cask "font-larsim" do
  version :latest
  sha256 :no_check

  url "https://ifonts.xyz/storage/2021/02/larsim-8370049.zip"
  name "Larsim"
  desc "Outdoors and adventure font"
  homepage "https://ifonts.xyz/larsim-font.html"

  font "Larsim.otf"
  font "Larsim Outline.otf"

  # No zap stanza required
end
