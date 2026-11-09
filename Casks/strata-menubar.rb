cask "strata-menubar" do
  version "0.1.3"
  sha256 "7bf71a34a162f653949c56667a2187b019417faef389fd587a9735f93bf44aab"

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
