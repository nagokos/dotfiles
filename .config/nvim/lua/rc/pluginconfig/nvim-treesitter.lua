-- selene: allow(unused_variable)
---@diagnostic disable-next-line: unused-function, unused-local
local function ts_disable(_, bufnr)
	return vim.api.nvim_buf_line_count(bufnr) > 5000
end

require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"typescript",
		"tsx",
		"go",
		"rust",
		"c",
		"yaml",
		"lua",
		"vimdoc",
		"vue",
		"json",
		"markdown",
		"toml",
		"nix",
		"query",
		"kdl",
	},             -- one of 'all', 'language', or a list of languages
	highlight = {
		enable = true, -- false will disable the whole extension
		disable = {}, -- list of language that will be disabled
		additional_vim_regex_highlighting = false,
	},
	incremental_selection = {
		enable = true,
		keymaps = { -- mappings for incremental selection (visual mappings)
			node_incremental = "<CR>",
			node_decremental = "<S-CR>",
		},
	},
	indent = { enable = false, disable = { "python", "c", "cpp" } },
	yati = { enable = true, disable = { "markdown", "c", "cpp", "python" }, default_lazy = true }, -- インデントバグっているので
})
