// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/material.dart';

/// Design plan: Visual deep-demo for painting/gradient_shadow_test.dart.
///
/// Subject: Flutter Gradient hierarchy (LinearGradient, RadialGradient,
/// SweepGradient) together with the Shadow / BoxShadow family. The original
/// test exercised constructors, color/stop lists, tileMode for gradients,
/// blurRadius/offset/spreadRadius/blurStyle for shadows, lerp helpers, and
/// combined gradient + shadow recipes. This file renders all of that as a
/// scrollable Material 3 catalogue.
///
/// Sections:
///   1. Header banner with a sweeping multi-stop linear gradient.
///   2. LinearGradient atlas (axes, stops, tileMode, transform).
///   3. RadialGradient lab (center, radius, focal, tileMode).
///   4. SweepGradient compass (startAngle, endAngle, stops, tileMode).
///   5. BoxShadow matrix (blur/offset/spread/blurStyle/color/alpha).
///   6. Shadow primitives (text shadows and inset-vs-outset gallery).
///   7. Gradient.lerp & BoxShadow.lerp interpolation strips.
///   8. Combined recipes (gradient backgrounds with layered shadows).
///   9. Glossary / cheat-sheet table.
/// All sub-trees are pure const-able Material 3 widgets with no async work.
class GradientShadowDemoApp extends StatelessWidget {
  const GradientShadowDemoApp({super.key});

  // ===== Material 3 color scheme used by the demo =====
  ColorScheme _scheme() => ColorScheme.fromSeed(
    seedColor: const Color(0xFF6750A4),
    brightness: Brightness.light,
  );

  @override
  Widget build(BuildContext context) {
    print('GradientShadow Deep Demo executing');
    final ColorScheme cs = _scheme();
    final ThemeData theme = ThemeData(useMaterial3: true, colorScheme: cs);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gradient & Shadow Deep Demo',
      theme: theme,
      home: Scaffold(
        backgroundColor: cs.surface,
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _HeaderBanner(scheme: cs),
              const SizedBox(height: 32.0),
              _SectionTitle(
                number: 1,
                title: 'LinearGradient Atlas',
                subtitle:
                    'Axes, multi-stop colors, tileMode and transform variants.',
                scheme: cs,
              ),
              const SizedBox(height: 16.0),
              const _LinearGradientAtlas(),
              const SizedBox(height: 36.0),
              _SectionTitle(
                number: 2,
                title: 'RadialGradient Lab',
                subtitle:
                    'Center, radius, focal, focalRadius and tileMode together.',
                scheme: cs,
              ),
              const SizedBox(height: 16.0),
              const _RadialGradientLab(),
              const SizedBox(height: 36.0),
              _SectionTitle(
                number: 3,
                title: 'SweepGradient Compass',
                subtitle:
                    'startAngle, endAngle, stops and tileMode forming pie ramps.',
                scheme: cs,
              ),
              const SizedBox(height: 16.0),
              const _SweepGradientCompass(),
              const SizedBox(height: 36.0),
              _SectionTitle(
                number: 4,
                title: 'BoxShadow Matrix',
                subtitle:
                    'blurRadius x offset x spreadRadius x blurStyle x color.',
                scheme: cs,
              ),
              const SizedBox(height: 16.0),
              _BoxShadowMatrix(scheme: cs),
              const SizedBox(height: 36.0),
              _SectionTitle(
                number: 5,
                title: 'Shadow Primitives',
                subtitle: 'Plain Shadow for text and synthetic inset cards.',
                scheme: cs,
              ),
              const SizedBox(height: 16.0),
              _ShadowPrimitives(scheme: cs),
              const SizedBox(height: 36.0),
              _SectionTitle(
                number: 6,
                title: 'Lerp Interpolation Strips',
                subtitle:
                    'Gradient.lerp and BoxShadow.lerp from start to end states.',
                scheme: cs,
              ),
              const SizedBox(height: 16.0),
              _LerpStrips(scheme: cs),
              const SizedBox(height: 36.0),
              _SectionTitle(
                number: 7,
                title: 'Combined Recipes',
                subtitle:
                    'Gradient backgrounds layered with multi-shadow stacks.',
                scheme: cs,
              ),
              const SizedBox(height: 16.0),
              _CombinedRecipes(scheme: cs),
              const SizedBox(height: 36.0),
              _SectionTitle(
                number: 8,
                title: 'Glossary & Cheat Sheet',
                subtitle: 'Quick reference for every parameter used above.',
                scheme: cs,
              ),
              const SizedBox(height: 16.0),
              _Glossary(scheme: cs),
              const SizedBox(height: 36.0),
              _FooterStripe(scheme: cs),
            ],
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// HEADER BANNER  (gradient + layered shadows + readable title)
// =============================================================================

class _HeaderBanner extends StatelessWidget {
  const _HeaderBanner({required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    print('=== Section 0: Header banner ===');
    return Container(
      padding: const EdgeInsets.fromLTRB(24.0, 28.0, 24.0, 28.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22.0),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            scheme.primary,
            scheme.secondary,
            scheme.tertiary,
            scheme.primaryContainer,
          ],
          stops: const <double>[0.0, 0.45, 0.75, 1.0],
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: scheme.primary.withValues(alpha: 0.35),
            blurRadius: 28.0,
            spreadRadius: 1.0,
            offset: const Offset(0.0, 12.0),
          ),
          BoxShadow(
            color: scheme.tertiary.withValues(alpha: 0.20),
            blurRadius: 12.0,
            offset: const Offset(0.0, 4.0),
            blurStyle: BlurStyle.outer,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: scheme.onPrimary.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(14.0),
                ),
                child: Icon(
                  Icons.gradient_outlined,
                  size: 36.0,
                  color: scheme.onPrimary,
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'painting/gradient_shadow_test',
                      style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w500,
                        color: scheme.onPrimary.withValues(alpha: 0.85),
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      'Gradients & Shadows',
                      style: TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.w800,
                        color: scheme.onPrimary,
                        height: 1.05,
                        shadows: <Shadow>[
                          Shadow(
                            offset: const Offset(0.0, 2.0),
                            blurRadius: 6.0,
                            color: Colors.black.withValues(alpha: 0.30),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14.0),
          Text(
            'A hand-crafted catalogue of the Flutter painting subsystem: '
            'LinearGradient, RadialGradient, SweepGradient, plus the entire '
            'Shadow and BoxShadow family. Every preview is a real widget tree '
            'rendered statically by the D4rt AST runner.',
            style: TextStyle(
              fontSize: 14.0,
              height: 1.45,
              color: scheme.onPrimary.withValues(alpha: 0.92),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// REUSABLE LITTLE PIECES
// =============================================================================

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({
    required this.number,
    required this.title,
    required this.subtitle,
    required this.scheme,
  });
  final int number;
  final String title;
  final String subtitle;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    print('=== Section $number: $title ===');
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 42.0,
          height: 42.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[scheme.primary, scheme.tertiary],
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: scheme.primary.withValues(alpha: 0.35),
                blurRadius: 8.0,
                offset: const Offset(0.0, 3.0),
              ),
            ],
          ),
          child: Text(
            '$number',
            style: TextStyle(
              color: scheme.onPrimary,
              fontWeight: FontWeight.w800,
              fontSize: 16.0,
            ),
          ),
        ),
        const SizedBox(width: 14.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w700,
                  color: scheme.onSurface,
                ),
              ),
              const SizedBox(height: 2.0),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 13.5,
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Caption extends StatelessWidget {
  const _Caption(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6.0),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 11.0,
          color: Colors.black87,
          height: 1.3,
        ),
      ),
    );
  }
}

// =============================================================================
// SECTION 1: LINEAR GRADIENT ATLAS
// =============================================================================

class _LinearGradientAtlas extends StatelessWidget {
  const _LinearGradientAtlas();

  // ----- gradient builders -----
  LinearGradient _basic() => const LinearGradient(
    colors: <Color>[Color(0xFF2196F3), Color(0xFFE53935)],
  );

  LinearGradient _horizontal() => const LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: <Color>[Color(0xFF2196F3), Color(0xFFE53935)],
  );

  LinearGradient _vertical() => const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: <Color>[Color(0xFF2196F3), Color(0xFFE53935)],
  );

  LinearGradient _diagonal() => const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[Color(0xFF2196F3), Color(0xFFE53935)],
  );

  LinearGradient _rainbow() => const LinearGradient(
    colors: <Color>[
      Color(0xFFE53935),
      Color(0xFFFF9800),
      Color(0xFFFFEB3B),
      Color(0xFF4CAF50),
      Color(0xFF2196F3),
      Color(0xFF673AB7),
    ],
  );

  LinearGradient _customStops() => const LinearGradient(
    colors: <Color>[Color(0xFFE53935), Color(0xFFFFEB3B), Color(0xFF2196F3)],
    stops: <double>[0.0, 0.30, 1.0],
  );

  LinearGradient _clamped() => const LinearGradient(
    begin: Alignment(-0.5, 0.0),
    end: Alignment(0.5, 0.0),
    colors: <Color>[Color(0xFF6200EE), Color(0xFF03DAC6)],
    tileMode: TileMode.clamp,
  );

  LinearGradient _repeated() => const LinearGradient(
    begin: Alignment(-0.5, 0.0),
    end: Alignment(-0.1, 0.0),
    colors: <Color>[Color(0xFF6200EE), Color(0xFF03DAC6)],
    tileMode: TileMode.repeated,
  );

  LinearGradient _mirrored() => const LinearGradient(
    begin: Alignment(-0.5, 0.0),
    end: Alignment(-0.1, 0.0),
    colors: <Color>[Color(0xFF6200EE), Color(0xFF03DAC6)],
    tileMode: TileMode.mirror,
  );

  LinearGradient _decal() => const LinearGradient(
    begin: Alignment(-0.5, 0.0),
    end: Alignment(-0.1, 0.0),
    colors: <Color>[Color(0xFF6200EE), Color(0xFF03DAC6)],
    tileMode: TileMode.decal,
  );

  Widget _swatch({
    required String label,
    required String caption,
    required LinearGradient gradient,
  }) {
    return Container(
      width: 184.0,
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 10.0,
            offset: const Offset(0.0, 4.0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            height: 88.0,
            decoration: BoxDecoration(
              gradient: gradient,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(14.0),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12.0, 10.0, 12.0, 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                _Caption(caption),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> swatches = <Widget>[
      _swatch(
        label: 'basic',
        caption: 'colors: [blue, red]\nbegin/end defaults',
        gradient: _basic(),
      ),
      _swatch(
        label: 'horizontal',
        caption: 'begin: centerLeft\nend:   centerRight',
        gradient: _horizontal(),
      ),
      _swatch(
        label: 'vertical',
        caption: 'begin: topCenter\nend:   bottomCenter',
        gradient: _vertical(),
      ),
      _swatch(
        label: 'diagonal',
        caption: 'begin: topLeft\nend:   bottomRight',
        gradient: _diagonal(),
      ),
      _swatch(
        label: 'rainbow',
        caption: '6 colors, even stops',
        gradient: _rainbow(),
      ),
      _swatch(
        label: 'custom stops',
        caption: 'stops: [0.0, 0.30, 1.0]',
        gradient: _customStops(),
      ),
      _swatch(
        label: 'tile: clamp',
        caption: 'extends edges with\nfirst/last color',
        gradient: _clamped(),
      ),
      _swatch(
        label: 'tile: repeated',
        caption: 'wraps the gradient\nstart -> end',
        gradient: _repeated(),
      ),
      _swatch(
        label: 'tile: mirror',
        caption: 'reflects each tile\nback and forth',
        gradient: _mirrored(),
      ),
      _swatch(
        label: 'tile: decal',
        caption: 'transparent outside\nthe gradient band',
        gradient: _decal(),
      ),
    ];
    return Wrap(
      alignment: WrapAlignment.center,
      children: swatches,
    );
  }
}

// =============================================================================
// SECTION 2: RADIAL GRADIENT LAB
// =============================================================================

class _RadialGradientLab extends StatelessWidget {
  const _RadialGradientLab();

  Widget _tile({
    required String label,
    required String caption,
    required RadialGradient gradient,
  }) {
    return Container(
      width: 180.0,
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 10.0,
            offset: const Offset(0.0, 4.0),
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Container(
            height: 140.0,
            decoration: BoxDecoration(
              gradient: gradient,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(14.0),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12.0, 10.0, 12.0, 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                _Caption(caption),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: <Widget>[
        _tile(
          label: 'center / r=0.5',
          caption: 'center: center\nradius: 0.5',
          gradient: const RadialGradient(
            colors: <Color>[Color(0xFFFFEB3B), Color(0xFFE53935)],
          ),
        ),
        _tile(
          label: 'wider radius',
          caption: 'radius: 1.0\nsame colors',
          gradient: const RadialGradient(
            radius: 1.0,
            colors: <Color>[Color(0xFFFFEB3B), Color(0xFFE53935)],
          ),
        ),
        _tile(
          label: 'off-center',
          caption: 'center: Alignment(-0.6, -0.6)',
          gradient: const RadialGradient(
            center: Alignment(-0.6, -0.6),
            radius: 0.9,
            colors: <Color>[Color(0xFFFFFFFF), Color(0xFF3F51B5)],
          ),
        ),
        _tile(
          label: 'focal offset',
          caption: 'focal: Alignment(0.4, -0.4)\nfocalRadius: 0.1',
          gradient: const RadialGradient(
            center: Alignment.center,
            focal: Alignment(0.4, -0.4),
            focalRadius: 0.1,
            radius: 0.8,
            colors: <Color>[Color(0xFFFFFFFF), Color(0xFFFF5722)],
          ),
        ),
        _tile(
          label: 'multi-stop',
          caption: 'stops: [0.0, 0.5, 1.0]\nyellow-orange-red',
          gradient: const RadialGradient(
            colors: <Color>[
              Color(0xFFFFEB3B),
              Color(0xFFFF9800),
              Color(0xFFE53935),
            ],
            stops: <double>[0.0, 0.5, 1.0],
          ),
        ),
        _tile(
          label: 'tile: clamp',
          caption: 'tileMode: clamp\nradius: 0.35',
          gradient: const RadialGradient(
            radius: 0.35,
            colors: <Color>[Color(0xFF00BCD4), Color(0xFF3F51B5)],
            tileMode: TileMode.clamp,
          ),
        ),
        _tile(
          label: 'tile: repeated',
          caption: 'tileMode: repeated\nradius: 0.2',
          gradient: const RadialGradient(
            radius: 0.2,
            colors: <Color>[Color(0xFF00BCD4), Color(0xFF3F51B5)],
            tileMode: TileMode.repeated,
          ),
        ),
        _tile(
          label: 'tile: mirror',
          caption: 'tileMode: mirror\nradius: 0.2',
          gradient: const RadialGradient(
            radius: 0.2,
            colors: <Color>[Color(0xFF00BCD4), Color(0xFF3F51B5)],
            tileMode: TileMode.mirror,
          ),
        ),
        _tile(
          label: 'spotlight',
          caption: 'focal off-axis\ndecal tileMode',
          gradient: const RadialGradient(
            center: Alignment.center,
            focal: Alignment(-0.5, -0.5),
            focalRadius: 0.05,
            radius: 0.6,
            colors: <Color>[Color(0xFFFFFFFF), Color(0xFF000000)],
            tileMode: TileMode.decal,
          ),
        ),
      ],
    );
  }
}

// =============================================================================
// SECTION 3: SWEEP GRADIENT COMPASS
// =============================================================================

class _SweepGradientCompass extends StatelessWidget {
  const _SweepGradientCompass();

  static const double _pi = 3.141592653589793;

  Widget _tile({
    required String label,
    required String caption,
    required SweepGradient gradient,
    BoxShape shape = BoxShape.rectangle,
  }) {
    return Container(
      width: 184.0,
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 10.0,
            offset: const Offset(0.0, 4.0),
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 6.0),
            child: AspectRatio(
              aspectRatio: 1.0,
              child: Container(
                decoration: BoxDecoration(
                  shape: shape,
                  borderRadius: shape == BoxShape.rectangle
                      ? BorderRadius.circular(12.0)
                      : null,
                  gradient: gradient,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                _Caption(caption),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: <Widget>[
        _tile(
          label: 'full sweep',
          caption: 'start: 0\nend:   2*pi',
          gradient: const SweepGradient(
            colors: <Color>[
              Color(0xFFE53935),
              Color(0xFFFFEB3B),
              Color(0xFF4CAF50),
              Color(0xFF2196F3),
              Color(0xFF673AB7),
              Color(0xFFE53935),
            ],
          ),
          shape: BoxShape.circle,
        ),
        _tile(
          label: 'half sweep',
          caption: 'start: 0\nend:   pi',
          gradient: SweepGradient(
            endAngle: _pi,
            colors: const <Color>[Color(0xFF2196F3), Color(0xFFE53935)],
          ),
        ),
        _tile(
          label: 'pie slice',
          caption: 'start: pi/4\nend:   3*pi/4',
          gradient: SweepGradient(
            startAngle: _pi / 4,
            endAngle: 3 * _pi / 4,
            colors: const <Color>[Color(0xFFFFEB3B), Color(0xFFE53935)],
          ),
        ),
        _tile(
          label: 'multi-stop',
          caption: 'stops: [0, .25, .5, .75, 1]',
          gradient: const SweepGradient(
            colors: <Color>[
              Color(0xFFE53935),
              Color(0xFFFFEB3B),
              Color(0xFF4CAF50),
              Color(0xFF2196F3),
              Color(0xFFE53935),
            ],
            stops: <double>[0.0, 0.25, 0.5, 0.75, 1.0],
          ),
          shape: BoxShape.circle,
        ),
        _tile(
          label: 'tile clamp',
          caption: 'tileMode: clamp\nshort sweep',
          gradient: SweepGradient(
            endAngle: _pi / 2,
            colors: const <Color>[Color(0xFF03DAC6), Color(0xFF6200EE)],
            tileMode: TileMode.clamp,
          ),
        ),
        _tile(
          label: 'tile repeated',
          caption: 'tileMode: repeated\nendAngle: pi/3',
          gradient: SweepGradient(
            endAngle: _pi / 3,
            colors: const <Color>[Color(0xFF03DAC6), Color(0xFF6200EE)],
            tileMode: TileMode.repeated,
          ),
        ),
        _tile(
          label: 'tile mirror',
          caption: 'tileMode: mirror\nendAngle: pi/3',
          gradient: SweepGradient(
            endAngle: _pi / 3,
            colors: const <Color>[Color(0xFF03DAC6), Color(0xFF6200EE)],
            tileMode: TileMode.mirror,
          ),
        ),
        _tile(
          label: 'center offset',
          caption: 'center: Alignment(0.4, 0.4)',
          gradient: const SweepGradient(
            center: Alignment(0.4, 0.4),
            colors: <Color>[
              Color(0xFF00BCD4),
              Color(0xFFE91E63),
              Color(0xFF00BCD4),
            ],
          ),
          shape: BoxShape.circle,
        ),
      ],
    );
  }
}

// =============================================================================
// SECTION 4: BOX SHADOW MATRIX
// =============================================================================

class _BoxShadowMatrix extends StatelessWidget {
  const _BoxShadowMatrix({required this.scheme});
  final ColorScheme scheme;

  Widget _card({
    required String label,
    required String caption,
    required List<BoxShadow> shadows,
    Color background = Colors.white,
  }) {
    return Container(
      width: 168.0,
      margin: const EdgeInsets.all(14.0),
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(14.0),
        boxShadow: shadows,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 28.0),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          _Caption(caption),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Wrap(
        alignment: WrapAlignment.center,
        children: <Widget>[
          _card(
            label: 'blur: 0',
            caption: 'blurRadius: 0.0\nhard edged shadow',
            shadows: const <BoxShadow>[
              BoxShadow(
                color: Color(0x66000000),
                offset: Offset(0.0, 6.0),
                blurRadius: 0.0,
              ),
            ],
          ),
          _card(
            label: 'blur: 8',
            caption: 'blurRadius: 8.0\nsoft shadow',
            shadows: const <BoxShadow>[
              BoxShadow(
                color: Color(0x55000000),
                offset: Offset(0.0, 4.0),
                blurRadius: 8.0,
              ),
            ],
          ),
          _card(
            label: 'blur: 24',
            caption: 'blurRadius: 24.0\nambient halo',
            shadows: const <BoxShadow>[
              BoxShadow(
                color: Color(0x33000000),
                offset: Offset(0.0, 12.0),
                blurRadius: 24.0,
              ),
            ],
          ),
          _card(
            label: 'spread: -4',
            caption: 'spreadRadius: -4.0\nshadow pulled in',
            shadows: const <BoxShadow>[
              BoxShadow(
                color: Color(0x44000000),
                offset: Offset(0.0, 8.0),
                blurRadius: 12.0,
                spreadRadius: -4.0,
              ),
            ],
          ),
          _card(
            label: 'spread: +6',
            caption: 'spreadRadius: 6.0\nshadow grown',
            shadows: const <BoxShadow>[
              BoxShadow(
                color: Color(0x44000000),
                offset: Offset(0.0, 6.0),
                blurRadius: 10.0,
                spreadRadius: 6.0,
              ),
            ],
          ),
          _card(
            label: 'offset.x',
            caption: 'Offset(12, 0)\nshadow shifted right',
            shadows: const <BoxShadow>[
              BoxShadow(
                color: Color(0x44000000),
                offset: Offset(12.0, 0.0),
                blurRadius: 10.0,
              ),
            ],
          ),
          _card(
            label: 'offset diag',
            caption: 'Offset(10, 10)\ndiagonal drop',
            shadows: const <BoxShadow>[
              BoxShadow(
                color: Color(0x55000000),
                offset: Offset(10.0, 10.0),
                blurRadius: 10.0,
              ),
            ],
          ),
          _card(
            label: 'blur normal',
            caption: 'blurStyle: normal',
            shadows: <BoxShadow>[
              BoxShadow(
                color: scheme.primary.withValues(alpha: 0.45),
                blurRadius: 14.0,
                offset: const Offset(0.0, 6.0),
                blurStyle: BlurStyle.normal,
              ),
            ],
          ),
          _card(
            label: 'blur solid',
            caption: 'blurStyle: solid',
            shadows: <BoxShadow>[
              BoxShadow(
                color: scheme.primary.withValues(alpha: 0.45),
                blurRadius: 14.0,
                offset: const Offset(0.0, 6.0),
                blurStyle: BlurStyle.solid,
              ),
            ],
          ),
          _card(
            label: 'blur outer',
            caption: 'blurStyle: outer',
            shadows: <BoxShadow>[
              BoxShadow(
                color: scheme.primary.withValues(alpha: 0.45),
                blurRadius: 14.0,
                offset: const Offset(0.0, 6.0),
                blurStyle: BlurStyle.outer,
              ),
            ],
          ),
          _card(
            label: 'blur inner',
            caption: 'blurStyle: inner\nrendered as inset',
            shadows: <BoxShadow>[
              BoxShadow(
                color: scheme.primary.withValues(alpha: 0.55),
                blurRadius: 14.0,
                offset: const Offset(0.0, 0.0),
                blurStyle: BlurStyle.inner,
              ),
            ],
          ),
          _card(
            label: 'two layers',
            caption: 'small + large halo\nbuilds depth',
            shadows: <BoxShadow>[
              BoxShadow(
                color: scheme.tertiary.withValues(alpha: 0.45),
                blurRadius: 6.0,
                offset: const Offset(0.0, 2.0),
              ),
              BoxShadow(
                color: scheme.primary.withValues(alpha: 0.30),
                blurRadius: 24.0,
                offset: const Offset(0.0, 12.0),
                spreadRadius: 2.0,
              ),
            ],
          ),
          _card(
            label: 'three layers',
            caption: 'tight + mid + wide\nMaterial elevation',
            shadows: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.20),
                blurRadius: 1.0,
                offset: const Offset(0.0, 1.0),
              ),
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.14),
                blurRadius: 4.0,
                offset: const Offset(0.0, 3.0),
              ),
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.12),
                blurRadius: 10.0,
                offset: const Offset(0.0, 6.0),
              ),
            ],
          ),
          _card(
            label: 'colored 1',
            caption: 'red drop shadow',
            shadows: const <BoxShadow>[
              BoxShadow(
                color: Color(0x66E53935),
                blurRadius: 18.0,
                offset: Offset(0.0, 8.0),
              ),
            ],
          ),
          _card(
            label: 'colored 2',
            caption: 'cyan glow',
            shadows: const <BoxShadow>[
              BoxShadow(
                color: Color(0x6600BCD4),
                blurRadius: 22.0,
                offset: Offset(0.0, 0.0),
                spreadRadius: 2.0,
              ),
            ],
          ),
          _card(
            label: 'colored 3',
            caption: 'violet ambient',
            shadows: const <BoxShadow>[
              BoxShadow(
                color: Color(0x55673AB7),
                blurRadius: 28.0,
                offset: Offset(0.0, 14.0),
                spreadRadius: -2.0,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// SECTION 5: SHADOW PRIMITIVES
// =============================================================================

class _ShadowPrimitives extends StatelessWidget {
  const _ShadowPrimitives({required this.scheme});
  final ColorScheme scheme;

  Widget _textCard({
    required String label,
    required List<Shadow> shadows,
    required Color background,
    required Color foreground,
  }) {
    return Container(
      width: 230.0,
      height: 130.0,
      margin: const EdgeInsets.all(10.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(14.0),
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.w800,
          color: foreground,
          shadows: shadows,
        ),
      ),
    );
  }

  Widget _insetCard({
    required String label,
    required Color color,
  }) {
    // BoxShadow.inner blurStyle simulates an inset look; we layer two for
    // a clearer pressed-in effect on a Material 3 surface tint.
    return Container(
      width: 230.0,
      height: 130.0,
      margin: const EdgeInsets.all(10.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(14.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: color.withValues(alpha: 0.45),
            blurRadius: 14.0,
            blurStyle: BlurStyle.inner,
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4.0,
            blurStyle: BlurStyle.inner,
            offset: const Offset(0.0, 2.0),
          ),
        ],
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w700,
          color: scheme.onSurfaceVariant,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> textCards = <Widget>[
      _textCard(
        label: 'Hard Shadow',
        background: scheme.primaryContainer,
        foreground: scheme.onPrimaryContainer,
        shadows: const <Shadow>[
          Shadow(
            offset: Offset(2.0, 2.0),
            blurRadius: 0.0,
            color: Colors.black54,
          ),
        ],
      ),
      _textCard(
        label: 'Soft Shadow',
        background: scheme.secondaryContainer,
        foreground: scheme.onSecondaryContainer,
        shadows: const <Shadow>[
          Shadow(
            offset: Offset(0.0, 3.0),
            blurRadius: 8.0,
            color: Colors.black45,
          ),
        ],
      ),
      _textCard(
        label: 'Neon Glow',
        background: const Color(0xFF101418),
        foreground: const Color(0xFFE0F7FA),
        shadows: const <Shadow>[
          Shadow(blurRadius: 6.0, color: Color(0xFF00E5FF)),
          Shadow(blurRadius: 18.0, color: Color(0xFF00E5FF)),
          Shadow(blurRadius: 36.0, color: Color(0x9900E5FF)),
        ],
      ),
      _textCard(
        label: 'Layered Drop',
        background: scheme.tertiaryContainer,
        foreground: scheme.onTertiaryContainer,
        shadows: <Shadow>[
          Shadow(
            offset: const Offset(0.0, 1.0),
            blurRadius: 1.0,
            color: Colors.black.withValues(alpha: 0.55),
          ),
          Shadow(
            offset: const Offset(0.0, 4.0),
            blurRadius: 10.0,
            color: Colors.black.withValues(alpha: 0.30),
          ),
        ],
      ),
      _textCard(
        label: 'Embossed',
        background: scheme.surfaceContainerHighest,
        foreground: scheme.onSurface,
        shadows: const <Shadow>[
          Shadow(
            offset: Offset(-1.0, -1.0),
            blurRadius: 0.0,
            color: Colors.white,
          ),
          Shadow(
            offset: Offset(1.0, 1.0),
            blurRadius: 0.0,
            color: Colors.black26,
          ),
        ],
      ),
      _textCard(
        label: 'Long Cast',
        background: scheme.errorContainer,
        foreground: scheme.onErrorContainer,
        shadows: <Shadow>[
          Shadow(
            offset: const Offset(6.0, 6.0),
            blurRadius: 0.0,
            color: scheme.error.withValues(alpha: 0.4),
          ),
        ],
      ),
    ];

    final List<Widget> insets = <Widget>[
      _insetCard(label: 'inset / primary glow', color: scheme.primary),
      _insetCard(label: 'inset / secondary', color: scheme.secondary),
      _insetCard(label: 'inset / tertiary', color: scheme.tertiary),
      _insetCard(label: 'inset / error', color: scheme.error),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6.0),
          child: Text(
            'Text Shadows (Shadow class)',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: scheme.onSurface,
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        Wrap(alignment: WrapAlignment.center, children: textCards),
        const SizedBox(height: 18.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6.0),
          child: Text(
            'Synthetic Inset Cards (BlurStyle.inner)',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: scheme.onSurface,
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        Wrap(alignment: WrapAlignment.center, children: insets),
      ],
    );
  }
}

// =============================================================================
// SECTION 6: LERP INTERPOLATION STRIPS
// =============================================================================

class _LerpStrips extends StatelessWidget {
  const _LerpStrips({required this.scheme});
  final ColorScheme scheme;

  static const int _steps = 9;

  Widget _gradientStrip({
    required String title,
    required LinearGradient a,
    required LinearGradient b,
  }) {
    final List<Widget> cells = <Widget>[];
    for (int i = 0; i < _steps; i++) {
      final double t = i / (_steps - 1);
      final LinearGradient g = LinearGradient.lerp(a, b, t)!;
      cells.add(
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 1.0),
            height: 60.0,
            decoration: BoxDecoration(gradient: g),
          ),
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 6.0),
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: scheme.onSurface,
            ),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Row(children: cells),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const <Widget>[
              Text(
                't = 0.00',
                style: TextStyle(fontFamily: 'monospace', fontSize: 11.0),
              ),
              Text(
                't = 1.00',
                style: TextStyle(fontFamily: 'monospace', fontSize: 11.0),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _shadowStrip({
    required String title,
    required BoxShadow a,
    required BoxShadow b,
  }) {
    final List<Widget> cells = <Widget>[];
    for (int i = 0; i < _steps; i++) {
      final double t = i / (_steps - 1);
      final BoxShadow s = BoxShadow.lerp(a, b, t)!;
      cells.add(
        Container(
          width: 64.0,
          height: 64.0,
          margin: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: <BoxShadow>[s],
          ),
          alignment: Alignment.center,
          child: Text(
            t.toStringAsFixed(2),
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 6.0),
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: scheme.onSurface,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          decoration: BoxDecoration(
            color: scheme.surfaceContainerHighest.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Wrap(alignment: WrapAlignment.center, children: cells),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _gradientStrip(
          title: 'LinearGradient.lerp  blue->red  ==>  yellow->purple',
          a: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: <Color>[Color(0xFF2196F3), Color(0xFFE53935)],
          ),
          b: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: <Color>[Color(0xFFFFEB3B), Color(0xFF673AB7)],
          ),
        ),
        const SizedBox(height: 18.0),
        _gradientStrip(
          title: 'LinearGradient.lerp  horizontal  ==>  diagonal',
          a: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: <Color>[Color(0xFF00BCD4), Color(0xFF03DAC6)],
          ),
          b: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[Color(0xFF6200EE), Color(0xFF03DAC6)],
          ),
        ),
        const SizedBox(height: 18.0),
        _shadowStrip(
          title: 'BoxShadow.lerp  soft black  ==>  spreading violet',
          a: const BoxShadow(
            color: Color(0x33000000),
            blurRadius: 4.0,
            offset: Offset(0.0, 2.0),
          ),
          b: const BoxShadow(
            color: Color(0x88673AB7),
            blurRadius: 22.0,
            offset: Offset(0.0, 12.0),
            spreadRadius: 6.0,
          ),
        ),
      ],
    );
  }
}

// =============================================================================
// SECTION 7: COMBINED RECIPES
// =============================================================================

class _CombinedRecipes extends StatelessWidget {
  const _CombinedRecipes({required this.scheme});
  final ColorScheme scheme;

  Widget _recipe({
    required String title,
    required String description,
    required Gradient gradient,
    required List<BoxShadow> shadows,
    Color textColor = Colors.white,
  }) {
    return Container(
      width: 280.0,
      margin: const EdgeInsets.all(12.0),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(18.0),
        boxShadow: shadows,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w800,
              color: textColor,
              shadows: const <Shadow>[
                Shadow(
                  blurRadius: 6.0,
                  color: Colors.black38,
                  offset: Offset(0.0, 2.0),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          Text(
            description,
            style: TextStyle(
              fontSize: 12.5,
              height: 1.4,
              color: textColor.withValues(alpha: 0.92),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: <Widget>[
        _recipe(
          title: 'Sunset Card',
          description:
              'LinearGradient (orange -> pink -> violet) with a colored\n'
              'drop shadow tinted by the dominant hue.',
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              Color(0xFFFF9800),
              Color(0xFFE91E63),
              Color(0xFF673AB7),
            ],
          ),
          shadows: const <BoxShadow>[
            BoxShadow(
              color: Color(0x55E91E63),
              blurRadius: 24.0,
              offset: Offset(0.0, 14.0),
              spreadRadius: 1.0,
            ),
            BoxShadow(
              color: Color(0x33000000),
              blurRadius: 6.0,
              offset: Offset(0.0, 4.0),
            ),
          ],
        ),
        _recipe(
          title: 'Aurora Panel',
          description:
              'RadialGradient with off-center focal + two-layer shadow:\n'
              'tight black + soft cyan halo.',
          gradient: const RadialGradient(
            center: Alignment(-0.6, -0.4),
            radius: 1.1,
            colors: <Color>[
              Color(0xFF00E5FF),
              Color(0xFF00B0FF),
              Color(0xFF1A237E),
            ],
            stops: <double>[0.0, 0.5, 1.0],
          ),
          shadows: const <BoxShadow>[
            BoxShadow(
              color: Color(0x33000000),
              blurRadius: 4.0,
              offset: Offset(0.0, 2.0),
            ),
            BoxShadow(
              color: Color(0x6600E5FF),
              blurRadius: 28.0,
              offset: Offset(0.0, 0.0),
              spreadRadius: 2.0,
            ),
          ],
        ),
        _recipe(
          title: 'Compass Disc',
          description:
              'SweepGradient pie with three-layer Material elevation,\n'
              'mimicking a floating disc.',
          gradient: const SweepGradient(
            colors: <Color>[
              Color(0xFFE53935),
              Color(0xFFFFEB3B),
              Color(0xFF4CAF50),
              Color(0xFF2196F3),
              Color(0xFFE53935),
            ],
            stops: <double>[0.0, 0.25, 0.5, 0.75, 1.0],
          ),
          shadows: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.20),
              blurRadius: 1.0,
              offset: const Offset(0.0, 1.0),
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.14),
              blurRadius: 6.0,
              offset: const Offset(0.0, 4.0),
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.10),
              blurRadius: 18.0,
              offset: const Offset(0.0, 10.0),
            ),
          ],
        ),
        _recipe(
          title: 'Glass Tile',
          description:
              'Subtle gradient with white-to-clear stops, plus an inner\n'
              'BlurStyle.inner highlight, then a soft outer drop.',
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[Color(0xFFFFFFFF), Color(0xFFB3E5FC)],
          ),
          shadows: <BoxShadow>[
            BoxShadow(
              color: Colors.white.withValues(alpha: 0.85),
              blurRadius: 8.0,
              blurStyle: BlurStyle.inner,
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 18.0,
              offset: const Offset(0.0, 8.0),
            ),
          ],
          textColor: const Color(0xFF003049),
        ),
        _recipe(
          title: 'Citrus Splash',
          description:
              'Sharp two-stop gradient with hard, offset drop shadow.\n'
              'Showcases blurRadius: 0 for a pop-art feel.',
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: <Color>[Color(0xFFFFEB3B), Color(0xFF4CAF50)],
          ),
          shadows: const <BoxShadow>[
            BoxShadow(
              color: Color(0xFF1B5E20),
              offset: Offset(6.0, 6.0),
              blurRadius: 0.0,
            ),
          ],
          textColor: const Color(0xFF1B1B1B),
        ),
        _recipe(
          title: 'Material 3 Surface',
          description:
              'Gradient between primaryContainer and tertiaryContainer\n'
              'with a scheme-tinted shadow stack.',
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[scheme.primaryContainer, scheme.tertiaryContainer],
          ),
          shadows: <BoxShadow>[
            BoxShadow(
              color: scheme.primary.withValues(alpha: 0.35),
              blurRadius: 12.0,
              offset: const Offset(0.0, 6.0),
            ),
            BoxShadow(
              color: scheme.tertiary.withValues(alpha: 0.25),
              blurRadius: 22.0,
              offset: const Offset(0.0, 14.0),
              spreadRadius: 2.0,
            ),
          ],
          textColor: scheme.onPrimaryContainer,
        ),
      ],
    );
  }
}

// =============================================================================
// SECTION 8: GLOSSARY
// =============================================================================

class _Glossary extends StatelessWidget {
  const _Glossary({required this.scheme});
  final ColorScheme scheme;

  Widget _row(String name, String desc, Color accent) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(10.0),
        border: Border(left: BorderSide(color: accent, width: 4.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 6.0,
            offset: const Offset(0.0, 2.0),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 160.0,
            child: Text(
              name,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.5,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              desc,
              style: const TextStyle(fontSize: 12.5, height: 1.35),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Cheat Sheet',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w800,
              color: scheme.onSurface,
            ),
          ),
          const SizedBox(height: 8.0),
          _row(
            'LinearGradient',
            'Colors interpolated along a straight line from begin to end '
                'alignment. Supports stops, tileMode and transform.',
            scheme.primary,
          ),
          _row(
            'RadialGradient',
            'Concentric rings emanating from center out to radius. '
                'Optional focal/focalRadius shifts the inner ring.',
            scheme.secondary,
          ),
          _row(
            'SweepGradient',
            'Pie-shaped sweep from startAngle to endAngle (radians). '
                'Wraps the colors around the center alignment.',
            scheme.tertiary,
          ),
          _row(
            'TileMode.clamp',
            'Edges of the gradient extend with the first/last color.',
            scheme.primary,
          ),
          _row(
            'TileMode.repeated',
            'Gradient tiles end-to-end across the paint region.',
            scheme.secondary,
          ),
          _row(
            'TileMode.mirror',
            'Gradient reflects each tile, producing a seamless wave.',
            scheme.tertiary,
          ),
          _row(
            'TileMode.decal',
            'Outside the gradient band the paint is transparent.',
            scheme.error,
          ),
          _row(
            'stops',
            'Per-color positions in [0..1]. Must match colors length.',
            scheme.primary,
          ),
          _row(
            'Gradient.lerp',
            'LinearGradient/RadialGradient/SweepGradient.lerp(a, b, t) '
                'interpolates compatible gradients channel by channel.',
            scheme.secondary,
          ),
          _row(
            'BoxShadow.color',
            'Shadow tint; alpha controls how heavy the shadow appears.',
            scheme.primary,
          ),
          _row(
            'BoxShadow.offset',
            'Pixel translation of the shadow relative to the source box.',
            scheme.secondary,
          ),
          _row(
            'BoxShadow.blurRadius',
            'Standard deviation of the blur. 0 == hard shadow.',
            scheme.tertiary,
          ),
          _row(
            'BoxShadow.spreadRadius',
            'Inflates (positive) or deflates (negative) the shadow before '
                'blurring.',
            scheme.primary,
          ),
          _row(
            'BoxShadow.blurStyle',
            'normal | solid | outer | inner -- changes whether the shadow '
                'covers the source area or only its outline.',
            scheme.error,
          ),
          _row(
            'Shadow (text)',
            'Used in TextStyle.shadows. Same offset/blur/color knobs but '
                'no spread/blurStyle.',
            scheme.secondary,
          ),
          _row(
            'BoxShadow.lerp',
            'Interpolates color, offset, blurRadius, and spreadRadius '
                'between two BoxShadow values.',
            scheme.tertiary,
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// FOOTER STRIPE
// =============================================================================

class _FooterStripe extends StatelessWidget {
  const _FooterStripe({required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    print('=== Section 9: Footer ===');
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18.0),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: <Color>[
            scheme.errorContainer,
            scheme.tertiaryContainer,
            scheme.primaryContainer,
          ],
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: scheme.primary.withValues(alpha: 0.25),
            blurRadius: 16.0,
            offset: const Offset(0.0, 8.0),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Icon(Icons.palette_outlined, size: 28.0, color: scheme.onPrimaryContainer),
          const SizedBox(width: 12.0),
          Expanded(
            child: Text(
              'End of demo. Every preview above was rendered statically '
              'by the D4rt AST runner from this single hand-authored file.',
              style: TextStyle(
                fontSize: 13.0,
                color: scheme.onPrimaryContainer,
                fontWeight: FontWeight.w600,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// ENTRYPOINT
// =============================================================================

dynamic build(BuildContext context) => const GradientShadowDemoApp();
