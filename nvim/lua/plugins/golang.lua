-- Go development
return {
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup({
        goimports = "gopls",
        gofmt = "gopls",
        tag_transform = false,
        test_dir = "",
        comment_placeholder = "   ",
        lsp_cfg = true,
        lsp_gofumpt = true,
        lsp_on_attach = nil,
        lsp_keymaps = false, -- we'll set our own
        lsp_codelens = true,
        lsp_diag_hdlr = true,
        lsp_inlay_hints = {
          enable = true,
          style = "inlay",
          only_current_line = false,
          only_current_line_autocmd = "CursorHold",
          show_variable_name = true,
          parameter_hints_prefix = "󰊕 ",
          show_parameter_hints = true,
          other_hints_prefix = "=> ",
        },
        gopls_cmd = nil,
        gopls_remote_auto = true,
        dap_debug = true,
        dap_debug_keymap = false,
        dap_debug_gui = true,
        dap_debug_vt = true,
        dap_port = 38697,
        build_tags = "",
        textobjects = true,
        test_runner = "go",
        verbose_tests = true,
        run_in_floaterm = false,
        trouble = true,
        luasnip = true,
      })
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()',
    keys = {
      -- Run/Test
      { "<leader>Gr", "<cmd>GoRun<cr>", desc = "Go Run" },
      { "<leader>Gt", "<cmd>GoTest<cr>", desc = "Go Test" },
      { "<leader>GT", "<cmd>GoTestFunc<cr>", desc = "Go Test Function" },
      { "<leader>Gc", "<cmd>GoCoverage<cr>", desc = "Go Coverage" },
      
      -- Generate/Modify
      { "<leader>Gi", "<cmd>GoImpl<cr>", desc = "Go Impl Interface" },
      { "<leader>Gf", "<cmd>GoFillStruct<cr>", desc = "Go Fill Struct" },
      { "<leader>Ge", "<cmd>GoIfErr<cr>", desc = "Go If Err" },
      { "<leader>Ga", "<cmd>GoAddTag<cr>", desc = "Go Add Tags" },
      { "<leader>GR", "<cmd>GoRmTag<cr>", desc = "Go Remove Tags" },
      
      -- Debug
      { "<leader>Gd", "<cmd>GoDebug<cr>", desc = "Go Debug" },
      { "<leader>Gs", "<cmd>GoDebug -s<cr>", desc = "Go Debug Stop" },
      { "<leader>Gb", "<cmd>GoBreakToggle<cr>", desc = "Go Toggle Breakpoint" },

      -- Code actions
      { "<leader>Gj", "<cmd>GoJson2Struct<cr>", desc = "JSON to Struct", mode = "v" },
      { "<leader>Gl", "<cmd>GoLint<cr>", desc = "Go Lint" },
      { "<leader>Gv", "<cmd>GoVet<cr>", desc = "Go Vet" },
    },
  },

  -- Go DAP configuration
  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
      {
        "leoluz/nvim-dap-go",
        config = function()
          require("dap-go").setup({
            dap_configurations = {
              {
                type = "go",
                name = "Debug",
                request = "launch",
                program = "${file}",
              },
              {
                type = "go",
                name = "Debug Package",
                request = "launch",
                program = "${fileDirname}",
              },
              {
                type = "go",
                name = "Debug test",
                request = "launch",
                mode = "test",
                program = "${file}",
              },
              {
                type = "go",
                name = "Debug test (go.mod)",
                request = "launch",
                mode = "test",
                program = "./${relativeFileDirname}",
              },
            },
            delve = {
              path = "dlv",
              initialize_timeout_sec = 20,
              port = "${port}",
              args = {},
              build_flags = "",
            },
          })
        end,
      },
    },
  },

  -- Formatter
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        go = { "goimports", "gofumpt" },
      },
    },
  },

  -- Which-key group for Go
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>G", group = "Go", icon = "" },
      },
    },
  },
}
