local map = vim.keymap.set
local options = { noremap = true }

map("n", "<A-j>", ":m +1<CR>==", options)
map("n", "<A-k>", ":m -2<CR>==", options)
map("n", "<Leader>vb", ":Telescope find_files cwd=~/AppData/Local/nvim/ search_dirs=Ultisnips,lua,viml,init.vim<cr>", options)
map("n", "<F5>", ":UndotreeToggle<CR>", options)
map("n", "<C-n>", ":NERDTreeToggle<CR>", options)

local builtin = require('telescope.builtin')
map('n', '<leader>ff', builtin.find_files, {})
map('n', '<leader>fg', builtin.live_grep, {})
map('n', '<leader>fb', builtin.buffers, {})
map('n', '<leader>fh', builtin.help_tags, {})

