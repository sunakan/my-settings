# REVIEW: update-claude-settings

> レビュー日時: 2026-05-07
> ファイル: /Users/user01/works/github.com/sunakan/my-settings/claudecode/skills/update-claude-settings/SKILL.md

## 総評
Claude Code の設定改善候補を Web 検索で調査し、TODO.md に追記するスキルで、責務が明確。`context: fork` が設定されており、4つのエージェントを並列起動するパターンも正しく実装されている。全体的に高品質なスキルで、軽微な改善余地のみ存在する。

## ✅ 良い点
- `context: fork` が設定されており、大量の Web 検索処理がメインコンテキストを汚染しない
- Phase 2 で4つの Agent を **1メッセージ内に同時起動** する明示がある（並列起動の最良パターン）
- 各 Agent に `subagent_type: Explore`（読み取り専用）が正しく指定されている
- Phase 3 のフィルタリングロジック（既実装・やらないリスト・既存検討中のスキップ）が具体的
- `TODO.md` が存在しない場合のフォールバックが冒頭に書かれている
- 追記フォーマットが具体的に定義されており、出力の一貫性が保たれる
- `allowed-tools: Bash(ls ~/.claude/*)` と最小権限に絞られている
- 「やらないリスト」の特例条件（`【特例】`フラグ）が明示されており、エッジケースが考慮されている

## ⚠️ 改善提案（任意対応）
- **`when_to_use` 欠如**: description に使用タイミングが含まれているが、`when_to_use` フィールドとして分離するとより明確になる → 追加例: `when_to_use: "Claude Code の設定を見直したいとき、新しいベストプラクティスを調査したいとき、my-settings リポジトリで設定改善候補をリストアップしたいとき"`
- **`Edit` ツールの必要性確認**: `allowed-tools` に `Edit` が含まれているが、スキルの本文では TODO.md への追記に `Edit` を使うことが明示されていない（Write で追記する可能性もある）。実際の使用ツールに合わせて整理すると良い

## ❌ 問題点（要修正）

なし
