# Managed by scripts/bump.py — the url/sha256 pairs are rewritten from the
# published SHA256SUMS of the latest release. Keep the block shape stable.
class Terakota < Formula
  desc "Read-only CLI and MCP server for AppFolio, QuickBooks, and Dialpad, with receipts"
  homepage "https://terakota.io"
  version "1.8.0"
  license :cannot_represent

  on_macos do
    on_intel do
      url "https://github.com/Terakota-io/terakota/releases/download/v1.8.0/terakota_v1.8.0_darwin_amd64.tar.gz"
      sha256 "29bf769730a90c9687821146ac0091e9a8f20c7cf656fedc1e274d663a733b47"
    end
    on_arm do
      url "https://github.com/Terakota-io/terakota/releases/download/v1.8.0/terakota_v1.8.0_darwin_arm64.tar.gz"
      sha256 "935634df200d5e44057a0cb8af82ddee7a99c76309bddbc5171e9bdd592e3155"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Terakota-io/terakota/releases/download/v1.8.0/terakota_v1.8.0_linux_amd64.tar.gz"
      sha256 "2d61d2e115a05d3247ab0005e57b5c8221a1892b25624f464bf80265a0ca3088"
    end
    on_arm do
      url "https://github.com/Terakota-io/terakota/releases/download/v1.8.0/terakota_v1.8.0_linux_arm64.tar.gz"
      sha256 "4d84661f525549ecf6a5b7734d37bae56a06a0771a8494505594ec33f0bf5468"
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
