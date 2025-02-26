require "nvchad.options"

-- add yours here!
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  command = "setlocal conceallevel=2",
})

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
