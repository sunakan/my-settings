# REVIEW: gen-pr

> レビュー日時: 2026-06-13
> ファイル: /Users/user01/works/github.com/sunakan/my-settings/claudecode/skills/gen-pr/SKILL.md

## 総評

`gh pr create` コマンドを組み立てて提示するスキルとして、frontmatter・本文ともに完成度が高い。`disable-model-invocation: true` による誤実行防止、`allowed-tools` の個別絞り込み、対話フロー主体ゆえの `context: fork` 非使用（Why-not コメント付き）と、全設計判断が適切に記録されている。問題点・改善提案ともになし。

## ✅ 良い点

- `disable-model-invocation: true`（L5）で PR 作成の誤実行を確実に防いでいる
- `allowed-tools`（L6）が `Bash(git log *)` `Bash(git diff *)` `Bash(git rev-parse *)` `Bash(gh repo view *)` `Bash(gh pr list *)` `Write` と個別に列挙されており、使用するコマンドと過不足なく一致している
- `context: fork` を付けず、Why-not コメント（L7）で理由（対話フロー主目的）を明記している。チェック [1] の `context` 判定は (B) に該当し、現在の設定が正しい
- `!` プレフィックスでブランチ名・コミット差分・マージ済み PR タイトル一覧を実行時に取得している（動的コンテキスト）
- フォールバックがベースブランチ未特定時・コミット差分なし時の 2 ケースで明示されている（L20-L22）
- PR body を `/tmp/pr-body-<branch>.md` に Write で書き出し、コマンドで参照する設計が明確
- `description` + `when_to_use` 合計 170 文字で上限 1,536 文字を大幅に下回っている
- 73 行で 500 行制限を大幅に下回り、supporting files への分割は不要

## ⚠️ 改善提案（任意対応）

なし

## ❌ 問題点（要修正）

なし
