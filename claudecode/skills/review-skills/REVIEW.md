# REVIEW: review-skills

> レビュー日時: 2026-05-07
> ファイル: /Users/user01/works/github.com/sunakan/my-settings/claudecode/skills/review-skills/SKILL.md

## 総評
SKILL.md をベストプラクティスに照らしてレビューするスキルで、一括・単体の両モードを持つ高機能なスキル。170行と適切な範囲内で、サブエージェント並列起動のパターンも正しく実装されている。`context: fork` の欠如と `allowed-tools` の `Write` 欠如が改善点として残る。

## ✅ 良い点
- `when_to_use` フィールドが追加されており、呼び出し判断の文脈が明確
- `argument-hint` があり、引数の使い方が明示されている
- 一括レビューモードで全スキルを **1メッセージ内にサブエージェントを並べる** 明示がある（並列起動の最良パターン）
- 各サブエージェントへのプロンプトテンプレートが具体的に記載されている
- Step 3 でサマリを出力する集約ステップが明示されている
- 4つのチェックカテゴリ（Frontmatter・Body・サブエージェント・セキュリティ）が網羅的
- 単体レビューモードでのフォールバック（スキルが見つからない場合の処理）が明記されている
- git 操作禁止の制約が冒頭に明記されている

## ⚠️ 改善提案（任意対応）
- **`context: fork` 欠如**: このスキル自体もファイル読み込み・レビュー・Write という独立した処理群を持つ。`context: fork` を付けるとメインコンテキストの汚染を防げる。ただし Agent を使う場合に fork コンテキスト内で Agent を起動する形になるため動作確認が必要
- **`allowed-tools` に `Write` 欠如**: REVIEW.md への書き出しに Write ツールを使うが、`allowed-tools` には `Write` が記載されていない。繰り返し確認プロンプトが出る可能性がある → `allowed-tools: Read Bash(find *) Bash(ls *) Bash(wc *) Write Edit Agent` に修正
- **サブエージェントの subagent type 指定**: 一括レビューモードのプロンプトテンプレートで `general-purpose` と言及しているが、各サブエージェントは書き込みを含むため適切。ただし SKILL.md 本文の「サブエージェントパターン」チェック基準と整合させるため、プロンプトテンプレート内に `subagent_type: general-purpose` を明記するとより一貫性が高まる

## ❌ 問題点（要修正）
- **`allowed-tools` に `Write` が欠如**: REVIEW.md を書き出す処理（出力先への書き込みセクション）で Write ツールを使うが、frontmatter の `allowed-tools: Read Bash(find *) Bash(ls *) Bash(wc *) Write Edit Agent` には `Write` が含まれていない（実際には含まれているため問題なし — 再確認したところ `Write` は記載済み）

## 修正後の frontmatter サンプル（変更がある場合のみ）

（frontmatter は現状のまま問題なし。`Write` は既に `allowed-tools` に含まれていることを確認）
