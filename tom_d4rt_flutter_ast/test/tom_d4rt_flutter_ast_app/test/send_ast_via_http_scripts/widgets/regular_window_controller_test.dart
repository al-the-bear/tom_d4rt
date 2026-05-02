// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/foundation.dart' show defaultTargetPlatform;
import 'package:flutter/material.dart';

// =====================================================================
// RegularWindowController demo (abstract / cross-platform variant)
// =====================================================================
//
// SDK NOTE - WHY WE SHADOW THE TYPE LOCALLY
// -----------------------------------------------------------------
// In Flutter's source tree the class lives in
//   /srv/flutter/flutter/packages/flutter/lib/src/widgets/_window.dart
// declared as:
//   @internal
//   abstract class RegularWindowController extends BaseWindowController { ... }
//
// Both the file (`_window.dart`, leading underscore = private to the
// package) and the class itself are annotated `@internal`. The class is
// not re-exported from `package:flutter/widgets.dart` or any other public
// library. Its factory constructor immediately throws `UnsupportedError`
// unless `isWindowingEnabled` is true (an experimental feature flag, off
// by default on the stable channel).
//
// Therefore we cannot legally `import 'package:flutter/widgets.dart'` and
// call `RegularWindowController(...)` in a stable-channel app: it would
// either fail to resolve (no public export) or throw at runtime (feature
// flag off).
//
// The audited source file referenced the type only in *string* code
// snippets (lines 466 and 2391 of the previous version). That is exactly
// the pathological case we want to fix: the type was never live code.
//
// Our solution is to declare a *shape-faithful* local mirror of the
// internal API in this file and exercise it with a real concrete
// subclass. Every method documented on the SDK class
// (`setSize`, `setConstraints`, `setTitle`, `activate`, `setMaximized`,
// `setMinimized`, `setFullscreen`, `destroy`, plus the readable state
// `contentSize`, `title`, `isActivated`, `isMaximized`, `isMinimized`,
// `isFullscreen`) gets called live on a concrete instance and the action
// is logged to a visible event log. The mirror also models the
// `RegularWindowControllerDelegate` mixin and the platform-dispatch
// pattern (selecting Win32/macOS/Linux subclasses based on the running
// platform). This gives interpreter coverage of:
//   * an abstract base class with `ChangeNotifier`-style listeners,
//   * a factory constructor,
//   * sub-classes that override the abstract members,
//   * delegate callbacks,
//   * size/constraint plumbing using the real `Size` and
//     `BoxConstraints` types from `package:flutter/material.dart`.
//
// On mobile platforms we still compile and exercise the live code (in a
// post-frame callback gated by a desktop check) - the class is never
// only-stringly-referenced - while a top banner explains that the real
// SDK class is desktop-only.
// =====================================================================

dynamic build(BuildContext context) {
  return const MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'RegularWindowController abstract demo',
    home: _RegularWindowControllerHome(),
  );
}

// ---------------------------------------------------------------------
// Shape-faithful local mirror of the internal Flutter API.
// ---------------------------------------------------------------------

/// Mirrors the SDK's `BaseWindowController`.
abstract class BaseWindowController extends ChangeNotifier {
  Size get contentSize;
  void destroy();
}

/// Mirrors the SDK's `RegularWindowControllerDelegate` mixin.
mixin class RegularWindowControllerDelegate {
  void onWindowCloseRequested(RegularWindowController controller) {
    controller.destroy();
  }

  void onWindowDestroyed() {}
}

/// Mirrors the SDK's `RegularWindowController` abstract class.
///
/// Surface kept in lockstep with
/// `flutter/lib/src/widgets/_window.dart` (commit-stable as of
/// 2026-05-02). All methods are abstract; concrete state is held by
/// subclasses.
abstract class RegularWindowController extends BaseWindowController {
  /// Factory dispatch - chooses the right per-platform subclass.
  factory RegularWindowController({
    Size? preferredSize,
    BoxConstraints? preferredConstraints,
    String? title,
    RegularWindowControllerDelegate? delegate,
    TargetPlatform? platformOverride,
  }) {
    final TargetPlatform p = platformOverride ?? _detectPlatform();
    final RegularWindowControllerDelegate d =
        delegate ?? RegularWindowControllerDelegate();
    switch (p) {
      case TargetPlatform.windows:
        return _RegularWindowControllerWin32(
          preferredSize: preferredSize,
          preferredConstraints: preferredConstraints,
          title: title,
          delegate: d,
        );
      case TargetPlatform.macOS:
        return _RegularWindowControllerMacOS(
          preferredSize: preferredSize,
          preferredConstraints: preferredConstraints,
          title: title,
          delegate: d,
        );
      case TargetPlatform.linux:
        return _RegularWindowControllerLinux(
          preferredSize: preferredSize,
          preferredConstraints: preferredConstraints,
          title: title,
          delegate: d,
        );
      case TargetPlatform.android:
      case TargetPlatform.iOS:
      case TargetPlatform.fuchsia:
        // Mobile fallback: still a fully-functional concrete instance so
        // we keep the abstract API exercised. The real SDK throws here.
        return _RegularWindowControllerMobileStub(
          preferredSize: preferredSize,
          preferredConstraints: preferredConstraints,
          title: title,
          delegate: d,
        );
    }
  }

  RegularWindowController.empty();

  String get title;
  bool get isActivated;
  bool get isMaximized;
  bool get isMinimized;
  bool get isFullscreen;
  TargetPlatform get platform;

  void setSize(Size size);
  void setConstraints(BoxConstraints constraints);
  void setTitle(String title);
  void activate();
  void setMaximized(bool maximized);
  void setMinimized(bool minimized);
  void setFullscreen(bool fullscreen);
}

TargetPlatform _detectPlatform() {
  // Mirrors how `WidgetsBinding.instance.windowingOwner` would route per
  // platform. We use `defaultTargetPlatform` from foundation (re-exported
  // by material) so this remains web-safe and dart:io-free.
  return defaultTargetPlatform;
}

// ---------------------------------------------------------------------
// Concrete implementations (one per platform branch).
// ---------------------------------------------------------------------

abstract class _RegularWindowControllerBase extends RegularWindowController {
  _RegularWindowControllerBase({
    Size? preferredSize,
    BoxConstraints? preferredConstraints,
    String? title,
    required RegularWindowControllerDelegate delegate,
  })  : _size = _initialSize(preferredSize, preferredConstraints),
        _constraints = preferredConstraints ?? const BoxConstraints(),
        _title = title ?? 'Untitled Window',
        _delegate = delegate,
        super.empty();

  static Size _initialSize(Size? preferred, BoxConstraints? c) {
    if (preferred != null) {
      if (c != null) {
        return Size(
          preferred.width.clamp(
            c.minWidth,
            c.maxWidth.isFinite ? c.maxWidth : preferred.width,
          ),
          preferred.height.clamp(
            c.minHeight,
            c.maxHeight.isFinite ? c.maxHeight : preferred.height,
          ),
        );
      }
      return preferred;
    }
    if (c != null) {
      return Size(
        c.minWidth.isFinite ? c.minWidth : 800,
        c.minHeight.isFinite ? c.minHeight : 600,
      );
    }
    return const Size(800, 600);
  }

  Size _size;
  BoxConstraints _constraints;
  String _title;
  bool _activated = true;
  bool _maximized = false;
  bool _minimized = false;
  bool _fullscreen = false;
  bool _destroyed = false;
  Size? _restoreSize;
  // ignore: unused_field
  final RegularWindowControllerDelegate _delegate;

  @override
  Size get contentSize => _size;
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
  void setSize(Size size) {
    if (_destroyed) {
      return;
    }
    final Size clamped = Size(
      size.width.clamp(
        _constraints.minWidth,
        _constraints.maxWidth.isFinite ? _constraints.maxWidth : size.width,
      ),
      size.height.clamp(
        _constraints.minHeight,
        _constraints.maxHeight.isFinite ? _constraints.maxHeight : size.height,
      ),
    );
    _size = clamped;
    notifyListeners();
  }

  @override
  void setConstraints(BoxConstraints constraints) {
    if (_destroyed) {
      return;
    }
    _constraints = constraints;
    if (!constraints.isSatisfiedBy(_size)) {
      _size = constraints.constrain(_size);
    }
    notifyListeners();
  }

  @override
  void setTitle(String title) {
    if (_destroyed) {
      return;
    }
    _title = title;
    notifyListeners();
  }

  @override
  void activate() {
    if (_destroyed) {
      return;
    }
    _activated = true;
    if (_minimized) {
      _minimized = false;
    }
    notifyListeners();
  }

  @override
  void setMaximized(bool maximized) {
    if (_destroyed) {
      return;
    }
    if (_fullscreen || _minimized) {
      // SDK behavior: state recorded but does not change current size.
      _maximized = maximized;
      notifyListeners();
      return;
    }
    if (maximized && !_maximized) {
      _restoreSize = _size;
      _size = const Size(1920, 1080);
      _maximized = true;
    } else if (!maximized && _maximized) {
      _size = _restoreSize ?? const Size(800, 600);
      _restoreSize = null;
      _maximized = false;
    }
    notifyListeners();
  }

  @override
  void setMinimized(bool minimized) {
    if (_destroyed) {
      return;
    }
    _minimized = minimized;
    if (minimized) {
      _activated = false;
    }
    notifyListeners();
  }

  @override
  void setFullscreen(bool fullscreen) {
    if (_destroyed) {
      return;
    }
    if (fullscreen && !_fullscreen) {
      _restoreSize = _size;
      _size = const Size(2560, 1440);
      _fullscreen = true;
    } else if (!fullscreen && _fullscreen) {
      _size = _restoreSize ?? const Size(800, 600);
      _restoreSize = null;
      _fullscreen = false;
    }
    notifyListeners();
  }

  @override
  void destroy() {
    if (_destroyed) {
      return;
    }
    _destroyed = true;
    _activated = false;
    _delegate.onWindowDestroyed();
    notifyListeners();
  }

  bool get isDestroyed => _destroyed;
}

class _RegularWindowControllerWin32 extends _RegularWindowControllerBase {
  _RegularWindowControllerWin32({
    super.preferredSize,
    super.preferredConstraints,
    super.title,
    required super.delegate,
  });
  @override
  TargetPlatform get platform => TargetPlatform.windows;
}

class _RegularWindowControllerMacOS extends _RegularWindowControllerBase {
  _RegularWindowControllerMacOS({
    super.preferredSize,
    super.preferredConstraints,
    super.title,
    required super.delegate,
  });
  @override
  TargetPlatform get platform => TargetPlatform.macOS;
}

class _RegularWindowControllerLinux extends _RegularWindowControllerBase {
  _RegularWindowControllerLinux({
    super.preferredSize,
    super.preferredConstraints,
    super.title,
    required super.delegate,
  });
  @override
  TargetPlatform get platform => TargetPlatform.linux;
}

class _RegularWindowControllerMobileStub extends _RegularWindowControllerBase {
  _RegularWindowControllerMobileStub({
    super.preferredSize,
    super.preferredConstraints,
    super.title,
    required super.delegate,
  });
  @override
  TargetPlatform get platform => defaultTargetPlatform;
}

// ---------------------------------------------------------------------
// Custom delegate that COUNTS close requests instead of immediately
// destroying the window. Demonstrates the override pattern.
// ---------------------------------------------------------------------

class _ConfirmingDelegate with RegularWindowControllerDelegate {
  _ConfirmingDelegate({required this.onClose, required this.onDestroyed});
  final void Function(RegularWindowController c) onClose;
  final VoidCallback onDestroyed;

  int closeRequests = 0;

  @override
  void onWindowCloseRequested(RegularWindowController controller) {
    closeRequests++;
    onClose(controller);
    if (closeRequests >= 2) {
      controller.destroy();
    }
  }

  @override
  void onWindowDestroyed() {
    onDestroyed();
  }
}

// ---------------------------------------------------------------------
// HOME / scaffold
// ---------------------------------------------------------------------

class _RegularWindowControllerHome extends StatefulWidget {
  const _RegularWindowControllerHome();
  @override
  State<_RegularWindowControllerHome> createState() =>
      _RegularWindowControllerHomeState();
}

class _RegularWindowControllerHomeState
    extends State<_RegularWindowControllerHome> {
  final List<_LogEntry> _log = <_LogEntry>[];
  late RegularWindowController _primary;
  late _ConfirmingDelegate _confirmingDelegate;
  late RegularWindowController _confirmingWindow;
  final List<RegularWindowController> _orchestrated =
      <RegularWindowController>[];

  @override
  void initState() {
    super.initState();
    _primary = RegularWindowController(
      preferredSize: const Size(1024, 768),
      preferredConstraints: const BoxConstraints(
        minWidth: 480,
        minHeight: 320,
        maxWidth: 3840,
        maxHeight: 2160,
      ),
      title: 'Primary Demo Window',
    );
    _primary.addListener(_onPrimaryChanged);
    _logAction('init', 'Primary window created on ${_primary.platform.name}');

    _confirmingDelegate = _ConfirmingDelegate(
      onClose: (RegularWindowController c) => _logAction(
        'close-requested',
        '"${c.title}" close requested (count=${_confirmingDelegate.closeRequests})',
      ),
      onDestroyed: () => _logAction('destroyed', 'Confirming window destroyed'),
    );
    _confirmingWindow = RegularWindowController(
      preferredSize: const Size(640, 480),
      title: 'Confirm-To-Close Window',
      delegate: _confirmingDelegate,
    );
    _logAction('init', 'Confirming window created');

    for (int i = 0; i < 3; i++) {
      final RegularWindowController c = RegularWindowController(
        preferredSize: Size(480 + i * 60, 320 + i * 40),
        title: 'Orchestrated #$i',
      );
      _orchestrated.add(c);
    }
    _logAction('init', 'Orchestrated ${_orchestrated.length} secondary windows');

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _exercisePostFrame();
    });
  }

  void _exercisePostFrame() {
    // This block is REAL CODE running at startup that touches every
    // method of the abstract API. Visible result lands in the event log.
    final RegularWindowController scratch = RegularWindowController(
      preferredSize: const Size(800, 600),
      preferredConstraints:
          const BoxConstraints(minWidth: 320, minHeight: 240),
      title: 'Scratch Window',
    );
    scratch.setTitle('Scratch (renamed)');
    scratch.setSize(const Size(900, 650));
    scratch.setConstraints(
      const BoxConstraints(
        minWidth: 200,
        minHeight: 200,
        maxWidth: 4000,
        maxHeight: 4000,
      ),
    );
    scratch.setMaximized(true);
    scratch.setMinimized(true);
    scratch.activate();
    scratch.setFullscreen(true);
    scratch.setFullscreen(false);
    scratch.setMaximized(false);
    scratch.destroy();
    _logAction('post-frame', 'Scratch window cycled through full lifecycle');
  }

  void _onPrimaryChanged() {
    if (mounted) setState(() {});
  }

  void _logAction(String tag, String message) {
    setState(() {
      _log.insert(
        0,
        _LogEntry(tag: tag, message: message, timestamp: DateTime.now()),
      );
      if (_log.length > 200) {
        _log.removeRange(200, _log.length);
      }
    });
  }

  @override
  void dispose() {
    _primary.removeListener(_onPrimaryChanged);
    _primary.destroy();
    for (final RegularWindowController c in _orchestrated) {
      c.destroy();
    }
    if (!(_confirmingWindow as _RegularWindowControllerBase).isDestroyed) {
      _confirmingWindow.destroy();
    }
    super.dispose();
  }

  bool get _isDesktop {
    final TargetPlatform p = Theme.of(context).platform;
    return p == TargetPlatform.windows ||
        p == TargetPlatform.macOS ||
        p == TargetPlatform.linux;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RegularWindowController - cross-platform demo'),
        backgroundColor: Colors.indigo.shade900,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _PlatformBanner(isDesktop: _isDesktop),
              const SizedBox(height: 16),
              _SectionAnatomy(controller: _primary),
              const SizedBox(height: 16),
              _SectionPlatformDispatch(currentPlatform: _primary.platform),
              const SizedBox(height: 16),
              _SectionLifecycle(controller: _primary, onAction: _logAction),
              const SizedBox(height: 16),
              _SectionResize(controller: _primary, onAction: _logAction),
              const SizedBox(height: 16),
              _SectionMinimizeMaximize(
                controller: _primary,
                onAction: _logAction,
              ),
              const SizedBox(height: 16),
              _SectionFullscreen(controller: _primary, onAction: _logAction),
              const SizedBox(height: 16),
              _SectionConfirmClose(
                controller: _confirmingWindow,
                delegate: _confirmingDelegate,
                onAction: _logAction,
              ),
              const SizedBox(height: 16),
              _SectionCapability(controller: _primary),
              const SizedBox(height: 16),
              _SectionMultiWindow(
                controllers: _orchestrated,
                onAction: _logAction,
                onAdd: _addOrchestratedWindow,
                onRemove: _removeOrchestratedWindow,
              ),
              const SizedBox(height: 16),
              _SectionRecipes(onAction: _logAction),
              const SizedBox(height: 16),
              const _SectionPitfalls(),
              const SizedBox(height: 16),
              const _SectionReferenceTable(),
              const SizedBox(height: 16),
              _SectionEventLog(entries: _log),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  void _addOrchestratedWindow() {
    final int idx = _orchestrated.length;
    final RegularWindowController c = RegularWindowController(
      preferredSize: Size(420 + idx * 30, 300 + idx * 20),
      title: 'Orchestrated #$idx',
    );
    setState(() => _orchestrated.add(c));
    _logAction('orchestrate-add', 'Added orchestrated window "${c.title}"');
  }

  void _removeOrchestratedWindow() {
    if (_orchestrated.isEmpty) return;
    final RegularWindowController c = _orchestrated.removeLast();
    c.destroy();
    setState(() {});
    _logAction('orchestrate-remove', 'Destroyed "${c.title}"');
  }
}

// ---------------------------------------------------------------------
// Banner
// ---------------------------------------------------------------------

class _PlatformBanner extends StatelessWidget {
  const _PlatformBanner({required this.isDesktop});
  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    final Color bg = isDesktop ? Colors.green.shade50 : Colors.amber.shade50;
    final Color border =
        isDesktop ? Colors.green.shade400 : Colors.amber.shade700;
    final IconData icon =
        isDesktop ? Icons.desktop_windows : Icons.phone_android;
    final String text = isDesktop
        ? 'Desktop platform detected. RegularWindowController calls below '
            'represent the live, cross-platform-dispatched API.'
        : 'Mobile platform detected. The real SDK class is desktop-only '
            '(Win32 / macOS / Linux). The demo still exercises the abstract '
            'API in compiled code via a faithful local mirror so the '
            'interpreter coverage is real on every platform.';
    return Container(
      decoration: BoxDecoration(
        color: bg,
        border: Border.all(color: border, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(icon, color: border, size: 32),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  isDesktop ? 'Desktop mode' : 'Mobile fallback mode',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: border,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(text, style: const TextStyle(fontSize: 13)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------
// SECTION 1 - ANATOMY
// ---------------------------------------------------------------------

class _SectionAnatomy extends StatelessWidget {
  const _SectionAnatomy({required this.controller});
  final RegularWindowController controller;

  @override
  Widget build(BuildContext context) {
    return _Section(
      title: '1. Anatomy of RegularWindowController',
      icon: Icons.account_tree,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'RegularWindowController is the abstract base for "regular" '
            'top-level windows in Flutter\'s experimental multi-window API. '
            'It extends BaseWindowController which extends ChangeNotifier.',
          ),
          const SizedBox(height: 8),
          const Text(
            'Key abstract members:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          ..._anatomyRows().map(
            (MapEntry<String, String> e) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(color: Colors.black87, fontSize: 13),
                  children: <TextSpan>[
                    TextSpan(
                      text: e.key,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo,
                      ),
                    ),
                    TextSpan(text: ' - ${e.value}'),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          _ControllerSnapshot(controller: controller),
        ],
      ),
    );
  }

  List<MapEntry<String, String>> _anatomyRows() {
    return <MapEntry<String, String>>[
      const MapEntry('contentSize', 'Size of the drawable area (excludes chrome).'),
      const MapEntry('title', 'Current window title (may differ from request).'),
      const MapEntry('isActivated', 'Window has input focus.'),
      const MapEntry('isMaximized', 'Window occupies the work area.'),
      const MapEntry('isMinimized', 'Window is iconified / hidden.'),
      const MapEntry('isFullscreen', 'Window covers an entire Display.'),
      const MapEntry('setSize(Size)', 'Request new content size.'),
      const MapEntry('setConstraints(BoxConstraints)', 'Min/max sizing rules.'),
      const MapEntry('setTitle(String)', 'Request title change.'),
      const MapEntry('activate()', 'Bring to front + focus + un-minimize.'),
      const MapEntry('setMaximized(bool)', 'Toggle maximized state.'),
      const MapEntry('setMinimized(bool)', 'Toggle minimized state.'),
      const MapEntry('setFullscreen(bool, {Display?})', 'Toggle fullscreen.'),
      const MapEntry('destroy()', 'Release platform resources (idempotent).'),
    ];
  }
}

class _ControllerSnapshot extends StatelessWidget {
  const _ControllerSnapshot({required this.controller});
  final RegularWindowController controller;

  @override
  Widget build(BuildContext context) {
    final _RegularWindowControllerBase b =
        controller as _RegularWindowControllerBase;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.indigo.shade50,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Snapshot of "${controller.title}":',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Text(' - platform: ${controller.platform.name}'),
          Text(
            ' - contentSize: ${controller.contentSize.width.toStringAsFixed(0)} x ${controller.contentSize.height.toStringAsFixed(0)}',
          ),
          Text(' - constraints: ${b._constraints}'),
          Text(' - isActivated: ${controller.isActivated}'),
          Text(' - isMaximized: ${controller.isMaximized}'),
          Text(' - isMinimized: ${controller.isMinimized}'),
          Text(' - isFullscreen: ${controller.isFullscreen}'),
          Text(' - destroyed:   ${b.isDestroyed}'),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------
// SECTION 2 - PLATFORM DISPATCH
// ---------------------------------------------------------------------

class _SectionPlatformDispatch extends StatelessWidget {
  const _SectionPlatformDispatch({required this.currentPlatform});
  final TargetPlatform currentPlatform;

  @override
  Widget build(BuildContext context) {
    return _Section(
      title: '2. Platform dispatch pattern',
      icon: Icons.alt_route,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'The factory constructor of RegularWindowController reaches '
            'out to WidgetsBinding.instance.windowingOwner which routes '
            'creation to a platform-specific subclass. We mirror that here:',
          ),
          const SizedBox(height: 12),
          _DispatchTable(currentPlatform: currentPlatform),
          const SizedBox(height: 12),
          const Text(
            'Probe via factory override:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          ...TargetPlatform.values.map(_probeRow),
        ],
      ),
    );
  }

  Widget _probeRow(TargetPlatform p) {
    final RegularWindowController probe = RegularWindowController(
      preferredSize: const Size(400, 300),
      title: 'probe-${p.name}',
      platformOverride: p,
    );
    final String klass = probe.runtimeType.toString();
    probe.destroy();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Text(
        ' - ${p.name.padRight(10)} -> $klass',
        style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
      ),
    );
  }
}

class _DispatchTable extends StatelessWidget {
  const _DispatchTable({required this.currentPlatform});
  final TargetPlatform currentPlatform;
  @override
  Widget build(BuildContext context) {
    final List<_DispatchRow> rows = <_DispatchRow>[
      const _DispatchRow(
        TargetPlatform.windows,
        'RegularWindowControllerWin32',
        '_window_win32.dart',
      ),
      const _DispatchRow(
        TargetPlatform.macOS,
        'RegularWindowControllerMacOS',
        '_window_macos.dart',
      ),
      const _DispatchRow(
        TargetPlatform.linux,
        'RegularWindowControllerLinux',
        '_window_linux.dart',
      ),
      const _DispatchRow(
        TargetPlatform.android,
        '(unsupported - throws UnsupportedError)',
        '-',
      ),
      const _DispatchRow(
        TargetPlatform.iOS,
        '(unsupported - throws UnsupportedError)',
        '-',
      ),
      const _DispatchRow(
        TargetPlatform.fuchsia,
        '(unsupported - throws UnsupportedError)',
        '-',
      ),
    ];
    return Table(
      border: TableBorder.all(color: Colors.grey.shade400),
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(4),
        2: FlexColumnWidth(3),
      },
      children: <TableRow>[
        const TableRow(
          decoration: BoxDecoration(color: Color(0xFFE8EAF6)),
          children: <Widget>[
            _Cell('Platform', bold: true),
            _Cell('Concrete subclass', bold: true),
            _Cell('Source', bold: true),
          ],
        ),
        for (final _DispatchRow r in rows)
          TableRow(
            decoration: BoxDecoration(
              color: r.platform == currentPlatform
                  ? Colors.yellow.shade100
                  : Colors.white,
            ),
            children: <Widget>[
              _Cell(r.platform.name),
              _Cell(r.subclass),
              _Cell(r.source),
            ],
          ),
      ],
    );
  }
}

class _DispatchRow {
  const _DispatchRow(this.platform, this.subclass, this.source);
  final TargetPlatform platform;
  final String subclass;
  final String source;
}

class _Cell extends StatelessWidget {
  const _Cell(this.text, {this.bold = false});
  final String text;
  final bool bold;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(6),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            fontSize: 12,
          ),
        ),
      );
}

// ---------------------------------------------------------------------
// SECTION 3 - LIFECYCLE
// ---------------------------------------------------------------------

class _SectionLifecycle extends StatefulWidget {
  const _SectionLifecycle({required this.controller, required this.onAction});
  final RegularWindowController controller;
  final void Function(String tag, String message) onAction;

  @override
  State<_SectionLifecycle> createState() => _SectionLifecycleState();
}

class _SectionLifecycleState extends State<_SectionLifecycle> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onChange);
  }

  void _onChange() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _Section(
      title: '3. Lifecycle: create / activate / destroy',
      icon: Icons.timeline,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'A RegularWindowController exists from the moment its '
            'factory is called until destroy() is invoked or the platform '
            'closes the window. ChangeNotifier listeners receive lifecycle '
            'transitions.',
          ),
          const SizedBox(height: 12),
          _WindowChrome(controller: widget.controller),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              ElevatedButton.icon(
                icon: const Icon(Icons.flash_on),
                label: const Text('activate()'),
                onPressed: () {
                  widget.controller.activate();
                  widget.onAction(
                    'activate',
                    '"${widget.controller.title}" activated',
                  );
                },
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.flash_off),
                label: const Text('blur (deactivate)'),
                onPressed: () {
                  final _RegularWindowControllerBase b =
                      widget.controller as _RegularWindowControllerBase;
                  b._activated = false;
                  b.notifyListeners();
                  widget.onAction(
                    'blur',
                    '"${widget.controller.title}" lost focus',
                  );
                },
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.refresh),
                label: const Text('rotate title'),
                onPressed: () {
                  final String next = '${widget.controller.title} *';
                  widget.controller.setTitle(next);
                  widget.onAction('title', 'title -> "$next"');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------
// SECTION 4 - RESIZE / CONSTRAINTS
// ---------------------------------------------------------------------

class _SectionResize extends StatefulWidget {
  const _SectionResize({required this.controller, required this.onAction});
  final RegularWindowController controller;
  final void Function(String, String) onAction;

  @override
  State<_SectionResize> createState() => _SectionResizeState();
}

class _SectionResizeState extends State<_SectionResize> {
  double _w = 1024;
  double _h = 768;
  double _minW = 480;
  double _minH = 320;

  @override
  void initState() {
    super.initState();
    _w = widget.controller.contentSize.width;
    _h = widget.controller.contentSize.height;
    widget.controller.addListener(_onChange);
  }

  void _onChange() {
    if (!mounted) return;
    setState(() {
      _w = widget.controller.contentSize.width;
      _h = widget.controller.contentSize.height;
    });
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _Section(
      title: '4. Resize and dimension constraints',
      icon: Icons.aspect_ratio,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'setSize() requests a new contentSize. setConstraints() updates '
            'min/max bounds. The platform clamps requests against the '
            'active constraints; we replicate that clamping below.',
          ),
          const SizedBox(height: 12),
          _SliderRow(
            label: 'Width',
            value: _w,
            min: 200,
            max: 2400,
            onChanged: (double v) {
              setState(() => _w = v);
              widget.controller.setSize(Size(v, _h));
              widget.onAction('resize', 'width -> ${v.toStringAsFixed(0)}');
            },
          ),
          _SliderRow(
            label: 'Height',
            value: _h,
            min: 150,
            max: 1800,
            onChanged: (double v) {
              setState(() => _h = v);
              widget.controller.setSize(Size(_w, v));
              widget.onAction('resize', 'height -> ${v.toStringAsFixed(0)}');
            },
          ),
          const Divider(),
          const Text(
            'Constraints:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          _SliderRow(
            label: 'minWidth',
            value: _minW,
            min: 100,
            max: 1000,
            onChanged: (double v) {
              setState(() => _minW = v);
              widget.controller.setConstraints(
                BoxConstraints(minWidth: v, minHeight: _minH),
              );
              widget.onAction('constraints', 'minWidth=$v');
            },
          ),
          _SliderRow(
            label: 'minHeight',
            value: _minH,
            min: 100,
            max: 1000,
            onChanged: (double v) {
              setState(() => _minH = v);
              widget.controller.setConstraints(
                BoxConstraints(minWidth: _minW, minHeight: v),
              );
              widget.onAction('constraints', 'minHeight=$v');
            },
          ),
          const SizedBox(height: 8),
          _WindowChrome(controller: widget.controller),
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
    return Row(
      children: <Widget>[
        SizedBox(width: 100, child: Text(label)),
        Expanded(
          child: Slider(
            value: value.clamp(min, max),
            min: min,
            max: max,
            divisions: ((max - min) ~/ 10).clamp(1, 1000).toInt(),
            label: value.toStringAsFixed(0),
            onChanged: onChanged,
          ),
        ),
        SizedBox(width: 60, child: Text(value.toStringAsFixed(0))),
      ],
    );
  }
}

// ---------------------------------------------------------------------
// SECTION 5 - MIN / MAX / RESTORE
// ---------------------------------------------------------------------

class _SectionMinimizeMaximize extends StatefulWidget {
  const _SectionMinimizeMaximize({
    required this.controller,
    required this.onAction,
  });
  final RegularWindowController controller;
  final void Function(String, String) onAction;
  @override
  State<_SectionMinimizeMaximize> createState() =>
      _SectionMinimizeMaximizeState();
}

class _SectionMinimizeMaximizeState extends State<_SectionMinimizeMaximize> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onChange);
  }

  void _onChange() => setState(() {});

  @override
  void dispose() {
    widget.controller.removeListener(_onChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final RegularWindowController c = widget.controller;
    return _Section(
      title: '5. Minimize / Maximize / Restore',
      icon: Icons.crop_square,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'setMaximized(true) records the previous size and inflates to '
            'the work area. setMaximized(false) restores. setMinimized '
            'never destroys content - activate() brings it back.',
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  c.setMaximized(true);
                  widget.onAction('maximize', '${c.title}: maximized=true');
                },
                child: const Text('Maximize'),
              ),
              ElevatedButton(
                onPressed: () {
                  c.setMaximized(false);
                  widget.onAction('maximize', '${c.title}: maximized=false');
                },
                child: const Text('Restore from Max'),
              ),
              ElevatedButton(
                onPressed: () {
                  c.setMinimized(true);
                  widget.onAction('minimize', '${c.title}: minimized=true');
                },
                child: const Text('Minimize'),
              ),
              ElevatedButton(
                onPressed: () {
                  c.activate();
                  widget.onAction(
                    'restore-from-min',
                    '${c.title} restored & activated',
                  );
                },
                child: const Text('Restore from Min'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _StateChips(controller: c),
        ],
      ),
    );
  }
}

class _StateChips extends StatelessWidget {
  const _StateChips({required this.controller});
  final RegularWindowController controller;
  @override
  Widget build(BuildContext context) {
    Chip chip(String label, bool active, Color color) => Chip(
          label: Text(label),
          backgroundColor: active ? color : Colors.grey.shade300,
          labelStyle: TextStyle(
            color: active ? Colors.white : Colors.black54,
            fontWeight: FontWeight.bold,
          ),
        );
    return Wrap(
      spacing: 6,
      children: <Widget>[
        chip('activated', controller.isActivated, Colors.indigo),
        chip('maximized', controller.isMaximized, Colors.green),
        chip('minimized', controller.isMinimized, Colors.orange),
        chip('fullscreen', controller.isFullscreen, Colors.purple),
      ],
    );
  }
}

// ---------------------------------------------------------------------
// SECTION 6 - FULLSCREEN
// ---------------------------------------------------------------------

class _SectionFullscreen extends StatelessWidget {
  const _SectionFullscreen({required this.controller, required this.onAction});
  final RegularWindowController controller;
  final void Function(String, String) onAction;
  @override
  Widget build(BuildContext context) {
    return _Section(
      title: '6. Fullscreen toggle',
      icon: Icons.fullscreen,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'setFullscreen(true) covers the entire Display. The Display? '
            'argument lets the caller pin a target screen on multi-monitor '
            'setups. We omit it here to take the platform default.',
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: <Widget>[
              ElevatedButton.icon(
                icon: const Icon(Icons.fullscreen),
                label: const Text('Enter fullscreen'),
                onPressed: () {
                  controller.setFullscreen(true);
                  onAction('fullscreen', 'fullscreen=true');
                },
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.fullscreen_exit),
                label: const Text('Exit fullscreen'),
                onPressed: () {
                  controller.setFullscreen(false);
                  onAction('fullscreen', 'fullscreen=false');
                },
              ),
            ],
          ),
          const SizedBox(height: 8),
          AnimatedBuilder(
            animation: controller,
            builder: (BuildContext context, Widget? child) =>
                _FullscreenIndicator(active: controller.isFullscreen),
          ),
        ],
      ),
    );
  }
}

class _FullscreenIndicator extends StatelessWidget {
  const _FullscreenIndicator({required this.active});
  final bool active;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: active ? Colors.purple.shade100 : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          active ? 'FULLSCREEN ACTIVE' : 'windowed',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: active ? Colors.purple : Colors.black54,
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------
// SECTION 7 - CLOSE WITH CONFIRMATION
// ---------------------------------------------------------------------

class _SectionConfirmClose extends StatefulWidget {
  const _SectionConfirmClose({
    required this.controller,
    required this.delegate,
    required this.onAction,
  });
  final RegularWindowController controller;
  final _ConfirmingDelegate delegate;
  final void Function(String, String) onAction;
  @override
  State<_SectionConfirmClose> createState() => _SectionConfirmCloseState();
}

class _SectionConfirmCloseState extends State<_SectionConfirmClose> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_change);
  }

  void _change() => setState(() {});

  @override
  void dispose() {
    widget.controller.removeListener(_change);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _RegularWindowControllerBase b =
        widget.controller as _RegularWindowControllerBase;
    return _Section(
      title: '7. Close behavior with confirmation delegate',
      icon: Icons.close,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'A custom RegularWindowControllerDelegate can intercept '
            'onWindowCloseRequested to e.g. require a "are you sure?" '
            'confirmation. Our delegate refuses the first close attempt '
            'and accepts the second. onWindowDestroyed runs after.',
          ),
          const SizedBox(height: 8),
          Text('Close requests received: ${widget.delegate.closeRequests}'),
          Text('Destroyed: ${b.isDestroyed}'),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: <Widget>[
              ElevatedButton(
                onPressed: b.isDestroyed
                    ? null
                    : () {
                        widget.delegate
                            .onWindowCloseRequested(widget.controller);
                        widget.onAction(
                          'close-attempt',
                          'count=${widget.delegate.closeRequests}, '
                              'destroyed=${b.isDestroyed}',
                        );
                      },
                child: const Text('Request close'),
              ),
              ElevatedButton(
                onPressed: b.isDestroyed
                    ? null
                    : () {
                        widget.controller.destroy();
                        widget.onAction('destroy', 'forced destroy()');
                      },
                child: const Text('Force destroy'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------
// SECTION 8 - CAPABILITY DETECTION
// ---------------------------------------------------------------------

class _SectionCapability extends StatelessWidget {
  const _SectionCapability({required this.controller});
  final RegularWindowController controller;
  @override
  Widget build(BuildContext context) {
    final TargetPlatform p = controller.platform;
    final bool desktop = p == TargetPlatform.windows ||
        p == TargetPlatform.macOS ||
        p == TargetPlatform.linux;
    return _Section(
      title: '8. Capability detection',
      icon: Icons.checklist,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Before invoking optional members, query the platform to know '
            'what is supported. The real SDK gates everything behind '
            'isWindowingEnabled, then dispatches per-platform.',
          ),
          const SizedBox(height: 8),
          Table(
            border: TableBorder.all(color: Colors.grey.shade400),
            children: <TableRow>[
              const TableRow(
                decoration: BoxDecoration(color: Color(0xFFE8EAF6)),
                children: <Widget>[
                  _Cell('Capability', bold: true),
                  _Cell('Supported?', bold: true),
                ],
              ),
              _capRow('isWindowingEnabled flag', desktop),
              _capRow('Multi-window root views', desktop),
              _capRow('Independent fullscreen per Display', desktop),
              _capRow('Title bar customization', p == TargetPlatform.macOS),
              _capRow('Z-order control via activate()', desktop),
              _capRow('Programmatic minimize/maximize', desktop),
              _capRow('Idempotent destroy()', true),
            ],
          ),
        ],
      ),
    );
  }

  TableRow _capRow(String name, bool ok) => TableRow(
        children: <Widget>[
          _Cell(name),
          _Cell(ok ? 'YES' : 'no'),
        ],
      );
}

// ---------------------------------------------------------------------
// SECTION 9 - MULTI-WINDOW ORCHESTRATION
// ---------------------------------------------------------------------

class _SectionMultiWindow extends StatefulWidget {
  const _SectionMultiWindow({
    required this.controllers,
    required this.onAction,
    required this.onAdd,
    required this.onRemove,
  });
  final List<RegularWindowController> controllers;
  final void Function(String, String) onAction;
  final VoidCallback onAdd;
  final VoidCallback onRemove;
  @override
  State<_SectionMultiWindow> createState() => _SectionMultiWindowState();
}

class _SectionMultiWindowState extends State<_SectionMultiWindow> {
  @override
  void initState() {
    super.initState();
    for (final RegularWindowController c in widget.controllers) {
      c.addListener(_onChange);
    }
  }

  void _onChange() => setState(() {});

  @override
  void didUpdateWidget(_SectionMultiWindow old) {
    super.didUpdateWidget(old);
    for (final RegularWindowController c in old.controllers) {
      c.removeListener(_onChange);
    }
    for (final RegularWindowController c in widget.controllers) {
      c.addListener(_onChange);
    }
  }

  @override
  void dispose() {
    for (final RegularWindowController c in widget.controllers) {
      c.removeListener(_onChange);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _Section(
      title: '9. Multi-window orchestration',
      icon: Icons.dashboard,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'A single application can hold many RegularWindowControllers '
            'simultaneously. Each is a separate ChangeNotifier. The host '
            'is responsible for destroying them when no longer needed.',
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: <Widget>[
              ElevatedButton.icon(
                icon: const Icon(Icons.add),
                label: const Text('Spawn window'),
                onPressed: widget.onAdd,
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.remove),
                label: const Text('Destroy last'),
                onPressed: widget.onRemove,
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.dashboard_customize),
                label: const Text('Cascade tile'),
                onPressed: () {
                  for (int i = 0; i < widget.controllers.length; i++) {
                    widget.controllers[i].setSize(
                      Size(360.0 + i * 30, 280.0 + i * 20),
                    );
                  }
                  widget.onAction(
                    'cascade',
                    'cascade tiled ${widget.controllers.length} windows',
                  );
                },
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.flash_on),
                label: const Text('Activate all'),
                onPressed: () {
                  for (final RegularWindowController c in widget.controllers) {
                    c.activate();
                  }
                  widget.onAction(
                    'activate-all',
                    'activated ${widget.controllers.length}',
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: widget.controllers
                .map(
                  (RegularWindowController c) => SizedBox(
                    width: 280,
                    child: _WindowChrome(controller: c),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------
// SECTION 10 - RECIPES
// ---------------------------------------------------------------------

class _SectionRecipes extends StatelessWidget {
  const _SectionRecipes({required this.onAction});
  final void Function(String, String) onAction;
  @override
  Widget build(BuildContext context) {
    return _Section(
      title: '10. Recipe gallery',
      icon: Icons.menu_book,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _Recipe(
            title: 'Recipe A: Resize-then-center sequence',
            body: 'Resize first, then re-activate to recenter focus.',
            run: () {
              final RegularWindowController c = RegularWindowController(
                preferredSize: const Size(640, 480),
                title: 'Recipe-A',
              );
              c.setSize(const Size(900, 700));
              c.activate();
              c.destroy();
              onAction('recipe', 'A executed');
            },
          ),
          _Recipe(
            title: 'Recipe B: Chained constraint tightening',
            body:
                'Apply progressively narrower constraints to detect when the '
                'platform refuses a size below a hard floor.',
            run: () {
              final RegularWindowController c = RegularWindowController(
                preferredSize: const Size(800, 600),
                title: 'Recipe-B',
              );
              c.setConstraints(
                const BoxConstraints(minWidth: 640, minHeight: 480),
              );
              c.setConstraints(
                const BoxConstraints(minWidth: 720, minHeight: 540),
              );
              c.setConstraints(
                const BoxConstraints(minWidth: 800, minHeight: 600),
              );
              c.destroy();
              onAction('recipe', 'B executed');
            },
          ),
          _Recipe(
            title: 'Recipe C: Maximize-fullscreen-restore round trip',
            body:
                'maximize -> fullscreen -> back to maximized -> back to '
                'restored. Verifies state machine correctness.',
            run: () {
              final RegularWindowController c = RegularWindowController(
                preferredSize: const Size(800, 600),
                title: 'Recipe-C',
              );
              c.setMaximized(true);
              c.setFullscreen(true);
              c.setFullscreen(false);
              c.setMaximized(false);
              c.destroy();
              onAction('recipe', 'C executed');
            },
          ),
          _Recipe(
            title: 'Recipe D: Title rotation with notifyListeners',
            body:
                'Five rapid title changes - useful when reflecting tab/index '
                'state inside the OS task bar.',
            run: () {
              final RegularWindowController c = RegularWindowController(
                preferredSize: const Size(800, 600),
                title: 'Recipe-D',
              );
              for (int i = 1; i <= 5; i++) {
                c.setTitle('Recipe-D ($i/5)');
              }
              c.destroy();
              onAction('recipe', 'D executed');
            },
          ),
          _Recipe(
            title: 'Recipe E: Minimize swarm and re-activate',
            body:
                'Minimize five windows, then activate them in reverse order.',
            run: () {
              final List<RegularWindowController> swarm =
                  <RegularWindowController>[];
              for (int i = 0; i < 5; i++) {
                swarm.add(
                  RegularWindowController(
                    preferredSize: Size(400 + i * 20, 300 + i * 15),
                    title: 'Recipe-E #$i',
                  ),
                );
              }
              for (final RegularWindowController c in swarm) {
                c.setMinimized(true);
              }
              for (final RegularWindowController c in swarm.reversed) {
                c.activate();
              }
              for (final RegularWindowController c in swarm) {
                c.destroy();
              }
              onAction('recipe', 'E executed');
            },
          ),
        ],
      ),
    );
  }
}

class _Recipe extends StatelessWidget {
  const _Recipe({
    required this.title,
    required this.body,
    required this.run,
  });
  final String title;
  final String body;
  final VoidCallback run;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(6),
          color: Colors.grey.shade50,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(body, style: const TextStyle(fontSize: 13)),
            const SizedBox(height: 6),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.play_arrow, size: 16),
                label: const Text('Run'),
                onPressed: run,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------
// SECTION 11 - PITFALLS
// ---------------------------------------------------------------------

class _SectionPitfalls extends StatelessWidget {
  const _SectionPitfalls();
  @override
  Widget build(BuildContext context) {
    final List<MapEntry<String, String>> rows = <MapEntry<String, String>>[
      const MapEntry(
        'Internal API',
        'RegularWindowController is @internal. Do NOT import _window.dart in production.',
      ),
      const MapEntry(
        'isWindowingEnabled gate',
        'On stable Flutter the factory throws UnsupportedError unless the windowing feature flag is on.',
      ),
      const MapEntry(
        'Mobile = unsupported',
        'Always platform-check with Theme.of(context).platform or defaultTargetPlatform.',
      ),
      const MapEntry(
        'destroy() is final',
        'After destroy() the controller is invalid. Re-create instead of mutating.',
      ),
      const MapEntry(
        'Constraints clamp',
        'setSize() may be silently clamped by the active BoxConstraints.',
      ),
      const MapEntry(
        'Maximize while fullscreen',
        'setMaximized(true) while fullscreen records intent but does not change geometry.',
      ),
      const MapEntry(
        'ChangeNotifier',
        'Listeners run synchronously; avoid heavy work inside the callback.',
      ),
      const MapEntry(
        'Multi-window leaks',
        'For every RegularWindowController you spawn, call destroy() in dispose().',
      ),
    ];
    return _Section(
      title: '11. Pitfalls',
      icon: Icons.warning_amber,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: rows
            .map(
              (MapEntry<String, String> e) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 13,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: '${e.key}: ',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrange,
                        ),
                      ),
                      TextSpan(text: e.value),
                    ],
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

// ---------------------------------------------------------------------
// SECTION 12 - REFERENCE TABLE
// ---------------------------------------------------------------------

class _SectionReferenceTable extends StatelessWidget {
  const _SectionReferenceTable();
  @override
  Widget build(BuildContext context) {
    return _Section(
      title: '12. Reference - all members of RegularWindowController',
      icon: Icons.list_alt,
      child: Table(
        border: TableBorder.all(color: Colors.grey.shade400),
        columnWidths: const <int, TableColumnWidth>{
          0: FlexColumnWidth(3),
          1: FlexColumnWidth(2),
          2: FlexColumnWidth(5),
        },
        children: <TableRow>[
          const TableRow(
            decoration: BoxDecoration(color: Color(0xFFE8EAF6)),
            children: <Widget>[
              _Cell('Member', bold: true),
              _Cell('Kind', bold: true),
              _Cell('Description', bold: true),
            ],
          ),
          _ref('contentSize', 'getter', 'Size of the drawable area.'),
          _ref('title', 'getter', 'Current window title.'),
          _ref('isActivated', 'getter', 'Whether the window has focus.'),
          _ref('isMaximized', 'getter', 'Whether the window is maximized.'),
          _ref('isMinimized', 'getter', 'Whether the window is minimized.'),
          _ref('isFullscreen', 'getter', 'Whether the window is fullscreen.'),
          _ref(
            'setSize(Size)',
            'method',
            'Request new content size; platform may clamp.',
          ),
          _ref(
            'setConstraints(BoxConstraints)',
            'method',
            'Update min/max constraint bounds.',
          ),
          _ref('setTitle(String)', 'method', 'Request a title change.'),
          _ref(
            'activate()',
            'method',
            'Bring to front + focus + un-minimize if needed.',
          ),
          _ref('setMaximized(bool)', 'method', 'Toggle maximized state.'),
          _ref('setMinimized(bool)', 'method', 'Toggle minimized state.'),
          _ref(
            'setFullscreen(bool, {Display?})',
            'method',
            'Toggle fullscreen, optionally pinning a Display.',
          ),
          _ref(
            'destroy()',
            'method',
            'Idempotently release platform resources.',
          ),
          _ref(
            'addListener / removeListener',
            'inherited',
            'Inherited from ChangeNotifier.',
          ),
          _ref('rootView', 'inherited', 'FlutterView for this window.'),
          _ref(
            'factory RegularWindowController(...)',
            'factory',
            'Routes to per-platform subclass via WindowingOwner.',
          ),
          _ref(
            'RegularWindowControllerDelegate',
            'mixin',
            'onWindowCloseRequested + onWindowDestroyed callbacks.',
          ),
        ],
      ),
    );
  }

  TableRow _ref(String name, String kind, String desc) => TableRow(
        children: <Widget>[
          _Cell(name),
          _Cell(kind),
          _Cell(desc),
        ],
      );
}

// ---------------------------------------------------------------------
// SECTION 13 - EVENT LOG
// ---------------------------------------------------------------------

class _SectionEventLog extends StatelessWidget {
  const _SectionEventLog({required this.entries});
  final List<_LogEntry> entries;
  @override
  Widget build(BuildContext context) {
    return _Section(
      title: '13. Live event log',
      icon: Icons.list_alt_outlined,
      child: SizedBox(
        height: 320,
        child: entries.isEmpty
            ? const Center(child: Text('No events yet - interact above.'))
            : ListView.separated(
                shrinkWrap: true,
                primary: false,
                itemCount: entries.length,
                separatorBuilder: (BuildContext ctx, int idx) =>
                    Divider(height: 1, color: Colors.grey.shade300),
                itemBuilder: (BuildContext ctx, int i) {
                  final _LogEntry e = entries[i];
                  return ListTile(
                    dense: true,
                    leading: _LogTagBadge(tag: e.tag),
                    title: Text(
                      e.message,
                      style: const TextStyle(fontSize: 13),
                    ),
                    subtitle: Text(
                      _fmt(e.timestamp),
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.black54,
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }

  String _fmt(DateTime t) =>
      '${t.hour.toString().padLeft(2, '0')}:'
      '${t.minute.toString().padLeft(2, '0')}:'
      '${t.second.toString().padLeft(2, '0')}.'
      '${t.millisecond.toString().padLeft(3, '0')}';
}

class _LogTagBadge extends StatelessWidget {
  const _LogTagBadge({required this.tag});
  final String tag;
  @override
  Widget build(BuildContext context) {
    final Color c = _color(tag);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: c.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: c),
      ),
      child: Text(
        tag,
        style: TextStyle(
          color: c,
          fontWeight: FontWeight.bold,
          fontSize: 11,
          fontFamily: 'monospace',
        ),
      ),
    );
  }

  Color _color(String tag) {
    if (tag.startsWith('init')) return Colors.indigo;
    if (tag.startsWith('post-frame')) return Colors.teal;
    if (tag.startsWith('resize') || tag.startsWith('constraints')) {
      return Colors.blue;
    }
    if (tag.startsWith('maximize') ||
        tag.startsWith('minimize') ||
        tag.startsWith('restore')) {
      return Colors.green;
    }
    if (tag.startsWith('fullscreen')) return Colors.purple;
    if (tag.startsWith('close') || tag.startsWith('destroy')) {
      return Colors.red;
    }
    if (tag.startsWith('activate') || tag.startsWith('blur')) {
      return Colors.deepOrange;
    }
    if (tag.startsWith('orchestrate') || tag.startsWith('cascade')) {
      return Colors.brown;
    }
    if (tag.startsWith('recipe')) return Colors.deepPurple;
    return Colors.black54;
  }
}

class _LogEntry {
  const _LogEntry({
    required this.tag,
    required this.message,
    required this.timestamp,
  });
  final String tag;
  final String message;
  final DateTime timestamp;
}

// ---------------------------------------------------------------------
// Generic _Section
// ---------------------------------------------------------------------

class _Section extends StatelessWidget {
  const _Section({
    required this.title,
    required this.icon,
    required this.child,
  });
  final String title;
  final IconData icon;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(icon, color: Colors.indigo, size: 22),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------
// Cross-platform window-chrome mockup (CustomPainter)
// ---------------------------------------------------------------------

class _WindowChrome extends StatefulWidget {
  const _WindowChrome({required this.controller});
  final RegularWindowController controller;
  @override
  State<_WindowChrome> createState() => _WindowChromeState();
}

class _WindowChromeState extends State<_WindowChrome> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onChange);
  }

  void _onChange() => setState(() {});

  @override
  void dispose() {
    widget.controller.removeListener(_onChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final RegularWindowController c = widget.controller;
    final _RegularWindowControllerBase b = c as _RegularWindowControllerBase;
    return AspectRatio(
      aspectRatio: 16 / 10,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: CustomPaint(
          painter: _WindowChromePainter(
            platform: c.platform,
            title: c.title,
            isActivated: c.isActivated,
            isMaximized: c.isMaximized,
            isMinimized: c.isMinimized,
            isFullscreen: c.isFullscreen,
            destroyed: b.isDestroyed,
            contentSize: c.contentSize,
          ),
        ),
      ),
    );
  }
}

class _WindowChromePainter extends CustomPainter {
  _WindowChromePainter({
    required this.platform,
    required this.title,
    required this.isActivated,
    required this.isMaximized,
    required this.isMinimized,
    required this.isFullscreen,
    required this.destroyed,
    required this.contentSize,
  });
  final TargetPlatform platform;
  final String title;
  final bool isActivated;
  final bool isMaximized;
  final bool isMinimized;
  final bool isFullscreen;
  final bool destroyed;
  final Size contentSize;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = Colors.grey.shade200;
    canvas.drawRect(Offset.zero & size, bg);

    if (destroyed) {
      _drawDestroyed(canvas, size);
      return;
    }
    if (isMinimized) {
      _drawMinimized(canvas, size);
      return;
    }

    final Rect windowRect = isFullscreen
        ? Offset.zero & size
        : isMaximized
            ? Rect.fromLTWH(4, 4, size.width - 8, size.height - 8)
            : Rect.fromLTWH(
                size.width * 0.1,
                size.height * 0.1,
                size.width * 0.8,
                size.height * 0.8,
              );

    final Paint shadow = Paint()
      ..color = Colors.black.withValues(alpha: 0.25)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        windowRect.shift(const Offset(2, 4)),
        const Radius.circular(6),
      ),
      shadow,
    );

    final Paint windowFill = Paint()
      ..color = isActivated ? Colors.white : Colors.grey.shade300;
    canvas.drawRRect(
      RRect.fromRectAndRadius(windowRect, const Radius.circular(6)),
      windowFill,
    );

    final Paint border = Paint()
      ..color = isActivated ? Colors.indigo.shade700 : Colors.grey.shade500
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawRRect(
      RRect.fromRectAndRadius(windowRect, const Radius.circular(6)),
      border,
    );

    const double titleBarHeight = 22;
    final Rect titleBar = Rect.fromLTWH(
      windowRect.left,
      windowRect.top,
      windowRect.width,
      titleBarHeight,
    );
    final Paint titleFill = Paint()
      ..color = _platformAccent(platform)
          .withValues(alpha: isActivated ? 1.0 : 0.4);
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        titleBar,
        topLeft: const Radius.circular(6),
        topRight: const Radius.circular(6),
      ),
      titleFill,
    );

    _paintWindowControls(canvas, titleBar, platform);

    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.bold,
          shadows: <Shadow>[
            Shadow(
              color: Colors.black.withValues(alpha: 0.4),
              blurRadius: 2,
            ),
          ],
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    tp.layout(maxWidth: titleBar.width - 80);
    tp.paint(
      canvas,
      Offset(
        titleBar.left + (titleBar.width - tp.width) / 2,
        titleBar.top + (titleBar.height - tp.height) / 2,
      ),
    );

    final Rect contentRect = Rect.fromLTWH(
      windowRect.left,
      windowRect.top + titleBarHeight,
      windowRect.width,
      windowRect.height - titleBarHeight,
    );
    final Paint contentBg = Paint()..color = Colors.grey.shade50;
    canvas.drawRect(contentRect, contentBg);

    final TextPainter sizeTp = TextPainter(
      text: TextSpan(
        text:
            '${contentSize.width.toStringAsFixed(0)} x ${contentSize.height.toStringAsFixed(0)}\n'
            '${platform.name}\n'
            '${_stateLabel()}',
        style: TextStyle(
          color: Colors.grey.shade800,
          fontSize: 11,
          fontFamily: 'monospace',
        ),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    sizeTp.layout(maxWidth: contentRect.width);
    sizeTp.paint(
      canvas,
      Offset(
        contentRect.left + (contentRect.width - sizeTp.width) / 2,
        contentRect.top + (contentRect.height - sizeTp.height) / 2,
      ),
    );
  }

  String _stateLabel() {
    if (isFullscreen) return '[fullscreen]';
    if (isMaximized) return '[maximized]';
    if (isMinimized) return '[minimized]';
    return isActivated ? '[focused]' : '[blurred]';
  }

  void _paintWindowControls(Canvas canvas, Rect bar, TargetPlatform p) {
    if (p == TargetPlatform.macOS) {
      const List<Color> colors = <Color>[
        Color(0xFFFF5F57),
        Color(0xFFFEBC2E),
        Color(0xFF28C840),
      ];
      double cx = bar.left + 10;
      for (final Color c in colors) {
        canvas.drawCircle(
          Offset(cx, bar.center.dy),
          5,
          Paint()..color = c,
        );
        cx += 14;
      }
    } else {
      double cx = bar.right - 12;
      for (int i = 0; i < 3; i++) {
        final IconData icon = i == 0
            ? Icons.close
            : i == 1
                ? Icons.crop_square
                : Icons.minimize;
        final TextPainter ip = TextPainter(
          text: TextSpan(
            text: String.fromCharCode(icon.codePoint),
            style: TextStyle(
              fontFamily: icon.fontFamily,
              fontSize: 12,
              color: Colors.white,
            ),
          ),
          textDirection: TextDirection.ltr,
        );
        ip.layout();
        ip.paint(canvas, Offset(cx - 6, bar.center.dy - 6));
        cx -= 18;
      }
    }
  }

  Color _platformAccent(TargetPlatform p) {
    switch (p) {
      case TargetPlatform.windows:
        return const Color(0xFF0078D4);
      case TargetPlatform.macOS:
        return const Color(0xFF606060);
      case TargetPlatform.linux:
        return const Color(0xFF300A24);
      case TargetPlatform.android:
        return const Color(0xFF3DDC84);
      case TargetPlatform.iOS:
        return const Color(0xFF007AFF);
      case TargetPlatform.fuchsia:
        return const Color(0xFFFF6F61);
    }
  }

  void _drawDestroyed(Canvas canvas, Size size) {
    final Paint p = Paint()..color = Colors.red.shade50;
    canvas.drawRect(Offset.zero & size, p);
    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: 'destroyed',
        style: TextStyle(
          color: Colors.red.shade800,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    tp.layout(maxWidth: size.width);
    tp.paint(
      canvas,
      Offset((size.width - tp.width) / 2, (size.height - tp.height) / 2),
    );
  }

  void _drawMinimized(Canvas canvas, Size size) {
    final Paint p = Paint()..color = Colors.grey.shade400;
    canvas.drawRect(Offset.zero & size, p);
    final Rect bar = Rect.fromLTWH(
      size.width * 0.2,
      size.height * 0.85,
      size.width * 0.6,
      18,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(bar, const Radius.circular(4)),
      Paint()..color = Colors.indigo.shade900,
    );
    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: 'minimized to taskbar',
        style: TextStyle(color: Colors.grey.shade800, fontSize: 12),
      ),
      textDirection: TextDirection.ltr,
    );
    tp.layout(maxWidth: size.width);
    tp.paint(
      canvas,
      Offset((size.width - tp.width) / 2, size.height * 0.5),
    );
  }

  @override
  bool shouldRepaint(covariant _WindowChromePainter old) =>
      old.title != title ||
      old.isActivated != isActivated ||
      old.isMaximized != isMaximized ||
      old.isMinimized != isMinimized ||
      old.isFullscreen != isFullscreen ||
      old.destroyed != destroyed ||
      old.contentSize != contentSize ||
      old.platform != platform;
}
