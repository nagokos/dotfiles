-- custom leader
vim.keymap.set({ "n", "x" }, "[_SubLeader]", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", ",", "[_SubLeader]", {})
vim.api.nvim_set_keymap("x", ",", "[_SubLeader]", {})

-- [_FuzzyFinder]
vim.keymap.set({ "n", "x" }, "f", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "[_FuzzyFinder]", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "[_FuzzyFinder]", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "f", "[_FuzzyFinder]", {})
vim.api.nvim_set_keymap("v", "f", "[_FuzzyFinder]", {})

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

-- <Nop>
vim.keymap.set("n", "gh", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("n", "gj", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("n", "gk", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("n", "gl", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("n", "gn", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("n", "gm", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("n", "go", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("n", "gq", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("n", "gr", "<Nop>", { noremap = true, silent = true })
-- vim.keymap.set("n", "gs", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("n", "gw", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("n", "g^", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("n", "g?", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("n", "gQ", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("n", "gR", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("n", "gT", "<Nop>", { noremap = true, silent = true })

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

-- Emacs style
vim.keymap.set("c", "<C-a>", "<Home>", { noremap = true, silent = false })
if not vim.g.vscode then
  vim.keymap.set("c", "<C-e>", "<End>", { noremap = true, silent = false })
end
vim.keymap.set("c", "<C-f>", "<right>", { noremap = true, silent = false })
vim.keymap.set("c", "<C-b>", "<left>", { noremap = true, silent = false })
vim.keymap.set("c", "<C-d>", "<DEL>", { noremap = true, silent = false })
-- vim.keymap.set('c', '<C-h>', '<BS>', {noremap = true, silent = true})
vim.keymap.set("c", "<C-s>", "<BS>", { noremap = true, silent = false })
vim.keymap.set("i", "<C-a>", "<Home>", { noremap = true, silent = false })
vim.keymap.set("i", "<C-e>", "<End>", { noremap = true, silent = false })
vim.keymap.set("i", "<C-f>", "<right>", { noremap = true, silent = false })
vim.keymap.set("i", "<C-b>", "<left>", { noremap = true, silent = false })
vim.keymap.set("i", "<C-h>", "<left>", { noremap = true, silent = false })
vim.keymap.set("i", "<C-l>", "<right>", { noremap = true, silent = false })
vim.keymap.set("i", "<C-k>", "<up>", { noremap = true, silent = false })
vim.keymap.set("i", "<C-j>", "<down>", { noremap = true, silent = false })

-- remap H M L
vim.keymap.set("n", "gH", "H", { noremap = true, silent = true })
vim.keymap.set("n", "gM", "M", { noremap = true, silent = true })
vim.keymap.set("n", "gL", "L", { noremap = true, silent = true })

-- Clear highlighting
vim.keymap.set("n", "gq", "<Cmd>nohlsearch<CR>", { noremap = true, silent = true })

-- lambdalisue's yank for slack
vim.keymap.set("x", "[_SubLeader]y", function()
  vim.cmd.normal({ "y", bang = true })
  local content = vim.fn.getreg(vim.v.register, 1, true)
  local spaces = {}
  for _, v in ipairs(content) do
    table.insert(spaces, string.match(v, "%s*"):len())
  end
  table.sort(spaces)
  local leading = spaces[1]
  local content_new = {}
  for _, v in ipairs(content) do
    table.insert(content_new, string.sub(v, leading + 1))
  end
  vim.fn.setreg(vim.v.register, content_new, vim.fn.getregtype(vim.v.register))
end, { noremap = true, silent = true })

-- paste
vim.keymap.set({ "n", "x" }, "p", "]p", { noremap = true, silent = true })
vim.keymap.set({ "n", "x" }, "gp", "p", { noremap = true, silent = true })
vim.keymap.set({ "n", "x" }, "gP", "P", { noremap = true, silent = true })
vim.keymap.set({ "n", "x" }, "<LocalLeader>p", '"+p', { noremap = true, silent = true })
vim.keymap.set({ "n", "x" }, "<LocalLeader>P", '"+P', { noremap = true, silent = true })

-- Increment / Decrement
vim.keymap.set({ "n", "x" }, "+", "<C-a>", { noremap = true, silent = true })
vim.keymap.set({ "n", "x" }, "_", "<C-x>", { noremap = true, silent = true })

-- switch quickfix/location list
vim.keymap.set("n", "[_SubLeader]q", "<Cmd>copen<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "[_SubLeader]l", "<Cmd>lopen<CR>", { noremap = true, silent = true })

-- For search
vim.keymap.set("n", "g/", "/\\v", { noremap = true, silent = false })
vim.keymap.set("n", "*", "g*N", { noremap = true, silent = true })
vim.keymap.set("x", "*", 'y/<C-R>"<CR>N', { noremap = true, silent = true })

-- noremap # g#n
vim.keymap.set({ "n", "x" }, "g*", "*N", { noremap = true, silent = true })
vim.keymap.set({ "n", "x" }, "g#", "#n", { noremap = true, silent = true })
vim.keymap.set("x", "/", "<ESC>/\\%V", { noremap = true, silent = false })
vim.keymap.set("x", "?", "<ESC>?\\%V", { noremap = true, silent = false })

-- For replace
vim.keymap.set("n", "gr", "gd[{V%::s/<C-R>///gc<left><left><left>", { noremap = true, silent = false })
vim.keymap.set("n", "gR", "gD:%s/<C-R>///gc<left><left><left>", { noremap = true, silent = false })
vim.keymap.set("n", "[_SubLeader]s", ":%s/\\<<C-r><C-w>\\>/", { noremap = true, silent = false })
vim.keymap.set("x", "[_SubLeader]s", ":s/\\%V", { noremap = true, silent = false })

-- Undoable<C-w> <C-u>
vim.keymap.set("i", "<C-w>", "<C-g>u<C-w>", { noremap = true, silent = true })
vim.keymap.set("i", "<C-u>", "<C-g>u<C-u>", { noremap = true, silent = true })

-- Delete buffer
vim.keymap.set("n", "[_SubLeader]db", "<Cmd>bdelete<CR>", { noremap = true, silent = true })

-- Delete Close Others
vim.keymap.set("n", "[_SubLeader]da", "<Cmd>BufferLineCloseOthers<CR>", { noremap = true, silent = true })

-- Delete all marks
vim.keymap.set("n", "[_SubLeader]dm", "<Cmd>delmarks!<CR>", { noremap = true, silent = true })

-- split
vim.keymap.set("n", "<C-,>", "<Cmd>split<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-.>", "<Cmd>vsplit<CR>", { noremap = true, silent = true })

-- indent
vim.keymap.set("x", "<", "<gv", { noremap = true, silent = true })
vim.keymap.set("x", ">", ">gv", { noremap = true, silent = true })

-- command mode
vim.keymap.set("c", "<C-x>", "<C-r>=expand('%:p:h')<CR>/", { noremap = true, silent = false }) -- expand path
vim.keymap.set("c", "<C-z>", "<C-r>=expand('%:p:r')<CR>", { noremap = true, silent = false })  -- expand file (not ext)
vim.keymap.set("c", "<C-p>", "<Up>", { noremap = true, silent = false })
vim.keymap.set("c", "<C-n>", "<Down>", { noremap = true, silent = false })

-- terminal mode
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = false })

-- quit
vim.keymap.set("n", "ZZ", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("n", "ZQ", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("n", "ZZ", "zz", { noremap = true, silent = true })
