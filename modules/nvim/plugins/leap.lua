require("lz.n").load({
	"leap.nvim",
	event = "DeferredUIEnter",
	after = function()
		vim.keymap.set("n", "s", function()
			local focusable_windows = vim.tbl_filter(function(win)
				return vim.api.nvim_win_get_config(win).focusable
			end, vim.api.nvim_tabpage_list_wins(0))
			require("leap").leap({ target_windows = focusable_windows })
		end)
	end,
})
