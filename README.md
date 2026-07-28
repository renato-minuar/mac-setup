# macOS Setup

A reproducible macOS setup for development — terminal-first, no iCloud, no Apple ecosystem lock-in. One script installs the packages, links the dotfiles and applies the system defaults.

Nothing here is personal: clone it, run it, and you have a working machine. **Coming from Windows?** Read [WINDOWS-TO-MAC.md](WINDOWS-TO-MAC.md) first — it translates the reflexes that stop working.

## Quick Start

```bash
git clone https://github.com/renato-minuar/mac-setup.git
cd mac-setup
./install.sh
```

Installs all packages, links config files, applies macOS defaults. Follow the manual steps printed at the end.

## What's Inside

- **[install.sh](install.sh)** — Automated setup script
- **[configs/](configs/)** — Dotfiles (zshrc, tmux, kitty, p10k), symlinked into `~` by the installer
- **[SETUP-GUIDE.md](SETUP-GUIDE.md)** — Detailed reference for each tool and setting
- **[APPS.md](APPS.md)** — One-liner description of every app and CLI tool installed
- **[WINDOWS-TO-MAC.md](WINDOWS-TO-MAC.md)** — Shortcut, Finder, and window-model translation for switchers
- **[personal/](personal/)** — The repo owner's extras, opt-in and separate. Delete it if you cloned this.

## Stack

| Category | Tools |
|----------|-------|
| Terminal | Kitty + Fira Code + tmux |
| Shell | zsh + Powerlevel10k + fzf + zoxide + syntax-highlighting + autosuggestions + bash 5 |
| Editors | VS Code, Obsidian |
| Launcher | Raycast |
| Browsers | Chrome, Firefox |
| WordPress | LocalWP, WP-CLI, Composer, Subversion, Poedit |
| JavaScript | Bun, Node.js (per-directory version pins), pnpm |
| Other languages | Go, PHP |
| Game dev | Godot |
| Containers | Docker Desktop |
| Database | Beekeeper Studio |
| File sync | Google Drive |
| Communication | Slack, Discord, Telegram, Signal, Google Chat, WhatsApp, Microsoft Teams |
| Design & Office | GIMP, Inkscape, LibreOffice |
| FTP | FileZilla (manual install) |
| Cloud CLI | gcloud-cli |
| Utilities | btop, jq, ripgrep, duti, ffmpeg, sox, poppler, woff2, Stats, HiddenBar, ImageOptim, Karabiner-Elements, Mos, Numi, Shottr |
| Networking | ProtonVPN, Tailscale, cloudflared |
| Media | Spotify, VLC, qBittorrent |

See [APPS.md](APPS.md) for a one-line description of each.

## Making it yours

- **Shell:** don't edit `configs/.zshrc` for machine-specific things. It sources `~/.zshrc.local` at the end — put private functions, extra `PATH` entries and tokens there.
- **Apps:** the cask list in `install.sh` is a starting point, not a prescription. Cut what you don't want.
- **Defaults:** every `defaults write` in `install.sh` is documented in [SETUP-GUIDE.md § 19](SETUP-GUIDE.md) so you can see what it changes before running it.
