vim.g.mapleader = " "

local keymap = vim.keymap

-- exit normal mode
keymap.set("i", "jk", "<ESC>")

-- quick close
keymap.set("n", "<leader>qq", ":q<CR>")

-- remove highlights
keymap.set("n", "<leader>nn", ":nohl<CR>")

-- split window vertically/horizontally
keymap.set("n", "<leader>ss", "<C-w>v")
keymap.set("n", "<leader>sh", "<C-w>s")

-- new tab
keymap.set("n", "<leader>tt", ":tabnew<CR>")

-- next/prev tab
keymap.set("n", "<C-Right>", ":tabn<CR>")
keymap.set("n", "<C-Left>", ":tabp<CR>")

-- move between split
keymap.set("n", "<S-Right>", "<C-w>l")
keymap.set("n", "<S-Left>", "<C-w>h")
keymap.set("n", "<S-Up>", "<C-w>k")
keymap.set("n", "<S-Down>", "<C-w>j")

-- end/start of word
keymap.set({ "n", "v" }, "e", "e")
keymap.set({ "n", "v" }, "w", "b")

-- end/start of line
keymap.set({ "n", "v" }, "<S-e>", "$")
keymap.set({ "n", "v" }, "<S-w>", "_")

-- save with ctrl+s
keymap.set("n", "<C-s>", ":w! %<CR>")
