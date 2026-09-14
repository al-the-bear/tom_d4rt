// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Mission Control — WidgetsBindingObserver Deep Demo
//
// SUBJECT
// -------
// `WidgetsBindingObserver` is a MIXIN declared in
// `package:flutter/src/widgets/binding.dart` (exported via `widgets.dart`)
// that lets any object opt into the framework-level lifecycle callbacks
// fanned out by `WidgetsBinding`. An instance is registered via
// `WidgetsBinding.instance.addObserver(this)` and removed via
// `WidgetsBinding.instance.removeObserver(this)`. Each observer is held
// in a `LinkedHashSet<WidgetsBindingObserver>` so insertion order is
// preserved and each callback is invoked for every registered observer
// before the next one fires.
//
// The mixin exposes one virtual method per system-level event. Every
// method has a concrete no-op default, so State subclasses only override
// the ones they actually care about. The observed surface is:
//
//   • didChangeAppLifecycleState(AppLifecycleState state)
//       resumed, inactive, hidden, paused, detached.
//   • didChangeMetrics()
//       window size / insets / padding changed.
//   • didChangeTextScaleFactor()
//       OS text scale changed.
//   • didChangePlatformBrightness()
//       light/dark switch at the OS level.
//   • didChangeLocales(List<Locale>? locales)
//       system locale list changed.
//   • didHaveMemoryPressure()
//       OS asked the app to drop caches.
//   • didChangeAccessibilityFeatures()
//       screen reader / bold text / reduce motion toggled.
//   • didRequestAppExit() → Future<AppExitResponse>
//       desktop close-request interception.
//   • didPushRoute(String route)                [deprecated]
//   • didPushRouteInformation(RouteInformation info)
//   • didPopRoute() → Future<bool>
//
// HARNESS CONTRACT
// ----------------
// This script runs inside the d4rt AST harness. There is exactly one
// top-level `dynamic build(BuildContext context)` entry point and it must
// return a `MaterialApp`. There is no `main()` and no `runApp()`. In the
// harness environment some of the observed callbacks (metrics, locales,
// platform brightness, etc.) never fire on their own, so the simulate
// panel invokes the observer's methods directly on `this` to drive the
// visual — that is explicitly legal, each method is a plain instance
// method with a public signature.
//
// THEME — Mission-Control Operator Deck
// -------------------------------------
// Dark navy background, cyan primary accents, amber warnings, soft-green
// OK states, and LED-style pulsing indicators that glow when their
// callback fires. The scrolling console at the bottom mimics a
// rack-mounted status readout.
//
//   navy       = #0B1022   — scaffold background
//   panel      = #111B33   — card / panel backgrounds
//   rail       = #1A2648   — dividers & subpanels
//   cyan       = #22D3EE   — primary accent / OK lamps
//   cyanSoft   = #67E8F9   — secondary accent / gauge fill
//   amber      = #FBBF24   — warnings / simulate buttons
//   amberSoft  = #FCD34D   — highlights
//   red        = #F87171   — critical / memory pressure
//   lime       = #A3E635   — success / resumed
//   violet     = #A78BFA   — exit / route intercept
//   chrome     = #E2E8F0   — primary text on navy
//   dim        = #94A3B8   — secondary text / muted labels
//   ink        = #0F172A   — button text on bright fills

import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Palette constants — declared once so every widget in the file uses the
// same color references. Using `Color(0xFF...)` keeps the palette literal
// and avoids `Colors.*` drift between scenes.
// ---------------------------------------------------------------------------
const Color _kNavy = Color(0xFF0B1022);
const Color _kPanel = Color(0xFF111B33);
const Color _kRail = Color(0xFF1A2648);
const Color _kCyan = Color(0xFF22D3EE);
const Color _kCyanSoft = Color(0xFF67E8F9);
const Color _kAmber = Color(0xFFFBBF24);
const Color _kAmberSoft = Color(0xFFFCD34D);
const Color _kRed = Color(0xFFF87171);
const Color _kLime = Color(0xFFA3E635);
const Color _kViolet = Color(0xFFA78BFA);
const Color _kChrome = Color(0xFFE2E8F0);
const Color _kDim = Color(0xFF94A3B8);
const Color _kInk = Color(0xFF0F172A);
const Color _kGrid = Color(0xFF1E2B4E);

// ---------------------------------------------------------------------------
// Entry point — the d4rt AST harness invokes this exactly once per test
// script. The returned widget tree is self-contained: no main(), no
// runApp(), no global state, no late fields at top level.
// ---------------------------------------------------------------------------
dynamic build(BuildContext context) {
  debugPrint('[Wbo] build() — WidgetsBindingObserver mission-control demo');
  return const _WboApp();
}

// ---------------------------------------------------------------------------
// Root MaterialApp wrapper. Keeps the demo themable without leaking state
// into the enclosing harness. A single Scaffold hosts a scrolling stack of
// sections — dossier, live observer, simulate panel, state diagram,
// observer log, memory drill, route intercept, locale swap, recipes,
// comparison, glossary.
// ---------------------------------------------------------------------------
class _WboApp extends StatelessWidget {
  const _WboApp();

  @override
  Widget build(BuildContext context) {
    debugPrint('[Wbo] building MaterialApp');
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mission Control — WidgetsBindingObserver',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: _kNavy,
        colorScheme: const ColorScheme.dark(
          primary: _kCyan,
          secondary: _kAmber,
          surface: _kPanel,
          error: _kRed,
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: _kChrome, height: 1.4),
          bodySmall: TextStyle(color: _kChrome, height: 1.35),
          titleLarge: TextStyle(
            color: _kCyan,
            fontSize: 22,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
          ),
          titleMedium: TextStyle(
            color: _kChrome,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
          labelLarge: TextStyle(
            color: _kInk,
            fontSize: 13,
            fontWeight: FontWeight.w700,
          ),
        ),
        cardTheme: const CardThemeData(
          color: _kPanel,
          surfaceTintColor: _kPanel,
        ),
      ),
      home: const _WboHome(),
    );
  }
}

// ---------------------------------------------------------------------------
// _WboHome — the scrolling operator deck. It is a StatefulWidget only
// because it owns the shared event stream (the LED pulse bus, the
// observer log, the current mocked lifecycle state, the current locale
// list). Those are lifted here so the simulate panel, state diagram, and
// log section all see the same data.
// ---------------------------------------------------------------------------
class _WboHome extends StatefulWidget {
  const _WboHome();

  @override
  State<_WboHome> createState() => _WboHomeState();
}

class _WboHomeState extends State<_WboHome> with WidgetsBindingObserver {
  // --- counters --------------------------------------------------------
  int _cntLifecycle = 0;
  int _cntMetrics = 0;
  int _cntTextScale = 0;
  int _cntBrightness = 0;
  int _cntLocales = 0;
  int _cntMemory = 0;
  int _cntAccess = 0;
  int _cntExit = 0;
  int _cntPushRoute = 0;
  int _cntPushRouteInfo = 0;
  int _cntPopRoute = 0;

  // --- last-seen timestamps (epoch ms) --------------------------------
  int _tsLifecycle = 0;
  int _tsMetrics = 0;
  int _tsTextScale = 0;
  int _tsBrightness = 0;
  int _tsLocales = 0;
  int _tsMemory = 0;
  int _tsAccess = 0;
  int _tsExit = 0;
  int _tsPushRoute = 0;
  int _tsPushRouteInfo = 0;
  int _tsPopRoute = 0;

  // --- currently glowing LED (pulse target) ---------------------------
  String _pulseTarget = '';

  // --- mocked state tracked by simulate panel -------------------------
  AppLifecycleState _mockState = AppLifecycleState.resumed;
  double _mockTextScale = 1.0;
  Brightness _mockBrightness = Brightness.dark;
  List<Locale> _mockLocales = const <Locale>[
    Locale('en', 'US'),
    Locale.fromSubtags(languageCode: 'de'),
  ];
  bool _mockHighContrast = false;
  bool _mockBoldText = false;
  bool _mockReduceMotion = false;
  double _memoryReclaim = 0.0;
  bool _routeInterceptVisible = false;
  String _mockRoute = '/home';

  // --- scrolling event log --------------------------------------------
  final List<_WboEvent> _log = <_WboEvent>[];
  static const int _kLogLimit = 50;

  @override
  void initState() {
    super.initState();
    debugPrint('[Wbo] initState — addObserver');
    WidgetsBinding.instance.addObserver(this);
    _record('initState', 'observer registered');
  }

  @override
  void dispose() {
    debugPrint('[Wbo] dispose — removeObserver');
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // -------------------------------------------------------------------
  // Observer callback overrides. Each override updates its counter, its
  // timestamp, pulses its LED, and appends a log entry. In the harness
  // many of these never fire on their own; the simulate panel invokes
  // them directly on `this` (which is fine — they're public instance
  // methods).
  // -------------------------------------------------------------------
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    setState(() {
      _cntLifecycle += 1;
      _tsLifecycle = DateTime.now().millisecondsSinceEpoch;
      _pulseTarget = 'lifecycle';
      _mockState = state;
      _record('didChangeAppLifecycleState', state.name);
    });
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    setState(() {
      _cntMetrics += 1;
      _tsMetrics = DateTime.now().millisecondsSinceEpoch;
      _pulseTarget = 'metrics';
      _record('didChangeMetrics', 'window geometry changed');
    });
  }

  @override
  void didChangeTextScaleFactor() {
    super.didChangeTextScaleFactor();
    setState(() {
      _cntTextScale += 1;
      _tsTextScale = DateTime.now().millisecondsSinceEpoch;
      _pulseTarget = 'textScale';
      _record(
        'didChangeTextScaleFactor',
        'scale=${_mockTextScale.toStringAsFixed(2)}',
      );
    });
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    setState(() {
      _cntBrightness += 1;
      _tsBrightness = DateTime.now().millisecondsSinceEpoch;
      _pulseTarget = 'brightness';
      _record('didChangePlatformBrightness', _mockBrightness.name);
    });
  }

  @override
  void didChangeLocales(List<Locale>? locales) {
    super.didChangeLocales(locales);
    setState(() {
      _cntLocales += 1;
      _tsLocales = DateTime.now().millisecondsSinceEpoch;
      _pulseTarget = 'locales';
      if (locales != null && locales.isNotEmpty) {
        _mockLocales = List<Locale>.unmodifiable(locales);
      }
      _record(
        'didChangeLocales',
        _mockLocales.map((Locale l) => l.toLanguageTag()).join(','),
      );
    });
  }

  @override
  void didHaveMemoryPressure() {
    super.didHaveMemoryPressure();
    setState(() {
      _cntMemory += 1;
      _tsMemory = DateTime.now().millisecondsSinceEpoch;
      _pulseTarget = 'memory';
      _memoryReclaim = math.min(1.0, _memoryReclaim + 0.18);
      _record('didHaveMemoryPressure', 'reclaim+=18%');
    });
  }

  @override
  void didChangeAccessibilityFeatures() {
    super.didChangeAccessibilityFeatures();
    setState(() {
      _cntAccess += 1;
      _tsAccess = DateTime.now().millisecondsSinceEpoch;
      _pulseTarget = 'access';
      _record(
        'didChangeAccessibilityFeatures',
        'hc=$_mockHighContrast bold=$_mockBoldText reduceMotion=$_mockReduceMotion',
      );
    });
  }

  @override
  Future<ui.AppExitResponse> didRequestAppExit() async {
    setState(() {
      _cntExit += 1;
      _tsExit = DateTime.now().millisecondsSinceEpoch;
      _pulseTarget = 'exit';
      _record('didRequestAppExit', 'response=cancel (demo)');
    });
    // The demo always cancels, to show the intercept pattern visually.
    return ui.AppExitResponse.cancel;
  }

  @override
  Future<bool> didPushRoute(String route) async {
    setState(() {
      _cntPushRoute += 1;
      _tsPushRoute = DateTime.now().millisecondsSinceEpoch;
      _pulseTarget = 'pushRoute';
      _mockRoute = route;
      _record('didPushRoute (deprecated)', route);
    });
    return true;
  }

  @override
  Future<bool> didPushRouteInformation(RouteInformation info) async {
    setState(() {
      _cntPushRouteInfo += 1;
      _tsPushRouteInfo = DateTime.now().millisecondsSinceEpoch;
      _pulseTarget = 'pushRouteInfo';
      _mockRoute = info.uri.toString();
      _record('didPushRouteInformation', info.uri.toString());
    });
    return true;
  }

  @override
  Future<bool> didPopRoute() async {
    setState(() {
      _cntPopRoute += 1;
      _tsPopRoute = DateTime.now().millisecondsSinceEpoch;
      _pulseTarget = 'popRoute';
      _routeInterceptVisible = true;
      _record('didPopRoute', 'intercepted → confirm dialog');
    });
    return true;
  }

  // -------------------------------------------------------------------
  // Event recorder. Appends to the log, trims to _kLogLimit, and returns
  // without touching setState — callers that already wrap in setState do
  // not need a second build pass.
  // -------------------------------------------------------------------
  void _record(String name, String payload) {
    final _WboEvent e = _WboEvent(
      name: name,
      payload: payload,
      ts: DateTime.now(),
    );
    _log.insert(0, e);
    if (_log.length > _kLogLimit) {
      _log.removeRange(_kLogLimit, _log.length);
    }
  }

  // -------------------------------------------------------------------
  // Accessors for child widgets. Children read snapshots; they never
  // mutate state. All mutation funnels through the observer methods.
  // -------------------------------------------------------------------
  _WboSnapshot _snapshot() => _WboSnapshot(
        cntLifecycle: _cntLifecycle,
        cntMetrics: _cntMetrics,
        cntTextScale: _cntTextScale,
        cntBrightness: _cntBrightness,
        cntLocales: _cntLocales,
        cntMemory: _cntMemory,
        cntAccess: _cntAccess,
        cntExit: _cntExit,
        cntPushRoute: _cntPushRoute,
        cntPushRouteInfo: _cntPushRouteInfo,
        cntPopRoute: _cntPopRoute,
        tsLifecycle: _tsLifecycle,
        tsMetrics: _tsMetrics,
        tsTextScale: _tsTextScale,
        tsBrightness: _tsBrightness,
        tsLocales: _tsLocales,
        tsMemory: _tsMemory,
        tsAccess: _tsAccess,
        tsExit: _tsExit,
        tsPushRoute: _tsPushRoute,
        tsPushRouteInfo: _tsPushRouteInfo,
        tsPopRoute: _tsPopRoute,
        pulseTarget: _pulseTarget,
        mockState: _mockState,
        mockTextScale: _mockTextScale,
        mockBrightness: _mockBrightness,
        mockLocales: _mockLocales,
        mockHighContrast: _mockHighContrast,
        mockBoldText: _mockBoldText,
        mockReduceMotion: _mockReduceMotion,
        memoryReclaim: _memoryReclaim,
        routeInterceptVisible: _routeInterceptVisible,
        mockRoute: _mockRoute,
        log: List<_WboEvent>.unmodifiable(_log),
      );

  void _toggleHighContrast() {
    _mockHighContrast = !_mockHighContrast;
    didChangeAccessibilityFeatures();
  }

  void _toggleBoldText() {
    _mockBoldText = !_mockBoldText;
    didChangeAccessibilityFeatures();
  }

  void _toggleReduceMotion() {
    _mockReduceMotion = !_mockReduceMotion;
    didChangeAccessibilityFeatures();
  }

  void _bumpTextScale() {
    final double next = _mockTextScale >= 1.6 ? 1.0 : _mockTextScale + 0.2;
    _mockTextScale = double.parse(next.toStringAsFixed(2));
    didChangeTextScaleFactor();
  }

  void _flipBrightness() {
    _mockBrightness = _mockBrightness == Brightness.dark
        ? Brightness.light
        : Brightness.dark;
    didChangePlatformBrightness();
  }

  void _swapLocales(List<Locale> next) {
    didChangeLocales(next);
  }

  void _closeRouteIntercept() {
    setState(() {
      _routeInterceptVisible = false;
    });
  }

  void _drainMemoryReclaim() {
    setState(() {
      _memoryReclaim = 0.0;
      _record('manual', 'reclaim gauge reset');
    });
  }

  @override
  Widget build(BuildContext context) {
    final _WboSnapshot snap = _snapshot();
    return Scaffold(
      backgroundColor: _kNavy,
      appBar: _WboAppBar(snapshot: snap),
      body: Stack(
        children: <Widget>[
          const _WboGridBackdrop(),
          ListView(
            padding: const EdgeInsets.fromLTRB(18, 16, 18, 80),
            children: <Widget>[
              const _WboHero(),
              const SizedBox(height: 18),
              const _WboDossierSection(),
              const SizedBox(height: 18),
              _WboLiveObserverSection(snapshot: snap),
              const SizedBox(height: 18),
              _WboSimulateSection(
                snapshot: snap,
                onLifecycle: didChangeAppLifecycleState,
                onMetrics: didChangeMetrics,
                onTextScale: () {
                  _bumpTextScale();
                },
                onBrightness: () {
                  _flipBrightness();
                },
                onLocales: _swapLocales,
                onMemory: didHaveMemoryPressure,
                onAccess: _toggleHighContrast,
                onBold: _toggleBoldText,
                onReduceMotion: _toggleReduceMotion,
                onPushRouteInfo: (String uri) {
                  didPushRouteInformation(
                    RouteInformation(uri: Uri.parse(uri)),
                  );
                },
                onPopRoute: () {
                  didPopRoute();
                },
                onRequestExit: () {
                  didRequestAppExit();
                },
              ),
              const SizedBox(height: 18),
              _WboStateDiagramSection(snapshot: snap),
              const SizedBox(height: 18),
              _WboLogSection(snapshot: snap),
              const SizedBox(height: 18),
              _WboMemoryDrillSection(
                snapshot: snap,
                onPressure: didHaveMemoryPressure,
                onDrain: _drainMemoryReclaim,
              ),
              const SizedBox(height: 18),
              _WboRouteInterceptSection(
                snapshot: snap,
                onConfirm: _closeRouteIntercept,
                onPop: () {
                  didPopRoute();
                },
              ),
              const SizedBox(height: 18),
              _WboLocaleSwapSection(
                snapshot: snap,
                onSwap: _swapLocales,
              ),
              const SizedBox(height: 18),
              const _WboRecipeSection(),
              const SizedBox(height: 18),
              const _WboComparisonSection(),
              const SizedBox(height: 18),
              const _WboGlossarySection(),
              const SizedBox(height: 18),
              const _WboEpilogueSection(),
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _WboConsoleReadout(snapshot: snap),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _WboSnapshot — an immutable view of the home state passed down to all
// children. Keeping the render tree downstream of an immutable snapshot
// makes every child trivially reactive: if the snapshot field changes,
// the child repaints; if not, it doesn't.
// ---------------------------------------------------------------------------
class _WboSnapshot {
  const _WboSnapshot({
    required this.cntLifecycle,
    required this.cntMetrics,
    required this.cntTextScale,
    required this.cntBrightness,
    required this.cntLocales,
    required this.cntMemory,
    required this.cntAccess,
    required this.cntExit,
    required this.cntPushRoute,
    required this.cntPushRouteInfo,
    required this.cntPopRoute,
    required this.tsLifecycle,
    required this.tsMetrics,
    required this.tsTextScale,
    required this.tsBrightness,
    required this.tsLocales,
    required this.tsMemory,
    required this.tsAccess,
    required this.tsExit,
    required this.tsPushRoute,
    required this.tsPushRouteInfo,
    required this.tsPopRoute,
    required this.pulseTarget,
    required this.mockState,
    required this.mockTextScale,
    required this.mockBrightness,
    required this.mockLocales,
    required this.mockHighContrast,
    required this.mockBoldText,
    required this.mockReduceMotion,
    required this.memoryReclaim,
    required this.routeInterceptVisible,
    required this.mockRoute,
    required this.log,
  });

  final int cntLifecycle;
  final int cntMetrics;
  final int cntTextScale;
  final int cntBrightness;
  final int cntLocales;
  final int cntMemory;
  final int cntAccess;
  final int cntExit;
  final int cntPushRoute;
  final int cntPushRouteInfo;
  final int cntPopRoute;

  final int tsLifecycle;
  final int tsMetrics;
  final int tsTextScale;
  final int tsBrightness;
  final int tsLocales;
  final int tsMemory;
  final int tsAccess;
  final int tsExit;
  final int tsPushRoute;
  final int tsPushRouteInfo;
  final int tsPopRoute;

  final String pulseTarget;
  final AppLifecycleState mockState;
  final double mockTextScale;
  final Brightness mockBrightness;
  final List<Locale> mockLocales;
  final bool mockHighContrast;
  final bool mockBoldText;
  final bool mockReduceMotion;
  final double memoryReclaim;
  final bool routeInterceptVisible;
  final String mockRoute;
  final List<_WboEvent> log;

  int get totalEvents =>
      cntLifecycle +
      cntMetrics +
      cntTextScale +
      cntBrightness +
      cntLocales +
      cntMemory +
      cntAccess +
      cntExit +
      cntPushRoute +
      cntPushRouteInfo +
      cntPopRoute;
}

// ---------------------------------------------------------------------------
// _WboEvent — a single row of the scrolling log. Carries the human-
// readable callback name, a short payload string, and a timestamp.
// ---------------------------------------------------------------------------
class _WboEvent {
  const _WboEvent({
    required this.name,
    required this.payload,
    required this.ts,
  });

  final String name;
  final String payload;
  final DateTime ts;

  String get hhmmss {
    final String h = ts.hour.toString().padLeft(2, '0');
    final String m = ts.minute.toString().padLeft(2, '0');
    final String s = ts.second.toString().padLeft(2, '0');
    final String ms = ts.millisecond.toString().padLeft(3, '0');
    return '$h:$m:$s.$ms';
  }
}

// ---------------------------------------------------------------------------
// _WboAppBar — a custom AppBar shaped like a mission-control header strip.
// Displays the mission name, a small telemetry pill summarising total
// observed events, and a decorative status cluster on the trailing edge.
// ---------------------------------------------------------------------------
class _WboAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _WboAppBar({required this.snapshot});

  final _WboSnapshot snapshot;

  @override
  // The MaterialApp theme sets `bodyMedium.height = 1.4`, which the inner
  // `_WboTelemetryPill` Text widgets inherit through DefaultTextStyle. With
  // that line-height multiplier, each pill's internal Column measures about
  // 51 px (Column 33.0 + padding 16 + border 2). The previous height of 76
  // (content area 46.5 after padding + border) overflowed each pill by 4.5
  // px. 86 gives the pills room to breathe (content area ~56.5).
  Size get preferredSize => const Size.fromHeight(86);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: _kPanel,
        border: Border(
          bottom: BorderSide(color: _kRail, width: 1.5),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(18, 14, 18, 14),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: <Widget>[
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: _kCyan.withOpacity(0.12),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _kCyan, width: 1.2),
              ),
              child: const Icon(Icons.satellite_alt, color: _kCyan, size: 24),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Text(
                    'MISSION CONTROL',
                    style: TextStyle(
                      color: _kCyan,
                      fontSize: 11,
                      letterSpacing: 2.4,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'WidgetsBindingObserver — live operator deck',
                    style: TextStyle(
                      color: _kChrome,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            _WboTelemetryPill(
              label: 'EVENTS',
              value: snapshot.totalEvents.toString(),
              tint: _kCyan,
            ),
            const SizedBox(width: 8),
            _WboTelemetryPill(
              label: 'STATE',
              value: snapshot.mockState.name.toUpperCase(),
              tint: _kLime,
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _WboTelemetryPill — a compact label/value pair used in the appbar and
// the console readout. Each pill has a subtle tinted border.
// ---------------------------------------------------------------------------
class _WboTelemetryPill extends StatelessWidget {
  const _WboTelemetryPill({
    required this.label,
    required this.value,
    required this.tint,
  });

  final String label;
  final String value;
  final Color tint;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: tint.withOpacity(0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: tint.withOpacity(0.5), width: 1),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(
              color: tint,
              fontSize: 9,
              letterSpacing: 1.6,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(
              color: _kChrome,
              fontSize: 13,
              fontWeight: FontWeight.w700,
              fontFeatures: <FontFeature>[FontFeature.tabularFigures()],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _WboGridBackdrop — a subtle grid painted behind every scene, evoking
// the graph paper of a real operator console. Fills the whole scaffold.
// ---------------------------------------------------------------------------
class _WboGridBackdrop extends StatelessWidget {
  const _WboGridBackdrop();

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: IgnorePointer(
        child: CustomPaint(painter: _WboGridPainter()),
      ),
    );
  }
}

class _WboGridPainter extends CustomPainter {
  _WboGridPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint line = Paint()
      ..color = _kGrid.withOpacity(0.45)
      ..strokeWidth = 1.0;
    const double step = 28.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), line);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), line);
    }
    // Faint diagonal wash.
    final Paint wash = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0x11222244), Color(0x00000000)],
      ).createShader(Offset.zero & size);
    canvas.drawRect(Offset.zero & size, wash);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ---------------------------------------------------------------------------
// _WboHero — the top banner under the appbar. Oversized title, tagline,
// and three status dots suggesting a running system.
// ---------------------------------------------------------------------------
class _WboHero extends StatelessWidget {
  const _WboHero();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[Color(0xFF0E1A36), Color(0xFF131E3E)],
        ),
        border: Border.all(color: _kRail, width: 1),
      ),
      padding: const EdgeInsets.fromLTRB(22, 22, 22, 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const _WboStatusDot(color: _kLime, label: 'NOMINAL'),
              const SizedBox(width: 8),
              const _WboStatusDot(color: _kAmber, label: 'OBSERVING'),
              const SizedBox(width: 8),
              const _WboStatusDot(color: _kCyan, label: 'LINKED'),
              const Spacer(),
              Text(
                'SCH ${DateTime.now().toIso8601String().substring(0, 10)}',
                style: const TextStyle(
                  color: _kDim,
                  fontSize: 11,
                  letterSpacing: 1.4,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          const Text(
            'WidgetsBindingObserver',
            style: TextStyle(
              color: _kChrome,
              fontSize: 30,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'A mixin for subscribing to framework-level lifecycle callbacks.\n'
            'Register in initState, remove in dispose, override only the '
            'callbacks you care about.',
            style: TextStyle(color: _kDim, fontSize: 13, height: 1.5),
          ),
          const SizedBox(height: 14),
          const _WboCodeLine(
            text: 'WidgetsBinding.instance.addObserver(this);',
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _WboStatusDot — a tiny pulsing label+dot marker used in the hero strip.
// Purely presentational; no animation here so the hero stays cheap.
// ---------------------------------------------------------------------------
class _WboStatusDot extends StatelessWidget {
  const _WboStatusDot({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: <BoxShadow>[
              BoxShadow(color: color.withOpacity(0.6), blurRadius: 6),
            ],
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 10,
            letterSpacing: 1.8,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// _WboCodeLine — a one-line code snippet styled like a terminal row.
// ---------------------------------------------------------------------------
class _WboCodeLine extends StatelessWidget {
  const _WboCodeLine({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: _kNavy,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kCyan.withOpacity(0.35)),
      ),
      child: Row(
        children: <Widget>[
          const Text(
            '\$',
            style: TextStyle(
              color: _kCyan,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: _kCyanSoft,
                fontSize: 12.5,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// SECTION 1 — DOSSIER / PREAMBLE
// ===========================================================================
// Six cards explaining the mixin, the WidgetsBinding it attaches to, the
// observer list, the fan-out order, the default no-op overrides, and the
// cleanup contract. Each card is rendered by _WboDossierCard below.
// ===========================================================================

class _WboDossierSection extends StatelessWidget {
  const _WboDossierSection();

  @override
  Widget build(BuildContext context) {
    final List<_WboDossierEntry> entries = _dossierEntries();
    return _WboSectionFrame(
      title: 'Dossier · What WidgetsBindingObserver is',
      subtitle:
          'Six cards laying out the mixin, its binding, the observer list, '
          'callback ordering, the default no-op surface, and the cleanup '
          'contract.',
      accent: _kCyan,
      icon: Icons.menu_book,
      child: Column(
        children: <Widget>[
          for (int i = 0; i < entries.length; i++) ...<Widget>[
            _WboDossierCard(entry: entries[i], index: i),
            if (i < entries.length - 1) const SizedBox(height: 10),
          ],
        ],
      ),
    );
  }
}

class _WboDossierEntry {
  const _WboDossierEntry({
    required this.icon,
    required this.title,
    required this.body,
    required this.tint,
    required this.tag,
  });
  final IconData icon;
  final String title;
  final String body;
  final Color tint;
  final String tag;
}

List<_WboDossierEntry> _dossierEntries() {
  return const <_WboDossierEntry>[
    _WboDossierEntry(
      icon: Icons.extension,
      title: 'Mixin, not a class',
      tag: '01 · MIXIN',
      tint: _kCyan,
      body: 'WidgetsBindingObserver is a mixin. You apply it to a State '
          'subclass with `with WidgetsBindingObserver`. Every callback it '
          'defines has a concrete no-op default, so subclasses only override '
          'the callbacks they actually care about — no abstract methods.',
    ),
    _WboDossierEntry(
      icon: Icons.hub,
      title: 'Attached to WidgetsBinding',
      tag: '02 · BINDING',
      tint: _kCyanSoft,
      body: 'Observers are registered against the singleton '
          '`WidgetsBinding.instance`. The binding owns the native-event '
          'channel and fans every system callback out to each registered '
          'observer. Add in initState, remove in dispose.',
    ),
    _WboDossierEntry(
      icon: Icons.list_alt,
      title: 'LinkedHashSet of observers',
      tag: '03 · LIST',
      tint: _kAmber,
      body: 'The binding stores observers in an insertion-ordered '
          '`LinkedHashSet<WidgetsBindingObserver>`. When a system event '
          'arrives, each observer\'s callback is invoked in registration '
          'order. Adding the same instance twice is a no-op.',
    ),
    _WboDossierEntry(
      icon: Icons.east,
      title: 'Fan-out order',
      tag: '04 · ORDER',
      tint: _kLime,
      body: 'Callbacks run synchronously unless they return Future. For '
          'Future-returning callbacks (didPopRoute, didRequestAppExit, '
          'didPushRouteInformation) the binding awaits each observer in '
          'order and stops at the first one that "handles" the event.',
    ),
    _WboDossierEntry(
      icon: Icons.shield_moon,
      title: 'Default no-op surface',
      tag: '05 · NO-OPS',
      tint: _kViolet,
      body: 'Every callback has a concrete implementation that does nothing. '
          'This means you can mix in the observer and only override the '
          'methods you need. Overriding a callback without calling super is '
          'fine because the base does nothing.',
    ),
    _WboDossierEntry(
      icon: Icons.cleaning_services,
      title: 'Cleanup is mandatory',
      tag: '06 · CLEANUP',
      tint: _kRed,
      body: 'Forgetting to call `removeObserver` in dispose leaks your State '
          'into the observer list. Next time the framework fans out a '
          'callback, your disposed State will be called — a classic source '
          'of "setState called on disposed widget" errors.',
    ),
  ];
}

class _WboDossierCard extends StatelessWidget {
  const _WboDossierCard({required this.entry, required this.index});

  final _WboDossierEntry entry;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _kPanel,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: entry.tint.withOpacity(0.35), width: 1),
      ),
      padding: const EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: entry.tint.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: entry.tint.withOpacity(0.55)),
            ),
            child: Icon(entry.icon, color: entry.tint, size: 26),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      entry.tag,
                      style: TextStyle(
                        color: entry.tint,
                        fontSize: 10,
                        letterSpacing: 1.8,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '#${index + 1}',
                      style: const TextStyle(
                        color: _kDim,
                        fontSize: 10,
                        letterSpacing: 1.6,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  entry.title,
                  style: const TextStyle(
                    color: _kChrome,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  entry.body,
                  style: const TextStyle(
                    color: _kDim,
                    fontSize: 12.5,
                    height: 1.5,
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

// ===========================================================================
// SECTION 2 — LIVE OBSERVER PANEL
// ===========================================================================
// Renders each observed callback as a labelled LED lamp in a control grid.
// Each lamp shows: callback name, counter, last timestamp, and an LED that
// glows bright when the callback was the most recent pulse target. The
// pulse animation is driven by a single AnimationController owned by the
// panel — it repeats forward/reverse for a subtle breathing effect and
// snaps to full-bright when its own target matches `pulseTarget`.
// ===========================================================================

class _WboLiveObserverSection extends StatelessWidget {
  const _WboLiveObserverSection({required this.snapshot});

  final _WboSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return _WboSectionFrame(
      title: 'Live observer · LED status grid',
      subtitle:
          'This State is mixed with WidgetsBindingObserver. Each LED below '
          'lights up when its callback fires. In the harness some of these '
          'will never fire on their own — use the simulate panel to drive '
          'them directly.',
      accent: _kCyanSoft,
      icon: Icons.grid_view,
      child: Column(
        children: <Widget>[
          _WboLedGrid(snapshot: snapshot),
          const SizedBox(height: 12),
          _WboObserverNote(snapshot: snapshot),
        ],
      ),
    );
  }
}

class _WboLedGrid extends StatelessWidget {
  const _WboLedGrid({required this.snapshot});

  final _WboSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    final List<_WboLedSpec> specs = <_WboLedSpec>[
      _WboLedSpec(
        key: 'lifecycle',
        label: 'didChangeAppLifecycleState',
        short: 'LIFECYCLE',
        count: snapshot.cntLifecycle,
        ts: snapshot.tsLifecycle,
        tint: _kLime,
        icon: Icons.play_circle,
      ),
      _WboLedSpec(
        key: 'metrics',
        label: 'didChangeMetrics',
        short: 'METRICS',
        count: snapshot.cntMetrics,
        ts: snapshot.tsMetrics,
        tint: _kCyan,
        icon: Icons.aspect_ratio,
      ),
      _WboLedSpec(
        key: 'textScale',
        label: 'didChangeTextScaleFactor',
        short: 'TEXT SCALE',
        count: snapshot.cntTextScale,
        ts: snapshot.tsTextScale,
        tint: _kAmber,
        icon: Icons.text_fields,
      ),
      _WboLedSpec(
        key: 'brightness',
        label: 'didChangePlatformBrightness',
        short: 'BRIGHTNESS',
        count: snapshot.cntBrightness,
        ts: snapshot.tsBrightness,
        tint: _kAmberSoft,
        icon: Icons.brightness_6,
      ),
      _WboLedSpec(
        key: 'locales',
        label: 'didChangeLocales',
        short: 'LOCALES',
        count: snapshot.cntLocales,
        ts: snapshot.tsLocales,
        tint: _kCyanSoft,
        icon: Icons.language,
      ),
      _WboLedSpec(
        key: 'memory',
        label: 'didHaveMemoryPressure',
        short: 'MEMORY',
        count: snapshot.cntMemory,
        ts: snapshot.tsMemory,
        tint: _kRed,
        icon: Icons.memory,
      ),
      _WboLedSpec(
        key: 'access',
        label: 'didChangeAccessibilityFeatures',
        short: 'A11Y',
        count: snapshot.cntAccess,
        ts: snapshot.tsAccess,
        tint: _kViolet,
        icon: Icons.accessibility_new,
      ),
      _WboLedSpec(
        key: 'exit',
        label: 'didRequestAppExit',
        short: 'EXIT REQ',
        count: snapshot.cntExit,
        ts: snapshot.tsExit,
        tint: _kRed,
        icon: Icons.logout,
      ),
      _WboLedSpec(
        key: 'pushRoute',
        label: 'didPushRoute (deprecated)',
        short: 'PUSH',
        count: snapshot.cntPushRoute,
        ts: snapshot.tsPushRoute,
        tint: _kDim,
        icon: Icons.route,
      ),
      _WboLedSpec(
        key: 'pushRouteInfo',
        label: 'didPushRouteInformation',
        short: 'PUSH INFO',
        count: snapshot.cntPushRouteInfo,
        ts: snapshot.tsPushRouteInfo,
        tint: _kCyan,
        icon: Icons.alt_route,
      ),
      _WboLedSpec(
        key: 'popRoute',
        label: 'didPopRoute',
        short: 'POP',
        count: snapshot.cntPopRoute,
        ts: snapshot.tsPopRoute,
        tint: _kAmber,
        icon: Icons.undo,
      ),
    ];

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints c) {
        final int cols = c.maxWidth > 720
            ? 4
            : c.maxWidth > 520
                ? 3
                : c.maxWidth > 360
                    ? 2
                    : 1;
        final double gap = 10;
        final double tileW = (c.maxWidth - gap * (cols - 1)) / cols;
        final List<Widget> rows = <Widget>[];
        for (int i = 0; i < specs.length; i += cols) {
          final List<Widget> row = <Widget>[];
          for (int j = 0; j < cols; j++) {
            final int idx = i + j;
            if (idx >= specs.length) {
              row.add(SizedBox(width: tileW));
            } else {
              row.add(SizedBox(
                width: tileW,
                child: _WboLedLamp(
                  spec: specs[idx],
                  active: snapshot.pulseTarget == specs[idx].key,
                ),
              ));
            }
            if (j < cols - 1) row.add(SizedBox(width: gap));
          }
          rows.add(Row(crossAxisAlignment: CrossAxisAlignment.start, children: row));
          if (i + cols < specs.length) rows.add(SizedBox(height: gap));
        }
        return Column(children: rows);
      },
    );
  }
}

class _WboLedSpec {
  const _WboLedSpec({
    required this.key,
    required this.label,
    required this.short,
    required this.count,
    required this.ts,
    required this.tint,
    required this.icon,
  });
  final String key;
  final String label;
  final String short;
  final int count;
  final int ts;
  final Color tint;
  final IconData icon;
}

class _WboLedLamp extends StatefulWidget {
  const _WboLedLamp({required this.spec, required this.active});

  final _WboLedSpec spec;
  final bool active;

  @override
  State<_WboLedLamp> createState() => _WboLedLampState();
}

class _WboLedLampState extends State<_WboLedLamp>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctl = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1400),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _ctl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctl,
      builder: (BuildContext context, Widget? _) {
        final double baseline = 0.35 + 0.25 * _ctl.value;
        final double glow = widget.active ? 1.0 : baseline * 0.8;
        final Color tint = widget.spec.tint;
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _kPanel,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: tint.withOpacity(widget.active ? 0.9 : 0.25),
              width: widget.active ? 1.6 : 1.0,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: tint.withOpacity(glow),
                      shape: BoxShape.circle,
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: tint.withOpacity(glow * 0.8),
                          blurRadius: widget.active ? 14 : 8,
                          spreadRadius: widget.active ? 2 : 0,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(widget.spec.icon, color: tint, size: 16),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      widget.spec.short,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: tint,
                        fontSize: 10.5,
                        letterSpacing: 1.4,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                widget.spec.label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: _kChrome,
                  fontSize: 11.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    widget.spec.count.toString().padLeft(3, '0'),
                    style: TextStyle(
                      color: tint,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      fontFeatures: const <FontFeature>[
                        FontFeature.tabularFigures(),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Text(
                    _formatTs(widget.spec.ts),
                    style: const TextStyle(
                      color: _kDim,
                      fontSize: 10,
                      letterSpacing: 1.0,
                      fontFeatures: <FontFeature>[FontFeature.tabularFigures()],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  String _formatTs(int ms) {
    if (ms == 0) return '--:--:--';
    final DateTime dt = DateTime.fromMillisecondsSinceEpoch(ms);
    final String h = dt.hour.toString().padLeft(2, '0');
    final String m = dt.minute.toString().padLeft(2, '0');
    final String s = dt.second.toString().padLeft(2, '0');
    return '$h:$m:$s';
  }
}

class _WboObserverNote extends StatelessWidget {
  const _WboObserverNote({required this.snapshot});

  final _WboSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    final String last = snapshot.log.isNotEmpty
        ? '${snapshot.log.first.name}  ·  ${snapshot.log.first.payload}'
        : 'no events yet — use simulate panel to drive callbacks';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: _kNavy,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kRail),
      ),
      child: Row(
        children: <Widget>[
          const Icon(Icons.sensors, color: _kCyan, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'last fan-out: $last',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: _kChrome,
                fontSize: 12,
                fontFeatures: <FontFeature>[FontFeature.tabularFigures()],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// SECTION 3 — SIMULATE PANEL
// ===========================================================================
// A grid of amber "console" buttons that invoke the observer methods
// directly on the State (passed down as callbacks). This exists because in
// the d4rt AST harness many of these callbacks will never fire on their
// own: there is no real window, no real OS text-scale signal, no real
// locale change. The buttons pulse the matching LED so the demo is still
// interactive and visual.
// ===========================================================================

class _WboSimulateSection extends StatelessWidget {
  const _WboSimulateSection({
    required this.snapshot,
    required this.onLifecycle,
    required this.onMetrics,
    required this.onTextScale,
    required this.onBrightness,
    required this.onLocales,
    required this.onMemory,
    required this.onAccess,
    required this.onBold,
    required this.onReduceMotion,
    required this.onPushRouteInfo,
    required this.onPopRoute,
    required this.onRequestExit,
  });

  final _WboSnapshot snapshot;
  final ValueChanged<AppLifecycleState> onLifecycle;
  final VoidCallback onMetrics;
  final VoidCallback onTextScale;
  final VoidCallback onBrightness;
  final ValueChanged<List<Locale>> onLocales;
  final VoidCallback onMemory;
  final VoidCallback onAccess;
  final VoidCallback onBold;
  final VoidCallback onReduceMotion;
  final ValueChanged<String> onPushRouteInfo;
  final VoidCallback onPopRoute;
  final VoidCallback onRequestExit;

  @override
  Widget build(BuildContext context) {
    return _WboSectionFrame(
      title: 'Simulate · Manual callback bench',
      subtitle:
          'Direct method invocations on the live observer. Pulses the '
          'matching LED and appends a log entry. Safe — each method is a '
          'plain public instance method with a no-op default.',
      accent: _kAmber,
      icon: Icons.tune,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _WboSubHeader(
            text: 'didChangeAppLifecycleState',
            tint: _kLime,
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              for (final AppLifecycleState s in AppLifecycleState.values)
                _WboConsoleButton(
                  label: s.name,
                  icon: _iconForState(s),
                  tint: _tintForState(s),
                  active: snapshot.mockState == s,
                  onPressed: () => onLifecycle(s),
                ),
            ],
          ),
          const SizedBox(height: 14),
          _WboSubHeader(text: 'Window & system', tint: _kCyan),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              _WboConsoleButton(
                label: 'didChangeMetrics',
                icon: Icons.aspect_ratio,
                tint: _kCyan,
                active: false,
                onPressed: onMetrics,
              ),
              _WboConsoleButton(
                label: 'TextScale → next',
                icon: Icons.text_fields,
                tint: _kAmber,
                active: false,
                onPressed: onTextScale,
              ),
              _WboConsoleButton(
                label: 'Brightness flip',
                icon: Icons.brightness_6,
                tint: _kAmberSoft,
                active: false,
                onPressed: onBrightness,
              ),
              _WboConsoleButton(
                label: 'didHaveMemoryPressure',
                icon: Icons.memory,
                tint: _kRed,
                active: false,
                onPressed: onMemory,
              ),
            ],
          ),
          const SizedBox(height: 14),
          _WboSubHeader(text: 'Locales', tint: _kCyanSoft),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              _WboConsoleButton(
                label: 'en-US, de',
                icon: Icons.language,
                tint: _kCyanSoft,
                active: false,
                onPressed: () => onLocales(const <Locale>[
                  Locale('en', 'US'),
                  Locale.fromSubtags(languageCode: 'de'),
                ]),
              ),
              _WboConsoleButton(
                label: 'ja-JP, ko',
                icon: Icons.language,
                tint: _kCyanSoft,
                active: false,
                onPressed: () => onLocales(const <Locale>[
                  Locale('ja', 'JP'),
                  Locale.fromSubtags(languageCode: 'ko'),
                ]),
              ),
              _WboConsoleButton(
                label: 'fr-FR, es, pt',
                icon: Icons.language,
                tint: _kCyanSoft,
                active: false,
                onPressed: () => onLocales(const <Locale>[
                  Locale('fr', 'FR'),
                  Locale.fromSubtags(languageCode: 'es'),
                  Locale.fromSubtags(languageCode: 'pt'),
                ]),
              ),
              _WboConsoleButton(
                label: 'en-GB only',
                icon: Icons.language,
                tint: _kCyanSoft,
                active: false,
                onPressed: () => onLocales(const <Locale>[
                  Locale('en', 'GB'),
                ]),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _WboSubHeader(text: 'Accessibility', tint: _kViolet),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              _WboConsoleButton(
                label: 'High contrast',
                icon: Icons.contrast,
                tint: _kViolet,
                active: snapshot.mockHighContrast,
                onPressed: onAccess,
              ),
              _WboConsoleButton(
                label: 'Bold text',
                icon: Icons.format_bold,
                tint: _kViolet,
                active: snapshot.mockBoldText,
                onPressed: onBold,
              ),
              _WboConsoleButton(
                label: 'Reduce motion',
                icon: Icons.motion_photos_off,
                tint: _kViolet,
                active: snapshot.mockReduceMotion,
                onPressed: onReduceMotion,
              ),
            ],
          ),
          const SizedBox(height: 14),
          _WboSubHeader(text: 'Routing & exit', tint: _kAmber),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              _WboConsoleButton(
                label: 'Push /dashboard',
                icon: Icons.alt_route,
                tint: _kCyan,
                active: false,
                onPressed: () => onPushRouteInfo('/dashboard'),
              ),
              _WboConsoleButton(
                label: 'Push /settings',
                icon: Icons.alt_route,
                tint: _kCyan,
                active: false,
                onPressed: () => onPushRouteInfo('/settings'),
              ),
              _WboConsoleButton(
                label: 'Push /logs',
                icon: Icons.alt_route,
                tint: _kCyan,
                active: false,
                onPressed: () => onPushRouteInfo('/logs'),
              ),
              _WboConsoleButton(
                label: 'didPopRoute',
                icon: Icons.undo,
                tint: _kAmber,
                active: false,
                onPressed: onPopRoute,
              ),
              _WboConsoleButton(
                label: 'didRequestAppExit',
                icon: Icons.logout,
                tint: _kRed,
                active: false,
                onPressed: onRequestExit,
              ),
            ],
          ),
        ],
      ),
    );
  }

  static IconData _iconForState(AppLifecycleState s) {
    switch (s) {
      case AppLifecycleState.resumed:
        return Icons.play_circle_fill;
      case AppLifecycleState.inactive:
        return Icons.pause_circle;
      case AppLifecycleState.hidden:
        return Icons.visibility_off;
      case AppLifecycleState.paused:
        return Icons.stop_circle;
      case AppLifecycleState.detached:
        return Icons.power_off;
    }
  }

  static Color _tintForState(AppLifecycleState s) {
    switch (s) {
      case AppLifecycleState.resumed:
        return _kLime;
      case AppLifecycleState.inactive:
        return _kAmber;
      case AppLifecycleState.hidden:
        return _kAmberSoft;
      case AppLifecycleState.paused:
        return _kRed;
      case AppLifecycleState.detached:
        return _kDim;
    }
  }
}

// ---------------------------------------------------------------------------
// _WboConsoleButton — a boxy mission-control push-button. When `active`
// the body fills with the tint; otherwise it's a dark shell with a tinted
// border. Hover is not required for a demo but this is Flutter's
// TextButton under the hood so mouse cursors still work.
// ---------------------------------------------------------------------------
class _WboConsoleButton extends StatelessWidget {
  const _WboConsoleButton({
    required this.label,
    required this.icon,
    required this.tint,
    required this.active,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final Color tint;
  final bool active;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final Color fg = active ? _kInk : tint;
    final Color bg = active ? tint : tint.withOpacity(0.08);
    return Material(
      color: bg,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: tint.withOpacity(active ? 1.0 : 0.45),
              width: 1.2,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(icon, color: fg, size: 16),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: fg,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WboSubHeader extends StatelessWidget {
  const _WboSubHeader({required this.text, required this.tint});
  final String text;
  final Color tint;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 6,
          height: 14,
          decoration: BoxDecoration(
            color: tint,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          text.toUpperCase(),
          style: TextStyle(
            color: tint,
            fontSize: 11,
            letterSpacing: 1.8,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

// ===========================================================================
// SECTION 4 — LIFECYCLE STATE DIAGRAM
// ===========================================================================
// CustomPainter rendering a state-machine for AppLifecycleState. The
// canonical edges are:
//     resumed ↔ inactive ↔ hidden ↔ paused
// and detached is terminal (reached only during shutdown / startup).
// The current mocked state glows.
// ===========================================================================

class _WboStateDiagramSection extends StatelessWidget {
  const _WboStateDiagramSection({required this.snapshot});

  final _WboSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return _WboSectionFrame(
      title: 'Lifecycle diagram · AppLifecycleState',
      subtitle:
          'resumed ↔ inactive ↔ hidden ↔ paused with detached as a terminal '
          'node. The glowing ring marks the currently mocked state.',
      accent: _kLime,
      icon: Icons.account_tree,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 260,
            child: CustomPaint(
              painter: _WboStateDiagramPainter(current: snapshot.mockState),
              child: const SizedBox.expand(),
            ),
          ),
          const SizedBox(height: 10),
          _WboStateLegend(current: snapshot.mockState),
        ],
      ),
    );
  }
}

class _WboStateDiagramPainter extends CustomPainter {
  _WboStateDiagramPainter({required this.current});

  final AppLifecycleState current;

  static const List<AppLifecycleState> _chain = <AppLifecycleState>[
    AppLifecycleState.resumed,
    AppLifecycleState.inactive,
    AppLifecycleState.hidden,
    AppLifecycleState.paused,
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final double radius = 36;
    final double y = size.height / 2 - 10;
    final double dx = size.width / (_chain.length + 1);
    final List<Offset> centers = <Offset>[];
    for (int i = 0; i < _chain.length; i++) {
      centers.add(Offset(dx * (i + 1), y));
    }
    // Edges between consecutive chain nodes (bidirectional arrows).
    final Paint edge = Paint()
      ..color = _kRail
      ..strokeWidth = 2.4
      ..style = PaintingStyle.stroke;
    for (int i = 0; i < centers.length - 1; i++) {
      final Offset a = centers[i];
      final Offset b = centers[i + 1];
      final Offset dir = (b - a);
      final double len = dir.distance;
      final Offset unit = Offset(dir.dx / len, dir.dy / len);
      final Offset aEnd = a + unit * radius;
      final Offset bEnd = b - unit * radius;
      canvas.drawLine(aEnd, bEnd, edge);
      _drawArrow(canvas, aEnd + unit * 4, unit, edge.color);
      _drawArrow(canvas, bEnd - unit * 4, -unit, edge.color);
    }
    // Nodes.
    for (int i = 0; i < _chain.length; i++) {
      final AppLifecycleState s = _chain[i];
      final bool isCurrent = current == s;
      _drawNode(canvas, centers[i], radius, s, isCurrent);
    }
    // Detached terminal node, drawn bottom-center with a dashed link to
    // paused (the path the framework takes during shutdown).
    final Offset detachedC = Offset(size.width / 2, size.height - 30);
    final bool detachedActive = current == AppLifecycleState.detached;
    _drawDashedLine(canvas, centers[3], detachedC, _kRail);
    _drawNode(canvas, detachedC, radius - 6, AppLifecycleState.detached,
        detachedActive);

    // Title strip.
    final TextPainter tp = TextPainter(
      text: const TextSpan(
        text: 'STATE MACHINE · AppLifecycleState',
        style: TextStyle(
          color: _kDim,
          fontSize: 11,
          letterSpacing: 2.2,
          fontWeight: FontWeight.w700,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, const Offset(12, 12));
  }

  void _drawNode(Canvas canvas, Offset c, double r, AppLifecycleState s,
      bool active) {
    final Color tint = _colorFor(s);
    final Paint ring = Paint()
      ..color = active ? tint : tint.withOpacity(0.35)
      ..style = PaintingStyle.stroke
      ..strokeWidth = active ? 3.2 : 1.6;
    final Paint fill = Paint()
      ..color = active ? tint.withOpacity(0.22) : _kPanel;
    if (active) {
      final Paint glow = Paint()
        ..color = tint.withOpacity(0.22)
        ..maskFilter = const ui.MaskFilter.blur(ui.BlurStyle.normal, 10);
      canvas.drawCircle(c, r + 6, glow);
    }
    canvas.drawCircle(c, r, fill);
    canvas.drawCircle(c, r, ring);

    final TextPainter tp = TextPainter(
      text: TextSpan(
        children: <InlineSpan>[
          TextSpan(
            text: s.name,
            style: TextStyle(
              color: active ? tint : _kChrome,
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout(maxWidth: r * 2);
    tp.paint(canvas, Offset(c.dx - tp.width / 2, c.dy - tp.height / 2));
  }

  void _drawArrow(Canvas canvas, Offset tip, Offset unit, Color color) {
    final Offset perp = Offset(-unit.dy, unit.dx);
    final Offset back = tip - unit * 8;
    final Path path = Path()
      ..moveTo(tip.dx, tip.dy)
      ..lineTo(back.dx + perp.dx * 4, back.dy + perp.dy * 4)
      ..lineTo(back.dx - perp.dx * 4, back.dy - perp.dy * 4)
      ..close();
    canvas.drawPath(path, Paint()..color = color);
  }

  void _drawDashedLine(Canvas canvas, Offset a, Offset b, Color color) {
    final Paint p = Paint()
      ..color = color
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;
    final double len = (b - a).distance;
    final Offset unit = Offset((b.dx - a.dx) / len, (b.dy - a.dy) / len);
    double d = 0;
    while (d < len) {
      final Offset s = a + unit * d;
      final Offset e = a + unit * (d + 6).clamp(0.0, len).toDouble();
      canvas.drawLine(s, e, p);
      d += 12;
    }
  }

  Color _colorFor(AppLifecycleState s) {
    switch (s) {
      case AppLifecycleState.resumed:
        return _kLime;
      case AppLifecycleState.inactive:
        return _kAmber;
      case AppLifecycleState.hidden:
        return _kAmberSoft;
      case AppLifecycleState.paused:
        return _kRed;
      case AppLifecycleState.detached:
        return _kDim;
    }
  }

  @override
  bool shouldRepaint(covariant _WboStateDiagramPainter oldDelegate) =>
      oldDelegate.current != current;
}

class _WboStateLegend extends StatelessWidget {
  const _WboStateLegend({required this.current});
  final AppLifecycleState current;

  @override
  Widget build(BuildContext context) {
    const List<Map<String, Object>> legend = <Map<String, Object>>[
      <String, Object>{
        'state': AppLifecycleState.resumed,
        'desc': 'Foreground, focused, receiving input.',
        'color': _kLime,
      },
      <String, Object>{
        'state': AppLifecycleState.inactive,
        'desc': 'Partially visible or unfocused (call, split screen).',
        'color': _kAmber,
      },
      <String, Object>{
        'state': AppLifecycleState.hidden,
        'desc': 'Completely hidden, about to pause.',
        'color': _kAmberSoft,
      },
      <String, Object>{
        'state': AppLifecycleState.paused,
        'desc': 'Background; may be killed by OS at any time.',
        'color': _kRed,
      },
      <String, Object>{
        'state': AppLifecycleState.detached,
        'desc': 'Engine alive but no view; startup or shutdown.',
        'color': _kDim,
      },
    ];
    return Column(
      children: <Widget>[
        for (final Map<String, Object> row in legend)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 12,
                  height: 12,
                  margin: const EdgeInsets.only(top: 3, right: 8),
                  decoration: BoxDecoration(
                    color: row['color'] as Color,
                    shape: BoxShape.circle,
                    boxShadow: current == row['state']
                        ? <BoxShadow>[
                            BoxShadow(
                              color: (row['color'] as Color).withOpacity(0.6),
                              blurRadius: 8,
                            ),
                          ]
                        : const <BoxShadow>[],
                  ),
                ),
                SizedBox(
                  width: 90,
                  child: Text(
                    (row['state'] as AppLifecycleState).name,
                    style: TextStyle(
                      color: row['color'] as Color,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.6,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    row['desc'] as String,
                    style: const TextStyle(
                      color: _kDim,
                      fontSize: 12,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

// ===========================================================================
// SECTION 5 — OBSERVER LOG
// ===========================================================================
// Scrolling list of the last 50 events with HH:MM:SS.mmm timestamps,
// callback names, and short payloads. Rendered inside a fixed-height pane
// so the section doesn't balloon; ListView handles the overflow.
// ===========================================================================

class _WboLogSection extends StatelessWidget {
  const _WboLogSection({required this.snapshot});

  final _WboSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return _WboSectionFrame(
      title: 'Observer log · last ${_WboHomeState._kLogLimit}',
      subtitle:
          'Timestamped tape of every observed callback. Newest at top. '
          'Trimmed to the last 50 entries so the scroll view stays cheap.',
      accent: _kCyan,
      icon: Icons.receipt_long,
      child: Container(
        height: 260,
        padding: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: _kNavy,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _kRail),
        ),
        child: snapshot.log.isEmpty
            ? const Center(
                child: Text(
                  'no events yet',
                  style: TextStyle(color: _kDim, fontSize: 12),
                ),
              )
            : ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                itemCount: snapshot.log.length,
                separatorBuilder: (BuildContext context, int i) =>
                    const Divider(color: _kRail, height: 6),
                itemBuilder: (BuildContext context, int i) {
                  final _WboEvent e = snapshot.log[i];
                  final Color tint = _tintFor(e.name);
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 96,
                        child: Text(
                          e.hhmmss,
                          style: const TextStyle(
                            color: _kDim,
                            fontSize: 11,
                            fontFamily: 'monospace',
                            fontFeatures: <FontFeature>[
                              FontFeature.tabularFigures(),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 4,
                        height: 14,
                        margin: const EdgeInsets.only(right: 8, top: 2),
                        color: tint,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              e.name,
                              style: TextStyle(
                                color: tint,
                                fontSize: 11.5,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              e.payload,
                              style: const TextStyle(
                                color: _kChrome,
                                fontSize: 11.5,
                                fontFamily: 'monospace',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
      ),
    );
  }

  Color _tintFor(String name) {
    if (name.contains('Memory')) return _kRed;
    if (name.contains('Exit')) return _kRed;
    if (name.contains('Lifecycle')) return _kLime;
    if (name.contains('Access')) return _kViolet;
    if (name.contains('Locale')) return _kCyanSoft;
    if (name.contains('Brightness')) return _kAmberSoft;
    if (name.contains('TextScale')) return _kAmber;
    if (name.contains('Route')) return _kCyan;
    if (name.contains('Metrics')) return _kCyan;
    return _kDim;
  }
}

// ===========================================================================
// SECTION 6 — MEMORY-PRESSURE DRILL
// ===========================================================================
// Shows a "reclaim" gauge that ticks up on each didHaveMemoryPressure call
// (saturating at 100%). A reset button drains the gauge. The card mimics a
// real cache-eviction flow: on pressure you'd drop image caches, release
// held resources, and trim in-memory fixtures.
// ===========================================================================

class _WboMemoryDrillSection extends StatelessWidget {
  const _WboMemoryDrillSection({
    required this.snapshot,
    required this.onPressure,
    required this.onDrain,
  });

  final _WboSnapshot snapshot;
  final VoidCallback onPressure;
  final VoidCallback onDrain;

  @override
  Widget build(BuildContext context) {
    final double pct = snapshot.memoryReclaim;
    return _WboSectionFrame(
      title: 'Memory drill · reclaim gauge',
      subtitle:
          'Each didHaveMemoryPressure call adds 18% to the gauge. In real '
          'apps this is where you drop caches and release held resources.',
      accent: _kRed,
      icon: Icons.memory,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  height: 32,
                  decoration: BoxDecoration(
                    color: _kNavy,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: _kRail),
                  ),
                  child: Stack(
                    children: <Widget>[
                      FractionallySizedBox(
                        widthFactor: pct,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: <Color>[_kRed, _kAmber, _kLime],
                            ),
                            borderRadius: BorderRadius.circular(7),
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          '${(pct * 100).toStringAsFixed(0)}% RECLAIMED',
                          style: const TextStyle(
                            color: _kChrome,
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              _WboConsoleButton(
                label: 'Pressure',
                icon: Icons.warning_amber,
                tint: _kRed,
                active: false,
                onPressed: onPressure,
              ),
              const SizedBox(width: 6),
              _WboConsoleButton(
                label: 'Drain',
                icon: Icons.cleaning_services,
                tint: _kLime,
                active: false,
                onPressed: onDrain,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              Expanded(
                child: _WboReclaimStep(
                  title: 'imageCache.clear()',
                  active: pct >= 0.18,
                  tint: _kRed,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _WboReclaimStep(
                  title: 'tile cache purge',
                  active: pct >= 0.36,
                  tint: _kAmber,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _WboReclaimStep(
                  title: 'release parsers',
                  active: pct >= 0.54,
                  tint: _kAmberSoft,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _WboReclaimStep(
                  title: 'trim repositories',
                  active: pct >= 0.72,
                  tint: _kCyanSoft,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _WboReclaimStep(
                  title: 'GC.hint()',
                  active: pct >= 0.9,
                  tint: _kLime,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'Tip · Treat didHaveMemoryPressure as an advisory signal. Drop '
            'discretionary caches, but never synchronously free something '
            'you still need within the same frame.',
            style: TextStyle(color: _kDim, fontSize: 12, height: 1.5),
          ),
        ],
      ),
    );
  }
}

class _WboReclaimStep extends StatelessWidget {
  const _WboReclaimStep({
    required this.title,
    required this.active,
    required this.tint,
  });
  final String title;
  final bool active;
  final Color tint;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      decoration: BoxDecoration(
        color: active ? tint.withOpacity(0.18) : _kNavy,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: active ? tint : _kRail,
          width: active ? 1.4 : 1.0,
        ),
      ),
      child: Column(
        children: <Widget>[
          Icon(
            active ? Icons.check_circle : Icons.radio_button_unchecked,
            color: active ? tint : _kDim,
            size: 16,
          ),
          const SizedBox(height: 4),
          Text(
            title,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: active ? tint : _kDim,
              fontSize: 10.5,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.4,
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// SECTION 7 — ROUTE INTERCEPT
// ===========================================================================
// Demonstrates didPopRoute returning Future<bool>. When true, the observer
// is saying "I handled this — don't propagate further". This is how you
// intercept Android back and show a confirm-dialog pattern.
// ===========================================================================

class _WboRouteInterceptSection extends StatelessWidget {
  const _WboRouteInterceptSection({
    required this.snapshot,
    required this.onConfirm,
    required this.onPop,
  });

  final _WboSnapshot snapshot;
  final VoidCallback onConfirm;
  final VoidCallback onPop;

  @override
  Widget build(BuildContext context) {
    return _WboSectionFrame(
      title: 'Route intercept · didPopRoute',
      subtitle:
          'Returning Future<bool> from didPopRoute tells the framework '
          '"I handled the back event". Classic use: guard unsaved changes.',
      accent: _kAmber,
      icon: Icons.shield,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              _WboConsoleButton(
                label: 'Simulate back',
                icon: Icons.arrow_back,
                tint: _kAmber,
                active: snapshot.routeInterceptVisible,
                onPressed: onPop,
              ),
              const SizedBox(width: 10),
              Text(
                'current route: ${snapshot.mockRoute}',
                style: const TextStyle(color: _kDim, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 12),
          AnimatedCrossFade(
            firstChild: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: _kNavy,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _kRail),
              ),
              child: const Row(
                children: <Widget>[
                  Icon(Icons.info_outline, color: _kDim, size: 18),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'no active intercept — press "Simulate back" to fire '
                      'didPopRoute and show the confirm dialog',
                      style: TextStyle(color: _kDim, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
            secondChild: _WboConfirmDialogPanel(
              onConfirm: onConfirm,
              onDismiss: onConfirm,
            ),
            crossFadeState: snapshot.routeInterceptVisible
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 180),
          ),
        ],
      ),
    );
  }
}

class _WboConfirmDialogPanel extends StatelessWidget {
  const _WboConfirmDialogPanel({
    required this.onConfirm,
    required this.onDismiss,
  });
  final VoidCallback onConfirm;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[Color(0xFF1A223E), Color(0xFF141B36)],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kAmber, width: 1.4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _kAmber.withOpacity(0.16),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.warning_amber, color: _kAmber),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Discard unsaved mission parameters?',
                  style: TextStyle(
                    color: _kChrome,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'Your observer returned `true` from didPopRoute, which means the '
            'framework will not propagate the back signal. This is exactly '
            'where you would render a confirm dialog like this one.',
            style: TextStyle(color: _kDim, fontSize: 12, height: 1.5),
          ),
          const SizedBox(height: 14),
          Row(
            children: <Widget>[
              const Spacer(),
              _WboConsoleButton(
                label: 'Stay',
                icon: Icons.check,
                tint: _kLime,
                active: false,
                onPressed: onDismiss,
              ),
              const SizedBox(width: 8),
              _WboConsoleButton(
                label: 'Discard',
                icon: Icons.close,
                tint: _kRed,
                active: false,
                onPressed: onConfirm,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// SECTION 8 — LOCALE SWAP
// ===========================================================================
// Flag strip showing the currently mocked locale list, plus quick swap
// presets. Each preset calls didChangeLocales directly, so the LED pulses
// and the log picks up the change.
// ===========================================================================

class _WboLocaleSwapSection extends StatelessWidget {
  const _WboLocaleSwapSection({
    required this.snapshot,
    required this.onSwap,
  });

  final _WboSnapshot snapshot;
  final ValueChanged<List<Locale>> onSwap;

  @override
  Widget build(BuildContext context) {
    return _WboSectionFrame(
      title: 'Locale swap · didChangeLocales',
      subtitle:
          'Mirrors the OS-preferred locale list. The flag strip shows the '
          'current mock; presets below fire the callback with a new list.',
      accent: _kCyanSoft,
      icon: Icons.translate,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _kNavy,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _kRail),
            ),
            child: Row(
              children: <Widget>[
                const Text(
                  'MOCK LOCALES',
                  style: TextStyle(
                    color: _kDim,
                    fontSize: 10,
                    letterSpacing: 1.6,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: <Widget>[
                      for (final Locale l in snapshot.mockLocales)
                        _WboLocalePill(locale: l),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              _WboConsoleButton(
                label: 'en-US + de',
                icon: Icons.swap_horiz,
                tint: _kCyanSoft,
                active: false,
                onPressed: () => onSwap(const <Locale>[
                  Locale('en', 'US'),
                  Locale.fromSubtags(languageCode: 'de'),
                ]),
              ),
              _WboConsoleButton(
                label: 'ja + ko',
                icon: Icons.swap_horiz,
                tint: _kCyanSoft,
                active: false,
                onPressed: () => onSwap(const <Locale>[
                  Locale.fromSubtags(languageCode: 'ja'),
                  Locale.fromSubtags(languageCode: 'ko'),
                ]),
              ),
              _WboConsoleButton(
                label: 'ar + he',
                icon: Icons.swap_horiz,
                tint: _kCyanSoft,
                active: false,
                onPressed: () => onSwap(const <Locale>[
                  Locale.fromSubtags(languageCode: 'ar'),
                  Locale.fromSubtags(languageCode: 'he'),
                ]),
              ),
              _WboConsoleButton(
                label: 'zh-CN',
                icon: Icons.swap_horiz,
                tint: _kCyanSoft,
                active: false,
                onPressed: () => onSwap(const <Locale>[
                  Locale('zh', 'CN'),
                ]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _WboLocalePill extends StatelessWidget {
  const _WboLocalePill({required this.locale});
  final Locale locale;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: _kCyanSoft.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: _kCyanSoft.withOpacity(0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Icon(Icons.flag, color: _kCyanSoft, size: 12),
          const SizedBox(width: 6),
          Text(
            locale.toLanguageTag(),
            style: const TextStyle(
              color: _kCyanSoft,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.6,
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// SECTION 9 — RECIPE CARDS
// ===========================================================================
// Five+ common patterns you hit when using WidgetsBindingObserver. Each
// card bundles a one-line headline, a longer rationale, and a short code
// snippet rendered as a terminal-style block.
// ===========================================================================

class _WboRecipeSection extends StatelessWidget {
  const _WboRecipeSection();

  @override
  Widget build(BuildContext context) {
    final List<_WboRecipe> recipes = _recipes();
    return _WboSectionFrame(
      title: 'Recipes · patterns you\'ll actually use',
      subtitle:
          'Five curated patterns: data refresh on resume, pause work on '
          'hidden, save on paused, reclaim on memory pressure, and the '
          'mounted-check guard for async work.',
      accent: _kAmber,
      icon: Icons.auto_stories,
      child: Column(
        children: <Widget>[
          for (int i = 0; i < recipes.length; i++) ...<Widget>[
            _WboRecipeCard(recipe: recipes[i], index: i),
            if (i < recipes.length - 1) const SizedBox(height: 10),
          ],
        ],
      ),
    );
  }
}

class _WboRecipe {
  const _WboRecipe({
    required this.icon,
    required this.title,
    required this.rationale,
    required this.code,
    required this.tint,
  });
  final IconData icon;
  final String title;
  final String rationale;
  final String code;
  final Color tint;
}

List<_WboRecipe> _recipes() => const <_WboRecipe>[
      _WboRecipe(
        icon: Icons.refresh,
        title: 'Refresh data on resume',
        rationale: 'When the user returns from the background, your cached '
            'view may be stale. Trigger a refetch on resumed to catch up '
            'without making the user pull-to-refresh.',
        code: 'void didChangeAppLifecycleState(AppLifecycleState s) {\n'
            '  if (s == AppLifecycleState.resumed) refetch();\n'
            '}',
        tint: _kLime,
      ),
      _WboRecipe(
        icon: Icons.pause,
        title: 'Pause background work when hidden',
        rationale: 'The app is still running when hidden, so any animation '
            'controllers, timers, or polling loops you have will continue '
            'burning battery. Pause on hidden, resume on resumed.',
        code: 'if (s == AppLifecycleState.hidden) controller.stop();\n'
            'if (s == AppLifecycleState.resumed) controller.repeat();',
        tint: _kAmberSoft,
      ),
      _WboRecipe(
        icon: Icons.save_alt,
        title: 'Persist state on paused',
        rationale: 'paused is your last reliable hook before the OS may '
            'kill the process. Flush any in-memory buffers to disk here — '
            'especially on Android where paused is the killable state.',
        code: 'if (s == AppLifecycleState.paused) draftRepo.flushSync();',
        tint: _kRed,
      ),
      _WboRecipe(
        icon: Icons.cleaning_services,
        title: 'Reclaim on memory pressure',
        rationale: 'Drop discretionary caches when you get the memory '
            'pressure ping. ImageCache.clear() and tile caches are usually '
            'safe targets; never drop anything still visible on screen.',
        code: '@override\n'
            'void didHaveMemoryPressure() {\n'
            '  PaintingBinding.instance.imageCache.clear();\n'
            '}',
        tint: _kRed,
      ),
      _WboRecipe(
        icon: Icons.lock,
        title: 'Guard async with mounted',
        rationale: 'Observer callbacks can fire right up until your State '
            'is disposed. Any async work you start must check `mounted` '
            'before touching setState or the BuildContext.',
        code: 'Future<void> _onResume() async {\n'
            '  final r = await repo.load();\n'
            '  if (!mounted) return;\n'
            '  setState(() => _data = r);\n'
            '}',
        tint: _kCyan,
      ),
      _WboRecipe(
        icon: Icons.logout,
        title: 'Desktop exit guard',
        rationale: 'didRequestAppExit fires when the user closes a desktop '
            'window. Return AppExitResponse.cancel to block, e.g. to show '
            'a save-dialog, then call exit yourself once the user confirms.',
        code: '@override\n'
            'Future<AppExitResponse> didRequestAppExit() async {\n'
            '  if (hasUnsaved) return AppExitResponse.cancel;\n'
            '  return AppExitResponse.exit;\n'
            '}',
        tint: _kViolet,
      ),
    ];

class _WboRecipeCard extends StatelessWidget {
  const _WboRecipeCard({required this.recipe, required this.index});
  final _WboRecipe recipe;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _kPanel,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: recipe.tint.withOpacity(0.35)),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: recipe.tint.withOpacity(0.14),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(recipe.icon, color: recipe.tint, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'RECIPE ${(index + 1).toString().padLeft(2, '0')}',
                      style: TextStyle(
                        color: recipe.tint,
                        fontSize: 10,
                        letterSpacing: 1.8,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      recipe.title,
                      style: const TextStyle(
                        color: _kChrome,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            recipe.rationale,
            style: const TextStyle(
              color: _kDim,
              fontSize: 12.5,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kNavy,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: recipe.tint.withOpacity(0.25)),
            ),
            child: Text(
              recipe.code,
              style: TextStyle(
                color: recipe.tint,
                fontSize: 11.5,
                fontFamily: 'monospace',
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// SECTION 10 — COMPARISON TABLE
// ===========================================================================
// WidgetsBindingObserver vs AppLifecycleListener vs RouteObserver. Table
// rendered from a list of rows so it wraps gracefully on narrow widths.
// ===========================================================================

class _WboComparisonSection extends StatelessWidget {
  const _WboComparisonSection();

  @override
  Widget build(BuildContext context) {
    final List<List<String>> rows = <List<String>>[
      <String>['Feature', 'WidgetsBindingObserver', 'AppLifecycleListener',
          'RouteObserver'],
      <String>['Flavour', 'Mixin on State', 'Plain object', 'Navigator plugin'],
      <String>['Scope', 'All app-level events', 'Lifecycle only',
          'Navigation only'],
      <String>['Setup', 'add/removeObserver manually',
          'Construct → dispose', 'Attach to Navigator.observers'],
      <String>['Lifecycle', 'didChangeAppLifecycleState(state)',
          'Named callbacks per state', 'n/a'],
      <String>['Metrics / scale',
          'didChangeMetrics / TextScale / Brightness', 'no', 'no'],
      <String>['Exit guard',
          'didRequestAppExit override', 'onExitRequested callback', 'no'],
      <String>['Route intercept',
          'didPopRoute / didPushRouteInformation', 'no',
          'didPush / didPop / didRemove / didReplace'],
      <String>['Memory / a11y',
          'didHaveMemoryPressure + A11y', 'no', 'no'],
      <String>['Best for',
          'Low-level hooks, one-stop shop',
          'Clean per-state handlers in non-State code',
          'Analytics / active-route tracking'],
      <String>['Pitfalls',
          'Forgetting removeObserver leaks', 'Remember to dispose',
          'Only fires for navigator events'],
    ];

    return _WboSectionFrame(
      title: 'Comparison · three lifecycle hooks',
      subtitle:
          'How WidgetsBindingObserver relates to its two cousins. Rule of '
          'thumb: use AppLifecycleListener for modern, focused lifecycle '
          'work; keep WidgetsBindingObserver for the wide surface.',
      accent: _kViolet,
      icon: Icons.compare_arrows,
      child: Column(
        children: <Widget>[
          for (int i = 0; i < rows.length; i++)
            _WboCompareRow(
              cells: rows[i],
              isHeader: i == 0,
              tint: i == 0 ? _kViolet : _kChrome,
            ),
        ],
      ),
    );
  }
}

class _WboCompareRow extends StatelessWidget {
  const _WboCompareRow({
    required this.cells,
    required this.isHeader,
    required this.tint,
  });
  final List<String> cells;
  final bool isHeader;
  final Color tint;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: isHeader ? _kViolet.withOpacity(0.12) : _kNavy,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isHeader ? _kViolet.withOpacity(0.55) : _kRail,
          width: isHeader ? 1.2 : 1.0,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Text(
              cells[0],
              style: TextStyle(
                color: tint,
                fontSize: 12,
                fontWeight: isHeader ? FontWeight.w800 : FontWeight.w600,
                letterSpacing: isHeader ? 1.0 : 0.3,
              ),
            ),
          ),
          for (int i = 1; i < cells.length; i++)
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  cells[i],
                  style: TextStyle(
                    color: isHeader ? _kViolet : _kDim,
                    fontSize: 11.5,
                    height: 1.35,
                    fontWeight:
                        isHeader ? FontWeight.w800 : FontWeight.w500,
                    letterSpacing: isHeader ? 1.0 : 0.2,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ===========================================================================
// SECTION 11 — GLOSSARY
// ===========================================================================
class _WboGlossarySection extends StatelessWidget {
  const _WboGlossarySection();

  @override
  Widget build(BuildContext context) {
    final List<_WboGlossaryEntry> entries = <_WboGlossaryEntry>[
      const _WboGlossaryEntry(
        term: 'WidgetsBinding',
        body: 'The singleton that plugs Flutter into the engine and native '
            'platform. Owns the observer list, the scheduler, and the '
            'hit-test manager. Access via `WidgetsBinding.instance`.',
      ),
      const _WboGlossaryEntry(
        term: 'WidgetsBindingObserver',
        body: 'The mixin this demo is about. Attach it to any class (not '
            'just State) and register the instance with the binding to be '
            'called back for system events.',
      ),
      const _WboGlossaryEntry(
        term: 'AppLifecycleState',
        body: 'Enum describing where the app is in its run lifecycle. '
            'Values: resumed, inactive, hidden, paused, detached. Not to '
            'be confused with navigation state.',
      ),
      const _WboGlossaryEntry(
        term: 'AppExitResponse',
        body: 'Enum returned from didRequestAppExit on desktop. exit = '
            'allow the window to close; cancel = prevent it. Only the '
            'first non-default response wins.',
      ),
      const _WboGlossaryEntry(
        term: 'RouteInformation',
        body: 'Value-type passed to didPushRouteInformation. Carries a Uri '
            'and an optional state object — the replacement for the '
            'deprecated String-based didPushRoute.',
      ),
      const _WboGlossaryEntry(
        term: 'Observer fan-out',
        body: 'The binding\'s policy of calling every registered observer '
            'in registration order for each system event. Insertion order '
            'is preserved by a LinkedHashSet.',
      ),
      const _WboGlossaryEntry(
        term: 'Memory pressure',
        body: 'A cooperative signal from the OS asking you to drop '
            'caches. Not a hard cap; the system still guarantees nothing.',
      ),
      const _WboGlossaryEntry(
        term: 'Mounted guard',
        body: 'The State.mounted boolean, used to bail out of async '
            'continuations that reach back into a disposed widget. A '
            'must when combining observers with async/await.',
      ),
    ];
    return _WboSectionFrame(
      title: 'Glossary · terms you\'ll encounter',
      subtitle:
          'Quick definitions for the framework types surrounding '
          'WidgetsBindingObserver. Skim as needed.',
      accent: _kCyan,
      icon: Icons.menu_book_outlined,
      child: Column(
        children: <Widget>[
          for (final _WboGlossaryEntry e in entries)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _kNavy,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: _kRail),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 6,
                      margin: const EdgeInsets.only(right: 10, top: 2),
                      height: 46,
                      decoration: BoxDecoration(
                        color: _kCyan.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            e.term,
                            style: const TextStyle(
                              color: _kCyan,
                              fontSize: 13,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            e.body,
                            style: const TextStyle(
                              color: _kDim,
                              fontSize: 12,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _WboGlossaryEntry {
  const _WboGlossaryEntry({required this.term, required this.body});
  final String term;
  final String body;
}

// ===========================================================================
// SECTION 12 — EPILOGUE
// ===========================================================================
class _WboEpilogueSection extends StatelessWidget {
  const _WboEpilogueSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[Color(0xFF0E1A36), Color(0xFF131E3E)],
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kCyan.withOpacity(0.35)),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          Text(
            'EPILOGUE',
            style: TextStyle(
              color: _kCyan,
              fontSize: 11,
              letterSpacing: 2.4,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'WidgetsBindingObserver is old, wide, and still useful.',
            style: TextStyle(
              color: _kChrome,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Newer APIs like AppLifecycleListener are cleaner when you only '
            'need a subset of the surface, but WidgetsBindingObserver remains '
            'the canonical one-stop shop for framework-level events — '
            'lifecycle, metrics, text scale, brightness, locales, memory '
            'pressure, accessibility, routes, and desktop exit. Remember the '
            'one rule that matters: register in initState, remove in '
            'dispose, and let the rest be no-ops.',
            style: TextStyle(color: _kDim, fontSize: 13, height: 1.55),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// SECTION FRAME
// ===========================================================================
// Shared chrome that wraps every section with an icon, a title, a
// subtitle, and a tinted top border. Keeps the scrolling deck visually
// consistent without repeating the same 40 lines in every section.
// ===========================================================================

class _WboSectionFrame extends StatelessWidget {
  const _WboSectionFrame({
    required this.title,
    required this.subtitle,
    required this.accent,
    required this.icon,
    required this.child,
  });

  final String title;
  final String subtitle;
  final Color accent;
  final IconData icon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    // Flutter forbids `borderRadius` together with a non-uniform `Border`
    // (e.g. a coloured top edge + neutral rails on the other sides). The
    // section frame's visual identity has two parts: rounded corners and a
    // tinted top edge. Keep both by using a uniform `Border.all` for the
    // rails and rendering the tinted top strip as a clipped overlay on top
    // of the rounded card.
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: _kPanel,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _kRail),
          ),
          padding: const EdgeInsets.fromLTRB(18, 16, 18, 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: accent.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: accent.withOpacity(0.55)),
                    ),
                    child: Icon(icon, color: accent, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          title.toUpperCase(),
                          style: TextStyle(
                            color: accent,
                            fontSize: 12,
                            letterSpacing: 1.8,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          subtitle,
                          style: const TextStyle(
                            color: _kDim,
                            fontSize: 12,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              child,
            ],
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          top: 0,
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(16),
            ),
            child: Container(
              height: 2,
              color: accent.withOpacity(0.7),
            ),
          ),
        ),
      ],
    );
  }
}

// ===========================================================================
// CONSOLE READOUT
// ===========================================================================
// Rack-mounted status bar at the bottom of the scaffold. Shows the
// current mocked state, text scale, brightness, and the tail of the log
// as a scrolling marquee-like single line.
// ===========================================================================

class _WboConsoleReadout extends StatelessWidget {
  const _WboConsoleReadout({required this.snapshot});

  final _WboSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    final _WboEvent? last =
        snapshot.log.isNotEmpty ? snapshot.log.first : null;
    return Container(
      decoration: const BoxDecoration(
        color: _kPanel,
        border: Border(
          top: BorderSide(color: _kRail, width: 1),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(14, 8, 14, 10),
      child: SafeArea(
        top: false,
        child: Row(
          children: <Widget>[
            _WboConsoleChip(
              label: 'STATE',
              value: snapshot.mockState.name.toUpperCase(),
              tint: _tintForState(snapshot.mockState),
            ),
            const SizedBox(width: 6),
            _WboConsoleChip(
              label: 'SCALE',
              value: 'x${snapshot.mockTextScale.toStringAsFixed(2)}',
              tint: _kAmber,
            ),
            const SizedBox(width: 6),
            _WboConsoleChip(
              label: 'BRT',
              value: snapshot.mockBrightness == Brightness.dark
                  ? 'DARK'
                  : 'LIGHT',
              tint: _kAmberSoft,
            ),
            const SizedBox(width: 6),
            _WboConsoleChip(
              label: 'LOC',
              value: snapshot.mockLocales.isEmpty
                  ? '--'
                  : snapshot.mockLocales.first.toLanguageTag(),
              tint: _kCyanSoft,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: _kNavy,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: _kRail),
                ),
                child: Text(
                  last == null
                      ? 'awaiting observer callback…'
                      : '${last.hhmmss}  ${last.name}  ·  ${last.payload}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: _kChrome,
                    fontSize: 11.5,
                    fontFamily: 'monospace',
                    fontFeatures: <FontFeature>[FontFeature.tabularFigures()],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Color _tintForState(AppLifecycleState s) {
    switch (s) {
      case AppLifecycleState.resumed:
        return _kLime;
      case AppLifecycleState.inactive:
        return _kAmber;
      case AppLifecycleState.hidden:
        return _kAmberSoft;
      case AppLifecycleState.paused:
        return _kRed;
      case AppLifecycleState.detached:
        return _kDim;
    }
  }
}

class _WboConsoleChip extends StatelessWidget {
  const _WboConsoleChip({
    required this.label,
    required this.value,
    required this.tint,
  });
  final String label;
  final String value;
  final Color tint;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: tint.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: tint.withOpacity(0.55)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(
              color: tint,
              fontSize: 9,
              letterSpacing: 1.4,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            value,
            style: const TextStyle(
              color: _kChrome,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              fontFeatures: <FontFeature>[FontFeature.tabularFigures()],
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// END OF FILE
// ---------------------------------------------------------------------------
// The demo above renders as a single scrolling deck:
//   [ AppBar ]
//   [ Hero banner ]
//   [ Dossier cards ]
//   [ Live observer LED grid ]
//   [ Simulate panel ]
//   [ State diagram ]
//   [ Observer log ]
//   [ Memory drill ]
//   [ Route intercept ]
//   [ Locale swap ]
//   [ Recipes ]
//   [ Comparison table ]
//   [ Glossary ]
//   [ Epilogue ]
//   [ Console readout pinned bottom ]
// ===========================================================================
