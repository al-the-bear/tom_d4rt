import Cocoa
import FlutterMacOS

class MainFlutterWindow: NSWindow {
  override func awakeFromNib() {
    let flutterViewController = FlutterViewController()
    self.contentViewController = flutterViewController
    // Default window size, consistent across all desktop platforms.
    let windowFrame = NSRect(x: 0, y: 0, width: 1600, height: 1200)
    self.setFrame(windowFrame, display: true)
    self.center()

    RegisterGeneratedPlugins(registry: flutterViewController)

    super.awakeFromNib()
  }
}
