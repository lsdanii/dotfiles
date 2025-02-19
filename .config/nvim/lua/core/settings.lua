local opt = vim.opt

vim.g.mapleader = " "

opt.number = true
opt.relativenumber = true
-- do not show a line break if it is not there
opt.wrap = false
opt.clipboard:append("unnamedplus") -- copy to system clipboard
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.smartindent = true

opt.termguicolors = true
opt.background = "dark"
opt.cursorline = false
-- infinite undo!
-- NOTE: ends up in ~/.local/state/nvim/undo/
vim.opt.undofile = true

vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

vim.keymap.set('n', '<leader>;', '<cmd>Buffers<cr>')
