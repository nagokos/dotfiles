-- custom leader
vim.keymap.set({ "n", "x" }, "[_SubLeader]", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", ",", "[_SubLeader]", {})
vim.api.nvim_set_keymap("x", ",", "[_SubLeader]", {})

-- Leader
vim.keymap.set("n", "<Space>", "<Nop>", { noremap = true, silent = true })

-- [_FuzzyFinder]
vim.keymap.set({ "n", "x" }, "w", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "w", "[_FuzzyFinder]", {})
vim.api.nvim_set_keymap("v", "w", "[_FuzzyFinder]", {})

-- [_Lsp]
vim.keymap.set("n", ";", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("n", "[_Lsp]", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", ";", "[_Lsp]", {})

-- [_Git]
vim.keymap.set({ "n", "x" }, "G", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "G", "[_Git]", {})
vim.keymap.set({ "n", "x" }, "GG", "G", { noremap = true, silent = true })

-- switch buffer
vim.keymap.set("n", "H", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("n", "L", "<Nop>", { noremap = true, silent = true })

-- columnmove. use gJ
vim.keymap.set("n", "J", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("n", "K", "<Nop>", { noremap = true, silent = true })

-- remap
vim.keymap.set("n", "gj", "j", { noremap = true, silent = true })
vim.keymap.set("n", "gk", "k", { noremap = true, silent = true })

-- move cursor
vim.keymap.set({ "n", "x" }, "j", function()
	return vim.v.count > 0 and "j" or "gj"
end, { noremap = true, expr = true })
vim.keymap.set({ "n", "x" }, "k", function()
	return vim.v.count > 0 and "k" or "gk"
end, { noremap = true, expr = true })
vim.keymap.set("n", "f", "w", { noremap = true, silent = true })
vim.keymap.set("n", "F", "W", { noremap = true, silent = true })

-- Automatically indent with i and A made by ycino
vim.keymap.set("n", "i", function()
	return string.len(vim.api.nvim_get_current_line()) ~= 0 and "i" or '"_cc'
end, { noremap = true, expr = true, silent = true })
vim.keymap.set("n", "A", function()
	return string.len(vim.api.nvim_get_current_line()) ~= 0 and "A" or '"_cc'
end, { noremap = true, expr = true, silent = true })

-- toggle 0, ^ made by ycino
vim.keymap.set("n", "0", function()
	return string.match(vim.api.nvim_get_current_line():sub(0, vim.api.nvim_win_get_cursor(0)[2]), "^%s+$") and "0"
		or "^"
end, { noremap = true, expr = true, silent = true })

for _, quote in ipairs({ '"', "'", "`" }) do
	vim.keymap.set({ "x", "o" }, "a" .. quote, "2i" .. quote)
end

vim.keymap.set("c", "<C-b>", "<Home>", { noremap = true, silent = false })
if not vim.g.vscode then
	vim.keymap.set("c", "<C-f>", "<End>", { noremap = true, silent = false })
end
vim.keymap.set("c", "<C-l>", "<right>", { noremap = true, silent = false })
vim.keymap.set("c", "<C-h>", "<left>", { noremap = true, silent = false })
vim.keymap.set("i", "<C-b>", "<Home>", { noremap = true, silent = false })
vim.keymap.set("i", "<C-f>", "<End>", { noremap = true, silent = false })
vim.keymap.set("i", "<C-h>", "<left>", { noremap = true, silent = false })
vim.keymap.set("i", "<C-l>", "<right>", { noremap = true, silent = false })
vim.keymap.set("i", "<C-k>", "<up>", { noremap = true, silent = false })
vim.keymap.set("i", "<C-j>", "<down>", { noremap = true, silent = false })

vim.keymap.set("c", "<C-e>", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("i", "<C-e>", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("c", "<C-a>", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("i", "<C-a>", "<Nop>", { noremap = true, silent = true })

-- remap H M L
vim.keymap.set("n", "gH", "H", { noremap = true, silent = true })
vim.keymap.set("n", "gM", "M", { noremap = true, silent = true })
vim.keymap.set("n", "gL", "L", { noremap = true, silent = true })

-- Clear highlighting
vim.keymap.set("n", "gq", "<Cmd>nohlsearch<CR>", { noremap = true, silent = true })

-- For search
vim.keymap.set("n", "*", "g*N", { noremap = true, silent = true })
vim.keymap.set("x", "*", 'y/<C-R>"<CR>N', { noremap = true, silent = true })

-- noremap # g#n
vim.keymap.set("x", "/", "<ESC>/\\%V", { noremap = true, silent = false })
vim.keymap.set("x", "?", "<ESC>?\\%V", { noremap = true, silent = false })

-- For replace
vim.keymap.set("n", "[_SubLeader]s", ":%s/\\<<C-r><C-w>\\>/", { noremap = true, silent = false })
vim.keymap.set("x", "[_SubLeader]s", ":s/\\%V", { noremap = true, silent = false })

-- insert mode undo delete
vim.keymap.set("i", "<C-d>", "<C-g>u<C-w>", { noremap = true, silent = true })
vim.keymap.set("i", "<C-u>", "<C-o>cc", { noremap = true, silent = true })

-- Delete buffer
vim.keymap.set("n", "[_SubLeader]db", "<Cmd>bdelete<CR>", { noremap = true, silent = true })
-- Delete Close Others
vim.keymap.set("n", "[_SubLeader]da", "<Cmd>BufferLineCloseOthers<CR>", { noremap = true, silent = true })

-- Delete all marks
vim.keymap.set("n", "[_SubLeader]dmb", "<Cmd>delmarks!<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "[_SubLeader]dma", function()
	if vim.fn.confirm("Delete all marks?", "&Yes\n&No", 2) == 1 then
		vim.cmd("delmarks a-zA-Z0-9")
		print("All marks deleted")
	end
end, { noremap = true, silent = true })

-- split
-- TODO: splitのサイズ調節するならコマンド入れる
vim.keymap.set("n", "<C-,>", "<Cmd>split<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-.>", "<Cmd>vsplit<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { noremap = true, silent = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true, silent = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })
vim.keymap.set("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })

-- indent
vim.keymap.set("x", "<", "<gv", { noremap = true, silent = true })
vim.keymap.set("x", ">", ">gv", { noremap = true, silent = true })

-- command mode
vim.keymap.set("c", "<C-x>", "<C-r>=expand('%:p:h')<CR>/", { noremap = true, silent = false }) -- expand path
vim.keymap.set("c", "<C-z>", "<C-r>=expand('%:p:r')<CR>", { noremap = true, silent = false }) -- expand file (not ext)
vim.keymap.set("c", "<Tab>", "<Down>", { noremap = true, silent = false })
vim.keymap.set("c", "<S-Tab>", "<Up>", { noremap = true, silent = false })

-- terminal mode
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = false })

-- quit
vim.keymap.set("n", "ZZ", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("n", "ZQ", "<Nop>", { noremap = true, silent = true })
