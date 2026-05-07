# REVIEW: review-claude-skills

> レビュー日時: 2026-05-07
> ファイル: /Users/user01/works/github.com/sunakan/my-settings/claudecode/skills/review-claude-skills/SKILL.md

## 総評
`.claude/skills/<name>/SKILL.md` を8観点でレビューするスキルで、Web検索による公式ベストプラクティスの最新確認機能も持つ。`disable-model-invocation: true`・`context: fork`・最小限 `allowed-tools` が揃っており安全性が高い。同リポジトリの `review-skills` との責務の住み分けが暗黙的である点と、shell injectionリスクが軽微な改善余地。

## ✅ 良い点
- `disable-model-invocation: true`（L5）で自動トリガーを防止している。
- `argument-hint: "[skill-name]"`（L7）があり引数の使い方が明示されている。
- `context: fork`（L8）が設定されており（チェック [1] の `context` 観点で(A)に該当 — `.claude/SKILL_REVIEW.md` への書き出しが主目的）、メインコンテキストを汚染しない。
- frontmatter コメント（L9）に `agent` を省略した理由（書き込みありのため `general-purpose` がデフォルト）が明記されており保守性が高い。
- `allowed-tools: Read Write Edit Bash(ls *) WebSearch WebFetch`（L6）は最小権限に絞られている（チェック [4] 過剰許可なし）。
- 8観点（L17–L26）が表形式で具体的に定義されており機械的チェックが可能。
- Step 2 で公式ドキュメントを Web 検索し、最新の推奨行数・description 文字数上限・truncation 仕様を確認する仕組みがある。
- 存在しないスキル名のフォールバック（L40–L44）が明記されている（チェック [2] フォールバック）。
- 注意事項（L98–L101）に「`disable-model-invocation: true` の場合 description が context に load されない」などハマりやすい仕様が明示されている。
- description（L3）の冒頭でこのスキルと `review-skills` の使い分けが一文で案内されている。

## ⚠️ 改善提案（任意対応）
- **`$ARGUMENTS` 直接展開のshell injectionリスク**: L35 の Bash inline で `$ARGUMENTS` がクォートなしで展開されている（`ls ".claude/skills/$ARGUMENTS/SKILL.md"`）。引数にシェルメタ文字を含む値が渡された場合に予期しない動作になる可能性がある。`ls ".claude/skills/$ARGUMENTS/SKILL.md" 2>/dev/null` のようにダブルクォートで囲むことを推奨（チェック [4] shell injection）。
- **`review-skills` との責務住み分けの明文化**: description（L3）末尾に「サブエージェント並列・REVIEW.md 書き出しが必要なら review-skills を使う」と明記されており、住み分けは説明されているが「こちら（review-claude-skills）が選ばれるべき具体的なシナリオ」の言語化が薄い。例えば「単体の素早い評価には review-claude-skills、一括REVIEW.md書き出しには review-skills」のように補足するとより明確（軽微）。

## ❌ 問題点（要修正）
なし。

## 修正後の frontmatter サンプル（変更がある場合のみ）
（変更不要）
