# personal/

The owner's machine-specific extras. **Everything outside this directory is generic** — a fresh Mac gets a complete working setup from `../install.sh` alone.

**Cloned this repo?** Delete this directory. Nothing in the core setup references it beyond one optional `source` line.

## Contents

| File | What it is |
|------|------------|
| `install-personal.sh` | Installs the AI tooling and links the shell additions |
| `zshrc.local` | Symlinked to `~/.zshrc.local`, sourced by `configs/.zshrc` if present |
| `raycast-settings.rayconfig` | Raycast settings export — the owner's hotkeys and extensions |
| `notes/` | One-off notes about this specific desk (KVM wiring, etc.) |

## Why these are not in the core

- **AI CLIs** (Claude Code, Codex, Gemini CLI, rtk, uipro, defuddle) and the Antigravity IDE are one person's workflow, not a Mac baseline. Claude Code config lives in its own repo (`~/.claude`), not here.
- **`claudio`** is a Claude Code launcher wrapping tmux. Useless without Claude Code.
- **Raycast export** carries personal hotkeys and enabled extensions. Others should export their own.

## Usage

```bash
../install.sh            # generic Mac setup
./install-personal.sh    # then the extras
```

The hook in `configs/.zshrc` that picks this up:

```zsh
[[ -r ~/.zshrc.local ]] && source ~/.zshrc.local
```

Anything machine-specific — extra `PATH` entries, private functions, tokens — belongs in `~/.zshrc.local`, never in `configs/.zshrc`.
