# REVIEW: commit

> レビュー日時: 2026-06-13
> ファイル: /Users/user01/works/github.com/sunakan/my-settings/claudecode/skills/commit/SKILL.md

## 総評

ステージング済み差分から候補3つを提示してコミットする、責務が明確なスキル。`disable-model-invocation: true` と最小限の `allowed-tools`、`context: fork` を付けない理由のコメントが揃っており、設計の意図が自己説明的で品質が高い。52行とコンパクトで、致命的な問題はなし。

## ✅ 良い点

- `context: fork` を付けない理由が frontmatter コメント（L7）と本文（L26）の両方に明記されている。チェック [1] の `context` 判定は (B)「ユーザーへの会話が主目的」に該当し、候補提示→確認→コミットという対話フローを維持するために `context: fork` なしが正しい
- `allowed-tools: Bash(git diff *) Bash(git log *) Bash(git commit *)`（L6）と必要最小限。`Bash` 全体許可になっていない（チェック [4] 過剰許可なし）
- `disable-model-invocation: true`（L5）が設定されており、コミットという副作用の大きい操作で自動 invoke を防いでいる（チェック [4] 破壊的操作の安全性）
- `git add` / `git stage` を絶対に実行しない制約（L24）で責務が明確に分離されている
- `!`git diff --staged``（L16）と `!`git log --oneline -10``（L20）で動的コンテキストを取得（チェック [2] 動的コンテキスト）
- ステージングが空のときのフォールバック（L25）が明記されている（チェック [2] フォールバック）
- `when_to_use`（L4）が独立フィールドとして存在し呼び出し判断の文脈が明確
- 52行で500行制限を大幅に下回り、supporting files への分割は不要

## ⚠️ 改善提案（任意対応）

- **description の冒頭の情報密度**: `disable-model-invocation: true` の場合は description がコンテキストにロードされないため、description の改善による実質的な効果は限定的（参考情報として）

## ❌ 問題点（要修正）

なし

## 修正後の frontmatter サンプル（変更がある場合のみ）

変更不要
