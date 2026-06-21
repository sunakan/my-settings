# REVIEW: review-claude-rules

> レビュー日時: 2026-06-13
> ファイル: /Users/user01/works/github.com/sunakan/my-settings/claudecode/skills/review-claude-rules/SKILL.md

## 総評

`.claude/rules/*.md` を6観点でレビューして `.claude/RULES_REVIEW.md` に書き出すスキルで、責務が明確。`disable-model-invocation: true` と `context: fork` が設定されており安全性・独立性が高い。`argument-hint`・`allowed-tools` が適切に揃い、フォールバックも明記されている。99行で全体的に高品質。

## ✅ 良い点

- `disable-model-invocation: true`（L5）で自動トリガーを防止している
- `argument-hint: "[rule-filename]"`（L7）があり、引数の使い方が明示されている
- `context: fork`（L8）が設定されており、チェック [1] の `context` 判定は (A)「ファイル書き込みで完結する」に該当（`.claude/RULES_REVIEW.md` への Write が主出力）。現在の設定が正しい
- frontmatter コメント（L9）に `agent` を省略した理由（書き込みありのため `general-purpose` がデフォルト）が明記されており保守性が高い
- `allowed-tools: Read Write Edit Bash(find *) Bash(ls *) Bash(date *)`（L6）と最小権限に絞られている（チェック [4] 過剰許可なし）
- Step 1 の Bash inline で引数あり/なしの分岐がワンライナーで書かれている（チェック [2] 動的コンテキスト）
- 6観点のレビュー基準（L17-L24）が表形式で具体的に定義されており機械的にチェックできる
- paths パターンの実マッチ確認（L62-L66）で `find` コマンド例が具体的に示されている
- 引数あり/なしの両モードに対応し、存在しないファイル名のフォールバック（L34-L40）が明記されている
- 93行で500行制限を大幅に下回り、supporting files への分割は不要

## ⚠️ 改善提案（任意対応）

- **`$ARGUMENTS` 直接展開の shell injection リスク**: Step 1 の Bash inline で `$ARGUMENTS` がクォートなしで `ls ".claude/rules/$ARGUMENTS"` に展開されている箇所がある。引数にシェルメタ文字（`;`, `|`, `` ` ``）が含まれる場合に予期しない動作になる可能性がある。ただし、このスキルは `disable-model-invocation: true` で手動限定起動かつユーザー自身が引数を入力するため、自己 injection リスクとして許容範囲ともいえる（`.claude/rules/skill-design.md` の方針に準拠）

## ❌ 問題点（要修正）

なし

## 修正後の frontmatter サンプル（変更がある場合のみ）

変更不要
