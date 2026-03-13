# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a Neovim configuration built on top of [NvChad v2.5](https://github.com/NvChad/NvChad) as the base framework. NvChad provides the plugin ecosystem, UI defaults, and base keymaps. This config extends NvChad with custom plugins and overrides.

## Architecture

**Entry point:** `init.lua` — bootstraps Lazy.nvim, loads NvChad, and declares some plugins inline.

**Key files:**
- `lua/chadrc.lua` — NvChad theme/UI overrides (theme: catppuccin)
- `lua/options.lua` — Vim option overrides on top of NvChad defaults
- `lua/mappings.lua` — Keymap overrides on top of NvChad defaults
- `lua/configs/lspconfig.lua` — LSP server configuration (pyright, html, cssls)
- `lua/configs/conform.lua` — Formatter config (stylua for Lua)
- `lua/plugins/init.lua` — Custom plugin specs
- `lua/plugins/debugging.lua` — DAP (Debug Adapter Protocol) setup
- `lua/custom/init.lua` — Autocmds

**Plugin management:** Lazy.nvim with a lock file (`lazy-lock.json`). Plugins come from two sources:
1. NvChad's built-in plugin set (imported via `{ import = "nvchad.plugins" }`)
2. Custom specs in `lua/plugins/` and inline in `init.lua`

## Custom Plugins

Beyond the NvChad defaults, this config adds:

| Plugin | Purpose |
|---|---|
| `iron.nvim` | Python/Lua REPL (ipython, vertical 60-char split) |
| `live-server.nvim` | Live reload for web dev |
| `git-blame.nvim` | Inline git blame virtual text |
| `nvim-dap` + `nvim-dap-ui` + `nvim-dap-python` | Python debugging with DAP |
| `nvim-dap-vscode-js` + `vscode-js-debug` | TypeScript/JavaScript debugging with DAP |
| `nvim-dap-virtual-text` | Inline variable values during debug |

## Key Mappings (leader = space)

**REPL (iron.nvim):**
- `<space>so` — Open REPL
- `<space>sc` / `<space>sf` / `<space>sl` — Send motion/file/line to REPL
- `<space>sq` / `<space>cl` — Exit / Clear REPL

**Debugging (DAP):**
- `<leader>db` — Toggle breakpoint
- `<leader>dc` — Continue / start
- `<leader>do` / `<leader>di` / `<leader>dO` — Step over/into/out
- `<leader>dr` / `<leader>dq` — Restart / terminate
- `<leader>du` — Toggle debug UI
- `<leader>dx` — Remove all breakpoints

**Terminal:** `jk` exits terminal mode

## Code Style

Lua is formatted with `stylua` (120 column width, 2-space indent, double quotes). Run manually — format-on-save is disabled.

## Adding Plugins

Add plugin specs to `lua/plugins/init.lua` (or a new file in `lua/plugins/`). Follow Lazy.nvim spec format. Avoid overriding NvChad-managed plugins unless intentionally extending them.

## LSP Servers

Managed via mason.nvim. To add a new server, install it with `:MasonInstall <server>` and add it to the `servers` table in `lua/configs/lspconfig.lua`.
