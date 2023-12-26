require("noice").setup({
	popupmenu = {
		-- cmp-cmdline has more sources and can be extended
		backend = "cmp", -- backend to use to show regular cmdline completions
	},
	lsp = {
		-- can not filter null-ls's data
		-- j-hui/fidget.nvim
		progress = {
			enabled = false,
		},
	},
	messages = {
		-- Using kevinhwang91/nvim-hlslens because virtualtext is hard to read
		view_search = false,
	},
})

vim.keymap.set("c", "<S-Enter>", function()
	require("noice").redirect(vim.fn.getcmdline())
end, { desc = "Redirect Cmdline" })

