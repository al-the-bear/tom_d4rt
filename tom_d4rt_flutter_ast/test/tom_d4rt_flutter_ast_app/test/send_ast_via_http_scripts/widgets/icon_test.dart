// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// =============================================================================
//  GLYPH LAPIS  ::  An Illuminated Codex of Icon
// =============================================================================
//
//  THEME
//  -----
//  "Glyph Lapis" is the visual language of the medieval scriptorium reborn for
//  the digital page. Imagine a vellum sheet stretched on an oak frame, lit by
//  the slanted northern light of a monastery window. The scribe dips a quill
//  into lapis-lazuli ink ground from Afghan stone, and beside the ink-pot rests
//  a small horn dish of egg-tempera mixed with leaf gold. Every glyph in the
//  margin is at once a letter and a tiny painted picture: a saint's halo, a
//  beast's flank, a tree of life. In Flutter, the Icon widget plays the same
//  double role. It is a glyph from a font, addressable by codepoint, but it is
//  also a painted ornament that carries semantic and aesthetic weight.
//
//  This codex paints the Icon widget in lapis blue and gold. Its sections are
//  the chapters of an illuminator's manual: the anatomy of a glyph, the
//  instruments (size, weight, grade, fill, optical-size, opacity, shadow),
//  the catalog (thirty-plus illustrative glyphs), the catechism (do/avoid
//  rules), and the colophon (semantic accessibility).
//
//  SUBJECT
//  -------
//  package:flutter/widgets.dart  ::  class Icon
//  re-exported by:               ::  package:flutter/material.dart
//
//  Icon is a stateless widget that paints a single glyph from an icon font.
//  It accepts an IconData (codepoint + font family + match-text-direction
//  flag) and modifies that glyph's appearance via:
//
//      icon              :: required IconData (the glyph to paint)
//      size              :: edge length of the square box (logical px)
//      color             :: foreground tint applied to the rasterized glyph
//      semanticLabel     :: text exposed to screen readers via Semantics()
//      textDirection     :: how the glyph mirrors when matchTextDirection
//                            is true on the IconData (e.g. directional arrows)
//      fill              :: 0.0 -> 1.0, only for variable-font icons; how
//                            "filled" the silhouette is (0.0 outline -> 1.0 solid)
//      weight            :: 100 -> 700, stroke weight of variable fonts
//      grade             :: -50 -> 200, fine adjustment to ink heaviness without
//                            changing icon footprint
//      opticalSize       :: 20, 24, 40, 48; tells variable-font renderer which
//                            optical size to favor (small icons need thicker stroke)
//      shadows           :: list of Shadow objects for drop-shadow / glow
//      applyTextScaling  :: bool; when true, MediaQuery.textScaleFactor scales
//                            the icon's effective size (default false)
//
//  IconData itself is a small value class:
//
//      IconData(int codePoint, {String? fontFamily, String? fontPackage,
//               bool matchTextDirection = false, List<String>? fontFamilyFallback})
//
//  ICONS.* CONSTANTS
//  -----------------
//  The static class Icons (in package:flutter/material/icons.dart) is a giant
//  registry of pre-baked IconData entries for the Material Icons font. Every
//  Icons.* identifier expands to something like:
//      static const IconData home = IconData(0xe88a, fontFamily: 'MaterialIcons');
//  This file enumerates more than thirty such constants, alongside three
//  hand-built IconData values to demonstrate that Icons.* is not magical: any
//  font with a known glyph table can drive Icon.
//
//  ICON vs IMAGEICON
//  -----------------
//  Two cousins share the family name. Icon paints a glyph from a font, so it
//  inherits the font's hinting, optical sizing, and color treatment. ImageIcon
//  paints an ImageProvider (PNG, SVG via flutter_svg) at IconTheme size and
//  color. Icons rendered from fonts scale with crisp vector outlines and obey
//  variable-font axes. Image icons rasterize at a fixed source resolution and
//  must be tinted via blend mode. Use Icon for symbolic glyphs that need to
//  feel native to the design system; reach for ImageIcon for brand marks,
//  logos, and bespoke illustrations that never make sense as a font glyph.
//
//  SECTIONS (twelve chapters in this codex)
//  ----------------------------------------
//   1. Title illumination - lapis title bar with gold leaf border.
//   2. Anatomy of a glyph - prose paragraphs and labelled property table.
//   3. Glyph catalog - thirty Icons.* constants displayed as illuminated tiles.
//   4. Hand-built IconData - three IconData values constructed by codepoint.
//   5. Size sweep - the same glyph at 12, 18, 24, 32, 48, 72 logical pixels.
//   6. Color ribbon - one glyph in twelve named lapis-and-gold tints.
//   7. Variable-font axes - fill, weight, grade, optical-size in 4x4 grids.
//   8. Shadow demos - drop shadow, double shadow, lapis halo, gold glow.
//   9. Glyph in context - icon as chip leading, avatar child, button leading.
//  10. Semantic label inspector - same glyph with three semantic personae.
//  11. Catechism cards - eight "do this / avoid that" rules.
//  12. Colophon - a closing scribe's note on accessibility and theming.
//
//  D4RT RULES OBSERVED HERE
//  ------------------------
//   * build(BuildContext) is invoked exactly once; widget tree is frozen.
//   * No StatefulWidget, no AnimationController, no ScrollController, no
//     TextEditingController, no async, no Stream, no Future.
//   * No `for-in` loops over BridgedInstance values - indexed `for (int i ...)`
//     loops only.
//   * No `.value` reads on Tween.animate(...) results (the script never
//     constructs an Animation in the first place).
//   * Color opacity is expressed as `Color.withValues(alpha: x)` rather than
//     the deprecated `withOpacity`.
//   * print(...) calls narrate the script for debugging.
//
//  ATTRIBUTION
//  -----------
//  "Glyph Lapis" is a fictional teaching aesthetic invented for this codex,
//  borrowing from the Lindisfarne Gospels, the Book of Kells, and the Très
//  Riches Heures du Duc de Berry. The scribe-prose voice is deliberate: it
//  asks the reader to slow down and treat the icon as an illuminated letter
//  rather than a throwaway decoration.
// =============================================================================

import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------
// PALETTE :: Glyph Lapis
//
// The palette has fourteen named tones, each chosen to evoke a pigment used in
// medieval manuscript illumination. Lapis ultramarine is the cornerstone; gold
// leaf is the accent; vellum is the background; iron-gall ink and rubricator
// red round out the typography.
// -----------------------------------------------------------------------------
const Color lapisIvory       = Color(0xFFF4ECD8); // unbleached vellum
const Color lapisParchment   = Color(0xFFE8DCB8); // aged parchment
const Color lapisRubric      = Color(0xFFB23A38); // rubricator red
const Color lapisIngot       = Color(0xFFC9A227); // burnished gold leaf
const Color lapisGoldHaze    = Color(0xFFE2C46A); // pale gold wash
const Color lapisInk         = Color(0xFF1D2A4A); // deep lapis ink
const Color lapisDeep        = Color(0xFF233567); // royal lapis
const Color lapisMid         = Color(0xFF35539B); // mid lapis pigment
const Color lapisAzure       = Color(0xFF4A78C8); // bright sky lapis
const Color lapisSky         = Color(0xFF7AA0DC); // pale lapis sky
const Color lapisVerdigris   = Color(0xFF497F6E); // copper verdigris
const Color lapisOlive       = Color(0xFF6B6B33); // earth-pigment olive
const Color lapisCharcoal    = Color(0xFF2A2826); // iron-gall ink
const Color lapisSlate       = Color(0xFF6F6E62); // muted scribe slate

// -----------------------------------------------------------------------------
// TYPOGRAPHY HELPERS
//
// The codex uses three text styles: a display title, a body paragraph, and a
// monospaced caption for property names. The medieval analogue would be
// majuscule, minuscule, and uncial scripts respectively.
// -----------------------------------------------------------------------------
TextStyle _displayStyle(double size, Color color) => TextStyle(
      fontSize: size,
      fontWeight: FontWeight.w800,
      color: color,
      letterSpacing: 0.6,
      height: 1.15,
    );

TextStyle _titleStyle(double size, Color color) => TextStyle(
      fontSize: size,
      fontWeight: FontWeight.w700,
      color: color,
      letterSpacing: 0.3,
      height: 1.2,
    );

TextStyle _bodyStyle(Color color, {double size = 13, FontWeight w = FontWeight.w400}) =>
    TextStyle(fontSize: size, color: color, fontWeight: w, height: 1.5);

TextStyle _captionStyle(Color color, {double size = 11}) => TextStyle(
      fontSize: size,
      color: color,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.4,
      height: 1.3,
    );

TextStyle _monoStyle(Color color, {double size = 11}) => TextStyle(
      fontFamily: 'monospace',
      fontSize: size,
      color: color,
      height: 1.4,
    );

// -----------------------------------------------------------------------------
// SURFACE DECORATIONS
//
// Two reusable BoxDecorations. _vellumSurface mimics aged parchment with a
// faint gold border. _lapisSurface is the inverse: deep lapis ground with a
// gold-leaf rule.
// -----------------------------------------------------------------------------
BoxDecoration _vellumSurface() => BoxDecoration(
      color: lapisIvory,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: lapisIngot.withValues(alpha: 0.55), width: 1.0),
    );

BoxDecoration _lapisSurface() => BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [lapisInk, lapisDeep, lapisMid],
      ),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: lapisIngot.withValues(alpha: 0.7), width: 1.2),
    );

BoxDecoration _goldFrame() => BoxDecoration(
      color: lapisIvory,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: lapisIngot, width: 1.4),
    );

// -----------------------------------------------------------------------------
// SMALL UI HELPERS
// -----------------------------------------------------------------------------
Widget _swatch(String name, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(4),
      border: Border.all(color: lapisInk.withValues(alpha: 0.35)),
    ),
    child: Text(
      name,
      style: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w600,
        color: ThemeData.estimateBrightnessForColor(color) == Brightness.dark
            ? lapisIvory
            : lapisInk,
      ),
    ),
  );
}

Widget _verticalGap(double h) => SizedBox(height: h);
Widget _horizontalGap(double w) => SizedBox(width: w);

Widget _propRow(String name, String value, {Color? accent}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 130,
          child: Text(
            name,
            style: _monoStyle(accent ?? lapisInk, size: 11),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: _bodyStyle(lapisCharcoal, size: 12),
          ),
        ),
      ],
    ),
  );
}

Widget _glyphTile({
  required IconData glyph,
  required String label,
  required String codepointHex,
  Color? accent,
}) {
  final Color tone = accent ?? lapisInk;
  return Container(
    width: 124,
    height: 120,
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: lapisIvory,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: lapisIngot.withValues(alpha: 0.6)),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Icon(glyph, size: 36, color: tone),
        ),
        Text(label, style: _captionStyle(lapisInk, size: 11), maxLines: 1, overflow: TextOverflow.ellipsis),
        Text(codepointHex, style: _monoStyle(lapisSlate, size: 9)),
      ],
    ),
  );
}

Widget _proseCard({required String title, required List<String> paragraphs}) {
  final List<Widget> children = <Widget>[];
  children.add(Text(title, style: _titleStyle(15, lapisInk)));
  children.add(_verticalGap(8));
  for (int i = 0; i < paragraphs.length; i++) {
    children.add(Text(paragraphs[i], style: _bodyStyle(lapisCharcoal, size: 12)));
    if (i < paragraphs.length - 1) {
      children.add(_verticalGap(8));
    }
  }
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: _vellumSurface(),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: children),
  );
}

// =============================================================================
// build(BuildContext)
//
// The single entry point. Every widget below is constructed once, returned in
// one frozen tree, and rendered by the D4rt host. There is no state, no
// listener, no controller, no async work in the tree.
// =============================================================================
dynamic build(BuildContext context) {
  print('================================================================');
  print('Glyph Lapis  ::  An Illuminated Codex of Icon');
  print('================================================================');
  print('Opening the codex on a vellum desk...');
  print('Reaching for the lapis-lazuli ink-pot and the gold-leaf horn dish.');

  // ---------------------------------------------------------------------------
  // CHAPTER 0 :: BUILDING THE GLYPH CATALOG
  //
  // We collect thirty IconData constants from package:flutter/material.dart's
  // Icons class. Each entry is paired with a human label and the codepoint as
  // hex - because IconData IS, fundamentally, an int wrapped in a font family.
  //
  // The codepoint hex is documentation: in a real production app you would
  // never write 0xe88a yourself, you would write Icons.home. But for a teaching
  // file the codepoint reminds the reader that the icon font is just a font.
  // ---------------------------------------------------------------------------
  print('Cataloging thirty illuminative glyphs from the Material font...');

  final List<IconData> catalogGlyphs = <IconData>[
    Icons.home,
    Icons.star,
    Icons.beach_access,
    Icons.lightbulb,
    Icons.book,
    Icons.menu_book,
    Icons.auto_stories,
    Icons.brush,
    Icons.palette,
    Icons.edit,
    Icons.create,
    Icons.draw,
    Icons.format_paint,
    Icons.color_lens,
    Icons.spa,
    Icons.local_florist,
    Icons.park,
    Icons.eco,
    Icons.nature_people,
    Icons.cottage,
    Icons.castle,
    Icons.church,
    Icons.temple_buddhist,
    Icons.account_balance,
    Icons.museum,
    Icons.theater_comedy,
    Icons.celebration,
    Icons.cake,
    Icons.coffee,
    Icons.wine_bar,
    Icons.restaurant_menu,
    Icons.local_dining,
  ];

  final List<String> catalogLabels = <String>[
    'home',
    'star',
    'beach_access',
    'lightbulb',
    'book',
    'menu_book',
    'auto_stories',
    'brush',
    'palette',
    'edit',
    'create',
    'draw',
    'format_paint',
    'color_lens',
    'spa',
    'local_florist',
    'park',
    'eco',
    'nature_people',
    'cottage',
    'castle',
    'church',
    'temple_buddhist',
    'account_balance',
    'museum',
    'theater_comedy',
    'celebration',
    'cake',
    'coffee',
    'wine_bar',
    'restaurant_menu',
    'local_dining',
  ];

  final List<String> catalogHex = <String>[
    '0xe88a', '0xe838', '0xeb3e', '0xe0f0', '0xe865',
    '0xea19', '0xe53b', '0xe3ae', '0xe40a', '0xe3c9',
    '0xe150', '0xebd0', '0xe43e', '0xe3b7', '0xe7b1',
    '0xe54e', '0xea63', '0xe63f', '0xe6b8', '0xe587',
    '0xeae7', '0xea05', '0xeaaf', '0xe84f', '0xea36',
    '0xea66', '0xea65', '0xe7e9', '0xefef', '0xf1e8',
    '0xe56c', '0xe556',
  ];

  print('Catalog assembled - ${catalogGlyphs.length} glyphs ready for illumination.');
  print('First glyph:  Icons.home  -> codepoint ${catalogHex[0]}');
  print('Last glyph:   Icons.local_dining  -> codepoint ${catalogHex[catalogHex.length - 1]}');

  // ---------------------------------------------------------------------------
  // HAND-BUILT ICONDATA :: The scribe forges three glyphs from raw codepoints.
  //
  // Icons.* is convenience. Underneath it is IconData(0xe88a, fontFamily: ...).
  // Below we build three IconData by hand to teach that contract.
  // ---------------------------------------------------------------------------
  print('Constructing three hand-built IconData values from raw codepoints...');

  final IconData manualHome = IconData(0xe88a, fontFamily: 'MaterialIcons');
  final IconData manualStar = IconData(0xe838, fontFamily: 'MaterialIcons');
  final IconData manualArrow = IconData(
    0xe5c8,
    fontFamily: 'MaterialIcons',
    matchTextDirection: true,
  );

  print('  manualHome  :: codePoint = ${manualHome.codePoint.toRadixString(16)}');
  print('  manualStar  :: codePoint = ${manualStar.codePoint.toRadixString(16)}');
  print('  manualArrow :: codePoint = ${manualArrow.codePoint.toRadixString(16)} '
      '(matchTextDirection = ${manualArrow.matchTextDirection})');

  // ===========================================================================
  // SECTION 1 :: TITLE ILLUMINATION
  // ===========================================================================
  print('Section 1 :: gilding the title cartouche.');
  final Widget section1 = Container(
    padding: const EdgeInsets.all(22),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [lapisInk, lapisDeep, lapisMid, lapisAzure],
      ),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: lapisIngot, width: 1.6),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.auto_stories, color: lapisIngot, size: 40),
            _horizontalGap(14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('GLYPH  LAPIS', style: _displayStyle(26, lapisIvory)),
                  _verticalGap(4),
                  Text(
                    'An illuminated codex of the Icon widget',
                    style: _bodyStyle(lapisGoldHaze, size: 14, w: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Icon(Icons.menu_book, color: lapisIngot, size: 40),
          ],
        ),
        _verticalGap(14),
        Text(
          'package:flutter/widgets.dart  ::  class Icon',
          style: _monoStyle(lapisSky, size: 12),
        ),
        _verticalGap(2),
        Text(
          'Re-exported by package:flutter/material.dart',
          style: _monoStyle(lapisSky.withValues(alpha: 0.85), size: 11),
        ),
        _verticalGap(14),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: [
            _swatch('ivory', lapisIvory),
            _swatch('parchment', lapisParchment),
            _swatch('rubric', lapisRubric),
            _swatch('ingot', lapisIngot),
            _swatch('gold haze', lapisGoldHaze),
            _swatch('ink', lapisInk),
            _swatch('deep', lapisDeep),
            _swatch('mid', lapisMid),
            _swatch('azure', lapisAzure),
            _swatch('sky', lapisSky),
            _swatch('verdigris', lapisVerdigris),
            _swatch('olive', lapisOlive),
            _swatch('charcoal', lapisCharcoal),
            _swatch('slate', lapisSlate),
          ],
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 2 :: ANATOMY OF A GLYPH
  //
  // Prose paragraphs, then a property table mapping each Icon constructor
  // argument to a one-sentence definition. Property table doubles as a quick
  // reference for the rest of the codex.
  // ===========================================================================
  print('Section 2 :: writing the anatomy of a glyph.');

  final Widget section2Prose = _proseCard(
    title: 'Anatomy :: a glyph is a codepoint with character',
    paragraphs: const [
      'In an icon font every symbol lives at a precise codepoint - a small '
          'integer in the Private Use Area of Unicode, U+E000 through U+F8FF. '
          'The Material Icons font, for example, places the home glyph at '
          'U+E88A. The class Icons in package:flutter/material/icons.dart is a '
          'static registry that turns Icons.home into IconData(0xe88a, '
          'fontFamily: MaterialIcons).',
      'IconData itself is the value class. It records the codepoint, the font '
          'family, an optional font package, an optional matchTextDirection '
          'flag, and an optional fontFamilyFallback list. IconData has no '
          'visual presence on its own; it is a request, not a painting.',
      'Icon is the widget that paints the request. It reads the ambient '
          'IconTheme to recover defaults for size, color, fill, weight, grade, '
          'and optical-size, then overrides any of those with constructor '
          'arguments. The result is a square box of edge length size, painted '
          'with the rasterized glyph in the chosen color, possibly with shadows '
          'and possibly with a Semantics() wrapper for screen readers.',
      'When the IconData has matchTextDirection = true, Icon mirrors the glyph '
          'horizontally inside an RTL Directionality. This is how arrow_back '
          'becomes arrow_forward in Arabic and Hebrew layouts without the '
          'application code having to swap which constant to draw.',
    ],
  );

  final Widget section2Table = Container(
    padding: const EdgeInsets.all(14),
    decoration: _vellumSurface(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Property dictionary', style: _titleStyle(15, lapisInk)),
        _verticalGap(6),
        Text(
          'Each row maps one Icon constructor argument to its purpose.',
          style: _bodyStyle(lapisSlate, size: 11),
        ),
        _verticalGap(10),
        _propRow('icon', 'IconData (required) - the glyph to paint.'),
        _propRow('size', 'double, edge length of square box; defaults to 24.'),
        _propRow('color', 'Color, foreground tint; defaults to IconTheme.color.'),
        _propRow('semanticLabel', 'String, screen-reader label; null = no Semantics().'),
        _propRow('textDirection', 'TextDirection, used when IconData.matchTextDirection.'),
        _propRow('fill', 'double 0.0-1.0, variable-font outline-to-solid axis.'),
        _propRow('weight', 'double 100-700, variable-font stroke heaviness.'),
        _propRow('grade', 'double -50-200, fine ink-weight tweak without footprint change.'),
        _propRow('opticalSize', 'double 20/24/40/48, axis hint for optical size.'),
        _propRow('shadows', 'List<Shadow>, drop-shadows / glows under the glyph.'),
        _propRow('applyTextScaling', 'bool, scale size by MediaQuery.textScaleFactor.'),
      ],
    ),
  );

  final Widget section2 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      section2Prose,
      _verticalGap(10),
      section2Table,
    ],
  );

  // ===========================================================================
  // SECTION 3 :: GLYPH CATALOG (32 ILLUMINATIVE TILES)
  //
  // The catalog is the heart of the codex. It draws thirty-plus Icons.*
  // constants in equal-sized vellum tiles, each with the codepoint hex below.
  // We use indexed for-loops only - no for-in over the BridgedInstance list.
  // ===========================================================================
  print('Section 3 :: laying out the thirty-glyph catalog grid.');
  final List<Widget> tileWidgets = <Widget>[];
  for (int i = 0; i < catalogGlyphs.length; i++) {
    final IconData g = catalogGlyphs[i];
    final String label = catalogLabels[i];
    final String hex = catalogHex[i];
    // Cycle accent color across the catalog so the page feels illuminated,
    // not monotonous. Lapis ink, royal lapis, mid lapis, verdigris, rubric,
    // and ingot rotate.
    final Color accent;
    final int mod = i % 6;
    if (mod == 0) {
      accent = lapisInk;
    } else if (mod == 1) {
      accent = lapisDeep;
    } else if (mod == 2) {
      accent = lapisMid;
    } else if (mod == 3) {
      accent = lapisVerdigris;
    } else if (mod == 4) {
      accent = lapisRubric;
    } else {
      accent = lapisIngot;
    }
    tileWidgets.add(_glyphTile(glyph: g, label: label, codepointHex: hex, accent: accent));
  }

  final Widget section3 = Container(
    padding: const EdgeInsets.all(16),
    decoration: _lapisSurface(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.grid_view, color: lapisIngot, size: 22),
            _horizontalGap(8),
            Text('Catalog of illuminative glyphs',
                style: _titleStyle(16, lapisIvory)),
          ],
        ),
        _verticalGap(4),
        Text(
          'Thirty-two Icons.* constants, each shown as glyph + label + codepoint.',
          style: _bodyStyle(lapisSky, size: 12),
        ),
        _verticalGap(12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: tileWidgets,
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 4 :: HAND-BUILT ICONDATA
  //
  // Three IconData built by codepoint. The scribe demonstrates that Icons.* is
  // syntactic sugar over a tiny constructor.
  // ===========================================================================
  print('Section 4 :: minting three IconData instances from raw codepoints.');

  Widget manualPanel({
    required String title,
    required IconData glyph,
    required String codeSnippet,
    required String prose,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: _vellumSurface(),
      width: 280,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(glyph, color: lapisInk, size: 38),
              _horizontalGap(10),
              Expanded(child: Text(title, style: _titleStyle(13, lapisInk))),
            ],
          ),
          _verticalGap(8),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: lapisCharcoal.withValues(alpha: 0.9),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(codeSnippet, style: _monoStyle(lapisGoldHaze, size: 11)),
          ),
          _verticalGap(8),
          Text(prose, style: _bodyStyle(lapisCharcoal, size: 11)),
        ],
      ),
    );
  }

  final Widget section4 = Container(
    padding: const EdgeInsets.all(14),
    decoration: _goldFrame(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Hand-built IconData :: three glyphs forged at the bench',
            style: _titleStyle(15, lapisInk)),
        _verticalGap(6),
        Text(
          'Each panel constructs IconData(...) directly and renders it. '
          'Icons.* is a registry; this is what the registry wraps.',
          style: _bodyStyle(lapisSlate, size: 11),
        ),
        _verticalGap(12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            manualPanel(
              title: 'manualHome',
              glyph: manualHome,
              codeSnippet: 'IconData(0xe88a,\n  fontFamily: \'MaterialIcons\')',
              prose:
                  'The same pixels as Icons.home, but constructed at the call '
                  'site. Useful when an icon font ships outside the Material '
                  'set and must be referenced by raw codepoint.',
            ),
            manualPanel(
              title: 'manualStar',
              glyph: manualStar,
              codeSnippet: 'IconData(0xe838,\n  fontFamily: \'MaterialIcons\')',
              prose:
                  'Twin to Icons.star. When you ship a custom font, you will '
                  'write codepoints exactly like this in a generated dart file.',
            ),
            manualPanel(
              title: 'manualArrow',
              glyph: manualArrow,
              codeSnippet:
                  'IconData(0xe5c8,\n  fontFamily: \'MaterialIcons\',\n  matchTextDirection: true)',
              prose:
                  'arrow_forward, mirrored automatically under RTL. Set '
                  'matchTextDirection: true to opt in - it is FALSE by default '
                  'because most glyphs (e.g. star, home) should never mirror.',
            ),
          ],
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 5 :: SIZE SWEEP
  //
  // The same glyph (Icons.auto_stories) at six logical sizes. We label each
  // sample with its size in points and place a vertical baseline so the reader
  // can see how the glyph scales relative to a fixed gutter.
  // ===========================================================================
  print('Section 5 :: sweeping the size axis from 12 to 72 logical pixels.');

  final List<double> sizeSamples = <double>[12.0, 18.0, 24.0, 32.0, 48.0, 72.0];
  final List<String> sizeLabels = <String>['12', '18', '24', '32', '48', '72'];
  final List<Widget> sizeColumns = <Widget>[];
  for (int i = 0; i < sizeSamples.length; i++) {
    final double s = sizeSamples[i];
    final String l = sizeLabels[i];
    sizeColumns.add(Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: lapisIvory,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: lapisIngot.withValues(alpha: 0.5)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 80,
            width: 80,
            child: Center(
              child: Icon(Icons.auto_stories, size: s, color: lapisDeep),
            ),
          ),
          _verticalGap(6),
          Text('$l px', style: _monoStyle(lapisInk, size: 11)),
        ],
      ),
    ));
  }

  final Widget section5 = Container(
    padding: const EdgeInsets.all(16),
    decoration: _vellumSurface(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Size sweep :: 12 -> 72 logical pixels',
            style: _titleStyle(15, lapisInk)),
        _verticalGap(4),
        Text(
          'A glyph is a vector outline. It scales without resampling, but the '
          'optical-size axis (see section 7) lets variable fonts adjust the '
          'stroke for legibility at small sizes.',
          style: _bodyStyle(lapisCharcoal, size: 12),
        ),
        _verticalGap(12),
        Wrap(spacing: 10, runSpacing: 10, children: sizeColumns),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 6 :: COLOR RIBBON
  //
  // The same glyph (Icons.lightbulb) painted in twelve named tints from the
  // Glyph Lapis palette. Each sample shows the tone name underneath.
  // ===========================================================================
  print('Section 6 :: painting the color ribbon in twelve lapis-and-gold tints.');

  final List<Color> ribbonColors = <Color>[
    lapisInk,
    lapisDeep,
    lapisMid,
    lapisAzure,
    lapisSky,
    lapisVerdigris,
    lapisOlive,
    lapisRubric,
    lapisIngot,
    lapisGoldHaze,
    lapisCharcoal,
    lapisSlate,
  ];
  final List<String> ribbonNames = <String>[
    'ink', 'deep', 'mid', 'azure', 'sky', 'verdigris',
    'olive', 'rubric', 'ingot', 'gold haze', 'charcoal', 'slate',
  ];
  final List<Widget> ribbonTiles = <Widget>[];
  for (int i = 0; i < ribbonColors.length; i++) {
    ribbonTiles.add(Container(
      width: 86,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
      decoration: BoxDecoration(
        color: lapisIvory,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: ribbonColors[i].withValues(alpha: 0.7)),
      ),
      child: Column(
        children: [
          Icon(Icons.lightbulb, size: 36, color: ribbonColors[i]),
          _verticalGap(6),
          Text(ribbonNames[i], style: _captionStyle(lapisInk, size: 10)),
        ],
      ),
    ));
  }

  final Widget section6 = Container(
    padding: const EdgeInsets.all(16),
    decoration: _lapisSurface(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Color ribbon :: a single lightbulb in twelve pigments',
            style: _titleStyle(15, lapisIvory)),
        _verticalGap(4),
        Text(
          'Color is multiplied into the glyph as a tint. The glyph itself is '
          'opaque alpha; color paints the pixels that survive the alpha test.',
          style: _bodyStyle(lapisSky, size: 12),
        ),
        _verticalGap(12),
        Wrap(spacing: 8, runSpacing: 8, children: ribbonTiles),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 7 :: VARIABLE-FONT AXES
  //
  // Four 4x4 grids: fill, weight, grade, optical-size. Each grid sweeps the
  // axis across four representative values while holding the others at default.
  // The Material Symbols variable font supports all four axes; the Material
  // Icons font (used here) supports a subset, but the API is identical.
  // ===========================================================================
  print('Section 7 :: walking the variable-font axes (fill / weight / grade / opticalSize).');

  Widget axisCell(String label, IconData glyph,
      {double? fill, double? weight, double? grade, double? opticalSize}) {
    return Container(
      width: 90,
      height: 100,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: lapisIvory,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: lapisIngot.withValues(alpha: 0.55)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Center(
            child: Icon(
              glyph,
              size: 38,
              color: lapisDeep,
              fill: fill,
              weight: weight,
              grade: grade,
              opticalSize: opticalSize,
            ),
          ),
          Text(label, style: _monoStyle(lapisInk, size: 10)),
        ],
      ),
    );
  }

  // ----- fill axis (0.0 outline -> 1.0 solid) -----
  final List<Widget> fillCells = <Widget>[
    axisCell('fill 0.0', Icons.favorite, fill: 0.0),
    axisCell('fill 0.33', Icons.favorite, fill: 0.33),
    axisCell('fill 0.66', Icons.favorite, fill: 0.66),
    axisCell('fill 1.0', Icons.favorite, fill: 1.0),
  ];

  // ----- weight axis (100 thin -> 700 bold) -----
  final List<Widget> weightCells = <Widget>[
    axisCell('weight 100', Icons.star, weight: 100.0),
    axisCell('weight 300', Icons.star, weight: 300.0),
    axisCell('weight 500', Icons.star, weight: 500.0),
    axisCell('weight 700', Icons.star, weight: 700.0),
  ];

  // ----- grade axis (-50 lighter -> 200 heavier) -----
  final List<Widget> gradeCells = <Widget>[
    axisCell('grade -25', Icons.book, grade: -25.0),
    axisCell('grade 0', Icons.book, grade: 0.0),
    axisCell('grade 100', Icons.book, grade: 100.0),
    axisCell('grade 200', Icons.book, grade: 200.0),
  ];

  // ----- opticalSize axis (20 small -> 48 large) -----
  final List<Widget> opticalCells = <Widget>[
    axisCell('os 20', Icons.brush, opticalSize: 20.0),
    axisCell('os 24', Icons.brush, opticalSize: 24.0),
    axisCell('os 40', Icons.brush, opticalSize: 40.0),
    axisCell('os 48', Icons.brush, opticalSize: 48.0),
  ];

  Widget axisRow(String title, String prose, List<Widget> cells) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: _vellumSurface(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: _titleStyle(13, lapisInk)),
          _verticalGap(4),
          Text(prose, style: _bodyStyle(lapisCharcoal, size: 11)),
          _verticalGap(10),
          Wrap(spacing: 8, runSpacing: 8, children: cells),
        ],
      ),
    );
  }

  final Widget section7 = Container(
    padding: const EdgeInsets.all(16),
    decoration: _goldFrame(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Variable-font axes :: fill / weight / grade / opticalSize',
            style: _titleStyle(15, lapisInk)),
        _verticalGap(4),
        Text(
          'Material Symbols is a variable font with four design-time axes. '
          'Icon exposes them as constructor arguments. Where the underlying '
          'font does not support an axis, the value is silently ignored - so '
          'these arguments are safe to set even if the chosen font is fixed.',
          style: _bodyStyle(lapisCharcoal, size: 12),
        ),
        _verticalGap(12),
        axisRow(
          'Fill axis :: outline (0.0) to solid (1.0)',
          'Fill morphs between the outline-only and fully-painted forms of a glyph. '
              'A common trick: fill = 0.0 for inactive items in a tab bar, fill = 1.0 '
              'for the selected one.',
          fillCells,
        ),
        _verticalGap(10),
        axisRow(
          'Weight axis :: 100 (thin) to 700 (bold)',
          'Weight is the stroke heaviness, parallel to font weight in text. '
              'Pair Icon weight with surrounding Text weight for visual harmony.',
          weightCells,
        ),
        _verticalGap(10),
        axisRow(
          'Grade axis :: -50 to 200 (fine ink-weight tweak)',
          'Grade nudges the stroke heavier or lighter without changing the '
              'icon footprint - use this when weight changes would shift adjacent layout.',
          gradeCells,
        ),
        _verticalGap(10),
        axisRow(
          'Optical size axis :: 20 / 24 / 40 / 48',
          'Optical size tells the renderer which optical-size master to favor. '
              'Small icons benefit from thicker, simpler outlines; large icons can carry detail.',
          opticalCells,
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 8 :: SHADOW DEMOS
  //
  // A glyph painted with Shadows: a soft drop shadow, a double drop shadow,
  // a lapis halo (radius 12), and a gold-leaf glow (offset zero, blur 16).
  // ===========================================================================
  print('Section 8 :: casting shadows beneath the illuminated glyphs.');

  Widget shadowCell({
    required String title,
    required IconData glyph,
    required List<Shadow> shadows,
    required String prose,
  }) {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: lapisIvory,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: lapisIngot.withValues(alpha: 0.6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: _titleStyle(12, lapisInk)),
          _verticalGap(8),
          SizedBox(
            height: 80,
            child: Center(
              child: Icon(glyph, size: 56, color: lapisDeep, shadows: shadows),
            ),
          ),
          _verticalGap(6),
          Text(prose, style: _bodyStyle(lapisCharcoal, size: 11)),
        ],
      ),
    );
  }

  final List<Shadow> dropShadow = <Shadow>[
    Shadow(
      offset: Offset(0, 2),
      blurRadius: 4,
      color: lapisCharcoal.withValues(alpha: 0.5),
    ),
  ];
  final List<Shadow> doubleDrop = <Shadow>[
    Shadow(
      offset: Offset(0, 2),
      blurRadius: 4,
      color: lapisCharcoal.withValues(alpha: 0.4),
    ),
    Shadow(
      offset: Offset(0, 6),
      blurRadius: 12,
      color: lapisInk.withValues(alpha: 0.25),
    ),
  ];
  final List<Shadow> lapisHalo = <Shadow>[
    Shadow(
      offset: Offset(0, 0),
      blurRadius: 12,
      color: lapisAzure.withValues(alpha: 0.7),
    ),
  ];
  final List<Shadow> goldGlow = <Shadow>[
    Shadow(
      offset: Offset(0, 0),
      blurRadius: 16,
      color: lapisIngot.withValues(alpha: 0.85),
    ),
  ];

  final Widget section8 = Container(
    padding: const EdgeInsets.all(16),
    decoration: _vellumSurface(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Shadow demos :: glyph as illuminated relief',
            style: _titleStyle(15, lapisInk)),
        _verticalGap(4),
        Text(
          'Icon.shadows accepts a List<Shadow>. Each Shadow has offset, '
          'blurRadius and color. Layer shadows for depth or for halo glows.',
          style: _bodyStyle(lapisCharcoal, size: 12),
        ),
        _verticalGap(12),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            shadowCell(
              title: 'Single drop shadow',
              glyph: Icons.castle,
              shadows: dropShadow,
              prose: 'Offset (0,2), blur 4, ink 50% alpha. The classic Material elevation hint.',
            ),
            shadowCell(
              title: 'Double drop shadow',
              glyph: Icons.museum,
              shadows: doubleDrop,
              prose: 'Inner crisp shadow + softer outer shadow. Mimics elevation 4dp.',
            ),
            shadowCell(
              title: 'Lapis halo',
              glyph: Icons.spa,
              shadows: lapisHalo,
              prose: 'Zero-offset, blur 12, lapis-azure tint. Used here to crown the saint of bath-salts.',
            ),
            shadowCell(
              title: 'Gold leaf glow',
              glyph: Icons.celebration,
              shadows: goldGlow,
              prose: 'Zero-offset, blur 16, gold ingot tint. Reserved in the codex for festal scenes.',
            ),
          ],
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 9 :: GLYPH IN CONTEXT
  //
  // Show the glyph in three real composite contexts: as a Chip leading icon,
  // as a CircleAvatar child, and as a TextButton.icon leading element.
  // ===========================================================================
  print('Section 9 :: placing the glyph in chip, avatar, and button contexts.');

  final Widget chipExample = Wrap(
    spacing: 8,
    runSpacing: 8,
    children: [
      Chip(
        avatar: Icon(Icons.home, size: 18, color: lapisInk),
        label: Text('home', style: _bodyStyle(lapisInk, size: 12)),
        backgroundColor: lapisIvory,
        side: BorderSide(color: lapisIngot.withValues(alpha: 0.6)),
      ),
      Chip(
        avatar: Icon(Icons.beach_access, size: 18, color: lapisDeep),
        label: Text('travel', style: _bodyStyle(lapisInk, size: 12)),
        backgroundColor: lapisParchment,
        side: BorderSide(color: lapisIngot.withValues(alpha: 0.6)),
      ),
      Chip(
        avatar: Icon(Icons.book, size: 18, color: lapisRubric),
        label: Text('reading', style: _bodyStyle(lapisInk, size: 12)),
        backgroundColor: lapisIvory,
        side: BorderSide(color: lapisIngot.withValues(alpha: 0.6)),
      ),
      Chip(
        avatar: Icon(Icons.brush, size: 18, color: lapisVerdigris),
        label: Text('art', style: _bodyStyle(lapisInk, size: 12)),
        backgroundColor: lapisParchment,
        side: BorderSide(color: lapisIngot.withValues(alpha: 0.6)),
      ),
      Chip(
        avatar: Icon(Icons.local_florist, size: 18, color: lapisOlive),
        label: Text('garden', style: _bodyStyle(lapisInk, size: 12)),
        backgroundColor: lapisIvory,
        side: BorderSide(color: lapisIngot.withValues(alpha: 0.6)),
      ),
    ],
  );

  final Widget avatarExample = Wrap(
    spacing: 12,
    runSpacing: 12,
    children: [
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 26,
            backgroundColor: lapisDeep,
            child: Icon(Icons.account_balance, color: lapisIngot, size: 28),
          ),
          _verticalGap(4),
          Text('archive', style: _captionStyle(lapisInk, size: 11)),
        ],
      ),
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 26,
            backgroundColor: lapisRubric,
            child: Icon(Icons.cake, color: lapisIvory, size: 28),
          ),
          _verticalGap(4),
          Text('feast', style: _captionStyle(lapisInk, size: 11)),
        ],
      ),
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 26,
            backgroundColor: lapisVerdigris,
            child: Icon(Icons.eco, color: lapisIvory, size: 28),
          ),
          _verticalGap(4),
          Text('vegetal', style: _captionStyle(lapisInk, size: 11)),
        ],
      ),
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 26,
            backgroundColor: lapisIngot,
            child: Icon(Icons.star, color: lapisInk, size: 28),
          ),
          _verticalGap(4),
          Text('haloed', style: _captionStyle(lapisInk, size: 11)),
        ],
      ),
    ],
  );

  final Widget buttonExample = Wrap(
    spacing: 8,
    runSpacing: 8,
    children: [
      OutlinedButton.icon(
        onPressed: () {},
        icon: Icon(Icons.menu_book, size: 18, color: lapisInk),
        label: Text('Read codex', style: _bodyStyle(lapisInk, size: 12)),
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: lapisIngot.withValues(alpha: 0.7)),
        ),
      ),
      OutlinedButton.icon(
        onPressed: () {},
        icon: Icon(Icons.draw, size: 18, color: lapisDeep),
        label: Text('Annotate', style: _bodyStyle(lapisInk, size: 12)),
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: lapisIngot.withValues(alpha: 0.7)),
        ),
      ),
      OutlinedButton.icon(
        onPressed: () {},
        icon: Icon(Icons.format_paint, size: 18, color: lapisVerdigris),
        label: Text('Illuminate', style: _bodyStyle(lapisInk, size: 12)),
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: lapisIngot.withValues(alpha: 0.7)),
        ),
      ),
      OutlinedButton.icon(
        onPressed: () {},
        icon: Icon(Icons.color_lens, size: 18, color: lapisRubric),
        label: Text('Colour', style: _bodyStyle(lapisInk, size: 12)),
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: lapisIngot.withValues(alpha: 0.7)),
        ),
      ),
    ],
  );

  final Widget section9 = Container(
    padding: const EdgeInsets.all(16),
    decoration: _vellumSurface(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Glyph in context :: chip, avatar, button',
            style: _titleStyle(15, lapisInk)),
        _verticalGap(4),
        Text(
          'Icon is rarely the leaf in production trees. It nests inside Chip, '
          'CircleAvatar, IconButton, ListTile leading, and TextButton.icon. '
          'Each parent supplies its own size and color defaults via IconTheme.',
          style: _bodyStyle(lapisCharcoal, size: 12),
        ),
        _verticalGap(12),
        Text('As Chip avatar', style: _titleStyle(13, lapisInk)),
        _verticalGap(6),
        chipExample,
        _verticalGap(14),
        Text('As CircleAvatar child', style: _titleStyle(13, lapisInk)),
        _verticalGap(6),
        avatarExample,
        _verticalGap(14),
        Text('As OutlinedButton.icon leading', style: _titleStyle(13, lapisInk)),
        _verticalGap(6),
        buttonExample,
      ],
    ),
  );

  // ===========================================================================
  // SECTION 10 :: SEMANTIC LABEL INSPECTOR
  //
  // The same glyph, three different semantic labels, three different
  // assistive readings. Demonstrates that visual form is decoupled from the
  // accessibility name.
  // ===========================================================================
  print('Section 10 :: inspecting semantic personae of one glyph.');

  Widget semanticPanel({
    required IconData glyph,
    required String label,
    required String reading,
    required Color accent,
  }) {
    return Container(
      width: 220,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: lapisIvory,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: accent.withValues(alpha: 0.6), width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Icon(glyph, size: 44, color: accent, semanticLabel: label),
          ),
          _verticalGap(8),
          Row(
            children: [
              Icon(Icons.label, size: 14, color: accent),
              _horizontalGap(4),
              Expanded(
                child: Text('semanticLabel: "$label"',
                    style: _monoStyle(accent, size: 10)),
              ),
            ],
          ),
          _verticalGap(6),
          Text('Reads as: "$reading"', style: _bodyStyle(lapisCharcoal, size: 11)),
        ],
      ),
    );
  }

  final Widget section10 = Container(
    padding: const EdgeInsets.all(16),
    decoration: _vellumSurface(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Semantic label inspector :: one glyph, three readings',
            style: _titleStyle(15, lapisInk)),
        _verticalGap(4),
        Text(
          'A star is a star until you tell the screen reader otherwise. '
          'semanticLabel determines the accessibility name without changing pixels.',
          style: _bodyStyle(lapisCharcoal, size: 12),
        ),
        _verticalGap(12),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            semanticPanel(
              glyph: Icons.star,
              label: 'Favorite',
              reading: 'button, Favorite',
              accent: lapisDeep,
            ),
            semanticPanel(
              glyph: Icons.star,
              label: 'Saved item',
              reading: 'button, Saved item',
              accent: lapisVerdigris,
            ),
            semanticPanel(
              glyph: Icons.star,
              label: 'Five star rating',
              reading: 'button, Five star rating',
              accent: lapisRubric,
            ),
          ],
        ),
        _verticalGap(12),
        Text(
          'Note: a null semanticLabel means Icon does NOT wrap itself in a '
          'Semantics() node. That is correct for purely-decorative glyphs '
          'whose meaning is already carried by adjacent text.',
          style: _bodyStyle(lapisSlate, size: 11),
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 11 :: CATECHISM CARDS
  //
  // Eight do/avoid rules for icon use. Each card is a vellum panel with a
  // green/red icon at the corner.
  // ===========================================================================
  print('Section 11 :: inscribing the catechism of do and avoid.');

  Widget ruleCard(bool isDo, String title, String body) {
    final IconData mark = isDo ? Icons.check_circle : Icons.cancel;
    final Color tone = isDo ? lapisVerdigris : lapisRubric;
    return Container(
      width: 280,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: lapisIvory,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: tone.withValues(alpha: 0.6), width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(mark, color: tone, size: 20),
              _horizontalGap(8),
              Expanded(child: Text(title, style: _titleStyle(12, lapisInk))),
            ],
          ),
          _verticalGap(8),
          Text(body, style: _bodyStyle(lapisCharcoal, size: 11)),
        ],
      ),
    );
  }

  final Widget section11 = Container(
    padding: const EdgeInsets.all(16),
    decoration: _goldFrame(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Catechism :: eight rules for Icon use',
            style: _titleStyle(15, lapisInk)),
        _verticalGap(10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            ruleCard(true,
                'Pair an icon with a label when meaning is non-obvious',
                'A wrench glyph alone may mean "settings", "repair", or "developer mode". A label removes the guesswork.'),
            ruleCard(false,
                'Avoid using Icon to render brand logos',
                'Logos should be ImageIcon or AssetImage. Brand color and proportion need pixel control that fonts can not give.'),
            ruleCard(true,
                'Use semanticLabel for any actionable icon',
                'IconButton wraps Icon and reuses semanticLabel as the button\'s accessibility name. Always provide it for tappable glyphs.'),
            ruleCard(false,
                'Avoid sub-16px icons when applyTextScaling is off',
                'Below 16 logical pixels Material glyphs lose hinting and become blobs. If you must go small, raise opticalSize.'),
            ruleCard(true,
                'Set matchTextDirection on directional glyphs',
                'arrow_back, arrow_forward, send, reply, undo - all need matchTextDirection: true to mirror in RTL.'),
            ruleCard(false,
                'Avoid baking colored icons into a font',
                'Color is a property of the Icon widget, not of the font. A fixed-color glyph defeats theming.'),
            ruleCard(true,
                'Prefer Icons.* over hand-built IconData',
                'The Icons class is generated from the official icon-font manifest. Hand-built IconData drifts when the font upgrades.'),
            ruleCard(false,
                'Avoid Icon as the only error/success signal',
                'Color and icon together fail color-blind users. Always pair with text or a Semantics() liveRegion.'),
          ],
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 12 :: COLOPHON
  //
  // The closing scribe's note. A small final row of glyphs and an attribution
  // paragraph that ties the codex up.
  // ===========================================================================
  print('Section 12 :: signing the colophon.');

  final Widget section12 = Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [lapisDeep, lapisInk],
      ),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: lapisIngot, width: 1.6),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.auto_stories, color: lapisIngot, size: 22),
            _horizontalGap(8),
            Text('Colophon', style: _titleStyle(16, lapisIvory)),
          ],
        ),
        _verticalGap(10),
        Text(
          'This codex was set in lapis ultramarine and gold leaf upon vellum, '
          'with rubricated catechism cards and a verdigris-trimmed catalog. '
          'It illuminates the Icon widget of package:flutter/widgets.dart, '
          're-exported by package:flutter/material.dart, in twelve sections.',
          style: _bodyStyle(lapisGoldHaze, size: 12),
        ),
        _verticalGap(8),
        Text(
          'Remember: the glyph is a letter painted as a picture. Treat it with '
          'the same respect a scribe accords a capital A. Choose the codepoint '
          'with intent, set the size to the line-height it sits beside, tint '
          'it with the theme\'s ink, and label it for the reader who can not see it.',
          style: _bodyStyle(lapisGoldHaze, size: 12, w: FontWeight.w500),
        ),
        _verticalGap(14),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            Icon(Icons.book, color: lapisIngot, size: 20),
            Icon(Icons.brush, color: lapisGoldHaze, size: 20),
            Icon(Icons.format_paint, color: lapisIngot, size: 20),
            Icon(Icons.color_lens, color: lapisGoldHaze, size: 20),
            Icon(Icons.menu_book, color: lapisIngot, size: 20),
            Icon(Icons.auto_stories, color: lapisGoldHaze, size: 20),
            Icon(Icons.castle, color: lapisIngot, size: 20),
            Icon(Icons.museum, color: lapisGoldHaze, size: 20),
          ],
        ),
        _verticalGap(12),
        Text(
          'Glyph Lapis  ::  fin.',
          style: _displayStyle(18, lapisIngot),
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 13 :: GLOSSARY OF ILLUMINATION
  //
  // Twenty-plus terms a digital scribe should know. Each entry is a small
  // vellum slip with the term in mono and the definition in body-prose.
  // ===========================================================================
  print('Section 13 :: compiling the glossary of illumination.');

  Widget glossEntry(String term, String def) {
    return Container(
      width: 290,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: lapisIvory,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: lapisIngot.withValues(alpha: 0.55)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(term, style: _monoStyle(lapisDeep, size: 12)),
          _verticalGap(4),
          Text(def, style: _bodyStyle(lapisCharcoal, size: 11)),
        ],
      ),
    );
  }

  final Widget section13 = Container(
    padding: const EdgeInsets.all(16),
    decoration: _vellumSurface(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Glossary of illumination :: terms a digital scribe should know',
            style: _titleStyle(15, lapisInk)),
        _verticalGap(4),
        Text(
          'A short bestiary of the words used throughout this codex. Read these '
          'first if you are coming fresh to icon fonts and variable typography.',
          style: _bodyStyle(lapisCharcoal, size: 12),
        ),
        _verticalGap(12),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            glossEntry('IconData',
                'A small value class that records the codepoint, font family, font package, matchTextDirection flag, and font-family fallback list of a glyph. It is a request, not a painting.'),
            glossEntry('codePoint',
                'The integer index of a glyph inside an icon font. For Material Icons it lives in the Unicode Private Use Area U+E000 - U+F8FF.'),
            glossEntry('fontFamily',
                'The string identifier under which the glyph table is registered in pubspec.yaml or the platform font system. For Material Icons it is "MaterialIcons".'),
            glossEntry('fontPackage',
                'Optional package name for fonts that ship inside a Flutter package rather than the host application. The framework rewrites the family lookup automatically.'),
            glossEntry('matchTextDirection',
                'A flag on IconData that, when true, tells Icon to mirror the glyph horizontally inside an RTL Directionality. Only relevant for directional glyphs.'),
            glossEntry('IconTheme',
                'An InheritedWidget that carries default size, color, fill, weight, grade, opticalSize, opacity, and shadows for descendant Icons. Override at any level of the tree.'),
            glossEntry('IconThemeData',
                'The data class held by IconTheme. You build one with IconThemeData(size: ..., color: ...) and pass it to IconTheme(data: ..., child: ...).'),
            glossEntry('semanticLabel',
                'A string passed to Icon that wraps the glyph in a Semantics() node with that label. Null means no semantics node - correct for purely decorative glyphs.'),
            glossEntry('Variable font',
                'A font format that exposes one or more design-time axes (weight, width, optical size, custom). Material Symbols is a variable font with weight, fill, grade, and optical-size axes.'),
            glossEntry('Fill axis',
                'A 0.0 - 1.0 axis that morphs a Material Symbol from outlined to solid. Common in tab bars where active tabs go solid.'),
            glossEntry('Weight axis',
                'A 100 - 700 axis that controls stroke heaviness. Pair the Icon weight with neighboring Text weight for harmony.'),
            glossEntry('Grade axis',
                'A -50 - 200 axis for fine ink-weight adjustments without changing footprint. Useful when weight changes would shift surrounding layout.'),
            glossEntry('Optical size axis',
                'A 20 / 24 / 40 / 48 axis hint that tells the variable-font renderer which optical-size master to favor. Small icons benefit from heavier outlines.'),
            glossEntry('Shadow',
                'A dart:ui value class with offset, blurRadius, and color. Icon.shadows accepts a List<Shadow> drawn behind the glyph.'),
            glossEntry('applyTextScaling',
                'A bool on Icon. When true, MediaQuery.textScaleFactor multiplies the effective size. Defaults to false because most icons should resist text scaling.'),
            glossEntry('Icons class',
                'A static registry of pre-baked IconData entries for the Material Icons font. Icons.home is shorthand for IconData(0xe88a, fontFamily: "MaterialIcons").'),
            glossEntry('ImageIcon',
                'A widget that paints an ImageProvider at IconTheme size and color. Use for brand marks and bespoke illustrations that do not belong in a font.'),
            glossEntry('IconButton',
                'A Material widget that wraps Icon in an InkResponse. Reuses Icon.semanticLabel as the button label.'),
            glossEntry('Material Icons font',
                'The default icon font shipped with Flutter. Static, supports color and shadows but not the variable-font axes.'),
            glossEntry('Material Symbols font',
                'A newer variable icon font that supports fill, weight, grade, and optical-size axes. Add as an asset font in pubspec.yaml.'),
            glossEntry('Cupertino Icons',
                'The companion font for iOS-style icons. Used by CupertinoIcons class. Visually distinct from Material Icons.'),
            glossEntry('Private Use Area',
                'The Unicode block U+E000 - U+F8FF reserved for application-private glyphs. Every Material Icon lives here.'),
            glossEntry('Glyph footprint',
                'The bounding box of an icon. Grade-axis adjustments preserve footprint; weight-axis adjustments do not.'),
            glossEntry('Semantics node',
                'A node in the accessibility tree describing a region of the UI to assistive technologies. Icon adds one only when semanticLabel is set.'),
          ],
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 14 :: COMPARISON TABLE - Icon vs ImageIcon vs SvgPicture
  //
  // A three-column comparison rendered as a vellum-on-lapis table.
  // ===========================================================================
  print('Section 14 :: drawing the comparison table for Icon, ImageIcon, SvgPicture.');

  Widget compareCell(String text, Color text2, {bool isHeader = false}) {
    return Container(
      width: 220,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isHeader ? lapisDeep : lapisIvory,
        border: Border.all(color: lapisIngot.withValues(alpha: 0.55)),
      ),
      child: Text(
        text,
        style: isHeader
            ? _titleStyle(12, lapisIvory)
            : _bodyStyle(text2, size: 11),
      ),
    );
  }

  Widget compareRow(List<Widget> cells) {
    // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #115, P1):
    // Each `compareRow` is a Row with `CrossAxisAlignment.stretch` so that
    // all four `compareCell` Containers in the comparison matrix paint with
    // the same height as the tallest cell in the row. The row lives inside a
    // page-level scrollable (the test host wraps `build()`'s root Container
    // in a SingleChildScrollView), so the row's parent grants it unbounded
    // vertical constraints; `Row(stretch)` then propagates that unbounded
    // height down to each cell Container, which asserts via
    // `BoxConstraints.checkValid` ("BoxConstraints forces an infinite
    // height."). Wrapping the Row in `IntrinsicHeight` resolves a finite
    // tight height from the tallest cell while preserving the height-matched
    // visual.
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: cells,
      ),
    );
  }

  final Widget section14 = Container(
    padding: const EdgeInsets.all(16),
    decoration: _goldFrame(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Comparison :: Icon vs ImageIcon vs SvgPicture',
            style: _titleStyle(15, lapisInk)),
        _verticalGap(4),
        Text(
          'Three rendering paths for symbolic art. Choose by source format and '
          'theming requirements.',
          style: _bodyStyle(lapisCharcoal, size: 12),
        ),
        _verticalGap(12),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            compareRow([
              compareCell('Aspect', lapisIvory, isHeader: true),
              compareCell('Icon', lapisIvory, isHeader: true),
              compareCell('ImageIcon', lapisIvory, isHeader: true),
              compareCell('SvgPicture', lapisIvory, isHeader: true),
            ]),
            compareRow([
              compareCell('Source format', lapisInk),
              compareCell('Glyph in icon font', lapisCharcoal),
              compareCell('PNG / JPG asset', lapisCharcoal),
              compareCell('SVG asset', lapisCharcoal),
            ]),
            compareRow([
              compareCell('Vector / raster', lapisInk),
              compareCell('Vector outline', lapisCharcoal),
              compareCell('Raster bitmap', lapisCharcoal),
              compareCell('Vector', lapisCharcoal),
            ]),
            compareRow([
              compareCell('Color tinting', lapisInk),
              compareCell('Direct color property', lapisCharcoal),
              compareCell('Via ColorFilter / blendMode', lapisCharcoal),
              compareCell('Via ColorFilter or theme', lapisCharcoal),
            ]),
            compareRow([
              compareCell('Multi-color glyphs', lapisInk),
              compareCell('No (font is monochrome)', lapisCharcoal),
              compareCell('Yes (source has colors)', lapisCharcoal),
              compareCell('Yes (full SVG palette)', lapisCharcoal),
            ]),
            compareRow([
              compareCell('Variable axes', lapisInk),
              compareCell('Yes (Material Symbols)', lapisCharcoal),
              compareCell('No', lapisCharcoal),
              compareCell('No (treat SVG as static)', lapisCharcoal),
            ]),
            compareRow([
              compareCell('Build cost', lapisInk),
              compareCell('Cheap (text shaping)', lapisCharcoal),
              compareCell('Cheap (raster blit)', lapisCharcoal),
              compareCell('More (parse + paint)', lapisCharcoal),
            ]),
            compareRow([
              compareCell('Bundle weight', lapisInk),
              compareCell('One font for thousands', lapisCharcoal),
              compareCell('One file per icon', lapisCharcoal),
              compareCell('One file per icon', lapisCharcoal),
            ]),
            compareRow([
              compareCell('When to choose', lapisInk),
              compareCell('Symbolic UI glyphs', lapisCharcoal),
              compareCell('Brand / illustration', lapisCharcoal),
              compareCell('Crisp brand vector', lapisCharcoal),
            ]),
          ],
        ),
        _verticalGap(10),
        Text(
          'Rule of thumb: Icon for the framework\'s symbolic vocabulary, '
          'ImageIcon for brand marks that ship as PNG, SvgPicture for crisp '
          'vector logos and decorative illustrations that need exact paint control.',
          style: _bodyStyle(lapisSlate, size: 11),
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 15 :: RECIPE CARDS
  //
  // Five concrete code-recipe cards showing common Icon patterns.
  // ===========================================================================
  print('Section 15 :: writing the recipe cards.');

  Widget recipeCard({
    required String title,
    required String code,
    required String prose,
    required IconData glyph,
  }) {
    return Container(
      width: 320,
      padding: const EdgeInsets.all(12),
      decoration: _vellumSurface(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(glyph, color: lapisDeep, size: 22),
              _horizontalGap(8),
              Expanded(child: Text(title, style: _titleStyle(13, lapisInk))),
            ],
          ),
          _verticalGap(8),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: lapisCharcoal,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(code, style: _monoStyle(lapisGoldHaze, size: 10)),
          ),
          _verticalGap(8),
          Text(prose, style: _bodyStyle(lapisCharcoal, size: 11)),
        ],
      ),
    );
  }

  final Widget section15 = Container(
    padding: const EdgeInsets.all(16),
    decoration: _lapisSurface(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Recipe cards :: five canonical patterns',
            style: _titleStyle(15, lapisIvory)),
        _verticalGap(4),
        Text(
          'Five short code recipes showing how Icon is used in the wild. '
          'Each recipe is the smallest faithful example of a real pattern.',
          style: _bodyStyle(lapisSky, size: 12),
        ),
        _verticalGap(12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            recipeCard(
              title: 'Theme-driven Icon',
              glyph: Icons.palette,
              code:
                  'IconTheme(\n  data: IconThemeData(\n    size: 20,\n    color: theme.primary,\n  ),\n  child: Icon(Icons.home),\n)',
              prose:
                  'Wrap a subtree in IconTheme to cascade size/color/axes to all '
                  'descendants. Lets a single design-system token drive every icon below.',
            ),
            recipeCard(
              title: 'Mirrored back arrow (RTL)',
              glyph: Icons.arrow_back,
              code:
                  'Icon(\n  Icons.arrow_back,\n  textDirection:\n    TextDirection.rtl,\n)',
              prose:
                  'arrow_back has matchTextDirection: true on its IconData. '
                  'Provide textDirection (or rely on Directionality) to mirror.',
            ),
            recipeCard(
              title: 'Variable-font heavy weight',
              glyph: Icons.star,
              code:
                  'Icon(\n  Icons.star,\n  weight: 700,\n  fill: 1.0,\n  grade: 50,\n)',
              prose:
                  'Use the variable-font axes for visual emphasis without '
                  'switching to a different IconData. Bold + filled = "selected" state.',
            ),
            recipeCard(
              title: 'Accessible IconButton',
              glyph: Icons.menu,
              code:
                  'IconButton(\n  icon: Icon(Icons.menu),\n  tooltip: \'Open drawer\',\n  onPressed: openDrawer,\n)',
              prose:
                  'IconButton inherits semanticLabel from tooltip when icon\'s '
                  'is null. Always set tooltip or semanticLabel for icon-only buttons.',
            ),
            recipeCard(
              title: 'Custom font glyph',
              glyph: Icons.brush,
              code:
                  'Icon(\n  IconData(\n    0xf001,\n    fontFamily: \'MyAppGlyphs\',\n  ),\n)',
              prose:
                  'When you ship a private icon font, build IconData by hand '
                  'with the codepoint your font tool emitted. Wrap them in a static class for ergonomics.',
            ),
          ],
        ),
      ],
    ),
  );

  // ===========================================================================
  // ASSEMBLE THE CODEX
  // ===========================================================================
  print('Assembling all fifteen sections into the codex tree.');
  // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #115, P2):
  // After fixing the comparison-matrix Row(stretch) infinite-height (see #115
  // P1 above) the codex's combined section heights revealed a second
  // framework error: "A RenderFlex overflowed by 5040 pixels on the bottom."
  // The page root was a plain Container > Column with no scroll ancestor.
  // Wrap the Column in a SingleChildScrollView — the parchment-coloured
  // Container stays *outside* the scroll view so the lapis-parchment
  // backdrop fills the whole viewport, not just the scrolled content.
  final Widget codex = Container(
    color: lapisParchment,
    child: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        section1,
        _verticalGap(16),
        section2,
        _verticalGap(16),
        section3,
        _verticalGap(16),
        section4,
        _verticalGap(16),
        section5,
        _verticalGap(16),
        section6,
        _verticalGap(16),
        section7,
        _verticalGap(16),
        section8,
        _verticalGap(16),
        section9,
        _verticalGap(16),
        section10,
        _verticalGap(16),
        section11,
        _verticalGap(16),
        section13,
        _verticalGap(16),
        section14,
        _verticalGap(16),
        section15,
        _verticalGap(16),
        section12,
      ],
      ),
    ),
  );

  print('Codex assembled. Closing the lapis ink-pot.');
  print('================================================================');

  return codex;
}
