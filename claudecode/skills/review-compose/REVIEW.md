# REVIEW: review-compose

> レビュー日時: 2026-06-13
> ファイル: /Users/user01/works/github.com/sunakan/my-settings/claudecode/skills/review-compose/SKILL.md

## 総評

Docker Compose ファイルをベストプラクティスに照らして自動修正するスキルで、WebSearch による最新情報取得・修正ループ・構文検証・完了報告が整理されている。65行とコンパクト。`allowed-tools` の `Bash` 全体許可が過剰許可の問題点として指摘に値する。

## ✅ 良い点

- `context: fork` を付けない理由が frontmatter コメント（L7）に明記されている。チェック [1] の `context` 判定は (B)「修正ループと完了サマリを会話に返すため」に該当し、現在の設定が正しい
- `disable-model-invocation` を付けない理由もコメント（L8）で明記されており、設計判断が自己説明的
- `argument-hint: <path-to-compose-yaml>`（L6）があり、引数の使い方が明示されている
- WebSearch で毎回最新のベストプラクティスを収集する設計（Step 1）で、情報の陳腐化リスクを低減している
- Step 3 の修正ループ（修正後に再 Read して残課題がなくなるまで繰り返す）が明確に指示されている
- Step 4 の構文検証（`docker compose config --quiet`）で修正後の正しさを確認する仕組みがある
- ファイルが存在しない場合のフォールバック（L23-L24）が明記されている（チェック [2] フォールバック）
- 65行で500行制限を大幅に下回り、supporting files への分割は不要
- レビュー観点（L33-L47）が12項目の表形式で整理されており網羅性が高い
- `docker` コマンドがない場合のスキップ（L54）で環境依存のエラーを防いでいる

## ⚠️ 改善提案（任意対応）

- **`$ARGUMENTS` のフォールバック**: 引数（ファイルパス）が省略された場合の対処が書かれていない。「`$ARGUMENTS` が空の場合はカレントディレクトリの `compose.yaml` または `compose.yml` を探す」か「引数が必要ですと伝えて終了する」のどちらかの挙動を明記することを検討

## ❌ 問題点（要修正）

- **`allowed-tools` の過剰許可**: `allowed-tools: WebSearch, Read, Edit, Bash`（L5）に `Bash` が全体許可になっている。Step 4 では `docker compose -f <path> config --quiet` のみ実行するため、`Bash(docker compose *)` に絞るべき（チェック [4] 過剰許可なし）

## 修正後の frontmatter サンプル（変更がある場合のみ）

```yaml
---
name: review-compose
description: Reviews and auto-fixes a Docker Compose file (compose.yaml or compose.yml) against the latest best practices. Searches the web for current Docker Compose guidelines, identifies all issues in the given file, applies fixes automatically with Edit, and repeats until no issues remain. Accepts a file path as an argument.
when_to_use: When the user wants to review or improve a Docker Compose file for best practices. Triggered by "compose.yaml をレビューしたい", "compose.yml を修正してほしい", "/review-compose <path>".
allowed-tools: WebSearch, Read, Edit, Bash(docker compose *)
argument-hint: <path-to-compose-yaml>
# context: fork は付けない — 修正ループと完了サマリを会話に返すため
# disable-model-invocation: 付けない — 自動修正だが破壊的ではなく手動起動限定でもない
---
```
