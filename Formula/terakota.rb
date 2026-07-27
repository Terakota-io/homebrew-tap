# Managed by scripts/bump.py — the url/sha256 pairs are rewritten from the
# published SHA256SUMS of the latest release. Keep the block shape stable.
class Terakota < Formula
  desc "Read-only CLI and MCP server for AppFolio and QuickBooks, with receipts"
  homepage "https://terakota.io"
  version "1.2.0"
  license :cannot_represent

  on_macos do
    on_intel do
      url "https://github.com/Terakota-io/terakota/releases/download/v1.2.0/terakota_v1.2.0_darwin_amd64.tar.gz"
      sha256 "71c30b65c0f31f4eb5154bcd82b866de43b808e877a18cf568e2fe4eb8ede828"
    end
    on_arm do
      url "https://github.com/Terakota-io/terakota/releases/download/v1.2.0/terakota_v1.2.0_darwin_arm64.tar.gz"
      sha256 "3e90b1d77f4dad057ef0920f4db878f54a84b5338496183c7ae2524d7ae528a7"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Terakota-io/terakota/releases/download/v1.2.0/terakota_v1.2.0_linux_amd64.tar.gz"
      sha256 "c4841ef1739b0b58c11349abd239ed59967efdf07fe8de4874885c220e4398bf"
    end
    on_arm do
      url "https://github.com/Terakota-io/terakota/releases/download/v1.2.0/terakota_v1.2.0_linux_arm64.tar.gz"
      sha256 "280f7c7eb2ad61e61011e0d051c036ac9f70933786bde812a30ab860c22dc414"
    end
  end

  def install
    bin.install "terakota", "verify-receipts"
    doc.install "THIRD_PARTY_NOTICES", "EULA.md"
  end

  def caveats
    <<~EOS
      terakota is read-only by construction and sends nothing to us — no telemetry,
      no account needed. It reads the AppFolio and QuickBooks accounts you already
      run, using credentials you supply.

      QuickBooks is sandbox-only in this release: QuickBooks Online connections run
      against Intuit sandbox companies only. AppFolio reads are unaffected.

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
