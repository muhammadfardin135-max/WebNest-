#!/usr/bin/env python3
"""Turn a YouTube .vtt subtitle file into a timestamped map of what is said when.

`vtt2txt.py` drops every timestamp, which is right when the transcript is going
to be read straight through. It is wrong when the question is *where in this
video is the part I need* — then the timestamp is the whole point.

Same de-duplication trick as vtt2txt: auto-generated captions repeat each line
as the caption rolls, so consecutive duplicates are dropped after tag removal.
What is kept is the start time of the first cue that carried each line.

Output is one block per bucket:

    [0:14:00] and so the second thing he does is ...

Bucket size defaults to 60 seconds. A two-hour video collapses to ~120 blocks,
which fits in a single read.
"""
import argparse
import re
import sys

CUE = re.compile(r"^(\d{2,}):(\d{2}):(\d{2})[.,](\d{3})\s*-->")
TAG = re.compile(r"<[^>]+>")
SKIP = ("WEBVTT", "Kind:", "Language:", "NOTE", "STYLE", "REGION")


def parse(path):
    """Yield (start_seconds, text) for each non-repeated caption line."""
    start, prev = None, None
    with open(path, encoding="utf-8", errors="ignore") as fh:
        for line in fh:
            line = line.rstrip("\n")
            m = CUE.match(line)
            if m:
                h, mi, s, ms = (int(g) for g in m.groups())
                start = h * 3600 + mi * 60 + s + ms / 1000
                continue
            if not line.strip() or line.startswith(SKIP):
                continue
            text = TAG.sub("", line).strip()
            if not text or text == prev:
                continue
            prev = text
            if start is not None:
                yield start, text


def hms(seconds):
    s = int(seconds)
    return f"{s // 3600}:{s % 3600 // 60:02d}:{s % 60:02d}"


def main():
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument("file", help="path to a .vtt subtitle file")
    ap.add_argument("-b", "--bucket", type=int, default=60,
                    help="seconds of speech per block (default 60)")
    args = ap.parse_args()

    if args.bucket < 1:
        sys.exit("vtt2map.py: --bucket must be at least 1 second")

    buckets, order = {}, []
    for start, text in parse(args.file):
        key = int(start) // args.bucket * args.bucket
        if key not in buckets:
            buckets[key] = []
            order.append(key)
        buckets[key].append(text)

    if not order:
        sys.exit(f"vtt2map.py: no caption cues found in {args.file}")

    for key in order:
        body = re.sub(r"\s+", " ", " ".join(buckets[key])).strip()
        print(f"[{hms(key)}] {body}")


if __name__ == "__main__":
    main()
