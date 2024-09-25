require("lz.n").load({
	"nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	load = function(name)
		vim.cmd.packadd(name)
		vim.cmd.packadd("cmp-nvim-lsp")
		vim.cmd.packadd("SchemaStore.nvim")
	end,
	after = function()
		local lspconfig = require("lspconfig")

		require("lspconfig.ui.windows").default_options = {
			border = "rounded",
		}
		vim.diagnostic.config({
			virtual_text = {
				prefix = "●",
			},
			float = {
				border = "rounded",
			},
		})

		local symbols = { Error = "󰅙", Info = "󰋼", Hint = "󰌵", Warn = "" }

		for name, icon in pairs(symbols) do
			local hl = "DiagnosticSign" .. name
			vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
		end

		local on_attach = function(_, bufnr)
			-- vim.lsp.inlay_hint.enable(true)

			-- Mappings.
			local opts = { noremap = true, silent = true, buffer = bufnr }
			vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
			vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
			vim.keymap.set("n", "[_Lsp]a", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
			vim.keymap.set("n", "[_Lsp]e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
			vim.keymap.set("n", "[_Lsp]q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
			vim.keymap.set("n", "[_Lsp]rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
			vim.keymap.set("n", "[_Lsp]d", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
			vim.keymap.set("n", "[_Lsp]rf", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
			vim.keymap.set("n", "?", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
		end

		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		-- Rust
		lspconfig.rust_analyzer.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				check = {
					command = "clippy",
				},
			},
		})

		-- Lua
		lspconfig.lua_ls.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
					-- hint = { enable = true },
					format = {
						enable = true,
						defaultConfig = {
							indent_style = "tab",
							indent_size = "2",
						},
					},
				},
			},
		})

		-- shell
		lspconfig.bashls.setup({ capabilities = capabilities, on_attach = on_attach })

		-- biome
		lspconfig.biome.setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- json
		lspconfig.jsonls.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				json = {
					schemas = require("schemastore").json.schemas(),
					validate = { enable = true },
				},
			},
		})

		-- yaml
		lspconfig.yamlls.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				yaml = {
					schemaStore = {
						-- You must disable built-in schemaStore support if you want to use
						-- this plugin and its advanced options like `ignore`.
						enable = false,
						-- Avoid TypeError: Cannot read properties of undefined (reading 'length')
						url = "",
					},
					schemas = require("schemastore").yaml.schemas(),
				},
			},
		})

		-- TOML
		lspconfig.taplo.setup({ capabilities = capabilities, on_attach = on_attach })

		-- nix
		lspconfig.nil_ls.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				["nil"] = {
					formatting = {
						command = { "nixfmt" },
					},
				},
			},
		})
	end,
})
