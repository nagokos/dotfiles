local wezterm = require("wezterm")
local keybinds = require("keybinds")

local config = {
	font = wezterm.font_with_fallback({
		{ family = "JetBrainsMono Nerd Font" },
		{ family = "YuGothic" },
	}),
	font_size = 21.0,
	color_scheme = "nordfox",

	window_frame = {
		font_size = 19,
	},
	window_decorations = "RESIZE",

	check_for_updates = false,
	use_ime = true,
	use_dead_keys = false,
	animation_fps = 1,
	cursor_blink_rate = 0,
	adjust_window_size_when_changing_font_size = false,

	exit_behavior = "CloseOnCleanExit",
	window_close_confirmation = "AlwaysPrompt",

	disable_default_key_bindings = true,
	enable_csi_u_key_encoding = true,

	leader = { key = "Space", mods = "CTRL|SHIFT" },
	keys = keybinds.default_keybinds,
	key_tables = keybinds.key_tables,
	mouse_bindings = keybinds.mouse_bindings,
	front_end = "WebGpu",
}

return config
