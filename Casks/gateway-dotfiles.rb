cask "gateway-dotfiles" do
  version "20240927,b9635d1cbbfebf3f50c55f5834eb2d7e059c5d25"
  sha256 :no_check

  on_monterey :or_older do
    binary ".Brewfile-legacy", target: "~/.Brewfile"
  end
  on_ventura :or_newer do
    binary ".Brewfile", target: "~/.Brewfile"
  end

  url "https://github.com/gatewaymedia/dotfiles.git",
      branch:   "main"
  name "Gateway Dotfiles"
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

  artifact ".hyper.js", target: "~/.hyper.js"
  artifact ".zshrc", target: "~/.zshrc"
  artifact ".stats.json", target: "~/.stats.json"

  preflight do
    omz = Pathname("#{Dir.home}/.oh-my-zsh/lib/")

    unless omz.exist?
      ohai "Installing Oh My Zsh"
      system "sh -c \"$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)\""
    end

    zshrc = Pathname("#{Dir.home}/.zshrc")

    if zshrc.exist?
      ohai "Backing up existing .zshrc"
      system "mv", "-f", "#{Dir.home}/.zshrc", "#{Dir.home}/.zshrc.backup"
    end

    Pathname("#{Dir.home}/Brewfile")

    if zshrc.exist?
      ohai "Backing up existing Brewfile"
      system "mv", "-f", "#{Dir.home}/Brewfile", "#{Dir.home}/Brewfile.backup"
    end
  end

  postflight do
    ohai "Importing Stats preferences"
    system "defaults", "import", "eu.exelban.Stats", "#{staged_path}/.stats.json"
  end
end
