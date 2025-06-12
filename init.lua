vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },
  {
    "github/copilot.vim",
    lazy = false,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    lazy = false,
    build = "make tiktoken", -- Only on MacOS or Linux
    format = "markdown",
    opts = {
      -- See Configuration section for options
    },
    -- See Commands section for default commands if you want to lazy load on them
  },
  {
    "GCBallesteros/jupytext.nvim",
    config = true,
    lazy = false,
  },
  {
    'barrett-ruth/live-server.nvim',
    build = 'npm add -g live-server',
    cmd = { 'LiveServerStart', 'LiveServerStop' },
    config = true,
  },
  {
    "f-person/git-blame.nvim",
    event = "VeryLazy",
    opts = {
        enabled = true, 
        message_template = " <author> • <date>", 
        date_format = "%d-%m-%Y %H:%M:%S", 
        virtual_text_column = 1,  
    },
  },
  { import = "plugins" },
}, lazy_config)

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  command = "setlocal conceallevel=2",
})
vim.opt.completeopt = {"menu", "menuone", "noinsert", "noselect", "popup"}

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)

-- Custom
vim.api.nvim_set_keymap('t','jk', '<C-\\><C-n>', { noremap = true, silent = true })

vim.opt.relativenumber = true
