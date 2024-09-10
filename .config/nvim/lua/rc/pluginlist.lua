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
		event = { "BufReadPre", "VeryLazy" },
		build = ":MasonUpdate",
		config = function()
			require("rc/pluginconfig/mason")
		end,
	},

	--------------------------------
	-- Lua Library
	{ "nvim-lua/plenary.nvim" },
	{ "MunifTanjim/nui.nvim" },

	--------------------------------
	-- UI Library
	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
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
		event = "InsertEnter",
		config = function()
			require("rc/pluginconfig/nvim-cmp")
		end,
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "onsails/lspkind.nvim" }
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

	----------------------------------
	-- Outline
	{
		"hedyhli/outline.nvim",
		cmd = "Outline",
		keys = {
			{ "[_Lsp]o", "<cmd>Outline<cr>", desc = "Toggle Outline" },
		},
		config = function()
			require("rc/pluginconfig/outline")
		end,
	},

	------------------------------
	-- fzf-lua
	{
		"ibhagwan/fzf-lua",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/fzf-lua")
		end,
	},

	--------------------------------
	-- Treesitter
	-- TODO: comment, jsxで効かないようならプラグイン入れる
	{
		"nvim-treesitter/nvim-treesitter",
		event = "BufReadPre",
		build = ":TSUpdateSync",
		config = function()
			require("rc/pluginconfig/nvim-treesitter")
		end,
		dependencies = {
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
		event = "VeryLazy",
		-- https://github.com/folke/noice.nvim/issues/931
		version = "4.4.7",
		config = function()
			require("rc/pluginconfig/noice")
		end,
	},
	{
		"hrsh7th/cmp-cmdline",
		event = "CmdlineEnter",
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
		event = "VimEnter",
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
		version = "*",
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
		keys = {
			{ "J", "<cmd>TSJToggle<cr>", desc = "Join Toggle" },
		},
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
	-- Grep tool
	{
		'MagicDuck/grug-far.nvim',
		cmd = "GrugFar",
		config = function()
			require("rc/pluginconfig/grug-far")
		end
	},

	--------------------------------
	-- Filer
	{
		"nvim-neo-tree/neo-tree.nvim",
		cmd = "Neotree",
		keys = {
			{ "gx", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
		},
		config = function()
			require("rc/pluginconfig/neo-tree")
		end,
	},

	--------------------------------------
	-- Move
	{
		"ggandor/leap.nvim",
		event = "VeryLazy",
		config = function()
			vim.keymap.set('n', 's', function()
				local focusable_windows = vim.tbl_filter(
					function(win) return vim.api.nvim_win_get_config(win).focusable end,
					vim.api.nvim_tabpage_list_wins(0)
				)
				require('leap').leap { target_windows = focusable_windows }
			end)
		end
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
		event = "VeryLazy",
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
		end
	},

	--------------------------------
	-- Session
	-- do not use the session per current directory
	{
		"jedrzejboczar/possession.nvim",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/possession")
		end,
	},

	--------------------------------
	-- Manual
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/which-key")
		end,
	},

	--------------------------------
	-- Terminal
	{
		"akinsho/toggleterm.nvim",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/toggleterm")
		end,
	},

	--------------------------------
	-- Reading assistant
	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufRead", "BufNewFile" },
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
		event = "InsertEnter",
		config = function()
			require("rc/pluginconfig/nvim-insx")
		end,
	},

	------------------------------------
	-- Format
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"[_Lsp]f",
				function()
					require("conform").format({ async = true })
				end,
				desc = "Format buffer",
			}
		},
		config = function()
			require("rc/pluginconfig/conform")
		end,
	},

	-------------------------------------
	-- Lint
	{
		"mfussenegger/nvim-lint",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/nvim-lint")
		end
	},

	----------------------------
	-- Git
	-- TODO:必要か精査する
	{
		"akinsho/git-conflict.nvim",
		event = "VeryLazy",
		config = true,
	},
	{
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/gitsigns")
		end,
	},
	{
		"sindrets/diffview.nvim",
		cmd = "DiffviewOpen",
		keys = {
			{ "[_Git]d", "<Cmd>DiffviewOpen<CR>", desc = "Diffview Open" }
		},
		config = function()
			require("rc/pluginconfig/diffview")
		end
	},

	-----------------------------
	-- Memo
	{
		"epwalsh/obsidian.nvim",
		event = "VeryLazy",
		ft = "markdown",
		config = function()
			require("rc/pluginconfig/obsidian")
		end,
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
		ft = "markdown",
	},
	{
		"OXY2DEV/markview.nvim",
		ft = "markdown",
	},

	----------------------------------
	---- Snippet
	{
		"L3MON4D3/LuaSnip",
		event = "VeryLazy",
		build = "make install_jsregexp",
		config = function()
			require("rc/pluginconfig/LuaSnip")
		end,
		dependencies = {
			{ "rafamadriz/friendly-snippets" },
		}
	},
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
