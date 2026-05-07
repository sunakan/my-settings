# Claude Code 設定 TODO

## 検討中


### スキル: `review-claude-skills`

> REVIEW: `claudecode/skills/review-claude-skills/REVIEW.md`

⚠️ 改善提案 3件（❌ 問題点なし）:
- `context: fork` 欠如（Web 検索・ファイル読み込み・評価・書き出しがメインコンテキストを汚染）
- `when_to_use` 欠如
- 参照先 `.claude/rules/skill-design.md` が実在するか確認が必要

---

### スキル: `commit`

> REVIEW: `claudecode/skills/commit/REVIEW.md`

⚠️ 改善提案 2件（❌ 問題点なし）:
- `when_to_use` 欠如
- `context: fork` 欠如（ただしコミット後の結果をメイン会話に戻す必要があるため意図的な可能性あり）

---

### スキル: `review-git-diff-size`

> REVIEW: `claudecode/skills/review-git-diff-size/REVIEW.md`

⚠️ 改善提案 2件（❌ 問題点なし）:
- `when_to_use` 欠如
- `context: fork` 検討（評価結果をユーザーに見せるのが主目的のため意図的な可能性あり）

---

### スキル: `update-claude-settings`

> REVIEW: `claudecode/skills/update-claude-settings/REVIEW.md`

⚠️ 改善提案 2件（❌ 問題点なし）:
- `when_to_use` 欠如
- `allowed-tools` の `Edit` が実際に使われているか確認（Write で代替可能なら削除）

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
