-- Diagnosticos y Quick Fixes (similar a VSCode Problems panel)
return {
  -- Trouble - Panel de diagnosticos mejorado
  {
    "folke/trouble.nvim",
    cmd = { "Trouble", "TroubleToggle" },
    opts = {
      position = "bottom",
      height = 12,
      icons = true,
      mode = "workspace_diagnostics",
      fold_open = "",
      fold_closed = "",
      group = true,
      padding = true,
      action_keys = {
        close = "q",
        cancel = "<esc>",
        refresh = "r",
        jump = { "<cr>", "<tab>" },
        open_split = { "<c-x>" },
        open_vsplit = { "<c-v>" },
        open_tab = { "<c-t>" },
        jump_close = { "o" },
        toggle_mode = "m",
        toggle_preview = "P",
        hover = "K",
        preview = "p",
        close_folds = { "zM", "zm" },
        open_folds = { "zR", "zr" },
        toggle_fold = { "zA", "za" },
        previous = "k",
        next = "j",
      },
      signs = {
        error = "",
        warning = "",
        hint = "",
        information = "",
        other = "",
      },
      use_diagnostic_signs = true,
    },
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics" },
      { "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
      { "<leader>xl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP Definitions/References" },
      { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List" },
      { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List" },
      -- Navegacion rapida con [ y ]
      {
        "[q",
        function()
          if require("trouble").is_open() then
            require("trouble").prev({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cprev)
            if not ok then vim.notify(err, vim.log.levels.ERROR) end
          end
        end,
        desc = "Previous Trouble/Quickfix"
      },
      {
        "]q",
        function()
          if require("trouble").is_open() then
            require("trouble").next({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cnext)
            if not ok then vim.notify(err, vim.log.levels.ERROR) end
          end
        end,
        desc = "Next Trouble/Quickfix"
      },
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

  -- Lsp Lines - Mostrar diagnosticos como lineas virtuales (alternativa)
  -- Descomenta si prefieres este estilo sobre tiny-inline-diagnostic
  -- {
  --   "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  --   event = "LspAttach",
  --   config = function()
  --     require("lsp_lines").setup()
  --     vim.diagnostic.config({ virtual_text = false })
  --   end,
  -- },

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
