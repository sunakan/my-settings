# REVIEW: review-claude-rules

> レビュー日時: 2026-05-07
> ファイル: /Users/user01/.claude/skills/review-claude-rules/SKILL.md

## 総評
`.claude/rules/*.md` を6観点でレビューして `.claude/RULES_REVIEW.md` に書き出すスキルで、責務が明確。`disable-model-invocation: true` と `context: fork` が設定されており安全性・独立性が高い。`argument-hint`・`allowed-tools` が適切に揃っており、フォールバックも書かれている。93行で全体的に高品質。

## ✅ 良い点
- `disable-model-invocation: true`（L5）で自動トリガーを防止している。
- `argument-hint: "[rule-filename]"`（L7）があり、引数の使い方が明示されている。
- `context: fork`（L8）が設定されており、メインコンテキストを汚染しない。チェック [1] の `context` 判定は (A)「ファイル書き込みで完結する」に該当（`.claude/RULES_REVIEW.md` への Write が主出力）。
- `allowed-tools: Read Write Edit Bash(find *) Bash(ls *) Bash(date *)`（L6）と最小権限に絞られており、`Bash` 全体許可になっていない（チェック [4] 過剰許可なし）。
- Step 1 の対象ファイル特定で `` !`...` `` Bash inline を活用しており、引数あり/なしの分岐がワンライナーで書かれている（チェック [2] 動的コンテキスト）。
- 6観点のレビュー基準（L17-L24）が表形式で具体的に定義されており、機械的にチェックできる（チェック [2] 具体性）。
- paths パターンの実マッチ確認（L62-L66）で `find` コマンド例が具体的に示されている。
- 引数あり/なしの両モードに対応し、存在しないファイル名のフォールバック（L34-L40）が明記されている（チェック [2] フォールバック）。
- 93行で500行制限を大幅に下回り、supporting files への分割は不要。
- `when_to_use`（L4）が独立フィールドとして存在し、呼び出し判断の文脈が明確。

## ⚠️ 改善提案（任意対応）
- **`$ARGUMENTS` 直接展開の shell injection リスク**: L30 の `ls .claude/rules/$ARGUMENTS 2>/dev/null` で `$ARGUMENTS` を直接展開している。チェック [4] の shell injection 観点では、引数に空白やシェルメタ文字（`;`, `|`, `` ` ``）を含むと予期しない動作になる可能性がある。`ls ".claude/rules/$ARGUMENTS" 2>/dev/null` のようにダブルクォートで囲むか、`$ARGUMENTS` がシンプルなファイル名のみに限られる旨を本文で明示すると安全性が増す。
- **`agent` フィールドの明示**: `context: fork` を付けているが、Step 5 で Edit による rules ファイル修正があるため書き込みありのスキルである。レビュー基準では「書き込みを含むなら `agent` を省略（`general-purpose` がデフォルト）」であり現状は正しいが、意図をコメントで残すと保守性が上がる（軽微）。

## ❌ 問題点（要修正）
なし。

## 修正後の frontmatter サンプル（変更がある場合のみ）
（変更不要）
