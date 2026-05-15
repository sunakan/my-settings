local wezterm = require("wezterm")

local config = {}

-- フォント
config.font = wezterm.font("HackGen Console NF")
config.font_size = 18.0

-- フォントサイズ変更時にウィンドウサイズを変更しない
config.adjust_window_size_when_changing_font_size = false

-- デフォルトで入っているカラースキーマ
-- config.color_scheme = 'Solarized Darcula'
-- config.color_scheme = "Github (Gogh)"
-- config.color_scheme = "Github Dark (Gogh)"
config.color_scheme = "Gogh (Gogh)"

-- ビープ無効化 + ビジュアルベル
config.audible_bell = "Disabled"
config.visual_bell = {
  fade_in_function = 'EaseIn',
  fade_in_duration_ms = 10,
  fade_out_function = 'EaseOut',
  fade_out_duration_ms = 500,
}
config.colors = {
  visual_bell = '444411',
}

return config
