cask "gateway-brewfile-production" do
  version "20250915,02ae53c7040550662a33a517d6f257bd3c62cc93"
  sha256 :no_check

  on_ventura :or_older do
    artifact ".Brewfile-production-legacy", target: "~/.Brewfile"
  end
  on_sonoma :or_newer do
    artifact ".Brewfile-production", target: "~/.Brewfile"
  end

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

  preflight do
    brewfile = Pathname("#{Dir.home}/.Brewfile")

    if brewfile.exist?
      ohai "Backing up existing Brewfile"
      system "mv", "-f", "#{Dir.home}/.Brewfile", "#{Dir.home}/.Brewfile.backup"
    end
  end
end
