# REVIEW: review-skills

> レビュー日時: 2026-05-07
> ファイル: /Users/user01/works/github.com/sunakan/my-settings/claudecode/skills/review-skills/SKILL.md

## 総評
SKILL.md をベストプラクティスに照らして一括/単体でレビューするスキルで、サブエージェント並列起動・REVIEW.md書き出し・サマリ集約・後続アクション確認まで一貫した設計。`context: fork`・`disable-model-invocation: true`・`agent: general-purpose` が明示されており品質が高い。231行と大きめだが500行制限内。`allowed-tools` の `Agent` の有効性と単体モードのCWD前提の明示が軽微な改善余地。

## ✅ 良い点
- `context: fork`（L8）が設定されており、チェック [1] の `context` 観点で(A)に該当（各スキルの `REVIEW.md` 書き出しが主出力）。
- `agent: general-purpose`（L9）が明示されており、書き込みを含む処理に適したサブエージェントタイプが分かりやすい。
- `disable-model-invocation: true`（L5）で自動トリガーを防止している。
- `argument-hint`（L7）と `when_to_use`（L4）が両方揃っており、引数の有無による挙動が description にも明記されている。
- 一括レビューモード Step 2 でサブエージェントを **1 メッセージ内に並べて起動** という指示がある（チェック [3] 並列起動の明示）。
- 各サブエージェントへのプロンプトテンプレートが具体的に記載されており `<name>` の置換ルールも明確（チェック [3] プロンプトテンプレート）。
- Step 3 で全サブエージェント完了後にサマリを集約 → 修正/TODO 追記確認という順序が明示されている（チェック [3] 待機・集約の順序）。
- `subagent_type: general-purpose` を明示し書き込みを含むため `Explore` は不可と理由付きで書かれている（チェック [3] subagent type）。
- 単体モードのフォールバックが明記されている（チェック [2] フォールバック）。
- チェック [1]〜[4] が観点別に表形式で整理されており、レビューの網羅性が高い。
- 「git 操作は一切行わない」という制約が冒頭に明記されており、副作用ガードが先頭で目に入る。
- 出力フォーマットが具体的に固定されており、出力の一貫性が保たれる。

## ⚠️ 改善提案（任意対応）
- **`allowed-tools` の `Agent` の有効性**: `allowed-tools` に `Agent` と書かれているが、Claude Code の正式なツール名は `Task`（サブエージェント起動）であり、`Agent` が pre-approve として効くかは環境依存の可能性がある。実際にサブエージェント起動時に許可プロンプトが繰り返し出るようなら `Task` への置き換えを検討（要動作確認）。
- **単体モードのCWD前提の明示**: 一括モードの Step 1 に「対象は CWD の `.claude/skills/`」という記載があるが、単体モードの説明（L82以降）には同様の明示がなく、暗黙的にCWD基準を前提としている。単体モードにも「対象は CWD の `.claude/skills/`」と一文添えると一貫性が増す（軽微）。

## ❌ 問題点（要修正）
なし。

## 修正後の frontmatter サンプル（変更がある場合のみ）
（変更不要。ただし `allowed-tools` の `Agent` が pre-approve として実機で効くか動作確認推奨）
