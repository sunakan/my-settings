# REVIEW: update-claude-settings

> レビュー日時: 2026-05-07
> ファイル: claudecode/skills/update-claude-settings/SKILL.md

## 総評
Claude Code の設定改善候補を Web 検索で調査し、TODO.md に追記するスキルで、責務が明確。`context: fork` が設定されており、4つのエージェントを並列起動するパターンも正しく実装されている。ただし `allowed-tools` に `Agent` が含まれていないにもかかわらず Agent ツールを使用している点と、`disable-model-invocation` が欠如している点が問題。

## ✅ 良い点
- `context: fork` が設定されており（分類: A — ファイル書き込みで完結）、大量の Web 検索処理がメインコンテキストを汚染しない
- Phase 2 で4つの Agent を **1メッセージ内に同時起動** する明示がある（並列起動の最良パターン）
- 各 Agent に `subagent_type: Explore`（読み取り専用）が正しく指定されている
- Phase 3 のフィルタリングロジック（既実装・やらないリスト・既存検討中のスキップ）が具体的
- `TODO.md` が存在しない場合のフォールバックが冒頭に書かれている
- 追記フォーマットが具体的に定義されており、出力の一貫性が保たれる
- 「やらないリスト」の特例条件（`【特例】`フラグ）が明示されており、エッジケースが考慮されている

## ⚠️ 改善提案（任意対応）
- **`when_to_use` 欠如**: description に使用タイミングが含まれているが、`when_to_use` フィールドとして分離するとより明確になる → 追加例: `when_to_use: "Claude Code の設定を見直したいとき、新しいベストプラクティスを調査したいとき、my-settings リポジトリで設定改善候補をリストアップしたいとき"`

## ❌ 問題点（要修正）
- **`allowed-tools` に `Agent` が未登録**: Phase 2 で Agent ツールを使用しているが、`allowed-tools: WebSearch WebFetch Read Bash(ls ~/.claude/*) Edit Agent` の `Agent` が含まれていない。Agent ツールを使う場合は `allowed-tools` に明示しなければ実行時に許可プロンプトが繰り返し表示される
- **`disable-model-invocation` 欠如**: TODO.md への追記という副作用を持つ操作であり、自動トリガーは不適切。`disable-model-invocation: true` を追加すべき

## 修正後の frontmatter サンプル（変更がある場合のみ）
```yaml
---
name: update-claude-settings
description: /update-claude-settings で呼ばれた時、Web検索でClaude Codeの最新ベストプラクティス・新オプション・コミュニティの工夫を調査し、現在の設定と照らし合わせて改善候補をTODO.mdの「検討中」セクションに追記する
disable-model-invocation: true
allowed-tools: WebSearch WebFetch Read Bash(ls ~/.claude/*) Edit Agent
context: fork
---
```
