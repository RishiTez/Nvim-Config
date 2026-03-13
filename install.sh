#!/usr/bin/env bash
set -euo pipefail

# ── helpers ──────────────────────────────────────────────────────────────────

info()    { printf '\033[1;34m[info]\033[0m  %s\n' "$*"; }
success() { printf '\033[1;32m[ok]\033[0m    %s\n' "$*"; }
warn()    { printf '\033[1;33m[warn]\033[0m  %s\n' "$*"; }
die()     { printf '\033[1;31m[error]\033[0m %s\n' "$*" >&2; exit 1; }

require_cmd() {
  command -v "$1" &>/dev/null || die "'$1' is required but not found. $2"
}

# ── 0. sanity checks ─────────────────────────────────────────────────────────

require_cmd git   "Install Xcode Command Line Tools: xcode-select --install"
require_cmd brew  "Install Homebrew: https://brew.sh"
require_cmd curl  ""

NVIM_CONFIG_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ── 1. neovim ─────────────────────────────────────────────────────────────────

if command -v nvim &>/dev/null; then
  success "neovim already installed: $(nvim --version | head -1)"
else
  info "installing neovim..."
  brew install neovim
  success "neovim installed"
fi

# ── 2. nvm + node ─────────────────────────────────────────────────────────────

NODE_VERSION="23.1.0"

if [ ! -d "$HOME/.nvm" ]; then
  info "installing nvm..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
  success "nvm installed"
fi

# Load nvm in this script session
export NVM_DIR="$HOME/.nvm"
# shellcheck disable=SC1091
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"

if ! nvm ls "$NODE_VERSION" &>/dev/null; then
  info "installing node $NODE_VERSION..."
  nvm install "$NODE_VERSION"
  success "node $NODE_VERSION installed"
else
  success "node $NODE_VERSION already installed"
fi

nvm use "$NODE_VERSION"

# ── 3. python tools ───────────────────────────────────────────────────────────

if ! command -v python3 &>/dev/null; then
  info "installing python via brew..."
  brew install python
  success "python installed"
else
  success "python already available: $(python3 --version)"
fi

if ! python3 -c "import IPython" &>/dev/null 2>&1; then
  info "installing ipython..."
  python3 -m pip install --quiet ipython
  success "ipython installed"
else
  success "ipython already installed"
fi

# debugpy is required by nvim-dap-python
if ! python3 -c "import debugpy" &>/dev/null 2>&1; then
  info "installing debugpy..."
  python3 -m pip install --quiet debugpy
  success "debugpy installed"
else
  success "debugpy already installed"
fi

# ── 4. stylua ─────────────────────────────────────────────────────────────────

if command -v stylua &>/dev/null; then
  success "stylua already installed"
else
  info "installing stylua..."
  brew install stylua
  success "stylua installed"
fi

# ── 5. java (optional) ────────────────────────────────────────────────────────

if ! command -v java &>/dev/null; then
  warn "java not found — jdtls (Java LSP) will not work."
  warn "Install via: brew install temurin  (or your preferred JDK)"
fi

# ── 6. patch init.lua node path ───────────────────────────────────────────────

NODE_BIN="$NVM_DIR/versions/node/v${NODE_VERSION}/bin"
INIT_LUA="$NVIM_CONFIG_DIR/init.lua"

CURRENT_PATH=$(grep -m1 'local node_bin' "$INIT_LUA" | sed 's/.*"\(.*\)".*/\1/')

if [ "$CURRENT_PATH" != "$NODE_BIN" ]; then
  info "patching node_bin path in init.lua..."
  sed -i.bak "s|local node_bin = \".*\"|local node_bin = \"$NODE_BIN\"|" "$INIT_LUA"
  rm -f "$INIT_LUA.bak"
  success "init.lua patched: $NODE_BIN"
else
  success "init.lua node_bin path is already correct"
fi

# ── 7. lazy.nvim + plugins ────────────────────────────────────────────────────

info "installing neovim plugins via lazy.nvim (headless)..."
nvim --headless "+Lazy! sync" +qa 2>&1 | grep -v '^$' || true
success "plugins installed"

# ── 8. mason tools ───────────────────────────────────────────────────────────

info "installing mason tools (LSP servers, DAP adapters)..."
nvim --headless \
  -c "lua require('mason').setup()" \
  -c "lua local mr = require('mason-registry'); mr.refresh(function() local tools = { 'lua-language-server', 'pyright', 'typescript-language-server', 'gopls', 'jdtls', 'html-lsp', 'css-lsp', 'js-debug-adapter', 'java-debug-adapter' }; for _, t in ipairs(tools) do local p = mr.get_package(t); if not p:is_installed() then p:install() end end end)" \
  -c "sleep 10" \
  +qa 2>/dev/null || true
success "mason tools queued for installation (they finish on first nvim open)"

# ── done ─────────────────────────────────────────────────────────────────────

printf '\n'
success "setup complete. open nvim — mason will finish installing any remaining tools on first launch."
