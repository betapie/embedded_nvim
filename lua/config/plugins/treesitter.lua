return { {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  config = function()
    vim.api.nvim_create_autocmd('VimEnter', {
      once = true,
      callback = function()
        local want = { 'c', 'cpp', 'lua', 'vim', 'vimdoc', 'query', 'html', 'json', 'markdown' }
        local have = require('nvim-treesitter.config').get_installed()
        local to_install = vim.iter(want):filter(function(p)
          return not vim.tbl_contains(have, p)
        end):totable()
        if #to_install > 0 then
          require('nvim-treesitter').install(to_install)
        end
      end,
    })

    vim.api.nvim_create_autocmd('FileType', {
      callback = function(ev)
        local buf = ev.buf
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
          return
        end
        pcall(vim.treesitter.start, buf)
        vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end
} }
