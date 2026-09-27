class Grenat < Formula
  desc "Agentic programming language: Ruby's syntax, Rust's speed"
  homepage "https://github.com/itsmedit/grenat"
  version "0.1.2"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/itsmedit/grenat/releases/download/v0.1.2/grenat-v0.1.2-aarch64-apple-darwin.tar.gz"
      sha256 "6ef473cdb9364b2c67ff67abee9ceee256d547fdabdb0909cef5a1caefa10a78"
    end
    on_intel do
      url "https://github.com/itsmedit/grenat/releases/download/v0.1.2/grenat-v0.1.2-x86_64-apple-darwin.tar.gz"
      sha256 "d38147818bf9e8ac47b33dfb972e4bd189b0270d23dad8d3365c5533a5d66077"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/itsmedit/grenat/releases/download/v0.1.2/grenat-v0.1.2-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "7a2061ca738ad4540c38816c52584a8135a17b60d05ddee7b5cee9adc1ec4f92"
    end
    on_intel do
      url "https://github.com/itsmedit/grenat/releases/download/v0.1.2/grenat-v0.1.2-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "bb0fc5ba3470e0e79bd93d100eb535357a9fa74369114a7c350a11c71a53b093"
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
