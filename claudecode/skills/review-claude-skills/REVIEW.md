# REVIEW: review-claude-skills

> レビュー日時: 2026-05-07
> ファイル: claudecode/skills/review-claude-skills/SKILL.md

## 総評
`.claude/skills/<name>/SKILL.md` を8観点でレビューするスキルで、Web検索による公式ベストプラクティスの確認機能も持つ。`disable-model-invocation: true` が設定されており安全性は高い。ただし `context: fork` が欠如しており、大量の調査処理がメインコンテキストを汚染するリスクがある。

## ✅ 良い点
- `disable-model-invocation: true` で自動トリガーを防止している
- `argument-hint: "[skill-name]"` があり引数の使い方が明示されている
- 8観点が表形式で具体的に定義されており、機械的なチェックが可能
- Step 2 で公式ドキュメントを Web 検索して最新情報を確認する仕組みがある
- `.claude/SKILL_REVIEW.md` への書き出し機能で結果を永続化できる
- Step 1 でスキルが存在しない場合のフォールバックが書かれている
- `disable-model-invocation: true` の場合に description が context に load されない点の注意書きがある

## ⚠️ 改善提案（任意対応）
- **`context: fork` 欠如**: Web 検索・ファイル読み込み・評価・書き出しという独立処理群はメインコンテキストを汚染しやすい。`context: fork` を追加することを検討
- **`when_to_use` 欠如**: description に「新規 SKILL.md 作成や既存スキルの改善時に使う」が含まれているが、`when_to_use` として分離するとより明確になる
- **`.claude/rules/skill-design.md` 参照の確認**: 本文中に参照が書かれているが、そのファイルが実際に存在するか確認が必要（参照先が欠如していると実行時に混乱する）

## ❌ 問題点（要修正）

なし
