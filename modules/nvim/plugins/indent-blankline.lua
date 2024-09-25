require("lz.n").load({
	"indent-blankline.nvim",
	event = { "BufReadPre", "BufNewFile" },
	after = function()
		require("ibl").setup({
			scope = {
				enabled = false,
			},
		})
	end,
})
