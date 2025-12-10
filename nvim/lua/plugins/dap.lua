-- Debug Adapter Protocol para .NET con netcoredbg
-- FIX: Paths convertidos a formato Windows para compatibilidad con netcoredbg
return {
  -- Which-key group
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>d", group = "Debug", icon = "" },
      },
    },
  },

  -- DAP principal
  {
    "mfussenegger/nvim-dap",
    lazy = true,
    event = "VeryLazy",
    dependencies = {
      {
        "rcarriga/nvim-dap-ui",
        dependencies = { "nvim-neotest/nvim-nio" },
        opts = {},
        config = function(_, opts)
          local dap = require("dap")
          local dapui = require("dapui")
          dapui.setup(opts)
          dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open({})
          end
          dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close({})
          end
          dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close({})
          end
        end,
      },
      {
        "theHamsta/nvim-dap-virtual-text",
        opts = {},
      },
    },
    config = function()
      local dap = require("dap")

      -- FIX CRÍTICO para Windows: Convertir paths de forward slashes a backslashes
      -- Neovim usa "/" pero netcoredbg necesita "\" para mapear breakpoints correctamente
      local Session = require("dap.session")
      local original_session_request = Session.request

      Session.request = function(self, command, arguments, callback)
        if command == "setBreakpoints" and arguments and arguments.source and arguments.source.path then
          arguments.source.path = arguments.source.path:gsub("/", "\\")
        end
        return original_session_request(self, command, arguments, callback)
      end

      -- Adapter de netcoredbg
      dap.adapters.coreclr = {
        type = "executable",
        command = "C:\\tools\\netcoredbg\\netcoredbg.exe",
        args = { "--interpreter=vscode" },
        options = {
          detached = false,
        },
      }

      -- Configuraciones para proyectos .NET
      local function get_cwd()
        return vim.fn.getcwd():gsub("/", "\\")
      end

      -- Función para buscar DLLs de proyectos automáticamente
      local function find_project_dlls()
        local cwd = get_cwd()
        local configs = {}

        -- Buscar en Apps/*/bin/Debug/net*/*.dll
        local apps_pattern = cwd .. "\\Apps\\*\\bin\\Debug\\net*"
        local apps_dirs = vim.fn.glob(apps_pattern, false, true)

        for _, dir in ipairs(apps_dirs) do
          dir = dir:gsub("/", "\\")
          local dlls = vim.fn.glob(dir .. "\\*.dll", false, true)
          for _, dll in ipairs(dlls) do
            dll = dll:gsub("/", "\\")
            local dll_name = vim.fn.fnamemodify(dll, ":t:r")
            local project_dir = dir:match("(.+\\Apps\\[^\\]+)")
            
            if project_dir then
              local csproj = project_dir .. "\\" .. dll_name .. ".csproj"
              if vim.fn.filereadable(csproj) == 1 then
                table.insert(configs, {
                  type = "coreclr",
                  name = dll_name,
                  request = "launch",
                  program = dll,
                  cwd = project_dir,
                  stopAtEntry = false,
                  justMyCode = false,
                  env = {
                    ASPNETCORE_ENVIRONMENT = "Development",
                  },
                })
              end
            end
          end
        end

        -- Si no encontró nada en Apps/, buscar en el directorio actual
        if #configs == 0 then
          local direct_pattern = cwd .. "\\bin\\Debug\\net*"
          local direct_dirs = vim.fn.glob(direct_pattern, false, true)
          
          for _, dir in ipairs(direct_dirs) do
            dir = dir:gsub("/", "\\")
            local dlls = vim.fn.glob(dir .. "\\*.dll", false, true)
            for _, dll in ipairs(dlls) do
              dll = dll:gsub("/", "\\")
              local dll_name = vim.fn.fnamemodify(dll, ":t:r")
              local csproj = cwd .. "\\" .. dll_name .. ".csproj"
              
              if vim.fn.filereadable(csproj) == 1 then
                table.insert(configs, {
                  type = "coreclr",
                  name = dll_name,
                  request = "launch",
                  program = dll,
                  cwd = cwd,
                  stopAtEntry = false,
                  justMyCode = false,
                  env = {
                    ASPNETCORE_ENVIRONMENT = "Development",
                  },
                })
              end
            end
          end
        end

        return configs
      end

      -- Configuración manual (para seleccionar DLL manualmente)
      local manual_config = {
        type = "coreclr",
        name = "[Manual] Select DLL...",
        request = "launch",
        program = function()
          local cwd = get_cwd()
          return vim.fn.input("Path to DLL: ", cwd .. "\\", "file"):gsub("/", "\\")
        end,
        cwd = function()
          return get_cwd()
        end,
        stopAtEntry = false,
        justMyCode = false,
        env = {
          ASPNETCORE_ENVIRONMENT = "Development",
        },
      }

      -- Configuraciones iniciales (se actualizan dinámicamente)
      local cs_configs = find_project_dlls()
      table.insert(cs_configs, manual_config)

      dap.configurations.cs = cs_configs

      -- Iconos para breakpoints
      vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError" })
      vim.fn.sign_define("DapBreakpointCondition", { text = "◐", texthl = "DiagnosticWarn" })
      vim.fn.sign_define("DapLogPoint", { text = "◆", texthl = "DiagnosticInfo" })
      vim.fn.sign_define("DapStopped", { text = "→", texthl = "DiagnosticOk", linehl = "Visual" })
      vim.fn.sign_define("DapBreakpointRejected", { text = "○", texthl = "DiagnosticError" })

      -- Función para compilar proyecto antes de debug
      local function build_project(project_cwd, callback)
        vim.notify("Building project...", vim.log.levels.INFO)
        
        local cmd = string.format('dotnet build "%s" --no-restore', project_cwd)
        
        vim.fn.jobstart(cmd, {
          on_exit = function(_, exit_code)
            if exit_code == 0 then
              vim.notify("Build successful!", vim.log.levels.INFO)
              callback(true)
            else
              vim.notify("Build failed! Check :messages for details.", vim.log.levels.ERROR)
              callback(false)
            end
          end,
          on_stdout = function(_, data)
            for _, line in ipairs(data) do
              if line and line ~= "" then
                -- Mostrar errores de compilación
                if line:match("error") then
                  vim.notify(line, vim.log.levels.ERROR)
                end
              end
            end
          end,
          on_stderr = function(_, data)
            for _, line in ipairs(data) do
              if line and line ~= "" and line:match("error") then
                vim.notify(line, vim.log.levels.ERROR)
              end
            end
          end,
        })
      end

      -- Función para iniciar debug de .NET (busca proyectos dinámicamente)
      local function start_dotnet_debug()
        -- Refrescar la lista de proyectos cada vez
        local configs = find_project_dlls()
        table.insert(configs, manual_config)
        
        if #configs == 0 then
          vim.notify("No .NET projects found. Use [Manual] to select a DLL.", vim.log.levels.WARN)
          configs = { manual_config }
        end

        vim.ui.select(configs, {
          prompt = "Select .NET project to debug:",
          format_item = function(item)
            return item.name
          end,
        }, function(selected)
          if selected then
            -- Compilar antes de iniciar debug
            local project_cwd = type(selected.cwd) == "function" and selected.cwd() or selected.cwd
            build_project(project_cwd, function(success)
              if success then
                -- Refrescar la config para obtener el DLL más reciente
                local fresh_configs = find_project_dlls()
                for _, cfg in ipairs(fresh_configs) do
                  if cfg.name == selected.name then
                    dap.run(cfg)
                    return
                  end
                end
                -- Si no encuentra, usar la config original
                dap.run(selected)
              end
            end)
          end
        end)
      end

      -- Comandos
      vim.api.nvim_create_user_command("DapDotnet", start_dotnet_debug, {
        desc = "Start .NET debugging",
      })
    end,
    keys = {
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Condition: ")) end, desc = "Conditional Breakpoint" },
      { "<leader>dc", "<cmd>DapDotnet<cr>", desc = "Start .NET Debug" },
      { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
      { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
      { "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
      { "<leader>dO", function() require("dap").step_over() end, desc = "Step Over" },
      { "<leader>dp", function() require("dap").pause() end, desc = "Pause" },
      { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
      { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
      { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
      { "<leader>du", function() require("dapui").toggle({}) end, desc = "Toggle DAP UI" },
      { "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = { "n", "v" } },
      { "<leader>dj", function() require("dap").down() end, desc = "Down (Stack)" },
      { "<leader>dk", function() require("dap").up() end, desc = "Up (Stack)" },
      { "<F5>", "<cmd>DapDotnet<cr>", desc = "Start .NET Debug" },
      { "<F9>", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
      { "<F10>", function() require("dap").step_over() end, desc = "Step Over" },
      { "<F11>", function() require("dap").step_into() end, desc = "Step Into" },
      { "<S-F11>", function() require("dap").step_out() end, desc = "Step Out" },
      { "<S-F5>", function() require("dap").terminate() end, desc = "Stop Debug" },
    },
  },
}
