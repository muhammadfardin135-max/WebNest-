# playwright-cli: what is installed and what was verified

Set up and tested 2026-08-29. Unlike `browser-use.md`, this describes something that
actually ran.

## What lives where

**In the repo (survives the container):**

- `.claude/skills/playwright-cli/` — the skill files, so Claude knows the commands.
- `.playwright/cli.config.json` — browser config, including the TLS workaround below.
- `.claude/hooks/session-start.sh` + `.claude/settings.json` — restores the rest at session start.

**Outside the repo (discarded with the container, restored by the hook):**

- The `@playwright/cli` npm package, installed globally.
- Chromium builds under `/opt/pw-browsers`.

The hook is a no-op unless `CLAUDE_CODE_REMOTE=true`, and re-running it is safe.

## The TLS workaround

`.playwright/cli.config.json` passes `--ssl-version-max=tls1.2` to Chromium. It is
load-bearing here, not decoration.

Without it every HTTPS navigation dies with `net::ERR_CONNECTION_RESET`. The agent
proxy's own log shows the pattern: about 2 KB of ClientHello sent, 39 bytes back,
tunnel closed after 6 seconds — on every host, `google.com` as much as the target.

**Verified by A/B, two runs each way:** 2/2 failed without the flag, 2/2 passed with it.
Across the whole session, 8 failed navigations without and 3 clean opens with.

Ruled out by testing, not by reasoning:

- Not certificate trust — `--ignore-certificate-errors` changed nothing.
- Not Encrypted Client Hello — `--disable-features=EncryptedClientHello` changed nothing.
- Not a stale post-quantum feature flag — `PostQuantumKyber`, `PostQuantumKeyAgreement`
  and `UseMLKEM` all changed nothing, and no such flag string exists in this Chromium
  build.
- Not the proxy or the host — `curl` returned 301, and `openssl s_client` completed a
  TLS 1.3 handshake through the same tunnel with a valid `CN=demo.playwright.dev`
  certificate.

So: the proxy handles TLS 1.3 fine from OpenSSL, and fails on whatever Chromium sends
in its TLS 1.3 ClientHello. The hybrid post-quantum key share is the obvious suspect,
**but that is inference, not a tested finding** — the local OpenSSL is 3.0.13 and cannot
send `X25519MLKEM768`, so the decisive test was not available.

Consequence: the flag is a real downgrade for the test browser. Drop it and re-test if
the proxy ever handles Chromium's TLS 1.3.

## Driving it

```sh
playwright-cli open https://example.com   # launch and navigate
playwright-cli snapshot                   # get element refs (e8, e21, ...)
playwright-cli fill e8 "text" --submit    # fill and press Enter
playwright-cli click e21
playwright-cli eval "document.title"
playwright-cli screenshot
playwright-cli close
```

Work from `snapshot` refs rather than guessing selectors. `find "some text"` searches the
snapshot when it is long. Full command list: `playwright-cli --help`, details in the skill.

Screenshots, snapshots and console logs land in `.playwright-cli/`, which is gitignored.

## What was actually exercised

The TodoMVC demo, end to end: added two items, completed one, checked the counter read
"1 item left", confirmed the Completed filter showed only the completed item and Active
only the other, and took a screenshot. Arabic text with diacritics went in and rendered
back correctly.

Re-run from cold after deleting the global npm package: the hook restored it in about
six seconds and the same flow passed again.
