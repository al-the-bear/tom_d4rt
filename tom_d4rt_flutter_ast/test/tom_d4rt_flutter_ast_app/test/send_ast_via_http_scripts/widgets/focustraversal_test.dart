// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unused_element
// D4rt deep visual demo: Focus traversal in `package:flutter/widgets.dart`.
//
// This file is a hand-authored corpus entry that exercises the focus-traversal
// surface area: `FocusTraversalPolicy`, `ReadingOrderTraversalPolicy`,
// `WidgetOrderTraversalPolicy`, `OrderedTraversalPolicy`, `NumericFocusOrder`,
// `LexicalFocusOrder`, `FocusTraversalGroup`, `FocusTraversalOrder`,
// `FocusNode`, `FocusScopeNode`, `FocusableActionDetector`, and the `Focus`
// widget. It is a fully static, scrollable poster — section banners with
// gradients, a CustomPainter that draws the focus tree, gallery cards that
// overlay traversal-order arrows on form-like layouts, tables, palette wraps
// and dark code-snippet cards.
//
// The script does NOT respond to keyboard input. Every traversal order is
// pre-computed and drawn as overlay arrows + numbered chips, so a reader can
// "see" the order that Flutter's focus engine would produce at runtime.

import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ─────────────────────────────────────────────────────────────────────────
// Painter: the focus-tree anatomy diagram.
// Draws nodes for FocusScope → FocusTraversalGroup → FocusNode leaves,
// with traversal-policy boundaries highlighted.
// ─────────────────────────────────────────────────────────────────────────
class _FocusTreePainter extends CustomPainter {
  const _FocusTreePainter({
    required this.scopeColor,
    required this.groupColor,
    required this.leafColor,
    required this.edgeColor,
    required this.labelColor,
    required this.boundaryColor,
  });

  final Color scopeColor;
  final Color groupColor;
  final Color leafColor;
  final Color edgeColor;
  final Color labelColor;
  final Color boundaryColor;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint edgePaint = Paint()
      ..color = edgeColor
      ..strokeWidth = 1.6
      ..style = PaintingStyle.stroke;
    final Paint boundaryPaint = Paint()
      ..color = boundaryColor
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    // Root: FocusScope
    final Rect scopeRect = Rect.fromLTWH(
      size.width / 2 - 90,
      8,
      180,
      34,
    );
    final RRect scopeR = RRect.fromRectAndRadius(
      scopeRect,
      const Radius.circular(8),
    );
    canvas.drawRRect(scopeR, Paint()..color = scopeColor);
    _drawLabel(canvas, 'FocusScope (root)', scopeRect, labelColor, bold: true);

    // Two FocusTraversalGroup nodes
    final Rect groupA = Rect.fromLTWH(20, 80, 150, 30);
    final Rect groupB = Rect.fromLTWH(size.width - 170, 80, 150, 30);
    canvas.drawRRect(
      RRect.fromRectAndRadius(groupA, const Radius.circular(7)),
      Paint()..color = groupColor,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(groupB, const Radius.circular(7)),
      Paint()..color = groupColor,
    );
    _drawLabel(canvas, 'Group: Reading', groupA, labelColor);
    _drawLabel(canvas, 'Group: Ordered', groupB, labelColor);

    // Connect scope to groups
    _drawTree(canvas, edgePaint, scopeRect, groupA);
    _drawTree(canvas, edgePaint, scopeRect, groupB);

    // Leaves under group A
    const int leftLeafCount = 3;
    for (int i = 0; i < leftLeafCount; i++) {
      final Rect leaf =
          Rect.fromLTWH(20.0 + i * 50.0, 150, 44, 24);
      canvas.drawRRect(
        RRect.fromRectAndRadius(leaf, const Radius.circular(6)),
        Paint()..color = leafColor,
      );
      _drawLabel(canvas, 'F${i + 1}', leaf, labelColor);
      _drawTree(canvas, edgePaint, groupA, leaf);
    }

    // Leaves under group B (numbered out of widget order)
    const List<String> rightLabels = <String>['F4#2', 'F5#1', 'F6#3'];
    for (int i = 0; i < rightLabels.length; i++) {
      final Rect leaf =
          Rect.fromLTWH(size.width - 170.0 + i * 50.0, 150, 44, 24);
      canvas.drawRRect(
        RRect.fromRectAndRadius(leaf, const Radius.circular(6)),
        Paint()..color = leafColor,
      );
      _drawLabel(canvas, rightLabels[i], leaf, labelColor);
      _drawTree(canvas, edgePaint, groupB, leaf);
    }

    // Dashed traversal-policy boundary around group B
    final Rect boundary = Rect.fromLTWH(
      size.width - 180,
      72,
      170,
      114,
    );
    _drawDashedRRect(
      canvas,
      RRect.fromRectAndRadius(boundary, const Radius.circular(10)),
      boundaryPaint,
    );

    // Title near boundary
    _drawText(
      canvas,
      'policy boundary',
      Offset(size.width - 178, 188),
      boundaryColor,
      9.5,
      true,
    );
  }

  void _drawTree(Canvas canvas, Paint paint, Rect from, Rect to) {
    final Offset start = Offset(from.center.dx, from.bottom);
    final Offset end = Offset(to.center.dx, to.top);
    final Path p = Path()
      ..moveTo(start.dx, start.dy)
      ..cubicTo(
        start.dx,
        (start.dy + end.dy) / 2,
        end.dx,
        (start.dy + end.dy) / 2,
        end.dx,
        end.dy,
      );
    canvas.drawPath(p, paint);
  }

  void _drawLabel(
    Canvas canvas,
    String text,
    Rect rect,
    Color color, {
    bool bold = false,
  }) {
    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: bold ? FontWeight.bold : FontWeight.w600,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    tp.layout(maxWidth: rect.width - 6);
    tp.paint(
      canvas,
      Offset(
        rect.center.dx - tp.width / 2,
        rect.center.dy - tp.height / 2,
      ),
    );
  }

  void _drawText(
    Canvas canvas,
    String text,
    Offset at,
    Color color,
    double size,
    bool italic,
  ) {
    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: size,
          fontStyle: italic ? FontStyle.italic : FontStyle.normal,
          fontWeight: FontWeight.w600,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    tp.paint(canvas, at);
  }

  void _drawDashedRRect(Canvas canvas, RRect rrect, Paint paint) {
    final Path path = Path()..addRRect(rrect);
    final ui.PathMetrics metrics = path.computeMetrics();
    for (final ui.PathMetric metric in metrics) {
      double distance = 0.0;
      const double dash = 5.0;
      const double gap = 3.0;
      while (distance < metric.length) {
        final double next = math.min(distance + dash, metric.length);
        canvas.drawPath(metric.extractPath(distance, next), paint);
        distance = next + gap;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _FocusTreePainter old) {
    return old.scopeColor != scopeColor ||
        old.groupColor != groupColor ||
        old.leafColor != leafColor ||
        old.edgeColor != edgeColor ||
        old.labelColor != labelColor ||
        old.boundaryColor != boundaryColor;
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Painter: overlays numbered arrows showing tab order across a list of
// rectangles in stack-coordinate space.
// ─────────────────────────────────────────────────────────────────────────
class _TraversalArrowPainter extends CustomPainter {
  const _TraversalArrowPainter({
    required this.fieldRects,
    required this.order,
    required this.arrowColor,
    required this.numberBg,
    required this.numberFg,
  });

  final List<Rect> fieldRects;
  final List<int> order;
  final Color arrowColor;
  final Color numberBg;
  final Color numberFg;
  static const Offset labelOffset = Offset(-12, -12);

  @override
  void paint(Canvas canvas, Size size) {
    if (order.length < 2) return;
    final Paint arrow = Paint()
      ..color = arrowColor
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < order.length - 1; i++) {
      final int aIdx = order[i];
      final int bIdx = order[i + 1];
      if (aIdx >= fieldRects.length || bIdx >= fieldRects.length) continue;
      final Rect a = fieldRects[aIdx];
      final Rect b = fieldRects[bIdx];
      final Offset start =
          Offset(a.center.dx, a.center.dy);
      final Offset end = Offset(b.center.dx, b.center.dy);
      final Path p = Path()
        ..moveTo(start.dx, start.dy)
        ..cubicTo(
          start.dx + (end.dx - start.dx) * 0.4,
          start.dy,
          start.dx + (end.dx - start.dx) * 0.6,
          end.dy,
          end.dx,
          end.dy,
        );
      canvas.drawPath(p, arrow);
      _drawArrowHead(canvas, arrow, start, end);
    }

    // Numbered chips at each field's top-left.
    for (int i = 0; i < order.length; i++) {
      final int idx = order[i];
      if (idx >= fieldRects.length) continue;
      final Rect rect = fieldRects[idx];
      final Offset center = Offset(
        rect.left + labelOffset.dx + 12,
        rect.top + labelOffset.dy + 12,
      );
      canvas.drawCircle(center, 11, Paint()..color = numberBg);
      canvas.drawCircle(
        center,
        11,
        Paint()
          ..color = numberFg.withValues(alpha: 0.6)
          ..strokeWidth = 1.2
          ..style = PaintingStyle.stroke,
      );
      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: '${i + 1}',
          style: TextStyle(
            color: numberFg,
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      tp.layout();
      tp.paint(
        canvas,
        Offset(center.dx - tp.width / 2, center.dy - tp.height / 2),
      );
    }
  }

  void _drawArrowHead(Canvas canvas, Paint paint, Offset from, Offset to) {
    final double angle = math.atan2(to.dy - from.dy, to.dx - from.dx);
    const double headLen = 8.0;
    final Offset h1 = Offset(
      to.dx - headLen * math.cos(angle - math.pi / 6),
      to.dy - headLen * math.sin(angle - math.pi / 6),
    );
    final Offset h2 = Offset(
      to.dx - headLen * math.cos(angle + math.pi / 6),
      to.dy - headLen * math.sin(angle + math.pi / 6),
    );
    canvas.drawLine(to, h1, paint);
    canvas.drawLine(to, h2, paint);
  }

  @override
  bool shouldRepaint(covariant _TraversalArrowPainter old) {
    return old.fieldRects != fieldRects ||
        old.order != order ||
        old.arrowColor != arrowColor;
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Painter: an LTR vs RTL reading-order comparison strip.
// ─────────────────────────────────────────────────────────────────────────
class _DirectionalityComparePainter extends CustomPainter {
  const _DirectionalityComparePainter({
    required this.cellColor,
    required this.arrowColor,
    required this.labelColor,
  });

  final Color cellColor;
  final Color arrowColor;
  final Color labelColor;

  @override
  void paint(Canvas canvas, Size size) {
    final double rowH = size.height / 2;
    // LTR row
    _drawRow(
      canvas,
      Rect.fromLTWH(0, 0, size.width, rowH),
      true,
      'LTR  →  1 2 3 4',
    );
    // RTL row
    _drawRow(
      canvas,
      Rect.fromLTWH(0, rowH, size.width, rowH),
      false,
      'RTL  ←  1 2 3 4',
    );
  }

  void _drawRow(Canvas canvas, Rect bounds, bool ltr, String title) {
    final double pad = 10;
    final double cellW = 44;
    final double gap = 8;
    final int n = 4;
    final double y = bounds.top + bounds.height / 2 - 14;

    for (int i = 0; i < n; i++) {
      final double x = ltr
          ? bounds.left + pad + i * (cellW + gap)
          : bounds.right - pad - (i + 1) * cellW - i * gap;
      final Rect cell = Rect.fromLTWH(x, y, cellW, 28);
      canvas.drawRRect(
        RRect.fromRectAndRadius(cell, const Radius.circular(5)),
        Paint()..color = cellColor,
      );
      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: '${i + 1}',
          style: TextStyle(
            color: labelColor,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      tp.layout();
      tp.paint(
        canvas,
        Offset(cell.center.dx - tp.width / 2, cell.center.dy - tp.height / 2),
      );

      if (i < n - 1) {
        final double nextX = ltr
            ? bounds.left + pad + (i + 1) * (cellW + gap)
            : bounds.right - pad - (i + 2) * cellW - (i + 1) * gap + cellW;
        final Offset a = Offset(
          ltr ? cell.right : cell.left,
          cell.center.dy,
        );
        final Offset b = Offset(
          ltr ? nextX : nextX - cellW,
          cell.center.dy,
        );
        final Paint arrow = Paint()
          ..color = arrowColor
          ..strokeWidth = 1.6
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round;
        canvas.drawLine(a, b, arrow);
        // arrowhead
        final double dir = ltr ? 1 : -1;
        canvas.drawLine(
          b,
          Offset(b.dx - 4 * dir, b.dy - 3),
          arrow,
        );
        canvas.drawLine(
          b,
          Offset(b.dx - 4 * dir, b.dy + 3),
          arrow,
        );
      }
    }

    final TextPainter ttl = TextPainter(
      text: TextSpan(
        text: title,
        style: TextStyle(
          color: labelColor,
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.3,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    ttl.layout();
    ttl.paint(canvas, Offset(bounds.left + 6, bounds.top + 4));
  }

  @override
  bool shouldRepaint(covariant _DirectionalityComparePainter old) {
    return old.cellColor != cellColor ||
        old.arrowColor != arrowColor ||
        old.labelColor != labelColor;
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Top-level harness: MaterialApp → Scaffold → SafeArea → Scroll → Column.
// ─────────────────────────────────────────────────────────────────────────
dynamic build(BuildContext context) {
  // ─── Palette: indigo / teal / slate ───────────────────────────────────
  const Color indigo = Color(0xFF4338CA);
  const Color indigoDeep = Color(0xFF1E1B4B);
  const Color indigoLight = Color(0xFFE0E7FF);
  const Color teal = Color(0xFF0D9488);
  const Color tealDeep = Color(0xFF134E4A);
  const Color tealLight = Color(0xFFCCFBF1);
  const Color slate = Color(0xFF334155);
  const Color slateDeep = Color(0xFF0F172A);
  const Color slateLight = Color(0xFFE2E8F0);
  const Color paper = Color(0xFFF8FAFC);
  const Color amber = Color(0xFFD97706);
  const Color amberLight = Color(0xFFFEF3C7);
  const Color rose = Color(0xFFE11D48);
  const Color roseLight = Color(0xFFFFE4E6);
  const Color sky = Color(0xFF0EA5E9);

  print('===== FOCUS TRAVERSAL DEEP VISUAL DEMO =====');

  // ─── Pre-built FocusNodes / FocusScopeNodes (constructed, not driven) ──
  final FocusScopeNode rootScope = FocusScopeNode(debugLabel: 'rootScope');
  final FocusScopeNode formScope = FocusScopeNode(debugLabel: 'formScope');
  final FocusNode aNode = FocusNode(debugLabel: 'fieldA');
  final FocusNode bNode = FocusNode(debugLabel: 'fieldB');
  final FocusNode cNode = FocusNode(debugLabel: 'fieldC');
  final FocusNode dNode = FocusNode(debugLabel: 'fieldD');
  print('rootScope: ${rootScope.debugLabel}');
  print('formScope: ${formScope.debugLabel}');
  print('aNode canRequestFocus: ${aNode.canRequestFocus}');
  print('aNode.skipTraversal: ${aNode.skipTraversal}');
  print('FocusManager.instance present: '
      '${FocusManager.instance.runtimeType}');

  // ─── Policies ────────────────────────────────────────────────────────
  final ReadingOrderTraversalPolicy readingPolicy =
      ReadingOrderTraversalPolicy();
  final WidgetOrderTraversalPolicy widgetPolicy =
      WidgetOrderTraversalPolicy();
  final OrderedTraversalPolicy orderedPolicy = OrderedTraversalPolicy();
  print('readingPolicy: ${readingPolicy.runtimeType}');
  print('widgetPolicy: ${widgetPolicy.runtimeType}');
  print('orderedPolicy: ${orderedPolicy.runtimeType}');
  final NumericFocusOrder n1 = const NumericFocusOrder(1.0);
  final NumericFocusOrder n2 = const NumericFocusOrder(2.0);
  final NumericFocusOrder n3 = const NumericFocusOrder(3.0);
  final LexicalFocusOrder lAlpha = const LexicalFocusOrder('alpha');
  final LexicalFocusOrder lBeta = const LexicalFocusOrder('beta');
  final LexicalFocusOrder lGamma = const LexicalFocusOrder('gamma');
  print('NumericFocusOrder(1).order: ${n1.order}');
  print('NumericFocusOrder(2) > NumericFocusOrder(1): '
      '${n2.compareTo(n1) > 0}');
  print('LexicalFocusOrder("alpha").order: ${lAlpha.order}');
  print('LexicalFocusOrder compare alpha vs beta: '
      '${lAlpha.compareTo(lBeta)}');
  print('LexicalFocusOrder compare gamma vs beta: '
      '${lGamma.compareTo(lBeta)}');

  // ─── Local widget helpers ───────────────────────────────────────────────

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
            color: gradient.first.withValues(alpha: 0.40),
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
        color: bg ?? paper,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: border ?? slateLight),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: indigo.withValues(alpha: 0.06),
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
        headerGradient ?? <Color>[indigoDeep, indigo];
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
            width: 200,
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

  Widget orderBadge(int n, Color bg, Color fg) {
    return Container(
      width: 22,
      height: 22,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(11),
        border: Border.all(color: fg.withValues(alpha: 0.5), width: 1),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: bg.withValues(alpha: 0.35),
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Center(
        child: Text(
          '$n',
          style: TextStyle(
            color: fg,
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget codeSnippetCard(String title, String code, {Color? accent}) {
    final Color a = accent ?? sky;
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
              color: a.withValues(alpha: 0.18),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(9)),
              border: Border(
                bottom: BorderSide(color: a.withValues(alpha: 0.4)),
              ),
            ),
            child: Row(
              children: <Widget>[
                Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    color: a,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.95),
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.3,
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
              style: const TextStyle(
                color: Color(0xFFE2E8F0),
                fontFamily: 'monospace',
                fontSize: 11.5,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // A simple "field box" — a fixed-size rectangle representing a focusable
  // form input. We pass a global key only when needed (here, never), keeping
  // everything 100% static.
  Widget fieldBox(String label, {Color? bg, Color? border, double w = 130}) {
    return Container(
      width: w,
      height: 40,
      decoration: BoxDecoration(
        color: bg ?? Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: border ?? slateLight, width: 1.2),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: slateDeep.withValues(alpha: 0.06),
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: slateDeep,
        ),
      ),
    );
  }

  // A field with a numbered chip in its corner (used for ordered demos).
  Widget numberedField(int n, String label,
      {Color? chipBg, Color? chipFg, double w = 130}) {
    final Color cb = chipBg ?? indigo;
    final Color cf = chipFg ?? Colors.white;
    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        fieldBox(label, w: w),
        Positioned(
          left: -10,
          top: -10,
          child: Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              color: cb,
              borderRadius: BorderRadius.circular(11),
              border: Border.all(color: Colors.white, width: 1.5),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: cb.withValues(alpha: 0.45),
                  blurRadius: 3,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Center(
              child: Text(
                '$n',
                style: TextStyle(
                  color: cf,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Wraps any widget with a CustomPaint overlay that draws traversal arrows
  // for a pre-computed order over a list of fixed field rects.
  Widget arrowsOverlay({
    required Widget child,
    required Size size,
    required List<Rect> rects,
    required List<int> order,
    required Color arrowColor,
    required Color numberBg,
    required Color numberFg,
  }) {
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Stack(
        children: <Widget>[
          Positioned.fill(child: child),
          Positioned.fill(
            child: IgnorePointer(
              child: CustomPaint(
                painter: _TraversalArrowPainter(
                  fieldRects: rects,
                  order: order,
                  arrowColor: arrowColor,
                  numberBg: numberBg,
                  numberFg: numberFg,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── 0. Hero card ─────────────────────────────────────────────────────
  final Widget hero = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[indigoDeep, indigo, teal],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: indigoDeep.withValues(alpha: 0.35),
          blurRadius: 14,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Flutter Focus Traversal',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.6,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'A static, illustrated tour of FocusTraversalPolicy, '
          'FocusTraversalGroup, FocusTraversalOrder, FocusNode and the '
          'FocusScope hierarchy.',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.92),
            fontSize: 13,
            height: 1.45,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          children: <Widget>[
            chipTag('FocusScope', Colors.white, indigoDeep),
            chipTag('Reading order', tealLight, tealDeep),
            chipTag('Widget order', indigoLight, indigoDeep),
            chipTag('Ordered', amberLight, amber),
            chipTag('Numeric / Lexical', roseLight, rose),
          ],
        ),
      ],
    ),
  );

  // ─── 1. Intro ─────────────────────────────────────────────────────────
  final Widget intro = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      sectionBanner('1', 'What is focus traversal, and why care?',
          const <Color>[indigoDeep, indigo]),
      proseBox(
        'Focus traversal is the rule that decides which focusable widget '
        'becomes "next" when the user presses Tab, an arrow key, a screen-'
        'reader swipe, or a gamepad bumper. Without it, the focused widget '
        'is only ever the last one you explicitly requested. With it, the '
        'entire user interface gains a deterministic linear order — one that '
        'is correct for keyboard users, for screen readers, for game pads, '
        'for in-car infotainment systems, and for accessibility audits.',
      ),
      infoCard(
        'A "next focus" is computed, not stored',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            dataRow('Trigger', 'Tab, Shift+Tab, arrow keys, dpad'),
            dataRow('Computed by',
                'FocusTraversalPolicy.findFirstFocusInDirection / next'),
            dataRow('Scope',
                'Nearest enclosing FocusTraversalGroup or FocusScope'),
            dataRow('Inputs',
                'Geometry, widget tree order, FocusTraversalOrder, '
                'Directionality'),
            dataRow('Output',
                'A FocusNode that becomes the new primaryFocus'),
          ],
        ),
      ),
      proseBox(
        'Three things together determine the next focus: (1) which '
        'FocusTraversalGroup encloses the current focus, (2) which '
        'FocusTraversalPolicy that group uses, and (3) whether individual '
        'children are tagged with FocusTraversalOrder. Geometry and '
        'Directionality come into play for reading-order policies.',
        bg: indigoLight,
        border: indigo,
      ),
    ],
  );

  // ─── 2. Anatomy diagram ───────────────────────────────────────────────
  final Widget anatomy = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      sectionBanner('2', 'Anatomy of the focus tree',
          const <Color>[tealDeep, teal]),
      proseBox(
        'Flutter maintains a parallel "focus tree" alongside the widget '
        'tree. Each FocusScope creates a stack-like region where focus can '
        'be restored when the scope re-enters. Inside a scope, a '
        'FocusTraversalGroup further partitions the focusable leaves into '
        'a policy boundary: tabbing inside a group cycles through that '
        'group; once the last leaf is reached, traversal escapes to the '
        'parent group.',
      ),
      Container(
        width: double.infinity,
        height: 220,
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: slateLight),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: slateDeep.withValues(alpha: 0.06),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: CustomPaint(
          painter: _FocusTreePainter(
            scopeColor: indigo,
            groupColor: teal,
            leafColor: amber,
            edgeColor: slate,
            labelColor: Colors.white,
            boundaryColor: rose,
          ),
        ),
      ),
      proseBox(
        'In the diagram above, the root FocusScope has two FocusTraversal'
        'Groups. The left group uses ReadingOrderTraversalPolicy and its '
        'three leaves traverse in widget order (F1 → F2 → F3). The right '
        'group uses OrderedTraversalPolicy with NumericFocusOrder, so its '
        'leaves traverse F5#1 → F4#2 → F6#3 — out of widget order. The '
        'dashed border around the right group is the policy boundary.',
        bg: tealLight,
        border: teal,
      ),
    ],
  );

  // ─── 3. Gallery: ReadingOrderTraversalPolicy ─────────────────────────
  // A 2x3 grid of fields. ReadingOrder roughly equals row-major in LTR.
  const Size readingSize = Size(420, 200);
  const List<Rect> readingRects = <Rect>[
    Rect.fromLTWH(20, 16, 130, 40),
    Rect.fromLTWH(170, 16, 130, 40),
    Rect.fromLTWH(20, 80, 130, 40),
    Rect.fromLTWH(170, 80, 130, 40),
    Rect.fromLTWH(20, 144, 130, 40),
    Rect.fromLTWH(170, 144, 130, 40),
  ];
  const List<int> readingOrder = <int>[0, 1, 2, 3, 4, 5];

  final Widget readingGalleryInner = Stack(
    children: <Widget>[
      for (int i = 0; i < readingRects.length; i++)
        Positioned(
          left: readingRects[i].left,
          top: readingRects[i].top,
          child: fieldBox(
            <String>['First name', 'Last name', 'Email', 'Phone', 'City',
                'Zip'][i],
            bg: paper,
            border: tealLight,
          ),
        ),
    ],
  );

  final Widget readingDemo = FocusTraversalGroup(
    policy: readingPolicy,
    child: arrowsOverlay(
      child: readingGalleryInner,
      size: readingSize,
      rects: readingRects,
      order: readingOrder,
      arrowColor: teal,
      numberBg: teal,
      numberFg: Colors.white,
    ),
  );

  // ─── 4. Gallery: WidgetOrderTraversalPolicy ───────────────────────────
  // The same 2x3 grid but with the second column placed FIRST in the widget
  // tree. WidgetOrder honours tree order, not geometry, so the arrows
  // criss-cross visually.
  const Size widgetSize = Size(420, 200);
  const List<Rect> widgetRects = <Rect>[
    // Stored in widget-tree order: column 1 entries come second.
    Rect.fromLTWH(170, 16, 130, 40),  // tree-index 0 (column 2 row 1)
    Rect.fromLTWH(20, 16, 130, 40),   // tree-index 1 (column 1 row 1)
    Rect.fromLTWH(170, 80, 130, 40),
    Rect.fromLTWH(20, 80, 130, 40),
    Rect.fromLTWH(170, 144, 130, 40),
    Rect.fromLTWH(20, 144, 130, 40),
  ];
  const List<int> widgetOrder = <int>[0, 1, 2, 3, 4, 5];

  final Widget widgetGalleryInner = Stack(
    children: <Widget>[
      for (int i = 0; i < widgetRects.length; i++)
        Positioned(
          left: widgetRects[i].left,
          top: widgetRects[i].top,
          child: fieldBox(
            <String>['B1', 'A1', 'B2', 'A2', 'B3', 'A3'][i],
            bg: paper,
            border: indigoLight,
          ),
        ),
    ],
  );

  final Widget widgetDemo = FocusTraversalGroup(
    policy: widgetPolicy,
    child: arrowsOverlay(
      child: widgetGalleryInner,
      size: widgetSize,
      rects: widgetRects,
      order: widgetOrder,
      arrowColor: indigo,
      numberBg: indigo,
      numberFg: Colors.white,
    ),
  );

  // ─── 5. Gallery: OrderedTraversalPolicy + NumericFocusOrder ───────────
  // Six fields in widget order, each tagged with NumericFocusOrder(N).
  // Renders numbered chips and arrows in the explicit numeric order.
  const Size numericSize = Size(420, 200);
  const List<Rect> numericRects = <Rect>[
    Rect.fromLTWH(20, 16, 130, 40),   // widget index 0 → N=3
    Rect.fromLTWH(170, 16, 130, 40),  // widget index 1 → N=1
    Rect.fromLTWH(20, 80, 130, 40),   // widget index 2 → N=5
    Rect.fromLTWH(170, 80, 130, 40),  // widget index 3 → N=2
    Rect.fromLTWH(20, 144, 130, 40),  // widget index 4 → N=6
    Rect.fromLTWH(170, 144, 130, 40), // widget index 5 → N=4
  ];
  // The numeric order assigned to each widget-index:
  const List<int> numericOrderValues = <int>[3, 1, 5, 2, 6, 4];
  // Visit-order: indices sorted by their numericOrderValues ascending.
  // Reading them off: 1=idx1, 2=idx3, 3=idx0, 4=idx5, 5=idx2, 6=idx4
  const List<int> numericVisitOrder = <int>[1, 3, 0, 5, 2, 4];

  final Widget numericGalleryInner = Stack(
    children: <Widget>[
      for (int i = 0; i < numericRects.length; i++)
        Positioned(
          left: numericRects[i].left,
          top: numericRects[i].top,
          child: FocusTraversalOrder(
            order: NumericFocusOrder(numericOrderValues[i].toDouble()),
            child: numberedField(
              numericOrderValues[i],
              'Field ${String.fromCharCode(65 + i)}',
              chipBg: amber,
              chipFg: Colors.white,
            ),
          ),
        ),
    ],
  );

  final Widget numericDemo = FocusTraversalGroup(
    policy: orderedPolicy,
    child: arrowsOverlay(
      child: numericGalleryInner,
      size: numericSize,
      rects: numericRects,
      order: numericVisitOrder,
      arrowColor: amber,
      numberBg: amber,
      numberFg: Colors.white,
    ),
  );

  // ─── 6. Gallery: OrderedTraversalPolicy + LexicalFocusOrder ───────────
  // Five fields, tagged lexically. Visit-order is alphabetic.
  const Size lexicalSize = Size(420, 200);
  const List<Rect> lexicalRects = <Rect>[
    Rect.fromLTWH(20, 16, 130, 40),
    Rect.fromLTWH(170, 16, 130, 40),
    Rect.fromLTWH(20, 80, 130, 40),
    Rect.fromLTWH(170, 80, 130, 40),
    Rect.fromLTWH(20, 144, 280, 40),
  ];
  const List<String> lexicalKeys = <String>[
    'epsilon',
    'alpha',
    'gamma',
    'beta',
    'delta',
  ];
  // Sort indices by key alphabetically: alpha(1), beta(3), delta(4),
  // epsilon(0), gamma(2).
  const List<int> lexicalVisitOrder = <int>[1, 3, 4, 0, 2];

  final Widget lexicalGalleryInner = Stack(
    children: <Widget>[
      for (int i = 0; i < lexicalRects.length; i++)
        Positioned(
          left: lexicalRects[i].left,
          top: lexicalRects[i].top,
          child: FocusTraversalOrder(
            order: LexicalFocusOrder(lexicalKeys[i]),
            child: fieldBox(
              lexicalKeys[i],
              bg: roseLight,
              border: rose,
              w: lexicalRects[i].width,
            ),
          ),
        ),
    ],
  );

  final Widget lexicalDemo = FocusTraversalGroup(
    policy: orderedPolicy,
    child: arrowsOverlay(
      child: lexicalGalleryInner,
      size: lexicalSize,
      rects: lexicalRects,
      order: lexicalVisitOrder,
      arrowColor: rose,
      numberBg: rose,
      numberFg: Colors.white,
    ),
  );

  // ─── Compose the gallery section ──────────────────────────────────────
  final Widget gallery = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      sectionBanner('3', 'Policy gallery',
          const <Color>[tealDeep, indigo]),
      proseBox(
        'Each card below wraps the same kind of layout in a different '
        'FocusTraversalPolicy. The numbered chips and arrows are the '
        'traversal order that Flutter would use, pre-computed and overlaid '
        'as a static diagram. There is no live focus motion — but the order '
        'shown is the order Tab would take.',
      ),
      infoCard(
        'ReadingOrderTraversalPolicy — geometry follows the Directionality',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'A 2-column form. Reading order in LTR walks row by row, '
              'left to right.',
              style: TextStyle(fontSize: 12, color: slate),
            ),
            const SizedBox(height: 8),
            readingDemo,
          ],
        ),
        headerGradient: const <Color>[tealDeep, teal],
      ),
      infoCard(
        'WidgetOrderTraversalPolicy — pure widget-tree order',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'The same grid, but the right-column fields appear first in '
              'the widget tree. WidgetOrder respects that and ignores '
              'geometry — arrows criss-cross.',
              style: TextStyle(fontSize: 12, color: slate),
            ),
            const SizedBox(height: 8),
            widgetDemo,
          ],
        ),
        headerGradient: const <Color>[indigoDeep, indigo],
      ),
      infoCard(
        'OrderedTraversalPolicy + NumericFocusOrder',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Six fields, each tagged with NumericFocusOrder(N). The '
              'numbered chip is the explicit traversal index — fields are '
              'visited in ascending numeric order regardless of widget '
              'position.',
              style: TextStyle(fontSize: 12, color: slate),
            ),
            const SizedBox(height: 8),
            numericDemo,
          ],
        ),
        headerGradient: <Color>[const Color(0xFF92400E), amber],
      ),
      infoCard(
        'OrderedTraversalPolicy + LexicalFocusOrder',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Same idea, but the order key is a string. Visit-order is '
              'alphabetic by the lexical key.',
              style: TextStyle(fontSize: 12, color: slate),
            ),
            const SizedBox(height: 8),
            lexicalDemo,
          ],
        ),
        headerGradient: <Color>[const Color(0xFF881337), rose],
      ),
    ],
  );

  // ─── 7. Numeric-order detail card with chips listing ──────────────────
  final Widget numericDetail = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      sectionBanner('4', 'NumericFocusOrder up close',
          const <Color>[Color(0xFF92400E), amber]),
      proseBox(
        'NumericFocusOrder wraps a double. OrderedTraversalPolicy sorts '
        'siblings by this value (ascending). Equal values are tie-broken by '
        'widget order. Negative numbers are allowed — they sort first.',
      ),
      infoCard(
        'Six tagged fields, sorted by chip number',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            for (int rank = 1; rank <= 6; rank++)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Row(
                  children: <Widget>[
                    orderBadge(rank, amber, Colors.white),
                    Text(
                      'Visit rank $rank  →  widget index '
                      '${numericVisitOrder[rank - 1]} '
                      '(label "Field '
                      '${String.fromCharCode(65 + numericVisitOrder[rank - 1])}")',
                      style: const TextStyle(
                        fontSize: 12,
                        color: slateDeep,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
        headerGradient: <Color>[const Color(0xFF92400E), amber],
      ),
      codeSnippetCard(
        'idiom: NumericFocusOrder on a single field',
        '''FocusTraversalGroup(
  policy: OrderedTraversalPolicy(),
  child: Column(
    children: <Widget>[
      FocusTraversalOrder(
        order: const NumericFocusOrder(3.0),
        child: TextField(decoration: InputDecoration(labelText: 'C')),
      ),
      FocusTraversalOrder(
        order: const NumericFocusOrder(1.0),
        child: TextField(decoration: InputDecoration(labelText: 'A')),
      ),
      FocusTraversalOrder(
        order: const NumericFocusOrder(2.0),
        child: TextField(decoration: InputDecoration(labelText: 'B')),
      ),
    ],
  ),
)''',
        accent: amber,
      ),
    ],
  );

  // ─── 8. LTR vs RTL comparison ─────────────────────────────────────────
  final Widget directionality = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      sectionBanner('5', 'LTR vs RTL — reading order flips',
          const <Color>[indigoDeep, teal]),
      proseBox(
        'ReadingOrderTraversalPolicy is sensitive to the ambient '
        'Directionality. In an LTR locale, four siblings are visited 1 → 2 '
        '→ 3 → 4 from the left. In an RTL locale, the same four siblings '
        'are visited from the right edge inward. The widget tree order does '
        'not change — only the policy\'s interpretation of "first" does.',
      ),
      Container(
        width: double.infinity,
        height: 120,
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: slateLight),
        ),
        child: const CustomPaint(
          painter: _DirectionalityComparePainter(
            cellColor: indigoLight,
            arrowColor: indigo,
            labelColor: slateDeep,
          ),
        ),
      ),
      infoCard(
        'Why this matters',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            dataRow('LTR languages',
                'English, German, French — Tab goes left → right, top → bottom'),
            dataRow('RTL languages',
                'Arabic, Hebrew — Tab goes right → left, top → bottom'),
            dataRow('Whose responsibility',
                'ReadingOrderTraversalPolicy reads Directionality.of(context)'),
            dataRow('Override?',
                'Wrap a subtree in Directionality(textDirection: ...)'),
          ],
        ),
        headerGradient: const <Color>[tealDeep, teal],
      ),
    ],
  );

  // ─── 9. Real FocusTraversalGroup with FocusTraversalOrder children ────
  // We construct a real FocusTraversalGroup with three Focus children, each
  // tagged with NumericFocusOrder. This exercises the actual API surface.
  final Widget realGroup = FocusTraversalGroup(
    policy: orderedPolicy,
    child: Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FocusTraversalOrder(
            order: const NumericFocusOrder(3.0),
            child: Focus(
              focusNode: cNode,
              child: numberedField(3, 'cNode (tag 3.0)',
                  chipBg: amber, w: 240),
            ),
          ),
          const SizedBox(height: 8),
          FocusTraversalOrder(
            order: const NumericFocusOrder(1.0),
            child: Focus(
              focusNode: aNode,
              child: numberedField(1, 'aNode (tag 1.0)',
                  chipBg: amber, w: 240),
            ),
          ),
          const SizedBox(height: 8),
          FocusTraversalOrder(
            order: const NumericFocusOrder(2.0),
            child: Focus(
              focusNode: bNode,
              child: numberedField(2, 'bNode (tag 2.0)',
                  chipBg: amber, w: 240),
            ),
          ),
        ],
      ),
    ),
  );

  final Widget realApi = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      sectionBanner('6', 'Real FocusTraversalGroup with Focus children',
          const <Color>[tealDeep, amber]),
      proseBox(
        'The card below contains a real FocusTraversalGroup with three '
        'Focus widgets attached to actual FocusNodes. Each Focus is wrapped '
        'in a FocusTraversalOrder using NumericFocusOrder. The numbered '
        'chips show the order Flutter would visit them.',
      ),
      infoCard(
        'FocusTraversalGroup + Focus(focusNode: ...)',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            realGroup,
            const SizedBox(height: 12),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    'rootScope.debugLabel: ${rootScope.debugLabel ?? '-'}',
                    style: const TextStyle(fontSize: 11, color: slate),
                  ),
                ),
                Expanded(
                  child: Text(
                    'formScope.debugLabel: ${formScope.debugLabel ?? '-'}',
                    style: const TextStyle(fontSize: 11, color: slate),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    'aNode.debugLabel: ${aNode.debugLabel ?? '-'}',
                    style: const TextStyle(fontSize: 11, color: slate),
                  ),
                ),
                Expanded(
                  child: Text(
                    'aNode.skipTraversal: ${aNode.skipTraversal}',
                    style: const TextStyle(fontSize: 11, color: slate),
                  ),
                ),
              ],
            ),
          ],
        ),
        headerGradient: <Color>[tealDeep, amber],
      ),
    ],
  );

  // ─── 10. FocusScope visualisation ─────────────────────────────────────
  final Widget scopes = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      sectionBanner('7', 'FocusScope: where focus parks itself',
          const <Color>[indigoDeep, sky]),
      proseBox(
        'A FocusScope is a "save point" for focus. When the scope becomes '
        'inactive (e.g. when a dialog is dismissed), Flutter remembers which '
        'descendant FocusNode last held focus inside that scope. When the '
        'scope regains focus, that node is restored — without your code '
        'having to remember anything. Each FocusScope contributes its own '
        'traversal frontier; tabbing inside a scope cycles inside it, then '
        'escapes outward.',
      ),
      infoCard(
        'rootScope vs formScope vs leaf FocusNodes',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            dataRow('FocusScopeNode',
                'A FocusNode subtype that participates as a scope frontier'),
            dataRow('Created by',
                'FocusScope widget, or constructed manually like rootScope'),
            dataRow('Remembers',
                'lastFocusedNode for round-trip restoration'),
            dataRow('rootScope debugLabel',
                rootScope.debugLabel ?? '(none)'),
            dataRow('formScope debugLabel',
                formScope.debugLabel ?? '(none)'),
            dataRow('aNode debugLabel', aNode.debugLabel ?? '(none)'),
            dataRow('bNode debugLabel', bNode.debugLabel ?? '(none)'),
            dataRow('cNode debugLabel', cNode.debugLabel ?? '(none)'),
            dataRow('dNode.canRequestFocus',
                '${dNode.canRequestFocus}'),
            dataRow('FocusManager type',
                FocusManager.instance.runtimeType.toString()),
          ],
        ),
        headerGradient: const <Color>[indigoDeep, indigo],
      ),
    ],
  );

  // ─── 11. FocusableActionDetector card ─────────────────────────────────
  // We can construct one, even though we won't trigger its actions.
  final Widget focusableActionCard = FocusableActionDetector(
    enabled: true,
    descendantsAreFocusable: true,
    actions: const <Type, Action<Intent>>{},
    shortcuts: const <ShortcutActivator, Intent>{
      SingleActivator(LogicalKeyboardKey.enter): ActivateIntent(),
      SingleActivator(LogicalKeyboardKey.space): ActivateIntent(),
    },
    child: Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: tealLight,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: teal),
      ),
      child: const Text(
        'FocusableActionDetector — combines Focus + Actions + Shortcuts',
        style: TextStyle(
          color: tealDeep,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
  );

  final Widget focusableActions = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      sectionBanner('8', 'FocusableActionDetector',
          const <Color>[tealDeep, teal]),
      proseBox(
        'FocusableActionDetector is the bundle widget. It is a Focus, an '
        'Actions, a Shortcuts and a MouseRegion all in one — the canonical '
        'wrapper for any "focusable, clickable, hoverable, key-bindable" '
        'leaf you build yourself. If you find yourself nesting four wrapper '
        'widgets in a row, you probably want this one instead.',
      ),
      infoCard(
        'A minimal FocusableActionDetector',
        focusableActionCard,
        headerGradient: const <Color>[tealDeep, teal],
      ),
      codeSnippetCard(
        'idiom: a focusable button-like widget',
        '''FocusableActionDetector(
  shortcuts: const <ShortcutActivator, Intent>{
    SingleActivator(LogicalKeyboardKey.enter): ActivateIntent(),
    SingleActivator(LogicalKeyboardKey.space): ActivateIntent(),
  },
  actions: <Type, Action<Intent>>{
    ActivateIntent: CallbackAction<ActivateIntent>(
      onInvoke: (Intent _) => doSomething(),
    ),
  },
  child: MyVisualBox(),
)''',
        accent: teal,
      ),
    ],
  );

  // ─── 12. Code samples for the four policies ───────────────────────────
  final Widget codeSamples = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      sectionBanner('9', 'Idiomatic setup',
          const <Color>[Color(0xFF111827), sky]),
      proseBox(
        'Each policy has a one-line, declarative wiring. The boilerplate is '
        'always the same: a FocusTraversalGroup at the boundary, a policy '
        'instance, and (for OrderedTraversalPolicy) FocusTraversalOrder '
        'children with NumericFocusOrder or LexicalFocusOrder.',
      ),
      codeSnippetCard(
        'ReadingOrderTraversalPolicy',
        '''FocusTraversalGroup(
  policy: ReadingOrderTraversalPolicy(),
  child: Column(
    children: <Widget>[
      TextField(),
      TextField(),
      TextField(),
    ],
  ),
)''',
        accent: teal,
      ),
      codeSnippetCard(
        'WidgetOrderTraversalPolicy',
        '''FocusTraversalGroup(
  policy: WidgetOrderTraversalPolicy(),
  child: Wrap(
    children: <Widget>[
      TextField(),
      TextField(),
    ],
  ),
)''',
        accent: indigo,
      ),
      codeSnippetCard(
        'OrderedTraversalPolicy + NumericFocusOrder',
        '''FocusTraversalGroup(
  policy: OrderedTraversalPolicy(),
  child: Column(
    children: <Widget>[
      FocusTraversalOrder(
        order: NumericFocusOrder(2),
        child: TextField(),
      ),
      FocusTraversalOrder(
        order: NumericFocusOrder(1),
        child: TextField(),
      ),
    ],
  ),
)''',
        accent: amber,
      ),
      codeSnippetCard(
        'OrderedTraversalPolicy + LexicalFocusOrder',
        '''FocusTraversalGroup(
  policy: OrderedTraversalPolicy(),
  child: Column(
    children: <Widget>[
      FocusTraversalOrder(
        order: LexicalFocusOrder('email'),
        child: TextField(),
      ),
      FocusTraversalOrder(
        order: LexicalFocusOrder('address'),
        child: TextField(),
      ),
    ],
  ),
)''',
        accent: rose,
      ),
    ],
  );

  // ─── 13. Pitfalls section ─────────────────────────────────────────────
  Widget pitfall(String title, String body, Color accent) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: accent.withValues(alpha: 0.55)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: accent.withValues(alpha: 0.10),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.15),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(7)),
              border: Border(
                bottom: BorderSide(color: accent.withValues(alpha: 0.45)),
              ),
            ),
            child: Row(
              children: <Widget>[
                Icon(Icons.warning_amber_rounded, color: accent, size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: accent,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              body,
              style: const TextStyle(
                fontSize: 12,
                height: 1.5,
                color: slateDeep,
              ),
            ),
          ),
        ],
      ),
    );
  }

  final Widget pitfalls = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      sectionBanner('10', 'Pitfalls and gotchas',
          const <Color>[Color(0xFF881337), rose]),
      proseBox(
        'Focus traversal usually "just works" — until it doesn\'t. The most '
        'common failure modes are listed below. Each one has a single, '
        'usually-one-line fix.',
      ),
      pitfall(
        'No FocusScope at all',
        'A subtree with focusable children but no enclosing FocusScope (and '
        'no MaterialApp/CupertinoApp which provide one) cannot stack focus '
        'state. Tabbing escapes into nothing. Fix: wrap the area in '
        'FocusScope or rely on the implicit one in MaterialApp.',
        rose,
      ),
      pitfall(
        'Mixing policies inside a single group',
        'A FocusTraversalGroup takes one policy. Mixing FocusTraversalOrder '
        'children with un-tagged children under OrderedTraversalPolicy leads '
        'to "untagged-first, tagged-by-numeric-order-second" behaviour, '
        'which surprises everyone. Fix: tag every child, or nest groups.',
        rose,
      ),
      pitfall(
        'Wrapping a single field in FocusTraversalGroup',
        'A FocusTraversalGroup with one focusable descendant cannot reorder '
        'anything; it only creates a traversal boundary that traps focus on '
        'itself. Fix: remove the wrapper, or move the wrapper outward to '
        'enclose the actual peer fields.',
        rose,
      ),
      pitfall(
        'Mismatched NumericFocusOrder scales',
        'NumericFocusOrder(0.0001) and NumericFocusOrder(10000) work, but '
        'mixing tiny fractions with large integers in one group makes '
        'maintenance unreasonable. Fix: pick one scale per group — e.g. '
        '10, 20, 30 (leaving room to insert later).',
        rose,
      ),
      pitfall(
        'Forgetting that ReadingOrder is geometry-based',
        'If your "row" is actually four Stack children placed by '
        'Positioned at the same y, ReadingOrderTraversalPolicy uses their '
        'horizontal centres — so a 1-pixel difference can flip the order. '
        'Fix: align rows precisely, or switch to OrderedTraversalPolicy.',
        rose,
      ),
      pitfall(
        'Using FocusNode.skipTraversal without thinking',
        'Setting skipTraversal=true removes a node from Tab navigation but '
        'keeps it focusable programmatically. Useful for "decorative '
        'links", confusing if applied to the only field in a group. Fix: '
        'apply skipTraversal only to nodes that are reachable some other '
        'way (clicks, swipes).',
        rose,
      ),
    ],
  );

  // ─── 14. Summary table of policies ────────────────────────────────────
  Widget policyRow(String name, String semantics, Color tint) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      decoration: BoxDecoration(
        color: tint.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(7),
        border: Border.all(color: tint.withValues(alpha: 0.45)),
      ),
      padding: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 220,
            child: Text(
              name,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: tint,
              ),
            ),
          ),
          Expanded(
            child: Text(
              semantics,
              style: const TextStyle(
                fontSize: 12,
                color: slateDeep,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  final Widget summaryTable = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      sectionBanner('11', 'Summary: policy semantics in one line each',
          const <Color>[indigoDeep, teal]),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: slateLight),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: slateDeep.withValues(alpha: 0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: <Widget>[
            policyRow(
              'ReadingOrderTraversalPolicy',
              'Geometry-based. Walks rows top-to-bottom; inside each row, '
              'walks LTR or RTL according to Directionality.',
              teal,
            ),
            policyRow(
              'WidgetOrderTraversalPolicy',
              'Pure widget-tree order. Geometry is ignored. Useful when '
              'visual layout differs from logical input order.',
              indigo,
            ),
            policyRow(
              'OrderedTraversalPolicy',
              'Uses FocusTraversalOrder children to define order; falls '
              'back to widget order for untagged children.',
              amber,
            ),
            policyRow(
              'DirectionalFocusTraversalPolicyMixin',
              'Mixin used by all built-in policies to handle arrow-key '
              'directional movement (vs Tab).',
              sky,
            ),
            policyRow(
              'NumericFocusOrder',
              'A FocusOrder whose key is a double; visits ascending.',
              const Color(0xFF92400E),
            ),
            policyRow(
              'LexicalFocusOrder',
              'A FocusOrder whose key is a String; visits alphabetically.',
              rose,
            ),
          ],
        ),
      ),
    ],
  );

  // ─── 15. Closing card ─────────────────────────────────────────────────
  final Widget closing = Container(
    width: double.infinity,
    margin: const EdgeInsets.only(top: 20, bottom: 12),
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[indigoDeep, slateDeep],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: indigoDeep.withValues(alpha: 0.30),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Recap',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.6,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'FocusScope creates focus state regions; FocusTraversalGroup '
          'creates policy regions; FocusTraversalOrder tags individual '
          'children with a sortable key. Pick the policy that matches the '
          'intent: ReadingOrder for geometry-driven input forms, WidgetOrder '
          'when widget tree order is canonical, and OrderedTraversalPolicy '
          'when you want to override either of the above.',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.94),
            fontSize: 13,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          children: <Widget>[
            chipTag('Tab', Colors.white, indigoDeep),
            chipTag('Shift+Tab', Colors.white, indigoDeep),
            chipTag('Arrow keys', indigoLight, indigoDeep),
            chipTag('Screen reader', tealLight, tealDeep),
            chipTag('Gamepad', amberLight, amber),
          ],
        ),
      ],
    ),
  );

  print('===== END FOCUS TRAVERSAL DEEP VISUAL DEMO =====');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Focus Traversal Deep Demo',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: indigo,
        brightness: Brightness.light,
      ),
      useMaterial3: true,
    ),
    home: Scaffold(
      backgroundColor: paper,
      appBar: AppBar(
        backgroundColor: indigoDeep,
        foregroundColor: Colors.white,
        title: const Text(
          'Focus Traversal — Deep Visual Demo',
          style: TextStyle(fontWeight: FontWeight.w700, letterSpacing: 0.4),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              hero,
              intro,
              anatomy,
              gallery,
              numericDetail,
              directionality,
              realApi,
              scopes,
              focusableActions,
              codeSamples,
              pitfalls,
              summaryTable,
              closing,
            ],
          ),
        ),
      ),
    ),
  );
}
