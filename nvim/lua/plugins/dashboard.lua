-- Dashboard con logo personalizado usando Snacks.nvim (LazyVim default)
return {
  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      -- Logo por defecto: .NET + Hexagonal + DDD
      local default_logo = [[
                                                                   
        ██████╗  ██████╗ ████████╗███╗   ██╗███████╗████████╗      
        ██╔══██╗██╔═══██╗╚══██╔══╝████╗  ██║██╔════╝╚══██╔══╝      
        ██║  ██║██║   ██║   ██║   ██╔██╗ ██║█████╗     ██║         
        ██║  ██║██║   ██║   ██║   ██║╚██╗██║██╔══╝     ██║         
        ██████╔╝╚██████╔╝   ██║   ██║ ╚████║███████╗   ██║         
        ╚═════╝  ╚═════╝    ╚═╝   ╚═╝  ╚═══╝╚══════╝   ╚═╝         
                                                                   
                    ╔═══════════════════════╗                      
                   ╱           ╲             ╲                     
                  ╱   DOMAIN    ╲             ╲                    
                 ╱    DRIVEN     ╲  ═══════════╗                   
                ╱     DESIGN      ╲  HEXAGONAL ║                   
               ╱                   ╲  PORTS &  ║                   
              ╱   ┌─────────────┐   ╲ ADAPTERS ║                   
             ╱    │  AGGREGATE  │    ╲═════════╝                   
            ╱     │   ROOTS     │     ╲                            
           ╱      └─────────────┘      ╲                           
          ╱         VALUE OBJECTS       ╲                          
         ╱═══════════════════════════════╲                         
                                                                   
             « Clean Architecture »                                
      ]]

      -- Intenta cargar logo personalizado desde .nvim/logo.txt
      local function load_custom_logo()
        local cwd = vim.fn.getcwd()
        local logo_path = cwd .. "/.nvim/logo.txt"
        local file = io.open(logo_path, "r")
        if file then
          local content = file:read("*all")
          file:close()
          return content
        end
        return nil
      end

      local custom_logo = load_custom_logo()
      local logo = custom_logo or default_logo

      opts.dashboard = opts.dashboard or {}
      opts.dashboard.preset = {
        header = logo,
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
          { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
          { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
      }

      opts.dashboard.sections = {
        { section = "header" },
        { section = "keys", gap = 1, padding = 1 },
        { section = "startup" },
      }

      return opts
    end,
  },
}
