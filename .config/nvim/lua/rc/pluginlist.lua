local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	vim.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--single-branch",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	}, { text = true }):wait()
end
vim.opt.runtimepath:prepend(lazypath)

local plugins = {
	-------------------------------------------------------------
	-- Installer
	{ "folke/lazy.nvim" },

	-- External package Installer
	{
		"williamboman/mason.nvim",
		event = { "BufReadPre", "VimEnter" },
		build = ":MasonUpdate",
		config = function()
			require("rc/pluginconfig/mason")
		end,
	},

	--------------------------------
	-- Lua Library
	{ "nvim-lua/plenary.nvim" },
	{ "kkharji/sqlite.lua" },
	{ "MunifTanjim/nui.nvim" },

	--------------------------------
	-- UI Library
	{
		"stevearc/dressing.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/dressing")
		end,
	},

	--------------------------------
	-- Notify
	{
		"rcarriga/nvim-notify",
		event = "BufReadPre",
		config = function()
			require("rc/pluginconfig/nvim-notify")
		end,
	},

	--------------------------------
	-- ColorScheme
	{
		"EdenEast/nightfox.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/nightfox")
		end
	},
	--------------------------------
	-- Font
	{ "kyazdani42/nvim-web-devicons" },

	--------------------------------------------------------------
	-- LSP & completion
	--------------------------------
	-- Auto Completion
	{
		"hrsh7th/nvim-cmp",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/nvim-cmp")
		end,
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "hrsh7th/cmp-vsnip" },
			{ "hrsh7th/vim-vsnip" },
			{ "f3fora/cmp-spell" },
			{ "saadparwaiz1/cmp_luasnip" },
			{
				"onsails/lspkind-nvim",
				config = function()
					require("rc/pluginconfig/lspkind-nvim")
				end,
			},
		},
	},

	--------------------------------
	-- Language Server Protocol(LSP)
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("rc/pluginconfig/nvim-lspconfig")
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		event = "BufReadPre",
		config = function()
			require("rc/pluginconfig/mason-lspconfig")
		end,
	},
	{
		"ray-x/lsp_signature.nvim",
		event = { "BufRead", "BufNewFile" },
		config = function()
			require("rc/pluginconfig/lsp_signature")
		end,
	},

	--------------------------------
	-- LSP's UI
	{
		"nvimdev/lspsaga.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/lspsaga")
		end,
	},
	{
		"folke/trouble.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/trouble")
		end,
	},
	{
		"j-hui/fidget.nvim",
		tag = "legacy",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/fidget")
		end,
	},

	------------------------------
	-- telescope.nvim
	{
		"nvim-telescope/telescope.nvim",
		event = { "VimEnter" },
		config = function()
			require("rc/pluginconfig/telescope")
		end,
		dependencies = {
			{
				"nvim-telescope/telescope-ui-select.nvim",
				config = function()
					require("telescope").load_extension("ui-select")
				end,
			},
		},
	},
	{
		"nvim-telescope/telescope-frecency.nvim",
		event = "VeryLazy",
		config = function()
			require("telescope").load_extension("frecency")
		end,
	},
	-- Consider telescope-improt

	--------------------------------
	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPost" },
		build = ":TSUpdateSync",
		config = function()
			require("rc/pluginconfig/nvim-treesitter")
		end,
		dependencies = {
			{ "JoosepAlviste/nvim-ts-context-commentstring" },
			{ "yioneko/nvim-yati" },
		},
	},
	{
		"windwp/nvim-ts-autotag",
		event = {
			"BufReadPre",
			"BufNewFile",
		},
		config = function()
			require("nvim-ts-autotag").setup({})
		end,
	},
	{
		"mfussenegger/nvim-treehopper",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/nvim-treehopper")
		end,
	},
	{
		"David-Kunz/treesitter-unit",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/treesitter-unit")
		end,
	},

	--------------------------------
	-- Treesitter UI customize
	{
		"romgrk/nvim-treesitter-context",
		cmd = { "TSContextEnable" },
		event = "VeryLazy",
		config = function()
			require("treesitter-context").setup()
		end,
	},

	--------------------------------
	-- Statusline
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/lualine")
		end,
	},

	--------------------------------
	-- Bufferline
	{
		"akinsho/bufferline.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/bufferline")
		end,
	},

	------------------------------
	-- Commandline
	{
		"folke/noice.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/noice")
		end,
	},
	{
		"hrsh7th/cmp-cmdline",
		event = "VimEnter",
	},

	----------------------
	-- Comment
	{
		"numToStr/Comment.nvim",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/Comment")
		end,
	},

	--------------------------------
	-- Highlight
	{
		"folke/todo-comments.nvim",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/todo-comments")
		end,
	},

	--------------------------------
	-- Startup screen
	{
		"goolord/alpha-nvim",
		event = "BufEnter",
		config = function()
			require("rc/pluginconfig/alpha-nvim")
		end,
	},

	--------------------------------
	-- Operator
	{
		"gbprod/substitute.nvim",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/substitute")
		end,
	},
	{
		"kylechui/nvim-surround",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/nvim-surround")
		end,
	},

	-------------------------------------
	-- Join
	{
		"Wansmer/treesj",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/treesj")
		end,
	},

	-----------------
	-- Adding and subtracting
	{
		"monaqa/dial.nvim",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/dial")
		end,
	},

	--------------------------------
	-- Find
	{
		"kevinhwang91/nvim-hlslens",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/nvim-hlslens")
		end,
	},
	{
		"rapan931/lasterisk.nvim",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/lasterisk")
		end,
	},

	--------------------------------
	-- Grep tool
	{
		"windwp/nvim-spectre",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/nvim-spectre")
		end,
	},

	--------------------------------
	-- Filer
	{
		"nvim-neo-tree/neo-tree.nvim",
		event = "VimEnter",
		branch = "main",
		config = function()
			require("rc/pluginconfig/neo-tree")
		end,
	},

	--------------------------------------
	-- Move
	{
		"ggandor/leap.nvim",
		event = "VimEnter",
		config = function()
			require("leap").create_default_mappings()
		end,
	},

	-- Move Block
	{
		"fedepujol/move.nvim",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/move")
		end,
	},

	-- split pane
	{
		"mrjones2014/smart-splits.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/smart-splits")
		end,
	},

	--------------------------------
	-- Quickfix
	{
		"kevinhwang91/nvim-bqf",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/nvim-bqf")
		end,
	},
	{
		"stevearc/qf_helper.nvim",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/qf_helper")
		end,
	},

	--------------------------------
	-- Session
	-- do not use the session per current directory
	{
		"jedrzejboczar/possession.nvim",
		-- lazy = false,
		event = "BufEnter",
		config = function()
			require("rc/pluginconfig/possession")
		end,
	},

	--------------------------------
	-- Manual
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		version = "~2.0.0", -- バージョン上げるとバグるのでとりあえず
		config = function()
			require("rc/pluginconfig/which-key")
		end,
	},

	--------------------------------
	-- Terminal
	{
		"akinsho/toggleterm.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/toggleterm")
		end,
	},

	--------------------------------
	-- Reading assistant
	{
		"lukas-reineke/indent-blankline.nvim",
		lazy = false,
		main = "ibl",
		config = function()
			require("rc/pluginconfig/indent-blankline")
		end,
	},

	------------------------------
	-- Brackets
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("rc/pluginconfig/nvim-autopairs")
		end,
	},
	{
		"hrsh7th/nvim-insx",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/nvim-insx")
		end,
	},

	------------------------------------
	-- Format
	{
		"stevearc/conform.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/conform")
		end
	},

	-------------------------------------
	-- Lint
	{
		"mfussenegger/nvim-lint",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/nvim-lint")
		end
	},

	----------------------------
	-- Git
	{
		"akinsho/git-conflict.nvim",
		event = "VeryLazy",
		config = true,
	},
	{
		"lewis6991/gitsigns.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/gitsigns")
		end,
	},

	-----------------------------
	-- Memo
	{
		"epwalsh/obsidian.nvim",
		lazy = false,
		ft = "markdown",
		config = function()
			require("rc/pluginconfig/obsidian")
		end,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"hrsh7th/nvim-cmp",
			"nvim-telescope/telescope.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
	},

	------------------------------
	-- Debugger
	-- {
	-- 	"mfussenegger/nvim-dap",
	-- 	event = "VeryLazy",
	-- 	config = function()
	-- 		require("rc/pluginconfig/nvim-dap")
	-- 	end,
	-- 	dependencies = {
	-- 		{
	-- 			"rcarriga/nvim-dap-ui",
	-- 			config = function()
	-- 				require("rc/pluginconfig/nvim-dap-ui")
	-- 			end,
	-- 		},
	-- 		{ "nvim-neotest/nvim-nio" },
	-- 		{ "theHamsta/nvim-dap-virtual-text" },
	-- 		{ "nvim-telescope/telescope-dap.nvim" },
	-- 	},
	-- },

	---------------------------------------
	-- Language

	-- Rust
	{
		"saecki/crates.nvim",
		tag = "stable",
		event = { "BufRead Cargo.toml" },
		config = function()
			require("rc/pluginconfig/crates")
		end
	},

	-- markdown
	{
		"ixru/nvim-markdown",
		event = "BufEnter",
	},

	----------------------------------
	---- Snippet
	{
		"L3MON4D3/LuaSnip",
		event = "VimEnter",
		build = "make install_jsregexp",
		config = function()
			require("rc/pluginconfig/LuaSnip")
		end,
	},

	----Snippet Pack
	{ "rafamadriz/friendly-snippets" },
}

require("lazy").setup(plugins, {
	defaults = {
		lazy = true,
	},
	performance = {
		cache = {
			enabled = true,
			-- disable_events = {},
		},
		rtp = {
			disabled_plugins = {
				"gzip",
				-- "matchit",
				-- "matchparen",
				-- "netrwPlugin",
				"rplugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
	ui = {
		backdrop = 100,
		border = "rounded",
	},
})
