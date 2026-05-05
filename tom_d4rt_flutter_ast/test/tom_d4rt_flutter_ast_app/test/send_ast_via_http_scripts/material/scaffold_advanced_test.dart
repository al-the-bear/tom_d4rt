// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// =============================================================================
//                COMPASS CINNABAR --- Scaffold (advanced features)
// =============================================================================
//
//  TARGET WIDGET .... Scaffold  (package:flutter/material.dart)
//
//  CONTEXT .......... Scaffold is the Material visual chassis. It owns the
//                     "page slots" of a Material screen: the AppBar at the
//                     top, the Drawer on the leading edge, the EndDrawer on
//                     the trailing edge, the body in the middle, the
//                     BottomNavigationBar across the foot, the BottomSheet
//                     hovering above the foot, the FloatingActionButton
//                     attached to the body's edge, the persistentFooterButtons
//                     row pinned just above the bottom nav. It also exposes
//                     boolean toggles --- extendBody, extendBodyBehindAppBar,
//                     resizeToAvoidBottomInset --- that change how the body
//                     interacts with translucent chrome and the soft keyboard.
//
//                     This demo dramatises the SLOTS, not Scaffold.of(context).
//                     We never reach into the runtime; we only render
//                     miniature Scaffold compositions inside small viewports
//                     so the reader can see, at a glance, what each property
//                     contributes to the final layout.
//
//  THEME ............ COMPASS CINNABAR
//
//                     A navigator's workshop. Imagine a wide oak chart-table
//                     under brass lamps. A mariner's compass sits at the
//                     centre, its needle pointing toward a copper star.
//                     Sea-charts are unrolled, pinned at the corners by
//                     paperweights of cinnabar (a deep red-orange mineral
//                     beloved of Ming-dynasty cartographers). Brass dividers
//                     and a sextant rest at the margins. The room itself is
//                     panelled in dark charcoal walnut; the parchment of the
//                     charts glows pale under the lamp.
//
//                     Cinnabar is the accent. Charcoal walnut is the chrome.
//                     Parchment is the body. Brass is the trim. Each mini
//                     Scaffold we render feels like a little chart-table
//                     waiting for a navigator to bend over it.
//
//  WHAT WE EXPLORE
//
//      appBar ........................ The masthead of the Scaffold
//      drawer ........................ The leading-edge slide-in panel
//      endDrawer ..................... The trailing-edge slide-in panel
//      bottomNavigationBar ........... The persistent foot strip
//      bottomSheet ................... A hovering panel above the foot
//      floatingActionButton .......... The action attached to the body
//      floatingActionButtonLocation .. WHERE the FAB is attached
//      persistentFooterButtons ....... A row pinned just above bottom nav
//      extendBody .................... Body draws under the bottom nav
//      extendBodyBehindAppBar ........ Body draws under the (translucent) app bar
//      resizeToAvoidBottomInset ...... Body shrinks for the soft keyboard
//      backgroundColor ............... The Scaffold's own canvas color
//
//  WHAT WE DO NOT TOUCH
//
//      Scaffold.of(context).openDrawer()           [runtime lookup]
//      Scaffold.of(context).showBottomSheet(...)   [runtime lookup]
//      ScaffoldMessenger.of(context).showSnackBar  [runtime lookup]
//      Any setState / AnimationController          [no live mutation]
//      Any Timer / Future / Stream                 [no async]
//
//  D4RT CONSTRAINTS
//
//      * build() is called exactly ONCE. We return a single snapshot tree.
//      * No StatefulWidget, no setState, no controllers, no timers.
//      * No `for-in` over BridgedInstance: indexed loops only.
//      * No `.value` on Tween.animate: we don't animate at all.
//      * Use `.withValues(alpha:...)` (not `.withOpacity`).
//
//  SECTIONS
//
//      Section  1 .... Title banner with palette swatches
//      Section  2 .... Prose anatomy of Scaffold
//      Section  3 .... Slot map --- the eight named drawers of a Scaffold
//      Section  4 .... Mini-Scaffold A : appBar + body
//      Section  5 .... Mini-Scaffold B : appBar + body + bottomNav
//      Section  6 .... Mini-Scaffold C : appBar + body + FAB + endDrawer hint
//      Section  7 .... Mini-Scaffold D : extendBodyBehindAppBar (translucent)
//      Section  8 .... Mini-Scaffold E : persistentFooterButtons + bottom sheet
//      Section  9 .... FAB location atlas
//      Section 10 .... extendBody / extendBodyBehindAppBar comparison
//      Section 11 .... resizeToAvoidBottomInset comparison
//      Section 12 .... DO / AVOID callouts
//      Section 13 .... Recipe cards
//      Section 14 .... Glossary
//      Section 15 .... Recap footer
//
// =============================================================================

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
//  PALETTE  ---  Compass Cinnabar
// ---------------------------------------------------------------------------
//  The workshop has a small but disciplined palette. Cinnabar is the only
//  "loud" colour; everything else is a neutral that supports it. We name
//  every token in long form because the whole point of this demo is that
//  the reader can map the colour back to its narrative role.
// ---------------------------------------------------------------------------

const Color cWalnutDark = Color(0xFF26201B); // panelled wall, very dark
const Color cWalnutMid = Color(0xFF3A2F26); // table edge
const Color cCharcoal = Color(0xFF4A3F36); // chart frame, dark trim
const Color cParchment = Color(0xFFEFE4CC); // unrolled chart paper
const Color cParchmentDim = Color(0xFFD9CDB1); // parchment in shadow
const Color cInk = Color(0xFF1F1A14); // chart ink, deepest
const Color cCinnabar = Color(0xFFB94A2A); // primary accent: cinnabar mineral
const Color cCinnabarDeep = Color(0xFF7E2A18); // deeper cinnabar (shadow)
const Color cCinnabarLite = Color(0xFFE57352); // hot cinnabar (highlight)
const Color cBrass = Color(0xFFC8A064); // brass dividers, lamp fittings
const Color cBrassDeep = Color(0xFF8C6A38); // tarnished brass shadow
const Color cCopperStar = Color(0xFFB87333); // copper star at compass centre
const Color cSeaInk = Color(0xFF2A4566); // chart ocean blue-grey
const Color cSeaPale = Color(0xFFB0C0CC); // pale ocean wash
const Color cMossGreen = Color(0xFF5C6A3A); // map land green
const Color cChartOff = Color(0xFFE6D9B6); // off-parchment for layered charts
const Color cLampGlow = Color(0xFFF4D58D); // brass-lamp glow (warm yellow)
const Color cFlagBlack = Color(0xFF14110D); // jolly-roger flag black

// Palette swatches surfaced in the title banner.
const List<Map<String, Object>> kPalette = <Map<String, Object>>[
  {'name': 'walnutDark', 'color': cWalnutDark},
  {'name': 'walnutMid', 'color': cWalnutMid},
  {'name': 'charcoal', 'color': cCharcoal},
  {'name': 'parchment', 'color': cParchment},
  {'name': 'parchmentDim', 'color': cParchmentDim},
  {'name': 'ink', 'color': cInk},
  {'name': 'cinnabar', 'color': cCinnabar},
  {'name': 'cinnabarDeep', 'color': cCinnabarDeep},
  {'name': 'cinnabarLite', 'color': cCinnabarLite},
  {'name': 'brass', 'color': cBrass},
  {'name': 'brassDeep', 'color': cBrassDeep},
  {'name': 'copperStar', 'color': cCopperStar},
  {'name': 'seaInk', 'color': cSeaInk},
  {'name': 'seaPale', 'color': cSeaPale},
  {'name': 'mossGreen', 'color': cMossGreen},
  {'name': 'chartOff', 'color': cChartOff},
  {'name': 'lampGlow', 'color': cLampGlow},
  {'name': 'flagBlack', 'color': cFlagBlack},
];

// ---------------------------------------------------------------------------
//  TEXT TOKENS
// ---------------------------------------------------------------------------

const TextStyle kTitleStyle = TextStyle(
  fontSize: 28,
  fontWeight: FontWeight.w800,
  color: cParchment,
  letterSpacing: 1.6,
);

const TextStyle kSubtitleStyle = TextStyle(
  fontSize: 14,
  fontStyle: FontStyle.italic,
  color: cParchmentDim,
  height: 1.45,
);

const TextStyle kSectionHeaderStyle = TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.w700,
  color: cInk,
);

const TextStyle kSectionLeadStyle = TextStyle(
  fontSize: 13,
  height: 1.45,
  color: cInk,
);

const TextStyle kBodyStyle = TextStyle(
  fontSize: 12,
  height: 1.45,
  color: cInk,
);

const TextStyle kSmallLabelStyle = TextStyle(
  fontSize: 11,
  color: cCinnabarDeep,
  fontWeight: FontWeight.w700,
  letterSpacing: 0.6,
);

const TextStyle kCodeStyle = TextStyle(
  fontFamily: 'monospace',
  fontSize: 12,
  color: cParchment,
  height: 1.4,
);

const TextStyle kCalloutDoStyle = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.w800,
  color: cMossGreen,
  letterSpacing: 0.5,
);

const TextStyle kCalloutAvoidStyle = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.w800,
  color: cCinnabarDeep,
  letterSpacing: 0.5,
);

const TextStyle kMiniAppBarStyle = TextStyle(
  fontSize: 9,
  fontWeight: FontWeight.w700,
  color: cParchment,
  letterSpacing: 0.4,
);

const TextStyle kMiniLabelStyle = TextStyle(
  fontSize: 8,
  color: cCharcoal,
  height: 1.2,
);

const TextStyle kMiniBodyStyle = TextStyle(
  fontSize: 9,
  color: cInk,
  height: 1.3,
);

// ---------------------------------------------------------------------------
//  BUILD ENTRY POINT
// ---------------------------------------------------------------------------
//  D4rt invokes this exactly once. We assemble the entire snapshot up front
//  and return a single Widget --- the whole demo is a static photograph of
//  what a navigator's chart-table looks like with the lamp lit.
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  print('===============================================================');
  print(' Compass Cinnabar --- Scaffold (advanced) deep demo');
  print('===============================================================');
  print(' Building ONE static snapshot.');
  print(' We will compose 5+ miniature Scaffolds inside small viewports.');
  print(' Each mini-Scaffold dramatises a different combination of slots.');
  print(' We never call Scaffold.of(context); this is a STATIC tour.');

  final sections = <Widget>[
    _buildTitleBanner(),
    _spacer(20),
    _buildAnatomySection(),
    _spacer(20),
    _buildSlotMap(),
    _spacer(20),
    _buildSectionHeader('4. Mini-Scaffold A --- appBar + body'),
    _buildMiniA(),
    _spacer(18),
    _buildSectionHeader('5. Mini-Scaffold B --- appBar + body + bottomNav'),
    _buildMiniB(),
    _spacer(18),
    _buildSectionHeader('6. Mini-Scaffold C --- FAB + endDrawer hint'),
    _buildMiniC(),
    _spacer(18),
    _buildSectionHeader('7. Mini-Scaffold D --- extendBodyBehindAppBar'),
    _buildMiniD(),
    _spacer(18),
    _buildSectionHeader('8. Mini-Scaffold E --- persistentFooterButtons + bottomSheet'),
    _buildMiniE(),
    _spacer(20),
    _buildSectionHeader('9. FloatingActionButtonLocation atlas'),
    _buildFabAtlas(),
    _spacer(20),
    _buildSectionHeader('10. extendBody / extendBodyBehindAppBar comparison'),
    _buildExtendBodyComparison(),
    _spacer(20),
    _buildSectionHeader('11. resizeToAvoidBottomInset comparison'),
    _buildResizeComparison(),
    _spacer(20),
    _buildSectionHeader('12. DO / AVOID callouts'),
    _buildDoAvoidCallouts(),
    _spacer(20),
    _buildSectionHeader('13. Recipe cards'),
    _buildRecipeCards(),
    _spacer(20),
    _buildSectionHeader('14. Glossary'),
    _buildGlossary(),
    _spacer(20),
    _buildRecapFooter(),
    _spacer(40),
  ];

  print(' Assembled ${sections.length} top-level section blocks.');
  print(' Returning Scaffold with SingleChildScrollView body.');

  return Scaffold(
    backgroundColor: cParchmentDim,
    body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: sections,
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
  // The section header is itself a chart-cartouche: parchment with a
  // cinnabar gutter on the leading edge and a brass underline.
  return Padding(
    padding: const EdgeInsets.only(top: 12, bottom: 8),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: const BoxDecoration(
        color: cParchment,
        border: Border(
          left: BorderSide(color: cCinnabar, width: 6),
          bottom: BorderSide(color: cBrassDeep, width: 1),
        ),
      ),
      child: Text(text, style: kSectionHeaderStyle),
    ),
  );
}

// Tiny inline icon-glyph for a "menu" hamburger when we cannot rely on
// real Icons rendering at very small sizes. We use the Icon widget but
// keep it tiny.
Widget _miniIcon(IconData icon, {double size = 12, Color color = cParchment}) {
  return Icon(icon, size: size, color: color);
}

// ===========================================================================
//  SECTION 1 --- Title banner with palette swatches
// ===========================================================================

Widget _buildTitleBanner() {
  print(' Building Section 1: title banner.');
  // The banner is a dark walnut panel with cinnabar glow underneath and a
  // brass border --- the chart-table seen from above with the lamp lit.
  final BoxDecoration bannerDeco = BoxDecoration(
    gradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[cWalnutDark, cWalnutMid, cCharcoal],
      stops: <double>[0.0, 0.5, 1.0],
    ),
    borderRadius: BorderRadius.circular(14),
    boxShadow: <BoxShadow>[
      BoxShadow(
        color: cCinnabar.withValues(alpha: 0.35),
        blurRadius: 22,
        spreadRadius: 1,
        offset: const Offset(0, 10),
      ),
    ],
    border: Border.all(color: cBrass, width: 2),
  );

  // A horizontal palette strip in the bottom of the banner.
  final swatches = <Widget>[];
  for (int i = 0; i < kPalette.length; i++) {
    final entry = kPalette[i];
    final c = entry['color'] as Color;
    final n = entry['name'] as String;
    final swatchDeco = BoxDecoration(
      color: c,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: cParchment.withValues(alpha: 0.65), width: 1),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: cFlagBlack.withValues(alpha: 0.45),
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
              width: 60,
              child: Text(
                n,
                style: const TextStyle(fontSize: 9, color: cParchment),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // A small compass-rose sigil floating at the top right of the banner.
  final compassRose = Container(
    width: 56,
    height: 56,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      gradient: const RadialGradient(
        colors: <Color>[cLampGlow, cCopperStar, cCharcoal],
        stops: <double>[0.0, 0.6, 1.0],
      ),
      border: Border.all(color: cBrass, width: 2),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: cBrass.withValues(alpha: 0.6),
          blurRadius: 10,
          spreadRadius: 1,
        ),
      ],
    ),
    child: const Center(
      child: Text(
        'N',
        style: TextStyle(
          color: cFlagBlack,
          fontWeight: FontWeight.w900,
          fontSize: 20,
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
                  Text('COMPASS CINNABAR', style: kTitleStyle),
                  SizedBox(height: 6),
                  Text(
                    'A navigator\'s walkthrough of Scaffold\'s advanced slots: '
                    'appBar, drawer, endDrawer, bottomNavigationBar, '
                    'bottomSheet, floatingActionButton, persistentFooterButtons '
                    'and the body-extension toggles. Each section is a chart '
                    'unrolled on a workshop table.',
                    style: kSubtitleStyle,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            compassRose,
          ],
        ),
        const SizedBox(height: 14),
        const Text(
          'PALETTE',
          style: TextStyle(
            color: cBrass,
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
      ],
    ),
  );
}

// ===========================================================================
//  SECTION 2 --- Prose anatomy of Scaffold
// ===========================================================================

Widget _buildAnatomySection() {
  print(' Building Section 2: prose anatomy.');
  // A parchment-coloured prose card with a cinnabar gutter and a brass border.
  final BoxDecoration proseDeco = BoxDecoration(
    color: cParchment,
    borderRadius: BorderRadius.circular(10),
    border: Border.all(color: cBrassDeep, width: 1),
    boxShadow: <BoxShadow>[
      BoxShadow(
        color: cFlagBlack.withValues(alpha: 0.18),
        blurRadius: 6,
        offset: const Offset(0, 3),
      ),
    ],
  );

  return Container(
    decoration: proseDeco,
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        Text('1. WHAT IS Scaffold?', style: kSectionHeaderStyle),
        SizedBox(height: 10),
        Text(
          'Scaffold is the visual chassis of a Material app screen. It is a '
          'StatefulWidget that lays out a fixed set of "page slots" --- '
          'regions of the screen, each named --- and then provides a body '
          'in the middle that is sized to fit whatever is left. Think of '
          'Scaffold as the room itself: the appBar is the lintel above the '
          'door, the drawer is a panel that slides in from the wall, the '
          'bottomNavigationBar is a baseboard along the floor, and the body '
          'is everything in between.',
          style: kSectionLeadStyle,
        ),
        SizedBox(height: 12),
        Text('THE EIGHT NAMED SLOTS', style: kSmallLabelStyle),
        SizedBox(height: 6),
        Text(
          '   1. appBar                    --- top edge, hosts a PreferredSize widget\n'
          '   2. body                       --- centre, sized by what is left\n'
          '   3. drawer                     --- slides from the leading (left) edge\n'
          '   4. endDrawer                  --- slides from the trailing (right) edge\n'
          '   5. bottomNavigationBar        --- pinned to the bottom edge\n'
          '   6. bottomSheet                --- hovers above the bottom nav\n'
          '   7. floatingActionButton       --- attached to the body edge\n'
          '   8. persistentFooterButtons    --- a row pinned just above the bottom nav\n'
          '\n'
          'These slots are each a single Widget? property on the Scaffold, '
          'and they each have a sensible default of `null`. Pass only the '
          'ones you need; the rest collapse to zero space.',
          style: kBodyStyle,
        ),
        SizedBox(height: 12),
        Text('THE FOUR BEHAVIOUR TOGGLES', style: kSmallLabelStyle),
        SizedBox(height: 6),
        Text(
          '   * extendBody                  --- body extends DOWN under the\n'
          '                                     bottom nav (useful with translucent\n'
          '                                     navs or images that should bleed)\n'
          '   * extendBodyBehindAppBar      --- body extends UP under the app bar\n'
          '                                     (useful with a translucent app bar\n'
          '                                     or a hero image at the top)\n'
          '   * resizeToAvoidBottomInset    --- when the soft keyboard appears, the\n'
          '                                     body is resized (default: true)\n'
          '   * backgroundColor             --- the canvas colour BEHIND the body\n'
          '                                     (visible only where the body is\n'
          '                                     transparent or where extendBody*\n'
          '                                     reveals it)\n'
          '\n'
          'These are pure layout/visual switches. They never call Scaffold.of(); '
          'they are just properties on the Scaffold widget itself.',
          style: kBodyStyle,
        ),
        SizedBox(height: 12),
        Text('A TYPICAL TREE', style: kSmallLabelStyle),
        SizedBox(height: 6),
        Text(
          '   MaterialApp\n'
          '      home: Scaffold(\n'
          '         appBar: AppBar(title: Text(\'Charts\')),\n'
          '         drawer: Drawer(child: ...),\n'
          '         endDrawer: Drawer(child: ...),\n'
          '         body: SafeArea(child: chartList),\n'
          '         bottomNavigationBar: BottomNavigationBar(...),\n'
          '         floatingActionButton: FloatingActionButton(...),\n'
          '         floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,\n'
          '         persistentFooterButtons: [TextButton(...), TextButton(...)],\n'
          '         extendBody: false,\n'
          '         extendBodyBehindAppBar: false,\n'
          '         resizeToAvoidBottomInset: true,\n'
          '         backgroundColor: const Color(0xFFEFE4CC),\n'
          '      ),\n'
          '\n'
          'Read it top-to-bottom and you have a complete spec for a Material '
          'screen.',
          style: kBodyStyle,
        ),
      ],
    ),
  );
}

// ===========================================================================
//  SECTION 3 --- Slot map: the eight named drawers of a Scaffold
// ===========================================================================

Widget _buildSlotMap() {
  print(' Building Section 3: slot map.');
  // A diagrammatic Stack illustrating where each named slot lives in the
  // physical screen rectangle. We label each region in cinnabar.
  final Widget diagram = Container(
    width: 320,
    height: 360,
    decoration: BoxDecoration(
      color: cChartOff,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: cBrassDeep, width: 1),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: cFlagBlack.withValues(alpha: 0.2),
          blurRadius: 6,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Stack(
        children: <Widget>[
          // Body region (background)
          Positioned.fill(
            child: Container(color: cParchment),
          ),
          // App bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 36,
              decoration: const BoxDecoration(
                color: cCinnabar,
                border: Border(
                  bottom: BorderSide(color: cBrass, width: 2),
                ),
              ),
              alignment: Alignment.center,
              child: const Text('appBar', style: kMiniAppBarStyle),
            ),
          ),
          // Drawer hint (leading edge)
          Positioned(
            top: 36,
            left: 0,
            bottom: 80,
            child: Container(
              width: 22,
              decoration: BoxDecoration(
                color: cWalnutMid.withValues(alpha: 0.85),
                border: const Border(
                  right: BorderSide(color: cBrass, width: 1),
                ),
              ),
              child: const RotatedBox(
                quarterTurns: 3,
                child: Center(
                  child: Text(
                    'drawer',
                    style: TextStyle(
                      color: cParchment,
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // EndDrawer hint (trailing edge)
          Positioned(
            top: 36,
            right: 0,
            bottom: 80,
            child: Container(
              width: 22,
              decoration: BoxDecoration(
                color: cWalnutMid.withValues(alpha: 0.85),
                border: const Border(
                  left: BorderSide(color: cBrass, width: 1),
                ),
              ),
              child: const RotatedBox(
                quarterTurns: 1,
                child: Center(
                  child: Text(
                    'endDrawer',
                    style: TextStyle(
                      color: cParchment,
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Body label, centred
          Positioned(
            left: 36,
            right: 36,
            top: 60,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
              decoration: BoxDecoration(
                color: cParchmentDim,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: cBrassDeep),
              ),
              child: const Text(
                'body\n(receives whatever space is left after\nthe other slots have taken theirs)',
                style: kMiniBodyStyle,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          // Persistent footer buttons (above bottom nav)
          Positioned(
            left: 36,
            right: 36,
            bottom: 60,
            child: Container(
              height: 22,
              decoration: BoxDecoration(
                color: cParchment,
                border: Border.all(color: cCinnabar.withValues(alpha: 0.7)),
                borderRadius: BorderRadius.circular(2),
              ),
              alignment: Alignment.center,
              child: const Text(
                'persistentFooterButtons',
                style: TextStyle(
                  fontSize: 9,
                  color: cCinnabarDeep,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          // Bottom nav bar
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 36,
              decoration: const BoxDecoration(
                color: cCharcoal,
                border: Border(
                  top: BorderSide(color: cBrass, width: 2),
                ),
              ),
              alignment: Alignment.center,
              child: const Text(
                'bottomNavigationBar',
                style: kMiniAppBarStyle,
              ),
            ),
          ),
          // Bottom sheet hint (just above the bottom nav)
          Positioned(
            left: 60,
            right: 60,
            bottom: 36,
            child: Container(
              height: 22,
              decoration: BoxDecoration(
                color: cParchment,
                border: Border.all(color: cBrassDeep),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(8),
                ),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: cFlagBlack.withValues(alpha: 0.25),
                    blurRadius: 4,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: const Text(
                'bottomSheet',
                style: TextStyle(
                  fontSize: 9,
                  color: cInk,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          // FAB (anchored at endFloat)
          Positioned(
            right: 30,
            bottom: 78,
            child: Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: cCinnabar,
                border: Border.all(color: cBrass, width: 1),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: cFlagBlack.withValues(alpha: 0.5),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(Icons.add, size: 16, color: cParchment),
            ),
          ),
        ],
      ),
    ),
  );

  // The legend on the right.
  final Widget legend = Container(
    width: 320,
    decoration: BoxDecoration(
      color: cParchment,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: cBrassDeep),
    ),
    padding: const EdgeInsets.all(12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('LEGEND', style: kSmallLabelStyle),
        const SizedBox(height: 6),
        _legendRow(cCinnabar, 'appBar', 'PreferredSize widget pinned to top'),
        _legendRow(cWalnutMid, 'drawer', 'Slides in from the leading edge'),
        _legendRow(cWalnutMid, 'endDrawer', 'Slides in from the trailing edge'),
        _legendRow(cParchmentDim, 'body', 'Centre region, what is left'),
        _legendRow(cParchment, 'bottomSheet', 'Hovers above the bottom nav'),
        _legendRow(cParchment, 'persistentFooterButtons', 'Row above bottom nav'),
        _legendRow(cCharcoal, 'bottomNavigationBar', 'Pinned to bottom edge'),
        _legendRow(cCinnabar, 'floatingActionButton', 'Attached to body edge'),
      ],
    ),
  );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _buildSectionHeader('3. Slot map --- the eight named drawers'),
      const SizedBox(height: 8),
      Wrap(
        spacing: 18,
        runSpacing: 18,
        children: <Widget>[diagram, legend],
      ),
    ],
  );
}

Widget _legendRow(Color swatch, String name, String desc) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 12,
          height: 12,
          margin: const EdgeInsets.only(top: 2, right: 8),
          decoration: BoxDecoration(
            color: swatch,
            borderRadius: BorderRadius.circular(2),
            border: Border.all(color: cInk.withValues(alpha: 0.6)),
          ),
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 11, color: cInk),
              children: <TextSpan>[
                TextSpan(
                  text: name,
                  style: const TextStyle(fontWeight: FontWeight.w800),
                ),
                const TextSpan(text: ' --- '),
                TextSpan(text: desc),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
//  Mini-Scaffold building blocks
// ===========================================================================
//  Each mini-Scaffold is a SizedBox+Material+ClipRRect viewport that
//  contains a real (small) Scaffold. Because Scaffold itself wants
//  Directionality + MediaQuery, we wrap our miniature in a MediaQuery so
//  the soft-keyboard / safe-area defaults don't trip on the tiny size.
//  We render at 240x240 pixels.
// ---------------------------------------------------------------------------

Widget _miniViewport(Scaffold scaffold, {double width = 280, double height = 280}) {
  // The frame around each mini-scaffold: walnut wood with a brass rim.
  final BoxDecoration frameDeco = BoxDecoration(
    color: cWalnutMid,
    borderRadius: BorderRadius.circular(10),
    border: Border.all(color: cBrass, width: 2),
    boxShadow: <BoxShadow>[
      BoxShadow(
        color: cFlagBlack.withValues(alpha: 0.45),
        blurRadius: 8,
        offset: const Offset(0, 4),
      ),
    ],
  );
  return Container(
    decoration: frameDeco,
    padding: const EdgeInsets.all(6),
    child: SizedBox(
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: MediaQuery(
          data: const MediaQueryData(),
          child: Material(
            color: cParchmentDim,
            child: scaffold,
          ),
        ),
      ),
    ),
  );
}

// A small caption that lives next to or under a mini viewport.
Widget _miniCaption(String title, String body, {double width = 280}) {
  final BoxDecoration captionDeco = BoxDecoration(
    color: cParchment,
    borderRadius: BorderRadius.circular(8),
    border: Border.all(color: cBrassDeep),
  );
  return Container(
    width: width,
    decoration: captionDeco,
    padding: const EdgeInsets.all(10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(title, style: kSmallLabelStyle),
        const SizedBox(height: 4),
        Text(body, style: kBodyStyle),
      ],
    ),
  );
}

// A reusable mini-AppBar appropriate for our 280-wide miniature.
PreferredSizeWidget _miniAppBar(String title, {bool translucent = false, bool withMenu = true, bool withTrailing = false}) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(28),
    child: Container(
      decoration: BoxDecoration(
        color: translucent ? cCinnabar.withValues(alpha: 0.55) : cCinnabar,
        border: const Border(
          bottom: BorderSide(color: cBrass, width: 1),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Row(
        children: <Widget>[
          if (withMenu) _miniIcon(Icons.menu, size: 14),
          if (withMenu) const SizedBox(width: 6),
          Expanded(child: Text(title, style: kMiniAppBarStyle)),
          if (withTrailing) _miniIcon(Icons.more_vert, size: 14),
        ],
      ),
    ),
  );
}

// A mini bottom nav strip (NOT a real BottomNavigationBar widget --- that
// requires too much space at this scale). We emulate the visual.
Widget _miniBottomNav({Color color = cCharcoal}) {
  return Container(
    height: 32,
    decoration: BoxDecoration(
      color: color,
      border: const Border(top: BorderSide(color: cBrass, width: 1)),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        _miniNavItem(Icons.map, 'Charts', selected: true),
        _miniNavItem(Icons.explore, 'Routes'),
        _miniNavItem(Icons.anchor, 'Ports'),
        _miniNavItem(Icons.settings, 'Tools'),
      ],
    ),
  );
}

Widget _miniNavItem(IconData icon, String label, {bool selected = false}) {
  final Color c = selected ? cLampGlow : cParchmentDim;
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Icon(icon, size: 14, color: c),
      Text(
        label,
        style: TextStyle(
          fontSize: 8,
          color: c,
          fontWeight: selected ? FontWeight.w800 : FontWeight.w400,
        ),
      ),
    ],
  );
}

// A mini chart-grid that pretends to be the body content of each mini.
Widget _miniChartBody({String label = 'CHART OF THE EASTERN APPROACHES', Color sea = cSeaPale}) {
  return Container(
    color: cParchment,
    padding: const EdgeInsets.all(6),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.w800,
            color: cInk,
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: 4),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: sea,
              border: Border.all(color: cBrassDeep),
              borderRadius: BorderRadius.circular(3),
            ),
            child: Stack(
              children: <Widget>[
                // Land mass (a moss-coloured blob)
                Positioned(
                  left: 14,
                  top: 14,
                  child: Container(
                    width: 60,
                    height: 38,
                    decoration: BoxDecoration(
                      color: cMossGreen,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: cInk),
                    ),
                  ),
                ),
                // A rhumb line in cinnabar
                Positioned(
                  left: 8,
                  top: 8,
                  right: 8,
                  bottom: 8,
                  child: CustomPaint(
                    painter: _RhumbLinePainter(),
                  ),
                ),
                // Latitude label
                const Positioned(
                  right: 4,
                  top: 4,
                  child: Text(
                    '50N',
                    style: TextStyle(
                      fontSize: 8,
                      color: cInk,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                // Longitude label
                const Positioned(
                  left: 4,
                  bottom: 4,
                  child: Text(
                    '5W',
                    style: TextStyle(
                      fontSize: 8,
                      color: cInk,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

// A custom painter for the rhumb line in cinnabar.
class _RhumbLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint p = Paint()
      ..color = cCinnabar
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;
    canvas.drawLine(Offset(size.width * 0.15, size.height * 0.85),
        Offset(size.width * 0.85, size.height * 0.15), p);
    final Paint dot = Paint()..color = cCinnabarDeep;
    canvas.drawCircle(
        Offset(size.width * 0.15, size.height * 0.85), 2, dot);
    canvas.drawCircle(
        Offset(size.width * 0.85, size.height * 0.15), 2, dot);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// A mini-Drawer panel we can insert as a Scaffold.drawer / endDrawer.
Widget _miniDrawer(String title, {required bool isEnd}) {
  return Drawer(
    width: 110,
    backgroundColor: cWalnutDark,
    shape: RoundedRectangleBorder(
      borderRadius: isEnd
          ? const BorderRadius.only(
              topLeft: Radius.circular(8),
              bottomLeft: Radius.circular(8),
            )
          : const BorderRadius.only(
              topRight: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
    ),
    child: Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              color: cBrass,
              fontWeight: FontWeight.w800,
              fontSize: 10,
              letterSpacing: 0.6,
            ),
          ),
          const SizedBox(height: 6),
          _drawerItem(Icons.map, 'Atlas'),
          _drawerItem(Icons.bookmark, 'Saved'),
          _drawerItem(Icons.compare_arrows, 'Routes'),
          _drawerItem(Icons.settings, 'Tools'),
        ],
      ),
    ),
  );
}

Widget _drawerItem(IconData icon, String label) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      children: <Widget>[
        Icon(icon, size: 12, color: cParchmentDim),
        const SizedBox(width: 6),
        Text(label,
            style: const TextStyle(color: cParchmentDim, fontSize: 9)),
      ],
    ),
  );
}

// ===========================================================================
//  SECTION 4 --- Mini-Scaffold A : appBar + body
// ===========================================================================

Widget _buildMiniA() {
  print(' Building Section 4: mini-Scaffold A.');
  // The simplest non-trivial Scaffold: a body and a Material AppBar.
  // No FAB, no drawer, no bottom nav. The body fills the entire space
  // beneath the AppBar.
  final Scaffold mini = Scaffold(
    backgroundColor: cParchmentDim,
    appBar: _miniAppBar('CHART ROOM', withTrailing: true),
    body: _miniChartBody(label: 'EASTERN APPROACHES'),
  );

  return Wrap(
    spacing: 18,
    runSpacing: 18,
    crossAxisAlignment: WrapCrossAlignment.start,
    children: <Widget>[
      _miniViewport(mini),
      _miniCaption(
        'A. appBar + body (the minimum)',
        'A Scaffold with only an appBar and a body is the workhorse of '
        'Material screens. The body is sized to whatever is left after '
        'the AppBar takes its preferred height. No drawer means no menu '
        'icon is auto-injected; you can still add one manually if the '
        'screen pushes a route that wants one.',
      ),
    ],
  );
}

// ===========================================================================
//  SECTION 5 --- Mini-Scaffold B : appBar + body + bottomNav
// ===========================================================================

Widget _buildMiniB() {
  print(' Building Section 5: mini-Scaffold B.');
  // Add a BottomNavigationBar. Note: the body is now sized in the gap
  // between the AppBar and the bottom nav. The bottom nav is pinned to
  // the bottom edge --- it never scrolls with the body.
  final Scaffold mini = Scaffold(
    backgroundColor: cParchmentDim,
    appBar: _miniAppBar('NAVIGATION'),
    body: _miniChartBody(label: 'WESTERN APPROACHES', sea: cSeaPale),
    bottomNavigationBar: _miniBottomNav(),
  );

  return Wrap(
    spacing: 18,
    runSpacing: 18,
    crossAxisAlignment: WrapCrossAlignment.start,
    children: <Widget>[
      _miniViewport(mini),
      _miniCaption(
        'B. appBar + body + bottomNavigationBar',
        'Adding a bottomNavigationBar pins a strip of icon-buttons at the '
        'foot of the screen. The body is pressed up by the bar\'s '
        'preferred height. The bar is OPAQUE by default; if you want the '
        'body to draw under it (for translucent navs or blurred-glass '
        'effects), set extendBody: true. Demonstrated in section 10.',
      ),
    ],
  );
}

// ===========================================================================
//  SECTION 6 --- Mini-Scaffold C : appBar + body + FAB + endDrawer hint
// ===========================================================================

Widget _buildMiniC() {
  print(' Building Section 6: mini-Scaffold C.');
  // A real FAB attached at endFloat. We do NOT actually open the
  // endDrawer (no Scaffold.of), but we can still ASSIGN a Drawer to the
  // endDrawer slot --- it just won't be visible at rest. To make the
  // concept visible, we draw a hint glyph at the trailing edge.
  final Scaffold mini = Scaffold(
    backgroundColor: cParchmentDim,
    appBar: _miniAppBar('LOG-BOOK', withTrailing: true),
    body: Stack(
      children: <Widget>[
        _miniChartBody(label: 'NORTH SEA'),
        // Static hint that the endDrawer EXISTS (for the reader's sake).
        Positioned(
          right: 0,
          top: 0,
          bottom: 0,
          child: Container(
            width: 14,
            decoration: BoxDecoration(
              color: cWalnutMid.withValues(alpha: 0.35),
              border: const Border(
                left: BorderSide(color: cBrass, width: 1),
              ),
            ),
            child: const RotatedBox(
              quarterTurns: 1,
              child: Center(
                child: Text(
                  'endDrawer waits here',
                  style: TextStyle(
                    color: cInk,
                    fontSize: 8,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
    endDrawer: _miniDrawer('TOOLS', isEnd: true),
    floatingActionButton: FloatingActionButton(
      onPressed: () {},
      backgroundColor: cCinnabar,
      foregroundColor: cParchment,
      mini: true,
      child: const Icon(Icons.edit),
    ),
    floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
  );

  return Wrap(
    spacing: 18,
    runSpacing: 18,
    crossAxisAlignment: WrapCrossAlignment.start,
    children: <Widget>[
      _miniViewport(mini),
      _miniCaption(
        'C. FAB + endDrawer hint',
        'A FloatingActionButton is "attached" to the body. Its position '
        'is decided by floatingActionButtonLocation, NOT by the body. '
        'The endDrawer exists as a property even when not visible; it is '
        'invoked via Scaffold.of(context).openEndDrawer() at runtime '
        '(out of scope for this static demo, so we draw a hint).',
      ),
    ],
  );
}

// ===========================================================================
//  SECTION 7 --- Mini-Scaffold D : extendBodyBehindAppBar
// ===========================================================================

Widget _buildMiniD() {
  print(' Building Section 7: mini-Scaffold D.');
  // extendBodyBehindAppBar lets the body draw UP behind the AppBar. We
  // use a translucent AppBar so you can see the chart bleed up through
  // the AppBar area. This pattern is used for hero images and for
  // glass-blur effects.
  final Scaffold mini = Scaffold(
    backgroundColor: cParchmentDim,
    extendBodyBehindAppBar: true,
    appBar: _miniAppBar('HORIZON', translucent: true),
    body: Stack(
      children: <Widget>[
        Positioned.fill(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[cLampGlow, cCinnabar, cCinnabarDeep, cWalnutDark],
                stops: <double>[0.0, 0.35, 0.65, 1.0],
              ),
            ),
          ),
        ),
        Center(
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: cFlagBlack.withValues(alpha: 0.45),
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Text(
              'HERO SUNSET',
              style: TextStyle(
                color: cParchment,
                fontWeight: FontWeight.w800,
                fontSize: 12,
                letterSpacing: 1.2,
              ),
            ),
          ),
        ),
      ],
    ),
  );

  return Wrap(
    spacing: 18,
    runSpacing: 18,
    crossAxisAlignment: WrapCrossAlignment.start,
    children: <Widget>[
      _miniViewport(mini),
      _miniCaption(
        'D. extendBodyBehindAppBar',
        'When extendBodyBehindAppBar is true, the body is laid out as if '
        'the AppBar were not there. The AppBar paints OVER the top of '
        'the body. With a translucent AppBar colour you get a glass '
        'effect; with an opaque AppBar you get nothing visible (don\'t '
        'do that --- you would just be wasting layout). Best paired '
        'with a hero image or a gradient that should bleed to the top.',
      ),
    ],
  );
}

// ===========================================================================
//  SECTION 8 --- Mini-Scaffold E : persistentFooterButtons + bottomSheet hint
// ===========================================================================

Widget _buildMiniE() {
  print(' Building Section 8: mini-Scaffold E.');
  // We stack persistentFooterButtons above a bottomNavigationBar, with a
  // hovering bottomSheet hint just above the buttons. The order from
  // bottom up is: bottomNav, persistentFooterButtons, bottomSheet, body.
  final Scaffold mini = Scaffold(
    backgroundColor: cParchmentDim,
    appBar: _miniAppBar('VOYAGE PLANNER'),
    body: _miniChartBody(label: 'PASSAGE PLAN'),
    persistentFooterButtons: <Widget>[
      TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          foregroundColor: cCinnabarDeep,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          minimumSize: const Size(0, 24),
        ),
        child: const Text('CANCEL', style: TextStyle(fontSize: 10)),
      ),
      TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          foregroundColor: cMossGreen,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          minimumSize: const Size(0, 24),
        ),
        child: const Text('SAVE', style: TextStyle(fontSize: 10)),
      ),
    ],
    bottomNavigationBar: _miniBottomNav(),
    bottomSheet: Container(
      height: 38,
      decoration: BoxDecoration(
        color: cParchment,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
        border: Border.all(color: cBrassDeep),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: cFlagBlack.withValues(alpha: 0.3),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: const Text(
        'bottomSheet --- weather advisory',
        style: TextStyle(
          fontSize: 9,
          color: cInk,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
  );

  return Wrap(
    spacing: 18,
    runSpacing: 18,
    crossAxisAlignment: WrapCrossAlignment.start,
    children: <Widget>[
      _miniViewport(mini, height: 320),
      _miniCaption(
        'E. footer buttons + bottomSheet',
        'persistentFooterButtons is a thin row of TextButtons pinned just '
        'above the bottomNav. It is great for "Cancel / Save" pairs that '
        'should always be reachable. A bottomSheet is a panel that hovers '
        'just above the persistentFooterButtons (or directly above the '
        'nav if there are none). When all four are present the foot of '
        'the screen layers up: nav, buttons, sheet, body.',
      ),
    ],
  );
}

// ===========================================================================
//  SECTION 9 --- FloatingActionButtonLocation atlas
// ===========================================================================

Widget _buildFabAtlas() {
  print(' Building Section 9: FAB location atlas.');
  // We render six tiny scaffolds, each with the FAB at a different
  // location. Six different locations is enough to ground the reader's
  // mental model.
  final List<Map<String, Object>> entries = <Map<String, Object>>[
    {'label': 'startTop', 'loc': FloatingActionButtonLocation.startTop},
    {'label': 'centerTop', 'loc': FloatingActionButtonLocation.centerTop},
    {'label': 'endTop', 'loc': FloatingActionButtonLocation.endTop},
    {'label': 'startFloat', 'loc': FloatingActionButtonLocation.startFloat},
    {'label': 'centerFloat', 'loc': FloatingActionButtonLocation.centerFloat},
    {'label': 'endFloat', 'loc': FloatingActionButtonLocation.endFloat},
    {'label': 'startDocked', 'loc': FloatingActionButtonLocation.startDocked},
    {'label': 'centerDocked', 'loc': FloatingActionButtonLocation.centerDocked},
    {'label': 'endDocked', 'loc': FloatingActionButtonLocation.endDocked},
  ];

  final List<Widget> tiles = <Widget>[];
  for (int i = 0; i < entries.length; i++) {
    final entry = entries[i];
    final label = entry['label'] as String;
    final loc = entry['loc'] as FloatingActionButtonLocation;

    final Scaffold mini = Scaffold(
      backgroundColor: cParchmentDim,
      appBar: _miniAppBar('AT $label', withMenu: false),
      body: Container(
        color: cParchment,
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 9,
              color: cInk,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
      bottomNavigationBar: _miniBottomNav(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: cCinnabar,
        foregroundColor: cParchment,
        mini: true,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: loc,
    );

    tiles.add(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _miniViewport(mini, width: 200, height: 220),
          const SizedBox(height: 4),
          SizedBox(
            width: 210,
            child: Text(label, style: kMiniLabelStyle),
          ),
        ],
      ),
    );
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      const Text(
        'There are nine standard FloatingActionButtonLocation values. They '
        'split into three tiers (top / float / docked) crossed with three '
        'sides (start / center / end). "Docked" notches into the bottomNav '
        'when one is present; "float" sits above it; "top" pins to the '
        'app-bar edge instead.',
        style: kBodyStyle,
      ),
      const SizedBox(height: 12),
      Wrap(spacing: 14, runSpacing: 18, children: tiles),
    ],
  );
}

// ===========================================================================
//  SECTION 10 --- extendBody / extendBodyBehindAppBar comparison
// ===========================================================================

Widget _buildExtendBodyComparison() {
  print(' Building Section 10: extendBody comparison.');
  // We render four tiny scaffolds on a 2x2 grid with each combination of
  // (extendBody, extendBodyBehindAppBar). Each body is a coloured
  // gradient so we can see whether it bleeds under the chrome.
  final List<Map<String, Object>> matrix = <Map<String, Object>>[
    {'eb': false, 'ebbab': false, 'label': 'eb=F   ebbab=F'},
    {'eb': true, 'ebbab': false, 'label': 'eb=T   ebbab=F'},
    {'eb': false, 'ebbab': true, 'label': 'eb=F   ebbab=T'},
    {'eb': true, 'ebbab': true, 'label': 'eb=T   ebbab=T'},
  ];

  final List<Widget> tiles = <Widget>[];
  for (int i = 0; i < matrix.length; i++) {
    final m = matrix[i];
    final eb = m['eb'] as bool;
    final ebbab = m['ebbab'] as bool;
    final label = m['label'] as String;

    final Scaffold mini = Scaffold(
      backgroundColor: cWalnutDark,
      extendBody: eb,
      extendBodyBehindAppBar: ebbab,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(28),
        child: Container(
          color: cCinnabar.withValues(alpha: 0.55),
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: const Text('translucent appBar', style: kMiniAppBarStyle),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[cLampGlow, cCinnabar, cCinnabarDeep, cInk],
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 9,
              color: cParchment,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 28,
        color: cCharcoal.withValues(alpha: 0.55),
        alignment: Alignment.center,
        child: const Text(
          'translucent nav',
          style: TextStyle(
            color: cParchmentDim,
            fontSize: 9,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );

    tiles.add(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _miniViewport(mini, width: 200, height: 220),
          const SizedBox(height: 4),
          SizedBox(
            width: 210,
            child: Text(label, style: kMiniLabelStyle),
          ),
        ],
      ),
    );
  }

  // Caption block to the right of the 2x2 grid.
  final Widget caption = SizedBox(
    width: 320,
    child: Container(
      decoration: BoxDecoration(
        color: cParchment,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: cBrassDeep),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          Text('READING THE GRID', style: kSmallLabelStyle),
          SizedBox(height: 6),
          Text(
            'In each tile the AppBar and BottomNav are 55% translucent. The '
            'body is a vertical gradient that goes lampGlow -> cinnabar -> '
            'ink. Where you see the gradient under the bars, the body is '
            'extending behind. Where you see flat solid colour under the '
            'bars, the body has been clipped.\n\n'
            '   eb=F  ebbab=F : default; body sits between the bars\n'
            '   eb=T  ebbab=F : body bleeds DOWN under bottomNav\n'
            '   eb=F  ebbab=T : body bleeds UP under appBar\n'
            '   eb=T  ebbab=T : body fills the whole frame; chrome floats',
            style: kBodyStyle,
          ),
        ],
      ),
    ),
  );

  return Wrap(
    spacing: 18,
    runSpacing: 18,
    crossAxisAlignment: WrapCrossAlignment.start,
    children: <Widget>[
      Wrap(
        spacing: 14,
        runSpacing: 14,
        children: tiles,
      ),
      caption,
    ],
  );
}

// ===========================================================================
//  SECTION 11 --- resizeToAvoidBottomInset comparison
// ===========================================================================

Widget _buildResizeComparison() {
  print(' Building Section 11: resizeToAvoidBottomInset.');
  // We can't actually summon the soft keyboard, so we explain via a
  // diagram pair: one labelled "true" with a smaller body region and
  // a labelled keyboard region; one labelled "false" with the body
  // covered by the keyboard.
  Widget sketch(bool resize) {
    return Container(
      width: 220,
      height: 240,
      decoration: BoxDecoration(
        color: cParchment,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: cBrassDeep),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'resizeToAvoidBottomInset = $resize',
            style: kSmallLabelStyle,
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Stack(
                children: <Widget>[
                  // app bar
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 22,
                      color: cCinnabar,
                      alignment: Alignment.center,
                      child: const Text('appBar', style: kMiniAppBarStyle),
                    ),
                  ),
                  // body
                  Positioned(
                    top: 22,
                    left: 0,
                    right: 0,
                    bottom: resize ? 80 : 0,
                    child: Container(
                      color: cParchmentDim,
                      alignment: Alignment.center,
                      child: const Text(
                        'body\n(text field here)',
                        style: kMiniBodyStyle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  // soft keyboard
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 80,
                      decoration: BoxDecoration(
                        color: cWalnutMid.withValues(
                            alpha: resize ? 1.0 : 0.85),
                        border: const Border(
                          top: BorderSide(color: cBrass, width: 1),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        'soft keyboard',
                        style: TextStyle(
                          color: cParchment,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            resize
                ? 'Body shrinks to leave room for the keyboard. A focused '
                    'TextField stays visible.'
                : 'Body keeps its full size; the keyboard COVERS the lower '
                    'half. A focused TextField may be hidden.',
            style: const TextStyle(fontSize: 10, color: cInk, height: 1.3),
          ),
        ],
      ),
    );
  }

  return Wrap(
    spacing: 16,
    runSpacing: 16,
    crossAxisAlignment: WrapCrossAlignment.start,
    children: <Widget>[
      sketch(true),
      sketch(false),
      SizedBox(
        width: 320,
        child: Container(
          decoration: BoxDecoration(
            color: cParchment,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: cBrassDeep),
          ),
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              Text('THE DEFAULT IS TRUE', style: kSmallLabelStyle),
              SizedBox(height: 6),
              Text(
                'You almost never need to flip resizeToAvoidBottomInset off. '
                'The single case is a full-bleed background image (think '
                'sign-in screen) where you would rather have the keyboard '
                'cover the picture than have the picture squashed. In that '
                'one case set it to false AND wrap the form in a '
                'SingleChildScrollView so the user can still scroll the '
                'focused field into view.',
                style: kBodyStyle,
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

// ===========================================================================
//  SECTION 12 --- DO / AVOID callouts
// ===========================================================================

Widget _buildDoAvoidCallouts() {
  print(' Building Section 12: DO / AVOID callouts.');
  final List<Map<String, String>> rules = <Map<String, String>>[
    {
      'kind': 'DO',
      'rule':
          'Pass exactly the slots you need. Every named slot has a sensible '
              'null default; passing null collapses the slot to zero space.',
    },
    {
      'kind': 'AVOID',
      'rule':
          'Putting business state inside the Scaffold and reaching for it '
              'from descendants. Lift state up to a Provider / Bloc / Riverpod '
              'scope that surrounds the Scaffold.',
    },
    {
      'kind': 'DO',
      'rule':
          'Use extendBodyBehindAppBar with a translucent AppBar to get a '
              'glass effect over a hero image. Pair with SafeArea inside '
              'the body so that text avoids the system status bar.',
    },
    {
      'kind': 'AVOID',
      'rule':
          'extendBodyBehindAppBar with an opaque AppBar. The body draws under '
              'the AppBar but the AppBar covers it: you have just spent a '
              'layout phase computing pixels nobody can see.',
    },
    {
      'kind': 'DO',
      'rule':
          'Use floatingActionButtonLocation: FloatingActionButtonLocation.endFloat '
              'as the default. It matches Material guidance and matches user '
              'thumb-reach on most phones.',
    },
    {
      'kind': 'AVOID',
      'rule':
          'Putting an icon and a FloatingActionButton at the same top-corner. '
              'Both will demand space at startTop / endTop and overlap.',
    },
    {
      'kind': 'DO',
      'rule':
          'Use persistentFooterButtons for Cancel / Save pairs that should '
              'never scroll away. They are pinned above the bottomNav and '
              'have generous tap targets.',
    },
    {
      'kind': 'AVOID',
      'rule':
          'Persistent footers with more than four items. The row scrolls '
              'horizontally on overflow but the discoverability is poor; '
              'use a bottom-sheet menu instead.',
    },
    {
      'kind': 'DO',
      'rule':
          'Trust the default resizeToAvoidBottomInset: true. The keyboard '
              'will cover the bottom inset and the body will resize. This '
              'keeps focused TextFields visible.',
    },
    {
      'kind': 'AVOID',
      'rule':
          'Setting resizeToAvoidBottomInset: false without compensating with '
              'a SingleChildScrollView. A focused TextField under the '
              'keyboard is unreachable and looks like a bug.',
    },
    {
      'kind': 'DO',
      'rule':
          'Set Scaffold.backgroundColor to your app theme\'s surface colour. '
              'It will show through whenever the body is transparent, '
              'including during page transitions.',
    },
    {
      'kind': 'AVOID',
      'rule':
          'Combining a coloured backgroundColor with a body that is its own '
              'opaque Container of a different colour. The Scaffold colour '
              'is wasted; either remove it or trim the body to its content.',
    },
    {
      'kind': 'DO',
      'rule':
          'Use endDrawer for screens with a primary drawer on the start side '
              '(navigation) AND a secondary one on the end side (filters, '
              'tools, history). Two drawers do not collide.',
    },
    {
      'kind': 'AVOID',
      'rule':
          'Stacking many BottomSheets. Scaffold owns ONE bottomSheet slot. '
              'Use showModalBottomSheet at runtime for transient sheets; '
              'reserve the slot for a persistent one.',
    },
  ];

  final List<Widget> tiles = <Widget>[];
  for (int i = 0; i < rules.length; i++) {
    final r = rules[i];
    final kind = r['kind']!;
    final rule = r['rule']!;
    final isDo = kind == 'DO';
    final BoxDecoration cardDeco = BoxDecoration(
      color: cParchment,
      borderRadius: BorderRadius.circular(8),
      border: Border(
        left: BorderSide(
          color: isDo ? cMossGreen : cCinnabar,
          width: 6,
        ),
        top: BorderSide(color: cBrassDeep.withValues(alpha: 0.4)),
        right: BorderSide(color: cBrassDeep.withValues(alpha: 0.4)),
        bottom: BorderSide(color: cBrassDeep.withValues(alpha: 0.4)),
      ),
    );
    tiles.add(
      Container(
        width: 320,
        decoration: cardDeco,
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              kind,
              style: isDo ? kCalloutDoStyle : kCalloutAvoidStyle,
            ),
            const SizedBox(height: 4),
            Text(rule, style: kBodyStyle),
          ],
        ),
      ),
    );
  }
  return Wrap(spacing: 10, runSpacing: 10, children: tiles);
}

// ===========================================================================
//  SECTION 13 --- Recipe cards
// ===========================================================================

Widget _buildRecipeCards() {
  print(' Building Section 13: recipe cards.');
  final List<Map<String, String>> recipes = <Map<String, String>>[
    {
      'title': 'Plain page (appBar + body)',
      'code': '''Scaffold(
  appBar: AppBar(title: const Text('Charts')),
  body: const SafeArea(child: ChartList()),
)''',
    },
    {
      'title': 'Bottom-tabbed page',
      'code': '''Scaffold(
  appBar: AppBar(title: const Text('Voyage')),
  body: const Center(child: Text('Body')),
  bottomNavigationBar: BottomNavigationBar(
    currentIndex: 0,
    items: const [
      BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Charts'),
      BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Routes'),
      BottomNavigationBarItem(icon: Icon(Icons.anchor), label: 'Ports'),
    ],
    onTap: (i) {},
  ),
)''',
    },
    {
      'title': 'FAB at endFloat',
      'code': '''Scaffold(
  appBar: AppBar(title: const Text('Log-book')),
  body: const Center(child: Text('Body')),
  floatingActionButton: FloatingActionButton(
    onPressed: () => Scaffold.of(context).openEndDrawer(),
    child: const Icon(Icons.edit),
  ),
  floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
  endDrawer: const Drawer(child: ToolPanel()),
)''',
    },
    {
      'title': 'Translucent app-bar hero',
      'code': '''Scaffold(
  extendBodyBehindAppBar: true,
  appBar: AppBar(
    backgroundColor: Colors.deepOrange.withValues(alpha: 0.55),
    elevation: 0,
    title: const Text('Horizon'),
  ),
  body: const HeroImage(),
)''',
    },
    {
      'title': 'Cancel / Save footer',
      'code': '''Scaffold(
  appBar: AppBar(title: const Text('Edit chart')),
  body: const ChartEditor(),
  persistentFooterButtons: [
    TextButton(onPressed: () {}, child: const Text('CANCEL')),
    TextButton(onPressed: () {}, child: const Text('SAVE')),
  ],
  bottomNavigationBar: BottomNavigationBar(items: const [...]),
)''',
    },
    {
      'title': 'Persistent bottom-sheet weather',
      'code': '''Scaffold(
  appBar: AppBar(title: const Text('Voyage planner')),
  body: const PassagePlan(),
  bottomSheet: Container(
    height: 56,
    color: Colors.amber.shade100,
    alignment: Alignment.center,
    child: const Text('Weather advisory'),
  ),
)''',
    },
    {
      'title': 'Two drawers',
      'code': '''Scaffold(
  appBar: AppBar(title: const Text('Atlas')),
  drawer: const Drawer(child: NavMenu()),
  endDrawer: const Drawer(child: ToolMenu()),
  body: const ChartView(),
)''',
    },
    {
      'title': 'Sign-in (no resize)',
      'code': '''Scaffold(
  resizeToAvoidBottomInset: false,
  body: SingleChildScrollView(
    child: Column(children: [
      const HeroImage(),
      SignInForm(),
    ]),
  ),
)''',
    },
  ];

  final List<Widget> cards = <Widget>[];
  for (int i = 0; i < recipes.length; i++) {
    final r = recipes[i];
    final BoxDecoration codeCardDeco = BoxDecoration(
      color: cWalnutDark,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: cBrass.withValues(alpha: 0.5)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: cFlagBlack.withValues(alpha: 0.4),
          blurRadius: 6,
          offset: const Offset(0, 4),
        ),
      ],
    );
    cards.add(
      Container(
        width: 380,
        decoration: codeCardDeco,
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              r['title']!,
              style: const TextStyle(
                color: cBrass,
                fontWeight: FontWeight.w800,
                fontSize: 13,
                letterSpacing: 0.6,
              ),
            ),
            const SizedBox(height: 6),
            Text(r['code']!, style: kCodeStyle),
          ],
        ),
      ),
    );
  }
  return Wrap(spacing: 10, runSpacing: 10, children: cards);
}

// ===========================================================================
//  SECTION 14 --- Glossary
// ===========================================================================

Widget _buildGlossary() {
  print(' Building Section 14: glossary.');
  final List<Map<String, String>> entries = <Map<String, String>>[
    {
      'term': 'Scaffold',
      'def': 'A Material chassis widget that lays out a fixed set of named '
          'page slots (appBar, body, drawer, etc.) and provides a body in '
          'the middle.',
    },
    {
      'term': 'appBar',
      'def': 'PreferredSizeWidget pinned to the top of the Scaffold. '
          'AppBar (a Material widget) is the most common choice but '
          'anything that returns a PreferredSize works.',
    },
    {
      'term': 'drawer / endDrawer',
      'def': 'Drawer widgets that slide in from the leading and trailing '
          'edges. A Scaffold may have one of each.',
    },
    {
      'term': 'body',
      'def': 'The main region of the screen, sized to whatever rectangle '
          'is left after the named slots have taken theirs.',
    },
    {
      'term': 'bottomNavigationBar',
      'def': 'A widget pinned to the bottom of the Scaffold. The '
          'BottomNavigationBar widget is typical but you can put any '
          'widget here (BottomAppBar, NavigationBar, custom).',
    },
    {
      'term': 'bottomSheet',
      'def': 'A persistent panel that hovers above the bottomNav. Distinct '
          'from showModalBottomSheet, which is transient and stacked on '
          'top of the entire app.',
    },
    {
      'term': 'floatingActionButton',
      'def': 'A high-emphasis action attached to the body edge. Its '
          'placement is governed by floatingActionButtonLocation.',
    },
    {
      'term': 'floatingActionButtonLocation',
      'def': 'A class that returns an Offset for the FAB given the layout '
          'geometry of the Scaffold. Standard values include endFloat, '
          'centerFloat, endDocked, etc.',
    },
    {
      'term': 'floatingActionButtonAnimator',
      'def': 'Controls how the FAB animates between locations. The default '
          'scales out and back in.',
    },
    {
      'term': 'persistentFooterButtons',
      'def': 'A row of TextButtons pinned just above the bottomNav. Used '
          'for "always reachable" actions (Cancel/Save).',
    },
    {
      'term': 'extendBody',
      'def': 'When true the body is laid out as if there were no '
          'bottomNav --- the body draws DOWN under the bar. Useful with '
          'translucent navs and bleed images.',
    },
    {
      'term': 'extendBodyBehindAppBar',
      'def': 'When true the body is laid out as if there were no AppBar --- '
          'the body draws UP under the bar. Useful with translucent app '
          'bars and hero images.',
    },
    {
      'term': 'resizeToAvoidBottomInset',
      'def': 'When true (default), the body is resized so it is not '
          'covered by the soft keyboard. Set false only with a deliberate '
          'plan for keeping focused fields visible.',
    },
    {
      'term': 'backgroundColor',
      'def': 'The colour of the canvas behind the Scaffold body. Visible '
          'wherever the body is transparent or where extendBody* exposes '
          'it under translucent chrome.',
    },
    {
      'term': 'primary',
      'def': 'When true (default) the Scaffold tells the AppBar to draw '
          'over the system status bar; pertinent on Android.',
    },
    {
      'term': 'drawerEdgeDragWidth',
      'def': 'How many logical pixels from the edge a horizontal drag '
          'must start, to count as a swipe-to-open of the drawer.',
    },
    {
      'term': 'drawerEnableOpenDragGesture',
      'def': 'When false the drawer can only be opened programmatically. '
          'Useful when the body wants horizontal swipes for something '
          'else (carousels).',
    },
    {
      'term': 'ScaffoldMessenger',
      'def': 'The static way to show SnackBars and MaterialBanners across '
          'multiple Scaffolds. Lives outside the Scaffold tree so '
          'messages survive page transitions.',
    },
  ];

  final List<Widget> tiles = <Widget>[];
  for (int i = 0; i < entries.length; i++) {
    final e = entries[i];
    final BoxDecoration tileDeco = BoxDecoration(
      color: cParchment,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: cBrassDeep.withValues(alpha: 0.6)),
    );
    tiles.add(
      Container(
        width: 320,
        decoration: tileDeco,
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              e['term']!,
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 12,
                color: cCinnabarDeep,
              ),
            ),
            const SizedBox(height: 4),
            Text(e['def']!, style: kBodyStyle),
          ],
        ),
      ),
    );
  }
  return Wrap(spacing: 10, runSpacing: 10, children: tiles);
}

// ===========================================================================
//  SECTION 15 --- Recap footer
// ===========================================================================

Widget _buildRecapFooter() {
  print(' Building Section 15: recap footer.');
  // Footer mirrors the title banner: walnut + cinnabar + brass.
  final BoxDecoration footerDeco = BoxDecoration(
    gradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[cCinnabarDeep, cWalnutMid, cWalnutDark],
    ),
    borderRadius: BorderRadius.circular(14),
    boxShadow: <BoxShadow>[
      BoxShadow(
        color: cFlagBlack.withValues(alpha: 0.5),
        blurRadius: 14,
        offset: const Offset(0, 8),
      ),
    ],
    border: Border.all(color: cBrass, width: 2),
  );

  return Container(
    decoration: footerDeco,
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        Text(
          'RECAP --- ROLLING UP THE CHART',
          style: TextStyle(
            color: cBrass,
            fontSize: 18,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.4,
          ),
        ),
        SizedBox(height: 10),
        Text(
          'Scaffold is the room.\n'
          'AppBar is the lintel.\n'
          'Drawer and EndDrawer are the wall panels.\n'
          'BottomNavigationBar is the baseboard.\n'
          'BottomSheet is the rolltop on the table.\n'
          'PersistentFooterButtons are the brass tacks on the bench.\n'
          'FloatingActionButton is the sextant on its hook.\n'
          'Body is the open chart on the table.\n'
          '\n'
          'Reach for extendBody when you want the chart to bleed under '
          'the baseboard. Reach for extendBodyBehindAppBar when you '
          'want it to bleed under the lintel. Trust '
          'resizeToAvoidBottomInset to handle the keyboard. Set the '
          'backgroundColor to match the room\'s walls. Then place each '
          'piece exactly where Material expects it --- and the room '
          'looks like a chart-table by lamplight, not a pile of widgets '
          'in a corner.',
          style: TextStyle(
            color: cParchment,
            fontSize: 12,
            height: 1.5,
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// END --- Scaffold (advanced) deep demo, "Compass Cinnabar" theme.
// =============================================================================
