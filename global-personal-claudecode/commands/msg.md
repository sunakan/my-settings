---
allowed-tools: Bash(git diff:*), Bash(git log:*)
description: コミットメッセージの候補を5つ出す
---

## 言語

- 日本語

## コンテキスト

- git log: !`git log`
- diff: !`git diff --staged`

## タスク

- diffが空の場合は、コミットメッセージ候補は出さない
- コミットメッセージの候補を5つ出す
- 候補のうち、おすすめのコミットメッセージを理由を添えて教えて
    - 理由は5~10行以内にして
