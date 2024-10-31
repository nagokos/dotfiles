require("lz.n").load({
	"alpha-nvim",
	event = "VimEnter",
	after = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		local logo = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ 
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
  ]]

		dashboard.section.header.val = vim.split(logo, "\n")
		dashboard.section.header.opts.hl = "Question"
		dashboard.section.buttons.val = {
			dashboard.button("o", "  Find old file", ":FzfLua oldfiles<CR>"),
			dashboard.button("f", "  Find file", ":FzfLua files<CR>"),
			dashboard.button("n", "  New file", ":enew<CR>"),
			dashboard.button("q", "  Exit", ":qa<CR>"),
		}
		alpha.setup(dashboard.config)
	end,
})
