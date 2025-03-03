return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons', opt = true },
  config = function()
    require("lualine").setup({
      options = {
        there = "catppuccin"
      }
    })
  end
}
