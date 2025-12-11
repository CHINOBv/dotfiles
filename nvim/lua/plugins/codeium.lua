-- Codeium: AI autocompletado gratuito (versión vim - independiente)
return {
  {
    "Exafunction/codeium.vim",
    event = "InsertEnter",
    config = function()
      -- Tab para aceptar sugerencia
      vim.keymap.set("i", "<Tab>", function()
        if vim.fn["codeium#Accept"]() ~= "" then
          return vim.fn["codeium#Accept"]()
        else
          return "\t"
        end
      end, { expr = true, silent = true })

      -- Alt+] para siguiente sugerencia
      vim.keymap.set("i", "<A-]>", function()
        return vim.fn["codeium#CycleCompletions"](1)
      end, { expr = true, silent = true })

      -- Alt+[ para sugerencia anterior
      vim.keymap.set("i", "<A-[>", function()
        return vim.fn["codeium#CycleCompletions"](-1)
      end, { expr = true, silent = true })

      -- Ctrl+] para cancelar sugerencia
      vim.keymap.set("i", "<C-]>", function()
        return vim.fn["codeium#Clear"]()
      end, { expr = true, silent = true })

      -- Desactivar el keymap por defecto de Tab de codeium
      vim.g.codeium_no_map_tab = true
    end,
  },
}
