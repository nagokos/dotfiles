require("lz.n").load({
	"fidget.nvim",
	event = "BufEnter",
	after = function()
		require("fidget").setup({
			progress = {
				display = {
					progress_icon = { pattern = "meter", period = 1 },
				},
			},
		})
	end,
})
