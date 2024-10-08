require("lz.n").load({
	"crates.nvim",
	event = { "BufRead Cargo.toml" },
	after = function()
		local crates = require("crates")
		crates.setup({
			-- https://github.com/Saecki/crates.nvim/issues/89
			completion = {
				cmp = {
					enabled = true,
				},
			},
		})

		vim.keymap.set("n", "[_Lsp]cd", crates.open_documentation, { silent = true })
	end,
})
