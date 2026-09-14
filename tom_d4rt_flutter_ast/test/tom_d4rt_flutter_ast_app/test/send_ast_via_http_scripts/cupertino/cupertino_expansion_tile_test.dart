// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// =============================================================================
//                FJORD CORAL --- CupertinoExpansionTile deep dive
// =============================================================================
//
//  TARGET WIDGET .... CupertinoExpansionTile  (package:flutter/cupertino.dart)
//
//  CONTEXT .......... CupertinoExpansionTile is the iOS-flavoured cousin of
//                     Material's ExpansionTile. It collapses a region of
//                     content behind a single tappable header row, opening
//                     to reveal its child when summoned. iOS treats this
//                     as a quiet, almost cartographic gesture: the tile is
//                     a section of a settings page, the chevron is the
//                     only hint that more lives beneath, and the disclosure
//                     is accompanied by a soft, scroll-style or fade-style
//                     animation. There is no inkwell, no ripple, no shadow
//                     lift; the iOS idiom is restraint.
//
//                     This demo dramatises the SHAPE and SLOTS of the tile,
//                     not its dynamic disclosure. Because D4rt forbids
//                     stateful widgets and controllers, we cannot drive the
//                     ExpansibleController at runtime. Instead we render
//                     real CupertinoExpansionTile instances side by side
//                     with hand-drawn "collapsed-state" mocks --- small
//                     custom widgets that paint exactly what an iOS tile
//                     looks like when folded shut. The reader can therefore
//                     see, side by side, both visual forms without ever
//                     touching a setState.
//
//  CONSTRUCTOR (the actual API)
//
//      CupertinoExpansionTile({
//        Key? key,
//        required Widget title,
//        required Widget child,
//        ExpansibleController? controller,
//        ExpansionTileTransitionMode transitionMode =
//            ExpansionTileTransitionMode.fade,
//      })
//
//  PROPERTIES UNDER GLASS
//
//      title          --- The mandatory headline widget. Any Widget. iOS
//                         expects a single, quietly emphatic line; we
//                         model it with Text but occasionally compose a
//                         Row(leading-icon, Column(title, subtitle))
//                         when a leading glyph or a subtitle is wanted.
//                         Note: there is no separate `leading`, `subtitle`,
//                         or `trailing` slot --- the WHOLE header row is
//                         the title widget you pass in.
//      child          --- The single mandatory body widget revealed when
//                         the tile is expanded. To present multiple lines
//                         of content, wrap them in a Column or a custom
//                         CupertinoListSection.
//      controller     --- ExpansibleController. A handle for imperative
//                         open/close. We do NOT call any controller
//                         methods in this demo.
//      transitionMode --- ExpansionTileTransitionMode.fade (default) or
//                         ExpansionTileTransitionMode.scroll. Determines
//                         whether the child fades in/out or scrolls under
//                         the header. iOS Settings tends toward fade; iOS
//                         Files tends toward scroll.
//
//  WHAT WE DO NOT TOUCH
//
//      controller.expand()                 [no imperative drive]
//      controller.collapse()               [no imperative drive]
//      Any StatefulWidget / setState       [no live mutation]
//      Any Timer / Future / Stream         [no async]
//
//  D4RT CONSTRAINTS
//
//      * build() is invoked exactly ONCE. We return a single snapshot.
//      * No StatefulWidget, no setState, no controllers driven, no timers.
//      * No `for-in` over BridgedInstance: indexed loops only.
//      * No `.value` reads on Tween.animate: we do not animate.
//      * Use `.withValues(alpha: ...)` instead of `.withOpacity()`.
//      * Imports: package:flutter/cupertino.dart and
//                 package:flutter/material.dart.
//
//  THEME ............ FJORD CORAL
//
//                     Apple-grade design language meeting a Norwegian fjord
//                     at first light. The reader is standing on the deck of
//                     a small wooden sailboat at anchor in a glacial bay.
//                     The cliffs rise blue-grey on either side; the water
//                     is deep, glassy, and almost black. Coral-orange
//                     marker buoys bob along the shore as harbour aids.
//                     The sky is a pale glacial white, almost ice. The
//                     granite trim of the boat's gunwales is a steady,
//                     granular grey.
//
//                     Fjord-blue cliff palette dominates. Coral is the
//                     accent. Glacial-white is the background. Granite-grey
//                     is the trim. Prose is styled as a sailing-handbook:
//                     clipped, observational, with a navigator's calm.
//
//  FILE LAYOUT (visual sections)
//
//      Section  1 .... Title banner with palette swatches and harbour sigil
//      Section  2 .... Anatomy of an iOS-style expansion tile (prose)
//      Section  3 .... Property table
//      Section  4 .... Collapsed-state mock catalogue (5 hand-drawn rows)
//      Section  5 .... Expanded tile catalogue (5 real tiles)
//      Section  6 .... Nested expansion tiles
//      Section  7 .... Header-composition variants (6 tiles)
//      Section  8 .... Settings-panel mock (insetGrouped, four tiles)
//      Section  9 .... Cupertino vs Material comparison
//      Section 10 .... DO / AVOID callouts
//      Section 11 .... Recipe cards
//      Section 12 .... Glossary
//      Section 13 .... Recap footer
//
// =============================================================================

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
//  PALETTE  ---  Fjord Coral
// ---------------------------------------------------------------------------

const Color cFjordAbyss = Color(0xFF0B1A2A); // deepest fjord water
const Color cFjordDeep = Color(0xFF142A44); // mid-fjord glassy blue
const Color cFjordBlue = Color(0xFF1F4570); // cliff blue at noon
const Color cFjordSky = Color(0xFF2E5F8E); // cliff blue at dawn
const Color cFjordMist = Color(0xFF4A7BAA); // mist on the cliff face
const Color cFjordHaze = Color(0xFF7DA4C8); // haze across the bay
const Color cGlacialIce = Color(0xFFD7E2EC); // glacier shadow
const Color cGlacialWhite = Color(0xFFF4F7FA); // glacial-white background
const Color cGlacialSnow = Color(0xFFFBFCFD); // fresh glacier snow
const Color cGraniteDark = Color(0xFF3A3F46); // gunwale granite
const Color cGraniteMid = Color(0xFF5A6068); // mid granite trim
const Color cGraniteSoft = Color(0xFF8A9099); // soft granite haze
const Color cGraniteFog = Color(0xFFB8BEC6); // distant granite fog
const Color cCoral = Color(0xFFE7704A); // coral marker buoy
const Color cCoralDeep = Color(0xFFB04A28); // weathered coral
const Color cCoralLite = Color(0xFFF59A78); // sunlit coral
const Color cKelpGreen = Color(0xFF3F6E5C); // kelp on the rocks
const Color cBuoyYellow = Color(0xFFE6C46A); // harbour-aid yellow buoy

const List<List<Object>> kPalette = <List<Object>>[
  <Object>['fjordAbyss', cFjordAbyss],
  <Object>['fjordDeep', cFjordDeep],
  <Object>['fjordBlue', cFjordBlue],
  <Object>['fjordSky', cFjordSky],
  <Object>['fjordMist', cFjordMist],
  <Object>['fjordHaze', cFjordHaze],
  <Object>['glacialIce', cGlacialIce],
  <Object>['glacialWhite', cGlacialWhite],
  <Object>['glacialSnow', cGlacialSnow],
  <Object>['graniteDark', cGraniteDark],
  <Object>['graniteMid', cGraniteMid],
  <Object>['graniteSoft', cGraniteSoft],
  <Object>['graniteFog', cGraniteFog],
  <Object>['coral', cCoral],
  <Object>['coralDeep', cCoralDeep],
  <Object>['coralLite', cCoralLite],
  <Object>['kelpGreen', cKelpGreen],
  <Object>['buoyYellow', cBuoyYellow],
];

// ---------------------------------------------------------------------------
//  TEXT TOKENS
// ---------------------------------------------------------------------------

const TextStyle kTitleStyle = TextStyle(
  fontSize: 28,
  fontWeight: FontWeight.w800,
  color: cGlacialWhite,
  letterSpacing: 1.4,
);

const TextStyle kSubtitleStyle = TextStyle(
  fontSize: 14,
  fontStyle: FontStyle.italic,
  color: cGlacialIce,
  height: 1.45,
);

const TextStyle kSectionHeaderStyle = TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.w700,
  color: cFjordAbyss,
);

const TextStyle kSectionLeadStyle = TextStyle(
  fontSize: 13,
  height: 1.45,
  color: cFjordAbyss,
);

const TextStyle kBodyStyle = TextStyle(
  fontSize: 12,
  height: 1.45,
  color: cFjordDeep,
);

const TextStyle kSmallLabelStyle = TextStyle(
  fontSize: 11,
  color: cCoralDeep,
  fontWeight: FontWeight.w700,
  letterSpacing: 0.6,
);

const TextStyle kCodeStyle = TextStyle(
  fontFamily: 'monospace',
  fontSize: 12,
  color: cGlacialWhite,
  height: 1.4,
);

const TextStyle kCalloutDoStyle = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.w800,
  color: cKelpGreen,
  letterSpacing: 0.5,
);

const TextStyle kCalloutAvoidStyle = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.w800,
  color: cCoralDeep,
  letterSpacing: 0.5,
);

const TextStyle kTileTitleStyle = TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.w600,
  color: cFjordAbyss,
);

const TextStyle kTileSubStyle = TextStyle(
  fontSize: 12,
  color: cGraniteMid,
  height: 1.3,
);

const TextStyle kTileBodyStyle = TextStyle(
  fontSize: 12,
  color: cFjordDeep,
  height: 1.4,
);

const TextStyle kGlossaryTermStyle = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.w800,
  color: cFjordBlue,
  letterSpacing: 0.4,
);

const TextStyle kGlossaryDefStyle = TextStyle(
  fontSize: 12,
  color: cFjordAbyss,
  height: 1.4,
);

// ---------------------------------------------------------------------------
//  BUILD ENTRY POINT
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  print('===============================================================');
  print(' Fjord Coral --- CupertinoExpansionTile deep demo');
  print('===============================================================');
  print(' Building ONE static snapshot.');
  print(' We render 12+ distinct CupertinoExpansionTile instances.');
  print(' The actual API is title + child + controller? + transitionMode.');
  print(' We never call controller.expand/collapse: D4rt forbids it.');

  final List<Widget> sections = <Widget>[];
  sections.add(_buildTitleBanner());
  sections.add(_spacer(20));
  sections.add(_buildAnatomySection());
  sections.add(_spacer(20));
  sections.add(_buildPropertyTable());
  sections.add(_spacer(20));
  sections.add(_buildSectionHeader('4. Collapsed-state mock catalogue'));
  sections.add(_buildCollapsedCatalogue());
  sections.add(_spacer(20));
  sections.add(_buildSectionHeader('5. Expanded tile catalogue'));
  sections.add(_buildExpandedCatalogue());
  sections.add(_spacer(20));
  sections.add(_buildSectionHeader('6. Nested expansion tiles'));
  sections.add(_buildNestedTiles());
  sections.add(_spacer(20));
  sections.add(_buildSectionHeader('7. Header-composition variants'));
  sections.add(_buildHeaderVariants());
  sections.add(_spacer(20));
  sections.add(_buildSectionHeader('8. Settings-panel mock (insetGrouped)'));
  sections.add(_buildSettingsPanelMock());
  sections.add(_spacer(20));
  sections.add(_buildSectionHeader('9. Cupertino vs Material comparison'));
  sections.add(_buildCupertinoVsMaterial());
  sections.add(_spacer(20));
  sections.add(_buildSectionHeader('10. DO / AVOID callouts'));
  sections.add(_buildDoAvoidCallouts());
  sections.add(_spacer(20));
  sections.add(_buildSectionHeader('11. Recipe cards'));
  sections.add(_buildRecipeCards());
  sections.add(_spacer(20));
  sections.add(_buildSectionHeader('12. Glossary'));
  sections.add(_buildGlossary());
  sections.add(_spacer(20));
  sections.add(_buildRecapFooter());
  sections.add(_spacer(40));

  print(' Assembled ${sections.length} top-level section blocks.');
  print(' Wrapping demo in a Material Scaffold for page chrome.');
  print(' Returning the snapshot tree.');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      scaffoldBackgroundColor: cGlacialWhite,
      brightness: Brightness.light,
    ),
    home: Scaffold(
      backgroundColor: cGlacialWhite,
      body: CupertinoTheme(
        data: const CupertinoThemeData(
          brightness: Brightness.light,
          primaryColor: cCoral,
          scaffoldBackgroundColor: cGlacialWhite,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: sections,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
//  Tiny helpers
// ---------------------------------------------------------------------------

Widget _spacer(double h) => SizedBox(height: h);

Widget _buildSectionHeader(String text) {
  return Padding(
    padding: const EdgeInsets.only(top: 12, bottom: 8),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: const BoxDecoration(
        color: cGlacialSnow,
        border: Border(
          left: BorderSide(color: cCoral, width: 6),
          bottom: BorderSide(color: cGraniteFog, width: 1),
        ),
      ),
      child: Text(text, style: kSectionHeaderStyle),
    ),
  );
}

BoxDecoration _proseCardDeco() {
  return BoxDecoration(
    color: cGlacialSnow,
    borderRadius: BorderRadius.circular(10),
    border: Border.all(color: cGraniteFog, width: 1),
    boxShadow: <BoxShadow>[
      BoxShadow(
        color: cFjordAbyss.withValues(alpha: 0.10),
        blurRadius: 6,
        offset: const Offset(0, 3),
      ),
    ],
  );
}

Widget _miniIcon(IconData icon, {double size = 16, Color color = cFjordBlue}) {
  return Icon(icon, size: size, color: color);
}

// A reusable "title row" composition: leading icon + title + optional
// subtitle + optional trailing badge. Because the real API only gives
// us a single `title` Widget slot, we compose Row(leading, Column(title,
// subtitle), trailing) and pass the whole composition as `title`. This
// is the idiomatic way to add leading icons or subtitles in iOS.
Widget _composeTitle({
  IconData? leading,
  Color leadingColor = cFjordSky,
  required String title,
  String? subtitle,
  Widget? trailingBadge,
}) {
  final List<Widget> rowKids = <Widget>[];
  if (leading != null) {
    rowKids.add(_miniIcon(leading, size: 18, color: leadingColor));
    rowKids.add(const SizedBox(width: 10));
  }
  final List<Widget> textKids = <Widget>[
    Text(title, style: kTileTitleStyle),
  ];
  if (subtitle != null) {
    textKids.add(const SizedBox(height: 2));
    textKids.add(Text(subtitle, style: kTileSubStyle));
  }
  rowKids.add(
    Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: textKids,
      ),
    ),
  );
  if (trailingBadge != null) {
    rowKids.add(const SizedBox(width: 8));
    rowKids.add(trailingBadge);
  }
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: rowKids,
  );
}

// A small reusable "collapsed-state mock" --- a hand-drawn row that
// looks like a CupertinoExpansionTile in its folded form. Section 4
// uses this to show the collapsed visual without a stateful host.
Widget _collapsedMock({
  IconData? leading,
  Color leadingColor = cFjordSky,
  required String title,
  String? subtitle,
  Widget? trailing,
}) {
  final List<Widget> rowKids = <Widget>[];
  if (leading != null) {
    rowKids.add(_miniIcon(leading, size: 20, color: leadingColor));
    rowKids.add(const SizedBox(width: 12));
  }
  final List<Widget> textKids = <Widget>[
    Text(title, style: kTileTitleStyle),
  ];
  if (subtitle != null) {
    textKids.add(const SizedBox(height: 2));
    textKids.add(Text(subtitle, style: kTileSubStyle));
  }
  rowKids.add(
    Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: textKids,
      ),
    ),
  );
  rowKids.add(const SizedBox(width: 8));
  if (trailing != null) {
    rowKids.add(trailing);
  } else {
    rowKids.add(const Icon(
      CupertinoIcons.right_chevron,
      size: 14,
      color: CupertinoColors.activeBlue,
    ));
  }
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    decoration: const BoxDecoration(
      color: cGlacialSnow,
      border: Border(
        bottom: BorderSide(color: cGraniteFog, width: 0.5),
      ),
    ),
    child: Row(children: rowKids),
  );
}

// ===========================================================================
//  SECTION 1 --- Title banner with palette swatches and harbour sigil
// ===========================================================================
//  The banner is a deep fjord-blue panel with a coral underglow and a
//  granite border --- the deck of the sailboat seen from above with the
//  morning fog still lifting. A harbour sigil ("N" for north) hangs in
//  the upper right corner like a brass plaque on the helm.
// ---------------------------------------------------------------------------

Widget _buildTitleBanner() {
  print(' Building Section 1: title banner with harbour sigil.');

  final BoxDecoration bannerDeco = BoxDecoration(
    gradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[cFjordAbyss, cFjordDeep, cFjordBlue],
      stops: <double>[0.0, 0.5, 1.0],
    ),
    borderRadius: BorderRadius.circular(14),
    boxShadow: <BoxShadow>[
      BoxShadow(
        color: cCoral.withValues(alpha: 0.30),
        blurRadius: 22,
        spreadRadius: 1,
        offset: const Offset(0, 10),
      ),
    ],
    border: Border.all(color: cGraniteSoft, width: 2),
  );

  // A horizontal palette strip painted across the foot of the banner.
  // Indexed loop because for-in over BridgedInstance is forbidden.
  final List<Widget> swatches = <Widget>[];
  for (int i = 0; i < kPalette.length; i++) {
    final List<Object> entry = kPalette[i];
    final String n = entry[0] as String;
    final Color c = entry[1] as Color;
    final BoxDecoration swatchDeco = BoxDecoration(
      color: c,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: cGlacialWhite.withValues(alpha: 0.55), width: 1),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: cFjordAbyss.withValues(alpha: 0.45),
          blurRadius: 3,
          offset: const Offset(0, 2),
        ),
      ],
    );
    swatches.add(
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Column(
          children: <Widget>[
            Container(width: 36, height: 36, decoration: swatchDeco),
            const SizedBox(height: 2),
            SizedBox(
              width: 64,
              child: Text(
                n,
                style: const TextStyle(fontSize: 9, color: cGlacialIce),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // The harbour sigil: a circular medallion with a radial gradient meant
  // to evoke a brass-and-coral compass plate fixed at the cabin door.
  final Widget harbourSigil = Container(
    width: 60,
    height: 60,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      gradient: const RadialGradient(
        colors: <Color>[cCoralLite, cCoral, cCoralDeep],
        stops: <double>[0.0, 0.55, 1.0],
      ),
      border: Border.all(color: cGlacialWhite, width: 2),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: cCoral.withValues(alpha: 0.55),
          blurRadius: 10,
          spreadRadius: 1,
        ),
      ],
    ),
    child: const Center(
      child: Text(
        'N',
        style: TextStyle(
          color: cGlacialSnow,
          fontWeight: FontWeight.w900,
          fontSize: 22,
          letterSpacing: 1.2,
        ),
      ),
    ),
  );

  return Container(
    decoration: bannerDeco,
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text('FJORD CORAL', style: kTitleStyle),
                  SizedBox(height: 6),
                  Text(
                    'A sailing-handbook walkthrough of CupertinoExpansionTile: '
                    'a one-line iOS disclosure widget whose API is title + '
                    'child + an optional ExpansibleController and a fade-or-'
                    'scroll transitionMode. Each section is a marker buoy '
                    'bobbing along a glacial coast.',
                    style: kSubtitleStyle,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            harbourSigil,
          ],
        ),
        const SizedBox(height: 14),
        const Text(
          'PALETTE',
          style: TextStyle(
            color: cCoralLite,
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.6,
          ),
        ),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(children: swatches),
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: cFjordAbyss.withValues(alpha: 0.45),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: cGraniteSoft, width: 1),
          ),
          child: const Text(
            'static snapshot --- no controllers --- 12+ tile instances',
            style: kCodeStyle,
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
//  SECTION 2 --- Anatomy of an iOS-style expansion tile (prose)
// ===========================================================================

Widget _buildAnatomySection() {
  print(' Building Section 2: anatomy of an iOS expansion tile.');

  return Container(
    decoration: _proseCardDeco(),
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        Text('1. WHAT IS CupertinoExpansionTile?', style: kSectionHeaderStyle),
        SizedBox(height: 10),
        Text(
          'A CupertinoExpansionTile is an iOS-flavoured disclosure row: a '
          'tappable header that hides --- or reveals --- a single child '
          'widget beneath it. It is the visual ancestor of the Settings '
          'app section header you have tapped a thousand times: a calm '
          'row, a chevron, and (when opened) a quiet column of options '
          'that fades or scrolls into view. There is no inkwell, no '
          'ripple, no shadow lift; iOS keeps the gesture restrained.',
          style: kSectionLeadStyle,
        ),
        SizedBox(height: 12),
        Text('TWO STATES, ONE WIDGET', style: kSmallLabelStyle),
        SizedBox(height: 6),
        Text(
          '   * COLLAPSED   --- only the header row is rendered. The chevron '
          'points end-ward. The child exists in the tree only as configuration; '
          'it is not painted.\n'
          '   * EXPANDED    --- the header row is followed by the child. iOS '
          'either fades the child in (transitionMode.fade, the default) or '
          'scrolls it under the header (transitionMode.scroll).\n'
          '\n'
          'Both states share the same tile instance. Switching is a STATE '
          'transition driven by the ExpansibleController, not a tree '
          'rebuild. Because D4rt forbids stateful mutation, we cannot drive '
          'that controller --- so we render real expanded tiles next to '
          'hand-drawn collapsed-state mocks. The mocks are not '
          'CupertinoExpansionTile instances; they are Container rows that '
          'paint exactly what one looks like when shut.',
          style: kBodyStyle,
        ),
        SizedBox(height: 12),
        Text('THE HEADER ROW', style: kSmallLabelStyle),
        SizedBox(height: 6),
        Text(
          'There is no separate `leading`, `subtitle`, or `trailing` slot. '
          'The whole header row is the `title` Widget you pass in. The '
          'idiomatic way to add a leading icon, a subtitle line, or a '
          'trailing badge is to compose them yourself:\n'
          '\n'
          '   Row(children: <Widget>[\n'
          '      Icon(CupertinoIcons.wifi),\n'
          '      const SizedBox(width: 10),\n'
          '      Expanded(child: Column(\n'
          '         crossAxisAlignment: CrossAxisAlignment.start,\n'
          '         children: const <Widget>[\n'
          '            Text(\'Wi-Fi\'),\n'
          '            Text(\'Glacial-Bay-5GHz\', style: TextStyle(fontSize: 12)),\n'
          '         ],\n'
          '      )),\n'
          '   ])\n'
          '\n'
          'Pass the whole composition as `title`. This demo uses a small '
          'helper `_composeTitle` to keep the call sites short.',
          style: kBodyStyle,
        ),
        SizedBox(height: 12),
        Text('THE CHILD', style: kSmallLabelStyle),
        SizedBox(height: 6),
        Text(
          'The `child` is a single Widget. To present multiple rows, wrap '
          'them in a Column or a CupertinoListSection. The child exists '
          'whenever the tile is built; on expand the layout simply reveals '
          'it. Plan for that --- do not stuff a thousand-item ListView '
          'under a single tile; reach for ListView.builder instead.',
          style: kBodyStyle,
        ),
        SizedBox(height: 12),
        Text('TRANSITION MODE', style: kSmallLabelStyle),
        SizedBox(height: 6),
        Text(
          '   * fade   --- the child appears fully extended and fades into\n'
          '                view. iOS Settings uses fade.\n'
          '   * scroll --- the child scrolls from under the header until it\n'
          '                becomes fully extended. iOS Files uses scroll.\n'
          '\n'
          'Pick once per screen. Mixing fade and scroll inside one section '
          'feels twitchy.',
          style: kBodyStyle,
        ),
        SizedBox(height: 12),
        Text('A TYPICAL iOS USAGE', style: kSmallLabelStyle),
        SizedBox(height: 6),
        Text(
          '   CupertinoListSection.insetGrouped(\n'
          '      header: const Text(\'NETWORK\'),\n'
          '      children: <Widget>[\n'
          '         CupertinoExpansionTile(\n'
          '            title: const Text(\'Wi-Fi\'),\n'
          '            transitionMode: ExpansionTileTransitionMode.fade,\n'
          '            child: Padding(\n'
          '               padding: const EdgeInsets.all(12),\n'
          '               child: Column(\n'
          '                  children: const <Widget>[\n'
          '                     CupertinoListTile(title: Text(\'Forget network\')),\n'
          '                     CupertinoListTile(title: Text(\'Renew lease\')),\n'
          '                  ],\n'
          '               ),\n'
          '            ),\n'
          '         ),\n'
          '      ],\n'
          '   ),\n'
          '\n'
          'Read it top-to-bottom and the screen lays itself out like a '
          'chart unrolled on the cabin table.',
          style: kBodyStyle,
        ),
      ],
    ),
  );
}

// ===========================================================================
//  SECTION 3 --- Property table
// ===========================================================================

const List<List<String>> kPropertyTable = <List<String>>[
  <String>[
    'title', 'Widget', '(required)',
    'The mandatory headline. iOS prefers a single Text or composed Row.',
  ],
  <String>[
    'child', 'Widget', '(required)',
    'The single body widget revealed when the tile is expanded.',
  ],
  <String>[
    'controller', 'ExpansibleController?', 'null',
    'Imperative open/close handle. Not driven in this demo.',
  ],
  <String>[
    'transitionMode', 'ExpansionTileTransitionMode',
    'fade',
    'fade or scroll. iOS Settings prefers fade.',
  ],
];

Widget _buildPropertyTable() {
  print(' Building Section 3: property table.');

  final List<Widget> rows = <Widget>[];

  rows.add(
    Container(
      decoration: const BoxDecoration(
        color: cCoral,
        border: Border(
          bottom: BorderSide(color: cGraniteDark, width: 1),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Row(
        children: const <Widget>[
          SizedBox(
            width: 130,
            child: Text(
              'PROPERTY',
              style: TextStyle(
                color: cGlacialSnow,
                fontWeight: FontWeight.w800,
                fontSize: 11,
                letterSpacing: 0.7,
              ),
            ),
          ),
          SizedBox(
            width: 200,
            child: Text(
              'TYPE',
              style: TextStyle(
                color: cGlacialSnow,
                fontWeight: FontWeight.w800,
                fontSize: 11,
                letterSpacing: 0.7,
              ),
            ),
          ),
          SizedBox(
            width: 90,
            child: Text(
              'DEFAULT',
              style: TextStyle(
                color: cGlacialSnow,
                fontWeight: FontWeight.w800,
                fontSize: 11,
                letterSpacing: 0.7,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'MEANING',
              style: TextStyle(
                color: cGlacialSnow,
                fontWeight: FontWeight.w800,
                fontSize: 11,
                letterSpacing: 0.7,
              ),
            ),
          ),
        ],
      ),
    ),
  );

  for (int i = 0; i < kPropertyTable.length; i++) {
    final List<String> row = kPropertyTable[i];
    final Color zebra = (i % 2 == 0) ? cGlacialSnow : cGlacialIce;
    rows.add(
      Container(
        color: zebra,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 130,
              child: Text(
                row[0],
                style: const TextStyle(
                  color: cFjordBlue,
                  fontWeight: FontWeight.w800,
                  fontSize: 12,
                  fontFamily: 'monospace',
                ),
              ),
            ),
            SizedBox(
              width: 200,
              child: Text(
                row[1],
                style: const TextStyle(
                  color: cFjordDeep,
                  fontSize: 11,
                  fontFamily: 'monospace',
                ),
              ),
            ),
            SizedBox(
              width: 90,
              child: Text(
                row[2],
                style: const TextStyle(
                  color: cCoralDeep,
                  fontSize: 11,
                  fontFamily: 'monospace',
                ),
              ),
            ),
            Expanded(
              child: Text(row[3], style: kBodyStyle),
            ),
          ],
        ),
      ),
    );
  }

  // Add a small lead-in below the table that explains why the actual
  // API is so small --- and how iOS achieves the rich Settings look
  // through composition rather than dedicated slots.
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: cGraniteDark, width: 1),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: cFjordAbyss.withValues(alpha: 0.10),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(children: rows),
      ),
      const SizedBox(height: 12),
      Container(
        padding: const EdgeInsets.all(12),
        decoration: _proseCardDeco(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            Text('FOUR PROPERTIES, ENDLESS COMPOSITIONS', style: kSmallLabelStyle),
            SizedBox(height: 6),
            Text(
              'The actual constructor is small on purpose. iOS apps achieve '
              'their rich settings appearance through composition: the '
              'header row is composed inside the `title` widget; the '
              'expanded panel is composed inside the `child` widget. The '
              'tile itself only needs four knobs to do its job.',
              style: kBodyStyle,
            ),
          ],
        ),
      ),
    ],
  );
}

// ===========================================================================
//  SECTION 4 --- Collapsed-state mock catalogue (5 hand-drawn rows)
// ===========================================================================
//  Five hand-drawn rows that paint the visual shape of a CupertinoExpansion
//  Tile in its folded form. These are NOT CupertinoExpansionTile instances
//  --- they are Container rows --- because there is no way to render a real
//  tile in its collapsed state in a single static build pass without a
//  StatefulWidget.
//
//  Each mock dramatises a different combination of header pieces:
//    A. title only
//    B. title + subtitle
//    C. leading icon + title
//    D. leading icon + title + subtitle
//    E. leading icon + title + custom trailing pill (instead of chevron)
//
//  Wrapped in CupertinoListSection.insetGrouped so the reader sees them
//  in their natural iOS habitat: a rounded card on a glacial-white field
//  with thin granite separators between rows.
// ---------------------------------------------------------------------------

Widget _buildCollapsedCatalogue() {
  print(' Building Section 4: collapsed-state mock catalogue (5 mocks).');

  final Widget mockA = _collapsedMock(title: 'A. Title only');

  final Widget mockB = _collapsedMock(
    title: 'B. Bluetooth',
    subtitle: 'On --- 2 paired devices',
  );

  final Widget mockC = _collapsedMock(
    leading: CupertinoIcons.wifi,
    leadingColor: cFjordSky,
    title: 'C. Cellular',
  );

  final Widget mockD = _collapsedMock(
    leading: CupertinoIcons.bell,
    leadingColor: cCoral,
    title: 'D. Notifications',
    subtitle: 'Most apps allowed',
  );

  final Widget mockE = _collapsedMock(
    leading: CupertinoIcons.lock,
    leadingColor: cKelpGreen,
    title: 'E. Privacy & Security',
    trailing: Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: cCoral,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Text(
        'NEW',
        style: TextStyle(
          color: cGlacialSnow,
          fontSize: 10,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.6,
        ),
      ),
    ),
  );

  final Widget lead = Padding(
    padding: const EdgeInsets.fromLTRB(4, 0, 4, 10),
    child: Text(
      'Five hand-drawn collapsed-state mocks. The chevron on the trailing '
      'edge is iOS\'s whispered hint that more lives below. These are '
      'Container rows, not CupertinoExpansionTile instances --- the real '
      'tile does not render in its folded form during a single static '
      'build, so we paint the shape ourselves.',
      style: kBodyStyle,
    ),
  );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      lead,
      Container(
        decoration: BoxDecoration(
          color: cGlacialSnow,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: cGraniteFog, width: 1),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: <Widget>[mockA, mockB, mockC, mockD, mockE],
        ),
      ),
    ],
  );
}

// ===========================================================================
//  SECTION 5 --- Expanded tile catalogue (5 real CupertinoExpansionTiles)
// ===========================================================================
//  Five distinct CupertinoExpansionTile instances, each with a different
//  child payload. These are real tiles --- they will render in whatever
//  state the ExpansibleController dictates at runtime --- but in a
//  static D4rt snapshot they appear in their initial state. We treat
//  them as a tour of "what an expanded tile reveals" rather than a
//  guaranteed visual.
//
//  Tile 1 --- a paragraph child (prose card).
//  Tile 2 --- a stack of CupertinoListTiles inside a Column.
//  Tile 3 --- a row of mode chips (Light / Dark / Auto).
//  Tile 4 --- a code cartouche.
//  Tile 5 --- a row of accent-colour swatches.
// ---------------------------------------------------------------------------

Widget _buildExpandedCatalogue() {
  print(' Building Section 5: expanded tile catalogue (5 tiles).');

  // Tile 1 --- prose paragraph child.
  final Widget tile1 = CupertinoExpansionTile(
    title: _composeTitle(
      leading: CupertinoIcons.book,
      leadingColor: cFjordSky,
      title: '1. About this section',
    ),
    transitionMode: ExpansionTileTransitionMode.fade,
    child: Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 14),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: cGlacialIce,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: cGraniteFog, width: 1),
        ),
        child: const Text(
          'When a CupertinoExpansionTile is open, the child renders below '
          'the header in tree order. iOS does not lazy-build it; it exists '
          'whenever the tile is built, and the expand gesture simply '
          'reveals it. Plan your child with that in mind.',
          style: kTileBodyStyle,
        ),
      ),
    ),
  );

  // Tile 2 --- a stack of CupertinoListTiles inside a Column.
  final Widget tile2 = CupertinoExpansionTile(
    title: _composeTitle(
      leading: CupertinoIcons.gear,
      leadingColor: cGraniteMid,
      title: '2. General',
      subtitle: 'System-wide preferences',
    ),
    transitionMode: ExpansionTileTransitionMode.fade,
    child: Column(
      children: const <Widget>[
        CupertinoListTile(title: Text('Software Update')),
        CupertinoListTile(title: Text('AirDrop')),
        CupertinoListTile(title: Text('AirPlay & Handoff')),
        CupertinoListTile(title: Text('Date & Time')),
      ],
    ),
  );

  // Tile 3 --- mode-chip row child.
  final Widget tile3 = CupertinoExpansionTile(
    title: _composeTitle(
      leading: CupertinoIcons.paintbrush,
      leadingColor: cCoral,
      title: '3. Display & Brightness',
    ),
    transitionMode: ExpansionTileTransitionMode.scroll,
    child: Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _modeChip('Light', cGlacialSnow, cFjordBlue, true),
          _modeChip('Dark', cFjordAbyss, cGlacialWhite, false),
          _modeChip('Auto', cGlacialIce, cFjordDeep, false),
        ],
      ),
    ),
  );

  // Tile 4 --- code cartouche child.
  final Widget tile4 = CupertinoExpansionTile(
    title: _composeTitle(
      leading: CupertinoIcons.chevron_left_slash_chevron_right,
      leadingColor: cFjordDeep,
      title: '4. Developer',
    ),
    transitionMode: ExpansionTileTransitionMode.fade,
    child: Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 14),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: cFjordAbyss,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: cGraniteDark, width: 1),
        ),
        child: const Text(
          'CupertinoExpansionTile(\n'
          '   title: const Text(\'General\'),\n'
          '   transitionMode: ExpansionTileTransitionMode.fade,\n'
          '   child: Column(\n'
          '      children: const <Widget>[\n'
          '         CupertinoListTile(title: Text(\'About\')),\n'
          '      ],\n'
          '   ),\n'
          ')',
          style: kCodeStyle,
        ),
      ),
    ),
  );

  // Tile 5 --- accent-colour swatch row child.
  final Widget tile5 = CupertinoExpansionTile(
    title: _composeTitle(
      leading: CupertinoIcons.color_filter,
      leadingColor: cCoralDeep,
      title: '5. Accent Colour',
      subtitle: 'Coral selected',
    ),
    transitionMode: ExpansionTileTransitionMode.fade,
    child: Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 14),
      child: Row(
        children: <Widget>[
          _accentDot(cCoral, true),
          _accentDot(cFjordBlue, false),
          _accentDot(cKelpGreen, false),
          _accentDot(cBuoyYellow, false),
          _accentDot(cGraniteMid, false),
        ],
      ),
    ),
  );

  final Widget lead = Padding(
    padding: const EdgeInsets.fromLTRB(4, 0, 4, 10),
    child: Text(
      'Five real CupertinoExpansionTile instances, each carrying a different '
      'kind of child payload. The header row in each is a Row composed by '
      '`_composeTitle` so the demo can dramatise leading icons and subtitles '
      'inside the single `title` slot. Tile 3 uses transitionMode.scroll; '
      'the rest use the default fade.',
      style: kBodyStyle,
    ),
  );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      lead,
      CupertinoListSection.insetGrouped(
        backgroundColor: cGlacialWhite,
        header: const Text(
          'EXPANDED CATALOGUE',
          style: TextStyle(
            color: cFjordBlue,
            fontWeight: FontWeight.w700,
            fontSize: 12,
            letterSpacing: 1.4,
          ),
        ),
        children: <Widget>[tile1, tile2, tile3, tile4, tile5],
      ),
    ],
  );
}

Widget _modeChip(String label, Color bg, Color fg, bool selected) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        color: selected ? cCoral : cGraniteFog,
        width: selected ? 2 : 1,
      ),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: fg,
        fontSize: 12,
        fontWeight: selected ? FontWeight.w800 : FontWeight.w500,
      ),
    ),
  );
}

Widget _accentDot(Color color, bool selected) {
  return Padding(
    padding: const EdgeInsets.only(right: 10),
    child: Container(
      width: 26,
      height: 26,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(
          color: selected ? cFjordAbyss : cGraniteFog,
          width: selected ? 2 : 1,
        ),
      ),
    ),
  );
}

// ===========================================================================
//  SECTION 6 --- Nested expansion tiles
// ===========================================================================
//  iOS occasionally allows a tile inside another tile --- a folder
//  inside a folder. We render an outer CupertinoExpansionTile whose
//  child is a Column containing two inner CupertinoExpansionTiles. We
//  add a small leading inset to the inner tiles to suggest hierarchy.
// ---------------------------------------------------------------------------

Widget _buildNestedTiles() {
  print(' Building Section 6: nested expansion tiles.');

  final Widget innerA = Padding(
    padding: const EdgeInsets.only(left: 12),
    child: CupertinoExpansionTile(
      title: _composeTitle(
        leading: CupertinoIcons.folder,
        leadingColor: cFjordMist,
        title: 'Sub-folder A',
      ),
      transitionMode: ExpansionTileTransitionMode.fade,
      child: Column(
        children: const <Widget>[
          CupertinoListTile(title: Text('Item A1')),
          CupertinoListTile(title: Text('Item A2')),
        ],
      ),
    ),
  );

  final Widget innerB = Padding(
    padding: const EdgeInsets.only(left: 12),
    child: CupertinoExpansionTile(
      title: _composeTitle(
        leading: CupertinoIcons.folder_open,
        leadingColor: cCoral,
        title: 'Sub-folder B',
      ),
      transitionMode: ExpansionTileTransitionMode.scroll,
      child: Column(
        children: const <Widget>[
          CupertinoListTile(title: Text('Item B1')),
          CupertinoListTile(title: Text('Item B2')),
          CupertinoListTile(title: Text('Item B3')),
        ],
      ),
    ),
  );

  final Widget outer = CupertinoExpansionTile(
    title: _composeTitle(
      leading: CupertinoIcons.tray_full,
      leadingColor: cFjordSky,
      title: 'Documents (outer)',
      subtitle: '2 sub-folders',
    ),
    transitionMode: ExpansionTileTransitionMode.fade,
    child: Column(
      children: <Widget>[innerA, innerB],
    ),
  );

  final Widget lead = Padding(
    padding: const EdgeInsets.fromLTRB(4, 0, 4, 10),
    child: Text(
      'A tile whose child contains two more tiles. We add a 12-pixel '
      'leading inset to the inner tiles to suggest hierarchy --- iOS '
      'itself uses a similar trick in the Files app and in nested '
      'Settings panels. Mix transitionMode.fade and .scroll between the '
      'inner tiles only when the design calls for it; uniformity is '
      'usually kinder to the reader.',
      style: kBodyStyle,
    ),
  );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      lead,
      CupertinoListSection.insetGrouped(
        backgroundColor: cGlacialWhite,
        header: const Text(
          'NESTED',
          style: TextStyle(
            color: cFjordBlue,
            fontWeight: FontWeight.w700,
            fontSize: 12,
            letterSpacing: 1.4,
          ),
        ),
        children: <Widget>[outer],
      ),
    ],
  );
}

// ===========================================================================
//  SECTION 7 --- Header-composition variants (6 tiles)
// ===========================================================================
//  Six tile variants, each composing a different kind of header inside
//  the single `title` slot. The reader sees how iOS-style "leading
//  icons", "subtitles", and "trailing badges" are achieved through Row
//  + Column composition rather than dedicated constructor parameters.
//
//  Variant A --- bare leading icon, plain title.
//  Variant B --- coloured swatch leading + title.
//  Variant C --- lettered medallion leading + title.
//  Variant D --- title + trailing pill badge (count of unread items).
//  Variant E --- locked-section: leading lock + title + trailing lock glyph.
//  Variant F --- title + trailing custom medallion (chevron-down).
//
//  All six tiles use a small placeholder child so the demo focuses on
//  the header composition.
// ---------------------------------------------------------------------------

Widget _buildHeaderVariants() {
  print(' Building Section 7: header-composition variants (6 tiles).');

  final Widget placeholderChild = Padding(
    padding: const EdgeInsets.fromLTRB(16, 8, 16, 14),
    child: Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: cGlacialIce,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: cGraniteFog, width: 1),
      ),
      child: const Text(
        'placeholder child',
        style: kTileBodyStyle,
      ),
    ),
  );

  // A. bare leading icon, plain title.
  final Widget vA = CupertinoExpansionTile(
    title: _composeTitle(
      leading: CupertinoIcons.wifi,
      leadingColor: cFjordSky,
      title: 'A. Bare icon leading',
    ),
    transitionMode: ExpansionTileTransitionMode.fade,
    child: placeholderChild,
  );

  // B. coloured swatch leading.
  final Widget vB = CupertinoExpansionTile(
    title: Row(
      children: <Widget>[
        Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            color: cCoral,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: cCoralDeep, width: 1),
          ),
        ),
        const SizedBox(width: 10),
        const Expanded(
          child: Text('B. Swatch leading', style: kTileTitleStyle),
        ),
      ],
    ),
    transitionMode: ExpansionTileTransitionMode.fade,
    child: placeholderChild,
  );

  // C. lettered medallion leading.
  final Widget vC = CupertinoExpansionTile(
    title: Row(
      children: <Widget>[
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: cFjordBlue,
            shape: BoxShape.circle,
            border: Border.all(color: cFjordDeep, width: 1),
          ),
          alignment: Alignment.center,
          child: const Text(
            'F',
            style: TextStyle(
              color: cGlacialSnow,
              fontWeight: FontWeight.w800,
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(width: 10),
        const Expanded(
          child: Text('C. Medallion leading', style: kTileTitleStyle),
        ),
      ],
    ),
    transitionMode: ExpansionTileTransitionMode.fade,
    child: placeholderChild,
  );

  // D. trailing pill badge.
  final Widget vD = CupertinoExpansionTile(
    title: _composeTitle(
      leading: CupertinoIcons.bell,
      leadingColor: cCoral,
      title: 'D. Pill badge in title',
      trailingBadge: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: cCoral,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Text(
          '3',
          style: TextStyle(
            color: cGlacialSnow,
            fontSize: 11,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    ),
    transitionMode: ExpansionTileTransitionMode.fade,
    child: placeholderChild,
  );

  // E. locked section.
  final Widget vE = CupertinoExpansionTile(
    title: _composeTitle(
      leading: CupertinoIcons.lock_fill,
      leadingColor: cKelpGreen,
      title: 'E. Locked section',
      trailingBadge: _miniIcon(CupertinoIcons.lock,
          size: 16, color: cGraniteMid),
    ),
    transitionMode: ExpansionTileTransitionMode.fade,
    child: placeholderChild,
  );

  // F. trailing custom medallion.
  final Widget vF = CupertinoExpansionTile(
    title: _composeTitle(
      leading: CupertinoIcons.cube_box,
      leadingColor: cFjordDeep,
      title: 'F. Trailing medallion',
      trailingBadge: Container(
        width: 22,
        height: 22,
        decoration: const BoxDecoration(
          color: cFjordBlue,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: const Icon(
          CupertinoIcons.chevron_down,
          size: 12,
          color: cGlacialSnow,
        ),
      ),
    ),
    transitionMode: ExpansionTileTransitionMode.fade,
    child: placeholderChild,
  );

  final Widget lead = Padding(
    padding: const EdgeInsets.fromLTRB(4, 0, 4, 10),
    child: Text(
      'Six header-composition variants. The leading slot can hold a bare '
      'icon, a coloured swatch, or a lettered medallion. The trailing '
      'visual (a pill, glyph, or medallion) is composed inside the title '
      'Row using the trailingBadge parameter of `_composeTitle`. The real '
      'CupertinoExpansionTile.title accepts any single Widget --- so we '
      'compose whatever shape we like and pass it in.',
      style: kBodyStyle,
    ),
  );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      lead,
      CupertinoListSection.insetGrouped(
        backgroundColor: cGlacialWhite,
        header: const Text(
          'HEADER VARIANTS',
          style: TextStyle(
            color: cFjordBlue,
            fontWeight: FontWeight.w700,
            fontSize: 12,
            letterSpacing: 1.4,
          ),
        ),
        children: <Widget>[vA, vB, vC, vD, vE, vF],
      ),
    ],
  );
}

// ===========================================================================
//  SECTION 8 --- Settings-panel mock (insetGrouped, four tiles)
// ===========================================================================
//  We mock a four-tile iOS Settings panel: General, Display, Battery, and
//  Privacy. All four are real CupertinoExpansionTile instances with
//  composed titles and varied child payloads. Together they paint a
//  realistic Settings screen on a glacial-white field with a coral
//  header bar at the top.
// ---------------------------------------------------------------------------

Widget _buildSettingsPanelMock() {
  print(' Building Section 8: settings-panel mock (4 tiles).');

  final Widget settingsGeneral = CupertinoExpansionTile(
    title: _composeTitle(
      leading: CupertinoIcons.gear,
      leadingColor: cGraniteMid,
      title: 'General',
      subtitle: 'Software, AirDrop, Date & Time',
    ),
    transitionMode: ExpansionTileTransitionMode.fade,
    child: Column(
      children: const <Widget>[
        CupertinoListTile(title: Text('Software Update')),
        CupertinoListTile(title: Text('AirDrop')),
      ],
    ),
  );

  final Widget settingsDisplay = CupertinoExpansionTile(
    title: _composeTitle(
      leading: CupertinoIcons.brightness,
      leadingColor: cBuoyYellow,
      title: 'Display & Brightness',
    ),
    transitionMode: ExpansionTileTransitionMode.fade,
    child: Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _modeChip('Light', cGlacialSnow, cFjordBlue, true),
              _modeChip('Dark', cFjordAbyss, cGlacialWhite, false),
              _modeChip('Auto', cGlacialIce, cFjordDeep, false),
            ],
          ),
        ),
        const CupertinoListTile(title: Text('Text Size')),
        const CupertinoListTile(title: Text('Bold Text')),
      ],
    ),
  );

  final Widget settingsBattery = CupertinoExpansionTile(
    title: _composeTitle(
      leading: CupertinoIcons.battery_75_percent,
      leadingColor: cKelpGreen,
      title: 'Battery',
      subtitle: '72% --- charging slowed',
    ),
    transitionMode: ExpansionTileTransitionMode.scroll,
    child: Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 14),
          child: _batteryBar(0.72),
        ),
        const CupertinoListTile(title: Text('Battery Health')),
        const CupertinoListTile(title: Text('Low Power Mode')),
      ],
    ),
  );

  final Widget settingsPrivacy = CupertinoExpansionTile(
    title: _composeTitle(
      leading: CupertinoIcons.lock_shield,
      leadingColor: cCoralDeep,
      title: 'Privacy & Security',
      trailingBadge: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: cCoral,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Text(
          'NEW',
          style: TextStyle(
            color: cGlacialSnow,
            fontSize: 10,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.6,
          ),
        ),
      ),
    ),
    transitionMode: ExpansionTileTransitionMode.fade,
    child: Column(
      children: const <Widget>[
        CupertinoListTile(title: Text('Location Services')),
        CupertinoListTile(title: Text('Tracking')),
        CupertinoListTile(title: Text('App Privacy Report')),
      ],
    ),
  );

  final Widget lead = Padding(
    padding: const EdgeInsets.fromLTRB(4, 0, 4, 10),
    child: Text(
      'A four-tile mock of an iOS Settings screen. Each tile is a real '
      'CupertinoExpansionTile with a composed title (leading icon + title '
      '+ optional subtitle or trailing badge) and a child built as a '
      'Column. Battery uses transitionMode.scroll; the rest fade. Privacy '
      'carries a coral NEW pill in its trailing-badge slot.',
      style: kBodyStyle,
    ),
  );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      lead,
      CupertinoListSection.insetGrouped(
        backgroundColor: cGlacialWhite,
        header: const Text(
          'SETTINGS',
          style: TextStyle(
            color: cFjordBlue,
            fontWeight: FontWeight.w700,
            fontSize: 12,
            letterSpacing: 1.4,
          ),
        ),
        footer: const Text(
          'Some sections require a passcode to expand.',
          style: TextStyle(
            color: cGraniteMid,
            fontSize: 11,
          ),
        ),
        children: <Widget>[
          settingsGeneral,
          settingsDisplay,
          settingsBattery,
          settingsPrivacy,
        ],
      ),
    ],
  );
}

Widget _batteryBar(double fraction) {
  return Container(
    height: 14,
    decoration: BoxDecoration(
      color: cGlacialIce,
      borderRadius: BorderRadius.circular(7),
      border: Border.all(color: cGraniteFog, width: 1),
    ),
    child: Row(
      children: <Widget>[
        Expanded(
          flex: (fraction * 1000).round(),
          child: Container(
            decoration: BoxDecoration(
              color: cKelpGreen,
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ),
        Expanded(
          flex: ((1.0 - fraction) * 1000).round(),
          child: const SizedBox.shrink(),
        ),
      ],
    ),
  );
}

// ===========================================================================
//  SECTION 9 --- Cupertino vs Material comparison
// ===========================================================================
//  Two compact tiles side-by-side: one CupertinoExpansionTile and one
//  Material ExpansionTile. The reader compares the two idioms at a glance
//  --- iOS prefers a quiet rounded card; Material prefers a flat row with
//  a hover state and a leading/subtitle/trailing slot trio that the iOS
//  API does not have.
// ---------------------------------------------------------------------------

Widget _buildCupertinoVsMaterial() {
  print(' Building Section 9: Cupertino vs Material comparison.');

  final Widget cupertinoSide = Container(
    decoration: BoxDecoration(
      color: cGlacialWhite,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: cGraniteFog, width: 1),
    ),
    padding: const EdgeInsets.all(8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.fromLTRB(4, 4, 4, 8),
          child: Text(
            'CUPERTINO',
            style: TextStyle(
              color: cFjordBlue,
              fontWeight: FontWeight.w800,
              fontSize: 11,
              letterSpacing: 1.4,
            ),
          ),
        ),
        CupertinoListSection.insetGrouped(
          backgroundColor: cGlacialWhite,
          margin: EdgeInsets.zero,
          children: <Widget>[
            CupertinoExpansionTile(
              title: _composeTitle(
                leading: CupertinoIcons.wifi,
                leadingColor: cFjordSky,
                title: 'Wi-Fi',
                subtitle: 'Glacial-Bay-5GHz',
              ),
              transitionMode: ExpansionTileTransitionMode.fade,
              child: Column(
                children: const <Widget>[
                  CupertinoListTile(title: Text('Forget network')),
                  CupertinoListTile(title: Text('Renew lease')),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );

  final Widget materialSide = Container(
    decoration: BoxDecoration(
      color: cGlacialWhite,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: cGraniteFog, width: 1),
    ),
    padding: const EdgeInsets.all(8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(4, 4, 4, 8),
          child: Text(
            'MATERIAL',
            style: TextStyle(
              color: cCoralDeep,
              fontWeight: FontWeight.w800,
              fontSize: 11,
              letterSpacing: 1.4,
            ),
          ),
        ),
        Card(
          color: cGlacialSnow,
          elevation: 0,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: cGraniteFog, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          margin: EdgeInsets.zero,
          child: ExpansionTile(
            leading: Icon(Icons.wifi, color: cFjordSky),
            title: Text('Wi-Fi', style: kTileTitleStyle),
            subtitle: Text('Glacial-Bay-5GHz', style: kTileSubStyle),
            initiallyExpanded: true,
            children: <Widget>[
              ListTile(title: Text('Forget network')),
              ListTile(title: Text('Renew lease')),
            ],
          ),
        ),
      ],
    ),
  );

  final Widget lead = Padding(
    padding: const EdgeInsets.fromLTRB(4, 0, 4, 10),
    child: Text(
      'Two equivalent tiles, side by side. The Cupertino tile sits in a '
      'rounded inset-grouped card and composes its leading icon and '
      'subtitle inside the single `title` slot. The Material tile uses '
      'dedicated `leading`, `title`, `subtitle`, and `children` parameters. '
      'Use the iOS form when the surrounding screen is CupertinoApp; use '
      'Material when the surrounding screen is MaterialApp. Mixing idioms '
      'inside one screen is rarely worth it.',
      style: kBodyStyle,
    ),
  );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      lead,
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(child: cupertinoSide),
          const SizedBox(width: 12),
          Expanded(child: materialSide),
        ],
      ),
      const SizedBox(height: 14),
      Container(
        padding: const EdgeInsets.all(12),
        decoration: _proseCardDeco(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            Text('DIFFERENCES IN A NAVIGATOR\'S NUTSHELL', style: kSmallLabelStyle),
            SizedBox(height: 6),
            Text(
              '   * API surface     --- iOS exposes title + child + controller\n'
              '                         + transitionMode. Material exposes\n'
              '                         leading + title + subtitle + trailing\n'
              '                         + children + onExpansionChanged + ...\n'
              '   * Header slots    --- iOS composes leading/subtitle/trailing\n'
              '                         INSIDE the single title widget. Material\n'
              '                         provides explicit named slots.\n'
              '   * Children        --- iOS wraps multiple rows in a Column\n'
              '                         INSIDE child. Material accepts a List\n'
              '                         <Widget> via the children parameter.\n'
              '   * Chrome          --- iOS uses a rounded inset-grouped card;\n'
              '                         Material uses a flat row optionally\n'
              '                         wrapped in a Card.\n'
              '   * Tap feedback    --- iOS provides a quiet highlight; Material\n'
              '                         provides an inkwell ripple.\n'
              '   * Disclosure glyph- iOS rotates a small chevron 90 degrees;\n'
              '                         Material rotates an arrow 180 degrees.\n'
              '\n'
              'Pick one. Hold to it. Tell the user where they are.',
              style: kBodyStyle,
            ),
          ],
        ),
      ),
    ],
  );
}

// ===========================================================================
//  SECTION 10 --- DO / AVOID callouts
// ===========================================================================

Widget _buildDoAvoidCallouts() {
  print(' Building Section 10: DO / AVOID callouts.');

  final Widget doCard = Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: cGlacialSnow,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: cKelpGreen, width: 2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        Text('DO', style: kCalloutDoStyle),
        SizedBox(height: 8),
        Text(
          '   * Compose leading + title + subtitle + trailing INSIDE the\n'
          '     single `title` widget using a Row + Column.\n'
          '   * Wrap multiple rows of expanded content in a Column inside\n'
          '     the `child` slot.\n'
          '   * Wrap tiles in CupertinoListSection.insetGrouped for chrome.\n'
          '   * Reserve the subtitle line for actionable status, not for\n'
          '     decoration.\n'
          '   * Keep the title short. iOS prefers one or two words.\n'
          '   * Use leading icons to reinforce the section\'s identity.\n'
          '   * Pick fade or scroll once per screen and stay with it.\n'
          '   * Match the system\'s rounded corners by sitting inside the\n'
          '     standard inset-grouped section --- do not roll your own.',
          style: kBodyStyle,
        ),
      ],
    ),
  );

  final Widget avoidCard = Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: cGlacialSnow,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: cCoralDeep, width: 2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        Text('AVOID', style: kCalloutAvoidStyle),
        SizedBox(height: 8),
        Text(
          '   * Do not stuff a thousand-item list inside `child`; reach for\n'
          '     a separate route with ListView.builder instead.\n'
          '   * Do not nest more than two levels --- iOS users get lost.\n'
          '   * Do not pair a CupertinoExpansionTile with a Material Card.\n'
          '   * Do not fill the title Row with a noisy custom widget; iOS\n'
          '     expects a quiet header.\n'
          '   * Do not animate the child\'s contents on expand --- iOS\n'
          '     uses a single quiet fade or scroll, not a cascade.\n'
          '   * Do not invent a `subtitle:` parameter that does not exist;\n'
          '     compose the subtitle inside the title widget.\n'
          '   * Do not rely on controller methods if you cannot rebuild the\n'
          '     tree (D4rt forbids it; production iOS apps require a\n'
          '     StatefulWidget host).',
          style: kBodyStyle,
        ),
      ],
    ),
  );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      doCard,
      const SizedBox(height: 12),
      avoidCard,
    ],
  );
}

// ===========================================================================
//  SECTION 11 --- Recipe cards
// ===========================================================================

const List<List<String>> kRecipes = <List<String>>[
  <String>[
    'Recipe 1: A single tile in an inset-grouped section',
    'The simplest production-shape: one tile inside one section. Use this '
        'when you have a single category of options that the user might '
        'want to fold away.',
    'CupertinoListSection.insetGrouped(\n'
    '   children: <Widget>[\n'
    '      CupertinoExpansionTile(\n'
    '         title: const Text(\'General\'),\n'
    '         child: Column(\n'
    '            children: const <Widget>[\n'
    '               CupertinoListTile(title: Text(\'About\')),\n'
    '            ],\n'
    '         ),\n'
    '      ),\n'
    '   ],\n'
    ')',
  ],
  <String>[
    'Recipe 2: A title that composes leading + subtitle',
    'There is no `leading` or `subtitle` parameter. Compose them inside '
        'the single title Widget by wrapping in Row(Icon, Column(title, '
        'subtitle)).',
    'CupertinoExpansionTile(\n'
    '   title: Row(children: <Widget>[\n'
    '      Icon(CupertinoIcons.wifi),\n'
    '      const SizedBox(width: 10),\n'
    '      Expanded(child: Column(\n'
    '         crossAxisAlignment: CrossAxisAlignment.start,\n'
    '         children: const <Widget>[\n'
    '            Text(\'Wi-Fi\'),\n'
    '            Text(\'Glacial-Bay-5GHz\'),\n'
    '         ],\n'
    '      )),\n'
    '   ]),\n'
    '   child: const SizedBox.shrink(),\n'
    ')',
  ],
  <String>[
    'Recipe 3: A coral NEW pill at the trailing edge of the title',
    'Add a coloured pill to the end of the title Row. Keep the pill '
        'small; iOS punishes loud trailing widgets.',
    'CupertinoExpansionTile(\n'
    '   title: Row(children: <Widget>[\n'
    '      Icon(CupertinoIcons.lock_shield),\n'
    '      const SizedBox(width: 10),\n'
    '      const Expanded(child: Text(\'Privacy\')),\n'
    '      Container(\n'
    '         padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),\n'
    '         decoration: BoxDecoration(\n'
    '            color: const Color(0xFFE7704A),\n'
    '            borderRadius: BorderRadius.circular(8),\n'
    '         ),\n'
    '         child: const Text(\'NEW\'),\n'
    '      ),\n'
    '   ]),\n'
    '   child: /* ... */ const SizedBox.shrink(),\n'
    ')',
  ],
  <String>[
    'Recipe 4: Pick a transitionMode that matches the surrounding screen',
    'iOS Settings tends toward fade; iOS Files tends toward scroll. '
        'Pick once per screen and stay with it.',
    'CupertinoExpansionTile(\n'
    '   title: const Text(\'Display\'),\n'
    '   transitionMode: ExpansionTileTransitionMode.scroll,\n'
    '   child: Column(\n'
    '      children: const <Widget>[\n'
    '         CupertinoListTile(title: Text(\'Text Size\')),\n'
    '      ],\n'
    '   ),\n'
    ')',
  ],
  <String>[
    'Recipe 5: Two nested tiles inside a parent tile',
    'Use sparingly. iOS tolerates one level of nesting; two levels is the '
        'far edge of what users can keep in their head. Add a small '
        'leading inset on the inner tiles to suggest hierarchy.',
    'CupertinoExpansionTile(\n'
    '   title: const Text(\'Documents\'),\n'
    '   child: Column(\n'
    '      children: <Widget>[\n'
    '         Padding(\n'
    '            padding: const EdgeInsets.only(left: 12),\n'
    '            child: CupertinoExpansionTile(\n'
    '               title: const Text(\'Sub-folder A\'),\n'
    '               child: const SizedBox.shrink(),\n'
    '            ),\n'
    '         ),\n'
    '      ],\n'
    '   ),\n'
    ')',
  ],
];

Widget _buildRecipeCards() {
  print(' Building Section 11: recipe cards.');

  final List<Widget> cards = <Widget>[];

  for (int i = 0; i < kRecipes.length; i++) {
    final List<String> recipe = kRecipes[i];
    final String title = recipe[0];
    final String lead = recipe[1];
    final String code = recipe[2];

    cards.add(
      Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: cGlacialSnow,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: cGraniteFog, width: 1),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: cFjordAbyss.withValues(alpha: 0.08),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: const BoxDecoration(
                color: cFjordBlue,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Text(
                title,
                style: const TextStyle(
                  color: cGlacialSnow,
                  fontWeight: FontWeight.w800,
                  fontSize: 13,
                  letterSpacing: 0.4,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 8),
              child: Text(lead, style: kBodyStyle),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: cFjordAbyss,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: cGraniteDark, width: 1),
              ),
              child: Text(code, style: kCodeStyle),
            ),
          ],
        ),
      ),
    );
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: cards,
  );
}

// ===========================================================================
//  SECTION 12 --- Glossary
// ===========================================================================

const List<List<String>> kGlossary = <List<String>>[
  <String>[
    'tile',
    'A single header row plus a single revealed child. In Cupertino the '
        'tile is a quiet card-row; in Material it is a flat row with a '
        'hover state.',
  ],
  <String>[
    'header row',
    'The always-visible top of the tile, drawn whenever the tile exists '
        'in the tree. The whole row is the `title` Widget you pass in.',
  ],
  <String>[
    'child',
    'A single Widget revealed beneath the header on expand. Wrap a Column '
        'inside `child` to present multiple lines.',
  ],
  <String>[
    'title (composed)',
    'The Row + Column composition that holds leading icon, title text, '
        'optional subtitle text, and an optional trailing badge. There is '
        'no separate slot for any of these.',
  ],
  <String>[
    'leading (composed)',
    'A small icon at the leading edge of the title Row. iOS keeps it '
        'square and quiet.',
  ],
  <String>[
    'subtitle (composed)',
    'A second line under the title Text, smaller and dimmer. Used '
        'sparingly in iOS for actionable status.',
  ],
  <String>[
    'trailingBadge (composed)',
    'A small widget at the trailing end of the title Row. Replaces the '
        'visual weight of a Material `trailing:` slot.',
  ],
  <String>[
    'controller',
    'ExpansibleController. An imperative handle for opening and closing '
        'the tile. Not driven in this demo because D4rt does not support '
        'StatefulWidgets.',
  ],
  <String>[
    'transitionMode.fade',
    'The child appears fully extended and fades into view. The default. '
        'iOS Settings uses fade.',
  ],
  <String>[
    'transitionMode.scroll',
    'The child scrolls from under the header until it is fully extended. '
        'iOS Files uses scroll.',
  ],
  <String>[
    'insetGrouped',
    'CupertinoListSection.insetGrouped --- the rounded card-shaped '
        'container that holds tiles in iOS Settings-style screens. The '
        'natural habitat for CupertinoExpansionTile.',
  ],
  <String>[
    'chevron',
    'The small > glyph at the trailing edge of the header. On expand iOS '
        'rotates it 90 degrees; on collapse it rotates back. The chevron '
        'is iOS\'s whispered hint that the tile holds more.',
  ],
  <String>[
    'fjord',
    'A long, narrow inlet between high cliffs, formed by glacial erosion. '
        'Our visual metaphor for the deep blue of the iOS background and '
        'the coral marker buoys floating along its surface.',
  ],
];

Widget _buildGlossary() {
  print(' Building Section 12: glossary (${kGlossary.length} terms).');

  final List<Widget> rows = <Widget>[];

  for (int i = 0; i < kGlossary.length; i++) {
    final List<String> entry = kGlossary[i];
    final String term = entry[0];
    final String def = entry[1];
    final Color zebra = (i % 2 == 0) ? cGlacialSnow : cGlacialIce;

    rows.add(
      Container(
        color: zebra,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 150,
              child: Text(term, style: kGlossaryTermStyle),
            ),
            const SizedBox(width: 8),
            Expanded(child: Text(def, style: kGlossaryDefStyle)),
          ],
        ),
      ),
    );
  }

  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: cGraniteDark, width: 1),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: cFjordAbyss.withValues(alpha: 0.10),
          blurRadius: 5,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    clipBehavior: Clip.antiAlias,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          color: cCoral,
          child: const Text(
            'GLOSSARY --- a navigator\'s pocket reference',
            style: TextStyle(
              color: cGlacialSnow,
              fontWeight: FontWeight.w800,
              fontSize: 11,
              letterSpacing: 0.7,
            ),
          ),
        ),
        Column(children: rows),
      ],
    ),
  );
}

// ===========================================================================
//  SECTION 13 --- Recap footer
// ===========================================================================

Widget _buildRecapFooter() {
  print(' Building Section 13: recap footer.');

  final BoxDecoration footerDeco = BoxDecoration(
    gradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[cFjordAbyss, cFjordDeep, cFjordBlue],
      stops: <double>[0.0, 0.5, 1.0],
    ),
    borderRadius: BorderRadius.circular(14),
    border: Border.all(color: cGraniteSoft, width: 2),
    boxShadow: <BoxShadow>[
      BoxShadow(
        color: cCoral.withValues(alpha: 0.25),
        blurRadius: 16,
        spreadRadius: 1,
        offset: const Offset(0, 8),
      ),
    ],
  );

  return Container(
    decoration: footerDeco,
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'RECAP --- FJORD CORAL',
          style: TextStyle(
            color: cCoralLite,
            fontSize: 13,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.6,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'You have walked from the mouth of the fjord to the head of the '
          'bay. We laid out the (small) anatomy of CupertinoExpansionTile '
          '--- four properties: title, child, controller, transitionMode '
          '--- and the (large) range of compositions that fit inside the '
          'single `title` slot. We rendered five hand-drawn collapsed-'
          'state mocks, five real expanded tiles, a nested-tile section, '
          'six header-composition variants, a four-tile Settings-panel '
          'mock, and a Cupertino-vs-Material side-by-side. We ended with '
          'DO/AVOID guidance, five recipe cards, and a glossary you can '
          'keep at the helm.',
          style: TextStyle(
            color: cGlacialIce,
            fontSize: 13,
            height: 1.45,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'The chevron is iOS\'s quietest hint that more lives below. '
          'When you build your own settings screens, keep the title '
          'composition modest, choose your transitionMode once, and '
          'wrap the whole thing in a CupertinoListSection.insetGrouped. '
          'Trust the chrome. Trust the animation. Let the user discover.',
          style: TextStyle(
            color: cGlacialIce,
            fontSize: 13,
            height: 1.45,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: cFjordAbyss.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: cGraniteSoft, width: 1),
          ),
          child: const Text(
            'fair winds --- and a soft chevron --- end of demo',
            style: kCodeStyle,
          ),
        ),
      ],
    ),
  );
}
