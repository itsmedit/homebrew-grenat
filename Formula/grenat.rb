class Grenat < Formula
  desc "Agentic programming language: Ruby's syntax, Rust's speed"
  homepage "https://github.com/itsmedit/grenat"
  version "0.1.3"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/itsmedit/grenat/releases/download/v0.1.3/grenat-v0.1.3-aarch64-apple-darwin.tar.gz"
      sha256 "119131c50f1588187542f327ea530e5ad88fd07212ca4b0bc273a185ffa084d1"
    end
    on_intel do
      url "https://github.com/itsmedit/grenat/releases/download/v0.1.3/grenat-v0.1.3-x86_64-apple-darwin.tar.gz"
      sha256 "8178ed671081c9f5b3134a17b1f648c2397572e29c222a93349a3913e3cdc4d4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/itsmedit/grenat/releases/download/v0.1.3/grenat-v0.1.3-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "79975ee7e8ce02c3718e6a0f346204509da9ed62c12fe2931a64234bddbbbc78"
    end
    on_intel do
      url "https://github.com/itsmedit/grenat/releases/download/v0.1.3/grenat-v0.1.3-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "f84520f56036790346f04fe8b6cffb8163b049246c577a15eeb28d1024e94938"
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
