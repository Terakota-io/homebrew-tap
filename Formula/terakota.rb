# Managed by scripts/bump.py — the url/sha256 pairs are rewritten from the
# published SHA256SUMS of the latest release. Keep the block shape stable.
class Terakota < Formula
  desc "Read-only CLI and MCP server for AppFolio and QuickBooks, with receipts"
  homepage "https://terakota.io"
  version "1.0.0"
  license :cannot_represent

  on_macos do
    on_intel do
      url "https://github.com/Terakota-io/terakota/releases/download/v1.0.0/terakota_v1.0.0_darwin_amd64.tar.gz"
      sha256 "96eeae687ad8b33ddcaea748558c5a2d29dc232b756c934ddc25571d5415295d"
    end
    on_arm do
      url "https://github.com/Terakota-io/terakota/releases/download/v1.0.0/terakota_v1.0.0_darwin_arm64.tar.gz"
      sha256 "bc0b06c949526f2cbbd3e483e3568f9b726c0c1a079877defd729e89bcedc4a1"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Terakota-io/terakota/releases/download/v1.0.0/terakota_v1.0.0_linux_amd64.tar.gz"
      sha256 "ec952a893dd06a5f51ba54834f0d9b0ff096eb6264d426df7b2453a682e21710"
    end
    on_arm do
      url "https://github.com/Terakota-io/terakota/releases/download/v1.0.0/terakota_v1.0.0_linux_arm64.tar.gz"
      sha256 "d439b4e8ccd08b750c4bac2a300ffab00c66a5aa468f66f9e0b081abf3568222"
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
        terakota company add --company mybooks --base-url https://<yourdomain>.appfolio.com/api/v2
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
