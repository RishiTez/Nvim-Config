return {
  {
    "ray-x/lsp_signature.nvim",
    event = "LspAttach",
    config = function()
      require("lsp_signature").setup({
        hint_enable = true,
        floating_window = true,
      })
    end,
  },
}
