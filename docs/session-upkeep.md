# Automatic session upkeep

## The problem

Rules only help if they're written down, and the moment you learn one is the moment
you're busiest doing something else. Asking for an upkeep pass by hand means
remembering to — which doesn't happen.

So the repo asks instead.

## How it works

`.claude/hooks/session-upkeep.sh` runs on every message you send, registered as a
`UserPromptSubmit` hook in `.claude/settings.json`. Almost every time it does
nothing at all and exits.

It counts your messages in the session. On message **12**, and every **20** after
that (32, 52, …), it prints a block of instructions that Claude reads as context.
You never see it. What you see is Claude answering your question and then adding a
**Session upkeep** section covering three things:

1. **CLAUDE.md** — a rule, correction or preference you stated this session that
   should hold in future ones, with the exact lines to add.
2. **A skill worth extracting** — a workflow that happened and will recur.
3. **Permission prompts** — command shapes that needed approval more than once,
   with the `settings.json` entries that would stop it. Every prompt is a tap.

If none of the three has anything real in it, the instruction is to say
"Session upkeep: nothing to add" and stop, rather than invent a finding.

Nothing is applied until you approve it. On approval Claude edits, commits and
pushes, and states which branch it landed on.

`UserPromptSubmit` is one of four events whose plain stdout is added to the model's
context ([docs](https://code.claude.com/docs/en/hooks)) — which is why it's the
event used here rather than `Stop`.

## Tuning it

Two variables at the top of the script:

```sh
FIRST_AT=12      # first nudge, in user turns
REPEAT_EVERY=20  # and again every N turns after that
```

Raise `FIRST_AT` if it interrupts too early. Just say so and it gets changed.

## What was verified

Tested directly, 2026-09-02, by feeding the script the JSON a hook receives:

| Check | Result |
|---|---|
| Fires only on the intended turns | Ran 40 turns; fired on 12 and 32, silent on the other 38 |
| Stays silent in a directory with no CLAUDE.md | Silent through 20 turns |
| Two sessions don't share a counter | Session B stayed silent at its turn 1 while session A sat at 11; A then fired at 12 |
| Junk, empty, and `{}` stdin | Exit 0 each time, no output, no crash |

**Not verified:** that Claude Code invokes the hook and surfaces the text inside a
live session. The script's logic is tested; the wiring is not. The first real
session past twelve messages is the test. If it never fires, check that
`.claude/settings.json` lists `UserPromptSubmit` and that the file is executable
(`ls -l .claude/hooks/`).
