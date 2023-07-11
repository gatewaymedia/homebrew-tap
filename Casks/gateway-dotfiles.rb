cask "gateway-dotfiles" do
  version "20230711"
  sha256 :no_check

  url "https://github.com/gatewaymedia/dotfiles.git",
      branch:   "main"
  name "Gateway Dotfiles"
  homepage "https://github.com/gatewaymedia/dotfiles"

  # Doesn't auto-update but setting this prevents updates initiated by `brew upgrade`
  auto_updates true
  depends_on cask:    ["homebrew/cask-fonts/font-sf-mono",
                       "bevanjkay/tap/zsh-autosuggestions",
                       "bevanjkay/tap/zsh-syntax-highlighting",
                       "hyper", "stats"],
             formula: ["mas", "yt-dlp"]

  artifact ".hyper.js", target: "~/.hyper.js"
  artifact ".zshrc", target: "~/.zshrc"
  artifact ".stats.json", target: "~/.stats.json"

  preflight do
    omz = Pathname("#{Dir.home}/.oh-my-zsh/lib/")

    if omz.exist?
      ohai "Oh My Zsh is installed"
      system "omz", "update"
    else
      ohai "Installing Oh My Zsh"
      system "sh -c $(curl -fsSL \"https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh\")"
    end
  end

  postflight do
    ohai "Importing Stats preferences"
    system "defaults", "import", "eu.exelban.Stats", "#{staged_path}/.stats.json"
  end
end
