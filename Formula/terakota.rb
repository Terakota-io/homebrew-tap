# Managed by scripts/bump.py — the url/sha256 pairs are rewritten from the
# published SHA256SUMS of the latest release. Keep the block shape stable.
class Terakota < Formula
  desc "Read-only CLI and MCP server for AppFolio, QuickBooks, and Dialpad, with receipts"
  homepage "https://terakota.io"
  version "1.11.0"
  license :cannot_represent

  on_macos do
    on_intel do
      url "https://github.com/Terakota-io/terakota/releases/download/v1.11.0/terakota_v1.11.0_darwin_amd64.tar.gz"
      sha256 "a93a74a10da4b81835dc2ffef059533034480b4ca0e818cf19c4f4ad3534ac18"
    end
    on_arm do
      url "https://github.com/Terakota-io/terakota/releases/download/v1.11.0/terakota_v1.11.0_darwin_arm64.tar.gz"
      sha256 "e91e83afef03147836b5cb189db330562376890695cd7e4b7132a3918da63476"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Terakota-io/terakota/releases/download/v1.11.0/terakota_v1.11.0_linux_amd64.tar.gz"
      sha256 "10e1a4277c3989b2ec3516b75872403b595c3b8cafa64c46e61b13e519639e04"
    end
    on_arm do
      url "https://github.com/Terakota-io/terakota/releases/download/v1.11.0/terakota_v1.11.0_linux_arm64.tar.gz"
      sha256 "856c4b2660d62f944970cc9017046058a06cb35209d55233e365007a7b4357fa"
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
