# Claude Code 設定 TODO

## 検討中

### スキル: `update-claude-settings`（実機確認のみ）

> REVIEW: `claudecode/skills/update-claude-settings/REVIEW.md`

⚠️ 改善提案 1件（❌ 問題点なし）:
- **`Task` の pre-approve 有効性**: `allowed-tools` の `Task` と `Bash(ls /Users/user01/.claude/*)` が実際に pre-approve として効くか実機確認が必要。許可プロンプトが繰り返し出るようなら動作確認の上でツール名を調整（チルダ→絶対パスは対応済み）。

---

### `async: true` フック — 非ブロッキング非同期フック

- **課題**: 現在の notify-on-stop.sh など、Claude の実行を待たせる必要がない副作用処理がブロッキング実行されている
- **現状**: 全フックが同期実行のため、Stop フックの通知スクリプトが完了するまで次の操作が始まらない
- **改善後**: `async: true` を Stop フックの command に追加し、通知処理をバックグラウンド実行にする
- **効果と期待**: Claude の応答開始までのレイテンシを削減できる（January 2026 リリースの機能）
- **参考**: https://medium.com/@joe.njenga/claude-code-async-hooks-upgrade-makes-workflows-3x-faster-i-tested-it-in-seconds-ef5836f2bd34

---

### `PostCompact` フック — コンテキスト圧縮後の文脈再注入

- **課題**: コンテキスト圧縮（compaction）後に重要な制約や進行中タスクの情報が失われることがある
- **現状**: PostCompact hook が未設定のため、圧縮後に Claude が文脈を失うリスクがある
- **改善後**: PostCompact フックを追加し、現在のタスク・制約・変更ファイル一覧を stdout で再注入するスクリプトを hooks/ に配置する
- **効果と期待**: 長時間セッションでの文脈ロストを防ぎ、圧縮後も一貫した動作が期待できる（March 2026 時点で 21 イベントに拡張済み）
- **参考**: https://medium.com/@porter.nicholas/claude-code-post-compaction-hooks-for-context-renewal-7b616dcaa204

---

### `Notification` フック — パーミッション/アイドル通知をデスクトップ通知へ転送

- **課題**: Claude がユーザー確認待ち（permissionprompt / idleprompt）になっても気づきにくい
- **現状**: Stop フックのみ通知設定済みで、許可待ちやアイドル状態の通知がない
- **改善後**: `Notification` イベントに matcher を設定し、notify-on-stop.sh の通知ロジックを流用してデスクトップ通知を飛ばす
- **効果と期待**: Claude が待機状態になったときにすぐ気づけるようになる
- **参考**: https://claudefa.st/blog/tools/hooks/hooks-guide

---

### `alwaysLoad` MCP オプション — 特定 MCP サーバーのツール常時利用

- **課題**: MCP サーバーのツールがツールサーチの対象になり、明示的に検索しないと利用できないケースがある
- **現状**: mcpServers は空（`{}`）で MCP サーバー未設定のため、将来 MCP を追加した際に検討が必要
- **改善後**: 頻繁に使う MCP サーバーの設定に `alwaysLoad: true` を追加し、ツールを常時利用可能にする
- **効果と期待**: 毎回ツールサーチなしに即座に MCP ツールが使えるようになる（v2.1.126 で追加されたオプション）
- **参考**: https://www.eesel.ai/blog/settings-json-claude-code

---

## やらない

### `keybindings.json` の git 管理

キーマッピングをする予定がないため。

---

### `PostToolUse: Write/Edit` フック — ファイル保存後に自動フォーマット

ISUCON や `.claude/settings.json` など、勝手にフォーマットされると困るファイルがあるため。

---

### `UserPromptSubmit` フック — プロンプト内に認証情報が含まれていたらブロック

毎回チェックされる煩わしさ・パフォーマンスの割に防御できるものがかなり限定的（完璧な正規表現が存在しない）であるため。

---

### スクリプト実行・プロンプトインジェクション経由のセンシティブファイル漏洩対策

効果が限定的で実装コストが高いため。
