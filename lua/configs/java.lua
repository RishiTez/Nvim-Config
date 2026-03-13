local jdtls = require("jdtls")

local home = os.getenv("HOME")
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = home .. "/.local/share/nvim/jdtls-workspace/" .. project_name

local root_dir = require("jdtls.setup").find_root({
  ".git",
  "mvnw",
  "gradlew",
  "pom.xml",
  "build.gradle",
})

if not root_dir then
  return
end

local config = {
  cmd = { vim.fn.stdpath("data") .. "/mason/bin/jdtls" },
  root_dir = root_dir,
  workspace_folder = workspace_dir,
  settings = {
    java = {
      format = { enabled = true },
      signatureHelp = { enabled = true },
      contentProvider = { preferred = "fernflower" },
      referencesCodeLens = { enabled = true },
      implementationsCodeLens = { enabled = true },
    },
  },
  init_options = {
    bundles = vim.fn.glob(
      vim.fn.stdpath("data")
        .. "/mason/packages/java-debug-adapter/extension/server/*.jar",
      true
    ),
  },
}

jdtls.start_or_attach(config)
jdtls.setup_dap({ hotcodereplace = "auto" })
jdtls.setup.add_commands()
