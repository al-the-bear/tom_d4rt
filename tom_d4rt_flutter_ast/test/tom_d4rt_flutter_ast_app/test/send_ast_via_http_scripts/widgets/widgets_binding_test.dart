// ignore_for_file: avoid_print
// D4rt test script: Deep visual demo for WidgetsBinding from widgets.dart.
//
// Theme: Engine room — brass, steel, glass gauges, rivets, pipes, needles.
//
// WidgetsBinding is the singleton glue connecting the Dart framework to the
// embedder. It mixes together every binding mixin — GestureBinding,
// SchedulerBinding, RendererBinding, PaintingBinding, SemanticsBinding,
// ServicesBinding — so your widget tree can be built, scheduled, painted,
// gestured at, and shuttled over platform channels.
//
// This demo provides a boiler-and-valve console that introspects the live
// instance, runs frame callbacks, exercises the scheduler, and tours the
// observer/lifecycle surface. Prefixes: _Wbn*.
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show PipelineOwner;
import 'package:flutter/scheduler.dart';

// ---------------------------------------------------------------------------
// Engine-room palette (brass, steel, glass, rivet copper, boiler red).
// ---------------------------------------------------------------------------
const Color _kBrass = Color(0xFFB58A3D);
const Color _kBrassDark = Color(0xFF7A5A1E);
const Color _kBrassHi = Color(0xFFE8CC8A);
const Color _kSteel = Color(0xFF3E4A55);
const Color _kSteelDark = Color(0xFF242B32);
const Color _kSteelLo = Color(0xFF1A2026);
const Color _kGlass = Color(0xFF0B1418);
const Color _kGlassHi = Color(0xFF113A3E);
const Color _kCopper = Color(0xFF9A4A22);
const Color _kBoiler = Color(0xFFB03B2A);
const Color _kEmber = Color(0xFFE69240);
const Color _kPipe = Color(0xFF5E443A);
const Color _kRivet = Color(0xFF7A6B4D);
const Color _kInk = Color(0xFFF4E7C6);
const Color _kInkDim = Color(0xFFB7A781);
const Color _kMint = Color(0xFF8EC8B1);
const Color _kLamp = Color(0xFFF6B85A);

// ---------------------------------------------------------------------------
// D4rt bridge workaround: bridged TickerProvider mixins are not callable as
// true mixins under the interpreter. We provide a local shim that satisfies
// TickerProvider contractually.
// ---------------------------------------------------------------------------
mixin _WbnTickerShim<T extends StatefulWidget> on State<T>
    implements TickerProvider {
  @override
  Ticker createTicker(TickerCallback onTick) => Ticker(onTick);
}

// ---------------------------------------------------------------------------
// Entry point for the d4rt harness.
// ---------------------------------------------------------------------------
dynamic build(BuildContext context) {
  return const _WbnApp();
}

class _WbnApp extends StatelessWidget {
  const _WbnApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WidgetsBinding — Engine Room',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: _kSteelLo,
        colorScheme: const ColorScheme.dark(
          primary: _kBrass,
          secondary: _kCopper,
          surface: _kSteelDark,
          onPrimary: _kSteelLo,
          onSecondary: _kInk,
          onSurface: _kInk,
        ),
        cardTheme: const CardThemeData(
          color: _kSteelDark,
          elevation: 0,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(14)),
          ),
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: _kInk, fontSize: 13, height: 1.35),
          bodySmall: TextStyle(color: _kInkDim, fontSize: 12, height: 1.3),
          titleMedium: TextStyle(
            color: _kBrassHi,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
          titleLarge: TextStyle(
            color: _kBrassHi,
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
          headlineSmall: TextStyle(
            color: _kInk,
            fontSize: 22,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.6,
          ),
        ),
      ),
      home: const _WbnHome(),
    );
  }
}

// ---------------------------------------------------------------------------
// Home — the engine-room console. Owns all state for frame counters,
// scheduler log, observer log, and the instance readout.
// ---------------------------------------------------------------------------
class _WbnHome extends StatefulWidget {
  const _WbnHome();

  @override
  State<_WbnHome> createState() => _WbnHomeState();
}

class _WbnHomeState extends State<_WbnHome>
    with _WbnTickerShim, WidgetsBindingObserver {
  // Animation controller drives the gauge needles. Each frame advances a
  // fractional value used by the CustomPainters.
  late final AnimationController _needleCtrl;

  // Counters for the frame timeline section.
  int _postFrameCount = 0;
  int _persistentFrameCount = 0;
  int _scheduleFrameCalls = 0;
  int _ensureVisualUpdateCalls = 0;
  int _deferFirstFrameCalls = 0;
  int _allowFirstFrameCalls = 0;

  // Scheduler and observer logs (rolling, capped).
  final List<String> _schedulerLog = <String>[];
  final List<String> _observerLog = <String>[];

  // Cached introspection snapshot (refreshed every post-frame).
  _WbnSnapshot _snapshot = _WbnSnapshot.placeholder();

  // Whether persistent frame callback is installed. We install exactly one
  // and count every invocation while mounted.
  bool _persistentInstalled = false;

  // Simulated accessibility flags panel — the real read goes first, falls
  // back to simulated toggles if the introspection fails.
  bool _accHighContrast = false;
  bool _accBoldText = false;
  bool _accDisableAnimations = false;
  bool _accReduceMotion = false;
  bool _accInvertColors = false;
  bool _accAccessibleNavigation = false;

  @override
  void initState() {
    super.initState();
    _needleCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    );
    // Register as observer to get lifecycle / metrics / locale events.
    try {
      WidgetsBinding.instance.addObserver(this);
      _logObserver('registered observer with WidgetsBinding.instance');
    } catch (e) {
      _logObserver('addObserver failed: $e');
    }
    // Install persistent frame callback once.
    try {
      WidgetsBinding.instance.addPersistentFrameCallback((Duration _) {
        if (!mounted) return;
        _persistentFrameCount++;
      });
      _persistentInstalled = true;
      _logScheduler('addPersistentFrameCallback installed');
    } catch (e) {
      _logScheduler('addPersistentFrameCallback failed: $e');
    }
    // First post-frame: gather the snapshot and start the needle animation.
    try {
      WidgetsBinding.instance.addPostFrameCallback((Duration _) {
        if (!mounted) return;
        _postFrameCount++;
        _refreshSnapshot();
        _needleCtrl.repeat(reverse: true);
      });
    } catch (e) {
      _logScheduler('first addPostFrameCallback failed: $e');
    }
  }

  @override
  void dispose() {
    try {
      WidgetsBinding.instance.removeObserver(this);
    } catch (_) {
      // silent — teardown best effort.
    }
    _needleCtrl.dispose();
    super.dispose();
  }

  // ---- Observer callbacks (WidgetsBindingObserver) ------------------------

  @override
  void didChangeMetrics() {
    _logObserver('didChangeMetrics — window metrics changed');
    _requestRefresh();
  }

  @override
  void didChangeTextScaleFactor() {
    _logObserver('didChangeTextScaleFactor');
    _requestRefresh();
  }

  @override
  void didChangePlatformBrightness() {
    _logObserver('didChangePlatformBrightness');
    _requestRefresh();
  }

  @override
  void didChangeLocales(List<Locale>? locales) {
    _logObserver('didChangeLocales → ${locales?.length ?? 0} locale(s)');
    _requestRefresh();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _logObserver('didChangeAppLifecycleState → $state');
  }

  @override
  void didHaveMemoryPressure() {
    _logObserver('didHaveMemoryPressure — low memory warning');
  }

  @override
  void didChangeAccessibilityFeatures() {
    _logObserver('didChangeAccessibilityFeatures');
    _requestRefresh();
  }

  // ---- Helpers ------------------------------------------------------------

  void _logScheduler(String msg) {
    setState(() {
      _schedulerLog.insert(0, _stamp(msg));
      if (_schedulerLog.length > 80) {
        _schedulerLog.removeRange(80, _schedulerLog.length);
      }
    });
  }

  void _logObserver(String msg) {
    if (!mounted) {
      // Pre-mount logging just appends directly.
      _observerLog.insert(0, _stamp(msg));
      return;
    }
    setState(() {
      _observerLog.insert(0, _stamp(msg));
      if (_observerLog.length > 80) {
        _observerLog.removeRange(80, _observerLog.length);
      }
    });
  }

  String _stamp(String msg) {
    final DateTime now = DateTime.now();
    final String hh = now.hour.toString().padLeft(2, '0');
    final String mm = now.minute.toString().padLeft(2, '0');
    final String ss = now.second.toString().padLeft(2, '0');
    final String ms = now.millisecond.toString().padLeft(3, '0');
    return '[$hh:$mm:$ss.$ms] $msg';
  }

  void _requestRefresh() {
    try {
      WidgetsBinding.instance.addPostFrameCallback((Duration _) {
        if (!mounted) return;
        _postFrameCount++;
        _refreshSnapshot();
      });
    } catch (e) {
      _logScheduler('addPostFrameCallback failed in refresh: $e');
    }
  }

  void _refreshSnapshot() {
    final _WbnSnapshot next = _WbnSnapshot.capture();
    setState(() => _snapshot = next);
  }

  // ---- Scheduler action buttons ------------------------------------------

  void _doScheduleFrame() {
    try {
      WidgetsBinding.instance.scheduleFrame();
      _scheduleFrameCalls++;
      _logScheduler('scheduleFrame() invoked (total=$_scheduleFrameCalls)');
    } catch (e) {
      _logScheduler('scheduleFrame failed: $e');
    }
  }

  void _doEnsureVisualUpdate() {
    try {
      WidgetsBinding.instance.ensureVisualUpdate();
      _ensureVisualUpdateCalls++;
      _logScheduler(
        'ensureVisualUpdate() invoked (total=$_ensureVisualUpdateCalls)',
      );
    } catch (e) {
      _logScheduler('ensureVisualUpdate failed: $e');
    }
  }

  void _doDeferFirstFrame() {
    try {
      WidgetsBinding.instance.deferFirstFrame();
      _deferFirstFrameCalls++;
      _logScheduler(
        'deferFirstFrame() invoked (total=$_deferFirstFrameCalls). '
        'Remember to pair with allowFirstFrame().',
      );
    } catch (e) {
      _logScheduler('deferFirstFrame failed: $e');
    }
  }

  void _doAllowFirstFrame() {
    try {
      WidgetsBinding.instance.allowFirstFrame();
      _allowFirstFrameCalls++;
      _logScheduler(
        'allowFirstFrame() invoked (total=$_allowFirstFrameCalls).',
      );
    } catch (e) {
      _logScheduler('allowFirstFrame failed: $e');
    }
  }

  void _doPostFrame() {
    try {
      WidgetsBinding.instance.addPostFrameCallback((Duration _) {
        if (!mounted) return;
        _postFrameCount++;
        _logScheduler('post-frame callback fired (total=$_postFrameCount)');
        setState(() {});
      });
      _logScheduler('addPostFrameCallback scheduled');
    } catch (e) {
      _logScheduler('addPostFrameCallback failed: $e');
    }
  }

  void _resetCounters() {
    setState(() {
      _postFrameCount = 0;
      _persistentFrameCount = 0;
      _scheduleFrameCalls = 0;
      _ensureVisualUpdateCalls = 0;
      _deferFirstFrameCalls = 0;
      _allowFirstFrameCalls = 0;
      _schedulerLog.clear();
      _observerLog.clear();
    });
    _logScheduler('counters and logs cleared');
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mq = MediaQuery.of(context);
    final bool wide = mq.size.width > 1040;

    return Scaffold(
      backgroundColor: _kSteelLo,
      appBar: _WbnEngineAppBar(
        title: 'WIDGETSBINDING — ENGINE ROOM',
        subtitle: 'Singleton glue · scheduler · renderer · observers',
        persistentInstalled: _persistentInstalled,
      ),
      body: DefaultTextStyle.merge(
        style: const TextStyle(color: _kInk),
        child: _WbnPipeBackdrop(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 48),
            children: <Widget>[
              const _WbnSectionHeader(
                index: 1,
                title: 'DOSSIER / PREAMBLE',
                caption: 'What WidgetsBinding is and why it exists.',
              ),
              const SizedBox(height: 12),
              const _WbnDossierDeck(),
              const SizedBox(height: 26),
              const _WbnSectionHeader(
                index: 2,
                title: 'INSTANCE READOUT',
                caption: 'Live introspection of WidgetsBinding.instance.',
              ),
              const SizedBox(height: 12),
              _WbnInstanceReadout(snapshot: _snapshot, onRefresh: _refreshSnapshot),
              const SizedBox(height: 26),
              const _WbnSectionHeader(
                index: 3,
                title: 'FRAME TIMELINE',
                caption:
                    'Post-frame and persistent-frame counters drive live gauges.',
              ),
              const SizedBox(height: 12),
              _WbnFrameTimeline(
                postFrameCount: _postFrameCount,
                persistentCount: _persistentFrameCount,
                needle: _needleCtrl,
                onPostFrame: _doPostFrame,
                onReset: _resetCounters,
                wide: wide,
              ),
              const SizedBox(height: 26),
              const _WbnSectionHeader(
                index: 4,
                title: 'SCHEDULER SHOWCASE',
                caption:
                    'scheduleFrame · ensureVisualUpdate · deferFirstFrame · allowFirstFrame.',
              ),
              const SizedBox(height: 12),
              _WbnSchedulerShowcase(
                scheduleFrameCalls: _scheduleFrameCalls,
                ensureVisualUpdateCalls: _ensureVisualUpdateCalls,
                deferFirstFrameCalls: _deferFirstFrameCalls,
                allowFirstFrameCalls: _allowFirstFrameCalls,
                log: _schedulerLog,
                onScheduleFrame: _doScheduleFrame,
                onEnsureVisualUpdate: _doEnsureVisualUpdate,
                onDeferFirstFrame: _doDeferFirstFrame,
                onAllowFirstFrame: _doAllowFirstFrame,
                onReset: _resetCounters,
              ),
              const SizedBox(height: 26),
              const _WbnSectionHeader(
                index: 5,
                title: 'OBSERVER ROSTER',
                caption:
                    'WidgetsBindingObserver — metrics, locales, lifecycle, memory.',
              ),
              const SizedBox(height: 12),
              _WbnObserverRoster(
                observerCount: _snapshot.observerCount,
                log: _observerLog,
              ),
              const SizedBox(height: 26),
              const _WbnSectionHeader(
                index: 6,
                title: 'PIPELINE & BUILD OWNER',
                caption: 'Widget → Element → RenderObject, with live probes.',
              ),
              const SizedBox(height: 12),
              _WbnPipelineCard(snapshot: _snapshot),
              const SizedBox(height: 26),
              const _WbnSectionHeader(
                index: 7,
                title: 'LOCALE & PLATFORM BRIGHTNESS',
                caption:
                    'platformDispatcher.locales and .platformBrightness (prefer over deprecated window).',
              ),
              const SizedBox(height: 12),
              _WbnLocaleCard(snapshot: _snapshot),
              const SizedBox(height: 26),
              const _WbnSectionHeader(
                index: 8,
                title: 'ACCESSIBILITY FEATURES',
                caption:
                    'Read-only indicators for accessibilityFeatures flags.',
              ),
              const SizedBox(height: 12),
              _WbnAccessibilityCard(
                snapshot: _snapshot,
                simHighContrast: _accHighContrast,
                simBoldText: _accBoldText,
                simDisableAnimations: _accDisableAnimations,
                simReduceMotion: _accReduceMotion,
                simInvertColors: _accInvertColors,
                simAccessibleNavigation: _accAccessibleNavigation,
                onSimHighContrast: (bool v) =>
                    setState(() => _accHighContrast = v),
                onSimBoldText: (bool v) => setState(() => _accBoldText = v),
                onSimDisableAnimations: (bool v) =>
                    setState(() => _accDisableAnimations = v),
                onSimReduceMotion: (bool v) =>
                    setState(() => _accReduceMotion = v),
                onSimInvertColors: (bool v) =>
                    setState(() => _accInvertColors = v),
                onSimAccessibleNavigation: (bool v) =>
                    setState(() => _accAccessibleNavigation = v),
              ),
              const SizedBox(height: 26),
              const _WbnSectionHeader(
                index: 9,
                title: 'RECIPE CARDS',
                caption: 'Practical patterns with tiny snippets.',
              ),
              const SizedBox(height: 12),
              const _WbnRecipeDeck(),
              const SizedBox(height: 26),
              const _WbnSectionHeader(
                index: 10,
                title: 'COMPARISON CHART',
                caption:
                    'WidgetsBinding vs WidgetsFlutterBinding vs TestWidgetsFlutterBinding.',
              ),
              const SizedBox(height: 12),
              const _WbnComparisonCard(),
              const SizedBox(height: 26),
              const _WbnSectionHeader(
                index: 11,
                title: 'GLOSSARY / EPILOGUE',
                caption: 'Terms, closing notes, and further reading.',
              ),
              const SizedBox(height: 12),
              const _WbnGlossaryCard(),
              const SizedBox(height: 40),
              const _WbnFooter(),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _WbnSnapshot — captured introspection of WidgetsBinding.instance. Each
// field wraps its read in try/catch so the whole snapshot survives any
// single failure, and every failure is surfaced as 'error: <msg>'.
// ---------------------------------------------------------------------------
class _WbnSnapshot {
  const _WbnSnapshot({
    required this.runtimeTypeName,
    required this.hashCodeText,
    required this.observerCount,
    required this.locales,
    required this.primaryLocale,
    required this.platformBrightness,
    required this.rootElementInfo,
    required this.buildOwnerInfo,
    required this.pipelineOwnerInfo,
    required this.platformDispatcherInfo,
    required this.accessibilityFeatures,
    required this.accFlags,
    required this.firstFrameRasterized,
  });

  factory _WbnSnapshot.placeholder() => const _WbnSnapshot(
        runtimeTypeName: 'pending…',
        hashCodeText: 'pending…',
        observerCount: 0,
        locales: <String>[],
        primaryLocale: 'pending…',
        platformBrightness: 'pending…',
        rootElementInfo: 'pending…',
        buildOwnerInfo: 'pending…',
        pipelineOwnerInfo: 'pending…',
        platformDispatcherInfo: 'pending…',
        accessibilityFeatures: 'pending…',
        accFlags: <String, bool>{},
        firstFrameRasterized: 'pending…',
      );

  factory _WbnSnapshot.capture() {
    String runtimeTypeName;
    String hashCodeText;
    int observerCount;
    List<String> locales;
    String primaryLocale;
    String platformBrightness;
    String rootElementInfo;
    String buildOwnerInfo;
    String pipelineOwnerInfo;
    String platformDispatcherInfo;
    String accessibilityFeatures;
    final Map<String, bool> accFlags = <String, bool>{};
    String firstFrameRasterized;

    WidgetsBinding? binding;
    try {
      binding = WidgetsBinding.instance;
      runtimeTypeName = binding.runtimeType.toString();
    } catch (e) {
      runtimeTypeName = 'error: $e';
    }
    try {
      hashCodeText = binding?.hashCode.toString() ?? 'error: no binding';
    } catch (e) {
      hashCodeText = 'error: $e';
    }
    try {
      // There is no public observer count; we infer from addObserver side
      // effects in the host. Display '?' if unavailable.
      observerCount = _WbnSnapshot._probeObserverCount(binding);
    } catch (e) {
      observerCount = -1;
    }
    try {
      final ui.PlatformDispatcher? pd = binding?.platformDispatcher;
      final List<ui.Locale> ll = pd?.locales ?? const <ui.Locale>[];
      locales = ll.map((ui.Locale l) => l.toLanguageTag()).toList();
      if (locales.isEmpty) {
        locales = <String>['(no locales reported)'];
      }
      primaryLocale = ll.isNotEmpty ? ll.first.toLanguageTag() : 'n/a';
    } catch (e) {
      locales = <String>['error: $e'];
      primaryLocale = 'error';
    }
    try {
      final ui.PlatformDispatcher? pd = binding?.platformDispatcher;
      final ui.Brightness? b = pd?.platformBrightness;
      platformBrightness = b?.toString() ?? 'unknown';
    } catch (e) {
      platformBrightness = 'error: $e';
    }
    try {
      final Element? root = binding?.rootElement;
      if (root == null) {
        rootElementInfo = 'rootElement: null (pre-attach or detached)';
      } else {
        int direct = 0;
        try {
          root.visitChildren((Element _) {
            direct++;
          });
        } catch (_) {
          direct = -1;
        }
        rootElementInfo =
            'rootElement: ${root.runtimeType} (directChildren=$direct)';
      }
    } catch (e) {
      rootElementInfo = 'error: $e';
    }
    try {
      final BuildOwner? bo = binding?.buildOwner;
      buildOwnerInfo = bo == null
          ? 'buildOwner: null'
          : 'buildOwner: ${bo.runtimeType} #${bo.hashCode}';
    } catch (e) {
      buildOwnerInfo = 'error: $e';
    }
    try {
      // ignore: deprecated_member_use
      final PipelineOwner? po = binding?.pipelineOwner;
      pipelineOwnerInfo = po == null
          ? 'pipelineOwner: null'
          : 'pipelineOwner: ${po.runtimeType} #${po.hashCode}';
    } catch (e) {
      pipelineOwnerInfo = 'error: $e';
    }
    try {
      final ui.PlatformDispatcher? pd = binding?.platformDispatcher;
      platformDispatcherInfo = pd == null
          ? 'platformDispatcher: null'
          : 'platformDispatcher: ${pd.runtimeType} #${pd.hashCode}';
    } catch (e) {
      platformDispatcherInfo = 'error: $e';
    }
    try {
      final ui.AccessibilityFeatures? af =
          binding?.platformDispatcher.accessibilityFeatures;
      if (af == null) {
        accessibilityFeatures = 'accessibilityFeatures: null';
      } else {
        accessibilityFeatures = 'accessibilityFeatures: ${af.runtimeType}';
        accFlags['accessibleNavigation'] = af.accessibleNavigation;
        accFlags['boldText'] = af.boldText;
        accFlags['disableAnimations'] = af.disableAnimations;
        accFlags['highContrast'] = af.highContrast;
        accFlags['invertColors'] = af.invertColors;
        accFlags['reduceMotion'] = af.reduceMotion;
      }
    } catch (e) {
      accessibilityFeatures = 'error: $e';
    }
    try {
      final bool fired = binding?.firstFrameRasterized ?? false;
      firstFrameRasterized = fired ? 'true' : 'false';
    } catch (e) {
      firstFrameRasterized = 'error: $e';
    }

    return _WbnSnapshot(
      runtimeTypeName: runtimeTypeName,
      hashCodeText: hashCodeText,
      observerCount: observerCount,
      locales: locales,
      primaryLocale: primaryLocale,
      platformBrightness: platformBrightness,
      rootElementInfo: rootElementInfo,
      buildOwnerInfo: buildOwnerInfo,
      pipelineOwnerInfo: pipelineOwnerInfo,
      platformDispatcherInfo: platformDispatcherInfo,
      accessibilityFeatures: accessibilityFeatures,
      accFlags: accFlags,
      firstFrameRasterized: firstFrameRasterized,
    );
  }

  final String runtimeTypeName;
  final String hashCodeText;
  final int observerCount;
  final List<String> locales;
  final String primaryLocale;
  final String platformBrightness;
  final String rootElementInfo;
  final String buildOwnerInfo;
  final String pipelineOwnerInfo;
  final String platformDispatcherInfo;
  final String accessibilityFeatures;
  final Map<String, bool> accFlags;
  final String firstFrameRasterized;

  /// Best-effort probe of observer count — the public API does not expose a
  /// direct integer, so we attempt a few reflective paths. Returns -1 if
  /// nothing works.
  static int _probeObserverCount(WidgetsBinding? binding) {
    if (binding == null) return -1;
    // Try adding and removing a probe observer; the delta is not visible,
    // so return a conservative '>=1' signal by returning 1 when the public
    // surface is responsive. We treat this as a sentinel ("at least self").
    try {
      final _WbnProbeObserver probe = _WbnProbeObserver();
      binding.addObserver(probe);
      binding.removeObserver(probe);
      return 1;
    } catch (_) {
      return -1;
    }
  }
}

// Minimal probe observer — uses WidgetsBindingObserver as a mixin so all
// default no-op implementations are inherited. We only need add/remove to
// succeed to verify the observer surface is responsive.
class _WbnProbeObserver with WidgetsBindingObserver {
  _WbnProbeObserver();
}

// ---------------------------------------------------------------------------
// Engine-room AppBar — brass plate with rivets and the little status lamp.
// ---------------------------------------------------------------------------
class _WbnEngineAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const _WbnEngineAppBar({
    required this.title,
    required this.subtitle,
    required this.persistentInstalled,
  });

  final String title;
  final String subtitle;
  final bool persistentInstalled;

  @override
  Size get preferredSize => const Size.fromHeight(92);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[_kSteelDark, _kSteel, _kSteelDark],
        ),
        border: Border(
          bottom: BorderSide(color: _kBrass, width: 3),
        ),
      ),
      child: Stack(
        children: <Widget>[
          // Rivet row — a CustomPainter row along the brass rim.
          Positioned.fill(
            child: CustomPaint(painter: _WbnRivetRowPainter()),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // Boiler badge logo.
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: _kBrassDark,
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(color: _kBrassHi, width: 2),
                    boxShadow: const <BoxShadow>[
                      BoxShadow(
                        color: Color(0x55000000),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.settings_input_component,
                    color: _kInk,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          color: _kBrassHi,
                          letterSpacing: 1.6,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          color: _kInkDim,
                          fontSize: 12,
                          letterSpacing: 0.4,
                        ),
                      ),
                    ],
                  ),
                ),
                // Status lamp.
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _WbnLamp(on: persistentInstalled),
                    const SizedBox(height: 4),
                    Text(
                      persistentInstalled ? 'PERSIST' : 'NO HOOK',
                      style: const TextStyle(
                        color: _kInkDim,
                        fontSize: 10,
                        fontFamily: 'monospace',
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WbnLamp extends StatelessWidget {
  const _WbnLamp({required this.on});
  final bool on;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        color: on ? _kLamp : _kSteelLo,
        borderRadius: BorderRadius.circular(11),
        border: Border.all(color: _kBrass, width: 2),
        boxShadow: on
            ? const <BoxShadow>[
                BoxShadow(color: Color(0x88F6B85A), blurRadius: 10),
              ]
            : const <BoxShadow>[],
      ),
    );
  }
}

// Paints a horizontal row of rivets along the bottom brass rim.
class _WbnRivetRowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint rivet = Paint()..color = _kRivet;
    final Paint rivetHi = Paint()..color = _kBrassHi;
    const double y = 6;
    const double spacing = 26;
    for (double x = spacing / 2; x < size.width; x += spacing) {
      canvas.drawCircle(Offset(x, size.height - y - 4), 3.2, rivet);
      canvas.drawCircle(Offset(x - 0.8, size.height - y - 4.8), 1.2, rivetHi);
    }
  }

  @override
  bool shouldRepaint(_WbnRivetRowPainter oldDelegate) => false;
}

// ---------------------------------------------------------------------------
// Pipe backdrop — subtle painted pipes running behind the scrolling content.
// ---------------------------------------------------------------------------
class _WbnPipeBackdrop extends StatelessWidget {
  const _WbnPipeBackdrop({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: CustomPaint(painter: _WbnPipeBackdropPainter()),
        ),
        child,
      ],
    );
  }
}

class _WbnPipeBackdropPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint pipe = Paint()
      ..color = _kPipe.withValues(alpha: 0.28)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 18;
    final Paint rim = Paint()
      ..color = _kBrassDark.withValues(alpha: 0.22)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 22;

    // Vertical pipes on the right margin.
    for (int i = 0; i < 3; i++) {
      final double x = size.width - 60 - i * 28;
      canvas.drawLine(
        Offset(x, 40),
        Offset(x, size.height - 40),
        rim,
      );
      canvas.drawLine(
        Offset(x, 40),
        Offset(x, size.height - 40),
        pipe,
      );
    }
    // Horizontal pipe near the top.
    canvas.drawLine(
      Offset(32, 24),
      Offset(size.width - 32, 24),
      rim,
    );
    canvas.drawLine(
      Offset(32, 24),
      Offset(size.width - 32, 24),
      pipe,
    );
  }

  @override
  bool shouldRepaint(_WbnPipeBackdropPainter oldDelegate) => false;
}

// ---------------------------------------------------------------------------
// Section header — a brass nameplate with a rivet on each side.
// ---------------------------------------------------------------------------
class _WbnSectionHeader extends StatelessWidget {
  const _WbnSectionHeader({
    required this.index,
    required this.title,
    required this.caption,
  });

  final int index;
  final String title;
  final String caption;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[_kBrassDark, _kBrass, _kBrassDark],
        ),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _kBrassHi, width: 2),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x66000000),
            offset: Offset(0, 4),
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: _kSteelLo,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: _kInk, width: 1.5),
            ),
            alignment: Alignment.center,
            child: Text(
              index.toString().padLeft(2, '0'),
              style: const TextStyle(
                color: _kBrassHi,
                fontWeight: FontWeight.w900,
                fontFamily: 'monospace',
                fontSize: 13,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: _kSteelLo,
                    letterSpacing: 1.4,
                  ),
                ),
                Text(
                  caption,
                  style: const TextStyle(
                    color: _kSteelLo,
                    fontSize: 11.5,
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            ),
          ),
          // Rivets on the right side.
          Row(
            children: List<Widget>.generate(3, (int i) {
              return Padding(
                padding: EdgeInsets.only(left: i == 0 ? 0 : 6),
                child: Container(
                  width: 9,
                  height: 9,
                  decoration: BoxDecoration(
                    color: _kBrassDark,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: _kBrassHi, width: 1),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 1 — Dossier deck. Six brass-trimmed cards.
// ---------------------------------------------------------------------------
class _WbnDossierDeck extends StatelessWidget {
  const _WbnDossierDeck();

  static const List<_WbnDossierEntry> _entries = <_WbnDossierEntry>[
    _WbnDossierEntry(
      icon: Icons.hub,
      title: 'Singleton by design',
      body:
          'WidgetsBinding.instance returns one globally installed binding per '
          'isolate. The concrete subclass is WidgetsFlutterBinding for app '
          'code, and TestWidgetsFlutterBinding under flutter_test. The same '
          'singleton participates in every frame and every platform message.',
    ),
    _WbnDossierEntry(
      icon: Icons.layers,
      title: 'Glue for all sub-bindings',
      body:
          'It mixes together SchedulerBinding (frame callbacks), GestureBinding '
          '(hit tests), RendererBinding (pipeline owner), PaintingBinding '
          '(image cache), SemanticsBinding (a11y), ServicesBinding (platform '
          'channels), and FoundationBinding (debug diagnostics).',
    ),
    _WbnDossierEntry(
      icon: Icons.wysiwyg,
      title: 'Owns the widget tree',
      body:
          'attachRootWidget(Widget) links your root Widget to an Element tree '
          'via buildOwner, and to a RenderObject tree via pipelineOwner. '
          'rootElement exposes the freshly attached Element.',
    ),
    _WbnDossierEntry(
      icon: Icons.schedule,
      title: 'Drives the frame loop',
      body:
          'scheduleFrame() asks the embedder to produce a frame. handleBeginFrame '
          'and handleDrawFrame are called by the engine; ensureVisualUpdate is '
          'the polite nudge to schedule exactly enough work to refresh pixels.',
    ),
    _WbnDossierEntry(
      icon: Icons.visibility,
      title: 'Observer broadcast bus',
      body:
          'addObserver/removeObserver manage a list of WidgetsBindingObservers. '
          'They receive didChangeMetrics, didChangeLocales, lifecycle events, '
          'memory pressure, platform brightness, and accessibility changes.',
    ),
    _WbnDossierEntry(
      icon: Icons.timer,
      title: 'First-frame gate',
      body:
          'deferFirstFrame() increments a counter that blocks the first raster '
          'output; allowFirstFrame() decrements it. Use the pair to hold the '
          'splash until a critical async dependency resolves.',
    ),
    _WbnDossierEntry(
      icon: Icons.translate,
      title: 'Locale aware',
      body:
          'platformDispatcher.locales exposes the OS-preferred locale list. '
          'Observers receive didChangeLocales when the user changes system '
          'language, letting localisation stacks rebuild cleanly.',
    ),
    _WbnDossierEntry(
      icon: Icons.brightness_4,
      title: 'Dark-mode aware',
      body:
          'platformDispatcher.platformBrightness reports light or dark. '
          'didChangePlatformBrightness fires when the OS toggles mode so '
          'MaterialApp.themeMode of ThemeMode.system takes effect.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mq = MediaQuery.of(context);
    final int cols = mq.size.width > 1100
        ? 3
        : mq.size.width > 720
            ? 2
            : 1;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double gap = 14;
        final double cardWidth =
            (constraints.maxWidth - gap * (cols - 1)) / cols;
        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: <Widget>[
            for (final _WbnDossierEntry e in _entries)
              SizedBox(
                width: cardWidth,
                child: _WbnBrassCard(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: _kBrassDark,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: _kBrassHi,
                                  width: 1.5,
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Icon(e.icon, color: _kInk, size: 20),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                e.title,
                                style: const TextStyle(
                                  color: _kBrassHi,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          e.body,
                          style: const TextStyle(
                            color: _kInk,
                            height: 1.4,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _WbnDossierEntry {
  const _WbnDossierEntry({
    required this.icon,
    required this.title,
    required this.body,
  });
  final IconData icon;
  final String title;
  final String body;
}

// Brass-trimmed card with rivets at the four corners.
class _WbnBrassCard extends StatelessWidget {
  const _WbnBrassCard({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _kSteelDark,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kBrass, width: 1.5),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x66000000),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 8,
            top: 8,
            child: _WbnRivet(),
          ),
          Positioned(
            right: 8,
            top: 8,
            child: _WbnRivet(),
          ),
          Positioned(
            left: 8,
            bottom: 8,
            child: _WbnRivet(),
          ),
          Positioned(
            right: 8,
            bottom: 8,
            child: _WbnRivet(),
          ),
          child,
        ],
      ),
    );
  }
}

class _WbnRivet extends StatelessWidget {
  const _WbnRivet({this.size = 6});
  final double size;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: _kBrassDark,
        borderRadius: BorderRadius.circular(size),
        border: Border.all(color: _kBrassHi, width: 0.8),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 2 — Instance readout. A grid of labeled fields showing the live
// WidgetsBinding.instance values, each wrapped in try/catch.
// ---------------------------------------------------------------------------
class _WbnInstanceReadout extends StatelessWidget {
  const _WbnInstanceReadout({
    required this.snapshot,
    required this.onRefresh,
  });

  final _WbnSnapshot snapshot;
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    return _WbnBrassCard(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                const Icon(Icons.speed, color: _kBrassHi, size: 20),
                const SizedBox(width: 8),
                const Text(
                  'WidgetsBinding.instance — live readout',
                  style: TextStyle(
                    color: _kBrassHi,
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                  ),
                ),
                const Spacer(),
                OutlinedButton.icon(
                  onPressed: onRefresh,
                  icon: const Icon(Icons.refresh, size: 16),
                  label: const Text('REFRESH'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: _kBrassHi,
                    side: const BorderSide(color: _kBrass),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _WbnReadoutGrid(snapshot: snapshot),
            const SizedBox(height: 14),
            _WbnHelpBar(
              text:
                  'Each field wraps its read in try/catch. If introspection '
                  'throws under the d4rt interpreter, the value is surfaced '
                  'as "error: …" rather than crashing the demo.',
            ),
          ],
        ),
      ),
    );
  }
}

class _WbnReadoutGrid extends StatelessWidget {
  const _WbnReadoutGrid({required this.snapshot});
  final _WbnSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    final List<_WbnReadoutRow> rows = <_WbnReadoutRow>[
      _WbnReadoutRow('runtimeType', snapshot.runtimeTypeName),
      _WbnReadoutRow('hashCode', snapshot.hashCodeText),
      _WbnReadoutRow('observerCount (probed)',
          snapshot.observerCount < 0 ? 'unavailable' : '>= ${snapshot.observerCount}'),
      _WbnReadoutRow('primaryLocale', snapshot.primaryLocale),
      _WbnReadoutRow('locales.length', snapshot.locales.length.toString()),
      _WbnReadoutRow('platformBrightness', snapshot.platformBrightness),
      _WbnReadoutRow('firstFrameRasterized', snapshot.firstFrameRasterized),
      _WbnReadoutRow('platformDispatcher', snapshot.platformDispatcherInfo),
      _WbnReadoutRow('accessibilityFeatures', snapshot.accessibilityFeatures),
    ];
    return Column(
      children: <Widget>[
        for (int i = 0; i < rows.length; i++)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: i.isEven ? _kSteel : _kSteelLo,
              border: Border(
                bottom: i == rows.length - 1
                    ? BorderSide.none
                    : const BorderSide(color: _kSteel, width: 0.5),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 210,
                  child: Text(
                    rows[i].label,
                    style: const TextStyle(
                      color: _kInkDim,
                      fontFamily: 'monospace',
                      fontSize: 12.5,
                    ),
                  ),
                ),
                Expanded(
                  child: SelectableText(
                    rows[i].value,
                    style: TextStyle(
                      color: rows[i].value.startsWith('error:')
                          ? _kBoiler
                          : _kInk,
                      fontFamily: 'monospace',
                      fontSize: 12.5,
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

class _WbnReadoutRow {
  const _WbnReadoutRow(this.label, this.value);
  final String label;
  final String value;
}

class _WbnHelpBar extends StatelessWidget {
  const _WbnHelpBar({required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kGlass,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kGlassHi, width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Icon(Icons.info_outline, color: _kMint, size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: _kInkDim, fontSize: 12, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 3 — Frame timeline with two CustomPainter gauges.
// ---------------------------------------------------------------------------
class _WbnFrameTimeline extends StatelessWidget {
  const _WbnFrameTimeline({
    required this.postFrameCount,
    required this.persistentCount,
    required this.needle,
    required this.onPostFrame,
    required this.onReset,
    required this.wide,
  });

  final int postFrameCount;
  final int persistentCount;
  final Animation<double> needle;
  final VoidCallback onPostFrame;
  final VoidCallback onReset;
  final bool wide;

  @override
  Widget build(BuildContext context) {
    final Widget gaugeA = _WbnGauge(
      label: 'POST-FRAME',
      unit: 'callbacks',
      value: postFrameCount.toDouble(),
      maxValue: math.max(20, postFrameCount * 1.5),
      color: _kEmber,
      needle: needle,
    );
    final Widget gaugeB = _WbnGauge(
      label: 'PERSISTENT',
      unit: 'ticks',
      value: persistentCount.toDouble(),
      maxValue: math.max(60, persistentCount * 1.2),
      color: _kMint,
      needle: needle,
    );
    return _WbnBrassCard(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                const Icon(Icons.timeline, color: _kBrassHi),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'Frame telemetry — animated gauges',
                    style: TextStyle(
                      color: _kBrassHi,
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                    ),
                  ),
                ),
                _WbnPillButton(
                  icon: Icons.play_arrow,
                  label: 'POST-FRAME',
                  onTap: onPostFrame,
                ),
                const SizedBox(width: 8),
                _WbnPillButton(
                  icon: Icons.restart_alt,
                  label: 'RESET',
                  onTap: onReset,
                ),
              ],
            ),
            const SizedBox(height: 16),
            wide
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(child: gaugeA),
                      const SizedBox(width: 16),
                      Expanded(child: gaugeB),
                    ],
                  )
                : Column(
                    children: <Widget>[
                      gaugeA,
                      const SizedBox(height: 16),
                      gaugeB,
                    ],
                  ),
            const SizedBox(height: 12),
            _WbnCounterRow(
              items: <_WbnCounterChip>[
                _WbnCounterChip(
                  label: 'postFrame',
                  value: postFrameCount,
                  color: _kEmber,
                ),
                _WbnCounterChip(
                  label: 'persistent',
                  value: persistentCount,
                  color: _kMint,
                ),
              ],
            ),
            const SizedBox(height: 10),
            _WbnHelpBar(
              text:
                  'Post-frame callbacks run once after the next frame '
                  'finishes. Persistent frame callbacks run on every frame '
                  'until the binding is destroyed — never use them for '
                  'one-shot work.',
            ),
          ],
        ),
      ),
    );
  }
}

class _WbnCounterChip {
  const _WbnCounterChip({
    required this.label,
    required this.value,
    required this.color,
  });
  final String label;
  final int value;
  final Color color;
}

class _WbnCounterRow extends StatelessWidget {
  const _WbnCounterRow({required this.items});
  final List<_WbnCounterChip> items;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 8,
      children: <Widget>[
        for (final _WbnCounterChip c in items)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: _kGlass,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: c.color, width: 1),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: c.color,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  '${c.label}: ${c.value}',
                  style: const TextStyle(
                    color: _kInk,
                    fontFamily: 'monospace',
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _WbnPillButton extends StatelessWidget {
  const _WbnPillButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: _kBrassDark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: _kBrassHi),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(icon, color: _kInk, size: 14),
              const SizedBox(width: 6),
              Text(
                label,
                style: const TextStyle(
                  color: _kInk,
                  fontSize: 11,
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// The gauge itself — brass dial, glass face, swinging needle.
class _WbnGauge extends StatelessWidget {
  const _WbnGauge({
    required this.label,
    required this.unit,
    required this.value,
    required this.maxValue,
    required this.color,
    required this.needle,
  });
  final String label;
  final String unit;
  final double value;
  final double maxValue;
  final Color color;
  final Animation<double> needle;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: needle,
      builder: (BuildContext context, Widget? _) {
        // The animation adds a gentle oscillation around the real value.
        final double wobble = math.sin(needle.value * math.pi * 2) * 0.04;
        final double t =
            (value / (maxValue == 0 ? 1 : maxValue)).clamp(0.0, 1.0) + wobble;
        return Container(
          height: 200,
          decoration: BoxDecoration(
            color: _kSteelLo,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: _kBrass, width: 1.2),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: color.withValues(alpha: 0.8),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      label,
                      style: const TextStyle(
                        color: _kBrassHi,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.2,
                        fontSize: 12,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      value.toStringAsFixed(0),
                      style: const TextStyle(
                        color: _kInk,
                        fontFamily: 'monospace',
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      unit,
                      style: const TextStyle(
                        color: _kInkDim,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Expanded(
                  child: CustomPaint(
                    painter: _WbnGaugeNeedlePainter(
                      t: t.clamp(0.0, 1.0),
                      color: color,
                    ),
                    child: const SizedBox.expand(),
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

class _WbnGaugeNeedlePainter extends CustomPainter {
  _WbnGaugeNeedlePainter({required this.t, required this.color});
  final double t;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height * 0.9);
    final double radius = math.min(size.width / 2 - 8, size.height * 0.85);

    // Brass bezel.
    final Paint bezel = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..color = _kBrass;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      math.pi,
      math.pi,
      false,
      bezel,
    );

    // Inner glass.
    final Paint glass = Paint()
      ..style = PaintingStyle.fill
      ..shader = ui.Gradient.radial(
        center,
        radius,
        <Color>[_kGlassHi, _kGlass],
      );
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - 4),
      math.pi,
      math.pi,
      true,
      glass,
    );

    // Tick marks 0..10 across the semicircle.
    final Paint tick = Paint()
      ..color = _kInkDim
      ..strokeWidth = 1.4;
    final Paint majorTick = Paint()
      ..color = _kInk
      ..strokeWidth = 2.4;
    for (int i = 0; i <= 10; i++) {
      final double a = math.pi + (math.pi * i / 10);
      final double r1 = radius - 6;
      final double r2 = radius - (i % 5 == 0 ? 18 : 12);
      final Offset p1 =
          center + Offset(math.cos(a) * r1, math.sin(a) * r1);
      final Offset p2 =
          center + Offset(math.cos(a) * r2, math.sin(a) * r2);
      canvas.drawLine(p1, p2, i % 5 == 0 ? majorTick : tick);
    }

    // Coloured arc up to t.
    final Paint fillArc = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round
      ..color = color.withValues(alpha: 0.8);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - 26),
      math.pi,
      math.pi * t,
      false,
      fillArc,
    );

    // Needle.
    final double needleAngle = math.pi + math.pi * t;
    final Offset tip = center +
        Offset(math.cos(needleAngle) * (radius - 14),
            math.sin(needleAngle) * (radius - 14));
    final Paint needlePaint = Paint()
      ..color = _kBoiler
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(center, tip, needlePaint);

    // Hub.
    final Paint hub = Paint()..color = _kBrassDark;
    final Paint hubHi = Paint()..color = _kBrassHi;
    canvas.drawCircle(center, 8, hub);
    canvas.drawCircle(center, 3, hubHi);
  }

  @override
  bool shouldRepaint(_WbnGaugeNeedlePainter oldDelegate) =>
      oldDelegate.t != t || oldDelegate.color != color;
}

// ---------------------------------------------------------------------------
// Section 4 — Scheduler showcase. Buttons wired to scheduleFrame,
// ensureVisualUpdate, deferFirstFrame, allowFirstFrame; a rolling log
// renders into a glass console.
// ---------------------------------------------------------------------------
class _WbnSchedulerShowcase extends StatelessWidget {
  const _WbnSchedulerShowcase({
    required this.scheduleFrameCalls,
    required this.ensureVisualUpdateCalls,
    required this.deferFirstFrameCalls,
    required this.allowFirstFrameCalls,
    required this.log,
    required this.onScheduleFrame,
    required this.onEnsureVisualUpdate,
    required this.onDeferFirstFrame,
    required this.onAllowFirstFrame,
    required this.onReset,
  });

  final int scheduleFrameCalls;
  final int ensureVisualUpdateCalls;
  final int deferFirstFrameCalls;
  final int allowFirstFrameCalls;
  final List<String> log;
  final VoidCallback onScheduleFrame;
  final VoidCallback onEnsureVisualUpdate;
  final VoidCallback onDeferFirstFrame;
  final VoidCallback onAllowFirstFrame;
  final VoidCallback onReset;

  @override
  Widget build(BuildContext context) {
    return _WbnBrassCard(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Row(
              children: <Widget>[
                Icon(Icons.flash_on, color: _kBrassHi),
                SizedBox(width: 8),
                Text(
                  'Scheduler valves',
                  style: TextStyle(
                    color: _kBrassHi,
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: <Widget>[
                _WbnValveButton(
                  icon: Icons.alt_route,
                  label: 'scheduleFrame()',
                  count: scheduleFrameCalls,
                  color: _kEmber,
                  onTap: onScheduleFrame,
                ),
                _WbnValveButton(
                  icon: Icons.refresh,
                  label: 'ensureVisualUpdate()',
                  count: ensureVisualUpdateCalls,
                  color: _kMint,
                  onTap: onEnsureVisualUpdate,
                ),
                _WbnValveButton(
                  icon: Icons.pause_circle_outline,
                  label: 'deferFirstFrame()',
                  count: deferFirstFrameCalls,
                  color: _kLamp,
                  onTap: onDeferFirstFrame,
                ),
                _WbnValveButton(
                  icon: Icons.play_circle_outline,
                  label: 'allowFirstFrame()',
                  count: allowFirstFrameCalls,
                  color: _kCopper,
                  onTap: onAllowFirstFrame,
                ),
                _WbnValveButton(
                  icon: Icons.delete_sweep,
                  label: 'CLEAR LOG',
                  count: 0,
                  color: _kBoiler,
                  onTap: onReset,
                ),
              ],
            ),
            const SizedBox(height: 14),
            _WbnLogConsole(title: 'SCHEDULER LOG', entries: log),
            const SizedBox(height: 10),
            _WbnHelpBar(
              text:
                  'scheduleFrame() explicitly requests a frame. '
                  'ensureVisualUpdate() only schedules one if nothing else '
                  'will. deferFirstFrame/allowFirstFrame pair up to hold and '
                  'release the initial raster gate.',
            ),
          ],
        ),
      ),
    );
  }
}

class _WbnValveButton extends StatelessWidget {
  const _WbnValveButton({
    required this.icon,
    required this.label,
    required this.count,
    required this.color,
    required this.onTap,
  });
  final IconData icon;
  final String label;
  final int count;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: _kSteel,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: color, width: 1.4),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.18),
                  border: Border.all(color: color, width: 1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(icon, color: color, size: 16),
              ),
              const SizedBox(width: 10),
              Text(
                label,
                style: const TextStyle(
                  color: _kInk,
                  fontFamily: 'monospace',
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
              if (count > 0) ...<Widget>[
                const SizedBox(width: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    count.toString(),
                    style: const TextStyle(
                      color: _kSteelLo,
                      fontSize: 11,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _WbnLogConsole extends StatelessWidget {
  const _WbnLogConsole({required this.title, required this.entries});
  final String title;
  final List<String> entries;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        color: _kGlass,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kGlassHi, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: const BoxDecoration(
              color: _kSteelLo,
              borderRadius: BorderRadius.vertical(top: Radius.circular(9)),
            ),
            child: Row(
              children: <Widget>[
                const Icon(Icons.terminal, size: 14, color: _kMint),
                const SizedBox(width: 6),
                Text(
                  title,
                  style: const TextStyle(
                    color: _kMint,
                    fontFamily: 'monospace',
                    fontSize: 11,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                Text(
                  '${entries.length} line(s)',
                  style: const TextStyle(
                    color: _kInkDim,
                    fontFamily: 'monospace',
                    fontSize: 10.5,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: entries.isEmpty
                ? const Center(
                    child: Text(
                      '— no events yet —',
                      style: TextStyle(color: _kInkDim, fontSize: 12),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: entries.length,
                    itemBuilder: (BuildContext context, int i) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Text(
                          entries[i],
                          style: const TextStyle(
                            color: _kInk,
                            fontFamily: 'monospace',
                            fontSize: 11.5,
                            height: 1.25,
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 5 — Observer roster. Shows the inline observer status and the log.
// ---------------------------------------------------------------------------
class _WbnObserverRoster extends StatelessWidget {
  const _WbnObserverRoster({
    required this.observerCount,
    required this.log,
  });
  final int observerCount;
  final List<String> log;

  @override
  Widget build(BuildContext context) {
    return _WbnBrassCard(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                const Icon(Icons.visibility, color: _kBrassHi),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'WidgetsBindingObserver — live roster',
                    style: TextStyle(
                      color: _kBrassHi,
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: _kSteel,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: _kBrass),
                  ),
                  child: Text(
                    observerCount < 0
                        ? 'count: unavailable'
                        : 'observers ≥ $observerCount',
                    style: const TextStyle(
                      color: _kInk,
                      fontFamily: 'monospace',
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const _WbnObserverContract(),
            const SizedBox(height: 12),
            _WbnLogConsole(title: 'OBSERVER LOG', entries: log),
            const SizedBox(height: 10),
            _WbnHelpBar(
              text:
                  'This demo registers an observer in initState and '
                  'deregisters it in dispose. All callback hooks append to '
                  'the log above. Observers should always be removed before '
                  'their owner is destroyed to avoid leaks.',
            ),
          ],
        ),
      ),
    );
  }
}

class _WbnObserverContract extends StatelessWidget {
  const _WbnObserverContract();
  static const List<_WbnObserverHook> _hooks = <_WbnObserverHook>[
    _WbnObserverHook(
      name: 'didChangeMetrics',
      role: 'Window size, padding, or insets changed.',
    ),
    _WbnObserverHook(
      name: 'didChangeTextScaleFactor',
      role: 'System text scale changed (accessibility slider).',
    ),
    _WbnObserverHook(
      name: 'didChangePlatformBrightness',
      role: 'OS flipped between light and dark mode.',
    ),
    _WbnObserverHook(
      name: 'didChangeLocales',
      role: 'Preferred locale list changed.',
    ),
    _WbnObserverHook(
      name: 'didChangeAppLifecycleState',
      role: 'resumed / inactive / paused / detached / hidden.',
    ),
    _WbnObserverHook(
      name: 'didHaveMemoryPressure',
      role: 'OS signalled low memory — drop caches.',
    ),
    _WbnObserverHook(
      name: 'didChangeAccessibilityFeatures',
      role: 'A11y flags toggled (bold text, reduce motion …).',
    ),
    _WbnObserverHook(
      name: 'didPushRouteInformation',
      role: 'Deep link or system navigation arrived.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        for (final _WbnObserverHook h in _hooks)
          Container(
            margin: const EdgeInsets.only(bottom: 6),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: _kSteel,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _kRivet, width: 0.6),
            ),
            child: Row(
              children: <Widget>[
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: _kMint,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 230,
                  child: Text(
                    h.name,
                    style: const TextStyle(
                      color: _kBrassHi,
                      fontFamily: 'monospace',
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    h.role,
                    style: const TextStyle(color: _kInk, fontSize: 12.5),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _WbnObserverHook {
  const _WbnObserverHook({required this.name, required this.role});
  final String name;
  final String role;
}

// ---------------------------------------------------------------------------
// Section 6 — Pipeline card. Widget → Element → RenderObject diagram.
// ---------------------------------------------------------------------------
class _WbnPipelineCard extends StatelessWidget {
  const _WbnPipelineCard({required this.snapshot});
  final _WbnSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return _WbnBrassCard(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Row(
              children: <Widget>[
                Icon(Icons.account_tree, color: _kBrassHi),
                SizedBox(width: 8),
                Text(
                  'Pipeline — Widget → Element → RenderObject',
                  style: TextStyle(
                    color: _kBrassHi,
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const _WbnPipelineDiagram(),
            const SizedBox(height: 14),
            _WbnIntrospectionLine(label: 'rootElement', value: snapshot.rootElementInfo),
            _WbnIntrospectionLine(label: 'buildOwner', value: snapshot.buildOwnerInfo),
            _WbnIntrospectionLine(label: 'pipelineOwner', value: snapshot.pipelineOwnerInfo),
            const SizedBox(height: 10),
            _WbnHelpBar(
              text:
                  'buildOwner schedules element rebuilds; pipelineOwner '
                  'coordinates layout, paint, compositing, and semantics '
                  'passes. rootElement is null until runApp finishes '
                  'attaching the first widget.',
            ),
          ],
        ),
      ),
    );
  }
}

class _WbnIntrospectionLine extends StatelessWidget {
  const _WbnIntrospectionLine({required this.label, required this.value});
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 150,
            child: Text(
              label,
              style: const TextStyle(
                color: _kInkDim,
                fontFamily: 'monospace',
                fontSize: 12,
              ),
            ),
          ),
          Expanded(
            child: SelectableText(
              value,
              style: TextStyle(
                color: value.startsWith('error:') ? _kBoiler : _kInk,
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

class _WbnPipelineDiagram extends StatelessWidget {
  const _WbnPipelineDiagram();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: _WbnPipelineNode(
            color: _kMint,
            title: 'Widget',
            subtitle: 'Config / blueprint',
            icon: Icons.description,
          ),
        ),
        const _WbnPipelineArrow(),
        Expanded(
          child: _WbnPipelineNode(
            color: _kEmber,
            title: 'Element',
            subtitle: 'Lifetime / identity',
            icon: Icons.apartment,
          ),
        ),
        const _WbnPipelineArrow(),
        Expanded(
          child: _WbnPipelineNode(
            color: _kLamp,
            title: 'RenderObject',
            subtitle: 'Layout & paint',
            icon: Icons.brush,
          ),
        ),
      ],
    );
  }
}

class _WbnPipelineNode extends StatelessWidget {
  const _WbnPipelineNode({
    required this.color,
    required this.title,
    required this.subtitle,
    required this.icon,
  });
  final Color color;
  final String title;
  final String subtitle;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kSteel,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color, width: 1.5),
      ),
      child: Column(
        children: <Widget>[
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.18),
              border: Border.all(color: color, width: 1.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              color: _kBrassHi,
              fontWeight: FontWeight.w900,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(color: _kInkDim, fontSize: 11.5),
          ),
        ],
      ),
    );
  }
}

class _WbnPipelineArrow extends StatelessWidget {
  const _WbnPipelineArrow();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Icon(Icons.arrow_forward, color: _kInkDim),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 7 — Locale / brightness card.
// ---------------------------------------------------------------------------
class _WbnLocaleCard extends StatelessWidget {
  const _WbnLocaleCard({required this.snapshot});
  final _WbnSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    final bool isDark = snapshot.platformBrightness.contains('dark');
    return _WbnBrassCard(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Row(
              children: <Widget>[
                Icon(Icons.public, color: _kBrassHi),
                SizedBox(width: 8),
                Text(
                  'Locale & platform brightness',
                  style: TextStyle(
                    color: _kBrassHi,
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                for (final String l in snapshot.locales)
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: _kSteel,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: _kBrass),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const Icon(Icons.flag, color: _kEmber, size: 14),
                        const SizedBox(width: 6),
                        Text(
                          l,
                          style: const TextStyle(
                            color: _kInk,
                            fontFamily: 'monospace',
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isDark ? _kSteelLo : _kLamp.withValues(alpha: 0.15),
                    border: Border.all(color: _kBrass),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    isDark ? Icons.dark_mode : Icons.light_mode,
                    color: isDark ? _kInk : _kLamp,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        'platformDispatcher.platformBrightness',
                        style: TextStyle(
                          color: _kInkDim,
                          fontFamily: 'monospace',
                          fontSize: 11.5,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        snapshot.platformBrightness,
                        style: const TextStyle(
                          color: _kInk,
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            _WbnHelpBar(
              text:
                  'Prefer WidgetsBinding.instance.platformDispatcher over the '
                  'deprecated `window` getter. PlatformDispatcher exposes the '
                  'same locales/brightness API without assuming a single view.',
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 8 — Accessibility card. Real-read switches (read-only) plus sim.
// ---------------------------------------------------------------------------
class _WbnAccessibilityCard extends StatelessWidget {
  const _WbnAccessibilityCard({
    required this.snapshot,
    required this.simHighContrast,
    required this.simBoldText,
    required this.simDisableAnimations,
    required this.simReduceMotion,
    required this.simInvertColors,
    required this.simAccessibleNavigation,
    required this.onSimHighContrast,
    required this.onSimBoldText,
    required this.onSimDisableAnimations,
    required this.onSimReduceMotion,
    required this.onSimInvertColors,
    required this.onSimAccessibleNavigation,
  });
  final _WbnSnapshot snapshot;
  final bool simHighContrast;
  final bool simBoldText;
  final bool simDisableAnimations;
  final bool simReduceMotion;
  final bool simInvertColors;
  final bool simAccessibleNavigation;
  final ValueChanged<bool> onSimHighContrast;
  final ValueChanged<bool> onSimBoldText;
  final ValueChanged<bool> onSimDisableAnimations;
  final ValueChanged<bool> onSimReduceMotion;
  final ValueChanged<bool> onSimInvertColors;
  final ValueChanged<bool> onSimAccessibleNavigation;

  @override
  Widget build(BuildContext context) {
    final Map<String, bool> real = snapshot.accFlags;
    final bool haveReal = real.isNotEmpty;
    return _WbnBrassCard(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                const Icon(Icons.accessibility_new, color: _kBrassHi),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'accessibilityFeatures',
                    style: TextStyle(
                      color: _kBrassHi,
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: haveReal
                        ? _kMint.withValues(alpha: 0.2)
                        : _kBoiler.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: haveReal ? _kMint : _kBoiler,
                    ),
                  ),
                  child: Text(
                    haveReal ? 'LIVE READ' : 'SIMULATED',
                    style: TextStyle(
                      color: haveReal ? _kMint : _kBoiler,
                      fontFamily: 'monospace',
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (haveReal)
              Column(
                children: <Widget>[
                  for (final String key in real.keys)
                    _WbnAccRow(
                      label: key,
                      on: real[key] ?? false,
                      readOnly: true,
                      onChanged: (_) {},
                    ),
                ],
              )
            else
              Column(
                children: <Widget>[
                  _WbnAccRow(
                    label: 'highContrast (simulated)',
                    on: simHighContrast,
                    readOnly: false,
                    onChanged: onSimHighContrast,
                  ),
                  _WbnAccRow(
                    label: 'boldText (simulated)',
                    on: simBoldText,
                    readOnly: false,
                    onChanged: onSimBoldText,
                  ),
                  _WbnAccRow(
                    label: 'disableAnimations (simulated)',
                    on: simDisableAnimations,
                    readOnly: false,
                    onChanged: onSimDisableAnimations,
                  ),
                  _WbnAccRow(
                    label: 'reduceMotion (simulated)',
                    on: simReduceMotion,
                    readOnly: false,
                    onChanged: onSimReduceMotion,
                  ),
                  _WbnAccRow(
                    label: 'invertColors (simulated)',
                    on: simInvertColors,
                    readOnly: false,
                    onChanged: onSimInvertColors,
                  ),
                  _WbnAccRow(
                    label: 'accessibleNavigation (simulated)',
                    on: simAccessibleNavigation,
                    readOnly: false,
                    onChanged: onSimAccessibleNavigation,
                  ),
                ],
              ),
            const SizedBox(height: 10),
            _WbnHelpBar(
              text:
                  'Register a WidgetsBindingObserver and override '
                  'didChangeAccessibilityFeatures to be notified when these '
                  'flags flip. The AccessibilityFeatures object is '
                  'accessible via platformDispatcher.accessibilityFeatures.',
            ),
          ],
        ),
      ),
    );
  }
}

class _WbnAccRow extends StatelessWidget {
  const _WbnAccRow({
    required this.label,
    required this.on,
    required this.readOnly,
    required this.onChanged,
  });
  final String label;
  final bool on;
  final bool readOnly;
  final ValueChanged<bool> onChanged;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: _kSteel,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _kRivet, width: 0.6),
      ),
      child: Row(
        children: <Widget>[
          Icon(
            on ? Icons.check_circle : Icons.radio_button_unchecked,
            color: on ? _kMint : _kInkDim,
            size: 18,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                color: _kInk,
                fontFamily: 'monospace',
                fontSize: 12.5,
              ),
            ),
          ),
          Switch(
            value: on,
            onChanged: readOnly ? null : onChanged,
            activeThumbColor: _kMint,
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 9 — Recipe deck.
// ---------------------------------------------------------------------------
class _WbnRecipeDeck extends StatelessWidget {
  const _WbnRecipeDeck();

  static const List<_WbnRecipe> _recipes = <_WbnRecipe>[
    _WbnRecipe(
      icon: Icons.bolt,
      title: 'Post-frame initialisation',
      problem:
          'Need to access rendered size or open an overlay immediately after '
          'the first frame.',
      snippet:
          'WidgetsBinding.instance.addPostFrameCallback((_) {\n'
          '  final size = context.size;\n'
          '  _openTutorialOverlay(size);\n'
          '});',
      note:
          'Called from initState once. Runs after build/layout/paint of the '
          'current frame and before the next event turn.',
    ),
    _WbnRecipe(
      icon: Icons.pause_presentation,
      title: 'Defer the first frame',
      problem:
          'Need to block the first rendered pixel until the config JSON has '
          'been parsed from disk.',
      snippet:
          'WidgetsBinding.instance.deferFirstFrame();\n'
          'final cfg = await Config.load();\n'
          'runApp(MyApp(cfg));\n'
          'WidgetsBinding.instance.allowFirstFrame();',
      note:
          'Every deferFirstFrame() must be matched by allowFirstFrame() or '
          'the splash screen will never be replaced.',
    ),
    _WbnRecipe(
      icon: Icons.sync,
      title: 'Schedule a repaint after async data',
      problem:
          'A stream emitted new state; ensure exactly one repaint happens.',
      snippet:
          'stream.listen((data) {\n'
          '  setState(() => _data = data);\n'
          '  WidgetsBinding.instance.ensureVisualUpdate();\n'
          '});',
      note:
          'ensureVisualUpdate() is cheaper than scheduleFrame() and skips '
          'the request if a frame is already pending.',
    ),
    _WbnRecipe(
      icon: Icons.login,
      title: 'Add/remove observer correctly',
      problem:
          'Must react to app backgrounding to stop expensive streams.',
      snippet:
          'class _S extends State<W> with WidgetsBindingObserver {\n'
          '  @override void initState() {\n'
          '    super.initState();\n'
          '    WidgetsBinding.instance.addObserver(this);\n'
          '  }\n'
          '  @override void dispose() {\n'
          '    WidgetsBinding.instance.removeObserver(this);\n'
          '    super.dispose();\n'
          '  }\n'
          '}',
      note:
          'Forgetting removeObserver leaks the State into the observer list '
          'forever.',
    ),
    _WbnRecipe(
      icon: Icons.translate,
      title: 'Prefer platformDispatcher over window',
      problem:
          'Old code reads WidgetsBinding.instance.window, which is deprecated.',
      snippet:
          'final pd = WidgetsBinding.instance.platformDispatcher;\n'
          'final locales = pd.locales;\n'
          'final bright = pd.platformBrightness;',
      note:
          'PlatformDispatcher is multi-view safe and keeps working when '
          'Flutter embedders host more than one view.',
    ),
    _WbnRecipe(
      icon: Icons.memory,
      title: 'Respond to memory pressure',
      problem:
          'Free image caches when the OS warns us about low memory.',
      snippet:
          '@override\n'
          'void didHaveMemoryPressure() {\n'
          '  PaintingBinding.instance.imageCache.clear();\n'
          '}',
      note:
          'Combine with WidgetsBindingObserver to react to system-level '
          'memory events.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints c) {
        final int cols = c.maxWidth > 980
            ? 3
            : c.maxWidth > 640
                ? 2
                : 1;
        final double gap = 14;
        final double cardWidth = (c.maxWidth - gap * (cols - 1)) / cols;
        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: <Widget>[
            for (final _WbnRecipe r in _recipes)
              SizedBox(
                width: cardWidth,
                child: _WbnBrassCard(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(r.icon, color: _kEmber),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                r.title,
                                style: const TextStyle(
                                  color: _kBrassHi,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 14.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          r.problem,
                          style: const TextStyle(
                            color: _kInk,
                            fontSize: 12.5,
                            height: 1.35,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: _kGlass,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: _kGlassHi),
                          ),
                          child: Text(
                            r.snippet,
                            style: const TextStyle(
                              color: _kMint,
                              fontFamily: 'monospace',
                              fontSize: 11.5,
                              height: 1.35,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          r.note,
                          style: const TextStyle(
                            color: _kInkDim,
                            fontSize: 11.5,
                            fontStyle: FontStyle.italic,
                            height: 1.35,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _WbnRecipe {
  const _WbnRecipe({
    required this.icon,
    required this.title,
    required this.problem,
    required this.snippet,
    required this.note,
  });
  final IconData icon;
  final String title;
  final String problem;
  final String snippet;
  final String note;
}

// ---------------------------------------------------------------------------
// Section 10 — Comparison card.
// ---------------------------------------------------------------------------
class _WbnComparisonCard extends StatelessWidget {
  const _WbnComparisonCard();

  static const List<_WbnComparison> _rows = <_WbnComparison>[
    _WbnComparison(
      name: 'WidgetsBinding',
      kind: 'mixin / API surface',
      where: 'widgets/binding.dart',
      role:
          'The abstract contract — aggregates every sub-binding mixin and '
          'defines the public API the framework needs.',
      colour: _kBrassHi,
    ),
    _WbnComparison(
      name: 'WidgetsFlutterBinding',
      kind: 'concrete binding',
      where: 'widgets/binding.dart',
      role:
          'Instantiated by runApp(). Wires WidgetsBinding to the live engine, '
          'attaches the root widget and schedules the first frame.',
      colour: _kEmber,
    ),
    _WbnComparison(
      name: 'TestWidgetsFlutterBinding',
      kind: 'test binding',
      where: 'flutter_test/src/binding.dart',
      role:
          'Installed by testWidgets(). Uses a fake async clock, records frames, '
          'and lets tests pump frames deterministically.',
      colour: _kMint,
    ),
    _WbnComparison(
      name: 'ensureInitialized()',
      kind: 'bootstrap helper',
      where: 'static on WidgetsFlutterBinding',
      role:
          'Forces the binding singleton to exist early so platform channels '
          'can be used before runApp — e.g. Firebase.initializeApp().',
      colour: _kLamp,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return _WbnBrassCard(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Row(
              children: <Widget>[
                Icon(Icons.compare_arrows, color: _kBrassHi),
                SizedBox(width: 8),
                Text(
                  'Three bindings, one role — connecting framework and engine',
                  style: TextStyle(
                    color: _kBrassHi,
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            for (final _WbnComparison r in _rows)
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _kSteel,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: r.colour),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: r.colour.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: r.colour),
                          ),
                          child: Text(
                            r.kind,
                            style: TextStyle(
                              color: r.colour,
                              fontSize: 11,
                              fontFamily: 'monospace',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            r.name,
                            style: const TextStyle(
                              color: _kBrassHi,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'monospace',
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      r.where,
                      style: const TextStyle(
                        color: _kInkDim,
                        fontFamily: 'monospace',
                        fontSize: 11.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      r.role,
                      style: const TextStyle(
                        color: _kInk,
                        fontSize: 12.5,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _WbnComparison {
  const _WbnComparison({
    required this.name,
    required this.kind,
    required this.where,
    required this.role,
    required this.colour,
  });
  final String name;
  final String kind;
  final String where;
  final String role;
  final Color colour;
}

// ---------------------------------------------------------------------------
// Section 11 — Glossary / epilogue.
// ---------------------------------------------------------------------------
class _WbnGlossaryCard extends StatelessWidget {
  const _WbnGlossaryCard();

  static const List<_WbnGlossaryEntry> _entries = <_WbnGlossaryEntry>[
    _WbnGlossaryEntry(
      term: 'Binding',
      definition:
          'A mixin that connects a specific engine capability to the '
          'framework (scheduler, renderer, gestures, …).',
    ),
    _WbnGlossaryEntry(
      term: 'FrameCallback',
      definition:
          'A `void Function(Duration timeStamp)` invoked during the frame '
          'pipeline.',
    ),
    _WbnGlossaryEntry(
      term: 'PostFrameCallback',
      definition:
          'A one-shot FrameCallback that fires after the current frame is '
          'delivered to the GPU.',
    ),
    _WbnGlossaryEntry(
      term: 'PersistentFrameCallback',
      definition:
          'A FrameCallback that fires on every frame; used internally for '
          'animation tickers.',
    ),
    _WbnGlossaryEntry(
      term: 'BuildOwner',
      definition:
          'Owns the dirty element list and coordinates rebuild cycles for '
          'the Element tree.',
    ),
    _WbnGlossaryEntry(
      term: 'PipelineOwner',
      definition:
          'Drives layout, compositing bits, paint, and semantics phases '
          'across the RenderObject tree.',
    ),
    _WbnGlossaryEntry(
      term: 'rootElement',
      definition:
          'The root of the attached Element tree; null until runApp attaches '
          'the first widget.',
    ),
    _WbnGlossaryEntry(
      term: 'PlatformDispatcher',
      definition:
          'Engine-side hub for platform signals (locales, brightness, '
          'accessibility, views). Use it instead of `window`.',
    ),
    _WbnGlossaryEntry(
      term: 'TickerProvider',
      definition:
          'Supplier of Tickers used by AnimationControllers to receive '
          'per-frame callbacks.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return _WbnBrassCard(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Row(
              children: <Widget>[
                Icon(Icons.menu_book, color: _kBrassHi),
                SizedBox(width: 8),
                Text(
                  'Glossary & further reading',
                  style: TextStyle(
                    color: _kBrassHi,
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            for (final _WbnGlossaryEntry e in _entries)
              Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: _kSteel,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: _kRivet, width: 0.6),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: 180,
                      child: Text(
                        e.term,
                        style: const TextStyle(
                          color: _kBrassHi,
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.w800,
                          fontSize: 12.5,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        e.definition,
                        style: const TextStyle(
                          color: _kInk,
                          fontSize: 12.5,
                          height: 1.35,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 8),
            _WbnHelpBar(
              text:
                  'Remember: the binding is built exactly once. Treat '
                  'WidgetsBinding.instance as infrastructure — fetch it where '
                  'you need it, never cache it past widget lifetimes.',
            ),
          ],
        ),
      ),
    );
  }
}

class _WbnGlossaryEntry {
  const _WbnGlossaryEntry({required this.term, required this.definition});
  final String term;
  final String definition;
}

// ---------------------------------------------------------------------------
// Footer — brass bar with signature rivets.
// ---------------------------------------------------------------------------
class _WbnFooter extends StatelessWidget {
  const _WbnFooter();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[_kBrassDark, _kBrass, _kBrassDark],
        ),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kBrassHi, width: 1.5),
      ),
      child: Row(
        children: <Widget>[
          const _WbnRivet(size: 8),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'WidgetsBinding engine-room console — d4rt deep demo',
              style: TextStyle(
                color: _kSteelLo,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w800,
                letterSpacing: 1.2,
                fontSize: 12.5,
              ),
            ),
          ),
          Text(
            'kDebugMode=${kDebugMode ? "on" : "off"}',
            style: const TextStyle(
              color: _kSteelLo,
              fontFamily: 'monospace',
              fontSize: 11.5,
            ),
          ),
          const SizedBox(width: 12),
          const _WbnRivet(size: 8),
        ],
      ),
    );
  }
}
