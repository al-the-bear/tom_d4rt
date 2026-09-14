// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep visual demo for Material 3 DynamicSchemeVariant.
//
// =========================================================================
// DESIGN PLAN -- DynamicSchemeVariant Deep Demo
// =========================================================================
// Subject: Material 3 ColorScheme.fromSeed(dynamicSchemeVariant: ...) and
// the nine DynamicSchemeVariant values that produce different M3 palettes
// from the same seed color.
//
// Sections (each prints a numbered "=== Section N: ===" header):
//   1. Variant overview cards -- nine variants with primary/secondary/
//      tertiary previews and one-line taglines.
//   2. Per-variant role grid -- every variant in light Brightness rendered
//      as a labelled swatch panel showing the full M3 role set.
//   3. Per-variant role grid -- same as section 2 but dark Brightness.
//   4. Side-by-side stripe matrix -- all nine variants for the deepPurple
//      seed in compact light+dark stripes for direct comparison.
//   5. Seed-color exploration -- six seeds (red, green, blue, purple,
//      orange, teal) combined with four representative variants.
//   6. Variant-character matrix -- 2D taxonomy plotting each variant on
//      axes "neutral <-> colored" and "subtle <-> vibrant".
//   7. Recipes -- code-shaped snippets showing each variant configured
//      for a real product theme.
//   8. Glossary -- terminology used in M3 dynamic color (seed, tonal
//      palette, role, container, on-color, surface family, etc.).
//
// Root: a Stateless MaterialApp whose home is a Scaffold containing a
// SingleChildScrollView with every section. No async, no Timer, no
// Navigator. Plain ASCII narrative comments throughout.
// =========================================================================

import 'package:flutter/material.dart';

// =========================================================================
// CONSTANTS  --  variant taxonomy and lookup tables.
// =========================================================================

const Color _seedDeepPurple = Color(0xFF673AB7);
const Color _seedRed = Color(0xFFE53935);
const Color _seedGreen = Color(0xFF2E7D32);
const Color _seedBlue = Color(0xFF1565C0);
const Color _seedOrange = Color(0xFFEF6C00);
const Color _seedTeal = Color(0xFF00796B);

// Canonical ordered list of all nine variants for stable iteration.
const List<DynamicSchemeVariant> _allVariants = <DynamicSchemeVariant>[
  DynamicSchemeVariant.tonalSpot,
  DynamicSchemeVariant.fidelity,
  DynamicSchemeVariant.monochrome,
  DynamicSchemeVariant.neutral,
  DynamicSchemeVariant.vibrant,
  DynamicSchemeVariant.expressive,
  DynamicSchemeVariant.content,
  DynamicSchemeVariant.rainbow,
  DynamicSchemeVariant.fruitSalad,
];

// Short human label per variant.
String _variantLabel(DynamicSchemeVariant v) {
  switch (v) {
    case DynamicSchemeVariant.tonalSpot:
      return 'tonalSpot';
    case DynamicSchemeVariant.fidelity:
      return 'fidelity';
    case DynamicSchemeVariant.monochrome:
      return 'monochrome';
    case DynamicSchemeVariant.neutral:
      return 'neutral';
    case DynamicSchemeVariant.vibrant:
      return 'vibrant';
    case DynamicSchemeVariant.expressive:
      return 'expressive';
    case DynamicSchemeVariant.content:
      return 'content';
    case DynamicSchemeVariant.rainbow:
      return 'rainbow';
    case DynamicSchemeVariant.fruitSalad:
      return 'fruitSalad';
  }
}

// One-line tagline per variant.
String _variantTagline(DynamicSchemeVariant v) {
  switch (v) {
    case DynamicSchemeVariant.tonalSpot:
      return 'Balanced M3 default. Gentle chroma everywhere.';
    case DynamicSchemeVariant.fidelity:
      return 'Stay faithful to the literal seed color.';
    case DynamicSchemeVariant.monochrome:
      return 'Strip chroma. Grayscale derived from luminance.';
    case DynamicSchemeVariant.neutral:
      return 'Mostly neutral surfaces with a hint of seed.';
    case DynamicSchemeVariant.vibrant:
      return 'High chroma. Energetic and saturated.';
    case DynamicSchemeVariant.expressive:
      return 'Playful. Shifts hues for personality.';
    case DynamicSchemeVariant.content:
      return 'Tuned for image and content backgrounds.';
    case DynamicSchemeVariant.rainbow:
      return 'Rotates through a wide hue palette.';
    case DynamicSchemeVariant.fruitSalad:
      return 'Multi-hue mix. Secondary differs from primary.';
  }
}

// A characteristic icon per variant.
IconData _variantIcon(DynamicSchemeVariant v) {
  switch (v) {
    case DynamicSchemeVariant.tonalSpot:
      return Icons.blur_on;
    case DynamicSchemeVariant.fidelity:
      return Icons.verified;
    case DynamicSchemeVariant.monochrome:
      return Icons.invert_colors_off;
    case DynamicSchemeVariant.neutral:
      return Icons.balance;
    case DynamicSchemeVariant.vibrant:
      return Icons.flash_on;
    case DynamicSchemeVariant.expressive:
      return Icons.theater_comedy;
    case DynamicSchemeVariant.content:
      return Icons.image;
    case DynamicSchemeVariant.rainbow:
      return Icons.color_lens;
    case DynamicSchemeVariant.fruitSalad:
      return Icons.local_florist;
  }
}

// Build a ColorScheme from a seed with a specific variant + brightness.
ColorScheme _scheme(Color seed, DynamicSchemeVariant v, Brightness b) {
  return ColorScheme.fromSeed(
    seedColor: seed,
    brightness: b,
    dynamicSchemeVariant: v,
  );
}

// Hex format helper.
String _hex(Color c) {
  return '#${c.value.toRadixString(16).padLeft(8, '0').substring(2).toUpperCase()}';
}

// Util: pick black or white as readable foreground for a color.
Color _onColorFor(Color c) {
  final double r = c.red / 255.0;
  final double g = c.green / 255.0;
  final double b = c.blue / 255.0;
  final double lum = 0.2126 * r + 0.7152 * g + 0.0722 * b;
  return lum > 0.55 ? Colors.black : Colors.white;
}

// =========================================================================
// ROOT WIDGET  --  Stateless MaterialApp entry.
// =========================================================================

class DynamicSchemeVariantDemoApp extends StatelessWidget {
  const DynamicSchemeVariantDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    print('DynamicSchemeVariant Deep Demo executing');

    return MaterialApp(
      title: 'DynamicSchemeVariant Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: _seedDeepPurple,
          dynamicSchemeVariant: DynamicSchemeVariant.tonalSpot,
        ),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _buildHeaderBanner(),
              const SizedBox(height: 24.0),
              _buildSection1Overview(),
              const SizedBox(height: 32.0),
              _buildSection2LightGrid(),
              const SizedBox(height: 32.0),
              _buildSection3DarkGrid(),
              const SizedBox(height: 32.0),
              _buildSection4StripeMatrix(),
              const SizedBox(height: 32.0),
              _buildSection5SeedExploration(),
              const SizedBox(height: 32.0),
              _buildSection6CharacterMatrix(),
              const SizedBox(height: 32.0),
              _buildSection7Recipes(),
              const SizedBox(height: 32.0),
              _buildSection8Glossary(),
              const SizedBox(height: 24.0),
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  // -----------------------------------------------------------------------
  // HEADER BANNER  --  gradient hero with chips for every variant name.
  // -----------------------------------------------------------------------
  Widget _buildHeaderBanner() {
    print('Building header banner');
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 28.0, horizontal: 24.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            Colors.deepPurple.shade700,
            Colors.indigo.shade500,
            Colors.teal.shade400,
            Colors.amber.shade400,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 16.0,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          const Icon(Icons.palette, color: Colors.white, size: 64.0),
          const SizedBox(height: 12.0),
          const Text(
            'DynamicSchemeVariant',
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 6.0),
          const Text(
            'Material 3 ColorScheme.fromSeed — nine flavors of dynamic color',
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.white70,
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 14.0),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            alignment: WrapAlignment.center,
            children: _allVariants.map((DynamicSchemeVariant v) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 4.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.4),
                    width: 1.0,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(_variantIcon(v), color: Colors.white, size: 14.0),
                    const SizedBox(width: 4.0),
                    Text(
                      _variantLabel(v),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // -----------------------------------------------------------------------
  // SECTION 1  --  Overview cards
  // -----------------------------------------------------------------------
  Widget _buildSection1Overview() {
    print('=== Section 1: Variant Overview ===');

    final List<Widget> cards = <Widget>[];
    for (final DynamicSchemeVariant v in _allVariants) {
      final ColorScheme cs = _scheme(_seedDeepPurple, v, Brightness.light);
      print('  variant=${_variantLabel(v)} primary=${_hex(cs.primary)}');
      cards.add(_overviewCard(v, cs));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _sectionTitle(
          number: '1',
          title: 'Variant Overview',
          subtitle:
              'Nine variants applied to seed #673AB7 (deepPurple). Each '
              'card previews primary plus secondary plus tertiary and a '
              'one-line tagline describing the variant character.',
        ),
        const SizedBox(height: 12.0),
        Wrap(
          spacing: 12.0,
          runSpacing: 12.0,
          children: cards,
        ),
      ],
    );
  }

  Widget _overviewCard(DynamicSchemeVariant v, ColorScheme cs) {
    return Container(
      width: 220.0,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: cs.outlineVariant, width: 1.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: cs.primary.withValues(alpha: 0.15),
            blurRadius: 8.0,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  color: cs.primaryContainer,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Icon(
                  _variantIcon(v),
                  color: cs.onPrimaryContainer,
                  size: 18.0,
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  _variantLabel(v),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: cs.onSurface,
                    fontSize: 14.0,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Row(
            children: <Widget>[
              Expanded(child: _tinyChip(cs.primary, 'P')),
              const SizedBox(width: 4.0),
              Expanded(child: _tinyChip(cs.secondary, 'S')),
              const SizedBox(width: 4.0),
              Expanded(child: _tinyChip(cs.tertiary, 'T')),
            ],
          ),
          const SizedBox(height: 6.0),
          Row(
            children: <Widget>[
              Expanded(child: _tinyChip(cs.primaryContainer, 'pC')),
              const SizedBox(width: 4.0),
              Expanded(child: _tinyChip(cs.secondaryContainer, 'sC')),
              const SizedBox(width: 4.0),
              Expanded(child: _tinyChip(cs.tertiaryContainer, 'tC')),
            ],
          ),
          const SizedBox(height: 10.0),
          Text(
            _variantTagline(v),
            style: TextStyle(
              fontSize: 11.0,
              color: cs.onSurfaceVariant,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }

  Widget _tinyChip(Color color, String label) {
    return Container(
      height: 32.0,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6.0),
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: TextStyle(
          color: _onColorFor(color),
          fontWeight: FontWeight.bold,
          fontSize: 11.0,
        ),
      ),
    );
  }

  // -----------------------------------------------------------------------
  // SECTION 2  --  Role grid (light)
  // -----------------------------------------------------------------------
  Widget _buildSection2LightGrid() {
    print('=== Section 2: Per-Variant M3 Role Grid (light) ===');
    final List<Widget> panels = <Widget>[];
    for (final DynamicSchemeVariant v in _allVariants) {
      final ColorScheme cs = _scheme(_seedDeepPurple, v, Brightness.light);
      print('  light/${_variantLabel(v)} surface=${_hex(cs.surface)}');
      panels.add(_rolePanel(v, cs, Brightness.light));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _sectionTitle(
          number: '2',
          title: 'M3 Role Palette — Light Brightness',
          subtitle:
              'Full Material 3 role set per variant: primary, secondary, '
              'tertiary, error, surface family and their on-colors. Seed '
              'is fixed to deepPurple so differences come purely from '
              'the variant algorithm.',
        ),
        const SizedBox(height: 12.0),
        ...panels,
      ],
    );
  }

  // -----------------------------------------------------------------------
  // SECTION 3  --  Role grid (dark)
  // -----------------------------------------------------------------------
  Widget _buildSection3DarkGrid() {
    print('=== Section 3: Per-Variant M3 Role Grid (dark) ===');
    final List<Widget> panels = <Widget>[];
    for (final DynamicSchemeVariant v in _allVariants) {
      final ColorScheme cs = _scheme(_seedDeepPurple, v, Brightness.dark);
      print('  dark/${_variantLabel(v)} surface=${_hex(cs.surface)}');
      panels.add(_rolePanel(v, cs, Brightness.dark));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _sectionTitle(
          number: '3',
          title: 'M3 Role Palette — Dark Brightness',
          subtitle:
              'Same nine variants reseeded for dark mode. Note how the '
              'surface family inverts toward low tones and on-colors flip '
              'toward high tones to maintain readable contrast.',
        ),
        const SizedBox(height: 12.0),
        ...panels,
      ],
    );
  }

  Widget _rolePanel(
    DynamicSchemeVariant v,
    ColorScheme cs,
    Brightness brightness,
  ) {
    final List<_RoleEntry> roles = <_RoleEntry>[
      _RoleEntry('primary', cs.primary, cs.onPrimary),
      _RoleEntry('onPrimary', cs.onPrimary, cs.primary),
      _RoleEntry('primaryContainer', cs.primaryContainer, cs.onPrimaryContainer),
      _RoleEntry(
        'onPrimaryContainer',
        cs.onPrimaryContainer,
        cs.primaryContainer,
      ),
      _RoleEntry('secondary', cs.secondary, cs.onSecondary),
      _RoleEntry('onSecondary', cs.onSecondary, cs.secondary),
      _RoleEntry(
        'secondaryContainer',
        cs.secondaryContainer,
        cs.onSecondaryContainer,
      ),
      _RoleEntry(
        'onSecondaryContainer',
        cs.onSecondaryContainer,
        cs.secondaryContainer,
      ),
      _RoleEntry('tertiary', cs.tertiary, cs.onTertiary),
      _RoleEntry('onTertiary', cs.onTertiary, cs.tertiary),
      _RoleEntry(
        'tertiaryContainer',
        cs.tertiaryContainer,
        cs.onTertiaryContainer,
      ),
      _RoleEntry(
        'onTertiaryContainer',
        cs.onTertiaryContainer,
        cs.tertiaryContainer,
      ),
      _RoleEntry('error', cs.error, cs.onError),
      _RoleEntry('onError', cs.onError, cs.error),
      _RoleEntry('errorContainer', cs.errorContainer, cs.onErrorContainer),
      _RoleEntry(
        'onErrorContainer',
        cs.onErrorContainer,
        cs.errorContainer,
      ),
      _RoleEntry('surface', cs.surface, cs.onSurface),
      _RoleEntry('onSurface', cs.onSurface, cs.surface),
      _RoleEntry('surfaceVariant', cs.surfaceVariant, cs.onSurfaceVariant),
      _RoleEntry('onSurfaceVariant', cs.onSurfaceVariant, cs.surfaceVariant),
      _RoleEntry('outline', cs.outline, cs.surface),
      _RoleEntry('outlineVariant', cs.outlineVariant, cs.onSurface),
      _RoleEntry('inverseSurface', cs.inverseSurface, cs.onInverseSurface),
      _RoleEntry('inversePrimary', cs.inversePrimary, cs.onSurface),
    ];

    return Container(
      margin: const EdgeInsets.only(bottom: 14.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: cs.outline, width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 4.0,
                ),
                decoration: BoxDecoration(
                  color: cs.primaryContainer,
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      _variantIcon(v),
                      color: cs.onPrimaryContainer,
                      size: 14.0,
                    ),
                    const SizedBox(width: 6.0),
                    Text(
                      _variantLabel(v),
                      style: TextStyle(
                        color: cs.onPrimaryContainer,
                        fontWeight: FontWeight.bold,
                        fontSize: 13.0,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10.0),
              Text(
                brightness == Brightness.light ? 'LIGHT' : 'DARK',
                style: TextStyle(
                  color: cs.onSurfaceVariant,
                  fontSize: 11.0,
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Text(
                'primary ${_hex(cs.primary)}',
                style: TextStyle(
                  color: cs.onSurfaceVariant,
                  fontFamily: 'monospace',
                  fontSize: 10.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Wrap(
            spacing: 6.0,
            runSpacing: 6.0,
            children: roles.map((_RoleEntry r) => _roleSwatch(r)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _roleSwatch(_RoleEntry r) {
    return Container(
      width: 132.0,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: r.bg,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            r.label,
            style: TextStyle(
              color: r.fg,
              fontSize: 10.0,
              fontWeight: FontWeight.w600,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2.0),
          Text(
            _hex(r.bg),
            style: TextStyle(
              color: r.fg,
              fontFamily: 'monospace',
              fontSize: 9.0,
            ),
          ),
        ],
      ),
    );
  }

  // -----------------------------------------------------------------------
  // SECTION 4  --  Stripe matrix (compact side-by-side compare)
  // -----------------------------------------------------------------------
  Widget _buildSection4StripeMatrix() {
    print('=== Section 4: Side-by-Side Stripe Matrix ===');
    final List<Widget> rows = <Widget>[];
    for (final DynamicSchemeVariant v in _allVariants) {
      final ColorScheme light = _scheme(_seedDeepPurple, v, Brightness.light);
      final ColorScheme dark = _scheme(_seedDeepPurple, v, Brightness.dark);
      rows.add(_stripeRow(v, light, dark));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _sectionTitle(
          number: '4',
          title: 'Stripe Matrix — Light vs Dark',
          subtitle:
              'Compact comparison: one row per variant, two stripes each '
              '(light then dark) showing primary, primaryContainer, '
              'secondary, secondaryContainer, tertiary, tertiaryContainer, '
              'error, errorContainer, surface, surfaceVariant.',
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 6.0),
                child: Row(
                  children: <Widget>[
                    const SizedBox(width: 100.0),
                    Expanded(
                      child: Center(
                        child: Text(
                          'LIGHT',
                          style: TextStyle(
                            fontSize: 11.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade700,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 4.0),
                    Expanded(
                      child: Center(
                        child: Text(
                          'DARK',
                          style: TextStyle(
                            fontSize: 11.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade700,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ...rows,
            ],
          ),
        ),
      ],
    );
  }

  Widget _stripeRow(
    DynamicSchemeVariant v,
    ColorScheme light,
    ColorScheme dark,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 100.0,
            child: Row(
              children: <Widget>[
                Icon(_variantIcon(v),
                    color: Colors.grey.shade700, size: 14.0),
                const SizedBox(width: 4.0),
                Expanded(
                  child: Text(
                    _variantLabel(v),
                    style: const TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: _stripe(light)),
          const SizedBox(width: 4.0),
          Expanded(child: _stripe(dark)),
        ],
      ),
    );
  }

  Widget _stripe(ColorScheme cs) {
    return Container(
      height: 28.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(color: Colors.grey.shade300, width: 0.5),
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        children: <Widget>[
          Expanded(child: Container(color: cs.primary)),
          Expanded(child: Container(color: cs.primaryContainer)),
          Expanded(child: Container(color: cs.secondary)),
          Expanded(child: Container(color: cs.secondaryContainer)),
          Expanded(child: Container(color: cs.tertiary)),
          Expanded(child: Container(color: cs.tertiaryContainer)),
          Expanded(child: Container(color: cs.error)),
          Expanded(child: Container(color: cs.errorContainer)),
          Expanded(child: Container(color: cs.surface)),
          Expanded(child: Container(color: cs.surfaceVariant)),
        ],
      ),
    );
  }

  // -----------------------------------------------------------------------
  // SECTION 5  --  Seed exploration
  // -----------------------------------------------------------------------
  Widget _buildSection5SeedExploration() {
    print('=== Section 5: Seed-Color Exploration ===');

    final List<_SeedDescriptor> seeds = <_SeedDescriptor>[
      _SeedDescriptor('Red', _seedRed),
      _SeedDescriptor('Green', _seedGreen),
      _SeedDescriptor('Blue', _seedBlue),
      _SeedDescriptor('Purple', _seedDeepPurple),
      _SeedDescriptor('Orange', _seedOrange),
      _SeedDescriptor('Teal', _seedTeal),
    ];

    final List<DynamicSchemeVariant> focusVariants = <DynamicSchemeVariant>[
      DynamicSchemeVariant.tonalSpot,
      DynamicSchemeVariant.fidelity,
      DynamicSchemeVariant.monochrome,
      DynamicSchemeVariant.vibrant,
    ];

    final List<Widget> cards = <Widget>[];
    for (final _SeedDescriptor s in seeds) {
      print('  seed=${s.name} ${_hex(s.seed)}');
      cards.add(_seedExplorationCard(s, focusVariants));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _sectionTitle(
          number: '5',
          title: 'Seed-Color Exploration',
          subtitle:
              'Six seed colors crossed with four representative variants '
              '(tonalSpot, fidelity, monochrome, vibrant). Useful when '
              'choosing a seed that survives the variant you intend to '
              'ship in production.',
        ),
        const SizedBox(height: 12.0),
        ...cards,
      ],
    );
  }

  Widget _seedExplorationCard(
    _SeedDescriptor s,
    List<DynamicSchemeVariant> focusVariants,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: Colors.grey.shade300, width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 28.0,
                height: 28.0,
                decoration: BoxDecoration(
                  color: s.seed,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.grey.shade400,
                    width: 1.0,
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              Text(
                'Seed: ${s.name}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),
              ),
              const SizedBox(width: 8.0),
              Text(
                _hex(s.seed),
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: focusVariants.map((DynamicSchemeVariant v) {
              final ColorScheme cs = _scheme(s.seed, v, Brightness.light);
              return _miniSchemeCard(v, cs);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _miniSchemeCard(DynamicSchemeVariant v, ColorScheme cs) {
    return Container(
      width: 160.0,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: cs.outlineVariant, width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(_variantIcon(v), color: cs.primary, size: 14.0),
              const SizedBox(width: 4.0),
              Expanded(
                child: Text(
                  _variantLabel(v),
                  style: TextStyle(
                    fontSize: 11.0,
                    fontWeight: FontWeight.w700,
                    color: cs.onSurface,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6.0),
          Row(
            children: <Widget>[
              Expanded(child: _bar(cs.primary, 22.0)),
              const SizedBox(width: 2.0),
              Expanded(child: _bar(cs.secondary, 22.0)),
              const SizedBox(width: 2.0),
              Expanded(child: _bar(cs.tertiary, 22.0)),
            ],
          ),
          const SizedBox(height: 4.0),
          Row(
            children: <Widget>[
              Expanded(child: _bar(cs.primaryContainer, 14.0)),
              const SizedBox(width: 2.0),
              Expanded(child: _bar(cs.secondaryContainer, 14.0)),
              const SizedBox(width: 2.0),
              Expanded(child: _bar(cs.tertiaryContainer, 14.0)),
            ],
          ),
          const SizedBox(height: 6.0),
          Text(
            'primary ${_hex(cs.primary)}',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 9.0,
              color: cs.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _bar(Color c, double h) {
    return Container(
      height: h,
      decoration: BoxDecoration(
        color: c,
        borderRadius: BorderRadius.circular(4.0),
      ),
    );
  }

  // -----------------------------------------------------------------------
  // SECTION 6  --  Character matrix (subtle vs vibrant, neutral vs colored)
  // -----------------------------------------------------------------------
  Widget _buildSection6CharacterMatrix() {
    print('=== Section 6: Variant Character Matrix ===');

    // Coordinates: x = colored (0..1), y = vibrant (0..1).
    final List<_VariantPos> positions = <_VariantPos>[
      _VariantPos(DynamicSchemeVariant.monochrome, 0.05, 0.10),
      _VariantPos(DynamicSchemeVariant.neutral, 0.20, 0.20),
      _VariantPos(DynamicSchemeVariant.tonalSpot, 0.55, 0.45),
      _VariantPos(DynamicSchemeVariant.content, 0.50, 0.30),
      _VariantPos(DynamicSchemeVariant.fidelity, 0.75, 0.55),
      _VariantPos(DynamicSchemeVariant.expressive, 0.80, 0.80),
      _VariantPos(DynamicSchemeVariant.fruitSalad, 0.85, 0.70),
      _VariantPos(DynamicSchemeVariant.rainbow, 0.92, 0.85),
      _VariantPos(DynamicSchemeVariant.vibrant, 0.95, 0.95),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _sectionTitle(
          number: '6',
          title: 'Character Matrix',
          subtitle:
              'Where each variant sits on the axes "neutral <-> colored" '
              'and "subtle <-> vibrant". Coordinates are illustrative and '
              'meant as a mental map, not a strict measurement.',
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(14.0),
            border: Border.all(color: Colors.grey.shade300, width: 1.0),
          ),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 320.0,
                child: LayoutBuilder(
                  builder: (BuildContext ctx, BoxConstraints c) {
                    final double w = c.maxWidth;
                    final double h = c.maxHeight;
                    final List<Widget> points = <Widget>[];

                    // Background grid (5 vertical + 5 horizontal lines).
                    for (int i = 0; i <= 4; i++) {
                      final double frac = i / 4.0;
                      points.add(Positioned(
                        left: w * frac,
                        top: 0.0,
                        bottom: 0.0,
                        child: Container(
                          width: 1.0,
                          color: Colors.grey.shade200,
                        ),
                      ));
                      points.add(Positioned(
                        top: h * frac,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          height: 1.0,
                          color: Colors.grey.shade200,
                        ),
                      ));
                    }

                    // Axis labels.
                    points.add(const Positioned(
                      left: 4.0,
                      bottom: 4.0,
                      child: Text(
                        'neutral / subtle',
                        style: TextStyle(
                          fontSize: 11.0,
                          color: Colors.grey,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ));
                    points.add(const Positioned(
                      right: 4.0,
                      top: 4.0,
                      child: Text(
                        'colored / vibrant',
                        style: TextStyle(
                          fontSize: 11.0,
                          color: Colors.grey,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ));

                    // Variant dots / chips.
                    for (final _VariantPos p in positions) {
                      final ColorScheme cs = _scheme(
                        _seedDeepPurple,
                        p.variant,
                        Brightness.light,
                      );
                      final double rawLeft = w * p.x - 50.0;
                      final double rawTop = h * (1.0 - p.y) - 14.0;
                      final double left =
                          rawLeft.clamp(0.0, (w - 100.0).clamp(0.0, w));
                      final double top =
                          rawTop.clamp(0.0, (h - 28.0).clamp(0.0, h));
                      points.add(Positioned(
                        left: left,
                        top: top,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 4.0,
                          ),
                          decoration: BoxDecoration(
                            color: cs.primaryContainer,
                            borderRadius: BorderRadius.circular(14.0),
                            border: Border.all(
                              color: cs.primary,
                              width: 1.5,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Container(
                                width: 10.0,
                                height: 10.0,
                                decoration: BoxDecoration(
                                  color: cs.primary,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 6.0),
                              Text(
                                _variantLabel(p.variant),
                                style: TextStyle(
                                  fontSize: 11.0,
                                  color: cs.onPrimaryContainer,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ));
                    }

                    return Stack(children: points);
                  },
                ),
              ),
              const SizedBox(height: 12.0),
              const Text(
                'X axis: neutrality of derived palette. '
                'Y axis: chroma / energy of derived palette.',
                style: TextStyle(fontSize: 11.0, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }

  // -----------------------------------------------------------------------
  // SECTION 7  --  Recipes
  // -----------------------------------------------------------------------
  Widget _buildSection7Recipes() {
    print('=== Section 7: Recipes ===');

    final List<_Recipe> recipes = <_Recipe>[
      _Recipe(
        title: 'Default Material App',
        variant: DynamicSchemeVariant.tonalSpot,
        seed: 'Colors.deepPurple',
        why:
            'Closest to plain ColorScheme.fromSeed defaults. Use when you '
            'have no opinion and want a calm, balanced result.',
      ),
      _Recipe(
        title: 'Brand-First Product Theme',
        variant: DynamicSchemeVariant.fidelity,
        seed: 'Color(0xFF0F62FE)',
        why:
            'Preserves the literal brand color in the primary slot. Use '
            'when the seed IS the brand and must not drift.',
      ),
      _Recipe(
        title: 'Print-Like Reader UI',
        variant: DynamicSchemeVariant.monochrome,
        seed: 'Colors.indigo',
        why:
            'Strips chroma for a neutral grayscale reading surface. The '
            'seed still controls accent placement and tonal anchors.',
      ),
      _Recipe(
        title: 'Subtle Surface-Heavy Dashboard',
        variant: DynamicSchemeVariant.neutral,
        seed: 'Colors.teal',
        why:
            'Almost-neutral palette with just a whisper of seed. Great '
            'for data tables and ops dashboards.',
      ),
      _Recipe(
        title: 'High-Energy Marketing Page',
        variant: DynamicSchemeVariant.vibrant,
        seed: 'Colors.pink',
        why:
            'Cranks chroma. Use for landing pages, promo screens, and '
            'first-run delight moments.',
      ),
      _Recipe(
        title: 'Playful Mobile App',
        variant: DynamicSchemeVariant.expressive,
        seed: 'Colors.orange',
        why:
            'Shifts hues to add personality. Reads as warm and energetic '
            'without being aggressive.',
      ),
      _Recipe(
        title: 'Photo / Wallpaper Theming',
        variant: DynamicSchemeVariant.content,
        seed: 'extractedFromImage',
        why:
            'Designed to play well with content backgrounds. Use when the '
            'seed is computed from imagery.',
      ),
      _Recipe(
        title: 'Editorial / Magazine Layout',
        variant: DynamicSchemeVariant.rainbow,
        seed: 'Colors.lime',
        why:
            'Wide hue rotation between roles. Useful where secondary and '
            'tertiary should feel clearly distinct from primary.',
      ),
      _Recipe(
        title: 'Kid / Education App',
        variant: DynamicSchemeVariant.fruitSalad,
        seed: 'Colors.amber',
        why:
            'Multi-hue mix where secondary contrasts with primary in '
            'hue, not just lightness. Friendly and varied.',
      ),
    ];

    final List<Widget> cards = <Widget>[];
    for (final _Recipe r in recipes) {
      print('  recipe=${r.title}  variant=${_variantLabel(r.variant)}');
      cards.add(_recipeCard(r));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _sectionTitle(
          number: '7',
          title: 'Recipes',
          subtitle:
              'Concrete product themes with code-shaped snippets. Each '
              'recipe pairs a variant with a seed and explains why the '
              'combination fits a product situation.',
        ),
        const SizedBox(height: 12.0),
        ...cards,
      ],
    );
  }

  Widget _recipeCard(_Recipe r) {
    final ColorScheme cs =
        _scheme(_seedDeepPurple, r.variant, Brightness.light);

    final String code = 'theme: ThemeData(\n'
        '  useMaterial3: true,\n'
        '  colorScheme: ColorScheme.fromSeed(\n'
        '    seedColor: ${r.seed},\n'
        '    dynamicSchemeVariant: DynamicSchemeVariant.${_variantLabel(r.variant)},\n'
        '  ),\n'
        ')';

    return Container(
      margin: const EdgeInsets.only(bottom: 14.0),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: cs.outlineVariant, width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(14.0),
            decoration: BoxDecoration(
              color: cs.primaryContainer,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(14.0),
              ),
            ),
            child: Row(
              children: <Widget>[
                Icon(
                  _variantIcon(r.variant),
                  color: cs.onPrimaryContainer,
                  size: 22.0,
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        r.title,
                        style: TextStyle(
                          color: cs.onPrimaryContainer,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'variant: ${_variantLabel(r.variant)}',
                        style: TextStyle(
                          color: cs.onPrimaryContainer.withValues(alpha: 0.8),
                          fontSize: 11.0,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  r.why,
                  style: TextStyle(
                    color: cs.onSurface,
                    fontSize: 12.0,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 10.0),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade900,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    code,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11.0,
                      color: Colors.green.shade200,
                      height: 1.4,
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                Row(
                  children: <Widget>[
                    Expanded(child: _swatchLabelled('primary', cs.primary)),
                    const SizedBox(width: 6.0),
                    Expanded(child: _swatchLabelled('secondary', cs.secondary)),
                    const SizedBox(width: 6.0),
                    Expanded(child: _swatchLabelled('tertiary', cs.tertiary)),
                    const SizedBox(width: 6.0),
                    Expanded(child: _swatchLabelled('error', cs.error)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _swatchLabelled(String label, Color c) {
    return Column(
      children: <Widget>[
        Container(
          height: 28.0,
          decoration: BoxDecoration(
            color: c,
            borderRadius: BorderRadius.circular(6.0),
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          label,
          style: const TextStyle(fontSize: 10.0, color: Colors.black54),
        ),
      ],
    );
  }

  // -----------------------------------------------------------------------
  // SECTION 8  --  Glossary
  // -----------------------------------------------------------------------
  Widget _buildSection8Glossary() {
    print('=== Section 8: Glossary ===');

    final List<_GlossaryEntry> entries = <_GlossaryEntry>[
      _GlossaryEntry(
        term: 'seed color',
        body:
            'The single input Color from which Material 3 derives the '
            'entire ColorScheme via tonal palettes.',
      ),
      _GlossaryEntry(
        term: 'DynamicSchemeVariant',
        body:
            'Enum that selects the algorithm used to derive a palette '
            'from the seed. The default is tonalSpot.',
      ),
      _GlossaryEntry(
        term: 'tonal palette',
        body:
            'A 13-step ramp of one hue at increasing tones (0..100). '
            'Roles like primary and onPrimary pick specific tones.',
      ),
      _GlossaryEntry(
        term: 'role',
        body:
            'A semantic slot in ColorScheme (primary, secondary, surface, '
            'error, etc.). Widgets read roles, not raw colors.',
      ),
      _GlossaryEntry(
        term: 'on-color',
        body:
            'The contrast color paired with a role for readable text and '
            'icons. onPrimary is the text color on primary surfaces.',
      ),
      _GlossaryEntry(
        term: 'container',
        body:
            'A tonal variant of a role (primaryContainer, '
            'secondaryContainer, etc.) used for filled chips, cards, and '
            'emphasis surfaces.',
      ),
      _GlossaryEntry(
        term: 'surface family',
        body:
            'surface, surfaceVariant, inverseSurface and their on-colors '
            'define the base canvas of the M3 app.',
      ),
      _GlossaryEntry(
        term: 'fidelity',
        body:
            'Variant biased toward preserving the literal seed color. '
            'Best for brand colors that must not shift.',
      ),
      _GlossaryEntry(
        term: 'monochrome',
        body:
            'Variant that drops chroma to produce a grayscale palette. '
            'Hue information becomes irrelevant.',
      ),
      _GlossaryEntry(
        term: 'expressive',
        body:
            'Variant that rotates hues for personality. Secondary and '
            'tertiary may diverge significantly from primary.',
      ),
      _GlossaryEntry(
        term: 'rainbow / fruitSalad',
        body:
            'Variants designed to vary hue across roles for editorial '
            'or multi-category UIs.',
      ),
      _GlossaryEntry(
        term: 'content',
        body:
            'Variant tuned to coexist with image content (e.g. seed '
            'extracted from a photo). Lower chroma in some roles.',
      ),
      _GlossaryEntry(
        term: 'brightness',
        body:
            'Brightness.light or Brightness.dark switches the tones used '
            'for surface and on-color roles. Same seed, mirrored ramp.',
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _sectionTitle(
          number: '8',
          title: 'Glossary',
          subtitle:
              'Terminology used throughout Material 3 dynamic color and '
              'the DynamicSchemeVariant API surface.',
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                Colors.indigo.shade50,
                Colors.deepPurple.shade50,
                Colors.teal.shade50,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(14.0),
            border: Border.all(color: Colors.indigo.shade100, width: 1.0),
          ),
          child: Column(
            children: entries.map((_GlossaryEntry e) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(top: 4.0),
                      width: 8.0,
                      height: 8.0,
                      decoration: BoxDecoration(
                        color: Colors.indigo.shade400,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 13.0,
                            height: 1.45,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: '${e.term} — ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.indigo.shade900,
                              ),
                            ),
                            TextSpan(text: e.body),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  // -----------------------------------------------------------------------
  // FOOTER
  // -----------------------------------------------------------------------
  Widget _buildFooter() {
    print('DynamicSchemeVariant Deep Demo completed successfully');
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(14.0),
      ),
      child: Column(
        children: <Widget>[
          Icon(
            Icons.check_circle,
            color: Colors.greenAccent.shade400,
            size: 32.0,
          ),
          const SizedBox(height: 8.0),
          const Text(
            'End of demo',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            'Nine variants. Six seeds. Two brightnesses. One ColorScheme API.',
            style: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 12.0,
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // -----------------------------------------------------------------------
  // Section title helper  --  used by every section for a consistent header.
  // -----------------------------------------------------------------------
  Widget _sectionTitle({
    required String number,
    required String title,
    required String subtitle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 36.0,
              height: 36.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    Colors.deepPurple.shade400,
                    Colors.indigo.shade400,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                number,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        Padding(
          padding: const EdgeInsets.only(left: 48.0),
          child: Text(
            subtitle,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.grey.shade700,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}

// =========================================================================
// Plain data classes
// =========================================================================

class _RoleEntry {
  const _RoleEntry(this.label, this.bg, this.fg);
  final String label;
  final Color bg;
  final Color fg;
}

class _SeedDescriptor {
  const _SeedDescriptor(this.name, this.seed);
  final String name;
  final Color seed;
}

class _VariantPos {
  const _VariantPos(this.variant, this.x, this.y);
  final DynamicSchemeVariant variant;
  final double x;
  final double y;
}

class _Recipe {
  const _Recipe({
    required this.title,
    required this.variant,
    required this.seed,
    required this.why,
  });
  final String title;
  final DynamicSchemeVariant variant;
  final String seed;
  final String why;
}

class _GlossaryEntry {
  const _GlossaryEntry({required this.term, required this.body});
  final String term;
  final String body;
}

// =========================================================================
// Entry point
// =========================================================================

dynamic build(BuildContext context) => const DynamicSchemeVariantDemoApp();
