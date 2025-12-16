-- Animaciones (desactivadas scroll/cursor para evitar problemas con gd, búsqueda, etc.)
return {
  -- Desactivar neoscroll - causa problemas con saltos grandes y búsqueda
  {
    "karb94/neoscroll.nvim",
    enabled = false,
  },

  -- Mini.animate - DESACTIVADO (causa problemas con ventanas flotantes/toggleterm)
  {
    "nvim-mini/mini.animate",
    enabled = false,
  },

  -- Animacion de indentacion (no afecta navegación)
  {
    "nvim-mini/mini.indentscope",
    version = false,
    event = "LazyFile",
    opts = {
      symbol = "│",
      options = { try_as_border = true },
      draw = {
        delay = 50,
        animation = function()
          return 5
        end,
      },
    },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "alpha",
          "dashboard",
          "help",
          "lazy",
          "lazyterm",
          "mason",
          "neo-tree",
          "notify",
          "toggleterm",
          "Trouble",
          "trouble",
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },
}
