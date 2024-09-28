local wezterm = require("wezterm")
local keybinds = require("keybinds")
local scheme = wezterm.get_builtin_color_schemes()["nord"]
require("on")

local config = {
	font = wezterm.font_with_fallback({
		{ family = "JetBrainsMono Nerd Font" },
		{ family = "YuGothic" },
	}),
	font_size = 21.0,
	check_for_updates = false,
	use_ime = true,
	use_dead_keys = false,
	animation_fps = 1,
	cursor_blink_rate = 0,
	color_scheme = "nordfox",
	adjust_window_size_when_changing_font_size = false,
	use_fancy_tab_bar = false,
	colors = {
		tab_bar = {
			background = scheme.background,
			new_tab = { bg_color = "#2e3440", fg_color = scheme.ansi[8], intensity = "Bold" },
			new_tab_hover = { bg_color = scheme.ansi[1], fg_color = scheme.brights[8], intensity = "Bold" },
		},
	},
	-- https://github.com/wez/wezterm/issues/4030
	exit_behavior = "CloseOnCleanExit",
	window_close_confirmation = "AlwaysPrompt",
	disable_default_key_bindings = true,
	enable_csi_u_key_encoding = true,
	leader = { key = "Space", mods = "CTRL|SHIFT" },
	keys = keybinds.default_keybinds,
	key_tables = keybinds.key_tables,
	mouse_bindings = keybinds.mouse_bindings,
}

return config
