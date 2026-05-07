# REVIEW: review-claude-rules

> レビュー日時: 2026-05-07
> ファイル: /Users/user01/works/github.com/sunakan/my-settings/claudecode/skills/review-claude-rules/SKILL.md

## 総評
`.claude/rules/*.md` を6観点でレビューするスキルで、責務は明確。`disable-model-invocation: true` が設定されており安全性は高い。ただし `allowed-tools: Bash` が過剰許可になっており、`context: fork` も欠如しているため改善が必要。

## ✅ 良い点
- `disable-model-invocation: true` が適切に設定されており、自動トリガーを防止している
- `argument-hint: "[rule-filename]"` があり、引数の使い方が明示されている
- Step 1 の対象ファイル特定で `` !`...` `` の動的コンテキストを活用している
- 6観点のレビュー基準が表形式で具体的に定義されており、チェックが機械的に行える
- paths パターンの実マッチ確認（`find` コマンド例）が具体的に示されている
- `.claude/RULES_REVIEW.md` への書き出し機能があり、レビュー結果を永続化できる

## ⚠️ 改善提案（任意対応）
- **`context: fork` 欠如**: このスキルはルールファイル調査・評価・書き出しまで一連の独立した処理。`context: fork` を付けることでメインコンテキストの汚染を防げる
- **Write の `allowed-tools` 欠如**: `.claude/RULES_REVIEW.md` への書き込みに Write ツールを使うが、`allowed-tools` に `Write` が記載されていない。繰り返し確認が出る可能性がある
- **`when_to_use` 欠如**: rules ファイル編集後の使用タイミングが description に含まれているが、`when_to_use` として分離するとより明確になる

## ❌ 問題点（要修正）
- **`allowed-tools: Bash` 過剰許可**: 現状 `Bash` 全体を許可しており、`find`・`ls`・`date` コマンドのみ使う想定に対して権限が広すぎる。`Bash(find *)` `Bash(ls *)` `Bash(date *)` に絞るべき

## 修正後の frontmatter サンプル（変更がある場合のみ）
```yaml
---
name: review-claude-rules
description: `.claude/rules/*.md` を 6 観点（paths フロントマター存在・paths パターンの妥当性・行数・CLAUDE.md との重複・自明な内容の排除・path-scoped に値する内容か）でレビューし、改善提案を出す。引数でファイル名を指定すれば単体、省略時は全 rules を対象。rules ファイルの新規作成や編集後に使う
disable-model-invocation: true
allowed-tools: Read Write Bash(find *) Bash(ls *) Bash(date *) Edit
argument-hint: "[rule-filename]"
context: fork
---
```
