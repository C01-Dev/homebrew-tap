class Strata < Formula
  desc "One binary: CLI, daemon and MCP server"
  homepage "https://github.com/C01-Dev/Strata"
  version "0.1.2"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/C01-Dev/Strata/releases/download/v0.1.2/strata-aarch64-apple-darwin.tar.xz"
    sha256 "d18655a5b154604cddaabd7dc335b4672a2f715b34181effcd82e8eaeb3adee7"
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/C01-Dev/Strata/releases/download/v0.1.2/strata-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "2d6ebaadf568dc7821c4f761eeab244a813abbf49a62e77abc3a5f7b4686b8cb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/C01-Dev/Strata/releases/download/v0.1.2/strata-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "2bb9f9ee0b14dfa34e98e88a36cd1900a448ba6a1ac44fcca9fd6ae43de7c1cf"
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
