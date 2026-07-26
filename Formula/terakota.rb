# Managed by scripts/bump.py — the url/sha256 pairs are rewritten from the
# published SHA256SUMS of the latest release. Keep the block shape stable.
class Terakota < Formula
  desc "Read-only CLI and MCP server for AppFolio and QuickBooks, with receipts"
  homepage "https://terakota.io"
  version "1.1.0"
  license :cannot_represent

  on_macos do
    on_intel do
      url "https://github.com/Terakota-io/terakota/releases/download/v1.1.0/terakota_v1.1.0_darwin_amd64.tar.gz"
      sha256 "28bbe4a3c4fb33e4cf2337e18e8b401aa56c26087d98b2e409d482ccdb261476"
    end
    on_arm do
      url "https://github.com/Terakota-io/terakota/releases/download/v1.1.0/terakota_v1.1.0_darwin_arm64.tar.gz"
      sha256 "1e56e8ec2ee9490a49af77bfd97128652ca11f723605d515cd7fe51191ebbe23"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Terakota-io/terakota/releases/download/v1.1.0/terakota_v1.1.0_linux_amd64.tar.gz"
      sha256 "88a9692ad28fc8af74587de1fb903fd735db17ae89bc1d55a9ebdddcb5d50bba"
    end
    on_arm do
      url "https://github.com/Terakota-io/terakota/releases/download/v1.1.0/terakota_v1.1.0_linux_arm64.tar.gz"
      sha256 "91a5ebd312a595166bf2a98146476b1f05fbdad7e0187d8ce98c6b0690580da2"
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
