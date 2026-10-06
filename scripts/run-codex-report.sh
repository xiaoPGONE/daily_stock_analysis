#!/usr/bin/env bash
set -euo pipefail

project_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$project_dir"
export PATH="$HOME/.local/bin:$PATH"
export GENERATION_BACKEND=codex_cli
export GENERATION_FALLBACK_BACKEND=
export AGENT_MODE=false

if [[ ! -x .venv/bin/python ]]; then
  printf '%s\n' 'Missing .venv/bin/python; create the project virtual environment and install requirements.txt first.' >&2
  exit 1
fi
if ! command -v codex >/dev/null 2>&1; then
  printf '%s\n' 'Codex CLI is not on PATH; install it and sign in on this device first.' >&2
  exit 1
fi

# With no arguments, review the market instead of choosing a sample stock.
if [[ $# -eq 0 ]]; then
  set -- --market-review
fi

exec .venv/bin/python main.py --no-notify "$@"
