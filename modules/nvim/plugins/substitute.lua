require("lz.n").load({
	"substitute.nvim",
	event = "DeferredUIEnter",
	after = function()
		require("substitute").setup()
		vim.keymap.set({ "n" }, "U", "<cmd>lua require('substitute').operator()<cr>", { noremap = true })
		vim.keymap.set("n", "UU", "<cmd>lua require('substitute').line()<cr>", { noremap = true })
		vim.keymap.set("x", "U", "<cmd>lua require('substitute').visual()<cr>", { noremap = true })
	end,
})
