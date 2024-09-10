local ls = require("luasnip")
local types = require("luasnip.util.types")

ls.setup({
	keep_roots = true,
	link_roots = true,
	link_children = true,
	updateevents = "TextChanged,TextChangedI",
	delete_check_events = "TextChanged",
	ext_opts = { [types.choiceNode] = { active = { virt_text = { { "choiceNode", "Comment" } } } } },
	ext_base_prio = 300,
	ext_prio_increase = 1,
	enable_autosnippets = true,
	ft_func = function()
		return vim.split(vim.bo.filetype, ".", true)
	end,
})

ls.filetype_extend("lua", { "c" })
ls.filetype_set("cpp", { "c" })

require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/luasnip-snippets" })

require("luasnip.loaders.from_vscode").lazy_load({
	paths = { vim.fn.stdpath("data") .. "/lazy/friendly-snippets" },
})

ls.filetype_extend("all", { "_" })
