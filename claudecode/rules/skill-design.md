---
globs: .claude/skills/**/SKILL.md
description: Rules for designing and editing SKILL.md files when creating or modifying skills
---

# SKILL.md 設計ルール

## description のルール（最重要）

- **三人称で書く**（「I can...」「私が...」を避ける。システムプロンプト注入対策で公式が必須化）
- **`disable-model-invocation: true` のスキルは description が context に load されない**（自動 trigger 不可）。手動起動限定スキルでのみ使う

## CLAUDE.md と重複させない

CLAUDE.md に既に書かれている原則（CRITICAL ルール・運用方針等）は SKILL.md で繰り返さない。CLAUDE.md は常時 load なので二重管理になる。

「200 行以下」「Bloated CLAUDE.md ignore リスク」など memory ファイルの行数規律は `.claude/rules/claude-md.md` を参照（CLAUDE.md / rules / SKILL.md 共通の鉄則）。

## SKILL.md 編集後の必須アクション

SKILL.md の新規作成または編集が完了したら、**必ず `/review-claude-skills` を実行する**。

## frontmatter フィールド順

`name` → `description` → `when_to_use` → `disable-model-invocation` → `allowed-tools` → `argument-hint` → `context` → `agent` → `# コメント`

省略フィールドはスキップ。`# コメント` は「なぜそのフィールドを付けないか」の Why-not 注釈（例: `# context: fork は付けない — 対話フローが主目的のため`）。

## 自動レビューの観点

`/review-claude-skills` で機械的にチェックされる観点（8 項目）は **`.claude/skills/review-claude-skills/SKILL.md` を正本**として参照する（二重管理回避）。
