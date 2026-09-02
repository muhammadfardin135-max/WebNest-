#!/bin/bash
# Rebuilds tooling that lives outside the repo and is lost when the container
# is discarded. Repo-side pieces are committed and need no restoring.
set -euo pipefail

if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

export PATH="$HOME/.local/bin:$PATH"

# --- playwright-cli -------------------------------------------------------
# Skill lives in .claude/skills/playwright-cli, config in .playwright (both
# committed). Only the npm package and browser binaries need restoring.
if ! command -v playwright-cli >/dev/null 2>&1; then
  npm install -g @playwright/cli@latest >/dev/null 2>&1
fi
playwright-cli install-browser chromium >/dev/null 2>&1 || true

# --- agent-reach ----------------------------------------------------------
# https://github.com/Panniantong/Agent-Reach — CLI plus the skill it registers
# at ~/.claude/skills/agent-reach. Both live outside the repo, so both are
# rebuilt here. The installer writes the skill itself; do not commit a copy,
# it would collide on the skill name.
AR_SRC="$HOME/.agent-reach/src/agent-reach"
AR_VENV="$HOME/.agent-reach-venv"

if ! command -v agent-reach >/dev/null 2>&1; then
  mkdir -p "$HOME/.agent-reach/src" "$HOME/.local/bin"

  if [ -d "$AR_SRC/.git" ]; then
    git -C "$AR_SRC" fetch --depth 1 origin main >/dev/null 2>&1 || true
    git -C "$AR_SRC" reset --hard origin/main >/dev/null 2>&1 || true
  else
    rm -rf "$AR_SRC"
    git clone --depth 1 https://github.com/Panniantong/agent-reach "$AR_SRC" >/dev/null 2>&1 || true
  fi

  if [ -f "$AR_SRC/pyproject.toml" ]; then
    if command -v uv >/dev/null 2>&1; then
      uv venv "$AR_VENV" >/dev/null 2>&1 || true
      VIRTUAL_ENV="$AR_VENV" uv pip install "$AR_SRC" >/dev/null 2>&1 || true
    else
      python3 -m venv "$AR_VENV" >/dev/null 2>&1 || true
      "$AR_VENV/bin/pip" install --quiet "$AR_SRC" >/dev/null 2>&1 || true
    fi

    for bin in agent-reach yt-dlp; do
      [ -x "$AR_VENV/bin/$bin" ] && ln -sf "$AR_VENV/bin/$bin" "$HOME/.local/bin/$bin"
    done
  fi
fi

# Installs gh/mcporter, writes the yt-dlp JS-runtime config and registers the
# skill. Cheap and idempotent once those are present, so it runs every session.
if command -v agent-reach >/dev/null 2>&1; then
  agent-reach install --env=auto --system >/dev/null 2>&1 || true
fi

# YouTube serves this datacenter IP a bot check on the default player client
# ("Sign in to confirm you're not a bot"). android/mweb/web_embedded still
# answer it, so pin a fallback chain. Appended after the installer, which
# writes --js-runtimes node to the same file.
YTDLP_CONF="$HOME/.config/yt-dlp/config"
YTDLP_LINE='--extractor-args youtube:player_client=default,android,mweb,web_embedded'
if [ -f "$YTDLP_CONF" ] && ! grep -qxF -- "$YTDLP_LINE" "$YTDLP_CONF" 2>/dev/null; then
  printf '%s\n' "$YTDLP_LINE" >> "$YTDLP_CONF"
fi
