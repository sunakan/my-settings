-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- markdownの ``` などの非表示をやめる
vim.opt.conceallevel = 0

-- 番号を表示
-- 相対行番号を無効
vim.opt.number = true
vim.opt.relativenumber = false

vim.cmd([[
  highlight LineNr guifg=#9966cc guibg=NONE
]])
