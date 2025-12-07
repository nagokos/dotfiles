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

		vim.api.nvim_create_autocmd("FileType", {
			pattern = "qf",
			callback = function()
				vim.keymap.set("n", "q", "<Cmd>cclose<CR>", { buffer = true })
			end,
			group = vim.api.nvim_create_augroup("bqfKeymap", { clear = true }),
		})
	end,
})
