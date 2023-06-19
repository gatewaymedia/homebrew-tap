cask "gateway-dotfiles" do
  version "20230619"
  sha256 :no_check

  url "https://github.com/gatewaymedia/dotfiles.git",
      branch:   "main"
  name "Gateway Dotfiles"
  homepage "https://github.com/gatewaymedia/dotfiles"

  depends_on cask:    "homebrew/cask-fonts/font-sf-mono",
             formula: ["zsh-autosuggestions", "zsh-syntax-highlighting"]

  artifact ".hyper.js", target: "~/.hyper.js"
  artifact ".zshrc", target: "~/.zshrc"
end
