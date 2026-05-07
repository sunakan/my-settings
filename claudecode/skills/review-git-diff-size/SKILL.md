---
name: review-git-diff-size
description: `/review-git-diff-size` で呼ばれた時にステージング済みの差分が1コミット分として適切な粒度か評価する。大きすぎる場合は分割案を提示する
allowed-tools: Bash(git diff *)
---

## コンテキスト

!`git diff --staged`

## タスク

- diff が空の場合は「ステージングされた変更がありません」と伝えて終了する
- 1コミット分として適切な粒度か評価する
- 改善点がある場合、ざっくりと何分割できそうか説明し、1つ目の分割内容を理由とともに詳しく示す
