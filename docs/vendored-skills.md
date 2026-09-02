# Vendored skills — what's installed, from where, how to refresh

225 skills from five GitHub repos were copied into `.claude/skills/`, one
directory per skill, alongside the 5 that were already here. All five upstream
repos are MIT-licensed, so copying and keeping them is allowed. Copyright stays
with the original authors; each skill directory keeps its own files unchanged.

Route 3 in `skills-and-plugins.md` — vendoring. Nothing here depends on a plugin
install surviving the container.

## Sources

Pinned to the commit that was copied. Refreshing means re-copying from a newer
commit; upstream fixes do not arrive on their own.

| Repo | Commit | Commit date | Copied | License |
|---|---|---|---|---|
| `wondelai/skills` | `eade5d1` | 2026-08-29 | 65 | MIT |
| `phuryn/pm-skills` | `18468a9` | 2026-07-03 | 68 | MIT |
| `bmad-code-org/BMAD-METHOD` | `891c0ab` | 2026-09-02 | 50 | MIT |
| `tjboudreaux/cc-thinking-skills` | `7b8fece` | 2026-08-07 | 28 | MIT |
| `obra/superpowers` | `b36e082` | 2026-08-12 | 14 | MIT |

Two of these were named without an owner. `superpowers` was matched to
`obra/superpowers` and `BMAD-METHOD` to `bmad-code-org/BMAD-METHOD` — both are
the canonical repos and their contents match. The star counts given when the
install was requested could not be checked: this session's GitHub API access is
scoped to `muhammadfardin135-max/webnest-` and returns 403 for anything else.
Matching was by owner, name and content, not by star count.

## What was left out

- **Re-bundled copies.** `wondelai/skills` ships each skill twice — once at the
  repo root, once under `plugins/`. Only one copy of each was taken.
- **BMAD web bundles and test fixtures** (`web-bundles/`, `tools/tests/`) — not
  skills.
- Upstream READMEs, CI config, and the editor-specific mirrors
  (`.cursor/`, `.windsurf/`, `.pi/`, `.agents/`).

No skill name collided with another, or with the 5 already here, so nothing was
renamed. Every directory name matches its `name:` field.

## The BMAD runtime

BMAD is the one set that is not self-contained. 42 of its 50 skills shell out to
Python scripts that its own installer (`npx bmad-method install`) would normally
place at `_bmad/`. The installer was not run — it is a Node tool that writes a
full project scaffold. Instead the three scripts the skills actually call were
copied from the same commit:

- `_bmad/scripts/` — `resolve_customization.py`, `resolve_config.py`,
  `memlog.py`, plus `config_utils.py` and `render_skill.py` they import.
- `_bmad/config.toml` — central config, normally written by the installer.
- `_bmad/bmm/config.yaml` — the same values in the older YAML shape that 23 of
  the `bmad-*` skills read directly. **Keep the two files in step.**

All three scripts were run against this repo and return correct output. They
need Python 3.11+ and `uv`; `uv` is restored each session by the session-start
hook.

`output_folder` is set to `_bmad-output/`, so everything BMAD generates stays out
of `numbers/`, `decisions/` and `docs/`. The directory is created lazily by the
first skill that writes to it.

`user_name` in both config files is still the upstream default `"BMad"` — no real
value was supplied, and it is what the BMAD agents will call you until it is
changed.

## The cost of holding 230 skills

Every skill's `name` and `description` is loaded into **every** session before
any work starts. Measured across the 225 vendored skills: **86,102 characters,
roughly 21,500 tokens.** That is paid on every session in this repo, whether or
not a skill is used.

Trimming means deleting skill directories. Two obvious candidates:

- **21 of the 50 BMAD skills are deprecated forwarding shims** whose whole
  description is "Deprecated — forwards to X". They exist so old invocations
  still work. This repo has no old invocations.
- The dev-lifecycle skills (BMAD's `bmad-agent-dev`, `bmad-dev-story`,
  `bmad-qa-generate-e2e-tests`, superpowers' TDD and worktree skills, wondelai's
  `clean-code` / `refactoring-patterns` family) are aimed at codebases. This repo
  is business notes.

## Refreshing one source

Clone the repo at a new commit, copy the skill directories over the existing ones
in `.claude/skills/`, and update the commit in the table above. For BMAD, also
re-copy `src/scripts/` to `_bmad/scripts/` and re-check the config keys in
`src/core-skills/module.yaml` and `src/bmm-skills/module.yaml` against
`_bmad/config.toml`.
