-- Buffer/Tabs management con bufferline mejorado
return {
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>bb", "<cmd>e #<cr>", desc = "Switch to Other Buffer" },
      { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
      { "<leader>bD", "<cmd>:bd<cr>", desc = "Delete Buffer and Window" },
      { "<leader>bn", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
      { "<leader>bp", "<cmd>BufferLineCyclePrev<cr>", desc = "Previous Buffer" },
      { "<leader>br", "<cmd>BufferLineCloseRight<cr>", desc = "Close Buffers to Right" },
      { "<leader>bl", "<cmd>BufferLineCloseLeft<cr>", desc = "Close Buffers to Left" },
      { "<leader>bo", "<cmd>BufferLineCloseOthers<cr>", desc = "Close Other Buffers" },
      { "<leader>bP", "<cmd>BufferLineTogglePin<cr>", desc = "Toggle Pin" },
      { "<leader>bs", "<cmd>BufferLinePick<cr>", desc = "Pick Buffer" },
      { "<leader>bS", "<cmd>BufferLinePickClose<cr>", desc = "Pick Buffer to Close" },
      { "<leader>b1", "<cmd>BufferLineGoToBuffer 1<cr>", desc = "Go to Buffer 1" },
      { "<leader>b2", "<cmd>BufferLineGoToBuffer 2<cr>", desc = "Go to Buffer 2" },
      { "<leader>b3", "<cmd>BufferLineGoToBuffer 3<cr>", desc = "Go to Buffer 3" },
      { "<leader>b4", "<cmd>BufferLineGoToBuffer 4<cr>", desc = "Go to Buffer 4" },
      { "<leader>b5", "<cmd>BufferLineGoToBuffer 5<cr>", desc = "Go to Buffer 5" },
      { "<leader>bh", "<cmd>BufferLineMovePrev<cr>", desc = "Move Buffer Left" },
      { "<leader>bj", "<cmd>BufferLineMoveNext<cr>", desc = "Move Buffer Right" },
      -- Tab navigation rápida
      { "<Tab>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
      { "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", desc = "Previous Buffer" },
      -- Alt+número para ir directamente a un buffer
      { "<A-1>", "<cmd>BufferLineGoToBuffer 1<cr>", desc = "Buffer 1" },
      { "<A-2>", "<cmd>BufferLineGoToBuffer 2<cr>", desc = "Buffer 2" },
      { "<A-3>", "<cmd>BufferLineGoToBuffer 3<cr>", desc = "Buffer 3" },
      { "<A-4>", "<cmd>BufferLineGoToBuffer 4<cr>", desc = "Buffer 4" },
      { "<A-5>", "<cmd>BufferLineGoToBuffer 5<cr>", desc = "Buffer 5" },
      { "<A-6>", "<cmd>BufferLineGoToBuffer 6<cr>", desc = "Buffer 6" },
      { "<A-7>", "<cmd>BufferLineGoToBuffer 7<cr>", desc = "Buffer 7" },
      { "<A-8>", "<cmd>BufferLineGoToBuffer 8<cr>", desc = "Buffer 8" },
      { "<A-9>", "<cmd>BufferLineGoToBuffer 9<cr>", desc = "Buffer 9" },
      { "<A-0>", "<cmd>BufferLineGoToBuffer -1<cr>", desc = "Last Buffer" },
    },
    opts = {
      options = {
        mode = "buffers",
        style_preset = require("bufferline").style_preset.default,
        themable = true,
        numbers = function(opts)
          return string.format("%s", opts.ordinal)
        end,
        close_command = function(n) Snacks.bufdelete(n) end,
        right_mouse_command = function(n) Snacks.bufdelete(n) end,
        left_mouse_command = "buffer %d",
        middle_mouse_command = function(n) Snacks.bufdelete(n) end,
        indicator = {
          icon = "▎",
          style = "icon",
        },
        buffer_close_icon = "󰅖",
        modified_icon = "●",
        close_icon = "",
        left_trunc_marker = "",
        right_trunc_marker = "",
        max_name_length = 30,
        max_prefix_length = 15,
        truncate_names = true,
        tab_size = 21,
        diagnostics = "nvim_lsp",
        diagnostics_update_in_insert = false,
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          local icons = { error = " ", warning = " ", hint = " ", info = " " }
          local result = ""
          for name, cnt in pairs(diagnostics_dict) do
            if icons[name] and cnt > 0 then
              result = result .. icons[name] .. cnt .. " "
            end
          end
          return vim.trim(result)
        end,
        color_icons = true,
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = false,
        show_tab_indicators = true,
        show_duplicate_prefix = true,
        duplicates_across_groups = true,
        persist_buffer_sort = true,
        move_wraps_at_ends = false,
        separator_style = "slant", -- "slant" | "slope" | "thick" | "thin" | { "▏", "▕" }
        enforce_regular_tabs = false,
        always_show_bufferline = true,
        auto_toggle_bufferline = true,
        hover = {
          enabled = true,
          delay = 200,
          reveal = { "close" },
        },
        sort_by = "insert_after_current",
        offsets = {
          {
            filetype = "neo-tree",
            text = " File Explorer",
            text_align = "center",
            separator = true,
            highlight = "Directory",
          },
          {
            filetype = "aerial",
            text = " Symbols",
            text_align = "center",
            separator = true,
          },
          {
            filetype = "DiffviewFiles",
            text = " Diff View",
            text_align = "center",
            separator = true,
          },
        },
        groups = {
          options = {
            toggle_hidden_on_enter = true,
          },
          items = {
            {
              name = " Tests",
              matcher = function(buf)
                return buf.name:match("%.test") or buf.name:match("%.spec") or buf.name:match("Test%.cs")
              end,
            },
            {
              name = "󰈙 Docs",
              matcher = function(buf)
                return buf.name:match("%.md") or buf.name:match("%.txt") or buf.name:match("README")
              end,
            },
          },
        },
      },
      highlights = {
        fill = {
          bg = { attribute = "bg", highlight = "Normal" },
        },
        background = {
          italic = true,
        },
        buffer_selected = {
          bold = true,
          italic = false,
        },
        numbers_selected = {
          bold = true,
        },
        diagnostic_selected = {
          bold = true,
        },
        hint_selected = {
          bold = true,
        },
        hint_diagnostic_selected = {
          bold = true,
        },
        info_selected = {
          bold = true,
        },
        info_diagnostic_selected = {
          bold = true,
        },
        warning_selected = {
          bold = true,
        },
        warning_diagnostic_selected = {
          bold = true,
        },
        error_selected = {
          bold = true,
        },
        error_diagnostic_selected = {
          bold = true,
        },
        separator = {
          bg = { attribute = "bg", highlight = "Normal" },
        },
        separator_visible = {
          bg = { attribute = "bg", highlight = "Normal" },
        },
        separator_selected = {
          bg = { attribute = "bg", highlight = "Normal" },
        },
      },
    },
    config = function(_, opts)
      require("bufferline").setup(opts)
      -- Fix bufferline when restoring a session
      vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
        callback = function()
          vim.schedule(function()
            pcall(nvim_bufferline)
          end)
        end,
      })
    end,
  },

  -- Registrar el grupo de buffers en which-key
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>b", group = "Buffer", icon = "" },
      },
    },
  },
}
