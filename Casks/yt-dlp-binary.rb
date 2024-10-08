cask "yt-dlp-binary" do
  version "2024.08.06"
  sha256 "0075722103617a080c5bdeeddc88ff278fd6d07c5af951b7f333dae8405a6caf"

  url "https://github.com/yt-dlp/yt-dlp/releases/download/#{version}/yt-dlp_macos"
  name "yt-dlp"
  desc "Feature-rich command-line audio/video downloader"
  homepage "https://github.com/yt-dlp/yt-dlp"

  binary "yt-dlp_macos", target: "yt-dlp"

  # No zap stanza required
end
