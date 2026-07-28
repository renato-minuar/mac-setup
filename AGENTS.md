# macOS Setup

Reproducible macOS provisioning. Full guide in `SETUP-GUIDE.md`, one-liner per app in `APPS.md`, switcher notes in `WINDOWS-TO-MAC.md`.

## Scope

This repo provisions a **generic work machine** — the thing to point at when any new Mac arrives, including someone else's. Keep it that way:

- No personal identifiers, project names, or one-person workflows in tracked core files. `configs/.zshrc` sources `~/.zshrc.local` for that; the owner's copy lives in `personal/`.
- No entertainment apps.
- No project-specific setup. A project that needs an older Node major declares it in its own `.nvmrc`; the `chpwd` hook in `configs/.zshrc` reads that generically.
- Use `$HOME`/`$BREW_PREFIX`, never `/Users/<name>` or a hardcoded `/opt/homebrew`.
- Verify a package name resolves (`brew info --cask <name>`) before adding it — `install.sh` runs under `set -e`, so one dead cask aborts the whole run before any dotfile gets linked.

## Software Stack

| Category | Tool |
|----------|------|
| Package manager | Homebrew |
| Terminal | Kitty + Fira Code + tmux |
| Shell | zsh + syntax-highlighting + autosuggestions + fzf + zoxide + Powerlevel10k + bash 5 |
| Editors | VS Code, Obsidian |
| Launcher | Raycast (Cmd+Space) |
| Browsers | Chrome (default), Firefox |
| WordPress | LocalWP, WP-CLI, Composer, Subversion, Poedit |
| JavaScript | Bun (default), Node.js + per-directory pins, pnpm |
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
- Dotfiles are symlinked from `configs/`, not copied, so edits are version-controlled immediately.
- `install.sh`, `SETUP-GUIDE.md` and `APPS.md` must agree. Adding a tool means touching all three.
- Machine state is the source of truth for what belongs here; docs claiming something untrue is a bug.
