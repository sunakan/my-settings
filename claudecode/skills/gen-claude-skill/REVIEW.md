# REVIEW: gen-claude-skill

> レビュー日時: 2026-06-13
> ファイル: /Users/user01/works/github.com/sunakan/my-settings/claudecode/skills/gen-claude-skill/SKILL.md

## 総評

`claudecode/skills/<name>/SKILL.md` を新規作成しベスプラ準拠を確認するスキル。対話フロー主体の設計が明確で、`allowed-tools`・`argument-hint`・`context: fork` なしのコメントが適切に揃っている。80行とコンパクトで問題点はなし。

## ✅ 良い点

- `context: fork` を付けない理由が frontmatter コメント（L7）に明記されている。チェック [1] の `context` 判定は (B)「ユーザーとの対話フローが主目的」に該当し、現在の設定が正しい
- `allowed-tools: Read Write Edit Bash(find *) Bash(ls *) Bash(mkdir *) WebSearch WebFetch`（L5）と最小権限。過剰な `Bash` 全体許可なし（チェック [4] 過剰許可なし）
- `argument-hint: "[skill name or topic]"`（L6）があり、引数の使い方が明示されている
- frontmatter フィールド順のルール（L18-L20）が明記されており、生成するスキルの品質も担保される
- 各フィールドの注意点（L23-L30）が具体的で、`disable-model-invocation` の挙動の注意（description が context にロードされない）まで明記されている
- Step 5 のベスプラレビュー8観点（L68-L78）が表形式で整理されており機械的にチェックできる
- Step 4 で `mkdir -p claudecode/skills/<name>` を明記しており、ディレクトリ作成漏れを防いでいる
- 80行で500行制限を大幅に下回り、supporting files への分割は不要
- 完了後に `/review-claude-skills <name>` の実行を提案する流れ（L80）で品質確認サイクルが閉じている

## ⚠️ 改善提案（任意対応）

- **`disable-model-invocation` なし**: `gen-claude-rule` と同様に対話フロー主体で保護としてユーザー確認フローがあるため現状で許容範囲。ただし新規ファイル作成（Write）を含むため、誤呼び出しリスクを嫌う場合は `disable-model-invocation: true` を検討

## ❌ 問題点（要修正）

なし

## 修正後の frontmatter サンプル（変更がある場合のみ）

変更不要
