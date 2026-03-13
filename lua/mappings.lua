require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

-- map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Nvim Tree mappings
map("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true, desc = "Toggle NvimTree" })
map("n", "<C-n>", ":NvimTreeFocus<CR>", { noremap = true, silent = true, desc = "Focus NvimTree" })

-- Diagnostics
local diag_win = nil
map("n", "<leader>cd", function()
  if diag_win and vim.api.nvim_win_is_valid(diag_win) then
    vim.api.nvim_win_close(diag_win, true)
    diag_win = nil
  else
    _, diag_win = vim.diagnostic.open_float({ border = "rounded" })
  end
end, { desc = "Toggle diagnostic" })
