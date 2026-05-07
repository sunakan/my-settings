#!/bin/bash
# Stop フック: Claude の応答完了時に macOS デスクトップ通知を送る
#
# 公式ドキュメント: https://code.claude.com/docs/en/hooks
#
# Why not set -e: 中断時の exit code が失敗コマンド任せになる。Stop hook は
# exit 2 で Claude を継続させる仕様のため、安全側に倒して set -e を使わず
# 末尾で必ず exit 0 する。
#   引用: "Stop | Yes | Prevents Claude from stopping, continues the conversation"
#         (Exit code 2 behavior per event 表より)
#
# Why stop_hook_active チェック: 公式が明示するループ防止フラグ。
#   引用: "The stop_hook_active field is true when Claude Code is already
#          continuing as a result of a stop hook. Check this value or process
#          the transcript to prevent Claude Code from running indefinitely."
#         (Stop input セクションより)

INPUT=$(cat)

if [ "$(printf '%s' "$INPUT" | jq -r '.stop_hook_active // false' 2>/dev/null)" = "true" ]; then
  exit 0
fi

PROJECT=$(printf '%s' "$INPUT" | jq -r '.cwd // ""' 2>/dev/null)
PROJECT=$(basename "${PROJECT:-unknown}")

if ! ERR=$(osascript -e "display notification \"タスク完了\" with title \"Claude Code - ${PROJECT}\" sound name \"Glass\"" 2>&1); then
  osascript -e "display alert \"Claude Code Stop hook error\" message \"${ERR}\"" >/dev/null 2>&1 || true
fi

exit 0
