vim.g.rustaceanvim = {
  server = {
    cmd = function()
      local mason_registry = require 'mason-registry'
      local ra_binary = mason_registry.is_installed 'rust-analyzer'
          -- This may need to be tweaked, depending on the operating system.
          and mason_registry.get_package('rust-analyzer'):get_install_path() .. '/rust-analyzer'
        or 'rust-analyzer'
      return { ra_binary } -- You can add args to the list, such as '--log-file'
    end,
    on_attach = function()
      vim.keymap.set('n', '<F5>', ':RustLsp debuggables\r', { silent = true, desc = 'Debug: Start/Continue' })
    end,
  },
}

return {
  'mrcjkb/rustaceanvim',
  version = '^5', -- Recommended
  lazy = false, -- This plugin is already lazy
  ['rust-analyzer'] = {
    cargo = {
      allFeatures = true,
    },
  },
}
