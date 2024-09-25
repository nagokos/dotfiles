require("lz.n").load({
	"render-markdown.nvim",
	priority = 1000,
	ft = "markdown",
	after = function()
		require("render-markdown").setup({})
	end,
})
