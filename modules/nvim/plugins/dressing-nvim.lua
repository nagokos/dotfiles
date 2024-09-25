require("lz.n").load({
	"dressing.nvim",
	event = "DeferredUIEnter",
	after = function()
		require("dressing").setup({})
	end,
})
