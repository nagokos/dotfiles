require('hlchunk').setup({
	chunk = {
		enable = true,
		style = {
			{ fg = "#AC5402" },
			{ fg = '#c21f30' },
		},
		use_treesitter = true,
	},
	indent = {
		enable = true,
		use_treesitter = true,
	},
	line_num = {
		enable = false,
		style = "#AC5402",
		use_treesitter = true,
	},
	blank = {
		enable = false,
	},
})
