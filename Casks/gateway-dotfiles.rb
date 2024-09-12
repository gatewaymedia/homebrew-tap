cask "gateway-dotfiles" do
  version "20240911,a1373776d9b3c6ccc23b755d2b28bfdd8bb3f348"
  sha256 :no_check

  on_monterey :or_newer do
    depends_on formula: %w[ffmpeg imagemagick mas yt-dlp]
  end
  on_ventura :or_older do
    depends_on formula: ["bevanjkay/formulae/mas-legacy", "bevanjkay/formulae/ffmpeg-legacy", "yt-dlp-binary"]
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
  depends_on cask: [
    "bevanjkay/tap/zsh-autosuggestions",
    "bevanjkay/tap/zsh-syntax-highlighting",
    "font-sf-mono",
    "hyper",
    "stats",
  ]

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
  end

  postflight do
    ohai "Importing Stats preferences"
    system "defaults", "import", "eu.exelban.Stats", "#{staged_path}/.stats.json"
  end
end
