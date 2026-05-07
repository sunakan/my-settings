---
name: update-claude-settings
description: /update-claude-settings で呼ばれた時、Web検索でClaude Codeの最新ベストプラクティス・新オプション・コミュニティの工夫を調査し、現在の設定と照らし合わせて改善候補をTODO.mdの「検討中」セクションに追記する
when_to_use: "Claude Code の設定を見直したいとき、新しいベストプラクティスを調査したいとき、my-settings リポジトリで設定改善候補をリストアップしたいとき"
disable-model-invocation: true
allowed-tools: WebSearch WebFetch Read Bash(ls /Users/user01/.claude/*) Edit Task
context: fork
---

## 前提チェック

`./TODO.md` が存在するか確認する。存在しない場合は「TODO.md が見つかりません。my-settings リポジトリのルートで実行してください」と伝えて終了する。

## Phase 1: 現状把握

以下を読む:

1. `./TODO.md` — 「やらない」リストのタイトルと「検討中」の既存項目タイトルを把握する
2. `~/.claude/settings.json` — 現在の設定内容を把握する
3. `ls ~/.claude/hooks/` — 設定済みのフック一覧
4. `ls ~/.claude/skills/` — 設定済みのスキル一覧

「やらない」リストに載っているタイトルを内部的にリストアップしておく（Phase 3 のフィルタリングで使う）。

## Phase 2: 並列 Web 検索

以下の 4 つの Agent を **1 メッセージ内に同時起動** する。各 Agent はサマリ（改善候補のタイトル・概要・ソース URL）のみを返す。

**Agent A — hooks・セキュリティ系**（subagent_type: Explore）

以下のキーワードで WebSearch し、Claude Code の hooks に関する新しいベストプラクティス・パターン・設定例を調査する:
- "claude code hooks best practices latest"
- "claude code PreToolUse PostToolUse UserPromptSubmit examples"
- "claude code hooks security"

**Agent B — settings.json・plugins 系**（subagent_type: Explore）

以下のキーワードで WebSearch し、settings.json の新オプション・公式 plugins・MCP サーバーの推奨事例を調査する:
- "claude code settings.json new options latest"
- "claude code plugins official"
- "claude code mcpServers examples"

**Agent C — GitHub コミュニティ設定**（subagent_type: Explore）

以下のキーワードで WebSearch し、GitHub で公開されている設定事例・CLAUDE.md のベストプラクティスを調査する:
- "github claude code settings community latest"
- "claude code CLAUDE.md examples github"
- "claude code skills commands github examples"

**Agent D — 日本語記事（Zenn / Qiita）**（subagent_type: Explore）

以下のキーワードで WebSearch し、Zenn・Qiita の日本語記事から Claude Code の工夫・設定 tips を調査する:
- "site:zenn.dev claude code 設定 最新"
- "site:qiita.com claude code ベストプラクティス"
- "claude code 工夫 tips 日本語"

## Phase 3: 照合・フィルタリング（Phase 2 の全 Agent 完了後）

Agent A〜D の結果を受け取り、以下の順でフィルタリングする:

1. **既に実装済み**（settings.json・hooks・skills の現状と一致） → スキップ
2. **やらないリストに載っている** → 原則スキップ。「重大なセキュリティリスクがある」など絶対に対応すべきと判断した場合のみ、タイトル先頭に `【特例】` を付けて追記する
3. **検討中に既に載っている** → スキップ
4. **同セッション内で既に追記済みのタイトルと重複** → スキップ（4 Agent が類似キーワードで同一トピックを返す場合を防ぐ）
5. **残った候補** → Phase 4 へ

## Phase 4: TODO.md への追記

### 「検討中」セクションの有無を確認

`./TODO.md` に `## 検討中` セクションが存在しない場合は、ファイル末尾に以下を追加してから項目を追記する:

```
## 検討中
```

### 追記フォーマット

各候補を以下のフォーマットで「検討中」セクションの末尾に追記する:

```markdown
### <改善案タイトル>

- **課題**: <なぜこれが必要か>
- **現状**: <今の設定で何が足りないか>
- **改善後**: <どう変えるか>
- **効果と期待**: <何が良くなるか>
- **参考**: <ソース URL>

---
```

### 追記後の報告

追加した項目数とタイトル一覧を会話上に表示する。追加がゼロの場合は「新しい改善候補は見つかりませんでした」と伝える。
