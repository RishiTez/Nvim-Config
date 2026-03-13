vim.diagnostic.config({
  float = { border = "rounded" },
  update_in_insert = true,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  command = "setlocal conceallevel=2",
})

