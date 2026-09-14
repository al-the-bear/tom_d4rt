// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt deep visual demo: ImageStream pipeline glue types from
// package:flutter/painting.dart. This file is a hand-authored, analyzer-clean
// static visualisation. It does not load real images; every value is inert
// literal data, rendered as labelled cards, diagrams, and tables.
//
// Topics covered:
//   - ImageStream
//   - ImageStreamListener (image / chunk / error callbacks)
//   - ImageStreamCompleter (abstract base)
//   - MultiFrameImageStreamCompleter   (concept-only)
//   - OneFrameImageStreamCompleter     (concept-only)
//   - ImageInfo (image, scale, debugLabel)
//   - ImageChunkEvent (cumulativeBytesLoaded, expectedTotalBytes)
//   - PlaceholderDimensions (size, alignment, baselineOffset, baseline)
//   - InlineSpanSemanticsInformation (text, isPlaceholder, requiresOwnNode)
//   - Accumulator (running counter helper)
//
// The whole file is rendered as a top-level dynamic build(BuildContext) →
// MaterialApp → Scaffold → SafeArea → SingleChildScrollView → Column harness,
// suitable for the d4rt flutter_ast HTTP test corpus.

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Theme constants used by the demo. Centralised for analyzer cleanliness and
// to keep the gradient/shadow inventory easy to count.
// ---------------------------------------------------------------------------

const Color _bgDeep = Color(0xFF0E1530);
const Color _accentCyan = Color(0xFF4DD0E1);
const Color _accentMagenta = Color(0xFFE040FB);
const Color _accentAmber = Color(0xFFFFC107);
const Color _accentGreen = Color(0xFF66BB6A);
const Color _accentRed = Color(0xFFEF5350);
const Color _ink = Color(0xFFE8EAF6);
const Color _muted = Color(0xFFB0BEC5);

// ---------------------------------------------------------------------------
// Reusable section-card shell. Each section card carries a distinct gradient
// and a multi-layer shadow stack so the demo accumulates the required visual
// inventory naturally as sections are added.
// ---------------------------------------------------------------------------

Widget _sectionCard({
  required String title,
  required String subtitle,
  required List<Color> gradient,
  required Color accent,
  required Widget child,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    padding: const EdgeInsets.fromLTRB(20, 18, 20, 22),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(18),
      gradient: LinearGradient(
        colors: gradient,
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      boxShadow: [
        BoxShadow(
          color: accent.withOpacity(0.32),
          blurRadius: 22,
          spreadRadius: 1,
          offset: const Offset(0, 10),
        ),
        BoxShadow(
          color: Colors.black.withOpacity(0.45),
          blurRadius: 36,
          spreadRadius: 2,
          offset: const Offset(0, 18),
        ),
        BoxShadow(
          color: accent.withOpacity(0.10),
          blurRadius: 4,
          offset: const Offset(0, 1),
        ),
      ],
      border: Border.all(color: accent.withOpacity(0.55), width: 1.2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 10,
              height: 36,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [accent, accent.withOpacity(0.3)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: _ink,
                      fontSize: 19,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.4,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: accent.withOpacity(0.95),
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.6,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        child,
      ],
    ),
  );
}

Widget _prose(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Text(
      text,
      style: TextStyle(
        color: _ink.withOpacity(0.92),
        fontSize: 13.5,
        height: 1.45,
      ),
    ),
  );
}

Widget _pill(String label, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    margin: const EdgeInsets.only(right: 6, bottom: 6),
    decoration: BoxDecoration(
      color: color.withOpacity(0.18),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: color.withOpacity(0.7)),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: color,
        fontSize: 11.5,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.4,
      ),
    ),
  );
}

Widget _kv(String key, String value, {Color? valueColor}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 170,
          child: Text(
            key,
            style: TextStyle(
              color: _muted,
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.3,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: valueColor ?? _ink,
              fontSize: 12.5,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _codeBlock(String code, {Color tint = _accentCyan}) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(vertical: 8),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [Color(0xFF101728), Color(0xFF192038)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: tint.withOpacity(0.4)),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.55),
          blurRadius: 14,
          offset: const Offset(0, 6),
        ),
        BoxShadow(
          color: tint.withOpacity(0.10),
          blurRadius: 30,
          offset: const Offset(0, 0),
        ),
      ],
    ),
    child: Text(
      code,
      style: TextStyle(
        color: tint,
        fontSize: 12,
        height: 1.5,
        fontFamily: 'monospace',
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// CustomPainter #1 — the image-load pipeline diagram.
// Draws six boxes connected by arrows:
//   ImageProvider → ImageStream → ImageStreamCompleter →
//   ImageStreamListener → ImageInfo → Paint
// Each box is annotated with role and the data it carries.
// ---------------------------------------------------------------------------

class _PipelinePainter extends CustomPainter {
  const _PipelinePainter();

  static const List<String> _nodes = [
    'ImageProvider',
    'ImageStream',
    'ImageStream\nCompleter',
    'ImageStream\nListener',
    'ImageInfo',
    'paint(canvas)',
  ];

  static const List<String> _labels = [
    'key + resolve()',
    'handle attach',
    'driver / decode',
    'callbacks',
    'ui.Image + scale',
    'drawImageRect',
  ];

  static const List<Color> _colors = [
    Color(0xFF4DD0E1),
    Color(0xFF80DEEA),
    Color(0xFFFFC107),
    Color(0xFFE040FB),
    Color(0xFF66BB6A),
    Color(0xFFEF5350),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final bgPaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFF101A38), Color(0xFF1B2552)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Offset.zero & size);
    final rrect = RRect.fromRectAndRadius(
      Offset.zero & size,
      const Radius.circular(14),
    );
    canvas.drawRRect(rrect, bgPaint);

    final boxW = (size.width - 80) / 3.0;
    final boxH = 60.0;
    final gapX = (size.width - 3 * boxW) / 4.0;
    final rows = [40.0, 40.0 + boxH + 70.0];

    final positions = <Offset>[];
    for (int i = 0; i < _nodes.length; i++) {
      final col = i % 3;
      final row = i ~/ 3;
      final x = gapX + col * (boxW + gapX);
      final y = rows[row];
      positions.add(Offset(x, y));
    }

    // Connecting arrows behind boxes.
    final arrow = Paint()
      ..color = _accentCyan.withOpacity(0.8)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;
    for (int i = 0; i < _nodes.length - 1; i++) {
      final from = positions[i];
      final to = positions[i + 1];
      final fromCenter = Offset(from.dx + boxW / 2, from.dy + boxH / 2);
      final toCenter = Offset(to.dx + boxW / 2, to.dy + boxH / 2);
      _drawArrow(canvas, fromCenter, toCenter, arrow);
    }

    // Boxes.
    for (int i = 0; i < _nodes.length; i++) {
      final pos = positions[i];
      final rect = Rect.fromLTWH(pos.dx, pos.dy, boxW, boxH);
      final rr = RRect.fromRectAndRadius(rect, const Radius.circular(10));
      final fill = Paint()
        ..shader = LinearGradient(
          colors: [_colors[i].withOpacity(0.85), _colors[i].withOpacity(0.45)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ).createShader(rect);
      canvas.drawRRect(rr, fill);
      final stroke = Paint()
        ..color = Colors.white.withOpacity(0.85)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2;
      canvas.drawRRect(rr, stroke);

      final title = TextPainter(
        text: TextSpan(
          text: _nodes[i],
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11.5,
            fontWeight: FontWeight.w800,
          ),
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );
      title.layout(maxWidth: boxW - 8);
      title.paint(
        canvas,
        Offset(pos.dx + (boxW - title.width) / 2, pos.dy + 6),
      );

      final sub = TextPainter(
        text: TextSpan(
          text: _labels[i],
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 9.5,
            fontStyle: FontStyle.italic,
          ),
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );
      sub.layout(maxWidth: boxW - 8);
      sub.paint(
        canvas,
        Offset(pos.dx + (boxW - sub.width) / 2, pos.dy + boxH - sub.height - 4),
      );
    }
  }

  void _drawArrow(Canvas canvas, Offset a, Offset b, Paint paint) {
    canvas.drawLine(a, b, paint);
    final dir = (b - a);
    final len = dir.distance;
    if (len < 1) return;
    final ux = dir.dx / len;
    final uy = dir.dy / len;
    final tipBase = Offset(b.dx - ux * 10, b.dy - uy * 10);
    final left = Offset(tipBase.dx + uy * 5, tipBase.dy - ux * 5);
    final right = Offset(tipBase.dx - uy * 5, tipBase.dy + ux * 5);
    final tri = Path()
      ..moveTo(b.dx, b.dy)
      ..lineTo(left.dx, left.dy)
      ..lineTo(right.dx, right.dy)
      ..close();
    final fill = Paint()..color = paint.color;
    canvas.drawPath(tri, fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ---------------------------------------------------------------------------
// CustomPainter #2 — the Accumulator graphic. Renders a stack of bars,
// each representing one increment() call. The cumulative height visualises
// the running counter — exactly what Accumulator tracks during a single
// dimension-collection pass over an inline-span tree.
// ---------------------------------------------------------------------------

class _AccumulatorPainter extends CustomPainter {
  final List<int> increments;
  const _AccumulatorPainter(this.increments);

  @override
  void paint(Canvas canvas, Size size) {
    final bg = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFF132044), Color(0xFF1F2D5E)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Offset.zero & size);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Offset.zero & size,
        const Radius.circular(12),
      ),
      bg,
    );

    final total = increments.fold<int>(0, (a, b) => a + b);
    if (total == 0) return;

    final usableHeight = size.height - 40;
    final barWidth = (size.width - 32) / increments.length;

    double running = 0;
    for (int i = 0; i < increments.length; i++) {
      final segment = increments[i];
      final segHeight = (segment / total) * usableHeight;
      final left = 16 + i * barWidth;
      final top = size.height - 20 - running - segHeight;
      final rect = Rect.fromLTWH(left + 2, top, barWidth - 4, segHeight);
      final paint = Paint()
        ..shader = LinearGradient(
          colors: [
            HSVColor.fromAHSV(1, (i * 53) % 360, 0.7, 0.95).toColor(),
            HSVColor.fromAHSV(1, (i * 53 + 30) % 360, 0.8, 0.7).toColor(),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ).createShader(rect);
      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, const Radius.circular(4)),
        paint,
      );
      final label = TextPainter(
        text: TextSpan(
          text: '+$segment',
          style: const TextStyle(color: Colors.white, fontSize: 10),
        ),
        textDirection: TextDirection.ltr,
      );
      label.layout();
      label.paint(
        canvas,
        Offset(left + (barWidth - label.width) / 2, top - 14),
      );
      running += segHeight;
    }

    final totalLabel = TextPainter(
      text: TextSpan(
        text: 'value = $total',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    totalLabel.layout();
    totalLabel.paint(
      canvas,
      Offset(size.width - totalLabel.width - 12, 8),
    );
  }

  @override
  bool shouldRepaint(covariant _AccumulatorPainter oldDelegate) =>
      oldDelegate.increments != increments;
}

// ---------------------------------------------------------------------------
// CustomPainter #3 — PlaceholderDimensions diagram. Draws a baseline text
// row with an inline placeholder box anchored at PlaceholderAlignment.middle,
// plus reference guides for baseline / aboveBaseline / belowBaseline.
// ---------------------------------------------------------------------------

class _PlaceholderPainter extends CustomPainter {
  const _PlaceholderPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final bg = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFF18243F), Color(0xFF22305A)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Offset.zero & size);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Offset.zero & size,
        const Radius.circular(12),
      ),
      bg,
    );

    final baselineY = size.height * 0.62;
    final guide = Paint()
      ..color = Colors.white24
      ..strokeWidth = 1.0;
    canvas.drawLine(
      Offset(20, baselineY),
      Offset(size.width - 20, baselineY),
      guide,
    );

    final guides = <double, String>{
      baselineY - 38: 'top',
      baselineY - 18: 'aboveBaseline',
      baselineY: 'baseline',
      baselineY + 18: 'belowBaseline',
      baselineY + 38: 'bottom',
    };
    final dash = Paint()
      ..color = Colors.white12
      ..strokeWidth = 0.8;
    guides.forEach((y, label) {
      canvas.drawLine(
        Offset(40, y),
        Offset(size.width - 40, y),
        dash,
      );
      final tp = TextPainter(
        text: TextSpan(
          text: label,
          style: const TextStyle(color: Colors.white54, fontSize: 9),
        ),
        textDirection: TextDirection.ltr,
      );
      tp.layout();
      tp.paint(canvas, Offset(size.width - 8 - tp.width, y - 6));
    });

    // "The " text.
    _drawText(canvas, 'The ', 24, baselineY - 14, Colors.white);
    // Placeholder box (middle aligned).
    final boxRect = Rect.fromLTWH(80, baselineY - 32, 50, 40);
    final fill = Paint()
      ..shader = const LinearGradient(
        colors: [_accentMagenta, Color(0xFF7C4DFF)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(boxRect);
    canvas.drawRRect(
      RRect.fromRectAndRadius(boxRect, const Radius.circular(6)),
      fill,
    );
    final boxLabel = TextPainter(
      text: const TextSpan(
        text: 'IMG',
        style: TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.w800,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    boxLabel.layout();
    boxLabel.paint(
      canvas,
      Offset(
        boxRect.left + (boxRect.width - boxLabel.width) / 2,
        boxRect.top + (boxRect.height - boxLabel.height) / 2,
      ),
    );

    _drawText(canvas, ' photo of a ', 140, baselineY - 14, Colors.white);

    // Second placeholder (baseline-aligned with offset).
    final box2 = Rect.fromLTWH(250, baselineY - 24, 40, 28);
    final fill2 = Paint()
      ..shader = const LinearGradient(
        colors: [_accentAmber, Color(0xFFFF7043)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(box2);
    canvas.drawRRect(
      RRect.fromRectAndRadius(box2, const Radius.circular(6)),
      fill2,
    );
    final box2Label = TextPainter(
      text: const TextSpan(
        text: 'PIC',
        style: TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.w800,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    box2Label.layout();
    box2Label.paint(
      canvas,
      Offset(
        box2.left + (box2.width - box2Label.width) / 2,
        box2.top + (box2.height - box2Label.height) / 2,
      ),
    );

    _drawText(canvas, ' kitten.', 300, baselineY - 14, Colors.white);

    // Annotation arrows.
    final arrowPaint = Paint()
      ..color = _accentCyan
      ..strokeWidth = 1.4;
    canvas.drawLine(
      Offset(boxRect.left + boxRect.width / 2, boxRect.bottom + 2),
      Offset(boxRect.left + boxRect.width / 2, baselineY + 30),
      arrowPaint,
    );
    final note = TextPainter(
      text: const TextSpan(
        text: 'middle',
        style: TextStyle(color: _accentCyan, fontSize: 10),
      ),
      textDirection: TextDirection.ltr,
    );
    note.layout();
    note.paint(
      canvas,
      Offset(boxRect.left + boxRect.width / 2 - note.width / 2, baselineY + 32),
    );
  }

  void _drawText(Canvas canvas, String text, double x, double y, Color c) {
    final tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(color: c, fontSize: 14, fontFamily: 'serif'),
      ),
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    tp.paint(canvas, Offset(x, y));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ---------------------------------------------------------------------------
// CustomPainter #4 — ImageChunkEvent progress bar with byte annotations.
// Static representation of a 64 KiB / 256 KiB decode in flight.
// ---------------------------------------------------------------------------

class _ChunkProgressPainter extends CustomPainter {
  final int loaded;
  final int? total;
  const _ChunkProgressPainter({required this.loaded, required this.total});

  @override
  void paint(Canvas canvas, Size size) {
    final bg = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFF15203D), Color(0xFF1E2C56)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Offset.zero & size);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Offset.zero & size,
        const Radius.circular(12),
      ),
      bg,
    );

    final barRect = Rect.fromLTWH(20, size.height / 2 - 14, size.width - 40, 28);
    final track = Paint()..color = Colors.white12;
    canvas.drawRRect(
      RRect.fromRectAndRadius(barRect, const Radius.circular(14)),
      track,
    );

    final fraction =
        total == null ? 0.35 : (loaded / total!).clamp(0.0, 1.0).toDouble();
    final fillRect = Rect.fromLTWH(
      barRect.left,
      barRect.top,
      barRect.width * fraction,
      barRect.height,
    );
    final fill = Paint()
      ..shader = const LinearGradient(
        colors: [_accentGreen, _accentCyan],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ).createShader(fillRect);
    canvas.drawRRect(
      RRect.fromRectAndRadius(fillRect, const Radius.circular(14)),
      fill,
    );

    // Tick marks every 25%.
    final tickPaint = Paint()
      ..color = Colors.white38
      ..strokeWidth = 1.0;
    for (int i = 1; i < 4; i++) {
      final x = barRect.left + barRect.width * (i / 4.0);
      canvas.drawLine(
        Offset(x, barRect.bottom),
        Offset(x, barRect.bottom + 4),
        tickPaint,
      );
    }

    final pct = total == null ? '?' : '${(fraction * 100).toStringAsFixed(0)}%';
    final label = TextPainter(
      text: TextSpan(
        text: 'cumulativeBytesLoaded=$loaded / expectedTotalBytes=${total ?? 'null'}   ($pct)',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.w600,
          fontFamily: 'monospace',
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    label.layout(maxWidth: size.width - 40);
    label.paint(canvas, Offset(20, barRect.bottom + 10));
  }

  @override
  bool shouldRepaint(covariant _ChunkProgressPainter oldDelegate) =>
      oldDelegate.loaded != loaded || oldDelegate.total != total;
}

// ---------------------------------------------------------------------------
// CustomPainter #5 — Mock thumbnail used by the ImageInfo card. Draws a
// stylised landscape so the "image" looks plausible without referencing
// any real ui.Image instance.
// ---------------------------------------------------------------------------

class _MockThumbPainter extends CustomPainter {
  const _MockThumbPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final sky = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFF263F8C), Color(0xFFE040FB), Color(0xFFFFC107)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Offset.zero & size);
    canvas.drawRect(Offset.zero & size, sky);

    // Sun.
    final sun = Paint()..color = Colors.yellow.withOpacity(0.85);
    canvas.drawCircle(
      Offset(size.width * 0.7, size.height * 0.45),
      size.width * 0.10,
      sun,
    );

    // Mountains.
    final mountain = Paint()
      ..shader = LinearGradient(
        colors: [Colors.indigo.shade900, Colors.deepPurple.shade700],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Offset.zero & size);
    final p = Path()
      ..moveTo(0, size.height * 0.85)
      ..lineTo(size.width * 0.25, size.height * 0.55)
      ..lineTo(size.width * 0.45, size.height * 0.75)
      ..lineTo(size.width * 0.65, size.height * 0.50)
      ..lineTo(size.width * 0.85, size.height * 0.72)
      ..lineTo(size.width, size.height * 0.60)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(p, mountain);

    // Ground reflection.
    final ground = Paint()
      ..color = Colors.black.withOpacity(0.35);
    canvas.drawRect(
      Rect.fromLTRB(0, size.height * 0.85, size.width, size.height),
      ground,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ---------------------------------------------------------------------------
// Section builders. Kept as top-level functions so the harness `build`
// stays small and readable.
// ---------------------------------------------------------------------------

Widget _buildIntroSection() {
  return _sectionCard(
    title: '1. ImageStream pipeline at a glance',
    subtitle: 'Why painting needs four cooperating types',
    gradient: const [Color(0xFF1B2A55), Color(0xFF2A3C7E)],
    accent: _accentCyan,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _prose(
          'Flutter never paints an image directly off the wire. A network or '
          'asset request flows through four cooperating glue types: '
          'ImageProvider produces a key and resolves into an ImageStream; the '
          'stream holds a handle to an ImageStreamCompleter which actually '
          'drives the decode; one or more ImageStreamListener objects observe '
          'lifecycle events; and the final payload arrives as an immutable '
          'ImageInfo. The painting layer takes that ImageInfo, reads its '
          'ui.Image and scale, and only then draws to the canvas. Each link '
          'in this chain is intentionally narrow so caches, error handlers, '
          'and progress meters can be layered on without disturbing the rest.',
        ),
        Wrap(
          children: [
            _pill('ImageProvider', _accentCyan),
            _pill('ImageStream', _accentCyan),
            _pill('ImageStreamCompleter', _accentAmber),
            _pill('ImageStreamListener', _accentMagenta),
            _pill('ImageInfo', _accentGreen),
            _pill('paint()', _accentRed),
          ],
        ),
      ],
    ),
  );
}

Widget _buildPipelineDiagramSection() {
  return _sectionCard(
    title: '2. Anatomy: the load-and-paint pipeline',
    subtitle: 'CustomPainter diagram of the six stages',
    gradient: const [Color(0xFF1F2A56), Color(0xFF34367F)],
    accent: _accentMagenta,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 200,
          width: double.infinity,
          child: CustomPaint(painter: const _PipelinePainter()),
        ),
        _prose(
          'The diagram above maps each pipeline stage to the data it carries. '
          'ImageProvider hands back an ImageStream that is initially empty; '
          'attaching a completer is what actually starts work. The completer '
          'is the only object that knows how to decode bytes — everything '
          'else just observes. Listeners are added through ImageStream.addListener '
          'and removed by reference equality; this is why ImageStreamListener '
          'instances must be stored in fields when used by real widgets.',
        ),
      ],
    ),
  );
}

Widget _buildStreamSection() {
  return _sectionCard(
    title: '3. ImageStream — the observable handle',
    subtitle: 'Thin facade over an ImageStreamCompleter',
    gradient: const [Color(0xFF14305A), Color(0xFF1F4880)],
    accent: _accentCyan,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _prose(
          'ImageStream is deliberately lightweight: it stores a nullable '
          'completer plus a list of listeners that registered before the '
          'completer arrived. When a completer becomes available, those '
          'pending listeners are transferred so no events are lost. The '
          'stream itself never decodes anything; it forwards every '
          'addListener / removeListener call to the underlying completer. '
          'Two streams compare equal when they point at the same completer, '
          'which is how image caching can dedupe in-flight loads.',
        ),
        _kv('addListener(listener)', 'forwards to completer or buffers'),
        _kv('removeListener(listener)', 'O(n) scan, identity match'),
        _kv('setCompleter(completer)', 'flushes buffered listeners'),
        _kv('hasListeners', 'true after at least one add'),
        _kv('completer', 'null until resolved'),
      ],
    ),
  );
}

Widget _buildListenerSection() {
  return _sectionCard(
    title: '4. ImageStreamListener — three callbacks, one identity',
    subtitle: 'onImage, onChunk, onError',
    gradient: const [Color(0xFF301A4E), Color(0xFF513182)],
    accent: _accentMagenta,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _prose(
          'ImageStreamListener bundles up to three callbacks: a mandatory '
          'onImage that fires once per available frame, an optional '
          'onChunkEvent that fires while bytes are still arriving, and an '
          'optional onError that fires on decode or transport failure. The '
          'object is value-equatable on the three function references plus a '
          'boolean flag describing whether the listener wants to be notified '
          'on every animation frame or just the first. This equality is why '
          'callers must store the listener in a field; recreating it on each '
          'build would silently leak subscriptions.',
        ),
        _codeBlock(
          'final listener = ImageStreamListener(\n'
          '  (ImageInfo info, bool synchronousCall) {\n'
          '    // info.image is a ui.Image — draw it on the canvas.\n'
          '  },\n'
          '  onChunk: (ImageChunkEvent event) {\n'
          '    // event.cumulativeBytesLoaded / event.expectedTotalBytes\n'
          '  },\n'
          '  onError: (Object error, StackTrace? stack) {\n'
          '    // log + show fallback decoration\n'
          '  },\n'
          ');',
          tint: _accentMagenta,
        ),
        _kv('onImage', 'ImageListener (required)'),
        _kv('onChunk', 'ImageChunkListener? (optional)'),
        _kv('onError', 'ImageErrorListener? (optional)'),
      ],
    ),
  );
}

Widget _buildCompleterSection() {
  return _sectionCard(
    title: '5. ImageStreamCompleter — drives the decode',
    subtitle: 'Abstract base, two concrete subclasses',
    gradient: const [Color(0xFF3A2A12), Color(0xFF6B4A1A)],
    accent: _accentAmber,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _prose(
          'ImageStreamCompleter is the abstract engine that turns raw bytes '
          'into ImageInfo events. Painting ships two concrete subclasses. '
          'OneFrameImageStreamCompleter is for codecs that produce exactly one '
          'frame — JPEG, PNG, single-frame WebP, in-memory MemoryImage. '
          'MultiFrameImageStreamCompleter drives animated codecs (animated WebP, '
          'GIF, multi-frame AVIF) by holding a Codec and a Ticker, scheduling '
          'frame decodes and dispatching them to listeners. Both share the '
          'completer contract: setImage, reportError, and the listener '
          'reference-count that decides when to keep the stream alive.',
        ),
        _kv('addListener / removeListener', 'reference-counted'),
        _kv('hasListeners', 'guards animation pumps'),
        _kv('setImage(ImageInfo)', 'notifies all current listeners'),
        _kv('reportError(...)', 'invokes onError or rethrows'),
        _kv('reportImageChunkEvent(e)', 'progress notifications'),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.30),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _accentAmber.withOpacity(0.4)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Subclass comparison',
                style: TextStyle(
                  color: _accentAmber,
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.4,
                ),
              ),
              const SizedBox(height: 8),
              _kv('OneFrameImageStreamCompleter', 'static images — one ImageInfo'),
              _kv('MultiFrameImageStreamCompleter', 'animated — N frames + ticker'),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildImageInfoSection() {
  return _sectionCard(
    title: '6. ImageInfo — the immutable payload',
    subtitle: 'image, scale, debugLabel',
    gradient: const [Color(0xFF143526), Color(0xFF1F5A40)],
    accent: _accentGreen,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _prose(
          'ImageInfo wraps a fully decoded ui.Image with the metadata the '
          'painting layer needs in order to size and label it. The scale '
          'field is the device-pixel ratio the image was decoded at — '
          'painting divides physical pixels by scale to get logical pixels. '
          'The debugLabel field is a hint shown in DevTools and image-cache '
          'snapshots; it never affects layout or paint. The class is immutable; '
          'the only mutating operation is dispose(), which drops the ui.Image '
          'handle and decrements the underlying image refcount.',
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                width: 110,
                height: 80,
                child: CustomPaint(painter: const _MockThumbPainter()),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _kv('image', 'ui.Image  ⟵  (mock 320x200)'),
                  _kv('scale', '2.0  (decoded at 2x DPR)'),
                  _kv('debugLabel', '"network:sunset.jpg"'),
                  _kv('sizeBytes', '~256 KiB'),
                  _kv('disposed', 'false (held by 1 listener)'),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        _codeBlock(
          'ImageInfo(\n'
          '  image: image,           // ui.Image (literal in tests)\n'
          '  scale: 2.0,             // decoded device pixel ratio\n'
          '  debugLabel: "network:sunset.jpg",\n'
          ');',
          tint: _accentGreen,
        ),
      ],
    ),
  );
}

Widget _buildChunkSection() {
  return _sectionCard(
    title: '7. ImageChunkEvent — progress, but only sometimes',
    subtitle: 'cumulativeBytesLoaded, expectedTotalBytes',
    gradient: const [Color(0xFF1D2F5A), Color(0xFF345B9C)],
    accent: _accentCyan,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _prose(
          'ImageChunkEvent reports decode and transport progress. '
          'cumulativeBytesLoaded grows monotonically and is always set; '
          'expectedTotalBytes is best-effort and may be null when the source '
          'does not advertise a Content-Length header (chunked transfer, '
          'compressed bodies, streamed proxies). Callers that render a '
          'determinate progress bar must check for null before computing a '
          'percentage and fall back to an indeterminate spinner. The event '
          'is only delivered while bytes are still arriving — once the '
          'image is decoded, listeners receive onImage instead.',
        ),
        SizedBox(
          height: 100,
          width: double.infinity,
          child: CustomPaint(
            painter: const _ChunkProgressPainter(
              loaded: 65536,
              total: 262144,
            ),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 100,
          width: double.infinity,
          child: CustomPaint(
            painter: const _ChunkProgressPainter(
              loaded: 41200,
              total: null,
            ),
          ),
        ),
        _codeBlock(
          'const ImageChunkEvent(\n'
          '  cumulativeBytesLoaded: 65536,\n'
          '  expectedTotalBytes: 262144,\n'
          ');\n'
          '// When the server does not send Content-Length:\n'
          'const ImageChunkEvent(\n'
          '  cumulativeBytesLoaded: 41200,\n'
          '  expectedTotalBytes: null,\n'
          ');',
          tint: _accentCyan,
        ),
      ],
    ),
  );
}

Widget _buildPlaceholderSection() {
  return _sectionCard(
    title: '8. PlaceholderDimensions — shape of an inline image slot',
    subtitle: 'size + alignment + (optional) baseline',
    gradient: const [Color(0xFF3F1849), Color(0xFF6B2A82)],
    accent: _accentMagenta,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _prose(
          'PlaceholderDimensions describes the box reserved for an inline '
          'image (or any non-text inline span) inside a TextSpan tree. The '
          'TextPainter cannot lay out the line until it knows each '
          'placeholder\'s width, height, and how to anchor it relative to the '
          'text baseline. PlaceholderAlignment.baseline requires a non-null '
          'baseline field and uses baselineOffset to shift the placeholder '
          'up or down. The other six alignments (top, bottom, middle, '
          'aboveBaseline, belowBaseline, baseline) ignore baselineOffset.',
        ),
        SizedBox(
          height: 170,
          width: double.infinity,
          child: CustomPaint(painter: const _PlaceholderPainter()),
        ),
        const SizedBox(height: 8),
        _kv('size', 'Size(100, 50) — logical pixels'),
        _kv('alignment', 'PlaceholderAlignment.middle'),
        _kv('baselineOffset', '20.0 (only used for baseline)'),
        _kv('baseline', 'TextBaseline.alphabetic'),
        _codeBlock(
          'const PlaceholderDimensions(\n'
          '  size: Size(100, 50),\n'
          '  alignment: PlaceholderAlignment.middle,\n'
          ');\n'
          '\n'
          'const PlaceholderDimensions(\n'
          '  size: Size(80, 30),\n'
          '  alignment: PlaceholderAlignment.baseline,\n'
          '  baselineOffset: 20,\n'
          '  baseline: TextBaseline.alphabetic,\n'
          ');',
          tint: _accentMagenta,
        ),
      ],
    ),
  );
}

Widget _buildSemanticsSection() {
  return _sectionCard(
    title: '9. InlineSpanSemanticsInformation — what the screen reader hears',
    subtitle: 'text, isPlaceholder, requiresOwnNode',
    gradient: const [Color(0xFF1A3D2A), Color(0xFF2F6A4A)],
    accent: _accentGreen,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _prose(
          'When Flutter walks an InlineSpan tree to produce a semantics tree, '
          'each visited span emits one InlineSpanSemanticsInformation record. '
          'The text field carries the verbalised string; isPlaceholder flags '
          'spans that have no text (typically inline images or custom '
          'widgets); and requiresOwnNode is true when the span needs to be '
          'addressable as its own focusable / tappable semantics node. The '
          'static const placeholder constant is reused for every '
          'WidgetSpan / PlaceholderSpan so that the semantics tree does not '
          'allocate a fresh record per inline image.',
        ),
        _kv('text', '"Hello World"'),
        _kv('isPlaceholder', 'false'),
        _kv('requiresOwnNode', 'false'),
        _kv('semanticsLabel', 'null'),
        _kv('stringAttributes', '<const empty>'),
        const SizedBox(height: 8),
        Wrap(
          children: [
            _pill('text-span entry', _accentGreen),
            _pill('placeholder marker', _accentMagenta),
            _pill('owned semantics node', _accentAmber),
            _pill('inherits parent label', _accentCyan),
          ],
        ),
      ],
    ),
  );
}

Widget _buildAccumulatorSection() {
  return _sectionCard(
    title: '10. Accumulator — the running counter helper',
    subtitle: 'A tiny utility, surprisingly load-bearing',
    gradient: const [Color(0xFF42301A), Color(0xFF7A5A28)],
    accent: _accentAmber,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _prose(
          'Accumulator is a one-field helper class used by TextPainter and '
          'related code to thread a running counter through recursive span '
          'walks. The painter cannot return the counter as a value because '
          'each recursive call may extend it; it cannot store it in a field '
          'on the painter because the same painter may be re-entered. So '
          'Accumulator is passed down by reference, every nested call '
          'increments it, and the top-level caller reads the final total. '
          'It exposes exactly one mutating method, increment(int addend), '
          'and one read-only property, value.',
        ),
        SizedBox(
          height: 160,
          width: double.infinity,
          child: CustomPaint(
            painter: const _AccumulatorPainter([5, 3, 7, 2, 9, 4]),
          ),
        ),
        const SizedBox(height: 4),
        _codeBlock(
          'final acc = Accumulator();          // value: 0\n'
          'acc.increment(5);                   // value: 5\n'
          'acc.increment(3);                   // value: 8\n'
          'acc.increment(7);                   // value: 15\n'
          'acc.increment(2);                   // value: 17\n'
          'acc.increment(9);                   // value: 26\n'
          'acc.increment(4);                   // value: 30',
          tint: _accentAmber,
        ),
        _kv('value', 'int — current total'),
        _kv('increment(int)', 'void — adds to running total'),
        _kv('immutable?', 'no — mutates in place'),
      ],
    ),
  );
}

Widget _buildListenerDecisionMatrix() {
  final headers = ['Need', 'onImage', 'onChunk', 'onError'];
  final rows = <List<String>>[
    ['Just paint a static image', 'required', '—', 'optional'],
    ['Paint + progress UI', 'required', 'required', 'required'],
    ['Paint + error fallback', 'required', '—', 'required'],
    ['Animated frame ticker', 'required', '—', 'required'],
    ['Cache warm-up (no paint)', 'no-op handler', '—', 'required'],
    ['Probe size only', 'read info.image then drop', '—', 'required'],
  ];

  return _sectionCard(
    title: '11. Decision matrix — which listener callbacks do I need?',
    subtitle: 'Pick the smallest set for your use case',
    gradient: const [Color(0xFF1D1F44), Color(0xFF34386F)],
    accent: _accentRed,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _prose(
          'ImageStreamListener can omit chunk and error callbacks, but in '
          'production almost every call site wants an onError — silent '
          'failures cause the dreaded grey-box bug. onChunk should be '
          'plumbed in only when there is a visible progress indicator, '
          'because expectedTotalBytes is often null and the cost of '
          'building a determinate UI that handles indeterminate input is '
          'real. This matrix collects the common patterns.',
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _accentRed.withOpacity(0.5)),
            color: Colors.black.withOpacity(0.30),
          ),
          child: Column(
            children: [
              _decisionRow(headers, isHeader: true),
              for (final r in rows) _decisionRow(r),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _decisionRow(List<String> cells, {bool isHeader = false}) {
  final style = TextStyle(
    color: isHeader ? _accentRed : _ink,
    fontSize: 12,
    fontWeight: isHeader ? FontWeight.w800 : FontWeight.w500,
    fontFamily: isHeader ? null : 'monospace',
  );
  return Container(
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(color: Colors.white12, width: 1),
      ),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    child: Row(
      children: [
        Expanded(flex: 3, child: Text(cells[0], style: style)),
        Expanded(flex: 2, child: Text(cells[1], style: style)),
        Expanded(flex: 2, child: Text(cells[2], style: style)),
        Expanded(flex: 2, child: Text(cells[3], style: style)),
      ],
    ),
  );
}

Widget _buildSnippetSection() {
  return _sectionCard(
    title: '12. End-to-end snippet — the canonical attach',
    subtitle: 'How the pieces fit in real code',
    gradient: const [Color(0xFF1A2A4F), Color(0xFF2D4585)],
    accent: _accentCyan,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _prose(
          'The snippet below shows the canonical wiring inside an Element '
          'that paints a network image: resolve the provider, store the '
          'returned stream in a field, build an ImageStreamListener that '
          'captures the three callbacks, and attach it. The matching detach '
          'lives in dispose() and uses the same listener reference. This is '
          'the contract every higher-level widget (Image, FadeInImage, '
          'DecorationImage) ultimately enforces.',
        ),
        _codeBlock(
          '// inside a State / RenderObject — pseudo-code, not executed here\n'
          'late ImageStream _stream;\n'
          'late ImageStreamListener _listener;\n'
          '\n'
          'void _resolve(ImageProvider provider) {\n'
          '  _stream = provider.resolve(ImageConfiguration.empty);\n'
          '  _listener = ImageStreamListener(\n'
          '    _handleImage,\n'
          '    onChunk: _handleChunk,\n'
          '    onError: _handleError,\n'
          '  );\n'
          '  _stream.addListener(_listener);\n'
          '}\n'
          '\n'
          'void _handleImage(ImageInfo info, bool sync) {\n'
          '  // Hold onto info.image until next frame, then dispose.\n'
          '}\n'
          'void _handleChunk(ImageChunkEvent e) {\n'
          '  final pct = e.expectedTotalBytes == null\n'
          '      ? null\n'
          '      : e.cumulativeBytesLoaded / e.expectedTotalBytes!;\n'
          '}\n'
          'void _handleError(Object err, StackTrace? stack) { /* log */ }\n'
          '\n'
          '@override\n'
          'void dispose() {\n'
          '  _stream.removeListener(_listener);\n'
          '  super.dispose();\n'
          '}',
          tint: _accentCyan,
        ),
      ],
    ),
  );
}

Widget _buildInteractiveSection() {
  return _sectionCard(
    title: '13. Inert interactive — toggle which callbacks are wired',
    subtitle: 'StatefulBuilder; no real stream attached',
    gradient: const [Color(0xFF2A1A40), Color(0xFF4B2A78)],
    accent: _accentMagenta,
    child: StatefulBuilder(
      builder: (context, setState) {
        bool wantImage = true;
        bool wantChunk = false;
        bool wantError = true;
        return StatefulBuilder(
          builder: (context, innerSet) {
            Widget chip(String label, bool selected, void Function() onTap) {
              return GestureDetector(
                onTap: () => innerSet(onTap),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 7),
                  margin: const EdgeInsets.only(right: 8, bottom: 8),
                  decoration: BoxDecoration(
                    color: selected
                        ? _accentMagenta.withOpacity(0.25)
                        : Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: selected
                          ? _accentMagenta
                          : Colors.white24,
                    ),
                  ),
                  child: Text(
                    '${selected ? "✓ " : "  "}$label',
                    style: TextStyle(
                      color: selected ? Colors.white : _muted,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _prose(
                  'Toggle the three callbacks to see which fields the '
                  'resulting ImageStreamListener would carry. Nothing is '
                  'attached to a real stream — this is purely a literal '
                  'preview of the constructor arguments.',
                ),
                Wrap(
                  children: [
                    chip('onImage', wantImage,
                        () => wantImage = !wantImage),
                    chip('onChunk', wantChunk,
                        () => wantChunk = !wantChunk),
                    chip('onError', wantError,
                        () => wantError = !wantError),
                  ],
                ),
                const SizedBox(height: 8),
                _codeBlock(
                  'ImageStreamListener(\n'
                  '  ${wantImage ? "_onImage" : "(_, __) {}"},'
                  '${wantChunk ? "\n  onChunk: _onChunk," : ""}'
                  '${wantError ? "\n  onError: _onError," : ""}\n'
                  ');',
                  tint: _accentMagenta,
                ),
                _kv('listener.onImage', wantImage ? '_onImage' : 'no-op'),
                _kv('listener.onChunk',
                    wantChunk ? '_onChunk' : 'null'),
                _kv('listener.onError',
                    wantError ? '_onError' : 'null'),
              ],
            );
          },
        );
      },
    ),
  );
}

Widget _buildPaletteSection() {
  return _sectionCard(
    title: '14. Related type palette',
    subtitle: 'Quick map of who touches what',
    gradient: const [Color(0xFF22183F), Color(0xFF3A2A6A)],
    accent: _accentCyan,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _prose(
          'These are the types most often seen on the same import line as '
          'the pipeline classes above. Some are consumed by the painting '
          'layer; some are produced by it. Treat this as a quick lookup '
          'table when navigating package:flutter/painting.dart.',
        ),
        Wrap(
          children: [
            _pill('ImageProvider', _accentCyan),
            _pill('ImageStream', _accentCyan),
            _pill('ImageStreamCompleter', _accentAmber),
            _pill('OneFrameImageStreamCompleter', _accentAmber),
            _pill('MultiFrameImageStreamCompleter', _accentAmber),
            _pill('ImageStreamListener', _accentMagenta),
            _pill('ImageInfo', _accentGreen),
            _pill('ImageChunkEvent', _accentCyan),
            _pill('ImageConfiguration', _accentGreen),
            _pill('ImageCache', _accentRed),
            _pill('PlaceholderDimensions', _accentMagenta),
            _pill('PlaceholderAlignment', _accentMagenta),
            _pill('InlineSpanSemanticsInformation', _accentGreen),
            _pill('Accumulator', _accentAmber),
            _pill('TextPainter', _ink),
            _pill('Codec', _accentRed),
          ],
        ),
      ],
    ),
  );
}

Widget _buildLiteralsTable() {
  return _sectionCard(
    title: '15. Literal-data snapshot',
    subtitle: 'Direct construction without attaching to anything',
    gradient: const [Color(0xFF14223D), Color(0xFF1E3666)],
    accent: _accentGreen,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _prose(
          'You can construct ImageChunkEvent and PlaceholderDimensions '
          'directly with literal values — they are inert data carriers. '
          'ImageInfo cannot be constructed in this demo without a real '
          'ui.Image, so it is described symbolically. The two tables '
          'below show inert instances that would be perfectly valid as '
          'arguments to onChunkEvent / TextPainter.setPlaceholderDimensions.',
        ),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.30),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _accentGreen.withOpacity(0.5)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sample ImageChunkEvent values',
                style: TextStyle(
                  color: _accentGreen,
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 6),
              _kv('e1', 'cumulative=5000  expected=10000  (50%)'),
              _kv('e2', 'cumulative=3000  expected=null    (indeterminate)'),
              _kv('e3', 'cumulative=262144 expected=262144 (done)'),
              _kv('e4', 'cumulative=0     expected=1048576 (just started)'),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.30),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _accentMagenta.withOpacity(0.5)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sample PlaceholderDimensions values',
                style: TextStyle(
                  color: _accentMagenta,
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 6),
              _kv('p1', 'Size(100,50)  middle'),
              _kv('p2', 'Size(80,30)   baseline  offset=20'),
              _kv('p3', 'Size(64,64)   top'),
              _kv('p4', 'Size(24,24)   aboveBaseline'),
              _kv('p5', 'Size(32,16)   belowBaseline'),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildFooter() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(14),
      gradient: const LinearGradient(
        colors: [Color(0xFF0E1530), Color(0xFF1B2452)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      border: Border.all(color: _accentCyan.withOpacity(0.5)),
      boxShadow: [
        BoxShadow(
          color: _accentCyan.withOpacity(0.18),
          blurRadius: 24,
          offset: const Offset(0, 8),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'imagestream_misc — deep visual demo',
          style: TextStyle(
            color: _accentCyan,
            fontSize: 14,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.6,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'All values shown are literal, inert data — no real image was '
          'fetched, decoded, or attached to any stream. This file exists '
          'to exercise the tom_d4rt_flutter_ast AST pipeline against a '
          'visually rich, analyzer-clean Flutter source.',
          style: TextStyle(
            color: _ink.withOpacity(0.85),
            fontSize: 12.5,
            height: 1.45,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Harness entry point.
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  print('imagestream_misc_test: building deep visual demo');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(brightness: Brightness.dark),
    home: Scaffold(
      backgroundColor: _bgDeep,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(16, 20, 16, 4),
                padding: const EdgeInsets.fromLTRB(20, 22, 20, 24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF142348),
                      Color(0xFF20336E),
                      Color(0xFF3A2A78),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: _accentMagenta.withOpacity(0.30),
                      blurRadius: 28,
                      offset: const Offset(0, 12),
                    ),
                    BoxShadow(
                      color: Colors.black.withOpacity(0.55),
                      blurRadius: 40,
                      offset: const Offset(0, 18),
                    ),
                  ],
                  border: Border.all(color: _accentMagenta.withOpacity(0.5)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ImageStream & friends',
                      style: TextStyle(
                        color: _ink,
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'A deep tour of the painting pipeline glue types',
                      style: TextStyle(
                        color: _accentCyan,
                        fontSize: 13.5,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.6,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Wrap(
                      children: [
                        _pill('static demo', _accentCyan),
                        _pill('no real images', _accentAmber),
                        _pill('literal data only', _accentGreen),
                        _pill('CustomPainter heavy', _accentMagenta),
                      ],
                    ),
                  ],
                ),
              ),
              _buildIntroSection(),
              _buildPipelineDiagramSection(),
              _buildStreamSection(),
              _buildListenerSection(),
              _buildCompleterSection(),
              _buildImageInfoSection(),
              _buildChunkSection(),
              _buildPlaceholderSection(),
              _buildSemanticsSection(),
              _buildAccumulatorSection(),
              _buildListenerDecisionMatrix(),
              _buildSnippetSection(),
              _buildInteractiveSection(),
              _buildPaletteSection(),
              _buildLiteralsTable(),
              _buildFooter(),
            ],
          ),
        ),
      ),
    ),
  );
}
