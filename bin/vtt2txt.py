#!/usr/bin/env python3
"""Strip a YouTube .vtt subtitle file down to plain readable text.

Auto-generated subtitles repeat each line as the caption rolls, so a naive
strip produces every sentence three times. Dropping consecutive duplicates
after tag removal is what makes the output readable.
"""
import re
import sys


def clean(path):
    out, prev = [], None
    with open(path, encoding="utf-8", errors="ignore") as fh:
        for line in fh:
            line = line.rstrip("\n")
            if "-->" in line or not line.strip():
                continue
            if line.startswith(("WEBVTT", "Kind:", "Language:", "NOTE")):
                continue
            text = re.sub(r"<[^>]+>", "", line).strip()
            if not text or text == prev:
                continue
            out.append(text)
            prev = text
    return re.sub(r"\s+", " ", " ".join(out))


if __name__ == "__main__":
    if len(sys.argv) != 2:
        sys.exit("usage: vtt2txt.py FILE.vtt")
    print(clean(sys.argv[1]))
