-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  -- theme
  use 'drewtempelmeyer/palenight.vim'
  -- left sidebar tree
  use 'preservim/nerdtree'
  -- the bar at the bottom
  use 'vim-airline/vim-airline'
  -- theme for the airline
  use 'vim-airline/vim-airline-themes'
  -- telescope dependencie
  use 'nvim-lua/plenary.nvim'
  -- search thing
  use 'nvim-telescope/telescope.nvim'
  -- dashboard
  use 'glepnir/dashboard-nvim'
  -- lsp setup
  use 'neovim/nvim-lspconfig'
  -- another theme
  use 'kaicataldo/material.vim'
  -- fzf (fuzzy finder)
  use { 'junegunn/fzf', run = ':call fzf#install()' }
  -- fzf vim plugin itself
  use 'junegunn/fzf.vim'
  -- icons
  use 'nvim-tree/nvim-web-devicons'
  -- add undo tree
  use 'mbbill/undotree'
  -- grep for telescope
  use 'BurntSushi/ripgrep'
  -- autocomplete
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  -- snippets
  use({"L3MON4D3/LuaSnip", tag = "v<CurrentMajor>.*"})
  -- connect luasnip with cmp
  use 'saadparwaiz1/cmp_luasnip'
end)
