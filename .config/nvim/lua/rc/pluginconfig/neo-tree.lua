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
