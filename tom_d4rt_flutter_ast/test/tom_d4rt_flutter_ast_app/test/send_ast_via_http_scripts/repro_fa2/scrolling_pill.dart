// ignore_for_file: avoid_print, deprecated_member_use
// D4rt deep visual demo: the "scrolling pill" pattern — a `ValueListenableBuilder<bool>`
// driven by a `bool`-typed `ValueNotifier`/`ValueListenable`, conceptually backed by
// `ScrollController.position.isScrollingNotifier`.
//
// In a live app, the source would be a real `ScrollPosition.isScrollingNotifier`
// (a `ValueListenable<bool>` that toggles true at the start of any drag / fling /
// programmatic scroll and back to false when the position settles). For a
// completely static, one-shot d4rt render we substitute hand-built
// `ValueNotifier<bool>` sources at known, fixed states (`true` / `false`). That
// is the entire point of this poster: showing how the same builder renders
// across the two possible inputs, in many visual guises.
//
// The file is intentionally a "deep" demo — many sections, painters, palettes
// and styled cards. It must compile cleanly under the d4rt analyzer-free
// interpreter and produce a tall, scrollable poster. There is no mutation, no
// timers, no animation, no setState. Each pill renders exactly once with the
// value the source notifier carries at construction time.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

// ─────────────────────────────────────────────────────────────────────────
// Painter: anatomy diagram of the listener → emit → rebuild loop.
// ─────────────────────────────────────────────────────────────────────────
class _ListenerLoopPainter extends CustomPainter {
  _ListenerLoopPainter({
    required this.nodeFill,
    required this.nodeStroke,
    required this.edgeColor,
    required this.labelColor,
    required this.accent,
  });

  final Color nodeFill;
  final Color nodeStroke;
  final Color edgeColor;
  final Color labelColor;
  final Color accent;

  @override
  void paint(Canvas canvas, Size size) {
    final List<String> labels = <String>[
      'ScrollPosition',
      'isScrollingNotifier',
      'ValueListenableBuilder',
      'builder(context,bool,_)',
      'Element rebuild',
    ];
    final double cellWidth = size.width;
    final double rowHeight = size.height / labels.length;
    final Paint fill = Paint()..color = nodeFill;
    final Paint stroke = Paint()
      ..color = nodeStroke
      ..strokeWidth = 1.4
      ..style = PaintingStyle.stroke;
    final Paint edgePaint = Paint()
      ..color = edgeColor
      ..strokeWidth = 1.6
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < labels.length; i++) {
      final double cy = rowHeight * i + rowHeight / 2;
      final RRect node = RRect.fromRectAndRadius(
        Rect.fromLTWH(10, cy - 13, cellWidth - 20, 26),
        const Radius.circular(8),
      );
      canvas.drawRRect(node, fill);
      canvas.drawRRect(node, stroke);

      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: labels[i],
          style: TextStyle(
            color: labelColor,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      tp.layout(maxWidth: cellWidth - 30);
      tp.paint(canvas, Offset(20, cy - tp.height / 2));

      if (i < labels.length - 1) {
        canvas.drawLine(
          Offset(cellWidth / 2, cy + 13),
          Offset(cellWidth / 2, cy + rowHeight - 13),
          edgePaint,
        );
        final Path arrow = Path()
          ..moveTo(cellWidth / 2 - 5, cy + rowHeight - 18)
          ..lineTo(cellWidth / 2, cy + rowHeight - 11)
          ..lineTo(cellWidth / 2 + 5, cy + rowHeight - 18);
        canvas.drawPath(arrow, edgePaint);
      }
    }

    // Feedback loop arrow on the right: rebuild → ScrollPosition
    final Paint feedback = Paint()
      ..color = accent
      ..strokeWidth = 1.8
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final Path loop = Path()
      ..moveTo(cellWidth - 14, rowHeight * (labels.length - 1) + rowHeight / 2)
      ..lineTo(cellWidth - 4, rowHeight * (labels.length - 1) + rowHeight / 2)
      ..lineTo(cellWidth - 4, rowHeight / 2)
      ..lineTo(cellWidth - 14, rowHeight / 2);
    canvas.drawPath(loop, feedback);
    final Path feedbackArrow = Path()
      ..moveTo(cellWidth - 19, rowHeight / 2 - 5)
      ..lineTo(cellWidth - 14, rowHeight / 2)
      ..lineTo(cellWidth - 19, rowHeight / 2 + 5);
    canvas.drawPath(feedbackArrow, feedback);
  }

  @override
  bool shouldRepaint(covariant _ListenerLoopPainter old) {
    return old.nodeFill != nodeFill ||
        old.nodeStroke != nodeStroke ||
        old.edgeColor != edgeColor ||
        old.labelColor != labelColor ||
        old.accent != accent;
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Painter: ScrollPosition state machine — at rest ↔ scrolling ↔ ballistic.
// ─────────────────────────────────────────────────────────────────────────
class _ScrollStatePainter extends CustomPainter {
  _ScrollStatePainter({
    required this.idleColor,
    required this.activeColor,
    required this.edgeColor,
    required this.labelColor,
  });

  final Color idleColor;
  final Color activeColor;
  final Color edgeColor;
  final Color labelColor;

  void _drawState(
    Canvas canvas,
    Offset center,
    String label,
    Color fill,
    Color stroke,
  ) {
    final Paint p = Paint()..color = fill;
    final Paint s = Paint()
      ..color = stroke
      ..strokeWidth = 1.6
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(center, 30, p);
    canvas.drawCircle(center, 30, s);

    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: label,
        style: TextStyle(
          color: labelColor,
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    tp.layout(maxWidth: 70);
    tp.paint(canvas, Offset(center.dx - tp.width / 2, center.dy - tp.height / 2));
  }

  void _drawArrow(Canvas canvas, Offset from, Offset to, String label) {
    final Paint edgePaint = Paint()
      ..color = edgeColor
      ..strokeWidth = 1.4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(from, to, edgePaint);
    final double angle = math.atan2(to.dy - from.dy, to.dx - from.dx);
    final double ah = 6.0;
    final Path arrow = Path()
      ..moveTo(to.dx - ah * math.cos(angle - math.pi / 6),
          to.dy - ah * math.sin(angle - math.pi / 6))
      ..lineTo(to.dx, to.dy)
      ..lineTo(to.dx - ah * math.cos(angle + math.pi / 6),
          to.dy - ah * math.sin(angle + math.pi / 6));
    canvas.drawPath(arrow, edgePaint);

    final Offset mid = Offset((from.dx + to.dx) / 2, (from.dy + to.dy) / 2 - 8);
    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: label,
        style: TextStyle(
          color: labelColor,
          fontSize: 10,
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.italic,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    tp.paint(canvas, Offset(mid.dx - tp.width / 2, mid.dy - tp.height / 2));
  }

  @override
  void paint(Canvas canvas, Size size) {
    final Offset idle = Offset(size.width * 0.18, size.height * 0.55);
    final Offset drag = Offset(size.width * 0.5, size.height * 0.22);
    final Offset ballistic = Offset(size.width * 0.82, size.height * 0.55);

    _drawState(canvas, idle, 'idle\nfalse', idleColor, edgeColor);
    _drawState(canvas, drag, 'drag\ntrue', activeColor, edgeColor);
    _drawState(canvas, ballistic, 'fling\ntrue', activeColor, edgeColor);

    _drawArrow(canvas, idle + const Offset(28, -10),
        drag + const Offset(-28, 10), 'beginDrag');
    _drawArrow(canvas, drag + const Offset(28, 10),
        ballistic + const Offset(-28, -10), 'endDrag');
    _drawArrow(canvas, ballistic + const Offset(-20, 20),
        idle + const Offset(20, 20), 'settle');
  }

  @override
  bool shouldRepaint(covariant _ScrollStatePainter old) {
    return old.idleColor != idleColor ||
        old.activeColor != activeColor ||
        old.edgeColor != edgeColor ||
        old.labelColor != labelColor;
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Painter: pulsing sonar — a static, single-frame "scanning" graphic for
// the pill in the "active" state. No animation; we just paint three rings
// at increasing radii with decreasing alpha.
// ─────────────────────────────────────────────────────────────────────────
class _SonarPainter extends CustomPainter {
  _SonarPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double maxR = math.min(size.width, size.height) / 2 - 1;
    for (int i = 0; i < 3; i++) {
      final double r = maxR * (0.4 + 0.3 * i);
      final Paint p = Paint()
        ..color = color.withValues(alpha: 0.65 - 0.18 * i)
        ..strokeWidth = 1.4
        ..style = PaintingStyle.stroke;
      canvas.drawCircle(center, r, p);
    }
    final Paint dot = Paint()..color = color;
    canvas.drawCircle(center, 3.5, dot);
  }

  @override
  bool shouldRepaint(covariant _SonarPainter old) => old.color != color;
}

// ─────────────────────────────────────────────────────────────────────────
// Top-level harness called once by the d4rt test app.
// ─────────────────────────────────────────────────────────────────────────
dynamic build(BuildContext context) {
  // ── Palette: teal / indigo / amber on a paper backdrop ──
  const Color teal = Color(0xFF0D9488);
  const Color tealDeep = Color(0xFF134E4A);
  const Color tealLight = Color(0xFFCCFBF1);
  const Color indigo = Color(0xFF4F46E5);
  const Color indigoDeep = Color(0xFF312E81);
  const Color indigoLight = Color(0xFFE0E7FF);
  const Color amber = Color(0xFFF59E0B);
  const Color amberDeep = Color(0xFF92400E);
  const Color amberLight = Color(0xFFFEF3C7);
  const Color rose = Color(0xFFE11D48);
  const Color slate = Color(0xFF334155);
  const Color slateDeep = Color(0xFF0F172A);
  const Color slateLight = Color(0xFFE2E8F0);
  const Color paper = Color(0xFFF8FAFC);

  print('===== SCROLLING PILL DEEP VISUAL DEMO =====');

  // ── Mock sources: `ValueNotifier<bool>` at fixed states ──
  // In a real app these would be `controller.position.isScrollingNotifier`
  // (a `ValueListenable<bool>` exposed by the active `ScrollPosition`).
  // For a static one-shot render we own them directly.
  final ValueNotifier<bool> idleNotifier = ValueNotifier<bool>(false);
  final ValueNotifier<bool> activeNotifier = ValueNotifier<bool>(true);
  final ValueNotifier<bool> headerNotifier = ValueNotifier<bool>(true);
  final ValueNotifier<bool> footerNotifier = ValueNotifier<bool>(false);
  final ValueNotifier<bool> sidebarNotifier = ValueNotifier<bool>(true);

  print('idle.value = ${idleNotifier.value}');
  print('active.value = ${activeNotifier.value}');
  print('header.value = ${headerNotifier.value}');
  print('footer.value = ${footerNotifier.value}');
  print('sidebar.value = ${sidebarNotifier.value}');

  // ── Local widget helpers ─────────────────────────────────────────────

  Widget sectionBanner(String number, String title, List<Color> gradient) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 28, bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: gradient.first.withValues(alpha: 0.45),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
          BoxShadow(
            color: slateDeep.withValues(alpha: 0.18),
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.22),
              borderRadius: BorderRadius.circular(19),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.55),
                width: 1.4,
              ),
            ),
            child: Center(
              child: Text(
                number,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget proseBox(String text, {Color? bg, Color? border}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: bg ?? Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: border ?? slateLight),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: slateDeep.withValues(alpha: 0.06),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 13,
          height: 1.55,
          color: slateDeep.withValues(alpha: 0.92),
        ),
      ),
    );
  }

  Widget infoCard(String heading, Widget content,
      {List<Color>? headerGradient, Color? bodyColor}) {
    final List<Color> gradient =
        headerGradient ?? <Color>[tealDeep, teal];
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: bodyColor ?? Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: slateLight),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: slateDeep.withValues(alpha: 0.07),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
          BoxShadow(
            color: gradient.first.withValues(alpha: 0.10),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: gradient,
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(9)),
            ),
            child: Text(
              heading,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.2,
              ),
            ),
          ),
          Padding(padding: const EdgeInsets.all(14), child: content),
        ],
      ),
    );
  }

  Widget dataRow(String label, String value, {Color? labelColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 180,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: labelColor ?? slateDeep,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 12, color: slate),
            ),
          ),
        ],
      ),
    );
  }

  Widget chipTag(String label, Color bg, Color fg) {
    return Container(
      margin: const EdgeInsets.only(right: 6, bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(14),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: bg.withValues(alpha: 0.30),
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: fg,
        ),
      ),
    );
  }

  Widget codeSnippetCard(String title, String code, {Color? accent}) {
    final Color a = accent ?? teal;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: slateDeep,
        borderRadius: BorderRadius.circular(10),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: slateDeep.withValues(alpha: 0.35),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: a.withValues(alpha: 0.18),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
            decoration: BoxDecoration(
              color: a.withValues(alpha: 0.20),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(9)),
            ),
            child: Row(
              children: <Widget>[
                Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFB7185),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFCD34D),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Color(0xFF34D399),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.85),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Text(
              code,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.92),
                fontSize: 12,
                height: 1.5,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Pill variants — each driven by a ValueListenableBuilder<bool> ────

  // Variant A: the classic pill (rounded rectangle, color shift on active).
  Widget classicPill(ValueListenable<bool> source) {
    return ValueListenableBuilder<bool>(
      valueListenable: source,
      builder: (BuildContext c, bool isScrolling, Widget? _) {
        final Color bg = isScrolling ? teal : slateLight;
        final Color fg = isScrolling ? Colors.white : slate;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(999),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: bg.withValues(alpha: 0.35),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: fg,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                isScrolling ? 'scrolling' : 'at rest',
                style: TextStyle(
                  color: fg,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Variant B: a flat badge (square corners, monospace label).
  Widget badgePill(ValueListenable<bool> source) {
    return ValueListenableBuilder<bool>(
      valueListenable: source,
      builder: (BuildContext c, bool isScrolling, Widget? _) {
        final Color bg = isScrolling ? indigo : indigoLight;
        final Color fg = isScrolling ? Colors.white : indigoDeep;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(3),
            border: Border.all(color: indigoDeep.withValues(alpha: 0.4)),
          ),
          child: Text(
            isScrolling ? 'SCROLLING' : 'IDLE',
            style: TextStyle(
              color: fg,
              fontSize: 10,
              fontWeight: FontWeight.w800,
              fontFamily: 'monospace',
              letterSpacing: 0.8,
            ),
          ),
        );
      },
    );
  }

  // Variant C: a ribbon (left-pointing arrow tip).
  Widget ribbonPill(ValueListenable<bool> source) {
    return ValueListenableBuilder<bool>(
      valueListenable: source,
      builder: (BuildContext c, bool isScrolling, Widget? _) {
        final Color bg = isScrolling ? amber : amberLight;
        final Color fg = isScrolling ? Colors.white : amberDeep;
        return ClipPath(
          clipper: const _RibbonClipper(),
          child: Container(
            padding: const EdgeInsets.fromLTRB(22, 6, 12, 6),
            color: bg,
            child: Text(
              isScrolling ? 'in motion' : 'still',
              style: TextStyle(
                color: fg,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        );
      },
    );
  }

  // Variant D: a banner card (full-width, gradient, large text).
  Widget bannerPill(ValueListenable<bool> source) {
    return ValueListenableBuilder<bool>(
      valueListenable: source,
      builder: (BuildContext c, bool isScrolling, Widget? _) {
        final List<Color> gradient = isScrolling
            ? <Color>[teal, indigo]
            : <Color>[slateLight, paper];
        final Color fg = isScrolling ? Colors.white : slateDeep;
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: gradient,
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(10),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: gradient.first.withValues(alpha: 0.30),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: <Widget>[
              Icon(
                isScrolling ? Icons.swap_vert : Icons.pause_circle_outline,
                color: fg,
                size: 22,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      isScrolling ? 'Scroll in progress' : 'Position settled',
                      style: TextStyle(
                        color: fg,
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      isScrolling
                          ? 'isScrollingNotifier.value == true'
                          : 'isScrollingNotifier.value == false',
                      style: TextStyle(
                        color: fg.withValues(alpha: 0.85),
                        fontSize: 11,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Variant E: an icon-only chip (no text, just a colored circle + glyph).
  Widget iconChipPill(ValueListenable<bool> source) {
    return ValueListenableBuilder<bool>(
      valueListenable: source,
      builder: (BuildContext c, bool isScrolling, Widget? _) {
        final Color bg = isScrolling ? rose : slateLight;
        return Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: bg,
            shape: BoxShape.circle,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: bg.withValues(alpha: 0.4),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(
            isScrolling ? Icons.expand_more : Icons.do_not_disturb_on_outlined,
            color: Colors.white,
            size: 20,
          ),
        );
      },
    );
  }

  // Variant F: a sonar pill — combines a CustomPainter "sonar" with a label.
  Widget sonarPill(ValueListenable<bool> source) {
    return ValueListenableBuilder<bool>(
      valueListenable: source,
      builder: (BuildContext c, bool isScrolling, Widget? _) {
        final Color accent = isScrolling ? teal : slate;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: accent.withValues(alpha: 0.5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: accent.withValues(alpha: 0.18),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                width: 22,
                height: 22,
                child: isScrolling
                    ? CustomPaint(painter: _SonarPainter(color: accent))
                    : Center(
                        child: Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: accent,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
              ),
              const SizedBox(width: 8),
              Text(
                isScrolling ? 'tracking' : 'parked',
                style: TextStyle(
                  color: accent,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Variant G: a vertical pill stack (icon over label).
  Widget stackedPill(ValueListenable<bool> source) {
    return ValueListenableBuilder<bool>(
      valueListenable: source,
      builder: (BuildContext c, bool isScrolling, Widget? _) {
        final Color bg = isScrolling ? tealLight : paper;
        final Color fg = isScrolling ? tealDeep : slate;
        return Container(
          width: 80,
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: fg.withValues(alpha: 0.3)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                isScrolling ? Icons.timeline : Icons.bedtime_outlined,
                color: fg,
                size: 22,
              ),
              const SizedBox(height: 4),
              Text(
                isScrolling ? 'live' : 'rest',
                style: TextStyle(
                  color: fg,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Variant H: a left-bordered status strip (no rounding on the left edge).
  Widget stripPill(ValueListenable<bool> source) {
    return ValueListenableBuilder<bool>(
      valueListenable: source,
      builder: (BuildContext c, bool isScrolling, Widget? _) {
        final Color accent = isScrolling ? indigo : slate;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              left: BorderSide(color: accent, width: 4),
              top: BorderSide(color: slateLight),
              right: BorderSide(color: slateLight),
              bottom: BorderSide(color: slateLight),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                isScrolling ? '▸ scrolling' : '■ at rest',
                style: TextStyle(
                  color: accent,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ── Section 1: hero intro ────────────────────────────────────────────
  final Widget heroSection = Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[tealDeep, indigoDeep],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: tealDeep.withValues(alpha: 0.5),
          blurRadius: 16,
          offset: const Offset(0, 8),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'The Scrolling Pill',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.6,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'A study in ValueListenableBuilder<bool> + ScrollPosition.isScrollingNotifier',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.85),
            fontSize: 13,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: <Widget>[
            classicPill(activeNotifier),
            const SizedBox(width: 10),
            classicPill(idleNotifier),
            const SizedBox(width: 10),
            sonarPill(activeNotifier),
          ],
        ),
      ],
    ),
  );

  // ── Section 2: anatomy — listener loop diagram ───────────────────────
  final Widget anatomyDiagram = SizedBox(
    height: 280,
    child: CustomPaint(
      painter: _ListenerLoopPainter(
        nodeFill: tealLight,
        nodeStroke: tealDeep,
        edgeColor: slate,
        labelColor: slateDeep,
        accent: rose,
      ),
    ),
  );

  // ── Section 3: variants gallery — 2×4 grid of pill styles ─────────────
  Widget galleryCell(String label, Widget child) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: slateLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              color: slate,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: <Widget>[
              child,
            ],
          ),
        ],
      ),
    );
  }

  // ── Section 4: scroll-state machine diagram ──────────────────────────
  final Widget stateMachineDiagram = SizedBox(
    height: 200,
    child: CustomPaint(
      painter: _ScrollStatePainter(
        idleColor: slateLight,
        activeColor: tealLight,
        edgeColor: slate,
        labelColor: slateDeep,
      ),
    ),
  );

  // ── Section 5: mock scroll-state gallery (both states side by side) ───
  Widget statePairRow(String name, Widget activeChild, Widget idleChild) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: paper,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: slateLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            name,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: slateDeep,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'value == true',
                      style: TextStyle(
                        fontSize: 10,
                        color: teal,
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    activeChild,
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'value == false',
                      style: TextStyle(
                        fontSize: 10,
                        color: rose,
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    idleChild,
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Section 6: lifecycle table ───────────────────────────────────────
  Widget lifecycleStep(int n, String when, String what) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 24,
            height: 24,
            margin: const EdgeInsets.only(right: 10, top: 1),
            decoration: BoxDecoration(
              color: tealDeep,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$n',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  when,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: slateDeep,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  what,
                  style: const TextStyle(
                    fontSize: 12,
                    color: slate,
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

  // ── Section 7: pitfall cards ─────────────────────────────────────────
  Widget pitfallCard(String title, String body, Color accent) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border(
          left: BorderSide(color: accent, width: 4),
          top: const BorderSide(color: slateLight),
          right: const BorderSide(color: slateLight),
          bottom: const BorderSide(color: slateLight),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.warning_amber_rounded, color: accent, size: 18),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: accent,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            body,
            style: const TextStyle(
              fontSize: 12,
              color: slate,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  // ── Compose the full poster ──────────────────────────────────────────
  final Widget content = Padding(
    padding: const EdgeInsets.fromLTRB(16, 18, 16, 36),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        heroSection,

        // ── Section 1: What is the pattern? ──
        sectionBanner(
          '1',
          'What is the scrolling-pill pattern?',
          const <Color>[tealDeep, teal],
        ),
        proseBox(
          'A "scrolling pill" is a tiny indicator widget that listens to a '
          'ValueListenable<bool> and re-renders whenever its boolean value '
          'flips. In a real Flutter app the source is '
          'ScrollController.position.isScrollingNotifier — a ValueListenable<bool> '
          'exposed by every ScrollPosition. It reads `true` while the user is '
          'dragging, while a fling is decelerating, or while a programmatic '
          'animateTo is in flight; and `false` whenever the position is settled '
          'and no activity is running.',
        ),
        proseBox(
          'The receiving widget is a ValueListenableBuilder<bool>. Its builder '
          'is called once on mount and again every time the notifier emits — '
          'subscribed via the Listenable.addListener contract, with the '
          'subscription torn down automatically when the element is unmounted. '
          'No setState. No StatefulWidget needed in the caller. The pill '
          'behaves as a pure, reactive function of the notifier value.',
          bg: indigoLight,
          border: indigo,
        ),
        infoCard(
          'Source surface',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              dataRow('Class', 'ScrollPosition (in package:flutter/widgets)'),
              dataRow('Getter', 'isScrollingNotifier'),
              dataRow('Return type', 'ValueListenable<bool>'),
              dataRow('True when', 'drag / fling / animateTo active'),
              dataRow('False when', 'position settled, no activity'),
              dataRow('Lifecycle', 'tied to ScrollPosition (recycled on attach)'),
            ],
          ),
        ),
        Wrap(
          children: <Widget>[
            chipTag('ValueListenable', tealLight, tealDeep),
            chipTag('bool', amberLight, amberDeep),
            chipTag('ScrollPosition', indigoLight, indigoDeep),
            chipTag('isScrollingNotifier', tealLight, tealDeep),
            chipTag('rebuild on emit', amberLight, amberDeep),
            chipTag('no setState', indigoLight, indigoDeep),
          ],
        ),

        // ── Section 2: Anatomy of the loop ──
        sectionBanner(
          '2',
          'Anatomy: listener → emit → rebuild',
          const <Color>[indigoDeep, indigo],
        ),
        proseBox(
          'The data flow is a five-node chain. The ScrollPosition owns an '
          'internal ValueNotifier<bool> exposed as isScrollingNotifier. Each '
          'time the position starts or stops an activity, the notifier '
          'invokes its registered listeners. The ValueListenableBuilder is '
          'such a listener; on emit it calls setState on its internal element '
          'and re-runs the builder closure with the new value. The closure '
          'returns the pill widget tree; Flutter reconciles it against the '
          'previous frame and paints the difference.',
        ),
        infoCard(
          'Listener loop',
          anatomyDiagram,
          headerGradient: const <Color>[indigoDeep, indigo],
        ),
        codeSnippetCard(
          'minimal_pill.dart',
          'ValueListenableBuilder<bool>(\n'
              '  valueListenable: controller.position.isScrollingNotifier,\n'
              '  builder: (BuildContext c, bool isScrolling, Widget? _) {\n'
              '    return Text(isScrolling ? "scrolling" : "at rest");\n'
              '  },\n'
              ');',
          accent: teal,
        ),
        proseBox(
          'Notice the trailing `child` parameter (named `_` above) — it is an '
          'optimisation slot for subtrees that do NOT depend on the boolean. '
          'Pass them through the outer `child:` argument and Flutter will '
          'reuse the same Widget instance across rebuilds, saving allocation '
          'and reconciliation cost for any heavy child.',
        ),

        // ── Section 3: Pill variants gallery ──
        sectionBanner(
          '3',
          'A gallery of pill shapes',
          const <Color>[teal, indigo],
        ),
        proseBox(
          'The same ValueListenableBuilder<bool> can render any visual '
          'shape. Below: eight distinct pill styles, each receiving the '
          'same family of mock notifiers. Each builder reads `isScrolling` '
          'and emits one of two pre-built subtrees — classic chip, flat '
          'badge, ribbon, banner, icon-chip, sonar, stacked tile, left strip.',
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: galleryCell('Classic (active)', classicPill(activeNotifier))),
            const SizedBox(width: 10),
            Expanded(child: galleryCell('Classic (idle)', classicPill(idleNotifier))),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: galleryCell('Badge (active)', badgePill(activeNotifier))),
            const SizedBox(width: 10),
            Expanded(child: galleryCell('Badge (idle)', badgePill(idleNotifier))),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: galleryCell('Ribbon (active)', ribbonPill(activeNotifier))),
            const SizedBox(width: 10),
            Expanded(child: galleryCell('Ribbon (idle)', ribbonPill(idleNotifier))),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: galleryCell('Icon-chip (active)', iconChipPill(activeNotifier))),
            const SizedBox(width: 10),
            Expanded(child: galleryCell('Icon-chip (idle)', iconChipPill(idleNotifier))),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: galleryCell('Sonar (active)', sonarPill(activeNotifier))),
            const SizedBox(width: 10),
            Expanded(child: galleryCell('Sonar (idle)', sonarPill(idleNotifier))),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: galleryCell('Stacked (active)', stackedPill(activeNotifier))),
            const SizedBox(width: 10),
            Expanded(child: galleryCell('Stacked (idle)', stackedPill(idleNotifier))),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: galleryCell('Strip (active)', stripPill(activeNotifier))),
            const SizedBox(width: 10),
            Expanded(child: galleryCell('Strip (idle)', stripPill(idleNotifier))),
          ],
        ),
        const SizedBox(height: 14),
        // Full-width banner pair
        bannerPill(activeNotifier),
        const SizedBox(height: 8),
        bannerPill(idleNotifier),

        // ── Section 4: State machine ──
        sectionBanner(
          '4',
          'When does the boolean actually flip?',
          const <Color>[amberDeep, amber],
        ),
        proseBox(
          'The notifier toggles on transitions in the ScrollPosition state '
          'machine. The simplified diagram below shows the three relevant '
          'states. `idle` reports `false`. Any of `drag`, `fling`, or '
          '`programmatic` reports `true`. The notifier flips on the edge — '
          'beginActivity raises it; the activity\'s dispose lowers it.',
          bg: amberLight,
          border: amber,
        ),
        infoCard(
          'ScrollPosition state machine (simplified)',
          stateMachineDiagram,
          headerGradient: const <Color>[amberDeep, amber],
        ),
        proseBox(
          'Edge cases worth remembering: a programmatic animateTo with a '
          'zero-duration curve will raise and lower the notifier in the same '
          'frame; a held drag (pointer down but not yet moving) reports '
          'true; and a position that is re-attached to a new viewport gets '
          'a fresh notifier instance — never cache the old one across '
          'remounts.',
        ),

        // ── Section 5: Mock state gallery ──
        sectionBanner(
          '5',
          'Side-by-side state preview',
          const <Color>[teal, tealDeep],
        ),
        proseBox(
          'The gallery below pairs each pill in both states. Because we own '
          'the source notifiers directly and they are static '
          'ValueNotifier<bool>(true) or ValueNotifier<bool>(false), every '
          'builder runs exactly once. There is no animation. The "active" '
          'column is what the user sees during a drag or fling; the "idle" '
          'column is what they see at rest.',
        ),
        statePairRow(
          'Classic chip',
          classicPill(activeNotifier),
          classicPill(idleNotifier),
        ),
        statePairRow(
          'Flat badge',
          badgePill(activeNotifier),
          badgePill(idleNotifier),
        ),
        statePairRow(
          'Ribbon',
          ribbonPill(activeNotifier),
          ribbonPill(idleNotifier),
        ),
        statePairRow(
          'Icon-only chip',
          iconChipPill(activeNotifier),
          iconChipPill(idleNotifier),
        ),
        statePairRow(
          'Sonar pill',
          sonarPill(activeNotifier),
          sonarPill(idleNotifier),
        ),
        statePairRow(
          'Stacked tile',
          stackedPill(activeNotifier),
          stackedPill(idleNotifier),
        ),
        statePairRow(
          'Left strip',
          stripPill(activeNotifier),
          stripPill(idleNotifier),
        ),

        // ── Section 6: Lifecycle steps ──
        sectionBanner(
          '6',
          'Lifecycle: from mount to dispose',
          const <Color>[indigoDeep, indigo],
        ),
        proseBox(
          'A live scrolling pill wires up to a real ScrollController. The '
          'six steps below trace the full path from widget mount to '
          'tear-down. Most production bugs in this area come from skipping '
          'step 1 (the `hasClients` guard) or step 5 (subscribing once but '
          'forgetting to re-subscribe after the ScrollPosition is replaced).',
        ),
        infoCard(
          'Lifecycle path',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              lifecycleStep(
                1,
                'Element mounts',
                'The pill widget builds for the first time. If the source '
                    'is `controller.position.isScrollingNotifier`, you must '
                    'first guard with `controller.hasClients` — the '
                    'position is only created after a Scrollable is laid '
                    'out below the controller.',
              ),
              lifecycleStep(
                2,
                'ValueListenableBuilder subscribes',
                'In its `initState`, the builder calls '
                    '`valueListenable.addListener(_listener)`. The listener '
                    'reads the current value and triggers an internal '
                    'setState.',
              ),
              lifecycleStep(
                3,
                'Initial render',
                'The build closure runs once with the current value. For '
                    'an unscrolled list, that value is `false` (at rest).',
              ),
              lifecycleStep(
                4,
                'Activity starts',
                'On the first drag/fling, ScrollPosition.beginActivity '
                    'updates the notifier to `true`. Listeners fire; the '
                    'pill rebuilds; the user sees "scrolling".',
              ),
              lifecycleStep(
                5,
                'Position replacement',
                'If the Scrollable\'s axis changes or the controller is '
                    'detached and reattached, the old position\'s notifier '
                    'is discarded. A correctly written pill re-reads '
                    'controller.position.isScrollingNotifier on every build '
                    'and lets the builder handle resubscription.',
              ),
              lifecycleStep(
                6,
                'Element unmounts',
                'The builder\'s `dispose` calls '
                    '`valueListenable.removeListener(_listener)`. No leak. '
                    'The notifier itself outlives the pill (it belongs to '
                    'the ScrollPosition).',
              ),
            ],
          ),
        ),

        // ── Section 7: Pitfalls ──
        sectionBanner(
          '7',
          'Pitfalls and footguns',
          const <Color>[Color(0xFFB91C1C), rose],
        ),
        proseBox(
          'The pill pattern is small but surprisingly easy to get wrong. The '
          'four cards below cover the highest-traffic mistakes — every one '
          'has been seen multiple times in production code.',
        ),
        pitfallCard(
          'No clients yet',
          'On the first build, `controller.position` throws if no '
              'Scrollable has registered with the controller. Always guard '
              'with `if (!controller.hasClients) return placeholder;` and '
              'render a static "idle"-shaped widget until the position is '
              'live. The example file you started from does this correctly.',
          rose,
        ),
        pitfallCard(
          'ValueListenable type variance',
          'The builder takes a `ValueListenable<T>`, not a `ValueNotifier<T>`. '
              'Passing the notifier itself works (it implements the listenable '
              'interface) but the type parameter must be `bool`. Writing '
              'ValueListenableBuilder<Object>(...) compiles and silently '
              'breaks pattern matching inside the builder.',
          amberDeep,
        ),
        pitfallCard(
          'Dispose ordering',
          'If you wrap the pill in a StatefulWidget that also owns the '
              'ScrollController, dispose the controller AFTER the pill is '
              'unmounted — otherwise the builder\'s removeListener call '
              'will see a disposed position. The framework will throw '
              '"used after being disposed" in debug.',
          indigoDeep,
        ),
        pitfallCard(
          'Capturing position in a constant',
          'Do NOT capture `controller.position.isScrollingNotifier` once in '
              'a top-level final and pass it down. When the Scrollable '
              'rebuilds with a new axis or owner, the position object is '
              'replaced and your cached notifier is now orphaned. Always '
              'read it inside `build`.',
          tealDeep,
        ),

        // ── Section 8: Comparative code ──
        sectionBanner(
          '8',
          'Two flavours of the same pattern',
          const <Color>[tealDeep, teal],
        ),
        proseBox(
          'The bare-minimum pill (left) and a more defensive variant '
          '(right) differ only in the `hasClients` guard. Both compile '
          'to the same render-tree at steady state; only the first frame '
          'and any controller-detach moment differ in behaviour.',
        ),
        codeSnippetCard(
          'naive_pill.dart',
          'class _Pill extends StatelessWidget {\n'
              '  const _Pill({required this.c});\n'
              '  final ScrollController c;\n'
              '  @override\n'
              '  Widget build(BuildContext ctx) {\n'
              '    return ValueListenableBuilder<bool>(\n'
              '      valueListenable: c.position.isScrollingNotifier,\n'
              '      builder: (_, bool s, __) =>\n'
              '          Text(s ? "scrolling" : "at rest"),\n'
              '    );\n'
              '  }\n'
              '}',
          accent: rose,
        ),
        codeSnippetCard(
          'safe_pill.dart',
          'class _Pill extends StatelessWidget {\n'
              '  const _Pill({required this.c});\n'
              '  final ScrollController c;\n'
              '  @override\n'
              '  Widget build(BuildContext ctx) {\n'
              '    if (!c.hasClients) return const Text("idle");\n'
              '    return ValueListenableBuilder<bool>(\n'
              '      valueListenable: c.position.isScrollingNotifier,\n'
              '      builder: (_, bool s, __) =>\n'
              '          Text(s ? "scrolling" : "at rest"),\n'
              '    );\n'
              '  }\n'
              '}',
          accent: teal,
        ),
        codeSnippetCard(
          'with_child_optimisation.dart',
          'ValueListenableBuilder<bool>(\n'
              '  valueListenable: c.position.isScrollingNotifier,\n'
              '  child: const _HeavySubtree(),     // built ONCE\n'
              '  builder: (_, bool s, Widget? child) {\n'
              '    return Opacity(\n'
              '      opacity: s ? 1.0 : 0.4,\n'
              '      child: child,                // reused every emit\n'
              '    );\n'
              '  },\n'
              ');',
          accent: indigo,
        ),

        // ── Section 9: Concept flow chart ──
        sectionBanner(
          '9',
          'Conceptual flow: where the pill lives in your tree',
          const <Color>[indigoDeep, indigo],
        ),
        proseBox(
          'Diagram below: the controller is owned by a State, attached to '
          'one or more Scrollables, and read by zero or more pills. The '
          'pills do not directly reference the Scrollable — they only see '
          'the controller. This is what makes the pattern so portable.',
        ),
        infoCard(
          'Ownership graph',
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: indigoLight,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: indigoDeep),
                      ),
                      child: const Column(
                        children: <Widget>[
                          Text(
                            'StatefulWidget',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: indigoDeep,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            'owns ScrollController',
                            style: TextStyle(
                              color: indigoDeep,
                              fontSize: 10,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Icon(Icons.arrow_downward, color: slate, size: 18),
              const SizedBox(height: 10),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: tealLight,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: tealDeep),
                      ),
                      child: const Column(
                        children: <Widget>[
                          Text(
                            'ListView / Scrollable',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: tealDeep,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            'attaches → ScrollPosition',
                            style: TextStyle(
                              color: tealDeep,
                              fontSize: 10,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: amberLight,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: amberDeep),
                      ),
                      child: const Column(
                        children: <Widget>[
                          Text(
                            '_Pill (this file)',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: amberDeep,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            'reads isScrollingNotifier',
                            style: TextStyle(
                              color: amberDeep,
                              fontSize: 10,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          headerGradient: const <Color>[indigoDeep, indigo],
        ),

        // ── Section 10: Mounting points — header / footer / sidebar ──
        sectionBanner(
          '10',
          'Where pills go in the layout',
          const <Color>[tealDeep, teal],
        ),
        proseBox(
          'Pills can live above a scrollable (as a status header), inside '
          'a sticky footer, in a sidebar next to a horizontally-scrolling '
          'gallery, or anywhere else in the tree. They do not need to be '
          'siblings of the Scrollable — only descendants of the same '
          'controller-owner. The three layouts below mock each placement.',
        ),
        // Mock header: pill above a fake list region
        infoCard(
          'Header pill above a list',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  bannerPill(headerNotifier),
                ],
              ),
              const SizedBox(height: 8),
              Container(
                height: 80,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: paper,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: slateLight),
                ),
                child: const Center(
                  child: Text(
                    'mocked ListView region',
                    style: TextStyle(
                      color: slate,
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),
            ],
          ),
          headerGradient: const <Color>[tealDeep, teal],
        ),
        // Mock footer: small pill anchored at bottom of fake region
        infoCard(
          'Sticky footer pill',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 80,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: paper,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: slateLight),
                ),
                child: const Center(
                  child: Text(
                    'mocked ListView region',
                    style: TextStyle(
                      color: slate,
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: <Widget>[
                  classicPill(footerNotifier),
                  const SizedBox(width: 10),
                  iconChipPill(footerNotifier),
                ],
              ),
            ],
          ),
          headerGradient: const <Color>[indigoDeep, indigo],
        ),
        // Mock sidebar: pill column next to fake horizontal gallery
        infoCard(
          'Sidebar pill next to a horizontal scroll',
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                children: <Widget>[
                  stackedPill(sidebarNotifier),
                  const SizedBox(height: 8),
                  stripPill(sidebarNotifier),
                ],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: paper,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: slateLight),
                  ),
                  child: const Center(
                    child: Text(
                      'mocked horizontal gallery',
                      style: TextStyle(
                        color: slate,
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          headerGradient: const <Color>[amberDeep, amber],
        ),

        // ── Section 11: Summary card ──
        sectionBanner(
          '11',
          'Takeaways',
          const <Color>[tealDeep, indigoDeep],
        ),
        infoCard(
          'Cheat-sheet',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              dataRow('Pattern', 'ValueListenableBuilder<bool>'),
              dataRow('Real source', 'ScrollPosition.isScrollingNotifier'),
              dataRow('Mock source', 'ValueNotifier<bool>(true|false)'),
              dataRow('Required guard', 'controller.hasClients before .position'),
              dataRow('Builder param 1', 'BuildContext'),
              dataRow('Builder param 2', 'bool isScrolling'),
              dataRow('Builder param 3', 'Widget? child (optimisation)'),
              dataRow('Rebuild trigger', 'notifier value change'),
              dataRow('Setup cost', 'one addListener at mount'),
              dataRow('Teardown cost', 'one removeListener at unmount'),
              dataRow('Animation needed', 'no'),
              dataRow('State class needed', 'no — Stateless is enough'),
            ],
          ),
          headerGradient: const <Color>[tealDeep, indigoDeep],
        ),
        proseBox(
          'This deep demo renders entirely from static `ValueNotifier<bool>` '
          'sources — five notifiers in total, each at a fixed value of '
          '`true` or `false`. No timers, no animation controllers, no '
          'setState. The pills you see are the exact widgets the original '
          '94-line repro builds at runtime against a live '
          '`controller.position.isScrollingNotifier`. The only difference '
          'is the source — and that\'s precisely what makes '
          '`ValueListenableBuilder<bool>` such a clean abstraction.',
          bg: tealLight,
          border: teal,
        ),
      ],
    ),
  );

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: paper,
      body: SafeArea(
        child: SingleChildScrollView(
          child: content,
        ),
      ),
    ),
  );
}

// ─────────────────────────────────────────────────────────────────────────
// Custom clipper for the ribbon-style pill variant.
// ─────────────────────────────────────────────────────────────────────────
class _RibbonClipper extends CustomClipper<Path> {
  const _RibbonClipper();

  @override
  Path getClip(Size size) {
    final Path p = Path()
      ..moveTo(10, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(10, size.height)
      ..lineTo(0, size.height / 2)
      ..close();
    return p;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
