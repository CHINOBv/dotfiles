-- Codeium: AI autocompletado gratuito (compatible con blink.cmp)
return {
  {
    "Exafunction/codeium.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    event = "InsertEnter",
    opts = {
      enable_chat = true,
    },
  },

  -- Agregar codeium como fuente de blink.cmp
  {
    "saghen/blink.cmp",
    optional = true,
    dependencies = { "Exafunction/codeium.nvim" },
    opts = {
      sources = {
        default = { "codeium", "lsp", "path", "snippets", "buffer" },
        providers = {
          codeium = {
            name = "codeium",
            module = "codeium.blink",
            async = true,
            score_offset = 100,
          },
        },
      },
    },
  },
}
