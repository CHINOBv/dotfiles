-- Harpoon: Navegación rápida entre archivos marcados
-- Ideal para saltar entre 3-5 archivos que usas frecuentemente
return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require("harpoon")
      harpoon:setup({
        settings = {
          save_on_toggle = true,
          sync_on_ui_close = true,
        },
      })

      -- Keymaps
      local map = vim.keymap.set

      -- Agregar archivo actual a harpoon
      map("n", "<leader>ha", function() harpoon:list():add() end, { desc = "Harpoon: Add file" })

      -- Toggle menu de harpoon
      map("n", "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon: Menu" })

      -- Navegación directa a archivos 1-5
      map("n", "<leader>1", function() harpoon:list():select(1) end, { desc = "Harpoon: File 1" })
      map("n", "<leader>2", function() harpoon:list():select(2) end, { desc = "Harpoon: File 2" })
      map("n", "<leader>3", function() harpoon:list():select(3) end, { desc = "Harpoon: File 3" })
      map("n", "<leader>4", function() harpoon:list():select(4) end, { desc = "Harpoon: File 4" })
      map("n", "<leader>5", function() harpoon:list():select(5) end, { desc = "Harpoon: File 5" })

      -- Navegación prev/next
      map("n", "<leader>hp", function() harpoon:list():prev() end, { desc = "Harpoon: Previous" })
      map("n", "<leader>hn", function() harpoon:list():next() end, { desc = "Harpoon: Next" })

      -- Alternativa con Ctrl para acceso más rápido
      map("n", "<C-1>", function() harpoon:list():select(1) end, { desc = "Harpoon: File 1" })
      map("n", "<C-2>", function() harpoon:list():select(2) end, { desc = "Harpoon: File 2" })
      map("n", "<C-3>", function() harpoon:list():select(3) end, { desc = "Harpoon: File 3" })
      map("n", "<C-4>", function() harpoon:list():select(4) end, { desc = "Harpoon: File 4" })
    end,
  },

  -- Which-key group para Harpoon
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>h", group = "Harpoon", icon = "󱡀" },
      },
    },
  },
}
