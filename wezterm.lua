local wezterm = require("wezterm")
local act = wezterm.action

local config = {
	font = wezterm.font_with_fallback({
		{ family = "UDEV Gothic 35NFLG", weight = "Regular", harfbuzz_features = { "calt=1", "clig=1", "liga=1" } },
	}),

	color_scheme = "nordfox",
	window_background_gradient = {
		colors = { "#11111b" },
	},

	automatically_reload_config = true,

	colors = {
		split = "#444444",
	},

	window_background_opacity = 0.75,
	macos_window_background_blur = 20,

	window_decorations = "RESIZE",
	window_frame = {
		inactive_titlebar_bg = "none",
		active_titlebar_bg = "none",
	},

	hide_tab_bar_if_only_one_tab = true,

	check_for_updates = false,

	font_size = 14.0,
	line_height = 1.3,
	use_ime = true,

	default_prog = { "/Users/kosudanaohiro/.nix-profile/bin/nu" },

	leader = { key = "Space", mods = "CTRL|SHIFT" },
	keys = {
		{ key = "t", mods = "ALT", action = act({ SpawnTab = "CurrentPaneDomain" }) },
		{ key = "h", mods = "ALT", action = act({ ActivateTabRelative = -1 }) },
		{ key = "l", mods = "ALT", action = act({ ActivateTabRelative = 1 }) },
		{ key = "h", mods = "ALT|CTRL", action = act({ MoveTabRelative = -1 }) },
		{ key = "l", mods = "ALT|CTRL", action = act({ MoveTabRelative = 1 }) },

		-- Pane
		{ key = ",", mods = "ALT", action = act({ SplitVertical = { domain = "CurrentPaneDomain" } }) },
		{ key = ".", mods = "ALT", action = act({ SplitHorizontal = { domain = "CurrentPaneDomain" } }) },
		{ key = "h", mods = "ALT|SHIFT", action = act({ ActivatePaneDirection = "Left" }) },
		{ key = "l", mods = "ALT|SHIFT", action = act({ ActivatePaneDirection = "Right" }) },
		{ key = "j", mods = "ALT|SHIFT", action = act({ ActivatePaneDirection = "Down" }) },
		{ key = "k", mods = "ALT|SHIFT", action = act({ ActivatePaneDirection = "Up" }) },
		{ key = "LeftArrow", mods = "ALT", action = act({ AdjustPaneSize = { "Left", 1 } }) },
		{ key = "RightArrow", mods = "ALT", action = act({ AdjustPaneSize = { "Right", 1 } }) },
		{ key = "UpArrow", mods = "ALT", action = act({ AdjustPaneSize = { "Up", 1 } }) },
		{ key = "DownArrow", mods = "ALT", action = act({ AdjustPaneSize = { "Down", 1 } }) },

		-- Copy / Search
		{ key = "/", mods = "ALT", action = act.Search("CurrentSelectionOrEmptyString") },
		{
			key = "v",
			mods = "ALT",
			action = act.Multiple({ act.CopyMode("ClearSelectionMode"), act.ActivateCopyMode, act.ClearSelection }),
		},
		{ key = "c", mods = "SUPER", action = act({ CopyTo = "Clipboard" }) },
		{ key = "v", mods = "SUPER", action = act({ PasteFrom = "Clipboard" }) },

		-- Zoom
		{ key = "=", mods = "CTRL", action = "ResetFontSize" },
		{ key = "+", mods = "CTRL|SHIFT", action = "IncreaseFontSize" },
		{ key = "-", mods = "CTRL", action = "DecreaseFontSize" },

		-- Scroll
		{ key = "u", mods = "ALT|SHIFT", action = act({ ScrollByPage = -0.2 }) },
		{ key = "d", mods = "ALT|SHIFT", action = act({ ScrollByPage = 0.2 }) },

		-- Close
		{ key = "x", mods = "ALT", action = act({ CloseCurrentPane = { confirm = true } }) },

		{ key = "f", mods = "ALT", action = act.ToggleFullScreen },

		-- Tab
		{
			key = "e",
			mods = "ALT",
			action = act.PromptInputLine({
				description = "Tab name:",
				action = wezterm.action_callback(function(window, _, line)
					if line then
						window:active_tab():set_title(line)
					end
				end),
			}),
		},
	},
	key_tables = {
		copy_mode = {
			{
				key = "Escape",
				mods = "NONE",
				action = act.Multiple({
					act.ClearSelection,
					act.CopyMode("ClearPattern"),
					act.CopyMode("Close"),
				}),
			},
			-- move cursor
			{ key = "h", mods = "NONE", action = act.CopyMode("MoveLeft") },
			{ key = "j", mods = "NONE", action = act.CopyMode("MoveDown") },
			{ key = "k", mods = "NONE", action = act.CopyMode("MoveUp") },
			{ key = "l", mods = "NONE", action = act.CopyMode("MoveRight") },
			-- move word
			{ key = "w", mods = "NONE", action = act.CopyMode("MoveForwardWord") },
			{ key = "b", mods = "NONE", action = act.CopyMode("MoveBackwardWord") },
			{
				key = "e",
				mods = "NONE",
				action = act({
					Multiple = {
						act.CopyMode("MoveRight"),
						act.CopyMode("MoveForwardWord"),
						act.CopyMode("MoveLeft"),
					},
				}),
			},
			-- move start/end
			{ key = "0", mods = "NONE", action = act.CopyMode("MoveToStartOfLine") },
			{ key = "$", mods = "SHIFT", action = act.CopyMode("MoveToEndOfLineContent") },
			{ key = "$", mods = "NONE", action = act.CopyMode("MoveToEndOfLineContent") },
			-- select
			{ key = "v", mods = "NONE", action = act.CopyMode({ SetSelectionMode = "Cell" }) },
			{
				key = "v",
				mods = "SHIFT",
				action = act({
					Multiple = {
						act.CopyMode("MoveToStartOfLineContent"),
						act.CopyMode({ SetSelectionMode = "Cell" }),
						act.CopyMode("MoveToEndOfLineContent"),
					},
				}),
			},
			-- copy
			{
				key = "y",
				mods = "NONE",
				action = act({
					Multiple = {
						act({ CopyTo = "ClipboardAndPrimarySelection" }),
						act.CopyMode("Close"),
					},
				}),
			},
			{
				key = "y",
				mods = "SHIFT",
				action = act({
					Multiple = {
						act.CopyMode({ SetSelectionMode = "Cell" }),
						act.CopyMode("MoveToEndOfLineContent"),
						act({ CopyTo = "ClipboardAndPrimarySelection" }),
						act.CopyMode("Close"),
					},
				}),
			},
			-- scroll
			{ key = "G", mods = "NONE", action = act.CopyMode("MoveToScrollbackBottom") },
			{ key = "g", mods = "NONE", action = act.CopyMode("MoveToScrollbackTop") },
			{ key = "H", mods = "NONE", action = act.CopyMode("MoveToViewportTop") },
			{ key = "H", mods = "SHIFT", action = act.CopyMode("MoveToViewportTop") },
			{ key = "M", mods = "NONE", action = act.CopyMode("MoveToViewportMiddle") },
			{ key = "M", mods = "SHIFT", action = act.CopyMode("MoveToViewportMiddle") },
			{ key = "L", mods = "NONE", action = act.CopyMode("MoveToViewportBottom") },
			{ key = "L", mods = "SHIFT", action = act.CopyMode("MoveToViewportBottom") },
			{
				key = "Enter",
				mods = "NONE",
				action = act.CopyMode("ClearSelectionMode"),
			},
			-- search
			{ key = "/", mods = "NONE", action = act.Search("CurrentSelectionOrEmptyString") },
		},
		search_mode = {
			{ key = "Escape", mods = "NONE", action = act.CopyMode("Close") },
			{
				key = "Enter",
				mods = "NONE",
				action = act.Multiple({
					act.CopyMode("ClearSelectionMode"),
					act.ActivateCopyMode,
				}),
			},
			{ key = "/", mods = "NONE", action = act.CopyMode("ClearPattern") },
		},
	},
	mouse_bindings = {
		{
			event = { Up = { streak = 1, button = "Left" } },
			mods = "NONE",
			action = act({ CompleteSelection = "PrimarySelection" }),
		},
		{
			event = { Up = { streak = 1, button = "Right" } },
			mods = "NONE",
			action = act({ CompleteSelection = "Clipboard" }),
		},
		{
			event = { Up = { streak = 1, button = "Left" } },
			mods = "CTRL",
			action = "OpenLinkAtMouseCursor",
		},
	},
}

return config
