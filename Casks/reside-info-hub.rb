cask "reside-info-hub" do
  version "2.0.1"
  sha256 "1217acad8f92c6bca7f61cbac1d52cfdab812478d7ec34b1ddae7a8849dd8b8e"

  url "https://github.com/bevanjkay/pake-builder/releases/download/reside-info-hub-#{version}/Reside.Info.Hub.dmg",
      verified: "github.com/bevanjkay/pake-builder/"
  name "Reside Info Hub"
  desc "Desktop application for Reside Info Hub"
  homepage "https://info.reside.church/"

  livecheck do
    url :url
    regex(/reside-info-hub[._-]v?(\d+(?:\.\d+)+)/i)
  end

  depends_on :macos

  app "Reside Info Hub.app"

  postflight do
    system "xattr", "-d", "com.apple.quarantine", "#{staged_path}/Reside Info Hub.app"
  end

  zap trash: "~/Library/Application Support/Reside Info Hub"
end
