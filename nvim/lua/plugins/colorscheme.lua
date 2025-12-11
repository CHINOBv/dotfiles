-- Temas disponibles con soporte para transparencia
-- Cambiar tema: <leader>uC o :Telescope colorscheme
return {
  -- ============================================================
  -- CATPPUCCIN (Default) - Paleta pastel moderna
  -- ============================================================
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "mocha", -- latte, frappe, macchiato, mocha
      transparent_background = true,
      term_colors = true,
      styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        functions = { "bold" },
        keywords = { "italic" },
      },
      integrations = {
        alpha = true,
        cmp = true,
        dashboard = true,
        gitsigns = true,
        indent_blankline = { enabled = true },
        mason = true,
        mini = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
        navic = { enabled = true },
        noice = true,
        notify = true,
        telescope = { enabled = true },
        treesitter = true,
        which_key = true,
        illuminate = true,
        dap = true,
        dap_ui = true,
      },
    },
  },

  -- ============================================================
  -- TOKYO NIGHT - Tema inspirado en Tokyo de noche
  -- ============================================================
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    opts = {
      style = "night", -- night, storm, day, moon
      transparent = true,
      terminal_colors = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        functions = { bold = true },
        sidebars = "transparent",
        floats = "transparent",
      },
      on_highlights = function(hl, c)
        hl.CursorLineNr = { fg = c.orange, bold = true }
      end,
    },
  },

  -- ============================================================
  -- ROSE PINE - Tema suave y elegante
  -- ============================================================
  {
    "rose-pine/neovim",
    name = "rose-pine",
    priority = 1000,
    opts = {
      variant = "main", -- main, moon, dawn
      dark_variant = "main",
      disable_background = true,
      disable_float_background = true,
      disable_italics = false,
      highlight_groups = {
        CursorLineNr = { fg = "gold", bold = true },
        StatusLine = { bg = "none" },
        StatusLineNC = { bg = "none" },
      },
    },
  },

  -- ============================================================
  -- KANAGAWA - Inspirado en el arte japonés
  -- ============================================================
  {
    "rebelot/kanagawa.nvim",
    priority = 1000,
    opts = {
      theme = "wave", -- wave, dragon, lotus
      transparent = true,
      terminalColors = true,
      commentStyle = { italic = true },
      functionStyle = { bold = true },
      keywordStyle = { italic = true },
      colors = {
        theme = {
          all = {
            ui = {
              bg_gutter = "none",
            },
          },
        },
      },
      overrides = function(colors)
        return {
          NormalFloat = { bg = "none" },
          FloatBorder = { bg = "none" },
        }
      end,
    },
  },

  -- ============================================================
  -- GRUVBOX - Tema retro cálido
  -- ============================================================
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    opts = {
      terminal_colors = true,
      transparent_mode = true,
      contrast = "hard", -- soft, medium, hard
      italic = {
        strings = false,
        emphasis = true,
        comments = true,
        operators = false,
        folds = true,
      },
    },
  },

  -- ============================================================
  -- NORD - Tema ártico frío
  -- ============================================================
  {
    "shaunsingh/nord.nvim",
    priority = 1000,
    config = function()
      vim.g.nord_contrast = true
      vim.g.nord_borders = false
      vim.g.nord_disable_background = true
      vim.g.nord_italic = true
      vim.g.nord_bold = true
    end,
  },

  -- ============================================================
  -- ONE DARK - Popular tema de Atom
  -- ============================================================
  {
    "navarasu/onedark.nvim",
    priority = 1000,
    opts = {
      style = "darker", -- dark, darker, cool, deep, warm, warmer
      transparent = true,
      term_colors = true,
      code_style = {
        comments = "italic",
        keywords = "italic",
        functions = "bold",
      },
    },
  },

  -- ============================================================
  -- DRACULA - Tema oscuro clásico
  -- ============================================================
  {
    "Mofiqul/dracula.nvim",
    priority = 1000,
    opts = {
      transparent_bg = true,
      italic_comment = true,
    },
  },

  -- ============================================================
  -- NIGHTFOX - Familia de temas oscuros
  -- ============================================================
  {
    "EdenEast/nightfox.nvim",
    priority = 1000,
    opts = {
      options = {
        transparent = true,
        terminal_colors = true,
        styles = {
          comments = "italic",
          keywords = "italic",
          functions = "bold",
        },
      },
    },
  },

  -- ============================================================
  -- GITHUB THEME - Tema oficial de GitHub
  -- ============================================================
  {
    "projekt0n/github-nvim-theme",
    priority = 1000,
    config = function()
      require("github-theme").setup({
        options = {
          transparent = true,
          styles = {
            comments = "italic",
            keywords = "italic",
            functions = "bold",
          },
        },
      })
    end,
  },

  -- ============================================================
  -- CYBERDREAM - Tema cyberpunk moderno
  -- ============================================================
  {
    "scottmckendry/cyberdream.nvim",
    priority = 1000,
    opts = {
      transparent = true,
      italic_comments = true,
      borderless_telescope = false,
    },
  },

  -- ============================================================
  -- EVERFOREST - Tema verde natural
  -- ============================================================
  {
    "neanias/everforest-nvim",
    priority = 1000,
    config = function()
      require("everforest").setup({
        background = "hard", -- soft, medium, hard
        transparent_background_level = 2,
        italics = true,
      })
    end,
  },

  -- ============================================================
  -- SOLARIZED OSAKA - Solarized moderno
  -- ============================================================
  {
    "craftzdog/solarized-osaka.nvim",
    priority = 1000,
    opts = {
      transparent = true,
      terminal_colors = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        functions = { bold = true },
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },

  -- ============================================================
  -- MATERIAL - Tema Material Design
  -- ============================================================
  {
    "marko-cerovac/material.nvim",
    priority = 1000,
    config = function()
      vim.g.material_style = "deep ocean" -- darker, lighter, oceanic, palenight, deep ocean
      require("material").setup({
        contrast = {
          terminal = true,
          sidebars = true,
          floating_windows = true,
        },
        styles = {
          comments = { italic = true },
          keywords = { italic = true },
          functions = { bold = true },
        },
        disable = {
          background = true,
        },
      })
    end,
  },

  -- ============================================================
  -- TEMA POR DEFECTO
  -- ============================================================
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
