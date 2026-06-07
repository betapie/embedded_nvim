if vim.fn.executable('npm') == 0 then
  return
end

return {
  'iamcco/markdown-preview.nvim',
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
