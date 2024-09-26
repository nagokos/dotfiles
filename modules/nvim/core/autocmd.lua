local group_name = "vimrc_vimrc"
vim.api.nvim_create_augroup(group_name, { clear = true })

vim.api.nvim_create_autocmd({ "FileType" }, {
	group = group_name,
	pattern = { "qf" },
	callback = function()
		vim.wo.wrap = true
	end,
	once = false,
})

vim.api.nvim_create_autocmd({ "CmdwinEnter" }, {
	group = group_name,
	pattern = "*",
	callback = function()
		vim.cmd.startinsert()
	end,
	once = false,
})

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	group = group_name,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = (vim.fn.hlexists("HighlightedyankRegion") > 0 and "HighlightedyankRegion" or "Visual"),
			timeout = 200,
		})
	end,
	once = false,
})

vim.keymap.set({ "n" }, "gy", function()
	vim.g.keep_cursor_yank = vim.api.nvim_win_get_cursor(0)
	return "y"
end, { noremap = true, silent = true, expr = true })
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	group = group_name,
	pattern = "*",
	callback = function()
		if vim.v.event.operator == "y" and vim.g.keep_cursor_yank then
			vim.api.nvim_win_set_cursor(0, vim.g.keep_cursor_yank)
			vim.g.keep_cursor_yank = nil
		end
	end,
	once = false,
})
