# macOS Setup

Reference for my Mac configuration. Full setup guide in `SETUP-GUIDE.md`. One-liner description of each app in `APPS.md`.

## Software Stack

| Category | Tool |
|----------|------|
| Package manager | Homebrew |
| Terminal | Kitty + Fira Code + tmux |
| Shell | zsh + syntax-highlighting + autosuggestions + fzf + zoxide + Powerlevel10k + bash 5 |
| Editors | VS Code (primary), Google Antigravity (rarely) |
| Notes | Obsidian |
| Launcher | Raycast (Cmd+Space) |
| Browsers | Chrome (default), Firefox |
| AI CLIs | Claude Code, Codex, Gemini CLI, rtk, uipro, defuddle |
| WordPress | LocalWP, WP-CLI, Composer, Subversion, Poedit |
| JavaScript | Bun (default), Node.js + node@22/@24 pins, pnpm |
| Other languages | Go, PHP |
| Game dev | Godot |
| Database | Beekeeper Studio |
| Containers | Docker Desktop |
| Communication | Slack, Discord, Telegram, Signal, Google Chat, WhatsApp, Microsoft Teams |
| File sync | Google Drive |
| Media | Spotify, VLC, qBittorrent |
| Networking | ProtonVPN, Tailscale, cloudflared |
| Design & Office | GIMP, Inkscape, LibreOffice |
| FTP | FileZilla (manual install — no cask) |
| Cloud CLI | gcloud-cli |
| Utilities | btop, jq, ripgrep, duti, ffmpeg, sox, poppler, woff2, ImageOptim, HiddenBar, Stats, Karabiner-Elements, Mos, Numi, Shottr |

## Scope

This repo provisions a **work machine** — the thing to point at when a new Mac arrives. Out of scope: entertainment apps (Steam, GeForce NOW, Synthesia, Playground Sessions) and anything project-specific. Per-project tooling belongs in the project (e.g. a Node major pin goes in that repo's `.nvmrc`, which the `chpwd` hook in `configs/.zshrc` reads generically).

## Preferences

- No "Co-Authored-By: Claude" in git commits
- Homebrew for all installs, except where no cask exists (FileZilla) or the tool ships as a node/bun global (AI CLIs, pnpm)
- No subscriptions (free or one-time purchase only)
- No Apple lock-in (no iCloud, Apple Notes, etc.)
- Google Drive instead of iCloud
- Dark mode, dock always visible (no auto-hide), tap to click
- Finder: list view, home folder default, search current folder


