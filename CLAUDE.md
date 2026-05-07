# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

macOS (Apple Silicon) 向けの個人設定ファイル管理リポジトリ。`setup.sh` でリポジトリ内の設定ファイルを `~/.config/` へシンボリックリンクとして展開する。

## セットアップ

```shell
# シンボリックリンクを作成（既存リンクはスキップ）
bash setup.sh
```

## よく使うコマンド

```shell
# ツールのインストール
mise install

# 不要バージョンの削除
mise prune

# インストール可能なバージョン確認
mise ls-remote <tool>        # 例: mise ls-remote ruby
mise ls-remote --all

# Homebrew パッケージの同期
brew bundle
```

## 構成

| ファイル/ディレクトリ | リンク先 | 内容 |
|---|---|---|
| `mise/config.toml` | `~/.config/mise/config.toml` | ツールバージョン管理 |
| `wezterm/wezterm.lua` | `~/.config/wezterm/wezterm.lua` | ターミナル設定 |
| `lazygit/config.yml` | `~/.config/lazygit/config.yml` | lazygit 設定 |
| `git/ignore` | `~/.config/git/ignore` | グローバル gitignore |
| `tmux/tmux.conf` | `~/.config/tmux/tmux.conf` | tmux 設定 |
| `nvim/` | `~/.config/nvim/` | AstroNvim 設定（一部のみ） |
| `zshrc` | （手動リンク）| zsh 設定 |
| `Brewfile` | — | Homebrew パッケージ一覧 |

## mise の特記事項

- macOS ARM 専用バイナリが必要なツール（`cage`, `profilecli`）は `[tools."http:xxx"]` ブロックで URL と checksum を直接指定している
- `experimental = true` は不要（go backend を使うときのみ必要だったが、http backend に移行済み）
- `idiomatic_version_file_enable_tools = ["go"]` により `.go-version` ファイルが自動認識される

## Brewfile の注意点

- `awscli` は mise/asdf でインストールすると CPU type エラーが出るため brew で管理
- `orbstack` を Docker Desktop の代替として使用（`docker context use orbstack`）
- `mysql-client@8.4` と `zstd` は mysql2 gem のビルドに必要
