require("lz.n").load({
	"grug-far.nvim",
	cmd = "GrugFar",
	after = function()
		require("grug-far").setup({
			windowCreationCommand = "tabnew",
		})
	end,
})
