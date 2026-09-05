# Market evidence — Irish tradesmen

Collected by the research agent during the panel run of **2026-09-05**. Tiers per
`.claude/method/reasoning.md` §2. This file exists so the work is not lost with
the container; it is not a set of conclusions.

**Handle with care:** during that run, a fetch-and-summarise step **fabricated a
quotation** from an Irish Data Protection Commission document. It was caught by
downloading the PDF. Findings below are marked where they were read as raw page
text and where they were not.

## Website ownership — the most useful finding

**624 unique Google Business Profile listings counted directly, 2026-09-05.
19.2% showed no website link.** Tier 2, primary — live listings, collected by
browser, deduplicated by name, ads removed.

| Search | Listings | No website |
|---|---|---|
| Junk removal, Dublin | 106 | **6%** |
| Plumber, Dublin | 95 | 7% |
| House clearance, Dublin | 18 | 17% |
| Plumber, Cork | 110 | 20% |
| Carpenter, Dublin | 103 | 21% |
| Carpenter, Galway | 106 | 24% |
| Handyman, Co. Mayo | 41 | 32% |
| **Carpenter, Co. Leitrim** | 45 | **49%** |

**What it does not cover.** Google Maps ranks by prominence, so this is the top
~120 listings per area, not a random sample. The true population rate is probably
**higher**, not lower — but nobody has measured it. Do not quote 19.2% as a market
rate. "No website link on the profile" also does not prove no website exists.

**The implication that matters:** the Dublin junk removal and plumbing segments
are the most saturated measured. Rural carpentry and handyman work are the least.

## Competitors, live pricing pages, 2026-09-05

- **WebEngineer.ie** (Dublin): €50/month, €0 upfront, builds homepage before
  payment, **12-month minimum, exit fee the lesser of remaining term or €500**.
  Other tiers: €500 once + €15/month; €250 + €90/month. Tier 2, read as raw page
  text.
- **Websites4Tradesmen.ie** (Dublin): one-off, €299–€899, no monthly fee. Free
  hosting year one, €299/yr after. Tier 2, raw text.
- **site-lift.com / "Global Marketing Group"**: deploying identical-template sites
  for Irish tradesmen across at least four counties. **Publishes no prices.**
- **Not retrieved:** Tradesmen.ie, Onlinetradesmen.ie and Golden Pages all block
  automated access. Four attempts, three directories, zero pages read. Their
  pricing is unretrieved, not absent.

## Instagram DM mechanics — official Meta sources only

- DMs from non-followers land in the **Requests folder** and must be accepted
  before appearing in Chats. Instagram Help Center, © 2026. Tier 2, primary.
- The recipient can **switch message requests off entirely**. Same source.
- Requests inactive for **30 days** stop being returned by the API. Meta for
  Developers. Tier 2.
- **No official source found** stating that video in a message request is hidden,
  blurred or unplayable. The widely-repeated 2023 claim traces to trade press,
  not Meta. **Unresolved.**
- **Meta publishes no limit on manually sent DMs.** Three queries. Published API
  rate limits apply to programmatic sending, not a person typing. Every "X per
  day is safe" figure found came from automation vendors — tier 4.

**Note:** the panel researched a mechanic that is not the one in use. See
`model/offer.md` — the reel is posted as a collab and forwarded, not attached as a
file. The findings above are about attached-file DMs and may not transfer.

## Legal — statute text, not an opinion

**S.I. 336/2011** (Ireland's ePrivacy regulations), read from irishstatutebook.ie.
Tier 2, primary — the law itself.

- Reg 13(1) bars unsolicited direct marketing by "electronic mail" to a **natural
  person** without consent. A sole trader is a natural person.
- Reg 13(2)'s business carve-out is written specifically about an **email
  address**. Whether it covers an Instagram handle is not addressed anywhere found.
- Reg 13(13)(b): **each message is a separate offence.**
- Reg 13(15): on indictment, up to **€50,000 for a natural person.**
- Reg 13(14): the burden of proving consent is on the sender.

**Two hinges are genuinely unresolved** on the sources read: whether an Instagram
DM is "electronic mail" sent over a "publicly available electronic communications
service" in Irish law, and whether the sole-trader carve-out reaches it. The DPC's
own direct-marketing guidance (last updated April 2020) covers phone, fax, SMS and
email and **does not mention messaging apps at all**.

`[INSERT: an Irish solicitor's read on whether S.I. 336/2011 reaches Instagram DMs
to sole traders — before volume increases]`

## Payment rails

- **Stripe does not list Bangladesh** as a supported merchant country. Ireland is
  supported. Source: stripe.com/global. The restriction is on where the *merchant*
  is based.
- **GoCardless** merchant countries: Ireland listed, Bangladesh not.
- **Paddle** does not list Bangladesh as unsupported, but whether a managed-website
  subscription qualifies as their "software business" is unresolved.
- PayPal's Bangladesh receiving availability: **not verified**, two fetches failed.
- Payoneer: **not researched**, page returned 403.

`[INSERT: which rail actually works for collecting €50/month recurring from an
Irish card to a Bangladesh-based provider — this is unresolved and it decides
whether the charge is automatic or manually invoiced every month]`

## Demand — unsettled, and nobody measures the right population

- **SOLAS National Skills Bulletin, October 2025** (tier 3, official, dated):
  2024 annual-average employment in Ireland — carpenters & joiners **19,900**,
  plumbers **12,300**. Both named as shortage occupations.
- **AIB Ireland Construction PMI**: contraction April 2025 to January 2026,
  returning to growth February 2026 (52.1). Tier 3 for the survey, secondary for
  the retrieval.
- **Neither measures a one-man domestic repair business's order book**, which is
  the actual question. A labour shortage and a demand contraction coexisted.

`[INSERT: any dated survey of Irish sole-trader tradesmen on current lead volume —
none was found]`

## Searched for and not found

- Any evidence of any tier on the **track record of the build-first-then-cold-DM
  model**. Two adversarial searches, only agency marketing blogs. A genuine void:
  it can neither be supported nor refuted from published experience.
- Any **churn benchmark for subscriptions the customer did not seek out**. Two
  searches. The entire benchmark literature assumes a self-selected buyer.
- Any **count of Irish sole-trader plumbing or carpentry businesses**. Official
  Irish website-ownership statistics (82% of enterprises) **exclude firms under
  ten employees by design** — they do not describe this market at all.
- Tradesman-side pricing for Ireland's two largest lead-gen directories (blocked).

## The nearest available churn benchmark, and why it barely applies

ChartMogul SaaS Retention Report, 2022 data, 2,100+ businesses. For $50–100/month
ARPA: median annual gross revenue retention **66.6%**. Tier 3, named sample.

Four boundaries, all of which bite here: the report **excludes companies under
$300k ARR**; the data is four years old; it is software, not a done-for-you
service; and every customer in it **chose to buy**.
