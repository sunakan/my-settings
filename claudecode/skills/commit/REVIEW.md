# REVIEW: commit

> レビュー日時: 2026-05-07
> ファイル: claudecode/skills/commit/SKILL.md

## 総評
git コミットメッセージを3候補提示してからコミットする、責務が明確なスキル。`disable-model-invocation: true` と `allowed-tools` の絞り込みが適切で、副作用操作のセキュリティ面は良好。`context: fork` と `when_to_use` の欠如が改善余地として残る。

## ✅ 良い点
- `disable-model-invocation: true` が設定されており、自動トリガーによる意図しないコミットを防止している
- `allowed-tools: Bash(git diff *) Bash(git log *) Bash(git commit *)` と最小権限に絞られている
- `` !`git diff --staged` `` と `` !`git log --oneline -10` `` で動的コンテキストを取得しており、実行時の最新情報を使える
- 「採用しなかった選択肢」をコミット本文に含める指針（Why not）が書かれており、コーディングスタイルと整合している
- ステージングなしの場合のフォールバック（「ステージングされた変更がありません」）が明記されている

## ⚠️ 改善提案（任意対応）
- **`when_to_use` 欠如**: `description` だけで呼び出し判断は可能だが、`when_to_use` を追加すると「ステージング済みの変更をコミットしたいとき」の文脈が明確になる → 追加例: `when_to_use: "ステージング済みの変更をコミットするとき（git add はユーザーが済ませた前提）"`
- **`context: fork` 欠如**: このスキルはメインコンテキストを汚染する中間処理（差分分析・候補提示）が多い。`context: fork` を付けると独立して処理が完結する → ただしコミット操作後にメイン会話に結果を戻す必要があるため、意図的に省いている可能性もある

## ❌ 問題点（要修正）

なし
