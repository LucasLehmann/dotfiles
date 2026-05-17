vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.list = true
vim.api.nvim_create_autocmd('TextYankPost', {callback = function() vim.hl.on_yank() end})

local gh = function(x) return 'https://github.com/' .. x end
vim.pack.add{
  gh'neovim/nvim-lspconfig',
  gh'catppuccin/nvim',
  gh'mbbill/undotree',
  gh'tpope/vim-sleuth',
  gh'lewis6991/gitsigns.nvim',
  gh'folke/which-key.nvim',
}
vim.cmd.colorscheme 'catppuccin-mocha'
vim.keymap.set('n', '<M-u>', vim.cmd.UndotreeToggle, { desc = 'Toggle Undotree' })
vim.lsp.enable{'clangd', 'ols'}
