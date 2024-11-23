#
# Default
#
tap "homebrew/bundle"

#
# font-hackgen-nerd
#
# URL
# - https://formulae.brew.sh/cask/font-hackgen-nerd
# GitHub
# - https://github.com/yuru7/HackGen
#
# 概要
# - プログラミング用フォント
cask "font-hackgen-nerd"

#
# Vagrant
#
# URL
# - https://formulae.brew.sh/cask/vagrant
# GitHub
#
cask "vagrant"

#
# git
#
# URL
# - https://formulae.brew.sh/formula/git#default
#
# 概要
# - バージョン管理ツール
# - brewで入れるとcredential-osxkeychain が最初から入っている
#   - クレデンシャルをoskeychainで管理可能
# - 例: git version 2.39.5 (Apple Git-154) → git version 2.47.0
#
brew "git"

#
# neovim
#
# URL
# - https://formulae.brew.sh/formula/neovim#default
#
# 概要
# - エディタ
#
brew "neovim"

#
# mise
#
# URL
# - https://formulae.brew.sh/formula/mise
#
# 概要
# - 次世代asdf
# - asdfの資産が利用可能
brew "mise"

#
# libyaml
#
# URL
# - https://formulae.brew.sh/formula/libyaml
#
# 概要
# - rubyをインストールするのに必要
#
brew "libyaml"

#
# awscli
#
# URL
# - https://formulae.brew.sh/formula/awscli
#
# 概要
# - mise/asdfでインストールした時
#   - zsh: bad CPU type in executable: aws
#   - みたいなエラーが出るため、brewで入れる
brew "awscli"

#
# docker desktop
#
# URL
# - https://formulae.brew.sh/cask/docker
#
# 概要
# - docker
# docker context use desktop-linux
# docker buildx ls --no-trunc
cask "docker"

#
# orbstack
#
# URL
# - https://formulae.brew.sh/cask/orbstack
#
# 概要
# - docker desktopの代替
#     - https://orbstack.dev/
# docker context use orbstack
# docker buildx ls --no-trunc
# - https://github.com/orbstack/orbstack/issues/1457
# にて、linux/amd64/v2をサポートできてないらしい → MySQLなどがうまく動かない
cask "orbstack"

#
# mysql-client
#
# URL
# - https://formulae.brew.sh/formula/mysql-client@8.4
#
# 概要
# - MySQLのクライアント
brew "mysql-client@8.4"

#
# zstd
#
# URL
# - https://formulae.brew.sh/formula/zstd
#
# 概要
# - Zstandard(zstd)
# - 可逆圧縮アルゴリズム
# - mysql-client@8.4を利用して、mysql2 gemをビルドするのに必要
brew "zstd"

#
# gdu
#
# URL
# - https://formulae.brew.sh/formula/gdu
#
# 概要
# - go DiskUsage()
#   - Goで記述された高速なディスク使用量分析ツール
# - https://github.com/dundee/gdu
# - AstroNvimのために導入
brew "gdu"
