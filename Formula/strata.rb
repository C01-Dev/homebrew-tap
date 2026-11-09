class Strata < Formula
  desc "One binary: CLI, daemon and MCP server"
  homepage "https://github.com/C01-Dev/Strata"
  version "0.1.4"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/C01-Dev/Strata/releases/download/v0.1.4/strata-aarch64-apple-darwin.tar.xz"
    sha256 "3a20b30700bf8006b2df77a15b5a2ec4e53ed32b2673caf3bad80f6bd7e5564d"
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/C01-Dev/Strata/releases/download/v0.1.4/strata-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b4cb0a7c50cd2a234bc9b23182dae80a6113a998b0be9b9f12ab202a56beb939"
    end
    if Hardware::CPU.intel?
      url "https://github.com/C01-Dev/Strata/releases/download/v0.1.4/strata-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "66d0a4fdd2e84bd012e83b593498b38c81e862548ba7de96eac53deb00ffdd83"
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
