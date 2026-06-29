#include "my_application.h"

// Background-stability note (Linux):
//
// Linux has no "App Nap" / EcoQoS equivalent of the per-process CPU throttling
// the macOS (macos/Runner/AppDelegate.swift) and Windows
// (windows/runner/main.cpp) runners suppress — the GLib main loop and timers
// run at full rate regardless of focus, so no native opt-out is needed here.
// The remaining concern is frame production for an unmapped/minimized window
// (the GTK frame clock can stop), which the Dart-side forced-frame keep-alive
// already covers (see the test app's _startFrameKeepAlive, which uses
// scheduleForcedFrame). For fully headless / unattended CI runs, launch under a
// virtual display (e.g. `xvfb-run -a flutter test …`) so the compositor keeps
// servicing frames.
int main(int argc, char** argv) {
  g_autoptr(MyApplication) app = my_application_new();
  return g_application_run(G_APPLICATION(app), argc, argv);
}
