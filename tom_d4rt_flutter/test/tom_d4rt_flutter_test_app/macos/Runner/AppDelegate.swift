import Cocoa
import FlutterMacOS

@main
class AppDelegate: FlutterAppDelegate {
  /// Held for the whole process lifetime to keep this test harness running at
  /// full speed while it is backgrounded / not the foreground window.
  ///
  /// macOS "App Nap" throttles the run loop, timers, and frame production of an
  /// app it considers idle — which a non-foreground test window is. That
  /// throttling slows the Dart-side forced-frame keep-alive timer (see the test
  /// app's `_startFrameKeepAlive`) down to ~1 Hz or worse and can stall the
  /// HTTP-driven `/build` loop. `beginActivity` with `.userInitiated` disables
  /// App Nap; `.latencyCritical` disables timer coalescing so the keep-alive
  /// timer fires at its full rate; the `idle*SleepDisabled` options keep the
  /// display and system awake so the vsync source that services forced frames
  /// keeps ticking during long unattended runs. The assertion is released
  /// automatically when the process exits.
  ///
  /// Keep in sync with the equivalent AppDelegate in
  /// tom_d4rt_flutter_ast/test/tom_d4rt_flutter_ast_app/macos/Runner.
  private var backgroundStableActivity: NSObjectProtocol?

  override func applicationDidFinishLaunching(_ notification: Notification) {
    backgroundStableActivity = ProcessInfo.processInfo.beginActivity(
      options: [.userInitiated, .latencyCritical,
                .idleSystemSleepDisabled, .idleDisplaySleepDisabled],
      reason: "D4rt Flutter bridge test harness — background-stable HTTP /build loop"
    )
    super.applicationDidFinishLaunching(notification)
  }

  override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
    return true
  }

  override func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
    return true
  }
}
