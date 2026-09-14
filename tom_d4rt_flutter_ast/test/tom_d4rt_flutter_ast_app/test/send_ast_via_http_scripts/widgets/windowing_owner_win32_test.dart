// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last

// =============================================================================
//  D4rt AST deep demo: WindowingOwnerWin32
// -----------------------------------------------------------------------------
//
//  Subject of study:
//      package:flutter/src/widgets/_window_win32.dart   (Flutter SDK)
//      class WindowingOwnerWin32 extends WindowingOwner
//      class RegularWindowControllerWin32 extends RegularWindowController
//      mixin class RegularWindowControllerDelegate
//
//  SDK gap:
//      The whole windowing API surface is gated behind `@internal` annotations
//      and an `isWindowingEnabled` runtime flag. The library file is
//      underscore-prefixed (`_window_win32.dart`), is NOT exported through
//      `package:flutter/widgets.dart`, and the comment at the top of the file
//      explicitly forbids importing it from production code. This demo is a
//      live, pure-Flutter mirror of the API shape so we can exercise it as
//      compiled Dart code instead of leaving it as inert documentation prose.
//
//  Cross-references (cite-by-line so future readers can re-find the originals):
//      - _window_win32.dart:33    `typedef HWND = ffi.Pointer<ffi.Void>;`
//      - _window_win32.dart:93    `class WindowingOwnerWin32 extends WindowingOwner`
//      - _window_win32.dart:106   `WindowingOwnerWin32() : allocator = _CallocAllocator()`
//      - _window_win32.dart:139   `createRegularWindowController(...) -> RegularWindowControllerWin32`
//      - _window_win32.dart:274   `class RegularWindowControllerWin32 extends RegularWindowController`
//      - _window_win32.dart:369   `setSize` ... :376 `setConstraints` ... :392 `activate`
//      - _window_win32.dart:399   `setMaximized` ... :410 `setMinimized` ... :421 `setFullscreen`
//      - _window_win32.dart:447   `destroy()`
//      - _window.dart:111         `mixin class RegularWindowControllerDelegate`
//      - _window.dart:191         `abstract class RegularWindowController extends BaseWindowController`
//      - _window.dart:905         `abstract class WindowingOwner`
//
//  Visual concept:
//      A "Win32 control tower" — the demo renders a fake Windows desktop, a
//      taskbar, and several mirror windows whose chrome is driven by the local
//      `WindowingOwnerWin32` mirror (right-aligned min/max/close buttons,
//      caption bars, taskbar entries, snap layouts).
// =============================================================================

import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------
//  Entry point used by the D4rt AST harness.
// -----------------------------------------------------------------------------

dynamic build(BuildContext context) {
  return const MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'WindowingOwnerWin32 — Control Tower',
    home: _Wow32Shell(),
  );
}

// =============================================================================
//  Section 1 — Local SDK mirror.
//
//  Faithful (not byte-for-byte; the originals depend on `dart:ffi` and the
//  embedder-specific platform interface) mirror of the windowing surface we
//  want to exercise. Method names and signatures track the SDK so that
//  `dart analyze` validates the call sites we use later.
// =============================================================================

/// Mirror of `HWND` from `_window_win32.dart:33`. The SDK declares it as a
/// `ffi.Pointer<ffi.Void>`. We model it as an opaque integer so the mirror
/// stays self-contained but still has a non-trivial nominal type.
class HwndMirror {
  const HwndMirror(this.address);
  final int address;

  @override
  String toString() => '0x${address.toRadixString(16).padLeft(8, '0')}';

  @override
  bool operator ==(Object other) => other is HwndMirror && other.address == address;

  @override
  int get hashCode => address.hashCode;
}

/// Mirror of `_window.dart:111` `mixin class RegularWindowControllerDelegate`.
/// The SDK exposes two hooks: `onWindowCloseRequested` and `onWindowDestroyed`.
class RegularWindowControllerDelegateMirror {
  RegularWindowControllerDelegateMirror({
    this.onClose,
    this.onDestroyed,
    this.shouldVetoClose,
  });

  /// Optional veto predicate. When it returns true, the delegate refuses
  /// to destroy the window (mirrors the standard "unsaved changes" pattern
  /// app authors implement on top of the real delegate).
  final bool Function(RegularWindowControllerWin32Mirror controller)? shouldVetoClose;

  final void Function(RegularWindowControllerWin32Mirror controller)? onClose;
  final void Function(RegularWindowControllerWin32Mirror controller)? onDestroyed;

  /// Mirror of `_window.dart:123 onWindowCloseRequested`.
  void onWindowCloseRequested(RegularWindowControllerWin32Mirror controller) {
    if (shouldVetoClose?.call(controller) ?? false) {
      controller._owner._log.add('CLOSE vetoed for "${controller.title}"');
      return;
    }
    onClose?.call(controller);
    controller.destroy();
  }

  /// Mirror of `_window.dart:139 onWindowDestroyed`.
  void onWindowDestroyed(RegularWindowControllerWin32Mirror controller) {
    onDestroyed?.call(controller);
  }
}

/// Mirror of `_window.dart:191 abstract class RegularWindowController`.
abstract class RegularWindowControllerMirror extends ChangeNotifier {
  RegularWindowControllerMirror.empty();

  String get title;
  bool get isActivated;
  bool get isMaximized;
  bool get isMinimized;
  bool get isFullscreen;
  Size get contentSize;

  void setSize(Size size);
  void setConstraints(BoxConstraints constraints);
  void setTitle(String title);
  void activate();
  void setMaximized(bool maximized);
  void setMinimized(bool minimized);
  void setFullscreen(bool fullscreen);
  void destroy();
}

/// Mirror of `_window.dart:905 abstract class WindowingOwner`.
abstract class WindowingOwnerMirror {
  RegularWindowControllerWin32Mirror createRegularWindowController({
    required RegularWindowControllerDelegateMirror delegate,
    Size? preferredSize,
    BoxConstraints? preferredConstraints,
    String? title,
  });
}

/// Tiny event log so the visualization can show the message pump in action.
class EventLogMirror extends ChangeNotifier {
  final List<String> entries = <String>[];

  void add(String entry) {
    entries.add(entry);
    if (entries.length > 200) {
      entries.removeRange(0, entries.length - 200);
    }
    notifyListeners();
  }

  void clear() {
    entries.clear();
    notifyListeners();
  }
}

/// Mirror of `_window_win32.dart:93 class WindowingOwnerWin32`.
///
/// In the real SDK the constructor wires up an FFI pump
/// (`_Win32PlatformInterface.initializeWindowing`). Here we keep an in-memory
/// list of windows and an event log so the demo can render the lifecycle
/// without touching native code.
class WindowingOwnerWin32Mirror extends WindowingOwnerMirror {
  WindowingOwnerWin32Mirror({EventLogMirror? log}) : _log = log ?? EventLogMirror() {
    _log.add('WindowingOwnerWin32 constructed (mirror)');
  }

  final EventLogMirror _log;
  EventLogMirror get log => _log;

  final List<RegularWindowControllerWin32Mirror> windows =
      <RegularWindowControllerWin32Mirror>[];

  int _nextHandle = 0x00010000;

  HwndMirror _allocateHandle() {
    _nextHandle += 0x10;
    return HwndMirror(_nextHandle);
  }

  @override
  RegularWindowControllerWin32Mirror createRegularWindowController({
    required RegularWindowControllerDelegateMirror delegate,
    Size? preferredSize,
    BoxConstraints? preferredConstraints,
    String? title,
  }) {
    final controller = RegularWindowControllerWin32Mirror._(
      owner: this,
      delegate: delegate,
      handle: _allocateHandle(),
      preferredSize: preferredSize ?? const Size(720, 480),
      preferredConstraints: preferredConstraints ??
          const BoxConstraints(minWidth: 320, minHeight: 240),
      title: title ?? 'Regular window',
    );
    windows.add(controller);
    _log.add('CreateRegularWindow ${controller.handle} "${controller.title}"');
    _activate(controller);
    return controller;
  }

  void _activate(RegularWindowControllerWin32Mirror controller) {
    for (final w in windows) {
      if (w._activated && w != controller) {
        w._activated = false;
        w._notify();
      }
    }
    controller._activated = true;
    controller._notify();
    _log.add('WM_ACTIVATE ${controller.handle}');
  }

  void _remove(RegularWindowControllerWin32Mirror controller) {
    windows.remove(controller);
    _log.add('WM_DESTROY ${controller.handle}');
    if (windows.isNotEmpty) {
      _activate(windows.last);
    }
  }
}

/// Mirror of `_window_win32.dart:274 class RegularWindowControllerWin32`.
class RegularWindowControllerWin32Mirror extends RegularWindowControllerMirror {
  RegularWindowControllerWin32Mirror._({
    required WindowingOwnerWin32Mirror owner,
    required RegularWindowControllerDelegateMirror delegate,
    required this.handle,
    required Size preferredSize,
    required BoxConstraints preferredConstraints,
    required String title,
  })  : _owner = owner,
        _delegate = delegate,
        _title = title,
        _size = preferredSize,
        _constraints = preferredConstraints,
        super.empty();

  final WindowingOwnerWin32Mirror _owner;
  final RegularWindowControllerDelegateMirror _delegate;
  final HwndMirror handle;

  String _title;
  Size _size;
  BoxConstraints _constraints;
  bool _activated = false;
  bool _maximized = false;
  bool _minimized = false;
  bool _fullscreen = false;
  bool _flashing = false;
  bool _destroyed = false;

  bool get flashing => _flashing;

  @override
  String get title => _title;

  @override
  bool get isActivated => _activated;

  @override
  bool get isMaximized => _maximized;

  @override
  bool get isMinimized => _minimized;

  @override
  bool get isFullscreen => _fullscreen;

  @override
  Size get contentSize => _size;

  BoxConstraints get constraints => _constraints;

  void _ensureLive() {
    if (_destroyed) {
      throw StateError('Window has been destroyed.');
    }
  }

  void _notify() {
    if (!_destroyed) {
      notifyListeners();
    }
  }

  @override
  void setSize(Size size) {
    _ensureLive();
    final clamped = _constraints.constrain(size);
    _size = clamped;
    _owner._log.add('setSize $handle -> $clamped');
    _notify();
  }

  /// Win32-specific helper exposed via the mirror only — handy for sliders.
  void setMinimumSize(Size size) {
    _ensureLive();
    _constraints = _constraints.copyWith(minWidth: size.width, minHeight: size.height);
    _owner._log.add('setMinimumSize $handle -> $size');
    _notify();
  }

  /// Win32-specific helper exposed via the mirror only.
  void setMaximumSize(Size size) {
    _ensureLive();
    _constraints = _constraints.copyWith(maxWidth: size.width, maxHeight: size.height);
    _owner._log.add('setMaximumSize $handle -> $size');
    _notify();
  }

  @override
  void setConstraints(BoxConstraints constraints) {
    _ensureLive();
    _constraints = constraints;
    _owner._log.add('setConstraints $handle -> $constraints');
    _notify();
  }

  @override
  void setTitle(String title) {
    _ensureLive();
    _title = title;
    _owner._log.add('SetWindowTextW $handle -> "$title"');
    _notify();
  }

  @override
  void activate() {
    _ensureLive();
    _owner._activate(this);
  }

  /// Mirror of the SDK's `deactivate` semantics. The real SDK does not expose
  /// a public method called `deactivate`, but losing focus is observable via
  /// `WM_ACTIVATE` with `wParam == WA_INACTIVE`. We surface it explicitly so
  /// the demo can drive the activation state from a button.
  void deactivate() {
    _ensureLive();
    _activated = false;
    _owner._log.add('WM_ACTIVATE inactive $handle');
    _notify();
  }

  @override
  void setMaximized(bool maximized) {
    _ensureLive();
    _maximized = maximized;
    if (maximized) {
      _minimized = false;
    }
    _owner._log.add('ShowWindow ${maximized ? "SW_MAXIMIZE" : "SW_RESTORE"} $handle');
    _notify();
  }

  @override
  void setMinimized(bool minimized) {
    _ensureLive();
    _minimized = minimized;
    if (minimized) {
      _activated = false;
    }
    _owner._log.add('ShowWindow ${minimized ? "SW_MINIMIZE" : "SW_RESTORE"} $handle');
    _notify();
  }

  @override
  void setFullscreen(bool fullscreen) {
    _ensureLive();
    _fullscreen = fullscreen;
    _owner._log.add('SetFullscreen $handle -> $fullscreen');
    _notify();
  }

  /// Mirror of the Win32 `FlashWindowEx` / `FlashWindow` request to draw user
  /// attention to the taskbar entry. The real SDK does not yet expose this
  /// through `WindowingOwnerWin32`, but it is one of the recipes the demo
  /// describes — so we expose it on the mirror.
  void flashTaskbar({bool flashing = true}) {
    _ensureLive();
    _flashing = flashing;
    _owner._log.add('FlashWindowEx $handle -> $flashing');
    _notify();
  }

  @override
  void destroy() {
    if (_destroyed) {
      return;
    }
    _destroyed = true;
    _owner._remove(this);
    _delegate.onWindowDestroyed(this);
    notifyListeners();
  }

  /// Mirror of the close-request path: in the SDK the WM_CLOSE message is
  /// delivered by the message pump and routed to the delegate. We expose a
  /// helper so the demo button can drive the same code path.
  void requestClose() {
    if (_destroyed) {
      return;
    }
    _owner._log.add('WM_CLOSE $handle');
    _delegate.onWindowCloseRequested(this);
  }
}

// =============================================================================
//  Section 2 — Design tokens.
// =============================================================================

class _Palette {
  static const Color desktopTop = Color(0xFF1E3A5F);
  static const Color desktopBottom = Color(0xFF3A6C9A);
  static const Color taskbar = Color(0xFF1C2734);
  static const Color taskbarHi = Color(0xFF2A394A);

  static const Color chromeActiveTop = Color(0xFF3D7DC4);
  static const Color chromeActiveBottom = Color(0xFF1F4F8B);
  static const Color chromeInactive = Color(0xFFB6C0CC);

  static const Color panel = Color(0xFFF3F5F8);
  static const Color panelStroke = Color(0xFFC9D1DB);
  static const Color panelStrokeStrong = Color(0xFF7A8A9E);

  static const Color accentBlue = Color(0xFF2E6FC9);
  static const Color accentTeal = Color(0xFF1E8A8A);
  static const Color accentAmber = Color(0xFFD08A2A);
  static const Color accentRed = Color(0xFFC0392B);
  static const Color accentGreen = Color(0xFF2E8B57);

  static const Color textPrimary = Color(0xFF13202F);
  static const Color textSecondary = Color(0xFF425468);
  static const Color textMuted = Color(0xFF7A8A9E);
  static const Color textOnDark = Color(0xFFE8EEF5);

  static const Color codeBg = Color(0xFF13202F);
  static const Color codeText = Color(0xFFDCE4EE);
  static const Color codeAccent = Color(0xFF6FAEE8);
}

class _Type {
  static const TextStyle pageTitle = TextStyle(
    fontFamily: 'Segoe UI',
    fontSize: 30,
    fontWeight: FontWeight.w300,
    color: _Palette.textOnDark,
    letterSpacing: 0.25,
    height: 1.1,
  );

  static const TextStyle pageSubtitle = TextStyle(
    fontFamily: 'Segoe UI',
    fontSize: 14,
    color: Color(0xFFB7C4D6),
    height: 1.4,
  );

  static const TextStyle sectionTitle = TextStyle(
    fontFamily: 'Segoe UI',
    fontSize: 22,
    fontWeight: FontWeight.w500,
    color: _Palette.textPrimary,
  );

  static const TextStyle body = TextStyle(
    fontFamily: 'Segoe UI',
    fontSize: 13,
    color: _Palette.textPrimary,
    height: 1.5,
  );

  static const TextStyle small = TextStyle(
    fontFamily: 'Segoe UI',
    fontSize: 11,
    color: _Palette.textSecondary,
    height: 1.4,
  );

  static const TextStyle code = TextStyle(
    fontFamily: 'Consolas',
    fontSize: 12,
    color: _Palette.codeText,
    height: 1.45,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: 'Segoe UI',
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: _Palette.textOnDark,
    letterSpacing: 0.4,
  );
}

// =============================================================================
//  Section 3 — Top-level shell.
// =============================================================================

class _Wow32Shell extends StatefulWidget {
  const _Wow32Shell();

  @override
  State<_Wow32Shell> createState() => _Wow32ShellState();
}

class _Wow32ShellState extends State<_Wow32Shell> {
  late final WindowingOwnerWin32Mirror owner;
  late final List<RegularWindowControllerWin32Mirror> _initialWindows;

  @override
  void initState() {
    super.initState();
    owner = WindowingOwnerWin32Mirror();

    _initialWindows = <RegularWindowControllerWin32Mirror>[
      owner.createRegularWindowController(
        delegate: RegularWindowControllerDelegateMirror(),
        preferredSize: const Size(640, 420),
        title: 'Notepad — Untitled',
      ),
      owner.createRegularWindowController(
        delegate: RegularWindowControllerDelegateMirror(),
        preferredSize: const Size(820, 560),
        title: 'Explorer — C:\\Users\\dev',
      ),
      owner.createRegularWindowController(
        delegate: RegularWindowControllerDelegateMirror(),
        preferredSize: const Size(540, 360),
        title: 'Calculator',
      ),
    ];
  }

  @override
  void dispose() {
    for (final w in List.of(owner.windows)) {
      w.destroy();
    }
    owner.log.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TargetPlatform tp = Theme.of(context).platform;
    final bool live = tp == TargetPlatform.windows;

    return Scaffold(
      backgroundColor: const Color(0xFF0A1420),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _HeroSection(platform: tp, live: live, owner: owner),
              const SizedBox(height: 28),
              _AnatomySection(),
              const SizedBox(height: 28),
              _MessagePumpSection(),
              const SizedBox(height: 28),
              _OwnerInstantiationSection(owner: owner),
              const SizedBox(height: 28),
              _ControllerLifecycleSection(owner: owner),
              const SizedBox(height: 28),
              _ResizePlaygroundSection(controller: _initialWindows[0]),
              const SizedBox(height: 28),
              _MaximizeRestoreSection(controller: _initialWindows[1]),
              const SizedBox(height: 28),
              _MinimizeSection(controller: _initialWindows[2]),
              const SizedBox(height: 28),
              _FullscreenSection(controller: _initialWindows[1]),
              const SizedBox(height: 28),
              _CloseDelegateSection(owner: owner),
              const SizedBox(height: 28),
              _MultiWindowSection(owner: owner),
              const SizedBox(height: 28),
              _FlashTaskbarSection(controller: _initialWindows[0]),
              const SizedBox(height: 28),
              _RecipeGallerySection(),
              const SizedBox(height: 28),
              _PitfallsSection(),
              const SizedBox(height: 28),
              _ReferenceTableSection(),
              const SizedBox(height: 28),
              _EventLogSection(log: owner.log),
              const SizedBox(height: 32),
              const _Footer(),
            ],
          ),
        ),
      ),
    );
  }
}

// =============================================================================
//  Section 4 — Reusable framework widgets.
// =============================================================================

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.subtitle,
    required this.child,
    this.icon = Icons.widgets_outlined,
    this.accent = _Palette.accentBlue,
  });

  final String title;
  final String subtitle;
  final Widget child;
  final IconData icon;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: _Palette.panel,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _Palette.panelStroke),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[accent.withValues(alpha: 0.92), accent.withValues(alpha: 0.7)],
              ),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
            ),
            child: Row(
              children: <Widget>[
                Icon(icon, color: Colors.white, size: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(title,
                          style: _Type.sectionTitle.copyWith(color: Colors.white)),
                      const SizedBox(height: 2),
                      Text(subtitle,
                          style: _Type.small.copyWith(
                            color: const Color(0xFFE8EEF5),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18),
            child: child,
          ),
        ],
      ),
    );
  }
}

class _CodeBlock extends StatelessWidget {
  const _CodeBlock(this.code);
  final String code;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: _Palette.codeBg,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFF22384F)),
      ),
      child: Text(code, style: _Type.code),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.label, required this.color});
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.6)),
      ),
      child: Text(label,
          style: _Type.small.copyWith(color: color, fontWeight: FontWeight.w600)),
    );
  }
}

// =============================================================================
//  Section 5 — Win32 chrome mirror widget.
// =============================================================================

class _Win32WindowChrome extends StatelessWidget {
  const _Win32WindowChrome({
    required this.controller,
    required this.body,
    this.height = 220,
  });

  final RegularWindowControllerWin32Mirror controller;
  final Widget body;
  final double height;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget? _) {
        final bool active = controller.isActivated;
        return Container(
          height: height,
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: active ? _Palette.accentBlue : _Palette.panelStrokeStrong,
              width: active ? 1.5 : 1,
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withValues(alpha: active ? 0.25 : 0.12),
                blurRadius: active ? 14 : 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _CaptionBar(controller: controller),
              if (!controller.isFullscreen) _MenuStrip(controller: controller),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  color: const Color(0xFFFFFFFF),
                  child: body,
                ),
              ),
              if (!controller.isFullscreen) _StatusBar(controller: controller),
            ],
          ),
        );
      },
    );
  }
}

class _CaptionBar extends StatelessWidget {
  const _CaptionBar({required this.controller});
  final RegularWindowControllerWin32Mirror controller;

  @override
  Widget build(BuildContext context) {
    final bool active = controller.isActivated;
    return Container(
      height: 30,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: active
              ? const <Color>[_Palette.chromeActiveTop, _Palette.chromeActiveBottom]
              : const <Color>[_Palette.chromeInactive, Color(0xFF8F9BA8)],
        ),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(5)),
      ),
      child: Row(
        children: <Widget>[
          const SizedBox(width: 8),
          const Icon(Icons.window, size: 14, color: Colors.white),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              controller.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 12,
                color: active ? Colors.white : const Color(0xFFE8EEF5),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          _CaptionButton(
            icon: Icons.minimize,
            onTap: () => controller.setMinimized(!controller.isMinimized),
          ),
          _CaptionButton(
            icon: controller.isMaximized ? Icons.filter_none : Icons.crop_square,
            onTap: () => controller.setMaximized(!controller.isMaximized),
          ),
          _CaptionButton(
            icon: Icons.close,
            danger: true,
            onTap: controller.requestClose,
          ),
        ],
      ),
    );
  }
}

class _CaptionButton extends StatefulWidget {
  const _CaptionButton({required this.icon, required this.onTap, this.danger = false});
  final IconData icon;
  final VoidCallback onTap;
  final bool danger;

  @override
  State<_CaptionButton> createState() => _CaptionButtonState();
}

class _CaptionButtonState extends State<_CaptionButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final Color hoverColor =
        widget.danger ? _Palette.accentRed : Colors.white.withValues(alpha: 0.18);
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          width: 38,
          height: 30,
          color: _hover ? hoverColor : Colors.transparent,
          alignment: Alignment.center,
          child: Icon(widget.icon, size: 14, color: Colors.white),
        ),
      ),
    );
  }
}

class _MenuStrip extends StatelessWidget {
  const _MenuStrip({required this.controller});
  final RegularWindowControllerWin32Mirror controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 22,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: const BoxDecoration(
        color: Color(0xFFEEF1F5),
        border: Border(bottom: BorderSide(color: _Palette.panelStroke)),
      ),
      child: Row(
        children: <Widget>[
          for (final String label in const <String>['File', 'Edit', 'View', 'Help'])
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Text(label, style: _Type.small),
            ),
          const Spacer(),
          Text('${controller.contentSize.width.toStringAsFixed(0)} × '
              '${controller.contentSize.height.toStringAsFixed(0)}',
              style: _Type.small.copyWith(color: _Palette.textMuted)),
        ],
      ),
    );
  }
}

class _StatusBar extends StatelessWidget {
  const _StatusBar({required this.controller});
  final RegularWindowControllerWin32Mirror controller;

  @override
  Widget build(BuildContext context) {
    final List<String> tags = <String>[
      if (controller.isActivated) 'ACTIVE',
      if (controller.isMaximized) 'MAXIMIZED',
      if (controller.isMinimized) 'MINIMIZED',
      if (controller.isFullscreen) 'FULLSCREEN',
      if (controller.flashing) 'FLASHING',
    ];
    return Container(
      height: 20,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: const BoxDecoration(
        color: Color(0xFFEEF1F5),
        border: Border(top: BorderSide(color: _Palette.panelStroke)),
      ),
      child: Row(
        children: <Widget>[
          Text('HWND ${controller.handle}', style: _Type.small),
          const SizedBox(width: 12),
          if (tags.isNotEmpty)
            Text(tags.join(' · '),
                style: _Type.small.copyWith(color: _Palette.accentBlue)),
          const Spacer(),
          Text('Win32 mirror', style: _Type.small.copyWith(color: _Palette.textMuted)),
        ],
      ),
    );
  }
}

// =============================================================================
//  Section 6 — Hero with platform banner.
// =============================================================================

class _HeroSection extends StatelessWidget {
  const _HeroSection({required this.platform, required this.live, required this.owner});
  final TargetPlatform platform;
  final bool live;
  final WindowingOwnerWin32Mirror owner;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[_Palette.desktopTop, _Palette.desktopBottom],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF20446B)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.desktop_windows, color: Colors.white, size: 30),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text('WindowingOwnerWin32', style: _Type.pageTitle),
                    const SizedBox(height: 4),
                    Text(
                      'Internal, experimental Flutter Win32 windowing owner — '
                      'mirrored live in this demo.',
                      style: _Type.pageSubtitle,
                    ),
                  ],
                ),
              ),
              const _Pill(label: '@internal', color: _Palette.accentAmber),
              const SizedBox(width: 6),
              const _Pill(label: 'isWindowingEnabled', color: _Palette.accentTeal),
            ],
          ),
          const SizedBox(height: 16),
          _PlatformBanner(platform: platform, live: live),
          const SizedBox(height: 16),
          AnimatedBuilder(
            animation: owner.log,
            builder: (BuildContext context, Widget? _) => Text(
              'Owner state: ${owner.windows.length} window'
              '${owner.windows.length == 1 ? '' : 's'} alive · '
              '${owner.log.entries.length} message'
              '${owner.log.entries.length == 1 ? '' : 's'} on the pump',
              style: _Type.pageSubtitle.copyWith(
                color: const Color(0xFFD9E4F2),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PlatformBanner extends StatelessWidget {
  const _PlatformBanner({required this.platform, required this.live});
  final TargetPlatform platform;
  final bool live;

  String get _platformName {
    switch (platform) {
      case TargetPlatform.windows:
        return 'Windows';
      case TargetPlatform.macOS:
        return 'macOS';
      case TargetPlatform.linux:
        return 'Linux';
      case TargetPlatform.android:
        return 'Android';
      case TargetPlatform.iOS:
        return 'iOS';
      case TargetPlatform.fuchsia:
        return 'Fuchsia';
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color tint = live ? _Palette.accentGreen : _Palette.accentAmber;
    final String text = live
        ? 'Running on Windows — `WindowingOwnerWin32` would be the real native '
            'owner here. The demo still uses the local mirror so it stays self-contained.'
        : 'this would only run live on Windows — currently demoing the chrome '
            'on $_platformName';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: tint.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: tint.withValues(alpha: 0.7)),
      ),
      child: Row(
        children: <Widget>[
          Icon(live ? Icons.check_circle_outline : Icons.info_outline,
              size: 18, color: Colors.white),
          const SizedBox(width: 10),
          Expanded(
            child: Text(text,
                style: _Type.small.copyWith(color: Colors.white, height: 1.45)),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
//  Section 7 — Anatomy.
// =============================================================================

class _AnatomySection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Class anatomy',
      subtitle: 'Where WindowingOwnerWin32 sits in the windowing class graph.',
      icon: Icons.account_tree_outlined,
      accent: _Palette.accentBlue,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Text(
            'The windowing API is structured as an abstract owner that the '
            'embedder fills in per-platform. WindowingOwnerWin32 is the '
            'concrete leaf for Win32 desktop targets.',
            style: _Type.body,
          ),
          const SizedBox(height: 12),
          const _CodeBlock('''
abstract class WindowingOwner {                       // _window.dart:905
  RegularWindowController createRegularWindowController({...});
  DialogWindowController  createDialogWindowController({...});
  TooltipWindowController createTooltipWindowController({...});
  PopupWindowController   createPopupWindowController({...});
}

@internal class WindowingOwnerWin32 extends WindowingOwner {  // _window_win32.dart:93
  WindowingOwnerWin32() : allocator = _CallocAllocator();
  final ffi.Allocator allocator;
  ...
}

@internal class RegularWindowControllerWin32             // _window_win32.dart:274
        extends RegularWindowController {
  RegularWindowControllerWin32({
    required WindowingOwnerWin32 owner,
    required RegularWindowControllerDelegate delegate,
    Size? preferredSize,
    BoxConstraints? preferredConstraints,
    String? title,
  });
}'''),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: const <Widget>[
              _Pill(label: 'extends WindowingOwner', color: _Palette.accentBlue),
              _Pill(label: 'returns RegularWindowControllerWin32', color: _Palette.accentTeal),
              _Pill(label: 'uses CoTaskMemAlloc', color: _Palette.accentAmber),
              _Pill(label: 'FFI native callbacks', color: _Palette.accentRed),
            ],
          ),
        ],
      ),
    );
  }
}

// =============================================================================
//  Section 8 — Message pump diagram.
// =============================================================================

class _MessagePumpSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Win32 message pump',
      subtitle: 'How WM_* messages reach Dart through WindowingOwnerWin32.',
      icon: Icons.swap_horiz,
      accent: _Palette.accentTeal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const _CodeBlock('''
   ┌───────────────┐        WM_SIZE / WM_CLOSE / WM_DESTROY
   │   Win32 OS    │ ───────────────────────────────────────► WndProc
   └───────────────┘                                              │
                                                                  ▼
                          ┌─────────────────────────────────────────┐
                          │ InternalFlutterWindows_WindowManager_   │
                          │ Initialize → onMessage(NativeCallable)  │
                          └─────────────────────────────────────────┘
                                                                  │
                                                                  ▼
                          ┌─────────────────────────────────────────┐
                          │ WindowingOwnerWin32._onMessage          │
                          │   → fan-out to _WindowsMessageHandler   │
                          └─────────────────────────────────────────┘
                                                                  │
                                                                  ▼
                          RegularWindowControllerWin32._handleWindowsMessage
                            • WM_CLOSE   → delegate.onWindowCloseRequested
                            • WM_DESTROY → delegate.onWindowDestroyed
                            • WM_SIZE / WM_ACTIVATE → notifyListeners()
'''),
          const SizedBox(height: 10),
          const Text(
            'In our mirror the pump is collapsed: setSize() / setMaximized() / '
            'requestClose() / destroy() drive the same delegate hooks that the '
            'real WndProc would, and every transition is appended to the live '
            'event log at the bottom of the page.',
            style: _Type.body,
          ),
        ],
      ),
    );
  }
}

// =============================================================================
//  Section 9 — Owner instantiation.
// =============================================================================

class _OwnerInstantiationSection extends StatelessWidget {
  const _OwnerInstantiationSection({required this.owner});
  final WindowingOwnerWin32Mirror owner;

  @override
  Widget build(BuildContext context) {
    final WindowingOwnerWin32Mirror localOwner = owner;
    final WindowingOwnerMirror baseOwner = localOwner;
    final List<WindowingOwnerWin32Mirror> owners = <WindowingOwnerWin32Mirror>[localOwner];
    final Map<String, WindowingOwnerWin32Mirror> registry =
        <String, WindowingOwnerWin32Mirror>{'primary': localOwner};

    return _SectionCard(
      title: 'Live owner instantiation',
      subtitle: 'WindowingOwnerWin32 used as a value, a base type, and a generic argument.',
      icon: Icons.power_settings_new,
      accent: _Palette.accentGreen,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Text(
            'The class is referenced live below: a direct constructor call on '
            'the mirror, an upcast to the abstract owner, a List<...> of '
            'owners, and a Map<String, ...>.',
            style: _Type.body,
          ),
          const SizedBox(height: 12),
          _CodeBlock('''
final WindowingOwnerWin32 localOwner = WindowingOwnerWin32();
final WindowingOwner       baseOwner = localOwner;
final List<WindowingOwnerWin32>          owners   = <WindowingOwnerWin32>[localOwner];
final Map<String, WindowingOwnerWin32>   registry = {'primary': localOwner};
// — runtime view —
runtimeType : ${localOwner.runtimeType}
baseType    : ${baseOwner.runtimeType}
owners.len  : ${owners.length}
registry.len: ${registry.length}'''),
          const SizedBox(height: 8),
          Text(
            'baseOwner.runtimeType == WindowingOwnerWin32Mirror : '
            '${baseOwner.runtimeType == WindowingOwnerWin32Mirror}',
            style: _Type.small,
          ),
        ],
      ),
    );
  }
}

// =============================================================================
//  Section 10 — Controller lifecycle.
// =============================================================================

class _ControllerLifecycleSection extends StatefulWidget {
  const _ControllerLifecycleSection({required this.owner});
  final WindowingOwnerWin32Mirror owner;

  @override
  State<_ControllerLifecycleSection> createState() => _ControllerLifecycleSectionState();
}

class _ControllerLifecycleSectionState extends State<_ControllerLifecycleSection> {
  RegularWindowControllerWin32Mirror? _controller;

  @override
  void dispose() {
    _controller?.destroy();
    super.dispose();
  }

  void _spawn() {
    setState(() {
      _controller = widget.owner.createRegularWindowController(
        delegate: RegularWindowControllerDelegateMirror(
          onDestroyed: (_) => setState(() => _controller = null),
        ),
        title: 'Lifecycle Demo',
        preferredSize: const Size(560, 320),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final RegularWindowControllerWin32Mirror? c = _controller;
    return _SectionCard(
      title: 'Controller lifecycle',
      subtitle: 'create → activate → deactivate → destroy on a real mirror controller.',
      icon: Icons.refresh,
      accent: _Palette.accentBlue,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              ElevatedButton.icon(
                onPressed: c == null ? _spawn : null,
                icon: const Icon(Icons.add),
                label: const Text('createRegularWindowController(...)'),
              ),
              const SizedBox(width: 10),
              ElevatedButton.icon(
                onPressed: c?.activate,
                icon: const Icon(Icons.play_arrow),
                label: const Text('activate()'),
              ),
              const SizedBox(width: 10),
              ElevatedButton.icon(
                onPressed: c?.deactivate,
                icon: const Icon(Icons.pause),
                label: const Text('deactivate()'),
              ),
              const SizedBox(width: 10),
              ElevatedButton.icon(
                onPressed: c?.destroy,
                icon: const Icon(Icons.delete_outline),
                label: const Text('destroy()'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _Palette.accentRed,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          if (c == null)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _Palette.panelStroke.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text('No controller. Press "create" to spawn one.',
                  style: _Type.small),
            )
          else
            _Win32WindowChrome(
              controller: c,
              body: const Center(
                child: Text(
                  'I am a live RegularWindowControllerWin32 mirror.',
                  style: _Type.body,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// =============================================================================
//  Section 11 — Resize playground.
// =============================================================================

class _ResizePlaygroundSection extends StatefulWidget {
  const _ResizePlaygroundSection({required this.controller});
  final RegularWindowControllerWin32Mirror controller;

  @override
  State<_ResizePlaygroundSection> createState() => _ResizePlaygroundSectionState();
}

class _ResizePlaygroundSectionState extends State<_ResizePlaygroundSection> {
  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Resize playground',
      subtitle: 'Drag sliders → setSize / setMinimumSize / setMaximumSize.',
      icon: Icons.straighten,
      accent: _Palette.accentTeal,
      child: AnimatedBuilder(
        animation: widget.controller,
        builder: (BuildContext context, Widget? _) {
          final Size s = widget.controller.contentSize;
          final BoxConstraints c = widget.controller.constraints;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _SliderRow(
                label: 'width',
                value: s.width,
                min: 200,
                max: 1600,
                onChanged: (double v) =>
                    widget.controller.setSize(Size(v, s.height)),
              ),
              _SliderRow(
                label: 'height',
                value: s.height,
                min: 150,
                max: 1000,
                onChanged: (double v) =>
                    widget.controller.setSize(Size(s.width, v)),
              ),
              _SliderRow(
                label: 'minWidth',
                value: c.minWidth,
                min: 100,
                max: 800,
                onChanged: (double v) =>
                    widget.controller.setMinimumSize(Size(v, c.minHeight)),
              ),
              _SliderRow(
                label: 'maxWidth',
                value: c.maxWidth.isFinite ? c.maxWidth : 1600,
                min: 400,
                max: 2400,
                onChanged: (double v) =>
                    widget.controller.setMaximumSize(Size(v, c.maxHeight.isFinite ? c.maxHeight : 1600)),
              ),
              const SizedBox(height: 8),
              _Win32WindowChrome(
                controller: widget.controller,
                height: 200,
                body: Text(
                  'contentSize = ${s.width.toStringAsFixed(0)} × '
                  '${s.height.toStringAsFixed(0)}\n'
                  'constraints = ${c.minWidth.toStringAsFixed(0)}…'
                  '${c.maxWidth.isFinite ? c.maxWidth.toStringAsFixed(0) : '∞'} × '
                  '${c.minHeight.toStringAsFixed(0)}…'
                  '${c.maxHeight.isFinite ? c.maxHeight.toStringAsFixed(0) : '∞'}',
                  style: _Type.body,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _SliderRow extends StatelessWidget {
  const _SliderRow({
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
  });

  final String label;
  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    final double clamped = value.clamp(min, max);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: <Widget>[
          SizedBox(
              width: 90,
              child: Text(label, style: _Type.body.copyWith(fontWeight: FontWeight.w500))),
          Expanded(
            child: Slider(
              value: clamped,
              min: min,
              max: max,
              onChanged: onChanged,
            ),
          ),
          SizedBox(
            width: 70,
            child: Text(clamped.toStringAsFixed(0),
                textAlign: TextAlign.right, style: _Type.small),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
//  Section 12 — Maximize / restore.
// =============================================================================

class _MaximizeRestoreSection extends StatelessWidget {
  const _MaximizeRestoreSection({required this.controller});
  final RegularWindowControllerWin32Mirror controller;

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Maximize / restore',
      subtitle: 'ShowWindow(SW_MAXIMIZE) ↔ ShowWindow(SW_RESTORE)',
      icon: Icons.crop_square,
      accent: _Palette.accentBlue,
      child: AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget? _) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: <Widget>[
                  ElevatedButton.icon(
                    onPressed: () => controller.setMaximized(true),
                    icon: const Icon(Icons.crop_square),
                    label: const Text('SW_MAXIMIZE'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton.icon(
                    onPressed: () => controller.setMaximized(false),
                    icon: const Icon(Icons.filter_none),
                    label: const Text('SW_RESTORE'),
                  ),
                  const SizedBox(width: 14),
                  Text('isMaximized = ${controller.isMaximized}', style: _Type.body),
                ],
              ),
              const SizedBox(height: 12),
              _Win32WindowChrome(
                controller: controller,
                height: controller.isMaximized ? 320 : 200,
                body: Center(
                  child: Text(
                    controller.isMaximized
                        ? 'Maximized: snapped to the work area.'
                        : 'Restored to last placement.',
                    style: _Type.body,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// =============================================================================
//  Section 13 — Minimize to taskbar.
// =============================================================================

class _MinimizeSection extends StatelessWidget {
  const _MinimizeSection({required this.controller});
  final RegularWindowControllerWin32Mirror controller;

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Minimize to taskbar',
      subtitle: 'ShowWindow(SW_MINIMIZE) and the taskbar entry that survives.',
      icon: Icons.minimize,
      accent: _Palette.accentTeal,
      child: AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget? _) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: <Widget>[
                  ElevatedButton.icon(
                    onPressed: () => controller.setMinimized(true),
                    icon: const Icon(Icons.minimize),
                    label: const Text('SW_MINIMIZE'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton.icon(
                    onPressed: () => controller.setMinimized(false),
                    icon: const Icon(Icons.open_in_full),
                    label: const Text('SW_RESTORE'),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              if (controller.isMinimized)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: _Palette.taskbar,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    children: <Widget>[
                      const Icon(Icons.window, color: Colors.white, size: 16),
                      const SizedBox(width: 8),
                      Text(controller.title,
                          style: _Type.small.copyWith(color: Colors.white)),
                      const Spacer(),
                      Text('TASKBAR ENTRY',
                          style: _Type.caption.copyWith(color: Colors.white70)),
                    ],
                  ),
                )
              else
                _Win32WindowChrome(
                  controller: controller,
                  body: const Center(
                    child: Text('Press SW_MINIMIZE — I will collapse to the taskbar.',
                        style: _Type.body),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

// =============================================================================
//  Section 14 — Fullscreen.
// =============================================================================

class _FullscreenSection extends StatelessWidget {
  const _FullscreenSection({required this.controller});
  final RegularWindowControllerWin32Mirror controller;

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Fullscreen',
      subtitle: 'SetFullscreen() hides the caption strip and status bar.',
      icon: Icons.fullscreen,
      accent: _Palette.accentBlue,
      child: AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget? _) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: <Widget>[
                  ElevatedButton.icon(
                    onPressed: () => controller.setFullscreen(!controller.isFullscreen),
                    icon: Icon(controller.isFullscreen
                        ? Icons.fullscreen_exit
                        : Icons.fullscreen),
                    label:
                        Text(controller.isFullscreen ? 'Exit fullscreen' : 'Enter fullscreen'),
                  ),
                  const SizedBox(width: 14),
                  Text('isFullscreen = ${controller.isFullscreen}', style: _Type.body),
                ],
              ),
              const SizedBox(height: 12),
              _Win32WindowChrome(
                controller: controller,
                height: controller.isFullscreen ? 260 : 200,
                body: Center(
                  child: Text(
                    controller.isFullscreen
                        ? 'Fullscreen — non-client area is suppressed.'
                        : 'Windowed — caption + menu + status visible.',
                    style: _Type.body,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// =============================================================================
//  Section 15 — Close-with-delegate (veto on unsaved changes).
// =============================================================================

class _CloseDelegateSection extends StatefulWidget {
  const _CloseDelegateSection({required this.owner});
  final WindowingOwnerWin32Mirror owner;

  @override
  State<_CloseDelegateSection> createState() => _CloseDelegateSectionState();
}

class _CloseDelegateSectionState extends State<_CloseDelegateSection> {
  RegularWindowControllerWin32Mirror? _controller;
  bool _unsavedChanges = true;

  @override
  void initState() {
    super.initState();
    _spawn();
  }

  @override
  void dispose() {
    _controller?.destroy();
    super.dispose();
  }

  void _spawn() {
    final delegate = RegularWindowControllerDelegateMirror(
      shouldVetoClose: (_) => _unsavedChanges,
      onDestroyed: (_) => setState(() => _controller = null),
    );
    setState(() {
      _controller = widget.owner.createRegularWindowController(
        delegate: delegate,
        title: 'Editor — *unsaved.txt',
        preferredSize: const Size(620, 320),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final RegularWindowControllerWin32Mirror? c = _controller;
    return _SectionCard(
      title: 'Close with delegate veto',
      subtitle: 'WM_CLOSE → delegate.onWindowCloseRequested → optional veto.',
      icon: Icons.cancel_outlined,
      accent: _Palette.accentAmber,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Switch(
                value: _unsavedChanges,
                onChanged: (bool v) => setState(() => _unsavedChanges = v),
              ),
              const SizedBox(width: 8),
              const Text('Has unsaved changes (close vetoed)', style: _Type.body),
              const Spacer(),
              if (c == null)
                ElevatedButton(onPressed: _spawn, child: const Text('Respawn'))
              else
                ElevatedButton.icon(
                  onPressed: c.requestClose,
                  icon: const Icon(Icons.close),
                  label: const Text('Click [×] / requestClose()'),
                ),
            ],
          ),
          const SizedBox(height: 12),
          if (c != null)
            _Win32WindowChrome(
              controller: c,
              body: const Center(
                child: Text(
                  'Toggle the switch off then click [×] — the delegate will '
                  'allow destroy() to run.',
                  style: _Type.body,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// =============================================================================
//  Section 16 — Multi-window orchestration (cascade / snap-left / snap-right).
// =============================================================================

class _MultiWindowSection extends StatefulWidget {
  const _MultiWindowSection({required this.owner});
  final WindowingOwnerWin32Mirror owner;

  @override
  State<_MultiWindowSection> createState() => _MultiWindowSectionState();
}

class _MultiWindowSectionState extends State<_MultiWindowSection> {
  String _layout = 'cascade';

  void _setLayout(String l) {
    setState(() => _layout = l);
    final List<RegularWindowControllerWin32Mirror> windows = widget.owner.windows;
    for (int i = 0; i < windows.length; i++) {
      final RegularWindowControllerWin32Mirror w = windows[i];
      switch (l) {
        case 'cascade':
          w.setSize(const Size(620, 380));
          w.setMaximized(false);
          break;
        case 'snap-left':
          w.setSize(const Size(540, 520));
          w.setMaximized(false);
          break;
        case 'snap-right':
          w.setSize(const Size(540, 520));
          w.setMaximized(false);
          break;
        case 'tile':
          w.setSize(const Size(420, 280));
          w.setMaximized(false);
          break;
      }
    }
    widget.owner.log.add('Snap layout -> $l');
  }

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Multi-window orchestration',
      subtitle: 'Cascade · Snap left · Snap right · Tile across the desktop.',
      icon: Icons.dashboard_outlined,
      accent: _Palette.accentTeal,
      child: AnimatedBuilder(
        animation: widget.owner.log,
        builder: (BuildContext context, Widget? _) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Wrap(
                spacing: 8,
                children: <Widget>[
                  for (final String l in const <String>[
                    'cascade',
                    'snap-left',
                    'snap-right',
                    'tile',
                  ])
                    ChoiceChip(
                      label: Text(l),
                      selected: _layout == l,
                      onSelected: (_) => _setLayout(l),
                    ),
                ],
              ),
              const SizedBox(height: 14),
              _Desktop(owner: widget.owner, layout: _layout),
            ],
          );
        },
      ),
    );
  }
}

class _Desktop extends StatelessWidget {
  const _Desktop({required this.owner, required this.layout});
  final WindowingOwnerWin32Mirror owner;
  final String layout;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[_Palette.desktopTop, _Palette.desktopBottom],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF20446B)),
      ),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final List<RegularWindowControllerWin32Mirror> ws = owner.windows;
          return Stack(
            children: <Widget>[
              for (int i = 0; i < ws.length; i++)
                _positioned(constraints, i, ws.length, ws[i]),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: _TaskbarStrip(owner: owner),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _positioned(
    BoxConstraints box,
    int i,
    int n,
    RegularWindowControllerWin32Mirror w,
  ) {
    double left;
    double top;
    double width;
    double height;
    switch (layout) {
      case 'snap-left':
        left = 0;
        top = 0;
        width = (box.maxWidth - 8) / 2;
        height = box.maxHeight - 38;
        if (i.isOdd) {
          left = width + 8;
        }
        break;
      case 'snap-right':
        width = (box.maxWidth - 8) / 2;
        height = box.maxHeight - 38;
        left = i.isOdd ? 0 : width + 8;
        top = 0;
        break;
      case 'tile':
        final int cols = 2;
        final int rows = ((n + cols - 1) ~/ cols).clamp(1, 4);
        width = (box.maxWidth - 8 * (cols - 1)) / cols;
        height = (box.maxHeight - 38 - 8 * (rows - 1)) / rows;
        left = (i % cols) * (width + 8);
        top = (i ~/ cols) * (height + 8);
        break;
      case 'cascade':
      default:
        width = box.maxWidth * 0.6;
        height = (box.maxHeight - 38) * 0.65;
        left = (i * 28).toDouble();
        top = (i * 24).toDouble();
        break;
    }
    return Positioned(
      left: left,
      top: top,
      width: width,
      height: height,
      child: _MiniWindow(controller: w),
    );
  }
}

class _MiniWindow extends StatelessWidget {
  const _MiniWindow({required this.controller});
  final RegularWindowControllerWin32Mirror controller;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: controller.activate,
      child: AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget? _) {
          final bool a = controller.isActivated;
          return Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: a ? _Palette.accentBlue : Colors.black26,
                width: a ? 1.5 : 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  height: 22,
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  decoration: BoxDecoration(
                    color: a ? _Palette.accentBlue : _Palette.chromeInactive,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(3)),
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(controller.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: _Type.caption.copyWith(color: Colors.white)),
                      ),
                      const Icon(Icons.minimize, size: 10, color: Colors.white),
                      const SizedBox(width: 6),
                      const Icon(Icons.crop_square, size: 10, color: Colors.white),
                      const SizedBox(width: 6),
                      const Icon(Icons.close, size: 10, color: Colors.white),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    alignment: Alignment.center,
                    child: Text('HWND ${controller.handle}', style: _Type.small),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _TaskbarStrip extends StatelessWidget {
  const _TaskbarStrip({required this.owner});
  final WindowingOwnerWin32Mirror owner;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      padding: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: _Palette.taskbar,
        borderRadius: BorderRadius.circular(6),
      ),
      child: AnimatedBuilder(
        animation: owner.log,
        builder: (BuildContext context, Widget? _) {
          return Row(
            children: <Widget>[
              const Icon(Icons.window, color: Colors.white, size: 16),
              const SizedBox(width: 10),
              for (final RegularWindowControllerWin32Mirror w in owner.windows)
                _TaskbarEntry(controller: w),
              const Spacer(),
              Text(TimeOfDay.now().format(context),
                  style: _Type.caption.copyWith(color: Colors.white70)),
              const SizedBox(width: 6),
            ],
          );
        },
      ),
    );
  }
}

class _TaskbarEntry extends StatelessWidget {
  const _TaskbarEntry({required this.controller});
  final RegularWindowControllerWin32Mirror controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget? _) {
        final bool a = controller.isActivated;
        final bool flash = controller.flashing;
        return GestureDetector(
          onTap: () {
            if (controller.isMinimized) {
              controller.setMinimized(false);
            }
            controller.activate();
          },
          child: Container(
            height: 22,
            margin: const EdgeInsets.symmetric(horizontal: 3),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: flash
                  ? _Palette.accentAmber
                  : (a ? _Palette.taskbarHi : Colors.transparent),
              borderRadius: BorderRadius.circular(3),
              border: Border.all(
                color: a ? _Palette.accentBlue : Colors.transparent,
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              controller.title.length > 16
                  ? '${controller.title.substring(0, 16)}…'
                  : controller.title,
              style: _Type.caption.copyWith(color: Colors.white),
            ),
          ),
        );
      },
    );
  }
}

// =============================================================================
//  Section 17 — Flash taskbar.
// =============================================================================

class _FlashTaskbarSection extends StatelessWidget {
  const _FlashTaskbarSection({required this.controller});
  final RegularWindowControllerWin32Mirror controller;

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Flash taskbar entry',
      subtitle: 'FlashWindowEx attention pattern (mirror-only helper).',
      icon: Icons.notifications_active,
      accent: _Palette.accentAmber,
      child: AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget? _) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: <Widget>[
                  ElevatedButton.icon(
                    onPressed: () => controller.flashTaskbar(flashing: true),
                    icon: const Icon(Icons.flash_on),
                    label: const Text('flashTaskbar()'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton.icon(
                    onPressed: () => controller.flashTaskbar(flashing: false),
                    icon: const Icon(Icons.flash_off),
                    label: const Text('stop'),
                  ),
                  const SizedBox(width: 14),
                  Text('flashing = ${controller.flashing}', style: _Type.body),
                ],
              ),
              const SizedBox(height: 12),
              const Text(
                'FlashWindowEx is not surfaced through the public Win32 owner '
                'in current Flutter, but it is a common Win32 recipe — so the '
                'mirror exposes it for completeness.',
                style: _Type.body,
              ),
            ],
          );
        },
      ),
    );
  }
}

// =============================================================================
//  Section 18 — Recipe gallery.
// =============================================================================

class _RecipeGallerySection extends StatelessWidget {
  static const List<_Recipe> _recipes = <_Recipe>[
    _Recipe(
      'Centred splash',
      'Spawn a small splash window above all others and dismiss after init.',
      'final c = owner.createRegularWindowController(\n'
          '  delegate: RegularWindowControllerDelegateMirror(),\n'
          '  preferredSize: const Size(360, 240),\n'
          '  title: "Loading...",\n'
          ');\n'
          'await Future<void>.delayed(const Duration(seconds: 2));\n'
          'c.destroy();',
    ),
    _Recipe(
      'Designer + Preview',
      'Two windows: editor on the left, live preview on the right.',
      'final editor  = owner.createRegularWindowController(title: "Editor");\n'
          'final preview = owner.createRegularWindowController(title: "Preview");\n'
          'editor.setSize(const Size(720, 600));\n'
          'preview.setSize(const Size(540, 600));',
    ),
    _Recipe(
      'Modal-ish dialog',
      'A regular window flagged as modal-by-convention. Dialogs use a '
          'separate DialogWindowControllerWin32 in the SDK.',
      'final dialog = owner.createRegularWindowController(\n'
          '  delegate: RegularWindowControllerDelegateMirror(\n'
          '    shouldVetoClose: (c) => !c.title.startsWith("OK"),\n'
          '  ),\n'
          '  title: "Confirm",\n'
          ');',
    ),
    _Recipe(
      'Detached tool window',
      'Spawn a panel, snap to the right edge, and pin via setMinimumSize.',
      'final tool = owner.createRegularWindowController(title: "Tools");\n'
          'tool.setSize(const Size(320, 600));\n'
          'tool.setMinimumSize(const Size(280, 480));',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Recipe gallery',
      subtitle: 'Hand-rolled patterns built on the WindowingOwnerWin32 surface.',
      icon: Icons.menu_book_outlined,
      accent: _Palette.accentTeal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          for (final _Recipe r in _recipes) ...<Widget>[
            Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: const Color(0xFFF7FAFD),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: _Palette.panelStroke),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(r.title,
                      style: _Type.body.copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 4),
                  Text(r.description, style: _Type.small),
                  const SizedBox(height: 8),
                  _CodeBlock(r.code),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _Recipe {
  const _Recipe(this.title, this.description, this.code);
  final String title;
  final String description;
  final String code;
}

// =============================================================================
//  Section 19 — Pitfalls.
// =============================================================================

class _PitfallsSection extends StatelessWidget {
  static const List<List<String>> _pitfalls = <List<String>>[
    <String>[
      'DPI awareness',
      'A WindowingOwnerWin32 created before the process declares per-monitor '
          'DPI awareness will paint blurry on high-DPI displays. Set the '
          'manifest before instantiating the owner.',
    ],
    <String>[
      'Message-pump reentrancy',
      'Calling `destroy()` from inside a delegate hook is fine, but calling '
          '`createRegularWindowController` from inside `_onMessage` re-enters '
          'the pump — keep window creation on the next microtask.',
    ],
    <String>[
      'isWindowingEnabled',
      'Both `WindowingOwnerWin32` and `RegularWindowControllerWin32` throw '
          'UnsupportedError when the windowing feature flag is off. Always '
          'guard the call site.',
    ],
    <String>[
      'CoTaskMemAlloc allocator',
      'The owner allocates request structs through `_CallocAllocator`, which '
          'wraps `ole32.dll!CoTaskMemAlloc`. Custom test allocators must '
          'implement `ffi.Allocator` correctly or the engine will leak.',
    ],
    <String>[
      'WM_NCHITTEST customization',
      'Custom drag regions and resize hit-testing happen on the engine side. '
          'The Dart-level owner only sees the post-hit-test messages.',
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Pitfalls & gotchas',
      subtitle: 'Things that bite when you adopt this API.',
      icon: Icons.warning_amber_outlined,
      accent: _Palette.accentRed,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          for (final List<String> p in _pitfalls)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Icon(Icons.error_outline,
                      size: 16, color: _Palette.accentRed),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(p[0],
                            style: _Type.body.copyWith(fontWeight: FontWeight.w600)),
                        const SizedBox(height: 2),
                        Text(p[1], style: _Type.small),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

// =============================================================================
//  Section 20 — Reference table.
// =============================================================================

class _ReferenceTableSection extends StatelessWidget {
  static const List<List<String>> _rows = <List<String>>[
    <String>['WindowingOwnerWin32()',
        'allocator = _CallocAllocator()', 'Sets up FFI, registers _onMessage'],
    <String>['createRegularWindowController(...)',
        'RegularWindowControllerWin32', 'Owner factory used by RegularWindow'],
    <String>['createDialogWindowController(...)',
        'DialogWindowControllerWin32', 'Modal-ish dialog with optional parent'],
    <String>['_addMessageHandler / _removeMessageHandler',
        '—', 'Internal pump fan-out'],
    <String>['controller.setSize(Size)',
        '—', 'WM_SIZE → notifyListeners()'],
    <String>['controller.setConstraints(BoxConstraints)',
        '—', 'Re-applies min/max'],
    <String>['controller.setMaximized(bool)',
        '—', 'ShowWindow(SW_MAXIMIZE / SW_RESTORE)'],
    <String>['controller.setMinimized(bool)',
        '—', 'ShowWindow(SW_MINIMIZE / SW_RESTORE)'],
    <String>['controller.setFullscreen(bool, {Display? display})',
        '—', 'SetFullscreen on requested monitor'],
    <String>['controller.activate()',
        '—', 'ShowWindow(SW_RESTORE) + bring to top'],
    <String>['controller.destroy()',
        '—', 'DestroyWindow + delegate.onWindowDestroyed'],
  ];

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Reference table',
      subtitle: 'Method · return · effect (cite-by-line in _window_win32.dart).',
      icon: Icons.table_chart_outlined,
      accent: _Palette.accentBlue,
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            color: _Palette.panelStroke.withValues(alpha: 0.4),
            child: Row(
              children: const <Widget>[
                Expanded(
                    flex: 4,
                    child: Text('member',
                        style: TextStyle(fontWeight: FontWeight.w700))),
                Expanded(
                    flex: 3,
                    child: Text('returns',
                        style: TextStyle(fontWeight: FontWeight.w700))),
                Expanded(
                    flex: 5,
                    child: Text('effect',
                        style: TextStyle(fontWeight: FontWeight.w700))),
              ],
            ),
          ),
          for (final List<String> r in _rows)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: _Palette.panelStroke)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(flex: 4, child: Text(r[0], style: _Type.small)),
                  Expanded(flex: 3, child: Text(r[1], style: _Type.small)),
                  Expanded(flex: 5, child: Text(r[2], style: _Type.small)),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

// =============================================================================
//  Section 21 — Live event log.
// =============================================================================

class _EventLogSection extends StatelessWidget {
  const _EventLogSection({required this.log});
  final EventLogMirror log;

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Live event log',
      subtitle: 'Every method call on the mirror appears here.',
      icon: Icons.terminal,
      accent: _Palette.accentTeal,
      child: AnimatedBuilder(
        animation: log,
        builder: (BuildContext context, Widget? _) {
          final List<String> tail = log.entries.length > 60
              ? log.entries.sublist(log.entries.length - 60)
              : List<String>.of(log.entries);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text('${log.entries.length} message'
                      '${log.entries.length == 1 ? '' : 's'}',
                      style: _Type.body),
                  const Spacer(),
                  TextButton.icon(
                    onPressed: log.clear,
                    icon: const Icon(Icons.clear_all),
                    label: const Text('clear'),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Container(
                height: 220,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _Palette.codeBg,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: ListView.builder(
                  reverse: true,
                  itemCount: tail.length,
                  itemBuilder: (BuildContext context, int i) {
                    final String entry = tail[tail.length - 1 - i];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 1),
                      child: Text(entry,
                          style: _Type.code.copyWith(
                            color: _Palette.codeAccent,
                          )),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// =============================================================================
//  Section 22 — Footer.
// =============================================================================

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF101A28),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF22384F)),
      ),
      child: Row(
        children: <Widget>[
          const Icon(Icons.info_outline, color: Colors.white70, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'WindowingOwnerWin32 lives in package:flutter/src/widgets/_window_win32.dart, '
              'is @internal, and is gated by isWindowingEnabled. This demo uses a '
              'shape-faithful local mirror so the API can be exercised live, '
              'without importing the SDK private surface.',
              style: _Type.small.copyWith(color: const Color(0xFFB7C4D6)),
            ),
          ),
        ],
      ),
    );
  }
}
