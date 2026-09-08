# Managed by scripts/bump.py — the url/sha256 pairs are rewritten from the
# published SHA256SUMS of the latest release. Keep the block shape stable.
class Terakota < Formula
  desc "Read-only CLI and MCP server for AppFolio, QuickBooks, and Dialpad, with receipts"
  homepage "https://terakota.io"
  version "1.10.0"
  license :cannot_represent

  on_macos do
    on_intel do
      url "https://github.com/Terakota-io/terakota/releases/download/v1.10.0/terakota_v1.10.0_darwin_amd64.tar.gz"
      sha256 "adc774ee0e49e9e75d1dc10245222a2bd8625fab3ab6073e3642e636b9bd9664"
    end
    on_arm do
      url "https://github.com/Terakota-io/terakota/releases/download/v1.10.0/terakota_v1.10.0_darwin_arm64.tar.gz"
      sha256 "a912012942e93edb751881c8a38f69d477469528f3538cd978deb33d23dd9535"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Terakota-io/terakota/releases/download/v1.10.0/terakota_v1.10.0_linux_amd64.tar.gz"
      sha256 "e63f4d21b6eb1aebbebb37e102410bab5699b27f6541994bab0a7f76a9243581"
    end
    on_arm do
      url "https://github.com/Terakota-io/terakota/releases/download/v1.10.0/terakota_v1.10.0_linux_arm64.tar.gz"
      sha256 "973b41eea4fbd012ddb4492318700263635653ed2780954d64dab918801b5d33"
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
