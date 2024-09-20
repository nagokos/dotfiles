local wezterm = require("wezterm")
local keybinds = require("keybinds")
local scheme = wezterm.get_builtin_color_schemes()["nord"]

local config = {
	font = wezterm.font_with_fallback({
		{ family = 'JetBrainsMono Nerd Font' },
		{ family = 'YuGothic' }
	}),
	-- harfbuzz_features = { "ss02" },
	font_size = 21.0,
	check_for_updates = false,
	use_ime = true,
	ime_preedit_rendering = "Builtin",
	use_dead_keys = false,
	warn_about_missing_glyphs = false,
	animation_fps = 1,
	cursor_blink_ease_in = "Constant",
	cursor_blink_ease_out = "Constant",
	cursor_blink_rate = 0,
	-- https://github.com/wez/wezterm/issues/1772
	-- enable_wayland = true,
	color_scheme = "nordfox",
	hide_tab_bar_if_only_one_tab = false,
	adjust_window_size_when_changing_font_size = false,
	selection_word_boundary = " \t\n{}[]()\"'`,;:│=&!%",
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
	tab_bar_at_bottom = false,
	window_close_confirmation = "AlwaysPrompt",
	disable_default_key_bindings = true,
	enable_csi_u_key_encoding = true,
	leader = { key = "Space", mods = "CTRL|SHIFT" },
	keys = keybinds.create_keybinds(),
	key_tables = keybinds.key_tables,
	mouse_bindings = keybinds.mouse_bindings,
	-- https://github.com/wez/wezterm/issues/2756
	front_end = "OpenGL",
}

return config
