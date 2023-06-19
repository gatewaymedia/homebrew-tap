cask "gateway-dotfiles" do
  version "20230619.1"
  sha256 :no_check

  url "https://github.com/gatewaymedia/dotfiles.git",
      branch:   "main"
  name "Gateway Dotfiles"
  homepage "https://github.com/gatewaymedia/dotfiles"

  depends_on cask: ["homebrew/cask-fonts/font-sf-mono",
                    "bevanjkay/tap/zsh-autosuggestions",
                    "bevanjkay/tap/zsh-syntax-highlighting"]

  artifact ".hyper.js", target: "~/.hyper.js"
  artifact ".zshrc", target: "~/.zshrc"

  preflight do
    omz = Pathname("#{Dir.home}/.oh-my-zsh")

    if omz.exist?
      ohai "Oh My Zsh is installed"
    else
      ohai "Installing Oh My Zsh"
      system "sh", "-c", "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    end
  end
end
