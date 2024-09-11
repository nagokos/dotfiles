vim.g.mapleader = " "

vim.o.shadafile = vim.fn.stdpath("state") .. "/shada/main.shada"
vim.o.complete = vim.o.complete .. ",k" -- Add dictionary file to completion
vim.o.completeopt = "menuone,noselect,noinsert"
vim.o.history = 10000
vim.o.timeout = true
vim.o.timeoutlen = 500
vim.o.ttimeoutlen = 10
vim.o.updatetime = 1000
vim.o.jumpoptions = "stack"
vim.o.mouse = "a"
vim.o.mousescroll = "ver:0,hor:0"
vim.g.editorconfig_enable = true

-- Tab
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 0
vim.o.list = false

-- Insert
vim.o.backspace = "indent,eol,start"             -- Backspaces to delete anything
vim.o.formatoptions = vim.o.formatoptions .. "m" -- Add formatting options, multi-byte system
vim.o.fixendofline = false

-- Command
vim.o.wildmenu = true -- Enhanced command completion
vim.o.wildmode = "longest,list,full"

-- Search
vim.o.wrapscan = true   -- Back to the top after searching to EOF
vim.o.ignorecase = true -- ignore upper and lower case letters
vim.o.smartcase = true  -- If I start with a capital letter, I don't ignore the case.
vim.o.incsearch = true  -- incremental search
vim.o.hlsearch = true   -- Highlight search text

-- Window
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.splitkeep = "cursor"
vim.o.equalalways = false

-- File
vim.o.autoread = true  -- Automatically reread if rewritten by others.
vim.o.swapfile = false -- No swap file is created.
vim.o.hidden = true    -- Allow other files to be opened while editing.
vim.o.directory = vim.fn.stdpath("state") .. "/swap/"
vim.fn.mkdir(vim.o.directory, "p")
vim.o.updatecount = 100
vim.o.undofile = true
vim.o.undodir = vim.fn.stdpath("state") .. "/undo/"
vim.fn.mkdir(vim.o.undodir, "p")
vim.o.modeline = false

-- clipboard
if vim.fn.has("clipboard") == 1 then
	vim.o.clipboard = "unnamedplus,unnamed"
end

-- beep sound
vim.o.errorbells = false
vim.o.visualbell = false

-- session
vim.o.sessionoptions = "buffers,curdir,tabpages,winsize,globals"

-- quickfix
vim.o.switchbuf = "useopen,uselast"

vim.o.pumblend = 0
vim.o.wildoptions = vim.o.wildoptions .. ",pum"
vim.o.spelllang = "en,cjk"
vim.opt_local.spelloptions:append("noplainbuffer")
vim.o.inccommand = "split"
vim.g.vimsyn_embed = "l"

-- diff
vim.o.diffopt = vim.o.diffopt .. ",vertical,internal,algorithm:patience,iwhite,indent-heuristic"

-- increment
vim.opt.nrformats:append("unsigned")
