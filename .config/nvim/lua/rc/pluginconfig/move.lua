vim.keymap.set('n', '<C-f>', ':MoveLine(1)<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-b>', ':MoveLine(-1)<CR>', { noremap = true, silent = true })
vim.keymap.set('v', '<C-f>', ':MoveBlock(1)<CR>', { noremap = true, silent = true })
vim.keymap.set('v', '<C-b>', ':MoveBlock(-1)<CR>', { noremap = true, silent = true })
