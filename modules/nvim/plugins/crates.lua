require("lz.n").load({
	"crates.nvim",
	event = { "BufRead Cargo.toml" },
	after = function()
		require("crates").setup({
			-- https://github.com/Saecki/crates.nvim/issues/89
			completion = {
				cmp = {
					enabled = true,
				},
			},
		})
	end,
})
