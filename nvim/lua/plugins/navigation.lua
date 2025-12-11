-- Navegación rápida en archivos grandes
return {
  -- ============================================================
  -- AERIAL - Vista de outline/símbolos (como VSCode Outline)
  -- ============================================================
  {
    "stevearc/aerial.nvim",
    event = "LazyFile",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      backends = { "lsp", "treesitter", "markdown", "man" },
      layout = {
        max_width = { 40, 0.2 },
        min_width = 30,
        default_direction = "right",
        placement = "edge",
      },
      attach_mode = "global",
      show_guides = true,
      guides = {
        mid_item = "├─",
        last_item = "└─",
        nested_top = "│ ",
        whitespace = "  ",
      },
      filter_kind = {
        "Class",
        "Constructor",
        "Enum",
        "Function",
        "Interface",
        "Method",
        "Module",
        "Namespace",
        "Property",
        "Struct",
      },
      icons = {
        Class = " ",
        Constructor = " ",
        Enum = " ",
        Function = "󰊕 ",
        Interface = " ",
        Method = "󰊕 ",
        Module = " ",
        Namespace = " ",
        Property = " ",
        Struct = " ",
        Field = " ",
      },
      highlight_on_hover = true,
      highlight_on_jump = 300,
      autojump = true,
      close_on_select = false,
      manage_folds = false,
    },
    keys = {
      { "<leader>cs", "<cmd>AerialToggle<cr>", desc = "Symbols Outline (Aerial)" },
      { "<leader>cS", "<cmd>AerialNavToggle<cr>", desc = "Symbols Navigation" },
      { "{", "<cmd>AerialPrev<cr>", desc = "Previous Symbol" },
      { "}", "<cmd>AerialNext<cr>", desc = "Next Symbol" },
    },
  },

  -- ============================================================
  -- LEAP - Saltos rápidos a cualquier parte visible
  -- ============================================================
  {
    "ggandor/leap.nvim",
    event = "VeryLazy",
    dependencies = { "tpope/vim-repeat" },
    config = function()
      local leap = require("leap")
      leap.add_default_mappings(true)
      -- Colores Catppuccin
      vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "Comment" })
      vim.api.nvim_set_hl(0, "LeapMatch", { fg = "#1e1e2e", bg = "#fab387", bold = true })
      vim.api.nvim_set_hl(0, "LeapLabelPrimary", { fg = "#1e1e2e", bg = "#f38ba8", bold = true })
      vim.api.nvim_set_hl(0, "LeapLabelSecondary", { fg = "#1e1e2e", bg = "#a6e3a1", bold = true })
    end,
  },

  -- ============================================================
  -- FLASH - Alternativa/complemento a Leap para búsqueda mejorada
  -- ============================================================
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      labels = "asdfghjklqwertyuiopzxcvbnm",
      search = {
        multi_window = true,
        forward = true,
        wrap = true,
      },
      jump = {
        jumplist = true,
        pos = "start",
        autojump = false,
      },
      label = {
        uppercase = false,
        rainbow = { enabled = true, shade = 5 },
      },
      highlight = {
        backdrop = true,
        matches = true,
        groups = {
          match = "FlashMatch",
          current = "FlashCurrent",
          backdrop = "FlashBackdrop",
          label = "FlashLabel",
        },
      },
      modes = {
        search = { enabled = false }, -- No interferir con / búsqueda normal
        char = { enabled = true }, -- Mejorar f, F, t, T
        treesitter = {
          labels = "abcdefghijklmnopqrstuvwxyz",
          jump = { pos = "range" },
          highlight = { backdrop = false, matches = false },
        },
      },
    },
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash Jump" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    },
  },

  -- ============================================================
  -- TREESITTER TEXTOBJECTS - Navegar por funciones, clases, etc.
  -- ============================================================
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = "VeryLazy",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("nvim-treesitter.configs").setup({
        textobjects = {
          -- Saltar entre funciones/clases
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              ["]m"] = { query = "@function.outer", desc = "Next Method/Function" },
              ["]c"] = { query = "@class.outer", desc = "Next Class" },
              ["]a"] = { query = "@parameter.inner", desc = "Next Argument" },
              ["]l"] = { query = "@loop.outer", desc = "Next Loop" },
              ["]i"] = { query = "@conditional.outer", desc = "Next If/Conditional" },
            },
            goto_next_end = {
              ["]M"] = { query = "@function.outer", desc = "Next Method End" },
              ["]C"] = { query = "@class.outer", desc = "Next Class End" },
            },
            goto_previous_start = {
              ["[m"] = { query = "@function.outer", desc = "Previous Method/Function" },
              ["[c"] = { query = "@class.outer", desc = "Previous Class" },
              ["[a"] = { query = "@parameter.inner", desc = "Previous Argument" },
              ["[l"] = { query = "@loop.outer", desc = "Previous Loop" },
              ["[i"] = { query = "@conditional.outer", desc = "Previous If/Conditional" },
            },
            goto_previous_end = {
              ["[M"] = { query = "@function.outer", desc = "Previous Method End" },
              ["[C"] = { query = "@class.outer", desc = "Previous Class End" },
            },
          },
          -- Seleccionar funciones/clases/etc.
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = { query = "@function.outer", desc = "Select outer function" },
              ["if"] = { query = "@function.inner", desc = "Select inner function" },
              ["ac"] = { query = "@class.outer", desc = "Select outer class" },
              ["ic"] = { query = "@class.inner", desc = "Select inner class" },
              ["aa"] = { query = "@parameter.outer", desc = "Select outer argument" },
              ["ia"] = { query = "@parameter.inner", desc = "Select inner argument" },
              ["al"] = { query = "@loop.outer", desc = "Select outer loop" },
              ["il"] = { query = "@loop.inner", desc = "Select inner loop" },
              ["ai"] = { query = "@conditional.outer", desc = "Select outer conditional" },
              ["ii"] = { query = "@conditional.inner", desc = "Select inner conditional" },
            },
          },
          -- Intercambiar argumentos/parámetros
          swap = {
            enable = true,
            swap_next = {
              ["<leader>a"] = { query = "@parameter.inner", desc = "Swap with next argument" },
            },
            swap_previous = {
              ["<leader>A"] = { query = "@parameter.inner", desc = "Swap with previous argument" },
            },
          },
        },
      })
    end,
  },

  -- ============================================================
  -- TELESCOPE SYMBOLS - Buscar símbolos en archivo/workspace
  -- ============================================================
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader>ss", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document Symbols" },
      { "<leader>sS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Workspace Symbols" },
      { "<leader>sm", "<cmd>Telescope lsp_document_symbols symbols=method,function<cr>", desc = "Methods/Functions" },
      { "<leader>sc", "<cmd>Telescope lsp_document_symbols symbols=class,struct,interface<cr>", desc = "Classes/Structs" },
    },
  },

  -- ============================================================
  -- MARKS - Marcadores mejorados
  -- ============================================================
  {
    "chentoast/marks.nvim",
    event = "VeryLazy",
    opts = {
      default_mappings = true,
      builtin_marks = { ".", "<", ">", "^" },
      cyclic = true,
      force_write_shada = false,
      refresh_interval = 250,
      sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
      mappings = {
        set_next = "m,",
        next = "m]",
        prev = "m[",
        preview = "m:",
        delete_line = "dm-",
        delete_buf = "dm<space>",
      },
    },
  },

  -- ============================================================
  -- MINI.BRACKETED - Navegar con [ y ] mejorado
  -- ============================================================
  {
    "echasnovski/mini.bracketed",
    event = "VeryLazy",
    opts = {
      buffer     = { suffix = "b", options = {} },
      comment    = { suffix = "c", options = {} },
      conflict   = { suffix = "x", options = {} },
      diagnostic = { suffix = "d", options = {} },
      file       = { suffix = "f", options = {} },
      indent     = { suffix = "i", options = {} },
      jump       = { suffix = "j", options = {} },
      location   = { suffix = "l", options = {} },
      oldfile    = { suffix = "o", options = {} },
      quickfix   = { suffix = "q", options = {} },
      treesitter = { suffix = "t", options = {} },
      undo       = { suffix = "u", options = {} },
      window     = { suffix = "w", options = {} },
      yank       = { suffix = "y", options = {} },
    },
  },
}
