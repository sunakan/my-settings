---
name: review-global-skills
description: "claudecode/skills/ 配下の全スキルをサブエージェントで並列レビューし、各スキルの隣に REVIEW.md を書き出す。全スキルのレビュー完了後に会話上でサマリを表示する。"
when_to_use: "複数スキルをまとめてレビューしたいとき、claudecode/skills/ 全体の品質を一括確認したいとき。"
allowed-tools: Read Bash(ls *) Bash(find claudecode/skills/*) Agent Write
context: fork
# サブ Agent プロンプトは外部参照（review-skills/SKILL.md）— 単一ソース維持のため inline 化しない
---

## 制約

**git 操作は一切行わないこと**（commit・add・push・status・diff 等すべて禁止）。

## Step 1: スキル一覧の取得

`claudecode/skills/` 配下のディレクトリを `ls` で取得する。各ディレクトリに `SKILL.md` が存在するものだけをレビュー対象とする（`find claudecode/skills/*/SKILL.md` で確認）。

対象スキルが 0 件の場合は「レビュー対象のスキルが見つかりませんでした」と伝えて終了する。

## Step 2: 並列レビュー

スキルごとに `general-purpose` サブ Agent を **1 つのメッセージ内に全て並べて**起動する。

各サブ Agent へのプロンプトテンプレート（`<name>` を実際のスキル名に置換する）:

---

あなたは Claude Code スキルのレビュアーです。

**タスク**: `claudecode/skills/<name>/SKILL.md` をレビューし、結果を `claudecode/skills/<name>/REVIEW.md` に書き出してください。

**レビュー基準**: `claudecode/skills/review-skills/SKILL.md` を Read で読み込み、「レビュー手順」セクション（チェック [1]〜[4]）に従ってレビューを実施してください。ファイルが見つからない場合は「完了: <name> (スキップ: review-skills/SKILL.md が見つかりません)」と返してください。

**出力フォーマット**: `claudecode/skills/review-skills/SKILL.md` の「書き込むフォーマット」セクションに従い、`claudecode/skills/<name>/REVIEW.md` に書き出す（既存ファイルは上書き）。

完了したら「完了: <name>」とだけ返してください。

---

## Step 3: サマリの出力

全サブ Agent が完了したら、各 `claudecode/skills/<name>/REVIEW.md` を Read して、会話上に以下の形式でサマリを出力する:

```markdown
## レビュー完了サマリ

| スキル名 | 総評（一行） | ❌ 問題点 | ⚠️ 改善提案 |
|---------|------------|---------|-----------|
| <name>  | ...        | N件      | N件        |
```

サマリ出力後、以下の順で確認する:

1. ❌ 問題点があるスキルについて「SKILL.md を修正しますか？」とユーザーに確認する。
2. ⚠️ 改善提案があるスキルについて「⚠️ 改善提案を TODO.md の「検討中」セクションに追記しますか？」とユーザーに確認する。承認された場合は `./TODO.md` の「検討中」セクション末尾に以下のフォーマットで追記する（❌ 修正済みのスキルはスキップ。「検討中」セクションが存在しない場合はファイル末尾に `## 検討中` を追加してから追記する）:

```markdown
### スキル: `<name>`

> REVIEW: `claudecode/skills/<name>/REVIEW.md`

⚠️ 改善提案 N件（❌ 問題点なし）:
- <改善提案1>
- <改善提案2>

---
```
