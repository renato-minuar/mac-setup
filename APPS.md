# Apps & Tools

One-liner reference for everything in [`install.sh`](install.sh). Install commands and config details live in [`SETUP-GUIDE.md`](SETUP-GUIDE.md).

## Package Manager

- **Homebrew** — macOS package manager for everything below.

## Terminal

- **Kitty** — GPU-accelerated terminal emulator with ligature support and split panes.
- **Fira Code** — Monospace font with programming ligatures (`!=`, `=>`, `->`).
- **tmux** — Terminal multiplexer. Sessions persist after disconnect, scriptable for multi-pane workflows.

## Shell

- **zsh** — Default macOS shell.
- **zsh-syntax-highlighting** — Colors valid commands green, invalid red, as you type.
- **zsh-autosuggestions** — Ghost-text suggestions from shell history.
- **fzf** — Fuzzy finder. `Ctrl+R` history search, `Ctrl+T` file search.
- **zoxide** — Smarter `cd` with frecency. `z foo` jumps to any visited directory matching "foo".
- **Powerlevel10k** — Fast, customizable zsh prompt with git status and command timing.
- **bash** — Bash 5.x. macOS ships 3.2 from 2007; scripts with `declare -A` or `${var^^}` need this.

## Development

- **Git** — Version control.
- **GitHub CLI (`gh`)** — GitHub from the terminal: PRs, issues, releases.
- **PHP + WP-CLI** — PHP runtime plus WordPress command-line tool.
- **Composer** — PHP dependency manager.
- **Subversion (`svn`)** — Needed for WordPress.org plugin/theme repos, which are SVN-backed.
- **Node.js** — JavaScript runtime (default keg, currently 26.x).
- **node@22 / node@24** — Keg-only pins for projects whose native modules break on the newest major. A `chpwd` hook in [`configs/.zshrc`](configs/.zshrc) switches per directory, reading `.node-version`/`.nvmrc`.
- **Bun** — Fast JavaScript runtime and package manager. Default for all JS work.
- **pnpm** — Alternative Node package manager, for projects whose lockfile demands it.
- **Go** — Go toolchain (`go`). Compiler, module manager, test runner in one binary.
- **Godot** — Open-source game engine.
- **jq** — Command-line JSON processor.
- **ripgrep (`rg`)** — Recursive regex search. Respects `.gitignore`, orders of magnitude faster than `grep -r`.
- **Docker Desktop** — Containers and Compose, with the `docker` CLI.

## AI CLIs

- **Claude Code (`claude`)** — Anthropic's agentic CLI. Launch via the `claudio` wrapper in [`configs/.zshrc`](configs/.zshrc).
- **Claude desktop** — Claude app for non-terminal chat.
- **Codex CLI (`codex`)** — OpenAI's coding CLI. Second-opinion reviewer via the `codex-partner` MCP server.
- **Gemini CLI (`gemini`)** — Google's coding CLI.
- **rtk** — Token-optimizing CLI proxy. Wraps `git`/build commands to cut LLM context cost; `rtk gain` reports savings.
- **uipro (`uipro-cli`)** — Installer for the UI/UX Pro Max skill (styles, palettes, font pairings). The skill itself lives in `~/.claude/skills`.
- **defuddle (`defuddle-cli`)** — Strips a web page to its article text (same extractor as Obsidian Web Clipper). Required by the `obsidian-skills` plugin; also cheap page reads for agents.

## Editors

- **VS Code** — Primary editor (`code` opens a file or folder from the shell).
- **Google Antigravity** — AI-native IDE. Installed, barely used. Only the separate Antigravity IDE build still ships a CLI (`agy-ide`); the plain build's `agy` shim is gone as of 2.4.2.
- **Obsidian** — Markdown-based note-taking with local files and bidirectional links.

## WordPress

- **LocalWP** — Local WordPress development environments with one-click sites.
- **Beekeeper Studio** — Cross-platform GUI for MySQL, PostgreSQL, SQLite, and others.

## Browsers

- **Google Chrome** — Default browser.
- **Firefox** — Backup browser, separate session jar.

## Productivity

- **Raycast** — Spotlight replacement: launcher, clipboard history, window management, extensions.

## Communication

- **Slack** — Team chat.
- **Discord** — Community chat and voice.
- **Telegram** — Encrypted messenger.
- **Signal** — End-to-end encrypted messenger.
- **Google Chat** — Workspace messaging (requires Rosetta on Apple Silicon).
- **WhatsApp** — Mobile-style messenger, desktop client.
- **Microsoft Teams** — For clients who insist on it.

## File Sync

- **Google Drive** — Cloud sync, replaces iCloud.

## Networking & VPN

- **ProtonVPN** — Privacy-focused VPN with a free tier.
- **Tailscale** — WireGuard mesh VPN. Reaches your own machines and servers by name from anywhere, with SSH built in.
- **cloudflared** — Cloudflare Tunnel client for exposing local services.

## Utilities

- **btop** — Resource monitor (CPU, RAM, network, disks) with a TUI.
- **duti** — Sets default apps per file type / URL scheme from the command line.
- **ffmpeg** — Converts and transcodes any audio/video.
- **sox** — Audio Swiss army knife: convert, trim, normalize, effects.
- **poppler** — PDF toolkit (`pdftotext`, `pdfimages`, `pdftoppm`).
- **woff2** — Converts TTF/OTF to WOFF2 for web fonts (`woff2_compress`).
- **ImageOptim** — Lossless image compression for PNG/JPEG/GIF.
- **HiddenBar** — Hides menu bar icons behind a toggle to clean up the bar.
- **Stats** — Menu bar system monitor with CPU, RAM, network, battery, and clock.
- **Karabiner-Elements** — Key remapper and EventViewer for diagnosing key issues.
- **Mos** — Smooth scrolling for external mice (macOS handles trackpads natively).
- **Numi** — Notepad calculator. Type `120 USD in EUR + 15%`, get a result.
- **Shottr** — Fast screenshot tool with annotations and OCR.

## Media

- **Spotify** — Music streaming.
- **VLC** — Plays anything.
- **qBittorrent** — Torrent client, no ads.

## Design & Office

- **GIMP** — Raster image editor (Photoshop-equivalent).
- **Inkscape** — Vector graphics editor (Illustrator-equivalent).
- **LibreOffice** — Office suite (Word/Excel/PowerPoint-equivalent).
- **Poedit** — Gettext `.po`/`.mo` translation editor for WordPress themes and plugins.

## FTP

- **FileZilla** — FTP/SFTP client. Dropped from homebrew-cask; download from [filezilla-project.org](https://filezilla-project.org).

## Cloud CLI

- **Google Cloud SDK (`gcloud`)** — Google Cloud command-line interface.

## Out of scope

Deliberately absent:

- **Entertainment** (Steam, GeForce NOW, Synthesia, and the like) — this provisions a work machine, install those by hand.
- **Project-specific setup** — a Node version pin belongs in that project's `.nvmrc`, which the shell hook reads generically.
