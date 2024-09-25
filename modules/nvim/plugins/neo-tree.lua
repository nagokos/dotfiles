require("lz.n").load({
	"neo-tree.nvim",
	cmd = "Neotree",
	keys = {
		{ "gx", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
	},
	after = function()
		require("neo-tree").setup({
			default_component_configs = {
				git_status = {
					symbols = {
						unstaged = "✗",
						staged = "✓",
						unmerged = "",
						renamed = "➜",
						untracked = "",
						deleted = "",
						ignored = "◌",
					},
				},
			},
			filesystem = {
				filtered_items = {
					hide_dotfiles = false,
				},
				follow_current_file = { enabled = true },
			},
		})
	end,
})
