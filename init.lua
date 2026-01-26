local node_bin = "/Users/rishi/.nvm/versions/node/v23.1.0/bin"
vim.env.PATH = node_bin .. ":" .. vim.env.PATH
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
    "Vigemus/iron.nvim",
    config = function()
      local iron = require("iron.core")

      iron.setup {
        config = {
          repl_definition = {
            python = { command = { "ipython" , "--no-autoindent" } },
            lua = { command = { "lua" } },
          },
          repl_open_cmd = "vertical botright 60 split",
        },
        format = function(lines)
          if lines[1] == "" then table.remove(lines, 1) end
          if lines[#lines] == "" then table.remove(lines, #lines) end

          local min_indent = math.huge
          for _, line in ipairs(lines) do
            local indent = line:match("^(%s*)")
            if #indent < min_indent and #indent < #line then
              min_indent = #indent
            end
          end
          if min_indent == math.huge then min_indent = 0 end

          for i, line in ipairs(lines) do
            lines[i] = line:sub(min_indent + 1)
          end

          table.insert(lines, 1, "%cpaste -q")
          table.insert(lines, "%cpaste --")
          return lines
        end,
        keymaps = {
          send_motion = "<space>sc",
          visual_send = "<space>sc",
          send_file = "<space>sf",
          send_line = "<space>sl",
          exit = "<space>sq",
          clear = "<space>cl",
        },
        highlight = { italic = true },
        ignore_blank_lines = true, }

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "python",
        callback = function()
          vim.keymap.set("n", "<space>so", function()
            iron.repl_for("python")
          end, { buffer = true, desc = "Open Python REPL" })
        end,
      })
    end,
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
