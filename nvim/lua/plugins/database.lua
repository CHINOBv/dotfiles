-- Database & Message Queue clients
-- SQL Server, PostgreSQL, MongoDB, Redis, RabbitMQ
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
  -- MONGODB
  -- ============================================
  {
    "tpope/vim-dadbod",
    -- MongoDB se soporta via dadbod con mongosh
    -- Connection string: mongodb://user:pass@localhost:27017/database
  },

  -- ============================================
  -- REDIS
  -- ============================================
  -- Redis CLI integrado via terminal
  {
    "akinsho/toggleterm.nvim",
    keys = {
      { 
        "<leader>Dr", 
        function()
          local Terminal = require("toggleterm.terminal").Terminal
          local redis = Terminal:new({
            cmd = "redis-cli",
            direction = "float",
            hidden = true,
            float_opts = {
              border = "curved",
              width = function() return math.floor(vim.o.columns * 0.8) end,
              height = function() return math.floor(vim.o.lines * 0.8) end,
            },
            on_open = function(term)
              vim.cmd("startinsert!")
            end,
          })
          redis:toggle()
        end,
        desc = "Redis: Open CLI" 
      },
      {
        "<leader>DR",
        function()
          local host = vim.fn.input("Redis Host [localhost]: ")
          if host == "" then host = "localhost" end
          local port = vim.fn.input("Redis Port [6379]: ")
          if port == "" then port = "6379" end
          local password = vim.fn.inputsecret("Redis Password (empty for none): ")
          
          local cmd = "redis-cli -h " .. host .. " -p " .. port
          if password ~= "" then
            cmd = cmd .. " -a " .. password
          end
          
          local Terminal = require("toggleterm.terminal").Terminal
          local redis = Terminal:new({
            cmd = cmd,
            direction = "float",
            hidden = true,
            float_opts = {
              border = "curved",
              width = function() return math.floor(vim.o.columns * 0.8) end,
              height = function() return math.floor(vim.o.lines * 0.8) end,
            },
            on_open = function(term)
              vim.cmd("startinsert!")
            end,
          })
          redis:toggle()
        end,
        desc = "Redis: Connect to Server"
      },
    },
  },

  -- ============================================
  -- RABBITMQ
  -- ============================================
  {
    "akinsho/toggleterm.nvim",
    keys = {
      {
        "<leader>Dq",
        function()
          -- RabbitMQ Management UI en browser
          local host = vim.fn.input("RabbitMQ Host [localhost]: ")
          if host == "" then host = "localhost" end
          local port = vim.fn.input("Management Port [15672]: ")
          if port == "" then port = "15672" end
          
          local url = "http://" .. host .. ":" .. port
          
          -- Abrir en browser (Windows)
          vim.fn.system('start "" "' .. url .. '"')
          vim.notify("Opening RabbitMQ Management: " .. url, vim.log.levels.INFO)
        end,
        desc = "RabbitMQ: Open Management UI"
      },
      {
        "<leader>DQ",
        function()
          local Terminal = require("toggleterm.terminal").Terminal
          
          -- RabbitMQ CLI tools
          local rabbitmq = Terminal:new({
            cmd = "pwsh",
            direction = "float",
            hidden = true,
            float_opts = {
              border = "curved",
              width = function() return math.floor(vim.o.columns * 0.9) end,
              height = function() return math.floor(vim.o.lines * 0.85) end,
            },
            on_open = function(term)
              vim.cmd("startinsert!")
              -- Mostrar comandos útiles
              vim.api.nvim_chan_send(term.job_id, 'Write-Host "RabbitMQ CLI Commands:" -ForegroundColor Cyan\r')
              vim.api.nvim_chan_send(term.job_id, 'Write-Host "  rabbitmqctl list_queues" -ForegroundColor Yellow\r')
              vim.api.nvim_chan_send(term.job_id, 'Write-Host "  rabbitmqctl list_exchanges" -ForegroundColor Yellow\r')
              vim.api.nvim_chan_send(term.job_id, 'Write-Host "  rabbitmqctl list_bindings" -ForegroundColor Yellow\r')
              vim.api.nvim_chan_send(term.job_id, 'Write-Host "  rabbitmqctl list_connections" -ForegroundColor Yellow\r')
              vim.api.nvim_chan_send(term.job_id, 'Write-Host "  rabbitmqctl list_channels" -ForegroundColor Yellow\r')
              vim.api.nvim_chan_send(term.job_id, 'Write-Host ""\r')
            end,
          })
          rabbitmq:toggle()
        end,
        desc = "RabbitMQ: CLI Terminal"
      },
    },
  },

  -- ============================================
  -- MONGODB GUI (via mongosh)
  -- ============================================
  {
    "akinsho/toggleterm.nvim",
    keys = {
      {
        "<leader>Dm",
        function()
          local Terminal = require("toggleterm.terminal").Terminal
          local mongosh = Terminal:new({
            cmd = "mongosh",
            direction = "float",
            hidden = true,
            float_opts = {
              border = "curved",
              width = function() return math.floor(vim.o.columns * 0.85) end,
              height = function() return math.floor(vim.o.lines * 0.85) end,
            },
            on_open = function(term)
              vim.cmd("startinsert!")
            end,
          })
          mongosh:toggle()
        end,
        desc = "MongoDB: Open mongosh"
      },
      {
        "<leader>DM",
        function()
          local connection = vim.fn.input("MongoDB URI [mongodb://localhost:27017]: ")
          if connection == "" then 
            connection = "mongodb://localhost:27017" 
          end
          
          local Terminal = require("toggleterm.terminal").Terminal
          local mongosh = Terminal:new({
            cmd = "mongosh '" .. connection .. "'",
            direction = "float",
            hidden = true,
            float_opts = {
              border = "curved",
              width = function() return math.floor(vim.o.columns * 0.85) end,
              height = function() return math.floor(vim.o.lines * 0.85) end,
            },
            on_open = function(term)
              vim.cmd("startinsert!")
            end,
          })
          mongosh:toggle()
        end,
        desc = "MongoDB: Connect to Server"
      },
    },
  },

  -- ============================================
  -- POSTGRESQL (psql CLI)
  -- ============================================
  {
    "akinsho/toggleterm.nvim",
    keys = {
      {
        "<leader>Dp",
        function()
          local Terminal = require("toggleterm.terminal").Terminal
          local psql = Terminal:new({
            cmd = "psql",
            direction = "float",
            hidden = true,
            float_opts = {
              border = "curved",
              width = function() return math.floor(vim.o.columns * 0.85) end,
              height = function() return math.floor(vim.o.lines * 0.85) end,
            },
            on_open = function(term)
              vim.cmd("startinsert!")
            end,
          })
          psql:toggle()
        end,
        desc = "PostgreSQL: Open psql"
      },
      {
        "<leader>DP",
        function()
          local host = vim.fn.input("Host [localhost]: ")
          if host == "" then host = "localhost" end
          local port = vim.fn.input("Port [5432]: ")
          if port == "" then port = "5432" end
          local user = vim.fn.input("User [postgres]: ")
          if user == "" then user = "postgres" end
          local database = vim.fn.input("Database: ")
          
          local cmd = "psql -h " .. host .. " -p " .. port .. " -U " .. user
          if database ~= "" then
            cmd = cmd .. " -d " .. database
          end
          
          local Terminal = require("toggleterm.terminal").Terminal
          local psql = Terminal:new({
            cmd = cmd,
            direction = "float",
            hidden = true,
            float_opts = {
              border = "curved",
              width = function() return math.floor(vim.o.columns * 0.85) end,
              height = function() return math.floor(vim.o.lines * 0.85) end,
            },
            on_open = function(term)
              vim.cmd("startinsert!")
            end,
          })
          psql:toggle()
        end,
        desc = "PostgreSQL: Connect to Server"
      },
    },
  },

  -- ============================================
  -- SQL SERVER (sqlcmd)
  -- ============================================
  {
    "akinsho/toggleterm.nvim",
    keys = {
      {
        "<leader>Dt",
        function()
          local server = vim.fn.input("Server [localhost]: ")
          if server == "" then server = "localhost" end
          local database = vim.fn.input("Database [master]: ")
          if database == "" then database = "master" end
          local user = vim.fn.input("User (empty for Windows Auth): ")
          
          local cmd = "sqlcmd -S " .. server .. " -d " .. database
          if user ~= "" then
            local password = vim.fn.inputsecret("Password: ")
            cmd = cmd .. " -U " .. user .. " -P " .. password
          else
            cmd = cmd .. " -E" -- Windows Authentication
          end
          
          local Terminal = require("toggleterm.terminal").Terminal
          local sqlcmd = Terminal:new({
            cmd = cmd,
            direction = "float",
            hidden = true,
            float_opts = {
              border = "curved",
              width = function() return math.floor(vim.o.columns * 0.85) end,
              height = function() return math.floor(vim.o.lines * 0.85) end,
            },
            on_open = function(term)
              vim.cmd("startinsert!")
            end,
          })
          sqlcmd:toggle()
        end,
        desc = "SQL Server: Connect (sqlcmd)"
      },
    },
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

--[[
================================================================================
RESUMEN DE KEYMAPS
================================================================================

SQL (DBUI - Interface visual):
  <leader>Ds    Toggle SQL UI (soporta SQL Server, PostgreSQL, MySQL, SQLite)
  <leader>Da    Agregar conexión SQL
  <leader>Df    Buscar buffer SQL
  Ctrl+Enter    Ejecutar query (en archivo .sql)

SQL Server:
  <leader>Dt    Conectar con sqlcmd

PostgreSQL:
  <leader>Dp    Abrir psql local
  <leader>DP    Conectar a servidor PostgreSQL

MongoDB:
  <leader>Dm    Abrir mongosh local
  <leader>DM    Conectar a servidor MongoDB

Redis:
  <leader>Dr    Abrir redis-cli local
  <leader>DR    Conectar a servidor Redis

RabbitMQ:
  <leader>Dq    Abrir Management UI en browser
  <leader>DQ    Terminal con comandos rabbitmqctl

================================================================================
CONNECTION STRINGS PARA DBUI (SQL)
================================================================================

SQL Server:
  sqlserver://user:password@localhost:1433/database
  sqlserver://localhost:1433/database?trusted_connection=true

PostgreSQL:
  postgresql://user:password@localhost:5432/database

MySQL:
  mysql://user:password@localhost:3306/database

SQLite:
  sqlite:///C:/path/to/database.db

MongoDB (via mongosh, no DBUI):
  mongodb://user:password@localhost:27017/database
  mongodb+srv://user:password@cluster.mongodb.net/database

================================================================================
REQUISITOS
================================================================================

Asegúrate de tener instalados los CLIs:

- SQL Server: sqlcmd (viene con SQL Server o SSMS)
- PostgreSQL: psql (viene con PostgreSQL)
- MongoDB: mongosh (https://www.mongodb.com/try/download/shell)
- Redis: redis-cli (https://redis.io/download o via chocolatey: choco install redis-64)
- RabbitMQ: rabbitmqctl (viene con RabbitMQ Server)

Para instalar con Chocolatey:
  choco install postgresql
  choco install mongodb-shell
  choco install redis-64
  choco install rabbitmq

================================================================================
--]]
