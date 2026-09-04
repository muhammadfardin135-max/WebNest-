# Skills — what is kept, what was deleted, how to get any of it back

Seven skills live in `.claude/skills/`. Until 2026-09-04 there were 231.

224 were deleted deliberately. This file records what they were and how to
restore one, so the deletion is reversible rather than merely regrettable.

## What is kept, and why each earns its place

| Skill | Why it stays |
|---|---|
| `business-critique` | `CLAUDE.md` names it directly — "the `business-critique` skill has the method". Deleting it would leave the project rules pointing at nothing. |
| `claude-md-improver` | The `/revise-claude-md` command in `.claude/commands/` calls it. Deleting it breaks that command. |
| `video-triage` | Consumes `bin/ytfind map`. Without it the transcript tooling has no reader. See `youtube-research.md`. |
| `mom-test` | Customer interviews without harvesting false encouragement. A technique, not a diagram — the one thing in the 231 that could not be improvised. |
| `interview-me` | One question at a time until the real ask is clear. |
| `reverse-prompting` | Forces clarifying questions before work begins. Overlaps `interview-me`; both kept because both are small. |
| `playwright-cli` | Browser automation. See `playwright-cli.md`. |

## What is not in this repo, and never was

Deleting from `.claude/skills/` does not touch either of these. Both come back
on their own every session.

- **`agent-reach`** — written into `~/.claude/skills/` by
  `.claude/hooks/session-start.sh`. See `agent-reach.md`.
- **Account skills** — `docx`, `pdf`, `pptx`, `xlsx`, `morning`,
  `import-memory`, `skill-creator`. Synced from claude.ai account settings.
  Turning one off is a toggle on the website, not an edit here.

## What was deleted

All 225 vendored skills except `mom-test`, plus the `_bmad/` runtime.

| Repo | Commit | Commit date | Copied | Deleted | License |
|---|---|---|---|---|---|
| `wondelai/skills` | `eade5d1` | 2026-08-29 | 65 | 64 | MIT |
| `phuryn/pm-skills` | `18468a9` | 2026-07-03 | 68 | 68 | MIT |
| `bmad-code-org/BMAD-METHOD` | `891c0ab` | 2026-09-02 | 50 | 50 | MIT |
| `tjboudreaux/cc-thinking-skills` | `7b8fece` | 2026-08-07 | 28 | 26 | MIT |
| `obra/superpowers` | `b36e082` | 2026-08-12 | 14 | 14 | MIT |

Roughly: 50 BMAD spec/PRD/story/sprint skills, ~120 business and product
frameworks, ~50 software-engineering skills. `.claude/skills/` went from 11MB to
304KB.

`_bmad/` went with them — its config and three Python scripts existed only to
serve the 42 `bmad-*` skills that shelled out to them. The `CLAUDE.md` bullet
describing it was removed in the same commit.

### Why

Frameworks were never the constraint. `CLAUDE.md` still carries three unfilled
`[INSERT]` lines — what the business sells, what stage it is at, the one number
that decides it. No quantity of canvases substitutes for those, and every skill
in the folder costs context in every session whether or not it is used.

The three engineering sets were vendored into a repo whose own rules open with
"Business notes, not code."

## Restoring one

Everything is in git history. Nothing needs re-downloading from upstream.

```
git checkout 62ed426 -- .claude/skills/NAME
```

`62ed426` is the last commit that held all 231. For the BMAD skills also restore
`_bmad/` from the same commit, or they will fail on their missing scripts.

**Ask before re-adding.** `CLAUDE.md` carries this as a standing rule: a skill
that is not used is a cost paid every session for an answer to a question that
was never asked.

## Refreshing a kept skill

Upstream fixes do not arrive on their own.

Five of the seven came from the `Seed business workspace` commit (`1d0f830`) —
`business-critique`, `interview-me`, `reverse-prompting`, `playwright-cli`,
`claude-md-improver`. Of those, only `claude-md-improver` tracks a real upstream
(Anthropic's `claude-md-management` plugin in `anthropics/claude-plugins-official`,
Apache-2.0).

`mom-test` came from `wondelai/skills` at `eade5d1`. `video-triage` was written
here on 2026-09-04 and has no upstream.

Refreshing any of them means copying the directory again from a newer commit.
