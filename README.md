# webnest

Business workspace. Notes, not code — the model, the offer, the pricing, the sales
motion, and the arguments about all four.

`CLAUDE.md` holds the working rules and is read at the start of every session.

| Folder | What's in it |
|---|---|
| `numbers/` | My real figures. Any economic claim is checked here first. |
| `decisions/` | Things already settled, and what would reopen them. |
| `docs/` | How the tooling works and what was actually tested. |
| `bin/` | `ytfind` — search YouTube and pull transcripts at scale. |
| `.claude/` | Rules, skills, and the two hooks below. |

## The two hooks

**`session-start.sh`** — every session runs in a fresh machine that keeps nothing.
This reinstalls the browser (`playwright-cli`) and the readers (Agent Reach:
web pages as clean text, YouTube transcripts, RSS) before anything else happens.
See `docs/playwright-cli.md` and `docs/agent-reach.md`.

**`session-upkeep.sh`** — once a session runs long, Claude is prompted to propose
updates to `CLAUDE.md`, extract a skill, or cut down repeated permission prompts.
Nothing is applied without approval. See `docs/session-upkeep.md`.

## Skills

- `business-critique` — attack a model at its weakest load-bearing assumption.
  The main event.
- `interview-me` — one question at a time until the real ask surfaces.
- `reverse-prompting` — five clarifying questions before any work starts.
- `claude-md-improver` + `/revise-claude-md` — audit and update the rules file.
- `playwright-cli` — drive a real browser.
