-- Diagnosticos y Quick Fixes (similar a VSCode Problems panel)
return {
  -- Trouble v3 - Panel de diagnosticos mejorado
  {
    "folke/trouble.nvim",
    opts = {
      modes = {
        diagnostics = {
          auto_close = false,
          auto_open = false,
          auto_preview = true,
          auto_refresh = true,
          focus = true,
          win = { position = "bottom", size = 12 },
        },
      },
    },
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics" },
      { "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
      { "<leader>xl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP Definitions/References" },
      { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List" },
      { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List" },
    },
  },

  -- Mejorar la UI de diagnosticos inline
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "LspAttach",
    priority = 1000,
    config = function()
      -- Desactivar virtual text default de vim
      vim.diagnostic.config({ virtual_text = false })
      
      require("tiny-inline-diagnostic").setup({
        preset = "modern",
        options = {
          show_source = true,
          throttle = 100,
          multilines = true,
          show_all_diags_on_cursorline = true,
        },
      })
    end,
  },

  -- Keymaps adicionales para diagnosticos
  {
    "neovim/nvim-lspconfig",
    opts = function()
      -- Keymaps globales para diagnosticos
      local keys = {
        { "[d", vim.diagnostic.goto_prev, desc = "Previous Diagnostic" },
        { "]d", vim.diagnostic.goto_next, desc = "Next Diagnostic" },
        { "[e", function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR }) end, desc = "Previous Error" },
        { "]e", function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR }) end, desc = "Next Error" },
        { "[w", function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.WARN }) end, desc = "Previous Warning" },
        { "]w", function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARN }) end, desc = "Next Warning" },
        { "<leader>cd", vim.diagnostic.open_float, desc = "Line Diagnostics (float)" },
        { "<leader>cl", "<cmd>LspInfo<cr>", desc = "LSP Info" },
      }

      for _, key in ipairs(keys) do
        vim.keymap.set("n", key[1], key[2], { desc = key.desc })
      end
    end,
  },
}
