---
name: gen-pr
description: "gh pr create コマンドを組み立てて提示する（実行はしない）。PR タイトルは直近のマージ済み PR のスタイルを参考にコミット差分から生成し、PR body（概要・課題・解決方法・不採用案）を /tmp/ に書き出す。アサイン自分・ドラフト PR 固定。"
when_to_use: "PR を作成したいとき、gh pr create コマンドを準備したいとき"
disable-model-invocation: true
allowed-tools: Bash(git log *) Bash(git diff *) Bash(git rev-parse *) Bash(gh repo view *) Bash(gh pr list *) Write
# context: fork は付けない — コマンド提示→ユーザー確認という対話フローが主目的のため
---

## コンテキスト収集

!`git rev-parse --abbrev-ref HEAD`
!`gh repo view --json defaultBranchRef --jq '.defaultBranchRef.name' 2>/dev/null || echo ""`
!`BASE=$(gh repo view --json defaultBranchRef --jq '.defaultBranchRef.name' 2>/dev/null); git log --oneline $(git merge-base HEAD "$BASE" 2>/dev/null || echo "")..HEAD 2>/dev/null`
!`BASE=$(gh repo view --json defaultBranchRef --jq '.defaultBranchRef.name' 2>/dev/null); git diff $(git merge-base HEAD "$BASE" 2>/dev/null || echo "")..HEAD 2>/dev/null`
!`gh pr list --state merged --limit 5 --json title --jq '.[].title'`

## 制約

- `gh pr create` は **絶対に実行しない**。コマンドを提示するだけ
- ベースブランチは `gh repo view` で取得したデフォルトブランチを使う。取得できない場合は「ベースブランチを特定できません」と伝えて終了する
- コミット差分がない場合は「ベースブランチとの差分がありません」と伝えて終了する

## 処理フロー

1. 現在のブランチ名を取得する
2. ベースブランチとのコミット差分・diff を取得する
3. 直近マージ済み PR のタイトル一覧からスタイルを把握する
4. タイトル候補を **3つ** 生成し、おすすめの1つを選んでその理由を1行で添える
5. PR body を生成し `/tmp/pr-body-<branch>.md` に Write で書き出す
6. `gh pr create` コマンドを提示する

## PR タイトルのルール

- 直近マージ済み PR のスタイル（言語・prefix・フォーマット）に合わせる
- 差分から変更の本質を端的に表す

## PR body のフォーマット

```markdown
## 概要

（変更内容を 2〜3 文で説明）

## 課題

（なぜこの変更が必要だったか）

## 解決方法

（どうアプローチしたか）

## 不採用にした手段

（あれば。なければこのセクションごと省略）
```

情報が不明・推測になる場合は書かない。わかっている事実だけを記載する。

## 出力ルール

- タイトル候補 3 つを提示する
- おすすめを明示して理由を1行添える
- body ファイルのパスを明示する
- 最後に以下の形式でコマンドを提示する（実行しない）

```
gh pr create \
  --assignee @me \
  --draft \
  --title "<選んだタイトル>" \
  --body-file /tmp/pr-body-<branch>.md
```
