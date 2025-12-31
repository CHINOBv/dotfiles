-- Roslyn LSP para C# (requiere .NET 10)
return {
  -- Desactivar omnisharp
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        omnisharp = false,
      },
    },
  },

  -- Roslyn.nvim - LSP moderno para C#
  {
    "seblj/roslyn.nvim",
    ft = "cs",
    opts = {
      filewatching = "roslyn",
      broad_search = true,
      lock_target = false,
    },
    config = function(_, opts)
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and client.name == "roslyn" then
            local map = function(keys, func, desc)
              vim.keymap.set("n", keys, func, { buffer = args.buf, desc = "LSP: " .. desc })
            end

            map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
            map("<leader>cr", vim.lsp.buf.rename, "Rename")
            map("<leader>cf", function() vim.lsp.buf.format({ async = true }) end, "Format")
            map("gd", vim.lsp.buf.definition, "Go to Definition")
            map("gr", vim.lsp.buf.references, "Go to References")
            map("gi", vim.lsp.buf.implementation, "Go to Implementation")
            map("gt", vim.lsp.buf.type_definition, "Go to Type Definition")
            map("K", vim.lsp.buf.hover, "Hover Documentation")
            map("<leader>cs", vim.lsp.buf.signature_help, "Signature Help")
            map("[d", vim.diagnostic.goto_prev, "Previous Diagnostic")
            map("]d", vim.diagnostic.goto_next, "Next Diagnostic")
            map("<leader>cd", vim.diagnostic.open_float, "Line Diagnostics")

            -- Organize imports on demand
            map("<leader>co", function()
              vim.lsp.buf.code_action({
                apply = true,
                context = { only = { "source.organizeImports" } },
              })
            end, "Organize Imports")

            -- Add missing import (quick fix)
            map("<leader>ci", function()
              vim.lsp.buf.code_action({
                apply = true,
                context = { only = { "quickfix" } },
                filter = function(action)
                  return action.title and action.title:match("using")
                end,
              })
            end, "Add Missing Import")
          end
        end,
      })

      -- Auto organize imports on save for C# files
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.cs",
        callback = function()
          vim.lsp.buf.code_action({
            apply = true,
            context = { only = { "source.organizeImports" } },
          })
        end,
      })

      require("roslyn").setup(opts)
    end,
  },

  -- Treesitter para C#
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "c_sharp" })
      end
    end,
  },
}
