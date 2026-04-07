class Dotknit < Formula
  desc "Sync AI coding tool configs, dotfiles, and packages across macOS machines"
  homepage "https://github.com/BigCactusLabs/dotknit"
  url "https://github.com/BigCactusLabs/dotknit/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "e7b1f1f88b4d48d8a59e186cefabc8461cb2fa452caee53b69fabe28eb60fe93"
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
