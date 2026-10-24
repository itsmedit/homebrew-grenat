class Grenat < Formula
  desc "Agentic programming language: Ruby's syntax, Rust's speed"
  homepage "https://github.com/itsmedit/grenat"
  version "0.1.5"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/itsmedit/grenat/releases/download/v0.1.5/grenat-v0.1.5-aarch64-apple-darwin.tar.gz"
      sha256 "e65651b6861a435328a4a6920f56dd4429eecb2f7ecfcaa5644e265b5871644e"
    end
    on_intel do
      url "https://github.com/itsmedit/grenat/releases/download/v0.1.5/grenat-v0.1.5-x86_64-apple-darwin.tar.gz"
      sha256 "44295eb95f8344b5314a117d9213a420a9f0f0e018d29cfdc35d3844d62d700f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/itsmedit/grenat/releases/download/v0.1.5/grenat-v0.1.5-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d3c6b5516ed8ff52dc1f5672566e3b64676b4d806204f5f3c24ade92e1e869cd"
    end
    on_intel do
      url "https://github.com/itsmedit/grenat/releases/download/v0.1.5/grenat-v0.1.5-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "dadba05856cfac1760326a12be42d26e35a394ceb1b9f35ad544d59d653bd0de"
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
