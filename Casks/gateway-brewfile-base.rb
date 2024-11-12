cask "gateway-brewfile-base" do
  version "20241112,6066c7882afffdf59336cb77de4c5bd793a73700"
  sha256 :no_check

  on_monterey :or_older do
    artifact ".Brewfile-base-legacy", target: "~/.Brewfile"
  end
  on_ventura :or_newer do
    artifact ".Brewfile-base", target: "~/.Brewfile"
  end

  url "https://github.com/gatewaymedia/dotfiles.git",
      branch:   "main"
  name "Gateway Production Brewfile"
  homepage "https://github.com/gatewaymedia/dotfiles"

  livecheck do
    url "https://api.github.com/repos/gatewaymedia/dotfiles/commits/main"
    strategy :json do |json|
      date = DateTime.parse(json["commit"]["committer"]["date"]).strftime("%Y%m%d")
      "#{date},#{json["sha"]}"
    end
  end

  # Doesn't auto-update but setting this prevents updates initiated by `brew upgrade`
  auto_updates true
  conflicts_with cask: [
    "gatewaymedia/tap/gateway-brewfile-production",
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
