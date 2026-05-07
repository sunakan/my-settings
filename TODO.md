# Claude Code 設定 TODO

## 検討中


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

### スキル: `next-todo`

> REVIEW: `claudecode/skills/next-todo/REVIEW.md`

⚠️ 改善提案 3件（❌ 問題点なし）:
- `context: fork` と対話フロー（Step 5 の「進めますか？」確認）の整合性確認（fork なら出力がメイン会話に戻らない可能性あり）
- `allowed-tools: Bash(cat *)` → `Read` で代替可能なため削除を検討
- `context: fork` を維持するなら `agent: Explore` の追加を検討（ただし Step 2 の Edit があるため省略も合理的）

---

### スキル: `review-claude-rules`

> REVIEW: `claudecode/skills/review-claude-rules/REVIEW.md`

⚠️ 改善提案 1件（❌ 問題点なし）:
- `when_to_use` 欠如（追加例: `.claude/rules/*.md を新規作成・編集したとき、rules ファイルの品質を一括確認したいとき`）

---

### スキル: `review-skills`

> REVIEW: `claudecode/skills/review-skills/REVIEW.md`

⚠️ 改善提案 3件（❌ 問題点なし）:
- 一括レビューモードのプロンプトテンプレートで `subagent_type: general-purpose` が未明示
- 単体モードのパス探索で `~/` 表記がシェル展開されない環境がある（絶対パスへの変更を検討）
- `context: fork` を付けているが `agent` フィールドが未明示（デフォルト `general-purpose` で正しいが、明示するとより意図が明確）

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
