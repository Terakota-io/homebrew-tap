# Managed by scripts/bump.py — the url/sha256 pairs are rewritten from the
# published SHA256SUMS of the latest release. Keep the block shape stable.
class Terakota < Formula
  desc "Read-only CLI and MCP server for AppFolio and QuickBooks, with receipts"
  homepage "https://terakota.io"
  version "1.3.1"
  license :cannot_represent

  on_macos do
    on_intel do
      url "https://github.com/Terakota-io/terakota/releases/download/v1.3.1/terakota_v1.3.1_darwin_amd64.tar.gz"
      sha256 "fc26eb2dea13717ed576028465460670a24c1e01f3a624bb910d0c65c8ed0cf2"
    end
    on_arm do
      url "https://github.com/Terakota-io/terakota/releases/download/v1.3.1/terakota_v1.3.1_darwin_arm64.tar.gz"
      sha256 "e2d8639be7c856d829301747b5a332ae78a8f9836f14c82f0ec72495c758825e"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Terakota-io/terakota/releases/download/v1.3.1/terakota_v1.3.1_linux_amd64.tar.gz"
      sha256 "10bc5ca2d623dcfcbbb068d2b157263891dd3c8df4d83a953ee714dc1d2a5974"
    end
    on_arm do
      url "https://github.com/Terakota-io/terakota/releases/download/v1.3.1/terakota_v1.3.1_linux_arm64.tar.gz"
      sha256 "feda3b374bebc42693792bc1ea770f04e44d3e2101fea100aeb591f786d3f5fc"
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
