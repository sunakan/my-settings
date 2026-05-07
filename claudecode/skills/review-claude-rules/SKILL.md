---
name: review-claude-rules
description: `.claude/rules/*.md` を 6 観点（paths フロントマター存在・paths パターンの妥当性・行数・CLAUDE.md との重複・自明な内容の排除・path-scoped に値する内容か）でレビューし、改善提案を出す。引数でファイル名を指定すれば単体、省略時は全 rules を対象。rules ファイルの新規作成や編集後に使う
when_to_use: ".claude/rules/*.md を新規作成・編集したとき、rules ファイルの品質を一括確認したいとき"
disable-model-invocation: true
allowed-tools: Read Write Edit Bash(find *) Bash(ls *) Bash(date *)
argument-hint: "[rule-filename]"
context: fork
# agent は省略 — 書き込みありのため general-purpose がデフォルト = 正しい
---

## 目的

`.claude/rules/*.md` をベスプラ準拠の観点でレビューし、改善提案を出す。

## レビュー観点（6 項目）

| # | 観点 | 判定基準 |
|---|---|---|
| 1 | `paths` フロントマターが存在するか | なし = 常時 load。意図的か確認（CLAUDE.md に書くべき内容でないか） |
| 2 | `paths` パターンが実ファイルにマッチするか | glob が正しいか `find` で確認。typo や誤パターンで未マッチは無効 |
| 3 | 行数が適切か | 目安 50 行以下。超えたら削減 or `docs/` への分離を検討 |
| 4 | CLAUDE.md との重複がないか | CLAUDE.md（常時 load）に既に書いてある内容の繰り返しを排除 |
| 5 | Claude が自明に分かることを書いていないか | 言語構文・典型フレームワーク慣習・一般的ベストプラクティスは不要 |
| 6 | path-scoped に値する内容か | 「対象ファイル編集時にだけ必要な情報」か。そうでなければ CLAUDE.md へ移動 |

## Step 1: 対象ファイルを特定

```!
[ -n "$ARGUMENTS" ] \
  && ls ".claude/rules/$ARGUMENTS" 2>/dev/null \
  || ls .claude/rules/*.md
```

存在しないファイル名なら以下を出力して終了：

```
ルール '<name>' が見つかりません。
.claude/rules/ 配下にあるファイル一覧:
<対象一覧>
```

## Step 2: CLAUDE.md を Read して重複チェックの基準を把握

`CLAUDE.md` を Read し、常時 load される内容（CRITICAL ルール・Overview・作業対象等）を把握する。

## Step 3: 各 rules ファイルを Read して 6 観点で評価

各ファイルごとに以下を出す：

```
### ルール: <filename>
- 行数: N 行
- paths: <値 or "なし（常時 load）">
- 評価:
  | 観点 | 判定 | 詳細 |
  |---|---|---|
  | 1. paths 存在 | ✅/⚠️/❌ | ... |
  | ...           | ...    | ... |
```

paths パターンの実マッチ確認（観点 2）:

```
# 例: paths が "web*/home/isucon/webapp/**" の場合
find . -path "./web*/home/isucon/webapp" -maxdepth 5 -type d 2>/dev/null | head -3
```

## Step 4: 改善提案を表形式で提示

```
| ファイル | 観点 | 現状 | 改善案 |
|---|---|---|---|
| honban-manual.md | 行数 | 18 行 | 問題なし |
| ... | ... | ... | ... |
```

## Step 4.5: 評価結果を `.claude/RULES_REVIEW.md` に書き出す

Write ツールで `.claude/RULES_REVIEW.md` を作成または上書きする（全置換でよい。対応履歴は git log で追える）。

書き出す内容（順番に記載）:
1. 最終更新日時（`date '+%Y-%m-%d %H:%M:%S'` で取得。1 日に複数回回ることが多いので時刻まで記録）
2. 評価観点テーブル（6 項目）
3. 全ルール評価サマリ（Step 3 の ✅/⚠️/❌ + 行数）
4. 未対応の改善提案（Step 4 の表。なければ「なし」と記載）

## Step 5: ユーザー合意後に修正

合意を得たら Edit で各 rules ファイルを修正。1ファイルずつ確認しながら進める。

修正完了後、`.claude/RULES_REVIEW.md` を更新する：
- 全ルール評価サマリの該当ファイルを ✅ に更新
- 未対応の改善提案テーブルから該当行を削除
