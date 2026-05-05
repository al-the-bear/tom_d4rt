// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// =============================================================================
//                  STAINED GLASS CATHEDRAL --- BoxDecoration
// =============================================================================
//
//  TARGET WIDGET .... BoxDecoration  (package:flutter/painting.dart)
//  CONTEXT .......... A pure painting object handed to a Container's
//                     `decoration:` slot. NOT a widget. It describes how a
//                     rectangular box should be PAINTED, but it does not lay
//                     out, hit-test by itself, or participate in the widget
//                     tree directly. It is data; Container uses it.
//
//  THEME ............ STAINED GLASS CATHEDRAL
//
//                     We imagine a 14th-century stone cathedral with the
//                     afternoon sun pouring through tall lancet windows.
//                     Each pane is leaded into place; the stone tracery
//                     forms the borders; the colored glass is the gradient;
//                     the wash of color on the flagstone floor is the
//                     boxShadow. The entire building is a tutorial in how
//                     you stack: shape, fill, gradient, image, border,
//                     shadow --- which is exactly the painting recipe a
//                     BoxDecoration encodes for Flutter.
//
//                     We use that metaphor throughout this file. Every
//                     palette color is named after a part of the cathedral:
//                     vault, transept, rose-window, narthex, lancet-blue,
//                     reliquary-gold, etc.
//
//  SHAPE OF THIS FILE
//
//      Section  1 .... Title banner with palette swatches
//      Section  2 .... Prose anatomy of BoxDecoration
//      Section  3 .... Property anatomy with color swatches
//      Section  4 .... Color showcase (8 boxes)
//      Section  5 .... Border showcase (6+ boxes)
//      Section  6 .... BorderRadius showcase (6+ boxes)
//      Section  7 .... BoxShadow showcase (6+ boxes)
//      Section  8 .... Gradient showcase (6+ boxes)
//      Section  9 .... Shape (rectangle vs circle) showcase
//      Section 10 .... blendMode showcase
//      Section 11 .... lerp / copyWith demonstrations
//      Section 12 .... DO / AVOID callouts
//      Section 13 .... Code-snippet recipe cards
//      Section 14 .... Glossary
//      Section 15 .... Recap footer
//
//  D4RT CONSTRAINTS
//
//      * build() is called exactly ONCE. We return a snapshot.
//      * No StatefulWidget, no setState, no controllers, no timers,
//        no futures, no streams.
//      * No `for-in` over BridgedInstance: we use indexed loops.
//      * No `.value` on Tween.animate: we don't animate at all.
//      * Use `.withValues(alpha:...)` (not `.withOpacity`).
//
// =============================================================================

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
//  PALETTE  ---  Stained Glass Cathedral
// ---------------------------------------------------------------------------
//  14+ named colors. Each is an ARGB Color. We treat them as named tokens
//  and reference them everywhere instead of hard-coded hex values, the same
//  way a real design system would expose them as theme tokens.
// ---------------------------------------------------------------------------

const Color cVaultStone = Color(0xFFE8E1D2); // pale limestone of the vault
const Color cFlagstone = Color(0xFFC9BFA8); // worn floor stone
const Color cTracery = Color(0xFF6B5A3E); // dark leaded outline
const Color cLancetBlue = Color(0xFF1F3D7A); // deep window blue
const Color cAzureGlass = Color(0xFF4A78C9); // brighter sky blue
const Color cRoseRed = Color(0xFFB22222); // rose-window crimson
const Color cMartyrPurple = Color(0xFF6B2A7A); // bishop's purple
const Color cReliquaryGold = Color(0xFFD9A441); // gilded gold
const Color cIncenseGreen = Color(0xFF3F6B4E); // mossy choir green
const Color cChalkLight = Color(0xFFF7F2E8); // candle-white
const Color cTransept = Color(0xFF2E2A22); // shadowed transept
const Color cNarthex = Color(0xFF8C7A5C); // narthex tan
const Color cAltarSilver = Color(0xFFC0C5CB); // chased silver
const Color cVespersOrange = Color(0xFFE07A2C); // vespers sunlight
const Color cPilgrimRose = Color(0xFFE8A6B0); // pilgrim's rose
const Color cReredosWine = Color(0xFF5B1A2A); // reredos burgundy

// A list of palette swatches we render in the title banner.
// We keep it as a simple list of (name, color) records expressed as
// constant maps so that we can iterate by index.
const List<Map<String, Object>> kPalette = <Map<String, Object>>[
  {'name': 'vaultStone', 'color': cVaultStone},
  {'name': 'flagstone', 'color': cFlagstone},
  {'name': 'tracery', 'color': cTracery},
  {'name': 'lancetBlue', 'color': cLancetBlue},
  {'name': 'azureGlass', 'color': cAzureGlass},
  {'name': 'roseRed', 'color': cRoseRed},
  {'name': 'martyrPurple', 'color': cMartyrPurple},
  {'name': 'reliquaryGold', 'color': cReliquaryGold},
  {'name': 'incenseGreen', 'color': cIncenseGreen},
  {'name': 'chalkLight', 'color': cChalkLight},
  {'name': 'transept', 'color': cTransept},
  {'name': 'narthex', 'color': cNarthex},
  {'name': 'altarSilver', 'color': cAltarSilver},
  {'name': 'vespersOrange', 'color': cVespersOrange},
  {'name': 'pilgrimRose', 'color': cPilgrimRose},
  {'name': 'reredosWine', 'color': cReredosWine},
];

// ---------------------------------------------------------------------------
//  TEXT TOKENS
// ---------------------------------------------------------------------------

const TextStyle kTitleStyle = TextStyle(
  fontSize: 28,
  fontWeight: FontWeight.w800,
  color: cChalkLight,
  letterSpacing: 1.4,
);

const TextStyle kSubtitleStyle = TextStyle(
  fontSize: 14,
  fontStyle: FontStyle.italic,
  color: cChalkLight,
);

const TextStyle kSectionHeaderStyle = TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.w700,
  color: cTransept,
);

const TextStyle kSectionLeadStyle = TextStyle(
  fontSize: 13,
  height: 1.4,
  color: cTransept,
);

const TextStyle kBodyStyle = TextStyle(
  fontSize: 12,
  height: 1.4,
  color: cTransept,
);

const TextStyle kSmallLabelStyle = TextStyle(
  fontSize: 11,
  color: cTracery,
  fontWeight: FontWeight.w600,
);

const TextStyle kCodeStyle = TextStyle(
  fontFamily: 'monospace',
  fontSize: 12,
  color: cChalkLight,
);

const TextStyle kCalloutDoStyle = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.w700,
  color: cIncenseGreen,
);

const TextStyle kCalloutAvoidStyle = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.w700,
  color: cRoseRed,
);

// ---------------------------------------------------------------------------
//  BUILD ENTRY POINT
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  print('===============================================================');
  print(' Stained Glass Cathedral --- BoxDecoration deep demo');
  print('===============================================================');
  print(' Building ONE snapshot widget tree.');
  print(' We will construct >= 30 real BoxDecoration instances.');
  print(' Each is fed to a Container as `decoration:`.');

  // The heart of the demo: assemble all sections.
  final sections = <Widget>[
    _buildTitleBanner(),
    _spacer(20),
    _buildAnatomySection(),
    _spacer(20),
    _buildPropertyAnatomy(),
    _spacer(20),
    _buildSectionHeader('4. Color showcase --- 8 solid fills'),
    _buildColorShowcase(),
    _spacer(20),
    _buildSectionHeader('5. Border showcase --- the leaded tracery'),
    _buildBorderShowcase(),
    _spacer(20),
    _buildSectionHeader('6. BorderRadius showcase --- arched windows'),
    _buildBorderRadiusShowcase(),
    _spacer(20),
    _buildSectionHeader('7. BoxShadow showcase --- pools of light'),
    _buildBoxShadowShowcase(),
    _spacer(20),
    _buildSectionHeader('8. Gradient showcase --- glass under sun'),
    _buildGradientShowcase(),
    _spacer(20),
    _buildSectionHeader('9. Shape --- rectangle vs circle'),
    _buildShapeShowcase(),
    _spacer(20),
    _buildSectionHeader('10. backgroundBlendMode --- pigment chemistry'),
    _buildBlendModeShowcase(),
    _spacer(20),
    _buildSectionHeader('11. lerp + copyWith --- two great hammers'),
    _buildLerpAndCopyWith(),
    _spacer(20),
    _buildSectionHeader('12. DO / AVOID callouts'),
    _buildDoAvoidCallouts(),
    _spacer(20),
    _buildSectionHeader('13. Code-snippet recipe cards'),
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
    backgroundColor: cVaultStone,
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
  return Padding(
    padding: const EdgeInsets.only(top: 12, bottom: 8),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: const BoxDecoration(
        color: cChalkLight,
        border: Border(
          left: BorderSide(color: cReliquaryGold, width: 6),
          bottom: BorderSide(color: cTracery, width: 1),
        ),
      ),
      child: Text(text, style: kSectionHeaderStyle),
    ),
  );
}

// ===========================================================================
//  SECTION 1 --- Title banner with palette swatches
// ===========================================================================

Widget _buildTitleBanner() {
  // The banner itself uses a real BoxDecoration with a gradient + shadow.
  // BoxDecoration #1.
  final BoxDecoration bannerDeco = BoxDecoration(
    gradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[cTransept, cLancetBlue, cMartyrPurple],
      stops: <double>[0.0, 0.55, 1.0],
    ),
    borderRadius: BorderRadius.circular(14),
    boxShadow: <BoxShadow>[
      BoxShadow(
        color: cTransept.withValues(alpha: 0.55),
        blurRadius: 18,
        offset: const Offset(0, 8),
      ),
    ],
    border: Border.all(color: cReliquaryGold, width: 2),
  );

  // A single-row horizontal palette swatch strip.
  final swatches = <Widget>[];
  for (int i = 0; i < kPalette.length; i++) {
    final entry = kPalette[i];
    final c = entry['color'] as Color;
    final n = entry['name'] as String;
    // BoxDecoration for each swatch (counts toward our 30+).
    final swatchDeco = BoxDecoration(
      color: c,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: cChalkLight.withValues(alpha: 0.7), width: 1),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: cTransept.withValues(alpha: 0.35),
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
              width: 56,
              child: Text(
                n,
                style: const TextStyle(fontSize: 9, color: cChalkLight),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  return Container(
    decoration: bannerDeco,
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('STAINED GLASS CATHEDRAL', style: kTitleStyle),
        const SizedBox(height: 6),
        const Text(
          'A deep walkthrough of BoxDecoration, the painting recipe behind '
          'every Container fill in Flutter. We treat the cathedral as a '
          'metaphor: stone, leaded glass, gold light, and long shadows.',
          style: kSubtitleStyle,
        ),
        const SizedBox(height: 14),
        const Text(
          'PALETTE',
          style: TextStyle(
            color: cReliquaryGold,
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
//  SECTION 2 --- Prose anatomy of BoxDecoration
// ===========================================================================

Widget _buildAnatomySection() {
  print(' Building Section 2: prose anatomy.');
  // BoxDecoration for the prose card itself.
  final proseDeco = BoxDecoration(
    color: cChalkLight,
    borderRadius: BorderRadius.circular(10),
    border: Border.all(color: cTracery, width: 1),
    boxShadow: <BoxShadow>[
      BoxShadow(
        color: cTracery.withValues(alpha: 0.25),
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
        Text('1. WHAT IS BoxDecoration?', style: kSectionHeaderStyle),
        SizedBox(height: 10),
        Text(
          'BoxDecoration is a pure data class from package:flutter/painting.dart. '
          'It describes how a rectangular (or circular) box should be PAINTED. '
          'It is not a widget. It does not lay out children. It does not '
          'react to gestures on its own. It is fed, normally, to the '
          'decoration: slot of a Container, but it can also be used by '
          'DecoratedBox, Ink, AnimatedContainer, and any custom widget that '
          'wants Flutter\'s standard painting recipe.',
          style: kSectionLeadStyle,
        ),
        SizedBox(height: 12),
        Text('THE PAINTING PIPELINE', style: kSmallLabelStyle),
        SizedBox(height: 6),
        Text(
          'When the engine asks the BoxDecoration to paint, it draws the '
          'layers in this fixed order:\n'
          '   1. Shadows (boxShadow list, painted under everything else)\n'
          '   2. Fill color (color)\n'
          '   3. Gradient (gradient, painted over the color)\n'
          '   4. Image (image, painted over the gradient)\n'
          '   5. Border (border, painted last so it sits on top)\n'
          '\n'
          'shape decides whether the fill / gradient / image is clipped to '
          'a rectangle (optionally rounded by borderRadius) or to a circle '
          'inscribed in the box.',
          style: kBodyStyle,
        ),
        SizedBox(height: 12),
        Text('WHERE DOES IT SIT?', style: kSmallLabelStyle),
        SizedBox(height: 6),
        Text(
          'Container delegates painting to a chain of widgets, one of which '
          'is DecoratedBox. The BoxDecoration is what DecoratedBox holds. '
          'So conceptually:\n\n'
          '   Container( decoration: BoxDecoration( ... ) )\n'
          '          --->  DecoratedBox( decoration: ... )\n'
          '          --->  RenderDecoratedBox\n'
          '          --->  BoxPainter ( engine canvas )\n\n'
          'BoxDecoration is the script. The Canvas is the stage.',
          style: kBodyStyle,
        ),
      ],
    ),
  );
}

// ===========================================================================
//  SECTION 3 --- Property anatomy with color swatches
// ===========================================================================

Widget _buildPropertyAnatomy() {
  print(' Building Section 3: property anatomy.');
  // 8 properties, each with its swatch color.
  final properties = <Map<String, Object>>[
    {
      'name': 'color',
      'swatch': cLancetBlue,
      'desc': 'Solid fill painted before gradient and image.',
    },
    {
      'name': 'image',
      'swatch': cReliquaryGold,
      'desc': 'A DecorationImage painted over the gradient.',
    },
    {
      'name': 'border',
      'swatch': cTracery,
      'desc': 'Outline drawn last; uses Border or BorderDirectional.',
    },
    {
      'name': 'borderRadius',
      'swatch': cAzureGlass,
      'desc': 'Rounds the rectangle. Ignored when shape == circle.',
    },
    {
      'name': 'boxShadow',
      'swatch': cTransept,
      'desc': 'List<BoxShadow> painted underneath the box.',
    },
    {
      'name': 'gradient',
      'swatch': cVespersOrange,
      'desc': 'Linear / Radial / Sweep, painted over color.',
    },
    {
      'name': 'backgroundBlendMode',
      'swatch': cMartyrPurple,
      'desc': 'BlendMode applied to color + gradient layer.',
    },
    {
      'name': 'shape',
      'swatch': cIncenseGreen,
      'desc': 'BoxShape.rectangle (default) or BoxShape.circle.',
    },
  ];

  final tiles = <Widget>[];
  for (int i = 0; i < properties.length; i++) {
    final p = properties[i];
    // BoxDecoration for the swatch dot.
    final swatchDeco = BoxDecoration(
      color: p['swatch'] as Color,
      shape: BoxShape.circle,
      border: Border.all(color: cTransept, width: 1),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: cTransept.withValues(alpha: 0.3),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    );
    // BoxDecoration for the tile background.
    final tileDeco = BoxDecoration(
      color: cChalkLight,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: cTracery.withValues(alpha: 0.4)),
    );
    tiles.add(
      Container(
        decoration: tileDeco,
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(width: 22, height: 22, decoration: swatchDeco),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    p['name'] as String,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 13,
                      color: cTransept,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(p['desc'] as String, style: kBodyStyle),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Lay out as a 2-column grid using a Wrap of fixed-width tiles.
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _buildSectionHeader('3. Property anatomy --- 8 keys'),
      Wrap(
        spacing: 10,
        runSpacing: 10,
        children: tiles
            .map(
              (w) => SizedBox(
                width: 320,
                child: w,
              ),
            )
            .toList(),
      ),
    ],
  );
}

// ===========================================================================
//  SECTION 4 --- Color showcase (8 solid fills)
// ===========================================================================

Widget _buildColorShowcase() {
  print(' Building Section 4: color showcase.');
  // 8 colors x varying borderRadius. Each is a real BoxDecoration on a
  // Container, so they all count toward our 30+ instance budget.
  final swatches = <Map<String, Object>>[
    {'name': 'lancetBlue', 'c': cLancetBlue, 'r': 0.0},
    {'name': 'roseRed', 'c': cRoseRed, 'r': 4.0},
    {'name': 'reliquaryGold', 'c': cReliquaryGold, 'r': 8.0},
    {'name': 'incenseGreen', 'c': cIncenseGreen, 'r': 12.0},
    {'name': 'martyrPurple', 'c': cMartyrPurple, 'r': 18.0},
    {'name': 'vespersOrange', 'c': cVespersOrange, 'r': 24.0},
    {'name': 'pilgrimRose', 'c': cPilgrimRose, 'r': 32.0},
    {'name': 'altarSilver', 'c': cAltarSilver, 'r': 40.0},
  ];

  final tiles = <Widget>[];
  for (int i = 0; i < swatches.length; i++) {
    final s = swatches[i];
    final color = s['c'] as Color;
    final radius = s['r'] as double;
    final name = s['name'] as String;
    // Real BoxDecoration #N.
    final deco = BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(color: cTransept.withValues(alpha: 0.35), width: 1),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: cTransept.withValues(alpha: 0.35),
          blurRadius: 5,
          offset: const Offset(0, 3),
        ),
      ],
    );
    tiles.add(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(width: 110, height: 70, decoration: deco),
          const SizedBox(height: 4),
          Text(
            '$name r=$radius',
            style: const TextStyle(fontSize: 10, color: cTransept),
          ),
        ],
      ),
    );
  }

  return Wrap(spacing: 12, runSpacing: 14, children: tiles);
}

// ===========================================================================
//  SECTION 5 --- Border showcase (6+ boxes)
// ===========================================================================

Widget _buildBorderShowcase() {
  print(' Building Section 5: border showcase.');
  final tiles = <Widget>[];

  // 1. Border.all uniform thin.
  tiles.add(
    _borderTile(
      'Border.all w=1',
      BoxDecoration(
        color: cChalkLight,
        border: Border.all(color: cTracery, width: 1),
      ),
    ),
  );
  // 2. Border.all thick.
  tiles.add(
    _borderTile(
      'Border.all w=6',
      BoxDecoration(
        color: cChalkLight,
        border: Border.all(color: cReliquaryGold, width: 6),
      ),
    ),
  );
  // 3. Border.symmetric.
  tiles.add(
    _borderTile(
      'Border.symmetric',
      BoxDecoration(
        color: cChalkLight,
        border: Border.symmetric(
          horizontal: BorderSide(color: cRoseRed, width: 5),
          vertical: BorderSide(color: cLancetBlue, width: 1),
        ),
      ),
    ),
  );
  // 4. Custom per-side widths.
  tiles.add(
    _borderTile(
      'asymmetric sides',
      BoxDecoration(
        color: cChalkLight,
        border: const Border(
          top: BorderSide(color: cVespersOrange, width: 8),
          right: BorderSide(color: cIncenseGreen, width: 3),
          bottom: BorderSide(color: cMartyrPurple, width: 1),
          left: BorderSide(color: cReliquaryGold, width: 5),
        ),
      ),
    ),
  );
  // 5. Border + radius.
  tiles.add(
    _borderTile(
      'border + radius',
      BoxDecoration(
        color: cAzureGlass,
        border: Border.all(color: cTransept, width: 3),
        borderRadius: BorderRadius.circular(14),
      ),
    ),
  );
  // 6. Dashed-feel via thick gold + thin black.
  tiles.add(
    _borderTile(
      'inner+outer feel',
      BoxDecoration(
        color: cChalkLight,
        border: Border.all(color: cTransept, width: 4),
        borderRadius: BorderRadius.circular(2),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: cReliquaryGold,
            blurRadius: 0,
            spreadRadius: 2,
            offset: Offset(0, 0),
          ),
        ],
      ),
    ),
  );
  // 7. Tall narrow with stroke.
  tiles.add(
    _borderTile(
      'tall lancet',
      BoxDecoration(
        color: cLancetBlue,
        border: Border.all(color: cReliquaryGold, width: 2),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
      ),
    ),
  );
  // 8. Triple-stack via container nesting illustrated by border only.
  tiles.add(
    _borderTile(
      'thick top only',
      BoxDecoration(
        color: cFlagstone,
        border: const Border(
          top: BorderSide(color: cReliquaryGold, width: 10),
        ),
      ),
    ),
  );

  return Wrap(spacing: 12, runSpacing: 14, children: tiles);
}

Widget _borderTile(String label, BoxDecoration deco) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Container(width: 130, height: 80, decoration: deco),
      const SizedBox(height: 4),
      SizedBox(
        width: 130,
        child: Text(
          label,
          style: const TextStyle(fontSize: 10, color: cTransept),
        ),
      ),
    ],
  );
}

// ===========================================================================
//  SECTION 6 --- BorderRadius showcase (6+ boxes)
// ===========================================================================

Widget _buildBorderRadiusShowcase() {
  print(' Building Section 6: borderRadius showcase.');
  final tiles = <Widget>[];

  // 1. Zero (default).
  tiles.add(
    _borderTile(
      'BorderRadius.zero',
      BoxDecoration(
        color: cIncenseGreen,
        border: Border.all(color: cTransept),
      ),
    ),
  );
  // 2. circular(8)
  tiles.add(
    _borderTile(
      'circular(8)',
      BoxDecoration(
        color: cIncenseGreen,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: cTransept),
      ),
    ),
  );
  // 3. circular(24)
  tiles.add(
    _borderTile(
      'circular(24)',
      BoxDecoration(
        color: cIncenseGreen,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: cTransept),
      ),
    ),
  );
  // 4. only(topLeft)
  tiles.add(
    _borderTile(
      'only(topLeft 30)',
      BoxDecoration(
        color: cMartyrPurple,
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(30)),
        border: Border.all(color: cTransept),
      ),
    ),
  );
  // 5. horizontal
  tiles.add(
    _borderTile(
      'horizontal(20)',
      BoxDecoration(
        color: cVespersOrange,
        borderRadius: const BorderRadius.horizontal(
          left: Radius.circular(20),
          right: Radius.circular(40),
        ),
        border: Border.all(color: cTransept),
      ),
    ),
  );
  // 6. vertical
  tiles.add(
    _borderTile(
      'vertical(top 25)',
      BoxDecoration(
        color: cReliquaryGold,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
        border: Border.all(color: cTransept),
      ),
    ),
  );
  // 7. Mixed elliptical
  tiles.add(
    _borderTile(
      'elliptical',
      BoxDecoration(
        color: cAzureGlass,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.elliptical(40, 12),
          bottomRight: Radius.elliptical(40, 12),
        ),
        border: Border.all(color: cTransept),
      ),
    ),
  );
  // 8. Pill
  tiles.add(
    _borderTile(
      'pill',
      BoxDecoration(
        color: cPilgrimRose,
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: cTransept),
      ),
    ),
  );

  return Wrap(spacing: 12, runSpacing: 14, children: tiles);
}

// ===========================================================================
//  SECTION 7 --- BoxShadow showcase (6+ boxes)
// ===========================================================================

Widget _buildBoxShadowShowcase() {
  print(' Building Section 7: boxShadow showcase.');
  final tiles = <Widget>[];

  // 1. small soft drop.
  tiles.add(
    _shadowTile(
      'soft drop',
      BoxDecoration(
        color: cChalkLight,
        borderRadius: BorderRadius.circular(8),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: cTransept.withValues(alpha: 0.25),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
    ),
  );
  // 2. high elevation.
  tiles.add(
    _shadowTile(
      'high elevation',
      BoxDecoration(
        color: cChalkLight,
        borderRadius: BorderRadius.circular(8),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: cTransept.withValues(alpha: 0.45),
            blurRadius: 18,
            offset: const Offset(0, 12),
          ),
        ],
      ),
    ),
  );
  // 3. spread.
  tiles.add(
    _shadowTile(
      'spread',
      BoxDecoration(
        color: cChalkLight,
        borderRadius: BorderRadius.circular(8),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: cReliquaryGold.withValues(alpha: 0.55),
            blurRadius: 4,
            spreadRadius: 4,
            offset: const Offset(0, 0),
          ),
        ],
      ),
    ),
  );
  // 4. coloured glow.
  tiles.add(
    _shadowTile(
      'coloured glow',
      BoxDecoration(
        color: cLancetBlue,
        borderRadius: BorderRadius.circular(8),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: cAzureGlass.withValues(alpha: 0.7),
            blurRadius: 14,
            spreadRadius: 1,
            offset: const Offset(0, 0),
          ),
        ],
      ),
    ),
  );
  // 5. multiple shadows (layered).
  tiles.add(
    _shadowTile(
      'two shadows',
      BoxDecoration(
        color: cChalkLight,
        borderRadius: BorderRadius.circular(8),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: cRoseRed.withValues(alpha: 0.45),
            blurRadius: 6,
            offset: const Offset(-4, 4),
          ),
          BoxShadow(
            color: cIncenseGreen.withValues(alpha: 0.45),
            blurRadius: 6,
            offset: const Offset(4, 4),
          ),
        ],
      ),
    ),
  );
  // 6. sharp / no blur.
  tiles.add(
    _shadowTile(
      'sharp ridge',
      BoxDecoration(
        color: cChalkLight,
        borderRadius: BorderRadius.circular(2),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: cTransept,
            blurRadius: 0,
            offset: Offset(4, 4),
          ),
        ],
      ),
    ),
  );
  // 7. inset feel via dark color + small blur (pseudo-inner).
  tiles.add(
    _shadowTile(
      'pseudo-inset',
      BoxDecoration(
        color: cFlagstone,
        borderRadius: BorderRadius.circular(8),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: cTransept.withValues(alpha: 0.5),
            blurRadius: 2,
            spreadRadius: -2,
            offset: const Offset(0, 2),
          ),
        ],
      ),
    ),
  );
  // 8. floor wash.
  tiles.add(
    _shadowTile(
      'long floor wash',
      BoxDecoration(
        color: cReliquaryGold,
        borderRadius: BorderRadius.circular(20),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: cVespersOrange.withValues(alpha: 0.5),
            blurRadius: 30,
            spreadRadius: 6,
            offset: const Offset(0, 18),
          ),
        ],
      ),
    ),
  );

  return Wrap(spacing: 16, runSpacing: 22, children: tiles);
}

Widget _shadowTile(String label, BoxDecoration deco) {
  return Padding(
    padding: const EdgeInsets.all(8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(width: 110, height: 70, decoration: deco),
        const SizedBox(height: 6),
        SizedBox(
          width: 130,
          child: Text(
            label,
            style: const TextStyle(fontSize: 10, color: cTransept),
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
//  SECTION 8 --- Gradient showcase (6+ boxes)
// ===========================================================================

Widget _buildGradientShowcase() {
  print(' Building Section 8: gradient showcase.');
  final tiles = <Widget>[];

  // 1. Linear top->bottom.
  tiles.add(
    _gradientTile(
      'Linear top->bottom',
      BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[cAzureGlass, cLancetBlue],
        ),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: cTransept),
      ),
    ),
  );
  // 2. Linear diagonal.
  tiles.add(
    _gradientTile(
      'Linear TL->BR',
      BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[cVespersOrange, cRoseRed, cMartyrPurple],
          stops: <double>[0.0, 0.5, 1.0],
        ),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: cTransept),
      ),
    ),
  );
  // 3. Linear with custom stops.
  tiles.add(
    _gradientTile(
      'stops 0/.2/1',
      BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: <Color>[cReliquaryGold, cChalkLight, cIncenseGreen],
          stops: <double>[0.0, 0.2, 1.0],
        ),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: cTransept),
      ),
    ),
  );
  // 4. Radial centred.
  tiles.add(
    _gradientTile(
      'Radial centre',
      BoxDecoration(
        gradient: const RadialGradient(
          center: Alignment.center,
          radius: 0.7,
          colors: <Color>[cReliquaryGold, cVespersOrange, cReredosWine],
          stops: <double>[0.0, 0.5, 1.0],
        ),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: cTransept),
      ),
    ),
  );
  // 5. Radial off-centre.
  tiles.add(
    _gradientTile(
      'Radial NE',
      BoxDecoration(
        gradient: const RadialGradient(
          center: Alignment.topRight,
          radius: 1.2,
          colors: <Color>[cChalkLight, cAzureGlass, cLancetBlue],
        ),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: cTransept),
      ),
    ),
  );
  // 6. Sweep full circle.
  tiles.add(
    _gradientTile(
      'Sweep 0..2pi',
      BoxDecoration(
        gradient: const SweepGradient(
          colors: <Color>[
            cRoseRed,
            cVespersOrange,
            cReliquaryGold,
            cIncenseGreen,
            cAzureGlass,
            cMartyrPurple,
            cRoseRed,
          ],
        ),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: cTransept),
      ),
    ),
  );
  // 7. Sweep partial.
  tiles.add(
    _gradientTile(
      'Sweep 0..pi',
      BoxDecoration(
        gradient: SweepGradient(
          startAngle: 0,
          endAngle: 3.14,
          colors: const <Color>[cAzureGlass, cMartyrPurple, cRoseRed],
        ),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: cTransept),
      ),
    ),
  );
  // 8. Linear with alpha.
  tiles.add(
    _gradientTile(
      'Linear+alpha',
      BoxDecoration(
        color: cTransept,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            cChalkLight.withValues(alpha: 0.0),
            cChalkLight.withValues(alpha: 0.7),
          ],
        ),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: cTransept),
      ),
    ),
  );

  return Wrap(spacing: 12, runSpacing: 14, children: tiles);
}

Widget _gradientTile(String label, BoxDecoration deco) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Container(width: 130, height: 80, decoration: deco),
      const SizedBox(height: 4),
      SizedBox(
        width: 130,
        child: Text(
          label,
          style: const TextStyle(fontSize: 10, color: cTransept),
        ),
      ),
    ],
  );
}

// ===========================================================================
//  SECTION 9 --- Shape (rectangle vs circle) showcase
// ===========================================================================

Widget _buildShapeShowcase() {
  print(' Building Section 9: shape showcase.');
  final tiles = <Widget>[];

  // 1. rectangle plain.
  tiles.add(
    _shapeTile(
      'rectangle',
      BoxDecoration(
        color: cLancetBlue,
        shape: BoxShape.rectangle,
        border: Border.all(color: cTransept, width: 2),
      ),
    ),
  );
  // 2. rectangle with radius.
  tiles.add(
    _shapeTile(
      'rect+radius',
      BoxDecoration(
        color: cIncenseGreen,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: cTransept, width: 2),
      ),
    ),
  );
  // 3. circle plain.
  tiles.add(
    _shapeTile(
      'circle',
      BoxDecoration(
        color: cMartyrPurple,
        shape: BoxShape.circle,
        border: Border.all(color: cReliquaryGold, width: 3),
      ),
    ),
  );
  // 4. circle with shadow.
  tiles.add(
    _shapeTile(
      'circle+shadow',
      BoxDecoration(
        color: cReliquaryGold,
        shape: BoxShape.circle,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: cTransept.withValues(alpha: 0.5),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
    ),
  );
  // 5. circle with gradient.
  tiles.add(
    _shapeTile(
      'circle+gradient',
      const BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: <Color>[cChalkLight, cVespersOrange, cReredosWine],
        ),
      ),
    ),
  );
  // 6. tall non-square circle (still a circle inscribed).
  tiles.add(
    _shapeTile(
      'circle (tall box)',
      BoxDecoration(
        color: cAzureGlass,
        shape: BoxShape.circle,
        border: Border.all(color: cTransept, width: 2),
      ),
    ),
  );

  return Wrap(spacing: 14, runSpacing: 14, children: tiles);
}

Widget _shapeTile(String label, BoxDecoration deco) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Container(width: 90, height: 90, decoration: deco),
      const SizedBox(height: 4),
      SizedBox(
        width: 100,
        child: Text(
          label,
          style: const TextStyle(fontSize: 10, color: cTransept),
        ),
      ),
    ],
  );
}

// ===========================================================================
//  SECTION 10 --- backgroundBlendMode showcase
// ===========================================================================

Widget _buildBlendModeShowcase() {
  print(' Building Section 10: blendMode showcase.');
  // We render four tiles. Each tile is a Stack: a colored backdrop, then a
  // Container with a BoxDecoration that uses backgroundBlendMode against
  // the backdrop. Each tile builds a real BoxDecoration --- counts toward 30.
  final tiles = <Widget>[
    _blendTile('multiply', BlendMode.multiply, cVespersOrange),
    _blendTile('screen', BlendMode.screen, cMartyrPurple),
    _blendTile('overlay', BlendMode.overlay, cIncenseGreen),
    _blendTile('plus', BlendMode.plus, cAzureGlass),
  ];

  return Wrap(spacing: 14, runSpacing: 14, children: tiles);
}

Widget _blendTile(String label, BlendMode mode, Color overlayColor) {
  // Backdrop deco --- the floor of the cathedral.
  final backdropDeco = BoxDecoration(
    gradient: const LinearGradient(
      colors: <Color>[cReliquaryGold, cVespersOrange, cReredosWine],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.circular(8),
    border: Border.all(color: cTransept),
  );
  // Foreground deco --- a panel of stained glass placed over the backdrop.
  final overlayDeco = BoxDecoration(
    color: overlayColor.withValues(alpha: 0.85),
    backgroundBlendMode: mode,
    borderRadius: BorderRadius.circular(8),
  );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Container(
        width: 130,
        height: 80,
        decoration: backdropDeco,
        child: Container(decoration: overlayDeco),
      ),
      const SizedBox(height: 4),
      SizedBox(
        width: 130,
        child: Text(
          'BlendMode.$label',
          style: const TextStyle(fontSize: 10, color: cTransept),
        ),
      ),
    ],
  );
}

// ===========================================================================
//  SECTION 11 --- lerp + copyWith demonstrations
// ===========================================================================

Widget _buildLerpAndCopyWith() {
  print(' Building Section 11: lerp + copyWith.');

  // Two endpoint decorations.
  final BoxDecoration a = BoxDecoration(
    color: cLancetBlue,
    borderRadius: BorderRadius.circular(0),
    border: Border.all(color: cTransept, width: 1),
    boxShadow: <BoxShadow>[
      BoxShadow(
        color: cTransept.withValues(alpha: 0.2),
        blurRadius: 2,
        offset: const Offset(0, 1),
      ),
    ],
  );

  final BoxDecoration b = BoxDecoration(
    color: cVespersOrange,
    borderRadius: BorderRadius.circular(40),
    border: Border.all(color: cReliquaryGold, width: 4),
    boxShadow: <BoxShadow>[
      BoxShadow(
        color: cReredosWine.withValues(alpha: 0.6),
        blurRadius: 14,
        spreadRadius: 2,
        offset: const Offset(0, 8),
      ),
    ],
  );

  // ACTUAL lerp call --- the canonical "halfway" decoration.
  final BoxDecoration mid =
      BoxDecoration.lerp(a, b, 0.5) ??
      const BoxDecoration(color: cTracery);

  // ACTUAL copyWith call --- take A but replace its color with gold.
  final BoxDecoration aGold = a.copyWith(color: cReliquaryGold);

  print(' BoxDecoration.lerp(a, b, 0.5) returned: '
      '${mid.color}');
  print(' a.copyWith(color: gold) returned: ${aGold.color}');

  Widget tile(String label, BoxDecoration deco) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(width: 130, height: 80, decoration: deco),
        const SizedBox(height: 4),
        SizedBox(
          width: 140,
          child: Text(
            label,
            style: const TextStyle(fontSize: 10, color: cTransept),
          ),
        ),
      ],
    );
  }

  return Container(
    decoration: BoxDecoration(
      color: cChalkLight,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: cTracery.withValues(alpha: 0.4)),
    ),
    padding: const EdgeInsets.all(12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'BoxDecoration.lerp(a, b, t) tweens color, border, radius, shadows '
          'and gradient piecewise. The Container itself is not animated here '
          '--- D4rt does not run animations --- but lerp is still the right '
          'tool when you want a static "halfway" preview, or when the host '
          'widget tree IS animated.',
          style: kBodyStyle,
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: <Widget>[
            tile('a (start)', a),
            tile('lerp(a,b,0.5)', mid),
            tile('b (end)', b),
            tile('a.copyWith(color: gold)', aGold),
          ],
        ),
      ],
    ),
  );
}

// ===========================================================================
//  SECTION 12 --- DO / AVOID callouts
// ===========================================================================

Widget _buildDoAvoidCallouts() {
  print(' Building Section 12: DO / AVOID callouts.');
  final rules = <Map<String, String>>[
    {
      'kind': 'DO',
      'rule':
          'Use BoxDecoration on Container.decoration. It is the path the '
              'framework optimises and the one the rest of the ecosystem '
              'expects.',
    },
    {
      'kind': 'AVOID',
      'rule':
          'Combining `borderRadius` with `shape: BoxShape.circle`. The '
              'engine throws an assertion --- a circle has no corners.',
    },
    {
      'kind': 'DO',
      'rule':
          'Prefer `BoxDecoration.lerp(a, b, t)` over hand-tweening color, '
              'border and radius separately --- it handles each property '
              'piecewise for you.',
    },
    {
      'kind': 'AVOID',
      'rule':
          'Setting BOTH `Container.color` and `decoration: BoxDecoration(...)` '
              'on the same Container. Flutter will assert; pick one.',
    },
    {
      'kind': 'DO',
      'rule':
          'Use `image: DecorationImage(...)` to put a background bitmap on '
              'top of the gradient. Set `fit: BoxFit.cover` for hero images.',
    },
    {
      'kind': 'AVOID',
      'rule':
          'Stacking many heavy `boxShadow`s with large blur radius on long '
              'lists. Each shadow is a separate composite-time operation.',
    },
    {
      'kind': 'DO',
      'rule':
          'Reach for `decoration.copyWith(...)` when you want to derive a '
              'variant (hover, selected) without re-typing every field.',
    },
    {
      'kind': 'AVOID',
      'rule':
          'Building a fresh BoxDecoration inside `build()` every frame for a '
              'long-lived static element. Cache it as a `const` or a final '
              'top-level token.',
    },
    {
      'kind': 'DO',
      'rule':
          'Use `backgroundBlendMode` only when there is a layer below to '
              'blend against; on a top-level Container it has nothing to '
              'mix with.',
    },
  ];

  final tiles = <Widget>[];
  for (int i = 0; i < rules.length; i++) {
    final r = rules[i];
    final kind = r['kind']!;
    final rule = r['rule']!;
    final isDo = kind == 'DO';
    // BoxDecoration for the callout card.
    final cardDeco = BoxDecoration(
      color: cChalkLight,
      borderRadius: BorderRadius.circular(8),
      border: Border(
        left: BorderSide(
          color: isDo ? cIncenseGreen : cRoseRed,
          width: 6,
        ),
        top: BorderSide(color: cTracery.withValues(alpha: 0.3)),
        right: BorderSide(color: cTracery.withValues(alpha: 0.3)),
        bottom: BorderSide(color: cTracery.withValues(alpha: 0.3)),
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
//  SECTION 13 --- Code-snippet recipe cards
// ===========================================================================

Widget _buildRecipeCards() {
  print(' Building Section 13: recipe cards.');
  final recipes = <Map<String, String>>[
    {
      'title': 'Simple rounded card',
      'code': '''Container(
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: Colors.black26,
        blurRadius: 6,
        offset: Offset(0, 3),
      ),
    ],
  ),
  child: ...,
)''',
    },
    {
      'title': 'Lancet window',
      'code': '''Container(
  decoration: BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Colors.lightBlueAccent, Colors.indigo],
    ),
    borderRadius: BorderRadius.vertical(
      top: Radius.circular(40),
    ),
    border: Border.all(color: Colors.brown, width: 3),
  ),
)''',
    },
    {
      'title': 'Gold halo circle',
      'code': '''Container(
  width: 80, height: 80,
  decoration: BoxDecoration(
    shape: BoxShape.circle,
    color: Colors.amber,
    boxShadow: [
      BoxShadow(
        color: Colors.amber.withValues(alpha: 0.8),
        blurRadius: 24,
        spreadRadius: 4,
      ),
    ],
  ),
)''',
    },
    {
      'title': 'Stained-glass overlay',
      'code': '''Container(
  decoration: BoxDecoration(
    gradient: RadialGradient(
      colors: [Colors.white, Colors.purple],
    ),
  ),
  child: Container(
    decoration: BoxDecoration(
      color: Colors.deepPurple.withValues(alpha: 0.5),
      backgroundBlendMode: BlendMode.multiply,
    ),
  ),
)''',
    },
    {
      'title': 'lerp halfway preview',
      'code': '''final a = BoxDecoration(color: Colors.blue);
final b = BoxDecoration(
  color: Colors.orange,
  borderRadius: BorderRadius.circular(40),
);
final mid = BoxDecoration.lerp(a, b, 0.5);
Container(decoration: mid);''',
    },
    {
      'title': 'copyWith for variant',
      'code': '''final base = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(8),
  border: Border.all(color: Colors.grey),
);
final selected = base.copyWith(
  border: Border.all(color: Colors.indigo, width: 2),
);''',
    },
  ];

  final cards = <Widget>[];
  for (int i = 0; i < recipes.length; i++) {
    final r = recipes[i];
    // BoxDecoration for the code card.
    final codeCardDeco = BoxDecoration(
      color: cTransept,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: cReliquaryGold.withValues(alpha: 0.5)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: cTransept.withValues(alpha: 0.3),
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
                color: cReliquaryGold,
                fontWeight: FontWeight.w800,
                fontSize: 13,
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
  final entries = <Map<String, String>>[
    {
      'term': 'BoxDecoration',
      'def': 'Painting recipe describing how a rectangular box is filled, '
          'gradient-painted, image-painted, bordered and shadowed.',
    },
    {
      'term': 'DecoratedBox',
      'def': 'The widget that actually paints a Decoration. Container '
          'wraps a DecoratedBox internally when you pass `decoration:`.',
    },
    {
      'term': 'Decoration',
      'def': 'Abstract base class. BoxDecoration is the most common '
          'concrete subclass; ShapeDecoration is the other common one.',
    },
    {
      'term': 'BoxShape',
      'def': 'enum { rectangle, circle }. Selects whether the fill is '
          'clipped to a rectangle or to the inscribed circle.',
    },
    {
      'term': 'BorderRadius',
      'def': 'Per-corner rounding. Ignored when shape == BoxShape.circle.',
    },
    {
      'term': 'BoxShadow',
      'def': 'Tuple of (color, blurRadius, spreadRadius, offset, blurStyle). '
          'Multiple shadows are painted in list order, back-to-front.',
    },
    {
      'term': 'Gradient',
      'def': 'Abstract; concrete subclasses are LinearGradient, '
          'RadialGradient, SweepGradient.',
    },
    {
      'term': 'BackgroundBlendMode',
      'def': 'BlendMode applied to the fill (color + gradient) layer when '
          'compositing against what is painted below this DecoratedBox.',
    },
    {
      'term': 'BoxBorder',
      'def': 'Abstract border type. Border (uniform sides) and '
          'BorderDirectional (start/end aware) are concrete subclasses.',
    },
    {
      'term': 'BorderSide',
      'def': 'A single edge of a Border: color, width, style.',
    },
    {
      'term': 'lerp(a,b,t)',
      'def': 'Linear interpolation between two BoxDecorations. Returns '
          'null if both inputs are null.',
    },
    {
      'term': 'copyWith',
      'def': 'Returns a new BoxDecoration where named fields are replaced '
          'and others copied.',
    },
    {
      'term': 'getClipPath',
      'def': 'Path describing the outline; used by clippers and ink '
          'splash routing.',
    },
    {
      'term': 'hitTest',
      'def': 'Predicate the framework calls to decide if a point is '
          'inside the decoration\'s painted area.',
    },
    {
      'term': 'DecorationImage',
      'def': 'A bitmap painted as part of the decoration; stacks over '
          'the gradient and under the border.',
    },
    {
      'term': 'spreadRadius',
      'def': 'Adds (or removes, when negative) extra size to a BoxShadow '
          'before blurring.',
    },
  ];

  final tiles = <Widget>[];
  for (int i = 0; i < entries.length; i++) {
    final e = entries[i];
    // BoxDecoration for the glossary tile.
    final tileDeco = BoxDecoration(
      color: cChalkLight,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: cTracery.withValues(alpha: 0.4)),
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
                color: cLancetBlue,
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
  // BoxDecoration for the footer.
  final footerDeco = BoxDecoration(
    gradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[cReredosWine, cTransept],
    ),
    borderRadius: BorderRadius.circular(14),
    boxShadow: <BoxShadow>[
      BoxShadow(
        color: cTransept.withValues(alpha: 0.5),
        blurRadius: 14,
        offset: const Offset(0, 8),
      ),
    ],
    border: Border.all(color: cReliquaryGold, width: 2),
  );

  return Container(
    decoration: footerDeco,
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        Text(
          'RECAP --- LEAVING THE CATHEDRAL',
          style: TextStyle(
            color: cReliquaryGold,
            fontSize: 18,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.4,
          ),
        ),
        SizedBox(height: 10),
        Text(
          'BoxDecoration is the recipe.\n'
          'Container is the kitchen.\n'
          'DecoratedBox is the oven.\n'
          'The Canvas is the plate.\n'
          '\n'
          'Reach for color when you want a flat fill, gradient when you '
          'want a transition, image when you want a photograph, border '
          'for tracery, boxShadow for the wash of light on the floor, '
          'borderRadius for the arch above the lancet, and shape when '
          'you want to flip the whole thing into a circle.\n'
          '\n'
          'Reach for lerp when you want a midpoint, and copyWith when '
          'you want a variant. The cathedral is built one stone at a '
          'time --- and BoxDecoration is the chisel.',
          style: TextStyle(
            color: cChalkLight,
            fontSize: 12,
            height: 1.5,
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// END --- BoxDecoration deep demo, "Stained Glass Cathedral" theme.
// =============================================================================
