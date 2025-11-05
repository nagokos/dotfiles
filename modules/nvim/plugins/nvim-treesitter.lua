require("nvim-treesitter.configs").setup({
	ensure_installed = {},
	highlight = {
		enable = true, -- false will disable the whole extension
	},
	incremental_selection = {
		enable = true,
		keymaps = { -- mappings for incremental selection (visual mappings)
			node_incremental = "<CR>",
			node_decremental = "<S-CR>",
		},
	},
	-- indent = { enable = true },
})
