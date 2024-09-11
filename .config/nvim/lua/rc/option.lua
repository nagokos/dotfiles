vim.g.mapleader = " "

vim.g["markdown_recommended_style"] = 0
vim.opt.breakindent = true
vim.opt.number = false
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.virtualedit = "block"
vim.opt.showtabline = 1
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.completeopt = 'menu,menuone,noselect'
vim.opt.laststatus = 3
vim.opt.scrolloff = 100
vim.opt.cursorline = true
vim.opt.helplang = 'ja'
vim.opt.autowrite = true
vim.opt.swapfile = false
vim.opt.showtabline = 1
vim.opt.diffopt = 'vertical,internal'
vim.opt.clipboard:append({ vim.fn.has('mac') == 1 and 'unnamed' or 'unnamedplus' })
vim.opt.grepprg = 'rg --vimgrep'
vim.opt.grepformat = '%f:%l:%c:%m'
vim.opt.mouse = {}
--vim.opt.foldmethod = 'expr'
--vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

-- persistent undo
vim.o.undofile = true
vim.o.undodir = vim.fn.stdpath("state") .. "/undo/"
vim.fn.mkdir(vim.o.undodir, "p")
