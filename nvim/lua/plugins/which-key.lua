-- Which-key configuration con grupos
return {
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>b", group = "Buffer", icon = "" },
        { "<leader>c", group = "Code", icon = "" },
        { "<leader>d", group = "Debug", icon = "" },
        { "<leader>D", group = "Database", icon = "" },
        { "<leader>f", group = "File/Find", icon = "" },
        { "<leader>g", group = "Git", icon = "" },
        { "<leader>h", group = "Harpoon", icon = "󰛢" },
        { "<leader>N", group = ".NET", icon = "" },
        { "<leader>o", group = "OpenCode", icon = "" },
        { "<leader>q", group = "Quit/Session", icon = "" },
        { "<leader>s", group = "Search", icon = "" },
        { "<leader>t", group = "Terminal", icon = "" },
        { "<leader>u", group = "UI/Toggle", icon = "" },
        { "<leader>w", group = "Windows", icon = "" },
        { "<leader>x", group = "Diagnostics/TODOs", icon = "" },
      },
    },
    keys = {
      -- Code Actions accesibles (como VSCode Ctrl+.)
      { "<leader>.", vim.lsp.buf.code_action, desc = "Code Action (Quick Fix)", mode = { "n", "v" } },
      { "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" } },
      { "<leader>cr", vim.lsp.buf.rename, desc = "Rename Symbol" },
      { "<leader>cf", function() vim.lsp.buf.format({ async = true }) end, desc = "Format Document" },
      { "<leader>cF", function() vim.lsp.buf.format({ async = true, range = true }) end, desc = "Format Selection", mode = "v" },
      -- UI toggles
      { "<leader>un", function() require("notify").dismiss({ silent = true, pending = true }) end, desc = "Dismiss Notifications" },
    },
  },
}
