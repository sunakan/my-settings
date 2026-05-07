# REVIEW: review-global-skills

> レビュー日時: 2026-05-07
> ファイル: claudecode/skills/review-global-skills/SKILL.md

## 総評
全スキルを並列レビューするオーケストレータスキル。52行と簡潔で `context: fork`・並列起動明示・0件フォールバックなど基本設計は良い。サブ Agent プロンプトが `review-skills/SKILL.md` を外部参照する設計で「単一ソース維持」のコメントが付いており設計意図は明確だが、Step 3 の確認フローが❌問題点のみに限られ⚠️改善提案の TODO 追記フローが欠落している点が改善余地として残る。

## ✅ 良い点
- `context: fork` が設定されており、メインコンテキストを汚染しない
- `allowed-tools` が `Bash(ls *)` `Bash(find *)` と絞られており過剰許可がない（`Bash` 全体許可ではない）
- Step 2 で「1 つのメッセージ内に全て並べて起動する」と並列起動を明示している
- `agent` を省略（書き込みあるため `general-purpose` がデフォルト = 正しい）
- Step 1 に 0 件フォールバックがある
- サブ Agent プロンプト内に `review-skills/SKILL.md` が見つからない場合のフォールバックがある
- git 操作禁止の制約が明記されている
- `# サブ Agent プロンプトは外部参照（review-skills/SKILL.md）— 単一ソース維持のため inline 化しない` と Why-not コメントが付いている

## ⚠️ 改善提案（任意対応）
- **Step 3 の確認フロー不足**: 現在 Step 3 には「❌ 問題点があるスキルについて確認する」のみ記載されているが、このスキル（review-skills）で定義している確認フローには⚠️改善提案を `TODO.md` に追記するかを確認するフローも含まれている。`review-global-skills` からも同様のフローを提供すると一貫性が高まる。

  改善案: Step 3 末尾に以下を追加する:
  ```
  ⚠️ 改善提案があるスキルについて「⚠️ 改善提案を TODO.md の「検討中」セクションに追記しますか？」とユーザーに確認する。承認された場合は `./TODO.md` の「検討中」セクション末尾に追記する。
  ```

- **`Bash(find *)` の許可範囲**: `find *` は任意の引数を許可する。Step 1 での使用目的は `claudecode/skills/*/SKILL.md` の確認のみなので `Bash(find claudecode/skills/*)` のように対象パスを絞るとより安全。

## ❌ 問題点（要修正）
なし
