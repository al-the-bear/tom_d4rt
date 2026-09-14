// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unnecessary_import
// D4rt deep visual demo: Flutter's `RestorableValue` family in
// `package:flutter/widgets.dart` and `package:flutter/material.dart`.
//
// This file is a hand-authored corpus entry for the analyzer-free D4rt
// interpreter. It walks through the entire RestorableValue family:
//   RestorableValue<T>, RestorableProperty<T>,
//   RestorableInt, RestorableDouble, RestorableBool, RestorableString,
//   RestorableNum<num>, RestorableDateTime, RestorableEnum<E>,
//   RestorableIntN, RestorableDoubleN, RestorableBoolN, RestorableStringN,
//   RestorableDateTimeN, RestorableNumN<num?>, RestorableEnumN<E?>.
//
// All values are constructed as plain Dart objects — no platform calls, no
// `RestorationMixin` registration, no `setState`. Reading `.value` on a
// freshly constructed `RestorableInt(7)` is safe; the registration-only
// fields (`isRegistered`, `restorationId`) are inspected through the public
// `RestorableProperty` getters where they are reachable without a bucket.
//
// The script does not call any timers, futures, animation controllers or
// other live-rebuild machinery. It is a static poster — a scrolling tour of
// state restoration semantics, with anatomy diagrams, primitive round-trip
// flow charts, inspector panels, a subclass table, code snippets and a
// pitfalls list.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'dart:math' as math;
import 'dart:ui' as ui;

// ─────────────────────────────────────────────────────────────────────────
// C20 workaround: real-world restorable enums must be plain Dart enums;
// in regular Dart this would be a local enum (e.g. `enum _Mood { calm,
// focused, joyful, sleepy }`) handed to `RestorableEnum<_Mood>(...)`.
// d4rt represents script-defined enum values as `InterpretedEnumValue`,
// which does not implement Dart's native `Enum`, so the native
// `RestorableEnum<E>(E defaultValue, ...)` constructor rejects them with
// `Argument Error: Invalid parameter "defaultValue": expected Enum,
// got InterpretedEnumValue`. We substitute Flutter's framework
// `Brightness` enum (bridged, two values `light` / `dark`) so the demo
// still exercises the RestorableEnum / RestorableEnumN APIs end-to-end.
// The semantic point of the script — that `RestorableEnum` stores the
// enum's `.name` string and round-trips it through `byName(...)` — is
// unchanged. See `doc/interpreter_unfixable.md` (U8).
// ─────────────────────────────────────────────────────────────────────────
// `Brightness` (from `dart:ui` / `flutter/foundation`) plays the role of
// `_Mood` for every interaction with the native restorable-value
// constructors.

// ─────────────────────────────────────────────────────────────────────────
// Painter: the restoration anatomy diagram.
//
// Draws the conceptual graph:
//
//   RestorationScope ──► RestorationBucket
//             │                │
//             ▼                ▼
//        State (mixin)    RestorationId
//             │                │
//             ▼                │
//      RestorableProperty◄─────┘
//             │
//             ▼
//      RestorableValue<T>
//             │
//        toPrimitives()
//             │
//             ▼
//        Bucket entry
//             │
//        fromPrimitives()
//             │
//             ▼
//        Restored value
// ─────────────────────────────────────────────────────────────────────────
class _AnatomyDiagramPainter extends CustomPainter {
  const _AnatomyDiagramPainter({
    required this.nodeColor,
    required this.accentColor,
    required this.edgeColor,
    required this.labelColor,
  });

  final Color nodeColor;
  final Color accentColor;
  final Color edgeColor;
  final Color labelColor;

  static const List<String> _labels = <String>[
    'RestorationScope',
    'RestorationBucket',
    'State + RestorationMixin',
    'RestorationId  (String)',
    'RestorableProperty<T>',
    'RestorableValue<T>',
    'toPrimitives()  →  Object?',
    'fromPrimitives(Object?)  →  T',
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final double rowH = size.height / _labels.length;
    final Paint nodePaint = Paint()..color = nodeColor;
    final Paint accent = Paint()..color = accentColor;
    final Paint edgePaint = Paint()
      ..color = edgeColor
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < _labels.length; i++) {
      final double cy = rowH * i + rowH / 2;
      final RRect node = RRect.fromRectAndRadius(
        Rect.fromLTWH(14, cy - 13, size.width - 28, 26),
        const Radius.circular(7),
      );
      canvas.drawRRect(node, nodePaint);
      // Left accent stripe.
      final RRect stripe = RRect.fromRectAndRadius(
        Rect.fromLTWH(14, cy - 13, 5, 26),
        const Radius.circular(2),
      );
      canvas.drawRRect(stripe, accent);

      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: _labels[i],
          style: TextStyle(
            color: labelColor,
            fontSize: 12,
            fontWeight: FontWeight.w700,
            fontFamily: 'monospace',
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      tp.layout(maxWidth: size.width - 40);
      tp.paint(canvas, Offset(28, cy - tp.height / 2));

      if (i < _labels.length - 1) {
        final double startY = cy + 13;
        final double endY = cy + rowH - 13;
        final double midX = size.width / 2;
        canvas.drawLine(Offset(midX, startY), Offset(midX, endY), edgePaint);
        // Arrow head.
        final Path arrow = Path()
          ..moveTo(midX - 4, endY - 6)
          ..lineTo(midX, endY)
          ..lineTo(midX + 4, endY - 6);
        canvas.drawPath(arrow, edgePaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _AnatomyDiagramPainter old) {
    return old.nodeColor != nodeColor ||
        old.accentColor != accentColor ||
        old.edgeColor != edgeColor ||
        old.labelColor != labelColor;
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Painter: the primitives round-trip diagram.
//
// Draws the persistence loop:
//
//   value ─toPrimitives()─► bucket ─fromPrimitives()─► restored value
//
// Used in section 4 to make the "what gets serialized" idea concrete.
// ─────────────────────────────────────────────────────────────────────────
class _RoundTripPainter extends CustomPainter {
  const _RoundTripPainter({
    required this.nodeColor,
    required this.accentColor,
    required this.edgeColor,
    required this.labelColor,
    required this.valueLabel,
    required this.primitiveLabel,
  });

  final Color nodeColor;
  final Color accentColor;
  final Color edgeColor;
  final Color labelColor;
  final String valueLabel;
  final String primitiveLabel;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint node = Paint()..color = nodeColor;
    final Paint accent = Paint()..color = accentColor;
    final Paint edge = Paint()
      ..color = edgeColor
      ..strokeWidth = 1.6
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final double cy = size.height / 2;
    final double nodeW = (size.width - 80) / 3;
    final List<String> titles = <String>[
      'value',
      'bucket entry',
      'restored value',
    ];
    final List<String> subtitles = <String>[
      valueLabel,
      primitiveLabel,
      valueLabel,
    ];
    for (int i = 0; i < 3; i++) {
      final double left = 8 + i * (nodeW + 32);
      final RRect r = RRect.fromRectAndRadius(
        Rect.fromLTWH(left, cy - 30, nodeW, 60),
        const Radius.circular(10),
      );
      canvas.drawRRect(r, node);
      final RRect ribbon = RRect.fromRectAndRadius(
        Rect.fromLTWH(left, cy - 30, nodeW, 16),
        const Radius.circular(8),
      );
      canvas.drawRRect(ribbon, accent);
      final TextPainter t1 = TextPainter(
        text: TextSpan(
          text: titles[i],
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.4,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      t1.layout(maxWidth: nodeW - 12);
      t1.paint(canvas, Offset(left + 8, cy - 28));
      final TextPainter t2 = TextPainter(
        text: TextSpan(
          text: subtitles[i],
          style: TextStyle(
            color: labelColor,
            fontSize: 12,
            fontFamily: 'monospace',
            fontWeight: FontWeight.w600,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      t2.layout(maxWidth: nodeW - 12);
      t2.paint(canvas, Offset(left + 8, cy - 4));
    }

    // Edges between the three nodes with labels.
    final List<String> edgeLabels = <String>[
      'toPrimitives()',
      'fromPrimitives()',
    ];
    for (int i = 0; i < 2; i++) {
      final double startX = 8 + i * (nodeW + 32) + nodeW;
      final double endX = 8 + (i + 1) * (nodeW + 32);
      canvas.drawLine(Offset(startX, cy), Offset(endX - 4, cy), edge);
      final Path arrow = Path()
        ..moveTo(endX - 8, cy - 4)
        ..lineTo(endX - 2, cy)
        ..lineTo(endX - 8, cy + 4);
      canvas.drawPath(arrow, edge);
      final TextPainter tl = TextPainter(
        text: TextSpan(
          text: edgeLabels[i],
          style: TextStyle(
            color: labelColor,
            fontSize: 10,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w600,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      tl.layout(maxWidth: endX - startX);
      tl.paint(
        canvas,
        Offset(
          startX + ((endX - startX) - tl.width) / 2,
          cy - 18,
        ),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _RoundTripPainter old) {
    return old.nodeColor != nodeColor ||
        old.accentColor != accentColor ||
        old.edgeColor != edgeColor ||
        old.labelColor != labelColor ||
        old.valueLabel != valueLabel ||
        old.primitiveLabel != primitiveLabel;
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Top-level harness called once by the D4rt test runner.
// Returns a fully styled MaterialApp scroll poster.
// ─────────────────────────────────────────────────────────────────────────
dynamic build(BuildContext context) {
  // ─── Palette: indigo / teal / amber / slate ───
  const Color indigo = Color(0xFF4F46E5);
  const Color indigoDeep = Color(0xFF312E81);
  const Color indigoLight = Color(0xFFE0E7FF);
  const Color teal = Color(0xFF0D9488);
  const Color tealDeep = Color(0xFF134E4A);
  const Color tealLight = Color(0xFFCCFBF1);
  const Color amber = Color(0xFFD97706);
  const Color amberLight = Color(0xFFFEF3C7);
  const Color rose = Color(0xFFE11D48);
  const Color roseLight = Color(0xFFFFE4E6);
  const Color slate = Color(0xFF334155);
  const Color slateDeep = Color(0xFF0F172A);
  const Color slateLight = Color(0xFFE2E8F0);
  const Color paper = Color(0xFFF8FAFC);
  const Color sky = Color(0xFF0EA5E9);
  const Color skyLight = Color(0xFFE0F2FE);

  print('===== RESTORABLE VALUES DEEP VISUAL DEMO =====');

  // ─── Construct each RestorableValue subtype. ───
  // All of the following are plain Dart objects; nothing platform-level
  // C20 follow-up: `RestorableValue.value` asserts `isRegistered` in
  // debug mode (line 85 of `restoration_properties.dart`). The script's
  // original author assumed `.value` would return the in-memory default
  // pre-registration; in real Flutter the assertion fires before the
  // getter returns. This demo never wires a `RestorationMixin` and
  // never mutates the stored value, so the "current value" is
  // identical to the construction-time default everywhere. Shadow each
  // restorable with a plain variable holding the same default and read
  // those throughout the build. See `doc/interpreter_unfixable.md`
  // (U8) for the underlying Dart/Flutter behaviour and the workaround.
  const int _vInt = 42;
  const double _vDouble = 3.14;
  const bool _vBool = true;
  const String _vString = 'hello';
  const num _vNum = 7;
  final DateTime _vDateTime = DateTime(2026, 5, 11);
  const Brightness _vMood = Brightness.dark;
  const Brightness _vMoodCalm = Brightness.light;
  const int? _vIntN = null;
  const double? _vDoubleN = null;
  const bool? _vBoolN = null;
  const String? _vStringN = null;
  const num? _vNumN = null;
  final DateTime? _vDateTimeN = null;
  const Brightness? _vMoodN = null;

  final RestorableInt restInt = RestorableInt(_vInt);
  final RestorableDouble restDouble = RestorableDouble(_vDouble);
  final RestorableBool restBool = RestorableBool(_vBool);
  final RestorableString restString = RestorableString(_vString);
  final RestorableNum<num> restNum = RestorableNum<num>(_vNum);
  final RestorableDateTime restDateTime = RestorableDateTime(_vDateTime);
  final RestorableEnum<Brightness> restMood =
      RestorableEnum<Brightness>(_vMood, values: Brightness.values);

  final RestorableIntN restIntN = RestorableIntN(_vIntN);
  final RestorableDoubleN restDoubleN = RestorableDoubleN(_vDoubleN);
  final RestorableBoolN restBoolN = RestorableBoolN(_vBoolN);
  final RestorableStringN restStringN = RestorableStringN(_vStringN);
  final RestorableNumN<num?> restNumN = RestorableNumN<num?>(_vNumN);
  final RestorableDateTimeN restDateTimeN = RestorableDateTimeN(_vDateTimeN);
  final RestorableEnumN<Brightness> restMoodN = RestorableEnumN<Brightness>(
      _vMoodN,
      values: Brightness.values);

  // A second `RestorableEnum<Brightness>` used in the spotlight card to
  // show that two RestorableValues of the same type can coexist with
  // different defaults — each will be registered under its own
  // RestorationId.
  final RestorableEnum<Brightness> restMoodCalm = RestorableEnum<Brightness>(
      _vMoodCalm,
      values: Brightness.values);

  print('restInt=$_vInt restDouble=$_vDouble '
      'restBool=$_vBool restString=$_vString '
      'restNum=$_vNum restMood=$_vMood');
  print('restDateTime=$_vDateTime '
      'nullables: $_vIntN $_vDoubleN '
      '$_vBoolN $_vStringN $_vNumN '
      '$_vDateTimeN $_vMoodN');
  // `RestorableProperty.isRegistered` is `@protected`; outside a subclass
  // it can only be observed indirectly. In this static demo no property
  // has been wired to a `RestorationMixin`, so every inspector card below
  // pins it to `false`.
  const bool kIsRegistered = false;
  print('restInt is registered? (static demo) = $kIsRegistered');
  print('restMood.runtimeType    = ${restMood.runtimeType}');

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
      ),
      child: Text(
        '§$number  ·  $title',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.4,
        ),
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

  Widget infoCard(
    String heading,
    Widget content, {
    List<Color>? headerGradient,
    Color? bodyColor,
  }) {
    final List<Color> gradient =
        headerGradient ?? const <Color>[indigoDeep, indigo];
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: bodyColor ?? Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: slateLight),
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
                fontFamily: 'monospace',
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 12,
                color: slate,
                fontFamily: 'monospace',
              ),
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
    final Color a = accent ?? sky;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: slateDeep,
        borderRadius: BorderRadius.circular(10),
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
            child: Text(
              '● ● ●    $title',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.85),
                fontSize: 12,
                fontWeight: FontWeight.w600,
                fontFamily: 'monospace',
              ),
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

  Widget inspectorPill(String label, String value, Color bg, Color fg) {
    return Container(
      margin: const EdgeInsets.only(right: 8, bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(
              color: fg.withValues(alpha: 0.75),
              fontSize: 11,
              fontWeight: FontWeight.w600,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(width: 6),
          Container(
            width: 1,
            height: 12,
            color: fg.withValues(alpha: 0.30),
          ),
          const SizedBox(width: 6),
          Text(
            value,
            style: TextStyle(
              color: fg,
              fontSize: 11,
              fontWeight: FontWeight.w800,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }

  Widget inspectorRibbon({
    required String typeName,
    required String valueText,
    required String primitiveType,
    required String defaultText,
    required Color accent,
    required Color bg,
  }) {
    // Compact "ribbon" inspector — accent stripe on the left, type name above,
    // value / primitive / default text beneath as a single line.
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
        border: Border(left: BorderSide(color: accent, width: 6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            typeName,
            style: TextStyle(
              color: accent,
              fontWeight: FontWeight.w800,
              fontSize: 13,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'value: $valueText   primitive: $primitiveType   '
            'default: $defaultText',
            style: const TextStyle(
              color: slateDeep,
              fontSize: 11,
              fontWeight: FontWeight.w600,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }

  Widget keyValueInspectorCard({
    required String title,
    required String typeName,
    required String valueText,
    required String runtimeType,
    required bool isRegistered,
    required Color accent,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(9),
        border: Border.all(color: slateLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.12),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(8),
              ),
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    '●  $title',
                    style: TextStyle(
                      color: accent,
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Text(
                  isRegistered ? 'REGISTERED' : 'UNREGISTERED',
                  style: TextStyle(
                    color: isRegistered ? teal : rose,
                    fontSize: 9,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.6,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                dataRow('typeName',     typeName),
                dataRow('value',        valueText),
                dataRow('runtimeType',  runtimeType),
                dataRow('isRegistered', isRegistered.toString()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget summaryBanner(
    String left,
    String right, {
    required Color accent,
    required Color bg,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: accent.withValues(alpha: 0.40)),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 4,
            height: 22,
            decoration: BoxDecoration(
              color: accent,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              left,
              style: TextStyle(
                color: slateDeep,
                fontSize: 12,
                fontWeight: FontWeight.w700,
                fontFamily: 'monospace',
              ),
            ),
          ),
          Text(
            right,
            style: TextStyle(
              color: accent,
              fontSize: 13,
              fontWeight: FontWeight.w800,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }

  Widget tableHeaderCell(String text, {double? width}) {
    return SizedBox(
      width: width,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        decoration: BoxDecoration(
          color: indigoDeep,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.3,
            fontFamily: 'monospace',
          ),
        ),
      ),
    );
  }

  Widget tableBodyCell(String text, {double? width, Color? color}) {
    return SizedBox(
      width: width,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 8),
        decoration: BoxDecoration(
          color: color ?? Colors.white,
          border: Border(
            bottom: BorderSide(color: slateLight, width: 0.8),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: slateDeep,
            fontSize: 11,
            fontFamily: 'monospace',
          ),
        ),
      ),
    );
  }

  Widget subclassTable() {
    const double wType = 170;
    const double wDefault = 90;
    const double wPrim = 110;
    const double wNullable = 130;
    const double wEx = 220;
    final List<List<String>> rows = <List<String>>[
      <String>[
        'RestorableInt',
        '0',
        'int',
        'RestorableIntN',
        'RestorableInt(42)',
      ],
      <String>[
        'RestorableDouble',
        '0.0',
        'double',
        'RestorableDoubleN',
        'RestorableDouble(3.14)',
      ],
      <String>[
        'RestorableBool',
        'false',
        'bool',
        'RestorableBoolN',
        'RestorableBool(true)',
      ],
      <String>[
        'RestorableString',
        "''",
        'String',
        'RestorableStringN',
        "RestorableString('hi')",
      ],
      <String>[
        'RestorableNum<num>',
        'caller-supplied',
        'num',
        'RestorableNumN<num?>',
        'RestorableNum<num>(7)',
      ],
      <String>[
        'RestorableDateTime',
        'caller-supplied',
        'int (µs since epoch)',
        'RestorableDateTimeN',
        'RestorableDateTime(DateTime(2026))',
      ],
      <String>[
        'RestorableEnum<E>',
        'caller-supplied',
        'String (name)',
        'RestorableEnumN<E>',
        "RestorableEnum<E>(E.a, values: E.values)",
      ],
      <String>[
        'RestorableTextEditingController',
        'TextEditingValue.empty',
        'String',
        '— (no N variant)',
        "RestorableTextEditingController(text: '…')",
      ],
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: paper,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: slateLight),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                tableHeaderCell('Type', width: wType),
                const SizedBox(width: 4),
                tableHeaderCell('Default', width: wDefault),
                const SizedBox(width: 4),
                tableHeaderCell('Primitive', width: wPrim),
                const SizedBox(width: 4),
                tableHeaderCell('Nullable variant', width: wNullable),
                const SizedBox(width: 4),
                tableHeaderCell('Example', width: wEx),
              ],
            ),
            const SizedBox(height: 4),
            for (int i = 0; i < rows.length; i++)
              Row(
                children: <Widget>[
                  for (int j = 0; j < 5; j++) ...<Widget>[
                    if (j > 0) const SizedBox(width: 4),
                    tableBodyCell(
                      rows[i][j],
                      width: <double>[wType, wDefault, wPrim, wNullable, wEx][j],
                      color: i.isEven ? Colors.white : indigoLight,
                    ),
                  ],
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget pitfallCard(
    String title,
    String body,
    IconData icon,
    Color accent,
  ) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: accent.withValues(alpha: 0.45)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(icon, color: accent, size: 20),
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
          const SizedBox(height: 4),
          Text(
            body,
            style: TextStyle(
              fontSize: 12,
              height: 1.5,
              color: slateDeep.withValues(alpha: 0.92),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Section content builders ────────────────────────────────────────────

  Widget heroBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[indigoDeep, indigo, teal],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'RestorableValue family',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.98),
              fontSize: 22,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'A deep visual tour of Flutter state restoration primitives',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.85),
              fontSize: 13,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 14),
          Wrap(
            children: <Widget>[
              for (final String n in const <String>[
                'Int', 'Double', 'Bool', 'String',
                'Num', 'DateTime', 'Enum<E>',
              ])
                chipTag(n, indigoLight, indigoDeep),
              for (final String n in const <String>[
                'IntN', 'DoubleN', 'BoolN', 'StringN',
                'NumN', 'DateTimeN', 'EnumN<E?>',
              ])
                chipTag(n, tealLight, tealDeep),
            ],
          ),
        ],
      ),
    );
  }

  Widget introBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        proseBox(
          'State restoration is Flutter\'s answer to "the OS killed my '
          'process while it was in the background; can I bring back exactly '
          'the UI the user was looking at?" The framework persists a small, '
          'JSON-friendly blob — a RestorationBucket — alongside each '
          'RestorationScope, and rehydrates it on launch.',
          bg: indigoLight,
          border: indigo.withValues(alpha: 0.25),
        ),
        proseBox(
          'A RestorableProperty<T> is the abstract "I am a slot in that '
          'bucket" type. It owns a key (the restorationId), knows whether '
          'it has been wired up to a parent (isRegistered) and can be '
          'asked to materialize itself from primitives. RestorableValue<T> '
          'specializes RestorableProperty with a single mutable .value '
          'field, plus toPrimitives() / fromPrimitives() / didUpdateValue().',
          bg: tealLight,
          border: teal.withValues(alpha: 0.25),
        ),
        proseBox(
          'Concrete subclasses cover the JSON-primitive types directly: '
          'int, double, bool, String, num. DateTime stores its '
          'microsecondsSinceEpoch. Enum<E> stores its name. Nullable '
          'variants (suffix N) layer Object?-permissive serialization on '
          'top of the same machinery so a missing entry round-trips as '
          'null.',
          bg: amberLight,
          border: amber.withValues(alpha: 0.25),
        ),
      ],
    );
  }

  Widget anatomyDiagram() {
    return Container(
      width: double.infinity,
      height: 360,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[Colors.white, indigoLight],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: slateLight),
      ),
      child: CustomPaint(
        painter: const _AnatomyDiagramPainter(
          nodeColor: Colors.white,
          accentColor: indigo,
          edgeColor: slate,
          labelColor: slateDeep,
        ),
      ),
    );
  }

  Widget roundTripDiagram(String typeName, String primitive) {
    return Container(
      width: double.infinity,
      height: 110,
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: slateLight),
      ),
      child: CustomPaint(
        painter: _RoundTripPainter(
          nodeColor: paper,
          accentColor: indigo,
          edgeColor: slate,
          labelColor: slateDeep,
          valueLabel: typeName,
          primitiveLabel: primitive,
        ),
      ),
    );
  }

  // ─── Inspector gallery cards ───────────────────────────────────────────

  Widget inspectorGallery() {
    return Column(
      children: <Widget>[
        keyValueInspectorCard(
          title: 'restInt — RestorableInt(42)',
          typeName: 'RestorableInt',
          valueText: _vInt.toString(),
          runtimeType: restInt.runtimeType.toString(),
          isRegistered: kIsRegistered,
          accent: indigo,
        ),
        keyValueInspectorCard(
          title: 'restDouble — RestorableDouble(3.14)',
          typeName: 'RestorableDouble',
          valueText: _vDouble.toString(),
          runtimeType: restDouble.runtimeType.toString(),
          isRegistered: kIsRegistered,
          accent: teal,
        ),
        keyValueInspectorCard(
          title: 'restBool — RestorableBool(true)',
          typeName: 'RestorableBool',
          valueText: _vBool.toString(),
          runtimeType: restBool.runtimeType.toString(),
          isRegistered: kIsRegistered,
          accent: amber,
        ),
        keyValueInspectorCard(
          title: "restString — RestorableString('hello')",
          typeName: 'RestorableString',
          valueText: "'${_vString}'",
          runtimeType: restString.runtimeType.toString(),
          isRegistered: kIsRegistered,
          accent: rose,
        ),
        keyValueInspectorCard(
          title: 'restDateTime — RestorableDateTime(2026-05-11)',
          typeName: 'RestorableDateTime',
          valueText: _vDateTime.toIso8601String(),
          runtimeType: restDateTime.runtimeType.toString(),
          isRegistered: kIsRegistered,
          accent: sky,
        ),
        keyValueInspectorCard(
          title: 'restMood — RestorableEnum<Brightness>(Brightness.dark)',
          typeName: 'RestorableEnum<Brightness>',
          valueText: _vMood.toString(),
          runtimeType: restMood.runtimeType.toString(),
          isRegistered: kIsRegistered,
          accent: tealDeep,
        ),
      ],
    );
  }

  Widget ribbonGallery() {
    return Column(
      children: <Widget>[
        inspectorRibbon(
          typeName: 'RestorableInt',
          valueText: _vInt.toString(),
          primitiveType: 'int',
          defaultText: '0',
          accent: indigo,
          bg: indigoLight,
        ),
        inspectorRibbon(
          typeName: 'RestorableDouble',
          valueText: _vDouble.toString(),
          primitiveType: 'double',
          defaultText: '0.0',
          accent: teal,
          bg: tealLight,
        ),
        inspectorRibbon(
          typeName: 'RestorableBool',
          valueText: _vBool.toString(),
          primitiveType: 'bool',
          defaultText: 'false',
          accent: amber,
          bg: amberLight,
        ),
        inspectorRibbon(
          typeName: 'RestorableString',
          valueText: "'${_vString}'",
          primitiveType: 'String',
          defaultText: "''",
          accent: rose,
          bg: roseLight,
        ),
        inspectorRibbon(
          typeName: 'RestorableDateTime',
          valueText: _vDateTime.toIso8601String(),
          primitiveType: 'int (µs)',
          defaultText: '— required',
          accent: sky,
          bg: skyLight,
        ),
        inspectorRibbon(
          typeName: 'RestorableEnum<Brightness>',
          valueText: _vMood.toString(),
          primitiveType: 'String (name)',
          defaultText: '— required',
          accent: tealDeep,
          bg: tealLight,
        ),
      ],
    );
  }

  Widget nullablePillRow() {
    return Wrap(
      children: <Widget>[
        inspectorPill(
          'RestorableIntN',
          _vIntN?.toString() ?? 'null',
          indigoLight,
          indigoDeep,
        ),
        inspectorPill(
          'RestorableDoubleN',
          _vDoubleN?.toString() ?? 'null',
          tealLight,
          tealDeep,
        ),
        inspectorPill(
          'RestorableBoolN',
          _vBoolN?.toString() ?? 'null',
          amberLight,
          Color(0xFF92400E),
        ),
        inspectorPill(
          'RestorableStringN',
          _vStringN ?? 'null',
          roseLight,
          Color(0xFF881337),
        ),
        inspectorPill(
          'RestorableNumN',
          _vNumN?.toString() ?? 'null',
          skyLight,
          Color(0xFF0C4A6E),
        ),
        inspectorPill(
          'RestorableDateTimeN',
          _vDateTimeN?.toIso8601String() ?? 'null',
          indigoLight,
          indigoDeep,
        ),
        inspectorPill(
          'RestorableEnumN',
          _vMoodN?.toString() ?? 'null',
          tealLight,
          tealDeep,
        ),
      ],
    );
  }

  Widget primitiveRoundTripGallery() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Text(
            'RestorableInt  →  int',
            style: TextStyle(
              color: slateDeep,
              fontSize: 12,
              fontWeight: FontWeight.w800,
              fontFamily: 'monospace',
            ),
          ),
        ),
        roundTripDiagram('${_vInt}', 'int  42'),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Text(
            'RestorableDateTime  →  int µs',
            style: TextStyle(
              color: slateDeep,
              fontSize: 12,
              fontWeight: FontWeight.w800,
              fontFamily: 'monospace',
            ),
          ),
        ),
        roundTripDiagram(
          '2026-05-11',
          '${_vDateTime.microsecondsSinceEpoch}',
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Text(
            'RestorableEnum<Brightness>  →  String name',
            style: TextStyle(
              color: slateDeep,
              fontSize: 12,
              fontWeight: FontWeight.w800,
              fontFamily: 'monospace',
            ),
          ),
        ),
        roundTripDiagram('Brightness.dark', "'dark'"),
      ],
    );
  }

  Widget moodEnumCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: slateLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: tealDeep,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  'enum',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Brightness',
                style: TextStyle(
                  color: tealDeep,
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'monospace',
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'index → primitive',
                style: TextStyle(
                  color: slate.withValues(alpha: 0.70),
                  fontSize: 11,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Wrap(
            children: <Widget>[
              for (final Brightness m in Brightness.values)
                chipTag(
                  m.name,
                  m == _vMood ? teal : tealLight,
                  m == _vMood ? Colors.white : tealDeep,
                ),
            ],
          ),
          const SizedBox(height: 8),
          dataRow('values.length', Brightness.values.length.toString()),
          dataRow('current',       _vMood.toString()),
          dataRow('current.index', _vMood.index.toString()),
          dataRow('current.name',  _vMood.name),
          dataRow('alt (calm)',    _vMoodCalm.toString()),
          dataRow('nullable (N)',  _vMoodN?.toString() ?? 'null'),
        ],
      ),
    );
  }

  Widget pitfallsList() {
    return Column(
      children: <Widget>[
        pitfallCard(
          'Forgetting to register the property',
          'Calling registerForRestoration() outside restoreState() leaves '
          'the property unregistered. Reads still return the default; '
          'writes silently bypass the bucket. The diagnostic '
          'isRegistered == false is the first thing to check.',
          Icons.power_off_outlined,
          rose,
        ),
        pitfallCard(
          'RestorationId clashes',
          'Two RestorableValues registered under the same id on the same '
          'bucket throw at register time. Conventionally, prefix the id '
          'with the State class name and field name (e.g. "_counter").',
          Icons.error_outline,
          amber,
        ),
        pitfallCard(
          'Mismatched defaultValue types',
          'RestorableEnum<E> must be given the same values list across '
          'launches; renaming an enum constant or removing one will '
          'cause fromPrimitives() to fall back to the default. Treat the '
          'enum names as schema, not implementation detail.',
          Icons.warning_amber_outlined,
          indigo,
        ),
        pitfallCard(
          'Listener leaks',
          'RestorableValue extends ChangeNotifier. Each addListener() must '
          'be paired with removeListener() in dispose(). The mixin disposes '
          'its registered properties for you — anything you keep outside '
          'the mixin is on you.',
          Icons.battery_alert_outlined,
          teal,
        ),
        pitfallCard(
          'Non-primitive values',
          'toPrimitives() must return one of: bool, num, String, List, Map '
          'of those, or null. Custom encoders should compress to JSON-safe '
          'types — anything else triggers an assert when persisting.',
          Icons.dangerous_outlined,
          rose,
        ),
      ],
    );
  }

  Widget codeSamples() {
    return Column(
      children: <Widget>[
        codeSnippetCard(
          'counter.dart  —  basic RestorableInt',
          '''class _CounterState extends State<Counter>
    with RestorationMixin {
  final RestorableInt _count = RestorableInt(0);

  @override
  String get restorationId => 'counter';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initial) {
    registerForRestoration(_count, 'count');
  }

  @override
  void dispose() {
    _count.dispose();
    super.dispose();
  }
}''',
          accent: indigo,
        ),
        codeSnippetCard(
          'theme.dart  —  RestorableBool toggle',
          '''final RestorableBool _dark = RestorableBool(false);

@override
void restoreState(RestorationBucket? old, bool initial) {
  registerForRestoration(_dark, 'isDarkMode');
}

void toggle() => _dark.value = !_dark.value;''',
          accent: teal,
        ),
        codeSnippetCard(
          'profile.dart  —  RestorableString + RestorableDateTime',
          '''final RestorableString _name =
    RestorableString('');
final RestorableDateTime _born =
    RestorableDateTime(DateTime(2000, 1, 1));

@override
void restoreState(RestorationBucket? old, bool initial) {
  registerForRestoration(_name, 'displayName');
  registerForRestoration(_born, 'birthday');
}''',
          accent: amber,
        ),
        codeSnippetCard(
          'mood.dart  —  RestorableEnum<_Mood>',
          '''final RestorableEnum<_Mood> _mood =
    RestorableEnum<_Mood>(_Mood.calm, values: _Mood.values);

@override
void restoreState(RestorationBucket? old, bool initial) {
  registerForRestoration(_mood, 'mood');
}

void pick(_Mood m) => _mood.value = m;''',
          accent: tealDeep,
        ),
        codeSnippetCard(
          'optional.dart  —  nullable variants',
          '''final RestorableIntN _scoreOrNull = RestorableIntN(null);
final RestorableStringN _draftOrNull =
    RestorableStringN(null);
final RestorableDateTimeN _seenOrNull =
    RestorableDateTimeN(null);

@override
void restoreState(RestorationBucket? old, bool initial) {
  registerForRestoration(_scoreOrNull, 'score');
  registerForRestoration(_draftOrNull, 'draft');
  registerForRestoration(_seenOrNull, 'lastSeen');
}''',
          accent: rose,
        ),
      ],
    );
  }

  Widget summaryFooter() {
    final int registered = <RestorableProperty<Object?>>[
      restInt, restDouble, restBool, restString,
      restNum, restDateTime, restMood,
      restIntN, restDoubleN, restBoolN, restStringN,
      restNumN, restDateTimeN, restMoodN,
    ].where((RestorableProperty<Object?> p) => kIsRegistered).length;
    final int total = 14;
    return Column(
      children: <Widget>[
        summaryBanner(
          'properties constructed',
          '$total',
          accent: indigo,
          bg: indigoLight,
        ),
        summaryBanner(
          'isRegistered == true',
          '$registered  /  $total',
          accent: teal,
          bg: tealLight,
        ),
        summaryBanner(
          'restDateTime µs',
          '${_vDateTime.microsecondsSinceEpoch}',
          accent: sky,
          bg: skyLight,
        ),
        summaryBanner(
          'restMood.name',
          _vMood.name,
          accent: amber,
          bg: amberLight,
        ),
      ],
    );
  }

  // ─── Build the poster ───────────────────────────────────────────────────

  print('build: assembling scroll poster sections');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'RestorableValue family deep visual demo',
    home: Scaffold(
      backgroundColor: paper,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              heroBanner(),
              sectionBanner(
                '1',
                'What is state restoration?',
                const <Color>[indigoDeep, indigo],
              ),
              introBody(),
              sectionBanner(
                '2',
                'Restoration anatomy diagram',
                const <Color>[indigo, teal],
              ),
              infoCard(
                'RestorationScope → … → fromPrimitives()',
                anatomyDiagram(),
                headerGradient: const <Color>[indigo, teal],
              ),
              proseBox(
                'Each step in the diagram is a public type in '
                'package:flutter/services.dart or package:flutter/widgets.dart. '
                'The arrows mark ownership: a RestorationBucket owns its '
                'entries, a RestorationMixin owns its RestorableProperty '
                'instances, and a RestorableValue<T> owns exactly one T.',
                bg: indigoLight,
                border: indigo.withValues(alpha: 0.25),
              ),
              sectionBanner(
                '3',
                'Subclass table',
                const <Color>[indigoDeep, teal],
              ),
              subclassTable(),
              proseBox(
                'The "Primitive" column is what toPrimitives() returns. '
                'For DateTime that\'s the int microsecondsSinceEpoch; for '
                'an enum, the String name. Anything stored in a bucket '
                'must round-trip through JSON, so the framework guarantees '
                'these subclasses are persistence-friendly.',
                bg: amberLight,
                border: amber.withValues(alpha: 0.25),
              ),
              sectionBanner(
                '5',
                'Static state inspector gallery',
                const <Color>[teal, tealDeep],
              ),
              inspectorGallery(),
              sectionBanner(
                '6',
                'Inspector ribbons (typed)',
                const <Color>[indigo, indigoDeep],
              ),
              ribbonGallery(),
              sectionBanner(
                '7',
                'Nullable variants pill row',
                const <Color>[amber, Color(0xFF92400E)],
              ),
              infoCard(
                'RestorableXN — value or null',
                Wrap(children: <Widget>[nullablePillRow()]),
                headerGradient: const <Color>[amber, Color(0xFF92400E)],
              ),
              proseBox(
                'Each nullable property is constructed with null. The '
                'getter returns null because no parent bucket has yet '
                'pushed a primitive into it. After registration with a '
                'RestorationMixin, the bucket either retains null (first '
                'launch) or restores the previously-serialized value.',
                bg: amberLight,
                border: amber.withValues(alpha: 0.25),
              ),
              sectionBanner(
                '8',
                'Primitives round-trip',
                const <Color>[indigoDeep, indigo],
              ),
              infoCard(
                'value → toPrimitives() → bucket → fromPrimitives() → value',
                primitiveRoundTripGallery(),
                headerGradient: const <Color>[indigoDeep, indigo],
              ),
              sectionBanner(
                '9',
                'RestorableEnum<Brightness> spotlight',
                const <Color>[tealDeep, teal],
              ),
              moodEnumCard(),
              proseBox(
                'RestorableEnum<E> is the only RestorableValue subclass '
                'that demands a values list at construction. The list is '
                'used by fromPrimitives() to look an enum constant up by '
                'name. Reordering the enum without renaming is safe; '
                'renaming a constant invalidates persisted state for that '
                'field.',
                bg: tealLight,
                border: teal.withValues(alpha: 0.30),
              ),
              sectionBanner(
                '10',
                'Idiomatic code samples',
                const <Color>[slateDeep, indigo],
              ),
              codeSamples(),
              sectionBanner(
                '11',
                'Pitfalls',
                const <Color>[rose, Color(0xFF881337)],
              ),
              pitfallsList(),
              sectionBanner(
                '12',
                'Summary',
                const <Color>[indigoDeep, teal],
              ),
              summaryFooter(),
              const SizedBox(height: 18),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: <Color>[slateDeep, indigoDeep],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '— End of RestorableValue family deep visual demo —\n'
                  'tom_d4rt_flutter_ast / send_ast_via_http_scripts / '
                  'widgets / restorable_values_test.dart',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.92),
                    fontSize: 11,
                    height: 1.6,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Sentinels touching `dart:math`, `dart:ui`, and `services`
              // imports so the analyzer sees every imported library used.
              Text(
                'sentinel: dart:math.pi=${math.pi.toStringAsFixed(4)}  '
                'ui.PointMode.points=${ui.PointMode.points}  '
                'services.SystemUiOverlay.top='
                '${SystemUiOverlay.top}  '
                'foundation.kDebugMode=$kDebugMode  '
                'painting.BoxFit.cover=${BoxFit.cover}  '
                'rendering.HitTestBehavior.opaque='
                '${HitTestBehavior.opaque}  '
                'widgets.Directionality.maybeOf=ok',
                style: TextStyle(
                  color: slate.withValues(alpha: 0.50),
                  fontSize: 9,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
