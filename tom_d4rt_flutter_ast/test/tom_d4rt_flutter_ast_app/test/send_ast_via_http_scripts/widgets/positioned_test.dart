// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unused_element, unused_element_parameter, unused_field, unnecessary_import, unused_import, no_leading_underscores_for_local_identifiers
//
// ============================================================================
// POSITIONED — Visual Deep Demo
// ============================================================================
//
// A hand-authored, narrative tour through the [Positioned] widget family that
// lives inside [Stack]. This file is intentionally long-form: every section
// builds small visual canvases, annotates coordinates, and contrasts the many
// constructors and edge-cases that Positioned exposes.
//
// Members tested:
//
//   * Positioned(left:, top:, right:, bottom:, width:, height:, child:)
//   * Positioned.fill(...)
//   * Positioned.directional(textDirection:, start:, end:, top:, bottom:, ...)
//   * PositionedDirectional(start:, end:, top:, bottom:, ...)
//   * Positioned.fromRect(rect:, child:)
//   * Positioned.fromRelativeRect(rect:, child:)
//
// ----------------------------------------------------------------------------
//
// Coordinate model recap (used everywhere below):
//
//                      top
//        +-------------------------------+
//        |                               |
//   left |          (child)              | right
//        |                               |
//        +-------------------------------+
//                     bottom
//
// Each side specifies the *distance from the parent Stack's edge* to the
// corresponding side of the child. If two opposite sides are set (e.g. left
// AND right), the width is derived. Likewise for top + bottom + height.
//
// If you set left + right + width, Flutter will throw a layout assertion at
// runtime because the three values over-constrain the horizontal axis. The
// same applies to vertical axes.
//
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:math' as math;

// ---------------------------------------------------------------------------
// Tiny helpers — kept private and pure so the build() function reads cleanly.
// ---------------------------------------------------------------------------

/// A coloured square used as a canvas-edge anchor in the diagrams.
Widget _dot(Color color, {double size = 6.0}) {
  return Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      color: color,
      shape: BoxShape.circle,
    ),
  );
}

/// A captioned mini-canvas wrapping a [Stack] of fixed dimensions so the
/// reader can clearly see where the Positioned children land.
Widget _canvas({
  required String title,
  required double width,
  required double height,
  required List<Widget> children,
  Color background = const Color(0xFFEFEFEF),
  Color border = const Color(0xFF999999),
}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: const TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w600,
            color: Color(0xFF333333),
          ),
        ),
        const SizedBox(height: 4.0),
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: background,
            border: Border.all(color: border, width: 1.0),
          ),
          child: Stack(
            clipBehavior: Clip.hardEdge,
            children: children,
          ),
        ),
      ],
    ),
  );
}

/// A tiny inline coordinate label (e.g. "L:10 T:10").
Widget _label(String text, {Color color = const Color(0xFF222222)}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
    color: const Color(0xCCFFFFFF),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 9.0,
        fontFamily: 'monospace',
        color: color,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

/// A coloured rectangular tile used as the "thing being positioned".
Widget _tile({
  required double w,
  required double h,
  required Color color,
  String? caption,
}) {
  return Container(
    width: w,
    height: h,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(2.0),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x33000000),
          blurRadius: 2.0,
          offset: Offset(1.0, 1.0),
        ),
      ],
    ),
    child: caption == null
        ? null
        : Text(
            caption,
            style: const TextStyle(
              fontSize: 9.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
  );
}

/// Renders a subtle grid of 10px lines on top of a Stack-canvas so the reader
/// can count pixels visually. The grid itself is NOT a Positioned child;
/// it's a regular Container painted to fit the parent via Positioned.fill.
Widget _gridOverlay({int step = 10}) {
  return Positioned.fill(
    child: IgnorePointer(
      ignoring: true,
      child: CustomPaint(
        painter: _GridPainter(step: step),
      ),
    ),
  );
}

class _GridPainter extends CustomPainter {
  _GridPainter({required this.step});
  final int step;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = const Color(0x22000000)
      ..strokeWidth = 0.5;
    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _GridPainter oldDelegate) {
    return oldDelegate.step != step;
  }
}

// ---------------------------------------------------------------------------
// Section header widget — purely decorative, used between content blocks.
// ---------------------------------------------------------------------------
Widget _section(String title, String subtitle) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(8.0, 24.0, 8.0, 8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          color: const Color(0xFF263238),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 13.0,
            ),
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 11.0,
            color: Color(0xFF555555),
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );
}

Widget _paragraph(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
    child: Text(
      text,
      style: const TextStyle(fontSize: 11.5, color: Color(0xFF333333), height: 1.35),
    ),
  );
}

Widget _bullet(String text) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(20.0, 2.0, 12.0, 2.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('• ', style: TextStyle(fontWeight: FontWeight.bold)),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 11.0, color: Color(0xFF333333)),
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// build()
// ===========================================================================
dynamic build(BuildContext context) {
  print('Positioned visual deep-demo: build() entered');

  // -------------------------------------------------------------------------
  // 0. DOSSIER
  // -------------------------------------------------------------------------
  // A "dossier" block introduces the widget, its lineage, and its key
  // constructors. We render it as a `Card` so it is visually distinct from
  // the rest of the document.
  // -------------------------------------------------------------------------
  final Widget dossier = Card(
    margin: const EdgeInsets.all(8.0),
    elevation: 2.0,
    color: const Color(0xFFFFFDE7),
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Widget: Positioned',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4.0),
          const Text(
            'Lineage: Object → DiagnosticableTree → Widget → ProxyWidget '
            '→ ParentDataWidget<StackParentData> → Positioned',
            style: TextStyle(fontSize: 10.5, fontFamily: 'monospace'),
          ),
          const Divider(height: 16.0),
          const Text('Constructors:',
              style: TextStyle(fontWeight: FontWeight.w600)),
          _bullet('Positioned({left, top, right, bottom, width, height, child})'),
          _bullet('Positioned.fill({left = 0, top = 0, right = 0, bottom = 0, child})'),
          _bullet('Positioned.directional({textDirection, start, end, top, bottom, width, height, child})'),
          _bullet('Positioned.fromRect({rect, child})'),
          _bullet('Positioned.fromRelativeRect({rect, child})'),
          _bullet('PositionedDirectional({start, end, top, bottom, width, height, child}) — Stateless wrapper'),
          const Divider(height: 16.0),
          const Text('Constraints rule:',
              style: TextStyle(fontWeight: FontWeight.w600)),
          _paragraph(
            'At most TWO of (left, right, width) and at most TWO of '
            '(top, bottom, height) may be non-null at the same time. '
            'The third value (if applicable) is derived from the other two.',
          ),
        ],
      ),
    ),
  );

  // -------------------------------------------------------------------------
  // 1. ANATOMY GRID — top/right/bottom/left/width/height combinations
  // -------------------------------------------------------------------------
  // Each canvas is 160x100 and pins a 40x30 tile to a different corner or
  // axis-stretch combination. We tag every tile with a tiny coordinate
  // label so the reader can read off the math.
  // -------------------------------------------------------------------------

  final Widget anatomyTopLeft = _canvas(
    title: 'top + left (anchor: top-left corner)',
    width: 160.0,
    height: 100.0,
    children: <Widget>[
      _gridOverlay(),
      Positioned(
        left: 10.0,
        top: 10.0,
        child: _tile(w: 40.0, h: 30.0, color: Colors.blue, caption: 'TL'),
      ),
      Positioned(left: 4.0, top: 4.0, child: _label('L:10 T:10')),
    ],
  );

  final Widget anatomyTopRight = _canvas(
    title: 'top + right (anchor: top-right corner)',
    width: 160.0,
    height: 100.0,
    children: <Widget>[
      _gridOverlay(),
      Positioned(
        right: 10.0,
        top: 10.0,
        child: _tile(w: 40.0, h: 30.0, color: Colors.red, caption: 'TR'),
      ),
      Positioned(right: 4.0, top: 4.0, child: _label('R:10 T:10')),
    ],
  );

  final Widget anatomyBottomLeft = _canvas(
    title: 'bottom + left (anchor: bottom-left corner)',
    width: 160.0,
    height: 100.0,
    children: <Widget>[
      _gridOverlay(),
      Positioned(
        left: 10.0,
        bottom: 10.0,
        child: _tile(w: 40.0, h: 30.0, color: Colors.green, caption: 'BL'),
      ),
      Positioned(left: 4.0, bottom: 4.0, child: _label('L:10 B:10')),
    ],
  );

  final Widget anatomyBottomRight = _canvas(
    title: 'bottom + right (anchor: bottom-right corner)',
    width: 160.0,
    height: 100.0,
    children: <Widget>[
      _gridOverlay(),
      Positioned(
        right: 10.0,
        bottom: 10.0,
        child: _tile(w: 40.0, h: 30.0, color: Colors.orange, caption: 'BR'),
      ),
      Positioned(right: 4.0, bottom: 4.0, child: _label('R:10 B:10')),
    ],
  );

  final Widget anatomyHorizontalStretch = _canvas(
    title: 'left + right + top (stretch horizontally)',
    width: 200.0,
    height: 100.0,
    children: <Widget>[
      _gridOverlay(),
      Positioned(
        left: 10.0,
        right: 10.0,
        top: 20.0,
        child: _tile(w: 0.0, h: 30.0, color: Colors.purple, caption: 'L+R+T'),
      ),
      Positioned(left: 4.0, top: 4.0, child: _label('L:10 R:10 T:20')),
    ],
  );

  final Widget anatomyVerticalStretch = _canvas(
    title: 'top + bottom + left (stretch vertically)',
    width: 200.0,
    height: 120.0,
    children: <Widget>[
      _gridOverlay(),
      Positioned(
        top: 10.0,
        bottom: 10.0,
        left: 20.0,
        child: _tile(w: 30.0, h: 0.0, color: Colors.teal, caption: 'T+B+L'),
      ),
      Positioned(left: 4.0, top: 4.0, child: _label('T:10 B:10 L:20')),
    ],
  );

  final Widget anatomyFullStretch = _canvas(
    title: 'left + right + top + bottom (full stretch)',
    width: 200.0,
    height: 100.0,
    children: <Widget>[
      _gridOverlay(),
      Positioned(
        left: 12.0,
        right: 12.0,
        top: 12.0,
        bottom: 12.0,
        child: _tile(w: 0.0, h: 0.0, color: Colors.indigo, caption: 'FULL'),
      ),
      Positioned(left: 4.0, top: 4.0, child: _label('L:R:T:B = 12')),
    ],
  );

  final Widget anatomyWidthHeightOnly = _canvas(
    title: 'width + height only (default top-left = 0,0)',
    width: 200.0,
    height: 100.0,
    children: <Widget>[
      _gridOverlay(),
      Positioned(
        width: 50.0,
        height: 30.0,
        child: _tile(w: 50.0, h: 30.0, color: Colors.brown, caption: 'W+H'),
      ),
      Positioned(left: 4.0, bottom: 4.0, child: _label('W:50 H:30 (no L/T)')),
    ],
  );

  final Widget anatomyLeftWidth = _canvas(
    title: 'left + width + top (no right)',
    width: 200.0,
    height: 100.0,
    children: <Widget>[
      _gridOverlay(),
      Positioned(
        left: 30.0,
        top: 30.0,
        width: 60.0,
        height: 30.0,
        child: _tile(w: 60.0, h: 30.0, color: Colors.cyan, caption: 'L+W'),
      ),
      Positioned(left: 4.0, top: 4.0, child: _label('L:30 T:30 W:60 H:30')),
    ],
  );

  final Widget anatomyRightWidth = _canvas(
    title: 'right + width + bottom (no left)',
    width: 200.0,
    height: 100.0,
    children: <Widget>[
      _gridOverlay(),
      Positioned(
        right: 30.0,
        bottom: 30.0,
        width: 60.0,
        height: 30.0,
        child: _tile(w: 60.0, h: 30.0, color: Colors.pink, caption: 'R+W'),
      ),
      Positioned(right: 4.0, bottom: 4.0, child: _label('R:30 B:30 W:60 H:30')),
    ],
  );

  final Widget anatomyOverlapDemo = _canvas(
    title: 'overlap — z-order = list order',
    width: 200.0,
    height: 120.0,
    children: <Widget>[
      _gridOverlay(),
      Positioned(
        left: 20.0,
        top: 20.0,
        child: _tile(w: 80.0, h: 60.0, color: Colors.red, caption: 'A (bottom)'),
      ),
      Positioned(
        left: 60.0,
        top: 50.0,
        child: _tile(w: 80.0, h: 60.0, color: Colors.green, caption: 'B (mid)'),
      ),
      Positioned(
        left: 100.0,
        top: 80.0,
        child: _tile(w: 80.0, h: 30.0, color: Colors.blue, caption: 'C (top)'),
      ),
    ],
  );

  final Widget anatomyGrid = Wrap(
    spacing: 8.0,
    runSpacing: 8.0,
    children: <Widget>[
      anatomyTopLeft,
      anatomyTopRight,
      anatomyBottomLeft,
      anatomyBottomRight,
      anatomyHorizontalStretch,
      anatomyVerticalStretch,
      anatomyFullStretch,
      anatomyWidthHeightOnly,
      anatomyLeftWidth,
      anatomyRightWidth,
      anatomyOverlapDemo,
    ],
  );

  // -------------------------------------------------------------------------
  // 2. RECIPE: BADGE OVER AVATAR
  // -------------------------------------------------------------------------
  // Classic notification-badge layered on top of a circular avatar.
  // -------------------------------------------------------------------------
  final Widget recipeBadgeAvatar = _canvas(
    title: 'Recipe — Notification badge over avatar',
    width: 200.0,
    height: 120.0,
    children: <Widget>[
      Positioned(
        left: 60.0,
        top: 20.0,
        child: Container(
          width: 80.0,
          height: 80.0,
          decoration: const BoxDecoration(
            color: Colors.blueGrey,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: const Text(
            'AB',
            style: TextStyle(color: Colors.white, fontSize: 24.0),
          ),
        ),
      ),
      Positioned(
        left: 122.0,
        top: 18.0,
        child: Container(
          width: 22.0,
          height: 22.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2.0),
          ),
          child: const Text(
            '3',
            style: TextStyle(
              color: Colors.white,
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      Positioned(left: 4.0, top: 4.0, child: _label('Badge at L:122 T:18')),
    ],
  );

  // -------------------------------------------------------------------------
  // 3. RECIPE: FLOATING LABEL (like Material text-field placeholder)
  // -------------------------------------------------------------------------
  final Widget recipeFloatingLabel = _canvas(
    title: 'Recipe — Floating label above border',
    width: 240.0,
    height: 80.0,
    children: <Widget>[
      Positioned(
        left: 10.0,
        right: 10.0,
        top: 25.0,
        bottom: 10.0,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.indigo, width: 1.5),
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
      ),
      Positioned(
        left: 20.0,
        top: 17.0,
        child: Container(
          color: const Color(0xFFEFEFEF),
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: const Text(
            'Email',
            style: TextStyle(
              color: Colors.indigo,
              fontSize: 11.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      Positioned(left: 4.0, bottom: 4.0, child: _label('label peeks over border')),
    ],
  );

  // -------------------------------------------------------------------------
  // 4. RECIPE: CORNER WATERMARK
  // -------------------------------------------------------------------------
  final Widget recipeWatermark = _canvas(
    title: 'Recipe — Corner watermark',
    width: 200.0,
    height: 140.0,
    children: <Widget>[
      Positioned.fill(
        child: Container(
          color: const Color(0xFFFFF8E1),
          alignment: Alignment.center,
          child: const Text(
            'Receipt #4521',
            style: TextStyle(fontSize: 14.0, color: Colors.brown),
          ),
        ),
      ),
      Positioned(
        right: 6.0,
        bottom: 6.0,
        child: Transform.rotate(
          angle: -math.pi / 12,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.red, width: 1.5),
            ),
            child: const Text(
              'PAID',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
          ),
        ),
      ),
      Positioned(left: 4.0, top: 4.0, child: _label('R:6 B:6 + rotate')),
    ],
  );

  // -------------------------------------------------------------------------
  // 5. RECIPE: SLIDING BANNER (top notification bar)
  // -------------------------------------------------------------------------
  final Widget recipeBanner = _canvas(
    title: 'Recipe — Sliding banner across the top',
    width: 260.0,
    height: 120.0,
    children: <Widget>[
      Positioned.fill(
        child: Container(color: const Color(0xFFE3F2FD)),
      ),
      Positioned(
        left: 0.0,
        right: 0.0,
        top: 0.0,
        child: Container(
          height: 28.0,
          color: Colors.deepPurple,
          alignment: Alignment.center,
          child: const Text(
            'New update available — tap to install',
            style: TextStyle(color: Colors.white, fontSize: 11.0),
          ),
        ),
      ),
      Positioned(
        left: 4.0,
        top: 32.0,
        child: _label('Banner: L:0 R:0 T:0'),
      ),
    ],
  );

  // -------------------------------------------------------------------------
  // 6. RECIPE: DIALOG OVERLAY (modal-ish)
  // -------------------------------------------------------------------------
  final Widget recipeDialog = _canvas(
    title: 'Recipe — Modal dialog overlay',
    width: 240.0,
    height: 160.0,
    children: <Widget>[
      Positioned.fill(
        child: Container(color: const Color(0xFFCFD8DC)),
      ),
      Positioned.fill(
        child: Container(color: const Color(0x88000000)),
      ),
      Positioned(
        left: 30.0,
        right: 30.0,
        top: 30.0,
        bottom: 30.0,
        child: Material(
          color: Colors.white,
          elevation: 4.0,
          child: const Center(
            child: Text(
              'Are you sure?',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
            ),
          ),
        ),
      ),
      Positioned(left: 4.0, top: 4.0, child: _label('scrim + centered dialog')),
    ],
  );

  // -------------------------------------------------------------------------
  // 7. RECIPE: CORNER RIBBON
  // -------------------------------------------------------------------------
  final Widget recipeRibbon = _canvas(
    title: 'Recipe — Corner ribbon (top-left)',
    width: 180.0,
    height: 140.0,
    children: <Widget>[
      Positioned.fill(
        child: Container(color: const Color(0xFFF1F8E9)),
      ),
      Positioned(
        left: -20.0,
        top: 14.0,
        child: Transform.rotate(
          angle: -math.pi / 4,
          child: Container(
            width: 100.0,
            color: Colors.amber,
            alignment: Alignment.center,
            child: const Text(
              'NEW',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
            ),
          ),
        ),
      ),
      Positioned(right: 4.0, bottom: 4.0, child: _label('L:-20 + rotate -45°')),
    ],
  );

  // -------------------------------------------------------------------------
  // 8. RECIPE: TOOLTIP WITH ARROW
  // -------------------------------------------------------------------------
  final Widget recipeTooltip = _canvas(
    title: 'Recipe — Tooltip with little arrow',
    width: 220.0,
    height: 140.0,
    children: <Widget>[
      Positioned(
        left: 80.0,
        top: 90.0,
        child: Container(
          width: 30.0,
          height: 30.0,
          color: Colors.deepOrange,
        ),
      ),
      Positioned(
        left: 40.0,
        top: 40.0,
        child: Container(
          padding: const EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: const Text(
            'Click me',
            style: TextStyle(color: Colors.white, fontSize: 11.0),
          ),
        ),
      ),
      Positioned(
        left: 88.0,
        top: 72.0,
        child: ClipPath(
          clipper: _TriangleClipper(),
          child: Container(width: 12.0, height: 10.0, color: Colors.black87),
        ),
      ),
      Positioned(right: 4.0, bottom: 4.0, child: _label('tooltip + triangle arrow')),
    ],
  );

  // -------------------------------------------------------------------------
  // 9. Positioned.fill RECIPE — backdrop + content
  // -------------------------------------------------------------------------
  final Widget fillRecipe = _canvas(
    title: 'Positioned.fill — fill the entire Stack',
    width: 240.0,
    height: 120.0,
    children: <Widget>[
      Positioned.fill(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[Colors.deepPurple, Colors.blueAccent],
            ),
          ),
        ),
      ),
      Positioned.fill(
        left: 16.0,
        top: 16.0,
        right: 16.0,
        bottom: 16.0,
        child: Container(
          color: const Color(0x55FFFFFF),
          alignment: Alignment.center,
          child: const Text(
            'Frosted card on gradient',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      Positioned(left: 4.0, bottom: 4.0, child: _label('Positioned.fill(insets)')),
    ],
  );

  // -------------------------------------------------------------------------
  // 10. Positioned.directional — RTL vs LTR
  // -------------------------------------------------------------------------
  final Widget directionalLtr = _canvas(
    title: 'Positioned.directional — LTR (start=left)',
    width: 200.0,
    height: 90.0,
    children: <Widget>[
      _gridOverlay(),
      Positioned.directional(
        textDirection: TextDirection.ltr,
        start: 20.0,
        top: 20.0,
        child: _tile(w: 60.0, h: 30.0, color: Colors.deepPurple, caption: 'START'),
      ),
      Positioned.directional(
        textDirection: TextDirection.ltr,
        end: 20.0,
        bottom: 10.0,
        child: _tile(w: 60.0, h: 20.0, color: Colors.teal, caption: 'END'),
      ),
      Positioned(left: 4.0, top: 4.0, child: _label('LTR: start≡left, end≡right')),
    ],
  );

  final Widget directionalRtl = _canvas(
    title: 'Positioned.directional — RTL (start=right)',
    width: 200.0,
    height: 90.0,
    children: <Widget>[
      _gridOverlay(),
      Positioned.directional(
        textDirection: TextDirection.rtl,
        start: 20.0,
        top: 20.0,
        child: _tile(w: 60.0, h: 30.0, color: Colors.deepPurple, caption: 'START'),
      ),
      Positioned.directional(
        textDirection: TextDirection.rtl,
        end: 20.0,
        bottom: 10.0,
        child: _tile(w: 60.0, h: 20.0, color: Colors.teal, caption: 'END'),
      ),
      Positioned(left: 4.0, top: 4.0, child: _label('RTL: start≡right, end≡left')),
    ],
  );

  // -------------------------------------------------------------------------
  // 11. PositionedDirectional — uses ambient Directionality
  // -------------------------------------------------------------------------
  final Widget positionedDirectionalLtr = _canvas(
    title: 'PositionedDirectional in LTR Directionality',
    width: 200.0,
    height: 90.0,
    children: <Widget>[
      _gridOverlay(),
      Positioned.fill(
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Stack(
            children: <Widget>[
              PositionedDirectional(
                start: 12.0,
                top: 12.0,
                child: _tile(w: 50.0, h: 30.0, color: Colors.red, caption: 'PD-S'),
              ),
              PositionedDirectional(
                end: 12.0,
                bottom: 12.0,
                child: _tile(w: 50.0, h: 30.0, color: Colors.green, caption: 'PD-E'),
              ),
            ],
          ),
        ),
      ),
      Positioned(left: 4.0, bottom: 4.0, child: _label('Ambient LTR')),
    ],
  );

  final Widget positionedDirectionalRtl = _canvas(
    title: 'PositionedDirectional in RTL Directionality',
    width: 200.0,
    height: 90.0,
    children: <Widget>[
      _gridOverlay(),
      Positioned.fill(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Stack(
            children: <Widget>[
              PositionedDirectional(
                start: 12.0,
                top: 12.0,
                child: _tile(w: 50.0, h: 30.0, color: Colors.red, caption: 'PD-S'),
              ),
              PositionedDirectional(
                end: 12.0,
                bottom: 12.0,
                child: _tile(w: 50.0, h: 30.0, color: Colors.green, caption: 'PD-E'),
              ),
            ],
          ),
        ),
      ),
      Positioned(left: 4.0, bottom: 4.0, child: _label('Ambient RTL — start flips')),
    ],
  );

  // -------------------------------------------------------------------------
  // 12. Positioned.fromRect
  // -------------------------------------------------------------------------
  final Widget fromRectDemo = _canvas(
    title: 'Positioned.fromRect — Rect.fromLTWH(20,20,80,40)',
    width: 200.0,
    height: 120.0,
    children: <Widget>[
      _gridOverlay(),
      Positioned.fromRect(
        rect: const Rect.fromLTWH(20.0, 20.0, 80.0, 40.0),
        child: _tile(w: 0.0, h: 0.0, color: Colors.indigo, caption: 'RECT'),
      ),
      Positioned(left: 4.0, top: 4.0, child: _label('Rect(20,20,80,40)')),
    ],
  );

  final Widget fromRectShiftedDemo = _canvas(
    title: 'Positioned.fromRect — Rect.fromCircle',
    width: 200.0,
    height: 120.0,
    children: <Widget>[
      _gridOverlay(),
      Positioned.fromRect(
        rect: Rect.fromCircle(center: const Offset(100.0, 60.0), radius: 30.0),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.deepOrange,
            shape: BoxShape.circle,
          ),
        ),
      ),
      Positioned(left: 4.0, top: 4.0, child: _label('center(100,60) r:30')),
    ],
  );

  final Widget fromRectMultiDemo = _canvas(
    title: 'Positioned.fromRect — three rects in a row',
    width: 240.0,
    height: 100.0,
    children: <Widget>[
      _gridOverlay(),
      Positioned.fromRect(
        rect: const Rect.fromLTWH(10.0, 30.0, 60.0, 40.0),
        child: _tile(w: 0.0, h: 0.0, color: Colors.red),
      ),
      Positioned.fromRect(
        rect: const Rect.fromLTWH(90.0, 30.0, 60.0, 40.0),
        child: _tile(w: 0.0, h: 0.0, color: Colors.green),
      ),
      Positioned.fromRect(
        rect: const Rect.fromLTWH(170.0, 30.0, 60.0, 40.0),
        child: _tile(w: 0.0, h: 0.0, color: Colors.blue),
      ),
      Positioned(left: 4.0, top: 4.0, child: _label('LTWH x:[10,90,170] w:60')),
    ],
  );

  // -------------------------------------------------------------------------
  // 13. Positioned.fromRelativeRect
  // -------------------------------------------------------------------------
  // RelativeRect.fromLTRB(left, top, right, bottom) measures insets from
  // each side of the parent Stack — analogous to setting left/top/right/bottom
  // directly, but bundled as a Rect-like type.
  // -------------------------------------------------------------------------
  final Widget fromRelativeRectDemo = _canvas(
    title: 'Positioned.fromRelativeRect — insets all around',
    width: 220.0,
    height: 120.0,
    children: <Widget>[
      _gridOverlay(),
      Positioned.fromRelativeRect(
        rect: const RelativeRect.fromLTRB(15.0, 15.0, 15.0, 15.0),
        child: Container(
          color: Colors.cyan.shade300,
          alignment: Alignment.center,
          child: const Text('RelativeRect inset 15', style: TextStyle(fontSize: 10.0)),
        ),
      ),
      Positioned(left: 4.0, top: 4.0, child: _label('LTRB:15,15,15,15')),
    ],
  );

  final Widget fromRelativeRectAsymmetricDemo = _canvas(
    title: 'Positioned.fromRelativeRect — asymmetric',
    width: 220.0,
    height: 120.0,
    children: <Widget>[
      _gridOverlay(),
      Positioned.fromRelativeRect(
        rect: const RelativeRect.fromLTRB(40.0, 10.0, 10.0, 40.0),
        child: Container(
          color: Colors.lightGreen.shade300,
          alignment: Alignment.center,
          child: const Text('asym', style: TextStyle(fontSize: 10.0)),
        ),
      ),
      Positioned(left: 4.0, bottom: 4.0, child: _label('L:40 T:10 R:10 B:40')),
    ],
  );

  // -------------------------------------------------------------------------
  // 14. COMPARISON: Positioned vs Align (inside Stack)
  // -------------------------------------------------------------------------
  final Widget compareAlign = _canvas(
    title: 'Stack with Align — aligns by ratio, not pixels',
    width: 220.0,
    height: 120.0,
    children: <Widget>[
      _gridOverlay(),
      Align(
        alignment: Alignment.topLeft,
        child: _tile(w: 30.0, h: 20.0, color: Colors.red, caption: 'TL'),
      ),
      Align(
        alignment: Alignment.center,
        child: _tile(w: 40.0, h: 30.0, color: Colors.green, caption: 'C'),
      ),
      Align(
        alignment: Alignment.bottomRight,
        child: _tile(w: 30.0, h: 20.0, color: Colors.blue, caption: 'BR'),
      ),
      Positioned(left: 4.0, top: 4.0, child: _label('Align: anchored fractions')),
    ],
  );

  final Widget comparePositioned = _canvas(
    title: 'Stack with Positioned — exact pixel offsets',
    width: 220.0,
    height: 120.0,
    children: <Widget>[
      _gridOverlay(),
      Positioned(
        left: 0.0,
        top: 0.0,
        child: _tile(w: 30.0, h: 20.0, color: Colors.red, caption: 'TL'),
      ),
      Positioned(
        left: 90.0,
        top: 45.0,
        child: _tile(w: 40.0, h: 30.0, color: Colors.green, caption: 'C-ish'),
      ),
      Positioned(
        right: 0.0,
        bottom: 0.0,
        child: _tile(w: 30.0, h: 20.0, color: Colors.blue, caption: 'BR'),
      ),
      Positioned(left: 4.0, top: 4.0, child: _label('Positioned: exact px')),
    ],
  );

  // -------------------------------------------------------------------------
  // 15. COMPARISON: Stack alignment vs Positioned
  // -------------------------------------------------------------------------
  // A Stack's `alignment` parameter governs the placement of NON-positioned
  // children. Positioned children ignore it entirely.
  // -------------------------------------------------------------------------
  final Widget compareStackAlignment = Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Stack(alignment: …) — affects NON-Positioned children only',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12.0),
        ),
        const SizedBox(height: 4.0),
        Container(
          width: 280.0,
          height: 140.0,
          decoration: BoxDecoration(border: Border.all(color: const Color(0xFF999999))),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              _gridOverlay(),
              // NON-positioned child — affected by alignment.
              _tile(w: 60.0, h: 20.0, color: Colors.amber, caption: 'aligned'),
              // Positioned child — ignores Stack.alignment.
              Positioned(
                left: 10.0,
                top: 10.0,
                child: _tile(w: 60.0, h: 20.0, color: Colors.indigo, caption: 'pinned'),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // 16. PITFALL: Conflicting constraints
  // -------------------------------------------------------------------------
  // Here we describe — but do NOT actually trigger — the over-constrained
  // case. Triggering would throw at runtime. We render an explanatory box.
  // -------------------------------------------------------------------------
  final Widget pitfallConflict = Card(
    color: const Color(0xFFFFEBEE),
    margin: const EdgeInsets.all(8.0),
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Pitfall — Over-constrained Positioned',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red, fontSize: 13.0),
          ),
          const SizedBox(height: 6.0),
          _paragraph(
            'The following constructor call is illegal because it specifies '
            'BOTH (left, right) AND width along the horizontal axis:',
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 6.0),
            padding: const EdgeInsets.all(6.0),
            color: Colors.black87,
            child: const Text(
              "Positioned(left: 10, right: 10, width: 100, child: ...)",
              style: TextStyle(
                color: Colors.lightGreenAccent,
                fontFamily: 'monospace',
                fontSize: 11.0,
              ),
            ),
          ),
          _paragraph(
            'Flutter will throw a `RenderObject` layout assertion at runtime: '
            'pick at most two of (left, right, width). Same applies to the '
            'vertical axis with (top, bottom, height).',
          ),
        ],
      ),
    ),
  );

  // -------------------------------------------------------------------------
  // 17. PITFALL: Positioned outside a Stack
  // -------------------------------------------------------------------------
  // Positioned is a ParentDataWidget — it only makes sense inside a Stack.
  // If you place it under a Column or Row, you'll get an assertion that the
  // ParentData was not consumed by an appropriate parent.
  // -------------------------------------------------------------------------
  final Widget pitfallOutsideStack = Card(
    color: const Color(0xFFFFF3E0),
    margin: const EdgeInsets.all(8.0),
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Pitfall — Positioned must be a Stack child',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepOrange, fontSize: 13.0),
          ),
          const SizedBox(height: 6.0),
          _paragraph(
            'Positioned is a ParentDataWidget<StackParentData>. Wrapping any '
            'widget with Positioned attaches StackParentData to that child. '
            'Only a RenderStack reads StackParentData, so placing Positioned '
            'under any other parent (Column, Row, ListView…) is an error.',
          ),
          _paragraph('Wrong:'),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 6.0),
            padding: const EdgeInsets.all(6.0),
            color: Colors.black87,
            child: const Text(
              "Column(children: [Positioned(top: 10, child: …)])",
              style: TextStyle(
                color: Colors.redAccent,
                fontFamily: 'monospace',
                fontSize: 11.0,
              ),
            ),
          ),
          _paragraph('Right:'),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 6.0),
            padding: const EdgeInsets.all(6.0),
            color: Colors.black87,
            child: const Text(
              "Stack(children: [Positioned(top: 10, child: …)])",
              style: TextStyle(
                color: Colors.lightGreenAccent,
                fontFamily: 'monospace',
                fontSize: 11.0,
              ),
            ),
          ),
        ],
      ),
    ),
  );

  // -------------------------------------------------------------------------
  // 18. PITFALL: Stack must be bounded
  // -------------------------------------------------------------------------
  final Widget pitfallUnbounded = Card(
    color: const Color(0xFFF3E5F5),
    margin: const EdgeInsets.all(8.0),
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Pitfall — Stack needs bounded constraints when using Positioned with two opposite sides',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.purple, fontSize: 13.0),
          ),
          const SizedBox(height: 6.0),
          _paragraph(
            'Positioned uses the Stack\'s incoming constraints to compute the '
            'child\'s rect. If the Stack is in unbounded constraints (e.g. '
            'inside a Column without an Expanded, or in a ListView without a '
            'SizedBox), Positioned will fall back to whatever bounded axis '
            'exists; an unbounded Stack with `right` or `bottom` set produces '
            'visual surprises or assertion failures.',
          ),
          _paragraph(
            'Solution: wrap the Stack in SizedBox, Expanded, AspectRatio, or '
            'use Stack.fit = StackFit.expand inside a Container with size.',
          ),
        ],
      ),
    ),
  );

  // -------------------------------------------------------------------------
  // 19. ADVANCED — Animated coordinate sweep (static snapshot)
  // -------------------------------------------------------------------------
  // We don't have a ticker (StatefulWidget is forbidden per file rules), but
  // we render a "frozen" snapshot at three discrete time steps so the
  // reader can imagine the animation.
  // -------------------------------------------------------------------------
  Widget _frozenSweep(double t) {
    return _canvas(
      title: 'Sweep snapshot — t=${t.toStringAsFixed(2)}',
      width: 220.0,
      height: 80.0,
      children: <Widget>[
        _gridOverlay(),
        Positioned(
          left: 10.0 + 180.0 * t,
          top: 25.0,
          child: _tile(w: 20.0, h: 30.0, color: Colors.blueAccent),
        ),
        Positioned(left: 4.0, top: 4.0, child: _label('left = 10 + 180*t')),
      ],
    );
  }

  final Widget sweepRow = Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _frozenSweep(0.0),
      _frozenSweep(0.5),
      _frozenSweep(1.0),
    ],
  );

  // -------------------------------------------------------------------------
  // 20. ADVANCED — Polar layout (Positioned on a circle)
  // -------------------------------------------------------------------------
  // Twelve tiles laid out around a circle using Positioned with computed
  // left/top from polar coordinates.
  // -------------------------------------------------------------------------
  final List<Widget> polarChildren = <Widget>[];
  polarChildren.add(_gridOverlay());
  for (int i = 0; i < 12; i++) {
    final double angle = (i / 12.0) * 2 * math.pi - math.pi / 2;
    final double cx = 120.0;
    final double cy = 90.0;
    final double r = 70.0;
    final double tileSize = 18.0;
    final double left = cx + r * math.cos(angle) - tileSize / 2;
    final double top = cy + r * math.sin(angle) - tileSize / 2;
    polarChildren.add(
      Positioned(
        left: left,
        top: top,
        child: Container(
          width: tileSize,
          height: tileSize,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color.lerp(Colors.red, Colors.blue, i / 11.0)!,
            shape: BoxShape.circle,
          ),
          child: Text(
            '$i',
            style: const TextStyle(color: Colors.white, fontSize: 9.0),
          ),
        ),
      ),
    );
  }
  polarChildren.add(
    Positioned(
      left: 110.0,
      top: 85.0,
      child: _tile(w: 20.0, h: 10.0, color: Colors.black87, caption: 'C'),
    ),
  );

  final Widget polarLayout = _canvas(
    title: 'Polar layout — twelve Positioned children around a circle',
    width: 240.0,
    height: 180.0,
    children: polarChildren,
  );

  // -------------------------------------------------------------------------
  // 21. ADVANCED — Grid layout via Positioned
  // -------------------------------------------------------------------------
  // Reproducing a 4x3 grid manually with Positioned, as if you were a
  // layout engine. Demonstrates how heavy this is compared to GridView!
  // -------------------------------------------------------------------------
  final List<Widget> gridChildren = <Widget>[_gridOverlay()];
  const int cols = 4;
  const int rows = 3;
  const double cellW = 50.0;
  const double cellH = 35.0;
  const double padX = 8.0;
  const double padY = 8.0;
  for (int r = 0; r < rows; r++) {
    for (int c = 0; c < cols; c++) {
      gridChildren.add(
        Positioned(
          left: padX + c * (cellW + padX),
          top: padY + r * (cellH + padY),
          child: _tile(
            w: cellW,
            h: cellH,
            color: Color.lerp(Colors.lightBlue, Colors.deepPurple,
                (r * cols + c) / (rows * cols - 1))!,
            caption: '$r,$c',
          ),
        ),
      );
    }
  }

  final Widget manualGrid = _canvas(
    title: 'Manual 4x3 grid — every cell is a Positioned',
    width: 240.0,
    height: 140.0,
    children: gridChildren,
  );

  // -------------------------------------------------------------------------
  // 22. ADVANCED — Stairs (each tile shifted by an offset)
  // -------------------------------------------------------------------------
  final List<Widget> stairsChildren = <Widget>[_gridOverlay()];
  for (int i = 0; i < 6; i++) {
    stairsChildren.add(
      Positioned(
        left: 10.0 + i * 30.0,
        bottom: 10.0 + i * 15.0,
        child: _tile(
          w: 32.0,
          h: 18.0,
          color: Color.lerp(Colors.green, Colors.yellow, i / 5.0)!,
          caption: '$i',
        ),
      ),
    );
  }
  final Widget stairsLayout = _canvas(
    title: 'Stairs — shift each tile up-and-right',
    width: 240.0,
    height: 140.0,
    children: stairsChildren,
  );

  // -------------------------------------------------------------------------
  // 23. ADVANCED — Cross of Positioned children
  // -------------------------------------------------------------------------
  final Widget crossLayout = _canvas(
    title: 'Cross — a + made out of two Positioned bars',
    width: 200.0,
    height: 150.0,
    children: <Widget>[
      _gridOverlay(),
      Positioned(
        left: 20.0,
        right: 20.0,
        top: 65.0,
        height: 20.0,
        child: Container(color: Colors.redAccent),
      ),
      Positioned(
        top: 20.0,
        bottom: 20.0,
        left: 90.0,
        width: 20.0,
        child: Container(color: Colors.redAccent),
      ),
      Positioned(left: 4.0, top: 4.0, child: _label('two Positioned bars overlap')),
    ],
  );

  // -------------------------------------------------------------------------
  // 24. ADVANCED — Page corners (four diagonal tiles)
  // -------------------------------------------------------------------------
  final Widget pageCorners = _canvas(
    title: 'Page corners — four diagonal Positioned tiles',
    width: 240.0,
    height: 140.0,
    children: <Widget>[
      _gridOverlay(),
      Positioned(
        left: 0.0,
        top: 0.0,
        child: ClipPath(
          clipper: _CornerClipper(),
          child: Container(width: 30.0, height: 30.0, color: Colors.blue),
        ),
      ),
      Positioned(
        right: 0.0,
        top: 0.0,
        child: Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()..scale(-1.0, 1.0),
          child: ClipPath(
            clipper: _CornerClipper(),
            child: Container(width: 30.0, height: 30.0, color: Colors.blue),
          ),
        ),
      ),
      Positioned(
        left: 0.0,
        bottom: 0.0,
        child: Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()..scale(1.0, -1.0),
          child: ClipPath(
            clipper: _CornerClipper(),
            child: Container(width: 30.0, height: 30.0, color: Colors.blue),
          ),
        ),
      ),
      Positioned(
        right: 0.0,
        bottom: 0.0,
        child: Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()..scale(-1.0, -1.0),
          child: ClipPath(
            clipper: _CornerClipper(),
            child: Container(width: 30.0, height: 30.0, color: Colors.blue),
          ),
        ),
      ),
    ],
  );

  // -------------------------------------------------------------------------
  // 25. ADVANCED — FAB-like floating action button
  // -------------------------------------------------------------------------
  final Widget fabRecipe = _canvas(
    title: 'Recipe — FAB above bottom bar',
    width: 240.0,
    height: 160.0,
    children: <Widget>[
      Positioned.fill(
        child: Container(color: const Color(0xFFE8F5E9)),
      ),
      Positioned(
        left: 0.0,
        right: 0.0,
        bottom: 0.0,
        child: Container(
          height: 40.0,
          color: Colors.green.shade700,
          alignment: Alignment.center,
          child: const Text(
            'Bottom Bar',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      Positioned(
        right: 16.0,
        bottom: 24.0,
        child: Container(
          width: 48.0,
          height: 48.0,
          decoration: const BoxDecoration(
            color: Colors.deepOrange,
            shape: BoxShape.circle,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Color(0x55000000),
                blurRadius: 4.0,
                offset: Offset(0.0, 2.0),
              ),
            ],
          ),
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
      Positioned(left: 4.0, top: 4.0, child: _label('FAB: R:16 B:24')),
    ],
  );

  // -------------------------------------------------------------------------
  // 26. ADVANCED — Drawer-edge handle
  // -------------------------------------------------------------------------
  final Widget drawerHandle = _canvas(
    title: 'Recipe — Drawer handle bar',
    width: 220.0,
    height: 200.0,
    children: <Widget>[
      Positioned.fill(child: Container(color: Colors.white)),
      Positioned(
        left: 0.0,
        top: 0.0,
        bottom: 0.0,
        width: 6.0,
        child: Container(color: Colors.indigo),
      ),
      Positioned(
        left: 0.0,
        top: 90.0,
        child: Container(
          width: 18.0,
          height: 30.0,
          decoration: BoxDecoration(
            color: Colors.indigo,
            borderRadius: const BorderRadius.horizontal(
              right: Radius.circular(6.0),
            ),
          ),
          alignment: Alignment.center,
          child: const Icon(Icons.chevron_right, color: Colors.white, size: 14.0),
        ),
      ),
      Positioned(right: 4.0, top: 4.0, child: _label('drawer bar + handle')),
    ],
  );

  // -------------------------------------------------------------------------
  // 27. ADVANCED — Speech bubble
  // -------------------------------------------------------------------------
  final Widget speechBubble = _canvas(
    title: 'Recipe — Speech bubble with pointer',
    width: 240.0,
    height: 140.0,
    children: <Widget>[
      Positioned(
        left: 40.0,
        top: 20.0,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.amber.shade200,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: const Text(
            "Hi! I'm a speech bubble",
            style: TextStyle(fontSize: 11.0),
          ),
        ),
      ),
      Positioned(
        left: 50.0,
        top: 60.0,
        child: ClipPath(
          clipper: _TriangleClipper(),
          child: Container(width: 18.0, height: 14.0, color: Colors.amber.shade200),
        ),
      ),
      Positioned(left: 4.0, bottom: 4.0, child: _label('bubble + clipped triangle')),
    ],
  );

  // -------------------------------------------------------------------------
  // 28. ADVANCED — Progress overlay
  // -------------------------------------------------------------------------
  final Widget progressOverlay = _canvas(
    title: 'Recipe — Progress bar overlay',
    width: 260.0,
    height: 60.0,
    children: <Widget>[
      Positioned.fill(
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFE0E0E0),
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
      ),
      Positioned(
        left: 0.0,
        top: 0.0,
        bottom: 0.0,
        width: 160.0,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.lightGreen,
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
      ),
      Positioned.fill(
        child: Center(
          child: Text(
            '60%',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.brown.shade800,
            ),
          ),
        ),
      ),
      Positioned(left: 4.0, top: 4.0, child: _label('two stacked Positioned bars')),
    ],
  );

  // -------------------------------------------------------------------------
  // 29. ADVANCED — Stamps (rotated overlapping Positioned)
  // -------------------------------------------------------------------------
  final List<Widget> stampsChildren = <Widget>[
    Positioned.fill(child: Container(color: const Color(0xFFFAFAFA))),
  ];
  final List<Color> stampColors = <Color>[
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.purple,
    Colors.orange,
  ];
  for (int i = 0; i < stampColors.length; i++) {
    stampsChildren.add(
      Positioned(
        left: 10.0 + i * 35.0,
        top: 20.0 + (i.isEven ? 0.0 : 30.0),
        child: Transform.rotate(
          angle: (i - 2) * math.pi / 24,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
            decoration: BoxDecoration(
              border: Border.all(color: stampColors[i], width: 1.5),
            ),
            child: Text(
              'STAMP $i',
              style: TextStyle(
                color: stampColors[i],
                fontWeight: FontWeight.bold,
                fontSize: 10.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
  final Widget stamps = _canvas(
    title: 'Stamps — rotated Positioned children',
    width: 240.0,
    height: 110.0,
    children: stampsChildren,
  );

  // -------------------------------------------------------------------------
  // 30. ADVANCED — Image with caption strip at bottom
  // -------------------------------------------------------------------------
  final Widget imageCaptionStrip = _canvas(
    title: 'Recipe — Image card with bottom caption',
    width: 220.0,
    height: 150.0,
    children: <Widget>[
      Positioned.fill(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[Colors.blueGrey.shade100, Colors.blueGrey.shade500],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      Positioned(
        left: 0.0,
        right: 0.0,
        bottom: 0.0,
        child: Container(
          color: const Color(0xAA000000),
          padding: const EdgeInsets.all(8.0),
          child: const Text(
            'Mt. Fuji at sunrise — 2026',
            style: TextStyle(color: Colors.white, fontSize: 11.0),
          ),
        ),
      ),
      Positioned(
        left: 8.0,
        top: 8.0,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 1.0),
          color: Colors.redAccent,
          child: const Text(
            'NEW',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 9.0,
            ),
          ),
        ),
      ),
    ],
  );

  // -------------------------------------------------------------------------
  // 31. ADVANCED — Tabbed top bar with active indicator
  // -------------------------------------------------------------------------
  final Widget tabbedBar = _canvas(
    title: 'Recipe — Tabs with active indicator',
    width: 280.0,
    height: 60.0,
    children: <Widget>[
      Positioned.fill(child: Container(color: Colors.white)),
      Positioned(
        left: 0.0,
        right: 0.0,
        top: 0.0,
        height: 36.0,
        child: Row(
          children: const <Widget>[
            _Tab('Home', active: true),
            _Tab('Search', active: false),
            _Tab('Profile', active: false),
          ],
        ),
      ),
      // Active indicator under "Home" (first tab spans 0..93)
      Positioned(
        left: 8.0,
        top: 32.0,
        width: 80.0,
        height: 3.0,
        child: Container(color: Colors.deepPurple),
      ),
      Positioned(left: 4.0, bottom: 4.0, child: _label('indicator under tab')),
    ],
  );

  // -------------------------------------------------------------------------
  // 32. ADVANCED — Card with floating action menu items
  // -------------------------------------------------------------------------
  final List<Widget> floatingMenuChildren = <Widget>[
    Positioned.fill(child: Container(color: const Color(0xFFE3F2FD))),
  ];
  for (int i = 0; i < 4; i++) {
    floatingMenuChildren.add(
      Positioned(
        right: 16.0,
        bottom: 16.0 + i * 44.0,
        child: Container(
          width: 36.0,
          height: 36.0,
          decoration: BoxDecoration(
            color: Color.lerp(Colors.indigo, Colors.cyan, i / 3.0)!,
            shape: BoxShape.circle,
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Color(0x44000000),
                blurRadius: 3.0,
                offset: Offset(1.0, 1.0),
              ),
            ],
          ),
          child: Icon(
            <IconData>[Icons.add, Icons.edit, Icons.share, Icons.delete][i],
            color: Colors.white,
            size: 18.0,
          ),
        ),
      ),
    );
  }
  final Widget floatingMenu = _canvas(
    title: 'Recipe — Stacked floating buttons',
    width: 220.0,
    height: 240.0,
    children: floatingMenuChildren,
  );

  // -------------------------------------------------------------------------
  // 33. GLOSSARY
  // -------------------------------------------------------------------------
  final Widget glossary = Card(
    margin: const EdgeInsets.all(8.0),
    color: const Color(0xFFE8EAF6),
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Glossary',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
          ),
          const SizedBox(height: 6.0),
          _bullet('Stack — A widget that positions its children relative to its own edges.'),
          _bullet('Positioned — A ParentDataWidget that controls where a child sits inside a Stack.'),
          _bullet('Positioned.fill — Convenience for stretching a child across the entire Stack (defaults left/top/right/bottom to 0).'),
          _bullet('Positioned.directional — Like Positioned but with start/end instead of left/right; requires an explicit textDirection.'),
          _bullet('PositionedDirectional — Like Positioned.directional but reads textDirection from the ambient Directionality. It is a StatelessWidget wrapper that resolves to Positioned.directional internally.'),
          _bullet('Positioned.fromRect — Build a Positioned from an absolute Rect (x, y, w, h).'),
          _bullet('Positioned.fromRelativeRect — Build a Positioned from a RelativeRect (insets from each side).'),
          _bullet('StackParentData — The parent data attached by Positioned; describes the child\'s rectangle relative to the Stack.'),
          _bullet('RelativeRect — A rectangle described by its insets from a containing rectangle\'s sides.'),
          _bullet('TextDirection — Used by directional helpers to decide which physical side (left or right) maps to logical start/end.'),
        ],
      ),
    ),
  );

  // -------------------------------------------------------------------------
  // 34. RECAP
  // -------------------------------------------------------------------------
  final Widget recap = Card(
    margin: const EdgeInsets.all(8.0),
    color: const Color(0xFFFFF3E0),
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Recap & decision matrix',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
          ),
          const SizedBox(height: 6.0),
          _bullet('Need pixel-perfect placement of one child relative to a Stack? Use Positioned.'),
          _bullet('Need the child to fill the entire Stack (typical for backgrounds)? Use Positioned.fill.'),
          _bullet('Need an inset background that still fills? Use Positioned.fill(left:, top:, right:, bottom:) — Positioned.fill accepts insets too.'),
          _bullet('Have a logical "start" or "end" instead of left/right (RTL-aware)? Use PositionedDirectional or Positioned.directional.'),
          _bullet('Already have a Rect in hand (e.g. computed by a hit-test or animation)? Use Positioned.fromRect.'),
          _bullet('Working with RelativeRect (e.g. for PositionedTransition or RelativeRectTween)? Use Positioned.fromRelativeRect.'),
          _bullet('Want children placed at a corner with NO offset math? Use Align inside Stack instead.'),
          _bullet('Want the same constraint shorthand for every non-Positioned child? Use Stack(alignment: …).'),
          const SizedBox(height: 8.0),
          const Text(
            'Mental model: Positioned writes coordinates into the StackParentData of its child. A RenderStack reads those coordinates and lays the child out at the requested rectangle, ignoring the Stack\'s own alignment.',
            style: TextStyle(fontSize: 11.0, fontStyle: FontStyle.italic),
          ),
        ],
      ),
    ),
  );

  // -------------------------------------------------------------------------
  // Trace prints — leftover from the original test contract, but informative.
  // -------------------------------------------------------------------------
  print('Positioned demo: dossier built');
  print('Positioned demo: anatomy grid built (11 canvases)');
  print('Positioned demo: 8 recipes built');
  print('Positioned demo: directional/PositionedDirectional built (4 canvases)');
  print('Positioned demo: fromRect/fromRelativeRect built (5 canvases)');
  print('Positioned demo: comparison vs Align/Stack alignment built');
  print('Positioned demo: pitfalls and glossary built');
  print('Positioned demo: 12 advanced layouts built');

  // -------------------------------------------------------------------------
  // FINAL TREE
  // -------------------------------------------------------------------------
  // We wrap everything in a single Material+Scaffold so the file resembles
  // an actual screen but stays a *pure* expression tree. No StatefulWidget.
  // -------------------------------------------------------------------------
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Positioned — Visual Deep Demo',
    home: Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        title: const Text('Positioned — Visual Deep Demo'),
        backgroundColor: const Color(0xFF263238),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            dossier,
            _section(
              '1. Anatomy — every constructor knob',
              'Each canvas pins a tile in a different way using top/right/bottom/left/width/height.',
            ),
            anatomyGrid,
            _section(
              '2. Recipe — Notification badge over avatar',
              'A tiny circular badge overlaid on the top-right of a circular avatar.',
            ),
            recipeBadgeAvatar,
            _section(
              '3. Recipe — Floating label',
              'A floating label peeking over an input border.',
            ),
            recipeFloatingLabel,
            _section(
              '4. Recipe — Corner watermark',
              'A "PAID" stamp rotated and pinned to the bottom-right.',
            ),
            recipeWatermark,
            _section(
              '5. Recipe — Sliding banner',
              'A top-pinned notification banner.',
            ),
            recipeBanner,
            _section(
              '6. Recipe — Modal dialog',
              'A scrim plus an inset rectangular dialog.',
            ),
            recipeDialog,
            _section(
              '7. Recipe — Corner ribbon',
              'A diagonal "NEW" ribbon crossing the top-left corner.',
            ),
            recipeRibbon,
            _section(
              '8. Recipe — Tooltip with arrow',
              'A black tooltip pointing down at a target via a clipped triangle.',
            ),
            recipeTooltip,
            _section(
              '9. Positioned.fill — backdrops and frames',
              'Fill the whole Stack or fill-with-insets to frame content.',
            ),
            fillRecipe,
            _section(
              '10. Positioned.directional — explicit textDirection',
              'start/end mean left/right under LTR, and right/left under RTL.',
            ),
            Wrap(
              children: <Widget>[directionalLtr, directionalRtl],
            ),
            _section(
              '11. PositionedDirectional — read ambient Directionality',
              'No need to pass textDirection — uses the closest Directionality.',
            ),
            Wrap(
              children: <Widget>[positionedDirectionalLtr, positionedDirectionalRtl],
            ),
            _section(
              '12. Positioned.fromRect',
              'Build a Positioned from an absolute Rect.',
            ),
            Wrap(
              children: <Widget>[fromRectDemo, fromRectShiftedDemo, fromRectMultiDemo],
            ),
            _section(
              '13. Positioned.fromRelativeRect',
              'Build a Positioned from a RelativeRect of insets.',
            ),
            Wrap(
              children: <Widget>[fromRelativeRectDemo, fromRelativeRectAsymmetricDemo],
            ),
            _section(
              '14. Compare — Positioned vs Align',
              'Align places by fraction; Positioned places by pixels.',
            ),
            Wrap(
              children: <Widget>[compareAlign, comparePositioned],
            ),
            _section(
              '15. Stack.alignment vs Positioned',
              'Stack.alignment governs only non-Positioned children.',
            ),
            compareStackAlignment,
            _section(
              '16. Pitfall — Conflicting horizontal/vertical constraints',
              'At most two of (left, right, width) and (top, bottom, height) may be set.',
            ),
            pitfallConflict,
            _section(
              '17. Pitfall — Positioned outside a Stack',
              'Positioned only works as a direct (or LayoutBuilder-style) Stack child.',
            ),
            pitfallOutsideStack,
            _section(
              '18. Pitfall — Unbounded Stack',
              'Stack needs bounded constraints when using two opposite sides.',
            ),
            pitfallUnbounded,
            _section(
              '19. Animation snapshot',
              'A frozen sweep at t=0, t=0.5, t=1 to imagine how AnimatedPositioned would tween.',
            ),
            sweepRow,
            _section(
              '20. Advanced — Polar layout',
              '12 tiles laid out on a circle using cos/sin and Positioned.',
            ),
            polarLayout,
            _section(
              '21. Advanced — Manual grid',
              'A 4x3 grid built by hand, each cell a Positioned.',
            ),
            manualGrid,
            _section(
              '22. Advanced — Stairs',
              'Each tile shifted up-and-right by a constant offset.',
            ),
            stairsLayout,
            _section(
              '23. Advanced — Cross',
              'A plus sign made of two stretched Positioned bars.',
            ),
            crossLayout,
            _section(
              '24. Advanced — Page corners',
              'Four diagonal Positioned corner tiles with rotations.',
            ),
            pageCorners,
            _section(
              '25. Advanced — Floating action button',
              'FAB pinned bottom-right above a bottom bar.',
            ),
            fabRecipe,
            _section(
              '26. Advanced — Drawer handle',
              'A left-edge drawer bar with a small chevron handle.',
            ),
            drawerHandle,
            _section(
              '27. Advanced — Speech bubble',
              'Rounded rect plus a clipped triangle for the pointer.',
            ),
            speechBubble,
            _section(
              '28. Advanced — Progress overlay',
              'A grey background bar plus an overlapping coloured fill.',
            ),
            progressOverlay,
            _section(
              '29. Advanced — Rotated stamps',
              'Several Positioned + Transform.rotate stamps overlapping.',
            ),
            stamps,
            _section(
              '30. Advanced — Image card with caption strip',
              'An image background with a bottom translucent caption strip.',
            ),
            imageCaptionStrip,
            _section(
              '31. Advanced — Tabbed top bar',
              'A row of tabs plus a Positioned active-indicator bar.',
            ),
            tabbedBar,
            _section(
              '32. Advanced — Stacked floating buttons',
              'A vertical column of mini FABs pinned to the bottom-right.',
            ),
            floatingMenu,
            _section(
              '33. Glossary',
              'Terms used throughout this demo.',
            ),
            glossary,
            _section(
              '34. Recap',
              'When to use which Positioned constructor.',
            ),
            recap,
          ],
        ),
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Auxiliary widgets and clippers.
// ---------------------------------------------------------------------------

class _Tab extends StatelessWidget {
  const _Tab(this.label, {required this.active});
  final String label;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        color: active ? const Color(0xFFEDE7F6) : Colors.white,
        child: Text(
          label,
          style: TextStyle(
            fontWeight: active ? FontWeight.bold : FontWeight.normal,
            color: active ? Colors.deepPurple : Colors.black54,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }
}

class _TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path p = Path();
    p.moveTo(0, 0);
    p.lineTo(size.width, 0);
    p.lineTo(size.width / 2, size.height);
    p.close();
    return p;
  }

  @override
  bool shouldReclip(covariant _TriangleClipper oldClipper) => false;
}

class _CornerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path p = Path();
    p.moveTo(0, 0);
    p.lineTo(size.width, 0);
    p.lineTo(0, size.height);
    p.close();
    return p;
  }

  @override
  bool shouldReclip(covariant _CornerClipper oldClipper) => false;
}

// ---------------------------------------------------------------------------
// END OF FILE
// ---------------------------------------------------------------------------
//
// Reflection: This file is intentionally large — it documents the entire
// Positioned family with hand-crafted canvases. Every constructor receives
// its own labelled demo, and every important pitfall is explicitly described
// so future readers can avoid the over-constraint and outside-of-Stack traps.
//
// If you want to extend this demo:
//
//   1. Add new canvases by composing _canvas(..., children: [...Positioned...]).
//   2. Annotate them with the _label() helper so coordinates are visible.
//   3. Add a matching `_section(...)` entry in the main column.
//   4. Keep the top-level shape: ignore_for_file → imports → build().
//
// ---------------------------------------------------------------------------
