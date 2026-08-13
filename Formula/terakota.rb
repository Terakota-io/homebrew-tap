# Managed by scripts/bump.py — the url/sha256 pairs are rewritten from the
# published SHA256SUMS of the latest release. Keep the block shape stable.
class Terakota < Formula
  desc "Read-only CLI and MCP server for AppFolio, QuickBooks, and Dialpad, with receipts"
  homepage "https://terakota.io"
  version "1.5.0"
  license :cannot_represent

  on_macos do
    on_intel do
      url "https://github.com/Terakota-io/terakota/releases/download/v1.5.0/terakota_v1.5.0_darwin_amd64.tar.gz"
      sha256 "94c16985e451d26c16611a765e320007249399d0599a37db8d442bacc2868145"
    end
    on_arm do
      url "https://github.com/Terakota-io/terakota/releases/download/v1.5.0/terakota_v1.5.0_darwin_arm64.tar.gz"
      sha256 "08685b59758ef35492808032158841414e71f2d4d1620eb33c98e06c626c5ae5"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Terakota-io/terakota/releases/download/v1.5.0/terakota_v1.5.0_linux_amd64.tar.gz"
      sha256 "ecf4f9417ca8429a1ead58e4a6affd20c8f6d1ba9f635754daa97aded5200533"
    end
    on_arm do
      url "https://github.com/Terakota-io/terakota/releases/download/v1.5.0/terakota_v1.5.0_linux_arm64.tar.gz"
      sha256 "58726c735fcf520de2fda1db8c2c807195a1954146731a95b572bc4f43013d20"
    end
  end

  def install
    bin.install "terakota", "verify-receipts"
    doc.install "THIRD_PARTY_NOTICES", "EULA.md"
  end

  def caveats
    <<~EOS
      terakota is read-only by construction, with zero telemetry. It reads the
      AppFolio, QuickBooks, and Dialpad accounts you already run, using
      credentials you supply, and reads always run from your machine to the
      vendor directly.

      AppFolio, Dialpad, local use, and QuickBooks sandbox under your own Intuit
      app need no terakota account and send nothing to us. Connecting a
      PRODUCTION QuickBooks company (from v1.4.0) is the exception: it goes
      through our hosted connect service and a free terakota account.

      Dialpad reads (from v1.5.0) use a BYO API key and are snippet-tier:
      verified against a maintainer-held tenant, not on customer accounts.

      Get started:
        terakota company add --company mybooks --base-url https://api.appfolio.com/api/v0
        terakota credentials set --company mybooks

      The license and the third-party notices are installed at:
        #{doc}
      Or print them any time with `terakota about` and `terakota licenses`.
    EOS
  end

  test do
    assert_match "terakota v#{version}", shell_output("#{bin}/terakota version")
    assert_predicate bin/"verify-receipts", :executable?
  end
end
