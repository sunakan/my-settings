# Claude Code 設定 TODO

## 検討中

### スキル: `review-claude-rules`

> REVIEW: `claudecode/skills/review-claude-rules/REVIEW.md`

⚠️ 改善提案 2件（❌ 問題点なし）:
- **`$ARGUMENTS` 直接展開の shell injection リスク**: `ls .claude/rules/$ARGUMENTS 2>/dev/null` でクォートなしで展開しているため、シェルメタ文字を含む引数で予期しない動作になる可能性がある。`ls ".claude/rules/$ARGUMENTS" 2>/dev/null` のようにダブルクォートで囲むと安全性が増す。
- **`agent` フィールドのコメント補足**: `context: fork` を付けているが書き込みありのため `general-purpose`（デフォルト）が正しい。デフォルトでよい旨をコメントで残すと意図が伝わる。

---

### スキル: `review-claude-skills`

> REVIEW: `claudecode/skills/review-claude-skills/REVIEW.md`

⚠️ 改善提案 4件（❌ 問題点なし）:
- **`review-skills` との責務重複の明文化**: 同リポジトリの `review-skills`（Agent 並列・REVIEW.md 書き出し）との違いを description か冒頭に明記すると使い分けが容易になる。重複が大きい場合は統合も検討。
- **`$ARGUMENTS` クォートなしの shell injection リスク**: `ls .claude/skills/"$ARGUMENTS"/SKILL.md 2>/dev/null` のようにクォートするのが安全。
- **Web 検索の頻度判定が曖昧**: 「時間が経っている場合」の判定基準を具体化（例: `SKILL_REVIEW.md` に最終 Web 確認日時を記録し N 日以上経過で再検索）すると判断が安定する。
- **`agent` フィールドのコメント補足**: 書き込みありのため `general-purpose` がデフォルトで正しいが、`agent: general-purpose` を明示するかコメントで意図を残すと保守性が上がる。

---

### スキル: `review-git-diff-size`

> REVIEW: `claudecode/skills/review-git-diff-size/REVIEW.md`

⚠️ 改善提案 1件（❌ 問題点なし）:
- **「適切な粒度」の判定基準の言語化**: 「1コミット分として適切な粒度か評価する」の基準が暗黙。「変更行数 / 変更ファイル数 / 関心事の数」などの観点をヒント程度に添えると評価のブレが減る。

---

### スキル: `review-skills`

> REVIEW: `claudecode/skills/review-skills/REVIEW.md`

⚠️ 改善提案 4件（❌ 問題点なし）:
- **`allowed-tools` の `Agent` の有効性**: Claude Code の正式なツール名は `Task`（サブエージェント起動）であり、`Agent` 文字列が pre-approve として効くかは環境依存の可能性がある。サブエージェント起動時に許可プロンプトが繰り返し出るようなら `Task` に置き換えが必要（要動作確認）。
- **`(Bash completed with no output)` 表記の混入**: チェック表内に `(Bash completed with no output)` という特殊表記が混入しており、本文を読む Claude を混乱させる可能性がある。`` !`command` `` 表記に統一する。
- **単体モードの探索パス前提の明示**: `.claude/skills/` がカレント基準かホーム基準かが文脈依存。プロジェクト直下なら `.claude/skills/`、グローバルなら `~/.claude/skills/` を見るという挙動の前提を明示、または両方を順に試す設計にすると取りこぼしが減る。
- **行数増加時の将来分割案**: 現状 189 行で問題ないが、チェック観点の表が長いため長期的に `review-checklist.md` など supporting file への抽出を検討。

---

### スキル: `update-claude-settings`

> REVIEW: `claudecode/skills/update-claude-settings/REVIEW.md`

⚠️ 改善提案 4件（❌ 問題点なし）:
- **`allowed-tools` の `Agent` の有効性**: `review-skills` と同じ論点。正式なツール名が `Task` の環境では置き換えが必要（要動作確認）。
- **`Bash(ls ~/.claude/*)` のパス展開挙動**: `~` がチルダ展開されるかは Claude Code のパーミッション照合実装に依存。確実に効かせたい場合は絶対パスに書き換えるか実機で確認。
- **Web 検索の年指定ハードコード**: Phase 2 の検索キーワードに `2025` がハードコードされており、将来的に古い情報ばかりヒットしうる。`latest` や `最新の` 表現、または動的な年指定に置き換えを検討。
- **並列 Agent 間の重複チェック**: 4 Agent が類似キーワードで近いトピックを返した場合、Phase 3 のフィルタリングは「TODO.md 読み込み時点」の検討中項目のみで判定されるため、同セッション内の追加候補同士が重複する可能性がある。

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
