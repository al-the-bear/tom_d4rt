// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unused_element, dead_code, unnecessary_import, unused_import, no_leading_underscores_for_local_identifiers
// D4rt test script: Deep visual demo of Material's SegmentedButton.
//
// This file is part of the D4rt flutter-test corpus. It is meant to be
// executed by an analyzer-free, sandboxed Dart interpreter. The script
// exports exactly one top-level entry point - `dynamic build(BuildContext)`
// - which is invoked exactly once and which returns a Widget tree wrapped
// in a `MaterialApp`.
//
// The rendered output is a long, static gallery dedicated to the Material 3
// `SegmentedButton<T>` widget and its supporting types:
//
//   * `SegmentedButton<T>`            - the toggle bar itself
//   * `ButtonSegment<T>`              - one tappable segment
//   * `SegmentedButtonThemeData`      - theme-level styling
//   * `SegmentedButtonTheme`          - inherited theme wrapper
//
// Eleven sections walk through every facet of the API:
//   1. Hero intro card
//   2. API reference table
//   3. Single-selection gallery (five variations)
//   4. Multi-selection gallery (four variations)
//   5. `SegmentedButtonThemeData` showcase
//   6. Disabled `ButtonSegment` showcase
//   7. `Axis.vertical` direction demo
//   8. Six code-block cards (idiomatic usage snippets)
//   9. Comparison table against ToggleButtons / CupertinoSegmentedControl /
//      CupertinoSlidingSegmentedControl / ChoiceChip
//  10. Six pitfalls / common mistakes
//  11. Footer cheat-sheet (chip groups + tagline)
//
// Because the script runs in a static, no-interaction environment, the
// `onSelectionChanged` callback of every `SegmentedButton` is the no-op
// `(_) {}` and the `selected:` argument is always a compile-time literal
// `<T>{...}` set. No `setState`, `Timer`, `Future`, or `AnimationController`
// are used anywhere in this file.
import 'dart:math' as math;
import 'dart:ui' show FontFeature;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

// ---------------------------------------------------------------------------
// COLOUR & TYPOGRAPHY CONSTANTS
// ---------------------------------------------------------------------------
// Literal ARGB constants are used here in preference to `Theme.of(context)`
// look-ups because some helper widgets are constructed before the
// `MaterialApp` is mounted. The palette is roughly aligned with Material 3
// expressive defaults so the demo still looks idiomatic.
const Color _kCanvas = Color(0xFFF6F4FB);
const Color _kCardBg = Color(0xFFFFFFFF);
const Color _kCardSoft = Color(0xFFFBF8FF);
const Color _kCardDark = Color(0xFF1E1B26);
const Color _kHairline = Color(0x14000000);
const Color _kHairlineStrong = Color(0x29000000);
const Color _kInk = Color(0xFF1C1B1F);
const Color _kInkSecondary = Color(0xFF49454F);
const Color _kInkTertiary = Color(0xFF79747E);
const Color _kInkOnDark = Color(0xFFE6E1E5);
const Color _kInkOnDarkSecondary = Color(0xFFCAC4D0);
const Color _kPrimary = Color(0xFF6750A4); // M3 baseline primary
const Color _kPrimaryContainer = Color(0xFFEADDFF);
const Color _kSecondary = Color(0xFF625B71);
const Color _kSecondaryContainer = Color(0xFFE8DEF8);
const Color _kTertiary = Color(0xFF7D5260);
const Color _kTertiaryContainer = Color(0xFFFFD8E4);
const Color _kError = Color(0xFFB3261E);
const Color _kSuccess = Color(0xFF386A20);
const Color _kWarning = Color(0xFFB36B00);
const Color _kInfo = Color(0xFF1F6FEB);
const Color _kAccent = _kPrimary;
const Color _kCodeBg = Color(0xFF1E1F22);
const Color _kCodeText = Color(0xFFE6E6E6);
const Color _kCodeAccent = Color(0xFFB39DDB);
const Color _kCodeKeyword = Color(0xFFFFA657);
const Color _kCodeString = Color(0xFFA5D6A7);
const Color _kCodeComment = Color(0xFF6E7681);
const Color _kCodeBorder = Color(0xFF2A2D32);

const TextStyle _kHeroTitle = TextStyle(
  fontSize: 30.0,
  fontWeight: FontWeight.w800,
  color: Color(0xFFFFFFFF),
  letterSpacing: -0.8,
);
const TextStyle _kHeroSubtitle = TextStyle(
  fontSize: 15.0,
  fontWeight: FontWeight.w500,
  color: Color(0xDDFFFFFF),
);
const TextStyle _kHeroBody = TextStyle(
  fontSize: 14.0,
  height: 1.5,
  color: Color(0xFFFFFFFF),
);
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
const TextStyle _kCardTitleStyle = TextStyle(
  fontSize: 16.0,
  fontWeight: FontWeight.w600,
  color: _kInk,
  letterSpacing: -0.2,
);
const TextStyle _kCardSubtitleStyle = TextStyle(
  fontSize: 12.5,
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
const TextStyle _kBodyMuted = TextStyle(
  fontSize: 13.0,
  height: 1.4,
  color: _kInkSecondary,
);
const TextStyle _kVariantLabel = TextStyle(
  fontSize: 11.5,
  color: _kInkSecondary,
  fontWeight: FontWeight.w500,
  letterSpacing: 0.2,
);
const TextStyle _kCodeStyle = TextStyle(
  fontSize: 12.5,
  fontFamily: 'monospace',
  color: _kCodeText,
  height: 1.4,
  fontFeatures: <FontFeature>[FontFeature.tabularFigures()],
);
const TextStyle _kCodeKeywordStyle = TextStyle(
  fontSize: 12.5,
  fontFamily: 'monospace',
  color: _kCodeKeyword,
  fontWeight: FontWeight.w600,
);
const TextStyle _kCodeStringStyle = TextStyle(
  fontSize: 12.5,
  fontFamily: 'monospace',
  color: _kCodeString,
);
const TextStyle _kCodeCommentStyle = TextStyle(
  fontSize: 12.5,
  fontFamily: 'monospace',
  color: _kCodeComment,
  fontStyle: FontStyle.italic,
);
const TextStyle _kTableHeaderStyle = TextStyle(
  fontSize: 12.5,
  fontWeight: FontWeight.w700,
  color: _kInk,
  letterSpacing: 0.1,
);
const TextStyle _kTableBodyStyle = TextStyle(
  fontSize: 12.5,
  color: _kInkSecondary,
  height: 1.4,
);
const EdgeInsets _kCardPadding = EdgeInsets.all(18.0);
const EdgeInsets _kCardMargin =
    EdgeInsets.symmetric(horizontal: 18.0, vertical: 6.0);
const EdgeInsets _kSectionPadding = EdgeInsets.symmetric(horizontal: 18.0);

// ---------------------------------------------------------------------------
// PRIVATE HELPERS
// ---------------------------------------------------------------------------
// All helpers are top-level `_camelCase` functions returning `Widget`s. They
// are intentionally not lifted into StatelessWidget subclasses so that the
// file can be read top-to-bottom without jumping around.
// ---------------------------------------------------------------------------
Widget _sectionHeader(int index, String title, String tagline) {
  return Padding(
    padding:
        const EdgeInsets.only(top: 28.0, bottom: 12.0, left: 18.0, right: 18.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 36.0,
          height: 36.0,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: _kPrimary,
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

Widget _card({
  required Widget child,
  Color background = _kCardBg,
  EdgeInsets padding = _kCardPadding,
  EdgeInsets margin = _kCardMargin,
}) {
  return Container(
    margin: margin,
    padding: padding,
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: _kHairline),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x0F000000),
          offset: Offset(0.0, 1.0),
          blurRadius: 3.0,
        ),
      ],
    ),
    child: child,
  );
}

Widget _cardTitle(
  String title, {
  String? subtitle,
  IconData? icon,
  Color iconColour = _kPrimary,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      if (icon != null) ...<Widget>[
        Icon(icon, color: iconColour, size: 20.0),
        const SizedBox(width: 8.0),
      ],
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(title, style: _kCardTitleStyle),
            if (subtitle != null) ...<Widget>[
              const SizedBox(height: 2.0),
              Text(subtitle, style: _kCardSubtitleStyle),
            ],
          ],
        ),
      ),
    ],
  );
}

Widget _pill(String label, {Color colour = _kPrimary}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: 3.0),
    decoration: BoxDecoration(
      color: colour.withOpacity(0.14),
      borderRadius: BorderRadius.circular(999.0),
      border: Border.all(color: colour.withOpacity(0.32)),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 11.0,
        fontWeight: FontWeight.w600,
        color: colour,
        letterSpacing: 0.1,
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
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _kCodeBorder),
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
                  color: Color(0xFFFF5F56),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6.0),
              Container(
                width: 10.0,
                height: 10.0,
                decoration: const BoxDecoration(
                  color: Color(0xFFFFBD2E),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6.0),
              Container(
                width: 10.0,
                height: 10.0,
                decoration: const BoxDecoration(
                  color: Color(0xFF27C93F),
                  shape: BoxShape.circle,
                ),
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

Widget _variantLabel(String label, {Color colour = _kInkSecondary}) {
  return Padding(
    padding: const EdgeInsets.only(top: 8.0),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 11.5,
        color: colour,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.2,
      ),
      textAlign: TextAlign.center,
    ),
  );
}

Widget _variantTile({
  required Widget child,
  required String label,
  Color background = _kCardBg,
  Color labelColour = _kInkSecondary,
  double height = 64.0,
  EdgeInsets innerPadding =
      const EdgeInsets.symmetric(horizontal: 12.0, vertical: 14.0),
}) {
  return Container(
    margin: const EdgeInsets.all(6.0),
    padding: innerPadding,
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _kHairline),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: height,
          child: Center(child: child),
        ),
        _variantLabel(label, colour: labelColour),
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

Widget _bullet(String text, {Color dotColour = _kPrimary}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 7.0, right: 8.0),
          child: Container(
            width: 6.0,
            height: 6.0,
            decoration: BoxDecoration(
              color: dotColour,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Expanded(child: Text(text, style: _kBodyStyle)),
      ],
    ),
  );
}

Widget _calloutRow({
  required IconData icon,
  required Color iconColour,
  required String title,
  required String description,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6.0),
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: iconColour.withOpacity(0.06),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: iconColour.withOpacity(0.22)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(icon, color: iconColour, size: 18.0),
        const SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w700,
                  color: iconColour,
                  letterSpacing: 0.1,
                ),
              ),
              const SizedBox(height: 3.0),
              Text(description, style: _kBodyMuted),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _chipGroup(String label, List<String> chips, Color colour) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
            fontSize: 11.5,
            fontWeight: FontWeight.w700,
            color: colour,
            letterSpacing: 0.6,
          ),
        ),
        const SizedBox(height: 6.0),
        Wrap(
          spacing: 6.0,
          runSpacing: 6.0,
          children: <Widget>[
            for (final String chip in chips) _pill(chip, colour: colour),
          ],
        ),
      ],
    ),
  );
}

Widget _kvRow(String key, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 132.0,
          child: Text(
            key,
            style: const TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: _kInk,
              fontFamily: 'monospace',
            ),
          ),
        ),
        Expanded(child: Text(value, style: _kBodyMuted)),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// API TABLE HELPERS
// ---------------------------------------------------------------------------
// `_apiTable` builds a clean three-column reference for the constructor of
// `SegmentedButton<T>` and the helper types used alongside it. Because the
// table is the single biggest learning aid for the gallery, we keep it
// densely packed but still legible.
Widget _apiTableHeader() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
    decoration: const BoxDecoration(
      color: _kPrimaryContainer,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10.0),
        topRight: Radius.circular(10.0),
      ),
    ),
    child: Row(
      children: const <Widget>[
        SizedBox(
          width: 170.0,
          child: Text('Field', style: _kTableHeaderStyle),
        ),
        SizedBox(
          width: 150.0,
          child: Text('Type', style: _kTableHeaderStyle),
        ),
        Expanded(child: Text('Description', style: _kTableHeaderStyle)),
      ],
    ),
  );
}

Widget _apiTableRow(String field, String type, String description,
    {bool alt = false}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 9.0),
    decoration: BoxDecoration(
      color: alt ? _kCardSoft : _kCardBg,
      border: const Border(
        bottom: BorderSide(color: _kHairline),
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 170.0,
          child: Text(
            field,
            style: const TextStyle(
              fontSize: 12.5,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w600,
              color: _kInk,
            ),
          ),
        ),
        SizedBox(
          width: 150.0,
          child: Text(
            type,
            style: const TextStyle(
              fontSize: 12.0,
              fontFamily: 'monospace',
              color: _kCodeKeyword,
            ),
          ),
        ),
        Expanded(child: Text(description, style: _kTableBodyStyle)),
      ],
    ),
  );
}

Widget _compareHeader(List<String> columns) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
    decoration: const BoxDecoration(
      color: _kSecondaryContainer,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10.0),
        topRight: Radius.circular(10.0),
      ),
    ),
    child: Row(
      children: <Widget>[
        for (int i = 0; i < columns.length; i++)
          Expanded(
            flex: i == 0 ? 2 : 3,
            child: Text(columns[i], style: _kTableHeaderStyle),
          ),
      ],
    ),
  );
}

Widget _compareRow(List<String> cells, {bool alt = false}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 9.0),
    decoration: BoxDecoration(
      color: alt ? _kCardSoft : _kCardBg,
      border: const Border(
        bottom: BorderSide(color: _kHairline),
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        for (int i = 0; i < cells.length; i++)
          Expanded(
            flex: i == 0 ? 2 : 3,
            child: Padding(
              padding: const EdgeInsets.only(right: 6.0),
              child: Text(
                cells[i],
                style: i == 0
                    ? const TextStyle(
                        fontSize: 12.5,
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.w600,
                        color: _kInk,
                      )
                    : _kTableBodyStyle,
              ),
            ),
          ),
      ],
    ),
  );
}

// ===========================================================================
// MAIN BUILD ENTRY POINT
// ---------------------------------------------------------------------------
// The interpreter calls this function exactly once. All "state" must live in
// local variables and be passed by closure to the widgets below. `selected`
// arguments are always const-set literals so there is no live mutation.
// ===========================================================================
dynamic build(BuildContext context) {
  print('SegmentedButton deep visual demo executing');
  final math.Random rng = math.Random(11);
  final int dummyEntropy = rng.nextInt(100);
  print('  rng warm-up: $dummyEntropy');

  // -------------------------------------------------------------------------
  // SECTION 1 - HERO INTRO
  // -------------------------------------------------------------------------
  // The hero card explains what SegmentedButton is, why it exists in Material
  // 3, and how it differs from the older ToggleButtons widget. Visually it
  // is a tall gradient card with two demo segmented buttons embedded on the
  // right-hand side.
  // -------------------------------------------------------------------------
  final Widget heroDemoSingle = SegmentedButton<String>(
    segments: const <ButtonSegment<String>>[
      ButtonSegment<String>(
        value: 'day',
        label: Text('Day'),
        icon: Icon(Icons.wb_sunny_outlined),
      ),
      ButtonSegment<String>(
        value: 'week',
        label: Text('Week'),
        icon: Icon(Icons.view_week_outlined),
      ),
      ButtonSegment<String>(
        value: 'month',
        label: Text('Month'),
        icon: Icon(Icons.calendar_month_outlined),
      ),
    ],
    selected: const <String>{'week'},
    onSelectionChanged: (_) {},
  );

  final Widget heroDemoMulti = SegmentedButton<String>(
    segments: const <ButtonSegment<String>>[
      ButtonSegment<String>(value: 'bold', label: Text('B')),
      ButtonSegment<String>(value: 'italic', label: Text('I')),
      ButtonSegment<String>(value: 'under', label: Text('U')),
      ButtonSegment<String>(value: 'strike', label: Text('S')),
    ],
    selected: const <String>{'bold', 'italic'},
    multiSelectionEnabled: true,
    showSelectedIcon: false,
    onSelectionChanged: (_) {},
  );

  final Widget heroIntro = Container(
    margin: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 8.0),
    padding: const EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          Color(0xFF6750A4),
          Color(0xFF7D5260),
        ],
      ),
      borderRadius: BorderRadius.circular(22.0),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x336750A4),
          offset: Offset(0.0, 6.0),
          blurRadius: 16.0,
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: const <Widget>[
            Icon(Icons.view_module_outlined,
                color: Color(0xFFFFFFFF), size: 32.0),
            SizedBox(width: 12.0),
            Text('SegmentedButton', style: _kHeroTitle),
          ],
        ),
        const SizedBox(height: 6.0),
        const Text(
          'Material 3 segmented selection - single or multi',
          style: _kHeroSubtitle,
        ),
        const SizedBox(height: 16.0),
        const Text(
          'SegmentedButton<T> is the Material 3 replacement for the legacy '
          'ToggleButtons widget. It groups two to five mutually-related '
          'options into a single horizontal (or vertical) bar. Each tap '
          'updates a generic Set<T>, which the caller is responsible for '
          'persisting via onSelectionChanged. Because the widget is '
          'stateless, it slots neatly into any state management approach: '
          'ChangeNotifier, BLoC, Riverpod, or plain setState.',
          style: _kHeroBody,
        ),
        const SizedBox(height: 18.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: <Widget>[
            _pill('Material 3', colour: const Color(0xFFFFFFFF)),
            _pill('Generic T', colour: const Color(0xFFFFFFFF)),
            _pill('Single', colour: const Color(0xFFFFFFFF)),
            _pill('Multi', colour: const Color(0xFFFFFFFF)),
            _pill('Themed', colour: const Color(0xFFFFFFFF)),
            _pill('Stateless', colour: const Color(0xFFFFFFFF)),
          ],
        ),
        const SizedBox(height: 18.0),
        Container(
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: const Color(0x33FFFFFF),
            borderRadius: BorderRadius.circular(14.0),
            border: Border.all(color: const Color(0x55FFFFFF)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Single selection',
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontWeight: FontWeight.w600,
                  fontSize: 12.0,
                  letterSpacing: 0.4,
                ),
              ),
              const SizedBox(height: 8.0),
              Align(alignment: Alignment.centerLeft, child: heroDemoSingle),
              const SizedBox(height: 14.0),
              const Text(
                'Multi selection (B + I)',
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontWeight: FontWeight.w600,
                  fontSize: 12.0,
                  letterSpacing: 0.4,
                ),
              ),
              const SizedBox(height: 8.0),
              Align(alignment: Alignment.centerLeft, child: heroDemoMulti),
            ],
          ),
        ),
        const SizedBox(height: 14.0),
        Row(
          children: const <Widget>[
            Icon(Icons.lightbulb_outline,
                color: Color(0xFFFFFFFF), size: 18.0),
            SizedBox(width: 6.0),
            Expanded(
              child: Text(
                'Rule of thumb: 2-5 short options that are mutually related. '
                'Six or more options? Reach for Chips or a DropdownButton.',
                style: TextStyle(
                  fontSize: 12.5,
                  color: Color(0xE6FFFFFF),
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 2 - API REFERENCE TABLE
  // -------------------------------------------------------------------------
  // The reference table walks through every named argument of the
  // SegmentedButton<T> constructor and every field of ButtonSegment<T>.
  // Each row uses monospaced font for the identifier and a tagged colour
  // for the type. This is the densest section of the gallery and is meant
  // to be skimmed by experienced developers.
  // -------------------------------------------------------------------------
  final Widget apiTableCard = _card(
    padding: EdgeInsets.zero,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 12.0),
          child: _cardTitle(
            'SegmentedButton<T> API at a glance',
            subtitle:
                'Every named argument, with type and a one-line description.',
            icon: Icons.api_outlined,
          ),
        ),
        _apiTableHeader(),
        _apiTableRow(
          'segments',
          'List<ButtonSegment<T>>',
          'Required. 2 to 5 segments; each must have a unique `value`.',
        ),
        _apiTableRow(
          'selected',
          'Set<T>',
          'Required. The currently selected values. Must reference values that '
              'exist in `segments`.',
          alt: true,
        ),
        _apiTableRow(
          'onSelectionChanged',
          'ValueChanged<Set<T>>?',
          'Called when the user taps a segment. `null` disables the entire '
              'button.',
        ),
        _apiTableRow(
          'multiSelectionEnabled',
          'bool',
          'Defaults to false. When true, taps toggle membership instead of '
              'replacing the set.',
          alt: true,
        ),
        _apiTableRow(
          'emptySelectionAllowed',
          'bool',
          'Defaults to false. Must be `true` to allow the user to deselect '
              'their last selection.',
        ),
        _apiTableRow(
          'style',
          'ButtonStyle?',
          'Optional override that flows down to each segment via '
              'WidgetStateProperty<...>.',
          alt: true,
        ),
        _apiTableRow(
          'showSelectedIcon',
          'bool',
          'Defaults to true. Renders a check icon in the selected segments '
              'unless `selectedIcon` overrides it.',
        ),
        _apiTableRow(
          'selectedIcon',
          'Widget?',
          'Replaces the default check mark on selected segments. Useful for '
              'app-specific glyphs.',
          alt: true,
        ),
        _apiTableRow(
          'direction',
          'Axis',
          'Defaults to Axis.horizontal. Switch to Axis.vertical for a column '
              'layout.',
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 6.0),
          child: Text(
            'ButtonSegment<T>',
            style: _kCardTitleStyle.copyWith(color: _kSecondary),
          ),
        ),
        _apiTableHeader(),
        _apiTableRow(
          'value',
          'T',
          'Required. The identity carried by this segment; appears in '
              '`selected` and `onSelectionChanged`.',
        ),
        _apiTableRow(
          'label',
          'Widget?',
          'Optional text label. Usually a `Text` widget.',
          alt: true,
        ),
        _apiTableRow(
          'icon',
          'Widget?',
          'Optional leading icon (or replacement when `label` is null).',
        ),
        _apiTableRow(
          'tooltip',
          'String?',
          'Optional hover/long-press tooltip; especially useful for icon-only '
              'segments.',
          alt: true,
        ),
        _apiTableRow(
          'enabled',
          'bool',
          'Defaults to true. Set to false to grey out an individual segment.',
        ),
        const SizedBox(height: 14.0),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 3 - SINGLE-SELECTION GALLERY
  // -------------------------------------------------------------------------
  // Five variants are shown:
  //   * 2-segment toggle (Left / Right)
  //   * 3-segment toggle (Day / Week / Month)
  //   * 4-segment with icons (List / Grid / Table / Card)
  //   * 3-segment icon-only (text-alignment)
  //   * 5-segment with long labels (Project lifecycle)
  // -------------------------------------------------------------------------
  final Widget singleTwo = SegmentedButton<int>(
    segments: const <ButtonSegment<int>>[
      ButtonSegment<int>(value: 0, label: Text('Left')),
      ButtonSegment<int>(value: 1, label: Text('Right')),
    ],
    selected: const <int>{0},
    onSelectionChanged: (_) {},
  );

  final Widget singleThree = SegmentedButton<String>(
    segments: const <ButtonSegment<String>>[
      ButtonSegment<String>(value: 'day', label: Text('Day')),
      ButtonSegment<String>(value: 'week', label: Text('Week')),
      ButtonSegment<String>(value: 'month', label: Text('Month')),
    ],
    selected: const <String>{'week'},
    onSelectionChanged: (_) {},
  );

  final Widget singleFourIcons = SegmentedButton<String>(
    segments: const <ButtonSegment<String>>[
      ButtonSegment<String>(
        value: 'list',
        label: Text('List'),
        icon: Icon(Icons.list),
      ),
      ButtonSegment<String>(
        value: 'grid',
        label: Text('Grid'),
        icon: Icon(Icons.grid_view),
      ),
      ButtonSegment<String>(
        value: 'table',
        label: Text('Table'),
        icon: Icon(Icons.table_chart_outlined),
      ),
      ButtonSegment<String>(
        value: 'card',
        label: Text('Card'),
        icon: Icon(Icons.view_agenda_outlined),
      ),
    ],
    selected: const <String>{'grid'},
    onSelectionChanged: (_) {},
  );

  final Widget singleIconsOnly = SegmentedButton<String>(
    segments: const <ButtonSegment<String>>[
      ButtonSegment<String>(
        value: 'align_left',
        icon: Icon(Icons.format_align_left),
        tooltip: 'Align left',
      ),
      ButtonSegment<String>(
        value: 'align_center',
        icon: Icon(Icons.format_align_center),
        tooltip: 'Align centre',
      ),
      ButtonSegment<String>(
        value: 'align_right',
        icon: Icon(Icons.format_align_right),
        tooltip: 'Align right',
      ),
    ],
    selected: const <String>{'align_center'},
    showSelectedIcon: false,
    onSelectionChanged: (_) {},
  );

  final Widget singleFiveLong = SegmentedButton<String>(
    segments: const <ButtonSegment<String>>[
      ButtonSegment<String>(value: 'plan', label: Text('Plan')),
      ButtonSegment<String>(value: 'design', label: Text('Design')),
      ButtonSegment<String>(value: 'build', label: Text('Build')),
      ButtonSegment<String>(value: 'review', label: Text('Review')),
      ButtonSegment<String>(value: 'release', label: Text('Release')),
    ],
    selected: const <String>{'build'},
    showSelectedIcon: false,
    onSelectionChanged: (_) {},
  );

  final Widget singleGallery = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'Single-selection gallery',
          subtitle: 'Five variants - two through five segments, with and '
              'without icons.',
          icon: Icons.radio_button_checked,
        ),
        const SizedBox(height: 12.0),
        Wrap(
          alignment: WrapAlignment.start,
          children: <Widget>[
            _variantTile(child: singleTwo, label: '2 segments'),
            _variantTile(child: singleThree, label: '3 segments'),
            _variantTile(
              child: singleFourIcons,
              label: '4 + icons',
              height: 72.0,
            ),
            _variantTile(
              child: singleIconsOnly,
              label: 'icon only',
            ),
            _variantTile(
              child: singleFiveLong,
              label: '5 long labels',
              innerPadding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 18.0),
            ),
          ],
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 4 - MULTI-SELECTION GALLERY
  // -------------------------------------------------------------------------
  // Four variants:
  //   * Two of three selected (B + I in a text formatting bar)
  //   * All-selected (Mon - Fri in a recurring-day picker)
  //   * None-selected (emptySelectionAllowed: true)
  //   * Mixed icon + label segments
  // -------------------------------------------------------------------------
  final Widget multiTwoOfThree = SegmentedButton<String>(
    segments: const <ButtonSegment<String>>[
      ButtonSegment<String>(value: 'bold', label: Text('B')),
      ButtonSegment<String>(value: 'italic', label: Text('I')),
      ButtonSegment<String>(value: 'under', label: Text('U')),
    ],
    selected: const <String>{'bold', 'italic'},
    multiSelectionEnabled: true,
    showSelectedIcon: false,
    onSelectionChanged: (_) {},
  );

  final Widget multiAll = SegmentedButton<String>(
    segments: const <ButtonSegment<String>>[
      ButtonSegment<String>(value: 'mon', label: Text('Mon')),
      ButtonSegment<String>(value: 'tue', label: Text('Tue')),
      ButtonSegment<String>(value: 'wed', label: Text('Wed')),
      ButtonSegment<String>(value: 'thu', label: Text('Thu')),
      ButtonSegment<String>(value: 'fri', label: Text('Fri')),
    ],
    selected: const <String>{'mon', 'tue', 'wed', 'thu', 'fri'},
    multiSelectionEnabled: true,
    showSelectedIcon: false,
    onSelectionChanged: (_) {},
  );

  final Widget multiEmpty = SegmentedButton<String>(
    segments: const <ButtonSegment<String>>[
      ButtonSegment<String>(value: 'x', label: Text('X')),
      ButtonSegment<String>(value: 'y', label: Text('Y')),
      ButtonSegment<String>(value: 'z', label: Text('Z')),
    ],
    selected: const <String>{},
    multiSelectionEnabled: true,
    emptySelectionAllowed: true,
    onSelectionChanged: (_) {},
  );

  final Widget multiMixed = SegmentedButton<String>(
    segments: const <ButtonSegment<String>>[
      ButtonSegment<String>(
        value: 'wifi',
        label: Text('Wifi'),
        icon: Icon(Icons.wifi),
      ),
      ButtonSegment<String>(
        value: 'bluetooth',
        label: Text('BT'),
        icon: Icon(Icons.bluetooth),
      ),
      ButtonSegment<String>(
        value: 'airplane',
        label: Text('Plane'),
        icon: Icon(Icons.airplanemode_active),
      ),
    ],
    selected: const <String>{'wifi', 'bluetooth'},
    multiSelectionEnabled: true,
    onSelectionChanged: (_) {},
  );

  final Widget multiGallery = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'Multi-selection gallery',
          subtitle: 'multiSelectionEnabled flips each tap from "replace" to '
              '"toggle". emptySelectionAllowed lets the user clear out.',
          icon: Icons.check_box_outlined,
        ),
        const SizedBox(height: 12.0),
        Wrap(
          alignment: WrapAlignment.start,
          children: <Widget>[
            _variantTile(child: multiTwoOfThree, label: '2 of 3'),
            _variantTile(
              child: multiAll,
              label: 'all selected',
              innerPadding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 18.0),
            ),
            _variantTile(child: multiEmpty, label: 'none selected'),
            _variantTile(
              child: multiMixed,
              label: 'icon + label',
              height: 72.0,
            ),
          ],
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 5 - SegmentedButtonThemeData SHOWCASE
  // -------------------------------------------------------------------------
  // The theme card demonstrates two ways to influence the look of a
  // SegmentedButton:
  //   1. Wrapping the widget in a `SegmentedButtonTheme(...)` directly.
  //   2. Setting `segmentedButtonTheme` on a parent `Theme(...)`.
  // The card also includes a screenshot-style snapshot of what the themed
  // button looks like so readers can compare it to the default rendering.
  // -------------------------------------------------------------------------
  final ButtonStyle _themedStyle = ButtonStyle(
    foregroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
      if (states.contains(WidgetState.selected)) {
        return _kPrimary;
      }
      return _kInkSecondary;
    }),
    backgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
      if (states.contains(WidgetState.selected)) {
        return _kPrimaryContainer;
      }
      return _kCardSoft;
    }),
    side: WidgetStateProperty.resolveWith<BorderSide?>((states) {
      if (states.contains(WidgetState.selected)) {
        return const BorderSide(color: _kPrimary, width: 1.4);
      }
      return const BorderSide(color: _kHairlineStrong);
    }),
    textStyle: WidgetStateProperty.all<TextStyle>(
      const TextStyle(fontSize: 13.0, fontWeight: FontWeight.w600),
    ),
  );

  final Widget themedRefSegmented = SegmentedButton<String>(
    segments: const <ButtonSegment<String>>[
      ButtonSegment<String>(
        value: 'low',
        label: Text('Low'),
        icon: Icon(Icons.arrow_downward),
      ),
      ButtonSegment<String>(
        value: 'mid',
        label: Text('Mid'),
        icon: Icon(Icons.horizontal_rule),
      ),
      ButtonSegment<String>(
        value: 'high',
        label: Text('High'),
        icon: Icon(Icons.arrow_upward),
      ),
    ],
    selected: const <String>{'mid'},
    onSelectionChanged: (_) {},
  );

  final Widget themedWithLocalTheme = SegmentedButtonTheme(
    data: SegmentedButtonThemeData(style: _themedStyle),
    child: SegmentedButton<String>(
      segments: const <ButtonSegment<String>>[
        ButtonSegment<String>(
          value: 'low',
          label: Text('Low'),
          icon: Icon(Icons.arrow_downward),
        ),
        ButtonSegment<String>(
          value: 'mid',
          label: Text('Mid'),
          icon: Icon(Icons.horizontal_rule),
        ),
        ButtonSegment<String>(
          value: 'high',
          label: Text('High'),
          icon: Icon(Icons.arrow_upward),
        ),
      ],
      selected: const <String>{'mid'},
      onSelectionChanged: (_) {},
    ),
  );

  final Widget themeShowcase = _card(
    background: _kCardSoft,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'SegmentedButtonThemeData showcase',
          subtitle:
              'Use the inherited theme to style every SegmentedButton in a '
              'subtree, or wrap a single one in SegmentedButtonTheme.',
          icon: Icons.palette_outlined,
        ),
        const SizedBox(height: 14.0),
        Text(
          'Default look (no theme)',
          style: _kCaptionStyle.copyWith(color: _kInkSecondary),
        ),
        const SizedBox(height: 8.0),
        Align(alignment: Alignment.centerLeft, child: themedRefSegmented),
        const SizedBox(height: 16.0),
        Text(
          'Wrapped in SegmentedButtonTheme(data: SegmentedButtonThemeData(style: ...))',
          style: _kCaptionStyle.copyWith(color: _kInkSecondary),
        ),
        const SizedBox(height: 8.0),
        Align(alignment: Alignment.centerLeft, child: themedWithLocalTheme),
        const SizedBox(height: 16.0),
        _kvRow('foregroundColor', 'Primary when selected, secondary when not.'),
        _kvRow('backgroundColor', 'PrimaryContainer on selection.'),
        _kvRow('side', 'Primary 1.4dp border when selected.'),
        _kvRow('textStyle', '13sp, weight 600 (applied unconditionally).'),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: _kPrimaryContainer.withOpacity(0.4),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: _kPrimary.withOpacity(0.4)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              Icon(Icons.info_outline, color: _kPrimary, size: 18.0),
              SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  'Theme cascade: a SegmentedButton picks up its style from '
                  '(in order) `style:`, the nearest SegmentedButtonTheme, '
                  'the ThemeData.segmentedButtonTheme, and finally the '
                  'Material 3 defaults.',
                  style: _kBodyMuted,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 6 - DISABLED SEGMENT SHOWCASE
  // -------------------------------------------------------------------------
  // Two demos:
  //   * A single segment with `enabled: false` in the middle.
  //   * A button where 2 of 4 segments are disabled, mixed with enabled
  //     selectable ones.
  // The card also shows what happens when the whole button is disabled by
  // setting `onSelectionChanged: null`.
  // -------------------------------------------------------------------------
  final Widget disabledMiddle = SegmentedButton<String>(
    segments: const <ButtonSegment<String>>[
      ButtonSegment<String>(value: 'a', label: Text('Auto')),
      ButtonSegment<String>(
        value: 'b',
        label: Text('Manual'),
        enabled: false,
      ),
      ButtonSegment<String>(value: 'c', label: Text('Off')),
    ],
    selected: const <String>{'a'},
    onSelectionChanged: (_) {},
  );

  final Widget disabledMixed = SegmentedButton<String>(
    segments: const <ButtonSegment<String>>[
      ButtonSegment<String>(value: 'tiny', label: Text('XS')),
      ButtonSegment<String>(value: 'small', label: Text('S')),
      ButtonSegment<String>(
        value: 'medium',
        label: Text('M'),
        enabled: false,
      ),
      ButtonSegment<String>(
        value: 'large',
        label: Text('L'),
        enabled: false,
      ),
    ],
    selected: const <String>{'small'},
    onSelectionChanged: (_) {},
  );

  final Widget disabledWhole = SegmentedButton<String>(
    segments: const <ButtonSegment<String>>[
      ButtonSegment<String>(value: 'one', label: Text('One')),
      ButtonSegment<String>(value: 'two', label: Text('Two')),
      ButtonSegment<String>(value: 'three', label: Text('Three')),
    ],
    selected: const <String>{'two'},
    onSelectionChanged: null,
  );

  final Widget disabledShowcase = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'Disabled segments & disabled buttons',
          subtitle: 'ButtonSegment.enabled false greys a single segment. '
              'onSelectionChanged: null disables the whole bar.',
          icon: Icons.block_outlined,
        ),
        const SizedBox(height: 14.0),
        Text('Single disabled segment (middle)',
            style: _kCaptionStyle.copyWith(color: _kInkSecondary)),
        const SizedBox(height: 8.0),
        Align(alignment: Alignment.centerLeft, child: disabledMiddle),
        const SizedBox(height: 16.0),
        Text('Mixed - two of four disabled',
            style: _kCaptionStyle.copyWith(color: _kInkSecondary)),
        const SizedBox(height: 8.0),
        Align(alignment: Alignment.centerLeft, child: disabledMixed),
        const SizedBox(height: 16.0),
        Text('Whole button disabled (onSelectionChanged: null)',
            style: _kCaptionStyle.copyWith(color: _kInkSecondary)),
        const SizedBox(height: 8.0),
        Align(alignment: Alignment.centerLeft, child: disabledWhole),
        const SizedBox(height: 14.0),
        _bullet(
          'Disabled segments still occupy the same width and round their '
          'shared border like enabled ones.',
        ),
        _bullet(
          'Disabling the whole bar via `onSelectionChanged: null` is the '
          'recommended way to communicate "the entire option set is not '
          'applicable here".',
          dotColour: _kWarning,
        ),
        _bullet(
          'You can not pre-select a disabled value programmatically without '
          'getting a runtime assertion in debug mode - keep your `selected` '
          'consistent with `enabled` flags.',
          dotColour: _kError,
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 7 - Axis.vertical DIRECTION DEMO
  // -------------------------------------------------------------------------
  // Two vertical SegmentedButtons<int> side by side. The first is a plain
  // vertical bar; the second has icons so readers can see how `direction:
  // Axis.vertical` reflows label + icon layouts.
  // -------------------------------------------------------------------------
  final Widget verticalPlain = SegmentedButton<int>(
    segments: const <ButtonSegment<int>>[
      ButtonSegment<int>(value: 1, label: Text('North')),
      ButtonSegment<int>(value: 2, label: Text('East')),
      ButtonSegment<int>(value: 3, label: Text('South')),
    ],
    selected: const <int>{2},
    direction: Axis.vertical,
    onSelectionChanged: (_) {},
  );

  final Widget verticalIcons = SegmentedButton<int>(
    segments: const <ButtonSegment<int>>[
      ButtonSegment<int>(
        value: 1,
        label: Text('Inbox'),
        icon: Icon(Icons.inbox_outlined),
      ),
      ButtonSegment<int>(
        value: 2,
        label: Text('Sent'),
        icon: Icon(Icons.send_outlined),
      ),
      ButtonSegment<int>(
        value: 3,
        label: Text('Drafts'),
        icon: Icon(Icons.drafts_outlined),
      ),
    ],
    selected: const <int>{1},
    direction: Axis.vertical,
    onSelectionChanged: (_) {},
  );

  final Widget verticalShowcase = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'direction: Axis.vertical',
          subtitle: 'Reflows the segments into a column. Handy in narrow '
              'sidebars or as a sub-nav.',
          icon: Icons.swap_vert,
        ),
        const SizedBox(height: 16.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Plain labels',
                    style: _kCaptionStyle.copyWith(color: _kInkSecondary),
                  ),
                  const SizedBox(height: 8.0),
                  verticalPlain,
                ],
              ),
            ),
            const SizedBox(width: 14.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Icon + label',
                    style: _kCaptionStyle.copyWith(color: _kInkSecondary),
                  ),
                  const SizedBox(height: 8.0),
                  verticalIcons,
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        _bullet(
          'Vertical direction does not change how `selected` is interpreted; '
          'it is purely a layout flag.',
        ),
        _bullet(
          'Inside a constrained-width Container, vertical SegmentedButton '
          'sizes itself to the widest label rather than wrapping.',
          dotColour: _kSecondary,
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 8 - CODE-BLOCK CARDS
  // -------------------------------------------------------------------------
  // Six idiomatic snippets that mirror the section content above. Each block
  // is wrapped in `_codeBlock(...)` to render a small "terminal window" with
  // traffic-light dots and a filename in the title bar.
  // -------------------------------------------------------------------------
  final Widget codeBasic = _codeBlock(
    'SegmentedButton<String>(\n'
    '  segments: const <ButtonSegment<String>>[\n'
    '    ButtonSegment<String>(value: \'day\',   label: Text(\'Day\')),\n'
    '    ButtonSegment<String>(value: \'week\',  label: Text(\'Week\')),\n'
    '    ButtonSegment<String>(value: \'month\', label: Text(\'Month\')),\n'
    '  ],\n'
    '  selected: <String>{\'week\'},\n'
    '  onSelectionChanged: (Set<String> next) {\n'
    '    setState(() => _range = next.first);\n'
    '  },\n'
    ')',
    title: 'snippet_01_basic.dart',
  );

  final Widget codeMulti = _codeBlock(
    '// emptySelectionAllowed lets the user clear everything.\n'
    'SegmentedButton<String>(\n'
    '  segments: const <ButtonSegment<String>>[\n'
    '    ButtonSegment<String>(value: \'b\', label: Text(\'B\')),\n'
    '    ButtonSegment<String>(value: \'i\', label: Text(\'I\')),\n'
    '    ButtonSegment<String>(value: \'u\', label: Text(\'U\')),\n'
    '  ],\n'
    '  selected: _format,\n'
    '  multiSelectionEnabled: true,\n'
    '  emptySelectionAllowed: true,\n'
    '  showSelectedIcon: false,\n'
    '  onSelectionChanged: (Set<String> next) =>\n'
    '      setState(() => _format = next),\n'
    ')',
    title: 'snippet_02_multi.dart',
  );

  final Widget codeIconOnly = _codeBlock(
    'SegmentedButton<String>(\n'
    '  segments: const <ButtonSegment<String>>[\n'
    '    ButtonSegment<String>(\n'
    '      value: \'left\',\n'
    '      icon: Icon(Icons.format_align_left),\n'
    '      tooltip: \'Align left\',\n'
    '    ),\n'
    '    ButtonSegment<String>(\n'
    '      value: \'center\',\n'
    '      icon: Icon(Icons.format_align_center),\n'
    '      tooltip: \'Align centre\',\n'
    '    ),\n'
    '    ButtonSegment<String>(\n'
    '      value: \'right\',\n'
    '      icon: Icon(Icons.format_align_right),\n'
    '      tooltip: \'Align right\',\n'
    '    ),\n'
    '  ],\n'
    '  selected: <String>{\'center\'},\n'
    '  showSelectedIcon: false,\n'
    '  onSelectionChanged: (_) {},\n'
    ')',
    title: 'snippet_03_icon_only.dart',
  );

  final Widget codeThemed = _codeBlock(
    'SegmentedButtonTheme(\n'
    '  data: SegmentedButtonThemeData(\n'
    '    style: ButtonStyle(\n'
    '      foregroundColor: WidgetStateProperty.resolveWith((s) =>\n'
    '          s.contains(WidgetState.selected)\n'
    '              ? colorScheme.primary\n'
    '              : colorScheme.onSurface),\n'
    '      backgroundColor: WidgetStateProperty.resolveWith((s) =>\n'
    '          s.contains(WidgetState.selected)\n'
    '              ? colorScheme.primaryContainer\n'
    '              : null),\n'
    '    ),\n'
    '  ),\n'
    '  child: SegmentedButton<String>( /* ... */ ),\n'
    ')',
    title: 'snippet_04_theme.dart',
  );

  final Widget codeDisabled = _codeBlock(
    'SegmentedButton<String>(\n'
    '  segments: const <ButtonSegment<String>>[\n'
    '    ButtonSegment<String>(value: \'auto\',   label: Text(\'Auto\')),\n'
    '    ButtonSegment<String>(\n'
    '      value: \'manual\',\n'
    '      label: Text(\'Manual\'),\n'
    '      enabled: false, // greyed out\n'
    '    ),\n'
    '    ButtonSegment<String>(value: \'off\',    label: Text(\'Off\')),\n'
    '  ],\n'
    '  selected: <String>{\'auto\'},\n'
    '  // onSelectionChanged: null disables the whole bar.\n'
    '  onSelectionChanged: (_) {},\n'
    ')',
    title: 'snippet_05_disabled.dart',
  );

  final Widget codeVertical = _codeBlock(
    'SegmentedButton<int>(\n'
    '  direction: Axis.vertical,\n'
    '  segments: const <ButtonSegment<int>>[\n'
    '    ButtonSegment<int>(\n'
    '      value: 1, label: Text(\'Inbox\'),  icon: Icon(Icons.inbox)),\n'
    '    ButtonSegment<int>(\n'
    '      value: 2, label: Text(\'Sent\'),   icon: Icon(Icons.send)),\n'
    '    ButtonSegment<int>(\n'
    '      value: 3, label: Text(\'Drafts\'), icon: Icon(Icons.drafts)),\n'
    '  ],\n'
    '  selected: <int>{1},\n'
    '  onSelectionChanged: (_) {},\n'
    ')',
    title: 'snippet_06_vertical.dart',
  );

  final Widget codeBlocksSection = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      codeBasic,
      codeMulti,
      codeIconOnly,
      codeThemed,
      codeDisabled,
      codeVertical,
    ],
  );

  // -------------------------------------------------------------------------
  // SECTION 9 - COMPARISON TABLE
  // -------------------------------------------------------------------------
  // Five widgets are compared along three axes - their material/cupertino
  // home, the kind of selection they handle, and a quick "when to use it"
  // recommendation. The table follows the same visual rhythm as the API
  // table from section 2.
  // -------------------------------------------------------------------------
  final Widget comparisonTableCard = _card(
    padding: EdgeInsets.zero,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 12.0),
          child: _cardTitle(
            'Cousins of SegmentedButton',
            subtitle: 'Choosing between five widgets that all "look kind of '
                'like a segmented bar".',
            icon: Icons.compare_arrows_outlined,
          ),
        ),
        _compareHeader(const <String>['Widget', 'Library', 'When to use']),
        _compareRow(const <String>[
          'SegmentedButton',
          'flutter/material (M3)',
          'Default choice in Material 3 apps. Single or multi, 2-5 options, '
              'optional icons, themeable.',
        ]),
        _compareRow(
          const <String>[
            'ToggleButtons',
            'flutter/material (M2)',
            'Legacy. Manual rendering of selected indices; lacks built-in '
                'multi/single mode toggle. Prefer SegmentedButton in new code.',
          ],
          alt: true,
        ),
        _compareRow(const <String>[
          'CupertinoSegmentedControl',
          'flutter/cupertino',
          'iOS pre-13 look (pill background). Best for iOS apps that want '
              'the classic UISegmentedControl appearance.',
        ]),
        _compareRow(
          const <String>[
            'CupertinoSlidingSegmentedControl',
            'flutter/cupertino',
            'iOS 13+ look (sliding thumb). The default segmented control '
                'on modern iOS surfaces.',
          ],
          alt: true,
        ),
        _compareRow(const <String>[
          'ChoiceChip / FilterChip',
          'flutter/material',
          'Use when options are not strictly mutually-exclusive *and* there '
              'are many of them, or when each option deserves its own '
              'shape/colour.',
        ]),
        const SizedBox(height: 14.0),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 10 - PITFALLS
  // -------------------------------------------------------------------------
  // Six callouts that bite developers in the wild. Each call-out has an
  // icon, a coloured background, a strong title, and a one-paragraph
  // explanation. They are styled with `_calloutRow(...)` so they share the
  // same visual rhythm.
  // -------------------------------------------------------------------------
  final Widget pitfallsCard = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'Pitfalls and common mistakes',
          subtitle: 'Six rough edges to watch out for when adopting '
              'SegmentedButton.',
          icon: Icons.warning_amber_outlined,
        ),
        const SizedBox(height: 8.0),
        _calloutRow(
          icon: Icons.power_off_outlined,
          iconColour: _kError,
          title: 'Missing onSelectionChanged disables the button',
          description:
              'Passing `onSelectionChanged: null` greys out the entire bar. '
              'If you want a read-only button that *looks* enabled, wrap it '
              'in an IgnorePointer instead.',
        ),
        _calloutRow(
          icon: Icons.code,
          iconColour: _kWarning,
          title: 'Generic type T must be inferable',
          description:
              'Always spell the type once explicitly, e.g. '
              '`SegmentedButton<String>(...)`. Mixing implicit and explicit '
              'segment values can land you with `SegmentedButton<Object>` '
              'and silent equality bugs.',
        ),
        _calloutRow(
          icon: Icons.compare,
          iconColour: _kTertiary,
          title: 'Value equality matters',
          description:
              'Segments are compared by `==`. If you use custom classes as '
              'segment values, override `operator ==` and `hashCode`, or you '
              'will see the wrong segment highlighted.',
        ),
        _calloutRow(
          icon: Icons.clear_all,
          iconColour: _kInfo,
          title: 'emptySelectionAllowed defaults to false',
          description:
              'When the user taps the only selected segment in single mode, '
              'nothing happens unless `emptySelectionAllowed: true`. Same '
              'thing in multi mode: the last selection cannot be removed by '
              'default.',
        ),
        _calloutRow(
          icon: Icons.image_not_supported_outlined,
          iconColour: _kSecondary,
          title: 'showSelectedIcon in icon-only segments',
          description:
              'If your segments are icon-only, leaving `showSelectedIcon: '
              'true` (the default) draws a tiny check beside your glyph. '
              'Set `showSelectedIcon: false` for icon bars.',
        ),
        _calloutRow(
          icon: Icons.style_outlined,
          iconColour: _kSuccess,
          title: 'Theme cascade',
          description:
              'A SegmentedButton looks up its style from `style:`, then the '
              'enclosing `SegmentedButtonTheme`, then '
              '`ThemeData.segmentedButtonTheme`, then Material 3 defaults. '
              'Setting `style:` on the widget short-circuits the rest.',
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 11 - FOOTER CHEAT-SHEET
  // -------------------------------------------------------------------------
  // Four chip groups summarise the API surface plus a final tagline. This is
  // the only section that intentionally repeats names from earlier sections,
  // because it is meant to be read in isolation as a quick reminder.
  // -------------------------------------------------------------------------
  final Widget cheatSheet = _card(
    background: _kCardSoft,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'Cheat sheet',
          subtitle: 'Everything you need to remember, on one screen.',
          icon: Icons.bookmark_outline,
        ),
        const SizedBox(height: 8.0),
        _chipGroup(
          'WIDGETS',
          const <String>[
            'SegmentedButton<T>',
            'ButtonSegment<T>',
            'SegmentedButtonTheme',
            'SegmentedButtonThemeData',
          ],
          _kPrimary,
        ),
        _chipGroup(
          'SEGMENT FIELDS',
          const <String>[
            'value',
            'label',
            'icon',
            'tooltip',
            'enabled',
          ],
          _kSecondary,
        ),
        _chipGroup(
          'THEME / STYLE',
          const <String>[
            'foregroundColor',
            'backgroundColor',
            'side',
            'textStyle',
            'padding',
            'shape',
          ],
          _kTertiary,
        ),
        _chipGroup(
          'RELATED',
          const <String>[
            'ToggleButtons',
            'CupertinoSegmentedControl',
            'CupertinoSlidingSegmentedControl',
            'ChoiceChip',
            'FilterChip',
            'DropdownButton',
          ],
          _kInfo,
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: <Color>[Color(0xFF6750A4), Color(0xFF7D5260)],
            ),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Row(
            children: const <Widget>[
              Icon(Icons.auto_awesome,
                  color: Color(0xFFFFFFFF), size: 18.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'SegmentedButton<T>: small, focused, themeable. The Material '
                  '3 answer to "two-to-five tiny related things".',
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 13.0,
                    fontWeight: FontWeight.w600,
                    height: 1.4,
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
  // ASSEMBLE THE SECTION LIST
  // -------------------------------------------------------------------------
  // The list mirrors the eleven hard-required sections from the spec, with
  // dividers between logical groupings. The order matches the section
  // numbering in the docstring at the top of this file.
  // -------------------------------------------------------------------------
  print('  building widget tree with 11 sections');
  final List<Widget> sectionWidgets = <Widget>[
    heroIntro,
    _sectionHeader(2, 'API reference', 'Every named argument with type'),
    apiTableCard,
    _sectionHeader(3, 'Single selection', 'Five flavours, 2 - 5 segments'),
    singleGallery,
    _sectionHeader(4, 'Multi selection', 'multiSelectionEnabled and friends'),
    multiGallery,
    _sectionHeader(5, 'Theme', 'SegmentedButtonThemeData in action'),
    themeShowcase,
    _sectionHeader(6, 'Disabled', 'Per-segment and whole-button disable'),
    disabledShowcase,
    _sectionHeader(7, 'Vertical', 'direction: Axis.vertical layout'),
    verticalShowcase,
    _sectionDivider(),
    _sectionHeader(8, 'Code', 'Six idiomatic snippets'),
    codeBlocksSection,
    _sectionHeader(9, 'Comparison', 'SegmentedButton vs its cousins'),
    comparisonTableCard,
    _sectionHeader(10, 'Pitfalls', 'Six common mistakes'),
    pitfallsCard,
    _sectionHeader(11, 'Cheat sheet', 'Names on one screen'),
    cheatSheet,
    const SizedBox(height: 36.0),
  ];
  print('  section widget count: ${sectionWidgets.length}');

  // -------------------------------------------------------------------------
  // FINAL APP
  // -------------------------------------------------------------------------
  // A single `MaterialApp` wrapping a `Scaffold`. The app uses Material 3
  // so the SegmentedButton widgets render with their modern look. Backed by
  // a `ListView` so the long demo scrolls vertically.
  // -------------------------------------------------------------------------
  final Widget app = MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'SegmentedButton Demo',
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _kPrimary,
        primary: _kPrimary,
        secondary: _kSecondary,
        tertiary: _kTertiary,
      ),
      scaffoldBackgroundColor: _kCanvas,
      visualDensity: VisualDensity.standard,
    ),
    home: Scaffold(
      backgroundColor: _kCanvas,
      appBar: AppBar(
        backgroundColor: _kPrimary,
        foregroundColor: const Color(0xFFFFFFFF),
        elevation: 0.0,
        title: const Text(
          'SegmentedButton',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            letterSpacing: -0.2,
          ),
        ),
        actions: const <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.0),
            child: Center(
              child: Text(
                'flutter/material',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12.0,
                  color: Color(0xFFFFFFFF),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          children: sectionWidgets,
        ),
      ),
    ),
  );

  print('SegmentedButton deep visual demo built successfully');
  return app;
}
