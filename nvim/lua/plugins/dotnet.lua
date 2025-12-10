-- Comandos y utilidades para .NET
return {
  -- Comandos personalizados para .NET
  {
    "folke/which-key.nvim",
    opts = function(_, opts)
      opts.spec = opts.spec or {}
      table.insert(opts.spec, { "<leader>N", group = ".NET", icon = "" })
    end,
  },

  -- Plugin para ejecutar comandos
  {
    "stevearc/overseer.nvim",
    opts = {},
    config = function(_, opts)
      local overseer = require("overseer")
      overseer.setup(opts)

      -- Templates para .NET
      overseer.register_template({
        name = "dotnet build",
        builder = function()
          return {
            cmd = { "dotnet" },
            args = { "build" },
            name = "dotnet build",
            cwd = vim.fn.getcwd(),
          }
        end,
        condition = {
          filetype = { "cs" },
        },
      })

      overseer.register_template({
        name = "dotnet run",
        builder = function()
          return {
            cmd = { "dotnet" },
            args = { "run" },
            name = "dotnet run",
            cwd = vim.fn.getcwd(),
          }
        end,
        condition = {
          filetype = { "cs" },
        },
      })

      overseer.register_template({
        name = "dotnet test",
        builder = function()
          return {
            cmd = { "dotnet" },
            args = { "test" },
            name = "dotnet test",
            cwd = vim.fn.getcwd(),
          }
        end,
        condition = {
          filetype = { "cs" },
        },
      })

      overseer.register_template({
        name = "dotnet watch",
        builder = function()
          return {
            cmd = { "dotnet" },
            args = { "watch", "run" },
            name = "dotnet watch",
            cwd = vim.fn.getcwd(),
          }
        end,
        condition = {
          filetype = { "cs" },
        },
      })

      overseer.register_template({
        name = "dotnet clean",
        builder = function()
          return {
            cmd = { "dotnet" },
            args = { "clean" },
            name = "dotnet clean",
            cwd = vim.fn.getcwd(),
          }
        end,
        condition = {
          filetype = { "cs" },
        },
      })

      overseer.register_template({
        name = "dotnet restore",
        builder = function()
          return {
            cmd = { "dotnet" },
            args = { "restore" },
            name = "dotnet restore",
            cwd = vim.fn.getcwd(),
          }
        end,
        condition = {
          filetype = { "cs" },
        },
      })
    end,
    keys = {
      { "<leader>Nb", "<cmd>OverseerRun dotnet build<cr>", desc = "Build" },
      { "<leader>Nr", "<cmd>OverseerRun dotnet run<cr>", desc = "Run" },
      { "<leader>Nt", "<cmd>OverseerRun dotnet test<cr>", desc = "Test" },
      { "<leader>Nw", "<cmd>OverseerRun dotnet watch<cr>", desc = "Watch" },
      { "<leader>Nc", "<cmd>OverseerRun dotnet clean<cr>", desc = "Clean" },
      { "<leader>NR", "<cmd>OverseerRun dotnet restore<cr>", desc = "Restore" },
      { "<leader>No", "<cmd>OverseerToggle<cr>", desc = "Overseer Toggle" },
    },
  },

  -- Neotest para tests de .NET
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "Issafalcon/neotest-dotnet",
    },
    opts = {
      adapters = {
        ["neotest-dotnet"] = {},
      },
    },
  },
}
