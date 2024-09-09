require("noice").setup({
	popupmenu = {
		-- cmp-cmdline has more sources and can be extended
		backend = "cmp", -- backend to use to show regular cmdline completions
	},
	lsp = {
		-- can not filter null-ls's data
		-- j-hui/fidget.nvim
		-- hover = {
		-- 	enabled = false,
		-- },
		signature = {
			enabled = false,
		},
		progress = {
			enabled = false,
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
			},
		},
	},
	-- you can enable a preset for easier configuration
	presets = {
		lsp_doc_border = true,
		bottom_search = false,
		command_palette = false,
	},
	messages = {
		-- Using kevinhwang91/nvim-hlslens because virtualtext is hard to read
		view_search = false,
	},
})

vim.keymap.set("c", "<S-Enter>", function()
	require("noice").redirect(vim.fn.getcmdline())
end, { desc = "Redirect Cmdline" })
