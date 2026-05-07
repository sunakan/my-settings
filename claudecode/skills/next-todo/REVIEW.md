# REVIEW: next-todo

> レビュー日時: 2026-05-07
> ファイル: claudecode/skills/next-todo/SKILL.md

## 総評
TODO.md の「検討中」セクションから次の項目を取り出して決まった形式で提示するスキル。50行とコンパクトで責務が明確。`context: fork` が設定されているが、Step 5 でユーザーに確認を求める対話フローがあるため fork との整合性に注意が必要。`allowed-tools` に `Bash(cat *)` があるが `Read` で代替可能な点が改善余地。

## ✅ 良い点
- `disable-model-invocation: true` が設定されており、意図しない自動起動を防止している
- `when_to_use` があり、呼び出し判断の文脈が明確
- TODO.md がない場合・「検討中」セクションが空の場合、2段階のフォールバックが書かれている
- 提示する5項目（現状・課題/背景・対応手段・効果・期待）が具体的に定義されている
- Step 2 で完了済み項目を実際のファイルと照合して自動削除する仕組みがある
- REVIEW.md などの参照ファイルを Read して内容を補完する指示がある（Step 4）

## ⚠️ 改善提案（任意対応）
- **`context: fork` と対話フローの整合性**: Step 5 で「進めますか？」とユーザーに確認を求めているが、`context: fork` を付けると fork コンテキスト内での出力がメイン会話に戻らない可能性がある。TODO 提示＋確認が主目的（分類: B寄り）なら `context: fork` を外すか、Step 5 の確認を fork 外に移す設計を検討すること
- **`allowed-tools: Bash(cat *)` の必要性**: `cat` で読み込む用途は `Read` ツールで代替可能。`Bash(cat *)` を削除し `Read` に統一するとツール権限をより絞り込める
- **`agent: Explore` の追加**: 主に読み取り専用（Read + Edit のみ）のスキルなので `context: fork` を維持する場合は `agent: Explore` を付けることを検討。ただし Step 2 の Edit（完了済み項目削除）があるため省略も合理的

## ❌ 問題点（要修正）

なし
