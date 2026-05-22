// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

/// Design plan for the TextStyle deep visual demo.
///
/// This script is a hand-authored visual gallery for `TextStyle` in the
/// `painting` library. It is intended to exercise the D4rt AST runner with a
/// representative real-world widget tree that uses the TextStyle API broadly.
///
/// Layout (each section prints a banner and renders real widgets):
///   1. Header gradient banner + intro card.
///   2. Constructor overview cards (default, named, inherited).
///   3. FontWeight swatch (w100..w900) rendered as labelled tiles.
///   4. FontStyle (normal vs italic) and fontSize ramp 10..40.
///   5. Color, backgroundColor and contrast tiles.
///   6. letterSpacing and wordSpacing visualisations (positive / negative).
///   7. height + leadingDistribution comparison panels.
///   8. TextDecoration variants combined with TextDecorationStyle and color.
///   9. Shadows on text (single / multi / soft / hard).
///  10. fontFeatures rows (tnum, ss01, smcp examples as label rows).
///  11. debugLabel, copyWith, merge, apply, lerp ramp demos.
///  12. getTextStyle bridging note + glossary / recipes footer.
///
/// The root widget is a StatelessWidget that returns a MaterialApp with a
/// Scaffold + SingleChildScrollView + Column. Material 3 ColorScheme idioms
/// (primary/secondary/tertiary/error containers) are used throughout.
///
/// No async work, no Timers, no Navigator pushes, no showDialog. Everything is
/// rendered inline so the AST runner can take a single static snapshot.

void main() => runApp(const TextStyleDemoApp());

class TextStyleDemoApp extends StatelessWidget {
  const TextStyleDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    print('TextStyle Deep Demo executing');
    final scheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF3949AB),
      brightness: Brightness.light,
    );
    final theme = ThemeData(colorScheme: scheme, useMaterial3: true);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: Scaffold(
        backgroundColor: scheme.surface,
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: _buildSections(scheme),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildSections(ColorScheme scheme) {
    final children = <Widget>[];

    // ----- Header banner -----
    print('=== Section 1: Header banner and intro ===');
    children.add(_buildHeaderBanner(scheme));
    children.add(const SizedBox(height: 28.0));
    children.add(_buildIntroCard(scheme));
    children.add(const SizedBox(height: 32.0));

    // ----- Section 2: Constructors -----
    print('=== Section 2: TextStyle constructors overview ===');
    children.add(_sectionTitle('2. Constructor Overview', scheme));
    children.add(const SizedBox(height: 12.0));
    children.add(_buildConstructorCards(scheme));
    children.add(const SizedBox(height: 32.0));

    // ----- Section 3: FontWeight swatch -----
    print('=== Section 3: FontWeight swatch (w100..w900) ===');
    children.add(_sectionTitle('3. FontWeight Swatch', scheme));
    children.add(const SizedBox(height: 12.0));
    children.add(_buildFontWeightSwatch(scheme));
    children.add(const SizedBox(height: 32.0));

    // ----- Section 4: FontStyle + size ramp -----
    print('=== Section 4: FontStyle and font size ramp ===');
    children.add(_sectionTitle('4. FontStyle and FontSize Ramp', scheme));
    children.add(const SizedBox(height: 12.0));
    children.add(_buildFontStyleCompare(scheme));
    children.add(const SizedBox(height: 16.0));
    children.add(_buildFontSizeRamp(scheme));
    children.add(const SizedBox(height: 32.0));

    // ----- Section 5: Colors -----
    print('=== Section 5: Color and backgroundColor tiles ===');
    children.add(_sectionTitle('5. Color and Background', scheme));
    children.add(const SizedBox(height: 12.0));
    children.add(_buildColorTiles(scheme));
    children.add(const SizedBox(height: 32.0));

    // ----- Section 6: Spacing -----
    print('=== Section 6: letterSpacing and wordSpacing ===');
    children.add(_sectionTitle('6. Letter and Word Spacing', scheme));
    children.add(const SizedBox(height: 12.0));
    children.add(_buildLetterSpacingPanel(scheme));
    children.add(const SizedBox(height: 16.0));
    children.add(_buildWordSpacingPanel(scheme));
    children.add(const SizedBox(height: 32.0));

    // ----- Section 7: Height and leadingDistribution -----
    print('=== Section 7: height and leadingDistribution ===');
    children.add(_sectionTitle('7. Line Height and Leading', scheme));
    children.add(const SizedBox(height: 12.0));
    children.add(_buildHeightPanel(scheme));
    children.add(const SizedBox(height: 16.0));
    children.add(_buildLeadingDistributionPanel(scheme));
    children.add(const SizedBox(height: 32.0));

    // ----- Section 8: Decoration -----
    print('=== Section 8: TextDecoration variants ===');
    children.add(_sectionTitle('8. Decoration Variants', scheme));
    children.add(const SizedBox(height: 12.0));
    children.add(_buildDecorationGrid(scheme));
    children.add(const SizedBox(height: 32.0));

    // ----- Section 9: Shadows -----
    print('=== Section 9: Shadows on text ===');
    children.add(_sectionTitle('9. Text Shadows', scheme));
    children.add(const SizedBox(height: 12.0));
    children.add(_buildShadowsPanel(scheme));
    children.add(const SizedBox(height: 32.0));

    // ----- Section 10: fontFeatures -----
    print('=== Section 10: fontFeatures rows ===');
    children.add(_sectionTitle('10. Font Features', scheme));
    children.add(const SizedBox(height: 12.0));
    children.add(_buildFontFeaturesPanel(scheme));
    children.add(const SizedBox(height: 32.0));

    // ----- Section 11: copyWith / merge / apply / lerp -----
    print('=== Section 11: copyWith, merge, apply, lerp ===');
    children.add(_sectionTitle('11. Transformations', scheme));
    children.add(const SizedBox(height: 12.0));
    children.add(_buildCopyWithPanel(scheme));
    children.add(const SizedBox(height: 16.0));
    children.add(_buildMergePanel(scheme));
    children.add(const SizedBox(height: 16.0));
    children.add(_buildApplyPanel(scheme));
    children.add(const SizedBox(height: 16.0));
    children.add(_buildLerpRamp(scheme));
    children.add(const SizedBox(height: 32.0));

    // ----- Section 12: Glossary -----
    print('=== Section 12: getTextStyle bridging note + glossary ===');
    children.add(_sectionTitle('12. Glossary and Recipes', scheme));
    children.add(const SizedBox(height: 12.0));
    children.add(_buildBridgingNote(scheme));
    children.add(const SizedBox(height: 16.0));
    children.add(_buildGlossary(scheme));
    children.add(const SizedBox(height: 16.0));
    children.add(_buildRecipes(scheme));
    children.add(const SizedBox(height: 24.0));

    print('TextStyle Deep Demo build complete');
    return children;
  }

  // ============================================================
  // Header
  // ============================================================
  Widget _buildHeaderBanner(ColorScheme scheme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 28.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [scheme.primary, scheme.tertiary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18.0),
        boxShadow: [
          BoxShadow(
            color: scheme.primary.withOpacity(0.35),
            blurRadius: 18.0,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.text_fields, color: scheme.onPrimary, size: 40.0),
              const SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'TextStyle Deep Demo',
                      style: TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.w800,
                        color: scheme.onPrimary,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      'A hand-authored gallery of painting.TextStyle',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: scheme.onPrimary.withOpacity(0.85),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: [
              _chip('weights', Icons.line_weight, scheme.onPrimary),
              _chip('decoration', Icons.format_underlined, scheme.onPrimary),
              _chip('shadows', Icons.filter_drama, scheme.onPrimary),
              _chip('features', Icons.tune, scheme.onPrimary),
              _chip('copyWith', Icons.copy_all, scheme.onPrimary),
              _chip('lerp', Icons.linear_scale, scheme.onPrimary),
            ],
          ),
        ],
      ),
    );
  }

  Widget _chip(String label, IconData icon, Color fg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: fg.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: fg.withOpacity(0.4), width: 1.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: fg, size: 14.0),
          const SizedBox(width: 6.0),
          Text(
            label,
            style: TextStyle(
              color: fg,
              fontSize: 12.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIntroCard(ColorScheme scheme) {
    return Container(
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        color: scheme.secondaryContainer,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: scheme.secondary.withOpacity(0.4)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.menu_book, color: scheme.onSecondaryContainer, size: 28.0),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'What is TextStyle?',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16.0,
                    color: scheme.onSecondaryContainer,
                  ),
                ),
                const SizedBox(height: 6.0),
                Text(
                  'TextStyle describes how text should be drawn: family, size, '
                  'weight, color, spacing, decoration, shadows and OpenType '
                  'features. It is immutable; transformations return new '
                  'instances via copyWith, merge, apply and lerp.',
                  style: TextStyle(
                    fontSize: 13.0,
                    color: scheme.onSecondaryContainer.withOpacity(0.88),
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String label, ColorScheme scheme) {
    return Row(
      children: [
        Container(
          width: 6.0,
          height: 24.0,
          decoration: BoxDecoration(
            color: scheme.primary,
            borderRadius: BorderRadius.circular(3.0),
          ),
        ),
        const SizedBox(width: 10.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w700,
            color: scheme.onSurface,
            letterSpacing: -0.2,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // Section 2: Constructors
  // ============================================================
  Widget _buildConstructorCards(ColorScheme scheme) {
    const defaultStyle = TextStyle();
    const namedStyle = TextStyle(
      fontFamily: 'Roboto',
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      color: Color(0xFF1A237E),
    );
    const inheritedStyle = TextStyle(
      inherit: false,
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Color(0xFF1B5E20),
      decoration: TextDecoration.none,
    );

    final cards = <Widget>[
      _constructorCard(
        title: 'Default',
        description: 'const TextStyle()',
        sample: const Text('AaBb 123', style: TextStyle(fontSize: 18.0)),
        details: 'No fields set; inherits from DefaultTextStyle.',
        color: scheme.primaryContainer,
        onColor: scheme.onPrimaryContainer,
        icon: Icons.text_format,
      ),
      _constructorCard(
        title: 'Named fields',
        description: 'TextStyle(fontFamily: ..., fontSize: 16, ...)',
        sample: const Text('AaBb 123', style: namedStyle),
        details: 'Common case: pass only the fields you care about.',
        color: scheme.tertiaryContainer,
        onColor: scheme.onTertiaryContainer,
        icon: Icons.tune,
      ),
      _constructorCard(
        title: 'inherit: false',
        description: 'TextStyle(inherit: false, ...)',
        sample: const Text('AaBb 123', style: inheritedStyle),
        details: 'Standalone style; nothing flows in from DefaultTextStyle.',
        color: scheme.secondaryContainer,
        onColor: scheme.onSecondaryContainer,
        icon: Icons.block,
      ),
    ];

    print('default fontSize: ${defaultStyle.fontSize}');
    print('named fontSize: ${namedStyle.fontSize}');
    print('inherited.inherit: ${inheritedStyle.inherit}');

    return Wrap(
      spacing: 12.0,
      runSpacing: 12.0,
      children: cards,
    );
  }

  Widget _constructorCard({
    required String title,
    required String description,
    required Widget sample,
    required String details,
    required Color color,
    required Color onColor,
    required IconData icon,
  }) {
    return Container(
      width: 260.0,
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18.0, color: onColor),
              const SizedBox(width: 8.0),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w700,
                  color: onColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 8.0, vertical: 6.0),
            decoration: BoxDecoration(
              color: onColor.withOpacity(0.08),
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Text(
              description,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.0,
                color: onColor,
              ),
            ),
          ),
          const SizedBox(height: 12.0),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.55),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Center(child: sample),
          ),
          const SizedBox(height: 10.0),
          Text(
            details,
            style: TextStyle(
              fontSize: 11.5,
              color: onColor.withOpacity(0.85),
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // Section 3: FontWeight swatch
  // ============================================================
  Widget _buildFontWeightSwatch(ColorScheme scheme) {
    final weights = <_NamedWeight>[
      const _NamedWeight('w100', FontWeight.w100, 'Thin'),
      const _NamedWeight('w200', FontWeight.w200, 'ExtraLight'),
      const _NamedWeight('w300', FontWeight.w300, 'Light'),
      const _NamedWeight('w400', FontWeight.w400, 'Regular'),
      const _NamedWeight('w500', FontWeight.w500, 'Medium'),
      const _NamedWeight('w600', FontWeight.w600, 'SemiBold'),
      const _NamedWeight('w700', FontWeight.w700, 'Bold'),
      const _NamedWeight('w800', FontWeight.w800, 'ExtraBold'),
      const _NamedWeight('w900', FontWeight.w900, 'Black'),
    ];

    final tiles = <Widget>[];
    for (var i = 0; i < weights.length; i++) {
      final w = weights[i];
      final t = i / (weights.length - 1);
      final bg = Color.lerp(
          scheme.primaryContainer, scheme.tertiaryContainer, t)!;
      tiles.add(
        Container(
          width: 120.0,
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: scheme.outlineVariant),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                w.code,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: scheme.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                w.name,
                style: TextStyle(
                  fontSize: 11.0,
                  color: scheme.onSurfaceVariant.withOpacity(0.75),
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                'Ag',
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: w.weight,
                  color: scheme.onSurface,
                  height: 1.0,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                'Quick brown',
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: w.weight,
                  color: scheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Wrap(spacing: 10.0, runSpacing: 10.0, children: tiles);
  }

  // ============================================================
  // Section 4: FontStyle + size ramp
  // ============================================================
  Widget _buildFontStyleCompare(ColorScheme scheme) {
    return Row(
      children: [
        Expanded(
          child: _fontStyleCell(
            label: 'FontStyle.normal',
            style: const TextStyle(
              fontSize: 22.0,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w500,
            ),
            scheme: scheme,
          ),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: _fontStyleCell(
            label: 'FontStyle.italic',
            style: const TextStyle(
              fontSize: 22.0,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w500,
            ),
            scheme: scheme,
          ),
        ),
      ],
    );
  }

  Widget _fontStyleCell({
    required String label,
    required TextStyle style,
    required ColorScheme scheme,
  }) {
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 11.5,
              color: scheme.onSurfaceVariant,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            'The pen is mightier than the keyboard.',
            style: style.copyWith(color: scheme.onSurface),
          ),
        ],
      ),
    );
  }

  Widget _buildFontSizeRamp(ColorScheme scheme) {
    final sizes = <double>[10.0, 12.0, 14.0, 16.0, 20.0, 24.0, 32.0, 40.0];
    final rows = <Widget>[];
    for (final s in sizes) {
      rows.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 50.0,
                child: Text(
                  '${s.toInt()}pt',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12.0,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'TextStyle(fontSize: $s)',
                  style: TextStyle(fontSize: s, color: scheme.onSurface),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      );
    }
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: rows,
      ),
    );
  }

  // ============================================================
  // Section 5: Colors
  // ============================================================
  Widget _buildColorTiles(ColorScheme scheme) {
    final palette = <Color>[
      scheme.primary,
      scheme.secondary,
      scheme.tertiary,
      scheme.error,
      const Color(0xFF6D4C41),
      const Color(0xFF455A64),
    ];
    final tiles = <Widget>[];
    for (final c in palette) {
      tiles.add(
        _colorTile(
          fg: c,
          bg: scheme.surface,
          label: 'color',
          sample:
              'fg #${c.value.toRadixString(16).padLeft(8, '0').substring(2)}',
          scheme: scheme,
        ),
      );
    }
    for (final c in palette) {
      tiles.add(
        _colorTile(
          fg: _readableOn(c),
          bg: c,
          label: 'bg',
          sample: 'background',
          scheme: scheme,
        ),
      );
    }
    return Wrap(
      spacing: 10.0,
      runSpacing: 10.0,
      children: tiles,
    );
  }

  Color _readableOn(Color c) {
    final lum = (0.299 * c.red + 0.587 * c.green + 0.114 * c.blue) / 255.0;
    return lum > 0.55 ? Colors.black : Colors.white;
  }

  Widget _colorTile({
    required Color fg,
    required Color bg,
    required String label,
    required String sample,
    required ColorScheme scheme,
  }) {
    return Container(
      width: 150.0,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 10.0,
              fontFamily: 'monospace',
              color: fg.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            'Aa Bb 0123',
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.w700,
              color: fg,
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            sample,
            style: TextStyle(fontSize: 11.0, color: fg.withOpacity(0.85)),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // Section 6: Spacing
  // ============================================================
  Widget _buildLetterSpacingPanel(ColorScheme scheme) {
    final values = <double>[-1.0, 0.0, 1.0, 2.0, 4.0, 8.0];
    final rows = <Widget>[];
    for (final v in values) {
      rows.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            children: [
              SizedBox(
                width: 70.0,
                child: Text(
                  '${v.toStringAsFixed(1)} px',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12.0,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  'AVALANCHE typography',
                  style: TextStyle(
                    fontSize: 18.0,
                    letterSpacing: v,
                    color: scheme.onSurface,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return _bordered(
      scheme: scheme,
      title: 'letterSpacing',
      subtitle: 'space added between each glyph (logical px)',
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, children: rows),
    );
  }

  Widget _buildWordSpacingPanel(ColorScheme scheme) {
    final values = <double>[-2.0, 0.0, 4.0, 8.0, 16.0];
    final rows = <Widget>[];
    for (final v in values) {
      rows.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            children: [
              SizedBox(
                width: 70.0,
                child: Text(
                  '${v.toStringAsFixed(1)} px',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12.0,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  'The lazy dog sleeps in the warm sun',
                  style: TextStyle(
                    fontSize: 15.0,
                    wordSpacing: v,
                    color: scheme.onSurface,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return _bordered(
      scheme: scheme,
      title: 'wordSpacing',
      subtitle: 'extra space inserted at each word boundary',
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, children: rows),
    );
  }

  // ============================================================
  // Section 7: Height / leading
  // ============================================================
  Widget _buildHeightPanel(ColorScheme scheme) {
    final heights = <double>[1.0, 1.2, 1.5, 2.0];
    final cards = <Widget>[];
    for (final h in heights) {
      cards.add(
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: scheme.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: scheme.outlineVariant),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'height: $h',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11.0,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Three\nshort\nlines',
                  style: TextStyle(
                    fontSize: 14.0,
                    height: h,
                    color: scheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return _bordered(
      scheme: scheme,
      title: 'height',
      subtitle: 'line height as a multiple of fontSize',
      child: Row(children: cards),
    );
  }

  Widget _buildLeadingDistributionPanel(ColorScheme scheme) {
    final variants = <_LeadingVariant>[
      const _LeadingVariant(
        label: 'proportional',
        value: ui.TextLeadingDistribution.proportional,
      ),
      const _LeadingVariant(
        label: 'even',
        value: ui.TextLeadingDistribution.even,
      ),
    ];
    final cells = <Widget>[];
    for (final v in variants) {
      cells.add(
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: scheme.surfaceContainerLow,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: scheme.outlineVariant),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'leadingDistribution.${v.label}',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11.0,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Adjusts where extra leading goes above vs below the line.',
                  style: TextStyle(
                    fontSize: 14.0,
                    height: 1.6,
                    leadingDistribution: v.value,
                    color: scheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return _bordered(
      scheme: scheme,
      title: 'leadingDistribution',
      subtitle: 'controls vertical placement of leading',
      child: Row(children: cells),
    );
  }

  // ============================================================
  // Section 8: Decoration
  // ============================================================
  Widget _buildDecorationGrid(ColorScheme scheme) {
    final decorations = <_DecorationCase>[
      _DecorationCase('underline solid', TextDecoration.underline,
          TextDecorationStyle.solid, scheme.primary),
      _DecorationCase('underline dashed', TextDecoration.underline,
          TextDecorationStyle.dashed, scheme.tertiary),
      _DecorationCase('underline dotted', TextDecoration.underline,
          TextDecorationStyle.dotted, scheme.secondary),
      _DecorationCase('underline double', TextDecoration.underline,
          TextDecorationStyle.double, scheme.error),
      _DecorationCase('underline wavy', TextDecoration.underline,
          TextDecorationStyle.wavy, scheme.primary),
      _DecorationCase('overline solid', TextDecoration.overline,
          TextDecorationStyle.solid, scheme.tertiary),
      _DecorationCase('overline wavy', TextDecoration.overline,
          TextDecorationStyle.wavy, scheme.secondary),
      _DecorationCase('lineThrough solid', TextDecoration.lineThrough,
          TextDecorationStyle.solid, scheme.error),
      _DecorationCase('lineThrough dashed', TextDecoration.lineThrough,
          TextDecorationStyle.dashed, scheme.primary),
      _DecorationCase(
        'combined',
        TextDecoration.combine(<TextDecoration>[
          TextDecoration.underline,
          TextDecoration.lineThrough,
        ]),
        TextDecorationStyle.solid,
        scheme.tertiary,
      ),
    ];

    final tiles = <Widget>[];
    for (final d in decorations) {
      tiles.add(
        Container(
          width: 230.0,
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: scheme.surfaceContainer,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: scheme.outlineVariant),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                d.label,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: scheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                'Sample heading',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: scheme.onSurface,
                  decoration: d.decoration,
                  decorationStyle: d.style,
                  decorationColor: d.color,
                  decorationThickness: 2.0,
                ),
              ),
            ],
          ),
        ),
      );
    }
    return Wrap(spacing: 10.0, runSpacing: 10.0, children: tiles);
  }

  // ============================================================
  // Section 9: Shadows
  // ============================================================
  Widget _buildShadowsPanel(ColorScheme scheme) {
    final cases = <_ShadowCase>[
      _ShadowCase(
        label: 'single soft',
        shadows: const [
          Shadow(
              blurRadius: 6.0, color: Colors.black54, offset: Offset(2, 2)),
        ],
      ),
      _ShadowCase(
        label: 'sharp drop',
        shadows: const [
          Shadow(
              blurRadius: 0.0, color: Colors.black87, offset: Offset(3, 3)),
        ],
      ),
      _ShadowCase(
        label: 'glow',
        shadows: [
          Shadow(blurRadius: 12.0, color: scheme.primary.withOpacity(0.8)),
          Shadow(blurRadius: 4.0, color: scheme.primary),
        ],
      ),
      _ShadowCase(
        label: 'double offset',
        shadows: const [
          Shadow(blurRadius: 0.0, color: Colors.red, offset: Offset(-2, 0)),
          Shadow(blurRadius: 0.0, color: Colors.blue, offset: Offset(2, 0)),
        ],
      ),
      _ShadowCase(
        label: 'long cast',
        shadows: [
          for (var i = 1; i <= 6; i++)
            Shadow(
              blurRadius: 0.0,
              color: Colors.grey.withOpacity(0.18 * (7 - i)),
              offset: Offset(i.toDouble(), i.toDouble()),
            ),
        ],
      ),
      _ShadowCase(
        label: 'paper press',
        shadows: const [
          Shadow(blurRadius: 1.0, color: Colors.white, offset: Offset(0, -1)),
          Shadow(blurRadius: 2.0, color: Colors.black38, offset: Offset(0, 2)),
        ],
      ),
    ];
    final tiles = <Widget>[];
    for (final c in cases) {
      tiles.add(
        Container(
          width: 220.0,
          height: 120.0,
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: scheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: scheme.outlineVariant),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                c.label,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: scheme.onSurfaceVariant,
                ),
              ),
              const Spacer(),
              Center(
                child: Text(
                  'Glyph',
                  style: TextStyle(
                    fontSize: 36.0,
                    fontWeight: FontWeight.w800,
                    color: scheme.onSurface,
                    shadows: c.shadows,
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      );
    }
    return Wrap(spacing: 12.0, runSpacing: 12.0, children: tiles);
  }

  // ============================================================
  // Section 10: Font features
  // ============================================================
  Widget _buildFontFeaturesPanel(ColorScheme scheme) {
    final features = <_FeatureCase>[
      const _FeatureCase(
        tag: 'tnum',
        title: 'Tabular numbers',
        description: 'Equal-width digits — table-friendly numeric columns.',
        plain: '1 4 7 0\n1 8 8 8',
        styled: '1 4 7 0\n1 8 8 8',
        features: [FontFeature.tabularFigures()],
      ),
      const _FeatureCase(
        tag: 'lnum',
        title: 'Lining numbers',
        description: 'Numbers sit on the baseline at uniform height.',
        plain: 'Total 1,234,567',
        styled: 'Total 1,234,567',
        features: [FontFeature.liningFigures()],
      ),
      const _FeatureCase(
        tag: 'onum',
        title: 'Old-style numbers',
        description: 'Numerals with ascenders and descenders.',
        plain: 'Page 1234567890',
        styled: 'Page 1234567890',
        features: [FontFeature.oldstyleFigures()],
      ),
      const _FeatureCase(
        tag: 'smcp',
        title: 'Small caps',
        description: 'Lowercase rendered as small uppercase glyphs.',
        plain: 'Hello small caps',
        styled: 'Hello small caps',
        features: [FontFeature.enable('smcp')],
      ),
      _FeatureCase(
        tag: 'ss01',
        title: 'Stylistic set 01',
        description: 'Alternate glyph shapes per stylistic set.',
        plain: 'agility quality',
        styled: 'agility quality',
        features: [FontFeature.stylisticSet(1)],
      ),
      const _FeatureCase(
        tag: 'frac',
        title: 'Fractions',
        description: 'Render fractions as proper diagonal forms.',
        plain: '1/2 3/4 5/8',
        styled: '1/2 3/4 5/8',
        features: [FontFeature.enable('frac')],
      ),
    ];

    final rows = <Widget>[];
    for (final f in features) {
      rows.add(
        Container(
          margin: const EdgeInsets.only(bottom: 10.0),
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: scheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: scheme.outlineVariant),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 3.0),
                    decoration: BoxDecoration(
                      color: scheme.primaryContainer,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text(
                      f.tag,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11.0,
                        fontWeight: FontWeight.w700,
                        color: scheme.onPrimaryContainer,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Text(
                    f.title,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w700,
                      color: scheme.onSurface,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6.0),
              Text(
                f.description,
                style: TextStyle(
                  fontSize: 12.0,
                  color: scheme.onSurfaceVariant,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 10.0),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: scheme.surface,
                        borderRadius: BorderRadius.circular(6.0),
                        border: Border.all(color: scheme.outlineVariant),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'off',
                            style: TextStyle(
                              fontSize: 10.0,
                              color: scheme.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            f.plain,
                            style: TextStyle(
                              fontSize: 18.0,
                              color: scheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: scheme.primaryContainer.withOpacity(0.35),
                        borderRadius: BorderRadius.circular(6.0),
                        border:
                            Border.all(color: scheme.primary.withOpacity(0.4)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'on',
                            style: TextStyle(
                              fontSize: 10.0,
                              color: scheme.primary,
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            f.styled,
                            style: TextStyle(
                              fontSize: 18.0,
                              color: scheme.onSurface,
                              fontFeatures: f.features,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
    return Column(children: rows);
  }

  // ============================================================
  // Section 11: copyWith / merge / apply / lerp
  // ============================================================
  Widget _buildCopyWithPanel(ColorScheme scheme) {
    final base = TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w400,
      color: scheme.onSurface,
      debugLabel: 'base',
    );
    final bolded =
        base.copyWith(fontWeight: FontWeight.w800, debugLabel: 'bold');
    final coloured =
        base.copyWith(color: scheme.primary, debugLabel: 'colored');
    final big = base.copyWith(fontSize: 26.0, debugLabel: 'big');
    final all = base.copyWith(
      fontSize: 22.0,
      fontWeight: FontWeight.w700,
      color: scheme.tertiary,
      letterSpacing: 1.2,
      debugLabel: 'all',
    );

    print('base.debugLabel: ${base.debugLabel}');
    print('bolded.debugLabel: ${bolded.debugLabel}');
    print('all.fontSize: ${all.fontSize}');

    return _bordered(
      scheme: scheme,
      title: 'copyWith',
      subtitle: 'returns a new TextStyle with overrides',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _styleRow('base', 'The quick brown fox', base),
          _styleRow('+ fontWeight: w800', 'The quick brown fox', bolded),
          _styleRow('+ color: primary', 'The quick brown fox', coloured),
          _styleRow('+ fontSize: 26', 'The quick brown fox', big),
          _styleRow('+ all', 'The quick brown fox', all),
        ],
      ),
    );
  }

  Widget _styleRow(String label, String text, TextStyle style) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 170.0,
            child: Text(
              label,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.5,
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          Expanded(child: Text(text, style: style)),
        ],
      ),
    );
  }

  Widget _buildMergePanel(ColorScheme scheme) {
    final outer = TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      color: scheme.onSurface,
      letterSpacing: 0.0,
    );
    const accent = TextStyle(
      fontWeight: FontWeight.w800,
      fontStyle: FontStyle.italic,
      letterSpacing: 1.5,
    );
    final merged = outer.merge(accent);
    print('merged.fontWeight: ${merged.fontWeight}');

    return _bordered(
      scheme: scheme,
      title: 'merge',
      subtitle: 'fields from `other` win when both are set',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _styleRow('outer', 'merge example', outer),
          _styleRow('other', 'merge example', accent),
          _styleRow('outer.merge(other)', 'merge example', merged),
        ],
      ),
    );
  }

  Widget _buildApplyPanel(ColorScheme scheme) {
    final base = TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
      color: scheme.onSurface,
    );
    final smaller = base.apply(fontSizeFactor: 0.85);
    final bigger = base.apply(fontSizeFactor: 1.6, fontWeightDelta: 2);
    final bumped = base.apply(fontSizeDelta: 6.0, color: scheme.tertiary);

    return _bordered(
      scheme: scheme,
      title: 'apply',
      subtitle: 'multiplicative / additive adjustments',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _styleRow('base', 'apply variant', base),
          _styleRow('factor: 0.85', 'apply variant', smaller),
          _styleRow('factor: 1.6, weight +2', 'apply variant', bigger),
          _styleRow('delta: +6, color', 'apply variant', bumped),
        ],
      ),
    );
  }

  Widget _buildLerpRamp(ColorScheme scheme) {
    final a = TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w300,
      color: scheme.primary,
      letterSpacing: 0.0,
    );
    final b = TextStyle(
      fontSize: 32.0,
      fontWeight: FontWeight.w900,
      color: scheme.tertiary,
      letterSpacing: 3.0,
    );
    final tiles = <Widget>[];
    for (var i = 0; i <= 6; i++) {
      final t = i / 6.0;
      final mid = TextStyle.lerp(a, b, t)!;
      tiles.add(
        Container(
          margin: const EdgeInsets.symmetric(vertical: 4.0),
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: scheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 56.0,
                child: Text(
                  't=${t.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11.0,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ),
              Expanded(
                child: Text('Lerping styles', style: mid),
              ),
            ],
          ),
        ),
      );
    }
    return _bordered(
      scheme: scheme,
      title: 'TextStyle.lerp',
      subtitle: 'linearly interpolate between two styles',
      child: Column(children: tiles),
    );
  }

  // ============================================================
  // Section 12: Bridging note + glossary + recipes
  // ============================================================
  Widget _buildBridgingNote(ColorScheme scheme) {
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: scheme.tertiaryContainer,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: scheme.tertiary.withOpacity(0.4)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.swap_horiz,
              color: scheme.onTertiaryContainer, size: 28.0),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'getTextStyle bridging',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15.0,
                    color: scheme.onTertiaryContainer,
                  ),
                ),
                const SizedBox(height: 6.0),
                Text(
                  'TextStyle.getTextStyle() returns a ui.TextStyle suitable for '
                  'low-level Paragraph painting. The D4rt bridge maps the dart:ui '
                  'TextStyle constructor to a real ui.TextStyle, so script-side '
                  'calls to base.getTextStyle() produce a value that round-trips '
                  'through the painting pipeline.',
                  style: TextStyle(
                    fontSize: 12.5,
                    color: scheme.onTertiaryContainer.withOpacity(0.88),
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

  Widget _buildGlossary(ColorScheme scheme) {
    final entries = <_GlossaryEntry>[
      const _GlossaryEntry(
          'fontFamily',
          'Name of the typeface to use. Falls back to fontFamilyFallback.'),
      const _GlossaryEntry(
          'fontFamilyFallback',
          'Ordered list of typefaces tried when fontFamily lacks a glyph.'),
      const _GlossaryEntry(
          'package', 'Asset package name to scope fontFamily lookup.'),
      const _GlossaryEntry(
          'fontWeight', 'Stroke thickness as one of FontWeight.w100..w900.'),
      const _GlossaryEntry('fontStyle', 'Normal or italic.'),
      const _GlossaryEntry('fontSize', 'Glyph height in logical pixels.'),
      const _GlossaryEntry(
          'color / backgroundColor',
          'Solid foreground / background fill. Mutually exclusive with '
              'foreground/background Paints.'),
      const _GlossaryEntry(
          'foreground / background',
          'Paint objects for advanced fills (gradients, strokes).'),
      const _GlossaryEntry(
          'letterSpacing', 'Extra space between glyphs in logical px.'),
      const _GlossaryEntry(
          'wordSpacing', 'Extra space inserted at word boundaries.'),
      const _GlossaryEntry(
          'height', 'Multiplier on fontSize defining the line box height.'),
      const _GlossaryEntry(
          'leadingDistribution',
          'How surplus leading is split above vs below the line.'),
      const _GlossaryEntry(
          'textBaseline',
          'Which baseline to align glyphs to (alphabetic or ideographic).'),
      const _GlossaryEntry(
          'decoration',
          'underline, overline, lineThrough, or combinations.'),
      const _GlossaryEntry(
          'decorationColor / decorationStyle / decorationThickness',
          'Fine-grained control over the decoration line.'),
      const _GlossaryEntry(
          'shadows', 'List of Shadow objects painted beneath the text.'),
      const _GlossaryEntry(
          'fontFeatures',
          'OpenType feature overrides (tnum, smcp, ss01, ...).'),
      const _GlossaryEntry(
          'fontVariations',
          'Variable font axis values (wght, wdth, ...).'),
      const _GlossaryEntry(
          'debugLabel',
          'Free-form label used only by toString and toDiagnostic output.'),
      const _GlossaryEntry(
          'inherit',
          'When true (default) missing fields cascade from DefaultTextStyle.'),
    ];
    final rows = <Widget>[];
    for (final e in entries) {
      rows.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 200.0,
                child: Text(
                  e.term,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12.0,
                    fontWeight: FontWeight.w700,
                    color: scheme.primary,
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  e.definition,
                  style: TextStyle(
                    fontSize: 12.5,
                    color: scheme.onSurface,
                    height: 1.35,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return _bordered(
      scheme: scheme,
      title: 'Glossary',
      subtitle: 'every field that TextStyle exposes',
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, children: rows),
    );
  }

  Widget _buildRecipes(ColorScheme scheme) {
    final recipes = <_Recipe>[
      const _Recipe(
        title: 'Headline',
        code:
            'TextStyle(fontSize: 28, fontWeight: FontWeight.w800, letterSpacing: -0.5)',
        sample: Text(
          'Quarterly Report',
          style: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
          ),
        ),
      ),
      const _Recipe(
        title: 'Body',
        code: 'TextStyle(fontSize: 14, height: 1.45)',
        sample: Text(
          'The painting library exposes TextStyle as an immutable description '
          'of how a span of text should be rendered.',
          style: TextStyle(fontSize: 14.0, height: 1.45),
        ),
      ),
      _Recipe(
        title: 'Caption',
        code: 'TextStyle(fontSize: 11, letterSpacing: 0.6, '
            'fontWeight: FontWeight.w500)',
        sample: Text(
          'FIGURE 1 - DEEP DEMO',
          style: TextStyle(
            fontSize: 11.0,
            letterSpacing: 0.6,
            fontWeight: FontWeight.w500,
            color: scheme.onSurfaceVariant,
          ),
        ),
      ),
      const _Recipe(
        title: 'Code',
        code: "TextStyle(fontFamily: 'monospace', fontSize: 13)",
        sample: Text(
          'final t = TextStyle();',
          style: TextStyle(fontFamily: 'monospace', fontSize: 13.0),
        ),
      ),
      _Recipe(
        title: 'Warning',
        code: 'TextStyle(color: scheme.error, fontWeight: w700, '
            'decoration: underline)',
        sample: Text(
          'Quota exceeded - retry later.',
          style: TextStyle(
            color: scheme.error,
            fontWeight: FontWeight.w700,
            decoration: TextDecoration.underline,
            decorationColor: scheme.error,
          ),
        ),
      ),
      _Recipe(
        title: 'Strikethrough cost',
        code: 'TextStyle(decoration: lineThrough, color: onSurfaceVariant)',
        sample: Text(
          '\$249.00',
          style: TextStyle(
            fontSize: 18.0,
            decoration: TextDecoration.lineThrough,
            color: scheme.onSurfaceVariant,
          ),
        ),
      ),
      const _Recipe(
        title: 'Italic quote',
        code: 'TextStyle(fontStyle: italic, fontWeight: w500)',
        sample: Text(
          'Type is the voice of the page.',
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w500,
            fontSize: 15.0,
          ),
        ),
      ),
      const _Recipe(
        title: 'Embossed',
        code: 'TextStyle(shadows: [white above, dark below])',
        sample: Text(
          'Embossed',
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.w800,
            color: Color(0xFF555555),
            shadows: [
              Shadow(
                  color: Colors.white,
                  blurRadius: 1.0,
                  offset: Offset(0, -1)),
              Shadow(
                  color: Colors.black54,
                  blurRadius: 2.0,
                  offset: Offset(0, 1)),
            ],
          ),
        ),
      ),
    ];

    final tiles = <Widget>[];
    for (final r in recipes) {
      tiles.add(
        Container(
          width: 320.0,
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: scheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: scheme.outlineVariant),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                r.title,
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w800,
                  color: scheme.primary,
                ),
              ),
              const SizedBox(height: 8.0),
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: scheme.surface,
                  borderRadius: BorderRadius.circular(6.0),
                  border: Border.all(color: scheme.outlineVariant),
                ),
                child: Text(
                  r.code,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11.0,
                    color: scheme.onSurfaceVariant,
                    height: 1.35,
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: scheme.surface,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: r.sample,
              ),
            ],
          ),
        ),
      );
    }

    return _bordered(
      scheme: scheme,
      title: 'Recipes',
      subtitle: 'ready-to-paste TextStyle patterns',
      child: Wrap(spacing: 10.0, runSpacing: 10.0, children: tiles),
    );
  }

  Widget _bordered({
    required ColorScheme scheme,
    required String title,
    required String subtitle,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w800,
              color: scheme.onSurface,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(height: 2.0),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 11.5,
              color: scheme.onSurfaceVariant,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 10.0),
          child,
        ],
      ),
    );
  }
}

// ============================================================
// Plain data records used by the demo
// ============================================================

class _NamedWeight {
  final String code;
  final FontWeight weight;
  final String name;
  const _NamedWeight(this.code, this.weight, this.name);
}

class _LeadingVariant {
  final String label;
  final ui.TextLeadingDistribution value;
  const _LeadingVariant({required this.label, required this.value});
}

class _DecorationCase {
  final String label;
  final TextDecoration decoration;
  final TextDecorationStyle style;
  final Color color;
  const _DecorationCase(this.label, this.decoration, this.style, this.color);
}

class _ShadowCase {
  final String label;
  final List<Shadow> shadows;
  const _ShadowCase({required this.label, required this.shadows});
}

class _FeatureCase {
  final String tag;
  final String title;
  final String description;
  final String plain;
  final String styled;
  final List<FontFeature> features;
  const _FeatureCase({
    required this.tag,
    required this.title,
    required this.description,
    required this.plain,
    required this.styled,
    required this.features,
  });
}

class _GlossaryEntry {
  final String term;
  final String definition;
  const _GlossaryEntry(this.term, this.definition);
}

class _Recipe {
  final String title;
  final String code;
  final Widget sample;
  const _Recipe({
    required this.title,
    required this.code,
    required this.sample,
  });
}
