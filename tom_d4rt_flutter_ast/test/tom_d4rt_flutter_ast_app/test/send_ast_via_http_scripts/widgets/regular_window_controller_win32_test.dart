import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// RegularWindowControllerWin32 – Deep Visual Demo
//
// RegularWindowControllerWin32 is the Windows-specific implementation of
// Flutter's experimental windowing API (flutter/src/widgets/_window.dart).
// It uses the Win32 HWND (window handle) system under the hood, bridging
// Flutter's FlutterViewController to native Win32 window management.
//
// Because the class is @internal / experimental and Windows-only, this demo
// provides a comprehensive educational walkthrough via simulation:
//   • Simulated Win32 window chrome (Windows 11 style)
//   • Win32 architecture diagram (CustomPainter)
//   • Window state machine with ShowWindow commands
//   • Win32 window styles (WS_* bitmask flags)
//   • Windows 11 features: Snap Layouts, Virtual Desktops, DWM
//   • Win32 message gallery (WM_SIZE, WM_MOVE, WM_ACTIVATE, etc.)
//   • Multi-window CreateWindow diagram
//   • Pitfalls and DPI awareness
//   • API cheat sheet
// ---------------------------------------------------------------------------

// ── top-level ValueNotifiers (stateless rule: no StatefulWidget) ──────────

/// Current simulated Win32 window state.
final ValueNotifier<_Win32WindowState> _windowState =
    ValueNotifier<_Win32WindowState>(_Win32WindowState.normal);

/// Whether the Snap Layouts popup is visible.
final ValueNotifier<bool> _snapLayoutVisible =
    ValueNotifier<bool>(false);

/// Selected snap zone index (0-5) or -1 for none.
final ValueNotifier<int> _snapZone = ValueNotifier<int>(-1);

/// Whether the window chrome is focused (active).
final ValueNotifier<bool> _windowFocused = ValueNotifier<bool>(true);

/// Enabled Win32 style flags bitmask simulation (indices into _kWin32Styles).
final ValueNotifier<Set<int>> _enabledStyles =
    ValueNotifier<Set<int>>(<int>{0, 1, 2, 3, 4});

/// Simulated Win32 message event log.
final ValueNotifier<List<_Win32Message>> _messageLog =
    ValueNotifier<List<_Win32Message>>(<_Win32Message>[]);

/// Index of the currently highlighted message in the gallery.
final ValueNotifier<int> _selectedMessage = ValueNotifier<int>(0);

/// Whether the DPI pitfall card is expanded.
final ValueNotifier<bool> _dpiCardExpanded = ValueNotifier<bool>(false);

/// Whether the UAC pitfall card is expanded.
final ValueNotifier<bool> _uacCardExpanded = ValueNotifier<bool>(false);

/// Whether the Windows-only pitfall card is expanded.
final ValueNotifier<bool> _platformCardExpanded = ValueNotifier<bool>(false);

/// Secondary window count (CreateWindow simulation).
final ValueNotifier<int> _secondaryWindowCount = ValueNotifier<int>(1);

/// Current virtual desktop index.
final ValueNotifier<int> _virtualDesktop = ValueNotifier<int>(0);

// ── enums ─────────────────────────────────────────────────────────────────

enum _Win32WindowState { normal, minimized, maximized, fullscreen }

// ── data classes ──────────────────────────────────────────────────────────

class _ShowWindowCmd {
  const _ShowWindowCmd({
    required this.constant,
    required this.value,
    required this.description,
    required this.state,
  });
  final String constant;
  final int value;
  final String description;
  final _Win32WindowState state;
}

class _Win32StyleFlag {
  const _Win32StyleFlag({
    required this.name,
    required this.hex,
    required this.description,
    required this.visual,
  });
  final String name;
  final String hex;
  final String description;
  final String visual;
}

class _Win32Message {
  const _Win32Message({
    required this.name,
    required this.constant,
    required this.wParam,
    required this.lParam,
    required this.description,
    required this.color,
    required this.icon,
  });
  final String name;
  final String constant;
  final String wParam;
  final String lParam;
  final String description;
  final Color color;
  final IconData icon;
}

class _Win32Feature {
  const _Win32Feature({
    required this.title,
    required this.icon,
    required this.color,
    required this.description,
    required this.apiNote,
    required this.flutterNote,
  });
  final String title;
  final IconData icon;
  final Color color;
  final String description;
  final String apiNote;
  final String flutterNote;
}

class _ApiEntry {
  const _ApiEntry({
    required this.signature,
    required this.category,
    required this.description,
  });
  final String signature;
  final String category;
  final String description;
}

class _MultiWindowStep {
  const _MultiWindowStep({
    required this.index,
    required this.title,
    required this.code,
    required this.description,
    required this.color,
  });
  final int index;
  final String title;
  final String code;
  final String description;
  final Color color;
}

class _PitfallCard {
  const _PitfallCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.severity,
    required this.problem,
    required this.solution,
    required this.codeSnippet,
  });
  final String title;
  final IconData icon;
  final Color color;
  final String severity;
  final String problem;
  final String solution;
  final String codeSnippet;
}

// ── static data ───────────────────────────────────────────────────────────

const List<_ShowWindowCmd> _kShowWindowCmds = <_ShowWindowCmd>[
  _ShowWindowCmd(
    constant: 'SW_SHOW',
    value: 5,
    description: 'Activates the window and shows it in its current size/pos',
    state: _Win32WindowState.normal,
  ),
  _ShowWindowCmd(
    constant: 'SW_MINIMIZE',
    value: 6,
    description: 'Minimises the window and activates the next top-level window',
    state: _Win32WindowState.minimized,
  ),
  _ShowWindowCmd(
    constant: 'SW_MAXIMIZE',
    value: 3,
    description: 'Maximises the specified window to fill the working area',
    state: _Win32WindowState.maximized,
  ),
  _ShowWindowCmd(
    constant: 'SW_RESTORE',
    value: 9,
    description: 'Activates and restores a minimised or maximised window',
    state: _Win32WindowState.normal,
  ),
  _ShowWindowCmd(
    constant: 'SW_SHOWFULLSCREEN',
    value: 3,
    description: 'Custom: remove WS_OVERLAPPEDWINDOW + SetWindowPos to cover taskbar',
    state: _Win32WindowState.fullscreen,
  ),
  _ShowWindowCmd(
    constant: 'SW_HIDE',
    value: 0,
    description: 'Hides the window and activates another; does not destroy HWND',
    state: _Win32WindowState.minimized,
  ),
];

const List<_Win32StyleFlag> _kWin32Styles = <_Win32StyleFlag>[
  _Win32StyleFlag(
    name: 'WS_OVERLAPPEDWINDOW',
    hex: '0x00CF0000',
    description: 'Composite: WS_OVERLAPPED | WS_CAPTION | WS_SYSMENU | WS_THICKFRAME | WS_MINIMIZEBOX | WS_MAXIMIZEBOX',
    visual: 'Full title bar, resize, min/max buttons',
  ),
  _Win32StyleFlag(
    name: 'WS_CAPTION',
    hex: '0x00C00000',
    description: 'Gives the window a title bar (includes WS_BORDER)',
    visual: 'Title bar text visible',
  ),
  _Win32StyleFlag(
    name: 'WS_THICKFRAME',
    hex: '0x00040000',
    description: 'Allows user resizing via drag on window border',
    visual: 'Resize handles on edges/corners',
  ),
  _Win32StyleFlag(
    name: 'WS_MINIMIZEBOX',
    hex: '0x00020000',
    description: 'Adds a minimise button to the caption bar',
    visual: 'Minimise (─) button in chrome',
  ),
  _Win32StyleFlag(
    name: 'WS_MAXIMIZEBOX',
    hex: '0x00010000',
    description: 'Adds a maximise button to the caption bar',
    visual: 'Maximise (□) button in chrome',
  ),
  _Win32StyleFlag(
    name: 'WS_SYSMENU',
    hex: '0x00080000',
    description: 'Adds the system menu (right-click title bar context menu)',
    visual: 'Right-click title bar for context menu',
  ),
  _Win32StyleFlag(
    name: 'WS_BORDER',
    hex: '0x00800000',
    description: 'Adds a thin border around the window',
    visual: 'Thin 1px border',
  ),
  _Win32StyleFlag(
    name: 'WS_POPUP',
    hex: '0x80000000',
    description: 'Creates a pop-up window (no title bar by default)',
    visual: 'Borderless floating window',
  ),
];

const List<_Win32Message> _kWin32Messages = <_Win32Message>[
  _Win32Message(
    name: 'WM_SIZE',
    constant: '0x0005',
    wParam: 'SIZE_RESTORED / SIZE_MINIMIZED / SIZE_MAXIMIZED',
    lParam: 'LOWORD=width, HIWORD=height (new client area)',
    description: 'Posted when the window size changes. Flutter uses this to trigger a relayout of the surface. '
        'The new client dimensions are packed into lParam.',
    color: Color(0xFF1565C0),
    icon: Icons.open_in_full,
  ),
  _Win32Message(
    name: 'WM_MOVE',
    constant: '0x0003',
    wParam: '0 (unused)',
    lParam: 'LOWORD=x, HIWORD=y (new position of client area, screen coords)',
    description: 'Posted when the window position changes. Important for multi-monitor DPI handling '
        'as the effective DPI may change when crossing monitor boundaries.',
    color: Color(0xFF2E7D32),
    icon: Icons.drag_indicator,
  ),
  _Win32Message(
    name: 'WM_ACTIVATE',
    constant: '0x0006',
    wParam: 'WA_INACTIVE(0) / WA_ACTIVE(1) / WA_CLICKACTIVE(2)',
    lParam: 'HWND of the other window being activated/deactivated',
    description: 'Sent when the window activation state changes. Flutter updates focus handling '
        'and rendering priority. WA_INACTIVE means the window is losing focus.',
    color: Color(0xFF6A1B9A),
    icon: Icons.window,
  ),
  _Win32Message(
    name: 'WM_CLOSE',
    constant: '0x0010',
    wParam: '0 (unused)',
    lParam: '0 (unused)',
    description: 'Sent when the user clicks the × button or Alt+F4. RegularWindowControllerWin32 '
        'intercepts this to trigger the onCloseRequested callback before calling DestroyWindow.',
    color: Color(0xFFC62828),
    icon: Icons.close,
  ),
  _Win32Message(
    name: 'WM_DESTROY',
    constant: '0x0002',
    wParam: '0 (unused)',
    lParam: '0 (unused)',
    description: 'Posted when the window is being destroyed. PostQuitMessage(0) is typically called '
        'here for the main window. Flutter tears down the FlutterViewController at this point.',
    color: Color(0xFFBF360C),
    icon: Icons.delete_forever,
  ),
  _Win32Message(
    name: 'WM_DPICHANGED',
    constant: '0x02E0',
    wParam: 'LOWORD=new DPI (x), HIWORD=new DPI (y)',
    lParam: 'RECT* suggested new window rect at new DPI',
    description: 'Sent when the effective DPI of the window changes (e.g. moved to a different monitor). '
        'Flutter uses SetWindowPos with the suggested rect to resize and reposition correctly.',
    color: Color(0xFF00695C),
    icon: Icons.monitor,
  ),
  _Win32Message(
    name: 'WM_NCHITTEST',
    constant: '0x0084',
    wParam: '0 (unused)',
    lParam: 'LOWORD=x, HIWORD=y (cursor position, screen coords)',
    description: 'Used to determine which part of the window the cursor is over. Returning HTCAPTION '
        'from non-caption areas allows custom drag regions for borderless windows.',
    color: Color(0xFF37474F),
    icon: Icons.mouse,
  ),
  _Win32Message(
    name: 'WM_ERASEBKGND',
    constant: '0x0014',
    wParam: 'HDC (device context)',
    lParam: '0 (unused)',
    description: 'Flutter typically returns 1 (handled) without erasing, since the compositor '
        'renders directly to the window surface. Prevents flicker during resize.',
    color: Color(0xFF4E342E),
    icon: Icons.format_color_fill,
  ),
];

const List<_Win32Feature> _kWin32Features = <_Win32Feature>[
  _Win32Feature(
    title: 'Snap Layouts',
    icon: Icons.dashboard_customize,
    color: Color(0xFF0078D4),
    description: 'Windows 11 hover the maximise button to reveal zone pickers. '
        'WM_GETMINMAXINFO controls the snapped size. Apps must handle WM_SIZE with SIZE_RESTORED.',
    apiNote: 'No Win32 API; Windows Shell auto-detects WS_MAXIMIZEBOX.\n'
        'DwmSetWindowAttribute(DWMWA_DISALLOW_PEEK) for customisation.',
    flutterNote: 'RegularWindowControllerWin32 exposes onSizeChanged. '
        'Snap zones trigger WM_SIZE → Flutter rebuilds layout.',
  ),
  _Win32Feature(
    title: 'Virtual Desktops',
    icon: Icons.view_quilt,
    color: Color(0xFF107C10),
    description: 'Windows 10+ Virtual Desktops allow grouping windows into separate workspaces. '
        'Each desktop has its own z-order but windows share the same HWND space.',
    apiNote: 'IVirtualDesktop COM interface (undocumented / internal).\n'
        'VirtualDesktopManager::IsWindowOnCurrentVirtualDesktop(HWND, BOOL*)',
    flutterNote: 'No direct Flutter API. Use ffi + CoCreateInstance to query '
        'virtual desktop membership when needed for multi-window coordination.',
  ),
  _Win32Feature(
    title: 'Taskbar Pinning',
    icon: Icons.push_pin,
    color: Color(0xFF6B2D8B),
    description: 'Apps register with the Windows taskbar via ITaskbarList3 COM interface. '
        'Thumbnails, progress overlays, and jump lists are all exposed through this interface.',
    apiNote: 'ITaskbarList3::SetProgressValue(HWND, ULONGLONG, ULONGLONG)\n'
        'ITaskbarList3::SetOverlayIcon(HWND, HICON, LPCWSTR)',
    flutterNote: 'Use package:win32 to access ITaskbarList3. '
        'RegularWindowControllerWin32 provides the HWND needed for these calls.',
  ),
  _Win32Feature(
    title: 'DWM Blur / Acrylic',
    icon: Icons.blur_on,
    color: Color(0xFF005A9E),
    description: 'Desktop Window Manager (DWM) composites all windows. '
        'Acrylic/mica effects use DwmSetWindowAttribute with DWMWA_SYSTEMBACKDROP_TYPE (Win11).',
    apiNote: 'DwmSetWindowAttribute(DWMWA_SYSTEMBACKDROP_TYPE, &backdropType, sizeof(backdropType))\n'
        'DWMSBT_MAINWINDOW → Mica, DWMSBT_TRANSIENTWINDOW → Acrylic',
    flutterNote: 'Set window background to Colors.transparent and use '
        'flutter_acrylic or direct ffi calls with the HWND from RegularWindowControllerWin32.',
  ),
];

const List<_MultiWindowStep> _kMultiWindowSteps = <_MultiWindowStep>[
  _MultiWindowStep(
    index: 1,
    title: 'Call FlutterWindow.create()',
    code: 'final controller = await FlutterWindow.create(\n'
        '  size: const Size(800, 600),\n'
        '  title: "Secondary Window",\n'
        ');',
    description: 'Flutter experimental API wraps Win32 CreateWindowEx internally. '
        'Returns a RegularWindowControllerWin32 (on Windows).',
    color: Color(0xFF1565C0),
  ),
  _MultiWindowStep(
    index: 2,
    title: 'Win32: CreateWindowEx',
    code: 'HWND hWnd = CreateWindowEx(\n'
        '  0, kWindowClassName, L"Secondary",\n'
        '  WS_OVERLAPPEDWINDOW,\n'
        '  CW_USEDEFAULT, CW_USEDEFAULT,\n'
        '  800, 600,\n'
        '  NULL, NULL, hInstance, NULL\n'
        ');',
    description: 'Under the hood, the Flutter embedder calls CreateWindowEx to obtain an HWND. '
        'Each HWND has its own message queue and WndProc.',
    color: Color(0xFF2E7D32),
  ),
  _MultiWindowStep(
    index: 3,
    title: 'Create FlutterViewController',
    code: 'FlutterViewController controller(\n'
        '  project,\n'
        '  size: {800, 600},\n'
        '  parent: hWnd\n'
        ');\n'
        'SetParent(controller.view(), hWnd);',
    description: 'A new FlutterViewController is created for the secondary HWND. '
        'It has its own engine or shares one (isolate-based).',
    color: Color(0xFF6A1B9A),
  ),
  _MultiWindowStep(
    index: 4,
    title: 'ShowWindow + UpdateWindow',
    code: 'ShowWindow(hWnd, SW_SHOW);\n'
        'UpdateWindow(hWnd);',
    description: 'The window becomes visible and receives WM_PAINT. '
        'Flutter begins rendering frames into the HWND surface.',
    color: Color(0xFFC62828),
  ),
  _MultiWindowStep(
    index: 5,
    title: 'Communicate via Isolates',
    code: 'final port = ReceivePort();\n'
        'await Isolate.spawn(\n'
        '  secondWindowEntry,\n'
        '  port.sendPort,\n'
        ');\n'
        'port.listen(handleMessage);',
    description: 'Secondary windows run in separate Dart isolates. '
        'Use SendPort / ReceivePort for bidirectional communication.',
    color: Color(0xFF00695C),
  ),
];

const List<_PitfallCard> _kPitfalls = <_PitfallCard>[
  _PitfallCard(
    title: 'Windows-Only API',
    icon: Icons.warning_amber_rounded,
    color: Color(0xFFF57F17),
    severity: 'Critical',
    problem: 'RegularWindowControllerWin32 and all Win32 HWND calls are compiled '
        'only on Windows. Using them without platform guards causes compile errors '
        'on macOS/Linux.',
    solution: 'Always guard with Platform.isWindows or use conditional imports. '
        'Prefer the abstract RegularWindowController base class API for cross-platform code.',
    codeSnippet: 'import dart:io show Platform;\n\nif (Platform.isWindows) {\n'
        '  // Win32-specific code here\n}',
  ),
  _PitfallCard(
    title: 'DPI Scaling (SetProcessDPIAwareness)',
    icon: Icons.monitor,
    color: Color(0xFF1565C0),
    severity: 'High',
    problem: 'Without declaring DPI awareness, Windows scales your window via bitmap '
        'stretching (DPI virtualisation), causing blurry text and incorrect layout '
        'on high-DPI monitors (4K, Surface, etc.).',
    solution: 'Call SetProcessDpiAwarenessContext(DPI_AWARENESS_CONTEXT_PER_MONITOR_AWARE_V2) '
        'at startup. Handle WM_DPICHANGED to resize/reposition with the suggested RECT. '
        'Flutter embedder does this automatically since Flutter 3.x.',
    codeSnippet: 'SetProcessDpiAwarenessContext(\n'
        '  DPI_AWARENESS_CONTEXT_PER_MONITOR_AWARE_V2\n'
        ');\n\n// In WndProc:\ncase WM_DPICHANGED:\n'
        '  RECT* r = (RECT*)lParam;\n'
        '  SetWindowPos(hWnd, NULL,\n'
        '    r->left, r->top,\n'
        '    r->right-r->left, r->bottom-r->top,\n'
        '    SWP_NOZORDER);',
  ),
  _PitfallCard(
    title: 'Windows Defender / UAC Prompts',
    icon: Icons.security,
    color: Color(0xFFC62828),
    severity: 'Medium',
    problem: 'Unsigned or newly built Flutter apps trigger Windows Defender SmartScreen '
        '"Unknown Publisher" warnings. Code-signing certificates cost money and require '
        'renewal. UAC elevation requests appear if your app manifest requests '
        'requireAdministrator.',
    solution: 'For development: use --allow-unsigned or add an exception. '
        'For release: obtain an EV code-signing certificate. '
        'Keep your manifest at asInvoker unless elevation is truly needed.',
        codeSnippet: '<!-- app.manifest -->\n<requestedPrivileges>\n'
        '  <requestedExecutionLevel\n'
        '    level="asInvoker"\n'
        '    uiAccess="false"/>\n'
        '</requestedPrivileges>',
  ),
  _PitfallCard(
    title: 'WndProc Message Ordering',
    icon: Icons.sort,
    color: Color(0xFF37474F),
    severity: 'Medium',
    problem: 'Win32 messages are not always posted in the expected order. '
        'WM_ACTIVATE arrives before WM_SIZE during maximise. '
        'WM_DESTROY arrives after child windows are already destroyed, so accessing '
        'child HWNDs in WM_DESTROY is unsafe.',
    solution: 'Do cleanup in WM_NCDESTROY (last message sent). '
        'Use PostMessage instead of SendMessage for deferred operations. '
        'Never call DestroyWindow from within WndProc; post a custom message instead.',
    codeSnippet: 'case WM_NCDESTROY:\n'
        '  // Safe: last message ever sent to this HWND\n'
        '  SetWindowLongPtr(hWnd, GWLP_USERDATA, 0);\n'
        '  delete pThis;\n'
        '  return 0;',
  ),
];

const List<_ApiEntry> _kApiEntries = <_ApiEntry>[
  _ApiEntry(
    signature: 'RegularWindowControllerWin32({required FlutterViewController viewController})',
    category: 'Constructor',
    description: 'Wraps an existing FlutterViewController to expose Win32 window management. '
        'The HWND is obtained via viewController.view().',
  ),
  _ApiEntry(
    signature: 'Future<void> setTitle(String title)',
    category: 'Window Properties',
    description: 'Sets the window title via SetWindowText(hWnd, title). '
        'Equivalent to WM_SETTEXT.',
  ),
  _ApiEntry(
    signature: 'Future<void> setSize(Size size)',
    category: 'Window Properties',
    description: 'Resizes the window via SetWindowPos. Triggers WM_SIZE → Flutter relayout.',
  ),
  _ApiEntry(
    signature: 'Future<void> setPosition(Offset position)',
    category: 'Window Properties',
    description: 'Moves the window via SetWindowPos with SWP_NOSIZE. Triggers WM_MOVE.',
  ),
  _ApiEntry(
    signature: 'Future<void> setMinimumSize(Size size)',
    category: 'Window Constraints',
    description: 'Enforced via WM_GETMINMAXINFO. ptMinTrackSize is set to prevent '
        'the window from being resized smaller than the specified size.',
  ),
  _ApiEntry(
    signature: 'Future<void> setMaximumSize(Size size)',
    category: 'Window Constraints',
    description: 'Enforced via WM_GETMINMAXINFO. ptMaxTrackSize is set to prevent '
        'the window from being resized larger than the specified size.',
  ),
  _ApiEntry(
    signature: 'Future<void> show()',
    category: 'Visibility',
    description: 'Calls ShowWindow(hWnd, SW_SHOW). Makes the window visible and active.',
  ),
  _ApiEntry(
    signature: 'Future<void> hide()',
    category: 'Visibility',
    description: 'Calls ShowWindow(hWnd, SW_HIDE). Hides without destroying HWND.',
  ),
  _ApiEntry(
    signature: 'Future<void> minimize()',
    category: 'State',
    description: 'Calls ShowWindow(hWnd, SW_MINIMIZE). Posts WM_SIZE with SIZE_MINIMIZED.',
  ),
  _ApiEntry(
    signature: 'Future<void> maximize()',
    category: 'State',
    description: 'Calls ShowWindow(hWnd, SW_MAXIMIZE). Posts WM_SIZE with SIZE_MAXIMIZED.',
  ),
  _ApiEntry(
    signature: 'Future<void> restore()',
    category: 'State',
    description: 'Calls ShowWindow(hWnd, SW_RESTORE). Returns from minimized or maximized.',
  ),
  _ApiEntry(
    signature: 'Future<void> close()',
    category: 'Lifecycle',
    description: 'Posts WM_CLOSE. If onCloseRequested is null, proceeds to DestroyWindow; '
        'otherwise waits for the callback to confirm closure.',
  ),
  _ApiEntry(
    signature: 'Future<void> destroy()',
    category: 'Lifecycle',
    description: 'Calls DestroyWindow(hWnd) directly, bypassing WM_CLOSE. '
        'Use for programmatic teardown (e.g. app exit).',
  ),
  _ApiEntry(
    signature: 'void Function(CloseRequestedReason)? onCloseRequested',
    category: 'Callbacks',
    description: 'Called when WM_CLOSE is received. Implement to show "unsaved changes?" dialogs. '
        'Call controller.close() to confirm, or do nothing to cancel.',
  ),
  _ApiEntry(
    signature: 'void Function(Size)? onSizeChanged',
    category: 'Callbacks',
    description: 'Called when WM_SIZE is received with the new client area size (logical pixels).',
  ),
  _ApiEntry(
    signature: 'void Function(Offset)? onPositionChanged',
    category: 'Callbacks',
    description: 'Called when WM_MOVE is received with the new top-left position (screen coords).',
  ),
  _ApiEntry(
    signature: 'int get hwnd',
    category: 'Platform Access',
    description: 'Returns the raw HWND (window handle) as an int. '
        'Pass to Win32 FFI calls via win32.HWND.fromAddress(controller.hwnd).',
  ),
];

// ── CustomPainters ─────────────────────────────────────────────────────────

/// Paints the Win32 architecture layered diagram.
class _ArchitecturePainter extends CustomPainter {
  const _ArchitecturePainter({required this.accentColor});
  final Color accentColor;

  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;
    final double layerH = h / 6.0;

    final List<_ArchLayer> layers = <_ArchLayer>[
      _ArchLayer('Flutter Widget Tree', accentColor.withAlpha(220), 0xFF),
      _ArchLayer('Flutter Engine (Impeller / Skia)', accentColor.withAlpha(180), 0xFF),
      _ArchLayer('FlutterViewController', accentColor.withAlpha(150), 0xFF),
      _ArchLayer('RegularWindowControllerWin32 + HWND', accentColor.withAlpha(120), 0xFF),
      _ArchLayer('Win32 Message Loop / WndProc', accentColor.withAlpha(90), 0xFF),
      _ArchLayer('Windows OS (DWM Compositor)', accentColor.withAlpha(60), 0xFF),
    ];

    final Paint boxPaint = Paint()..style = PaintingStyle.fill;
    final Paint borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.white.withAlpha(60)
      ..strokeWidth = 1;
    final Paint arrowPaint = Paint()
      ..color = Colors.white.withAlpha(180)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < layers.length; i++) {
      final double top = i * layerH;
      final Rect rect = Rect.fromLTWH(4, top + 3, w - 8, layerH - 6);
      final RRect rRect = RRect.fromRectAndRadius(rect, const Radius.circular(8));

      boxPaint.color = layers[i].color;
      canvas.drawRRect(rRect, boxPaint);
      canvas.drawRRect(rRect, borderPaint);

      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: layers[i].label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
          ),
        ),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
      );
      tp.layout(maxWidth: w - 16);
      tp.paint(canvas, Offset((w - tp.width) / 2, top + (layerH - tp.height) / 2));

      // Arrow between layers
      if (i < layers.length - 1) {
        final double arrowX = w / 2;
        final double arrowStartY = (i + 1) * layerH - 2;
        final double arrowEndY = arrowStartY + 2;
        const double arrowSize = 4;

        canvas.drawLine(
          Offset(arrowX, arrowStartY - 2),
          Offset(arrowX, arrowEndY + 2),
          arrowPaint,
        );
        final Path arrowHead = Path()
          ..moveTo(arrowX, arrowEndY + 2)
          ..lineTo(arrowX - arrowSize, arrowEndY - arrowSize)
          ..lineTo(arrowX + arrowSize, arrowEndY - arrowSize)
          ..close();
        canvas.drawPath(
          arrowHead,
          Paint()..color = Colors.white.withAlpha(180),
        );
      }
    }

    // HWND bridge annotation
    final TextPainter htp = TextPainter(
      text: const TextSpan(
        text: 'HWND Bridge',
        style: TextStyle(
          color: Colors.amber,
          fontSize: 9,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    htp.layout();
    htp.paint(canvas, Offset(w - htp.width - 8, 3.5 * layerH - htp.height / 2));
  }

  @override
  bool shouldRepaint(_ArchitecturePainter oldDelegate) =>
      oldDelegate.accentColor != accentColor;
}

class _ArchLayer {
  const _ArchLayer(this.label, this.color, int _);
  final String label;
  final Color color;
}

/// Paints a simulated Windows 11 Snap Layouts overlay grid.
class _SnapLayoutPainter extends CustomPainter {
  const _SnapLayoutPainter({required this.selectedZone, required this.accentColor});
  final int selectedZone;
  final Color accentColor;

  @override
  void paint(Canvas canvas, Size size) {
    const double pad = 4;
    const double gap = 3;
    final double w = size.width - pad * 2;
    final double h = size.height - pad * 2;

    final List<Rect> zones = <Rect>[
      Rect.fromLTWH(pad, pad, w / 2 - gap / 2, h / 2 - gap / 2),
      Rect.fromLTWH(pad + w / 2 + gap / 2, pad, w / 2 - gap / 2, h / 2 - gap / 2),
      Rect.fromLTWH(pad, pad + h / 2 + gap / 2, w / 3 - gap, h / 2 - gap / 2),
      Rect.fromLTWH(pad + w / 3 + gap / 2, pad + h / 2 + gap / 2, w / 3 - gap, h / 2 - gap / 2),
      Rect.fromLTWH(pad + 2 * (w / 3 + gap / 2), pad + h / 2 + gap / 2, w / 3 - gap, h / 2 - gap / 2),
      Rect.fromLTWH(pad, pad, w, h),
    ];

    for (int i = 0; i < zones.length && i < 5; i++) {
      final bool selected = i == selectedZone;
      final RRect rr = RRect.fromRectAndRadius(zones[i], const Radius.circular(3));
      canvas.drawRRect(
        rr,
        Paint()
          ..color = selected
              ? accentColor.withAlpha(200)
              : Colors.white.withAlpha(30),
      );
      canvas.drawRRect(
        rr,
        Paint()
          ..color = Colors.white.withAlpha(60)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 0.5,
      );
    }
  }

  @override
  bool shouldRepaint(_SnapLayoutPainter oldDelegate) =>
      oldDelegate.selectedZone != selectedZone ||
      oldDelegate.accentColor != accentColor;
}

// ── section widgets (all stateless, using ValueListenableBuilder) ──────────

/// Hero banner.
Widget _buildHeroBanner(BuildContext context) {
  final ColorScheme cs = Theme.of(context).colorScheme;
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          cs.primary,
          cs.secondary,
          cs.tertiary,
        ],
      ),
      borderRadius: BorderRadius.circular(20),
    ),
    padding: const EdgeInsets.all(28),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(30),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(Icons.window, color: Colors.white, size: 32),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'RegularWindowControllerWin32',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Windows Desktop Window Management in Flutter',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white.withAlpha(200),
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: <Widget>[
            _heroBadge('Win32 HWND Bridging', Icons.link),
            _heroBadge('Windows 11', Icons.computer),
            _heroBadge('FlutterViewController', Icons.layers),
            _heroBadge('Experimental API', Icons.science),
            _heroBadge('DPI Awareness', Icons.monitor),
          ],
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.black.withAlpha(50),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Text(
            'RegularWindowControllerWin32 is the Windows-specific implementation of '
            'Flutter\'s experimental multi-window API. It wraps a native Win32 HWND '
            '(window handle) and exposes Dart-friendly APIs for window lifecycle, '
            'sizing, positioning, and event handling. Under the hood it bridges the '
            'Flutter engine\'s FlutterViewController to the Win32 message loop via a '
            'custom WndProc, enabling full desktop window management from pure Dart.',
            style: TextStyle(color: Colors.white, height: 1.5),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: <Widget>[
            _infoChip(Icons.source, 'flutter/src/widgets/_window.dart'),
            const SizedBox(width: 8),
            _infoChip(Icons.warning_amber, '@internal / experimental'),
          ],
        ),
      ],
    ),
  );
}

Widget _heroBadge(String label, IconData icon) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: Colors.white.withAlpha(30),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.white.withAlpha(60)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(icon, color: Colors.white, size: 13),
        const SizedBox(width: 5),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 11)),
      ],
    ),
  );
}

Widget _infoChip(IconData icon, String label) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Icon(icon, color: Colors.white.withAlpha(180), size: 13),
      const SizedBox(width: 4),
      Text(label,
          style: TextStyle(color: Colors.white.withAlpha(180), fontSize: 11)),
    ],
  );
}

// ── Tab 2: Simulated Win32 Window Chrome ──────────────────────────────────

Widget _buildWindowChrome(BuildContext context) {
  final ColorScheme cs = Theme.of(context).colorScheme;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _sectionHeader(context, 'Simulated Win32 Window Chrome',
          'Flutter-drawn Windows 11 title bar with interactive controls'),
      const SizedBox(height: 16),
      ValueListenableBuilder<bool>(
        valueListenable: _windowFocused,
        builder: (BuildContext ctx, bool focused, Widget? _) {
          return ValueListenableBuilder<_Win32WindowState>(
            valueListenable: _windowState,
            builder: (BuildContext ctx2, _Win32WindowState state, Widget? _) {
              return ValueListenableBuilder<bool>(
                valueListenable: _snapLayoutVisible,
                builder: (BuildContext ctx3, bool snapVisible, Widget? _) {
                  return ValueListenableBuilder<int>(
                    valueListenable: _snapZone,
                    builder: (BuildContext ctx4, int snapZoneIdx, Widget? _) {
                      return _win32ChromeWidget(
                        focused: focused,
                        state: state,
                        snapVisible: snapVisible,
                        snapZoneIdx: snapZoneIdx,
                        accentColor: cs.primary,
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
      const SizedBox(height: 16),
      _labeledRow('Window Focus:', _focusToggle(context, cs)),
      const SizedBox(height: 8),
      _labeledRow('Window State:', _stateIndicator(context, cs)),
      const SizedBox(height: 16),
      _chromeLegend(context, cs),
    ],
  );
}

Widget _win32ChromeWidget({
  required bool focused,
  required _Win32WindowState state,
  required bool snapVisible,
  required int snapZoneIdx,
  required Color accentColor,
}) {
  final Color titleBarBg =
      focused ? const Color(0xFF202020) : const Color(0xFF2D2D2D);
  final Color titleBarText =
      focused ? Colors.white : Colors.white.withAlpha(130);
  final Color borderColor =
      focused ? accentColor.withAlpha(180) : Colors.white.withAlpha(30);

  String titleBarStateLabel = '';
  if (state == _Win32WindowState.minimized) titleBarStateLabel = ' [Minimized]';
  if (state == _Win32WindowState.maximized) titleBarStateLabel = ' [Maximized]';
  if (state == _Win32WindowState.fullscreen) titleBarStateLabel = ' [Full Screen]';

  return Container(
    decoration: BoxDecoration(
      border: Border.all(color: borderColor, width: 1.5),
      borderRadius: BorderRadius.circular(state == _Win32WindowState.maximized ? 0 : 10),
      boxShadow: focused
          ? <BoxShadow>[
              BoxShadow(
                color: accentColor.withAlpha(40),
                blurRadius: 20,
                spreadRadius: 2,
              )
            ]
          : null,
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(state == _Win32WindowState.maximized ? 0 : 9),
      child: Column(
        children: <Widget>[
          // Title bar
          Container(
            height: 32,
            color: titleBarBg,
            child: Row(
              children: <Widget>[
                const SizedBox(width: 12),
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: accentColor.withAlpha(focused ? 255 : 80),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'My Flutter App — Windows Desktop$titleBarStateLabel',
                    style: TextStyle(
                      color: titleBarText,
                      fontSize: 11,
                      fontWeight: focused ? FontWeight.w500 : FontWeight.normal,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                // Snap layouts button (Windows 11)
                _chromeHoverButton(
                  onPressed: () => _snapLayoutVisible.value = !_snapLayoutVisible.value,
                  icon: Icons.dashboard_customize_outlined,
                  tooltip: 'Snap Layouts',
                  color: titleBarText,
                  hoverColor: const Color(0xFF404040),
                ),
                // Min button
                _chromeHoverButton(
                  onPressed: () {
                    _windowState.value = _Win32WindowState.minimized;
                    _snapLayoutVisible.value = false;
                  },
                  icon: Icons.remove,
                  tooltip: 'Minimize (SW_MINIMIZE)',
                  color: titleBarText,
                  hoverColor: const Color(0xFF404040),
                ),
                // Max / Restore button
                _chromeHoverButton(
                  onPressed: () {
                    if (_windowState.value == _Win32WindowState.maximized) {
                      _windowState.value = _Win32WindowState.normal;
                    } else {
                      _windowState.value = _Win32WindowState.maximized;
                    }
                    _snapLayoutVisible.value = false;
                  },
                  icon: state == _Win32WindowState.maximized
                      ? Icons.filter_none
                      : Icons.crop_square,
                  tooltip: state == _Win32WindowState.maximized
                      ? 'Restore (SW_RESTORE)'
                      : 'Maximize (SW_MAXIMIZE)',
                  color: titleBarText,
                  hoverColor: const Color(0xFF404040),
                ),
                // Close button
                _chromeHoverButton(
                  onPressed: () {
                    _windowState.value = _Win32WindowState.normal;
                    _snapLayoutVisible.value = false;
                  },
                  icon: Icons.close,
                  tooltip: 'Close (WM_CLOSE)',
                  color: Colors.white,
                  hoverColor: const Color(0xFFC42B1C),
                ),
              ],
            ),
          ),
          // Snap layouts popup overlay
          if (snapVisible)
            Container(
              height: 80,
              color: const Color(0xFF2D2D2D),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Snap Zones:',
                    style: TextStyle(color: Colors.white70, fontSize: 10),
                  ),
                  const SizedBox(width: 8),
                  ...List<Widget>.generate(5, (int i) {
                    return GestureDetector(
                      onTap: () {
                        _snapZone.value = i;
                        _snapLayoutVisible.value = false;
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        decoration: BoxDecoration(
                          color: snapZoneIdx == i
                              ? accentColor.withAlpha(180)
                              : Colors.white.withAlpha(20),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: Colors.white.withAlpha(40),
                          ),
                        ),
                        child: CustomPaint(
                          painter: _SnapLayoutPainter(
                            selectedZone: snapZoneIdx == i ? i : -1,
                            accentColor: accentColor,
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          // Window client area
          Container(
            height: state == _Win32WindowState.minimized ? 0 : 120,
            color: const Color(0xFF1E1E1E),
            child: state == _Win32WindowState.minimized
                ? null
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.flutter_dash,
                            color: accentColor.withAlpha(180), size: 40),
                        const SizedBox(height: 8),
                        Text(
                          'Flutter renders here via FlutterViewController',
                          style: TextStyle(
                            color: Colors.white.withAlpha(130),
                            fontSize: 11,
                          ),
                        ),
                        if (snapZoneIdx >= 0) ...<Widget>[
                          const SizedBox(height: 4),
                          Text(
                            'Snap Zone ${snapZoneIdx + 1} selected',
                            style: TextStyle(
                              color: accentColor,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
          ),
        ],
      ),
    ),
  );
}

Widget _chromeHoverButton({
  required VoidCallback onPressed,
  required IconData icon,
  required String tooltip,
  required Color color,
  required Color hoverColor,
}) {
  return Tooltip(
    message: tooltip,
    child: InkWell(
      onTap: onPressed,
      hoverColor: hoverColor,
      child: SizedBox(
        width: 40,
        height: 32,
        child: Icon(icon, color: color, size: 14),
      ),
    ),
  );
}

Widget _focusToggle(BuildContext context, ColorScheme cs) {
  return ValueListenableBuilder<bool>(
    valueListenable: _windowFocused,
    builder: (BuildContext ctx, bool focused, Widget? _) {
      return Row(
        children: <Widget>[
          Switch(
            value: focused,
            onChanged: (bool v) => _windowFocused.value = v,
            activeThumbColor: cs.primary,
          ),
          const SizedBox(width: 8),
          Text(
            focused ? 'Active (WA_ACTIVE)' : 'Inactive (WA_INACTIVE)',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      );
    },
  );
}

Widget _stateIndicator(BuildContext context, ColorScheme cs) {
  return ValueListenableBuilder<_Win32WindowState>(
    valueListenable: _windowState,
    builder: (BuildContext ctx, _Win32WindowState state, Widget? _) {
      final String label = state.name.toUpperCase();
      final Color color = switch (state) {
        _Win32WindowState.normal => cs.primary,
        _Win32WindowState.minimized => cs.secondary,
        _Win32WindowState.maximized => cs.tertiary,
        _Win32WindowState.fullscreen => Colors.deepOrange,
      };
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: color.withAlpha(30),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withAlpha(100)),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      );
    },
  );
}

Widget _chromeLegend(BuildContext context, ColorScheme cs) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: cs.surfaceContainerHighest.withAlpha(80),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Windows 11 Chrome Notes',
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        _legendRow('Rounded corners', 'DwmSetWindowAttribute(DWMWA_WINDOW_CORNER_PREFERENCE) — Win11 only'),
        _legendRow('Snap Layouts button', 'Auto-shown on WS_MAXIMIZEBOX — no API call needed'),
        _legendRow('Active border glow', 'DWM compositor effect, controlled by theme colour'),
        _legendRow('Mica background', 'DWMWA_SYSTEMBACKDROP_TYPE = DWMSBT_MAINWINDOW'),
        _legendRow('Close button red hover', 'Shell-level styling, not programmable'),
      ],
    ),
  );
}

Widget _legendRow(String term, String value) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Icon(Icons.arrow_right, size: 16),
        const SizedBox(width: 4),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 12, color: Colors.black87),
              children: <TextSpan>[
                TextSpan(
                  text: '$term: ',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: value),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

// ── Tab 3: Architecture Diagram ───────────────────────────────────────────

Widget _buildArchitectureDiagram(BuildContext context) {
  final ColorScheme cs = Theme.of(context).colorScheme;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _sectionHeader(context, 'Win32 Architecture Diagram',
          'Flutter → FlutterViewController → HWND → Win32 message loop → WndProc'),
      const SizedBox(height: 16),
      Container(
        height: 360,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[cs.primary.withAlpha(200), cs.surface],
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: CustomPaint(
          painter: _ArchitecturePainter(accentColor: cs.primary),
          child: const SizedBox.expand(),
        ),
      ),
      const SizedBox(height: 16),
      _archCallFlow(context, cs),
    ],
  );
}

Widget _archCallFlow(BuildContext context, ColorScheme cs) {
  final List<(IconData, String, String)> steps = <(IconData, String, String)>[
    (Icons.widgets, 'Widget', 'FlutterWindow.create() / controller.setTitle()'),
    (Icons.layers, 'Engine', 'Routes call through platform channel to embedder'),
    (Icons.memory, 'Embedder', 'FlutterViewController dispatches to Win32 HWND'),
    (Icons.window, 'HWND', 'SetWindowText / ShowWindow / SetWindowPos'),
    (Icons.loop, 'WndProc', 'Intercepts WM_SIZE, WM_MOVE, WM_CLOSE → Dart callback'),
    (Icons.desktop_windows, 'DWM', 'Composites result to screen'),
  ];
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: cs.surfaceContainerHighest.withAlpha(80),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Call Flow',
          style: Theme.of(context)
              .textTheme
              .labelMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        ...steps.asMap().entries.map((MapEntry<int, (IconData, String, String)> e) {
          final int i = e.key;
          final (IconData icon, String label, String desc) = e.value;
          return Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              children: <Widget>[
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: cs.primary.withAlpha(30),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, size: 15, color: cs.primary),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 90,
                  child: Text(
                    '${i + 1}. $label',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
                Expanded(
                  child: Text(
                    desc,
                    style: const TextStyle(fontSize: 11),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    ),
  );
}

// ── Tab 4: Window State Machine ───────────────────────────────────────────

Widget _buildStateMachine(BuildContext context) {
  final ColorScheme cs = Theme.of(context).colorScheme;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _sectionHeader(context, 'Win32 Window State Machine',
          'ShowWindow commands and state transitions'),
      const SizedBox(height: 16),
      ValueListenableBuilder<_Win32WindowState>(
        valueListenable: _windowState,
        builder: (BuildContext ctx, _Win32WindowState state, Widget? _) {
          return Column(
            children: <Widget>[
              _stateDisplay(context, cs, state),
              const SizedBox(height: 16),
              _showWindowButtons(context, cs, state),
              const SizedBox(height: 16),
              _showWindowTable(context, cs, state),
            ],
          );
        },
      ),
    ],
  );
}

Widget _stateDisplay(
    BuildContext context, ColorScheme cs, _Win32WindowState state) {
  final Map<_Win32WindowState, (IconData, String, Color)> stateInfo =
      <_Win32WindowState, (IconData, String, Color)>{
    _Win32WindowState.normal: (Icons.window, 'NORMAL', cs.primary),
    _Win32WindowState.minimized: (Icons.minimize, 'MINIMIZED', cs.secondary),
    _Win32WindowState.maximized: (Icons.crop_square, 'MAXIMIZED', cs.tertiary),
    _Win32WindowState.fullscreen: (Icons.fullscreen, 'FULLSCREEN', Colors.deepOrange),
  };
  final (IconData icon, String label, Color color) = stateInfo[state]!;

  return Container(
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[color.withAlpha(40), color.withAlpha(10)],
      ),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: color.withAlpha(80)),
    ),
    child: Row(
      children: <Widget>[
        Icon(icon, size: 48, color: color),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Current State: $label',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: color,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                _stateDescription(state),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

String _stateDescription(_Win32WindowState s) => switch (s) {
      _Win32WindowState.normal =>
        'Window is visible and interactive at its normal size. HWND is shown.',
      _Win32WindowState.minimized =>
        'Window collapsed to taskbar. HWND still exists. WM_SIZE posted with SIZE_MINIMIZED.',
      _Win32WindowState.maximized =>
        'Window fills the working area (minus taskbar). WM_SIZE with SIZE_MAXIMIZED.',
      _Win32WindowState.fullscreen =>
        'WS_OVERLAPPEDWINDOW removed + SetWindowPos covers taskbar. Covers entire screen.',
    };

Widget _showWindowButtons(
    BuildContext context, ColorScheme cs, _Win32WindowState state) {
  return Wrap(
    spacing: 8,
    runSpacing: 8,
    children: _kShowWindowCmds.map((_ShowWindowCmd cmd) {
      final bool isActive = cmd.state == state;
      return ElevatedButton.icon(
        onPressed: () {
          _windowState.value = cmd.state;
          _logMessage(cmd.constant, '0x${cmd.value.toRadixString(16).padLeft(4, '0')}',
              '0x0000', cmd.description);
        },
        icon: Icon(
          isActive ? Icons.radio_button_checked : Icons.radio_button_unchecked,
          size: 16,
        ),
        label: Text(cmd.constant, style: const TextStyle(fontSize: 11)),
        style: ElevatedButton.styleFrom(
          backgroundColor: isActive ? cs.primary : null,
          foregroundColor: isActive ? cs.onPrimary : null,
        ),
      );
    }).toList(),
  );
}

Widget _showWindowTable(
    BuildContext context, ColorScheme cs, _Win32WindowState currentState) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: cs.outlineVariant),
    ),
    child: Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: cs.surfaceContainerHighest,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
          ),
          child: const Row(
            children: <Widget>[
              SizedBox(width: 150, child: Text('Command', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
              SizedBox(width: 60, child: Text('nCmd', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
              Expanded(child: Text('Description', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
            ],
          ),
        ),
        ..._kShowWindowCmds.map((_ShowWindowCmd cmd) {
          final bool active = cmd.state == currentState;
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            color: active ? cs.primary.withAlpha(20) : null,
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 150,
                  child: Text(
                    cmd.constant,
                    style: TextStyle(
                      fontSize: 11,
                      fontFamily: 'monospace',
                      fontWeight:
                          active ? FontWeight.bold : FontWeight.normal,
                      color: active ? cs.primary : null,
                    ),
                  ),
                ),
                SizedBox(
                  width: 60,
                  child: Text(
                    '${cmd.value}',
                    style: const TextStyle(fontSize: 11, fontFamily: 'monospace'),
                  ),
                ),
                Expanded(
                  child: Text(
                    cmd.description,
                    style: const TextStyle(fontSize: 11),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    ),
  );
}

// ── Tab 5: Win32 Window Styles ─────────────────────────────────────────────

Widget _buildWindowStyles(BuildContext context) {
  final ColorScheme cs = Theme.of(context).colorScheme;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _sectionHeader(context, 'Win32 Window Styles',
          'WS_* bitmask flags — toggle to see effect on simulated chrome'),
      const SizedBox(height: 16),
      ValueListenableBuilder<Set<int>>(
        valueListenable: _enabledStyles,
        builder: (BuildContext ctx, Set<int> enabled, Widget? _) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _stylePreview(context, cs, enabled),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: List<Widget>.generate(
                    _kWin32Styles.length, (int i) {
                  final _Win32StyleFlag flag = _kWin32Styles[i];
                  final bool on = enabled.contains(i);
                  return FilterChip(
                    selected: on,
                    label: Text(flag.name,
                        style: const TextStyle(fontSize: 11, fontFamily: 'monospace')),
                    onSelected: (bool v) {
                      final Set<int> next = Set<int>.from(enabled);
                      if (v) {
                        next.add(i);
                      } else {
                        next.remove(i);
                      }
                      _enabledStyles.value = next;
                    },
                    selectedColor: cs.primaryContainer,
                  );
                }),
              ),
              const SizedBox(height: 16),
              _stylesTable(context, cs, enabled),
            ],
          );
        },
      ),
    ],
  );
}

Widget _stylePreview(BuildContext context, ColorScheme cs, Set<int> enabled) {
  final bool hasCaption = enabled.contains(1);
  final bool hasThickFrame = enabled.contains(2);
  final bool hasMinBox = enabled.contains(3);
  final bool hasMaxBox = enabled.contains(4);
  final bool hasSysMenu = enabled.contains(5);

  return Container(
    decoration: BoxDecoration(
      border: Border.all(
        color: hasThickFrame ? cs.primary : Colors.grey.withAlpha(80),
        width: hasThickFrame ? 3 : 1,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      children: <Widget>[
        if (hasCaption)
          Container(
            height: 28,
            color: const Color(0xFF202020),
            child: Row(
              children: <Widget>[
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'My Window',
                    style: TextStyle(color: Colors.white.withAlpha(200), fontSize: 11),
                  ),
                ),
                if (hasSysMenu)
                  const Icon(Icons.menu, color: Colors.white54, size: 14),
                const SizedBox(width: 8),
                if (hasMinBox)
                  const Icon(Icons.remove, color: Colors.white70, size: 14),
                const SizedBox(width: 6),
                if (hasMaxBox)
                  const Icon(Icons.crop_square, color: Colors.white70, size: 14),
                const SizedBox(width: 6),
                const Icon(Icons.close, color: Colors.white70, size: 14),
                const SizedBox(width: 8),
              ],
            ),
          ),
        Container(
          height: 80,
          color: const Color(0xFF1E1E1E),
          child: Center(
            child: Text(
              enabled.isEmpty
                  ? 'No styles (invisible/empty)'
                  : 'Active styles: ${enabled.length}',
              style: TextStyle(color: Colors.white.withAlpha(130), fontSize: 11),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _stylesTable(BuildContext context, ColorScheme cs, Set<int> enabled) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: cs.outlineVariant),
    ),
    child: Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: cs.surfaceContainerHighest,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
          ),
          child: const Row(
            children: <Widget>[
              SizedBox(width: 32),
              SizedBox(width: 170, child: Text('Style', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
              SizedBox(width: 110, child: Text('Value', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
              Expanded(child: Text('Visual Effect', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
            ],
          ),
        ),
        ..._kWin32Styles.asMap().entries.map((MapEntry<int, _Win32StyleFlag> e) {
          final int i = e.key;
          final _Win32StyleFlag flag = e.value;
          final bool on = enabled.contains(i);
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            color: on ? cs.primaryContainer.withAlpha(60) : null,
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 32,
                  child: Icon(
                    on ? Icons.check_circle : Icons.circle_outlined,
                    size: 16,
                    color: on ? cs.primary : cs.outlineVariant,
                  ),
                ),
                SizedBox(
                  width: 170,
                  child: Text(
                    flag.name,
                    style: const TextStyle(
                        fontSize: 10, fontFamily: 'monospace'),
                  ),
                ),
                SizedBox(
                  width: 110,
                  child: Text(
                    flag.hex,
                    style: const TextStyle(
                        fontSize: 10, fontFamily: 'monospace', color: Colors.deepOrange),
                  ),
                ),
                Expanded(
                  child: Text(
                    flag.visual,
                    style: const TextStyle(fontSize: 11),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    ),
  );
}

// ── Tab 6: Windows 11 Features ────────────────────────────────────────────

Widget _buildWindows11Features(BuildContext context) {
  final ColorScheme cs = Theme.of(context).colorScheme;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _sectionHeader(context, 'Windows 11 Features',
          'Snap Layouts, Virtual Desktops, Taskbar, DWM Acrylic/Mica'),
      const SizedBox(height: 16),
      ..._kWin32Features.map((_Win32Feature f) => _featureCard(context, cs, f)),
      const SizedBox(height: 8),
      _virtualDesktopSimulator(context, cs),
    ],
  );
}

Widget _featureCard(
    BuildContext context, ColorScheme cs, _Win32Feature feature) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: feature.color.withAlpha(100)),
      color: feature.color.withAlpha(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: feature.color.withAlpha(20),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(13)),
          ),
          child: Row(
            children: <Widget>[
              Icon(feature.icon, color: feature.color, size: 22),
              const SizedBox(width: 10),
              Text(
                feature.title,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: feature.color,
                    ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(feature.description,
                  style: const TextStyle(fontSize: 12, height: 1.5)),
              const SizedBox(height: 10),
              _codeLabel('Win32 API'),
              _codeBlock(feature.apiNote, cs),
              const SizedBox(height: 8),
              _codeLabel('Flutter Note'),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: cs.primaryContainer.withAlpha(80),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(feature.flutterNote,
                    style: const TextStyle(fontSize: 11, height: 1.5)),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _virtualDesktopSimulator(BuildContext context, ColorScheme cs) {
  return ValueListenableBuilder<int>(
    valueListenable: _virtualDesktop,
    builder: (BuildContext ctx, int desktop, Widget? _) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cs.surfaceContainerHighest.withAlpha(80),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Virtual Desktop Simulator',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            Row(
              children: List<Widget>.generate(4, (int i) {
                final bool active = i == desktop;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => _virtualDesktop.value = i,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      height: 70,
                      decoration: BoxDecoration(
                        color: active
                            ? cs.primary.withAlpha(40)
                            : cs.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: active ? cs.primary : cs.outlineVariant,
                          width: active ? 2 : 1,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.desktop_windows,
                            color: active ? cs.primary : cs.onSurfaceVariant,
                            size: 20,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Desktop ${i + 1}',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: active ? FontWeight.bold : FontWeight.normal,
                              color: active ? cs.primary : cs.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 8),
            Text(
              'Active: Desktop ${desktop + 1} — '
              'IVirtualDesktopManager::IsWindowOnCurrentVirtualDesktop(hwnd, &bResult)',
              style:
                  Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      );
    },
  );
}

// ── Tab 7: Win32 Message Gallery ──────────────────────────────────────────

void _logMessage(String name, String wParam, String lParam, String desc) {
  final List<_Win32Message> current = List<_Win32Message>.from(_messageLog.value);
  // Find matching message for colour/icon
  final _Win32Message? template = _kWin32Messages
      .where((_Win32Message m) => m.constant == name || m.name == name)
      .firstOrNull;
  current.insert(
    0,
    _Win32Message(
      name: name,
      constant: name,
      wParam: wParam,
      lParam: lParam,
      description: desc,
      color: template?.color ?? Colors.grey,
      icon: template?.icon ?? Icons.message,
    ),
  );
  if (current.length > 20) {
    current.removeLast();
  }
  _messageLog.value = current;
}

Widget _buildMessageGallery(BuildContext context) {
  final ColorScheme cs = Theme.of(context).colorScheme;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _sectionHeader(context, 'Win32 Message Gallery',
          'WM_SIZE, WM_MOVE, WM_ACTIVATE, WM_CLOSE, WM_DESTROY, WM_DPICHANGED'),
      const SizedBox(height: 16),
      ValueListenableBuilder<int>(
        valueListenable: _selectedMessage,
        builder: (BuildContext ctx, int sel, Widget? _) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _messageSelector(context, cs, sel),
              const SizedBox(height: 12),
              _messageDetail(context, cs, _kWin32Messages[sel]),
              const SizedBox(height: 16),
              _messageLogPanel(context, cs),
            ],
          );
        },
      ),
    ],
  );
}

Widget _messageSelector(BuildContext context, ColorScheme cs, int sel) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: _kWin32Messages.asMap().entries.map(
        (MapEntry<int, _Win32Message> e) {
          final bool active = e.key == sel;
          final _Win32Message msg = e.value;
          return GestureDetector(
            onTap: () {
              _selectedMessage.value = e.key;
              _logMessage(msg.name, msg.wParam, msg.lParam, msg.description);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: active ? msg.color : msg.color.withAlpha(20),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: active ? msg.color : msg.color.withAlpha(60),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(msg.icon,
                      color: active ? Colors.white : msg.color, size: 16),
                  const SizedBox(width: 6),
                  Text(
                    msg.name,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: active ? Colors.white : msg.color,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ).toList(),
    ),
  );
}

Widget _messageDetail(
    BuildContext context, ColorScheme cs, _Win32Message msg) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: msg.color.withAlpha(15),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: msg.color.withAlpha(80)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: msg.color.withAlpha(30),
                shape: BoxShape.circle,
              ),
              child: Icon(msg.icon, color: msg.color, size: 20),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  msg.name,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: msg.color,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  msg.constant,
                  style: TextStyle(
                    fontSize: 11,
                    fontFamily: 'monospace',
                    color: cs.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(msg.description,
            style: const TextStyle(fontSize: 12, height: 1.5)),
        const SizedBox(height: 12),
        _paramRow('wParam', msg.wParam, cs),
        const SizedBox(height: 6),
        _paramRow('lParam', msg.lParam, cs),
      ],
    ),
  );
}

Widget _paramRow(String label, String value, ColorScheme cs) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: cs.secondaryContainer,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontFamily: 'monospace',
            fontWeight: FontWeight.bold,
            color: cs.onSecondaryContainer,
          ),
        ),
      ),
      const SizedBox(width: 8),
      Expanded(
        child: Text(value, style: const TextStyle(fontSize: 11)),
      ),
    ],
  );
}

Widget _messageLogPanel(BuildContext context, ColorScheme cs) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Row(
        children: <Widget>[
          Text(
            'Event Log (simulated)',
            style: Theme.of(context)
                .textTheme
                .labelMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          TextButton(
            onPressed: () => _messageLog.value = <_Win32Message>[],
            child: const Text('Clear', style: TextStyle(fontSize: 11)),
          ),
        ],
      ),
      const SizedBox(height: 6),
      ValueListenableBuilder<List<_Win32Message>>(
        valueListenable: _messageLog,
        builder: (BuildContext ctx, List<_Win32Message> log, Widget? _) {
          if (log.isEmpty) {
            return Container(
              height: 80,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: cs.surfaceContainerHighest.withAlpha(60),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'Tap a message button to log events here',
                style: TextStyle(color: cs.onSurfaceVariant, fontSize: 12),
              ),
            );
          }
          return Container(
            height: 200,
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A2E),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: log.length,
              itemBuilder: (BuildContext ctx2, int i) {
                final _Win32Message m = log[i];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    children: <Widget>[
                      Text(
                        (log.length - i).toString().padLeft(3, '0'),
                        style: TextStyle(
                          color: Colors.white.withAlpha(60),
                          fontSize: 10,
                          fontFamily: 'monospace',
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: m.color,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        m.name,
                        style: TextStyle(
                          color: m.color,
                          fontSize: 10,
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          m.wParam,
                          style: TextStyle(
                            color: Colors.white.withAlpha(130),
                            fontSize: 9,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    ],
  );
}

// ── Tab 8: Multi-Window ───────────────────────────────────────────────────

Widget _buildMultiWindow(BuildContext context) {
  final ColorScheme cs = Theme.of(context).colorScheme;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _sectionHeader(context, 'Multi-Window with Win32 CreateWindow',
          'How Flutter creates secondary HWNDs and manages them'),
      const SizedBox(height: 16),
      _multiWindowDiagram(context, cs),
      const SizedBox(height: 16),
      ..._kMultiWindowSteps
          .map((_MultiWindowStep s) => _multiWindowStepCard(context, cs, s)),
      const SizedBox(height: 8),
      _secondaryWindowCounter(context, cs),
    ],
  );
}

Widget _multiWindowDiagram(BuildContext context, ColorScheme cs) {
  return Container(
    height: 120,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: cs.surfaceContainerHighest.withAlpha(80),
      borderRadius: BorderRadius.circular(14),
    ),
    child: Row(
      children: <Widget>[
        _windowBox(context, cs, 'Primary\nHWND', cs.primary, true),
        _windowArrow(cs),
        _windowBox(context, cs, 'Dart\nIsolate 1', cs.secondary, false),
        _windowArrow(cs),
        _windowBox(context, cs, 'Secondary\nHWND', cs.tertiary, true),
        _windowArrow(cs),
        _windowBox(context, cs, 'Dart\nIsolate 2', Colors.orange, false),
      ],
    ),
  );
}

Widget _windowBox(BuildContext context, ColorScheme cs, String label,
    Color color, bool isHwnd) {
  return Expanded(
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: color.withAlpha(30),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withAlpha(120)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            isHwnd ? Icons.window : Icons.code,
            color: color,
            size: 18,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _windowArrow(ColorScheme cs) {
  return Icon(Icons.arrow_forward, color: cs.onSurfaceVariant, size: 16);
}

Widget _multiWindowStepCard(
    BuildContext context, ColorScheme cs, _MultiWindowStep step) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: step.color.withAlpha(80)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 48,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: step.color.withAlpha(30),
            borderRadius: const BorderRadius.horizontal(left: Radius.circular(11)),
          ),
          child: Text(
            '${step.index}',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: step.color,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  step.title,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: step.color,
                      ),
                ),
                const SizedBox(height: 4),
                Text(step.description,
                    style: const TextStyle(fontSize: 11, height: 1.4)),
                const SizedBox(height: 6),
                _codeBlock(step.code, cs),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _secondaryWindowCounter(BuildContext context, ColorScheme cs) {
  return ValueListenableBuilder<int>(
    valueListenable: _secondaryWindowCount,
    builder: (BuildContext ctx, int count, Widget? _) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cs.surfaceContainerHighest.withAlpha(80),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Simulated Secondary Windows',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            Row(
              children: <Widget>[
                IconButton(
                  onPressed: count > 0
                      ? () => _secondaryWindowCount.value = count - 1
                      : null,
                  icon: const Icon(Icons.remove_circle_outline),
                ),
                Expanded(
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: List<Widget>.generate(count, (int i) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: cs.secondaryContainer,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: cs.secondary.withAlpha(80)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(Icons.window, size: 14, color: cs.secondary),
                            const SizedBox(width: 5),
                            Text(
                              'Window ${i + 2}',
                              style: TextStyle(
                                fontSize: 11,
                                color: cs.onSecondaryContainer,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
                IconButton(
                  onPressed: count < 5
                      ? () => _secondaryWindowCount.value = count + 1
                      : null,
                  icon: const Icon(Icons.add_circle_outline),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              '$count secondary HWND(s) — ${count + 1} FlutterViewController(s) total',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      );
    },
  );
}

// ── Tab 9: Pitfalls ───────────────────────────────────────────────────────

Widget _buildPitfalls(BuildContext context) {
  final ColorScheme cs = Theme.of(context).colorScheme;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _sectionHeader(context, 'Common Pitfalls',
          'Windows-only, DPI scaling, UAC prompts, message ordering'),
      const SizedBox(height: 16),
      _pitfallCard(context, cs, _kPitfalls[0], _platformCardExpanded),
      _pitfallCard(context, cs, _kPitfalls[1], _dpiCardExpanded),
      _pitfallCard(context, cs, _kPitfalls[2], _uacCardExpanded),
      _pitfallCard(context, cs, _kPitfalls[3],
          ValueNotifier<bool>(false)),
    ],
  );
}

Widget _pitfallCard(BuildContext context, ColorScheme cs, _PitfallCard card,
    ValueNotifier<bool> expanded) {
  return ValueListenableBuilder<bool>(
    valueListenable: expanded,
    builder: (BuildContext ctx, bool isExpanded, Widget? _) {
      return Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: card.color.withAlpha(100)),
          color: card.color.withAlpha(8),
        ),
        child: Column(
          children: <Widget>[
            InkWell(
              onTap: () => expanded.value = !isExpanded,
              borderRadius: BorderRadius.circular(14),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  children: <Widget>[
                    Icon(card.icon, color: card.color, size: 22),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            card.title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: card.color,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: card.color.withAlpha(30),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'Severity: ${card.severity}',
                              style: TextStyle(
                                fontSize: 10,
                                color: card.color,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      isExpanded ? Icons.expand_less : Icons.expand_more,
                      color: card.color,
                    ),
                  ],
                ),
              ),
            ),
            if (isExpanded)
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Divider(),
                    _labeledSection('Problem', card.problem, cs),
                    const SizedBox(height: 8),
                    _labeledSection('Solution', card.solution, cs),
                    const SizedBox(height: 8),
                    _codeLabel('Code'),
                    _codeBlock(card.codeSnippet, cs),
                  ],
                ),
              ),
          ],
        ),
      );
    },
  );
}

Widget _labeledSection(String label, String content, ColorScheme cs) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
      ),
      const SizedBox(height: 4),
      Text(content, style: const TextStyle(fontSize: 12, height: 1.4)),
    ],
  );
}

// ── Tab 10: API Cheat Sheet ───────────────────────────────────────────────

Widget _buildApiCheatSheet(BuildContext context) {
  final ColorScheme cs = Theme.of(context).colorScheme;

  final Map<String, List<_ApiEntry>> grouped = <String, List<_ApiEntry>>{};
  for (final _ApiEntry e in _kApiEntries) {
    grouped.putIfAbsent(e.category, () => <_ApiEntry>[]).add(e);
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _sectionHeader(context, 'API Cheat Sheet',
          'RegularWindowControllerWin32 — complete method and property reference'),
      const SizedBox(height: 16),
      ...grouped.entries.map((MapEntry<String, List<_ApiEntry>> entry) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(bottom: 8, top: 4),
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: cs.primaryContainer,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                entry.key,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: cs.onPrimaryContainer,
                ),
              ),
            ),
            ...entry.value
                .map((_ApiEntry e) => _apiEntryCard(context, cs, e)),
            const SizedBox(height: 8),
          ],
        );
      }),
    ],
  );
}

Widget _apiEntryCard(BuildContext context, ColorScheme cs, _ApiEntry entry) {
  return Container(
    margin: const EdgeInsets.only(bottom: 6),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: cs.surfaceContainerHighest.withAlpha(60),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: cs.outlineVariant.withAlpha(80)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E1E),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            entry.signature,
            style: const TextStyle(
              color: Color(0xFF9CDCFE),
              fontSize: 11,
              fontFamily: 'monospace',
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          entry.description,
          style: const TextStyle(fontSize: 11, height: 1.4),
        ),
      ],
    ),
  );
}

// ── shared helpers ─────────────────────────────────────────────────────────

Widget _sectionHeader(
    BuildContext context, String title, String subtitle) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
      const SizedBox(height: 4),
      Text(
        subtitle,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
      ),
    ],
  );
}

Widget _labeledRow(String label, Widget child) {
  return Row(
    children: <Widget>[
      SizedBox(
        width: 120,
        child: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        ),
      ),
      child,
    ],
  );
}

Widget _codeLabel(String label) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Text(
      label,
      style: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.bold,
        color: Colors.blueGrey,
      ),
    ),
  );
}

Widget _codeBlock(String code, ColorScheme cs) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: const Color(0xFF1E1E1E),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      code,
      style: const TextStyle(
        color: Color(0xFFD4D4D4),
        fontSize: 11,
        fontFamily: 'monospace',
        height: 1.5,
      ),
    ),
  );
}

// ── entry point ───────────────────────────────────────────────────────────

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF0078D4),
        brightness: Brightness.light,
      ),
    ),
    home: DefaultTabController(
      length: 9,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'RegularWindowControllerWin32',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          bottom: const TabBar(
            isScrollable: true,
            tabs: <Tab>[
              Tab(text: 'Overview'),
              Tab(text: 'Window Chrome'),
              Tab(text: 'Architecture'),
              Tab(text: 'State Machine'),
              Tab(text: 'Win32 Styles'),
              Tab(text: 'Win11 Features'),
              Tab(text: 'Messages'),
              Tab(text: 'Multi-Window'),
              Tab(text: 'Pitfalls & API'),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            // Tab 1: Overview / Hero
            ListView(
              padding: const EdgeInsets.all(20),
              children: <Widget>[
                _buildHeroBanner(context),
              ],
            ),
            // Tab 2: Simulated Window Chrome
            ListView(
              padding: const EdgeInsets.all(20),
              children: <Widget>[
                _buildWindowChrome(context),
              ],
            ),
            // Tab 3: Architecture Diagram
            ListView(
              padding: const EdgeInsets.all(20),
              children: <Widget>[
                _buildArchitectureDiagram(context),
              ],
            ),
            // Tab 4: Window State Machine
            ListView(
              padding: const EdgeInsets.all(20),
              children: <Widget>[
                _buildStateMachine(context),
              ],
            ),
            // Tab 5: Win32 Window Styles
            ListView(
              padding: const EdgeInsets.all(20),
              children: <Widget>[
                _buildWindowStyles(context),
              ],
            ),
            // Tab 6: Windows 11 Features
            ListView(
              padding: const EdgeInsets.all(20),
              children: <Widget>[
                _buildWindows11Features(context),
              ],
            ),
            // Tab 7: Win32 Message Gallery
            ListView(
              padding: const EdgeInsets.all(20),
              children: <Widget>[
                _buildMessageGallery(context),
              ],
            ),
            // Tab 8: Multi-Window
            ListView(
              padding: const EdgeInsets.all(20),
              children: <Widget>[
                _buildMultiWindow(context),
              ],
            ),
            // Tab 9: Pitfalls + API cheat sheet
            ListView(
              padding: const EdgeInsets.all(20),
              children: <Widget>[
                _buildPitfalls(context),
                const SizedBox(height: 24),
                _buildApiCheatSheet(context),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
