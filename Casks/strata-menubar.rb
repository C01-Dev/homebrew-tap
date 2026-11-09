cask "strata-menubar" do
  version "0.1.4"
  sha256 "fa7246be1780a1486d9217d2bf70e6ec649727fbd6f85c23858c6228c57ace75"

  url "https://github.com/C01-Dev/Strata/releases/download/v#{version}/Strata-macOS.zip"
  name "Strata"
  desc "Menu bar app for Strata: every coding agent's worktree, memory and dev server"
  homepage "https://strata.c01.dev/"

  depends_on arch: :arm64
  depends_on macos: ">= :sonoma"

  app "Strata.app"

  caveats <<~EOS
    Strata.app runs the strata command. Install it too if you have not:
      brew install c01-dev/tap/strata
  EOS
end
