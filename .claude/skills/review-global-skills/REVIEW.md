# REVIEW: review-global-skills

> レビュー日時: 2026-05-07
> ファイル: .claude/skills/review-global-skills/SKILL.md

## 総評
全スキルを並列レビューするオーケストレータスキル。71行と簡潔にまとまっており、frontmatter・フォールバック・並列起動の明示・subagent type がすべて適切に設定されている。軽微な二重定義の問題のみで、全体的に品質は高い。

## ✅ 良い点
- `context: fork` が設定されており、メインコンテキストを汚染しない
- `allowed-tools` が `Bash(ls *)` `Bash(find *)` と絞られており過剰許可がない
- Step 2 で「1 つのメッセージ内に全て並べて起動する」と並列起動を明示
- サブ Agent に `general-purpose` を指定（書き込みあり）
- Step 1 に 0件フォールバックあり
- サブ Agent プロンプトに `review-skills/SKILL.md` が見つからない場合のフォールバックあり

## ⚠️ 改善提案（任意対応）
- **出力フォーマットの二重定義**: サブ Agent プロンプト内に出力フォーマットを直書きしているが、「レビュー基準は `review-skills/SKILL.md` を読め」と既に指示しているので、フォーマットも同ファイルに委ねれば `review-skills/SKILL.md` 変更時に自動追従できる。現状は両者が乖離するリスクがある

  改善案: サブ Agent プロンプトの出力フォーマットセクションを削除し、以下に差し替える:
  ```
  **出力フォーマット**: `review-skills/SKILL.md` の「書き込むフォーマット」セクションに従い、
  `claudecode/skills/<name>/REVIEW.md` に書き出す（既存ファイルは上書き）。
  ```

## ❌ 問題点（要修正）
なし
