// ignore_for_file: avoid_print
// D4rt deep visual demo: the "three-mixin RenderObject relayout container"
// pattern from Flutter's rendering layer.
//
// This file is a hand-authored corpus entry for the D4rt flutter-test pipeline.
// It does NOT exercise the interpreter's RenderObject bridges directly; the
// sandboxed interpreter cannot host real RenderBox subclasses (they require a
// PipelineOwner / vsync / BuildOwner machinery). Instead this script renders a
// large, instructive POSTER that visually explains the pattern that
// `repro_fa6` is built around: a RenderBox composed from THREE orthogonal
// mixins, hosting a relayout-boundary-style container.
//
// Sections in this poster:
//   1. Intro card — what a "relayout container" is, what a RelayoutBoundary
//      means in Flutter's rendering pipeline, how mixins compose RenderBox.
//   2. Pipeline diagram — needsLayout → markNeedsLayout → relayout boundary
//      → layout() → size → paint, with the boundary annotated.
//   3. Three-mixin composition diagram — three stacked mixins above a
//      RenderBox base, each with a description label.
//   4. Three concrete usage cards — STATIC visual mockups of what the
//      three-mixin RO output looks like (no real RenderObject subclasses).
//   5. Theory cards — what causes a relayout, depth-first vs depth-aware.
//   6. Pitfalls — markNeedsLayout, reading sizes during paint, parentData
//      type mismatches.
//   7. Code-block sample cards — idiomatic RenderBox mixin composition,
//      rendered as styled Text (no execution).
//   8. Gallery — 4–6 static visual cards each showing what a three-mixin
//      RenderObject's output would look like.
//
// d4rt constraints respected:
//   * Top-level `dynamic build(BuildContext context)` returning a Widget,
//     called exactly once by the test harness.
//   * No setState. No real custom RenderObject subclasses. No Timer / Future
//     / AnimationController. 100% static.
//   * No inline `// ignore:` comments. One file-level ignore header above.
//   * `const` is dropped from any list that contains a non-const child.
//   * Only `flutter/material.dart`, `flutter/widgets.dart`,
//     `flutter/painting.dart`, `flutter/foundation.dart`,
//     `flutter/rendering.dart`, `dart:math`, `dart:ui` are imported.
//   * Helper widgets and painters are private.

import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────────────────
// Palette + constants for the poster.
// ─────────────────────────────────────────────────────────────────────────

const Color _bgTop = Color(0xFF0B132B);
const Color _bgBottom = Color(0xFF1C2541);
const Color _cardBg = Color(0xFF1F2A44);
const Color _cardEdge = Color(0xFF3A506B);
const Color _accentA = Color(0xFF5BC0BE);
const Color _accentB = Color(0xFF6FFFE9);
const Color _accentWarn = Color(0xFFFFB703);
const Color _accentBad = Color(0xFFE63946);
const Color _ink = Color(0xFFE6EAF2);
const Color _inkDim = Color(0xFFAAB4C8);
const Color _codeBg = Color(0xFF0E1726);
const Color _codeEdge = Color(0xFF2A3A5C);
const Color _mixinA = Color(0xFFEF476F);
const Color _mixinB = Color(0xFFFFD166);
const Color _mixinC = Color(0xFF06D6A0);
const Color _baseBox = Color(0xFF118AB2);

// ─────────────────────────────────────────────────────────────────────────
// Pipeline painter — draws the layout pipeline as a horizontal flow.
//   needsLayout → markNeedsLayout → relayout boundary → layout() → size → paint
// The relayout boundary is highlighted; an arrow loops back to indicate that
// upward propagation stops there.
// ─────────────────────────────────────────────────────────────────────────
class _PipelinePainter extends CustomPainter {
  _PipelinePainter();

  static const List<String> _stages = <String>[
    'needsLayout',
    'markNeedsLayout',
    'RelayoutBoundary',
    'layout()',
    'size',
    'paint()',
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = _codeBg;
    canvas.drawRRect(
      RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(10)),
      bg,
    );

    final double margin = 14;
    final double slotW = (size.width - margin * 2) / _stages.length;
    final double y = size.height * 0.55;
    final double boxH = 38;

    for (int i = 0; i < _stages.length; i++) {
      final double cx = margin + slotW * (i + 0.5);
      final Rect r = Rect.fromCenter(
        center: Offset(cx, y),
        width: slotW - 12,
        height: boxH,
      );
      final bool isBoundary = i == 2;
      final Paint fill = Paint()
        ..color = isBoundary ? _accentWarn : _cardEdge;
      final Paint border = Paint()
        ..color = isBoundary ? _accentBad : _accentA
        ..style = PaintingStyle.stroke
        ..strokeWidth = isBoundary ? 2.2 : 1.4;
      final RRect rr = RRect.fromRectAndRadius(r, const Radius.circular(8));
      canvas.drawRRect(rr, fill);
      canvas.drawRRect(rr, border);

      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: _stages[i],
          style: TextStyle(
            color: isBoundary ? _bgTop : _ink,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
        maxLines: 2,
      );
      tp.layout(maxWidth: slotW - 16);
      tp.paint(
        canvas,
        Offset(cx - tp.width / 2, y - tp.height / 2),
      );

      // Arrow to next.
      if (i < _stages.length - 1) {
        final double ax1 = cx + (slotW - 12) / 2;
        final double ax2 = cx + slotW - (slotW - 12) / 2;
        final Paint arrow = Paint()
          ..color = _accentA
          ..strokeWidth = 1.6
          ..style = PaintingStyle.stroke;
        canvas.drawLine(Offset(ax1, y), Offset(ax2, y), arrow);
        final Path head = Path()
          ..moveTo(ax2, y)
          ..lineTo(ax2 - 6, y - 4)
          ..lineTo(ax2 - 6, y + 4)
          ..close();
        canvas.drawPath(head, Paint()..color = _accentA);
      }
    }

    // Loop-back arrow above the boundary box, indicating "stops here".
    final double cxBoundary = margin + slotW * (2 + 0.5);
    final double topY = y - boxH / 2 - 6;
    final Path loop = Path()
      ..moveTo(cxBoundary - 22, topY)
      ..quadraticBezierTo(
        cxBoundary,
        topY - 28,
        cxBoundary + 22,
        topY,
      );
    canvas.drawPath(
      loop,
      Paint()
        ..color = _accentBad
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.6,
    );
    final Path loopHead = Path()
      ..moveTo(cxBoundary + 22, topY)
      ..lineTo(cxBoundary + 18, topY - 5)
      ..lineTo(cxBoundary + 26, topY - 5)
      ..close();
    canvas.drawPath(loopHead, Paint()..color = _accentBad);

    final TextPainter caption = TextPainter(
      text: const TextSpan(
        text: 'upward markNeedsLayout stops at boundary',
        style: TextStyle(
          color: _accentBad,
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    caption.layout();
    caption.paint(
      canvas,
      Offset(cxBoundary - caption.width / 2, topY - 44),
    );

    // Title.
    final TextPainter title = TextPainter(
      text: const TextSpan(
        text: 'layout pipeline',
        style: TextStyle(
          color: _inkDim,
          fontSize: 10,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.4,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    title.layout();
    title.paint(canvas, Offset(margin, 8));
  }

  @override
  bool shouldRepaint(covariant _PipelinePainter old) => false;
}

// ─────────────────────────────────────────────────────────────────────────
// Mixin-stack painter — draws three stacked mixin "plates" on top of a
// RenderBox base. Each plate has a colored band and a short description.
// ─────────────────────────────────────────────────────────────────────────
class _MixinStackPainter extends CustomPainter {
  _MixinStackPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = _codeBg;
    canvas.drawRRect(
      RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(10)),
      bg,
    );

    final double pad = 18;
    final double plateW = size.width - pad * 2;
    final double plateH = (size.height - pad * 2 - 14) / 4;

    final List<_MixinPlate> plates = <_MixinPlate>[
      _MixinPlate(
        title: 'RenderObjectWithChildMixin<RenderBox>',
        sub: 'adds a single typed child slot + setupParentData hook',
        color: _mixinA,
      ),
      _MixinPlate(
        title: 'RenderProxyBoxMixin',
        sub: 'forwards layout / paint / hit-test to that single child',
        color: _mixinB,
      ),
      _MixinPlate(
        title: 'RelayoutWhenSystemFontsChangeMixin',
        sub: 'subscribes to system-font changes, calls markNeedsLayout',
        color: _mixinC,
      ),
      _MixinPlate(
        title: 'RenderBox  (base)',
        sub: 'BoxConstraints in, Size out — the relayout boundary host',
        color: _baseBox,
      ),
    ];

    for (int i = 0; i < plates.length; i++) {
      final _MixinPlate p = plates[i];
      final double y = pad + i * (plateH + 4);
      final Rect r = Rect.fromLTWH(pad, y, plateW, plateH);
      final RRect rr =
          RRect.fromRectAndRadius(r, const Radius.circular(8));
      final Paint fill = Paint()..color = _cardEdge;
      final Paint band = Paint()..color = p.color;
      canvas.drawRRect(rr, fill);
      // Left color band.
      final Rect bandRect = Rect.fromLTWH(r.left, r.top, 8, r.height);
      canvas.drawRRect(
        RRect.fromRectAndCorners(
          bandRect,
          topLeft: const Radius.circular(8),
          bottomLeft: const Radius.circular(8),
        ),
        band,
      );
      canvas.drawRRect(
        rr,
        Paint()
          ..color = _accentA.withValues(alpha: 0.4)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.1,
      );

      final TextPainter title = TextPainter(
        text: TextSpan(
          text: p.title,
          style: const TextStyle(
            color: _ink,
            fontSize: 12,
            fontWeight: FontWeight.w700,
            fontFamilyFallback: <String>['monospace'],
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      title.layout(maxWidth: plateW - 24);
      title.paint(canvas, Offset(r.left + 18, r.top + 6));

      final TextPainter sub = TextPainter(
        text: TextSpan(
          text: p.sub,
          style: const TextStyle(
            color: _inkDim,
            fontSize: 10.5,
            fontWeight: FontWeight.w500,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      sub.layout(maxWidth: plateW - 24);
      sub.paint(
        canvas,
        Offset(r.left + 18, r.top + 24),
      );
    }

    // Composition arrow on the right.
    final double ax = size.width - pad - 4;
    final Paint axisPaint = Paint()
      ..color = _accentB
      ..strokeWidth = 1.4
      ..style = PaintingStyle.stroke;
    canvas.drawLine(
      Offset(ax, pad + 8),
      Offset(ax, size.height - pad - 8),
      axisPaint,
    );
    final Path tipDown = Path()
      ..moveTo(ax, size.height - pad - 8)
      ..lineTo(ax - 5, size.height - pad - 14)
      ..lineTo(ax + 5, size.height - pad - 14)
      ..close();
    canvas.drawPath(tipDown, Paint()..color = _accentB);

    final TextPainter label = TextPainter(
      text: const TextSpan(
        text: 'with',
        style: TextStyle(
          color: _accentB,
          fontSize: 9.5,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.6,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    label.layout();
    canvas.save();
    canvas.translate(ax + 4, size.height / 2);
    canvas.rotate(math.pi / 2);
    label.paint(canvas, Offset(-label.width / 2, -label.height / 2));
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _MixinStackPainter old) => false;
}

class _MixinPlate {
  const _MixinPlate({
    required this.title,
    required this.sub,
    required this.color,
  });
  final String title;
  final String sub;
  final Color color;
}

// ─────────────────────────────────────────────────────────────────────────
// Relayout-boundary diagram painter — shows a tree of render objects, with
// one node highlighted as the boundary. markNeedsLayout originates from a
// leaf and propagates up, stopping at the boundary.
// ─────────────────────────────────────────────────────────────────────────
class _BoundaryTreePainter extends CustomPainter {
  _BoundaryTreePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = _codeBg;
    canvas.drawRRect(
      RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(10)),
      bg,
    );

    // Nodes: id -> (x, y, label, isBoundary).
    final List<_TreeNode> nodes = <_TreeNode>[
      _TreeNode(id: 0, x: 0.5, y: 0.18, label: 'View', boundary: false),
      _TreeNode(id: 1, x: 0.3, y: 0.38, label: 'Scaffold', boundary: false),
      _TreeNode(id: 2, x: 0.7, y: 0.38, label: 'Overlay', boundary: false),
      _TreeNode(
        id: 3,
        x: 0.2,
        y: 0.6,
        label: 'ThreeMixin RO',
        boundary: true,
      ),
      _TreeNode(id: 4, x: 0.45, y: 0.6, label: 'Padding', boundary: false),
      _TreeNode(id: 5, x: 0.7, y: 0.6, label: 'Stack', boundary: false),
      _TreeNode(id: 6, x: 0.2, y: 0.82, label: 'leaf', boundary: false),
      _TreeNode(id: 7, x: 0.45, y: 0.82, label: 'leaf', boundary: false),
      _TreeNode(id: 8, x: 0.7, y: 0.82, label: 'leaf*', boundary: false),
    ];
    final List<List<int>> edges = <List<int>>[
      <int>[0, 1],
      <int>[0, 2],
      <int>[1, 3],
      <int>[1, 4],
      <int>[2, 5],
      <int>[3, 6],
      <int>[4, 7],
      <int>[5, 8],
    ];

    Offset pos(_TreeNode n) => Offset(n.x * size.width, n.y * size.height);

    // Edges first.
    final Paint edgePaint = Paint()
      ..color = _cardEdge
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;
    for (final List<int> e in edges) {
      canvas.drawLine(pos(nodes[e[0]]), pos(nodes[e[1]]), edgePaint);
    }

    // Highlight the upward markNeedsLayout chain: 8 -> 5 -> 2 (stops because
    // the boundary is on the OTHER subtree, but we'll show a parallel chain
    // 7 -> 4 -> 1 stopping at the boundary's PARENT … wait, the boundary IS
    // node 3 which is a sibling. Cleaner: chain 6 -> 3 (stops at boundary).
    final Paint chain = Paint()
      ..color = _accentBad
      ..strokeWidth = 2.4
      ..style = PaintingStyle.stroke;
    canvas.drawLine(pos(nodes[6]), pos(nodes[3]), chain);

    // Nodes.
    for (final _TreeNode n in nodes) {
      final Offset c = pos(n);
      final double r = n.boundary ? 28 : 22;
      final Paint fill = Paint()
        ..color = n.boundary ? _accentWarn : _cardEdge;
      final Paint border = Paint()
        ..color = n.boundary ? _accentBad : _accentA
        ..style = PaintingStyle.stroke
        ..strokeWidth = n.boundary ? 2.4 : 1.2;
      canvas.drawCircle(c, r, fill);
      canvas.drawCircle(c, r, border);

      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: n.label,
          style: TextStyle(
            color: n.boundary ? _bgTop : _ink,
            fontSize: n.boundary ? 10 : 9,
            fontWeight: FontWeight.w700,
          ),
        ),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
        maxLines: 2,
      );
      tp.layout(maxWidth: r * 2 + 8);
      tp.paint(canvas, Offset(c.dx - tp.width / 2, c.dy - tp.height / 2));
    }

    // Caption.
    final TextPainter cap = TextPainter(
      text: const TextSpan(
        text: 'red chain = markNeedsLayout climbing — stops at the boundary',
        style: TextStyle(
          color: _accentBad,
          fontSize: 10.5,
          fontWeight: FontWeight.w600,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    cap.layout(maxWidth: size.width - 16);
    cap.paint(canvas, Offset(12, size.height - 22));

    final TextPainter title = TextPainter(
      text: const TextSpan(
        text: 'relayout boundary in a tree',
        style: TextStyle(
          color: _inkDim,
          fontSize: 10,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.4,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    title.layout();
    title.paint(canvas, const Offset(12, 6));
  }

  @override
  bool shouldRepaint(covariant _BoundaryTreePainter old) => false;
}

class _TreeNode {
  const _TreeNode({
    required this.id,
    required this.x,
    required this.y,
    required this.label,
    required this.boundary,
  });
  final int id;
  final double x;
  final double y;
  final String label;
  final bool boundary;
}

// ─────────────────────────────────────────────────────────────────────────
// Painter that mocks the visual output of a three-mixin RO. Children are
// stacked vertically and each is labeled with mock parentData info.
// ─────────────────────────────────────────────────────────────────────────
class _ThreeMixinMockPainter extends CustomPainter {
  _ThreeMixinMockPainter({
    required this.children,
    required this.label,
  });

  final List<_MockChild> children;
  final String label;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = _codeBg;
    canvas.drawRRect(
      RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(10)),
      bg,
    );

    // Frame line representing the RO size.
    final Rect frame = Rect.fromLTWH(8, 8, size.width - 16, size.height - 26);
    canvas.drawRRect(
      RRect.fromRectAndRadius(frame, const Radius.circular(6)),
      Paint()
        ..color = _accentA.withValues(alpha: 0.45)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0,
    );

    double cursorY = frame.top + 6;
    for (int i = 0; i < children.length; i++) {
      final _MockChild c = children[i];
      final double w = c.width.clamp(20, frame.width - 12);
      final double h = c.height;
      final Rect r = Rect.fromLTWH(frame.left + 8, cursorY, w, h);
      canvas.drawRRect(
        RRect.fromRectAndRadius(r, const Radius.circular(4)),
        Paint()..color = c.color,
      );
      // parent data label
      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: 'offset=(0,${(cursorY - frame.top - 6).toStringAsFixed(0)})',
          style: const TextStyle(
            color: _ink,
            fontSize: 9,
            fontWeight: FontWeight.w600,
            fontFamilyFallback: <String>['monospace'],
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      tp.layout();
      tp.paint(canvas, Offset(r.right + 6, r.top + 2));
      cursorY += h + 4;
    }

    // Footer label.
    final TextPainter footer = TextPainter(
      text: TextSpan(
        text: label,
        style: const TextStyle(
          color: _inkDim,
          fontSize: 10,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.0,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    footer.layout(maxWidth: size.width - 16);
    footer.paint(canvas, Offset(8, size.height - 16));
  }

  @override
  bool shouldRepaint(covariant _ThreeMixinMockPainter old) => false;
}

class _MockChild {
  const _MockChild({
    required this.width,
    required this.height,
    required this.color,
  });
  final double width;
  final double height;
  final Color color;
}

// ─────────────────────────────────────────────────────────────────────────
// Section header.
// ─────────────────────────────────────────────────────────────────────────
class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.tag,
    required this.title,
    required this.subtitle,
  });

  final String tag;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: _accentA.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: _accentA, width: 1),
            ),
            child: Text(
              tag,
              style: const TextStyle(
                color: _accentB,
                fontSize: 10,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.6,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              color: _ink,
              fontSize: 22,
              fontWeight: FontWeight.w800,
              height: 1.15,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(
              color: _inkDim,
              fontSize: 13,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Generic card shell.
// ─────────────────────────────────────────────────────────────────────────
class _Card extends StatelessWidget {
  const _Card({required this.child, this.padding = 14});
  final Widget child;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 6, 20, 6),
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _cardEdge, width: 1),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.30),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Code-block card (styled Text — NOT executed).
// ─────────────────────────────────────────────────────────────────────────
class _CodeBlock extends StatelessWidget {
  const _CodeBlock({required this.code, this.caption});
  final String code;
  final String? caption;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      decoration: BoxDecoration(
        color: _codeBg,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _codeEdge, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (caption != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                caption!,
                style: const TextStyle(
                  color: _accentB,
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.4,
                ),
              ),
            ),
          Text(
            code,
            style: const TextStyle(
              color: _ink,
              fontSize: 12,
              height: 1.45,
              fontFamilyFallback: <String>['monospace', 'Courier'],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Inline pill / chip used in glossary rows.
// ─────────────────────────────────────────────────────────────────────────
class _Pill extends StatelessWidget {
  const _Pill({required this.text, required this.color});
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color, width: 1),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 10.5,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Bullet row.
// ─────────────────────────────────────────────────────────────────────────
class _Bullet extends StatelessWidget {
  const _Bullet({required this.icon, required this.color, required this.text});
  final IconData icon;
  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: _ink,
                fontSize: 13,
                height: 1.42,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Intro card.
// ─────────────────────────────────────────────────────────────────────────
class _IntroCard extends StatelessWidget {
  const _IntroCard();

  @override
  Widget build(BuildContext context) {
    return _Card(
      padding: 18,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const _Pill(text: 'PATTERN', color: _accentA),
              const SizedBox(width: 8),
              const _Pill(text: 'RENDERBOX', color: _mixinB),
              const SizedBox(width: 8),
              const _Pill(text: 'RELAYOUT', color: _mixinC),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'The "three-mixin RenderObject relayout container" is a RenderBox '
            'whose capabilities are assembled by composing THREE orthogonal '
            'mixins on top of the RenderBox base. Each mixin adds one '
            'independent concern: child storage, child delegation, and '
            'relayout triggering.',
            style: TextStyle(color: _ink, fontSize: 13.5, height: 1.5),
          ),
          const SizedBox(height: 10),
          const Text(
            'In Flutter\'s rendering pipeline, a RelayoutBoundary is the node '
            'at which markNeedsLayout stops propagating upward. The boundary '
            'is the smallest subtree the engine is allowed to relay out in '
            'isolation. RenderObjects that always pass through their own '
            'constraints to children — or whose size is uniquely determined '
            'by constraints — qualify as boundaries.',
            style: TextStyle(color: _inkDim, fontSize: 13, height: 1.5),
          ),
          const SizedBox(height: 10),
          const Text(
            'A "relayout container" is the practical realization: a RenderBox '
            'subclass that hosts one or more children, qualifies as a '
            'boundary, and additionally subscribes to external triggers '
            '(e.g. system fonts changing) that need to mark the subtree '
            'dirty without bubbling further up.',
            style: TextStyle(color: _inkDim, fontSize: 13, height: 1.5),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Visual usage mockup card. Uses Stack + Positioned + Container to STATIC-ally
// render what a three-mixin RO's output would look like at frame time.
// ─────────────────────────────────────────────────────────────────────────
class _UsageMockCard extends StatelessWidget {
  const _UsageMockCard({
    required this.title,
    required this.subtitle,
    required this.boxes,
    this.height = 180,
  });

  final String title;
  final String subtitle;
  final List<_MockBox> boxes;
  final double height;

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              color: _ink,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(
              color: _inkDim,
              fontSize: 12,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: height,
            decoration: BoxDecoration(
              color: _codeBg,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _codeEdge, width: 1),
            ),
            child: Stack(
              children: <Widget>[
                for (final _MockBox b in boxes)
                  Positioned(
                    left: b.left,
                    top: b.top,
                    width: b.width,
                    height: b.height,
                    child: Container(
                      decoration: BoxDecoration(
                        color: b.color,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: Colors.black.withValues(alpha: 0.35),
                          width: 0.8,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        b.label,
                        style: const TextStyle(
                          color: _bgTop,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                Positioned(
                  left: 6,
                  bottom: 4,
                  child: Text(
                    'static mockup — no real RenderObject',
                    style: TextStyle(
                      color: _inkDim.withValues(alpha: 0.8),
                      fontSize: 9.5,
                      fontStyle: FontStyle.italic,
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

class _MockBox {
  const _MockBox({
    required this.left,
    required this.top,
    required this.width,
    required this.height,
    required this.color,
    required this.label,
  });
  final double left;
  final double top;
  final double width;
  final double height;
  final Color color;
  final String label;
}

// ─────────────────────────────────────────────────────────────────────────
// Build helpers for the poster sections.
// ─────────────────────────────────────────────────────────────────────────

Widget _buildPipelineDiagram() {
  return _Card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'pipeline: needsLayout → … → paint',
          style: TextStyle(
            color: _ink,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 120,
          child: CustomPaint(
            painter: _PipelinePainter(),
            size: Size.infinite,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'When a node calls markNeedsLayout, the dirty flag travels UP the '
          'tree, but only until it reaches the nearest RelayoutBoundary. The '
          'boundary is what bounds the work the engine has to do per frame.',
          style: TextStyle(color: _inkDim, fontSize: 12.5, height: 1.45),
        ),
      ],
    ),
  );
}

Widget _buildPainterMockCard() {
  return _Card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'painter-based mock: what performLayout assigns',
          style: TextStyle(
            color: _ink,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 180,
          child: CustomPaint(
            painter: _ThreeMixinMockPainter(
              children: const <_MockChild>[
                _MockChild(width: 220, height: 26, color: _mixinA),
                _MockChild(width: 180, height: 26, color: _mixinB),
                _MockChild(width: 240, height: 26, color: _mixinC),
                _MockChild(width: 160, height: 26, color: _baseBox),
              ],
              label: 'performLayout → assign offset → constrain Size',
            ),
            size: Size.infinite,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Each child gets an offset stored in its parentData by the parent '
          'during performLayout. defaultPaint reads those offsets to position '
          'each child during the paint phase.',
          style: TextStyle(color: _inkDim, fontSize: 12.5, height: 1.45),
        ),
      ],
    ),
  );
}

Widget _buildMixinStackDiagram() {
  return _Card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'three-mixin composition over RenderBox',
          style: TextStyle(
            color: _ink,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 220,
          child: CustomPaint(
            painter: _MixinStackPainter(),
            size: Size.infinite,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Each mixin contributes ONE concern. Read top to bottom as the '
          '`with` clause in source order; the base class is the bottom plate. '
          'Each mixin layer is independent — you can swap any one of them '
          'without rewriting the others.',
          style: TextStyle(color: _inkDim, fontSize: 12.5, height: 1.45),
        ),
      ],
    ),
  );
}

Widget _buildBoundaryTreeDiagram() {
  return _Card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'relayout boundary inside a render tree',
          style: TextStyle(
            color: _ink,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 260,
          child: CustomPaint(
            painter: _BoundaryTreePainter(),
            size: Size.infinite,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'The amber node is a relayout boundary. A markNeedsLayout originating '
          'from a leaf bubbles up until it hits the boundary; at that point '
          'the engine schedules a layout pass for the boundary subtree only.',
          style: TextStyle(color: _inkDim, fontSize: 12.5, height: 1.45),
        ),
      ],
    ),
  );
}

Widget _buildTheoryRelayoutCauses() {
  return _Card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'what triggers a relayout',
          style: TextStyle(
            color: _ink,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 6),
        const _Bullet(
          icon: Icons.straighten,
          color: _mixinA,
          text:
              'Parent passes new BoxConstraints — the child\'s layout() is '
              'invoked again, even if nothing else changed.',
        ),
        const _Bullet(
          icon: Icons.swap_horiz,
          color: _mixinB,
          text:
              'parentData changes (e.g. a Positioned changes left/top) — the '
              'parent that owns the parentData type marks itself dirty.',
        ),
        const _Bullet(
          icon: Icons.font_download_outlined,
          color: _mixinC,
          text:
              'A subscribed external signal fires — system fonts changed, '
              'text scale changed, platform brightness changed. The relevant '
              'mixin calls markNeedsLayout on the host.',
        ),
        const _Bullet(
          icon: Icons.add_box_outlined,
          color: _accentB,
          text:
              'A child is inserted or removed — the parent\'s child list '
              'changes, so the parent must relay out to recompute its size.',
        ),
      ],
    ),
  );
}

Widget _buildTheoryDepthVsAware() {
  return _Card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'depth-first traversal vs. depth-aware scheduling',
          style: TextStyle(
            color: _ink,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'During performLayout, a parent recursively calls child.layout() — '
          'this is plain depth-first traversal. By contrast, the pipeline '
          'owner\'s dirty queue is depth-aware: when multiple nodes need '
          'layout in the same frame, it sorts them so that ancestors run '
          'before their descendants. This avoids wasted work where a child '
          'lays out, then its parent re-lays it out under different '
          'constraints.',
          style: TextStyle(color: _inkDim, fontSize: 12.5, height: 1.5),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _codeBg,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _codeEdge),
          ),
          child: const Text(
            'depth-first  : parent → child → grandchild  (single-shot)\n'
            'depth-aware  : sort dirty boundaries by depth, layout shallow first',
            style: TextStyle(
              color: _accentB,
              fontSize: 11.5,
              height: 1.5,
              fontFamilyFallback: <String>['monospace'],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildPitfallsCard() {
  return _Card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'pitfalls',
          style: TextStyle(
            color: _ink,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 6),
        const _Bullet(
          icon: Icons.error_outline,
          color: _accentBad,
          text:
              'Forgetting markNeedsLayout — a subscribed external signal '
              'changes state, but the host never tells the pipeline owner. '
              'The frame paints with stale geometry.',
        ),
        const _Bullet(
          icon: Icons.visibility_off_outlined,
          color: _accentBad,
          text:
              'Reading sizes during paint — a paint phase that reads '
              'child.size before child.layout has completed in the same '
              'frame breaks the layout/paint invariant.',
        ),
        const _Bullet(
          icon: Icons.bug_report_outlined,
          color: _accentWarn,
          text:
              'Wrong parentData type — if setupParentData does not install '
              'the type the container mixin expects, parentData reads cast '
              'as the expected type will throw at runtime.',
        ),
        const _Bullet(
          icon: Icons.swap_calls_outlined,
          color: _accentWarn,
          text:
              'Breaking the boundary — passing the parent\'s own constraints '
              'unmodified PLUS sizing yourself based on the child\'s size '
              'can demote the node from being a boundary.',
        ),
        const _Bullet(
          icon: Icons.timer_outlined,
          color: _accentBad,
          text:
              'Scheduling layout from build — calling markNeedsLayout from '
              'inside a build method (instead of from a mixin\'s lifecycle '
              'hook) reorders the pipeline phases.',
        ),
      ],
    ),
  );
}

// ─────────────────────────────────────────────────────────────────────────
// Sample code cards (styled Text, never executed).
// ─────────────────────────────────────────────────────────────────────────

Widget _buildSampleCardClassic() {
  return _Card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'sample 1 — classic single-child proxy with a relayout signal',
          style: TextStyle(
            color: _ink,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'A proxy that forwards one child, hosts typed parentData, and '
          'reacts to a system-level signal by marking itself dirty.',
          style: TextStyle(color: _inkDim, fontSize: 12.5, height: 1.45),
        ),
        const _CodeBlock(
          caption: 'sample.dart',
          code:
              'class _PD extends ParentData {}\n\n'
              'class _RenderProxyWithSignal extends RenderBox\n'
              '    with\n'
              '        RenderObjectWithChildMixin<RenderBox>,\n'
              '        RenderProxyBoxMixin,\n'
              '        RelayoutWhenSystemFontsChangeMixin {\n'
              '  @override\n'
              '  void setupParentData(RenderObject child) {\n'
              '    if (child.parentData is! _PD) {\n'
              '      child.parentData = _PD();\n'
              '    }\n'
              '  }\n\n'
              '  @override\n'
              '  void systemFontsDidChange() {\n'
              '    super.systemFontsDidChange();\n'
              '    markNeedsLayout();\n'
              '  }\n'
              '}',
        ),
      ],
    ),
  );
}

Widget _buildSampleCardMultiChild() {
  return _Card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'sample 2 — multi-child container with default paint/hit-test',
          style: TextStyle(
            color: _ink,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Two mixins replace what would otherwise be hand-written linked-'
          'list traversal and per-child paint offset arithmetic.',
          style: TextStyle(color: _inkDim, fontSize: 12.5, height: 1.45),
        ),
        const _CodeBlock(
          caption: 'sample.dart',
          code:
              'class _PDMulti extends ContainerBoxParentData<RenderBox> {}\n\n'
              'class _RenderStack extends RenderBox\n'
              '    with\n'
              '        ContainerRenderObjectMixin<RenderBox, _PDMulti>,\n'
              '        RenderBoxContainerDefaultsMixin<RenderBox, _PDMulti>,\n'
              '        RelayoutWhenSystemFontsChangeMixin {\n'
              '  @override\n'
              '  void setupParentData(RenderObject child) {\n'
              '    if (child.parentData is! _PDMulti) {\n'
              '      child.parentData = _PDMulti();\n'
              '    }\n'
              '  }\n\n'
              '  @override\n'
              '  void paint(PaintingContext ctx, Offset off) {\n'
              '    defaultPaint(ctx, off);\n'
              '  }\n\n'
              '  @override\n'
              '  bool hitTestChildren(BoxHitTestResult r, {required Offset position}) {\n'
              '    return defaultHitTestChildren(r, position: position);\n'
              '  }\n'
              '}',
        ),
      ],
    ),
  );
}

Widget _buildSampleCardLayoutBody() {
  return _Card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'sample 3 — performLayout walks the linked list',
          style: TextStyle(
            color: _ink,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'ContainerRenderObjectMixin gives us firstChild / lastChild and a '
          'doubly-linked list. We walk it, layout each child, accumulate '
          'size, and assign offset into parentData.',
          style: TextStyle(color: _inkDim, fontSize: 12.5, height: 1.45),
        ),
        const _CodeBlock(
          caption: 'sample.dart',
          code:
              '@override\n'
              'void performLayout() {\n'
              '  var width = 0.0;\n'
              '  var height = 0.0;\n'
              '  var child = firstChild;\n'
              '  while (child != null) {\n'
              '    child.layout(constraints, parentUsesSize: true);\n'
              '    final pd = child.parentData! as _PDMulti;\n'
              '    pd.offset = Offset(0, height);\n'
              '    width = math.max(width, child.size.width);\n'
              '    height += child.size.height;\n'
              '    child = pd.nextSibling;\n'
              '  }\n'
              '  size = constraints.constrain(Size(width, height));\n'
              '}',
        ),
      ],
    ),
  );
}

Widget _buildSampleCardRelayoutSignal() {
  return _Card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'sample 4 — explicit relayout signal from a custom source',
          style: TextStyle(
            color: _ink,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Sometimes you want your OWN mixin (a third party signal, e.g. a '
          'theme tokens registry). The mixin overrides attach/detach to '
          'subscribe and unsubscribe, and exposes a hook subclasses call '
          'markNeedsLayout from.',
          style: TextStyle(color: _inkDim, fontSize: 12.5, height: 1.45),
        ),
        const _CodeBlock(
          caption: 'sample.dart',
          code:
              'mixin RelayoutOnTokenChange on RenderObject {\n'
              '  @override\n'
              '  void attach(PipelineOwner owner) {\n'
              '    super.attach(owner);\n'
              '    TokensRegistry.instance.addListener(_onTokens);\n'
              '  }\n\n'
              '  @override\n'
              '  void detach() {\n'
              '    TokensRegistry.instance.removeListener(_onTokens);\n'
              '    super.detach();\n'
              '  }\n\n'
              '  void _onTokens() {\n'
              '    markNeedsLayout();\n'
              '  }\n'
              '}',
        ),
      ],
    ),
  );
}

Widget _buildSampleCardBuildSite() {
  return _Card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'sample 5 — build-site widget that hosts the three-mixin RO',
          style: TextStyle(
            color: _ink,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'A MultiChildRenderObjectWidget exposes the three-mixin RO. Note '
          'how the widget API stays small — all the rendering complexity '
          'is encapsulated in the RO class itself.',
          style: TextStyle(color: _inkDim, fontSize: 12.5, height: 1.45),
        ),
        const _CodeBlock(
          caption: 'sample.dart',
          code:
              'class ThreeMixinHost extends MultiChildRenderObjectWidget {\n'
              '  const ThreeMixinHost({\n'
              '    super.key,\n'
              '    super.children,\n'
              '  });\n\n'
              '  @override\n'
              '  RenderObject createRenderObject(BuildContext context) {\n'
              '    return _RenderStack();\n'
              '  }\n'
              '}',
        ),
      ],
    ),
  );
}

Widget _buildSampleCardParentData() {
  return _Card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'sample 6 — typed parentData and applyPaintTransform',
          style: TextStyle(
            color: _ink,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Container mixins expect a parentData subclass of '
          'ContainerBoxParentData<RenderBox>. Once the offset lives there, '
          'applyPaintTransform is automatic via defaultPaint.',
          style: TextStyle(color: _inkDim, fontSize: 12.5, height: 1.45),
        ),
        const _CodeBlock(
          caption: 'sample.dart',
          code:
              'class _PD extends ContainerBoxParentData<RenderBox> {\n'
              '  String? slotName;\n'
              '}\n\n'
              '@override\n'
              'void applyPaintTransform(RenderBox child, Matrix4 transform) {\n'
              '  final pd = child.parentData! as _PD;\n'
              '  transform.translate(pd.offset.dx, pd.offset.dy);\n'
              '}',
        ),
      ],
    ),
  );
}

// ─────────────────────────────────────────────────────────────────────────
// Gallery cards — visual mockups of what the three-mixin RO output looks
// like across different layout situations. Each is a Stack-based static
// rendering, never an actual RenderObject.
// ─────────────────────────────────────────────────────────────────────────

List<Widget> _galleryCards() {
  return <Widget>[
    _UsageMockCard(
      title: 'gallery 1 — vertical stack, tight constraints',
      subtitle:
          'Three children laid out top-to-bottom; the boundary keeps the '
          'parent\'s constraints opaque to the outside.',
      boxes: <_MockBox>[
        const _MockBox(
          left: 16,
          top: 14,
          width: 220,
          height: 30,
          color: _mixinA,
          label: 'child[0]  offset=(0,0)',
        ),
        const _MockBox(
          left: 16,
          top: 50,
          width: 220,
          height: 30,
          color: _mixinB,
          label: 'child[1]  offset=(0,30)',
        ),
        const _MockBox(
          left: 16,
          top: 86,
          width: 220,
          height: 30,
          color: _mixinC,
          label: 'child[2]  offset=(0,60)',
        ),
      ],
    ),
    _UsageMockCard(
      title: 'gallery 2 — horizontal flow, parentData-driven gaps',
      subtitle:
          'parentData carries per-child gap and slot name; the RO reads them '
          'in performLayout and assigns offset.dx.',
      boxes: <_MockBox>[
        const _MockBox(
          left: 16,
          top: 60,
          width: 70,
          height: 50,
          color: _mixinA,
          label: 'A',
        ),
        const _MockBox(
          left: 96,
          top: 60,
          width: 90,
          height: 50,
          color: _mixinB,
          label: 'B',
        ),
        const _MockBox(
          left: 196,
          top: 60,
          width: 60,
          height: 50,
          color: _mixinC,
          label: 'C',
        ),
      ],
    ),
    _UsageMockCard(
      title: 'gallery 3 — single proxied child, padded',
      subtitle:
          'RenderObjectWithChildMixin + RenderProxyBoxMixin forward layout '
          'directly. The relayout mixin lets the proxy reflow when fonts '
          'change.',
      boxes: <_MockBox>[
        const _MockBox(
          left: 28,
          top: 24,
          width: 240,
          height: 110,
          color: _baseBox,
          label: 'sole child  parentData=null',
        ),
      ],
    ),
    _UsageMockCard(
      title: 'gallery 4 — grid-like, multi-child container',
      subtitle:
          'Linked-list iteration places children in row-major order; the '
          'parent computes its size from the largest row.',
      boxes: <_MockBox>[
        const _MockBox(
          left: 16,
          top: 14,
          width: 60,
          height: 40,
          color: _mixinA,
          label: '00',
        ),
        const _MockBox(
          left: 84,
          top: 14,
          width: 60,
          height: 40,
          color: _mixinA,
          label: '01',
        ),
        const _MockBox(
          left: 152,
          top: 14,
          width: 60,
          height: 40,
          color: _mixinA,
          label: '02',
        ),
        const _MockBox(
          left: 16,
          top: 62,
          width: 60,
          height: 40,
          color: _mixinB,
          label: '10',
        ),
        const _MockBox(
          left: 84,
          top: 62,
          width: 60,
          height: 40,
          color: _mixinB,
          label: '11',
        ),
        const _MockBox(
          left: 152,
          top: 62,
          width: 60,
          height: 40,
          color: _mixinB,
          label: '12',
        ),
        const _MockBox(
          left: 16,
          top: 110,
          width: 60,
          height: 40,
          color: _mixinC,
          label: '20',
        ),
        const _MockBox(
          left: 84,
          top: 110,
          width: 60,
          height: 40,
          color: _mixinC,
          label: '21',
        ),
        const _MockBox(
          left: 152,
          top: 110,
          width: 60,
          height: 40,
          color: _mixinC,
          label: '22',
        ),
      ],
    ),
    _UsageMockCard(
      title: 'gallery 5 — boundary protects an expensive subtree',
      subtitle:
          'The host\'s rectangle is unchanged between frames even if its '
          'parent reflows, because constraints are tight.',
      height: 200,
      boxes: <_MockBox>[
        const _MockBox(
          left: 20,
          top: 18,
          width: 260,
          height: 160,
          color: _accentWarn,
          label: 'RelayoutBoundary',
        ),
        const _MockBox(
          left: 36,
          top: 40,
          width: 100,
          height: 50,
          color: _mixinA,
          label: 'child A',
        ),
        const _MockBox(
          left: 36,
          top: 100,
          width: 100,
          height: 50,
          color: _mixinB,
          label: 'child B',
        ),
        const _MockBox(
          left: 150,
          top: 40,
          width: 120,
          height: 110,
          color: _mixinC,
          label: 'expensive C',
        ),
      ],
    ),
    _UsageMockCard(
      title: 'gallery 6 — system-fonts trigger reflow',
      subtitle:
          'The third mixin observes the platform font-feature signal and '
          'marks the host dirty. Children re-layout under the SAME '
          'constraints.',
      boxes: <_MockBox>[
        const _MockBox(
          left: 16,
          top: 18,
          width: 240,
          height: 28,
          color: _mixinA,
          label: 'text-row  fontScale=1.0',
        ),
        const _MockBox(
          left: 16,
          top: 56,
          width: 256,
          height: 36,
          color: _mixinB,
          label: 'text-row  fontScale=1.3',
        ),
        const _MockBox(
          left: 16,
          top: 100,
          width: 280,
          height: 44,
          color: _mixinC,
          label: 'text-row  fontScale=1.6',
        ),
      ],
    ),
  ];
}

// ─────────────────────────────────────────────────────────────────────────
// Glossary block: short definitions in a two-column grid layout.
// ─────────────────────────────────────────────────────────────────────────

Widget _buildGlossaryCard() {
  return _Card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'glossary',
          style: TextStyle(
            color: _ink,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        _glossaryRow(
          term: 'RenderBox',
          pillColor: _baseBox,
          desc:
              'Box-constraints + Size based RenderObject. Accepts '
              'BoxConstraints, emits Size, supports hit-testing.',
        ),
        _glossaryRow(
          term: 'RenderObjectWithChildMixin',
          pillColor: _mixinA,
          desc:
              'Mixin for single-child render objects. Adds a typed child '
              'slot and hooks setupParentData.',
        ),
        _glossaryRow(
          term: 'ContainerRenderObjectMixin',
          pillColor: _mixinA,
          desc:
              'Mixin for multi-child render objects. Owns a doubly-linked '
              'list of children with typed parentData.',
        ),
        _glossaryRow(
          term: 'RenderProxyBoxMixin',
          pillColor: _mixinB,
          desc:
              'Mixin that forwards layout, paint and hit-test calls to a '
              'single child as-is.',
        ),
        _glossaryRow(
          term: 'RenderBoxContainerDefaultsMixin',
          pillColor: _mixinB,
          desc:
              'Provides defaultPaint, defaultHitTestChildren, '
              'defaultComputeDistanceToFirstActualBaseline for box children.',
        ),
        _glossaryRow(
          term: 'RelayoutWhenSystemFontsChangeMixin',
          pillColor: _mixinC,
          desc:
              'Subscribes to system-fonts notifications and calls '
              'markNeedsLayout on the host when the signal fires.',
        ),
        _glossaryRow(
          term: 'RelayoutBoundary',
          pillColor: _accentWarn,
          desc:
              'A node whose subtree can be relaid out in isolation. '
              'markNeedsLayout does not propagate above a boundary.',
        ),
        _glossaryRow(
          term: 'ParentData',
          pillColor: _accentB,
          desc:
              'Per-child data slot owned by the PARENT — used to store '
              'layout output like Offset, slot names, gap hints.',
        ),
      ],
    ),
  );
}

Widget _glossaryRow({
  required String term,
  required Color pillColor,
  required String desc,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 220,
          child: Align(
            alignment: Alignment.topLeft,
            child: _Pill(text: term, color: pillColor),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            desc,
            style: const TextStyle(
              color: _inkDim,
              fontSize: 12.5,
              height: 1.45,
            ),
          ),
        ),
      ],
    ),
  );
}

// ─────────────────────────────────────────────────────────────────────────
// Footer.
// ─────────────────────────────────────────────────────────────────────────

Widget _buildFooter() {
  return Padding(
    padding: const EdgeInsets.fromLTRB(20, 22, 20, 30),
    child: Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _cardEdge),
      ),
      child: const Row(
        children: <Widget>[
          Icon(Icons.architecture, color: _accentA, size: 22),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'D4rt corpus — three-mixin relayout container. Static poster, no '
              'real RenderObject subclasses are instantiated.',
              style: TextStyle(
                color: _inkDim,
                fontSize: 12,
                height: 1.4,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

// ─────────────────────────────────────────────────────────────────────────
// Title block with a tiny custom-painted three-mixin badge.
// ─────────────────────────────────────────────────────────────────────────

class _BadgePainter extends CustomPainter {
  _BadgePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Rect r = Offset.zero & size;
    final Paint bg = Paint()
      ..shader = ui.Gradient.linear(
        r.topLeft,
        r.bottomRight,
        const <Color>[_accentA, _mixinC],
      );
    canvas.drawRRect(
      RRect.fromRectAndRadius(r, const Radius.circular(12)),
      bg,
    );

    // Three layered plates.
    final double centerY = size.height / 2;
    for (int i = 0; i < 3; i++) {
      final Rect plate = Rect.fromCenter(
        center: Offset(size.width / 2, centerY + (i - 1) * 6),
        width: size.width * 0.62,
        height: 10,
      );
      final Color c = <Color>[_mixinA, _mixinB, _mixinC][i];
      canvas.drawRRect(
        RRect.fromRectAndRadius(plate, const Radius.circular(3)),
        Paint()..color = c.withValues(alpha: 0.92),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _BadgePainter old) => false;
}

class _TitleBlock extends StatelessWidget {
  const _TitleBlock();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 26, 20, 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: 56,
            height: 56,
            child: CustomPaint(painter: _BadgePainter()),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Three-Mixin Relayout Container',
                  style: TextStyle(
                    color: _ink,
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    height: 1.05,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'a deep visual demo of the Fa6 RenderBox composition pattern',
                  style: TextStyle(
                    color: _inkDim,
                    fontSize: 13.5,
                    fontStyle: FontStyle.italic,
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

// ─────────────────────────────────────────────────────────────────────────
// Top-level build — called ONCE by the d4rt test harness.
// ─────────────────────────────────────────────────────────────────────────

dynamic build(BuildContext context) {
  // We aggressively `kDebugMode`-guard nothing here, but referencing it once
  // exercises the foundation import and makes the const-evaluator happy.
  final bool debugTag = kDebugMode;

  final List<Widget> children = <Widget>[
    const _TitleBlock(),
    const _SectionHeader(
      tag: '1 · INTRO',
      title: 'What is a relayout container?',
      subtitle:
          'A RenderBox that hosts children, qualifies as a relayout '
          'boundary, and composes its capabilities from three mixins.',
    ),
    const _IntroCard(),

    const _SectionHeader(
      tag: '2 · PIPELINE',
      title: 'Layout pipeline & where the boundary cuts in',
      subtitle:
          'needsLayout → markNeedsLayout → boundary → layout() → size → '
          'paint. The boundary terminates upward propagation.',
    ),
    _buildPipelineDiagram(),
    _buildBoundaryTreeDiagram(),

    const _SectionHeader(
      tag: '3 · COMPOSITION',
      title: 'Three mixins, one RenderBox',
      subtitle:
          'Each mixin contributes one independent concern: child storage, '
          'child delegation, and relayout triggering.',
    ),
    _buildMixinStackDiagram(),
    _buildPainterMockCard(),

    const _SectionHeader(
      tag: '4 · USAGE',
      title: 'Three concrete usage mockups',
      subtitle:
          'Each card is a static Stack-based rendering of what the '
          'three-mixin RO output would look like at frame time.',
    ),
    _UsageMockCard(
      title: 'usage A — vertical column of children',
      subtitle:
          'Container mixin walks firstChild → nextSibling, assigns '
          'offset.dy = cumulative height.',
      boxes: <_MockBox>[
        const _MockBox(
          left: 20,
          top: 14,
          width: 220,
          height: 26,
          color: _mixinA,
          label: 'A',
        ),
        const _MockBox(
          left: 20,
          top: 48,
          width: 220,
          height: 26,
          color: _mixinB,
          label: 'B',
        ),
        const _MockBox(
          left: 20,
          top: 82,
          width: 220,
          height: 26,
          color: _mixinC,
          label: 'C',
        ),
        const _MockBox(
          left: 20,
          top: 116,
          width: 220,
          height: 26,
          color: _baseBox,
          label: 'D',
        ),
      ],
    ),
    _UsageMockCard(
      title: 'usage B — proxy with overlay child',
      subtitle:
          'RenderProxyBoxMixin forwards constraints to a single child; the '
          'overlay sits ABOVE it in paint order.',
      boxes: <_MockBox>[
        const _MockBox(
          left: 16,
          top: 18,
          width: 280,
          height: 130,
          color: _baseBox,
          label: 'proxied child',
        ),
        const _MockBox(
          left: 38,
          top: 38,
          width: 100,
          height: 24,
          color: _accentWarn,
          label: 'overlay',
        ),
      ],
    ),
    _UsageMockCard(
      title: 'usage C — text-row reflowing on font signal',
      subtitle:
          'RelayoutWhenSystemFontsChangeMixin reflows the row when the '
          'platform changes the font configuration.',
      boxes: <_MockBox>[
        const _MockBox(
          left: 16,
          top: 18,
          width: 40,
          height: 24,
          color: _mixinA,
          label: 'I',
        ),
        const _MockBox(
          left: 60,
          top: 18,
          width: 60,
          height: 24,
          color: _mixinA,
          label: 'AM',
        ),
        const _MockBox(
          left: 124,
          top: 18,
          width: 80,
          height: 24,
          color: _mixinA,
          label: 'A',
        ),
        const _MockBox(
          left: 208,
          top: 18,
          width: 60,
          height: 24,
          color: _mixinA,
          label: 'ROW',
        ),
        const _MockBox(
          left: 16,
          top: 60,
          width: 60,
          height: 36,
          color: _mixinB,
          label: 'I',
        ),
        const _MockBox(
          left: 80,
          top: 60,
          width: 80,
          height: 36,
          color: _mixinB,
          label: 'AM',
        ),
        const _MockBox(
          left: 164,
          top: 60,
          width: 100,
          height: 36,
          color: _mixinB,
          label: 'BIG',
        ),
      ],
    ),

    const _SectionHeader(
      tag: '5 · THEORY',
      title: 'What triggers a relayout, traversal vs. scheduling',
      subtitle:
          'Concrete sources of dirty marks; depth-first vs depth-aware '
          'scheduling inside the pipeline owner.',
    ),
    _buildTheoryRelayoutCauses(),
    _buildTheoryDepthVsAware(),

    const _SectionHeader(
      tag: '6 · PITFALLS',
      title: 'How three-mixin ROs go wrong',
      subtitle:
          'A short catalog of bugs to look for during code review and '
          'when reading stack traces during layout failures.',
    ),
    _buildPitfallsCard(),

    const _SectionHeader(
      tag: '7 · SAMPLES',
      title: 'Idiomatic three-mixin code (styled, not executed)',
      subtitle:
          'Code-block cards showing the canonical class shape, the layout '
          'body, and the build-site widget.',
    ),
    _buildSampleCardClassic(),
    _buildSampleCardMultiChild(),
    _buildSampleCardLayoutBody(),
    _buildSampleCardRelayoutSignal(),
    _buildSampleCardBuildSite(),
    _buildSampleCardParentData(),

    const _SectionHeader(
      tag: '8 · GALLERY',
      title: 'What the output looks like',
      subtitle:
          'Six static visual mockups showing parentData-driven offsets, '
          'multi-child grids, proxied single children, and font-driven '
          'reflows.',
    ),
    ..._galleryCards(),

    _buildGlossaryCard(),
    _buildFooter(),

    // Tiny debug-flag readout so the foundation import is used.
    Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
      child: Text(
        'kDebugMode=$debugTag',
        style: const TextStyle(
          color: _inkDim,
          fontSize: 10,
          fontFamilyFallback: <String>['monospace'],
        ),
      ),
    ),
  ];

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Three-Mixin Relayout Container — D4rt Demo',
    home: Scaffold(
      backgroundColor: _bgTop,
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[_bgTop, _bgBottom],
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.zero,
            children: children,
          ),
        ),
      ),
    ),
  );
}
