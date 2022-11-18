vim.g.mapleader = " "
vim.opt.number = true              -- add number lines
vim.opt.mouse = "a"                -- add ability to use mouse 
vim.opt.relativenumber = true      -- relative numbers
vim.opt.tabstop = 4 
vim.opt.softtabstop = 0            -- ? was set to 4
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.expandtab = true           -- convert tabs into spaces
vim.opt.hidden = true              -- use hidden buffers
vim.opt.wrap = false               -- wrap line
vim.opt.incsearch = true           -- search while you type
vim.opt.scrolloff = 8              -- keep n distance from top and bottom of the screen
vim.opt.signcolumn = "yes"         -- add column on the left for icons, errors etc.
vim.opt.undofile=true              -- save file history?
vim.opt.clipboard = "unnamedplus"  -- sync nvim with system clipboard

require'lspconfig'.tsserver.setup {}
require('keymap')

vim.cmd([[
colorscheme material
set undodir=~/.vim/undodir
command! -nargs=0 Prettier :CocCommand prettier.forceFormatDocument
]])
--if (has("termguicolors")) 
--    set termguicolors
--endif
