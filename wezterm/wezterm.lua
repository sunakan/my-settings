local wezterm = require 'wezterm'

local config = {}

-- フォント
config.font = wezterm.font('HackGen Console NF')
config.font_size = 18.0

-- フォントサイズ変更時にウィンドウサイズを変更しない
config.adjust_window_size_when_changing_font_size = false

-- デフォルトで入っているカラースキーマ
config.color_scheme = 'Solarized Darcula'

return config
