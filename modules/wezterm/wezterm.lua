local wezterm = require("wezterm")
local act = wezterm.action

local config = {
	font = wezterm.font_with_fallback({
		{ family = "JetBrainsMono Nerd Font" },
		{ family = "YuGothic" },
	}),
	font_size = 13,
	color_scheme = "nightfox",

	automatically_reload_config = true,

	window_background_opacity = 0.85,
	macos_window_background_blur = 20,

	window_decorations = "RESIZE",
	window_frame = {
		font = wezterm.font({
			family = "Berkeley Mono",
			weight = "Bold",
		}),
		font_size = 15,
	},
	window_padding = {
		left = "1cell",
		right = "1cell",
		top = "1",
		bottom = "0",
	},

	show_new_tab_button_in_tab_bar = false,
	show_close_tab_button_in_tabs = false,

	default_prog = { "/Users/kosudanaohiro/.nix-profile/bin/nu" },

	check_for_updates = false,
	use_ime = true,
	use_dead_keys = false,
	animation_fps = 1,
	cursor_blink_rate = 0,
	adjust_window_size_when_changing_font_size = false,

	exit_behavior = "CloseOnCleanExit",
	window_close_confirmation = "AlwaysPrompt",

	-- https://wezterm.org/config/lua/config/skip_close_confirmation_for_processes_named.html (currentpane close confirm)
	-- skip_close_confirmation_for_processes_named

	disable_default_key_bindings = true,
	enable_csi_u_key_encoding = true,

	front_end = "WebGpu",

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
			{ key = "G", mods = "SHIFT", action = act.CopyMode("MoveToScrollbackBottom") },
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

local function segments_for_right_status()
	return {
		wezterm.strftime("%Y/%m/%d %H:%M"),
	}
end
wezterm.on("update-status", function(window, _)
	local segments = segments_for_right_status()

	local color_scheme = window:effective_config().resolved_palette
	local fg = color_scheme.foreground

	local elements = {}

	for i, seg in ipairs(segments) do
		local is_first = i == 1

		if is_first then
			table.insert(elements, { Background = { Color = "none" } })
		end

		table.insert(elements, { Foreground = { Color = fg } })
		table.insert(elements, { Background = { Color = "none" } })
		table.insert(elements, { Text = "" .. seg .. "   " })
	end

	window:set_right_status(wezterm.format(elements))
end)

wezterm.on("format-tab-title", function(tab, _, _, _, _, max_width)
	local tab_index = tab.tab_index + 1
	local title = string.format("%d: %s", tab_index, wezterm.truncate_right(tab.active_pane.title, max_width - 3))
	title = " " .. title .. " "

	return {
		{ Text = title },
	}
end)

return config
