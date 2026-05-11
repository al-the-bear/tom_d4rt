// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// Deep visual demo for the Tom D4rt flutter_ast corpus:
// The render-tree "view layer" — RenderView, RenderViewport, ViewportOffset,
// RenderShiftedBox family, RenderProxyBox, and the relationship between the
// widget tree, element tree, and render tree at the root.
//
// This file is a static visualisation. We do not instantiate raw
// RenderObjects here; we paint diagrams with normal widgets to explain how
// Flutter's binding wires a FlutterView -> RenderView -> child render
// objects, and how a RenderViewport composes slivers behind a window.

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Palette
// ---------------------------------------------------------------------------

const Color _kBackground = Color(0xFF0E1322);
const Color _kCardA = Color(0xFF1A2238);
const Color _kCardB = Color(0xFF202A47);
const Color _kCardC = Color(0xFF2A3358);
const Color _kAccentBlue = Color(0xFF4FC3F7);
const Color _kAccentCyan = Color(0xFF26E0D6);
const Color _kAccentPurple = Color(0xFFB388FF);
const Color _kAccentAmber = Color(0xFFFFC857);
const Color _kAccentPink = Color(0xFFFF6E9C);
const Color _kAccentGreen = Color(0xFF7BE495);
const Color _kInk = Color(0xFFEDF2FF);
const Color _kInkDim = Color(0xFFA9B4D2);
const Color _kRule = Color(0xFF394269);

const TextStyle _kTitle = TextStyle(
  color: _kInk,
  fontSize: 22,
  fontWeight: FontWeight.w700,
  letterSpacing: 0.2,
);

const TextStyle _kSub = TextStyle(
  color: _kAccentCyan,
  fontSize: 13,
  fontWeight: FontWeight.w600,
  letterSpacing: 1.6,
);

const TextStyle _kBody = TextStyle(
  color: _kInk,
  fontSize: 14,
  height: 1.45,
);

const TextStyle _kBodyDim = TextStyle(
  color: _kInkDim,
  fontSize: 13,
  height: 1.45,
);

const TextStyle _kMono = TextStyle(
  color: _kAccentGreen,
  fontFamily: 'monospace',
  fontSize: 12.5,
  height: 1.45,
);

// ---------------------------------------------------------------------------
// Decoration factories
// ---------------------------------------------------------------------------

BoxDecoration _cardA() => BoxDecoration(
      borderRadius: BorderRadius.circular(18),
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [_kCardA, _kCardB],
      ),
      border: Border.all(color: _kRule, width: 1),
      boxShadow: const [
        BoxShadow(
          color: Color(0x66000000),
          blurRadius: 22,
          offset: Offset(0, 10),
        ),
        BoxShadow(
          color: Color(0x223A8DFF),
          blurRadius: 6,
          offset: Offset(0, 1),
        ),
      ],
    );

BoxDecoration _cardB() => BoxDecoration(
      borderRadius: BorderRadius.circular(18),
      gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [_kCardB, _kCardC],
      ),
      border: Border.all(color: _kRule, width: 1),
      boxShadow: const [
        BoxShadow(
          color: Color(0x55000000),
          blurRadius: 18,
          offset: Offset(0, 8),
        ),
        BoxShadow(
          color: Color(0x2226E0D6),
          blurRadius: 8,
          offset: Offset(0, 0),
        ),
      ],
    );

BoxDecoration _accentGradient(List<Color> c) => BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: c,
      ),
      borderRadius: BorderRadius.circular(12),
      boxShadow: const [
        BoxShadow(
          color: Color(0x44000000),
          blurRadius: 10,
          offset: Offset(0, 4),
        ),
      ],
    );

BoxDecoration _codeDeco() => BoxDecoration(
      color: const Color(0xFF05080F),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: const Color(0xFF1F2A44)),
      boxShadow: const [
        BoxShadow(
          color: Color(0x66000000),
          blurRadius: 8,
          offset: Offset(0, 2),
        ),
      ],
    );

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

Widget _sectionHeader(String eyebrow, String title) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(eyebrow, style: _kSub),
      const SizedBox(height: 6),
      Text(title, style: _kTitle),
      const SizedBox(height: 4),
      Container(
        height: 3,
        width: 64,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [_kAccentCyan, _kAccentPurple],
          ),
          borderRadius: BorderRadius.circular(2),
        ),
      ),
      const SizedBox(height: 14),
    ],
  );
}

Widget _prose(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Text(text, style: _kBody),
  );
}

Widget _proseDim(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Text(text, style: _kBodyDim),
  );
}

Widget _chip(String label, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: Color.fromARGB(50, color.red, color.green, color.blue),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color, width: 1),
    ),
    child: Text(label,
        style: TextStyle(
          color: color,
          fontSize: 11.5,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.4,
        )),
  );
}

// ---------------------------------------------------------------------------
// CustomPainter — RenderView pipeline anatomy
// ---------------------------------------------------------------------------

class _PipelinePainter extends CustomPainter {
  const _PipelinePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paintBg = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFF0B1326), Color(0xFF1A2348)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Offset.zero & size);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Offset.zero & size,
        const Radius.circular(14),
      ),
      paintBg,
    );

    final colW = size.width / 3;
    final boxes = ['Widget Tree', 'Element Tree', 'Render Tree'];
    final detail = [
      'View (Widget)\nMaterialApp\nScaffold\nColumn',
      'StatefulElement\nComponentElement\nRenderObjectElement',
      'RenderView\nRenderConstrainedBox\nRenderFlex\nRenderParagraph',
    ];
    final cols = [_kAccentBlue, _kAccentPurple, _kAccentAmber];

    for (var i = 0; i < 3; i++) {
      final left = colW * i + 14;
      final right = colW * (i + 1) - 14;
      final rect = Rect.fromLTRB(left, 18, right, size.height - 18);
      final box = Paint()
        ..shader = LinearGradient(
          colors: [
            Color.fromARGB(60, cols[i].red, cols[i].green, cols[i].blue),
            Color.fromARGB(20, cols[i].red, cols[i].green, cols[i].blue),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ).createShader(rect);
      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, const Radius.circular(10)),
        box,
      );
      final stroke = Paint()
        ..style = PaintingStyle.stroke
        ..color = cols[i]
        ..strokeWidth = 1.4;
      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, const Radius.circular(10)),
        stroke,
      );

      final tp = TextPainter(
        text: TextSpan(
          text: boxes[i],
          style: TextStyle(
            color: cols[i],
            fontSize: 13,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.4,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: rect.width - 16);
      tp.paint(canvas, Offset(rect.left + 10, rect.top + 8));

      final tp2 = TextPainter(
        text: TextSpan(
          text: detail[i],
          style: const TextStyle(
            color: _kInk,
            fontSize: 11.5,
            height: 1.5,
            fontFamily: 'monospace',
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: rect.width - 16);
      tp2.paint(canvas, Offset(rect.left + 10, rect.top + 34));

      if (i < 2) {
        final arrowY = rect.center.dy;
        final p1 = Offset(rect.right + 1, arrowY);
        final p2 = Offset(rect.right + colW - rect.width - 2, arrowY);
        final arrowPaint = Paint()
          ..color = _kInkDim
          ..strokeWidth = 1.4;
        canvas.drawLine(p1, p2, arrowPaint);
        final path = Path()
          ..moveTo(p2.dx, p2.dy)
          ..lineTo(p2.dx - 6, p2.dy - 4)
          ..lineTo(p2.dx - 6, p2.dy + 4)
          ..close();
        canvas.drawPath(path, Paint()..color = _kInkDim);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ---------------------------------------------------------------------------
// CustomPainter — Viewport stack (window over a tall child)
// ---------------------------------------------------------------------------

class _ViewportStackPainter extends CustomPainter {
  const _ViewportStackPainter({required this.offsetFrac});

  final double offsetFrac;

  @override
  void paint(Canvas canvas, Size size) {
    final bg = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFF111935), Color(0xFF1B2247)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Offset.zero & size);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
          Offset.zero & size, const Radius.circular(12)),
      bg,
    );

    final childRect =
        Rect.fromLTWH(size.width * 0.55, 14, size.width * 0.35, size.height - 28);
    final tall = Paint()
      ..shader = const LinearGradient(
        colors: [_kAccentPurple, _kAccentPink],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(childRect);
    canvas.drawRRect(
      RRect.fromRectAndRadius(childRect, const Radius.circular(8)),
      tall,
    );

    final segH = (childRect.height) / 6;
    final segPaint = Paint()
      ..color = const Color(0x33FFFFFF)
      ..style = PaintingStyle.stroke;
    for (var i = 1; i < 6; i++) {
      final y = childRect.top + i * segH;
      canvas.drawLine(
          Offset(childRect.left + 4, y),
          Offset(childRect.right - 4, y),
          segPaint);
    }

    final winRect = Rect.fromLTWH(
      size.width * 0.08,
      size.height * 0.18,
      size.width * 0.36,
      size.height * 0.64,
    );
    final winPaint = Paint()
      ..shader = const LinearGradient(
        colors: [_kAccentCyan, _kAccentBlue],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(winRect);
    canvas.drawRRect(
      RRect.fromRectAndRadius(winRect, const Radius.circular(10)),
      winPaint,
    );

    final stroke = Paint()
      ..color = _kInk
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;
    canvas.drawRRect(
      RRect.fromRectAndRadius(winRect, const Radius.circular(10)),
      stroke,
    );

    final connectorPaint = Paint()
      ..color = _kInkDim
      ..strokeWidth = 1.2;
    final winRight = Offset(winRect.right, winRect.center.dy);
    final visTop = childRect.top +
        childRect.height * offsetFrac.clamp(0.0, 0.6);
    final visBottom = visTop + winRect.height * 0.6;
    canvas.drawLine(winRight, Offset(childRect.left, visTop), connectorPaint);
    canvas.drawLine(
        Offset(winRect.right, winRect.bottom),
        Offset(childRect.left, visBottom),
        connectorPaint);

    final tp = TextPainter(
      text: const TextSpan(
        text: 'Viewport\n(window)',
        style: TextStyle(
          color: _kInk,
          fontSize: 12,
          fontWeight: FontWeight.w700,
          height: 1.2,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: winRect.width - 8);
    tp.paint(
      canvas,
      Offset(
        winRect.left + (winRect.width - tp.width) / 2,
        winRect.top + 8,
      ),
    );

    final tp2 = TextPainter(
      text: const TextSpan(
        text: 'Child\n(slivers /\nbox content)',
        style: TextStyle(
          color: _kInk,
          fontSize: 11,
          fontWeight: FontWeight.w600,
          height: 1.2,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: childRect.width - 6);
    tp2.paint(
      canvas,
      Offset(
        childRect.left + (childRect.width - tp2.width) / 2,
        childRect.top + 8,
      ),
    );
  }

  @override
  bool shouldRepaint(covariant _ViewportStackPainter oldDelegate) =>
      oldDelegate.offsetFrac != offsetFrac;
}

// ---------------------------------------------------------------------------
// CustomPainter — ViewportOffset axis
// ---------------------------------------------------------------------------

class _OffsetAxisPainter extends CustomPainter {
  const _OffsetAxisPainter({required this.value, required this.maxV});

  final double value;
  final double maxV;

  @override
  void paint(Canvas canvas, Size size) {
    final bg = Paint()..color = const Color(0xFF0B1226);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
          Offset.zero & size, const Radius.circular(10)),
      bg,
    );

    final axis = Paint()
      ..color = _kRule
      ..strokeWidth = 1.0;
    final yMid = size.height / 2;
    canvas.drawLine(Offset(20, yMid), Offset(size.width - 20, yMid), axis);

    final ticks = 10;
    for (var i = 0; i <= ticks; i++) {
      final x = 20 + (size.width - 40) * (i / ticks);
      canvas.drawLine(
        Offset(x, yMid - 6),
        Offset(x, yMid + 6),
        axis,
      );
      final tp = TextPainter(
        text: TextSpan(
          text: (maxV * i / ticks).toStringAsFixed(0),
          style: const TextStyle(color: _kInkDim, fontSize: 10),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(x - tp.width / 2, yMid + 10));
    }

    final cursorX = 20 + (size.width - 40) * (value / maxV).clamp(0.0, 1.0);
    final cursorPaint = Paint()
      ..shader = const LinearGradient(
        colors: [_kAccentCyan, _kAccentPurple],
      ).createShader(Rect.fromCircle(
          center: Offset(cursorX, yMid), radius: 10));
    canvas.drawCircle(Offset(cursorX, yMid), 8, cursorPaint);
    canvas.drawCircle(
      Offset(cursorX, yMid),
      8,
      Paint()
        ..style = PaintingStyle.stroke
        ..color = _kInk
        ..strokeWidth = 1.4,
    );

    final tp = TextPainter(
      text: TextSpan(
        text: 'pixels = ${value.toStringAsFixed(1)}',
        style: const TextStyle(
            color: _kInk, fontSize: 11, fontWeight: FontWeight.w600),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, Offset(cursorX - tp.width / 2, yMid - 28));
  }

  @override
  bool shouldRepaint(covariant _OffsetAxisPainter oldDelegate) =>
      oldDelegate.value != value || oldDelegate.maxV != maxV;
}

// ---------------------------------------------------------------------------
// CustomPainter — RenderShiftedBox arrangement
// ---------------------------------------------------------------------------

class _ShiftedBoxPainter extends CustomPainter {
  const _ShiftedBoxPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final bg = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFF0C1326), Color(0xFF181F40)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Offset.zero & size);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
          Offset.zero & size, const Radius.circular(12)),
      bg,
    );

    final parent = Rect.fromLTWH(
        16, 16, size.width - 32, size.height - 32);
    final parentPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = _kAccentBlue
      ..strokeWidth = 1.4;
    canvas.drawRRect(
      RRect.fromRectAndRadius(parent, const Radius.circular(8)),
      parentPaint,
    );

    final padding = const EdgeInsets.fromLTRB(24, 28, 20, 20);
    final innerRect = padding.deflateRect(parent);
    final padPaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0x55B388FF), Color(0x33B388FF)],
      ).createShader(innerRect);
    canvas.drawRRect(
      RRect.fromRectAndRadius(innerRect, const Radius.circular(6)),
      padPaint,
    );

    final childW = innerRect.width * 0.55;
    final childH = innerRect.height * 0.55;
    final childRect = Rect.fromLTWH(
        innerRect.left, innerRect.top, childW, childH);
    final childPaint = Paint()
      ..shader = const LinearGradient(
        colors: [_kAccentCyan, _kAccentGreen],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(childRect);
    canvas.drawRRect(
      RRect.fromRectAndRadius(childRect, const Radius.circular(6)),
      childPaint,
    );

    final txt = TextPainter(
      text: const TextSpan(
        text: 'child',
        style: TextStyle(
            color: Color(0xFF0E1322),
            fontSize: 12,
            fontWeight: FontWeight.w700),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    txt.paint(
      canvas,
      Offset(
        childRect.left + (childRect.width - txt.width) / 2,
        childRect.top + (childRect.height - txt.height) / 2,
      ),
    );

    final parentLabel = TextPainter(
      text: const TextSpan(
        text: 'parent (RenderShiftedBox)',
        style: TextStyle(
            color: _kAccentBlue,
            fontSize: 11,
            fontWeight: FontWeight.w600),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    parentLabel.paint(canvas, Offset(parent.left + 6, parent.top + 4));

    final padLabel = TextPainter(
      text: const TextSpan(
        text: 'padding insets',
        style: TextStyle(
            color: _kAccentPurple,
            fontSize: 10,
            fontWeight: FontWeight.w600),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    padLabel.paint(canvas, Offset(innerRect.left + 4, innerRect.top - 14));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ---------------------------------------------------------------------------
// Section: 1 — Pipeline overview
// ---------------------------------------------------------------------------

Widget _buildPipelineSection() {
  return Container(
    padding: const EdgeInsets.all(22),
    decoration: _cardA(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader('01 // PIPELINE',
            'Widget Tree -> Element Tree -> Render Tree'),
        _prose(
            'Every Flutter app builds three parallel trees. The widget tree '
            'is the immutable description that you write in build() methods. '
            'The element tree is the mutable bookkeeping layer; each Element '
            'wraps a widget instance and tracks its parent/child relations '
            'and lifecycle. The render tree is where layout, painting, and '
            'hit-testing actually happen — and its root, attached to the '
            'FlutterView by the RendererBinding, is the RenderView.'),
        _prose(
            'The RenderView is special: it does not measure itself by '
            'asking a parent for constraints. Instead it is given the '
            'physical viewConfiguration of the FlutterView (size, devicePixelRatio) '
            'and forwards a tight BoxConstraints to its single child. From '
            'there, every subsequent constraint flows down and every size '
            'flows back up, exactly as a classical box layout works.'),
        const SizedBox(height: 14),
        SizedBox(
          height: 180,
          child: CustomPaint(
            painter: const _PipelinePainter(),
            size: Size.infinite,
          ),
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _chip('RendererBinding', _kAccentBlue),
            _chip('FlutterView', _kAccentCyan),
            _chip('PipelineOwner', _kAccentPurple),
            _chip('RenderView', _kAccentAmber),
            _chip('Element', _kAccentPink),
            _chip('Widget', _kAccentGreen),
          ],
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section: 2 — RenderView anatomy
// ---------------------------------------------------------------------------

Widget _buildRenderViewSection() {
  return Container(
    padding: const EdgeInsets.all(22),
    decoration: _cardB(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader('02 // ROOT', 'RenderView — top of the render tree'),
        _prose(
            'RenderView is the single render object that knows about the '
            'physical output surface. Conceptually it does three jobs: it '
            'owns a Layer tree root (TransformLayer / OffsetLayer) into '
            'which paint operations are composited; it owns the root '
            'PipelineOwner that schedules layout, paint, and semantics '
            'phases; and it exposes a tight BoxConstraints to its single '
            'child equal to the FlutterView size.'),
        _prose(
            'Because RenderView is created by the binding, you almost never '
            'construct one yourself. Tests, headless renderers, and screenshot '
            'pipelines may construct a RenderView attached to a custom '
            'FlutterView, but in app code its existence is invisible — every '
            'MaterialApp is implicitly hosted by one.'),
        const SizedBox(height: 14),
        Stack(
          children: [
            Container(
              height: 220,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF1B2347), Color(0xFF0F1730)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _kRule),
              ),
            ),
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Container(
                  decoration: _accentGradient(
                      const [_kAccentAmber, Color(0xFFFF8A65)]),
                  child: Stack(
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(10, 6, 0, 0),
                        child: Text('RenderView',
                            style: TextStyle(
                                color: Color(0xFF0E1322),
                                fontWeight: FontWeight.w800,
                                fontSize: 13)),
                      ),
                      Positioned.fill(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 28, 20, 20),
                          child: Container(
                            decoration: _accentGradient(
                                const [_kAccentPurple, _kAccentBlue]),
                            child: Stack(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.fromLTRB(10, 6, 0, 0),
                                  child: Text('RenderConstrainedBox',
                                      style: TextStyle(
                                          color: _kInk,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 12)),
                                ),
                                Positioned.fill(
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 28, 20, 20),
                                    child: Container(
                                      decoration: _accentGradient(
                                          const [_kAccentCyan, _kAccentGreen]),
                                      alignment: Alignment.center,
                                      child: const Text(
                                          'child render subtree',
                                          style: TextStyle(
                                              color: Color(0xFF0E1322),
                                              fontWeight: FontWeight.w700)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _proseDim(
            'Each frame, the binding asks the PipelineOwner to flush layout, '
            'compositing bits, paint, and semantics. The RenderView starts '
            'these traversals at the top of the tree, and the Layer tree it '
            'owns is the one ultimately shipped to the GPU compositor.'),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section: 3 — Viewport stack
// ---------------------------------------------------------------------------

Widget _buildViewportStackSection() {
  return Container(
    padding: const EdgeInsets.all(22),
    decoration: _cardA(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader('03 // VIEWPORT',
            'RenderViewport — a window onto a tall child'),
        _prose(
            'A RenderViewport is the render object behind every scrollable '
            'list. It has a fixed extent in the main axis (determined by '
            'incoming constraints), but it grants its child slivers an '
            'infinite scrollExtent. The viewport then paints only the slice '
            'currently visible, offsetting it by ViewportOffset.pixels. '
            'Conceptually, it is a fixed window sliding over a tall painted '
            'world.'),
        const SizedBox(height: 14),
        StatefulBuilder(
          builder: (context, setLocal) {
            return _ViewportStackInteractive();
          },
        ),
        const SizedBox(height: 12),
        _proseDim(
            'The diagram shows the viewport (left) revealing a slice of the '
            'child (right). The two dotted connectors illustrate the '
            'mapping from the visible window edges into child-space. Slide '
            'the offset to see what pixel range the viewport currently '
            'shows.'),
      ],
    ),
  );
}

class _ViewportStackInteractive extends StatefulWidget {
  @override
  State<_ViewportStackInteractive> createState() =>
      _ViewportStackInteractiveState();
}

class _ViewportStackInteractiveState
    extends State<_ViewportStackInteractive> {
  double frac = 0.2;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 200,
          child: CustomPaint(
            painter: _ViewportStackPainter(offsetFrac: frac),
            size: Size.infinite,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Text('ViewportOffset.fixed →',
                style: TextStyle(color: _kInkDim, fontSize: 12)),
            Expanded(
              child: Slider(
                value: frac,
                min: 0,
                max: 1,
                activeColor: _kAccentCyan,
                inactiveColor: _kRule,
                onChanged: (v) => setState(() => frac = v),
              ),
            ),
            Text('${(frac * 1000).toStringAsFixed(0)} px',
                style: const TextStyle(color: _kInk, fontSize: 12)),
          ],
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Section: 4 — ViewportOffset
// ---------------------------------------------------------------------------

Widget _buildViewportOffsetSection() {
  return Container(
    padding: const EdgeInsets.all(22),
    decoration: _cardB(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader(
            '04 // OFFSET', 'ViewportOffset — the scroll coordinate'),
        _prose(
            'ViewportOffset is a Listenable whose .pixels value drives the '
            'main-axis translation of a viewport. A ScrollPosition is the '
            'most common production implementation: it derives pixels from '
            'user gestures, ballistic simulations, and programmatic '
            'animations. For testing and static rendering, '
            'ViewportOffset.fixed(value) and ViewportOffset.zero() are '
            'sufficient.'),
        const SizedBox(height: 12),
        StatefulBuilder(
          builder: (context, setLocal) {
            return _OffsetExplorer();
          },
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: _codeDeco(),
          child: const Text(
            'final fixed = ViewportOffset.fixed(120.0);\n'
            'final zero  = ViewportOffset.zero();\n\n'
            '// pixels increases as the user scrolls down.\n'
            '// Listeners are notified each time pixels changes.\n'
            'offset.addListener(() => print(offset.pixels));',
            style: _kMono,
          ),
        ),
      ],
    ),
  );
}

class _OffsetExplorer extends StatefulWidget {
  @override
  State<_OffsetExplorer> createState() => _OffsetExplorerState();
}

class _OffsetExplorerState extends State<_OffsetExplorer> {
  double pixels = 240.0;
  static const double max = 1000.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 64,
          child: CustomPaint(
            painter: _OffsetAxisPainter(value: pixels, maxV: max),
            size: Size.infinite,
          ),
        ),
        Slider(
          value: pixels,
          min: 0,
          max: max,
          activeColor: _kAccentPurple,
          inactiveColor: _kRule,
          onChanged: (v) => setState(() => pixels = v),
        ),
        Row(
          children: [
            _chip('hasPixels=true', _kAccentGreen),
            const SizedBox(width: 6),
            _chip(
              'userScrollDirection=idle',
              _kAccentAmber,
            ),
            const SizedBox(width: 6),
            _chip('allowImplicitScrolling=false', _kAccentBlue),
          ],
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Section: 5 — Shifted box family
// ---------------------------------------------------------------------------

Widget _buildShiftedBoxSection() {
  return Container(
    padding: const EdgeInsets.all(22),
    decoration: _cardA(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader('05 // SHIFT',
            'RenderShiftedBox — single-child positioned containers'),
        _prose(
            'RenderShiftedBox is the abstract base for render objects that '
            'lay out a single child and then position it at some offset. '
            'Concrete subclasses include RenderPadding (insets the child by '
            'an EdgeInsets), RenderAligned (positions the child using an '
            'Alignment), RenderConstrainedOverflowBox, RenderBaseline, and '
            'RenderShiftedBox-derived layout primitives used internally by '
            'Material widgets.'),
        const SizedBox(height: 14),
        SizedBox(
          height: 200,
          child: CustomPaint(
            painter: const _ShiftedBoxPainter(),
            size: Size.infinite,
          ),
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: _codeDeco(),
          child: const Text(
            '// Subclasses position one child inside their own box.\n'
            'class MyShiftedBox extends RenderShiftedBox {\n'
            '  MyShiftedBox(super.child);\n'
            '  @override\n'
            '  void performLayout() {\n'
            '    child!.layout(constraints.loosen(), parentUsesSize: true);\n'
            '    size = constraints.constrain(child!.size);\n'
            '    final p = child!.parentData! as BoxParentData;\n'
            '    p.offset = Offset(8, 8); // shift child\n'
            '  }\n'
            '}',
            style: _kMono,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section: 6 — Proxy box
// ---------------------------------------------------------------------------

Widget _buildProxyBoxSection() {
  return Container(
    padding: const EdgeInsets.all(22),
    decoration: _cardB(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader('06 // PROXY',
            'RenderProxyBox — transparent single-child wrappers'),
        _prose(
            'A RenderProxyBox forwards all layout, hit-testing, and paint '
            'behavior to its single child. By default it adopts the child\'s '
            'size and paints the child at the origin — meaning a bare '
            'RenderProxyBox is logically invisible. Real subclasses override '
            'one or two methods to add a behavior: opacity, clipping, '
            'transforms, repaint boundaries, semantics annotations, pointer '
            'transformers, and so on.'),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            _proxyTile('RenderOpacity', _kAccentCyan,
                'multiplies alpha while painting'),
            _proxyTile('RenderClipRect', _kAccentPurple,
                'clips child to a rectangle'),
            _proxyTile('RenderTransform', _kAccentAmber,
                'applies a Matrix4 in paint'),
            _proxyTile('RenderRepaintBoundary', _kAccentGreen,
                'caches the child layer'),
            _proxyTile('RenderSemanticsAnnotations', _kAccentPink,
                'adds Semantics info'),
            _proxyTile('RenderPointerListener', _kAccentBlue,
                'observes pointer events'),
          ],
        ),
        const SizedBox(height: 14),
        _proseDim(
            'Proxy boxes are the workhorses of the framework. When you see '
            'a Container with padding, alignment, decoration, foreground '
            'decoration, transform, clip, and child, you are actually '
            'looking at a small stack of proxy boxes built around a single '
            'render leaf.'),
      ],
    ),
  );
}

Widget _proxyTile(String title, Color color, String body) {
  return SizedBox(
    width: 230,
    child: Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(80, color.red, color.green, color.blue),
            Color.fromARGB(20, color.red, color.green, color.blue),
          ],
        ),
        border: Border.all(color: color, width: 1),
        boxShadow: [
          BoxShadow(
            color:
                Color.fromARGB(60, color.red, color.green, color.blue),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w700,
                fontSize: 13,
              )),
          const SizedBox(height: 4),
          Text(body, style: _kBodyDim),
        ],
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Section: 7 — Scrollable container decision table
// ---------------------------------------------------------------------------

Widget _buildDecisionTableSection() {
  TextStyle h() => const TextStyle(
        color: _kAccentCyan,
        fontWeight: FontWeight.w700,
        fontSize: 12,
      );
  TextStyle b() => const TextStyle(color: _kInk, fontSize: 12);
  return Container(
    padding: const EdgeInsets.all(22),
    decoration: _cardA(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader('07 // DECIDE',
            'When to use which scrollable container'),
        _prose(
            'Flutter ships several widgets that sit on top of RenderViewport. '
            'Choosing the right one matters more for performance than for '
            'features: SingleChildScrollView builds its entire child eagerly, '
            'while ListView and CustomScrollView lazily build only what is '
            'inside the cache extent. The table below summarises the '
            'practical trade-offs.'),
        const SizedBox(height: 14),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF0F1730),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _kRule),
          ),
          child: Theme(
            data: ThemeData.dark(),
            child: DataTable(
              headingRowColor:
                  WidgetStateProperty.all(const Color(0xFF1A2238)),
              dataRowColor:
                  WidgetStateProperty.all(const Color(0xFF131A33)),
              columnSpacing: 18,
              columns: [
                DataColumn(label: Text('Widget', style: h())),
                DataColumn(label: Text('Underlying Viewport', style: h())),
                DataColumn(label: Text('Lazy?', style: h())),
                DataColumn(label: Text('Best for', style: h())),
              ],
              rows: [
                DataRow(cells: [
                  DataCell(Text('SingleChildScrollView', style: b())),
                  DataCell(Text('RenderShrinkWrappingViewport', style: b())),
                  DataCell(Text('No', style: b())),
                  DataCell(
                      Text('Short content larger than the screen', style: b())),
                ]),
                DataRow(cells: [
                  DataCell(Text('ListView', style: b())),
                  DataCell(Text('RenderViewport + RenderSliverList', style: b())),
                  DataCell(Text('Yes', style: b())),
                  DataCell(Text('Linear lists of items', style: b())),
                ]),
                DataRow(cells: [
                  DataCell(Text('GridView', style: b())),
                  DataCell(Text('RenderViewport + RenderSliverGrid', style: b())),
                  DataCell(Text('Yes', style: b())),
                  DataCell(Text('2D grids of fixed-shape items', style: b())),
                ]),
                DataRow(cells: [
                  DataCell(Text('CustomScrollView', style: b())),
                  DataCell(Text('RenderViewport', style: b())),
                  DataCell(Text('Yes', style: b())),
                  DataCell(Text('Mixed slivers (app bars + lists)', style: b())),
                ]),
                DataRow(cells: [
                  DataCell(Text('NestedScrollView', style: b())),
                  DataCell(Text('Outer + inner RenderViewport', style: b())),
                  DataCell(Text('Yes', style: b())),
                  DataCell(Text('Collapsing headers over inner scroll',
                      style: b())),
                ]),
                DataRow(cells: [
                  DataCell(Text('PageView', style: b())),
                  DataCell(Text('RenderViewport (axis = horizontal)',
                      style: b())),
                  DataCell(Text('Yes', style: b())),
                  DataCell(Text('Paged horizontal layouts', style: b())),
                ]),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section: 8 — Live mini viewport
// ---------------------------------------------------------------------------

Widget _buildLiveViewportSection() {
  return Container(
    padding: const EdgeInsets.all(22),
    decoration: _cardB(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader('08 // LIVE',
            'A real SingleChildScrollView (rendered to scale)'),
        _prose(
            'Below is a real, working SingleChildScrollView. It is bounded '
            'by a fixed height, and inside it sits a Column that is much '
            'taller than the viewport. Notice that you can scroll inside '
            'this region even though the outer page also scrolls — the '
            'inner Scrollable has its own Scrollable widget and therefore '
            'its own ViewportOffset.'),
        const SizedBox(height: 14),
        Container(
          height: 220,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: const LinearGradient(
              colors: [Color(0xFF0F1730), Color(0xFF1B2247)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(color: _kRule),
            boxShadow: const [
              BoxShadow(
                color: Color(0x55000000),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.all(8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(24, (i) {
                  final hue = (i * 18) % 360;
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      gradient: LinearGradient(
                        colors: [
                          HSVColor.fromAHSV(1, hue.toDouble(), 0.5, 0.6)
                              .toColor(),
                          HSVColor.fromAHSV(
                                  1, (hue + 40) % 360.0, 0.4, 0.45)
                              .toColor(),
                        ],
                      ),
                    ),
                    child: Text(
                      'Inner row #${i + 1} — RenderSliverList child',
                      style: const TextStyle(
                        color: _kInk,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        _proseDim(
            'Internally, this widget composes a Scrollable around a '
            'RenderShrinkWrappingViewport with a single sliver wrapping the '
            'Column. The Scrollable produces ViewportOffset values that the '
            'RenderViewport consumes during paint.'),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section: 9 — CustomScrollView with slivers
// ---------------------------------------------------------------------------

Widget _buildSliverDemoSection() {
  return Container(
    padding: const EdgeInsets.all(22),
    decoration: _cardA(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader(
            '09 // SLIVERS', 'CustomScrollView — viewport over slivers'),
        _prose(
            'CustomScrollView is the most general scrollable: it places a '
            'RenderViewport above a list of slivers, each of which is a '
            'RenderSliver subclass with its own SliverGeometry and '
            'SliverConstraints. Slivers do not deal in BoxConstraints '
            'directly; they speak to each other in terms of scrollOffset, '
            'remainingPaintExtent, and overlap. A single RenderViewport '
            'orchestrates them by walking the sliver list with its '
            'ViewportOffset.'),
        const SizedBox(height: 14),
        Container(
          height: 280,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: const LinearGradient(
              colors: [Color(0xFF101935), Color(0xFF1E284C)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(color: _kRule),
          ),
          padding: const EdgeInsets.all(8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    height: 56,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: _accentGradient(
                        const [_kAccentCyan, _kAccentBlue]),
                    child: const Text(
                      'SliverToBoxAdapter — a single box sliver',
                      style: TextStyle(
                          color: Color(0xFF0E1322),
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(8),
                  sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 2.4,
                      crossAxisSpacing: 6,
                      mainAxisSpacing: 6,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, i) {
                        final hue = (i * 30) % 360;
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            gradient: LinearGradient(
                              colors: [
                                HSVColor.fromAHSV(
                                        1, hue.toDouble(), 0.6, 0.7)
                                    .toColor(),
                                HSVColor.fromAHSV(
                                        1, (hue + 30) % 360.0, 0.5, 0.55)
                                    .toColor(),
                              ],
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text('g$i',
                              style: const TextStyle(
                                  color: _kInk,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 11)),
                        );
                      },
                      childCount: 12,
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, i) {
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 3),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(
                                  220, 30 + i * 8, 50, 90 + i * 4),
                              Color.fromARGB(
                                  220, 60 + i * 4, 80, 120 + i * 2),
                            ],
                          ),
                        ),
                        child: Text('SliverList row #$i',
                            style: const TextStyle(
                                color: _kInk,
                                fontWeight: FontWeight.w600,
                                fontSize: 12)),
                      );
                    },
                    childCount: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        _proseDim(
            'Three slivers feed the viewport: a box adapter, a grid, and a '
            'list. The viewport assigns them sliver constraints in order '
            'and stacks their painted output along the main axis. Each '
            'sliver returns a SliverGeometry that tells the viewport how '
            'much main-axis extent it consumed and how much it contributed '
            'to the cache extent.'),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section: 10 — Code snippet card (binding hookup)
// ---------------------------------------------------------------------------

Widget _buildBindingCodeSection() {
  return Container(
    padding: const EdgeInsets.all(22),
    decoration: _cardB(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader('10 // BINDING',
            'How the RendererBinding wires the RenderView'),
        _prose(
            'You usually never see this code, but it is worth knowing what '
            'runApp() does under the hood. The widget binding ensures a '
            'RenderView exists, attaches it to a PipelineOwner, and pumps '
            'a frame. Schematically it looks like the snippet below — the '
            'production version is more careful, but the structure is the '
            'same.'),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: _codeDeco(),
          child: const Text(
            '''class RendererBinding extends BindingBase {
  late final PipelineOwner pipelineOwner;
  late final RenderView renderView;

  void initInstances() {
    super.initInstances();
    pipelineOwner = PipelineOwner(
      onNeedVisualUpdate: ensureVisualUpdate,
    );
    renderView = RenderView(
      configuration: createViewConfiguration(),
      view: platformDispatcher.implicitView!,
    );
    pipelineOwner.rootNode = renderView;
    renderView.prepareInitialFrame();
  }

  void drawFrame() {
    pipelineOwner.flushLayout();
    pipelineOwner.flushCompositingBits();
    pipelineOwner.flushPaint();
    renderView.compositeFrame();
    pipelineOwner.flushSemantics();
  }
}''',
            style: _kMono,
          ),
        ),
        const SizedBox(height: 10),
        _proseDim(
            'Notice that drawFrame() is exactly the classical four-phase '
            'pipeline: layout → compositing bits → paint → semantics. The '
            'RenderView coordinates compositing on the GPU thread via '
            'compositeFrame(), which submits its Layer tree to the '
            'Flutter engine.'),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section: 11 — Wrap palette of related types
// ---------------------------------------------------------------------------

Widget _buildPaletteSection() {
  Widget palettePill(String label, List<Color> grad) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(colors: grad),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(60, grad.last.red, grad.last.green,
                grad.last.blue),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Text(label,
          style: const TextStyle(
            color: Color(0xFF0E1322),
            fontSize: 12,
            fontWeight: FontWeight.w700,
          )),
    );
  }

  return Container(
    padding: const EdgeInsets.all(22),
    decoration: _cardA(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader('11 // PALETTE',
            'Related rendering types you should recognise'),
        _prose(
            'The rendering library is large, but the view layer is anchored '
            'by a small cluster of types you should be able to name on '
            'sight. The palette below groups them by responsibility: roots '
            'and bindings, viewports and offsets, single-child wrappers, '
            'and sliver layout.'),
        const SizedBox(height: 14),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            palettePill(
                'RenderView', const [_kAccentAmber, Color(0xFFFF8A65)]),
            palettePill('PipelineOwner',
                const [_kAccentPurple, _kAccentPink]),
            palettePill('RendererBinding',
                const [_kAccentBlue, _kAccentCyan]),
            palettePill('FlutterView',
                const [_kAccentCyan, _kAccentGreen]),
            palettePill('RenderViewport',
                const [_kAccentPurple, _kAccentBlue]),
            palettePill('RenderShrinkWrappingViewport',
                const [_kAccentBlue, _kAccentAmber]),
            palettePill('ViewportOffset',
                const [_kAccentGreen, _kAccentCyan]),
            palettePill('ScrollPosition',
                const [_kAccentPink, _kAccentPurple]),
            palettePill('RenderProxyBox',
                const [_kAccentBlue, _kAccentGreen]),
            palettePill('RenderShiftedBox',
                const [_kAccentAmber, _kAccentPink]),
            palettePill('RenderSliver',
                const [_kAccentCyan, _kAccentAmber]),
            palettePill('RenderSliverList',
                const [_kAccentPink, _kAccentCyan]),
          ],
        ),
        const SizedBox(height: 14),
        _proseDim(
            'These types form a small, learnable surface area. Once you can '
            'sketch the relationship between RenderView, PipelineOwner, '
            'RenderViewport, and ViewportOffset, the rest of the rendering '
            'library is mostly a collection of specialised proxy and '
            'shifted boxes.'),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section: 12 — API reference card
// ---------------------------------------------------------------------------

Widget _buildReferenceCard() {
  TextStyle h() => const TextStyle(
        color: _kAccentAmber,
        fontWeight: FontWeight.w700,
        fontSize: 12,
      );
  TextStyle b() => const TextStyle(
        color: _kInk,
        fontSize: 12,
        fontFamily: 'monospace',
      );

  return Container(
    padding: const EdgeInsets.all(22),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(18),
      gradient: const LinearGradient(
        colors: [Color(0xFF1A2347), Color(0xFF272E54)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      border: Border.all(color: _kRule),
      boxShadow: const [
        BoxShadow(
          color: Color(0x66000000),
          blurRadius: 22,
          offset: Offset(0, 12),
        ),
        BoxShadow(
          color: Color(0x33FFC857),
          blurRadius: 6,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader('12 // REFERENCE', 'View-layer API summary'),
        _prose(
            'A compact lookup table for the classes covered in this demo. '
            'Each row names the symbol, the file it lives in (within the '
            'Flutter SDK), and the responsibility it carries. Use this as '
            'a study aid when reading framework sources or test code.'),
        const SizedBox(height: 14),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF0F1730),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _kRule),
          ),
          child: Theme(
            data: ThemeData.dark(),
            child: DataTable(
              headingRowColor:
                  WidgetStateProperty.all(const Color(0xFF1A2238)),
              dataRowColor:
                  WidgetStateProperty.all(const Color(0xFF131A33)),
              columnSpacing: 14,
              columns: [
                DataColumn(label: Text('Symbol', style: h())),
                DataColumn(label: Text('Library', style: h())),
                DataColumn(label: Text('Role', style: h())),
              ],
              rows: [
                DataRow(cells: [
                  DataCell(Text('RenderView', style: b())),
                  DataCell(Text('rendering/view.dart', style: b())),
                  DataCell(Text('Root render object; owns layer tree',
                      style: b())),
                ]),
                DataRow(cells: [
                  DataCell(Text('PipelineOwner', style: b())),
                  DataCell(Text('rendering/object.dart', style: b())),
                  DataCell(
                      Text('Schedules layout/paint/semantics phases',
                          style: b())),
                ]),
                DataRow(cells: [
                  DataCell(Text('RendererBinding', style: b())),
                  DataCell(Text('rendering/binding.dart', style: b())),
                  DataCell(Text('Hooks the engine to RenderView',
                      style: b())),
                ]),
                DataRow(cells: [
                  DataCell(Text('RenderViewport', style: b())),
                  DataCell(Text('rendering/viewport.dart', style: b())),
                  DataCell(Text('Window onto a sliver subtree',
                      style: b())),
                ]),
                DataRow(cells: [
                  DataCell(Text('RenderShrinkWrappingViewport',
                      style: b())),
                  DataCell(Text('rendering/viewport.dart', style: b())),
                  DataCell(
                      Text('Viewport sized to its sliver content',
                          style: b())),
                ]),
                DataRow(cells: [
                  DataCell(Text('RenderAbstractViewport', style: b())),
                  DataCell(Text('rendering/viewport.dart', style: b())),
                  DataCell(Text(
                      'Abstract base for viewport implementations',
                      style: b())),
                ]),
                DataRow(cells: [
                  DataCell(Text('ViewportOffset', style: b())),
                  DataCell(Text('rendering/viewport_offset.dart',
                      style: b())),
                  DataCell(Text('Listenable scroll position abstraction',
                      style: b())),
                ]),
                DataRow(cells: [
                  DataCell(Text('RenderProxyBox', style: b())),
                  DataCell(Text('rendering/proxy_box.dart', style: b())),
                  DataCell(Text(
                      'Forwarding wrapper for single-child overrides',
                      style: b())),
                ]),
                DataRow(cells: [
                  DataCell(Text('RenderShiftedBox', style: b())),
                  DataCell(Text('rendering/shifted_box.dart', style: b())),
                  DataCell(
                      Text('Positions one child at an offset',
                          style: b())),
                ]),
                DataRow(cells: [
                  DataCell(Text('RenderSliver', style: b())),
                  DataCell(Text('rendering/sliver.dart', style: b())),
                  DataCell(Text(
                      'Base for sliver-protocol render objects',
                      style: b())),
                ]),
              ],
            ),
          ),
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: _codeDeco(),
          child: const Text(
            '// One-line glossary\n'
            'RenderView          — root of the render tree.\n'
            'PipelineOwner       — schedules layout/paint/semantics.\n'
            'RendererBinding     — engine <-> render-tree glue.\n'
            'RenderViewport      — windowed view over slivers.\n'
            'ViewportOffset      — scroll coordinate (Listenable).\n'
            'RenderProxyBox      — single-child forwarding render box.\n'
            'RenderShiftedBox    — single-child positioned render box.',
            style: _kMono,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section: 13 — Hit-testing & semantics (extra context)
// ---------------------------------------------------------------------------

Widget _buildHitTestSection() {
  return Container(
    padding: const EdgeInsets.all(22),
    decoration: _cardA(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader(
            '13 // HIT-TEST', 'How the render tree resolves a tap'),
        _prose(
            'When a pointer event arrives at the engine, the RendererBinding '
            'hands it to the GestureBinding, which asks the RenderView to '
            'perform a hit-test from the root. The RenderView walks down '
            'the render tree, transforming the pointer position into each '
            'child\'s coordinate space until it reaches a leaf. Proxy boxes '
            'usually pass through; shifted boxes adjust by their offset; '
            'and Viewports translate the y-coordinate by their offset.pixels.'),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: _codeDeco(),
          child: const Text(
            'flow:\n'
            '  PlatformDispatcher.onPointerDataPacket\n'
            '    -> GestureBinding._handlePointerEvent\n'
            '      -> hitTest(result, position)\n'
            '        RenderView.hitTest -> child render objects\n'
            '          -> BoxHitTestResult.add(BoxHitTestEntry)\n'
            '  -> GestureBinding.dispatchEvent\n'
            '    -> recognisers receive the event chain',
            style: _kMono,
          ),
        ),
        const SizedBox(height: 12),
        _proseDim(
            'A viewport\'s hit-test is special: it translates the pointer '
            'into scroll coordinates using its ViewportOffset before '
            'asking its children. That is why a tap inside a scrolled '
            'ListView correctly addresses the row that visually appears '
            'under the finger, regardless of how far the list has been '
            'scrolled.'),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Top-level build()
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: _kBackground,
      colorScheme: const ColorScheme.dark(
        primary: _kAccentCyan,
        secondary: _kAccentPurple,
        surface: _kCardA,
      ),
      sliderTheme: const SliderThemeData(
        showValueIndicator: ShowValueIndicator.never,
      ),
    ),
    home: Scaffold(
      backgroundColor: _kBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Banner
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(24, 26, 24, 26),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF21305C),
                      Color(0xFF3A2657),
                      Color(0xFF182040),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  border: Border.all(color: _kRule),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x66000000),
                      blurRadius: 24,
                      offset: Offset(0, 12),
                    ),
                    BoxShadow(
                      color: Color(0x55B388FF),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('FLUTTER RENDERING',
                        style: TextStyle(
                          color: _kAccentAmber,
                          letterSpacing: 2.4,
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                        )),
                    const SizedBox(height: 8),
                    const Text(
                      'The View Layer of the Render Tree',
                      style: TextStyle(
                        color: _kInk,
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        height: 1.1,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'RenderView, RenderViewport, ViewportOffset, '
                      'RenderShiftedBox and RenderProxyBox — a static, '
                      'illustrated tour of the rendering pipeline\'s root.',
                      style: _kBodyDim,
                    ),
                    const SizedBox(height: 14),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _chip('static demo', _kAccentCyan),
                        _chip('no live RenderObjects', _kAccentPurple),
                        _chip('analyzer-clean', _kAccentGreen),
                        _chip('Tom D4rt flutter_ast corpus', _kAccentAmber),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              _buildPipelineSection(),
              const SizedBox(height: 18),
              _buildRenderViewSection(),
              const SizedBox(height: 18),
              _buildViewportStackSection(),
              const SizedBox(height: 18),
              _buildViewportOffsetSection(),
              const SizedBox(height: 18),
              _buildShiftedBoxSection(),
              const SizedBox(height: 18),
              _buildProxyBoxSection(),
              const SizedBox(height: 18),
              _buildDecisionTableSection(),
              const SizedBox(height: 18),
              _buildLiveViewportSection(),
              const SizedBox(height: 18),
              _buildSliverDemoSection(),
              const SizedBox(height: 18),
              _buildBindingCodeSection(),
              const SizedBox(height: 18),
              _buildPaletteSection(),
              const SizedBox(height: 18),
              _buildHitTestSection(),
              const SizedBox(height: 18),
              _buildReferenceCard(),
              const SizedBox(height: 28),
              Center(
                child: Text(
                  'end of demo — RenderView is where the pipeline begins',
                  style: _kBodyDim.copyWith(fontStyle: FontStyle.italic),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    ),
  );
}
