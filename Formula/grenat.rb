class Grenat < Formula
  desc "Agentic programming language: Ruby's syntax, Rust's speed"
  homepage "https://github.com/itsmedit/grenat"
  version "0.1.4"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/itsmedit/grenat/releases/download/v0.1.4/grenat-v0.1.4-aarch64-apple-darwin.tar.gz"
      sha256 "e106bdfe7f96aa2f6f1f827c396d703e26e54d3cad1833611fb657972cb98b95"
    end
    on_intel do
      url "https://github.com/itsmedit/grenat/releases/download/v0.1.4/grenat-v0.1.4-x86_64-apple-darwin.tar.gz"
      sha256 "1a236301c695379fa0a38b83ac629fecf6d1797f58f09a7bd44aeff641e6c9b2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/itsmedit/grenat/releases/download/v0.1.4/grenat-v0.1.4-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "0c52f76544a82b81fa44bd12e36f2b2f286fd67ec1bd97065e8c88b0d6b53956"
    end
    on_intel do
      url "https://github.com/itsmedit/grenat/releases/download/v0.1.4/grenat-v0.1.4-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c773efee014d009afdbcccceba587600b4f39e6d6c3b5b4802b390330ea638a5"
    end
  end

  def install
    bin.install "bin/grenat", "bin/setter"
    # the runtime libraries `grenat build` links, found next to the binary
    (lib/"grenat").install Dir["lib/grenat/*.a"]
  end

  test do
    (testpath/"hello.grn").write "def main\n  puts \"hello\"\nend\n"
    assert_equal "hello\n", shell_output("#{bin}/grenat run #{testpath}/hello.grn")
    system bin/"grenat", "build", "--native", testpath/"hello.grn", "-o", testpath/"hello"
    assert_equal "hello\n", shell_output(testpath/"hello")
  end
end
