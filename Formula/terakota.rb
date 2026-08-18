# Managed by scripts/bump.py — the url/sha256 pairs are rewritten from the
# published SHA256SUMS of the latest release. Keep the block shape stable.
class Terakota < Formula
  desc "Read-only CLI and MCP server for AppFolio, QuickBooks, and Dialpad, with receipts"
  homepage "https://terakota.io"
  version "1.6.0"
  license :cannot_represent

  on_macos do
    on_intel do
      url "https://github.com/Terakota-io/terakota/releases/download/v1.6.0/terakota_v1.6.0_darwin_amd64.tar.gz"
      sha256 "188831ad5d622f0285cdd24955b8517eface7600026d69299dc77ed49a67e614"
    end
    on_arm do
      url "https://github.com/Terakota-io/terakota/releases/download/v1.6.0/terakota_v1.6.0_darwin_arm64.tar.gz"
      sha256 "78235fa9b62de1815b5da72817e827fb693483e16a8b9a66df26a45cb4554244"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Terakota-io/terakota/releases/download/v1.6.0/terakota_v1.6.0_linux_amd64.tar.gz"
      sha256 "05b536b9b3fcbd74db2e1e500ca992631c1d973b3b8657c561b6b82acc275a61"
    end
    on_arm do
      url "https://github.com/Terakota-io/terakota/releases/download/v1.6.0/terakota_v1.6.0_linux_arm64.tar.gz"
      sha256 "636069b80516ccb0289e169dabe56c483dee16961995b42d502188efa15fc4d8"
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
