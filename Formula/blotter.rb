class Blotter < Formula
  desc "Append-only friction ledger for AI agents: log the cuts that got in the way and the findings worth writing up, find what recurs, promote it into durable fixes, and verify the fixes held."
  homepage "https://github.com/BigCactusLabs/blotter"
  version "1.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/BigCactusLabs/blotter/releases/download/v1.1.1/blotter-cli-aarch64-apple-darwin.tar.gz"
      sha256 "50179bc34bc7b56cbb42f5b3ae56844ad2cb8bcc3e7920fb252be2c6417ac1dc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/BigCactusLabs/blotter/releases/download/v1.1.1/blotter-cli-x86_64-apple-darwin.tar.gz"
      sha256 "d2924fbe499dba5aebedd24c4cebf1fdfbef09331de251fdc15298db59ce1bcd"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/BigCactusLabs/blotter/releases/download/v1.1.1/blotter-cli-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "04046d9bd3bceb9b9eec4f71eb51c0fb49095d28f58319724b5d3f4667629c50"
    end
    if Hardware::CPU.intel?
      url "https://github.com/BigCactusLabs/blotter/releases/download/v1.1.1/blotter-cli-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b9961e07dce20868ac4d0a23e48cbe2d94245d8c9c919ee8246bd59221d41a83"
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
