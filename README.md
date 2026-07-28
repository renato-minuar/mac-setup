# macOS Setup

My macOS configuration, reproducible from one script — terminal-first, no iCloud, no Apple ecosystem lock-in. Packages, dotfiles and system defaults all in one place, so a new machine is an afternoon rather than a week.

**Coming from Windows?** [WINDOWS-TO-MAC.md](WINDOWS-TO-MAC.md) translates the reflexes that stop working: Cmd vs Ctrl, the app-vs-window model, Finder, and why half these tools are here.

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
- **[raycast-settings.rayconfig](raycast-settings.rayconfig)** — Raycast settings export (double-click to import)
- **[notes/](notes/)** — Scratch notes for one-off setups (KVM wiring, etc.)

## Stack

| Category | Tools |
|----------|-------|
| Terminal | Kitty + Fira Code + tmux |
| Shell | zsh + Powerlevel10k + fzf + zoxide + syntax-highlighting + autosuggestions + bash 5 |
| Editors | VS Code, Google Antigravity, Obsidian |
| Launcher | Raycast |
| Browsers | Chrome, Firefox |
| AI CLIs | Claude Code, Codex, Gemini CLI, rtk, uipro, defuddle |
| WordPress | LocalWP, WP-CLI, Composer, Subversion, Poedit |
| JavaScript | Bun, Node.js (+ per-directory version pins), pnpm |
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

## Scope

A work machine. Entertainment apps stay out — install those by hand. Project-specific setup stays in the project: a repo that needs an older Node major says so in its own `.nvmrc`, and the `chpwd` hook in [`configs/.zshrc`](configs/.zshrc) picks it up.

Anything that shouldn't be committed — tokens, one-off experiments — goes in `~/.zshrc.local`, which the tracked `.zshrc` sources if it exists.
