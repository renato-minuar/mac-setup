# Random dark background per Kitty split
[[ -n "$KITTY_WINDOW_ID" ]] && printf '\e]11;#%02x%02x%02x\e\\' $((RANDOM % 30 + 10)) $((RANDOM % 30 + 10)) $((RANDOM % 30 + 10))

# claudio — Claude Code launcher
# Usage: claudio [-t] [-s] [-c] [-n name] [claude args...]
#   -t  Run inside tmux (session named after current dir, reuses if exists)
#   -s  Safe mode (with permissions, no --dangerously-skip-permissions)
#   -c  Clean dead claude-* tmux sessions before starting
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
  local claude_cmd="claude"
  [[ "$safe_mode" == false ]] && claude_cmd="claude --dangerously-skip-permissions"

  # Clean dead claude-* tmux sessions (only those where the process has exited)
  if [[ "$do_clean" == true ]]; then
    local cleaned=0
    for sess in $(tmux list-sessions -F '#{session_name}:#{session_attached}:#{pane_pid}' 2>/dev/null); do
      local name="${sess%%:*}" rest="${sess#*:}" attached="${rest%%:*}" pid="${rest#*:}"
      if [[ "$name" == c-* && "$attached" == "0" ]] && ! kill -0 "$pid" 2>/dev/null; then
        tmux kill-session -t "$name" 2>/dev/null && ((cleaned++))
      fi
    done
    if [[ $cleaned -gt 0 ]]; then
      echo "Cleaned $cleaned dead session(s)"
    else
      echo "No dead sessions found"
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
export PATH="$HOME/.antigravity/antigravity/bin:$PATH"

# Starship prompt
eval "$(starship init zsh)"

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
