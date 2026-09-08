# Managed by scripts/bump.py — the url/sha256 pairs are rewritten from the
# published SHA256SUMS of the latest release. Keep the block shape stable.
class Terakota < Formula
  desc "Read-only CLI and MCP server for AppFolio, QuickBooks, and Dialpad, with receipts"
  homepage "https://terakota.io"
  version "1.9.0"
  license :cannot_represent

  on_macos do
    on_intel do
      url "https://github.com/Terakota-io/terakota/releases/download/v1.9.0/terakota_v1.9.0_darwin_amd64.tar.gz"
      sha256 "422a62859f75241d790cc645aa32b8daf52fe526c07dd39db7694c19040e9587"
    end
    on_arm do
      url "https://github.com/Terakota-io/terakota/releases/download/v1.9.0/terakota_v1.9.0_darwin_arm64.tar.gz"
      sha256 "f792cb6679249951091802b6f2011d203d2507ddeaf96cb6f404ac01eba02868"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Terakota-io/terakota/releases/download/v1.9.0/terakota_v1.9.0_linux_amd64.tar.gz"
      sha256 "25283afc9ced8a0b9fac67dd306b602ebe6e14846d6f0839f9fe4e6079b93469"
    end
    on_arm do
      url "https://github.com/Terakota-io/terakota/releases/download/v1.9.0/terakota_v1.9.0_linux_arm64.tar.gz"
      sha256 "26718add0a93a79d8f0a0ac4206f2b37778bc663ac40b9a52a51380114f2cb90"
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
