---
name: review-claude-skills
description: 既存の SKILL.md（`.claude/skills/<name>/SKILL.md`）を 8 観点（one skill one job・description は load-bearing・冒頭に最重要事項・500 行以下・CLAUDE.md との重複・無駄な Bash inline・disable-model-invocation の妥当性・三人称表記）で機械的にレビューし、改善提案を出す。引数でスキル名を指定すれば単体、省略時は全スキルを対象。新規 SKILL.md 作成や既存スキルの改善時に使う
disable-model-invocation: true
allowed-tools: Read Write Edit Bash(ls *) WebSearch WebFetch
argument-hint: "[skill-name]"
context: fork
when_to_use: "新規 SKILL.md を作成したとき、既存スキルを改善したとき、スキルの品質を確認したいとき"
---

## 目的

`.claude/skills/<name>/SKILL.md` をベスプラ準拠の観点でレビューし、改善提案を出す。

## レビュー観点（8 項目）

| # | 観点 | 判定基準 |
|---|---|---|
| 1 | description は load-bearing か | 1,024 字以内（`when_to_use` と合算で 1,536 字）・key use case 冒頭・具体的 trigger（「〜の時」「〜で呼ばれた時」）含む |
| 2 | one skill, one job か | 責務が単一。複数の job を含むなら分割を提案 |
| 3 | 冒頭に最重要事項があるか | SKILL.md truncation 対策（最初の数十行で最重要指示が伝わる） |
| 4 | 500 行以下か | 公式推奨。超えたら supporting files への分離を提案 |
| 5 | CLAUDE.md と重複していないか | CRITICAL ルール・運用方針等の繰り返しを排除 |
| 6 | 無駄な Bash inline がないか | `echo "(... を実行)"` のようなダミーコマンドは削除 |
| 7 | `disable-model-invocation` の設定は妥当か | 自動 trigger 不要・副作用ある操作・手動起動限定なら `true`（`true` だと description が context に load されない点に注意） |
| 8 | 三人称で書かれているか | description / 本文で「I can」「私が」を避ける（システムプロンプト注入対策、公式必須） |

詳細は `.claude/rules/skill-design.md`（SKILL.md 編集時に自動 load）。

## Step 1: 対象スキルを特定

引数 `$ARGUMENTS`（スキル名）が指定されていれば単体、省略時は全スキル。

```!
[ -n "$ARGUMENTS" ] && ls .claude/skills/$ARGUMENTS/SKILL.md 2>/dev/null || ls .claude/skills/*/SKILL.md
```

存在しないスキル名なら以下を出力して終了：

```
スキル '<name>' が見つかりません。
.claude/skills/ 配下にあるスキル一覧:
<対象一覧>
```

## Step 2: 公式ベスプラを web 検索で再確認（必要時）

`/review-claude-skills` 初回実行時、または最終確認から時間が経っている場合、以下を web 検索：

- 公式: https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices
- 公式: https://code.claude.com/docs/en/skills

最新の推奨行数・description 文字数上限・truncation 仕様を確認。

## Step 3: 各 SKILL.md を Read して 8 観点で評価

各スキルごとに以下を出す：

```
### スキル: <name>
- 行数: N 行
- description 文字数: M 字
- 評価:
  | 観点 | 判定 | 詳細 |
  |---|---|---|
  | 1. description load-bearing | ✅/⚠️/❌ | ... |
  | ...                        | ...    | ... |
```

## Step 4: 改善提案を表形式で提示

```
| スキル | 観点 | 現状 | 改善案 |
|---|---|---|---|
| review-claude-docs | description | 長文・key use case が冒頭でない | 「ISUCON 本番モード視点で...」を冒頭に |
| ... | ... | ... | ... |
```

## Step 4.5: 評価結果を `.claude/SKILL_REVIEW.md` に書き出す

Write ツールで `.claude/SKILL_REVIEW.md` を作成または上書きする（全置換でよい。対応履歴は git log で追える）。

書き出す内容（順番に記載）:
1. 最終更新日時（`date '+%Y-%m-%d %H:%M:%S'` で取得。1 日に複数回回ることが多いので時刻まで記録）
2. 評価観点テーブル（8 項目）
3. 全スキル評価サマリ（Step 3 の ✅/⚠️/❌ + 行数）
4. 未対応の改善提案（Step 4 の表。なければ「なし」と記載）

## Step 5: ユーザー合意後に修正

合意を得たら Edit で各 SKILL.md を修正。複数スキル変更時は1ファイルずつ確認しながら進める。

修正完了後、`.claude/SKILL_REVIEW.md` を更新する：
- 全スキル評価サマリの該当スキルを ✅ に更新
- 未対応の改善提案テーブルから該当行を削除

## 注意事項

- description は **frontmatter 内**で 1,024 字（`when_to_use` と合算で 1,536 字）。本文の長さとは別計測
- スキル実行時は SKILL.md が bash で読まれる仕様のため、SKILL.md 内の `!` Bash inline は preprocessing で実行される（無駄な echo は本当にコンテキストに入るので削除価値あり）
- 評価結果は **そのまま `.claude/rules/skill-design.md` のレビュー観点と整合**するように
