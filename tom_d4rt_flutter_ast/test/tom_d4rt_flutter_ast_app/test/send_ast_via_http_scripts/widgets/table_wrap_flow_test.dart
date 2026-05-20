// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unused_element, dead_code, unnecessary_import, no_leading_underscores_for_local_identifiers, use_super_parameters
// D4rt test script: Deep visual demo of the Flutter Table / Wrap / Flow trio.
//
// This file belongs to the D4rt flutter-test corpus and is executed by an
// analyzer-free, sandboxed Dart interpreter. The script exports exactly one
// top-level entry point - `dynamic build(BuildContext)` - which the runtime
// invokes a single time. The returned widget tree is then handed straight to
// the host app's renderer.
//
// The rendered output is a long, static gallery that explores the three
// multi-child layout widgets that sit *outside* the Row/Column/Stack staple:
//
//   1. Hero intro - the "layout-of-many" triad: Table, Wrap, Flow.
//   2. Class hierarchy CustomPainter - RenderObjectWidget descendants,
//      TableColumnWidth subclasses and the FlowDelegate listenable shape.
//   3. Table deep-dive - TableRow, TableCell, the five TableColumnWidth
//      strategies side-by-side, TableBorder presets, and
//      TableCellVerticalAlignment options.
//   4. Wrap deep-dive - direction, spacing, runSpacing, WrapAlignment and
//      WrapCrossAlignment shown across a chip-like Container cluster.
//   5. Flow deep-dive - a CustomPainter mock of FlowDelegate / paintChildren /
//      getSize with a real (static) Flow widget driven by a const Listenable.
//   6. Comparison matrix - Table vs DataTable, Wrap vs RowFlow, plus a row
//      of differences against Row, Column and GridView.
//   7. Recipe code cards - six idiomatic snippets.
//   8. Pitfalls panel - six callouts that commonly bite layout engineers.
//   9. Cheat-sheet footer - chip groups for the Table/Wrap/Flow surface area.
//
// Build-time discipline: no `setState`, no `Timer`, no `Future`, no live
// `AnimationController`, no async, no Streams, no `Tween.animate(...).value`
// reads, and no for-in over BridgedInstance from Flutter APIs. All Flow
// delegates use a `const _kRepaintNever` Listenable so the rendering is fully
// static, and TableColumnWidth instances are constructed locally so their
// type names can be reflected in the diagnostics row.
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
const Color _kCanvas = Color(0xFFF1F4F6);
const Color _kCardBg = Color(0xFFFFFFFF);
const Color _kCardSoft = Color(0xFFF6F9FB);
const Color _kCardDark = Color(0xFF14202B);
const Color _kHairline = Color(0x14000000);
const Color _kHairlineDark = Color(0x33FFFFFF);
const Color _kInk = Color(0xFF14202B);
const Color _kInkSecondary = Color(0xFF3D4A57);
const Color _kInkTertiary = Color(0xFF8595A4);
const Color _kInkOnDark = Color(0xFFEDF3F7);
const Color _kInkOnDarkSecondary = Color(0xFFA8B6C2);
const Color _kAccent = Color(0xFF0F766E);
const Color _kAccentSoft = Color(0xFFCCFBF1);
const Color _kAccentBlue = Color(0xFF1D4ED8);
const Color _kAccentCyan = Color(0xFF0891B2);
const Color _kAccentGreen = Color(0xFF15803D);
const Color _kAccentAmber = Color(0xFFD97706);
const Color _kAccentRose = Color(0xFFBE123C);
const Color _kAccentViolet = Color(0xFF7C3AED);
const Color _kAccentSlate = Color(0xFF475569);
const Color _kGridLine = Color(0xFFDDE5EB);
const Color _kCellTint = Color(0xFFE0F2F1);
const Color _kCellTintAlt = Color(0xFFFEF3C7);
const Color _kCodeBg = Color(0xFF1B1D22);
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
const TextStyle _kBodySoftStyle = TextStyle(
  fontSize: 13.0,
  height: 1.4,
  color: _kInkSecondary,
);
const TextStyle _kCodeStyle = TextStyle(
  fontSize: 12.5,
  fontFamily: 'monospace',
  color: _kCodeText,
  height: 1.45,
  fontFeatures: <FontFeature>[FontFeature.tabularFigures()],
);
const TextStyle _kMonoInlineStyle = TextStyle(
  fontSize: 12.5,
  fontFamily: 'monospace',
  color: _kInk,
  height: 1.3,
);
const EdgeInsets _kCardPadding = EdgeInsets.all(18.0);

// ---------------------------------------------------------------------------
// PRIVATE BUILDER HELPERS
// ---------------------------------------------------------------------------
Widget _sectionHeader(int index, String title, String tagline) {
  return Padding(
    padding: const EdgeInsets.only(top: 30.0, bottom: 12.0, left: 18.0, right: 18.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 38.0,
          height: 38.0,
          alignment: Alignment.center,
          decoration: const BoxDecoration(color: _kAccent, shape: BoxShape.circle),
          child: Text('$index',
              style: const TextStyle(
                  color: Color(0xFFFFFFFF), fontSize: 16.0, fontWeight: FontWeight.w700)),
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
}) {
  return Container(
    margin: margin,
    padding: padding,
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _kHairline),
      boxShadow: const <BoxShadow>[
        BoxShadow(color: Color(0x0D000000), offset: Offset(0.0, 1.0), blurRadius: 3.0),
      ],
    ),
    child: child,
  );
}

Widget _cardTitle(String title,
    {String? subtitle, Color titleColor = _kInk, Color subtitleColor = _kInkSecondary}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(title,
          style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: titleColor,
              letterSpacing: -0.2)),
      if (subtitle != null) ...<Widget>[
        const SizedBox(height: 2.0),
        Text(subtitle, style: TextStyle(fontSize: 12.5, color: subtitleColor)),
      ],
    ],
  );
}

Widget _pill(String label, {Color colour = _kAccent}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: 3.0),
    decoration: BoxDecoration(
      color: colour.withOpacity(0.12),
      borderRadius: BorderRadius.circular(999.0),
      border: Border.all(color: colour.withOpacity(0.3)),
    ),
    child: Text(label,
        style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600, color: colour)),
  );
}

Widget _sectionDivider() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 16.0),
    height: 1.0,
    color: _kHairline,
  );
}

Widget _kvRow(String key, String value, {Color valueColour = _kInk}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 210.0,
          child: Text(key,
              style: const TextStyle(
                  fontSize: 12.5, fontFamily: 'monospace', color: _kInkSecondary)),
        ),
        Expanded(
          child: Text(value,
              style:
                  TextStyle(fontSize: 12.5, fontFamily: 'monospace', color: valueColour)),
        ),
      ],
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
                decoration: const BoxDecoration(
                    color: Color(0xFFFF5F56), shape: BoxShape.circle),
              ),
              const SizedBox(width: 6.0),
              Container(
                width: 10.0,
                height: 10.0,
                decoration: const BoxDecoration(
                    color: Color(0xFFFFBD2E), shape: BoxShape.circle),
              ),
              const SizedBox(width: 6.0),
              Container(
                width: 10.0,
                height: 10.0,
                decoration: const BoxDecoration(
                    color: Color(0xFF27C93F), shape: BoxShape.circle),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Text(title,
                    style: const TextStyle(
                        color: _kCodeAccent,
                        fontFamily: 'monospace',
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600)),
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

// A const, never-firing Listenable for Flow delegates. Flow widgets need a
// `repaint` argument; using this means the demo never schedules a repaint.
class _NeverNotifier extends Listenable {
  const _NeverNotifier();
  @override
  void addListener(VoidCallback listener) {}
  @override
  void removeListener(VoidCallback listener) {}
}

const _NeverNotifier _kRepaintNever = _NeverNotifier();

// A label tile used in many sections.
Widget _labelTile(String text,
    {Color background = _kAccentSoft,
    Color text_ = _kAccent,
    double width = 80.0,
    double height = 32.0,
    EdgeInsets margin = EdgeInsets.zero}) {
  return Container(
    width: width,
    height: height,
    alignment: Alignment.center,
    margin: margin,
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(color: text_.withOpacity(0.35)),
    ),
    child: Text(text,
        style: TextStyle(
            fontSize: 11.5, fontWeight: FontWeight.w600, color: text_)),
  );
}

// ---------------------------------------------------------------------------
// SECTION 1 - HERO INTRO
// ---------------------------------------------------------------------------
Widget _heroBanner() {
  return Container(
    margin: const EdgeInsets.fromLTRB(18.0, 20.0, 18.0, 8.0),
    padding: const EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFF134E4A), Color(0xFF0F766E), Color(0xFF0891B2)],
      ),
      borderRadius: BorderRadius.circular(18.0),
      boxShadow: const <BoxShadow>[
        BoxShadow(color: Color(0x33134E4A), offset: Offset(0.0, 6.0), blurRadius: 18.0),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: const Color(0x33FFFFFF),
                borderRadius: BorderRadius.circular(999.0),
              ),
              child: const Text('package:flutter/widgets.dart',
                  style: TextStyle(
                      color: Color(0xFFEDF3F7),
                      fontSize: 11.5,
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.w600)),
            ),
            const SizedBox(width: 10.0),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: const Color(0x33FFFFFF),
                borderRadius: BorderRadius.circular(999.0),
              ),
              child: const Text('table.dart / wrap.dart / flow.dart',
                  style: TextStyle(
                      color: Color(0xFFEDF3F7),
                      fontSize: 11.5,
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.w600)),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        const Text('Table, Wrap, Flow',
            style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 30.0,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.6)),
        const SizedBox(height: 8.0),
        const Text(
          'Three layout-of-many widgets that sit beside Row, Column and '
          'GridView - structured columns, run-flow chips, and free-form '
          'delegate-driven paint - in one static gallery.',
          style: TextStyle(color: Color(0xFFD4EAEA), fontSize: 14.5, height: 1.45),
        ),
        const SizedBox(height: 16.0),
        Row(
          children: <Widget>[
            _pill('Table', colour: const Color(0xFFFDE68A)),
            const SizedBox(width: 8.0),
            _pill('Wrap', colour: const Color(0xFFBBF7D0)),
            const SizedBox(width: 8.0),
            _pill('Flow', colour: const Color(0xFFBAE6FD)),
            const SizedBox(width: 8.0),
            _pill('vs Row/Column/GridView', colour: const Color(0xFFFBCFE8)),
          ],
        ),
      ],
    ),
  );
}

Widget _heroIntroCard() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle('The layout-of-many triad',
            subtitle:
                'Each widget answers a different question about a list of children. '
                'Pick the one whose constraints match your data, not the one whose '
                'name sounds friendliest.'),
        const SizedBox(height: 14.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: _triadCard('Table',
                'Children live in a rigid grid of rows and columns. Column widths are computed by TableColumnWidth strategies and shared across every row.',
                _kAccent, _kAccentSoft)),
            const SizedBox(width: 10.0),
            Expanded(child: _triadCard('Wrap',
                'Children flow along one axis (horizontal or vertical) and break into a new run when the main axis fills up. Think of CSS flexbox with wrap.',
                _kAccentGreen, const Color(0xFFDCFCE7))),
            const SizedBox(width: 10.0),
            Expanded(child: _triadCard('Flow',
                'Children paint at offsets returned by a FlowDelegate. Layout is free-form; getSize gives the overall size, paintChildren picks transforms.',
                _kAccentBlue, const Color(0xFFDBEAFE))),
          ],
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: _kCardSoft,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: _kHairline),
          ),
          child: const Text(
            'Mental model: Table is "shared column model", Wrap is "main-axis '
            'flow with run break", Flow is "delegate-driven paint". All three '
            'are RenderObjectWidgets that ultimately produce a single '
            'RenderBox in the render tree.',
            style: _kBodySoftStyle,
          ),
        ),
      ],
    ),
  );
}

Widget _triadCard(String title, String body, Color accent, Color soft) {
  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: soft,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: accent.withOpacity(0.35)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(children: <Widget>[
          Container(
            width: 28.0,
            height: 28.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(color: accent, borderRadius: BorderRadius.circular(8.0)),
            child: Text(title.substring(0, 1),
                style: const TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 14.0,
                    fontWeight: FontWeight.w800)),
          ),
          const SizedBox(width: 8.0),
          Text(title,
              style: TextStyle(
                  fontSize: 15.0, fontWeight: FontWeight.w700, color: accent)),
        ]),
        const SizedBox(height: 8.0),
        Text(body, style: const TextStyle(fontSize: 12.5, height: 1.4, color: _kInkSecondary)),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 2 - CLASS HIERARCHY CUSTOM PAINTER
// ---------------------------------------------------------------------------
class _HierarchyBox {
  const _HierarchyBox({
    required this.x,
    required this.y,
    required this.w,
    required this.h,
    required this.label,
    required this.colour,
    this.italic = false,
  });
  final double x;
  final double y;
  final double w;
  final double h;
  final String label;
  final Color colour;
  final bool italic;
}

class _HierarchyEdge {
  const _HierarchyEdge(this.fromIdx, this.toIdx);
  final int fromIdx;
  final int toIdx;
}

class _HierarchyPainter extends CustomPainter {
  _HierarchyPainter();

  static const List<_HierarchyBox> boxes = <_HierarchyBox>[
    _HierarchyBox(
        x: 270.0, y: 4.0, w: 200.0, h: 32.0, label: 'RenderObjectWidget', colour: _kInkSecondary),
    _HierarchyBox(
        x: 270.0, y: 60.0, w: 200.0, h: 32.0, label: 'MultiChildRenderObjectWidget', colour: _kInkSecondary),
    _HierarchyBox(
        x: 60.0, y: 130.0, w: 160.0, h: 36.0, label: 'Table', colour: _kAccent),
    _HierarchyBox(
        x: 290.0, y: 130.0, w: 160.0, h: 36.0, label: 'Wrap', colour: _kAccentGreen),
    _HierarchyBox(
        x: 520.0, y: 130.0, w: 160.0, h: 36.0, label: 'Flow', colour: _kAccentBlue),
    _HierarchyBox(
        x: 60.0, y: 200.0, w: 160.0, h: 30.0, label: 'RenderTable', colour: _kInkTertiary, italic: true),
    _HierarchyBox(
        x: 290.0, y: 200.0, w: 160.0, h: 30.0, label: 'RenderWrap', colour: _kInkTertiary, italic: true),
    _HierarchyBox(
        x: 520.0, y: 200.0, w: 160.0, h: 30.0, label: 'RenderFlow', colour: _kInkTertiary, italic: true),
    _HierarchyBox(
        x: 30.0, y: 260.0, w: 110.0, h: 28.0, label: 'TableRow', colour: _kAccentAmber),
    _HierarchyBox(
        x: 150.0, y: 260.0, w: 110.0, h: 28.0, label: 'TableCell', colour: _kAccentAmber),
    _HierarchyBox(
        x: 30.0, y: 295.0, w: 230.0, h: 28.0, label: 'TableColumnWidth (abstract)', colour: _kAccentRose),
    _HierarchyBox(
        x: 30.0, y: 330.0, w: 230.0, h: 60.0,
        label: 'Fixed | Flex | Intrinsic\nMax | Min | Fraction',
        colour: _kAccentViolet),
    _HierarchyBox(
        x: 280.0, y: 260.0, w: 180.0, h: 28.0, label: 'WrapAlignment', colour: _kAccentGreen),
    _HierarchyBox(
        x: 280.0, y: 295.0, w: 180.0, h: 28.0, label: 'WrapCrossAlignment', colour: _kAccentGreen),
    _HierarchyBox(
        x: 280.0, y: 330.0, w: 180.0, h: 28.0, label: 'Axis (horizontal/vertical)', colour: _kAccentGreen),
    _HierarchyBox(
        x: 490.0, y: 260.0, w: 210.0, h: 28.0, label: 'FlowDelegate', colour: _kAccentBlue),
    _HierarchyBox(
        x: 490.0, y: 295.0, w: 210.0, h: 28.0, label: 'FlowPaintingContext', colour: _kAccentBlue),
    _HierarchyBox(
        x: 490.0, y: 330.0, w: 210.0, h: 28.0, label: 'paintChildren() / getSize()', colour: _kAccentBlue),
  ];

  static const List<_HierarchyEdge> edges = <_HierarchyEdge>[
    _HierarchyEdge(0, 1),
    _HierarchyEdge(1, 2),
    _HierarchyEdge(1, 3),
    _HierarchyEdge(1, 4),
    _HierarchyEdge(2, 5),
    _HierarchyEdge(3, 6),
    _HierarchyEdge(4, 7),
    _HierarchyEdge(2, 8),
    _HierarchyEdge(2, 9),
    _HierarchyEdge(2, 10),
    _HierarchyEdge(10, 11),
    _HierarchyEdge(3, 12),
    _HierarchyEdge(3, 13),
    _HierarchyEdge(3, 14),
    _HierarchyEdge(4, 15),
    _HierarchyEdge(15, 16),
    _HierarchyEdge(15, 17),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = _kCardSoft;
    canvas.drawRRect(
        RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(10.0)), bg);

    final Paint edgePaint = Paint()
      ..color = _kInkTertiary
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < edges.length; i++) {
      final _HierarchyEdge e = edges[i];
      final _HierarchyBox a = boxes[e.fromIdx];
      final _HierarchyBox b = boxes[e.toIdx];
      final Offset start = Offset(a.x + a.w / 2.0, a.y + a.h);
      final Offset end = Offset(b.x + b.w / 2.0, b.y);
      final Path p = Path()
        ..moveTo(start.dx, start.dy)
        ..cubicTo(start.dx, (start.dy + end.dy) / 2.0, end.dx,
            (start.dy + end.dy) / 2.0, end.dx, end.dy);
      canvas.drawPath(p, edgePaint);
    }

    for (int i = 0; i < boxes.length; i++) {
      final _HierarchyBox b = boxes[i];
      final Rect r = Rect.fromLTWH(b.x, b.y, b.w, b.h);
      final Paint fill = Paint()..color = b.colour.withOpacity(0.18);
      final Paint stroke = Paint()
        ..color = b.colour.withOpacity(0.7)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.4;
      final RRect rr = RRect.fromRectAndRadius(r, const Radius.circular(7.0));
      canvas.drawRRect(rr, fill);
      canvas.drawRRect(rr, stroke);
      final TextSpan span = TextSpan(
        text: b.label,
        style: TextStyle(
          fontSize: 11.5,
          color: b.colour,
          fontWeight: FontWeight.w700,
          fontStyle: b.italic ? FontStyle.italic : FontStyle.normal,
          height: 1.2,
        ),
      );
      final TextPainter tp = TextPainter(
        text: span,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
        maxLines: 3,
      )..layout(maxWidth: b.w - 6.0);
      tp.paint(canvas,
          Offset(b.x + (b.w - tp.width) / 2.0, b.y + (b.h - tp.height) / 2.0));
    }
  }

  @override
  bool shouldRepaint(covariant _HierarchyPainter oldDelegate) => false;
}

Widget _hierarchySection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _cardTitle('RenderObjectWidget descendants',
                subtitle:
                    'Each of Table, Wrap and Flow is a MultiChildRenderObjectWidget '
                    'that owns a dedicated RenderBox subclass and a small family of '
                    'configuration types.'),
            const SizedBox(height: 12.0),
            SizedBox(
              height: 410.0,
              child: CustomPaint(
                painter: _HierarchyPainter(),
                size: const Size(double.infinity, 410.0),
              ),
            ),
            const SizedBox(height: 10.0),
            Wrap(
              spacing: 8.0,
              runSpacing: 6.0,
              children: <Widget>[
                _pill('Widget', colour: _kAccent),
                _pill('RenderBox', colour: _kInkTertiary),
                _pill('Config', colour: _kAccentRose),
                _pill('Enum', colour: _kAccentGreen),
                _pill('Delegate', colour: _kAccentBlue),
              ],
            ),
          ],
        ),
      ),
      _card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _cardTitle('Configuration surface at a glance'),
            const SizedBox(height: 8.0),
            _kvRow('Table', 'children: List<TableRow>, columnWidths, defaultColumnWidth, border, defaultVerticalAlignment, textBaseline'),
            _kvRow('TableRow', 'decoration, children: List<Widget>'),
            _kvRow('TableCell', 'verticalAlignment, child'),
            _kvRow('TableColumnWidth', 'minIntrinsicWidth, maxIntrinsicWidth, flex'),
            _kvRow('Wrap', 'direction, alignment, spacing, runAlignment, runSpacing, crossAxisAlignment, textDirection, verticalDirection, clipBehavior'),
            _kvRow('Flow', 'delegate: FlowDelegate, children, clipBehavior'),
            _kvRow('FlowDelegate', 'paintChildren(ctx), getSize(constraints), getConstraintsForChild(i, c), shouldRepaint, shouldRelayout'),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// SECTION 3 - TABLE DEEP-DIVE
// ---------------------------------------------------------------------------
Widget _tableSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _tableColumnStrategyCard(),
      _tableBorderPresetsCard(),
      _tableVerticalAlignmentCard(),
      _tableDiagnosticsCard(),
    ],
  );
}

Widget _tableColumnStrategyCard() {
  // Build five small tables side-by-side, each demonstrating a different
  // TableColumnWidth subclass for its middle column.
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle('Five TableColumnWidth strategies',
            subtitle:
                'Each mini-table puts a different TableColumnWidth instance in '
                'the middle slot. The outer columns are FixedColumnWidth so the '
                'centre treatment is the only variable.'),
        const SizedBox(height: 12.0),
        Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          children: <Widget>[
            _miniTable('FixedColumnWidth(80)',
                'Resolves to a fixed width, ignoring children.',
                const FixedColumnWidth(80.0), _kAccent),
            _miniTable('FlexColumnWidth(2)',
                'Takes a flex share of leftover space, like Expanded.',
                const FlexColumnWidth(2.0), _kAccentBlue),
            _miniTable('IntrinsicColumnWidth()',
                'Sizes to fit child intrinsic widths. Expensive at scale.',
                const IntrinsicColumnWidth(), _kAccentGreen),
            _miniTable('MaxColumnWidth(Intrinsic, Fixed(60))',
                'Takes the larger of two strategies per row.',
                const MaxColumnWidth(IntrinsicColumnWidth(), FixedColumnWidth(60.0)),
                _kAccentAmber),
            _miniTable('MinColumnWidth(Flex(1), Fixed(60))',
                'Takes the smaller of two strategies per row.',
                const MinColumnWidth(FlexColumnWidth(1.0), FixedColumnWidth(60.0)),
                _kAccentRose),
            _miniTable('FractionColumnWidth(0.25)',
                'Takes a fraction of the table\'s maximum width.',
                const FractionColumnWidth(0.25), _kAccentViolet),
          ],
        ),
      ],
    ),
  );
}

Widget _miniTable(
    String title, String body, TableColumnWidth centre, Color accent) {
  return Container(
    width: 285.0,
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: _kCardSoft,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: accent.withOpacity(0.35)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(title,
            style: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w700,
                color: accent,
                fontFamily: 'monospace')),
        const SizedBox(height: 4.0),
        Text(body,
            style: const TextStyle(
                fontSize: 11.5, color: _kInkSecondary, height: 1.35)),
        const SizedBox(height: 10.0),
        Table(
          columnWidths: <int, TableColumnWidth>{
            0: const FixedColumnWidth(50.0),
            1: centre,
            2: const FixedColumnWidth(50.0),
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          border: TableBorder.all(color: accent.withOpacity(0.5), width: 1.0),
          children: <TableRow>[
            TableRow(
              decoration: BoxDecoration(color: accent.withOpacity(0.1)),
              children: <Widget>[
                _tableHeaderCell('A', accent),
                _tableHeaderCell('B', accent),
                _tableHeaderCell('C', accent),
              ],
            ),
            TableRow(children: <Widget>[
              _tableBodyCell('aaa'),
              _tableBodyCell('long long center'),
              _tableBodyCell('ccc'),
            ]),
            TableRow(children: <Widget>[
              _tableBodyCell('x'),
              _tableBodyCell('mid'),
              _tableBodyCell('y'),
            ]),
          ],
        ),
      ],
    ),
  );
}

Widget _tableHeaderCell(String text, Color accent) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 6.0),
    child: Text(text,
        style: TextStyle(
            fontSize: 11.5, fontWeight: FontWeight.w700, color: accent)),
  );
}

Widget _tableBodyCell(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 6.0),
    child: Text(text,
        style: const TextStyle(fontSize: 11.5, color: _kInk)),
  );
}

Widget _tableBorderPresetsCard() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle('TableBorder presets',
            subtitle:
                'TableBorder controls top/right/bottom/left + horizontalInside + '
                'verticalInside as independent BorderSides. Three common shapes:'),
        const SizedBox(height: 12.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: _borderDemo('TableBorder.all',
                'Outer + inner grid lines, uniform colour.',
                TableBorder.all(color: _kAccent, width: 1.2))),
            const SizedBox(width: 12.0),
            Expanded(child: _borderDemo('TableBorder.symmetric',
                'inside vs outside as separate sides.',
                const TableBorder.symmetric(
                    inside: BorderSide(color: _kAccentBlue, width: 1.5),
                    outside: BorderSide(color: _kInkSecondary, width: 2.0)))),
            const SizedBox(width: 12.0),
            Expanded(child: _borderDemo('TableBorder(...)',
                'Manual: only horizontalInside set.',
                const TableBorder(
                    horizontalInside:
                        BorderSide(color: _kAccentGreen, width: 1.2)))),
          ],
        ),
      ],
    ),
  );
}

Widget _borderDemo(String title, String body, TableBorder border) {
  return Container(
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: _kCardSoft,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: _kHairline),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(title,
            style: const TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w700,
                fontFamily: 'monospace',
                color: _kInk)),
        const SizedBox(height: 2.0),
        Text(body,
            style:
                const TextStyle(fontSize: 11.0, color: _kInkSecondary, height: 1.35)),
        const SizedBox(height: 8.0),
        Table(
          border: border,
          columnWidths: const <int, TableColumnWidth>{
            0: FlexColumnWidth(1.0),
            1: FlexColumnWidth(1.0),
            2: FlexColumnWidth(1.0),
          },
          children: <TableRow>[
            TableRow(children: <Widget>[
              _tableBodyCell('A1'),
              _tableBodyCell('A2'),
              _tableBodyCell('A3'),
            ]),
            TableRow(children: <Widget>[
              _tableBodyCell('B1'),
              _tableBodyCell('B2'),
              _tableBodyCell('B3'),
            ]),
            TableRow(children: <Widget>[
              _tableBodyCell('C1'),
              _tableBodyCell('C2'),
              _tableBodyCell('C3'),
            ]),
          ],
        ),
      ],
    ),
  );
}

Widget _tableVerticalAlignmentCard() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle('TableCellVerticalAlignment',
            subtitle:
                'Each column shows the same tall row painted with a different '
                'vertical alignment for the short cell.'),
        const SizedBox(height: 10.0),
        // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #135, P9):
        // The "baseline" column uses `TableCellVerticalAlignment.baseline`
        // (line below), which requires the enclosing Table to declare an
        // explicit `textBaseline`. Without it Flutter asserts at
        // table.dart:1372 'textBaseline != null': "An explicit textBaseline
        // is required when using baseline alignment.". Setting
        // `textBaseline: TextBaseline.alphabetic` (the only Roman-script
        // baseline; `ideographic` is for CJK glyphs and would visually be
        // identical here) clears the assertion while preserving the baseline
        // demonstration's visual intent (the short text in the baseline cell
        // sits on the alphabetic baseline of the tall row's first text line).
        Table(
          border: TableBorder.all(color: _kGridLine, width: 1.0),
          textBaseline: TextBaseline.alphabetic,
          columnWidths: const <int, TableColumnWidth>{
            0: FlexColumnWidth(1.0),
            1: FlexColumnWidth(1.0),
            2: FlexColumnWidth(1.0),
            3: FlexColumnWidth(1.0),
            4: FlexColumnWidth(1.0),
          },
          children: <TableRow>[
            TableRow(
              decoration: const BoxDecoration(color: _kCellTint),
              children: <Widget>[
                _tableHeaderCell('top', _kAccent),
                _tableHeaderCell('middle', _kAccent),
                _tableHeaderCell('bottom', _kAccent),
                _tableHeaderCell('baseline', _kAccent),
                _tableHeaderCell('fill', _kAccent),
              ],
            ),
            TableRow(children: <Widget>[
              TableCell(
                verticalAlignment: TableCellVerticalAlignment.top,
                child: _alignCellShort(),
              ),
              TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: _alignCellShort(),
              ),
              TableCell(
                verticalAlignment: TableCellVerticalAlignment.bottom,
                child: _alignCellShort(),
              ),
              TableCell(
                verticalAlignment: TableCellVerticalAlignment.baseline,
                child: _alignCellShort(),
              ),
              TableCell(
                verticalAlignment: TableCellVerticalAlignment.fill,
                child: Container(
                  color: _kAccentSoft,
                  alignment: Alignment.center,
                  child: const Text('fills',
                      style: TextStyle(fontSize: 11.5, color: _kAccent)),
                ),
              ),
            ]),
            TableRow(children: <Widget>[
              for (int i = 0; i < 5; i++) _alignCellTall(i),
            ]),
          ],
        ),
      ],
    ),
  );
}

Widget _alignCellShort() {
  return const Padding(
    padding: EdgeInsets.all(6.0),
    child: Text('short',
        style: TextStyle(fontSize: 11.5, color: _kInk)),
  );
}

Widget _alignCellTall(int idx) {
  return Container(
    padding: const EdgeInsets.all(6.0),
    height: 80.0,
    alignment: Alignment.topLeft,
    color: idx.isEven ? _kCardSoft : _kCellTintAlt.withOpacity(0.4),
    child: Text('tall row\n#$idx\nline three',
        style: const TextStyle(fontSize: 11.0, color: _kInkSecondary, height: 1.3)),
  );
}

Widget _tableDiagnosticsCard() {
  final FixedColumnWidth fixedW = const FixedColumnWidth(80.0);
  final FlexColumnWidth flexW = const FlexColumnWidth(2.0);
  final IntrinsicColumnWidth intrinsicW = const IntrinsicColumnWidth();
  final MaxColumnWidth maxW =
      const MaxColumnWidth(IntrinsicColumnWidth(), FixedColumnWidth(60.0));
  final MinColumnWidth minW =
      const MinColumnWidth(FlexColumnWidth(1.0), FixedColumnWidth(60.0));
  final FractionColumnWidth fracW = const FractionColumnWidth(0.25);
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle('TableColumnWidth diagnostics',
            subtitle:
                'Inspecting runtime types & values of the six instances above.'),
        const SizedBox(height: 8.0),
        _kvRow('FixedColumnWidth.value', '80.0'),
        _kvRow('FlexColumnWidth.value', '2.0'),
        _kvRow('IntrinsicColumnWidth.flex', 'null (no flex by default)'),
        _kvRow('MaxColumnWidth.a/b', 'IntrinsicColumnWidth, FixedColumnWidth(60.0)'),
        _kvRow('MinColumnWidth.a/b', 'FlexColumnWidth(1.0), FixedColumnWidth(60.0)'),
        _kvRow('FractionColumnWidth.value', '0.25'),
        const SizedBox(height: 8.0),
        Wrap(spacing: 6.0, runSpacing: 6.0, children: <Widget>[
          _pill('${fixedW.runtimeType}', colour: _kAccent),
          _pill('${flexW.runtimeType}', colour: _kAccentBlue),
          _pill('${intrinsicW.runtimeType}', colour: _kAccentGreen),
          _pill('${maxW.runtimeType}', colour: _kAccentAmber),
          _pill('${minW.runtimeType}', colour: _kAccentRose),
          _pill('${fracW.runtimeType}', colour: _kAccentViolet),
        ]),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 4 - WRAP DEEP-DIVE
// ---------------------------------------------------------------------------
const List<String> _kWrapChipLabels = <String>[
  'flutter', 'dart', 'widgets', 'painting', 'rendering',
  'foundation', 'gestures', 'services', 'animation',
  'semantics', 'cupertino', 'material', 'scheduler',
];

Widget _wrapChip(String label, {Color colour = _kAccent, double pad = 10.0}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: pad, vertical: pad * 0.4),
    decoration: BoxDecoration(
      color: colour.withOpacity(0.12),
      borderRadius: BorderRadius.circular(999.0),
      border: Border.all(color: colour.withOpacity(0.4)),
    ),
    child: Text(label,
        style: TextStyle(
            fontSize: 11.5, fontWeight: FontWeight.w600, color: colour)),
  );
}

List<Widget> _wrapChips({double sizeMul = 1.0}) {
  final List<Widget> out = <Widget>[];
  for (int i = 0; i < _kWrapChipLabels.length; i++) {
    final String label = _kWrapChipLabels[i];
    final Color c = <Color>[
      _kAccent,
      _kAccentBlue,
      _kAccentGreen,
      _kAccentAmber,
      _kAccentRose,
      _kAccentViolet,
      _kAccentCyan,
    ][i % 7];
    out.add(_wrapChip(label, colour: c, pad: 10.0 * sizeMul));
  }
  return out;
}

Widget _wrapDemoFrame(String title, String body, Widget child,
    {double height = 140.0}) {
  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: _kCardSoft,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: _kHairline),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(title,
            style: const TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w700,
                fontFamily: 'monospace',
                color: _kInk)),
        const SizedBox(height: 2.0),
        Text(body,
            style:
                const TextStyle(fontSize: 11.0, color: _kInkSecondary, height: 1.35)),
        const SizedBox(height: 10.0),
        SizedBox(
          height: height,
          width: double.infinity,
          child: ClipRect(child: child),
        ),
      ],
    ),
  );
}

Widget _wrapSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _wrapAlignmentMatrixCard(),
      _wrapCrossAlignmentCard(),
      _wrapDirectionCard(),
      _wrapSpacingMatrixCard(),
    ],
  );
}

Widget _wrapAlignmentMatrixCard() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle('WrapAlignment - five chip clusters',
            subtitle:
                'Same chip set, identical runSpacing/spacing, varying only the '
                'main-axis alignment within each run.'),
        const SizedBox(height: 12.0),
        Wrap(
          spacing: 12.0,
          runSpacing: 12.0,
          children: <Widget>[
            SizedBox(width: 330.0, child: _wrapDemoFrame('WrapAlignment.start',
                'Children packed at the start of each run.',
                Container(
                  color: _kCardBg,
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    spacing: 6.0, runSpacing: 6.0, children: _wrapChips()),
                ))),
            SizedBox(width: 330.0, child: _wrapDemoFrame('WrapAlignment.center',
                'Symmetric padding on the leading/trailing edges.',
                Container(
                  color: _kCardBg,
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 6.0, runSpacing: 6.0, children: _wrapChips()),
                ))),
            SizedBox(width: 330.0, child: _wrapDemoFrame('WrapAlignment.end',
                'Children packed at the end of each run.',
                Container(
                  color: _kCardBg,
                  child: Wrap(
                    alignment: WrapAlignment.end,
                    spacing: 6.0, runSpacing: 6.0, children: _wrapChips()),
                ))),
            SizedBox(width: 330.0, child: _wrapDemoFrame('WrapAlignment.spaceBetween',
                'Equal gaps between children, none at the edges.',
                Container(
                  color: _kCardBg,
                  child: Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    spacing: 6.0, runSpacing: 6.0, children: _wrapChips()),
                ))),
            SizedBox(width: 330.0, child: _wrapDemoFrame('WrapAlignment.spaceAround',
                'Half-gap leading/trailing, full gap between children.',
                Container(
                  color: _kCardBg,
                  child: Wrap(
                    alignment: WrapAlignment.spaceAround,
                    spacing: 6.0, runSpacing: 6.0, children: _wrapChips()),
                ))),
            SizedBox(width: 330.0, child: _wrapDemoFrame('WrapAlignment.spaceEvenly',
                'Equal gaps including leading/trailing.',
                Container(
                  color: _kCardBg,
                  child: Wrap(
                    alignment: WrapAlignment.spaceEvenly,
                    spacing: 6.0, runSpacing: 6.0, children: _wrapChips()),
                ))),
          ],
        ),
      ],
    ),
  );
}

Widget _wrapCrossAlignmentCard() {
  // Same chips, but varying sizes so cross-axis alignment is visible.
  List<Widget> sizedChips() {
    final List<Widget> out = <Widget>[];
    final List<double> sizes = <double>[10.0, 14.0, 8.0, 18.0, 12.0, 22.0, 9.0, 16.0];
    for (int i = 0; i < sizes.length; i++) {
      out.add(_wrapChip('chip $i',
          colour: i.isEven ? _kAccent : _kAccentBlue, pad: sizes[i]));
    }
    return out;
  }

  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle('WrapCrossAlignment - three options',
            subtitle:
                'crossAxisAlignment positions children of varying sizes within a '
                'single run on the cross axis.'),
        const SizedBox(height: 12.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: _wrapDemoFrame('start',
                'Top edges line up.',
                Container(
                  color: _kCardBg,
                  alignment: Alignment.topLeft,
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.start,
                    spacing: 6.0, runSpacing: 6.0, children: sizedChips()),
                ),
                height: 120.0)),
            const SizedBox(width: 10.0),
            Expanded(child: _wrapDemoFrame('center',
                'Children centered on the run\'s mid-line.',
                Container(
                  color: _kCardBg,
                  alignment: Alignment.topLeft,
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 6.0, runSpacing: 6.0, children: sizedChips()),
                ),
                height: 120.0)),
            const SizedBox(width: 10.0),
            Expanded(child: _wrapDemoFrame('end',
                'Bottom edges line up.',
                Container(
                  color: _kCardBg,
                  alignment: Alignment.topLeft,
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.end,
                    spacing: 6.0, runSpacing: 6.0, children: sizedChips()),
                ),
                height: 120.0)),
          ],
        ),
      ],
    ),
  );
}

Widget _wrapDirectionCard() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle('direction & runAlignment',
            subtitle:
                'Wrap flows along its main axis. Set direction: Axis.vertical to '
                'flow downward and break columns instead of rows.'),
        const SizedBox(height: 12.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: _wrapDemoFrame('direction: Axis.horizontal',
                'Children flow left -> right, runs stack down.',
                Container(
                  color: _kCardBg,
                  alignment: Alignment.topLeft,
                  child: Wrap(
                    direction: Axis.horizontal,
                    spacing: 6.0, runSpacing: 6.0, children: _wrapChips()),
                ))),
            const SizedBox(width: 10.0),
            Expanded(child: _wrapDemoFrame('direction: Axis.vertical',
                'Children flow top -> bottom, runs stack right.',
                Container(
                  color: _kCardBg,
                  alignment: Alignment.topLeft,
                  child: Wrap(
                    direction: Axis.vertical,
                    spacing: 6.0, runSpacing: 6.0, children: _wrapChips()),
                ),
                height: 200.0)),
          ],
        ),
        const SizedBox(height: 10.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: _wrapDemoFrame('runAlignment.start',
                'Runs hug the cross-axis start.',
                Container(
                  color: _kCardBg,
                  alignment: Alignment.topLeft,
                  child: Wrap(
                    runAlignment: WrapAlignment.start,
                    spacing: 6.0, runSpacing: 6.0, children: _wrapChips()),
                ),
                height: 180.0)),
            const SizedBox(width: 10.0),
            Expanded(child: _wrapDemoFrame('runAlignment.spaceBetween',
                'Runs pushed apart with equal gaps.',
                Container(
                  color: _kCardBg,
                  alignment: Alignment.topLeft,
                  child: Wrap(
                    runAlignment: WrapAlignment.spaceBetween,
                    spacing: 6.0, runSpacing: 6.0, children: _wrapChips()),
                ),
                height: 180.0)),
            const SizedBox(width: 10.0),
            Expanded(child: _wrapDemoFrame('runAlignment.end',
                'Runs hug the cross-axis end.',
                Container(
                  color: _kCardBg,
                  alignment: Alignment.topLeft,
                  child: Wrap(
                    runAlignment: WrapAlignment.end,
                    spacing: 6.0, runSpacing: 6.0, children: _wrapChips()),
                ),
                height: 180.0)),
          ],
        ),
      ],
    ),
  );
}

Widget _wrapSpacingMatrixCard() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle('spacing vs runSpacing',
            subtitle:
                '`spacing` is the gap between children inside a run. `runSpacing` '
                'is the gap between runs on the cross axis.'),
        const SizedBox(height: 12.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: _wrapDemoFrame('spacing: 4 / runSpacing: 4',
                'Tight grid.',
                Container(
                  color: _kCardBg,
                  alignment: Alignment.topLeft,
                  child: Wrap(spacing: 4.0, runSpacing: 4.0, children: _wrapChips()),
                ))),
            const SizedBox(width: 10.0),
            Expanded(child: _wrapDemoFrame('spacing: 16 / runSpacing: 4',
                'Wide horizontal gaps.',
                Container(
                  color: _kCardBg,
                  alignment: Alignment.topLeft,
                  child: Wrap(spacing: 16.0, runSpacing: 4.0, children: _wrapChips()),
                ))),
            const SizedBox(width: 10.0),
            Expanded(child: _wrapDemoFrame('spacing: 4 / runSpacing: 18',
                'Wide vertical gaps.',
                Container(
                  color: _kCardBg,
                  alignment: Alignment.topLeft,
                  child: Wrap(spacing: 4.0, runSpacing: 18.0, children: _wrapChips()),
                ),
                height: 200.0)),
          ],
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 5 - FLOW DEEP-DIVE
// ---------------------------------------------------------------------------
class _FlowConceptPainter extends CustomPainter {
  _FlowConceptPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = _kCardSoft;
    canvas.drawRRect(
        RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(10.0)), bg);

    // Frame
    final Paint frame = Paint()
      ..color = _kAccentBlue.withOpacity(0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;
    final Rect frameRect = Rect.fromLTWH(20.0, 20.0, size.width - 40.0, size.height - 40.0);
    canvas.drawRRect(
        RRect.fromRectAndRadius(frameRect, const Radius.circular(8.0)), frame);

    // Label
    final TextPainter labelTp = TextPainter(
      text: const TextSpan(
          text: 'FlowDelegate canvas (getSize -> ${'\$constraints'})',
          style: TextStyle(
              fontSize: 11.5,
              color: _kAccentBlue,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w700)),
      textDirection: TextDirection.ltr,
    )..layout();
    labelTp.paint(canvas, Offset(28.0, 6.0));

    // Six child boxes painted at delegate-chosen offsets to mimic paintChildren.
    const List<Offset> centres = <Offset>[
      Offset(0.18, 0.30),
      Offset(0.36, 0.55),
      Offset(0.50, 0.30),
      Offset(0.65, 0.60),
      Offset(0.80, 0.35),
      Offset(0.22, 0.75),
    ];
    final List<Color> palette = <Color>[
      _kAccent,
      _kAccentBlue,
      _kAccentGreen,
      _kAccentAmber,
      _kAccentRose,
      _kAccentViolet,
    ];

    for (int i = 0; i < centres.length; i++) {
      final Offset c = centres[i];
      final double cx = frameRect.left + c.dx * frameRect.width;
      final double cy = frameRect.top + c.dy * frameRect.height;
      final double sz = 44.0 + (i % 3) * 6.0;
      final Rect r = Rect.fromCenter(center: Offset(cx, cy), width: sz, height: sz);
      final Color col = palette[i];
      canvas.drawRRect(
          RRect.fromRectAndRadius(r, const Radius.circular(6.0)),
          Paint()..color = col.withOpacity(0.16));
      canvas.drawRRect(
          RRect.fromRectAndRadius(r, const Radius.circular(6.0)),
          Paint()
            ..color = col.withOpacity(0.7)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.4);
      final TextPainter tp = TextPainter(
        text: TextSpan(
            text: 'child[$i]',
            style: TextStyle(
                fontSize: 10.5,
                color: col,
                fontWeight: FontWeight.w700,
                fontFamily: 'monospace')),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas,
          Offset(r.center.dx - tp.width / 2.0, r.center.dy - tp.height / 2.0));

      // Arrow from frame origin to centre to suggest a transform.
      final Paint arrow = Paint()
        ..color = col.withOpacity(0.5)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0;
      canvas.drawLine(Offset(frameRect.left + 8.0, frameRect.top + 8.0),
          Offset(r.left, r.top), arrow);
    }

    // Right-side legend bullets.
    final List<String> legend = <String>[
      'paintChildren(ctx)',
      'context.paintChild(i, transform: …)',
      'getSize(constraints) -> Size',
      'getConstraintsForChild(i, c)',
      'shouldRepaint(old)',
      'shouldRelayout(old)',
    ];
    double y = frameRect.bottom + 8.0;
    for (int i = 0; i < legend.length; i++) {
      // place at bottom of card if there's room; otherwise leave alone
      final TextPainter tp = TextPainter(
        text: TextSpan(
            text: legend[i],
            style: const TextStyle(
                fontSize: 11.0,
                color: _kInkSecondary,
                fontFamily: 'monospace')),
        textDirection: TextDirection.ltr,
      )..layout();
      if (y + tp.height > size.height - 4.0) break;
      tp.paint(canvas, Offset(28.0 + (i % 2) * 220.0, y));
      if (i.isOdd) y += tp.height + 2.0;
    }
  }

  @override
  bool shouldRepaint(covariant _FlowConceptPainter oldDelegate) => false;
}

class _StaticFlowDelegate extends FlowDelegate {
  const _StaticFlowDelegate({Listenable? repaint = _kRepaintNever})
      : super(repaint: repaint);

  @override
  Size getSize(BoxConstraints constraints) {
    return Size(constraints.maxWidth, 160.0);
  }

  @override
  BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) {
    return BoxConstraints.tight(const Size(54.0, 54.0));
  }

  @override
  void paintChildren(FlowPaintingContext context) {
    final double w = context.size.width;
    final double h = context.size.height;
    final int n = context.childCount;
    if (n == 0) return;
    final double radius = math.min(w, h) * 0.32;
    final Offset c = Offset(w * 0.5, h * 0.5);
    for (int i = 0; i < n; i++) {
      final double t = i / n;
      final double angle = t * 2.0 * math.pi;
      final double dx = c.dx + radius * math.cos(angle) - 27.0;
      final double dy = c.dy + radius * math.sin(angle) - 27.0;
      context.paintChild(i, transform: Matrix4.translationValues(dx, dy, 0.0));
    }
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) => false;
  @override
  bool shouldRelayout(covariant FlowDelegate oldDelegate) => false;
}

class _GridFlowDelegate extends FlowDelegate {
  const _GridFlowDelegate({Listenable? repaint = _kRepaintNever, this.cols = 5})
      : super(repaint: repaint);

  final int cols;

  @override
  Size getSize(BoxConstraints constraints) =>
      Size(constraints.maxWidth, 160.0);
  @override
  BoxConstraints getConstraintsForChild(int i, BoxConstraints c) =>
      BoxConstraints.tight(const Size(54.0, 54.0));
  @override
  void paintChildren(FlowPaintingContext context) {
    final double cellW = context.size.width / cols;
    const double cellH = 60.0;
    for (int i = 0; i < context.childCount; i++) {
      final int row = i ~/ cols;
      final int col = i % cols;
      final double dx = col * cellW + (cellW - 54.0) / 2.0;
      final double dy = row * cellH + 4.0;
      context.paintChild(i, transform: Matrix4.translationValues(dx, dy, 0.0));
    }
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) => false;
  @override
  bool shouldRelayout(covariant FlowDelegate oldDelegate) => false;
}

Widget _flowChild(int i, Color col) {
  return Container(
    decoration: BoxDecoration(
      color: col.withOpacity(0.15),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: col.withOpacity(0.55), width: 1.2),
    ),
    alignment: Alignment.center,
    child: Text('$i',
        style: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.w700, color: col)),
  );
}

List<Widget> _flowChildren(int n) {
  final List<Color> palette = <Color>[
    _kAccent, _kAccentBlue, _kAccentGreen,
    _kAccentAmber, _kAccentRose, _kAccentViolet, _kAccentCyan
  ];
  final List<Widget> out = <Widget>[];
  for (int i = 0; i < n; i++) {
    out.add(_flowChild(i, palette[i % palette.length]));
  }
  return out;
}

Widget _flowSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _cardTitle('FlowDelegate concept diagram',
                subtitle:
                    'Each child is painted by paintChild(i, transform: ...). '
                    'The delegate owns layout and paint; the framework just '
                    'feeds it a FlowPaintingContext.'),
            const SizedBox(height: 12.0),
            SizedBox(
              height: 240.0,
              child: CustomPaint(
                painter: _FlowConceptPainter(),
                size: const Size(double.infinity, 240.0),
              ),
            ),
          ],
        ),
      ),
      _card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _cardTitle('Real Flow: circular layout',
                subtitle:
                    'Static FlowDelegate places eight children on a circle. '
                    'No animation, no AnimationController - paintChildren is '
                    'driven by constant geometry.'),
            const SizedBox(height: 10.0),
            SizedBox(
              height: 170.0,
              child: Flow(
                delegate: const _StaticFlowDelegate(),
                children: _flowChildren(8),
              ),
            ),
          ],
        ),
      ),
      _card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _cardTitle('Real Flow: grid via delegate',
                subtitle:
                    'Same Flow widget, different FlowDelegate - shows that the '
                    'layout policy lives entirely in the delegate.'),
            const SizedBox(height: 10.0),
            SizedBox(
              height: 170.0,
              child: Flow(
                delegate: const _GridFlowDelegate(cols: 6),
                children: _flowChildren(12),
              ),
            ),
          ],
        ),
      ),
      _card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _cardTitle('FlowDelegate API summary'),
            const SizedBox(height: 8.0),
            _kvRow('getSize', '(constraints) -> Size'),
            _kvRow('getConstraintsForChild', '(i, parentConstraints) -> BoxConstraints'),
            _kvRow('paintChildren', '(FlowPaintingContext) -> void'),
            _kvRow('shouldRepaint', '(covariant FlowDelegate old) -> bool'),
            _kvRow('shouldRelayout', '(covariant FlowDelegate old) -> bool'),
            _kvRow('repaint Listenable', 'optional - drives shouldRepaint without rebuilding'),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// SECTION 6 - COMPARISON MATRIX
// ---------------------------------------------------------------------------
Widget _comparisonSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _comparisonHeaderRow(),
      _comparisonMatrixCard(),
      _tableVsDataTableCard(),
      _wrapVsRowFlowCard(),
    ],
  );
}

Widget _comparisonHeaderRow() {
  return _card(
    background: _kCardDark,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle('When to reach for which',
            titleColor: _kInkOnDark,
            subtitleColor: _kInkOnDarkSecondary,
            subtitle:
                'Five layout-of-many widgets compared across the axes that '
                'matter at design time.'),
        const SizedBox(height: 10.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 6.0,
          children: <Widget>[
            _pill('Table', colour: const Color(0xFFFDE68A)),
            _pill('Wrap', colour: const Color(0xFFBBF7D0)),
            _pill('Flow', colour: const Color(0xFFBAE6FD)),
            _pill('Row/Column', colour: const Color(0xFFFBCFE8)),
            _pill('GridView', colour: const Color(0xFFE9D5FF)),
          ],
        ),
      ],
    ),
  );
}

Widget _comparisonMatrixCard() {
  TableRow header(List<String> labels) {
    return TableRow(
      decoration: const BoxDecoration(color: _kCellTint),
      children: <Widget>[
        for (int i = 0; i < labels.length; i++)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
            child: Text(labels[i],
                style: TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w700,
                    color: i == 0 ? _kInkSecondary : _kAccent)),
          ),
      ],
    );
  }

  TableRow row(List<String> cells) {
    return TableRow(
      children: <Widget>[
        for (int i = 0; i < cells.length; i++)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
            child: Text(cells[i],
                style: TextStyle(
                    fontSize: 11.5,
                    color: i == 0 ? _kInkSecondary : _kInk,
                    fontWeight: i == 0 ? FontWeight.w600 : FontWeight.w400,
                    fontFamily: i == 0 ? 'monospace' : null,
                    height: 1.35)),
          ),
      ],
    );
  }

  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle('Layout-of-many comparison matrix'),
        const SizedBox(height: 10.0),
        Table(
          border: TableBorder.all(color: _kGridLine, width: 1.0),
          columnWidths: const <int, TableColumnWidth>{
            0: FixedColumnWidth(160.0),
            1: FlexColumnWidth(1.0),
            2: FlexColumnWidth(1.0),
            3: FlexColumnWidth(1.0),
            4: FlexColumnWidth(1.0),
            5: FlexColumnWidth(1.0),
          },
          children: <TableRow>[
            header(<String>['axis', 'Table', 'Wrap', 'Flow', 'Row/Col', 'GridView']),
            row(<String>['shape', 'rigid grid', 'wrapped row/col', 'free-form', 'single line', 'scrolling grid']),
            row(<String>['column sizing', 'TableColumnWidth', 'driven by chip size', 'delegate', 'flex / intrinsic', 'SliverGridDelegate']),
            row(<String>['shared column model', 'yes', 'no', 'no', 'n/a', 'yes (delegate)']),
            row(<String>['scrolls', 'no', 'no', 'no', 'no', 'yes (slivers)']),
            row(<String>['lazy children', 'no', 'no', 'no', 'no', 'yes (builder)']),
            row(<String>['custom paint', 'no', 'no', 'YES via delegate', 'no', 'no']),
            row(<String>['supports transforms', 'no', 'no', 'YES (Matrix4)', 'no', 'no']),
            row(<String>['handles overflow', 'shrink-wraps', 'wraps to new run', 'delegate decides', 'asserts', 'scrolls']),
            row(<String>['vertical alignment per cell', 'TableCell', 'crossAxisAlignment', 'delegate', 'crossAxisAlignment', 'cell-level']),
            row(<String>['repaint trigger', 'rebuild', 'rebuild', 'Listenable!', 'rebuild', 'scroll/rebuild']),
            row(<String>['typical use', 'invoice grids', 'tag/chip clouds', 'menus, arcs', 'toolbars, rows', 'galleries, lists']),
          ],
        ),
      ],
    ),
  );
}

Widget _tableVsDataTableCard() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle('Table vs DataTable',
            subtitle:
                'Both render rows-of-cells but live on different layers of the '
                'framework and answer different questions.'),
        const SizedBox(height: 10.0),
        Table(
          border: TableBorder.all(color: _kGridLine, width: 1.0),
          columnWidths: const <int, TableColumnWidth>{
            0: FixedColumnWidth(170.0),
            1: FlexColumnWidth(1.0),
            2: FlexColumnWidth(1.0),
          },
          children: <TableRow>[
            TableRow(
              decoration: const BoxDecoration(color: _kCellTint),
              children: <Widget>[
                _tableHeaderCell('aspect', _kAccent),
                _tableHeaderCell('Table (widgets)', _kAccent),
                _tableHeaderCell('DataTable (material)', _kAccent),
              ],
            ),
            _comparisonRow('package', 'flutter/widgets.dart', 'flutter/material.dart'),
            _comparisonRow('layer', 'rendering, no styling', 'Material visuals, theming'),
            _comparisonRow('column type', 'List<TableRow>', 'List<DataColumn> + List<DataRow>'),
            _comparisonRow('sortable', 'manual', 'built-in via onSort'),
            _comparisonRow('selectable rows', 'manual', 'built-in via selected'),
            _comparisonRow('cell sizing', 'TableColumnWidth', 'computed automatically'),
            _comparisonRow('headings', 'just another TableRow', 'separate DataColumn list'),
            _comparisonRow('row decoration', 'TableRow.decoration', 'theme + selected'),
            _comparisonRow('scrolling', 'wrap in SingleChildScrollView', 'wrap in SingleChildScrollView'),
            _comparisonRow('best for', 'forms, label/value grids', 'tabular data with sort + select'),
          ],
        ),
      ],
    ),
  );
}

TableRow _comparisonRow(String a, String b, String c) {
  return TableRow(children: <Widget>[
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 6.0),
      child: Text(a,
          style: const TextStyle(
              fontSize: 11.5,
              fontFamily: 'monospace',
              color: _kInkSecondary,
              fontWeight: FontWeight.w600)),
    ),
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 6.0),
      child: Text(b,
          style: const TextStyle(fontSize: 11.5, color: _kInk, height: 1.35)),
    ),
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 6.0),
      child: Text(c,
          style: const TextStyle(fontSize: 11.5, color: _kInk, height: 1.35)),
    ),
  ]);
}

Widget _wrapVsRowFlowCard() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle('Wrap vs Row+Flow',
            subtitle:
                'A common question - "isn\'t Row with a Flow wrapper the same?" '
                'Short answer: no. They have different overflow semantics and '
                'different layout passes.'),
        const SizedBox(height: 10.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: _wrapVsRowFlowCell(
                'Wrap',
                'Single layout pass per run. Chooses run break inline using '
                '`spacing` and child sizes. Cannot transform children.',
                _kAccentGreen)),
            const SizedBox(width: 10.0),
            Expanded(child: _wrapVsRowFlowCell(
                'Row',
                'Single line. Throws on overflow unless wrapped in Flexible / '
                'Expanded. No run break logic at all.',
                _kAccentRose)),
            const SizedBox(width: 10.0),
            Expanded(child: _wrapVsRowFlowCell(
                'Flow',
                'Delegate paints children at arbitrary transforms. You decide '
                'when to break to a new row - paintChildren is your loop.',
                _kAccentBlue)),
          ],
        ),
      ],
    ),
  );
}

Widget _wrapVsRowFlowCell(String title, String body, Color accent) {
  return Container(
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: accent.withOpacity(0.06),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: accent.withOpacity(0.4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(title,
            style: TextStyle(
                fontSize: 14.0, fontWeight: FontWeight.w800, color: accent)),
        const SizedBox(height: 4.0),
        Text(body,
            style:
                const TextStyle(fontSize: 12.0, color: _kInkSecondary, height: 1.35)),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 7 - RECIPE CODE CARDS
// ---------------------------------------------------------------------------
Widget _recipesSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _codeBlock(
        title: 'recipe 1 - label/value form via Table',
        '// Two-column table: fixed label column, flexible value column.\n'
        'Table(\n'
        '  columnWidths: const <int, TableColumnWidth>{\n'
        '    0: IntrinsicColumnWidth(),\n'
        '    1: FlexColumnWidth(1),\n'
        '  },\n'
        '  defaultVerticalAlignment: TableCellVerticalAlignment.middle,\n'
        '  children: <TableRow>[\n'
        '    TableRow(children: <Widget>[Text("name"), TextField()]),\n'
        '    TableRow(children: <Widget>[Text("email"), TextField()]),\n'
        '  ],\n'
        ');',
      ),
      _codeBlock(
        title: 'recipe 2 - chip cloud via Wrap',
        '// Tags wrap to a new line automatically.\n'
        'Wrap(\n'
        '  spacing: 8,\n'
        '  runSpacing: 8,\n'
        '  alignment: WrapAlignment.start,\n'
        '  crossAxisAlignment: WrapCrossAlignment.center,\n'
        '  children: tags.map((String t) => Chip(label: Text(t))).toList(),\n'
        ');',
      ),
      _codeBlock(
        title: 'recipe 3 - radial menu via Flow',
        '// Children orbit a center point via a custom FlowDelegate.\n'
        'class RadialFlowDelegate extends FlowDelegate {\n'
        '  RadialFlowDelegate(this.radius, this.t);\n'
        '  final double radius;\n'
        '  final double t; // 0..1 progress\n'
        '  @override\n'
        '  void paintChildren(FlowPaintingContext context) {\n'
        '    for (int i = 0; i < context.childCount; i++) {\n'
        '      final double a = i / context.childCount * 6.28;\n'
        '      context.paintChild(i,\n'
        '        transform: Matrix4.translationValues(\n'
        '          radius * t * math.cos(a),\n'
        '          radius * t * math.sin(a),\n'
        '          0,\n'
        '        ),\n'
        '      );\n'
        '    }\n'
        '  }\n'
        '  @override\n'
        '  bool shouldRepaint(_) => true;\n'
        '}',
      ),
      _codeBlock(
        title: 'recipe 4 - sticky header table',
        '// Use a Column with a fixed header Table and a scrollable body Table.\n'
        '// Both share the same columnWidths map so columns stay aligned.\n'
        'final Map<int, TableColumnWidth> widths = const <int, TableColumnWidth>{\n'
        '  0: FixedColumnWidth(60),\n'
        '  1: FlexColumnWidth(2),\n'
        '  2: FlexColumnWidth(1),\n'
        '};\n'
        'Column(children: <Widget>[\n'
        '  Table(columnWidths: widths, children: <TableRow>[headerRow]),\n'
        '  Expanded(child: SingleChildScrollView(\n'
        '    child: Table(columnWidths: widths, children: bodyRows),\n'
        '  )),\n'
        ']);',
      ),
      _codeBlock(
        title: 'recipe 5 - mixed alignment cells in a row',
        '// Per-cell TableCellVerticalAlignment overrides the Table default.\n'
        'TableRow(children: <Widget>[\n'
        '  TableCell(\n'
        '    verticalAlignment: TableCellVerticalAlignment.top,\n'
        '    child: Text("title"),\n'
        '  ),\n'
        '  TableCell(\n'
        '    verticalAlignment: TableCellVerticalAlignment.fill,\n'
        '    child: ColoredBox(color: Colors.amber),\n'
        '  ),\n'
        ']);',
      ),
      _codeBlock(
        title: 'recipe 6 - vertical Wrap as a tag column',
        '// Direction Axis.vertical wraps top->bottom, runs go right.\n'
        'Wrap(\n'
        '  direction: Axis.vertical,\n'
        '  runAlignment: WrapAlignment.start,\n'
        '  spacing: 4,\n'
        '  runSpacing: 12,\n'
        '  children: <Widget>[ /* short labels */ ],\n'
        ');',
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// SECTION 8 - PITFALLS PANEL
// ---------------------------------------------------------------------------
Widget _pitfallsSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _card(
        background: const Color(0xFFFEF7E6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _cardTitle('Six callouts that bite'),
            const SizedBox(height: 8.0),
            _pitfallRow('Table rows must agree on column count',
                'Every TableRow must contain exactly the same number of children. '
                'Otherwise the framework throws at build time.'),
            _pitfallRow('IntrinsicColumnWidth is O(rows * cols)',
                'It asks every child for its intrinsic width on every layout. '
                'For large tables prefer FixedColumnWidth or FlexColumnWidth.'),
            _pitfallRow('Wrap is not a scroll view',
                'When the cross-axis exceeds the available size, Wrap just overflows. '
                'Wrap it in SingleChildScrollView if you expect overflow.'),
            _pitfallRow('Flow does not clip by default',
                'Set clipBehavior: Clip.hardEdge if your delegate paints outside '
                'the parent\'s box, otherwise children may appear over neighbours.'),
            _pitfallRow('FlowDelegate.shouldRepaint vs repaint Listenable',
                'If you need animation, pass an Animation as `repaint`. Returning '
                'true from shouldRepaint without one will still need a rebuild.'),
            _pitfallRow('Table.defaultColumnWidth still applies',
                'Columns not listed in columnWidths fall back to defaultColumnWidth '
                '(default FlexColumnWidth(1)), not zero.'),
          ],
        ),
      ),
    ],
  );
}

Widget _pitfallRow(String title, String body) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 22.0,
          height: 22.0,
          margin: const EdgeInsets.only(right: 10.0, top: 2.0),
          alignment: Alignment.center,
          decoration: const BoxDecoration(
              color: _kAccentAmber, shape: BoxShape.circle),
          child: const Text('!',
              style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 13.0,
                  fontWeight: FontWeight.w800)),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title,
                  style: const TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w700,
                      color: _kInk)),
              const SizedBox(height: 2.0),
              Text(body,
                  style: const TextStyle(
                      fontSize: 12.0,
                      color: _kInkSecondary,
                      height: 1.4)),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 9 - CHEAT-SHEET FOOTER
// ---------------------------------------------------------------------------
Widget _cheatSheetFooter() {
  return _card(
    background: _kCardDark,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle('Cheat-sheet',
            titleColor: _kInkOnDark,
            subtitleColor: _kInkOnDarkSecondary,
            subtitle:
                'A compact map of the Table / Wrap / Flow surface area.'),
        const SizedBox(height: 12.0),
        _cheatGroup('Table',
            const <String>[
              'children: List<TableRow>',
              'columnWidths: Map<int, TableColumnWidth>',
              'defaultColumnWidth',
              'defaultVerticalAlignment',
              'border: TableBorder',
              'textBaseline',
            ],
            const Color(0xFFFDE68A)),
        _cheatGroup('TableColumnWidth',
            const <String>[
              'FixedColumnWidth(value)',
              'FlexColumnWidth(value)',
              'IntrinsicColumnWidth({flex})',
              'MaxColumnWidth(a, b)',
              'MinColumnWidth(a, b)',
              'FractionColumnWidth(value)',
            ],
            const Color(0xFFFCA5A5)),
        _cheatGroup('Wrap',
            const <String>[
              'direction: Axis',
              'alignment: WrapAlignment',
              'spacing',
              'runSpacing',
              'runAlignment',
              'crossAxisAlignment',
              'textDirection',
              'verticalDirection',
              'clipBehavior',
            ],
            const Color(0xFFBBF7D0)),
        _cheatGroup('Flow / FlowDelegate',
            const <String>[
              'delegate: FlowDelegate',
              'repaint: Listenable?',
              'paintChildren',
              'getSize',
              'getConstraintsForChild',
              'shouldRepaint',
              'shouldRelayout',
              'FlowPaintingContext.paintChild',
            ],
            const Color(0xFFBAE6FD)),
        _cheatGroup('TableCellVerticalAlignment',
            const <String>[
              'top',
              'middle',
              'bottom',
              'baseline',
              'fill',
              'intrinsicHeight',
            ],
            const Color(0xFFE9D5FF)),
      ],
    ),
  );
}

Widget _cheatGroup(String title, List<String> items, Color accent) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(title,
            style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w800,
                color: accent,
                letterSpacing: 0.3)),
        const SizedBox(height: 6.0),
        Wrap(
          spacing: 6.0,
          runSpacing: 6.0,
          children: <Widget>[
            for (int i = 0; i < items.length; i++)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                decoration: BoxDecoration(
                  color: const Color(0x22FFFFFF),
                  borderRadius: BorderRadius.circular(6.0),
                  border: Border.all(color: accent.withOpacity(0.6)),
                ),
                child: Text(items[i],
                    style: const TextStyle(
                        fontSize: 11.0,
                        color: _kInkOnDark,
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.w600)),
              ),
          ],
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// TOP-LEVEL BUILD ENTRY
// ---------------------------------------------------------------------------
dynamic build(BuildContext context) {
  print('Table/Wrap/Flow deep visual demo: building widget tree');

  // Construct a handful of TableColumnWidth instances just to log their
  // runtimeType. They are also used downstream in _tableDiagnosticsCard.
  const FixedColumnWidth fixedW = FixedColumnWidth(80.0);
  const FlexColumnWidth flexW = FlexColumnWidth(2.0);
  const IntrinsicColumnWidth intrinsicW = IntrinsicColumnWidth();
  const MaxColumnWidth maxW =
      MaxColumnWidth(IntrinsicColumnWidth(), FixedColumnWidth(60.0));
  const MinColumnWidth minW =
      MinColumnWidth(FlexColumnWidth(1.0), FixedColumnWidth(60.0));
  const FractionColumnWidth fracW = FractionColumnWidth(0.25);
  print('FixedColumnWidth=${fixedW.runtimeType}');
  print('FlexColumnWidth=${flexW.runtimeType}');
  print('IntrinsicColumnWidth=${intrinsicW.runtimeType}');
  print('MaxColumnWidth=${maxW.runtimeType}');
  print('MinColumnWidth=${minW.runtimeType}');
  print('FractionColumnWidth=${fracW.runtimeType}');
  print('TableCellVerticalAlignment.top=${TableCellVerticalAlignment.top}');
  print('WrapAlignment.spaceEvenly=${WrapAlignment.spaceEvenly}');
  print('WrapCrossAlignment.center=${WrapCrossAlignment.center}');
  print('Axis.horizontal=${Axis.horizontal}');
  print('kDebugMode=$kDebugMode');

  return Container(
    color: _kCanvas,
    child: SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Section 1
          _heroBanner(),
          _sectionHeader(1, 'The layout-of-many triad',
              'Three RenderObjectWidgets that go beyond Row/Column/Stack.'),
          _heroIntroCard(),
          _sectionDivider(),

          // Section 2
          _sectionHeader(2, 'Class hierarchy',
              'Widget, RenderBox and configuration types side-by-side.'),
          _hierarchySection(),
          _sectionDivider(),

          // Section 3
          _sectionHeader(3, 'Table deep-dive',
              'Rows, cells, column-width strategies, borders, alignments.'),
          _tableSection(),
          _sectionDivider(),

          // Section 4
          _sectionHeader(4, 'Wrap deep-dive',
              'alignment, runAlignment, crossAxisAlignment, direction, spacing.'),
          _wrapSection(),
          _sectionDivider(),

          // Section 5
          _sectionHeader(5, 'Flow deep-dive',
              'FlowDelegate, paintChildren, getSize, FlowPaintingContext.'),
          _flowSection(),
          _sectionDivider(),

          // Section 6
          _sectionHeader(6, 'Comparison matrix',
              'Table vs DataTable, Wrap vs Row/Flow, vs Row/Column/GridView.'),
          _comparisonSection(),
          _sectionDivider(),

          // Section 7
          _sectionHeader(7, 'Recipe code cards',
              'Six idiomatic snippets to keep handy.'),
          _recipesSection(),
          _sectionDivider(),

          // Section 8
          _sectionHeader(8, 'Pitfalls',
              'Six callouts that commonly bite layout engineers.'),
          _pitfallsSection(),
          _sectionDivider(),

          // Section 9
          _sectionHeader(9, 'Cheat-sheet',
              'Compact map of the Table/Wrap/Flow surface area.'),
          _cheatSheetFooter(),
        ],
      ),
    ),
  );
}
