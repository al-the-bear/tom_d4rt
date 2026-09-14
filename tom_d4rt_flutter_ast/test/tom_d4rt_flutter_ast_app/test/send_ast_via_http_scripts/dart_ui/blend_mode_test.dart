// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
//
// D4rt AST visual deep demo for `dart:ui` BlendMode.
//
// DESIGN PLAN
// ===========
// (Hand-authored. Not generated. Not derived from a template.)
//
// Goal: render a single Flutter page that exhaustively illustrates every
// BlendMode value defined in `dart:ui`, grouped by behavioural family so
// that a reader can compare composition strategies at a glance.
//
// Reference scene: each blend mode is shown by drawing a uniform overlay
// (a red circle painted over a fixed teal/blue square gradient base) using
// `ColorFiltered(colorFilter: ColorFilter.mode(<color>, <mode>), ...)`.
// The reference scene is constant across cards so the only visible
// variable is the blend mode itself.
//
// Sections (each prints its own banner string):
//   1  Header gradient banner and concept primer.
//   2  Porter-Duff compositing family (clear..xor).
//   3  Additive and modulative arithmetic (plus, modulate, screen).
//   4  Overlay, hard-light, soft-light family.
//   5  Darken family (darken, multiply, colorBurn).
//   6  Lighten family (lighten, screen, colorDodge).
//   7  Difference, exclusion, contrast operators.
//   8  HSL component swaps (hue, saturation, color, luminosity).
//   9  Recipes - tinting, multiply shading, screen highlights.
//  10  Decision matrix - which mode for which problem.
//  11  Glossary - alpha, premultiplication, source-over default.
//
// All widgets are inert and inline. Material 3 ColorScheme containers
// (primary/secondary/tertiary/error) drive surface accents.

import 'package:flutter/material.dart';

dynamic build(BuildContext context) => const BlendModeDemoApp();

// ---------------------------------------------------------------------------
// Data model: a single comparable swatch for one BlendMode value.
// ---------------------------------------------------------------------------
class _ModeSpec {
  const _ModeSpec(this.mode, this.label, this.note);
  final BlendMode mode;
  final String label;
  final String note;
}

// ---------------------------------------------------------------------------
// Root application widget.
// ---------------------------------------------------------------------------
class BlendModeDemoApp extends StatelessWidget {
  const BlendModeDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    print('BlendMode deep visual demo: bootstrapping MaterialApp');
    final ColorScheme scheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF4F46E5),
      brightness: Brightness.light,
    );
    final ThemeData theme = ThemeData(
      colorScheme: scheme,
      useMaterial3: true,
      textTheme: const TextTheme(
        titleLarge: TextStyle(fontWeight: FontWeight.w700),
      ),
    );
    return MaterialApp(
      title: 'BlendMode Deep Demo',
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: Scaffold(
        backgroundColor: scheme.surface,
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 28.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _buildHeaderBanner(scheme),
              const SizedBox(height: 28.0),
              _buildSectionOne(scheme),
              const SizedBox(height: 32.0),
              _buildSectionTwo(scheme),
              const SizedBox(height: 32.0),
              _buildSectionThree(scheme),
              const SizedBox(height: 32.0),
              _buildSectionFour(scheme),
              const SizedBox(height: 32.0),
              _buildSectionFive(scheme),
              const SizedBox(height: 32.0),
              _buildSectionSix(scheme),
              const SizedBox(height: 32.0),
              _buildSectionSeven(scheme),
              const SizedBox(height: 32.0),
              _buildSectionEight(scheme),
              const SizedBox(height: 32.0),
              _buildSectionNine(scheme),
              const SizedBox(height: 32.0),
              _buildSectionTen(scheme),
              const SizedBox(height: 32.0),
              _buildSectionEleven(scheme),
              const SizedBox(height: 24.0),
              _buildFooterPlate(scheme),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Header banner with gradient and short tagline.
// ---------------------------------------------------------------------------
Widget _buildHeaderBanner(ColorScheme scheme) {
  print('=== Section 0: Header gradient banner ===');
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 26.0, vertical: 32.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          scheme.primary,
          scheme.tertiary,
          scheme.secondary,
        ],
        stops: const <double>[0.0, 0.55, 1.0],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: scheme.primary.withValues(alpha: 0.35),
          blurRadius: 24.0,
          offset: const Offset(0, 10),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 64.0,
          height: 64.0,
          decoration: BoxDecoration(
            color: scheme.onPrimary.withValues(alpha: 0.18),
            shape: BoxShape.circle,
            border: Border.all(color: scheme.onPrimary, width: 2.0),
          ),
          child: Icon(Icons.blender, color: scheme.onPrimary, size: 32.0),
        ),
        const SizedBox(width: 20.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'BlendMode',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.w800,
                  color: scheme.onPrimary,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 6.0),
              Text(
                'Every dart:ui blend mode, side by side, on a common scene',
                style: TextStyle(
                  fontSize: 14.0,
                  color: scheme.onPrimary.withValues(alpha: 0.85),
                ),
              ),
              const SizedBox(height: 10.0),
              Wrap(
                spacing: 8.0,
                runSpacing: 6.0,
                children: <Widget>[
                  _buildBannerChip('Porter-Duff', scheme),
                  _buildBannerChip('Lighten', scheme),
                  _buildBannerChip('Darken', scheme),
                  _buildBannerChip('Contrast', scheme),
                  _buildBannerChip('HSL', scheme),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildBannerChip(String text, ColorScheme scheme) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: scheme.onPrimary.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(40.0),
      border: Border.all(
        color: scheme.onPrimary.withValues(alpha: 0.6),
        width: 1.0,
      ),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: scheme.onPrimary,
        fontSize: 11.0,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.4,
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// The reference scene every mode is applied to.
// Base: a horizontal blue/teal gradient square.
// Overlay: an opaque red circle, centred, tinted by the active BlendMode.
// ---------------------------------------------------------------------------
Widget _buildReferenceScene(BlendMode mode) {
  return SizedBox(
    width: 120.0,
    height: 96.0,
    child: Stack(
      alignment: Alignment.center,
      children: <Widget>[
        // Base: gradient rectangle (the destination).
        Container(
          width: 120.0,
          height: 96.0,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: <Color>[Color(0xFF1565C0), Color(0xFF00ACC1)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        // Yellow band to provide a third reference colour.
        Positioned(
          left: 12.0,
          top: 56.0,
          child: Container(
            width: 96.0,
            height: 18.0,
            decoration: BoxDecoration(
              color: const Color(0xFFFFC107),
              borderRadius: BorderRadius.circular(4.0),
            ),
          ),
        ),
        // Overlay: red circle with active blend.
        ColorFiltered(
          colorFilter: ColorFilter.mode(const Color(0xFFE53935), mode),
          child: Container(
            width: 76.0,
            height: 76.0,
            decoration: const BoxDecoration(
              color: Color(0xFFE53935),
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// A labelled card around a reference scene.
// ---------------------------------------------------------------------------
Widget _buildModeCard(_ModeSpec spec, ColorScheme scheme) {
  return Container(
    width: 156.0,
    margin: const EdgeInsets.all(6.0),
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: scheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(
        color: scheme.outlineVariant,
        width: 1.0,
      ),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: scheme.shadow.withValues(alpha: 0.05),
          blurRadius: 6.0,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: _buildReferenceScene(spec.mode),
        ),
        const SizedBox(height: 8.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
          decoration: BoxDecoration(
            color: scheme.primaryContainer,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            spec.label,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              color: scheme.onPrimaryContainer,
            ),
          ),
        ),
        const SizedBox(height: 6.0),
        Text(
          spec.note,
          style: TextStyle(
            fontSize: 10.5,
            color: scheme.onSurfaceVariant,
            height: 1.3,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Common helper: section title.
// ---------------------------------------------------------------------------
Widget _buildSectionTitle(
  String index,
  String title,
  String subtitle,
  IconData icon,
  ColorScheme scheme,
) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Container(
        width: 44.0,
        height: 44.0,
        decoration: BoxDecoration(
          color: scheme.secondaryContainer,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Icon(icon, color: scheme.onSecondaryContainer, size: 22.0),
      ),
      const SizedBox(width: 14.0),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 2.0),
                  decoration: BoxDecoration(
                    color: scheme.tertiaryContainer,
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Text(
                    index,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: scheme.onTertiaryContainer,
                      fontSize: 12.0,
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w800,
                    color: scheme.onSurface,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2.0),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 12.5,
                color: scheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// SECTION 1: Concept primer.
// ---------------------------------------------------------------------------
Widget _buildSectionOne(ColorScheme scheme) {
  print('=== Section 1: Concept primer (source vs destination) ===');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _buildSectionTitle(
        '01',
        'Source over destination',
        'The mental model behind every BlendMode value',
        Icons.layers_outlined,
        scheme,
      ),
      const SizedBox(height: 14.0),
      Container(
        padding: const EdgeInsets.all(18.0),
        decoration: BoxDecoration(
          color: scheme.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: scheme.outlineVariant),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Source (src) is what you are drawing right now. Destination (dst) is whatever is already on the canvas. A BlendMode is a pure function of two premultiplied RGBA pixels that returns a third pixel; Skia walks every pixel of the source primitive and asks the mode "given this src and this dst, what should I write back?".',
              style: TextStyle(
                fontSize: 13.0,
                color: scheme.onSurface,
                height: 1.45,
              ),
            ),
            const SizedBox(height: 14.0),
            Row(
              children: <Widget>[
                Expanded(
                  child: _buildConceptTile(
                    'src',
                    'The shape, image, or paint you are about to draw.',
                    const Color(0xFFE53935),
                    Icons.brush,
                    scheme,
                  ),
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: _buildConceptTile(
                    'dst',
                    'Existing canvas contents below the new draw call.',
                    const Color(0xFF1565C0),
                    Icons.layers,
                    scheme,
                  ),
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: _buildConceptTile(
                    'result',
                    'BlendMode(src, dst). Always premultiplied RGBA.',
                    scheme.tertiary,
                    Icons.auto_awesome,
                    scheme,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18.0),
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: scheme.primaryContainer.withValues(alpha: 0.55),
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: scheme.primary.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: <Widget>[
                  Icon(Icons.info_outline, color: scheme.onPrimaryContainer),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: Text(
                      'BlendMode.srcOver is the default. Almost every Flutter draw call uses it implicitly; the other 28 modes only show up when you opt in via Paint.blendMode, ColorFilter.mode, ShaderMask, or saveLayer.',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: scheme.onPrimaryContainer,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 16.0),
      Container(
        padding: const EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: scheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: scheme.outlineVariant),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Reference scene used throughout this demo',
              style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w700,
                color: scheme.onSurface,
              ),
            ),
            const SizedBox(height: 10.0),
            Row(
              children: <Widget>[
                _buildReferenceScene(BlendMode.srcOver),
                const SizedBox(width: 14.0),
                Expanded(
                  child: Text(
                    'A blue/teal gradient rectangle plays the role of destination. '
                    'A red circle (with a yellow accent band beneath it) is the '
                    'source. Every card below shows the same scene under a different '
                    'BlendMode, so you can compare modes pixel for pixel.',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: scheme.onSurfaceVariant,
                      height: 1.45,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _buildConceptTile(
  String title,
  String body,
  Color accent,
  IconData icon,
  ColorScheme scheme,
) {
  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: accent.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: accent.withValues(alpha: 0.4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(icon, color: accent, size: 18.0),
            const SizedBox(width: 6.0),
            Text(
              title,
              style: TextStyle(
                fontFamily: 'monospace',
                fontWeight: FontWeight.w800,
                color: accent,
                fontSize: 13.0,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        Text(
          body,
          style: TextStyle(
            fontSize: 11.5,
            color: scheme.onSurfaceVariant,
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 2: Porter-Duff compositing family.
// ---------------------------------------------------------------------------
Widget _buildSectionTwo(ColorScheme scheme) {
  print('=== Section 2: Porter-Duff compositing family ===');
  const List<_ModeSpec> specs = <_ModeSpec>[
    _ModeSpec(BlendMode.clear, 'clear',
        'Both src and dst are erased; result is fully transparent.'),
    _ModeSpec(BlendMode.src, 'src',
        'Replace dst with src. Destination is completely discarded.'),
    _ModeSpec(BlendMode.dst, 'dst',
        'Keep dst as is. The source is drawn but contributes nothing.'),
    _ModeSpec(BlendMode.srcOver, 'srcOver',
        'Default. Source painted over destination using src alpha.'),
    _ModeSpec(BlendMode.dstOver, 'dstOver',
        'Destination painted over source - source fills only gaps.'),
    _ModeSpec(BlendMode.srcIn, 'srcIn',
        'Show src only where dst is opaque. Destination is the mask.'),
    _ModeSpec(BlendMode.dstIn, 'dstIn',
        'Show dst only where src is opaque. Source is the mask.'),
    _ModeSpec(BlendMode.srcOut, 'srcOut',
        'Show src only outside dst alpha. Inverse of srcIn.'),
    _ModeSpec(BlendMode.dstOut, 'dstOut',
        'Show dst only outside src alpha. Punch a hole using src.'),
    _ModeSpec(BlendMode.srcATop, 'srcATop',
        'Src drawn atop dst, clipped to dst alpha; dst retained outside.'),
    _ModeSpec(BlendMode.dstATop, 'dstATop',
        'Dst drawn atop src, clipped to src alpha; src retained outside.'),
    _ModeSpec(BlendMode.xor, 'xor',
        'Symmetric difference of alphas; overlap becomes transparent.'),
  ];
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _buildSectionTitle(
        '02',
        'Porter-Duff compositing',
        'The twelve original alpha-only operators from Porter and Duff (1984)',
        Icons.join_full_outlined,
        scheme,
      ),
      const SizedBox(height: 12.0),
      Wrap(
        alignment: WrapAlignment.start,
        children: specs.map((_ModeSpec s) => _buildModeCard(s, scheme)).toList(),
      ),
      const SizedBox(height: 14.0),
      _buildAdvicePlate(
        'Porter-Duff is purely about alpha bookkeeping. None of these twelve '
        'modes invent new colour data - they only decide which of src or dst '
        'contributes its colour at every pixel. Use them when you want a '
        'shape to behave as a clip, a mask, or a hole-puncher.',
        Icons.shield_moon_outlined,
        scheme.primary,
        scheme,
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// SECTION 3: Arithmetic / additive family.
// ---------------------------------------------------------------------------
Widget _buildSectionThree(ColorScheme scheme) {
  print('=== Section 3: Arithmetic and additive family ===');
  const List<_ModeSpec> specs = <_ModeSpec>[
    _ModeSpec(BlendMode.plus, 'plus',
        'Channel-wise sum, clamped to 1.0. Brighter, often blown out.'),
    _ModeSpec(BlendMode.modulate, 'modulate',
        'Channel-wise product. Black stays black, white preserves dst.'),
    _ModeSpec(BlendMode.screen, 'screen',
        '1 - (1-src)(1-dst). Inverse multiply; always brightens.'),
  ];
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _buildSectionTitle(
        '03',
        'Arithmetic blends',
        'Closed-form formulas on premultiplied RGB; no conditionals',
        Icons.calculate_outlined,
        scheme,
      ),
      const SizedBox(height: 12.0),
      Wrap(
        children: specs.map((_ModeSpec s) => _buildModeCard(s, scheme)).toList(),
      ),
      const SizedBox(height: 14.0),
      _buildFormulaBlock(
        title: 'Per-channel formulas',
        rows: const <List<String>>[
          <String>['plus', 'r = min(1, src + dst)'],
          <String>['modulate', 'r = src * dst'],
          <String>['screen', 'r = 1 - (1 - src) * (1 - dst)'],
        ],
        scheme: scheme,
      ),
      const SizedBox(height: 14.0),
      _buildAdvicePlate(
        'plus and screen are the cornerstones of "additive" lighting. plus '
        'risks hard clipping when both sides are bright; screen is the safe '
        'alternative because its result is always in [0,1]. modulate is the '
        'standard way to tint a fully opaque image.',
        Icons.lightbulb_outline,
        scheme.tertiary,
        scheme,
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// SECTION 4: Overlay / hard light / soft light.
// ---------------------------------------------------------------------------
Widget _buildSectionFour(ColorScheme scheme) {
  print('=== Section 4: Overlay and light family ===');
  const List<_ModeSpec> specs = <_ModeSpec>[
    _ModeSpec(BlendMode.overlay, 'overlay',
        'Multiply or screen depending on dst luminance; punchy contrast.'),
    _ModeSpec(BlendMode.hardLight, 'hardLight',
        'Like overlay but pivot on src; harsher than soft light.'),
    _ModeSpec(BlendMode.softLight, 'softLight',
        'Smooth S-curve around 0.5 in src; gentle dodging and burning.'),
  ];
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _buildSectionTitle(
        '04',
        'Overlay and light',
        'Conditional blends that boost contrast based on luminance',
        Icons.contrast,
        scheme,
      ),
      const SizedBox(height: 12.0),
      Wrap(
        children: specs.map((_ModeSpec s) => _buildModeCard(s, scheme)).toList(),
      ),
      const SizedBox(height: 14.0),
      Container(
        padding: const EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: scheme.tertiaryContainer.withValues(alpha: 0.45),
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: scheme.tertiary.withValues(alpha: 0.35)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Pivot intuition',
              style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w700,
                color: scheme.onTertiaryContainer,
              ),
            ),
            const SizedBox(height: 6.0),
            Text(
              'overlay branches on dst < 0.5 to either multiply (darken) or '
              'screen (lighten). hardLight does the same with the src side as '
              'the pivot, so swapping the two layers swaps overlay and '
              'hardLight. softLight is a Photoshop-style smoothed variant '
              'that never produces values outside the [0,1] range.',
              style: TextStyle(
                fontSize: 12.0,
                color: scheme.onTertiaryContainer,
                height: 1.45,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// SECTION 5: Darken family.
// ---------------------------------------------------------------------------
Widget _buildSectionFive(ColorScheme scheme) {
  print('=== Section 5: Darken family ===');
  const List<_ModeSpec> specs = <_ModeSpec>[
    _ModeSpec(BlendMode.darken, 'darken',
        'Per-channel minimum of src and dst. Result is never brighter.'),
    _ModeSpec(BlendMode.multiply, 'multiply',
        'src * dst including alpha; classic shadow / shading operator.'),
    _ModeSpec(BlendMode.colorBurn, 'colorBurn',
        'Saturates and darkens dst proportionally to inverse of src.'),
  ];
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _buildSectionTitle(
        '05',
        'Darken family',
        'Operators that can only produce values <= the destination',
        Icons.dark_mode_outlined,
        scheme,
      ),
      const SizedBox(height: 12.0),
      Wrap(
        children: specs.map((_ModeSpec s) => _buildModeCard(s, scheme)).toList(),
      ),
      const SizedBox(height: 14.0),
      _buildFormulaBlock(
        title: 'Darken formulas',
        rows: const <List<String>>[
          <String>['darken', 'r = min(src, dst)'],
          <String>['multiply', 'r = src * dst'],
          <String>['colorBurn', 'r = 1 - min(1, (1 - dst) / src)'],
        ],
        scheme: scheme,
      ),
      const SizedBox(height: 14.0),
      _buildAdvicePlate(
        'When in doubt, reach for multiply. It is the only darken mode that '
        'commutes (src*dst == dst*src), it works correctly with premultiplied '
        'alpha, and it does not blow out chroma like colorBurn can.',
        Icons.dark_mode,
        scheme.error,
        scheme,
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// SECTION 6: Lighten family.
// ---------------------------------------------------------------------------
Widget _buildSectionSix(ColorScheme scheme) {
  print('=== Section 6: Lighten family ===');
  const List<_ModeSpec> specs = <_ModeSpec>[
    _ModeSpec(BlendMode.lighten, 'lighten',
        'Per-channel maximum of src and dst. Result is never darker.'),
    _ModeSpec(BlendMode.screen, 'screen',
        'Inverse multiply. Classic "glow" / highlight pass.'),
    _ModeSpec(BlendMode.colorDodge, 'colorDodge',
        'Brightens dst proportionally to src; pushes towards white.'),
  ];
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _buildSectionTitle(
        '06',
        'Lighten family',
        'Operators that can only produce values >= the destination',
        Icons.light_mode_outlined,
        scheme,
      ),
      const SizedBox(height: 12.0),
      Wrap(
        children: specs.map((_ModeSpec s) => _buildModeCard(s, scheme)).toList(),
      ),
      const SizedBox(height: 14.0),
      _buildFormulaBlock(
        title: 'Lighten formulas',
        rows: const <List<String>>[
          <String>['lighten', 'r = max(src, dst)'],
          <String>['screen', 'r = 1 - (1 - src) * (1 - dst)'],
          <String>['colorDodge', 'r = min(1, dst / (1 - src))'],
        ],
        scheme: scheme,
      ),
      const SizedBox(height: 14.0),
      _buildAdvicePlate(
        'screen is to lighten what multiply is to darken: well-behaved, '
        'commutative, and numerically stable. Reach for colorDodge only when '
        'you intentionally want highlights to saturate towards pure white.',
        Icons.light_mode,
        scheme.secondary,
        scheme,
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// SECTION 7: Difference, exclusion, contrast operators.
// ---------------------------------------------------------------------------
Widget _buildSectionSeven(ColorScheme scheme) {
  print('=== Section 7: Difference and exclusion ===');
  const List<_ModeSpec> specs = <_ModeSpec>[
    _ModeSpec(BlendMode.difference, 'difference',
        'abs(src - dst); produces inverted, high-contrast result.'),
    _ModeSpec(BlendMode.exclusion, 'exclusion',
        'src + dst - 2*src*dst; softer variant of difference.'),
  ];
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _buildSectionTitle(
        '07',
        'Difference and exclusion',
        'Symmetric, invertible operators that invert when src is white',
        Icons.compare_arrows,
        scheme,
      ),
      const SizedBox(height: 12.0),
      Wrap(
        children: specs.map((_ModeSpec s) => _buildModeCard(s, scheme)).toList(),
      ),
      const SizedBox(height: 14.0),
      _buildFormulaBlock(
        title: 'Difference formulas',
        rows: const <List<String>>[
          <String>['difference', 'r = abs(src - dst)'],
          <String>['exclusion', 'r = src + dst - 2 * src * dst'],
        ],
        scheme: scheme,
      ),
      const SizedBox(height: 14.0),
      _buildAdvicePlate(
        'difference with src == white inverts the destination, which is the '
        'classic trick used to build "invert colours" filters. exclusion is '
        'gentler: mid-grey produces mid-grey instead of pulling everything '
        'to black.',
        Icons.invert_colors,
        scheme.primary,
        scheme,
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// SECTION 8: HSL component swaps.
// ---------------------------------------------------------------------------
Widget _buildSectionEight(ColorScheme scheme) {
  print('=== Section 8: HSL component swap operators ===');
  const List<_ModeSpec> specs = <_ModeSpec>[
    _ModeSpec(BlendMode.hue, 'hue',
        'Use src hue, keep dst saturation and luminosity.'),
    _ModeSpec(BlendMode.saturation, 'saturation',
        'Use src saturation, keep dst hue and luminosity.'),
    _ModeSpec(BlendMode.color, 'color',
        'Use src hue and saturation, keep dst luminosity.'),
    _ModeSpec(BlendMode.luminosity, 'luminosity',
        'Use src luminosity, keep dst hue and saturation.'),
  ];
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _buildSectionTitle(
        '08',
        'HSL component swaps',
        'Operators that work in HSL space rather than per-RGB-channel',
        Icons.palette_outlined,
        scheme,
      ),
      const SizedBox(height: 12.0),
      Wrap(
        children: specs.map((_ModeSpec s) => _buildModeCard(s, scheme)).toList(),
      ),
      const SizedBox(height: 14.0),
      Container(
        padding: const EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: scheme.secondaryContainer.withValues(alpha: 0.55),
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: scheme.secondary.withValues(alpha: 0.4)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Component mnemonic',
              style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w800,
                color: scheme.onSecondaryContainer,
              ),
            ),
            const SizedBox(height: 6.0),
            _buildHslRow('hue', 'H', 'src', 'S/L', 'dst', scheme),
            _buildHslRow('saturation', 'S', 'src', 'H/L', 'dst', scheme),
            _buildHslRow('color', 'H+S', 'src', 'L', 'dst', scheme),
            _buildHslRow('luminosity', 'L', 'src', 'H+S', 'dst', scheme),
            const SizedBox(height: 8.0),
            Text(
              'color is the canonical "recolour without losing shading" mode. '
              'luminosity is its inverse: keep the colour, change the value.',
              style: TextStyle(
                fontSize: 11.5,
                color: scheme.onSecondaryContainer,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _buildHslRow(
  String name,
  String srcParts,
  String srcLabel,
  String dstParts,
  String dstLabel,
  ColorScheme scheme,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      children: <Widget>[
        SizedBox(
          width: 86.0,
          child: Text(
            name,
            style: TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.w700,
              color: scheme.onSecondaryContainer,
              fontSize: 12.0,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
          decoration: BoxDecoration(
            color: scheme.primary.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            '$srcParts from $srcLabel',
            style: TextStyle(
              fontSize: 11.0,
              color: scheme.onSecondaryContainer,
            ),
          ),
        ),
        const SizedBox(width: 6.0),
        Icon(
          Icons.add,
          size: 14.0,
          color: scheme.onSecondaryContainer,
        ),
        const SizedBox(width: 6.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
          decoration: BoxDecoration(
            color: scheme.tertiary.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            '$dstParts from $dstLabel',
            style: TextStyle(
              fontSize: 11.0,
              color: scheme.onSecondaryContainer,
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 9: Practical recipes.
// ---------------------------------------------------------------------------
Widget _buildSectionNine(ColorScheme scheme) {
  print('=== Section 9: Practical recipes ===');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _buildSectionTitle(
        '09',
        'Practical recipes',
        'Idiomatic ways to reach for the right BlendMode for a real task',
        Icons.menu_book_outlined,
        scheme,
      ),
      const SizedBox(height: 12.0),
      Wrap(
        spacing: 12.0,
        runSpacing: 12.0,
        children: <Widget>[
          _buildRecipeCard(
            scheme,
            heading: 'Tint an image with a brand colour',
            mode: BlendMode.modulate,
            beforeWidget: _buildRecipePhoto(scheme),
            afterWidget: ColorFiltered(
              colorFilter: ColorFilter.mode(
                scheme.primary.withValues(alpha: 0.85),
                BlendMode.modulate,
              ),
              child: _buildRecipePhoto(scheme),
            ),
            code:
                "ColorFiltered(\n  colorFilter: ColorFilter.mode(\n    scheme.primary,\n    BlendMode.modulate,\n  ),\n  child: Image.network(url),\n)",
            tip: 'modulate multiplies channels so white pixels become the tint',
          ),
          _buildRecipeCard(
            scheme,
            heading: 'Painted shadow under a sticker',
            mode: BlendMode.multiply,
            beforeWidget: _buildRecipePhoto(scheme),
            afterWidget: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                _buildRecipePhoto(scheme),
                Positioned(
                  bottom: 8.0,
                  child: ColorFiltered(
                    colorFilter: const ColorFilter.mode(
                      Color(0x66000000),
                      BlendMode.multiply,
                    ),
                    child: Container(
                      width: 80.0,
                      height: 18.0,
                      decoration: const BoxDecoration(
                        color: Color(0xFF000000),
                        borderRadius: BorderRadius.all(Radius.circular(40.0)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            code:
                "ColorFiltered(\n  colorFilter: ColorFilter.mode(\n    Colors.black54,\n    BlendMode.multiply,\n  ),\n  child: shadowEllipse,\n)",
            tip: 'multiply with a dark colour darkens uniformly without halos',
          ),
          _buildRecipeCard(
            scheme,
            heading: 'Highlight glow / specular dot',
            mode: BlendMode.screen,
            beforeWidget: _buildRecipePhoto(scheme),
            afterWidget: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                _buildRecipePhoto(scheme),
                ColorFiltered(
                  colorFilter: const ColorFilter.mode(
                    Color(0xFFFFFFFF),
                    BlendMode.screen,
                  ),
                  child: Container(
                    width: 36.0,
                    height: 36.0,
                    decoration: const BoxDecoration(
                      color: Color(0x99FFFFFF),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
            code:
                "ColorFiltered(\n  colorFilter: ColorFilter.mode(\n    Colors.white,\n    BlendMode.screen,\n  ),\n  child: glowDot,\n)",
            tip: 'screen with white pushes affected pixels towards bright',
          ),
          _buildRecipeCard(
            scheme,
            heading: 'Punch a hole through a panel',
            mode: BlendMode.dstOut,
            beforeWidget: _buildRecipePhoto(scheme),
            afterWidget: ShaderMask(
              shaderCallback: (Rect bounds) => const RadialGradient(
                colors: <Color>[Color(0x00000000), Color(0xFF000000)],
                stops: <double>[0.45, 0.55],
              ).createShader(bounds),
              blendMode: BlendMode.dstOut,
              child: _buildRecipePhoto(scheme),
            ),
            code:
                "ShaderMask(\n  blendMode: BlendMode.dstOut,\n  shaderCallback: (r) => holeGradient.createShader(r),\n  child: panel,\n)",
            tip: 'dstOut erases dst wherever the mask is opaque',
          ),
        ],
      ),
    ],
  );
}

Widget _buildRecipePhoto(ColorScheme scheme) {
  return Container(
    width: 140.0,
    height: 86.0,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          scheme.primaryContainer,
          scheme.tertiaryContainer,
          scheme.secondaryContainer,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: scheme.outlineVariant),
    ),
    alignment: Alignment.center,
    child: Icon(
      Icons.image_outlined,
      color: scheme.onSurface.withValues(alpha: 0.7),
      size: 36.0,
    ),
  );
}

Widget _buildRecipeCard(
  ColorScheme scheme, {
  required String heading,
  required BlendMode mode,
  required Widget beforeWidget,
  required Widget afterWidget,
  required String code,
  required String tip,
}) {
  return Container(
    width: 340.0,
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: scheme.surfaceContainerHigh,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: scheme.outlineVariant),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: scheme.primaryContainer,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text(
                mode.toString().split('.').last,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w800,
                  color: scheme.onPrimaryContainer,
                  fontSize: 11.0,
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                heading,
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w700,
                  color: scheme.onSurface,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Row(
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  beforeWidget,
                  const SizedBox(height: 4.0),
                  Text('before',
                      style: TextStyle(
                          fontSize: 10.0, color: scheme.onSurfaceVariant)),
                ],
              ),
            ),
            Icon(Icons.east, color: scheme.outline),
            Expanded(
              child: Column(
                children: <Widget>[
                  afterWidget,
                  const SizedBox(height: 4.0),
                  Text('after',
                      style: TextStyle(
                          fontSize: 10.0, color: scheme.onSurfaceVariant)),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: scheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            code,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.5,
              color: scheme.onSurface,
              height: 1.4,
            ),
          ),
        ),
        const SizedBox(height: 6.0),
        Row(
          children: <Widget>[
            Icon(Icons.tips_and_updates_outlined,
                size: 14.0, color: scheme.tertiary),
            const SizedBox(width: 6.0),
            Expanded(
              child: Text(
                tip,
                style: TextStyle(
                  fontSize: 11.0,
                  color: scheme.onSurfaceVariant,
                  height: 1.35,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 10: Decision matrix.
// ---------------------------------------------------------------------------
Widget _buildSectionTen(ColorScheme scheme) {
  print('=== Section 10: Decision matrix ===');
  final List<List<String>> matrix = <List<String>>[
    <String>['Goal', 'Use', 'Notes'],
    <String>['Default draw', 'srcOver', 'You almost never need to override this'],
    <String>['Tint an icon', 'modulate', 'Or srcIn if alpha mask is the goal'],
    <String>['Recolour image but keep shading', 'color', 'HSL mode; preserves L'],
    <String>['Paint a shadow / shading', 'multiply', 'Commutes, stays in range'],
    <String>['Highlight / glow', 'screen', 'Inverse of multiply'],
    <String>['Erase part of a layer', 'dstOut', 'Source acts as a hole punch'],
    <String>['Clip to silhouette', 'srcIn', 'Source survives only inside dst'],
    <String>['Invert colours', 'difference', 'with src = white'],
    <String>['Boost contrast', 'overlay', 'Pivot on dst at 0.5'],
    <String>['Soft retouch / dodge-burn', 'softLight', 'Gentle, in-range'],
    <String>['Composite atop existing alpha', 'srcATop', 'Common for stickers'],
    <String>['Clear region', 'clear', 'Forces transparency'],
  ];
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _buildSectionTitle(
        '10',
        'Decision matrix',
        'Pick the right BlendMode by starting from the goal, not the name',
        Icons.account_tree_outlined,
        scheme,
      ),
      const SizedBox(height: 12.0),
      Container(
        decoration: BoxDecoration(
          color: scheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: scheme.outlineVariant),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: <Widget>[
            for (int i = 0; i < matrix.length; i++)
              Container(
                color: i == 0
                    ? scheme.primaryContainer
                    : (i.isEven
                        ? scheme.surfaceContainerHighest
                        : scheme.surfaceContainerLow),
                padding: const EdgeInsets.symmetric(
                    horizontal: 14.0, vertical: 10.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 5,
                      child: Text(
                        matrix[i][0],
                        style: TextStyle(
                          fontWeight: i == 0 ? FontWeight.w800 : FontWeight.w500,
                          fontSize: 12.5,
                          color: i == 0
                              ? scheme.onPrimaryContainer
                              : scheme.onSurface,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        matrix[i][1],
                        style: TextStyle(
                          fontFamily: i == 0 ? null : 'monospace',
                          fontWeight: FontWeight.w700,
                          fontSize: 12.5,
                          color: i == 0
                              ? scheme.onPrimaryContainer
                              : scheme.primary,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: Text(
                        matrix[i][2],
                        style: TextStyle(
                          fontStyle:
                              i == 0 ? FontStyle.normal : FontStyle.italic,
                          fontSize: 11.5,
                          color: i == 0
                              ? scheme.onPrimaryContainer
                              : scheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// SECTION 11: Glossary.
// ---------------------------------------------------------------------------
Widget _buildSectionEleven(ColorScheme scheme) {
  print('=== Section 11: Glossary ===');
  final List<List<String>> terms = <List<String>>[
    <String>[
      'Premultiplied alpha',
      'RGB channels are already multiplied by alpha before blending. Skia '
          'operates in this space, which is why src*dst respects transparency.',
    ],
    <String>[
      'Compositing operator',
      'A pure function (src, dst) -> result on premultiplied RGBA. BlendMode '
          'values are the operators Skia exposes.',
    ],
    <String>[
      'Porter-Duff',
      'The 1984 paper that defined the 12 alpha-only compositing operators '
          '(clear, src, dst, srcOver, dstOver, srcIn, dstIn, srcOut, dstOut, '
          'srcATop, dstATop, xor).',
    ],
    <String>[
      'Source / destination',
      'Source is what is being drawn right now; destination is what was '
          'already on the canvas. Some modes are asymmetric in these roles.',
    ],
    <String>[
      'Commutative',
      'A mode where blend(a, b) == blend(b, a). multiply, screen, difference, '
          'exclusion, plus, darken and lighten are commutative; overlay and '
          'hardLight are not.',
    ],
    <String>[
      'Saturating',
      'A mode that clamps results back into [0,1]. plus and colorDodge are '
          'the famously saturating modes - they can crush to pure white.',
    ],
    <String>[
      'HSL component swap',
      'hue, saturation, color, luminosity all work in HSL: take some '
          'components from src and the rest from dst, then convert back to RGB.',
    ],
    <String>[
      'saveLayer',
      'Many BlendMode values only behave as documented when applied to an '
          'isolated layer. Flutter widgets like ColorFiltered, ShaderMask and '
          'BackdropFilter handle this for you.',
    ],
  ];
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _buildSectionTitle(
        '11',
        'Glossary',
        'Vocabulary for talking precisely about compositing',
        Icons.menu_book,
        scheme,
      ),
      const SizedBox(height: 12.0),
      Column(
        children: <Widget>[
          for (final List<String> term in terms)
            Container(
              margin: const EdgeInsets.only(bottom: 10.0),
              padding: const EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                color: scheme.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: scheme.outlineVariant),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 36.0,
                    height: 36.0,
                    decoration: BoxDecoration(
                      color: scheme.tertiaryContainer,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Icon(
                      Icons.bookmark_border,
                      size: 18.0,
                      color: scheme.onTertiaryContainer,
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          term[0],
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 13.5,
                            color: scheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          term[1],
                          style: TextStyle(
                            fontSize: 12.0,
                            color: scheme.onSurfaceVariant,
                            height: 1.45,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Shared helpers - formula block and advice plate.
// ---------------------------------------------------------------------------
Widget _buildFormulaBlock({
  required String title,
  required List<List<String>> rows,
  required ColorScheme scheme,
}) {
  return Container(
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: const Color(0xFF0F172A),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(Icons.functions, size: 18.0, color: Color(0xFF22D3EE)),
            const SizedBox(width: 6.0),
            Text(
              title,
              style: const TextStyle(
                color: Color(0xFF22D3EE),
                fontWeight: FontWeight.w800,
                fontSize: 12.5,
                letterSpacing: 0.4,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        for (final List<String> row in rows)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 110.0,
                  child: Text(
                    row[0],
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      color: Color(0xFFFDE68A),
                      fontSize: 12.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    row[1],
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      color: Color(0xFFA7F3D0),
                      fontSize: 12.0,
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

Widget _buildAdvicePlate(
  String body,
  IconData icon,
  Color accent,
  ColorScheme scheme,
) {
  return Container(
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: accent.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: accent.withValues(alpha: 0.35)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 32.0,
          height: 32.0,
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: accent, size: 18.0),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: Text(
            body,
            style: TextStyle(
              fontSize: 12.0,
              height: 1.5,
              color: scheme.onSurface,
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Footer plate.
// ---------------------------------------------------------------------------
Widget _buildFooterPlate(ColorScheme scheme) {
  return Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: scheme.errorContainer.withValues(alpha: 0.35),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: scheme.error.withValues(alpha: 0.3)),
    ),
    child: Row(
      children: <Widget>[
        Icon(Icons.warning_amber_rounded, color: scheme.error),
        const SizedBox(width: 10.0),
        Expanded(
          child: Text(
            'Some BlendMode values are no-ops on a single draw call without an '
            'isolation layer. If a mode looks like srcOver, wrap your subtree '
            'in ColorFiltered, ShaderMask, or a Canvas.saveLayer call to give '
            'Skia an explicit destination to blend against.',
            style: TextStyle(
              fontSize: 12.0,
              color: scheme.onErrorContainer,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}
