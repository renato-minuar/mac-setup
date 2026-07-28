# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Homebrew prefix — /opt/homebrew on Apple Silicon, /usr/local on Intel.
# Resolved without calling `brew` so shell startup stays fast.
if [[ -d /opt/homebrew ]]; then
  BREW_PREFIX=/opt/homebrew
else
  BREW_PREFIX=/usr/local
fi

# Random dark background per Kitty split — makes panes distinguishable
[[ -n "$KITTY_WINDOW_ID" ]] && printf '\e]11;#%02x%02x%02x\e\\' $((RANDOM % 30 + 10)) $((RANDOM % 30 + 10)) $((RANDOM % 30 + 10))

# Syntax highlighting (valid commands = green, invalid = red)
source "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# Autosuggestions (ghost text from history)
source "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"

# fzf keybindings and completion (Ctrl+R for history, Ctrl+T for files)
source <(fzf --zsh)

# zoxide — smarter cd (usage: z <partial-name>)
eval "$(zoxide init zsh)"

# Powerlevel10k prompt
source "$BREW_PREFIX/share/powerlevel10k/powerlevel10k.zsh-theme"
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# Bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
[ -s "$BUN_INSTALL/_bun" ] && source "$BUN_INSTALL/_bun"

# Per-directory Node version pin. Some projects need a specific Node major
# because a native module's prebuilt ABI doesn't match the default keg.
# Resolution order, first hit wins:
#   1. nearest .node-version or .nvmrc walking up from $PWD (project-committed)
#   2. ~/.config/node-pins — untracked "<path> <major>" lines, for repos that
#      carry neither file
# The matching keg ($BREW_PREFIX/opt/node@<major>/bin) is prepended to PATH;
# leaving the directory removes it. No pin = default node.
_node_pin_version() {
  local dir="$PWD" f v
  while [[ -n "$dir" && "$dir" != "/" ]]; do
    for f in "$dir/.node-version" "$dir/.nvmrc"; do
      [[ -r "$f" ]] || continue
      v="$(<"$f")"
      v="${v//[^0-9.]/}"
      [[ -n "$v" ]] && { print -r -- "${v%%.*}"; return 0 }
    done
    dir="${dir:h}"
  done

  local pins="${XDG_CONFIG_HOME:-$HOME/.config}/node-pins" pat major
  [[ -r "$pins" ]] || return 1
  while IFS=$' \t' read -r pat major; do
    [[ -z "$pat" || "$pat" == \#* || -z "$major" ]] && continue
    pat="${pat/#\~/$HOME}"
    case "$PWD/" in
      "${pat%/}"/*) print -r -- "$major"; return 0 ;;
    esac
  done < "$pins"
  return 1
}

_node_pin_path() {
  local -a kept=()
  local p
  for p in "${(@s/:/)PATH}"; do
    [[ "$p" == "$BREW_PREFIX"/opt/node@*/bin ]] || kept+=("$p")
  done
  PATH="${(j/:/)kept}"

  local major keg
  if major="$(_node_pin_version)"; then
    keg="$BREW_PREFIX/opt/node@${major}/bin"
    [[ -d "$keg" ]] && PATH="$keg:$PATH"
  fi
  export PATH
}
autoload -U add-zsh-hook
add-zsh-hook chpwd _node_pin_path
_node_pin_path

# Machine-specific additions (personal functions, extra PATH entries, secrets).
# Not tracked by this repo — see personal/ for how the owner wires this up.
[[ -r ~/.zshrc.local ]] && source ~/.zshrc.local
