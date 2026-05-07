#!/usr/bin/env bash
# =============================================================================
# PreToolUse hook: センシティブファイルへのアクセスをブロックする
#
# 対象ツール: Bash
# 用途: Claude Code が Bash コマンドを実行する前に検査し、
#       センシティブなファイルを含むコマンドをブロックする
#
# ブロック対象パターン:
#   - 環境変数ファイル (.env 系)
#   - 秘密鍵・証明書 (id_rsa, id_ed25519, .pem, .key)
#   - Rails マスターキー (master.key)
#   - AWS 設定 (.aws)
#   - SSH 設定 (.ssh)
#   - その他クレデンシャル系 (.secret, .credential)
# =============================================================================
set -euo pipefail

# Claude Code が hook を呼ぶ時に stdin へ流し込む JSON から
# .tool_input.command の値を取り出す
# 例: {"tool_name": "Bash", "tool_input": {"command": "cat .env"}}
# // "" は値が null や存在しない場合に空文字を返すデフォルト値
cmd=$(cat | jq -r '.tool_input.command // ""')

#SENSITIVE_PATTERN='(\.env|\.secret|\.credential|id_rsa|id_ed25519|\.pem|\.key|master\.key|\.aws|\.ssh)'
SENSITIVE_PATTERN='(\.secret|\.credential|id_rsa|id_ed25519|\.pem|\.key|master\.key|\.aws)'

if echo "$cmd" | grep -qE "$SENSITIVE_PATTERN"; then
  echo '{"decision": "block", "reason": "sensitive file access is forbidden.(もし見直す場合はhooks/block-sensitive-files.shを見直してください)"}'
  exit 0
fi

echo '{"decision": "approve"}'
exit 0
