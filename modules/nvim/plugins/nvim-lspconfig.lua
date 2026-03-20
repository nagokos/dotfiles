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

		local capabilities = require("blink.cmp").get_lsp_capabilities({})

		vim.lsp.config("*", {
			capabilities = capabilities,
		})

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
			vim.keymap.set("n", "[_Lsp]f", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
			vim.keymap.set("n", "?", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
		end

		-- Rust
		vim.lsp.config("rust_analyzer", {
			on_attach = on_attach,
			settings = {
				["rust-analyzer"] = {
					diagnostics = {
						enable = true,
					},
					check = {
						command = "clippy",
					},
				},
			},
		})
		vim.lsp.enable("rust_analyzer")

		-- Haskell
		vim.lsp.config("hls", {
			on_attach = on_attach,
			settings = {
				haskell = {
					plugin = {
						hlint = { globalOn = true },
					},
				},
			},
		})
		vim.lsp.enable("hls")

		-- Lua
		vim.lsp.config("lua_ls", {
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
		vim.lsp.enable("lua_ls")

		-- TODO: lsp settings

		-- shell
		vim.lsp.config("bashls", {
			on_attach = on_attach,
		})
		vim.lsp.enable("bashls")

		-- nu
		vim.lsp.config("nushell", {
			on_attach = on_attach,
		})
		vim.lsp.enable("nushell")
		--
		-- biome
		vim.lsp.config("biome", {
			on_attach = on_attach,
		})
		vim.lsp.enable("biome")

		-- json
		vim.lsp.config("jsonls", {
			on_attach = on_attach,
			settings = {
				json = {
					schemas = require("schemastore").json.schemas(),
					validate = { enable = true },
				},
			},
		})
		vim.lsp.enable("jsonls")

		-- c and c++
		vim.lsp.config("clangd", {
			on_attach = on_attach,
			cmd = {
				"clangd",
				"--background-index",
				"--clang-tidy",
				"--completion-style=detailed",
				"--header-insertion=iwyu",
				"--pch-storage=memory",
			},
			-- clangd は settings ではなく init_options / cmd で調整することが多い
			init_options = {
				clangdFileStatus = true, -- ステータス表示（対応クライアントで効く）
			},
		})

		vim.lsp.enable("clangd")

		-- yaml
		vim.lsp.config("yamlls", {
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
		vim.lsp.enable("yamlls")

		local nvim_lsp = require("lspconfig")

		local is_node_dir = function()
			return nvim_lsp.util.root_pattern("package.json")(vim.fn.getcwd())
		end

		-- ts_ls
		local ts_opts = {}
		ts_opts.on_attach = function(client)
			if not is_node_dir() then
				client.stop(true)
			end
		end

		vim.lsp.config("ts_ls", ts_opts)
		vim.lsp.enable("ts_ls")

		-- denols
		local deno_opts = {}
		deno_opts.on_attach = function(client)
			if is_node_dir() then
				client.stop(true)
			end
		end

		vim.lsp.config("denols", deno_opts)
		vim.lsp.enable("denols")

		-- TOML
		vim.lsp.config("taplo", {
			on_attach = on_attach,
		})
		vim.lsp.enable("taplo")

		-- nix
		vim.lsp.config("nixd", {
			on_attach = on_attach,
			settings = {
				nixd = {
					formatting = {
						command = { "nixfmt" },
					},
				},
			},
		})
		vim.lsp.enable("nixd")
	end,
})
