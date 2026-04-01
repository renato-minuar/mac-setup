# macOS Setup Guide

macOS setup for productivity, terminal workflows, and web development — no iCloud, no Apple ecosystem lock-in.

> This guide is written to be AI-readable. On a fresh machine, point Claude Code at this repo and it can execute the full setup autonomously.

---

## 1. Package Manager

### Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

After install, follow the instructions to add Homebrew to your PATH.

---

## 2. Terminal

### Kitty

```bash
brew install --cask kitty
```

### Fira Code

```bash
brew install --cask font-fira-code
```

### Kitty Configuration

Create `~/.config/kitty/kitty.conf`:

```
# Font
font_family Fira Code
font_size 16.0
disable_ligatures never

# Cursor
cursor_shape beam
cursor_blink_interval 0

# Scrollback
scrollback_lines 10000

# Window
window_padding_width 8
hide_window_decorations no
confirm_os_window_close 0
background_opacity 0.65
background_blur 48
background #1a0a2e

# Tab bar
tab_bar_style powerline
tab_powerline_style slanted

# macOS
macos_option_as_alt yes
macos_quit_when_last_window_closed yes

# URLs
url_style curly
open_url_with default

# Bell
enable_audio_bell no
visual_bell_duration 0

# Clipboard
copy_on_select clipboard
clipboard_control write-clipboard write-primary read-clipboard read-primary
```

---

## 3. Terminal Multiplexer

### tmux

Three reasons this is in the stack: (1) sessions persist — accidental `Ctrl+C` doesn't kill a running Claude Code session, reattach with `tmux attach`; (2) keyboard-driven copy without touching the mouse; (3) fully scriptable — Claude can spawn and orchestrate multiple panes programmatically.

```bash
brew install tmux
```

Create `~/.tmux.conf`:

```
# Prefix: Ctrl+a (more ergonomic than default Ctrl+b)
set -g prefix C-a
unbind C-b
bind C-a send-prefix

# Reload config
bind r source-file ~/.tmux.conf

# Splits (keep current path)
bind | split-window -h -c "#{pane_current_path}"
bind - split-window -v -c "#{pane_current_path}"

# Navigate panes
bind Left select-pane -L
bind Down select-pane -D
bind Up select-pane -U
bind Right select-pane -R

# Copy mode + system clipboard
setw -g mode-keys vi
bind -T copy-mode-vi v send -X begin-selection
bind -T copy-mode-vi y send -X copy-pipe-and-cancel "pbcopy"

# Start index at 1 (easier to reach on keyboard)
set -g base-index 1
setw -g pane-base-index 1

# Colors
set -g default-terminal "tmux-256color"
set -ga terminal-overrides ",xterm-256color:Tc"

# No escape delay
set -sg escape-time 0

# Scrollback
set -g history-limit 50000

# Status bar
set -g status-style 'bg=default fg=white'
```

**Key bindings:**

| Key | Action |
|-----|--------|
| `Ctrl+a \|` | Split vertically |
| `Ctrl+a -` | Split horizontally |
| `Ctrl+a arrows` | Navigate panes |
| `Ctrl+a [` | Enter copy mode |
| `v` / `y` | Select / copy (in copy mode) |
| `Ctrl+a d` | Detach session |
| `tmux attach` | Reattach |

**Scripting panes** (Claude can run this to set up a multi-agent workspace):

```bash
tmux new-session -d -s dev
tmux split-window -h
tmux split-window -v
tmux send-keys -t dev:1.1 "claude" Enter
tmux send-keys -t dev:1.2 "claude" Enter
tmux send-keys -t dev:1.3 "npm run dev" Enter
tmux attach -t dev
```

---

## 4. Shell (zsh)

### Packages

```bash
brew install zsh-syntax-highlighting zsh-autosuggestions fzf starship
```

### Starship Configuration

Create `~/.config/starship.toml`:

```toml
[character]
success_symbol = "[❯](green)"
error_symbol = "[❯](red)"

[directory]
truncation_length = 3
truncate_to_repo = true

[cmd_duration]
min_time = 3000

[username]
disabled = true

[hostname]
disabled = true
```

### `~/.zshrc`

```bash
# Random dark background per Kitty split
[[ -n "$KITTY_WINDOW_ID" ]] && printf '\e]11;#%02x%02x%02x\e\\' $((RANDOM % 50 + 15)) $((RANDOM % 50 + 15)) $((RANDOM % 50 + 15))

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source <(fzf --zsh)
eval "$(starship init zsh)"

# Bun
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
```

---

## 5. Development Tools

### Git

```bash
git config --global user.name "Your Name"
git config --global user.email "your@email.com"
```

### GitHub CLI

```bash
brew install gh
gh auth login
```

### PHP + WP-CLI

```bash
brew install wp-cli
```

PHP installs automatically as a dependency.

### Composer

```bash
brew install composer
```

### Node.js

```bash
brew install node
```

### Bun

```bash
curl -fsSL https://bun.sh/install | bash
```

### jq

```bash
brew install jq
```

### Docker Desktop

Includes CLI tools (`docker`, `docker compose`).

```bash
brew install --cask docker-desktop
```

---

## 6. Editors

### VS Code

```bash
brew install --cask visual-studio-code
```

CLI: `code`

### Google Antigravity

```bash
brew install --cask antigravity
```

CLI: `agy`

### Obsidian

```bash
brew install --cask obsidian
```

---

## 7. WordPress

### LocalWP

```bash
brew install --cask local
```

### Beekeeper Studio

```bash
brew install --cask beekeeper-studio
```

---

## 8. Browsers

```bash
brew install --cask google-chrome firefox
```

Set Chrome as default: System Settings → Desktop & Dock → Default web browser.

---

## 9. Productivity

### Raycast

```bash
brew install --cask raycast
```

Replace Spotlight: System Settings → Keyboard → Keyboard Shortcuts → Spotlight → uncheck Cmd+Space, then set Raycast hotkey to Cmd+Space.

Import settings: double-click `raycast-settings.rayconfig` in this repo.

**Window management shortcuts** (Raycast Settings → Extensions → Window Management):

| Shortcut | Action |
|----------|--------|
| `Ctrl + Option + ←` | Left Half |
| `Ctrl + Option + →` | Right Half |
| `Ctrl + Option + 1` | Top Left Quarter |
| `Ctrl + Option + 2` | Top Right Quarter |
| `Ctrl + Option + 3` | Bottom Left Quarter |
| `Ctrl + Option + 4` | Bottom Right Quarter |

**Extensions:** Brew (search/install Homebrew packages from Raycast).

---

## 10. Window Switcher

### AltTab

Windows-style Alt+Tab that switches individual windows instead of apps.

```bash
brew install --cask alt-tab
```

Grant Accessibility permissions on first launch: System Settings → Privacy & Security → Accessibility.

---

## 11. Communication

```bash
brew install --cask slack discord telegram google-chat whatsapp
```

Google Chat requires Rosetta 2 on Apple Silicon.

---

## 12. File Sync

```bash
brew install --cask google-drive
```

---

## 13. VPN

```bash
brew install --cask protonvpn
```

---

## 14. Utilities

```bash
brew install btop
brew install --cask imageoptim hiddenbar stats
```

**Stats clock format:** `EEE HH:mm dd-MM` → `Tue 17:37 31-12`

---

## 15. Media

```bash
brew install --cask spotify vlc qbittorrent
```

---

## 16. SSH Keys

Migrating from another machine — copy `~/.ssh/` and `~/.gitconfig`, then fix permissions:

```bash
chmod 700 ~/.ssh
chmod 600 ~/.ssh/id_*
chmod 644 ~/.ssh/*.pub
```

---

## 17. macOS Settings

### Finder

```bash
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder NewWindowTarget -string "PfHm"
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
killall Finder
```

Toggle hidden files: `Cmd + Shift + .`

### Dock

```bash
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock tilesize -int 33
defaults write com.apple.dock show-recents -bool false
killall Dock
```

### Keyboard

```bash
defaults write NSGlobalDomain KeyRepeat -int 5
defaults write NSGlobalDomain InitialKeyRepeat -int 25
```

Requires logout/restart to take effect.

### Trackpad

```bash
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
```

### Appearance

```bash
defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"
```

### Hot Corners

```bash
# Bottom-right = Quick Note
defaults write com.apple.dock wvous-br-corner -int 14
killall Dock
```

---

## Quick Install

```bash
brew install zsh-syntax-highlighting zsh-autosuggestions fzf starship gh wp-cli composer node jq btop tmux

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
  alt-tab \
  obsidian

# Run separately (require password prompt):
brew install --cask docker-desktop google-drive
```

---

## Troubleshooting

### External Keyboard Issues

**Swapped Command/Option keys:** Fix in System Settings → Keyboard → Keyboard Shortcuts → Modifier Keys. Select your external keyboard and swap Option ↔ Command.

**Modifier + arrow key combos not working:** Some keyboards have key matrix ghosting where certain multi-key combinations can't register simultaneously. This is a hardware limitation — use different shortcuts.

**Per-device scroll direction:** macOS now supports separate Natural Scrolling toggles for Mouse and Trackpad in System Settings.

**Diagnosing key issues:** Karabiner-Elements (`brew install --cask karabiner-elements`) includes EventViewer to inspect exact keycodes.
