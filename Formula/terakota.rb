# Managed by scripts/bump.py — the url/sha256 pairs are rewritten from the
# published SHA256SUMS of the latest release. Keep the block shape stable.
class Terakota < Formula
  desc "Read-only CLI and MCP server for AppFolio and QuickBooks, with receipts"
  homepage "https://terakota.io"
  version "1.2.1"
  license :cannot_represent

  on_macos do
    on_intel do
      url "https://github.com/Terakota-io/terakota/releases/download/v1.2.1/terakota_v1.2.1_darwin_amd64.tar.gz"
      sha256 "54e3c24e1cc5f987731e72899a611af9881d8c1491544d5f7999d6cc68625a28"
    end
    on_arm do
      url "https://github.com/Terakota-io/terakota/releases/download/v1.2.1/terakota_v1.2.1_darwin_arm64.tar.gz"
      sha256 "b18062807db4f1068a2cc955bc130cee04df39e2c9af12320a94b25f0633aedb"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Terakota-io/terakota/releases/download/v1.2.1/terakota_v1.2.1_linux_amd64.tar.gz"
      sha256 "26e919cf98adbd1809e8fffa5d48389117c079a99f3835753d85620abeb2bba3"
    end
    on_arm do
      url "https://github.com/Terakota-io/terakota/releases/download/v1.2.1/terakota_v1.2.1_linux_arm64.tar.gz"
      sha256 "a4f31b41e0c8da8dc68ba34c70b1cfdb9ef87344ec2b4722b323a5ce77ee9c1c"
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
