// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unused_element
// D4rt visual deep demo: PerformanceOverlayOption — bitmask flags driving Flutter's
// PerformanceOverlay widget. Hand-drawn replica via CustomPainter (we cannot use the
// real PerformanceOverlay from a sandboxed AST script because it requires the engine's
// internal stats source). Sections: hero meter, anatomy, six flag cards, all-on
// rendered replica, single-flag rendered replica, checkerboard demos, jank-pattern
// panel, MaterialApp recipe, WidgetsApp wiring, pitfalls, footer.

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// ---------------------------------------------------------------------------
// Palette and metrics
// ---------------------------------------------------------------------------

const Color _kBgDeep = Color(0xFF0A0F1C);
const Color _kBgPanel = Color(0xFF131A2C);
const Color _kBgCard = Color(0xFF1B2540);
const Color _kBorder = Color(0xFF2D3A5C);
const Color _kInk = Color(0xFFE6ECFF);
const Color _kInkDim = Color(0xFFA3B0D4);
const Color _kInkFaint = Color(0xFF6F7DA8);
const Color _kAccent = Color(0xFF5EE6C8);
const Color _kAccentWarm = Color(0xFFFFB86B);
const Color _kAccentRed = Color(0xFFFF5C7A);
const Color _kUiBar = Color(0xFFE05A6E);
const Color _kRasterBar = Color(0xFF4FC0FF);
const Color _kTargetLine = Color(0xFF7CE38B);
const Color _kCapLine = Color(0xFFF8C76C);
const Color _kCheckerA = Color(0xFFA855F7);
const Color _kCheckerB = Color(0xFF22D3EE);

const double _kHeroHeight = 230.0;
const double _kHistogramHeight = 110.0;
const double _kHistogramWidth = 360.0;

// ---------------------------------------------------------------------------
// Top-level helpers
// ---------------------------------------------------------------------------

TextStyle _privateTitleStyle() => const TextStyle(
      color: _kInk,
      fontSize: 22,
      fontWeight: FontWeight.w800,
      letterSpacing: 0.2,
    );

TextStyle _privateSubtitleStyle() => const TextStyle(
      color: _kInkDim,
      fontSize: 13,
      fontWeight: FontWeight.w500,
      height: 1.45,
    );

TextStyle _privateBodyStyle() => const TextStyle(
      color: _kInk,
      fontSize: 13,
      height: 1.5,
    );

TextStyle _privateMonoStyle({Color color = _kInk, double size = 12}) => TextStyle(
      color: color,
      fontSize: size,
      fontFamily: 'monospace',
      height: 1.45,
    );

TextStyle _privateLabelStyle() => const TextStyle(
      color: _kInkFaint,
      fontSize: 11,
      fontWeight: FontWeight.w600,
      letterSpacing: 1.4,
    );

BoxDecoration _privateCardDecoration({Color? border, Color? fill}) => BoxDecoration(
      color: fill ?? _kBgCard,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: border ?? _kBorder, width: 1),
    );

Widget _privateSectionTitle(String index, String title, String? subtitle) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(4, 24, 4, 14),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 38,
          height: 38,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: _kBgCard,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _kAccent.withValues(alpha: 0.5), width: 1),
          ),
          child: Text(
            index,
            style: const TextStyle(
              color: _kAccent,
              fontWeight: FontWeight.w800,
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: _privateTitleStyle()),
              if (subtitle != null) ...[
                const SizedBox(height: 4),
                Text(subtitle, style: _privateSubtitleStyle()),
              ],
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _privateChip(String label, Color color, {bool filled = false}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: filled ? color.withValues(alpha: 0.18) : Colors.transparent,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: color.withValues(alpha: 0.7), width: 1),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: color,
        fontSize: 11,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.6,
      ),
    ),
  );
}

Widget _privateBulletLine(String head, String body, {Color? accent}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 8,
          height: 8,
          margin: const EdgeInsets.only(top: 6, right: 10),
          decoration: BoxDecoration(
            color: accent ?? _kAccent,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: _privateBodyStyle(),
              children: [
                TextSpan(
                  text: '$head ',
                  style: const TextStyle(
                    color: _kInk,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text: body,
                  style: const TextStyle(color: _kInkDim),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Frame model — synthetic timing data feeding the histogram painters
// ---------------------------------------------------------------------------

class _PrivateFrameSample {
  final double uiMs;
  final double rasterMs;
  const _PrivateFrameSample(this.uiMs, this.rasterMs);
}

class _PrivateFrameSeries {
  final String label;
  final List<_PrivateFrameSample> frames;
  const _PrivateFrameSeries(this.label, this.frames);

  double get avgUi {
    double total = 0;
    for (final f in frames) {
      total += f.uiMs;
    }
    return frames.isEmpty ? 0 : total / frames.length;
  }

  double get avgRaster {
    double total = 0;
    for (final f in frames) {
      total += f.rasterMs;
    }
    return frames.isEmpty ? 0 : total / frames.length;
  }

  double get worstUi {
    double worst = 0;
    for (final f in frames) {
      if (f.uiMs > worst) worst = f.uiMs;
    }
    return worst;
  }

  double get worstRaster {
    double worst = 0;
    for (final f in frames) {
      if (f.rasterMs > worst) worst = f.rasterMs;
    }
    return worst;
  }
}

List<_PrivateFrameSample> _privateGenerateSmoothFrames(int count, int seed) {
  final rnd = math.Random(seed);
  final list = <_PrivateFrameSample>[];
  for (int i = 0; i < count; i++) {
    final ui = 4.0 + rnd.nextDouble() * 4.5;
    final raster = 5.0 + rnd.nextDouble() * 4.0;
    list.add(_PrivateFrameSample(ui, raster));
  }
  return list;
}

List<_PrivateFrameSample> _privateGenerateOccasionalJank(int count, int seed) {
  final rnd = math.Random(seed);
  final list = <_PrivateFrameSample>[];
  for (int i = 0; i < count; i++) {
    double ui = 5.5 + rnd.nextDouble() * 4.0;
    double raster = 6.0 + rnd.nextDouble() * 3.5;
    if (i == 9 || i == 23 || i == 41) {
      ui += 18 + rnd.nextDouble() * 6;
      raster += 4;
    }
    if (i == 30) raster += 22;
    list.add(_PrivateFrameSample(ui, raster));
  }
  return list;
}

List<_PrivateFrameSample> _privateGenerateSustainedJank(int count, int seed) {
  final rnd = math.Random(seed);
  final list = <_PrivateFrameSample>[];
  for (int i = 0; i < count; i++) {
    final ui = 13.0 + rnd.nextDouble() * 9.0;
    final raster = 16.0 + rnd.nextDouble() * 12.0;
    list.add(_PrivateFrameSample(ui, raster));
  }
  return list;
}

List<_PrivateFrameSample> _privateGenerateBurstFrames(int count, int seed) {
  final rnd = math.Random(seed);
  final list = <_PrivateFrameSample>[];
  for (int i = 0; i < count; i++) {
    final phase = (i ~/ 8) % 3;
    double ui;
    double raster;
    if (phase == 0) {
      ui = 4 + rnd.nextDouble() * 3;
      raster = 5 + rnd.nextDouble() * 3;
    } else if (phase == 1) {
      ui = 8 + rnd.nextDouble() * 6;
      raster = 9 + rnd.nextDouble() * 6;
    } else {
      ui = 14 + rnd.nextDouble() * 10;
      raster = 16 + rnd.nextDouble() * 12;
    }
    list.add(_PrivateFrameSample(ui, raster));
  }
  return list;
}

// ---------------------------------------------------------------------------
// Hero painter — stylized FPS meter, dial face, big "60" label
// ---------------------------------------------------------------------------

class _PrivateHeroMeterPainter extends CustomPainter {
  const _PrivateHeroMeterPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final bg = Paint()..color = _kBgPanel;
    canvas.drawRRect(
      RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(18)),
      bg,
    );

    final gridPaint = Paint()
      ..color = _kBorder.withValues(alpha: 0.5)
      ..strokeWidth = 1;
    for (double x = 18; x < size.width; x += 28) {
      canvas.drawLine(Offset(x, 12), Offset(x, size.height - 12), gridPaint);
    }
    for (double y = 18; y < size.height; y += 28) {
      canvas.drawLine(Offset(12, y), Offset(size.width - 12, y), gridPaint);
    }

    final dialCenter = Offset(size.width * 0.28, size.height * 0.55);
    final dialRadius = math.min(size.width, size.height) * 0.32;

    final dialBg = Paint()
      ..color = _kBgDeep
      ..style = PaintingStyle.fill;
    canvas.drawCircle(dialCenter, dialRadius, dialBg);

    final dialBorder = Paint()
      ..color = _kAccent.withValues(alpha: 0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawCircle(dialCenter, dialRadius, dialBorder);

    final tickPaint = Paint()
      ..color = _kInkDim
      ..strokeWidth = 1.5;
    for (int i = 0; i <= 60; i += 5) {
      final ang = math.pi * (0.75 + (i / 60) * 1.5);
      final outer = Offset(
        dialCenter.dx + math.cos(ang) * dialRadius,
        dialCenter.dy + math.sin(ang) * dialRadius,
      );
      final inner = Offset(
        dialCenter.dx + math.cos(ang) * (dialRadius - (i % 10 == 0 ? 12 : 7)),
        dialCenter.dy + math.sin(ang) * (dialRadius - (i % 10 == 0 ? 12 : 7)),
      );
      canvas.drawLine(inner, outer, tickPaint);
    }

    final needleAng = math.pi * (0.75 + (54 / 60) * 1.5);
    final needlePaint = Paint()
      ..color = _kAccentRed
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      dialCenter,
      Offset(
        dialCenter.dx + math.cos(needleAng) * (dialRadius - 16),
        dialCenter.dy + math.sin(needleAng) * (dialRadius - 16),
      ),
      needlePaint,
    );
    canvas.drawCircle(dialCenter, 5, Paint()..color = _kAccent);

    _privatePaintCenteredText(
      canvas,
      '60',
      Offset(dialCenter.dx, dialCenter.dy + dialRadius + 14),
      const TextStyle(
        color: _kAccent,
        fontWeight: FontWeight.w900,
        fontSize: 26,
      ),
    );
    _privatePaintCenteredText(
      canvas,
      'FPS',
      Offset(dialCenter.dx, dialCenter.dy + dialRadius + 38),
      const TextStyle(color: _kInkFaint, fontSize: 10, letterSpacing: 2),
    );

    final histLeft = size.width * 0.5;
    final histTop = size.height * 0.22;
    final histW = size.width - histLeft - 24;
    final histH = size.height * 0.28;

    _privatePaintMiniHistogram(
      canvas,
      Rect.fromLTWH(histLeft, histTop, histW, histH),
      _kUiBar,
      _privateGenerateSmoothFrames(48, 1),
      isUi: true,
    );
    _privatePaintMiniHistogram(
      canvas,
      Rect.fromLTWH(histLeft, histTop + histH + 10, histW, histH),
      _kRasterBar,
      _privateGenerateSmoothFrames(48, 2),
      isUi: false,
    );

    _privatePaintLeftText(
      canvas,
      'PerformanceOverlayOption',
      Offset(histLeft, 16),
      const TextStyle(color: _kInk, fontSize: 16, fontWeight: FontWeight.w800),
    );
    _privatePaintLeftText(
      canvas,
      'flag bits → graphs + checker overlays',
      Offset(histLeft, 38),
      _privateMonoStyle(color: _kInkFaint, size: 11),
    );
  }

  void _privatePaintMiniHistogram(
    Canvas canvas,
    Rect rect,
    Color color,
    List<_PrivateFrameSample> frames, {
    required bool isUi,
  }) {
    final bg = Paint()..color = _kBgDeep;
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(6)),
      bg,
    );

    final border = Paint()
      ..color = _kBorder
      ..style = PaintingStyle.stroke;
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(6)),
      border,
    );

    final barPaint = Paint()..color = color;
    final barW = rect.width / frames.length;
    for (int i = 0; i < frames.length; i++) {
      final v = isUi ? frames[i].uiMs : frames[i].rasterMs;
      final h = (v / 24.0).clamp(0.0, 1.0) * (rect.height - 4);
      canvas.drawRect(
        Rect.fromLTWH(rect.left + i * barW + 1, rect.bottom - h - 2, barW - 2, h),
        barPaint,
      );
    }

    final targetPaint = Paint()
      ..color = _kTargetLine
      ..strokeWidth = 1;
    final yTarget = rect.bottom - (16 / 24.0) * (rect.height - 4) - 2;
    for (double x = rect.left; x < rect.right; x += 6) {
      canvas.drawLine(Offset(x, yTarget), Offset(x + 3, yTarget), targetPaint);
    }
  }

  void _privatePaintCenteredText(
    Canvas canvas,
    String text,
    Offset center,
    TextStyle style,
  ) {
    final tp = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, Offset(center.dx - tp.width / 2, center.dy - tp.height / 2));
  }

  void _privatePaintLeftText(
    Canvas canvas,
    String text,
    Offset topLeft,
    TextStyle style,
  ) {
    final tp = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, topLeft);
  }

  @override
  bool shouldRepaint(covariant _PrivateHeroMeterPainter oldDelegate) => false;
}

// ---------------------------------------------------------------------------
// Histogram painter — replica of one of the two stacked PerformanceOverlay graphs
// ---------------------------------------------------------------------------

class _PrivateHistogramPainter extends CustomPainter {
  final List<_PrivateFrameSample> frames;
  final Color barColor;
  final bool isUiThread;
  final bool showVisualization;
  final bool showStatistics;
  final String header;
  final String subheader;

  const _PrivateHistogramPainter({
    required this.frames,
    required this.barColor,
    required this.isUiThread,
    required this.showVisualization,
    required this.showStatistics,
    required this.header,
    required this.subheader,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final outline = RRect.fromRectAndRadius(
      Offset.zero & size,
      const Radius.circular(8),
    );

    canvas.drawRRect(outline, Paint()..color = _kBgDeep);
    canvas.drawRRect(
      outline,
      Paint()
        ..color = _kBorder
        ..style = PaintingStyle.stroke,
    );

    final padding = 8.0;
    final headerH = 18.0;
    final statsH = showStatistics ? 22.0 : 0.0;
    final graphRect = Rect.fromLTWH(
      padding,
      padding + headerH,
      size.width - padding * 2,
      size.height - padding * 2 - headerH - statsH,
    );

    _privatePaintText(
      canvas,
      header,
      Offset(padding + 2, padding),
      TextStyle(
        color: barColor,
        fontSize: 11,
        fontWeight: FontWeight.w800,
        letterSpacing: 0.4,
      ),
    );
    _privatePaintText(
      canvas,
      subheader,
      Offset(padding + 90, padding + 1),
      _privateMonoStyle(color: _kInkFaint, size: 10),
    );

    if (showVisualization) {
      _privatePaintBars(canvas, graphRect);
      _privatePaintTargetLines(canvas, graphRect);
    } else {
      _privatePaintFlatPlaceholder(canvas, graphRect);
    }

    if (showStatistics) {
      _privatePaintStats(
        canvas,
        Rect.fromLTWH(
          padding,
          size.height - padding - statsH,
          size.width - padding * 2,
          statsH,
        ),
      );
    }
  }

  void _privatePaintBars(Canvas canvas, Rect rect) {
    if (frames.isEmpty) return;
    final barW = rect.width / frames.length;
    for (int i = 0; i < frames.length; i++) {
      final v = isUiThread ? frames[i].uiMs : frames[i].rasterMs;
      final clamped = v.clamp(0.0, 33.0);
      final h = (clamped / 33.0) * (rect.height - 2);
      Color c = barColor;
      if (v > 33) {
        c = _kAccentRed;
      } else if (v > 16) {
        c = _kAccentWarm;
      }
      final paint = Paint()..color = c;
      canvas.drawRect(
        Rect.fromLTWH(
          rect.left + i * barW + 0.6,
          rect.bottom - h - 1,
          math.max(barW - 1.2, 1),
          h,
        ),
        paint,
      );
    }
  }

  void _privatePaintTargetLines(Canvas canvas, Rect rect) {
    final target16 = Paint()
      ..color = _kTargetLine
      ..strokeWidth = 1;
    final y16 = rect.bottom - (16.0 / 33.0) * (rect.height - 2) - 1;
    _privateDottedLine(canvas, rect.left, rect.right, y16, target16);

    final target33 = Paint()
      ..color = _kCapLine
      ..strokeWidth = 1;
    final y33 = rect.top + 1;
    _privateDottedLine(canvas, rect.left, rect.right, y33, target33);

    _privatePaintText(
      canvas,
      '16ms',
      Offset(rect.right - 28, y16 - 12),
      _privateMonoStyle(color: _kTargetLine, size: 9),
    );
    _privatePaintText(
      canvas,
      '33ms',
      Offset(rect.right - 28, y33),
      _privateMonoStyle(color: _kCapLine, size: 9),
    );
  }

  void _privatePaintFlatPlaceholder(Canvas canvas, Rect rect) {
    final p = Paint()
      ..color = _kInkFaint.withValues(alpha: 0.4)
      ..strokeWidth = 1;
    final mid = rect.top + rect.height / 2;
    _privateDottedLine(canvas, rect.left, rect.right, mid, p);
    _privatePaintText(
      canvas,
      '(visualize flag OFF)',
      Offset(rect.left + 8, mid - 14),
      _privateMonoStyle(color: _kInkFaint, size: 10),
    );
  }

  void _privatePaintStats(Canvas canvas, Rect rect) {
    double avgVal = 0;
    double worstVal = 0;
    for (final f in frames) {
      final v = isUiThread ? f.uiMs : f.rasterMs;
      avgVal += v;
      if (v > worstVal) worstVal = v;
    }
    if (frames.isNotEmpty) avgVal /= frames.length;
    final text =
        '${isUiThread ? "UI" : "Raster"} avg ${avgVal.toStringAsFixed(1)}ms · worst ${worstVal.toStringAsFixed(1)}ms';
    _privatePaintText(
      canvas,
      text,
      Offset(rect.left + 2, rect.top + 4),
      _privateMonoStyle(color: _kInk, size: 10),
    );
  }

  void _privateDottedLine(
    Canvas canvas,
    double x0,
    double x1,
    double y,
    Paint paint,
  ) {
    for (double x = x0; x < x1; x += 5) {
      canvas.drawLine(Offset(x, y), Offset(x + 2.5, y), paint);
    }
  }

  void _privatePaintText(
    Canvas canvas,
    String text,
    Offset topLeft,
    TextStyle style,
  ) {
    final tp = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, topLeft);
  }

  @override
  bool shouldRepaint(covariant _PrivateHistogramPainter oldDelegate) {
    return oldDelegate.showVisualization != showVisualization ||
        oldDelegate.showStatistics != showStatistics;
  }
}

// ---------------------------------------------------------------------------
// Checkerboard painter — depicts what
// checkerboardOffscreenLayers / checkerboardRasterCacheImages would draw on top of
// rendered content.
// ---------------------------------------------------------------------------

class _PrivateCheckerboardPainter extends CustomPainter {
  final Color tintA;
  final Color tintB;
  final String label;
  const _PrivateCheckerboardPainter({
    required this.tintA,
    required this.tintB,
    required this.label,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final bg = Paint()..color = const Color(0xFF1F2A48);
    canvas.drawRRect(
      RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(8)),
      bg,
    );

    canvas.save();
    canvas.clipRRect(
      RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(8)),
    );

    final fakeContent = Paint()..color = const Color(0xFF2D3A65);
    canvas.drawCircle(Offset(size.width * 0.3, size.height * 0.45), 36, fakeContent);
    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.45, size.height * 0.35, 80, 38),
      fakeContent,
    );
    final iconPaint = Paint()..color = const Color(0xFF44558A);
    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.62, size.height * 0.55, 60, 14),
      iconPaint,
    );

    final tile = 14.0;
    final paintA = Paint()..color = tintA.withValues(alpha: 0.55);
    final paintB = Paint()..color = tintB.withValues(alpha: 0.55);
    for (double y = 0; y < size.height; y += tile) {
      for (double x = 0; x < size.width; x += tile) {
        final use = ((x ~/ tile) + (y ~/ tile)) % 2 == 0 ? paintA : paintB;
        canvas.drawRect(Rect.fromLTWH(x, y, tile, tile), use);
      }
    }

    canvas.restore();

    final tp = TextPainter(
      text: TextSpan(
        text: label,
        style: const TextStyle(
          color: _kInk,
          fontSize: 12,
          fontWeight: FontWeight.w800,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    final pad = const EdgeInsets.symmetric(horizontal: 8, vertical: 4);
    final box = Rect.fromLTWH(
      8,
      8,
      tp.width + pad.horizontal,
      tp.height + pad.vertical,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(box, const Radius.circular(4)),
      Paint()..color = _kBgDeep.withValues(alpha: 0.85),
    );
    tp.paint(canvas, Offset(box.left + pad.left, box.top + pad.top));
  }

  @override
  bool shouldRepaint(covariant _PrivateCheckerboardPainter oldDelegate) => false;
}

// ---------------------------------------------------------------------------
// Section: Hero card
// ---------------------------------------------------------------------------

Widget _privateBuildHeroCard() {
  return Container(
    decoration: _privateCardDecoration(),
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _privateChip('ENUM', _kAccent, filled: true),
            const SizedBox(width: 8),
            _privateChip('rendering.dart', _kAccentWarm),
            const SizedBox(width: 8),
            _privateChip('flutter/widgets re-export', _kInkFaint),
          ],
        ),
        const SizedBox(height: 14),
        Text('PerformanceOverlayOption', style: _privateTitleStyle()),
        const SizedBox(height: 6),
        Text(
          'Bitmask flags fed to PerformanceOverlay to enable each of the four '
          'data lanes plus two checkerboard overlays. Each value targets one '
          'piece of frame-pipeline introspection.',
          style: _privateSubtitleStyle(),
        ),
        const SizedBox(height: 18),
        SizedBox(
          height: _kHeroHeight,
          child: CustomPaint(
            painter: const _PrivateHeroMeterPainter(),
            size: Size.infinite,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section: Anatomy of a PerformanceOverlay
// ---------------------------------------------------------------------------

Widget _privateBuildAnatomyCard() {
  return Container(
    decoration: _privateCardDecoration(),
    padding: const EdgeInsets.all(18),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Anatomy of the overlay', style: _privateTitleStyle()),
                  const SizedBox(height: 6),
                  Text(
                    'Two stacked histograms — UI build thread on top in red, '
                    'GPU/raster thread below in blue. The dotted green line is '
                    'your 16ms frame budget (60Hz). The amber line marks 33ms '
                    '(half-rate clamp).',
                    style: _privateSubtitleStyle(),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            _privateChip('Two threads', _kUiBar),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SizedBox(
                height: _kHistogramHeight * 2 + 16,
                child: Column(
                  children: [
                    SizedBox(
                      height: _kHistogramHeight,
                      child: CustomPaint(
                        painter: _PrivateHistogramPainter(
                          frames: _privateGenerateSmoothFrames(60, 11),
                          barColor: _kUiBar,
                          isUiThread: true,
                          showVisualization: true,
                          showStatistics: true,
                          header: 'UI THREAD',
                          subheader: '· widget build + layout + paint',
                        ),
                        size: Size.infinite,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: _kHistogramHeight,
                      child: CustomPaint(
                        painter: _PrivateHistogramPainter(
                          frames: _privateGenerateSmoothFrames(60, 12),
                          barColor: _kRasterBar,
                          isUiThread: false,
                          showVisualization: true,
                          showStatistics: true,
                          header: 'RASTER THREAD',
                          subheader: '· skia/impeller GPU rasterization',
                        ),
                        size: Size.infinite,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 16),
            SizedBox(
              width: 240,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('LEGEND', style: _privateLabelStyle()),
                  const SizedBox(height: 8),
                  _privateLegendRow(_kUiBar, 'UI thread bar'),
                  _privateLegendRow(_kRasterBar, 'Raster thread bar'),
                  _privateLegendRow(_kAccentWarm, 'Frame > 16ms'),
                  _privateLegendRow(_kAccentRed, 'Frame > 33ms'),
                  _privateLegendRow(_kTargetLine, '16ms 60fps target'),
                  _privateLegendRow(_kCapLine, '33ms cap (jank!)'),
                  const SizedBox(height: 12),
                  Text('READING ORDER', style: _privateLabelStyle()),
                  const SizedBox(height: 8),
                  _privateBulletLine('Top:', 'most recent UI frames'),
                  _privateBulletLine('Bottom:', 'most recent raster frames'),
                  _privateBulletLine('X-axis:', 'frame index → newest right'),
                  _privateBulletLine('Y-axis:', 'time in ms (0 → 33)'),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _privateLegendRow(Color c, String label) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Row(
      children: [
        Container(
          width: 18,
          height: 10,
          decoration: BoxDecoration(
            color: c,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(label, style: _privateBodyStyle()),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section: Six flag cards
// ---------------------------------------------------------------------------

class _PrivateFlagInfo {
  final String name;
  final int bit;
  final String draws;
  final String enableWhen;
  final Color tint;
  final bool isVisual;
  final IconData icon;
  const _PrivateFlagInfo({
    required this.name,
    required this.bit,
    required this.draws,
    required this.enableWhen,
    required this.tint,
    required this.isVisual,
    required this.icon,
  });
}

const List<_PrivateFlagInfo> _privateFlagInfos = [
  _PrivateFlagInfo(
    name: 'displayRasterizerStatistics',
    bit: 0,
    draws:
        'A textual line at the bottom of the raster graph: avg/worst ms across '
        'the rolling window of last 64 frames.',
    enableWhen:
        'You want a numeric readout for screenshots / bug reports without '
        'reading bar heights.',
    tint: _kRasterBar,
    isVisual: false,
    icon: Icons.text_snippet_outlined,
  ),
  _PrivateFlagInfo(
    name: 'visualizeRasterizerStatistics',
    bit: 1,
    draws:
        'The blue per-frame bar histogram for the GPU/raster thread. Bars '
        'taller than 16ms cross the green target line.',
    enableWhen:
        'Always on when investigating raster-thread jank — slow paint/'
        'rasterize cycles, big shaders, expensive saveLayer.',
    tint: _kRasterBar,
    isVisual: true,
    icon: Icons.bar_chart,
  ),
  _PrivateFlagInfo(
    name: 'displayEngineStatistics',
    bit: 2,
    draws:
        'A textual line at the bottom of the UI graph: avg/worst ms over '
        'the last 64 UI-thread frames.',
    enableWhen:
        'You want quick numeric snapshots of UI-thread health without '
        'inspecting bars.',
    tint: _kUiBar,
    isVisual: false,
    icon: Icons.short_text,
  ),
  _PrivateFlagInfo(
    name: 'visualizeEngineStatistics',
    bit: 3,
    draws:
        'The red per-frame bar histogram for the UI thread (build + layout '
        '+ paint phase).',
    enableWhen:
        'Investigating UI-thread jank: heavy build()s, layout thrash, '
        'unbounded ListView.builder, huge tree rebuilds.',
    tint: _kUiBar,
    isVisual: true,
    icon: Icons.show_chart,
  ),
  _PrivateFlagInfo(
    name: 'checkerboardOffscreenLayers',
    bit: 4,
    draws:
        'Magenta checker pattern on top of every offscreen layer Flutter '
        'has to spin up (saveLayer, ShaderMask, BackdropFilter, etc.)',
    enableWhen:
        'You suspect saveLayer/clip blowup. Each magenta region is paid '
        'twice — once into the offscreen, then composited.',
    tint: _kCheckerA,
    isVisual: false,
    icon: Icons.layers_outlined,
  ),
  _PrivateFlagInfo(
    name: 'checkerboardRasterCacheImages',
    bit: 5,
    draws:
        'Cyan checker pattern over picture layers Flutter has decided to '
        'cache as a raster image to avoid re-paint every frame.',
    enableWhen:
        'You want to verify static UI is being cached, or hunt down '
        'cache thrash where layers churn each frame.',
    tint: _kCheckerB,
    isVisual: false,
    icon: Icons.grid_4x4,
  ),
];

Widget _privateBuildFlagCardsGrid() {
  // 20260524-2003 baseline §6/H-hardly3 todo #17
  // (performance_overlay_option_test): 7 _PrivateFlagInfo cards in
  // 2-col grid with childAspectRatio 1.55 → 3 × 0.516 px + 2 × 21 px
  // bottom overflows (different cards need different amounts more
  // height). Drop to 1.40 to give every cell ~22 px more vertical
  // room (cell height ~245 vs widest natural ~243).
  return GridView.count(
    crossAxisCount: 2,
    mainAxisSpacing: 12,
    crossAxisSpacing: 12,
    childAspectRatio: 1.40,
    physics: const NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    children: [
      for (final info in _privateFlagInfos) _privateBuildFlagCard(info),
    ],
  );
}

Widget _privateBuildFlagCard(_PrivateFlagInfo info) {
  return Container(
    decoration: _privateCardDecoration(border: info.tint.withValues(alpha: 0.45)),
    padding: const EdgeInsets.all(14),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 34,
              height: 34,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: info.tint.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: info.tint.withValues(alpha: 0.7)),
              ),
              child: Icon(info.icon, color: info.tint, size: 18),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    info.name,
                    style: _privateMonoStyle(color: _kInk, size: 12.5).copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      _privateChip('bit ${info.bit}', info.tint),
                      const SizedBox(width: 6),
                      _privateChip(
                        info.isVisual ? 'visual' : 'overlay/text',
                        _kInkFaint,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text('DRAWS', style: _privateLabelStyle()),
        const SizedBox(height: 4),
        Text(info.draws, style: _privateBodyStyle()),
        const SizedBox(height: 8),
        Text('ENABLE WHEN', style: _privateLabelStyle()),
        const SizedBox(height: 4),
        Text(info.enableWhen, style: _privateBodyStyle()),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section: Rendered replicas (all flags ON / single flag ON)
// ---------------------------------------------------------------------------

Widget _privateBuildOverlayReplica({
  required String title,
  required String subtitle,
  required bool visualizeUi,
  required bool visualizeRaster,
  required bool displayUi,
  required bool displayRaster,
  required List<_PrivateFrameSample> uiFrames,
  required List<_PrivateFrameSample> rasterFrames,
  required List<String> activeFlags,
}) {
  return Container(
    decoration: _privateCardDecoration(),
    padding: const EdgeInsets.all(18),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: _privateTitleStyle()),
        const SizedBox(height: 6),
        Text(subtitle, style: _privateSubtitleStyle()),
        const SizedBox(height: 10),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: [
            for (final f in activeFlags)
              _privateChip(f, _kAccent, filled: true),
          ],
        ),
        const SizedBox(height: 14),
        Center(
          child: SizedBox(
            width: _kHistogramWidth,
            child: Column(
              children: [
                SizedBox(
                  height: _kHistogramHeight,
                  child: CustomPaint(
                    painter: _PrivateHistogramPainter(
                      frames: uiFrames,
                      barColor: _kUiBar,
                      isUiThread: true,
                      showVisualization: visualizeUi,
                      showStatistics: displayUi,
                      header: 'UI',
                      subheader: '· build + layout + paint',
                    ),
                    size: Size.infinite,
                  ),
                ),
                const SizedBox(height: 4),
                SizedBox(
                  height: _kHistogramHeight,
                  child: CustomPaint(
                    painter: _PrivateHistogramPainter(
                      frames: rasterFrames,
                      barColor: _kRasterBar,
                      isUiThread: false,
                      showVisualization: visualizeRaster,
                      showStatistics: displayRaster,
                      header: 'GPU',
                      subheader: '· raster + composition',
                    ),
                    size: Size.infinite,
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

// ---------------------------------------------------------------------------
// Section: Checkerboards
// ---------------------------------------------------------------------------

Widget _privateBuildCheckerboardsCard() {
  return Container(
    decoration: _privateCardDecoration(),
    padding: const EdgeInsets.all(18),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Checkerboard overlays', style: _privateTitleStyle()),
        const SizedBox(height: 6),
        Text(
          'These two flags are not graphs. They tint the rendered scene with '
          'a colored checker pattern wherever the matching layer kind appears, '
          'so you can spot offscreen layers / cached pictures by eye.',
          style: _privateSubtitleStyle(),
        ),
        const SizedBox(height: 14),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 130,
                    child: CustomPaint(
                      painter: _PrivateCheckerboardPainter(
                        tintA: _kCheckerA,
                        tintB: const Color(0xFFEC4899),
                        label: 'checkerboardOffscreenLayers',
                      ),
                      size: Size.infinite,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _privateBulletLine(
                    'Marks:',
                    'every saveLayer / ShaderMask / BackdropFilter / clip with antialias.',
                  ),
                  _privateBulletLine(
                    'Cost:',
                    'each region renders into an offscreen target, then composes back.',
                    accent: _kAccentWarm,
                  ),
                  _privateBulletLine(
                    'Hunt for:',
                    'unintended saveLayers from Opacity > 0/<1 with multiple children.',
                    accent: _kAccentRed,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 130,
                    child: CustomPaint(
                      painter: _PrivateCheckerboardPainter(
                        tintA: _kCheckerB,
                        tintB: const Color(0xFF06B6D4),
                        label: 'checkerboardRasterCacheImages',
                      ),
                      size: Size.infinite,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _privateBulletLine(
                    'Marks:',
                    'picture layers cached as raster images for reuse across frames.',
                  ),
                  _privateBulletLine(
                    'Cost:',
                    'memory + first-frame raster, then near-free reuse.',
                    accent: _kAccentWarm,
                  ),
                  _privateBulletLine(
                    'Hunt for:',
                    'cache thrash: regions blinking on/off — they are being re-created each frame.',
                    accent: _kAccentRed,
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

// ---------------------------------------------------------------------------
// Section: Jank-pattern panel
// ---------------------------------------------------------------------------

Widget _privateBuildJankPatternsCard() {
  final smoothUi = _privateGenerateSmoothFrames(64, 21);
  final smoothRaster = _privateGenerateSmoothFrames(64, 22);
  final occUi = _privateGenerateOccasionalJank(64, 31);
  final occRaster = _privateGenerateOccasionalJank(64, 32);
  final sustUi = _privateGenerateSustainedJank(64, 41);
  final sustRaster = _privateGenerateSustainedJank(64, 42);

  return Container(
    decoration: _privateCardDecoration(),
    padding: const EdgeInsets.all(18),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Reading jank patterns', style: _privateTitleStyle()),
        const SizedBox(height: 6),
        Text(
          'Three sample histograms — what they look like, what they tell you, '
          'and where to start digging.',
          style: _privateSubtitleStyle(),
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _privateJankPatternColumn(
                'Smooth 60fps',
                'All bars under the green 16ms line. Flat tops, similar heights. '
                'No work to do.',
                smoothUi,
                smoothRaster,
                _kTargetLine,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _privateJankPatternColumn(
                'Occasional jank',
                'Mostly smooth with isolated spikes. Likely an animation '
                'kick-off, image decode, or one-off layout.',
                occUi,
                occRaster,
                _kAccentWarm,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _privateJankPatternColumn(
                'Sustained jank',
                'Consistently above 16ms — sometimes over the 33ms cap. '
                'A whole interaction is broken, not just a frame.',
                sustUi,
                sustRaster,
                _kAccentRed,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _privateJankPatternColumn(
  String title,
  String desc,
  List<_PrivateFrameSample> ui,
  List<_PrivateFrameSample> raster,
  Color accent,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: accent,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              color: _kInk,
              fontSize: 14,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
      const SizedBox(height: 6),
      Text(desc, style: _privateBodyStyle()),
      const SizedBox(height: 10),
      SizedBox(
        height: 80,
        child: CustomPaint(
          painter: _PrivateHistogramPainter(
            frames: ui,
            barColor: _kUiBar,
            isUiThread: true,
            showVisualization: true,
            showStatistics: false,
            header: 'UI',
            subheader: '',
          ),
          size: Size.infinite,
        ),
      ),
      const SizedBox(height: 4),
      SizedBox(
        height: 80,
        child: CustomPaint(
          painter: _PrivateHistogramPainter(
            frames: raster,
            barColor: _kRasterBar,
            isUiThread: false,
            showVisualization: true,
            showStatistics: false,
            header: 'GPU',
            subheader: '',
          ),
          size: Size.infinite,
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section: MaterialApp recipe and WidgetsApp wiring
// ---------------------------------------------------------------------------

Widget _privateBuildCodeBlock(String title, String code, {Color? accent}) {
  return Container(
    decoration: _privateCardDecoration(),
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, size: 16, color: accent ?? _kAccent),
            const SizedBox(width: 8),
            Text(title, style: _privateTitleStyle().copyWith(fontSize: 16)),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _kBgDeep,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _kBorder),
          ),
          child: Text(code, style: _privateMonoStyle(color: _kInk, size: 12)),
        ),
      ],
    ),
  );
}

const String _privateMaterialAppRecipe = '''MaterialApp(
  // Single boolean — turns on the default option set.
  showPerformanceOverlay: true,

  // Optional: also light up the checkerboards.
  checkerboardOffscreenLayers: true,
  checkerboardRasterCacheImages: true,

  home: const MyApp(),
);

// In dart:ui terms the boolean above is equivalent to setting the
// PerformanceOverlay s optionsMask to:
//   1 << PerformanceOverlayOption.displayRasterizerStatistics.index
// | 1 << PerformanceOverlayOption.visualizeRasterizerStatistics.index
// | 1 << PerformanceOverlayOption.displayEngineStatistics.index
// | 1 << PerformanceOverlayOption.visualizeEngineStatistics.index;''';

const String _privateWidgetsAppRecipe = '''// Custom placement: wrap your tree, then position the overlay
// yourself with a Stack — useful when you only want the bars
// in a specific corner during recording.

class DebugOverlay extends StatelessWidget {
  const DebugOverlay({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final mask = (1 << PerformanceOverlayOption.visualizeEngineStatistics.index)
               | (1 << PerformanceOverlayOption.visualizeRasterizerStatistics.index);

    return Stack(
      children: [
        child,
        Positioned(
          right: 8,
          top: 8,
          width: 240,
          height: 100,
          child: PerformanceOverlay(optionsMask: mask),
        ),
      ],
    );
  }
}''';

// ---------------------------------------------------------------------------
// Section: Pitfalls
// ---------------------------------------------------------------------------

Widget _privateBuildPitfallsCard() {
  return Container(
    decoration: _privateCardDecoration(border: _kAccentRed.withValues(alpha: 0.5)),
    padding: const EdgeInsets.all(18),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.warning_amber_rounded, color: _kAccentRed, size: 20),
            const SizedBox(width: 8),
            Text('Pitfalls', style: _privateTitleStyle()),
          ],
        ),
        const SizedBox(height: 10),
        _privateBulletLine(
          'Debug builds lie:',
          'numbers in --debug include extra checks (asserts, observatory). '
          'Always benchmark in --profile or --release.',
          accent: _kAccentRed,
        ),
        _privateBulletLine(
          'Frame budget ≠ 16ms always:',
          'on 90/120Hz devices the budget shrinks to ~11ms / ~8.3ms. The '
          'green target line is hardcoded at 16ms, so reading bars on high-'
          'refresh phones needs context.',
          accent: _kAccentWarm,
        ),
        _privateBulletLine(
          'UI vs raster confusion:',
          'a tall raster bar with a short UI bar means GPU work, not Dart '
          'work. Don\'t go optimizing setState() if the red graph is fine.',
        ),
        _privateBulletLine(
          'Checker thrash from dropdowns:',
          'temporary Opacity widgets often light up magenta. Replace with '
          'AnimatedOpacity + always-mounted, or use AlwaysIncludeSemantics.',
          accent: _kCheckerA,
        ),
        _privateBulletLine(
          'No effect in tests:',
          'PerformanceOverlay reads engine stats — under flutter_test there '
          'are no real frames so the overlay is empty.',
          accent: _kInkFaint,
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section: Footer
// ---------------------------------------------------------------------------

Widget _privateBuildFooter() {
  return Container(
    margin: const EdgeInsets.only(top: 18),
    padding: const EdgeInsets.all(16),
    decoration: _privateCardDecoration(fill: _kBgPanel),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 36,
          height: 36,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: _kAccent.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _kAccent.withValues(alpha: 0.5)),
          ),
          child: const Icon(Icons.bolt, color: _kAccent, size: 18),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'PerformanceOverlayOption · cheat sheet',
                style: _privateTitleStyle().copyWith(fontSize: 16),
              ),
              const SizedBox(height: 4),
              Text(
                '6 flags · 2 dimensions (UI/Raster · text/graph) + 2 checkerboards. '
                'Combine via bitmask, hand off to PerformanceOverlay.optionsMask, '
                'or take the shortcut MaterialApp.showPerformanceOverlay = true.',
                style: _privateSubtitleStyle(),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  for (final f in _privateFlagInfos)
                    _privateChip(f.name, f.tint),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Console diagnostic prelude — keeps the original test informational printouts
// ---------------------------------------------------------------------------

void _privatePrintDiagnostics() {
  print('PerformanceOverlayOption visual deep demo');
  print('=' * 50);
  print('values count: ${PerformanceOverlayOption.values.length}');
  for (final v in PerformanceOverlayOption.values) {
    print('  ${v.name} index=${v.index} bit=${1 << v.index}');
  }
  print('-' * 50);
  print('Sample overlay bitmask combinations:');
  final allMask = PerformanceOverlayOption.values.fold<int>(
    0,
    (acc, v) => acc | (1 << v.index),
  );
  print('  ALL flags        : 0b${allMask.toRadixString(2).padLeft(6, "0")}');
  final visualOnly = (1 << PerformanceOverlayOption.visualizeEngineStatistics.index) |
      (1 << PerformanceOverlayOption.visualizeRasterizerStatistics.index);
  print('  visualize only   : 0b${visualOnly.toRadixString(2).padLeft(6, "0")}');
  final rasterOnly = 1 << PerformanceOverlayOption.visualizeRasterizerStatistics.index;
  print('  raster visual    : 0b${rasterOnly.toRadixString(2).padLeft(6, "0")}');
  print('=' * 50);

  final smooth = _PrivateFrameSeries(
    'smooth',
    _privateGenerateSmoothFrames(60, 99),
  );
  final occ = _PrivateFrameSeries(
    'occasional',
    _privateGenerateOccasionalJank(60, 88),
  );
  final sust = _PrivateFrameSeries(
    'sustained',
    _privateGenerateSustainedJank(60, 77),
  );
  for (final s in [smooth, occ, sust]) {
    print(
      '  series ${s.label.padRight(11)} ui avg=${s.avgUi.toStringAsFixed(2)} '
      'worst=${s.worstUi.toStringAsFixed(2)} '
      'raster avg=${s.avgRaster.toStringAsFixed(2)} '
      'worst=${s.worstRaster.toStringAsFixed(2)}',
    );
  }
  print('=' * 50);
}

// ---------------------------------------------------------------------------
// Entry point
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  _privatePrintDiagnostics();

  // Pre-build the frame series used by the all-on / visualize-only replicas.
  final allOnUi = _privateGenerateBurstFrames(60, 51);
  final allOnRaster = _privateGenerateBurstFrames(60, 52);
  final singleFlagUi = _privateGenerateSmoothFrames(60, 61);
  final singleFlagRaster = _privateGenerateOccasionalJank(60, 62);

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark().copyWith(
      scaffoldBackgroundColor: _kBgDeep,
      textTheme: ThemeData.dark().textTheme.apply(
            bodyColor: _kInk,
            displayColor: _kInk,
          ),
    ),
    home: Scaffold(
      backgroundColor: _kBgDeep,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _privateSectionTitle(
              '01',
              'Hero · the FPS meter',
              'Why PerformanceOverlayOption exists.',
            ),
            _privateBuildHeroCard(),

            _privateSectionTitle(
              '02',
              'Anatomy · two histograms, three lines',
              'How to parse the grid before you parse the bars.',
            ),
            _privateBuildAnatomyCard(),

            _privateSectionTitle(
              '03',
              'The six flags',
              'Each card describes a single bit in the overlay\'s optionsMask.',
            ),
            _privateBuildFlagCardsGrid(),

            _privateSectionTitle(
              '04',
              'Replica · all flags ON',
              'What you see when MaterialApp.showPerformanceOverlay = true and '
              'both checkerboards are enabled.',
            ),
            _privateBuildOverlayReplica(
              title: 'optionsMask = 0b001111 (the four numeric/graph flags)',
              subtitle:
                  'UI thread on top, raster thread below. Bars + textual avg/'
                  'worst readouts.',
              visualizeUi: true,
              visualizeRaster: true,
              displayUi: true,
              displayRaster: true,
              uiFrames: allOnUi,
              rasterFrames: allOnRaster,
              activeFlags: const [
                'visualizeEngineStatistics',
                'displayEngineStatistics',
                'visualizeRasterizerStatistics',
                'displayRasterizerStatistics',
              ],
            ),

            _privateSectionTitle(
              '05',
              'Replica · only visualizeRasterizerStatistics',
              'A minimal overlay focused on GPU thread bars.',
            ),
            _privateBuildOverlayReplica(
              title: 'optionsMask = 1 << visualizeRasterizerStatistics.index',
              subtitle:
                  'Raster bars only. UI graph collapses to a placeholder hint.',
              visualizeUi: false,
              visualizeRaster: true,
              displayUi: false,
              displayRaster: false,
              uiFrames: singleFlagUi,
              rasterFrames: singleFlagRaster,
              activeFlags: const ['visualizeRasterizerStatistics'],
            ),

            _privateSectionTitle(
              '06',
              'Checkerboards · the other two flags',
              'Not graphs — colored tiles painted on top of the actual scene.',
            ),
            _privateBuildCheckerboardsCard(),

            _privateSectionTitle(
              '07',
              'Reading jank patterns',
              'Smooth, occasional, sustained — and what each implies.',
            ),
            _privateBuildJankPatternsCard(),

            _privateSectionTitle(
              '08',
              'Recipe · MaterialApp shortcut',
              'The single boolean that turns on the four numeric/graph flags.',
            ),
            _privateBuildCodeBlock(
              'MaterialApp showPerformanceOverlay',
              _privateMaterialAppRecipe,
            ),

            _privateSectionTitle(
              '09',
              'Recipe · custom placement via PerformanceOverlay',
              'Lower-level wiring when the default position is wrong.',
            ),
            _privateBuildCodeBlock(
              'Custom debug overlay',
              _privateWidgetsAppRecipe,
              accent: _kAccentWarm,
            ),

            _privateSectionTitle(
              '10',
              'Pitfalls',
              'What goes wrong if you read the overlay literally.',
            ),
            _privateBuildPitfallsCard(),

            _privateBuildFooter(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    ),
  );
}
