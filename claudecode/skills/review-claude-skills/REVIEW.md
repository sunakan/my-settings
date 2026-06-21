# REVIEW: review-claude-skills

> レビュー日時: 2026-06-13
> ファイル: /Users/user01/works/github.com/sunakan/my-settings/claudecode/skills/review-claude-skills/SKILL.md

## 総評

`.claude/skills/<name>/SKILL.md` を8観点でレビューするスキルで、Web 検索による公式ベストプラクティスの最新確認機能も持つ。`disable-model-invocation: true`・`context: fork`・最小限 `allowed-tools` が揃っており安全性が高い。`review-skills` との責務の住み分けが description 末尾に明記されており、全体的に高品質。

## ✅ 良い点

- `disable-model-invocation: true`（L5）で自動トリガーを防止している
- `argument-hint: "[skill-name]"`（L7）があり引数の使い方が明示されている
- `context: fork`（L8）が設定されており、チェック [1] の `context` 観点で (A) に該当（`.claude/SKILL_REVIEW.md` への書き出しが主目的）。メインコンテキストを汚染しない
- frontmatter コメント（L9, L10）に `agent` 省略理由と `$ARGUMENTS` の shell injection 対策省略方針が明記されており保守性が高い
- `allowed-tools: Read Write Edit Bash(ls *) WebSearch WebFetch`（L6）は最小権限に絞られている（チェック [4] 過剰許可なし）
- 8観点（L17-L26）が表形式で具体的に定義されており機械的チェックが可能
- Step 2 で公式ドキュメントを Web 検索し、最新の推奨行数・description 文字数上限・truncation 仕様を確認する仕組みがある
- 存在しないスキル名のフォールバック（L40-L44）が明記されている
- description（L3）の冒頭でこのスキルと `review-skills` の使い分けが案内されている
- 注意事項（L98-L101）に「`disable-model-invocation: true` の場合 description が context にロードされない」などハマりやすい仕様が明示されている

## ⚠️ 改善提案（任意対応）

- **`review-skills` との責務住み分けのより明確な案内**: description 末尾の「単体スキルの素早い評価はこちら、全スキル一括 REVIEW.md 書き出しが必要なら review-skills を使う」という記載で概ね明確。さらに「REVIEW.md は書き出さず、会話上にのみ評価を返す」という差異を一文添えるとより判断しやすくなる（軽微）

## ❌ 問題点（要修正）

なし

## 修正後の frontmatter サンプル（変更がある場合のみ）

変更不要
