// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unused_element, unused_element_parameter, dead_code, unnecessary_import, no_leading_underscores_for_local_identifiers, prefer_const_constructors, prefer_const_literals_to_create_immutables
// D4rt test script: Deep visual demo of the Cupertino picker family,
// focusing on `CupertinoPickerDefaultSelectionOverlay` and the three
// real pickers that compose with it - `CupertinoPicker`,
// `CupertinoDatePicker` and `CupertinoTimerPicker`.
//
// This script is part of the D4rt flutter-test corpus. It runs inside
// a sandboxed, analyzer-free Dart interpreter and exposes a single
// top-level entry point - `dynamic build(BuildContext context)` -
// which is invoked once and returns a Widget tree.
//
// The rendered output is a long, static gallery that walks through the
// `flutter/cupertino` picker stack, namely:
//
//   * `CupertinoPickerDefaultSelectionOverlay` - the rounded band
//     drawn behind the selected row, with three knobs: `background`,
//     `capStartEdge` and `capEndEdge`.
//   * `CupertinoPicker`                        - the wheel widget that
//     renders rows using a ListWheelScrollView under the hood. Surface
//     parameters: `itemExtent`, `magnification`, `useMagnifier`,
//     `diameterRatio`, `squeeze`, `offAxisFraction`, `backgroundColor`,
//     `looping`, `selectionOverlay`, `scrollController`.
//   * `CupertinoDatePicker`                    - composes 2-3 picker
//     wheels for `dateAndTime`, `date`, `time` and `monthYear` modes.
//   * `CupertinoTimerPicker`                   - composes 2-3 picker
//     wheels for `hms`, `hm` and `ms` modes plus `minuteInterval` and
//     `secondInterval` snap grids.
//   * `FixedExtentScrollController`            - the controller used to
//     seed `initialItem` so a meaningful row is highlighted without
//     any callback being fired.
//   * `FixedExtentScrollPhysics`               - the physics that snaps
//     to a row when the user releases a drag.
//
// Each section is followed by a code block illustrating idiomatic
// usage, a comparison table that pairs picker variants with their
// modes / parameters, a pitfalls panel with seven callouts and finally
// a cheat-sheet footer. Because the script runs in a static, no-
// interaction environment, every callback is either `null` (disabled
// state) or `(_) {}` (a no-op consumer). No `setState`, `Timer`,
// `Future`, `Stream`, `async`, live `AnimationController` or
// `Tween.animate(...).value` reads occur anywhere in this file.
import 'dart:math' as math;
import 'dart:ui' show FontFeature;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

// ---------------------------------------------------------------------------
// COLOR & TYPOGRAPHY CONSTANTS
// ---------------------------------------------------------------------------
// As with the rest of the corpus, the demo mixes chrome-level Color
// literals (cards, dividers, code blocks) with `CupertinoColors.*`
// references resolved against `context` in the build entry point.
// Cap edges are emphasized by drawing them in `_kAccentIndigo` so the
// reader can see the `capStartEdge` / `capEndEdge` parameters visually.

const Color _kCanvas = Color(0xFFF2F2F7);
const Color _kCardBg = Color(0xFFFFFFFF);
const Color _kCardDark = Color(0xFF1C1C1E);
const Color _kHairline = Color(0x14000000);
const Color _kHairlineDark = Color(0x33FFFFFF);
const Color _kInk = Color(0xFF1C1C1E);
const Color _kInkSecondary = Color(0xFF3C3C43);
const Color _kInkTertiary = Color(0xFF8E8E93);
const Color _kInkOnDark = Color(0xFFEDEDF0);
const Color _kInkOnDarkSecondary = Color(0xFFA1A1A6);
const Color _kAccent = Color(0xFF007AFF);
const Color _kAccentGreen = Color(0xFF34C759);
const Color _kAccentOrange = Color(0xFFFF9500);
const Color _kAccentRed = Color(0xFFFF3B30);
const Color _kAccentIndigo = Color(0xFF5856D6);
const Color _kAccentPurple = Color(0xFFAF52DE);
const Color _kAccentPink = Color(0xFFFF2D55);
const Color _kAccentTeal = Color(0xFF30B0C7);
const Color _kAccentYellow = Color(0xFFFFCC00);
const Color _kCodeBg = Color(0xFF1E1F22);
const Color _kCodeText = Color(0xFFE6E6E6);
const Color _kCodeAccent = Color(0xFF7DD3FC);
const Color _kCodeKeyword = Color(0xFFFFA657);
const Color _kCodeString = Color(0xFFA5D6A7);
const Color _kCodeComment = Color(0xFF6E7681);
const Color _kCodeType = Color(0xFFF9C8C2);
const Color _kBandFill = Color(0x14787880); // CupertinoColors.tertiarySystemFill
const Color _kBandStroke = Color(0x335856D6);

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
const TextStyle _kMonoTiny = TextStyle(
  fontSize: 10.5,
  fontFamily: 'monospace',
  fontFeatures: <FontFeature>[FontFeature.tabularFigures()],
  color: _kInkSecondary,
);
const TextStyle _kMonoBody = TextStyle(
  fontSize: 12.0,
  fontFamily: 'monospace',
  fontFeatures: <FontFeature>[FontFeature.tabularFigures()],
  color: _kInk,
  height: 1.45,
);
const TextStyle _kSectionHeader = TextStyle(
  fontSize: 17.0,
  fontWeight: FontWeight.w700,
  color: _kInk,
  letterSpacing: -0.2,
);

// ---------------------------------------------------------------------------
// ENTRY POINT
// ---------------------------------------------------------------------------
// The single top-level `build` function returns a static `CupertinoApp`
// configured for light mode. All scrollable content is wrapped in a
// `ListView` with `physics: const ClampingScrollPhysics()` so the demo
// looks the same on every platform.

dynamic build(BuildContext context) {
  return CupertinoApp(
    title: 'CupertinoPickerDefaultSelectionOverlay Deep Demo',
    debugShowCheckedModeBanner: false,
    theme: const CupertinoThemeData(
      brightness: Brightness.light,
      primaryColor: _kAccentIndigo,
      scaffoldBackgroundColor: _kCanvas,
    ),
    home: CupertinoPageScaffold(
      backgroundColor: _kCanvas,
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Cupertino Picker Family'),
        backgroundColor: Color(0xF8F8F8FA),
        border: Border(
          bottom: BorderSide(color: _kHairline, width: 0.5),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: ListView(
          physics: const ClampingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
          children: <Widget>[
            _buildHeroSection(),
            _buildIntroCard(),
            _buildOverlayAnatomySection(),
            _buildParameterTableSection(),
            _buildPickerVariantsGallery(),
            _buildDatePickerViewportSection(),
            _buildTimerPickerViewportSection(),
            _buildMagnificationVisualizationSection(),
            _buildLoopingAndPhysicsSection(),
            _buildRecipeCardsSection(),
            _buildPitfallsSection(),
            _buildCheatSheetFooter(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// HERO SECTION
// ---------------------------------------------------------------------------

Widget _buildHeroSection() {
  return Container(
    margin: const EdgeInsets.only(bottom: 20),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          Color(0xFF5E5CE6),
          Color(0xFFAF52DE),
          Color(0xFFFF2D55),
        ],
      ),
      borderRadius: BorderRadius.circular(24),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x405E5CE6),
          blurRadius: 32,
          offset: Offset(0, 16),
        ),
        BoxShadow(
          color: Color(0x33FF2D55),
          blurRadius: 18,
          offset: Offset(0, 6),
        ),
      ],
    ),
    padding: const EdgeInsets.fromLTRB(24, 28, 24, 28),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: const <Widget>[
            _HeroBadge(
              icon: CupertinoIcons.slider_horizontal_3,
              label: 'PICKER FAMILY',
            ),
            Spacer(),
            Icon(
              CupertinoIcons.sparkles,
              color: Color(0xFFFFFFFF),
              size: 28,
            ),
          ],
        ),
        const SizedBox(height: 18),
        const Text(
          'Default Selection Overlay',
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 32,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.8,
            height: 1.05,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'CupertinoPickerDefaultSelectionOverlay + CupertinoPicker + '
          'CupertinoDatePicker + CupertinoTimerPicker',
          style: TextStyle(
            color: Color(0xE6FFFFFF),
            fontSize: 14,
            fontWeight: FontWeight.w500,
            height: 1.35,
          ),
        ),
        const SizedBox(height: 22),
        Row(
          children: const <Widget>[
            _HeroMetric(value: '4', label: 'pickers'),
            SizedBox(width: 12),
            _HeroMetric(value: '11', label: 'knobs'),
            SizedBox(width: 12),
            _HeroMetric(value: '3', label: 'caps'),
            SizedBox(width: 12),
            _HeroMetric(value: '9', label: 'sections'),
          ],
        ),
      ],
    ),
  );
}

class _HeroBadge extends StatelessWidget {
  const _HeroBadge({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0x33FFFFFF),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0x55FFFFFF), width: 0.6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, color: const Color(0xFFFFFFFF), size: 14),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.0,
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroMetric extends StatelessWidget {
  const _HeroMetric({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0x22FFFFFF),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0x44FFFFFF), width: 0.6),
        ),
        child: Column(
          children: <Widget>[
            Text(
              value,
              style: const TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 20,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.2,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: const TextStyle(
                color: Color(0xCCFFFFFF),
                fontSize: 10,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// INTRO CARD
// ---------------------------------------------------------------------------

Widget _buildIntroCard() {
  return _Card(
    title: 'Why a separate overlay widget?',
    subtitle:
        'CupertinoPickerDefaultSelectionOverlay isolates the rounded band so '
        'you can swap, recolor or remove it without touching the wheel.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'A picker is composed of three independent layers:\n'
          '  1. The wheel (CupertinoPicker / CupertinoDatePicker / CupertinoTimerPicker).\n'
          '  2. The selection band (CupertinoPickerDefaultSelectionOverlay).\n'
          '  3. The magnifier glass (a magnification > 1.0 applied to the centre row).\n'
          '\n'
          'The overlay widget is just a Container with rounded corners, so any\n'
          'StatelessWidget that renders something behind the centre row will work\n'
          'as a replacement.',
          style: _kBodyStyle,
        ),
        const SizedBox(height: 12),
        const _CodeBlock(
          lines: <_CodeLine>[
            _CodeLine.comment('// minimal selectionOverlay usage'),
            _CodeLine.keyword('const ', plain: 'CupertinoPicker('),
            _CodeLine.plain('  itemExtent: 32,'),
            _CodeLine.plain('  onSelectedItemChanged: null,'),
            _CodeLine.plain('  selectionOverlay: '),
            _CodeLine.type('  CupertinoPickerDefaultSelectionOverlay'),
            _CodeLine.plain('  (),'),
            _CodeLine.plain('  children: <Widget>[],'),
            _CodeLine.plain(');'),
          ],
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 1: OVERLAY ANATOMY WITH CAP EDGES DIAGRAM
// ---------------------------------------------------------------------------

Widget _buildOverlayAnatomySection() {
  return _Card(
    title: '1. Overlay anatomy',
    subtitle:
        'The selection overlay is a rounded pill behind the centre row. Two '
        'knobs decide which corners are rounded: capStartEdge and capEndEdge.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _SubHeader('Schematic'),
        const SizedBox(height: 6),
        SizedBox(
          height: 200,
          child: CustomPaint(
            painter: _OverlayAnatomyPainter(),
          ),
        ),
        const SizedBox(height: 16),
        const _SubHeader('Cap edges, all four combinations'),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: _OverlayMiniPreview(
                title: 'both true (default)',
                capStart: true,
                capEnd: true,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _OverlayMiniPreview(
                title: 'start only',
                capStart: true,
                capEnd: false,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: _OverlayMiniPreview(
                title: 'end only',
                capStart: false,
                capEnd: true,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _OverlayMiniPreview(
                title: 'both false',
                capStart: false,
                capEnd: false,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        const _SubHeader('Background colours'),
        const SizedBox(height: 8),
        Row(
          children: <Widget>[
            Expanded(
              child: _OverlayMiniPreview(
                title: 'tertiarySystemFill',
                capStart: true,
                capEnd: true,
                background: _kBandFill,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _OverlayMiniPreview(
                title: 'systemIndigo 15%',
                capStart: true,
                capEnd: true,
                background: Color(0x265856D6),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _OverlayMiniPreview(
                title: 'systemRed 12%',
                capStart: true,
                capEnd: true,
                background: Color(0x1FFF3B30),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const _CodeBlock(
          lines: <_CodeLine>[
            _CodeLine.comment('// chunky pill - default everywhere'),
            _CodeLine.type('CupertinoPickerDefaultSelectionOverlay', plain: '('),
            _CodeLine.plain('  background: CupertinoColors.tertiarySystemFill,'),
            _CodeLine.plain('  capStartEdge: true,'),
            _CodeLine.plain('  capEndEdge: true,'),
            _CodeLine.plain(');'),
            _CodeLine.comment('// flush pill - used inside a date picker column'),
            _CodeLine.type('CupertinoPickerDefaultSelectionOverlay', plain: '('),
            _CodeLine.plain('  capStartEdge: false,'),
            _CodeLine.plain('  capEndEdge: true,'),
            _CodeLine.plain(');'),
          ],
        ),
      ],
    ),
  );
}

class _OverlayMiniPreview extends StatelessWidget {
  const _OverlayMiniPreview({
    required this.title,
    required this.capStart,
    required this.capEnd,
    this.background = _kBandFill,
  });

  final String title;
  final bool capStart;
  final bool capEnd;
  final Color background;

  @override
  Widget build(BuildContext context) {
    final BorderRadius radius = BorderRadius.horizontal(
      left: capStart ? const Radius.circular(8) : Radius.zero,
      right: capEnd ? const Radius.circular(8) : Radius.zero,
    );
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFC),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kHairline, width: 0.6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              fontSize: 10.5,
              fontWeight: FontWeight.w700,
              color: _kInkSecondary,
            ),
          ),
          const SizedBox(height: 6),
          SizedBox(
            height: 56,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text('Row 1',
                        style: TextStyle(
                            fontSize: 11, color: _kInkTertiary)),
                    Text('Row 2',
                        style: TextStyle(
                            fontSize: 13,
                            color: _kInk,
                            fontWeight: FontWeight.w700)),
                    Text('Row 3',
                        style: TextStyle(
                            fontSize: 11, color: _kInkTertiary)),
                  ],
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: 22,
                  height: 16,
                  child: Container(
                    decoration: BoxDecoration(
                      color: background,
                      borderRadius: radius,
                      border: Border.all(
                        color: _kBandStroke,
                        width: 0.6,
                      ),
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

class _OverlayAnatomyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint cardPaint = Paint()..color = const Color(0xFFFAFAFC);
    final RRect card = RRect.fromRectAndRadius(
      Rect.fromLTWH(8, 8, size.width - 16, size.height - 16),
      const Radius.circular(12),
    );
    canvas.drawRRect(card, cardPaint);
    canvas.drawRRect(
      card,
      Paint()
        ..style = PaintingStyle.stroke
        ..color = _kHairline
        ..strokeWidth = 0.6,
    );

    // Wheel ghost rows
    final TextPainter tp = TextPainter(
      textDirection: TextDirection.ltr,
    );
    final List<String> rows = <String>[
      'January',
      'February',
      'March',
      'April',
      'May',
    ];
    final double rowHeight = (size.height - 16) / 5;
    for (int i = 0; i < rows.length; i++) {
      final double t = (i - 2).abs() / 2.0;
      final Color colour = Color.lerp(_kInk, _kInkTertiary, t)!;
      final double fontSize = i == 2 ? 17.0 : 13.0 - t * 1.5;
      tp.text = TextSpan(
        text: rows[i],
        style: TextStyle(
          fontSize: fontSize,
          color: colour,
          fontWeight: i == 2 ? FontWeight.w700 : FontWeight.w500,
        ),
      );
      tp.layout(maxWidth: size.width - 32);
      tp.paint(
        canvas,
        Offset((size.width - tp.width) / 2, 8 + rowHeight * i + 4),
      );
    }

    // Selection band
    final double bandTop = 8 + rowHeight * 2;
    final Rect bandRect = Rect.fromLTWH(
      16,
      bandTop + 2,
      size.width - 32,
      rowHeight - 4,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(bandRect, const Radius.circular(8)),
      Paint()..color = _kBandFill,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(bandRect, const Radius.circular(8)),
      Paint()
        ..style = PaintingStyle.stroke
        ..color = _kBandStroke
        ..strokeWidth = 0.8,
    );

    // Cap edge annotations
    final Paint arrowPaint = Paint()
      ..color = _kAccentIndigo
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;
    // Left cap
    canvas.drawLine(
      Offset(bandRect.left, bandRect.center.dy),
      Offset(bandRect.left - 6, bandRect.center.dy),
      arrowPaint,
    );
    // Right cap
    canvas.drawLine(
      Offset(bandRect.right, bandRect.center.dy),
      Offset(bandRect.right + 6, bandRect.center.dy),
      arrowPaint,
    );

    tp.text = const TextSpan(
      text: 'capStartEdge',
      style: TextStyle(
        fontSize: 10,
        color: _kAccentIndigo,
        fontWeight: FontWeight.w700,
      ),
    );
    tp.layout();
    tp.paint(canvas, Offset(8, bandRect.center.dy - tp.height - 4));

    tp.text = const TextSpan(
      text: 'capEndEdge',
      style: TextStyle(
        fontSize: 10,
        color: _kAccentIndigo,
        fontWeight: FontWeight.w700,
      ),
    );
    tp.layout();
    tp.paint(
      canvas,
      Offset(size.width - tp.width - 8, bandRect.center.dy - tp.height - 4),
    );

    // background label
    tp.text = const TextSpan(
      text: 'background',
      style: TextStyle(
        fontSize: 10,
        color: _kInkSecondary,
        fontWeight: FontWeight.w700,
      ),
    );
    tp.layout();
    tp.paint(canvas, Offset(size.width / 2 - tp.width / 2, bandRect.bottom + 4));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ---------------------------------------------------------------------------
// SECTION 2: PARAMETER TABLE
// ---------------------------------------------------------------------------

Widget _buildParameterTableSection() {
  return _Card(
    title: '2. CupertinoPicker parameter table',
    subtitle:
        'Every CupertinoPicker knob, what it controls, the default and a '
        'sensible range for tuning.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _ParamTableHeader(),
        const _ParamRow(
          name: 'itemExtent',
          type: 'double',
          defaultValue: 'required',
          description:
              'Row height in logical pixels. Determines wheel cadence; '
              'iOS native is around 32.',
        ),
        const _ParamRow(
          name: 'onSelectedItemChanged',
          type: 'ValueChanged<int>?',
          defaultValue: 'null',
          description:
              'Fired when scroll settles on a new row. Pass null to disable '
              'changes, or (_) {} as a no-op in static demos.',
        ),
        const _ParamRow(
          name: 'children',
          type: 'List<Widget>',
          defaultValue: 'required',
          description:
              'The row widgets to display. For a builder approach use '
              'CupertinoPicker.builder.',
        ),
        const _ParamRow(
          name: 'magnification',
          type: 'double',
          defaultValue: '1.0',
          description:
              'Scale factor for the centre row. 1.0 disables magnification. '
              'iOS uses around 1.08.',
        ),
        const _ParamRow(
          name: 'useMagnifier',
          type: 'bool',
          defaultValue: 'false',
          description:
              'When true, draws a square magnifier glass over the centre '
              'row. Combine with magnification > 1.0.',
        ),
        const _ParamRow(
          name: 'diameterRatio',
          type: 'double',
          defaultValue: '1.07',
          description:
              'Wheel-to-screen diameter ratio. Lower => steeper curve; '
              'higher => flatter wheel.',
        ),
        const _ParamRow(
          name: 'squeeze',
          type: 'double',
          defaultValue: '1.45',
          description:
              'How tightly visible rows are packed. > 1.0 squeezes rows '
              'closer together.',
        ),
        const _ParamRow(
          name: 'offAxisFraction',
          type: 'double',
          defaultValue: '0.0',
          description:
              'Tilt of the wheel along the horizontal axis. Negative leans '
              'left, positive leans right.',
        ),
        const _ParamRow(
          name: 'backgroundColor',
          type: 'Color?',
          defaultValue: 'null',
          description:
              'Fill drawn behind the wheel. Use null for transparent so '
              'a CupertinoFormSection or sheet shows through.',
        ),
        const _ParamRow(
          name: 'looping',
          type: 'bool',
          defaultValue: 'false',
          description:
              'When true, the wheel wraps around endlessly. Disabled by '
              'default for accessibility.',
        ),
        const _ParamRow(
          name: 'scrollController',
          type: 'FixedExtentScrollController?',
          defaultValue: 'null',
          description:
              'Externally owned controller; pass one with initialItem to '
              'seed the selection.',
        ),
        const _ParamRow(
          name: 'selectionOverlay',
          type: 'Widget?',
          defaultValue: 'CupertinoPickerDefaultSelectionOverlay()',
          description:
              'Behind-centre-row decoration. Pass null to remove the band '
              'entirely.',
        ),
        const SizedBox(height: 16),
        const _SubHeader('FixedExtentScrollController knobs'),
        const SizedBox(height: 6),
        const _ParamTableHeader(),
        const _ParamRow(
          name: 'initialItem',
          type: 'int',
          defaultValue: '0',
          description:
              'Index that should be centred when the picker first builds.',
        ),
        const _ParamRow(
          name: 'selectedItem',
          type: 'int (getter)',
          defaultValue: '-',
          description:
              'Read the currently selected index from the controller.',
        ),
        const _ParamRow(
          name: 'jumpToItem(int)',
          type: 'void',
          defaultValue: '-',
          description:
              'Instant teleport to an index. No animation, no callbacks.',
        ),
        const _ParamRow(
          name: 'animateToItem(...)',
          type: 'Future<void>',
          defaultValue: '-',
          description:
              'Smooth scroll to an index. Not used in this static demo.',
        ),
      ],
    ),
  );
}

class _ParamTableHeader extends StatelessWidget {
  const _ParamTableHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: const BoxDecoration(
        color: Color(0xFFF5F5F7),
        borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
      ),
      child: Row(
        children: const <Widget>[
          Expanded(
            flex: 4,
            child: Text('parameter', style: _kParamHeaderStyle),
          ),
          Expanded(
            flex: 3,
            child: Text('type', style: _kParamHeaderStyle),
          ),
          Expanded(
            flex: 3,
            child: Text('default', style: _kParamHeaderStyle),
          ),
        ],
      ),
    );
  }
}

const TextStyle _kParamHeaderStyle = TextStyle(
  fontSize: 10.5,
  color: _kInkTertiary,
  fontWeight: FontWeight.w700,
  letterSpacing: 0.4,
);

class _ParamRow extends StatelessWidget {
  const _ParamRow({
    required this.name,
    required this.type,
    required this.defaultValue,
    required this.description,
  });

  final String name;
  final String type;
  final String defaultValue;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: _kHairline, width: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Text(
                  name,
                  style: const TextStyle(
                    fontSize: 12.5,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w700,
                    color: _kInk,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  type,
                  style: const TextStyle(
                    fontSize: 11,
                    fontFamily: 'monospace',
                    color: _kAccentIndigo,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  defaultValue,
                  style: const TextStyle(
                    fontSize: 11,
                    fontFamily: 'monospace',
                    color: _kAccentOrange,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.only(left: 2),
            child: Text(
              description,
              style: const TextStyle(
                fontSize: 12,
                color: _kInkSecondary,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 3: PICKER VARIANTS GALLERY (3D WHEEL CUSTOM PAINTER)
// ---------------------------------------------------------------------------

Widget _buildPickerVariantsGallery() {
  return _Card(
    title: '3. Picker variants gallery',
    subtitle:
        'A static 3D wheel painter side-by-side with three real, non-'
        'scrolling CupertinoPickers. Each picker is fed a fresh '
        'FixedExtentScrollController so a meaningful row is centred.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _SubHeader('Static 3D wheel (CustomPaint)'),
        const SizedBox(height: 8),
        SizedBox(
          height: 220,
          child: CustomPaint(
            painter: _WheelPainter(items: <String>[
              'Mountain View',
              'Cupertino',
              'San Francisco',
              'Palo Alto',
              'Mountain View',
              'Cupertino',
              'San Francisco',
            ], selected: 3),
          ),
        ),
        const SizedBox(height: 16),
        const _SubHeader('Real CupertinoPicker - default'),
        const SizedBox(height: 6),
        _PickerCard(
          caption: 'itemExtent 32, magnification 1.0, useMagnifier false',
          picker: CupertinoPicker(
            itemExtent: 32,
            onSelectedItemChanged: (int _) {},
            scrollController: FixedExtentScrollController(initialItem: 2),
            children: const <Widget>[
              Center(child: Text('Apple')),
              Center(child: Text('Banana')),
              Center(child: Text('Cherry')),
              Center(child: Text('Date')),
              Center(child: Text('Elderberry')),
              Center(child: Text('Fig')),
              Center(child: Text('Grape')),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const _SubHeader('Real CupertinoPicker - magnified'),
        const SizedBox(height: 6),
        _PickerCard(
          caption: 'magnification 1.12, useMagnifier true, squeeze 1.25',
          picker: CupertinoPicker(
            itemExtent: 36,
            magnification: 1.12,
            useMagnifier: true,
            squeeze: 1.25,
            backgroundColor: const Color(0xFFFAFAFC),
            onSelectedItemChanged: (int _) {},
            scrollController: FixedExtentScrollController(initialItem: 4),
            selectionOverlay: const CupertinoPickerDefaultSelectionOverlay(
              background: Color(0x265856D6),
            ),
            children: const <Widget>[
              Center(child: Text('XS')),
              Center(child: Text('S')),
              Center(child: Text('M')),
              Center(child: Text('L')),
              Center(child: Text('XL')),
              Center(child: Text('XXL')),
              Center(child: Text('XXXL')),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const _SubHeader('Real CupertinoPicker - off-axis tilt'),
        const SizedBox(height: 6),
        _PickerCard(
          caption: 'offAxisFraction -0.4, diameterRatio 1.35',
          picker: CupertinoPicker(
            itemExtent: 30,
            offAxisFraction: -0.4,
            diameterRatio: 1.35,
            onSelectedItemChanged: (int _) {},
            scrollController: FixedExtentScrollController(initialItem: 1),
            selectionOverlay: null,
            children: const <Widget>[
              Center(child: Text('Mon')),
              Center(child: Text('Tue')),
              Center(child: Text('Wed')),
              Center(child: Text('Thu')),
              Center(child: Text('Fri')),
              Center(child: Text('Sat')),
              Center(child: Text('Sun')),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const _SubHeader('CupertinoPicker.builder - 1000 rows'),
        const SizedBox(height: 6),
        _PickerCard(
          caption: 'builder uses itemBuilder, returns null beyond childCount',
          picker: CupertinoPicker.builder(
            itemExtent: 32,
            onSelectedItemChanged: (int _) {},
            scrollController: FixedExtentScrollController(initialItem: 42),
            childCount: 1000,
            itemBuilder: (BuildContext _, int index) {
              return Center(
                child: Text(
                  'Row #${index.toString().padLeft(4, '0')}',
                  style: const TextStyle(fontFamily: 'monospace'),
                ),
              );
            },
          ),
        ),
      ],
    ),
  );
}

class _PickerCard extends StatelessWidget {
  const _PickerCard({required this.caption, required this.picker});

  final String caption;
  final Widget picker;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFC),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kHairline, width: 0.6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(caption, style: _kMonoTiny),
          const SizedBox(height: 6),
          SizedBox(height: 150, child: picker),
        ],
      ),
    );
  }
}

class _WheelPainter extends CustomPainter {
  _WheelPainter({required this.items, required this.selected});

  final List<String> items;
  final int selected;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = const Color(0xFFFAFAFC);
    final RRect frame = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      const Radius.circular(12),
    );
    canvas.drawRRect(frame, bg);
    canvas.drawRRect(
      frame,
      Paint()
        ..style = PaintingStyle.stroke
        ..color = _kHairline
        ..strokeWidth = 0.8,
    );

    final double cx = size.width / 2;
    final double cy = size.height / 2;
    final double radius = size.height * 0.55;
    final int n = items.length;
    final TextPainter tp = TextPainter(textDirection: TextDirection.ltr);

    for (int i = 0; i < n; i++) {
      final int delta = i - selected;
      final double angle = delta * 0.28;
      final double y = cy + math.sin(angle) * radius;
      final double scale = math.cos(angle).clamp(0.0, 1.0);
      final double opacity = scale * scale;
      if (scale < 0.05) continue;
      final TextStyle style = TextStyle(
        fontSize: 17 * scale + 4,
        color: Color.lerp(_kInkTertiary, _kInk, opacity)!,
        fontWeight:
            delta == 0 ? FontWeight.w700 : FontWeight.w500,
        letterSpacing: -0.2,
      );
      tp.text = TextSpan(text: items[i], style: style);
      tp.layout(maxWidth: size.width - 32);
      tp.paint(canvas, Offset(cx - tp.width / 2, y - tp.height / 2));
    }

    // Selection band
    final double bandHeight = 32;
    final Rect band = Rect.fromCenter(
      center: Offset(cx, cy),
      width: size.width - 32,
      height: bandHeight,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(band, const Radius.circular(8)),
      Paint()..color = _kBandFill,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(band, const Radius.circular(8)),
      Paint()
        ..style = PaintingStyle.stroke
        ..color = _kBandStroke
        ..strokeWidth = 0.6,
    );

    // Top + bottom fade overlays
    final Paint topFade = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[
          Color(0xFFFAFAFC),
          Color(0x00FAFAFC),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height * 0.35));
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height * 0.35),
      topFade,
    );
    final Paint bottomFade = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: <Color>[
          Color(0xFFFAFAFC),
          Color(0x00FAFAFC),
        ],
      ).createShader(Rect.fromLTWH(
        0,
        size.height * 0.65,
        size.width,
        size.height * 0.35,
      ));
    canvas.drawRect(
      Rect.fromLTWH(0, size.height * 0.65, size.width, size.height * 0.35),
      bottomFade,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ---------------------------------------------------------------------------
// SECTION 4: CUPERTINO DATE PICKER VIEWPORTS
// ---------------------------------------------------------------------------

Widget _buildDatePickerViewportSection() {
  return _Card(
    title: '4. CupertinoDatePicker - the four modes',
    subtitle:
        'Each mode composes a different number of inner wheels. Below we '
        'show real, statically-rendered pickers seeded with a fixed '
        'initialDateTime so no animation is needed.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _DatePickerModeCard(
          mode: CupertinoDatePickerMode.dateAndTime,
          label: 'dateAndTime',
          description:
              '3 wheels: weekday+date, hour, minute (+ am/pm if 12h).',
        ),
        const SizedBox(height: 12),
        _DatePickerModeCard(
          mode: CupertinoDatePickerMode.date,
          label: 'date',
          description: '3 wheels: month, day, year.',
        ),
        const SizedBox(height: 12),
        _DatePickerModeCard(
          mode: CupertinoDatePickerMode.time,
          label: 'time',
          description: '2 wheels: hour, minute (+ am/pm if 12h).',
        ),
        const SizedBox(height: 12),
        _DatePickerModeCard(
          mode: CupertinoDatePickerMode.monthYear,
          label: 'monthYear',
          description: '2 wheels: month, year.',
        ),
        const SizedBox(height: 16),
        const _CodeBlock(
          lines: <_CodeLine>[
            _CodeLine.type('CupertinoDatePicker', plain: '('),
            _CodeLine.plain('  mode: CupertinoDatePickerMode.date,'),
            _CodeLine.plain('  initialDateTime: DateTime(2026, 5, 12),'),
            _CodeLine.plain('  minimumDate: DateTime(2000),'),
            _CodeLine.plain('  maximumDate: DateTime(2099, 12, 31),'),
            _CodeLine.plain('  onDateTimeChanged: (DateTime _) {},'),
            _CodeLine.plain(');'),
          ],
        ),
      ],
    ),
  );
}

class _DatePickerModeCard extends StatelessWidget {
  const _DatePickerModeCard({
    required this.mode,
    required this.label,
    required this.description,
  });

  final CupertinoDatePickerMode mode;
  final String label;
  final String description;

  @override
  Widget build(BuildContext context) {
    final DateTime seed = DateTime(2026, 5, 12, 9, 41);
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kHairline, width: 0.6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: _kAccentIndigo,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  label,
                  style: const TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(description, style: _kMonoTiny),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 180,
            child: CupertinoDatePicker(
              mode: mode,
              initialDateTime: seed,
              minimumDate: DateTime(2000),
              maximumDate: DateTime(2099, 12, 31),
              onDateTimeChanged: (DateTime _) {},
              use24hFormat: false,
              backgroundColor: const Color(0xFFFFFFFF),
              selectionOverlayBuilder:
                  (BuildContext _, {required int columnCount, required int selectedIndex}) {
                return CupertinoPickerDefaultSelectionOverlay(
                  capStartEdge: selectedIndex == 0,
                  capEndEdge: selectedIndex == columnCount - 1,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 5: CUPERTINO TIMER PICKER VIEWPORTS
// ---------------------------------------------------------------------------

Widget _buildTimerPickerViewportSection() {
  return _Card(
    title: '5. CupertinoTimerPicker - hms / hm / ms modes',
    subtitle:
        'CupertinoTimerPicker is a sibling of CupertinoDatePicker that '
        'expresses durations rather than dates. It exposes minuteInterval '
        'and secondInterval, both of which must divide 60.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _TimerPickerModeCard(
          mode: CupertinoTimerPickerMode.hms,
          label: 'hms',
          description: '3 wheels: hours, minutes, seconds.',
          duration: Duration(hours: 1, minutes: 23, seconds: 45),
          minuteInterval: 1,
          secondInterval: 1,
        ),
        const SizedBox(height: 12),
        _TimerPickerModeCard(
          mode: CupertinoTimerPickerMode.hm,
          label: 'hm',
          description: '2 wheels: hours, minutes. Common for alarms.',
          duration: Duration(hours: 0, minutes: 15),
          minuteInterval: 5,
          secondInterval: 1,
        ),
        const SizedBox(height: 12),
        _TimerPickerModeCard(
          mode: CupertinoTimerPickerMode.ms,
          label: 'ms',
          description: '2 wheels: minutes, seconds. Used for kitchen timers.',
          duration: Duration(minutes: 4, seconds: 30),
          minuteInterval: 1,
          secondInterval: 15,
        ),
        const SizedBox(height: 16),
        const _CodeBlock(
          lines: <_CodeLine>[
            _CodeLine.type('CupertinoTimerPicker', plain: '('),
            _CodeLine.plain('  mode: CupertinoTimerPickerMode.hm,'),
            _CodeLine.plain('  initialTimerDuration: Duration(minutes: 15),'),
            _CodeLine.plain('  minuteInterval: 5,'),
            _CodeLine.plain('  onTimerDurationChanged: (Duration _) {},'),
            _CodeLine.plain(');'),
          ],
        ),
      ],
    ),
  );
}

class _TimerPickerModeCard extends StatelessWidget {
  const _TimerPickerModeCard({
    required this.mode,
    required this.label,
    required this.description,
    required this.duration,
    required this.minuteInterval,
    required this.secondInterval,
  });

  final CupertinoTimerPickerMode mode;
  final String label;
  final String description;
  final Duration duration;
  final int minuteInterval;
  final int secondInterval;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kHairline, width: 0.6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: _kAccentPurple,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  label,
                  style: const TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(description, style: _kMonoTiny),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFEDEDF0),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '${duration.inHours}h ${duration.inMinutes.remainder(60)}m '
                  '${duration.inSeconds.remainder(60)}s',
                  style: _kMonoTiny,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 180,
            child: CupertinoTimerPicker(
              mode: mode,
              initialTimerDuration: duration,
              minuteInterval: minuteInterval,
              secondInterval: secondInterval,
              onTimerDurationChanged: (Duration _) {},
              backgroundColor: const Color(0xFFFFFFFF),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 6: MAGNIFICATION EFFECT VISUALIZATION
// ---------------------------------------------------------------------------

Widget _buildMagnificationVisualizationSection() {
  return _Card(
    title: '6. Magnification + magnifier glass',
    subtitle:
        'magnification scales the centre row. useMagnifier draws a square '
        'glass overlay around the band. The two cooperate but are also '
        'independent.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _SubHeader('Static visualization'),
        const SizedBox(height: 6),
        SizedBox(
          height: 200,
          child: CustomPaint(
            painter: _MagnificationPainter(),
          ),
        ),
        const SizedBox(height: 12),
        const _SubHeader('Side by side - magnification 1.0 vs 1.2'),
        const SizedBox(height: 6),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: _PickerCard(
                caption: 'magnification 1.0',
                picker: CupertinoPicker(
                  itemExtent: 30,
                  magnification: 1.0,
                  useMagnifier: false,
                  onSelectedItemChanged: (int _) {},
                  scrollController:
                      FixedExtentScrollController(initialItem: 3),
                  children: const <Widget>[
                    Center(child: Text('Red')),
                    Center(child: Text('Orange')),
                    Center(child: Text('Yellow')),
                    Center(child: Text('Green')),
                    Center(child: Text('Blue')),
                    Center(child: Text('Indigo')),
                    Center(child: Text('Violet')),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _PickerCard(
                caption: 'magnification 1.2 + useMagnifier',
                picker: CupertinoPicker(
                  itemExtent: 30,
                  magnification: 1.2,
                  useMagnifier: true,
                  onSelectedItemChanged: (int _) {},
                  scrollController:
                      FixedExtentScrollController(initialItem: 3),
                  children: const <Widget>[
                    Center(child: Text('Red')),
                    Center(child: Text('Orange')),
                    Center(child: Text('Yellow')),
                    Center(child: Text('Green')),
                    Center(child: Text('Blue')),
                    Center(child: Text('Indigo')),
                    Center(child: Text('Violet')),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        const _CodeBlock(
          lines: <_CodeLine>[
            _CodeLine.comment('// iOS-flavoured chunky magnifier'),
            _CodeLine.type('CupertinoPicker', plain: '('),
            _CodeLine.plain('  itemExtent: 32,'),
            _CodeLine.plain('  magnification: 1.08,'),
            _CodeLine.plain('  useMagnifier: true,'),
            _CodeLine.plain('  onSelectedItemChanged: (int _) {},'),
            _CodeLine.plain('  children: const <Widget>[ ... ],'),
            _CodeLine.plain(');'),
          ],
        ),
      ],
    ),
  );
}

class _MagnificationPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = const Color(0xFFFAFAFC);
    final RRect frame = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      const Radius.circular(12),
    );
    canvas.drawRRect(frame, bg);
    canvas.drawRRect(
      frame,
      Paint()
        ..style = PaintingStyle.stroke
        ..color = _kHairline
        ..strokeWidth = 0.6,
    );

    final TextPainter tp = TextPainter(textDirection: TextDirection.ltr);
    final List<String> rows = <String>[
      '13:39',
      '13:40',
      '13:41',
      '13:42',
      '13:43',
    ];
    final double rowHeight = size.height / 5;
    for (int i = 0; i < rows.length; i++) {
      final int delta = (i - 2).abs();
      final double scale = i == 2 ? 1.15 : 1.0 - delta * 0.18;
      final double opacity = i == 2 ? 1.0 : (1.0 - delta * 0.25);
      tp.text = TextSpan(
        text: rows[i],
        style: TextStyle(
          fontSize: 18 * scale,
          color: Color.lerp(
              const Color(0x00000000), _kInk, opacity.clamp(0.0, 1.0))!,
          fontWeight: i == 2 ? FontWeight.w700 : FontWeight.w500,
          fontFeatures: const <FontFeature>[FontFeature.tabularFigures()],
        ),
      );
      tp.layout();
      tp.paint(
        canvas,
        Offset((size.width - tp.width) / 2,
            i * rowHeight + (rowHeight - tp.height) / 2),
      );
    }

    // Magnifier glass
    final Rect glass = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: size.width * 0.65,
      height: rowHeight * 1.2,
    );
    final RRect glassR =
        RRect.fromRectAndRadius(glass, const Radius.circular(10));
    canvas.drawRRect(
      glassR,
      Paint()..color = const Color(0x14000000),
    );
    canvas.drawRRect(
      glassR,
      Paint()
        ..style = PaintingStyle.stroke
        ..color = _kAccentIndigo
        ..strokeWidth = 1.2,
    );

    // Annotation arrow + label
    final Paint arrow = Paint()
      ..color = _kAccentIndigo
      ..strokeWidth = 1.2;
    canvas.drawLine(
      Offset(glass.right + 4, glass.center.dy),
      Offset(glass.right + 16, glass.center.dy),
      arrow,
    );
    tp.text = const TextSpan(
      text: 'useMagnifier: true',
      style: TextStyle(
        fontSize: 10,
        color: _kAccentIndigo,
        fontWeight: FontWeight.w700,
      ),
    );
    tp.layout();
    if (glass.right + 18 + tp.width < size.width) {
      tp.paint(canvas, Offset(glass.right + 18, glass.center.dy - tp.height / 2));
    }

    tp.text = const TextSpan(
      text: 'magnification > 1.0',
      style: TextStyle(
        fontSize: 10,
        color: _kAccentOrange,
        fontWeight: FontWeight.w700,
      ),
    );
    tp.layout();
    tp.paint(canvas, Offset(8, 6));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ---------------------------------------------------------------------------
// SECTION 7: LOOPING + PHYSICS
// ---------------------------------------------------------------------------

Widget _buildLoopingAndPhysicsSection() {
  return _Card(
    title: '7. Looping pickers and FixedExtentScrollPhysics',
    subtitle:
        'Pickers can wrap around endlessly (looping: true) and always snap '
        'to a row through FixedExtentScrollPhysics.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: _PickerCard(
                caption: 'looping: false (default)',
                picker: CupertinoPicker(
                  itemExtent: 30,
                  looping: false,
                  onSelectedItemChanged: (int _) {},
                  scrollController:
                      FixedExtentScrollController(initialItem: 1),
                  children: const <Widget>[
                    Center(child: Text('Daily')),
                    Center(child: Text('Weekly')),
                    Center(child: Text('Monthly')),
                    Center(child: Text('Yearly')),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _PickerCard(
                caption: 'looping: true',
                picker: CupertinoPicker(
                  itemExtent: 30,
                  looping: true,
                  onSelectedItemChanged: (int _) {},
                  scrollController:
                      FixedExtentScrollController(initialItem: 1),
                  children: const <Widget>[
                    Center(child: Text('Daily')),
                    Center(child: Text('Weekly')),
                    Center(child: Text('Monthly')),
                    Center(child: Text('Yearly')),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFFFAFAFC),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _kHairline, width: 0.6),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text('FixedExtentScrollPhysics',
                  style: _kSectionHeader),
              const SizedBox(height: 6),
              const Text(
                'The wheel uses FixedExtentScrollPhysics, which inherits '
                'from ScrollPhysics but constrains the rest position to a '
                'multiple of itemExtent. This is why a flick always settles '
                'on a row instead of stopping between two values.',
                style: _kBodyStyle,
              ),
              const SizedBox(height: 10),
              const _CodeBlock(
                lines: <_CodeLine>[
                  _CodeLine.comment('// internal physics, you rarely override it'),
                  _CodeLine.type('ListWheelScrollView', plain: '('),
                  _CodeLine.plain('  physics: const FixedExtentScrollPhysics(),'),
                  _CodeLine.plain('  itemExtent: 32.0,'),
                  _CodeLine.plain('  children: <Widget>[ ... ],'),
                  _CodeLine.plain(');'),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 8: RECIPE CARDS
// ---------------------------------------------------------------------------

Widget _buildRecipeCardsSection() {
  return _Card(
    title: '8. Recipes',
    subtitle:
        'Copy-paste shapes for the picker variants you reach for most '
        'often.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const <Widget>[
        _RecipeCard(
          title: 'Country picker',
          tagline:
              'Tall list of strings, magnified for legibility, transparent '
              'background so the bottom sheet shines through.',
          code: <_CodeLine>[
            _CodeLine.type('CupertinoPicker', plain: '('),
            _CodeLine.plain('  itemExtent: 36,'),
            _CodeLine.plain('  magnification: 1.08,'),
            _CodeLine.plain('  useMagnifier: true,'),
            _CodeLine.plain('  squeeze: 1.1,'),
            _CodeLine.plain('  backgroundColor: null,'),
            _CodeLine.plain('  scrollController: FixedExtentScrollController('),
            _CodeLine.plain('    initialItem: 41, // index of "Germany"'),
            _CodeLine.plain('  ),'),
            _CodeLine.plain('  onSelectedItemChanged: (int _) {},'),
            _CodeLine.plain('  children: <Widget>[ ... ],'),
            _CodeLine.plain(');'),
          ],
        ),
        SizedBox(height: 10),
        _RecipeCard(
          title: 'Numeric stepper',
          tagline:
              'Compact wheel with looping enabled, custom overlay coloured '
              'systemBlue for emphasis.',
          code: <_CodeLine>[
            _CodeLine.type('CupertinoPicker', plain: '.builder('),
            _CodeLine.plain('  itemExtent: 28,'),
            _CodeLine.plain('  looping: true,'),
            _CodeLine.plain('  childCount: 100,'),
            _CodeLine.plain('  selectionOverlay: const'),
            _CodeLine.type('  CupertinoPickerDefaultSelectionOverlay',
                plain: '('),
            _CodeLine.plain('    background: Color(0x265856D6),'),
            _CodeLine.plain('  ),'),
            _CodeLine.plain('  itemBuilder: (BuildContext _, int i) {'),
            _CodeLine.plain('    return Center(child: Text("\$i"));'),
            _CodeLine.plain('  },'),
            _CodeLine.plain('  onSelectedItemChanged: (int _) {},'),
            _CodeLine.plain(');'),
          ],
        ),
        SizedBox(height: 10),
        _RecipeCard(
          title: 'Per-column flush date picker overlay',
          tagline:
              'Pass selectionOverlayBuilder to a date picker to render the '
              'first column with capStartEdge only and the last column with '
              'capEndEdge only, so the band runs flush between columns.',
          code: <_CodeLine>[
            _CodeLine.type('CupertinoDatePicker', plain: '('),
            _CodeLine.plain('  mode: CupertinoDatePickerMode.date,'),
            _CodeLine.plain('  selectionOverlayBuilder:'),
            _CodeLine.plain('  (BuildContext _, {required int columnCount,'),
            _CodeLine.plain('   required int selectedIndex}) {'),
            _CodeLine.plain('    return'),
            _CodeLine.type('     CupertinoPickerDefaultSelectionOverlay',
                plain: '('),
            _CodeLine.plain('      capStartEdge: selectedIndex == 0,'),
            _CodeLine.plain('      capEndEdge:'),
            _CodeLine.plain('       selectedIndex == columnCount - 1,'),
            _CodeLine.plain('    );'),
            _CodeLine.plain('  },'),
            _CodeLine.plain('  onDateTimeChanged: (DateTime _) {},'),
            _CodeLine.plain(');'),
          ],
        ),
        SizedBox(height: 10),
        _RecipeCard(
          title: 'Removable overlay (chrome-less)',
          tagline:
              'Drop the band entirely - useful when the picker sits in a '
              'card that already has its own selected-row affordance.',
          code: <_CodeLine>[
            _CodeLine.type('CupertinoPicker', plain: '('),
            _CodeLine.plain('  itemExtent: 30,'),
            _CodeLine.plain('  selectionOverlay: null,'),
            _CodeLine.plain('  onSelectedItemChanged: (int _) {},'),
            _CodeLine.plain('  children: <Widget>[ ... ],'),
            _CodeLine.plain(');'),
          ],
        ),
      ],
    ),
  );
}

class _RecipeCard extends StatelessWidget {
  const _RecipeCard({
    required this.title,
    required this.tagline,
    required this.code,
  });

  final String title;
  final String tagline;
  final List<_CodeLine> code;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kHairline, width: 0.6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: _kInk,
              )),
          const SizedBox(height: 4),
          Text(tagline,
              style: const TextStyle(
                fontSize: 12,
                color: _kInkSecondary,
                height: 1.4,
              )),
          const SizedBox(height: 8),
          _CodeBlock(lines: code),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 9: PITFALLS
// ---------------------------------------------------------------------------

Widget _buildPitfallsSection() {
  return _Card(
    title: '9. Pitfalls',
    subtitle:
        'Common surprises with CupertinoPicker, the default overlay and the '
        'date / timer pickers.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const <Widget>[
        _PitfallTile(
          severity: 'warn',
          title: 'Forgetting that magnification is multiplicative',
          body:
              'magnification scales the centre row only. If your row widget '
              'already paints a large icon, set magnification: 1.0 to avoid '
              'overshooting the band.',
        ),
        _PitfallTile(
          severity: 'warn',
          title: 'Using useMagnifier with magnification == 1.0',
          body:
              'The magnifier glass still draws, but nothing visually grows. '
              'Either bump magnification > 1.0, or set useMagnifier: false.',
        ),
        _PitfallTile(
          severity: 'info',
          title: 'looping needs at least two rows',
          body:
              'A single child with looping: true degenerates into a flat '
              'wheel. Provide >= 2 children so the wrap-around is visible.',
        ),
        _PitfallTile(
          severity: 'info',
          title: 'minuteInterval must divide 60',
          body:
              'CupertinoTimerPicker asserts that minuteInterval and '
              'secondInterval both divide 60. Use 1, 2, 3, 5, 10, 15, 30 '
              'or 60.',
        ),
        _PitfallTile(
          severity: 'warn',
          title: 'Setting selectionOverlay: null hides the band',
          body:
              'It does not remove the centre selection - the picker still '
              'tracks a selected row. If you want to hide selection entirely '
              'you must combine null overlay with a custom visual treatment.',
        ),
        _PitfallTile(
          severity: 'info',
          title: 'FixedExtentScrollController must outlive the picker',
          body:
              'Storing the controller in a local variable inside build is '
              'fine here (static demo). In real apps, hold it as a State '
              'field and dispose it.',
        ),
        _PitfallTile(
          severity: 'info',
          title: 'CupertinoDatePickerMode.monthYear ignores time fields',
          body:
              'When using monthYear, the day / hour / minute of the '
              'initialDateTime are silently clamped to the 1st at 00:00. '
              'Plan your seed accordingly.',
        ),
      ],
    ),
  );
}

class _PitfallTile extends StatelessWidget {
  const _PitfallTile({
    required this.severity,
    required this.title,
    required this.body,
  });

  final String severity;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final bool warn = severity == 'warn';
    final Color tint = warn ? _kAccentOrange : _kAccent;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: tint.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: tint.withValues(alpha: 0.35), width: 0.6),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(
            warn
                ? CupertinoIcons.exclamationmark_triangle
                : CupertinoIcons.info_circle,
            color: tint,
            size: 18,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: tint,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  body,
                  style: const TextStyle(
                    fontSize: 12.5,
                    color: _kInkSecondary,
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
}

// ---------------------------------------------------------------------------
// CHEAT SHEET FOOTER
// ---------------------------------------------------------------------------

Widget _buildCheatSheetFooter() {
  return Container(
    margin: const EdgeInsets.only(top: 4),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _kCardDark,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: _kHairlineDark, width: 0.6),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(
              CupertinoIcons.book,
              color: _kInkOnDark,
              size: 18,
            ),
            const SizedBox(width: 8),
            const Text(
              'Picker cheat sheet',
              style: TextStyle(
                color: _kInkOnDark,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.2,
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: _kAccentIndigo,
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text(
                'v3.x',
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        const _CheatLine(
          left: 'CupertinoPicker',
          right: 'wheel of arbitrary widgets',
        ),
        const _CheatLine(
          left: 'CupertinoPicker.builder',
          right: 'lazy wheel; childCount + itemBuilder',
        ),
        const _CheatLine(
          left: 'CupertinoPickerDefaultSelectionOverlay',
          right: 'rounded band: background, capStartEdge, capEndEdge',
        ),
        const _CheatLine(
          left: 'CupertinoDatePicker(dateAndTime)',
          right: '3 wheels: weekday+date, hour, minute (+am/pm)',
        ),
        const _CheatLine(
          left: 'CupertinoDatePicker(date)',
          right: '3 wheels: month, day, year',
        ),
        const _CheatLine(
          left: 'CupertinoDatePicker(time)',
          right: '2 wheels: hour, minute (+am/pm)',
        ),
        const _CheatLine(
          left: 'CupertinoDatePicker(monthYear)',
          right: '2 wheels: month, year',
        ),
        const _CheatLine(
          left: 'CupertinoTimerPicker(hms)',
          right: '3 wheels: hours, minutes, seconds',
        ),
        const _CheatLine(
          left: 'CupertinoTimerPicker(hm)',
          right: '2 wheels: hours, minutes',
        ),
        const _CheatLine(
          left: 'CupertinoTimerPicker(ms)',
          right: '2 wheels: minutes, seconds',
        ),
        const _CheatLine(
          left: 'FixedExtentScrollController',
          right: 'initialItem, selectedItem, jumpToItem, animateToItem',
        ),
        const _CheatLine(
          left: 'FixedExtentScrollPhysics',
          right: 'snaps the wheel to a row on release',
        ),
        const SizedBox(height: 12),
        const Text(
          'Picker = wheel + selection band + (optional) magnifier glass. '
          'CupertinoPickerDefaultSelectionOverlay owns the band; everything '
          'else is the wheel.',
          style: TextStyle(
            color: _kInkOnDarkSecondary,
            fontSize: 12,
            height: 1.45,
          ),
        ),
      ],
    ),
  );
}

class _CheatLine extends StatelessWidget {
  const _CheatLine({required this.left, required this.right});

  final String left;
  final String right;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 220,
            child: Text(
              left,
              style: const TextStyle(
                color: _kCodeAccent,
                fontFamily: 'monospace',
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              right,
              style: const TextStyle(
                color: _kInkOnDark,
                fontSize: 11.5,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SHARED CARD CHROME
// ---------------------------------------------------------------------------

class _Card extends StatelessWidget {
  const _Card({
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _kHairline, width: 0.6),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 16,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(title, style: _kTitleStyle),
          const SizedBox(height: 4),
          Text(subtitle, style: _kSubtitleStyle),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}

class _SubHeader extends StatelessWidget {
  const _SubHeader(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        children: <Widget>[
          Container(
            width: 3,
            height: 14,
            decoration: BoxDecoration(
              color: _kAccentIndigo,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 8),
          Text(text, style: _kSectionHeader),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// CODE BLOCK SUPPORT
// ---------------------------------------------------------------------------
// Tiny syntax-tinted code block. Each line is one of `plain`, `keyword`,
// `type`, `string` or `comment`. Lines that mix kinds use the `plain`
// field to append a trailing un-tinted segment.

class _CodeLine {
  const _CodeLine.plain(this.text)
      : kind = _CodeLineKind.plain,
        plain = '';
  const _CodeLine.keyword(this.text, {this.plain = ''})
      : kind = _CodeLineKind.keyword;
  const _CodeLine.type(this.text, {this.plain = ''})
      : kind = _CodeLineKind.type;
  const _CodeLine.string(this.text, {this.plain = ''})
      : kind = _CodeLineKind.string;
  const _CodeLine.comment(this.text)
      : kind = _CodeLineKind.comment,
        plain = '';

  final _CodeLineKind kind;
  final String text;
  final String plain;
}

enum _CodeLineKind { plain, keyword, type, string, comment }

class _CodeBlock extends StatelessWidget {
  const _CodeBlock({required this.lines});

  final List<_CodeLine> lines;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kCodeBg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          for (final _CodeLine line in lines) _renderLine(line),
        ],
      ),
    );
  }

  Widget _renderLine(_CodeLine line) {
    final Color tint;
    switch (line.kind) {
      case _CodeLineKind.plain:
        tint = _kCodeText;
        break;
      case _CodeLineKind.keyword:
        tint = _kCodeKeyword;
        break;
      case _CodeLineKind.type:
        tint = _kCodeType;
        break;
      case _CodeLineKind.string:
        tint = _kCodeString;
        break;
      case _CodeLineKind.comment:
        tint = _kCodeComment;
        break;
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.5,
            height: 1.4,
            color: _kCodeText,
          ),
          children: <InlineSpan>[
            TextSpan(text: line.text, style: TextStyle(color: tint)),
            if (line.plain.isNotEmpty)
              TextSpan(text: line.plain, style: const TextStyle(color: _kCodeText)),
          ],
        ),
      ),
    );
  }
}
