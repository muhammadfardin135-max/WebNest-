---
description: Run the adversarial advisory panel on a business question — research, prosecute, defend, audit, then one ranked answer with probabilities.
---

Run the full advisory panel on this: $ARGUMENTS

Read `.claude/method/reasoning.md` and `.claude/agents/advisor.md` first, then
chair the panel yourself following the advisor's protocol exactly.

**Use this command when the panel should run from the main session** — it works
whether or not a subagent is permitted to spawn other subagents.

Steps:

1. **Frame it** (advisor Round 0). Kind of question, premise check, word check,
   the state of `numbers/`, and the crux question in one line.
2. **Dispatch `researcher`, `prosecutor` and `defender` in parallel** via the
   Agent tool, each with the framing and the crux question.
3. **Round 2** — give both sides the researcher's findings; require each to
   answer the other's strongest point and to state which probabilities moved.
4. **Round 3** — both name the fact that would flip them.
5. **Draft**, then send it to `auditor` and apply its cuts. Run any round it
   sends back.
6. **Write the output** in the advisor's eight-part shape, including the
   low-confidence section and the failed-search log.

Do not average a split panel. Report the split.
