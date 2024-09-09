require("which-key").setup({
	plugins = {
		marks = false,   -- shows a list of your marks on ' and `
		registers = false, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
		-- the presets plugin, adds help for a bunch of default keybindings in Neovim
		-- No actual key bindings are created
		presets = {
			operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
			motions = false,   -- adds help for motions
			text_objects = false, -- help for text objects triggered after entering an operator
			windows = false,   -- default bindings on <c-w>
			nav = false,       -- misc bindings to work with windows
			z = false,         -- bindings for folds, spelling and others prefixed with z
			g = false,         -- bindings for prefixed with g
		},
	},
	-- add operators that will trigger motion and text object completion
	-- to enable all native operators, set the preset / operators plugin above
	icons = {
		breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
		separator = "➜", -- symbol used between a key and it's label
		group = "+", -- symbol prepended to a group
	},
	window = {
		border = "none",        -- none, single, double, shadow
		position = "bottom",    -- bottom, top
		margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
		padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
	},
	layout = {
		height = { min = 4, max = 25 },                                            -- min and max height of the columns
		width = { min = 20, max = 50 },                                            -- min and max width of the columns
		spacing = 3,                                                               -- spacing between columns
	},
	hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
	show_help = true,                                                            -- show help message on the command line when the popup is visible
	-- triggers = "auto", -- automatically setup triggers
	triggers = { "<Leader>" },                                                   -- or specify a list manually
})

vim.api.nvim_set_keymap("n", "<Leader><CR>", "<Cmd>WhichKey \\ <CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<LocalLeader><CR>", "<Cmd>WhichKey <LocalLeader><CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "[_SubLeader]<CR>", "<Cmd>WhichKey [_SubLeader]<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "[_Debugger]<CR>", "<Cmd>WhichKey [_Debugger]<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "[_FuzzyFinder]<CR>", "<Cmd>WhichKey [_FuzzyFinder]<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "[_Lsp]<CR>", "<Cmd>WhichKey [_Lsp]<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "[_Git]<CR>", "<Cmd>WhichKey [_Git]<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "g<CR>", "<Cmd>WhichKey g<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "[<CR>", "<Cmd>WhichKey [<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "]<CR>", "<Cmd>WhichKey ]<CR>", { noremap = true })
