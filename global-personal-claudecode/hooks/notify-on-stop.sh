#!/bin/bash
# Stop フック: Claude の応答完了時に macOS デスクトップ通知を送る
# async: true で呼ばれるため stop_hook_active チェック不要（無限ループしない）

INPUT=$(cat)
# cwd からプロジェクト名を取得（複数プロジェクト並走時に「どれが終わったか」を識別するため）
PROJECT=$(basename "$(echo "$INPUT" | jq -r '.cwd')")

osascript -e "display notification \"タスク完了\" with title \"Claude Code - ${PROJECT}\" sound name \"Glass\""
