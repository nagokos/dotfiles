require("lz.n").load({
	"markview.nvim",
	ft = "markdown",
	after = function()
		require("markview").setup({})
	end,
})
