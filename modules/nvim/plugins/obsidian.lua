require("lz.n").load({
	"obsidian.nvim",
	cmd = "Obsidian",
	ft = "markdown",
	keys = {
		{ "[_FuzzyFinder]zn", "<Cmd>Obsidian new<CR>", desc = "obsidian open" },
		{ "[_FuzzyFinder]zs", "<Cmd>Obsidian search<CR>", desc = "obsidian search" },
		{ "[_FuzzyFinder]zq", "<Cmd>Obsidian quick_switch<CR>", desc = "obsidian quick switch" },
		{ "[_FuzzyFinder]zt", "<Cmd>Obsidian tags<CR>", desc = "obsidian tags" },
		{ "[_FuzzyFinder]zd", "<Cmd>Obsidian today<CR>", desc = "obsidian switch workspace" },
		{ "[_FuzzyFinder]zm", "<Cmd>Obsidian tomorrow<CR>", desc = "obsidian switch workspace" },
	},
	after = function()
		require("lz.n").trigger_load("fzf-lua")

		vim.opt.conceallevel = 1

		require("obsidian").setup({
			legacy_commands = false,
			workspaces = {
				{
					name = "zettelkasten",
					path = vim.fn.expand("~/Documents/zellekasten"),
				},
			},

			frontmatter = {
				enabled = true,
				func = function(note)
					local metadata = note.metadata or {}

					return {
						date = os.date("%Y-%m-%d"),
						tags = note.tags,
						hubs = metadata.hubs or {},
						urls = metadata.urls or {},
					}
				end,
				sort = { "date", "tags", "hubs", "urls" },
			},

			note_id_func = function(title)
				local purified
				if title then
					purified = title:lower()

					purified = purified:gsub("[^%w%-_]", "-")

					purified = purified:gsub("^-+", ""):gsub("-+$", ""):gsub("-+", "-")

					if purified == "" or purified:match("^-*$") then
						purified = nil
					end
				end

				if not purified then
					purified = ""
					for _ = 1, 4 do
						purified = purified .. string.char(math.random(65, 90))
					end
				end

				return os.date("%Y-%m-%d_") .. purified
			end,

			ui = {
				enable = true,
			},

			picker = {
				name = "fzf-lua",
				note_mappings = {
					-- Create a new note from your query.
					new = "<C-x>",
					-- Insert a link to the selected note.
					insert_link = "<C-l>",
				},
				tag_mappings = {
					-- Add tag(s) to current note.
					tag_note = "<C-x>",
					-- Insert a tag at the current location.
					insert_tag = "<C-l>",
				},
			},
		})
	end,
})
