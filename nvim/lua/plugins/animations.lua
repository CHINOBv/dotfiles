-- Animaciones (desactivadas scroll/cursor para evitar problemas con gd, búsqueda, etc.)
return {
  -- Desactivar neoscroll - causa problemas con saltos grandes y búsqueda
  {
    "karb94/neoscroll.nvim",
    enabled = false,
  },

  -- Mini.animate - SOLO animaciones de ventanas (NO scroll ni cursor)
  {
    "echasnovski/mini.animate",
    event = "VeryLazy",
    opts = function()
      local animate = require("mini.animate")
      return {
        -- DESACTIVAR scroll y cursor - causan problemas con gd, /, n, N en archivos grandes
        scroll = { enable = false },
        cursor = { enable = false },
        
        -- Mantener solo animaciones de ventanas (no afectan navegación)
        resize = {
          timing = animate.gen_timing.linear({ duration = 100, unit = "total" }),
        },
        open = {
          timing = animate.gen_timing.linear({ duration = 100, unit = "total" }),
          winconfig = animate.gen_winconfig.wipe({ direction = "from_edge" }),
          winblend = animate.gen_winblend.linear({ from = 80, to = 0 }),
        },
        close = {
          timing = animate.gen_timing.linear({ duration = 100, unit = "total" }),
          winconfig = animate.gen_winconfig.wipe({ direction = "to_edge" }),
          winblend = animate.gen_winblend.linear({ from = 0, to = 80 }),
        },
      }
    end,
  },

  -- Animacion de indentacion (no afecta navegación)
  {
    "echasnovski/mini.indentscope",
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
