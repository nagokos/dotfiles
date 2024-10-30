require("lz.n").load({
	"crates.nvim",
	event = { "BufRead Cargo.toml" },
	after = function()
		local crates = require("crates")
		crates.setup({
			-- https://github.com/Saecki/crates.nvim/issues/89
			lsp = {
				enabled = true,
				name = "crates.nvim",
				on_attach = function(client, bufnr) end,
				actions = true,
				completion = true,
				hover = true,
			},
		})

		vim.keymap.set("n", "[_Lsp]cd", crates.open_documentation, { silent = true })
	end,
})
