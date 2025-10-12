vim.g.mapleader = " "
vim.opt.number = true
vim.opt.relativenumber = true
-- Infinite undo!!
vim.opt.undofile = true
-- default to case insensitive search
vim.opt.ignorecase = true
-- unless you use uppercase
vim.opt.smartcase = true
-- do not show a line break if it is not there
vim.opt.wrap = false
-- indentation
vim.opt.tabstop = 8
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = false
vim.opt.smartindent = true
vim.opt.background = "dark"
-- vim.opt.signcolumn = "yes"

vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('highlight_yank', {}),
  desc = 'Hightlight selection on yank',
  pattern = '*',
  callback = function()
    vim.highlight.on_yank { higroup = 'IncSearch', timeout = 500 }
  end,
})

