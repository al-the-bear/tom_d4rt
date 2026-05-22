// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep visual demo of dart:ui BlurStyle enum
//
// Design plan
// -----------
// BlurStyle has four canonical values: normal, solid, outer, inner. They drive
// the way Skia paints a MaskFilter / BoxShadow blur outside, inside, both, or
// only the body of the source shape. This file paints every value across many
// dimensions so the visual differences become unmistakable.
//
// Sections:
//   1. Header gradient banner with the four BlurStyle chips
//   2. Per-style specimen cards (normal / solid / outer / inner)
//   3. blurRadius sweep grid (rows = style, cols = radius 0/4/8/16/24)
//   4. spreadRadius interaction matrix
//   5. Color interaction strip (warm / cool / mono / neon)
//   6. Real-world recipes (elevation, glow, inset, sharp)
//   7. Decision matrix + glossary
//   8. Footer summary
//
// All output is static (no Timer, no async, no Navigator). Every box is a
// labelled BoxShadow specimen so the renderer can be diffed by eye.
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Top-level constants used across the demo. Kept const-able so the AST is flat
// and easy to walk.
// ---------------------------------------------------------------------------
const List<BlurStyle> _allStyles = <BlurStyle>[
  BlurStyle.normal,
  BlurStyle.solid,
  BlurStyle.outer,
  BlurStyle.inner,
];

const List<double> _radiusSweep = <double>[0.0, 4.0, 8.0, 16.0, 24.0];

const List<double> _spreadSweep = <double>[0.0, 2.0, 4.0, 8.0];

// ---------------------------------------------------------------------------
// String label for a BlurStyle.
// ---------------------------------------------------------------------------
String _styleLabel(BlurStyle s) {
  switch (s) {
    case BlurStyle.normal:
      return 'normal';
    case BlurStyle.solid:
      return 'solid';
    case BlurStyle.outer:
      return 'outer';
    case BlurStyle.inner:
      return 'inner';
  }
}

// Short human-readable description of what each style paints.
String _styleDescription(BlurStyle s) {
  switch (s) {
    case BlurStyle.normal:
      return 'Fuzzy halo, no solid core. Same as a regular Gaussian blur.';
    case BlurStyle.solid:
      return 'Solid source plus a fuzzy halo outside the source.';
    case BlurStyle.outer:
      return 'Only the halo outside; the source itself is removed.';
    case BlurStyle.inner:
      return 'Halo painted inside the source; nothing outside.';
  }
}

// Material 3 themed accent for each style, taken from the ColorScheme.
Color _styleAccent(ColorScheme cs, BlurStyle s) {
  switch (s) {
    case BlurStyle.normal:
      return cs.primary;
    case BlurStyle.solid:
      return cs.secondary;
    case BlurStyle.outer:
      return cs.tertiary;
    case BlurStyle.inner:
      return cs.error;
  }
}

Color _styleAccentContainer(ColorScheme cs, BlurStyle s) {
  switch (s) {
    case BlurStyle.normal:
      return cs.primaryContainer;
    case BlurStyle.solid:
      return cs.secondaryContainer;
    case BlurStyle.outer:
      return cs.tertiaryContainer;
    case BlurStyle.inner:
      return cs.errorContainer;
  }
}

// Icon hint for each style.
IconData _styleIcon(BlurStyle s) {
  switch (s) {
    case BlurStyle.normal:
      return Icons.blur_on;
    case BlurStyle.solid:
      return Icons.lens;
    case BlurStyle.outer:
      return Icons.radio_button_unchecked;
    case BlurStyle.inner:
      return Icons.adjust;
  }
}

// ---------------------------------------------------------------------------
// Specimen: a labelled square whose shadow uses a given BlurStyle.
//
// This is the smallest visual unit in the demo. Every section composes these.
// ---------------------------------------------------------------------------
class BlurSpecimen extends StatelessWidget {
  final BlurStyle style;
  final double blurRadius;
  final double spreadRadius;
  final Color shadowColor;
  final Color boxColor;
  final double size;
  final String? caption;
  final String? subCaption;

  const BlurSpecimen({
    super.key,
    required this.style,
    this.blurRadius = 12.0,
    this.spreadRadius = 0.0,
    this.shadowColor = const Color(0xFF000000),
    this.boxColor = const Color(0xFFFFFFFF),
    this.size = 72.0,
    this.caption,
    this.subCaption,
  });

  @override
  Widget build(BuildContext context) {
    // The actual specimen: a coloured square with a single BoxShadow whose
    // blurStyle property is what we are demonstrating.
    final box = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: boxColor,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: shadowColor,
            blurRadius: blurRadius,
            spreadRadius: spreadRadius,
            blurStyle: style,
          ),
        ],
      ),
    );

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // Generous padding so the outer halo is visible even at radius 24.
          Padding(padding: const EdgeInsets.all(20.0), child: box),
          if (caption != null)
            Text(
              caption!,
              style: const TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          if (subCaption != null)
            Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: Text(
                subCaption!,
                style: const TextStyle(fontSize: 10.0, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
            ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SectionHeading: prints to stdout and renders a labelled banner.
// ---------------------------------------------------------------------------
class SectionHeading extends StatelessWidget {
  final int number;
  final String title;
  final String? subtitle;
  final Color color;
  final IconData icon;

  const SectionHeading({
    super.key,
    required this.number,
    required this.title,
    required this.color,
    required this.icon,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 4.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12.0),
        border: Border(left: BorderSide(color: color, width: 5.0)),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 40.0,
            height: 40.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            child: Text(
              '$number',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
          ),
          const SizedBox(width: 14.0),
          Icon(icon, color: color, size: 26.0),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                if (subtitle != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 2.0),
                    child: Text(
                      subtitle!,
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: Colors.black54,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 1: header banner. Big gradient with a chip for every BlurStyle.
// ---------------------------------------------------------------------------
class HeaderBanner extends StatelessWidget {
  const HeaderBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(28.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            cs.primary,
            cs.secondary,
            cs.tertiary,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: cs.primary.withValues(alpha: 0.35),
            blurRadius: 24.0,
            spreadRadius: 2.0,
            offset: const Offset(0, 8),
            blurStyle: BlurStyle.normal,
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          const Icon(Icons.blur_on, size: 64.0, color: Colors.white),
          const SizedBox(height: 10.0),
          const Text(
            'BlurStyle Deep Demo',
            style: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 6.0),
          const Text(
            'dart:ui  -  normal / solid / outer / inner',
            style: TextStyle(fontSize: 14.0, color: Colors.white70),
          ),
          const SizedBox(height: 20.0),
          // Style chips, one per enum value, each carrying its own demo shadow.
          Wrap(
            spacing: 12.0,
            runSpacing: 12.0,
            alignment: WrapAlignment.center,
            children: <Widget>[
              for (final BlurStyle s in _allStyles)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14.0,
                    vertical: 10.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40.0),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.45),
                        blurRadius: 12.0,
                        spreadRadius: 0.0,
                        blurStyle: s,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(_styleIcon(s), size: 18.0, color: cs.primary),
                      const SizedBox(width: 6.0),
                      Text(
                        'BlurStyle.${_styleLabel(s)}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: cs.onSurface,
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
}

// ---------------------------------------------------------------------------
// Section 2: per-style specimen cards. One large card per BlurStyle, each
// holding a hero specimen plus a short narrative.
// ---------------------------------------------------------------------------
class StyleSpecimenCard extends StatelessWidget {
  final BlurStyle style;
  const StyleSpecimenCard({super.key, required this.style});

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final Color accent = _styleAccent(cs, style);
    final Color container = _styleAccentContainer(cs, style);
    return Container(
      width: 260.0,
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        color: container,
        borderRadius: BorderRadius.circular(18.0),
        border: Border.all(color: accent.withValues(alpha: 0.6), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 36.0,
                height: 36.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: accent,
                  shape: BoxShape.circle,
                ),
                child: Icon(_styleIcon(style), color: Colors.white, size: 20.0),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  'BlurStyle.${_styleLabel(style)}',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: accent,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14.0),
          // Hero specimen: thick shadow so the style signature is obvious.
          Center(
            child: BlurSpecimen(
              style: style,
              blurRadius: 18.0,
              spreadRadius: 2.0,
              shadowColor: accent,
              boxColor: cs.surface,
              size: 96.0,
              caption: 'r=18, s=2',
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            _styleDescription(style),
            style: const TextStyle(fontSize: 12.0, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 3: the blurRadius sweep grid. Rows are styles, columns are radii.
// ---------------------------------------------------------------------------
class RadiusSweepGrid extends StatelessWidget {
  const RadiusSweepGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(14.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Header row: empty corner + radius labels.
          Row(
            children: <Widget>[
              const SizedBox(width: 80.0),
              for (final double r in _radiusSweep)
                SizedBox(
                  width: 112.0,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        color: cs.primary.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: Text(
                        'r = ${r.toStringAsFixed(0)}',
                        style: TextStyle(
                          fontSize: 11.0,
                          fontWeight: FontWeight.bold,
                          color: cs.primary,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8.0),
          // One row per BlurStyle.
          for (final BlurStyle s in _allStyles)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 80.0,
                    child: Container(
                      padding: const EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        color: _styleAccent(cs, s).withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: Text(
                        _styleLabel(s),
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: _styleAccent(cs, s),
                        ),
                      ),
                    ),
                  ),
                  for (final double r in _radiusSweep)
                    SizedBox(
                      width: 112.0,
                      child: BlurSpecimen(
                        style: s,
                        blurRadius: r,
                        spreadRadius: 0.0,
                        shadowColor: _styleAccent(cs, s),
                        boxColor: cs.surface,
                        size: 50.0,
                      ),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 4: spreadRadius interaction matrix.
// ---------------------------------------------------------------------------
class SpreadInteractionMatrix extends StatelessWidget {
  const SpreadInteractionMatrix({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(14.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const SizedBox(width: 80.0),
              for (final double sp in _spreadSweep)
                SizedBox(
                  width: 110.0,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        color: cs.secondary.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: Text(
                        'spread ${sp.toStringAsFixed(0)}',
                        style: TextStyle(
                          fontSize: 11.0,
                          fontWeight: FontWeight.bold,
                          color: cs.secondary,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8.0),
          for (final BlurStyle s in _allStyles)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 80.0,
                    child: Container(
                      padding: const EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        color: _styleAccent(cs, s).withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: Text(
                        _styleLabel(s),
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: _styleAccent(cs, s),
                        ),
                      ),
                    ),
                  ),
                  for (final double sp in _spreadSweep)
                    SizedBox(
                      width: 110.0,
                      child: BlurSpecimen(
                        style: s,
                        blurRadius: 10.0,
                        spreadRadius: sp,
                        shadowColor: _styleAccent(cs, s),
                        boxColor: cs.surface,
                        size: 48.0,
                      ),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 5: colour interaction strip. Four palettes x four styles.
// ---------------------------------------------------------------------------
class ColorInteractionStrip extends StatelessWidget {
  const ColorInteractionStrip({super.key});

  // Hand-picked palette / box-color pairs to stress the styles in different
  // luminance regimes.
  static const List<Map<String, dynamic>> _palettes = <Map<String, dynamic>>[
    <String, dynamic>{
      'label': 'warm',
      'shadow': Color(0xFFE53935),
      'box': Color(0xFFFFF3E0),
    },
    <String, dynamic>{
      'label': 'cool',
      'shadow': Color(0xFF1E88E5),
      'box': Color(0xFFE3F2FD),
    },
    <String, dynamic>{
      'label': 'mono',
      'shadow': Color(0xFF212121),
      'box': Color(0xFFFAFAFA),
    },
    <String, dynamic>{
      'label': 'neon',
      'shadow': Color(0xFF00E5FF),
      'box': Color(0xFF0F1E2E),
    },
  ];

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Column(
      children: <Widget>[
        for (final Map<String, dynamic> p in _palettes)
          Container(
            margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: cs.surface,
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(
                color: cs.outlineVariant.withValues(alpha: 0.6),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      width: 18.0,
                      height: 18.0,
                      decoration: BoxDecoration(
                        color: p['shadow'] as Color,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      'palette: ${p['label']}',
                      style: const TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    for (final BlurStyle s in _allStyles)
                      BlurSpecimen(
                        style: s,
                        blurRadius: 14.0,
                        spreadRadius: 1.0,
                        shadowColor: p['shadow'] as Color,
                        boxColor: p['box'] as Color,
                        size: 56.0,
                        caption: _styleLabel(s),
                      ),
                  ],
                ),
              ],
            ),
          ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Section 6: real-world recipes. Each card uses a style for a believable UI
// effect: elevation, glow, inset, sharp edge.
// ---------------------------------------------------------------------------
class ElevationRecipe extends StatelessWidget {
  const ElevationRecipe({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Container(
      width: 220.0,
      height: 140.0,
      margin: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(14.0),
        boxShadow: <BoxShadow>[
          // Classic Material elevation uses BlurStyle.normal.
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.18),
            blurRadius: 16.0,
            spreadRadius: 0.0,
            offset: const Offset(0, 6),
            blurStyle: BlurStyle.normal,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.layers, color: cs.primary, size: 22.0),
                const SizedBox(width: 8.0),
                Text(
                  'Elevation card',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: cs.onSurface,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6.0),
            const Text(
              'BlurStyle.normal\nblurRadius: 16\noffset: (0, 6)',
              style: TextStyle(fontSize: 11.0, color: Colors.black54),
            ),
            const Spacer(),
            Text(
              'Soft drop shadow, the everyday default.',
              style: TextStyle(fontSize: 10.0, color: cs.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}

class GlowRecipe extends StatelessWidget {
  const GlowRecipe({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Container(
      width: 220.0,
      height: 140.0,
      margin: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: const Color(0xFF101820),
        borderRadius: BorderRadius.circular(14.0),
        boxShadow: <BoxShadow>[
          // Neon glow: outer style so the source stays sharp, halo bleeds out.
          BoxShadow(
            color: cs.tertiary,
            blurRadius: 28.0,
            spreadRadius: 4.0,
            blurStyle: BlurStyle.outer,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.bolt, color: cs.tertiary, size: 22.0),
                const SizedBox(width: 8.0),
                const Text(
                  'Glow button',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6.0),
            const Text(
              'BlurStyle.outer\nblurRadius: 28\nspread: 4',
              style: TextStyle(fontSize: 11.0, color: Colors.white70),
            ),
            const Spacer(),
            const Text(
              'Halo only, source untouched.',
              style: TextStyle(fontSize: 10.0, color: Colors.white60),
            ),
          ],
        ),
      ),
    );
  }
}

class InsetRecipe extends StatelessWidget {
  const InsetRecipe({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Container(
      width: 220.0,
      height: 140.0,
      margin: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(14.0),
        boxShadow: <BoxShadow>[
          // Inset look: inner style paints the halo inside the shape.
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.55),
            blurRadius: 18.0,
            spreadRadius: -2.0,
            blurStyle: BlurStyle.inner,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.invert_colors, color: cs.onSurface, size: 22.0),
                const SizedBox(width: 8.0),
                Text(
                  'Inset well',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: cs.onSurface,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6.0),
            const Text(
              'BlurStyle.inner\nblurRadius: 18\nspread: -2',
              style: TextStyle(fontSize: 11.0, color: Colors.black54),
            ),
            const Spacer(),
            Text(
              'Halo painted inside, looks pushed in.',
              style: TextStyle(fontSize: 10.0, color: cs.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}

class SharpRecipe extends StatelessWidget {
  const SharpRecipe({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Container(
      width: 220.0,
      height: 140.0,
      margin: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(14.0),
        boxShadow: <BoxShadow>[
          // Solid keeps the source fully visible and adds a soft halo outside.
          BoxShadow(
            color: cs.primary.withValues(alpha: 0.55),
            blurRadius: 10.0,
            spreadRadius: 2.0,
            blurStyle: BlurStyle.solid,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.crop_square, color: cs.primary, size: 22.0),
                const SizedBox(width: 8.0),
                Text(
                  'Crisp card',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: cs.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6.0),
            const Text(
              'BlurStyle.solid\nblurRadius: 10\nspread: 2',
              style: TextStyle(fontSize: 11.0, color: Colors.black54),
            ),
            const Spacer(),
            Text(
              'Sharp edges with a hint of halo.',
              style: TextStyle(fontSize: 10.0, color: cs.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 7: decision matrix + glossary.
// ---------------------------------------------------------------------------
class DecisionMatrix extends StatelessWidget {
  const DecisionMatrix({super.key});

  static const List<Map<String, String>> _rows = <Map<String, String>>[
    <String, String>{
      'goal': 'Material elevation',
      'style': 'normal',
      'why': 'Soft drop shadow without disturbing the source.',
    },
    <String, String>{
      'goal': 'Neon / focus glow',
      'style': 'outer',
      'why': 'Halo only, source stays crisp.',
    },
    <String, String>{
      'goal': 'Pressed / inset well',
      'style': 'inner',
      'why': 'Shadow painted inside, source feels recessed.',
    },
    <String, String>{
      'goal': 'Bordered chip with halo',
      'style': 'solid',
      'why': 'Source fully opaque plus a fuzzy outer halo.',
    },
    <String, String>{
      'goal': 'Subtle separator',
      'style': 'normal',
      'why': 'Low alpha + small radius = thin underline shadow.',
    },
    <String, String>{
      'goal': 'Status indicator pulse',
      'style': 'outer',
      'why': 'Outer keeps the dot solid while the aura spreads.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: cs.surfaceContainer,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Column(
        children: <Widget>[
          // Header
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: cs.primary,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(14.0),
              ),
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: Text(
                    'Goal',
                    style: TextStyle(
                      color: cs.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Style',
                    style: TextStyle(
                      color: cs.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Text(
                    'Why',
                    style: TextStyle(
                      color: cs.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          for (int i = 0; i < _rows.length; i++)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 10.0,
              ),
              decoration: BoxDecoration(
                color: i.isEven
                    ? cs.surfaceContainerLow
                    : cs.surfaceContainerLowest,
                border: Border(
                  bottom: BorderSide(
                    color: cs.outlineVariant.withValues(alpha: 0.4),
                  ),
                ),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: Text(
                      _rows[i]['goal']!,
                      style: const TextStyle(fontSize: 12.0),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6.0,
                        vertical: 2.0,
                      ),
                      margin: const EdgeInsets.only(right: 8.0),
                      decoration: BoxDecoration(
                        color: cs.tertiaryContainer,
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: Text(
                        _rows[i]['style']!,
                        style: TextStyle(
                          fontSize: 11.0,
                          fontFamily: 'monospace',
                          color: cs.onTertiaryContainer,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Text(
                      _rows[i]['why']!,
                      style: const TextStyle(
                        fontSize: 11.0,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class GlossaryPanel extends StatelessWidget {
  const GlossaryPanel({super.key});

  static const List<Map<String, String>> _entries = <Map<String, String>>[
    <String, String>{
      'term': 'BlurStyle',
      'def':
          'Enum in dart:ui that selects how a Gaussian blur is composed with '
          'its source shape.',
    },
    <String, String>{
      'term': 'normal',
      'def':
          'Pure Gaussian blur. The source is replaced by its blurred copy. '
          'Most common for drop shadows.',
    },
    <String, String>{
      'term': 'solid',
      'def':
          'The source remains opaque, with a Gaussian blur painted around '
          'it. Useful for badges with a halo.',
    },
    <String, String>{
      'term': 'outer',
      'def':
          'Only the blur outside the source is rendered. Perfect for glow '
          'effects that should not bleed onto the source.',
    },
    <String, String>{
      'term': 'inner',
      'def':
          'Only the blur inside the source is rendered. Looks like an inset '
          'or pressed effect.',
    },
    <String, String>{
      'term': 'blurRadius',
      'def':
          'Standard deviation of the Gaussian kernel, in logical pixels. '
          'Larger values are softer and more expensive.',
    },
    <String, String>{
      'term': 'spreadRadius',
      'def':
          'Amount by which the source rect is inflated (or deflated) before '
          'the blur is applied. Combine with negative values for tight inset.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: cs.secondaryContainer,
        borderRadius: BorderRadius.circular(14.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.menu_book, color: cs.onSecondaryContainer),
              const SizedBox(width: 8.0),
              Text(
                'Glossary',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: cs.onSecondaryContainer,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          for (final Map<String, String> e in _entries)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: cs.surface,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      e['term']!,
                      style: TextStyle(
                        fontSize: 13.0,
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.bold,
                        color: cs.primary,
                      ),
                    ),
                    const SizedBox(height: 2.0),
                    Text(
                      e['def']!,
                      style: const TextStyle(fontSize: 11.0),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Recipe code listing - shows the Dart fragments used in section 6.
// ---------------------------------------------------------------------------
class RecipeCodeListing extends StatelessWidget {
  const RecipeCodeListing({super.key});

  static const String _code =
      '// Elevation\n'
      'BoxShadow(\n'
      '  color: Colors.black26,\n'
      '  blurRadius: 16,\n'
      '  offset: Offset(0, 6),\n'
      '  blurStyle: BlurStyle.normal,\n'
      ');\n'
      '\n'
      '// Glow\n'
      'BoxShadow(\n'
      '  color: cs.tertiary,\n'
      '  blurRadius: 28,\n'
      '  spreadRadius: 4,\n'
      '  blurStyle: BlurStyle.outer,\n'
      ');\n'
      '\n'
      '// Inset\n'
      'BoxShadow(\n'
      '  color: Colors.black54,\n'
      '  blurRadius: 18,\n'
      '  spreadRadius: -2,\n'
      '  blurStyle: BlurStyle.inner,\n'
      ');\n'
      '\n'
      '// Crisp / solid\n'
      'BoxShadow(\n'
      '  color: cs.primary.withValues(alpha: 0.55),\n'
      '  blurRadius: 10,\n'
      '  spreadRadius: 2,\n'
      '  blurStyle: BlurStyle.solid,\n'
      ');';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: const Color(0xFF1B1F27),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.code, color: Colors.cyanAccent.shade100, size: 18.0),
              const SizedBox(width: 6.0),
              Text(
                'Recipe code',
                style: TextStyle(
                  color: Colors.cyanAccent.shade100,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Text(
            _code,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.greenAccent.shade100,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Footer summary panel.
// ---------------------------------------------------------------------------
class FooterSummary extends StatelessWidget {
  const FooterSummary({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final List<List<dynamic>> items = <List<dynamic>>[
      <dynamic>[
        Icons.layers,
        'normal',
        'Default drop shadow look',
        cs.primary,
      ],
      <dynamic>[
        Icons.lens,
        'solid',
        'Opaque source + outer halo',
        cs.secondary,
      ],
      <dynamic>[
        Icons.radio_button_unchecked,
        'outer',
        'Halo only, source erased',
        cs.tertiary,
      ],
      <dynamic>[
        Icons.adjust,
        'inner',
        'Halo painted inside source',
        cs.error,
      ],
    ];
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            cs.primaryContainer,
            cs.tertiaryContainer,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Key takeaways',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: cs.onPrimaryContainer,
            ),
          ),
          const SizedBox(height: 12.0),
          for (final List<dynamic> it in items)
            Container(
              margin: const EdgeInsets.symmetric(vertical: 4.0),
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: cs.surface.withValues(alpha: 0.85),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 32.0,
                    height: 32.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: (it[3] as Color).withValues(alpha: 0.18),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      it[0] as IconData,
                      color: it[3] as Color,
                      size: 18.0,
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Text(
                    it[1] as String,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.bold,
                      color: it[3] as Color,
                    ),
                  ),
                  const SizedBox(width: 14.0),
                  Expanded(
                    child: Text(
                      it[2] as String,
                      style: const TextStyle(fontSize: 12.0),
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 6.0),
          Text(
            'Combine blurStyle with blurRadius, spreadRadius and offset to '
            'cover the entire shadow design space without ever leaving '
            'BoxShadow.',
            style: TextStyle(
              fontSize: 11.0,
              color: cs.onPrimaryContainer,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Root widget. Stateless, builds the entire demo tree statically.
// ---------------------------------------------------------------------------
class BlurStyleDemoApp extends StatelessWidget {
  const BlurStyleDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Print every section heading up front so the AST runner gets a trail.
    print('BlurStyle Deep Demo executing');
    print('=== Section 1: Header banner and style chips ===');
    print('=== Section 2: Per-style specimen cards ===');
    print('=== Section 3: blurRadius sweep grid ===');
    print('=== Section 4: spreadRadius interaction matrix ===');
    print('=== Section 5: Color interaction strip ===');
    print('=== Section 6: Real-world recipes ===');
    print('=== Section 7: Decision matrix and glossary ===');
    print('=== Section 8: Footer summary ===');
    for (final BlurStyle s in _allStyles) {
      print('BlurStyle.${_styleLabel(s)} -> ${_styleDescription(s)}');
    }

    final ThemeData theme = ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF4F6BED),
        brightness: Brightness.light,
      ),
      useMaterial3: true,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BlurStyle Deep Demo',
      theme: theme,
      home: Scaffold(
        backgroundColor: theme.colorScheme.surface,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // 1. Header
                const HeaderBanner(),

                // 2. Per-style specimen cards
                const SectionHeading(
                  number: 2,
                  title: 'Per-style specimen cards',
                  subtitle:
                      'One hero specimen for each BlurStyle enum value, '
                      'identical inputs except for blurStyle.',
                  color: Color(0xFF4F6BED),
                  icon: Icons.style,
                ),
                Wrap(
                  alignment: WrapAlignment.center,
                  children: <Widget>[
                    for (final BlurStyle s in _allStyles)
                      StyleSpecimenCard(style: s),
                  ],
                ),

                // 3. Radius sweep grid
                const SectionHeading(
                  number: 3,
                  title: 'blurRadius sweep',
                  subtitle:
                      'Rows are BlurStyle values, columns are blurRadius '
                      '0 / 4 / 8 / 16 / 24.',
                  color: Color(0xFF1E88E5),
                  icon: Icons.grid_view,
                ),
                const RadiusSweepGrid(),

                // 4. Spread interaction
                const SectionHeading(
                  number: 4,
                  title: 'spreadRadius interaction',
                  subtitle:
                      'Fixed blurRadius of 10, sweeping spreadRadius across '
                      '0 / 2 / 4 / 8.',
                  color: Color(0xFF8E24AA),
                  icon: Icons.zoom_out_map,
                ),
                const SpreadInteractionMatrix(),

                // 5. Color interactions
                const SectionHeading(
                  number: 5,
                  title: 'Color interactions',
                  subtitle:
                      'Same geometry across four palettes - warm, cool, '
                      'mono, neon.',
                  color: Color(0xFFEF6C00),
                  icon: Icons.palette,
                ),
                const ColorInteractionStrip(),

                // 6. Real-world recipes
                const SectionHeading(
                  number: 6,
                  title: 'Real-world recipes',
                  subtitle:
                      'Believable UI cards: elevation, glow, inset well, '
                      'crisp / solid.',
                  color: Color(0xFF2E7D32),
                  icon: Icons.lightbulb,
                ),
                const Wrap(
                  alignment: WrapAlignment.center,
                  children: <Widget>[
                    ElevationRecipe(),
                    GlowRecipe(),
                    InsetRecipe(),
                    SharpRecipe(),
                  ],
                ),
                const RecipeCodeListing(),

                // 7. Decision matrix + glossary
                const SectionHeading(
                  number: 7,
                  title: 'Decision matrix and glossary',
                  subtitle:
                      'Pick the right BlurStyle for the job, then look up '
                      'the supporting terms.',
                  color: Color(0xFFC2185B),
                  icon: Icons.fact_check,
                ),
                const DecisionMatrix(),
                const SizedBox(height: 8.0),
                const GlossaryPanel(),

                // 8. Footer summary
                const SectionHeading(
                  number: 8,
                  title: 'Footer summary',
                  subtitle: 'One-line takeaway for every enum value.',
                  color: Color(0xFF455A64),
                  icon: Icons.flag,
                ),
                const FooterSummary(),
                const SizedBox(height: 24.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void main() => runApp(const BlurStyleDemoApp());
