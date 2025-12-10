-- OpenCode integration
return {
  -- Terminal flotante para OpenCode
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      size = function(term)
        if term.direction == "horizontal" then
          return 20
        elseif term.direction == "vertical" then
          return math.floor(vim.o.columns * 0.4)
        end
        return 20
      end,
      open_mapping = [[<c-\>]],
      hide_numbers = true,
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      persist_size = true,
      direction = "float",
      close_on_exit = true,
      shell = "pwsh",
      float_opts = {
        border = "curved",
        winblend = 0,
        highlights = {
          border = "Normal",
          background = "Normal",
        },
      },
    },
    config = function(_, opts)
      require("toggleterm").setup(opts)

      local Terminal = require("toggleterm.terminal").Terminal

      -- OpenCode flotante (pantalla completa)
      -- NOTA: Usa Ctrl+` para ocultar/mostrar (no conflictúa con OpenCode)
      local opencode_float = Terminal:new({
        cmd = "opencode",
        dir = "git_dir",
        direction = "float",
        hidden = true,
        count = 10, -- ID único para este terminal
        float_opts = {
          border = "double",
          width = function()
            return math.floor(vim.o.columns * 0.9)
          end,
          height = function()
            return math.floor(vim.o.lines * 0.85)
          end,
        },
        on_open = function(term)
          vim.cmd("startinsert!")
          -- Ctrl+o para toggle OpenCode
          vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<C-o>", "<cmd>lua _OPENCODE_FLOAT_TOGGLE()<CR>", { noremap = true, silent = true })
        end,
      })

      -- OpenCode lateral (vertical split - 40% del ancho)
      local opencode_vertical = Terminal:new({
        cmd = "opencode",
        dir = "git_dir",
        direction = "vertical",
        hidden = true,
        count = 11, -- ID único
        size = math.floor(vim.o.columns * 0.4),
        on_open = function(term)
          vim.cmd("startinsert!")
          vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<C-o>", "<cmd>lua _OPENCODE_VERTICAL_TOGGLE()<CR>", { noremap = true, silent = true })
        end,
      })

      -- OpenCode horizontal (bottom split - 15 líneas)
      local opencode_horizontal = Terminal:new({
        cmd = "opencode",
        dir = "git_dir",
        direction = "horizontal",
        hidden = true,
        count = 12, -- ID único
        size = 15,
        on_open = function(term)
          vim.cmd("startinsert!")
          vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<C-o>", "<cmd>lua _OPENCODE_HORIZONTAL_TOGGLE()<CR>", { noremap = true, silent = true })
        end,
      })

      -- Funciones globales
      function _OPENCODE_FLOAT_TOGGLE()
        opencode_float:toggle()
      end

      function _OPENCODE_VERTICAL_TOGGLE()
        opencode_vertical:toggle()
      end

      function _OPENCODE_HORIZONTAL_TOGGLE()
        opencode_horizontal:toggle()
      end

      -- Terminal lazygit
      local lazygit = Terminal:new({
        cmd = "lazygit",
        dir = "git_dir",
        direction = "float",
        hidden = true,
        count = 20,
        float_opts = {
          border = "double",
          width = function()
            return math.floor(vim.o.columns * 0.9)
          end,
          height = function()
            return math.floor(vim.o.lines * 0.9)
          end,
        },
        on_open = function(term)
          vim.cmd("startinsert!")
          vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
        end,
      })

      function _LAZYGIT_TOGGLE()
        lazygit:toggle()
      end
    end,
    keys = {
      -- OpenCode (Ctrl+o para toggle desde cualquier lugar)
      { "<leader>oo", "<cmd>lua _OPENCODE_FLOAT_TOGGLE()<CR>", desc = "OpenCode (Float)" },
      { "<leader>ov", "<cmd>lua _OPENCODE_VERTICAL_TOGGLE()<CR>", desc = "OpenCode (Lateral)" },
      { "<leader>oh", "<cmd>lua _OPENCODE_HORIZONTAL_TOGGLE()<CR>", desc = "OpenCode (Bottom)" },
      { "<C-o>", "<cmd>lua _OPENCODE_FLOAT_TOGGLE()<CR>", desc = "Toggle OpenCode", mode = { "n", "t" } },
      
      -- LazyGit
      { "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", desc = "LazyGit" },
      
      -- Terminal general
      { "<c-\\>", "<cmd>ToggleTerm<CR>", desc = "Toggle Terminal" },
      { "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", desc = "Float Terminal" },
      { "<leader>th", "<cmd>ToggleTerm direction=horizontal<CR>", desc = "Horizontal Terminal" },
      { "<leader>tv", "<cmd>ToggleTerm direction=vertical<CR>", desc = "Vertical Terminal" },
    },
  },

  -- Which-key group para OpenCode
  {
    "folke/which-key.nvim",
    opts = function(_, opts)
      opts.spec = opts.spec or {}
      table.insert(opts.spec, { "<leader>o", group = "OpenCode", icon = "" })
      table.insert(opts.spec, { "<leader>t", group = "Terminal", icon = "" })
    end,
  },
}
