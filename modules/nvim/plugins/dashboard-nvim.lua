require("lz.n").load({
	"dashboard-nvim",
	event = "VimEnter",
	after = function()
		local logo = [[


	███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
	████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
	██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
	██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
	██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
	╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝

		]]

		require("dashboard").setup({
			theme = "doom",
			hide = {
				statusline = false,
			},
			config = {
				header = vim.split(logo, "\n"),
				center = {
					{
						icon = " ",
						desc = "Find file",
						action = "FzfLua files",
						key = "f",
					},
					{
						icon = " ",
						desc = "Find old file",
						action = "FzfLua oldfiles",
						key = "o",
					},
					{
						icon = " ",
						desc = "New file",
						action = ":enew",
						key = "n",
					},
					{
						icon = " ",
						desc = "Exit",
						action = ":qa",
						key = "q",
					},
				},
				footer = {},
			},
		})
	end,
})
