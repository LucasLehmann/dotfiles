vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.tabstop = 4
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.showmode = false
vim.opt.clipboard = 'unnamedplus'
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>') 
vim.api.nvim_create_autocmd('TextYankPost', {callback = function() vim.hl.on_yank() end})

vim.keymap.set('n', '<leader>r', ':make<CR>', { desc = 'Run :make' })

local gh = function(x) return 'https://github.com/' .. x end
local cb = function(x) return 'https://codeberg.org/' .. x end

vim.pack.add{
  gh'neovim/nvim-lspconfig',
  gh'catppuccin/nvim',
  gh'mbbill/undotree',
  gh'tpope/vim-sleuth',
  gh'lewis6991/gitsigns.nvim',
  gh'folke/which-key.nvim',
  gh'ThePrimeagen/vim-be-good',
  gh'lukas-reineke/indent-blankline.nvim',
}
vim.cmd.colorscheme 'catppuccin-mocha'
vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = 'Toggle Undotree' })
require('ibl').setup()
vim.lsp.enable'clangd'
-- debugger dap?
-- formating conform?
-- linting nvim-lint?
-- auto install lsps linters and formaters, mason-lspconfig?

-- make more shortcuts for telescope
vim.pack.add{gh'nvim-lua/plenary.nvim', gh'nvim-telescope/telescope-ui-select.nvim',gh'nvim-telescope/telescope-fzf-native.nvim',gh'nvim-telescope/telescope.nvim'}
local builtin = require'telescope.builtin'
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
-- vim: ts=2 sts=2 sw=2 et
