cask "gateway-fluro-checkin" do
  version "1.0.1"
  sha256 "91390c7de98973b7117e04e48c50e1d8794b796dd0df79e24a9adbf5800e4697"

  url "https://github.com/bevanjkay/pake-builder/releases/download/gateway-fluro-checkin-#{version}/Gateway.Fluro.Checkin.dmg",
      verified: "github.com/bevanjkay/pake-builder/"
  name "Gateway Fluro Checkin"
  desc "Desktop application for Gateway Fluro Checkin"
  homepage "https://gc.org.au/"

  livecheck do
    url :url
    regex(/gateway-fluro-checkin[._-]v?(\d+(?:\.\d+)+)/i)
  end

  app "Gateway Fluro Checkin.app"

  postflight do
    system "xattr", "-d", "com.apple.quarantine", "#{staged_path}/Gateway Fluro Checkin.app"
  end

  zap trash: "~/Library/Application Support/Gateway Fluro Checkin"
end
