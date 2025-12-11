-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- Windows
map("n", "<leader>ww", "<C-W>p", { desc = "Other Window" })
map("n", "<leader>wd", "<C-W>c", { desc = "Delete Window" })
map("n", "<leader>w-", "<C-W>s", { desc = "Split Window Below" })
map("n", "<leader>w|", "<C-W>v", { desc = "Split Window Right" })
map("n", "<leader>-", "<C-W>s", { desc = "Split Window Below" })
map("n", "<leader>|", "<C-W>v", { desc = "Split Window Right" })

-- Resize windows con flechas
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- Mover líneas (Ctrl+Shift+j/k para evitar conflicto con GlazeWM)
map("n", "<C-S-j>", "<cmd>m .+1<cr>==", { desc = "Move Line Down" })
map("n", "<C-S-k>", "<cmd>m .-2<cr>==", { desc = "Move Line Up" })
map("i", "<C-S-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Line Down" })
map("i", "<C-S-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Line Up" })
map("v", "<C-S-j>", ":m '>+1<cr>gv=gv", { desc = "Move Lines Down" })
map("v", "<C-S-k>", ":m '<-2<cr>gv=gv", { desc = "Move Lines Up" })

-- Mejor indentación en visual mode
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Clear search con Escape
map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear Search Highlight" })

-- Guardar archivo
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

-- Quit
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit All" })

-- Better up/down con word wrap
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Centro la pantalla después de buscar
map("n", "n", "nzzzv", { desc = "Next Search Result" })
map("n", "N", "Nzzzv", { desc = "Previous Search Result" })
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll Down" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll Up" })

-- Navegación entre ventanas más fácil (sin Ctrl+w)
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window" })

-- Salir del modo terminal más fácil
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit Terminal Mode" })
map("t", "<C-h>", "<C-\\><C-n><C-w>h", { desc = "Go to Left Window" })
map("t", "<C-j>", "<C-\\><C-n><C-w>j", { desc = "Go to Lower Window" })
map("t", "<C-k>", "<C-\\><C-n><C-w>k", { desc = "Go to Upper Window" })
map("t", "<C-l>", "<C-\\><C-n><C-w>l", { desc = "Go to Right Window" })

-- H y L para inicio/final de línea (más fácil que ^ y $)
map({ "n", "v", "o" }, "H", "^", { desc = "Start of Line" })
map({ "n", "v", "o" }, "L", "$", { desc = "End of Line" })
