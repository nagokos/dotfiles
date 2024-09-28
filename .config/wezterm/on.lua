local wezterm = require("wezterm")

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
	local title = string.format("%d: %s", tab_index, wezterm.truncate_right(tab.active_pane.title, max_width - 4))
	title = " " .. title .. " "

	return {
		{ Text = title },
	}
end)
