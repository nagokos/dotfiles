require("lz.n").load({
	"outline.nvim",
	cmd = "Outline",
	keys = {
		{ "[_Lsp]o", "<cmd>Outline<cr>", desc = "Toggle Outline" },
	},
	after = function ()
		require("outline").setup({})
	end
})
