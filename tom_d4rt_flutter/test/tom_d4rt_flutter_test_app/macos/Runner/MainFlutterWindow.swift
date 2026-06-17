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

  // Test-harness window: appear WITHOUT stealing focus from the user's
  // foreground app (e.g. the editor). `flutter run -d macos` triggers a
  // `makeKeyAndOrderFront` at launch, which both raises the window AND makes
  // it the key window of a newly-activated app — yanking focus away. Routing
  // that call to `orderFront` keeps the window visible (so the Flutter engine
  // keeps producing frames — a fully occluded macOS window would stall vsync
  // and hang the HTTP-driven /build loop) but does NOT make it key or activate
  // the app, so the caret stays where the user was typing. The user can still
  // click the window to focus it normally.
  override func makeKeyAndOrderFront(_ sender: Any?) {
    self.orderFront(sender)
  }
}
