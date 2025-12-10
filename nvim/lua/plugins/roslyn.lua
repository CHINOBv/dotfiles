-- Roslyn LSP para C#
return {
  -- Desactivar omnisharp de LazyVim
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
    init = function()
      -- Agregar roslyn al PATH si no está
      local roslyn_path = vim.fn.stdpath("data") .. "/roslyn"
      local current_path = vim.env.PATH or ""
      if not current_path:find(roslyn_path, 1, true) then
        vim.env.PATH = roslyn_path .. ";" .. current_path
      end
    end,
    opts = {
      filewatching = "auto",
      broad_search = true,
      lock_target = false,
    },
    config = function(_, opts)
      -- Keymaps para C#
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
            map("<leader>ch", function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
            end, "Toggle Inlay Hints")
          end
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
