require("lz.n").load({
	"nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	load = function(name)
		vim.cmd.packadd(name)
		vim.cmd.packadd("SchemaStore.nvim")
	end,
	after = function()
		vim.diagnostic.config({
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = "●",
					[vim.diagnostic.severity.WARN] = "●",
					[vim.diagnostic.severity.INFO] = "●",
					[vim.diagnostic.severity.HINT] = "●",
				},
			},
			float = {
				border = "rounded",
			},
			virtual_text = {
				prefix = " ●",
				format = function(diagnostic)
					return string.format("%s ", diagnostic.message)
				end,
			},
		})

		local lspconfig = require("lspconfig")

		require("lspconfig.ui.windows").default_options = {
			border = "rounded",
		}

		local on_attach = function(_, bufnr)
			-- vim.lsp.inlay_hint.enable(true)

			-- Mappings.
			local opts = { noremap = true, silent = true, buffer = bufnr }
			vim.keymap.set("n", "[d", function()
				vim.diagnostic.jump({ count = -1, float = false })
			end, opts)
			vim.keymap.set("n", "]d", function()
				vim.diagnostic.jump({ count = 1, float = false })
			end, opts)
			vim.keymap.set("n", "[_Lsp]a", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
			vim.keymap.set("n", "[_Lsp]e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
			vim.keymap.set("n", "[_Lsp]q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
			vim.keymap.set("n", "[_Lsp]n", "<cmd>lua vim.lsp.buf.rename()<CR>")
			vim.keymap.set("n", "[_Lsp]d", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
			vim.keymap.set("n", "[_Lsp]r", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
			vim.keymap.set("n", "?", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
		end

		local capabilities = vim.lsp.protocol.make_client_capabilities()

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
		lspconfig.bashls.setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- nu
		lspconfig.nushell.setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

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
		lspconfig.taplo.setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

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
