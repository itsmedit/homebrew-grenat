class Grenat < Formula
  desc "Agentic programming language: Ruby's syntax, Rust's speed"
  homepage "https://github.com/itsmedit/grenat"
  version "0.1.1"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/itsmedit/grenat/releases/download/v0.1.1/grenat-v0.1.1-aarch64-apple-darwin.tar.gz"
      sha256 "d84a80d8f8a1fb76a2a129700f9cdbe7214a5c45bb259ab67307441ab55f4e13"
    end
    on_intel do
      url "https://github.com/itsmedit/grenat/releases/download/v0.1.1/grenat-v0.1.1-x86_64-apple-darwin.tar.gz"
      sha256 "2f01a7787bc871bf81eae385857b46e8f770b9e487db734051a76a28ff502b63"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/itsmedit/grenat/releases/download/v0.1.1/grenat-v0.1.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a4677608d9c96928f5f6ae6239b996862ec9fb3cfc4bd3a6461019a33b6773cb"
    end
    on_intel do
      url "https://github.com/itsmedit/grenat/releases/download/v0.1.1/grenat-v0.1.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6352503d52245e72558fa16d0f77927a5259d30910df39bc031291b83891f4a4"
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
