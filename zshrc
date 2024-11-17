#
# autoload -Uz vcs_info
#
# autoload: zshの組み込みコマンド、指定された関数をロードする
# -U: 関数をロード時にエイリアスの展開を無効。関数名が誤って解釈されるのを防ぐ
# -z: 関数をzshネイティブモードでロードする
# vcs_info: VCSの情報を取得できる
autoload -Uz vcs_info

#
# zstyle ':vcs_info:git:*' check-for-changes true
# zstyle ':vcs_info:git:*' unstagedstr '!'
# zstyle ':vcs_info:git:*' stagedstr '+'
#
# zstyleコマンド: vcs_infoの出力フォーマットの設定
# ':vcs_info:git:*': gitの全ての操作に適用される
# check-for-changes true: リポジトリ内の変更をチェックする(true)
#
# unstagedstr '!': stagingされていない変更がある場合は'!'を表示
# stagedstr '+': stagingされている変更がある場合は'+'を表示
#
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' unstagedstr '!'
zstyle ':vcs_info:git:*' stagedstr '+'

#
# zstyle ':vcs_info:*' formats '%c%u[%b]'
# zstyle ':vcs_info:*' actionformats '%c%u[%b|%a]'
#
# zstyleコマンド: vcs_infoの出力フォーマットの設定
# ':vcs_info:*': 全てのVCS(Git,Mercurial等)に対して適用
# formats: 通常の状態（rebaseやmergeなどの特別な操作を行っていない状態）でのフォーマットを設定
# actionformats: 特別な操作（rebaseやmergeなど）を行っている際のフォーマットを設定します。
# - %c: stagingされた変更の有無(上述の `+`)
# - %u: stagingされていない変更の有無(上述の `!`)
# - %b: 現在のブランチ名
# - %a: 現在の操作(rebase, merge)
# +!()
zstyle ':vcs_info:*' formats '%c%u[%b]'
zstyle ':vcs_info:*' actionformats '%c%u[%b|%a]'


#
# 現在のパス_______:git情報:JST日時:UTC日時
#
# precmd () {...}
# zshのフック関数で、プロンプトが表示される直前に実行
precmd() {
  # 1行目プロンプトの右側
  local last_exit_code=$?
  vcs_info
  local vcs_info=${vcs_info_msg_0_:-(no branch)}
  local current_time=$(date -u '+%Y-%m-%d %H:%M:%S')
  local right="${vcs_info} %F{green}${current_time}(UTC) %F{yellow}last_exit:${last_exit_code}%f"

  # 1行目プロンプトの左側
  # %~: ホームディレクトリからの相対パス
  # %F{cyan}: cyan色
  # %f: 色のリセット
  local left="%F{cyan}%~%f"

  # スペースの長さを計算
  # テキストを装飾する場合、エスケープシーケンスをカウントしない
  local invisible='%([BSUbfksu]|([FK]|){*})'
  local leftwidth=${#${(S%%)left//$~invisible/}}
  local rightwidth=${#${(S%%)right//$~invisible/}}
  local padwidth=$(($COLUMNS - ($leftwidth + $rightwidth) % $COLUMNS))

  # $left と $right の間をスペースで埋めて表示
  # %Uで下線付きにする
  print -P $left%U${(r:$padwidth:: :)}$right
}
PROMPT="$ "
