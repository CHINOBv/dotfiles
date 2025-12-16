-- OpenCode integration
-- Keymaps definidos en config/keymaps.lua para evitar conflictos con lazy loading
return {
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
