return{
  "mfussenegger/nvim-dap",
  lazy = false,
  dependencies = {
    "rcarriga/nvim-dap-ui",  
    "theHamsta/nvim-dap-virtual-text",
    "nvim-neotest/nvim-nio",
    "mfussenegger/nvim-dap-python",
  },

  config = function()
    local dap = require("dap")
    local dapui = require("dapui")
    local dap_python = require("dap-python")
    
    require("dapui").setup({})
    require("nvim-dap-virtual-text").setup({
      commented = true,
    })

    dap_python.setup("python3")

    vim.fn.sign_define("DapBreakpoint", {
      text = "⊙",
      texthl = "DiagnosticSignError",
      linehl = "",
      numhl = "",
    })

    vim.fn.sign_define("DapBreakpointRejected", {
      text = "⊘",
      texthl = "DiagnosticSignError",
      linehl = "",
      numhl = "",
    })

    vim.fn.sign_define("DapStopped", {
      text = "→",
      texthl = "DiagnosticSignWarn",
      linehl = "Visual",
      numhl = "DiagnosticSignWarn",
    })

    dap.listeners.after.event_initialized['dapui_config'] = function()
      dapui.open()
    end

    -- Toggle Breakpoints
    vim.keymap.set("n", "<leader>db", function()
      dap.toggle_breakpoint()
    end, {noremap = true, silent = true, desc = "Toggle Breakpoint"})

    -- Continue / Start
    vim.keymap.set("n", "<leader>dc", function()
      dap.continue()
    end, {noremap = true, silent = true, desc = "Continue"})

    -- Step Over
    vim.keymap.set("n", "<leader>do", function()
      dap.step_over()
    end, {noremap = true, silent = true, desc = "Start Over"})

    -- Step Into
    vim.keymap.set("n", "<leader>di", function()
      dap.step_into()
    end, {noremap = true, silent = true, desc = "Step Into"})

    -- Step Out
    vim.keymap.set("n", "<leader>dO", function()
      dap.step_out()
    end, {noremap = true, silent = true, desc = "Step Out"})

    -- Restart
    vim.keymap.set("n", "<leader>dr", function()
      dap.restart()
    end, {noremap = true, silent = true, desc = "Restart"})

    -- Terminate Debugging
    vim.keymap.set("n", "<leader>dq", function()
      dap.terminate()
    end, {noremap = true, silent = true, desc = "Terminate Debugging"})

    -- Toggle UI
    vim.keymap.set("n", "<leader>du", function()
      dapui.toggle()
    end, {noremap = true, silent = true, desc = "Toggle UI"})
  end,
}
