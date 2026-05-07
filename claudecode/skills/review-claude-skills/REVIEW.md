# REVIEW: review-claude-skills

> レビュー日時: 2026-05-07
> ファイル: /Users/user01/.claude/skills/review-claude-skills/SKILL.md

## 総評
`.claude/skills/<name>/SKILL.md` を8観点でレビューするスキルで、Web検索による公式ベストプラクティスの再確認機能も持つ。`disable-model-invocation: true` と `context: fork` が適切に設定されており、`allowed-tools` も最小権限に絞られている。同じリポジトリに `review-skills` という近接スキルが存在するため、責務の住み分けの明文化が改善余地。

## ✅ 良い点
- `disable-model-invocation: true`（L5）で自動トリガーを防止している。
- `argument-hint: "[skill-name]"`（L7）があり引数の使い方が明示されている。
- `context: fork`（L8）が設定されており（チェック [1] の `context` 観点で(A)に該当 — `.claude/SKILL_REVIEW.md` への書き出しが主目的）、メインコンテキストを汚染しない。
- `allowed-tools: Read Write Edit Bash(ls *) WebSearch WebFetch`（L6）は最小権限に絞られている（`Bash` 全体ではなく `Bash(ls *)`、チェック [4] 過剰許可なし）。
- 8観点（L17–L26）が表形式で具体的に定義されており、機械的なチェックが可能（チェック [2] 具体性）。
- Step 2 で公式ドキュメントを Web 検索し、最新の推奨行数・description 文字数上限・truncation 仕様を確認する仕組みがある。
- `.claude/SKILL_REVIEW.md` への書き出し機能（Step 4.5）で結果を永続化できる。
- 存在しないスキル名のフォールバック（L40–L44）が明記されている。
- 注意事項（L98–L101）に「`disable-model-invocation: true` の場合 description が context に load されない」など、ハマりやすい仕様が明示されている。
- `when_to_use`（L4）が独立フィールドとして存在する。

## ⚠️ 改善提案（任意対応）
- **`review-skills` との責務重複の明文化**: 同じリポジトリ内に `review-skills` スキル（一括/単体レビュー、Agent 並列起動、REVIEW.md 書き出し）が存在し、機能が大きく重なる。description または冒頭に「`review-skills` との違い（例: こちらは8観点固定の機械的チェック＋Web検索による最新ベスプラ確認、あちらは Agent 並列＋REVIEW.md 書き出しによるレビュー）」を明記すると、Claude もユーザーも使い分けが容易になる。重複が大きい場合は片方への統合も検討（チェック [2] 具体性 / チェック [3] サブエージェント設計の整理）。
- **Step 1 の Bash inline での `$ARGUMENTS` 直接展開**: L35 で `$ARGUMENTS` をクオートなしで展開している。シェルメタ文字を含む引数で予期せぬ挙動になる可能性があるため、`ls .claude/skills/"$ARGUMENTS"/SKILL.md 2>/dev/null` のようにクオートするのが安全（チェック [4] shell injection）。
- **Web 検索の頻度判定**: Step 2 で「初回実行時、または最終確認から時間が経っている場合」とあるが「時間が経っている」の判定方法が曖昧。`SKILL_REVIEW.md` に「最終 Web 確認日時」を残し、N 日以上経過していれば再検索、のように具体化すると判断が安定する。
- **`agent` フィールドの明示**: `context: fork` を付けているが、Step 5 で Edit による SKILL.md 修正があるため `general-purpose`（デフォルト）が正しい。`agent: general-purpose` を明示するか、デフォルトでよい旨をコメントで残すと意図が伝わる（軽微）。

## ❌ 問題点（要修正）
なし。

## 修正後の frontmatter サンプル（変更がある場合のみ）
（変更不要）
