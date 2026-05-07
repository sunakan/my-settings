# REVIEW: review-claude-rules

> レビュー日時: 2026-05-07
> ファイル: claudecode/skills/review-claude-rules/SKILL.md

## 総評
`.claude/rules/*.md` を6観点でレビューするスキルで、責務は明確。`disable-model-invocation: true` と `context: fork` が設定されており安全性・独立性は高い。`allowed-tools` も適切に絞り込まれており、全体的な品質は高い。`when_to_use` フィールドの欠如が唯一の軽微な改善余地。

## ✅ 良い点
- `disable-model-invocation: true` が適切に設定されており、自動トリガーを防止している
- `argument-hint: "[rule-filename]"` があり、引数の使い方が明示されている
- `context: fork` が設定されており、メインコンテキストを汚染しない（分類: A — ファイル書き込みで完結する処理群）
- `allowed-tools: Read Write Edit Bash(find *) Bash(ls *) Bash(date *)` と最小権限に絞られている
- Step 1 の対象ファイル特定で `` !`...` `` の動的コンテキストを活用している
- 6観点のレビュー基準が表形式で具体的に定義されており、チェックが機械的に行える
- paths パターンの実マッチ確認（`find` コマンド例）が具体的に示されている
- `.claude/RULES_REVIEW.md` への書き出し機能があり、レビュー結果を永続化できる
- 引数なし・引数あり両方のモードに対応しており、フォールバックも明記されている

## ⚠️ 改善提案（任意対応）
- **`when_to_use` 欠如**: rules ファイル編集後の使用タイミングが description に含まれているが、`when_to_use` として分離するとより明確になる → 追加例: `when_to_use: ".claude/rules/*.md を新規作成・編集したとき、rules ファイルの品質を一括確認したいとき"`

## ❌ 問題点（要修正）

なし
