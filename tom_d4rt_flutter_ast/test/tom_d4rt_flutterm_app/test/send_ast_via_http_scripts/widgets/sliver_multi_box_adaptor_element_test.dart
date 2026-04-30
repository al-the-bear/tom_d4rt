// ---------------------------------------------------------------------------
// SliverMultiBoxAdaptorElement — Element Lifecycle Observatory
// ---------------------------------------------------------------------------
// This file is a hand-authored visual demo for the ELEMENT TIER of the
// SliverMultiBoxAdaptor family. Where `sliver_multi_box_adaptor_widget_test`
// explores the widget configuration contract, this file focuses on the
// element-tier lifecycle machine: how `SliverMultiBoxAdaptorElement` creates,
// updates, recycles, reorders and forgets child Element instances under the
// direction of a `SliverChildDelegate` and the render object below it.
//
// The scenes are designed as a single-screen "Observatory":
//   1. Hero header           — radar sweep over a logical element grid
//   2. Lifecycle ring buffer — three stacked slivers: mount → layout → recycle
//   3. Dart signature card   — real method signatures with inline gloss
//   4. Keyed child cache     — 6×3 cell painter; tap to highlight + fade peers
//   5. Triple sliver stage   — SliverList / SliverGrid / SliverFixedExtentList
//                              each with a pixel-extent ruler gutter
//   6. Pitfall card          — why direct instantiation is wrong
//   7. Timeline strip        — mount / build / update / layout / paint /
//                              recycle / forget stations joined by arrows
//
// Palette is an obsidian instrument panel:
//   * Background : 0xFF0F1216
//   * Phosphor   : 0xFF7CFFB7   (accent, active / alive states)
//   * Amber      : 0xFFFFC857   (attention, warm / cached states)
//
// The entry point follows the d4rt AST harness convention: a single top-level
//   dynamic build(BuildContext context) => MaterialApp(home: ...)
// No main(), no runApp(), imports limited to material + dart:math.
// ---------------------------------------------------------------------------

import 'dart:math' as math;

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Palette and typography constants (observatory-wide).
// ---------------------------------------------------------------------------

const Color _smbaeObsidian = Color(0xFF0F1216);
const Color _smbaeObsidianSoft = Color(0xFF141923);
const Color _smbaeObsidianHigh = Color(0xFF1B2230);
const Color _smbaePhosphor = Color(0xFF7CFFB7);
const Color _smbaePhosphorDim = Color(0xFF3FA574);
const Color _smbaeAmber = Color(0xFFFFC857);
const Color _smbaeInk = Color(0xFFE8EEF2);
const Color _smbaeInkSoft = Color(0xFFB6C1C9);
const Color _smbaeInkFaint = Color(0xFF6E7A84);
const Color _smbaeGrid = Color(0xFF20283A);

const double _smbaeHeroHeight = 260.0;
const double _smbaeCardRadius = 14.0;
const double _smbaeGutterWidth = 56.0;

// ---------------------------------------------------------------------------
// Entry point — d4rt AST harness.
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  return const MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'SliverMultiBoxAdaptorElement Observatory',
    home: _SmbaeObservatoryHome(),
  );
}

// ---------------------------------------------------------------------------
// _SmbaeObservatoryHome — top-level scaffold.
// ---------------------------------------------------------------------------

class _SmbaeObservatoryHome extends StatefulWidget {
  const _SmbaeObservatoryHome();

  @override
  State<_SmbaeObservatoryHome> createState() => _SmbaeObservatoryHomeState();
}

class _SmbaeObservatoryHomeState extends State<_SmbaeObservatoryHome>
    with TickerProviderStateMixin {
  late final AnimationController _radarController;
  late final AnimationController _pulseController;
  late final AnimationController _timelineController;
  int _selectedCacheCell = 7;

  @override
  void initState() {
    super.initState();
    _radarController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);
    _timelineController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();
  }

  @override
  void dispose() {
    _radarController.dispose();
    _pulseController.dispose();
    _timelineController.dispose();
    super.dispose();
  }

  void _onCacheCellTapped(int index) {
    setState(() {
      _selectedCacheCell = index;
    });
    debugPrint('Smbae cache cell selected: $index');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _smbaeObsidian,
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: _SmbaeHeroHeader(
                radar: _radarController,
                pulse: _pulseController,
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
            SliverToBoxAdapter(
              child: _SmbaeLifecycleRingBufferPanel(pulse: _pulseController),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
            const SliverToBoxAdapter(child: _SmbaeSignatureCard()),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
            SliverToBoxAdapter(
              child: _SmbaeKeyedCacheVisualisation(
                selectedIndex: _selectedCacheCell,
                onTap: _onCacheCellTapped,
                pulse: _pulseController,
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
            const SliverToBoxAdapter(child: _SmbaeTripleSliverStageHeader()),
            const SliverToBoxAdapter(child: SizedBox(height: 8)),
            const _SmbaeRulerListSliver(),
            const SliverToBoxAdapter(child: _SmbaeStageDivider(label: 'GRID')),
            const _SmbaeRulerGridSliver(),
            const SliverToBoxAdapter(child: _SmbaeStageDivider(label: 'FIXED')),
            const _SmbaeRulerFixedExtentSliver(),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
            const SliverToBoxAdapter(child: _SmbaePitfallCard()),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
            SliverToBoxAdapter(
              child: _SmbaeTimelineStrip(timeline: _timelineController),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 40)),
            const SliverToBoxAdapter(child: _SmbaeFooterBar()),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Hero header — radar sweep over a logical element grid.
// ---------------------------------------------------------------------------

class _SmbaeHeroHeader extends StatelessWidget {
  const _SmbaeHeroHeader({required this.radar, required this.pulse});

  final AnimationController radar;
  final AnimationController pulse;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _smbaeHeroHeight,
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(_smbaeCardRadius),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[_smbaeObsidianSoft, _smbaeObsidian],
        ),
        border: Border.all(color: (_smbaePhosphor ?? const Color(0xFF000000)).withValues(alpha: 0.18)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          AnimatedBuilder(
            animation: Listenable.merge(<Listenable>[radar, pulse]),
            builder: (BuildContext context, Widget? child) {
              return CustomPaint(
                painter: _SmbaeRadarPainter(
                  sweep: radar.value,
                  pulse: pulse.value,
                ),
              );
            },
          ),
          const Positioned(
            left: 24,
            top: 24,
            right: 24,
            child: _SmbaeHeroTitleBlock(),
          ),
          Positioned(
            left: 24,
            right: 24,
            bottom: 20,
            child: _SmbaeHeroLegend(pulse: pulse),
          ),
        ],
      ),
    );
  }
}

class _SmbaeHeroTitleBlock extends StatelessWidget {
  const _SmbaeHeroTitleBlock();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: (_smbaePhosphor ?? const Color(0xFF000000)).withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: (_smbaePhosphor ?? const Color(0xFF000000)).withValues(alpha: 0.5)),
          ),
          alignment: Alignment.center,
          child: const Icon(Icons.radar, color: _smbaePhosphor, size: 28),
        ),
        const SizedBox(width: 16),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'SliverMultiBoxAdaptorElement',
                style: TextStyle(
                  color: _smbaeInk,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.4,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Element-tier lifecycle engine for SliverList / SliverGrid / SliverFixedExtentList',
                style: TextStyle(
                  color: _smbaeInkSoft,
                  fontSize: 13,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
        _SmbaeHeroBadge(label: 'ELEMENT', tone: _smbaePhosphor),
        const SizedBox(width: 8),
        _SmbaeHeroBadge(label: 'TIER 2', tone: _smbaeAmber),
      ],
    );
  }
}

class _SmbaeHeroBadge extends StatelessWidget {
  const _SmbaeHeroBadge({required this.label, required this.tone});

  final String label;
  final Color tone;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: (tone ?? const Color(0xFF000000)).withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: (tone ?? const Color(0xFF000000)).withValues(alpha: 0.5)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: tone,
          fontSize: 10,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.4,
        ),
      ),
    );
  }
}

class _SmbaeHeroLegend extends StatelessWidget {
  const _SmbaeHeroLegend({required this.pulse});

  final AnimationController pulse;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: pulse,
      builder: (BuildContext context, Widget? child) {
        final double p = 0.4 + 0.6 * pulse.value;
        return Row(
          children: <Widget>[
            _legendDot((_smbaePhosphor ?? const Color(0xFF000000)).withValues(alpha: p), 'mounted'),
            const SizedBox(width: 18),
            _legendDot((_smbaeAmber ?? const Color(0xFF000000)).withValues(alpha: p), 'cached'),
            const SizedBox(width: 18),
            _legendDot(_smbaeInkFaint, 'forgotten'),
            const Spacer(),
            const Text(
              'sweep @ 60fps',
              style: TextStyle(
                color: _smbaeInkFaint,
                fontSize: 11,
                letterSpacing: 1.2,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _legendDot(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            color: _smbaeInkSoft,
            fontSize: 11,
            letterSpacing: 0.8,
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Radar painter — obsidian background, phosphor rings, amber sweep cone.
// ---------------------------------------------------------------------------

class _SmbaeRadarPainter extends CustomPainter {
  _SmbaeRadarPainter({required this.sweep, required this.pulse});

  final double sweep;
  final double pulse;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = _smbaeObsidian;
    canvas.drawRect(Offset.zero & size, bg);

    _paintBackgroundGrid(canvas, size);
    _paintRadarRings(canvas, size);
    _paintElementGrid(canvas, size);
    _paintSweepCone(canvas, size);
    _paintOscilloscopeTrace(canvas, size);
  }

  void _paintBackgroundGrid(Canvas canvas, Size size) {
    final Paint grid = Paint()
      ..color = (_smbaeGrid ?? const Color(0xFF000000)).withValues(alpha: 0.45)
      ..strokeWidth = 0.6;
    const double step = 24.0;
    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
    }
    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }
  }

  void _paintRadarRings(Canvas canvas, Size size) {
    final Offset center = Offset(size.width * 0.78, size.height * 0.58);
    final Paint ring = Paint()
      ..style = PaintingStyle.stroke
      ..color = (_smbaePhosphor ?? const Color(0xFF000000)).withValues(alpha: 0.28)
      ..strokeWidth = 1.1;
    for (int i = 1; i <= 4; i++) {
      canvas.drawCircle(center, i * 26.0, ring);
    }
    final Paint crosshair = Paint()
      ..color = (_smbaePhosphor ?? const Color(0xFF000000)).withValues(alpha: 0.4)
      ..strokeWidth = 0.8;
    canvas.drawLine(
      Offset(center.dx - 110, center.dy),
      Offset(center.dx + 110, center.dy),
      crosshair,
    );
    canvas.drawLine(
      Offset(center.dx, center.dy - 110),
      Offset(center.dx, center.dy + 110),
      crosshair,
    );
  }

  void _paintElementGrid(Canvas canvas, Size size) {
    final math.Random rng = math.Random(17);
    const int cols = 14;
    const int rows = 6;
    final double cellW = (size.width * 0.58) / cols;
    final double cellH = (size.height * 0.7) / rows;
    final double originX = 24;
    final double originY = size.height * 0.2;

    for (int r = 0; r < rows; r++) {
      for (int c = 0; c < cols; c++) {
        final double seed = rng.nextDouble();
        final Rect cell = Rect.fromLTWH(
          originX + c * cellW + 2,
          originY + r * cellH + 2,
          cellW - 4,
          cellH - 4,
        );
        final Color fill = seed < 0.18
            ? (_smbaeAmber ?? const Color(0xFF000000)).withValues(alpha: 0.35 + 0.25 * pulse)
            : seed < 0.62
                ? (_smbaePhosphor ?? const Color(0xFF000000)).withValues(alpha: 0.22 + 0.28 * pulse * seed)
                : (_smbaeInkFaint ?? const Color(0xFF000000)).withValues(alpha: 0.12);
        final Paint p = Paint()..color = fill;
        canvas.drawRRect(
          RRect.fromRectAndRadius(cell, const Radius.circular(2)),
          p,
        );
      }
    }
  }

  void _paintSweepCone(Canvas canvas, Size size) {
    final Offset center = Offset(size.width * 0.78, size.height * 0.58);
    final double angle = sweep * math.pi * 2;
    const double coneWidth = math.pi / 4;
    final Path cone = Path()
      ..moveTo(center.dx, center.dy)
      ..arcTo(
        Rect.fromCircle(center: center, radius: 108),
        angle - coneWidth,
        coneWidth,
        false,
      )
      ..close();
    final Paint glow = Paint()
      ..shader = SweepGradient(
        center: Alignment.center,
        colors: <Color>[
          (_smbaePhosphor ?? const Color(0xFF000000)).withValues(alpha: 0.0),
          (_smbaePhosphor ?? const Color(0xFF000000)).withValues(alpha: 0.35),
          (_smbaePhosphor ?? const Color(0xFF000000)).withValues(alpha: 0.0),
        ],
        startAngle: angle - coneWidth,
        endAngle: angle,
      ).createShader(Rect.fromCircle(center: center, radius: 108));
    canvas.drawPath(cone, glow);

    final Paint sweepLine = Paint()
      ..color = _smbaePhosphor
      ..strokeWidth = 1.4;
    canvas.drawLine(
      center,
      Offset(center.dx + math.cos(angle) * 108,
          center.dy + math.sin(angle) * 108),
      sweepLine,
    );
  }

  void _paintOscilloscopeTrace(Canvas canvas, Size size) {
    final Paint trace = Paint()
      ..color = (_smbaeAmber ?? const Color(0xFF000000)).withValues(alpha: 0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    final Path p = Path();
    final double baseY = size.height * 0.92;
    p.moveTo(0, baseY);
    for (double x = 0; x <= size.width; x += 4) {
      final double phase = (x / size.width) * math.pi * 4 + sweep * math.pi * 2;
      final double y = baseY - math.sin(phase) * 10 - math.cos(phase * 1.7) * 4;
      p.lineTo(x, y);
    }
    canvas.drawPath(p, trace);
  }

  @override
  bool shouldRepaint(covariant _SmbaeRadarPainter oldDelegate) {
    return oldDelegate.sweep != sweep || oldDelegate.pulse != pulse;
  }
}

// ---------------------------------------------------------------------------
// Lifecycle ring buffer panel — mount → layout → recycle.
// ---------------------------------------------------------------------------

class _SmbaeLifecycleRingBufferPanel extends StatelessWidget {
  const _SmbaeLifecycleRingBufferPanel({required this.pulse});

  final AnimationController pulse;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: _smbaePanelDecoration(),
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SmbaeSectionHeader(
            kicker: 'PANEL A',
            title: 'Lifecycle ring buffer',
            subtitle:
                'Three sliver bands showing active indices: mount candidates, '
                'laid-out children, and recycled slots waiting for reuse.',
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 210,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: _SmbaeRingBufferBand(
                    title: 'MOUNT',
                    tone: _smbaePhosphor,
                    entries: const <_SmbaeRingEntry>[
                      _SmbaeRingEntry('idx 12', 'createChild', true),
                      _SmbaeRingEntry('idx 13', 'createChild', false),
                      _SmbaeRingEntry('idx 14', 'createChild', true),
                      _SmbaeRingEntry('idx 15', 'createChild', false),
                      _SmbaeRingEntry('idx 16', 'createChild', true),
                    ],
                    pulse: pulse,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _SmbaeRingBufferBand(
                    title: 'LAYOUT',
                    tone: _smbaeAmber,
                    entries: const <_SmbaeRingEntry>[
                      _SmbaeRingEntry('idx 08', 'performLayout', true),
                      _SmbaeRingEntry('idx 09', 'performLayout', true),
                      _SmbaeRingEntry('idx 10', 'performLayout', true),
                      _SmbaeRingEntry('idx 11', 'performLayout', false),
                      _SmbaeRingEntry('idx 12', 'performLayout', true),
                    ],
                    pulse: pulse,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _SmbaeRingBufferBand(
                    title: 'RECYCLE',
                    tone: _smbaeInkFaint,
                    entries: const <_SmbaeRingEntry>[
                      _SmbaeRingEntry('idx 02', 'collectGarbage', true),
                      _SmbaeRingEntry('idx 03', 'collectGarbage', false),
                      _SmbaeRingEntry('idx 04', 'collectGarbage', true),
                      _SmbaeRingEntry('idx 05', 'collectGarbage', false),
                      _SmbaeRingEntry('idx 06', 'collectGarbage', true),
                    ],
                    pulse: pulse,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          const _SmbaeRingLegend(),
        ],
      ),
    );
  }
}

class _SmbaeRingEntry {
  const _SmbaeRingEntry(this.label, this.op, this.fresh);
  final String label;
  final String op;
  final bool fresh;
}

class _SmbaeRingBufferBand extends StatelessWidget {
  const _SmbaeRingBufferBand({
    required this.title,
    required this.tone,
    required this.entries,
    required this.pulse,
  });

  final String title;
  final Color tone;
  final List<_SmbaeRingEntry> entries;
  final AnimationController pulse;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _smbaeObsidian,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: (tone ?? const Color(0xFF000000)).withValues(alpha: 0.35)),
      ),
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(color: tone, shape: BoxShape.circle),
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  color: tone,
                  fontSize: 11,
                  letterSpacing: 1.4,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              Text(
                '${entries.length}',
                style: const TextStyle(
                  color: _smbaeInkFaint,
                  fontSize: 11,
                  fontFeatures: <FontFeature>[FontFeature.tabularFigures()],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Column(
              children: <Widget>[
                for (int i = 0; i < entries.length; i++)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: _SmbaeRingRow(
                        entry: entries[i],
                        tone: tone,
                        pulse: pulse,
                        index: i,
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

class _SmbaeRingRow extends StatelessWidget {
  const _SmbaeRingRow({
    required this.entry,
    required this.tone,
    required this.pulse,
    required this.index,
  });

  final _SmbaeRingEntry entry;
  final Color tone;
  final AnimationController pulse;
  final int index;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: pulse,
      builder: (BuildContext context, Widget? child) {
        final double t =
            ((pulse.value + index * 0.17) % 1.0).clamp(0.0, 1.0);
        final double blink = entry.fresh ? (0.35 + 0.65 * t) : 0.35;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: (tone ?? const Color(0xFF000000)).withValues(alpha: 0.06 + 0.10 * blink),
            borderRadius: BorderRadius.circular(4),
            border: Border(
              left: BorderSide(
                color: (tone ?? const Color(0xFF000000)).withValues(alpha: blink),
                width: 2,
              ),
            ),
          ),
          child: Row(
            children: <Widget>[
              Text(
                entry.label,
                style: const TextStyle(
                  color: _smbaeInk,
                  fontSize: 12,
                  fontFamily: 'monospace',
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  entry.op,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: _smbaeInkSoft,
                    fontSize: 11,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
              if (entry.fresh)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                  decoration: BoxDecoration(
                    color: (tone ?? const Color(0xFF000000)).withValues(alpha: 0.22),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Text(
                    'NEW',
                    style: TextStyle(
                      color: tone,
                      fontSize: 8,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.1,
                    ),
                  ),
                )
              else
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                  decoration: BoxDecoration(
                    color: (_smbaeInkFaint ?? const Color(0xFF000000)).withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: const Text(
                    'REUSE',
                    style: TextStyle(
                      color: _smbaeInkFaint,
                      fontSize: 8,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.1,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class _SmbaeRingLegend extends StatelessWidget {
  const _SmbaeRingLegend();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        _dot(_smbaePhosphor, 'createChild flushes widget from delegate'),
        const SizedBox(width: 22),
        _dot(_smbaeAmber, 'performLayout positions each RenderBox'),
        const SizedBox(width: 22),
        _dot(_smbaeInkFaint, 'collectGarbage releases offscreen slots'),
      ],
    );
  }

  Widget _dot(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(color: _smbaeInkSoft, fontSize: 11),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Signature card — real API signatures quoted with inline gloss.
// ---------------------------------------------------------------------------

class _SmbaeSignatureCard extends StatelessWidget {
  const _SmbaeSignatureCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: _smbaePanelDecoration(),
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          _SmbaeSectionHeader(
            kicker: 'PANEL B',
            title: 'Element API surface',
            subtitle:
                'Four hot paths that the render object below invokes during '
                'layout. Commentary is a condensed gloss, not a docstring.',
          ),
          SizedBox(height: 14),
          _SmbaeSignatureEntry(
            signature:
                'Element? createChild(int index, {required RenderBox? after})',
            returns: 'Element?',
            gloss:
                'Asks the delegate for the widget at `index`, inflates it into '
                'an Element, and inserts the Element so its RenderBox sits '
                'immediately after the one referenced by `after`.',
            tag: 'mount',
            tone: _smbaePhosphor,
          ),
          SizedBox(height: 10),
          _SmbaeSignatureEntry(
            signature: 'void removeChild(RenderBox child)',
            returns: 'void',
            gloss:
                'Detaches the Element that owns `child` and removes its '
                'RenderBox from the parent; the Element is then either '
                'recycled or forgotten.',
            tag: 'unmount',
            tone: _smbaeAmber,
          ),
          SizedBox(height: 10),
          _SmbaeSignatureEntry(
            signature:
                'double estimateMaxScrollOffset(SliverConstraints constraints, '
                '{int firstIndex, int lastIndex, double leadingScrollOffset, '
                'double trailingScrollOffset})',
            returns: 'double',
            gloss:
                'Forwards the delegate\'s best estimate of total scroll extent '
                'so the render object can compute scroll metrics before every '
                'child has materialised.',
            tag: 'metrics',
            tone: _smbaePhosphor,
          ),
          SizedBox(height: 10),
          _SmbaeSignatureEntry(
            signature:
                'void collectGarbage(int leadingGarbage, int trailingGarbage)',
            returns: 'void',
            gloss:
                'Releases out-of-viewport Elements in batches; keyed entries '
                'may be retained in the keyed-child cache for reuse on '
                'scroll reversal.',
            tag: 'recycle',
            tone: _smbaeInkFaint,
          ),
          SizedBox(height: 10),
          _SmbaeSignatureEntry(
            signature: 'void performRebuild()',
            returns: 'void',
            gloss:
                'Re-requests widgets from the delegate for every currently '
                'active index; used after hot-reload or delegate swap.',
            tag: 'rebuild',
            tone: _smbaeAmber,
          ),
        ],
      ),
    );
  }
}

class _SmbaeSignatureEntry extends StatelessWidget {
  const _SmbaeSignatureEntry({
    required this.signature,
    required this.returns,
    required this.gloss,
    required this.tag,
    required this.tone,
  });

  final String signature;
  final String returns;
  final String gloss;
  final String tag;
  final Color tone;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 12),
      decoration: BoxDecoration(
        color: _smbaeObsidian,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: (tone ?? const Color(0xFF000000)).withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: (tone ?? const Color(0xFF000000)).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(3),
                  border: Border.all(color: (tone ?? const Color(0xFF000000)).withValues(alpha: 0.5)),
                ),
                child: Text(
                  tag.toUpperCase(),
                  style: TextStyle(
                    color: tone,
                    fontSize: 9,
                    letterSpacing: 1.3,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                'returns $returns',
                style: const TextStyle(
                  color: _smbaeInkFaint,
                  fontSize: 11,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            signature,
            style: const TextStyle(
              color: _smbaePhosphor,
              fontSize: 13,
              fontFamily: 'monospace',
              height: 1.35,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            gloss,
            style: const TextStyle(
              color: _smbaeInkSoft,
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
// Keyed child cache — 6×3 CustomPainter grid with tap to highlight.
// ---------------------------------------------------------------------------

class _SmbaeKeyedCacheVisualisation extends StatelessWidget {
  const _SmbaeKeyedCacheVisualisation({
    required this.selectedIndex,
    required this.onTap,
    required this.pulse,
  });

  final int selectedIndex;
  final ValueChanged<int> onTap;
  final AnimationController pulse;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: _smbaePanelDecoration(),
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SmbaeSectionHeader(
            kicker: 'PANEL C',
            title: 'Keyed child cache',
            subtitle:
                'Each cell is an Element entry keyed by its delegate-supplied '
                'Key. Tap a cell to highlight; peers fade but persist in cache.',
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 190,
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints c) {
                return Stack(
                  children: <Widget>[
                    AnimatedBuilder(
                      animation: pulse,
                      builder: (BuildContext context, Widget? child) {
                        return CustomPaint(
                          size: Size(c.maxWidth, c.maxHeight),
                          painter: _SmbaeCacheGridPainter(
                            selectedIndex: selectedIndex,
                            pulse: pulse.value,
                          ),
                        );
                      },
                    ),
                    Positioned.fill(
                      child: _SmbaeCacheHitSurface(
                        onTap: onTap,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          _SmbaeCacheSelectionInfo(selectedIndex: selectedIndex),
        ],
      ),
    );
  }
}

class _SmbaeCacheHitSurface extends StatelessWidget {
  const _SmbaeCacheHitSurface({required this.onTap});

  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints c) {
        const int cols = 6;
        const int rows = 3;
        final double cellW = c.maxWidth / cols;
        final double cellH = c.maxHeight / rows;
        return Stack(
          children: <Widget>[
            for (int r = 0; r < rows; r++)
              for (int col = 0; col < cols; col++)
                Positioned(
                  left: col * cellW,
                  top: r * cellH,
                  width: cellW,
                  height: cellH,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => onTap(r * cols + col),
                  ),
                ),
          ],
        );
      },
    );
  }
}

class _SmbaeCacheGridPainter extends CustomPainter {
  _SmbaeCacheGridPainter({required this.selectedIndex, required this.pulse});

  final int selectedIndex;
  final double pulse;

  static const List<String> _keys = <String>[
    'k:row-0', 'k:row-1', 'k:row-2', 'k:row-3', 'k:row-4', 'k:row-5',
    'k:row-6', 'k:row-7', 'k:row-8', 'k:row-9', 'k:row-10', 'k:row-11',
    'k:row-12', 'k:row-13', 'k:row-14', 'k:row-15', 'k:row-16', 'k:row-17',
  ];

  static const List<bool> _cached = <bool>[
    true, true, false, true, false, true,
    false, true, true, false, true, false,
    true, false, true, true, false, true,
  ];

  @override
  void paint(Canvas canvas, Size size) {
    const int cols = 6;
    const int rows = 3;
    final double cellW = size.width / cols;
    final double cellH = size.height / rows;
    for (int i = 0; i < _keys.length; i++) {
      final int r = i ~/ cols;
      final int c = i % cols;
      final Rect rect = Rect.fromLTWH(
        c * cellW + 4,
        r * cellH + 4,
        cellW - 8,
        cellH - 8,
      );
      final bool isSelected = i == selectedIndex;
      final bool isCached = _cached[i];
      final double fade = isSelected ? 1.0 : 0.35;
      final Color tone = isCached ? _smbaePhosphor : _smbaeAmber;
      final Paint fill = Paint()
        ..color = (tone ?? const Color(0xFF000000)).withValues(
          alpha: (isSelected ? (0.28 + 0.18 * pulse) : 0.12) * fade,
        );
      final Paint border = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = isSelected ? 1.8 : 1.0
        ..color = (tone ?? const Color(0xFF000000)).withValues(alpha: isSelected ? 0.95 : 0.35 * fade);
      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, const Radius.circular(6)),
        fill,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, const Radius.circular(6)),
        border,
      );
      _paintLabel(
        canvas,
        rect,
        _keys[i],
        isCached ? 'CACHED' : 'ACTIVE',
        tone,
        fade,
      );
    }
  }

  void _paintLabel(
    Canvas canvas,
    Rect rect,
    String key,
    String state,
    Color tone,
    double fade,
  ) {
    final TextPainter keyPainter = TextPainter(
      text: TextSpan(
        text: key,
        style: TextStyle(
          color: (_smbaeInk ?? const Color(0xFF000000)).withValues(alpha: fade),
          fontSize: 11,
          fontFamily: 'monospace',
          fontWeight: FontWeight.w600,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: rect.width - 10);
    keyPainter.paint(canvas, Offset(rect.left + 8, rect.top + 8));
    final TextPainter stPainter = TextPainter(
      text: TextSpan(
        text: state,
        style: TextStyle(
          color: (tone ?? const Color(0xFF000000)).withValues(alpha: fade),
          fontSize: 9,
          letterSpacing: 1.2,
          fontWeight: FontWeight.w700,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    stPainter.paint(
      canvas,
      Offset(rect.right - stPainter.width - 8, rect.bottom - stPainter.height - 6),
    );
  }

  @override
  bool shouldRepaint(covariant _SmbaeCacheGridPainter oldDelegate) {
    return oldDelegate.selectedIndex != selectedIndex ||
        oldDelegate.pulse != pulse;
  }
}

class _SmbaeCacheSelectionInfo extends StatelessWidget {
  const _SmbaeCacheSelectionInfo({required this.selectedIndex});

  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    final String keyLabel = 'k:row-$selectedIndex';
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
      decoration: BoxDecoration(
        color: _smbaeObsidian,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: (_smbaePhosphor ?? const Color(0xFF000000)).withValues(alpha: 0.3)),
      ),
      child: Row(
        children: <Widget>[
          const Icon(Icons.key, size: 16, color: _smbaePhosphor),
          const SizedBox(width: 8),
          Text(
            'selected: $keyLabel',
            style: const TextStyle(
              color: _smbaeInk,
              fontSize: 12,
              fontFamily: 'monospace',
            ),
          ),
          const Spacer(),
          const Text(
            'retained until delegate invalidates',
            style: TextStyle(color: _smbaeInkFaint, fontSize: 11),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Shared chrome — section header, panel decoration, stage divider.
// ---------------------------------------------------------------------------

BoxDecoration _smbaePanelDecoration() {
  return BoxDecoration(
    color: _smbaeObsidianSoft,
    borderRadius: BorderRadius.circular(_smbaeCardRadius),
    border: Border.all(color: (_smbaePhosphor ?? const Color(0xFF000000)).withValues(alpha: 0.18)),
  );
}

class _SmbaeSectionHeader extends StatelessWidget {
  const _SmbaeSectionHeader({
    required this.kicker,
    required this.title,
    required this.subtitle,
  });

  final String kicker;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 4,
          height: 42,
          decoration: BoxDecoration(
            color: _smbaePhosphor,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                kicker,
                style: const TextStyle(
                  color: _smbaePhosphor,
                  fontSize: 10,
                  letterSpacing: 1.8,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                title,
                style: const TextStyle(
                  color: _smbaeInk,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  color: _smbaeInkSoft,
                  fontSize: 12,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SmbaeStageDivider extends StatelessWidget {
  const _SmbaeStageDivider({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Row(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: (_smbaeAmber ?? const Color(0xFF000000)).withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(3),
              border: Border.all(color: (_smbaeAmber ?? const Color(0xFF000000)).withValues(alpha: 0.5)),
            ),
            child: Text(
              label,
              style: const TextStyle(
                color: _smbaeAmber,
                fontSize: 9,
                letterSpacing: 1.5,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Divider(color: _smbaeGrid, height: 1),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Triple sliver stage — header + three slivers with ruler gutters.
// ---------------------------------------------------------------------------

class _SmbaeTripleSliverStageHeader extends StatelessWidget {
  const _SmbaeTripleSliverStageHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: _smbaePanelDecoration(),
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _SmbaeSectionHeader(
            kicker: 'PANEL D',
            title: 'Triple sliver stage',
            subtitle:
                'Three adjacent slivers share one CustomScrollView. Each gutter '
                'ruler marks paint-offset pixels so element creation windows '
                'line up with physical scroll offsets.',
          ),
          SizedBox(height: 6),
          Text(
            '────── LIST ──────',
            style: TextStyle(
              color: _smbaeAmber,
              fontSize: 10,
              letterSpacing: 1.6,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _SmbaeRulerGutter extends StatelessWidget {
  const _SmbaeRulerGutter({
    required this.topOffset,
    required this.height,
    required this.ticks,
  });

  final double topOffset;
  final double height;
  final int ticks;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _smbaeGutterWidth,
      height: height,
      child: CustomPaint(
        painter: _SmbaeRulerPainter(topOffset: topOffset, ticks: ticks),
      ),
    );
  }
}

class _SmbaeRulerPainter extends CustomPainter {
  _SmbaeRulerPainter({required this.topOffset, required this.ticks});

  final double topOffset;
  final int ticks;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = _smbaeObsidian;
    canvas.drawRect(Offset.zero & size, bg);
    final Paint rail = Paint()
      ..color = (_smbaePhosphorDim ?? const Color(0xFF000000)).withValues(alpha: 0.6)
      ..strokeWidth = 1.0;
    canvas.drawLine(
      Offset(size.width - 6, 0),
      Offset(size.width - 6, size.height),
      rail,
    );
    final double step = size.height / ticks;
    for (int i = 0; i <= ticks; i++) {
      final double y = i * step;
      final bool major = i % 2 == 0;
      final Paint tick = Paint()
        ..color = major
            ? (_smbaePhosphor ?? const Color(0xFF000000)).withValues(alpha: 0.8)
            : (_smbaePhosphor ?? const Color(0xFF000000)).withValues(alpha: 0.4)
        ..strokeWidth = major ? 1.2 : 0.8;
      canvas.drawLine(
        Offset(size.width - (major ? 14 : 10), y),
        Offset(size.width - 6, y),
        tick,
      );
      if (major) {
        final double pxLabel = topOffset + i * step;
        final TextPainter tp = TextPainter(
          text: TextSpan(
            text: pxLabel.toStringAsFixed(0),
            style: const TextStyle(
              color: _smbaeInkFaint,
              fontSize: 9,
              fontFamily: 'monospace',
            ),
          ),
          textDirection: TextDirection.ltr,
        )..layout();
        tp.paint(canvas, Offset(4, y - tp.height / 2));
      }
    }
  }

  @override
  bool shouldRepaint(covariant _SmbaeRulerPainter oldDelegate) {
    return oldDelegate.topOffset != topOffset || oldDelegate.ticks != ticks;
  }
}

// List-style sliver with ruler gutter.
class _SmbaeRulerListSliver extends StatelessWidget {
  const _SmbaeRulerListSliver();

  static const List<_SmbaeListRow> _rows = <_SmbaeListRow>[
    _SmbaeListRow(0, 'Element#0', 'mounted at viewport top', _smbaePhosphor),
    _SmbaeListRow(1, 'Element#1', 'laid out — stable across frames', _smbaePhosphor),
    _SmbaeListRow(2, 'Element#2', 'reused key k:row-2', _smbaeAmber),
    _SmbaeListRow(3, 'Element#3', 'new createChild this frame', _smbaePhosphor),
    _SmbaeListRow(4, 'Element#4', 'retained via keyed cache', _smbaeAmber),
    _SmbaeListRow(5, 'Element#5', 'marked for garbage collection', _smbaeInkFaint),
    _SmbaeListRow(6, 'Element#6', 'delegate returned null (out of range)', _smbaeInkFaint),
  ];

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverList.builder(
        itemCount: _rows.length,
        itemBuilder: (BuildContext context, int index) {
          final _SmbaeListRow row = _rows[index];
          // E2: dropped `IntrinsicHeight + Row(crossAxisAlignment: stretch)`
          // — the gutter already pins a fixed `height: 64`, so we can
          // wrap the whole row in a `SizedBox(height: 64)` and let
          // children size against the bounded main-axis extent instead
          // of asking for intrinsic measurements (which the
          // surrounding sliver render-tree did not support and which
          // surfaced as `RenderBox was not laid out` on the
          // `RenderIntrinsicHeight`).
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: SizedBox(
              height: 64,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _SmbaeRulerGutter(
                    topOffset: index * 64.0,
                    height: 64,
                    ticks: 4,
                  ),
                  const SizedBox(width: 8),
                  Expanded(child: _SmbaeListRowCard(row: row)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _SmbaeListRow {
  const _SmbaeListRow(this.index, this.title, this.note, this.tone);
  final int index;
  final String title;
  final String note;
  final Color tone;
}

class _SmbaeListRowCard extends StatelessWidget {
  const _SmbaeListRowCard({required this.row});

  final _SmbaeListRow row;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _smbaeObsidianSoft,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: (row.tone ?? const Color(0xFF000000)).withValues(alpha: 0.35)),
      ),
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
      child: Row(
        children: <Widget>[
          Container(
            width: 32,
            height: 32,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: (row.tone ?? const Color(0xFF000000)).withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              '${row.index}',
              style: TextStyle(
                color: row.tone,
                fontSize: 13,
                fontWeight: FontWeight.w700,
                fontFamily: 'monospace',
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  row.title,
                  style: const TextStyle(
                    color: _smbaeInk,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  row.note,
                  style: const TextStyle(color: _smbaeInkSoft, fontSize: 11),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right, size: 16, color: row.tone),
        ],
      ),
    );
  }
}

// Grid-style sliver with ruler gutter.
class _SmbaeRulerGridSliver extends StatelessWidget {
  const _SmbaeRulerGridSliver();

  @override
  Widget build(BuildContext context) {
    // E2: replaced `IntrinsicHeight + Row(crossAxisAlignment: stretch)`
    // wrapping a `GridView.builder(shrinkWrap: true)` with
    // `SizedBox(height: 240)`. `IntrinsicHeight` walks its child with
    // `getMaxIntrinsicHeight`, but `RenderShrinkWrappingViewport`
    // refuses to compute intrinsics ("Calculating the intrinsic
    // dimensions would require instantiating every child of the
    // viewport, which defeats the point of viewports being lazy.").
    // Pinning a fixed height — the gutter already declared `height:
    // 240` — keeps the same visual layout without asking the grid
    // for intrinsics.
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverToBoxAdapter(
        child: SizedBox(
          height: 240,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const _SmbaeRulerGutter(
                topOffset: 0,
                height: 240,
                ticks: 6,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 9,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: 1.15,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return _SmbaeGridCell(index: index);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SmbaeGridCell extends StatelessWidget {
  const _SmbaeGridCell({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final bool alive = index % 3 != 2;
    final Color tone = alive ? _smbaePhosphor : _smbaeAmber;
    return Container(
      decoration: BoxDecoration(
        color: (tone ?? const Color(0xFF000000)).withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: (tone ?? const Color(0xFF000000)).withValues(alpha: 0.45)),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'cell #$index',
            style: TextStyle(
              color: tone,
              fontSize: 11,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w700,
            ),
          ),
          const Spacer(),
          Text(
            alive ? 'active' : 'cached',
            style: const TextStyle(color: _smbaeInkSoft, fontSize: 10),
          ),
        ],
      ),
    );
  }
}

// Fixed-extent sliver with ruler gutter.
class _SmbaeRulerFixedExtentSliver extends StatelessWidget {
  const _SmbaeRulerFixedExtentSliver();

  static const List<String> _labels = <String>[
    'fixed-extent #0 — itemExtent: 54 px',
    'fixed-extent #1 — itemExtent: 54 px',
    'fixed-extent #2 — itemExtent: 54 px',
    'fixed-extent #3 — itemExtent: 54 px',
    'fixed-extent #4 — itemExtent: 54 px',
  ];

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverFixedExtentList.builder(
        itemExtent: 54,
        itemCount: _labels.length,
        itemBuilder: (BuildContext context, int index) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _SmbaeRulerGutter(
                topOffset: index * 54.0,
                height: 54,
                ticks: 2,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 2),
                  decoration: BoxDecoration(
                    color: _smbaeObsidianHigh,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: (_smbaePhosphor ?? const Color(0xFF000000)).withValues(alpha: 0.3),
                    ),
                  ),
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    _labels[index],
                    style: const TextStyle(
                      color: _smbaeInk,
                      fontSize: 12,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Pitfall card — direct instantiation warning.
// ---------------------------------------------------------------------------

class _SmbaePitfallCard extends StatelessWidget {
  const _SmbaePitfallCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: _smbaeObsidianSoft,
        borderRadius: BorderRadius.circular(_smbaeCardRadius),
        border: Border.all(color: (_smbaeAmber ?? const Color(0xFF000000)).withValues(alpha: 0.5)),
      ),
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 34,
                height: 34,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: (_smbaeAmber ?? const Color(0xFF000000)).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: (_smbaeAmber ?? const Color(0xFF000000)).withValues(alpha: 0.6),
                  ),
                ),
                child: const Icon(
                  Icons.warning_amber_rounded,
                  color: _smbaeAmber,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'PITFALL — do not instantiate SliverMultiBoxAdaptorElement',
                  style: TextStyle(
                    color: _smbaeAmber,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'SliverMultiBoxAdaptorElement is constructed exclusively by the '
            'Element framework when SliverMultiBoxAdaptorWidget.createElement() '
            'is called during inflation. Instantiating it yourself is wrong '
            'for four reasons:',
            style: TextStyle(color: _smbaeInkSoft, fontSize: 12, height: 1.45),
          ),
          const SizedBox(height: 10),
          const _SmbaePitfallBullet(
            index: 1,
            text:
                'The enclosing BuildOwner is set as a side-effect of inflation. '
                'Without it, performRebuild() has no owner to mark dirty.',
          ),
          const _SmbaePitfallBullet(
            index: 2,
            text:
                'The backing RenderSliverMultiBoxAdaptor is attached through '
                'Element.mount(). Short-circuiting that leaves the render '
                'object detached and layout silently no-ops.',
          ),
          const _SmbaePitfallBullet(
            index: 3,
            text:
                'The keyed-child cache is keyed by the Element\'s slot. '
                'Slots are assigned during mount; a hand-built instance has '
                'a null slot and can never be looked up.',
          ),
          const _SmbaePitfallBullet(
            index: 4,
            text:
                'You bypass the SliverChildDelegate lifecycle. '
                'didFinishLayout / didChangeDependencies / didStartPaintingChild '
                'are never called, so delegate-driven keep-alive and '
                'AutomaticKeepAlive interop breaks.',
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
            decoration: BoxDecoration(
              color: _smbaeObsidian,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: (_smbaePhosphor ?? const Color(0xFF000000)).withValues(alpha: 0.3)),
            ),
            child: const Text(
              '// Correct usage: construct a subclass WIDGET and let the \n'
              '// framework inflate it. Never call the element constructor.\n'
              'final sliver = SliverList(delegate: myDelegate);\n'
              'final element = sliver.createElement(); // framework-only path',
              style: TextStyle(
                color: _smbaePhosphor,
                fontSize: 12,
                fontFamily: 'monospace',
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SmbaePitfallBullet extends StatelessWidget {
  const _SmbaePitfallBullet({required this.index, required this.text});

  final int index;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 20,
            height: 20,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: (_smbaeAmber ?? const Color(0xFF000000)).withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              '$index',
              style: const TextStyle(
                color: _smbaeAmber,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: _smbaeInkSoft,
                fontSize: 12,
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
// Timeline strip — horizontal stations joined by arrows.
// ---------------------------------------------------------------------------

class _SmbaeTimelineStrip extends StatelessWidget {
  const _SmbaeTimelineStrip({required this.timeline});

  final AnimationController timeline;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: _smbaePanelDecoration(),
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SmbaeSectionHeader(
            kicker: 'PANEL E',
            title: 'Lifecycle timeline strip',
            subtitle:
                'Seven stations traversed by every keyed child. The travelling '
                'marker represents the currently-processing slot.',
          ),
          const SizedBox(height: 14),
          AnimatedBuilder(
            animation: timeline,
            builder: (BuildContext context, Widget? child) {
              return CustomPaint(
                size: const Size.fromHeight(110),
                painter: _SmbaeTimelinePainter(progress: timeline.value),
                child: const SizedBox(width: double.infinity, height: 110),
              );
            },
          ),
          const SizedBox(height: 10),
          const _SmbaeTimelineLegend(),
        ],
      ),
    );
  }
}

class _SmbaeTimelinePainter extends CustomPainter {
  _SmbaeTimelinePainter({required this.progress});

  final double progress;

  static const List<String> _stations = <String>[
    'mount',
    'build',
    'update',
    'layout',
    'paint',
    'recycle',
    'forget',
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final double slotW = size.width / _stations.length;
    final double centerY = size.height * 0.45;

    // Baseline rail.
    final Paint rail = Paint()
      ..color = _smbaeGrid
      ..strokeWidth = 2.0;
    canvas.drawLine(
      Offset(slotW * 0.5, centerY),
      Offset(size.width - slotW * 0.5, centerY),
      rail,
    );

    // Stations.
    for (int i = 0; i < _stations.length; i++) {
      final double cx = slotW * (i + 0.5);
      final bool active = (progress * _stations.length).floor() == i;
      final Color tone = i < 3
          ? _smbaePhosphor
          : i < 5
              ? _smbaeAmber
              : _smbaeInkFaint;
      final Paint ringOuter = Paint()
        ..style = PaintingStyle.stroke
        ..color = (tone ?? const Color(0xFF000000)).withValues(alpha: active ? 1.0 : 0.5)
        ..strokeWidth = active ? 2.2 : 1.4;
      canvas.drawCircle(Offset(cx, centerY), 13, ringOuter);
      final Paint fill = Paint()
        ..color = (tone ?? const Color(0xFF000000)).withValues(alpha: active ? 0.4 : 0.12);
      canvas.drawCircle(Offset(cx, centerY), 9, fill);

      // Label above.
      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: _stations[i],
          style: TextStyle(
            color: tone,
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
          ),
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(cx - tp.width / 2, centerY - 36));

      // Index below.
      final TextPainter ip = TextPainter(
        text: TextSpan(
          text: '#$i',
          style: const TextStyle(
            color: _smbaeInkFaint,
            fontSize: 10,
            fontFamily: 'monospace',
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      ip.paint(canvas, Offset(cx - ip.width / 2, centerY + 20));

      // Arrow to next station.
      if (i < _stations.length - 1) {
        final double arrowStart = cx + 13;
        final double arrowEnd = slotW * (i + 1.5) - 13;
        final Paint arrowPaint = Paint()
          ..color = (_smbaeInkFaint ?? const Color(0xFF000000)).withValues(alpha: 0.9)
          ..strokeWidth = 1.1;
        canvas.drawLine(
          Offset(arrowStart, centerY),
          Offset(arrowEnd, centerY),
          arrowPaint,
        );
        final Path head = Path()
          ..moveTo(arrowEnd, centerY)
          ..lineTo(arrowEnd - 5, centerY - 3)
          ..lineTo(arrowEnd - 5, centerY + 3)
          ..close();
        canvas.drawPath(head, arrowPaint..style = PaintingStyle.fill);
      }
    }

    // Traveling marker.
    final double markerX = slotW * 0.5 +
        progress * (size.width - slotW);
    final Paint marker = Paint()
      ..color = (_smbaePhosphor ?? const Color(0xFF000000)).withValues(alpha: 0.85);
    canvas.drawCircle(Offset(markerX, centerY), 4.5, marker);
    final Paint markerRing = Paint()
      ..style = PaintingStyle.stroke
      ..color = (_smbaePhosphor ?? const Color(0xFF000000)).withValues(alpha: 0.5)
      ..strokeWidth = 1.2;
    canvas.drawCircle(Offset(markerX, centerY), 9, markerRing);
  }

  @override
  bool shouldRepaint(covariant _SmbaeTimelinePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

class _SmbaeTimelineLegend extends StatelessWidget {
  const _SmbaeTimelineLegend();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        _chip(_smbaePhosphor, 'Element-tier: mount / build / update'),
        const SizedBox(width: 14),
        _chip(_smbaeAmber, 'Render-tier: layout / paint'),
        const SizedBox(width: 14),
        _chip(_smbaeInkFaint, 'Lifecycle exit: recycle / forget'),
      ],
    );
  }

  Widget _chip(Color color, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: (color ?? const Color(0xFF000000)).withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: (color ?? const Color(0xFF000000)).withValues(alpha: 0.45)),
      ),
      child: Text(
        label,
        style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.w600),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Footer bar — observatory signature.
// ---------------------------------------------------------------------------

class _SmbaeFooterBar extends StatelessWidget {
  const _SmbaeFooterBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      decoration: BoxDecoration(
        color: _smbaeObsidianSoft,
        borderRadius: BorderRadius.circular(_smbaeCardRadius),
        border: Border.all(color: (_smbaePhosphor ?? const Color(0xFF000000)).withValues(alpha: 0.18)),
      ),
      child: Row(
        children: <Widget>[
          const Icon(Icons.memory, size: 16, color: _smbaePhosphor),
          const SizedBox(width: 8),
          const Expanded(
            child: Text(
              'Element Lifecycle Observatory — SliverMultiBoxAdaptorElement',
              style: TextStyle(color: _smbaeInkSoft, fontSize: 11),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: (_smbaeAmber ?? const Color(0xFF000000)).withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(3),
              border: Border.all(color: (_smbaeAmber ?? const Color(0xFF000000)).withValues(alpha: 0.45)),
            ),
            child: const Text(
              'TIER 2 / ELEMENT',
              style: TextStyle(
                color: _smbaeAmber,
                fontSize: 9,
                letterSpacing: 1.3,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
