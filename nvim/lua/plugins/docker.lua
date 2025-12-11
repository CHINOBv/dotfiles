-- Docker development
return {
  -- Docker LSP
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        dockerls = {},
        docker_compose_language_service = {},
      },
    },
  },

  -- Dockerfile syntax
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "dockerfile" })
      end
    end,
  },

  -- Docker commands
  {
    "dgrbrady/nvim-docker",
    dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" },
    cmd = { "Docker" },
    keys = {
      { "<leader>Dc", "<cmd>Docker containers<cr>", desc = "Docker Containers" },
      { "<leader>Di", "<cmd>Docker images<cr>", desc = "Docker Images" },
      { "<leader>Dn", "<cmd>Docker networks<cr>", desc = "Docker Networks" },
      { "<leader>Dv", "<cmd>Docker volumes<cr>", desc = "Docker Volumes" },
    },
    config = true,
  },

  -- Which-key group for Docker
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>D", group = "Docker", icon = "" },
      },
    },
  },
}
