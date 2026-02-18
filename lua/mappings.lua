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
map("n", "<leader>cd", ":Copilot disable<CR>", { noremap = true, silent = true, desc = "Disable Copilot" })

-- Nvim Tree mappings
map("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true, desc = "Toggle NvimTree" })
map("n", "<C-n>", ":NvimTreeFocus<CR>", { noremap = true, silent = true, desc = "Focus NvimTree" })

-- Navigation
map("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to Declaration" })
map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to Implementation" })
map("n", "gr", vim.lsp.buf.references, { desc = "Find References" })
map("n", "gt", vim.lsp.buf.type_definition, { desc = "Go to Type Definition" })

-- Documentation
map("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation" })
map("n", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature Help" })

-- Refactoring
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename Symbol" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })

-- Formatting
map("n", "<leader>fm", function()
  vim.lsp.buf.format({ async = true })
end, { desc = "Format File" })

-- Diagnostics
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous Diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })
map("n", "<leader>dl", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
map("n", "<leader>dq", vim.diagnostic.setloclist, { desc = "Diagnostics List" })

-- Workspace
map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, { desc = "Add Workspace Folder" })
map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, { desc = "Remove Workspace Folder" })
map("n", "<leader>wl", function()
  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, { desc = "List Workspace Folders" })

-- Inlay Hints Toggle
map("n", "<leader>ih", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "Toggle Inlay Hints" })
