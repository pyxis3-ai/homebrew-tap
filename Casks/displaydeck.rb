cask "displaydeck" do
  version "2.8.5"
  sha256 "6f4742ea2b5b29757f15acbfbe339d507a8aae32a28013ff532853f7e7f4cef3"

  url "https://github.com/pyxis3-ai/displaydeck/releases/download/v#{version}/DisplayDeck.app.zip"
  name "DisplayDeck"
  desc "Menu-bar app for total control of your Mac's displays and windows"
  homepage "https://github.com/pyxis3-ai/displaydeck"

  depends_on macos: :sonoma
  depends_on arch: :arm64

  app "DisplayDeck.app"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/DisplayDeck.app"]
  end

  uninstall quit: "com.local.DisplayDeck"

  zap trash: "~/Library/Preferences/com.local.DisplayDeck.plist"

  caveats <<~CAV
    DisplayDeck is self-signed (not notarized) and built on private APIs.
      - Display / HiDPI / brightness / warmth work out of the box.
      - Window transparency, blur, keep-on-top and the picture-in-picture
        pin need SIP disabled + the -arm64e_preview_abi boot-arg.
      - Picture-in-Picture also needs Accessibility permission.
    On first launch it asks once for an admin password to install its
    scripting addition into Dock.
  CAV
end
