require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

-- map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Copilot mappings
map("n", "<leader>cc", ":CopilotChatToggle<CR>", { noremap = true, silent = true, desc = "Toggle Copilot Chat" })
map("v", "<leader>ce", ":CopilotChatExplain<CR>", { noremap = true, silent = true, desc = "Explains selected code" })
map("v", "<leader>cf", ":CopilotChatFix<CR>", { noremap = true, silent = true, desc = "Rewrites the selected code without bugs" })

-- Nvim Tree mappings
map("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true, desc = "Toggle NvimTree" })
map("n", "<C-n>", ":NvimTreeFocus<CR>", { noremap = true, silent = true, desc = "Focus NvimTree" })
