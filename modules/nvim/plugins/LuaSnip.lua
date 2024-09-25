local lz = require("lz.n")
lz.register_handler(require("handlers.load_before"))

lz.load({
	"LuaSnip",
	load_before = { "nvim-cmp" },
	after = function()
		lz.trigger_load("friendly-snippets")

		local luasnip = require("luasnip")
		require("luasnip.loaders.from_vscode").lazy_load()
		luasnip.config.setup({})
	end,
})
