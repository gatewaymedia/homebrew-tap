cask "gateway-community-hub" do
  version "1.1.1"
  sha256 "0e0d57b1b76b45cf57dd90aeb3f81528f581e100e31a09f2d9b2c7d3a338ab8e"

  url "https://github.com/bevanjkay/pake-builder/releases/download/gateway-community-hub-#{version}/Gateway.Community.Hub.dmg",
      verified: "github.com/bevanjkay/pake-builder/"
  name "Gateway Community Hub"
  desc "Desktop application for Gateway Community Hub"
  homepage "https://hub.gc.org.au/"

  livecheck do
    url :url
    regex(/gateway-community-hub[._-]v?(\d+(?:\.\d+)+)/i)
  end

  app "Gateway Community Hub.app"

  postflight do
    system "xattr", "-d", "com.apple.quarantine", "#{staged_path}/Gateway Community Hub.app"
  end

  zap trash: "~/Library/Application Support/Gateway Community Hub"
end
