-- Database & Message Queue clients
-- SQL Server, PostgreSQL, MongoDB, Redis, RabbitMQ
-- Keymaps definidos en config/keymaps.lua
return {
  -- ============================================
  -- SQL DATABASES (SQL Server, PostgreSQL, MySQL, SQLite)
  -- ============================================
  {
    "tpope/vim-dadbod",
    cmd = { "DB", "DBUI", "DBUIToggle", "DBUIAddConnection" },
  },

  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
    },
    cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_show_database_icon = 1
      vim.g.db_ui_force_echo_notifications = 1
      
      vim.g.db_ui_icons = {
        expanded = "▾",
        collapsed = "▸",
        saved_query = "",
        new_query = "",
        tables = "󰓫",
        buffers = "",
        connection_ok = "✓",
        connection_error = "✕",
      }

      vim.g.db_ui_save_location = vim.fn.stdpath("data") .. "/db_ui"

      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "sql", "mysql", "plsql" },
        callback = function()
          vim.keymap.set("n", "<C-CR>", "<Plug>(DBUI_ExecuteQuery)", { buffer = true, desc = "Execute Query" })
          vim.keymap.set("v", "<C-CR>", "<Plug>(DBUI_ExecuteQuery)", { buffer = true, desc = "Execute Selection" })
          vim.keymap.set("n", "<leader>W", "<Plug>(DBUI_SaveQuery)", { buffer = true, desc = "Save Query" })
        end,
      })
    end,
    keys = {
      { "<leader>Ds", "<cmd>DBUIToggle<cr>", desc = "SQL: Toggle DB UI" },
      { "<leader>Da", "<cmd>DBUIAddConnection<cr>", desc = "SQL: Add Connection" },
      { "<leader>Df", "<cmd>DBUIFindBuffer<cr>", desc = "SQL: Find Buffer" },
    },
  },

  {
    "kristijanhusak/vim-dadbod-completion",
    ft = { "sql", "mysql", "plsql" },
    dependencies = { "hrsh7th/nvim-cmp" },
    config = function()
      local cmp = require("cmp")
      cmp.setup.filetype({ "sql", "mysql", "plsql" }, {
        sources = cmp.config.sources({
          { name = "vim-dadbod-completion" },
          { name = "buffer" },
        }),
      })
    end,
  },

  -- ============================================
  -- WHICH-KEY GROUP
  -- ============================================
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>D", group = "Database/MQ", icon = "" },
      },
    },
  },
}
