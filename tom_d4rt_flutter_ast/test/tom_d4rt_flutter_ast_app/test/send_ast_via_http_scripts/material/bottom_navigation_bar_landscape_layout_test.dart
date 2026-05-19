// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, dead_code, unnecessary_this, avoid_print, deprecated_member_use, sort_child_properties_last
// =============================================================================
//          PIER CERULEAN  ---  BottomNavigationBarLandscapeLayout (enum)
// =============================================================================
//
//  TARGET ENUM ........ BottomNavigationBarLandscapeLayout
//                       (package:flutter/material.dart)
//
//  DECLARATION ........ enum BottomNavigationBarLandscapeLayout {
//                         spread,
//                         centered,
//                         linear,
//                       }
//
//  WHERE IT LIVES ..... BottomNavigationBar(
//                         landscapeLayout:
//                           BottomNavigationBarLandscapeLayout.spread,
//                         ...
//                       )
//
//  WHAT IT DOES ....... Controls how a BottomNavigationBar arranges its
//                       items WHEN the parent is in landscape orientation.
//                       In portrait, this property is ignored: items are
//                       always laid out as a Row of icon-above-label tiles
//                       distributed evenly. In landscape, the Material
//                       team faced a question: do you let the items spread
//                       across the wide bar, do you cluster them in the
//                       middle, or do you stretch each item into a
//                       horizontal "icon | label" pill? This enum picks
//                       which of those three behaviours wins.
//
//                         spread   -- items distributed evenly across the
//                                     full landscape width, icon ABOVE label,
//                                     just like portrait but stretched.
//                                     This is the DEFAULT.
//                         centered -- items grouped in the middle of the
//                                     bar, icon ABOVE label, with empty
//                                     padding either side. The bar still
//                                     fills the screen but the touch
//                                     targets are centred, like a tablet
//                                     dock.
//                         linear   -- each item becomes a Row of (icon,
//                                     label), and the items are
//                                     distributed evenly across the full
//                                     landscape width. The label sits
//                                     BESIDE the icon, not under it. This
//                                     is the most "wide-screen friendly"
//                                     option.
//
//  THEME .............. PIER CERULEAN
//
//                       A coastal boardwalk on a clear afternoon. Imagine
//                       a long wooden pier reaching out over deep ocean
//                       blue, the planks bleached to driftwood beige by
//                       sun and salt. Cerulean waves break beneath; coral
//                       buoys bob at the periphery. A row of weathered
//                       signposts marches down the centre line of the
//                       pier; a striped lifeguard stand sits at the
//                       seaward end. The whole demo treats the
//                       BottomNavigationBar as if it were a row of pier
//                       signposts laid flat: spread evenly, clustered at
//                       the centre, or stretched out shoulder to shoulder.
//
//                       Cerulean is the chrome. Driftwood is the page.
//                       Sun-coral is the accent. Brine is the deep ink.
//
//  WHAT WE EXPLORE
//
//      Section  1 .... Pier Cerulean title hero with palette swatches
//      Section  2 .... Prose anatomy of BottomNavigationBarLandscapeLayout
//      Section  3 .... Three-pier anatomy --- the three layouts side by side
//      Section  4 .... Spread layout deep dive
//      Section  5 .... Centered layout deep dive
//      Section  6 .... Linear layout deep dive
//      Section  7 .... Item-count grid (2..5 items x 3 layouts)
//      Section  8 .... Use-case cards (six realistic apps)
//      Section  9 .... Comparison table
//      Section 10 .... Type & default-behaviour table
//      Section 11 .... Anti-pattern gallery
//      Section 12 .... Glossary
//      Section 13 .... Closing essay
//      Section 14 .... Recap footer
//
//  WHAT WE DO NOT TOUCH
//
//      Real Scaffold + BottomNavigationBar mounted in landscape.
//        We cannot rotate the canvas inside this snapshot, so every
//        landscape strip is rendered as a 240-wide x 64-high Container
//        that mocks the real bar.
//      Tween, AnimationController, setState, Timer, Future, Stream.
//      Scaffold.of(context), MediaQuery.of(context).orientation, etc.
//
//  D4RT CONSTRAINTS
//
//      * build() is called exactly ONCE; we return a single static tree.
//      * No StatefulWidget, no controllers, no async, no timers.
//      * No `for-in` and no collection-for: indexed loops only.
//      * Use `.withValues(alpha: ...)` not `.withOpacity(...)`.
//      * No `class` declarations: every helper is a top-level function.
//
// =============================================================================

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
//  PALETTE  ---  Pier Cerulean
// ---------------------------------------------------------------------------
//  A short, disciplined palette. The deep ocean blues carry the chrome;
//  driftwood beige carries the body; sun-coral is the only "loud" colour
//  and is reserved for accents and highlights. Each token is named in
//  long form so the reader can map a colour back to its narrative role.
// ---------------------------------------------------------------------------

const Color cOceanDeep = Color(0xFF0F4A66);     // brine-ink: deep ocean
const Color cOceanCerulean = Color(0xFF1B6E8C); // cerulean primary
const Color cOceanWave = Color(0xFF4498BF);     // wave crest
const Color cOceanFoam = Color(0xFFB6DCEE);     // foam pale
const Color cOceanMist = Color(0xFFDDEEF6);     // sea mist
const Color cDriftwoodDark = Color(0xFF8C7A55); // sun-baked plank shadow
const Color cDriftwoodMid = Color(0xFFC5B58A);  // weathered plank
const Color cDriftwoodLite = Color(0xFFE8DCC2); // pale driftwood beige
const Color cSandPale = Color(0xFFF3EBD6);      // dry sand
const Color cCoralAccent = Color(0xFFE36050);   // sun-coral primary accent
const Color cCoralDeep = Color(0xFFB23F2F);     // sun-coral shadow
const Color cCoralLite = Color(0xFFF0866C);     // sun-coral highlight
const Color cBuoyYellow = Color(0xFFE7C46A);    // navigation buoy yellow
const Color cBuoyShadow = Color(0xFF8E6F2C);    // buoy shadow
const Color cKelpGreen = Color(0xFF3E6D55);     // kelp on the piling
const Color cKelpDeep = Color(0xFF254535);      // wet kelp shadow
const Color cBrineInk = Color(0xFF0A2230);      // deepest ink
const Color cChromeRail = Color(0xFFA9C2CE);    // chrome handrail
const Color cBoneWhite = Color(0xFFFAF6EC);     // bleached bone white

// Palette swatches surfaced in the title hero.
const List<Map<String, Object>> kPalette = <Map<String, Object>>[
  {'name': 'oceanDeep', 'color': cOceanDeep},
  {'name': 'cerulean', 'color': cOceanCerulean},
  {'name': 'wave', 'color': cOceanWave},
  {'name': 'foam', 'color': cOceanFoam},
  {'name': 'mist', 'color': cOceanMist},
  {'name': 'driftDark', 'color': cDriftwoodDark},
  {'name': 'driftMid', 'color': cDriftwoodMid},
  {'name': 'driftLite', 'color': cDriftwoodLite},
  {'name': 'sand', 'color': cSandPale},
  {'name': 'coral', 'color': cCoralAccent},
  {'name': 'coralDeep', 'color': cCoralDeep},
  {'name': 'coralLite', 'color': cCoralLite},
  {'name': 'buoyYellow', 'color': cBuoyYellow},
  {'name': 'kelpGreen', 'color': cKelpGreen},
  {'name': 'brineInk', 'color': cBrineInk},
  {'name': 'chromeRail', 'color': cChromeRail},
  {'name': 'bone', 'color': cBoneWhite},
];

// ---------------------------------------------------------------------------
//  TEXT TOKENS
// ---------------------------------------------------------------------------

const TextStyle kTitleStyle = TextStyle(
  fontSize: 28,
  fontWeight: FontWeight.w800,
  color: cBoneWhite,
  letterSpacing: 1.6,
);

const TextStyle kSubtitleStyle = TextStyle(
  fontSize: 13,
  fontStyle: FontStyle.italic,
  color: cOceanFoam,
  height: 1.45,
);

const TextStyle kSectionHeaderStyle = TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.w700,
  color: cBrineInk,
);

const TextStyle kSectionLeadStyle = TextStyle(
  fontSize: 13,
  height: 1.45,
  color: cBrineInk,
);

const TextStyle kBodyStyle = TextStyle(
  fontSize: 12,
  height: 1.45,
  color: cBrineInk,
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
  color: cBoneWhite,
  height: 1.4,
);

const TextStyle kDoStyle = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.w800,
  color: cKelpGreen,
  letterSpacing: 0.5,
);

const TextStyle kAvoidStyle = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.w800,
  color: cCoralDeep,
  letterSpacing: 0.5,
);

const TextStyle kMiniLabelStyle = TextStyle(
  fontSize: 9,
  color: cBrineInk,
  height: 1.2,
);

const TextStyle kPierSignStyle = TextStyle(
  fontSize: 9,
  color: cBoneWhite,
  fontWeight: FontWeight.w800,
  letterSpacing: 0.6,
);

// ---------------------------------------------------------------------------
//  ICON SET --- the five canonical pier signposts
// ---------------------------------------------------------------------------
//  Each "nav item" in our mocked BottomNavigationBar is a (icon, label)
//  pair. We pick five concrete icons so that the visuals look like a
//  real navigation bar from a real app.
// ---------------------------------------------------------------------------

const List<Map<String, Object>> kNavItemsFive = <Map<String, Object>>[
  {'icon': Icons.home_outlined, 'iconSel': Icons.home, 'label': 'Pier'},
  {'icon': Icons.search_outlined, 'iconSel': Icons.search, 'label': 'Search'},
  {'icon': Icons.favorite_outline, 'iconSel': Icons.favorite, 'label': 'Saved'},
  {'icon': Icons.notifications_outlined, 'iconSel': Icons.notifications, 'label': 'Tide'},
  {'icon': Icons.person_outline, 'iconSel': Icons.person, 'label': 'You'},
];

const List<Map<String, Object>> kNavItemsFour = <Map<String, Object>>[
  {'icon': Icons.home_outlined, 'iconSel': Icons.home, 'label': 'Pier'},
  {'icon': Icons.map_outlined, 'iconSel': Icons.map, 'label': 'Charts'},
  {'icon': Icons.favorite_outline, 'iconSel': Icons.favorite, 'label': 'Saved'},
  {'icon': Icons.person_outline, 'iconSel': Icons.person, 'label': 'You'},
];

const List<Map<String, Object>> kNavItemsThree = <Map<String, Object>>[
  {'icon': Icons.home_outlined, 'iconSel': Icons.home, 'label': 'Pier'},
  {'icon': Icons.search_outlined, 'iconSel': Icons.search, 'label': 'Search'},
  {'icon': Icons.person_outline, 'iconSel': Icons.person, 'label': 'You'},
];

const List<Map<String, Object>> kNavItemsTwo = <Map<String, Object>>[
  {'icon': Icons.home_outlined, 'iconSel': Icons.home, 'label': 'Pier'},
  {'icon': Icons.person_outline, 'iconSel': Icons.person, 'label': 'You'},
];

// ---------------------------------------------------------------------------
//  BUILD ENTRY POINT
// ---------------------------------------------------------------------------
//  D4rt invokes this exactly once. We build the entire snapshot up front
//  and return one Widget. The whole demo is a static photograph of a
//  cerulean pier with three layouts laid out plank by plank.
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  print('===============================================================');
  print(' Pier Cerulean --- BottomNavigationBarLandscapeLayout deep demo');
  print('===============================================================');
  print(' Building ONE static snapshot.');
  print(' We mock landscape bars as 240x64 strips since we cannot rotate.');
  print(' Three values: spread (default), centered, linear.');

  final List<Widget> sections = <Widget>[
    _buildTitleHero(),
    _spacer(20),
    _buildAnatomySection(),
    _spacer(20),
    _buildSectionHeader('3. Three-pier anatomy --- the three layouts'),
    _buildThreePierAnatomy(),
    _spacer(20),
    _buildSectionHeader('4. Spread layout deep dive'),
    _buildSpreadDeepDive(),
    _spacer(20),
    _buildSectionHeader('5. Centered layout deep dive'),
    _buildCenteredDeepDive(),
    _spacer(20),
    _buildSectionHeader('6. Linear layout deep dive'),
    _buildLinearDeepDive(),
    _spacer(20),
    _buildSectionHeader('7. Item-count grid (2..5 items x 3 layouts)'),
    _buildItemCountGrid(),
    _spacer(20),
    _buildSectionHeader('8. Use-case cards --- six realistic apps'),
    _buildUseCaseCards(),
    _spacer(20),
    _buildSectionHeader('9. Comparison table'),
    _buildComparisonTable(),
    _spacer(20),
    _buildSectionHeader('10. Type & default-behaviour table'),
    _buildTypeAndDefaultTable(),
    _spacer(20),
    _buildSectionHeader('11. Anti-pattern gallery'),
    _buildAntiPatternGallery(),
    _spacer(20),
    _buildSectionHeader('12. Glossary'),
    _buildGlossary(),
    _spacer(20),
    _buildSectionHeader('13. Closing essay --- portrait vs landscape'),
    _buildClosingEssay(),
    _spacer(20),
    _buildRecapFooter(),
    _spacer(40),
  ];

  print(' Assembled ${sections.length} top-level section blocks.');
  print(' Returning Container with SingleChildScrollView body.');

  return Container(
    color: cDriftwoodLite,
    child: SingleChildScrollView(
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
  // The section header is itself a pier signpost: driftwood beige with a
  // cerulean gutter on the leading edge and a coral underline.
  return Padding(
    padding: const EdgeInsets.only(top: 12, bottom: 8),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: const BoxDecoration(
        color: cSandPale,
        border: Border(
          left: BorderSide(color: cOceanCerulean, width: 6),
          bottom: BorderSide(color: cCoralAccent, width: 1),
        ),
      ),
      child: Text(text, style: kSectionHeaderStyle),
    ),
  );
}

// ---------------------------------------------------------------------------
//  MOCK BOTTOM NAVIGATION BAR
// ---------------------------------------------------------------------------
//  We cannot rotate the d4rt canvas, so we render every landscape bar as
//  a 240-wide x 64-high horizontal strip with the items inside arranged
//  according to which BottomNavigationBarLandscapeLayout we are mocking.
//
//      _mockNavBar(layout: 'spread', items: kNavItemsFive, selectedIndex: 0)
//
//  layout values:
//      'spread'   --- mainAxisAlignment: spaceEvenly, icon above label
//      'centered' --- mainAxisAlignment: center, gaps between items, icon
//                     above label
//      'linear'   --- mainAxisAlignment: spaceEvenly, label BESIDE icon
// ---------------------------------------------------------------------------

Widget _mockNavBar({
  required String layout,
  required List<Map<String, Object>> items,
  required int selectedIndex,
  double width = 240,
  double height = 64,
}) {
  final BoxDecoration barDeco = BoxDecoration(
    color: cBoneWhite,
    borderRadius: BorderRadius.circular(6),
    border: Border.all(color: cChromeRail, width: 1),
    boxShadow: <BoxShadow>[
      BoxShadow(
        color: cBrineInk.withValues(alpha: 0.18),
        blurRadius: 4,
        offset: const Offset(0, 2),
      ),
    ],
  );

  // Build the children differently for each layout.
  final List<Widget> tiles = <Widget>[];

  if (layout == 'centered') {
    // Centered: each tile is icon-above-label, items grouped with gaps.
    for (int i = 0; i < items.length; i++) {
      final Map<String, Object> it = items[i];
      tiles.add(_navTileVertical(it, i == selectedIndex));
      if (i < items.length - 1) {
        tiles.add(const SizedBox(width: 14));
      }
    }
    return Container(
      width: width,
      height: height,
      decoration: barDeco,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: tiles,
      ),
    );
  }

  if (layout == 'linear') {
    // Linear: each tile is icon-beside-label, items distributed evenly.
    for (int i = 0; i < items.length; i++) {
      final Map<String, Object> it = items[i];
      tiles.add(_navTileHorizontal(it, i == selectedIndex));
    }
    return Container(
      width: width,
      height: height,
      decoration: barDeco,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: tiles,
      ),
    );
  }

  // Default: spread --- each tile is icon-above-label, items distributed.
  for (int i = 0; i < items.length; i++) {
    final Map<String, Object> it = items[i];
    tiles.add(_navTileVertical(it, i == selectedIndex));
  }
  return Container(
    width: width,
    height: height,
    decoration: barDeco,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: tiles,
    ),
  );
}

// A vertical tile: icon above label.
Widget _navTileVertical(Map<String, Object> it, bool selected) {
  final Color color = selected ? cCoralAccent : cOceanDeep;
  final IconData icon = selected
      ? it['iconSel'] as IconData
      : it['icon'] as IconData;
  final String label = it['label'] as String;
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Icon(icon, size: 22, color: color),
      const SizedBox(height: 2),
      Text(
        label,
        style: TextStyle(
          fontSize: 10,
          color: color,
          fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
        ),
      ),
    ],
  );
}

// A horizontal tile: icon beside label.
Widget _navTileHorizontal(Map<String, Object> it, bool selected) {
  final Color color = selected ? cCoralAccent : cOceanDeep;
  final IconData icon = selected
      ? it['iconSel'] as IconData
      : it['icon'] as IconData;
  final String label = it['label'] as String;
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Icon(icon, size: 20, color: color),
      const SizedBox(width: 4),
      Text(
        label,
        style: TextStyle(
          fontSize: 10,
          color: color,
          fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
        ),
      ),
    ],
  );
}

// ===========================================================================
//  SECTION 1 --- Title hero with palette swatches
// ===========================================================================

Widget _buildTitleHero() {
  print(' Building Section 1: Pier Cerulean title hero.');
  // The hero is a deep-ocean panel with a cerulean glow underneath, a
  // chrome-rail border at the top --- a pier seen end-on with the sea
  // beneath it.
  final BoxDecoration heroDeco = BoxDecoration(
    gradient: const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: <Color>[cOceanCerulean, cOceanDeep, cBrineInk],
      stops: <double>[0.0, 0.55, 1.0],
    ),
    borderRadius: BorderRadius.circular(14),
    boxShadow: <BoxShadow>[
      BoxShadow(
        color: cCoralAccent.withValues(alpha: 0.30),
        blurRadius: 22,
        spreadRadius: 1,
        offset: const Offset(0, 10),
      ),
    ],
    border: Border.all(color: cChromeRail, width: 2),
  );

  // A horizontal palette strip in the bottom of the hero.
  final List<Widget> swatches = <Widget>[];
  for (int i = 0; i < kPalette.length; i++) {
    final Map<String, Object> entry = kPalette[i];
    final Color c = entry['color'] as Color;
    final String n = entry['name'] as String;
    final BoxDecoration swatchDeco = BoxDecoration(
      color: c,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: cBoneWhite.withValues(alpha: 0.65), width: 1),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: cBrineInk.withValues(alpha: 0.45),
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
                style: const TextStyle(fontSize: 9, color: cBoneWhite),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // A buoy sigil floating at the top right of the hero.
  final Widget buoy = Container(
    width: 56,
    height: 56,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      gradient: const RadialGradient(
        colors: <Color>[cBuoyYellow, cCoralAccent, cCoralDeep],
        stops: <double>[0.0, 0.65, 1.0],
      ),
      border: Border.all(color: cBoneWhite, width: 2),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: cCoralAccent.withValues(alpha: 0.55),
          blurRadius: 10,
          spreadRadius: 1,
        ),
      ],
    ),
    child: const Center(
      child: Text(
        'P',
        style: TextStyle(
          color: cBrineInk,
          fontWeight: FontWeight.w900,
          fontSize: 22,
          letterSpacing: 1.2,
        ),
      ),
    ),
  );

  // Signature line --- the actual enum declaration as a code monoline.
  final Widget signature = Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: BoxDecoration(
      color: cBrineInk.withValues(alpha: 0.55),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: cChromeRail.withValues(alpha: 0.6)),
    ),
    child: const Text(
      'enum BottomNavigationBarLandscapeLayout { spread, centered, linear }',
      style: kCodeStyle,
    ),
  );

  return Container(
    decoration: heroDeco,
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
                  Text('PIER CERULEAN', style: kTitleStyle),
                  SizedBox(height: 6),
                  Text(
                    'A coastal walkthrough of BottomNavigationBarLandscapeLayout: '
                    'how a Material BottomNavigationBar arranges its items '
                    'when the screen is held wide. Three values --- spread, '
                    'centered, linear --- each rendered as a row of pier '
                    'signposts on a sun-bleached boardwalk.',
                    style: kSubtitleStyle,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            buoy,
          ],
        ),
        const SizedBox(height: 14),
        signature,
        const SizedBox(height: 14),
        const Text(
          'PALETTE',
          style: TextStyle(
            color: cOceanFoam,
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
//  SECTION 2 --- Prose anatomy of BottomNavigationBarLandscapeLayout
// ===========================================================================

Widget _buildAnatomySection() {
  print(' Building Section 2: prose anatomy.');
  // A driftwood-coloured prose card with a cerulean gutter and a coral border.
  final BoxDecoration proseDeco = BoxDecoration(
    color: cSandPale,
    borderRadius: BorderRadius.circular(10),
    border: Border.all(color: cDriftwoodDark, width: 1),
    boxShadow: <BoxShadow>[
      BoxShadow(
        color: cBrineInk.withValues(alpha: 0.18),
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
        Text('2. WHAT IS BottomNavigationBarLandscapeLayout?',
            style: kSectionHeaderStyle),
        SizedBox(height: 10),
        Text(
          'BottomNavigationBarLandscapeLayout is a Material enum with three '
          'values --- spread, centered, linear. It is passed to a '
          'BottomNavigationBar as the `landscapeLayout` named argument. '
          'The enum has zero effect in portrait orientation; portrait '
          'BottomNavigationBars always render as a row of icon-above-label '
          'tiles distributed evenly. The enum only kicks in once the '
          'parent is wider than it is tall (landscape, tablets, foldables, '
          'wide windows on desktop).',
          style: kSectionLeadStyle,
        ),
        SizedBox(height: 12),
        Text('THE THREE VALUES', style: kSmallLabelStyle),
        SizedBox(height: 6),
        Text(
          '   spread    --- DEFAULT. Items distributed evenly across the\n'
          '                 full landscape width. Icon ABOVE label. Looks\n'
          '                 like portrait, just stretched wider.\n'
          '   centered  --- Items clustered in the centre of the bar with\n'
          '                 empty padding either side. Icon ABOVE label.\n'
          '                 Reads like a tablet "dock" or a desktop\n'
          '                 toolbar.\n'
          '   linear    --- Each item is laid out as a Row: icon BESIDE\n'
          '                 label. Items distributed evenly. Reads like a\n'
          '                 horizontal navigation rail flattened into a\n'
          '                 strip.\n'
          '\n'
          'These are not "themes" you can mix --- exactly ONE applies, and\n'
          'it applies the same way to every item in the bar.',
          style: kBodyStyle,
        ),
        SizedBox(height: 12),
        Text('A TYPICAL TREE', style: kSmallLabelStyle),
        SizedBox(height: 6),
        Text(
          '   Scaffold(\n'
          '      body: ...,\n'
          '      bottomNavigationBar: BottomNavigationBar(\n'
          '         type: BottomNavigationBarType.fixed,\n'
          '         currentIndex: 0,\n'
          '         landscapeLayout:\n'
          '             BottomNavigationBarLandscapeLayout.linear,\n'
          '         items: const <BottomNavigationBarItem>[\n'
          '            BottomNavigationBarItem(\n'
          '               icon: Icon(Icons.home), label: \'Pier\'),\n'
          '            BottomNavigationBarItem(\n'
          '               icon: Icon(Icons.search), label: \'Search\'),\n'
          '            BottomNavigationBarItem(\n'
          '               icon: Icon(Icons.person), label: \'You\'),\n'
          '         ],\n'
          '      ),\n'
          '   )\n'
          '\n'
          'Read it top-to-bottom: a Scaffold whose bottom strip is a wide\n'
          'BottomNavigationBar that, in landscape, lays its items out as\n'
          'horizontal "icon | label" rows.',
          style: kBodyStyle,
        ),
        SizedBox(height: 12),
        Text('WHEN DOES IT MATTER?', style: kSmallLabelStyle),
        SizedBox(height: 6),
        Text(
          'It matters when:\n'
          '   * Your app supports landscape orientation on phones.\n'
          '   * Your app runs on tablets, foldables, ChromeOS, or as a\n'
          '     resizable desktop window.\n'
          '   * You support split-screen / multi-window where the screen\n'
          '     can become noticeably wider than tall.\n'
          '\n'
          'It does NOT matter when:\n'
          '   * Your app is portrait-only (look for orientation lock in\n'
          '     your manifest / Info.plist).\n'
          '   * You are not using BottomNavigationBar at all (NavigationBar\n'
          '     in Material 3 has its own affordances).',
          style: kBodyStyle,
        ),
      ],
    ),
  );
}

// ===========================================================================
//  SECTION 3 --- Three-pier anatomy
// ===========================================================================

Widget _buildThreePierAnatomy() {
  print(' Building Section 3: three-pier anatomy.');
  // Three labelled cards side by side, each containing a 240x64 mock
  // landscape bar.
  final List<Widget> piers = <Widget>[
    _buildPierCard(
      title: 'spread (default)',
      subtitle: 'Items distributed evenly across the full landscape width.',
      bar: _mockNavBar(
        layout: 'spread',
        items: kNavItemsFive,
        selectedIndex: 0,
      ),
      tint: cOceanWave,
    ),
    _buildPierCard(
      title: 'centered',
      subtitle: 'Items grouped at the centre with empty padding either side.',
      bar: _mockNavBar(
        layout: 'centered',
        items: kNavItemsFive,
        selectedIndex: 0,
      ),
      tint: cKelpGreen,
    ),
    _buildPierCard(
      title: 'linear',
      subtitle: 'Each item as icon-beside-label. Items distributed evenly.',
      // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #37, P3):
      // 5 horizontal tiles natural width slightly exceeds 240 (0.601 px
      // sub-pixel overflow). Widen the mock bar to 252 to absorb the
      // overflow without changing the visual intent.
      bar: _mockNavBar(
        layout: 'linear',
        items: kNavItemsFive,
        selectedIndex: 0,
        width: 252,
      ),
      tint: cCoralAccent,
    ),
  ];

  return Wrap(spacing: 14, runSpacing: 14, children: piers);
}

Widget _buildPierCard({
  required String title,
  required String subtitle,
  required Widget bar,
  required Color tint,
}) {
  // A pier card is a piece of weathered driftwood with a coloured signpost
  // banner along the top.
  final BoxDecoration cardDeco = BoxDecoration(
    color: cBoneWhite,
    borderRadius: BorderRadius.circular(10),
    border: Border.all(color: cDriftwoodDark, width: 1),
    boxShadow: <BoxShadow>[
      BoxShadow(
        color: cBrineInk.withValues(alpha: 0.20),
        blurRadius: 6,
        offset: const Offset(0, 3),
      ),
    ],
  );
  final BoxDecoration bannerDeco = BoxDecoration(
    color: tint,
    borderRadius: const BorderRadius.only(
      topLeft: Radius.circular(10),
      topRight: Radius.circular(10),
    ),
  );

  return Container(
    width: 280,
    decoration: cardDeco,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          decoration: bannerDeco,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          width: double.infinity,
          child: Text(title, style: kPierSignStyle),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(subtitle, style: kBodyStyle),
              const SizedBox(height: 10),
              Center(child: bar),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: cOceanMist,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: cChromeRail.withValues(alpha: 0.7)),
                ),
                child: const Text(
                  'Mocked as 240x64 strip --- in real Flutter the bar fills '
                  'the screen width in landscape.',
                  style: kMiniLabelStyle,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
//  SECTION 4 --- Spread layout deep dive
// ===========================================================================

Widget _buildSpreadDeepDive() {
  print(' Building Section 4: spread deep dive.');
  // A driftwood card with three rows: the bar, an annotated diagram, and
  // a recipe.
  return _buildLayoutDeepDive(
    layoutName: 'spread',
    layoutKey: 'spread',
    selectedIndex: 0,
    accent: cOceanCerulean,
    description:
        'spread is the DEFAULT for BottomNavigationBar in landscape. It '
        'behaves the same as portrait: each item is rendered with the '
        'icon ABOVE the label, and the items are distributed evenly '
        'across the full bar width using mainAxisAlignment.spaceEvenly. '
        'The bar feels symmetric. Each item gets the same horizontal '
        'slot, regardless of label length. This is the safest choice '
        'for an app that already looks good in portrait --- nothing '
        'really changes.',
    bullets: <String>[
      'mainAxisAlignment: spaceEvenly across the full bar.',
      'Icon above label (same as portrait).',
      'Equal horizontal share for every item.',
      'Default for both BottomNavigationBarType.fixed and .shifting.',
      'Reads like portrait, just stretched.',
    ],
    pros: <String>[
      'Predictable: identical to portrait.',
      'Works for 2..5 items without redesign.',
      'Touch targets are large (full slot is tappable).',
    ],
    cons: <String>[
      'Wide bars feel empty in the middle if you only have 2-3 items.',
      'Long labels in narrow slots can ellipse before the bar feels full.',
    ],
  );
}

// ===========================================================================
//  SECTION 5 --- Centered layout deep dive
// ===========================================================================

Widget _buildCenteredDeepDive() {
  print(' Building Section 5: centered deep dive.');
  return _buildLayoutDeepDive(
    layoutName: 'centered',
    layoutKey: 'centered',
    selectedIndex: 0,
    accent: cKelpGreen,
    description:
        'centered groups all items in the centre of the bar with '
        'mainAxisAlignment.center, leaving empty driftwood-coloured '
        'space on both sides. Icons stay ABOVE labels (same vertical '
        'tile shape as portrait). The empty space on either side is '
        'NOT padding you control --- it is simply where the items '
        'are not. This works well on tablets and wide windows where '
        'spreading 3 items across 1200 logical pixels would leave '
        'comically wide gaps.',
    bullets: <String>[
      'mainAxisAlignment: center.',
      'Icon above label (same vertical tile shape as portrait).',
      'Empty space on either side scales with viewport width.',
      'Touch targets shrink to the natural size of the tile.',
      'Reads like a tablet dock or a desktop toolbar.',
    ],
    pros: <String>[
      'Avoids "big empty middle" on wide bars with few items.',
      'Looks deliberate and dock-like on tablets.',
      'Works well with 2-3 items.',
    ],
    cons: <String>[
      'Asymmetric reach --- items further from centre on a wide screen.',
      'Less obvious where to tap if items cluster too tightly.',
      'Feels off with 5 items: they cluster, the wings feel wasted.',
    ],
  );
}

// ===========================================================================
//  SECTION 6 --- Linear layout deep dive
// ===========================================================================

Widget _buildLinearDeepDive() {
  print(' Building Section 6: linear deep dive.');
  return _buildLayoutDeepDive(
    layoutName: 'linear',
    layoutKey: 'linear',
    selectedIndex: 0,
    accent: cCoralAccent,
    description:
        'linear is the most "wide-screen friendly" option. Each item is '
        'laid out as a Row of (icon, label) instead of a Column of '
        '(icon over label). Items are distributed evenly across the '
        'full bar width with mainAxisAlignment.spaceEvenly. The label '
        'sits BESIDE the icon, not under it. The whole bar reads like '
        'a horizontal NavigationRail flattened into a single strip. '
        'It is the only landscape layout that genuinely takes '
        'advantage of the extra horizontal space.',
    bullets: <String>[
      'Each item: Row(icon, label) instead of Column(icon, label).',
      'mainAxisAlignment: spaceEvenly across the full bar.',
      'Label is fully visible because there is more horizontal room.',
      'Vertical bar height shrinks (no stacked icon+label tower).',
      'Reads like a horizontal navigation rail.',
    ],
    pros: <String>[
      'Best use of landscape horizontal space.',
      'Labels are easier to read at a glance.',
      'The bar is shorter vertically --- more room for body content.',
    ],
    cons: <String>[
      'Touch targets are wider but shorter.',
      'Labels with many characters can dominate the slot.',
      'Looks alien if your portrait bar uses tall stacked tiles --- '
          'the user notices the orientation shift.',
    ],
  );
}

// ---------------------------------------------------------------------------
//  Shared deep-dive scaffolding for sections 4, 5, 6
// ---------------------------------------------------------------------------

Widget _buildLayoutDeepDive({
  required String layoutName,
  required String layoutKey,
  required int selectedIndex,
  required Color accent,
  required String description,
  required List<String> bullets,
  required List<String> pros,
  required List<String> cons,
}) {
  // Card with title bar in `accent`, then the mocked landscape bar with
  // each of the 5 nav-item counts {2, 3, 4, 5}, plus a description plus
  // bullet list plus pros/cons.
  final BoxDecoration cardDeco = BoxDecoration(
    color: cBoneWhite,
    borderRadius: BorderRadius.circular(10),
    border: Border.all(color: cDriftwoodDark, width: 1),
    boxShadow: <BoxShadow>[
      BoxShadow(
        color: cBrineInk.withValues(alpha: 0.18),
        blurRadius: 6,
        offset: const Offset(0, 3),
      ),
    ],
  );

  final List<Widget> bulletWidgets = <Widget>[];
  for (int i = 0; i < bullets.length; i++) {
    bulletWidgets.add(
      Padding(
        padding: const EdgeInsets.only(top: 4, bottom: 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 6,
              height: 6,
              margin: const EdgeInsets.only(top: 6, right: 8),
              decoration: BoxDecoration(
                color: accent,
                shape: BoxShape.circle,
              ),
            ),
            Expanded(child: Text(bullets[i], style: kBodyStyle)),
          ],
        ),
      ),
    );
  }

  final List<Widget> proWidgets = <Widget>[];
  for (int i = 0; i < pros.length; i++) {
    proWidgets.add(
      Padding(
        padding: const EdgeInsets.only(top: 3, bottom: 3),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(top: 1, right: 6),
              child: Icon(Icons.check_circle,
                  size: 14, color: cKelpGreen),
            ),
            Expanded(
              child: Text(
                pros[i],
                style: const TextStyle(
                  fontSize: 11,
                  color: cBrineInk,
                  height: 1.35,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final List<Widget> conWidgets = <Widget>[];
  for (int i = 0; i < cons.length; i++) {
    conWidgets.add(
      Padding(
        padding: const EdgeInsets.only(top: 3, bottom: 3),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(top: 1, right: 6),
              child: Icon(Icons.cancel,
                  size: 14, color: cCoralDeep),
            ),
            Expanded(
              child: Text(
                cons[i],
                style: const TextStyle(
                  fontSize: 11,
                  color: cBrineInk,
                  height: 1.35,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Examples row --- four mock bars at item counts {2, 3, 4, 5}.
  final List<Widget> exampleStacks = <Widget>[];
  final List<List<Map<String, Object>>> itemSets = <List<Map<String, Object>>>[
    kNavItemsTwo,
    kNavItemsThree,
    kNavItemsFour,
    kNavItemsFive,
  ];
  final List<int> itemCounts = <int>[2, 3, 4, 5];
  for (int i = 0; i < itemSets.length; i++) {
    final int n = itemCounts[i];
    exampleStacks.add(
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: accent,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              '$n items',
              style: const TextStyle(
                color: cBoneWhite,
                fontSize: 10,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.4,
              ),
            ),
          ),
          const SizedBox(height: 6),
          _mockNavBar(
            layout: layoutKey,
            items: itemSets[i],
            selectedIndex: 0,
            // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #37, P3):
            // Linear with 5 items has natural width slightly above 240
            // (0.601 px sub-pixel overflow). Widen to 252 for linear,
            // keep 240 for spread/centered.
            width: layoutKey == 'linear' ? 252 : 240,
            height: 64,
          ),
        ],
      ),
    );
  }

  return Container(
    decoration: cardDeco,
    padding: const EdgeInsets.all(14),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: accent,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            'BottomNavigationBarLandscapeLayout.$layoutName',
            style: const TextStyle(
              color: cBoneWhite,
              fontWeight: FontWeight.w800,
              fontSize: 12,
              letterSpacing: 0.5,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(description, style: kBodyStyle),
        const SizedBox(height: 12),
        Text('AT A GLANCE', style: kSmallLabelStyle),
        const SizedBox(height: 4),
        Column(children: bulletWidgets),
        const SizedBox(height: 12),
        Text('EXAMPLES (2..5 items)', style: kSmallLabelStyle),
        const SizedBox(height: 6),
        Wrap(spacing: 18, runSpacing: 16, children: exampleStacks),
        const SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: cKelpGreen.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                      color: cKelpGreen.withValues(alpha: 0.4)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text('PROS', style: kDoStyle),
                    const SizedBox(height: 6),
                    Column(children: proWidgets),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: cCoralAccent.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                      color: cCoralAccent.withValues(alpha: 0.4)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text('CONS', style: kAvoidStyle),
                    const SizedBox(height: 6),
                    Column(children: conWidgets),
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

// ===========================================================================
//  SECTION 7 --- Item-count grid
// ===========================================================================
//  A 3-row x 4-column grid: rows are the three layouts; columns are the
//  item counts {2, 3, 4, 5}. The grid lets the reader compare layout x
//  item-count combinations at a glance.
// ===========================================================================

Widget _buildItemCountGrid() {
  print(' Building Section 7: item-count grid.');
  final BoxDecoration outerDeco = BoxDecoration(
    color: cBoneWhite,
    borderRadius: BorderRadius.circular(10),
    border: Border.all(color: cDriftwoodDark, width: 1),
    boxShadow: <BoxShadow>[
      BoxShadow(
        color: cBrineInk.withValues(alpha: 0.18),
        blurRadius: 6,
        offset: const Offset(0, 3),
      ),
    ],
  );

  final List<String> layouts = <String>['spread', 'centered', 'linear'];
  final List<Color> layoutAccents = <Color>[
    cOceanCerulean,
    cKelpGreen,
    cCoralAccent,
  ];
  final List<List<Map<String, Object>>> sets =
      <List<Map<String, Object>>>[
    kNavItemsTwo,
    kNavItemsThree,
    kNavItemsFour,
    kNavItemsFive,
  ];
  final List<int> counts = <int>[2, 3, 4, 5];

  // Header row: "Layout \\ items", then the four counts.
  final List<Widget> headerCells = <Widget>[];
  headerCells.add(
    Container(
      width: 100,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: cOceanDeep,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
        ),
      ),
      child: const Text(
        'layout \\ items',
        style: TextStyle(
          color: cBoneWhite,
          fontSize: 11,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.4,
        ),
      ),
    ),
  );
  for (int i = 0; i < counts.length; i++) {
    final BorderRadius br = i == counts.length - 1
        ? const BorderRadius.only(topRight: Radius.circular(8))
        : BorderRadius.zero;
    headerCells.add(
      // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #37, P3):
      // Cell width widened from 250 to 280 so linear-5 bar (natural
      // ~241) fits in the cell inner space (280-16 = 264). The grid
      // is in a horizontal SingleChildScrollView so total width is
      // not bounded by viewport.
      Container(
        width: 280,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: cOceanDeep,
          borderRadius: br,
          border: const Border(
            left: BorderSide(color: cBoneWhite, width: 1),
          ),
        ),
        child: Text(
          '${counts[i]} items',
          style: const TextStyle(
            color: cBoneWhite,
            fontSize: 11,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.4,
          ),
        ),
      ),
    );
  }

  // Body rows: one row per layout.
  final List<Widget> bodyRows = <Widget>[];
  for (int row = 0; row < layouts.length; row++) {
    final String layout = layouts[row];
    final Color tint = layoutAccents[row];
    final List<Widget> cells = <Widget>[];
    cells.add(
      Container(
        width: 100,
        height: 90,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: tint,
          border: const Border(
            top: BorderSide(color: cBoneWhite, width: 1),
          ),
        ),
        child: Text(
          layout,
          style: const TextStyle(
            color: cBoneWhite,
            fontSize: 12,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.4,
          ),
        ),
      ),
    );
    for (int col = 0; col < sets.length; col++) {
      cells.add(
        // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #37, P3):
        // Cell width 280 (matches header).
        Container(
          width: 280,
          height: 90,
          padding: const EdgeInsets.all(8),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: row.isEven ? cSandPale : cOceanMist,
            border: const Border(
              top: BorderSide(color: cChromeRail, width: 1),
              left: BorderSide(color: cChromeRail, width: 1),
            ),
          ),
          child: _mockNavBar(
            layout: layout,
            items: sets[col],
            selectedIndex: 0,
            // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #37, P3):
            // Bar widened from 230 to 250 (well above linear-5 natural
            // ~241). Cells widened to 280 to keep the bar fully inside.
            width: 250,
            height: 60,
          ),
        ),
      );
    }
    bodyRows.add(Row(children: cells));
  }

  return Container(
    decoration: outerDeco,
    padding: const EdgeInsets.all(8),
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(children: headerCells),
          Column(children: bodyRows),
          const SizedBox(height: 8),
          const Text(
            'Reading the grid: each cell shows the same fixed pier mocked '
            'with the row\'s layout and the column\'s item count. Notice '
            'how centered with 5 items still clusters in the middle, while '
            'linear with 2 items wastes the most horizontal real-estate.',
            style: kMiniLabelStyle,
          ),
        ],
      ),
    ),
  );
}

// ===========================================================================
//  SECTION 8 --- Use-case cards
// ===========================================================================
//  Six realistic apps, each with a recommended landscape layout and a
//  short justification. The cards are styled like postcards from
//  fictional pier shops.
// ===========================================================================

Widget _buildUseCaseCards() {
  print(' Building Section 8: use-case cards.');
  final List<Map<String, Object>> useCases = <Map<String, Object>>[
    {
      'app': 'Mail client',
      'recommend': 'linear',
      'recommendKey': 'linear',
      'why':
          'Mail apps lean on labels (Inbox / Sent / Drafts / Archive). '
              'In landscape, linear puts the labels right next to the icons, '
              'so users do not need to read tiny vertical typography. '
              'Wide inboxes also benefit from a shorter bar so more email '
              'rows are visible.',
      'items': kNavItemsFour,
      'tint': cOceanCerulean,
      'icon': Icons.mail_outline,
    },
    {
      'app': 'Music player',
      'recommend': 'centered',
      'recommendKey': 'centered',
      'why':
          'Music apps usually have 3 items (Library / Now Playing / Search) '
              'and benefit from feeling like a "tablet remote" in landscape. '
              'Centered keeps the controls clustered like a media console.',
      'items': kNavItemsThree,
      'tint': cKelpGreen,
      'icon': Icons.music_note,
    },
    {
      'app': 'Fitness tracker',
      'recommend': 'spread',
      'recommendKey': 'spread',
      'why':
          'Fitness apps typically have 5 items (Today / Workouts / Coach / '
              'Stats / Profile) and want the bar to feel "the same as '
              'portrait". Spread keeps users\' muscle memory intact.',
      'items': kNavItemsFive,
      'tint': cCoralAccent,
      'icon': Icons.directions_run,
    },
    {
      'app': 'Banking',
      'recommend': 'linear',
      'recommendKey': 'linear',
      'why':
          'Banking labels are non-negotiable (Accounts / Pay / Cards / Profile) --- '
              'misreading "Pay" as "Profile" is unacceptable. Linear keeps '
              'labels prominent in landscape, especially on tablets.',
      'items': kNavItemsFour,
      'tint': cOceanDeep,
      'icon': Icons.account_balance_outlined,
    },
    {
      'app': 'Social network',
      'recommend': 'spread',
      'recommendKey': 'spread',
      'why':
          'Social apps have 5 prominent destinations and millions of '
              'users with deep muscle memory. The portrait bar IS the '
              'identity of the app. Spread preserves that shape in '
              'landscape verbatim.',
      'items': kNavItemsFive,
      'tint': cCoralDeep,
      'icon': Icons.people_outline,
    },
    {
      'app': 'News reader',
      'recommend': 'centered',
      'recommendKey': 'centered',
      'why':
          'News apps in landscape often switch to a multi-column reading '
              'layout. Centered keeps the bar visually quiet on the sides '
              'so the text columns can dominate.',
      'items': kNavItemsThree,
      'tint': cKelpDeep,
      'icon': Icons.article_outlined,
    },
  ];

  final List<Widget> cards = <Widget>[];
  for (int i = 0; i < useCases.length; i++) {
    final Map<String, Object> u = useCases[i];
    final BoxDecoration cardDeco = BoxDecoration(
      color: cBoneWhite,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: u['tint'] as Color, width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: cBrineInk.withValues(alpha: 0.16),
          blurRadius: 6,
          offset: const Offset(0, 3),
        ),
      ],
    );
    cards.add(
      Container(
        width: 360,
        decoration: cardDeco,
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: u['tint'] as Color,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(
                    u['icon'] as IconData,
                    size: 18,
                    color: cBoneWhite,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        u['app'] as String,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: cBrineInk,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'recommended: ${u['recommend']}',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: u['tint'] as Color,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            _mockNavBar(
              layout: u['recommendKey'] as String,
              items: u['items'] as List<Map<String, Object>>,
              selectedIndex: 0,
              width: 320,
              height: 64,
            ),
            const SizedBox(height: 10),
            Text(u['why'] as String, style: kBodyStyle),
          ],
        ),
      ),
    );
  }
  return Wrap(spacing: 14, runSpacing: 14, children: cards);
}

// ===========================================================================
//  SECTION 9 --- Comparison table
// ===========================================================================
//  Rows: spread, centered, linear.
//  Columns: item alignment, icon-label arrangement, default behaviour,
//           best fit.
// ===========================================================================

Widget _buildComparisonTable() {
  print(' Building Section 9: comparison table.');
  final List<List<String>> rows = <List<String>>[
    <String>[
      'spread',
      'spaceEvenly across full width',
      'icon ABOVE label (vertical)',
      'DEFAULT for both fixed and shifting',
      '5-item phone apps that already look right in portrait',
    ],
    <String>[
      'centered',
      'center, padding either side',
      'icon ABOVE label (vertical)',
      'opt-in via landscapeLayout: ...centered',
      'tablets, 3-item music/news/dock apps',
    ],
    <String>[
      'linear',
      'spaceEvenly across full width',
      'icon BESIDE label (horizontal)',
      'opt-in via landscapeLayout: ...linear',
      'tablets, mail/banking, label-heavy apps',
    ],
  ];

  final List<String> headers = <String>[
    'value',
    'item alignment',
    'icon-label arrangement',
    'default behaviour',
    'best fit',
  ];
  final List<double> widths = <double>[100, 180, 180, 220, 240];

  // Build header row.
  final List<Widget> headerCells = <Widget>[];
  for (int i = 0; i < headers.length; i++) {
    final BorderRadius br = i == 0
        ? const BorderRadius.only(topLeft: Radius.circular(8))
        : (i == headers.length - 1
            ? const BorderRadius.only(topRight: Radius.circular(8))
            : BorderRadius.zero);
    headerCells.add(
      Container(
        width: widths[i],
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          color: cOceanDeep,
          borderRadius: br,
          border: const Border(
            left: BorderSide(color: cBoneWhite, width: 1),
          ),
        ),
        child: Text(
          headers[i],
          style: const TextStyle(
            color: cBoneWhite,
            fontWeight: FontWeight.w800,
            fontSize: 11,
            letterSpacing: 0.4,
          ),
        ),
      ),
    );
  }

  // Body rows.
  final List<Widget> bodyRows = <Widget>[];
  for (int r = 0; r < rows.length; r++) {
    final List<String> row = rows[r];
    final List<Widget> cells = <Widget>[];
    for (int c = 0; c < row.length; c++) {
      Color bg = r.isEven ? cSandPale : cOceanMist;
      if (c == 0) {
        // Value column: tint by which value
        if (r == 0) bg = cOceanCerulean.withValues(alpha: 0.18);
        if (r == 1) bg = cKelpGreen.withValues(alpha: 0.18);
        if (r == 2) bg = cCoralAccent.withValues(alpha: 0.18);
      }
      cells.add(
        Container(
          width: widths[c],
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: bg,
            border: const Border(
              left: BorderSide(color: cChromeRail, width: 1),
              top: BorderSide(color: cChromeRail, width: 1),
            ),
          ),
          child: Text(
            row[c],
            style: TextStyle(
              fontSize: 11,
              color: cBrineInk,
              fontWeight: c == 0 ? FontWeight.w800 : FontWeight.w500,
              height: 1.35,
            ),
          ),
        ),
      );
    }
    bodyRows.add(Row(children: cells));
  }

  return Container(
    decoration: BoxDecoration(
      color: cBoneWhite,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: cDriftwoodDark, width: 1),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: cBrineInk.withValues(alpha: 0.16),
          blurRadius: 6,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    padding: const EdgeInsets.all(8),
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        children: <Widget>[
          Row(children: headerCells),
          Column(children: bodyRows),
        ],
      ),
    ),
  );
}

// ===========================================================================
//  SECTION 10 --- Type & default-behaviour table
// ===========================================================================

Widget _buildTypeAndDefaultTable() {
  print(' Building Section 10: type & default table.');
  // A two-column property table: each row has a "property" cell and a
  // "explanation" cell. We list the formal facts about the parameter.
  final List<List<String>> rows = <List<String>>[
    <String>[
      'declaration site',
      'BottomNavigationBar.landscapeLayout '
          '({BottomNavigationBarLandscapeLayout? landscapeLayout, ...})',
    ],
    <String>[
      'type',
      'BottomNavigationBarLandscapeLayout? --- nullable enum',
    ],
    <String>[
      'default value',
      'null on the constructor; resolved at layout-time to '
          'BottomNavigationBarLandscapeLayout.spread',
    ],
    <String>[
      'effective in portrait',
      'No --- portrait always uses the icon-above-label spread layout',
    ],
    <String>[
      'effective in landscape',
      'Yes --- the chosen value picks one of three landscape strategies',
    ],
    <String>[
      'interaction with type=fixed',
      'fully respected: spread/centered/linear all behave as documented',
    ],
    <String>[
      'interaction with type=shifting',
      'fully respected, but the shifting selected-item still grows; with '
          'centered+shifting the cluster can drift if the selected item '
          'is at an edge',
    ],
    <String>[
      'interaction with selectedFontSize',
      'still applied in all three layouts; in linear the larger font sits '
          'beside the icon',
    ],
    <String>[
      'interaction with showSelectedLabels=false',
      'in linear the icon stays alone in its row slot; in spread/centered '
          'the icon takes the full vertical tile',
    ],
    <String>[
      'breaking-change history',
      'introduced in Flutter 1.20 (2020); spread is the historical '
          'default to preserve portrait parity',
    ],
    <String>[
      'related Material 3 widget',
      'NavigationBar (Material 3) does NOT expose a landscapeLayout --- '
          'it always uses an inline icon+label tile in landscape',
    ],
  ];

  final List<Widget> rowWidgets = <Widget>[];
  for (int r = 0; r < rows.length; r++) {
    final Color bg = r.isEven ? cSandPale : cOceanMist;
    rowWidgets.add(
      Container(
        decoration: BoxDecoration(
          color: bg,
          border: const Border(
            top: BorderSide(color: cChromeRail, width: 1),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 200,
              child: Text(
                rows[r][0],
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: cCoralDeep,
                  height: 1.4,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                rows[r][1],
                style: kBodyStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }

  return Container(
    decoration: BoxDecoration(
      color: cBoneWhite,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: cDriftwoodDark, width: 1),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: cBrineInk.withValues(alpha: 0.16),
          blurRadius: 6,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: const BoxDecoration(
            color: cOceanDeep,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: const Text(
            'BottomNavigationBar.landscapeLayout --- type & defaults',
            style: TextStyle(
              color: cBoneWhite,
              fontSize: 13,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.5,
            ),
          ),
        ),
        Column(children: rowWidgets),
      ],
    ),
  );
}

// ===========================================================================
//  SECTION 11 --- Anti-pattern gallery
// ===========================================================================

Widget _buildAntiPatternGallery() {
  print(' Building Section 11: anti-pattern gallery.');
  final List<Map<String, Object>> antis = <Map<String, Object>>[
    {
      'title': 'Forcing centered with 5 items in a narrow viewport',
      'why':
          'Centered with 5 items cramps the icons in the middle and '
              'wastes the horizontal room you fought for. Either drop to '
              '3 items or switch to spread/linear.',
      'badLayout': 'centered',
      'badItems': kNavItemsFive,
      'goodLayout': 'spread',
      'goodItems': kNavItemsFive,
    },
    {
      'title': 'Using linear when icons matter more than labels',
      'why':
          'A photo / camera / drawing app whose icons are the brand will '
              'look cluttered if every icon gets a label glued to its '
              'side. Spread preserves the iconic feel.',
      'badLayout': 'linear',
      'badItems': kNavItemsFive,
      'goodLayout': 'spread',
      'goodItems': kNavItemsFive,
    },
    {
      'title': 'Switching layout per orientation in stateful navigation',
      'why':
          'Do not make the bar identity wobble: if portrait is spread, '
              'do not switch to centered in landscape just to "use the '
              'space". The user notices and feels the app is unstable.',
      'badLayout': 'centered',
      'badItems': kNavItemsFour,
      'goodLayout': 'spread',
      'goodItems': kNavItemsFour,
    },
    {
      'title': 'Long labels with linear on a phone in landscape',
      'why':
          "On a 6\" phone in landscape, 'Notifications' + 'Library' + "
              '"Profile" + "Settings" + "Discover" do not fit beside their '
              'icons. Linear forces ellipsis or wrap. Use spread (or '
              'shorter labels).',
      'badLayout': 'linear',
      'badItems': kNavItemsFive,
      'goodLayout': 'spread',
      'goodItems': kNavItemsFive,
    },
  ];

  final List<Widget> cards = <Widget>[];
  for (int i = 0; i < antis.length; i++) {
    final Map<String, Object> a = antis[i];
    final BoxDecoration cardDeco = BoxDecoration(
      color: cBoneWhite,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: cCoralDeep, width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: cCoralAccent.withValues(alpha: 0.18),
          blurRadius: 6,
          offset: const Offset(0, 3),
        ),
      ],
    );
    cards.add(
      Container(
        width: 380,
        decoration: cardDeco,
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                const Icon(Icons.warning_amber, color: cCoralDeep, size: 18),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    a['title'] as String,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: cCoralDeep,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(a['why'] as String, style: kBodyStyle),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: cCoralAccent.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                    color: cCoralAccent.withValues(alpha: 0.5)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text('AVOID', style: kAvoidStyle),
                  const SizedBox(height: 6),
                  Center(
                    child: _mockNavBar(
                      layout: a['badLayout'] as String,
                      items: a['badItems'] as List<Map<String, Object>>,
                      selectedIndex: 0,
                      width: 320,
                      height: 60,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: cKelpGreen.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                    color: cKelpGreen.withValues(alpha: 0.5)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text('PREFER', style: kDoStyle),
                  const SizedBox(height: 6),
                  Center(
                    child: _mockNavBar(
                      layout: a['goodLayout'] as String,
                      items: a['goodItems'] as List<Map<String, Object>>,
                      selectedIndex: 0,
                      width: 320,
                      height: 60,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  return Wrap(spacing: 14, runSpacing: 14, children: cards);
}

// ===========================================================================
//  SECTION 12 --- Glossary
// ===========================================================================

Widget _buildGlossary() {
  print(' Building Section 12: glossary.');
  final List<Map<String, String>> entries = <Map<String, String>>[
    {
      'term': 'orientation',
      'def': 'The aspect ratio of the parent. Flutter exposes it as '
          'MediaQuery.of(context).orientation, which is either '
          'Orientation.portrait (taller than wide) or Orientation.landscape '
          '(wider than tall).',
    },
    {
      'term': 'breakpoint',
      'def': 'A logical pixel width threshold at which a design changes '
          'shape. BottomNavigationBarLandscapeLayout is itself a '
          'kind of breakpoint --- the bar switches behaviour at the '
          'portrait/landscape boundary.',
    },
    {
      'term': 'safe area',
      'def': 'The rectangle of the screen NOT covered by system intrusions '
          '(notch, status bar, gesture insets). BottomNavigationBar '
          'lives at the bottom of the safe area; the chosen landscape '
          'layout simply rearranges items inside that strip.',
    },
    {
      'term': 'gutter',
      'def': 'Empty padding flanking a content region. With centered, the '
          'gutters are large; with spread/linear they are zero.',
    },
    {
      'term': 'item slot',
      'def': 'The horizontal share of the bar that a single nav item gets. '
          'In spread/linear every slot is equal; in centered there ARE '
          'no equal slots --- items are sized to fit and grouped.',
    },
    {
      'term': 'icon-above-label',
      'def': 'A vertical tile layout where the icon stacks on top of the '
          'label. Used by spread and centered.',
    },
    {
      'term': 'icon-beside-label',
      'def': 'A horizontal tile layout where the icon sits to the left of '
          'the label. Used by linear.',
    },
    {
      'term': 'BottomNavigationBarType.fixed',
      'def': 'A type of BottomNavigationBar where every item shows its '
          'label and the bar background is a single color. Plays well '
          'with all three landscape layouts.',
    },
    {
      'term': 'BottomNavigationBarType.shifting',
      'def': 'A type where the selected item grows and the bar background '
          'changes to that item\'s color. The growth still respects the '
          'chosen landscape layout, but with centered, the growing item '
          'can push neighbours.',
    },
    {
      'term': 'currentIndex',
      'def': 'Which item is currently selected. The selected item is '
          'highlighted regardless of which landscape layout is in use.',
    },
    {
      'term': 'landscapeLayout (parameter)',
      'def': 'The named argument on BottomNavigationBar that takes a '
          'BottomNavigationBarLandscapeLayout. Nullable; null defaults '
          'to spread at layout time.',
    },
    {
      'term': 'NavigationBar (Material 3)',
      'def': 'The Material 3 successor to BottomNavigationBar. It does '
          'NOT expose landscapeLayout; in landscape it uses an inline '
          'icon+label tile.',
    },
    {
      'term': 'NavigationRail',
      'def': 'A vertical sibling to BottomNavigationBar designed for '
          'wide layouts. Often the right answer for tablet-first UI '
          'instead of trying to make BottomNavigationBar adapt.',
    },
    {
      'term': 'showSelectedLabels',
      'def': 'When false, only the selected item\'s label is visible. '
          'Interacts subtly with linear (which assumes a label is '
          'always present beside the icon).',
    },
  ];

  final List<Widget> tiles = <Widget>[];
  for (int i = 0; i < entries.length; i++) {
    final Map<String, String> e = entries[i];
    final BoxDecoration tileDeco = BoxDecoration(
      color: cSandPale,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: cDriftwoodDark.withValues(alpha: 0.6)),
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
                color: cCoralDeep,
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
//  SECTION 13 --- Closing essay (200-word prose)
// ===========================================================================

Widget _buildClosingEssay() {
  print(' Building Section 13: closing essay.');
  // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #37, P5(a)):
  // Original combined `Border(left: 6px cerulean, right/top/bottom: 1px
  // driftwoodDark)` with `borderRadius: 10`. Flutter rejects the non-
  // uniform border + rounded corners with "A borderRadius can only be
  // given on borders with uniform colors." Canonical P5(a) fix: outer
  // Container uses uniform `Border.all(driftwoodDark, 1)` + rounded
  // corners + `clipBehavior: Clip.antiAlias`; the 6-px cerulean accent
  // strip is a sibling `Container(width: 6)` inside `IntrinsicHeight >
  // Row(crossAxisAlignment: stretch)`. Visually identical.
  final BoxDecoration essayDeco = BoxDecoration(
    color: cSandPale,
    borderRadius: BorderRadius.circular(10),
    border: Border.all(color: cDriftwoodDark, width: 1),
    boxShadow: <BoxShadow>[
      BoxShadow(
        color: cBrineInk.withValues(alpha: 0.16),
        blurRadius: 6,
        offset: const Offset(0, 3),
      ),
    ],
  );

  return Container(
    decoration: essayDeco,
    clipBehavior: Clip.antiAlias,
    child: IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(width: 6, color: cOceanCerulean),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text(
                    'PORTRAIT VS LANDSCAPE --- A QUIET DICHOTOMY',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: cOceanDeep,
                      letterSpacing: 1.0,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'A bottom navigation bar in portrait is a thumb-rest. The hand '
                    'cradles the phone, the thumb arcs across the bottom edge, and '
                    'every icon-above-label tile lands inside that arc. Five tiles, '
                    'five thumb destinations, no calculus. Landscape is different. '
                    'The phone is sideways, two hands are on it, the thumbs are '
                    'closer to the bezels, and the bottom edge has stretched to '
                    'twice its old length. Suddenly there is empty room in the '
                    'middle of the bar, and the eye notices it. This is the '
                    'question BottomNavigationBarLandscapeLayout answers. Spread '
                    'says: keep the portrait shape, just stretch it; the user\'s '
                    'muscle memory wins. Centered says: cluster the items where '
                    'the eye expects a control surface; the tablet-dock metaphor '
                    'wins. Linear says: take the landscape on its own terms, lay '
                    'each item out as a horizontal pill, treat the bar as a '
                    'flattened rail; the readability wins. Three answers, no '
                    'wrong ones --- only fits and misfits. The job of the '
                    'designer is to pick the answer that lets the bar disappear, '
                    'so the body of the app can speak.',
                    style: TextStyle(
                      fontSize: 12,
                      color: cBrineInk,
                      height: 1.55,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

// ===========================================================================
//  SECTION 14 --- Recap footer
// ===========================================================================

Widget _buildRecapFooter() {
  print(' Building Section 14: recap footer.');
  // Footer mirrors the title hero: ocean + cerulean + chrome rail.
  final BoxDecoration footerDeco = BoxDecoration(
    gradient: const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: <Color>[cOceanCerulean, cOceanDeep, cBrineInk],
    ),
    borderRadius: BorderRadius.circular(14),
    boxShadow: <BoxShadow>[
      BoxShadow(
        color: cBrineInk.withValues(alpha: 0.5),
        blurRadius: 14,
        offset: const Offset(0, 8),
      ),
    ],
    border: Border.all(color: cChromeRail, width: 2),
  );

  return Container(
    decoration: footerDeco,
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        Text(
          'RECAP --- WALKING BACK DOWN THE PIER',
          style: TextStyle(
            color: cOceanFoam,
            fontSize: 18,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.4,
          ),
        ),
        SizedBox(height: 10),
        Text(
          'spread keeps portrait habits in landscape.\n'
          'centered makes a wide bar feel like a tablet dock.\n'
          'linear flattens the bar into a horizontal rail.\n'
          '\n'
          'The default is spread; do not switch off it casually --- '
          'muscle memory is a feature. Reach for centered when 3 items '
          'rattle around in a wide bar. Reach for linear when labels '
          'are doing real work and the screen is wide enough to grant '
          'them room. And remember: in portrait, none of this matters. '
          'The enum is silent until the screen lies down.',
          style: TextStyle(
            color: cBoneWhite,
            fontSize: 12,
            height: 1.5,
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// END --- BottomNavigationBarLandscapeLayout deep demo, "Pier Cerulean" theme.
// =============================================================================
