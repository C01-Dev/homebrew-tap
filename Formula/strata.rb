class Strata < Formula
  desc "One binary: CLI, daemon and MCP server"
  homepage "https://github.com/C01-Dev/Strata"
  version "0.1.3"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/C01-Dev/Strata/releases/download/v0.1.3/strata-aarch64-apple-darwin.tar.xz"
    sha256 "f80806094c7b09749ee426e00189b0822563dabd738adc1feccae5485cf001cb"
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/C01-Dev/Strata/releases/download/v0.1.3/strata-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "75ffecfba1cb6e1e07497d420e0f29c19aad2f0750d6597de97dbc4ee1f1ee78"
    end
    if Hardware::CPU.intel?
      url "https://github.com/C01-Dev/Strata/releases/download/v0.1.3/strata-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b115b604a51c7a9e973f74996a3e125aadcf33c5a14d681abc25528f94853816"
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
