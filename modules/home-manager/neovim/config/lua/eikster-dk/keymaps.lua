-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap

-- Normal --
-- disable Ex mode, I always enter in it by mistake
keymap.set("n", "Q", "<Nop>")

-- Half page up and down movements & center
keymap.set("n", "<C-u>", "<C-u>zz")
keymap.set("n", "<C-d>", "<C-d>zz")

-- Move text up and down
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true })
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true })

--- greatest remap ever
keymap.set({ "x" }, "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
keymap.set({ "n", "v" }, "<leader>y", [["+y]])
keymap.set("n", "<leader>Y", [["+Y]])
keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- good search/replace: thanks theprimeagen
keymap.set("n", "<leader>sr", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- indention and.. outdention?
-- enable to continue to indent our outdent instead of clearing visual mode
vim.keymap.set("v", "<", "<gv", { noremap = true })
vim.keymap.set("v", ">", ">gv", { noremap = true })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- save
vim.keymap.set("n", "<leader>w", ":write<CR>", { desc = "Save file" })
vim.keymap.set("n", "<leader>W", ":noautocmd write<CR>", { desc = "Save file with no autocmd" })

-- copy the current file path
vim.keymap.set("n", "<leader>fy", ':let @" = expand("%:.")<CR>', { desc = "Copy the current file relative path"})
vim.keymap.set("n", "<leader>fY", ':let @" = expand("%:p")<CR>', { desc = "Copy the current file absolute path"})
