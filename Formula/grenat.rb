class Grenat < Formula
  desc "Agentic programming language: Ruby's syntax, Rust's speed"
  homepage "https://github.com/itsmedit/grenat"
  version "0.1.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/itsmedit/grenat/releases/download/v0.1.0/grenat-v0.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "5683073a4f398b699e542a58aacb48d0a4ac5f46f60cd693a7e36dd910c49b2c"
    end
    on_intel do
      url "https://github.com/itsmedit/grenat/releases/download/v0.1.0/grenat-v0.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "a0eb1c134a25a4abec400b71f40a1843a1d46e3c8a161a812c9f19ce443b548b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/itsmedit/grenat/releases/download/v0.1.0/grenat-v0.1.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "897c93358c44919608bbf3e6fbc5dec4e1982be275a2de0b4730c0e03bd07367"
    end
    on_intel do
      url "https://github.com/itsmedit/grenat/releases/download/v0.1.0/grenat-v0.1.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "265141dcb19dfed440839390a404f2c4a0e629ece3b1246462b02dc9e6f6111e"
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
