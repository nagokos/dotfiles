require("which-key").setup({
	delay = 400,
	triggers = {
		{ "g", mode = { "n", "v" } },
		{ "[", mode = "n" },
		{ "]", mode = "n" },
		{ "z", mode = { "n", "v" } },
	},
	spec = {
		{ "[_Git]",         group = "Git" },
		{ "[_FuzzyFinder]", group = "FuzzyFinder" },
		{ "[_Lsp]",         proxy = ";",          group = "Lsp" },
		{ "[_SubLeader]",   proxy = ",",          group = "SubLeader" },
	}
})
