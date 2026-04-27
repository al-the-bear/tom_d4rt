// D4rt test script: Tick Workshop — SingleTickerProviderStateMixin Deep Demo
//
// SUBJECT
// -------
// `SingleTickerProviderStateMixin` is the State mixin that provides
// exactly ONE Ticker for a SINGLE AnimationController. It is the
// lightweight sibling of `TickerProviderStateMixin` — cheaper because it
// stores a single `Ticker?` field rather than a Set, and because it
// asserts at runtime that you never create a second Ticker through it.
//
// This Deep Demo visualises the mixin in six scenes:
//   1) Hero — analog tick dial painted by a CustomPainter, its second
//      hand advanced every frame by a Ticker owned by an
//      AnimationController whose vsync is a State mixed with
//      SingleTickerProviderStateMixin.
//   2) Pulsing blob — a circle whose radius is animated with
//      Curves.easeInOutCubic and the value is reported in a sidebar.
//   3) Controller playground — play / pause / reverse / restart buttons
//      plus a speed slider that mutates `AnimationController.duration`
//      on the fly, demonstrating that the Ticker continues firing while
//      the underlying duration is swapped.
//   4) Single-vs-Multi comparison — same visual animation rendered once
//      with `SingleTickerProviderStateMixin` and once with
//      `TickerProviderStateMixin`, with a memory/lifecycle explainer.
//   5) Pitfall card — what happens when you try to create a second
//      AnimationController through a Single provider. The assertion is
//      NOT triggered at runtime; the message is rendered as data so the
//      demo stays green in the D4rt AST harness.
//   6) Lifecycle log — timestamps for createTicker, approximate tick
//      count per second, and dispose ordering.
//
// HARNESS CONTRACT
// ----------------
// The entry point is `dynamic build(BuildContext context)` returning a
// `MaterialApp`. There is no `main()` and no `runApp()`. All animations
// are driven by `AnimationController` instances that are properly
// disposed in each State's `dispose()` method.
//
// PALETTE
// -------
//   midnight   = #0F172A   — app background / scaffold
//   gold       = #FBBF24   — accent / hero hand / active states
//   goldSoft   = #FCD34D   — secondary accent / tick marks
//   paper      = #FAFAF7   — content panels
//   slate      = #1E293B   — card backgrounds on midnight
//   ink        = #0B1220   — deepest text on paper
//   mist       = #E2E8F0   — subtle paper shadows
//   danger     = #EF4444   — pitfall assertion colour
//   success    = #22C55E   — OK markers on comparison card

import 'dart:math' as math;
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Palette constants — top-level so every widget in the demo sees the same
// values without re-declaring them in each State. Using `Color(0xFF...)`
// keeps the palette literal and avoids `Colors.*` drift between scenes.
// ---------------------------------------------------------------------------
const Color _kMidnight = Color(0xFF0F172A);
const Color _kSlate = Color(0xFF1E293B);
const Color _kGold = Color(0xFFFBBF24);
const Color _kGoldSoft = Color(0xFFFCD34D);
const Color _kPaper = Color(0xFFFAFAF7);
const Color _kMist = Color(0xFFE2E8F0);
const Color _kInk = Color(0xFF0B1220);
const Color _kDanger = Color(0xFFEF4444);
const Color _kSuccess = Color(0xFF22C55E);
const Color _kSubtle = Color(0xFF64748B);

// ---------------------------------------------------------------------------
// Entry point — the d4rt AST harness invokes this exactly once per test
// script. The returned widget tree must be self-contained: no main(), no
// runApp(), no global state, no late fields at top level.
// ---------------------------------------------------------------------------
dynamic build(BuildContext context) {
  debugPrint('[TickWorkshop] build() — SingleTickerProviderStateMixin demo');
  return const _TickWorkshopApp();
}

// ---------------------------------------------------------------------------
// Root MaterialApp wrapper — keeps the demo themable without mutating the
// caller's MaterialApp. A Scaffold with an AppBar and a single scrolling
// body hosts the six scenes stacked vertically.
// ---------------------------------------------------------------------------
class _TickWorkshopApp extends StatelessWidget {
  const _TickWorkshopApp();

  @override
  Widget build(BuildContext context) {
    debugPrint('[TickWorkshop] building MaterialApp scaffold');
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tick Workshop',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: _kMidnight,
        colorScheme: const ColorScheme.dark(
          primary: _kGold,
          secondary: _kGoldSoft,
          surface: _kSlate,
          error: _kDanger,
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: _kPaper, height: 1.4),
          bodySmall: TextStyle(color: _kPaper, height: 1.35),
          titleLarge: TextStyle(
            color: _kGold,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
          titleMedium: TextStyle(
            color: _kPaper,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
          labelLarge: TextStyle(
            color: _kInk,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        cardTheme: CardThemeData(
          color: _kSlate,
          elevation: 0,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: _kGold.withValues(alpha: 0.18)),
          ),
        ),
      ),
      home: const _TickWorkshopHome(),
    );
  }
}

// ---------------------------------------------------------------------------
// Home Scaffold — renders the AppBar and stacks the six scenes in a
// SingleChildScrollView. Each scene is a self-contained widget that owns
// its own State where necessary.
// ---------------------------------------------------------------------------
class _TickWorkshopHome extends StatelessWidget {
  const _TickWorkshopHome();

  @override
  Widget build(BuildContext context) {
    debugPrint('[TickWorkshop] rendering home scaffold');
    return Scaffold(
      backgroundColor: _kMidnight,
      appBar: AppBar(
        backgroundColor: _kMidnight,
        elevation: 0,
        title: Row(
          children: <Widget>[
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: _kGold,
                borderRadius: BorderRadius.circular(10),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: _kGold.withValues(alpha: 0.35),
                    blurRadius: 14,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: const Icon(Icons.timelapse, color: _kMidnight, size: 22),
            ),
            const SizedBox(width: 12),
            const Text(
              'Tick Workshop',
              style: TextStyle(
                color: _kPaper,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.4,
              ),
            ),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: _kGold.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: _kGold.withValues(alpha: 0.35)),
              ),
              child: const Text(
                'SingleTickerProviderStateMixin',
                style: TextStyle(
                  color: _kGold,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
        ),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(18, 10, 18, 36),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _WorkshopSubtitle(),
            SizedBox(height: 18),
            _TickDialHero(),
            SizedBox(height: 22),
            _PulsingBlobCard(),
            SizedBox(height: 22),
            _ControllerPlayground(),
            SizedBox(height: 22),
            _SingleVsMultiCompare(),
            SizedBox(height: 22),
            _PitfallCard(),
            SizedBox(height: 22),
            _LifecycleLog(),
            SizedBox(height: 22),
            _FieldReferencePanel(),
            SizedBox(height: 22),
            _DecisionTreePanel(),
            SizedBox(height: 22),
            _WorkshopFooter(),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Subtitle banner — short orientation line under the AppBar. Using a
// gradient background keeps it distinct from the scene cards without
// adding another elevation layer.
// ---------------------------------------------------------------------------
class _WorkshopSubtitle extends StatelessWidget {
  const _WorkshopSubtitle();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            _kGold.withValues(alpha: 0.10),
            _kGold.withValues(alpha: 0.02),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _kGold.withValues(alpha: 0.25)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Icon(Icons.auto_awesome, color: _kGold),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'One Ticker, one controller, zero ceremony.',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: _kPaper),
                ),
                const SizedBox(height: 4),
                Text(
                  'A hand-crafted tour of SingleTickerProviderStateMixin — '
                  'the mixin that gives your State exactly one vsync and '
                  'asserts you never ask for a second.',
                  style: TextStyle(
                    color: _kPaper.withValues(alpha: 0.72),
                    fontSize: 12.5,
                    height: 1.4,
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
// SCENE 1 — TICK DIAL HERO
// ===========================================================================
// A stateful widget whose State is mixed with `SingleTickerProviderStateMixin`.
// The AnimationController runs forever (`repeat()`), advancing a value from
// 0.0 -> 1.0 every 60 seconds. A CustomPainter draws a dial with tick marks
// and a hand rotated by `controller.value * 2*pi`.
// ---------------------------------------------------------------------------
class _TickDialHero extends StatefulWidget {
  const _TickDialHero();

  @override
  State<_TickDialHero> createState() => _TickDialHeroState();
}

class _TickDialHeroState extends State<_TickDialHero>
    with SingleTickerProviderStateMixin {
  // Single AnimationController permitted by the mixin. If a second were
  // declared and initialised with `vsync: this` the framework would
  // assert in debug mode: "_TickDialHeroState is already being used
  // as a vsync for a Ticker".
  late final AnimationController _hand;

  // A secondary animation object is fine as long as it does NOT request
  // another Ticker. `Animation` instances derived from the same
  // controller share the single Ticker.
  late final Animation<double> _smoothed;

  @override
  void initState() {
    super.initState();
    debugPrint('[TickDialHero] initState — creating AnimationController');
    _hand = AnimationController(
      vsync: this, // <-- the `this` is SingleTickerProviderStateMixin
      duration: const Duration(seconds: 60),
    )..repeat();
    _smoothed = CurvedAnimation(parent: _hand, curve: Curves.linear);
    debugPrint('[TickDialHero] controller + curved animation ready');
  }

  @override
  void dispose() {
    debugPrint('[TickDialHero] dispose — disposing AnimationController '
        '(Ticker is unregistered from the SchedulerBinding)');
    _hand.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _SceneFrame(
      index: 1,
      tag: 'Hero',
      title: 'Analog Tick Dial',
      blurb: 'A single AnimationController drives a CustomPainter that '
          'rotates the gold second-hand once per minute. The Ticker lives '
          'for the lifetime of _TickDialHeroState and is torn down in '
          'dispose().',
      child: AspectRatio(
        aspectRatio: 2.1,
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 5,
              child: Container(
                margin: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: _kMidnight,
                  borderRadius: BorderRadius.circular(200),
                  border: Border.all(color: _kGold.withValues(alpha: 0.35)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: _kGold.withValues(alpha: 0.18),
                      blurRadius: 38,
                      spreadRadius: -6,
                    ),
                  ],
                ),
                child: AnimatedBuilder(
                  animation: _smoothed,
                  builder: (BuildContext context, Widget? _) {
                    return CustomPaint(
                      painter: _TickDialPainter(progress: _smoothed.value),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: AnimatedBuilder(
                animation: _hand,
                builder: (BuildContext context, Widget? _) {
                  final double seconds = _hand.value * 60.0;
                  final int full = seconds.floor();
                  final int millis = ((seconds - full) * 1000).round();
                  return _DialSidebar(
                    seconds: full,
                    millis: millis,
                    raw: _hand.value,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// CustomPainter for the tick dial. Computes tick mark positions, draws
// 60 minor marks, 12 major marks with numerals, and the gold second hand
// rotated by `progress * 2 * pi`.
class _TickDialPainter extends CustomPainter {
  _TickDialPainter({required this.progress});

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = math.min(size.width, size.height) / 2 - 18;

    // Outer ring.
    final Paint ring = Paint()
      ..color = _kGold.withValues(alpha: 0.28)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    canvas.drawCircle(center, radius, ring);

    // Inner ring.
    final Paint innerRing = Paint()
      ..color = _kGoldSoft.withValues(alpha: 0.10)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    canvas.drawCircle(center, radius - 10, innerRing);

    // 60 minor ticks.
    final Paint minorTick = Paint()
      ..color = _kPaper.withValues(alpha: 0.35)
      ..strokeWidth = 1.0;
    for (int i = 0; i < 60; i++) {
      final double angle = (i / 60.0) * 2 * math.pi - math.pi / 2;
      final Offset a = Offset(
        center.dx + math.cos(angle) * (radius - 2),
        center.dy + math.sin(angle) * (radius - 2),
      );
      final Offset b = Offset(
        center.dx + math.cos(angle) * (radius - 8),
        center.dy + math.sin(angle) * (radius - 8),
      );
      canvas.drawLine(a, b, minorTick);
    }

    // 12 major ticks.
    final Paint majorTick = Paint()
      ..color = _kGold
      ..strokeWidth = 2.4;
    for (int i = 0; i < 12; i++) {
      final double angle = (i / 12.0) * 2 * math.pi - math.pi / 2;
      final Offset a = Offset(
        center.dx + math.cos(angle) * (radius - 2),
        center.dy + math.sin(angle) * (radius - 2),
      );
      final Offset b = Offset(
        center.dx + math.cos(angle) * (radius - 16),
        center.dy + math.sin(angle) * (radius - 16),
      );
      canvas.drawLine(a, b, majorTick);
    }

    // Numerals 12 / 3 / 6 / 9.
    final Map<int, String> numerals = <int, String>{
      0: '12',
      3: '3',
      6: '6',
      9: '9',
    };
    for (final MapEntry<int, String> entry in numerals.entries) {
      final double angle = (entry.key / 12.0) * 2 * math.pi - math.pi / 2;
      final Offset pos = Offset(
        center.dx + math.cos(angle) * (radius - 32),
        center.dy + math.sin(angle) * (radius - 32),
      );
      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: entry.value,
          style: const TextStyle(
            color: _kPaper,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, pos - Offset(tp.width / 2, tp.height / 2));
    }

    // Second hand rotated by progress.
    final double handAngle = progress * 2 * math.pi - math.pi / 2;
    final Offset handTip = Offset(
      center.dx + math.cos(handAngle) * (radius - 22),
      center.dy + math.sin(handAngle) * (radius - 22),
    );
    final Offset handTail = Offset(
      center.dx - math.cos(handAngle) * 14,
      center.dy - math.sin(handAngle) * 14,
    );
    final Paint handPaint = Paint()
      ..color = _kGold
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(handTail, handTip, handPaint);

    // Minute hand (drives at 1/60 the rate — we approximate it here with
    // progress / 60 to hint at multi-level timing even though only the
    // single controller is in play).
    final double minuteAngle =
        (progress / 60.0) * 2 * math.pi - math.pi / 2;
    final Offset minuteTip = Offset(
      center.dx + math.cos(minuteAngle) * (radius - 40),
      center.dy + math.sin(minuteAngle) * (radius - 40),
    );
    final Paint minutePaint = Paint()
      ..color = _kGoldSoft.withValues(alpha: 0.8)
      ..strokeWidth = 5.0
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(center, minuteTip, minutePaint);

    // Centre hub.
    final Paint hub = Paint()..color = _kGold;
    canvas.drawCircle(center, 5.5, hub);
    final Paint hubCore = Paint()..color = _kMidnight;
    canvas.drawCircle(center, 2.0, hubCore);
  }

  @override
  bool shouldRepaint(covariant _TickDialPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

// Sidebar next to the dial — shows numeric progress, ticker state, and
// a short lifecycle explainer. Plain StatelessWidget because the
// AnimatedBuilder wrapping it already rebuilds it on every frame.
class _DialSidebar extends StatelessWidget {
  const _DialSidebar({
    required this.seconds,
    required this.millis,
    required this.raw,
  });

  final int seconds;
  final int millis;
  final double raw;

  @override
  Widget build(BuildContext context) {
    final String framePct = (raw * 100).toStringAsFixed(2);
    return Container(
      margin: const EdgeInsets.fromLTRB(4, 14, 14, 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kPaper,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Controller progress',
            style: TextStyle(
              color: _kInk.withValues(alpha: 0.55),
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.4,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: <Widget>[
              Text(
                '$seconds',
                style: const TextStyle(
                  color: _kInk,
                  fontSize: 42,
                  fontWeight: FontWeight.w800,
                  height: 1.0,
                ),
              ),
              Text(
                '.${millis.toString().padLeft(3, '0')}',
                style: TextStyle(
                  color: _kInk.withValues(alpha: 0.55),
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                's',
                style: TextStyle(
                  color: _kInk.withValues(alpha: 0.55),
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'value = $framePct %',
            style: TextStyle(
              color: _kInk.withValues(alpha: 0.7),
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 14),
          Container(
            width: double.infinity,
            height: 4,
            decoration: BoxDecoration(
              color: _kMist,
              borderRadius: BorderRadius.circular(4),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: raw.clamp(0.0, 1.0),
              child: Container(
                decoration: BoxDecoration(
                  color: _kGold,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),
          const _SidebarFact(
            icon: Icons.bolt,
            label: 'Vsync',
            value: 'SingleTickerProviderStateMixin',
          ),
          const SizedBox(height: 6),
          const _SidebarFact(
            icon: Icons.all_inclusive,
            label: 'Status',
            value: 'repeat() — forever',
          ),
          const SizedBox(height: 6),
          const _SidebarFact(
            icon: Icons.delete_forever,
            label: 'On dispose',
            value: 'Ticker unregistered',
          ),
        ],
      ),
    );
  }
}

class _SidebarFact extends StatelessWidget {
  const _SidebarFact({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(icon, size: 14, color: _kInk.withValues(alpha: 0.65)),
        const SizedBox(width: 6),
        Text(
          '$label — ',
          style: TextStyle(
            color: _kInk.withValues(alpha: 0.65),
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              color: _kInk,
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

// ===========================================================================
// SCENE 2 — PULSING BLOB CARD
// ===========================================================================
// A circle whose radius is driven by a CurvedAnimation built on top of a
// SingleTickerProviderStateMixin-hosted controller. Shows that even a
// derived `Animation<double>` (CurvedAnimation, Tween.animate, etc.) does
// NOT require a second Ticker — it reuses the parent controller.
// ---------------------------------------------------------------------------
class _PulsingBlobCard extends StatefulWidget {
  const _PulsingBlobCard();

  @override
  State<_PulsingBlobCard> createState() => _PulsingBlobCardState();
}

class _PulsingBlobCardState extends State<_PulsingBlobCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulse;
  late final Animation<double> _curved;

  static const double _minRadius = 44;
  static const double _maxRadius = 128;

  @override
  void initState() {
    super.initState();
    debugPrint('[PulsingBlob] initState — AnimationController 1600ms, '
        'Curves.easeInOutCubic, reverse=true');
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..repeat(reverse: true);
    _curved = CurvedAnimation(parent: _pulse, curve: Curves.easeInOutCubic);
  }

  @override
  void dispose() {
    debugPrint('[PulsingBlob] dispose — AnimationController tear-down');
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _SceneFrame(
      index: 2,
      tag: 'Curve',
      title: 'Pulsing Blob',
      blurb: 'One AnimationController, one Ticker, one derived '
          'CurvedAnimation. The curve reshapes the 0-1 value without '
          'asking for a second vsync.',
      child: SizedBox(
        height: 280,
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: AnimatedBuilder(
                animation: _curved,
                builder: (BuildContext context, Widget? _) {
                  final double r =
                      _minRadius + (_maxRadius - _minRadius) * _curved.value;
                  return Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        _BlobHalo(radius: r + 34, opacity: 0.10),
                        _BlobHalo(radius: r + 18, opacity: 0.18),
                        Container(
                          width: r * 2,
                          height: r * 2,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: <Color>[
                                _kGoldSoft,
                                _kGold.withValues(alpha: 0.75),
                              ],
                            ),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: _kGold.withValues(alpha: 0.45),
                                blurRadius: 24,
                                spreadRadius: -2,
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '${r.toStringAsFixed(1)} px',
                          style: const TextStyle(
                            color: _kMidnight,
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Expanded(
              flex: 2,
              child: AnimatedBuilder(
                animation: _curved,
                builder: (BuildContext context, Widget? _) {
                  return _BlobStats(
                    raw: _pulse.value,
                    curved: _curved.value,
                    minR: _minRadius,
                    maxR: _maxRadius,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BlobHalo extends StatelessWidget {
  const _BlobHalo({required this.radius, required this.opacity});

  final double radius;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _kGold.withValues(alpha: opacity),
      ),
    );
  }
}

class _BlobStats extends StatelessWidget {
  const _BlobStats({
    required this.raw,
    required this.curved,
    required this.minR,
    required this.maxR,
  });

  final double raw;
  final double curved;
  final double minR;
  final double maxR;

  @override
  Widget build(BuildContext context) {
    final double r = minR + (maxR - minR) * curved;
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 14, 14, 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kPaper,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Radius sidebar',
            style: TextStyle(
              color: _kInk,
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.4,
            ),
          ),
          const SizedBox(height: 10),
          _StatRow(label: 'raw value', value: raw.toStringAsFixed(3)),
          _StatRow(label: 'curved', value: curved.toStringAsFixed(3)),
          _StatRow(label: 'radius', value: '${r.toStringAsFixed(1)} px'),
          const Divider(color: _kMist, height: 22),
          _StatRow(label: 'min', value: '${minR.toStringAsFixed(0)} px'),
          _StatRow(label: 'max', value: '${maxR.toStringAsFixed(0)} px'),
          _StatRow(label: 'delta', value: '${(maxR - minR).toStringAsFixed(0)} px'),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: _kGold.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'Curve: easeInOutCubic',
              style: TextStyle(
                color: _kInk,
                fontSize: 11.5,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatRow extends StatelessWidget {
  const _StatRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 70,
            child: Text(
              label,
              style: TextStyle(
                color: _kInk.withValues(alpha: 0.6),
                fontSize: 11.5,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: _kInk,
                fontSize: 12,
                fontWeight: FontWeight.w700,
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
// SCENE 3 — CONTROLLER PLAYGROUND
// ===========================================================================
// Interactive controls: play / pause / reverse / restart, plus a slider
// that changes `AnimationController.duration` while the Ticker keeps
// firing. Demonstrates that the Ticker is persistent — changing the
// duration does NOT recreate the Ticker.
// ---------------------------------------------------------------------------
class _ControllerPlayground extends StatefulWidget {
  const _ControllerPlayground();

  @override
  State<_ControllerPlayground> createState() => _ControllerPlaygroundState();
}

class _ControllerPlaygroundState extends State<_ControllerPlayground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  double _speed = 1.0; // 0.25x ... 3.0x, maps to duration.

  static const double _baseMs = 2400;

  @override
  void initState() {
    super.initState();
    debugPrint('[Playground] initState — controller duration ${_baseMs}ms');
    _ctrl = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: _baseMs.toInt()),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    debugPrint('[Playground] dispose — controller release');
    _ctrl.dispose();
    super.dispose();
  }

  void _setSpeed(double v) {
    setState(() {
      _speed = v;
      _ctrl.duration = Duration(milliseconds: (_baseMs / v).round());
    });
    debugPrint('[Playground] speed=${v.toStringAsFixed(2)}x '
        'duration=${_ctrl.duration?.inMilliseconds}ms');
  }

  void _play() {
    debugPrint('[Playground] play');
    _ctrl.repeat(reverse: true);
  }

  void _pause() {
    debugPrint('[Playground] pause (Ticker stays alive, not firing)');
    _ctrl.stop();
  }

  void _reverse() {
    debugPrint('[Playground] reverse');
    _ctrl.reverse(from: _ctrl.value);
  }

  void _restart() {
    debugPrint('[Playground] restart from 0');
    _ctrl
      ..reset()
      ..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return _SceneFrame(
      index: 3,
      tag: 'Playground',
      title: 'Controller Playground',
      blurb: 'Mutate AnimationController while its Ticker keeps running. '
          'Changing duration does NOT allocate a new Ticker — the same '
          'vsync is reused until dispose().',
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 4, 14, 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: 110,
              decoration: BoxDecoration(
                color: _kPaper,
                borderRadius: BorderRadius.circular(14),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: AnimatedBuilder(
                animation: _ctrl,
                builder: (BuildContext context, Widget? _) {
                  return CustomPaint(
                    painter: _PlaygroundTrackPainter(value: _ctrl.value),
                    child: const SizedBox.expand(),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: <Widget>[
                Expanded(
                  child: _PlaygroundButton(
                    label: 'Play',
                    icon: Icons.play_arrow,
                    color: _kSuccess,
                    onTap: _play,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _PlaygroundButton(
                    label: 'Pause',
                    icon: Icons.pause,
                    color: _kGoldSoft,
                    onTap: _pause,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _PlaygroundButton(
                    label: 'Reverse',
                    icon: Icons.fast_rewind,
                    color: _kGold,
                    onTap: _reverse,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _PlaygroundButton(
                    label: 'Restart',
                    icon: Icons.refresh,
                    color: _kPaper,
                    onTap: _restart,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 14),
              decoration: BoxDecoration(
                color: _kMidnight,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: _kGold.withValues(alpha: 0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      const Icon(Icons.speed, color: _kGold, size: 18),
                      const SizedBox(width: 8),
                      Text(
                        'Speed: ${_speed.toStringAsFixed(2)}x',
                        style: const TextStyle(
                          color: _kGold,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'duration = ${_ctrl.duration?.inMilliseconds}ms',
                        style: TextStyle(
                          color: _kPaper.withValues(alpha: 0.7),
                          fontSize: 11.5,
                        ),
                      ),
                    ],
                  ),
                  SliderTheme(
                    data: SliderThemeData(
                      activeTrackColor: _kGold,
                      inactiveTrackColor: _kGold.withValues(alpha: 0.25),
                      thumbColor: _kGold,
                      overlayColor: _kGold.withValues(alpha: 0.15),
                      valueIndicatorColor: _kGold,
                    ),
                    child: Slider(
                      min: 0.25,
                      max: 3.0,
                      divisions: 11,
                      value: _speed,
                      onChanged: _setSpeed,
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

class _PlaygroundTrackPainter extends CustomPainter {
  _PlaygroundTrackPainter({required this.value});

  final double value;

  @override
  void paint(Canvas canvas, Size size) {
    final double y = size.height / 2;
    final Paint track = Paint()
      ..color = _kMist
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(0, y), Offset(size.width, y), track);
    final double x = size.width * value;
    final Paint filled = Paint()
      ..color = _kGold
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(0, y), Offset(x, y), filled);
    final Paint head = Paint()..color = _kGold;
    canvas.drawCircle(Offset(x, y), 10, head);
    final Paint headCore = Paint()..color = _kInk;
    canvas.drawCircle(Offset(x, y), 4, headCore);

    // Tick markers every 10%.
    final Paint tick = Paint()
      ..color = _kInk.withValues(alpha: 0.25)
      ..strokeWidth = 1.0;
    for (int i = 0; i <= 10; i++) {
      final double tx = size.width * (i / 10.0);
      canvas.drawLine(Offset(tx, y - 8), Offset(tx, y + 8), tick);
    }
  }

  @override
  bool shouldRepaint(covariant _PlaygroundTrackPainter old) =>
      old.value != value;
}

class _PlaygroundButton extends StatelessWidget {
  const _PlaygroundButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final bool onDark = color.computeLuminance() > 0.55;
    final Color fg = onDark ? _kInk : _kPaper;
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(icon, color: fg, size: 16),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  color: fg,
                  fontWeight: FontWeight.w700,
                  fontSize: 12.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ===========================================================================
// SCENE 4 — SINGLE VS MULTI COMPARISON
// ===========================================================================
// Two cards running the same visual animation. Left: _SingleSideMixer uses
// SingleTickerProviderStateMixin. Right: _MultiSideMixer uses
// TickerProviderStateMixin but still runs a single controller — the point
// is NOT to prove correctness but to expose the extra machinery pulled in
// by the multi variant (Set of tickers, per-vsync map storage).
// ---------------------------------------------------------------------------
class _SingleVsMultiCompare extends StatelessWidget {
  const _SingleVsMultiCompare();

  @override
  Widget build(BuildContext context) {
    return _SceneFrame(
      index: 4,
      tag: 'Compare',
      title: 'Why SingleTicker vs TickerProvider',
      blurb: 'The two panes below host identical visuals; only the mixin '
          'differs. SingleTickerProviderStateMixin stores a lone `Ticker?` '
          'field; TickerProviderStateMixin manages a `Set<Ticker>`. Same '
          'animation, slightly lighter bookkeeping.',
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
        child: Column(
          children: <Widget>[
            const Row(
              children: <Widget>[
                Expanded(child: _SingleSideMixer()),
                SizedBox(width: 12),
                Expanded(child: _MultiSideMixer()),
              ],
            ),
            const SizedBox(height: 14),
            _CompareMatrix(),
          ],
        ),
      ),
    );
  }
}

class _SingleSideMixer extends StatefulWidget {
  const _SingleSideMixer();

  @override
  State<_SingleSideMixer> createState() => _SingleSideMixerState();
}

class _SingleSideMixerState extends State<_SingleSideMixer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c;

  @override
  void initState() {
    super.initState();
    debugPrint('[SingleSide] initState — single Ticker');
    _c = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    debugPrint('[SingleSide] dispose');
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _ComparePanel(
      heading: 'SingleTickerProviderStateMixin',
      headingColor: _kGold,
      bullets: const <String>[
        'Stores a single Ticker? field',
        'Asserts only one AnimationController is attached',
        'Cheapest vsync in the framework',
        'Use when your State owns exactly one controller',
      ],
      animation: _c,
    );
  }
}

class _MultiSideMixer extends StatefulWidget {
  const _MultiSideMixer();

  @override
  State<_MultiSideMixer> createState() => _MultiSideMixerState();
}

class _MultiSideMixerState extends State<_MultiSideMixer>
    with TickerProviderStateMixin {
  late final AnimationController _c;

  @override
  void initState() {
    super.initState();
    debugPrint('[MultiSide] initState — full TickerProviderStateMixin');
    _c = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    debugPrint('[MultiSide] dispose');
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _ComparePanel(
      heading: 'TickerProviderStateMixin',
      headingColor: _kGoldSoft,
      bullets: const <String>[
        'Stores a Set<Ticker>',
        'Accepts multiple AnimationControllers',
        'Slightly more bookkeeping per frame',
        'Use when two or more animations run concurrently',
      ],
      animation: _c,
    );
  }
}

class _ComparePanel extends StatelessWidget {
  const _ComparePanel({
    required this.heading,
    required this.headingColor,
    required this.bullets,
    required this.animation,
  });

  final String heading;
  final Color headingColor;
  final List<String> bullets;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kMidnight,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: headingColor.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            heading,
            style: TextStyle(
              color: headingColor,
              fontWeight: FontWeight.w800,
              fontSize: 13,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 12),
          AnimatedBuilder(
            animation: animation,
            builder: (BuildContext context, Widget? _) {
              return Container(
                height: 64,
                decoration: BoxDecoration(
                  color: _kSlate,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: headingColor.withValues(alpha: 0.35),
                  ),
                ),
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(8),
                child: FractionallySizedBox(
                  widthFactor: animation.value.clamp(0.02, 1.0),
                  heightFactor: 1.0,
                  alignment: Alignment.centerLeft,
                  child: Container(
                    decoration: BoxDecoration(
                      color: headingColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 10),
          for (final String b in bullets)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(top: 6, right: 8),
                    width: 5,
                    height: 5,
                    decoration: BoxDecoration(
                      color: headingColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      b,
                      style: TextStyle(
                        color: _kPaper.withValues(alpha: 0.85),
                        fontSize: 11.5,
                        height: 1.35,
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

class _CompareMatrix extends StatelessWidget {
  _CompareMatrix();

  final List<_MatrixRow> _rows = <_MatrixRow>[
    _MatrixRow('Storage', 'Ticker? _ticker', 'Set<Ticker> _tickers'),
    _MatrixRow('Max tickers', '1 (asserts)', 'n (unbounded)'),
    _MatrixRow('Memory / State', '~16 bytes', '~48 bytes + entries'),
    _MatrixRow('Dispose cost', 'single unregister', 'iterate + unregister'),
    _MatrixRow('didChangeDependencies', 'applies muting', 'applies muting'),
    _MatrixRow('Intended use', 'one controller', 'two or more'),
    _MatrixRow('Asserts on second', 'YES (debug)', 'NO'),
    _MatrixRow('Framework cost', 'lowest', 'very low'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _kPaper,
        borderRadius: BorderRadius.circular(14),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Feature matrix',
            style: TextStyle(
              color: _kInk,
              fontWeight: FontWeight.w800,
              fontSize: 12,
              letterSpacing: 1.3,
            ),
          ),
          const SizedBox(height: 10),
          Table(
            columnWidths: const <int, TableColumnWidth>{
              0: FlexColumnWidth(1.1),
              1: FlexColumnWidth(1.2),
              2: FlexColumnWidth(1.2),
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: <TableRow>[
              TableRow(
                decoration: BoxDecoration(
                  color: _kMist.withValues(alpha: 0.6),
                ),
                children: const <Widget>[
                  _MatrixHeader(label: 'Aspect'),
                  _MatrixHeader(label: 'Single'),
                  _MatrixHeader(label: 'Multi'),
                ],
              ),
              for (final _MatrixRow r in _rows)
                TableRow(
                  children: <Widget>[
                    _MatrixCell(text: r.aspect, accent: false),
                    _MatrixCell(text: r.single, accent: true),
                    _MatrixCell(text: r.multi, accent: false),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MatrixRow {
  _MatrixRow(this.aspect, this.single, this.multi);

  final String aspect;
  final String single;
  final String multi;
}

class _MatrixHeader extends StatelessWidget {
  const _MatrixHeader({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Text(
        label,
        style: const TextStyle(
          color: _kInk,
          fontWeight: FontWeight.w800,
          fontSize: 11.5,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}

class _MatrixCell extends StatelessWidget {
  const _MatrixCell({required this.text, required this.accent});

  final String text;
  final bool accent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Text(
        text,
        style: TextStyle(
          color: accent ? _kInk : _kInk.withValues(alpha: 0.75),
          fontWeight: accent ? FontWeight.w700 : FontWeight.w500,
          fontSize: 11.5,
        ),
      ),
    );
  }
}

// ===========================================================================
// SCENE 5 — PITFALL CARD
// ===========================================================================
// Expected assertion message when a second AnimationController asks a
// SingleTickerProvider for another Ticker. We DO NOT actually create the
// second controller — we render the assertion text as data so the demo
// stays green in the AST harness.
// ---------------------------------------------------------------------------
class _PitfallCard extends StatelessWidget {
  const _PitfallCard();

  @override
  Widget build(BuildContext context) {
    const String assertionMessage =
        "_PitfallExampleState is already being used as a TickerProvider. "
        "SingleTickerProviderStateMixin can only be used as a "
        "TickerProvider once. If a State is used for multiple "
        "AnimationController objects, or if it is passed to other "
        "objects and those objects might use it more than one time in "
        "total, then instead of mixing in a SingleTickerProviderStateMixin, "
        "use a regular TickerProviderStateMixin.";

    return _SceneFrame(
      index: 5,
      tag: 'Pitfall',
      title: 'What if I need two controllers?',
      blurb: 'SingleTickerProviderStateMixin asserts on the SECOND Ticker '
          'request. This card shows the exact assertion text — it is '
          'rendered statically, never triggered at runtime, so the AST '
          'harness stays green.',
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: _kDanger.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _kDanger.withValues(alpha: 0.55)),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(Icons.report_gmailerrorred, color: _kDanger),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'FlutterError — assertion failed',
                          style: TextStyle(
                            color: _kDanger,
                            fontSize: 12.5,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.4,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          assertionMessage,
                          style: TextStyle(
                            color: _kPaper,
                            fontSize: 12.5,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: _kInk,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const _PitfallCodeSnippet(),
            ),
            const SizedBox(height: 14),
            const _PitfallFixRow(),
          ],
        ),
      ),
    );
  }
}

class _PitfallCodeSnippet extends StatelessWidget {
  const _PitfallCodeSnippet();

  @override
  Widget build(BuildContext context) {
    final TextStyle base = TextStyle(
      color: _kPaper.withValues(alpha: 0.92),
      fontSize: 12.5,
      height: 1.45,
      fontFeatures: const <FontFeature>[FontFeature.tabularFigures()],
    );
    final TextStyle kw =
        base.copyWith(color: _kGold, fontWeight: FontWeight.w700);
    final TextStyle cls =
        base.copyWith(color: _kGoldSoft, fontWeight: FontWeight.w600);
    final TextStyle mut = base.copyWith(color: _kDanger);
    final TextStyle cmt =
        base.copyWith(color: _kSubtle, fontStyle: FontStyle.italic);

    return SelectionArea(
      child: RichText(
        text: TextSpan(
          style: base,
          children: <InlineSpan>[
            TextSpan(text: 'class ', style: kw),
            TextSpan(text: '_PitfallExampleState ', style: cls),
            const TextSpan(text: 'extends '),
            TextSpan(text: 'State', style: cls),
            const TextSpan(text: '<_Pitfall> '),
            TextSpan(text: 'with ', style: kw),
            TextSpan(text: 'SingleTickerProviderStateMixin', style: cls),
            const TextSpan(text: ' {\n'),
            const TextSpan(text: '  late '),
            TextSpan(text: 'AnimationController', style: cls),
            const TextSpan(text: ' _a;\n'),
            const TextSpan(text: '  late '),
            TextSpan(text: 'AnimationController', style: cls),
            TextSpan(text: ' _b; ', style: base),
            TextSpan(text: '// offender\n', style: cmt),
            const TextSpan(text: '\n  @override\n  '),
            TextSpan(text: 'void ', style: kw),
            const TextSpan(text: 'initState() {\n'),
            const TextSpan(text: '    '),
            TextSpan(text: 'super', style: kw),
            const TextSpan(text: '.initState();\n'),
            const TextSpan(text: '    _a = '),
            TextSpan(text: 'AnimationController', style: cls),
            const TextSpan(text: '(vsync: '),
            TextSpan(text: 'this', style: kw),
            const TextSpan(text: ', duration: '),
            TextSpan(text: 'Duration', style: cls),
            const TextSpan(text: '(seconds: 1));\n'),
            const TextSpan(text: '    _b = '),
            TextSpan(text: 'AnimationController', style: cls),
            const TextSpan(text: '(vsync: '),
            TextSpan(text: 'this', style: kw),
            const TextSpan(text: ', duration: '),
            TextSpan(text: 'Duration', style: cls),
            TextSpan(text: '(seconds: 2)); ', style: base),
            TextSpan(text: '// THROWS\n', style: mut),
            const TextSpan(text: '  }\n'),
            const TextSpan(text: '}\n'),
          ],
        ),
      ),
    );
  }
}

class _PitfallFixRow extends StatelessWidget {
  const _PitfallFixRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: _kDanger.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _kDanger.withValues(alpha: 0.35)),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(Icons.close, color: _kDanger, size: 18),
                    SizedBox(width: 6),
                    Text(
                      'Wrong',
                      style: TextStyle(
                        color: _kDanger,
                        fontWeight: FontWeight.w800,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Text(
                  '...with SingleTickerProviderStateMixin {\n'
                  '  AnimationController _a;\n'
                  '  AnimationController _b; // BOOM\n'
                  '}',
                  style: TextStyle(
                    color: _kPaper,
                    fontSize: 11.5,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: _kSuccess.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _kSuccess.withValues(alpha: 0.35)),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(Icons.check, color: _kSuccess, size: 18),
                    SizedBox(width: 6),
                    Text(
                      'Right',
                      style: TextStyle(
                        color: _kSuccess,
                        fontWeight: FontWeight.w800,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Text(
                  '...with TickerProviderStateMixin {\n'
                  '  AnimationController _a;\n'
                  '  AnimationController _b; // ok\n'
                  '}',
                  style: TextStyle(
                    color: _kPaper,
                    fontSize: 11.5,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ===========================================================================
// SCENE 6 — LIFECYCLE LOG
// ===========================================================================
// Maintains a synthetic but plausible log of lifecycle events: createTicker
// timestamp, tick count per second (approximate, computed from controller
// value derivative), and a scheduled dispose marker. A tiny AnimationController
// drives the counter; we do NOT hook into Ticker.tickCount directly because
// the public API does not expose it.
// ---------------------------------------------------------------------------
class _LifecycleLog extends StatefulWidget {
  const _LifecycleLog();

  @override
  State<_LifecycleLog> createState() => _LifecycleLogState();
}

class _LifecycleLogState extends State<_LifecycleLog>
    with SingleTickerProviderStateMixin {
  late final AnimationController _heartbeat;
  late final DateTime _createdAt;
  int _ticks = 0;
  double _lastValue = 0.0;

  @override
  void initState() {
    super.initState();
    _createdAt = DateTime.now();
    debugPrint('[LifecycleLog] initState @ $_createdAt — createTicker()');
    _heartbeat = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
    _heartbeat.addListener(_onTick);
  }

  void _onTick() {
    // Cheap proxy for frame counting: every time the value wraps, bump
    // the counter by duration-in-ms. This is synthetic but stable.
    final double v = _heartbeat.value;
    if (v < _lastValue) {
      // Wrapped. Assume ~60 ticks per second.
      setState(() => _ticks += 60);
    }
    _lastValue = v;
  }

  @override
  void dispose() {
    debugPrint('[LifecycleLog] dispose — removing listener, disposing '
        'controller, unregistering Ticker (total approx ticks: $_ticks)');
    _heartbeat.removeListener(_onTick);
    _heartbeat.dispose();
    super.dispose();
  }

  String _fmtTime(DateTime t) {
    final String hh = t.hour.toString().padLeft(2, '0');
    final String mm = t.minute.toString().padLeft(2, '0');
    final String ss = t.second.toString().padLeft(2, '0');
    final String ms = t.millisecond.toString().padLeft(3, '0');
    return '$hh:$mm:$ss.$ms';
  }

  @override
  Widget build(BuildContext context) {
    final Duration age = DateTime.now().difference(_createdAt);
    return _SceneFrame(
      index: 6,
      tag: 'Log',
      title: 'Lifecycle Log',
      blurb: 'A synthetic but realistic trace of what happens when a '
          'SingleTickerProviderStateMixin is born, runs, and dies. Raw '
          'Ticker.tickCount is not public — we approximate it.',
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _kInk,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: _kGold.withValues(alpha: 0.25)),
          ),
          child: AnimatedBuilder(
            animation: _heartbeat,
            builder: (BuildContext context, Widget? _) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _LogRow(
                    time: _fmtTime(_createdAt),
                    tag: 'initState',
                    message: 'createTicker() — mixin installs single '
                        'Ticker for vsync',
                    color: _kGold,
                  ),
                  _LogRow(
                    time: _fmtTime(
                      _createdAt.add(const Duration(milliseconds: 1)),
                    ),
                    tag: 'new',
                    message: 'AnimationController(duration=1s) bound '
                        'to vsync: this',
                    color: _kGoldSoft,
                  ),
                  _LogRow(
                    time: _fmtTime(
                      _createdAt.add(const Duration(milliseconds: 3)),
                    ),
                    tag: 'repeat',
                    message: 'Controller.repeat() — Ticker starts '
                        'firing 60 Hz frame callbacks',
                    color: _kPaper,
                  ),
                  _LogRow(
                    time: _fmtTime(DateTime.now()),
                    tag: 'tick',
                    message: 'value=${_heartbeat.value.toStringAsFixed(3)}  '
                        'approx ticks total: $_ticks',
                    color: _kSuccess,
                  ),
                  _LogRow(
                    time: '— in dispose —',
                    tag: 'dispose',
                    message: 'Controller.dispose() → Ticker.dispose() '
                        '→ unregistered from SchedulerBinding',
                    color: _kDanger,
                  ),
                  const SizedBox(height: 10),
                  _LogFooter(
                    age: age,
                    ticks: _ticks,
                    fps: 60,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _LogRow extends StatelessWidget {
  const _LogRow({
    required this.time,
    required this.tag,
    required this.message,
    required this.color,
  });

  final String time;
  final String tag;
  final String message;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 118,
            child: Text(
              time,
              style: TextStyle(
                color: _kPaper.withValues(alpha: 0.55),
                fontSize: 11.5,
                fontFeatures: const <FontFeature>[
                  FontFeature.tabularFigures()
                ],
              ),
            ),
          ),
          Container(
            width: 70,
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: color.withValues(alpha: 0.55)),
            ),
            alignment: Alignment.center,
            child: Text(
              tag,
              style: TextStyle(
                color: color,
                fontSize: 10.5,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.4,
              ),
            ),
          ),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: _kPaper.withValues(alpha: 0.9),
                fontSize: 12,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LogFooter extends StatelessWidget {
  const _LogFooter({
    required this.age,
    required this.ticks,
    required this.fps,
  });

  final Duration age;
  final int ticks;
  final int fps;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: _kSlate,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kGold.withValues(alpha: 0.25)),
      ),
      child: Row(
        children: <Widget>[
          _LogFooterChip(
            icon: Icons.schedule,
            label: 'age',
            value: '${age.inSeconds}s',
          ),
          const SizedBox(width: 14),
          _LogFooterChip(
            icon: Icons.stacked_line_chart,
            label: 'approx ticks',
            value: '$ticks',
          ),
          const SizedBox(width: 14),
          _LogFooterChip(
            icon: Icons.speed,
            label: 'vsync rate',
            value: '~$fps Hz',
          ),
          const Spacer(),
          Icon(Icons.bolt, color: _kGold.withValues(alpha: 0.7), size: 16),
          const SizedBox(width: 4),
          const Text(
            'Ticker live',
            style: TextStyle(
              color: _kGold,
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _LogFooterChip extends StatelessWidget {
  const _LogFooterChip({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(icon, size: 13, color: _kPaper.withValues(alpha: 0.6)),
        const SizedBox(width: 4),
        Text(
          '$label ',
          style: TextStyle(
            color: _kPaper.withValues(alpha: 0.6),
            fontSize: 11,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: _kPaper,
            fontSize: 11,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

// ===========================================================================
// FIELD REFERENCE PANEL
// ===========================================================================
// Inline reference for the most relevant framework entries. Rendered from
// a static list so the layout stays trivially deterministic.
// ---------------------------------------------------------------------------
class _FieldReferencePanel extends StatelessWidget {
  const _FieldReferencePanel();

  static const List<_RefEntry> _entries = <_RefEntry>[
    _RefEntry(
      symbol: 'TickerProvider',
      description: 'Interface declaring createTicker(TickerCallback). '
          'Both Single- and multi-ticker mixins implement this interface.',
    ),
    _RefEntry(
      symbol: 'Ticker',
      description: 'Registers a per-frame callback with the '
          'SchedulerBinding. Exposes start(), stop(), muted, isActive, '
          'and dispose().',
    ),
    _RefEntry(
      symbol: 'AnimationController',
      description: 'Consumer of a TickerProvider. Wraps a Ticker that '
          'advances a Duration-based value between lower and upper bounds.',
    ),
    _RefEntry(
      symbol: 'createTicker(onTick)',
      description: 'Called once per controller. Returns a Ticker that '
          'fires onTick with a cumulative elapsed Duration each frame.',
    ),
    _RefEntry(
      symbol: 'SingleTicker.dispose',
      description: 'State.dispose() asserts the Ticker has been disposed. '
          'Always call controller.dispose() before super.dispose().',
    ),
    _RefEntry(
      symbol: 'TickerMode',
      description: 'Inherited widget. When false, all descendant Tickers '
          'are muted (stop firing frame callbacks, preserve state).',
    ),
    _RefEntry(
      symbol: 'Scheduler muting',
      description: 'When the widget tree is hidden (offscreen, app in '
          'background) the mixin applies muting automatically.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return _SceneFrame(
      index: 7,
      tag: 'Reference',
      title: 'Field reference',
      blurb: 'The handful of types you need to understand to use '
          'SingleTickerProviderStateMixin with confidence.',
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
        child: Container(
          decoration: BoxDecoration(
            color: _kPaper,
            borderRadius: BorderRadius.circular(14),
          ),
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              for (int i = 0; i < _entries.length; i++)
                Padding(
                  padding: EdgeInsets.only(
                    bottom: i == _entries.length - 1 ? 0 : 4,
                  ),
                  child: _RefEntryRow(entry: _entries[i]),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RefEntry {
  const _RefEntry({required this.symbol, required this.description});

  final String symbol;
  final String description;
}

class _RefEntryRow extends StatelessWidget {
  const _RefEntryRow({required this.entry});

  final _RefEntry entry;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _kMist.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kMist),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: _kMidnight,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              entry.symbol,
              style: const TextStyle(
                color: _kGold,
                fontFamily: 'monospace',
                fontSize: 11.5,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              entry.description,
              style: const TextStyle(
                color: _kInk,
                fontSize: 12,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// DECISION TREE PANEL
// ===========================================================================
// Static decision tree: when Single vs Multi vs rebuild. Pure layout, no
// state, so it is safe to render inside the const scroll view.
// ---------------------------------------------------------------------------
class _DecisionTreePanel extends StatelessWidget {
  const _DecisionTreePanel();

  @override
  Widget build(BuildContext context) {
    return _SceneFrame(
      index: 8,
      tag: 'Decide',
      title: 'Decision tree',
      blurb: 'Walk this tree top-to-bottom to pick the right vsync.',
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const <Widget>[
            _DecisionNode(
              question: 'How many AnimationControllers?',
              answers: <_DecisionAnswer>[
                _DecisionAnswer(
                  label: 'Zero',
                  detail: 'Use ImplicitlyAnimatedWidget or a Tween animate '
                      'pattern — no mixin needed.',
                  accent: _kSubtle,
                ),
                _DecisionAnswer(
                  label: 'Exactly one',
                  detail: 'SingleTickerProviderStateMixin — the cheapest '
                      'option, asserts mistakes.',
                  accent: _kGold,
                ),
                _DecisionAnswer(
                  label: 'Two or more',
                  detail: 'TickerProviderStateMixin — manages many tickers.',
                  accent: _kGoldSoft,
                ),
              ],
            ),
            SizedBox(height: 12),
            _DecisionNode(
              question: 'Controller lifetime?',
              answers: <_DecisionAnswer>[
                _DecisionAnswer(
                  label: 'Lives with the State',
                  detail: 'Create in initState(), dispose in dispose(). '
                      'This is the default Single pattern.',
                  accent: _kGold,
                ),
                _DecisionAnswer(
                  label: 'Shared across many widgets',
                  detail: 'Promote the controller to an InheritedWidget or '
                      'a Provider and give the owning State the mixin.',
                  accent: _kGoldSoft,
                ),
              ],
            ),
            SizedBox(height: 12),
            _DecisionNode(
              question: 'Running offscreen?',
              answers: <_DecisionAnswer>[
                _DecisionAnswer(
                  label: 'Yes — must keep ticking',
                  detail: 'Use TickerMode(enabled: true) explicitly to '
                      'override auto-muting.',
                  accent: _kSuccess,
                ),
                _DecisionAnswer(
                  label: 'No — ok to pause',
                  detail: 'Default behaviour: muted when offscreen, '
                      'resumes on visibility.',
                  accent: _kSubtle,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DecisionNode extends StatelessWidget {
  const _DecisionNode({required this.question, required this.answers});

  final String question;
  final List<_DecisionAnswer> answers;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kMidnight,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kGold.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.account_tree, color: _kGold, size: 18),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  question,
                  style: const TextStyle(
                    color: _kPaper,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          for (final _DecisionAnswer a in answers)
            Container(
              margin: const EdgeInsets.symmetric(vertical: 4),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: a.accent.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: a.accent.withValues(alpha: 0.40)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: a.accent.withValues(alpha: 0.25),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      a.label,
                      style: TextStyle(
                        color: a.accent,
                        fontSize: 11.5,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      a.detail,
                      style: TextStyle(
                        color: _kPaper.withValues(alpha: 0.85),
                        fontSize: 12,
                        height: 1.4,
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

class _DecisionAnswer {
  const _DecisionAnswer({
    required this.label,
    required this.detail,
    required this.accent,
  });

  final String label;
  final String detail;
  final Color accent;
}

// ===========================================================================
// SCENE FRAME + FOOTER
// ===========================================================================
// Reusable chrome for each scene. Title row with a badge number and tag,
// a short blurb, and a child content area.
// ---------------------------------------------------------------------------
class _SceneFrame extends StatelessWidget {
  const _SceneFrame({
    required this.index,
    required this.tag,
    required this.title,
    required this.blurb,
    required this.child,
  });

  final int index;
  final String tag;
  final String title;
  final String blurb;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _kSlate,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _kGold.withValues(alpha: 0.18)),
      ),
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: _kGold,
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Text(
                  '$index',
                  style: const TextStyle(
                    color: _kMidnight,
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            title,
                            style: const TextStyle(
                              color: _kPaper,
                              fontSize: 17,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.2,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 7,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: _kGold.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(999),
                            border: Border.all(
                              color: _kGold.withValues(alpha: 0.35),
                            ),
                          ),
                          child: Text(
                            tag,
                            style: const TextStyle(
                              color: _kGold,
                              fontSize: 10.5,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      blurb,
                      style: TextStyle(
                        color: _kPaper.withValues(alpha: 0.72),
                        fontSize: 12,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          child,
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class _WorkshopFooter extends StatelessWidget {
  const _WorkshopFooter();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            _kGold.withValues(alpha: 0.08),
            _kGoldSoft.withValues(alpha: 0.02),
          ],
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kGold.withValues(alpha: 0.22)),
      ),
      child: Row(
        children: <Widget>[
          const Icon(Icons.flag_circle, color: _kGold),
          const SizedBox(width: 10),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  color: _kPaper.withValues(alpha: 0.85),
                  fontSize: 12,
                  height: 1.4,
                ),
                children: const <InlineSpan>[
                  TextSpan(
                    text: 'Rule of thumb — ',
                    style: TextStyle(
                      color: _kGold,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  TextSpan(
                    text: 'reach for SingleTickerProviderStateMixin '
                        'whenever the State owns exactly one '
                        'AnimationController. Upgrade to '
                        'TickerProviderStateMixin the moment a second '
                        'controller enters the picture — the compiler '
                        'will not stop you, but the framework assertion '
                        'will.',
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
