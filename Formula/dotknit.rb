class Dotknit < Formula
  desc "Sync AI coding tool configs, dotfiles, and packages across macOS machines"
  homepage "https://github.com/BigCactusLabs/dotknit"
  url "https://github.com/BigCactusLabs/dotknit/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "a237a76a78ea19525df92dc80a5a982a1e9b477e76a0bc32ced235ea9cb5be02"
  license "MIT"

  depends_on "stow"

  def install
    system "make", "install", "PREFIX=#{prefix}"
  end

  def caveats
    <<~EOS
      For the interactive TUI, run:
        dotknit tui --setup
      Requires Python 3.11+.
    EOS
  end

  test do
    assert_match "dotknit", shell_output("#{bin}/dotknit version")
    assert_match "dotknit init", shell_output("#{bin}/dotknit status 2>&1", 1)
  end
end
