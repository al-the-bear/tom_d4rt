import 'package:flutter/material.dart';

// ============================================================================
// ScrollDecelerationRate — Deep Visual Demo ("Deceleration Rate Dyno")
// ----------------------------------------------------------------------------
// Subject: ScrollDecelerationRate (enum: .normal, .fast)
//
//   .normal  — iOS-style slower ballistic coast. Default for BouncingScrollPhysics
//              on iOS. Feels silky, long gliding tails.
//   .fast    — Android-style snappier deceleration. Shorter coast, the list
//              "plants" sooner. Preferred for dense lists where users want
//              rapid stops.
//
// Entrypoint: dynamic build(BuildContext context) returning a MaterialApp.
//
// This file is a d4rt AST harness script — there is no main() and no runApp().
// It imports only package:flutter/material.dart; debugPrint is re-exported.
// ============================================================================

// ----------------------------------------------------------------------------
// Palette — "Dyno Track"
// ----------------------------------------------------------------------------
const Color _kTrackBlack = Color(0xFF101319);
const Color _kCardBg = Color(0xFF181C26);
const Color _kCardBgSoft = Color(0xFF1F2431);
const Color _kCardStroke = Color(0xFF2A3044);
const Color _kTextPrimary = Color(0xFFE4E9F2);
const Color _kTextSecondary = Color(0xFF9AA3B8);
const Color _kTextMuted = Color(0xFF6D7590);
const Color _kNormalNeon = Color(0xFF2EE6D6); // cyan for .normal
const Color _kFastMagenta = Color(0xFFFF4D8D); // magenta for .fast
const Color _kAccentAmber = Color(0xFFFFC857);
const Color _kAccentGreen = Color(0xFF6CF0A6);
const Color _kAccentRed = Color(0xFFFF6B6B);
const Color _kStripeA = Color(0xFF0B0D12);
const Color _kStripeB = Color(0xFF161A24);

// ----------------------------------------------------------------------------
// Tile palette — 50 items per track
// ----------------------------------------------------------------------------
const List<Color> _kTilePaletteNormal = <Color>[
  Color(0xFF0E3B3A),
  Color(0xFF124B47),
  Color(0xFF145B54),
  Color(0xFF176B61),
  Color(0xFF1A7B6E),
  Color(0xFF1D8B7B),
  Color(0xFF209B88),
  Color(0xFF23AB95),
  Color(0xFF26BBA2),
  Color(0xFF29CBAF),
];

const List<Color> _kTilePaletteFast = <Color>[
  Color(0xFF401428),
  Color(0xFF521930),
  Color(0xFF641E38),
  Color(0xFF76233F),
  Color(0xFF882847),
  Color(0xFF9A2D4F),
  Color(0xFFAC3257),
  Color(0xFFBE375F),
  Color(0xFFD03C66),
  Color(0xFFE2416E),
];

// ----------------------------------------------------------------------------
// Entry point
// ----------------------------------------------------------------------------
dynamic build(BuildContext context) {
  debugPrint('=== ScrollDecelerationRate Deep Demo — Deceleration Rate Dyno ===');
  debugPrint('.normal = iOS-style (slower), .fast = Android-style (snappier)');
  debugPrint('Two ListViews, same content, different ScrollPhysics.decelerationRate.');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Deceleration Rate Dyno',
    theme: ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: _kTrackBlack,
      primaryColor: _kNormalNeon,
      colorScheme: const ColorScheme.dark(
        primary: _kNormalNeon,
        secondary: _kFastMagenta,
        surface: _kCardBg,
      ),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: _kTextPrimary),
        bodySmall: TextStyle(color: _kTextSecondary),
      ),
    ),
    home: const _DynoHomePage(),
  );
}

// ============================================================================
// HOME PAGE
// ============================================================================
class _DynoHomePage extends StatefulWidget {
  const _DynoHomePage();

  @override
  State<_DynoHomePage> createState() => _DynoHomePageState();
}

class _DynoHomePageState extends State<_DynoHomePage>
    with TickerProviderStateMixin {
  // Controllers — one per track ---------------------------------------------
  final ScrollController _normalCtl = ScrollController();
  final ScrollController _fastCtl = ScrollController();

  // Listeners for live telemetry --------------------------------------------
  late final VoidCallback _normalListener;
  late final VoidCallback _fastListener;

  // Telemetry samples -------------------------------------------------------
  final _TelemetryBuffer _normalBuf = _TelemetryBuffer(capacity: 400);
  final _TelemetryBuffer _fastBuf = _TelemetryBuffer(capacity: 400);

  // Animation ticker for redrawing telemetry overlays -----------------------
  late final AnimationController _ticker;

  // Displayed pixel values --------------------------------------------------
  double _normalPixels = 0.0;
  double _fastPixels = 0.0;
  double _normalVelocity = 0.0;
  double _fastVelocity = 0.0;

  // Previous samples for velocity estimation --------------------------------
  double _normalPrev = 0.0;
  double _fastPrev = 0.0;
  DateTime _normalPrevT = DateTime.now();
  DateTime _fastPrevT = DateTime.now();

  @override
  void initState() {
    super.initState();
    _ticker = AnimationController(
      vsync: this,
      duration: const Duration(days: 1),
    )..repeat();

    _normalListener = () {
      if (!_normalCtl.hasClients) return;
      final now = DateTime.now();
      final px = _normalCtl.position.pixels;
      final dt = now.difference(_normalPrevT).inMicroseconds / 1e6;
      final v = dt > 0 ? (px - _normalPrev) / dt : 0.0;
      _normalPrev = px;
      _normalPrevT = now;
      _normalBuf.push(px);
      setState(() {
        _normalPixels = px;
        _normalVelocity = v;
      });
    };
    _fastListener = () {
      if (!_fastCtl.hasClients) return;
      final now = DateTime.now();
      final px = _fastCtl.position.pixels;
      final dt = now.difference(_fastPrevT).inMicroseconds / 1e6;
      final v = dt > 0 ? (px - _fastPrev) / dt : 0.0;
      _fastPrev = px;
      _fastPrevT = now;
      _fastBuf.push(px);
      setState(() {
        _fastPixels = px;
        _fastVelocity = v;
      });
    };

    _normalCtl.addListener(_normalListener);
    _fastCtl.addListener(_fastListener);
  }

  @override
  void dispose() {
    _normalCtl.removeListener(_normalListener);
    _fastCtl.removeListener(_fastListener);
    _normalCtl.dispose();
    _fastCtl.dispose();
    _ticker.dispose();
    super.dispose();
  }

  // Synthetic "fling both" button ------------------------------------------
  void _flingBoth() {
    const double delta = 900.0;
    const Duration duration = Duration(milliseconds: 1400);
    if (_normalCtl.hasClients) {
      final target = (_normalCtl.position.pixels + delta).clamp(
        _normalCtl.position.minScrollExtent,
        _normalCtl.position.maxScrollExtent,
      );
      _normalCtl.animateTo(
        target,
        duration: duration,
        curve: Curves.decelerate,
      );
    }
    if (_fastCtl.hasClients) {
      final target = (_fastCtl.position.pixels + delta).clamp(
        _fastCtl.position.minScrollExtent,
        _fastCtl.position.maxScrollExtent,
      );
      _fastCtl.animateTo(
        target,
        // Shorter, sharper coast for the fast track
        duration: const Duration(milliseconds: 900),
        curve: Curves.decelerate,
      );
    }
  }

  void _resetBoth() {
    if (_normalCtl.hasClients) {
      _normalCtl.animateTo(
        0,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      );
    }
    if (_fastCtl.hasClients) {
      _fastCtl.animateTo(
        0,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      );
    }
    _normalBuf.clear();
    _fastBuf.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kTrackBlack,
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            // -----------------------------------------------------------------
            // 1) Hero header
            // -----------------------------------------------------------------
            SliverToBoxAdapter(child: _HeroHeader()),

            // -----------------------------------------------------------------
            // 2) Side-by-side dyno track
            // -----------------------------------------------------------------
            SliverToBoxAdapter(
              child: _DynoTrackPair(
                normalController: _normalCtl,
                fastController: _fastCtl,
              ),
            ),

            // -----------------------------------------------------------------
            // 3) Live telemetry — one card per side
            // -----------------------------------------------------------------
            SliverToBoxAdapter(
              child: _TelemetryRow(
                normalController: _normalCtl,
                fastController: _fastCtl,
                normalPixels: _normalPixels,
                fastPixels: _fastPixels,
                normalVelocity: _normalVelocity,
                fastVelocity: _fastVelocity,
              ),
            ),

            // -----------------------------------------------------------------
            // 4) Coast curve sparklines
            // -----------------------------------------------------------------
            SliverToBoxAdapter(
              child: _CoastCurves(
                normalBuf: _normalBuf,
                fastBuf: _fastBuf,
                ticker: _ticker,
              ),
            ),

            // -----------------------------------------------------------------
            // 5) Synchronized fling button row
            // -----------------------------------------------------------------
            SliverToBoxAdapter(
              child: _FlingControls(
                onFling: _flingBoth,
                onReset: _resetBoth,
              ),
            ),

            // -----------------------------------------------------------------
            // 6) Enum reference card
            // -----------------------------------------------------------------
            const SliverToBoxAdapter(child: _EnumReferenceCard()),

            // -----------------------------------------------------------------
            // 7) Physics interaction matrix
            // -----------------------------------------------------------------
            const SliverToBoxAdapter(child: _PhysicsMatrixCard()),

            // -----------------------------------------------------------------
            // 8) "When to use which" guide
            // -----------------------------------------------------------------
            const SliverToBoxAdapter(child: _WhenToUseCard()),

            // -----------------------------------------------------------------
            // 9) Code snippet panel
            // -----------------------------------------------------------------
            const SliverToBoxAdapter(child: _CodeSnippetPanel()),

            // -----------------------------------------------------------------
            // 10) Teaching panel — gotchas
            // -----------------------------------------------------------------
            const SliverToBoxAdapter(child: _GotchasPanel()),

            // -----------------------------------------------------------------
            // 11) Footer summary
            // -----------------------------------------------------------------
            const SliverToBoxAdapter(child: _FooterCard()),

            const SliverToBoxAdapter(child: SizedBox(height: 48)),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// SECTION 1 — HERO HEADER
// ============================================================================
class _HeroHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 8),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Color(0xFF101319),
            Color(0xFF1B1F2D),
            Color(0xFF23283A),
          ],
        ),
        border: Border.all(color: _kCardStroke, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const SweepGradient(
                    colors: <Color>[
                      _kNormalNeon,
                      _kFastMagenta,
                      _kAccentAmber,
                      _kNormalNeon,
                    ],
                  ),
                ),
                child: const Center(
                  child: Icon(Icons.speed_rounded, color: Colors.black,
                      size: 24),
                ),
              ),
              const SizedBox(width: 14),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'ScrollDecelerationRate — Normal vs Fast',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: _kTextPrimary,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Flick the same list two ways; watch them coast differently.',
                      style: TextStyle(
                        fontSize: 13,
                        color: _kTextSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            children: const <Widget>[
              _HeroBadge(
                label: '.normal',
                sub: 'iOS-feel',
                color: _kNormalNeon,
              ),
              SizedBox(width: 12),
              _HeroBadge(
                label: '.fast',
                sub: 'Android-feel',
                color: _kFastMagenta,
              ),
              SizedBox(width: 12),
              _HeroBadge(
                label: 'ballistic only',
                sub: 'does not affect drag',
                color: _kAccentAmber,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeroBadge extends StatelessWidget {
  final String label;
  final String sub;
  final Color color;
  const _HeroBadge({required this.label, required this.sub, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 12,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                sub,
                style: const TextStyle(
                  color: _kTextMuted,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// SECTION 2 — DYNO TRACK PAIR
// ============================================================================
class _DynoTrackPair extends StatelessWidget {
  final ScrollController normalController;
  final ScrollController fastController;

  const _DynoTrackPair({
    required this.normalController,
    required this.fastController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
      child: SizedBox(
        height: 420,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: _DynoLane(
                label: 'normal',
                sublabel: 'iOS-feel (slower)',
                color: _kNormalNeon,
                tilePalette: _kTilePaletteNormal,
                controller: normalController,
                decelerationRate: ScrollDecelerationRate.normal,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: _DynoLane(
                label: 'fast',
                sublabel: 'Android-feel (snappier)',
                color: _kFastMagenta,
                tilePalette: _kTilePaletteFast,
                controller: fastController,
                decelerationRate: ScrollDecelerationRate.fast,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DynoLane extends StatelessWidget {
  final String label;
  final String sublabel;
  final Color color;
  final List<Color> tilePalette;
  final ScrollController controller;
  final ScrollDecelerationRate decelerationRate;

  const _DynoLane({
    required this.label,
    required this.sublabel,
    required this.color,
    required this.tilePalette,
    required this.controller,
    required this.decelerationRate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _kCardStroke),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Racing stripe header
          _RacingStripeHeader(
            label: label,
            sublabel: sublabel,
            color: color,
          ),
          // The ListView — BISECT: no BouncingScrollPhysics
          Expanded(
            child: ListView.builder(
              controller: controller,
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 8,
              ),
              itemCount: 50,
              itemBuilder: (context, index) {
                return _LaneTile(
                  index: index,
                  color: tilePalette[index % tilePalette.length],
                  accent: color,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _RacingStripeHeader extends StatelessWidget {
  final String label;
  final String sublabel;
  final Color color;
  const _RacingStripeHeader({
    required this.label,
    required this.sublabel,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54,
      child: Stack(
        children: <Widget>[
          // Diagonal racing stripes
          Positioned.fill(
            child: CustomPaint(
              painter: _RacingStripesPainter(
                colorA: _kStripeA,
                colorB: _kStripeB,
              ),
            ),
          ),
          // Glow from the side
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    color.withValues(alpha: 0.25),
                    color.withValues(alpha: 0.00),
                  ],
                ),
              ),
            ),
          ),
          // Label
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              children: <Widget>[
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: color.withValues(alpha: 0.7),
                        blurRadius: 10,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  label,
                  style: TextStyle(
                    color: color,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'monospace',
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: Text(
                    sublabel,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: _kTextSecondary,
                      fontSize: 11,
                    ),
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

class _RacingStripesPainter extends CustomPainter {
  final Color colorA;
  final Color colorB;
  _RacingStripesPainter({required this.colorA, required this.colorB});

  @override
  void paint(Canvas canvas, Size size) {
    final paintA = Paint()..color = colorA;
    final paintB = Paint()..color = colorB;
    canvas.drawRect(Offset.zero & size, paintA);
    const double stripeWidth = 24;
    for (double x = -size.height; x < size.width + size.height;
        x += stripeWidth * 2) {
      final path = Path()
        ..moveTo(x, 0)
        ..lineTo(x + stripeWidth, 0)
        ..lineTo(x + stripeWidth + size.height, size.height)
        ..lineTo(x + size.height, size.height)
        ..close();
      canvas.drawPath(path, paintB);
    }
  }

  @override
  bool shouldRepaint(covariant _RacingStripesPainter oldDelegate) =>
      oldDelegate.colorA != colorA || oldDelegate.colorB != colorB;
}

class _LaneTile extends StatelessWidget {
  final int index;
  final Color color;
  final Color accent;
  const _LaneTile({
    required this.index,
    required this.color,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: accent.withValues(alpha: 0.15)),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: accent.withValues(alpha: 0.22),
              border: Border.all(color: accent.withValues(alpha: 0.65)),
            ),
            child: Center(
              child: Text(
                '${index + 1}',
                style: const TextStyle(
                  color: _kTextPrimary,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'tile ${index.toString().padLeft(2, '0')}',
                  style: const TextStyle(
                    color: _kTextPrimary,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'dyno segment · coast test',
                  style: TextStyle(
                    color: _kTextSecondary.withValues(alpha: 0.8),
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios,
              color: accent.withValues(alpha: 0.6), size: 12),
        ],
      ),
    );
  }
}

// Custom ScrollBehavior that returns BouncingScrollPhysics with a given
// decelerationRate. This is the direct integration between
// ScrollDecelerationRate and the scroll pipeline.
class _DecelerationBehavior extends ScrollBehavior {
  final ScrollDecelerationRate decelerationRate;
  const _DecelerationBehavior({required this.decelerationRate});

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return BouncingScrollPhysics(decelerationRate: decelerationRate);
  }

  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

// ============================================================================
// SECTION 3 — LIVE TELEMETRY
// ============================================================================
class _TelemetryRow extends StatelessWidget {
  final ScrollController normalController;
  final ScrollController fastController;
  final double normalPixels;
  final double fastPixels;
  final double normalVelocity;
  final double fastVelocity;

  const _TelemetryRow({
    required this.normalController,
    required this.fastController,
    required this.normalPixels,
    required this.fastPixels,
    required this.normalVelocity,
    required this.fastVelocity,
  });

  @override
  Widget build(BuildContext context) {
    // `crossAxisAlignment: stretch` propagates the parent
    // `SliverToBoxAdapter`'s unbounded-height into each `Expanded`
    // child and trips the C3/E8 cascade. Default cross-alignment lets
    // each card size itself to its content, which is what the original
    // visual layout intended (cards have intrinsic content heights).
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 6, 20, 6),
      child: Row(
        children: <Widget>[
          Expanded(
            child: _TelemetryCard(
              label: '.normal telemetry',
              color: _kNormalNeon,
              controller: normalController,
              pixels: normalPixels,
              velocity: normalVelocity,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: _TelemetryCard(
              label: '.fast telemetry',
              color: _kFastMagenta,
              controller: fastController,
              pixels: fastPixels,
              velocity: fastVelocity,
            ),
          ),
        ],
      ),
    );
  }
}

class _TelemetryCard extends StatelessWidget {
  final String label;
  final Color color;
  final ScrollController controller;
  final double pixels;
  final double velocity;

  const _TelemetryCard({
    required this.label,
    required this.color,
    required this.controller,
    required this.pixels,
    required this.velocity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kCardStroke),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              _Dot(color: color),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontFamily: 'monospace',
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              _ScrollingPill(controller: controller, color: color),
            ],
          ),
          const SizedBox(height: 12),
          _TelemetryRowKV(
            k: 'pixels',
            v: pixels.toStringAsFixed(1),
            color: _kTextPrimary,
          ),
          const SizedBox(height: 6),
          _TelemetryRowKV(
            k: 'velocity',
            v: '${velocity.toStringAsFixed(1)} px/s',
            color: velocity.abs() > 0.5 ? color : _kTextSecondary,
          ),
          const SizedBox(height: 6),
          _TelemetryRowKV(
            k: 'max',
            v: controller.hasClients
                ? controller.position.maxScrollExtent.toStringAsFixed(0)
                : '—',
            color: _kTextSecondary,
          ),
        ],
      ),
    );
  }
}

class _TelemetryRowKV extends StatelessWidget {
  final String k;
  final String v;
  final Color color;
  const _TelemetryRowKV({
    required this.k,
    required this.v,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 72,
          child: Text(
            k,
            style: const TextStyle(
              color: _kTextMuted,
              fontSize: 11,
              fontFamily: 'monospace',
            ),
          ),
        ),
        Text(
          v,
          style: TextStyle(
            color: color,
            fontSize: 13,
            fontFamily: 'monospace',
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _ScrollingPill extends StatelessWidget {
  final ScrollController controller;
  final Color color;
  const _ScrollingPill({required this.controller, required this.color});

  @override
  Widget build(BuildContext context) {
    if (!controller.hasClients) {
      return _PillStatic(label: 'idle', color: _kTextMuted);
    }
    return ValueListenableBuilder<bool>(
      valueListenable: controller.position.isScrollingNotifier,
      builder: (context, isScrolling, _) {
        return _PillStatic(
          label: isScrolling ? 'scrolling' : 'at rest',
          color: isScrolling ? color : _kTextMuted,
        );
      },
    );
  }
}

class _PillStatic extends StatelessWidget {
  final String label;
  final Color color;
  const _PillStatic({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontFamily: 'monospace',
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final Color color;
  const _Dot({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: color.withValues(alpha: 0.6),
            blurRadius: 8,
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// SECTION 4 — COAST CURVE SPARKLINES
// ============================================================================
class _TelemetryBuffer {
  final int capacity;
  final List<double> _samples = <double>[];
  _TelemetryBuffer({required this.capacity});

  void push(double v) {
    _samples.add(v);
    if (_samples.length > capacity) {
      _samples.removeAt(0);
    }
  }

  void clear() => _samples.clear();

  List<double> snapshot() => List<double>.unmodifiable(_samples);

  int get length => _samples.length;
}

class _CoastCurves extends StatelessWidget {
  final _TelemetryBuffer normalBuf;
  final _TelemetryBuffer fastBuf;
  final Listenable ticker;

  const _CoastCurves({
    required this.normalBuf,
    required this.fastBuf,
    required this.ticker,
  });

  @override
  Widget build(BuildContext context) {
    // Same shape as `_TelemetryRow.build`: avoid `crossAxisAlignment:
    // stretch` because `SliverToBoxAdapter` propagates an unbounded
    // height. `_SparkCard` already pins `height: 120`, so the row's
    // cross-axis simply matches the cards' intrinsic 120 px.
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 6, 20, 10),
      child: Row(
        children: <Widget>[
          Expanded(
            child: _SparkCard(
              title: '.normal coast curve',
              color: _kNormalNeon,
              buffer: normalBuf,
              ticker: ticker,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: _SparkCard(
              title: '.fast coast curve',
              color: _kFastMagenta,
              buffer: fastBuf,
              ticker: ticker,
            ),
          ),
        ],
      ),
    );
  }
}

class _SparkCard extends StatelessWidget {
  final String title;
  final Color color;
  final _TelemetryBuffer buffer;
  final Listenable ticker;

  const _SparkCard({
    required this.title,
    required this.color,
    required this.buffer,
    required this.ticker,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kCardStroke),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              _Dot(color: color),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  color: color,
                  fontSize: 12,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              Text(
                '400-sample window',
                style: TextStyle(
                  color: _kTextMuted.withValues(alpha: 0.8),
                  fontSize: 10,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: AnimatedBuilder(
              animation: ticker,
              builder: (context, _) {
                return CustomPaint(
                  painter: _SparkPainter(
                    samples: buffer.snapshot(),
                    color: color,
                  ),
                  child: const SizedBox.expand(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SparkPainter extends CustomPainter {
  final List<double> samples;
  final Color color;
  _SparkPainter({required this.samples, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    // Baseline grid
    final gridPaint = Paint()
      ..color = _kCardStroke.withValues(alpha: 0.5)
      ..strokeWidth = 0.5;
    for (int i = 0; i <= 4; i++) {
      final y = size.height * i / 4;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }
    for (int i = 0; i <= 5; i++) {
      final x = size.width * i / 5;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }

    if (samples.length < 2) {
      final textPainter = TextPainter(
        text: const TextSpan(
          text: 'scroll to record…',
          style: TextStyle(color: _kTextMuted, fontSize: 11),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      textPainter.paint(
        canvas,
        Offset(
          (size.width - textPainter.width) / 2,
          (size.height - textPainter.height) / 2,
        ),
      );
      return;
    }

    double minV = samples.first, maxV = samples.first;
    for (final v in samples) {
      if (v < minV) minV = v;
      if (v > maxV) maxV = v;
    }
    final range = (maxV - minV).abs() < 1e-6 ? 1.0 : (maxV - minV);

    final linePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = color
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final fillPaint = Paint()
      ..style = PaintingStyle.fill
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[
          color.withValues(alpha: 0.35),
          color.withValues(alpha: 0.02),
        ],
      ).createShader(Offset.zero & size);

    final linePath = Path();
    final fillPath = Path()..moveTo(0, size.height);
    for (int i = 0; i < samples.length; i++) {
      final x = size.width * i / (samples.length - 1);
      final y = size.height -
          ((samples[i] - minV) / range) * size.height;
      if (i == 0) {
        linePath.moveTo(x, y);
      } else {
        linePath.lineTo(x, y);
      }
      fillPath.lineTo(x, y);
    }
    fillPath.lineTo(size.width, size.height);
    fillPath.close();

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(linePath, linePaint);

    // Current-value dot
    if (samples.isNotEmpty) {
      final lastX = size.width;
      final lastY = size.height -
          ((samples.last - minV) / range) * size.height;
      canvas.drawCircle(
        Offset(lastX, lastY),
        3,
        Paint()..color = color,
      );
      canvas.drawCircle(
        Offset(lastX, lastY),
        6,
        Paint()
          ..color = color.withValues(alpha: 0.3)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _SparkPainter oldDelegate) => true;
}

// ============================================================================
// SECTION 5 — FLING CONTROLS
// ============================================================================
class _FlingControls extends StatelessWidget {
  final VoidCallback onFling;
  final VoidCallback onReset;
  const _FlingControls({required this.onFling, required this.onReset});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: _kCardBg,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _kCardStroke),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                const Icon(Icons.auto_graph, color: _kAccentAmber, size: 18),
                const SizedBox(width: 8),
                const Text(
                  'Synchronized Fling',
                  style: TextStyle(
                    color: _kTextPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: _kAccentAmber.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    'synthetic analog',
                    style: TextStyle(
                      color: _kAccentAmber,
                      fontSize: 10,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'Pushes both positions by +900 px with Curves.decelerate. '
              'Real flings go through BallisticScrollActivity; this animation '
              'is a teaching stand-in — the coast shapes come from '
              'decelerationRate when the user actually flicks.',
              style: TextStyle(
                color: _kTextSecondary,
                fontSize: 11,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: <Widget>[
                Expanded(
                  child: _BigButton(
                    label: 'FLING BOTH  ›',
                    color: _kAccentAmber,
                    onTap: onFling,
                  ),
                ),
                const SizedBox(width: 10),
                _SmallButton(
                  label: 'reset',
                  onTap: onReset,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _BigButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onTap;
  const _BigButton({
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Container(
          height: 44,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              colors: <Color>[
                color.withValues(alpha: 0.7),
                color.withValues(alpha: 0.3),
              ],
            ),
            border: Border.all(color: color),
          ),
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 13,
              fontWeight: FontWeight.w800,
              fontFamily: 'monospace',
              letterSpacing: 1.3,
            ),
          ),
        ),
      ),
    );
  }
}

class _SmallButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _SmallButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Container(
          height: 44,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: _kCardBgSoft,
            border: Border.all(color: _kCardStroke),
          ),
          child: Text(
            label,
            style: const TextStyle(
              color: _kTextSecondary,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// SECTION 6 — ENUM REFERENCE CARD
// ============================================================================
class _EnumReferenceCard extends StatelessWidget {
  const _EnumReferenceCard();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _kCardBg,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _kCardStroke),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const _SectionTitle(
              icon: Icons.menu_book_rounded,
              text: 'Enum Reference',
            ),
            const SizedBox(height: 14),
            // No `crossAxisAlignment: stretch` — outer
            // `SliverToBoxAdapter > Padding > Container > Column` is
            // vertically unbounded. Stretch would propagate infinity
            // into the `Expanded` children (C3/E8 cascade). Default
            // alignment lets `_EnumCell` size itself naturally.
            Row(
              children: <Widget>[
                Expanded(
                  child: _EnumCell(
                    name: 'ScrollDecelerationRate.normal',
                    description:
                        'iOS-style slower fling deceleration. Long, gliding '
                        'tails. Default for BouncingScrollPhysics on iOS.',
                    platforms: 'iOS · macOS',
                    color: _kNormalNeon,
                    friction: 'lower friction coefficient',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _EnumCell(
                    name: 'ScrollDecelerationRate.fast',
                    description:
                        'Android-style snappier deceleration. Lists "plant" '
                        'sooner. Preferred for dense feeds where users want '
                        'quick stops.',
                    platforms: 'Android · Windows · Linux · Web',
                    color: _kFastMagenta,
                    friction: 'higher friction coefficient',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _EnumCell extends StatelessWidget {
  final String name;
  final String description;
  final String platforms;
  final Color color;
  final String friction;

  const _EnumCell({
    required this.name,
    required this.description,
    required this.platforms,
    required this.color,
    required this.friction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kCardBgSoft,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            name,
            style: TextStyle(
              color: color,
              fontSize: 13,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(
              color: _kTextPrimary,
              fontSize: 12,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 10),
          _KVRow(k: 'platforms', v: platforms, color: color),
          const SizedBox(height: 4),
          _KVRow(k: 'friction', v: friction, color: color),
        ],
      ),
    );
  }
}

class _KVRow extends StatelessWidget {
  final String k;
  final String v;
  final Color color;
  const _KVRow({required this.k, required this.v, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 70,
          child: Text(
            k,
            style: const TextStyle(
              color: _kTextMuted,
              fontSize: 10,
              fontFamily: 'monospace',
            ),
          ),
        ),
        Expanded(
          child: Text(
            v,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    );
  }
}

// ============================================================================
// SECTION 7 — PHYSICS INTERACTION MATRIX
// ============================================================================
class _PhysicsMatrixCard extends StatelessWidget {
  const _PhysicsMatrixCard();

  @override
  Widget build(BuildContext context) {
    const rows = <_MatrixRow>[
      _MatrixRow(
        physics: 'BouncingScrollPhysics',
        supports: true,
        note: 'iOS-style bounce — accepts decelerationRate: directly.',
      ),
      _MatrixRow(
        physics: 'ClampingScrollPhysics',
        supports: true,
        note: 'Android-style clamping — also accepts decelerationRate:.',
      ),
      _MatrixRow(
        physics: 'PageScrollPhysics',
        supports: false,
        note: 'Snap-to-page motion; decelerationRate has no effect.',
      ),
      _MatrixRow(
        physics: 'FixedExtentScrollPhysics',
        supports: false,
        note: 'Wheel-style snap (date picker); not influenced.',
      ),
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _kCardBg,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _kCardStroke),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const _SectionTitle(
              icon: Icons.grid_on_rounded,
              text: 'Physics · decelerationRate interaction matrix',
            ),
            const SizedBox(height: 12),
            _MatrixHeader(),
            const SizedBox(height: 2),
            ...rows.map((r) => _MatrixRowWidget(row: r)),
          ],
        ),
      ),
    );
  }
}

class _MatrixRow {
  final String physics;
  final bool supports;
  final String note;
  const _MatrixRow({
    required this.physics,
    required this.supports,
    required this.note,
  });
}

class _MatrixHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: _kCardBgSoft,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Row(
        children: <Widget>[
          SizedBox(
            width: 200,
            child: Text(
              'ScrollPhysics subclass',
              style: TextStyle(
                color: _kTextMuted,
                fontSize: 11,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(
            width: 70,
            child: Text(
              'accepts',
              style: TextStyle(
                color: _kTextMuted,
                fontSize: 11,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'notes',
              style: TextStyle(
                color: _kTextMuted,
                fontSize: 11,
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

class _MatrixRowWidget extends StatelessWidget {
  final _MatrixRow row;
  const _MatrixRowWidget({required this.row});

  @override
  Widget build(BuildContext context) {
    final checkColor = row.supports ? _kAccentGreen : _kAccentRed;
    return Container(
      margin: const EdgeInsets.only(top: 4),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: _kCardBgSoft.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(8),
        border: Border(
          left: BorderSide(color: checkColor, width: 3),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 200,
            child: Text(
              row.physics,
              style: const TextStyle(
                color: _kTextPrimary,
                fontSize: 12,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            width: 70,
            child: Row(
              children: <Widget>[
                Icon(
                  row.supports ? Icons.check_circle : Icons.cancel,
                  color: checkColor,
                  size: 14,
                ),
                const SizedBox(width: 4),
                Text(
                  row.supports ? 'yes' : 'no',
                  style: TextStyle(
                    color: checkColor,
                    fontSize: 11,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Text(
              row.note,
              style: const TextStyle(
                color: _kTextSecondary,
                fontSize: 11,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// SECTION 8 — WHEN TO USE WHICH
// ============================================================================
class _WhenToUseCard extends StatelessWidget {
  const _WhenToUseCard();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _kCardBg,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _kCardStroke),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const _SectionTitle(
              icon: Icons.psychology_alt_rounded,
              text: 'When to use which',
            ),
            const SizedBox(height: 12),
            // No `crossAxisAlignment: stretch` — same reason as the
            // Enum Reference card above. Outer parent is vertically
            // unbounded; stretching would propagate infinity into
            // `Expanded`.
            Row(
              children: const <Widget>[
                Expanded(
                  child: _UseTile(
                    heading: 'Use .normal when…',
                    color: _kNormalNeon,
                    bullets: <String>[
                      'Building for iOS / macOS — users expect long, gliding '
                          'fling tails.',
                      'UI surfaces that imitate the stock iOS look '
                          '(settings, detail pages, feeds).',
                      'Content where the "coast after flick" is part of the '
                          'vibe — reading, browsing.',
                    ],
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: _UseTile(
                    heading: 'Use .fast when…',
                    color: _kFastMagenta,
                    bullets: <String>[
                      'Building for Android / desktop — users expect snappy '
                          'stops.',
                      'Dense lists (admin tables, grids) where long coast '
                          'feels wasteful.',
                      'Touch-precision scenarios — quick stops let users '
                          'land on items accurately.',
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _UseTile extends StatelessWidget {
  final String heading;
  final Color color;
  final List<String> bullets;

  const _UseTile({
    required this.heading,
    required this.color,
    required this.bullets,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kCardBgSoft,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            heading,
            style: TextStyle(
              color: color,
              fontSize: 13,
              fontWeight: FontWeight.w800,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(height: 10),
          ...bullets.map(
            (b) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 6,
                    height: 6,
                    margin: const EdgeInsets.only(top: 6, right: 8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: color,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      b,
                      style: const TextStyle(
                        color: _kTextPrimary,
                        fontSize: 11,
                        height: 1.5,
                      ),
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

// ============================================================================
// SECTION 9 — CODE SNIPPET PANEL
// ============================================================================
class _CodeSnippetPanel extends StatelessWidget {
  const _CodeSnippetPanel();

  @override
  Widget build(BuildContext context) {
    const code = '''// Fast Android-feel ballistic coast.
final physics = BouncingScrollPhysics(
  decelerationRate: ScrollDecelerationRate.fast,
);

// Inside ListView:
ListView.builder(
  physics: physics,
  itemCount: items.length,
  itemBuilder: (ctx, i) => MyTile(items[i]),
);

// Or via ScrollBehavior for a whole subtree:
class SnappyBehavior extends ScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext ctx) =>
      const BouncingScrollPhysics(
        decelerationRate: ScrollDecelerationRate.fast,
      );
}''';

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _kCardBg,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _kCardStroke),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const _SectionTitle(
              icon: Icons.terminal_rounded,
              text: 'Code snippet',
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFF0B0E15),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _kCardStroke),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: List<Widget>.generate(
                      code.split('\n').length,
                      (i) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 1),
                        child: Text(
                          '${i + 1}'.padLeft(2, ' '),
                          style: const TextStyle(
                            color: _kTextMuted,
                            fontSize: 11,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: code
                          .split('\n')
                          .map(
                            (line) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 1),
                              child: Text(
                                line.isEmpty ? ' ' : line,
                                style: TextStyle(
                                  color: _colorizeHint(line),
                                  fontSize: 11,
                                  fontFamily: 'monospace',
                                  height: 1.35,
                                ),
                              ),
                            ),
                          )
                          .toList(),
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

  static Color _colorizeHint(String line) {
    final trimmed = line.trim();
    if (trimmed.startsWith('//')) return _kTextMuted;
    if (trimmed.startsWith('class ') ||
        trimmed.startsWith('final ') ||
        trimmed.startsWith('const ')) {
      return _kAccentAmber;
    }
    if (trimmed.contains('decelerationRate')) return _kFastMagenta;
    if (trimmed.contains('BouncingScrollPhysics')) return _kNormalNeon;
    return _kTextPrimary;
  }
}

// ============================================================================
// SECTION 10 — GOTCHAS / TEACHING PANEL
// ============================================================================
class _GotchasPanel extends StatelessWidget {
  const _GotchasPanel();

  @override
  Widget build(BuildContext context) {
    const gotchas = <_Gotcha>[
      _Gotcha(
        icon: Icons.pan_tool_rounded,
        title: 'Only affects ballistic motion',
        body:
            'decelerationRate only changes how the list coasts after a fling. '
            'While the user drags with their finger, the pixel-by-pixel motion '
            'follows the touch exactly — the rate parameter is ignored.',
      ),
      _Gotcha(
        icon: Icons.do_not_disturb_on_rounded,
        title: 'Does not affect snap-to-item physics',
        body:
            'FixedExtentScrollPhysics (used by the Cupertino wheel pickers and '
            'date/time pickers) ignores decelerationRate — the snap spring '
            'does its own thing.',
      ),
      _Gotcha(
        icon: Icons.book_rounded,
        title: 'Also does not affect pages',
        body:
            'PageView uses PageScrollPhysics which snaps to pages. Setting '
            'decelerationRate on it has no observable effect.',
      ),
      _Gotcha(
        icon: Icons.ios_share_rounded,
        title: 'Default depends on the physics class',
        body:
            'BouncingScrollPhysics defaults to ScrollDecelerationRate.normal '
            '(iOS-feel). ClampingScrollPhysics also defaults to .normal. If '
            'you want the Android snap, opt into .fast explicitly.',
      ),
      _Gotcha(
        icon: Icons.extension_rounded,
        title: 'Cross-platform trick',
        body:
            'Choose ScrollDecelerationRate based on Theme.of(context).platform '
            'inside a custom ScrollBehavior to give each platform its native '
            'ballistic feel with one widget tree.',
      ),
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _kCardBg,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _kCardStroke),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const _SectionTitle(
              icon: Icons.lightbulb_rounded,
              text: 'Gotchas / teaching panel',
            ),
            const SizedBox(height: 12),
            ...gotchas.map((g) => _GotchaTile(gotcha: g)),
          ],
        ),
      ),
    );
  }
}

class _Gotcha {
  final IconData icon;
  final String title;
  final String body;
  const _Gotcha({
    required this.icon,
    required this.title,
    required this.body,
  });
}

class _GotchaTile extends StatelessWidget {
  final _Gotcha gotcha;
  const _GotchaTile({required this.gotcha});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kCardBgSoft,
        borderRadius: BorderRadius.circular(10),
        border: Border(
          left: BorderSide(color: _kAccentAmber, width: 3),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: _kAccentAmber.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(gotcha.icon, color: _kAccentAmber, size: 16),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  gotcha.title,
                  style: const TextStyle(
                    color: _kTextPrimary,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  gotcha.body,
                  style: const TextStyle(
                    color: _kTextSecondary,
                    fontSize: 11,
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

// ============================================================================
// SECTION 11 — FOOTER SUMMARY
// ============================================================================
class _FooterCard extends StatelessWidget {
  const _FooterCard();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(
            colors: <Color>[
              Color(0xFF0E1117),
              Color(0xFF181C26),
            ],
          ),
          border: Border.all(color: _kCardStroke),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: const <Widget>[
                Icon(Icons.flag_rounded,
                    color: _kAccentGreen, size: 18),
                SizedBox(width: 8),
                Text(
                  'Summary',
                  style: TextStyle(
                    color: _kTextPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              'ScrollDecelerationRate is a tiny enum with a big visible effect. '
              'It picks the friction constant used when a scrollable coasts '
              'after a fling. Pair with BouncingScrollPhysics or '
              'ClampingScrollPhysics — the other physics classes ignore it. '
              'Use .normal for iOS-feel, .fast for Android-feel, and switch '
              'per-platform if you want the best of both.',
              style: TextStyle(
                color: _kTextSecondary,
                fontSize: 12,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 14),
            Row(
              children: <Widget>[
                _StatChip(
                  label: 'ScrollDecelerationRate',
                  value: 'enum · 2',
                  color: _kNormalNeon,
                ),
                const SizedBox(width: 8),
                _StatChip(
                  label: 'Physics supporting it',
                  value: '2',
                  color: _kAccentGreen,
                ),
                const SizedBox(width: 8),
                _StatChip(
                  label: 'Physics ignoring it',
                  value: '2',
                  color: _kAccentRed,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  const _StatChip({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color.withValues(alpha: 0.4)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              value,
              style: TextStyle(
                color: color,
                fontSize: 16,
                fontWeight: FontWeight.w800,
                fontFamily: 'monospace',
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: const TextStyle(
                color: _kTextMuted,
                fontSize: 9.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// SHARED — SECTION TITLE
// ============================================================================
class _SectionTitle extends StatelessWidget {
  final IconData icon;
  final String text;
  const _SectionTitle({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: _kNormalNeon.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: _kNormalNeon, size: 16),
        ),
        const SizedBox(width: 10),
        Text(
          text,
          style: const TextStyle(
            color: _kTextPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}
