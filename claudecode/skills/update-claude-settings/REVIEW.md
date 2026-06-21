# REVIEW: update-claude-settings

> レビュー日時: 2026-06-13
> ファイル: /Users/user01/works/github.com/sunakan/my-settings/claudecode/skills/update-claude-settings/SKILL.md

## 総評

Web 検索で最新ベスプラを調査し現状と照合して TODO.md「検討中」に追記するスキル。`disable-model-invocation: true`・`context: fork`・4つのサブエージェント並列起動パターンが明示されており全体的に高品質。フィルタリング・追記フォーマット・フォールバックも具体的で問題点はなし。

## ✅ 良い点

- `disable-model-invocation: true`（L5）で TODO.md への自動編集を防止している
- `context: fork`（L7）が設定されており、チェック [1] の `context` 観点で (A) に該当（TODO.md への追記が主目的の独立処理）
- `allowed-tools: WebSearch WebFetch Read Bash(ls /Users/user01/.claude/*) Edit Task`（L6）と、必要権限のみに絞られている（チェック [4] 過剰許可なし）
- `when_to_use`（L4）が独立フィールドとして存在し、呼び出し判断の文脈が明確
- Phase 2 で4つのエージェントを **1 メッセージ内に同時起動** という指示がある（チェック [3] 並列起動の明示）
- 各エージェントに `subagent_type: Explore`（読み取り専用）が正しく指定されている（チェック [3] subagent type）
- 各エージェントへの調査キーワードが具体的に記載されている（チェック [3] プロンプトテンプレート）
- Phase 3 のフィルタリングロジック（既実装・やらないリスト・既存検討中のスキップ）が具体的で機械的に判定可能
- `TODO.md` が存在しない場合のフォールバック（L11-L12）が冒頭に記載されている（チェック [2] フォールバック）
- 追記フォーマット（L78-L90）が固定されており、出力の一貫性が保たれる
- Phase 3 の L64 に「同セッション内で既に追記済みのタイトルと重複 → スキップ」が明記されており、並列4エージェントが類似トピックを返す場合の重複対策が設計されている

## ⚠️ 改善提案（任意対応）

- **`allowed-tools` の `Task` の有効性**: `Task` が pre-approve として効くかは環境依存の可能性がある。実際にサブエージェント起動時に許可プロンプトが繰り返し出るようなら動作確認を推奨（チェック [4] 安全性）

## ❌ 問題点（要修正）

なし

## 修正後の frontmatter サンプル（変更がある場合のみ）

変更不要（ただし `allowed-tools` の `Task` が実機で pre-approve として効くか動作確認推奨）
