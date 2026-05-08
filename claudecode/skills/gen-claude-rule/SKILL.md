---
name: gen-claude-rule
description: Interactively creates a Claude Code path-scoped rule file. Asks which files to target and what guidelines to enforce, then creates the rule in claudecode/rules/ and iteratively reviews/fixes until best-practice-compliant.
when_to_use: When the user wants to create a new Claude Code path-scoped rule file. Triggered by "rules ファイルを作りたい", "新しいルールを追加したい", "gen-claude-rule".
allowed-tools: Read Write Edit Bash(find *) Bash(ls *) WebSearch WebFetch
argument-hint: "[rule name or topic]"
# context: fork は付けない — ユーザーとの対話フローが主目的のため
---

## 目的

`claudecode/rules/` に path-scoped rule ファイルを新規作成し、ベスプラ準拠を確認する。

## Step 1: ベストプラクティスの確認

組み込み知識を使う。必要に応じて `WebSearch` で最新情報を補完する。

**frontmatter（必須）**
- `globs: <pattern>` — カンマ区切り文字列。`paths:` の YAML list 形式はサイレント失敗の既知問題（GitHub Issue #17204）
- `description: <third-party description>` — 何に・いつ適用されるかを第三者視点で記述

**コンテンツ基準**
- 100行以下
- 指示形（命令形）を使う。否定形より肯定形が効果的
- 自己説明文（「このルールは...自動 load される」）は書かない
- Claude が自明に分かること（言語構文・典型的なフレームワーク慣習）は書かない
- CLAUDE.md との重複は排除

## Step 2: 既存環境の確認

`ls claudecode/rules/` を実行し、既存ルールとの重複・競合を確認する。
CLAUDE.md を Read して常時 load される内容を把握する。

## Step 3: ヒアリング

会話の流れで以下を確認する（既に分かっている場合はスキップ）:

1. **目的**: このルールで何を達成したいか
2. **対象ファイル**: どのファイルを編集する時に適用したいか（glob pattern）
   - `find` で実際のファイル構造を確認し適切なパターンを提案する
3. **ルール内容**: Claude に何をしてほしいか（具体的に）
4. **ファイル名**: `claudecode/rules/<name>.md` の `<name>` 部分（kebab-case）

全て揃ったら Step 4 へ進む。

## Step 4: ルールファイルの作成

`claudecode/rules/<name>.md` を Write で作成する。

作成後、内容をユーザーに提示して確認を得る。

## Step 5: ベスプラレビュー & 修正（完璧になるまで繰り返す）

| # | 観点 | ✅ 基準 |
|---|---|---|
| 1 | `globs:` 形式 | カンマ区切り文字列（`paths:` YAML list は不可） |
| 2 | glob が実ファイルにマッチするか | `find` で確認（マッチ 0 件なら rule は永遠にロードされない） |
| 3 | `description` フィールド | 第三者視点・具体的 |
| 4 | 行数 | 100行以下 |
| 5 | 自己説明文なし | 「このルールは...load される」等を削除 |
| 6 | 指示形 | 肯定形・命令形が主体 |
| 7 | 非自明な内容のみ | Claude が自明に分かることは除外 |
| 8 | CLAUDE.md との重複なし | 重複があれば削除 |
| 9 | path-scoped に値するか | 全ファイル共通なら CLAUDE.md へ移動 |

問題があれば Edit で修正 → 再レビュー。全項目 ✅ で完了を報告する。
