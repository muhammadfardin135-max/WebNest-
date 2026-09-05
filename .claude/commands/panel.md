---
description: Run the adversarial advisory panel on a business question — ask, research, prosecute, defend, then one ranked answer with probabilities.
---

Run the advisory panel on this: $ARGUMENTS

Read `.claude/method/reasoning.md` and `.claude/agents/advisor.md` first, then chair
the panel yourself following the advisor's protocol.

**This command is expensive.** The budget rules below are not suggestions — a panel
that costs three times what it should is a worse panel, because he stops running it.

## 1. Frame it (Round 0)

Kind of question, premise check, word check, the state of `numbers/`, and the crux in
one line. Keep it under 200 words.

## 2. Ask him first — before spending anything

**Use `AskUserQuestion`. This step is not optional and it is not a formality.**

Most wasted panel budget goes on agents reasoning about something he already knows.
He runs the outreach himself; he knows how his own channel behaves, what he has already
tried, and what the mechanics actually are. Nobody has ever guessed it correctly.

**Ask only questions where a different answer sends the agents somewhere different.**
Two to four, no more. Test each one: *if he answers A instead of B, does the research
brief change?* If not, cut it.

Reliably worth asking:

- **The mechanic, in his words.** Not "you DM them" — what literally happens, step by
  step, in what order, from which account. Panels have burned five figures of tokens
  researching a delivery mechanism that was not the one he uses.
- **What he has already checked.** Do not commission research into a fact he has in
  front of him.
- **What is off the table.** Price, segment, channel — anything settled.
- **Which number he can produce this week**, if the answer turns on one he has not
  recorded.

Then write the brief from his answers, not from your reconstruction of his business.

## 3. Dispatch three agents in parallel, on a budget

`researcher`, `prosecutor` and `defender` at once, each with the framing, his answers,
and the crux. Parallel so neither side anchors on the other.

**Give the researcher at most five named claims to check, ranked, and a hard cap of
eight searches and six fetches.** Name the claims yourself — an open brief is what makes
this agent cost more than the other four combined. Tell it to report the cap it hit.

**Cap the prosecutor and the defender at three searches each**, and tell them the
researcher is covering the market evidence so they do not duplicate it.

**Fold rounds 2 and 3 into the first brief.** Require each of them, in their first and
only output, to:

- name the single fact that would flip their position, and
- state which of their probabilities are soft — one afternoon of research from moving.

That buys most of what a cross-examination round buys, at a third of the cost.

## 4. Draft, and resolve the collisions yourself

Do not run another round to reconcile the two sides. Put their strongest points against
each other in your own draft and say which survives.

**Do not average a split panel. Report the split** — including where they name different
cruxes, which is a finding, not a problem to smooth over.

## 5. Audit — only when it earns its place

Send the draft to `auditor` in exactly three cases: no conclusion in it would surprise
him; the two sides agreed fast without new evidence arriving; or the draft's core rests
on something nobody actually checked. Otherwise run the auditor's Check 1 (obviousness)
and Check 3 (probability) yourself against `reasoning.md` and skip the agent.

## 6. Output — 600 words, hard

The advisor's shape, compressed: the call, banded confidence, what it rests on, the
crux and its cheapest test, **held with low confidence** (always present), and what
could not be checked with query counts.

Cut every conclusion that fails §5's obviousness filter. If nothing survives, say the
panel found nothing — that is a real result and it is cheaper than four pages.
