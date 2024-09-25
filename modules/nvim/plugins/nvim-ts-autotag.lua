require("lz.n").load({
	"nvim-ts-autotag",
	event = { "BufReadPre", "BufNewFile" },
	after = function()
		require("nvim-ts-autotag").setup({})
	end,
})
