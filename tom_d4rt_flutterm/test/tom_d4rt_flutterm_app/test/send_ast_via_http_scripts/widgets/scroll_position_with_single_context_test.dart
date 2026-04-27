import 'dart:math' as math;

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Palette constants — used throughout the demo for a coherent editorial look.
// ---------------------------------------------------------------------------
const Color _cobalt = Color(0xFF1E3A8A);
const Color _amber = Color(0xFFF59E0B);
const Color _cream = Color(0xFFFEF9E9);
const Color _charcoal = Color(0xFF111827);
const Color _paper = Color(0xFFFDFBF3);
const Color _softCobalt = Color(0xFF3B56B5);
const Color _mutedAmber = Color(0xFFE8B457);
const Color _leaf = Color(0xFF4E7C4A);
const Color _rose = Color(0xFFB84A5A);
const Color _slate = Color(0xFF475569);
const Color _line = Color(0xFFE2D8B9);

// ---------------------------------------------------------------------------
// Entry point for the d4rt AST harness. Returns a MaterialApp — no runApp().
// ---------------------------------------------------------------------------
dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'ScrollPositionWithSingleContext deep-dive',
    theme: ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: _paper,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _cobalt,
        primary: _cobalt,
        secondary: _amber,
        surface: _cream,
      ),
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          color: _charcoal,
          fontSize: 26,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.5,
        ),
        titleLarge: TextStyle(
          color: _charcoal,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
        titleMedium: TextStyle(
          color: _charcoal,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
        bodyMedium: TextStyle(color: _charcoal, fontSize: 13, height: 1.45),
        bodySmall: TextStyle(color: _slate, fontSize: 12, height: 1.4),
      ),
      cardTheme: const CardThemeData(
        color: Colors.white,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(18)),
          side: BorderSide(color: _line, width: 1),
        ),
      ),
    ),
    home: const _SpwscDemoHome(),
  );
}

// ---------------------------------------------------------------------------
// Home — keeps a single ScrollController; all panels observe its position.
// ---------------------------------------------------------------------------
class _SpwscDemoHome extends StatefulWidget {
  const _SpwscDemoHome();

  @override
  State<_SpwscDemoHome> createState() => _SpwscDemoHomeState();
}

class _SpwscDemoHomeState extends State<_SpwscDemoHome> {
  final ScrollController _controller = ScrollController();
  ScrollHoldController? _heldHold;
  String _lastActivity = 'IdleScrollActivity';
  String _userDirection = 'idle';
  double _pixels = 0.0;
  double _minExtent = 0.0;
  double _maxExtent = 0.0;
  double _viewport = 0.0;
  String _axisDir = 'down';
  bool _outOfRange = false;
  bool _atEdge = true;
  bool _haveDimensions = false;
  double _extentBefore = 0.0;
  double _extentInside = 0.0;
  double _extentAfter = 0.0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onScrollListener);
  }

  @override
  void dispose() {
    _controller.removeListener(_onScrollListener);
    _heldHold?.cancel();
    _heldHold = null;
    _controller.dispose();
    super.dispose();
  }

  void _onScrollListener() {
    if (!_controller.hasClients) return;
    final ScrollPosition pos = _controller.position;
    setState(() {
      _pixels = pos.pixels;
      _minExtent = pos.minScrollExtent;
      _maxExtent = pos.maxScrollExtent;
      _viewport = pos.viewportDimension;
      _axisDir = pos.axisDirection.name;
      _outOfRange = pos.outOfRange;
      _atEdge = pos.atEdge;
      _haveDimensions = pos.haveDimensions;
      _extentBefore = pos.extentBefore;
      _extentInside = pos.extentInside;
      _extentAfter = pos.extentAfter;
      _userDirection = pos.userScrollDirection.name;
      final ScrollActivity? act = pos.activity;
      _lastActivity = act == null ? 'null' : act.runtimeType.toString();
    });
  }

  void _jumpToStart() {
    if (!_controller.hasClients) return;
    _controller.jumpTo(_controller.position.minScrollExtent);
    debugPrint('jumpTo(min) — instant teleport, no physics involved.');
  }

  void _jumpToEnd() {
    if (!_controller.hasClients) return;
    _controller.jumpTo(_controller.position.maxScrollExtent);
    debugPrint('jumpTo(max) — instant teleport to end of extent.');
  }

  void _animateToMid() {
    if (!_controller.hasClients) return;
    final double mid =
        (_controller.position.maxScrollExtent +
            _controller.position.minScrollExtent) /
        2.0;
    _controller.animateTo(
      mid,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
    debugPrint('animateTo(mid) — installs a DrivenScrollActivity.');
  }

  void _pointerNudge() {
    if (!_controller.hasClients) return;
    final ScrollPosition pos = _controller.position;
    final double target = (pos.pixels + 60.0).clamp(
      pos.minScrollExtent,
      pos.maxScrollExtent,
    );
    _controller.animateTo(
      target,
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOut,
    );
    debugPrint('pointerScroll(+60) — simulated with a short animateTo.');
  }

  void _startHold() {
    if (!_controller.hasClients) return;
    if (_heldHold != null) return;
    _heldHold = _controller.position.hold(_onHoldCancelled);
    debugPrint('hold() — installed HoldScrollActivity.');
    setState(() {});
  }

  void _releaseHold() {
    _heldHold?.cancel();
    _heldHold = null;
    debugPrint('hold.cancel() — releasing back to Idle.');
    setState(() {});
  }

  void _onHoldCancelled() {
    // Safety net: ScrollPosition calls this when the hold is cancelled
    // externally (e.g. a new drag begins before we released it ourselves).
    debugPrint('hold cancellation callback fired.');
    _heldHold = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _cobalt,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'ScrollPositionWithSingleContext — the workhorse position',
          style: TextStyle(fontWeight: FontWeight.w700, letterSpacing: -0.2),
        ),
        actions: const [_HeroPulseIcon(), SizedBox(width: 12)],
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: _handleScrollNotification,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _HeroHeader(
                pixels: _pixels,
                minExtent: _minExtent,
                maxExtent: _maxExtent,
              ),
              const SizedBox(height: 24),
              _LivePixelDashboard(
                controller: _controller,
                pixels: _pixels,
                minExtent: _minExtent,
                maxExtent: _maxExtent,
                viewport: _viewport,
                axis: _axisDir,
                outOfRange: _outOfRange,
                atEdge: _atEdge,
                haveDimensions: _haveDimensions,
                extentBefore: _extentBefore,
                extentInside: _extentInside,
                extentAfter: _extentAfter,
                userDirection: _userDirection,
                activity: _lastActivity,
              ),
              const SizedBox(height: 20),
              _MethodPlayground(
                onJumpMin: _jumpToStart,
                onJumpMax: _jumpToEnd,
                onAnimate: _animateToMid,
                onPointer: _pointerNudge,
                activity: _lastActivity,
              ),
              const SizedBox(height: 24),
              _ActivityDiagram(current: _lastActivity),
              const SizedBox(height: 24),
              _ActivityObserverCard(activity: _lastActivity),
              const SizedBox(height: 24),
              _HoldDemonstration(
                holding: _heldHold != null,
                onHold: _startHold,
                onRelease: _releaseHold,
                activity: _lastActivity,
              ),
              const SizedBox(height: 24),
              const _MethodReferenceCard(),
              const SizedBox(height: 24),
              const _TeachingPanel(),
              const SizedBox(height: 24),
              const _WhenToReachIn(),
              const SizedBox(height: 24),
              const _FooterSummary(),
            ],
          ),
        ),
      ),
    );
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    // Not strictly needed because the controller listener updates state, but
    // demonstrates how to read notifications alongside the position listener.
    if (notification is ScrollStartNotification) {
      debugPrint('ScrollStartNotification — DragScrollActivity likely.');
    } else if (notification is ScrollEndNotification) {
      debugPrint('ScrollEndNotification — returning to Idle.');
    }
    return false;
  }
}

// ---------------------------------------------------------------------------
// Hero header — custom-painted gauge face + needle showing current pixels.
// ---------------------------------------------------------------------------
class _HeroHeader extends StatelessWidget {
  const _HeroHeader({
    required this.pixels,
    required this.minExtent,
    required this.maxExtent,
  });

  final double pixels;
  final double minExtent;
  final double maxExtent;

  @override
  Widget build(BuildContext context) {
    final double range = maxExtent - minExtent;
    final double normalised = range <= 0
        ? 0
        : ((pixels - minExtent) / range).clamp(0.0, 1.0);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: _amber.withValues(alpha: 0.22),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: const Text(
                      'widgets/scrollable',
                      style: TextStyle(
                        color: _charcoal,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.4,
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'The position every ListView, GridView, and SingleChildScrollView shares.',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'ScrollPositionWithSingleContext binds exactly one ScrollContext '
                    'to one ScrollPhysics chain. It stores the `pixels` offset, '
                    'arbitrates ScrollActivity transitions, and emits '
                    'notifications to listeners up the tree.',
                    style: TextStyle(
                      color: _charcoal,
                      fontSize: 13,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: const [
                      _Pill(text: 'single context'),
                      _Pill(text: 'owns ScrollActivity'),
                      _Pill(text: 'listens via isScrollingNotifier'),
                      _Pill(text: 'enforces physics at setPixels'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 18),
            SizedBox(
              width: 210,
              height: 210,
              child: CustomPaint(
                painter: _GaugePainter(
                  progress: normalised,
                  pixels: pixels,
                  min: minExtent,
                  max: maxExtent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: _cobalt.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: _cobalt.withValues(alpha: 0.18)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: _cobalt,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _GaugePainter extends CustomPainter {
  _GaugePainter({
    required this.progress,
    required this.pixels,
    required this.min,
    required this.max,
  });

  final double progress;
  final double pixels;
  final double min;
  final double max;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset centre = Offset(size.width / 2, size.height * 0.78);
    final double radius = math.min(size.width, size.height) * 0.48;

    // Outer face — cream disc with subtle ring.
    final Paint face = Paint()..color = _cream;
    canvas.drawCircle(centre, radius, face);
    final Paint faceRing = Paint()
      ..color = _line
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.3;
    canvas.drawCircle(centre, radius, faceRing);

    // Arc — progress segment (amber) plus remainder (cobalt tint).
    final Rect arcRect = Rect.fromCircle(
      center: centre,
      radius: radius - 18,
    );
    final Paint track = Paint()
      ..color = _cobalt.withValues(alpha: 0.12)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;
    const double start = math.pi * 1.15;
    const double sweep = math.pi * 0.7;
    canvas.drawArc(arcRect, start, sweep, false, track);
    final Paint done = Paint()
      ..color = _amber
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(arcRect, start, sweep * progress, false, done);

    // Tick marks — 10 steps.
    final Paint tick = Paint()
      ..color = _charcoal.withValues(alpha: 0.6)
      ..strokeWidth = 1.2;
    for (int i = 0; i <= 10; i++) {
      final double t = i / 10.0;
      final double angle = start + sweep * t;
      final Offset inner = centre +
          Offset(math.cos(angle), math.sin(angle)) * (radius - 28);
      final Offset outer = centre +
          Offset(math.cos(angle), math.sin(angle)) * (radius - 10);
      canvas.drawLine(inner, outer, tick);
    }

    // Needle.
    final double needleAngle = start + sweep * progress;
    final Offset needleEnd = centre +
        Offset(math.cos(needleAngle), math.sin(needleAngle)) *
            (radius - 24);
    final Paint needle = Paint()
      ..color = _cobalt
      ..strokeWidth = 3.2
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(centre, needleEnd, needle);
    canvas.drawCircle(centre, 7, Paint()..color = _cobalt);
    canvas.drawCircle(centre, 3, Paint()..color = _amber);

    // Pixel readout.
    final TextPainter label = TextPainter(
      text: TextSpan(
        text: 'pixels',
        style: TextStyle(
          color: _charcoal.withValues(alpha: 0.6),
          fontSize: 10,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.8,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    label.paint(canvas, Offset(centre.dx - label.width / 2, 10));

    final TextPainter value = TextPainter(
      text: TextSpan(
        text: pixels.toStringAsFixed(1),
        style: const TextStyle(
          color: _cobalt,
          fontSize: 26,
          fontWeight: FontWeight.w800,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    value.paint(canvas, Offset(centre.dx - value.width / 2, 26));

    final TextPainter range = TextPainter(
      text: TextSpan(
        text:
            '${min.toStringAsFixed(0)} – ${max.toStringAsFixed(0)}',
        style: const TextStyle(
          color: _slate,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    range.paint(
      canvas,
      Offset(centre.dx - range.width / 2, centre.dy + 18),
    );
  }

  @override
  bool shouldRepaint(_GaugePainter old) =>
      old.progress != progress ||
      old.pixels != pixels ||
      old.min != min ||
      old.max != max;
}

// ---------------------------------------------------------------------------
// Hero pulse — uses ValueListenableBuilder on isScrollingNotifier.
// ---------------------------------------------------------------------------
class _HeroPulseIcon extends StatelessWidget {
  const _HeroPulseIcon();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        final _SpwscDemoHomeState? state = context
            .findAncestorStateOfType<_SpwscDemoHomeState>();
        if (state == null || !state._controller.hasClients) {
          return const _PulseDot(active: false);
        }
        return ValueListenableBuilder<bool>(
          valueListenable: state._controller.position.isScrollingNotifier,
          builder: (BuildContext context, bool scrolling, _) {
            return _PulseDot(active: scrolling);
          },
        );
      },
    );
  }
}

class _PulseDot extends StatelessWidget {
  const _PulseDot({required this.active});

  final bool active;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: active ? _amber : _amber.withValues(alpha: 0.25),
            shape: BoxShape.circle,
            boxShadow: active
                ? [
                    BoxShadow(
                      color: _amber.withValues(alpha: 0.6),
                      blurRadius: 12,
                      spreadRadius: 2,
                    ),
                  ]
                : const [],
          ),
        ),
        const SizedBox(width: 8),
        Text(
          active ? 'scrolling' : 'at rest',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.4,
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Live pixel dashboard — a ListView + metrics readout.
// ---------------------------------------------------------------------------
class _LivePixelDashboard extends StatelessWidget {
  const _LivePixelDashboard({
    required this.controller,
    required this.pixels,
    required this.minExtent,
    required this.maxExtent,
    required this.viewport,
    required this.axis,
    required this.outOfRange,
    required this.atEdge,
    required this.haveDimensions,
    required this.extentBefore,
    required this.extentInside,
    required this.extentAfter,
    required this.userDirection,
    required this.activity,
  });

  final ScrollController controller;
  final double pixels;
  final double minExtent;
  final double maxExtent;
  final double viewport;
  final String axis;
  final bool outOfRange;
  final bool atEdge;
  final bool haveDimensions;
  final double extentBefore;
  final double extentInside;
  final double extentAfter;
  final String userDirection;
  final String activity;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.speed_rounded, color: _cobalt, size: 20),
                const SizedBox(width: 8),
                Text(
                  'Live pixel dashboard',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Spacer(),
                _ActivityBadge(activity: activity),
              ],
            ),
            const SizedBox(height: 6),
            const Text(
              'Scroll the colourful ListView — every value is read straight '
              'from controller.position and refreshed on every tick.',
              style: TextStyle(color: _slate, fontSize: 12, height: 1.4),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 230,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: _cream.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: _line),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: ListView.builder(
                    controller: controller,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: 60,
                    itemBuilder: (BuildContext ctx, int index) {
                      return _ColouredTile(index: index);
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                _Metric(label: 'pixels', value: pixels.toStringAsFixed(2)),
                _Metric(
                  label: 'minScrollExtent',
                  value: minExtent.toStringAsFixed(1),
                ),
                _Metric(
                  label: 'maxScrollExtent',
                  value: maxExtent.toStringAsFixed(1),
                ),
                _Metric(
                  label: 'viewportDimension',
                  value: viewport.toStringAsFixed(1),
                ),
                _Metric(label: 'axisDirection', value: axis),
                _Metric(label: 'userScrollDirection', value: userDirection),
                _Metric(
                  label: 'extentBefore',
                  value: extentBefore.toStringAsFixed(1),
                ),
                _Metric(
                  label: 'extentInside',
                  value: extentInside.toStringAsFixed(1),
                ),
                _Metric(
                  label: 'extentAfter',
                  value: extentAfter.toStringAsFixed(1),
                ),
                _Metric(label: 'atEdge', value: atEdge.toString()),
                _Metric(label: 'outOfRange', value: outOfRange.toString()),
                _Metric(
                  label: 'haveDimensions',
                  value: haveDimensions.toString(),
                ),
              ],
            ),
            const SizedBox(height: 14),
            _IsScrollingRow(controller: controller),
          ],
        ),
      ),
    );
  }
}

class _ColouredTile extends StatelessWidget {
  const _ColouredTile({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final List<Color> palette = const [
      _cobalt,
      _amber,
      _leaf,
      _rose,
      _softCobalt,
      _mutedAmber,
    ];
    final Color base = palette[index % palette.length];
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: base.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: base.withValues(alpha: 0.32)),
      ),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: base,
              borderRadius: BorderRadius.circular(6),
            ),
            alignment: Alignment.center,
            child: Text(
              '${index + 1}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Tile ${index + 1} — pixels grows as this tile moves under the viewport origin.',
              style: const TextStyle(
                color: _charcoal,
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

class _Metric extends StatelessWidget {
  const _Metric({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 150),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: _paper,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _line),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: _slate,
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(
              color: _charcoal,
              fontSize: 14,
              fontWeight: FontWeight.w700,
              fontFeatures: <FontFeature>[FontFeature.tabularFigures()],
            ),
          ),
        ],
      ),
    );
  }
}

class _IsScrollingRow extends StatelessWidget {
  const _IsScrollingRow({required this.controller});

  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    if (!controller.hasClients) {
      return const _IsScrollingLed(active: false);
    }
    return ValueListenableBuilder<bool>(
      valueListenable: controller.position.isScrollingNotifier,
      builder: (BuildContext context, bool scrolling, _) {
        return _IsScrollingLed(active: scrolling);
      },
    );
  }
}

class _IsScrollingLed extends StatelessWidget {
  const _IsScrollingLed({required this.active});

  final bool active;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            color: active ? _leaf : _charcoal.withValues(alpha: 0.2),
            shape: BoxShape.circle,
            boxShadow: active
                ? [
                    BoxShadow(
                      color: _leaf.withValues(alpha: 0.5),
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ]
                : const [],
          ),
        ),
        const SizedBox(width: 10),
        const Text(
          'isScrollingNotifier',
          style: TextStyle(
            color: _charcoal,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          active ? 'true' : 'false',
          style: TextStyle(
            color: active ? _leaf : _slate,
            fontSize: 12,
            fontWeight: FontWeight.w700,
            fontFeatures: const <FontFeature>[FontFeature.tabularFigures()],
          ),
        ),
      ],
    );
  }
}

class _ActivityBadge extends StatelessWidget {
  const _ActivityBadge({required this.activity});

  final String activity;

  @override
  Widget build(BuildContext context) {
    final Color colour = _activityColour(activity);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: colour.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: colour.withValues(alpha: 0.35)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: colour, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Text(
            activity,
            style: TextStyle(
              color: colour,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}

Color _activityColour(String activity) {
  if (activity.contains('Idle')) return _slate;
  if (activity.contains('Drag')) return _cobalt;
  if (activity.contains('Ballistic')) return _amber;
  if (activity.contains('Driven')) return _leaf;
  if (activity.contains('Hold')) return _rose;
  return _slate;
}

// ---------------------------------------------------------------------------
// Method playground — 2x2 grid of buttons, each with a coloured phase.
// ---------------------------------------------------------------------------
class _MethodPlayground extends StatelessWidget {
  const _MethodPlayground({
    required this.onJumpMin,
    required this.onJumpMax,
    required this.onAnimate,
    required this.onPointer,
    required this.activity,
  });

  final VoidCallback onJumpMin;
  final VoidCallback onJumpMax;
  final VoidCallback onAnimate;
  final VoidCallback onPointer;
  final String activity;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.play_circle_rounded, color: _amber, size: 22),
                const SizedBox(width: 8),
                Text(
                  'Method playground',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 6),
            const Text(
              'Each button drives the attached position through a different '
              'ScrollActivity. Watch the dashboard and the badge update.',
              style: TextStyle(color: _slate, fontSize: 12, height: 1.4),
            ),
            const SizedBox(height: 16),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 2.4,
              children: [
                _PlaygroundButton(
                  label: 'jumpTo(0)',
                  sub: 'instant teleport to min',
                  phase: 'IdleScrollActivity',
                  activity: activity,
                  icon: Icons.first_page_rounded,
                  colour: _cobalt,
                  onTap: onJumpMin,
                ),
                _PlaygroundButton(
                  label: 'jumpTo(max)',
                  sub: 'teleport to extent',
                  phase: 'IdleScrollActivity',
                  activity: activity,
                  icon: Icons.last_page_rounded,
                  colour: _cobalt,
                  onTap: onJumpMax,
                ),
                _PlaygroundButton(
                  label: 'animateTo(mid, 1s)',
                  sub: 'DrivenScrollActivity',
                  phase: 'DrivenScrollActivity',
                  activity: activity,
                  icon: Icons.timeline_rounded,
                  colour: _leaf,
                  onTap: onAnimate,
                ),
                _PlaygroundButton(
                  label: 'pointerScroll(+60)',
                  sub: 'short DrivenScrollActivity',
                  phase: 'DrivenScrollActivity',
                  activity: activity,
                  icon: Icons.mouse_rounded,
                  colour: _amber,
                  onTap: onPointer,
                ),
              ],
            ),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _cream,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _line),
              ),
              child: Row(
                children: [
                  const Icon(Icons.lightbulb, color: _amber, size: 18),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'Tip: calling animateTo while another DrivenScrollActivity is '
                      'running interrupts the previous one — the new activity wins.',
                      style: TextStyle(
                        color: _charcoal,
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
      ),
    );
  }
}

class _PlaygroundButton extends StatelessWidget {
  const _PlaygroundButton({
    required this.label,
    required this.sub,
    required this.phase,
    required this.activity,
    required this.icon,
    required this.colour,
    required this.onTap,
  });

  final String label;
  final String sub;
  final String phase;
  final String activity;
  final IconData icon;
  final Color colour;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final bool active = activity == phase;
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: active
              ? colour.withValues(alpha: 0.18)
              : colour.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: colour.withValues(alpha: active ? 0.55 : 0.28),
            width: active ? 1.6 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: colour,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: Colors.white, size: 18),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      color: _charcoal,
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    sub,
                    style: const TextStyle(
                      color: _slate,
                      fontSize: 11,
                      height: 1.3,
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

// ---------------------------------------------------------------------------
// ScrollActivity state-machine diagram. Uses layered Containers + Icons.
// ---------------------------------------------------------------------------
class _ActivityDiagram extends StatelessWidget {
  const _ActivityDiagram({required this.current});

  final String current;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.account_tree_rounded, color: _cobalt),
                const SizedBox(width: 8),
                Text(
                  'ScrollActivity state machine',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'The position is never in "no state"; it always has a current '
              'ScrollActivity (`position.activity`). Transitions follow these '
              'well-defined paths.',
              style: TextStyle(color: _slate, fontSize: 12, height: 1.4),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                _ActivityNode(
                  title: 'IdleScrollActivity',
                  caption: 'resting state',
                  colour: _slate,
                  highlighted: current == 'IdleScrollActivity',
                ),
                _Arrow(compact: true, label: 'hold()'),
                _ActivityNode(
                  title: 'HoldScrollActivity',
                  caption: 'position is pinned',
                  colour: _rose,
                  highlighted: current == 'HoldScrollActivity',
                ),
                _Arrow(compact: true, label: 'drag()'),
                _ActivityNode(
                  title: 'DragScrollActivity',
                  caption: 'finger on screen',
                  colour: _cobalt,
                  highlighted: current == 'DragScrollActivity',
                ),
                _Arrow(compact: true, label: 'fling'),
                _ActivityNode(
                  title: 'BallisticScrollActivity',
                  caption: 'physics simulation',
                  colour: _amber,
                  highlighted: current == 'BallisticScrollActivity',
                ),
                _Arrow(compact: true, label: 'simulation ends'),
                _ActivityNode(
                  title: 'IdleScrollActivity',
                  caption: 'back at rest',
                  colour: _slate,
                  highlighted: false,
                ),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                const Icon(Icons.route_rounded, color: _leaf, size: 18),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'animateTo(…) installs a DrivenScrollActivity that bypasses '
                    'Drag/Ballistic and returns directly to Idle when finished.',
                    style: TextStyle(
                      color: _charcoal,
                      fontSize: 12,
                      height: 1.4,
                    ),
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

class _ActivityNode extends StatelessWidget {
  const _ActivityNode({
    required this.title,
    required this.caption,
    required this.colour,
    required this.highlighted,
  });

  final String title;
  final String caption;
  final Color colour;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: highlighted
            ? colour.withValues(alpha: 0.2)
            : colour.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colour.withValues(alpha: highlighted ? 0.7 : 0.3),
          width: highlighted ? 2 : 1,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(color: colour, shape: BoxShape.circle),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: colour,
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            caption,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: _slate,
              fontSize: 10,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}

class _Arrow extends StatelessWidget {
  const _Arrow({required this.compact, required this.label});

  final bool compact;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            compact ? Icons.arrow_downward : Icons.arrow_forward,
            color: _charcoal.withValues(alpha: 0.6),
            size: 18,
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
              color: _slate,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Activity observer — reads the live activity runtimeType and colours it.
// ---------------------------------------------------------------------------
class _ActivityObserverCard extends StatelessWidget {
  const _ActivityObserverCard({required this.activity});

  final String activity;

  @override
  Widget build(BuildContext context) {
    final Color colour = _activityColour(activity);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 14,
              height: 14,
              margin: const EdgeInsets.only(top: 4),
              decoration: BoxDecoration(color: colour, shape: BoxShape.circle),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Activity observer — reading position.activity.runtimeType',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Notifications and listeners give a high-level story. For '
                    'the ground truth, read `controller.position.activity` — '
                    'but remember it can be null briefly while the position '
                    'swaps activities.',
                    style: TextStyle(
                      color: _slate,
                      fontSize: 12,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: colour.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: colour.withValues(alpha: 0.35),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.radio_button_checked_rounded,
                          size: 16,
                          color: _charcoal,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'current runtimeType: $activity',
                          style: TextStyle(
                            color: colour,
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                            fontFeatures: const <FontFeature>[
                              FontFeature.tabularFigures(),
                            ],
                          ),
                        ),
                      ],
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

// ---------------------------------------------------------------------------
// Hold demonstration — driving HoldScrollActivity via position.hold.
// ---------------------------------------------------------------------------
class _HoldDemonstration extends StatelessWidget {
  const _HoldDemonstration({
    required this.holding,
    required this.onHold,
    required this.onRelease,
    required this.activity,
  });

  final bool holding;
  final VoidCallback onHold;
  final VoidCallback onRelease;
  final String activity;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.pan_tool_rounded, color: _rose),
                const SizedBox(width: 8),
                Text(
                  'hold() — pin the position in place',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Spacer(),
                _ActivityBadge(activity: activity),
              ],
            ),
            const SizedBox(height: 6),
            const Text(
              'Press "Hold" to install a HoldScrollActivity. Ballistic settles '
              'will be suppressed until you call `cancel()` on the returned '
              'ScrollHoldController. This mirrors the gesture system\'s hold-'
              'before-drag handoff.',
              style: TextStyle(color: _slate, fontSize: 12, height: 1.4),
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                FilledButton.icon(
                  onPressed: holding ? null : onHold,
                  icon: const Icon(Icons.lock_rounded, size: 18),
                  label: const Text('Hold'),
                  style: FilledButton.styleFrom(
                    backgroundColor: _rose,
                    foregroundColor: Colors.white,
                  ),
                ),
                const SizedBox(width: 12),
                FilledButton.icon(
                  onPressed: holding ? onRelease : null,
                  icon: const Icon(Icons.lock_open_rounded, size: 18),
                  label: const Text('Release'),
                  style: FilledButton.styleFrom(
                    backgroundColor: _leaf,
                    foregroundColor: Colors.white,
                  ),
                ),
                const SizedBox(width: 16),
                Flexible(
                  child: Text(
                    holding
                        ? 'HoldScrollActivity is installed; any new drag will cancel it.'
                        : 'Idle — no hold is active right now.',
                    style: TextStyle(
                      color: holding ? _rose : _slate,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
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

// ---------------------------------------------------------------------------
// Method reference card — two columns, one-line descriptions.
// ---------------------------------------------------------------------------
class _MethodReferenceCard extends StatelessWidget {
  const _MethodReferenceCard();

  @override
  Widget build(BuildContext context) {
    final List<List<String>> rows = const [
      ['setPixels(value)', 'Physics-aware offset change; clamps with overscroll.'],
      ['forcePixels(value)', 'Hard sets pixels, bypassing physics checks.'],
      ['correctPixels(value)', 'Silent adjust during layout correction passes.'],
      ['animateTo(off, d, c)', 'Drive to offset with DrivenScrollActivity.'],
      ['jumpTo(value)', 'Teleport offset; snaps without animation.'],
      ['moveTo(off, d?, c?)', 'Smart choice of jump vs animate by duration.'],
      ['hold(onCancel)', 'Install HoldScrollActivity; returns controller.'],
      ['drag(details, end)', 'Start a DragScrollActivity tied to the gesture.'],
      ['beginActivity(act)', 'Swap in a new ScrollActivity manually.'],
      ['goIdle()', 'Request transition back to IdleScrollActivity.'],
      ['goBallistic(velocity)', 'Install BallisticScrollActivity with velocity.'],
    ];
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.menu_book_rounded, color: _cobalt),
                const SizedBox(width: 8),
                Text(
                  'Method reference — single-context position API',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 14),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: rows
                  .map((row) => _ReferenceRow(name: row[0], desc: row[1]))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReferenceRow extends StatelessWidget {
  const _ReferenceRow({required this.name, required this.desc});

  final String name;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 310, maxWidth: 440),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _paper,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _line),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: _cobalt.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              name,
              style: const TextStyle(
                color: _cobalt,
                fontSize: 12,
                fontWeight: FontWeight.w800,
                fontFeatures: <FontFeature>[FontFeature.tabularFigures()],
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            desc,
            style: const TextStyle(
              color: _charcoal,
              fontSize: 12,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Teaching panel — four opinionated tiles.
// ---------------------------------------------------------------------------
class _TeachingPanel extends StatelessWidget {
  const _TeachingPanel();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.school_rounded, color: _leaf),
                const SizedBox(width: 8),
                Text(
                  'Teaching notes',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 14),
            Wrap(
              spacing: 14,
              runSpacing: 14,
              children: const [
                _TeachTile(
                  title: 'setPixels enforces physics.',
                  body: 'Overscroll is clamped and reported — forcePixels skips '
                      'physics and should be used sparingly.',
                  colour: _cobalt,
                ),
                _TeachTile(
                  title: 'animateTo is interruptible.',
                  body: 'A DrivenScrollActivity is installed; any new drag, '
                      'animate, or ballistic call replaces it immediately.',
                  colour: _leaf,
                ),
                _TeachTile(
                  title: 'Dispose the ScrollController.',
                  body: 'The position is attached to its lifecycle. Forgetting '
                      'to dispose leaks listeners and Position objects.',
                  colour: _rose,
                ),
                _TeachTile(
                  title: 'isScrollingNotifier → efficient rebuilds.',
                  body: 'Wrap in ValueListenableBuilder to rebuild only when '
                      'scrolling starts/stops, not on every frame.',
                  colour: _amber,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TeachTile extends StatelessWidget {
  const _TeachTile({
    required this.title,
    required this.body,
    required this.colour,
  });

  final String title;
  final String body;
  final Color colour;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 260, maxWidth: 380),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colour.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colour.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: colour,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  title,
                  style: TextStyle(
                    color: colour,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            body,
            style: const TextStyle(
              color: _charcoal,
              fontSize: 12,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// When-to-reach-into-position — four use case tiles.
// ---------------------------------------------------------------------------
class _WhenToReachIn extends StatelessWidget {
  const _WhenToReachIn();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.hub_rounded, color: _cobalt),
                const SizedBox(width: 8),
                Text(
                  'When to reach directly into the position',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 6),
            const Text(
              'Most code leans on ScrollController and ScrollNotification, but '
              'these four scenarios really want `controller.position`.',
              style: TextStyle(color: _slate, fontSize: 12, height: 1.4),
            ),
            const SizedBox(height: 14),
            Wrap(
              spacing: 14,
              runSpacing: 14,
              children: const [
                _UseCaseTile(
                  icon: Icons.push_pin_rounded,
                  colour: _cobalt,
                  title: 'Sticky headers',
                  body: 'Read `pixels` and `viewportDimension` to translate '
                      'a header and snap it into place at thresholds.',
                ),
                _UseCaseTile(
                  icon: Icons.downloading_rounded,
                  colour: _amber,
                  title: 'Pull-to-refresh',
                  body: 'Detect overscroll by watching `pixels` drop below '
                      '`minScrollExtent`, then trigger a refresh.',
                ),
                _UseCaseTile(
                  icon: Icons.save_rounded,
                  colour: _leaf,
                  title: 'Restoration',
                  body: 'Persist `pixels` across launches and call '
                      '`jumpTo(saved)` once dimensions are available.',
                ),
                _UseCaseTile(
                  icon: Icons.pause_circle_rounded,
                  colour: _rose,
                  title: 'Pause autoplay',
                  body: 'Use `isScrollingNotifier` to pause a video or '
                      'carousel while the user is scrolling.',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _UseCaseTile extends StatelessWidget {
  const _UseCaseTile({
    required this.icon,
    required this.colour,
    required this.title,
    required this.body,
  });

  final IconData icon;
  final Color colour;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 250, maxWidth: 360),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _line),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: colour.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: colour.withValues(alpha: 0.4)),
            ),
            child: Icon(icon, color: colour, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: _charcoal,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  body,
                  style: const TextStyle(
                    color: _slate,
                    fontSize: 12,
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

// ---------------------------------------------------------------------------
// Footer summary card — closes the demo with the elevator pitch.
// ---------------------------------------------------------------------------
class _FooterSummary extends StatelessWidget {
  const _FooterSummary();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: _cobalt,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: _cobalt.withValues(alpha: 0.3),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.flag_rounded, color: _amber),
              SizedBox(width: 8),
              Text(
                'Workshop summary',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'ScrollPositionWithSingleContext is the default, single-context '
            'concrete position used under every standard scrollable. It tracks '
            '`pixels`, arbitrates `ScrollActivity` transitions, respects '
            'physics at `setPixels`, and speaks to listeners via '
            '`isScrollingNotifier`. Drive it with `jumpTo`, `animateTo`, '
            '`hold`, `drag`, or go all the way down to `beginActivity` — but '
            'always remember to dispose the ScrollController that owns it.',
            style: TextStyle(color: _cream, fontSize: 13, height: 1.55),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 10,
            children: const [
              _FooterChip(label: 'single ScrollContext'),
              _FooterChip(label: 'owns ScrollActivity'),
              _FooterChip(label: 'physics-gated setPixels'),
              _FooterChip(label: 'isScrollingNotifier'),
              _FooterChip(label: 'controller.position'),
            ],
          ),
        ],
      ),
    );
  }
}

class _FooterChip extends StatelessWidget {
  const _FooterChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withValues(alpha: 0.25)),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}
