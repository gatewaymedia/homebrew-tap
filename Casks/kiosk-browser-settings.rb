cask "kiosk-browser-settings" do
  version "1.0.0"
  sha256 "ee80f300e7a49cfc3fd51edce13673d13c3d403bb87901581ccdb12811b0b245"

  url "https://github.com/gatewaymedia/kiosk-browser-settings/archive/refs/tags/v#{version}.tar.gz"
  name "Kiosk Browser Settings"
  desc "Settings for Web Kiosk Browser"
  homepage "https://github.com/gatewaymedia/kiosk-browser-settings/"

  depends_on cask: "bevanjkay/tap/kiosk-browser"
  depends_on :macos

  app "kiosk-browser-settings-#{version}/Start Hub.app", target: "~/Desktop/Kiosk Browser Commands/Start Hub.app"
  app "kiosk-browser-settings-#{version}/Start Giving Kiosk.app", target: "~/Desktop/Kiosk Browser Commands/Start Giving Kiosk.app"
  artifact "kiosk-browser-settings-#{version}/hub.command", target: "~/Desktop/Kiosk Browser Commands/hub.command"
  artifact "kiosk-browser-settings-#{version}/youth.command", target: "~/Desktop/Kiosk Browser Commands/youth.command"
  artifact "kiosk-browser-settings-#{version}/website.command", target: "~/Desktop/Kiosk Browser Commands/website.command"
  artifact "kiosk-browser-settings-#{version}/missions-signage.command", target: "~/Desktop/Kiosk Browser Commands/missions-signage.command"
  artifact "kiosk-browser-settings-#{version}/giving-kiosk.command", target: "~/Desktop/Kiosk Browser Commands/giving-kiosk.command"
  artifact "kiosk-browser-settings-#{version}/hubInject.js", target: "~/Desktop/Kiosk Browser Commands/hubInject.js"
  artifact "kiosk-browser-settings-#{version}/youthInject.js", target: "~/Desktop/Kiosk Browser Commands/youthInject.js"

  postflight_steps do
    run "/usr/bin/xattr",
        args:           [
          "-d",
          "com.apple.quarantine",
          "/Users/{{user}}/Desktop/Kiosk Browser Commands/Start Hub.app",
          "/Users/{{user}}/Desktop/Kiosk Browser Commands/Start Giving Kiosk.app",
          "/Users/{{user}}/Desktop/Kiosk Browser Commands/hub.command",
          "/Users/{{user}}/Desktop/Kiosk Browser Commands/youth.command",
          "/Users/{{user}}/Desktop/Kiosk Browser Commands/website.command",
          "/Users/{{user}}/Desktop/Kiosk Browser Commands/missions-signage.command",
          "/Users/{{user}}/Desktop/Kiosk Browser Commands/giving-kiosk.command",
          "/Users/{{user}}/Desktop/Kiosk Browser Commands/hubInject.js",
          "/Users/{{user}}/Desktop/Kiosk Browser Commands/youthInject.js",
        ],
        writable_paths: ["Desktop/Kiosk Browser Commands"],
        writable_base:  :home,
        must_succeed:   false
    set_permissions "Desktop/Kiosk Browser Commands/*.command", "0755", base: :home
  end

  uninstall rmdir: "~/Desktop/Kiosk Browser Commands"
end
