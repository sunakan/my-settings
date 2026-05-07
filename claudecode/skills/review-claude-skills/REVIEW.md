# REVIEW: review-claude-skills

> レビュー日時: 2026-05-07
> ファイル: claudecode/skills/review-claude-skills/SKILL.md

## 総評
`.claude/skills/<name>/SKILL.md` を8観点でレビューするスキルで、Web検索による公式ベストプラクティスの確認機能も持つ。`disable-model-invocation: true` が設定されており安全性は高い。ただし `allowed-tools: Bash` が過剰許可になっており、`context: fork` も欠如しているため改善が必要。

## ✅ 良い点
- `disable-model-invocation: true` で自動トリガーを防止している
- `argument-hint: "[skill-name]"` があり引数の使い方が明示されている
- 8観点が表形式で具体的に定義されており、機械的なチェックが可能
- Step 2 で公式ドキュメントを Web 検索して最新情報を確認する仕組みがある
- `.claude/SKILL_REVIEW.md` への書き出し機能で結果を永続化できる
- Step 1 でスキルが存在しない場合のフォールバックが書かれている
- `disable-model-invocation: true` の場合に description が context に load されない点の注意書きがある

## ⚠️ 改善提案（任意対応）
- **`context: fork` 欠如**: Web 検索・ファイル読み込み・評価・書き出しという独立処理群（分類: A — ファイル書き込みで完結）はメインコンテキストを汚染しやすい。`context: fork` を追加することを検討
- **`when_to_use` 欠如**: description に「新規 SKILL.md 作成や既存スキルの改善時に使う」が含まれているが、`when_to_use` として分離するとより明確になる

## ❌ 問題点（要修正）
- **`allowed-tools: Bash` 過剰許可**: 現状 `Bash` 全体を許可しており、使用するコマンドは `ls` のみの想定に対して権限が広すぎる。`Bash(ls *)` に絞るべき（WebSearch・WebFetch は独立フィールドで指定済みのため Bash 全体許可は不要）

## 修正後の frontmatter サンプル（変更がある場合のみ）
```yaml
---
name: review-claude-skills
description: 既存の SKILL.md（`.claude/skills/<name>/SKILL.md`）を 8 観点（one skill one job・description は load-bearing・冒頭に最重要事項・500 行以下・CLAUDE.md との重複・無駄な Bash inline・disable-model-invocation の妥当性・三人称表記）で機械的にレビューし、改善提案を出す。引数でスキル名を指定すれば単体、省略時は全スキルを対象。新規 SKILL.md 作成や既存スキルの改善時に使う
disable-model-invocation: true
allowed-tools: Read Write Edit Bash(ls *) WebSearch WebFetch
argument-hint: "[skill-name]"
context: fork
---
```
