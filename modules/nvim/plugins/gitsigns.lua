require("lz.n").load({
	"gitsigns.nvim",
	event = "DeferredUIEnter",
	after = function()
		require("gitsigns").setup({
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- Navigation
				map("n", "]g", function()
					if vim.wo.diff then
						return "]g"
					end
					vim.schedule(function()
						gs.next_hunk()
					end)
					return "<Ignore>"
				end, { expr = true, desc = "next hunk" })

				map("n", "[g", function()
					if vim.wo.diff then
						return "[g"
					end
					vim.schedule(function()
						gs.prev_hunk()
					end)
					return "<Ignore>"
				end, { expr = true, desc = "preview hunk" })

				-- Actions
				map({ "n", "v" }, "[_Git]s", ":Gitsigns stage_hunk<CR>")
				map({ "n", "v" }, "[_Git]r", ":Gitsigns reset_hunk<CR>")
				map({ "n", "v" }, "[_Git]u", ":Gitsigns undo_stage_hunk<CR>")
				map("n", "[_Git]p", gs.preview_hunk)
			end,
		})
	end,
})
