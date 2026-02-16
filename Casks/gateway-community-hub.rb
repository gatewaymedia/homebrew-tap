cask "gateway-community-hub" do
  version "1.2.0"
  sha256 "8e9fda77698946e7f5683ae96e5e17a0b5f7b7f58379467c620bff9f7f95bc8d"

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
