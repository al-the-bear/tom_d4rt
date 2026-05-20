import Cocoa
import FlutterMacOS

class MainFlutterWindow: NSWindow {
  override func awakeFromNib() {
    let flutterViewController = FlutterViewController()
    // Override the nib-defined frame with an explicit 1920x1080 size,
    // centred on whichever screen owns the previous frame's origin.
    let screen = self.screen ?? NSScreen.main
    let screenFrame = screen?.visibleFrame ?? self.frame
    let width: CGFloat = 1920
    let height: CGFloat = 1080
    let originX = screenFrame.origin.x + (screenFrame.size.width - width) / 2
    let originY = screenFrame.origin.y + (screenFrame.size.height - height) / 2
    let windowFrame = NSRect(x: originX, y: originY, width: width, height: height)
    self.contentViewController = flutterViewController
    self.setFrame(windowFrame, display: true)

    RegisterGeneratedPlugins(registry: flutterViewController)

    super.awakeFromNib()
  }
}
