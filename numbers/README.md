# numbers

My real figures. Nothing else.

Any claim about the economics of this business gets checked against this folder
first. If the folder is empty, the honest answer is that the analysis is
unanchored — a story, not a business. Typical industry values are not a
substitute and must not be quietly used as one.

## What belongs here

One file per thing, plain markdown or CSV. Suggested starting set:

- `pricing.md` — what I charge, every tier, and what I actually collect after
  discounts
- `costs.md` — fixed and per-unit, so gross margin is computable
- `funnel.md` — traffic, leads, calls, closes, with the dates the counts cover
- `customers.md` — count, churn, average contract value, concentration
- `channels.md` — spend and result per channel, so CAC is real rather than assumed

## Rules for this folder

**Date every number.** A conversion rate with no period attached is not a number.

**Say where it came from.** Stripe, a spreadsheet, a hand count. If it's an
estimate, write "estimate" next to it and say whose.

**Keep guesses separate from measurements.** Same file is fine, different heading
is not optional. A guess that gets read as a measurement six weeks later is how
bad decisions get made confidently.

**Don't delete old figures.** Move them under a `## History` heading. Trend beats
snapshot, and I won't remember what last quarter looked like.
