// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable
// D4rt test script: Deep Demo - Color and Colors from dart:ui / material
// Comprehensive visual exploration of ARGB color construction, mutators,
// blending, lerp gradients, MaterialColor swatches, and the Colors palette.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ColorsTest deep demo executing');

  // ============================================================================
  // SECTION 1 DATA: DOSSIER
  // ============================================================================
  // Color is a 32-bit ARGB value laid out as 0xAARRGGBB in sRGB color space.
  // The high byte holds alpha (0..255), then red, green, blue, each 0..255.
  // Construction can be done three ways which all collapse to the same int:
  //   - Color(0xAARRGGBB)              raw 32-bit literal
  //   - Color.fromARGB(a, r, g, b)     four int channels
  //   - Color.fromRGBO(r, g, b, o)     o is opacity in [0.0, 1.0]
  // The Colors class is a static catalogue of well-known Material colors and
  // MaterialColor / MaterialAccentColor swatches.

  // ============================================================================
  // SECTION 2 DATA: ANATOMY TABLES
  // ============================================================================

  final constructorRows = <Map<String, String>>[
    {
      'ctor': 'Color(int)',
      'sig': 'const Color(int value)',
      'note': 'Direct 32-bit ARGB literal: 0xAARRGGBB',
    },
    {
      'ctor': 'Color.fromARGB',
      'sig': 'Color.fromARGB(int a, int r, int g, int b)',
      'note': 'Channels as 0..255 ints; explicit alpha',
    },
    {
      'ctor': 'Color.fromRGBO',
      'sig': 'Color.fromRGBO(int r, int g, int b, double o)',
      'note': 'Opacity 0.0..1.0 instead of alpha int',
    },
    {
      'ctor': 'Colors.<name>',
      'sig': 'static const Colors.red, Colors.blue, …',
      'note': 'Pre-defined Material palette constants',
    },
  ];

  final accessorRows = <Map<String, String>>[
    {
      'name': '.alpha',
      'type': 'int',
      'note': 'Alpha channel 0..255 (high byte of value)',
    },
    {
      'name': '.red',
      'type': 'int',
      'note': 'Red channel 0..255',
    },
    {
      'name': '.green',
      'type': 'int',
      'note': 'Green channel 0..255',
    },
    {
      'name': '.blue',
      'type': 'int',
      'note': 'Blue channel 0..255',
    },
    {
      'name': '.value',
      'type': 'int',
      'note': '32-bit packed ARGB integer',
    },
    {
      'name': '.opacity',
      'type': 'double',
      'note': 'Alpha as 0.0..1.0 (alpha / 255)',
    },
    {
      'name': '.computeLuminance()',
      'type': 'double',
      'note': 'Perceived brightness 0.0..1.0 (WCAG)',
    },
  ];

  // ============================================================================
  // SECTION 3 DATA: CONSTRUCTOR VARIANTS (CRIMSON)
  // ============================================================================

  final crimsonHex = Color(0xFFC91A2A);
  final crimsonArgb = Color.fromARGB(255, 201, 26, 42);
  final crimsonRgbo = Color.fromRGBO(201, 26, 42, 1.0);

  final ctorVariants = <Map<String, dynamic>>[
    {
      'label': 'Color(0xFFC91A2A)',
      'color': crimsonHex,
      'value': crimsonHex.value,
      'hash': crimsonHex.hashCode,
    },
    {
      'label': 'Color.fromARGB(255, 201, 26, 42)',
      'color': crimsonArgb,
      'value': crimsonArgb.value,
      'hash': crimsonArgb.hashCode,
    },
    {
      'label': 'Color.fromRGBO(201, 26, 42, 1.0)',
      'color': crimsonRgbo,
      'value': crimsonRgbo.value,
      'hash': crimsonRgbo.hashCode,
    },
  ];

  final crimsonEqual =
      crimsonHex == crimsonArgb && crimsonArgb == crimsonRgbo;
  final crimsonHashesEqual =
      crimsonHex.hashCode == crimsonArgb.hashCode &&
      crimsonArgb.hashCode == crimsonRgbo.hashCode;

  print('Crimson equality across constructors: $crimsonEqual');
  print('Crimson hashCode parity: $crimsonHashesEqual');

  // ============================================================================
  // SECTION 4 DATA: WITH* MUTATORS
  // ============================================================================

  final baseTeal = Color(0xFF008B8B);

  final opacityRamp = <Color>[
    baseTeal.withOpacity(0.1),
    baseTeal.withOpacity(0.25),
    baseTeal.withOpacity(0.4),
    baseTeal.withOpacity(0.55),
    baseTeal.withOpacity(0.7),
    baseTeal.withOpacity(0.85),
    baseTeal.withOpacity(1.0),
  ];

  final alphaRamp = <Color>[
    baseTeal.withAlpha(32),
    baseTeal.withAlpha(64),
    baseTeal.withAlpha(96),
    baseTeal.withAlpha(128),
    baseTeal.withAlpha(160),
    baseTeal.withAlpha(192),
    baseTeal.withAlpha(255),
  ];

  final redRamp = <Color>[
    baseTeal.withRed(0),
    baseTeal.withRed(64),
    baseTeal.withRed(128),
    baseTeal.withRed(192),
    baseTeal.withRed(255),
  ];

  final greenRamp = <Color>[
    baseTeal.withGreen(0),
    baseTeal.withGreen(64),
    baseTeal.withGreen(128),
    baseTeal.withGreen(192),
    baseTeal.withGreen(255),
  ];

  final blueRamp = <Color>[
    baseTeal.withBlue(0),
    baseTeal.withBlue(64),
    baseTeal.withBlue(128),
    baseTeal.withBlue(192),
    baseTeal.withBlue(255),
  ];

  // ============================================================================
  // SECTION 5 DATA: COLOR.LERP GRADIENT
  // ============================================================================

  final lerpA = Color(0xFF1E88E5); // bright blue
  final lerpB = Color(0xFFE53935); // bright red
  final lerpStops = <Map<String, dynamic>>[];
  for (int i = 0; i <= 10; i++) {
    final t = i / 10.0;
    final c = Color.lerp(lerpA, lerpB, t) ?? lerpA;
    lerpStops.add({'t': t, 'color': c});
  }

  // ============================================================================
  // SECTION 6 DATA: ALPHA BLEND
  // ============================================================================

  final blendForeground = Color(0x80F44336); // red, 50% opacity
  final blendBackground = Color(0xFF1976D2); // opaque blue
  final blendResult = Color.alphaBlend(blendForeground, blendBackground);

  final blendBreakdown = <Map<String, dynamic>>[
    {
      'label': 'foreground (translucent red)',
      'color': blendForeground,
      'a': blendForeground.alpha,
      'r': blendForeground.red,
      'g': blendForeground.green,
      'b': blendForeground.blue,
    },
    {
      'label': 'background (opaque blue)',
      'color': blendBackground,
      'a': blendBackground.alpha,
      'r': blendBackground.red,
      'g': blendBackground.green,
      'b': blendBackground.blue,
    },
    {
      'label': 'alphaBlend result',
      'color': blendResult,
      'a': blendResult.alpha,
      'r': blendResult.red,
      'g': blendResult.green,
      'b': blendResult.blue,
    },
  ];

  // ============================================================================
  // SECTION 7 DATA: COLORS PALETTE
  // ============================================================================

  final paletteRed = <Map<String, dynamic>>[
    {'name': 'red', 'color': Colors.red},
    {'name': 'redAccent', 'color': Colors.redAccent},
    {'name': 'pink', 'color': Colors.pink},
    {'name': 'pinkAccent', 'color': Colors.pinkAccent},
    {'name': 'deepOrange', 'color': Colors.deepOrange},
    {'name': 'deepOrangeAccent', 'color': Colors.deepOrangeAccent},
  ];

  final paletteOrangeYellow = <Map<String, dynamic>>[
    {'name': 'orange', 'color': Colors.orange},
    {'name': 'orangeAccent', 'color': Colors.orangeAccent},
    {'name': 'amber', 'color': Colors.amber},
    {'name': 'amberAccent', 'color': Colors.amberAccent},
    {'name': 'yellow', 'color': Colors.yellow},
    {'name': 'yellowAccent', 'color': Colors.yellowAccent},
  ];

  final paletteGreen = <Map<String, dynamic>>[
    {'name': 'lime', 'color': Colors.lime},
    {'name': 'limeAccent', 'color': Colors.limeAccent},
    {'name': 'lightGreen', 'color': Colors.lightGreen},
    {'name': 'lightGreenAccent', 'color': Colors.lightGreenAccent},
    {'name': 'green', 'color': Colors.green},
    {'name': 'greenAccent', 'color': Colors.greenAccent},
    {'name': 'teal', 'color': Colors.teal},
    {'name': 'tealAccent', 'color': Colors.tealAccent},
  ];

  final paletteBlue = <Map<String, dynamic>>[
    {'name': 'cyan', 'color': Colors.cyan},
    {'name': 'cyanAccent', 'color': Colors.cyanAccent},
    {'name': 'lightBlue', 'color': Colors.lightBlue},
    {'name': 'lightBlueAccent', 'color': Colors.lightBlueAccent},
    {'name': 'blue', 'color': Colors.blue},
    {'name': 'blueAccent', 'color': Colors.blueAccent},
    {'name': 'indigo', 'color': Colors.indigo},
    {'name': 'indigoAccent', 'color': Colors.indigoAccent},
  ];

  final palettePurple = <Map<String, dynamic>>[
    {'name': 'purple', 'color': Colors.purple},
    {'name': 'purpleAccent', 'color': Colors.purpleAccent},
    {'name': 'deepPurple', 'color': Colors.deepPurple},
    {'name': 'deepPurpleAccent', 'color': Colors.deepPurpleAccent},
  ];

  final paletteNeutral = <Map<String, dynamic>>[
    {'name': 'brown', 'color': Colors.brown},
    {'name': 'grey', 'color': Colors.grey},
    {'name': 'blueGrey', 'color': Colors.blueGrey},
    {'name': 'black', 'color': Colors.black},
    {'name': 'white', 'color': Colors.white},
    {'name': 'black87', 'color': Colors.black87},
    {'name': 'white70', 'color': Colors.white70},
    {'name': 'transparent', 'color': Colors.transparent},
  ];

  // ============================================================================
  // SECTION 8 DATA: MATERIALCOLOR SHADES (INDIGO)
  // ============================================================================

  final indigoShades = <Map<String, dynamic>>[
    {'shade': 50, 'color': Colors.indigo.shade50},
    {'shade': 100, 'color': Colors.indigo.shade100},
    {'shade': 200, 'color': Colors.indigo.shade200},
    {'shade': 300, 'color': Colors.indigo.shade300},
    {'shade': 400, 'color': Colors.indigo.shade400},
    {'shade': 500, 'color': Colors.indigo.shade500},
    {'shade': 600, 'color': Colors.indigo.shade600},
    {'shade': 700, 'color': Colors.indigo.shade700},
    {'shade': 800, 'color': Colors.indigo.shade800},
    {'shade': 900, 'color': Colors.indigo.shade900},
  ];

  final indigoIndexerVsShade = Colors.indigo[500] == Colors.indigo.shade500;
  final indigoPrimaryIsShade500 = Colors.indigo == Colors.indigo.shade500
      ? 'value-equal'
      : 'distinct-instance';
  print('Colors.indigo[500] == .shade500 -> $indigoIndexerVsShade');

  // ============================================================================
  // SECTION 9 DATA: LUMINANCE GALLERY
  // ============================================================================

  final luminanceCandidates = <Map<String, dynamic>>[
    {'name': 'black', 'color': Colors.black},
    {'name': 'brown', 'color': Colors.brown},
    {'name': 'indigo', 'color': Colors.indigo},
    {'name': 'red', 'color': Colors.red},
    {'name': 'deepOrange', 'color': Colors.deepOrange},
    {'name': 'green', 'color': Colors.green},
    {'name': 'teal', 'color': Colors.teal},
    {'name': 'blue', 'color': Colors.blue},
    {'name': 'cyan', 'color': Colors.cyan},
    {'name': 'amber', 'color': Colors.amber},
    {'name': 'yellow', 'color': Colors.yellow},
    {'name': 'white', 'color': Colors.white},
  ];
  final luminanceRanked = luminanceCandidates
      .map((m) => {
            'name': m['name'],
            'color': m['color'],
            'lum': (m['color'] as Color).computeLuminance(),
          })
      .toList();
  luminanceRanked.sort(
    (a, b) => (a['lum'] as double).compareTo(b['lum'] as double),
  );

  // ============================================================================
  // SECTION 10 DATA: RECIPE CARDS
  // ============================================================================

  final recipes = <Map<String, String>>[
    {
      'title': 'Translucent overlay',
      'code': "Color(0x80000000)  // 50% black scrim",
      'why': 'Darken anything underneath without hiding it.',
    },
    {
      'title': 'Tint a brand color',
      'code': "brand.withOpacity(0.12)",
      'why': 'Subtle background that hints at the primary color.',
    },
    {
      'title': 'Two-stop blend',
      'code': "Color.lerp(a, b, 0.5)!",
      'why': 'Midpoint between two themes (! because lerp is nullable).',
    },
    {
      'title': 'Layer cake',
      'code': "Color.alphaBlend(top, bottom)",
      'why': 'Resolve a translucent top color over an opaque background.',
    },
    {
      'title': 'Pick a foreground',
      'code': "bg.computeLuminance() > 0.5 ? Colors.black : Colors.white",
      'why': 'Auto-contrast text on an arbitrary background.',
    },
    {
      'title': 'Variant from one base',
      'code': "base.withRed((base.red * 0.7).toInt())",
      'why': 'Programmatic channel modulation for hover/pressed states.',
    },
    {
      'title': 'Shade from MaterialColor',
      'code': "Colors.blue.shade700  // or Colors.blue[700]",
      'why': 'Stay on-palette without inventing new hex codes.',
    },
    {
      'title': 'Hex from an int value',
      'code': "color.value.toRadixString(16).padLeft(8, '0').toUpperCase()",
      'why': 'Render a Color as readable 0xAARRGGBB for tooltips/logs.',
    },
  ];

  // ============================================================================
  // SECTION 11 DATA: COMPARISON TABLE
  // ============================================================================

  final comparison = <Map<String, String>>[
    {
      'kind': 'Color',
      'lives': 'dart:ui',
      'shape': 'single 32-bit ARGB value',
      'usage': 'Anywhere a single color is needed',
    },
    {
      'kind': 'MaterialColor',
      'lives': 'package:flutter/material.dart',
      'shape': 'primary color + 10 shade swatches',
      'usage': 'Themed UI with light/dark shade variants',
    },
    {
      'kind': 'MaterialAccentColor',
      'lives': 'package:flutter/material.dart',
      'shape': 'primary + 4 accent shades (100,200,400,700)',
      'usage': 'Vivid accent highlights',
    },
    {
      'kind': 'ColorSwatch<T>',
      'lives': 'package:flutter/material.dart',
      'shape': 'Color + Map<T, Color> of variants',
      'usage': 'Custom themed swatch families',
    },
    {
      'kind': 'Theme tokens',
      'lives': 'Theme.of(context).colorScheme',
      'shape': 'Semantic ColorScheme roles',
      'usage': 'Material 3 semantic theming',
    },
  ];

  // ============================================================================
  // SECTION 12 DATA: GLOSSARY
  // ============================================================================

  final glossary = <Map<String, String>>[
    {
      'term': 'ARGB',
      'def': 'Alpha-Red-Green-Blue packed as four bytes in a 32-bit int.',
    },
    {
      'term': 'sRGB',
      'def': 'The standard color space Flutter uses for Color values.',
    },
    {
      'term': 'Alpha',
      'def': 'Opacity channel 0..255 stored in the high byte of value.',
    },
    {
      'term': 'Opacity',
      'def': 'Alpha expressed as a 0.0..1.0 double (alpha / 255).',
    },
    {
      'term': 'Luminance',
      'def': 'Perceived brightness used for contrast decisions (WCAG).',
    },
    {
      'term': 'Lerp',
      'def': 'Linear interpolation: lerp(a,b,t) = a*(1-t) + b*t per channel.',
    },
    {
      'term': 'Alpha blend',
      'def': 'Compose a translucent top color over an opaque bottom one.',
    },
    {
      'term': 'MaterialColor',
      'def': 'A primary Color with a 10-entry shade swatch (50..900).',
    },
    {
      'term': 'Shade',
      'def': 'A specific lightness step (50,100,…,900) within a swatch.',
    },
    {
      'term': 'Accent',
      'def': 'A vivid 4-entry variant set (100,200,400,700) of a hue.',
    },
    {
      'term': 'ColorScheme',
      'def': 'Material 3 semantic color roles like primary, surface, error.',
    },
  ];

  // ============================================================================
  // BUILD COMPREHENSIVE UI
  // ============================================================================

  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // ===== HEADER =====
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF6A1B9A), Color(0xFFEC407A)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Color & Colors Deep Demo',
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'ARGB, mutators, lerp, alphaBlend, MaterialColor, palette',
                  style: TextStyle(fontSize: 14.0, color: Color(0xFFFCE4EC)),
                ),
                SizedBox(height: 16.0),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: [
                    _pill('dart:ui Color'),
                    _pill('Colors palette'),
                    _pill('MaterialColor'),
                    _pill('Color.lerp'),
                    _pill('alphaBlend'),
                    _pill('computeLuminance'),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: 24.0),

          // ============================================================
          // SECTION 1: DOSSIER
          // ============================================================
          _sectionHeader(
            '1. Dossier — Color as 32-bit ARGB',
            Color(0xFF6A1B9A),
            Color(0xFFF3E5F5),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Color(0xFFF3E5F5),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Color(0xFFCE93D8), width: 1.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'A Color is a single 32-bit integer interpreted as 0xAARRGGBB '
                  'in the sRGB color space. The high byte is alpha (opacity), '
                  'followed by red, green, and blue — each a 0..255 channel.',
                  style: TextStyle(fontSize: 13.0, height: 1.5),
                ),
                SizedBox(height: 12.0),
                // Byte layout visualization.
                Row(
                  children: [
                    _byteBox('A', '0xFF', Color(0xFF424242)),
                    _byteBox('R', '0xC9', Color(0xFFE53935)),
                    _byteBox('G', '0x1A', Color(0xFF43A047)),
                    _byteBox('B', '0x2A', Color(0xFF1E88E5)),
                  ],
                ),
                SizedBox(height: 12.0),
                Text(
                  'Constructed three equivalent ways:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13.0,
                  ),
                ),
                SizedBox(height: 6.0),
                _codeLine('Color(0xFFC91A2A)'),
                _codeLine('Color.fromARGB(255, 201, 26, 42)'),
                _codeLine('Color.fromRGBO(201, 26, 42, 1.0)'),
              ],
            ),
          ),

          SizedBox(height: 24.0),

          // ============================================================
          // SECTION 2: ANATOMY — CONSTRUCTORS + ACCESSORS
          // ============================================================
          _sectionHeader(
            '2. Anatomy — Constructors & Accessors',
            Color(0xFF1565C0),
            Color(0xFFE3F2FD),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Color(0xFFE3F2FD),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Color(0xFF90CAF9), width: 1.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Constructors',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                  ),
                ),
                SizedBox(height: 8.0),
                for (final row in constructorRows)
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Color(0xFFBBDEFB),
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            row['ctor']!,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                            ),
                          ),
                          SizedBox(height: 2.0),
                          Text(
                            row['sig']!,
                            style: TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 11.0,
                              color: Color(0xFF0D47A1),
                            ),
                          ),
                          SizedBox(height: 2.0),
                          Text(
                            row['note']!,
                            style: TextStyle(
                              fontSize: 11.0,
                              color: Color(0xFF424242),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                SizedBox(height: 8.0),
                Text(
                  'Accessors',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                  ),
                ),
                SizedBox(height: 8.0),
                for (final row in accessorRows)
                  Padding(
                    padding: EdgeInsets.only(bottom: 6.0),
                    child: Row(
                      children: [
                        Container(
                          width: 130.0,
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 4.0,
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xFF1976D2),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Text(
                            row['name']!,
                            style: TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 11.0,
                              color: Color(0xFFFFFFFF),
                            ),
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6.0,
                            vertical: 2.0,
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xFF90CAF9),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Text(
                            row['type']!,
                            style: TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 10.0,
                              color: Color(0xFF0D47A1),
                            ),
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Expanded(
                          child: Text(
                            row['note']!,
                            style: TextStyle(fontSize: 11.0),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),

          SizedBox(height: 24.0),

          // ============================================================
          // SECTION 3: CONSTRUCTOR VARIANTS (CRIMSON)
          // ============================================================
          _sectionHeader(
            '3. Three Constructors, Same Crimson',
            Color(0xFFC91A2A),
            Color(0xFFFFEBEE),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Color(0xFFFFEBEE),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Color(0xFFEF9A9A), width: 1.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    for (final v in ctorVariants)
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.0),
                          child: Column(
                            children: [
                              Container(
                                height: 90.0,
                                decoration: BoxDecoration(
                                  color: v['color'] as Color,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Center(
                                  child: Text(
                                    _hex(v['color'] as Color),
                                    style: TextStyle(
                                      color: Color(0xFFFFFFFF),
                                      fontFamily: 'monospace',
                                      fontSize: 11.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 6.0),
                              Text(
                                v['label'] as String,
                                style: TextStyle(
                                  fontSize: 10.0,
                                  fontFamily: 'monospace',
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 2.0),
                              Text(
                                'value: ${v['value']}',
                                style: TextStyle(
                                  fontSize: 9.0,
                                  color: Color(0xFF757575),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 12.0),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: crimsonEqual
                        ? Color(0xFF2E7D32)
                        : Color(0xFFC62828),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Text(
                    crimsonEqual
                        ? 'All three constructors produce equal Color instances (== and hashCode match).'
                        : 'Mismatch detected across constructors.',
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 6.0),
                Text(
                  'hashCode parity: $crimsonHashesEqual',
                  style: TextStyle(fontSize: 11.0, fontFamily: 'monospace'),
                ),
              ],
            ),
          ),

          SizedBox(height: 24.0),

          // ============================================================
          // SECTION 4: WITH* MUTATORS
          // ============================================================
          _sectionHeader(
            '4. with* Mutators — Channel Edits',
            Color(0xFF00695C),
            Color(0xFFE0F2F1),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Color(0xFFE0F2F1),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Color(0xFF80CBC4), width: 1.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _rampLabel('withOpacity(0.1 → 1.0)'),
                _rampRow(opacityRamp),
                SizedBox(height: 12.0),
                _rampLabel('withAlpha(32 → 255)'),
                _rampRow(alphaRamp),
                SizedBox(height: 12.0),
                _rampLabel('withRed(0 → 255)'),
                _rampRow(redRamp),
                SizedBox(height: 12.0),
                _rampLabel('withGreen(0 → 255)'),
                _rampRow(greenRamp),
                SizedBox(height: 12.0),
                _rampLabel('withBlue(0 → 255)'),
                _rampRow(blueRamp),
                SizedBox(height: 8.0),
                Text(
                  'Base color: ${_hex(baseTeal)} (Color(0xFF008B8B), DarkCyan).',
                  style: TextStyle(fontSize: 11.0, color: Color(0xFF424242)),
                ),
              ],
            ),
          ),

          SizedBox(height: 24.0),

          // ============================================================
          // SECTION 5: COLOR.LERP GRADIENT
          // ============================================================
          _sectionHeader(
            '5. Color.lerp — 11-Stop Gradient',
            Color(0xFF1E88E5),
            Color(0xFFFFEBEE),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Color(0xFFFFF3E0),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Color(0xFFFFB74D), width: 1.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Color.lerp(${_hex(lerpA)}, ${_hex(lerpB)}, t)',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12.0,
                    color: Color(0xFF424242),
                  ),
                ),
                SizedBox(height: 12.0),
                Row(
                  children: [
                    for (final stop in lerpStops)
                      Expanded(
                        child: Container(
                          height: 64.0,
                          margin: EdgeInsets.symmetric(horizontal: 1.0),
                          decoration: BoxDecoration(
                            color: stop['color'] as Color,
                          ),
                          child: Center(
                            child: Text(
                              (stop['t'] as double).toStringAsFixed(1),
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 10.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 8.0),
                Wrap(
                  spacing: 6.0,
                  runSpacing: 4.0,
                  children: [
                    for (final stop in lerpStops)
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6.0,
                          vertical: 3.0,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xFFFFE0B2),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Text(
                          't=${(stop['t'] as double).toStringAsFixed(1)} '
                          '→ ${_hex(stop['color'] as Color)}',
                          style: TextStyle(
                            fontSize: 10.0,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: 24.0),

          // ============================================================
          // SECTION 6: ALPHA BLEND
          // ============================================================
          _sectionHeader(
            '6. Color.alphaBlend — Translucent Over Opaque',
            Color(0xFF4527A0),
            Color(0xFFEDE7F6),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Color(0xFFEDE7F6),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Color(0xFFB39DDB), width: 1.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Stack: background ← foreground (translucent) ⇒ result',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Color(0xFF424242),
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(height: 12.0),
                // Visual stack
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 90.0,
                      decoration: BoxDecoration(
                        color: blendBackground,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Center(
                        child: Text(
                          'background ${_hex(blendBackground)}',
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 12.0,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 16.0,
                      right: 16.0,
                      top: 16.0,
                      bottom: 16.0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: blendForeground,
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        child: Center(
                          child: Text(
                            'foreground ${_hex(blendForeground)}',
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 12.0,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.0),
                Container(
                  width: double.infinity,
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: blendResult,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Center(
                    child: Text(
                      'result ${_hex(blendResult)}',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 13.0,
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12.0),
                Text(
                  'Channel breakdown',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                  ),
                ),
                SizedBox(height: 6.0),
                for (final row in blendBreakdown)
                  Padding(
                    padding: EdgeInsets.only(bottom: 6.0),
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Color(0xFFD1C4E9),
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 28.0,
                            height: 28.0,
                            decoration: BoxDecoration(
                              color: row['color'] as Color,
                              border: Border.all(
                                color: Color(0xFF311B92),
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                          ),
                          SizedBox(width: 10.0),
                          Expanded(
                            child: Text(
                              row['label'] as String,
                              style: TextStyle(fontSize: 11.0),
                            ),
                          ),
                          Text(
                            'A:${row['a']} R:${row['r']} G:${row['g']} B:${row['b']}',
                            style: TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 10.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),

          SizedBox(height: 24.0),

          // ============================================================
          // SECTION 7: COLORS PALETTE
          // ============================================================
          _sectionHeader(
            '7. Colors.* Palette — Material Catalogue',
            Color(0xFFAD1457),
            Color(0xFFFCE4EC),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Color(0xFFFCE4EC),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Color(0xFFF48FB1), width: 1.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _paletteFamily('Reds & Pinks', paletteRed),
                _paletteFamily('Oranges & Yellows', paletteOrangeYellow),
                _paletteFamily('Greens', paletteGreen),
                _paletteFamily('Blues', paletteBlue),
                _paletteFamily('Purples', palettePurple),
                _paletteFamily('Neutrals', paletteNeutral),
              ],
            ),
          ),

          SizedBox(height: 24.0),

          // ============================================================
          // SECTION 8: MATERIALCOLOR SHADES
          // ============================================================
          _sectionHeader(
            '8. MaterialColor — Indigo Shade Ramp',
            Color(0xFF283593),
            Color(0xFFE8EAF6),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Color(0xFFE8EAF6),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Color(0xFF9FA8DA), width: 1.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    for (final entry in indigoShades)
                      Expanded(
                        child: Container(
                          height: 60.0,
                          margin: EdgeInsets.symmetric(horizontal: 1.0),
                          color: entry['color'] as Color,
                          child: Center(
                            child: Text(
                              '${entry['shade']}',
                              style: TextStyle(
                                fontSize: 11.0,
                                fontWeight: FontWeight.bold,
                                color: ((entry['color'] as Color)
                                            .computeLuminance() >
                                        0.5)
                                    ? Color(0xFF000000)
                                    : Color(0xFFFFFFFF),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 8.0),
                Row(
                  children: [
                    for (final entry in indigoShades)
                      Expanded(
                        child: Text(
                          _hex(entry['color'] as Color),
                          style: TextStyle(
                            fontSize: 8.0,
                            fontFamily: 'monospace',
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 12.0),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: indigoIndexerVsShade
                        ? Color(0xFF2E7D32)
                        : Color(0xFFC62828),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Text(
                    indigoIndexerVsShade
                        ? "Colors.indigo[500] == Colors.indigo.shade500 ✓"
                        : "Colors.indigo[500] != Colors.indigo.shade500 ✗",
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 12.0,
                      fontFamily: 'monospace',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 6.0),
                Text(
                  'Primary color is $indigoPrimaryIsShade500 to shade500.',
                  style: TextStyle(fontSize: 11.0, color: Color(0xFF424242)),
                ),
              ],
            ),
          ),

          SizedBox(height: 24.0),

          // ============================================================
          // SECTION 9: LUMINANCE GALLERY
          // ============================================================
          _sectionHeader(
            '9. Luminance Gallery — Ranked Darkest to Lightest',
            Color(0xFF455A64),
            Color(0xFFECEFF1),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Color(0xFFECEFF1),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Color(0xFFB0BEC5), width: 1.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'computeLuminance() returns 0.0..1.0 (WCAG perceived).',
                  style: TextStyle(
                    fontSize: 11.0,
                    color: Color(0xFF424242),
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(height: 12.0),
                Row(
                  children: [
                    for (final m in luminanceRanked)
                      Expanded(
                        child: Container(
                          height: 80.0,
                          margin: EdgeInsets.symmetric(horizontal: 1.0),
                          color: m['color'] as Color,
                          child: Center(
                            child: Text(
                              (m['lum'] as double).toStringAsFixed(2),
                              style: TextStyle(
                                fontSize: 11.0,
                                fontWeight: FontWeight.bold,
                                color: ((m['color'] as Color)
                                            .computeLuminance() >
                                        0.5)
                                    ? Color(0xFF000000)
                                    : Color(0xFFFFFFFF),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 6.0),
                Row(
                  children: [
                    for (final m in luminanceRanked)
                      Expanded(
                        child: Text(
                          m['name'] as String,
                          style: TextStyle(fontSize: 8.0),
                          textAlign: TextAlign.center,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: 24.0),

          // ============================================================
          // SECTION 10: RECIPE CARDS
          // ============================================================
          _sectionHeader(
            '10. Recipe Cards',
            Color(0xFF2E7D32),
            Color(0xFFE8F5E9),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Color(0xFFE8F5E9),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Color(0xFFA5D6A7), width: 1.0),
            ),
            child: Column(
              children: [
                for (final r in recipes)
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: Color(0xFF66BB6A),
                          width: 1.0,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            r['title']!,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13.0,
                              color: Color(0xFF1B5E20),
                            ),
                          ),
                          SizedBox(height: 4.0),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 6.0,
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xFFE8F5E9),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Text(
                              r['code']!,
                              style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 11.0,
                                color: Color(0xFF2E7D32),
                              ),
                            ),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            r['why']!,
                            style: TextStyle(
                              fontSize: 11.0,
                              color: Color(0xFF424242),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),

          SizedBox(height: 24.0),

          // ============================================================
          // SECTION 11: COMPARISON TABLE
          // ============================================================
          _sectionHeader(
            '11. Comparison — Color vs MaterialColor vs Tokens',
            Color(0xFFE65100),
            Color(0xFFFFF3E0),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Color(0xFFFFF3E0),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Color(0xFFFFCC80), width: 1.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _th('Kind', 2),
                    _th('Lives in', 3),
                    _th('Shape', 3),
                    _th('Usage', 3),
                  ],
                ),
                SizedBox(height: 4.0),
                for (final row in comparison)
                  Padding(
                    padding: EdgeInsets.only(bottom: 4.0),
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Color(0xFFFFE0B2),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Row(
                        children: [
                          _td(row['kind']!, 2, bold: true),
                          _td(row['lives']!, 3),
                          _td(row['shape']!, 3),
                          _td(row['usage']!, 3),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),

          SizedBox(height: 24.0),

          // ============================================================
          // SECTION 12: GLOSSARY
          // ============================================================
          _sectionHeader(
            '12. Glossary',
            Color(0xFF37474F),
            Color(0xFFCFD8DC),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Color(0xFFCFD8DC),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Color(0xFF90A4AE), width: 1.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final g in glossary)
                  Padding(
                    padding: EdgeInsets.only(bottom: 6.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 110.0,
                          child: Text(
                            g['term']!,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                              color: Color(0xFF263238),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            g['def']!,
                            style: TextStyle(
                              fontSize: 11.0,
                              color: Color(0xFF37474F),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),

          SizedBox(height: 24.0),

          // ============================================================
          // SECTION 13: FINAL COMPOSED PREVIEW
          // ============================================================
          _sectionHeader(
            '13. Final Composed Preview',
            Color(0xFF1A237E),
            Color(0xFFE8EAF6),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.lerp(lerpA, lerpB, 0.0)!,
                  Color.lerp(lerpA, lerpB, 0.5)!,
                  Color.lerp(lerpA, lerpB, 1.0)!,
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Everything together',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'A gradient from ${_hex(lerpA)} to ${_hex(lerpB)} via lerp(), '
                  'topped with an alphaBlend scrim, sitting above a row of '
                  'indigo shades from the MaterialColor swatch.',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Color(0xFFFFFFFF),
                    height: 1.4,
                  ),
                ),
                SizedBox(height: 12.0),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Color.alphaBlend(
                      Color(0x66000000),
                      Color(0xFFFFFFFF),
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    children: [
                      for (final entry in indigoShades)
                        Expanded(
                          child: Container(
                            height: 28.0,
                            margin: EdgeInsets.symmetric(horizontal: 1.0),
                            color: entry['color'] as Color,
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _summaryChip('Color ✓'),
                    _summaryChip('Colors ✓'),
                    _summaryChip('MaterialColor ✓'),
                    _summaryChip('lerp ✓'),
                    _summaryChip('alphaBlend ✓'),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: 16.0),

          // ===== FOOTER =====
          Center(
            child: Text(
              'Deep Demo • Color & Colors • Flutter Painting',
              style: TextStyle(fontSize: 12.0, color: Color(0xFF9E9E9E)),
            ),
          ),
        ],
      ),
    ),
  );
}

// ============================================================================
// HELPER WIDGETS
// ============================================================================

String _hex(Color c) {
  final v = c.value.toRadixString(16).padLeft(8, '0').toUpperCase();
  return '0x$v';
}

Widget _pill(String label) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
    decoration: BoxDecoration(
      color: Color(0x33FFFFFF),
      borderRadius: BorderRadius.circular(16.0),
    ),
    child: Text(
      label,
      style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 11.0),
    ),
  );
}

Widget _sectionHeader(String title, Color accent, Color bg) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8.0),
    child: Row(
      children: [
        Container(
          width: 6.0,
          height: 24.0,
          decoration: BoxDecoration(
            color: accent,
            borderRadius: BorderRadius.circular(3.0),
          ),
        ),
        SizedBox(width: 8.0),
        Text(
          title,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: accent,
          ),
        ),
      ],
    ),
  );
}

Widget _byteBox(String label, String value, Color color) {
  return Expanded(
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 2.0),
      padding: EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
            ),
          ),
          SizedBox(height: 2.0),
          Text(
            value,
            style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontFamily: 'monospace',
              fontSize: 11.0,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _codeLine(String code) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2.0),
    child: Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: Color(0xFFE1BEE7),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Text(
        code,
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 11.0,
          color: Color(0xFF4A148C),
        ),
      ),
    ),
  );
}

Widget _rampLabel(String label) {
  return Padding(
    padding: EdgeInsets.only(bottom: 4.0),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 12.0,
        fontFamily: 'monospace',
        color: Color(0xFF004D40),
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget _rampRow(List<Color> colors) {
  return Row(
    children: [
      for (final c in colors)
        Expanded(
          child: Container(
            height: 44.0,
            margin: EdgeInsets.symmetric(horizontal: 1.0),
            decoration: BoxDecoration(
              color: c,
              border: Border.all(color: Color(0x33000000), width: 0.5),
            ),
            child: Center(
              child: Text(
                _hex(c),
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 8.0,
                  color: c.computeLuminance() > 0.5
                      ? Color(0xFF000000)
                      : Color(0xFFFFFFFF),
                ),
              ),
            ),
          ),
        ),
    ],
  );
}

Widget _paletteFamily(String label, List<Map<String, dynamic>> entries) {
  return Padding(
    padding: EdgeInsets.only(bottom: 12.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13.0,
            color: Color(0xFF880E4F),
          ),
        ),
        SizedBox(height: 6.0),
        Wrap(
          spacing: 4.0,
          runSpacing: 4.0,
          children: [
            for (final e in entries)
              Container(
                width: 96.0,
                height: 56.0,
                decoration: BoxDecoration(
                  color: e['color'] as Color,
                  borderRadius: BorderRadius.circular(4.0),
                  border: Border.all(color: Color(0x33000000), width: 0.5),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      e['name'] as String,
                      style: TextStyle(
                        fontSize: 10.0,
                        fontWeight: FontWeight.bold,
                        color:
                            (e['color'] as Color).computeLuminance() > 0.5
                                ? Color(0xFF000000)
                                : Color(0xFFFFFFFF),
                      ),
                    ),
                    SizedBox(height: 2.0),
                    Text(
                      _hex(e['color'] as Color),
                      style: TextStyle(
                        fontSize: 8.0,
                        fontFamily: 'monospace',
                        color:
                            (e['color'] as Color).computeLuminance() > 0.5
                                ? Color(0xFF000000)
                                : Color(0xFFFFFFFF),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ],
    ),
  );
}

Widget _th(String label, int flex) {
  return Expanded(
    flex: flex,
    child: Text(
      label,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 11.0,
        color: Color(0xFFBF360C),
      ),
    ),
  );
}

Widget _td(String label, int flex, {bool bold = false}) {
  return Expanded(
    flex: flex,
    child: Text(
      label,
      style: TextStyle(
        fontSize: 10.0,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal,
        color: Color(0xFF424242),
      ),
    ),
  );
}

Widget _summaryChip(String label) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
    decoration: BoxDecoration(
      color: Color(0x33FFFFFF),
      borderRadius: BorderRadius.circular(16.0),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: Color(0xFFFFFFFF),
        fontSize: 11.0,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
