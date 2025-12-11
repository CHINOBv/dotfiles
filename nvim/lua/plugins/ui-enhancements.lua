-- UI/UX Enhancements - Mejoras visuales y de experiencia
return {
  -- ============================================================
  -- NOTIFICACIONES MEJORADAS
  -- ============================================================
  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 3000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
      stages = "fade_in_slide_out",
      render = "wrapped-compact",
      top_down = true,
      background_colour = "#1e1e2e",
      icons = {
        ERROR = "",
        WARN = "",
        INFO = "",
        DEBUG = "",
        TRACE = "",
      },
    },
    init = function()
      vim.notify = require("notify")
    end,
  },

  -- ============================================================
  -- UI DE SELECCIÓN MEJORADA (vim.ui.select, vim.ui.input)
  -- ============================================================
  {
    "stevearc/dressing.nvim",
    lazy = true,
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.input(...)
      end
    end,
    opts = {
      input = {
        enabled = true,
        default_prompt = "Input:",
        title_pos = "center",
        insert_only = true,
        start_in_insert = true,
        border = "rounded",
        relative = "cursor",
        prefer_width = 40,
        width = nil,
        max_width = { 140, 0.9 },
        min_width = { 20, 0.2 },
        win_options = {
          winhighlight = "NormalFloat:Normal,FloatBorder:FloatBorder",
        },
      },
      select = {
        enabled = true,
        backend = { "telescope", "builtin" },
        trim_prompt = true,
        telescope = {
          layout_strategy = "vertical",
          layout_config = {
            width = 0.5,
            height = 0.4,
          },
        },
        builtin = {
          border = "rounded",
          relative = "editor",
          win_options = {
            winhighlight = "NormalFloat:Normal,FloatBorder:FloatBorder",
          },
        },
      },
    },
  },

  -- ============================================================
  -- BREADCRUMBS / WINBAR (muestra ruta del símbolo actual)
  -- ============================================================
  {
    "SmiteshP/nvim-navic",
    lazy = true,
    init = function()
      vim.g.navic_silence = true
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and client.server_capabilities.documentSymbolProvider then
            require("nvim-navic").attach(client, args.buf)
          end
        end,
      })
    end,
    opts = {
      separator = " › ",
      highlight = true,
      depth_limit = 5,
      icons = {
        File = " ",
        Module = " ",
        Namespace = " ",
        Package = " ",
        Class = " ",
        Method = " ",
        Property = " ",
        Field = " ",
        Constructor = " ",
        Enum = " ",
        Interface = " ",
        Function = " ",
        Variable = " ",
        Constant = " ",
        String = " ",
        Number = " ",
        Boolean = " ",
        Array = " ",
        Object = " ",
        Key = " ",
        Null = " ",
        EnumMember = " ",
        Struct = " ",
        Event = " ",
        Operator = " ",
        TypeParameter = " ",
      },
    },
  },

  -- Configurar winbar con navic
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      -- Winbar con breadcrumbs
      opts.winbar = {
        lualine_c = {
          {
            function()
              return require("nvim-navic").get_location()
            end,
            cond = function()
              return package.loaded["nvim-navic"] and require("nvim-navic").is_available()
            end,
          },
        },
      }
      opts.inactive_winbar = {
        lualine_c = { "filename" },
      }
    end,
  },

  -- ============================================================
  -- TODO COMMENTS (resalta TODO, FIXME, NOTE, etc.)
  -- ============================================================
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = "LazyFile",
    opts = {
      signs = true,
      sign_priority = 8,
      keywords = {
        FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
        TODO = { icon = " ", color = "info" },
        HACK = { icon = " ", color = "warning" },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
        PERF = { icon = " ", color = "default", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
        TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
      },
      highlight = {
        multiline = true,
        multiline_pattern = "^.",
        multiline_context = 10,
        before = "",
        keyword = "wide",
        after = "fg",
        pattern = [[.*<(KEYWORDS)\s*:]],
        comments_only = true,
      },
    },
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next TODO" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous TODO" },
      { "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "TODOs (Trouble)" },
      { "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "TODO/FIX/FIXME" },
      { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Search TODOs" },
    },
  },

  -- SCROLLBAR desactivado (causa errores y no aporta mucho valor)
  -- {
  --   "petertriho/nvim-scrollbar",
  --   enabled = false,
  -- },

  -- ============================================================
  -- COLORIZER (preview de colores en código)
  -- ============================================================
  {
    "NvChad/nvim-colorizer.lua",
    event = "BufReadPost",
    opts = {
      filetypes = {
        "*",
        css = { css = true },
        scss = { css = true },
        html = { names = true },
        lua = { names = false },
      },
      user_default_options = {
        RGB = true,
        RRGGBB = true,
        names = false,
        RRGGBBAA = true,
        AARRGGBB = true,
        rgb_fn = true,
        hsl_fn = true,
        css = false,
        css_fn = true,
        mode = "background",
        tailwind = true,
        sass = { enable = true, parsers = { "css" } },
        virtualtext = "■",
      },
    },
  },

  -- ============================================================
  -- HIGHLIGHT DE PALABRAS BAJO CURSOR
  -- ============================================================
  {
    "RRethy/vim-illuminate",
    event = "LazyFile",
    opts = {
      delay = 200,
      large_file_cutoff = 2000,
      large_file_overrides = {
        providers = { "lsp" },
      },
      filetypes_denylist = {
        "dirbuf",
        "dirvish",
        "fugitive",
        "neo-tree",
        "TelescopePrompt",
        "DressingInput",
      },
    },
    config = function(_, opts)
      require("illuminate").configure(opts)
    end,
    keys = {
      { "]]", function() require("illuminate").goto_next_reference(false) end, desc = "Next Reference" },
      { "[[", function() require("illuminate").goto_prev_reference(false) end, desc = "Prev Reference" },
    },
  },

  -- ============================================================
  -- SMOOTH CURSOR (línea de cursor animada)
  -- ============================================================
  {
    "gen740/SmoothCursor.nvim",
    event = "VeryLazy",
    opts = {
      type = "default",
      cursor = "",
      texthl = "SmoothCursor",
      linehl = nil,
      fancy = {
        enable = true,
        head = { cursor = "▷", texthl = "SmoothCursor", linehl = nil },
        body = {
          { cursor = "●", texthl = "SmoothCursorBody" },
          { cursor = "●", texthl = "SmoothCursorBody" },
          { cursor = "•", texthl = "SmoothCursorBody" },
          { cursor = ".", texthl = "SmoothCursorBody" },
        },
        tail = { cursor = nil, texthl = "SmoothCursor" },
      },
      flyin_effect = nil,
      speed = 25,
      intervals = 35,
      priority = 10,
      timeout = 3000,
      threshold = 3,
      disable_float_win = true,
      enabled_filetypes = nil,
      disabled_filetypes = { "neo-tree", "dashboard", "TelescopePrompt" },
    },
    config = function(_, opts)
      require("smoothcursor").setup(opts)
      -- Colores Catppuccin para el cursor
      vim.api.nvim_set_hl(0, "SmoothCursor", { fg = "#fab387" })
      vim.api.nvim_set_hl(0, "SmoothCursorBody", { fg = "#6c7086" })
    end,
  },

  -- ============================================================
  -- INDENT BLANKLINE MEJORADO
  -- ============================================================
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = "LazyFile",
    opts = {
      indent = {
        char = "│",
        tab_char = "│",
      },
      scope = {
        enabled = true,
        show_start = true,
        show_end = false,
        highlight = { "Function", "Label" },
      },
      exclude = {
        filetypes = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        },
      },
    },
  },

  -- ============================================================
  -- DASHBOARD MEJORADO
  -- ============================================================
  {
    "nvimdev/dashboard-nvim",
    opts = function(_, opts)
      local logo = [[
      ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
      ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
      ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
      ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
      ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
      ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
      ]]
      logo = string.rep("\n", 4) .. logo .. "\n\n"
      opts.config = opts.config or {}
      opts.config.header = vim.split(logo, "\n")
    end,
  },

  -- ============================================================
  -- WINDOW PICKER (selección visual de ventanas)
  -- ============================================================
  {
    "s1n7ax/nvim-window-picker",
    name = "window-picker",
    event = "VeryLazy",
    version = "2.*",
    opts = {
      hint = "floating-big-letter",
      selection_chars = "FJDKSLA;CMRUEIWOQP",
      filter_rules = {
        include_current_win = false,
        autoselect_one = true,
        bo = {
          filetype = { "neo-tree", "neo-tree-popup", "notify" },
          buftype = { "terminal", "quickfix" },
        },
      },
      highlights = {
        statusline = {
          focused = { fg = "#1e1e2e", bg = "#fab387", bold = true },
          unfocused = { fg = "#1e1e2e", bg = "#6c7086", bold = true },
        },
        winbar = {
          focused = { fg = "#1e1e2e", bg = "#fab387", bold = true },
          unfocused = { fg = "#1e1e2e", bg = "#6c7086", bold = true },
        },
      },
    },
    keys = {
      {
        "<leader>wp",
        function()
          local picked_window_id = require("window-picker").pick_window()
          if picked_window_id then
            vim.api.nvim_set_current_win(picked_window_id)
          end
        end,
        desc = "Pick Window",
      },
    },
  },

  -- ============================================================
  -- ZEN MODE (modo sin distracciones)
  -- ============================================================
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
      window = {
        backdrop = 0.95,
        width = 120,
        height = 1,
        options = {
          signcolumn = "no",
          number = false,
          relativenumber = false,
          cursorline = false,
          cursorcolumn = false,
          foldcolumn = "0",
          list = false,
        },
      },
      plugins = {
        options = {
          enabled = true,
          ruler = false,
          showcmd = false,
          laststatus = 0,
        },
        twilight = { enabled = true },
        gitsigns = { enabled = false },
        tmux = { enabled = false },
      },
    },
    keys = {
      { "<leader>uz", "<cmd>ZenMode<cr>", desc = "Zen Mode" },
    },
  },

  -- Twilight (atenuar código fuera de foco en Zen Mode)
  {
    "folke/twilight.nvim",
    cmd = "Twilight",
    opts = {
      dimming = {
        alpha = 0.25,
        color = { "Normal", "#ffffff" },
        term_bg = "#1e1e2e",
        inactive = false,
      },
      context = 10,
      treesitter = true,
    },
  },
}
