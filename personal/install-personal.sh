#!/bin/bash
set -e

# Owner's extras. Run AFTER ../install.sh, and only on the owner's own machine —
# none of this is needed to have a working Mac. If you cloned this repo, delete
# the personal/ directory.

echo "=== Personal layer ==="
echo ""

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# --- AI tooling ---
echo "Installing AI CLIs and apps..."
brew install rtk
brew install --cask claude antigravity

# Node globals land in the Homebrew node prefix; Bun globals in ~/.bun
npm install -g \
  @anthropic-ai/claude-code \
  @google/gemini-cli \
  defuddle-cli \
  uipro-cli

bun install -g @openai/codex

# --- Shell additions ---
echo ""
echo "Linking ~/.zshrc.local..."
ln -sf "$SCRIPT_DIR/zshrc.local" ~/.zshrc.local
echo "  ~/.zshrc.local  (claudio launcher, Antigravity PATH)"

# --- Raycast settings ---
echo ""
echo "To import Raycast settings, double-click: $SCRIPT_DIR/raycast-settings.rayconfig"

echo ""
echo "Done. Open a new shell to pick up ~/.zshrc.local."
