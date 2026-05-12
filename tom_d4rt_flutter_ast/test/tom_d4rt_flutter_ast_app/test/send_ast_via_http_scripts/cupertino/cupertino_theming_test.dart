// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unused_element, dead_code, unnecessary_import, no_leading_underscores_for_local_identifiers, prefer_const_constructors, prefer_const_literals_to_create_immutables
// D4rt test script: Deep visual demo of Flutter's Cupertino theming system.
//
// This script is part of the D4rt flutter-test corpus. It runs inside a
// sandboxed, analyzer-free Dart interpreter and exposes a single
// top-level entry point - `dynamic build(BuildContext context)` - which
// is invoked once and returns a Widget tree.
//
// While the companion file `cupertino_colors_system_test.dart` focuses on
// the `CupertinoColors` palette and `CupertinoDynamicColor`, THIS file
// makes `CupertinoTheme` and `CupertinoThemeData` the headline subjects.
// It walks through:
//
//   * `CupertinoTheme.of(context)`           - inherited theme lookup
//   * `CupertinoThemeData` fields            - primaryColor,
//                                              primaryContrastingColor,
//                                              barBackgroundColor,
//                                              scaffoldBackgroundColor,
//                                              brightness, textTheme,
//                                              applyThemeToAll
//   * `CupertinoTextThemeData`               - the eight named text styles
//   * `CupertinoIconThemeData`               - icon color derivation
//   * `CupertinoDynamicColor.resolve`        - resolution against a context
//   * `CupertinoTheme` override worked example
//   * Cupertino-vs-Material differences      - design philosophy contrast
//
// The page is laid out like a single-column technical poster: a hero
// anatomy diagram drawn by a `CustomPainter`, several side-by-side
// light/dark comparison panels, a textTheme catalog, an icon theme
// derivation strip, a theme override before/after diptych, a
// Cupertino-vs-Material comparison matrix and a pitfalls/cheatsheet
// footer.
//
// Because the script runs in a static, no-interaction environment, every
// callback is either `null` or a no-op consumer.  No `setState`, `Timer`,
// `Future`, `Stream`, `async` or live `AnimationController` is used
// anywhere in this file.
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
const Color _kCanvas = Color(0xFFF2F2F7);
const Color _kCanvasDark = Color(0xFF000000);
const Color _kCardBg = Color(0xFFFFFFFF);
const Color _kCardDark = Color(0xFF1C1C1E);
const Color _kCardElevatedDark = Color(0xFF2C2C2E);
const Color _kHairline = Color(0x14000000);
const Color _kHairlineDark = Color(0x33FFFFFF);
const Color _kInk = Color(0xFF1C1C1E);
const Color _kInkSecondary = Color(0xFF3C3C43);
const Color _kInkTertiary = Color(0xFF8E8E93);
const Color _kInkOnDark = Color(0xFFEDEDF0);
const Color _kInkOnDarkSecondary = Color(0xFFA1A1A6);
const Color _kInkOnDarkTertiary = Color(0xFF8E8E93);
const Color _kAccent = Color(0xFF007AFF);
const Color _kAccentDark = Color(0xFF0A84FF);
const Color _kAccentGreen = Color(0xFF34C759);
const Color _kAccentOrange = Color(0xFFFF9500);
const Color _kAccentRed = Color(0xFFFF3B30);
const Color _kAccentIndigo = Color(0xFF5856D6);
const Color _kAccentPink = Color(0xFFFF2D55);
const Color _kAccentTeal = Color(0xFF30B0C7);
const Color _kAccentPurple = Color(0xFFAF52DE);
const Color _kAccentYellow = Color(0xFFFFCC00);
const Color _kMaterialPurple = Color(0xFF6750A4);
const Color _kMaterialPink = Color(0xFFB3261E);
const Color _kCodeBg = Color(0xFF1E1F22);
const Color _kCodeText = Color(0xFFE6E6E6);
const Color _kCodeAccent = Color(0xFF7DD3FC);
const Color _kCodeKeyword = Color(0xFFFFA657);
const Color _kCodeString = Color(0xFFA5D6A7);
const Color _kCodeComment = Color(0xFF6E7681);
const Color _kCodeType = Color(0xFFF9C8C2);
const Color _kCodeNumber = Color(0xFFD2A8FF);
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
const TextStyle _kFieldNameStyle = TextStyle(
  fontSize: 12.5,
  fontFamily: 'monospace',
  fontWeight: FontWeight.w600,
  color: _kInk,
  fontFeatures: <FontFeature>[FontFeature.tabularFigures()],
);
const TextStyle _kCodeStyle = TextStyle(
  fontSize: 12.5,
  fontFamily: 'monospace',
  color: _kCodeText,
  height: 1.45,
  fontFeatures: <FontFeature>[FontFeature.tabularFigures()],
);
const EdgeInsets _kCardPadding = EdgeInsets.all(18.0);

// ---------------------------------------------------------------------------
// SMALL TYPED RECORDS
// ---------------------------------------------------------------------------
class _FieldRow {
  const _FieldRow(this.name, this.type, this.purpose);
  final String name;
  final String type;
  final String purpose;
}

class _CompareRow {
  const _CompareRow(this.subject, this.cupertino, this.material);
  final String subject;
  final String cupertino;
  final String material;
}

class _ThemeSnapshot {
  const _ThemeSnapshot({
    required this.label,
    required this.brightness,
    required this.primary,
    required this.primaryContrasting,
    required this.barBackground,
    required this.scaffold,
    required this.canvas,
    required this.card,
    required this.ink,
    required this.inkSecondary,
    required this.hairline,
  });
  final String label;
  final Brightness brightness;
  final Color primary;
  final Color primaryContrasting;
  final Color barBackground;
  final Color scaffold;
  final Color canvas;
  final Color card;
  final Color ink;
  final Color inkSecondary;
  final Color hairline;
}

const _ThemeSnapshot _kLightSnapshot = _ThemeSnapshot(
  label: 'Brightness.light',
  brightness: Brightness.light,
  primary: _kAccent,
  primaryContrasting: Color(0xFFFFFFFF),
  barBackground: Color(0xF2F9F9F9),
  scaffold: _kCanvas,
  canvas: _kCanvas,
  card: _kCardBg,
  ink: _kInk,
  inkSecondary: _kInkSecondary,
  hairline: _kHairline,
);

const _ThemeSnapshot _kDarkSnapshot = _ThemeSnapshot(
  label: 'Brightness.dark',
  brightness: Brightness.dark,
  primary: _kAccentDark,
  primaryContrasting: Color(0xFF000000),
  barBackground: Color(0xF21D1D1D),
  scaffold: _kCanvasDark,
  canvas: _kCanvasDark,
  card: _kCardDark,
  ink: _kInkOnDark,
  inkSecondary: _kInkOnDarkSecondary,
  hairline: _kHairlineDark,
);

// ---------------------------------------------------------------------------
// PRIVATE HELPERS
// ---------------------------------------------------------------------------
String _hexOf(Color c) {
  final int v = c.value;
  final String hex = v.toRadixString(16).toUpperCase().padLeft(8, '0');
  return '#$hex';
}

Color _contrastingFor(Color c) {
  final double r = c.red / 255.0;
  final double g = c.green / 255.0;
  final double b = c.blue / 255.0;
  final double l = 0.2126 * r + 0.7152 * g + 0.0722 * b;
  return l > 0.55 ? _kInk : const Color(0xFFFFFFFF);
}

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
          child: Text(
            '$index',
            style: const TextStyle(color: Color(0xFFFFFFFF), fontSize: 16.0, fontWeight: FontWeight.w700),
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

Widget _sectionDivider() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18.0),
    child: Container(height: 1.0, color: _kHairline),
  );
}

Widget _card({
  required Widget child,
  Color background = _kCardBg,
  EdgeInsets padding = _kCardPadding,
  EdgeInsets margin = const EdgeInsets.symmetric(horizontal: 18.0, vertical: 6.0),
  Color borderColor = _kHairline,
}) {
  return Container(
    margin: margin,
    padding: padding,
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: borderColor),
      boxShadow: const <BoxShadow>[
        BoxShadow(color: Color(0x0D000000), offset: Offset(0.0, 1.0), blurRadius: 3.0),
      ],
    ),
    child: child,
  );
}

Widget _cardTitle(
  String title, {
  String? subtitle,
  Color titleColor = _kInk,
  Color subtitleColor = _kInkSecondary,
}) {
  return Column(
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
  );
}

Widget _pill(String label, {Color colour = _kAccent}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
    decoration: BoxDecoration(
      color: colour.withOpacity(0.12),
      borderRadius: BorderRadius.circular(999.0),
      border: Border.all(color: colour.withOpacity(0.3)),
    ),
    child: Text(
      label,
      style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600, color: colour),
    ),
  );
}

Widget _miniSwatch(Color c, {double size = 16.0}) {
  return Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      color: c,
      borderRadius: BorderRadius.circular(4.0),
      border: Border.all(color: _kHairline),
    ),
  );
}

Widget _hexLabel(Color c, {Color textColor = _kInkTertiary}) {
  return Text(
    _hexOf(c),
    style: TextStyle(
      fontSize: 10.5,
      fontFamily: 'monospace',
      color: textColor,
      fontFeatures: const <FontFeature>[FontFeature.tabularFigures()],
    ),
  );
}

// ---------------------------------------------------------------------------
// CODE SPAN HELPERS
// ---------------------------------------------------------------------------
// Tiny syntax-highlighter helpers used by all the code blocks throughout
// the demo. They are functions rather than a real parser, because the
// content of each code block is hand-curated and short.

TextSpan _kw(String s) => TextSpan(text: s, style: const TextStyle(color: _kCodeKeyword));
TextSpan _ty(String s) => TextSpan(text: s, style: const TextStyle(color: _kCodeType));
TextSpan _id(String s) => TextSpan(text: s, style: const TextStyle(color: _kCodeText));
TextSpan _str(String s) => TextSpan(text: s, style: const TextStyle(color: _kCodeString));
TextSpan _num_(String s) => TextSpan(text: s, style: const TextStyle(color: _kCodeNumber));
TextSpan _cmt(String s) => TextSpan(text: s, style: const TextStyle(color: _kCodeComment, fontStyle: FontStyle.italic));
TextSpan _acc(String s) => TextSpan(text: s, style: const TextStyle(color: _kCodeAccent));
TextSpan _pn(String s) => TextSpan(text: s, style: const TextStyle(color: _kCodeText));

Widget _codeBlock(List<List<TextSpan>> lines, {EdgeInsets? padding}) {
  return Container(
    width: double.infinity,
    padding: padding ?? const EdgeInsets.fromLTRB(14.0, 12.0, 14.0, 12.0),
    decoration: BoxDecoration(
      color: _kCodeBg,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: const Color(0xFF2A2C31)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        for (int i = 0; i < lines.length; i++)
          RichText(
            text: TextSpan(
              style: _kCodeStyle,
              children: <TextSpan>[
                TextSpan(
                  text: '${(i + 1).toString().padLeft(2, ' ')}  ',
                  style: const TextStyle(color: _kCodeComment),
                ),
                ...lines[i],
              ],
            ),
          ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// ANATOMY DIAGRAM CUSTOM PAINTER
// ---------------------------------------------------------------------------
// Section 1 hero: a centered `CupertinoThemeData` node with seven labelled
// children fanning out. Each child is a field of CupertinoThemeData.
// Drawn from scratch with CustomPainter so the layout can be precise.

class _AnatomyPainter extends CustomPainter {
  const _AnatomyPainter({required this.brightnessLabel});

  final String brightnessLabel;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()
      ..color = const Color(0xFFF7F8FC)
      ..style = PaintingStyle.fill;
    final RRect bgRect = RRect.fromRectAndRadius(
      Offset.zero & size,
      const Radius.circular(12.0),
    );
    canvas.drawRRect(bgRect, bg);

    // Subtle grid background.
    final Paint grid = Paint()
      ..color = const Color(0x0A000000)
      ..strokeWidth = 1.0;
    const double step = 24.0;
    for (double x = step; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0.0), Offset(x, size.height), grid);
    }
    for (double y = step; y < size.height; y += step) {
      canvas.drawLine(Offset(0.0, y), Offset(size.width, y), grid);
    }

    final Offset center = Offset(size.width / 2.0, size.height / 2.0);

    // Children labels are placed on a circle around the center.
    final List<String> children = <String>[
      'primaryColor',
      'primaryContrastingColor',
      'barBackgroundColor',
      'scaffoldBackgroundColor',
      'textTheme',
      'brightness',
      'applyThemeToAll',
    ];
    final List<Color> childColors = <Color>[
      _kAccent,
      const Color(0xFFFFFFFF),
      const Color(0xFFF9F9F9),
      _kCanvas,
      _kAccentIndigo,
      _kAccentOrange,
      _kAccentGreen,
    ];

    final double radius = math.min(size.width, size.height) * 0.36;
    final List<Offset> targets = <Offset>[];
    for (int i = 0; i < children.length; i++) {
      final double angle = (-math.pi / 2.0) + (2.0 * math.pi * i / children.length);
      final Offset p = Offset(
        center.dx + radius * math.cos(angle),
        center.dy + radius * math.sin(angle),
      );
      targets.add(p);
    }

    // Draw connector lines first.
    final Paint connector = Paint()
      ..color = const Color(0x66007AFF)
      ..strokeWidth = 1.4
      ..style = PaintingStyle.stroke;
    for (final Offset t in targets) {
      final Path p = Path()
        ..moveTo(center.dx, center.dy)
        ..lineTo(t.dx, t.dy);
      canvas.drawPath(p, connector);
      // Arrowhead.
      final double dx = t.dx - center.dx;
      final double dy = t.dy - center.dy;
      final double len = math.sqrt(dx * dx + dy * dy);
      final double ux = dx / len;
      final double uy = dy / len;
      final Offset arrowTip = Offset(t.dx - ux * 26.0, t.dy - uy * 26.0);
      final Offset l = Offset(arrowTip.dx - uy * 4.0, arrowTip.dy + ux * 4.0);
      final Offset r = Offset(arrowTip.dx + uy * 4.0, arrowTip.dy - ux * 4.0);
      final Paint arrow = Paint()
        ..color = _kAccent
        ..style = PaintingStyle.fill;
      final Path arrowPath = Path()
        ..moveTo(arrowTip.dx + ux * 6.0, arrowTip.dy + uy * 6.0)
        ..lineTo(l.dx, l.dy)
        ..lineTo(r.dx, r.dy)
        ..close();
      canvas.drawPath(arrowPath, arrow);
    }

    // Center node.
    final Paint centerFill = Paint()..color = _kAccent;
    final RRect centerRect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: center, width: 168.0, height: 64.0),
      const Radius.circular(14.0),
    );
    canvas.drawRRect(centerRect, centerFill);
    final TextPainter centerText = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
      text: const TextSpan(
        text: 'CupertinoThemeData',
        style: TextStyle(
          color: Color(0xFFFFFFFF),
          fontSize: 14.0,
          fontWeight: FontWeight.w700,
        ),
      ),
    )..layout(maxWidth: 160.0);
    centerText.paint(
      canvas,
      Offset(center.dx - centerText.width / 2.0, center.dy - centerText.height / 2.0 - 8.0),
    );
    final TextPainter centerSub = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
      text: TextSpan(
        text: brightnessLabel,
        style: const TextStyle(
          color: Color(0xCCFFFFFF),
          fontSize: 10.5,
          fontFamily: 'monospace',
        ),
      ),
    )..layout(maxWidth: 160.0);
    centerSub.paint(
      canvas,
      Offset(center.dx - centerSub.width / 2.0, center.dy + 6.0),
    );

    // Child nodes.
    for (int i = 0; i < children.length; i++) {
      final Offset t = targets[i];
      final Color fill = childColors[i];
      final Paint nodeFill = Paint()..color = fill;
      final RRect nodeRect = RRect.fromRectAndRadius(
        Rect.fromCenter(center: t, width: 152.0, height: 40.0),
        const Radius.circular(10.0),
      );
      canvas.drawRRect(nodeRect, nodeFill);
      final Paint border = Paint()
        ..color = const Color(0x1A000000)
        ..strokeWidth = 1.0
        ..style = PaintingStyle.stroke;
      canvas.drawRRect(nodeRect, border);

      final Color textColor = _contrastingFor(fill);
      final TextPainter tp = TextPainter(
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
        text: TextSpan(
          text: children[i],
          style: TextStyle(
            color: textColor,
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
            fontFamily: 'monospace',
          ),
        ),
      )..layout(maxWidth: 140.0);
      tp.paint(
        canvas,
        Offset(t.dx - tp.width / 2.0, t.dy - tp.height / 2.0),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _AnatomyPainter old) =>
      old.brightnessLabel != brightnessLabel;
}

Widget _anatomyDiagram() {
  return _card(
    padding: const EdgeInsets.fromLTRB(14.0, 14.0, 14.0, 14.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'Anatomy of CupertinoThemeData',
          subtitle: 'Seven first-class fields, painted from scratch',
        ),
        const SizedBox(height: 12.0),
        SizedBox(
          height: 420.0,
          child: CustomPaint(
            painter: const _AnatomyPainter(brightnessLabel: 'brightness: null (inherits)'),
            size: Size.infinite,
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          'The center node is CupertinoThemeData itself; each spoke is a field.\n'
          'When brightness is null, fields that depend on it (primaryColor, barBackgroundColor, scaffoldBackgroundColor) inherit from the ambient platform brightness via MediaQuery.',
          style: _kCaptionStyle.copyWith(height: 1.4),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 1: INTRO + FIELDS TABLE
// ---------------------------------------------------------------------------
// We open with a definition card that explains what CupertinoTheme is,
// followed by a field table for CupertinoThemeData. The field table is a
// hand-laid-out grid (name | type | purpose) rather than DataTable so we
// keep control of column widths and avoid Material chrome bleeding in.

Widget _introCard() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            _pill('CupertinoTheme', colour: _kAccent),
            const SizedBox(width: 6.0),
            _pill('InheritedWidget', colour: _kAccentIndigo),
            const SizedBox(width: 6.0),
            _pill('static', colour: _kAccentTeal),
          ],
        ),
        const SizedBox(height: 10.0),
        _cardTitle(
          'CupertinoTheme is an InheritedWidget',
          subtitle: 'It exposes a CupertinoThemeData to every descendant via CupertinoTheme.of(context)',
        ),
        const SizedBox(height: 10.0),
        const Text(
          'Unlike Material\'s Theme, the Cupertino theme is intentionally small. '
          'It does not try to encode every visual decision; it only encodes the '
          'few that change between iOS appearances: brightness, the tint color, '
          'the contrasting color, the bar background, the scaffold background, '
          'the text theme, and a flag that controls how aggressively a child '
          'CupertinoTheme override re-tints widgets that pull from Material.',
          style: _kBodyStyle,
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: const Color(0xFFF1F6FF),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: const Color(0xFFCBDDF7)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Icon(CupertinoIcons.info_circle_fill, color: _kAccent, size: 18.0),
              const SizedBox(width: 8.0),
              const Expanded(
                child: Text(
                  'CupertinoTheme.of(context) NEVER returns null. If no '
                  'CupertinoTheme is in the tree, the lookup falls back to '
                  'a default constructed CupertinoThemeData() and resolves '
                  'dynamic colors against the ambient MediaQuery.',
                  style: TextStyle(fontSize: 13.0, color: _kInk, height: 1.4),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _fieldsTable() {
  const List<_FieldRow> rows = <_FieldRow>[
    _FieldRow(
      'brightness',
      'Brightness?',
      'Drives light/dark resolution of every CupertinoDynamicColor reachable through this theme. When null, MediaQuery.platformBrightnessOf(context) is used.',
    ),
    _FieldRow(
      'primaryColor',
      'Color',
      'The tint of the app. Defaults to CupertinoColors.systemBlue. Used by CupertinoButton, CupertinoNavigationBar leading/trailing, switches and pickers.',
    ),
    _FieldRow(
      'primaryContrastingColor',
      'Color',
      'The color of glyphs placed on primaryColor (e.g. the title of a filled CupertinoButton). Should pair with primaryColor for legibility.',
    ),
    _FieldRow(
      'barBackgroundColor',
      'Color',
      'Background for CupertinoNavigationBar and CupertinoTabBar. Translucent by default so the system blur layer can show through.',
    ),
    _FieldRow(
      'scaffoldBackgroundColor',
      'Color',
      'Default backgroundColor for CupertinoPageScaffold. Replaces nothing if a scaffold passes an explicit value.',
    ),
    _FieldRow(
      'textTheme',
      'CupertinoTextThemeData',
      'Eight named text styles consumed by Cupertino widgets. Inherits primary/contrasting colors from the surrounding theme.',
    ),
    _FieldRow(
      'applyThemeToAll',
      'bool',
      'When true, CupertinoTheme attempts to influence non-Cupertino descendants (e.g. some Material widgets) using the same data.',
    ),
  ];
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle('Fields of CupertinoThemeData'),
        const SizedBox(height: 10.0),
        Row(
          children: const <Widget>[
            SizedBox(
              width: 170.0,
              child: Text('field', style: _kCaptionStyle),
            ),
            SizedBox(
              width: 150.0,
              child: Text('type', style: _kCaptionStyle),
            ),
            Expanded(child: Text('purpose', style: _kCaptionStyle)),
          ],
        ),
        const SizedBox(height: 6.0),
        Container(height: 1.0, color: _kHairline),
        const SizedBox(height: 6.0),
        for (int i = 0; i < rows.length; i++) ...<Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 7.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(width: 170.0, child: Text(rows[i].name, style: _kFieldNameStyle)),
                SizedBox(
                  width: 150.0,
                  child: Text(
                    rows[i].type,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12.0,
                      color: _kAccentIndigo,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(rows[i].purpose, style: _kBodyStyle.copyWith(fontSize: 13.0)),
                ),
              ],
            ),
          ),
          if (i != rows.length - 1) Container(height: 1.0, color: _kHairline.withOpacity(0.6)),
        ],
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 2: BRIGHTNESS DIPTYCH
// ---------------------------------------------------------------------------
// Two ThemeSnapshot panels side-by-side so the user can see how the same
// CupertinoThemeData() default reads differently under Brightness.light
// and Brightness.dark.

Widget _miniNavBar(_ThemeSnapshot s) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
    decoration: BoxDecoration(
      color: s.barBackground,
      border: Border(bottom: BorderSide(color: s.hairline, width: 0.5)),
    ),
    child: Row(
      children: <Widget>[
        Icon(CupertinoIcons.back, color: s.primary, size: 22.0),
        const SizedBox(width: 4.0),
        Text(
          'Back',
          style: TextStyle(color: s.primary, fontSize: 15.0, fontWeight: FontWeight.w400),
        ),
        const Spacer(),
        Text(
          'Settings',
          style: TextStyle(color: s.ink, fontSize: 16.0, fontWeight: FontWeight.w600),
        ),
        const Spacer(),
        Icon(CupertinoIcons.ellipsis_circle, color: s.primary, size: 22.0),
      ],
    ),
  );
}

Widget _miniListItem(_ThemeSnapshot s, IconData icon, String title, String trailing) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 11.0),
    decoration: BoxDecoration(
      color: s.card,
      border: Border(bottom: BorderSide(color: s.hairline, width: 0.5)),
    ),
    child: Row(
      children: <Widget>[
        Icon(icon, color: s.primary, size: 19.0),
        const SizedBox(width: 10.0),
        Expanded(
          child: Text(
            title,
            style: TextStyle(color: s.ink, fontSize: 14.5),
          ),
        ),
        Text(
          trailing,
          style: TextStyle(color: s.inkSecondary, fontSize: 13.0),
        ),
        const SizedBox(width: 6.0),
        Icon(CupertinoIcons.chevron_right, color: s.inkSecondary, size: 14.0),
      ],
    ),
  );
}

Widget _miniButton(_ThemeSnapshot s, String label, {bool filled = false}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 9.0),
    decoration: BoxDecoration(
      color: filled ? s.primary : null,
      borderRadius: BorderRadius.circular(9.0),
      border: filled ? null : Border.all(color: s.primary, width: 1.0),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: filled ? s.primaryContrasting : s.primary,
        fontSize: 13.5,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

Widget _brightnessPanel(_ThemeSnapshot s) {
  return Container(
    decoration: BoxDecoration(
      color: s.canvas,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: s.hairline),
    ),
    clipBehavior: Clip.antiAlias,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _miniNavBar(s),
        const SizedBox(height: 10.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(
            s.label,
            style: TextStyle(
              color: s.inkSecondary,
              fontSize: 11.0,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ),
        const SizedBox(height: 6.0),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 12.0),
          decoration: BoxDecoration(
            color: s.card,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: s.hairline),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: <Widget>[
              _miniListItem(s, CupertinoIcons.wifi, 'Wi-Fi', 'home'),
              _miniListItem(s, CupertinoIcons.bluetooth, 'Bluetooth', 'On'),
              _miniListItem(s, CupertinoIcons.bell_fill, 'Notifications', '14'),
            ],
          ),
        ),
        const SizedBox(height: 12.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            children: <Widget>[
              _miniButton(s, 'Cancel'),
              const SizedBox(width: 10.0),
              _miniButton(s, 'Confirm', filled: true),
            ],
          ),
        ),
        const SizedBox(height: 12.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Wrap(
            spacing: 6.0,
            runSpacing: 6.0,
            children: <Widget>[
              _fieldPair('primaryColor', s.primary),
              _fieldPair('primaryContrasting', s.primaryContrasting),
              _fieldPair('barBackground', s.barBackground),
              _fieldPair('scaffold', s.scaffold),
            ],
          ),
        ),
        const SizedBox(height: 12.0),
      ],
    ),
  );
}

Widget _fieldPair(String name, Color c) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: const Color(0x14000000),
      borderRadius: BorderRadius.circular(6.0),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _miniSwatch(c, size: 14.0),
        const SizedBox(width: 5.0),
        Text(
          name,
          style: const TextStyle(
            fontSize: 10.5,
            fontFamily: 'monospace',
            color: _kInkOnDark,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}

Widget _brightnessDiptych() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'The same default theme, twice',
          subtitle: 'CupertinoThemeData(brightness: Brightness.light) vs CupertinoThemeData(brightness: Brightness.dark)',
        ),
        const SizedBox(height: 12.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: _brightnessPanel(_kLightSnapshot)),
            const SizedBox(width: 10.0),
            Expanded(child: _brightnessPanel(_kDarkSnapshot)),
          ],
        ),
        const SizedBox(height: 12.0),
        _codeBlock(<List<TextSpan>>[
          <TextSpan>[_kw('const'), _id(' lightTheme '), _id('= '), _ty('CupertinoThemeData'), _id('(')],
          <TextSpan>[_id('  brightness: '), _ty('Brightness'), _id('.light,')],
          <TextSpan>[_id('  primaryColor: '), _ty('CupertinoColors'), _id('.systemBlue,')],
          <TextSpan>[_id(');')],
          <TextSpan>[],
          <TextSpan>[_kw('const'), _id(' darkTheme '), _id('= '), _ty('CupertinoThemeData'), _id('(')],
          <TextSpan>[_id('  brightness: '), _ty('Brightness'), _id('.dark,')],
          <TextSpan>[_id('  primaryColor: '), _ty('CupertinoColors'), _id('.systemBlue,  '), _cmt('// resolves to 0A84FF in dark')],
          <TextSpan>[_id(');')],
        ]),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 3: CupertinoTextThemeData CATALOG
// ---------------------------------------------------------------------------
// CupertinoTextThemeData has 8 named text styles. We render every single
// one of them, in two columns (sample + spec).

class _TextStyleSpec {
  const _TextStyleSpec({
    required this.field,
    required this.fontSize,
    required this.fontWeight,
    required this.letterSpacing,
    required this.sample,
    required this.usage,
    this.colorOverride,
  });
  final String field;
  final double fontSize;
  final FontWeight fontWeight;
  final double letterSpacing;
  final String sample;
  final String usage;
  final Color? colorOverride;
}

const List<_TextStyleSpec> _kTextStyleSpecs = <_TextStyleSpec>[
  _TextStyleSpec(
    field: 'textStyle',
    fontSize: 17.0,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.41,
    sample: 'The body text for nearly every widget.',
    usage: 'Default for CupertinoButton labels, plain Text widgets under DefaultTextStyle inherited from theme.',
  ),
  _TextStyleSpec(
    field: 'actionTextStyle',
    fontSize: 17.0,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.41,
    sample: 'Confirm  -  Cancel  -  Delete',
    usage: 'Tappable actions in CupertinoButton, alert action buttons and other tinted controls. Tinted with primaryColor.',
    colorOverride: _kAccent,
  ),
  _TextStyleSpec(
    field: 'tabLabelTextStyle',
    fontSize: 10.0,
    fontWeight: FontWeight.w500,
    letterSpacing: -0.24,
    sample: 'Home  Browse  Profile',
    usage: 'Labels under CupertinoTabBar icons. Compact, slightly heavier weight than body.',
  ),
  _TextStyleSpec(
    field: 'navTitleTextStyle',
    fontSize: 17.0,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.41,
    sample: 'Inbox',
    usage: 'Compact-mode navigation bar title. Heavier weight than body text and aligned to center.',
  ),
  _TextStyleSpec(
    field: 'navLargeTitleTextStyle',
    fontSize: 34.0,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.41,
    sample: 'Photos',
    usage: 'Large-title mode for CupertinoSliverNavigationBar.large. Drops to navTitleTextStyle as the user scrolls.',
  ),
  _TextStyleSpec(
    field: 'navActionTextStyle',
    fontSize: 17.0,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.41,
    sample: 'Edit',
    usage: 'Trailing/leading actions in CupertinoNavigationBar. Tinted with primaryColor.',
    colorOverride: _kAccent,
  ),
  _TextStyleSpec(
    field: 'pickerTextStyle',
    fontSize: 21.0,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.6,
    sample: '14:30',
    usage: 'CupertinoPicker rows. Slightly larger than body, balanced for the drum-roll layout.',
  ),
  _TextStyleSpec(
    field: 'dateTimePickerTextStyle',
    fontSize: 21.0,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.6,
    sample: 'Sun, Nov 12',
    usage: 'CupertinoDatePicker rows. Same metrics as pickerTextStyle by default; usually customized only to match dense layouts.',
  ),
];

Widget _textStyleRow(int index, _TextStyleSpec spec) {
  final TextStyle ts = TextStyle(
    fontSize: spec.fontSize,
    fontWeight: spec.fontWeight,
    letterSpacing: spec.letterSpacing,
    color: spec.colorOverride ?? _kInk,
    height: 1.2,
  );
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 14.0),
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: index == _kTextStyleSpecs.length - 1 ? const Color(0x00000000) : _kHairline,
        ),
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 220.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('#${(index + 1).toString().padLeft(2, '0')}', style: _kCaptionStyle),
              const SizedBox(height: 2.0),
              Text(spec.field, style: _kFieldNameStyle),
              const SizedBox(height: 4.0),
              Text(
                'size ${spec.fontSize.toStringAsFixed(1)}  ·  w${(spec.fontWeight.index + 1) * 100}',
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10.5,
                  color: _kInkTertiary,
                ),
              ),
              Text(
                'letter ${spec.letterSpacing.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10.5,
                  color: _kInkTertiary,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(spec.sample, style: ts),
              const SizedBox(height: 4.0),
              Text(
                spec.usage,
                style: _kBodyStyle.copyWith(fontSize: 12.5, color: _kInkSecondary),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _textThemeCatalog() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            _pill('CupertinoTextThemeData', colour: _kAccentIndigo),
            const SizedBox(width: 6.0),
            _pill('8 styles', colour: _kAccentOrange),
          ],
        ),
        const SizedBox(height: 8.0),
        _cardTitle(
          'Eight text styles, eight jobs',
          subtitle: 'Each is wired by a specific Cupertino widget',
        ),
        const SizedBox(height: 6.0),
        for (int i = 0; i < _kTextStyleSpecs.length; i++)
          _textStyleRow(i, _kTextStyleSpecs[i]),
        const SizedBox(height: 8.0),
        _codeBlock(<List<TextSpan>>[
          <TextSpan>[_kw('final'), _ty(' CupertinoThemeData'), _id(' theme = '), _ty('CupertinoThemeData'), _id('(')],
          <TextSpan>[_id('  brightness: '), _ty('Brightness'), _id('.light,')],
          <TextSpan>[_id('  textTheme: '), _ty('CupertinoTextThemeData'), _id('(')],
          <TextSpan>[_id('    primaryColor: '), _ty('CupertinoColors'), _id('.systemIndigo,')],
          <TextSpan>[_id('    textStyle: '), _ty('TextStyle'), _id('('), _id('fontSize: '), _num_('16.0'), _id(', height: '), _num_('1.4'), _id('),')],
          <TextSpan>[_id('  ),')],
          <TextSpan>[_id(');')],
        ]),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 4: CupertinoIconThemeData derivation
// ---------------------------------------------------------------------------
// CupertinoIconThemeData is what IconTheme.of(context) returns inside a
// CupertinoApp. Its color tracks the surrounding CupertinoTheme primary
// color. We render a derivation strip showing how a primaryColor choice
// flows into icons across a fake toolbar.

class _IconRecipe {
  const _IconRecipe(this.icon, this.label);
  final IconData icon;
  final String label;
}

const List<_IconRecipe> _kIconRecipes = <_IconRecipe>[
  _IconRecipe(CupertinoIcons.house_fill, 'house_fill'),
  _IconRecipe(CupertinoIcons.search, 'search'),
  _IconRecipe(CupertinoIcons.heart_fill, 'heart_fill'),
  _IconRecipe(CupertinoIcons.bell_fill, 'bell_fill'),
  _IconRecipe(CupertinoIcons.bookmark_fill, 'bookmark_fill'),
  _IconRecipe(CupertinoIcons.person_crop_circle, 'person_crop_circle'),
  _IconRecipe(CupertinoIcons.gear, 'gear'),
  _IconRecipe(CupertinoIcons.cloud_fill, 'cloud_fill'),
];

Widget _iconStrip(Color tint, String label) {
  return Container(
    padding: const EdgeInsets.fromLTRB(12.0, 10.0, 12.0, 12.0),
    decoration: BoxDecoration(
      color: _kCardBg,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: _kHairline),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            _miniSwatch(tint, size: 14.0),
            const SizedBox(width: 6.0),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12.5,
                fontFamily: 'monospace',
                color: _kInk,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 6.0),
            _hexLabel(tint),
          ],
        ),
        const SizedBox(height: 8.0),
        Wrap(
          spacing: 14.0,
          runSpacing: 10.0,
          children: <Widget>[
            for (final _IconRecipe r in _kIconRecipes)
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(r.icon, color: tint, size: 26.0),
                  const SizedBox(height: 3.0),
                  SizedBox(
                    width: 80.0,
                    child: Text(
                      r.label,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 10.0,
                        fontFamily: 'monospace',
                        color: _kInkTertiary,
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ],
    ),
  );
}

Widget _iconThemeCard() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            _pill('CupertinoIconThemeData', colour: _kAccentTeal),
            const SizedBox(width: 6.0),
            _pill('IconThemeData', colour: _kAccentPurple),
          ],
        ),
        const SizedBox(height: 8.0),
        _cardTitle(
          'Icons inherit the primary tint',
          subtitle: 'IconTheme.of(context).color == CupertinoTheme.of(context).primaryColor (by default)',
        ),
        const SizedBox(height: 10.0),
        const Text(
          'Inside a CupertinoApp, IconTheme is preset to a CupertinoIconThemeData '
          'whose color follows the surrounding CupertinoThemeData.primaryColor. '
          'Switching the theme tint or wrapping a subtree in CupertinoTheme '
          'changes every plain Icon below it without touching the Icon\'s own '
          'color argument.',
          style: _kBodyStyle,
        ),
        const SizedBox(height: 12.0),
        Column(
          children: <Widget>[
            _iconStrip(_kAccent, 'primaryColor = systemBlue'),
            const SizedBox(height: 8.0),
            _iconStrip(_kAccentIndigo, 'primaryColor = systemIndigo'),
            const SizedBox(height: 8.0),
            _iconStrip(_kAccentOrange, 'primaryColor = systemOrange'),
            const SizedBox(height: 8.0),
            _iconStrip(_kAccentGreen, 'primaryColor = systemGreen'),
            const SizedBox(height: 8.0),
            _iconStrip(_kAccentPink, 'primaryColor = systemPink'),
            const SizedBox(height: 8.0),
            _iconStrip(_kAccentTeal, 'primaryColor = systemTeal'),
          ],
        ),
        const SizedBox(height: 12.0),
        _codeBlock(<List<TextSpan>>[
          <TextSpan>[_cmt('// Each Icon below is plain - no color argument.')],
          <TextSpan>[_ty('CupertinoTheme'), _id('(')],
          <TextSpan>[_id('  data: '), _ty('CupertinoThemeData'), _id('(primaryColor: '), _ty('CupertinoColors'), _id('.systemPink),')],
          <TextSpan>[_id('  child: '), _ty('Row'), _id('(children: <'), _ty('Widget'), _id('>[')],
          <TextSpan>[_id('    '), _ty('Icon'), _id('('), _ty('CupertinoIcons'), _id('.heart_fill),  '), _cmt('// pink')],
          <TextSpan>[_id('    '), _ty('Icon'), _id('('), _ty('CupertinoIcons'), _id('.gear),         '), _cmt('// pink')],
          <TextSpan>[_id('  ]),')],
          <TextSpan>[_id('),')],
        ]),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 5: CupertinoDynamicColor.resolve
// ---------------------------------------------------------------------------
// A worked example: explain the eight variants and show the resolution
// matrix as a 2x2x2 cube flattened into a table.

class _ResolveRow {
  const _ResolveRow(this.brightness, this.contrast, this.elevation, this.value);
  final String brightness;
  final String contrast;
  final String elevation;
  final Color value;
}

const List<_ResolveRow> _kResolveRows = <_ResolveRow>[
  _ResolveRow('light', 'normal', 'base',     Color(0xFF007AFF)),
  _ResolveRow('light', 'normal', 'elevated', Color(0xFF007AFF)),
  _ResolveRow('light', 'high',   'base',     Color(0xFF0040DD)),
  _ResolveRow('light', 'high',   'elevated', Color(0xFF0040DD)),
  _ResolveRow('dark',  'normal', 'base',     Color(0xFF0A84FF)),
  _ResolveRow('dark',  'normal', 'elevated', Color(0xFF0A84FF)),
  _ResolveRow('dark',  'high',   'base',     Color(0xFF409CFF)),
  _ResolveRow('dark',  'high',   'elevated', Color(0xFF409CFF)),
];

Widget _resolveTableHeader() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6.0),
    child: Row(
      children: const <Widget>[
        SizedBox(width: 90.0, child: Text('brightness', style: _kCaptionStyle)),
        SizedBox(width: 90.0, child: Text('contrast', style: _kCaptionStyle)),
        SizedBox(width: 90.0, child: Text('level', style: _kCaptionStyle)),
        Expanded(child: Text('resolved value', style: _kCaptionStyle)),
      ],
    ),
  );
}

Widget _resolveTableRow(_ResolveRow row) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6.0),
    child: Row(
      children: <Widget>[
        SizedBox(
          width: 90.0,
          child: Text(
            row.brightness,
            style: const TextStyle(fontFamily: 'monospace', fontSize: 12.5, color: _kInk),
          ),
        ),
        SizedBox(
          width: 90.0,
          child: Text(
            row.contrast,
            style: const TextStyle(fontFamily: 'monospace', fontSize: 12.5, color: _kInk),
          ),
        ),
        SizedBox(
          width: 90.0,
          child: Text(
            row.elevation,
            style: const TextStyle(fontFamily: 'monospace', fontSize: 12.5, color: _kInk),
          ),
        ),
        Expanded(
          child: Row(
            children: <Widget>[
              _miniSwatch(row.value, size: 20.0),
              const SizedBox(width: 8.0),
              Text(
                _hexOf(row.value),
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12.0,
                  color: _kInkSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _dynamicResolveCard() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            _pill('CupertinoDynamicColor', colour: _kAccentPurple),
            const SizedBox(width: 6.0),
            _pill('.resolve', colour: _kAccentTeal),
          ],
        ),
        const SizedBox(height: 8.0),
        _cardTitle(
          'Eight variants, one final Color',
          subtitle: 'resolve(context) consults Brightness, MediaQuery.highContrast and CupertinoUserInterfaceLevel',
        ),
        const SizedBox(height: 10.0),
        const Text(
          'CupertinoTheme.of(context) holds the dynamic colors unchanged. '
          'The flat Color you see in a paint pass is produced lazily by '
          'CupertinoDynamicColor.resolve, which reads three axes off the '
          'BuildContext and returns one of eight constants stored in the '
          'dynamic color.',
          style: _kBodyStyle,
        ),
        const SizedBox(height: 12.0),
        _codeBlock(<List<TextSpan>>[
          <TextSpan>[_kw('final'), _ty(' Color'), _id(' tint = '), _ty('CupertinoDynamicColor'), _id('.resolve(')],
          <TextSpan>[_id('  '), _ty('CupertinoColors'), _id('.systemBlue,')],
          <TextSpan>[_id('  context,')],
          <TextSpan>[_id(');')],
          <TextSpan>[],
          <TextSpan>[_cmt('// Equivalent to:')],
          <TextSpan>[_cmt('//   Brightness b   = MediaQuery.platformBrightnessOf(context);')],
          <TextSpan>[_cmt('//   bool       hc  = MediaQuery.highContrastOf(context);')],
          <TextSpan>[_cmt('//   CupertinoUserInterfaceLevelData lvl = ... (or base);')],
          <TextSpan>[_cmt('//   return color.pickFrom(b, hc, lvl);')],
        ]),
        const SizedBox(height: 12.0),
        Text('Resolution matrix for CupertinoColors.systemBlue', style: _kFieldNameStyle),
        const SizedBox(height: 4.0),
        _resolveTableHeader(),
        Container(height: 1.0, color: _kHairline),
        for (final _ResolveRow r in _kResolveRows) ...<Widget>[
          _resolveTableRow(r),
          Container(height: 1.0, color: _kHairline.withOpacity(0.4)),
        ],
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 6: CUPERTINO vs MATERIAL COMPARISON MATRIX
// ---------------------------------------------------------------------------
// A wide table that contrasts the design choices in CupertinoTheme vs
// Material's ThemeData on the same subject. Six rows, each is a small
// callout.

const List<_CompareRow> _kCompareRows = <_CompareRow>[
  _CompareRow(
    'Theme widget',
    'CupertinoTheme is a single InheritedWidget exposing CupertinoThemeData. CupertinoTheme.of(context) never returns null.',
    'Theme is also an InheritedWidget; Theme.of(context) returns ThemeData (also never null but uses an internal default).',
  ),
  _CompareRow(
    'Number of fields',
    'CupertinoThemeData carries 7 directly observable fields plus textTheme. Designed to be small.',
    'ThemeData carries 100+ fields: each Material component family has its own *ThemeData (CardTheme, ChipTheme, ...) merged in.',
  ),
  _CompareRow(
    'Dynamic colors',
    'Resolved on the fly via CupertinoDynamicColor.resolve(context). The color stored in the theme has 8 variants.',
    'ColorScheme.fromSeed produces a Material 3 palette. Each color is a plain Color; brightness chooses one of two schemes.',
  ),
  _CompareRow(
    'Brightness model',
    'CupertinoThemeData.brightness can be null. When null, MediaQuery.platformBrightnessOf decides per resolve.',
    'ThemeData.brightness is non-null. The whole subtree is built either light or dark, then re-built on change.',
  ),
  _CompareRow(
    'Component customization',
    'Cupertino widgets read a small number of theme fields directly. There are no per-component subthemes.',
    'Most widgets read both ThemeData.colorScheme/textTheme AND their own *Theme (ButtonTheme, AppBarTheme, ...).',
  ),
  _CompareRow(
    'Override granularity',
    'Wrap with CupertinoTheme to override the whole CupertinoThemeData at a subtree boundary. There is no per-field-only override widget.',
    'Theme.copyWith or component-specific *Theme widgets let you override just one slice of the design system.',
  ),
];

Widget _compareRow(_CompareRow row, bool last) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 12.0),
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(color: last ? const Color(0x00000000) : _kHairline),
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 140.0,
          child: Text(
            row.subject,
            style: _kFieldNameStyle.copyWith(color: _kInk),
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10.0),
            margin: const EdgeInsets.only(right: 6.0),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F6FF),
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: const Color(0xFFCBDDF7)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    _pill('Cupertino', colour: _kAccent),
                  ],
                ),
                const SizedBox(height: 6.0),
                Text(row.cupertino, style: _kBodyStyle.copyWith(fontSize: 12.5)),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: const Color(0xFFF6F0FF),
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: const Color(0xFFDDD0F0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    _pill('Material', colour: _kMaterialPurple),
                  ],
                ),
                const SizedBox(height: 6.0),
                Text(row.material, style: _kBodyStyle.copyWith(fontSize: 12.5)),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _compareMatrix() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            _pill('CupertinoTheme', colour: _kAccent),
            const SizedBox(width: 4.0),
            const Text('vs', style: _kCaptionStyle),
            const SizedBox(width: 4.0),
            _pill('Material Theme', colour: _kMaterialPurple),
          ],
        ),
        const SizedBox(height: 8.0),
        _cardTitle(
          'Same subject, different design philosophy',
          subtitle: 'Six rows highlighting where the two systems intentionally diverge',
        ),
        const SizedBox(height: 6.0),
        for (int i = 0; i < _kCompareRows.length; i++)
          _compareRow(_kCompareRows[i], i == _kCompareRows.length - 1),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 7: THEME OVERRIDE WORKED EXAMPLE
// ---------------------------------------------------------------------------
// Before / after diptych. Two panels render the same fake CupertinoApp
// screen; the right one is wrapped in a nested CupertinoTheme that
// changes the primary color and brightness.

Widget _appShell({required _ThemeSnapshot snap, required String overrideLabel}) {
  return Container(
    decoration: BoxDecoration(
      color: snap.canvas,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: snap.hairline),
    ),
    clipBehavior: Clip.antiAlias,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _miniNavBar(snap),
        const SizedBox(height: 12.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(
            overrideLabel,
            style: TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
              color: snap.inkSecondary,
              letterSpacing: 0.4,
            ),
          ),
        ),
        const SizedBox(height: 6.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(
            'New playlist',
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.w700,
              color: snap.ink,
              letterSpacing: -0.4,
            ),
          ),
        ),
        const SizedBox(height: 4.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(
            'Pick a theme color and name your playlist.',
            style: TextStyle(fontSize: 13.0, color: snap.inkSecondary),
          ),
        ),
        const SizedBox(height: 12.0),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 12.0),
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 11.0),
          decoration: BoxDecoration(
            color: snap.card,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: snap.hairline),
          ),
          child: Row(
            children: <Widget>[
              Icon(CupertinoIcons.music_note_list, color: snap.primary, size: 18.0),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'Untitled playlist',
                  style: TextStyle(fontSize: 14.0, color: snap.ink),
                ),
              ),
              Icon(CupertinoIcons.checkmark_alt, color: snap.primary, size: 18.0),
            ],
          ),
        ),
        const SizedBox(height: 10.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            children: <Widget>[
              _miniButton(snap, 'Discard'),
              const SizedBox(width: 10.0),
              _miniButton(snap, 'Create', filled: true),
            ],
          ),
        ),
        const SizedBox(height: 14.0),
      ],
    ),
  );
}

Widget _overrideCard() {
  // The right-hand panel is a fictitious override: primary green, dark.
  const _ThemeSnapshot overridden = _ThemeSnapshot(
    label: 'overridden subtree',
    brightness: Brightness.dark,
    primary: _kAccentGreen,
    primaryContrasting: Color(0xFFFFFFFF),
    barBackground: Color(0xF21D1D1D),
    scaffold: _kCanvasDark,
    canvas: _kCanvasDark,
    card: _kCardDark,
    ink: _kInkOnDark,
    inkSecondary: _kInkOnDarkSecondary,
    hairline: _kHairlineDark,
  );
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            _pill('CupertinoTheme(', colour: _kAccent),
            const SizedBox(width: 4.0),
            _pill('data: ...', colour: _kAccentIndigo),
            const SizedBox(width: 4.0),
            _pill('child: ...)', colour: _kAccentTeal),
          ],
        ),
        const SizedBox(height: 8.0),
        _cardTitle(
          'Nested CupertinoTheme override',
          subtitle: 'Wrap any subtree to give it a different palette and brightness',
        ),
        const SizedBox(height: 12.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: _appShell(snap: _kLightSnapshot, overrideLabel: 'BEFORE - inherited theme')),
            const SizedBox(width: 10.0),
            Expanded(child: _appShell(snap: overridden, overrideLabel: 'AFTER - nested override')),
          ],
        ),
        const SizedBox(height: 12.0),
        _codeBlock(<List<TextSpan>>[
          <TextSpan>[_ty('CupertinoTheme'), _id('(')],
          <TextSpan>[_id('  data: '), _ty('CupertinoTheme'), _id('.of(context).copyWith(')],
          <TextSpan>[_id('    brightness: '), _ty('Brightness'), _id('.dark,')],
          <TextSpan>[_id('    primaryColor: '), _ty('CupertinoColors'), _id('.systemGreen,')],
          <TextSpan>[_id('  ),')],
          <TextSpan>[_id('  child: '), _ty('CupertinoPageScaffold'), _id('(')],
          <TextSpan>[_id('    navigationBar: '), _ty('CupertinoNavigationBar'), _id('(middle: '), _ty('Text'), _id('('), _str('\'New playlist\''), _id(')),')],
          <TextSpan>[_id('    child: '), _id('_PlaylistEditor(),')],
          <TextSpan>[_id('  ),')],
          <TextSpan>[_id('),')],
        ]),
        const SizedBox(height: 8.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF7E6),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: const Color(0xFFFFE0A8)),
          ),
          child: const Text(
            'Tip: prefer CupertinoTheme.of(context).copyWith(...) over building '
            'a brand-new CupertinoThemeData from scratch, so unspecified fields '
            'continue to inherit from the parent theme.',
            style: TextStyle(fontSize: 13.0, color: _kInk, height: 1.4),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 8: PITFALLS & CHEATSHEET
// ---------------------------------------------------------------------------
// Six numbered pitfalls + a compact cheatsheet of the most useful calls.

class _Pitfall {
  const _Pitfall(this.title, this.body);
  final String title;
  final String body;
}

const List<_Pitfall> _kPitfalls = <_Pitfall>[
  _Pitfall(
    'Reading colors from CupertinoTheme too early',
    'CupertinoTheme.of(context).primaryColor returns the dynamic color WITH eight variants. To get a flat Color usable in a paint pass, also call CupertinoDynamicColor.resolve(theme.primaryColor, context).',
  ),
  _Pitfall(
    'Forgetting brightness is nullable',
    'CupertinoThemeData.brightness can be null. Code that branches on brightness must fall back to MediaQuery.platformBrightnessOf(context) when null - copyWith does not coerce the value.',
  ),
  _Pitfall(
    'Building a brand-new CupertinoThemeData',
    'Constructing CupertinoThemeData() from scratch resets every unspecified field to its default. Almost every override should be CupertinoTheme.of(context).copyWith(...).',
  ),
  _Pitfall(
    'Expecting Material widgets to follow Cupertino theme',
    'Material widgets ignore CupertinoTheme unless applyThemeToAll is true AND they read the values that CupertinoTheme exposes to Material. For a fully shared palette, build both a ThemeData and a CupertinoThemeData and feed them to a single root.',
  ),
  _Pitfall(
    'Mutating the text theme by reassigning',
    'CupertinoTextThemeData.copyWith creates a new instance; assigning to fields directly is impossible because they are final. Always work through copyWith.',
  ),
  _Pitfall(
    'Hardcoding a Color instead of CupertinoColors',
    'Hardcoded ARGB literals do NOT track Brightness, high-contrast or elevation. Prefer CupertinoColors.* and feed them through resolve() at paint time.',
  ),
];

Widget _pitfallCallout(int i, _Pitfall p) {
  return Container(
    padding: const EdgeInsets.all(12.0),
    margin: const EdgeInsets.only(bottom: 8.0),
    decoration: BoxDecoration(
      color: const Color(0xFFFFF7F4),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: const Color(0xFFFFD8C9)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 26.0,
          height: 26.0,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: _kAccentRed,
            shape: BoxShape.circle,
          ),
          child: Text(
            '${i + 1}',
            style: const TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 13.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(p.title, style: _kFieldNameStyle.copyWith(fontFamily: null, fontSize: 14.0)),
              const SizedBox(height: 4.0),
              Text(p.body, style: _kBodyStyle.copyWith(fontSize: 12.5)),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _pitfallsCard() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            _pill('pitfalls', colour: _kAccentRed),
            const SizedBox(width: 6.0),
            _pill('6 callouts', colour: _kAccentOrange),
          ],
        ),
        const SizedBox(height: 8.0),
        _cardTitle('Six places people slip up'),
        const SizedBox(height: 10.0),
        for (int i = 0; i < _kPitfalls.length; i++) _pitfallCallout(i, _kPitfalls[i]),
      ],
    ),
  );
}

Widget _cheatsheetCard() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            _pill('cheatsheet', colour: _kAccentGreen),
          ],
        ),
        const SizedBox(height: 8.0),
        _cardTitle('Theming cheatsheet'),
        const SizedBox(height: 10.0),
        _codeBlock(<List<TextSpan>>[
          <TextSpan>[_cmt('// Look up the current theme')]
          ,
          <TextSpan>[_kw('final'), _ty(' CupertinoThemeData'), _id(' theme = '), _ty('CupertinoTheme'), _id('.of(context);')],
          <TextSpan>[],
          <TextSpan>[_cmt('// Resolve a dynamic color')],
          <TextSpan>[_kw('final'), _ty(' Color'), _id(' tint = '), _ty('CupertinoDynamicColor'), _id('.resolve(theme.primaryColor, context);')],
          <TextSpan>[],
          <TextSpan>[_cmt('// Override just one field')],
          <TextSpan>[_ty('CupertinoTheme'), _id('(')],
          <TextSpan>[_id('  data: theme.copyWith(primaryColor: '), _ty('CupertinoColors'), _id('.systemPink),')],
          <TextSpan>[_id('  child: child,')],
          <TextSpan>[_id(');')],
          <TextSpan>[],
          <TextSpan>[_cmt('// Custom text theme')],
          <TextSpan>[_ty('CupertinoTheme'), _id('(')],
          <TextSpan>[_id('  data: theme.copyWith(')],
          <TextSpan>[_id('    textTheme: theme.textTheme.copyWith(')],
          <TextSpan>[_id('      textStyle: '), _ty('TextStyle'), _id('(fontSize: '), _num_('15.5'), _id('),')],
          <TextSpan>[_id('    ),')],
          <TextSpan>[_id('  ),')],
          <TextSpan>[_id('  child: child,')],
          <TextSpan>[_id(');')],
        ]),
      ],
    ),
  );
}

Widget _footerCard() {
  return _card(
    background: const Color(0xFF1C1C1E),
    borderColor: _kHairlineDark,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'CupertinoTheme is small on purpose.',
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 18.0,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 6.0),
        const Text(
          'When iOS gets a new appearance, the same eight CupertinoDynamicColor '
          'slots feed the whole UI. The job of a theme is to declare the few '
          'choices an app actually wants to override - everything else inherits.',
          style: TextStyle(color: _kInkOnDarkSecondary, fontSize: 13.5, height: 1.5),
        ),
        const SizedBox(height: 10.0),
        Row(
          children: <Widget>[
            _miniSwatch(_kAccent, size: 20.0),
            const SizedBox(width: 6.0),
            _miniSwatch(_kAccentIndigo, size: 20.0),
            const SizedBox(width: 6.0),
            _miniSwatch(_kAccentGreen, size: 20.0),
            const SizedBox(width: 6.0),
            _miniSwatch(_kAccentOrange, size: 20.0),
            const SizedBox(width: 6.0),
            _miniSwatch(_kAccentPink, size: 20.0),
            const SizedBox(width: 6.0),
            _miniSwatch(_kAccentTeal, size: 20.0),
            const SizedBox(width: 6.0),
            _miniSwatch(_kAccentPurple, size: 20.0),
          ],
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// HERO HEADER
// ---------------------------------------------------------------------------
Widget _heroHeader() {
  return Container(
    margin: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0.0),
    padding: const EdgeInsets.fromLTRB(18.0, 22.0, 18.0, 22.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          Color(0xFF007AFF),
          Color(0xFF5856D6),
        ],
      ),
      borderRadius: BorderRadius.circular(16.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: const <Widget>[
            Icon(CupertinoIcons.paintbrush_fill, color: Color(0xFFFFFFFF), size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'CUPERTINO THEMING DEEP DIVE',
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 11.5,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        const Text(
          'CupertinoTheme and CupertinoThemeData',
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 26.0,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
            height: 1.15,
          ),
        ),
        const SizedBox(height: 4.0),
        const Text(
          'A visual reference for the seven fields of CupertinoThemeData, '
          'the eight styles of CupertinoTextThemeData and the resolution rules '
          'of CupertinoDynamicColor.',
          style: TextStyle(
            color: Color(0xE6FFFFFF),
            fontSize: 14.0,
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// ENTRY POINT
// ---------------------------------------------------------------------------
// The d4rt analyzer-free interpreter looks for a top-level
// `dynamic build(BuildContext context)` function. We render the entire
// poster inside a Material/Scaffold backdrop because the host harness
// already provides MaterialApp, but every section is otherwise
// self-contained.
dynamic build(BuildContext context) {
  return Container(
    color: _kCanvas,
    child: SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _heroHeader(),
          _sectionHeader(1, 'Anatomy of the theme object', 'How the fields of CupertinoThemeData hang together'),
          _introCard(),
          _fieldsTable(),
          _anatomyDiagram(),
          _sectionDivider(),
          _sectionHeader(2, 'Brightness diptych', 'Same defaults, two appearances'),
          _brightnessDiptych(),
          _sectionDivider(),
          _sectionHeader(3, 'The eight text styles', 'CupertinoTextThemeData in full'),
          _textThemeCatalog(),
          _sectionDivider(),
          _sectionHeader(4, 'Icons follow the primary tint', 'CupertinoIconThemeData derivation'),
          _iconThemeCard(),
          _sectionDivider(),
          _sectionHeader(5, 'Resolving CupertinoDynamicColor', 'Eight variants, one flat Color'),
          _dynamicResolveCard(),
          _sectionDivider(),
          _sectionHeader(6, 'Cupertino vs Material', 'Different choices on the same subject'),
          _compareMatrix(),
          _sectionDivider(),
          _sectionHeader(7, 'Worked theme override', 'CupertinoTheme(data: ..., child: ...)'),
          _overrideCard(),
          _sectionDivider(),
          _sectionHeader(8, 'Pitfalls & cheatsheet', 'Six callouts and a quick-reference card'),
          _pitfallsCard(),
          _cheatsheetCard(),
          const SizedBox(height: 10.0),
          _footerCard(),
        ],
      ),
    ),
  );
}
