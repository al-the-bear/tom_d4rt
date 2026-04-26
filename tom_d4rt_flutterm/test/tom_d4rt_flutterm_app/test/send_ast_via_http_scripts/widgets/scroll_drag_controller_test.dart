// D4rt test script: Deep Visual Demo — ScrollDragController
// ===========================================================
// ScrollDragController is the internal `Drag` implementation
// that a `ScrollPosition` builds whenever a pointer begins a
// scroll gesture. It owns no widget; it is a plain controller
// that receives DragUpdateDetails / DragEndDetails / cancel()
// from the scroll gesture recognizer and forwards the distilled
// motion to `ScrollPosition.applyUserOffset`. When the finger
// lifts, it asks the position to `goBallistic(velocity)` so a
// BallisticScrollActivity can take over with a deceleration
// simulation. In short: finger -> gesture recognizer ->
// ScrollDragController -> ScrollPosition -> ScrollActivity.
//
// This script cannot directly construct a ScrollDragController
// because it depends on package-private ScrollActivityDelegate
// plumbing. Instead we do two things simultaneously:
//   1) Run a real Scrollable and observe the notifications it
//      emits while an internal ScrollDragController is being
//      created, updated and torn down beneath the surface.
//   2) Operate a parallel pedagogical `_PedagogicalDrag` plain
//      Dart class that mirrors the Drag interface (update /
//      end / cancel) so readers can see the exact shape of
//      the API the framework uses behind the scenes.
//
// The app is one tall ScrollView with ten numbered sections
// covering hero, live drag canvas, lifecycle diagram, real
// ListView telemetry, pedagogical drag class, DragUpdate /
// DragEnd details inspector, velocity->ballistic bands, prose
// teaching, reference cards and a closing footer.

import 'package:flutter/material.dart';

// ---------------------------------------------------------------
// Colour palette. We keep these at the top so every section can
// refer to the same indigo/amber/cream combination without
// relying on Theme-of(context) (d4rt harness friendly).
// ---------------------------------------------------------------

const Color _kIndigo = Color(0xFF4C51BF);
const Color _kIndigoDark = Color(0xFF322E76);
const Color _kIndigoMist = Color(0xFFE4E4FA);
const Color _kAmber = Color(0xFFF6AD55);
const Color _kAmberDeep = Color(0xFFB7791F);
const Color _kCream = Color(0xFFFDF6EC);
const Color _kInk = Color(0xFF1A202C);
const Color _kMuted = Color(0xFF4A5568);
const Color _kLine = Color(0xFFCBD5E0);
const Color _kSurface = Color(0xFFFFFBF2);

// ---------------------------------------------------------------
// Pedagogical Drag class. This class intentionally mirrors the
// real `Drag` interface (update / end / cancel) so students can
// see the methods a ScrollDragController actually implements. It
// is a plain Dart object — no widget lifecycle, no ticker — so
// we can drive it directly from the sandbox GestureDetector in
// section 5 and inspect its state in section 6.
// ---------------------------------------------------------------

class _PedagogicalDrag {
  _PedagogicalDrag({
    required this.startPosition,
    required this.onChange,
    required this.onFinalize,
  }) : currentPosition = startPosition,
       samples = <_DragSample>[
         _DragSample(
           offset: startPosition,
           delta: Offset.zero,
           timestamp: Duration.zero,
           kind: _DragSampleKind.start,
         ),
       ];

  final Offset startPosition;
  final void Function(_PedagogicalDrag drag) onChange;
  final void Function(_PedagogicalDrag drag, _DragOutcome outcome) onFinalize;

  Offset currentPosition;
  final List<_DragSample> samples;
  bool _finalized = false;

  // Mirrors ScrollDragController.update(DragUpdateDetails).
  // The real controller forwards delta through applyUserOffset.
  // Here we merely accumulate offsets and append to a log.
  void update(DragUpdateDetails details) {
    if (_finalized) {
      return;
    }
    currentPosition = currentPosition + details.delta;
    samples.add(
      _DragSample(
        offset: currentPosition,
        delta: details.delta,
        timestamp: details.sourceTimeStamp ?? Duration.zero,
        kind: _DragSampleKind.update,
      ),
    );
    debugPrint(
      'PedagogicalDrag.update delta=${details.delta} '
      'total=$currentPosition',
    );
    onChange(this);
  }

  // Mirrors ScrollDragController.end(DragEndDetails). The real
  // controller asks its ScrollPosition to goBallistic(velocity).
  void end(DragEndDetails details) {
    if (_finalized) {
      return;
    }
    _finalized = true;
    samples.add(
      _DragSample(
        offset: currentPosition,
        delta: Offset.zero,
        timestamp: Duration.zero,
        kind: _DragSampleKind.end,
      ),
    );
    debugPrint(
      'PedagogicalDrag.end velocity=${details.velocity.pixelsPerSecond}',
    );
    onFinalize(
      this,
      _DragOutcome(
        kind: _DragOutcomeKind.ballistic,
        velocity: details.velocity.pixelsPerSecond,
      ),
    );
  }

  // Mirrors ScrollDragController.cancel(). The real controller
  // tells the position to goIdle() and tosses the drag away.
  void cancel() {
    if (_finalized) {
      return;
    }
    _finalized = true;
    samples.add(
      _DragSample(
        offset: currentPosition,
        delta: Offset.zero,
        timestamp: Duration.zero,
        kind: _DragSampleKind.cancel,
      ),
    );
    debugPrint('PedagogicalDrag.cancel');
    onFinalize(
      this,
      const _DragOutcome(
        kind: _DragOutcomeKind.idle,
        velocity: Offset.zero,
      ),
    );
  }
}

enum _DragSampleKind { start, update, end, cancel }

enum _DragOutcomeKind { ballistic, idle }

class _DragSample {
  const _DragSample({
    required this.offset,
    required this.delta,
    required this.timestamp,
    required this.kind,
  });
  final Offset offset;
  final Offset delta;
  final Duration timestamp;
  final _DragSampleKind kind;
}

class _DragOutcome {
  const _DragOutcome({required this.kind, required this.velocity});
  final _DragOutcomeKind kind;
  final Offset velocity;
}

// ---------------------------------------------------------------
// Entry point — the d4rt AST harness expects a `build(context)`
// that returns a MaterialApp. No main(), no runApp().
// ---------------------------------------------------------------

dynamic build(BuildContext context) {
  debugPrint('ScrollDragController deep demo building');
  return const MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'ScrollDragController — anatomy',
    home: _AnatomyShell(),
  );
}

class _AnatomyShell extends StatelessWidget {
  const _AnatomyShell();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kCream,
      appBar: AppBar(
        backgroundColor: _kIndigo,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text('ScrollDragController · anatomy'),
        centerTitle: false,
      ),
      body: const _AnatomyBody(),
    );
  }
}

class _AnatomyBody extends StatelessWidget {
  const _AnatomyBody();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const <Widget>[
          _SectionHeader(
            index: 1,
            title: 'The bridge from finger to ScrollPosition',
          ),
          _HeroHeader(),
          SizedBox(height: 36),
          _SectionHeader(index: 2, title: 'Live drag visual canvas'),
          _LiveDragCanvasSection(),
          SizedBox(height: 36),
          _SectionHeader(index: 3, title: 'Lifecycle diagram'),
          _LifecycleDiagramSection(),
          SizedBox(height: 36),
          _SectionHeader(index: 4, title: 'Real ListView drag telemetry'),
          _RealListViewTelemetrySection(),
          SizedBox(height: 36),
          _SectionHeader(index: 5, title: 'Pedagogical _PedagogicalDrag'),
          _PedagogicalDragSection(),
          SizedBox(height: 36),
          _SectionHeader(index: 6, title: 'DragUpdate / DragEnd inspector'),
          _DetailsInspectorSection(),
          SizedBox(height: 36),
          _SectionHeader(index: 7, title: 'Velocity → ballistic transition'),
          _VelocityBallisticSection(),
          SizedBox(height: 36),
          _SectionHeader(index: 8, title: 'Teaching panel'),
          _TeachingPanelSection(),
          SizedBox(height: 36),
          _SectionHeader(index: 9, title: 'Reference card'),
          _ReferenceCardSection(),
          SizedBox(height: 36),
          _SectionHeader(index: 10, title: 'Footer summary'),
          _FooterSummaryCard(),
          SizedBox(height: 48),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------
// Shared section header. Includes a thin accent rule under the
// title so each section feels distinct while staying on brand.
// ---------------------------------------------------------------

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.index, required this.title});
  final int index;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: _kIndigo,
              shape: BoxShape.circle,
            ),
            child: Text(
              '$index',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 18,
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
                    color: _kIndigoDark,
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  height: 3,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        _kIndigo.withValues(alpha: 0.9),
                        _kAmber.withValues(alpha: 0.6),
                        _kCream,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(2),
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

// ---------------------------------------------------------------
// Section 1 — hero header. Decorative hand-built-from-Containers
// "finger" with a curved trailing arrow suggesting drag motion.
// ---------------------------------------------------------------

class _HeroHeader extends StatelessWidget {
  const _HeroHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _kIndigo.withValues(alpha: 0.12),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const _DecorativeFinger(),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'ScrollDragController',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: _kIndigoDark,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'the bridge from your finger to a ScrollPosition',
                  style: TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                    color: _kMuted,
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  children: const <Widget>[
                    _HeroBadge(label: 'implements Drag'),
                    SizedBox(width: 8),
                    _HeroBadge(label: 'owned by ScrollPosition'),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: const <Widget>[
                    _HeroBadge(label: 'routes to applyUserOffset'),
                    SizedBox(width: 8),
                    _HeroBadge(label: 'ends with goBallistic'),
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

class _DecorativeFinger extends StatelessWidget {
  const _DecorativeFinger();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140,
      height: 140,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 0,
            top: 36,
            child: Container(
              width: 60,
              height: 96,
              decoration: BoxDecoration(
                color: _kAmber.withValues(alpha: 0.85),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(28),
                  topRight: Radius.circular(28),
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
                border: Border.all(color: _kAmberDeep, width: 2),
              ),
            ),
          ),
          Positioned(
            left: 14,
            top: 18,
            child: Container(
              width: 32,
              height: 54,
              decoration: BoxDecoration(
                color: _kAmber,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: _kAmberDeep, width: 2),
              ),
            ),
          ),
          Positioned.fill(
            child: CustomPaint(painter: _HeroArrowPainter()),
          ),
          Positioned(
            right: 6,
            top: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: _kIndigo,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'drag',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = _kIndigo.withValues(alpha: 0.6)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path()
      ..moveTo(58, 70)
      ..cubicTo(90, 40, 110, 110, 132, 72);
    canvas.drawPath(path, paint);

    final tip = Path()
      ..moveTo(132, 72)
      ..lineTo(120, 64)
      ..moveTo(132, 72)
      ..lineTo(124, 84);
    canvas.drawPath(tip, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _HeroBadge extends StatelessWidget {
  const _HeroBadge({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: _kIndigoMist,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _kIndigo.withValues(alpha: 0.35)),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: _kIndigoDark,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------
// Section 2 — live drag visual canvas. A 400-wide GestureDetector
// records the pointer path on a CustomPaint, and every callback
// appends one entry to a side-by-side log so you can literally
// see Drag.update/end/cancel events as they happen.
// ---------------------------------------------------------------

class _LiveDragCanvasSection extends StatefulWidget {
  const _LiveDragCanvasSection();

  @override
  State<_LiveDragCanvasSection> createState() => _LiveDragCanvasSectionState();
}

class _LiveDragCanvasSectionState extends State<_LiveDragCanvasSection> {
  final List<Offset> _path = <Offset>[];
  final List<_LogRow> _log = <_LogRow>[];
  Offset? _fingerPosition;
  int _sequence = 0;

  void _logAdd(String event, Color color) {
    final row = _LogRow(
      index: ++_sequence,
      event: event,
      color: color,
      time: DateTime.now(),
    );
    _log.insert(0, row);
    if (_log.length > 20) {
      _log.removeLast();
    }
  }

  void _onPanStart(DragStartDetails details) {
    setState(() {
      _path.clear();
      _path.add(details.localPosition);
      _fingerPosition = details.localPosition;
      _logAdd(
        'onPanStart local=${_fmt(details.localPosition)}',
        _kIndigo,
      );
    });
  }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      _path.add(details.localPosition);
      _fingerPosition = details.localPosition;
      _logAdd(
        'onPanUpdate delta=${_fmt(details.delta)}',
        _kAmberDeep,
      );
    });
  }

  void _onPanEnd(DragEndDetails details) {
    setState(() {
      _fingerPosition = null;
      _logAdd(
        'onPanEnd v=${_fmt(details.velocity.pixelsPerSecond)} px/s',
        Colors.green.shade700,
      );
    });
  }

  void _onPanCancel() {
    setState(() {
      _fingerPosition = null;
      _logAdd('onPanCancel', Colors.redAccent);
    });
  }

  String _fmt(Offset o) {
    return '(${o.dx.toStringAsFixed(1)}, ${o.dy.toStringAsFixed(1)})';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _kLine),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Drag on the canvas. Every Drag.update delta is drawn '
            'as part of the path and logged on the right — that is '
            'the same firehose of deltas that a real ScrollDrag'
            'Controller would hand to ScrollPosition.applyUserOffset.',
            style: TextStyle(color: _kMuted, height: 1.4),
          ),
          const SizedBox(height: 12),
          LayoutBuilder(
            builder: (context, constraints) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: 400,
                    height: 260,
                    child: GestureDetector(
                      onPanStart: _onPanStart,
                      onPanUpdate: _onPanUpdate,
                      onPanEnd: _onPanEnd,
                      onPanCancel: _onPanCancel,
                      child: Container(
                        decoration: BoxDecoration(
                          color: _kIndigoMist.withValues(alpha: 0.6),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: _kIndigo.withValues(alpha: 0.35),
                            width: 1.5,
                          ),
                        ),
                        child: CustomPaint(
                          painter: _FingerPathPainter(
                            path: _path,
                            finger: _fingerPosition,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(child: _LogPanel(rows: _log)),
                ],
              );
            },
          ),
          const SizedBox(height: 10),
          Row(
            children: <Widget>[
              const Text(
                'path samples: ',
                style: TextStyle(color: _kMuted, fontSize: 12),
              ),
              Text(
                '${_path.length}',
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: _kIndigoDark,
                ),
              ),
              const SizedBox(width: 20),
              const Text(
                'log rows: ',
                style: TextStyle(color: _kMuted, fontSize: 12),
              ),
              Text(
                '${_log.length}',
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: _kIndigoDark,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _LogRow {
  const _LogRow({
    required this.index,
    required this.event,
    required this.color,
    required this.time,
  });
  final int index;
  final String event;
  final Color color;
  final DateTime time;
}

class _LogPanel extends StatelessWidget {
  const _LogPanel({required this.rows});
  final List<_LogRow> rows;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1F36),
        borderRadius: BorderRadius.circular(10),
      ),
      child: rows.isEmpty
          ? const Center(
              child: Text(
                'drag the canvas to populate the event log',
                style: TextStyle(
                  color: Color(0xFFA0AEC0),
                  fontFamily: 'monospace',
                  fontSize: 12,
                ),
              ),
            )
          : ListView.builder(
              reverse: false,
              itemCount: rows.length,
              itemBuilder: (context, i) {
                final row = rows[i];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 26,
                        alignment: Alignment.centerRight,
                        child: Text(
                          '${row.index}',
                          style: const TextStyle(
                            color: Color(0xFF718096),
                            fontFamily: 'monospace',
                            fontSize: 11,
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        width: 6,
                        height: 14,
                        margin: const EdgeInsets.only(top: 2),
                        decoration: BoxDecoration(
                          color: row.color,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          row.event,
                          style: TextStyle(
                            color: row.color,
                            fontFamily: 'monospace',
                            fontSize: 11.5,
                            height: 1.3,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}

class _FingerPathPainter extends CustomPainter {
  _FingerPathPainter({required this.path, required this.finger});
  final List<Offset> path;
  final Offset? finger;

  @override
  void paint(Canvas canvas, Size size) {
    // Grid.
    final grid = Paint()
      ..color = _kIndigo.withValues(alpha: 0.08)
      ..strokeWidth = 1;
    for (double x = 0; x < size.width; x += 20) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
    }
    for (double y = 0; y < size.height; y += 20) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }

    // Path stroke.
    if (path.length >= 2) {
      final stroke = Paint()
        ..color = _kIndigo
        ..strokeWidth = 3
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round;
      final p = Path()..moveTo(path.first.dx, path.first.dy);
      for (int i = 1; i < path.length; i++) {
        p.lineTo(path[i].dx, path[i].dy);
      }
      canvas.drawPath(p, stroke);

      // Amber tail gradient on the last third of the path.
      final tailStart = (path.length * 2 / 3).floor();
      if (tailStart < path.length - 1) {
        final tailPaint = Paint()
          ..color = _kAmber
          ..strokeWidth = 5
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round;
        final tail = Path()
          ..moveTo(path[tailStart].dx, path[tailStart].dy);
        for (int i = tailStart + 1; i < path.length; i++) {
          tail.lineTo(path[i].dx, path[i].dy);
        }
        canvas.drawPath(tail, tailPaint);
      }
    }

    // Finger dot.
    final f = finger;
    if (f != null) {
      canvas.drawCircle(
        f,
        14,
        Paint()..color = _kAmber.withValues(alpha: 0.35),
      );
      canvas.drawCircle(
        f,
        7,
        Paint()..color = _kAmber,
      );
      canvas.drawCircle(
        f,
        7,
        Paint()
          ..color = _kAmberDeep
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _FingerPathPainter old) {
    return old.path != path || old.finger != finger;
  }
}

// ---------------------------------------------------------------
// Section 3 — lifecycle diagram. Four phase cards stacked with
// connector arrows drawn via a background CustomPaint. Shows:
//   (a) ScrollPosition.drag() returns ScrollDragController
//   (b) applyUserOffset per update
//   (c) goBallistic(velocity) on end
//   (d) position.goIdle() on cancel
// ---------------------------------------------------------------

class _LifecycleDiagramSection extends StatelessWidget {
  const _LifecycleDiagramSection();

  @override
  Widget build(BuildContext context) {
    final phases = <_LifecyclePhase>[
      const _LifecyclePhase(
        tag: 'a',
        title: 'ScrollPosition.drag()',
        body: 'A scroll gesture begins. ScrollPositionWithSingle'
            'Context.drag(DragStartDetails, onCancel) constructs a '
            'ScrollDragController, attaches itself as the delegate '
            'and returns the controller to the scroll recognizer.',
        accent: _kIndigo,
      ),
      const _LifecyclePhase(
        tag: 'b',
        title: 'update → applyUserOffset',
        body: 'The recognizer feeds DragUpdateDetails into '
            'ScrollDragController.update(). The controller tweaks '
            'the delta (direction, carried momentum) and forwards '
            'it to ScrollPosition.applyUserOffset(delta).',
        accent: _kAmberDeep,
      ),
      const _LifecyclePhase(
        tag: 'c',
        title: 'end → goBallistic',
        body: 'When the finger lifts, the recognizer calls '
            'ScrollDragController.end(DragEndDetails). The controller '
            'asks the position to goBallistic(velocity). A '
            'BallisticScrollActivity takes over with a decelerating '
            'simulation.',
        accent: Color(0xFF38A169),
      ),
      const _LifecyclePhase(
        tag: 'd',
        title: 'cancel → goIdle',
        body: 'If the gesture is interrupted (scroll accepted by a '
            'different recognizer, pointer cancelled), ScrollDrag'
            'Controller.cancel() fires. The position transitions to '
            'an IdleScrollActivity and the drag object is disposed.',
        accent: Color(0xFFE53E3E),
      ),
    ];

    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: IgnorePointer(
            child: CustomPaint(painter: _LifecycleArrowPainter()),
          ),
        ),
        Column(
          children: <Widget>[
            for (int i = 0; i < phases.length; i++) ...<Widget>[
              _LifecyclePhaseCard(phase: phases[i]),
              if (i != phases.length - 1) const SizedBox(height: 18),
            ],
          ],
        ),
      ],
    );
  }
}

class _LifecyclePhase {
  const _LifecyclePhase({
    required this.tag,
    required this.title,
    required this.body,
    required this.accent,
  });
  final String tag;
  final String title;
  final String body;
  final Color accent;
}

class _LifecyclePhaseCard extends StatelessWidget {
  const _LifecyclePhaseCard({required this.phase});
  final _LifecyclePhase phase;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: phase.accent.withValues(alpha: 0.4),
          width: 1.5,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 42,
            height: 42,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: phase.accent,
              shape: BoxShape.circle,
            ),
            child: Text(
              phase.tag.toUpperCase(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  phase.title,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: phase.accent,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  phase.body,
                  style: const TextStyle(
                    fontSize: 13,
                    color: _kInk,
                    height: 1.45,
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

class _LifecycleArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = _kIndigo.withValues(alpha: 0.15)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    // Decorative vertical guide just inside the left edge.
    canvas.drawLine(
      const Offset(22, 0),
      Offset(22, size.height),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ---------------------------------------------------------------
// Section 4 — real ListView with drag telemetry. A NotificationL-
// istener wraps a real Scrollable so we can see the high-level
// scroll notifications that correspond to the internal ScrollDrag-
// Controller's lifecycle.
// ---------------------------------------------------------------

class _RealListViewTelemetrySection extends StatefulWidget {
  const _RealListViewTelemetrySection();

  @override
  State<_RealListViewTelemetrySection> createState() =>
      _RealListViewTelemetrySectionState();
}

class _RealListViewTelemetrySectionState
    extends State<_RealListViewTelemetrySection> {
  final List<_Telemetry> _events = <_Telemetry>[];
  int _startCount = 0;
  int _updateCount = 0;
  int _endCount = 0;

  bool _onNotification(ScrollNotification n) {
    setState(() {
      if (n is ScrollStartNotification) {
        _startCount++;
        _events.insert(
          0,
          _Telemetry(
            label: 'ScrollStart',
            detail: 'ScrollDragController created · '
                'pixels=${n.metrics.pixels.toStringAsFixed(1)}',
            color: _kIndigo,
          ),
        );
      } else if (n is ScrollUpdateNotification) {
        _updateCount++;
        _events.insert(
          0,
          _Telemetry(
            label: 'ScrollUpdate',
            detail: 'applyUserOffset · '
                'delta=${(n.scrollDelta ?? 0).toStringAsFixed(1)} · '
                'pixels=${n.metrics.pixels.toStringAsFixed(1)}',
            color: _kAmberDeep,
          ),
        );
      } else if (n is ScrollEndNotification) {
        _endCount++;
        _events.insert(
          0,
          _Telemetry(
            label: 'ScrollEnd',
            detail: 'drag.end / ballistic lifted · '
                'pixels=${n.metrics.pixels.toStringAsFixed(1)}',
            color: Colors.green.shade700,
          ),
        );
      } else if (n is OverscrollNotification) {
        _events.insert(
          0,
          _Telemetry(
            label: 'Overscroll',
            detail: 'overscroll=${n.overscroll.toStringAsFixed(2)}',
            color: Colors.redAccent,
          ),
        );
      }
      if (_events.length > 30) {
        _events.removeLast();
      }
    });
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _kLine),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Scroll the 40-item ListView below. Each start/update/end '
            'notification corresponds to a ScrollDragController '
            'lifecycle event inside the scroll position.',
            style: TextStyle(color: _kMuted, height: 1.4),
          ),
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              _CounterChip(
                label: 'start',
                value: _startCount,
                color: _kIndigo,
              ),
              const SizedBox(width: 8),
              _CounterChip(
                label: 'update',
                value: _updateCount,
                color: _kAmberDeep,
              ),
              const SizedBox(width: 8),
              _CounterChip(
                label: 'end',
                value: _endCount,
                color: Colors.green.shade700,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: 260,
                height: 320,
                child: NotificationListener<ScrollNotification>(
                  onNotification: _onNotification,
                  child: Container(
                    decoration: BoxDecoration(
                      color: _kIndigoMist.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: _kLine),
                    ),
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: 40,
                      itemBuilder: (context, i) {
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: i.isEven
                                ? Colors.white
                                : _kCream,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: _kLine),
                          ),
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 28,
                                height: 28,
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                  color: _kIndigo,
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  '$i',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  'tile $i — scroll me to hear '
                                  'the ScrollDragController',
                                  style: const TextStyle(fontSize: 13),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Container(
                  height: 320,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFF16213E),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: _events.isEmpty
                      ? const Center(
                          child: Text(
                            'scroll the list to populate telemetry',
                            style: TextStyle(
                              color: Color(0xFF94A3B8),
                              fontFamily: 'monospace',
                              fontSize: 12,
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: _events.length,
                          itemBuilder: (context, i) {
                            final e = _events[i];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 6),
                              child: Row(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 6,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: e.color.withValues(alpha: 0.25),
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(color: e.color),
                                    ),
                                    child: Text(
                                      e.label,
                                      style: TextStyle(
                                        color: e.color,
                                        fontFamily: 'monospace',
                                        fontSize: 10.5,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      e.detail,
                                      style: const TextStyle(
                                        color: Color(0xFFE2E8F0),
                                        fontFamily: 'monospace',
                                        fontSize: 11,
                                        height: 1.4,
                                      ),
                                    ),
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
        ],
      ),
    );
  }
}

class _Telemetry {
  const _Telemetry({
    required this.label,
    required this.detail,
    required this.color,
  });
  final String label;
  final String detail;
  final Color color;
}

class _CounterChip extends StatelessWidget {
  const _CounterChip({
    required this.label,
    required this.value,
    required this.color,
  });
  final String label;
  final int value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            '$value',
            style: TextStyle(
              color: color,
              fontFamily: 'monospace',
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------
// Section 5 — the pedagogical _PedagogicalDrag sandbox. This uses
// the plain Dart class defined at the top of this file. A Gesture-
// Detector drives `update`/`end`/`cancel` directly, so readers
// can see the API surface of a ScrollDragController in isolation.
// ---------------------------------------------------------------

class _PedagogicalDragSection extends StatefulWidget {
  const _PedagogicalDragSection();

  @override
  State<_PedagogicalDragSection> createState() =>
      _PedagogicalDragSectionState();
}

class _PedagogicalDragSectionState extends State<_PedagogicalDragSection> {
  _PedagogicalDrag? _active;
  final List<_PedagogicalDrag> _history = <_PedagogicalDrag>[];
  DragUpdateDetails? _lastUpdate;
  DragEndDetails? _lastEnd;
  _DragOutcome? _lastOutcome;

  void _onPanDown(DragDownDetails details) {
    setState(() {
      _active = _PedagogicalDrag(
        startPosition: details.localPosition,
        onChange: (d) {
          setState(() {
            // Force rebuild while dragging.
          });
        },
        onFinalize: (d, outcome) {
          setState(() {
            _history.insert(0, d);
            if (_history.length > 6) {
              _history.removeLast();
            }
            _lastOutcome = outcome;
            _active = null;
          });
        },
      );
    });
  }

  void _onPanUpdate(DragUpdateDetails details) {
    _lastUpdate = details;
    _active?.update(details);
  }

  void _onPanEnd(DragEndDetails details) {
    _lastEnd = details;
    _active?.end(details);
  }

  void _onPanCancel() {
    _active?.cancel();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _kLine),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            '_PedagogicalDrag mirrors the real Drag interface from '
            'package:flutter/gestures.dart. Drag inside the box to '
            'invoke update/end/cancel on a real instance and watch '
            'its internal samples grow.',
            style: TextStyle(color: _kMuted, height: 1.4),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: 320,
                height: 240,
                child: GestureDetector(
                  onPanDown: _onPanDown,
                  onPanUpdate: _onPanUpdate,
                  onPanEnd: _onPanEnd,
                  onPanCancel: _onPanCancel,
                  child: Container(
                    decoration: BoxDecoration(
                      color: _kCream,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: _kAmber,
                        width: 1.8,
                      ),
                    ),
                    child: CustomPaint(
                      painter: _PedagogicalPainter(active: _active),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(child: _PedagogicalStatePanel(active: _active)),
            ],
          ),
          const SizedBox(height: 14),
          if (_lastOutcome != null)
            _OutcomeBanner(
              outcome: _lastOutcome!,
              lastUpdate: _lastUpdate,
              lastEnd: _lastEnd,
            ),
          const SizedBox(height: 14),
          const Text(
            'Finalized drags (last 6):',
            style: TextStyle(
              color: _kIndigoDark,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          if (_history.isEmpty)
            const Text(
              'no drags recorded yet',
              style: TextStyle(color: _kMuted, fontStyle: FontStyle.italic),
            )
          else
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                for (final d in _history) _HistoryChip(drag: d),
              ],
            ),
        ],
      ),
    );
  }
}

class _PedagogicalPainter extends CustomPainter {
  _PedagogicalPainter({required this.active});
  final _PedagogicalDrag? active;

  @override
  void paint(Canvas canvas, Size size) {
    // Background grid.
    final grid = Paint()
      ..color = _kAmber.withValues(alpha: 0.1)
      ..strokeWidth = 1;
    for (double x = 0; x < size.width; x += 16) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
    }
    for (double y = 0; y < size.height; y += 16) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }

    final d = active;
    if (d == null || d.samples.isEmpty) {
      return;
    }

    // Draw sample points as the drag grows.
    final linePaint = Paint()
      ..color = _kAmberDeep
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    if (d.samples.length >= 2) {
      final p = Path()
        ..moveTo(d.samples.first.offset.dx, d.samples.first.offset.dy);
      for (int i = 1; i < d.samples.length; i++) {
        p.lineTo(d.samples[i].offset.dx, d.samples[i].offset.dy);
      }
      canvas.drawPath(p, linePaint);
    }
    for (final s in d.samples) {
      final c = s.kind == _DragSampleKind.start
          ? _kIndigo
          : s.kind == _DragSampleKind.update
              ? _kAmber
              : Colors.green;
      canvas.drawCircle(s.offset, 3, Paint()..color = c);
    }
    canvas.drawCircle(
      d.currentPosition,
      10,
      Paint()..color = _kAmber.withValues(alpha: 0.35),
    );
    canvas.drawCircle(
      d.currentPosition,
      5,
      Paint()..color = _kAmberDeep,
    );
  }

  @override
  bool shouldRepaint(covariant _PedagogicalPainter old) => true;
}

class _PedagogicalStatePanel extends StatelessWidget {
  const _PedagogicalStatePanel({required this.active});
  final _PedagogicalDrag? active;

  @override
  Widget build(BuildContext context) {
    final d = active;
    return Container(
      height: 240,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(10),
      ),
      child: d == null
          ? const Center(
              child: Text(
                'no active _PedagogicalDrag',
                style: TextStyle(
                  color: Color(0xFF94A3B8),
                  fontFamily: 'monospace',
                ),
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'active _PedagogicalDrag',
                  style: TextStyle(
                    color: Color(0xFFF59E0B),
                    fontFamily: 'monospace',
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                _monoLine('start', _fmtOffset(d.startPosition)),
                _monoLine('current', _fmtOffset(d.currentPosition)),
                _monoLine('samples', '${d.samples.length}'),
                const SizedBox(height: 10),
                const Text(
                  'last 6 samples:',
                  style: TextStyle(
                    color: Color(0xFFE2E8F0),
                    fontFamily: 'monospace',
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 4),
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    itemCount: d.samples.length > 6 ? 6 : d.samples.length,
                    itemBuilder: (context, i) {
                      final s = d.samples[d.samples.length - 1 - i];
                      return Text(
                        '${s.kind.name.padRight(7)} '
                        '${_fmtOffset(s.offset)} '
                        'Δ${_fmtOffset(s.delta)}',
                        style: const TextStyle(
                          color: Color(0xFFCBD5E1),
                          fontFamily: 'monospace',
                          fontSize: 11,
                          height: 1.35,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }

  Widget _monoLine(String k, String v) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 72,
            child: Text(
              k,
              style: const TextStyle(
                color: Color(0xFF94A3B8),
                fontFamily: 'monospace',
                fontSize: 11.5,
              ),
            ),
          ),
          Text(
            v,
            style: const TextStyle(
              color: Color(0xFFF8FAFC),
              fontFamily: 'monospace',
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  static String _fmtOffset(Offset o) {
    return '(${o.dx.toStringAsFixed(1)},${o.dy.toStringAsFixed(1)})';
  }
}

class _OutcomeBanner extends StatelessWidget {
  const _OutcomeBanner({
    required this.outcome,
    required this.lastUpdate,
    required this.lastEnd,
  });
  final _DragOutcome outcome;
  final DragUpdateDetails? lastUpdate;
  final DragEndDetails? lastEnd;

  @override
  Widget build(BuildContext context) {
    final isBallistic = outcome.kind == _DragOutcomeKind.ballistic;
    final color = isBallistic ? _kIndigo : Colors.redAccent;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Row(
        children: <Widget>[
          Icon(
            isBallistic ? Icons.rocket_launch : Icons.pause_circle_filled,
            color: color,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              isBallistic
                  ? 'Last drag ended. Position would goBallistic'
                    '(${outcome.velocity.dx.toStringAsFixed(1)}, '
                    '${outcome.velocity.dy.toStringAsFixed(1)} px/s).'
                  : 'Last drag was cancelled. Position would goIdle().',
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HistoryChip extends StatelessWidget {
  const _HistoryChip({required this.drag});
  final _PedagogicalDrag drag;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: _kIndigoMist,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kIndigo.withValues(alpha: 0.5)),
      ),
      child: Text(
        '${drag.samples.length} samples',
        style: const TextStyle(
          color: _kIndigoDark,
          fontFamily: 'monospace',
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------
// Section 6 — DragUpdateDetails / DragEndDetails inspector. Two
// cards side by side surface the fields of the data classes fed
// to Drag.update() and Drag.end(). Values update live as the user
// drags the small "inspector canvas" below.
// ---------------------------------------------------------------

class _DetailsInspectorSection extends StatefulWidget {
  const _DetailsInspectorSection();

  @override
  State<_DetailsInspectorSection> createState() =>
      _DetailsInspectorSectionState();
}

class _DetailsInspectorSectionState extends State<_DetailsInspectorSection> {
  DragUpdateDetails? _lastUpdate;
  DragEndDetails? _lastEnd;
  DragStartDetails? _lastStart;
  int _updateCount = 0;

  void _onPanStart(DragStartDetails details) {
    setState(() {
      _lastStart = details;
      _lastEnd = null;
      _updateCount = 0;
    });
  }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      _lastUpdate = details;
      _updateCount++;
    });
  }

  void _onPanEnd(DragEndDetails details) {
    setState(() {
      _lastEnd = details;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _kLine),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'These are the exact data classes passed into Drag.update '
            'and Drag.end. Drag the strip below to watch them update.',
            style: TextStyle(color: _kMuted, height: 1.4),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 70,
            child: GestureDetector(
              onPanStart: _onPanStart,
              onPanUpdate: _onPanUpdate,
              onPanEnd: _onPanEnd,
              child: Container(
                decoration: BoxDecoration(
                  color: _kAmber.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: _kAmber),
                ),
                child: const Center(
                  child: Text(
                    'drag here horizontally or vertically',
                    style: TextStyle(
                      color: _kAmberDeep,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: _DetailsCard(
                  title: 'DragUpdateDetails',
                  color: _kIndigo,
                  rows: <_DetailsRow>[
                    _DetailsRow(
                      'delta',
                      _fmtOffset(_lastUpdate?.delta),
                    ),
                    _DetailsRow(
                      'primaryDelta',
                      _fmtDouble(_lastUpdate?.primaryDelta),
                    ),
                    _DetailsRow(
                      'globalPosition',
                      _fmtOffset(_lastUpdate?.globalPosition),
                    ),
                    _DetailsRow(
                      'localPosition',
                      _fmtOffset(_lastUpdate?.localPosition),
                    ),
                    _DetailsRow(
                      'sourceTimeStamp',
                      _fmtDuration(_lastUpdate?.sourceTimeStamp),
                    ),
                    _DetailsRow('updateCount', '$_updateCount'),
                  ],
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: _DetailsCard(
                  title: 'DragEndDetails',
                  color: _kAmberDeep,
                  rows: <_DetailsRow>[
                    _DetailsRow(
                      'velocity.pixelsPerSecond',
                      _fmtOffset(_lastEnd?.velocity.pixelsPerSecond),
                    ),
                    _DetailsRow(
                      'primaryVelocity',
                      _fmtDouble(_lastEnd?.primaryVelocity),
                    ),
                    _DetailsRow(
                      'globalPosition',
                      _fmtOffset(_lastEnd?.globalPosition),
                    ),
                    _DetailsRow(
                      'localPosition',
                      _fmtOffset(_lastEnd?.localPosition),
                    ),
                    _DetailsRow(
                      'start.globalPosition',
                      _fmtOffset(_lastStart?.globalPosition),
                    ),
                    _DetailsRow(
                      'start.kind',
                      _lastStart?.kind?.toString() ?? '—',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _fmtOffset(Offset? o) {
    if (o == null) {
      return '—';
    }
    return '(${o.dx.toStringAsFixed(1)}, ${o.dy.toStringAsFixed(1)})';
  }

  String _fmtDouble(double? d) {
    if (d == null) {
      return '—';
    }
    return d.toStringAsFixed(2);
  }

  String _fmtDuration(Duration? d) {
    if (d == null) {
      return '—';
    }
    return '${d.inMicroseconds}µs';
  }
}

class _DetailsRow {
  const _DetailsRow(this.k, this.v);
  final String k;
  final String v;
}

class _DetailsCard extends StatelessWidget {
  const _DetailsCard({
    required this.title,
    required this.color,
    required this.rows,
  });
  final String title;
  final Color color;
  final List<_DetailsRow> rows;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.45)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.data_object, color: color, size: 18),
              const SizedBox(width: 6),
              Text(
                title,
                style: TextStyle(
                  color: color,
                  fontFamily: 'monospace',
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          for (final row in rows)
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: 130,
                    child: Text(
                      row.k,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11.5,
                        color: _kMuted,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      row.v,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12,
                        color: _kInk,
                        fontWeight: FontWeight.w700,
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

// ---------------------------------------------------------------
// Section 7 — velocity -> ballistic transition. Three static
// "lanes" with example release velocities (200, 800, 2400 px/s)
// each drawing a sparkline-style decaying curve to suggest the
// ballistic simulation duration.
// ---------------------------------------------------------------

class _VelocityBallisticSection extends StatelessWidget {
  const _VelocityBallisticSection();

  @override
  Widget build(BuildContext context) {
    final lanes = <_VelocityLane>[
      const _VelocityLane(
        velocity: 200,
        duration: 0.6,
        label: 'gentle',
        color: Color(0xFF38A169),
      ),
      const _VelocityLane(
        velocity: 800,
        duration: 1.4,
        label: 'confident',
        color: _kIndigo,
      ),
      const _VelocityLane(
        velocity: 2400,
        duration: 2.8,
        label: 'fling',
        color: _kAmberDeep,
      ),
    ];
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _kLine),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'When ScrollDragController.end(DragEndDetails) is called, '
            'the release velocity determines how long the subsequent '
            'BallisticScrollActivity runs.',
            style: TextStyle(color: _kMuted, height: 1.4),
          ),
          const SizedBox(height: 14),
          for (final lane in lanes) ...<Widget>[
            _VelocityLaneWidget(lane: lane),
            const SizedBox(height: 14),
          ],
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _kIndigoMist.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'Duration values here are illustrative. Actual timing '
              'depends on the ScrollPhysics (ClampingScrollSimulation '
              'vs BouncingScrollSimulation) and the platform.',
              style: TextStyle(
                color: _kIndigoDark,
                fontSize: 12,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _VelocityLane {
  const _VelocityLane({
    required this.velocity,
    required this.duration,
    required this.label,
    required this.color,
  });
  final double velocity;
  final double duration;
  final String label;
  final Color color;
}

class _VelocityLaneWidget extends StatelessWidget {
  const _VelocityLaneWidget({required this.lane});
  final _VelocityLane lane;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 120,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                lane.label,
                style: TextStyle(
                  color: lane.color,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                '${lane.velocity.toStringAsFixed(0)} px/s',
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                  color: _kInk,
                ),
              ),
              Text(
                '${lane.duration.toStringAsFixed(1)}s',
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                  color: _kMuted,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            height: 64,
            decoration: BoxDecoration(
              color: lane.color.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: lane.color.withValues(alpha: 0.4)),
            ),
            child: CustomPaint(painter: _BallisticCurvePainter(lane: lane)),
          ),
        ),
      ],
    );
  }
}

class _BallisticCurvePainter extends CustomPainter {
  _BallisticCurvePainter({required this.lane});
  final _VelocityLane lane;

  @override
  void paint(Canvas canvas, Size size) {
    final stroke = Paint()
      ..color = lane.color
      ..strokeWidth = 2.4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final fill = Paint()
      ..color = lane.color.withValues(alpha: 0.18)
      ..style = PaintingStyle.fill;

    final p = Path();
    final h = size.height;
    final w = size.width;
    final steps = 80;
    // Decaying exponential-ish deceleration: y = amplitude * e^(-t*k).
    final amplitude = (lane.velocity / 2400).clamp(0.1, 1.0);
    final kDecay = 4.0 / lane.duration;
    p.moveTo(0, h);
    for (int i = 0; i <= steps; i++) {
      final t = i / steps;
      final seconds = t * lane.duration;
      final y = h -
          amplitude *
              h *
              0.9 *
              _exp(-kDecay * seconds);
      p.lineTo(t * w, y);
    }
    p.lineTo(w, h);
    p.close();
    canvas.drawPath(p, fill);

    final stroked = Path();
    for (int i = 0; i <= steps; i++) {
      final t = i / steps;
      final seconds = t * lane.duration;
      final y = h -
          amplitude *
              h *
              0.9 *
              _exp(-kDecay * seconds);
      if (i == 0) {
        stroked.moveTo(0, y);
      } else {
        stroked.lineTo(t * w, y);
      }
    }
    canvas.drawPath(stroked, stroke);

    // Start marker (finger release).
    canvas.drawCircle(
      Offset(0, h - amplitude * h * 0.9),
      4,
      Paint()..color = lane.color,
    );
    // End marker (scroll at rest).
    canvas.drawCircle(
      Offset(w, h),
      4,
      Paint()
        ..color = lane.color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );
  }

  double _exp(double x) {
    // Manual Maclaurin-ish approximation so the painter has no
    // dependency on dart:math; fine for a decorative curve.
    double result = 1.0;
    double term = 1.0;
    for (int i = 1; i < 12; i++) {
      term = term * x / i;
      result += term;
    }
    return result;
  }

  @override
  bool shouldRepaint(covariant _BallisticCurvePainter old) {
    return old.lane.velocity != lane.velocity ||
        old.lane.duration != lane.duration;
  }
}

// ---------------------------------------------------------------
// Section 8 — teaching panel. Prose tiles with the headline rule
// that you don't usually instantiate ScrollDragController directly.
// ---------------------------------------------------------------

class _TeachingPanelSection extends StatelessWidget {
  const _TeachingPanelSection();

  @override
  Widget build(BuildContext context) {
    final tiles = <_TeachingTile>[
      const _TeachingTile(
        icon: Icons.do_not_disturb_on_outlined,
        title: "don't instantiate it yourself",
        body: 'ScrollDragController has package-private constructor '
            'arguments. Only a ScrollPosition can meaningfully build '
            'one. Reach for it only when implementing custom '
            'ScrollPosition/ScrollActivityDelegate pairs.',
        tone: Color(0xFFE53E3E),
      ),
      _TeachingTile(
        icon: Icons.view_module,
        title: 'interact via ScrollController / notifications',
        body: 'In almost every app, ScrollController and '
            'NotificationListener<ScrollNotification> are enough. '
            'They expose the observable side of the Drag controller '
            'without requiring you to implement Drag yourself.',
        tone: _kIndigo,
      ),
      _TeachingTile(
        icon: Icons.build_circle,
        title: 'custom drag? use a recognizer + applyUserOffset',
        body: 'If you need a hand-rolled drag gesture (e.g. a custom '
            'dismissible row), pair a VerticalDragGestureRecognizer '
            'with ScrollPosition.applyUserOffset — far simpler than '
            'owning a ScrollDragController.',
        tone: _kAmberDeep,
      ),
      const _TeachingTile(
        icon: Icons.call_split,
        title: 'Drag is one of many activities',
        body: 'ScrollDragController drives a DragScrollActivity. When '
            'the finger lifts, control passes to a BallisticScroll'
            'Activity, and finally IdleScrollActivity. Learn the set '
            'instead of the individual controller.',
        tone: Color(0xFF38A169),
      ),
    ];

    return Column(
      children: <Widget>[
        for (final tile in tiles) ...<Widget>[
          _TeachingTileWidget(tile: tile),
          const SizedBox(height: 12),
        ],
      ],
    );
  }
}

class _TeachingTile {
  const _TeachingTile({
    required this.icon,
    required this.title,
    required this.body,
    required this.tone,
  });
  final IconData icon;
  final String title;
  final String body;
  final Color tone;
}

class _TeachingTileWidget extends StatelessWidget {
  const _TeachingTileWidget({required this.tile});
  final _TeachingTile tile;

  @override
  Widget build(BuildContext context) {
    // A non-uniform Border (a colored left accent + neutral other sides)
    // cannot coexist with `borderRadius` on a BoxDecoration — Flutter
    // throws "A borderRadius can only be given on borders with uniform
    // colors". Split the look in two: a uniform-bordered rounded card,
    // plus a separate colored accent strip rendered as the first child
    // of the Row.
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kLine),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 4,
            height: 36,
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: tile.tone,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Container(
            width: 36,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: tile.tone.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(tile.icon, color: tile.tone, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  tile.title,
                  style: TextStyle(
                    color: tile.tone,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  tile.body,
                  style: const TextStyle(
                    color: _kInk,
                    fontSize: 13,
                    height: 1.45,
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

// ---------------------------------------------------------------
// Section 9 — reference card. The three methods of the Drag
// interface plus the rough signature each one has, for quick
// recall.
// ---------------------------------------------------------------

class _ReferenceCardSection extends StatelessWidget {
  const _ReferenceCardSection();

  @override
  Widget build(BuildContext context) {
    final entries = <_ReferenceEntry>[
      const _ReferenceEntry(
        signature: 'void update(DragUpdateDetails details)',
        summary: 'Called once per pointer move while the drag is '
            'active. Forwards the delta to applyUserOffset.',
      ),
      const _ReferenceEntry(
        signature: 'void end(DragEndDetails details)',
        summary: 'Called when the finger lifts. Triggers '
            'goBallistic(velocity) on the ScrollPosition.',
      ),
      const _ReferenceEntry(
        signature: 'void cancel()',
        summary: 'Called when the gesture is rejected or interrupted. '
            'Transitions the position to idle.',
      ),
    ];
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kIndigoDark,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: const <Widget>[
              Icon(Icons.menu_book, color: _kAmber),
              SizedBox(width: 8),
              Text(
                'Drag interface · methods',
                style: TextStyle(
                  color: _kAmber,
                  fontFamily: 'monospace',
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          for (final e in entries) ...<Widget>[
            _ReferenceEntryWidget(entry: e),
            const SizedBox(height: 10),
          ],
        ],
      ),
    );
  }
}

class _ReferenceEntry {
  const _ReferenceEntry({required this.signature, required this.summary});
  final String signature;
  final String summary;
}

class _ReferenceEntryWidget extends StatelessWidget {
  const _ReferenceEntryWidget({required this.entry});
  final _ReferenceEntry entry;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kAmber.withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            entry.signature,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'monospace',
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            entry.summary,
            style: const TextStyle(
              color: Color(0xFFE2E8F0),
              fontSize: 12,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------
// Section 10 — footer summary card. Gives the reader a takeaway.
// ---------------------------------------------------------------

class _FooterSummaryCard extends StatelessWidget {
  const _FooterSummaryCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[_kIndigo, _kIndigoDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _kIndigo.withValues(alpha: 0.25),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 54,
            height: 54,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _kAmber.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.pan_tool_alt,
              color: _kAmber,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'recap',
                  style: TextStyle(
                    color: _kAmber,
                    fontFamily: 'monospace',
                    fontSize: 12,
                    letterSpacing: 2,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'ScrollDragController is a small but pivotal '
                  'actor in the scrolling story. It is produced '
                  'by a ScrollPosition at drag-start, fed per-frame '
                  'deltas through its update() method, and retires '
                  'into a ballistic or idle activity when end() or '
                  'cancel() is called. You rarely touch it directly '
                  '— but understanding its shape is how '
                  'ScrollController, NotificationListener and custom '
                  'physics suddenly click.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.5,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: _kAmber.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'finger -> ScrollDragController -> applyUserOffset '
                    '-> goBallistic',
                    style: TextStyle(
                      color: _kAmber,
                      fontFamily: 'monospace',
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
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
