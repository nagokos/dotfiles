local M = {}
local wezterm = require("wezterm")
local act = wezterm.action
local utils = require("utils")

---------------------------------------------------------------
--- keybinds
---------------------------------------------------------------
M.tmux_keybinds = {
	{ key = "k", mods = "ALT",      action = act({ SpawnTab = "CurrentPaneDomain" }) },
	{ key = "j", mods = "ALT",      action = act({ CloseCurrentTab = { confirm = true } }) },
	{ key = "h", mods = "ALT",      action = act({ ActivateTabRelative = -1 }) },
	{ key = "l", mods = "ALT",      action = act({ ActivateTabRelative = 1 }) },
	{ key = "h", mods = "ALT|CTRL", action = act({ MoveTabRelative = -1 }) },
	{ key = "l", mods = "ALT|CTRL", action = act({ MoveTabRelative = 1 }) },
	{
		key = "k",
		mods = "ALT|CTRL",
		action = act.Multiple({ act.CopyMode("ClearSelectionMode"), act.ActivateCopyMode, act.ClearSelection }),
	},
	{ key = ",",          mods = "ALT",       action = act({ SplitVertical = { domain = "CurrentPaneDomain" } }) },
	{ key = ".",          mods = "ALT",       action = act({ SplitHorizontal = { domain = "CurrentPaneDomain" } }) },
	{ key = "h",          mods = "ALT|SHIFT", action = act({ ActivatePaneDirection = "Left" }) },
	{ key = "l",          mods = "ALT|SHIFT", action = act({ ActivatePaneDirection = "Right" }) },
	{ key = "k",          mods = "ALT|SHIFT", action = act({ ActivatePaneDirection = "Up" }) },
	{ key = "j",          mods = "ALT|SHIFT", action = act({ ActivatePaneDirection = "Down" }) },
	{ key = "/",          mods = "ALT",       action = act.Search("CurrentSelectionOrEmptyString") },
	{ key = "LeftArrow",  mods = "ALT",       action = act({ AdjustPaneSize = { "Left", 1 } }) },
	{ key = "RightArrow", mods = "ALT",       action = act({ AdjustPaneSize = { "Right", 1 } }) },
	{ key = "UpArrow",    mods = "ALT",       action = act({ AdjustPaneSize = { "Up", 1 } }) },
	{ key = "DownArrow",  mods = "ALT",       action = act({ AdjustPaneSize = { "Down", 1 } }) },
}

M.default_keybinds = {
	{ key = "c",      mods = "SUPER",      action = act({ CopyTo = "Clipboard" }) },
	{ key = "v",      mods = "SUPER",      action = act({ PasteFrom = "Clipboard" }) },
	{ key = "Insert", mods = "SHIFT",      action = act({ PasteFrom = "PrimarySelection" }) },
	{ key = "=",      mods = "CTRL",       action = "ResetFontSize" },
	{ key = "+",      mods = "CTRL|SHIFT", action = "IncreaseFontSize" },
	{ key = "-",      mods = "CTRL",       action = "DecreaseFontSize" },
	{ key = "u",      mods = "CTRL|SHIFT", action = act({ ScrollByPage = -0.2 }) },
	{ key = "d",      mods = "CTRL|SHIFT", action = act({ ScrollByPage = 0.2 }) },
	{ key = "q",      mods = "ALT",        action = act({ CloseCurrentPane = { confirm = true } }) },
	{ key = "x",      mods = "ALT",        action = act({ CloseCurrentPane = { confirm = true } }) },
	-- {
	--   key = "r",
	--   mods = "ALT",
	--   action = act({
	--     ActivateKeyTable = {
	--       name = "resize_pane",
	--       one_shot = false,
	--       timeout_milliseconds = 3000,
	--       replace_current = false,
	--     },
	--   }),
	-- },
}

function M.create_keybinds()
	return utils.merge_lists(M.default_keybinds, M.tmux_keybinds)
end

M.key_tables = {
	-- resize_pane = {
	--   { key = "h",      action = act({ AdjustPaneSize = { "Left", 1 } }) },
	--   { key = "l",      action = act({ AdjustPaneSize = { "Right", 1 } }) },
	--   { key = "k",      action = act({ AdjustPaneSize = { "Up", 1 } }) },
	--   { key = "j",      action = act({ AdjustPaneSize = { "Down", 1 } }) },
	--   -- Cancel the mode by pressing escape
	--   { key = "Escape", action = "PopKeyTable" },
	-- },
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
		{ key = "q", mods = "NONE", action = act.CopyMode("Close") },
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
		{ key = "0", mods = "NONE",  action = act.CopyMode("MoveToStartOfLine") },
		{ key = "$", mods = "SHIFT", action = act.CopyMode("MoveToEndOfLineContent") },
		{ key = "$", mods = "NONE",  action = act.CopyMode("MoveToEndOfLineContent") },
		-- select
		{ key = "v", mods = "NONE",  action = act.CopyMode({ SetSelectionMode = "Cell" }) },
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
		{ key = "G", mods = "NONE",  action = act.CopyMode("MoveToScrollbackBottom") },
		{ key = "g", mods = "NONE",  action = act.CopyMode("MoveToScrollbackTop") },
		{ key = "H", mods = "NONE",  action = act.CopyMode("MoveToViewportTop") },
		{ key = "H", mods = "SHIFT", action = act.CopyMode("MoveToViewportTop") },
		{ key = "M", mods = "NONE",  action = act.CopyMode("MoveToViewportMiddle") },
		{ key = "M", mods = "SHIFT", action = act.CopyMode("MoveToViewportMiddle") },
		{ key = "L", mods = "NONE",  action = act.CopyMode("MoveToViewportBottom") },
		{ key = "L", mods = "SHIFT", action = act.CopyMode("MoveToViewportBottom") },
		{ key = "o", mods = "NONE",  action = act.CopyMode("MoveToSelectionOtherEnd") },
		{ key = "O", mods = "NONE",  action = act.CopyMode("MoveToSelectionOtherEndHoriz") },
		{ key = "O", mods = "SHIFT", action = act.CopyMode("MoveToSelectionOtherEndHoriz") },
		{
			key = "Enter",
			mods = "NONE",
			action = act.CopyMode("ClearSelectionMode"),
		},
		-- search
		{ key = "/", mods = "NONE", action = act.Search("CurrentSelectionOrEmptyString") },
		{
			key = "n",
			mods = "NONE",
			action = act.Multiple({
				act.CopyMode("NextMatch"),
				act.CopyMode("ClearSelectionMode"),
			}),
		},
		{
			key = "N",
			mods = "SHIFT",
			action = act.Multiple({
				act.CopyMode("PriorMatch"),
				act.CopyMode("ClearSelectionMode"),
			}),
		},
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
		{ key = "/",      mods = "NONE", action = act.CopyMode("ClearPattern") },
	},
}

M.mouse_bindings = {
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
}

return M
