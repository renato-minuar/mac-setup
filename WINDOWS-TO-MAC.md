# Windows → macOS

The parts nobody tells you. A new Mac doesn't feel worse than Windows, it feels *wrong* — because a dozen reflexes now do something else. This is the translation layer.

Read this before running [`install.sh`](install.sh); several tools in the stack exist purely to fix things Windows already did well.

---

## Modifier keys

The physical key next to the spacebar is **Command (⌘)**, and it takes over almost every job `Ctrl` had.

| Windows | macOS | Notes |
|---------|-------|-------|
| `Ctrl+C` / `V` / `X` | `Cmd+C` / `V` / `X` | Same idea, different key |
| `Ctrl+Z` / `Ctrl+Y` | `Cmd+Z` / `Cmd+Shift+Z` | No separate redo key |
| `Ctrl+A` | `Cmd+A` | |
| `Ctrl+F` | `Cmd+F` | |
| `Ctrl+S` | `Cmd+S` | |
| `Ctrl+W` | `Cmd+W` | Closes window, **not** the app |
| `Alt+F4` | `Cmd+Q` | Actually quits the app |
| `Ctrl+Alt+Del` | `Cmd+Option+Esc` | Force-quit dialog |
| `Alt+Tab` | `Cmd+Tab` | Switches **apps**, not windows |
| — | `Cmd+\`` | Cycles windows *within* the current app |
| `Win` key | `Cmd+Space` | Search — Spotlight, or Raycast once installed |
| `PrtScn` | `Cmd+Shift+4` | Region shot; `Cmd+Shift+3` full screen |
| `Home` / `End` | `Cmd+←` / `Cmd+→` | Line start/end |
| `Ctrl+Home` / `Ctrl+End` | `Cmd+↑` / `Cmd+↓` | Document start/end |
| `Del` (forward delete) | `Fn+Delete` | The `Delete` key backspaces |
| `Ctrl+←` / `→` | `Option+←` / `→` | Move by word |
| Emoji picker (`Win+.`) | `Ctrl+Cmd+Space` | |

**In the terminal, `Ctrl` stays `Ctrl`.** `Ctrl+C` interrupts, `Ctrl+R` searches history. Copy in the terminal is `Cmd+C`. This split trips everyone up for about a week.

**Using a PC keyboard?** Command and Alt are usually swapped. Fix per-device: System Settings → Keyboard → Keyboard Shortcuts → Modifier Keys, pick the keyboard, swap Option ↔ Command. Karabiner-Elements (in the stack) handles anything deeper.

---

## The window model

macOS separates **apps** from **windows**, and this is the single biggest mental shift.

- The red ✕ closes a *window*. The app keeps running — a dot under its Dock icon means it's alive. `Cmd+Q` quits.
- Closing every window doesn't quit the app. The menu bar at the top belongs to whichever app has focus, and it changes as you switch.
- One app can own many windows. `Cmd+Tab` gets you between apps; `Cmd+\`` between that app's windows.
- **There is no built-in `Win+←` snapping** worth using. That's why Raycast is in the stack — it gives you `Ctrl+Option+←/→` for halves and quarters. Set it up first, before the missing snap drives you mad.
- The green button fullscreens into its own Space rather than maximizing. Hold `Option` and click it to actually zoom the window instead.
- Mission Control (`F3` or three-finger swipe up) is the closest thing to Task View.

---

## Finder vs Explorer

| Explorer | Finder |
|----------|--------|
| `C:\Users\you` | `/Users/you`, written `~` |
| Drive letters | Everything under `/`; disks appear in `/Volumes` |
| Backslash paths | Forward slashes |
| `Ctrl+X` then paste | `Cmd+C` then **`Cmd+Option+V`** to move |
| `F2` rename | `Return` renames; `Cmd+O` opens |
| `Enter` opens | `Return` *renames* — this one bites daily |
| Address bar | `Cmd+Shift+G` for "go to path" |
| Show hidden files toggle | `Cmd+Shift+.` |
| Delete | `Cmd+Delete` |
| Task Manager | Activity Monitor, or `btop` in a terminal |

Two Finder defaults worth changing immediately (`install.sh` does both): open new windows in your home folder instead of Recents, and search the current folder instead of the whole Mac.

The filesystem is **case-insensitive but case-preserving**. `README.md` and `readme.md` are the same file, and Git will happily let you commit a rename that no one else can check out cleanly. Worth knowing before it costs you an afternoon.

---

## Installing software

Forget `.exe` installers and "next, next, finish". Homebrew is `winget`/`choco`, and it's how everything in this repo arrives:

```bash
brew install ripgrep          # CLI tools
brew install --cask firefox   # GUI apps
brew upgrade                  # update everything
brew uninstall ripgrep
```

For apps that do come as a download: a `.dmg` mounts like a virtual disc, you drag the app into `/Applications`, then eject the disc. The `.dmg` itself is not the app — leaving it mounted forever is the classic beginner move.

Unsigned apps get blocked on first launch ("cannot be opened because the developer cannot be verified"). Right-click → Open, then confirm. Gatekeeper, not a virus warning. You do not need an antivirus.

---

## Terminal, not WSL

Windows makes you install WSL to get a real Unix shell. macOS *is* Unix — the shell is native, and Docker, git, ssh, make and the rest run directly. Nothing to enable.

The default shell is `zsh` (not bash), configured in `~/.zshrc`. There is no registry: environment variables and `PATH` are shell config, exported from that file.

The system `bash` is version 3.2 from 2007 for licensing reasons, which is why this repo installs a modern one. `#!/usr/bin/env bash` scripts using associative arrays fail otherwise.

Watch line endings: Windows tooling writes CRLF, and a `.sh` file with CRLF fails with a baffling `bad interpreter` error. Set `git config --global core.autocrlf input`.

---

## Trackpad and mouse

The trackpad is genuinely better than any Windows one — learn the gestures instead of fighting them: two-finger scroll, pinch zoom, three-finger swipe between Spaces, four-finger pinch for Launchpad.

Two settings that annoy every switcher:

- **Tap to click** is off by default. Turn it on (`install.sh` does).
- **Scroll direction.** macOS "natural" scrolling is inverted from Windows. Per-device toggles for Mouse and Trackpad live in System Settings — the trackpad feels right inverted, an external mouse usually doesn't.
- External mouse scrolling is *chunky* because macOS doesn't smooth non-Apple wheels. **Mos** (in the stack) fixes it.

---

## Small things that cause confusion

- **No Program Files.** Apps are single bundles in `/Applications`; drag to Trash to uninstall. Homebrew-installed apps: `brew uninstall --cask name`.
- **Zip:** right-click → Compress. Built in, no 7-Zip needed. For `.rar`, install The Unarchiver.
- **No Alt+Space window menu**, no title-bar double-click-to-maximize by default (System Settings → Desktop & Dock can map double-click to zoom).
- **Function keys** are media keys; hold `Fn` for F1–F12, or invert the default in System Settings → Keyboard.
- **Screenshots** land on the Desktop by default. Shottr (in the stack) replaces the built-in tool with annotation and OCR.
- **`Cmd+H`** hides an app's windows instantly. Useful, and easy to trigger by accident and think the app crashed.
- **Force quit** an unresponsive app: `Cmd+Option+Esc`, or `killall AppName` in a terminal.
- **Right-click** works normally — two-finger tap on the trackpad, or `Ctrl`+click.
- **Preview** opens PDFs and images, and can sign, annotate and merge PDFs. Don't install Acrobat.
- **Time Machine** is File History done well. Plug in an external disk and enable it once; it makes migrating to the next Mac a non-event.

---

## Migration checklist

1. Copy `~/.ssh` from the old machine, then `chmod 700 ~/.ssh` and `chmod 600 ~/.ssh/id_*` — wrong permissions make ssh refuse the key.
2. Convert `.bat`/PowerShell helpers into shell functions in `~/.zshrc.local`.
3. Reinstall browser profiles by signing in rather than copying folders.
4. Check whether your license keys are per-OS — some Windows licenses don't carry over.
5. Set `git config --global core.autocrlf input` before cloning anything.
6. Then run [`install.sh`](install.sh) and follow the manual steps it prints.
