import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------
// ScrollHoldController — Hold Laboratory
// -----------------------------------------------------------------------------
// A deep visual demo exploring `ScrollHoldController`, the handle returned from
// `ScrollPosition.hold(VoidCallback holdCancelCallback)`. Its sole public
// surface is `cancel()`; behind it sits a `HoldScrollActivity` that freezes
// the current position, suppresses any in-progress BallisticScrollActivity,
// and waits for the owning gesture to either release (hand-off to Ballistic
// again) or evolve into a Drag.
//
// Typical flow:
//   final hold = controller.position.hold(() {/* cancelled externally */});
//   ...later, on pointer-up:
//   hold.cancel();
//
// This laboratory demonstrates the full lifecycle, its relationship to
// fling/drag activities, the `holdCancelCallback` signal, and a handful of
// common places where ScrollHoldController shows up in real code.
// -----------------------------------------------------------------------------

// Shared palette for the laboratory.
const Color kForest = Color(0xFF2D6A4F);
const Color kBurnt = Color(0xFFD62828);
const Color kCream = Color(0xFFFFF4E3);
const Color kCharcoal = Color(0xFF1B1B1E);
const Color kMist = Color(0xFFE6DFD2);
const Color kSlate = Color(0xFF4C5C68);

// Phase colour map for timeline / badges.
const Map<String, Color> kPhasePalette = <String, Color>{
  'Idle': kSlate,
  'Driven': Color(0xFF1D4E89),
  'Hold': Color(0xFFE07A1F),
  'Ballistic': kForest,
  'Cancelled': kBurnt,
};

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'ScrollHoldController — Hold Laboratory',
    theme: ThemeData(
      scaffoldBackgroundColor: kCream,
      colorScheme: ColorScheme.fromSeed(
        seedColor: kForest,
        primary: kForest,
        secondary: kBurnt,
        surface: kCream,
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontWeight: FontWeight.w800,
          color: kCharcoal,
          letterSpacing: -0.6,
        ),
        titleLarge: TextStyle(
          fontWeight: FontWeight.w700,
          color: kCharcoal,
        ),
        bodyMedium: TextStyle(color: kCharcoal, height: 1.4),
      ),
      useMaterial3: true,
    ),
    home: const _HoldLaboratoryPage(),
  );
}

// =============================================================================
// Page shell
// =============================================================================

class _HoldLaboratoryPage extends StatefulWidget {
  const _HoldLaboratoryPage();

  @override
  State<_HoldLaboratoryPage> createState() => _HoldLaboratoryPageState();
}

class _HoldLaboratoryPageState extends State<_HoldLaboratoryPage> {
  final ScrollController _outerController = ScrollController();

  @override
  void dispose() {
    _outerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kCream,
      body: SafeArea(
        child: Scrollbar(
          controller: _outerController,
          thumbVisibility: true,
          child: SingleChildScrollView(
            controller: _outerController,
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 32,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const <Widget>[
                _HeroHeaderSection(),
                SizedBox(height: 32),
                _FlingAndHoldSection(),
                SizedBox(height: 32),
                _PhaseTimelineSection(),
                SizedBox(height: 32),
                _LifecycleDiagramSection(),
                SizedBox(height: 32),
                _HoldCancelCallbackSection(),
                SizedBox(height: 32),
                _MethodReferenceSection(),
                SizedBox(height: 32),
                _UseCasesSection(),
                SizedBox(height: 32),
                _TeachingPanelSection(),
                SizedBox(height: 32),
                _CodeSnippetSection(),
                SizedBox(height: 32),
                _FooterSummarySection(),
                SizedBox(height: 48),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// Section 1 — Hero header
// =============================================================================

class _HeroHeaderSection extends StatelessWidget {
  const _HeroHeaderSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[kForest, Color(0xFF40916C)],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: kForest.withValues(alpha: 0.3),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // Decorative pause / snowflake hybrid.
          const SizedBox(
            width: 128,
            height: 128,
            child: _PauseSnowflakePainterHost(),
          ),
          const SizedBox(width: 28),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'ScrollHoldController',
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        color: kCream,
                        fontSize: 38,
                      ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Freeze a ballistic, hand back control.',
                  style: TextStyle(
                    color: kCream,
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'A Hold Laboratory — study the handle returned from '
                  'ScrollPosition.hold(). One method: cancel(). Behind the '
                  'scenes: a HoldScrollActivity suppresses flings, pauses '
                  'pixels, and waits for the gesture to resolve.',
                  style: TextStyle(color: kCream, fontSize: 14, height: 1.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PauseSnowflakePainterHost extends StatefulWidget {
  const _PauseSnowflakePainterHost();

  @override
  State<_PauseSnowflakePainterHost> createState() =>
      _PauseSnowflakePainterHostState();
}

class _PauseSnowflakePainterHostState extends State<_PauseSnowflakePainterHost>
    with SingleTickerProviderStateMixin {
  late final AnimationController _rotation;

  @override
  void initState() {
    super.initState();
    _rotation = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 18),
    )..repeat();
  }

  @override
  void dispose() {
    _rotation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _rotation,
      builder: (BuildContext context, Widget? _) {
        return CustomPaint(
          painter: _PauseSnowflakePainter(_rotation.value),
          size: const Size.square(128),
        );
      },
    );
  }
}

class _PauseSnowflakePainter extends CustomPainter {
  _PauseSnowflakePainter(this.t);
  final double t;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset centre = Offset(size.width / 2, size.height / 2);
    final double radius = size.shortestSide / 2 - 4;

    // Outer ring.
    final Paint ring = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..color = kCream.withValues(alpha: 0.55);
    canvas.drawCircle(centre, radius, ring);

    // 6 snowflake arms.
    final Paint arm = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.4
      ..strokeCap = StrokeCap.round
      ..color = kCream.withValues(alpha: 0.85);
    canvas.save();
    canvas.translate(centre.dx, centre.dy);
    canvas.rotate(t * 2 * math.pi);
    for (int i = 0; i < 6; i++) {
      final double a = i * math.pi / 3;
      final Offset tip = Offset(math.cos(a) * radius, math.sin(a) * radius);
      canvas.drawLine(Offset.zero, tip, arm);
      // Fork branches.
      final Offset f1 = Offset(math.cos(a) * radius * 0.55,
          math.sin(a) * radius * 0.55);
      final Offset f2a = Offset(
          f1.dx + math.cos(a + 0.9) * radius * 0.25,
          f1.dy + math.sin(a + 0.9) * radius * 0.25);
      final Offset f2b = Offset(
          f1.dx + math.cos(a - 0.9) * radius * 0.25,
          f1.dy + math.sin(a - 0.9) * radius * 0.25);
      canvas.drawLine(f1, f2a, arm);
      canvas.drawLine(f1, f2b, arm);
    }
    canvas.restore();

    // Pause bars in the centre.
    final Paint bar = Paint()
      ..style = PaintingStyle.fill
      ..color = kCream;
    final double barW = radius * 0.18;
    final double barH = radius * 0.58;
    final RRect left = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: centre.translate(-barW * 0.9, 0),
        width: barW,
        height: barH,
      ),
      const Radius.circular(4),
    );
    final RRect right = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: centre.translate(barW * 0.9, 0),
        width: barW,
        height: barH,
      ),
      const Radius.circular(4),
    );
    canvas.drawRRect(left, bar);
    canvas.drawRRect(right, bar);
  }

  @override
  bool shouldRepaint(covariant _PauseSnowflakePainter old) => old.t != t;
}

// =============================================================================
// Section 2 — Fling-and-Hold interactive demo
// =============================================================================

enum _ScrollPhase { idle, driven, hold, ballistic, cancelled }

String _phaseLabel(_ScrollPhase p) {
  switch (p) {
    case _ScrollPhase.idle:
      return 'Idle';
    case _ScrollPhase.driven:
      return 'Driven';
    case _ScrollPhase.hold:
      return 'Hold';
    case _ScrollPhase.ballistic:
      return 'Ballistic';
    case _ScrollPhase.cancelled:
      return 'Cancelled';
  }
}

class _PhaseEvent {
  _PhaseEvent(this.phase, this.at);
  final _ScrollPhase phase;
  final DateTime at;
}

class _FlingAndHoldSection extends StatefulWidget {
  const _FlingAndHoldSection();

  @override
  State<_FlingAndHoldSection> createState() => _FlingAndHoldSectionState();
}

class _FlingAndHoldSectionState extends State<_FlingAndHoldSection> {
  final ScrollController _listController = ScrollController();
  ScrollHoldController? _hold;
  bool _heldCancelled = false;
  _ScrollPhase _phase = _ScrollPhase.idle;
  final List<_PhaseEvent> _history = <_PhaseEvent>[];
  Timer? _phaseInspector;
  double _lastPixels = 0;

  @override
  void initState() {
    super.initState();
    _recordPhase(_ScrollPhase.idle);
    _listController.addListener(_onScroll);
    // Low-frequency inspector detects phase transitions the notification
    // system doesn't expose directly.
    _phaseInspector =
        Timer.periodic(const Duration(milliseconds: 120), (_) => _inspect());
  }

  void _onScroll() {
    if (!_listController.hasClients) return;
    final double px = _listController.position.pixels;
    final double dp = (px - _lastPixels).abs();
    _lastPixels = px;
    if (_hold != null) {
      // Holding — position shouldn't move. Stay in hold.
      return;
    }
    if (dp > 0.1 && _phase != _ScrollPhase.driven) {
      _recordPhase(_ScrollPhase.driven);
    }
  }

  void _inspect() {
    if (!_listController.hasClients) return;
    final double dp = (_listController.position.pixels - _lastPixels).abs();
    if (_hold != null && _phase != _ScrollPhase.hold) {
      _recordPhase(_ScrollPhase.hold);
      return;
    }
    if (_hold == null && dp < 0.05 && _phase != _ScrollPhase.idle) {
      _recordPhase(_ScrollPhase.idle);
    }
  }

  void _recordPhase(_ScrollPhase next) {
    if (!mounted) return;
    setState(() {
      _phase = next;
      _history.add(_PhaseEvent(next, DateTime.now()));
      if (_history.length > 60) {
        _history.removeAt(0);
      }
    });
  }

  Future<void> _fling() async {
    if (!_listController.hasClients) return;
    _heldCancelled = false;
    _recordPhase(_ScrollPhase.ballistic);
    final double target = _listController.position.maxScrollExtent;
    try {
      await _listController.animateTo(
        target,
        duration: const Duration(seconds: 2),
        curve: Curves.decelerate,
      );
    } catch (_) {
      // Animation can throw if interrupted.
    }
  }

  void _startHold() {
    if (!_listController.hasClients) return;
    if (_hold != null) return;
    final ScrollHoldController hold = _listController.position.hold(() {
      // Hold was cancelled by something else (e.g. animateTo / drag).
      setState(() {
        _heldCancelled = true;
        _hold = null;
      });
      _recordPhase(_ScrollPhase.cancelled);
      // Briefly dwell on 'Cancelled', then settle.
      Future<void>.delayed(const Duration(milliseconds: 320), () {
        if (mounted && _hold == null) _recordPhase(_ScrollPhase.idle);
      });
    });
    setState(() {
      _hold = hold;
      _heldCancelled = false;
    });
    _recordPhase(_ScrollPhase.hold);
  }

  void _release() {
    _hold?.cancel();
    setState(() => _hold = null);
    _recordPhase(_ScrollPhase.idle);
  }

  @override
  void dispose() {
    _phaseInspector?.cancel();
    _hold?.cancel();
    _listController.removeListener(_onScroll);
    _listController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _LabCard(
      title: '2. Fling-and-Hold interactive demo',
      subtitle:
          'Fling the list, then tap Hold to freeze it mid-air. Release to '
          'resume Idle. Watch the phase badge.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              _PhaseBadge(phase: _phase),
              const SizedBox(width: 16),
              if (_heldCancelled)
                const _TextPill(
                  text: 'Hold was cancelled externally',
                  colour: kBurnt,
                ),
              const Spacer(),
              _PillButton(
                label: 'Fling →',
                colour: kForest,
                onPressed: _fling,
              ),
              const SizedBox(width: 10),
              _PillButton(
                label: _hold == null ? 'Hold' : 'Holding…',
                colour: _hold == null ? const Color(0xFFE07A1F) : kSlate,
                onPressed: _startHold,
              ),
              const SizedBox(width: 10),
              _PillButton(
                label: 'Release',
                colour: kBurnt,
                onPressed: _release,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            height: 280,
            decoration: BoxDecoration(
              color: kMist.withValues(alpha: 0.45),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: kMist),
            ),
            padding: const EdgeInsets.all(8),
            child: Scrollbar(
              controller: _listController,
              thumbVisibility: true,
              child: ListView.builder(
                controller: _listController,
                itemCount: 50,
                itemBuilder: (BuildContext context, int i) {
                  return Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 4),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: kMist,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 30,
                          height: 30,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: kForest.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '${i + 1}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: kForest),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Tile ${i + 1} — a scrollable row that can be '
                            'flung, held, and released.',
                            style: const TextStyle(color: kCharcoal),
                          ),
                        ),
                        Icon(
                          Icons.chevron_right,
                          color: kSlate.withValues(alpha: 0.6),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PhaseBadge extends StatelessWidget {
  const _PhaseBadge({required this.phase});
  final _ScrollPhase phase;

  @override
  Widget build(BuildContext context) {
    final Color c = kPhasePalette[_phaseLabel(phase)] ?? kSlate;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOutCubic,
      padding: EdgeInsets.symmetric(
        horizontal: phase == _ScrollPhase.hold ? 20 : 16,
        vertical: phase == _ScrollPhase.hold ? 12 : 10,
      ),
      decoration: BoxDecoration(
        color: c.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: c, width: 1.5),
        boxShadow: phase == _ScrollPhase.hold
            ? <BoxShadow>[
                BoxShadow(
                  color: c.withValues(alpha: 0.35),
                  blurRadius: 12,
                  spreadRadius: 2,
                ),
              ]
            : const <BoxShadow>[],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: c,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            _phaseLabel(phase),
            style: TextStyle(
              color: c,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}

class _TextPill extends StatelessWidget {
  const _TextPill({required this.text, required this.colour});
  final String text;
  final Color colour;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: colour.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: colour.withValues(alpha: 0.4)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: colour,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }
}

class _PillButton extends StatelessWidget {
  const _PillButton({
    required this.label,
    required this.colour,
    required this.onPressed,
  });
  final String label;
  final Color colour;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: colour,
        foregroundColor: kCream,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: const TextStyle(fontWeight: FontWeight.w700),
      ),
      child: Text(label),
    );
  }
}

// =============================================================================
// Section 3 — Phase timeline (Gantt-style)
// =============================================================================

class _PhaseTimelineSection extends StatefulWidget {
  const _PhaseTimelineSection();

  @override
  State<_PhaseTimelineSection> createState() => _PhaseTimelineSectionState();
}

class _PhaseTimelineSectionState extends State<_PhaseTimelineSection>
    with SingleTickerProviderStateMixin {
  // Simulated history; fed by an internal timer cycling through phases so
  // the timeline is always visibly active even without user interaction.
  final List<_PhaseEvent> _events = <_PhaseEvent>[];
  Timer? _ticker;
  final List<_ScrollPhase> _cycle = <_ScrollPhase>[
    _ScrollPhase.idle,
    _ScrollPhase.driven,
    _ScrollPhase.ballistic,
    _ScrollPhase.hold,
    _ScrollPhase.idle,
    _ScrollPhase.driven,
    _ScrollPhase.ballistic,
    _ScrollPhase.cancelled,
    _ScrollPhase.idle,
  ];
  int _cycleIndex = 0;

  @override
  void initState() {
    super.initState();
    _events.add(_PhaseEvent(_ScrollPhase.idle, DateTime.now()));
    _ticker = Timer.periodic(const Duration(milliseconds: 900), (_) {
      if (!mounted) return;
      setState(() {
        _cycleIndex = (_cycleIndex + 1) % _cycle.length;
        _events.add(_PhaseEvent(_cycle[_cycleIndex], DateTime.now()));
        // Drop events older than 12s.
        final DateTime cutoff =
            DateTime.now().subtract(const Duration(seconds: 12));
        _events.removeWhere((_PhaseEvent e) => e.at.isBefore(cutoff));
      });
    });
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _LabCard(
      title: '3. Phase timeline',
      subtitle:
          'A rolling 12-second Gantt of scroll activity phases. Each lane '
          'represents a phase; the bar shows when it was active.',
      child: SizedBox(
        height: 220,
        child: CustomPaint(
          painter: _TimelinePainter(_events, DateTime.now()),
          size: Size.infinite,
        ),
      ),
    );
  }
}

class _TimelinePainter extends CustomPainter {
  _TimelinePainter(this.events, this.now);
  final List<_PhaseEvent> events;
  final DateTime now;

  static const List<_ScrollPhase> _lanes = <_ScrollPhase>[
    _ScrollPhase.idle,
    _ScrollPhase.driven,
    _ScrollPhase.hold,
    _ScrollPhase.ballistic,
    _ScrollPhase.cancelled,
  ];

  @override
  void paint(Canvas canvas, Size size) {
    const double windowSec = 12;
    final double laneHeight = size.height / _lanes.length;

    // Background.
    final Paint bg = Paint()..color = kMist.withValues(alpha: 0.35);
    canvas.drawRect(Offset.zero & size, bg);

    // Gridlines — 1 per second.
    final Paint grid = Paint()
      ..color = kSlate.withValues(alpha: 0.15)
      ..strokeWidth = 1;
    for (int s = 0; s <= windowSec; s++) {
      final double x = size.width - (s / windowSec) * size.width;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
    }

    // Lane labels + dividers.
    final TextPainter labelPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );
    for (int i = 0; i < _lanes.length; i++) {
      final double y = i * laneHeight;
      if (i > 0) {
        canvas.drawLine(
          Offset(0, y),
          Offset(size.width, y),
          Paint()
            ..color = kSlate.withValues(alpha: 0.2)
            ..strokeWidth = 1,
        );
      }
      final String label = _phaseLabel(_lanes[i]);
      labelPainter.text = TextSpan(
        text: label,
        style: TextStyle(
          color: kPhasePalette[label],
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
      );
      labelPainter.layout();
      labelPainter.paint(canvas, Offset(8, y + 4));
    }

    // Event bars.
    for (int i = 0; i < events.length; i++) {
      final _PhaseEvent e = events[i];
      final DateTime endAt =
          (i + 1 < events.length) ? events[i + 1].at : now;
      final double startSec =
          now.difference(e.at).inMilliseconds / 1000.0;
      final double endSec =
          now.difference(endAt).inMilliseconds / 1000.0;
      if (startSec > windowSec) continue;
      final double x1 =
          size.width - (startSec.clamp(0, windowSec) / windowSec) * size.width;
      final double x2 =
          size.width - (endSec.clamp(0, windowSec) / windowSec) * size.width;
      final int laneIndex = _lanes.indexOf(e.phase);
      if (laneIndex < 0) continue;
      final double y = laneIndex * laneHeight + 6;
      final Rect r = Rect.fromLTWH(x1, y, (x2 - x1).abs(), laneHeight - 12);
      final Paint barP = Paint()
        ..color = kPhasePalette[_phaseLabel(e.phase)]!
            .withValues(alpha: 0.75);
      canvas.drawRRect(
          RRect.fromRectAndRadius(r, const Radius.circular(6)), barP);
    }

    // "Now" marker.
    final Paint nowPaint = Paint()
      ..color = kBurnt
      ..strokeWidth = 2;
    canvas.drawLine(
      Offset(size.width - 1, 0),
      Offset(size.width - 1, size.height),
      nowPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _TimelinePainter old) =>
      old.events != events || old.now != now;
}

// =============================================================================
// Section 4 — Hold lifecycle diagram
// =============================================================================

class _LifecycleDiagramSection extends StatelessWidget {
  const _LifecycleDiagramSection();

  @override
  Widget build(BuildContext context) {
    return _LabCard(
      title: '4. Hold lifecycle diagram',
      subtitle:
          'How a HoldScrollActivity enters, idles, and exits. The '
          'ScrollHoldController is the handle into the orange node.',
      child: SizedBox(
        height: 280,
        child: CustomPaint(
          painter: _LifecycleDiagramPainter(),
          size: Size.infinite,
        ),
      ),
    );
  }
}

class _LifecycleDiagramPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final List<_DiagramNode> nodes = <_DiagramNode>[
      _DiagramNode('Ballistic', const Offset(0.12, 0.5), kForest),
      _DiagramNode('HoldScrollActivity', const Offset(0.42, 0.5),
          const Color(0xFFE07A1F)),
      _DiagramNode('Idle', const Offset(0.75, 0.25), kSlate),
      _DiagramNode('Drag', const Offset(0.75, 0.75),
          const Color(0xFF1D4E89)),
    ];
    // Arrows.
    _drawArrow(canvas, size, nodes[0], nodes[1],
        label: 'position.hold()', above: true);
    _drawArrow(canvas, size, nodes[1], nodes[2],
        label: 'holdController.cancel()', above: true);
    _drawArrow(canvas, size, nodes[1], nodes[3],
        label: 'user starts drag', above: false);
    _drawArrow(canvas, size, nodes[2], nodes[0],
        label: 'fling gesture', above: false, curve: true);

    for (final _DiagramNode n in nodes) {
      _drawNode(canvas, size, n);
    }
  }

  void _drawNode(Canvas canvas, Size size, _DiagramNode n) {
    final Offset p = Offset(n.pos.dx * size.width, n.pos.dy * size.height);
    final Rect box = Rect.fromCenter(center: p, width: 160, height: 48);
    final Paint fill = Paint()..color = n.colour.withValues(alpha: 0.12);
    final Paint stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = n.colour;
    canvas.drawRRect(
        RRect.fromRectAndRadius(box, const Radius.circular(14)), fill);
    canvas.drawRRect(
        RRect.fromRectAndRadius(box, const Radius.circular(14)), stroke);
    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: n.label,
        style: TextStyle(
            color: n.colour, fontWeight: FontWeight.w800, fontSize: 14),
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: 150);
    tp.paint(canvas, p - Offset(tp.width / 2, tp.height / 2));
  }

  void _drawArrow(
    Canvas canvas,
    Size size,
    _DiagramNode from,
    _DiagramNode to, {
    required String label,
    required bool above,
    bool curve = false,
  }) {
    final Offset a = Offset(from.pos.dx * size.width, from.pos.dy * size.height);
    final Offset b = Offset(to.pos.dx * size.width, to.pos.dy * size.height);
    final Paint p = Paint()
      ..color = kCharcoal.withValues(alpha: 0.55)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    final Path path = Path()..moveTo(a.dx, a.dy);
    if (curve) {
      final Offset ctl = Offset(
        (a.dx + b.dx) / 2,
        math.min(a.dy, b.dy) - 60,
      );
      path.quadraticBezierTo(ctl.dx, ctl.dy, b.dx, b.dy);
    } else {
      path.lineTo(b.dx, b.dy);
    }
    canvas.drawPath(path, p);

    // Arrowhead.
    final double angle = math.atan2(b.dy - a.dy, b.dx - a.dx);
    final double ah = 10;
    final Path head = Path()
      ..moveTo(b.dx, b.dy)
      ..lineTo(
        b.dx - ah * math.cos(angle - 0.4),
        b.dy - ah * math.sin(angle - 0.4),
      )
      ..lineTo(
        b.dx - ah * math.cos(angle + 0.4),
        b.dy - ah * math.sin(angle + 0.4),
      )
      ..close();
    canvas.drawPath(head, Paint()..color = kCharcoal.withValues(alpha: 0.7));

    // Label.
    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: label,
        style: TextStyle(
          color: kCharcoal.withValues(alpha: 0.8),
          fontStyle: FontStyle.italic,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    final Offset mid = Offset((a.dx + b.dx) / 2, (a.dy + b.dy) / 2);
    final Offset offset = above ? const Offset(0, -16) : const Offset(0, 6);
    final Rect bg = Rect.fromCenter(
      center: mid + offset + Offset(0, tp.height / 2),
      width: tp.width + 10,
      height: tp.height + 4,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(bg, const Radius.circular(4)),
      Paint()..color = kCream,
    );
    tp.paint(canvas, mid + offset - Offset(tp.width / 2, 0));
  }

  @override
  bool shouldRepaint(covariant _LifecycleDiagramPainter old) => false;
}

class _DiagramNode {
  _DiagramNode(this.label, this.pos, this.colour);
  final String label;
  final Offset pos;
  final Color colour;
}

// =============================================================================
// Section 5 — holdCancelCallback demo
// =============================================================================

class _HoldCancelCallbackSection extends StatefulWidget {
  const _HoldCancelCallbackSection();

  @override
  State<_HoldCancelCallbackSection> createState() =>
      _HoldCancelCallbackSectionState();
}

class _HoldCancelCallbackSectionState
    extends State<_HoldCancelCallbackSection> {
  final ScrollController _controller = ScrollController();
  ScrollHoldController? _hold;
  bool _externallyCancelled = false;
  int _cancelCount = 0;

  void _beginHold() {
    if (_hold != null || !_controller.hasClients) return;
    _hold = _controller.position.hold(() {
      setState(() {
        _externallyCancelled = true;
        _cancelCount++;
        _hold = null;
      });
      debugPrint('[ScrollHoldController] holdCancelCallback fired '
          '(count=$_cancelCount)');
    });
    setState(() => _externallyCancelled = false);
  }

  Future<void> _externalCancel() async {
    if (!_controller.hasClients) return;
    // Programmatic animateTo will supersede any HoldScrollActivity and
    // invoke the holdCancelCallback.
    await _controller.animateTo(
      0,
      duration: const Duration(milliseconds: 650),
      curve: Curves.easeOutCubic,
    );
  }

  void _release() {
    _hold?.cancel();
    setState(() => _hold = null);
  }

  @override
  void dispose() {
    _hold?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _LabCard(
      title: '5. holdCancelCallback demo',
      subtitle:
          'Start a hold, then fire a programmatic animateTo. The hold is '
          'superseded and your callback fires so you can tidy up state.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              _PillButton(
                label: _hold == null ? 'Begin hold' : 'Holding…',
                colour: const Color(0xFFE07A1F),
                onPressed: _beginHold,
              ),
              const SizedBox(width: 10),
              _PillButton(
                label: 'Simulate external cancel',
                colour: kBurnt,
                onPressed: _externalCancel,
              ),
              const SizedBox(width: 10),
              _PillButton(
                label: 'Release',
                colour: kSlate,
                onPressed: _release,
              ),
              const Spacer(),
              if (_externallyCancelled)
                const _TextPill(
                  text: 'Hold was cancelled externally',
                  colour: kBurnt,
                ),
              const SizedBox(width: 10),
              _TextPill(
                text: 'Cancel callbacks fired: $_cancelCount',
                colour: kForest,
              ),
            ],
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 180,
            child: Scrollbar(
              controller: _controller,
              thumbVisibility: true,
              child: ListView.builder(
                controller: _controller,
                itemCount: 30,
                itemBuilder: (BuildContext context, int i) {
                  return Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 4, vertical: 3),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: kMist),
                    ),
                    child: Text('Row ${i + 1} — scroll me programmatically.'),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// Section 6 — Method reference card
// =============================================================================

class _MethodReferenceSection extends StatelessWidget {
  const _MethodReferenceSection();

  @override
  Widget build(BuildContext context) {
    final List<_MethodEntry> entries = <_MethodEntry>[
      _MethodEntry(
        'ScrollPosition.hold(VoidCallback holdCancelCallback)',
        'Creator. Returns a ScrollHoldController; the callback fires if the '
            'hold is superseded by another activity.',
        kForest,
      ),
      _MethodEntry(
        'ScrollHoldController.cancel()',
        'Ends the held state. If nothing else has intervened, transitions '
            'the position back to Idle. Safe to call only once per controller.',
        const Color(0xFFE07A1F),
      ),
      _MethodEntry(
        'holdCancelCallback',
        'Fires when another activity pre-empts the hold (animateTo, '
            'jumpTo, another drag, a new fling). Lets you null out your '
            'stored handle.',
        kBurnt,
      ),
      _MethodEntry(
        'Lifecycle',
        'hold() → HoldScrollActivity installed → cancel() OR external '
            'pre-emption → callback + disposal. Only one active hold per '
            'position at a time.',
        kSlate,
      ),
    ];
    return _LabCard(
      title: '6. Method reference card',
      subtitle: 'Everything you can call on ScrollHoldController — and the '
          'surrounding ScrollPosition surface that produces it.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          for (final _MethodEntry e in entries) ...<Widget>[
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: e.colour.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color: e.colour.withValues(alpha: 0.4), width: 1),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 10,
                    height: 10,
                    margin: const EdgeInsets.only(top: 6, right: 12),
                    decoration: BoxDecoration(
                      color: e.colour,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          e.signature,
                          style: TextStyle(
                            color: e.colour,
                            fontFamily: 'monospace',
                            fontWeight: FontWeight.w700,
                            fontSize: 13.5,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          e.description,
                          style: const TextStyle(
                            color: kCharcoal,
                            fontSize: 13,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _MethodEntry {
  _MethodEntry(this.signature, this.description, this.colour);
  final String signature;
  final String description;
  final Color colour;
}

// =============================================================================
// Section 7 — Common use cases strip
// =============================================================================

class _UseCasesSection extends StatelessWidget {
  const _UseCasesSection();

  @override
  Widget build(BuildContext context) {
    final List<_UseCase> cases = <_UseCase>[
      _UseCase(
        title: 'Tap during fling stops the scroll',
        body: 'The ubiquitous mobile pattern. When the user touches the '
            'list mid-fling, Flutter calls position.hold() to freeze the '
            'ballistic; on pointer up the hold is cancelled or becomes a '
            'drag.',
        icon: Icons.pan_tool_alt,
        colour: kForest,
      ),
      _UseCase(
        title: 'Pull-to-refresh hand-off',
        body: 'A gesture recognizer holds the position while deciding '
            'whether the overscroll becomes a refresh. During that time '
            'nothing else can drive the scroll — the hold is the lock.',
        icon: Icons.refresh,
        colour: Color(0xFFE07A1F),
      ),
      _UseCase(
        title: 'Interruptible scroll animation',
        body: 'A programmatic scroll should pause on hover. Call hold() '
            'when hover starts and cancel() on hover end. Your animateTo '
            'is seamlessly suspended.',
        icon: Icons.pause_circle_filled,
        colour: Color(0xFF1D4E89),
      ),
      _UseCase(
        title: 'Custom gesture composition',
        body: 'When a touch could be a tap OR a drag, hold keeps the '
            'position still while you compute intent. Upgrade to a drag '
            'activity only if the slop is crossed.',
        icon: Icons.touch_app,
        colour: kBurnt,
      ),
    ];
    return _LabCard(
      title: '7. Common use cases',
      subtitle: 'Four recurring places where ScrollHoldController shows up.',
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints c) {
          final double w = c.maxWidth;
          final int cols = w > 900 ? 4 : (w > 560 ? 2 : 1);
          final double cardW = (w - 16 * (cols - 1)) / cols;
          return Wrap(
            spacing: 16,
            runSpacing: 16,
            children: <Widget>[
              for (final _UseCase u in cases)
                SizedBox(width: cardW, child: _UseCaseTile(useCase: u)),
            ],
          );
        },
      ),
    );
  }
}

class _UseCase {
  _UseCase({
    required this.title,
    required this.body,
    required this.icon,
    required this.colour,
  });
  final String title;
  final String body;
  final IconData icon;
  final Color colour;
}

class _UseCaseTile extends StatelessWidget {
  const _UseCaseTile({required this.useCase});
  final _UseCase useCase;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: useCase.colour.withValues(alpha: 0.35)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: useCase.colour.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: useCase.colour.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(useCase.icon, color: useCase.colour),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  useCase.title,
                  style: TextStyle(
                    color: useCase.colour,
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            useCase.body,
            style: const TextStyle(
              color: kCharcoal,
              fontSize: 13,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// Section 8 — Teaching panel
// =============================================================================

class _TeachingPanelSection extends StatelessWidget {
  const _TeachingPanelSection();

  @override
  Widget build(BuildContext context) {
    final List<_TeachingTile> tiles = <_TeachingTile>[
      _TeachingTile(
        heading: 'Hold vs jumpTo',
        body: 'ScrollHoldController preserves pixels and yields an '
            'idle-style frozen state that cooperates with the activity '
            'machinery. jumpTo teleports the position, produces '
            'notifications, and cannot be cancelled — it is not a "pause".',
        colour: kForest,
      ),
      _TeachingTile(
        heading: 'Always cancel()',
        body: 'A hold that is never cancelled lives forever, blocking '
            'every future drag, fling, or animateTo on that position. If '
            'you hold() on pointer down, ALWAYS cancel() on pointer up '
            '— including in error paths.',
        colour: kBurnt,
      ),
      _TeachingTile(
        heading: 'Who creates holds?',
        body: 'Most of the time, framework gesture code (Scrollable, '
            'drag recognizers) creates the ScrollHoldController for you. '
            'You typically only touch it directly inside custom '
            'recognizers or physics experiments.',
        colour: Color(0xFF1D4E89),
      ),
    ];
    return _LabCard(
      title: '8. Teaching notes',
      subtitle: 'Three conceptual traps worth internalising before using '
          'ScrollHoldController in anger.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          for (final _TeachingTile t in tiles) ...<Widget>[
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: t.colour.withValues(alpha: 0.08),
                border: Border(
                  left: BorderSide(color: t.colour, width: 4),
                ),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    t.heading,
                    style: TextStyle(
                      color: t.colour,
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    t.body,
                    style: const TextStyle(
                      color: kCharcoal,
                      fontSize: 13.5,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _TeachingTile {
  _TeachingTile({
    required this.heading,
    required this.body,
    required this.colour,
  });
  final String heading;
  final String body;
  final Color colour;
}

// =============================================================================
// Section 9 — Code snippet panel
// =============================================================================

class _CodeSnippetSection extends StatelessWidget {
  const _CodeSnippetSection();

  @override
  Widget build(BuildContext context) {
    const String snippet = '''
// Canonical usage of ScrollHoldController inside a custom recognizer.
ScrollHoldController? _hold;

void _onPointerDown() {
  // Freeze any in-progress ballistic so the user feels that their
  // finger has "caught" the scroll. If something else pre-empts us,
  // our callback fires and we clean up the handle.
  _hold = _controller.position.hold(() {
    _hold = null;
  });
}

void _onPointerUp() {
  // Release the hold — if no drag was started, physics may now
  // install a BallisticScrollActivity to continue the fling.
  _hold?.cancel();
  _hold = null;
}

void _onPointerCancel() {
  // Defensive cleanup — never leak a live ScrollHoldController.
  _hold?.cancel();
  _hold = null;
}
''';
    return _LabCard(
      title: '9. Canonical code snippet',
      subtitle:
          'The pattern you will copy-paste roughly 95% of the time.',
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: kCharcoal,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: kSlate, width: 1),
        ),
        child: SelectableText(
          snippet,
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 13,
            color: Color(0xFFE8EDDF),
            height: 1.5,
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// Section 10 — Footer summary card
// =============================================================================

class _FooterSummarySection extends StatelessWidget {
  const _FooterSummarySection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[kCharcoal, Color(0xFF2E3033)],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: kForest.withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.bookmark_border, color: kCream),
              ),
              const SizedBox(width: 12),
              const Text(
                'ScrollHoldController — in one breath',
                style: TextStyle(
                  color: kCream,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            'A one-method handle (cancel()) on a HoldScrollActivity that '
            'freezes the ScrollPosition mid-ballistic, preserves pixels, '
            'and waits for the owning gesture to resolve — either releasing '
            'back to physics, evolving into a drag, or being pre-empted by '
            'another activity (which invokes your holdCancelCallback).',
            style: TextStyle(
              color: kCream.withValues(alpha: 0.85),
              fontSize: 14,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: const <Widget>[
              _TagChip(text: 'hold()', colour: Color(0xFFE07A1F)),
              _TagChip(text: 'cancel()', colour: kForest),
              _TagChip(text: 'HoldScrollActivity', colour: Color(0xFF1D4E89)),
              _TagChip(text: 'holdCancelCallback', colour: kBurnt),
              _TagChip(text: 'ScrollPosition', colour: kMist),
            ],
          ),
        ],
      ),
    );
  }
}

class _TagChip extends StatelessWidget {
  const _TagChip({required this.text, required this.colour});
  final String text;
  final Color colour;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: colour.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: colour.withValues(alpha: 0.55)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: colour,
          fontFamily: 'monospace',
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

// =============================================================================
// Shared card wrapper
// =============================================================================

class _LabCard extends StatelessWidget {
  const _LabCard({
    required this.title,
    required this.subtitle,
    required this.child,
  });
  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: kMist),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: kCharcoal.withValues(alpha: 0.06),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              color: kCharcoal,
              fontSize: 22,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.4,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: TextStyle(
              color: kCharcoal.withValues(alpha: 0.7),
              fontSize: 14,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 18),
          child,
        ],
      ),
    );
  }
}
