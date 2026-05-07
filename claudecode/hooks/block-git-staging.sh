#!/usr/bin/env bash
# =============================================================================
# PreToolUse hook: git のステージング操作をブロックする
#
# 対象ツール: Bash
# 用途: deny リストは先頭マッチのみのため、複合コマンド（&& や ; で連結）内に
#       埋め込まれた git add 等を検出するために使用する
#
# ブロック対象パターン:
#   - git add
#   - git stage
#   - git commit -a / --all（自動ステージング付きコミット）
#   - git -C（別ディレクトリ指定での迂回）
# =============================================================================
set -euo pipefail

cmd=$(cat | jq -r '.tool_input.command // ""')

# git add/stage/commit -a/--all/git -C がコマンド文字列内に含まれるかチェック
# deny リストは先頭マッチのみ担保するため、複合コマンド内の出現も拾う
GIT_STAGING_PATTERN='git[[:space:]]+(add|stage)|git[[:space:]]+-C[[:space:]]|git[[:space:]]+commit[[:space:]]+[^"'"'"']*(-a[[:space:]]|-a$|--all)'

if echo "$cmd" | grep -qE "$GIT_STAGING_PATTERN"; then
  echo '{"decision": "block", "reason": "git staging operation is forbidden by AI. (git add / git stage / git commit -a / git -C)"}'
  exit 0
fi

echo '{"decision": "approve"}'
exit 0
