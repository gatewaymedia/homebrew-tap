cask "gateway-brewfile-kiosk" do
  version :latest
  sha256 :no_check

  url "https://github.com/gatewaymedia/dotfiles.git",
      branch:   "main"
  name "Gateway Production Brewfile"
  homepage "https://github.com/gatewaymedia/dotfiles"

  conflicts_with cask: [
    "gatewaymedia/tap/gateway-brewfile-base",
    "gatewaymedia/tap/gateway-brewfile-production",
  ]

  artifact ".Brewfile-base", target: "~/.Brewfile-base"
  artifact ".Brewfile-kiosk", target: "~/.Brewfile"

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
