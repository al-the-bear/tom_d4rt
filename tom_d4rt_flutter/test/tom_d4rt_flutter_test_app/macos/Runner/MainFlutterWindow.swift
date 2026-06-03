import Cocoa
import FlutterMacOS

class MainFlutterWindow: NSWindow {
  override func awakeFromNib() {
    let flutterViewController = FlutterViewController()
    self.contentViewController = flutterViewController
    // Override the XIB-defined size with our preferred initial window size
    // (full window frame, title bar included).
    self.setFrame(
      NSRect(origin: self.frame.origin,
             size: NSSize(width: 1920, height: 1440)),
      display: true
    )

    RegisterGeneratedPlugins(registry: flutterViewController)

    super.awakeFromNib()
  }
}
