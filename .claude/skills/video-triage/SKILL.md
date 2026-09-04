---
name: video-triage
description: Report what is actually inside a long video, with timestamps, so the user can decide whether to watch it and which parts to skip. Use whenever the user sends a YouTube link or id and asks whether it is worth watching, what is in it, where a topic is covered, or asks for timestamps, chapters, or a breakdown of a long video, podcast, lecture, or interview. Also use before recommending any video found with `bin/ytfind search`.
---

# Video triage

The user is not asking for a verdict. They are asking for the contents, placed on
the clock, so they can pass judgement themselves. A summary that concludes "worth
watching" and gives no timestamps has answered a question nobody asked.

## The command

```
bin/ytfind map ID
```

Writes a timestamped transcript to `$TMPDIR/ytfind/subs/ID.map.txt` and prints the
path, the block count and the word count. One block per minute of speech by
default; `-b 300` for five-minute blocks on very long material.

Measured 2026-09-04, this container: a 2h06m interview → 126 blocks, 22,233 words,
5.9 seconds. Read the whole file. Do not sample it — the parts worth flagging are
usually not where the title says they are.

`ytfind subs ID` gives the same transcript with the timestamps stripped. That is
the wrong tool here. Use it only when the transcript is going to be read straight
through as prose.

If the output says `NO ENGLISH SUBTITLES`, say so and stop. Do not fall back to
describing the video from its title, description or comments — that is guessing,
and it reads identically to knowing.

## What to write back

Four parts, in this order.

**1. The shape.** Two or three lines. Format (interview, lecture, monologue),
who is speaking, and how the time actually divides. Roughly what fraction is
substance versus preamble, sponsor reads, anecdote and cross-promotion.

**2. The map.** A row per segment, at the granularity the material has — not a
fixed number of rows. Merge minutes that belong to one topic. Split a minute that
turns.

| Time | What happens |
|---|---|
| `0:00–0:08` | … |

Give a real start time you can jump to, not a chapter number. Say what is *said*,
not what the segment is *about*: "claims X causes Y, no evidence given" beats
"discussion of X".

**3. Worth your time.** Only the segments that carry an argument, a number, a
method, or something the user could not have predicted from the title. Each one:
timestamp, one line on the claim, one line on why it earns the minutes. If a
two-hour video has eleven useful minutes, say eleven minutes and name them.

**4. Skippable, and why.** Not a courtesy list. Name what is padding — repetition
of an earlier point, promotion, a story with no payoff — so skipping is a decision
rather than a gamble.

Then one line at the end: the total minutes worth watching, and whether that is
better served by reading the relevant blocks of the transcript instead. Often it
is, and saying so is the more useful answer.

## Rules

- **Never recommend or dismiss on a title.** The transcript decides. This is the
  same rule that governs `ytfind search` in `docs/youtube-research.md`.
- **Quote when a claim is the point.** A paraphrase of a specific claim loses
  exactly the thing the user wanted to check. Keep quotes short and mark them.
- **Distinguish what the speaker asserts from what they establish.** "He says the
  figure is 40%" is a report. "The figure is 40%" is a claim of your own, and you
  have not checked it.
- **Absence is a finding.** If a two-hour video never covers the thing the user
  asked about, that is the answer, and it is worth more than a summary of what it
  did cover. Say which timestamps you checked.
- **No adjectives doing an argument's job.** Not "fascinating discussion". Say
  what is discussed and let the user decide whether it is fascinating.
