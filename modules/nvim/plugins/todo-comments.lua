require("lz.n").load({
	"todo-comments.nvim",
	event = "DeferredUIEnter",
	keys = {
		{ "[_SubLeader]t", "<CMD>TodoQuickFix<CR>" },
	},
	after = function()
		require("todo-comments").setup({
			keywords = {
				FIX = {
					icon = "", -- icon used for the sign, and in search results
					color = "error", -- can be a hex color, or a named color (see below)
					alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
					-- signs = false, -- configure signs for some keywords individually
				},
				TODO = { icon = "", color = "hint" },
				HACK = { icon = "", color = "warning" },
				WARN = { icon = "", color = "warning", alt = { "WARNING", "XXX" } },
				PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
				NOTE = { icon = " ", color = "info", alt = { "INFO" } },
			},
		})
	end,
})
