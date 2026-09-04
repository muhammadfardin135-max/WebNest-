# Adding skills and plugins, from a phone

## The rule that governs all of this

Every session runs in a fresh machine that is thrown away afterwards. `~/.claude`
does not survive. Committed files do.

So anything installed *into the container* is gone by the next session, and
anything committed *into this repo* is permanent. Where there's a choice, choose
the repo.

Three routes, best first.

## 1. Skills from your account settings

Verified working. On claude.ai, turn a skill on in settings and it syncs into every
session automatically — nothing to commit, nothing to maintain.

Already arriving this way: `docx`, `pdf`, `pptx`, `xlsx`, `skill-creator`,
`morning`, `import-memory`.

This is the right route for general-purpose skills. Use it first.

## 2. Plugins from the catalogue

Ask for a plugin and an install card appears in the chat — tap it, no terminal.
The catalogue holds bundles like Small Business, Sales, Marketing.

**Not yet verified:** that an installed plugin actually reaches a remote session
like this one. Checked 2026-09-02: the container's synced-plugins folder was empty,
so this has never been observed working end to end. Install one and ask Claude to
check from inside — that settles it.

Note that most catalogue plugins lead with connectors (HubSpot, Stripe, QuickBooks)
that need separate setup. The skills inside them work without those.

## 3. Vendoring — for anything else

Copy the skill's files into `.claude/skills/` and commit them. This is what was done
with `claude-md-improver` (Anthropic's `claude-md-management` plugin, Apache-2.0,
from `anthropics/claude-plugins-official`) and its paired `/revise-claude-md`
command.

Installing that as a plugin would have put it in `~/.claude/plugins` — fine on a
laptop, useless here.

**The trade:** upstream fixes don't arrive on their own. Refreshing means copying
the files again. Worth it for anything you rely on.

225 skills from five repos once arrived this way — pm-skills, wondelai,
BMAD-METHOD, cc-thinking-skills, superpowers. **224 of them were deleted on
2026-09-04**, leaving seven. Vendoring is still the right route; the lesson is
that bulk vendoring is not. A skill that is never used costs context in every
session and answers a question that was never asked.

What was kept, what went, and how to restore any of it: `vendored-skills.md`.

Hand Claude a GitHub link to a skill and it can do the copying.

## Which route for what

| | Route |
|---|---|
| A general skill in your account settings | 1 — toggle it on |
| A bundle from the catalogue | 2 — tap the install card |
| Anything from GitHub, or anything you must not lose | 3 — vendor it |
| A skill specific to this business | Write it here directly, with `skill-creator` |
