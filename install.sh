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
  starship \
  gh \
  wp-cli \
  composer \
  node \
  jq \
  btop \
  tmux \
  cloudflared

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
  local \
  beekeeper-studio \
  slack \
  discord \
  telegram \
  google-chat \
  whatsapp \
  protonvpn \
  spotify \
  vlc \
  qbittorrent \
  imageoptim \
  hiddenbar \
  stats \
  karabiner-elements \
  mos \
  gimp \
  libreoffice \
  filezilla \
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
else
  echo "Bun already installed"
fi

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

# starship
mkdir -p ~/.config
ln -sf "$SCRIPT_DIR/configs/starship.toml" ~/.config/starship.toml
echo "  ~/.config/starship.toml"

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

# Dock
defaults write com.apple.dock tilesize -int 33
defaults write com.apple.dock show-recents -bool false

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
echo "5. Set Raycast hotkey to Cmd+Space (disable Spotlight first)"
echo "6. Grant Accessibility permissions to Mos and Karabiner-Elements"
echo "7. Log out and back in for keyboard repeat settings to take effect"
echo ""
echo "Done!"
