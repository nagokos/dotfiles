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

-- in a lua file: search lua-, then c-, then all-snippets.
ls.filetype_extend("lua", { "c" })
-- in a cpp file: search c-snippets, then all-snippets only (no cpp-snippets!!).
ls.filetype_set("cpp", { "c" })

require("luasnip.loaders.from_lua").load({
	paths = "~/.config/nvim/luasnip-snippets",
	exclude = { "javascript" },
})

-- You can also use lazy loading so snippets are loaded on-demand, not all at once (may interfere with lazy-loading luasnip itself).
-- require("luasnip.loaders.from_vscode").lazy_load() -- You can pass { paths = "./my-snippets/"} as well
require("luasnip.loaders.from_vscode").lazy_load({ paths = { "~/.config/nvim/vscode-snippets" } }) -- You can pass { paths = "./my-snippets/"} as well
require("luasnip.loaders.from_vscode").lazy_load({
	paths = { vim.fn.stdpath("data") .. "/lazy/friendly-snippets" },
}) -- You can pass { paths = "./my-snippets/"} as well

ls.filetype_extend("all", { "_" })

vim.api.nvim_set_keymap("i", "<C-Down>", "<Plug>luasnip-next-choice", {})
vim.api.nvim_set_keymap("s", "<C-Down>", "<Plug>luasnip-next-choice", {})
