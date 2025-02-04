return {
  {
    'mbbill/undotree',
    config = function()
      if vim.fn.has 'win32' or vim.fn.has 'win64' then
        vim.g.undotree_DiffCommand = 'FC'
      elseif vim.fn.has 'unix' then
        vim.g.undotree_DiffCommand = 'diff'
      end
      vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = 'Toggle Undotree' })
    end,
  },
}
