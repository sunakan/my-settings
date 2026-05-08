---
globs: CLAUDE.md, AGENTS.md, .claude/rules/**/*.md, .claude/skills/**/SKILL.md
description: Editing conventions for CLAUDE.md, .claude/rules/, and .claude/skills/ files
---

# CLAUDE.md / .claude/rules/ / .claude/skills/ 編集の運用ルール

## 鉄則

- **200 行以下を維持**（[公式推奨](https://code.claude.com/docs/en/memory)：「Longer files consume more context and reduce adherence」、[best-practices](https://code.claude.com/docs/en/best-practices)：「Bloated CLAUDE.md files cause Claude to ignore your actual instructions」）。超えそうなら `.claude/rules/`（path-scoped）か `docs/` に詳細を移す
- **「Claude が自明に分かること」は書かない**（言語の構文・典型的なフレームワーク慣習・一般的なベストプラクティス等）
- **書くべきは**: ビジネス文脈・命名規則・固有のはまりどころ・チーム合意のルール・このリポジトリ特有の構造
- 各行について `"Would removing this cause Claude to make mistakes?"` で取捨選択する（公式 best-practices）
- `/init` 実行時もこのルールを優先する（網羅性より簡潔性）
