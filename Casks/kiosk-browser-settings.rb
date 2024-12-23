cask "kiosk-browser-settings" do
  version "1.0.0"
  sha256 "ee80f300e7a49cfc3fd51edce13673d13c3d403bb87901581ccdb12811b0b245"

  url "https://github.com/gatewaymedia/kiosk-browser-settings/archive/refs/tags/v#{version}.tar.gz"
  name "Kiosk Browser Settings"
  desc "Settings for Web Kiosk Browser"
  homepage "https://github.com/gatewaymedia/kiosk-browser-settings/"

  depends_on cask: "bevanjkay/tap/kiosk-browser"

  app "Start Hub.app", target: "~/Desktop/Kiosk Browser Commands/Start Hub.app"
  app "Start Giving Kiosk.app", target: "~/Desktop/Kiosk Browser Commands/Start Giving Kiosk.app"
  artifact "hub.command", target: "~/Desktop/Kiosk Browser Commands/hub.command"
  artifact "youth.command", target: "~/Desktop/Kiosk Browser Commands/youth.command"
  artifact "website.command", target: "~/Desktop/Kiosk Browser Commands/website.command"
  artifact "missions-signage.command", target: "~/Desktop/Kiosk Browser Commands/missions-signage.command"
  artifact "giving-kiosk.command", target: "~/Desktop/Kiosk Browser Commands/giving-kiosk.command"
  artifact "hubInject.js", target: "~/Desktop/Kiosk Browser Commands/hubInject.js"
  artifact "youthInject.js", target: "~/Desktop/Kiosk Browser Commands/youthInject.js"

  postflight do
    files = system_command "/bin/ls", args: [staged_path.to_s]
    files_list = files.stdout.split("\n")
    files_list.each do |file|
      system_command "xattr", args: ["-d", "com.apple.quarantine", "#{staged_path}/#{file}"]
      system_command "/bin/chmod", args: ["+x", "#{staged_path}/#{file}"]
    end
  end

  uninstall rmdir: "~/Desktop/Kiosk Browser Commands"
end
