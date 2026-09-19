class Blotter < Formula
  desc "Append-only friction ledger for AI agents: log the cuts that got in the way and the findings worth writing up, find what recurs, promote it into durable fixes, and verify the fixes held."
  homepage "https://github.com/BigCactusLabs/blotter"
  version "1.1.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/BigCactusLabs/blotter/releases/download/v1.1.2/blotter-cli-aarch64-apple-darwin.tar.gz"
      sha256 "ff9b7b1b69e816f6ae4cc5f7418a5a688842d787bf5a4ac6957205bb4f571b59"
    end
    if Hardware::CPU.intel?
      url "https://github.com/BigCactusLabs/blotter/releases/download/v1.1.2/blotter-cli-x86_64-apple-darwin.tar.gz"
      sha256 "ea07fb765bfe35a654b33ba2d5ac7a6f94e268fb561606e98698d013bf1ee24d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/BigCactusLabs/blotter/releases/download/v1.1.2/blotter-cli-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "4dca3ee0ad7c74e8e71ed45f203fca69245deb974a3168f90bd11bae2eedad4a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/BigCactusLabs/blotter/releases/download/v1.1.2/blotter-cli-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "cb5ddc1ae0fe53212986bfcf50330a625f10a1a9c7fb063e46f873d8a4c4c43e"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":              {},
    "aarch64-unknown-linux-gnu":         {},
    "x86_64-apple-darwin":               {},
    "x86_64-pc-windows-gnu":             {},
    "x86_64-unknown-linux-gnu":          {},
    "x86_64-unknown-linux-musl-dynamic": {},
    "x86_64-unknown-linux-musl-static":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "blotter"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "blotter"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "blotter"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "blotter"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
