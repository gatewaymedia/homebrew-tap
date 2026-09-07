cask "kiosk-browser-settings" do
  version "1.0.0"
  sha256 "ee80f300e7a49cfc3fd51edce13673d13c3d403bb87901581ccdb12811b0b245"

  url "https://github.com/gatewaymedia/kiosk-browser-settings/archive/refs/tags/v#{version}.tar.gz"
  name "Kiosk Browser Settings"
  desc "Settings for Web Kiosk Browser"
  homepage "https://github.com/gatewaymedia/kiosk-browser-settings/"

  depends_on cask: "bevanjkay/tap/kiosk-browser"
  depends_on :macos

  app "Start Hub.app", target: "~/Desktop/Kiosk Browser Commands/Start Hub.app"
  app "Start Giving Kiosk.app", target: "~/Desktop/Kiosk Browser Commands/Start Giving Kiosk.app"
  artifact "hub.command", target: "~/Desktop/Kiosk Browser Commands/hub.command"
  artifact "youth.command", target: "~/Desktop/Kiosk Browser Commands/youth.command"
  artifact "website.command", target: "~/Desktop/Kiosk Browser Commands/website.command"
  artifact "missions-signage.command", target: "~/Desktop/Kiosk Browser Commands/missions-signage.command"
  artifact "giving-kiosk.command", target: "~/Desktop/Kiosk Browser Commands/giving-kiosk.command"
  artifact "hubInject.js", target: "~/Desktop/Kiosk Browser Commands/hubInject.js"
  artifact "youthInject.js", target: "~/Desktop/Kiosk Browser Commands/youthInject.js"

  postflight_steps do
    run "/usr/bin/xattr",
        args:           [
          "-d",
          "com.apple.quarantine",
          "{{staged_path}}/Start Hub.app",
          "{{staged_path}}/Start Giving Kiosk.app",
          "{{staged_path}}/hub.command",
          "{{staged_path}}/youth.command",
          "{{staged_path}}/website.command",
          "{{staged_path}}/missions-signage.command",
          "{{staged_path}}/giving-kiosk.command",
          "{{staged_path}}/hubInject.js",
          "{{staged_path}}/youthInject.js",
        ],
        writable_paths: ["Desktop/Kiosk Browser Commands"],
        writable_base:  :home,
        must_succeed:   false
    set_permissions "Desktop/Kiosk Browser Commands/*.command", "0755", base: :home
  end

  uninstall rmdir: "~/Desktop/Kiosk Browser Commands"
end
