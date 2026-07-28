# macOS Setup

macOS configuration for productivity, terminal workflows, and web development — without Apple's ecosystem lock-in.

Scope is a **work machine**: what to run when a new Mac arrives. Entertainment apps and project-specific tooling stay out.

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
- **[notes/](notes/)** — Scratch notes for one-off machine setups (e.g. KVM)
- **[raycast-settings.rayconfig](raycast-settings.rayconfig)** — Raycast settings export (double-click to import)

## Stack

| Category | Tools |
|----------|-------|
| Terminal | Kitty + Fira Code + tmux |
| Shell | zsh + Powerlevel10k + fzf + zoxide + syntax-highlighting + autosuggestions + bash 5 |
| Editors | VS Code (primary), Google Antigravity |
| Notes | Obsidian |
| Launcher | Raycast |
| Browsers | Chrome, Firefox |
| AI CLIs | Claude Code, Codex, Gemini CLI, rtk, uipro, defuddle |
| WordPress | LocalWP, WP-CLI, Composer, Subversion, Poedit |
| JavaScript | Bun, Node.js (+ node@22/@24 pins), pnpm |
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
