cask "yt-dlp-binary" do
  version "2024.09.27"
  sha256 "e71e8bf6c7fdbfc82e1e637d45b8aae9af49d4575eb19399a364c36c45281c58"

  url "https://github.com/yt-dlp/yt-dlp/releases/download/#{version}/yt-dlp_macos"
  name "yt-dlp"
  desc "Feature-rich command-line audio/video downloader"
  homepage "https://github.com/yt-dlp/yt-dlp"

  binary "yt-dlp_macos", target: "yt-dlp"

  # No zap stanza required
end
