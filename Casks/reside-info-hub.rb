cask "reside-info-hub" do
  version "2.0.0"
  sha256 "fb768d7cbff17e36978eb2b2a6b7948e4b9e22343e79f147f656c508bf665bd3"

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
