vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.list = true
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = '80,120,160'
vim.opt.linebreak = true
vim.g.mapleader = " "
vim.api.nvim_create_autocmd('TextYankPost', {callback = function() vim.hl.on_yank() end})
vim.keymap.set('n', '<esc>', '<cmd>nohlsearch<CR><esc>',  {desc = "Clear highlight fom search"})
vim.keymap.set('n', '<f5>', '<cmd>make<CR>', {desc = 'run :make'})
local gh = function(x) return 'https://github.com/' .. x end
vim.pack.add{
  gh'neovim/nvim-lspconfig',
  gh'catppuccin/nvim',
  gh'mbbill/undotree',
  gh'tpope/vim-sleuth',
  gh'lewis6991/gitsigns.nvim',
  gh'folke/which-key.nvim',
  gh'github/copilot.vim',
  gh'chomosuke/typst-preview.nvim'
}
require'typst-preview'.setup{invert_colors='always'}
vim.g.copilot_enabled = false
vim.cmd.colorscheme 'catppuccin-mocha'
vim.lsp.enable{'clangd', 'ols', 'pyright', 'tinymist', 'rust-analyzer' }

vim.keymap.set('n', '<M-u>', vim.cmd.UndotreeToggle, { desc = 'Toggle Undotree' })
vim.api.nvim_create_autocmd("FileType", {
  pattern = "typst",
  callback = function(args)
    vim.opt_local.columns = 80
    vim.keymap.set('n', '<leader>p', '<cmd>TypstPreview<CR>',  { buffer = args.buf })
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "txt", "md", "typst" },
  callback = function(args)
    vim.opt.spell = true
    vim.opt.spelllang = { "nb", "en" }
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = {"c", "cpp"},
  callback = function()
    local has_makefile = vim.fn.glob("[mM][aA][kK][eE][fF][iI][lL][eE]") ~= ""
    if not has_makefile then
      -- Wanting to use this one instead but it wouldnt work on winodws
      -- the other one makes it annoying to tab complete :)
      -- vim.bo.makeprg = "gcc % && ./a.out"
      vim.bo.makeprg = "gcc % -o %< && ./%<"
    end
  end,
})

require'which-key'.add{
  { '<leader>h', group = "gitsigns hunk"},
  { '<leader>t', group = "gitsigns toggle"},
}

require'gitsigns'.setup{
  on_attach = function(bufnr)
    local gitsigns = require('gitsigns')

    map = vim.keymap.set
    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then
        vim.cmd.normal({']c', bang = true})
      else
        gitsigns.nav_hunk('next')
      end
    end, {desc = "Next hunk"})

    map('n', '[c', function()
      if vim.wo.diff then
        vim.cmd.normal({'[c', bang = true})
      else
        gitsigns.nav_hunk('prev')
      end
    end, {desc = "Previous hunk"})

    -- Actions
    map('n', '<leader>hs', gitsigns.stage_hunk, {desc = "Stage hunk"})
    map('n', '<leader>hr', gitsigns.reset_hunk, {desc = "Reset hunk"})

    map('v', '<leader>hs', function()
      gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end)

    map('v', '<leader>hr', function()
      gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end)

    map('n', '<leader>hS', gitsigns.stage_buffer, {desc = "Stage buffer"})
    map('n', '<leader>hR', gitsigns.reset_buffer, {desc = "Reset buffer"})
    map('n', '<leader>hp', gitsigns.preview_hunk, {desc = "Preview hunk"})
    map('n', '<leader>hi', gitsigns.preview_hunk_inline, {desc = "Preview hunk inline"})

    map('n', '<leader>hb', function()
      gitsigns.blame_line({ full = true })
    end, {desc = "Blame line"})

    map('n', '<leader>hd', gitsigns.diffthis, {desc = "Diffthis"})

    map('n', '<leader>hD', function()
      gitsigns.diffthis('~')
    end, {desc = "Diff against last commit"})

    map('n', '<leader>hQ', function() gitsigns.setqflist('all') end, {desc = "Set quickfixlist with all buffers"})
    map('n', '<leader>hq', gitsigns.setqflist, {desc = "Set quickfixlist"})

    -- Toggles
    map('n', '<leader>tb', gitsigns.toggle_current_line_blame, {desc = "Toggle current line blame"})
    map('n', '<leader>tw', gitsigns.toggle_word_diff, {desc = "Toggle world diff"})

    -- Text object
    map({'o', 'x'}, 'ih', gitsigns.select_hunk, {desc = "inner hunk"})
  end
}
