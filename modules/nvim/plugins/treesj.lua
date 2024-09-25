require("lz.n").load({
	"treesj",
	keys = {
		{ "J", "<cmd>TSJToggle<cr>", desc = "Join Toggle" },
	},
	after = function()
		require("treesj").setup({
			use_default_keymaps = false,
			max_join_length = 150,
		})
	end,
})
