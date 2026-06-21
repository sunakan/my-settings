# REVIEW: gen-claude-rule

> レビュー日時: 2026-06-13
> ファイル: /Users/user01/works/github.com/sunakan/my-settings/claudecode/skills/gen-claude-rule/SKILL.md

## 総評

`claudecode/rules/` に path-scoped rule ファイルを新規作成しベスプラ準拠を確認するスキル。`allowed-tools`・`argument-hint`・`context: fork` なしコメントが適切で、対話フロー主体の設計が明確。66行とコンパクトで問題点はないが、`disable-model-invocation` の欠如は設計上の判断として許容範囲。

## ✅ 良い点

- `context: fork` を付けない理由が frontmatter コメント（L7）に明記されている。チェック [1] の `context` 判定は (B)「ユーザーとの対話フローが主目的」に該当し、現在の設定が正しい
- `allowed-tools: Read Write Edit Bash(find *) Bash(ls *) WebSearch WebFetch`（L5）と最小権限。過剰な `Bash` 全体許可なし（チェック [4] 過剰許可なし）
- `argument-hint: "[rule name or topic]"`（L6）があり、引数の使い方が明示されている
- Step 5 のベスプラレビュー基準（L54-L65）が9観点で表形式にまとまっており機械的にチェックできる
- glob が実ファイルにマッチするか `find` で確認する手順（観点2）が具体的に指示されている
- Step 3 で既に分かっている情報はスキップするという柔軟なヒアリング設計（L36）
- CLAUDE.md との重複排除（観点8）が観点に含まれており、ルールファイルの品質担保が設計に組み込まれている
- 66行で500行制限を大幅に下回り、supporting files への分割は不要
- 命令形で記述されており説明文的な箇所がない

## ⚠️ 改善提案（任意対応）

- **`disable-model-invocation` なし**: このスキルは対話フロー主体で破壊的操作（ファイル作成は Write だが既存ファイルを上書きするリスクあり）を含む。ただし「新規作成」スキルとしての性質上、ユーザー確認フロー（Step 4 末尾）が保護として機能しているため、現状でも許容範囲。破壊的操作保護を強化したい場合は `disable-model-invocation: true` を付けることを検討

## ❌ 問題点（要修正）

なし

## 修正後の frontmatter サンプル（変更がある場合のみ）

変更不要
