# macOS Setup Guide

macOS setup for productivity, terminal workflows, and web development — no iCloud, no Apple ecosystem lock-in.

> On a fresh machine: `git clone` this repo, run `./install.sh`, and follow the manual steps at the end. Config files live in `configs/`.

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

Config: [`configs/kitty.conf`](configs/kitty.conf) → `~/.config/kitty/kitty.conf`

Highlights: Fira Code with ligatures, semi-transparent background (0.80 opacity), powerline tabs, beam cursor, no bell.

---

## 3. Terminal Multiplexer

### tmux

Three reasons this is in the stack: (1) sessions persist — accidental `Ctrl+C` doesn't kill a running Claude Code session, reattach with `tmux attach`; (2) keyboard-driven copy without touching the mouse; (3) fully scriptable — Claude can spawn and orchestrate multiple panes programmatically.

```bash
brew install tmux
```

Config: [`configs/.tmux.conf`](configs/.tmux.conf) → `~/.tmux.conf`

Highlights: `Ctrl+a` prefix, vi copy mode with pbcopy, mouse support, 50k scrollback.

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
brew install zsh-syntax-highlighting zsh-autosuggestions fzf powerlevel10k zoxide
```

`zoxide` provides smarter `cd` — `z <partial-name>` jumps to any directory you've visited before, ranked by frecency.

### Powerlevel10k Configuration

Config: [`configs/.p10k.zsh`](configs/.p10k.zsh) → `~/.p10k.zsh`

Sourced from `~/.zshrc` via `source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme`. Run `p10k configure` to regenerate.

### `~/.zshrc`

Config: [`configs/.zshrc`](configs/.zshrc) → `~/.zshrc`

Highlights: random dark background per Kitty split, `claudio` function (Claude Code launcher with tmux integration), syntax highlighting, autosuggestions, fzf, zoxide, Powerlevel10k, Bun.

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

## 10. Communication

```bash
brew install --cask slack discord telegram google-chat whatsapp
```

Google Chat requires Rosetta 2 on Apple Silicon.

---

## 11. File Sync

```bash
brew install --cask google-drive
```

---

## 12. VPN

```bash
brew install --cask protonvpn
```

---

## 13. Utilities

```bash
brew install btop cloudflared
brew install --cask imageoptim hiddenbar stats karabiner-elements mos numi shottr
```

**Stats clock format:** `EEE HH:mm dd-MM` → `Tue 17:37 31-12`

**Karabiner-Elements:** Useful for remapping keys and diagnosing key issues via EventViewer.

**Mos:** Smooth scrolling for external mice. Grant Accessibility permissions on first launch.

**Numi:** Notepad calculator — type `120 USD in EUR + 15%` and get a result. Cmd+Shift+N to summon.

**Shottr:** Fast screenshot tool with annotations and OCR. Replaces macOS native shortcuts when remapped in System Settings → Keyboard → Shortcuts → Screenshots.

---

## 14. Media

```bash
brew install --cask spotify vlc qbittorrent
```

---

## 15. Design & Office

### GIMP

```bash
brew install --cask gimp
```

### Inkscape

```bash
brew install --cask inkscape
```

### LibreOffice

```bash
brew install --cask libreoffice
```

---

## 16. FTP

### FileZilla

```bash
brew install --cask filezilla
```

---

## 17. Cloud CLI

### Google Cloud SDK

```bash
brew install --cask gcloud-cli
```

---

## 18. SSH Keys

Migrating from another machine — copy `~/.ssh/` and `~/.gitconfig`, then fix permissions:

```bash
chmod 700 ~/.ssh
chmod 600 ~/.ssh/id_*
chmod 644 ~/.ssh/*.pub
```

---

## 19. macOS Settings

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
./install.sh
```

This installs all packages, copies config files, and applies macOS defaults. See [`install.sh`](install.sh) for details.

---

## Troubleshooting

### External Keyboard Issues

**Swapped Command/Option keys:** Fix in System Settings → Keyboard → Keyboard Shortcuts → Modifier Keys. Select your external keyboard and swap Option ↔ Command.

**Modifier + arrow key combos not working:** Some keyboards have key matrix ghosting where certain multi-key combinations can't register simultaneously. This is a hardware limitation — use different shortcuts.

**Per-device scroll direction:** macOS now supports separate Natural Scrolling toggles for Mouse and Trackpad in System Settings.

**Diagnosing key issues:** Karabiner-Elements includes EventViewer to inspect exact keycodes (installed in § 13).
