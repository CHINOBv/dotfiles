-- Codeium: AI autocompletado gratuito
return {
  {
    "Exafunction/codeium.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    event = "InsertEnter",
    config = function()
      require("codeium").setup({
        enable_chat = true,
      })
    end,
  },

  -- Agregar codeium como fuente de nvim-cmp
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      table.insert(opts.sources, 1, {
        name = "codeium",
        group_index = 1,
        priority = 100,
      })
    end,
  },
}
