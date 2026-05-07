#!/bin/bash

safe_link() {
  local src="$1"
  local dst="$2"

  if [ -L "$dst" ] || [ -e "$dst" ]; then
    [ ! -L "$dst" ] && echo "WARNING: $dst is a regular file, skipping"
    return
  fi

  mkdir -p "$(dirname "$dst")"
  ln -s "$src" "$dst"
}

LINKS=(
  "$(pwd)/mise/config.toml:$HOME/.config/mise/config.toml"
  "$(pwd)/wezterm/wezterm.lua:$HOME/.config/wezterm/wezterm.lua"
  "$(pwd)/lazygit/config.yml:$HOME/.config/lazygit/config.yml"
  "$(pwd)/git/ignore:$HOME/.config/git/ignore"
  "$(pwd)/tmux/tmux.conf:$HOME/.config/tmux/tmux.conf"
  "$(pwd)/nvim/lua/config/options.lua:$HOME/.config/nvim/lua/config/options.lua"
  "$(pwd)/global-personal-claudecode/hooks:$HOME/.claude/hooks"
  "$(pwd)/global-personal-claudecode/rules:$HOME/.claude/rules"
  "$(pwd)/global-personal-claudecode/settings.json:$HOME/.claude/settings.json"
  "$(pwd)/global-personal-claudecode/skills:$HOME/.claude/skills"
  "$(pwd)/global-personal-claudecode/CLAUDE.md:$HOME/.claude/CLAUDE.md"
)

for entry in "${LINKS[@]}"; do
  src="${entry%%:*}"
  dst="${entry##*:}"
  safe_link "$src" "$dst"
done

echo ""
echo "=== symlink status ==="
for entry in "${LINKS[@]}"; do
  dst="${entry##*:}"
  if [ -L "$dst" ]; then
    echo "  OK       $dst -> $(readlink "$dst")"
  elif [ -e "$dst" ]; then
    echo "  WARNING  $dst (regular file)"
  else
    echo "  MISSING  $dst"
  fi
done
