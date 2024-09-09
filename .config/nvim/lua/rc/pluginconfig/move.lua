require("move").setup()

vim.keymap.set("n", "<C-n>", ":MoveLine(1)<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-p>", ":MoveLine(-1)<CR>", { noremap = true, silent = true })
vim.keymap.set("v", "<C-n>", ":MoveBlock(1)<CR>", { noremap = true, silent = true })
vim.keymap.set("v", "<C-p>", ":MoveBlock(-1)<CR>", { noremap = true, silent = true })
