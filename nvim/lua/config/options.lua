-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- ============================================================================
-- Desactivar providers que no necesitamos (elimina warnings)
-- ============================================================================
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

-- ============================================================================
-- Opciones específicas para C#/.NET
-- ============================================================================
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- ============================================================================
-- Opciones generales mejoradas
-- ============================================================================
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.updatetime = 200
vim.opt.timeoutlen = 300
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.wrap = false
vim.opt.cursorline = true

-- ============================================================================
-- Desactivar luarocks (no lo necesitamos)
-- ============================================================================
vim.g.lazyvim_rocks_enabled = false
