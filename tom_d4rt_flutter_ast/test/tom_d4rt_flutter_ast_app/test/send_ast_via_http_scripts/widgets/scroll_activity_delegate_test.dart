import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

// ----------------------------------------------------------------------------
// ScrollActivityDelegate Observatory
// ----------------------------------------------------------------------------
// A deep, hand-authored visual demo of ScrollActivityDelegate — the abstract
// interface that ScrollPosition implements to drive ScrollActivity instances:
//   * IdleScrollActivity       — nothing happening, position at rest
//   * DragScrollActivity       — user finger touching and moving
//   * HoldScrollActivity       — user finger resting on screen, frozen
//   * BallisticScrollActivity  — simulation physics decaying to rest
//   * DrivenScrollActivity     — programmatic animateTo / animation
//
// The Observatory watches a real ScrollPosition via NotificationListener and
// narrates which abstract "phase" the delegate is currently serving. You can
// never construct a ScrollActivityDelegate yourself; ScrollPosition /
// ScrollPositionWithSingleContext already do that.
// ----------------------------------------------------------------------------

dynamic build(BuildContext context) {
  return const MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'ScrollActivityDelegate Observatory',
    home: _ObservatoryShell(),
  );
}

// ----------------------------------------------------------------------------
// Palette
// ----------------------------------------------------------------------------

class _Palette {
  static const Color background = Color(0xFF1C2230);
  static const Color card = Color(0xFF252C3C);
  static const Color cardRaised = Color(0xFF2C3448);
  static const Color cardSunken = Color(0xFF1E2330);
  static const Color text = Color(0xFFE4E9F2);
  static const Color textMuted = Color(0xFF9BA4B8);
  static const Color textFaint = Color(0xFF6C7489);
  static const Color accent = Color(0xFFF4D35E);

  // Phase colours
  static const Color drag = Color(0xFF4ECDC4);
  static const Color ballistic = Color(0xFFF4D35E);
  static const Color idle = Color(0xFF7A8399);
  static const Color hold = Color(0xFF9C89B8);
  static const Color driven = Color(0xFF6FACE3);
  static const Color overscroll = Color(0xFFF25C54);

  static const Color divider = Color(0xFF333B52);
  static const Color gridLine = Color(0x223E4663);
}

// ----------------------------------------------------------------------------
// Activity phase enum (we derive this from ScrollNotification stream)
// ----------------------------------------------------------------------------

enum _Phase { idle, drag, hold, ballistic, driven }

extension _PhaseMeta on _Phase {
  String get label {
    switch (this) {
      case _Phase.idle:
        return 'Idle';
      case _Phase.drag:
        return 'Drag';
      case _Phase.hold:
        return 'Hold';
      case _Phase.ballistic:
        return 'Ballistic';
      case _Phase.driven:
        return 'Driven';
    }
  }

  String get subtitle {
    switch (this) {
      case _Phase.idle:
        return 'Position at rest. Delegate serves IdleScrollActivity.';
      case _Phase.drag:
        return 'User finger is moving. Delegate serves DragScrollActivity.';
      case _Phase.hold:
        return 'User finger down but stationary. HoldScrollActivity.';
      case _Phase.ballistic:
        return 'Physics simulation decaying. BallisticScrollActivity.';
      case _Phase.driven:
        return 'Programmatic animation. DrivenScrollActivity.';
    }
  }

  Color get color {
    switch (this) {
      case _Phase.idle:
        return _Palette.idle;
      case _Phase.drag:
        return _Palette.drag;
      case _Phase.hold:
        return _Palette.hold;
      case _Phase.ballistic:
        return _Palette.ballistic;
      case _Phase.driven:
        return _Palette.driven;
    }
  }

  IconData get icon {
    switch (this) {
      case _Phase.idle:
        return Icons.pause_circle_outline;
      case _Phase.drag:
        return Icons.pan_tool_alt_outlined;
      case _Phase.hold:
        return Icons.back_hand_outlined;
      case _Phase.ballistic:
        return Icons.speed_outlined;
      case _Phase.driven:
        return Icons.play_circle_outline;
    }
  }
}

// ----------------------------------------------------------------------------
// Root shell
// ----------------------------------------------------------------------------

class _ObservatoryShell extends StatelessWidget {
  const _ObservatoryShell();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: _Palette.background,
      body: SafeArea(
        child: _ObservatoryBody(),
      ),
    );
  }
}

class _ObservatoryBody extends StatefulWidget {
  const _ObservatoryBody();

  @override
  State<_ObservatoryBody> createState() => _ObservatoryBodyState();
}

class _ObservatoryBodyState extends State<_ObservatoryBody>
    with TickerProviderStateMixin {
  final ScrollController _controller = ScrollController();
  final List<double> _deltaSamples = <double>[];
  static const int _maxSamples = 120;

  _Phase _phase = _Phase.idle;
  bool _overscrolling = false;
  double _lastOffset = 0;
  double _lastVelocity = 0;
  int _dragStarts = 0;
  int _ballisticStarts = 0;
  int _idleTransitions = 0;
  int _drivenStarts = 0;
  int _overscrollHits = 0;
  bool _drivenInFlight = false;
  DateTime _lastEventAt = DateTime.now();

  late final AnimationController _pulse;

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulse.dispose();
    _controller.dispose();
    super.dispose();
  }

  // ---- notification handling -------------------------------------------------

  bool _onScrollNotification(ScrollNotification n) {
    final DateTime now = DateTime.now();

    if (n is ScrollStartNotification) {
      final DragStartDetails? drag = n.dragDetails;
      setState(() {
        if (_drivenInFlight) {
          _phase = _Phase.driven;
        } else if (drag != null) {
          _phase = _Phase.drag;
          _dragStarts++;
        } else {
          _phase = _Phase.hold;
        }
        _lastEventAt = now;
      });
    } else if (n is ScrollUpdateNotification) {
      final double delta = n.scrollDelta ?? 0;
      setState(() {
        _recordSample(delta);
        _lastOffset = n.metrics.pixels;
        if (_drivenInFlight) {
          _phase = _Phase.driven;
        } else if (n.dragDetails != null) {
          _phase = _Phase.drag;
        } else if (_phase == _Phase.drag) {
          // still drag — the gesture owns the position
        } else if (_phase == _Phase.hold) {
          // small creep during hold
        } else {
          // no drag details, no driven → treat as ballistic update
          _phase = _Phase.ballistic;
        }
        _lastEventAt = now;
      });
    } else if (n is OverscrollNotification) {
      setState(() {
        _overscrolling = true;
        _overscrollHits++;
        _lastVelocity = n.velocity;
        _lastEventAt = now;
      });
      Future<void>.delayed(const Duration(milliseconds: 500), () {
        if (!mounted) return;
        setState(() => _overscrolling = false);
      });
    } else if (n is ScrollEndNotification) {
      setState(() {
        if (!_drivenInFlight) {
          // a drag release may be followed by ballistic notifications, but the
          // synchronous end-of-drag event itself is the moment the delegate
          // transitions.
          if (_phase == _Phase.drag) {
            _ballisticStarts++;
            _phase = _Phase.ballistic;
          } else if (_phase == _Phase.ballistic) {
            _idleTransitions++;
            _phase = _Phase.idle;
          } else if (_phase == _Phase.hold) {
            _idleTransitions++;
            _phase = _Phase.idle;
          } else {
            _idleTransitions++;
            _phase = _Phase.idle;
          }
        }
        _lastEventAt = now;
      });
    }
    return false;
  }

  void _recordSample(double delta) {
    _deltaSamples.add(delta);
    if (_deltaSamples.length > _maxSamples) {
      _deltaSamples.removeAt(0);
    }
  }

  // ---- programmatic triggers ------------------------------------------------

  Future<void> _triggerAnimateTo(double target) async {
    if (!_controller.hasClients) return;
    setState(() {
      _drivenInFlight = true;
      _drivenStarts++;
      _phase = _Phase.driven;
    });
    await _controller.animateTo(
      target,
      duration: const Duration(milliseconds: 900),
      curve: Curves.easeInOutCubic,
    );
    setState(() {
      _drivenInFlight = false;
      _phase = _Phase.idle;
      _idleTransitions++;
    });
  }

  void _triggerJumpTo(double target) {
    if (!_controller.hasClients) return;
    setState(() {
      _phase = _Phase.idle;
      _idleTransitions++;
    });
    _controller.jumpTo(target);
    debugPrint('ScrollActivityDelegate: jumpTo($target) '
        'calls setPixels synchronously — no new activity is constructed.');
  }

  Future<void> _triggerAnimateHome() async {
    await _triggerAnimateTo(0);
  }

  // ---- build -----------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        const SliverToBoxAdapter(child: _HeroHeader()),
        SliverToBoxAdapter(
          child: _PhaseDashboard(
            phase: _phase,
            overscrolling: _overscrolling,
            pulse: _pulse,
            offset: _lastOffset,
            velocity: _lastVelocity,
            dragStarts: _dragStarts,
            ballisticStarts: _ballisticStarts,
            idleTransitions: _idleTransitions,
            drivenStarts: _drivenStarts,
            overscrollHits: _overscrollHits,
            lastEventAt: _lastEventAt,
          ),
        ),
        SliverToBoxAdapter(
          child: _LiveMonitorCard(
            controller: _controller,
            onNotification: _onScrollNotification,
          ),
        ),
        SliverToBoxAdapter(
          child: _SparklineCard(samples: List<double>.of(_deltaSamples)),
        ),
        SliverToBoxAdapter(
          child: _ProgrammaticTriggers(
            onAnimate: () => _triggerAnimateTo(2400),
            onAnimateHome: _triggerAnimateHome,
            onJumpMiddle: () => _triggerJumpTo(1200),
            onJumpTop: () => _triggerJumpTo(0),
          ),
        ),
        const SliverToBoxAdapter(child: _StateMachineDiagram()),
        const SliverToBoxAdapter(child: _MethodReferenceCard()),
        const SliverToBoxAdapter(child: _PhaseCardsRow()),
        const SliverToBoxAdapter(child: _TeachingPanel()),
        const SliverToBoxAdapter(child: _FooterSummary()),
        const SliverToBoxAdapter(child: SizedBox(height: 40)),
      ],
    );
  }
}

// ----------------------------------------------------------------------------
// Hero header
// ----------------------------------------------------------------------------

class _HeroHeader extends StatelessWidget {
  const _HeroHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: _Palette.accent.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _Palette.accent.withValues(alpha: 0.35),
                  ),
                ),
                child: const Icon(
                  Icons.show_chart,
                  color: _Palette.accent,
                  size: 24,
                ),
              ),
              const SizedBox(width: 14),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'ScrollActivityDelegate',
                      style: TextStyle(
                        color: _Palette.text,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.2,
                      ),
                    ),
                    Text(
                      'Observatory',
                      style: TextStyle(
                        color: _Palette.accent,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 2.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Text(
            'A live look at the abstract delegate that ScrollPosition implements '
            'to serve the four canonical ScrollActivity phases — Idle, Drag, '
            'Ballistic, Hold — plus the programmatic Driven variant.',
            style: TextStyle(
              color: _Palette.textMuted,
              fontSize: 14,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          const _Oscilloscope(),
        ],
      ),
    );
  }
}

class _Oscilloscope extends StatelessWidget {
  const _Oscilloscope();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 112,
      decoration: BoxDecoration(
        color: _Palette.cardSunken,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _Palette.divider),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: CustomPaint(painter: _GridPainter()),
          ),
          Positioned.fill(
            child: CustomPaint(painter: _OscilloTracePainter()),
          ),
          Positioned(
            top: 10,
            left: 14,
            child: Row(
              children: const <Widget>[
                Icon(Icons.circle, color: _Palette.accent, size: 8),
                SizedBox(width: 6),
                Text(
                  'PHASE TRACE',
                  style: TextStyle(
                    color: _Palette.accent,
                    fontSize: 10,
                    letterSpacing: 2.1,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 14,
            bottom: 10,
            child: Text(
              'CH1  0.5V/div',
              style: TextStyle(
                color: _Palette.textFaint.withValues(alpha: 0.7),
                fontSize: 10,
                letterSpacing: 1.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint p = Paint()
      ..color = _Palette.gridLine
      ..strokeWidth = 1;
    const double step = 24;
    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), p);
    }
    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), p);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _OscilloTracePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint trace = Paint()
      ..color = _Palette.accent.withValues(alpha: 0.85)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4
      ..strokeCap = StrokeCap.round;
    final Path path = Path();
    final double midY = size.height / 2;
    for (int i = 0; i < 160; i++) {
      final double x = i * (size.width / 160);
      final double phase = i / 160 * math.pi * 4;
      final double y = midY +
          math.sin(phase) * 18 +
          math.sin(phase * 2.3) * 6 -
          (i > 90 && i < 120 ? 20 : 0);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    canvas.drawPath(path, trace);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ----------------------------------------------------------------------------
// Phase dashboard (top-level live status)
// ----------------------------------------------------------------------------

class _PhaseDashboard extends StatelessWidget {
  const _PhaseDashboard({
    required this.phase,
    required this.overscrolling,
    required this.pulse,
    required this.offset,
    required this.velocity,
    required this.dragStarts,
    required this.ballisticStarts,
    required this.idleTransitions,
    required this.drivenStarts,
    required this.overscrollHits,
    required this.lastEventAt,
  });

  final _Phase phase;
  final bool overscrolling;
  final Animation<double> pulse;
  final double offset;
  final double velocity;
  final int dragStarts;
  final int ballisticStarts;
  final int idleTransitions;
  final int drivenStarts;
  final int overscrollHits;
  final DateTime lastEventAt;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: _Palette.card,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: _Palette.divider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                _PhaseBadge(phase: phase, pulse: pulse),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        phase.label.toUpperCase(),
                        style: TextStyle(
                          color: phase.color,
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 2.1,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        phase.subtitle,
                        style: const TextStyle(
                          color: _Palette.textMuted,
                          fontSize: 12,
                          height: 1.35,
                        ),
                      ),
                    ],
                  ),
                ),
                AnimatedOpacity(
                  opacity: overscrolling ? 1 : 0.2,
                  duration: const Duration(milliseconds: 220),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: _Palette.overscroll.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: _Palette.overscroll.withValues(alpha: 0.6),
                      ),
                    ),
                    child: const Text(
                      'OVERSCROLL',
                      style: TextStyle(
                        color: _Palette.overscroll,
                        fontSize: 10,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(color: _Palette.divider, height: 1),
            const SizedBox(height: 16),
            Row(
              children: <Widget>[
                Expanded(
                  child: _MetricTile(
                    label: 'offset (px)',
                    value: offset.toStringAsFixed(1),
                  ),
                ),
                Expanded(
                  child: _MetricTile(
                    label: 'last velocity',
                    value: velocity.toStringAsFixed(1),
                  ),
                ),
                Expanded(
                  child: _MetricTile(
                    label: 'drag starts',
                    value: '$dragStarts',
                  ),
                ),
                Expanded(
                  child: _MetricTile(
                    label: 'ballistics',
                    value: '$ballisticStarts',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: <Widget>[
                Expanded(
                  child: _MetricTile(
                    label: 'idle transitions',
                    value: '$idleTransitions',
                  ),
                ),
                Expanded(
                  child: _MetricTile(
                    label: 'driven starts',
                    value: '$drivenStarts',
                  ),
                ),
                Expanded(
                  child: _MetricTile(
                    label: 'overscroll hits',
                    value: '$overscrollHits',
                  ),
                ),
                Expanded(
                  child: _MetricTile(
                    label: 'last event',
                    value:
                        '${lastEventAt.hour.toString().padLeft(2, '0')}:${lastEventAt.minute.toString().padLeft(2, '0')}:${lastEventAt.second.toString().padLeft(2, '0')}',
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

class _PhaseBadge extends StatelessWidget {
  const _PhaseBadge({required this.phase, required this.pulse});

  final _Phase phase;
  final Animation<double> pulse;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: pulse,
      builder: (BuildContext context, Widget? _) {
        final double t = pulse.value;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 260),
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: phase.color.withValues(alpha: 0.14 + t * 0.1),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: phase.color.withValues(alpha: 0.4 + t * 0.3),
              width: 1.5,
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: phase.color.withValues(alpha: 0.18 * t),
                blurRadius: 12 + t * 8,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Icon(
            phase.icon,
            color: phase.color,
            size: 28,
          ),
        );
      },
    );
  }
}

class _MetricTile extends StatelessWidget {
  const _MetricTile({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: _Palette.cardSunken,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _Palette.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label.toUpperCase(),
            style: const TextStyle(
              color: _Palette.textFaint,
              fontSize: 9,
              letterSpacing: 1.3,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: _Palette.text,
              fontSize: 15,
              fontWeight: FontWeight.w700,
              fontFeatures: <FontFeature>[FontFeature.tabularFigures()],
            ),
          ),
        ],
      ),
    );
  }
}

// ----------------------------------------------------------------------------
// Live monitor — 80 items, listens to ScrollNotification
// ----------------------------------------------------------------------------

class _LiveMonitorCard extends StatelessWidget {
  const _LiveMonitorCard({
    required this.controller,
    required this.onNotification,
  });

  final ScrollController controller;
  final NotificationListenerCallback<ScrollNotification> onNotification;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
      child: Container(
        decoration: BoxDecoration(
          color: _Palette.card,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: _Palette.divider),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const _SectionHeader(
              label: 'Live phase monitor',
              hint: 'drag, fling, or use triggers below',
              icon: Icons.monitor_heart_outlined,
            ),
            SizedBox(
              height: 280,
              child: NotificationListener<ScrollNotification>(
                onNotification: onNotification,
                child: ListView.builder(
                  controller: controller,
                  itemCount: 80,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 8),
                  itemBuilder: (BuildContext context, int index) {
                    return _MonitorRow(index: index);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MonitorRow extends StatelessWidget {
  const _MonitorRow({required this.index});

  final int index;

  static const List<Color> _hues = <Color>[
    Color(0xFF4ECDC4),
    Color(0xFFF4D35E),
    Color(0xFF9C89B8),
    Color(0xFF6FACE3),
    Color(0xFFF25C54),
    Color(0xFF7ED389),
    Color(0xFFFF9F68),
    Color(0xFFE58CD3),
  ];

  @override
  Widget build(BuildContext context) {
    final Color hue = _hues[index % _hues.length];
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: _Palette.cardRaised,
        borderRadius: BorderRadius.circular(10),
        border: Border(
          left: BorderSide(color: hue, width: 3),
        ),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 32,
            height: 32,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: hue.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '${index + 1}',
              style: TextStyle(
                color: hue,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Viewport row #${index + 1}',
                  style: const TextStyle(
                    color: _Palette.text,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  _descriptionFor(index),
                  style: const TextStyle(
                    color: _Palette.textMuted,
                    fontSize: 11,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: hue.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              '${(index * 48).toString()}px',
              style: TextStyle(
                color: hue,
                fontSize: 10,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.6,
                fontFeatures: const <FontFeature>[FontFeature.tabularFigures()],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _descriptionFor(int i) {
    const List<String> verbs = <String>[
      'observes drag deltas handed to applyUserOffset',
      'watches BallisticScrollActivity decay the offset',
      'records the moment IdleScrollActivity takes over',
      'sees DrivenScrollActivity honour animateTo',
      'catches OverscrollNotification bleed over clamp',
      'traces setPixels firing on every frame',
      'captures HoldScrollActivity freezing the position',
      'notes goBallistic(velocity) firing at drag release',
    ];
    return verbs[i % verbs.length];
  }
}

// ----------------------------------------------------------------------------
// Sparkline
// ----------------------------------------------------------------------------

class _SparklineCard extends StatelessWidget {
  const _SparklineCard({required this.samples});

  final List<double> samples;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
      child: Container(
        decoration: BoxDecoration(
          color: _Palette.card,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: _Palette.divider),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const _SectionHeader(
              label: 'Velocity sparkline',
              hint: 'last 120 scrollDelta samples',
              icon: Icons.timeline_outlined,
            ),
            SizedBox(
              height: 110,
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: CustomPaint(painter: _SparkGridPainter()),
                  ),
                  Positioned.fill(
                    child: CustomPaint(
                      painter: _SparklinePainter(samples: samples),
                    ),
                  ),
                  Positioned(
                    left: 12,
                    bottom: 8,
                    child: Text(
                      samples.isEmpty
                          ? 'no samples yet'
                          : 'samples: ${samples.length}/120   last: '
                              '${samples.last.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: _Palette.textFaint,
                        fontSize: 10,
                        letterSpacing: 1.0,
                        fontFeatures: <FontFeature>[
                          FontFeature.tabularFigures()
                        ],
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

class _SparkGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint mid = Paint()
      ..color = _Palette.divider
      ..strokeWidth = 1;
    final double midY = size.height / 2;
    canvas.drawLine(Offset(0, midY), Offset(size.width, midY), mid);

    final Paint faint = Paint()
      ..color = _Palette.gridLine
      ..strokeWidth = 1;
    for (double y = midY - 24; y > 0; y -= 24) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), faint);
    }
    for (double y = midY + 24; y < size.height; y += 24) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), faint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _SparklinePainter extends CustomPainter {
  _SparklinePainter({required this.samples});

  final List<double> samples;

  @override
  void paint(Canvas canvas, Size size) {
    if (samples.isEmpty) return;
    final double midY = size.height / 2;
    final double dx = size.width / math.max(samples.length - 1, 1);

    double maxAbs = 1;
    for (final double s in samples) {
      if (s.abs() > maxAbs) maxAbs = s.abs();
    }
    final double scale = (size.height / 2 - 6) / maxAbs;

    final Path path = Path();
    for (int i = 0; i < samples.length; i++) {
      final double x = i * dx;
      final double y = midY - samples[i] * scale;
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    final Paint fill = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[
          _Palette.accent.withValues(alpha: 0.32),
          _Palette.accent.withValues(alpha: 0.02),
        ],
      ).createShader(Offset.zero & size)
      ..style = PaintingStyle.fill;

    final Path fillPath = Path.from(path)
      ..lineTo((samples.length - 1) * dx, midY)
      ..lineTo(0, midY)
      ..close();
    canvas.drawPath(fillPath, fill);

    final Paint line = Paint()
      ..color = _Palette.accent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    canvas.drawPath(path, line);

    // last-point dot
    final double lastX = (samples.length - 1) * dx;
    final double lastY = midY - samples.last * scale;
    canvas.drawCircle(
      Offset(lastX, lastY),
      3,
      Paint()..color = _Palette.accent,
    );
    canvas.drawCircle(
      Offset(lastX, lastY),
      6,
      Paint()..color = _Palette.accent.withValues(alpha: 0.25),
    );
  }

  @override
  bool shouldRepaint(covariant _SparklinePainter oldDelegate) =>
      oldDelegate.samples != samples;
}

// ----------------------------------------------------------------------------
// Programmatic triggers
// ----------------------------------------------------------------------------

class _ProgrammaticTriggers extends StatelessWidget {
  const _ProgrammaticTriggers({
    required this.onAnimate,
    required this.onAnimateHome,
    required this.onJumpMiddle,
    required this.onJumpTop,
  });

  final VoidCallback onAnimate;
  final VoidCallback onAnimateHome;
  final VoidCallback onJumpMiddle;
  final VoidCallback onJumpTop;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
      child: Container(
        decoration: BoxDecoration(
          color: _Palette.card,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: _Palette.divider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const _SectionHeader(
              label: 'Programmatic activity triggers',
              hint: 'animateTo = Driven, jumpTo = setPixels synchronous',
              icon: Icons.api_outlined,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 4, 14, 16),
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: <Widget>[
                  _TriggerButton(
                    label: 'animateTo(2400)',
                    sublabel: 'DrivenScrollActivity',
                    color: _Palette.driven,
                    icon: Icons.play_arrow_rounded,
                    onTap: onAnimate,
                  ),
                  _TriggerButton(
                    label: 'animateTo(0)',
                    sublabel: 'DrivenScrollActivity',
                    color: _Palette.driven,
                    icon: Icons.fast_rewind_rounded,
                    onTap: onAnimateHome,
                  ),
                  _TriggerButton(
                    label: 'jumpTo(1200)',
                    sublabel: 'setPixels, no activity',
                    color: _Palette.accent,
                    icon: Icons.north_east_rounded,
                    onTap: onJumpMiddle,
                  ),
                  _TriggerButton(
                    label: 'jumpTo(0)',
                    sublabel: 'setPixels, no activity',
                    color: _Palette.accent,
                    icon: Icons.vertical_align_top_rounded,
                    onTap: onJumpTop,
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

class _TriggerButton extends StatelessWidget {
  const _TriggerButton({
    required this.label,
    required this.sublabel,
    required this.color,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final String sublabel;
  final Color color;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color.withValues(alpha: 0.10),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withValues(alpha: 0.45)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(icon, color: color, size: 18),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    label,
                    style: TextStyle(
                      color: color,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.4,
                    ),
                  ),
                  Text(
                    sublabel,
                    style: TextStyle(
                      color: color.withValues(alpha: 0.75),
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.8,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ----------------------------------------------------------------------------
// Activity transition diagram
// ----------------------------------------------------------------------------

class _StateMachineDiagram extends StatelessWidget {
  const _StateMachineDiagram();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
      child: Container(
        decoration: BoxDecoration(
          color: _Palette.card,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: _Palette.divider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const _SectionHeader(
              label: 'Activity state machine',
              hint: 'how the delegate swaps ScrollActivity instances',
              icon: Icons.schema_outlined,
            ),
            SizedBox(
              height: 220,
              child: CustomPaint(
                painter: _StateMachinePainter(),
                child: const SizedBox.expand(),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Text(
                'Drag release calls goBallistic(velocity). When the ballistic '
                'simulation settles, goIdle() is called and IdleScrollActivity '
                'takes over. Programmatic animateTo installs a '
                'DrivenScrollActivity instead — it never passes through '
                'Ballistic.',
                style: TextStyle(
                  color: _Palette.textMuted,
                  fontSize: 12,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StateMachinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    TextPainter makeText(String txt, Color color) {
      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: txt,
          style: TextStyle(
            color: color,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      return tp;
    }

    final double cy = size.height / 2;
    final double step = size.width / 5;

    final List<_Node> nodes = <_Node>[
      _Node(Offset(step * 0.6, cy), 'Idle', _Palette.idle),
      _Node(Offset(step * 1.7, cy - 50), 'Hold', _Palette.hold),
      _Node(Offset(step * 2.7, cy), 'Drag', _Palette.drag),
      _Node(Offset(step * 3.8, cy - 50), 'Ballistic', _Palette.ballistic),
      _Node(Offset(step * 3.8, cy + 50), 'Driven', _Palette.driven),
    ];

    // edges
    _drawEdge(canvas, nodes[0].pos, nodes[1].pos,
        label: 'touch down', labelColor: _Palette.hold);
    _drawEdge(canvas, nodes[1].pos, nodes[2].pos,
        label: 'move', labelColor: _Palette.drag);
    _drawEdge(canvas, nodes[0].pos, nodes[2].pos,
        label: 'drag start', labelColor: _Palette.drag, dashed: true);
    _drawEdge(canvas, nodes[2].pos, nodes[3].pos,
        label: 'goBallistic(v)', labelColor: _Palette.ballistic);
    _drawEdge(canvas, nodes[3].pos, nodes[0].pos,
        label: 'goIdle()', labelColor: _Palette.idle, curveUp: true);
    _drawEdge(canvas, nodes[0].pos, nodes[4].pos,
        label: 'animateTo()', labelColor: _Palette.driven, dashed: true);
    _drawEdge(canvas, nodes[4].pos, nodes[0].pos,
        label: 'complete', labelColor: _Palette.idle, curveUp: false);

    // nodes
    for (final _Node n in nodes) {
      final Paint bg = Paint()..color = n.color.withValues(alpha: 0.16);
      final Paint border = Paint()
        ..color = n.color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.6;
      final Rect rect = Rect.fromCenter(
        center: n.pos,
        width: 84,
        height: 34,
      );
      final RRect rr = RRect.fromRectAndRadius(rect, const Radius.circular(10));
      canvas.drawRRect(rr, bg);
      canvas.drawRRect(rr, border);
      final TextPainter tp = makeText(n.label, n.color);
      tp.paint(
        canvas,
        n.pos - Offset(tp.width / 2, tp.height / 2),
      );
    }
  }

  void _drawEdge(
    Canvas canvas,
    Offset a,
    Offset b, {
    required String label,
    required Color labelColor,
    bool dashed = false,
    bool curveUp = false,
  }) {
    final Paint line = Paint()
      ..color = labelColor.withValues(alpha: 0.55)
      ..strokeWidth = 1.4
      ..style = PaintingStyle.stroke;

    final Path p = Path();
    final Offset mid = Offset.lerp(a, b, 0.5)!;
    final Offset ctrl = mid + Offset(0, curveUp ? -34 : 14);
    p.moveTo(a.dx, a.dy);
    p.quadraticBezierTo(ctrl.dx, ctrl.dy, b.dx, b.dy);

    if (dashed) {
      _drawDashed(canvas, p, line);
    } else {
      canvas.drawPath(p, line);
    }

    // arrowhead
    const double arrowSize = 6;
    final Offset dir = (b - ctrl);
    final double angle = math.atan2(dir.dy, dir.dx);
    final Path arrow = Path()
      ..moveTo(b.dx, b.dy)
      ..lineTo(
        b.dx - arrowSize * math.cos(angle - math.pi / 6),
        b.dy - arrowSize * math.sin(angle - math.pi / 6),
      )
      ..lineTo(
        b.dx - arrowSize * math.cos(angle + math.pi / 6),
        b.dy - arrowSize * math.sin(angle + math.pi / 6),
      )
      ..close();
    canvas.drawPath(arrow, Paint()..color = labelColor);

    // label
    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: label,
        style: TextStyle(
          color: labelColor,
          fontSize: 9.5,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.6,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    final Offset labelPos = ctrl + const Offset(-8, -10);
    tp.paint(canvas, labelPos);
  }

  void _drawDashed(Canvas canvas, Path path, Paint paint) {
    const double dashWidth = 5;
    const double dashSpace = 4;
    for (final ui.PathMetric metric in path.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        final double next = distance + dashWidth;
        canvas.drawPath(
          metric.extractPath(distance, next.clamp(0, metric.length)),
          paint,
        );
        distance = next + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _Node {
  _Node(this.pos, this.label, this.color);
  final Offset pos;
  final String label;
  final Color color;
}

// ----------------------------------------------------------------------------
// Method reference card
// ----------------------------------------------------------------------------

class _MethodReferenceCard extends StatelessWidget {
  const _MethodReferenceCard();

  static const List<_MethodDoc> _methods = <_MethodDoc>[
    _MethodDoc(
      'setPixels(double value)',
      'Moves the scroll offset to the given pixel value and returns the '
          'amount that could not be applied (overscroll).',
    ),
    _MethodDoc(
      'applyUserOffset(double delta)',
      'Called by DragScrollActivity on each drag update so the position '
          'can convert a finger delta into a pixel change.',
    ),
    _MethodDoc(
      'goIdle()',
      'Installs IdleScrollActivity — used when ballistic simulation comes '
          'to rest or an animation completes.',
    ),
    _MethodDoc(
      'goBallistic(double velocity)',
      'Builds a physics simulation from the current velocity and installs '
          'BallisticScrollActivity to decay it.',
    ),
    _MethodDoc(
      'applyNewDimensions()',
      'Called when the viewport size or content extent changes so the '
          'current activity can react (e.g. clamp).',
    ),
    _MethodDoc(
      'axisDirection',
      'Exposes the direction of the scrollable so activities know whether '
          'positive deltas scroll up or down.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
      child: Container(
        decoration: BoxDecoration(
          color: _Palette.card,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: _Palette.divider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const _SectionHeader(
              label: 'Delegate method reference',
              hint: 'the abstract surface ScrollPosition implements',
              icon: Icons.description_outlined,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
              child: Column(
                children: <Widget>[
                  for (int i = 0; i < _methods.length; i++)
                    _MethodRow(
                      doc: _methods[i],
                      showDivider: i != _methods.length - 1,
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

class _MethodDoc {
  const _MethodDoc(this.signature, this.description);
  final String signature;
  final String description;
}

class _MethodRow extends StatelessWidget {
  const _MethodRow({required this.doc, required this.showDivider});

  final _MethodDoc doc;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: 160,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: _Palette.cardSunken,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: _Palette.divider),
                  ),
                  child: Text(
                    doc.signature,
                    style: const TextStyle(
                      color: _Palette.accent,
                      fontSize: 11.5,
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    doc.description,
                    style: const TextStyle(
                      color: _Palette.text,
                      fontSize: 12.5,
                      height: 1.45,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (showDivider) const Divider(color: _Palette.divider, height: 1),
      ],
    );
  }
}

// ----------------------------------------------------------------------------
// Phase cards row
// ----------------------------------------------------------------------------

class _PhaseCardsRow extends StatelessWidget {
  const _PhaseCardsRow();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
      child: Container(
        decoration: BoxDecoration(
          color: _Palette.card,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: _Palette.divider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const _SectionHeader(
              label: 'ScrollActivity taxonomy',
              hint: 'five concrete subclasses the delegate installs',
              icon: Icons.category_outlined,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: const <Widget>[
                  _PhaseCard(
                    title: 'IdleScrollActivity',
                    color: _Palette.idle,
                    icon: Icons.pause_circle_outline,
                    description:
                        'The default quiescent state. No simulation, no drag. '
                        'The position simply sits at its current pixels.',
                    example: 'after a ballistic comes to rest',
                  ),
                  _PhaseCard(
                    title: 'DragScrollActivity',
                    color: _Palette.drag,
                    icon: Icons.pan_tool_alt_outlined,
                    description:
                        'Owned by a DragScrollDetails pointer. Forwards every '
                        'update to applyUserOffset on the delegate.',
                    example: 'finger dragging a ListView',
                  ),
                  _PhaseCard(
                    title: 'BallisticScrollActivity',
                    color: _Palette.ballistic,
                    icon: Icons.speed_outlined,
                    description:
                        'Runs a Simulation produced by physics.createBallistic'
                        'Simulation. Calls setPixels each frame.',
                    example: 'post-fling decay',
                  ),
                  _PhaseCard(
                    title: 'HoldScrollActivity',
                    color: _Palette.hold,
                    icon: Icons.back_hand_outlined,
                    description:
                        'Finger down but no drag yet — keeps the scroll '
                        'anchored while the gesture arena decides.',
                    example: 'tap-and-hold inside a scroller',
                  ),
                  _PhaseCard(
                    title: 'DrivenScrollActivity',
                    color: _Palette.driven,
                    icon: Icons.play_circle_outline,
                    description:
                        'Animates the scroll offset via an AnimationController '
                        'and curve. Used by animateTo / ensureVisible.',
                    example: 'controller.animateTo(...)',
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

class _PhaseCard extends StatelessWidget {
  const _PhaseCard({
    required this.title,
    required this.color,
    required this.icon,
    required this.description,
    required this.example,
  });

  final String title;
  final Color color;
  final IconData icon;
  final String description;
  final String example;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _Palette.cardRaised,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 32,
                height: 32,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 18),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: color,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: const TextStyle(
              color: _Palette.text,
              fontSize: 12,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(Icons.bolt_outlined, size: 12, color: color),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    example,
                    style: TextStyle(
                      color: color,
                      fontSize: 10.5,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.3,
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

// ----------------------------------------------------------------------------
// Teaching panel
// ----------------------------------------------------------------------------

class _TeachingPanel extends StatelessWidget {
  const _TeachingPanel();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
      child: Container(
        decoration: BoxDecoration(
          color: _Palette.card,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: _Palette.divider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const _SectionHeader(
              label: 'When does each activity fire?',
              hint: 'plus: please do not implement this yourself',
              icon: Icons.school_outlined,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  _TeachingBullet(
                    phase: _Phase.idle,
                    title: 'Idle',
                    text:
                        'Fires on startup, after goIdle() is called at the end '
                        'of every other activity, and whenever the position is '
                        'assigned a value that does not need animation.',
                  ),
                  SizedBox(height: 10),
                  _TeachingBullet(
                    phase: _Phase.hold,
                    title: 'Hold',
                    text:
                        'Fires when a pointer goes down inside a scrollable '
                        'and the gesture arena has not yet declared a winner. '
                        'Blocks ballistic fling from continuing.',
                  ),
                  SizedBox(height: 10),
                  _TeachingBullet(
                    phase: _Phase.drag,
                    title: 'Drag',
                    text:
                        'Fires as soon as a drag is accepted. Each move event '
                        'calls applyUserOffset on the delegate, which decides '
                        'how much of the delta becomes a pixel change.',
                  ),
                  SizedBox(height: 10),
                  _TeachingBullet(
                    phase: _Phase.ballistic,
                    title: 'Ballistic',
                    text:
                        'Fires when the user lifts their finger and the '
                        'physics produces a non-zero velocity. goBallistic is '
                        'called; the simulation ticks setPixels each frame.',
                  ),
                  SizedBox(height: 10),
                  _TeachingBullet(
                    phase: _Phase.driven,
                    title: 'Driven',
                    text:
                        'Fires on any programmatic animateTo / ensureVisible. '
                        'Owns its own AnimationController rather than a '
                        'Simulation. Ends with goIdle.',
                  ),
                  SizedBox(height: 14),
                  _Caveat(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TeachingBullet extends StatelessWidget {
  const _TeachingBullet({
    required this.phase,
    required this.title,
    required this.text,
  });

  final _Phase phase;
  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 4),
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: phase.color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(
                color: _Palette.text,
                fontSize: 12.5,
                height: 1.45,
              ),
              children: <InlineSpan>[
                TextSpan(
                  text: '$title — ',
                  style: TextStyle(
                    color: phase.color,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(text: text),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _Caveat extends StatelessWidget {
  const _Caveat();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _Palette.overscroll.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: _Palette.overscroll.withValues(alpha: 0.45),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          Icon(
            Icons.warning_amber_outlined,
            color: _Palette.overscroll,
            size: 20,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'Do not implement ScrollActivityDelegate yourself. '
              'ScrollPositionWithSingleContext already implements the entire '
              'contract for you — subclass ScrollPosition or write a custom '
              'ScrollPhysics instead.',
              style: TextStyle(
                color: _Palette.text,
                fontSize: 12.5,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ----------------------------------------------------------------------------
// Footer
// ----------------------------------------------------------------------------

class _FooterSummary extends StatelessWidget {
  const _FooterSummary();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              _Palette.card,
              _Palette.cardRaised.withValues(alpha: 0.9),
            ],
          ),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: _Palette.divider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 38,
                  height: 38,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: _Palette.accent.withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: _Palette.accent.withValues(alpha: 0.35),
                    ),
                  ),
                  child: const Icon(
                    Icons.auto_awesome_outlined,
                    color: _Palette.accent,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'Observatory summary',
                    style: TextStyle(
                      color: _Palette.text,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              'ScrollActivityDelegate is the seam between a ScrollPosition '
              'and the ScrollActivity it currently serves. Activities never '
              'talk to widgets directly; they call setPixels, applyUserOffset, '
              'goBallistic, or goIdle on their delegate. Understanding this '
              'handoff is the entire mental model for Flutter scroll physics.',
              style: TextStyle(
                color: _Palette.textMuted,
                fontSize: 12.5,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 14),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: const <Widget>[
                _Chip(label: 'setPixels', color: _Palette.accent),
                _Chip(label: 'applyUserOffset', color: _Palette.drag),
                _Chip(label: 'goBallistic', color: _Palette.ballistic),
                _Chip(label: 'goIdle', color: _Palette.idle),
                _Chip(label: 'axisDirection', color: _Palette.driven),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.45)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 11.5,
          fontWeight: FontWeight.w700,
          fontFamily: 'monospace',
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}

// ----------------------------------------------------------------------------
// Section header (shared)
// ----------------------------------------------------------------------------

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.label,
    required this.hint,
    required this.icon,
  });

  final String label;
  final String hint;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
      child: Row(
        children: <Widget>[
          Icon(icon, color: _Palette.accent, size: 16),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  label,
                  style: const TextStyle(
                    color: _Palette.text,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  hint,
                  style: const TextStyle(
                    color: _Palette.textFaint,
                    fontSize: 10.5,
                    letterSpacing: 1.0,
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
