-- Which-key configuration con grupos
return {
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>b", group = "Buffer", icon = "" },
        { "<leader>c", group = "Code", icon = "" },
        { "<leader>d", group = "Debug", icon = "" },
        { "<leader>f", group = "File/Find", icon = "" },
        { "<leader>g", group = "Git", icon = "" },
        { "<leader>N", group = ".NET", icon = "" },
        { "<leader>o", group = "OpenCode", icon = "" },
        { "<leader>q", group = "Quit/Session", icon = "" },
        { "<leader>s", group = "Search", icon = "" },
        { "<leader>t", group = "Terminal", icon = "" },
        { "<leader>u", group = "UI", icon = "" },
        { "<leader>w", group = "Windows", icon = "" },
        { "<leader>x", group = "Diagnostics/Quickfix", icon = "" },
      },
    },
  },
}
