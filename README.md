# Terakota Homebrew tap

Install [`terakota`](https://github.com/Terakota-io/terakota) on macOS or Linux:

```sh
brew install terakota-io/tap/terakota
```

That puts two binaries on your PATH:

- `terakota` — the CLI and MCP server
- `verify-receipts` — the standalone offline receipt-chain verifier

It also installs `EULA.md` and `THIRD_PARTY_NOTICES` under the formula's `doc`
directory (`brew --prefix terakota`/share/doc/terakota).

## What this tap does and does not do

The formula downloads the **official signed release archives** from
`Terakota-io/terakota` and verifies their published SHA-256 checksums. Nothing is
rebuilt here and nothing is modified — the bytes Homebrew installs are the bytes
we published.

To verify the release yourself — cosign signatures, SBOMs, and build provenance —
follow [docs/verify.md](https://github.com/Terakota-io/terakota/blob/main/docs/verify.md)
in the release repo. Homebrew's checksum check is not a substitute for that.

Windows is not served here; Homebrew is macOS and Linux only.

> **QuickBooks is sandbox-only in v1.** QuickBooks Online connections in this
> release run against Intuit **sandbox** companies only. AppFolio reads are
> unaffected. Everything is read-only by construction.

## Staying current

`.github/workflows/bump.yml` runs daily, reads the latest release from the public
release repo, and rewrites the formula's version, URLs, and checksums from that
release's published `SHA256SUMS`. It only ever moves to a `vX.Y.Z` tag.

## License

The formula and scripts in this repo are Terakota packaging metadata. The
binaries they install are governed by the `EULA.md` shipped inside each release
archive; the embedded open-source components are covered by
`THIRD_PARTY_NOTICES`.

We are not affiliated with, endorsed by, or sponsored by AppFolio, Inc. or Intuit
Inc.; their services are governed by your agreements with them.
