#!/bin/bash

mkdir -p ~/.config/mise/
[ ! -f ~/.config/mise/config.toml ] && ln -s $(pwd)/mise/config.toml ~/.config/mise/config.toml
ls -lh ~/.config/mise/config.toml
