-- Configuración de nvim-cmp keymaps
-- Tab = aceptar ghost text / expandir snippet
-- Enter = seleccionar del menú
return {
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      opts.mapping = vim.tbl_extend("force", opts.mapping or {}, {
        -- Enter solo confirma si hay algo seleccionado en el menú
        ["<CR>"] = cmp.mapping.confirm({ select = false }),

        -- Tab: expandir snippet o aceptar ghost text, o siguiente item
        ["<Tab>"] = cmp.mapping(function(fallback)
          if luasnip.expandable() then
            luasnip.expand()
          elseif cmp.visible() then
            -- Si el menú está visible, selecciona el primer item y confirma
            if not cmp.get_selected_entry() then
              cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            end
            cmp.confirm({ select = true })
          elseif luasnip.jumpable(1) then
            luasnip.jump(1)
          else
            fallback()
          end
        end, { "i", "s" }),

        -- Shift-Tab: saltar atrás en snippet
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if luasnip.jumpable(-1) then
            luasnip.jump(-1)
          elseif cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end, { "i", "s" }),

        -- Ctrl+j/k para navegar el menú sin seleccionar
        ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
        ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
      })

      return opts
    end,
  },
}
