return {
  'iamcco/markdown-preview.nvim',
  enabled = vim.fn.executable('npm') == 1,
  cmd = { 'MarkdownPreview', 'MarkdownPreviewStop', 'MarkdownPreviewToggle' },
  ft = { 'markdown' },
  keys = {
    { '<leader>mp', '<cmd>MarkdownPreviewToggle<CR>', desc = 'Toggle Markdown preview' },
  },
  build = "cd app && git update-index --assume-unchanged yarn.lock && npm install",
  config = function()
    vim.g.mkdp_auto_start = 0
    vim.g.mkdp_auto_close = 1
    vim.g.mkdp_theme = 'dark'
  end,
}
