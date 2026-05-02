// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/material.dart';

// ===========================================================================
// DEEP DEMO: RegularWindowControllerMacOS
// ---------------------------------------------------------------------------
// `RegularWindowControllerMacOS` is the macOS-specific implementation of the
// abstract `RegularWindowController` used by Flutter's experimental multi-
// window API. It lives in the SDK at:
//
//   package:flutter/src/widgets/_window_macos.dart
//
// The leading underscore on `_window_macos.dart` makes the file LIBRARY-
// PRIVATE within the `flutter` package. The barrel files
// (`package:flutter/widgets.dart`, `package:flutter/material.dart`) do NOT
// re-export anything from `_window_macos.dart` or `_window.dart`. The
// constructor is also marked `@internal`, and the runtime guard
// `isWindowingEnabled` causes it to throw `UnsupportedError` unless the
// experimental windowing feature flag is enabled at engine build time.
//
// As a consequence, this class CANNOT be imported, instantiated, or even
// named from a normal user-space Dart file (or this D4rt sandbox file). To
// keep the demo informative across all platforms — including the linux host
// running this AST harness — we faithfully MIRROR the public API surface
// (`setSize`, `setMaximized`, `setMinimized`, `setFullscreen`, `activate`,
// `setTitle`, `destroy`, `isActivated`, `isMaximized`, `isMinimized`,
// `isFullscreen`, `contentSize`, `title`, plus the
// `RegularWindowControllerDelegate` callbacks `onWindowCloseRequested` and
// `onWindowDestroyed`) using a local `_FakeRegularWindowControllerMacOS`
// `ChangeNotifier`. The fake exposes the same method names and getters in
// the same shapes — the call sites read like real code, only the import is
// substituted for a local class.
//
// The demo is platform-aware: on macOS the narrative explains how to wire
// the real controller through `WindowingOwnerMacOS.createRegularWindowController(...)`
// (the only public-ish entry point) and renders an "ENABLE-EXPERIMENTAL-FLAGS"
// instruction; everywhere else it renders an information banner naming the
// running platform. Visual chrome — traffic lights, title bar, resize handle,
// fullscreen icon — is rendered by `CustomPainter`s on every platform.
// ===========================================================================

// ---------------------------------------------------------------------------
// Section 0 — Top-level state holders.
//
// All STATELESS widgets in this file read from these `ValueNotifier` and
// `ChangeNotifier` instances. The harness expects a top-level `build`
// function (no widget classes).
// ---------------------------------------------------------------------------

/// Theme toggle (light vs dark macOS chrome).
final ValueNotifier<bool> _darkMode = ValueNotifier<bool>(false);

/// Global "active" focus indicator for the primary scenario controller.
/// Mirrors `_primaryController.isActivated` for widgets that want to
/// observe focus without subscribing directly to the controller.
final ValueNotifier<bool> _primaryFocus = ValueNotifier<bool>(true);

/// Currently selected scenario index in the recipe gallery row.
final ValueNotifier<int> _selectedRecipe = ValueNotifier<int>(0);

/// Toggle for showing the "raw constructor call" code panel under each
/// scenario card.
final ValueNotifier<bool> _showCodeSnippets = ValueNotifier<bool>(true);

// ---------------------------------------------------------------------------
// Section 1 — macOS chrome design tokens.
// ---------------------------------------------------------------------------

const Color _macosRed = Color(0xFFFF5F57);
const Color _macosYellow = Color(0xFFFEBC2E);
const Color _macosGreen = Color(0xFF28C840);
const Color _macosTrafficInactive = Color(0xFFCDCDCD);
const Color _macosTitlebarLight = Color(0xFFECECEC);
const Color _macosTitlebarDark = Color(0xFF3A3A3A);
const Color _macosWindowBodyLight = Color(0xFFFFFFFF);
const Color _macosWindowBodyDark = Color(0xFF1F1F1F);
const Color _macosBorderLight = Color(0xFFC8C8C8);
const Color _macosBorderDark = Color(0xFF101010);
const Color _macosTextLight = Color(0xFF1F1F1F);
const Color _macosTextDark = Color(0xFFEEEEEE);

const double _kTrafficDotRadius = 6.0;
const double _kTitlebarHeight = 28.0;
const double _kCornerRadius = 8.0;

// ---------------------------------------------------------------------------
// Section 2 — Faithful API mirror.
//
// `_FakeRegularWindowControllerDelegate` mirrors the SDK's
// `RegularWindowControllerDelegate` mixin — same method names, same default
// no-op behavior, same parameter shapes.
// ---------------------------------------------------------------------------

mixin class _FakeRegularWindowControllerDelegate {
  void onWindowCloseRequested(_FakeRegularWindowControllerMacOS controller) {
    // Default behavior in the SDK: destroy the window unless overridden.
    controller.destroy();
  }

  void onWindowDestroyed() {
    // Default no-op (matches `RegularWindowControllerDelegate.onWindowDestroyed`).
  }
}

/// A faithful local mirror of `RegularWindowControllerMacOS` from
/// `package:flutter/src/widgets/_window_macos.dart`. Method names,
/// parameter shapes, and getter names match the SDK exactly. The only
/// difference is that this class does not call FFI — it updates local
/// state and notifies listeners.
class _FakeRegularWindowControllerMacOS extends ChangeNotifier {
  _FakeRegularWindowControllerMacOS({
    required _FakeWindowingOwnerMacOS owner,
    required _FakeRegularWindowControllerDelegate delegate,
    required Size? preferredSize,
    BoxConstraints? preferredConstraints,
    String? title,
  })  : _owner = owner,
        _delegate = delegate,
        _contentSize = preferredSize ?? const Size(640, 480),
        _constraints = preferredConstraints ?? const BoxConstraints(),
        _title = title ?? '' {
    _owner._activeControllers.add(this);
  }

  final _FakeWindowingOwnerMacOS _owner;
  final _FakeRegularWindowControllerDelegate _delegate;

  Size _contentSize;
  BoxConstraints _constraints;
  String _title;
  bool _maximized = false;
  bool _minimized = false;
  bool _fullscreen = false;
  bool _activated = true;
  bool _destroyed = false;

  // ---- API surface mirroring the SDK -------------------------------------

  Size get contentSize {
    _ensureNotDestroyed();
    return _contentSize;
  }

  String get title {
    _ensureNotDestroyed();
    return _title;
  }

  bool get isMaximized {
    _ensureNotDestroyed();
    return _maximized;
  }

  bool get isMinimized {
    _ensureNotDestroyed();
    return _minimized;
  }

  bool get isFullscreen {
    _ensureNotDestroyed();
    return _fullscreen;
  }

  bool get isActivated {
    _ensureNotDestroyed();
    return _activated;
  }

  bool get isDestroyed => _destroyed;

  BoxConstraints get constraints => _constraints;

  void setSize(Size size) {
    _ensureNotDestroyed();
    _contentSize = size;
    notifyListeners();
  }

  void setConstraints(BoxConstraints constraints) {
    _ensureNotDestroyed();
    _constraints = constraints;
    notifyListeners();
  }

  void setTitle(String title) {
    _ensureNotDestroyed();
    _title = title;
    notifyListeners();
  }

  void setMaximized(bool maximized) {
    _ensureNotDestroyed();
    if (_maximized == maximized) {
      return;
    }
    _maximized = maximized;
    if (maximized) {
      _minimized = false;
    }
    notifyListeners();
  }

  void setMinimized(bool minimized) {
    _ensureNotDestroyed();
    if (_minimized == minimized) {
      return;
    }
    _minimized = minimized;
    notifyListeners();
  }

  void setFullscreen(bool fullscreen) {
    _ensureNotDestroyed();
    if (_fullscreen == fullscreen) {
      return;
    }
    _fullscreen = fullscreen;
    notifyListeners();
  }

  void activate() {
    _ensureNotDestroyed();
    for (final _FakeRegularWindowControllerMacOS other in _owner._activeControllers) {
      if (other != this && other._activated) {
        other._activated = false;
        other.notifyListeners();
      }
    }
    _activated = true;
    notifyListeners();
  }

  void requestClose() {
    _ensureNotDestroyed();
    _delegate.onWindowCloseRequested(this);
  }

  void destroy() {
    if (_destroyed) {
      return;
    }
    _destroyed = true;
    _owner._activeControllers.remove(this);
    _delegate.onWindowDestroyed();
    notifyListeners();
  }

  void _ensureNotDestroyed() {
    if (_destroyed) {
      throw StateError('Window has been destroyed.');
    }
  }
}

/// Local mirror of `WindowingOwnerMacOS`. Holds the list of active
/// controllers like the SDK does.
class _FakeWindowingOwnerMacOS {
  final List<_FakeRegularWindowControllerMacOS> _activeControllers =
      <_FakeRegularWindowControllerMacOS>[];

  List<_FakeRegularWindowControllerMacOS> get controllers =>
      List<_FakeRegularWindowControllerMacOS>.unmodifiable(_activeControllers);

  _FakeRegularWindowControllerMacOS createRegularWindowController({
    required _FakeRegularWindowControllerDelegate delegate,
    Size? preferredSize,
    BoxConstraints? preferredConstraints,
    String? title,
  }) {
    return _FakeRegularWindowControllerMacOS(
      owner: this,
      delegate: delegate,
      preferredSize: preferredSize,
      preferredConstraints: preferredConstraints,
      title: title,
    );
  }
}

// ---------------------------------------------------------------------------
// Section 3 — Shared owner + delegate instances used by the live demo.
//
// On macOS we'd construct the REAL owner via:
//   final WindowingOwnerMacOS owner = WindowingOwnerMacOS();
// but `WindowingOwnerMacOS` is also `@internal`, so we cannot name it.
// ---------------------------------------------------------------------------

final _FakeWindowingOwnerMacOS _liveOwner = _FakeWindowingOwnerMacOS();

class _LoggingDelegate with _FakeRegularWindowControllerDelegate {
  _LoggingDelegate(this.label);
  final String label;
  final ValueNotifier<List<String>> log = ValueNotifier<List<String>>(<String>[]);

  void _push(String entry) {
    log.value = <String>[...log.value, '[$label] $entry'];
  }

  @override
  void onWindowCloseRequested(_FakeRegularWindowControllerMacOS controller) {
    _push('onWindowCloseRequested → destroy()');
    controller.destroy();
  }

  @override
  void onWindowDestroyed() {
    _push('onWindowDestroyed');
  }
}

// Primary live controller used in scenarios 4–10.
final _LoggingDelegate _primaryDelegate = _LoggingDelegate('primary');

final _FakeRegularWindowControllerMacOS _primaryController = (() {
  final _FakeRegularWindowControllerMacOS c =
      _liveOwner.createRegularWindowController(
    delegate: _primaryDelegate,
    preferredSize: const Size(820, 540),
    preferredConstraints: const BoxConstraints(
      minWidth: 320,
      minHeight: 240,
      maxWidth: 2048,
      maxHeight: 1536,
    ),
    title: 'Primary Window',
  );
  c.addListener(() {
    if (!c.isDestroyed) {
      _primaryFocus.value = c.isActivated;
    } else {
      _primaryFocus.value = false;
    }
  });
  return c;
})();

// A secondary controller for the multi-window orchestration scenario.
final _LoggingDelegate _secondaryDelegate = _LoggingDelegate('secondary');
final _FakeRegularWindowControllerMacOS _secondaryController =
    _liveOwner.createRegularWindowController(
  delegate: _secondaryDelegate,
  preferredSize: const Size(420, 320),
  title: 'Secondary Window',
);

// A tertiary controller for the multi-window orchestration scenario.
final _LoggingDelegate _tertiaryDelegate = _LoggingDelegate('tertiary');
final _FakeRegularWindowControllerMacOS _tertiaryController =
    _liveOwner.createRegularWindowController(
  delegate: _tertiaryDelegate,
  preferredSize: const Size(380, 280),
  title: 'Tertiary Window',
);

// ---------------------------------------------------------------------------
// Section 4 — Painters: traffic lights, title bar, body chrome, fullscreen
// indicator, resize handle, multi-window grid background.
// ---------------------------------------------------------------------------

class _TrafficLightsPainter extends CustomPainter {
  _TrafficLightsPainter({
    required this.activated,
    required this.canClose,
    required this.canMinimize,
    required this.canZoom,
  });

  final bool activated;
  final bool canClose;
  final bool canMinimize;
  final bool canZoom;

  @override
  void paint(Canvas canvas, Size size) {
    final double cy = size.height / 2;
    final List<_TrafficDot> dots = <_TrafficDot>[
      _TrafficDot(_macosRed, canClose, 'close'),
      _TrafficDot(_macosYellow, canMinimize, 'min'),
      _TrafficDot(_macosGreen, canZoom, 'zoom'),
    ];
    double cx = _kTrafficDotRadius + 6;
    for (final _TrafficDot dot in dots) {
      final Color color = !activated
          ? _macosTrafficInactive
          : (dot.enabled ? dot.color : _macosTrafficInactive);
      final Paint paint = Paint()..color = color;
      canvas.drawCircle(Offset(cx, cy), _kTrafficDotRadius, paint);
      // Subtle ring for depth.
      final Paint ring = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.6
        ..color = Colors.black.withValues(alpha: 0.18);
      canvas.drawCircle(Offset(cx, cy), _kTrafficDotRadius, ring);
      cx += _kTrafficDotRadius * 2 + 6;
    }
  }

  @override
  bool shouldRepaint(covariant _TrafficLightsPainter old) {
    return old.activated != activated ||
        old.canClose != canClose ||
        old.canMinimize != canMinimize ||
        old.canZoom != canZoom;
  }
}

class _TrafficDot {
  const _TrafficDot(this.color, this.enabled, this.tag);
  final Color color;
  final bool enabled;
  final String tag;
}

class _WindowChromePainter extends CustomPainter {
  _WindowChromePainter({
    required this.dark,
    required this.activated,
    required this.fullscreen,
    required this.minimized,
    required this.maximized,
    required this.title,
  });

  final bool dark;
  final bool activated;
  final bool fullscreen;
  final bool minimized;
  final bool maximized;
  final String title;

  @override
  void paint(Canvas canvas, Size size) {
    final RRect rrect = RRect.fromRectAndRadius(
      Offset.zero & size,
      Radius.circular(fullscreen ? 0 : _kCornerRadius),
    );
    final Paint bodyPaint = Paint()
      ..color = dark ? _macosWindowBodyDark : _macosWindowBodyLight;
    canvas.drawRRect(rrect, bodyPaint);

    // Title bar gradient.
    final Rect titleBar = Rect.fromLTWH(0, 0, size.width, _kTitlebarHeight);
    final Paint titlePaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[
          dark ? _macosTitlebarDark : _macosTitlebarLight,
          dark
              ? _macosTitlebarDark.withValues(alpha: 0.95)
              : _macosTitlebarLight.withValues(alpha: 0.92),
        ],
      ).createShader(titleBar);
    if (fullscreen) {
      canvas.drawRect(titleBar, titlePaint);
    } else {
      final Path tbPath = Path()
        ..addRRect(RRect.fromLTRBAndCorners(
          0,
          0,
          size.width,
          _kTitlebarHeight,
          topLeft: const Radius.circular(_kCornerRadius),
          topRight: const Radius.circular(_kCornerRadius),
        ));
      canvas.drawPath(tbPath, titlePaint);
    }

    // Border.
    final Paint border = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8
      ..color = dark ? _macosBorderDark : _macosBorderLight;
    canvas.drawRRect(rrect, border);

    // Title text in titlebar.
    final TextSpan span = TextSpan(
      text: title,
      style: TextStyle(
        color: !activated
            ? (dark ? Colors.white38 : Colors.black38)
            : (dark ? _macosTextDark : _macosTextLight),
        fontSize: 12,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
      ),
    );
    final TextPainter tp = TextPainter(
      text: span,
      textDirection: TextDirection.ltr,
      maxLines: 1,
      ellipsis: '…',
    )..layout(maxWidth: size.width - 120);
    tp.paint(
      canvas,
      Offset((size.width - tp.width) / 2, (_kTitlebarHeight - tp.height) / 2),
    );

    // Body content placeholder dashes.
    if (!minimized) {
      final Paint dash = Paint()
        ..color = dark ? Colors.white12 : Colors.black12
        ..strokeWidth = 1.5
        ..strokeCap = StrokeCap.round;
      double y = _kTitlebarHeight + 16;
      while (y < size.height - 12) {
        canvas.drawLine(Offset(18, y), Offset(size.width - 18, y), dash);
        y += 12;
      }
    } else {
      final TextSpan ms = TextSpan(
        text: 'minimized',
        style: TextStyle(
          color: dark ? Colors.white38 : Colors.black38,
          fontSize: 10,
          fontStyle: FontStyle.italic,
        ),
      );
      final TextPainter mtp = TextPainter(
        text: ms,
        textDirection: TextDirection.ltr,
      )..layout();
      mtp.paint(
        canvas,
        Offset(
          (size.width - mtp.width) / 2,
          _kTitlebarHeight + (size.height - _kTitlebarHeight - mtp.height) / 2,
        ),
      );
    }

    // Bottom-right resize handle hint.
    if (!fullscreen && !maximized && !minimized) {
      final Paint handle = Paint()
        ..color = dark ? Colors.white24 : Colors.black26
        ..strokeWidth = 1.0;
      const double handleInset = 6.0;
      final double startX = size.width - handleInset;
      final double startY = size.height - handleInset;
      for (int i = 0; i < 3; i++) {
        canvas.drawLine(
          Offset(startX - i * 4, startY),
          Offset(startX, startY - i * 4),
          handle,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant _WindowChromePainter old) {
    return old.dark != dark ||
        old.activated != activated ||
        old.fullscreen != fullscreen ||
        old.minimized != minimized ||
        old.maximized != maximized ||
        old.title != title;
  }
}

class _MultiWindowGridPainter extends CustomPainter {
  _MultiWindowGridPainter({required this.dark});
  final bool dark;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()
      ..color = dark ? const Color(0xFF111419) : const Color(0xFFEBEDF0);
    canvas.drawRect(Offset.zero & size, bg);
    final Paint line = Paint()
      ..color = dark ? Colors.white10 : Colors.black12
      ..strokeWidth = 0.7;
    const double step = 24;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), line);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), line);
    }
  }

  @override
  bool shouldRepaint(covariant _MultiWindowGridPainter old) =>
      old.dark != dark;
}

// ---------------------------------------------------------------------------
// Section 5 — Reusable presentation widgets.
// ---------------------------------------------------------------------------

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.title, required this.subtitle, required this.child});
  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(title, style: theme.textTheme.titleLarge),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: theme.textTheme.bodyMedium
                  ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
            ),
            const SizedBox(height: 14),
            child,
          ],
        ),
      ),
    );
  }
}

class _CodeSnippet extends StatelessWidget {
  const _CodeSnippet({required this.code});
  final String code;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _showCodeSnippets,
      builder: (BuildContext ctx, bool show, _) {
        if (!show) {
          return const SizedBox.shrink();
        }
        return Container(
          margin: const EdgeInsets.only(top: 10),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: Theme.of(ctx).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Theme.of(ctx).colorScheme.outlineVariant,
              width: 0.5,
            ),
          ),
          width: double.infinity,
          child: SelectableText(
            code,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.5,
              height: 1.4,
            ),
          ),
        );
      },
    );
  }
}

class _ChromePreview extends StatelessWidget {
  const _ChromePreview({
    required this.controller,
    required this.dark,
    this.width = 460,
    this.height = 240,
  });

  final _FakeRegularWindowControllerMacOS controller;
  final bool dark;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext ctx, _) {
        if (controller.isDestroyed) {
          return Container(
            width: width,
            height: height,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: dark ? Colors.black54 : Colors.black12,
              borderRadius: BorderRadius.circular(_kCornerRadius),
              border: Border.all(color: Colors.red.shade300),
            ),
            child: Text(
              'destroyed',
              style: TextStyle(
                color: dark ? Colors.white70 : Colors.black54,
                fontStyle: FontStyle.italic,
              ),
            ),
          );
        }
        final double effectiveW = controller.isFullscreen ? width : width;
        final double effectiveH = controller.isMinimized
            ? _kTitlebarHeight + 18
            : (controller.isFullscreen ? height + 30 : height);
        return SizedBox(
          width: effectiveW,
          height: effectiveH,
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: CustomPaint(
                  painter: _WindowChromePainter(
                    dark: dark,
                    activated: controller.isActivated,
                    fullscreen: controller.isFullscreen,
                    minimized: controller.isMinimized,
                    maximized: controller.isMaximized,
                    title: controller.isDestroyed ? '(destroyed)' : controller.title,
                  ),
                ),
              ),
              Positioned(
                left: 0,
                top: 0,
                width: 80,
                height: _kTitlebarHeight,
                child: CustomPaint(
                  painter: _TrafficLightsPainter(
                    activated: controller.isActivated,
                    canClose: !controller.isFullscreen,
                    canMinimize: !controller.isFullscreen,
                    canZoom: true,
                  ),
                ),
              ),
              if (controller.isMaximized && !controller.isFullscreen)
                Positioned(
                  right: 8,
                  top: 4,
                  child: Icon(Icons.crop_din,
                      size: 16, color: dark ? Colors.white70 : Colors.black54),
                ),
              if (controller.isFullscreen)
                Positioned(
                  right: 8,
                  top: 6,
                  child: Icon(Icons.fullscreen,
                      size: 18, color: dark ? Colors.white70 : Colors.black54),
                ),
            ],
          ),
        );
      },
    );
  }
}

class _StateBadges extends StatelessWidget {
  const _StateBadges({required this.controller});
  final _FakeRegularWindowControllerMacOS controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext ctx, _) {
        return Wrap(
          spacing: 8,
          runSpacing: 8,
          children: <Widget>[
            _badge('isActivated',
                controller.isDestroyed ? false : controller.isActivated),
            _badge('isMaximized',
                controller.isDestroyed ? false : controller.isMaximized),
            _badge('isMinimized',
                controller.isDestroyed ? false : controller.isMinimized),
            _badge('isFullscreen',
                controller.isDestroyed ? false : controller.isFullscreen),
            _badge('isDestroyed', controller.isDestroyed,
                colorOn: Colors.red, colorOff: Colors.green),
          ],
        );
      },
    );
  }

  Widget _badge(String label, bool on,
      {Color colorOn = Colors.green, Color colorOff = Colors.grey}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: on ? colorOn.withValues(alpha: 0.15) : colorOff.withValues(alpha: 0.10),
        border: Border.all(
          color: on ? colorOn : colorOff,
          width: 0.8,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            on ? Icons.check_circle : Icons.radio_button_unchecked,
            size: 14,
            color: on ? colorOn : colorOff,
          ),
          const SizedBox(width: 6),
          Text(
            '$label = $on',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: on ? colorOn : colorOff,
            ),
          ),
        ],
      ),
    );
  }
}

class _DelegateLogPanel extends StatelessWidget {
  const _DelegateLogPanel({required this.delegate});
  final _LoggingDelegate delegate;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<String>>(
      valueListenable: delegate.log,
      builder: (BuildContext ctx, List<String> entries, _) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Theme.of(ctx).colorScheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: Theme.of(ctx).colorScheme.outlineVariant,
              width: 0.5,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: <Widget>[
                  const Icon(Icons.list_alt, size: 16),
                  const SizedBox(width: 6),
                  Text('Delegate log (${entries.length})',
                      style: const TextStyle(fontWeight: FontWeight.w600)),
                  const Spacer(),
                  TextButton.icon(
                    onPressed: () {
                      delegate.log.value = <String>[];
                    },
                    icon: const Icon(Icons.delete_outline, size: 16),
                    label: const Text('clear'),
                  ),
                ],
              ),
              if (entries.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(6),
                  child: Text('no events yet',
                      style: TextStyle(
                          color: Theme.of(ctx).colorScheme.onSurfaceVariant,
                          fontStyle: FontStyle.italic)),
                )
              else
                ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 130),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: entries.length,
                    itemBuilder: (BuildContext c, int i) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Text(
                          '${i + 1}. ${entries[i]}',
                          style: const TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 12,
                          ),
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// Section 6 — Sliders state for the resize scenario.
// ---------------------------------------------------------------------------

final ValueNotifier<double> _resizeWidth = ValueNotifier<double>(820);
final ValueNotifier<double> _resizeHeight = ValueNotifier<double>(540);
final ValueNotifier<String> _titleEditValue =
    ValueNotifier<String>('Primary Window');

// ---------------------------------------------------------------------------
// Section 7 — Scenario builders.
// ---------------------------------------------------------------------------

Widget _buildPlatformBanner(BuildContext context) {
  final TargetPlatform platform = Theme.of(context).platform;
  final bool isMac = platform == TargetPlatform.macOS;
  return Container(
    margin: const EdgeInsets.fromLTRB(16, 12, 16, 4),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    decoration: BoxDecoration(
      color: isMac
          ? Colors.green.withValues(alpha: 0.10)
          : Colors.amber.withValues(alpha: 0.12),
      border: Border.all(
        color: isMac ? Colors.green : Colors.orange,
        width: 0.8,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      children: <Widget>[
        Icon(
          isMac ? Icons.check_circle : Icons.info_outline,
          color: isMac ? Colors.green.shade700 : Colors.orange.shade800,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                isMac
                    ? 'Running on macOS — RegularWindowControllerMacOS demo'
                    : 'This window controller only works on macOS — running on $platform',
                style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
              ),
              const SizedBox(height: 4),
              Text(
                isMac
                    ? 'On a real macOS Flutter build with the experimental windowing flag enabled, '
                        '`WindowingOwnerMacOS().createRegularWindowController(...)` would mint a real '
                        'controller. Because the type is `@internal` and lives in a private file, this '
                        'demo uses a faithful local mirror so the API surface, state machine, and '
                        'visual chrome can still be exercised.'
                    : 'The native FFI bindings only resolve on macOS. Below you still see live '
                        '`_FakeRegularWindowControllerMacOS` instances driving accurate state, plus '
                        'CustomPainter chrome that mirrors macOS traffic-lights, title bar, fullscreen, '
                        'and minimize/zoom semantics.',
                style: TextStyle(
                  fontSize: 12.5,
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.78),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildAnatomySection(BuildContext context) {
  return _SectionCard(
    title: '1 · Anatomy of RegularWindowControllerMacOS',
    subtitle:
        'Constructor signature, base class chain, delegate role, and the `@internal` boundary.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const Text(
          'The SDK defines the controller in package:flutter/src/widgets/_window_macos.dart:\n'
          '\n'
          '  class RegularWindowControllerMacOS extends RegularWindowController {\n'
          '    RegularWindowControllerMacOS({\n'
          '      required WindowingOwnerMacOS owner,\n'
          '      required RegularWindowControllerDelegate delegate,\n'
          '      required Size? preferredSize,\n'
          '      BoxConstraints? preferredConstraints,\n'
          '      String? title,\n'
          '    });\n'
          '  }\n'
          '\n'
          'Both the class file and the abstract `RegularWindowController` in '
          '`_window.dart` carry leading underscores at the file level, so they '
          'are NOT exported by `package:flutter/widgets.dart`. The constructor '
          'is also annotated `@internal` and runtime-guarded by '
          '`isWindowingEnabled`.',
          style: TextStyle(fontFamily: 'monospace', fontSize: 12.5, height: 1.45),
        ),
        const SizedBox(height: 14),
        _CodeSnippet(
          code:
              '// On a real macOS Flutter build (windowing flag enabled):\n'
              'final WindowingOwnerMacOS owner = WindowingOwnerMacOS();\n'
              'final RegularWindowController controller =\n'
              '    owner.createRegularWindowController(\n'
              '  delegate: const RegularWindowControllerDelegate(),\n'
              '  preferredSize: const Size(820, 540),\n'
              '  preferredConstraints: const BoxConstraints(\n'
              '    minWidth: 320, minHeight: 240,\n'
              '    maxWidth: 2048, maxHeight: 1536,\n'
              '  ),\n'
              '  title: \'Primary Window\',\n'
              ');',
        ),
      ],
    ),
  );
}

Widget _buildChromeAnatomy(BuildContext context) {
  return _SectionCard(
    title: '2 · macOS window chrome anatomy',
    subtitle:
        'Traffic lights (close · minimize · zoom), title bar, body, resize handle.',
    child: ValueListenableBuilder<bool>(
      valueListenable: _darkMode,
      builder: (BuildContext ctx, bool dark, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                _ChromePreview(controller: _primaryController, dark: dark),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const <Widget>[
                      _AnatomyBullet(
                        emoji: '●',
                        color: _macosRed,
                        title: 'Close (red)',
                        body: 'Triggers `delegate.onWindowCloseRequested(controller)`. '
                            'The default `RegularWindowControllerDelegate` calls '
                            '`controller.destroy()`. Override to confirm before close.',
                      ),
                      _AnatomyBullet(
                        emoji: '●',
                        color: _macosYellow,
                        title: 'Minimize (yellow)',
                        body: 'Calls `controller.setMinimized(true)`; restore via '
                            '`setMinimized(false)`. Reads back via `isMinimized`.',
                      ),
                      _AnatomyBullet(
                        emoji: '●',
                        color: _macosGreen,
                        title: 'Zoom (green)',
                        body: 'Toggles maximize/zoom via `setMaximized(true/false)`. '
                            'Holding option toggles fullscreen via `setFullscreen(true)`.',
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            const Text(
              'The titlebar height is fixed at 28dp on macOS Big Sur+. '
              'The body area is what `contentSize` reports — title bar height is '
              'NOT included. `setSize(Size)` writes the content size, not the '
              'frame size.',
              style: TextStyle(fontSize: 13),
            ),
          ],
        );
      },
    ),
  );
}

class _AnatomyBullet extends StatelessWidget {
  const _AnatomyBullet({
    required this.emoji,
    required this.color,
    required this.title,
    required this.body,
  });
  final String emoji;
  final Color color;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(emoji,
              style: TextStyle(color: color, fontSize: 22, height: 1.0)),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title,
                    style: const TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 2),
                Text(body,
                    style: const TextStyle(fontSize: 12.5, height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildBasicCreationSection(BuildContext context) {
  return _SectionCard(
    title: '3 · Basic window creation',
    subtitle:
        'A live `_FakeRegularWindowControllerMacOS` is constructed at file scope. '
        'Its state is rendered below.',
    child: ValueListenableBuilder<bool>(
      valueListenable: _darkMode,
      builder: (BuildContext ctx, bool dark, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _ChromePreview(controller: _primaryController, dark: dark),
            const SizedBox(height: 12),
            _StateBadges(controller: _primaryController),
            const SizedBox(height: 12),
            _DelegateLogPanel(delegate: _primaryDelegate),
            _CodeSnippet(
              code:
                  '// At file scope:\n'
                  'final WindowingOwnerMacOS owner = WindowingOwnerMacOS();\n'
                  'final RegularWindowController primary =\n'
                  '    owner.createRegularWindowController(\n'
                  '  delegate: _primaryDelegate,\n'
                  '  preferredSize: const Size(820, 540),\n'
                  '  preferredConstraints: const BoxConstraints(\n'
                  '    minWidth: 320, minHeight: 240,\n'
                  '    maxWidth: 2048, maxHeight: 1536,\n'
                  '  ),\n'
                  '  title: \'Primary Window\',\n'
                  ');',
            ),
          ],
        );
      },
    ),
  );
}

Widget _buildResizeSection(BuildContext context) {
  return _SectionCard(
    title: '4 · Resize · setSize / setConstraints',
    subtitle:
        'Drive `setSize(Size)` and `setConstraints(BoxConstraints)` from sliders. '
        'Reads back via `contentSize`.',
    child: ValueListenableBuilder<bool>(
      valueListenable: _darkMode,
      builder: (BuildContext ctx, bool dark, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ValueListenableBuilder<double>(
              valueListenable: _resizeWidth,
              builder: (BuildContext c, double w, _) {
                return ValueListenableBuilder<double>(
                  valueListenable: _resizeHeight,
                  builder: (BuildContext c2, double h, _) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            const SizedBox(width: 80, child: Text('width')),
                            Expanded(
                              child: Slider(
                                value: w,
                                min: 320,
                                max: 1280,
                                divisions: 96,
                                label: w.toStringAsFixed(0),
                                onChanged: (double v) {
                                  _resizeWidth.value = v;
                                  _primaryController.setSize(
                                      Size(v, _resizeHeight.value));
                                },
                              ),
                            ),
                            SizedBox(width: 60, child: Text(w.toStringAsFixed(0))),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            const SizedBox(width: 80, child: Text('height')),
                            Expanded(
                              child: Slider(
                                value: h,
                                min: 240,
                                max: 800,
                                divisions: 56,
                                label: h.toStringAsFixed(0),
                                onChanged: (double v) {
                                  _resizeHeight.value = v;
                                  _primaryController.setSize(
                                      Size(_resizeWidth.value, v));
                                },
                              ),
                            ),
                            SizedBox(width: 60, child: Text(h.toStringAsFixed(0))),
                          ],
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 12),
            AnimatedBuilder(
              animation: _primaryController,
              builder: (BuildContext c, _) {
                final Size cs = _primaryController.isDestroyed
                    ? Size.zero
                    : _primaryController.contentSize;
                return Text(
                  'controller.contentSize  ⇒  '
                  'Size(${cs.width.toStringAsFixed(0)}, ${cs.height.toStringAsFixed(0)})',
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 13,
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
            Center(
              child: AnimatedBuilder(
                animation: _primaryController,
                builder: (BuildContext c, _) {
                  if (_primaryController.isDestroyed) {
                    return _ChromePreview(
                      controller: _primaryController,
                      dark: dark,
                    );
                  }
                  return SizedBox(
                    width: (_primaryController.contentSize.width / 2)
                        .clamp(160, 640)
                        .toDouble(),
                    height: (_primaryController.contentSize.height / 2)
                        .clamp(120, 400)
                        .toDouble(),
                    child: _ChromePreview(
                      controller: _primaryController,
                      dark: dark,
                      width: (_primaryController.contentSize.width / 2)
                          .clamp(160, 640)
                          .toDouble(),
                      height: (_primaryController.contentSize.height / 2)
                          .clamp(120, 400)
                          .toDouble(),
                    ),
                  );
                },
              ),
            ),
            _CodeSnippet(
              code:
                  'controller.setSize(Size(width, height));\n'
                  'controller.setConstraints(\n'
                  '  const BoxConstraints(minWidth: 320, minHeight: 240,\n'
                  '                       maxWidth: 1600, maxHeight: 1000),\n'
                  ');\n'
                  '// Read-back:\n'
                  'final Size current = controller.contentSize;',
            ),
          ],
        );
      },
    ),
  );
}

Widget _buildMinimizeSection(BuildContext context) {
  return _SectionCard(
    title: '5 · Minimize · setMinimized / isMinimized',
    subtitle: 'Yellow traffic-light behavior. Mirrors NSWindow.miniaturize.',
    child: ValueListenableBuilder<bool>(
      valueListenable: _darkMode,
      builder: (BuildContext ctx, bool dark, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _ChromePreview(controller: _primaryController, dark: dark),
            const SizedBox(height: 12),
            AnimatedBuilder(
              animation: _primaryController,
              builder: (BuildContext c, _) {
                final bool min = _primaryController.isDestroyed
                    ? false
                    : _primaryController.isMinimized;
                return Wrap(
                  spacing: 10,
                  children: <Widget>[
                    FilledButton.icon(
                      onPressed: _primaryController.isDestroyed
                          ? null
                          : () => _primaryController.setMinimized(true),
                      icon: const Icon(Icons.minimize),
                      label: const Text('setMinimized(true)'),
                    ),
                    OutlinedButton.icon(
                      onPressed: _primaryController.isDestroyed
                          ? null
                          : () => _primaryController.setMinimized(false),
                      icon: const Icon(Icons.crop_din),
                      label: const Text('setMinimized(false)'),
                    ),
                    Chip(
                      label: Text('isMinimized = $min'),
                      backgroundColor: min
                          ? Colors.amber.withValues(alpha: 0.2)
                          : Colors.grey.withValues(alpha: 0.15),
                    ),
                  ],
                );
              },
            ),
            _CodeSnippet(
              code:
                  'controller.setMinimized(true);   // dock the window\n'
                  'controller.setMinimized(false);  // restore from dock\n'
                  'final bool min = controller.isMinimized;',
            ),
          ],
        );
      },
    ),
  );
}

Widget _buildMaximizeSection(BuildContext context) {
  return _SectionCard(
    title: '6 · Maximize / Zoom · setMaximized / isMaximized',
    subtitle:
        'Green traffic-light behavior. Note: macOS treats this as "zoom" not '
        'true maximize. Holding ⌥ on the green button means fullscreen instead.',
    child: ValueListenableBuilder<bool>(
      valueListenable: _darkMode,
      builder: (BuildContext ctx, bool dark, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _ChromePreview(controller: _primaryController, dark: dark),
            const SizedBox(height: 12),
            AnimatedBuilder(
              animation: _primaryController,
              builder: (BuildContext c, _) {
                final bool maxd = _primaryController.isDestroyed
                    ? false
                    : _primaryController.isMaximized;
                return Wrap(
                  spacing: 10,
                  children: <Widget>[
                    FilledButton.icon(
                      onPressed: _primaryController.isDestroyed
                          ? null
                          : () => _primaryController.setMaximized(true),
                      icon: const Icon(Icons.zoom_out_map),
                      label: const Text('setMaximized(true)'),
                    ),
                    OutlinedButton.icon(
                      onPressed: _primaryController.isDestroyed
                          ? null
                          : () => _primaryController.setMaximized(false),
                      icon: const Icon(Icons.zoom_in_map),
                      label: const Text('setMaximized(false)'),
                    ),
                    Chip(
                      label: Text('isMaximized = $maxd'),
                      backgroundColor: maxd
                          ? Colors.green.withValues(alpha: 0.2)
                          : Colors.grey.withValues(alpha: 0.15),
                    ),
                  ],
                );
              },
            ),
            _CodeSnippet(
              code:
                  'controller.setMaximized(true);  // green-button zoom\n'
                  'controller.setMaximized(false);\n'
                  'final bool zoomed = controller.isMaximized;',
            ),
          ],
        );
      },
    ),
  );
}

Widget _buildFullscreenSection(BuildContext context) {
  return _SectionCard(
    title: '7 · Fullscreen · setFullscreen / isFullscreen',
    subtitle:
        'Native fullscreen Space transition. The optional `display` parameter '
        'targets a specific monitor.',
    child: ValueListenableBuilder<bool>(
      valueListenable: _darkMode,
      builder: (BuildContext ctx, bool dark, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _ChromePreview(controller: _primaryController, dark: dark),
            const SizedBox(height: 12),
            AnimatedBuilder(
              animation: _primaryController,
              builder: (BuildContext c, _) {
                final bool fs = _primaryController.isDestroyed
                    ? false
                    : _primaryController.isFullscreen;
                return Row(
                  children: <Widget>[
                    Switch(
                      value: fs,
                      onChanged: _primaryController.isDestroyed
                          ? null
                          : (bool v) => _primaryController.setFullscreen(v),
                    ),
                    const SizedBox(width: 8),
                    Text('setFullscreen($fs)',
                        style: const TextStyle(fontFamily: 'monospace')),
                    const SizedBox(width: 16),
                    Chip(
                      avatar: Icon(fs ? Icons.fullscreen : Icons.fullscreen_exit,
                          size: 18),
                      label: Text('isFullscreen = $fs'),
                    ),
                  ],
                );
              },
            ),
            _CodeSnippet(
              code:
                  'controller.setFullscreen(true);  // enter Space\n'
                  'controller.setFullscreen(false); // restore window\n'
                  '// Optionally target a specific Display:\n'
                  '// controller.setFullscreen(true, display: targetDisplay);\n'
                  'final bool full = controller.isFullscreen;',
            ),
          ],
        );
      },
    ),
  );
}

Widget _buildCloseSection(BuildContext context) {
  return _SectionCard(
    title: '8 · Close behavior · onWindowCloseRequested · destroy',
    subtitle:
        'Red traffic-light. By default the delegate destroys the window; '
        'override `onWindowCloseRequested` to interpose a confirm dialog.',
    child: ValueListenableBuilder<bool>(
      valueListenable: _darkMode,
      builder: (BuildContext ctx, bool dark, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _ChromePreview(controller: _primaryController, dark: dark),
            const SizedBox(height: 12),
            AnimatedBuilder(
              animation: _primaryController,
              builder: (BuildContext c, _) {
                return Wrap(
                  spacing: 10,
                  runSpacing: 8,
                  children: <Widget>[
                    FilledButton.icon(
                      onPressed: _primaryController.isDestroyed
                          ? null
                          : _primaryController.requestClose,
                      icon: const Icon(Icons.close),
                      label: const Text('user clicks ⊗ (red)'),
                    ),
                    OutlinedButton.icon(
                      onPressed: _primaryController.isDestroyed
                          ? null
                          : () => _primaryController.destroy(),
                      icon: const Icon(Icons.delete_forever),
                      label: const Text('controller.destroy()'),
                    ),
                  ],
                );
              },
            ),
            _DelegateLogPanel(delegate: _primaryDelegate),
            _CodeSnippet(
              code:
                  'class ConfirmCloseDelegate with RegularWindowControllerDelegate {\n'
                  '  @override\n'
                  '  void onWindowCloseRequested(RegularWindowController controller) {\n'
                  '    if (await _userConfirmsClose()) {\n'
                  '      controller.destroy();\n'
                  '    }\n'
                  '  }\n'
                  '  @override\n'
                  '  void onWindowDestroyed() {\n'
                  '    debugPrint(\'window destroyed\');\n'
                  '  }\n'
                  '}',
            ),
          ],
        );
      },
    ),
  );
}

Widget _buildFocusSection(BuildContext context) {
  return _SectionCard(
    title: '9 · Focus / activate · activate · isActivated',
    subtitle: 'Activating a controller deactivates siblings (per the macOS HIG).',
    child: ValueListenableBuilder<bool>(
      valueListenable: _darkMode,
      builder: (BuildContext ctx, bool dark, _) {
        return AnimatedBuilder(
          animation: Listenable.merge(<Listenable>[
            _primaryController,
            _secondaryController,
            _tertiaryController,
          ]),
          builder: (BuildContext c, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: <Widget>[
                    _focusTile('primary', _primaryController, dark),
                    _focusTile('secondary', _secondaryController, dark),
                    _focusTile('tertiary', _tertiaryController, dark),
                  ],
                ),
                const SizedBox(height: 10),
                _CodeSnippet(
                  code:
                      'controller.activate();           // raise + give key focus\n'
                      'final bool focused = controller.isActivated;',
                ),
              ],
            );
          },
        );
      },
    ),
  );
}

Widget _focusTile(String label, _FakeRegularWindowControllerMacOS c, bool dark) {
  return InkWell(
    onTap: c.isDestroyed ? null : c.activate,
    child: Container(
      width: 220,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: c.isActivated && !c.isDestroyed
            ? Colors.blue.withValues(alpha: 0.10)
            : Colors.transparent,
        border: Border.all(
          color: c.isActivated && !c.isDestroyed
              ? Colors.blue
              : Colors.grey.withValues(alpha: 0.4),
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                c.isActivated && !c.isDestroyed
                    ? Icons.radio_button_checked
                    : Icons.radio_button_off,
                size: 16,
                color: c.isActivated && !c.isDestroyed
                    ? Colors.blue
                    : Colors.grey,
              ),
              const SizedBox(width: 6),
              Text(label,
                  style: const TextStyle(fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 6),
          _ChromePreview(controller: c, dark: dark, width: 200, height: 110),
        ],
      ),
    ),
  );
}

Widget _buildMultiWindowSection(BuildContext context) {
  return _SectionCard(
    title: '10 · Multi-window orchestration',
    subtitle:
        'Three controllers managed by the same `WindowingOwnerMacOS`. The owner '
        'tracks active controllers; each `activate()` deactivates siblings.',
    child: ValueListenableBuilder<bool>(
      valueListenable: _darkMode,
      builder: (BuildContext ctx, bool dark, _) {
        return AnimatedBuilder(
          animation: Listenable.merge(<Listenable>[
            _primaryController,
            _secondaryController,
            _tertiaryController,
          ]),
          builder: (BuildContext c, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 320),
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CustomPaint(
                            painter: _MultiWindowGridPainter(dark: dark),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 24,
                        top: 24,
                        child: _ChromePreview(
                          controller: _primaryController,
                          dark: dark,
                          width: 320,
                          height: 200,
                        ),
                      ),
                      Positioned(
                        left: 220,
                        top: 80,
                        child: _ChromePreview(
                          controller: _secondaryController,
                          dark: dark,
                          width: 280,
                          height: 170,
                        ),
                      ),
                      Positioned(
                        left: 80,
                        top: 130,
                        child: _ChromePreview(
                          controller: _tertiaryController,
                          dark: dark,
                          width: 260,
                          height: 150,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 10,
                  runSpacing: 8,
                  children: <Widget>[
                    OutlinedButton(
                      onPressed: () {
                        if (!_primaryController.isDestroyed) {
                          _primaryController.activate();
                        }
                      },
                      child: const Text('activate primary'),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        if (!_secondaryController.isDestroyed) {
                          _secondaryController.activate();
                        }
                      },
                      child: const Text('activate secondary'),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        if (!_tertiaryController.isDestroyed) {
                          _tertiaryController.activate();
                        }
                      },
                      child: const Text('activate tertiary'),
                    ),
                    FilledButton.tonal(
                      onPressed: () {
                        for (final _FakeRegularWindowControllerMacOS k
                            in _liveOwner.controllers) {
                          if (!k.isDestroyed) {
                            k.setMinimized(true);
                          }
                        }
                      },
                      child: const Text('minimize all'),
                    ),
                    FilledButton.tonal(
                      onPressed: () {
                        for (final _FakeRegularWindowControllerMacOS k
                            in _liveOwner.controllers) {
                          if (!k.isDestroyed) {
                            k.setMinimized(false);
                          }
                        }
                      },
                      child: const Text('restore all'),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  'owner.controllers.length = ${_liveOwner.controllers.length}',
                  style: const TextStyle(fontFamily: 'monospace'),
                ),
                _CodeSnippet(
                  code:
                      'final WindowingOwnerMacOS owner = WindowingOwnerMacOS();\n'
                      'final RegularWindowController a = owner.createRegularWindowController(...);\n'
                      'final RegularWindowController b = owner.createRegularWindowController(...);\n'
                      'final RegularWindowController c = owner.createRegularWindowController(...);\n'
                      'b.activate();   // a, c become inactive\n'
                      '// owner internally tracks `_activeControllers`.',
                ),
              ],
            );
          },
        );
      },
    ),
  );
}

class _RecipeSpec {
  const _RecipeSpec({
    required this.title,
    required this.size,
    required this.dark,
    required this.maximized,
    required this.minimized,
    required this.fullscreen,
    required this.activated,
    required this.code,
  });
  final String title;
  final Size size;
  final bool dark;
  final bool maximized;
  final bool minimized;
  final bool fullscreen;
  final bool activated;
  final String code;
}

const List<_RecipeSpec> _recipes = <_RecipeSpec>[
  _RecipeSpec(
    title: 'Light · default',
    size: Size(420, 240),
    dark: false,
    maximized: false,
    minimized: false,
    fullscreen: false,
    activated: true,
    code:
        'owner.createRegularWindowController(\n'
        '  delegate: const RegularWindowControllerDelegate(),\n'
        '  preferredSize: const Size(640, 480),\n'
        '  title: \'Editor\',\n'
        ');',
  ),
  _RecipeSpec(
    title: 'Dark · default',
    size: Size(420, 240),
    dark: true,
    maximized: false,
    minimized: false,
    fullscreen: false,
    activated: true,
    code: '// Same call; dark chrome follows system appearance.',
  ),
  _RecipeSpec(
    title: 'Tiny utility',
    size: Size(220, 200),
    dark: false,
    maximized: false,
    minimized: false,
    fullscreen: false,
    activated: true,
    code:
        'owner.createRegularWindowController(\n'
        '  delegate: ToolDelegate(),\n'
        '  preferredSize: const Size(220, 200),\n'
        '  preferredConstraints: const BoxConstraints.tightFor(width: 220, height: 200),\n'
        '  title: \'Inspector\',\n'
        ');',
  ),
  _RecipeSpec(
    title: 'Wide composer',
    size: Size(560, 220),
    dark: false,
    maximized: false,
    minimized: false,
    fullscreen: false,
    activated: true,
    code:
        'owner.createRegularWindowController(\n'
        '  delegate: ComposerDelegate(),\n'
        '  preferredSize: const Size(900, 380),\n'
        '  title: \'Compose\',\n'
        ');',
  ),
  _RecipeSpec(
    title: 'Tall sidebar',
    size: Size(220, 320),
    dark: true,
    maximized: false,
    minimized: false,
    fullscreen: false,
    activated: false,
    code:
        'owner.createRegularWindowController(\n'
        '  delegate: SidebarDelegate(),\n'
        '  preferredSize: const Size(280, 720),\n'
        '  preferredConstraints: BoxConstraints(minWidth: 240, maxWidth: 360,\n'
        '                                       minHeight: 480, maxHeight: 1200),\n'
        '  title: \'Library\',\n'
        ');',
  ),
  _RecipeSpec(
    title: 'Zoomed (maximize)',
    size: Size(480, 240),
    dark: false,
    maximized: true,
    minimized: false,
    fullscreen: false,
    activated: true,
    code: 'controller.setMaximized(true);',
  ),
  _RecipeSpec(
    title: 'Minimized (dock)',
    size: Size(480, 240),
    dark: false,
    maximized: false,
    minimized: true,
    fullscreen: false,
    activated: true,
    code: 'controller.setMinimized(true);',
  ),
  _RecipeSpec(
    title: 'Fullscreen Space',
    size: Size(560, 240),
    dark: false,
    maximized: false,
    minimized: false,
    fullscreen: true,
    activated: true,
    code: 'controller.setFullscreen(true);',
  ),
  _RecipeSpec(
    title: 'Inactive (unfocused)',
    size: Size(420, 240),
    dark: false,
    maximized: false,
    minimized: false,
    fullscreen: false,
    activated: false,
    code:
        '// Sibling controller calls activate(); this one\n'
        '// transitions to !isActivated automatically.',
  ),
];

Widget _buildRecipeGallery(BuildContext context) {
  return _SectionCard(
    title: '11 · Recipe gallery',
    subtitle: 'Nine pre-canned chrome variants — pick one to inspect.',
    child: ValueListenableBuilder<int>(
      valueListenable: _selectedRecipe,
      builder: (BuildContext ctx, int sel, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 110,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _recipes.length,
                separatorBuilder: (BuildContext _, int _) =>
                    const SizedBox(width: 10),
                itemBuilder: (BuildContext c, int i) {
                  final _RecipeSpec r = _recipes[i];
                  final bool selected = i == sel;
                  return InkWell(
                    onTap: () => _selectedRecipe.value = i,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 160),
                      width: 160,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: selected
                              ? Theme.of(c).colorScheme.primary
                              : Theme.of(c).colorScheme.outlineVariant,
                          width: selected ? 1.6 : 0.6,
                        ),
                        borderRadius: BorderRadius.circular(8),
                        color: selected
                            ? Theme.of(c)
                                .colorScheme
                                .primary
                                .withValues(alpha: 0.06)
                            : Colors.transparent,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('${i + 1}. ${r.title}',
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w600),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis),
                          const SizedBox(height: 6),
                          Expanded(
                            child: _RecipePreview(spec: r, miniature: true),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 14),
            Center(child: _RecipePreview(spec: _recipes[sel], miniature: false)),
            const SizedBox(height: 12),
            _CodeSnippet(code: _recipes[sel].code),
          ],
        );
      },
    ),
  );
}

class _RecipePreview extends StatelessWidget {
  const _RecipePreview({required this.spec, required this.miniature});
  final _RecipeSpec spec;
  final bool miniature;

  @override
  Widget build(BuildContext context) {
    final double w = miniature ? 132 : spec.size.width;
    final double h = miniature
        ? 70
        : (spec.minimized ? _kTitlebarHeight + 18 : spec.size.height);
    return SizedBox(
      width: w,
      height: h,
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: CustomPaint(
              painter: _WindowChromePainter(
                dark: spec.dark,
                activated: spec.activated,
                fullscreen: spec.fullscreen,
                minimized: spec.minimized,
                maximized: spec.maximized,
                title: spec.title,
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 0,
            width: miniature ? 60 : 80,
            height: miniature ? 18 : _kTitlebarHeight,
            child: CustomPaint(
              painter: _TrafficLightsPainter(
                activated: spec.activated,
                canClose: !spec.fullscreen,
                canMinimize: !spec.fullscreen,
                canZoom: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildPitfallsSection(BuildContext context) {
  const List<List<String>> rows = <List<String>>[
    <String>[
      '`@internal` boundary',
      'The class is exported nowhere. You must go through `WindowingOwnerMacOS.createRegularWindowController(...)` and store as the abstract base type `RegularWindowController`.',
    ],
    <String>[
      'Experimental flag',
      '`isWindowingEnabled` must be true at engine build. Otherwise the constructor throws `UnsupportedError`. See https://github.com/flutter/flutter/issues/30701.',
    ],
    <String>[
      'Platform check',
      '`WindowingOwnerMacOS()` throws `UnsupportedError` on non-macOS. Always wrap construction in `if (Platform.isMacOS)` or `Theme.of(context).platform == TargetPlatform.macOS`.',
    ],
    <String>[
      'NativeCallable lifecycle',
      'The controller registers FFI `NativeCallable<Void Function()>` for `onShouldClose`, `onWillClose`, `onResize`. Calling `destroy()` is REQUIRED for them to be closed in `_handleOnWillClose`.',
    ],
    <String>[
      '`contentSize` ≠ frame size',
      '`setSize(Size)` and `contentSize` refer to the CONTENT area only. The 28dp title bar is rendered above and is not included.',
    ],
    <String>[
      'Maximize vs Fullscreen',
      'macOS distinguishes "zoom" (`setMaximized`) from native fullscreen (`setFullscreen`). Don\'t conflate them: they\'re separate state machines.',
    ],
    <String>[
      'Listening for resize',
      'The controller is itself a `Listenable` (extends `ChangeNotifier` via `BaseWindowController`). Use `AnimatedBuilder` or `controller.addListener(...)`.',
    ],
    <String>[
      'Close vs Destroy',
      'User pressing ⊗ → `delegate.onWindowCloseRequested` (you decide). Calling `destroy()` directly skips the request hook.',
    ],
    <String>[
      'Active controllers list',
      '`WindowingOwnerMacOS._activeControllers` is private; iterate your own collection. The owner only uses it for housekeeping.',
    ],
    <String>[
      'Tooltip / Popup',
      '`createTooltipWindowController` / `createPopupWindowController` throw `UnimplementedError` on macOS today.',
    ],
  ];

  return _SectionCard(
    title: '12 · Pitfalls & gotchas',
    subtitle: 'Things that bite in real macOS multi-window code.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        for (int i = 0; i < rows.length; i++)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(context).colorScheme.outlineVariant,
                  width: 0.4,
                ),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CircleAvatar(
                  radius: 12,
                  backgroundColor: Theme.of(context)
                      .colorScheme
                      .primary
                      .withValues(alpha: 0.12),
                  child: Text('${i + 1}',
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).colorScheme.primary)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(rows[i][0],
                          style:
                              const TextStyle(fontWeight: FontWeight.w700)),
                      const SizedBox(height: 4),
                      Text(rows[i][1],
                          style: const TextStyle(
                              fontSize: 12.5, height: 1.45)),
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

Widget _buildReferenceTable(BuildContext context) {
  const List<List<String>> apiRows = <List<String>>[
    <String>['Constructor', 'RegularWindowControllerMacOS({owner, delegate, preferredSize, preferredConstraints, title})'],
    <String>['contentSize', 'Size — current content area'],
    <String>['title', 'String — current window title'],
    <String>['constraints', 'BoxConstraints — current min/max'],
    <String>['isMaximized', 'bool — getter'],
    <String>['isMinimized', 'bool — getter'],
    <String>['isFullscreen', 'bool — getter'],
    <String>['isActivated', 'bool — getter'],
    <String>['setSize(Size)', 'set content size (FFI: InternalFlutter_Window_SetContentSize)'],
    <String>['setConstraints(BoxConstraints)', 'set min/max (FFI: InternalFlutter_Window_SetConstraints)'],
    <String>['setTitle(String)', 'sets window title (FFI: InternalFlutter_Window_SetTitle)'],
    <String>['setMaximized(bool)', 'green-button zoom toggle'],
    <String>['setMinimized(bool)', 'yellow-button miniaturize / unminiaturize'],
    <String>['setFullscreen(bool, {Display? display})', 'native Space transition'],
    <String>['activate()', 'raise + key window (FFI: InternalFlutter_Window_Activate)'],
    <String>['destroy()', 'tear down the NSWindow + close NativeCallables'],
    <String>['getWindowHandle()', 'Pointer<Void> to NSWindow*'],
  ];
  const List<List<String>> delegateRows = <List<String>>[
    <String>['onWindowCloseRequested(controller)', 'user clicked ⊗; default = controller.destroy()'],
    <String>['onWindowDestroyed()', 'NSWindow has been torn down'],
  ];

  return _SectionCard(
    title: '13 · Reference table',
    subtitle: 'Full API surface for `RegularWindowControllerMacOS` and its delegate.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Text('RegularWindowControllerMacOS',
              style: Theme.of(context).textTheme.titleMedium),
        ),
        _refTable(context, apiRows),
        const SizedBox(height: 14),
        Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Text('RegularWindowControllerDelegate',
              style: Theme.of(context).textTheme.titleMedium),
        ),
        _refTable(context, delegateRows),
      ],
    ),
  );
}

Widget _refTable(BuildContext context, List<List<String>> rows) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(
        color: Theme.of(context).colorScheme.outlineVariant,
        width: 0.5,
      ),
      borderRadius: BorderRadius.circular(6),
    ),
    child: Column(
      children: <Widget>[
        for (int i = 0; i < rows.length; i++)
          Container(
            decoration: BoxDecoration(
              color: i.isEven
                  ? Theme.of(context).colorScheme.surfaceContainerLowest
                  : Theme.of(context).colorScheme.surfaceContainerLow,
              border: i == rows.length - 1
                  ? null
                  : Border(
                      bottom: BorderSide(
                        color: Theme.of(context).colorScheme.outlineVariant,
                        width: 0.3,
                      ),
                    ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 240,
                  child: SelectableText(
                    rows[i][0],
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Expanded(
                  child: SelectableText(
                    rows[i][1],
                    style: const TextStyle(fontSize: 12.5),
                  ),
                ),
              ],
            ),
          ),
      ],
    ),
  );
}

Widget _buildTitleEditor(BuildContext context) {
  return _SectionCard(
    title: 'Bonus · setTitle live',
    subtitle: 'Type to call `controller.setTitle(value)`.',
    child: ValueListenableBuilder<bool>(
      valueListenable: _darkMode,
      builder: (BuildContext ctx, bool dark, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ValueListenableBuilder<String>(
              valueListenable: _titleEditValue,
              builder: (BuildContext c, String value, _) {
                return TextField(
                  controller: TextEditingController(text: value)
                    ..selection = TextSelection.collapsed(offset: value.length),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Window title',
                    isDense: true,
                  ),
                  onSubmitted: (String v) {
                    _titleEditValue.value = v;
                    if (!_primaryController.isDestroyed) {
                      _primaryController.setTitle(v);
                    }
                  },
                  onChanged: (String v) {
                    _titleEditValue.value = v;
                    if (!_primaryController.isDestroyed) {
                      _primaryController.setTitle(v);
                    }
                  },
                );
              },
            ),
            const SizedBox(height: 12),
            _ChromePreview(controller: _primaryController, dark: dark),
          ],
        );
      },
    ),
  );
}

Widget _buildHeader(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(16, 18, 16, 6),
    child: Row(
      children: <Widget>[
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Icon(Icons.desktop_mac,
              color: Theme.of(context).colorScheme.primary),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('RegularWindowControllerMacOS',
                  style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 2),
              Text(
                'Deep demo · Flutter experimental multi-window API · macOS impl',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color:
                          Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
            ],
          ),
        ),
        ValueListenableBuilder<bool>(
          valueListenable: _primaryFocus,
          builder: (BuildContext ctx, bool focused, _) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Chip(
                avatar: Icon(
                  focused ? Icons.center_focus_strong : Icons.center_focus_weak,
                  size: 16,
                  color: focused ? Colors.green : Colors.grey,
                ),
                label: Text(focused ? 'primary focused' : 'primary blurred',
                    style: const TextStyle(fontSize: 11)),
                visualDensity: VisualDensity.compact,
              ),
            );
          },
        ),
        ValueListenableBuilder<bool>(
          valueListenable: _showCodeSnippets,
          builder: (BuildContext ctx, bool show, _) {
            return IconButton(
              tooltip: show ? 'hide code snippets' : 'show code snippets',
              icon: Icon(show ? Icons.code_off : Icons.code),
              onPressed: () => _showCodeSnippets.value = !show,
            );
          },
        ),
        ValueListenableBuilder<bool>(
          valueListenable: _darkMode,
          builder: (BuildContext ctx, bool dark, _) {
            return IconButton(
              tooltip: dark ? 'light chrome' : 'dark chrome',
              icon: Icon(dark ? Icons.light_mode : Icons.dark_mode),
              onPressed: () => _darkMode.value = !dark,
            );
          },
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 8 — Top-level `build` entry point.
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  return ValueListenableBuilder<bool>(
    valueListenable: _darkMode,
    builder: (BuildContext ctx, bool dark, _) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF1E88E5),
            brightness: dark ? Brightness.dark : Brightness.light,
          ),
        ),
        home: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _buildHeader(ctx),
                  _buildPlatformBanner(ctx),
                  _buildAnatomySection(ctx),
                  _buildChromeAnatomy(ctx),
                  _buildBasicCreationSection(ctx),
                  _buildResizeSection(ctx),
                  _buildMinimizeSection(ctx),
                  _buildMaximizeSection(ctx),
                  _buildFullscreenSection(ctx),
                  _buildCloseSection(ctx),
                  _buildFocusSection(ctx),
                  _buildMultiWindowSection(ctx),
                  _buildRecipeGallery(ctx),
                  _buildTitleEditor(ctx),
                  _buildPitfallsSection(ctx),
                  _buildReferenceTable(ctx),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
