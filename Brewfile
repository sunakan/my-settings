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
# awscli と session-manager-plugin
#
# URL
# - https://formulae.brew.sh/formula/awscli
# - https://formulae.brew.sh/cask/session-manager-plugin
#
# 概要
# - mise/asdfでインストールした時
#   - zsh: bad CPU type in executable: aws
#   - みたいなエラーが出るため、brewで入れる
# - ssm でのEC2ログイン機能は、プラグインで分離された模様
#   - aws cli v2には同梱されているとかあったが、brewで入れるとなかった
brew "awscli"
cask "session-manager-plugin"

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
#cask "docker-desktop"

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

#
# zsh-completions
#
# URL
# - https://formulae.brew.sh/formula/zsh-completions
#
# 概要
# - zshで補完を効かせるツール
# ```.zshrc
# autoload -Uz compinit
# compinit
# ```
#
# Homebrewによってインストールされたzshの共有ディレクトリに対して、グループとその他ユーザーの書き込み権限を再帰的に削除
# -R: 再帰的に
# g: グループ
# o: その他ユーザー
# -w: 書き込み権限の削除
# ```shell
# chmod -R go-w $(brew --prefix)/share/zsh/
# ````
brew "zsh-completions"

#
# percona-toolkit
#
# URL
# - https://formulae.brew.sh/formula/percona-toolkit
#
# 概要
# - MySQLの色々なツールが含まれている
# - slowqueryの分析ツールであるpt-query-digestが入っている
# - isuconで利用
brew "percona-toolkit"

#
# duckdb
#
# URL
# - https://formulae.brew.sh/formula/duckdb
#
# 概要
# - SQLite3の列指向版
# - 分析特化
# - ファイルベースで管理可能なdb
# - ファイルサイズも小さい
brew "duckdb"

#
# cirruslabs/cli/tart
#
# URL
# - https://github.com/cirruslabs/tart?tab=readme-ov-file#usage
#
# 概要
# - Mac(Arm)特化型の仮想マシンを構築できるツール
# - VirtualBoxがMac(Arm)に対応したけど、まだVagrant Box側にboxがない
# - vagrant pluginとしてvagrant-tartを作ってくれ、軽いドキュメントまであるので、Tartを利用する
#   - 作ったよというメッセージ(まだ公式には承認はされていないっぽい)
#     - https://github.com/hashicorp/vagrant/issues/12760#issuecomment-2183976588
#   - ドキュメント
#     - https://letiemble.github.io/vagrant-tart/
tap "cirruslabs/cli"
brew "cirruslabs/cli/tart"

#
# bottom
#
# URL
# - https://github.com/ClementTsang/bottom
#
# 概要
# - topコマンドの代替
#
brew "bottom"

#
# git-credential-manager
#
# URL
# - https://github.com/git-ecosystem/git-credential-manager/blob/release/docs/install.md
#
# 概要
# - gitでPATを利用せずにアクセスするためのツール
#
cask "git-credential-manager"

#
# pinact
#
# URL
# - https://formulae.brew.sh/formula/pinact
#
# 概要
# - github actionsのバージョンをpin
#
brew "pinact"

#
# gnupg
#
# URL
# - https://formulae.brew.sh/formula/pinact
#
# 概要
# - GPGキーを生成するのに利用
# - GitHubのコミットの信頼性を高めるためのやつ
#
brew "gnupg"

#
# pinentry-mac
#
# URL
# - https://formulae.brew.sh/formula/pinentry-mac
#
# 概要
# - GPGキーのパスフレーズを自動入力してくれる
#
brew "pinentry-mac"

#
# fzf
#
# URL
# - https://formulae.brew.sh/formula/fzf
#
# 概要
# - CLI用ファジー検索ツール
#
brew "fzf"

#
# fd
#
# URL
# - https://formulae.brew.sh/formula/fd
#
# 概要
# - シンプルで高速かつユーザーフレンドリーなfind file代替手段
#
brew "fd"

#
# graphviz
#
# 概要
# - pprofのWebUIで必要
#
brew "graphviz"
