# macOS Setup Guide

macOS setup for productivity, terminal workflows, and web development — no iCloud, no Apple Notes, no ecosystem lock-in.

## Prerequisites

- Fresh macOS install
- Admin access
- Internet connection

---

## 1. Package Manager

### Homebrew
The standard package manager for macOS. Install everything else through this.

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

After install, follow the instructions to add Homebrew to your PATH.

---

## 2. Terminal Setup

### Kitty Terminal
Fast, GPU-accelerated terminal with ligature support.

```bash
brew install --cask kitty
```

### Fira Code Font
Programming font with ligatures (`->` becomes →, `!=` becomes ≠).

```bash
brew install --cask font-fira-code
```

### Kitty Configuration
Create `~/.config/kitty/kitty.conf`:

```
# Font
font_family Fira Code
font_size 16.0

# Enable ligatures (-> becomes arrow, etc.)
disable_ligatures never

# Cursor
cursor_shape beam
cursor_blink_interval 0

# Scrollback
scrollback_lines 10000

# Window
window_padding_width 8
hide_window_decorations titlebar-only
confirm_os_window_close 0

# Tab bar
tab_bar_style powerline
tab_powerline_style slanted

# macOS specific
macos_option_as_alt yes
macos_quit_when_last_window_closed yes

# URL handling
url_style curly
open_url_with default

# Bell
enable_audio_bell no
visual_bell_duration 0

# Selection
copy_on_select clipboard

# Clipboard (allow read/write for image paste support)
clipboard_control write-clipboard write-primary read-clipboard read-primary
```

---

## 3. Shell Enhancements (zsh)

### Syntax Highlighting
Colors valid commands green, invalid red.

```bash
brew install zsh-syntax-highlighting
```

### Autosuggestions
Ghost text suggestions from command history.

```bash
brew install zsh-autosuggestions
```

### fzf (Fuzzy Finder)
Fuzzy search for files and command history.

```bash
brew install fzf
```

### Starship Prompt
Minimal, fast prompt that shows git branch, directory, and more.

```bash
brew install starship
```

**Optional config** — create `~/.config/starship.toml`:

```toml
# Simpler prompt character
[character]
success_symbol = "[❯](green)"
error_symbol = "[❯](red)"

# Shorter directory path (show 3 levels max)
[directory]
truncation_length = 3
truncate_to_repo = true

# Show command duration only if > 3 seconds
[cmd_duration]
min_time = 3000

# Hide username (you know who you are)
[username]
disabled = true

# Hide hostname (you know where you are)
[hostname]
disabled = true
```

### Shell Configuration
Add to `~/.zshrc`:

```bash
# Syntax highlighting (valid commands = green, invalid = red)
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Autosuggestions (ghost text from history)
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# fzf keybindings and completion (Ctrl+R for history, Ctrl+T for files)
source <(fzf --zsh)

# Starship prompt
eval "$(starship init zsh)"

# Bun (if installed)
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
```

**fzf shortcuts:**
- `Ctrl+R` — fuzzy search command history
- `Ctrl+T` — fuzzy find files

---

## 4. Development Tools

### Git (comes with macOS, but configure it)

```bash
git config --global user.name "Your Name"
git config --global user.email "your@email.com"
```

### GitHub CLI
Handles Git authentication seamlessly.

```bash
brew install gh
gh auth login
```
Choose: GitHub.com → HTTPS → Login with browser

### PHP + WP-CLI
PHP installs automatically as a WP-CLI dependency.

```bash
brew install wp-cli
```

### Composer
PHP package manager for plugin/theme dependencies.

```bash
brew install composer
```

### Node.js
Required for most build tools and npm packages.

```bash
brew install node
```

### Bun
Fast JavaScript runtime and package manager (alternative to Node/npm).

```bash
curl -fsSL https://bun.sh/install | bash
```

### jq
JSON processor for CLI (useful for API work).

```bash
brew install jq
```

### Docker
Container platform for development environments.

```bash
brew install --cask docker
```
(Requires password prompt)

### Ollama
Run LLMs locally.

```bash
brew install ollama
```

---

## 5. Editors

### VS Code

```bash
brew install --cask visual-studio-code
```

CLI command: `code`

### Google Antigravity
AI coding IDE.

```bash
brew install --cask antigravity
```

CLI command: `agy`

### Obsidian
Markdown-based note-taking and knowledge base.

```bash
brew install --cask obsidian
```

---

## 6. WordPress Development

### LocalWP
Local WordPress development environment.

```bash
brew install --cask local
```

### Database Client (Beekeeper Studio)
Connect to LocalWP databases or remote servers.

```bash
brew install --cask beekeeper-studio
```

---

## 7. Browsers

```bash
brew install --cask google-chrome firefox
```

**Set Chrome as default:** Open Chrome → accept prompt, or System Settings → Desktop & Dock → Default web browser

---

## 8. Productivity

### Raycast
App launcher, window management, clipboard history, calculator.

```bash
brew install --cask raycast
```

**Setup:**
1. Open Raycast
2. To replace Spotlight: System Settings → Keyboard → Keyboard Shortcuts → Spotlight → uncheck Cmd+Space
3. Set Raycast hotkey to Cmd+Space

**Window management:** Type "left half", "right half", "maximize", etc.

**Import settings:** Double-click the `.rayconfig` file in this repo to restore all settings and shortcuts.

**Recommended extensions (install from Raycast Store):**
- **Brew** — search and install Homebrew packages from Raycast

**Custom shortcuts (set in Raycast Settings → Extensions → Window Management):**

| Shortcut | Action |
|----------|--------|
| `Ctrl + Option + ←` | Left Half |
| `Ctrl + Option + →` | Right Half |
| `Ctrl + Option + 1` | Top Left Quarter |
| `Ctrl + Option + 2` | Top Right Quarter |
| `Ctrl + Option + 3` | Bottom Left Quarter |
| `Ctrl + Option + 4` | Bottom Right Quarter |

---

## 9. Window Switcher

### AltTab
Windows/Ubuntu-style Alt+Tab that switches between individual windows instead of apps.

```bash
brew install --cask alt-tab
```

Grant Accessibility permissions on first launch: System Settings → Privacy & Security → Accessibility.

---

## 10. Communication

```bash
brew install --cask slack discord telegram
```

### Google Chat

```bash
brew install --cask google-chat
```
(Needs Rosetta 2 on Apple Silicon)

---

## 11. File Transfer

### Cyberduck
SFTP/FTP client.

```bash
brew install --cask cyberduck
```

### Google Drive
File sync (replaces iCloud).

```bash
brew install --cask google-drive
```
(Requires password prompt)

---

## 12. Utilities

### btop
Better process monitor.

```bash
brew install btop
```

### ImageOptim
Compress images for web.

```bash
brew install --cask imageoptim
```

### HiddenBar
Hide menu bar icons you don't need to see constantly.

```bash
brew install --cask hiddenbar
```

After install, drag menu bar icons left of the HiddenBar divider to hide them.

### Stats
System monitor in menu bar (CPU, RAM, disk, network, battery). Can replace the system clock.

```bash
brew install --cask stats
```

**Custom clock format:** In Stats clock settings, use `EEE HH:mm dd-MM` for `Tue 17:37 31-12`

---

## 13. Media

```bash
brew install --cask spotify vlc
```

---

## 14. SSH Keys

If migrating from another machine, copy:
- `~/.ssh/` (keys, config, known_hosts)
- `~/.gitconfig`

Set correct permissions:
```bash
chmod 700 ~/.ssh
chmod 600 ~/.ssh/id_*
chmod 644 ~/.ssh/*.pub
```

---

## 15. macOS Settings

### Finder

```bash
# Show hidden files (dotfiles)
defaults write com.apple.finder AppleShowAllFiles -bool true

# Show all file extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Show path bar (breadcrumb at bottom)
defaults write com.apple.finder ShowPathbar -bool true

# Show status bar (item count, disk space)
defaults write com.apple.finder ShowStatusBar -bool true

# New Finder windows open to home folder (not Recents)
# PfHm = Home, PfDe = Desktop, PfDo = Documents, PfLo = Other (set NewWindowTargetPath)
defaults write com.apple.finder NewWindowTarget -string "PfHm"

# Search current folder by default (not entire Mac)
# SCcf = Current Folder, SCsp = Previous Scope, SCev = Entire Mac
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Default view as List
# Nlsv = List, icnv = Icon, clmv = Column, glyv = Gallery
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Apply Finder changes
killall Finder
```

Keyboard shortcut to toggle hidden files: `Cmd + Shift + .`

### Dock

```bash
# Auto-hide dock
defaults write com.apple.dock autohide -bool true

# Set dock size (33 = small)
defaults write com.apple.dock tilesize -int 33

# Don't show recent apps in dock
defaults write com.apple.dock show-recents -bool false

# Apply dock changes
killall Dock
```

### Keyboard

```bash
# Faster key repeat (default is 6, lower = faster)
defaults write NSGlobalDomain KeyRepeat -int 5

# Shorter delay before key repeat (default is 68, lower = faster)
defaults write NSGlobalDomain InitialKeyRepeat -int 25
```

Requires logout/restart to take effect.

### Trackpad

```bash
# Enable tap to click
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
```

### Appearance

```bash
# Dark mode
defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"
```

### Hot Corners

Set via System Settings → Desktop & Dock → Hot Corners.

Your setup: Bottom-right = Quick Note (value 14)

```bash
# Bottom-right corner = Quick Note (14)
defaults write com.apple.dock wvous-br-corner -int 14
killall Dock
```

---

## Quick Install Script

Run everything at once (apps that need sudo will fail silently):

```bash
# Core tools
brew install zsh-syntax-highlighting zsh-autosuggestions fzf starship gh wp-cli composer node jq btop ollama

# Apps
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
  cyberduck \
  slack \
  discord \
  telegram \
  spotify \
  imageoptim \
  hiddenbar \
  stats \
  vlc \
  google-chat \
  alt-tab \
  obsidian

# These need password prompts - run separately:
# brew install --cask docker google-drive
```

---

## Notes

- **No subscriptions:** All software here is free or one-time purchase
- **No Apple lock-in:** Avoided iCloud, Apple Notes, etc.
- **Homebrew for everything:** Makes reinstalls and updates easy (`brew upgrade`)
- **LocalWP uses its own PHP:** The system PHP from Homebrew is separate

---

## Troubleshooting

### External Keyboard Issues

Non-Apple keyboards (especially wireless ones with USB receivers) may have quirks:

**Swapped Command/Option keys:** Common on Windows-layout keyboards. Fix in System Settings → Keyboard → Keyboard Shortcuts → Modifier Keys. Select your external keyboard and swap Option ↔ Command.

**Modifier + arrow key combos not working:** Some keyboards have "ghosting" limitations where certain multi-key combinations can't be detected simultaneously due to how the key matrix is wired. For example, Ctrl+Option+Command+Left might not register while Ctrl+Option+Command+Right works fine. This is a hardware limitation — the fix is to use different shortcuts.

**Different scroll direction for mouse vs trackpad:** macOS doesn't separate this natively. Install `brew install --cask scroll-reverser` or `brew install --cask linearmouse` to set per-device scroll direction.

**Diagnosing key issues:** Install Karabiner-Elements (`brew install --cask karabiner-elements`) temporarily and use its EventViewer app to see exactly what keycodes your keyboard sends.
