require("lz.n").load({
	"quicker.nvim",
	after = function()
		require("quicker").setup({
			type_icons = {
				E = "● ",
				W = "● ",
				I = "● ",
				N = "● ",
				H = "● ",
			},
			keys = {
				{
					">",
					function()
						require("quicker").expand({ before = 2, after = 2, add_to_existing = true })
					end,
					desc = "Expand quickfix context",
				},
				{
					"<",
					function()
						require("quicker").collapse()
					end,
					desc = "Collapse quickfix context",
				},
			},
		})

		vim.keymap.set("n", "[_SubLeader]q", function()
			require("quicker").toggle()
		end, {
			desc = "Toggle quickfix",
		})
		vim.keymap.set("n", "[_SubLeader]l", function()
			require("quicker").toggle({ loclist = true })
		end, {
			desc = "Toggle loclist",
		})
	end,
})
