cask "gateway-brewfile-base" do
  version :latest
  sha256 :no_check

  url "https://github.com/gatewaymedia/dotfiles.git",
      branch:   "main"
  name "Gateway Production Brewfile"
  homepage "https://github.com/gatewaymedia/dotfiles"

  conflicts_with cask: [
    "gatewaymedia/tap/gateway-brewfile-kiosk",
    "gatewaymedia/tap/gateway-brewfile-production",
  ]

  artifact ".Brewfile-base", target: "~/.Brewfile"

  preflight do
    brewfile = Pathname("#{Dir.home}/.Brewfile")

    if brewfile.exist?
      ohai "Backing up existing Brewfile"
      system "mv", "-f", "#{Dir.home}/.Brewfile", "#{Dir.home}/.Brewfile.backup"
    end
  end
end
