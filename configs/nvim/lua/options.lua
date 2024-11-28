local opt = vim.opt

-- line numbers
opt.relativenumber = true
opt.number = true

-- tabs & indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.autoindent = true
opt.expandtab = true

-- search settings
opt.ignorecase = true
opt.smartcase = true

-- use system clipboard
-- DEPRECATED?
opt.clipboard:append("unnamedplus")

-- split windows
opt.splitright = true
opt.splitbelow = true

-- include - as part of word
-- opt.iskeyword:append("-")

-- turn off swapfile
opt.swapfile = false

-- always display diagnostic signs to avoid right-shift
opt.signcolumn = "yes"
