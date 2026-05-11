// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unused_element, dead_code, unnecessary_import, unused_import, no_leading_underscores_for_local_identifiers
// D4rt test script: Deep visual demo of Flutter's `rendering` ParentData layer.
//
// This file is part of the D4rt flutter-test corpus. It is executed by an
// analyzer-free sandboxed Dart interpreter. The script exports exactly one
// top-level entry point - `dynamic build(BuildContext)` - that is invoked a
// single time and returns a Widget tree.
//
// The rendered output is a long static gallery that walks through Flutter's
// ParentData hierarchy. ParentData is the little "envelope" that a parent
// RenderObject attaches to each of its children to carry layout-specific
// information from the layout phase into the paint phase. Examples:
//
//   * `BoxParentData.offset` - the resolved (x, y) of a box child.
//   * `FlexParentData.flex / fit` - per-child flex weight and fit policy.
//   * `StackParentData.top/left/right/bottom/width/height` - Positioned data.
//   * `SliverPhysicalParentData.paintOffset` - per-sliver paint translation.
//   * `ContainerBoxParentData<T>` - mixin that turns parent data into a
//     doubly-linked list node so a parent can iterate its children.
//
// The script renders eleven labelled sections:
//
//   1. Hero intro - what ParentData is and why renderers need it.
//   2. ParentData class hierarchy painted as a tree via CustomPainter.
//   3. BoxParentData anatomy diagram: offset carries position layout -> paint.
//   4. FlexParentData gallery: six children with different flex / fit values.
//   5. StackParentData gallery: five Positioned variants annotated.
//   6. SliverPhysicalParentData gallery: a CustomScrollView with three slivers.
//   7. ParentDataWidget code block: Expanded / Flexible / Positioned / Align.
//   8. Custom ParentDataWidget walkthrough: five-card authoring guide.
//   9. Pitfalls: five common mistakes that bite renderers.
//  10. Comparison table: BoxParentData vs SliverPhysicalParentData vs custom.
//  11. Footer cheat-sheet: chip groups (Classes, Mixins, Widgets, Render layer).
//
// Every helper is private. No `setState`, `Timer`, `Future` or
// `AnimationController` is used anywhere in this file.
import 'dart:math' as math;
import 'dart:ui' show FontFeature;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

// ---------------------------------------------------------------------------
// COLOUR & TYPOGRAPHY CONSTANTS
// ---------------------------------------------------------------------------
// The palette is a calm "engineering notebook" feel - light canvas, paper
// cards, ink-grey text, and a small set of accent colours that we use to
// distinguish layout phases (blue = layout, orange = paint, green = data,
// purple = mixin, pink = pitfall).
const Color _kCanvas = Color(0xFFF4F5F8);
const Color _kCardBg = Color(0xFFFFFFFF);
const Color _kCardDark = Color(0xFF1B1D23);
const Color _kHairline = Color(0x14000000);
const Color _kHairlineDark = Color(0x33FFFFFF);
const Color _kInk = Color(0xFF1B1D23);
const Color _kInkSecondary = Color(0xFF454852);
const Color _kInkTertiary = Color(0xFF8A8E99);
const Color _kInkOnDark = Color(0xFFEDEFF4);
const Color _kInkOnDarkSecondary = Color(0xFFA1A6B2);

const Color _kLayout = Color(0xFF2D6BFF); // blue
const Color _kPaint = Color(0xFFFF8A2A); // orange
const Color _kData = Color(0xFF1FA971); // green
const Color _kMixin = Color(0xFF8B5CF6); // purple
const Color _kSliver = Color(0xFF0EA5E9); // sky
const Color _kStack = Color(0xFFE11D74); // pink
const Color _kFlex = Color(0xFFFFB627); // amber
const Color _kPitfall = Color(0xFFE03131); // red

const Color _kCodeBg = Color(0xFF1E1F22);
const Color _kCodeText = Color(0xFFE6E6E6);
const Color _kCodeAccent = Color(0xFF7DD3FC);
const Color _kCodeKeyword = Color(0xFFFFA657);
const Color _kCodeString = Color(0xFFA5D6A7);
const Color _kCodeComment = Color(0xFF6E7681);

const TextStyle _kTitleStyle = TextStyle(
  fontSize: 22.0,
  fontWeight: FontWeight.w700,
  color: _kInk,
  letterSpacing: -0.4,
);
const TextStyle _kSubtitleStyle = TextStyle(
  fontSize: 14.0,
  fontWeight: FontWeight.w500,
  color: _kInkSecondary,
);
const TextStyle _kCaptionStyle = TextStyle(
  fontSize: 12.0,
  color: _kInkTertiary,
  fontWeight: FontWeight.w500,
);
const TextStyle _kBodyStyle = TextStyle(
  fontSize: 14.0,
  height: 1.45,
  color: _kInk,
);
const TextStyle _kMonoStyle = TextStyle(
  fontSize: 12.5,
  fontFamily: 'monospace',
  color: _kInk,
  height: 1.4,
  fontFeatures: <FontFeature>[FontFeature.tabularFigures()],
);
const TextStyle _kCodeStyle = TextStyle(
  fontSize: 12.5,
  fontFamily: 'monospace',
  color: _kCodeText,
  height: 1.4,
  fontFeatures: <FontFeature>[FontFeature.tabularFigures()],
);
const EdgeInsets _kCardPadding = EdgeInsets.all(18.0);
const EdgeInsets _kSectionPadding = EdgeInsets.symmetric(horizontal: 18.0);

// ---------------------------------------------------------------------------
// PRIVATE HELPER WIDGETS
// ---------------------------------------------------------------------------
// All helpers are top-level functions returning `Widget`s. Keeping them as
// plain functions (instead of StatelessWidget subclasses) makes the file
// readable top-to-bottom without jumping between class definitions.
Widget _sectionHeader(int index, String title, String tagline, {Color accent = _kLayout}) {
  return Padding(
    padding: const EdgeInsets.only(top: 28.0, bottom: 12.0, left: 18.0, right: 18.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 36.0,
          height: 36.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: accent,
            shape: BoxShape.circle,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: accent.withOpacity(0.35),
                offset: const Offset(0.0, 2.0),
                blurRadius: 6.0,
              ),
            ],
          ),
          child: Text(
            '$index',
            style: const TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 16.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title, style: _kTitleStyle),
              const SizedBox(height: 2.0),
              Text(tagline, style: _kSubtitleStyle),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _card({
  required Widget child,
  Color background = _kCardBg,
  EdgeInsets padding = _kCardPadding,
  EdgeInsets margin = const EdgeInsets.symmetric(horizontal: 18.0, vertical: 6.0),
  Color? borderColour,
}) {
  return Container(
    margin: margin,
    padding: padding,
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: borderColour ?? _kHairline),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x0D000000),
          offset: Offset(0.0, 1.0),
          blurRadius: 3.0,
        ),
      ],
    ),
    child: child,
  );
}

Widget _cardTitle(String title, {String? subtitle, Color titleColor = _kInk, Color subtitleColor = _kInkSecondary, IconData? icon, Color iconColor = _kLayout}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      if (icon != null) ...<Widget>[
        Icon(icon, color: iconColor, size: 20.0),
        const SizedBox(width: 8.0),
      ],
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                color: titleColor,
                letterSpacing: -0.2,
              ),
            ),
            if (subtitle != null) ...<Widget>[
              const SizedBox(height: 2.0),
              Text(subtitle, style: TextStyle(fontSize: 12.5, color: subtitleColor)),
            ],
          ],
        ),
      ),
    ],
  );
}

Widget _pill(String label, {Color colour = _kLayout, Color? textColour}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: 3.0),
    decoration: BoxDecoration(
      color: colour.withOpacity(0.12),
      borderRadius: BorderRadius.circular(999.0),
      border: Border.all(color: colour.withOpacity(0.35)),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 11.0,
        fontWeight: FontWeight.w600,
        color: textColour ?? colour,
        letterSpacing: 0.1,
      ),
    ),
  );
}

Widget _chipSolid(String label, {Color colour = _kLayout}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: colour,
      borderRadius: BorderRadius.circular(999.0),
    ),
    child: Text(
      label,
      style: const TextStyle(
        fontSize: 11.0,
        fontWeight: FontWeight.w600,
        color: Color(0xFFFFFFFF),
        letterSpacing: 0.2,
      ),
    ),
  );
}

Widget _codeBlock(String code, {String? title}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: _kCodeBg,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: const Color(0xFF2A2D32)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (title != null) ...<Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 10.0,
                height: 10.0,
                decoration: const BoxDecoration(color: Color(0xFFFF5F56), shape: BoxShape.circle),
              ),
              const SizedBox(width: 6.0),
              Container(
                width: 10.0,
                height: 10.0,
                decoration: const BoxDecoration(color: Color(0xFFFFBD2E), shape: BoxShape.circle),
              ),
              const SizedBox(width: 6.0),
              Container(
                width: 10.0,
                height: 10.0,
                decoration: const BoxDecoration(color: Color(0xFF27C93F), shape: BoxShape.circle),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: _kCodeAccent,
                    fontFamily: 'monospace',
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
        ],
        Text(code, style: _kCodeStyle),
      ],
    ),
  );
}

Widget _sectionDivider() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18.0),
    height: 1.0,
    color: _kHairline,
  );
}

Widget _kvRow(String key, String value, {Color keyColour = _kInkTertiary, Color valueColour = _kInk}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 86.0,
          child: Text(
            key,
            style: TextStyle(
              fontSize: 11.5,
              fontFamily: 'monospace',
              color: keyColour,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 11.5,
              fontFamily: 'monospace',
              color: valueColour,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _bulletLine(String text, {Color bulletColour = _kLayout}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 6.0, right: 8.0),
          child: Container(
            width: 6.0,
            height: 6.0,
            decoration: BoxDecoration(
              color: bulletColour,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Expanded(child: Text(text, style: _kBodyStyle)),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// HIERARCHY PAINTER - SECTION 2
// ---------------------------------------------------------------------------
// `_HierarchyPainter` paints the ParentData inheritance tree:
//
//                          ParentData
//                              |
//             +----------------+----------------+
//             |                |                |
//        BoxParentData   SliverLogical   SliverPhysical
//             |          ParentData      ParentData
//             |
//   +---------+---------+-----------------------+
//   |         |         |                       |
//   Flex      Stack     ContainerBox            MultiChildLayout
//   ParentData ParentData ParentData<T extends ParentData>
//
// Each node is drawn as a rounded rectangle with a coloured stripe. Edges
// are simple polylines joining parents to children. The painter is purely
// static so no `shouldRepaint` magic is needed.
class _HierarchyNode {
  const _HierarchyNode({
    required this.label,
    required this.x,
    required this.y,
    required this.colour,
    this.width = 150.0,
  });
  final String label;
  final double x;
  final double y;
  final Color colour;
  final double width;
}

class _HierarchyEdge {
  const _HierarchyEdge({required this.from, required this.to});
  final int from;
  final int to;
}

class _HierarchyPainter extends CustomPainter {
  const _HierarchyPainter({required this.nodes, required this.edges});
  final List<_HierarchyNode> nodes;
  final List<_HierarchyEdge> edges;

  @override
  void paint(Canvas canvas, Size size) {
    // 1) Draw all edges first so node fills cover the joins.
    final Paint edgePaint = Paint()
      ..color = const Color(0xFFB7BCC8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    for (final _HierarchyEdge edge in edges) {
      final _HierarchyNode a = nodes[edge.from];
      final _HierarchyNode b = nodes[edge.to];
      final Offset aBottom = Offset(a.x + a.width / 2.0, a.y + 40.0);
      final Offset bTop = Offset(b.x + b.width / 2.0, b.y);
      final double midY = (aBottom.dy + bTop.dy) / 2.0;
      final Path path = Path()
        ..moveTo(aBottom.dx, aBottom.dy)
        ..lineTo(aBottom.dx, midY)
        ..lineTo(bTop.dx, midY)
        ..lineTo(bTop.dx, bTop.dy);
      canvas.drawPath(path, edgePaint);

      // Arrowhead at the child node top.
      final Path arrow = Path()
        ..moveTo(bTop.dx - 4.0, bTop.dy - 6.0)
        ..lineTo(bTop.dx + 4.0, bTop.dy - 6.0)
        ..lineTo(bTop.dx, bTop.dy)
        ..close();
      canvas.drawPath(arrow, Paint()..color = const Color(0xFFB7BCC8));
    }

    // 2) Draw nodes.
    for (final _HierarchyNode node in nodes) {
      final RRect rect = RRect.fromRectAndRadius(
        Rect.fromLTWH(node.x, node.y, node.width, 40.0),
        const Radius.circular(8.0),
      );
      // Shadow.
      canvas.drawRRect(
        rect.shift(const Offset(0.0, 2.0)),
        Paint()..color = const Color(0x14000000),
      );
      // Body.
      canvas.drawRRect(rect, Paint()..color = const Color(0xFFFFFFFF));
      // Border.
      canvas.drawRRect(
        rect,
        Paint()
          ..color = node.colour.withOpacity(0.5)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.2,
      );
      // Coloured stripe on the left.
      final RRect stripe = RRect.fromRectAndCorners(
        Rect.fromLTWH(node.x, node.y, 6.0, 40.0),
        topLeft: const Radius.circular(8.0),
        bottomLeft: const Radius.circular(8.0),
      );
      canvas.drawRRect(stripe, Paint()..color = node.colour);

      // Label.
      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: node.label,
          style: const TextStyle(
            color: _kInk,
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
            fontFamily: 'monospace',
          ),
        ),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
        maxLines: 2,
        ellipsis: '...',
      )..layout(maxWidth: node.width - 16.0);
      tp.paint(
        canvas,
        Offset(node.x + 10.0, node.y + (40.0 - tp.height) / 2.0),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _HierarchyPainter oldDelegate) => false;
}

// ---------------------------------------------------------------------------
// BOX ANATOMY PAINTER - SECTION 3
// ---------------------------------------------------------------------------
// Paints the "envelope" diagram showing how `BoxParentData.offset` carries
// the resolved child position from a parent's `performLayout` into its
// `paint` method. Two rounded rectangles, an arrow between them, and a
// caption labelled "offset".
class _BoxAnatomyPainter extends CustomPainter {
  const _BoxAnatomyPainter();

  @override
  void paint(Canvas canvas, Size size) {
    // Backdrop graph paper.
    final Paint grid = Paint()
      ..color = const Color(0xFFEDEFF4)
      ..strokeWidth = 1.0;
    for (double x = 0.0; x <= size.width; x += 24.0) {
      canvas.drawLine(Offset(x, 0.0), Offset(x, size.height), grid);
    }
    for (double y = 0.0; y <= size.height; y += 24.0) {
      canvas.drawLine(Offset(0.0, y), Offset(size.width, y), grid);
    }

    // Parent rectangle - large outline.
    final Rect parent = Rect.fromLTWH(20.0, 24.0, size.width - 40.0, size.height - 48.0);
    final Paint parentBorder = Paint()
      ..color = _kLayout
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    canvas.drawRRect(
      RRect.fromRectAndRadius(parent, const Radius.circular(10.0)),
      parentBorder,
    );
    final TextPainter parentLabel = TextPainter(
      text: const TextSpan(
        text: 'Parent RenderBox  (performLayout)',
        style: TextStyle(
          color: _kLayout,
          fontSize: 11.0,
          fontWeight: FontWeight.w700,
          fontFamily: 'monospace',
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    parentLabel.paint(canvas, Offset(parent.left + 12.0, parent.top + 6.0));

    // Origin marker for parent.
    final Offset origin = Offset(parent.left + 36.0, parent.top + 36.0);
    canvas.drawCircle(origin, 4.0, Paint()..color = _kLayout);
    final TextPainter originLabel = TextPainter(
      text: const TextSpan(
        text: '(0, 0) parent origin',
        style: TextStyle(
          color: _kLayout,
          fontSize: 10.5,
          fontWeight: FontWeight.w600,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    originLabel.paint(canvas, origin + const Offset(8.0, -6.0));

    // Child rectangle.
    final Rect child = Rect.fromLTWH(parent.left + 80.0, parent.top + 80.0, 160.0, 70.0);
    final Paint childFill = Paint()..color = _kData.withOpacity(0.18);
    final Paint childBorder = Paint()
      ..color = _kData
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8;
    canvas.drawRRect(
      RRect.fromRectAndRadius(child, const Radius.circular(8.0)),
      childFill,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(child, const Radius.circular(8.0)),
      childBorder,
    );
    final TextPainter childLabel = TextPainter(
      text: const TextSpan(
        text: 'Child RenderBox',
        style: TextStyle(
          color: _kData,
          fontSize: 11.0,
          fontWeight: FontWeight.w700,
          fontFamily: 'monospace',
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    childLabel.paint(canvas, Offset(child.left + 10.0, child.top + 8.0));
    final TextPainter childSize = TextPainter(
      text: const TextSpan(
        text: 'size: 160 x 70',
        style: TextStyle(
          color: _kInkSecondary,
          fontSize: 10.5,
          fontFamily: 'monospace',
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    childSize.paint(canvas, Offset(child.left + 10.0, child.top + 24.0));

    // Offset arrow from origin -> child topLeft.
    final Paint arrowPaint = Paint()
      ..color = _kPaint
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    canvas.drawLine(origin, Offset(child.left, child.top), arrowPaint);

    // Arrowhead.
    final double dx = child.left - origin.dx;
    final double dy = child.top - origin.dy;
    final double angle = math.atan2(dy, dx);
    final Offset tip = Offset(child.left, child.top);
    final double headLen = 9.0;
    final Path arrowHead = Path()
      ..moveTo(tip.dx, tip.dy)
      ..lineTo(
        tip.dx - headLen * math.cos(angle - 0.5),
        tip.dy - headLen * math.sin(angle - 0.5),
      )
      ..lineTo(
        tip.dx - headLen * math.cos(angle + 0.5),
        tip.dy - headLen * math.sin(angle + 0.5),
      )
      ..close();
    canvas.drawPath(arrowHead, Paint()..color = _kPaint);

    // Label "offset" near the midpoint of the arrow.
    final Offset midpoint = Offset(
      (origin.dx + child.left) / 2.0,
      (origin.dy + child.top) / 2.0,
    );
    final TextPainter offsetLabel = TextPainter(
      text: const TextSpan(
        text: 'offset = Offset(44, 44)',
        style: TextStyle(
          color: _kPaint,
          fontSize: 11.0,
          fontWeight: FontWeight.w700,
          fontFamily: 'monospace',
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    final Rect bg = Rect.fromCenter(
      center: midpoint,
      width: offsetLabel.width + 10.0,
      height: offsetLabel.height + 6.0,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(bg, const Radius.circular(4.0)),
      Paint()..color = const Color(0xFFFFFFFF),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(bg, const Radius.circular(4.0)),
      Paint()
        ..color = _kPaint
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0,
    );
    offsetLabel.paint(
      canvas,
      Offset(bg.left + 5.0, bg.top + 3.0),
    );
  }

  @override
  bool shouldRepaint(covariant _BoxAnatomyPainter oldDelegate) => false;
}

// ===========================================================================
// MAIN BUILD ENTRY POINT
// ---------------------------------------------------------------------------
// The interpreter calls this function exactly once. All state lives in
// local variables passed by closure into the constructed widget tree.
// ===========================================================================
dynamic build(BuildContext context) {
  print('ParentData deep visual demo executing');

  // -------------------------------------------------------------------------
  // SECTION 1 - HERO INTRO
  // -------------------------------------------------------------------------
  // Big gradient banner. Explains the role of ParentData in the rendering
  // pipeline: a typed envelope attached by the parent RenderObject to each
  // child to carry layout-derived metadata into the paint phase.
  // -------------------------------------------------------------------------
  final Widget heroIntro = Container(
    margin: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 8.0),
    padding: const EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          Color(0xFF2D6BFF),
          Color(0xFF8B5CF6),
        ],
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x332D6BFF),
          offset: Offset(0.0, 6.0),
          blurRadius: 18.0,
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: const <Widget>[
            Icon(Icons.account_tree, color: Color(0xFFFFFFFF), size: 32.0),
            SizedBox(width: 12.0),
            Text(
              'ParentData',
              style: TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.w800,
                color: Color(0xFFFFFFFF),
                letterSpacing: -0.8,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        const Text(
          'The little envelope every RenderObject attaches to its children',
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w500,
            color: Color(0xCCFFFFFF),
          ),
        ),
        const SizedBox(height: 16.0),
        const Text(
          'ParentData is a sealed-feeling but openly extensible base class in '
          'package:flutter/rendering.dart. Each child of a parent RenderObject '
          'gets a ParentData instance attached at attach() time. The parent '
          'fills it during layout (offsets, flex weights, positioning) and '
          'reads it during paint or hitTest. ParentData lets the parent keep '
          'its custom per-child metadata WITHOUT subclassing the child.',
          style: TextStyle(
            fontSize: 14.0,
            height: 1.55,
            color: Color(0xFFFFFFFF),
          ),
        ),
        const SizedBox(height: 14.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: <Widget>[
            _pill('per-child', colour: const Color(0xFFFFFFFF)),
            _pill('typed', colour: const Color(0xFFFFFFFF)),
            _pill('layout -> paint', colour: const Color(0xFFFFFFFF)),
            _pill('linked list node', colour: const Color(0xFFFFFFFF)),
            _pill('written by parent', colour: const Color(0xFFFFFFFF)),
          ],
        ),
        const SizedBox(height: 16.0),
        Row(
          children: const <Widget>[
            Icon(Icons.lightbulb_outline, color: Color(0xFFFFFFFF), size: 18.0),
            SizedBox(width: 6.0),
            Expanded(
              child: Text(
                'Rule of thumb: if information about a child is computed by its '
                'parent, it lives in ParentData. If it is intrinsic to the child '
                'itself, it lives on the child RenderObject.',
                style: TextStyle(
                  fontSize: 12.5,
                  color: Color(0xE6FFFFFF),
                  height: 1.45,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 2 - HIERARCHY CUSTOMPAINTER
  // -------------------------------------------------------------------------
  // Render the class tree using `_HierarchyPainter`. We place nodes at hand
  // chosen coordinates so the layout is predictable across different screen
  // widths (we wrap the CustomPaint in a fixed-size SizedBox).
  // -------------------------------------------------------------------------
  const List<_HierarchyNode> hierarchyNodes = <_HierarchyNode>[
    _HierarchyNode(label: 'ParentData', x: 285.0, y: 6.0, colour: _kInk, width: 140.0),
    _HierarchyNode(label: 'BoxParentData', x: 60.0, y: 96.0, colour: _kLayout, width: 160.0),
    _HierarchyNode(label: 'SliverLogicalParentData', x: 240.0, y: 96.0, colour: _kSliver, width: 200.0),
    _HierarchyNode(label: 'SliverPhysicalParentData', x: 460.0, y: 96.0, colour: _kSliver, width: 210.0),
    _HierarchyNode(label: 'FlexParentData', x: 0.0, y: 196.0, colour: _kFlex, width: 150.0),
    _HierarchyNode(label: 'StackParentData', x: 160.0, y: 196.0, colour: _kStack, width: 150.0),
    _HierarchyNode(label: 'ContainerBoxParentData', x: 320.0, y: 196.0, colour: _kMixin, width: 200.0),
    _HierarchyNode(label: 'MultiChildLayoutParentData', x: 530.0, y: 196.0, colour: _kData, width: 220.0),
  ];
  const List<_HierarchyEdge> hierarchyEdges = <_HierarchyEdge>[
    _HierarchyEdge(from: 0, to: 1),
    _HierarchyEdge(from: 0, to: 2),
    _HierarchyEdge(from: 0, to: 3),
    _HierarchyEdge(from: 1, to: 4),
    _HierarchyEdge(from: 1, to: 5),
    _HierarchyEdge(from: 1, to: 6),
    _HierarchyEdge(from: 1, to: 7),
  ];
  final Widget hierarchyCard = _card(
    padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 18.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'Class hierarchy',
          subtitle: 'ParentData -> BoxParentData / SliverLogicalParentData / SliverPhysicalParentData and beyond',
          icon: Icons.schema,
          iconColor: _kLayout,
        ),
        const SizedBox(height: 14.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            width: 760.0,
            height: 260.0,
            child: CustomPaint(
              painter: _HierarchyPainter(
                nodes: hierarchyNodes,
                edges: hierarchyEdges,
              ),
            ),
          ),
        ),
        const SizedBox(height: 14.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 6.0,
          children: <Widget>[
            _pill('root: ParentData', colour: _kInk),
            _pill('box subtree: BoxParentData', colour: _kLayout),
            _pill('sliver: SliverLogicalParentData', colour: _kSliver),
            _pill('sliver: SliverPhysicalParentData', colour: _kSliver),
            _pill('flex: FlexParentData', colour: _kFlex),
            _pill('stack: StackParentData', colour: _kStack),
            _pill('container mixin: ContainerBoxParentData<T>', colour: _kMixin),
          ],
        ),
        const SizedBox(height: 10.0),
        const Text(
          'BoxParentData is the trunk for box-protocol renderers. It already '
          'carries an `offset` field that downstream classes inherit. Sliver '
          'parent data forms a separate branch because slivers measure '
          'differently (extents, not Cartesian boxes). ContainerBoxParentData '
          'mixes in linked-list pointers so the parent can walk children.',
          style: _kBodyStyle,
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 3 - BOX ANATOMY DIAGRAM
  // -------------------------------------------------------------------------
  // `BoxParentData.offset` is the single most important field in the layer.
  // We draw it explicitly: parent box at the outside, child box positioned
  // by an offset arrow, and a caption.
  // -------------------------------------------------------------------------
  final Widget boxAnatomyCard = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'BoxParentData anatomy',
          subtitle: 'How `offset` carries position from layout into paint',
          icon: Icons.crop_square,
          iconColor: _kData,
        ),
        const SizedBox(height: 14.0),
        SizedBox(
          height: 240.0,
          width: double.infinity,
          child: CustomPaint(painter: const _BoxAnatomyPainter()),
        ),
        const SizedBox(height: 14.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: _kLayout.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: _kLayout.withOpacity(0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        const Icon(Icons.architecture, size: 16.0, color: _kLayout),
                        const SizedBox(width: 6.0),
                        Text('performLayout()', style: TextStyle(color: _kLayout, fontWeight: FontWeight.w700, fontSize: 12.5, fontFamily: 'monospace')),
                      ],
                    ),
                    const SizedBox(height: 6.0),
                    const Text(
                      'Parent calls child.layout(constraints, parentUsesSize: true), '
                      'then writes the resolved Offset into child.parentData.offset.',
                      style: _kBodyStyle,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: _kPaint.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: _kPaint.withOpacity(0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        const Icon(Icons.format_paint, size: 16.0, color: _kPaint),
                        const SizedBox(width: 6.0),
                        Text('paint()', style: TextStyle(color: _kPaint, fontWeight: FontWeight.w700, fontSize: 12.5, fontFamily: 'monospace')),
                      ],
                    ),
                    const SizedBox(height: 6.0),
                    const Text(
                      'Parent calls context.paintChild(child, offset + childParentData.offset). '
                      'The offset is the only thing the paint phase needs.',
                      style: _kBodyStyle,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        _codeBlock(
          '// inside RenderMyContainer.performLayout()\n'
          'final BoxParentData cpd = child.parentData! as BoxParentData;\n'
          'cpd.offset = Offset(44.0, 44.0);\n'
          '\n'
          '// inside RenderMyContainer.paint()\n'
          'final BoxParentData cpd = child.parentData! as BoxParentData;\n'
          'context.paintChild(child, offset + cpd.offset);',
          title: 'box_parent_data_usage.dart',
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 4 - FLEXPARENTDATA GALLERY
  // -------------------------------------------------------------------------
  // Six children of a Row, each wrapped in either Expanded (FlexFit.tight)
  // or Flexible (FlexFit.loose) with different flex weights. Side-by-side
  // we render annotation cards that list the resolved FlexParentData
  // fields (flex, fit) and the inherited `offset` field placeholder.
  // -------------------------------------------------------------------------
  Widget _flexChild(String label, Color colour, {required int flex, required FlexFit fit}) {
    final Widget body = Container(
      height: 56.0,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: colour.withOpacity(0.18),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: colour, width: 1.2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
              color: colour,
            ),
          ),
          const SizedBox(height: 2.0),
          Text(
            'flex $flex / ${fit == FlexFit.tight ? 'tight' : 'loose'}',
            style: const TextStyle(
              fontSize: 10.5,
              color: _kInkSecondary,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
    if (fit == FlexFit.tight) {
      return Expanded(flex: flex, child: body);
    }
    return Flexible(flex: flex, fit: FlexFit.loose, child: body);
  }

  Widget _flexAnnotation(String label, Color colour, {required int flex, required FlexFit fit}) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.only(bottom: 8.0),
      decoration: BoxDecoration(
        color: colour.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: colour.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(width: 8.0, height: 8.0, decoration: BoxDecoration(color: colour, shape: BoxShape.circle)),
              const SizedBox(width: 6.0),
              Text(label, style: TextStyle(color: colour, fontWeight: FontWeight.w700, fontSize: 12.5, fontFamily: 'monospace')),
            ],
          ),
          const SizedBox(height: 4.0),
          _kvRow('flex', flex.toString()),
          _kvRow('fit', fit == FlexFit.tight ? 'FlexFit.tight' : 'FlexFit.loose'),
          _kvRow('offset', '<computed by Row>'),
        ],
      ),
    );
  }

  final Widget flexGalleryRow = Row(
    children: <Widget>[
      _flexChild('A', _kFlex, flex: 1, fit: FlexFit.tight),
      const SizedBox(width: 6.0),
      _flexChild('B', _kLayout, flex: 2, fit: FlexFit.tight),
      const SizedBox(width: 6.0),
      _flexChild('C', _kData, flex: 3, fit: FlexFit.tight),
      const SizedBox(width: 6.0),
      _flexChild('D', _kPaint, flex: 1, fit: FlexFit.loose),
      const SizedBox(width: 6.0),
      _flexChild('E', _kMixin, flex: 2, fit: FlexFit.loose),
      const SizedBox(width: 6.0),
      _flexChild('F', _kStack, flex: 3, fit: FlexFit.loose),
    ],
  );

  final Widget flexGalleryCard = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'FlexParentData gallery',
          subtitle: 'Row with six children: three Expanded (tight) and three Flexible (loose)',
          icon: Icons.view_week,
          iconColor: _kFlex,
        ),
        const SizedBox(height: 12.0),
        flexGalleryRow,
        const SizedBox(height: 14.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _flexAnnotation('A: Expanded(flex: 1)', _kFlex, flex: 1, fit: FlexFit.tight),
                  _flexAnnotation('B: Expanded(flex: 2)', _kLayout, flex: 2, fit: FlexFit.tight),
                  _flexAnnotation('C: Expanded(flex: 3)', _kData, flex: 3, fit: FlexFit.tight),
                ],
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _flexAnnotation('D: Flexible(flex: 1)', _kPaint, flex: 1, fit: FlexFit.loose),
                  _flexAnnotation('E: Flexible(flex: 2)', _kMixin, flex: 2, fit: FlexFit.loose),
                  _flexAnnotation('F: Flexible(flex: 3)', _kStack, flex: 3, fit: FlexFit.loose),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: _kFlex.withOpacity(0.08),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: _kFlex.withOpacity(0.35)),
          ),
          child: Row(
            children: const <Widget>[
              Icon(Icons.info_outline, color: _kFlex, size: 18.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'FlexParentData extends ContainerBoxParentData<RenderBox>. It '
                  'adds two writable fields - `int? flex` and `FlexFit? fit` - and '
                  'inherits `offset` from BoxParentData. RenderFlex reads them in '
                  'two layout passes: first to size tight children, then to size '
                  'flexible ones.',
                  style: _kBodyStyle,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 5 - STACKPARENTDATA GALLERY
  // -------------------------------------------------------------------------
  // Five Positioned children inside a Stack, each demonstrating a different
  // combination of top/left/right/bottom/width/height. Adjacent annotation
  // cards display the resolved StackParentData fields.
  // -------------------------------------------------------------------------
  Widget _stackChip(String label, Color colour) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: colour,
        borderRadius: BorderRadius.circular(6.0),
        boxShadow: const <BoxShadow>[
          BoxShadow(color: Color(0x22000000), offset: Offset(0.0, 1.0), blurRadius: 2.0),
        ],
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFFFFFFFF),
          fontSize: 11.0,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _stackAnnotation({
    required String label,
    required Color colour,
    double? top,
    double? left,
    double? right,
    double? bottom,
    double? width,
    double? height,
  }) {
    String fmt(double? v) => v == null ? 'null' : v.toStringAsFixed(1);
    final bool positioned = top != null ||
        left != null ||
        right != null ||
        bottom != null ||
        width != null ||
        height != null;
    return Container(
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.only(bottom: 8.0),
      decoration: BoxDecoration(
        color: colour.withOpacity(0.06),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: colour.withOpacity(0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(width: 8.0, height: 8.0, decoration: BoxDecoration(color: colour, shape: BoxShape.circle)),
              const SizedBox(width: 6.0),
              Text(label, style: TextStyle(color: colour, fontWeight: FontWeight.w700, fontSize: 12.5, fontFamily: 'monospace')),
            ],
          ),
          const SizedBox(height: 4.0),
          _kvRow('top', fmt(top)),
          _kvRow('left', fmt(left)),
          _kvRow('right', fmt(right)),
          _kvRow('bottom', fmt(bottom)),
          _kvRow('width', fmt(width)),
          _kvRow('height', fmt(height)),
          _kvRow('isPositioned', positioned.toString(), valueColour: positioned ? _kData : _kInkTertiary),
        ],
      ),
    );
  }

  final Widget stackVisual = Container(
    height: 260.0,
    decoration: BoxDecoration(
      color: const Color(0xFFF8F9FC),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: _kHairline),
    ),
    child: Stack(
      children: <Widget>[
        // P1 - top/left only.
        Positioned(top: 10.0, left: 10.0, child: _stackChip('P1 t=10 l=10', _kStack)),
        // P2 - top/right with explicit width.
        Positioned(top: 10.0, right: 10.0, width: 90.0, child: _stackChip('P2 t/r/w', _kLayout)),
        // P3 - bottom/left with explicit width+height.
        Positioned(bottom: 14.0, left: 12.0, width: 110.0, height: 36.0, child: _stackChip('P3 b/l/w/h', _kData)),
        // P4 - centred via left+right (stretched).
        Positioned(top: 110.0, left: 60.0, right: 60.0, height: 32.0, child: _stackChip('P4 t/l/r stretch', _kPaint)),
        // P5 - bottom+right + width + height (anchor bottom-right).
        Positioned(right: 16.0, bottom: 16.0, width: 100.0, height: 36.0, child: _stackChip('P5 br/w/h', _kMixin)),
      ],
    ),
  );

  final Widget stackGalleryCard = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'StackParentData gallery',
          subtitle: 'Five Positioned children with different anchor combinations',
          icon: Icons.layers,
          iconColor: _kStack,
        ),
        const SizedBox(height: 12.0),
        stackVisual,
        const SizedBox(height: 14.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _stackAnnotation(label: 'P1: top/left', colour: _kStack, top: 10.0, left: 10.0),
                  _stackAnnotation(label: 'P2: top/right/width', colour: _kLayout, top: 10.0, right: 10.0, width: 90.0),
                  _stackAnnotation(label: 'P3: bottom/left + size', colour: _kData, bottom: 14.0, left: 12.0, width: 110.0, height: 36.0),
                ],
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _stackAnnotation(label: 'P4: t/l/r stretch', colour: _kPaint, top: 110.0, left: 60.0, right: 60.0, height: 32.0),
                  _stackAnnotation(label: 'P5: br anchor', colour: _kMixin, right: 16.0, bottom: 16.0, width: 100.0, height: 36.0),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: _kHairline,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: const Text(
                      'Bare children (no Positioned) leave StackParentData '
                      'with all nulls. They are laid out according to the '
                      'Stack.alignment and StackFit policies instead of the '
                      'PD fields.',
                      style: _kBodyStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 6 - SLIVERPHYSICALPARENTDATA GALLERY
  // -------------------------------------------------------------------------
  // A small static CustomScrollView with three slivers. We do not scroll it
  // (the gallery is static) so we wrap it in a SizedBox of generous height.
  // Three annotation cards show what `SliverPhysicalParentData.paintOffset`
  // looks like for each sliver.
  // -------------------------------------------------------------------------
  Widget _sliverAnnotation(String label, Color colour, String paintOffset, String constraints) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.only(bottom: 8.0),
      decoration: BoxDecoration(
        color: colour.withOpacity(0.06),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: colour.withOpacity(0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(width: 8.0, height: 8.0, decoration: BoxDecoration(color: colour, shape: BoxShape.circle)),
              const SizedBox(width: 6.0),
              Text(label, style: TextStyle(color: colour, fontWeight: FontWeight.w700, fontSize: 12.5, fontFamily: 'monospace')),
            ],
          ),
          const SizedBox(height: 4.0),
          _kvRow('paintOffset', paintOffset),
          _kvRow('constraints', constraints),
        ],
      ),
    );
  }

  final Widget sliverVisual = Container(
    height: 320.0,
    decoration: BoxDecoration(
      color: const Color(0xFFF8F9FC),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: _kHairline),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: CustomScrollView(
        physics: const NeverScrollableScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 80.0,
            backgroundColor: _kSliver,
            flexibleSpace: const FlexibleSpaceBar(
              title: Text(
                'SliverAppBar',
                style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 14.0, fontWeight: FontWeight.w700),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(<Widget>[
              for (int i = 0; i < 3; i++)
                Container(
                  height: 36.0,
                  margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: _kLayout.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6.0),
                    border: Border.all(color: _kLayout.withOpacity(0.3)),
                  ),
                  child: Text(
                    'SliverList item $i',
                    style: const TextStyle(color: _kInk, fontSize: 12.5, fontWeight: FontWeight.w600),
                  ),
                ),
            ]),
          ),
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 6.0,
              crossAxisSpacing: 6.0,
              childAspectRatio: 1.8,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext _, int i) {
                return Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: _kData.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6.0),
                    border: Border.all(color: _kData.withOpacity(0.3)),
                  ),
                  child: Text(
                    'G$i',
                    style: const TextStyle(color: _kData, fontWeight: FontWeight.w700),
                  ),
                );
              },
              childCount: 6,
            ),
          ),
        ],
      ),
    ),
  );

  final Widget sliverGalleryCard = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'SliverPhysicalParentData gallery',
          subtitle: 'CustomScrollView with SliverAppBar + SliverList + SliverGrid',
          icon: Icons.list_alt,
          iconColor: _kSliver,
        ),
        const SizedBox(height: 12.0),
        sliverVisual,
        const SizedBox(height: 14.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _sliverAnnotation(
                    'SliverAppBar (pinned)',
                    _kSliver,
                    'Offset(0.0, 0.0)',
                    'scrollOffset = 0.0 / remainingPaintExtent = 320.0',
                  ),
                  _sliverAnnotation(
                    'SliverList',
                    _kLayout,
                    'Offset(0.0, 80.0)',
                    'scrollOffset = 0.0 / cacheOrigin = 0.0',
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _sliverAnnotation(
                    'SliverGrid',
                    _kData,
                    'Offset(0.0, 212.0)',
                    'scrollOffset = 0.0 / crossAxisExtent = full',
                  ),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: _kSliver.withOpacity(0.06),
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: _kSliver.withOpacity(0.3)),
                    ),
                    child: Row(
                      children: const <Widget>[
                        Icon(Icons.compare_arrows, color: _kSliver, size: 16.0),
                        SizedBox(width: 6.0),
                        Expanded(
                          child: Text(
                            'Physical PD stores the FULL Offset for paint translation. '
                            'Logical PD stores only the scalar `layoutOffset` along the '
                            'main axis - cheaper, used by Viewports.',
                            style: _kBodyStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 7 - PARENTDATAWIDGET CODE-BLOCK GALLERY
  // -------------------------------------------------------------------------
  // ParentDataWidget<T extends ParentData> is the widget-layer adapter that
  // writes ParentData onto its descendant RenderObject. The framework calls
  // `applyParentData(RenderObject)` during the build phase. We show four
  // first-party specialisations: Expanded, Flexible, Positioned, Align.
  // -------------------------------------------------------------------------
  final Widget parentDataWidgetSection = Column(
    children: <Widget>[
      _codeBlock(
        '// Expanded: writes flex=N, fit=FlexFit.tight into FlexParentData.\n'
        'class Expanded extends Flexible {\n'
        '  const Expanded({super.key, super.flex = 1, required super.child})\n'
        '      : super(fit: FlexFit.tight);\n'
        '}',
        title: 'expanded.dart',
      ),
      _codeBlock(
        '// Flexible: ParentDataWidget<FlexParentData>; writes flex + fit.\n'
        'class Flexible extends ParentDataWidget<FlexParentData> {\n'
        '  const Flexible({super.key, this.flex = 1, this.fit = FlexFit.loose,\n'
        '                  required super.child});\n'
        '  final int flex;\n'
        '  final FlexFit fit;\n'
        '\n'
        '  @override\n'
        '  void applyParentData(RenderObject renderObject) {\n'
        '    final FlexParentData pd = renderObject.parentData! as FlexParentData;\n'
        '    bool needsLayout = false;\n'
        '    if (pd.flex != flex) { pd.flex = flex; needsLayout = true; }\n'
        '    if (pd.fit != fit) { pd.fit = fit; needsLayout = true; }\n'
        '    if (needsLayout) (renderObject.parent as RenderObject?)?.markNeedsLayout();\n'
        '  }\n'
        '\n'
        '  @override\n'
        '  Type get debugTypicalAncestorWidgetClass => Flex;\n'
        '}',
        title: 'flexible.dart',
      ),
      _codeBlock(
        '// Positioned: ParentDataWidget<StackParentData>; writes anchor fields.\n'
        'class Positioned extends ParentDataWidget<StackParentData> {\n'
        '  const Positioned({super.key, this.left, this.top, this.right,\n'
        '                    this.bottom, this.width, this.height,\n'
        '                    required super.child});\n'
        '\n'
        '  @override\n'
        '  void applyParentData(RenderObject renderObject) {\n'
        '    final StackParentData pd = renderObject.parentData! as StackParentData;\n'
        '    bool needsLayout = false;\n'
        '    if (pd.left != left)     { pd.left = left;     needsLayout = true; }\n'
        '    if (pd.top != top)       { pd.top = top;       needsLayout = true; }\n'
        '    if (pd.right != right)   { pd.right = right;   needsLayout = true; }\n'
        '    if (pd.bottom != bottom) { pd.bottom = bottom; needsLayout = true; }\n'
        '    if (pd.width != width)   { pd.width = width;   needsLayout = true; }\n'
        '    if (pd.height != height) { pd.height = height; needsLayout = true; }\n'
        '    if (needsLayout) (renderObject.parent as RenderObject?)?.markNeedsLayout();\n'
        '  }\n'
        '}',
        title: 'positioned.dart',
      ),
      _codeBlock(
        '// Align (Positioned variant): same family. Writes\n'
        '// StackParentData.left/top/width/height computed from Alignment.\n'
        'class PositionedAlign extends ParentDataWidget<StackParentData> {\n'
        '  const PositionedAlign({super.key, required this.alignment,\n'
        '                         required super.child});\n'
        '  final AlignmentGeometry alignment;\n'
        '\n'
        '  @override\n'
        '  void applyParentData(RenderObject renderObject) {\n'
        '    // simplified: just set top/left based on alignment.\n'
        '    final StackParentData pd = renderObject.parentData! as StackParentData;\n'
        '    pd.left ??= 0.0;\n'
        '    pd.top  ??= 0.0;\n'
        '    (renderObject.parent as RenderObject?)?.markNeedsLayout();\n'
        '  }\n'
        '}',
        title: 'align_as_parentdata.dart',
      ),
    ],
  );

  // -------------------------------------------------------------------------
  // SECTION 8 - CUSTOM PARENTDATAWIDGET WALKTHROUGH
  // -------------------------------------------------------------------------
  // Five-card walkthrough for authoring a `MyTagParentDataWidget`:
  //
  //   Card 1: Define the ParentData subclass with the new field.
  //   Card 2: Define the ParentDataWidget that writes the field.
  //   Card 3: Define the MultiChildRenderObjectWidget host.
  //   Card 4: Define the RenderBox parent that wires `setupParentData`.
  //   Card 5: Read the field during paint() to do something useful.
  //
  // Code only - no runtime execution.
  // -------------------------------------------------------------------------
  Widget _walkthroughCard(int step, String title, String body, String code) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: _kHairline),
        boxShadow: const <BoxShadow>[
          BoxShadow(color: Color(0x0D000000), offset: Offset(0.0, 1.0), blurRadius: 3.0),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 14.0, 16.0, 6.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 28.0,
                  height: 28.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: _kMixin,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '$step',
                    style: const TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontWeight: FontWeight.w700,
                      fontSize: 13.0,
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w700,
                          color: _kInk,
                          letterSpacing: -0.2,
                        ),
                      ),
                      const SizedBox(height: 2.0),
                      Text(body, style: _kBodyStyle),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: _kCodeBg,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(code, style: _kCodeStyle),
          ),
        ],
      ),
    );
  }

  final Widget walkthroughSection = Column(
    children: <Widget>[
      _walkthroughCard(
        1,
        'Define the ParentData subclass',
        'Extends ContainerBoxParentData<RenderBox> so the parent can keep a '
            'doubly linked list of children. Adds the custom `tag` field.',
        '// my_tag_parent_data.dart\n'
        'class MyTagParentData extends ContainerBoxParentData<RenderBox> {\n'
        '  String? tag; // custom per-child metadata.\n'
        '}',
      ),
      _walkthroughCard(
        2,
        'Define the ParentDataWidget',
        'ParentDataWidget<MyTagParentData> that writes `tag` into the '
            'child\'s parent data and asks the parent to re-layout when changed.',
        '// my_tag.dart\n'
        'class MyTag extends ParentDataWidget<MyTagParentData> {\n'
        '  const MyTag({super.key, required this.tag, required super.child});\n'
        '  final String tag;\n'
        '\n'
        '  @override\n'
        '  void applyParentData(RenderObject renderObject) {\n'
        '    final MyTagParentData pd =\n'
        '        renderObject.parentData! as MyTagParentData;\n'
        '    if (pd.tag != tag) {\n'
        '      pd.tag = tag;\n'
        '      (renderObject.parent as RenderObject?)?.markNeedsLayout();\n'
        '    }\n'
        '  }\n'
        '\n'
        '  @override\n'
        '  Type get debugTypicalAncestorWidgetClass => MyTaggedRow;\n'
        '}',
      ),
      _walkthroughCard(
        3,
        'Define the MultiChildRenderObjectWidget host',
        'The widget layer counterpart of the custom RenderObject. It '
            'creates the parent RenderBox during `createRenderObject`.',
        '// my_tagged_row.dart\n'
        'class MyTaggedRow extends MultiChildRenderObjectWidget {\n'
        '  const MyTaggedRow({super.key, super.children = const <Widget>[]});\n'
        '\n'
        '  @override\n'
        '  RenderMyTaggedRow createRenderObject(BuildContext context) {\n'
        '    return RenderMyTaggedRow();\n'
        '  }\n'
        '}',
      ),
      _walkthroughCard(
        4,
        'Define the RenderBox + setupParentData',
        'The parent RenderObject mixes in ContainerRenderObjectMixin and '
            'RenderBoxContainerDefaultsMixin. Override `setupParentData` so '
            'each child receives a MyTagParentData on attach.',
        '// render_my_tagged_row.dart\n'
        'class RenderMyTaggedRow extends RenderBox\n'
        '    with ContainerRenderObjectMixin<RenderBox, MyTagParentData>,\n'
        '         RenderBoxContainerDefaultsMixin<RenderBox, MyTagParentData> {\n'
        '\n'
        '  @override\n'
        '  void setupParentData(RenderBox child) {\n'
        '    if (child.parentData is! MyTagParentData) {\n'
        '      child.parentData = MyTagParentData();\n'
        '    }\n'
        '  }\n'
        '\n'
        '  @override\n'
        '  void performLayout() {\n'
        '    double x = 0.0;\n'
        '    RenderBox? c = firstChild;\n'
        '    while (c != null) {\n'
        '      c.layout(constraints.loosen(), parentUsesSize: true);\n'
        '      final MyTagParentData pd = c.parentData! as MyTagParentData;\n'
        '      pd.offset = Offset(x, 0.0);\n'
        '      x += c.size.width;\n'
        '      c = pd.nextSibling;\n'
        '    }\n'
        '    size = Size(x, constraints.maxHeight);\n'
        '  }\n'
        '}',
      ),
      _walkthroughCard(
        5,
        'Read the tag during paint',
        'In `paint()` we walk the linked list, ask each child for its '
            'MyTagParentData, and tint a small overlay if the tag is set. '
            'This is the moment where parent-data round-trips into pixels.',
        '@override\n'
        'void paint(PaintingContext context, Offset offset) {\n'
        '  RenderBox? c = firstChild;\n'
        '  while (c != null) {\n'
        '    final MyTagParentData pd = c.parentData! as MyTagParentData;\n'
        '    context.paintChild(c, offset + pd.offset);\n'
        '\n'
        '    if (pd.tag != null) {\n'
        '      context.canvas.drawRect(\n'
        '        (offset + pd.offset) & c.size,\n'
        '        Paint()..color = const Color(0x33FF8A2A),\n'
        '      );\n'
        '    }\n'
        '    c = pd.nextSibling;\n'
        '  }\n'
        '}',
      ),
    ],
  );

  // -------------------------------------------------------------------------
  // SECTION 9 - PITFALLS
  // -------------------------------------------------------------------------
  // Five common rookie mistakes with ParentData. Each item lives in its own
  // tile with a red accent and an icon. We deliberately overshoot a little
  // (5 cards) so the section reads like an "actual checklist".
  // -------------------------------------------------------------------------
  Widget _pitfallCard(int idx, IconData icon, String title, String body, String hint) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 6.0),
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: _kPitfall.withOpacity(0.06),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: _kPitfall.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 32.0,
                height: 32.0,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: _kPitfall,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 16.0, color: const Color(0xFFFFFFFF)),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          'Pitfall $idx',
                          style: const TextStyle(
                            color: _kPitfall,
                            fontWeight: FontWeight.w700,
                            fontSize: 11.5,
                            letterSpacing: 0.3,
                          ),
                        ),
                        const SizedBox(width: 6.0),
                        Container(width: 4.0, height: 4.0, decoration: const BoxDecoration(color: _kPitfall, shape: BoxShape.circle)),
                        const SizedBox(width: 6.0),
                        Expanded(
                          child: Text(
                            title,
                            style: const TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w700,
                              color: _kInk,
                              letterSpacing: -0.2,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4.0),
                    Text(body, style: _kBodyStyle),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: const Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: _kHairline),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Icon(Icons.tips_and_updates, color: _kData, size: 16.0),
                const SizedBox(width: 8.0),
                Expanded(child: Text(hint, style: _kBodyStyle)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final Widget pitfallsSection = Column(
    children: <Widget>[
      _pitfallCard(
        1,
        Icons.error_outline,
        'Wrong parent-data type',
        'Wrapping a child with the wrong ParentDataWidget (e.g. Positioned '
            'directly inside a Row) crashes at build time with a long stack '
            'trace from `debugTypicalAncestorWidgetClass`.',
        'Match the ParentDataWidget to its host: Expanded/Flexible inside '
            'Row/Column/Flex, Positioned inside Stack, custom widgets inside '
            'their custom multi-child host.',
      ),
      _pitfallCard(
        2,
        Icons.layers_clear,
        'Missing ContainerParentDataMixin',
        'If the parent walks children via `firstChild`/`nextSibling`, the '
            'ParentData class MUST mix in ContainerParentDataMixin (typically '
            'through ContainerBoxParentData<T>). Otherwise the linked list is '
            'empty and you paint nothing.',
        'Always extend ContainerBoxParentData<RenderBox> for box children, '
            'or mix in ContainerParentDataMixin<RenderSliver> for sliver '
            'children.',
      ),
      _pitfallCard(
        3,
        Icons.build_circle,
        'Forgetting setupParentData',
        'The parent RenderObject must override `setupParentData(child)` and '
            'attach an instance of the correct ParentData subclass. The '
            'default implementation attaches a vanilla `ParentData` which '
            'lacks `offset`, `tag`, etc.',
        'Override setupParentData and check `if (child.parentData is! MyPD) '
            'child.parentData = MyPD();` for every child type you accept.',
      ),
      _pitfallCard(
        4,
        Icons.lock_clock,
        'Mutating ParentData after layout',
        'ParentData fields are meant to be written ONLY during the parent\'s '
            'layout pass. Mutating them from paint() or hitTest() leads to '
            'flickers, stale assertions and broken hit testing - the '
            'framework will not re-run layout for you.',
        'Treat parent data as write-once-per-frame. If you need a runtime '
            'override, surface it as a property on your ParentDataWidget and '
            'call `markNeedsLayout()` so a fresh pass happens.',
      ),
      _pitfallCard(
        5,
        Icons.brush,
        'Painting with stale offsets',
        'Some renderers cache `pd.offset` into local variables across '
            'frames. After a re-layout the cached values are stale and the '
            'child paints at the previous position - a classic ghosting bug.',
        'Always read `child.parentData! as BoxParentData` at the top of '
            '`paint()`. Never close over offsets in deferred callbacks.',
      ),
    ],
  );

  // -------------------------------------------------------------------------
  // SECTION 10 - COMPARISON TABLE
  // -------------------------------------------------------------------------
  // Three-column comparison: BoxParentData vs SliverPhysicalParentData vs
  // a custom ParentData (the MyTagParentData from Section 8). The table is
  // implemented as a Column of Rows so it works inside the ListView.
  // -------------------------------------------------------------------------
  Widget _comparisonHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: _kCardDark,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
      ),
      child: Row(
        children: const <Widget>[
          SizedBox(
            width: 110.0,
            child: Text(
              'aspect',
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 12.0,
                fontWeight: FontWeight.w700,
                fontFamily: 'monospace',
              ),
            ),
          ),
          Expanded(
            child: Text(
              'BoxParentData',
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 12.0,
                fontWeight: FontWeight.w700,
                fontFamily: 'monospace',
              ),
            ),
          ),
          Expanded(
            child: Text(
              'SliverPhysicalParentData',
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 12.0,
                fontWeight: FontWeight.w700,
                fontFamily: 'monospace',
              ),
            ),
          ),
          Expanded(
            child: Text(
              'custom (MyTagParentData)',
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 12.0,
                fontWeight: FontWeight.w700,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _comparisonRow(String key, String a, String b, String c, {bool isLast = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        border: Border(
          left: const BorderSide(color: _kHairline),
          right: const BorderSide(color: _kHairline),
          bottom: BorderSide(color: isLast ? _kHairline : _kHairline),
        ),
        borderRadius: isLast
            ? const BorderRadius.only(
                bottomLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
              )
            : null,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 110.0,
            child: Text(
              key,
              style: const TextStyle(
                color: _kInkSecondary,
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
                fontFamily: 'monospace',
              ),
            ),
          ),
          Expanded(child: Text(a, style: _kMonoStyle)),
          Expanded(child: Text(b, style: _kMonoStyle)),
          Expanded(child: Text(c, style: _kMonoStyle)),
        ],
      ),
    );
  }

  final Widget comparisonTable = Container(
    margin: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 6.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      boxShadow: const <BoxShadow>[
        BoxShadow(color: Color(0x0D000000), offset: Offset(0.0, 1.0), blurRadius: 3.0),
      ],
    ),
    child: Column(
      children: <Widget>[
        _comparisonHeader(),
        _comparisonRow('protocol', 'box', 'sliver', 'box (custom)'),
        _comparisonRow('extends', 'ParentData', 'ParentData', 'ContainerBoxParentData<RenderBox>'),
        _comparisonRow('container?', 'no (use ContainerBoxParentData<T>)', 'no (use mixin)', 'yes (linked list)'),
        _comparisonRow('main field', 'offset: Offset', 'paintOffset: Offset', 'tag: String?, plus offset'),
        _comparisonRow('axis', '2D (x, y)', '1D scroll + 2D paint', '2D (x, y)'),
        _comparisonRow('written by', 'parent.performLayout', 'viewport.performLayout', 'parent.performLayout'),
        _comparisonRow('read by', 'parent.paint', 'viewport.paint', 'parent.paint'),
        _comparisonRow('typical use', 'flex / stack / align', 'CustomScrollView slivers', 'tagged group rendering', isLast: true),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 11 - CHEAT SHEET FOOTER
  // -------------------------------------------------------------------------
  // Four chip groups (Classes, Mixins, Widgets, Render layer) plus an API
  // tagline at the bottom. Each group lives on a dark card so the chips
  // pop visually.
  // -------------------------------------------------------------------------
  Widget _chipGroup(String title, List<Widget> chips, IconData icon, Color accent) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: const Color(0xFF26282F),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: _kHairlineDark),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(icon, color: accent, size: 16.0),
              const SizedBox(width: 6.0),
              Text(
                title,
                style: TextStyle(
                  color: accent,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Wrap(
            spacing: 6.0,
            runSpacing: 6.0,
            children: chips,
          ),
        ],
      ),
    );
  }

  final Widget cheatSheet = Container(
    margin: const EdgeInsets.fromLTRB(18.0, 8.0, 18.0, 24.0),
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: _kCardDark,
      borderRadius: BorderRadius.circular(16.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: const <Widget>[
            Icon(Icons.bookmark, color: Color(0xFFFFD60A), size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Cheat Sheet',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w700,
                color: Color(0xFFFFFFFF),
                letterSpacing: -0.3,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4.0),
        const Text(
          'The ParentData vocabulary you actually use.',
          style: TextStyle(fontSize: 12.0, color: _kInkOnDarkSecondary),
        ),
        const SizedBox(height: 14.0),
        _chipGroup(
          'Classes',
          <Widget>[
            _chipSolid('ParentData', colour: _kInkSecondary),
            _chipSolid('BoxParentData', colour: _kLayout),
            _chipSolid('FlexParentData', colour: _kFlex),
            _chipSolid('StackParentData', colour: _kStack),
            _chipSolid('SliverLogicalParentData', colour: _kSliver),
            _chipSolid('SliverPhysicalParentData', colour: _kSliver),
            _chipSolid('MultiChildLayoutParentData', colour: _kData),
          ],
          Icons.class_,
          _kCodeAccent,
        ),
        _chipGroup(
          'Mixins',
          <Widget>[
            _chipSolid('ContainerParentDataMixin<ChildType>', colour: _kMixin),
            _chipSolid('ContainerBoxParentData<RenderBox>', colour: _kMixin),
            _chipSolid('ContainerRenderObjectMixin', colour: _kMixin),
            _chipSolid('RenderBoxContainerDefaultsMixin', colour: _kMixin),
          ],
          Icons.merge,
          _kMixin,
        ),
        _chipGroup(
          'ParentDataWidgets',
          <Widget>[
            _chipSolid('Expanded', colour: _kFlex),
            _chipSolid('Flexible', colour: _kFlex),
            _chipSolid('Positioned', colour: _kStack),
            _chipSolid('Positioned.fill', colour: _kStack),
            _chipSolid('Positioned.directional', colour: _kStack),
            _chipSolid('PositionedDirectional', colour: _kStack),
            _chipSolid('LayoutId', colour: _kData),
            _chipSolid('KeepAlive', colour: _kSliver),
          ],
          Icons.widgets,
          _kData,
        ),
        _chipGroup(
          'Render layer',
          <Widget>[
            _chipSolid('RenderObject.setupParentData', colour: _kLayout),
            _chipSolid('RenderObject.attach', colour: _kLayout),
            _chipSolid('RenderBox.parentData', colour: _kLayout),
            _chipSolid('PaintingContext.paintChild', colour: _kPaint),
            _chipSolid('markNeedsLayout', colour: _kPaint),
          ],
          Icons.engineering,
          _kPaint,
        ),
        const SizedBox(height: 6.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: const Color(0xFF2C2C2E),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: _kHairlineDark),
          ),
          child: Row(
            children: const <Widget>[
              Icon(Icons.code, color: Color(0xFFFFD60A), size: 18.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'API tagline: Parents own the layout, children own themselves, '
                  'ParentData is the contract between them. Write fields during '
                  'performLayout, read them during paint, never the other way around.',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: _kInkOnDark,
                    height: 1.45,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // ASSEMBLE THE FULL SCROLLABLE GALLERY
  // -------------------------------------------------------------------------
  // Each section is preceded by a numbered header. Sections that have a
  // single visual card are followed by that card directly. Sections that
  // have multiple cards (7, 8, 9) follow a `Column` of cards. The final
  // tree lives inside a MaterialApp + Scaffold + SingleChildScrollView.
  // -------------------------------------------------------------------------
  print('  building widget tree with 11 sections');
  final List<Widget> sectionWidgets = <Widget>[
    heroIntro,
    _sectionHeader(2, 'Class hierarchy', 'ParentData tree painted as a diagram', accent: _kLayout),
    hierarchyCard,
    _sectionHeader(3, 'BoxParentData anatomy', 'offset carries position from layout to paint', accent: _kData),
    boxAnatomyCard,
    _sectionHeader(4, 'FlexParentData gallery', 'flex weights and FlexFit policies', accent: _kFlex),
    flexGalleryCard,
    _sectionHeader(5, 'StackParentData gallery', 'Positioned anchors and stretch', accent: _kStack),
    stackGalleryCard,
    _sectionHeader(6, 'SliverPhysicalParentData', 'CustomScrollView with three slivers', accent: _kSliver),
    sliverGalleryCard,
    _sectionDivider(),
    _sectionHeader(7, 'ParentDataWidget snippets', 'Expanded / Flexible / Positioned / Align', accent: _kFlex),
    parentDataWidgetSection,
    _sectionHeader(8, 'Custom ParentDataWidget', 'Walkthrough: MyTagParentData', accent: _kMixin),
    walkthroughSection,
    _sectionHeader(9, 'Pitfalls', 'Five common mistakes', accent: _kPitfall),
    pitfallsSection,
    _sectionHeader(10, 'Comparison', 'Box vs Sliver vs custom', accent: _kLayout),
    comparisonTable,
    _sectionHeader(11, 'Cheat sheet', 'Vocabulary at a glance', accent: _kInk),
    cheatSheet,
  ];
  print('  section widget count: ${sectionWidgets.length}');

  final Widget app = MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'ParentData visual demo',
    theme: ThemeData(
      brightness: Brightness.light,
      primaryColor: _kLayout,
      scaffoldBackgroundColor: _kCanvas,
      textTheme: const TextTheme(),
    ),
    home: Scaffold(
      backgroundColor: _kCanvas,
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        elevation: 0.5,
        foregroundColor: _kInk,
        title: Row(
          children: const <Widget>[
            Icon(Icons.account_tree, color: _kLayout, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'ParentData',
              style: TextStyle(
                color: _kInk,
                fontSize: 17.0,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.3,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          children: sectionWidgets,
        ),
      ),
    ),
  );

  print('ParentData deep visual demo built successfully');
  return app;
}
