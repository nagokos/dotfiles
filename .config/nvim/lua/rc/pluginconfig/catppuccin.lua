require("catppuccin").setup({
	flavour = "latte",
	integrations = {
		fidget = true,
		lsp_saga = true,
		mason = true,
		notify = true,
		neotree = true,
		noice = true,
	}
})

vim.cmd.colorscheme("catppuccin")
