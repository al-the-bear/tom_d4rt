// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unused_element, dead_code, unnecessary_import, no_leading_underscores_for_local_identifiers
// D4rt test script: Deep visual demo of the Material AppBarTheme surface.
//
// This file is part of the D4rt flutter-test corpus and is executed by an
// analyzer-free, sandboxed Dart interpreter. The script exports exactly one
// top-level entry point - `dynamic build(BuildContext)` - which the runtime
// invokes a single time. The returned widget tree is then handed straight
// to the host app's renderer.
//
// The rendered output is a long, static gallery that walks through Flutter's
// Material-3 AppBar theming surface. Ten thematic sections cover:
//
//   1. Hero intro - what AppBarTheme is, how Theme.of(context).appBarTheme
//      is resolved at runtime by AppBar widgets.
//   2. AppBarTheme anatomy table - every field annotated with its type,
//      default semantics, and one-line use-case description.
//   3. Light vs Dark side-by-side mock AppBars - the same widget tree
//      rendered under two ThemeData seeds to make defaults concrete.
//   4. scrolledUnderElevation visual demo - three frozen states showing
//      the surface-tint overlay applied as the user scrolls.
//   5. SliverAppBar pinned / floating / snap state diagram - the three
//      stretch modes drawn as a horizontal timeline.
//   6. surfaceTintColor explanation panel - the M3 tonal elevation
//      overlay, why it exists, how it composes with background.
//   7. AppBar vs SliverAppBar comparison matrix - axes such as "scroll
//      coupling", "supports stretch", "owns flexibleSpace".
//   8. Code-snippet cards for ThemeData.appBarTheme overrides - six
//      idiomatic recipes (full theme, single field, copyWith, dark
//      variant, M2 fallback, per-route override).
//   9. Pitfalls panel - eight callouts about implicit defaults, back
//      button visibility, centerTitle platform variance, and the
//      systemOverlayStyle gotcha on Android.
//  10. Cheat-sheet footer - compact chips for every field name.
//
// Build-time discipline: no `setState`, no `Timer`, no `Future`, no
// `AnimationController`, no `for-in` over BridgedInstance collections from
// Flutter APIs. All "data" tables are hand-spelled Dart lists of records.
import 'dart:math' as math;
import 'dart:ui' show FontFeature;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

// ---------------------------------------------------------------------------
// COLOUR & TYPOGRAPHY CONSTANTS
// ---------------------------------------------------------------------------
const Color _kCanvas = Color(0xFFF4F5F8);
const Color _kCardBg = Color(0xFFFFFFFF);
const Color _kCardSoft = Color(0xFFF8F9FC);
const Color _kCardDark = Color(0xFF1B1D2A);
const Color _kHairline = Color(0x14000000);
const Color _kHairlineDark = Color(0x33FFFFFF);
const Color _kInk = Color(0xFF1A1C25);
const Color _kInkSecondary = Color(0xFF424657);
const Color _kInkTertiary = Color(0xFF8C90A1);
const Color _kInkOnDark = Color(0xFFEDEEF5);
const Color _kInkOnDarkSecondary = Color(0xFFA3A6B8);
const Color _kAccent = Color(0xFF4F46E5); // indigo
const Color _kAccentSoft = Color(0xFFEEF2FF);
const Color _kAccentBlue = Color(0xFF2563EB);
const Color _kAccentTeal = Color(0xFF14B8A6);
const Color _kAccentGreen = Color(0xFF22C55E);
const Color _kAccentAmber = Color(0xFFF59E0B);
const Color _kAccentRose = Color(0xFFE11D48);
const Color _kAccentViolet = Color(0xFF8B5CF6);
const Color _kCodeBg = Color(0xFF1E1F22);
const Color _kCodeText = Color(0xFFE6E6E6);
const Color _kCodeAccent = Color(0xFF7DD3FC);

// M3 reference seed colours - hand-spelled so the demo is theme-independent.
const Color _kSeedPrimary = Color(0xFF4F46E5);
const Color _kLightAppBarBg = Color(0xFFFFFFFF);
const Color _kLightAppBarFg = Color(0xFF1A1C25);
const Color _kLightAppBarTint = Color(0xFFEEF2FF);
const Color _kLightAppBarShadow = Color(0x29000000);
const Color _kDarkAppBarBg = Color(0xFF1B1D2A);
const Color _kDarkAppBarFg = Color(0xFFEDEEF5);
const Color _kDarkAppBarTint = Color(0xFF3730A3);
const Color _kDarkAppBarShadow = Color(0x66000000);

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
    padding: const EdgeInsets.only(
      top: 30.0,
      bottom: 12.0,
      left: 18.0,
      right: 18.0,
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 38.0,
          height: 38.0,
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

Widget _card({
  required Widget child,
  Color background = _kCardBg,
  EdgeInsets padding = _kCardPadding,
  EdgeInsets margin = const EdgeInsets.symmetric(
    horizontal: 18.0,
    vertical: 6.0,
  ),
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
    padding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: 3.0),
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

Widget _sectionDivider() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 16.0),
    height: 1.0,
    color: _kHairline,
  );
}

Widget _bulletList(List<String> items, {Color colour = _kAccent}) {
  final List<Widget> rows = <Widget>[];
  for (int i = 0; i < items.length; i++) {
    rows.add(
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 7.0, right: 8.0),
              width: 6.0,
              height: 6.0,
              decoration: BoxDecoration(
                color: colour,
                borderRadius: BorderRadius.circular(2.0),
              ),
            ),
            Expanded(child: Text(items[i], style: _kBodySoftStyle)),
          ],
        ),
      ),
    );
  }
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: rows,
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
        colors: <Color>[Color(0xFF312E81), Color(0xFF4F46E5), Color(0xFF7C3AED)],
      ),
      borderRadius: BorderRadius.circular(18.0),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x33312E81),
          offset: Offset(0.0, 6.0),
          blurRadius: 18.0,
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 4.0,
              ),
              decoration: BoxDecoration(
                color: const Color(0x33FFFFFF),
                borderRadius: BorderRadius.circular(999.0),
              ),
              child: const Text(
                'package:flutter/material.dart',
                style: TextStyle(
                  color: Color(0xFFEDEEF5),
                  fontSize: 11.5,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 4.0,
              ),
              decoration: BoxDecoration(
                color: const Color(0x33FFFFFF),
                borderRadius: BorderRadius.circular(999.0),
              ),
              child: const Text(
                'app_bar_theme.dart',
                style: TextStyle(
                  color: Color(0xFFEDEEF5),
                  fontSize: 11.5,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        const Text(
          'AppBarTheme',
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 30.0,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.6,
          ),
        ),
        const SizedBox(height: 8.0),
        const Text(
          'The Material-3 AppBar theming surface, field-by-field. Defaults, '
          'overrides, the tonal-elevation overlay, and how SliverAppBar bends '
          'the same rules - all in one static gallery.',
          style: TextStyle(
            color: Color(0xFFE0E1F4),
            fontSize: 14.5,
            height: 1.45,
          ),
        ),
        const SizedBox(height: 16.0),
        Row(
          children: <Widget>[
            _pill('backgroundColor', colour: const Color(0xFFFDE68A)),
            const SizedBox(width: 8.0),
            _pill('elevation', colour: const Color(0xFF93C5FD)),
            const SizedBox(width: 8.0),
            _pill('surfaceTintColor', colour: const Color(0xFFA7F3D0)),
            const SizedBox(width: 8.0),
            _pill('shape', colour: const Color(0xFFFBCFE8)),
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
        _cardTitle(
          'What is AppBarTheme?',
          subtitle:
              'An immutable bundle of nullable defaults consumed by AppBar '
              'and SliverAppBar. Each field falls back through the local '
              'theme, then ThemeData.appBarTheme, then framework defaults.',
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: _kAccentSoft,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: _kAccent.withOpacity(0.25)),
          ),
          child: const Text(
            'Resolution order inside AppBar.build: widget property -> '
            'Theme.of(context).appBarTheme.<field> -> M3 defaults from '
            '_AppBarDefaultsM3 (or _AppBarDefaultsM2 when useMaterial3 is '
            'false). Because every field is nullable, AppBarTheme is a '
            'pure override layer.',
            style: TextStyle(
              fontSize: 13.5,
              height: 1.5,
              color: _kInk,
            ),
          ),
        ),
        const SizedBox(height: 14.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: _bulletList(const <String>[
                'Defined in package:flutter/src/material/app_bar_theme.dart.',
                'Immutable; mutate via copyWith(...) and reassign.',
                'Reached at runtime via Theme.of(context).appBarTheme.',
                'Consumed by AppBar and SliverAppBar identically.',
                'M3 default elevation is 0; M2 default is 4.',
              ]),
            ),
            const SizedBox(width: 14.0),
            Expanded(
              child: _bulletList(
                const <String>[
                  'surfaceTintColor is M3-only; ignored when useMaterial3 is false.',
                  'systemOverlayStyle controls Android status-bar icon colour.',
                  'centerTitle defaults to true on iOS, false on other platforms.',
                  'toolbarHeight gates the AppBar preferredSize.',
                  'shape lets you round bottom corners; respected by both bars.',
                ],
                colour: _kAccentTeal,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 2 - ANATOMY TABLE
// ---------------------------------------------------------------------------

class _AnatomyRow {
  const _AnatomyRow(
    this.field,
    this.type,
    this.m3Default,
    this.purpose, {
    this.tint = _kAccent,
  });
  final String field;
  final String type;
  final String m3Default;
  final String purpose;
  final Color tint;
}

const List<_AnatomyRow> _kAnatomy = <_AnatomyRow>[
  _AnatomyRow('backgroundColor', 'Color?', 'ColorScheme.surface',
      'Solid fill behind the toolbar.'),
  _AnatomyRow('foregroundColor', 'Color?', 'ColorScheme.onSurface',
      'Default colour for title, icons, leading widget.',
      tint: _kAccentBlue),
  _AnatomyRow('elevation', 'double?', '0.0 (M3)',
      'Drop-shadow depth (Material 2 behaviour).',
      tint: _kAccentTeal),
  _AnatomyRow('scrolledUnderElevation', 'double?', '3.0',
      'Replacement elevation once content scrolls under the bar.',
      tint: _kAccentGreen),
  _AnatomyRow('shadowColor', 'Color?', 'Colors.black',
      'Colour of the drop shadow when elevation > 0.',
      tint: _kAccentAmber),
  _AnatomyRow('surfaceTintColor', 'Color?', 'ColorScheme.surfaceTint',
      'M3 tonal overlay tint composed over backgroundColor.',
      tint: _kAccentRose),
  _AnatomyRow('shape', 'ShapeBorder?', 'null',
      'Bottom edge shape (e.g. rounded corners, beveled).',
      tint: _kAccentViolet),
  _AnatomyRow('iconTheme', 'IconThemeData?', 'IconThemeData(size: 24)',
      'Icon size/colour used by leading and inferred actions.'),
  _AnatomyRow('actionsIconTheme', 'IconThemeData?', 'iconTheme fallback',
      'Overrides iconTheme just for the trailing actions slot.',
      tint: _kAccentBlue),
  _AnatomyRow('centerTitle', 'bool?', 'platform-dependent',
      'true centres the title; iOS defaults to true, others false.',
      tint: _kAccentTeal),
  _AnatomyRow('titleSpacing', 'double?', 'NavigationToolbar.kMiddleSpacing',
      'Horizontal gap between leading and title widgets.',
      tint: _kAccentGreen),
  _AnatomyRow('toolbarHeight', 'double?', 'kToolbarHeight (56)',
      'Total vertical extent reserved for the toolbar row.',
      tint: _kAccentAmber),
  _AnatomyRow('titleTextStyle', 'TextStyle?', 'TextTheme.titleLarge',
      'Default text style applied to the title widget.',
      tint: _kAccentRose),
  _AnatomyRow('toolbarTextStyle', 'TextStyle?', 'TextTheme.bodyMedium',
      'Default text style for non-title text in the toolbar.',
      tint: _kAccentViolet),
  _AnatomyRow('systemOverlayStyle', 'SystemUiOverlayStyle?', 'derived',
      'Android status-bar icon colour and contrast.'),
];

Widget _anatomyTable() {
  final List<Widget> rows = <Widget>[];
  rows.add(
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
      decoration: const BoxDecoration(
        color: _kCardSoft,
        border: Border(bottom: BorderSide(color: _kHairline)),
      ),
      child: Row(
        children: const <Widget>[
          SizedBox(
            width: 180.0,
            child: Text('Field',
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w700,
                  color: _kInkSecondary,
                )),
          ),
          SizedBox(
            width: 150.0,
            child: Text('Type',
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w700,
                  color: _kInkSecondary,
                )),
          ),
          SizedBox(
            width: 180.0,
            child: Text('M3 default',
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w700,
                  color: _kInkSecondary,
                )),
          ),
          Expanded(
            child: Text('Purpose',
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w700,
                  color: _kInkSecondary,
                )),
          ),
        ],
      ),
    ),
  );

  for (int i = 0; i < _kAnatomy.length; i++) {
    final _AnatomyRow row = _kAnatomy[i];
    final bool alt = i.isOdd;
    rows.add(
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 9.0),
        decoration: BoxDecoration(
          color: alt ? _kCardSoft : _kCardBg,
          border: const Border(bottom: BorderSide(color: _kHairline)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 180.0,
              child: Row(
                children: <Widget>[
                  Container(
                    width: 6.0,
                    height: 6.0,
                    margin: const EdgeInsets.only(right: 8.0),
                    decoration: BoxDecoration(
                      color: row.tint,
                      borderRadius: BorderRadius.circular(2.0),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      row.field,
                      style: const TextStyle(
                        fontSize: 12.5,
                        fontFamily: 'monospace',
                        color: _kInk,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 150.0,
              child: Text(
                row.type,
                style: const TextStyle(
                  fontSize: 12.0,
                  fontFamily: 'monospace',
                  color: _kInkSecondary,
                ),
              ),
            ),
            SizedBox(
              width: 180.0,
              child: Text(
                row.m3Default,
                style: const TextStyle(
                  fontSize: 12.0,
                  fontFamily: 'monospace',
                  color: _kInkSecondary,
                ),
              ),
            ),
            Expanded(
              child: Text(row.purpose, style: _kBodySoftStyle),
            ),
          ],
        ),
      ),
    );
  }

  return _card(
    padding: EdgeInsets.zero,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: rows,
      ),
    ),
  );
}

Widget _anatomySection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _cardTitle('Every field in one table',
                subtitle:
                    'Fifteen nullable fields. Each one is "if non-null, win".'),
            const SizedBox(height: 10.0),
            Text(
              'Reading the table: when AppBar resolves a property, it asks '
              'its widget-level value first, then this AppBarTheme, then the '
              'M3 defaults. A field set to null on AppBarTheme means '
              '"fall through to the defaults table".',
              style: _kBodySoftStyle,
            ),
          ],
        ),
      ),
      _anatomyTable(),
    ],
  );
}

// ---------------------------------------------------------------------------
// SECTION 3 - LIGHT vs DARK SIDE-BY-SIDE
// ---------------------------------------------------------------------------

Widget _mockAppBar({
  required Color background,
  required Color foreground,
  required Color shadow,
  required Color tint,
  required double elevation,
  required double tintOpacity,
  required String title,
  required bool centerTitle,
  required bool showBack,
  double height = 56.0,
}) {
  final List<BoxShadow> shadows = <BoxShadow>[
    if (elevation > 0.0)
      BoxShadow(
        color: shadow,
        offset: Offset(0.0, elevation * 0.5),
        blurRadius: elevation * 1.5,
      ),
  ];
  final List<Widget> rowChildren = <Widget>[];
  if (showBack) {
    rowChildren.add(
      Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: Icon(Icons.arrow_back, color: foreground, size: 22.0),
      ),
    );
  } else {
    rowChildren.add(const SizedBox(width: 16.0));
  }
  rowChildren.add(
    Expanded(
      child: Align(
        alignment: centerTitle ? Alignment.center : Alignment.centerLeft,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
            color: foreground,
            letterSpacing: -0.2,
          ),
        ),
      ),
    ),
  );
  rowChildren.add(
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: Icon(Icons.search, color: foreground, size: 22.0),
    ),
  );
  rowChildren.add(
    Padding(
      padding: const EdgeInsets.only(right: 12.0, left: 6.0),
      child: Icon(Icons.more_vert, color: foreground, size: 22.0),
    ),
  );
  return Container(
    height: height,
    decoration: BoxDecoration(
      color: background,
      boxShadow: shadows,
    ),
    child: Stack(
      children: <Widget>[
        if (tintOpacity > 0.0)
          Positioned.fill(
            child: Container(
              color: tint.withOpacity(tintOpacity),
            ),
          ),
        Row(children: rowChildren),
      ],
    ),
  );
}

Widget _themedPreviewColumn({
  required String label,
  required Color canvas,
  required Color barBg,
  required Color barFg,
  required Color barShadow,
  required Color barTint,
  required bool isDark,
}) {
  return Expanded(
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      decoration: BoxDecoration(
        color: canvas,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: isDark ? _kHairlineDark : _kHairline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w700,
                    color: isDark ? _kInkOnDark : _kInk,
                    letterSpacing: 0.4,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 6.0, vertical: 2.0),
                  decoration: BoxDecoration(
                    color: (isDark ? _kInkOnDark : _kInk).withOpacity(0.08),
                    borderRadius: BorderRadius.circular(999.0),
                  ),
                  child: Text(
                    isDark ? 'dark' : 'light',
                    style: TextStyle(
                      fontSize: 10.0,
                      fontFamily: 'monospace',
                      color: isDark ? _kInkOnDark : _kInk,
                    ),
                  ),
                ),
              ],
            ),
          ),
          _mockAppBar(
            background: barBg,
            foreground: barFg,
            shadow: barShadow,
            tint: barTint,
            elevation: 0.0,
            tintOpacity: 0.0,
            title: 'Inbox',
            centerTitle: false,
            showBack: true,
          ),
          const SizedBox(height: 12.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'backgroundColor',
                  style: TextStyle(
                    fontSize: 10.5,
                    color: isDark ? _kInkOnDarkSecondary : _kInkTertiary,
                    fontFamily: 'monospace',
                  ),
                ),
                Text(
                  '#${barBg.value.toRadixString(16).padLeft(8, '0').toUpperCase()}',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: isDark ? _kInkOnDark : _kInk,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6.0),
                Text(
                  'foregroundColor',
                  style: TextStyle(
                    fontSize: 10.5,
                    color: isDark ? _kInkOnDarkSecondary : _kInkTertiary,
                    fontFamily: 'monospace',
                  ),
                ),
                Text(
                  '#${barFg.value.toRadixString(16).padLeft(8, '0').toUpperCase()}',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: isDark ? _kInkOnDark : _kInk,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14.0),
        ],
      ),
    ),
  );
}

Widget _lightVsDarkSection() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle('Light vs Dark, identical widget tree',
            subtitle:
                'Same AppBar(title: Text("Inbox")). Only ThemeData seed differs.'),
        const SizedBox(height: 14.0),
        SizedBox(
          height: 220.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _themedPreviewColumn(
                label: 'LIGHT THEME',
                canvas: const Color(0xFFF4F5F8),
                barBg: _kLightAppBarBg,
                barFg: _kLightAppBarFg,
                barShadow: _kLightAppBarShadow,
                barTint: _kLightAppBarTint,
                isDark: false,
              ),
              _themedPreviewColumn(
                label: 'DARK THEME',
                canvas: const Color(0xFF11131C),
                barBg: _kDarkAppBarBg,
                barFg: _kDarkAppBarFg,
                barShadow: _kDarkAppBarShadow,
                barTint: _kDarkAppBarTint,
                isDark: true,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: _kCardSoft,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'Note that nothing about the widget tree changed. Light/dark is '
            'a pure theming decision driven by ColorScheme.surface and '
            'ColorScheme.onSurface flowing through AppBarTheme defaults.',
            style: _kBodySoftStyle,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 4 - scrolledUnderElevation
// ---------------------------------------------------------------------------

class _ScrollState {
  const _ScrollState(this.label, this.elevation, this.tintOpacity, this.caption);
  final String label;
  final double elevation;
  final double tintOpacity;
  final String caption;
}

const List<_ScrollState> _kScrollStates = <_ScrollState>[
  _ScrollState('At rest', 0.0, 0.0,
      'No content under bar. elevation = AppBarTheme.elevation (0 in M3).'),
  _ScrollState(
      'Scrolled under',
      3.0,
      0.08,
      'NestedScrollView reports scrolledUnder=true; switches to '
          'scrolledUnderElevation and applies surfaceTint overlay.'),
  _ScrollState('Max scroll', 3.0, 0.14,
      'Tint clamps but does not strengthen beyond the M3 elevation curve.'),
];

Widget _scrolledUnderCard(_ScrollState state, int index) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 4.0),
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: _kCardSoft,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _kHairline),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 24.0,
              height: 24.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: _kAccent.withOpacity(0.15),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text(
                '${index + 1}',
                style: const TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w700,
                  color: _kAccent,
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            Text(
              state.label,
              style: const TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w700,
                color: _kInk,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        _mockAppBar(
          background: _kLightAppBarBg,
          foreground: _kLightAppBarFg,
          shadow: _kLightAppBarShadow,
          tint: _kSeedPrimary,
          elevation: state.elevation,
          tintOpacity: state.tintOpacity,
          title: 'Inbox',
          centerTitle: false,
          showBack: true,
        ),
        const SizedBox(height: 8.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: const Color(0xFFEEF2FF),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            'elevation=${state.elevation.toStringAsFixed(1)}  '
            'tint=${(state.tintOpacity * 100).toStringAsFixed(0)}%',
            style: const TextStyle(
              fontSize: 10.5,
              fontFamily: 'monospace',
              color: _kAccent,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        Text(state.caption,
            style: const TextStyle(
              fontSize: 11.5,
              color: _kInkSecondary,
              height: 1.4,
            )),
      ],
    ),
  );
}

Widget _scrolledUnderSection() {
  final List<Widget> cards = <Widget>[];
  for (int i = 0; i < _kScrollStates.length; i++) {
    cards.add(Expanded(child: _scrolledUnderCard(_kScrollStates[i], i)));
  }
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle('scrolledUnderElevation in three frames',
            subtitle:
                'The M3 AppBar swaps elevation when content scrolls under it.'),
        const SizedBox(height: 14.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: cards,
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFBEB),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: const Color(0xFFFDE68A)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Icon(Icons.bolt, color: _kAccentAmber, size: 18.0),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'AppBar listens to its nearest Scrollable. Without one '
                  '(e.g. inside a CustomScrollView slot the bar reports as '
                  'NOT scrolled), scrolledUnderElevation never engages.',
                  style: _kBodySoftStyle,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 5 - SliverAppBar state diagram
// ---------------------------------------------------------------------------

class _SliverMode {
  const _SliverMode(this.flags, this.label, this.behaviour, this.colour);
  final String flags;
  final String label;
  final String behaviour;
  final Color colour;
}

const List<_SliverMode> _kSliverModes = <_SliverMode>[
  _SliverMode('pinned: false\nfloating: false', 'Default',
      'Scrolls completely off as you scroll down.', _kInkTertiary),
  _SliverMode('pinned: true', 'Pinned',
      'Sticks at top once collapsed to its toolbarHeight.', _kAccent),
  _SliverMode('floating: true', 'Floating',
      'Reappears immediately on any upward scroll gesture.', _kAccentTeal),
  _SliverMode(
      'floating: true\nsnap: true',
      'Floating+Snap',
      'Snaps fully open on any upward scroll; snaps closed downward.',
      _kAccentGreen),
  _SliverMode(
      'pinned: true\nfloating: true\nsnap: true',
      'Pinned+Floating',
      'Always visible at minExtent; expands on upward scroll.',
      _kAccentViolet),
];

Widget _sliverModeCard(_SliverMode mode) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: _kCardBg,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: mode.colour.withOpacity(0.4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 8.0,
              height: 8.0,
              decoration: BoxDecoration(
                color: mode.colour,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8.0),
            Text(mode.label,
                style: const TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w700,
                  color: _kInk,
                )),
          ],
        ),
        const SizedBox(height: 8.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: mode.colour.withOpacity(0.08),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            mode.flags,
            style: TextStyle(
              fontSize: 10.5,
              fontFamily: 'monospace',
              color: mode.colour,
              height: 1.3,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        Text(mode.behaviour, style: _kBodySoftStyle),
      ],
    ),
  );
}

Widget _sliverFrame(String tag, String state, double barHeight) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Row(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
            decoration: BoxDecoration(
              color: _kAccent.withOpacity(0.12),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(tag,
                style: const TextStyle(
                  fontSize: 10.0,
                  fontFamily: 'monospace',
                  color: _kAccent,
                  fontWeight: FontWeight.w600,
                )),
          ),
          const SizedBox(width: 6.0),
          Expanded(
            child: Text(
              state,
              style: const TextStyle(
                fontSize: 10.5,
                color: _kInkSecondary,
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 6.0),
      Container(
        height: 180.0,
        decoration: BoxDecoration(
          color: _kCardBg,
          border: Border.all(color: _kHairline),
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Column(
          children: <Widget>[
            Container(
              height: barHeight,
              decoration: BoxDecoration(
                color: _kAccent.withOpacity(0.85),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(6.0),
                ),
              ),
              alignment: Alignment.bottomLeft,
              padding: const EdgeInsets.all(8.0),
              child: const Text(
                'SliverAppBar',
                style: TextStyle(
                  fontSize: 11.0,
                  color: Color(0xFFFFFFFF),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 4.0),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.0),
              child: Text('list item',
                  style: TextStyle(fontSize: 10.0, color: _kInkSecondary)),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.0),
              child: Text('list item',
                  style: TextStyle(fontSize: 10.0, color: _kInkSecondary)),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.0),
              child: Text('list item',
                  style: TextStyle(fontSize: 10.0, color: _kInkSecondary)),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _sliverDiagramTrack() {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6.0),
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: _kCardSoft,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: _kHairline),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(child: _sliverFrame('t=0', 'expandedHeight', 130.0)),
        const SizedBox(width: 8.0),
        Expanded(child: _sliverFrame('t=mid', 'collapsing', 80.0)),
        const SizedBox(width: 8.0),
        Expanded(
            child: _sliverFrame('t=max', 'toolbarHeight (pinned)', 40.0)),
      ],
    ),
  );
}

Widget _sliverSection() {
  final List<Widget> cards = <Widget>[];
  for (int i = 0; i < _kSliverModes.length; i++) {
    cards.add(SizedBox(width: 320.0, child: _sliverModeCard(_kSliverModes[i])));
  }
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle('SliverAppBar: pinned, floating, snap',
            subtitle:
                'A SliverAppBar reads AppBarTheme but adds scroll-driven '
                'extent rules absent from AppBar.'),
        const SizedBox(height: 14.0),
        _sliverDiagramTrack(),
        const SizedBox(height: 12.0),
        Wrap(
          spacing: 0.0,
          runSpacing: 0.0,
          children: cards,
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 6 - surfaceTintColor explanation
// ---------------------------------------------------------------------------

Color _composite(Color background, Color overlay, double opacity) {
  return Color.alphaBlend(overlay.withOpacity(opacity), background);
}

Widget _tintLayer(String label, Color colour, double opacity, String desc) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 50.0,
          height: 30.0,
          decoration: BoxDecoration(
            color: colour.withOpacity(opacity),
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(color: _kHairline),
          ),
        ),
        const SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(label,
                  style: const TextStyle(
                    fontSize: 11.5,
                    fontFamily: 'monospace',
                    color: _kInk,
                    fontWeight: FontWeight.w600,
                  )),
              Text(desc,
                  style: const TextStyle(
                    fontSize: 11.0,
                    color: _kInkSecondary,
                    height: 1.3,
                  )),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _surfaceTintSection() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle('surfaceTintColor: the M3 tonal overlay',
            subtitle:
                'How Material 3 simulates elevation without a drop shadow.'),
        const SizedBox(height: 14.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _tintLayer('1. backgroundColor', _kLightAppBarBg, 1.0,
                      'ColorScheme.surface (e.g. #FFFFFFFF).'),
                  _tintLayer(
                      '2. surfaceTintColor @ opacity(elevation)',
                      _kSeedPrimary,
                      0.08,
                      'Opacity rises with effective elevation per M3 curve.'),
                  _tintLayer(
                      '3. = composited toolbar fill',
                      _composite(_kLightAppBarBg, _kSeedPrimary, 0.08),
                      1.0,
                      'What AppBar actually paints behind your icons.'),
                ],
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              flex: 4,
              child: Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: _kCardSoft,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Why it exists',
                      style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w700,
                        color: _kInk,
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    Text(
                      'M3 replaces drop shadows with subtle tonal shifts of '
                      'the surface itself. The deeper the perceived elevation, '
                      'the more of surfaceTintColor is composited over '
                      'backgroundColor. AppBar uses this only when '
                      'scrolledUnder reports true.',
                      style: _kBodySoftStyle,
                    ),
                    const SizedBox(height: 10.0),
                    const Text(
                      'Compose formula',
                      style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w700,
                        color: _kInk,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: _kCodeBg,
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: const Text(
                        'final = Color.alphaBlend(\n'
                        '  surfaceTintColor.withOpacity(\n'
                        '    M3.elevationOpacity(elevation)\n'
                        '  ),\n'
                        '  backgroundColor,\n'
                        ');',
                        style: _kCodeStyle,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      'M3.elevationOpacity(3.0) is roughly 0.08. '
                      'Set surfaceTintColor: Colors.transparent to opt out.',
                      style: _kBodySoftStyle,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 7 - AppBar vs SliverAppBar comparison
// ---------------------------------------------------------------------------

class _CompareRow {
  const _CompareRow(this.axis, this.appBar, this.sliverAppBar);
  final String axis;
  final String appBar;
  final String sliverAppBar;
}

const List<_CompareRow> _kCompare = <_CompareRow>[
  _CompareRow('Widget kind', 'StatefulWidget (RenderObjectWidget tree)',
      'RenderObjectWidget that produces a RenderSliver.'),
  _CompareRow('Mount point', 'Scaffold.appBar or any PreferredSizeWidget slot',
      'CustomScrollView.slivers list.'),
  _CompareRow('Reads AppBarTheme', 'Yes - every field.',
      'Yes - the same field set.'),
  _CompareRow('Scroll coupling', 'Listens via NotificationListener.',
      'Native: receives SliverConstraints directly.'),
  _CompareRow('Supports expandedHeight', 'No - fixed toolbarHeight.',
      'Yes - expandedHeight + flexibleSpace.'),
  _CompareRow('Supports pinned/floating', 'No.', 'Yes (the whole point).'),
  _CompareRow('Stretch on overscroll', 'No.',
      'Yes via stretch: true and onStretchTrigger.'),
  _CompareRow('Owns FlexibleSpaceBar parallax', 'No.',
      'Yes - the parallax is sliver-coordinate driven.'),
  _CompareRow('scrolledUnder evaluation',
      'Inferred from nearest Scrollable.',
      'Computed from SliverConstraints.scrollOffset.'),
  _CompareRow('Preferred for tabs?', 'Yes - bottom: TabBar always docked.',
      'Only with pinned: true; otherwise tabs scroll away.'),
];

Widget _comparisonSection() {
  final List<Widget> rows = <Widget>[];
  rows.add(
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
      decoration: const BoxDecoration(
        color: _kCardSoft,
        border: Border(bottom: BorderSide(color: _kHairline)),
      ),
      child: Row(
        children: const <Widget>[
          SizedBox(
            width: 220.0,
            child: Text('Axis',
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w700,
                  color: _kInkSecondary,
                )),
          ),
          Expanded(
            child: Text('AppBar',
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w700,
                  color: _kAccent,
                )),
          ),
          Expanded(
            child: Text('SliverAppBar',
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w700,
                  color: _kAccentTeal,
                )),
          ),
        ],
      ),
    ),
  );
  for (int i = 0; i < _kCompare.length; i++) {
    final _CompareRow row = _kCompare[i];
    final bool alt = i.isOdd;
    rows.add(
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 9.0),
        decoration: BoxDecoration(
          color: alt ? _kCardSoft : _kCardBg,
          border: const Border(bottom: BorderSide(color: _kHairline)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 220.0,
              child: Text(row.axis,
                  style: const TextStyle(
                    fontSize: 12.5,
                    color: _kInk,
                    fontWeight: FontWeight.w600,
                  )),
            ),
            Expanded(child: Text(row.appBar, style: _kBodySoftStyle)),
            Expanded(child: Text(row.sliverAppBar, style: _kBodySoftStyle)),
          ],
        ),
      ),
    );
  }
  return _card(
    padding: EdgeInsets.zero,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: rows,
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 8 - Code recipes
// ---------------------------------------------------------------------------

Widget _codeRecipesSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _codeBlock(
        title: 'recipe-01-full-theme.dart',
        '// Override every AppBar across the app via ThemeData.\n'
            'ThemeData(\n'
            '  useMaterial3: true,\n'
            '  appBarTheme: const AppBarTheme(\n'
            '    backgroundColor: Color(0xFFFFFFFF),\n'
            '    foregroundColor: Color(0xFF1A1C25),\n'
            '    elevation: 0.0,\n'
            '    scrolledUnderElevation: 3.0,\n'
            '    centerTitle: false,\n'
            '    titleTextStyle: TextStyle(\n'
            '      fontSize: 18.0,\n'
            '      fontWeight: FontWeight.w600,\n'
            '      color: Color(0xFF1A1C25),\n'
            '    ),\n'
            '  ),\n'
            ');',
      ),
      _codeBlock(
        title: 'recipe-02-single-field.dart',
        '// Tweak just one field by reusing the existing theme.\n'
            'theme.copyWith(\n'
            '  appBarTheme: theme.appBarTheme.copyWith(\n'
            '    scrolledUnderElevation: 6.0,\n'
            '  ),\n'
            ');',
      ),
      _codeBlock(
        title: 'recipe-03-dark-variant.dart',
        '// Pair with darkTheme so AppBar follows MediaQuery.platformBrightness.\n'
            'MaterialApp(\n'
            '  theme: lightTheme.copyWith(\n'
            '    appBarTheme: const AppBarTheme(\n'
            '      backgroundColor: Color(0xFFFFFFFF),\n'
            '      foregroundColor: Color(0xFF1A1C25),\n'
            '    ),\n'
            '  ),\n'
            '  darkTheme: darkTheme.copyWith(\n'
            '    appBarTheme: const AppBarTheme(\n'
            '      backgroundColor: Color(0xFF1B1D2A),\n'
            '      foregroundColor: Color(0xFFEDEEF5),\n'
            '    ),\n'
            '  ),\n'
            ');',
      ),
      _codeBlock(
        title: 'recipe-04-m2-fallback.dart',
        '// useMaterial3: false reverts to Material 2 defaults; surfaceTint\n'
            '// is ignored and elevation defaults back to 4.0.\n'
            'ThemeData(\n'
            '  useMaterial3: false,\n'
            '  appBarTheme: const AppBarTheme(\n'
            '    elevation: 4.0,\n'
            '    shadowColor: Color(0xFF000000),\n'
            '  ),\n'
            ');',
      ),
      _codeBlock(
        title: 'recipe-05-per-route-override.dart',
        '// Override AppBarTheme for a single route via Theme(...).\n'
            'Theme(\n'
            '  data: Theme.of(context).copyWith(\n'
            '    appBarTheme: const AppBarTheme(\n'
            '      backgroundColor: Color(0xFF312E81),\n'
            '      foregroundColor: Color(0xFFFFFFFF),\n'
            '    ),\n'
            '  ),\n'
            '  child: Scaffold(\n'
            '    appBar: AppBar(title: const Text("Settings")),\n'
            '    body: const _SettingsBody(),\n'
            '  ),\n'
            ');',
      ),
      _codeBlock(
        title: 'recipe-06-shape-and-tint.dart',
        '// Rounded bottom corners + opt out of M3 tint.\n'
            'AppBarTheme(\n'
            '  shape: const RoundedRectangleBorder(\n'
            '    borderRadius: BorderRadius.vertical(\n'
            '      bottom: Radius.circular(20.0),\n'
            '    ),\n'
            '  ),\n'
            '  surfaceTintColor: Colors.transparent,\n'
            '  scrolledUnderElevation: 0.0,\n'
            ');',
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// SECTION 9 - Pitfalls
// ---------------------------------------------------------------------------

class _Pitfall {
  const _Pitfall(this.title, this.body, this.colour);
  final String title;
  final String body;
  final Color colour;
}

const List<_Pitfall> _kPitfalls = <_Pitfall>[
  _Pitfall(
    'Implicit defaults differ between M2 and M3',
    'Switching useMaterial3 flips elevation from 4 to 0 and adds the '
        'surfaceTint overlay. Forgetting this is the #1 reason apps look '
        '"flat" after upgrade.',
    _kAccentRose,
  ),
  _Pitfall(
    'centerTitle is platform-dependent by default',
    'On iOS the title centres; on Android/Linux it left-aligns. Always '
        'pass centerTitle explicitly if you want consistency across platforms.',
    _kAccentAmber,
  ),
  _Pitfall(
    'Back button visibility is automatic, not theme-controlled',
    'AppBar.automaticallyImplyLeading drives it, not AppBarTheme. There is '
        'no "showBack" field on the theme.',
    _kAccent,
  ),
  _Pitfall(
    'systemOverlayStyle only applies on Android',
    'On iOS the status-bar style comes from the UIKit hosting view; '
        'setting AppBarTheme.systemOverlayStyle is silently ignored.',
    _kAccentBlue,
  ),
  _Pitfall(
    'scrolledUnderElevation needs a nearby Scrollable',
    'AppBar finds its scroll source via NotificationListener. Inside a '
        'CustomScrollView, SliverAppBar wins; AppBar alone may never see '
        'the scroll updates.',
    _kAccentViolet,
  ),
  _Pitfall(
    'surfaceTintColor stacks with backgroundColor',
    'Setting backgroundColor alone does NOT remove the M3 tint when the '
        'bar is scrolled under. You must also set surfaceTintColor to '
        'Colors.transparent or zero out scrolledUnderElevation.',
    _kAccentTeal,
  ),
  _Pitfall(
    'iconTheme does not flow into TabBar.indicator colour',
    'TabBarTheme.indicatorColor is its own slot. AppBarTheme.iconTheme '
        'only feeds the leading icon and the actions if actionsIconTheme is '
        'null.',
    _kAccentGreen,
  ),
  _Pitfall(
    'toolbarHeight changes preferredSize, not visual height',
    'If you raise toolbarHeight without also adjusting padding inside '
        'flexibleSpace, the extra height is empty space, not extra title '
        'room.',
    _kAccentRose,
  ),
];

Widget _pitfallsSection() {
  final List<Widget> cards = <Widget>[];
  for (int i = 0; i < _kPitfalls.length; i++) {
    final _Pitfall p = _kPitfalls[i];
    cards.add(
      SizedBox(
        width: 360.0,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 6.0),
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: _kCardBg,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: p.colour.withOpacity(0.4)),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Color(0x0A000000),
                offset: Offset(0.0, 1.0),
                blurRadius: 2.0,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 26.0,
                    height: 26.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: p.colour.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Icon(Icons.warning_amber_rounded,
                        size: 16.0, color: p.colour),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: Text(
                      p.title,
                      style: const TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w700,
                        color: _kInk,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Text(p.body, style: _kBodySoftStyle),
            ],
          ),
        ),
      ),
    );
  }
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _cardTitle('Eight commonly missed details',
            subtitle:
                'Defaults that bite when you migrate between M2 and M3 or '
                'switch between AppBar and SliverAppBar.'),
        const SizedBox(height: 10.0),
        Wrap(
          spacing: 0.0,
          runSpacing: 0.0,
          children: cards,
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 10 - Cheat-sheet footer
// ---------------------------------------------------------------------------

Widget _cheatSheetFooter() {
  const List<String> fields = <String>[
    'backgroundColor',
    'foregroundColor',
    'elevation',
    'scrolledUnderElevation',
    'shadowColor',
    'surfaceTintColor',
    'shape',
    'iconTheme',
    'actionsIconTheme',
    'centerTitle',
    'titleSpacing',
    'toolbarHeight',
    'titleTextStyle',
    'toolbarTextStyle',
    'systemOverlayStyle',
  ];
  const List<String> consumers = <String>[
    'AppBar',
    'SliverAppBar',
    'NestedScrollView',
    'Scaffold.appBar',
    'CustomScrollView.slivers',
    'PreferredSize',
  ];
  final List<Widget> fieldChips = <Widget>[];
  for (int i = 0; i < fields.length; i++) {
    fieldChips.add(
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        decoration: BoxDecoration(
          color: const Color(0x33FFFFFF),
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Text(
          fields[i],
          style: const TextStyle(
            color: _kInkOnDark,
            fontFamily: 'monospace',
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
  final List<Widget> consumerChips = <Widget>[];
  for (int i = 0; i < consumers.length; i++) {
    consumerChips.add(
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        decoration: BoxDecoration(
          color: _kAccent.withOpacity(0.35),
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Text(
          consumers[i],
          style: const TextStyle(
            color: _kInkOnDark,
            fontFamily: 'monospace',
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
  return _card(
    background: _kCardDark,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'AppBarTheme cheat-sheet',
          style: TextStyle(
            color: _kInkOnDark,
            fontSize: 16.0,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.2,
          ),
        ),
        const SizedBox(height: 4.0),
        const Text(
          'Fields & consumers, in one compact map.',
          style: TextStyle(
            color: _kInkOnDarkSecondary,
            fontSize: 12.5,
          ),
        ),
        const SizedBox(height: 14.0),
        const Text(
          'Fields',
          style: TextStyle(
            color: _kInkOnDarkSecondary,
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.6,
          ),
        ),
        const SizedBox(height: 6.0),
        Wrap(spacing: 6.0, runSpacing: 6.0, children: fieldChips),
        const SizedBox(height: 14.0),
        const Text(
          'Consumers',
          style: TextStyle(
            color: _kInkOnDarkSecondary,
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.6,
          ),
        ),
        const SizedBox(height: 6.0),
        Wrap(spacing: 6.0, runSpacing: 6.0, children: consumerChips),
        const SizedBox(height: 16.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: const Color(0x22FFFFFF),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: const Text(
            'Mnemonic: "colour + shadow + shape + typography + system". '
            'Five families, fifteen fields - every one nullable, every one '
            'overridden in resolution order: widget > AppBarTheme > defaults.',
            style: TextStyle(
              color: _kInkOnDark,
              fontSize: 12.5,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// ENTRY POINT
// ---------------------------------------------------------------------------
dynamic build(BuildContext context) {
  print('AppBarTheme deep visual demo: building widget tree');

  // Inert AppBarTheme constructed at build-time so we can read a
  // few field defaults into local variables. These are not attached to any
  // MaterialApp; we only use them for diagnostic prints.
  const AppBarTheme demoTheme = AppBarTheme(
    backgroundColor: _kLightAppBarBg,
    foregroundColor: _kLightAppBarFg,
    elevation: 0.0,
    scrolledUnderElevation: 3.0,
    centerTitle: false,
    toolbarHeight: 56.0,
  );
  print('demoTheme.backgroundColor=${demoTheme.backgroundColor}');
  print('demoTheme.elevation=${demoTheme.elevation}');
  print('demoTheme.scrolledUnderElevation=${demoTheme.scrolledUnderElevation}');
  print('demoTheme.centerTitle=${demoTheme.centerTitle}');
  print('demoTheme.toolbarHeight=${demoTheme.toolbarHeight}');
  print('kToolbarHeight=$kToolbarHeight');
  print('kDebugMode=$kDebugMode');
  // Touch math/services/painting/widgets so unused-import warnings stay quiet
  // (the ignore_for_file pragma also covers them).
  final double sample = math.max(0.0, demoTheme.elevation ?? 0.0);
  print('sample-elevation-max=$sample');
  const SystemUiOverlayStyle overlayProbe = SystemUiOverlayStyle.dark;
  print('overlayProbe.statusBarIconBrightness='
      '${overlayProbe.statusBarIconBrightness}');
  const TextStyle paintingProbe = TextStyle(color: _kInk);
  print('paintingProbe.color=${paintingProbe.color}');
  const Widget widgetsProbe = SizedBox.shrink();
  print('widgetsProbe.runtimeType=${widgetsProbe.runtimeType}');

  return Container(
    color: _kCanvas,
    child: SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Section 1
          _heroBanner(),
          _sectionHeader(1, 'Why AppBarTheme exists',
              'A nullable override layer for every AppBar in the app.'),
          _heroIntroCard(),
          _sectionDivider(),

          // Section 2
          _sectionHeader(2, 'AppBarTheme anatomy',
              'Every field, its type, its M3 default, its purpose.'),
          _anatomySection(),
          _sectionDivider(),

          // Section 3
          _sectionHeader(3, 'Light vs Dark, same widget tree',
              'How ColorScheme drives AppBar defaults under the hood.'),
          _lightVsDarkSection(),
          _sectionDivider(),

          // Section 4
          _sectionHeader(4, 'scrolledUnderElevation',
              'The elevation tint switch as the user scrolls.'),
          _scrolledUnderSection(),
          _sectionDivider(),

          // Section 5
          _sectionHeader(5, 'SliverAppBar pinned, floating, snap',
              'How scroll-driven extent interacts with the theme.'),
          _sliverSection(),
          _sectionDivider(),

          // Section 6
          _sectionHeader(6, 'surfaceTintColor & tonal elevation',
              'How M3 simulates depth without a drop shadow.'),
          _surfaceTintSection(),
          _sectionDivider(),

          // Section 7
          _sectionHeader(7, 'AppBar vs SliverAppBar',
              'Same theme inputs, different scroll-coupling rules.'),
          _comparisonSection(),
          _sectionDivider(),

          // Section 8
          _sectionHeader(8, 'ThemeData.appBarTheme recipes',
              'Six idiomatic overrides you will reach for again.'),
          _codeRecipesSection(),
          _sectionDivider(),

          // Section 9
          _sectionHeader(9, 'Pitfalls',
              'Eight defaults that commonly trip Flutter engineers.'),
          _pitfallsSection(),
          _sectionDivider(),

          // Section 10
          _sectionHeader(10, 'Cheat-sheet',
              'Compact recap of fields, consumers, and resolution order.'),
          _cheatSheetFooter(),
        ],
      ),
    ),
  );
}
