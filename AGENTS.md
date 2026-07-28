# macOS Setup

Reference for my Mac configuration, reproducible from `install.sh`. Full guide in `SETUP-GUIDE.md`, one-liner per app in `APPS.md`, switcher notes in `WINDOWS-TO-MAC.md`.

## Scope

Provisions a **work machine**. Two things stay out:

- **Entertainment apps** (Steam, GeForce NOW, Synthesia, Playground Sessions) — installed by hand, not tracked here.
- **Project-specific setup** — a project needing an older Node major declares it in its own `.nvmrc`; the `chpwd` hook in `configs/.zshrc` reads that generically. Never hardcode a project path in a config.

## Software Stack

| Category | Tool |
|----------|------|
| Package manager | Homebrew |
| Terminal | Kitty + Fira Code + tmux |
| Shell | zsh + syntax-highlighting + autosuggestions + fzf + zoxide + Powerlevel10k + bash 5 |
| Editors | VS Code (primary), Google Antigravity (rarely), Obsidian |
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

## Conventions

- Homebrew for everything installable that way. Exceptions get a manual step printed by `install.sh` (currently FileZilla) — never a silent gap.
- Verify a package name resolves (`brew info --cask <name>`) before adding it. `install.sh` runs under `set -e`, so one dead cask aborts the run before any dotfile gets linked.
- Use `$HOME` and `$BREW_PREFIX` in configs, never `/Users/<name>` or a bare `/opt/homebrew`.
- Dotfiles are symlinked from `configs/`, not copied, so edits are version-controlled immediately.
- `install.sh`, `SETUP-GUIDE.md` and `APPS.md` must agree. Adding a tool means touching all three.
- Machine state is the source of truth. A doc claiming something untrue is a bug.

## Preferences

- No "Co-Authored-By: Claude" in git commits
- No subscriptions (free or one-time purchase only)
- No Apple lock-in (no iCloud, Apple Notes, etc.)
- Google Drive instead of iCloud
- Dark mode, dock always visible (no auto-hide), tap to click
- Finder: list view, home folder default, search current folder



