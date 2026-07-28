# Managed by scripts/bump.py — the url/sha256 pairs are rewritten from the
# published SHA256SUMS of the latest release. Keep the block shape stable.
class Terakota < Formula
  desc "Read-only CLI and MCP server for AppFolio and QuickBooks, with receipts"
  homepage "https://terakota.io"
  version "1.3.0"
  license :cannot_represent

  on_macos do
    on_intel do
      url "https://github.com/Terakota-io/terakota/releases/download/v1.3.0/terakota_v1.3.0_darwin_amd64.tar.gz"
      sha256 "6ffb9a3210e6f36000451b52ec9023d5a5038b75f0e5418caac5b0934d16377c"
    end
    on_arm do
      url "https://github.com/Terakota-io/terakota/releases/download/v1.3.0/terakota_v1.3.0_darwin_arm64.tar.gz"
      sha256 "b8573ecf2ccc5fe08dff67299ccf2483947c09d53db1e7fb7fcbfa27aeeb65c2"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Terakota-io/terakota/releases/download/v1.3.0/terakota_v1.3.0_linux_amd64.tar.gz"
      sha256 "f4d95245b168b1e16cf880b78133a9e5caa0aa8ff691f477ad2dc4d357cd0a0d"
    end
    on_arm do
      url "https://github.com/Terakota-io/terakota/releases/download/v1.3.0/terakota_v1.3.0_linux_arm64.tar.gz"
      sha256 "2646b57bc318cec82e8bfa0121d251d6c5cb499a8cf3fd54130c86b6cea3d68a"
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
