# Claude Code 設定 TODO

## 検討中

### スキル: `update-claude-settings`（実機確認のみ）

> REVIEW: `claudecode/skills/update-claude-settings/REVIEW.md`

⚠️ 改善提案 1件（❌ 問題点なし）:
- **`Task` の pre-approve 有効性**: `allowed-tools` の `Task` と `Bash(ls /Users/user01/.claude/*)` が実際に pre-approve として効くか実機確認が必要。許可プロンプトが繰り返し出るようなら動作確認の上でツール名を調整（チルダ→絶対パスは対応済み）。

---

## やらない

### `keybindings.json` の git 管理

キーマッピングをする予定がないため。

---

### `PostToolUse: Write/Edit` フック — ファイル保存後に自動フォーマット

ISUCON や `.claude/settings.json` など、勝手にフォーマットされると困るファイルがあるため。

---

### `UserPromptSubmit` フック — プロンプト内に認証情報が含まれていたらブロック

毎回チェックされる煩わしさ・パフォーマンスの割に防御できるものがかなり限定的（完璧な正規表現が存在しない）であるため。

---

### スクリプト実行・プロンプトインジェクション経由のセンシティブファイル漏洩対策

効果が限定的で実装コストが高いため。
