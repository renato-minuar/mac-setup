# macOS Setup Guide

macOS setup for productivity, terminal workflows, and web development — no iCloud, no Apple ecosystem lock-in.

> On a fresh machine: `git clone` this repo, run `./install.sh`, and follow the manual steps at the end. Config files live in `configs/`. For a one-line description of each app, see [`APPS.md`](APPS.md).
>
> **Switching from Windows?** Read [`WINDOWS-TO-MAC.md`](WINDOWS-TO-MAC.md) first — it covers the muscle-memory differences that make a new Mac feel broken.

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

Three reasons this is in the stack: (1) sessions persist — closing the terminal or dropping an SSH connection doesn't kill what's running, reattach with `tmux attach`; (2) keyboard-driven copy without touching the mouse; (3) fully scriptable, so one command lays out a whole workspace.

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

**Scripting panes** — one command builds a three-pane workspace:

```bash
tmux new-session -d -s dev
tmux split-window -h
tmux split-window -v
tmux send-keys -t dev:1.1 "bun run dev" Enter
tmux send-keys -t dev:1.2 "bun test --watch" Enter
tmux send-keys -t dev:1.3 "btop" Enter
tmux attach -t dev
```

---

## 4. Shell (zsh)

### Packages

```bash
brew install zsh-syntax-highlighting zsh-autosuggestions fzf powerlevel10k zoxide bash
```

`zoxide` provides smarter `cd` — `z <partial-name>` jumps to any directory you've visited before, ranked by frecency.

`bash` is Bash 5.x. macOS still ships 3.2 (2007, GPLv2), so any script using associative arrays or `${var^^}` needs the Homebrew build.

### Powerlevel10k Configuration

Config: [`configs/.p10k.zsh`](configs/.p10k.zsh) → `~/.p10k.zsh`

Sourced from `~/.zshrc` via `source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme`. Run `p10k configure` to regenerate.

### `~/.zshrc`

Config: [`configs/.zshrc`](configs/.zshrc) → `~/.zshrc`

Highlights:

- Homebrew prefix resolved without shelling out to `brew`, so Intel and Apple Silicon both work
- Random dark background per Kitty split, so panes stay distinguishable
- syntax highlighting, autosuggestions, fzf, zoxide, Powerlevel10k
- Bun install prefix + completions
- `_node_pin_path` — `chpwd` hook that switches Node major per directory (see § 5)
- sources `~/.zshrc.local` at the end if present — machine-specific functions, extra `PATH` entries and anything private go there, never in the tracked file

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

### Subversion

```bash
brew install subversion
```

WordPress.org plugin and theme repos are SVN-backed — releasing to them needs `svn`.

### Composer

```bash
brew install composer
```

### Node.js and version pins

```bash
brew install node
```

Some projects can't run on the newest major, because a dependency ships prebuilt native binaries against an older ABI (`better-sqlite3` is the usual offender). Install the majors your projects actually pin:

```bash
brew install node@22   # keg-only — not linked into PATH
```

The `_node_pin_path` hook in [`configs/.zshrc`](configs/.zshrc) picks the major per directory on every `cd`:

1. nearest `.node-version` or `.nvmrc` walking up from `$PWD` — nothing to configure, the project already declares it
2. `~/.config/node-pins` — untracked `<path> <major>` lines, for repos carrying neither file

A match prepends that keg's `bin` to `PATH`; leaving the directory strips it. No match means the default `node`. The hook is a silent no-op when the keg isn't installed, so `node -v` disagreeing with a project's pin usually means the keg is simply missing.

```bash
# example ~/.config/node-pins
~/work/legacy-app   22
```

### Bun

```bash
curl -fsSL https://bun.sh/install | bash
```

Default JS runtime and package manager.

### pnpm

```bash
brew install pnpm
```

Only for projects whose lockfile demands it.

### Go

```bash
brew install go
```

Compiler, module manager, formatter and test runner in one binary — `go build`, `go test ./...`, `go fmt`.

### Godot

```bash
brew install --cask godot
```

Game engine. Ships its own script editor, so no toolchain to configure.

### jq

```bash
brew install jq
```

### ripgrep

```bash
brew install ripgrep
```

`rg` — respects `.gitignore` and is far faster than `grep -r`. Most editors and CLI tools shell out to it for search.

### Docker Desktop

Includes CLI tools (`docker`, `docker compose`).

```bash
brew install --cask docker-desktop
```

---

## 6. Editors

### VS Code

Primary editor.

```bash
brew install --cask visual-studio-code
```

CLI: `code`

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

### Poedit

Translation editor for `.po`/`.mo` files.

```bash
brew install --cask poedit
```

---

## 8. Browsers

```bash
brew install --cask google-chrome firefox
```

Set Chrome as default: System Settings → Desktop & Dock → Default web browser.

Google Docs/Sheets/Slides are installed as Chrome PWAs (Chrome menu → Cast, save, share → Install page as app), not native apps.

---

## 9. Productivity

### Raycast

```bash
brew install --cask raycast
```

Replace Spotlight: System Settings → Keyboard → Keyboard Shortcuts → Spotlight → uncheck Cmd+Space, then set Raycast hotkey to Cmd+Space.

Raycast exports its whole config to a `.rayconfig` file — worth doing once yours is set up, so the next machine is one double-click away.

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
brew install --cask slack discord telegram signal google-chat whatsapp microsoft-teams
```

Google Chat requires Rosetta 2 on Apple Silicon. Teams is only there for client meetings.

---

## 11. File Sync

```bash
brew install --cask google-drive
```

---

## 12. Networking & VPN

```bash
brew install --cask protonvpn tailscale-app
brew install cloudflared
```

**Tailscale:** mesh VPN and the access path to the VPS boxes, including Tailscale SSH. Cask was renamed from `tailscale` to `tailscale-app` (the `tailscale` formula is the CLI-only daemon).

**cloudflared:** Cloudflare Tunnel client for exposing a local port on a real hostname.

---

## 13. Utilities

```bash
brew install btop duti ffmpeg sox poppler woff2
brew install --cask imageoptim hiddenbar stats karabiner-elements mos numi shottr
```

**duti:** sets default apps per file type from the shell — `duti -x html` prints what currently owns `.html`.

**ffmpeg / sox:** video and audio conversion, trimming, normalizing.

**poppler:** `pdftotext`, `pdfimages`, `pdftoppm` for pulling text and images out of PDFs.

**woff2:** `woff2_compress font.ttf` for web fonts.

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

No longer packaged by Homebrew (the cask was dropped). Download from [filezilla-project.org](https://filezilla-project.org) and skip the bundled offers during install.

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

Always visible — no auto-hide.

```bash
defaults write com.apple.dock tilesize -int 33
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock autohide -bool false
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

This installs all packages, links config files, and applies macOS defaults. See [`install.sh`](install.sh) for details.

Not covered by the script: FileZilla (no cask any more) and the Google Docs/Sheets/Slides PWAs.

**Scope.** Everything above is generic — a working Mac for development, nothing tied to one person. Out on purpose: entertainment apps, and one person's AI tooling. The repo owner's extras live in [`personal/`](personal/) behind a separate script; delete that directory if you cloned this repo.

### Keeping your own machine-specific bits

Don't edit `configs/.zshrc` for anything that only makes sense on your machine. It ends with:

```zsh
[[ -r ~/.zshrc.local ]] && source ~/.zshrc.local
```

Put private functions, extra `PATH` entries and tokens in `~/.zshrc.local`. The tracked config stays clean and pulls keep working.

---

## Troubleshooting

### External Keyboard Issues

**Swapped Command/Option keys:** Fix in System Settings → Keyboard → Keyboard Shortcuts → Modifier Keys. Select your external keyboard and swap Option ↔ Command.

**Modifier + arrow key combos not working:** Some keyboards have key matrix ghosting where certain multi-key combinations can't register simultaneously. This is a hardware limitation — use different shortcuts.

**Per-device scroll direction:** macOS now supports separate Natural Scrolling toggles for Mouse and Trackpad in System Settings.

**Diagnosing key issues:** Karabiner-Elements includes EventViewer to inspect exact keycodes (installed in § 13).

### Node native module errors

`NODE_MODULE_VERSION` mismatch on `better-sqlite3` or similar means the wrong Node major is active. Check `node -v` against the project's `.nvmrc`/`.node-version`, then confirm the keg exists — the `chpwd` hook (§ 5) silently does nothing when `node@<major>` was never installed. `_node_pin_version` prints the major it resolved for the current directory.
