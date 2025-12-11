-- TypeScript/JavaScript/React development
return {
  -- TypeScript tools
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    opts = {
      settings = {
        separate_diagnostic_server = true,
        publish_diagnostic_on = "insert_leave",
        expose_as_code_action = { "fix_all", "add_missing_imports", "remove_unused" },
        tsserver_path = nil,
        tsserver_plugins = {},
        tsserver_max_memory = "auto",
        tsserver_format_options = {
          insertSpaceAfterCommaDelimiter = true,
          insertSpaceAfterSemicolonInForStatements = true,
          insertSpaceBeforeAndAfterBinaryOperators = true,
          insertSpaceAfterConstructor = false,
          insertSpaceAfterKeywordsInControlFlowStatements = true,
          insertSpaceAfterFunctionKeywordForAnonymousFunctions = true,
          insertSpaceAfterOpeningAndBeforeClosingNonemptyParenthesis = false,
          insertSpaceAfterOpeningAndBeforeClosingNonemptyBrackets = false,
          insertSpaceAfterOpeningAndBeforeClosingNonemptyBraces = true,
          insertSpaceAfterOpeningAndBeforeClosingEmptyBraces = true,
          insertSpaceAfterOpeningAndBeforeClosingTemplateStringBraces = false,
          insertSpaceAfterOpeningAndBeforeClosingJsxExpressionBraces = false,
          insertSpaceAfterTypeAssertion = false,
          insertSpaceBeforeFunctionParenthesis = false,
          placeOpenBraceOnNewLineForFunctions = false,
          placeOpenBraceOnNewLineForControlBlocks = false,
          semicolons = "insert",
        },
        tsserver_file_preferences = {
          includeInlayParameterNameHints = "all",
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayVariableTypeHintsWhenTypeMatchesName = false,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
          includeCompletionsForModuleExports = true,
          quotePreference = "single",
        },
        complete_function_calls = true,
        include_completions_with_insert_text = true,
      },
    },
    keys = {
      { "<leader>To", "<cmd>TSToolsOrganizeImports<cr>", desc = "Organize Imports" },
      { "<leader>Ts", "<cmd>TSToolsSortImports<cr>", desc = "Sort Imports" },
      { "<leader>Tr", "<cmd>TSToolsRemoveUnusedImports<cr>", desc = "Remove Unused Imports" },
      { "<leader>Tu", "<cmd>TSToolsRemoveUnused<cr>", desc = "Remove Unused" },
      { "<leader>Ta", "<cmd>TSToolsAddMissingImports<cr>", desc = "Add Missing Imports" },
      { "<leader>Tf", "<cmd>TSToolsFixAll<cr>", desc = "Fix All" },
      { "<leader>Tg", "<cmd>TSToolsGoToSourceDefinition<cr>", desc = "Go To Source Definition" },
      { "<leader>TR", "<cmd>TSToolsRenameFile<cr>", desc = "Rename File" },
    },
  },

  -- Prettier formatter
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        json = { "prettier" },
        jsonc = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        markdown = { "prettier" },
        yaml = { "prettier" },
      },
    },
  },

  -- ESLint integration
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        eslint = {
          settings = {
            workingDirectories = { mode = "auto" },
          },
        },
      },
    },
  },

  -- Tailwind CSS
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tailwindcss = {
          filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact" },
        },
      },
    },
  },

  -- Which-key group for TypeScript
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>T", group = "TypeScript", icon = "" },
      },
    },
  },
}
