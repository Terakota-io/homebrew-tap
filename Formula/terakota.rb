# Managed by scripts/bump.py — the url/sha256 pairs are rewritten from the
# published SHA256SUMS of the latest release. Keep the block shape stable.
class Terakota < Formula
  desc "Read-only CLI and MCP server for AppFolio, QuickBooks, and Dialpad, with receipts"
  homepage "https://terakota.io"
  version "1.4.0"
  license :cannot_represent

  on_macos do
    on_intel do
      url "https://github.com/Terakota-io/terakota/releases/download/v1.4.0/terakota_v1.4.0_darwin_amd64.tar.gz"
      sha256 "f09a3a45fb5980781cf44f53aeb3aefb74defd9cc7998e5e08eac06d3e2a2386"
    end
    on_arm do
      url "https://github.com/Terakota-io/terakota/releases/download/v1.4.0/terakota_v1.4.0_darwin_arm64.tar.gz"
      sha256 "78193e9f087c899e6020637792d300c7e6a58be2a80422854587f86dab18ecd5"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Terakota-io/terakota/releases/download/v1.4.0/terakota_v1.4.0_linux_amd64.tar.gz"
      sha256 "1a686533513097c03fc11dfc64615cf7297504df3f8874bfec46ad6e9d78b9ff"
    end
    on_arm do
      url "https://github.com/Terakota-io/terakota/releases/download/v1.4.0/terakota_v1.4.0_linux_arm64.tar.gz"
      sha256 "928504ab56959850dc8b06a16fdc8d90af076302ab3830173e752360d2608dd8"
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
