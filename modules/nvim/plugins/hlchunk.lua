require("lz.n").load({
	"hlchunk.nvim",
	event = { "BufReadPre", "BufNewFile" },
	after = function()
		require("hlchunk").setup({
			chunk = {
				enable = true,
				style = {
					{ fg = "#AC5402" },
					{ fg = "#c21f30" },
				},
				chars = {
					horizontal_line = "─",
					vertical_line = "│",
					left_top = "╭",
					left_bottom = "╰",
					right_arrow = "─",
				},
				use_treesitter = true,
				duration = 0,
				delay = 0,
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
	end,
})
