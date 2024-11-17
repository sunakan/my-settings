#!/bin/bash

mkdir -p ~/.config/mise/
[ ! -f ~/.config/mise/config.toml ] && ln -s $(pwd)/mise/config.toml ~/.config/mise/config.toml
ls -lh ~/.config/mise/config.toml

mkdir -p ~/.config/wezterm/
[ ! -f ~/.config/wezterm/wezterm.lua ] && ln -s $(pwd)/wezterm/wezterm.lua ~/.config/wezterm/wezterm.lua
ls -lh ~/.config/wezterm/wezterm.lua
