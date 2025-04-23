cask "gateway-dotfiles" do
  version "20250423,c9f5669333a09206da936e433a754fdd7dd11ab1"
  sha256 :no_check

  url "https://github.com/gatewaymedia/dotfiles.git",
      revision: version.csv.second,
      branch:   "main"
  name "Gateway Dotfiles"
  desc "Dotfiles for Gateway Media"
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
  artifact "config.sh", target: "~/.scripts/config.sh"

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

    hyperjs = Pathname("#{Dir.home}/.hyper.js")

    if hyperjs.exist?
      ohai "Backing up existing .hyper.js"
      system "mv", "-f", "#{Dir.home}/.hyper.js", "#{Dir.home}/.hyper.js.backup"
    end
  end

  postflight do
    ohai "Importing Stats preferences"
    system "defaults", "import", "eu.exelban.Stats", "#{staged_path}/.stats.json"
  end

  # No zap stanza required
end
