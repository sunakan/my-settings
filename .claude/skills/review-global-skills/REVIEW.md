# REVIEW: review-global-skills

> レビュー日時: 2026-05-07
> ファイル: claudecode/skills/review-global-skills/SKILL.md

## 総評
全スキルを並列レビューするオーケストレータスキル。67行と簡潔で `context: fork`・並列起動明示・0件フォールバック・TODO追記フローも含む完成度の高い設計。`allowed-tools` の絞り込みや Why-not コメントなど品質指標も満たしており、現時点で問題点は見当たらない。

## ✅ 良い点
- `context: fork` が設定されており、メインコンテキストを汚染しない
- `allowed-tools` が `Bash(ls *)` `Bash(find claudecode/skills/*)` と絞られており過剰許可がない（`Bash` 全体許可ではない）
- Step 2 で「1 つのメッセージ内に全て並べて起動する」と並列起動を明示している
- `agent` を省略（書き込みあるため `general-purpose` がデフォルト = 正しい）
- Step 1 に 0 件フォールバックがある
- サブ Agent プロンプト内に `review-skills/SKILL.md` が見つからない場合のフォールバックがある
- git 操作禁止の制約が明記されている
- `# サブ Agent プロンプトは外部参照（review-skills/SKILL.md）— 単一ソース維持のため inline 化しない` と Why-not コメントが付いている
- Step 3 に ❌ 問題点スキルへの修正確認と ⚠️ 改善提案の TODO.md 追記フローの両方が含まれている
- `description` + `when_to_use` の合計が約349文字で1,536文字制限内に収まっている

## ⚠️ 改善提案（任意対応）
なし

## ❌ 問題点（要修正）
なし
