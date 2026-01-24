return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
  	"nvim-treesitter/nvim-treesitter",
  	opts = {
  		ensure_installed = {"markdown", "markdown_inline", "vim", "lua", "vimdoc", "html", "css" },
      highlight = { enable = true },
  	},
  },
  -- LSP management
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {
      ensure_installed = {
        "pyright",     -- For Python
        "html",        -- For HTML
        "cssls",       -- For CSS
      },
    },
  },

  -- LSP configuration
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("mason-lspconfig").setup()
    end,
  },

  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local cmp = require("cmp")
      local cmp_mapping = cmp.mapping.preset.insert({
        ["<C-y>"] = cmp.mapping.confirm({ select = true }),
      })
      cmp.setup({
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "path" },
          { name = "buffer" },
        }),
        mapping = cmp_mapping,
      })
    end,
  },
}

