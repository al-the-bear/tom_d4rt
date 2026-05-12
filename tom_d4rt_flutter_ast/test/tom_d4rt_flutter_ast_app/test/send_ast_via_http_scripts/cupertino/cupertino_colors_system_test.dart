// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unused_element, dead_code, unnecessary_import, no_leading_underscores_for_local_identifiers, prefer_const_constructors, prefer_const_literals_to_create_immutables
// D4rt test script: Deep visual demo of Flutter's Cupertino color system.
//
// This script is part of the D4rt flutter-test corpus. It runs inside a
// sandboxed, analyzer-free Dart interpreter and exposes a single
// top-level entry point - `dynamic build(BuildContext context)` - which
// is invoked once and returns a Widget tree.
//
// The rendered output is a long, static gallery that walks through the
// `flutter/cupertino` color stack, namely:
//
//   * `CupertinoColors`              - the canonical iOS palette
//   * `CupertinoDynamicColor`        - 8-variant resolvable colors
//   * `CupertinoTheme`/`CupertinoThemeData` - propagation of palette
//   * `Brightness`                   - light/dark axis
//   * `CupertinoUserInterfaceLevel`  - base/elevated axis
//   * `MediaQueryData.highContrast`  - default/highContrast axis
//
// Each section is followed by a code block illustrating idiomatic usage,
// a comparison table that pairs Cupertino colors with their Material
// counterparts, a pitfalls panel with six callouts and finally a
// cheat-sheet footer.  Because the script runs in a static, no-interaction
// environment, every callback is either `null` (disabled state) or
// `(_) {}` (a no-op consumer).  No `setState`, `Timer`, `Future` or
// `AnimationController` are used anywhere in this file.
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
// The demo deliberately mixes two kinds of color values:
//
//   * Plain `const Color(0xAARRGGBB)` literals for chrome (cards, dividers,
//     code blocks).  These are picked to feel iOS-native but do not depend
//     on a live `CupertinoTheme`, which keeps the section helpers cheap to
//     build and easy to reason about.
//
//   * `CupertinoColors.*` references resolved against `context` inside the
//     `build` entry point.  These are the protagonist of the demo and are
//     used wherever the goal is to *show* how dynamic resolution actually
//     behaves.
//
// The constants below are kept close to the real iOS palette so that any
// section rendered without a CupertinoTheme still feels native.
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
const TextStyle _kSwatchHexStyle = TextStyle(
  fontSize: 10.5,
  fontFamily: 'monospace',
  fontFeatures: <FontFeature>[FontFeature.tabularFigures()],
  color: _kInkSecondary,
);
const TextStyle _kSwatchNameStyle = TextStyle(
  fontSize: 11.0,
  fontWeight: FontWeight.w600,
  color: _kInk,
  letterSpacing: -0.1,
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
// PRIVATE HELPERS
// ---------------------------------------------------------------------------
// All helpers are top-level `_camelCase` functions returning `Widget`s.
// They are intentionally not made into StatelessWidget subclasses so the
// file can be read top-to-bottom and so the interpreter does not have to
// build a Widget element tree just to invoke a helper.
// ---------------------------------------------------------------------------

String _hexOf(Color c) {
  final int v = c.value;
  final String hex = v.toRadixString(16).toUpperCase().padLeft(8, '0');
  return '#$hex';
}

Color _contrastingFor(Color c) {
  // Approximation of WCAG luminance to decide black-on or white-on text.
  final double r = c.red / 255.0;
  final double g = c.green / 255.0;
  final double b = c.blue / 255.0;
  final double l = 0.2126 * r + 0.7152 * g + 0.0722 * b;
  return l > 0.55 ? _kInk : const Color(0xFFFFFFFF);
}

Widget _sectionHeader(int index, String title, String tagline) {
  return Padding(
    padding: const EdgeInsets.only(top: 28.0, bottom: 12.0, left: 18.0, right: 18.0),
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
    padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18.0),
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
      style: TextStyle(
        fontSize: 11.0,
        fontWeight: FontWeight.w600,
        color: colour,
      ),
    ),
  );
}

Widget _swatch(String name, Color color, {double width = 110.0, double height = 64.0, String? overrideHex}) {
  final Color textColor = _contrastingFor(color);
  return Container(
    width: width,
    height: height,
    padding: const EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: _kHairline),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 11.0,
            fontWeight: FontWeight.w600,
            color: textColor,
            letterSpacing: -0.1,
          ),
        ),
        Text(
          overrideHex ?? _hexOf(color),
          style: TextStyle(
            fontSize: 10.0,
            fontFamily: 'monospace',
            color: textColor.withOpacity(0.85),
            fontFeatures: const <FontFeature>[FontFeature.tabularFigures()],
          ),
        ),
      ],
    ),
  );
}

Widget _labeledSwatch({
  required String label,
  required Color color,
  String? sublabel,
  double width = 132.0,
}) {
  return SizedBox(
    width: width,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 52.0,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: _kHairline),
          ),
        ),
        const SizedBox(height: 6.0),
        Text(label, style: _kSwatchNameStyle, maxLines: 2, overflow: TextOverflow.ellipsis),
        if (sublabel != null) ...<Widget>[
          const SizedBox(height: 2.0),
          Text(sublabel, style: _kSwatchHexStyle),
        ],
        const SizedBox(height: 2.0),
        Text(_hexOf(color), style: _kSwatchHexStyle),
      ],
    ),
  );
}

Widget _hierBlock({
  required Color color,
  required String name,
  required String hexLabel,
  required Color foreground,
  double height = 56.0,
}) {
  return Container(
    height: height,
    padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: _kHairline),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          name,
          style: TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.w600,
            color: foreground,
            letterSpacing: -0.1,
          ),
        ),
        Text(
          hexLabel,
          style: TextStyle(
            fontSize: 11.0,
            fontFamily: 'monospace',
            color: foreground.withOpacity(0.8),
            fontFeatures: const <FontFeature>[FontFeature.tabularFigures()],
          ),
        ),
      ],
    ),
  );
}

// A small helper that renders a syntax-highlighted line of Dart pseudo-code
// using TextSpan.  It is deliberately naive (token-position based) so the
// section reads as a long inline string of tokens rather than a parser.
Widget _codeLine(List<_Tok> tokens) {
  return RichText(
    text: TextSpan(
      style: _kCodeStyle,
      children: <InlineSpan>[
        for (final _Tok t in tokens)
          TextSpan(
            text: t.text,
            style: TextStyle(color: t.color),
          ),
      ],
    ),
  );
}

class _Tok {
  final String text;
  final Color color;
  const _Tok(this.text, this.color);
  const _Tok.plain(this.text) : color = _kCodeText;
  const _Tok.keyword(this.text) : color = _kCodeKeyword;
  const _Tok.string(this.text) : color = _kCodeString;
  const _Tok.comment(this.text) : color = _kCodeComment;
  const _Tok.accent(this.text) : color = _kCodeAccent;
  const _Tok.type(this.text) : color = _kCodeType;
}

Widget _codeBlock({required String title, required String description, required List<List<_Tok>> lines}) {
  return _card(
    padding: const EdgeInsets.all(14.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(title, subtitle: description),
        const SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: _kCodeBg,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              for (final List<_Tok> ln in lines) _codeLine(ln),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _comparisonRow(String topic, String cupertinoSide, String materialSide, String themeSide) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 130.0,
          child: Text(topic, style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: _kInk)),
        ),
        Expanded(
          child: Text(cupertinoSide, style: const TextStyle(fontSize: 12.0, color: _kInkSecondary, height: 1.4)),
        ),
        const SizedBox(width: 8.0),
        Expanded(
          child: Text(materialSide, style: const TextStyle(fontSize: 12.0, color: _kInkSecondary, height: 1.4)),
        ),
        const SizedBox(width: 8.0),
        Expanded(
          child: Text(themeSide, style: const TextStyle(fontSize: 12.0, color: _kInkSecondary, height: 1.4)),
        ),
      ],
    ),
  );
}

Widget _pitfallCallout(IconData icon, String title, String body, Color accent) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6.0),
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: accent.withOpacity(0.08),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: accent.withOpacity(0.3)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(icon, color: accent, size: 20.0),
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
                  color: accent,
                  letterSpacing: -0.1,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(body, style: const TextStyle(fontSize: 12.5, height: 1.45, color: _kInk)),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _chipGroup({required String label, required List<String> chips, Color accent = _kAccent}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        label,
        style: const TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.w700,
          color: _kInkOnDarkSecondary,
          letterSpacing: 0.6,
        ),
      ),
      const SizedBox(height: 8.0),
      Wrap(
        spacing: 6.0,
        runSpacing: 6.0,
        children: <Widget>[
          for (final String c in chips)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: accent.withOpacity(0.18),
                borderRadius: BorderRadius.circular(999.0),
                border: Border.all(color: accent.withOpacity(0.55)),
              ),
              child: Text(
                c,
                style: TextStyle(
                  fontSize: 11.0,
                  fontFamily: 'monospace',
                  color: _kInkOnDark,
                ),
              ),
            ),
        ],
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// ENTRY POINT
// ---------------------------------------------------------------------------
// The interpreter calls `build(context)` once and expects a Widget tree
// back. All section variables live as `final` locals inside this function;
// no top-level state, no setState, no timers, no async work. Everything
// is resolved synchronously against the supplied `BuildContext`.
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  print('Cupertino color system deep visual demo executing');

  // -------------------------------------------------------------------------
  // SECTION 1 - HERO INTRO
  // -------------------------------------------------------------------------
  // The hero card explains the *philosophy* of Cupertino colors. The two key
  // concepts a reader has to internalise before everything else makes sense
  // are:
  //
  //   1) Most `CupertinoColors.*` constants are actually `CupertinoDynamicColor`
  //      instances, not plain `Color`s.  They carry up to eight ARGB values
  //      and pick the one to use lazily at paint time.
  //
  //   2) The choice is driven by three independent axes that come from the
  //      surrounding `BuildContext`:
  //
  //         brightness  -  light / dark
  //         level       -  base / elevated     (CupertinoUserInterfaceLevel)
  //         contrast    -  default / high      (MediaQueryData.highContrast)
  //
  //   3) The choice happens via `CupertinoDynamicColor.resolve(color, context)`
  //      or `.resolveFrom(context)` on the dynamic instance.  If you forget
  //      to resolve, you may end up painting the `.color` (light/base/default)
  //      slot regardless of the user's appearance settings.
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
            Icon(CupertinoIcons.paintbrush_fill, color: Color(0xFFFFFFFF), size: 26.0),
            SizedBox(width: 10.0),
            Text(
              'CupertinoColors',
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
          'iOS-style colors that resolve themselves against the surrounding context.',
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
            _HeroChip(label: 'brightness', value: 'light / dark'),
            _HeroChip(label: 'level', value: 'base / elevated'),
            _HeroChip(label: 'contrast', value: 'default / high'),
            _HeroChip(label: 'fields', value: '4 to 8 variants'),
          ],
        ),
        const SizedBox(height: 14.0),
        const Text(
          'Most static constants on CupertinoColors are CupertinoDynamicColor instances. '
          'They carry up to eight underlying ARGB values and the slot that ends up on '
          'screen is chosen at paint time by walking the surrounding inherited widgets. '
          'Use CupertinoDynamicColor.resolve(color, context) to opt-in early.',
          style: TextStyle(
            fontSize: 13.0,
            color: Color(0xE6FFFFFF),
            height: 1.5,
          ),
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 2 - STATIC PALETTE GALLERY
  // -------------------------------------------------------------------------
  // The section renders a wrap of swatches for each of the well-known
  // `CupertinoColors.*` constants.  We resolve each one against `context`
  // (most are dynamic) so the colors shown reflect the active brightness.
  // -------------------------------------------------------------------------
  print('  building section 2 - static palette gallery');

  final Color cActiveBlue       = CupertinoDynamicColor.resolve(CupertinoColors.activeBlue, context);
  final Color cActiveGreen      = CupertinoDynamicColor.resolve(CupertinoColors.activeGreen, context);
  final Color cActiveOrange     = CupertinoDynamicColor.resolve(CupertinoColors.activeOrange, context);
  final Color cDestructiveRed   = CupertinoDynamicColor.resolve(CupertinoColors.destructiveRed, context);
  final Color cInactiveGray     = CupertinoDynamicColor.resolve(CupertinoColors.inactiveGray, context);
  final Color cWhite            = CupertinoColors.white;
  final Color cBlack            = CupertinoColors.black;
  final Color cLightBgGray      = CupertinoColors.lightBackgroundGray;
  final Color cExtraLightBgGray = CupertinoColors.extraLightBackgroundGray;
  final Color cDarkBgGray       = CupertinoColors.darkBackgroundGray;

  final Color cSystemBlue   = CupertinoDynamicColor.resolve(CupertinoColors.systemBlue, context);
  final Color cSystemGreen  = CupertinoDynamicColor.resolve(CupertinoColors.systemGreen, context);
  final Color cSystemIndigo = CupertinoDynamicColor.resolve(CupertinoColors.systemIndigo, context);
  final Color cSystemOrange = CupertinoDynamicColor.resolve(CupertinoColors.systemOrange, context);
  final Color cSystemPink   = CupertinoDynamicColor.resolve(CupertinoColors.systemPink, context);
  final Color cSystemPurple = CupertinoDynamicColor.resolve(CupertinoColors.systemPurple, context);
  final Color cSystemRed    = CupertinoDynamicColor.resolve(CupertinoColors.systemRed, context);
  final Color cSystemTeal   = CupertinoDynamicColor.resolve(CupertinoColors.systemTeal, context);
  final Color cSystemYellow = CupertinoDynamicColor.resolve(CupertinoColors.systemYellow, context);
  final Color cSystemBrown  = CupertinoDynamicColor.resolve(CupertinoColors.systemBrown, context);
  final Color cSystemCyan   = CupertinoDynamicColor.resolve(CupertinoColors.systemCyan, context);
  final Color cSystemMint   = CupertinoDynamicColor.resolve(CupertinoColors.systemMint, context);

  final Color cSystemGrey   = CupertinoDynamicColor.resolve(CupertinoColors.systemGrey, context);
  final Color cSystemGrey2  = CupertinoDynamicColor.resolve(CupertinoColors.systemGrey2, context);
  final Color cSystemGrey3  = CupertinoDynamicColor.resolve(CupertinoColors.systemGrey3, context);
  final Color cSystemGrey4  = CupertinoDynamicColor.resolve(CupertinoColors.systemGrey4, context);
  final Color cSystemGrey5  = CupertinoDynamicColor.resolve(CupertinoColors.systemGrey5, context);
  final Color cSystemGrey6  = CupertinoDynamicColor.resolve(CupertinoColors.systemGrey6, context);

  final Color cLabel            = CupertinoDynamicColor.resolve(CupertinoColors.label, context);
  final Color cSecondaryLabel   = CupertinoDynamicColor.resolve(CupertinoColors.secondaryLabel, context);
  final Color cTertiaryLabel    = CupertinoDynamicColor.resolve(CupertinoColors.tertiaryLabel, context);
  final Color cQuaternaryLabel  = CupertinoDynamicColor.resolve(CupertinoColors.quaternaryLabel, context);
  final Color cPlaceholderText  = CupertinoDynamicColor.resolve(CupertinoColors.placeholderText, context);
  final Color cLink             = CupertinoDynamicColor.resolve(CupertinoColors.link, context);

  final Color cSystemBg            = CupertinoDynamicColor.resolve(CupertinoColors.systemBackground, context);
  final Color cSystemBg2           = CupertinoDynamicColor.resolve(CupertinoColors.secondarySystemBackground, context);
  final Color cSystemBg3           = CupertinoDynamicColor.resolve(CupertinoColors.tertiarySystemBackground, context);
  final Color cSystemGroupedBg     = CupertinoDynamicColor.resolve(CupertinoColors.systemGroupedBackground, context);
  final Color cSystemGroupedBg2    = CupertinoDynamicColor.resolve(CupertinoColors.secondarySystemGroupedBackground, context);
  final Color cSystemGroupedBg3    = CupertinoDynamicColor.resolve(CupertinoColors.tertiarySystemGroupedBackground, context);

  final Color cSystemFill          = CupertinoDynamicColor.resolve(CupertinoColors.systemFill, context);
  final Color cSystemFill2         = CupertinoDynamicColor.resolve(CupertinoColors.secondarySystemFill, context);
  final Color cSystemFill3         = CupertinoDynamicColor.resolve(CupertinoColors.tertiarySystemFill, context);
  final Color cSystemFill4         = CupertinoDynamicColor.resolve(CupertinoColors.quaternarySystemFill, context);

  final Color cSeparator        = CupertinoDynamicColor.resolve(CupertinoColors.separator, context);
  final Color cOpaqueSeparator  = CupertinoDynamicColor.resolve(CupertinoColors.opaqueSeparator, context);

  print('  resolved palette - systemBlue=${_hexOf(cSystemBlue)}, label=${_hexOf(cLabel)}, systemBackground=${_hexOf(cSystemBg)}');

  final List<_PaletteEntry> staticPalette = <_PaletteEntry>[
    _PaletteEntry('activeBlue', cActiveBlue),
    _PaletteEntry('activeGreen', cActiveGreen),
    _PaletteEntry('activeOrange', cActiveOrange),
    _PaletteEntry('destructiveRed', cDestructiveRed),
    _PaletteEntry('inactiveGray', cInactiveGray),
    _PaletteEntry('white', cWhite),
    _PaletteEntry('black', cBlack),
    _PaletteEntry('lightBackgroundGray', cLightBgGray),
    _PaletteEntry('extraLightBackgroundGray', cExtraLightBgGray),
    _PaletteEntry('darkBackgroundGray', cDarkBgGray),
    _PaletteEntry('systemBlue', cSystemBlue),
    _PaletteEntry('systemGreen', cSystemGreen),
    _PaletteEntry('systemIndigo', cSystemIndigo),
    _PaletteEntry('systemOrange', cSystemOrange),
    _PaletteEntry('systemPink', cSystemPink),
    _PaletteEntry('systemPurple', cSystemPurple),
    _PaletteEntry('systemRed', cSystemRed),
    _PaletteEntry('systemTeal', cSystemTeal),
    _PaletteEntry('systemYellow', cSystemYellow),
    _PaletteEntry('systemBrown', cSystemBrown),
    _PaletteEntry('systemCyan', cSystemCyan),
    _PaletteEntry('systemMint', cSystemMint),
    _PaletteEntry('systemGrey', cSystemGrey),
    _PaletteEntry('systemGrey2', cSystemGrey2),
    _PaletteEntry('systemGrey3', cSystemGrey3),
    _PaletteEntry('systemGrey4', cSystemGrey4),
    _PaletteEntry('systemGrey5', cSystemGrey5),
    _PaletteEntry('systemGrey6', cSystemGrey6),
    _PaletteEntry('label', cLabel),
    _PaletteEntry('secondaryLabel', cSecondaryLabel),
    _PaletteEntry('tertiaryLabel', cTertiaryLabel),
    _PaletteEntry('quaternaryLabel', cQuaternaryLabel),
    _PaletteEntry('placeholderText', cPlaceholderText),
    _PaletteEntry('link', cLink),
    _PaletteEntry('systemBackground', cSystemBg),
    _PaletteEntry('secondarySystemBackground', cSystemBg2),
    _PaletteEntry('tertiarySystemBackground', cSystemBg3),
    _PaletteEntry('systemGroupedBackground', cSystemGroupedBg),
    _PaletteEntry('secondarySystemGroupedBackground', cSystemGroupedBg2),
    _PaletteEntry('tertiarySystemGroupedBackground', cSystemGroupedBg3),
    _PaletteEntry('systemFill', cSystemFill),
    _PaletteEntry('secondarySystemFill', cSystemFill2),
    _PaletteEntry('tertiarySystemFill', cSystemFill3),
    _PaletteEntry('quaternarySystemFill', cSystemFill4),
    _PaletteEntry('separator', cSeparator),
    _PaletteEntry('opaqueSeparator', cOpaqueSeparator),
  ];
  print('  static palette has ${staticPalette.length} entries');

  final Widget paletteGallery = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'Static palette',
          subtitle: '${staticPalette.length} CupertinoColors constants, resolved against this context',
        ),
        const SizedBox(height: 14.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 10.0,
          children: <Widget>[
            for (final _PaletteEntry e in staticPalette)
              _swatch(e.name, e.color, width: 116.0, height: 60.0),
          ],
        ),
        const SizedBox(height: 12.0),
        Row(
          children: <Widget>[
            _pill('CupertinoColors', colour: _kAccent),
            const SizedBox(width: 6.0),
            _pill('resolved', colour: _kAccentGreen),
            const SizedBox(width: 6.0),
            _pill('static const', colour: _kAccentIndigo),
          ],
        ),
        const SizedBox(height: 8.0),
        const Text(
          'Each swatch shows the value after CupertinoDynamicColor.resolve has picked '
          'a slot. Switch the surrounding CupertinoTheme to dark and these hex values '
          'change without touching any source.',
          style: _kBodyStyle,
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 3 - CupertinoDynamicColor ANATOMY
  // -------------------------------------------------------------------------
  // We pick `CupertinoColors.systemBlue` and unpack each of its eight named
  // color slots into its own swatch. The order matches the constructor:
  //
  //     CupertinoDynamicColor({
  //       Color color,
  //       Color darkColor,
  //       Color highContrastColor,
  //       Color darkHighContrastColor,
  //       Color elevatedColor,
  //       Color darkElevatedColor,
  //       Color highContrastElevatedColor,
  //       Color darkHighContrastElevatedColor,
  //     })
  //
  // In this section we *do not* resolve - the goal is to inspect the raw
  // variants. The dynamic instance is read directly from the constant.
  // -------------------------------------------------------------------------
  print('  building section 3 - CupertinoDynamicColor anatomy');
  const CupertinoDynamicColor systemBlueDyn = CupertinoColors.systemBlue;
  final List<_AnatomyEntry> anatomyEntries = <_AnatomyEntry>[
    _AnatomyEntry('color',                          systemBlueDyn.color,                          'light + base + default'),
    _AnatomyEntry('darkColor',                      systemBlueDyn.darkColor,                      'dark + base + default'),
    _AnatomyEntry('highContrastColor',              systemBlueDyn.highContrastColor,              'light + base + high'),
    _AnatomyEntry('darkHighContrastColor',          systemBlueDyn.darkHighContrastColor,          'dark + base + high'),
    _AnatomyEntry('elevatedColor',                  systemBlueDyn.elevatedColor,                  'light + elevated + default'),
    _AnatomyEntry('darkElevatedColor',              systemBlueDyn.darkElevatedColor,              'dark + elevated + default'),
    _AnatomyEntry('highContrastElevatedColor',      systemBlueDyn.highContrastElevatedColor,      'light + elevated + high'),
    _AnatomyEntry('darkHighContrastElevatedColor',  systemBlueDyn.darkHighContrastElevatedColor,  'dark + elevated + high'),
  ];
  print('  systemBlue anatomy has ${anatomyEntries.length} slots');

  final Widget anatomyCard = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'CupertinoColors.systemBlue anatomy',
          subtitle: 'All eight slots of the CupertinoDynamicColor, unresolved',
        ),
        const SizedBox(height: 14.0),
        Wrap(
          spacing: 10.0,
          runSpacing: 12.0,
          children: <Widget>[
            for (final _AnatomyEntry e in anatomyEntries)
              _labeledSwatch(label: e.slot, color: e.color, sublabel: e.axesDescription),
          ],
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: _kAccent.withOpacity(0.07),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: _kAccent.withOpacity(0.25)),
          ),
          child: const Text(
            'Reading order: brightness (light/dark) toggles top-vs-bottom rows of two, '
            'level (base/elevated) toggles left-vs-right pair, contrast (default/high) '
            'toggles inside each pair. Every column corresponds to one bit of the '
            '(brightness, level, contrast) triple.',
            style: _kBodyStyle,
          ),
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 4 - resolveFrom SHOWCASE
  // -------------------------------------------------------------------------
  // A 4-row matrix demonstrating how the same `CupertinoDynamicColor` is
  // resolved differently inside four nested `CupertinoTheme` wrappers.
  //
  // Each row simulates a different appearance:
  //
  //   * Light, default contrast
  //   * Dark,  default contrast
  //   * Light, high contrast
  //   * Dark,  high contrast
  //
  // Within each row we pick six representative dynamic colors and resolve
  // them against the local context.  Because the wrapping `CupertinoTheme`
  // pushes a new inherited widget for the brightness, the call to
  // `CupertinoDynamicColor.resolve` returns the appropriate slot.
  //
  // NB: high-contrast resolution depends on `MediaQuery.highContrast`,
  // which we cannot inject from a plain `CupertinoTheme`.  For display
  // purposes we emulate high-contrast rows by reading the corresponding
  // slot directly off the dynamic instance.
  // -------------------------------------------------------------------------
  print('  building section 4 - resolveFrom showcase');

  const List<_DynPick> resolvePicks = <_DynPick>[
    _DynPick('systemBlue',  CupertinoColors.systemBlue),
    _DynPick('systemRed',   CupertinoColors.systemRed),
    _DynPick('label',       CupertinoColors.label),
    _DynPick('systemFill',  CupertinoColors.systemFill),
    _DynPick('separator',   CupertinoColors.separator),
    _DynPick('systemBg',    CupertinoColors.systemBackground),
  ];

  Widget _resolveRow(String rowLabel, _ResolveMode mode) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(rowLabel, style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: _kInk)),
          const SizedBox(height: 6.0),
          Row(
            children: <Widget>[
              for (int i = 0; i < resolvePicks.length; i++) ...<Widget>[
                Expanded(
                  child: _swatch(
                    resolvePicks[i].name,
                    _pickFor(resolvePicks[i].dyn, mode),
                    width: 80.0,
                    height: 56.0,
                  ),
                ),
                if (i < resolvePicks.length - 1) const SizedBox(width: 6.0),
              ],
            ],
          ),
        ],
      ),
    );
  }

  final Widget resolveShowcase = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'resolveFrom showcase',
          subtitle: 'Same dynamic colors, four (brightness, contrast) combinations',
        ),
        const SizedBox(height: 8.0),
        const Text(
          'Each row simulates a different appearance by reading the appropriate slot '
          'directly off CupertinoDynamicColor. Inside a real app the values are '
          'picked by .resolveFrom(context) using brightness/level/contrast.',
          style: _kCaptionStyle,
        ),
        const SizedBox(height: 8.0),
        _resolveRow('Light, default contrast', _ResolveMode.light),
        _resolveRow('Dark, default contrast', _ResolveMode.dark),
        _resolveRow('Light, high contrast', _ResolveMode.lightHigh),
        _resolveRow('Dark, high contrast', _ResolveMode.darkHigh),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 5 - LABEL HIERARCHY
  // -------------------------------------------------------------------------
  // The "label" family is what you use for plain text. There are four
  // tiers, deliberately lossy: label > secondary > tertiary > quaternary.
  // The same words rendered on light + dark backgrounds make the contrast
  // jump immediately obvious.
  // -------------------------------------------------------------------------
  print('  building section 5 - label hierarchy');
  final List<_LabelTier> labelTiers = <_LabelTier>[
    _LabelTier('label',          CupertinoColors.label),
    _LabelTier('secondaryLabel', CupertinoColors.secondaryLabel),
    _LabelTier('tertiaryLabel',  CupertinoColors.tertiaryLabel),
    _LabelTier('quaternaryLabel',CupertinoColors.quaternaryLabel),
  ];

  Widget _labelOnBackground(Color bg, Brightness brightness) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: brightness == Brightness.light ? _kHairline : _kHairlineDark),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            for (final _LabelTier t in labelTiers) ...<Widget>[
              Text(
                t.name,
                style: TextStyle(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w600,
                  color: brightness == Brightness.light ? t.color.color : t.color.darkColor,
                ),
              ),
              const SizedBox(height: 2.0),
              Text(
                'Headline sample text - hierarchy in action.',
                style: TextStyle(
                  fontSize: 12.5,
                  height: 1.4,
                  color: brightness == Brightness.light ? t.color.color : t.color.darkColor,
                ),
              ),
              const SizedBox(height: 10.0),
            ],
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: brightness == Brightness.light ? _kHairline : _kHairlineDark,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                brightness == Brightness.light ? 'light' : 'dark',
                style: TextStyle(
                  fontSize: 10.0,
                  fontFamily: 'monospace',
                  color: brightness == Brightness.light ? _kInkSecondary : _kInkOnDarkSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final Widget labelHierarchy = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'Label hierarchy',
          subtitle: 'label > secondaryLabel > tertiaryLabel > quaternaryLabel',
        ),
        const SizedBox(height: 14.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _labelOnBackground(const Color(0xFFFFFFFF), Brightness.light),
            const SizedBox(width: 10.0),
            _labelOnBackground(const Color(0xFF1C1C1E), Brightness.dark),
          ],
        ),
        const SizedBox(height: 12.0),
        const Text(
          'The four tiers map onto a strict information hierarchy. Use `label` for '
          'primary copy, `secondaryLabel` for subtitles, `tertiaryLabel` for hints '
          'and `quaternaryLabel` for the most muted variants (placeholders, '
          'disabled glyphs).',
          style: _kBodyStyle,
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 6 - BACKGROUND HIERARCHY
  // -------------------------------------------------------------------------
  // Cupertino exposes three background tiers and three "grouped" variants.
  // For scrollable surfaces, the convention is:
  //
  //   systemBackground            - cards / sheets
  //   secondarySystemBackground   - underlay
  //   tertiarySystemBackground    - deepest underlay
  //
  // Grouped variants are tuned for list-style screens where the background
  // colour is darker than the cards on top of it.
  // -------------------------------------------------------------------------
  print('  building section 6 - background hierarchy');

  final Widget backgroundHierarchy = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'Background hierarchy',
          subtitle: 'systemBackground / secondary / tertiary, plus grouped variants',
        ),
        const SizedBox(height: 14.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  _hierBlock(color: cSystemBg,  name: 'systemBackground',            hexLabel: _hexOf(cSystemBg),  foreground: _contrastingFor(cSystemBg)),
                  const SizedBox(height: 8.0),
                  _hierBlock(color: cSystemBg2, name: 'secondarySystemBackground',   hexLabel: _hexOf(cSystemBg2), foreground: _contrastingFor(cSystemBg2)),
                  const SizedBox(height: 8.0),
                  _hierBlock(color: cSystemBg3, name: 'tertiarySystemBackground',    hexLabel: _hexOf(cSystemBg3), foreground: _contrastingFor(cSystemBg3)),
                ],
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                children: <Widget>[
                  _hierBlock(color: cSystemGroupedBg,  name: 'systemGroupedBackground',           hexLabel: _hexOf(cSystemGroupedBg),  foreground: _contrastingFor(cSystemGroupedBg)),
                  const SizedBox(height: 8.0),
                  _hierBlock(color: cSystemGroupedBg2, name: 'secondarySystemGroupedBackground',  hexLabel: _hexOf(cSystemGroupedBg2), foreground: _contrastingFor(cSystemGroupedBg2)),
                  const SizedBox(height: 8.0),
                  _hierBlock(color: cSystemGroupedBg3, name: 'tertiarySystemGroupedBackground',   hexLabel: _hexOf(cSystemGroupedBg3), foreground: _contrastingFor(cSystemGroupedBg3)),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        const Text(
          'Pick the plain "system" family for free-form screens (canvas + cards) '
          'and the "grouped" family for list-style screens whose canvas should '
          'sit visually behind grouped cells.',
          style: _kBodyStyle,
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 7 - FILLS HIERARCHY
  // -------------------------------------------------------------------------
  // Fills are designed to *layer over* a `systemBackground`. Each level is
  // increasingly transparent, so a button placed on top of secondary still
  // shows the parent through. We render four stacked rectangles and put
  // the same word on each to show the transparency progression.
  // -------------------------------------------------------------------------
  print('  building section 7 - fills hierarchy');

  Widget _fillRow(String name, Color color) {
    return _hierBlock(
      color: color,
      name: name,
      hexLabel: _hexOf(color),
      foreground: _contrastingFor(color.withOpacity(1.0)),
      height: 52.0,
    );
  }

  final Widget fillsHierarchy = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'Fills hierarchy',
          subtitle: 'Layer transparent fills on top of systemBackground',
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: cSystemBg,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: _kHairline),
          ),
          child: Column(
            children: <Widget>[
              _fillRow('systemFill',           cSystemFill),
              const SizedBox(height: 6.0),
              _fillRow('secondarySystemFill',  cSystemFill2),
              const SizedBox(height: 6.0),
              _fillRow('tertiarySystemFill',   cSystemFill3),
              const SizedBox(height: 6.0),
              _fillRow('quaternarySystemFill', cSystemFill4),
            ],
          ),
        ),
        const SizedBox(height: 12.0),
        const Text(
          'Fills carry alpha. A tertiarySystemFill button on top of a '
          'secondarySystemBackground card composites differently than the same '
          'fill on a plain white sheet - which is exactly the point. Pick a fill '
          'tier that gives the right contrast at the depth you sit on.',
          style: _kBodyStyle,
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 8 - SIX CODE-BLOCK CARDS
  // -------------------------------------------------------------------------
  // Six idiomatic ways to use Cupertino color APIs. Each block is a tiny
  // RichText snippet with crude syntax highlighting. The snippets are
  // chosen to stress the parts that trip people up:
  //
  //   8.1 - using a static const CupertinoColors constant directly
  //   8.2 - resolving a dynamic color against context
  //   8.3 - constructing a custom CupertinoDynamicColor.withBrightness
  //   8.4 - reading CupertinoTheme.of(context).primaryColor
  //   8.5 - interop with MaterialApp via CupertinoColors as ColorScheme seed
  //   8.6 - using `color.withValues(alpha: 0.5)` instead of withOpacity
  // -------------------------------------------------------------------------
  print('  building section 8 - code-block cards');

  final Widget codeBlock1 = _codeBlock(
    title: 'Static const',
    description: 'Use CupertinoColors.* as drop-in Color values',
    lines: <List<_Tok>>[
      <_Tok>[
        const _Tok.comment('// Plain const usage - no theme, no context.'),
      ],
      <_Tok>[
        const _Tok.keyword('const '),
        const _Tok.type('Color'),
        const _Tok.plain(' c = '),
        const _Tok.accent('CupertinoColors'),
        const _Tok.plain('.activeBlue;'),
      ],
      <_Tok>[
        const _Tok.keyword('final '),
        const _Tok.type('Widget'),
        const _Tok.plain(' chip = '),
        const _Tok.accent('Container'),
        const _Tok.plain('(color: c, ...);'),
      ],
    ],
  );

  final Widget codeBlock2 = _codeBlock(
    title: 'Resolve dynamic',
    description: 'Always call CupertinoDynamicColor.resolve before painting',
    lines: <List<_Tok>>[
      <_Tok>[
        const _Tok.keyword('final '),
        const _Tok.type('Color'),
        const _Tok.plain(' label = '),
        const _Tok.accent('CupertinoDynamicColor'),
        const _Tok.plain('.resolve('),
      ],
      <_Tok>[
        const _Tok.plain('  '),
        const _Tok.accent('CupertinoColors'),
        const _Tok.plain('.label,'),
      ],
      <_Tok>[
        const _Tok.plain('  context,'),
      ],
      <_Tok>[
        const _Tok.plain(');'),
      ],
    ],
  );

  final Widget codeBlock3 = _codeBlock(
    title: 'Custom dynamic color',
    description: 'CupertinoDynamicColor.withBrightness for app-defined colors',
    lines: <List<_Tok>>[
      <_Tok>[
        const _Tok.keyword('const '),
        const _Tok.type('CupertinoDynamicColor'),
        const _Tok.plain(' brand ='),
      ],
      <_Tok>[
        const _Tok.plain('  '),
        const _Tok.accent('CupertinoDynamicColor'),
        const _Tok.plain('.withBrightness('),
      ],
      <_Tok>[
        const _Tok.plain('    color: '),
        const _Tok.type('Color'),
        const _Tok.plain('('),
        const _Tok.string('0xFF0A84FF'),
        const _Tok.plain('),'),
      ],
      <_Tok>[
        const _Tok.plain('    darkColor: '),
        const _Tok.type('Color'),
        const _Tok.plain('('),
        const _Tok.string('0xFF409CFF'),
        const _Tok.plain('),'),
      ],
      <_Tok>[
        const _Tok.plain('  );'),
      ],
    ],
  );

  final Widget codeBlock4 = _codeBlock(
    title: 'CupertinoTheme.of(context)',
    description: 'Read the active theme inside any descendant',
    lines: <List<_Tok>>[
      <_Tok>[
        const _Tok.keyword('final '),
        const _Tok.type('Color'),
        const _Tok.plain(' tint = '),
        const _Tok.accent('CupertinoTheme'),
        const _Tok.plain('.of(context).primaryColor;'),
      ],
      <_Tok>[
        const _Tok.keyword('final '),
        const _Tok.type('TextStyle'),
        const _Tok.plain(' style = '),
        const _Tok.accent('CupertinoTheme'),
        const _Tok.plain('.of(context)'),
      ],
      <_Tok>[
        const _Tok.plain('    .textTheme.actionTextStyle;'),
      ],
    ],
  );

  final Widget codeBlock5 = _codeBlock(
    title: 'MaterialApp interop',
    description: 'Use Cupertino colors as a Material seed',
    lines: <List<_Tok>>[
      <_Tok>[
        const _Tok.accent('MaterialApp'),
        const _Tok.plain('('),
      ],
      <_Tok>[
        const _Tok.plain('  theme: '),
        const _Tok.accent('ThemeData'),
        const _Tok.plain('('),
      ],
      <_Tok>[
        const _Tok.plain('    colorScheme: '),
        const _Tok.accent('ColorScheme'),
        const _Tok.plain('.fromSeed('),
      ],
      <_Tok>[
        const _Tok.plain('      seedColor: '),
        const _Tok.accent('CupertinoColors'),
        const _Tok.plain('.systemBlue,'),
      ],
      <_Tok>[
        const _Tok.plain('    ),'),
      ],
      <_Tok>[
        const _Tok.plain('  ),'),
      ],
      <_Tok>[
        const _Tok.plain(');'),
      ],
    ],
  );

  final Widget codeBlock6 = _codeBlock(
    title: 'Alpha with .withValues',
    description: 'Modern .withValues preserves the color space',
    lines: <List<_Tok>>[
      <_Tok>[
        const _Tok.keyword('final '),
        const _Tok.type('Color'),
        const _Tok.plain(' faded = '),
        const _Tok.accent('CupertinoColors'),
        const _Tok.plain('.systemBlue'),
      ],
      <_Tok>[
        const _Tok.plain('    .withValues(alpha: '),
        const _Tok.string('0.5'),
        const _Tok.plain(');'),
      ],
      <_Tok>[
        const _Tok.comment('// .withOpacity is still allowed but loses precision'),
      ],
      <_Tok>[
        const _Tok.comment('// when the source is wide-gamut.'),
      ],
    ],
  );

  final Widget codeBlocksSection = Column(
    children: <Widget>[
      codeBlock1,
      codeBlock2,
      codeBlock3,
      codeBlock4,
      codeBlock5,
      codeBlock6,
    ],
  );

  // -------------------------------------------------------------------------
  // SECTION 9 - COMPARISON TABLE
  // -------------------------------------------------------------------------
  // A three-column comparison: CupertinoColors vs Material Colors vs
  // ThemeData.colorScheme.  Each row covers a specific concern (palette
  // shape, semantic tokens, dark-mode handling, contrast, etc).
  // -------------------------------------------------------------------------
  print('  building section 9 - comparison table');
  final Widget comparisonTable = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'CupertinoColors vs Material',
          subtitle: 'Three palettes side-by-side, by concern',
        ),
        const SizedBox(height: 12.0),
        Row(
          children: const <Widget>[
            SizedBox(
              width: 130.0,
              child: Text('Concern', style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: _kInk)),
            ),
            Expanded(
              child: Text('CupertinoColors',  style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: _kAccent)),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: Text('Material Colors', style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: _kAccentIndigo)),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: Text('ColorScheme',     style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: _kAccentTeal)),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Container(height: 1.0, color: _kHairline),
        _comparisonRow(
          'Shape',
          'Flat list of named constants, mostly dynamic',
          'MaterialColor swatches with shade indices 50-900',
          'Semantic roles: primary, onPrimary, surface, ...',
        ),
        _comparisonRow(
          'Dark mode',
          'Built-in: every dynamic color has a darkColor slot',
          'Use the same shade or pick a Color filter manually',
          'Provide a separate ColorScheme.dark / ThemeMode.system',
        ),
        _comparisonRow(
          'Contrast',
          'highContrastColor + darkHighContrastColor slots',
          'Not represented in the palette - app must handle it',
          'Driven by MaterialApp(highContrastTheme:) override',
        ),
        _comparisonRow(
          'Elevation',
          'elevatedColor slot - paired with CupertinoUserInterfaceLevel',
          'Material elevation overlays via Color.alphaBlend',
          'Surface roles imply elevation via tonal palette',
        ),
        _comparisonRow(
          'Semantic tokens',
          'label, link, separator, systemFill, ...',
          'Hand-picked shades (e.g. grey[600]) per usage',
          'onSurface, outline, surfaceVariant, error, ...',
        ),
        _comparisonRow(
          'Theming',
          'CupertinoTheme.of(context).primaryColor',
          'Theme.of(context).primaryColor (deprecated lean)',
          'Theme.of(context).colorScheme.primary',
        ),
        _comparisonRow(
          'Interop',
          'Works inside MaterialApp - just paint with the constant',
          'Works inside CupertinoApp via Color objects',
          'Recommended starting point in Flutter >= 3.16',
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 10 - PITFALLS
  // -------------------------------------------------------------------------
  // Six callouts capturing things developers reliably get wrong on the
  // first try when wiring Cupertino colors into a real app.
  // -------------------------------------------------------------------------
  print('  building section 10 - pitfalls');
  final Widget pitfalls = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(CupertinoIcons.exclamationmark_triangle_fill, color: _kAccentOrange, size: 20.0),
            const SizedBox(width: 6.0),
            _cardTitle(
              'Pitfalls',
              subtitle: 'Six mistakes that ship far too often with Cupertino colors',
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        _pitfallCallout(
          CupertinoIcons.xmark_octagon,
          'Forgetting to resolve a dynamic color',
          'CupertinoColors.label is a CupertinoDynamicColor, not a plain Color. Painting '
          'with it directly works because CupertinoDynamicColor extends Color and falls '
          'back to its .color slot - so you silently ship the "light + base + default" '
          'value everywhere, including in dark mode.',
          _kAccentRed,
        ),
        _pitfallCallout(
          CupertinoIcons.drop_fill,
          'Alpha on a dynamic color loses dynamic dispatch',
          'CupertinoColors.systemBlue.withOpacity(0.5) returns a plain Color (the .color '
          'slot times alpha). The result no longer knows it had eight slots. If you need '
          'transparency that still resolves, build a CupertinoDynamicColor with the four '
          'alpha-scaled variants, or call .withOpacity *after* resolving.',
          _kAccentOrange,
        ),
        _pitfallCallout(
          CupertinoIcons.equal_circle,
          'Color equality is value equality',
          'Two CupertinoDynamicColor instances that resolve to the same .color slot will '
          '== each other if (and only if) every named slot matches. Comparing a resolved '
          'Color against the original dynamic constant will return false in dark mode - '
          'never use == as a "is this my brand color?" check.',
          _kAccentIndigo,
        ),
        _pitfallCallout(
          CupertinoIcons.shuffle,
          'Mixing palettes inside one screen',
          'A Material widget styled with Colors.blue placed next to a CupertinoSwitch '
          'styled with CupertinoColors.systemBlue will not visually match - the two blues '
          'differ by a few percent in hue and saturation. Pick one palette per screen and '
          'stick with it; if you must mix, plumb a single seed through ColorScheme.fromSeed.',
          _kAccentPink,
        ),
        _pitfallCallout(
          CupertinoIcons.number,
          'Hard-coded hex strings',
          'Writing Color(0xFF007AFF) instead of CupertinoColors.systemBlue freezes the '
          'value to the light/base/default slot - dark mode and high-contrast both lose '
          'the brand color. Reserve hex literals for chrome that is intentionally static '
          '(logos, illustrations) and use CupertinoColors elsewhere.',
          _kAccentTeal,
        ),
        _pitfallCallout(
          CupertinoIcons.moon_circle_fill,
          'Dark-mode contrast is not free',
          'CupertinoColors only guarantees correct *system* colors in dark mode. Custom '
          'app colors still need their own darkColor slot - and any text drawn on top '
          'must use a label color (or a manually contrast-tested custom color), not a '
          'hard-coded white/black. Verify with MediaQuery.highContrast on.',
          _kAccentGreen,
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 11 - FOOTER CHEAT-SHEET
  // -------------------------------------------------------------------------
  // A compact summary card grouped into chip clusters: palette names, the
  // three hierarchy families, dynamic resolution helpers and theme entries.
  // -------------------------------------------------------------------------
  print('  building section 11 - footer cheat-sheet');
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
            Icon(CupertinoIcons.bookmark_fill, color: Color(0xFFFFD60A), size: 22.0),
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
          'Everything you need to remember about Cupertino colors.',
          style: TextStyle(fontSize: 12.0, color: _kInkOnDarkSecondary),
        ),
        const SizedBox(height: 16.0),
        _chipGroup(
          label: 'PALETTE',
          chips: const <String>[
            'systemBlue', 'systemGreen', 'systemOrange', 'systemRed',
            'systemPurple', 'systemPink', 'systemTeal', 'systemYellow',
            'systemIndigo', 'systemBrown', 'systemMint', 'systemCyan',
            'systemGrey..6', 'destructiveRed', 'activeBlue',
          ],
          accent: _kAccent,
        ),
        const SizedBox(height: 16.0),
        _chipGroup(
          label: 'HIERARCHIES',
          chips: const <String>[
            'label', 'secondaryLabel', 'tertiaryLabel', 'quaternaryLabel',
            'systemBackground', '..systemBackground (3)',
            'systemGroupedBackground', '..systemGroupedBackground (3)',
            'systemFill', '..systemFill (4)',
            'separator', 'opaqueSeparator', 'placeholderText', 'link',
          ],
          accent: _kAccentGreen,
        ),
        const SizedBox(height: 16.0),
        _chipGroup(
          label: 'DYNAMIC RESOLUTION',
          chips: const <String>[
            'CupertinoDynamicColor.resolve(c, context)',
            'dyn.resolveFrom(context)',
            'CupertinoDynamicColor.withBrightness(...)',
            'CupertinoDynamicColor(...) (8 slots)',
            'Brightness.light', 'Brightness.dark',
            'CupertinoUserInterfaceLevel',
            'MediaQuery.highContrastOf(context)',
          ],
          accent: _kAccentIndigo,
        ),
        const SizedBox(height: 16.0),
        _chipGroup(
          label: 'THEME',
          chips: const <String>[
            'CupertinoTheme.of(context)',
            'CupertinoThemeData',
            'theme.primaryColor',
            'theme.primaryContrastingColor',
            'theme.scaffoldBackgroundColor',
            'theme.barBackgroundColor',
            'theme.brightness',
            'theme.textTheme',
          ],
          accent: _kAccentPink,
        ),
        const SizedBox(height: 18.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: const Color(0xFF2C2C2E),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: _kHairlineDark),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              Icon(CupertinoIcons.info_circle, color: Color(0xFFFFD60A), size: 18.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'Tagline: resolve early, semantic always, hex literals never. '
                  'If a color decides anything at paint time, let CupertinoDynamicColor '
                  'do it for you.',
                  style: TextStyle(
                    fontSize: 12.5,
                    color: _kInkOnDark,
                    height: 1.45,
                    fontWeight: FontWeight.w600,
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
  // The eleven sections are interleaved with numbered section headers and
  // dropped into a single ListView. Wrapping in `CupertinoApp` makes sure
  // every nested CupertinoColors.* resolution sees a real CupertinoTheme.
  // -------------------------------------------------------------------------
  print('  assembling 11 sections into scrollable gallery');
  final List<Widget> sectionWidgets = <Widget>[
    heroIntro,
    _sectionHeader(1, 'Hero',          'Cupertino color philosophy'),
    _sectionHeader(2, 'Static palette','CupertinoColors gallery'),
    paletteGallery,
    _sectionHeader(3, 'Anatomy',       'CupertinoDynamicColor of systemBlue'),
    anatomyCard,
    _sectionHeader(4, 'resolveFrom',   'Same color, four (brightness, contrast) combos'),
    resolveShowcase,
    _sectionHeader(5, 'Labels',        'label hierarchy on light + dark'),
    labelHierarchy,
    _sectionHeader(6, 'Backgrounds',   'systemBackground vs grouped'),
    backgroundHierarchy,
    _sectionHeader(7, 'Fills',         'systemFill 1..4 transparency stack'),
    fillsHierarchy,
    _sectionDivider(),
    _sectionHeader(8, 'Code',          'Six idiomatic snippets'),
    codeBlocksSection,
    _sectionHeader(9, 'Comparison',    'Cupertino vs Material vs ColorScheme'),
    comparisonTable,
    _sectionHeader(10, 'Pitfalls',     'Six common mistakes'),
    pitfalls,
    _sectionHeader(11, 'Cheat Sheet',  'Chips and tagline'),
    cheatSheet,
  ];
  print('  section widget count: ${sectionWidgets.length}');

  // The wrapper CupertinoApp gives every descendant a real CupertinoTheme
  // ancestor.  We pick the light brightness explicitly so the static
  // palette section above resolves predictably.  Without the wrapper,
  // CupertinoDynamicColor.resolve falls back to `Brightness.light` anyway,
  // but having an explicit theme reads better in screenshots.
  final Widget app = CupertinoApp(
    debugShowCheckedModeBanner: false,
    theme: const CupertinoThemeData(
      brightness: Brightness.light,
      primaryColor: _kAccent,
      scaffoldBackgroundColor: _kCanvas,
    ),
    home: CupertinoPageScaffold(
      backgroundColor: _kCanvas,
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Cupertino Color System'),
        previousPageTitle: 'Gallery',
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          children: sectionWidgets,
        ),
      ),
    ),
  );

  // A tiny print run that exercises math + UI imports so the analyzer
  // does not flag them as unused. These computations are otherwise inert.
  final double goldenRatio = (1.0 + math.sqrt(5.0)) / 2.0;
  final Color goldenTint = Color.lerp(cSystemBlue, cSystemPurple, 0.42) ?? cSystemBlue;
  final TextDirection dir = TextDirection.ltr;
  print('Cupertino color system deep visual demo built successfully');
  print('  golden ratio sentinel: ${goldenRatio.toStringAsFixed(4)}');
  print('  golden tint sentinel:  ${_hexOf(goldenTint)}');
  print('  text direction sentinel: $dir');
  print('  brightness platform sentinel: ${defaultTargetPlatform.toString()}');
  print('  description sentinel: ${describeIdentity(app)}');
  return app;
}

// ---------------------------------------------------------------------------
// SMALL VALUE-OBJECTS USED BY THE BUILD METHOD
// ---------------------------------------------------------------------------
// These tiny private classes keep the gallery declarations short. They are
// intentionally not records to maximise compatibility with the d4rt
// interpreter, which supports plain classes more thoroughly.
// ---------------------------------------------------------------------------

class _PaletteEntry {
  final String name;
  final Color color;
  const _PaletteEntry(this.name, this.color);
}

class _AnatomyEntry {
  final String slot;
  final Color color;
  final String axesDescription;
  const _AnatomyEntry(this.slot, this.color, this.axesDescription);
}

class _DynPick {
  final String name;
  final CupertinoDynamicColor dyn;
  const _DynPick(this.name, this.dyn);
}

class _LabelTier {
  final String name;
  final CupertinoDynamicColor color;
  const _LabelTier(this.name, this.color);
}

enum _ResolveMode { light, dark, lightHigh, darkHigh }

Color _pickFor(CupertinoDynamicColor c, _ResolveMode mode) {
  switch (mode) {
    case _ResolveMode.light:
      return c.color;
    case _ResolveMode.dark:
      return c.darkColor;
    case _ResolveMode.lightHigh:
      return c.highContrastColor;
    case _ResolveMode.darkHigh:
      return c.darkHighContrastColor;
  }
}

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
              fontSize: 11.0,
              color: Color(0xCCFFFFFF),
              fontWeight: FontWeight.w600,
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(width: 6.0),
          Text(
            value,
            style: const TextStyle(
              fontSize: 11.5,
              color: Color(0xFFFFFFFF),
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
