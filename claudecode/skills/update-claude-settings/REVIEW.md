# REVIEW: update-claude-settings

> レビュー日時: 2026-05-07
> ファイル: /Users/user01/.claude/skills/update-claude-settings/SKILL.md

## 総評
Web 検索で最新ベスプラを調査し、現状と照合して TODO.md「検討中」に追記するスキル。`disable-model-invocation: true`、`context: fork`、`Agent` を含む `allowed-tools` が揃っており、4 つのサブエージェントを並列起動するパターンも明示されている。フィルタリング・追記フォーマット・フォールバックも具体的で、全体的に高品質。

## ✅ 良い点
- `disable-model-invocation: true`（L5）で TODO.md への自動編集を防止している。
- `context: fork`（L7）が設定されており、チェック [1] の `context` 観点で(A)に該当（TODO.md への追記が主目的の独立処理）。
- `allowed-tools: WebSearch WebFetch Read Bash(ls ~/.claude/*) Edit Agent`（L6）と、Web 検索系・Read・Edit・Agent が事前承認されており、必要権限のみに絞られている（チェック [4] 過剰許可なし）。
- `when_to_use`（L4）が独立フィールドとして存在し、呼び出し判断の文脈が明確。
- Phase 2（L26–L55）で 4 つの Agent を **1 メッセージ内に同時起動** という指示がある（チェック [3] 並列起動の明示）。
- 各 Agent に `subagent_type: Explore`（読み取り専用）が正しく指定されている（チェック [3] subagent type — Web 検索のみで書き込みなし）。
- 各 Agent への調査キーワードが具体的に記載されている（チェック [3] プロンプトテンプレート、チェック [2] 具体性）。
- Phase 3（L57–L64）のフィルタリングロジック（既実装・やらないリスト・既存検討中のスキップ）が具体的で機械的に判定可能。
- `TODO.md` が存在しない場合のフォールバック（L11–L12）が冒頭に記載されている（チェック [2] フォールバック）。
- 追記フォーマット（L78–L90）が固定されており、出力の一貫性が保たれる。
- 「やらないリスト」に対する `【特例】` フラグ運用（L62）でエッジケース（重大セキュリティリスク等）が考慮されている。

## ⚠️ 改善提案（任意対応）
- **`allowed-tools` の `Agent` の有効性**: L6 の `Agent` が Claude Code 環境で pre-approve として実際に効くかは要動作確認。正式なツール名が `Task` の環境では置き換えが必要（review-skills と同じ論点）。
- **`Bash(ls ~/.claude/*)` の展開挙動**: `allowed-tools` パターンとして `~` がチルダ展開されるかは Claude Code のパーミッション照合実装に依存。確実に効かせたい場合は絶対パス（例: `Bash(ls /Users/user01/.claude/*)`）に書き換えるか、チルダを使う場合の挙動を実機で確認しておくと安全。
- **Web 検索の年指定キーワード**: Phase 2 の各 Agent のキーワードに `2025` がハードコードされている（L33, L38, L43, L48, L52）。年が固定されていると将来的に古い情報ばかりヒットしうる。`current_year` 相当の動的展開や「最新の」「latest」表現に置き換えると陳腐化を防げる。
- **Phase 4 追記後の重複チェックの再実行**: 並列起動した 4 Agent が類似キーワードで近いトピックを返した場合、Phase 3 の「検討中に既に載っている」チェックは「TODO.md 読み込み時点」の検討中項目のみで判定される。Phase 4 の追記中に同セッション内の追加候補同士が重複する可能性に触れると、より堅牢になる（軽微）。

## ❌ 問題点（要修正）
なし。

## 修正後の frontmatter サンプル（変更がある場合のみ）
（変更不要。ただし `allowed-tools` の `Agent` と `Bash(ls ~/.claude/*)` のパターンが pre-approve として実機で効くか動作確認推奨）
