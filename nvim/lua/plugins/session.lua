-- Persistencia de sesiones (restaurar archivos abiertos)
return {
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {
      dir = vim.fn.stdpath("state") .. "/sessions/",
      options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp" },
    },
    keys = {
      { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session (cwd)" },
      { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      { "<leader>qd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
    },
    init = function()
      -- Auto-cargar sesión al abrir Neovim en un directorio (sin argumentos)
      vim.api.nvim_create_autocmd("VimEnter", {
        group = vim.api.nvim_create_augroup("restore_session", { clear = true }),
        callback = function()
          -- Solo si no hay argumentos (archivos) y no es stdin
          if vim.fn.argc(-1) == 0 and not vim.g.started_with_stdin then
            -- Pequeño delay para que carguen los plugins primero
            vim.defer_fn(function()
              require("persistence").load()
            end, 50)
          end
        end,
        nested = true,
      })

      -- Detectar si se abrió con stdin (pipe)
      vim.api.nvim_create_autocmd("StdinReadPre", {
        callback = function()
          vim.g.started_with_stdin = true
        end,
      })
    end,
  },
}
