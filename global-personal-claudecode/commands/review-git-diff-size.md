---
allowed-tools: Bash(git diff:*)
description: staging領域のgit差分の大きさが、1コミット分として適切な粒度か評価する
---

## 言語

- 日本語

## コンテキスト

- diff: !`git diff --staged`

## タスク

- diffが空の場合は、コミットメッセージ候補は出さない
- gitプロジェクトの1commitのサイズか評価して欲しい
- 改善点がある場合、ざっくりと何分割できそうか説明して、分割した時の1つ目を詳しく理由も添えて教えて
