require("blink.cmp").setup({
	keymap = {
		show = "<C-space>",
		hide = "<C-y>",
		accept = "<CR>",
		select_prev = { "<C-p>" },
		select_next = { "<C-n>" },

		scroll_documentation_up = "<C-b>",
		scroll_documentation_down = "<C-f>",

		snippet_forward = "<Tab>",
		snippet_backward = "<S-Tab>",
	},

	trigger = {
		signature_help = {
			enabled = true,
			blocked_trigger_characters = {},
			blocked_retrigger_characters = {},
			show_on_insert_on_trigger_character = true,
		},
	},

	fuzzy = {
		use_frecency = true,
		use_proximity = true,
		max_items = 200,
		sorts = { "label", "kind", "score" },

		prebuiltBinaries = {
			download = true,
			forceVersion = nil,
		},
	},

	sources = {
		providers = {
			{
				"blink.cmp.sources.lsp",
				name = "LSP",
				keyword_length = 0,
				score_offset = 0,
				trigger_characters = { "f", "o", "o" },
			},
			-- the following two sources have additional options
			{
				"blink.cmp.sources.path",
				name = "Path",
				score_offset = 3,
				opts = {
					trailing_slash = false,
					label_trailing_slash = true,
					get_cwd = function(context)
						return vim.fn.expand(("#%d:p:h"):format(context.bufnr))
					end,
					show_hidden_files_by_default = true,
				},
			},
			{
				"blink.cmp.sources.snippets",
				name = "Snippets",
				score_offset = -3,
				opts = {
					friendly_snippets = true,
					search_paths = { vim.fn.stdpath("config") .. "/snippets" },
					global_snippets = { "all" },
					extended_filetypes = {},
					ignored_filetypes = {},
				},
			},
			{
				"blink.cmp.sources.buffer",
				name = "Buffer",
				fallback_for = { "LSP" },
			},
		},
	},

	windows = {
		autocomplete = {
			min_width = 15,
			max_height = 10,
			border = "rounded",
			winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
			scrolloff = 2,
			direction_priority = { "s", "n" },
			selection = "preselect",
			draw = "simple",
			cycle = {
				from_bottom = true,
				from_top = true,
			},
		},
		documentation = {
			min_width = 10,
			max_width = 60,
			max_height = 20,
			border = "rounded",
			winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
			direction_priority = {
				autocomplete_north = { "e", "w", "n", "s" },
				autocomplete_south = { "e", "w", "s", "n" },
			},
			auto_show = false,
			auto_show_delay_ms = 500,
			update_delay_ms = 50,
		},
		signature_help = {
			min_width = 1,
			max_width = 100,
			max_height = 10,
			border = "rounded",
			winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
		},
	},

	highlight = {
		ns = vim.api.nvim_create_namespace("blink_cmp"),
		use_nvim_cmp_as_default = true,
	},

	nerd_font_variant = "normal",

	kind_icons = {
		Text = "󰉿",
		Method = "󰊕",
		Function = "󰊕",
		Constructor = "󰒓",

		Field = "󰜢",
		Variable = "󰆦",
		Property = "󰖷",

		Class = "󱡠",
		Interface = "󱡠",
		Struct = "󱡠",
		Module = "󰅩",

		Unit = "󰪚",
		Value = "󰦨",
		Enum = "󰦨",
		EnumMember = "󰦨",

		Keyword = "󰻾",
		Constant = "󰏿",

		Snippet = "󱄽",
		Color = "󰏘",
		File = "󰈔",
		Reference = "󰬲",
		Folder = "󰉋",
		Event = "󱐋",
		Operator = "󰪚",
		TypeParameter = "󰬛",
	},
})
