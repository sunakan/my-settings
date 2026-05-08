---
name: review-compose
description: Reviews and auto-fixes a Docker Compose file (compose.yaml or compose.yml) against the latest best practices. Searches the web for current Docker Compose guidelines, identifies all issues in the given file, applies fixes automatically with Edit, and repeats until no issues remain. Accepts a file path as an argument.
when_to_use: When the user wants to review or improve a Docker Compose file for best practices. Triggered by "compose.yaml をレビューしたい", "compose.yml を修正してほしい", "/review-compose <path>".
allowed-tools: WebSearch, Read, Edit, Bash
argument-hint: <path-to-compose-yaml>
# context: fork は付けない — 修正ループと完了サマリを会話に返すため
# disable-model-invocation: 付けない — 自動修正だが破壊的ではなく手動起動限定でもない
---

## 処理フロー

### Step 1: ベスプラ収集

WebSearch で以下を調査する（毎回実行）:

- Docker Compose 公式ドキュメントの最新ベストプラクティス
- Compose V2 での変更点・非推奨項目
- セキュリティ・パフォーマンスに関する推奨設定

### Step 2: ファイル読み込み

`$ARGUMENTS` のパスを Read して現状を把握する。
ファイルが存在しない場合はエラーを報告して終了する。

### Step 3: レビュー & 修正ループ

以下の観点で問題を特定し、Edit で自動修正する。
修正後に再 Read して残課題がないか確認し、なくなるまで繰り返す。

**レビュー観点**

| 観点 | 確認内容 |
|---|---|
| `version` フィールド | Compose V2 では obsolete — 削除する |
| イメージタグ | `latest` は禁止 — 具体的なバージョンに固定 |
| `restart` ポリシー | `unless-stopped` または `on-failure` を推奨 |
| `healthcheck` | 全サービスに設定されているか |
| 機密情報 | 環境変数の直書きを避け `secrets` または `.env` を使う |
| `depends_on` | `condition: service_healthy` で依存順序を保証 |
| ネットワーク | デフォルトネットワーク依存を避け named network を明示 |
| ボリューム | named volume を使い匿名ボリュームを避ける |
| リソース制限 | `deploy.resources.limits` で CPU/memory を設定 |
| ロギング | `logging.driver` と `options` を設定 |
| ポート公開 | 不必要な `ports` 公開を避け内部通信は `expose` で |
| 環境変数ファイル | `env_file` を活用してインラインを減らす |

### Step 4: 構文検証

```bash
docker compose -f <path> config --quiet
```

エラーがあれば修正して再検証する。`docker` コマンドがない場合はスキップ。

### Step 5: 完了報告

修正内容を箇条書きでサマリとして会話に出力する。
修正が不要だった場合は「問題なし」と報告する。

## 注意事項

- ユーザーの承認なしで Edit を適用してよい（`$ARGUMENTS` で指定したファイルのみ）
- WebSearch で得た最新情報がレビュー観点と矛盾する場合は最新情報を優先する
- Compose V2 (`docker compose`) と V1 (`docker-compose`) で推奨が異なる場合は V2 を基準にする
