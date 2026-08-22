# Managed by scripts/bump.py — the url/sha256 pairs are rewritten from the
# published SHA256SUMS of the latest release. Keep the block shape stable.
class Terakota < Formula
  desc "Read-only CLI and MCP server for AppFolio, QuickBooks, and Dialpad, with receipts"
  homepage "https://terakota.io"
  version "1.7.0"
  license :cannot_represent

  on_macos do
    on_intel do
      url "https://github.com/Terakota-io/terakota/releases/download/v1.7.0/terakota_v1.7.0_darwin_amd64.tar.gz"
      sha256 "854fc5c0ff8410f4bcb8744472420b7cecff95b7c4d534f7ada4ce5bcec6205a"
    end
    on_arm do
      url "https://github.com/Terakota-io/terakota/releases/download/v1.7.0/terakota_v1.7.0_darwin_arm64.tar.gz"
      sha256 "c32704662f89f04862853e8ea1e0f766bbeffb5491996defec5542a3819d6983"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Terakota-io/terakota/releases/download/v1.7.0/terakota_v1.7.0_linux_amd64.tar.gz"
      sha256 "972cd43d7e1ecc4251ee140044a7ce296698feb1e42a66fc312cc8af12a28f83"
    end
    on_arm do
      url "https://github.com/Terakota-io/terakota/releases/download/v1.7.0/terakota_v1.7.0_linux_arm64.tar.gz"
      sha256 "dc7a170deded06e5559dc02ce49d4c0adccd71724e78d938b169d221be8663f9"
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
