local augroup = vim.api.nvim_create_augroup("LspFormattingAndImports", { clear = true })

-- Organize imports for JS/TS
vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup,
  pattern = { "*.ts", "*.tsx", "*.js", "*.jsx" },
  callback = function()
    vim.lsp.buf.code_action({
      context = { only = { "source.organizeImports" } },
      apply = true,
    })
  end,
})

-- Format on save (all files with LSP)
vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup,
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})
