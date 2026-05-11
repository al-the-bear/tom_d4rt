// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unused_element, unused_element_parameter, unused_field, unnecessary_import
//
// =====================================================================
// TapDragStartDetails — Deep Visual Demo (Glacier / Aurora Edition)
// =====================================================================
//
// `TapDragStartDetails` is the payload delivered to the
//   `GestureTapDragStartCallback` typedef
// as the `onDragStart` argument of `BaseTapAndDragGestureRecognizer`
// (and its concrete subclasses — `TapAndPanGestureRecognizer`,
// `TapAndHorizontalDragGestureRecognizer`). It is fired the instant
// a *tap-then-drag* sequence has tipped from "pointer is still down"
// into "the drag has officially begun" — i.e. the slop threshold has
// been exceeded and the recognizer has committed to drag mode while
// remembering that one or more taps preceded it.
//
// Why does this exist as its own type instead of reusing
// `DragStartDetails`?  Because the tap-drag combo cares about how
// many taps in a row preceded *this* drag start. That value lives
// on `consecutiveTapCount` and is what allows text editors to
// implement single-tap word drag, double-tap paragraph drag, triple-
// tap line drag, and so on. The number resets when the inter-tap
// timeout elapses or the user moves too far between taps.
//
// Fields reviewed in this demo:
//   * sourceTimeStamp     : Duration?          — engine event time
//   * globalPosition      : Offset             — screen-frame coords
//   * localPosition       : Offset             — local-box coords
//   * kind                : PointerDeviceKind? — touch/mouse/stylus/…
//   * consecutiveTapCount : int                — 1=solo, 2=double, …
//
// Note on key modifiers: `TapDragStartDetails` itself does not carry
// a `keysPressedOnDown` field — modifier state is queried via
// `HardwareKeyboard.instance.logicalKeysPressed` at the moment the
// callback fires. This demo simulates that pattern by capturing the
// active modifier set in a parallel record next to each constructed
// details object so callers can study the typical "drag-with-shift",
// "drag-with-ctrl" recipes used by text editors.
//
// Theme: glacier-blue + aurora-green + violet on a deep navy chassis,
// evoking a polar-night control panel. Glacier-blue highlights the
// drag-start moment itself; aurora-green tracks the tap counter;
// violet marks the modifier-key dimension; warm amber accents fall
// on pitfalls and warnings.
// =====================================================================

import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------
// Colour palette — glacier / aurora / navy
// ---------------------------------------------------------------------
const Color kGlacier = Color(0xFF4FA6D1);
const Color kGlacierDeep = Color(0xFF1F5D80);
const Color kGlacierSoft = Color(0xFFA9D4E8);
const Color kAurora = Color(0xFF34C796);
const Color kAuroraDeep = Color(0xFF128566);
const Color kAuroraSoft = Color(0xFFA4E7D1);
const Color kViolet = Color(0xFF8F6CC4);
const Color kVioletDeep = Color(0xFF5C3F8C);
const Color kVioletSoft = Color(0xFFD1BFE9);
const Color kNavy = Color(0xFF101A2E);
const Color kNavySoft = Color(0xFF1B2A47);
const Color kNavyLight = Color(0xFF324563);
const Color kSnow = Color(0xFFF4F7FB);
const Color kSnowDeep = Color(0xFFD9E2EC);
const Color kAmber = Color(0xFFFFB347);
const Color kAmberDeep = Color(0xFFB87A20);
const Color kCoral = Color(0xFFFF6F61);
const Color kSlate = Color(0xFF45556C);
const Color kSlateLight = Color(0xFF8A99B0);
const Color kShadow = Color(0xFF05080F);

// ---------------------------------------------------------------------
// Helper: pretty-print a TapDragStartDetails to the console.
// ---------------------------------------------------------------------
void _dumpDetails(String label, TapDragStartDetails d) {
  print('--- $label ---');
  print('  runtimeType        : ${d.runtimeType}');
  print('  sourceTimeStamp    : ${d.sourceTimeStamp}');
  print('  globalPosition     : ${d.globalPosition}');
  print('  localPosition      : ${d.localPosition}');
  print('  kind               : ${d.kind}');
  print('  consecutiveTapCount: ${d.consecutiveTapCount}');
}

// ---------------------------------------------------------------------
// Helper: format a Duration like `+0:00.480` for compact display.
// ---------------------------------------------------------------------
String _fmtTime(Duration? d) {
  if (d == null) {
    return 'null';
  }
  final int ms = d.inMilliseconds;
  final int s = ms ~/ 1000;
  final int sub = ms.remainder(1000);
  return '+${s.toString().padLeft(1, '0')}.${sub.toString().padLeft(3, '0')}s';
}

// ---------------------------------------------------------------------
// Helper: format an Offset like `(48.0, 64.0)` rounded to one decimal.
// ---------------------------------------------------------------------
String _fmtOffset(Offset o) {
  return '(${o.dx.toStringAsFixed(1)}, ${o.dy.toStringAsFixed(1)})';
}

// ---------------------------------------------------------------------
// Helper: human label for a PointerDeviceKind.
// ---------------------------------------------------------------------
String _kindLabel(PointerDeviceKind? k) {
  if (k == null) {
    return 'null (unspecified)';
  }
  switch (k) {
    case PointerDeviceKind.touch:
      return 'touch (finger)';
    case PointerDeviceKind.mouse:
      return 'mouse';
    case PointerDeviceKind.stylus:
      return 'stylus (pen)';
    case PointerDeviceKind.invertedStylus:
      return 'inverted stylus (eraser)';
    case PointerDeviceKind.trackpad:
      return 'trackpad';
    case PointerDeviceKind.unknown:
      return 'unknown';
  }
}

// ---------------------------------------------------------------------
// Helper: framed card with a title strip and a body widget.
// ---------------------------------------------------------------------
Widget _frame({
  required String title,
  required Widget body,
  Color border = kGlacier,
  Color fill = kSnow,
  Color titleFill = kGlacierDeep,
  Color titleText = kSnow,
}) {
  return Container(
    margin: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: fill,
      border: Border.all(color: border, width: 2),
      borderRadius: BorderRadius.circular(10),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: kShadow,
          blurRadius: 10,
          spreadRadius: 1,
          offset: Offset(2, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: titleFill,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
          ),
          child: Text(
            title,
            style: TextStyle(
              color: titleText,
              fontWeight: FontWeight.bold,
              fontSize: 14,
              letterSpacing: 0.4,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: body,
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------
// Helper: section header (large, italic, with a leading icon).
// ---------------------------------------------------------------------
Widget _sectionHeader(
  String title, {
  IconData icon = Icons.swipe,
  Color color = kGlacierDeep,
  String? subtitle,
}) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(8, 18, 8, 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: color.withAlpha(40),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(icon, color: color, size: 22),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  letterSpacing: 0.3,
                ),
              ),
              if (subtitle != null) ...<Widget>[
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: kSlate,
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------
// Helper: a labelled "chip" used to render one field of a details obj.
// ---------------------------------------------------------------------
Widget _chip(
  String label,
  String value, {
  Color color = kGlacier,
  IconData? icon,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: color.withAlpha(30),
      border: Border.all(color: color, width: 1.2),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (icon != null) ...<Widget>[
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
        ],
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          value,
          style: const TextStyle(
            fontSize: 12,
            color: kNavy,
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------
// Helper: a 2-column properties table.
// ---------------------------------------------------------------------
Widget _propsTable(List<List<String>> rows, {Color accent = kGlacier}) {
  return Container(
    decoration: BoxDecoration(
      color: kSnow,
      border: Border.all(color: accent.withAlpha(140)),
      borderRadius: BorderRadius.circular(6),
    ),
    child: Table(
      columnWidths: const <int, TableColumnWidth>{
        0: IntrinsicColumnWidth(),
        1: FlexColumnWidth(),
      },
      border: TableBorder.symmetric(
        inside: BorderSide(color: accent.withAlpha(60)),
      ),
      children: <TableRow>[
        for (int i = 0; i < rows.length; i++)
          TableRow(
            decoration: BoxDecoration(
              color: i.isEven ? kSnow : kSnowDeep.withAlpha(120),
            ),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                child: Text(
                  rows[i][0],
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: accent,
                    fontSize: 12,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                child: Text(
                  rows[i][1],
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12,
                    color: kNavy,
                  ),
                ),
              ),
            ],
          ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------
// CustomPainter that draws a small canvas with an annotated start point.
// ---------------------------------------------------------------------
class _StartPointPainter extends CustomPainter {
  _StartPointPainter({
    required this.local,
    required this.color,
    required this.consecutiveTapCount,
    required this.kindLabel,
  });

  final Offset local;
  final Color color;
  final int consecutiveTapCount;
  final String kindLabel;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect bounds = Offset.zero & size;
    // Background gradient
    final Paint bg = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[kNavySoft, kNavy],
      ).createShader(bounds);
    canvas.drawRRect(
      RRect.fromRectAndRadius(bounds, const Radius.circular(8)),
      bg,
    );

    // Grid
    final Paint grid = Paint()
      ..color = kNavyLight.withAlpha(120)
      ..strokeWidth = 0.6;
    const double step = 16;
    for (double x = step; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
    }
    for (double y = step; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }

    // Clamp start point inside box
    final Offset clamped = Offset(
      local.dx.clamp(8.0, size.width - 8.0),
      local.dy.clamp(8.0, size.height - 8.0),
    );

    // Crosshair
    final Paint cross = Paint()
      ..color = color.withAlpha(200)
      ..strokeWidth = 1.0;
    canvas.drawLine(
      Offset(0, clamped.dy),
      Offset(size.width, clamped.dy),
      cross,
    );
    canvas.drawLine(
      Offset(clamped.dx, 0),
      Offset(clamped.dx, size.height),
      cross,
    );

    // Outer glow ring (pulse based on tap count)
    for (int i = 0; i < consecutiveTapCount; i++) {
      final Paint ring = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.4
        ..color = color.withAlpha(180 - i * 40);
      canvas.drawCircle(clamped, 10.0 + i * 6.0, ring);
    }

    // Solid dot
    final Paint dot = Paint()..color = color;
    canvas.drawCircle(clamped, 5.0, dot);

    // Direction arrow (hint of imminent drag)
    final Paint arrow = Paint()
      ..color = kAurora
      ..strokeWidth = 1.6
      ..style = PaintingStyle.stroke;
    final Offset tip = clamped + const Offset(28, -10);
    canvas.drawLine(clamped, tip, arrow);
    final Path arrowHead = Path()
      ..moveTo(tip.dx, tip.dy)
      ..lineTo(tip.dx - 5, tip.dy - 1)
      ..lineTo(tip.dx - 3, tip.dy + 4)
      ..close();
    canvas.drawPath(arrowHead, Paint()..color = kAurora);

    // Corner label
    final TextPainter tpKind = TextPainter(
      text: TextSpan(
        text: kindLabel,
        style: TextStyle(
          color: kSnow.withAlpha(200),
          fontSize: 9,
          fontWeight: FontWeight.w600,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tpKind.paint(canvas, const Offset(6, 4));

    // Bottom-right tap counter
    final TextPainter tpCount = TextPainter(
      text: TextSpan(
        text: 'taps=$consecutiveTapCount',
        style: TextStyle(
          color: kAurora.withAlpha(220),
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tpCount.paint(
      canvas,
      Offset(size.width - tpCount.width - 6, size.height - tpCount.height - 6),
    );
  }

  @override
  bool shouldRepaint(covariant _StartPointPainter old) {
    return old.local != local ||
        old.color != color ||
        old.consecutiveTapCount != consecutiveTapCount ||
        old.kindLabel != kindLabel;
  }
}

// ---------------------------------------------------------------------
// Helper: thumbnail with start-point annotation.
// ---------------------------------------------------------------------
Widget _thumbnail(TapDragStartDetails d, Color color, {double size = 120}) {
  return SizedBox(
    width: size,
    height: size,
    child: CustomPaint(
      painter: _StartPointPainter(
        local: d.localPosition,
        color: color,
        consecutiveTapCount: d.consecutiveTapCount,
        kindLabel: _kindLabel(d.kind),
      ),
    ),
  );
}

// ---------------------------------------------------------------------
// Helper: combined card showing thumbnail + properties table.
// ---------------------------------------------------------------------
Widget _detailsCard(
  String label,
  TapDragStartDetails d, {
  required Color accent,
  required IconData icon,
  String? note,
  Set<String> modifiers = const <String>{},
}) {
  _dumpDetails(label, d);
  return _frame(
    title: label,
    border: accent,
    titleFill: accent,
    body: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _thumbnail(d, accent),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(icon, color: accent, size: 18),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      'consecutiveTapCount = ${d.consecutiveTapCount}',
                      style: TextStyle(
                        color: accent,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              _propsTable(
                <List<String>>[
                  <String>['sourceTimeStamp', _fmtTime(d.sourceTimeStamp)],
                  <String>['globalPosition', _fmtOffset(d.globalPosition)],
                  <String>['localPosition', _fmtOffset(d.localPosition)],
                  <String>['kind', _kindLabel(d.kind)],
                  <String>[
                    'consecutiveTapCount',
                    d.consecutiveTapCount.toString(),
                  ],
                ],
                accent: accent,
              ),
              if (modifiers.isNotEmpty) ...<Widget>[
                const SizedBox(height: 8),
                Row(
                  children: <Widget>[
                    Icon(Icons.keyboard, size: 14, color: kViolet),
                    const SizedBox(width: 4),
                    const Text(
                      'modifiers held:',
                      style: TextStyle(
                        fontSize: 11,
                        color: kViolet,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Wrap(
                  spacing: 4,
                  runSpacing: 4,
                  children: <Widget>[
                    for (final String k in modifiers)
                      _chip(
                        'KEY',
                        k,
                        color: kViolet,
                        icon: Icons.keyboard_alt,
                      ),
                  ],
                ),
              ],
              if (note != null) ...<Widget>[
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: accent.withAlpha(25),
                    border: Border.all(color: accent.withAlpha(120)),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    note,
                    style: const TextStyle(
                      fontSize: 11,
                      color: kSlate,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------
// Helper: a banner that displays a short message with leading icon.
// ---------------------------------------------------------------------
Widget _banner(
  String text, {
  Color color = kGlacier,
  IconData icon = Icons.info_outline,
}) {
  return Container(
    margin: const EdgeInsets.all(8),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withAlpha(28),
      border: Border.all(color: color, width: 1.2),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: <Widget>[
        Icon(icon, color: color, size: 18),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: color == kAmber ? kAmberDeep : kNavy,
              fontSize: 12.5,
              fontWeight: FontWeight.w500,
              height: 1.35,
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------
// Helper: a tiny key-cap glyph for the modifier matrix.
// ---------------------------------------------------------------------
Widget _keycap(String label, {Color color = kViolet, bool down = false}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: down ? color : kSnow,
      border: Border.all(color: color, width: 1.3),
      borderRadius: BorderRadius.circular(5),
      boxShadow: down
          ? <BoxShadow>[
              BoxShadow(
                color: color.withAlpha(60),
                blurRadius: 4,
                offset: const Offset(0, 1),
              ),
            ]
          : null,
    ),
    child: Text(
      label,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11,
        fontWeight: FontWeight.bold,
        color: down ? kSnow : color,
      ),
    ),
  );
}

// ---------------------------------------------------------------------
// Helper: a numbered step row.
// ---------------------------------------------------------------------
Widget _step(int n, String title, String body, {Color color = kGlacier}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 26,
          height: 26,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: Text(
            n.toString(),
            style: const TextStyle(
              color: kSnow,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                body,
                style: const TextStyle(
                  color: kNavy,
                  fontSize: 12,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------
// Helper: code snippet block.
// ---------------------------------------------------------------------
Widget _code(String text, {Color color = kGlacierDeep}) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(vertical: 6),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: kNavy,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color, width: 1),
    ),
    child: Text(
      text,
      style: const TextStyle(
        color: kSnow,
        fontFamily: 'monospace',
        fontSize: 11.5,
        height: 1.4,
      ),
    ),
  );
}

// ---------------------------------------------------------------------
// SECTION BUILDERS — each returns a Widget for one major section.
// ---------------------------------------------------------------------

Widget _buildDossier() {
  return _frame(
    title: '1. Dossier — what is TapDragStartDetails?',
    border: kGlacierDeep,
    titleFill: kGlacierDeep,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'TapDragStartDetails is the payload delivered to '
          'GestureTapDragStartCallback (the onDragStart argument of '
          'BaseTapAndDragGestureRecognizer and its subclasses '
          'TapAndPanGestureRecognizer + '
          'TapAndHorizontalDragGestureRecognizer).',
          style: TextStyle(fontSize: 13, height: 1.45, color: kNavy),
        ),
        const SizedBox(height: 10),
        const Text(
          'It is fired at the exact moment a tap-then-drag sequence '
          'transitions from "still in the tap window" to "now a drag" — '
          'i.e. the slop threshold has been exceeded, *and* the '
          'recognizer remembers that one or more taps already preceded '
          'this drag start.',
          style: TextStyle(fontSize: 13, height: 1.45, color: kNavy),
        ),
        const SizedBox(height: 12),
        Wrap(
          children: <Widget>[
            _chip(
              'callback',
              'GestureTapDragStartCallback',
              color: kGlacier,
              icon: Icons.api,
            ),
            _chip(
              'fired by',
              'BaseTapAndDragGestureRecognizer',
              color: kGlacier,
              icon: Icons.gesture,
            ),
            _chip(
              'positioned',
              'PositionedGestureDetails',
              color: kAurora,
              icon: Icons.location_on,
            ),
            _chip(
              'mixin',
              'Diagnosticable',
              color: kViolet,
              icon: Icons.bug_report,
            ),
          ],
        ),
        const SizedBox(height: 12),
        _banner(
          'Compare with DragStartDetails: same positioned info, but '
          'TapDragStartDetails adds consecutiveTapCount so that text '
          'editors can distinguish single-tap drag (selection), '
          'double-tap drag (word extension), triple-tap drag (line '
          'extension), and so on.',
          color: kGlacier,
          icon: Icons.compare_arrows,
        ),
        _banner(
          'When fired: After the recognizer wins the gesture arena AND '
          'a movement greater than the slop has occurred while the '
          'pointer is still down. Never fired for a pure tap.',
          color: kAurora,
          icon: Icons.flash_on,
        ),
        _banner(
          'sourceTimeStamp may be null when the event originates from '
          'an accessibility proxy or other synthetic source — always '
          'guard before subtracting.',
          color: kAmber,
          icon: Icons.warning_amber,
        ),
      ],
    ),
  );
}

Widget _buildAnatomy() {
  // Build a canonical example to anchor the anatomy section.
  final TapDragStartDetails canonical = TapDragStartDetails(
    sourceTimeStamp: const Duration(milliseconds: 480),
    globalPosition: const Offset(180.0, 140.0),
    localPosition: const Offset(60.0, 40.0),
    kind: PointerDeviceKind.touch,
    consecutiveTapCount: 1,
  );
  _dumpDetails('Anatomy canonical', canonical);

  return _frame(
    title: '2. Anatomy — the five fields',
    border: kGlacier,
    titleFill: kGlacier,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _thumbnail(canonical, kGlacier, size: 140),
            const SizedBox(width: 12),
            Expanded(
              child: _propsTable(
                <List<String>>[
                  <String>[
                    'sourceTimeStamp',
                    _fmtTime(canonical.sourceTimeStamp),
                  ],
                  <String>[
                    'globalPosition',
                    _fmtOffset(canonical.globalPosition),
                  ],
                  <String>[
                    'localPosition',
                    _fmtOffset(canonical.localPosition),
                  ],
                  <String>['kind', _kindLabel(canonical.kind)],
                  <String>[
                    'consecutiveTapCount',
                    canonical.consecutiveTapCount.toString(),
                  ],
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        _step(
          1,
          'sourceTimeStamp',
          'Engine-recorded timestamp of the pointer event that '
              'triggered the drag-start. Type Duration?. Null when the '
              'event came from an accessibility bridge or any synthetic '
              'source. Use it for velocity computations and for '
              'time-based gestures (e.g. hold-and-drag latency).',
          color: kGlacier,
        ),
        _step(
          2,
          'globalPosition',
          'Offset in the *root window* coordinate space. Useful for '
              'overlays, hit-testing across nested routes, and for '
              'rendering follow-the-finger overlays that must outlive '
              'the originating widget.',
          color: kGlacier,
        ),
        _step(
          3,
          'localPosition',
          'Offset relative to the receiving widget\'s top-left. The '
              'preferred field for in-widget drawing because it remains '
              'stable across screen rotation and parent transforms.',
          color: kGlacier,
        ),
        _step(
          4,
          'kind',
          'PointerDeviceKind? describing the input device. Use this to '
              'tailor feedback: thicker stroke for stylus, finer hit '
              'box for mouse, momentum for trackpad. Null when the '
              'recognizer was driven synthetically.',
          color: kGlacier,
        ),
        _step(
          5,
          'consecutiveTapCount',
          'int counter exposing 1 for a solo tap-then-drag, 2 for a '
              'double-tap-then-drag, 3 for triple-tap-then-drag, and '
              'so on. Resets when the inter-tap timeout elapses or '
              'when the tap-window slop is exceeded between taps.',
          color: kAurora,
        ),
        const SizedBox(height: 10),
        _code(
          'TapDragStartDetails(\n'
          '  sourceTimeStamp: Duration(milliseconds: 480),\n'
          '  globalPosition : Offset(180.0, 140.0),\n'
          '  localPosition  : Offset(60.0, 40.0),\n'
          '  kind           : PointerDeviceKind.touch,\n'
          '  consecutiveTapCount: 1,\n'
          ');',
        ),
        _banner(
          'Modifier keys (Shift/Ctrl/Alt/Meta) are NOT carried by the '
          'details object itself. Query them via '
          'HardwareKeyboard.instance.logicalKeysPressed at callback '
          'time — see the key-modifier matrix below for the recipe.',
          color: kViolet,
          icon: Icons.keyboard,
        ),
      ],
    ),
  );
}

Widget _buildRecipes() {
  // Recipes: single / double / triple tap drag — show consecutiveTapCount.
  final TapDragStartDetails singleTapDrag = TapDragStartDetails(
    sourceTimeStamp: const Duration(milliseconds: 220),
    globalPosition: const Offset(100.0, 80.0),
    localPosition: const Offset(40.0, 30.0),
    kind: PointerDeviceKind.touch,
    consecutiveTapCount: 1,
  );
  final TapDragStartDetails doubleTapDrag = TapDragStartDetails(
    sourceTimeStamp: const Duration(milliseconds: 540),
    globalPosition: const Offset(160.0, 120.0),
    localPosition: const Offset(60.0, 50.0),
    kind: PointerDeviceKind.touch,
    consecutiveTapCount: 2,
  );
  final TapDragStartDetails tripleTapDrag = TapDragStartDetails(
    sourceTimeStamp: const Duration(milliseconds: 920),
    globalPosition: const Offset(220.0, 160.0),
    localPosition: const Offset(80.0, 70.0),
    kind: PointerDeviceKind.mouse,
    consecutiveTapCount: 3,
  );
  final TapDragStartDetails quadTapDrag = TapDragStartDetails(
    sourceTimeStamp: const Duration(milliseconds: 1300),
    globalPosition: const Offset(280.0, 200.0),
    localPosition: const Offset(100.0, 90.0),
    kind: PointerDeviceKind.mouse,
    consecutiveTapCount: 4,
  );

  return _frame(
    title: '3. Recipes — tap-count progression',
    border: kAurora,
    titleFill: kAuroraDeep,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'consecutiveTapCount lets editors layer behavior on top of '
          'the basic drag-start. Below: the same drag-start event for '
          'tap counts 1, 2, 3 and 4 — each typically maps to a '
          'different text-selection unit.',
          style: TextStyle(fontSize: 13, height: 1.45, color: kNavy),
        ),
        const SizedBox(height: 8),
        _detailsCard(
          'Single-tap drag — character selection',
          singleTapDrag,
          accent: kGlacier,
          icon: Icons.text_fields,
          note:
              'tapCount=1: drag selects character by character, like '
              'click-and-drag in a typical text widget.',
        ),
        _detailsCard(
          'Double-tap drag — word extension',
          doubleTapDrag,
          accent: kAurora,
          icon: Icons.short_text,
          note:
              'tapCount=2: drag now snaps to word boundaries, '
              'extending the selection one word at a time.',
        ),
        _detailsCard(
          'Triple-tap drag — line / paragraph extension',
          tripleTapDrag,
          accent: kViolet,
          icon: Icons.notes,
          note:
              'tapCount=3: drag snaps to whole lines or paragraphs '
              '— common in IDEs and word processors.',
        ),
        _detailsCard(
          'Quad-tap drag — document-scoped selection (rare)',
          quadTapDrag,
          accent: kCoral,
          icon: Icons.article,
          note:
              'tapCount=4+: some editors map this to "select all" or '
              'document-level operations. Treat anything >3 with care.',
        ),
        const SizedBox(height: 8),
        _code(
          'void _onDragStart(TapDragStartDetails d) {\n'
          '  switch (d.consecutiveTapCount) {\n'
          '    case 1: _beginCharSelect(d); break;\n'
          '    case 2: _beginWordSelect(d); break;\n'
          '    case 3: _beginLineSelect(d); break;\n'
          '    default: _beginDocumentSelect(d);\n'
          '  }\n'
          '}',
        ),
      ],
    ),
  );
}

Widget _buildPointerKindMatrix() {
  // One details instance for each PointerDeviceKind value.
  final TapDragStartDetails touch = TapDragStartDetails(
    sourceTimeStamp: const Duration(milliseconds: 100),
    globalPosition: const Offset(60.0, 60.0),
    localPosition: const Offset(20.0, 20.0),
    kind: PointerDeviceKind.touch,
    consecutiveTapCount: 1,
  );
  final TapDragStartDetails mouse = TapDragStartDetails(
    sourceTimeStamp: const Duration(milliseconds: 300),
    globalPosition: const Offset(120.0, 60.0),
    localPosition: const Offset(40.0, 25.0),
    kind: PointerDeviceKind.mouse,
    consecutiveTapCount: 1,
  );
  final TapDragStartDetails stylus = TapDragStartDetails(
    sourceTimeStamp: const Duration(milliseconds: 540),
    globalPosition: const Offset(80.0, 140.0),
    localPosition: const Offset(28.0, 60.0),
    kind: PointerDeviceKind.stylus,
    consecutiveTapCount: 1,
  );
  final TapDragStartDetails invertedStylus = TapDragStartDetails(
    sourceTimeStamp: const Duration(milliseconds: 760),
    globalPosition: const Offset(140.0, 140.0),
    localPosition: const Offset(50.0, 60.0),
    kind: PointerDeviceKind.invertedStylus,
    consecutiveTapCount: 1,
  );
  final TapDragStartDetails trackpad = TapDragStartDetails(
    sourceTimeStamp: const Duration(milliseconds: 980),
    globalPosition: const Offset(60.0, 220.0),
    localPosition: const Offset(22.0, 92.0),
    kind: PointerDeviceKind.trackpad,
    consecutiveTapCount: 2,
  );
  final TapDragStartDetails unknown = TapDragStartDetails(
    sourceTimeStamp: null,
    globalPosition: const Offset(140.0, 220.0),
    localPosition: const Offset(52.0, 92.0),
    kind: PointerDeviceKind.unknown,
    consecutiveTapCount: 1,
  );

  return _frame(
    title: '4. Pointer kind matrix',
    border: kGlacierDeep,
    titleFill: kGlacierDeep,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'kind is a PointerDeviceKind? — use it to brand the '
          'experience per input modality. Six instances below cover '
          'every enum value plus the unspecified case.',
          style: TextStyle(fontSize: 13, height: 1.45, color: kNavy),
        ),
        const SizedBox(height: 6),
        _detailsCard(
          'touch — finger contact',
          touch,
          accent: kGlacier,
          icon: Icons.touch_app,
          note:
              'Most common on mobile. Lower precision, larger slop, '
              'no hover. Avoid 1-px hit boxes.',
        ),
        _detailsCard(
          'mouse — desktop click-drag',
          mouse,
          accent: kAurora,
          icon: Icons.mouse,
          note:
              'Click-and-drag on desktop. High precision; hover and '
              'right-button info available via other recognizers.',
        ),
        _detailsCard(
          'stylus — pen down',
          stylus,
          accent: kViolet,
          icon: Icons.edit,
          note:
              'Drawing tablets and convertible laptops. Pressure and '
              'tilt available on PointerEvent but NOT on this details.',
        ),
        _detailsCard(
          'invertedStylus — eraser end',
          invertedStylus,
          accent: kCoral,
          icon: Icons.brush,
          note:
              'Some pens report the eraser tip as an inverted stylus. '
              'Map this kind to your erase tool.',
        ),
        _detailsCard(
          'trackpad — two-finger scrub',
          trackpad,
          accent: kAmberDeep,
          icon: Icons.swipe,
          note:
              'On laptops with multi-touch trackpads, gesture events '
              'come through with this kind. Often paired with the pan '
              'subclass.',
        ),
        _detailsCard(
          'unknown — synthetic / accessibility',
          unknown,
          accent: kSlate,
          icon: Icons.help_outline,
          note:
              'Accessibility bridges and tests may emit unknown. '
              'sourceTimeStamp is null here too. Treat defensively.',
        ),
      ],
    ),
  );
}

Widget _buildKeyModifierMatrix() {
  // Same drag-start, varying modifier sets (queried from HardwareKeyboard
  // at callback time — here we simulate by carrying the set alongside).
  final TapDragStartDetails base = TapDragStartDetails(
    sourceTimeStamp: const Duration(milliseconds: 600),
    globalPosition: const Offset(180.0, 100.0),
    localPosition: const Offset(70.0, 40.0),
    kind: PointerDeviceKind.mouse,
    consecutiveTapCount: 1,
  );

  Widget keyRow(String label, Set<String> mods, String hint) {
    final bool shift = mods.contains('shift') ||
        mods.contains('shiftLeft') ||
        mods.contains('shiftRight');
    final bool ctrl = mods.contains('control') ||
        mods.contains('controlLeft') ||
        mods.contains('controlRight');
    final bool alt = mods.contains('alt') ||
        mods.contains('altLeft') ||
        mods.contains('altRight');
    final bool meta = mods.contains('meta') ||
        mods.contains('metaLeft') ||
        mods.contains('metaRight');

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: kSnow,
        border: Border.all(color: kViolet.withAlpha(120)),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              SizedBox(
                width: 110,
                child: Text(
                  label,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: kVioletDeep,
                    fontSize: 12,
                  ),
                ),
              ),
              _keycap('SHIFT', down: shift),
              _keycap('CTRL', down: ctrl),
              _keycap('ALT', down: alt),
              _keycap('META', down: meta),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  hint,
                  style: const TextStyle(
                    fontSize: 11,
                    color: kSlate,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _dumpDetails('Modifier-matrix base', base);

  return _frame(
    title: '5. Key-modifier matrix (Shift / Ctrl / Alt / Meta)',
    border: kViolet,
    titleFill: kVioletDeep,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'TapDragStartDetails does NOT carry a keysPressedOnDown '
          'field, but recipients almost always need to react to '
          'modifier keys. Query HardwareKeyboard.instance at '
          'callback time. Common semantics:',
          style: TextStyle(fontSize: 13, height: 1.45, color: kNavy),
        ),
        const SizedBox(height: 8),
        _code(
          'void _onDragStart(TapDragStartDetails d) {\n'
          '  final keys = HardwareKeyboard.instance.logicalKeysPressed;\n'
          '  final bool shift = keys.any(_isShift);\n'
          '  final bool ctrl  = keys.any(_isCtrl);\n'
          '  final bool alt   = keys.any(_isAlt);\n'
          '  final bool meta  = keys.any(_isMeta);\n'
          '  _startDragWithModifiers(d, shift, ctrl, alt, meta);\n'
          '}',
        ),
        const SizedBox(height: 8),
        keyRow(
          'no modifier',
          const <String>{},
          'plain drag — replace existing selection',
        ),
        keyRow(
          'shift only',
          const <String>{'shiftLeft'},
          'extend selection from previous anchor',
        ),
        keyRow(
          'ctrl only',
          const <String>{'controlLeft'},
          'multi-region select / unit jump',
        ),
        keyRow(
          'alt only',
          const <String>{'altLeft'},
          'column / block selection in editors',
        ),
        keyRow(
          'meta only',
          const <String>{'metaLeft'},
          'cmd-drag (macOS) — duplicate / link',
        ),
        keyRow(
          'shift + alt',
          const <String>{'shiftLeft', 'altLeft'},
          'extend column selection',
        ),
        keyRow(
          'ctrl + shift',
          const <String>{'controlLeft', 'shiftLeft'},
          'extend by word/line',
        ),
        keyRow(
          'all four',
          const <String>{'shiftLeft', 'controlLeft', 'altLeft', 'metaLeft'},
          'rare combo — usually reserved for power-user shortcuts',
        ),
        const SizedBox(height: 10),
        _detailsCard(
          'Sample: drag-start with Shift held',
          base,
          accent: kViolet,
          icon: Icons.keyboard_capslock,
          note:
              'The details object is identical regardless of modifier '
              'state — the difference lives in HardwareKeyboard.',
          modifiers: const <String>{'shiftLeft'},
        ),
        _detailsCard(
          'Sample: drag-start with Ctrl+Shift held',
          base,
          accent: kVioletDeep,
          icon: Icons.keyboard_command_key,
          note:
              'Same payload; modifier set recorded separately to '
              'illustrate the "look up at callback time" pattern.',
          modifiers: const <String>{'controlLeft', 'shiftLeft'},
        ),
      ],
    ),
  );
}

Widget _buildComparison() {
  // Compare side-by-side with DragStartDetails and TapDownDetails.
  final TapDragStartDetails tds = TapDragStartDetails(
    sourceTimeStamp: const Duration(milliseconds: 500),
    globalPosition: const Offset(150.0, 100.0),
    localPosition: const Offset(50.0, 30.0),
    kind: PointerDeviceKind.touch,
    consecutiveTapCount: 2,
  );
  final DragStartDetails dsd = DragStartDetails(
    sourceTimeStamp: const Duration(milliseconds: 500),
    globalPosition: const Offset(150.0, 100.0),
    localPosition: const Offset(50.0, 30.0),
    kind: PointerDeviceKind.touch,
  );
  final TapDownDetails tdd = TapDownDetails(
    globalPosition: const Offset(150.0, 100.0),
    localPosition: const Offset(50.0, 30.0),
    kind: PointerDeviceKind.touch,
  );

  print('--- Comparison anchors ---');
  _dumpDetails('TapDragStart', tds);
  print('  DragStartDetails        : gp=${dsd.globalPosition} '
      'lp=${dsd.localPosition} ts=${dsd.sourceTimeStamp}');
  print('  TapDownDetails          : gp=${tdd.globalPosition} '
      'lp=${tdd.localPosition} kind=${tdd.kind}');

  Widget col(String title, Color color, List<List<String>> rows) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: kSnow,
          border: Border.all(color: color, width: 1.5),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 6),
            _propsTable(rows, accent: color),
          ],
        ),
      ),
    );
  }

  return _frame(
    title: '6. Comparison — vs DragStartDetails and TapDownDetails',
    border: kAuroraDeep,
    titleFill: kAuroraDeep,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Three sibling details classes carry overlapping but '
          'distinct slices of "the pointer touched the screen". '
          'Pick the one whose extra field you need.',
          style: TextStyle(fontSize: 13, height: 1.45, color: kNavy),
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            col('TapDragStartDetails', kGlacier, <List<String>>[
              <String>['sourceTimeStamp', _fmtTime(tds.sourceTimeStamp)],
              <String>['globalPosition', _fmtOffset(tds.globalPosition)],
              <String>['localPosition', _fmtOffset(tds.localPosition)],
              <String>['kind', _kindLabel(tds.kind)],
              <String>[
                'consecutiveTapCount',
                tds.consecutiveTapCount.toString(),
              ],
            ]),
            col('DragStartDetails', kAurora, <List<String>>[
              <String>['sourceTimeStamp', _fmtTime(dsd.sourceTimeStamp)],
              <String>['globalPosition', _fmtOffset(dsd.globalPosition)],
              <String>['localPosition', _fmtOffset(dsd.localPosition)],
              <String>['kind', _kindLabel(dsd.kind)],
              <String>['consecutiveTapCount', 'n/a (not a field)'],
            ]),
            col('TapDownDetails', kViolet, <List<String>>[
              <String>['sourceTimeStamp', 'n/a (not a field)'],
              <String>['globalPosition', _fmtOffset(tdd.globalPosition)],
              <String>['localPosition', _fmtOffset(tdd.localPosition)],
              <String>['kind', _kindLabel(tdd.kind)],
              <String>['consecutiveTapCount', 'n/a (not a field)'],
            ]),
          ],
        ),
        const SizedBox(height: 10),
        _banner(
          'Use TapDragStartDetails when you need tap-count awareness '
          '(word/line selection) AND drag origin in the same payload.',
          color: kGlacier,
          icon: Icons.tag,
        ),
        _banner(
          'Use DragStartDetails for pure drag gestures (pan, '
          'horizontal, vertical) where the prefix tap count is '
          'irrelevant.',
          color: kAurora,
          icon: Icons.swipe,
        ),
        _banner(
          'Use TapDownDetails for the very first "finger touched" '
          'instant, before the recognizer has committed to drag or '
          'pure-tap behaviour.',
          color: kViolet,
          icon: Icons.touch_app,
        ),
      ],
    ),
  );
}

Widget _buildPitfalls() {
  return _frame(
    title: '7. Common pitfalls & gotchas',
    border: kAmberDeep,
    titleFill: kAmberDeep,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _banner(
          'Don\'t assume sourceTimeStamp is non-null. Synthetic '
          'sources (accessibility, tests) frequently leave it as '
          'null. Use ?? Duration.zero or guard explicitly.',
          color: kAmber,
          icon: Icons.access_time,
        ),
        _banner(
          'Don\'t use globalPosition for in-widget drawing — it '
          'lives in the root window frame and will be wrong inside '
          'transformed parents. Use localPosition.',
          color: kAmber,
          icon: Icons.crop_free,
        ),
        _banner(
          'consecutiveTapCount can grow unbounded. Cap it (e.g. min(3, '
          'count)) before mapping to a selection unit, otherwise '
          'quad-tap drags may silently fall through your switch.',
          color: kAmber,
          icon: Icons.numbers,
        ),
        _banner(
          'Modifier-key state is read at callback time. If the user '
          'releases Shift between drag-start and drag-update, your '
          'update handler may disagree with your start handler — '
          'persist the modifier set captured at drag-start.',
          color: kAmber,
          icon: Icons.keyboard_alt,
        ),
        _banner(
          'TapDragStartDetails fires AFTER the slop threshold is '
          'exceeded; for the pre-drag tap-down moment use '
          'TapDragDownDetails instead.',
          color: kAmber,
          icon: Icons.timeline,
        ),
        _banner(
          'kind == PointerDeviceKind.unknown is not an error — it '
          'simply means the source did not report a kind. Provide a '
          'sensible default (often treat as touch).',
          color: kAmber,
          icon: Icons.help_outline,
        ),
        _banner(
          'BaseTapAndDragGestureRecognizer is the *base* class; it '
          'is abstract in spirit. Use TapAndPanGestureRecognizer or '
          'TapAndHorizontalDragGestureRecognizer in practice.',
          color: kAmber,
          icon: Icons.architecture,
        ),
        _banner(
          'On Flutter Web, browser drag-and-drop events do NOT feed '
          'this recognizer directly — they go through a separate HTML '
          'DnD bridge. Don\'t expect identical behaviour on web.',
          color: kAmber,
          icon: Icons.web,
        ),
      ],
    ),
  );
}

Widget _buildGlossary() {
  Widget term(String term, String body, {Color color = kGlacier}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: RichText(
        text: TextSpan(
          children: <InlineSpan>[
            TextSpan(
              text: term,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 13,
                fontFamily: 'monospace',
              ),
            ),
            const TextSpan(
              text: '  —  ',
              style: TextStyle(color: kSlate, fontSize: 13),
            ),
            TextSpan(
              text: body,
              style: const TextStyle(
                color: kNavy,
                fontSize: 12.5,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  return _frame(
    title: '8. Glossary',
    border: kVioletDeep,
    titleFill: kVioletDeep,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        term(
          'slop',
          'The minimum pointer movement (in logical pixels) required '
              'before a tap is reclassified as a drag. Default ~18px on '
              'touch, configurable via gestureSettings.',
          color: kGlacier,
        ),
        term(
          'gesture arena',
          'Flutter\'s pointer-event resolver. Recognizers compete; the '
              'winner receives subsequent events. TapDragStartDetails '
              'fires only after the tap-drag recognizer wins.',
          color: kGlacier,
        ),
        term(
          'consecutiveTapCount',
          'Number of taps that landed close together in time and space '
              'before this drag start. Resets on inter-tap timeout.',
          color: kAurora,
        ),
        term(
          'PointerDeviceKind',
          'Enum: touch, mouse, stylus, invertedStylus, trackpad, '
              'unknown. The "kind" field on positioned details.',
          color: kViolet,
        ),
        term(
          'HardwareKeyboard',
          'Singleton that reports which logical keys are currently '
              'down. Use it to read modifier state inside gesture '
              'callbacks.',
          color: kViolet,
        ),
        term(
          'PositionedGestureDetails',
          'Interface implemented by all details classes that carry '
              'globalPosition / localPosition fields.',
          color: kGlacierDeep,
        ),
        term(
          'sourceTimeStamp',
          'Engine-recorded time of the raw pointer event. Nullable. '
              'Useful for velocity and timing computations.',
          color: kAurora,
        ),
        term(
          'GestureTapDragStartCallback',
          'Function type: void Function(TapDragStartDetails). The '
              'callback signature for onDragStart.',
          color: kViolet,
        ),
      ],
    ),
  );
}

Widget _buildRecap() {
  return _frame(
    title: '9. Recap',
    border: kGlacierDeep,
    titleFill: kNavy,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _step(
          1,
          'Identity',
          'TapDragStartDetails = positioned drag-origin + tap-counter. '
              'Delivered to GestureTapDragStartCallback by '
              'BaseTapAndDragGestureRecognizer.',
          color: kGlacier,
        ),
        _step(
          2,
          'Fields',
          'sourceTimeStamp (Duration?), globalPosition (Offset), '
              'localPosition (Offset), kind (PointerDeviceKind?), '
              'consecutiveTapCount (int).',
          color: kGlacier,
        ),
        _step(
          3,
          'When fired',
          'After the recognizer wins the arena AND the pointer has '
              'moved enough to leave the tap window. Never on a pure '
              'tap.',
          color: kAurora,
        ),
        _step(
          4,
          'Tap-count semantics',
          '1 = char select, 2 = word, 3 = line, 4+ = document — by '
              'convention. Cap your switch.',
          color: kAurora,
        ),
        _step(
          5,
          'Modifier keys',
          'Read HardwareKeyboard.instance.logicalKeysPressed at '
              'callback time. The details object itself does not carry '
              'modifier state.',
          color: kViolet,
        ),
        _step(
          6,
          'Pointer kind',
          'Use kind to tailor feedback: thicker stroke for stylus, '
              'finer hit-box for mouse, momentum for trackpad.',
          color: kViolet,
        ),
        _step(
          7,
          'Comparison',
          'Different from DragStartDetails (no tap counter) and '
              'TapDownDetails (no timestamp / no tap counter).',
          color: kCoral,
        ),
        _step(
          8,
          'Gotchas',
          'Null sourceTimeStamp, unbounded tap count, modifier-state '
              'drift, root vs local coordinates, web bridge.',
          color: kAmberDeep,
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------
// Build a small distribution chart of tap-count incidence (synthetic).
// ---------------------------------------------------------------------
Widget _buildTapCountChart() {
  // Synthetic distribution — what fraction of drag-starts use each
  // tap count in a typical editor session.
  final List<int> counts = <int>[680, 240, 60, 18, 2];
  final List<String> labels = <String>[
    'tap=1\n(char)',
    'tap=2\n(word)',
    'tap=3\n(line)',
    'tap=4\n(rare)',
    'tap=5+\n(very rare)',
  ];
  final List<Color> bars = <Color>[
    kGlacier,
    kAurora,
    kViolet,
    kCoral,
    kAmberDeep,
  ];
  final int maxV = counts.reduce(math.max);

  return _frame(
    title: '10. Synthetic tap-count distribution (editor session)',
    border: kGlacier,
    titleFill: kGlacier,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const Text(
          'Not from real telemetry — illustrative only. In a typical '
          'text-editing session the bulk of drag-starts come with '
          'consecutiveTapCount=1, dropping sharply after.',
          style: TextStyle(fontSize: 12.5, color: kNavy, height: 1.4),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 140,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              for (int i = 0; i < counts.length; i++)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          counts[i].toString(),
                          style: TextStyle(
                            fontSize: 11,
                            color: bars[i],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Container(
                          height: (counts[i] / maxV) * 100.0 + 4.0,
                          decoration: BoxDecoration(
                            color: bars[i],
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(4),
                              topRight: Radius.circular(4),
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          labels[i],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 9.5,
                            color: kSlate,
                            height: 1.2,
                          ),
                        ),
                      ],
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

// ---------------------------------------------------------------------
// Build a timestamp axis showing where each sample lands in time.
// ---------------------------------------------------------------------
Widget _buildTimelineAxis() {
  // Build a fresh batch of details with ascending timestamps for the
  // axis demo.
  final List<TapDragStartDetails> series = <TapDragStartDetails>[
    TapDragStartDetails(
      sourceTimeStamp: const Duration(milliseconds: 80),
      globalPosition: const Offset(40, 40),
      localPosition: const Offset(10, 10),
      kind: PointerDeviceKind.touch,
      consecutiveTapCount: 1,
    ),
    TapDragStartDetails(
      sourceTimeStamp: const Duration(milliseconds: 360),
      globalPosition: const Offset(120, 60),
      localPosition: const Offset(20, 12),
      kind: PointerDeviceKind.touch,
      consecutiveTapCount: 2,
    ),
    TapDragStartDetails(
      sourceTimeStamp: const Duration(milliseconds: 720),
      globalPosition: const Offset(200, 80),
      localPosition: const Offset(30, 14),
      kind: PointerDeviceKind.mouse,
      consecutiveTapCount: 1,
    ),
    TapDragStartDetails(
      sourceTimeStamp: const Duration(milliseconds: 1080),
      globalPosition: const Offset(280, 100),
      localPosition: const Offset(40, 16),
      kind: PointerDeviceKind.stylus,
      consecutiveTapCount: 3,
    ),
    TapDragStartDetails(
      sourceTimeStamp: const Duration(milliseconds: 1480),
      globalPosition: const Offset(360, 120),
      localPosition: const Offset(50, 18),
      kind: PointerDeviceKind.trackpad,
      consecutiveTapCount: 1,
    ),
    TapDragStartDetails(
      sourceTimeStamp: null,
      globalPosition: const Offset(440, 140),
      localPosition: const Offset(60, 20),
      kind: PointerDeviceKind.unknown,
      consecutiveTapCount: 1,
    ),
  ];

  final int maxMs = 1600;

  Widget marker(TapDragStartDetails d, int i) {
    final Color c = <Color>[
      kGlacier,
      kAurora,
      kViolet,
      kCoral,
      kAmberDeep,
      kSlate,
    ][i % 6];
    final double left = d.sourceTimeStamp == null
        ? 1.0
        : (d.sourceTimeStamp!.inMilliseconds / maxMs).clamp(0.0, 1.0);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 90,
            child: Text(
              _fmtTime(d.sourceTimeStamp),
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11,
                color: c,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (BuildContext ctx, BoxConstraints box) {
                final double w = box.maxWidth;
                return Stack(
                  children: <Widget>[
                    Container(
                      height: 22,
                      decoration: BoxDecoration(
                        color: kSnowDeep,
                        borderRadius: BorderRadius.circular(11),
                        border: Border.all(color: kSlateLight, width: 0.5),
                      ),
                    ),
                    Positioned(
                      left: (left * (w - 18)).clamp(0.0, w - 18.0),
                      top: 1,
                      child: Container(
                        width: 18,
                        height: 20,
                        decoration: BoxDecoration(
                          color: c,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: c.withAlpha(120),
                              blurRadius: 4,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          d.consecutiveTapCount.toString(),
                          style: const TextStyle(
                            color: kSnow,
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(width: 6),
          SizedBox(
            width: 90,
            child: Text(
              _kindLabel(d.kind),
              style: TextStyle(
                fontSize: 10.5,
                color: c,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }

  for (int i = 0; i < series.length; i++) {
    _dumpDetails('Timeline #$i', series[i]);
  }

  return _frame(
    title: '11. Drag-start timeline axis',
    border: kAuroraDeep,
    titleFill: kAuroraDeep,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Six drag-starts placed on a 1.6-second axis by their '
          'sourceTimeStamp. Numbers inside the bubble show '
          'consecutiveTapCount; the null-timestamp sample lands at '
          'the far right (clamped).',
          style: TextStyle(fontSize: 12.5, color: kNavy, height: 1.4),
        ),
        const SizedBox(height: 8),
        for (int i = 0; i < series.length; i++) marker(series[i], i),
        const SizedBox(height: 4),
        const Text(
          'Axis runs 0 → 1600ms (left to right). Null-timestamp '
          'events have no defined position and are pinned to the end.',
          style: TextStyle(
            fontSize: 11,
            color: kSlate,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------
// Diagnostics dump — call debugFillProperties on a TapDragStartDetails
// and render the result.
// ---------------------------------------------------------------------
Widget _buildDiagnosticsDump() {
  final TapDragStartDetails sample = TapDragStartDetails(
    sourceTimeStamp: const Duration(milliseconds: 1234),
    globalPosition: const Offset(123.4, 56.7),
    localPosition: const Offset(23.4, 6.7),
    kind: PointerDeviceKind.stylus,
    consecutiveTapCount: 2,
  );
  final DiagnosticPropertiesBuilder builder = DiagnosticPropertiesBuilder();
  sample.debugFillProperties(builder);
  final List<DiagnosticsNode> nodes = builder.properties;

  // Also log them to the console for d4rt trace inspection.
  print('--- Diagnostics dump ---');
  for (final DiagnosticsNode n in nodes) {
    print('  ${n.name} = ${n.value}');
  }

  return _frame(
    title: '12. Diagnostics dump (debugFillProperties)',
    border: kViolet,
    titleFill: kViolet,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'TapDragStartDetails mixes in Diagnosticable; '
          'debugFillProperties yields one DiagnosticsNode per field. '
          'Useful for inspector output and snapshot testing.',
          style: TextStyle(fontSize: 12.5, color: kNavy, height: 1.4),
        ),
        const SizedBox(height: 8),
        _propsTable(
          <List<String>>[
            for (final DiagnosticsNode n in nodes)
              <String>[n.name ?? '?', n.value?.toString() ?? 'null'],
          ],
          accent: kViolet,
        ),
        const SizedBox(height: 8),
        _code(
          'final builder = DiagnosticPropertiesBuilder();\n'
          'tapDragStartDetails.debugFillProperties(builder);\n'
          'for (final n in builder.properties) {\n'
          '  print(\'\${n.name} = \${n.value}\');\n'
          '}',
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------
// Main build entry point.
// ---------------------------------------------------------------------
dynamic build(BuildContext context) {
  print('======================================================');
  print('TapDragStartDetails Deep Visual Demo — execution start');
  print('======================================================');

  // Pre-build a quick sanity-check details so we can compare it to
  // the other details types early in the trace.
  final TapDragStartDetails sanity = TapDragStartDetails(
    sourceTimeStamp: const Duration(milliseconds: 10),
    globalPosition: Offset.zero,
    localPosition: Offset.zero,
    kind: PointerDeviceKind.unknown,
    consecutiveTapCount: 1,
  );
  _dumpDetails('Sanity check (zero-origin)', sanity);

  return Scaffold(
    backgroundColor: kSnowDeep,
    appBar: AppBar(
      backgroundColor: kNavy,
      foregroundColor: kSnow,
      elevation: 4,
      title: Row(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: kGlacier,
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Icon(Icons.swipe, color: kSnow, size: 18),
          ),
          const SizedBox(width: 10),
          const Text(
            'TapDragStartDetails — Deep Visual Demo',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ],
      ),
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Top hero strip
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[kNavy, kGlacierDeep],
              ),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: kGlacier, width: 2),
            ),
            child: Row(
              children: <Widget>[
                const Icon(Icons.swipe, color: kSnow, size: 32),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        'TapDragStartDetails',
                        style: TextStyle(
                          color: kSnow,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.4,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Payload of GestureTapDragStartCallback '
                        '(BaseTapAndDragGestureRecognizer).',
                        style: TextStyle(
                          color: kSnow.withAlpha(220),
                          fontSize: 12.5,
                          fontStyle: FontStyle.italic,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Wrap(
                        children: <Widget>[
                          _chip(
                            'class',
                            'TapDragStartDetails',
                            color: kGlacierSoft,
                            icon: Icons.class_,
                          ),
                          _chip(
                            'package',
                            'flutter/gestures.dart',
                            color: kAuroraSoft,
                            icon: Icons.archive,
                          ),
                          _chip(
                            'mixin',
                            'Diagnosticable',
                            color: kVioletSoft,
                            icon: Icons.bug_report,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          _sectionHeader(
            'Section 1 · Dossier',
            icon: Icons.menu_book,
            color: kGlacierDeep,
            subtitle: 'Who fires it, when, and why it exists.',
          ),
          _buildDossier(),

          _sectionHeader(
            'Section 2 · Anatomy',
            icon: Icons.account_tree,
            color: kGlacier,
            subtitle: 'Each of the five constructor parameters.',
          ),
          _buildAnatomy(),

          _sectionHeader(
            'Section 3 · Recipes',
            icon: Icons.restaurant_menu,
            color: kAurora,
            subtitle:
                'Single, double, triple, quad-tap drag with '
                'consecutiveTapCount progression.',
          ),
          _buildRecipes(),

          _sectionHeader(
            'Section 4 · Pointer kind matrix',
            icon: Icons.devices_other,
            color: kGlacierDeep,
            subtitle:
                'Touch / mouse / stylus / inverted stylus / '
                'trackpad / unknown.',
          ),
          _buildPointerKindMatrix(),

          _sectionHeader(
            'Section 5 · Key-modifier matrix',
            icon: Icons.keyboard,
            color: kViolet,
            subtitle:
                'Shift / Ctrl / Alt / Meta combinations — '
                'queried via HardwareKeyboard.',
          ),
          _buildKeyModifierMatrix(),

          _sectionHeader(
            'Section 6 · Comparison',
            icon: Icons.compare_arrows,
            color: kAuroraDeep,
            subtitle:
                'vs DragStartDetails and TapDownDetails — '
                'pick the right details class.',
          ),
          _buildComparison(),

          _sectionHeader(
            'Section 7 · Pitfalls',
            icon: Icons.warning_amber,
            color: kAmberDeep,
            subtitle: 'Eight traps to sidestep.',
          ),
          _buildPitfalls(),

          _sectionHeader(
            'Section 8 · Glossary',
            icon: Icons.translate,
            color: kVioletDeep,
            subtitle: 'Terms used throughout this demo.',
          ),
          _buildGlossary(),

          _sectionHeader(
            'Section 9 · Recap',
            icon: Icons.checklist,
            color: kGlacierDeep,
            subtitle: 'Eight bullets you can quote from memory.',
          ),
          _buildRecap(),

          _sectionHeader(
            'Section 10 · Tap-count distribution',
            icon: Icons.bar_chart,
            color: kGlacier,
            subtitle:
                'How common each consecutiveTapCount is in a '
                'typical editor session.',
          ),
          _buildTapCountChart(),

          _sectionHeader(
            'Section 11 · Timeline axis',
            icon: Icons.timeline,
            color: kAuroraDeep,
            subtitle:
                'sourceTimeStamp axis — six samples plotted by '
                'their engine timestamps.',
          ),
          _buildTimelineAxis(),

          _sectionHeader(
            'Section 12 · Diagnostics dump',
            icon: Icons.bug_report,
            color: kViolet,
            subtitle: 'debugFillProperties on a real instance.',
          ),
          _buildDiagnosticsDump(),

          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: kNavy,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: kGlacier, width: 1.5),
            ),
            child: Row(
              children: <Widget>[
                const Icon(Icons.check_circle, color: kAurora, size: 22),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'End of TapDragStartDetails deep demo — five fields, '
                    'six pointer kinds, four tap counts, eight pitfalls.',
                    style: TextStyle(
                      color: kSnow.withAlpha(230),
                      fontSize: 12.5,
                      fontStyle: FontStyle.italic,
                      height: 1.35,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    ),
  );
}
