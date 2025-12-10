-- Animaciones y scroll suave
return {
  -- Neoscroll - scroll suave
  {
    "karb94/neoscroll.nvim",
    event = "VeryLazy",
    opts = {
      mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
      hide_cursor = true,
      stop_eof = true,
      respect_scrolloff = false,
      cursor_scrolls_alone = true,
      easing_function = "sine",
      pre_hook = nil,
      post_hook = nil,
      performance_mode = false,
    },
  },

  -- Mini.animate - animaciones de cursor y ventanas
  {
    "nvim-mini/mini.animate",
    event = "VeryLazy",
    opts = function()
      -- No animar durante macros o con muchas lineas
      local mouse_scrolled = false
      for _, scroll in ipairs({ "Up", "Down" }) do
        local key = "<ScrollWheel" .. scroll .. ">"
        vim.keymap.set({ "", "i" }, key, function()
          mouse_scrolled = true
          return key
        end, { expr = true })
      end

      local animate = require("mini.animate")
      return {
        resize = {
          timing = animate.gen_timing.linear({ duration = 100, unit = "total" }),
        },
        scroll = {
          timing = animate.gen_timing.linear({ duration = 150, unit = "total" }),
          subscroll = animate.gen_subscroll.equal({
            predicate = function(total_scroll)
              if mouse_scrolled then
                mouse_scrolled = false
                return false
              end
              return total_scroll > 1
            end,
          }),
        },
        cursor = {
          timing = animate.gen_timing.linear({ duration = 80, unit = "total" }),
        },
        open = {
          timing = animate.gen_timing.linear({ duration = 150, unit = "total" }),
          winconfig = animate.gen_winconfig.wipe({ direction = "from_edge" }),
          winblend = animate.gen_winblend.linear({ from = 80, to = 0 }),
        },
        close = {
          timing = animate.gen_timing.linear({ duration = 150, unit = "total" }),
          winconfig = animate.gen_winconfig.wipe({ direction = "to_edge" }),
          winblend = animate.gen_winblend.linear({ from = 0, to = 80 }),
        },
      }
    end,
  },

  -- Animacion de indentacion
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
