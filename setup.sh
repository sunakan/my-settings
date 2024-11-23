#!/bin/bash

mkdir -p ~/.config/mise/
[ ! -f ~/.config/mise/config.toml ] && ln -s $(pwd)/mise/config.toml ~/.config/mise/config.toml

mkdir -p ~/.config/wezterm/
[ ! -f ~/.config/wezterm/wezterm.lua ] && ln -s $(pwd)/wezterm/wezterm.lua ~/.config/wezterm/wezterm.lua

mkdir -p ~/.config/lazygit/
[ ! -f ~/.config/lazygit/config.yml ] && ln -s $(pwd)/lazygit/config.yml ~/.config/lazygit/config.yml

mkdir -p ~/.config/git/
[ ! -f ~/.config/git/ignore ] && ln -s $(pwd)/.config/git/ignore ~/.config/git/ignore

ls -lh ~/.config/**
