-- Highlight todo, notes, etc in comments

vim.keymap.set('n', ']t', function()
  require('todo-comments').jump_next()
end, { desc = 'Next todo comment' })

vim.keymap.set('n', '[t', function()
  require('todo-comments').jump_prev()
end, { desc = 'Previous todo comment' })

return {
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      signs = false,
      keywords = {
        TODO = { alt = { 'todo' } },
      },
      highlight = {
        comments_only = false,
        pattern = {
          [[.*<(KEYWORDS)\s*[:!].]],
        },
      },
      search = {
        pattern = [[\b(KEYWORDS)\b]],
      },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
