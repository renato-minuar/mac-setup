# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Random dark background per Kitty split
[[ -n "$KITTY_WINDOW_ID" ]] && printf '\e]11;#%02x%02x%02x\e\\' $((RANDOM % 30 + 10)) $((RANDOM % 30 + 10)) $((RANDOM % 30 + 10))

# claudio — Claude Code launcher
# Usage: claudio [-t] [-s] [-c] [-n name] [claude args...]
#   -t  Run inside tmux (session named after current dir, reuses if exists)
#   -s  Safe mode (with permissions, no --dangerously-skip-permissions)
#   -c  Clean detached c-* tmux sessions idle ≥48h, then list survivors.
#       If used alone (no other flags/args), exits after cleaning.
#   -n  Custom tmux session name (implies -t)
claudio() {
  local use_tmux=false safe_mode=false do_clean=false custom_name=""
  local args=()

  # Parse our flags, collect everything else for claude
  while [[ $# -gt 0 ]]; do
    case "$1" in
      -t) use_tmux=true ;;
      -s) safe_mode=true; use_tmux=true ;;
      -c) do_clean=true ;;
      -n) shift; custom_name="$1"; use_tmux=true ;;
      *)  args+=("$1") ;;
    esac
    shift
  done

  # Build claude command
  local claude_cmd="claude --chrome"
  [[ "$safe_mode" == false ]] && claude_cmd="claude --chrome --dangerously-skip-permissions"

  # Clean detached c-* tmux sessions idle ≥48h, then list all c-* sessions
  if [[ "$do_clean" == true ]]; then
    local max_idle_hours=48
    local now=$(date +%s)
    local cleaned=0
    # Current tmux session (if any) — never kill the one we're inside
    local current_session=""
    [[ -n "$TMUX" ]] && current_session=$(tmux display-message -p '#S' 2>/dev/null)

    for sess in $(tmux list-sessions -F '#{session_name}:#{session_attached}:#{session_activity}' 2>/dev/null); do
      local name="${sess%%:*}" rest="${sess#*:}" attached="${rest%%:*}" activity="${rest#*:}"
      [[ "$name" != c-* ]] && continue
      [[ "$name" == "$current_session" ]] && continue
      local idle_h=$(( (now - activity) / 3600 ))
      if (( idle_h >= max_idle_hours )); then
        tmux kill-session -t "$name" 2>/dev/null && { ((cleaned++)); echo "  killed: $name (idle ${idle_h}h)"; }
      fi
    done

    if (( cleaned > 0 )); then
      echo "Cleaned $cleaned session(s) idle ≥${max_idle_hours}h"
    else
      echo "No sessions idle ≥${max_idle_hours}h"
    fi

    echo ""
    echo "Alive c-* sessions:"
    local any=0
    for sess in $(tmux list-sessions -F '#{session_name}:#{session_attached}:#{session_activity}' 2>/dev/null); do
      local name="${sess%%:*}" rest="${sess#*:}" attached="${rest%%:*}" activity="${rest#*:}"
      [[ "$name" != c-* ]] && continue
      local idle_h=$(( (now - activity) / 3600 ))
      local sess_status="idle ${idle_h}h"
      [[ "$attached" == "1" ]] && sess_status="attached"
      printf "  %-32s  %s\n" "$name" "$sess_status"
      any=1
    done
    (( any == 0 )) && echo "  (none)"

    # If -c was the only flag (no tmux, no custom name, no extra args), stop here.
    if [[ "$use_tmux" == false && ${#args[@]} -eq 0 ]]; then
      return 0
    fi
  fi

  if [[ "$use_tmux" == true ]]; then
    local name
    if [[ -n "$custom_name" ]]; then
      name="c-${custom_name}"
    else
      local dir="${PWD:t}"
      local id=$((RANDOM % 900 + 100))
      name="c-${dir}-${id}"
    fi

    if [[ -n "$TMUX" ]]; then
      # Already in tmux — just run claude directly
      eval "$claude_cmd ${args[*]}"
    else
      # Always create a new session (unique ID allows multiple per directory)
      tmux new-session -d -s "$name"
      tmux send-keys -t "$name" "$claude_cmd ${args[*]}" Enter
      tmux attach -t "$name"
    fi
  else
    # No tmux — just run claude
    eval "$claude_cmd ${args[*]}"
  fi
}

# Syntax highlighting (valid commands = green, invalid = red)
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Autosuggestions (ghost text from history)
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# fzf keybindings and completion (Ctrl+R for history, Ctrl+T for files)
source <(fzf --zsh)

# Added by Antigravity
export PATH="/Users/benne-air/.antigravity/antigravity/bin:$PATH"

# Powerlevel10k prompt
source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# bun completions
[ -s "/Users/benne-air/.bun/_bun" ] && source "/Users/benne-air/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
