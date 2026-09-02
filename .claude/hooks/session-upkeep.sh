#!/bin/bash
# UserPromptSubmit hook. Counts turns and, once a session is long enough to have
# taught something, prints a plain-text block that Claude reads as context.
#
# UserPromptSubmit is one of four events whose plain stdout is added to Claude's
# context (docs: code.claude.com/docs/en/hooks). Exit 0 with no output is a no-op.
#
# Point of the thing: the user works from a phone and will not remember to ask
# for an upkeep pass. So the repo asks.
set -uo pipefail

FIRST_AT=12      # first nudge, in user turns
REPEAT_EVERY=20  # and again every N turns after that

INPUT=$(cat 2>/dev/null || true)

SESSION=$(printf '%s' "$INPUT" | jq -r '.session_id // empty' 2>/dev/null)
DIR=$(printf '%s' "$INPUT" | jq -r '.cwd // empty' 2>/dev/null)
[ -n "$DIR" ] || DIR="${CLAUDE_PROJECT_DIR:-$PWD}"
[ -n "$SESSION" ] || SESSION="nosession-$(printf '%s' "$DIR" | cksum | cut -d' ' -f1)"

# Nothing to review against.
[ -f "$DIR/CLAUDE.md" ] || exit 0

STATE_DIR="${TMPDIR:-/tmp}/claude-upkeep"
mkdir -p "$STATE_DIR" 2>/dev/null || exit 0
COUNT_FILE="$STATE_DIR/$SESSION.count"

N=$(cat "$COUNT_FILE" 2>/dev/null || echo 0)
case "$N" in ''|*[!0-9]*) N=0 ;; esac
N=$((N + 1))
printf '%s' "$N" > "$COUNT_FILE" 2>/dev/null || true

if [ "$N" -lt "$FIRST_AT" ]; then exit 0; fi
if [ "$N" -ne "$FIRST_AT" ] && [ $(( (N - FIRST_AT) % REPEAT_EVERY )) -ne 0 ]; then exit 0; fi

cat <<'NUDGE'
[session-upkeep: automatic, fired by .claude/hooks/session-upkeep.sh]

This session is long enough to have taught the repo something. Answer what the
user just asked FIRST and in full. Then, at the end of that same reply, under a
heading "Session upkeep", run this review:

1. CLAUDE.md — did the user state a rule, correction, or preference this session
   that should hold in future sessions? Quote it. Propose the exact lines to add
   or change, and say which existing line it replaces. Rules only; no narration
   of what happened. If the file has grown loose, say what to cut.
2. A skill worth extracting — did a multi-step workflow happen that will recur?
   Name it and say what the skill would do. Use skill-creator to write it if the
   user approves.
3. Permission prompts — did the same command shape need approval more than once?
   Propose the exact .claude/settings.json allow entries. Every prompt is a tap
   on a phone.

If all three are genuinely empty, say "Session upkeep: nothing to add" in one
line and stop. Do not manufacture a finding.

Then WAIT for approval. On approval: apply the edits, commit, and push. State
plainly which branch it landed on and what the user must still do for it to
reach main — an unmerged branch does not exist for the next session.
NUDGE
exit 0
