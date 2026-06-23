#!/bin/bash

input=$(cat)

# ステータスラインJSONから取得
IFS=$'\t' read -r cwd model effort used_pct < <(
  jq -r '[
    (.workspace.current_dir // .cwd // ""),
    (.model.display_name // ""),
    (.effort.level // ""),
    (.context_window.used_percentage // "")
  ] | @tsv' <<< "$input"
)

short_cwd="${cwd/#$HOME/~}"

# Gitブランチ名
# GIT_OPTIONAL_LOCKS=0の理由:
# - gitの一部の読み取りコマンドは、読み取りなのについでにインデックスキャッシュを更新しようとして.git/index.lockを取る
# - ぶつかったりするので、ロックを取らないオプションがGIT_OPTIONAL_LOCKS=0
branch=""
if b=$(GIT_OPTIONAL_LOCKS=0 git -C "$cwd" symbolic-ref --short HEAD 2>/dev/null); then
  branch="$b"
elif b=$(GIT_OPTIONAL_LOCKS=0 git -C "$cwd" rev-parse --short HEAD 2>/dev/null); then
  branch="${b}(detached)"
fi

# api/oauth/usage キャッシュ取得
CACHE="$HOME/.cache/claude-usage.json"
CACHE_TTL=60  # 秒

cache_stale() {
  [ ! -f "$CACHE" ] && return 0
  local age=$(( $(date +%s) - $(stat -f %m "$CACHE" 2>/dev/null || stat -c %Y "$CACHE") ))
  [ "$age" -gt "$CACHE_TTL" ]
}

if cache_stale; then
  TOK=$(jq -r '.claudeAiOauth.accessToken // empty' \
    "$HOME/.claude/.credentials.json" 2>/dev/null)
  [ -z "$TOK" ] && TOK=$(security find-generic-password \
    -s "Claude Code-credentials" -w 2>/dev/null \
    | jq -r '.claudeAiOauth.accessToken // empty')

  if [ -n "$TOK" ]; then
    RESP=$(curl -sf --max-time 5 \
      "https://api.anthropic.com/api/oauth/usage" \
      -H "Authorization: Bearer $TOK" \
      -H "anthropic-beta: oauth-2025-04-20" \
      -H "User-Agent: claude-code/$(claude --version 2>/dev/null | awk '{print $NF}')" \
    )
    [ -n "$RESP" ] && { mkdir -p "$(dirname "$CACHE")"; echo "$RESP" > "$CACHE"; }
  fi
fi

fh_pct="" fh_resets="" sd_pct="" sd_resets=""
if [ -f "$CACHE" ]; then
  IFS=$'\t' read -r fh_pct fh_resets sd_pct sd_resets < <(
    jq -r '[
      (.five_hour.utilization // ""),
      (.five_hour.resets_at // ""),
      (.seven_day.utilization // ""),
      (.seven_day.resets_at // "")
    ] | @tsv' "$CACHE" 2>/dev/null
  )
fi

# ヘルパー関数
pct() {
  [ -z "$1" ] && { printf '-'; return; }
  local v="${1%.*}"
  local c
  if   [ "$v" -le 30 ]; then c='\033[32m'       # 緑
  elif [ "$v" -le 50 ]; then c='\033[38;5;148m' # 黄緑
  elif [ "$v" -le 60 ]; then c='\033[93m'       # 薄い黄色
  elif [ "$v" -le 70 ]; then c='\033[33m'       # 濃い黄色
  elif [ "$v" -le 80 ]; then c='\033[38;5;210m' # 薄いサーモン赤
  else                       c='\033[31m'       # 濃い赤
  fi
  printf "${c}%.1f%%\033[0m" "$1"
}

# resets_atから残り時間を計算（macOS用）
# 5h用：残り時間（Xh Xm）
remaining_hm() {
  [ -z "$1" ] && { printf ''; return; }
  local fixed=$(echo "$1" \
    | sed 's/\.[0-9]*//' \
    | sed 's/+\([0-9][0-9]\):\([0-9][0-9]\)$/+\1\2/')
  local epoch=$(date -j -f "%Y-%m-%dT%H:%M:%S%z" "$fixed" "+%s" 2>/dev/null)
  [ -z "$epoch" ] && { printf ''; return; }
  local diff=$(( epoch - $(date +%s) ))
  [ "$diff" -le 0 ] && { printf '(reset済)'; return; }
  local h=$(( diff / 3600 ))
  local m=$(( (diff % 3600) / 60 ))
  [ "$h" -gt 0 ] && printf '(残:%dh%02dm)' "$h" "$m" || printf '(%dm)' "$m"
}

# 7d用：リセット日時（M/D HH:mm）
remaining_date() {
  [ -z "$1" ] && { printf ''; return; }
  local fixed=$(echo "$1" \
    | sed 's/\.[0-9]*//' \
    | sed 's/+\([0-9][0-9]\):\([0-9][0-9]\)$/+\1\2/')
  local epoch=$(date -j -f "%Y-%m-%dT%H:%M:%S%z" "$fixed" "+%s" 2>/dev/null)
  [ -z "$epoch" ] && { printf ''; return; }
  printf '(%s)' "$(LC_TIME=ja_JP.UTF-8 date -r "$epoch" '+%-m/%-d(%a) %H:%M %Z')"
}

remaining() {
  [ -z "$1" ] && { printf ''; return; }
  # 小数秒を除去してからタイムゾーン変換
  local fixed=$(echo "$1" \
    | sed 's/\.[0-9]*//' \
    | sed 's/+\([0-9][0-9]\):\([0-9][0-9]\)$/+\1\2/')
  local epoch=$(date -j -f "%Y-%m-%dT%H:%M:%S%z" "$fixed" "+%s" 2>/dev/null)
  [ -z "$epoch" ] && { printf ''; return; }
  local diff=$(( epoch - $(date +%s) ))
  [ "$diff" -le 0 ] && { printf '(reset済)'; return; }
  local h=$(( diff / 3600 ))
  local m=$(( (diff % 3600) / 60 ))
  [ "$h" -gt 0 ] && printf '(%dh%02dm)' "$h" "$m" || printf '(%dm)' "$m"
}

# ── 出力 ─────────────────────────────────────────────────────────
printf '%s\n%s\n%s\n' \
  "📂 ${short_cwd}${branch:+ │ 🌿 $branch}" \
  "context: $(pct "$used_pct")${model:+ │ $model${effort:+ ($effort)}}" \
  "5h: $(pct "$fh_pct") $(remaining_hm "$fh_resets") │ 7d: $(pct "$sd_pct") $(remaining_date "$sd_resets")"

