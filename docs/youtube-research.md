# Finding videos on YouTube

`bin/ytfind`. Wraps `yt-dlp`, which the session-start hook restores. No API key,
no cookies, no login.

```
ytfind search [-d DEPTH] [-m MIN] [-M MAX] [-s SINCE] [-L] QUERY...
ytfind subs ID...
ytfind meta ID...
```

`-d` results per query (default 100) · `-m`/`-M` duration bounds in seconds
(default 600–10800) · `-s` drop anything before `YYYYMMDD` · `-L` also run
YouTube's own >20min filter.

## The method, in order

1. **`search`** across three or four phrasings of the topic. Output stays in
   YouTube's relevance order, so read top-down and stop where it degrades —
   usually somewhere past the tenth result.
2. **`subs`** on every plausible candidate. Not the shortlist — the longlist.
3. **Read the transcripts and reject.** This is the step that produces the
   answer. Nothing gets recommended on the strength of a title.

On the 2026-09-01 run: 12 transcripts pulled, 9 rejected. One was cut on a
single line — *"hive mind intelligence, neural networks, 27 cognitive models
— don't ask me what that is."* Titles in this genre all promise a deep dive.

## What was verified

Measured 2026-09-01, this container, on the `ruflo` / agent-orchestration topic.

| Claim | Result |
|---|---|
| `ytsearch100:` returns 100 hits | 100 rows, 3.8s |
| Flat search carries no upload date | 0 of 100 rows had one — dates need the per-video pass |
| Parallel enrichment at `-P 16` | 63 videos, full metadata, 55s |
| YouTube's own >20min filter (`sp=EgIYAg%3D%3D`) works through yt-dlp | Yes — and it returned a 34-minute video that 26 keyword searches had missed |
| `subs` on a video with no English track | Reports `NO ENGLISH SUBTITLES`, does not fail silently |

**`ytsearchdate` does not work here.** Hard error: *unsupported url scheme*.
So retrieval ranked by upload date is the one angle this route cannot reach.
It is the only thing a YouTube Data API v3 key would add that yt-dlp does not
already do — the rest of the case for that key was wrong, and the key is not
worth acquiring for it. **Untested:** no call has ever been made against that
API from this container.

## Traps

- **Never re-sort the merged pool by date.** YouTube pads a search tail with
  loosely-related hits, and those are often the newest things in the pool, so
  date-sorting floats junk to the top and buries the real answers. `search`
  deliberately keeps relevance order.
- **yt-dlp does not expand `\t` in `--print`.** Pass a literal tab.
- **A full `search` run takes 60–90 seconds** and will trip a 2-minute command
  timeout if you chain several. Run them one at a time.
- **Absence is a finding.** If the good video does not exist, say that, with
  the number of queries behind the claim. A silent gap reads as "I found the
  best there is" and that is a different, false statement.
