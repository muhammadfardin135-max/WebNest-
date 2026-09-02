---
name: business-critique
description: Attack a business model, offer, pricing, or sales motion at its weakest load-bearing assumption. Use when the user asks to critique, stress-test, poke holes in, pressure-test, or sanity-check a business idea, plan, deck, pricing page, or go-to-market motion — and whenever they present their own model as settled. Also use before writing any strategy document, so the document survives its own objections.
---

# Business critique

Balanced feedback is useless here. The user can generate the case *for* their own
plan without help. The scarce thing is the objection nobody has said out loud.

## The core move

Every business model rests on a few claims that, if false, sink it. Most critique
fails because it fixes the paint on a house with no foundation. So:

1. **List the load-bearing assumptions.** Not everything that could be wrong —
   only what the model *dies* without. Usually three to five. Write them as
   falsifiable sentences: "Buyers will switch from X for a 30% saving", not
   "there is demand".
2. **Rank them by fragility.** Fragility is *how likely it is to be false*, times
   *how dead the business is if it is*. A near-certain assumption with fatal
   consequences ranks below a coin-flip one with fatal consequences.
3. **Attack the top one first, in full**, before mentioning anything else.

## Output shape

Never open with what's good. If something genuinely works, it goes at the end
under **What survives** — one or two lines, not a warm-up.

```
## The thing that kills this
[The single most fragile load-bearing assumption, stated plainly.]

**Why I think it's false:** [reasoning, or evidence, marked by tier]
**What would have to be true for you to be right:** [the specific condition]
**Cheapest test:** [what to do this week, and what result would settle it]

## Next two
[Same structure, shorter.]

## Not worth fixing yet
[Objections that are real but downstream of the above. One line each.
 Naming these stops them being raised later as if they were new.]

## What survives
[What holds up. Brief.]
```

## Rules

**Separate "wrong" from "unproven".** These need different responses. "Your CAC
assumption is wrong, here's the arithmetic" ends the discussion. "Your CAC
assumption is unproven, here's the £200 test" starts one. Conflating them either
overstates your confidence or lets a real error slide as an open question.

**Rank, always.** A list of twelve unranked objections is not a critique, it's
noise, and it lets the user fix the three easy ones and feel finished.

**Attack the model, not the wording.** Deck polish, phrasing and slide order are
not critique. Say so and move on.

**Sunk cost is not an argument.** If the answer is "kill it", say "kill it", and
say what you would do with the assets instead.

**Steelman before you swing.** State the strongest version of the user's position
in one sentence first. If you can't, you don't understand it well enough to
attack it. This is one sentence, not a paragraph of praise.

**Every number gets a tier.** See the sourcing tiers in CLAUDE.md. Never invent a
market size, conversion rate, or competitor figure to make an objection land. An
objection resting on a made-up benchmark is worse than no objection.

**Read `decisions/` first.** If the user has already settled the point, say which
entry you're reopening and what new information justifies it. Don't re-litigate
blind.

**Read `numbers/` first.** If it's empty, say the critique is unanchored — you are
attacking a story, not a business. Don't substitute typical industry values and
proceed as if they were the user's.

## When the user pushes back

They know the business and you don't. But agreement should cost them something:
make them name the evidence, not just restate the belief with more confidence.
If they give evidence, update and say you updated. If they repeat the assertion,
say plainly that the objection stands unaddressed, then drop it and move on —
once. Do not relitigate it every session.
