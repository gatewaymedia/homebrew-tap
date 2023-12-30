cask "gateway-printer-driver" do
  version "7.117.3.0,20759"
  sha256 "7de8a1c118ba1d8182366e3d32281d68137b9307a31300e3e6c5abf905c42041"

  url "https://business.toshiba.com/downloads/KB/f1Ulds/#{version.csv.second}/TOSHIBA_ColorMFP.dmg.gz"
  name "Toshiba ColorMFP Drivers"
  desc "Drivers for Toshiba ColorMFP devices"
  homepage "https://business.toshiba.com/support"

  livecheck do
    url "https://business.toshiba.com/support/downloads/GetDownloads.jsp?model=e-STUDIO3515AC"
    strategy :page_match do |page|
      match = page.match(/"TOSHIBA_ColorMFP.dmg.gz",.*?"id":"(\d+)",.*?"versionName":"(\d+(?:\.\d+)+)",/)
      next if match.blank?

      "#{match[2]},#{match[1]}"
    end
  end

  conflicts_with cask: "toshiba-color-mfp"

  pkg "TOSHIBA ColorMFP.pkg"

  uninstall pkgutil: "com.toshiba.pde.x7.colormfp",
            delete:  [
              "/Library/Printers/PPDs/Contents/Resources/TOSHIBA_ColorMFP*.gz",
              "/Library/Printers/toshiba",
            ]
end
