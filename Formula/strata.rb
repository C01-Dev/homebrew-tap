class Strata < Formula
  desc "One binary: CLI, daemon and MCP server"
  homepage "https://github.com/C01-Dev/strata"
  version "0.1.1"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/C01-Dev/strata/releases/download/v0.1.1/strata-aarch64-apple-darwin.tar.xz"
    sha256 "26c00cd59e6ea3cad9569618a1c4d85c237d79a799becb668107ee90f095d778"
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/C01-Dev/strata/releases/download/v0.1.1/strata-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "09c90f273d3014ee384539253ec863842fbb0004f47638423e108a161f251e15"
    end
    if Hardware::CPU.intel?
      url "https://github.com/C01-Dev/strata/releases/download/v0.1.1/strata-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "cbe8233cbcf2dbf2a63f7f1721b314ea1f97c5dda47f210b40916c88c810b173"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-unknown-linux-gnu":  {},
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
      bin.install "strata"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "strata"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "strata"
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
