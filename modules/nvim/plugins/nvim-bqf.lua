require("lz.n").load({
	"nvim-bqf",
	event = "DeferredUIEnter",
	after = function()
		require("bqf").setup({
			func_map = {
				pscrollup = "<C-u>",
				pscrolldown = "<C-d>",
			},
		})
	end,
})
