cask "strata-menubar" do
  version "0.1.2"
  sha256 "ff3b68245ac686e411b6791025bb49c871293fb735af73ff6e37240e7a3b4347"

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
