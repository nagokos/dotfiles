require("lz.n").load({
	"leap.nvim",
	event = "DeferredUIEnter",
	after = function()
		vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap)")
	end,
})
