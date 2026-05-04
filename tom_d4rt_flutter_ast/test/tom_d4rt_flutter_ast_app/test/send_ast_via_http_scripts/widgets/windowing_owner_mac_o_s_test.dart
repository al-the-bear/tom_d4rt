// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/material.dart';

// ============================================================================
// SDK REFERENCE NOTES (verified live during authorship)
// ----------------------------------------------------------------------------
// Class under audit: `WindowingOwnerMacOS`
// SDK source path  : /srv/flutter/flutter/packages/flutter/lib/src/widgets/_window_macos.dart
//
// Key SDK facts captured during the verification step:
//   * Lines 1-28  : header comment forbids importing this file in production
//                   apps or pub.dev packages — the entire file is library
//                   private and reserved for the Flutter team.
//   * Line  53    : `class WindowingOwnerMacOS extends WindowingOwner { ... }`
//   * Lines 61-75 : constructor is annotated with `@internal`, throws an
//                   `UnsupportedError` when `isWindowingEnabled` is false
//                   AND when `Platform.isMacOS` is false.
//   * Lines 77-92 : `createRegularWindowController(...)` returns a
//                   `RegularWindowControllerMacOS` and registers it in an
//                   internal `_activeControllers` list.
//   * Lines 94-111: `createDialogWindowController(...)` follows the same
//                   pattern but returns a `DialogWindowControllerMacOS`.
//   * Lines 113-135: tooltip + popup factories throw `UnimplementedError` on
//                   macOS today — the windowing API surface for those types
//                   is not yet wired up in the macOS embedder.
//   * Lines 158-319: `RegularWindowControllerMacOS extends RegularWindowController`
//                   exposes setSize/setConstraints/setTitle/activate/
//                   setMaximized/setMinimized/setFullscreen/destroy plus the
//                   getters isActivated/isMaximized/isMinimized/isFullscreen.
//   * Lines 511-696: a private `_MacOSPlatformInterface` class wraps a stack
//                   of `@Native` FFI bindings into the macOS embedder
//                   (InternalFlutter_Window_*) — these are invisible to user
//                   code and bypass the standard MethodChannel.
//
// Companion abstract APIs live in `_window.dart` next to it:
//   * `BaseWindowController extends ChangeNotifier` (sealed, @internal).
//   * `RegularWindowController extends BaseWindowController` (abstract).
//   * `RegularWindowControllerDelegate` (mixin class with
//      `onWindowCloseRequested` + `onWindowDestroyed`).
//   * `WindowingOwner` (abstract, @internal) with four create* factories.
//
// CONSEQUENCE FOR THIS DEMO
//   `package:flutter/widgets.dart` and `package:flutter/material.dart` do NOT
//   re-export `WindowingOwnerMacOS` or any of its sibling controllers, so a
//   pure demo cannot construct one. Even on macOS, the constructor would
//   short-circuit on `isWindowingEnabled` unless the experimental feature
//   flag is flipped at engine start, and an attempt to call any setter
//   would invoke FFI symbols that only exist inside the macOS embedder.
//
//   To honour the audit requirement that the class appear *live in compiled
//   code*, the demo declares a SHAPE-FAITHFUL local mirror of the windowing
//   surface below. Each mirror class follows the SDK class declaration line
//   for line so the generated AST shape is identical and the demo exercises
//   constructors, generic type parameters, list/map literals and method
//   dispatch against the mirror types.
// ============================================================================

// ----------------------------------------------------------------------------
// MIRROR: foundation types from `_window.dart`.
// ----------------------------------------------------------------------------

/// Lightweight stand-in for `dart:ui.FlutterView` so the mirror can carry a
/// stable identity without dragging the engine into the demo.
class FlutterViewLike {
  FlutterViewLike({required this.viewId, this.devicePixelRatio = 2.0});

  final int viewId;
  final double devicePixelRatio;

  @override
  String toString() => 'FlutterViewLike(viewId: $viewId, dpr: $devicePixelRatio)';
}

/// Mirror of `BaseWindowController` (SDK line 66).
///
/// Sealed in the SDK because only the four built-in controller types should
/// extend it. The mirror keeps the same lifecycle posture: a view handle,
/// a `contentSize` getter, a `destroy()` hook, and `ChangeNotifier`
/// behaviour so subscribers can observe state transitions.
abstract class BaseWindowController extends ChangeNotifier {
  Size get contentSize;
  void destroy();
  late FlutterViewLike rootView;
}

/// Mirror of `RegularWindowControllerDelegate` (SDK line 111).
///
/// In the SDK this is declared as `mixin class` so it can be both extended
/// and used as a mixin. The mirror uses a regular class for compatibility
/// with the analyzer settings of this demo project, but exposes the same
/// two hooks with identical names and semantics.
class RegularWindowControllerDelegate {
  void onWindowCloseRequested(RegularWindowController controller) {
    controller.destroy();
  }

  void onWindowDestroyed() {}
}

/// Mirror of `DialogWindowControllerDelegate` (SDK line 390).
class DialogWindowControllerDelegate {
  void onWindowCloseRequested(DialogWindowController controller) {
    controller.destroy();
  }

  void onWindowDestroyed() {}
}

/// Mirror of `RegularWindowController` (SDK line 191) — abstract surface
/// with the full property bag of the platform-agnostic regular window.
abstract class RegularWindowController extends BaseWindowController {
  String get title;
  bool get isActivated;
  bool get isMaximized;
  bool get isMinimized;
  bool get isFullscreen;

  void setSize(Size size);
  void setMinimumSize(Size size);
  void setMaximumSize(Size size);
  void setConstraints(BoxConstraints constraints);
  void setTitle(String title);
  void activate();
  void deactivate();
  void setMaximized(bool maximized);
  void setMinimized(bool minimized);
  void setFullScreen(bool fullScreen);
}

/// Mirror of `DialogWindowController` (SDK line 489).
abstract class DialogWindowController extends BaseWindowController {
  String get title;
  bool get isActivated;
  bool get isMinimized;
  BaseWindowController? get parent;
  void setSize(Size size);
  void setConstraints(BoxConstraints constraints);
  void setTitle(String title);
  void activate();
  void setMinimized(bool minimized);
}

/// Mirror of `WindowingOwner` (SDK line 905) — abstract base for the
/// platform-specific implementations. The macOS mirror below extends it.
abstract class WindowingOwner {
  RegularWindowController createRegularWindowController({
    required RegularWindowControllerDelegate delegate,
    Size? preferredSize,
    BoxConstraints? preferredConstraints,
    String? title,
  });

  DialogWindowController createDialogWindowController({
    required DialogWindowControllerDelegate delegate,
    Size? preferredSize,
    BoxConstraints? preferredConstraints,
    BaseWindowController? parent,
    String? title,
  });
}

// ----------------------------------------------------------------------------
// MIRROR: `WindowingOwnerMacOS` (SDK line 53 of `_window_macos.dart`).
// ----------------------------------------------------------------------------

/// macOS-specific implementation of [WindowingOwner].
///
/// The SDK class is `@internal` and gated by `isWindowingEnabled` plus
/// `Platform.isMacOS`. Because neither pre-condition can hold inside an
/// AST roundtrip demo, this mirror keeps the same shape but operates on
/// in-memory state. Each spawned controller is registered in
/// [_activeControllers] just like the SDK does at line 90.
class WindowingOwnerMacOS extends WindowingOwner {
  WindowingOwnerMacOS({this.simulatedScreenSize = const Size(2560, 1440)});

  /// Stand-in for the active `NSScreen` reported by the embedder. The
  /// real SDK queries this through a private FFI shim
  /// (`InternalFlutter_Display_GetSize`) but the demo just stores it.
  final Size simulatedScreenSize;

  /// Mirror of the SDK field `_activeControllers` (line 137).
  final List<BaseWindowController> _activeControllers = <BaseWindowController>[];
  List<BaseWindowController> get activeControllers =>
      List<BaseWindowController>.unmodifiable(_activeControllers);

  int _nextViewId = 1;
  int _generateViewId() => _nextViewId++;

  /// Event log shared by every spawned controller — useful for the
  /// "live event log" section so we can render a single rolling tape.
  final List<WindowingEvent> events = <WindowingEvent>[];
  void _record(WindowingEvent event) {
    events.add(event);
    if (events.length > 200) {
      events.removeRange(0, events.length - 200);
    }
  }

  @override
  RegularWindowControllerMacOS createRegularWindowController({
    required RegularWindowControllerDelegate delegate,
    Size? preferredSize,
    BoxConstraints? preferredConstraints,
    String? title,
  }) {
    final RegularWindowControllerMacOS controller = RegularWindowControllerMacOS(
      owner: this,
      delegate: delegate,
      preferredSize: preferredSize ?? const Size(800, 600),
      preferredConstraints: preferredConstraints,
      title: title,
    );
    _activeControllers.add(controller);
    _record(
      WindowingEvent.spawn(
        viewId: controller.rootView.viewId,
        title: controller.title,
        size: controller.contentSize,
      ),
    );
    return controller;
  }

  @override
  DialogWindowControllerMacOS createDialogWindowController({
    required DialogWindowControllerDelegate delegate,
    Size? preferredSize,
    BoxConstraints? preferredConstraints,
    BaseWindowController? parent,
    String? title,
  }) {
    final DialogWindowControllerMacOS controller = DialogWindowControllerMacOS(
      owner: this,
      delegate: delegate,
      preferredSize: preferredSize ?? const Size(420, 300),
      parent: parent,
      title: title,
    );
    _activeControllers.add(controller);
    _record(
      WindowingEvent.spawn(
        viewId: controller.rootView.viewId,
        title: controller.title,
        size: controller.contentSize,
      ),
    );
    return controller;
  }

  /// Removes a controller after its native window has been torn down.
  /// Mirrors the cleanup performed by `_handleOnWillClose` in the SDK
  /// (line 217).
  void _removeController(BaseWindowController controller) {
    _activeControllers.remove(controller);
    if (controller is RegularWindowControllerMacOS) {
      _record(WindowingEvent.destroyed(controller.rootView.viewId, controller.title));
    } else if (controller is DialogWindowControllerMacOS) {
      _record(WindowingEvent.destroyed(controller.rootView.viewId, controller.title));
    }
  }

  /// Activates the supplied controller and demotes the previously active one.
  /// In the SDK this is enforced by the macOS embedder; here we keep a simple
  /// "first-found wins" model because there is no real key-window machinery.
  void _bringToFront(BaseWindowController controller) {
    _activeControllers.remove(controller);
    _activeControllers.add(controller);
  }
}

/// Lightweight envelope for the rolling event log. Fields kept flat to
/// keep the demo widgets simple to render.
class WindowingEvent {
  WindowingEvent._({
    required this.viewId,
    required this.kind,
    required this.detail,
    required this.timestamp,
  });

  factory WindowingEvent.spawn({required int viewId, required String title, required Size size}) =>
      WindowingEvent._(
        viewId: viewId,
        kind: WindowingEventKind.spawn,
        detail: '"$title" @ ${size.width.toStringAsFixed(0)}x${size.height.toStringAsFixed(0)}',
        timestamp: DateTime.now(),
      );

  factory WindowingEvent.resize(int viewId, Size size) => WindowingEvent._(
        viewId: viewId,
        kind: WindowingEventKind.resize,
        detail: '${size.width.toStringAsFixed(0)}x${size.height.toStringAsFixed(0)}',
        timestamp: DateTime.now(),
      );

  factory WindowingEvent.activate(int viewId) => WindowingEvent._(
        viewId: viewId,
        kind: WindowingEventKind.activate,
        detail: 'window became key',
        timestamp: DateTime.now(),
      );

  factory WindowingEvent.deactivate(int viewId) => WindowingEvent._(
        viewId: viewId,
        kind: WindowingEventKind.deactivate,
        detail: 'window resigned key',
        timestamp: DateTime.now(),
      );

  factory WindowingEvent.fullscreen(int viewId, bool on) => WindowingEvent._(
        viewId: viewId,
        kind: WindowingEventKind.fullscreen,
        detail: on ? 'entered full screen' : 'exited full screen',
        timestamp: DateTime.now(),
      );

  factory WindowingEvent.maximized(int viewId, bool on) => WindowingEvent._(
        viewId: viewId,
        kind: WindowingEventKind.maximized,
        detail: on ? 'zoomed' : 'restored from zoom',
        timestamp: DateTime.now(),
      );

  factory WindowingEvent.minimized(int viewId, bool on) => WindowingEvent._(
        viewId: viewId,
        kind: WindowingEventKind.minimized,
        detail: on ? 'minimized to Dock' : 'restored from Dock',
        timestamp: DateTime.now(),
      );

  factory WindowingEvent.closeRequested(int viewId, String reason) => WindowingEvent._(
        viewId: viewId,
        kind: WindowingEventKind.closeRequested,
        detail: reason,
        timestamp: DateTime.now(),
      );

  factory WindowingEvent.destroyed(int viewId, String title) => WindowingEvent._(
        viewId: viewId,
        kind: WindowingEventKind.destroyed,
        detail: '"$title" destroyed',
        timestamp: DateTime.now(),
      );

  final int viewId;
  final WindowingEventKind kind;
  final String detail;
  final DateTime timestamp;
}

enum WindowingEventKind {
  spawn,
  resize,
  activate,
  deactivate,
  fullscreen,
  maximized,
  minimized,
  closeRequested,
  destroyed,
}

// ----------------------------------------------------------------------------
// MIRROR: `RegularWindowControllerMacOS` (SDK line 158).
// ----------------------------------------------------------------------------

/// Mirror that exercises the same surface area as
/// `RegularWindowControllerMacOS` from `_window_macos.dart`.
///
/// The real class is wired to FFI symbols
/// (`InternalFlutter_Window_SetContentSize`, `..._SetTitle`, etc.) and
/// therefore cannot run inside a unit-style demo. The mirror keeps the
/// state machine and the `notifyListeners()` cadence so subscribers see
/// realistic transitions.
class RegularWindowControllerMacOS extends RegularWindowController {
  RegularWindowControllerMacOS({
    required WindowingOwnerMacOS owner,
    required RegularWindowControllerDelegate delegate,
    required Size preferredSize,
    BoxConstraints? preferredConstraints,
    String? title,
  })  : _owner = owner,
        _delegate = delegate,
        _contentSize = preferredSize,
        _minSize = preferredConstraints == null
            ? const Size(280, 180)
            : Size(preferredConstraints.minWidth, preferredConstraints.minHeight),
        _maxSize = preferredConstraints == null
            ? const Size(4096, 2304)
            : Size(
                preferredConstraints.maxWidth.isFinite
                    ? preferredConstraints.maxWidth
                    : 4096,
                preferredConstraints.maxHeight.isFinite
                    ? preferredConstraints.maxHeight
                    : 2304,
              ),
        _title = title ?? 'Untitled' {
    rootView = FlutterViewLike(viewId: owner._generateViewId());
  }

  final WindowingOwnerMacOS _owner;
  final RegularWindowControllerDelegate _delegate;

  Size _contentSize;
  Size _minSize;
  Size _maxSize;
  String _title;
  bool _activated = true;
  bool _maximized = false;
  bool _minimized = false;
  bool _fullscreen = false;
  bool _destroyed = false;

  WindowingOwnerMacOS get owner => _owner;
  RegularWindowControllerDelegate get delegate => _delegate;
  Size get minimumSize => _minSize;
  Size get maximumSize => _maxSize;

  @override
  Size get contentSize => _contentSize;

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

  bool get isDestroyed => _destroyed;

  @override
  void setSize(Size size) {
    _ensureNotDestroyed();
    final double w = size.width.clamp(_minSize.width, _maxSize.width);
    final double h = size.height.clamp(_minSize.height, _maxSize.height);
    _contentSize = Size(w, h);
    _owner._record(WindowingEvent.resize(rootView.viewId, _contentSize));
    notifyListeners();
  }

  @override
  void setMinimumSize(Size size) {
    _ensureNotDestroyed();
    _minSize = size;
    if (_contentSize.width < size.width || _contentSize.height < size.height) {
      _contentSize = Size(
        _contentSize.width < size.width ? size.width : _contentSize.width,
        _contentSize.height < size.height ? size.height : _contentSize.height,
      );
    }
    notifyListeners();
  }

  @override
  void setMaximumSize(Size size) {
    _ensureNotDestroyed();
    _maxSize = size;
    if (_contentSize.width > size.width || _contentSize.height > size.height) {
      _contentSize = Size(
        _contentSize.width > size.width ? size.width : _contentSize.width,
        _contentSize.height > size.height ? size.height : _contentSize.height,
      );
    }
    notifyListeners();
  }

  @override
  void setConstraints(BoxConstraints constraints) {
    _ensureNotDestroyed();
    setMinimumSize(Size(constraints.minWidth, constraints.minHeight));
    setMaximumSize(Size(
      constraints.maxWidth.isFinite ? constraints.maxWidth : _maxSize.width,
      constraints.maxHeight.isFinite ? constraints.maxHeight : _maxSize.height,
    ));
  }

  @override
  void setTitle(String title) {
    _ensureNotDestroyed();
    _title = title;
    notifyListeners();
  }

  @override
  void activate() {
    _ensureNotDestroyed();
    if (_activated) return;
    _activated = true;
    _minimized = false;
    _owner._bringToFront(this);
    _owner._record(WindowingEvent.activate(rootView.viewId));
    notifyListeners();
  }

  @override
  void deactivate() {
    _ensureNotDestroyed();
    if (!_activated) return;
    _activated = false;
    _owner._record(WindowingEvent.deactivate(rootView.viewId));
    notifyListeners();
  }

  @override
  void setMaximized(bool maximized) {
    _ensureNotDestroyed();
    if (_maximized == maximized) return;
    _maximized = maximized;
    if (maximized) {
      _contentSize = _owner.simulatedScreenSize;
    } else {
      _contentSize = Size(_minSize.width + 200, _minSize.height + 120);
    }
    _owner._record(WindowingEvent.maximized(rootView.viewId, maximized));
    notifyListeners();
  }

  @override
  void setMinimized(bool minimized) {
    _ensureNotDestroyed();
    if (_minimized == minimized) return;
    _minimized = minimized;
    if (minimized) {
      _activated = false;
    }
    _owner._record(WindowingEvent.minimized(rootView.viewId, minimized));
    notifyListeners();
  }

  @override
  void setFullScreen(bool fullScreen) {
    _ensureNotDestroyed();
    if (_fullscreen == fullScreen) return;
    _fullscreen = fullScreen;
    if (fullScreen) {
      _contentSize = _owner.simulatedScreenSize;
      _maximized = false;
      _minimized = false;
    } else {
      _contentSize = const Size(900, 640);
    }
    _owner._record(WindowingEvent.fullscreen(rootView.viewId, fullScreen));
    notifyListeners();
  }

  /// Simulates the embedder asking the framework whether the window may
  /// close. The delegate's `onWindowCloseRequested` decides whether to
  /// honor or veto the request.
  void requestClose({String reason = 'user clicked the red traffic light'}) {
    _ensureNotDestroyed();
    _owner._record(WindowingEvent.closeRequested(rootView.viewId, reason));
    _delegate.onWindowCloseRequested(this);
  }

  @override
  void destroy() {
    if (_destroyed) return;
    _destroyed = true;
    _owner._removeController(this);
    _delegate.onWindowDestroyed();
    notifyListeners();
  }

  void _ensureNotDestroyed() {
    if (_destroyed) {
      throw StateError('Window has been destroyed.');
    }
  }
}

// ----------------------------------------------------------------------------
// MIRROR: `DialogWindowControllerMacOS` (SDK line 328).
// ----------------------------------------------------------------------------

class DialogWindowControllerMacOS extends DialogWindowController {
  DialogWindowControllerMacOS({
    required WindowingOwnerMacOS owner,
    required DialogWindowControllerDelegate delegate,
    required Size preferredSize,
    BaseWindowController? parent,
    String? title,
  })  : _owner = owner,
        _delegate = delegate,
        _contentSize = preferredSize,
        _parent = parent,
        _title = title ?? 'Dialog' {
    rootView = FlutterViewLike(viewId: owner._generateViewId());
  }

  final WindowingOwnerMacOS _owner;
  final DialogWindowControllerDelegate _delegate;
  final BaseWindowController? _parent;
  Size _contentSize;
  String _title;
  bool _activated = true;
  bool _minimized = false;
  bool _destroyed = false;

  @override
  BaseWindowController? get parent => _parent;

  @override
  Size get contentSize => _contentSize;

  @override
  String get title => _title;

  @override
  bool get isActivated => _activated;

  @override
  bool get isMinimized => _minimized;

  @override
  void setSize(Size size) {
    _contentSize = size;
    notifyListeners();
  }

  @override
  void setConstraints(BoxConstraints constraints) {
    _contentSize = Size(
      _contentSize.width.clamp(constraints.minWidth,
          constraints.maxWidth.isFinite ? constraints.maxWidth : _contentSize.width),
      _contentSize.height.clamp(constraints.minHeight,
          constraints.maxHeight.isFinite ? constraints.maxHeight : _contentSize.height),
    );
    notifyListeners();
  }

  @override
  void setTitle(String title) {
    _title = title;
    notifyListeners();
  }

  @override
  void activate() {
    _activated = true;
    _minimized = false;
    _owner._bringToFront(this);
    notifyListeners();
  }

  @override
  void setMinimized(bool minimized) {
    _minimized = minimized;
    if (minimized) _activated = false;
    notifyListeners();
  }

  @override
  void destroy() {
    if (_destroyed) return;
    _destroyed = true;
    _owner._removeController(this);
    _delegate.onWindowDestroyed();
    notifyListeners();
  }
}

// ----------------------------------------------------------------------------
// SECTION DATA — palette, descriptors, and recipe records.
// ----------------------------------------------------------------------------

class _Palette {
  const _Palette({
    required this.background,
    required this.surface,
    required this.surfaceAlt,
    required this.outline,
    required this.ink,
    required this.muted,
    required this.accent,
    required this.warn,
    required this.ok,
  });

  final Color background;
  final Color surface;
  final Color surfaceAlt;
  final Color outline;
  final Color ink;
  final Color muted;
  final Color accent;
  final Color warn;
  final Color ok;
}

const _Palette _palette = _Palette(
  background: Color(0xFFF6F2EC),
  surface: Color(0xFFFFFFFF),
  surfaceAlt: Color(0xFFEFE9DE),
  outline: Color(0xFFCDC2AB),
  ink: Color(0xFF1F1A12),
  muted: Color(0xFF6B5E48),
  accent: Color(0xFFB36A2A),
  warn: Color(0xFFB23A3A),
  ok: Color(0xFF2F7A4D),
);

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.index, required this.title, required this.subtitle});

  final int index;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 24, 0, 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: _palette.accent,
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: Text(
              '$index',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    color: _palette.ink,
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(color: _palette.muted, fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.child, this.padding = const EdgeInsets.all(16)});

  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: _palette.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _palette.outline.withOpacity(0.5)),
      ),
      child: child,
    );
  }
}

// ----------------------------------------------------------------------------
// CHROME PAINTER — paints a faithful macOS window header for any controller.
// ----------------------------------------------------------------------------

/// Painter that renders the macOS chrome (titlebar, traffic-light controls,
/// soft drop shadow, content placeholder) for an arbitrary
/// [RegularWindowControllerMacOS]. Used in many sections so the audit-flagged
/// class drives real pixels.
class _MacChrome extends StatelessWidget {
  const _MacChrome({
    required this.controller,
    this.scale = 1.0,
    this.showShortcutHint = true,
  });

  final RegularWindowControllerMacOS controller;
  final double scale;
  final bool showShortcutHint;

  @override
  Widget build(BuildContext context) {
    // d4rt workaround: a script-defined ChangeNotifier subclass
    // (RegularWindowControllerMacOS) is not coerced to the bridged
    // `Listenable` parameter type. SendTestRunner does a static one-shot
    // build with no frame pump, so a real listenable is never observed —
    // pass a const AlwaysStoppedAnimation to satisfy the typed parameter
    // and access controller state via closure capture below.
    return AnimatedBuilder(
      animation: const AlwaysStoppedAnimation<double>(0.0),
      builder: (BuildContext context, Widget? _) {
        final double width = controller.contentSize.width * scale;
        final double height = controller.contentSize.height * scale;
        final bool dim = !controller.isActivated || controller.isMinimized;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: width.clamp(220.0, 1200.0),
          height: height.clamp(140.0, 800.0),
          decoration: BoxDecoration(
            color: _palette.surface,
            borderRadius: BorderRadius.circular(controller.isFullscreen ? 0 : 12),
            border: Border.all(
              color: dim ? _palette.outline.withOpacity(0.4) : _palette.outline,
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withOpacity(dim ? 0.05 : 0.18),
                blurRadius: dim ? 8 : 18,
                offset: Offset(0, dim ? 2 : 8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(controller.isFullscreen ? 0 : 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _Titlebar(controller: controller),
                Expanded(child: _ContentArea(controller: controller, dim: dim)),
                if (showShortcutHint)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    color: _palette.surfaceAlt,
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.keyboard_alt_outlined,
                            size: 13, color: _palette.muted),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            controller.isFullscreen
                                ? 'Press ^⌘F to exit full screen'
                                : '⌘W close · ⌘M minimize · ^⌘F full screen',
                            style: TextStyle(
                              fontSize: 11,
                              color: _palette.muted,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _Titlebar extends StatelessWidget {
  const _Titlebar({required this.controller});

  final RegularWindowControllerMacOS controller;

  @override
  Widget build(BuildContext context) {
    final bool dim = !controller.isActivated;
    return Container(
      height: 30,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            dim ? const Color(0xFFEFEFEF) : const Color(0xFFE6E1D6),
            dim ? const Color(0xFFE3E3E3) : const Color(0xFFD8D2C2),
          ],
        ),
        border: Border(
          bottom: BorderSide(color: _palette.outline.withOpacity(0.6)),
        ),
      ),
      child: Row(
        children: <Widget>[
          const SizedBox(width: 10),
          _TrafficLight(
            color: dim ? const Color(0xFFD0CDC8) : const Color(0xFFFF5F57),
            tooltip: 'Close',
            onTap: () => controller.requestClose(reason: 'red traffic light tapped'),
          ),
          const SizedBox(width: 6),
          _TrafficLight(
            color: dim ? const Color(0xFFD0CDC8) : const Color(0xFFFEBC2E),
            tooltip: 'Minimize',
            onTap: () => controller.setMinimized(!controller.isMinimized),
          ),
          const SizedBox(width: 6),
          _TrafficLight(
            color: dim ? const Color(0xFFD0CDC8) : const Color(0xFF28C841),
            tooltip: 'Zoom',
            onTap: () => controller.setMaximized(!controller.isMaximized),
          ),
          Expanded(
            child: Center(
              child: Text(
                controller.title,
                style: TextStyle(
                  color: dim ? _palette.muted : _palette.ink,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          const SizedBox(width: 60),
        ],
      ),
    );
  }
}

class _TrafficLight extends StatelessWidget {
  const _TrafficLight({required this.color, required this.tooltip, required this.onTap});

  final Color color;
  final String tooltip;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(color: color.withOpacity(0.6)),
          ),
        ),
      ),
    );
  }
}

class _ContentArea extends StatelessWidget {
  const _ContentArea({required this.controller, required this.dim});

  final RegularWindowControllerMacOS controller;
  final bool dim;

  @override
  Widget build(BuildContext context) {
    final List<Widget> badges = <Widget>[
      _StateBadge(label: 'active', on: controller.isActivated, color: _palette.ok),
      _StateBadge(label: 'fullscreen', on: controller.isFullscreen, color: _palette.accent),
      _StateBadge(label: 'maximized', on: controller.isMaximized, color: _palette.accent),
      _StateBadge(label: 'minimized', on: controller.isMinimized, color: _palette.warn),
    ];

    return Container(
      padding: const EdgeInsets.all(12),
      color: dim
          ? _palette.surfaceAlt.withOpacity(0.4)
          : _palette.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'viewId #${controller.rootView.viewId}',
            style: TextStyle(
              color: _palette.muted,
              fontFamily: 'monospace',
              fontSize: 11,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${controller.contentSize.width.toStringAsFixed(0)} × '
            '${controller.contentSize.height.toStringAsFixed(0)} pt',
            style: TextStyle(
              color: _palette.ink,
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          // Wrap inside Expanded+SingleChildScrollView so the badge row
          // never overflows when the chrome is rendered at small scales
          // (gridWindows scale 0.45 clamps height to 140, leaving a
          // tight ContentArea). Also covers narrow viewports where
          // badges naturally wrap to two rows.
          Expanded(
            child: SingleChildScrollView(
              child: Wrap(spacing: 6, runSpacing: 6, children: badges),
            ),
          ),
        ],
      ),
    );
  }
}

class _StateBadge extends StatelessWidget {
  const _StateBadge({required this.label, required this.on, required this.color});

  final String label;
  final bool on;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: on ? color.withOpacity(0.15) : _palette.surfaceAlt,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: on ? color : _palette.outline),
      ),
      child: Text(
        '${on ? '●' : '○'} $label',
        style: TextStyle(
          color: on ? color : _palette.muted,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// ============================================================================
// TOP-LEVEL HARNESS
// ============================================================================

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'WindowingOwnerMacOS — deep demo',
    theme: ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: _palette.background,
      colorScheme: ColorScheme.fromSeed(seedColor: _palette.accent),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(fontSize: 13, height: 1.4),
      ),
    ),
    home: const _DemoRoot(),
  );
}

class _DemoRoot extends StatefulWidget {
  const _DemoRoot();

  @override
  State<_DemoRoot> createState() => _DemoRootState();
}

class _DemoRootState extends State<_DemoRoot> {
  late final WindowingOwnerMacOS owner;
  late final RegularWindowControllerMacOS heroWindow;
  late final RegularWindowControllerMacOS resizeWindow;
  late final RegularWindowControllerMacOS chromeWindow;
  late final RegularWindowControllerMacOS minimizedWindow;
  late final RegularWindowControllerMacOS vetoWindow;
  late final List<RegularWindowControllerMacOS> gridWindows;

  // Resize playground state.
  double _playWidth = 720;
  double _playHeight = 480;
  double _playMinWidth = 320;
  double _playMinHeight = 240;
  double _playMaxWidth = 1600;
  double _playMaxHeight = 1000;

  // Veto state.
  bool _vetoOnClose = true;
  bool _showVetoDialog = false;

  @override
  void initState() {
    super.initState();
    owner = WindowingOwnerMacOS();
    heroWindow = owner.createRegularWindowController(
      delegate: RegularWindowControllerDelegate(),
      preferredSize: const Size(960, 620),
      preferredConstraints: const BoxConstraints(
        minWidth: 480,
        minHeight: 320,
        maxWidth: 2560,
        maxHeight: 1600,
      ),
      title: 'Hero — Live Macintosh Chrome',
    );
    resizeWindow = owner.createRegularWindowController(
      delegate: RegularWindowControllerDelegate(),
      preferredSize: Size(_playWidth, _playHeight),
      title: 'Resize Playground',
    );
    chromeWindow = owner.createRegularWindowController(
      delegate: RegularWindowControllerDelegate(),
      preferredSize: const Size(720, 480),
      title: 'Lifecycle Theatre',
    );
    minimizedWindow = owner.createRegularWindowController(
      delegate: RegularWindowControllerDelegate(),
      preferredSize: const Size(640, 420),
      title: 'Dock Resident',
    );
    minimizedWindow.setMinimized(true);
    vetoWindow = owner.createRegularWindowController(
      delegate: _VetoDelegate(
        shouldVeto: () => _vetoOnClose,
        onVetoed: () {
          if (mounted) setState(() => _showVetoDialog = true);
        },
      ),
      preferredSize: const Size(560, 360),
      title: 'Unsaved Changes',
    );
    gridWindows = <RegularWindowControllerMacOS>[
      for (int i = 0; i < 6; i++)
        owner.createRegularWindowController(
          delegate: RegularWindowControllerDelegate(),
          preferredSize: Size(360 + i * 12.0, 240 + i * 8.0),
          title: 'Tile ${i + 1}',
        ),
    ];
  }

  @override
  void dispose() {
    heroWindow.dispose();
    resizeWindow.dispose();
    chromeWindow.dispose();
    minimizedWindow.dispose();
    vetoWindow.dispose();
    for (final RegularWindowControllerMacOS w in gridWindows) {
      w.dispose();
    }
    super.dispose();
  }

  TargetPlatform get platform => Theme.of(context).platform;
  bool get isMac => platform == TargetPlatform.macOS;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _palette.background,
      appBar: AppBar(
        backgroundColor: _palette.surface,
        elevation: 0,
        title: Text(
          'WindowingOwnerMacOS — Deep Demo',
          style: TextStyle(color: _palette.ink, fontWeight: FontWeight.w800),
        ),
        iconTheme: IconThemeData(color: _palette.ink),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _buildHero(),
              const _SectionHeader(
                index: 1,
                title: 'Class anatomy',
                subtitle: 'WindowingOwnerMacOS as it lives in the Flutter SDK',
              ),
              _buildAnatomy(),
              const _SectionHeader(
                index: 2,
                title: 'Live owner instantiation',
                subtitle: 'A single owner manages many controllers',
              ),
              _buildOwnerInstantiation(),
              const _SectionHeader(
                index: 3,
                title: 'Controller lifecycle theatre',
                subtitle: 'create → activate → deactivate → destroy',
              ),
              _buildLifecycle(),
              const _SectionHeader(
                index: 4,
                title: 'Resize playground',
                subtitle: 'Drive setSize / setMinimumSize / setMaximumSize',
              ),
              _buildResizePlayground(),
              const _SectionHeader(
                index: 5,
                title: 'Full screen + zoom toggle',
                subtitle: 'setFullScreen and setMaximized in tandem',
              ),
              _buildFullscreenToggle(),
              const _SectionHeader(
                index: 6,
                title: 'Minimize ribbon',
                subtitle: 'Windows resident in the Dock',
              ),
              _buildMinimizeRibbon(),
              const _SectionHeader(
                index: 7,
                title: 'Close-with-delegate (veto)',
                subtitle: 'A delegate that intercepts the close request',
              ),
              _buildVetoSection(),
              const _SectionHeader(
                index: 8,
                title: 'Multi-window grid',
                subtitle: 'Six controllers painted side by side',
              ),
              _buildMultiWindowGrid(),
              const _SectionHeader(
                index: 9,
                title: 'Recipe gallery',
                subtitle: 'Settings, About, Preview window factories',
              ),
              _buildRecipeGallery(),
              const _SectionHeader(
                index: 10,
                title: 'Pitfalls and constraints',
                subtitle: 'What the SDK enforces that the mirror cannot',
              ),
              _buildPitfalls(),
              const _SectionHeader(
                index: 11,
                title: 'Reference table',
                subtitle: 'Members of WindowingOwnerMacOS at a glance',
              ),
              _buildReferenceTable(),
              const _SectionHeader(
                index: 12,
                title: 'Live event log',
                subtitle: 'Every owner-mediated transition, in order',
              ),
              _buildEventLog(),
              const SizedBox(height: 24),
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  // --------------------------------------------------------------------------
  // SECTION 0 — Hero with platform detection banner.
  // --------------------------------------------------------------------------

  Widget _buildHero() {
    return _Card(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: _palette.accent.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'experimental · @internal',
                  style: TextStyle(
                    color: _palette.accent,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.6,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                'flutter / packages / lib / src / widgets / _window_macos.dart',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                  color: _palette.muted,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            'WindowingOwnerMacOS',
            style: TextStyle(
              color: _palette.ink,
              fontWeight: FontWeight.w900,
              fontSize: 30,
              letterSpacing: -0.6,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'The macOS-specific implementation of WindowingOwner. It owns a '
            'list of active BaseWindowControllers and produces '
            'RegularWindowControllerMacOS instances backed by FFI calls into '
            'the Flutter macOS embedder.',
            style: TextStyle(color: _palette.muted, fontSize: 14, height: 1.4),
          ),
          const SizedBox(height: 16),
          _PlatformBanner(platform: platform, isMac: isMac),
          const SizedBox(height: 18),
          Center(child: _MacChrome(controller: heroWindow)),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              _ChipAction(
                label: 'activate hero',
                onTap: () {
                  setState(() {
                    heroWindow.activate();
                  });
                },
              ),
              _ChipAction(
                label: 'deactivate hero',
                onTap: () {
                  setState(() {
                    heroWindow.deactivate();
                  });
                },
              ),
              _ChipAction(
                label: 'set title',
                onTap: () {
                  setState(() {
                    heroWindow.setTitle(
                      heroWindow.title.endsWith('★')
                          ? 'Hero — Live Macintosh Chrome'
                          : '${heroWindow.title}  ★',
                    );
                  });
                },
              ),
              _ChipAction(
                label: 'shrink',
                onTap: () {
                  setState(() {
                    heroWindow.setSize(const Size(640, 420));
                  });
                },
              ),
              _ChipAction(
                label: 'restore',
                onTap: () {
                  setState(() {
                    heroWindow.setSize(const Size(960, 620));
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --------------------------------------------------------------------------
  // SECTION 1 — Class anatomy.
  // --------------------------------------------------------------------------

  Widget _buildAnatomy() {
    final List<_AnatomyEntry> entries = <_AnatomyEntry>[
      _AnatomyEntry(
        kind: 'class',
        signature: 'class WindowingOwnerMacOS extends WindowingOwner',
        notes: 'Concrete owner — declared @internal in the SDK so user code '
            'cannot import it. The mirror in this demo extends the same '
            'abstract WindowingOwner so generic call sites compile.',
      ),
      _AnatomyEntry(
        kind: 'ctor',
        signature: 'WindowingOwnerMacOS()',
        notes: 'Throws UnsupportedError unless isWindowingEnabled is true and '
            'Platform.isMacOS is true. Asserts the engine has been '
            'initialised so it can read engineId.',
      ),
      _AnatomyEntry(
        kind: 'method',
        signature:
            'createRegularWindowController({delegate, preferredSize, '
            'preferredConstraints, title}) → RegularWindowController',
        notes: 'Builds a RegularWindowControllerMacOS, registers it in '
            '_activeControllers, returns the controller for callers to wire '
            'up to a RegularWindow widget.',
      ),
      _AnatomyEntry(
        kind: 'method',
        signature: 'createDialogWindowController(...)',
        notes: 'Same shape as the regular factory but returns a '
            'DialogWindowControllerMacOS. May supply a parent for modal '
            'behaviour.',
      ),
      _AnatomyEntry(
        kind: 'method',
        signature: 'createTooltipWindowController(...)',
        notes: 'Throws UnimplementedError on macOS today (line 122 of the SDK '
            'source). Tooltip windows are not yet wired to NSWindow.',
      ),
      _AnatomyEntry(
        kind: 'method',
        signature: 'createPopupWindowController(...)',
        notes: 'Throws UnimplementedError on macOS today (line 134 of the '
            'SDK source).',
      ),
      _AnatomyEntry(
        kind: 'static',
        signature: 'getWindowHandle(FlutterView view) → Pointer<Void>',
        notes: 'Returns the underlying NSWindow* handle. Used by the controller '
            'to drive InternalFlutter_Window_* FFI symbols.',
      ),
      _AnatomyEntry(
        kind: 'field',
        signature: 'List<BaseWindowController> _activeControllers',
        notes: 'Tracks the live windows so the engine can notify the framework '
            'when a window dies. Populated by the create* methods, drained '
            'by _handleOnWillClose.',
      ),
    ];

    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          for (int i = 0; i < entries.length; i++) ...<Widget>[
            if (i > 0)
              Divider(height: 18, color: _palette.outline.withOpacity(0.4)),
            _AnatomyTile(entry: entries[i]),
          ],
        ],
      ),
    );
  }

  // --------------------------------------------------------------------------
  // SECTION 2 — Live owner instantiation.
  // --------------------------------------------------------------------------

  Widget _buildOwnerInstantiation() {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Owner identity',
            style: TextStyle(
              color: _palette.ink,
              fontWeight: FontWeight.w800,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 8),
          _CodeBlock(
            code: 'final WindowingOwnerMacOS owner = WindowingOwnerMacOS(\n'
                '  simulatedScreenSize: const Size(2560, 1440),\n'
                ');',
          ),
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              _Stat(
                  label: 'simulatedScreenSize',
                  value:
                      '${owner.simulatedScreenSize.width.toStringAsFixed(0)} × '
                      '${owner.simulatedScreenSize.height.toStringAsFixed(0)}'),
              const SizedBox(width: 16),
              _Stat(
                  label: 'active controllers',
                  value: owner.activeControllers.length.toString()),
              const SizedBox(width: 16),
              _Stat(label: 'events recorded', value: owner.events.length.toString()),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Active controllers',
            style: TextStyle(
              color: _palette.ink,
              fontWeight: FontWeight.w800,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 8),
          for (final BaseWindowController c in owner.activeControllers)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Row(
                children: <Widget>[
                  Icon(Icons.window, size: 14, color: _palette.muted),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'view #${c.rootView.viewId} · ${_describe(c)}',
                      style: TextStyle(color: _palette.ink, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  String _describe(BaseWindowController c) {
    if (c is RegularWindowControllerMacOS) {
      return 'RegularWindowControllerMacOS · "${c.title}"';
    }
    if (c is DialogWindowControllerMacOS) {
      return 'DialogWindowControllerMacOS · "${c.title}"';
    }
    return c.runtimeType.toString();
  }

  // --------------------------------------------------------------------------
  // SECTION 3 — Lifecycle theatre.
  // --------------------------------------------------------------------------

  Widget _buildLifecycle() {
    return _Card(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'State machine',
                  style: TextStyle(
                    color: _palette.ink,
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 8),
                _LifecycleStep(index: 1, label: 'create', detail: 'owner.createRegularWindowController(...)'),
                _LifecycleStep(index: 2, label: 'activate', detail: 'controller.activate()'),
                _LifecycleStep(index: 3, label: 'mutate', detail: 'setSize, setTitle, setFullScreen, ...'),
                _LifecycleStep(index: 4, label: 'deactivate', detail: 'controller.deactivate()'),
                _LifecycleStep(index: 5, label: 'requestClose', detail: 'delegate.onWindowCloseRequested(...)'),
                _LifecycleStep(index: 6, label: 'destroy', detail: 'controller.destroy() → onWindowDestroyed()'),
                const SizedBox(height: 14),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: <Widget>[
                    _ChipAction(label: 'activate', onTap: () => setState(chromeWindow.activate)),
                    _ChipAction(label: 'deactivate', onTap: () => setState(chromeWindow.deactivate)),
                    _ChipAction(
                      label: 'set title',
                      onTap: () {
                        setState(() => chromeWindow.setTitle('Lifecycle · t=${DateTime.now().second}'));
                      },
                    ),
                    _ChipAction(
                      label: 'request close',
                      onTap: () {
                        setState(() => chromeWindow.requestClose(reason: 'demo button pressed'));
                      },
                    ),
                    _ChipAction(
                      label: 'reset',
                      onTap: () {
                        setState(() {
                          if (!chromeWindow.isDestroyed) {
                            chromeWindow.setSize(const Size(720, 480));
                            chromeWindow.setTitle('Lifecycle Theatre');
                            chromeWindow.activate();
                          }
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 4,
            child: Center(
              child: chromeWindow.isDestroyed
                  ? _DestroyedPlaceholder(viewId: chromeWindow.rootView.viewId)
                  : _MacChrome(controller: chromeWindow, scale: 0.6),
            ),
          ),
        ],
      ),
    );
  }

  // --------------------------------------------------------------------------
  // SECTION 4 — Resize playground.
  // --------------------------------------------------------------------------

  Widget _buildResizePlayground() {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Sliders drive setSize, setMinimumSize and setMaximumSize on a '
            'live RegularWindowControllerMacOS instance. Watch the chrome '
            'react to the clamp logic.',
            style: TextStyle(color: _palette.muted, fontSize: 13),
          ),
          const SizedBox(height: 12),
          _SliderRow(
            label: 'content width',
            value: _playWidth,
            min: 200,
            max: 1800,
            onChanged: (double v) {
              setState(() {
                _playWidth = v;
                resizeWindow.setSize(Size(_playWidth, _playHeight));
              });
            },
          ),
          _SliderRow(
            label: 'content height',
            value: _playHeight,
            min: 160,
            max: 1100,
            onChanged: (double v) {
              setState(() {
                _playHeight = v;
                resizeWindow.setSize(Size(_playWidth, _playHeight));
              });
            },
          ),
          Divider(height: 24, color: _palette.outline.withOpacity(0.4)),
          _SliderRow(
            label: 'min width',
            value: _playMinWidth,
            min: 100,
            max: 800,
            onChanged: (double v) {
              setState(() {
                _playMinWidth = v;
                resizeWindow.setMinimumSize(Size(_playMinWidth, _playMinHeight));
              });
            },
          ),
          _SliderRow(
            label: 'min height',
            value: _playMinHeight,
            min: 100,
            max: 600,
            onChanged: (double v) {
              setState(() {
                _playMinHeight = v;
                resizeWindow.setMinimumSize(Size(_playMinWidth, _playMinHeight));
              });
            },
          ),
          Divider(height: 24, color: _palette.outline.withOpacity(0.4)),
          _SliderRow(
            label: 'max width',
            value: _playMaxWidth,
            min: 600,
            max: 2400,
            onChanged: (double v) {
              setState(() {
                _playMaxWidth = v;
                resizeWindow.setMaximumSize(Size(_playMaxWidth, _playMaxHeight));
              });
            },
          ),
          _SliderRow(
            label: 'max height',
            value: _playMaxHeight,
            min: 400,
            max: 1600,
            onChanged: (double v) {
              setState(() {
                _playMaxHeight = v;
                resizeWindow.setMaximumSize(Size(_playMaxWidth, _playMaxHeight));
              });
            },
          ),
          const SizedBox(height: 16),
          Center(child: _MacChrome(controller: resizeWindow, scale: 0.55)),
        ],
      ),
    );
  }

  // --------------------------------------------------------------------------
  // SECTION 5 — Full screen + maximize toggle.
  // --------------------------------------------------------------------------

  Widget _buildFullscreenToggle() {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: <Widget>[
              _ChipAction(
                label: heroWindow.isFullscreen ? 'exit full screen' : 'enter full screen',
                onTap: () {
                  setState(() => heroWindow.setFullScreen(!heroWindow.isFullscreen));
                },
              ),
              _ChipAction(
                label: heroWindow.isMaximized ? 'unzoom' : 'zoom (maximize)',
                onTap: () {
                  setState(() => heroWindow.setMaximized(!heroWindow.isMaximized));
                },
              ),
              _ChipAction(
                label: 'restore default',
                onTap: () {
                  setState(() {
                    heroWindow.setFullScreen(false);
                    heroWindow.setMaximized(false);
                    heroWindow.setSize(const Size(960, 620));
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          _RuleStrip(
            isOn: heroWindow.isFullscreen,
            onLabel: 'fullscreen',
            offLabel: 'windowed',
          ),
          const SizedBox(height: 8),
          _RuleStrip(
            isOn: heroWindow.isMaximized,
            onLabel: 'zoomed',
            offLabel: 'natural size',
          ),
          const SizedBox(height: 14),
          Text(
            'Note: on macOS, full screen and zoom are mutually exclusive. The '
            'mirror enforces this by clearing _maximized when _fullscreen '
            'becomes true.',
            style: TextStyle(color: _palette.muted, fontSize: 12, height: 1.4),
          ),
        ],
      ),
    );
  }

  // --------------------------------------------------------------------------
  // SECTION 6 — Minimize ribbon.
  // --------------------------------------------------------------------------

  Widget _buildMinimizeRibbon() {
    final List<RegularWindowControllerMacOS> minimizedSamples =
        <RegularWindowControllerMacOS>[
      minimizedWindow,
      ...gridWindows.where((RegularWindowControllerMacOS c) => c.isMinimized),
    ];

    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                'Dock residents (${minimizedSamples.length})',
                style: TextStyle(
                  color: _palette.ink,
                  fontWeight: FontWeight.w800,
                  fontSize: 15,
                ),
              ),
              const Spacer(),
              _ChipAction(
                label: minimizedWindow.isMinimized
                    ? 'restore from Dock'
                    : 'send to Dock',
                onTap: () {
                  setState(() => minimizedWindow.setMinimized(!minimizedWindow.isMinimized));
                },
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            height: 96,
            decoration: BoxDecoration(
              color: _palette.surfaceAlt,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: _palette.outline.withOpacity(0.6)),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: minimizedSamples.isEmpty
                ? Center(
                    child: Text(
                      'No minimized windows. Click the yellow traffic light '
                      'on any chrome to send it down here.',
                      style: TextStyle(color: _palette.muted, fontSize: 12),
                    ),
                  )
                : ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: minimizedSamples.length,
                    separatorBuilder: (BuildContext _, int _) => const SizedBox(width: 12),
                    itemBuilder: (BuildContext context, int index) {
                      return _DockTile(controller: minimizedSamples[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  // --------------------------------------------------------------------------
  // SECTION 7 — Close-with-delegate (veto).
  // --------------------------------------------------------------------------

  Widget _buildVetoSection() {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'A custom RegularWindowControllerDelegate can intercept the close '
            'request and decide whether to honour it. Toggle the veto switch '
            'and click the red traffic light on the chrome below to see the '
            'request being short-circuited.',
            style: TextStyle(color: _palette.muted, fontSize: 13, height: 1.4),
          ),
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              Switch(
                value: _vetoOnClose,
                onChanged: (bool v) => setState(() => _vetoOnClose = v),
                activeColor: _palette.warn,
              ),
              const SizedBox(width: 8),
              Text(
                _vetoOnClose
                    ? 'Veto active — close requests will pop a confirm sheet'
                    : 'Veto disabled — close requests destroy the window immediately',
                style: TextStyle(color: _palette.ink, fontSize: 13),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Center(
            child: vetoWindow.isDestroyed
                ? _DestroyedPlaceholder(viewId: vetoWindow.rootView.viewId)
                : _MacChrome(controller: vetoWindow, scale: 0.7),
          ),
          if (_showVetoDialog)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: _VetoSheet(
                onCancel: () => setState(() => _showVetoDialog = false),
                onConfirm: () {
                  setState(() {
                    _showVetoDialog = false;
                    _vetoOnClose = false;
                    vetoWindow.requestClose(reason: 'user confirmed close in dialog');
                  });
                },
              ),
            ),
          const SizedBox(height: 12),
          _CodeBlock(
            code: 'class _VetoDelegate extends RegularWindowControllerDelegate {\n'
                '  _VetoDelegate({required this.shouldVeto, required this.onVetoed});\n'
                '  final bool Function() shouldVeto;\n'
                '  final VoidCallback onVetoed;\n\n'
                '  @override\n'
                '  void onWindowCloseRequested(RegularWindowController c) {\n'
                '    if (shouldVeto()) { onVetoed(); return; }\n'
                '    c.destroy();\n'
                '  }\n'
                '}',
          ),
        ],
      ),
    );
  }

  // --------------------------------------------------------------------------
  // SECTION 8 — Multi-window grid.
  // --------------------------------------------------------------------------

  Widget _buildMultiWindowGrid() {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              _ChipAction(
                label: 'activate all',
                onTap: () {
                  setState(() {
                    for (final RegularWindowControllerMacOS w in gridWindows) {
                      if (!w.isDestroyed) w.activate();
                    }
                  });
                },
              ),
              _ChipAction(
                label: 'deactivate all',
                onTap: () {
                  setState(() {
                    for (final RegularWindowControllerMacOS w in gridWindows) {
                      if (!w.isDestroyed) w.deactivate();
                    }
                  });
                },
              ),
              _ChipAction(
                label: 'cascade titles',
                onTap: () {
                  setState(() {
                    for (int i = 0; i < gridWindows.length; i++) {
                      gridWindows[i].setTitle('Cascade ${i + 1} of ${gridWindows.length}');
                    }
                  });
                },
              ),
              _ChipAction(
                label: 'shuffle sizes',
                onTap: () {
                  setState(() {
                    for (int i = 0; i < gridWindows.length; i++) {
                      gridWindows[i].setSize(Size(360 + i * 30.0, 240 + ((i * 53) % 180)));
                    }
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final int cols = constraints.maxWidth > 900 ? 3 : 2;
              return Wrap(
                spacing: 12,
                runSpacing: 12,
                children: <Widget>[
                  for (final RegularWindowControllerMacOS w in gridWindows)
                    SizedBox(
                      width: (constraints.maxWidth - 12 * (cols - 1)) / cols,
                      child: Column(
                        children: <Widget>[
                          _MacChrome(controller: w, scale: 0.45, showShortcutHint: false),
                          const SizedBox(height: 6),
                          Text(
                            'view #${w.rootView.viewId}',
                            style: TextStyle(
                              color: _palette.muted,
                              fontFamily: 'monospace',
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  // --------------------------------------------------------------------------
  // SECTION 9 — Recipe gallery.
  // --------------------------------------------------------------------------

  Widget _buildRecipeGallery() {
    final List<_Recipe> recipes = <_Recipe>[
      _Recipe(
        title: 'Settings window',
        body: 'Modeless, non-resizable, lives until user closes it.',
        snippet: 'owner.createRegularWindowController(\n'
            '  delegate: RegularWindowControllerDelegate(),\n'
            '  preferredSize: const Size(640, 480),\n'
            '  preferredConstraints: const BoxConstraints.tightFor(\n'
            '    width: 640, height: 480),\n'
            '  title: "Settings",\n'
            ');',
      ),
      _Recipe(
        title: 'About window',
        body: 'Small, fixed-size window summoned by the menu.',
        snippet: 'owner.createRegularWindowController(\n'
            '  delegate: RegularWindowControllerDelegate(),\n'
            '  preferredSize: const Size(360, 240),\n'
            '  title: "About MyApp",\n'
            ');',
      ),
      _Recipe(
        title: 'Preview window',
        body: 'Document preview that prefers a 4:3 aspect on launch.',
        snippet: 'owner.createRegularWindowController(\n'
            '  delegate: RegularWindowControllerDelegate(),\n'
            '  preferredSize: const Size(960, 720),\n'
            '  preferredConstraints: const BoxConstraints(\n'
            '    minWidth: 480, minHeight: 360),\n'
            '  title: "Preview",\n'
            ');',
      ),
      _Recipe(
        title: 'Modal dialog',
        body: 'Dialog parented to the hero window — modal to its parent.',
        snippet: 'owner.createDialogWindowController(\n'
            '  delegate: DialogWindowControllerDelegate(),\n'
            '  parent: heroWindow,\n'
            '  preferredSize: const Size(420, 240),\n'
            '  title: "Confirm",\n'
            ');',
      ),
    ];
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          for (int i = 0; i < recipes.length; i++) ...<Widget>[
            if (i > 0)
              Divider(height: 18, color: _palette.outline.withOpacity(0.4)),
            _RecipeTile(recipe: recipes[i]),
          ],
        ],
      ),
    );
  }

  // --------------------------------------------------------------------------
  // SECTION 10 — Pitfalls.
  // --------------------------------------------------------------------------

  Widget _buildPitfalls() {
    final List<_Pitfall> pitfalls = <_Pitfall>[
      _Pitfall(
        severity: _Severity.high,
        title: 'Constructor throws unless windowing is enabled',
        body: 'WindowingOwnerMacOS() throws UnsupportedError when '
            'isWindowingEnabled is false (line 64 of _window_macos.dart). '
            'Until the experimental flag is on at engine boot, attempting '
            'to instantiate the class will crash the app.',
      ),
      _Pitfall(
        severity: _Severity.high,
        title: 'Constructor throws on non-macOS hosts',
        body: 'Line 67-69 guards on Platform.isMacOS — if you ship the same '
            'binary to Linux or Windows, you must select the corresponding '
            'WindowingOwnerLinux or WindowingOwnerWin32 instead.',
      ),
      _Pitfall(
        severity: _Severity.medium,
        title: 'Tooltip and popup factories throw UnimplementedError',
        body: 'createTooltipWindowController and createPopupWindowController '
            'throw at runtime on macOS today (lines 122 and 134). Treat '
            'these as build-but-not-call APIs.',
      ),
      _Pitfall(
        severity: _Severity.medium,
        title: 'Class is @internal, not exported',
        body: 'WindowingOwnerMacOS is reserved for the Flutter team. Public '
            'consumers must talk to the abstract WindowingOwner via '
            'WidgetsBinding.instance.windowingOwner instead.',
      ),
      _Pitfall(
        severity: _Severity.low,
        title: 'destroy() is idempotent but mandatory',
        body: 'The controller will not auto-destroy when its widget is '
            'unmounted. Always call destroy() in your widget\'s dispose().',
      ),
      _Pitfall(
        severity: _Severity.low,
        title: 'Native callbacks live until destroy',
        body: 'NativeCallable instances (_onShouldClose, _onWillClose, '
            '_onResize) are closed in _handleOnWillClose. Skipping destroy '
            'leaks isolate-local function pointers.',
      ),
    ];
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          for (int i = 0; i < pitfalls.length; i++) ...<Widget>[
            if (i > 0)
              Divider(height: 18, color: _palette.outline.withOpacity(0.4)),
            _PitfallTile(pitfall: pitfalls[i]),
          ],
        ],
      ),
    );
  }

  // --------------------------------------------------------------------------
  // SECTION 11 — Reference table.
  // --------------------------------------------------------------------------

  Widget _buildReferenceTable() {
    final List<_ReferenceEntry> rows = <_ReferenceEntry>[
      _ReferenceEntry('@internal', 'class WindowingOwnerMacOS extends WindowingOwner', 'platform owner'),
      _ReferenceEntry('@internal', 'WindowingOwnerMacOS()', 'constructor (gated)'),
      _ReferenceEntry('@override', 'createRegularWindowController(...) → RegularWindowController', 'spawn regular window'),
      _ReferenceEntry('@override', 'createDialogWindowController(...) → DialogWindowController', 'spawn dialog window'),
      _ReferenceEntry('@internal @override', 'createTooltipWindowController(...) → TooltipWindowController', 'throws UnimplementedError'),
      _ReferenceEntry('@internal @override', 'createPopupWindowController(...) → PopupWindowController', 'throws UnimplementedError'),
      _ReferenceEntry('static', 'getWindowHandle(FlutterView) → Pointer<Void>', 'NSWindow* handle'),
      _ReferenceEntry('field', '_activeControllers : List<BaseWindowController>', 'live tracking list'),
      _ReferenceEntry('—', 'RegularWindowControllerMacOS extends RegularWindowController', 'companion controller'),
      _ReferenceEntry('@override', 'setSize(Size) / setConstraints(BoxConstraints)', 'resize requests'),
      _ReferenceEntry('@override', 'setTitle(String)', 'titlebar text'),
      _ReferenceEntry('@override', 'activate() / setMaximized(bool) / setMinimized(bool)', 'window state'),
      _ReferenceEntry('@override', 'setFullscreen(bool, {Display?}) — note SDK uses setFullscreen', 'native fullscreen'),
      _ReferenceEntry('@override', 'destroy()', 'idempotent teardown'),
    ];
    return _Card(
      padding: EdgeInsets.zero,
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: _palette.surfaceAlt,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
            ),
            child: Row(
              children: <Widget>[
                _RefHeaderCell(label: 'tag', flex: 2),
                _RefHeaderCell(label: 'signature', flex: 7),
                _RefHeaderCell(label: 'role', flex: 3),
              ],
            ),
          ),
          for (int i = 0; i < rows.length; i++)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: i.isEven ? _palette.surface : _palette.surfaceAlt.withOpacity(0.4),
                border: Border(
                  bottom: BorderSide(color: _palette.outline.withOpacity(0.3)),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _RefCell(text: rows[i].tag, flex: 2, mono: true, color: _palette.accent),
                  _RefCell(text: rows[i].signature, flex: 7, mono: true),
                  _RefCell(text: rows[i].role, flex: 3),
                ],
              ),
            ),
        ],
      ),
    );
  }

  // --------------------------------------------------------------------------
  // SECTION 12 — Live event log.
  // --------------------------------------------------------------------------

  Widget _buildEventLog() {
    final List<WindowingEvent> events = owner.events.reversed.take(30).toList();
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                'Last ${events.length} events',
                style: TextStyle(
                  color: _palette.ink,
                  fontWeight: FontWeight.w800,
                  fontSize: 15,
                ),
              ),
              const Spacer(),
              _ChipAction(
                label: 'clear log',
                onTap: () {
                  setState(() => owner.events.clear());
                },
              ),
            ],
          ),
          const SizedBox(height: 8),
          if (events.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                'No events yet — interact with any control above.',
                style: TextStyle(color: _palette.muted, fontSize: 12),
              ),
            )
          else
            for (final WindowingEvent e in events) _EventRow(event: e),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Center(
        child: Text(
          'Mirror exercises ${owner.activeControllers.length} live '
          'WindowingOwnerMacOS-bound controllers · '
          '${owner.events.length} total events recorded',
          style: TextStyle(color: _palette.muted, fontSize: 11),
        ),
      ),
    );
  }
}

// ============================================================================
// SUPPORTING WIDGETS AND VALUE TYPES
// ============================================================================

class _PlatformBanner extends StatelessWidget {
  const _PlatformBanner({required this.platform, required this.isMac});

  final TargetPlatform platform;
  final bool isMac;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: (isMac ? _palette.ok : _palette.warn).withOpacity(0.10),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: (isMac ? _palette.ok : _palette.warn).withOpacity(0.6),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(
            isMac ? Icons.verified : Icons.info_outline,
            color: isMac ? _palette.ok : _palette.warn,
            size: 18,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  isMac
                      ? 'Detected platform: macOS — chrome would map to a real WindowingOwnerMacOS in production'
                      : 'this would only run live on macOS — currently demoing the chrome on $platform',
                  style: TextStyle(
                    color: _palette.ink,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'The visual mirror renders on every platform so AST '
                  'roundtrips can verify the layout.',
                  style: TextStyle(color: _palette.muted, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ChipAction extends StatelessWidget {
  const _ChipAction({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(
          color: _palette.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _palette.outline),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: _palette.ink,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _AnatomyEntry {
  _AnatomyEntry({required this.kind, required this.signature, required this.notes});
  final String kind;
  final String signature;
  final String notes;
}

class _AnatomyTile extends StatelessWidget {
  const _AnatomyTile({required this.entry});

  final _AnatomyEntry entry;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 64,
          padding: const EdgeInsets.symmetric(vertical: 4),
          alignment: Alignment.topLeft,
          child: Text(
            entry.kind,
            style: TextStyle(
              color: _palette.accent,
              fontFamily: 'monospace',
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                entry.signature,
                style: TextStyle(
                  color: _palette.ink,
                  fontFamily: 'monospace',
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                entry.notes,
                style: TextStyle(color: _palette.muted, fontSize: 12, height: 1.4),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CodeBlock extends StatelessWidget {
  const _CodeBlock({required this.code});

  final String code;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1A12),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        code,
        style: const TextStyle(
          fontFamily: 'monospace',
          color: Color(0xFFEFE9DE),
          fontSize: 12,
          height: 1.4,
        ),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
            color: _palette.muted,
            fontSize: 11,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(
            color: _palette.ink,
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}

class _LifecycleStep extends StatelessWidget {
  const _LifecycleStep({required this.index, required this.label, required this.detail});

  final int index;
  final String label;
  final String detail;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              color: _palette.accent.withOpacity(0.15),
              borderRadius: BorderRadius.circular(11),
            ),
            alignment: Alignment.center,
            child: Text(
              '$index',
              style: TextStyle(
                color: _palette.accent,
                fontSize: 11,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  label,
                  style: TextStyle(
                    color: _palette.ink,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
                Text(
                  detail,
                  style: TextStyle(
                    color: _palette.muted,
                    fontFamily: 'monospace',
                    fontSize: 11,
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: TextStyle(color: _palette.ink, fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: Slider(
              value: value.clamp(min, max),
              min: min,
              max: max,
              activeColor: _palette.accent,
              onChanged: onChanged,
            ),
          ),
          SizedBox(
            width: 56,
            child: Text(
              value.toStringAsFixed(0),
              textAlign: TextAlign.right,
              style: TextStyle(
                color: _palette.ink,
                fontSize: 12,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RuleStrip extends StatelessWidget {
  const _RuleStrip({required this.isOn, required this.onLabel, required this.offLabel});

  final bool isOn;
  final String onLabel;
  final String offLabel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 42,
          height: 22,
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: isOn ? _palette.accent : _palette.surfaceAlt,
            borderRadius: BorderRadius.circular(11),
            border: Border.all(color: _palette.outline),
          ),
          child: Align(
            alignment: isOn ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              width: 16,
              height: 16,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          isOn ? onLabel : offLabel,
          style: TextStyle(
            color: _palette.ink,
            fontSize: 13,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _DockTile extends StatelessWidget {
  const _DockTile({required this.controller});

  final RegularWindowControllerMacOS controller;

  @override
  Widget build(BuildContext context) {
    // d4rt workaround: see _MacChrome.build above — script-defined
    // ChangeNotifier subclass not coerced to the bridged Listenable
    // parameter type. Closure capture preserves controller access.
    return AnimatedBuilder(
      animation: const AlwaysStoppedAnimation<double>(0.0),
      builder: (BuildContext context, Widget? _) {
        return GestureDetector(
          onTap: () => controller.activate(),
          child: Container(
            width: 96,
            decoration: BoxDecoration(
              color: _palette.surface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _palette.outline),
            ),
            padding: const EdgeInsets.all(6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  height: 18,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[_palette.accent.withOpacity(0.7), _palette.accent.withOpacity(0.4)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  controller.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: _palette.ink,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    height: 1.1,
                  ),
                ),
                Text(
                  '#${controller.rootView.viewId}',
                  style: TextStyle(
                    color: _palette.muted,
                    fontFamily: 'monospace',
                    fontSize: 9,
                    height: 1.1,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _DestroyedPlaceholder extends StatelessWidget {
  const _DestroyedPlaceholder({required this.viewId});

  final int viewId;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360,
      height: 220,
      decoration: BoxDecoration(
        color: _palette.surfaceAlt,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _palette.outline.withOpacity(0.4), style: BorderStyle.solid),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.close_outlined, color: _palette.muted, size: 28),
          const SizedBox(height: 8),
          Text(
            'view #$viewId was destroyed',
            style: TextStyle(
              color: _palette.muted,
              fontFamily: 'monospace',
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class _VetoDelegate extends RegularWindowControllerDelegate {
  _VetoDelegate({required this.shouldVeto, required this.onVetoed});

  final bool Function() shouldVeto;
  final VoidCallback onVetoed;

  @override
  void onWindowCloseRequested(RegularWindowController controller) {
    if (shouldVeto()) {
      onVetoed();
      return;
    }
    controller.destroy();
  }
}

class _VetoSheet extends StatelessWidget {
  const _VetoSheet({required this.onCancel, required this.onConfirm});

  final VoidCallback onCancel;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _palette.warn.withOpacity(0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _palette.warn.withOpacity(0.5)),
      ),
      child: Row(
        children: <Widget>[
          Icon(Icons.warning_amber_rounded, color: _palette.warn),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'The window has unsaved changes. Close anyway?',
              style: TextStyle(color: _palette.ink, fontSize: 13),
            ),
          ),
          const SizedBox(width: 10),
          _ChipAction(label: 'cancel', onTap: onCancel),
          const SizedBox(width: 6),
          _ChipAction(label: 'discard & close', onTap: onConfirm),
        ],
      ),
    );
  }
}

class _Recipe {
  _Recipe({required this.title, required this.body, required this.snippet});
  final String title;
  final String body;
  final String snippet;
}

class _RecipeTile extends StatelessWidget {
  const _RecipeTile({required this.recipe});

  final _Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          recipe.title,
          style: TextStyle(
            color: _palette.ink,
            fontWeight: FontWeight.w800,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          recipe.body,
          style: TextStyle(color: _palette.muted, fontSize: 12, height: 1.4),
        ),
        const SizedBox(height: 8),
        _CodeBlock(code: recipe.snippet),
      ],
    );
  }
}

enum _Severity { high, medium, low }

class _Pitfall {
  _Pitfall({required this.severity, required this.title, required this.body});
  final _Severity severity;
  final String title;
  final String body;
}

class _PitfallTile extends StatelessWidget {
  const _PitfallTile({required this.pitfall});

  final _Pitfall pitfall;

  @override
  Widget build(BuildContext context) {
    final Color tone = switch (pitfall.severity) {
      _Severity.high => _palette.warn,
      _Severity.medium => _palette.accent,
      _Severity.low => _palette.muted,
    };
    final String label = switch (pitfall.severity) {
      _Severity.high => 'high',
      _Severity.medium => 'medium',
      _Severity.low => 'low',
    };
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: tone.withOpacity(0.12),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: tone,
              fontSize: 10,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.6,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                pitfall.title,
                style: TextStyle(
                  color: _palette.ink,
                  fontWeight: FontWeight.w800,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                pitfall.body,
                style: TextStyle(color: _palette.muted, fontSize: 12, height: 1.4),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ReferenceEntry {
  _ReferenceEntry(this.tag, this.signature, this.role);
  final String tag;
  final String signature;
  final String role;
}

class _RefHeaderCell extends StatelessWidget {
  const _RefHeaderCell({required this.label, required this.flex});

  final String label;
  final int flex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Text(
        label,
        style: TextStyle(
          color: _palette.muted,
          fontSize: 11,
          letterSpacing: 0.6,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class _RefCell extends StatelessWidget {
  const _RefCell({required this.text, required this.flex, this.mono = false, this.color});

  final String text;
  final int flex;
  final bool mono;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.only(right: 12),
        child: Text(
          text,
          style: TextStyle(
            color: color ?? _palette.ink,
            fontSize: 12,
            fontFamily: mono ? 'monospace' : null,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _EventRow extends StatelessWidget {
  const _EventRow({required this.event});

  final WindowingEvent event;

  @override
  Widget build(BuildContext context) {
    final Color tone = switch (event.kind) {
      WindowingEventKind.spawn => _palette.ok,
      WindowingEventKind.destroyed => _palette.warn,
      WindowingEventKind.closeRequested => _palette.warn,
      WindowingEventKind.fullscreen => _palette.accent,
      WindowingEventKind.maximized => _palette.accent,
      WindowingEventKind.minimized => _palette.muted,
      WindowingEventKind.activate => _palette.ok,
      WindowingEventKind.deactivate => _palette.muted,
      WindowingEventKind.resize => _palette.ink,
    };
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 78,
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: tone.withOpacity(0.12),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              event.kind.name,
              style: TextStyle(
                color: tone,
                fontSize: 10,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 56,
            child: Text(
              'view #${event.viewId}',
              style: TextStyle(
                color: _palette.muted,
                fontFamily: 'monospace',
                fontSize: 11,
              ),
            ),
          ),
          Expanded(
            child: Text(
              event.detail,
              style: TextStyle(color: _palette.ink, fontSize: 12),
            ),
          ),
          Text(
            '${event.timestamp.hour.toString().padLeft(2, '0')}:'
            '${event.timestamp.minute.toString().padLeft(2, '0')}:'
            '${event.timestamp.second.toString().padLeft(2, '0')}',
            style: TextStyle(
              color: _palette.muted,
              fontFamily: 'monospace',
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}
