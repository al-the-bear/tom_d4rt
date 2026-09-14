// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// =============================================================================
//  COMPASS OBSIDIAN  ::  TargetPlatform Atlas
// =============================================================================
//
//  THEME
//  -----
//  "Compass Obsidian" — a darkly polished compass-rose visual language. We
//  imagine a navigator's brass instrument set against an obsidian slab. Each
//  TargetPlatform value is a cardinal point on that compass: Android to the
//  east (industrial green), iOS to the west (glassy silver), macOS to the
//  northwest (granite), Windows to the north (cobalt), Linux to the south
//  (penguin-graphite), and Fuchsia at the off-rose meridian (rose magenta).
//
//  SUBJECT
//  -------
//  TargetPlatform is the enum that tells Flutter which platform's interaction
//  conventions to honor. It is the *source of truth* for adaptive behaviour:
//
//     * Switch.adaptive picks Cupertino on iOS/macOS, Material elsewhere.
//     * Icon.adaptive_arrow_back swaps the chevron glyph.
//     * ScrollPhysics morphs from BouncingScrollPhysics to ClampingScrollPhysics.
//     * Theme.of(context).platform reads from MaterialApp's platform override,
//       falling through to defaultTargetPlatform when not set.
//
//  PHILOSOPHY
//  ----------
//  TargetPlatform is *intent*, not *truth*. The truth is `Platform.isIOS`. The
//  intent is "I want to render with iOS conventions even on a desktop debug
//  run." Flutter chooses intent over truth deliberately so that designers can
//  preview platform skins on any host. This script catalogs the enum, the
//  resolution chain, and the adaptive widgets that consume it.
//
//  SECTIONS
//  --------
//   1. Title banner with Compass Obsidian palette swatches.
//   2. Prose anatomy — what TargetPlatform IS and IS NOT.
//   3. Property anatomy — the six enum values and their material/cupertino map.
//   4. Per-platform card gallery — six large cards, one per enum value.
//   5. Adaptive widget matrix — 6 platforms x 4 widget categories.
//   6. Comparison table — twelve+ behavioural differences.
//   7. Resolution timeline — Platform.operatingSystem -> default -> Theme.
//   8. Live readout — defaultTargetPlatform + Theme.of(context).platform.
//   9. DO / AVOID callouts — six rules of adaptive design.
//  10. Code-snippet cards — five canonical recipes.
//  11. Glossary — twelve+ terms.
//  12. Recap footer — Compass Obsidian closing motto.
//
//  RULES OF THE ROAD (D4RT CONSTRAINTS)
//  ------------------------------------
//   * build(context) is invoked exactly ONCE; we return a frozen tree.
//   * No StatefulWidget, no setState, no controllers, no timers.
//   * No streams, no futures, no animation tickers.
//   * No `for-in` loops over BridgedInstance values.
//   * No `.value` reads on Tween.animate(...) results.
//   * Use `Color.withValues(alpha: ...)` instead of `withOpacity`.
//   * Real enum identifiers: TargetPlatform.android, .iOS, .macOS, etc.
//   * Embed defaultTargetPlatform.name in actual Text widgets.
//   * Narrate the script with print(...) calls — five to fifteen total.
//
//  ATTRIBUTION
//  -----------
//  Compass Obsidian is a fictional design language invented for this teaching
//  artifact. It draws from compass cartography, brass-and-slate aesthetics,
//  and the "platform-as-intent" philosophy of Flutter's adaptive system.
// =============================================================================

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ===========================================================================
  // SECTION 0 :: NARRATIVE PRELUDE
  // ===========================================================================
  print('[Compass Obsidian] charting the TargetPlatform atlas...');
  print('[Compass Obsidian] enum cardinality = ${TargetPlatform.values.length}');
  print('[Compass Obsidian] defaultTargetPlatform = ${defaultTargetPlatform.name}');

  // ---------------------------------------------------------------------------
  // PALETTE :: Compass Obsidian — 14 named colors
  // ---------------------------------------------------------------------------
  final Color obsidianBase = Color(0xFF0E1116);          // slab black
  final Color obsidianHaze = Color(0xFF1A1F27);          // smoky panel
  final Color brassGleam = Color(0xFFC8A24B);            // compass brass
  final Color brassDeep = Color(0xFF7A5E22);             // tarnished brass
  final Color compassRose = Color(0xFFE9D8A6);           // ivory rose
  final Color cardinalNorth = Color(0xFF3A6EA5);         // cobalt north
  final Color cardinalEast = Color(0xFF4F8C3A);          // industrial green
  final Color cardinalSouth = Color(0xFF5B5B5B);         // graphite south
  final Color cardinalWest = Color(0xFFB7C2CC);          // glass silver
  final Color meridianRose = Color(0xFFCE3B7E);          // fuchsia meridian
  final Color granitePeak = Color(0xFF8A8E96);           // mac granite
  final Color parchmentGlow = Color(0xFFF3E9C9);         // text parchment
  final Color emberAccent = Color(0xFFE07A3C);           // ember warning
  final Color tealCipher = Color(0xFF2A8C8C);            // cipher teal

  print('[Compass Obsidian] palette assembled — 14 swatches ready.');

  // ---------------------------------------------------------------------------
  // ENUM CATALOG :: gather every TargetPlatform value
  // ---------------------------------------------------------------------------
  final TargetPlatform pAndroid = TargetPlatform.android;
  final TargetPlatform pFuchsia = TargetPlatform.fuchsia;
  final TargetPlatform pIOS = TargetPlatform.iOS;
  final TargetPlatform pLinux = TargetPlatform.linux;
  final TargetPlatform pMacOS = TargetPlatform.macOS;
  final TargetPlatform pWindows = TargetPlatform.windows;

  final List<TargetPlatform> allPlatforms = TargetPlatform.values;
  print('[Compass Obsidian] catalog: ${allPlatforms.length} cardinals registered.');

  // Live readout values
  final TargetPlatform liveDefault = defaultTargetPlatform;
  final TargetPlatform liveTheme = Theme.of(context).platform;
  print('[Compass Obsidian] live default = ${liveDefault.name}');
  print('[Compass Obsidian] live theme   = ${liveTheme.name}');

  // ---------------------------------------------------------------------------
  // SWITCH-EXHAUSTIVE LABEL FUNCTION
  // ---------------------------------------------------------------------------
  String prettyLabelFor(TargetPlatform p) {
    switch (p) {
      case TargetPlatform.android:
        return 'Android (Material East)';
      case TargetPlatform.fuchsia:
        return 'Fuchsia (Meridian Rose)';
      case TargetPlatform.iOS:
        return 'iOS (Cupertino West)';
      case TargetPlatform.linux:
        return 'Linux (Graphite South)';
      case TargetPlatform.macOS:
        return 'macOS (Granite Peak)';
      case TargetPlatform.windows:
        return 'Windows (Cobalt North)';
    }
  }

  Color cardColorFor(TargetPlatform p) {
    switch (p) {
      case TargetPlatform.android:
        return cardinalEast;
      case TargetPlatform.fuchsia:
        return meridianRose;
      case TargetPlatform.iOS:
        return cardinalWest;
      case TargetPlatform.linux:
        return cardinalSouth;
      case TargetPlatform.macOS:
        return granitePeak;
      case TargetPlatform.windows:
        return cardinalNorth;
    }
  }

  IconData iconFor(TargetPlatform p) {
    switch (p) {
      case TargetPlatform.android:
        return Icons.android;
      case TargetPlatform.fuchsia:
        return Icons.bubble_chart;
      case TargetPlatform.iOS:
        return Icons.phone_iphone;
      case TargetPlatform.linux:
        return Icons.terminal;
      case TargetPlatform.macOS:
        return Icons.laptop_mac;
      case TargetPlatform.windows:
        return Icons.desktop_windows;
    }
  }

  String designLanguageFor(TargetPlatform p) {
    switch (p) {
      case TargetPlatform.android:
        return 'Material 3 — bold ink, ripple, FAB';
      case TargetPlatform.fuchsia:
        return 'Material with experimental rose accents';
      case TargetPlatform.iOS:
        return 'Cupertino — translucent panes, rubber-band scroll';
      case TargetPlatform.linux:
        return 'Material desktop — flat, dense, keyboard-first';
      case TargetPlatform.macOS:
        return 'Cupertino desktop — vibrancy, sheet dialogs';
      case TargetPlatform.windows:
        return 'Material desktop — Fluent-leaning accents';
    }
  }

  String backGestureFor(TargetPlatform p) {
    switch (p) {
      case TargetPlatform.android:
        return 'System back button + edge-swipe predictive';
      case TargetPlatform.fuchsia:
        return 'System back gesture (Material parity)';
      case TargetPlatform.iOS:
        return 'Edge-swipe pop with parallax';
      case TargetPlatform.linux:
        return 'Mouse + keyboard Alt+Left';
      case TargetPlatform.macOS:
        return 'Two-finger swipe + Cmd+[';
      case TargetPlatform.windows:
        return 'Mouse back-button, Alt+Left';
    }
  }

  // ===========================================================================
  // SECTION 1 :: TITLE BANNER WITH PALETTE SWATCHES
  // ===========================================================================
  Widget paletteSwatch(String name, Color c) {
    return Container(
      width: 110,
      margin: EdgeInsets.only(right: 8, bottom: 8),
      decoration: BoxDecoration(
        color: obsidianHaze,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: brassDeep.withValues(alpha: 0.6)),
      ),
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 28,
            decoration: BoxDecoration(
              color: c,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          SizedBox(height: 6),
          Text(
            name,
            style: TextStyle(color: parchmentGlow, fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget titleBanner = Container(
    width: double.infinity,
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [obsidianBase, obsidianHaze],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: brassGleam, width: 2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.explore, color: brassGleam, size: 36),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'COMPASS OBSIDIAN',
                    style: TextStyle(
                      color: brassGleam,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 4,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'A TargetPlatform Atlas — Six Cardinals of Adaptive Flutter',
                    style: TextStyle(
                      color: compassRose,
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 14),
        Text(
          'Palette',
          style: TextStyle(
            color: brassGleam,
            fontSize: 12,
            letterSpacing: 2,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8),
        Wrap(
          children: [
            paletteSwatch('obsidianBase', obsidianBase),
            paletteSwatch('obsidianHaze', obsidianHaze),
            paletteSwatch('brassGleam', brassGleam),
            paletteSwatch('brassDeep', brassDeep),
            paletteSwatch('compassRose', compassRose),
            paletteSwatch('cardinalNorth', cardinalNorth),
            paletteSwatch('cardinalEast', cardinalEast),
            paletteSwatch('cardinalSouth', cardinalSouth),
            paletteSwatch('cardinalWest', cardinalWest),
            paletteSwatch('meridianRose', meridianRose),
            paletteSwatch('granitePeak', granitePeak),
            paletteSwatch('parchmentGlow', parchmentGlow),
            paletteSwatch('emberAccent', emberAccent),
            paletteSwatch('tealCipher', tealCipher),
          ],
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 2 :: PROSE ANATOMY
  // ===========================================================================
  Widget proseParagraph(String body) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Text(
        body,
        style: TextStyle(
          color: parchmentGlow.withValues(alpha: 0.92),
          fontSize: 13,
          height: 1.5,
        ),
      ),
    );
  }

  Widget proseAnatomy = Container(
    width: double.infinity,
    margin: EdgeInsets.only(top: 18),
    padding: EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: obsidianHaze,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: brassDeep),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.menu_book, color: brassGleam, size: 22),
            SizedBox(width: 8),
            Text(
              '02  ::  PROSE ANATOMY',
              style: TextStyle(
                color: brassGleam,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        proseParagraph(
          'TargetPlatform is an enum exported from package:flutter/foundation.dart. '
          'It carries six values: android, fuchsia, iOS, linux, macOS, windows. It '
          'represents the *intent* — which platform conventions Flutter should obey '
          'when rendering — rather than the actual host operating system.',
        ),
        proseParagraph(
          'The variable defaultTargetPlatform is initialized at startup. On debug '
          'builds, Flutter inspects Platform.operatingSystem and maps it onto a '
          'TargetPlatform value. It can be overridden by setting '
          'debugDefaultTargetPlatformOverride during debug runs to preview a '
          'different platform skin.',
        ),
        proseParagraph(
          'Theme.of(context).platform exposes the resolved platform for the '
          'subtree. MaterialApp accepts a `platform:` argument; if you pass '
          'TargetPlatform.iOS, every descendant adaptive widget will pretend '
          'to be on iOS regardless of the host. This is the lever designers '
          'pull to verify cross-platform parity.',
        ),
        proseParagraph(
          'Adaptive widgets — Switch.adaptive, Slider.adaptive, '
          'Icon.adaptive_arrow_back, CircularProgressIndicator.adaptive, and '
          'others — read this resolved value and switch between Material and '
          'Cupertino implementations.',
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 3 :: PROPERTY ANATOMY (per enum value)
  // ===========================================================================
  Widget propertyRow(TargetPlatform p) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: obsidianBase,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: cardColorFor(p).withValues(alpha: 0.6)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: cardColorFor(p).withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: cardColorFor(p)),
            ),
            child: Icon(iconFor(p), color: cardColorFor(p), size: 24),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'TargetPlatform.${p.name}',
                  style: TextStyle(
                    color: brassGleam,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  prettyLabelFor(p),
                  style: TextStyle(color: compassRose, fontSize: 12),
                ),
                SizedBox(height: 4),
                Text(
                  'Design language: ${designLanguageFor(p)}',
                  style: TextStyle(
                    color: parchmentGlow.withValues(alpha: 0.88),
                    fontSize: 11,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'index=${p.index} · name="${p.name}"',
                  style: TextStyle(
                    color: tealCipher,
                    fontSize: 11,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget propertyAnatomy = Container(
    width: double.infinity,
    margin: EdgeInsets.only(top: 18),
    padding: EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: obsidianHaze,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: brassDeep),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.list_alt, color: brassGleam, size: 22),
            SizedBox(width: 8),
            Text(
              '03  ::  PROPERTY ANATOMY  ::  SIX CARDINALS',
              style: TextStyle(
                color: brassGleam,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
        SizedBox(height: 6),
        Text(
          'Each TargetPlatform value below shows its enum index, design language, '
          'and the visual cardinal we have assigned to it within Compass Obsidian.',
          style: TextStyle(color: compassRose, fontSize: 12, fontStyle: FontStyle.italic),
        ),
        propertyRow(pAndroid),
        propertyRow(pFuchsia),
        propertyRow(pIOS),
        propertyRow(pLinux),
        propertyRow(pMacOS),
        propertyRow(pWindows),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 4 :: PER-PLATFORM CARD GALLERY
  // ===========================================================================
  Widget galleryCard(TargetPlatform p, String motto, List<String> bullets) {
    return Container(
      width: 280,
      margin: EdgeInsets.only(right: 12, bottom: 12),
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: obsidianBase,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: cardColorFor(p), width: 2),
        boxShadow: [
          BoxShadow(
            color: cardColorFor(p).withValues(alpha: 0.18),
            blurRadius: 16,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(iconFor(p), color: cardColorFor(p), size: 28),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  prettyLabelFor(p),
                  style: TextStyle(
                    color: brassGleam,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 6),
          Text(
            motto,
            style: TextStyle(
              color: compassRose,
              fontSize: 12,
              fontStyle: FontStyle.italic,
            ),
          ),
          Divider(color: brassDeep.withValues(alpha: 0.6)),
          Text(
            'Adaptive widget choices',
            style: TextStyle(
              color: tealCipher,
              fontSize: 11,
              letterSpacing: 1.5,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 4),
          Text(
            '• ${bullets[0]}',
            style: TextStyle(color: parchmentGlow, fontSize: 11, height: 1.4),
          ),
          Text(
            '• ${bullets[1]}',
            style: TextStyle(color: parchmentGlow, fontSize: 11, height: 1.4),
          ),
          Text(
            '• ${bullets[2]}',
            style: TextStyle(color: parchmentGlow, fontSize: 11, height: 1.4),
          ),
          Text(
            '• ${bullets[3]}',
            style: TextStyle(color: parchmentGlow, fontSize: 11, height: 1.4),
          ),
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: cardColorFor(p).withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              'index ${p.index}  ·  back: ${backGestureFor(p)}',
              style: TextStyle(
                color: cardColorFor(p),
                fontSize: 10,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget galleryAndroid = galleryCard(pAndroid, 'Industrial East — bold ripple, FAB orbits.', [
    'Switch.adaptive renders MD3 Switch with thumb travel.',
    'Icon.adaptive_arrow_back uses Icons.arrow_back.',
    'ScrollPhysics defaults to ClampingScrollPhysics overscroll glow.',
    'CircularProgressIndicator.adaptive renders Material spinner.',
  ]);

  Widget galleryFuchsia = galleryCard(pFuchsia, 'Meridian Rose — Material parity, experimental ground.', [
    'Behaves like Android in adaptive widgets.',
    'Icons stay Material; rose accents reserved for theming.',
    'ScrollPhysics matches Android (clamping + glow).',
    'Reserved for future Fuchsia conventions.',
  ]);

  Widget galleryIOS = galleryCard(pIOS, 'Cupertino West — glassy panes, rubber bounce.', [
    'Switch.adaptive renders CupertinoSwitch (track green).',
    'Icon.adaptive_arrow_back uses Icons.arrow_back_ios_new.',
    'ScrollPhysics is BouncingScrollPhysics — rubber band.',
    'CircularProgressIndicator.adaptive renders CupertinoActivityIndicator.',
  ]);

  Widget galleryLinux = galleryCard(pLinux, 'Graphite South — keyboard-first, dense layouts.', [
    'Adaptive widgets remain Material flavoured.',
    'Mouse hover states encouraged on all interactive widgets.',
    'ScrollPhysics defaults to clamping desktop physics.',
    'Right-click menus expected for productivity tools.',
  ]);

  Widget galleryMacOS = galleryCard(pMacOS, 'Granite Peak — vibrancy + sheet dialogs.', [
    'Switch.adaptive renders CupertinoSwitch desktop variant.',
    'Icon.adaptive_arrow_back uses Cupertino chevron.',
    'ScrollPhysics is BouncingScrollPhysics on inertial trackpads.',
    'Dialogs lean toward sheet presentations (Cupertino).',
  ]);

  Widget galleryWindows = galleryCard(pWindows, 'Cobalt North — Fluent accents on Material.', [
    'Adaptive widgets render Material flavour.',
    'Mouse + keyboard parity with rich tooltips.',
    'ScrollPhysics: clamping; mouse-wheel inertia tuned.',
    'FluentUI styling possible via separate package.',
  ]);

  Widget galleryRow = SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: [
        galleryAndroid,
        galleryFuchsia,
        galleryIOS,
        galleryLinux,
        galleryMacOS,
        galleryWindows,
      ],
    ),
  );

  Widget gallerySection = Container(
    width: double.infinity,
    margin: EdgeInsets.only(top: 18),
    padding: EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: obsidianHaze,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: brassDeep),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.collections, color: brassGleam, size: 22),
            SizedBox(width: 8),
            Text(
              '04  ::  PER-PLATFORM CARD GALLERY',
              style: TextStyle(
                color: brassGleam,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          'Six cards, one per cardinal. Each lists adaptive widget choices and the '
          'back-navigation gesture model the platform expects.',
          style: TextStyle(color: compassRose, fontSize: 12, fontStyle: FontStyle.italic),
        ),
        SizedBox(height: 12),
        galleryRow,
      ],
    ),
  );

  // ===========================================================================
  // SECTION 5 :: ADAPTIVE WIDGET MATRIX (6 x 4)
  // ===========================================================================
  Widget matrixHeaderCell(String label) {
    return Container(
      width: 130,
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 6),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: brassDeep.withValues(alpha: 0.4),
        border: Border.all(color: brassGleam.withValues(alpha: 0.6)),
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: brassGleam,
          fontSize: 11,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.4,
        ),
      ),
    );
  }

  Widget matrixCell(String content, Color tint) {
    return Container(
      width: 130,
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 6),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: tint.withValues(alpha: 0.10),
        border: Border.all(color: tint.withValues(alpha: 0.45)),
      ),
      child: Text(
        content,
        style: TextStyle(color: parchmentGlow, fontSize: 10.5, height: 1.3),
      ),
    );
  }

  String switchFor(TargetPlatform p) {
    switch (p) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return 'CupertinoSwitch';
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return 'Material Switch';
    }
  }

  String sliderFor(TargetPlatform p) {
    switch (p) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return 'CupertinoSlider';
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return 'Material Slider';
    }
  }

  String iconKindFor(TargetPlatform p) {
    switch (p) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return 'arrow_back_ios_new';
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return 'arrow_back';
    }
  }

  String physicsFor(TargetPlatform p) {
    switch (p) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return 'BouncingScrollPhysics';
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return 'ClampingScrollPhysics';
    }
  }

  Widget matrixRow(TargetPlatform p) {
    final Color tint = cardColorFor(p);
    return Row(
      children: [
        Container(
          width: 130,
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 6),
          decoration: BoxDecoration(
            color: tint.withValues(alpha: 0.25),
            border: Border.all(color: tint),
          ),
          child: Row(
            children: [
              Icon(iconFor(p), color: tint, size: 16),
              SizedBox(width: 6),
              Expanded(
                child: Text(
                  p.name,
                  style: TextStyle(
                    color: brassGleam,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        matrixCell(switchFor(p), tint),
        matrixCell(sliderFor(p), tint),
        matrixCell(iconKindFor(p), tint),
        matrixCell(physicsFor(p), tint),
      ],
    );
  }

  Widget matrixSection = Container(
    width: double.infinity,
    margin: EdgeInsets.only(top: 18),
    padding: EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: obsidianHaze,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: brassDeep),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.grid_on, color: brassGleam, size: 22),
            SizedBox(width: 8),
            Text(
              '05  ::  ADAPTIVE WIDGET MATRIX  ::  6 × 4',
              style: TextStyle(
                color: brassGleam,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Text(
          'Rows: TargetPlatform values. Columns: Switch / Slider / Icon / ScrollPhysics.',
          style: TextStyle(color: compassRose, fontSize: 12, fontStyle: FontStyle.italic),
        ),
        SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  matrixHeaderCell('Platform'),
                  matrixHeaderCell('Switch.adaptive'),
                  matrixHeaderCell('Slider.adaptive'),
                  matrixHeaderCell('Icon.adaptive'),
                  matrixHeaderCell('ScrollPhysics'),
                ],
              ),
              matrixRow(pAndroid),
              matrixRow(pFuchsia),
              matrixRow(pIOS),
              matrixRow(pLinux),
              matrixRow(pMacOS),
              matrixRow(pWindows),
            ],
          ),
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 6 :: COMPARISON TABLE (12+ behaviour rows)
  // ===========================================================================
  Widget comparisonRow(String aspect, String iosLike, String materialLike) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: brassDeep.withValues(alpha: 0.4))),
      ),
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 160,
            child: Text(
              aspect,
              style: TextStyle(
                color: brassGleam,
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 6),
              decoration: BoxDecoration(
                color: cardinalWest.withValues(alpha: 0.10),
              ),
              child: Text(
                iosLike,
                style: TextStyle(color: parchmentGlow, fontSize: 11, height: 1.4),
              ),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 6),
              decoration: BoxDecoration(
                color: cardinalEast.withValues(alpha: 0.10),
              ),
              child: Text(
                materialLike,
                style: TextStyle(color: parchmentGlow, fontSize: 11, height: 1.4),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget comparisonHeader = Padding(
    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
    child: Row(
      children: [
        SizedBox(
          width: 160,
          child: Text(
            'Aspect',
            style: TextStyle(
              color: brassGleam,
              fontSize: 11.5,
              letterSpacing: 1.4,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: Text(
            'iOS / macOS (Cupertino)',
            style: TextStyle(
              color: cardinalWest,
              fontSize: 11.5,
              letterSpacing: 1.4,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            'Android / Fuchsia / Linux / Windows (Material)',
            style: TextStyle(
              color: cardinalEast,
              fontSize: 11.5,
              letterSpacing: 1.4,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );

  Widget comparisonSection = Container(
    width: double.infinity,
    margin: EdgeInsets.only(top: 18),
    padding: EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: obsidianHaze,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: brassDeep),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.compare_arrows, color: brassGleam, size: 22),
            SizedBox(width: 8),
            Text(
              '06  ::  COMPARISON TABLE  ::  CUPERTINO vs MATERIAL',
              style: TextStyle(
                color: brassGleam,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        comparisonHeader,
        comparisonRow(
          'Back-button gesture',
          'Edge-swipe with parallax pop transition',
          'System back button + predictive edge-swipe (Android 14+)',
        ),
        comparisonRow(
          'Scroll bounce',
          'BouncingScrollPhysics — rubber-band overscroll',
          'ClampingScrollPhysics + GlowingOverscrollIndicator',
        ),
        comparisonRow(
          'Font fallback',
          'San Francisco / SF Pro stack',
          'Roboto / system stack',
        ),
        comparisonRow(
          'FAB style',
          'Generally absent — actions in toolbar/nav bar',
          'FloatingActionButton with elevation + ripple',
        ),
        comparisonRow(
          'Dialog shape',
          'CupertinoAlertDialog — small radius, action buttons',
          'AlertDialog — Material radius, Material buttons',
        ),
        comparisonRow(
          'Ripple effect',
          'No ripple — opacity flash on tap',
          'InkWell ripple animates outward from touch point',
        ),
        comparisonRow(
          'Switch widget',
          'CupertinoSwitch — pill track, smooth thumb',
          'Material Switch — rectangular track, thumb shadow',
        ),
        comparisonRow(
          'AppBar style',
          'CupertinoNavigationBar — large title, blur backdrop',
          'AppBar — Material elevation, leading + actions',
        ),
        comparisonRow(
          'Page transition',
          'Cupertino slide-from-right with parallax',
          'Material fade-up / shared-axis transitions',
        ),
        comparisonRow(
          'Tab bar',
          'CupertinoTabBar — bottom, blurred background',
          'BottomNavigationBar / NavigationBar (Material 3)',
        ),
        comparisonRow(
          'Text selection handles',
          'iOS-style lozenge handles, magnifier on hold',
          'Material drop handles, paste tooltip',
        ),
        comparisonRow(
          'Date/time picker',
          'CupertinoDatePicker — wheel scroll',
          'showDatePicker — calendar grid',
        ),
        comparisonRow(
          'Modal sheet',
          'CupertinoActionSheet / CupertinoSheet',
          'showModalBottomSheet (Material)',
        ),
        comparisonRow(
          'Pull-to-refresh',
          'CupertinoSliverRefreshControl — spinner appears below',
          'RefreshIndicator — circular Material spinner',
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 7 :: RESOLUTION TIMELINE
  // ===========================================================================
  Widget timelineStep(int index, String title, String body, Color accent) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: obsidianBase,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: accent.withValues(alpha: 0.6)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.2),
              shape: BoxShape.circle,
              border: Border.all(color: accent),
            ),
            child: Text(
              '$index',
              style: TextStyle(
                color: accent,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: brassGleam,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  body,
                  style: TextStyle(
                    color: parchmentGlow.withValues(alpha: 0.9),
                    fontSize: 11.5,
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

  Widget timelineSection = Container(
    width: double.infinity,
    margin: EdgeInsets.only(top: 18),
    padding: EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: obsidianHaze,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: brassDeep),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.timeline, color: brassGleam, size: 22),
            SizedBox(width: 8),
            Text(
              '07  ::  RESOLUTION TIMELINE',
              style: TextStyle(
                color: brassGleam,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
        SizedBox(height: 6),
        Text(
          'How a TargetPlatform value is resolved at any point in the widget tree.',
          style: TextStyle(color: compassRose, fontSize: 12, fontStyle: FontStyle.italic),
        ),
        timelineStep(
          1,
          'Boot · Platform.operatingSystem',
          'On native start, dart:io reports the host OS string ("ios", "android", "linux", '
              '"macos", "windows"). On web, kIsWeb short-circuits this.',
          cardinalNorth,
        ),
        timelineStep(
          2,
          'Map · _defaultTargetPlatformForOSName',
          'Flutter maps the OS string to a TargetPlatform value. "ios" -> TargetPlatform.iOS, '
              '"macos" -> TargetPlatform.macOS, etc. Result is cached in defaultTargetPlatform.',
          cardinalEast,
        ),
        timelineStep(
          3,
          'Override · debugDefaultTargetPlatformOverride',
          'In debug builds, setting this static lets developers preview a different platform '
              'skin. Production builds ignore the override.',
          emberAccent,
        ),
        timelineStep(
          4,
          'Theme · MaterialApp(platform:)',
          'If MaterialApp is constructed with a platform: argument, ThemeData stores it. The '
              'theme value wins for descendants.',
          meridianRose,
        ),
        timelineStep(
          5,
          'Read · Theme.of(context).platform',
          'Adaptive widgets call Theme.of(context).platform. This returns the theme override '
              'if set, otherwise falls through to defaultTargetPlatform.',
          cardinalWest,
        ),
        timelineStep(
          6,
          'Render · Adaptive widgets',
          'Switch.adaptive, Slider.adaptive, Icon.adaptive_arrow_back, '
              'CircularProgressIndicator.adaptive each branch on the resolved platform and '
              'render the corresponding Material or Cupertino widget.',
          tealCipher,
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 8 :: LIVE READOUT
  // ===========================================================================
  Widget readoutTile(String label, String value, Color tint) {
    return Container(
      width: 240,
      margin: EdgeInsets.only(right: 12, bottom: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: obsidianBase,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: tint),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: tint,
              fontSize: 11,
              letterSpacing: 1.4,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              color: brassGleam,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }

  Widget liveReadoutSection = Container(
    width: double.infinity,
    margin: EdgeInsets.only(top: 18),
    padding: EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: obsidianHaze,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: brassDeep),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.satellite_alt, color: brassGleam, size: 22),
            SizedBox(width: 8),
            Text(
              '08  ::  LIVE READOUT  ::  THIS HOST',
              style: TextStyle(
                color: brassGleam,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          'These values are read at build time from the actual runtime.',
          style: TextStyle(color: compassRose, fontSize: 12, fontStyle: FontStyle.italic),
        ),
        SizedBox(height: 12),
        Wrap(
          children: [
            readoutTile('defaultTargetPlatform', liveDefault.name, cardinalEast),
            readoutTile('Theme.of(context).platform', liveTheme.name, cardinalNorth),
            readoutTile('default index', '${liveDefault.index}', tealCipher),
            readoutTile('theme index', '${liveTheme.index}', meridianRose),
            readoutTile('total values', '${allPlatforms.length}', brassGleam),
            readoutTile('label', prettyLabelFor(liveDefault), cardinalWest),
          ],
        ),
        SizedBox(height: 8),
        Text(
          'Resolution narrative: the host reports as "${liveDefault.name}", and the theme '
          'agrees with "${liveTheme.name}". If they disagreed, the theme value would win '
          'inside this subtree.',
          style: TextStyle(
            color: parchmentGlow.withValues(alpha: 0.9),
            fontSize: 12,
            height: 1.4,
          ),
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 9 :: DO / AVOID CALLOUTS
  // ===========================================================================
  Widget calloutTile(bool good, String headline, String body) {
    final Color tint = good ? cardinalEast : emberAccent;
    final IconData glyph = good ? Icons.check_circle : Icons.warning_amber;
    final String tag = good ? 'DO' : 'AVOID';
    return Container(
      width: 320,
      margin: EdgeInsets.only(right: 12, bottom: 12),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: obsidianBase,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: tint, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(glyph, color: tint, size: 20),
              SizedBox(width: 6),
              Text(
                tag,
                style: TextStyle(
                  color: tint,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
          SizedBox(height: 4),
          Text(
            headline,
            style: TextStyle(
              color: brassGleam,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Text(
            body,
            style: TextStyle(
              color: parchmentGlow.withValues(alpha: 0.9),
              fontSize: 11.5,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget calloutsSection = Container(
    width: double.infinity,
    margin: EdgeInsets.only(top: 18),
    padding: EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: obsidianHaze,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: brassDeep),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.flag, color: brassGleam, size: 22),
            SizedBox(width: 8),
            Text(
              '09  ::  DO / AVOID CALLOUTS',
              style: TextStyle(
                color: brassGleam,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Wrap(
          children: [
            calloutTile(
              true,
              'Branch on Theme.of(context).platform',
              'Always read the resolved platform from the inherited theme — it honours '
                  'MaterialApp overrides for design previews.',
            ),
            calloutTile(
              false,
              'Branching on Platform.isIOS in widget code',
              'dart:io platform checks bypass the theme override and break design previews. '
                  'Reserve them for non-UI logic.',
            ),
            calloutTile(
              true,
              'Prefer Switch.adaptive over manual branches',
              'The adaptive variants encapsulate the platform branch and pick the correct '
                  'sub-widget for you, including future platforms.',
            ),
            calloutTile(
              false,
              'Hardcoding physics in scroll views',
              'Forcing BouncingScrollPhysics on Android breaks expectations. Let the platform '
                  'decide unless you have a strong product reason.',
            ),
            calloutTile(
              true,
              'Treat Fuchsia as Material parity',
              'Adaptive widgets render Fuchsia as Material. Do the same in custom code — fold '
                  'fuchsia into the Android branch.',
            ),
            calloutTile(
              false,
              'Forgetting desktop platforms in switches',
              'Switch statements on TargetPlatform must cover linux, macOS, and windows. '
                  'Otherwise the analyzer will warn and runtime will throw.',
            ),
            calloutTile(
              true,
              'Use debugDefaultTargetPlatformOverride for previews',
              'During development, override the default to verify your screens render '
                  'correctly across platforms without redeploying.',
            ),
            calloutTile(
              false,
              'Mutating defaultTargetPlatform in tests',
              'Setting it directly is asking for cross-test pollution. Use the debug override '
                  'inside test setup/teardown blocks.',
            ),
          ],
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 10 :: CODE-SNIPPET CARDS
  // ===========================================================================
  Widget snippetCard(String title, String code, String commentary) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: obsidianBase,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: tealCipher.withValues(alpha: 0.6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.code, color: tealCipher, size: 18),
              SizedBox(width: 6),
              Text(
                title,
                style: TextStyle(
                  color: brassGleam,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 6),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Color(0xFF06080B),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: brassDeep.withValues(alpha: 0.5)),
            ),
            child: Text(
              code,
              style: TextStyle(
                color: parchmentGlow,
                fontFamily: 'monospace',
                fontSize: 11.5,
                height: 1.45,
              ),
            ),
          ),
          SizedBox(height: 6),
          Text(
            commentary,
            style: TextStyle(
              color: compassRose,
              fontSize: 11,
              fontStyle: FontStyle.italic,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget snippetsSection = Container(
    width: double.infinity,
    margin: EdgeInsets.only(top: 18),
    padding: EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: obsidianHaze,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: brassDeep),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.terminal, color: brassGleam, size: 22),
            SizedBox(width: 8),
            Text(
              '10  ::  CODE-SNIPPET CARDS  ::  CANONICAL RECIPES',
              style: TextStyle(
                color: brassGleam,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
        snippetCard(
          'Recipe 1 — Read defaultTargetPlatform',
          'import \'package:flutter/foundation.dart\';\n'
              '\n'
              'final platform = defaultTargetPlatform;\n'
              'print(platform.name); // android | ios | macos | ...',
          'The simplest read: defaultTargetPlatform is a top-level getter. Use this when you '
              'do NOT have a BuildContext (e.g. in pure Dart utility code).',
        ),
        snippetCard(
          'Recipe 2 — Read Theme.of(context).platform',
          'final platform = Theme.of(context).platform;\n'
              'switch (platform) {\n'
              '  case TargetPlatform.iOS:\n'
              '  case TargetPlatform.macOS:\n'
              '    return CupertinoButton(child: child, onPressed: onTap);\n'
              '  default:\n'
              '    return ElevatedButton(child: child, onPressed: onTap);\n'
              '}',
          'Inside a widget build method, prefer the theme-aware read: it honours '
              'MaterialApp(platform:) overrides for design preview.',
        ),
        snippetCard(
          'Recipe 3 — Switch.adaptive in practice',
          'Switch.adaptive(\n'
              '  value: enabled,\n'
              '  onChanged: (v) => /* ... */ {},\n'
              ')',
          'Switch.adaptive automatically renders CupertinoSwitch on iOS and macOS, and the '
              'Material Switch elsewhere — no manual branching required.',
        ),
        snippetCard(
          'Recipe 4 — Override platform for design preview',
          'MaterialApp(\n'
              '  theme: ThemeData(platform: TargetPlatform.iOS),\n'
              '  home: const MyScreen(),\n'
              ')',
          'Pass platform: into ThemeData to force the entire app to render with iOS '
              'conventions, even on a Linux dev machine. Useful for screenshots.',
        ),
        snippetCard(
          'Recipe 5 — Group desktop vs mobile',
          'bool isDesktop(TargetPlatform p) {\n'
              '  switch (p) {\n'
              '    case TargetPlatform.linux:\n'
              '    case TargetPlatform.macOS:\n'
              '    case TargetPlatform.windows:\n'
              '      return true;\n'
              '    case TargetPlatform.android:\n'
              '    case TargetPlatform.fuchsia:\n'
              '    case TargetPlatform.iOS:\n'
              '      return false;\n'
              '  }\n'
              '}',
          'Encapsulate desktop/mobile classification in helpers — and prefer the exhaustive '
              'switch shape so future enum values trigger an analyzer warning.',
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 11 :: GLOSSARY
  // ===========================================================================
  Widget glossaryRow(String term, String definition, Color tint) {
    return Container(
      margin: EdgeInsets.only(top: 6),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: obsidianBase,
        border: Border(left: BorderSide(color: tint, width: 4)),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(6),
          bottomRight: Radius.circular(6),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            term,
            style: TextStyle(
              color: brassGleam,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              fontFamily: 'monospace',
            ),
          ),
          SizedBox(height: 2),
          Text(
            definition,
            style: TextStyle(
              color: parchmentGlow.withValues(alpha: 0.92),
              fontSize: 11.5,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget glossarySection = Container(
    width: double.infinity,
    margin: EdgeInsets.only(top: 18),
    padding: EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: obsidianHaze,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: brassDeep),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.menu_book_outlined, color: brassGleam, size: 22),
            SizedBox(width: 8),
            Text(
              '11  ::  GLOSSARY',
              style: TextStyle(
                color: brassGleam,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
        SizedBox(height: 6),
        glossaryRow(
          'TargetPlatform',
          'The Flutter enum of platform "intents" — android, fuchsia, iOS, linux, macOS, windows.',
          cardinalEast,
        ),
        glossaryRow(
          'defaultTargetPlatform',
          'A top-level getter from foundation.dart returning the resolved TargetPlatform for the host runtime.',
          cardinalNorth,
        ),
        glossaryRow(
          'debugDefaultTargetPlatformOverride',
          'Static field in foundation.dart; setting it overrides defaultTargetPlatform in debug builds only.',
          emberAccent,
        ),
        glossaryRow(
          'Theme.of(context).platform',
          'The resolved platform within a Theme subtree — respects MaterialApp(platform:) overrides.',
          meridianRose,
        ),
        glossaryRow(
          'Switch.adaptive',
          'Constructor on Switch that picks CupertinoSwitch on iOS/macOS and the Material Switch elsewhere.',
          cardinalWest,
        ),
        glossaryRow(
          'Slider.adaptive',
          'Constructor on Slider that yields CupertinoSlider on iOS/macOS, Material Slider otherwise.',
          tealCipher,
        ),
        glossaryRow(
          'Icon.adaptive_arrow_back',
          'IconData that resolves to arrow_back_ios_new on Cupertino platforms and arrow_back elsewhere.',
          granitePeak,
        ),
        glossaryRow(
          'CircularProgressIndicator.adaptive',
          'Constructor that renders a CupertinoActivityIndicator on iOS/macOS and the Material spinner elsewhere.',
          brassGleam,
        ),
        glossaryRow(
          'kIsWeb',
          'A compile-time constant; when true, defaultTargetPlatform is resolved from the browser user-agent.',
          cardinalSouth,
        ),
        glossaryRow(
          'BouncingScrollPhysics',
          'Scroll physics with rubber-band overscroll — the default on iOS and macOS.',
          cardinalWest,
        ),
        glossaryRow(
          'ClampingScrollPhysics',
          'Scroll physics with hard edges and a glow indicator — the default on Android, Fuchsia, Linux, Windows.',
          cardinalEast,
        ),
        glossaryRow(
          'CupertinoApp',
          'A WidgetsApp-derived root that defaults the platform to TargetPlatform.iOS regardless of host.',
          cardinalNorth,
        ),
        glossaryRow(
          'MaterialApp(platform:)',
          'Optional argument that sets ThemeData.platform — pinning the design language for the subtree.',
          meridianRose,
        ),
        glossaryRow(
          'Adaptive widget',
          'Any widget that branches on platform to pick a Material or Cupertino implementation.',
          tealCipher,
        ),
        glossaryRow(
          'Compass Obsidian',
          'The fictional design language we invented for this tutorial. Brass and obsidian, six cardinals.',
          brassGleam,
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 12 :: RECAP FOOTER
  // ===========================================================================
  Widget recapBullet(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.east, color: brassGleam, size: 14),
          SizedBox(width: 6),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: parchmentGlow.withValues(alpha: 0.92),
                fontSize: 12,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget recapFooter = Container(
    width: double.infinity,
    margin: EdgeInsets.only(top: 18, bottom: 28),
    padding: EdgeInsets.all(18),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [obsidianHaze, obsidianBase],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: brassGleam, width: 2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.auto_stories, color: brassGleam, size: 22),
            SizedBox(width: 8),
            Text(
              '12  ::  RECAP — COMPASS OBSIDIAN MOTTO',
              style: TextStyle(
                color: brassGleam,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Text(
          '"Six cardinals, one compass — let the theme name the wind, and the widget '
          'will trim the sail."',
          style: TextStyle(
            color: compassRose,
            fontSize: 14,
            fontStyle: FontStyle.italic,
            height: 1.5,
          ),
        ),
        SizedBox(height: 12),
        recapBullet(
          'TargetPlatform is intent: design conventions, not host truth.',
        ),
        recapBullet(
          'Six values: android, fuchsia, iOS, linux, macOS, windows — Fuchsia rides with Android.',
        ),
        recapBullet(
          'iOS and macOS share the Cupertino branch in adaptive widgets.',
        ),
        recapBullet(
          'Android, Fuchsia, Linux, Windows share the Material branch.',
        ),
        recapBullet(
          'defaultTargetPlatform reads the host; Theme.of(context).platform respects overrides.',
        ),
        recapBullet(
          'Switch.adaptive, Slider.adaptive, Icon.adaptive_arrow_back, '
          'CircularProgressIndicator.adaptive — let them branch for you.',
        ),
        recapBullet(
          'On this run: defaultTargetPlatform = ${liveDefault.name}, theme platform = ${liveTheme.name}.',
        ),
        SizedBox(height: 8),
        Text(
          '— end of atlas —',
          style: TextStyle(
            color: brassGleam,
            fontSize: 11,
            letterSpacing: 4,
          ),
        ),
      ],
    ),
  );

  print('[Compass Obsidian] all sections assembled.');
  print('[Compass Obsidian] returning frozen widget tree...');

  // ===========================================================================
  // FINAL ASSEMBLY
  // ===========================================================================
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: obsidianBase,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            titleBanner,
            proseAnatomy,
            propertyAnatomy,
            gallerySection,
            matrixSection,
            comparisonSection,
            timelineSection,
            liveReadoutSection,
            calloutsSection,
            snippetsSection,
            glossarySection,
            recapFooter,
          ],
        ),
      ),
    ),
  );
}
