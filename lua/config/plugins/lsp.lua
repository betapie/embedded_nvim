local on_attach = function(client, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }

  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, opts)
  vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', '<leader>ld', vim.diagnostic.open_float, opts)
  vim.keymap.set('n', ']d', function()
    vim.diagnostic.jump { count = 1 }
  end, opts)
  vim.keymap.set('n', '[d', function()
    vim.diagnostic.jump { count = -1 }
  end, opts)
  vim.keymap.set('n', '<leader>lf', function()
    vim.lsp.buf.format({ async = true })
  end, opts)
end

return {
  'neovim/nvim-lspconfig',
  config = function()
    local capabilities = require('blink.cmp').get_lsp_capabilities()
    if vim.fn.executable('lua-language-server') == 1 then
      vim.lsp.config('lua_ls', {
        capabilities = capabilities,
        on_init = function(client)
          if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if path ~= vim.fn.stdpath('config') and (vim.ui.fs_stat(path .. '/.luarc.json')
                  or vim.ui.fs_stat(path .. '/.luarc.jsonc')) then
              return
            end
          end

          client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = {
              version = 'LuaJIT'
            },
            -- Make the server aware of Neovim runtime files
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME,
                -- Depending on the usage, you might want to add additional paths here.
                -- '${3rd}/luv/library'
                -- '${3rd}/busted/library',
              }
            }
          })
        end,
        on_attach = on_attach,
        settings = {
          Lua = {}
        }
      })
      vim.lsp.enable('lua_ls')
    end
    if vim.fn.executable('clangd') == 1 then
      vim.lsp.config('clangd', {
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          on_attach(client, bufnr)
          vim.keymap.set("n", "<leader>ls", function()
            vim.lsp.buf_request(
              0,
              "textDocument/switchSourceHeader",
              { uri = vim.uri_from_bufnr(0) },
              function(err, result)
                if err then
                  vim.notify(err.message or "Clangd switch failed", vim.log.levels.ERROR)
                  return
                end
                if not result then
                  vim.notify("No corresponding file found", vim.log.levels.WARN)
                  return
                end
                vim.cmd.edit(vim.uri_to_fname(result))
              end
            )
          end, { buffer = bufnr, desc = "Clangd switch source/header" })
        end
      })
      vim.lsp.enable('clangd')
    end
    if vim.fn.executable('rust-analyzer') == 1 then
      vim.lsp.config('rust_analyzer', {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          ["rust-analyzer"] = {
            cargo = {
              allFeatures = true,
            },
            checkOnSave = true,
            check = {
              command = "clippy", -- or "check" if you prefer speed over lints
            },
            diagnostics = {
              enable = true, -- should be on by default
            },
          },
        }
      })
      vim.lsp.enable('rust_analyzer')
    end
  end
}
