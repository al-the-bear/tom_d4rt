// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
//
// =====================================================================
// dart:ui BackdropFilterEngineLayer - Hand-authored deep visual demo
// =====================================================================
//
// Design plan:
//
// BackdropFilterEngineLayer is an internal engine-side layer object that
// Flutter creates whenever a BackdropFilter widget participates in the
// scene graph. It is not directly instantiable from Dart code; it is
// produced indirectly by SceneBuilder.pushBackdropFilter, which is in
// turn invoked by the BackdropFilter widget's render object during the
// rendering pipeline. The layer's job is to read pixels already drawn
// behind the current paint layer, apply an ImageFilter to those pixels,
// and then composite the result with an optional BlendMode under a
// clipped region.
//
// This demo treats the engine-layer abstraction as the subject and
// surfaces its observable behaviour through the BackdropFilter widget
// and the full ImageFilter family: blur, dilate, erode, matrix, and
// compose. Every section renders genuine Flutter widgets over rich
// gradient or photographic-style backdrops so that the filter effect
// is visible and pedagogically clear.
//
// Sections:
//   1. Header gradient banner introducing the layer object.
//   2. ImageFilter.blur catalogue across sigma values.
//   3. Asymmetric (sigmaX vs sigmaY) directional blur grid.
//   4. ImageFilter.dilate and ImageFilter.erode morphology pair.
//   5. ImageFilter.matrix translation / scale / rotation panel.
//   6. ImageFilter.compose stacking demonstration.
//   7. BlendMode showcase over a frosted-glass backdrop.
//   8. Engine layer relationship box diagram.
//   9. Recipe gallery: frosted card, blurred header, modal scrim.
//  10. Glossary and final summary panel.
//
// Constraints: no async, no Timer, no Navigator, no showDialog; the
// root widget is stateless and the program ends with runApp.
//
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

void main() => runApp(const BackdropFilterDemoApp());

// =====================================================================
// Root application widget
// =====================================================================
class BackdropFilterDemoApp extends StatelessWidget {
  const BackdropFilterDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    print('BackdropFilterEngineLayer deep demo starting');
    final ColorScheme scheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF3F51B5),
      brightness: Brightness.light,
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BackdropFilterEngineLayer Demo',
      theme: ThemeData(useMaterial3: true, colorScheme: scheme),
      home: Scaffold(
        backgroundColor: scheme.surface,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _HeaderBanner(scheme: scheme),
              const SizedBox(height: 28.0),
              _SectionHeader(
                index: 1,
                title: 'Header & Subject Introduction',
                scheme: scheme,
              ),
              _IntroPanel(scheme: scheme),
              const SizedBox(height: 28.0),
              _SectionHeader(
                index: 2,
                title: 'ImageFilter.blur Sigma Catalogue',
                scheme: scheme,
              ),
              _BlurSigmaCatalogue(scheme: scheme),
              const SizedBox(height: 28.0),
              _SectionHeader(
                index: 3,
                title: 'Directional Blur (sigmaX vs sigmaY)',
                scheme: scheme,
              ),
              _DirectionalBlurGrid(scheme: scheme),
              const SizedBox(height: 28.0),
              _SectionHeader(
                index: 4,
                title: 'Morphology: Dilate and Erode',
                scheme: scheme,
              ),
              _MorphologyPanel(scheme: scheme),
              const SizedBox(height: 28.0),
              _SectionHeader(
                index: 5,
                title: 'ImageFilter.matrix Transforms',
                scheme: scheme,
              ),
              _MatrixFilterPanel(scheme: scheme),
              const SizedBox(height: 28.0),
              _SectionHeader(
                index: 6,
                title: 'ImageFilter.compose Stacking',
                scheme: scheme,
              ),
              _ComposeFilterPanel(scheme: scheme),
              const SizedBox(height: 28.0),
              _SectionHeader(
                index: 7,
                title: 'BlendMode Showcase on Frosted Glass',
                scheme: scheme,
              ),
              _BlendModeShowcase(scheme: scheme),
              const SizedBox(height: 28.0),
              _SectionHeader(
                index: 8,
                title: 'Engine Layer Relationship Diagram',
                scheme: scheme,
              ),
              _EngineLayerDiagram(scheme: scheme),
              const SizedBox(height: 28.0),
              _SectionHeader(
                index: 9,
                title: 'Recipe Gallery',
                scheme: scheme,
              ),
              _RecipeGallery(scheme: scheme),
              const SizedBox(height: 28.0),
              _SectionHeader(
                index: 10,
                title: 'Glossary and Summary',
                scheme: scheme,
              ),
              _GlossaryPanel(scheme: scheme),
              const SizedBox(height: 40.0),
              _FooterStamp(scheme: scheme),
              const SizedBox(height: 28.0),
            ],
          ),
        ),
      ),
    );
  }
}

// =====================================================================
// Header gradient banner
// =====================================================================
class _HeaderBanner extends StatelessWidget {
  const _HeaderBanner({required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    print('=== Section 0: Header banner ===');
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            scheme.primary,
            scheme.secondary,
            scheme.tertiary,
          ],
        ),
        borderRadius: BorderRadius.circular(22.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: scheme.primary.withValues(alpha: 0.40),
            blurRadius: 22.0,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.22),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.blur_on,
              size: 56.0,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 20.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'BackdropFilterEngineLayer',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26.0,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.4,
                  ),
                ),
                const SizedBox(height: 6.0),
                Text(
                  'An internal dart:ui engine layer that filters the\n'
                  'pixels already painted behind a region of the scene.',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.92),
                    fontSize: 13.5,
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 10.0),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 6.0,
                  children: <Widget>[
                    _pill('dart:ui'),
                    _pill('SceneBuilder.pushBackdropFilter'),
                    _pill('ImageFilter'),
                    _pill('BackdropFilter widget'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _pill(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: Colors.white.withValues(alpha: 0.45)),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11.0,
          fontWeight: FontWeight.w600,
          fontFamily: 'monospace',
        ),
      ),
    );
  }
}

// =====================================================================
// Section header
// =====================================================================
class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.index,
    required this.title,
    required this.scheme,
  });
  final int index;
  final String title;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    print('=== Section $index: $title ===');
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: <Widget>[
          Container(
            width: 38.0,
            height: 38.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: scheme.primaryContainer,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(
              '$index',
              style: TextStyle(
                color: scheme.onPrimaryContainer,
                fontWeight: FontWeight.w900,
                fontSize: 18.0,
              ),
            ),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: scheme.onSurface,
                fontSize: 20.0,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Container(
            height: 2.0,
            width: 90.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: <Color>[
                scheme.primary,
                scheme.tertiary,
              ]),
              borderRadius: BorderRadius.circular(2.0),
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// Section 1: Intro panel
// =====================================================================
class _IntroPanel extends StatelessWidget {
  const _IntroPanel({required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: scheme.secondaryContainer,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: scheme.secondary.withValues(alpha: 0.4),
          width: 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.info_outline, color: scheme.onSecondaryContainer),
              const SizedBox(width: 8.0),
              Text(
                'Where does BackdropFilterEngineLayer come from?',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15.0,
                  color: scheme.onSecondaryContainer,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Text(
            'You never construct one directly. The widget tree contains a '
            'BackdropFilter; its render object (RenderBackdropFilter) calls '
            'PaintingContext.pushLayer with a BackdropFilterLayer; that, in '
            'turn, calls SceneBuilder.pushBackdropFilter, and the engine '
            'returns a BackdropFilterEngineLayer handle. The handle can be '
            'reused across frames as long as the filter parameters stay '
            'compatible, which is one of the most important performance '
            'tricks behind smooth blurred surfaces on mobile devices.',
            style: TextStyle(
              fontSize: 13.0,
              height: 1.45,
              color: scheme.onSecondaryContainer,
            ),
          ),
          const SizedBox(height: 14.0),
          Container(
            padding: const EdgeInsets.all(14.0),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.78),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: const Text(
              '// Conceptual flow\n'
              'BackdropFilter(filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10))\n'
              '   -> RenderBackdropFilter.paint(...)\n'
              '   -> PaintingContext.pushLayer(BackdropFilterLayer(...))\n'
              '   -> SceneBuilder.pushBackdropFilter(filter, blendMode, oldLayer)\n'
              '   -> returns BackdropFilterEngineLayer (opaque handle)',
              style: TextStyle(
                color: Color(0xFFB8E994),
                fontFamily: 'monospace',
                fontSize: 11.5,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// Shared painted backdrop used behind blur previews
// =====================================================================
class _GradientCanvas extends StatelessWidget {
  const _GradientCanvas({
    required this.width,
    required this.height,
    this.style = _CanvasStyle.sunset,
  });
  final double width;
  final double height;
  final _CanvasStyle style;

  @override
  Widget build(BuildContext context) {
    final List<Color> colors;
    switch (style) {
      case _CanvasStyle.sunset:
        colors = const <Color>[
          Color(0xFFFF6E7F),
          Color(0xFFBFE9FF),
          Color(0xFFFFD86F),
          Color(0xFFF09819),
        ];
        break;
      case _CanvasStyle.ocean:
        colors = const <Color>[
          Color(0xFF1A2980),
          Color(0xFF26D0CE),
          Color(0xFF0F2027),
          Color(0xFF2C5364),
        ];
        break;
      case _CanvasStyle.forest:
        colors = const <Color>[
          Color(0xFF134E5E),
          Color(0xFF71B280),
          Color(0xFFE8F5E9),
          Color(0xFF2E7D32),
        ];
        break;
      case _CanvasStyle.candy:
        colors = const <Color>[
          Color(0xFFFC466B),
          Color(0xFF3F5EFB),
          Color(0xFFFFAFBD),
          Color(0xFFFFC3A0),
        ];
        break;
    }
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        children: <Widget>[
          // Conic-style background built from gradient layers.
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: colors,
                ),
              ),
            ),
          ),
          // Decorative shapes that make the blur effect visible.
          Positioned(
            left: width * 0.10,
            top: height * 0.18,
            child: _blob(width * 0.30, Colors.white.withValues(alpha: 0.55)),
          ),
          Positioned(
            right: width * 0.06,
            top: height * 0.10,
            child: _blob(width * 0.22, Colors.black.withValues(alpha: 0.35)),
          ),
          Positioned(
            left: width * 0.40,
            bottom: height * 0.10,
            child: _blob(width * 0.26, Colors.yellow.withValues(alpha: 0.55)),
          ),
          Positioned(
            right: width * 0.30,
            bottom: height * 0.30,
            child: _blob(width * 0.18, Colors.pink.withValues(alpha: 0.55)),
          ),
        ],
      ),
    );
  }

  Widget _blob(double diameter, Color color) {
    return Container(
      width: diameter,
      height: diameter,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}

enum _CanvasStyle { sunset, ocean, forest, candy }

// =====================================================================
// Section 2: ImageFilter.blur sigma catalogue
// =====================================================================
class _BlurSigmaCatalogue extends StatelessWidget {
  const _BlurSigmaCatalogue({required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    final List<double> sigmas = <double>[0.0, 2.0, 5.0, 10.0, 18.0, 28.0];
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Text(
            'A symmetric sigma (sigmaX == sigmaY) gives an evenly spread '
            'gaussian blur. The first card is sigma 0 (no blur) to anchor '
            'the perceptual scale.',
            style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12.5),
          ),
        ),
        Wrap(
          spacing: 14.0,
          runSpacing: 14.0,
          children: <Widget>[
            for (final double sigma in sigmas)
              _BlurCard(sigma: sigma, scheme: scheme),
          ],
        ),
      ],
    );
  }
}

class _BlurCard extends StatelessWidget {
  const _BlurCard({required this.sigma, required this.scheme});
  final double sigma;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    const double w = 170.0;
    const double h = 120.0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: SizedBox(
            width: w,
            height: h,
            child: Stack(
              children: <Widget>[
                const _GradientCanvas(width: w, height: h),
                Positioned.fill(
                  child: BackdropFilter(
                    filter: ui.ImageFilter.blur(
                      sigmaX: sigma,
                      sigmaY: sigma,
                    ),
                    child: Container(
                      color: Colors.white.withValues(alpha: 0.05),
                      alignment: Alignment.bottomLeft,
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 4.0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.55),
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        child: Text(
                          'sigma ${sigma.toStringAsFixed(1)}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11.0,
                            fontFamily: 'monospace',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 6.0),
        Container(
          width: w,
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: scheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            _descriptionFor(sigma),
            style: TextStyle(
              fontSize: 10.5,
              color: scheme.onSurfaceVariant,
            ),
          ),
        ),
      ],
    );
  }

  String _descriptionFor(double sigma) {
    if (sigma == 0.0) {
      return 'No blur, the engine still installs the layer.';
    } else if (sigma < 3.0) {
      return 'Subtle softening, text behind stays readable.';
    } else if (sigma < 8.0) {
      return 'Gentle frosted-glass feel.';
    } else if (sigma < 15.0) {
      return 'Classic iOS-style modal sheet blur.';
    } else if (sigma < 25.0) {
      return 'Strong privacy blur, fields become unreadable.';
    }
    return 'Aggressive blur that flattens almost all detail.';
  }
}

// =====================================================================
// Section 3: Directional blur grid (sigmaX != sigmaY)
// =====================================================================
class _DirectionalBlurGrid extends StatelessWidget {
  const _DirectionalBlurGrid({required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    final List<List<double>> pairs = <List<double>>[
      <double>[18.0, 0.0],
      <double>[0.0, 18.0],
      <double>[14.0, 2.0],
      <double>[2.0, 14.0],
      <double>[12.0, 12.0],
      <double>[24.0, 6.0],
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Asymmetric blur is useful for motion-style smears and for '
          'anisotropic filtering of frosted surfaces.',
          style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12.5),
        ),
        const SizedBox(height: 10.0),
        Wrap(
          spacing: 12.0,
          runSpacing: 12.0,
          children: <Widget>[
            for (final List<double> pair in pairs)
              _DirectionalCard(
                sigmaX: pair[0],
                sigmaY: pair[1],
                scheme: scheme,
              ),
          ],
        ),
      ],
    );
  }
}

class _DirectionalCard extends StatelessWidget {
  const _DirectionalCard({
    required this.sigmaX,
    required this.sigmaY,
    required this.scheme,
  });
  final double sigmaX;
  final double sigmaY;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    const double w = 175.0;
    const double h = 115.0;
    final String tag =
        '(${sigmaX.toStringAsFixed(0)}, ${sigmaY.toStringAsFixed(0)})';
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(
          color: scheme.outlineVariant,
          width: 1.0,
        ),
      ),
      padding: const EdgeInsets.all(6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: SizedBox(
              width: w,
              height: h,
              child: Stack(
                children: <Widget>[
                  const _GradientCanvas(
                    width: w,
                    height: h,
                    style: _CanvasStyle.ocean,
                  ),
                  Positioned.fill(
                    child: BackdropFilter(
                      filter: ui.ImageFilter.blur(
                        sigmaX: sigmaX,
                        sigmaY: sigmaY,
                      ),
                      child: const SizedBox.expand(),
                    ),
                  ),
                  Positioned(
                    left: 8.0,
                    top: 8.0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: Text(
                        'sigma $tag',
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'monospace',
                          fontSize: 11.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 6.0),
          Row(
            children: <Widget>[
              Icon(Icons.swap_horiz, size: 14.0, color: scheme.primary),
              const SizedBox(width: 4.0),
              Text(
                'X strength ${sigmaX.toStringAsFixed(0)}',
                style: TextStyle(fontSize: 10.5, color: scheme.onSurface),
              ),
              const SizedBox(width: 10.0),
              Icon(Icons.swap_vert, size: 14.0, color: scheme.tertiary),
              const SizedBox(width: 4.0),
              Text(
                'Y strength ${sigmaY.toStringAsFixed(0)}',
                style: TextStyle(fontSize: 10.5, color: scheme.onSurface),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// Section 4: Morphology (dilate / erode)
// =====================================================================
class _MorphologyPanel extends StatelessWidget {
  const _MorphologyPanel({required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: scheme.tertiaryContainer,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                Icons.zoom_out_map,
                color: scheme.onTertiaryContainer,
              ),
              const SizedBox(width: 8.0),
              Text(
                'ImageFilter.dilate / ImageFilter.erode',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 15.0,
                  color: scheme.onTertiaryContainer,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6.0),
          Text(
            'These two morphological filters expand or contract bright '
            'regions in the source. They are rarer in production UI but '
            'still produce a valid BackdropFilterEngineLayer.',
            style: TextStyle(
              fontSize: 12.5,
              color: scheme.onTertiaryContainer,
              height: 1.35,
            ),
          ),
          const SizedBox(height: 14.0),
          Wrap(
            spacing: 14.0,
            runSpacing: 14.0,
            children: <Widget>[
              _MorphologyCard(
                label: 'dilate(2, 2)',
                filter: ui.ImageFilter.dilate(radiusX: 2.0, radiusY: 2.0),
                style: _CanvasStyle.forest,
              ),
              _MorphologyCard(
                label: 'dilate(5, 5)',
                filter: ui.ImageFilter.dilate(radiusX: 5.0, radiusY: 5.0),
                style: _CanvasStyle.forest,
              ),
              _MorphologyCard(
                label: 'erode(2, 2)',
                filter: ui.ImageFilter.erode(radiusX: 2.0, radiusY: 2.0),
                style: _CanvasStyle.forest,
              ),
              _MorphologyCard(
                label: 'erode(5, 5)',
                filter: ui.ImageFilter.erode(radiusX: 5.0, radiusY: 5.0),
                style: _CanvasStyle.forest,
              ),
              _MorphologyCard(
                label: 'dilate(8, 0)',
                filter: ui.ImageFilter.dilate(radiusX: 8.0, radiusY: 0.0),
                style: _CanvasStyle.forest,
              ),
              _MorphologyCard(
                label: 'erode(0, 8)',
                filter: ui.ImageFilter.erode(radiusX: 0.0, radiusY: 8.0),
                style: _CanvasStyle.forest,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MorphologyCard extends StatelessWidget {
  const _MorphologyCard({
    required this.label,
    required this.filter,
    required this.style,
  });
  final String label;
  final ui.ImageFilter filter;
  final _CanvasStyle style;

  @override
  Widget build(BuildContext context) {
    const double w = 160.0;
    const double h = 100.0;
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: SizedBox(
        width: w,
        height: h,
        child: Stack(
          children: <Widget>[
            _GradientCanvas(width: w, height: h, style: style),
            Positioned.fill(
              child: BackdropFilter(
                filter: filter,
                child: const SizedBox.expand(),
              ),
            ),
            Positioned(
              left: 8.0,
              bottom: 8.0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 4.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'monospace',
                    fontSize: 11.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =====================================================================
// Section 5: ImageFilter.matrix transformations
// =====================================================================
class _MatrixFilterPanel extends StatelessWidget {
  const _MatrixFilterPanel({required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    final List<_MatrixEntry> entries = <_MatrixEntry>[
      _MatrixEntry(
        label: 'identity',
        description: 'No transform; baseline.',
        matrix: _identityMatrix(),
      ),
      _MatrixEntry(
        label: 'translate(20, 0)',
        description: 'Shifts the sampled pixels right by 20.',
        matrix: _translateMatrix(20.0, 0.0),
      ),
      _MatrixEntry(
        label: 'translate(0, 18)',
        description: 'Shifts the sampled pixels down by 18.',
        matrix: _translateMatrix(0.0, 18.0),
      ),
      _MatrixEntry(
        label: 'scale(1.4)',
        description: 'Magnifies the backdrop region.',
        matrix: _scaleMatrix(1.4),
      ),
      _MatrixEntry(
        label: 'scale(0.8)',
        description: 'Shrinks the sampled backdrop.',
        matrix: _scaleMatrix(0.8),
      ),
      _MatrixEntry(
        label: 'rotate(8 deg)',
        description: 'Slight in-plane rotation.',
        matrix: _rotateMatrix(8.0),
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'ImageFilter.matrix accepts a 4x4 Float64List representing the '
          'transform to apply when sampling source pixels. Unlike a Transform '
          'widget it does not move the painted content; it remaps what the '
          'layer reads back from the scene below.',
          style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12.5),
        ),
        const SizedBox(height: 12.0),
        Wrap(
          spacing: 14.0,
          runSpacing: 14.0,
          children: <Widget>[
            for (final _MatrixEntry e in entries)
              _MatrixCard(entry: e, scheme: scheme),
          ],
        ),
      ],
    );
  }

  Float64List _identityMatrix() {
    final Float64List m = Float64List(16);
    m[0] = 1.0;
    m[5] = 1.0;
    m[10] = 1.0;
    m[15] = 1.0;
    return m;
  }

  Float64List _translateMatrix(double tx, double ty) {
    final Float64List m = _identityMatrix();
    m[12] = tx;
    m[13] = ty;
    return m;
  }

  Float64List _scaleMatrix(double s) {
    final Float64List m = Float64List(16);
    m[0] = s;
    m[5] = s;
    m[10] = 1.0;
    m[15] = 1.0;
    return m;
  }

  Float64List _rotateMatrix(double degrees) {
    final double r = degrees * 3.141592653589793 / 180.0;
    final double c = _cos(r);
    final double s = _sin(r);
    final Float64List m = Float64List(16);
    m[0] = c;
    m[1] = s;
    m[4] = -s;
    m[5] = c;
    m[10] = 1.0;
    m[15] = 1.0;
    return m;
  }

  // Taylor approximations to avoid importing dart:math (kept tiny range).
  double _cos(double x) {
    final double x2 = x * x;
    return 1.0 - x2 / 2.0 + (x2 * x2) / 24.0;
  }

  double _sin(double x) {
    final double x2 = x * x;
    return x - (x2 * x) / 6.0 + (x2 * x2 * x) / 120.0;
  }
}

class _MatrixEntry {
  _MatrixEntry({
    required this.label,
    required this.description,
    required this.matrix,
  });
  final String label;
  final String description;
  final Float64List matrix;
}

class _MatrixCard extends StatelessWidget {
  const _MatrixCard({required this.entry, required this.scheme});
  final _MatrixEntry entry;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    const double w = 180.0;
    const double h = 120.0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: SizedBox(
            width: w,
            height: h,
            child: Stack(
              children: <Widget>[
                const _GradientCanvas(
                  width: w,
                  height: h,
                  style: _CanvasStyle.candy,
                ),
                Positioned.fill(
                  child: BackdropFilter(
                    filter: ui.ImageFilter.matrix(entry.matrix),
                    child: const SizedBox.expand(),
                  ),
                ),
                Positioned(
                  left: 8.0,
                  top: 8.0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 4.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Text(
                      entry.label,
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'monospace',
                        fontSize: 11.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 6.0),
        SizedBox(
          width: w,
          child: Text(
            entry.description,
            style: TextStyle(fontSize: 10.5, color: scheme.onSurface),
          ),
        ),
      ],
    );
  }
}

// Minimal Float64List shim is not needed; we use dart:typed_data through
// dart:ui re-export. Importing dart:typed_data implicitly would be wrong;
// instead we rely on the dart:ui ImageFilter.matrix signature which
// accepts Float64List. We import dart:typed_data via dart:ui transitively.
// To keep the file self-contained we add the import here:

// =====================================================================
// Section 6: ImageFilter.compose stacking
// =====================================================================
class _ComposeFilterPanel extends StatelessWidget {
  const _ComposeFilterPanel({required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    final List<_ComposeEntry> entries = <_ComposeEntry>[
      _ComposeEntry(
        label: 'blur(8) then dilate(2)',
        outer: ui.ImageFilter.dilate(radiusX: 2.0, radiusY: 2.0),
        inner: ui.ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
        note: 'Soften, then thicken bright highlights.',
      ),
      _ComposeEntry(
        label: 'dilate(2) then blur(8)',
        outer: ui.ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
        inner: ui.ImageFilter.dilate(radiusX: 2.0, radiusY: 2.0),
        note: 'Thicken first, then soften the result.',
      ),
      _ComposeEntry(
        label: 'erode(2) then blur(12)',
        outer: ui.ImageFilter.blur(sigmaX: 12.0, sigmaY: 12.0),
        inner: ui.ImageFilter.erode(radiusX: 2.0, radiusY: 2.0),
        note: 'Remove fine detail, then heavily blur.',
      ),
      _ComposeEntry(
        label: 'blur(4) then blur(10)',
        outer: ui.ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        inner: ui.ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
        note: 'Cascaded blurs approximate a wider kernel.',
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'ImageFilter.compose(outer, inner) applies the inner filter first '
          'and the outer filter second. Order matters; the previews below '
          'flip the same pair to show the difference.',
          style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12.5),
        ),
        const SizedBox(height: 12.0),
        Wrap(
          spacing: 14.0,
          runSpacing: 14.0,
          children: <Widget>[
            for (final _ComposeEntry e in entries)
              _ComposeCard(entry: e, scheme: scheme),
          ],
        ),
      ],
    );
  }
}

class _ComposeEntry {
  _ComposeEntry({
    required this.label,
    required this.outer,
    required this.inner,
    required this.note,
  });
  final String label;
  final ui.ImageFilter outer;
  final ui.ImageFilter inner;
  final String note;
}

class _ComposeCard extends StatelessWidget {
  const _ComposeCard({required this.entry, required this.scheme});
  final _ComposeEntry entry;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    const double w = 220.0;
    const double h = 130.0;
    return Container(
      width: w,
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: scheme.outlineVariant),
      ),
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: SizedBox(
              width: double.infinity,
              height: h,
              child: Stack(
                children: <Widget>[
                  const _GradientCanvas(
                    width: w - 16.0,
                    height: h,
                    style: _CanvasStyle.sunset,
                  ),
                  Positioned.fill(
                    child: BackdropFilter(
                      filter: ui.ImageFilter.compose(
                        outer: entry.outer,
                        inner: entry.inner,
                      ),
                      child: const SizedBox.expand(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 6.0),
          Text(
            entry.label,
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w700,
              color: scheme.onSurface,
            ),
          ),
          Text(
            entry.note,
            style: TextStyle(fontSize: 10.5, color: scheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// Section 7: BlendMode showcase
// =====================================================================
class _BlendModeShowcase extends StatelessWidget {
  const _BlendModeShowcase({required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    final List<_BlendEntry> entries = <_BlendEntry>[
      _BlendEntry(
        mode: BlendMode.srcOver,
        overlay: Colors.white.withValues(alpha: 0.30),
        note: 'Standard alpha-blend over the blur.',
      ),
      _BlendEntry(
        mode: BlendMode.multiply,
        overlay: Colors.indigo.withValues(alpha: 0.55),
        note: 'Multiplies overlay with the blurred backdrop.',
      ),
      _BlendEntry(
        mode: BlendMode.screen,
        overlay: Colors.amber.withValues(alpha: 0.55),
        note: 'Lightens regions while keeping highlights.',
      ),
      _BlendEntry(
        mode: BlendMode.overlay,
        overlay: Colors.deepPurple.withValues(alpha: 0.45),
        note: 'Combines multiply and screen for contrast.',
      ),
      _BlendEntry(
        mode: BlendMode.softLight,
        overlay: Colors.teal.withValues(alpha: 0.45),
        note: 'Gentle tint, photographic feel.',
      ),
      _BlendEntry(
        mode: BlendMode.colorBurn,
        overlay: Colors.orange.withValues(alpha: 0.50),
        note: 'Darkens and saturates the result.',
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'BlendMode is the third ingredient of pushBackdropFilter: it '
          'specifies how the filtered backdrop is combined with the layer '
          'painted on top. The overlay card on each preview uses a '
          'differently-coloured Container with the configured mode.',
          style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12.5),
        ),
        const SizedBox(height: 12.0),
        Wrap(
          spacing: 14.0,
          runSpacing: 14.0,
          children: <Widget>[
            for (final _BlendEntry e in entries)
              _BlendCard(entry: e, scheme: scheme),
          ],
        ),
      ],
    );
  }
}

class _BlendEntry {
  _BlendEntry({
    required this.mode,
    required this.overlay,
    required this.note,
  });
  final BlendMode mode;
  final Color overlay;
  final String note;
}

class _BlendCard extends StatelessWidget {
  const _BlendCard({required this.entry, required this.scheme});
  final _BlendEntry entry;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    const double w = 190.0;
    const double h = 130.0;
    return Container(
      width: w,
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: scheme.outlineVariant),
      ),
      padding: const EdgeInsets.all(6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: SizedBox(
              width: double.infinity,
              height: h,
              child: Stack(
                children: <Widget>[
                  const _GradientCanvas(
                    width: w - 12.0,
                    height: h,
                    style: _CanvasStyle.candy,
                  ),
                  Positioned.fill(
                    child: BackdropFilter(
                      filter: ui.ImageFilter.blur(
                        sigmaX: 10.0,
                        sigmaY: 10.0,
                      ),
                      blendMode: entry.mode,
                      child: Container(color: entry.overlay),
                    ),
                  ),
                  Positioned(
                    left: 8.0,
                    bottom: 8.0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.55),
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: Text(
                        'BlendMode.${entry.mode.name}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'monospace',
                          fontSize: 11.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 6.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Text(
              entry.note,
              style: TextStyle(
                fontSize: 10.5,
                color: scheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// Section 8: Engine layer relationship diagram
// =====================================================================
class _EngineLayerDiagram extends StatelessWidget {
  const _EngineLayerDiagram({required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            scheme.primaryContainer,
            scheme.tertiaryContainer,
          ],
        ),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'From widget to engine layer',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 15.0,
              color: scheme.onPrimaryContainer,
            ),
          ),
          const SizedBox(height: 14.0),
          _diagramRow(
            label: 'BackdropFilter widget',
            description: 'StatelessWidget — user-facing API.',
            color: scheme.primary,
            scheme: scheme,
          ),
          _arrow(scheme),
          _diagramRow(
            label: 'RenderBackdropFilter',
            description: 'Render object that owns the layer.',
            color: scheme.secondary,
            scheme: scheme,
          ),
          _arrow(scheme),
          _diagramRow(
            label: 'BackdropFilterLayer (rendering layer)',
            description: 'Composited layer kept across frames.',
            color: scheme.tertiary,
            scheme: scheme,
          ),
          _arrow(scheme),
          _diagramRow(
            label: 'SceneBuilder.pushBackdropFilter(...)',
            description: 'Engine call that returns the handle.',
            color: scheme.primary,
            scheme: scheme,
          ),
          _arrow(scheme),
          _diagramRow(
            label: 'BackdropFilterEngineLayer (this demo)',
            description: 'Opaque handle owned by the engine.',
            color: scheme.error,
            scheme: scheme,
            highlight: true,
          ),
          const SizedBox(height: 12.0),
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: const Text(
              '// Inside BackdropFilterLayer.addToScene\n'
              'final ui.BackdropFilterEngineLayer? engineLayer =\n'
              '    builder.pushBackdropFilter(\n'
              '      filter,\n'
              '      blendMode: blendMode,\n'
              '      oldLayer: _engineLayer,\n'
              '    );\n'
              '_engineLayer = engineLayer; // remember for next frame',
              style: TextStyle(
                color: Color(0xFFB8E994),
                fontFamily: 'monospace',
                fontSize: 11.5,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _diagramRow({
    required String label,
    required String description,
    required Color color,
    required ColorScheme scheme,
    bool highlight = false,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3.0),
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: highlight
            ? color.withValues(alpha: 0.92)
            : Colors.white.withValues(alpha: 0.75),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: color, width: highlight ? 2.0 : 1.0),
      ),
      child: Row(
        children: <Widget>[
          Icon(
            highlight ? Icons.bolt : Icons.layers,
            size: 18.0,
            color: highlight ? Colors.white : color,
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: highlight ? Colors.white : color,
                    fontSize: 13.0,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 11.5,
                    color: highlight
                        ? Colors.white.withValues(alpha: 0.92)
                        : scheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _arrow(ColorScheme scheme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: <Widget>[
          const SizedBox(width: 14.0),
          Icon(
            Icons.arrow_downward,
            size: 18.0,
            color: scheme.onPrimaryContainer.withValues(alpha: 0.65),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// Section 9: Recipe gallery
// =====================================================================
class _RecipeGallery extends StatelessWidget {
  const _RecipeGallery({required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Three concrete UI recipes built entirely with BackdropFilter:',
          style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12.5),
        ),
        const SizedBox(height: 12.0),
        _FrostedCardRecipe(scheme: scheme),
        const SizedBox(height: 18.0),
        _BlurredHeaderRecipe(scheme: scheme),
        const SizedBox(height: 18.0),
        _ModalScrimRecipe(scheme: scheme),
      ],
    );
  }
}

class _FrostedCardRecipe extends StatelessWidget {
  const _FrostedCardRecipe({required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    const double w = 360.0;
    const double h = 180.0;
    return _RecipeShell(
      title: 'Recipe 1: Frosted glass card',
      caption: 'BackdropFilter + translucent rounded rectangle on top of '
          'a colourful gradient backdrop.',
      scheme: scheme,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: SizedBox(
          width: w,
          height: h,
          child: Stack(
            children: <Widget>[
              const _GradientCanvas(
                width: w,
                height: h,
                style: _CanvasStyle.sunset,
              ),
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18.0),
                  child: BackdropFilter(
                    filter: ui.ImageFilter.blur(sigmaX: 14.0, sigmaY: 14.0),
                    child: Container(
                      width: w * 0.78,
                      height: h * 0.74,
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.28),
                        borderRadius: BorderRadius.circular(18.0),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.55),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const <Widget>[
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.ac_unit,
                                color: Colors.white,
                                size: 20.0,
                              ),
                              SizedBox(width: 8.0),
                              Text(
                                'Frosted Glass',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 15.0,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 6.0),
                          Text(
                            'A backdrop filter is applied behind the card '
                            'while the card paints a translucent fill on '
                            'top to maintain readability.',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11.5,
                              height: 1.35,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BlurredHeaderRecipe extends StatelessWidget {
  const _BlurredHeaderRecipe({required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    const double w = 360.0;
    const double h = 200.0;
    return _RecipeShell(
      title: 'Recipe 2: Blurred sticky header',
      caption: 'Scrollable content slides under a blurred header strip.',
      scheme: scheme,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: SizedBox(
          width: w,
          height: h,
          child: Stack(
            children: <Widget>[
              // Mock scrolling content.
              const _GradientCanvas(
                width: w,
                height: h,
                style: _CanvasStyle.ocean,
              ),
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.only(top: 60.0, left: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _stripeRow(0.85),
                      _stripeRow(0.70),
                      _stripeRow(0.55),
                      _stripeRow(0.65),
                      _stripeRow(0.40),
                    ],
                  ),
                ),
              ),
              // Blurred header strip.
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                height: 56.0,
                child: ClipRect(
                  child: BackdropFilter(
                    filter: ui.ImageFilter.blur(sigmaX: 12.0, sigmaY: 12.0),
                    child: Container(
                      color: Colors.white.withValues(alpha: 0.25),
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: const Text(
                        'BackdropFilter Header',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _stripeRow(double widthFraction) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: <Widget>[
          Container(
            width: 30.0,
            height: 14.0,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.55),
              borderRadius: BorderRadius.circular(4.0),
            ),
          ),
          const SizedBox(width: 8.0),
          Container(
            width: 220.0 * widthFraction,
            height: 14.0,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.32),
              borderRadius: BorderRadius.circular(4.0),
            ),
          ),
        ],
      ),
    );
  }
}

class _ModalScrimRecipe extends StatelessWidget {
  const _ModalScrimRecipe({required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    const double w = 360.0;
    const double h = 220.0;
    return _RecipeShell(
      title: 'Recipe 3: Modal scrim',
      caption: 'A full-bleed blur scrim with a dialog panel above it.',
      scheme: scheme,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: SizedBox(
          width: w,
          height: h,
          child: Stack(
            children: <Widget>[
              const _GradientCanvas(
                width: w,
                height: h,
                style: _CanvasStyle.forest,
              ),
              Positioned.fill(
                child: BackdropFilter(
                  filter: ui.ImageFilter.blur(sigmaX: 18.0, sigmaY: 18.0),
                  child: Container(
                    color: Colors.black.withValues(alpha: 0.18),
                  ),
                ),
              ),
              Center(
                child: Container(
                  width: w * 0.62,
                  padding: const EdgeInsets.all(18.0),
                  decoration: BoxDecoration(
                    color: scheme.surface,
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.18),
                        blurRadius: 16.0,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.warning_amber,
                            color: scheme.error,
                            size: 22.0,
                          ),
                          const SizedBox(width: 8.0),
                          Text(
                            'Confirm action',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 15.0,
                              color: scheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6.0),
                      Text(
                        'The dialog floats above a BackdropFilter-based '
                        'scrim. The scrim builds exactly one engine layer.',
                        style: TextStyle(
                          fontSize: 11.5,
                          color: scheme.onSurfaceVariant,
                          height: 1.35,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                              vertical: 6.0,
                            ),
                            decoration: BoxDecoration(
                              color: scheme.surfaceContainerHighest,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: scheme.onSurface,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                              vertical: 6.0,
                            ),
                            decoration: BoxDecoration(
                              color: scheme.primary,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Text(
                              'OK',
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                color: scheme.onPrimary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RecipeShell extends StatelessWidget {
  const _RecipeShell({
    required this.title,
    required this.caption,
    required this.scheme,
    required this.child,
  });
  final String title;
  final String caption;
  final ColorScheme scheme;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 14.5,
              color: scheme.onSurface,
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            caption,
            style: TextStyle(
              fontSize: 11.5,
              color: scheme.onSurfaceVariant,
              height: 1.35,
            ),
          ),
          const SizedBox(height: 10.0),
          Center(child: child),
        ],
      ),
    );
  }
}

// =====================================================================
// Section 10: Glossary panel
// =====================================================================
class _GlossaryPanel extends StatelessWidget {
  const _GlossaryPanel({required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    final List<List<String>> rows = <List<String>>[
      <String>[
        'BackdropFilterEngineLayer',
        'Opaque engine handle returned by pushBackdropFilter; not '
            'instantiated by user code.',
      ],
      <String>[
        'BackdropFilter (widget)',
        'StatelessWidget that wraps a child and registers an '
            'ImageFilter and BlendMode for backdrop sampling.',
      ],
      <String>[
        'ImageFilter.blur',
        'Symmetric or asymmetric gaussian blur using sigmaX, sigmaY.',
      ],
      <String>[
        'ImageFilter.dilate',
        'Morphological dilation by radiusX, radiusY pixels.',
      ],
      <String>[
        'ImageFilter.erode',
        'Morphological erosion by radiusX, radiusY pixels.',
      ],
      <String>[
        'ImageFilter.matrix',
        'Affine remap of sampled coordinates via a 4x4 Float64List.',
      ],
      <String>[
        'ImageFilter.compose',
        'Applies inner first, then outer, in a single layer.',
      ],
      <String>[
        'BlendMode',
        'How the filtered backdrop combines with painted overlay.',
      ],
      <String>[
        'SceneBuilder.pushBackdropFilter',
        'Engine entry point that produces the layer handle.',
      ],
      <String>[
        'oldLayer parameter',
        'Engine handle reused across frames when parameters are '
            'compatible; primary perf optimisation.',
      ],
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: scheme.primaryContainer,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    Icons.menu_book,
                    color: scheme.onPrimaryContainer,
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    'Glossary',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w800,
                      color: scheme.onPrimaryContainer,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              for (int i = 0; i < rows.length; i++)
                _glossaryRow(
                  rows[i][0],
                  rows[i][1],
                  scheme,
                  alt: i.isEven,
                ),
            ],
          ),
        ),
        const SizedBox(height: 16.0),
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                scheme.tertiaryContainer,
                scheme.secondaryContainer,
              ],
            ),
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Performance notes',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 14.5,
                  color: scheme.onTertiaryContainer,
                ),
              ),
              const SizedBox(height: 8.0),
              _bullet(
                'Each BackdropFilter pushes its own engine layer. Nesting '
                'blur over blur multiplies the cost; prefer compose.',
                scheme,
              ),
              _bullet(
                'Keep filter parameters stable across frames so the engine '
                'can reuse the oldLayer handle.',
                scheme,
              ),
              _bullet(
                'Clip the BackdropFilter region; a full-screen blur is far '
                'more expensive than a small frosted panel.',
                scheme,
              ),
              _bullet(
                'On Impeller the engine layer maps to a render-pass '
                'attachment; sigmas above ~30 may require downsampling.',
                scheme,
              ),
              _bullet(
                'BlendMode.srcOver is the only mode guaranteed to be free; '
                'others may force an off-screen pass.',
                scheme,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16.0),
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: scheme.errorContainer,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    Icons.report_problem,
                    color: scheme.onErrorContainer,
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    'Pitfalls',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 14.5,
                      color: scheme.onErrorContainer,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              _bulletColored(
                'Forgetting to clip the BackdropFilter region causes the '
                'whole screen to be blurred.',
                scheme.onErrorContainer,
              ),
              _bulletColored(
                'Using BackdropFilter inside a transparent ancestor with '
                'no painted backdrop yields a no-op.',
                scheme.onErrorContainer,
              ),
              _bulletColored(
                'Animating sigma values invalidates the engine-layer cache '
                'every frame; the cost compounds quickly.',
                scheme.onErrorContainer,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _glossaryRow(String term, String def, ColorScheme s, {bool alt = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: alt
            ? Colors.white.withValues(alpha: 0.55)
            : Colors.white.withValues(alpha: 0.30),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 200.0,
            child: Text(
              term,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 12.0,
                color: s.onPrimaryContainer,
                fontFamily: 'monospace',
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              def,
              style: TextStyle(
                fontSize: 11.5,
                color: s.onPrimaryContainer,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bullet(String text, ColorScheme s) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(
            Icons.check_circle,
            size: 16.0,
            color: s.tertiary,
          ),
          const SizedBox(width: 6.0),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 11.5,
                color: s.onTertiaryContainer,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bulletColored(String text, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(Icons.error_outline, size: 16.0, color: color),
          const SizedBox(width: 6.0),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 11.5,
                color: color,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// Footer stamp
// =====================================================================
class _FooterStamp extends StatelessWidget {
  const _FooterStamp({required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[scheme.primary, scheme.tertiary],
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: <Widget>[
          const Icon(Icons.verified, color: Colors.white, size: 22.0),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              'End of BackdropFilterEngineLayer deep demo - 10 sections, '
              'every preview rendered with a real BackdropFilter widget.',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 12.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
