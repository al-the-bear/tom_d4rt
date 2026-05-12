// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unused_element, dead_code, unnecessary_import, no_leading_underscores_for_local_identifiers, prefer_const_constructors, prefer_const_literals_to_create_immutables
// D4rt test script: Deep visual demo of Flutter's Cupertino list widget family.
//
// This script is part of the D4rt flutter-test corpus. It runs inside a
// sandboxed, analyzer-free Dart interpreter and exposes a single
// top-level entry point - `dynamic build(BuildContext context)` - which
// is invoked once and returns a Widget tree.
//
// The rendered output is a long, static gallery that walks through the
// `flutter/cupertino` list-widget family, namely:
//
//   * `CupertinoListSection`        - grouped iOS-style container
//       - .insetGrouped               (rounded inset card, iOS 13+ default)
//       - plain (default)             (flat full-bleed group)
//       - header / footer slots
//       - dividerMargin, additionalDividerMargin, separatorColor
//       - decoration, backgroundColor, margin, topMargin, hasLeading
//       - clipBehavior
//   * `CupertinoListTile`           - the row primitive
//       - default and .notched variants
//       - leading, title, subtitle, additionalInfo, trailing
//       - backgroundColor, backgroundColorActivated
//       - padding, leadingSize, leadingToTitle, onTap
//   * `CupertinoFormSection`        - section tuned for form rows
//   * `CupertinoFormRow`            - prefix / helper / error wrapper
//   * `CupertinoTextFormFieldRow`   - editable form text field
//
// Each section is followed by a code block illustrating idiomatic usage,
// a side-by-side comparison panel where applicable, a pitfalls panel
// with callouts and finally a cheat-sheet footer.  Because the script
// runs in a static, no-interaction environment, every callback is
// either `null` (disabled state) or `(_) {}` (a no-op consumer).  No
// `setState`, `Timer`, `Future`, `Stream`, `async`, live
// `AnimationController`, or `Tween.animate(...).value` reads are used.
import 'dart:ui' show FontFeature;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

// ---------------------------------------------------------------------------
// COLOR & TYPOGRAPHY CONSTANTS
// ---------------------------------------------------------------------------
// The demo deliberately mixes two kinds of color values:
//
//   * Plain `const Color(0xAARRGGBB)` literals for chrome (cards, dividers,
//     code blocks).  These are picked to feel iOS-native but do not depend
//     on a live `CupertinoTheme`, which keeps the section helpers cheap to
//     build and easy to reason about.
//
//   * `CupertinoColors.*` references resolved against `context` inside the
//     `build` entry point.  These are used wherever the goal is to *show*
//     how the real Cupertino list widgets paint themselves.
//
// The constants below are kept close to the real iOS palette so that any
// section rendered without a `CupertinoTheme` still feels native.
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
const Color _kAccent = Color(0xFF007AFF); // systemBlue resolved (light)
const Color _kAccentGreen = Color(0xFF34C759);
const Color _kAccentOrange = Color(0xFFFF9500);
const Color _kAccentRed = Color(0xFFFF3B30);
const Color _kAccentIndigo = Color(0xFF5856D6);
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
const Color _kPitfallBg = Color(0xFFFFF7E6);
const Color _kPitfallBorder = Color(0xFFFFC773);
const Color _kPitfallInk = Color(0xFF7A4B00);
const Color _kRecipeBg = Color(0xFFEAF4FF);
const Color _kRecipeBorder = Color(0xFFB9D7F9);

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
  fontSize: 11.0,
  fontFamily: 'monospace',
  fontFeatures: <FontFeature>[FontFeature.tabularFigures()],
  color: _kInkSecondary,
);
const TextStyle _kCodeStyle = TextStyle(
  fontSize: 12.5,
  fontFamily: 'monospace',
  color: _kCodeText,
  height: 1.4,
  fontFeatures: <FontFeature>[FontFeature.tabularFigures()],
);
const TextStyle _kAnnotationStyle = TextStyle(
  fontSize: 10.5,
  fontWeight: FontWeight.w600,
  color: _kAccent,
  letterSpacing: 0.1,
);
const EdgeInsets _kCardPadding = EdgeInsets.all(18.0);
const EdgeInsets _kSectionPadding = EdgeInsets.symmetric(horizontal: 18.0);

// ---------------------------------------------------------------------------
// PRIVATE HELPERS
// ---------------------------------------------------------------------------
// All helpers are top-level `_camelCase` functions returning `Widget`s.
// They are intentionally not made into `StatelessWidget` subclasses so the
// file can be read top-to-bottom and so the interpreter does not have to
// build a Widget element tree just to invoke a helper.
// ---------------------------------------------------------------------------

Widget _sectionHeader(int index, String title, String tagline) {
  return Padding(
    padding: const EdgeInsets.only(top: 30.0, bottom: 12.0, left: 18.0, right: 18.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 36.0,
          height: 36.0,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: _kAccent,
            shape: BoxShape.circle,
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

Widget _sectionDivider() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 16.0),
    child: Container(
      height: 1.0,
      color: _kHairline,
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

Widget _cardTitle(String title, {String? subtitle, Color titleColor = _kInk, Color subtitleColor = _kInkSecondary}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        title,
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w700,
          color: titleColor,
          letterSpacing: -0.2,
        ),
      ),
      if (subtitle != null) ...<Widget>[
        const SizedBox(height: 3.0),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 12.0,
            color: subtitleColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ],
  );
}

Widget _codeBlock(List<TextSpan> spans) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
    decoration: BoxDecoration(
      color: _kCodeBg,
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: RichText(
      text: TextSpan(style: _kCodeStyle, children: spans),
    ),
  );
}

TextSpan _kw(String s) => TextSpan(text: s, style: const TextStyle(color: _kCodeKeyword, fontWeight: FontWeight.w700));
TextSpan _ty(String s) => TextSpan(text: s, style: const TextStyle(color: _kCodeType, fontWeight: FontWeight.w600));
TextSpan _str(String s) => TextSpan(text: s, style: const TextStyle(color: _kCodeString));
TextSpan _id(String s) => TextSpan(text: s, style: const TextStyle(color: _kCodeAccent));
TextSpan _cm(String s) => TextSpan(text: s, style: const TextStyle(color: _kCodeComment));
TextSpan _tx(String s) => TextSpan(text: s);

Widget _annotation(String text) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
    decoration: BoxDecoration(
      color: const Color(0x1A007AFF),
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(color: const Color(0x33007AFF)),
    ),
    child: Text(text, style: _kAnnotationStyle),
  );
}

Widget _pitfall(String title, String body) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6.0),
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: _kPitfallBg,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: _kPitfallBorder),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(top: 1.0),
          child: Icon(CupertinoIcons.exclamationmark_triangle_fill, color: _kAccentOrange, size: 18.0),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                  color: _kPitfallInk,
                ),
              ),
              const SizedBox(height: 3.0),
              Text(
                body,
                style: const TextStyle(
                  fontSize: 12.5,
                  color: _kPitfallInk,
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

Widget _legendDot(Color color, String label) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      children: <Widget>[
        Container(
          width: 10.0,
          height: 10.0,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8.0),
        Expanded(child: Text(label, style: _kCaptionStyle)),
      ],
    ),
  );
}

Widget _propRow(String name, String typ, String description) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 150.0,
          child: Text(
            name,
            style: const TextStyle(
              fontSize: 12.0,
              fontFamily: 'monospace',
              color: _kInk,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(
          width: 100.0,
          child: Text(
            typ,
            style: const TextStyle(
              fontSize: 11.0,
              fontFamily: 'monospace',
              color: _kAccentIndigo,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: Text(
            description,
            style: const TextStyle(fontSize: 12.5, color: _kInkSecondary, height: 1.4),
          ),
        ),
      ],
    ),
  );
}

Widget _arrowLabel(String text, {Color color = _kAccent}) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
        decoration: BoxDecoration(
          color: color.withOpacity(0.12),
          borderRadius: BorderRadius.circular(6.0),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 10.5,
            fontWeight: FontWeight.w700,
            color: color,
            letterSpacing: 0.1,
          ),
        ),
      ),
      const SizedBox(width: 4.0),
      Icon(CupertinoIcons.arrow_right, size: 12.0, color: color),
    ],
  );
}

// ---------------------------------------------------------------------------
// Build entry point.
// ---------------------------------------------------------------------------
dynamic build(BuildContext context) {
  print('Cupertino list widgets deep visual demo executing');

  // -------------------------------------------------------------------------
  // SECTION 1 - HERO INTRO
  // -------------------------------------------------------------------------
  // The hero card frames the entire demo. The Cupertino list family is built
  // around three layered primitives:
  //
  //   * `CupertinoListSection`   - the outer iOS group container.  Provides
  //                                background, rounded corners (inset), header
  //                                and footer slots and the separator color
  //                                between rows.
  //   * `CupertinoListTile`      - the row primitive.  Looks like the cells in
  //                                the iOS Settings app: leading icon, title,
  //                                subtitle, additional info, trailing slot.
  //   * `CupertinoFormSection`   - a section variant tuned for form rows
  //                                (`CupertinoFormRow`, `CupertinoTextFormFieldRow`).
  //
  // The hero block also highlights the two enum-driven styles (`base`, the
  // edge-to-edge style, and `insetGrouped`, the rounded card style that ships
  // as the iOS Settings default since iOS 13).
  // -------------------------------------------------------------------------
  print('  building section 1 - hero intro');
  final Widget heroIntro = Container(
    margin: const EdgeInsets.fromLTRB(18.0, 24.0, 18.0, 8.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFF0A84FF), Color(0xFF5E5CE6), Color(0xFFBF5AF2)],
      ),
      borderRadius: BorderRadius.circular(18.0),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x33000000),
          offset: Offset(0.0, 8.0),
          blurRadius: 24.0,
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: const <Widget>[
            Icon(CupertinoIcons.list_bullet_indent, color: Color(0xFFFFFFFF), size: 26.0),
            SizedBox(width: 10.0),
            Text(
              'Cupertino lists',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w800,
                color: Color(0xFFFFFFFF),
                letterSpacing: -0.6,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        const Text(
          'iOS-style grouped lists, form sections and notched list tiles.',
          style: TextStyle(
            fontSize: 14.0,
            color: Color(0xCCFFFFFF),
            height: 1.4,
          ),
        ),
        const SizedBox(height: 14.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: const <Widget>[
            _HeroChip(label: 'section', value: 'CupertinoListSection'),
            _HeroChip(label: 'tile', value: 'CupertinoListTile'),
            _HeroChip(label: 'form', value: 'CupertinoFormSection'),
            _HeroChip(label: 'row', value: 'CupertinoFormRow'),
            _HeroChip(label: 'field', value: 'CupertinoTextFormFieldRow'),
          ],
        ),
        const SizedBox(height: 14.0),
        const Text(
          'CupertinoListSection wraps a list of tiles in an iOS-native grouped container. '
          'Use the default ".base" style for full-bleed groups that hug the screen edges, '
          'and ".insetGrouped" for the rounded-card look adopted by Settings since iOS 13. '
          'CupertinoListTile is the row primitive: it places leading, title, subtitle, '
          'additionalInfo and trailing slots in a layout that adapts to the section type '
          'around it.',
          style: TextStyle(
            fontSize: 13.5,
            color: Color(0xEEFFFFFF),
            height: 1.45,
          ),
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 2 - CupertinoListSection anatomy with annotated screenshot
  // -------------------------------------------------------------------------
  // We render a single, fully-populated `CupertinoListSection.insetGrouped`
  // and pair it with a callout column that annotates each visible part:
  //   - header
  //   - top margin
  //   - left margin (insetGrouped only)
  //   - rounded card with sectioned tiles
  //   - dividers between tiles
  //   - separatorColor
  //   - additionalDividerMargin (gap before the first divider when hasLeading)
  //   - footer
  // -------------------------------------------------------------------------
  print('  building section 2 - anatomy');
  final Widget anatomySection = CupertinoListSection.insetGrouped(
    header: const Text('GENERAL'),
    footer: const Text('Tap any row to drill down.  This footer text typically explains the section to the user.'),
    additionalDividerMargin: 6.0,
    dividerMargin: 16.0,
    hasLeading: true,
    margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
    backgroundColor: _kCanvas,
    decoration: BoxDecoration(
      color: _kCardBg,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _kHairline),
    ),
    separatorColor: const Color(0xFFD0D0D5),
    topMargin: 16.0,
    clipBehavior: Clip.hardEdge,
    children: const <Widget>[
      CupertinoListTile(
        leading: Icon(CupertinoIcons.airplane, color: _kAccentOrange),
        title: Text('Airplane mode'),
        trailing: CupertinoListTileChevron(),
      ),
      CupertinoListTile(
        leading: Icon(CupertinoIcons.wifi, color: _kAccent),
        title: Text('Wi-Fi'),
        additionalInfo: Text('TomNet'),
        trailing: CupertinoListTileChevron(),
      ),
      CupertinoListTile(
        leading: Icon(CupertinoIcons.bluetooth, color: _kAccent),
        title: Text('Bluetooth'),
        additionalInfo: Text('On'),
        trailing: CupertinoListTileChevron(),
      ),
      CupertinoListTile(
        leading: Icon(CupertinoIcons.antenna_radiowaves_left_right, color: _kAccentGreen),
        title: Text('Cellular'),
        trailing: CupertinoListTileChevron(),
      ),
      CupertinoListTile(
        leading: Icon(CupertinoIcons.personalhotspot, color: _kAccentGreen),
        title: Text('Personal hotspot'),
        additionalInfo: Text('Off'),
        trailing: CupertinoListTileChevron(),
      ),
    ],
  );

  final Widget anatomyAnnotations = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _annotation('header: Text'),
      const SizedBox(height: 6.0),
      Text(
        'The all-caps "GENERAL" line.  Rendered above the card with '
        'tertiary ink color.  Defaults to a 16dp top inset; override '
        'with topMargin.',
        style: _kBodyStyle,
      ),
      const SizedBox(height: 12.0),
      _annotation('margin'),
      const SizedBox(height: 6.0),
      Text(
        'Outer EdgeInsets around the rounded card.  insetGrouped uses '
        '~14dp horizontal by default; override per-section to align '
        'with custom chrome.',
        style: _kBodyStyle,
      ),
      const SizedBox(height: 12.0),
      _annotation('decoration'),
      const SizedBox(height: 6.0),
      Text(
        'BoxDecoration of the rounded card.  Use this to tint the '
        'group while keeping the section behavior; pass null to fall '
        'back to the theme default.',
        style: _kBodyStyle,
      ),
      const SizedBox(height: 12.0),
      _annotation('hasLeading'),
      const SizedBox(height: 6.0),
      Text(
        'When true, dividers between tiles start to the right of the '
        'leading column (creates the iOS Settings indent).  '
        'additionalDividerMargin adds extra inset on top of that.',
        style: _kBodyStyle,
      ),
      const SizedBox(height: 12.0),
      _annotation('separatorColor + dividerMargin'),
      const SizedBox(height: 6.0),
      Text(
        'separatorColor paints the hairline between tiles.  dividerMargin '
        'sets where it starts from the left edge of the card.',
        style: _kBodyStyle,
      ),
      const SizedBox(height: 12.0),
      _annotation('footer: Text'),
      const SizedBox(height: 6.0),
      Text(
        'Caption-style text below the card.  Wraps to multiple lines '
        'and inherits the tertiary ink color.',
        style: _kBodyStyle,
      ),
    ],
  );

  final Widget anatomyCodeBlock = _codeBlock(<TextSpan>[
    _kw('final'), _tx(' '), _ty('Widget'), _tx(' section = '), _id('CupertinoListSection'), _tx('.'), _id('insetGrouped'), _tx('(\n'),
    _tx('  header: '), _ty('Text'), _tx('('), _str("'GENERAL'"), _tx('),\n'),
    _tx('  footer: '), _ty('Text'), _tx('('), _str("'Tap any row...'"), _tx('),\n'),
    _tx('  additionalDividerMargin: '), _id('6.0'), _tx(',\n'),
    _tx('  dividerMargin: '), _id('16.0'), _tx(',\n'),
    _tx('  hasLeading: '), _kw('true'), _tx(',\n'),
    _tx('  separatorColor: '), _ty('Color'), _tx('('), _id('0xFFD0D0D5'), _tx('),\n'),
    _tx('  topMargin: '), _id('16.0'), _tx(',\n'),
    _tx('  margin: '), _ty('EdgeInsets'), _tx('.'), _id('symmetric'), _tx('(horizontal: '), _id('12.0'), _tx('),\n'),
    _tx('  clipBehavior: '), _ty('Clip'), _tx('.'), _id('hardEdge'), _tx(',\n'),
    _tx('  children: '), _kw('const'), _tx(' <'), _ty('Widget'), _tx('>['), _tx('\n'),
    _tx('    '), _id('CupertinoListTile'), _tx('(...),'), _tx('\n'),
    _tx('  ],\n'),
    _tx(');'),
  ]);

  // -------------------------------------------------------------------------
  // SECTION 3 - insetGrouped vs plain (`.base`) side-by-side
  // -------------------------------------------------------------------------
  // Two sections rendered with the *same* children but different
  // constructors.  The plain (`.base`) variant goes edge-to-edge and uses
  // flat full-width dividers.  `.insetGrouped` wraps the rows in a rounded
  // card with horizontal margin and lifts the section type to the iOS-13+
  // grouped style.
  // -------------------------------------------------------------------------
  print('  building section 3 - inset vs plain');
  final List<Widget> _sharedRows = <Widget>[
    const CupertinoListTile(
      leading: Icon(CupertinoIcons.person_crop_circle, color: _kAccent),
      title: Text('Apple ID'),
      subtitle: Text('Account, Family Sharing, iCloud'),
      trailing: CupertinoListTileChevron(),
    ),
    const CupertinoListTile(
      leading: Icon(CupertinoIcons.lock_shield, color: _kAccentGreen),
      title: Text('Privacy & Security'),
      trailing: CupertinoListTileChevron(),
    ),
    const CupertinoListTile(
      leading: Icon(CupertinoIcons.bell_fill, color: _kAccentRed),
      title: Text('Notifications'),
      additionalInfo: Text('Allowed'),
      trailing: CupertinoListTileChevron(),
    ),
  ];

  final Widget plainSection = CupertinoListSection(
    header: const Text('PLAIN / .base'),
    children: _sharedRows,
  );

  final Widget insetSection = CupertinoListSection.insetGrouped(
    header: const Text('INSET / .insetGrouped'),
    children: _sharedRows,
  );

  final Widget insetVsPlainTable = Container(
    decoration: BoxDecoration(
      color: const Color(0xFFFAFAFC),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: _kHairline),
    ),
    padding: const EdgeInsets.all(12.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Side-by-side comparison',
          style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w700, color: _kInk),
        ),
        const SizedBox(height: 8.0),
        _propRow('CupertinoListSectionType', 'enum', '.base vs .insetGrouped switches the painting and clipping.'),
        _propRow('outer margin', 'EdgeInsets', 'Plain: zero.  Inset: ~14dp horizontal so the card floats.'),
        _propRow('corner radius', 'double', 'Plain: 0.  Inset: ~10dp rounded card.'),
        _propRow('divider style', 'Color/double', 'Plain: full-width hairline.  Inset: indented hairline.'),
        _propRow('use when', 'guidance', 'Plain: full-bleed lists.  Inset: settings/preferences with header+footer.'),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 4 - CupertinoListTile.notched variant demo
  // -------------------------------------------------------------------------
  // The `.notched` constructor is the variant used when the surrounding
  // section type is base (or when you build the row standalone).  Notched
  // tiles use a larger leading size (`leadingSize`), more leading-to-title
  // spacing (`leadingToTitle`) and a slightly different vertical padding
  // contract.  We render three pairs of (default, notched) rows so the
  // difference becomes visible.
  // -------------------------------------------------------------------------
  print('  building section 4 - notched variant');
  final Widget defaultTileA = const CupertinoListTile(
    leading: Icon(CupertinoIcons.wifi, color: _kAccent),
    title: Text('Wi-Fi'),
    subtitle: Text('TomNet'),
    additionalInfo: Text('Connected'),
    trailing: CupertinoListTileChevron(),
  );
  final Widget notchedTileA = CupertinoListTile.notched(
    leading: const Icon(CupertinoIcons.wifi, color: _kAccent),
    title: const Text('Wi-Fi'),
    subtitle: const Text('TomNet'),
    additionalInfo: const Text('Connected'),
    trailing: const CupertinoListTileChevron(),
    leadingSize: 32.0,
    leadingToTitle: 14.0,
  );

  final Widget defaultTileB = const CupertinoListTile(
    leading: Icon(CupertinoIcons.bluetooth, color: _kAccent),
    title: Text('Bluetooth'),
    additionalInfo: Text('On'),
    trailing: CupertinoListTileChevron(),
  );
  final Widget notchedTileB = CupertinoListTile.notched(
    leading: const Icon(CupertinoIcons.bluetooth, color: _kAccent),
    title: const Text('Bluetooth'),
    additionalInfo: const Text('On'),
    trailing: const CupertinoListTileChevron(),
    leadingSize: 32.0,
  );

  final Widget defaultTileC = const CupertinoListTile(
    leading: Icon(CupertinoIcons.battery_100, color: _kAccentGreen),
    title: Text('Battery'),
    subtitle: Text('Optimised charging enabled'),
    additionalInfo: Text('94%'),
    trailing: CupertinoListTileChevron(),
    backgroundColor: _kCardBg,
    backgroundColorActivated: Color(0xFFE5E5EA),
    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
  );
  final Widget notchedTileC = CupertinoListTile.notched(
    leading: const Icon(CupertinoIcons.battery_100, color: _kAccentGreen),
    title: const Text('Battery'),
    subtitle: const Text('Optimised charging enabled'),
    additionalInfo: const Text('94%'),
    trailing: const CupertinoListTileChevron(),
    backgroundColor: _kCardBg,
    backgroundColorActivated: const Color(0xFFD9D9DE),
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    leadingSize: 32.0,
    leadingToTitle: 14.0,
    onTap: () {},
  );

  final Widget notchedCodeBlock = _codeBlock(<TextSpan>[
    _id('CupertinoListTile'), _tx('.'), _id('notched'), _tx('(\n'),
    _tx('  leading: '), _ty('Icon'), _tx('('), _id('CupertinoIcons'), _tx('.'), _id('battery_100'), _tx('),\n'),
    _tx('  title: '), _ty('Text'), _tx('('), _str("'Battery'"), _tx('),\n'),
    _tx('  subtitle: '), _ty('Text'), _tx('('), _str("'Optimised charging'"), _tx('),\n'),
    _tx('  additionalInfo: '), _ty('Text'), _tx('('), _str("'94%'"), _tx('),\n'),
    _tx('  trailing: '), _ty('CupertinoListTileChevron'), _tx('(),\n'),
    _tx('  backgroundColor: '), _ty('CupertinoColors'), _tx('.'), _id('systemBackground'), _tx(',\n'),
    _tx('  backgroundColorActivated: '), _ty('Color'), _tx('('), _id('0xFFD9D9DE'), _tx('),\n'),
    _tx('  padding: '), _ty('EdgeInsets'), _tx('.'), _id('symmetric'), _tx('(\n'),
    _tx('    horizontal: '), _id('16.0'), _tx(', vertical: '), _id('12.0'), _tx(',\n'),
    _tx('  ),\n'),
    _tx('  leadingSize: '), _id('32.0'), _tx(', '), _cm('// larger square'), _tx('\n'),
    _tx('  leadingToTitle: '), _id('14.0'), _tx(', '), _cm('// more gap'), _tx('\n'),
    _tx('  onTap: () {},\n'),
    _tx(');'),
  ]);

  final Widget notchedDefaultVsNotched = Container(
    margin: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: _kCardBg,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _kHairline),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.fromLTRB(16.0, 14.0, 16.0, 4.0),
          child: Text(
            'Default vs .notched',
            style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700, color: _kInk),
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 10.0),
          child: Text(
            'Same content, different constructor.  Notice the larger leading box and the extra '
            'breathing room between leading and title in the .notched column.',
            style: _kCaptionStyle,
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                    child: Text('default', style: _kAnnotationStyle),
                  ),
                  defaultTileA,
                  Container(height: 1.0, color: _kHairline, margin: const EdgeInsets.symmetric(horizontal: 16.0)),
                  defaultTileB,
                  Container(height: 1.0, color: _kHairline, margin: const EdgeInsets.symmetric(horizontal: 16.0)),
                  defaultTileC,
                ],
              ),
            ),
            Container(width: 1.0, height: 260.0, color: _kHairline),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                    child: Text('.notched', style: _kAnnotationStyle),
                  ),
                  notchedTileA,
                  Container(height: 1.0, color: _kHairline, margin: const EdgeInsets.symmetric(horizontal: 16.0)),
                  notchedTileB,
                  Container(height: 1.0, color: _kHairline, margin: const EdgeInsets.symmetric(horizontal: 16.0)),
                  notchedTileC,
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 5 - CupertinoFormSection gallery
  // -------------------------------------------------------------------------
  // `CupertinoFormSection` is a sibling of `CupertinoListSection` tuned for
  // forms.  Its child slot expects `CupertinoFormRow`s (or
  // `CupertinoTextFormFieldRow`s).  The form row exposes a `prefix` slot
  // (label), a `helper` line, an `error` line and a centered child slot.
  // We render the four common compositions:
  //
  //   - simple text field
  //   - text field with helper text
  //   - text field with prefix label
  //   - generic form row hosting a switch and a slider
  //
  // We also expose a non-editable preview of `CupertinoTextFormFieldRow`'s
  // padding / placeholder / decoration knobs.
  // -------------------------------------------------------------------------
  print('  building section 5 - form section gallery');
  final Widget formFieldA = CupertinoTextFormFieldRow(
    prefix: const Text('Name'),
    placeholder: 'Tom Forge',
    textCapitalization: TextCapitalization.words,
    style: const TextStyle(fontSize: 16.0, color: _kInk),
  );
  final Widget formFieldB = CupertinoTextFormFieldRow(
    prefix: const Text('Email'),
    placeholder: 'tom@example.com',
    keyboardType: TextInputType.emailAddress,
    autocorrect: false,
    style: const TextStyle(fontSize: 16.0, color: _kInk),
  );
  final Widget formFieldC = CupertinoFormRow(
    prefix: const Text('Username'),
    helper: const Text('Letters, numbers and underscores only.', style: _kCaptionStyle),
    child: SizedBox(
      width: 180.0,
      child: CupertinoTextFormFieldRow(
        placeholder: 'tom_the_builder',
        style: const TextStyle(fontSize: 16.0, color: _kInk),
        padding: EdgeInsets.zero,
      ),
    ),
  );
  final Widget formFieldD = CupertinoFormRow(
    prefix: const Text('Password'),
    error: const Text('Password must be at least 8 characters.', style: TextStyle(fontSize: 12.0, color: _kAccentRed)),
    child: SizedBox(
      width: 180.0,
      child: CupertinoTextFormFieldRow(
        placeholder: 'Required',
        obscureText: true,
        style: const TextStyle(fontSize: 16.0, color: _kInk),
        padding: EdgeInsets.zero,
      ),
    ),
  );

  final Widget formRowSwitch = CupertinoFormRow(
    prefix: const Text('Notifications'),
    helper: const Text('Receive build status pings on success and failure.', style: _kCaptionStyle),
    child: CupertinoSwitch(value: true, onChanged: (bool v) {}),
  );
  final Widget formRowSlider = CupertinoFormRow(
    prefix: const Text('Volume'),
    helper: const Text('Default ringtone volume for incoming alerts.', style: _kCaptionStyle),
    child: SizedBox(
      width: 160.0,
      child: CupertinoSlider(
        value: 0.6,
        min: 0.0,
        max: 1.0,
        onChanged: (double v) {},
      ),
    ),
  );
  final Widget formRowSegmented = CupertinoFormRow(
    prefix: const Text('Theme'),
    helper: const Text('Choose the appearance the section paints with.', style: _kCaptionStyle),
    child: SizedBox(
      width: 180.0,
      child: CupertinoSegmentedControl<int>(
        groupValue: 1,
        onValueChanged: (int v) {},
        children: const <int, Widget>{
          0: Padding(padding: EdgeInsets.symmetric(horizontal: 8.0), child: Text('Light')),
          1: Padding(padding: EdgeInsets.symmetric(horizontal: 8.0), child: Text('Auto')),
          2: Padding(padding: EdgeInsets.symmetric(horizontal: 8.0), child: Text('Dark')),
        },
      ),
    ),
  );

  final Widget formSectionGallery = CupertinoFormSection.insetGrouped(
    header: const Text('SIGN UP'),
    footer: const Text('All fields are required.  Email is used for build notifications only.'),
    margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
    children: <Widget>[
      formFieldA,
      formFieldB,
      formFieldC,
      formFieldD,
    ],
  );

  final Widget formControlsSection = CupertinoFormSection.insetGrouped(
    header: const Text('CONTROLS'),
    footer: const Text('Generic CupertinoFormRow accepts any Widget in its child slot.'),
    margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
    children: <Widget>[
      formRowSwitch,
      formRowSlider,
      formRowSegmented,
    ],
  );

  final Widget formCodeBlock = _codeBlock(<TextSpan>[
    _id('CupertinoFormSection'), _tx('.'), _id('insetGrouped'), _tx('(\n'),
    _tx('  header: '), _ty('Text'), _tx('('), _str("'SIGN UP'"), _tx('),\n'),
    _tx('  footer: '), _ty('Text'), _tx('('), _str("'All fields...'"), _tx('),\n'),
    _tx('  children: <'), _ty('Widget'), _tx('>[\n'),
    _tx('    '), _id('CupertinoTextFormFieldRow'), _tx('(\n'),
    _tx('      prefix: '), _ty('Text'), _tx('('), _str("'Name'"), _tx('),\n'),
    _tx('      placeholder: '), _str("'Tom Forge'"), _tx(',\n'),
    _tx('    ),\n'),
    _tx('    '), _id('CupertinoFormRow'), _tx('(\n'),
    _tx('      prefix: '), _ty('Text'), _tx('('), _str("'Notifications'"), _tx('),\n'),
    _tx('      helper: '), _ty('Text'), _tx('('), _str("'Build pings...'"), _tx('),\n'),
    _tx('      child: '), _ty('CupertinoSwitch'), _tx('(value: '), _kw('true'), _tx(', onChanged: ...),\n'),
    _tx('    ),\n'),
    _tx('  ],\n'),
    _tx(');'),
  ]);

  // -------------------------------------------------------------------------
  // SECTION 6 - CupertinoListTile vs Material ListTile comparison
  // -------------------------------------------------------------------------
  // Both APIs target the same conceptual cell (icon + headline + supporting
  // text + trailing).  This section sketches the property-mapping matrix
  // and renders the two side by side so the visual differences (typography,
  // spacing, divider treatment) are visible without leaving the file.
  // -------------------------------------------------------------------------
  print('  building section 6 - cupertino vs material');
  final Widget materialPreview = Material(
    color: _kCardBg,
    child: ListTile(
      leading: const Icon(Icons.wifi, color: _kAccent),
      title: const Text('Wi-Fi'),
      subtitle: const Text('TomNet'),
      trailing: const Text('Connected', style: TextStyle(color: _kInkTertiary)),
      onTap: () {},
    ),
  );

  final Widget cupertinoPreview = const CupertinoListTile(
    leading: Icon(CupertinoIcons.wifi, color: _kAccent),
    title: Text('Wi-Fi'),
    subtitle: Text('TomNet'),
    additionalInfo: Text('Connected'),
    trailing: CupertinoListTileChevron(),
  );

  final Widget comparisonMatrix = Container(
    margin: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: _kCardBg,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _kHairline),
    ),
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle('Property mapping', subtitle: 'How CupertinoListTile slots map to Material ListTile slots.'),
        const SizedBox(height: 10.0),
        _propRow('leading',         'Widget?',  'Identical.  Cupertino expects 28-32dp square; Material 40dp.'),
        _propRow('title',           'Widget?',  'Identical.  Cupertino caps at one line by default.'),
        _propRow('subtitle',        'Widget?',  'Identical.  Cupertino prefers a single line below title.'),
        _propRow('additionalInfo',  'Widget?',  'Cupertino-only.  Right-aligned text before the chevron.'),
        _propRow('trailing',        'Widget?',  'Identical.  Use CupertinoListTileChevron for drill-down.'),
        _propRow('backgroundColor', 'Color?',   'Cupertino: per-tile background.  Material: use Container/Material.'),
        _propRow('backgroundColorActivated', 'Color?', 'Cupertino-only.  Painted while pressed.'),
        _propRow('onTap',           'VoidCallback?', 'Identical.  Both render a press feedback when non-null.'),
        _propRow('padding',         'EdgeInsets?',   'Cupertino-only.  Material uses contentPadding instead.'),
        _propRow('leadingSize',     'double?',       'Cupertino-only.  Controls the leading icon box.'),
        _propRow('leadingToTitle',  'double?',       'Cupertino-only.  Horizontal gap to title column.'),
        const SizedBox(height: 14.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.all(6.0),
                    child: Text('Material', style: _kAnnotationStyle),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: _kHairline),
                    ),
                    child: materialPreview,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.all(6.0),
                    child: Text('Cupertino', style: _kAnnotationStyle),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: _kHairline),
                    ),
                    child: cupertinoPreview,
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
  // SECTION 7 - Recipe cards
  // -------------------------------------------------------------------------
  // Four common compositions any iOS-style app eventually needs.  Each
  // recipe renders the final widget and is preceded by a small "what it
  // demonstrates" caption.
  //
  //   recipe A   Settings screen (mixed icons + chevrons + info)
  //   recipe B   Toggles section (CupertinoSwitch trailing)
  //   recipe C   Profile card (avatar leading + multi-line)
  //   recipe D   Compact form (Field + helper + error)
  // -------------------------------------------------------------------------
  print('  building section 7 - recipe cards');
  final Widget recipeA = CupertinoListSection.insetGrouped(
    header: const Text('GENERAL'),
    margin: const EdgeInsets.all(8.0),
    children: const <Widget>[
      CupertinoListTile(
        leading: Icon(CupertinoIcons.gear_alt_fill, color: _kInkSecondary),
        title: Text('General'),
        trailing: CupertinoListTileChevron(),
      ),
      CupertinoListTile(
        leading: Icon(CupertinoIcons.bell_fill, color: _kAccentRed),
        title: Text('Notifications'),
        additionalInfo: Text('Allowed'),
        trailing: CupertinoListTileChevron(),
      ),
      CupertinoListTile(
        leading: Icon(CupertinoIcons.volume_up, color: _kAccentPink),
        title: Text('Sounds & Haptics'),
        trailing: CupertinoListTileChevron(),
      ),
      CupertinoListTile(
        leading: Icon(CupertinoIcons.moon_fill, color: _kAccentIndigo),
        title: Text('Focus'),
        additionalInfo: Text('Sleep'),
        trailing: CupertinoListTileChevron(),
      ),
    ],
  );

  final Widget recipeB = CupertinoListSection.insetGrouped(
    header: const Text('TOGGLES'),
    margin: const EdgeInsets.all(8.0),
    children: <Widget>[
      CupertinoListTile(
        leading: const Icon(CupertinoIcons.airplane, color: _kAccentOrange),
        title: const Text('Airplane mode'),
        trailing: CupertinoSwitch(value: false, onChanged: (bool v) {}),
      ),
      CupertinoListTile(
        leading: const Icon(CupertinoIcons.location_solid, color: _kAccent),
        title: const Text('Location services'),
        trailing: CupertinoSwitch(value: true, onChanged: (bool v) {}),
      ),
      CupertinoListTile(
        leading: const Icon(CupertinoIcons.eye_fill, color: _kAccentTeal),
        title: const Text('Hide IP address'),
        trailing: CupertinoSwitch(value: true, onChanged: (bool v) {}),
      ),
      CupertinoListTile(
        leading: const Icon(CupertinoIcons.lock_fill, color: _kAccentGreen),
        title: const Text('Private relay'),
        trailing: CupertinoSwitch(value: false, onChanged: (bool v) {}),
      ),
    ],
  );

  final Widget recipeC = CupertinoListSection.insetGrouped(
    header: const Text('PROFILE'),
    margin: const EdgeInsets.all(8.0),
    children: <Widget>[
      CupertinoListTile.notched(
        leading: Container(
          width: 48.0,
          height: 48.0,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: <Color>[Color(0xFF34C759), Color(0xFF30B0C7)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          alignment: Alignment.center,
          child: const Text(
            'TF',
            style: TextStyle(color: Color(0xFFFFFFFF), fontWeight: FontWeight.w700, fontSize: 18.0),
          ),
        ),
        title: const Text('Tom Forge'),
        subtitle: const Text('tom.forge@example.com'),
        additionalInfo: const Text('Pro'),
        trailing: const CupertinoListTileChevron(),
        leadingSize: 48.0,
        leadingToTitle: 14.0,
      ),
      CupertinoListTile(
        leading: const Icon(CupertinoIcons.creditcard_fill, color: _kAccent),
        title: const Text('Payment & shipping'),
        additionalInfo: const Text('Visa ••1234'),
        trailing: const CupertinoListTileChevron(),
        onTap: () {},
      ),
      CupertinoListTile(
        leading: const Icon(CupertinoIcons.cloud_fill, color: _kAccentTeal),
        title: const Text('iCloud'),
        additionalInfo: const Text('200GB'),
        trailing: const CupertinoListTileChevron(),
        onTap: () {},
      ),
    ],
  );

  final Widget recipeD = CupertinoFormSection.insetGrouped(
    header: const Text('CREATE PROJECT'),
    footer: const Text('Project names are case-sensitive and must be unique.'),
    margin: const EdgeInsets.all(8.0),
    children: <Widget>[
      CupertinoTextFormFieldRow(
        prefix: const Text('Name'),
        placeholder: 'my_amazing_app',
      ),
      CupertinoFormRow(
        prefix: const Text('Folder'),
        helper: const Text('Absolute path on disk.', style: _kCaptionStyle),
        child: SizedBox(
          width: 180.0,
          child: CupertinoTextFormFieldRow(
            placeholder: '/srv/repos',
            padding: EdgeInsets.zero,
          ),
        ),
      ),
      CupertinoFormRow(
        prefix: const Text('Public'),
        helper: const Text('Visible to all workspace members.', style: _kCaptionStyle),
        child: CupertinoSwitch(value: false, onChanged: (bool v) {}),
      ),
    ],
  );

  Widget _recipeCard(String tag, String title, String summary, Widget child) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: _kRecipeBg,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: _kRecipeBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Row(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                  decoration: BoxDecoration(
                    color: const Color(0x33007AFF),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Text(
                    tag,
                    style: const TextStyle(
                      fontSize: 10.5,
                      color: _kAccent,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.4,
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(fontSize: 14.5, fontWeight: FontWeight.w700, color: _kInk),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 10.0),
            child: Text(summary, style: _kCaptionStyle),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            decoration: BoxDecoration(
              color: _kCanvas,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: child,
          ),
          const SizedBox(height: 8.0),
        ],
      ),
    );
  }

  final Widget recipes = Column(
    children: <Widget>[
      _recipeCard(
        'RECIPE A',
        'Settings root',
        'Classic iOS Settings root list.  Icons paired with chevrons and additionalInfo strings.',
        recipeA,
      ),
      _recipeCard(
        'RECIPE B',
        'Toggle group',
        'CupertinoSwitch in the trailing slot. Notice the natural alignment provided by the list section.',
        recipeB,
      ),
      _recipeCard(
        'RECIPE C',
        'Profile card',
        'A notched tile with a 48dp gradient avatar in the leading slot.',
        recipeC,
      ),
      _recipeCard(
        'RECIPE D',
        'Create-project form',
        'CupertinoFormSection with three rows: text field, helper text, generic CupertinoFormRow with a switch.',
        recipeD,
      ),
    ],
  );

  // -------------------------------------------------------------------------
  // SECTION 8 - Pitfalls
  // -------------------------------------------------------------------------
  // Eight callouts gathered from real-world reviews.  These are the kinds of
  // mistakes that survive code review but fall apart in production.
  // -------------------------------------------------------------------------
  print('  building section 8 - pitfalls');
  final Widget pitfalls = _card(
    background: _kCardBg,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle('Pitfalls', subtitle: 'Failure modes that survive code review.'),
        const SizedBox(height: 10.0),
        _pitfall(
          'Mixing dividerMargin and hasLeading',
          'When hasLeading is true the section already pads dividers past the leading column. '
          'Setting dividerMargin to the same value adds the offset twice, producing a visible '
          'misalignment under icons.',
        ),
        _pitfall(
          'Trailing CupertinoSwitch with no onChanged',
          'A CupertinoSwitch with null onChanged renders disabled.  Provide an empty consumer '
          '(v) {} when you want a visually-enabled but stateful switch.',
        ),
        _pitfall(
          'Long subtitles on default tile',
          'CupertinoListTile (default) keeps title and subtitle on the same row.  Long subtitles '
          'truncate.  Use .notched for two-line layouts that wrap naturally.',
        ),
        _pitfall(
          'Padding overrides for accessibility',
          'Custom padding shrinks the hit target.  Keep vertical padding above 10dp so the tile '
          'remains tappable on small devices.',
        ),
        _pitfall(
          'Wrapping in Material ancestor',
          'CupertinoListSection does not require a Material ancestor.  Wrapping it in a Material '
          'tile produces double ink splashes and breaks the activation highlight.',
        ),
        _pitfall(
          'Section margins inside ListView',
          'When embedding sections inside a ListView, set the margin to zero or the ListView '
          'will double-pad rows.  Use Padding outside instead.',
        ),
        _pitfall(
          'CupertinoTextFormFieldRow without onChanged',
          'The form field reports value changes through onChanged in the parent form.  '
          'Forgetting to wire onChanged means initial value is shown but never persisted on submit.',
        ),
        _pitfall(
          'Backgrounds vs theme',
          'backgroundColor on the section overrides the CupertinoTheme.  Pass a '
          'CupertinoDynamicColor (or resolve via context) if the section must adapt to dark mode.',
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 9 - Cheat-sheet legend & summary footer
  // -------------------------------------------------------------------------
  // Final card.  Colour swatches and properties in a single, dense reference
  // panel.  Acts as a navigation aid when scrolling back up.
  // -------------------------------------------------------------------------
  print('  building section 9 - cheat sheet');
  final Widget cheatSheet = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle('Cheat sheet', subtitle: 'Reach-for-it reference for the list widget family.'),
        const SizedBox(height: 10.0),
        _legendDot(_kAccent,        'CupertinoListSection.insetGrouped  ->  rounded card, header + footer'),
        _legendDot(_kAccentIndigo,  'CupertinoListSection                ->  edge-to-edge, full-bleed dividers'),
        _legendDot(_kAccentGreen,   'CupertinoListTile                   ->  one-line title + subtitle + info + trailing'),
        _legendDot(_kAccentOrange,  'CupertinoListTile.notched           ->  larger leading, more breathing room'),
        _legendDot(_kAccentTeal,    'CupertinoFormSection                ->  same shape as list section but for forms'),
        _legendDot(_kAccentPink,    'CupertinoFormRow                    ->  prefix + child + helper + error'),
        _legendDot(_kAccentRed,     'CupertinoTextFormFieldRow           ->  text field wrapped in a CupertinoFormRow'),
        const SizedBox(height: 12.0),
        Container(height: 1.0, color: _kHairline),
        const SizedBox(height: 12.0),
        const Text(
          'A useful rule of thumb: pick .insetGrouped when the section conveys a *settings* meaning '
          '(rounded, padded, header), pick the plain constructor for *content* lists (mail, photos, '
          'logs).  Use the .notched tile when the cell has two or more text lines, and the default '
          'tile when the cell is a one-liner.  Reach for CupertinoFormSection whenever the tiles are '
          'editable.',
          style: _kBodyStyle,
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // Assemble final widget tree
  // -------------------------------------------------------------------------
  print('Assembling final widget tree');
  return CupertinoApp(
    debugShowCheckedModeBanner: false,
    home: CupertinoPageScaffold(
      backgroundColor: _kCanvas,
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Cupertino Lists - Deep Demo'),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // ---- SECTION 1 - hero intro ----
              heroIntro,

              // ---- SECTION 2 - anatomy ----
              _sectionHeader(2, 'CupertinoListSection anatomy',
                  'Every visible part labelled and explained.'),
              _card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _cardTitle('Anatomy of an .insetGrouped section',
                        subtitle: 'Annotated screenshot paired with explanations.'),
                    const SizedBox(height: 12.0),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          flex: 4,
                          child: Container(
                            decoration: BoxDecoration(
                              color: _kCanvas,
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(color: _kHairline),
                            ),
                            padding: const EdgeInsets.all(4.0),
                            child: anatomySection,
                          ),
                        ),
                        const SizedBox(width: 14.0),
                        Expanded(
                          flex: 5,
                          child: anatomyAnnotations,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    anatomyCodeBlock,
                  ],
                ),
              ),

              _sectionDivider(),

              // ---- SECTION 3 - inset vs plain ----
              _sectionHeader(3, 'insetGrouped vs plain',
                  'Side-by-side rendering of the two constructors.'),
              _card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _cardTitle('Same children, different constructor',
                        subtitle: 'CupertinoListSection() vs CupertinoListSection.insetGrouped().'),
                    const SizedBox(height: 12.0),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: _kCanvas,
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(color: _kHairline),
                            ),
                            child: plainSection,
                          ),
                        ),
                        const SizedBox(width: 12.0),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: _kCanvas,
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(color: _kHairline),
                            ),
                            child: insetSection,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14.0),
                    insetVsPlainTable,
                  ],
                ),
              ),

              _sectionDivider(),

              // ---- SECTION 4 - notched variant ----
              _sectionHeader(4, 'CupertinoListTile.notched',
                  'When and why to use the .notched constructor.'),
              _card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _cardTitle('.notched constructor',
                        subtitle: 'Larger leading box, more breathing room, distinct activation color.'),
                    const SizedBox(height: 10.0),
                    Text(
                      'The .notched factory produces a CupertinoListTile that matches the iOS '
                      'Settings.app inset-grouped style: the leading icon sits in a 32dp box, the '
                      'gap between leading and title widens, and the activated background color '
                      'shifts slightly to feel more native on grouped sections.',
                      style: _kBodyStyle,
                    ),
                    const SizedBox(height: 14.0),
                    notchedDefaultVsNotched,
                    const SizedBox(height: 14.0),
                    notchedCodeBlock,
                  ],
                ),
              ),

              _sectionDivider(),

              // ---- SECTION 5 - form section gallery ----
              _sectionHeader(5, 'CupertinoFormSection gallery',
                  'CupertinoFormSection, CupertinoFormRow, CupertinoTextFormFieldRow.'),
              _card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _cardTitle('Forms built on the section family',
                        subtitle: 'CupertinoFormSection is shaped like CupertinoListSection but tuned for editable rows.'),
                    const SizedBox(height: 14.0),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: _kCanvas,
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(color: _kHairline),
                            ),
                            child: formSectionGallery,
                          ),
                        ),
                        const SizedBox(width: 12.0),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: _kCanvas,
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(color: _kHairline),
                            ),
                            child: formControlsSection,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14.0),
                    formCodeBlock,
                    const SizedBox(height: 12.0),
                    _propRow('prefix',         'Widget?',  'Label on the leading edge of the row.  Usually a Text.'),
                    _propRow('helper',         'Widget?',  'Caption-style line below the input, on the same column.'),
                    _propRow('error',          'Widget?',  'Red error line below the input; replaces helper visually.'),
                    _propRow('child',          'Widget',   'Centered input slot - any Widget works (switch, slider, ...).'),
                    _propRow('placeholder',    'String?',  'Greyed placeholder rendered inside the editable field.'),
                    _propRow('keyboardType',   'TextInputType?', 'Drives the on-screen keyboard variant.'),
                    _propRow('obscureText',    'bool',     'Mask characters - use for passwords / secrets.'),
                  ],
                ),
              ),

              _sectionDivider(),

              // ---- SECTION 6 - cupertino vs material ----
              _sectionHeader(6, 'Cupertino vs Material',
                  'Property mapping and a side-by-side preview.'),
              comparisonMatrix,

              _sectionDivider(),

              // ---- SECTION 7 - recipes ----
              _sectionHeader(7, 'Recipes',
                  'Four common compositions you can lift directly.'),
              recipes,

              _sectionDivider(),

              // ---- SECTION 8 - pitfalls ----
              _sectionHeader(8, 'Pitfalls',
                  'Failure modes that survive review and bite later.'),
              pitfalls,

              _sectionDivider(),

              // ---- SECTION 9 - cheat sheet ----
              _sectionHeader(9, 'Cheat sheet',
                  'Single-card reference for the whole family.'),
              cheatSheet,

              const SizedBox(height: 32.0),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'end of demo - cupertino list widget family',
                    style: _kCaptionStyle.copyWith(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Hero chip widget (small private widget used only by the hero intro)
// ---------------------------------------------------------------------------
class _HeroChip extends StatelessWidget {
  final String label;
  final String value;
  const _HeroChip({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      decoration: BoxDecoration(
        color: const Color(0x33FFFFFF),
        borderRadius: BorderRadius.circular(999.0),
        border: Border.all(color: const Color(0x55FFFFFF)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.2,
            ),
          ),
          const SizedBox(width: 6.0),
          Container(
            width: 4.0,
            height: 4.0,
            decoration: const BoxDecoration(
              color: Color(0xCCFFFFFF),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6.0),
          Text(
            value,
            style: const TextStyle(
              color: Color(0xEEFFFFFF),
              fontSize: 11.5,
            ),
          ),
        ],
      ),
    );
  }
}

// End of file.
