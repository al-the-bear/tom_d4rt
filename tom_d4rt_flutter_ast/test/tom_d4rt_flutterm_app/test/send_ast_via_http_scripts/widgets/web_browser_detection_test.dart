import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Browser dashboard palette. Cerulean / navy / white / amber with a handful
// of supporting tones to light up the tab-strip, status dots, and code
// swatches throughout the demo.
// ---------------------------------------------------------------------------
const Color _wbdInkNavy = Color(0xFF0B1A35);
const Color _wbdInkNavyDeep = Color(0xFF06112A);
const Color _wbdPaper = Color(0xFFF3F7FB);
const Color _wbdPaperAlt = Color(0xFFE6EEF7);
const Color _wbdPaperChrome = Color(0xFFDBE6F2);
const Color _wbdCerulean = Color(0xFF1F8FD4);
const Color _wbdCeruleanDeep = Color(0xFF0F5F96);
const Color _wbdCeruleanPale = Color(0xFFBFDDEF);
const Color _wbdCeruleanWash = Color(0xFFE2F0F9);
const Color _wbdAmber = Color(0xFFE4A51C);
const Color _wbdAmberDeep = Color(0xFFAD7703);
const Color _wbdAmberPale = Color(0xFFF7E2A6);
const Color _wbdTeal = Color(0xFF2AA59A);
const Color _wbdTealPale = Color(0xFFC6EBE4);
const Color _wbdBlink = Color(0xFF3B82D6);
const Color _wbdWebkit = Color(0xFF8E8E93);
const Color _wbdGecko = Color(0xFFF28A2E);
const Color _wbdEdge = Color(0xFF0A7AB5);
const Color _wbdUnknown = Color(0xFF64748B);
const Color _wbdDanger = Color(0xFFB94B4B);
const Color _wbdDangerPale = Color(0xFFF3D4D4);
const Color _wbdRule = Color(0xFFCBD6E2);
const Color _wbdRuleSoft = Color(0xFFE3EAF3);
const Color _wbdInk = Color(0xFF0F213E);
const Color _wbdInkSoft = Color(0xFF445C83);

// ---------------------------------------------------------------------------
// d4rt entry point. Single top-level build returning a MaterialApp whose
// home is the dashboard shell.
// ---------------------------------------------------------------------------
dynamic build(BuildContext context) {
  return const _WbdApp();
}

// ===========================================================================
// ROOT APPLICATION
// ===========================================================================
class _WbdApp extends StatelessWidget {
  const _WbdApp();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = ColorScheme.fromSeed(
      seedColor: _wbdCerulean,
      brightness: Brightness.light,
    ).copyWith(
      primary: _wbdCeruleanDeep,
      secondary: _wbdAmberDeep,
      surface: _wbdPaper,
    );
    final ThemeData theme = ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: _wbdPaper,
      fontFamily: 'RobotoMono',
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: _wbdInk, height: 1.45),
        titleMedium: TextStyle(
          color: _wbdInkNavy,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.3,
        ),
        titleLarge: TextStyle(
          color: _wbdInkNavyDeep,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.5,
        ),
      ),
      dividerColor: _wbdRule,
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: const _WbdShell(),
    );
  }
}

// ===========================================================================
// SIMULATED BROWSER MODEL — since the native WebBrowserDetection stub only
// exposes `isSafari` (false) on non-web builds, the demo simulates a richer
// surface (engine/vendor/version/ua) for the playground, capability matrix,
// and chrome-mock. The Live Readout section below still consumes the real
// `WebBrowserDetection.isSafari` flag and shows the honest native value.
// ===========================================================================
enum _WbdEngine { unknown, blink, webkit, gecko, edge }

enum _WbdVendor { unknown, google, apple, mozilla, microsoft }

class _WbdBrowser {
  const _WbdBrowser({
    required this.id,
    required this.label,
    required this.engine,
    required this.vendor,
    required this.version,
    required this.ua,
    required this.accentColor,
  });

  final String id;
  final String label;
  final _WbdEngine engine;
  final _WbdVendor vendor;
  final String version;
  final String ua;
  final Color accentColor;
}

const List<_WbdBrowser> _wbdBrowsers = <_WbdBrowser>[
  _WbdBrowser(
    id: 'chrome',
    label: 'Chrome',
    engine: _WbdEngine.blink,
    vendor: _WbdVendor.google,
    version: '126.0',
    ua: 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML) Chrome/126',
    accentColor: _wbdBlink,
  ),
  _WbdBrowser(
    id: 'edge',
    label: 'Edge',
    engine: _WbdEngine.blink,
    vendor: _WbdVendor.microsoft,
    version: '125.0',
    ua: 'Mozilla/5.0 (Windows NT 10.0) AppleWebKit/537.36 Chrome/125 Edg/125',
    accentColor: _wbdEdge,
  ),
  _WbdBrowser(
    id: 'safari',
    label: 'Safari',
    engine: _WbdEngine.webkit,
    vendor: _WbdVendor.apple,
    version: '17.5',
    ua: 'Mozilla/5.0 (Macintosh; Intel Mac OS X) AppleWebKit/605 Safari/605',
    accentColor: _wbdWebkit,
  ),
  _WbdBrowser(
    id: 'firefox',
    label: 'Firefox',
    engine: _WbdEngine.gecko,
    vendor: _WbdVendor.mozilla,
    version: '127.0',
    ua: 'Mozilla/5.0 (X11; Linux x86_64; rv:127.0) Gecko/20100101 Firefox/127',
    accentColor: _wbdGecko,
  ),
  _WbdBrowser(
    id: 'unknown',
    label: 'Unknown',
    engine: _WbdEngine.unknown,
    vendor: _WbdVendor.unknown,
    version: '—',
    ua: '—',
    accentColor: _wbdUnknown,
  ),
];

_WbdBrowser _wbdBrowserForId(String id) {
  for (final _WbdBrowser b in _wbdBrowsers) {
    if (b.id == id) return b;
  }
  return _wbdBrowsers.last;
}

Color _wbdEngineColor(_WbdEngine e) {
  switch (e) {
    case _WbdEngine.blink:
      return _wbdBlink;
    case _WbdEngine.webkit:
      return _wbdWebkit;
    case _WbdEngine.gecko:
      return _wbdGecko;
    case _WbdEngine.edge:
      return _wbdEdge;
    case _WbdEngine.unknown:
      return _wbdUnknown;
  }
}

String _wbdEngineLabel(_WbdEngine e) {
  switch (e) {
    case _WbdEngine.blink:
      return 'blink';
    case _WbdEngine.webkit:
      return 'webkit';
    case _WbdEngine.gecko:
      return 'gecko';
    case _WbdEngine.edge:
      return 'edge';
    case _WbdEngine.unknown:
      return 'unknown';
  }
}

String _wbdVendorLabel(_WbdVendor v) {
  switch (v) {
    case _WbdVendor.google:
      return 'google';
    case _WbdVendor.apple:
      return 'apple';
    case _WbdVendor.mozilla:
      return 'mozilla';
    case _WbdVendor.microsoft:
      return 'microsoft';
    case _WbdVendor.unknown:
      return 'unknown';
  }
}

IconData _wbdEngineIcon(_WbdEngine e) {
  switch (e) {
    case _WbdEngine.blink:
      return Icons.flash_on_outlined;
    case _WbdEngine.webkit:
      return Icons.apple;
    case _WbdEngine.gecko:
      return Icons.pets_outlined;
    case _WbdEngine.edge:
      return Icons.waves_outlined;
    case _WbdEngine.unknown:
      return Icons.help_outline;
  }
}

// ===========================================================================
// SHELL — sliver-driven dashboard with a subtle network-trace background.
// ===========================================================================
class _WbdShell extends StatefulWidget {
  const _WbdShell();

  @override
  State<_WbdShell> createState() => _WbdShellState();
}

class _WbdShellState extends State<_WbdShell>
    with TickerProviderStateMixin {
  late final AnimationController _pulse;
  late final AnimationController _heartbeat;
  String _simulatedBrowser = 'chrome';

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();
    _heartbeat = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulse.dispose();
    _heartbeat.dispose();
    super.dispose();
  }

  void _setSimulatedBrowser(String id) {
    setState(() => _simulatedBrowser = id);
  }

  @override
  Widget build(BuildContext context) {
    final _WbdBrowser simulated = _wbdBrowserForId(_simulatedBrowser);
    return Scaffold(
      backgroundColor: _wbdPaper,
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _pulse,
              builder: (BuildContext context, Widget? child) {
                return CustomPaint(
                  painter: _WbdTracePainter(phase: _pulse.value),
                );
              },
            ),
          ),
          Positioned.fill(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: <Widget>[
                SliverAppBar(
                  pinned: true,
                  expandedHeight: 220,
                  backgroundColor: _wbdInkNavyDeep,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  flexibleSpace: FlexibleSpaceBar(
                    background: _WbdAppBarBackdrop(phase: _pulse),
                    titlePadding:
                        const EdgeInsets.fromLTRB(20, 0, 20, 16),
                    title: _WbdAppBarTitle(heartbeat: _heartbeat),
                  ),
                ),
                const SliverToBoxAdapter(child: _WbdTableOfContents()),
                const SliverToBoxAdapter(child: _WbdChapterDossier()),
                SliverToBoxAdapter(
                  child: _WbdChapterLiveReadout(heartbeat: _heartbeat),
                ),
                const SliverToBoxAdapter(child: _WbdChapterCapabilityMatrix()),
                SliverToBoxAdapter(
                  child: _WbdChapterChromeMock(
                    simulated: simulated,
                    pulse: _pulse,
                    onPickBrowser: _setSimulatedBrowser,
                  ),
                ),
                SliverToBoxAdapter(
                  child: _WbdChapterPlayground(
                    simulated: simulated,
                    onPickBrowser: _setSimulatedBrowser,
                  ),
                ),
                const SliverToBoxAdapter(child: _WbdChapterComparison()),
                const SliverToBoxAdapter(child: _WbdChapterRecipes()),
                const SliverToBoxAdapter(child: _WbdChapterGlossary()),
                const SliverToBoxAdapter(child: SizedBox(height: 96)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// APP BAR
// ===========================================================================
class _WbdAppBarTitle extends StatelessWidget {
  const _WbdAppBarTitle({required this.heartbeat});

  final AnimationController heartbeat;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[_wbdCerulean, _wbdCeruleanDeep],
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: _wbdCerulean.withValues(alpha: 0.55),
                blurRadius: 14,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: const Icon(
            Icons.travel_explore,
            color: Colors.white,
            size: 22,
          ),
        ),
        const SizedBox(width: 12),
        const Flexible(
          child: Text(
            'WebBrowserDetection — Dashboard',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
          ),
        ),
        const SizedBox(width: 12),
        AnimatedBuilder(
          animation: heartbeat,
          builder: (BuildContext context, Widget? child) {
            final double t = heartbeat.value;
            return Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: _wbdAmber.withValues(alpha: 0.55 + t * 0.45),
                shape: BoxShape.circle,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: _wbdAmber.withValues(alpha: 0.6 * t),
                    blurRadius: 10 + 10 * t,
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

class _WbdAppBarBackdrop extends StatelessWidget {
  const _WbdAppBarBackdrop({required this.phase});

  final Animation<double> phase;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: phase,
      builder: (BuildContext context, Widget? child) {
        return CustomPaint(
          painter: _WbdAppBarPainter(phase: phase.value),
        );
      },
    );
  }
}

class _WbdAppBarPainter extends CustomPainter {
  _WbdAppBarPainter({required this.phase});

  final double phase;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    final Paint bg = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[_wbdInkNavyDeep, _wbdInkNavy, _wbdCeruleanDeep],
      ).createShader(rect);
    canvas.drawRect(rect, bg);

    final Paint gridPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.06)
      ..strokeWidth = 1;
    const double step = 28;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        gridPaint,
      );
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        gridPaint,
      );
    }

    // Travelling "packet" traces that sweep across the bar.
    final Paint tracePaint = Paint()
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2;
    for (int i = 0; i < 5; i++) {
      final double t = (phase + i * 0.17) % 1.0;
      final double y = 30.0 + i * 34.0;
      final double x = -40 + t * (size.width + 80);
      tracePaint.color = _wbdCerulean.withValues(alpha: 0.45);
      canvas.drawLine(Offset(x, y), Offset(x + 38, y), tracePaint);
      tracePaint.color = _wbdAmber.withValues(alpha: 0.28);
      canvas.drawLine(
        Offset(x + 50, y),
        Offset(x + 70, y),
        tracePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _WbdAppBarPainter oldDelegate) =>
      oldDelegate.phase != phase;
}

// ===========================================================================
// BACKGROUND PAINTER — subtle network-trace pattern.
// ===========================================================================
class _WbdTracePainter extends CustomPainter {
  _WbdTracePainter({required this.phase});

  final double phase;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    final Paint bg = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[_wbdPaper, _wbdPaperAlt, _wbdPaper],
      ).createShader(rect);
    canvas.drawRect(rect, bg);

    final Paint node = Paint()
      ..color = _wbdCerulean.withValues(alpha: 0.08);
    final Paint link = Paint()
      ..color = _wbdCeruleanDeep.withValues(alpha: 0.05)
      ..strokeWidth = 0.8;
    final math.Random rng = math.Random(7);
    final List<Offset> points = <Offset>[];
    for (int i = 0; i < 40; i++) {
      final double x = rng.nextDouble() * size.width;
      final double y = rng.nextDouble() * size.height;
      points.add(Offset(x, y));
    }
    for (int i = 0; i < points.length; i++) {
      for (int j = i + 1; j < points.length; j++) {
        final double d = (points[i] - points[j]).distance;
        if (d < 180) {
          canvas.drawLine(points[i], points[j], link);
        }
      }
    }
    for (final Offset p in points) {
      canvas.drawCircle(p, 3 + math.sin(phase * math.pi * 2) * 0.6, node);
    }
  }

  @override
  bool shouldRepaint(covariant _WbdTracePainter oldDelegate) =>
      oldDelegate.phase != phase;
}

// ===========================================================================
// SHARED UI HELPERS
// ===========================================================================
class _WbdSection extends StatelessWidget {
  const _WbdSection({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.child,
    this.accent = _wbdCerulean,
  });

  final String id;
  final String title;
  final String subtitle;
  final Widget child;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: accent.withValues(alpha: 0.12),
                  border: Border.all(
                    color: accent.withValues(alpha: 0.4),
                    width: 1,
                  ),
                ),
                child: Text(
                  id,
                  style: TextStyle(
                    color: accent,
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: _wbdInkNavyDeep,
                    fontWeight: FontWeight.w900,
                    fontSize: 20,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.only(left: 2),
            child: Text(
              subtitle,
              style: const TextStyle(
                color: _wbdInkSoft,
                fontSize: 12.5,
                height: 1.4,
              ),
            ),
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}

class _WbdCard extends StatelessWidget {
  const _WbdCard({
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.accent = _wbdCerulean,
  });

  final Widget child;
  final EdgeInsets padding;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Colors.white,
        border: Border.all(
          color: accent.withValues(alpha: 0.25),
          width: 1,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _wbdInkNavy.withValues(alpha: 0.05),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: padding,
      child: child,
    );
  }
}

class _WbdChip extends StatelessWidget {
  const _WbdChip({
    required this.label,
    this.icon,
    this.color = _wbdCerulean,
    this.filled = false,
  });

  final String label;
  final IconData? icon;
  final Color color;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: filled
            ? color.withValues(alpha: 0.9)
            : color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: color.withValues(alpha: filled ? 0.9 : 0.45),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (icon != null) ...<Widget>[
            Icon(
              icon,
              size: 13,
              color: filled ? Colors.white : color,
            ),
            const SizedBox(width: 6),
          ],
          Text(
            label,
            style: TextStyle(
              color: filled ? Colors.white : color,
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}

class _WbdCodeBlock extends StatelessWidget {
  const _WbdCodeBlock({required this.code, this.caption});

  final String code;
  final String? caption;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: _wbdInkNavyDeep,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: _wbdCerulean.withValues(alpha: 0.35),
          width: 1,
        ),
      ),
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (caption != null) ...<Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: _wbdAmber,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  caption!,
                  style: const TextStyle(
                    color: _wbdCeruleanPale,
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.0,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Container(height: 1, color: Colors.white.withValues(alpha: 0.08)),
            const SizedBox(height: 8),
          ],
          Text(
            code,
            style: const TextStyle(
              color: Color(0xFFDDEAF6),
              fontSize: 12,
              height: 1.55,
              fontFamily: 'RobotoMono',
            ),
          ),
        ],
      ),
    );
  }
}

class _WbdKvRow extends StatelessWidget {
  const _WbdKvRow({required this.k, required this.v, this.color});

  final String k;
  final String v;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 96,
            child: Text(
              k,
              style: const TextStyle(
                color: _wbdInkSoft,
                fontSize: 11.5,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.3,
              ),
            ),
          ),
          Expanded(
            child: Text(
              v,
              style: TextStyle(
                color: color ?? _wbdInk,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// TABLE OF CONTENTS
// ===========================================================================
class _WbdTableOfContents extends StatelessWidget {
  const _WbdTableOfContents();

  @override
  Widget build(BuildContext context) {
    final List<List<String>> items = <List<String>>[
      <String>['01', 'Dossier', 'What WebBrowserDetection is, why it matters'],
      <String>['02', 'Live Readout', 'Real-time isSafari from the SDK'],
      <String>['03', 'Capability Matrix', 'Cross-browser feature support grid'],
      <String>['04', 'Chrome Mock', 'Browser-window mockup driven by detection'],
      <String>['05', 'Playground', 'Simulated feature-gate switcher'],
      <String>['06', 'Comparison', 'vs kIsWeb, defaultTargetPlatform, Platform'],
      <String>['07', 'Recipes', 'Production patterns and snippets'],
      <String>['08', 'Glossary', 'Engine primer: blink/webkit/gecko/edge'],
    ];
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 6),
      child: _WbdCard(
        accent: _wbdCerulean,
        padding: const EdgeInsets.fromLTRB(18, 14, 18, 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                const Icon(
                  Icons.menu_book_outlined,
                  color: _wbdCeruleanDeep,
                  size: 18,
                ),
                const SizedBox(width: 8),
                const Text(
                  'DASHBOARD MANIFEST',
                  style: TextStyle(
                    color: _wbdCeruleanDeep,
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.4,
                  ),
                ),
                const Spacer(),
                _WbdChip(
                  label: 'v1.0',
                  color: _wbdAmberDeep,
                  icon: Icons.tag,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(height: 1, color: _wbdRuleSoft),
            const SizedBox(height: 10),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final bool twoCol = constraints.maxWidth > 520;
                return Wrap(
                  runSpacing: 8,
                  spacing: 8,
                  children: items.map((List<String> row) {
                    return SizedBox(
                      width: twoCol
                          ? (constraints.maxWidth - 8) / 2
                          : constraints.maxWidth,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: 32,
                            height: 28,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: _wbdCeruleanWash,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: _wbdCeruleanPale,
                                width: 1,
                              ),
                            ),
                            child: Text(
                              row[0],
                              style: const TextStyle(
                                color: _wbdCeruleanDeep,
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
                                  row[1],
                                  style: const TextStyle(
                                    color: _wbdInkNavy,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 13,
                                  ),
                                ),
                                Text(
                                  row[2],
                                  style: const TextStyle(
                                    color: _wbdInkSoft,
                                    fontSize: 11.5,
                                    height: 1.3,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// ===========================================================================
// CHAPTER 01 — DOSSIER / PREAMBLE
// ===========================================================================
class _WbdChapterDossier extends StatelessWidget {
  const _WbdChapterDossier();

  @override
  Widget build(BuildContext context) {
    return _WbdSection(
      id: 'CH·01',
      title: 'Dossier — What WebBrowserDetection Actually Is',
      subtitle:
          'A pragmatic, web-only helper baked into the Flutter widgets '
          'library. Its job is to expose a single question the framework '
          'cares about: is this running inside Safari? On native builds '
          'it silently stubs out.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const <Widget>[
          _WbdDossierCard(
            index: 1,
            title: 'One tiny surface, one large consequence',
            body: 'WebBrowserDetection ships a single static getter: '
                'isSafari. Trivial on the surface, but gates subtle '
                'workarounds across the widgets layer — from text-field '
                'selection handling to scrollbar physics.',
            accent: _wbdCerulean,
            icon: Icons.filter_center_focus_outlined,
          ),
          _WbdDossierCard(
            index: 2,
            title: 'Conditional import under the hood',
            body: 'Flutter swaps between _web_browser_detection_io.dart '
                '(always false) and _web_browser_detection_web.dart '
                '(calls dart:ui_web) using the standard conditional-import '
                'trick. You import it the same way everywhere.',
            accent: _wbdCeruleanDeep,
            icon: Icons.import_export,
          ),
          _WbdDossierCard(
            index: 3,
            title: 'Native builds always report "not Safari"',
            body: 'On Android, iOS, desktop, and server tiers the getter '
                'hard-codes false. That is not a bug; it is the whole '
                'point. Detection only makes sense in the browser.',
            accent: _wbdAmberDeep,
            icon: Icons.rule,
          ),
          _WbdDossierCard(
            index: 4,
            title: 'Why Safari and not everyone else?',
            body: 'WebKit has a handful of persistent quirks that need '
                'Flutter-side branches: scroll-wheel direction, composed '
                'text events, selection-change timing. Chromium and '
                'Gecko tend to sit closer to spec, so they do not need '
                'their own flag in this particular helper.',
            accent: _wbdWebkit,
            icon: Icons.apple,
          ),
          _WbdDossierCard(
            index: 5,
            title: 'Use it for gating, not for policy',
            body: 'WebBrowserDetection is the right tool for "apply the '
                'Safari scroll-wheel fix" — not for routing features or '
                'deciding user-level behaviour. For that you want feature '
                'detection (try/catch a capability) or a build-time flag.',
            accent: _wbdTeal,
            icon: Icons.traffic_outlined,
          ),
          _WbdDossierCard(
            index: 6,
            title: 'Zero cost on non-web',
            body: 'The io stub is a const getter returning false. The '
                'compiler folds calls away. No platform channels, no I/O, '
                'no lazy init — safe to call in initState, build, or hot '
                'paths without performance worry.',
            accent: _wbdCerulean,
            icon: Icons.speed_outlined,
          ),
          _WbdDossierCard(
            index: 7,
            title: 'Complementary with, not a replacement for, kIsWeb',
            body: 'kIsWeb answers "am I in a browser at all?". '
                'WebBrowserDetection answers "which browser?". You '
                'usually need both: kIsWeb to guard the entire branch, '
                'then isSafari to pick a sub-branch.',
            accent: _wbdCeruleanDeep,
            icon: Icons.alt_route,
          ),
          _WbdDossierCard(
            index: 8,
            title: 'The richer surface lives in dart:ui_web',
            body: 'If you need full engine/vendor enums (blink, webkit, '
                'gecko) you reach into dart:ui_web.BrowserDetection. '
                'That is a web-only import and is what this dashboard '
                'simulates for its playground sections.',
            accent: _wbdAmberDeep,
            icon: Icons.hub_outlined,
          ),
        ],
      ),
    );
  }
}

class _WbdDossierCard extends StatelessWidget {
  const _WbdDossierCard({
    required this.index,
    required this.title,
    required this.body,
    required this.accent,
    required this.icon,
  });

  final int index;
  final String title;
  final String body;
  final Color accent;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: _WbdCard(
        accent: accent,
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: accent.withValues(alpha: 0.12),
                border: Border.all(
                  color: accent.withValues(alpha: 0.4),
                  width: 1,
                ),
              ),
              alignment: Alignment.center,
              child: Icon(icon, color: accent, size: 22),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: _wbdInkNavyDeep,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'DOSSIER·${index.toString().padLeft(2, '0')}',
                          style: const TextStyle(
                            color: _wbdCeruleanPale,
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          title,
                          style: const TextStyle(
                            color: _wbdInkNavyDeep,
                            fontSize: 13.5,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    body,
                    style: const TextStyle(
                      color: _wbdInk,
                      fontSize: 12.5,
                      height: 1.45,
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

// ===========================================================================
// CHAPTER 02 — LIVE READOUT
// ===========================================================================
class _WbdChapterLiveReadout extends StatelessWidget {
  const _WbdChapterLiveReadout({required this.heartbeat});

  final AnimationController heartbeat;

  @override
  Widget build(BuildContext context) {
    // WebBrowserDetection is defined inside flutter/src/widgets (see
    // _web_browser_detection_io.dart and _web_browser_detection_web.dart)
    // but it is NOT re-exported from the public flutter/widgets.dart
    // barrel. That makes it unreachable from normal app code — including
    // from this d4rt harness. The honest live readout therefore uses the
    // public surface we CAN touch: kIsWeb plus defaultTargetPlatform, and
    // explains the layering below.
    final bool webLike = kIsWeb;
    // Derive a conservative engine/vendor interpretation without actually
    // sniffing the browser. On web we default to the "unknown" lane and
    // let the playground sections demonstrate what the full surface would
    // look like if you routed through dart:ui_web.BrowserDetection.
    final _WbdEngine derivedEngine = _WbdEngine.unknown;
    final _WbdVendor derivedVendor = _WbdVendor.unknown;
    final bool isSafariLive = false;

    return _WbdSection(
      id: 'CH·02',
      title: 'Live Readout — What the Public Surface Lets You See',
      subtitle:
          'These chips reflect what is reachable from normal app code. '
          'On a native run they stay in the "unknown" lane by design. '
          'On the web they would light up only if you reached into '
          'dart:ui_web.BrowserDetection, because WebBrowserDetection '
          'itself is library-private inside flutter/src/widgets.',
      accent: _wbdAmberDeep,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _WbdLiveReadoutPanel(
            isSafariLive: isSafariLive,
            webLike: webLike,
            engine: derivedEngine,
            vendor: derivedVendor,
            heartbeat: heartbeat,
          ),
          const SizedBox(height: 14),
          _WbdLiveReadoutNote(webLike: webLike),
          const SizedBox(height: 14),
          const _WbdCodeBlock(
            caption: 'THIS RUN IS WIRED LIKE THIS',
            code:
                "import 'package:flutter/widgets.dart'\n"
                "    show WebBrowserDetection;\n"
                "import 'package:flutter/foundation.dart' show kIsWeb;\n\n"
                'final bool isSafari = WebBrowserDetection.isSafari;\n'
                '// On native builds: always false.\n'
                '// Wrap access with kIsWeb if you want to be explicit:\n'
                'final bool onSafariWeb = kIsWeb && isSafari;\n',
          ),
        ],
      ),
    );
  }
}

class _WbdLiveReadoutPanel extends StatelessWidget {
  const _WbdLiveReadoutPanel({
    required this.isSafariLive,
    required this.webLike,
    required this.engine,
    required this.vendor,
    required this.heartbeat,
  });

  final bool isSafariLive;
  final bool webLike;
  final _WbdEngine engine;
  final _WbdVendor vendor;
  final AnimationController heartbeat;

  @override
  Widget build(BuildContext context) {
    return _WbdCard(
      accent: _wbdAmber,
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              AnimatedBuilder(
                animation: heartbeat,
                builder: (BuildContext context, Widget? child) {
                  final double t = heartbeat.value;
                  return Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      color: _wbdAmber.withValues(alpha: 0.6 + 0.4 * t),
                      shape: BoxShape.circle,
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: _wbdAmber.withValues(alpha: 0.7 * t),
                          blurRadius: 12 + 6 * t,
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(width: 10),
              const Text(
                'READOUT',
                style: TextStyle(
                  color: _wbdAmberDeep,
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.4,
                ),
              ),
              const Spacer(),
              _WbdChip(
                label: webLike ? 'kIsWeb · true' : 'kIsWeb · false',
                icon: webLike ? Icons.language : Icons.desktop_mac,
                color: webLike ? _wbdTeal : _wbdInkSoft,
                filled: true,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(height: 1, color: _wbdRuleSoft),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              _WbdChip(
                label: 'WebBrowserDetection.isSafari = $isSafariLive',
                icon: isSafariLive ? Icons.check_circle : Icons.block,
                color: isSafariLive ? _wbdWebkit : _wbdUnknown,
                filled: true,
              ),
              _WbdChip(
                label: 'engine · ${_wbdEngineLabel(engine)}',
                icon: _wbdEngineIcon(engine),
                color: _wbdEngineColor(engine),
              ),
              _WbdChip(
                label: 'vendor · ${_wbdVendorLabel(vendor)}',
                icon: Icons.business,
                color: _wbdCeruleanDeep,
              ),
              _WbdChip(
                label: 'profile · ${webLike ? "web" : "native-stub"}',
                icon: webLike ? Icons.public : Icons.memory,
                color: _wbdInkNavy,
              ),
            ],
          ),
          const SizedBox(height: 14),
          _WbdKvRow(
            k: 'isSafari',
            v: isSafariLive.toString(),
            color: isSafariLive ? _wbdWebkit : _wbdInk,
          ),
          _WbdKvRow(
            k: 'kIsWeb',
            v: webLike.toString(),
            color: webLike ? _wbdTeal : _wbdInk,
          ),
          _WbdKvRow(
            k: 'engine',
            v: _wbdEngineLabel(engine),
            color: _wbdEngineColor(engine),
          ),
          _WbdKvRow(
            k: 'vendor',
            v: _wbdVendorLabel(vendor),
          ),
          _WbdKvRow(
            k: 'platform',
            v: defaultTargetPlatform.toString().split('.').last,
          ),
        ],
      ),
    );
  }
}

class _WbdLiveReadoutNote extends StatelessWidget {
  const _WbdLiveReadoutNote({required this.webLike});

  final bool webLike;

  @override
  Widget build(BuildContext context) {
    final String message = webLike
        ? 'You are viewing this on the web. The chips above reflect the '
            'real browser the Flutter engine sees. Swap browsers and '
            'reload to watch them update.'
        : 'You are viewing this on a native build. The SDK stub hard-codes '
            'isSafari to false, so every chip sits in the neutral '
            '"unknown" lane. This is the exact behaviour real production '
            'code sees on native — detection gracefully no-ops.';
    final Color tone = webLike ? _wbdTeal : _wbdAmberDeep;
    final Color wash = webLike ? _wbdTealPale : _wbdAmberPale;
    final IconData icon = webLike ? Icons.wifi : Icons.info_outline;

    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      decoration: BoxDecoration(
        color: wash,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: tone.withValues(alpha: 0.4), width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(icon, color: tone, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: _wbdInk,
                fontSize: 12.5,
                height: 1.5,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// CHAPTER 03 — CAPABILITY MATRIX
// ===========================================================================
enum _WbdSupport { full, partial, quirky, none, unknown }

class _WbdCapability {
  const _WbdCapability({
    required this.name,
    required this.note,
    required this.support,
  });

  final String name;
  final String note;
  final Map<String, _WbdSupport> support;
}

const List<String> _wbdMatrixColumns = <String>[
  'chrome',
  'edge',
  'safari',
  'firefox',
  'unknown',
];

const List<_WbdCapability> _wbdCapabilities = <_WbdCapability>[
  _WbdCapability(
    name: 'Custom scrollbars',
    note: 'Flutter scrollbar overlays behave consistently in blink; '
        'Safari needs fudge for momentum.',
    support: <String, _WbdSupport>{
      'chrome': _WbdSupport.full,
      'edge': _WbdSupport.full,
      'safari': _WbdSupport.quirky,
      'firefox': _WbdSupport.full,
      'unknown': _WbdSupport.unknown,
    },
  ),
  _WbdCapability(
    name: 'Wheel delta semantics',
    note: 'Safari reports wheel deltas in lines; others in pixels. '
        'WebBrowserDetection.isSafari gates the conversion.',
    support: <String, _WbdSupport>{
      'chrome': _WbdSupport.full,
      'edge': _WbdSupport.full,
      'safari': _WbdSupport.quirky,
      'firefox': _WbdSupport.partial,
      'unknown': _WbdSupport.unknown,
    },
  ),
  _WbdCapability(
    name: 'Pointer events (Flutter)',
    note: 'Mouse / touch / stylus unified via pointer events. '
        'All modern browsers now comply.',
    support: <String, _WbdSupport>{
      'chrome': _WbdSupport.full,
      'edge': _WbdSupport.full,
      'safari': _WbdSupport.full,
      'firefox': _WbdSupport.full,
      'unknown': _WbdSupport.unknown,
    },
  ),
  _WbdCapability(
    name: 'Composition events (IME)',
    note: 'Safari fires compositionend before the final character lands; '
        'Flutter applies a one-frame delay there.',
    support: <String, _WbdSupport>{
      'chrome': _WbdSupport.full,
      'edge': _WbdSupport.full,
      'safari': _WbdSupport.quirky,
      'firefox': _WbdSupport.full,
      'unknown': _WbdSupport.unknown,
    },
  ),
  _WbdCapability(
    name: 'Clipboard paste shortcut',
    note: 'Safari still needs a trusted user gesture; Chromium vends '
        'the async Clipboard API freely.',
    support: <String, _WbdSupport>{
      'chrome': _WbdSupport.full,
      'edge': _WbdSupport.full,
      'safari': _WbdSupport.partial,
      'firefox': _WbdSupport.partial,
      'unknown': _WbdSupport.unknown,
    },
  ),
  _WbdCapability(
    name: 'WebGL 2',
    note: 'All mainstream engines now ship WebGL2; legacy Safari lagged.',
    support: <String, _WbdSupport>{
      'chrome': _WbdSupport.full,
      'edge': _WbdSupport.full,
      'safari': _WbdSupport.full,
      'firefox': _WbdSupport.full,
      'unknown': _WbdSupport.unknown,
    },
  ),
  _WbdCapability(
    name: 'CanvasKit renderer',
    note: 'Flutter defaults to CanvasKit on non-Safari; HTML renderer '
        'elsewhere historically. All are now on Skia.',
    support: <String, _WbdSupport>{
      'chrome': _WbdSupport.full,
      'edge': _WbdSupport.full,
      'safari': _WbdSupport.partial,
      'firefox': _WbdSupport.full,
      'unknown': _WbdSupport.unknown,
    },
  ),
  _WbdCapability(
    name: 'Keyboard event .code',
    note: 'Physical key codes normalized across engines; Safari '
        'historically differed on modifier latches.',
    support: <String, _WbdSupport>{
      'chrome': _WbdSupport.full,
      'edge': _WbdSupport.full,
      'safari': _WbdSupport.quirky,
      'firefox': _WbdSupport.full,
      'unknown': _WbdSupport.unknown,
    },
  ),
  _WbdCapability(
    name: 'Resize observer on <canvas>',
    note: 'ResizeObserver is universal; Safari briefly throttled it '
        'under low-power mode.',
    support: <String, _WbdSupport>{
      'chrome': _WbdSupport.full,
      'edge': _WbdSupport.full,
      'safari': _WbdSupport.partial,
      'firefox': _WbdSupport.full,
      'unknown': _WbdSupport.unknown,
    },
  ),
  _WbdCapability(
    name: 'IntersectionObserver',
    note: 'Rock-solid everywhere; safe to use unconditionally.',
    support: <String, _WbdSupport>{
      'chrome': _WbdSupport.full,
      'edge': _WbdSupport.full,
      'safari': _WbdSupport.full,
      'firefox': _WbdSupport.full,
      'unknown': _WbdSupport.unknown,
    },
  ),
];

class _WbdChapterCapabilityMatrix extends StatelessWidget {
  const _WbdChapterCapabilityMatrix();

  @override
  Widget build(BuildContext context) {
    return _WbdSection(
      id: 'CH·03',
      title: 'Capability Matrix — Cross-Browser Feature Support',
      subtitle:
          'A purely illustrative grid of browser × capability. Use it to '
          'decide where a WebBrowserDetection branch is actually buying '
          'you something versus just adding noise. "Quirky" means works '
          'with a fix-up; "partial" means feature-flag gated.',
      accent: _wbdCeruleanDeep,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _WbdCard(
            accent: _wbdCerulean,
            padding: const EdgeInsets.fromLTRB(6, 6, 6, 6),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: _WbdCapabilityGrid(),
            ),
          ),
          const SizedBox(height: 14),
          const _WbdMatrixLegend(),
        ],
      ),
    );
  }
}

class _WbdCapabilityGrid extends StatelessWidget {
  const _WbdCapabilityGrid();

  @override
  Widget build(BuildContext context) {
    // NOTE [E2 batch 3 fix]: removed `crossAxisAlignment: CrossAxisAlignment.stretch`.
    // This Column lives inside a horizontal `SingleChildScrollView`, which gives
    // it an unbounded cross-axis (= horizontal) width. With `stretch` set,
    // Column tried to stretch to infinite width, cascading through the
    // relayoutBoundary chain. Each row already has its own intrinsic width.
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _WbdMatrixHeader(),
        for (int i = 0; i < _wbdCapabilities.length; i++)
          _WbdMatrixRow(
            capability: _wbdCapabilities[i],
            alt: i.isOdd,
          ),
      ],
    );
  }
}

class _WbdMatrixHeader extends StatelessWidget {
  const _WbdMatrixHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: _wbdInkNavyDeep,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: <Widget>[
          const SizedBox(
            width: 260,
            child: Text(
              'Capability',
              style: TextStyle(
                color: _wbdCeruleanPale,
                fontSize: 12,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.0,
              ),
            ),
          ),
          ..._wbdMatrixColumns.map((String col) {
            final _WbdBrowser b = _wbdBrowserForId(col);
            return Container(
              width: 96,
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: b.accentColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    b.label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.4,
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
}

class _WbdMatrixRow extends StatelessWidget {
  const _WbdMatrixRow({required this.capability, required this.alt});

  final _WbdCapability capability;
  final bool alt;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: alt ? _wbdCeruleanWash : Colors.white,
        border: const Border(
          bottom: BorderSide(color: _wbdRuleSoft, width: 1),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 260,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  capability.name,
                  style: const TextStyle(
                    color: _wbdInkNavy,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  capability.note,
                  style: const TextStyle(
                    color: _wbdInkSoft,
                    fontSize: 11,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
          ..._wbdMatrixColumns.map((String col) {
            final _WbdSupport s =
                capability.support[col] ?? _WbdSupport.unknown;
            return SizedBox(
              width: 96,
              child: Center(child: _WbdSupportBadge(support: s)),
            );
          }),
        ],
      ),
    );
  }
}

class _WbdSupportBadge extends StatelessWidget {
  const _WbdSupportBadge({required this.support});

  final _WbdSupport support;

  @override
  Widget build(BuildContext context) {
    late final Color color;
    late final Color wash;
    late final IconData icon;
    late final String label;
    switch (support) {
      case _WbdSupport.full:
        color = _wbdTeal;
        wash = _wbdTealPale;
        icon = Icons.check;
        label = 'full';
      case _WbdSupport.partial:
        color = _wbdAmberDeep;
        wash = _wbdAmberPale;
        icon = Icons.horizontal_rule;
        label = 'partial';
      case _WbdSupport.quirky:
        color = _wbdWebkit;
        wash = const Color(0xFFE8E8EE);
        icon = Icons.error_outline;
        label = 'quirky';
      case _WbdSupport.none:
        color = _wbdDanger;
        wash = _wbdDangerPale;
        icon = Icons.close;
        label = 'none';
      case _WbdSupport.unknown:
        color = _wbdUnknown;
        wash = const Color(0xFFE7ECF2);
        icon = Icons.help_outline;
        label = '—';
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: wash,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: color.withValues(alpha: 0.55),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, color: color, size: 12),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 10.5,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _WbdMatrixLegend extends StatelessWidget {
  const _WbdMatrixLegend();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: const <Widget>[
        _WbdSupportBadge(support: _WbdSupport.full),
        _WbdSupportBadge(support: _WbdSupport.partial),
        _WbdSupportBadge(support: _WbdSupport.quirky),
        _WbdSupportBadge(support: _WbdSupport.none),
        _WbdSupportBadge(support: _WbdSupport.unknown),
      ],
    );
  }
}

// ===========================================================================
// CHAPTER 04 — BROWSER CHROME MOCK
// ===========================================================================
class _WbdChapterChromeMock extends StatelessWidget {
  const _WbdChapterChromeMock({
    required this.simulated,
    required this.pulse,
    required this.onPickBrowser,
  });

  final _WbdBrowser simulated;
  final AnimationController pulse;
  final ValueChanged<String> onPickBrowser;

  @override
  Widget build(BuildContext context) {
    return _WbdSection(
      id: 'CH·04',
      title: 'Browser-Chrome Mock — Detection, Visualised',
      subtitle:
          'This fake browser window re-paints itself based on the '
          'simulated vendor. The active tab pulses in that vendor\'s '
          'brand colour. Use the dropdown to switch and watch the window '
          'recolour — no engine is actually loaded.',
      accent: _wbdCerulean,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _WbdBrowserPicker(
            simulated: simulated,
            onPickBrowser: onPickBrowser,
          ),
          const SizedBox(height: 14),
          _WbdBrowserMockWindow(
            simulated: simulated,
            pulse: pulse,
          ),
        ],
      ),
    );
  }
}

class _WbdBrowserPicker extends StatelessWidget {
  const _WbdBrowserPicker({
    required this.simulated,
    required this.onPickBrowser,
  });

  final _WbdBrowser simulated;
  final ValueChanged<String> onPickBrowser;

  @override
  Widget build(BuildContext context) {
    return _WbdCard(
      accent: simulated.accentColor,
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: simulated.accentColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: simulated.accentColor.withValues(alpha: 0.5),
                width: 1,
              ),
            ),
            alignment: Alignment.center,
            child: Icon(
              _wbdEngineIcon(simulated.engine),
              color: simulated.accentColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'SIMULATED BROWSER',
                  style: TextStyle(
                    color: _wbdInkSoft,
                    fontSize: 10.5,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.3,
                  ),
                ),
                Text(
                  '${simulated.label} · ${simulated.version}',
                  style: const TextStyle(
                    color: _wbdInkNavyDeep,
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: _wbdCeruleanWash,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _wbdCeruleanPale, width: 1),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: simulated.id,
                isDense: true,
                dropdownColor: Colors.white,
                style: const TextStyle(
                  color: _wbdInkNavy,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                ),
                items: _wbdBrowsers
                    .map(
                      (_WbdBrowser b) => DropdownMenuItem<String>(
                        value: b.id,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                color: b.accentColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(b.label),
                          ],
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (String? v) {
                  if (v != null) onPickBrowser(v);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WbdBrowserMockWindow extends StatelessWidget {
  const _WbdBrowserMockWindow({
    required this.simulated,
    required this.pulse,
  });

  final _WbdBrowser simulated;
  final AnimationController pulse;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: simulated.accentColor.withValues(alpha: 0.35),
          width: 1,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _wbdInkNavy.withValues(alpha: 0.08),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _WbdMockTitleBar(simulated: simulated),
          _WbdMockTabStrip(simulated: simulated, pulse: pulse),
          _WbdMockAddressBar(simulated: simulated),
          _WbdMockViewport(simulated: simulated),
        ],
      ),
    );
  }
}

class _WbdMockTitleBar extends StatelessWidget {
  const _WbdMockTitleBar({required this.simulated});

  final _WbdBrowser simulated;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: _wbdPaperChrome,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(14),
          topRight: Radius.circular(14),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: <Widget>[
          _buildDot(const Color(0xFFE35A52)),
          const SizedBox(width: 6),
          _buildDot(const Color(0xFFE7AD3C)),
          const SizedBox(width: 6),
          _buildDot(const Color(0xFF3DBE5A)),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              '${simulated.label} Browser · capability preview',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: _wbdInkSoft,
                fontSize: 11.5,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.4,
              ),
            ),
          ),
          const Icon(Icons.minimize, size: 14, color: _wbdInkSoft),
          const SizedBox(width: 10),
          const Icon(Icons.crop_square, size: 13, color: _wbdInkSoft),
          const SizedBox(width: 10),
          const Icon(Icons.close, size: 14, color: _wbdInkSoft),
        ],
      ),
    );
  }

  Widget _buildDot(Color c) {
    return Container(
      width: 11,
      height: 11,
      decoration: BoxDecoration(
        color: c,
        shape: BoxShape.circle,
      ),
    );
  }
}

class _WbdMockTabStrip extends StatelessWidget {
  const _WbdMockTabStrip({required this.simulated, required this.pulse});

  final _WbdBrowser simulated;
  final AnimationController pulse;

  @override
  Widget build(BuildContext context) {
    final List<_WbdBrowser> others = _wbdBrowsers
        .where((_WbdBrowser b) =>
            b.id != 'unknown' && b.id != simulated.id)
        .take(3)
        .toList();
    return Container(
      color: _wbdPaperAlt,
      padding: const EdgeInsets.fromLTRB(10, 6, 10, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          _WbdMockTab(
            label: simulated.label,
            engine: simulated.engine,
            active: true,
            pulse: pulse,
            color: simulated.accentColor,
          ),
          for (final _WbdBrowser b in others)
            _WbdMockTab(
              label: b.label,
              engine: b.engine,
              active: false,
              pulse: pulse,
              color: b.accentColor,
            ),
          const SizedBox(width: 8),
          Container(
            width: 26,
            height: 26,
            decoration: BoxDecoration(
              color: _wbdPaperChrome,
              borderRadius: BorderRadius.circular(6),
            ),
            alignment: Alignment.center,
            child: const Icon(Icons.add, size: 14, color: _wbdInkSoft),
          ),
        ],
      ),
    );
  }
}

class _WbdMockTab extends StatelessWidget {
  const _WbdMockTab({
    required this.label,
    required this.engine,
    required this.active,
    required this.pulse,
    required this.color,
  });

  final String label;
  final _WbdEngine engine;
  final bool active;
  final AnimationController pulse;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: pulse,
      builder: (BuildContext context, Widget? child) {
        final double t = active
            ? (0.5 + 0.5 * math.sin(pulse.value * math.pi * 2))
            : 0.0;
        final Color bg = active
            ? Color.lerp(Colors.white, color.withValues(alpha: 0.1), t) ??
                Colors.white
            : _wbdPaperChrome;
        return Container(
          margin: const EdgeInsets.only(right: 4),
          padding: const EdgeInsets.fromLTRB(12, 7, 12, 9),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            border: Border(
              top: BorderSide(
                color: active
                    ? color.withValues(alpha: 0.85)
                    : Colors.transparent,
                width: 2,
              ),
              left: BorderSide(color: _wbdRule, width: active ? 1 : 0),
              right: BorderSide(color: _wbdRule, width: active ? 1 : 0),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                _wbdEngineIcon(engine),
                size: 12,
                color: color,
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  color: active ? _wbdInkNavyDeep : _wbdInkSoft,
                  fontSize: 11.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.close,
                size: 11,
                color: active ? _wbdInkSoft : _wbdInkSoft.withValues(alpha: 0.5),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _WbdMockAddressBar extends StatelessWidget {
  const _WbdMockAddressBar({required this.simulated});

  final _WbdBrowser simulated;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _wbdPaperAlt,
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
      child: Row(
        children: <Widget>[
          const Icon(Icons.arrow_back, size: 14, color: _wbdInkSoft),
          const SizedBox(width: 10),
          const Icon(Icons.arrow_forward, size: 14, color: _wbdInkSoft),
          const SizedBox(width: 10),
          const Icon(Icons.refresh, size: 14, color: _wbdInkSoft),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: _wbdRule, width: 1),
              ),
              child: Row(
                children: <Widget>[
                  Icon(Icons.lock, size: 12, color: _wbdTeal),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'https://flutter.dev/detect?engine=${_wbdEngineLabel(simulated.engine)}',
                      style: const TextStyle(
                        color: _wbdInkNavy,
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.star_border,
                    size: 13,
                    color: _wbdInkSoft,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            width: 26,
            height: 26,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: simulated.accentColor.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: simulated.accentColor.withValues(alpha: 0.55),
                width: 1,
              ),
            ),
            child: Text(
              simulated.label.substring(0, 1).toUpperCase(),
              style: TextStyle(
                color: simulated.accentColor,
                fontSize: 12,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WbdMockViewport extends StatelessWidget {
  const _WbdMockViewport({required this.simulated});

  final _WbdBrowser simulated;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(14),
          bottomRight: Radius.circular(14),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: simulated.accentColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: simulated.accentColor.withValues(alpha: 0.5),
                    width: 1,
                  ),
                ),
                alignment: Alignment.center,
                child: Icon(
                  _wbdEngineIcon(simulated.engine),
                  color: simulated.accentColor,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Detected: ${simulated.label} ${simulated.version}',
                      style: const TextStyle(
                        color: _wbdInkNavyDeep,
                        fontWeight: FontWeight.w900,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      'engine=${_wbdEngineLabel(simulated.engine)} · '
                      'vendor=${_wbdVendorLabel(simulated.vendor)}',
                      style: const TextStyle(
                        color: _wbdInkSoft,
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
            decoration: BoxDecoration(
              color: _wbdCeruleanWash,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _wbdCeruleanPale, width: 1),
            ),
            child: Text(
              'User-Agent  ·  ${simulated.ua}',
              style: const TextStyle(
                color: _wbdInkNavy,
                fontSize: 11,
                height: 1.4,
                fontFamily: 'RobotoMono',
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              _WbdChip(
                label: 'isSafari = ${simulated.engine == _WbdEngine.webkit}',
                icon: simulated.engine == _WbdEngine.webkit
                    ? Icons.check_circle
                    : Icons.cancel,
                color: simulated.engine == _WbdEngine.webkit
                    ? _wbdWebkit
                    : _wbdInkSoft,
                filled: true,
              ),
              const SizedBox(width: 8),
              _WbdChip(
                label: 'isChromium = ${simulated.engine == _WbdEngine.blink}',
                icon: simulated.engine == _WbdEngine.blink
                    ? Icons.check_circle
                    : Icons.cancel,
                color: simulated.engine == _WbdEngine.blink
                    ? _wbdBlink
                    : _wbdInkSoft,
                filled: simulated.engine == _WbdEngine.blink,
              ),
              const SizedBox(width: 8),
              _WbdChip(
                label: 'isFirefox = ${simulated.engine == _WbdEngine.gecko}',
                icon: simulated.engine == _WbdEngine.gecko
                    ? Icons.check_circle
                    : Icons.cancel,
                color: simulated.engine == _WbdEngine.gecko
                    ? _wbdGecko
                    : _wbdInkSoft,
                filled: simulated.engine == _WbdEngine.gecko,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// CHAPTER 05 — FEATURE-GATE PLAYGROUND
// ===========================================================================
class _WbdChapterPlayground extends StatelessWidget {
  const _WbdChapterPlayground({
    required this.simulated,
    required this.onPickBrowser,
  });

  final _WbdBrowser simulated;
  final ValueChanged<String> onPickBrowser;

  @override
  Widget build(BuildContext context) {
    return _WbdSection(
      id: 'CH·05',
      title: 'Feature-Gate Playground — Pick a Branch',
      subtitle:
          'The dropdown above already drives a simulated browser. This '
          'section reuses that selection and shows how a real app would '
          'branch on the detection result. Only one path is lit at a '
          'time — the others collapse into ghost-state.',
      accent: _wbdTeal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _WbdPlaygroundSelector(
            simulated: simulated,
            onPickBrowser: onPickBrowser,
          ),
          const SizedBox(height: 14),
          _WbdFeatureGate(
            simulated: simulated,
            gateTitle: 'Scroll-wheel delta conversion',
            gateIcon: Icons.mouse_outlined,
            paths: const <String, String>{
              'safari': 'Multiply wheel.deltaY by 16 (lines→pixels) and '
                  'clamp between -480 and 480.',
              'blink':
                  'Pass wheel.deltaY directly through. Chromium already '
                  'delivers pixel deltas.',
              'gecko':
                  'Pass deltaY, then correct for deltaMode === 1. Rare '
                  'but still possible on legacy Linux builds.',
              'edge':
                  'Treat as Chromium — Edge shares Blink since 2020.',
              'unknown':
                  'Default path: pass deltaY through and log a warning '
                  'to help diagnose odd reports.',
            },
          ),
          const SizedBox(height: 12),
          _WbdFeatureGate(
            simulated: simulated,
            gateTitle: 'Selection change handling',
            gateIcon: Icons.text_fields,
            paths: const <String, String>{
              'safari':
                  'Defer selection reconciliation by one frame; Safari '
                  'fires selectionchange before the DOM settles.',
              'blink':
                  'Reconcile inline on selectionchange — Chromium is '
                  'well-behaved here.',
              'gecko':
                  'Reconcile inline. Firefox matches the spec closely.',
              'edge':
                  'Blink-path — same as Chrome.',
              'unknown':
                  'Default path: reconcile inline but schedule a '
                  'microtask fallback.',
            },
          ),
          const SizedBox(height: 12),
          _WbdFeatureGate(
            simulated: simulated,
            gateTitle: 'Clipboard-paste permission',
            gateIcon: Icons.content_paste_outlined,
            paths: const <String, String>{
              'safari':
                  'Require a real user click within 500ms; fall back to '
                  'document.execCommand otherwise.',
              'blink':
                  'Call navigator.clipboard.readText() directly inside '
                  'the gesture handler.',
              'gecko':
                  'Await navigator.clipboard.readText(); prompt the user '
                  'for permission on first use.',
              'edge':
                  'Blink-path — permissions UX matches Chrome.',
              'unknown':
                  'Wrap in try/catch, show the in-app paste dialog as '
                  'the graceful fallback.',
            },
          ),
          const SizedBox(height: 14),
          const _WbdCodeBlock(
            caption: 'PRODUCTION-STYLE GATE',
            code:
                "import 'package:flutter/foundation.dart' show kIsWeb;\n"
                "import 'package:flutter/widgets.dart'\n"
                "    show WebBrowserDetection;\n\n"
                'double convertWheelDelta(double raw) {\n'
                '  if (!kIsWeb) return raw;\n'
                '  if (WebBrowserDetection.isSafari) {\n'
                '    return (raw * 16).clamp(-480, 480).toDouble();\n'
                '  }\n'
                '  return raw;\n'
                '}\n',
          ),
        ],
      ),
    );
  }
}

class _WbdPlaygroundSelector extends StatelessWidget {
  const _WbdPlaygroundSelector({
    required this.simulated,
    required this.onPickBrowser,
  });

  final _WbdBrowser simulated;
  final ValueChanged<String> onPickBrowser;

  @override
  Widget build(BuildContext context) {
    return _WbdCard(
      accent: _wbdTeal,
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
      child: Row(
        children: <Widget>[
          const Icon(Icons.swap_horiz, color: _wbdTeal, size: 18),
          const SizedBox(width: 8),
          const Text(
            'CURRENT PATH',
            style: TextStyle(
              color: _wbdTeal,
              fontSize: 11.5,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.3,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Wrap(
              spacing: 6,
              runSpacing: 6,
              children: _wbdBrowsers.map((_WbdBrowser b) {
                final bool selected = b.id == simulated.id;
                return GestureDetector(
                  onTap: () => onPickBrowser(b.id),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: selected
                          ? b.accentColor
                          : b.accentColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(
                        color: b.accentColor.withValues(alpha: 0.55),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(
                          _wbdEngineIcon(b.engine),
                          size: 12,
                          color: selected ? Colors.white : b.accentColor,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          b.label,
                          style: TextStyle(
                            color:
                                selected ? Colors.white : b.accentColor,
                            fontSize: 11.5,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _WbdFeatureGate extends StatelessWidget {
  const _WbdFeatureGate({
    required this.simulated,
    required this.gateTitle,
    required this.gateIcon,
    required this.paths,
  });

  final _WbdBrowser simulated;
  final String gateTitle;
  final IconData gateIcon;
  final Map<String, String> paths;

  String _pathKeyForSimulated() {
    switch (simulated.engine) {
      case _WbdEngine.webkit:
        return 'safari';
      case _WbdEngine.blink:
        return simulated.vendor == _WbdVendor.microsoft ? 'edge' : 'blink';
      case _WbdEngine.gecko:
        return 'gecko';
      case _WbdEngine.edge:
        return 'edge';
      case _WbdEngine.unknown:
        return 'unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    final String activeKey = _pathKeyForSimulated();
    return _WbdCard(
      accent: simulated.accentColor,
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: simulated.accentColor.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: simulated.accentColor.withValues(alpha: 0.5),
                    width: 1,
                  ),
                ),
                alignment: Alignment.center,
                child: Icon(
                  gateIcon,
                  color: simulated.accentColor,
                  size: 18,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  gateTitle,
                  style: const TextStyle(
                    color: _wbdInkNavyDeep,
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              _WbdChip(
                label: 'active · $activeKey',
                color: simulated.accentColor,
                filled: true,
                icon: Icons.bolt,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(height: 1, color: _wbdRuleSoft),
          const SizedBox(height: 10),
          ...paths.entries.map((MapEntry<String, String> e) {
            final bool active = e.key == activeKey;
            final Color color = _wbdPathColor(e.key);
            return Opacity(
              opacity: active ? 1.0 : 0.45,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 8,
                      height: 8,
                      margin: const EdgeInsets.only(top: 6),
                      decoration: BoxDecoration(
                        color: active ? color : _wbdRule,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 76,
                      child: Text(
                        e.key.toUpperCase(),
                        style: TextStyle(
                          color: active ? color : _wbdInkSoft,
                          fontSize: 11,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        e.value,
                        style: TextStyle(
                          color: active ? _wbdInk : _wbdInkSoft,
                          fontSize: 12,
                          height: 1.45,
                          fontWeight:
                              active ? FontWeight.w600 : FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

Color _wbdPathColor(String key) {
  switch (key) {
    case 'safari':
      return _wbdWebkit;
    case 'blink':
      return _wbdBlink;
    case 'gecko':
      return _wbdGecko;
    case 'edge':
      return _wbdEdge;
    case 'unknown':
    default:
      return _wbdUnknown;
  }
}

// ===========================================================================
// CHAPTER 06 — COMPARISON
// ===========================================================================
class _WbdComparisonRow {
  const _WbdComparisonRow({
    required this.feature,
    required this.webBrowserDetection,
    required this.kIsWebCol,
    required this.defaultTargetPlatformCol,
    required this.platformOsCol,
  });

  final String feature;
  final String webBrowserDetection;
  final String kIsWebCol;
  final String defaultTargetPlatformCol;
  final String platformOsCol;
}

const List<_WbdComparisonRow> _wbdComparisonRows = <_WbdComparisonRow>[
  _WbdComparisonRow(
    feature: 'Scope',
    webBrowserDetection: 'Which browser engine',
    kIsWebCol: 'Am I running in any browser',
    defaultTargetPlatformCol: 'Logical target platform',
    platformOsCol: 'Host OS via dart:io',
  ),
  _WbdComparisonRow(
    feature: 'Where it lives',
    webBrowserDetection: 'flutter/widgets.dart',
    kIsWebCol: 'flutter/foundation.dart',
    defaultTargetPlatformCol: 'flutter/foundation.dart',
    platformOsCol: 'dart:io',
  ),
  _WbdComparisonRow(
    feature: 'Web-safe?',
    webBrowserDetection: 'Yes (web + native stub)',
    kIsWebCol: 'Yes',
    defaultTargetPlatformCol: 'Yes',
    platformOsCol: 'No — throws on web',
  ),
  _WbdComparisonRow(
    feature: 'Const-foldable',
    webBrowserDetection: 'Effectively (native)',
    kIsWebCol: 'Yes — top-level const',
    defaultTargetPlatformCol: 'Lazy getter',
    platformOsCol: 'Runtime only',
  ),
  _WbdComparisonRow(
    feature: 'Override for tests',
    webBrowserDetection: 'Not directly',
    kIsWebCol: 'Compile-time only',
    defaultTargetPlatformCol: 'debugDefaultTargetPlatformOverride',
    platformOsCol: 'Platform.environment mocks',
  ),
  _WbdComparisonRow(
    feature: 'Use for UI routing?',
    webBrowserDetection: 'No — too narrow',
    kIsWebCol: 'Sometimes',
    defaultTargetPlatformCol: 'Yes',
    platformOsCol: 'Rarely — prefer defaultTargetPlatform',
  ),
  _WbdComparisonRow(
    feature: 'Use for workarounds?',
    webBrowserDetection: 'Yes — primary use',
    kIsWebCol: 'Wraps, not branches',
    defaultTargetPlatformCol: 'iOS vs Android native',
    platformOsCol: 'Server-only branches',
  ),
  _WbdComparisonRow(
    feature: 'Cost on native build',
    webBrowserDetection: 'Zero',
    kIsWebCol: 'Zero — const',
    defaultTargetPlatformCol: 'Negligible',
    platformOsCol: 'Cheap string read',
  ),
];

class _WbdChapterComparison extends StatelessWidget {
  const _WbdChapterComparison();

  @override
  Widget build(BuildContext context) {
    return _WbdSection(
      id: 'CH·06',
      title: 'Comparison — Four Tools, Four Questions',
      subtitle:
          'WebBrowserDetection sits alongside three other environment '
          'flags. Each answers a different question. Mixing them '
          'correctly is the difference between a robust gate and a '
          'brittle one.',
      accent: _wbdAmberDeep,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _WbdCard(
            accent: _wbdAmberDeep,
            padding: const EdgeInsets.fromLTRB(6, 6, 6, 6),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: _WbdComparisonGrid(),
            ),
          ),
          const SizedBox(height: 14),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              Expanded(
                child: _WbdComparisonUseCase(
                  title: 'Use kIsWeb',
                  body: 'To guard an entire branch that cannot compile '
                      'or link on one side.',
                  color: _wbdTeal,
                  icon: Icons.language,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: _WbdComparisonUseCase(
                  title: 'Use defaultTargetPlatform',
                  body: 'To adapt UX (material vs cupertino, keyboard '
                      'shortcuts, menus) per logical OS.',
                  color: _wbdCeruleanDeep,
                  icon: Icons.devices_other,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              Expanded(
                child: _WbdComparisonUseCase(
                  title: 'Use WebBrowserDetection',
                  body: 'To apply browser-engine workarounds — scroll, '
                      'IME, clipboard, focus edge cases.',
                  color: _wbdWebkit,
                  icon: Icons.travel_explore,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: _WbdComparisonUseCase(
                  title: 'Use Platform.operatingSystem',
                  body: 'Only in dart:io contexts. Never on web — it '
                      'throws. Prefer defaultTargetPlatform.',
                  color: _wbdAmberDeep,
                  icon: Icons.memory,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _WbdComparisonGrid extends StatelessWidget {
  const _WbdComparisonGrid();

  @override
  Widget build(BuildContext context) {
    // NOTE [E2 batch 3 fix]: removed `crossAxisAlignment: CrossAxisAlignment.stretch`.
    // Same horizontal-SingleChildScrollView cascade as `_WbdCapabilityGrid`.
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _WbdComparisonHeaderRow(),
        for (int i = 0; i < _wbdComparisonRows.length; i++)
          _WbdComparisonDataRow(
            row: _wbdComparisonRows[i],
            alt: i.isOdd,
          ),
      ],
    );
  }
}

class _WbdComparisonHeaderRow extends StatelessWidget {
  const _WbdComparisonHeaderRow();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: _wbdInkNavyDeep,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: const <Widget>[
          SizedBox(
            width: 160,
            child: Text('Feature',
                style: TextStyle(
                  color: _wbdCeruleanPale,
                  fontSize: 11.5,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.0,
                )),
          ),
          SizedBox(
            width: 220,
            child: Text('WebBrowserDetection',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11.5,
                  fontWeight: FontWeight.w900,
                )),
          ),
          SizedBox(
            width: 180,
            child: Text('kIsWeb',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11.5,
                  fontWeight: FontWeight.w900,
                )),
          ),
          SizedBox(
            width: 220,
            child: Text('defaultTargetPlatform',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11.5,
                  fontWeight: FontWeight.w900,
                )),
          ),
          SizedBox(
            width: 220,
            child: Text('Platform.operatingSystem',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11.5,
                  fontWeight: FontWeight.w900,
                )),
          ),
        ],
      ),
    );
  }
}

class _WbdComparisonDataRow extends StatelessWidget {
  const _WbdComparisonDataRow({required this.row, required this.alt});

  final _WbdComparisonRow row;
  final bool alt;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: alt ? _wbdCeruleanWash : Colors.white,
        border: const Border(
          bottom: BorderSide(color: _wbdRuleSoft, width: 1),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 160,
            child: Text(
              row.feature,
              style: const TextStyle(
                color: _wbdInkNavyDeep,
                fontSize: 12,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          SizedBox(
            width: 220,
            child: Text(
              row.webBrowserDetection,
              style: const TextStyle(
                color: _wbdWebkit,
                fontSize: 11.5,
                fontWeight: FontWeight.w700,
                height: 1.35,
              ),
            ),
          ),
          SizedBox(
            width: 180,
            child: Text(
              row.kIsWebCol,
              style: const TextStyle(
                color: _wbdTeal,
                fontSize: 11.5,
                fontWeight: FontWeight.w700,
                height: 1.35,
              ),
            ),
          ),
          SizedBox(
            width: 220,
            child: Text(
              row.defaultTargetPlatformCol,
              style: const TextStyle(
                color: _wbdCeruleanDeep,
                fontSize: 11.5,
                fontWeight: FontWeight.w700,
                height: 1.35,
              ),
            ),
          ),
          SizedBox(
            width: 220,
            child: Text(
              row.platformOsCol,
              style: const TextStyle(
                color: _wbdAmberDeep,
                fontSize: 11.5,
                fontWeight: FontWeight.w700,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WbdComparisonUseCase extends StatelessWidget {
  const _WbdComparisonUseCase({
    required this.title,
    required this.body,
    required this.color,
    required this.icon,
  });

  final String title;
  final String body;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return _WbdCard(
      accent: color,
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(icon, color: color, size: 16),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: color,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            body,
            style: const TextStyle(
              color: _wbdInk,
              fontSize: 12,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// CHAPTER 07 — RECIPES
// ===========================================================================
class _WbdRecipe {
  const _WbdRecipe({
    required this.title,
    required this.premise,
    required this.code,
    required this.accent,
    required this.icon,
    required this.tags,
  });

  final String title;
  final String premise;
  final String code;
  final Color accent;
  final IconData icon;
  final List<String> tags;
}

const List<_WbdRecipe> _wbdRecipes = <_WbdRecipe>[
  _WbdRecipe(
    title: 'Safari-aware scroll physics',
    premise: 'Swap BouncingScrollPhysics for ClampingScrollPhysics when '
        'the host is Safari on iOS web. Keeps the rubber-banding '
        'feeling from fighting native Safari overscroll.',
    code: "ScrollPhysics pickPhysics() {\n"
        "  if (!kIsWeb) return const BouncingScrollPhysics();\n"
        "  if (WebBrowserDetection.isSafari) {\n"
        "    return const ClampingScrollPhysics();\n"
        "  }\n"
        "  return const BouncingScrollPhysics();\n"
        "}",
    accent: _wbdWebkit,
    icon: Icons.swipe_outlined,
    tags: <String>['scroll', 'safari-only'],
  ),
  _WbdRecipe(
    title: 'Composition reconciliation delay',
    premise: 'Delay one frame on Safari so the DOM commits the final '
        'composition character before Flutter reads back selection.',
    code: "void onCompositionEnd() {\n"
        "  if (kIsWeb && WebBrowserDetection.isSafari) {\n"
        "    SchedulerBinding.instance.addPostFrameCallback((_) {\n"
        "      reconcileSelection();\n"
        "    });\n"
        "  } else {\n"
        "    reconcileSelection();\n"
        "  }\n"
        "}",
    accent: _wbdCerulean,
    icon: Icons.text_fields,
    tags: <String>['ime', 'text-input'],
  ),
  _WbdRecipe(
    title: 'Graceful clipboard fallback',
    premise: 'Try the modern async clipboard. On Safari fall back to '
        'execCommand for a non-modal paste experience.',
    code: "Future<String?> pasteFromClipboard() async {\n"
        "  try {\n"
        "    final data = await Clipboard.getData(Clipboard.kTextPlain);\n"
        "    return data?.text;\n"
        "  } catch (e) {\n"
        "    if (kIsWeb && WebBrowserDetection.isSafari) {\n"
        "      return legacyExecCommandPaste();\n"
        "    }\n"
        "    rethrow;\n"
        "  }\n"
        "}",
    accent: _wbdAmberDeep,
    icon: Icons.content_paste_outlined,
    tags: <String>['clipboard', 'fallback'],
  ),
  _WbdRecipe(
    title: 'Feature flag layering',
    premise: 'Combine kIsWeb, isSafari, and a runtime remote flag so '
        'you can kill-switch the workaround without shipping code.',
    code: "bool get shouldApplySafariWorkaround =>\n"
        "    kIsWeb &&\n"
        "    WebBrowserDetection.isSafari &&\n"
        "    remoteFlags.enabled('safari_scroll_fix');",
    accent: _wbdTeal,
    icon: Icons.tune_outlined,
    tags: <String>['flags', 'safety'],
  ),
  _WbdRecipe(
    title: 'Analytics tagging',
    premise: 'Emit a browser_engine attribute with each event so your '
        'dashboards can isolate Safari-only regressions.',
    code: "Map<String, Object> browserAttrs() {\n"
        "  return <String, Object>{\n"
        "    'is_web': kIsWeb,\n"
        "    'is_safari': kIsWeb && WebBrowserDetection.isSafari,\n"
        "    'platform': defaultTargetPlatform.name,\n"
        "  };\n"
        "}",
    accent: _wbdCeruleanDeep,
    icon: Icons.insights_outlined,
    tags: <String>['analytics'],
  ),
  _WbdRecipe(
    title: 'Renderer-aware image pipeline',
    premise: 'Pick a lossier image format on Safari/WebKit where '
        'memory pressure tends to matter more, keep WebP elsewhere.',
    code: "String pickImageFormat() {\n"
        "  if (!kIsWeb) return 'avif';\n"
        "  return WebBrowserDetection.isSafari ? 'jpeg' : 'webp';\n"
        "}",
    accent: _wbdBlink,
    icon: Icons.image_outlined,
    tags: <String>['assets', 'media'],
  ),
  _WbdRecipe(
    title: 'Diagnostic banner',
    premise: 'Render a single debug chip at app startup so QA can '
        'screenshot the detected environment without devtools.',
    code: "Widget debugBrowserBanner() {\n"
        "  if (!kDebugMode) return const SizedBox.shrink();\n"
        "  final safari = kIsWeb && WebBrowserDetection.isSafari;\n"
        "  return Banner(\n"
        "    location: BannerLocation.topStart,\n"
        "    message: safari ? 'Safari' : 'Not Safari',\n"
        "  );\n"
        "}",
    accent: _wbdAmber,
    icon: Icons.flag_outlined,
    tags: <String>['debug', 'qa'],
  ),
  _WbdRecipe(
    title: 'Guarded plugin usage',
    premise: 'Some web plugins silently no-op on Safari. Guard and '
        'surface a friendly "feature not available" card instead.',
    code: "Widget buildPrinter() {\n"
        "  if (kIsWeb && WebBrowserDetection.isSafari) {\n"
        "    return const _UnavailableCard(reason: 'Print API');\n"
        "  }\n"
        "  return const PrinterLauncher();\n"
        "}",
    accent: _wbdGecko,
    icon: Icons.print_outlined,
    tags: <String>['plugins'],
  ),
];

class _WbdChapterRecipes extends StatelessWidget {
  const _WbdChapterRecipes();

  @override
  Widget build(BuildContext context) {
    return _WbdSection(
      id: 'CH·07',
      title: 'Recipes — Production Patterns',
      subtitle:
          'Eight snippet-style cards showing how WebBrowserDetection '
          'usually lands in a real codebase. Copy, adapt, and gate '
          'behind your own feature flags.',
      accent: _wbdCeruleanDeep,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          for (int i = 0; i < _wbdRecipes.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _WbdRecipeCard(recipe: _wbdRecipes[i], index: i + 1),
            ),
        ],
      ),
    );
  }
}

class _WbdRecipeCard extends StatelessWidget {
  const _WbdRecipeCard({required this.recipe, required this.index});

  final _WbdRecipe recipe;
  final int index;

  @override
  Widget build(BuildContext context) {
    return _WbdCard(
      accent: recipe.accent,
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: recipe.accent.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: recipe.accent.withValues(alpha: 0.5),
                    width: 1,
                  ),
                ),
                alignment: Alignment.center,
                child: Icon(recipe.icon, color: recipe.accent, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: _wbdInkNavyDeep,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'RECIPE·${index.toString().padLeft(2, '0')}',
                            style: const TextStyle(
                              color: _wbdCeruleanPale,
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            recipe.title,
                            style: const TextStyle(
                              color: _wbdInkNavyDeep,
                              fontSize: 13.5,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Wrap(
                      spacing: 6,
                      runSpacing: 4,
                      children: recipe.tags
                          .map((String t) => _WbdChip(
                                label: t,
                                color: recipe.accent,
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            recipe.premise,
            style: const TextStyle(
              color: _wbdInk,
              fontSize: 12.5,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 10),
          _WbdCodeBlock(code: recipe.code),
        ],
      ),
    );
  }
}

// ===========================================================================
// CHAPTER 08 — GLOSSARY / EPILOGUE
// ===========================================================================
class _WbdGlossaryEntry {
  const _WbdGlossaryEntry({
    required this.token,
    required this.title,
    required this.body,
    required this.color,
    required this.icon,
    required this.vendors,
  });

  final String token;
  final String title;
  final String body;
  final Color color;
  final IconData icon;
  final String vendors;
}

const List<_WbdGlossaryEntry> _wbdGlossary = <_WbdGlossaryEntry>[
  _WbdGlossaryEntry(
    token: 'blink',
    title: 'Blink — the Chromium engine',
    body: 'Forked from WebKit in 2013, Blink powers Chrome, Edge, Opera '
        'and friends. Flutter defaults a lot of "normal" paths to this '
        'engine because it is the most spec-aligned today.',
    color: _wbdBlink,
    icon: Icons.flash_on_outlined,
    vendors: 'Chrome · Edge · Opera · Brave',
  ),
  _WbdGlossaryEntry(
    token: 'webkit',
    title: 'WebKit — Safari\'s engine',
    body: 'Apple\'s browser engine. Mandatory on iOS where every '
        'browser is WebKit under the hood. Has its own scroll, IME, '
        'clipboard, and selection quirks — the precise reason '
        'WebBrowserDetection exists.',
    color: _wbdWebkit,
    icon: Icons.apple,
    vendors: 'Safari · iOS Chrome · iOS Firefox',
  ),
  _WbdGlossaryEntry(
    token: 'gecko',
    title: 'Gecko — Mozilla\'s engine',
    body: 'Firefox\'s engine and the only remaining fully-independent '
        'non-Chromium desktop browser. Standards-oriented. Does not '
        'need a WebBrowserDetection branch most of the time.',
    color: _wbdGecko,
    icon: Icons.pets_outlined,
    vendors: 'Firefox · Thunderbird',
  ),
  _WbdGlossaryEntry(
    token: 'edge',
    title: 'Edge — historical separate enum value',
    body: 'Once its own engine (EdgeHTML). Since 2020 it is Blink-based. '
        'The BrowserEngine.edge enum value still exists in dart:ui_web '
        'for legacy detection, but today\'s Edge reports as blink.',
    color: _wbdEdge,
    icon: Icons.waves_outlined,
    vendors: 'Microsoft Edge (pre-2020)',
  ),
  _WbdGlossaryEntry(
    token: 'unknown',
    title: 'Unknown — the default and the honest answer',
    body: 'What WebBrowserDetection effectively reports on native '
        'builds (via isSafari = false) and what dart:ui_web reports '
        'when no heuristic matches. Treat it as "fall through to the '
        'generic path".',
    color: _wbdUnknown,
    icon: Icons.help_outline,
    vendors: 'Native builds · Unrecognised UA',
  ),
  _WbdGlossaryEntry(
    token: 'canvaskit',
    title: 'CanvasKit — Flutter\'s web renderer',
    body: 'A WebAssembly-compiled build of Skia. Shipped alongside '
        'Flutter apps. Not a browser engine itself, but the reason '
        'Flutter cares about engine quirks: it has to translate its '
        'own paint output through each one.',
    color: _wbdCerulean,
    icon: Icons.brush_outlined,
    vendors: 'Flutter web runtime',
  ),
  _WbdGlossaryEntry(
    token: 'ua string',
    title: 'User-Agent — the folklore source',
    body: 'A free-form header browsers send. Historically the primary '
        'way JS detected them. dart:ui_web does parse the UA, but it '
        'wraps that detection behind a clean enum so app code stays '
        'out of the string-sniffing business.',
    color: _wbdAmberDeep,
    icon: Icons.article_outlined,
    vendors: 'Every browser',
  ),
  _WbdGlossaryEntry(
    token: 'feature detection',
    title: 'Feature detection — preferred alternative',
    body: 'Rather than "am I Safari?", ask "does this API exist and '
        'return what I expect?". WebBrowserDetection is a last resort '
        'for behaviour differences feature detection cannot see.',
    color: _wbdTeal,
    icon: Icons.science_outlined,
    vendors: 'Pattern, not product',
  ),
];

class _WbdChapterGlossary extends StatelessWidget {
  const _WbdChapterGlossary();

  @override
  Widget build(BuildContext context) {
    return _WbdSection(
      id: 'CH·08',
      title: 'Glossary — Engines, Vendors, and Adjacent Terms',
      subtitle:
          'A small reference for the tokens that keep surfacing in '
          'browser-detection code. Keep this handy when reading '
          'Flutter\'s own source or the dart:ui_web surface.',
      accent: _wbdCeruleanDeep,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          for (int i = 0; i < _wbdGlossary.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _WbdGlossaryCard(
                entry: _wbdGlossary[i],
                index: i + 1,
              ),
            ),
          const SizedBox(height: 8),
          const _WbdEpilogue(),
        ],
      ),
    );
  }
}

class _WbdGlossaryCard extends StatelessWidget {
  const _WbdGlossaryCard({required this.entry, required this.index});

  final _WbdGlossaryEntry entry;
  final int index;

  @override
  Widget build(BuildContext context) {
    return _WbdCard(
      accent: entry.color,
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: entry.color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: entry.color.withValues(alpha: 0.5),
                width: 1,
              ),
            ),
            alignment: Alignment.center,
            child: Icon(entry.icon, color: entry.color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 7,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: entry.color.withValues(alpha: 0.14),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: entry.color.withValues(alpha: 0.45),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        entry.token,
                        style: TextStyle(
                          color: entry.color,
                          fontSize: 10.5,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        entry.title,
                        style: const TextStyle(
                          color: _wbdInkNavyDeep,
                          fontSize: 13,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  entry.body,
                  style: const TextStyle(
                    color: _wbdInk,
                    fontSize: 12,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: <Widget>[
                    const Icon(
                      Icons.flag_outlined,
                      size: 12,
                      color: _wbdInkSoft,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        entry.vendors,
                        style: const TextStyle(
                          color: _wbdInkSoft,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.3,
                        ),
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

class _WbdEpilogue extends StatelessWidget {
  const _WbdEpilogue();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[_wbdInkNavyDeep, _wbdInkNavy, _wbdCeruleanDeep],
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _wbdInkNavyDeep.withValues(alpha: 0.3),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: _wbdAmber,
                  shape: BoxShape.circle,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: _wbdAmber.withValues(alpha: 0.6),
                      blurRadius: 14,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'EPILOGUE',
                style: TextStyle(
                  color: _wbdAmberPale,
                  fontSize: 11.5,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'WebBrowserDetection is the smallest surface that does the '
            'largest job of any Flutter helper: it lets a single codebase '
            'ship a well-behaved UI across engines that mostly agree, '
            'disagreeing only at the edges. Treat every call to it as a '
            'conscious act. Guard with kIsWeb. Prefer feature detection '
            'where you can. And when you cannot — reach for isSafari, '
            'document the quirk it masks, and move on.',
            style: TextStyle(
              color: Color(0xFFE6F0F8),
              fontSize: 12.5,
              height: 1.6,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: const <Widget>[
              _WbdChip(
                label: 'flutter/widgets.dart',
                icon: Icons.extension_outlined,
                color: _wbdCerulean,
                filled: true,
              ),
              _WbdChip(
                label: 'dart:ui_web',
                icon: Icons.hub_outlined,
                color: _wbdAmberDeep,
                filled: true,
              ),
              _WbdChip(
                label: 'native = stub',
                icon: Icons.memory,
                color: _wbdUnknown,
                filled: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
