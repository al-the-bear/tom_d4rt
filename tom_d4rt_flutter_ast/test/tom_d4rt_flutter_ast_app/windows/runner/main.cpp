#include <flutter/dart_project.h>
#include <flutter/flutter_view_controller.h>
#include <windows.h>

#include "flutter_window.h"
#include "utils.h"

// Windows equivalent of the macOS App-Nap suppression (see
// macos/Runner/AppDelegate.swift). Keeps this test harness responsive while it
// runs backgrounded / occluded so the HTTP-driven /build loop does not stall:
//
//  * SetThreadExecutionState(ES_SYSTEM_REQUIRED | ES_DISPLAY_REQUIRED) keeps
//    the system and display awake during long unattended runs so the DWM
//    keeps presenting and the Dart forced-frame keep-alive timer (see the test
//    app's _startFrameKeepAlive) keeps getting serviced.
//  * SetProcessInformation(ProcessPowerThrottling, …) opts the process out of
//    EcoQoS / "Efficiency mode" CPU throttling, which Windows otherwise applies
//    to background processes and which slows timers and frame production.
//
// Both are best-effort: failures (older Windows without ProcessPowerThrottling)
// are ignored — the Dart-side forced-frame keep-alive still degrades
// gracefully. Released implicitly when the process exits.
static void KeepHarnessResponsiveInBackground() {
  ::SetThreadExecutionState(ES_CONTINUOUS | ES_SYSTEM_REQUIRED |
                            ES_DISPLAY_REQUIRED);

  PROCESS_POWER_THROTTLING_STATE power_throttling = {};
  power_throttling.Version = PROCESS_POWER_THROTTLING_CURRENT_VERSION;
  power_throttling.ControlMask = PROCESS_POWER_THROTTLING_EXECUTION_SPEED;
  power_throttling.StateMask = 0;  // 0 = disable execution-speed throttling.
  ::SetProcessInformation(::GetCurrentProcess(), ProcessPowerThrottling,
                          &power_throttling, sizeof(power_throttling));
}

int APIENTRY wWinMain(_In_ HINSTANCE instance, _In_opt_ HINSTANCE prev,
                      _In_ wchar_t *command_line, _In_ int show_command) {
  // Attach to console when present (e.g., 'flutter run') or create a
  // new console when running with a debugger.
  if (!::AttachConsole(ATTACH_PARENT_PROCESS) && ::IsDebuggerPresent()) {
    CreateAndAttachConsole();
  }

  KeepHarnessResponsiveInBackground();

  // Initialize COM, so that it is available for use in the library and/or
  // plugins.
  ::CoInitializeEx(nullptr, COINIT_APARTMENTTHREADED);

  flutter::DartProject project(L"data");

  std::vector<std::string> command_line_arguments =
      GetCommandLineArguments();

  project.set_dart_entrypoint_arguments(std::move(command_line_arguments));

  FlutterWindow window(project);
  Win32Window::Point origin(10, 10);
  Win32Window::Size size(1920, 1440);
  if (!window.Create(L"tom_d4rt_flutter_ast_app", origin, size)) {
    return EXIT_FAILURE;
  }
  window.SetQuitOnClose(true);

  ::MSG msg;
  while (::GetMessage(&msg, nullptr, 0, 0)) {
    ::TranslateMessage(&msg);
    ::DispatchMessage(&msg);
  }

  ::CoUninitialize();
  return EXIT_SUCCESS;
}
