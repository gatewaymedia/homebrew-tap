cask "gateway-brewfile-production" do
  version "20260217,b733f7819115c1ef4b50e8a15686969b10abec94"
  sha256 :no_check

  url "https://github.com/gatewaymedia/dotfiles.git",
      branch:   "main"
  name "Gateway Production Brewfile"
  homepage "https://github.com/gatewaymedia/dotfiles"

  livecheck do
    url "https://api.github.com/repos/gatewaymedia/dotfiles/commits?path=.Brewfile-production"
    strategy :json do |json|
      latest_commit = json.first
      date = DateTime.parse(latest_commit["commit"]["committer"]["date"]).strftime("%Y%m%d")
      "#{date},#{latest_commit["sha"]}"
    end
  end

  # Doesn't auto-update but setting this prevents updates initiated by `brew upgrade`
  auto_updates true
  conflicts_with cask: [
    "gatewaymedia/tap/gateway-brewfile-base",
    "gatewaymedia/tap/gateway-brewfile-kiosk",
  ]

  artifact ".Brewfile-base", target: "~/.Brewfile-base"
  artifact ".Brewfile-production", target: "~/.Brewfile"

  preflight do
    brewfile = Pathname("#{Dir.home}/.Brewfile")
    brewfile_base = Pathname("#{Dir.home}/.Brewfile-base")

    if brewfile.exist?
      ohai "Backing up existing Brewfile"
      system "mv", "-f", "#{Dir.home}/.Brewfile", "#{Dir.home}/.Brewfile.backup"
    end

    if brewfile_base.exist?
      ohai "Backing up existing Brewfile-base"
      system "mv", "-f", "#{Dir.home}/.Brewfile-base", "#{Dir.home}/.Brewfile-base.backup"
    end
  end
end
