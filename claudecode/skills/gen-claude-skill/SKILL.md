---
name: gen-claude-skill
description: Interactively creates a new Claude Code skill (SKILL.md). Asks what the skill should do, when it triggers, and what tools it needs, then creates claudecode/skills/<name>/SKILL.md and iteratively reviews/fixes until all 8 best-practice criteria pass.
when_to_use: When the user wants to create a new Claude Code skill. Triggered by "新しいスキルを作りたい", "スキルを追加したい", "gen-claude-skill".
allowed-tools: Read Write Edit Bash(find *) Bash(ls *) Bash(mkdir *) WebSearch WebFetch
argument-hint: "[skill name or topic]"
# context: fork は付けない — ユーザーとの対話フローが主目的のため
---

## 目的

`claudecode/skills/<name>/SKILL.md` を新規作成し、ベスプラ準拠を確認する。

## Step 1: ベストプラクティスの確認

組み込み知識を使う。必要に応じて `WebSearch` で最新情報を補完する。

**frontmatter フィールド順**

`name` → `description` → `when_to_use` → `disable-model-invocation` → `allowed-tools` → `argument-hint` → `context` → `agent` → `# コメント`

省略フィールドはスキップ。`# コメント` は「なぜそのフィールドを付けないか」の Why-not 注釈。

**各フィールドの注意点**

- `description`: 三人称（「I can」「私が」禁止）・1,024字以内・key use case 冒頭
- `when_to_use`: 具体的な trigger。`description` と合算で 1,536字以内
- `disable-model-invocation`: `true` にすると description が context にロードされない → 自動 trigger 不可。副作用大・手動限定スキルでのみ使う
- `context: fork` — ファイル出力メインなら付ける。対話フロー・結果を会話に返したいなら付けない
- `allowed-tools`: 最小権限。不要なツールは付けない

**コンテンツ基準**

- 500行以下、最重要事項を冒頭に（truncation 対策）
- CLAUDE.md との重複は排除
- 無駄な Bash inline（`echo "(... を実行)"` 等）は書かない

## Step 2: 既存環境の確認

`ls claudecode/skills/` を実行し、既存スキルとの責務重複を確認する。
CLAUDE.md を Read して常時 load される内容を把握する。

## Step 3: ヒアリング

会話の流れで以下を確認する（既に分かっている場合はスキップ）:

1. **目的・責務**: このスキルで何を達成したいか（one skill, one job）
2. **起動方法**: いつ・どうやって呼ばれるか（自動 trigger か手動限定か）
3. **context: fork の要否**: 対話メインか・ファイル出力メインか
4. **disable-model-invocation の要否**: 副作用大・手動起動限定か
5. **使用ツール**: 何が必要か
6. **スキル名**: `claudecode/skills/<name>/` の `<name>` 部分（kebab-case）
7. **処理フロー**: 何をどの順番でやるか

全て揃ったら Step 4 へ進む。

## Step 4: スキルの作成

```
mkdir -p claudecode/skills/<name>
```

`claudecode/skills/<name>/SKILL.md` を Write で作成する。

作成後、内容をユーザーに提示して確認を得る。

## Step 5: ベスプラレビュー & 修正（完璧になるまで繰り返す）

| # | 観点 | ✅ 基準 |
|---|---|---|
| 1 | description load-bearing か | 1,024字以内（`when_to_use` と合算で 1,536字）・key use case 冒頭・具体的 trigger 含む |
| 2 | one skill, one job か | 責務が単一 |
| 3 | 冒頭に最重要事項 | 最初の数十行で何をするスキルか把握できる |
| 4 | 500行以下 | 超えたら supporting files への分離を提案 |
| 5 | CLAUDE.md との重複なし | 重複があれば削除 |
| 6 | 無駄な Bash inline なし | ダミーコマンドを削除 |
| 7 | disable-model-invocation の設定 | 副作用大・手動限定なら `true`。それ以外は設定しない |
| 8 | 三人称 | description / 本文に「I can」「私が」なし |

問題があれば Edit で修正 → 再レビュー。全項目 ✅ になったら `/review-claude-skills <name>` の実行を提案して完了を報告する。
