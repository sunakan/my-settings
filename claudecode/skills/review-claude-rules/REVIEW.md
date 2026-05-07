# REVIEW: review-claude-rules

> レビュー日時: 2026-05-07
> ファイル: /Users/user01/.claude/skills/review-claude-rules/SKILL.md

## 総評
`.claude/rules/*.md` を6観点でレビューするスキルで、責務が明確。`disable-model-invocation: true` と `context: fork` が設定されており安全性・独立性が高い。`when_to_use`・`argument-hint`・`allowed-tools` が適切に揃っており、フォールバックも書かれている。93行と適度なサイズで、全体的に高品質。

## ✅ 良い点
- `disable-model-invocation: true`（L5）で自動トリガーを防止している。
- `argument-hint: "[rule-filename]"`（L7）があり、引数の使い方が明示されている。
- `context: fork`（L8）が設定されており、メインコンテキストを汚染しない。チェック [1] の `context` 観点で(A)に該当（`.claude/RULES_REVIEW.md` への書き出しが主目的の処理が含まれる）。
- `when_to_use`（L4）が独立フィールドとして存在し、呼び出し判断の文脈が明確。
- `allowed-tools: Read Write Edit Bash(find *) Bash(ls *) Bash(date *)`（L6）と最小権限に絞られている（チェック [4] 過剰許可なし）。
- Step 1 の対象ファイル特定で `` !`...` `` Bash inline を活用しており、引数あり/なしの分岐がワンライナーで書かれている（チェック [2] 動的コンテキスト）。
- 6観点のレビュー基準（L17–L24）が表形式で具体的に定義されており、機械的にチェックできる（チェック [2] 具体性）。
- paths パターンの実マッチ確認（L62–L66）で `find` の例が具体的に示されている。
- `.claude/RULES_REVIEW.md` への書き出し機能（Step 4.5）でレビュー結果を永続化できる。
- 引数なし・引数ありの両モードに対応し、存在しないファイル名のフォールバック（L34–L40）が明記されている（チェック [2] フォールバック）。
- 命令形で記述されている（「〜を確認する」「〜を Read する」）（チェック [2] 文体）。

## ⚠️ 改善提案（任意対応）
- **Step 1 の Bash inline での `$ARGUMENTS` 直接展開**: L29 の `[ -n "$ARGUMENTS" ] && ls .claude/rules/$ARGUMENTS 2>/dev/null || ls .claude/rules/*.md` で `$ARGUMENTS` を直接展開している。チェック [4] の shell injection 観点では引用符で囲んでも `ls` 引数として展開されるためリスクは小さいが、引数に空白やシェルメタ文字（`;`, `|`, `` ` ``）を含むケースで予期せず動作する可能性がある。`ls .claude/rules/"$ARGUMENTS" 2>/dev/null` のように厳密にクオートする、または `$ARGUMENTS` をシンプルなファイル名のみに制限する旨を本文に明記すると安全性が増す。
- **`agent` フィールドの明示**: `context: fork` を付けているが、Step 5 で Edit による rules ファイル修正があるため `general-purpose`（デフォルト）が正しい。`agent: general-purpose` を明示するか、書き込みありなのでデフォルトのままで OK の旨をコメントで残すと意図が伝わる（軽微）。

## ❌ 問題点（要修正）
なし。

## 修正後の frontmatter サンプル（変更がある場合のみ）
（変更不要）
