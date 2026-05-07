# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

macOS (Apple Silicon) 向けの個人設定ファイル管理リポジトリ。`setup.sh` でリポジトリ内の設定ファイルを `~/.config/` および `~/.claude/` へシンボリックリンクとして展開する。

## セットアップ

```shell
# シンボリックリンクを作成（既存リンクはスキップ）
bash setup.sh
```

## よく使うコマンド

```shell
mise install          # ツールのインストール
mise prune            # 不要バージョンの削除
mise ls-remote <tool> # インストール可能なバージョン確認
brew bundle           # Homebrew パッケージの同期
```

## シンボリックリンク対応

`setup.sh` の `LINKS` 配列で管理（`src:dst`）。新しいリンクは配列に追加する。

| リポジトリ内パス | リンク先 |
|---|---|
| `mise/config.toml` | `~/.config/mise/config.toml` |
| `wezterm/wezterm.lua` | `~/.config/wezterm/wezterm.lua` |
| `lazygit/config.yml` | `~/.config/lazygit/config.yml` |
| `git/ignore` | `~/.config/git/ignore` |
| `tmux/tmux.conf` | `~/.config/tmux/tmux.conf` |
| `nvim/lua/config/options.lua` | `~/.config/nvim/lua/config/options.lua` |
| `claudecode/hooks` | `~/.claude/hooks` |
| `claudecode/rules` | `~/.claude/rules` |
| `claudecode/settings.json` | `~/.claude/settings.json` |
| `claudecode/skills` | `~/.claude/skills` |

`zshrc` はリンク対象外（手動リンクが必要）。

## claudecode/

Claude Code のグローバル設定を管理。`setup.sh` で `~/.claude/` へリンクされる。

| パス | 役割 |
|---|---|
| `settings.json` | モデル・権限・OpenTelemetry・hooks のグローバル設定 |
| `rules/*.md` | path-scoped ルール（特定ファイル編集時に自動 load） |
| `skills/<name>/SKILL.md` | カスタムスキル（1ディレクトリ = 1スキル） |
| `hooks/block-sensitive-files.sh` | PreToolUse hook でセンシティブファイルへの Bash アクセスをブロック |

新しいスキルを作成したら必ず `/review-claude-skills` を実行してベスプラ準拠を確認する。

## mise の特記事項

- macOS ARM 専用バイナリ（`cage`, `profilecli`）は `[tools."http:xxx"]` ブロックで URL と checksum を直接指定している
- `idiomatic_version_file_enable_tools = ["go"]` により `.go-version` ファイルが自動認識される

## Brewfile の注意点

- `awscli` は mise でインストールすると CPU type エラーが出るため brew で管理
- `orbstack` を Docker Desktop の代替として使用（`docker context use orbstack`）
- `mysql-client@8.4` と `zstd` は mysql2 gem のビルドに必要
