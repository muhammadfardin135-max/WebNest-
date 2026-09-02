# Agent Reach

[Panniantong/Agent-Reach](https://github.com/Panniantong/Agent-Reach) v1.5.0, MIT.
A router, not a wrapper: it installs upstream CLIs, checks their health, and
registers a skill telling the agent which command serves which platform.

Restored each session by `.claude/hooks/session-start.sh`. Nothing about it is
committed to this repo — the CLI lives in `~/.agent-reach-venv`, the source
clone in `~/.agent-reach/src/agent-reach`, and the installer writes its own
skill to `~/.claude/skills/agent-reach`. A committed copy of that skill would
collide on the skill name, so there isn't one.

## What was verified

Cold test, 2026-08-29: every binary and config removed (venv, symlinks,
`~/.agent-reach`, `~/.claude/skills/agent-reach`, `~/.config/yt-dlp`, global
`mcporter`, apt `gh`), then the hook run as the session would run it.
**Exit 0, 16 seconds**, all four binaries and the skill back. Fast because the
pip and apt caches survive; a cache-cold container has not been measured.

Run end-to-end after that restore:

| Channel | Command | Result |
|---|---|---|
| Any web page | `curl -s https://r.jina.ai/URL` | Wikipedia *Usul al-fiqh* returned as markdown |
| YouTube subtitles | `yt-dlp --skip-download --write-auto-sub --sub-lang en URL` | wrote a 440-byte `.vtt` |
| YouTube search | `yt-dlp "ytsearch5:QUERY" --flat-playlist` | 5 real hits, no login |
| RSS/Atom | `python -c "import feedparser; ..."` | Institute of Ismaili Studies feed, 10 entries |

`agent-reach doctor` reports `ok` for those three plus V2EX and Bilibili search.
The two Chinese platforms were not tested and are unlikely to matter here.

## YouTube and the bot check

YouTube serves this datacenter IP `HTTP 429` and *"Sign in to confirm you're not a
bot"* on yt-dlp's default player client — on some videos, not all. Search is
unaffected.

Three clients still answer: `android`, `mweb`, `web_embedded`. The hook appends
a fallback chain to `~/.config/yt-dlp/config`, so plain `yt-dlp URL` calls work
with no flags:

```
--extractor-args youtube:player_client=default,android,mweb,web_embedded
```

Verified 2026-08-30: a video that failed on the default client returned its title
and a 3,982-word transcript once the chain was in place, and again after the
config was deleted and the hook re-run. Appending is idempotent.

No cookies involved. If YouTube tightens this, cookies are the documented next
step (`yt-dlp --cookies FILE`) — yt-dlp's maintainers advise a throwaway Google
account for it, not a main one.

## What does not work

- **Exa semantic search** — `warn`. The keyless tier is rate-limited and
  returned nothing. Needs a free key from https://dashboard.exa.ai/api-keys,
  then `mcporter config add exa 'https://mcp.exa.ai/mcp?exaApiKey=KEY' --scope home`.
- **`gh` CLI** — `warn`. Installs fine, but this environment's `GH_TOKEN` is
  rejected by it. Session GitHub access is via the MCP tools instead.
- **Twitter/X, Reddit, XiaoHongShu, Facebook, Instagram, Xueqiu, LinkedIn,
  Xiaoyuzhou** — need cookies exported from a logged-in browser, and the Meta
  and XiaoHongShu paths additionally need desktop Chrome with the OpenCLI
  extension. Not reachable from a phone.

## Adding a gated channel later

Cookie route, per platform:

1. Log in on the platform in a desktop browser.
2. Install the Cookie-Editor extension, open the site, Export → Header String.
3. Paste the string into a session and ask for that channel.

Then `agent-reach install --env=auto --system --channels=NAME`. Names:
`opencli`, `twitter`, `xiaoyuzhou`, `xueqiu`, `xiaohongshu`, `reddit`,
`facebook`, `instagram`, `bilibili`, `linkedin`, `all`.

Upstream advises a secondary account for any cookie-authenticated platform:
cookies grant full account access, and these platforms ban for non-browser API
traffic.

## Overlap

Web reading and search are already covered in-session by `WebFetch`,
`WebSearch` and Firecrawl, and GitHub by the MCP tools. What Agent Reach adds
that the session did not already have is **YouTube subtitle extraction** and
**RSS parsing**, plus the gated platforms if cookies are ever supplied.
