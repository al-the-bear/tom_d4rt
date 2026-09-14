import 'dart:math' as math;

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// End-of-Scroll Radar — a deep visual demo for ScrollEndNotification.
//
// ScrollEndNotification extends ScrollNotification and is dispatched whenever
// a scroll activity transitions to idle. It carries:
//   - metrics      : ScrollMetrics snapshot at the moment the scroll ended.
//   - context      : BuildContext of the Scrollable that produced the event.
//   - dragDetails  : DragEndDetails? — non-null when the end was caused by
//                    the user lifting their finger (so velocity is known);
//                    null when the end came from a programmatic animateTo or
//                    jumpTo, or from a ballistic scroll that settled on its
//                    own after the pointer was already released.
//
// This demo is intentionally didactic: each section explores a different
// facet of the notification so that a reader can "see" when it fires, what
// it carries, and how to use it in real applications such as infinite-scroll
// loaders, autoplay resume logic, scroll-linked animations, and snap points.
// ---------------------------------------------------------------------------

const Color kNavy = Color(0xFF0B1F3A);
const Color kCoral = Color(0xFFFF6B6B);
const Color kButter = Color(0xFFFFD166);
const Color kMist = Color(0xFFE8ECF1);
const Color kInk = Color(0xFF12233F);
const Color kMuted = Color(0xFF7A8AA0);

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'ScrollEndNotification — End-of-Scroll Radar',
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: kNavy,
        primary: kNavy,
        secondary: kCoral,
      ),
      scaffoldBackgroundColor: kMist,
      fontFamily: 'Roboto',
    ),
    home: const _EndOfScrollRadarHome(),
  );
}

// ---------------------------------------------------------------------------
// Captured end-event record.
// ---------------------------------------------------------------------------

class _EndEvent {
  _EndEvent({
    required this.timestamp,
    required this.pixels,
    required this.maxScrollExtent,
    required this.minScrollExtent,
    required this.viewportDimension,
    required this.axisDirection,
    required this.fromDrag,
    required this.primaryVelocity,
    required this.velocityDx,
    required this.velocityDy,
    required this.startedAt,
    required this.cause,
  });

  final DateTime timestamp;
  final double pixels;
  final double maxScrollExtent;
  final double minScrollExtent;
  final double viewportDimension;
  final AxisDirection axisDirection;
  final bool fromDrag;
  final double primaryVelocity;
  final double velocityDx;
  final double velocityDy;
  final DateTime? startedAt;
  final String cause;

  double get extentBefore => (pixels - minScrollExtent).clamp(0.0, double.infinity);
  double get extentAfter =>
      (maxScrollExtent - pixels).clamp(0.0, double.infinity);
  double get extentInside => viewportDimension;

  Duration get duration =>
      startedAt == null ? Duration.zero : timestamp.difference(startedAt!);
}

// ---------------------------------------------------------------------------
// Root.
// ---------------------------------------------------------------------------

class _EndOfScrollRadarHome extends StatefulWidget {
  const _EndOfScrollRadarHome();

  @override
  State<_EndOfScrollRadarHome> createState() => _EndOfScrollRadarHomeState();
}

class _EndOfScrollRadarHomeState extends State<_EndOfScrollRadarHome>
    with TickerProviderStateMixin {
  // Animation for the decorative radar sweep in the hero header.
  late final AnimationController _radar;

  // Animation for pulsing highlights on captured events.
  late final AnimationController _pulse;

  // Scroll controller used by the live list AND by the "programmatic" scenario
  // button so we can call animateTo to synthesize a non-drag end.
  final ScrollController _listController = ScrollController();

  // Horizontal scroll controller for the timeline strip.
  final ScrollController _timelineController = ScrollController();

  // Rolling log of captured end events (most recent first).
  final List<_EndEvent> _events = <_EndEvent>[];

  // Most recent start time, used to approximate start→end pairing.
  DateTime? _lastStartTime;

  // Scenario tagging: the next end event will be labelled with this cause.
  String _nextCause = 'user';

  // Highlights per scenario card.
  int? _highlightForFling;
  int? _highlightForTouchRelease;
  int? _highlightForProgrammatic;

  // Counters for the teaching tiles.
  int _totalEnds = 0;
  int _dragEnds = 0;
  int _progEnds = 0;

  @override
  void initState() {
    super.initState();
    _radar = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _radar.dispose();
    _pulse.dispose();
    _listController.dispose();
    _timelineController.dispose();
    super.dispose();
  }

  // --- notification handlers ------------------------------------------------

  bool _onNotification(ScrollNotification n) {
    if (n is ScrollStartNotification) {
      _lastStartTime = DateTime.now();
    } else if (n is ScrollEndNotification) {
      _captureEnd(n);
    }
    return false;
  }

  void _captureEnd(ScrollEndNotification n) {
    final DragEndDetails? d = n.dragDetails;
    final bool fromDrag = d != null;
    final double dx = d?.velocity.pixelsPerSecond.dx ?? 0.0;
    final double dy = d?.velocity.pixelsPerSecond.dy ?? 0.0;
    final double primary = d?.primaryVelocity ?? 0.0;

    String cause = _nextCause;
    // If our scenario tag was "user" but there are no drag details, call it
    // a settle; this happens when a ballistic animation ends after the finger
    // has already lifted.
    if (cause == 'user' && !fromDrag) cause = 'settle';
    _nextCause = 'user';

    final ev = _EndEvent(
      timestamp: DateTime.now(),
      pixels: n.metrics.pixels,
      maxScrollExtent: n.metrics.maxScrollExtent,
      minScrollExtent: n.metrics.minScrollExtent,
      viewportDimension: n.metrics.viewportDimension,
      axisDirection: n.metrics.axisDirection,
      fromDrag: fromDrag,
      primaryVelocity: primary,
      velocityDx: dx,
      velocityDy: dy,
      startedAt: _lastStartTime,
      cause: cause,
    );

    setState(() {
      _events.insert(0, ev);
      if (_events.length > 60) {
        _events.removeRange(60, _events.length);
      }
      _totalEnds += 1;
      if (fromDrag) {
        _dragEnds += 1;
      } else {
        _progEnds += 1;
      }

      // Light up the most appropriate scenario card.
      if (cause == 'fling' || (fromDrag && primary.abs() >= 200)) {
        _highlightForFling = 0;
      } else if (cause == 'release' || (fromDrag && primary.abs() < 200)) {
        _highlightForTouchRelease = 0;
      } else if (cause == 'programmatic' || !fromDrag) {
        _highlightForProgrammatic = 0;
      }
    });

    // Keep the timeline anchored to the newest event.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_timelineController.hasClients) {
        _timelineController.animateTo(
          0,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });

    debugPrint(
      'ScrollEnd captured: pixels=${n.metrics.pixels.toStringAsFixed(1)} '
      'drag=$fromDrag primary=${primary.toStringAsFixed(1)} cause=$cause',
    );
  }

  // --- scenario triggers ----------------------------------------------------

  Future<void> _runProgrammatic() async {
    _nextCause = 'programmatic';
    if (!_listController.hasClients) return;
    final double target =
        _listController.offset + 420 > _listController.position.maxScrollExtent
            ? 0.0
            : _listController.offset + 420;
    await _listController.animateTo(
      target,
      duration: const Duration(milliseconds: 900),
      curve: Curves.easeInOut,
    );
  }

  void _hintFling() {
    _nextCause = 'fling';
    debugPrint('Hint: drag the list hard and release for a fling-end.');
  }

  void _hintRelease() {
    _nextCause = 'release';
    debugPrint('Hint: drag the list gently and release slowly.');
  }

  void _clearLog() {
    setState(() {
      _events.clear();
      _totalEnds = 0;
      _dragEnds = 0;
      _progEnds = 0;
      _highlightForFling = null;
      _highlightForTouchRelease = null;
      _highlightForProgrammatic = null;
    });
  }

  // --- build ---------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMist,
      body: NotificationListener<ScrollNotification>(
        onNotification: _onNotification,
        child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: _HeroHeader(radar: _radar)),
              SliverToBoxAdapter(child: _SectionDivider(title: '1 · Overview')),
              SliverToBoxAdapter(child: _OverviewCard()),
              SliverToBoxAdapter(
                child: _SectionDivider(title: '2 · Live end-event catcher'),
              ),
              SliverToBoxAdapter(
                child: _LiveCatcher(
                  controller: _listController,
                  events: _events,
                  onClear: _clearLog,
                ),
              ),
              SliverToBoxAdapter(
                child: _SectionDivider(title: '3 · Event timeline'),
              ),
              SliverToBoxAdapter(
                child: _EventTimeline(
                  events: _events,
                  controller: _timelineController,
                ),
              ),
              SliverToBoxAdapter(
                child:
                    _SectionDivider(title: '4 · Cause-of-end comparison cards'),
              ),
              SliverToBoxAdapter(
                child: _ScenarioCards(
                  events: _events,
                  pulse: _pulse,
                  onFling: _hintFling,
                  onRelease: _hintRelease,
                  onProgrammatic: _runProgrammatic,
                  flingHighlight: _highlightForFling,
                  releaseHighlight: _highlightForTouchRelease,
                  progHighlight: _highlightForProgrammatic,
                ),
              ),
              SliverToBoxAdapter(
                child: _SectionDivider(title: '5 · DragEndDetails anatomy'),
              ),
              SliverToBoxAdapter(child: _DragDetailsCard(events: _events)),
              SliverToBoxAdapter(
                child: _SectionDivider(title: '6 · ScrollMetrics snapshot'),
              ),
              SliverToBoxAdapter(child: _MetricsCard(events: _events)),
              SliverToBoxAdapter(
                child:
                    _SectionDivider(title: '7 · ScrollStart / End pairing'),
              ),
              SliverToBoxAdapter(child: _PairingDiagram(events: _events)),
              SliverToBoxAdapter(
                child: _SectionDivider(title: '8 · Teaching panel'),
              ),
              SliverToBoxAdapter(
                child: _TeachingPanel(
                  totalEnds: _totalEnds,
                  dragEnds: _dragEnds,
                  progEnds: _progEnds,
                ),
              ),
              SliverToBoxAdapter(
                child: _SectionDivider(title: '9 · Common use cases'),
              ),
              SliverToBoxAdapter(child: _UseCasesStrip()),
              SliverToBoxAdapter(
                child: _SectionDivider(title: '10 · Summary'),
              ),
              SliverToBoxAdapter(child: _FooterCard()),
              const SliverToBoxAdapter(child: SizedBox(height: 32)),
            ],
          ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Hero header with a rotating radar sweep.
// ---------------------------------------------------------------------------

class _HeroHeader extends StatelessWidget {
  const _HeroHeader({required this.radar});
  final AnimationController radar;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [kNavy, Color(0xFF132E57)],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: kNavy.withValues(alpha: 0.35),
            offset: const Offset(0, 12),
            blurRadius: 24,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 160,
            height: 160,
            child: AnimatedBuilder(
              animation: radar,
              builder: (context, _) {
                return CustomPaint(
                  painter: _RadarPainter(sweep: radar.value * 2 * math.pi),
                );
              },
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ScrollEndNotification',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.2,
                      ),
                ),
                const SizedBox(height: 6),
                Text(
                  'the last frame of a scroll',
                  style: TextStyle(
                    color: kButter,
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Dispatched when a scroll activity becomes idle. Carries '
                  'ScrollMetrics and, when the end was caused by the user '
                  'lifting their finger, DragEndDetails with velocity.',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.85),
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: const [
                    _HeroChip(label: 'metrics'),
                    _HeroChip(label: 'context'),
                    _HeroChip(label: 'dragDetails'),
                    _HeroChip(label: 'velocity', accent: true),
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

class _HeroChip extends StatelessWidget {
  const _HeroChip({required this.label, this.accent = false});
  final String label;
  final bool accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: accent
            ? kCoral.withValues(alpha: 0.85)
            : Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: accent
              ? kCoral
              : Colors.white.withValues(alpha: 0.25),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: accent ? Colors.white : Colors.white.withValues(alpha: 0.85),
          fontFamily: 'monospace',
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _RadarPainter extends CustomPainter {
  _RadarPainter({required this.sweep});
  final double sweep;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = size.center(Offset.zero);
    final double r = size.shortestSide / 2 - 4;

    // Rings.
    final ringPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..color = Colors.white.withValues(alpha: 0.25);
    for (int i = 1; i <= 4; i++) {
      canvas.drawCircle(center, r * (i / 4), ringPaint);
    }

    // Cross axes.
    final axisPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.15)
      ..strokeWidth = 1.0;
    canvas.drawLine(
      Offset(center.dx - r, center.dy),
      Offset(center.dx + r, center.dy),
      axisPaint,
    );
    canvas.drawLine(
      Offset(center.dx, center.dy - r),
      Offset(center.dx, center.dy + r),
      axisPaint,
    );

    // Sweep gradient wedge.
    final Rect rect = Rect.fromCircle(center: center, radius: r);
    final sweepPaint = Paint()
      ..shader = SweepGradient(
        startAngle: sweep - 0.6,
        endAngle: sweep,
        colors: [
          kCoral.withValues(alpha: 0.0),
          kCoral.withValues(alpha: 0.75),
        ],
      ).createShader(rect);
    canvas.drawArc(rect, sweep - 0.6, 0.6, true, sweepPaint);

    // Rotating line.
    final linePaint = Paint()
      ..color = kButter
      ..strokeWidth = 2.2
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      center,
      Offset(center.dx + r * math.cos(sweep), center.dy + r * math.sin(sweep)),
      linePaint,
    );

    // Center dot.
    canvas.drawCircle(
      center,
      4,
      Paint()..color = kButter,
    );

    // Pip marks.
    final pipPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.4)
      ..style = PaintingStyle.fill;
    for (int i = 0; i < 12; i++) {
      final double a = (i / 12) * 2 * math.pi;
      final double x = center.dx + r * math.cos(a);
      final double y = center.dy + r * math.sin(a);
      canvas.drawCircle(Offset(x, y), 1.6, pipPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _RadarPainter old) => old.sweep != sweep;
}

// ---------------------------------------------------------------------------
// Section divider.
// ---------------------------------------------------------------------------

class _SectionDivider extends StatelessWidget {
  const _SectionDivider({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: const BoxDecoration(
              color: kCoral,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            title,
            style: const TextStyle(
              color: kNavy,
              fontSize: 20,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.2,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Container(height: 2, color: kNavy.withValues(alpha: 0.08)),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Overview card.
// ---------------------------------------------------------------------------

class _OverviewCard extends StatelessWidget {
  const _OverviewCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: kNavy.withValues(alpha: 0.06)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          _BulletRow(
            icon: Icons.circle_notifications_outlined,
            text:
                'ScrollEndNotification fires once per scroll gesture when the '
                'underlying scroll activity becomes idle.',
          ),
          _BulletRow(
            icon: Icons.touch_app_outlined,
            text:
                'dragDetails is non-null when the end was caused by the user '
                'lifting their finger — its velocity tells you whether they '
                'flicked or released gently.',
          ),
          _BulletRow(
            icon: Icons.auto_mode_outlined,
            text:
                'dragDetails is null when the end came from a programmatic '
                'animateTo / jumpTo, or when a ballistic scroll settled on '
                'its own after the finger had already been released.',
          ),
          _BulletRow(
            icon: Icons.analytics_outlined,
            text:
                'Always pair it with ScrollStartNotification when measuring '
                'gesture durations, and never assume "end" means "bottom" — '
                'check metrics.pixels vs metrics.maxScrollExtent explicitly.',
          ),
        ],
      ),
    );
  }
}

class _BulletRow extends StatelessWidget {
  const _BulletRow({required this.icon, required this.text});
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: kCoral, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: kInk,
                fontSize: 14,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 2 — live catcher: a real ListView + a log pane.
// ---------------------------------------------------------------------------

class _LiveCatcher extends StatelessWidget {
  const _LiveCatcher({
    required this.controller,
    required this.events,
    required this.onClear,
  });

  final ScrollController controller;
  final List<_EndEvent> events;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: 380,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: kNavy.withValues(alpha: 0.06)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18),
                bottomLeft: Radius.circular(18),
              ),
              child: _ColouredListView(controller: controller),
            ),
          ),
          Container(width: 1, color: kNavy.withValues(alpha: 0.08)),
          Expanded(
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(14, 12, 12, 8),
                  child: Row(
                    children: [
                      const Icon(Icons.receipt_long_outlined,
                          color: kNavy, size: 20),
                      const SizedBox(width: 8),
                      const Text(
                        'End event log',
                        style: TextStyle(
                          color: kNavy,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        visualDensity: VisualDensity.compact,
                        tooltip: 'Clear log',
                        onPressed: onClear,
                        icon: const Icon(Icons.delete_sweep_outlined,
                            color: kMuted),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: events.isEmpty
                      ? const _EmptyLogHint()
                      : ListView.separated(
                          padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                          itemCount: events.length,
                          separatorBuilder: (c, i) =>
                              const SizedBox(height: 6),
                          itemBuilder: (ctx, i) => _EventLogRow(event: events[i]),
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

class _ColouredListView extends StatelessWidget {
  const _ColouredListView({required this.controller});
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: controller,
      physics: const BouncingScrollPhysics(),
      itemCount: 40,
      padding: EdgeInsets.zero,
      itemBuilder: (ctx, i) {
        final double t = i / 40.0;
        final Color c = Color.lerp(kNavy, kCoral, t)!;
        return Container(
          height: 64,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: c.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(12),
            border: Border(left: BorderSide(color: c, width: 4)),
          ),
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: c,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '${i + 1}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tile #${i + 1}',
                      style: const TextStyle(
                        color: kInk,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Scroll me, fling me, release me — watch the log.',
                      style: TextStyle(
                        color: kMuted,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: c),
            ],
          ),
        );
      },
    );
  }
}

class _EmptyLogHint extends StatelessWidget {
  const _EmptyLogHint();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.hourglass_empty, color: kMuted, size: 32),
            const SizedBox(height: 8),
            Text(
              'No end events yet.\nScroll the list on the left.',
              textAlign: TextAlign.center,
              style: TextStyle(color: kMuted, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

class _EventLogRow extends StatelessWidget {
  const _EventLogRow({required this.event});
  final _EndEvent event;

  @override
  Widget build(BuildContext context) {
    final String ts = _fmtTime(event.timestamp);
    final String badge = event.fromDrag ? 'DRAG' : 'PROG';
    final Color badgeBg = event.fromDrag ? kCoral : kMuted;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: kMist.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: kNavy.withValues(alpha: 0.06)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: badgeBg.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: badgeBg),
            ),
            child: Text(
              badge,
              style: TextStyle(
                color: badgeBg,
                fontFamily: 'monospace',
                fontSize: 10,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: DefaultTextStyle(
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 11,
                color: kInk,
                height: 1.3,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$ts  px=${event.pixels.toStringAsFixed(1)}  '
                    'max=${event.maxScrollExtent.toStringAsFixed(0)}  '
                    'vp=${event.viewportDimension.toStringAsFixed(0)}',
                  ),
                  Text(
                    event.fromDrag
                        ? 'v=${event.primaryVelocity.toStringAsFixed(1)} '
                            'dx=${event.velocityDx.toStringAsFixed(1)} '
                            'dy=${event.velocityDy.toStringAsFixed(1)}'
                        : 'programmatic — no DragEndDetails',
                    style: TextStyle(
                      color: event.fromDrag ? kNavy : kMuted,
                      fontFamily: 'monospace',
                      fontSize: 11,
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

// ---------------------------------------------------------------------------
// Section 3 — timeline strip.
// ---------------------------------------------------------------------------

class _EventTimeline extends StatelessWidget {
  const _EventTimeline({required this.events, required this.controller});
  final List<_EndEvent> events;
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    final recent = events.take(20).toList();
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: 110,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: kNavy.withValues(alpha: 0.06)),
      ),
      child: recent.isEmpty
          ? Center(
              child: Text(
                'Timeline will fill as scroll-end events arrive.',
                style: TextStyle(color: kMuted, fontStyle: FontStyle.italic),
              ),
            )
          : ListView.separated(
              controller: controller,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: recent.length,
              separatorBuilder: (c, i) => const SizedBox(width: 10),
              itemBuilder: (ctx, i) => _TimelineChip(event: recent[i], index: i),
            ),
    );
  }
}

class _TimelineChip extends StatelessWidget {
  const _TimelineChip({required this.event, required this.index});
  final _EndEvent event;
  final int index;

  @override
  Widget build(BuildContext context) {
    final Color c = event.fromDrag ? kCoral : kMuted;
    final String label = event.fromDrag
        ? 'v ${event.primaryVelocity.toStringAsFixed(0)}'
        : 'prog';

    return Container(
      width: 80,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: c.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: c),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: c,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              '#${index + 1}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w800,
                fontFamily: 'monospace',
              ),
            ),
          ),
          const Spacer(),
          Text(
            label,
            style: const TextStyle(
              color: kInk,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w700,
              fontSize: 12,
            ),
          ),
          Text(
            _fmtTime(event.timestamp),
            style: TextStyle(
              color: kMuted,
              fontFamily: 'monospace',
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 4 — cause-of-end comparison cards.
// ---------------------------------------------------------------------------

class _ScenarioCards extends StatelessWidget {
  const _ScenarioCards({
    required this.events,
    required this.pulse,
    required this.onFling,
    required this.onRelease,
    required this.onProgrammatic,
    required this.flingHighlight,
    required this.releaseHighlight,
    required this.progHighlight,
  });

  final List<_EndEvent> events;
  final AnimationController pulse;
  final VoidCallback onFling;
  final VoidCallback onRelease;
  final VoidCallback onProgrammatic;
  final int? flingHighlight;
  final int? releaseHighlight;
  final int? progHighlight;

  _EndEvent? _findFor(String kind) {
    for (final e in events) {
      switch (kind) {
        case 'fling':
          if (e.fromDrag && e.primaryVelocity.abs() >= 200) return e;
          break;
        case 'release':
          if (e.fromDrag && e.primaryVelocity.abs() < 200) return e;
          break;
        case 'programmatic':
          if (!e.fromDrag) return e;
          break;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: LayoutBuilder(builder: (ctx, bc) {
        final bool wide = bc.maxWidth > 900;
        final children = [
          _ScenarioCard(
            title: 'User fling end',
            subtitle: 'fast flick, released with velocity',
            icon: Icons.bolt,
            accent: kCoral,
            event: _findFor('fling'),
            pulse: pulse,
            highlight: flingHighlight,
            button: 'Arm — next end = fling',
            onPressed: onFling,
            bullets: const [
              'dragDetails != null',
              'primaryVelocity |v| ≥ ~200',
              'typical for page swipes and tab scrolls',
            ],
          ),
          _ScenarioCard(
            title: 'User touch release',
            subtitle: 'slow drag, released with ~0 velocity',
            icon: Icons.pan_tool_alt_outlined,
            accent: kButter,
            event: _findFor('release'),
            pulse: pulse,
            highlight: releaseHighlight,
            button: 'Arm — next end = release',
            onPressed: onRelease,
            bullets: const [
              'dragDetails != null',
              'primaryVelocity |v| ≈ 0',
              'user "parks" the list precisely',
            ],
          ),
          _ScenarioCard(
            title: 'Programmatic animateTo end',
            subtitle: 'no pointer, settled by controller',
            icon: Icons.auto_mode,
            accent: kNavy,
            event: _findFor('programmatic'),
            pulse: pulse,
            highlight: progHighlight,
            button: 'Run animateTo now',
            onPressed: onProgrammatic,
            bullets: const [
              'dragDetails == null',
              'velocity unknown',
              'e.g. scrollToIndex, restoreOffset',
            ],
          ),
        ];

        if (wide) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (int i = 0; i < children.length; i++) ...[
                Expanded(child: children[i]),
                if (i < children.length - 1) const SizedBox(width: 12),
              ],
            ],
          );
        }
        return Column(
          children: [
            for (int i = 0; i < children.length; i++) ...[
              children[i],
              if (i < children.length - 1) const SizedBox(height: 12),
            ],
          ],
        );
      }),
    );
  }
}

class _ScenarioCard extends StatelessWidget {
  const _ScenarioCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.accent,
    required this.event,
    required this.pulse,
    required this.highlight,
    required this.button,
    required this.onPressed,
    required this.bullets,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color accent;
  final _EndEvent? event;
  final AnimationController pulse;
  final int? highlight;
  final String button;
  final VoidCallback onPressed;
  final List<String> bullets;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: kNavy.withValues(alpha: 0.06)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: accent),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: kNavy,
                        fontWeight: FontWeight.w800,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(color: kMuted, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          for (final b in bullets)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('•  ',
                      style: TextStyle(color: kCoral, fontSize: 14)),
                  Expanded(
                    child: Text(
                      b,
                      style: const TextStyle(color: kInk, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: FilledButton.tonal(
              style: FilledButton.styleFrom(
                backgroundColor: accent.withValues(alpha: 0.12),
                foregroundColor: accent,
              ),
              onPressed: onPressed,
              child: Text(button),
            ),
          ),
          const SizedBox(height: 12),
          AnimatedBuilder(
            animation: pulse,
            builder: (ctx, _) {
              final double glow = highlight == null ? 0.0 : pulse.value;
              return Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: kMist,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: accent.withValues(alpha: 0.35 + 0.5 * glow),
                    width: 1 + glow,
                  ),
                ),
                child: event == null
                    ? Text(
                        'No event captured yet for this scenario.',
                        style: TextStyle(
                          color: kMuted,
                          fontStyle: FontStyle.italic,
                          fontSize: 12,
                        ),
                      )
                    : DefaultTextStyle(
                        style: const TextStyle(
                          color: kInk,
                          fontFamily: 'monospace',
                          fontSize: 11,
                          height: 1.4,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('when : ${_fmtTime(event!.timestamp)}'),
                            Text(
                              'px   : ${event!.pixels.toStringAsFixed(2)}',
                            ),
                            Text(
                              'max  : ${event!.maxScrollExtent.toStringAsFixed(1)}',
                            ),
                            Text(
                              event!.fromDrag
                                  ? 'v    : ${event!.primaryVelocity.toStringAsFixed(1)} px/s'
                                  : 'v    : — (programmatic)',
                            ),
                          ],
                        ),
                      ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 5 — DragEndDetails anatomy card.
// ---------------------------------------------------------------------------

class _DragDetailsCard extends StatelessWidget {
  const _DragDetailsCard({required this.events});
  final List<_EndEvent> events;

  @override
  Widget build(BuildContext context) {
    final _EndEvent? latest =
        events.where((e) => e.fromDrag).isEmpty ? null : events.firstWhere((e) => e.fromDrag);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: kNavy.withValues(alpha: 0.06)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'DragEndDetails (live — updates on drag-end)',
            style: TextStyle(
              color: kNavy,
              fontWeight: FontWeight.w800,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'When the scroll ended because the user lifted their finger, the '
            'notification carries these fields describing the gesture.',
            style: TextStyle(color: kMuted, fontSize: 12, height: 1.4),
          ),
          const SizedBox(height: 14),
          LayoutBuilder(builder: (ctx, bc) {
            final bool wide = bc.maxWidth > 720;
            final fields = [
              _FieldTile(
                label: 'velocity.pixelsPerSecond.dx',
                value: latest == null ? '—' : latest.velocityDx.toStringAsFixed(2),
              ),
              _FieldTile(
                label: 'velocity.pixelsPerSecond.dy',
                value: latest == null ? '—' : latest.velocityDy.toStringAsFixed(2),
              ),
              _FieldTile(
                label: 'primaryVelocity',
                value: latest == null ? '—' : latest.primaryVelocity.toStringAsFixed(2),
              ),
              _FieldTile(
                label: 'speed (magnitude)',
                value: latest == null
                    ? '—'
                    : math
                        .sqrt(latest.velocityDx * latest.velocityDx +
                            latest.velocityDy * latest.velocityDy)
                        .toStringAsFixed(2),
              ),
              _FieldTile(
                label: 'direction',
                value: latest == null
                    ? '—'
                    : _directionLabel(latest.primaryVelocity, latest.axisDirection),
              ),
              _FieldTile(
                label: 'captured at',
                value: latest == null ? '—' : _fmtTime(latest.timestamp),
              ),
            ];
            if (wide) {
              return Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  for (final f in fields)
                    SizedBox(width: (bc.maxWidth - 36) / 3, child: f),
                ],
              );
            }
            return Column(
              children: [
                for (final f in fields)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: f,
                  ),
              ],
            );
          }),
          const SizedBox(height: 14),
          _VelocityGauge(
            velocity: latest?.primaryVelocity ?? 0.0,
            active: latest != null,
          ),
        ],
      ),
    );
  }

  String _directionLabel(double v, AxisDirection axis) {
    if (v == 0) return 'none';
    final bool positive = v > 0;
    switch (axis) {
      case AxisDirection.down:
        return positive ? 'downwards' : 'upwards';
      case AxisDirection.up:
        return positive ? 'upwards' : 'downwards';
      case AxisDirection.left:
        return positive ? 'leftwards' : 'rightwards';
      case AxisDirection.right:
        return positive ? 'rightwards' : 'leftwards';
    }
  }
}

class _FieldTile extends StatelessWidget {
  const _FieldTile({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: kMist,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: kNavy.withValues(alpha: 0.06)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: kMuted,
              fontSize: 11,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: kNavy,
              fontSize: 15,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _VelocityGauge extends StatelessWidget {
  const _VelocityGauge({required this.velocity, required this.active});
  final double velocity;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final double clamped = velocity.clamp(-4000.0, 4000.0);
    final double ratio = clamped / 4000.0; // -1..1
    final double bar = ratio.abs();
    final Color c = velocity >= 0 ? kCoral : kNavy;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: kMist,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: kNavy.withValues(alpha: 0.06)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'primaryVelocity gauge',
                style: TextStyle(
                  color: kNavy,
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
              const Spacer(),
              Text(
                active ? 'LIVE' : 'IDLE',
                style: TextStyle(
                  color: active ? kCoral : kMuted,
                  fontWeight: FontWeight.w800,
                  fontSize: 11,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LayoutBuilder(builder: (ctx, bc) {
            final double halfW = bc.maxWidth / 2;
            return SizedBox(
              height: 18,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(9),
                        border:
                            Border.all(color: kNavy.withValues(alpha: 0.1)),
                      ),
                    ),
                  ),
                  Positioned(
                    left: halfW - 1,
                    top: 2,
                    bottom: 2,
                    child: Container(width: 2, color: kMuted),
                  ),
                  Positioned(
                    left: velocity >= 0 ? halfW : halfW - halfW * bar,
                    top: 3,
                    bottom: 3,
                    width: halfW * bar,
                    child: Container(
                      decoration: BoxDecoration(
                        color: c.withValues(alpha: 0.75),
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 6),
          Text(
            '${velocity.toStringAsFixed(1)} px/s (range ±4000)',
            style: TextStyle(
              color: kMuted,
              fontFamily: 'monospace',
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 6 — ScrollMetrics snapshot with extent bars.
// ---------------------------------------------------------------------------

class _MetricsCard extends StatelessWidget {
  const _MetricsCard({required this.events});
  final List<_EndEvent> events;

  @override
  Widget build(BuildContext context) {
    final _EndEvent? latest = events.isEmpty ? null : events.first;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: kNavy.withValues(alpha: 0.06)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'ScrollMetrics at the moment of end',
            style: TextStyle(
              color: kNavy,
              fontWeight: FontWeight.w800,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 12),
          if (latest == null)
            Text(
              'No metrics yet — scroll the list above.',
              style: TextStyle(color: kMuted, fontStyle: FontStyle.italic),
            )
          else ...[
            _MetricRow(label: 'axisDirection', value: '${latest.axisDirection}'),
            _MetricRow(
              label: 'pixels',
              value: latest.pixels.toStringAsFixed(2),
            ),
            _MetricRow(
              label: 'minScrollExtent',
              value: latest.minScrollExtent.toStringAsFixed(2),
            ),
            _MetricRow(
              label: 'maxScrollExtent',
              value: latest.maxScrollExtent.toStringAsFixed(2),
            ),
            _MetricRow(
              label: 'viewportDimension',
              value: latest.viewportDimension.toStringAsFixed(2),
            ),
            _MetricRow(
              label: 'extentBefore',
              value: latest.extentBefore.toStringAsFixed(2),
            ),
            _MetricRow(
              label: 'extentInside',
              value: latest.extentInside.toStringAsFixed(2),
            ),
            _MetricRow(
              label: 'extentAfter',
              value: latest.extentAfter.toStringAsFixed(2),
            ),
            const SizedBox(height: 14),
            _ExtentBars(event: latest),
            const SizedBox(height: 10),
            Text(
              latest.pixels >= latest.maxScrollExtent - 0.5
                  ? 'Reached the bottom. Safe to fetch the next page.'
                  : 'Ended mid-list at '
                      '${(latest.pixels / latest.maxScrollExtent * 100).toStringAsFixed(1)}% '
                      'of the scrollable range.',
              style: TextStyle(
                color: kMuted,
                fontStyle: FontStyle.italic,
                fontSize: 12,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _MetricRow extends StatelessWidget {
  const _MetricRow({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          SizedBox(
            width: 180,
            child: Text(
              label,
              style: TextStyle(
                color: kMuted,
                fontFamily: 'monospace',
                fontSize: 12,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: kInk,
                fontFamily: 'monospace',
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ExtentBars extends StatelessWidget {
  const _ExtentBars({required this.event});
  final _EndEvent event;

  @override
  Widget build(BuildContext context) {
    final double total = (event.extentBefore +
            event.extentInside +
            event.extentAfter)
        .clamp(1.0, double.infinity);
    final double b = event.extentBefore / total;
    final double i = event.extentInside / total;
    final double a = event.extentAfter / total;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 22,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(11),
            border: Border.all(color: kNavy.withValues(alpha: 0.1)),
          ),
          clipBehavior: Clip.antiAlias,
          child: Row(
            children: [
              Expanded(
                flex: (b * 1000).round().clamp(1, 1000),
                child: Container(color: kNavy.withValues(alpha: 0.7)),
              ),
              Expanded(
                flex: (i * 1000).round().clamp(1, 1000),
                child: Container(color: kButter),
              ),
              Expanded(
                flex: (a * 1000).round().clamp(1, 1000),
                child: Container(color: kCoral.withValues(alpha: 0.8)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            _LegendDot(color: kNavy.withValues(alpha: 0.7), label: 'before'),
            const SizedBox(width: 12),
            _LegendDot(color: kButter, label: 'inside (viewport)'),
            const SizedBox(width: 12),
            _LegendDot(color: kCoral, label: 'after'),
          ],
        ),
      ],
    );
  }
}

class _LegendDot extends StatelessWidget {
  const _LegendDot({required this.color, required this.label});
  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(color: kMuted, fontSize: 11),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Section 7 — pairing diagram (start → end bars).
// ---------------------------------------------------------------------------

class _PairingDiagram extends StatelessWidget {
  const _PairingDiagram({required this.events});
  final List<_EndEvent> events;

  @override
  Widget build(BuildContext context) {
    final paired = events.where((e) => e.startedAt != null).take(10).toList();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: kNavy.withValues(alpha: 0.06)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'ScrollStart → ScrollEnd pairing (last 10)',
            style: TextStyle(
              color: kNavy,
              fontWeight: FontWeight.w800,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Every ScrollStartNotification is eventually paired with a '
            'ScrollEndNotification. Bars show the duration of each gesture.',
            style: TextStyle(color: kMuted, fontSize: 12, height: 1.4),
          ),
          const SizedBox(height: 12),
          if (paired.isEmpty)
            Text(
              'Scroll the list above to populate this diagram.',
              style: TextStyle(color: kMuted, fontStyle: FontStyle.italic),
            )
          else
            LayoutBuilder(builder: (ctx, bc) {
              final double maxMs = paired
                  .map((e) => e.duration.inMilliseconds.toDouble())
                  .fold<double>(1.0, (p, c) => c > p ? c : p);
              return Column(
                children: [
                  for (int i = 0; i < paired.length; i++)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 28,
                            child: Text(
                              '#${i + 1}',
                              style: TextStyle(
                                color: kMuted,
                                fontFamily: 'monospace',
                                fontSize: 11,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 16,
                              decoration: BoxDecoration(
                                color: kMist,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: FractionallySizedBox(
                                alignment: Alignment.centerLeft,
                                widthFactor: (paired[i]
                                            .duration
                                            .inMilliseconds /
                                        maxMs)
                                    .clamp(0.02, 1.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: paired[i].fromDrag
                                        ? kCoral.withValues(alpha: 0.85)
                                        : kMuted,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: 80,
                            child: Text(
                              '${paired[i].duration.inMilliseconds} ms',
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                color: kInk,
                                fontFamily: 'monospace',
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              );
            }),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 8 — teaching panel.
// ---------------------------------------------------------------------------

class _TeachingPanel extends StatelessWidget {
  const _TeachingPanel({
    required this.totalEnds,
    required this.dragEnds,
    required this.progEnds,
  });

  final int totalEnds;
  final int dragEnds;
  final int progEnds;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: LayoutBuilder(builder: (ctx, bc) {
        final bool wide = bc.maxWidth > 900;
        final tiles = [
          _TeachingTile(
            icon: Icons.download_done_outlined,
            title: 'Use it to lazy-load',
            body:
                'Fetch the next page of items only after scrolling settles. '
                'The end event is cheaper to handle than onScroll deltas, and '
                'matches the user\'s intent ("I stopped — give me more").',
            counter: _TeachingCounter(
              label: 'end events captured',
              value: '$totalEnds',
            ),
          ),
          _TeachingTile(
            icon: Icons.fork_right,
            title: 'Differentiate user vs programmatic',
            body:
                'Check dragDetails != null to know if the end came from a '
                'real gesture. Programmatic ends (animateTo, jumpTo) arrive '
                'with a null dragDetails and no velocity.',
            counter: _TeachingCounter(
              label: 'drag / prog',
              value: '$dragEnds / $progEnds',
            ),
          ),
          _TeachingTile(
            icon: Icons.warning_amber_outlined,
            title: '"End" ≠ "bottom"',
            body:
                'End merely means "activity became idle". Compare '
                'metrics.pixels against metrics.maxScrollExtent to detect '
                'reaching the end of content. The two are orthogonal.',
            counter: _TeachingCounter(
              label: 'rule',
              value: 'pixels vs max',
            ),
          ),
        ];
        if (wide) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (int i = 0; i < tiles.length; i++) ...[
                Expanded(child: tiles[i]),
                if (i < tiles.length - 1) const SizedBox(width: 12),
              ],
            ],
          );
        }
        return Column(
          children: [
            for (int i = 0; i < tiles.length; i++) ...[
              tiles[i],
              if (i < tiles.length - 1) const SizedBox(height: 12),
            ],
          ],
        );
      }),
    );
  }
}

class _TeachingTile extends StatelessWidget {
  const _TeachingTile({
    required this.icon,
    required this.title,
    required this.body,
    required this.counter,
  });

  final IconData icon;
  final String title;
  final String body;
  final _TeachingCounter counter;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: kNavy.withValues(alpha: 0.06)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38,
            height: 38,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: kCoral.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: kCoral),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              color: kNavy,
              fontWeight: FontWeight.w800,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            body,
            style: const TextStyle(color: kInk, fontSize: 13, height: 1.45),
          ),
          const SizedBox(height: 12),
          counter,
        ],
      ),
    );
  }
}

class _TeachingCounter extends StatelessWidget {
  const _TeachingCounter({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: kMist,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.timeline, color: kNavy, size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                color: kMuted,
                fontSize: 11,
                fontFamily: 'monospace',
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: kNavy,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 9 — common use cases strip.
// ---------------------------------------------------------------------------

class _UseCasesStrip extends StatelessWidget {
  const _UseCasesStrip();

  @override
  Widget build(BuildContext context) {
    final cases = const [
      _UseCase(
        icon: Icons.all_inbox_outlined,
        title: 'Infinite scroll loader',
        body:
            'Detect near-bottom settle (metrics.extentAfter < viewport) and '
            'trigger fetchNextPage only after the end fires — avoiding '
            'rapid-fire mid-scroll requests.',
        accent: kCoral,
      ),
      _UseCase(
        icon: Icons.play_circle_outline,
        title: 'Autoplay resume',
        body:
            'Pause video playback on ScrollStart, then resume when the '
            'matching ScrollEnd arrives, so users don\'t hear audio while '
            'they flick through a feed.',
        accent: kButter,
      ),
      _UseCase(
        icon: Icons.animation_outlined,
        title: 'Scroll-linked animation settle',
        body:
            'Let a parallax or hero header relax to its resting state when '
            'the end fires — cheaper than snapping to the final value on '
            'every scroll frame.',
        accent: kNavy,
      ),
      _UseCase(
        icon: Icons.center_focus_strong_outlined,
        title: 'Snap-to-anchor trigger',
        body:
            'Decide the closest snap target when end fires and animate to '
            'it — only if dragDetails != null and |primaryVelocity| is low.',
        accent: kCoral,
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: LayoutBuilder(builder: (ctx, bc) {
        final bool wide = bc.maxWidth > 900;
        if (wide) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (int i = 0; i < cases.length; i++) ...[
                Expanded(child: cases[i]),
                if (i < cases.length - 1) const SizedBox(width: 12),
              ],
            ],
          );
        }
        return Column(
          children: [
            for (int i = 0; i < cases.length; i++) ...[
              cases[i],
              if (i < cases.length - 1) const SizedBox(height: 12),
            ],
          ],
        );
      }),
    );
  }
}

class _UseCase extends StatelessWidget {
  const _UseCase({
    required this.icon,
    required this.title,
    required this.body,
    required this.accent,
  });

  final IconData icon;
  final String title;
  final String body;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kNavy.withValues(alpha: 0.06)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 34,
            height: 34,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: accent, size: 20),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              color: kNavy,
              fontWeight: FontWeight.w800,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            body,
            style: const TextStyle(color: kInk, fontSize: 12, height: 1.45),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 10 — footer summary.
// ---------------------------------------------------------------------------

class _FooterCard extends StatelessWidget {
  const _FooterCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [kNavy, Color(0xFF132E57)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Summary',
            style: TextStyle(
              color: kButter,
              fontSize: 16,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.2,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'ScrollEndNotification is the punctuation mark at the end of a '
            'scroll sentence. It tells you the activity is idle, hands you '
            'the final ScrollMetrics, and — when the user was the cause — '
            'a DragEndDetails with the release velocity. Pair it with '
            'ScrollStartNotification to measure gestures, use its metrics '
            'to lazy-load content, and always branch on dragDetails != null '
            'to keep user-driven and programmatic scrolls cleanly separated.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.9),
              fontSize: 13,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Helpers.
// ---------------------------------------------------------------------------

String _fmtTime(DateTime t) {
  String two(int v) => v.toString().padLeft(2, '0');
  String three(int v) => v.toString().padLeft(3, '0');
  return '${two(t.hour)}:${two(t.minute)}:${two(t.second)}.${three(t.millisecond)}';
}
