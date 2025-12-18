cask "gateway-community-hub" do
  version "1.0.0"
  sha256 "9a4963d027604d3497c1e262ea083ac50de78d25370120fbc234fdf460ade80e"

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
