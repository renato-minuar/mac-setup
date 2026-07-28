#!/bin/bash
set -e

echo "=== macOS Setup ==="
echo ""

# --- Homebrew ---
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  echo "Homebrew already installed"
fi

# --- Formulae ---
echo ""
echo "Installing formulae..."
brew install \
  zsh-syntax-highlighting \
  zsh-autosuggestions \
  fzf \
  powerlevel10k \
  zoxide \
  bash \
  gh \
  wp-cli \
  composer \
  subversion \
  node \
  node@22 \
  node@24 \
  pnpm \
  rtk \
  go \
  jq \
  ripgrep \
  btop \
  tmux \
  cloudflared \
  duti \
  ffmpeg \
  sox \
  poppler \
  woff2

# node@22 / node@24 are keg-only. The chpwd hook in configs/.zshrc activates one
# per directory, reading the project's .node-version / .nvmrc.

# --- Casks ---
echo ""
echo "Installing casks..."
brew install --cask \
  kitty \
  font-fira-code \
  google-chrome \
  firefox \
  raycast \
  visual-studio-code \
  antigravity \
  claude \
  local \
  beekeeper-studio \
  slack \
  discord \
  telegram \
  signal \
  google-chat \
  whatsapp \
  microsoft-teams \
  protonvpn \
  tailscale-app \
  spotify \
  vlc \
  qbittorrent \
  imageoptim \
  hiddenbar \
  stats \
  karabiner-elements \
  mos \
  numi \
  shottr \
  gimp \
  inkscape \
  libreoffice \
  poedit \
  godot \
  gcloud-cli \
  obsidian

# Separate installs (may require password prompt)
echo ""
echo "Installing Docker Desktop and Google Drive (may require password)..."
brew install --cask docker-desktop google-drive

# --- Bun ---
if ! command -v bun &>/dev/null; then
  echo ""
  echo "Installing Bun..."
  curl -fsSL https://bun.sh/install | bash
  export BUN_INSTALL="$HOME/.bun"
  export PATH="$BUN_INSTALL/bin:$PATH"
else
  echo "Bun already installed"
fi

# --- AI CLIs ---
# Node globals land in the Homebrew node prefix, Bun globals in ~/.bun.
echo ""
echo "Installing AI CLIs..."
npm install -g \
  @anthropic-ai/claude-code \
  @google/gemini-cli \
  defuddle-cli \
  uipro-cli

bun install -g @openai/codex

# --- Config files ---
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo ""
echo "Linking config files..."

# zshrc
ln -sf "$SCRIPT_DIR/configs/.zshrc" ~/.zshrc
echo "  ~/.zshrc"

# tmux
ln -sf "$SCRIPT_DIR/configs/.tmux.conf" ~/.tmux.conf
echo "  ~/.tmux.conf"

# kitty
mkdir -p ~/.config/kitty
ln -sf "$SCRIPT_DIR/configs/kitty.conf" ~/.config/kitty/kitty.conf
echo "  ~/.config/kitty/kitty.conf"

# powerlevel10k
ln -sf "$SCRIPT_DIR/configs/.p10k.zsh" ~/.p10k.zsh
echo "  ~/.p10k.zsh"

# --- macOS defaults ---
echo ""
echo "Applying macOS defaults..."

# Finder
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder NewWindowTarget -string "PfHm"
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Dock (always visible — no auto-hide)
defaults write com.apple.dock tilesize -int 33
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock autohide -bool false

# Keyboard
defaults write NSGlobalDomain KeyRepeat -int 5
defaults write NSGlobalDomain InitialKeyRepeat -int 25

# Trackpad
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true

# Appearance
defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"

# Hot Corners — bottom-right = Quick Note
defaults write com.apple.dock wvous-br-corner -int 14

# Restart affected apps
killall Finder 2>/dev/null || true
killall Dock 2>/dev/null || true

# --- Raycast settings ---
echo ""
echo "To import Raycast settings, double-click: $SCRIPT_DIR/raycast-settings.rayconfig"

# --- Manual steps ---
echo ""
echo "=== Manual steps ==="
echo "1. Set up git:  git config --global user.name \"Your Name\""
echo "                git config --global user.email \"your@email.com\""
echo "2. Set up GitHub CLI:  gh auth login"
echo "3. Copy SSH keys from old machine and fix permissions"
echo "4. Set Chrome as default browser: System Settings > Desktop & Dock"
echo "5. Set Raycast hotkey to Cmd+Space (disable Spotlight first), then set up"
echo "   window management shortcuts — see SETUP-GUIDE.md section 9"
echo "6. Grant Accessibility permissions to Mos and Karabiner-Elements"
echo "7. Log out and back in for keyboard repeat settings to take effect"
echo "8. FileZilla has no cask any more — download from https://filezilla-project.org"
echo "9. Google Docs/Sheets/Slides are Chrome PWAs — install from Chrome (Cast, save, share > Install page as app)"
echo ""
echo "Coming from Windows? WINDOWS-TO-MAC.md covers the muscle-memory"
echo "differences (shortcuts, Finder, window snapping, force quit)."
echo ""
echo "Out of scope on purpose: entertainment apps. This provisions a work machine."
echo ""
echo "Done!"
