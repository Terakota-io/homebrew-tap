#!/usr/bin/env python3
"""Rewrite Formula/terakota.rb to the latest terakota release.

Pull, not push: this runs in the tap and reads the public release repo with the
tap's own GITHUB_TOKEN, so the release pipeline needs no cross-repo credential.
Exits 0 with "unchanged" when the formula already matches the latest release.
"""
import json
import os
import pathlib
import re
import sys
import urllib.error
import urllib.request

REPO = "Terakota-io/terakota"
FORMULA = pathlib.Path(__file__).resolve().parent.parent / "Formula" / "terakota.rb"
TARGETS = [("darwin", "amd64"), ("darwin", "arm64"), ("linux", "amd64"), ("linux", "arm64")]

URL_RE = re.compile(r'^(\s*)url "(\S+)/terakota_(v[^_"]+)_(\w+)_(\w+)\.tar\.gz"\s*$')
SHA_RE = re.compile(r'^(\s*)sha256 "[0-9a-f]{64}"\s*$')
VERSION_RE = re.compile(r'^(\s*version ")[^"]+(")\s*$')


def fetch(url, accept="application/vnd.github+json"):
    req = urllib.request.Request(url, headers={"Accept": accept, "User-Agent": "terakota-tap-bump"})
    token = os.environ.get("GITHUB_TOKEN")
    if token:
        req.add_header("Authorization", f"Bearer {token}")
    with urllib.request.urlopen(req, timeout=60) as resp:
        return resp.read()


def latest_release():
    rel = json.loads(fetch(f"https://api.github.com/repos/{REPO}/releases/latest"))
    tag = rel["tag_name"]
    if not re.fullmatch(r"v\d+\.\d+\.\d+", tag):
        sys.exit(f"refusing to bump to non-release tag {tag!r}")
    return tag


def sums_for(tag):
    """Parse the release's published SHA256SUMS into {filename: digest}."""
    body = fetch(
        f"https://github.com/{REPO}/releases/download/{tag}/SHA256SUMS", accept="*/*"
    ).decode()
    out = {}
    for line in body.splitlines():
        parts = line.split()
        if len(parts) == 2:
            out[parts[1]] = parts[0]
    missing = [f"terakota_{tag}_{o}_{a}.tar.gz" for o, a in TARGETS if f"terakota_{tag}_{o}_{a}.tar.gz" not in out]
    if missing:
        sys.exit(f"SHA256SUMS for {tag} is missing: {', '.join(missing)}")
    return out


def rewrite(text, tag, sums):
    lines = text.splitlines(keepends=True)
    out, pending, seen = [], None, set()
    for line in lines:
        if pending is not None:
            m = SHA_RE.match(line)
            if not m:
                sys.exit(f"expected a sha256 line after the url for {pending}, got: {line.strip()!r}")
            out.append(f'{m.group(1)}sha256 "{sums[pending]}"\n')
            pending = None
            continue
        m = URL_RE.match(line)
        if m:
            indent, base, _, os_, arch = m.groups()
            name = f"terakota_{tag}_{os_}_{arch}.tar.gz"
            out.append(f'{indent}url "https://github.com/{REPO}/releases/download/{tag}/{name}"\n')
            pending = name
            seen.add((os_, arch))
            continue
        m = VERSION_RE.match(line)
        if m:
            out.append(f"{m.group(1)}{tag.lstrip('v')}{m.group(2)}\n")
            continue
        out.append(line)
    if pending is not None:
        sys.exit(f"url for {pending} had no sha256 line after it")
    if set(TARGETS) - seen:
        sys.exit(f"formula is missing url blocks for: {sorted(set(TARGETS) - seen)}")
    return "".join(out)


def main():
    tag = latest_release()
    before = FORMULA.read_text()
    after = rewrite(before, tag, sums_for(tag))
    if after == before:
        print(f"unchanged — formula already at {tag}")
        return
    FORMULA.write_text(after)
    print(f"bumped to {tag}")
    if step_output := os.environ.get("GITHUB_OUTPUT"):
        with open(step_output, "a") as fh:
            fh.write(f"tag={tag}\n")


if __name__ == "__main__":
    main()
