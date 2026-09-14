import 'dart:math' as math;
import 'package:flutter/material.dart';

// ===========================================================================
// Scroll Pulse Telemetry
// ---------------------------------------------------------------------------
// A deep visual demo of ScrollUpdateNotification, the per-frame heartbeat of
// every scrollable widget in Flutter. Each time a ScrollPosition changes, a
// ScrollUpdateNotification bubbles up the tree carrying:
//   * metrics      — absolute pixels, min/max extent, viewport dimension.
//   * context      — the BuildContext of the notifying scrollable.
//   * scrollDelta  — the incremental pixel change this frame.
//   * dragDetails  — non-null if the update was driven by a user drag.
// Ballistic (fling), programmatic (animateTo/jumpTo) and user-drag phases all
// generate ScrollUpdateNotification — only dragDetails differentiates a
// finger from a physics simulation.
// ===========================================================================

const Color kElectricBlue = Color(0xFF2563EB);
const Color kCyan = Color(0xFF06B6D4);
const Color kInk = Color(0xFF0F172A);
const Color kPaper = Color(0xFFFFFFFF);
const Color kSurface = Color(0xFFF8FAFC);
const Color kMuted = Color(0xFF64748B);
const Color kAmber = Color(0xFFF59E0B);
const Color kLime = Color(0xFF84CC16);
const Color kRose = Color(0xFFF43F5E);
const Color kViolet = Color(0xFF8B5CF6);
const Color kGridLine = Color(0xFFE2E8F0);

// Histogram bucket boundaries (exclusive upper bound except for the last).
const List<double> kBucketEdges = <double>[
  -double.infinity,
  -50.0,
  -20.0,
  -5.0,
  -0.0001,
  0.0,
  5.0,
  20.0,
  50.0,
  double.infinity,
];

const List<String> kBucketLabels = <String>[
  '<= -50',
  '-50..-20',
  '-20..-5',
  '-5..0',
  '0',
  '0..5',
  '5..20',
  '20..50',
  '> 50',
];

dynamic build(BuildContext context) {
  return const MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'ScrollUpdateNotification — Scroll Pulse Telemetry',
    home: ScrollPulseHome(),
  );
}

// ---------------------------------------------------------------------------
// Root scaffold.
// ---------------------------------------------------------------------------

class ScrollPulseHome extends StatefulWidget {
  const ScrollPulseHome({super.key});

  @override
  State<ScrollPulseHome> createState() => _ScrollPulseHomeState();
}

class _ScrollPulseHomeState extends State<ScrollPulseHome>
    with TickerProviderStateMixin {
  // Telemetry driven by the ListView's scroll notifications.
  final ValueNotifier<double> _pixels = ValueNotifier<double>(0);
  final ValueNotifier<double> _lastDelta = ValueNotifier<double>(0);
  final ValueNotifier<double> _velocity = ValueNotifier<double>(0);
  final ValueNotifier<double> _distance = ValueNotifier<double>(0);
  final ValueNotifier<bool> _userDriven = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _nearBottom = ValueNotifier<bool>(false);
  final ValueNotifier<double> _maxExtent = ValueNotifier<double>(1);
  final ValueNotifier<int> _frameCount = ValueNotifier<int>(0);
  final ValueNotifier<int> _sampleTick = ValueNotifier<int>(0);

  final List<double> _samples = <double>[];
  final List<int> _buckets = List<int>.filled(kBucketLabels.length, 0);
  final List<_TelemetryEntry> _recent = <_TelemetryEntry>[];
  static const int _maxSamples = 120;
  static const int _maxRecent = 6;

  late final AnimationController _heroPulse;
  late final AnimationController _loadMoreCtrl;

  DateTime _lastUpdate = DateTime.now();
  bool _loadMoreVisible = false;

  @override
  void initState() {
    super.initState();
    _heroPulse = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
    _loadMoreCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
  }

  @override
  void dispose() {
    _pixels.dispose();
    _lastDelta.dispose();
    _velocity.dispose();
    _distance.dispose();
    _userDriven.dispose();
    _nearBottom.dispose();
    _maxExtent.dispose();
    _frameCount.dispose();
    _sampleTick.dispose();
    _heroPulse.dispose();
    _loadMoreCtrl.dispose();
    super.dispose();
  }

  bool _onScrollUpdate(ScrollUpdateNotification note) {
    final double delta = note.scrollDelta ?? 0;
    final DateTime now = DateTime.now();
    final double dtMs = now.difference(_lastUpdate).inMicroseconds / 1000.0;
    _lastUpdate = now;
    final double frameMs = dtMs <= 0 ? 16.0 : dtMs;

    // Raw values.
    _pixels.value = note.metrics.pixels;
    _maxExtent.value = note.metrics.maxScrollExtent <= 0
        ? 1
        : note.metrics.maxScrollExtent;
    _lastDelta.value = delta;

    // Smoothed velocity px/s — scrollDelta / frameMs * 1000, low-pass filtered.
    final double instV = (delta.abs() / frameMs) * 1000.0;
    _velocity.value = _velocity.value * 0.7 + instV * 0.3;

    // Cumulative distance.
    _distance.value += delta.abs();

    // User vs programmatic.
    _userDriven.value = note.dragDetails != null;

    // Near-bottom threshold for infinite-scroll use-case.
    final double headroom =
        note.metrics.maxScrollExtent - note.metrics.pixels;
    final bool near = headroom < 200 && note.metrics.maxScrollExtent > 0;
    if (near != _nearBottom.value) {
      _nearBottom.value = near;
      if (near && !_loadMoreVisible) {
        _loadMoreVisible = true;
        _loadMoreCtrl.forward(from: 0);
      } else if (!near && _loadMoreVisible) {
        _loadMoreVisible = false;
        _loadMoreCtrl.reverse();
      }
    }

    // Sparkline samples.
    _samples.add(delta);
    if (_samples.length > _maxSamples) {
      _samples.removeAt(0);
    }

    // Histogram bucket.
    final int b = _bucketFor(delta);
    _buckets[b] += 1;

    // Recent entries with dragDetails classification.
    _recent.insert(
      0,
      _TelemetryEntry(
        pixels: note.metrics.pixels,
        delta: delta,
        userDriven: note.dragDetails != null,
        stamp: now,
      ),
    );
    if (_recent.length > _maxRecent) _recent.removeLast();

    _frameCount.value += 1;
    _sampleTick.value += 1;
    return false;
  }

  int _bucketFor(double delta) {
    if (delta <= -50) return 0;
    if (delta <= -20) return 1;
    if (delta <= -5) return 2;
    if (delta < 0) return 3;
    if (delta == 0) return 4;
    if (delta < 5) return 5;
    if (delta < 20) return 6;
    if (delta < 50) return 7;
    return 8;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSurface,
      appBar: AppBar(
        backgroundColor: kInk,
        foregroundColor: kPaper,
        title: const Text('ScrollUpdateNotification — Scroll Pulse Telemetry'),
        elevation: 0,
      ),
      body: NotificationListener<ScrollUpdateNotification>(
        onNotification: _onScrollUpdate,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(child: _HeroHeader(pulse: _heroPulse)),
            const SliverToBoxAdapter(child: _SectionDivider('1. Live telemetry')),
            SliverToBoxAdapter(
              child: _LiveTelemetrySection(
                pixels: _pixels,
                lastDelta: _lastDelta,
                velocity: _velocity,
                distance: _distance,
                nearBottom: _nearBottom,
                loadMoreCtrl: _loadMoreCtrl,
                userDriven: _userDriven,
                maxExtent: _maxExtent,
                frameCount: _frameCount,
              ),
            ),
            const SliverToBoxAdapter(
                child: _SectionDivider('2. Sparkline — last 120 frames')),
            SliverToBoxAdapter(
              child: _SparklinePanel(
                samples: _samples,
                tick: _sampleTick,
              ),
            ),
            const SliverToBoxAdapter(
                child: _SectionDivider('3. Delta distribution')),
            SliverToBoxAdapter(
              child: _HistogramPanel(
                buckets: _buckets,
                tick: _sampleTick,
              ),
            ),
            const SliverToBoxAdapter(
                child: _SectionDivider('4. Recent updates — USER vs PROG')),
            SliverToBoxAdapter(
              child: _RecentUpdatesPanel(
                recent: _recent,
                tick: _sampleTick,
              ),
            ),
            const SliverToBoxAdapter(
                child: _SectionDivider('5. Anatomy of a ScrollUpdateNotification')),
            const SliverToBoxAdapter(child: _AnatomyCard()),
            const SliverToBoxAdapter(
                child: _SectionDivider('6. Teaching panel')),
            const SliverToBoxAdapter(child: _TeachingPanel()),
            const SliverToBoxAdapter(child: _FooterSummary()),
            const SliverPadding(padding: EdgeInsets.only(bottom: 24)),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Hero header — ECG-style waveform + title.
// ---------------------------------------------------------------------------

class _HeroHeader extends StatelessWidget {
  const _HeroHeader({required this.pulse});

  final AnimationController pulse;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[kInk, Color(0xFF1E293B), kElectricBlue],
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: kElectricBlue.withValues(alpha: 0.25),
            blurRadius: 28,
            offset: const Offset(0, 14),
          ),
        ],
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
                  color: kCyan.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: kCyan.withValues(alpha: 0.5)),
                ),
                child: const Icon(Icons.monitor_heart,
                    color: kCyan, size: 26),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'ScrollUpdateNotification',
                      style: TextStyle(
                        color: kPaper,
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                        shadows: <Shadow>[
                          Shadow(
                            color: kCyan.withValues(alpha: 0.4),
                            blurRadius: 12,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'The per-frame heartbeat of a scroll.',
                      style: TextStyle(
                        color: kPaper.withValues(alpha: 0.85),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              _HeroChip(label: 'frame-rate', value: '~60 Hz'),
            ],
          ),
          const SizedBox(height: 22),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              height: 120,
              decoration: BoxDecoration(
                color: kInk.withValues(alpha: 0.65),
                border: Border.all(color: kCyan.withValues(alpha: 0.3)),
                borderRadius: BorderRadius.circular(12),
              ),
              child: AnimatedBuilder(
                animation: pulse,
                builder: (BuildContext context, Widget? _) {
                  return CustomPaint(
                    painter: _EcgPainter(phase: pulse.value),
                    size: Size.infinite,
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 10,
            runSpacing: 8,
            children: const <Widget>[
              _HeroTag('metrics'),
              _HeroTag('context'),
              _HeroTag('scrollDelta'),
              _HeroTag('dragDetails'),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeroChip extends StatelessWidget {
  const _HeroChip({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: kPaper.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: kPaper.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(label,
              style: TextStyle(
                fontSize: 10,
                color: kPaper.withValues(alpha: 0.7),
                letterSpacing: 1.2,
              )),
          Text(value,
              style: const TextStyle(
                color: kPaper,
                fontWeight: FontWeight.w700,
                fontSize: 13,
              )),
        ],
      ),
    );
  }
}

class _HeroTag extends StatelessWidget {
  const _HeroTag(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: kCyan.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: kCyan.withValues(alpha: 0.5)),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: kCyan,
          fontFamily: 'monospace',
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _EcgPainter extends CustomPainter {
  _EcgPainter({required this.phase});

  final double phase;

  @override
  void paint(Canvas canvas, Size size) {
    // Grid background.
    final Paint grid = Paint()
      ..color = kCyan.withValues(alpha: 0.08)
      ..strokeWidth = 1;
    const double cellW = 20;
    const double cellH = 20;
    for (double x = 0; x < size.width; x += cellW) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
    }
    for (double y = 0; y < size.height; y += cellH) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }

    // Zero line.
    final double cy = size.height / 2;
    final Paint zero = Paint()
      ..color = kCyan.withValues(alpha: 0.25)
      ..strokeWidth = 1;
    canvas.drawLine(Offset(0, cy), Offset(size.width, cy), zero);

    // Waveform path.
    final Path path = Path();
    final Paint trace = Paint()
      ..color = kCyan
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final double offset = phase * size.width;
    bool first = true;
    for (double x = 0; x < size.width; x += 2) {
      final double t = (x + offset) % 120;
      double y;
      if (t < 10) {
        y = 0; // flat
      } else if (t < 14) {
        y = -(t - 10) * 4; // P wave up
      } else if (t < 18) {
        y = -16 + (t - 14) * 4; // back to 0
      } else if (t < 22) {
        y = (t - 18) * 3; // Q dip
      } else if (t < 26) {
        y = 12 - (t - 22) * 15; // big R spike up
      } else if (t < 30) {
        y = -48 + (t - 26) * 16; // S back down and through
      } else if (t < 34) {
        y = 16 - (t - 30) * 4; // back to 0
      } else if (t < 50) {
        y = 0;
      } else if (t < 58) {
        y = -math.sin((t - 50) / 8 * math.pi) * 10; // T wave
      } else {
        y = 0;
      }

      final Offset p = Offset(x, cy + y);
      if (first) {
        path.moveTo(p.dx, p.dy);
        first = false;
      } else {
        path.lineTo(p.dx, p.dy);
      }
    }
    canvas.drawPath(path, trace);

    // Bright cursor dot at wave leading edge.
    final double cursorX = size.width - 10;
    final Paint dot = Paint()..color = kCyan;
    canvas.drawCircle(Offset(cursorX, cy), 4, dot);
    final Paint glow = Paint()
      ..color = kCyan.withValues(alpha: 0.35)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
    canvas.drawCircle(Offset(cursorX, cy), 8, glow);
  }

  @override
  bool shouldRepaint(covariant _EcgPainter oldDelegate) =>
      oldDelegate.phase != phase;
}

// ---------------------------------------------------------------------------
// Section divider.
// ---------------------------------------------------------------------------

class _SectionDivider extends StatelessWidget {
  const _SectionDivider(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 8),
      child: Row(
        children: <Widget>[
          Container(width: 6, height: 22, color: kElectricBlue),
          const SizedBox(width: 10),
          Text(
            title,
            style: const TextStyle(
              color: kInk,
              fontSize: 16,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.2,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(child: Divider(color: kGridLine, thickness: 1)),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Live telemetry section — ListView + gauges + parallax + collapsing header.
// ---------------------------------------------------------------------------

class _LiveTelemetrySection extends StatelessWidget {
  const _LiveTelemetrySection({
    required this.pixels,
    required this.lastDelta,
    required this.velocity,
    required this.distance,
    required this.nearBottom,
    required this.loadMoreCtrl,
    required this.userDriven,
    required this.maxExtent,
    required this.frameCount,
  });

  final ValueNotifier<double> pixels;
  final ValueNotifier<double> lastDelta;
  final ValueNotifier<double> velocity;
  final ValueNotifier<double> distance;
  final ValueNotifier<bool> nearBottom;
  final AnimationController loadMoreCtrl;
  final ValueNotifier<bool> userDriven;
  final ValueNotifier<double> maxExtent;
  final ValueNotifier<int> frameCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
      child: Column(
        children: <Widget>[
          _CollapsingStickyHeader(pixels: pixels),
          const SizedBox(height: 10),
          _ScrollViewport(
            pixels: pixels,
            nearBottom: nearBottom,
            loadMoreCtrl: loadMoreCtrl,
          ),
          const SizedBox(height: 14),
          _GaugeRow(
            pixels: pixels,
            lastDelta: lastDelta,
            velocity: velocity,
            distance: distance,
          ),
          const SizedBox(height: 10),
          _ProgressBarRow(pixels: pixels, maxExtent: maxExtent),
          const SizedBox(height: 10),
          _SessionChipsRow(
              userDriven: userDriven,
              frameCount: frameCount,
              nearBottom: nearBottom),
        ],
      ),
    );
  }
}

class _CollapsingStickyHeader extends StatelessWidget {
  const _CollapsingStickyHeader({required this.pixels});

  final ValueNotifier<double> pixels;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
      valueListenable: pixels,
      builder: (BuildContext context, double px, Widget? _) {
        final double t = (px / 100).clamp(0.0, 1.0);
        final double h = 120 - (120 - 48) * t;
        final double fontT = 22 - (22 - 14) * t;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 60),
          height: h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                kElectricBlue.withValues(alpha: 1 - t * 0.3),
                kCyan.withValues(alpha: 1 - t * 0.3),
              ],
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: kElectricBlue.withValues(alpha: 0.25),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8 + 10 * (1 - t)),
          alignment: Alignment.centerLeft,
          child: Row(
            children: <Widget>[
              const Icon(Icons.push_pin, color: kPaper, size: 20),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Sticky header (collapses 120 -> 48 as you scroll 0 -> 100 px)',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: kPaper,
                    fontSize: fontT,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: kPaper.withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text('${(t * 100).toStringAsFixed(0)}%',
                    style: const TextStyle(
                        color: kPaper,
                        fontWeight: FontWeight.w700,
                        fontSize: 12)),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ScrollViewport extends StatefulWidget {
  const _ScrollViewport({
    required this.pixels,
    required this.nearBottom,
    required this.loadMoreCtrl,
  });

  final ValueNotifier<double> pixels;
  final ValueNotifier<bool> nearBottom;
  final AnimationController loadMoreCtrl;

  @override
  State<_ScrollViewport> createState() => _ScrollViewportState();
}

class _ScrollViewportState extends State<_ScrollViewport> {
  final ScrollController _inner = ScrollController();

  @override
  void dispose() {
    _inner.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: kPaper,
        border: Border.all(color: kGridLine),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: kInk.withValues(alpha: 0.06),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: <Widget>[
          // Parallax gradient header — moves 0.3x scroll speed.
          ValueListenableBuilder<double>(
            valueListenable: widget.pixels,
            builder: (BuildContext context, double px, Widget? _) {
              return Positioned(
                left: 0,
                right: 0,
                top: 0,
                height: 140,
                child: Transform(
                  transform: Matrix4.translationValues(0, -px * 0.3, 0),
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: <Color>[kCyan, kElectricBlue, kInk],
                      ),
                    ),
                    alignment: Alignment.bottomLeft,
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      'parallax 0.3x  |  px=${px.toStringAsFixed(1)}',
                      style: const TextStyle(
                        color: kPaper,
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          // The actual scrollable.
          Positioned.fill(
            child: ListView.builder(
              controller: _inner,
              padding: const EdgeInsets.fromLTRB(12, 88, 12, 64),
              itemCount: 50,
              itemBuilder: (BuildContext context, int i) {
                return _SampleTile(index: i);
              },
            ),
          ),
          // Load-more toast near bottom.
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: AnimatedBuilder(
              animation: widget.loadMoreCtrl,
              builder: (BuildContext context, Widget? _) {
                final double v = widget.loadMoreCtrl.value;
                return Opacity(
                  opacity: v,
                  child: Transform.translate(
                    offset: Offset(0, (1 - v) * 24),
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                        color: kAmber,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: kAmber.withValues(alpha: 0.4),
                            blurRadius: 16,
                          ),
                        ],
                      ),
                      child: const Row(
                        children: <Widget>[
                          Icon(Icons.download, color: kInk, size: 18),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Near bottom — pixels > maxExtent - 200. Load more!',
                              style: TextStyle(
                                  color: kInk, fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
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

class _SampleTile extends StatelessWidget {
  const _SampleTile({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final List<String> titles = <String>[
      'Frame-by-frame analytics',
      'Parallax backgrounds',
      'Sticky header collapse',
      'Pull-to-refresh feel',
      'Infinite scrolling lists',
      'Velocity-aware animations',
      'Scroll-driven storytelling',
      'Snap to section boundaries',
      'Chat auto-scroll heuristics',
      'Scroll progress indicators',
    ];
    final String title = titles[index % titles.length];
    final Color accent = index.isEven ? kElectricBlue : kCyan;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: kSurface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: kGridLine),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: Text('${index + 1}',
                style: TextStyle(color: accent, fontWeight: FontWeight.w800)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title,
                    style: const TextStyle(
                        color: kInk,
                        fontWeight: FontWeight.w700,
                        fontSize: 13)),
                const SizedBox(height: 2),
                const Text(
                  'Driven by ScrollUpdateNotification each frame of the scroll.',
                  style: TextStyle(color: kMuted, fontSize: 11),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: kMuted),
        ],
      ),
    );
  }
}

class _GaugeRow extends StatelessWidget {
  const _GaugeRow({
    required this.pixels,
    required this.lastDelta,
    required this.velocity,
    required this.distance,
  });

  final ValueNotifier<double> pixels;
  final ValueNotifier<double> lastDelta;
  final ValueNotifier<double> velocity;
  final ValueNotifier<double> distance;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: ValueListenableBuilder<double>(
            valueListenable: pixels,
            builder: (BuildContext context, double v, Widget? _) {
              return _Gauge(
                label: 'metrics.pixels',
                value: v.toStringAsFixed(1),
                unit: 'px',
                accent: kElectricBlue,
                icon: Icons.straighten,
              );
            },
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: ValueListenableBuilder<double>(
            valueListenable: lastDelta,
            builder: (BuildContext context, double v, Widget? _) {
              final IconData arrow =
                  v > 0 ? Icons.arrow_downward : (v < 0 ? Icons.arrow_upward : Icons.remove);
              final Color c = v > 0 ? kRose : (v < 0 ? kLime : kMuted);
              return _Gauge(
                label: 'scrollDelta',
                value: v.toStringAsFixed(2),
                unit: 'px/frame',
                accent: c,
                icon: arrow,
              );
            },
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: ValueListenableBuilder<double>(
            valueListenable: velocity,
            builder: (BuildContext context, double v, Widget? _) {
              return _Gauge(
                label: 'velocity (smooth)',
                value: v.toStringAsFixed(0),
                unit: 'px/s',
                accent: kViolet,
                icon: Icons.speed,
              );
            },
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: ValueListenableBuilder<double>(
            valueListenable: distance,
            builder: (BuildContext context, double v, Widget? _) {
              return _Gauge(
                label: 'cumulative',
                value: v.toStringAsFixed(0),
                unit: 'px total',
                accent: kCyan,
                icon: Icons.timeline,
              );
            },
          ),
        ),
      ],
    );
  }
}

class _Gauge extends StatelessWidget {
  const _Gauge({
    required this.label,
    required this.value,
    required this.unit,
    required this.accent,
    required this.icon,
  });

  final String label;
  final String value;
  final String unit;
  final Color accent;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: kPaper,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: kGridLine),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: kInk.withValues(alpha: 0.05),
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
              Icon(icon, color: accent, size: 16),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: kMuted,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              color: accent,
              fontSize: 20,
              fontWeight: FontWeight.w800,
              fontFamily: 'monospace',
            ),
          ),
          Text(
            unit,
            style: const TextStyle(color: kMuted, fontSize: 10),
          ),
        ],
      ),
    );
  }
}

class _ProgressBarRow extends StatelessWidget {
  const _ProgressBarRow({required this.pixels, required this.maxExtent});

  final ValueNotifier<double> pixels;
  final ValueNotifier<double> maxExtent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: kPaper,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: kGridLine),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Row(
            children: <Widget>[
              Icon(Icons.rule, color: kElectricBlue, size: 16),
              SizedBox(width: 6),
              Text('pixels / maxScrollExtent',
                  style: TextStyle(
                      color: kInk, fontWeight: FontWeight.w700, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 8),
          ValueListenableBuilder<double>(
            valueListenable: pixels,
            builder: (BuildContext context, double px, Widget? _) {
              return ValueListenableBuilder<double>(
                valueListenable: maxExtent,
                builder: (BuildContext context, double mx, Widget? _) {
                  final double frac = (px / mx).clamp(0.0, 1.0);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      LayoutBuilder(
                        builder: (BuildContext context, BoxConstraints cs) {
                          return Stack(
                            children: <Widget>[
                              Container(
                                height: 10,
                                width: cs.maxWidth,
                                decoration: BoxDecoration(
                                  color: kGridLine,
                                  borderRadius: BorderRadius.circular(999),
                                ),
                              ),
                              Container(
                                height: 10,
                                width: cs.maxWidth * frac,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: <Color>[kElectricBlue, kCyan],
                                  ),
                                  borderRadius: BorderRadius.circular(999),
                                ),
                              ),
                              // Threshold marker at 200 px from end.
                              Positioned(
                                left: cs.maxWidth *
                                    ((mx - 200) / mx).clamp(0.0, 1.0),
                                child: Container(
                                  height: 10,
                                  width: 2,
                                  color: kAmber,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: <Widget>[
                          Text('${px.toStringAsFixed(1)} px',
                              style: const TextStyle(
                                  color: kInk,
                                  fontFamily: 'monospace',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 11)),
                          const Spacer(),
                          Text('max ${mx.toStringAsFixed(0)} px',
                              style: const TextStyle(
                                  color: kMuted,
                                  fontFamily: 'monospace',
                                  fontSize: 11)),
                        ],
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class _SessionChipsRow extends StatelessWidget {
  const _SessionChipsRow({
    required this.userDriven,
    required this.frameCount,
    required this.nearBottom,
  });

  final ValueNotifier<bool> userDriven;
  final ValueNotifier<int> frameCount;
  final ValueNotifier<bool> nearBottom;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: ValueListenableBuilder<bool>(
            valueListenable: userDriven,
            builder: (BuildContext context, bool v, Widget? _) {
              return _StatusChip(
                label: v ? 'USER DRIVEN' : 'PROGRAMMATIC',
                color: v ? kLime : kViolet,
                icon: v ? Icons.touch_app : Icons.play_arrow,
              );
            },
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: ValueListenableBuilder<int>(
            valueListenable: frameCount,
            builder: (BuildContext context, int v, Widget? _) {
              return _StatusChip(
                label: 'frames: $v',
                color: kElectricBlue,
                icon: Icons.rotate_right,
              );
            },
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: ValueListenableBuilder<bool>(
            valueListenable: nearBottom,
            builder: (BuildContext context, bool v, Widget? _) {
              return _StatusChip(
                label: v ? 'NEAR BOTTOM' : 'scrolling',
                color: v ? kAmber : kMuted,
                icon: v ? Icons.warning_amber : Icons.south,
              );
            },
          ),
        ),
      ],
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip(
      {required this.label, required this.color, required this.icon});

  final String label;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, color: color, size: 14),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w800,
                fontSize: 11,
                letterSpacing: 0.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Sparkline panel.
// ---------------------------------------------------------------------------

class _SparklinePanel extends StatelessWidget {
  const _SparklinePanel({required this.samples, required this.tick});

  final List<double> samples;
  final ValueNotifier<int> tick;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
      child: Container(
        height: 170,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: kPaper,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: kGridLine),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: kInk.withValues(alpha: 0.05),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Row(
              children: <Widget>[
                Icon(Icons.show_chart, color: kElectricBlue, size: 16),
                SizedBox(width: 6),
                Text('scrollDelta waveform',
                    style: TextStyle(
                        color: kInk,
                        fontWeight: FontWeight.w700,
                        fontSize: 12)),
                Spacer(),
                Text('positive = down, negative = up',
                    style: TextStyle(color: kMuted, fontSize: 10)),
              ],
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ValueListenableBuilder<int>(
                valueListenable: tick,
                builder: (BuildContext context, int _, Widget? child) {
                  return CustomPaint(
                    painter: _SparkPainter(List<double>.unmodifiable(samples)),
                    size: Size.infinite,
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

class _SparkPainter extends CustomPainter {
  _SparkPainter(this.samples);

  final List<double> samples;

  @override
  void paint(Canvas canvas, Size size) {
    // Background grid.
    final Paint grid = Paint()..color = kGridLine;
    for (int i = 1; i < 4; i++) {
      final double y = size.height * i / 4;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }

    final double cy = size.height / 2;
    final Paint zero = Paint()
      ..color = kInk.withValues(alpha: 0.35)
      ..strokeWidth = 1;
    canvas.drawLine(Offset(0, cy), Offset(size.width, cy), zero);

    if (samples.isEmpty) {
      final TextPainter tp = TextPainter(
        text: const TextSpan(
            text: 'scroll the list to generate samples',
            style: TextStyle(color: kMuted, fontSize: 12)),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset((size.width - tp.width) / 2, cy - tp.height / 2));
      return;
    }

    // Symmetric auto-range with floor.
    double maxAbs = 5;
    for (final double s in samples) {
      if (s.abs() > maxAbs) maxAbs = s.abs();
    }

    final double dx = size.width / (samples.length - 1).clamp(1, 1000);
    final Path path = Path();
    final Path fill = Path()..moveTo(0, cy);
    for (int i = 0; i < samples.length; i++) {
      final double x = i * dx;
      final double norm = (samples[i] / maxAbs).clamp(-1.0, 1.0);
      final double y = cy - norm * (size.height / 2 - 6);
      if (i == 0) {
        path.moveTo(x, y);
        fill.lineTo(x, y);
      } else {
        path.lineTo(x, y);
        fill.lineTo(x, y);
      }
    }
    fill
      ..lineTo(size.width, cy)
      ..close();

    final Paint fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[
          kElectricBlue.withValues(alpha: 0.28),
          kElectricBlue.withValues(alpha: 0.02),
        ],
      ).createShader(Offset.zero & size);
    canvas.drawPath(fill, fillPaint);

    final Paint stroke = Paint()
      ..color = kElectricBlue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8
      ..strokeJoin = StrokeJoin.round
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(path, stroke);

    // Latest point highlight.
    if (samples.isNotEmpty) {
      final double norm = (samples.last / maxAbs).clamp(-1.0, 1.0);
      final double y = cy - norm * (size.height / 2 - 6);
      canvas.drawCircle(Offset(size.width, y), 3.5, Paint()..color = kCyan);
    }
  }

  @override
  bool shouldRepaint(covariant _SparkPainter oldDelegate) =>
      oldDelegate.samples != samples;
}

// ---------------------------------------------------------------------------
// Histogram panel.
// ---------------------------------------------------------------------------

class _HistogramPanel extends StatelessWidget {
  const _HistogramPanel({required this.buckets, required this.tick});

  final List<int> buckets;
  final ValueNotifier<int> tick;

  Color _bucketColor(int i) {
    // Magnitude colouring: 4 is zero-bucket, further from 4 = hotter.
    final int dist = (i - 4).abs();
    switch (dist) {
      case 0:
        return kMuted;
      case 1:
        return kLime;
      case 2:
        return kElectricBlue;
      case 3:
        return kAmber;
      default:
        return kRose;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: kPaper,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: kGridLine),
        ),
        child: ValueListenableBuilder<int>(
          valueListenable: tick,
          builder: (BuildContext context, int _, Widget? child) {
            final int maxV = buckets.fold<int>(
                1, (int acc, int v) => v > acc ? v : acc);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    const Icon(Icons.bar_chart,
                        color: kElectricBlue, size: 16),
                    const SizedBox(width: 6),
                    const Text('Delta bucket counts',
                        style: TextStyle(
                            color: kInk,
                            fontWeight: FontWeight.w700,
                            fontSize: 12)),
                    const Spacer(),
                    Text('max $maxV',
                        style:
                            const TextStyle(color: kMuted, fontSize: 10)),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 130,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: List<Widget>.generate(buckets.length, (int i) {
                      final double h =
                          120 * (buckets[i] / maxV).clamp(0.0, 1.0);
                      final Color c = _bucketColor(i);
                      return Expanded(
                        child: Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 2),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text('${buckets[i]}',
                                  style: TextStyle(
                                      color: c,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700)),
                              const SizedBox(height: 2),
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 120),
                                height: h + 4,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(6)),
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: <Color>[
                                      c,
                                      c.withValues(alpha: 0.5),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: List<Widget>.generate(kBucketLabels.length, (int i) {
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: Text(
                          kBucketLabels[i],
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: kMuted,
                              fontSize: 9,
                              fontFamily: 'monospace'),
                        ),
                      ),
                    );
                  }),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Recent updates — USER vs PROG chips.
// ---------------------------------------------------------------------------

class _TelemetryEntry {
  _TelemetryEntry({
    required this.pixels,
    required this.delta,
    required this.userDriven,
    required this.stamp,
  });

  final double pixels;
  final double delta;
  final bool userDriven;
  final DateTime stamp;
}

class _RecentUpdatesPanel extends StatelessWidget {
  const _RecentUpdatesPanel({required this.recent, required this.tick});

  final List<_TelemetryEntry> recent;
  final ValueNotifier<int> tick;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: kPaper,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: kGridLine),
        ),
        child: ValueListenableBuilder<int>(
          valueListenable: tick,
          builder: (BuildContext context, int _, Widget? child) {
            if (recent.isEmpty) {
              return const SizedBox(
                height: 80,
                child: Center(
                  child: Text(
                    'Scroll the list above to log updates here.',
                    style: TextStyle(color: kMuted),
                  ),
                ),
              );
            }
            return Column(
              children: recent.map(_entryRow).toList(),
            );
          },
        ),
      ),
    );
  }

  Widget _entryRow(_TelemetryEntry e) {
    final Color chipColor = e.userDriven ? kLime : kViolet;
    final Color deltaColor =
        e.delta > 0 ? kRose : (e.delta < 0 ? kLime : kMuted);
    final IconData arrow = e.delta > 0
        ? Icons.arrow_downward
        : (e.delta < 0 ? Icons.arrow_upward : Icons.remove);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: chipColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: chipColor.withValues(alpha: 0.5)),
            ),
            child: Text(
              e.userDriven ? 'USER' : 'PROG',
              style: TextStyle(
                  color: chipColor,
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.6),
            ),
          ),
          const SizedBox(width: 10),
          Icon(arrow, color: deltaColor, size: 14),
          const SizedBox(width: 4),
          Text(
            e.delta.toStringAsFixed(2),
            style: TextStyle(
              color: deltaColor,
              fontWeight: FontWeight.w700,
              fontFamily: 'monospace',
              fontSize: 12,
            ),
          ),
          const Spacer(),
          Text(
            'px=${e.pixels.toStringAsFixed(1)}',
            style: const TextStyle(
                color: kInk,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w600,
                fontSize: 12),
          ),
          const SizedBox(width: 12),
          Text(
            '${e.stamp.hour.toString().padLeft(2, '0')}:${e.stamp.minute.toString().padLeft(2, '0')}:${e.stamp.second.toString().padLeft(2, '0')}',
            style: const TextStyle(
                color: kMuted, fontFamily: 'monospace', fontSize: 11),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Anatomy card.
// ---------------------------------------------------------------------------

class _AnatomyCard extends StatelessWidget {
  const _AnatomyCard();

  static const List<List<String>> _rows = <List<String>>[
    <String>['metrics', 'ScrollMetrics',
        'Absolute position: pixels, min/maxScrollExtent, viewportDimension, axis.'],
    <String>['context', 'BuildContext?',
        'The BuildContext of the notifying Scrollable — use to look up inherited widgets.'],
    <String>['scrollDelta', 'double?',
        'The INCREMENTAL pixel change this frame. null when reserved; typically non-null.'],
    <String>['dragDetails', 'DragUpdateDetails?',
        'Non-null only when this update comes from a user drag. null during ballistic / programmatic.'],
    <String>['depth', 'int',
        'Inherited from ScrollNotification — nesting level inside other scrollables.'],
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: kPaper,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: kGridLine),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Row(
              children: <Widget>[
                Icon(Icons.account_tree, color: kElectricBlue, size: 18),
                SizedBox(width: 8),
                Text('Fields of ScrollUpdateNotification',
                    style: TextStyle(
                        color: kInk,
                        fontWeight: FontWeight.w800,
                        fontSize: 15)),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: const <Widget>[
                SizedBox(
                    width: 120,
                    child: Text('Field',
                        style: TextStyle(
                            color: kMuted,
                            fontWeight: FontWeight.w700,
                            fontSize: 11))),
                SizedBox(
                    width: 130,
                    child: Text('Type',
                        style: TextStyle(
                            color: kMuted,
                            fontWeight: FontWeight.w700,
                            fontSize: 11))),
                Expanded(
                  child: Text('Meaning',
                      style: TextStyle(
                          color: kMuted,
                          fontWeight: FontWeight.w700,
                          fontSize: 11)),
                ),
              ],
            ),
            const Divider(color: kGridLine, height: 16),
            ..._rows.map(_row),
          ],
        ),
      ),
    );
  }

  Widget _row(List<String> r) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
              width: 120,
              child: Text(r[0],
                  style: const TextStyle(
                    color: kElectricBlue,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ))),
          SizedBox(
              width: 130,
              child: Text(r[1],
                  style: const TextStyle(
                    color: kViolet,
                    fontFamily: 'monospace',
                    fontSize: 12,
                  ))),
          Expanded(
            child: Text(r[2],
                style: const TextStyle(
                    color: kInk, fontSize: 12, height: 1.35)),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Teaching panel.
// ---------------------------------------------------------------------------

class _TeachingPanel extends StatelessWidget {
  const _TeachingPanel();

  static const List<Map<String, String>> _tiles = <Map<String, String>>[
    <String, String>{
      'title': 'Fires every frame',
      'body':
          'ScrollUpdateNotification fires EVERY frame of a scroll — handlers must be cheap. Avoid allocations, avoid layout, avoid synchronous logs.',
    },
    <String, String>{
      'title': 'Avoid setState per frame',
      'body':
          'Use ValueNotifier + ValueListenableBuilder for the reactive parts. setState would rebuild the whole subtree at 60 Hz.',
    },
    <String, String>{
      'title': 'scrollDelta is incremental',
      'body':
          'Integrate over time for total distance (sum |scrollDelta|). Differentiate over time for velocity. Divide by frame duration for px/s.',
    },
    <String, String>{
      'title': 'Delta vs pixels',
      'body':
          'Do not confuse scrollDelta (incremental, per-frame) with metrics.pixels (absolute, cumulative). They answer different questions.',
    },
    <String, String>{
      'title': 'User vs ballistic',
      'body':
          'dragDetails is non-null only during a finger drag. During the subsequent fling (BallisticScrollActivity), updates still fire but dragDetails is null.',
    },
    <String, String>{
      'title': 'Returning false',
      'body':
          'Return false from NotificationListener.onNotification to let the notification continue bubbling. Return true to stop it.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints cs) {
          final int cols = cs.maxWidth > 700 ? 3 : (cs.maxWidth > 420 ? 2 : 1);
          return GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: cols,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: cols == 1 ? 3.3 : (cols == 2 ? 1.8 : 1.4),
            children: _tiles.map(_buildTile).toList(),
          );
        },
      ),
    );
  }

  Widget _buildTile(Map<String, String> t) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[kPaper, kSurface],
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: kGridLine),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: kElectricBlue.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: kElectricBlue.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: const Icon(Icons.lightbulb, color: kElectricBlue, size: 16),
          ),
          const SizedBox(height: 8),
          Text(
            t['title']!,
            style: const TextStyle(
                color: kInk, fontWeight: FontWeight.w800, fontSize: 13),
          ),
          const SizedBox(height: 6),
          Expanded(
            child: Text(
              t['body']!,
              style: const TextStyle(
                  color: kMuted, fontSize: 12, height: 1.35),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Footer summary.
// ---------------------------------------------------------------------------

class _FooterSummary extends StatelessWidget {
  const _FooterSummary();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[kInk, kElectricBlue],
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: kElectricBlue.withValues(alpha: 0.2),
              blurRadius: 18,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Row(
              children: <Widget>[
                Icon(Icons.flag, color: kCyan, size: 20),
                SizedBox(width: 8),
                Text('Scroll Pulse Telemetry — recap',
                    style: TextStyle(
                        color: kPaper,
                        fontSize: 16,
                        fontWeight: FontWeight.w800)),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'ScrollUpdateNotification is the per-frame signal that drives parallax, sticky-header collapse, velocity analytics, '
              'infinite-scroll thresholding and scroll-driven UX. Listen via NotificationListener<ScrollUpdateNotification>, keep '
              'your handler cheap, push state into ValueNotifiers, and trust that each frame of drag + ballistic phases will '
              'produce exactly one notification with scrollDelta describing the change and dragDetails telling you who caused it.',
              style: TextStyle(
                  color: kPaper.withValues(alpha: 0.9),
                  fontSize: 12,
                  height: 1.5),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: const <Widget>[
                _FooterPill('NotificationListener<ScrollUpdateNotification>'),
                _FooterPill('scrollDelta'),
                _FooterPill('dragDetails == null -> ballistic/programmatic'),
                _FooterPill('ValueNotifier over setState'),
                _FooterPill('integrate for distance'),
                _FooterPill('differentiate for velocity'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _FooterPill extends StatelessWidget {
  const _FooterPill(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: kPaper.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: kPaper.withValues(alpha: 0.35)),
      ),
      child: Text(
        label,
        style: const TextStyle(
            color: kPaper,
            fontFamily: 'monospace',
            fontSize: 11,
            fontWeight: FontWeight.w600),
      ),
    );
  }
}
