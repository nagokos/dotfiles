require("lz.n").load({
	"noice.nvim",
	event = "DeferredUIEnter",
	after = function()
		require("noice").setup({
			cmdline = {
				enabled = true,
				view = "cmdline",
			},
			popupmenu = {
				-- cmp-cmdline has more sources and can be extended
				backend = "cmp", -- backend to use to show regular cmdline completions
				win_options = {
					winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
				},
				border = {
					padding = { 0, 1 },
				},
			},
			lsp = {
				hover = {
					enabled = true,
					opts = {
						win_options = {
							winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
						},
					},
				},
				signature = {
					enabled = true,
					auto_open = {
						enabled = true,
						trigger = true, -- Automatically show signature help when typing a trigger character from the LSP
						luasnip = true, -- Will open signature help when jumping to Luasnip insert nodes
						throttle = 50, -- Debounce lsp signature help request by 50ms
					},
					opts = {
						win_options = {
							winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
						},
					},
				},
				progress = {
					enabled = true,
				},
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
				},
				documentation = {
					view = "hover",
					opts = {
						win_options = {
							winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
						},
					},
				},
			},
			-- you can enable a preset for easier configuration
			presets = {
				lsp_doc_border = true,
				bottom_search = false,
				command_palette = false,
			},
			messages = {
				-- Using kevinhwang91/nvim-hlslens because virtualtext is hard to read
				view_search = false,
			},
		})
	end,
})
