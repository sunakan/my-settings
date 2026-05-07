---
name: review-git-diff-size
description: `/review-git-diff-size` で呼ばれた時にステージング済みの差分が1コミット分として適切な粒度か評価する。大きすぎる場合は分割案を提示する
when_to_use: "コミット前に差分が1コミット分として適切か確認したいとき、差分が大きすぎて分割すべきか迷っているとき"
disable-model-invocation: true
allowed-tools: Bash(git diff *)
# context: fork は付けない — 評価結果をユーザーに会話で提示することが主目的のため（ファイル出力がメインになったら検討）
---

## コンテキスト

!`git diff --staged`

## タスク

- diff が空の場合は「ステージングされた変更がありません」と伝えて終了する
- 1コミット分として適切な粒度か評価する
- 改善点がある場合、ざっくりと何分割できそうか説明し、1つ目の分割内容を理由とともに詳しく示す
