# REVIEW: review-skills

> レビュー日時: 2026-05-07
> ファイル: /Users/user01/.claude/skills/review-skills/SKILL.md

## 総評
SKILL.md をベストプラクティスに照らしてレビューするスキルで、一括/単体の両モードを持つ。189行と適切な範囲内で、サブエージェント並列起動・集約サマリ・REVIEW.md 書き出し・後続アクション確認まで一貫した設計になっている。`context: fork`、`disable-model-invocation: true`、`agent: general-purpose` も明示されており品質は高い。`allowed-tools` の表記の一貫性と Step 2 のサブエージェント挙動の一部に軽微な改善余地。

## ✅ 良い点
- `context: fork`（L8）が設定されており、チェック [1] の `context` 観点で(A)に該当（各スキルの `REVIEW.md` 書き出しが主目的）。
- `agent: general-purpose`（L9）が明示されており、書き込みを含む処理に対応した設定が分かりやすい。
- `disable-model-invocation: true`（L5）で自動トリガーを防止している。
- `argument-hint`（L7）と `when_to_use`（L4）が両方揃っており、引数の有無による挙動が description にも明記されている。
- 一括レビューモード Step 2（L33–L49）でサブエージェントを **1 メッセージ内に並べて起動** という指示がある（チェック [3] 並列起動の明示）。
- 各サブエージェントへのプロンプトテンプレート（L39–L49）が具体的に記載されており、`<name>` `<path>` の置換ルールも明確（チェック [3] プロンプトテンプレート）。
- Step 3（L51–L78）で全サブエージェント完了後にサマリを集約 → 修正/TODO 追記の確認、という順序が明示されている（チェック [3] 待機・集約の順序）。
- subagent_type に `general-purpose` を明示し、書き込みを含むため `Explore` は不可、と理由付きで書かれている（チェック [3] subagent type）。
- 単体モードのフォールバック（L89–L91、L83–L94）が明記されている（チェック [2] フォールバック）。
- チェック [1]〜[4] が観点別に表形式で整理されており、レビューの網羅性が高い。
- 「git 操作は一切行わない」という制約が冒頭の「## 制約」（L13–L14）に明記されており、副作用ガードが先頭で目に入る。
- 出力フォーマット（L150–L174）が具体的に固定されており、出力の一貫性が保たれる。
- `allowed-tools` に `Write Edit Agent` が含まれており、REVIEW.md 書き出し・Agent 起動で確認プロンプトが繰り返し出ない。

## ⚠️ 改善提案（任意対応）
- **`allowed-tools` の `Agent` の有効性**: L6 の `allowed-tools` に `Agent` と書かれているが、Claude Code の正式なツール名は `Task`（サブエージェント起動）であり、`Agent` 文字列が pre-approve として効くかは環境依存の可能性がある。実際にこのスキルを実行してサブエージェント起動時に許可プロンプトが繰り返し出るようなら、`Task` への置き換え、または該当環境のツール名に合わせる必要がある（要動作確認）。
- **Step 2 の Bash inline `{ (Bash completed with no output) }` 表記**: チェック [2] の表（L119）に `` (Bash completed with no output) `` という特殊な表記が混入している（おそらく `` !`command` `` の意図）。本文を読む Claude を混乱させる可能性があるため、`` !`command` `` 表記に統一する（チェック [4] 安全性の項 L142 にも同じ表記あり）。
- **単体モードの探索順の `~/` 表記**: L94 の supporting files 探索や、`.claude/skills/` 表記がカレント基準・ホーム基準のどちらかが文脈依存。プロジェクト直下から呼ばれるとカレントの `.claude/skills/` を、グローバルなら `~/.claude/skills/` を見る、という挙動の前提が暗黙。両方を順に試すか、本文で明示すると単体モードでの取りこぼしが減る。
- **行数（189行）**: 500 行制限内に十分収まっているが、チェック観点の表が長いため「supporting file（review-checklist.md など）への抽出」を将来検討する余地あり（現時点では分割不要）。

## ❌ 問題点（要修正）
なし。

## 修正後の frontmatter サンプル（変更がある場合のみ）
（変更不要。ただし `allowed-tools: ... Agent` が想定通り pre-approve として効くか動作確認推奨）
