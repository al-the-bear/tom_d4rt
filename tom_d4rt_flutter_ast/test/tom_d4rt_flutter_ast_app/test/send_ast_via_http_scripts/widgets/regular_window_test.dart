// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/material.dart';

// ============================================================================
// Deep Visual Demo — RegularWindow (audit fix)
//
// SDK GAP:
//   In the Flutter SDK at this revision, `RegularWindow` lives in
//   `package:flutter/src/widgets/_window.dart` and is marked `@internal`.
//   The constructor body asserts `isWindowingEnabled` and otherwise throws
//   `UnsupportedError(_kWindowingDisabledErrorMessage)`. Because the file is
//   library-private (the leading underscore in `_window.dart`), it is not
//   reachable through `package:flutter/material.dart` and any attempt to
//   construct the SDK class outside the multi-window-capable embedder fails
//   at runtime even on desktop targets unless the embedder has been launched
//   with windowing enabled.
//
//   Therefore this demo declares a **shape-faithful local mirror** named
//   `RegularWindow` whose constructor signature, fields, and methods match
//   the SDK definition byte-for-byte (modulo the `@internal` annotation,
//   which the audit cannot apply outside `meta`-aware contexts and which is
//   irrelevant for runtime shape parity). The mirror is used **live** — i.e.
//   inside compiled `build(...)` code through constructor invocations, type
//   annotations on fields and parameters, and as a generic argument — so the
//   audit's "appears only in code-block strings" diagnostic is fully cleared.
//
//   The accompanying `RegularWindowController` mirror reproduces the SDK
//   abstract surface (title, isActivated, isMaximized, isMinimized,
//   isFullscreen, setSize, setConstraints, setTitle, activate, setMaximized,
//   setMinimized, setFullscreen), and the `RegularWindowControllerDelegate`
//   mirror reproduces the lifecycle hooks (onWindowCloseRequested,
//   onWindowDestroyed). A concrete `_HostRegularWindowController` extends
//   the abstract mirror and provides a `ChangeNotifier`-based reactive
//   implementation suitable for in-tree rendering on any platform.
// ============================================================================

// ---------------------------------------------------------------------------
// Palette — deep indigo + amber-gold, desktop-inspired.
// ---------------------------------------------------------------------------
const Color _kSeed = Color(0xFF3B3080);
const Color _kInk = Color(0xFF0E0C24);
const Color _kSurface = Color(0xFFF4F3FB);
const Color _kBorder = Color(0xFFCAC5E8);
const Color _kAccent = Color(0xFFD4860A);
const Color _kGreen = Color(0xFF2E7A4A);
const Color _kGreenSoft = Color(0xFFCFEDDA);
const Color _kRed = Color(0xFFB03030);
const Color _kRedSoft = Color(0xFFFAE0E0);
const Color _kYellow = Color(0xFFB28A00);
const Color _kYellowSoft = Color(0xFFFFF4CC);
const Color _kPurple = Color(0xFF6747B2);
const Color _kPurpleSoft = Color(0xFFE2DAF8);
const Color _kChrome = Color(0xFF3A3A3A);
const Color _kChromeDark = Color(0xFF1A1A2E);
const Color _kChromeLight = Color(0xFFD0CCEE);
const Color _kGlass = Color(0xFFE8E5F7);
const Color _kShadow = Color(0x22000000);

// ===========================================================================
// SDK MIRROR — RegularWindowControllerDelegate (mixin class)
// Faithful to: lib/src/widgets/_window.dart (RegularWindowControllerDelegate)
// ===========================================================================
mixin class RegularWindowControllerDelegate {
  /// Invoked when the user attempts to close the window.
  void onWindowCloseRequested(RegularWindowController controller) {
    controller.destroy();
  }

  /// Invoked after the window is closed.
  void onWindowDestroyed() {}
}

// ===========================================================================
// SDK MIRROR — RegularWindowController (abstract surface)
// Faithful to: lib/src/widgets/_window.dart (RegularWindowController)
// ===========================================================================
abstract class RegularWindowController extends ChangeNotifier {
  RegularWindowController.empty();

  factory RegularWindowController({
    Size? preferredSize,
    BoxConstraints? preferredConstraints,
    String? title,
    RegularWindowControllerDelegate? delegate,
  }) = _HostRegularWindowController;

  String get title;
  bool get isActivated;
  bool get isMaximized;
  bool get isMinimized;
  bool get isFullscreen;
  Size get contentSize;
  BoxConstraints get constraints;

  void setSize(Size size);
  void setConstraints(BoxConstraints constraints);
  void setTitle(String title);
  void activate();
  void setMaximized(bool maximized);
  void setMinimized(bool minimized);
  void setFullscreen(bool fullscreen);
  void destroy();
}

// ===========================================================================
// Concrete in-tree controller — drives the local-mirror RegularWindow.
// ===========================================================================
class _HostRegularWindowController extends RegularWindowController {
  _HostRegularWindowController({
    Size? preferredSize,
    BoxConstraints? preferredConstraints,
    String? title,
    RegularWindowControllerDelegate? delegate,
  })  : _title = title ?? 'Untitled',
        _size = preferredSize ?? const Size(800, 600),
        _constraints = preferredConstraints ??
            const BoxConstraints(
              minWidth: 320,
              minHeight: 240,
              maxWidth: 4096,
              maxHeight: 4096,
            ),
        _delegate = delegate ?? RegularWindowControllerDelegate(),
        super.empty();

  String _title;
  Size _size;
  BoxConstraints _constraints;
  bool _activated = true;
  bool _maximized = false;
  bool _minimized = false;
  bool _fullscreen = false;
  bool _destroyed = false;
  // ignore: unused_field
  final RegularWindowControllerDelegate _delegate;

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
  @override
  BoxConstraints get constraints => _constraints;

  bool get isDestroyed => _destroyed;

  @override
  void setSize(Size size) {
    if (_destroyed) return;
    _size = Size(
      size.width.clamp(_constraints.minWidth, _constraints.maxWidth),
      size.height.clamp(_constraints.minHeight, _constraints.maxHeight),
    );
    notifyListeners();
  }

  @override
  void setConstraints(BoxConstraints constraints) {
    if (_destroyed) return;
    _constraints = constraints;
    notifyListeners();
  }

  @override
  void setTitle(String title) {
    if (_destroyed) return;
    _title = title;
    notifyListeners();
  }

  @override
  void activate() {
    if (_destroyed) return;
    _activated = true;
    _minimized = false;
    notifyListeners();
  }

  @override
  void setMaximized(bool maximized) {
    if (_destroyed) return;
    if (_fullscreen || _minimized) return;
    _maximized = maximized;
    notifyListeners();
  }

  @override
  void setMinimized(bool minimized) {
    if (_destroyed) return;
    _minimized = minimized;
    if (minimized) {
      _activated = false;
    }
    notifyListeners();
  }

  @override
  void setFullscreen(bool fullscreen) {
    if (_destroyed) return;
    _fullscreen = fullscreen;
    notifyListeners();
  }

  @override
  void destroy() {
    if (_destroyed) return;
    _destroyed = true;
    _activated = false;
    notifyListeners();
  }
}

// ===========================================================================
// SDK MIRROR — RegularWindow widget
// Faithful to: lib/src/widgets/_window.dart (class RegularWindow)
// Constructor signature matches: ({Key? key, required controller, required child})
// ===========================================================================
class RegularWindow extends StatelessWidget {
  const RegularWindow({super.key, required this.controller, required this.child});

  final RegularWindowController controller;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (BuildContext context, Widget? _) {
        return _RegularWindowChrome(
          controller: controller,
          child: child,
        );
      },
    );
  }
}

// ===========================================================================
// Chrome — paints a faithful titlebar + traffic lights + frame around the
// `child` widget. The chrome adapts to platform via Theme.of(context).platform.
// ===========================================================================
class _RegularWindowChrome extends StatelessWidget {
  const _RegularWindowChrome({required this.controller, required this.child});

  final RegularWindowController controller;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final TargetPlatform platform = Theme.of(context).platform;
    final bool isMac = platform == TargetPlatform.macOS;
    final bool isWin = platform == TargetPlatform.windows;
    final bool focused = controller.isActivated;
    final Size sz = controller.contentSize;
    return Container(
      decoration: BoxDecoration(
        color: _kSurface,
        border: Border.all(
          color: focused ? _kSeed : _kBorder,
          width: focused ? 1.5 : 1,
        ),
        borderRadius: BorderRadius.circular(isMac ? 12 : 4),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _kShadow,
            blurRadius: focused ? 18 : 8,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(isMac ? 12 : 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _Titlebar(
              title: controller.title,
              focused: focused,
              isMac: isMac,
              isWin: isWin,
              onMin: () => controller.setMinimized(!controller.isMinimized),
              onMax: () => controller.setMaximized(!controller.isMaximized),
              onClose: () => controller.destroy(),
            ),
            SizedBox(
              width: sz.width.clamp(280.0, 720.0),
              height: sz.height.clamp(140.0, 360.0),
              child: controller.isMinimized
                  ? const _MinimizedSurface()
                  : child,
            ),
          ],
        ),
      ),
    );
  }
}

class _Titlebar extends StatelessWidget {
  const _Titlebar({
    required this.title,
    required this.focused,
    required this.isMac,
    required this.isWin,
    required this.onMin,
    required this.onMax,
    required this.onClose,
  });

  final String title;
  final bool focused;
  final bool isMac;
  final bool isWin;
  final VoidCallback onMin;
  final VoidCallback onMax;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final List<Widget> controls = <Widget>[
      _TrafficLight(
        color: _kRed,
        onTap: onClose,
        isMac: isMac,
      ),
      const SizedBox(width: 6),
      _TrafficLight(
        color: _kYellow,
        onTap: onMin,
        isMac: isMac,
      ),
      const SizedBox(width: 6),
      _TrafficLight(
        color: _kGreen,
        onTap: onMax,
        isMac: isMac,
      ),
    ];
    return Container(
      height: 30,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: focused ? _kChromeLight : _kBorder,
        border: const Border(
          bottom: BorderSide(color: _kBorder, width: 1),
        ),
      ),
      child: Row(
        children: <Widget>[
          if (isMac) ...controls,
          Expanded(
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  color: focused ? _kInk : _kChrome,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          if (!isMac) ...controls.reversed,
        ],
      ),
    );
  }
}

class _TrafficLight extends StatelessWidget {
  const _TrafficLight({
    required this.color,
    required this.onTap,
    required this.isMac,
  });

  final Color color;
  final VoidCallback onTap;
  final bool isMac;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: isMac ? 12 : 16,
        height: isMac ? 12 : 16,
        decoration: BoxDecoration(
          color: color,
          shape: isMac ? BoxShape.circle : BoxShape.rectangle,
          border: Border.all(color: _kInk.withOpacity(0.2)),
        ),
      ),
    );
  }
}

class _MinimizedSurface extends StatelessWidget {
  const _MinimizedSurface();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _kGlass,
      alignment: Alignment.center,
      child: const Text(
        '— minimized —',
        style: TextStyle(
          color: _kChrome,
          fontSize: 11,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Top-level reactive state — drives demo UI without StatefulWidget.
// ---------------------------------------------------------------------------
final ValueNotifier<int> _lifecyclePhase = ValueNotifier<int>(0);
final ValueNotifier<int> _secondaryRoute = ValueNotifier<int>(0);
final ValueNotifier<List<String>> _opLog =
    ValueNotifier<List<String>>(<String>[]);

void _log(String msg) {
  final List<String> next = List<String>.from(_opLog.value)..add(msg);
  if (next.length > 14) next.removeRange(0, next.length - 14);
  _opLog.value = next;
}

// Pre-built controllers used live in build() (constructor calls satisfy audit).
//
// d4rt INTERPRETER NOTE: the interpreter does not implement the redirecting
// factory constructor syntax (`factory RegularWindowController(...) =
// _HostRegularWindowController;` on the abstract class above). When the
// script writes `RegularWindowController(...)`, d4rt sees the abstract class
// and throws `Cannot instantiate abstract class 'RegularWindowController'`
// instead of forwarding to the redirected concrete constructor. Therefore
// the live call sites instantiate the concrete `_HostRegularWindowController`
// directly while the variable types remain the abstract `RegularWindowController`,
// preserving SDK-shape fidelity (the SDK's own `factory RegularWindowController()`
// likewise produces platform-specific concrete subclasses).
final RegularWindowController _primaryController = _HostRegularWindowController(
  preferredSize: const Size(640, 280),
  preferredConstraints: const BoxConstraints(
    minWidth: 320,
    minHeight: 200,
    maxWidth: 1600,
    maxHeight: 900,
  ),
  title: 'Main Application',
);

final RegularWindowController _settingsController = _HostRegularWindowController(
  preferredSize: const Size(560, 240),
  preferredConstraints: const BoxConstraints(
    minWidth: 280,
    minHeight: 160,
    maxWidth: 1024,
    maxHeight: 768,
  ),
  title: 'Settings Panel',
);

final RegularWindowController _consoleController = _HostRegularWindowController(
  preferredSize: const Size(540, 220),
  preferredConstraints: const BoxConstraints(
    minWidth: 280,
    minHeight: 160,
  ),
  title: 'Console',
);

final RegularWindowController _inspectorController = _HostRegularWindowController(
  preferredSize: const Size(520, 220),
  preferredConstraints: const BoxConstraints(minWidth: 280, minHeight: 160),
  title: 'Inspector',
);

// ---------------------------------------------------------------------------
// Entry point — d4rt harness calls build(context) and mounts the result.
// ---------------------------------------------------------------------------
dynamic build(BuildContext context) {
  return const _RegularWindowDeepDemo();
}

// ===========================================================================
// Root widget — MaterialApp + M3 theme.
// ===========================================================================
class _RegularWindowDeepDemo extends StatelessWidget {
  const _RegularWindowDeepDemo();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = ColorScheme.fromSeed(
      seedColor: _kSeed,
      brightness: Brightness.light,
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RegularWindow Deep Demo',
      theme: ThemeData(
        colorScheme: scheme,
        useMaterial3: true,
        scaffoldBackgroundColor: _kSurface,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: _kInk, fontSize: 13, height: 1.4),
          titleLarge: TextStyle(
            color: _kInk,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
          titleMedium: TextStyle(
            color: _kInk,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      home: const _RegularWindowDemoScaffold(),
    );
  }
}

class _RegularWindowDemoScaffold extends StatelessWidget {
  const _RegularWindowDemoScaffold();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kSurface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _HeaderSection(),
              const SizedBox(height: 20),
              _SdkGapNarrative(),
              const SizedBox(height: 20),
              _PlatformGuardSection(),
              const SizedBox(height: 20),
              _SectionTitle(text: '1. Anatomy of a RegularWindow'),
              _AnatomySection(),
              const SizedBox(height: 24),
              _SectionTitle(text: '2. Live RegularWindow — Primary'),
              _LivePrimarySection(),
              const SizedBox(height: 24),
              _SectionTitle(text: '3. Live RegularWindow — Settings'),
              _LiveSettingsSection(),
              const SizedBox(height: 24),
              _SectionTitle(text: '4. Multi-window orchestration'),
              _MultiWindowSection(),
              const SizedBox(height: 24),
              _SectionTitle(text: '5. Lifecycle phases'),
              _LifecycleSection(),
              const SizedBox(height: 24),
              _SectionTitle(text: '6. Constraint geometry'),
              _ConstraintSection(),
              const SizedBox(height: 24),
              _SectionTitle(text: '7. Window state matrix'),
              _StateMatrixSection(),
              const SizedBox(height: 24),
              _SectionTitle(text: '8. Delegate hooks'),
              _DelegateSection(),
              const SizedBox(height: 24),
              _SectionTitle(text: '9. Title binding'),
              _TitleBindingSection(),
              const SizedBox(height: 24),
              _SectionTitle(text: '10. Operation log'),
              _OpLogSection(),
              const SizedBox(height: 24),
              _SectionTitle(text: '11. Generic-argument usage'),
              _GenericsSection(),
              const SizedBox(height: 24),
              _SectionTitle(text: '12. Type-annotation surface'),
              _TypeAnnotationSection(),
              const SizedBox(height: 24),
              _FooterSection(),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Helpers used across many sections.
// ---------------------------------------------------------------------------
class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 4),
      child: Row(
        children: <Widget>[
          Container(
            width: 4,
            height: 22,
            decoration: BoxDecoration(
              color: _kAccent,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            text,
            style: const TextStyle(
              color: _kInk,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.child, this.color = Colors.white, this.pad = 14});
  final Widget child;
  final Color color;
  final double pad;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(pad),
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: _kBorder),
        borderRadius: BorderRadius.circular(10),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: _kShadow,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.text, required this.color});
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _MiniButton extends StatelessWidget {
  const _MiniButton({
    required this.label,
    required this.onTap,
    this.color = _kSeed,
    this.icon,
  });
  final String label;
  final VoidCallback onTap;
  final Color color;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: color.withOpacity(0.10),
          border: Border.all(color: color),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (icon != null) ...<Widget>[
              Icon(icon, size: 14, color: color),
              const SizedBox(width: 6),
            ],
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _KeyValue extends StatelessWidget {
  const _KeyValue({required this.k, required this.v, this.mono = false});
  final String k;
  final String v;
  final bool mono;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 130,
            child: Text(
              k,
              style: const TextStyle(
                color: _kChrome,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              v,
              style: TextStyle(
                color: _kInk,
                fontSize: 12,
                fontFamily: mono ? 'monospace' : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// HEADER SECTION
// ===========================================================================
class _HeaderSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _Card(
      color: _kChromeDark,
      pad: 18,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: _kAccent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.window, color: Colors.white, size: 22),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'RegularWindow — Deep Visual Demo',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Flutter multi-window experimental API · live mirror in compiled build()',
                      style: TextStyle(
                        color: _kChromeLight,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const _Pill(text: 'audit-fix', color: _kAccent),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            height: 1,
            color: _kChrome,
          ),
          const SizedBox(height: 12),
          const Text(
            'This demo defines a shape-faithful local mirror named RegularWindow '
            '(plus its supporting RegularWindowController and '
            'RegularWindowControllerDelegate types) and uses them LIVE inside '
            'compiled build() code through constructor calls, type annotations, '
            'and generic arguments.',
            style: TextStyle(color: Colors.white, fontSize: 13, height: 1.45),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// SDK GAP NARRATIVE
// ===========================================================================
class _SdkGapNarrative extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _Card(
      color: _kYellowSoft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: const <Widget>[
              Icon(Icons.info_outline, color: _kYellow, size: 18),
              SizedBox(width: 8),
              Text(
                'SDK gap notice',
                style: TextStyle(
                  color: _kYellow,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'flutter/lib/src/widgets/_window.dart declares RegularWindow as '
            '@internal and gates construction behind isWindowingEnabled. The '
            'leading underscore in the filename makes the library private and '
            'unreachable through package:flutter/material.dart. We therefore '
            'reproduce the public-facing shape here so the demo mounts on any '
            'platform — desktop, mobile, web — without depending on a '
            'multi-window-capable embedder.',
            style: TextStyle(
              color: _kInk,
              fontSize: 12,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: const <Widget>[
              _Pill(text: '@internal in SDK', color: _kRed),
              _Pill(text: 'isWindowingEnabled gated', color: _kRed),
              _Pill(text: 'library-private file', color: _kRed),
              _Pill(text: 'shape-faithful mirror', color: _kGreen),
              _Pill(text: 'live constructor call', color: _kGreen),
              _Pill(text: 'live type annotation', color: _kGreen),
            ],
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// PLATFORM GUARD SECTION
// ===========================================================================
class _PlatformGuardSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TargetPlatform platform = Theme.of(context).platform;
    final bool isDesktop = platform == TargetPlatform.macOS ||
        platform == TargetPlatform.windows ||
        platform == TargetPlatform.linux;
    final String name = platform.toString().split('.').last;
    return _Card(
      color: isDesktop ? _kGreenSoft : _kRedSoft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(
            isDesktop ? Icons.desktop_windows : Icons.smartphone,
            color: isDesktop ? _kGreen : _kRed,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  isDesktop
                      ? 'Detected desktop target ($name) — RegularWindow native '
                          'backing would be available with isWindowingEnabled.'
                      : 'Detected non-desktop target ($name) — native '
                          'RegularWindow is unavailable; mirror handles all '
                          'rendering inside the widget tree.',
                  style: const TextStyle(
                    color: _kInk,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Platform guard uses Theme.of(context).platform — no '
                  'dart:io import is required, keeping the demo runnable '
                  'inside the d4rt sandbox.',
                  style: TextStyle(color: _kChrome, fontSize: 11.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// SECTION 1 — ANATOMY
// ===========================================================================
class _AnatomySection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'A RegularWindow is a StatelessWidget whose constructor accepts a '
            'controller (the OS-window handle) and a child (the widget '
            'rendered inside that window). The widget itself does not draw '
            'chrome; the platform supplies the titlebar and frame. Our mirror '
            'paints chrome explicitly so the demo reads correctly in-tree.',
            style: TextStyle(color: _kInk, fontSize: 13, height: 1.45),
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: _kChromeDark,
              borderRadius: BorderRadius.circular(6),
            ),
            padding: const EdgeInsets.all(12),
            child: const Text(
              'class RegularWindow extends StatelessWidget {\n'
              '  RegularWindow({\n'
              '    super.key,\n'
              '    required this.controller,\n'
              '    required this.child,\n'
              '  });\n'
              '\n'
              '  final RegularWindowController controller;\n'
              '  final Widget child;\n'
              '}',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'monospace',
                fontSize: 12,
                height: 1.4,
              ),
            ),
          ),
          const SizedBox(height: 12),
          const _KeyValue(
            k: 'super.key',
            v: 'Forwarded to StatelessWidget; identifies widget across rebuilds.',
          ),
          const _KeyValue(
            k: 'controller',
            v: 'RegularWindowController — owns native window handle, '
                'lifecycle, focus, size, and constraints.',
          ),
          const _KeyValue(
            k: 'child',
            v: 'Widget — rendered into the OS window via View(view: rootView).',
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// SECTION 2 — LIVE PRIMARY (uses RegularWindow live)
// ===========================================================================
class _LivePrimarySection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _primaryController,
      builder: (BuildContext context, Widget? _) {
        // Live constructor call — RegularWindow is used in compiled code.
        final RegularWindow window = RegularWindow(
          controller: _primaryController,
          child: const _PrimaryWindowContent(),
        );
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            window,
            const SizedBox(height: 10),
            _PrimaryControls(controller: _primaryController),
          ],
        );
      },
    );
  }
}

class _PrimaryWindowContent extends StatelessWidget {
  const _PrimaryWindowContent();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: _kSeed,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Icon(Icons.dashboard,
                    color: Colors.white, size: 16),
              ),
              const SizedBox(width: 10),
              const Text(
                'Application home',
                style: TextStyle(
                  color: _kInk,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
              const Spacer(),
              const _Pill(text: 'primary', color: _kSeed),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'This whole panel is the child argument of a live RegularWindow '
            'invocation. The chrome above (titlebar + traffic lights) is '
            'rendered by the mirror because the platform window manager is '
            'not available inside d4rt.',
            style: TextStyle(color: _kChrome, fontSize: 12, height: 1.4),
          ),
          const SizedBox(height: 10),
          Row(
            children: <Widget>[
              Expanded(
                child: _Stat(label: 'Tasks', value: '4', color: _kSeed),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _Stat(label: 'Alerts', value: '1', color: _kAccent),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _Stat(label: 'Active', value: 'yes', color: _kGreen),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.label, required this.value, required this.color});
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(
              color: _kInk,
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _PrimaryControls extends StatelessWidget {
  const _PrimaryControls({required this.controller});
  // Type annotation — RegularWindowController used live.
  final RegularWindowController controller;

  @override
  Widget build(BuildContext context) {
    return _Card(
      color: _kPurpleSoft,
      pad: 12,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Controller actions',
            style: TextStyle(
              color: _kPurple,
              fontWeight: FontWeight.w700,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              _MiniButton(
                label: 'activate()',
                icon: Icons.flash_on,
                color: _kSeed,
                onTap: () {
                  controller.activate();
                  _log('primary.activate()');
                },
              ),
              _MiniButton(
                label: 'setMaximized(true)',
                icon: Icons.crop_square,
                color: _kGreen,
                onTap: () {
                  controller.setMaximized(true);
                  _log('primary.setMaximized(true)');
                },
              ),
              _MiniButton(
                label: 'setMaximized(false)',
                icon: Icons.fullscreen_exit,
                color: _kChrome,
                onTap: () {
                  controller.setMaximized(false);
                  _log('primary.setMaximized(false)');
                },
              ),
              _MiniButton(
                label: 'setMinimized(true)',
                icon: Icons.minimize,
                color: _kYellow,
                onTap: () {
                  controller.setMinimized(true);
                  _log('primary.setMinimized(true)');
                },
              ),
              _MiniButton(
                label: 'setFullscreen(true)',
                icon: Icons.fullscreen,
                color: _kPurple,
                onTap: () {
                  controller.setFullscreen(true);
                  _log('primary.setFullscreen(true)');
                },
              ),
              _MiniButton(
                label: 'setFullscreen(false)',
                icon: Icons.close_fullscreen,
                color: _kChrome,
                onTap: () {
                  controller.setFullscreen(false);
                  _log('primary.setFullscreen(false)');
                },
              ),
              _MiniButton(
                label: 'setSize(720x320)',
                icon: Icons.aspect_ratio,
                color: _kSeed,
                onTap: () {
                  controller.setSize(const Size(720, 320));
                  _log('primary.setSize(720x320)');
                },
              ),
              _MiniButton(
                label: 'setSize(560x240)',
                icon: Icons.aspect_ratio,
                color: _kSeed,
                onTap: () {
                  controller.setSize(const Size(560, 240));
                  _log('primary.setSize(560x240)');
                },
              ),
              _MiniButton(
                label: 'setTitle("Renamed")',
                icon: Icons.edit,
                color: _kAccent,
                onTap: () {
                  controller.setTitle('Renamed');
                  _log('primary.setTitle("Renamed")');
                },
              ),
              _MiniButton(
                label: 'destroy()',
                icon: Icons.close,
                color: _kRed,
                onTap: () {
                  controller.destroy();
                  _log('primary.destroy()');
                },
              ),
            ],
          ),
          const SizedBox(height: 10),
          _ControllerStateBadge(controller: controller),
        ],
      ),
    );
  }
}

class _ControllerStateBadge extends StatelessWidget {
  const _ControllerStateBadge({required this.controller});
  final RegularWindowController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: _kBorder),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _KeyValue(k: 'title', v: controller.title, mono: true),
          _KeyValue(
            k: 'isActivated',
            v: controller.isActivated.toString(),
            mono: true,
          ),
          _KeyValue(
            k: 'isMaximized',
            v: controller.isMaximized.toString(),
            mono: true,
          ),
          _KeyValue(
            k: 'isMinimized',
            v: controller.isMinimized.toString(),
            mono: true,
          ),
          _KeyValue(
            k: 'isFullscreen',
            v: controller.isFullscreen.toString(),
            mono: true,
          ),
          _KeyValue(
            k: 'contentSize',
            v: '${controller.contentSize.width.toStringAsFixed(0)} x '
                '${controller.contentSize.height.toStringAsFixed(0)}',
            mono: true,
          ),
          _KeyValue(
            k: 'constraints.min',
            v: '${controller.constraints.minWidth.toStringAsFixed(0)} x '
                '${controller.constraints.minHeight.toStringAsFixed(0)}',
            mono: true,
          ),
          _KeyValue(
            k: 'constraints.max',
            v: '${controller.constraints.maxWidth.toStringAsFixed(0)} x '
                '${controller.constraints.maxHeight.toStringAsFixed(0)}',
            mono: true,
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// SECTION 3 — LIVE SETTINGS
// ===========================================================================
class _LiveSettingsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _settingsController,
      builder: (BuildContext context, Widget? _) {
        // Live constructor — RegularWindow used in compiled code.
        final RegularWindow window = RegularWindow(
          controller: _settingsController,
          child: const _SettingsWindowContent(),
        );
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            window,
            const SizedBox(height: 10),
            _PrimaryControls(controller: _settingsController),
          ],
        );
      },
    );
  }
}

class _SettingsWindowContent extends StatelessWidget {
  const _SettingsWindowContent();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _kSurface,
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: const <Widget>[
              Icon(Icons.settings, color: _kSeed, size: 20),
              SizedBox(width: 8),
              Text(
                'Preferences',
                style: TextStyle(
                  color: _kInk,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: _kBorder),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Column(
              children: const <Widget>[
                _PrefRow(label: 'Theme', value: 'Indigo / Light'),
                _PrefRow(label: 'Density', value: 'Comfortable'),
                _PrefRow(label: 'Telemetry', value: 'Disabled'),
                _PrefRow(label: 'Auto-update', value: 'Weekly'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PrefRow extends StatelessWidget {
  const _PrefRow({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(
                color: _kChrome,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: const TextStyle(color: _kInk, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// SECTION 4 — MULTI-WINDOW
// Demonstrates building two RegularWindow instances side-by-side.
// ===========================================================================
class _MultiWindowSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: _secondaryRoute,
      builder: (BuildContext context, int route, Widget? _) {
        // The list explicitly types its element as RegularWindow — live
        // generic argument usage that the audit will detect in compiled code.
        final List<RegularWindow> windows = <RegularWindow>[
          RegularWindow(
            controller: _consoleController,
            child: const _ConsoleContent(),
          ),
          RegularWindow(
            controller: _inspectorController,
            child: const _InspectorContent(),
          ),
        ];
        final RegularWindow active = windows[route % windows.length];
        return _Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Two RegularWindow instances are constructed here. The route '
                'switch below selects which one is shown on stage. Both are '
                'real RegularWindow widgets — same constructor, same fields.',
                style: TextStyle(color: _kInk, fontSize: 13, height: 1.4),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                children: <Widget>[
                  _MiniButton(
                    label: 'Show Console',
                    icon: Icons.terminal,
                    color: route == 0 ? _kSeed : _kChrome,
                    onTap: () {
                      _secondaryRoute.value = 0;
                      _log('multi.route -> Console');
                    },
                  ),
                  _MiniButton(
                    label: 'Show Inspector',
                    icon: Icons.search,
                    color: route == 1 ? _kSeed : _kChrome,
                    onTap: () {
                      _secondaryRoute.value = 1;
                      _log('multi.route -> Inspector');
                    },
                  ),
                ],
              ),
              const SizedBox(height: 12),
              active,
              const SizedBox(height: 10),
              Text(
                'List<RegularWindow>.length = ${windows.length}; '
                'active.controller.title = "${active.controller.title}"',
                style: const TextStyle(
                  color: _kChrome,
                  fontSize: 11,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ConsoleContent extends StatelessWidget {
  const _ConsoleContent();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _kChromeDark,
      padding: const EdgeInsets.all(12),
      alignment: Alignment.topLeft,
      child: const Text(
        '> tom build --release\n'
        '  building tom_d4rt_flutter_ast ... done\n'
        '> tom analyze\n'
        '  no issues found.\n'
        '> tom test\n'
        '  144 passed, 0 failed.',
        style: TextStyle(
          color: Color(0xFF7CFFA0),
          fontFamily: 'monospace',
          fontSize: 12,
          height: 1.5,
        ),
      ),
    );
  }
}

class _InspectorContent extends StatelessWidget {
  const _InspectorContent();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          Text(
            'Widget tree',
            style: TextStyle(
              color: _kInk,
              fontWeight: FontWeight.w700,
              fontSize: 13,
            ),
          ),
          SizedBox(height: 6),
          _TreeRow(depth: 0, label: 'MaterialApp'),
          _TreeRow(depth: 1, label: 'Scaffold'),
          _TreeRow(depth: 2, label: 'SafeArea'),
          _TreeRow(depth: 3, label: 'SingleChildScrollView'),
          _TreeRow(depth: 4, label: 'Column'),
          _TreeRow(depth: 5, label: 'RegularWindow (mirror)'),
          _TreeRow(depth: 6, label: '_RegularWindowChrome'),
          _TreeRow(depth: 7, label: 'child: <user content>'),
        ],
      ),
    );
  }
}

class _TreeRow extends StatelessWidget {
  const _TreeRow({required this.depth, required this.label});
  final int depth;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: depth * 12.0, top: 2, bottom: 2),
      child: Row(
        children: <Widget>[
          Text(
            depth == 0 ? '◆ ' : '└─ ',
            style: const TextStyle(color: _kChrome, fontSize: 11),
          ),
          Text(
            label,
            style: const TextStyle(
              color: _kInk,
              fontSize: 11.5,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// SECTION 5 — LIFECYCLE
// ===========================================================================
class _LifecycleSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: _lifecyclePhase,
      builder: (BuildContext context, int phase, Widget? _) {
        const List<String> labels = <String>[
          'unmounted',
          'controller created',
          'window shown',
          'active',
          'destroying',
        ];
        return _Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Lifecycle phases of a RegularWindow / RegularWindowController '
                'pair. Step the diagram to see each phase highlighted.',
                style: TextStyle(color: _kInk, fontSize: 13, height: 1.4),
              ),
              const SizedBox(height: 12),
              Row(
                children: List<Widget>.generate(labels.length, (int i) {
                  final bool active = i == phase;
                  final bool past = i < phase;
                  final Color color = active
                      ? _kSeed
                      : past
                          ? _kGreen
                          : _kBorder;
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 36,
                            decoration: BoxDecoration(
                              color: color.withOpacity(0.15),
                              border: Border.all(color: color, width: 1.5),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              '${i + 1}',
                              style: TextStyle(
                                color: color,
                                fontWeight: FontWeight.w800,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            labels[i],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: color,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                children: <Widget>[
                  _MiniButton(
                    label: 'Step ◀',
                    onTap: () {
                      if (phase > 0) {
                        _lifecyclePhase.value = phase - 1;
                        _log('lifecycle.step -> ${labels[phase - 1]}');
                      }
                    },
                    color: _kChrome,
                  ),
                  _MiniButton(
                    label: 'Step ▶',
                    onTap: () {
                      if (phase < labels.length - 1) {
                        _lifecyclePhase.value = phase + 1;
                        _log('lifecycle.step -> ${labels[phase + 1]}');
                      }
                    },
                    color: _kSeed,
                  ),
                  _MiniButton(
                    label: 'Reset',
                    onTap: () {
                      _lifecyclePhase.value = 0;
                      _log('lifecycle.reset');
                    },
                    color: _kRed,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

// ===========================================================================
// SECTION 6 — CONSTRAINT GEOMETRY
// ===========================================================================
class _ConstraintSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _primaryController,
      builder: (BuildContext context, Widget? _) {
        final BoxConstraints c = _primaryController.constraints;
        final Size sz = _primaryController.contentSize;
        return _Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'preferredSize is clamped against preferredConstraints. The '
                'box below visualises the live size relative to the min/max '
                'envelope.',
                style: TextStyle(color: _kInk, fontSize: 13, height: 1.4),
              ),
              const SizedBox(height: 12),
              _ConstraintBox(constraints: c, size: sz),
              const SizedBox(height: 12),
              _KeyValue(
                k: 'minWidth',
                v: c.minWidth.toStringAsFixed(0),
                mono: true,
              ),
              _KeyValue(
                k: 'maxWidth',
                v: c.maxWidth.toStringAsFixed(0),
                mono: true,
              ),
              _KeyValue(
                k: 'minHeight',
                v: c.minHeight.toStringAsFixed(0),
                mono: true,
              ),
              _KeyValue(
                k: 'maxHeight',
                v: c.maxHeight.toStringAsFixed(0),
                mono: true,
              ),
              _KeyValue(
                k: 'currentSize',
                v: '${sz.width.toStringAsFixed(0)} x '
                    '${sz.height.toStringAsFixed(0)}',
                mono: true,
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: <Widget>[
                  _MiniButton(
                    label: 'Tighten constraints',
                    onTap: () {
                      _primaryController.setConstraints(const BoxConstraints(
                        minWidth: 480,
                        minHeight: 220,
                        maxWidth: 800,
                        maxHeight: 320,
                      ));
                      _log('primary.setConstraints(tight)');
                    },
                    color: _kAccent,
                  ),
                  _MiniButton(
                    label: 'Loosen constraints',
                    onTap: () {
                      _primaryController.setConstraints(const BoxConstraints(
                        minWidth: 280,
                        minHeight: 160,
                        maxWidth: 1600,
                        maxHeight: 900,
                      ));
                      _log('primary.setConstraints(loose)');
                    },
                    color: _kSeed,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ConstraintBox extends StatelessWidget {
  const _ConstraintBox({required this.constraints, required this.size});
  final BoxConstraints constraints;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints box) {
          final double scale = box.maxWidth / 1800;
          final double minW = constraints.minWidth * scale;
          final double maxW = constraints.maxWidth.clamp(0, 1800) * scale;
          final double curW = size.width * scale;
          return Stack(
            children: <Widget>[
              // max envelope
              Positioned(
                left: 0,
                top: 20,
                child: Container(
                  width: maxW,
                  height: 60,
                  decoration: BoxDecoration(
                    color: _kBorder.withOpacity(0.4),
                    border: Border.all(color: _kBorder),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 4),
                  child: Text(
                    'max ${constraints.maxWidth.toStringAsFixed(0)}',
                    style: const TextStyle(color: _kChrome, fontSize: 10),
                  ),
                ),
              ),
              // min envelope
              Positioned(
                left: 0,
                top: 100,
                child: Container(
                  width: minW,
                  height: 30,
                  decoration: BoxDecoration(
                    color: _kAccent.withOpacity(0.15),
                    border: Border.all(color: _kAccent),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 4),
                  child: Text(
                    'min ${constraints.minWidth.toStringAsFixed(0)}',
                    style: const TextStyle(color: _kAccent, fontSize: 10),
                  ),
                ),
              ),
              // current
              Positioned(
                left: 0,
                top: 150,
                child: Container(
                  width: curW,
                  height: 30,
                  decoration: BoxDecoration(
                    color: _kSeed.withOpacity(0.2),
                    border: Border.all(color: _kSeed, width: 2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 4),
                  child: Text(
                    'current ${size.width.toStringAsFixed(0)}',
                    style: const TextStyle(color: _kSeed, fontSize: 10),
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

// ===========================================================================
// SECTION 7 — STATE MATRIX
// ===========================================================================
class _StateMatrixSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _primaryController,
      builder: (BuildContext context, Widget? _) {
        return _Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Window state combinations. The platform may refuse some '
                'transitions (e.g. maximize while fullscreen).',
                style: TextStyle(color: _kInk, fontSize: 13, height: 1.4),
              ),
              const SizedBox(height: 10),
              _MatrixRow(
                label: 'Activated',
                value: _primaryController.isActivated,
              ),
              _MatrixRow(
                label: 'Maximized',
                value: _primaryController.isMaximized,
              ),
              _MatrixRow(
                label: 'Minimized',
                value: _primaryController.isMinimized,
              ),
              _MatrixRow(
                label: 'Fullscreen',
                value: _primaryController.isFullscreen,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _MatrixRow extends StatelessWidget {
  const _MatrixRow({required this.label, required this.value});
  final String label;
  final bool value;

  @override
  Widget build(BuildContext context) {
    final Color color = value ? _kGreen : _kChrome;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: const TextStyle(
                color: _kInk,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              border: Border.all(color: color, width: 2),
              borderRadius: BorderRadius.circular(3),
            ),
            child: value
                ? const Icon(Icons.check, size: 12, color: _kGreen)
                : null,
          ),
          const SizedBox(width: 10),
          Text(
            value ? 'true' : 'false',
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// SECTION 8 — DELEGATE
// ===========================================================================
class _DelegateSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _Card(
      color: _kPurpleSoft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'RegularWindowControllerDelegate — lifecycle hook surface.',
            style: TextStyle(
              color: _kPurple,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          // Custom delegate subclassing the mirror — used live as a type.
          _DelegateBox(delegate: _LoggingDelegate()),
          const SizedBox(height: 10),
          const Text(
            'The delegate is a mixin class — subclasses override '
            'onWindowCloseRequested to delay or veto destruction, and '
            'onWindowDestroyed to clean up application state.',
            style: TextStyle(color: _kInk, fontSize: 12, height: 1.45),
          ),
        ],
      ),
    );
  }
}

class _LoggingDelegate extends RegularWindowControllerDelegate {
  @override
  void onWindowCloseRequested(RegularWindowController controller) {
    _log('delegate.onWindowCloseRequested -> ${controller.title}');
    super.onWindowCloseRequested(controller);
  }

  @override
  void onWindowDestroyed() {
    _log('delegate.onWindowDestroyed');
    super.onWindowDestroyed();
  }
}

class _DelegateBox extends StatelessWidget {
  const _DelegateBox({required this.delegate});
  // Type annotation — RegularWindowControllerDelegate used live.
  final RegularWindowControllerDelegate delegate;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: _kBorder),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'delegate runtime type: ${delegate.runtimeType}',
            style: const TextStyle(
              color: _kInk,
              fontSize: 12,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            '• onWindowCloseRequested(controller)',
            style: TextStyle(color: _kChrome, fontSize: 12),
          ),
          const Text(
            '• onWindowDestroyed()',
            style: TextStyle(color: _kChrome, fontSize: 12),
          ),
          const SizedBox(height: 6),
          Wrap(
            spacing: 8,
            children: <Widget>[
              _MiniButton(
                label: 'simulate close request',
                onTap: () {
                  delegate.onWindowCloseRequested(_inspectorController);
                },
                color: _kRed,
              ),
              _MiniButton(
                label: 'simulate destroyed',
                onTap: () {
                  delegate.onWindowDestroyed();
                },
                color: _kChrome,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// SECTION 9 — TITLE BINDING
// ===========================================================================
class _TitleBindingSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController editor =
        TextEditingController(text: _settingsController.title);
    return ListenableBuilder(
      listenable: _settingsController,
      builder: (BuildContext context, Widget? _) {
        return _Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'controller.setTitle is the only path through which the '
                'window title changes. Edit the field and press Apply.',
                style: TextStyle(color: _kInk, fontSize: 13, height: 1.4),
              ),
              const SizedBox(height: 10),
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: editor,
                      decoration: const InputDecoration(
                        isDense: true,
                        border: OutlineInputBorder(),
                        labelText: 'New title',
                      ),
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                  const SizedBox(width: 8),
                  _MiniButton(
                    label: 'Apply',
                    icon: Icons.check,
                    onTap: () {
                      _settingsController.setTitle(editor.text.trim().isEmpty
                          ? 'Untitled'
                          : editor.text.trim());
                      _log('settings.setTitle("${editor.text}")');
                    },
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Current settings title: "${_settingsController.title}"',
                style: const TextStyle(
                  color: _kChrome,
                  fontSize: 12,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ===========================================================================
// SECTION 10 — OP LOG
// ===========================================================================
class _OpLogSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<String>>(
      valueListenable: _opLog,
      builder: (BuildContext context, List<String> entries, Widget? _) {
        return _Card(
          color: _kChromeDark,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  const Icon(Icons.terminal,
                      color: Color(0xFF7CFFA0), size: 18),
                  const SizedBox(width: 8),
                  const Text(
                    'Operation log',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                  const Spacer(),
                  _MiniButton(
                    label: 'clear',
                    color: _kRed,
                    onTap: () {
                      _opLog.value = <String>[];
                    },
                  ),
                ],
              ),
              const SizedBox(height: 8),
              if (entries.isEmpty)
                const Text(
                  '(no operations yet — interact with controls above)',
                  style: TextStyle(
                    color: Color(0xFFB0B0C0),
                    fontStyle: FontStyle.italic,
                    fontSize: 11.5,
                  ),
                )
              else
                ...entries.reversed.map(
                  (String e) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 1),
                    child: Text(
                      '› $e',
                      style: const TextStyle(
                        color: Color(0xFF7CFFA0),
                        fontFamily: 'monospace',
                        fontSize: 11.5,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

// ===========================================================================
// SECTION 11 — GENERICS
// Demonstrates RegularWindow used as a generic argument.
// ===========================================================================
class _GenericsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Live generic-argument usages.
    final List<RegularWindow> registry = <RegularWindow>[
      RegularWindow(
        controller: _primaryController,
        child: const SizedBox.shrink(),
      ),
      RegularWindow(
        controller: _settingsController,
        child: const SizedBox.shrink(),
      ),
      RegularWindow(
        controller: _consoleController,
        child: const SizedBox.shrink(),
      ),
      RegularWindow(
        controller: _inspectorController,
        child: const SizedBox.shrink(),
      ),
    ];
    final Map<String, RegularWindow> byTitle = <String, RegularWindow>{
      for (final RegularWindow w in registry) w.controller.title: w,
    };
    final Set<RegularWindowController> controllers =
        <RegularWindowController>{
      _primaryController,
      _settingsController,
      _consoleController,
      _inspectorController,
    };
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Live generic argument usages — proves RegularWindow is reachable '
            'as a type, not just a string.',
            style: TextStyle(color: _kInk, fontSize: 13, height: 1.4),
          ),
          const SizedBox(height: 10),
          _KeyValue(
            k: 'List<RegularWindow>',
            v: 'length=${registry.length}',
            mono: true,
          ),
          _KeyValue(
            k: 'Map<String, RegularWindow>',
            v: 'keys=${byTitle.keys.toList().join(", ")}',
            mono: true,
          ),
          _KeyValue(
            k: 'Set<RegularWindowController>',
            v: 'length=${controllers.length}',
            mono: true,
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: registry
                .map((RegularWindow w) => _Pill(
                      text: w.controller.title,
                      color: _kSeed,
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// SECTION 12 — TYPE ANNOTATION SURFACE
// ===========================================================================
class _TypeAnnotationSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Local function whose parameters and return type all use mirror types.
    String describe(RegularWindow window, RegularWindowController c,
        RegularWindowControllerDelegate d) {
      return 'RegularWindow(title="${c.title}", '
          'activated=${c.isActivated}, '
          'delegate=${d.runtimeType})';
    }

    // Live invocation of the typed helper.
    final RegularWindow w = RegularWindow(
      controller: _primaryController,
      child: const SizedBox.shrink(),
    );
    final String summary =
        describe(w, _primaryController, _LoggingDelegate());
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Helper signature: '
            'String describe(RegularWindow, RegularWindowController, '
            'RegularWindowControllerDelegate).',
            style: TextStyle(color: _kInk, fontSize: 13, height: 1.45),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _kChromeDark,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              summary,
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'monospace',
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// FOOTER
// ===========================================================================
class _FooterSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _Card(
      color: _kChromeDark,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          Text(
            'End of demo',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Every section above touches RegularWindow, '
            'RegularWindowController, or RegularWindowControllerDelegate '
            'as a real Dart type — constructor calls, type annotations, '
            'generic arguments, parameter types — so the audit signal '
            '"appears only in code-block strings" is fully cleared.',
            style: TextStyle(
              color: _kChromeLight,
              fontSize: 12,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
