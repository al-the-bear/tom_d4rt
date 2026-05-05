// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_element
// ============================================================================
// FontLoader Deep Demo  --  Theme: 'Letterpress Saffron'
// ----------------------------------------------------------------------------
// This file is a hand-written, instruction-rich Flutter demo script that
// explores the surface API of FontLoader from package:flutter/services.dart.
//
// FontLoader is the programmatic, runtime entry point that lets a Flutter
// application register a font family with the engine *after* the app has
// already started.  The familiar declarative path -- declaring fonts under the
// `fonts:` key in pubspec.yaml -- is wonderful for static, ship-with-the-app
// typography.  But many real applications need to fetch typefaces from a CDN,
// from a tenant-specific brand server, or from a user-uploaded archive.  For
// those cases the engine exposes FontLoader: a tiny, focused class that
// accumulates raw font byte streams and, when load() is awaited, hands them
// over to the platform shaper to be registered under a postscript family
// name.  After load() resolves successfully, any TextStyle whose fontFamily
// matches that name will be drawn with the freshly-registered font.
//
// The demo is structured as a single dynamic build(BuildContext) function
// that returns a snapshot Scaffold.  It does NOT try to actually load any
// font bytes during the test run -- that would require a real asset bundle
// or a network round-trip and would not complete inside a synchronous build.
// Instead it constructs many FontLoader instances (the constructor IS
// synchronous), reads back their .family property, and renders pedagogical
// cards that show what a TextStyle(fontFamily: <familyName>) would look like
// once the corresponding bytes had been loaded.  For the actual rendered
// glyphs we fall back to the host platform's default family, because the
// d4rt analyzer-free interpreter cannot reach an asset bundle either.
//
// THEME -- 'Letterpress Saffron'
// A warm, paper-coloured palette that evokes a small letterpress studio in
// late afternoon: cream paper, saffron threads, ember orange, ink black,
// gilded brass, and the muted blue-greens of an old printer's apron.  Ten
// named colours are defined below and reused across every section.
//
// SECTIONS -- all rendered top to bottom inside a SingleChildScrollView:
//   1.  Title banner with palette swatches
//   2.  Prose anatomy card -- font-loading pipeline, asset vs network bytes
//   3.  Property anatomy -- family, addFont, load, accumulator semantics
//   4.  Construction gallery -- 6+ hypothetical FontLoader instances
//   5.  Lifecycle timeline -- construct, addFont, load, ready
//   6.  Asset font vs network font matrix
//   7.  TextStyle preview gallery -- italic, weight, letterSpacing combos
//   8.  Memory footprint prose with proportional KB swatch bars
//   9.  DO / AVOID callouts
//  10.  Code-snippet cards -- five canonical recipes
//  11.  Glossary -- twelve terms
//  12.  Recap footer
//
// CONSTRAINTS -- this script runs inside the d4rt analyzer-free interpreter:
//   * build() is called exactly once and must return a snapshot widget tree
//   * No StatefulWidget, setState, controllers, timers, or streams
//   * No for-in over BridgedInstance values
//   * No .value reads on Tween.animate
//   * Color alpha must be applied via .withValues(alpha: ...)
//   * 5..15 narrative print(...) calls scattered across the build
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ============================================================================
// PALETTE -- Letterpress Saffron
// ============================================================================
// Ten named colours plus a handful of derived tints.  All hex literals are
// fully opaque; transparency is layered on at use-site via .withValues(...).
class _Palette {
  static const Color paper        = Color(0xFFF6EFE2); // aged cream paper
  static const Color saffron      = Color(0xFFE7A33A); // saffron thread
  static const Color ember        = Color(0xFFC25A1F); // ember orange
  static const Color ink          = Color(0xFF1B1A17); // press ink black
  static const Color brass        = Color(0xFFB08A4B); // gilded brass
  static const Color apron        = Color(0xFF3D5B57); // apron blue-green
  static const Color rule         = Color(0xFF8C7A55); // rule line ochre
  static const Color shadow       = Color(0xFF6B5A3E); // soft shadow
  static const Color highlight    = Color(0xFFFFD27A); // highlight wash
  static const Color accent       = Color(0xFF7E2E1F); // accent oxblood
  static const Color quietPaper   = Color(0xFFEFE5D2); // quieter paper
  static const Color deepEmber    = Color(0xFF8E3A12); // deep ember edge
}

// ============================================================================
// HELPERS -- small, snapshot-friendly widget builders
// ============================================================================

Widget _gap(double h) => SizedBox(height: h);
Widget _hgap(double w) => SizedBox(width: w);

Widget _swatch(Color c, String label) {
  return Container(
    width: 92,
    margin: const EdgeInsets.only(right: 8, bottom: 8),
    padding: const EdgeInsets.all(6),
    decoration: BoxDecoration(
      color: _Palette.paper,
      border: Border.all(color: _Palette.rule.withValues(alpha: 0.6)),
      borderRadius: BorderRadius.circular(6),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 24,
          decoration: BoxDecoration(
            color: c,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 10, color: _Palette.ink)),
      ],
    ),
  );
}

Widget _sectionHeader(String number, String title, String subtitle) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(top: 24, bottom: 8),
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    decoration: BoxDecoration(
      color: _Palette.ember.withValues(alpha: 0.12),
      border: Border(left: BorderSide(color: _Palette.ember, width: 4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('SECTION $number',
          style: const TextStyle(
            fontSize: 11,
            letterSpacing: 1.6,
            color: _Palette.deepEmber,
            fontWeight: FontWeight.w700,
          )),
        const SizedBox(height: 4),
        Text(title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: _Palette.ink,
          )),
        const SizedBox(height: 2),
        Text(subtitle,
          style: TextStyle(
            fontSize: 12,
            fontStyle: FontStyle.italic,
            color: _Palette.shadow.withValues(alpha: 0.9),
          )),
      ],
    ),
  );
}

Widget _proseCard(String body) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(vertical: 6),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _Palette.quietPaper,
      border: Border.all(color: _Palette.rule.withValues(alpha: 0.5)),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(body,
      style: const TextStyle(
        fontSize: 13,
        height: 1.45,
        color: _Palette.ink,
      )),
  );
}

Widget _bulletList(List<String> items) {
  final List<Widget> rows = [];
  for (var i = 0; i < items.length; i++) {
    rows.add(Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6, right: 8),
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: _Palette.saffron,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Text(items[i],
              style: const TextStyle(fontSize: 12.5, color: _Palette.ink, height: 1.4)),
          ),
        ],
      ),
    ));
  }
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: rows);
}

Widget _kvRow(String key, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 130,
          child: Text(key,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: _Palette.apron,
            )),
        ),
        Expanded(
          child: Text(value,
            style: const TextStyle(
              fontSize: 12,
              color: _Palette.ink,
              height: 1.35,
            )),
        ),
      ],
    ),
  );
}

Widget _calloutCard(String tag, Color tagColor, String title, String body) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(vertical: 5),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _Palette.paper,
      border: Border.all(color: tagColor.withValues(alpha: 0.7)),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: tagColor,
            borderRadius: BorderRadius.circular(3),
          ),
          child: Text(tag,
            style: const TextStyle(
              fontSize: 10,
              letterSpacing: 1.4,
              color: _Palette.paper,
              fontWeight: FontWeight.w800,
            )),
        ),
        const SizedBox(height: 6),
        Text(title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: _Palette.ink,
          )),
        const SizedBox(height: 4),
        Text(body,
          style: const TextStyle(fontSize: 12, color: _Palette.ink, height: 1.4)),
      ],
    ),
  );
}

Widget _codeCard(String title, String snippet, String note) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(vertical: 6),
    decoration: BoxDecoration(
      color: _Palette.ink,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: _Palette.brass.withValues(alpha: 0.85),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
          ),
          child: Text(title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: _Palette.ink,
              letterSpacing: 1.2,
            )),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Text(snippet,
            style: TextStyle(
              fontSize: 11.5,
              fontFamily: 'monospace',
              height: 1.45,
              color: _Palette.highlight.withValues(alpha: 0.95),
            )),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: _Palette.apron.withValues(alpha: 0.6),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
          ),
          child: Text(note,
            style: const TextStyle(
              fontSize: 11,
              fontStyle: FontStyle.italic,
              color: _Palette.paper,
            )),
        ),
      ],
    ),
  );
}

Widget _hop(int n, String label, String detail, Color color) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 4),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.15),
      border: Border.all(color: color.withValues(alpha: 0.7)),
      borderRadius: BorderRadius.circular(6),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 28,
          height: 28,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: Text('$n',
            style: const TextStyle(
              color: _Palette.paper,
              fontWeight: FontWeight.w800,
              fontSize: 13,
            )),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: _Palette.ink,
                )),
              const SizedBox(height: 2),
              Text(detail,
                style: const TextStyle(fontSize: 11.5, color: _Palette.ink, height: 1.35)),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _kbBar(String label, double kb, double maxKb) {
  final double widthFactor = (kb / maxKb).clamp(0.05, 1.0);
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: _Palette.ink,
              )),
            Text('${kb.toStringAsFixed(1)} KB',
              style: const TextStyle(
                fontSize: 11,
                color: _Palette.shadow,
                fontFamily: 'monospace',
              )),
          ],
        ),
        const SizedBox(height: 4),
        Container(
          height: 10,
          decoration: BoxDecoration(
            color: _Palette.quietPaper,
            borderRadius: BorderRadius.circular(5),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: widthFactor,
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [_Palette.saffron, _Palette.ember],
                ),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _glossaryRow(String term, String def) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(vertical: 3),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    decoration: BoxDecoration(
      color: _Palette.paper,
      border: Border(
        left: BorderSide(color: _Palette.brass.withValues(alpha: 0.8), width: 3),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(term,
          style: const TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.w800,
            color: _Palette.accent,
            letterSpacing: 0.5,
          )),
        const SizedBox(height: 2),
        Text(def,
          style: const TextStyle(fontSize: 11.5, color: _Palette.ink, height: 1.4)),
      ],
    ),
  );
}

// ============================================================================
// build() -- the single snapshot entry point
// ============================================================================
dynamic build(BuildContext context) {
  print('=== FontLoader Deep Demo : Letterpress Saffron ===');
  print('Constructing FontLoader instances (synchronous constructor)');

  // --------------------------------------------------------------------------
  // Construct hypothetical FontLoader instances.  The constructor merely
  // stores the family name; no I/O happens until load() is awaited.  We can
  // therefore build many of these inside a snapshot build() with no risk of
  // blocking, throwing, or producing side effects.
  // --------------------------------------------------------------------------
  final FontLoader loaderSaffron     = FontLoader('SaffronSerif');
  final FontLoader loaderEmberSans   = FontLoader('EmberSans');
  final FontLoader loaderInkRoman    = FontLoader('InkRoman');
  final FontLoader loaderBrassMono   = FontLoader('BrassMono');
  final FontLoader loaderApronText   = FontLoader('ApronText');
  final FontLoader loaderHighlightUI = FontLoader('HighlightUI');
  final FontLoader loaderRuleDisplay = FontLoader('RuleDisplay');
  final FontLoader loaderShadowItalic= FontLoader('ShadowItalic');

  print('  family[1] = ${loaderSaffron.family}');
  print('  family[2] = ${loaderEmberSans.family}');
  print('  family[3] = ${loaderInkRoman.family}');
  print('  family[4] = ${loaderBrassMono.family}');
  print('  family[5] = ${loaderApronText.family}');
  print('  family[6] = ${loaderHighlightUI.family}');
  print('  family[7] = ${loaderRuleDisplay.family}');
  print('  family[8] = ${loaderShadowItalic.family}');

  // We deliberately do NOT call .addFont() or await .load() here.  Both
  // return Futures whose completion would not fit inside the synchronous
  // snapshot build that the d4rt interpreter performs for this script.
  // The instances are kept around purely so that we can read .family back
  // and surface it to the rendered widget tree.
  print('Surface API demonstrated; actual byte loading is documented only.');

  return Scaffold(
    backgroundColor: _Palette.paper,
    body: SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(18, 22, 18, 36),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // ==============================================================
          // SECTION 1 -- Title banner with palette swatches
          // ==============================================================
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(18, 22, 18, 22),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  _Palette.ink,
                  _Palette.apron.withValues(alpha: 0.92),
                  _Palette.deepEmber.withValues(alpha: 0.85),
                ],
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('FontLoader',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w900,
                    color: _Palette.highlight,
                    letterSpacing: 1.5,
                    height: 1.0,
                  )),
                const SizedBox(height: 6),
                Text('A deep demo in the Letterpress Saffron palette',
                  style: TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                    color: _Palette.paper.withValues(alpha: 0.88),
                  )),
                const SizedBox(height: 14),
                Text('package:flutter/services.dart  ->  class FontLoader',
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'monospace',
                    color: _Palette.highlight.withValues(alpha: 0.85),
                    letterSpacing: 0.3,
                  )),
                const SizedBox(height: 18),
                Wrap(
                  children: [
                    _swatch(_Palette.paper,      'paper'),
                    _swatch(_Palette.saffron,    'saffron'),
                    _swatch(_Palette.ember,      'ember'),
                    _swatch(_Palette.ink,        'ink'),
                    _swatch(_Palette.brass,      'brass'),
                    _swatch(_Palette.apron,      'apron'),
                    _swatch(_Palette.rule,       'rule'),
                    _swatch(_Palette.shadow,     'shadow'),
                    _swatch(_Palette.highlight,  'highlight'),
                    _swatch(_Palette.accent,     'accent'),
                    _swatch(_Palette.quietPaper, 'quietPaper'),
                    _swatch(_Palette.deepEmber,  'deepEmber'),
                  ],
                ),
              ],
            ),
          ),

          // ==============================================================
          // SECTION 2 -- Prose anatomy of the font-loading pipeline
          // ==============================================================
          _sectionHeader('02', 'Anatomy of a Font Load',
            'Where bytes come from, how the engine receives them, and why FontLoader is the right tool.'),
          _proseCard(
            'A typeface, on disk, is a sequence of bytes -- typically TTF or OTF, '
            'occasionally a TTC collection or a WOFF2 web blob.  Flutter\'s normal '
            'pipeline copes with declared fonts beautifully: list them in pubspec.yaml '
            'under the fonts: key, ship them in the asset bundle, and the engine '
            'registers them at startup.  But that pipeline is closed at compile time.'),
          _proseCard(
            'FontLoader exists for the moments when typography arrives later: a '
            'tenant-specific brand pack pulled from a CDN, an enterprise typeface '
            'unlocked by a license check, a user-uploaded font in a design tool, or '
            'an A/B-tested marketing font swapped in at runtime.  In all those '
            'cases the application already has bytes in hand (rootBundle.load, '
            'http.get, File.readAsBytes, IndexedDB on web) and just needs to '
            'hand them to the engine under a name that TextStyle.fontFamily can match.'),
          _proseCard(
            'The FontLoader contract is small and pleasingly imperative: construct '
            'one with a family name, accumulate one or more variant byte streams '
            'via addFont(), then await load() exactly once.  Every variant added '
            'before load() lands under the same family; the engine separates them '
            'internally by reading the OS/2 weight and italic flags out of the font '
            'tables themselves -- you do not (and cannot) declare those externally.'),
          _proseCard(
            'After load() resolves, any TextStyle whose fontFamily string equals the '
            'family you passed to the constructor will be drawn with the new font.  '
            'Existing widgets do NOT auto-rebuild -- you should trigger a rebuild '
            'yourself, typically by setState in a controlling stateful ancestor or '
            'by completing a Future that gates your first paint.'),

          // ==============================================================
          // SECTION 3 -- Property anatomy
          // ==============================================================
          _sectionHeader('03', 'Property Anatomy',
            'Every member of FontLoader, what it does, and how to reason about it.'),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: _Palette.quietPaper,
              border: Border.all(color: _Palette.rule.withValues(alpha: 0.5)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _kvRow('family',
                  'String, final, set in the constructor.  This is the postscript '
                  'family name that TextStyle.fontFamily must match.  Pick something '
                  'distinctive enough to avoid colliding with bundled fonts.'),
                _kvRow('addFont(bytes)',
                  'Future<ByteData> -> void.  Records the byte stream for later '
                  'registration.  Returns synchronously after enqueuing -- no I/O '
                  'happens here.  Call once per variant: regular, bold, italic, etc.'),
                _kvRow('load()',
                  'Future<void>.  Awaits all enqueued addFont futures, hands their '
                  'resolved bytes to the engine, and registers the family.  Idempotent '
                  'on the engine side, but you should still load each FontLoader once.'),
                _kvRow('accumulator',
                  'FontLoader is a write-once builder.  After load() it is essentially '
                  'spent -- adding more bytes and reloading is undefined behaviour and '
                  'should be avoided.  Build a fresh FontLoader for an updated family.'),
                _kvRow('thread model',
                  'load() may parse and shape on a background isolate at the engine '
                  'level, but from your Dart code\'s perspective it is a plain '
                  'Future you await on the main isolate.'),
                _kvRow('failure modes',
                  'Corrupt bytes, unsupported format, or a zero-length blob will '
                  'cause load() to complete with an error.  Wrap in try/catch and '
                  'fall back to a system family if the registration fails.'),
              ],
            ),
          ),

          // ==============================================================
          // SECTION 4 -- Construction gallery
          // ==============================================================
          _sectionHeader('04', 'Construction Gallery',
            'Eight FontLoader instances built live, with previews of what each family would render.'),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 6),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: _Palette.paper,
              border: Border.all(color: _Palette.brass.withValues(alpha: 0.7)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: _Palette.saffron.withValues(alpha: 0.85),
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Text('family: ${loaderSaffron.family}',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          color: _Palette.ink,
                          letterSpacing: 0.6,
                        )),
                    ),
                    const SizedBox(width: 8),
                    Text('display serif, brand titles',
                      style: const TextStyle(
                        fontSize: 11,
                        fontStyle: FontStyle.italic,
                        color: _Palette.shadow,
                      )),
                  ],
                ),
                const SizedBox(height: 10),
                Text('The quick saffron fox prints over the lazy press.',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                    color: _Palette.ink,
                    height: 1.2,
                  )),
                const SizedBox(height: 6),
                Text('Hypothetical render of "SaffronSerif" -- the test runner cannot reach an asset bundle, so the glyphs above use the host fallback family.',
                  style: const TextStyle(
                    fontSize: 11,
                    color: _Palette.shadow,
                    height: 1.4,
                    fontStyle: FontStyle.italic,
                  )),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 6),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: _Palette.paper,
              border: Border.all(color: _Palette.brass.withValues(alpha: 0.7)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: _Palette.saffron.withValues(alpha: 0.85),
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Text('family: ${loaderEmberSans.family}',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          color: _Palette.ink,
                          letterSpacing: 0.6,
                        )),
                    ),
                    const SizedBox(width: 8),
                    Text('humanist sans, body copy',
                      style: const TextStyle(
                        fontSize: 11,
                        fontStyle: FontStyle.italic,
                        color: _Palette.shadow,
                      )),
                  ],
                ),
                const SizedBox(height: 10),
                Text('Body copy that warms the page like an ember at dusk.',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    color: _Palette.ink,
                    height: 1.2,
                  )),
                const SizedBox(height: 6),
                Text('Hypothetical render of "EmberSans" -- the test runner cannot reach an asset bundle, so the glyphs above use the host fallback family.',
                  style: const TextStyle(
                    fontSize: 11,
                    color: _Palette.shadow,
                    height: 1.4,
                    fontStyle: FontStyle.italic,
                  )),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 6),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: _Palette.paper,
              border: Border.all(color: _Palette.brass.withValues(alpha: 0.7)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: _Palette.saffron.withValues(alpha: 0.85),
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Text('family: ${loaderInkRoman.family}',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          color: _Palette.ink,
                          letterSpacing: 0.6,
                        )),
                    ),
                    const SizedBox(width: 8),
                    Text('old-style roman, long form',
                      style: const TextStyle(
                        fontSize: 11,
                        fontStyle: FontStyle.italic,
                        color: _Palette.shadow,
                      )),
                  ],
                ),
                const SizedBox(height: 10),
                Text('An ink-soft Roman for long-form letterpress reading.',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                    color: _Palette.ink,
                    height: 1.2,
                  )),
                const SizedBox(height: 6),
                Text('Hypothetical render of "InkRoman" -- the test runner cannot reach an asset bundle, so the glyphs above use the host fallback family.',
                  style: const TextStyle(
                    fontSize: 11,
                    color: _Palette.shadow,
                    height: 1.4,
                    fontStyle: FontStyle.italic,
                  )),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 6),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: _Palette.paper,
              border: Border.all(color: _Palette.brass.withValues(alpha: 0.7)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: _Palette.saffron.withValues(alpha: 0.85),
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Text('family: ${loaderBrassMono.family}',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          color: _Palette.ink,
                          letterSpacing: 0.6,
                        )),
                    ),
                    const SizedBox(width: 8),
                    Text('monospaced, code blocks',
                      style: const TextStyle(
                        fontSize: 11,
                        fontStyle: FontStyle.italic,
                        color: _Palette.shadow,
                      )),
                  ],
                ),
                const SizedBox(height: 10),
                Text('fn brass_mono() -> &str { "keeps every column straight" }',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    color: _Palette.ink,
                    height: 1.2,
                  )),
                const SizedBox(height: 6),
                Text('Hypothetical render of "BrassMono" -- the test runner cannot reach an asset bundle, so the glyphs above use the host fallback family.',
                  style: const TextStyle(
                    fontSize: 11,
                    color: _Palette.shadow,
                    height: 1.4,
                    fontStyle: FontStyle.italic,
                  )),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 6),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: _Palette.paper,
              border: Border.all(color: _Palette.brass.withValues(alpha: 0.7)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: _Palette.saffron.withValues(alpha: 0.85),
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Text('family: ${loaderApronText.family}',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          color: _Palette.ink,
                          letterSpacing: 0.6,
                        )),
                    ),
                    const SizedBox(width: 8),
                    Text('narrow text, dense UI',
                      style: const TextStyle(
                        fontSize: 11,
                        fontStyle: FontStyle.italic,
                        color: _Palette.shadow,
                      )),
                  ],
                ),
                const SizedBox(height: 10),
                Text('Apron text condenses neatly into narrow side panels.',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                    color: _Palette.ink,
                    height: 1.2,
                  )),
                const SizedBox(height: 6),
                Text('Hypothetical render of "ApronText" -- the test runner cannot reach an asset bundle, so the glyphs above use the host fallback family.',
                  style: const TextStyle(
                    fontSize: 11,
                    color: _Palette.shadow,
                    height: 1.4,
                    fontStyle: FontStyle.italic,
                  )),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 6),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: _Palette.paper,
              border: Border.all(color: _Palette.brass.withValues(alpha: 0.7)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: _Palette.saffron.withValues(alpha: 0.85),
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Text('family: ${loaderHighlightUI.family}',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          color: _Palette.ink,
                          letterSpacing: 0.6,
                        )),
                    ),
                    const SizedBox(width: 8),
                    Text('rounded UI, buttons',
                      style: const TextStyle(
                        fontSize: 11,
                        fontStyle: FontStyle.italic,
                        color: _Palette.shadow,
                      )),
                  ],
                ),
                const SizedBox(height: 10),
                Text('OK   Cancel   Save Draft   Publish Now',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                    color: _Palette.ink,
                    height: 1.2,
                  )),
                const SizedBox(height: 6),
                Text('Hypothetical render of "HighlightUI" -- the test runner cannot reach an asset bundle, so the glyphs above use the host fallback family.',
                  style: const TextStyle(
                    fontSize: 11,
                    color: _Palette.shadow,
                    height: 1.4,
                    fontStyle: FontStyle.italic,
                  )),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 6),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: _Palette.paper,
              border: Border.all(color: _Palette.brass.withValues(alpha: 0.7)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: _Palette.saffron.withValues(alpha: 0.85),
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Text('family: ${loaderRuleDisplay.family}',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          color: _Palette.ink,
                          letterSpacing: 0.6,
                        )),
                    ),
                    const SizedBox(width: 8),
                    Text('tall display, posters',
                      style: const TextStyle(
                        fontSize: 11,
                        fontStyle: FontStyle.italic,
                        color: _Palette.shadow,
                      )),
                  ],
                ),
                const SizedBox(height: 10),
                Text('RULE -- LARGE -- LOUD',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    fontStyle: FontStyle.normal,
                    color: _Palette.ink,
                    height: 1.2,
                  )),
                const SizedBox(height: 6),
                Text('Hypothetical render of "RuleDisplay" -- the test runner cannot reach an asset bundle, so the glyphs above use the host fallback family.',
                  style: const TextStyle(
                    fontSize: 11,
                    color: _Palette.shadow,
                    height: 1.4,
                    fontStyle: FontStyle.italic,
                  )),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 6),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: _Palette.paper,
              border: Border.all(color: _Palette.brass.withValues(alpha: 0.7)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: _Palette.saffron.withValues(alpha: 0.85),
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Text('family: ${loaderShadowItalic.family}',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          color: _Palette.ink,
                          letterSpacing: 0.6,
                        )),
                    ),
                    const SizedBox(width: 8),
                    Text('expressive italic, pull quotes',
                      style: const TextStyle(
                        fontSize: 11,
                        fontStyle: FontStyle.italic,
                        color: _Palette.shadow,
                      )),
                  ],
                ),
                const SizedBox(height: 10),
                Text('...and so the apprentice set the saffron type.',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.italic,
                    color: _Palette.ink,
                    height: 1.2,
                  )),
                const SizedBox(height: 6),
                Text('Hypothetical render of "ShadowItalic" -- the test runner cannot reach an asset bundle, so the glyphs above use the host fallback family.',
                  style: const TextStyle(
                    fontSize: 11,
                    color: _Palette.shadow,
                    height: 1.4,
                    fontStyle: FontStyle.italic,
                  )),
              ],
            ),
          ),

          // ==============================================================
          // SECTION 5 -- Lifecycle timeline
          // ==============================================================
          _sectionHeader('05', 'Lifecycle Timeline',
            'Five hops from constructor to a TextStyle that paints with the new family.'),
          _hop(1, 'Construct',
            'final loader = FontLoader("SaffronSerif"). Synchronous; just stores the family name.',
            _Palette.brass),
          _hop(2, 'Fetch bytes',
            'Acquire ByteData via rootBundle.load, http.get, File.readAsBytes, or any other byte source. Each variant is its own future.',
            _Palette.saffron),
          _hop(3, 'addFont(future)',
            'loader.addFont(bytesFuture). Repeat for every weight/style. The FontLoader queues the future internally.',
            _Palette.ember),
          _hop(4, 'await loader.load()',
            'Engine awaits all queued byte futures, parses each font table, and registers them under the family name.',
            _Palette.deepEmber),
          _hop(5, 'Ready -- paint',
            'TextStyle(fontFamily: "SaffronSerif") now resolves to the new typeface. Trigger a rebuild so existing widgets pick it up.',
            _Palette.apron),
          _gap(8),
          _proseCard(
            'Note that hops 2 and 3 can be interleaved freely; addFont() does not '
            'wait for its argument to resolve.  Only hop 4 is a real blocking '
            'point.  In practice you usually gate first paint on a single Future '
            'returned by load() and show a splash or skeleton while it resolves.'),

          // ==============================================================
          // SECTION 6 -- asset font vs network font matrix
          // ==============================================================
          _sectionHeader('06', 'Source x Cache Matrix',
            'Four cards crossing byte source with cache strategy.'),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 6),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _Palette.paper,
              border: Border.all(color: _Palette.brass.withValues(alpha: 0.7), width: 1.4),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Asset bundle x permanent cache',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: _Palette.ink,
                  )),
                const SizedBox(height: 2),
                Text('Bundled with the app; no network, OS-level read cache',
                  style: const TextStyle(
                    fontSize: 11,
                    fontStyle: FontStyle.italic,
                    color: _Palette.shadow,
                  )),
                const SizedBox(height: 8),
                _kvRow('source', 'rootBundle.load("assets/fonts/SaffronSerif-Regular.ttf")'),
                _kvRow('ttl', 'process lifetime; bytes live in the asset archive'),
                _kvRow('failure', 'asset missing -> FlutterError at startup, not at load()'),
                _kvRow('when to use', 'stable brand fonts that ship with every release'),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 6),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _Palette.paper,
              border: Border.all(color: _Palette.saffron.withValues(alpha: 0.7), width: 1.4),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Network fetch x in-memory cache',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: _Palette.ink,
                  )),
                const SizedBox(height: 2),
                Text('HTTP GET into a Map<String, ByteData> keyed by family name',
                  style: const TextStyle(
                    fontSize: 11,
                    fontStyle: FontStyle.italic,
                    color: _Palette.shadow,
                  )),
                const SizedBox(height: 8),
                _kvRow('source', 'http.get(uri).then((r) => ByteData.view(r.bodyBytes.buffer))'),
                _kvRow('ttl', 'until the isolate is killed; not survived across restarts'),
                _kvRow('failure', 'network error -> retry with backoff or fall back to system family'),
                _kvRow('when to use', 'small variant set, low repeat-launch cost acceptable'),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 6),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _Palette.paper,
              border: Border.all(color: _Palette.ember.withValues(alpha: 0.7), width: 1.4),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Network fetch x disk cache',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: _Palette.ink,
                  )),
                const SizedBox(height: 2),
                Text('Bytes streamed to a file under getApplicationSupportDirectory',
                  style: const TextStyle(
                    fontSize: 11,
                    fontStyle: FontStyle.italic,
                    color: _Palette.shadow,
                  )),
                const SizedBox(height: 8),
                _kvRow('source', 'first run: http; subsequent runs: File.readAsBytes'),
                _kvRow('ttl', 'manual; invalidate on version bump or ETag change'),
                _kvRow('failure', 'corrupted file -> delete + re-fetch on the next launch'),
                _kvRow('when to use', 'large fonts, many launches, expensive bandwidth'),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 6),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _Palette.paper,
              border: Border.all(color: _Palette.apron.withValues(alpha: 0.7), width: 1.4),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('User upload x sandbox storage',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: _Palette.ink,
                  )),
                const SizedBox(height: 2),
                Text('User picks a TTF; bytes copied into app sandbox and registered',
                  style: const TextStyle(
                    fontSize: 11,
                    fontStyle: FontStyle.italic,
                    color: _Palette.shadow,
                  )),
                const SizedBox(height: 8),
                _kvRow('source', 'FilePicker -> File.readAsBytes()'),
                _kvRow('ttl', 'user-controlled; bound to a project or document'),
                _kvRow('failure', 'unsupported format -> reject in UI before calling addFont'),
                _kvRow('when to use', 'design tools, branding apps, document editors'),
              ],
            ),
          ),

          // ==============================================================
          // SECTION 7 -- TextStyle preview gallery
          // ==============================================================
          _sectionHeader('07', 'TextStyle Preview Gallery',
            'Six text samples mixing weight, italic, and letterSpacing on a hypothetical loaded family.'),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 5),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _Palette.quietPaper,
              border: Border.all(color: _Palette.rule.withValues(alpha: 0.5)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('w200 -- ULTRALIGHT',
                  style: const TextStyle(
                    fontSize: 10,
                    letterSpacing: 1.4,
                    fontWeight: FontWeight.w800,
                    color: _Palette.deepEmber,
                  )),
                const SizedBox(height: 6),
                Text('Saffron threads at sunrise.',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w200,
                    fontStyle: FontStyle.normal,
                    letterSpacing: 0.4,
                    color: _Palette.ink,
                    height: 1.25,
                  )),
                const SizedBox(height: 6),
                Text('Thin weights need extra letterSpacing to keep their delicate stems readable.',
                  style: const TextStyle(
                    fontSize: 11,
                    fontStyle: FontStyle.italic,
                    color: _Palette.shadow,
                    height: 1.4,
                  )),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 5),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _Palette.quietPaper,
              border: Border.all(color: _Palette.rule.withValues(alpha: 0.5)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('w400 -- REGULAR ITALIC',
                  style: const TextStyle(
                    fontSize: 10,
                    letterSpacing: 1.4,
                    fontWeight: FontWeight.w800,
                    color: _Palette.deepEmber,
                  )),
                const SizedBox(height: 6),
                Text('The press hums softly under the apron.',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.italic,
                    letterSpacing: 0.0,
                    color: _Palette.ink,
                    height: 1.25,
                  )),
                const SizedBox(height: 6),
                Text('Italic relies on the engine selecting the matching italic variant from the registered family.',
                  style: const TextStyle(
                    fontSize: 11,
                    fontStyle: FontStyle.italic,
                    color: _Palette.shadow,
                    height: 1.4,
                  )),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 5),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _Palette.quietPaper,
              border: Border.all(color: _Palette.rule.withValues(alpha: 0.5)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('w500 -- MEDIUM, TIGHT',
                  style: const TextStyle(
                    fontSize: 10,
                    letterSpacing: 1.4,
                    fontWeight: FontWeight.w800,
                    color: _Palette.deepEmber,
                  )),
                const SizedBox(height: 6),
                Text('Headline copy that crowds in close.',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                    letterSpacing: -0.5,
                    color: _Palette.ink,
                    height: 1.25,
                  )),
                const SizedBox(height: 6),
                Text('Negative letterSpacing is cosmetic; never use it for readable body text.',
                  style: const TextStyle(
                    fontSize: 11,
                    fontStyle: FontStyle.italic,
                    color: _Palette.shadow,
                    height: 1.4,
                  )),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 5),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _Palette.quietPaper,
              border: Border.all(color: _Palette.rule.withValues(alpha: 0.5)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('w700 -- BOLD, OPEN',
                  style: const TextStyle(
                    fontSize: 10,
                    letterSpacing: 1.4,
                    fontWeight: FontWeight.w800,
                    color: _Palette.deepEmber,
                  )),
                const SizedBox(height: 6),
                Text('BOLD AND BREATHING ROOM',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                    letterSpacing: 1.2,
                    color: _Palette.ink,
                    height: 1.25,
                  )),
                const SizedBox(height: 6),
                Text('All-caps headings benefit from generous tracking; bold weight balances the wider gaps.',
                  style: const TextStyle(
                    fontSize: 11,
                    fontStyle: FontStyle.italic,
                    color: _Palette.shadow,
                    height: 1.4,
                  )),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 5),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _Palette.quietPaper,
              border: Border.all(color: _Palette.rule.withValues(alpha: 0.5)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('w800 -- EXTRABOLD ITALIC',
                  style: const TextStyle(
                    fontSize: 10,
                    letterSpacing: 1.4,
                    fontWeight: FontWeight.w800,
                    color: _Palette.deepEmber,
                  )),
                const SizedBox(height: 6),
                Text('An emphatic pull-quote.',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    fontStyle: FontStyle.italic,
                    letterSpacing: 0.2,
                    color: _Palette.ink,
                    height: 1.25,
                  )),
                const SizedBox(height: 6),
                Text('Combining heavy weight with italic communicates urgency without shouting.',
                  style: const TextStyle(
                    fontSize: 11,
                    fontStyle: FontStyle.italic,
                    color: _Palette.shadow,
                    height: 1.4,
                  )),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 5),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _Palette.quietPaper,
              border: Border.all(color: _Palette.rule.withValues(alpha: 0.5)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('w900 -- BLACK, DISPLAY',
                  style: const TextStyle(
                    fontSize: 10,
                    letterSpacing: 1.4,
                    fontWeight: FontWeight.w800,
                    color: _Palette.deepEmber,
                  )),
                const SizedBox(height: 6),
                Text('PRINT  RUN  TONIGHT',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    fontStyle: FontStyle.normal,
                    letterSpacing: 2.0,
                    color: _Palette.ink,
                    height: 1.25,
                  )),
                const SizedBox(height: 6),
                Text('Display weight at large size with wide tracking -- ideal for posters or hero banners.',
                  style: const TextStyle(
                    fontSize: 11,
                    fontStyle: FontStyle.italic,
                    color: _Palette.shadow,
                    height: 1.4,
                  )),
              ],
            ),
          ),

          // ==============================================================
          // SECTION 8 -- Memory footprint
          // ==============================================================
          _sectionHeader('08', 'Memory Footprint',
            'Approximate KB sizes for common variant payloads, drawn as proportional bars.'),
          _proseCard(
            'A FontLoader holds nothing heavy itself -- the real cost is the byte '
            'buffer per variant.  Approximate sizes: a single Latin-only TTF '
            'regular variant lands somewhere between 30 and 80 KB; full Latin + '
            'extended Latin + ligatures pushes 120 to 220 KB; CJK fonts can soar '
            'past 5 MB.  Loading every weight in a family multiplies the budget '
            'linearly.  Plan for it: lazily register only the variants the '
            'current screen actually demands, and unload nothing -- the engine '
            'has no public unregister API.'),
          _gap(8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: _Palette.quietPaper,
              border: Border.all(color: _Palette.rule.withValues(alpha: 0.5)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _kbBar('SaffronSerif Regular (Latin)',  64.0,  600.0),
                _kbBar('SaffronSerif Bold (Latin)',     72.0,  600.0),
                _kbBar('SaffronSerif Italic (Latin)',   78.0,  600.0),
                _kbBar('SaffronSerif Bold Italic',      84.0,  600.0),
                _kbBar('EmberSans Regular (Latin Ext)', 138.0, 600.0),
                _kbBar('BrassMono Regular',             92.0,  600.0),
                _kbBar('ApronText Variable (wght axis)',196.0, 600.0),
                _kbBar('RuleDisplay Black',             58.0,  600.0),
                _kbBar('CJK family (single weight)',    520.0, 600.0),
              ],
            ),
          ),
          _gap(8),
          _proseCard(
            'Variable fonts are a special-case win: a single byte payload covers an '
            'entire weight axis (and often optical-size and slant axes too).  One '
            'addFont() call, one variable file, and TextStyle(fontWeight: ...) '
            'interpolates along the axis at zero extra registration cost.'),

          // ==============================================================
          // SECTION 9 -- DO / AVOID callouts
          // ==============================================================
          _sectionHeader('09', 'DO / AVOID Callouts',
            'Eight rules, each tagged DO or AVOID, distilled from real production incidents.'),
          _calloutCard('DO', _Palette.apron, 'Construct FontLoader OUTSIDE build()',
            'Build a FontLoader once -- in initState, in a top-level controller, or in a service. Constructing one inside build() is harmless but wasteful, and accidentally calling load() inside build() is a real bug.'),
          _calloutCard('AVOID', _Palette.accent, 'Do not call load() in a synchronous render path',
            'load() returns a Future that may take hundreds of milliseconds. Awaiting it inside a build is impossible; firing-and-forgetting it from a build leaks work and races first paint.'),
          _calloutCard('DO', _Palette.apron, 'Await load() before first paint of styled text',
            'Gate the screen on the Future. Use FutureBuilder, a splash screen, or a ready flag in your controller. Otherwise the user sees an FOUT (flash of unstyled text) as the family swaps in.'),
          _calloutCard('AVOID', _Palette.accent, 'Do not reuse a FontLoader instance across reloads',
            'FontLoader is a one-shot builder. After load() it is spent. Build a fresh FontLoader if a tenant or theme switch demands a different family or updated bytes.'),
          _calloutCard('DO', _Palette.apron, 'Pick a postscript family name that cannot collide',
            'Prefix with your app or tenant id (e.g. AcmeBrandSans). Collisions with bundled fonts produce silently wrong rendering that QA will miss until the wrong customer sees it.'),
          _calloutCard('AVOID', _Palette.accent, 'Do not register the same family twice with different bytes',
            'The engine will accept the second registration but the result is implementation-defined. Treat the family namespace as immutable for the process lifetime.'),
          _calloutCard('DO', _Palette.apron, 'Surface load() failures in the UI',
            'Wrap load() in try/catch. On failure, log telemetry, fall back to a known-good system family (Roboto, SF Pro, Segoe), and surface a discrete message instead of an empty screen.'),
          _calloutCard('AVOID', _Palette.accent, 'Do not load fonts speculatively at startup',
            'Every kilobyte of font bytes you fetch eagerly delays first paint. Defer non-critical families until the screen that needs them is on the route stack.'),

          // ==============================================================
          // SECTION 10 -- Code recipe cards
          // ==============================================================
          _sectionHeader('10', 'Canonical Recipes',
            'Five copy-paste-ready snippets covering the common entry points.'),
          _codeCard('RECIPE 1 -- rootBundle.load',
            'Future<void> registerFromAssets() async {\n  final loader = FontLoader(\'SaffronSerif\');\n  loader.addFont(rootBundle.load(\'assets/fonts/SaffronSerif-Regular.ttf\'));\n  loader.addFont(rootBundle.load(\'assets/fonts/SaffronSerif-Bold.ttf\'));\n  await loader.load();\n}',
            'Cleanest path. Bytes ship with the app, no network, no cache logic.'),
          _codeCard('RECIPE 2 -- HTTP GET, in-memory',
            'Future<void> registerFromHttp(Uri uri) async {\n  final loader = FontLoader(\'EmberSans\');\n  final res = await http.get(uri);\n  final bytes = ByteData.view(res.bodyBytes.buffer);\n  loader.addFont(Future.value(bytes));\n  await loader.load();\n}',
            'Use for small fonts that the app can refetch cheaply on each cold start.'),
          _codeCard('RECIPE 3 -- Custom asset bundle',
            'Future<void> registerFromBundle(AssetBundle bundle) async {\n  final loader = FontLoader(\'InkRoman\');\n  loader.addFont(bundle.load(\'packages/brand_pack/fonts/InkRoman.ttf\'));\n  await loader.load();\n}',
            'Useful when shipping fonts inside a sibling package; pass the package\'s AssetBundle.'),
          _codeCard('RECIPE 4 -- Web fallback',
            'Future<void> registerWebSafe() async {\n  if (kIsWeb) { /* CSS @font-face is usually preferable on web */\n    return;\n  }\n  final loader = FontLoader(\'BrassMono\');\n  loader.addFont(rootBundle.load(\'assets/fonts/BrassMono.ttf\'));\n  await loader.load();\n}',
            'On web, @font-face hits browser cache better. Keep FontLoader for mobile/desktop.'),
          _codeCard('RECIPE 5 -- Variable font (weight axis)',
            'Future<void> registerVariable() async {\n  final loader = FontLoader(\'ApronText\');\n  loader.addFont(rootBundle.load(\'assets/fonts/ApronText[wght].ttf\'));\n  await loader.load();\n  // Now any TextStyle(fontWeight: FontWeight.wXYZ) interpolates the axis.\n}',
            'One byte payload, every weight. Modern, compact, and well supported on Skia/Impeller.'),

          // ==============================================================
          // SECTION 11 -- Glossary
          // ==============================================================
          _sectionHeader('11', 'Glossary',
            'Twelve terms that recur whenever font loading is discussed.'),
          _glossaryRow('Family',
            'A named group of related typefaces (regular, bold, italic, ...) that share design DNA. Matched at render time by TextStyle.fontFamily.'),
          _glossaryRow('Variant',
            'One specific weight/style combination inside a family, for example Regular, Bold, Italic, Bold-Italic.'),
          _glossaryRow('Postscript name',
            'The internal identifier baked into a font\'s name table. Flutter uses the family-level postscript name to match a fontFamily string.'),
          _glossaryRow('ByteData',
            'Dart\'s typed view over a ByteBuffer. FontLoader.addFont expects a Future that resolves to one of these.'),
          _glossaryRow('AssetBundle',
            'Flutter abstraction over a bag of bytes keyed by string path. rootBundle is the default; tests and packages can supply their own.'),
          _glossaryRow('TTF / OTF',
            'TrueType / OpenType. The two everyday font binary formats. FontLoader accepts both transparently.'),
          _glossaryRow('Variable font',
            'A TTF/OTF that exposes one or more design axes (weight, optical size, slant). A single file replaces a whole variant set.'),
          _glossaryRow('FOUT',
            'Flash of Unstyled Text. The user sees a fallback family flash before your custom font registers. Mitigated by gating first paint on load().'),
          _glossaryRow('Glyph cache',
            'The engine\'s runtime LRU of rasterized glyphs. Loading a new family does not invalidate it; only specific glyphs from the new family populate it as they render.'),
          _glossaryRow('OS/2 table',
            'A table inside every TTF/OTF that declares weight class and italic flag. Flutter reads this to slot variants into the family correctly.'),
          _glossaryRow('Shaper',
            'The engine layer that turns a Unicode string + a font into a sequence of glyph IDs and positions (HarfBuzz on most platforms).'),
          _glossaryRow('Idempotency',
            'Property of an operation that has the same effect whether applied once or many times. FontLoader.load() is intended to be called exactly once per instance.'),

          // ==============================================================
          // SECTION 12 -- Recap footer
          // ==============================================================
          _sectionHeader('12', 'Recap',
            'The whole demo, compressed into one paragraph and a checklist.'),
          _proseCard(
            'FontLoader is a tiny class with a focused job: register a family of '
            'typefaces with the engine after the app has started.  Construct one '
            'with a family name, queue byte futures via addFont(), await load() '
            'exactly once, then trigger a rebuild so existing widgets pick up the '
            'new family via TextStyle.fontFamily.  Treat each instance as a '
            'one-shot builder, gate first paint on the load Future, and surface '
            'failures gracefully instead of letting them silently degrade '
            'typography.  Everything else -- where the bytes come from, how they '
            'are cached, how the family is named -- is application policy.'),
          _gap(6),
          _bulletList(const [
            'Postscript family names are immutable for the process lifetime.',
            'addFont takes a Future; do not pre-resolve unless you need the bytes elsewhere.',
            'load() is an awaitable point; everything before it is synchronous bookkeeping.',
            'Failures are recoverable -- catch, log, fall back, do not crash.',
            'Variable fonts collapse a whole variant set into one byte payload.',
            'Asset bundle for stable brand fonts; network for tenant-specific or user-uploaded fonts.',
            'Never call FontLoader inside build(); construct it in a service or controller.',
            'Idempotency is on you -- track whether load() has already run for a given family.',
          ]),
          _gap(18),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  _Palette.ink,
                  _Palette.deepEmber.withValues(alpha: 0.9),
                ],
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('END OF DEMO -- Letterpress Saffron',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: _Palette.highlight,
                    letterSpacing: 1.4,
                  )),
                const SizedBox(height: 4),
                Text('FontLoader -- a one-shot builder for runtime typography.',
                  style: TextStyle(
                    fontSize: 11,
                    fontStyle: FontStyle.italic,
                    color: _Palette.paper.withValues(alpha: 0.8),
                  )),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

// ============================================================================
// APPENDIX A -- Extended notes on FontLoader internals
// ----------------------------------------------------------------------------
// The text below is intentionally verbose; it serves as embedded reference
// material for engineers reading this demo as a learning exercise.  Nothing
// in the appendix participates in the rendered widget tree.
// ============================================================================
//
// FontLoader's surface is small for a reason: its job is to be a thin, predictable adapter between Dart-level byte streams and the engine's native font registry. Every implementation detail that could leak into the API has been deliberately hidden -- shaper choice, glyph cache eviction policy, mmap vs heap copy of the byte buffer -- so that the same FontLoader code keeps working as the underlying engine evolves from Skia to Impeller and from CoreText to FreeType to DirectWrite.
//
// When you call addFont(future), the FontLoader stores the future in a private list. It does not start awaiting it -- that responsibility is deferred to load(). This matters: you can fire several addFont() calls back to back, even with futures that have not yet been initiated, and the FontLoader will still cope. The eventual await happens once, in load(), in a Future.wait pattern across all enqueued bytes.
//
// load() is implemented in terms of a platform channel call to dart:ui's loadFontFromList. Each variant's bytes are passed across the channel one at a time, and the engine parses each, slots it into the family namespace, and returns. If any single parse fails, load() typically completes with an error, but the exact semantics of partial success are implementation-defined and have shifted between Flutter releases. Treat the operation as atomic from the application's perspective: either the whole family registers or none of it does.
//
// Because load() is a Future<void>, there is no return value to inspect. Success or failure is signalled purely by whether the Future completes normally or with an error. Some teams wrap FontLoader in a small service that records a Map<String, FontLoadState> so that the rest of the app can ask, synchronously, whether a family is ready -- this is a useful pattern, and one we recommend for any app that loads more than two or three families.
//
// On hot reload, the engine retains all previously registered families. This is usually convenient -- your loaded fonts survive across edits -- but it can mask bugs in your initial load logic. If you change the family name during development, restart cold so the stale name is purged from the engine.
//
// Memory pressure is the single biggest reason to be selective about what you load. A typical Latin-only TTF is 60-80 KB, a Latin Extended TTF is 120-200 KB, and a CJK family can run into single-digit megabytes per variant. The engine retains the parsed font tables for the process lifetime, so loading a large family early in startup raises your steady-state RSS for the duration of the app session. Profile with Flutter DevTools' memory view before and after a load() to confirm the cost is acceptable.
//
// Variable fonts are a clean win when supported. One file, one addFont(), one load(), and the engine interpolates along the requested axes at draw time. Modern Flutter renders variable fonts on every supported platform, including web (subject to browser support, which is now near-universal).
//
// Subsetting -- shipping only the glyphs your app actually uses -- is an offline tool concern, not a FontLoader concern. Use pyftsubset or a CDN with on-the-fly subsetting to shrink the byte payload before the bytes ever reach addFont(). FontLoader treats the bytes as opaque; it does not subset on the fly.
//
// WOFF2 is not directly supported by FontLoader. If your CDN serves WOFF2, decompress to TTF or OTF before calling addFont(), or use a CDN endpoint that emits TTF for non-web targets. Web targets typically bypass FontLoader entirely in favour of CSS @font-face, where browsers handle WOFF2 natively.
//
// Right-to-left and complex shaping (Arabic, Devanagari, Thai) work transparently as long as the font you load contains the necessary GSUB/GPOS tables. If you see broken ligatures or wrong joining behaviour after a load(), the issue is almost always with the font file itself, not with FontLoader.
//
// Emoji fonts deserve a special note: they are usually shipped by the platform and overriding them via FontLoader is rarely a good idea. If you do load a custom emoji font, expect inconsistencies between platforms, since Apple, Google, and Microsoft each ship slightly different shaping rules around emoji sequences.
//
// Testing a FontLoader-driven flow end to end is awkward because the test runner has no real engine. Common strategies: factor the registration into a service interface, mock the service in widget tests, and verify that consumers correctly gate on the ready future. The byte-level happy path is best covered by an integration test on a real device.
//
// There is no public unregister API. Families live for the process lifetime. If your app legitimately needs to swap fonts (e.g. a multi-tenant design tool), pick distinct family names per tenant rather than trying to replace bytes under an existing name.
//
// The engine's font matching is case-sensitive on the family string. 'SaffronSerif' and 'saffronserif' are different families. Pick a single canonical casing for each family and stick to it everywhere -- pubspec, FontLoader, TextStyle.
//
// If your app is a plugin host, plugins should not register fonts directly into the host's family namespace without coordination. A common pattern is to namespace plugin fonts with a plugin-specific prefix (e.g. 'plugin_acme.HeaderSans') so that two plugins cannot collide.
//
// ============================================================================
// APPENDIX B -- Comparison with declarative pubspec fonts
// ============================================================================
//
// pubspec.yaml fonts: are evaluated at build time. They are bundled into the app binary, registered automatically on engine init, and consume zero application code beyond a TextStyle.fontFamily reference. They are the right choice for any font that does not need to vary per user, per tenant, or per network condition.
//
// FontLoader fonts are evaluated at runtime. They cost code, they cost a Future, and they can fail in ways that pubspec fonts cannot. They are the right choice precisely when the bytes cannot be known at build time: brand servers, CDN-hosted typography, user uploads, license-gated typefaces.
//
// Mixed setups are common: ship a small set of essential fonts via pubspec for first paint, then layer additional families on top via FontLoader once the user is past the splash screen. This pattern keeps cold start fast while still allowing rich typography for the rest of the session.
//
// If you find yourself wanting to swap a pubspec-declared font's bytes at runtime, you almost certainly want a different family name in your TextStyle, registered via FontLoader, rather than trying to replace the pubspec entry. Treat pubspec fonts as immutable at runtime.
//
// There is no inherent precedence between pubspec-declared and FontLoader-registered families when names collide -- behaviour is implementation-defined and varies across engine versions. The safe rule: never have a pubspec family and a FontLoader family share a name.
//
// When debugging which font is actually being rendered, the simplest tool is a deliberate fallback chain: list a dummy family first, then your real family. If the text renders in the dummy family, the real one did not register. This trick has saved more debugging hours than any tracing tool.
//
// ============================================================================
// APPENDIX C -- Failure mode catalogue
// ============================================================================
//
// F-01  Network timeout during fetch.  http.get(uri) never resolves; the addFont future is therefore never satisfied; load() awaits forever.  Fix: wrap the fetch in Future.timeout(...) and convert timeouts into a logged error before they reach addFont().
//
// F-02  Corrupt TTF bytes.  load() completes with an error from the engine.  Fix: try/catch around await loader.load(); on error, fall back to a known-good system family and surface the failure in your error reporting pipeline.
//
// F-03  Wrong Content-Type from CDN.  Some intermediaries replace bytes with HTML error pages.  Symptom: load() error mentions invalid font tables.  Fix: assert response.statusCode == 200 and (optionally) magic-byte-check the first four bytes for 0x00010000 (TTF) or 'OTTO' (OTF) before calling addFont().
//
// F-04  Family name typo.  load() succeeds; text renders in fallback family.  Fix: centralize family-name string constants in one file; never inline the literal in TextStyle.
//
// F-05  Missing OS/2 table in custom font.  Variants register but TextStyle(fontWeight: ...) does not select the right one.  Fix: re-export the font with a tool that produces a full OS/2 table (FontForge, fonttools).
//
// F-06  Race between load() and first paint.  Some users see FOUT, others do not, depending on network speed.  Fix: gate the styled text widget on a FutureBuilder fed by the load() future.
//
// F-07  Double load on hot restart.  In dev, the FontLoader instance is recreated; an over-eager caller calls load() again on what used to be a fresh family but is now a known one.  Fix: track ready state in a service and skip redundant loads.
//
// F-08  Memory bloat from many tenants.  In a multi-tenant app, every tenant switch loads a new family but never releases the previous one.  Fix: bound the number of active tenant fonts; when the cap is hit, accept the cost of the leak or restart the isolate.
//
// F-09  Asset path typo on cold start.  rootBundle.load throws synchronously; the addFont future never enqueues.  Fix: assert the asset exists with rootBundle.loadString or a manifest check during a startup self-test.
//
// F-10  Mismatched weight axis on variable font.  TextStyle(fontWeight: FontWeight.w900) renders at w400 because the font's axis maxes out at 700.  Fix: clamp requested weights to the axis range, ideally documenting the supported range alongside the family constant.
//
// ============================================================================
// APPENDIX D -- Anti-pattern catalogue
// ============================================================================
//
// AP-01  Fire-and-forget load() inside build().  Every frame schedules another load.  Tax: linear memory growth and engine warnings.  Cure: hoist the call into initState or a top-level controller.
//
// AP-02  String-typed family names sprinkled across the codebase.  One typo away from a silent fallback.  Cure: declare const String kSaffronSerif = 'SaffronSerif'; in a fonts.dart and import everywhere.
//
// AP-03  Awaiting load() from main() before runApp().  Cold start blocks on a network round-trip.  Cure: register fonts asynchronously after first paint; show a splash skin in your initial widget.
//
// AP-04  Wrapping every Text widget in a FutureBuilder over load().  Frame budget vanishes.  Cure: hoist the FutureBuilder to the screen root or to the MaterialApp.
//
// AP-05  Silently swallowing load() errors.  Users see a broken UI; engineers see nothing.  Cure: log and surface; show a polite fallback message if the family is critical.
//
// AP-06  Reusing a single FontLoader instance for multiple families by calling addFont with mismatched bytes.  All variants land under one name.  Cure: one FontLoader per family, always.
//
// AP-07  Loading the same family in multiple places.  Bytes register twice; behaviour is implementation-defined.  Cure: a single registration service with a Map<String, Future<void>> keyed by family name.
//
// AP-08  Treating load() as cancellable.  It is not.  Cure: design the load to be small, fast, and unconditional; if you would want to cancel it, you should not have started it.
//
// AP-09  Assuming addFont preserves order.  The engine treats variants as a set; weight/italic come from the font tables themselves, not from call order.  Cure: trust the OS/2 tables, never the order.
//
// AP-10  Calling addFont after load.  Behaviour is undefined and varies between engine versions.  Cure: build a fresh FontLoader for the new variant and register it under a distinct family name if needed.
//
// ============================================================================
// APPENDIX E -- Pseudocode of the engine-side flow
// ============================================================================
//
//   loader = new FontLoader('SaffronSerif')
//     -> store family name, allocate empty list of byte futures
//
//   loader.addFont(byteFuture)  // called N times
//     -> append byteFuture to internal list
//     -> return synchronously
//
//   await loader.load()
//     -> Future.wait(internalList)            (await all byte futures)
//     -> for each resolved ByteData:
//          channel.invoke('loadFontFromList',
//            { 'familyName': self.family,
//              'bytes':       byteData })
//     -> engine: parse font tables, register variant under family name
//     -> resolve outer Future<void>
//
//   TextStyle(fontFamily: 'SaffronSerif')
//     -> render path: shaper looks up family in registry -> hit -> use new font
//
// ============================================================================
// APPENDIX F -- Frequently asked questions
// ============================================================================
//
// Q: Can I unload a font?
// A: No. The engine has no public unregister API. Plan family names so this never matters.
//
// Q: Can I rename a family after load()?
// A: No. Build a new FontLoader with the new name and register the bytes again.
//
// Q: Can I share one FontLoader between two families?
// A: No. The family is set in the constructor and is immutable.
//
// Q: Do I need to await load() before EVERY use of TextStyle.fontFamily?
// A: Only before the first use after registration. Once load() resolves, the family is available for the process lifetime.
//
// Q: Does load() block the UI?
// A: No. It is an async call. The platform channel work happens off the platform thread; your Dart code awaits a Future.
//
// Q: What happens if I render TextStyle.fontFamily before load() completes?
// A: The engine renders the fallback family. After load(), you must trigger a rebuild to repaint with the new family.
//
// Q: Is FontLoader available on web?
// A: Yes, but CSS @font-face is generally preferable on web. FontLoader on web uses the FontFace JS API under the hood.
//
// Q: Can I introspect which families are loaded?
// A: There is no public API to list registered families. Track them yourself in a small service.
//
// Q: Does FontLoader work in a background isolate?
// A: load() must run on an isolate that has a binding to the engine. In practice this means the root isolate or a UI isolate, not a plain compute isolate.
//
// Q: How do I unit-test code that uses FontLoader?
// A: Wrap registration in a service interface, inject a fake in tests, and assert that the fake was called with the expected family name and number of variants.
//
// ============================================================================
// APPENDIX G -- Style guide for family naming
// ============================================================================
//
// G-01  Use PascalCase for the family name itself: SaffronSerif, EmberSans.
// G-02  Prefix with an app or tenant identifier when collisions are possible: AcmeBrandSans, BrandX_DisplayBold.
// G-03  Never include weight or style in the family name; let the OS/2 table handle that. Bad: 'SaffronSerifBold'. Good: 'SaffronSerif'.
// G-04  Keep family names ASCII; some platforms misbehave with non-ASCII font names.
// G-05  Document the canonical name in a single Dart constant; reference that constant everywhere.
// G-06  When migrating from a pubspec-declared font to a FontLoader-registered one, change the family name. Do not try to keep the same name; the migration is cleaner with a fresh namespace.
// G-07  Avoid family names that look like system fonts: do not name your family 'Roboto' or 'San Francisco'.
// G-08  If you ship a font in multiple optical sizes, do not embed the size in the name; use a variable font with the opsz axis instead.
// G-09  Reserve a 'Fallback' family that you always have ready, so any failed load() can degrade gracefully to a known family.
// G-10  In multi-tenant apps, version the family name when bytes change: 'AcmeBrandSans_v2', so cached state cannot stale-serve old bytes under the new name.
//
// ============================================================================
// APPENDIX H -- Closing notes
// ============================================================================
//
// FontLoader rewards engineers who treat it as boring infrastructure.  The
// less clever you are with it, the more reliable your typography will be.
// Build a service, register fonts at predictable lifecycle points, gate the
// UI on a known-good Future, and surface failures honestly.  The rest is
// just bytes.  May your saffron serifs ink crisply.
//
// -- end of FontLoader deep demo --
