require("lz.n").load({
	"diffview.nvim",
	cmd = "DiffviewOpen",
	keys = {
		{ "[_Git]D", "<Cmd>DiffviewOpen<CR>", desc = "Diffview Open" },
	},
	after = function()
		require("diffview").setup({
			enhanced_diff_hl = true,
		})

		vim.api.nvim_create_autocmd("FileType", {
			pattern = "DiffviewFiles",
			callback = function()
				vim.keymap.set("n", "q", "<Cmd>tabclose<CR>", { buffer = true })
			end,
			group = vim.api.nvim_create_augroup("diffviewInit", { clear = true }),
		})
	end,
})
