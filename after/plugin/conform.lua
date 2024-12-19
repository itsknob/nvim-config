require('conform').setup {
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format { async = true, lsp_fallback = true }
      end,
      mode = '',
      desc = '[F]ormat buffer after-plugin-conform',
    },
  },
  formatters_by_ft = {
    lua = { 'stylua' },
    -- Conform will run multiple formatters sequentially
    python = { 'isort', 'black' },
    -- Use a sub-list to run only the first available formatter
    javascript = { { 'prettierd', 'prettier' } },
    java = { 'google-java-format' },
  },
}

vim.keymap.set('n', '<leader>f', '<nop>', { desc = '[F]ormat after-plugin-conform-keymap' })
