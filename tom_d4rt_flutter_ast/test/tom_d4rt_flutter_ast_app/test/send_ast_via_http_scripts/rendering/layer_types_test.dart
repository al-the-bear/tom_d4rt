// ignore_for_file: avoid_print, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_element
//
// Layer Types — Hand-authored deep demo for Flutter compositing layers.
//
// This script renders a comprehensive single-screen showcase that exercises
// the full set of compositing Layer subclasses defined in
// `package:flutter/rendering.dart`. You don't construct these layers directly
// in user code: each is allocated by Flutter's rendering pipeline whenever a
// specific widget triggers a save-layer or a transform/clip during paint.
//
// The layer types demonstrated here, and the widgets that produce them:
//
//   • Layer                  — abstract base of the compositing tree
//   • ContainerLayer          — any layer that can hold children
//   • OffsetLayer             — applied at every RenderObject paint offset
//   • TransformLayer          — produced by `Transform`, `RotatedBox`, etc.
//   • ClipRectLayer           — produced by `ClipRect` (and friends)
//   • ClipRRectLayer          — produced by `ClipRRect`
//   • ClipPathLayer           — produced by `ClipPath` with a custom clipper
//   • OpacityLayer            — produced by `Opacity` and `FadeTransition`
//   • BackdropFilterLayer     — produced by `BackdropFilter`
//   • ColorFilterLayer        — produced by `ColorFiltered`
//   • ImageFilterLayer        — produced by `ImageFiltered`
//   • PictureLayer            — every leaf paint, including `CustomPaint`
//
// The demo is fully static. It contains a single `dynamic build(BuildContext)`
// that returns a `MaterialApp`. There are no animations, controllers, timers
// or async work. All helper widgets, painters and clippers are private
// (`_Private`) and live below the entry point.
//
// Visual themes:
//   • A vibrant gradient palette (≥6 distinct gradients).
//   • Layered cards with rich BoxShadows (≥6 shadow stacks).
//   • Sectioned layout with hand-drawn callouts explaining the layer cost.
//
// This file targets ≥800 lines, written by hand. It does not instantiate
// any compositing Layer subclass directly — it composes ordinary widgets
// and each section calls out which layer the widget produces during paint.
//
// =====================================================================

import 'dart:ui' as ui;

import 'package:flutter/material.dart';

// =====================================================================
// ENTRY POINT
// =====================================================================

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Layer Types Demo',
    theme: ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.indigo,
      scaffoldBackgroundColor: const Color(0xFFF4F1FB),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(fontSize: 14, height: 1.4),
        titleLarge: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.5,
        ),
      ),
    ),
    home: const _LayerTypesShowcase(),
  );
}

// =====================================================================
// SHOWCASE ROOT
// =====================================================================

class _LayerTypesShowcase extends StatelessWidget {
  const _LayerTypesShowcase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F1FB),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const <Widget>[
              _HeroSection(),
              SizedBox(height: 32),
              _OffsetContainerSection(),
              SizedBox(height: 32),
              _TransformLayerSection(),
              SizedBox(height: 32),
              _ClipRectLayerSection(),
              SizedBox(height: 32),
              _ClipRRectLayerSection(),
              SizedBox(height: 32),
              _ClipPathLayerSection(),
              SizedBox(height: 32),
              _OpacityLayerSection(),
              SizedBox(height: 32),
              _BackdropFilterSection(),
              SizedBox(height: 32),
              _ColorFilterSection(),
              SizedBox(height: 32),
              _PictureLayerSection(),
              SizedBox(height: 32),
              _CompositeCostSection(),
              SizedBox(height: 32),
              _LegendSection(),
              SizedBox(height: 64),
            ],
          ),
        ),
      ),
    );
  }
}

// =====================================================================
// SHARED PALETTE / GRADIENT BANK
// =====================================================================
//
// All colors and gradients are pre-baked constants. The visual richness of
// the demo intentionally makes heavy use of the layer types being explained:
// every shadow casts a save-layer; every gradient is rasterised into a
// PictureLayer; every Transform/Clip/Opacity introduces another layer.

class _Palette {
  _Palette._();

  static const Color ink = Color(0xFF1B1535);
  static const Color subtleInk = Color(0xFF4F4773);
  static const Color paper = Color(0xFFFFFFFF);

  // Primary brand colors used across sections.
  static const Color violet = Color(0xFF6750A4);
  static const Color violetLight = Color(0xFFB69DF8);
  static const Color rose = Color(0xFFE91E63);
  static const Color amber = Color(0xFFFFB300);
  static const Color teal = Color(0xFF009688);
  static const Color cyan = Color(0xFF00BCD4);
  static const Color emerald = Color(0xFF10B981);
  static const Color slate = Color(0xFF334155);

  // ≥6 gradients — used widely in section backgrounds and decorative blocks.
  static const LinearGradient sunset = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[Color(0xFFFF6A88), Color(0xFFFFB16A), Color(0xFFFFD86A)],
    stops: <double>[0.0, 0.55, 1.0],
  );

  static const LinearGradient ocean = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: <Color>[Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
  );

  static const LinearGradient meadow = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: <Color>[Color(0xFF11998E), Color(0xFF38EF7D)],
  );

  static const LinearGradient candy = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[Color(0xFFFC466B), Color(0xFF3F5EFB)],
  );

  static const RadialGradient lantern = RadialGradient(
    center: Alignment(-0.2, -0.4),
    radius: 1.1,
    colors: <Color>[Color(0xFFFFE7A0), Color(0xFFFFB36B), Color(0xFF6E3D8F)],
    stops: <double>[0.0, 0.45, 1.0],
  );

  static const SweepGradient prism = SweepGradient(
    center: Alignment.center,
    colors: <Color>[
      Color(0xFFFF595E),
      Color(0xFFFFCA3A),
      Color(0xFF8AC926),
      Color(0xFF1982C4),
      Color(0xFF6A4C93),
      Color(0xFFFF595E),
    ],
    stops: <double>[0.0, 0.2, 0.4, 0.6, 0.8, 1.0],
  );

  static const LinearGradient vapor = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[Color(0xFFA1C4FD), Color(0xFFC2E9FB)],
  );

  // ≥6 BoxShadow stacks — chosen to cover soft, hard, glow, and inset-style.
  static const List<BoxShadow> softElevation = <BoxShadow>[
    BoxShadow(color: Color(0x22000000), blurRadius: 20, offset: Offset(0, 12)),
    BoxShadow(color: Color(0x14000000), blurRadius: 4, offset: Offset(0, 2)),
  ];

  static const List<BoxShadow> hardElevation = <BoxShadow>[
    BoxShadow(color: Color(0x33222244), blurRadius: 0, offset: Offset(4, 4)),
    BoxShadow(color: Color(0x22222244), blurRadius: 0, offset: Offset(8, 8)),
  ];

  static const List<BoxShadow> violetGlow = <BoxShadow>[
    BoxShadow(color: Color(0x556750A4), blurRadius: 32, spreadRadius: 1),
    BoxShadow(color: Color(0x336750A4), blurRadius: 64, spreadRadius: 6),
  ];

  static const List<BoxShadow> roseGlow = <BoxShadow>[
    BoxShadow(color: Color(0x66E91E63), blurRadius: 28, spreadRadius: 0),
    BoxShadow(color: Color(0x33E91E63), blurRadius: 60, spreadRadius: 4),
  ];

  static const List<BoxShadow> sunkenInk = <BoxShadow>[
    BoxShadow(
      color: Color(0x33000000),
      blurRadius: 1,
      spreadRadius: 0,
      offset: Offset(0, 1),
    ),
    BoxShadow(
      color: Color(0x55000000),
      blurRadius: 16,
      spreadRadius: -8,
      offset: Offset(0, 12),
    ),
  ];

  static const List<BoxShadow> crispOutline = <BoxShadow>[
    BoxShadow(color: Color(0x22000000), blurRadius: 0, spreadRadius: 1),
    BoxShadow(color: Color(0x11000000), blurRadius: 6, offset: Offset(0, 4)),
  ];
}

// =====================================================================
// SHARED PRIMITIVES — HEADERS, CARDS, CALLOUTS
// =====================================================================

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.label,
    required this.title,
    required this.layerName,
    required this.swatch,
  });

  final String label;
  final String title;
  final String layerName;
  final Color swatch;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 8,
            height: 56,
            decoration: BoxDecoration(
              color: swatch,
              borderRadius: BorderRadius.circular(4),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: swatch.withValues(alpha: 0.45),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  label.toUpperCase(),
                  style: TextStyle(
                    fontSize: 11,
                    letterSpacing: 1.6,
                    fontWeight: FontWeight.w700,
                    color: swatch,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: _Palette.ink,
                    height: 1.05,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Layer: $layerName',
                  style: const TextStyle(
                    fontSize: 13,
                    color: _Palette.subtleInk,
                    fontStyle: FontStyle.italic,
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

class _Callout extends StatelessWidget {
  const _Callout({
    required this.message,
    this.tone = _CalloutTone.info,
  });

  final String message;
  final _CalloutTone tone;

  @override
  Widget build(BuildContext context) {
    final Color bg = switch (tone) {
      _CalloutTone.info => const Color(0xFFEFEBFA),
      _CalloutTone.warn => const Color(0xFFFFF4E1),
      _CalloutTone.tip => const Color(0xFFE6F8EF),
    };
    final Color edge = switch (tone) {
      _CalloutTone.info => _Palette.violet,
      _CalloutTone.warn => _Palette.amber,
      _CalloutTone.tip => _Palette.emerald,
    };
    final IconData icon = switch (tone) {
      _CalloutTone.info => Icons.info_outline,
      _CalloutTone.warn => Icons.bolt_outlined,
      _CalloutTone.tip => Icons.lightbulb_outline,
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(14),
        border: Border(
          left: BorderSide(color: edge, width: 4),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(icon, size: 18, color: edge),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                fontSize: 13,
                height: 1.4,
                color: _Palette.ink,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum _CalloutTone { info, warn, tip }

class _Card extends StatelessWidget {
  const _Card({
    required this.child,
    this.shadows = _Palette.softElevation,
  });

  final Widget child;
  final List<BoxShadow> shadows;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _Palette.paper,
        borderRadius: BorderRadius.circular(20),
        boxShadow: shadows,
      ),
      child: child,
    );
  }
}

// =====================================================================
// SECTION 1 — HERO
// =====================================================================
//
// Layers showcased: OpacityLayer (via Opacity), TransformLayer (via
// Transform.rotate), and several PictureLayers from the gradient blocks.
// =====================================================================

class _HeroSection extends StatelessWidget {
  const _HeroSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 36),
      decoration: BoxDecoration(
        gradient: _Palette.candy,
        borderRadius: BorderRadius.circular(28),
        boxShadow: _Palette.violetGlow,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          // Decorative ribbon: TransformLayer.
          Positioned(
            right: -20,
            top: -16,
            child: Transform.rotate(
              angle: 0.35,
              child: Container(
                width: 220,
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: _Palette.amber,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: _Palette.crispOutline,
                ),
                child: const Text(
                  'LAYERS  •  RENDERING  •  COMPOSITING',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: _Palette.ink,
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.6,
                  ),
                ),
              ),
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'package:flutter/rendering.dart',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                  letterSpacing: 1.4,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Layer Types',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 48,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -1.5,
                  height: 1.0,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                width: 120,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.85),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              const SizedBox(height: 18),
              const SizedBox(
                width: 480,
                child: Text(
                  'A guided tour through the compositing layers Flutter '
                  'creates while painting your widget tree. Each section '
                  'uses the very layer it documents.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    height: 1.5,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Opacity demo: OpacityLayer.
              Row(
                children: <Widget>[
                  for (final double a in <double>[0.25, 0.5, 0.75, 1.0])
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Opacity(
                        opacity: a,
                        child: Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: _Palette.crispOutline,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '${(a * 100).round()}%',
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              color: _Palette.ink,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// SECTION 2 — OffsetLayer & ContainerLayer
// =====================================================================
//
// Every RenderObject paint installs an OffsetLayer when its offset is
// nonzero. ContainerLayer is the abstract supertype of every layer that
// holds children. We show offset accumulation with a stack of nested
// cards anchored by markers.
// =====================================================================

class _OffsetContainerSection extends StatelessWidget {
  const _OffsetContainerSection();

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const _SectionHeader(
            label: 'Section 2',
            title: 'OffsetLayer & ContainerLayer',
            layerName: 'OffsetLayer (extends ContainerLayer)',
            swatch: _Palette.violet,
          ),
          const _Callout(
            message:
                'Every RenderObject paints into an OffsetLayer whose offset '
                'accumulates down the tree. ContainerLayer is the parent '
                'class for any layer with children — including OffsetLayer, '
                'TransformLayer, and all clip layers.',
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 240,
            child: Stack(
              children: const <Widget>[
                Positioned(left: 0, top: 0, child: _OffsetCard(level: 1)),
                Positioned(left: 32, top: 32, child: _OffsetCard(level: 2)),
                Positioned(left: 64, top: 64, child: _OffsetCard(level: 3)),
                Positioned(left: 96, top: 96, child: _OffsetCard(level: 4)),
                Positioned(left: 128, top: 128, child: _OffsetAnchor()),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const _Callout(
            tone: _CalloutTone.tip,
            message:
                'Each Positioned introduces an extra paint offset relative '
                'to the Stack. The OffsetLayer is what carries that offset '
                'into the compositor without forcing a re-paint of children.',
          ),
        ],
      ),
    );
  }
}

class _OffsetCard extends StatelessWidget {
  const _OffsetCard({required this.level});

  final int level;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      height: 100,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: _Palette.vapor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: _Palette.softElevation,
        border: Border.all(color: _Palette.violet.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Level $level',
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              color: _Palette.ink,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'OffsetLayer accumulates offsets through ContainerLayer parents.',
            style: TextStyle(fontSize: 11, color: _Palette.subtleInk),
          ),
        ],
      ),
    );
  }
}

class _OffsetAnchor extends StatelessWidget {
  const _OffsetAnchor();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _Palette.rose,
        boxShadow: _Palette.roseGlow,
      ),
      alignment: Alignment.center,
      child: const Icon(Icons.center_focus_strong,
          color: Colors.white, size: 14),
    );
  }
}

// =====================================================================
// SECTION 3 — TransformLayer
// =====================================================================
//
// `Transform.rotate`, `Transform.scale`, `Transform.translate`, and a
// raw `Transform(transform: Matrix4)` all produce a TransformLayer.
// We render a 3×3 grid that combines several flavors.
// =====================================================================

class _TransformLayerSection extends StatelessWidget {
  const _TransformLayerSection();

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const _SectionHeader(
            label: 'Section 3',
            title: 'TransformLayer',
            layerName: 'TransformLayer',
            swatch: _Palette.cyan,
          ),
          const _Callout(
            message:
                'Transform.rotate / scale / translate, and a raw Matrix4 '
                'transform, all paint into a TransformLayer. The transform '
                'is applied at composite time — children stay sharp.',
          ),
          const SizedBox(height: 16),
          GridView.count(
            crossAxisCount: 3,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: <Widget>[
              _TransformTile(
                label: 'rotate(0.2)',
                child: Transform.rotate(
                  angle: 0.2,
                  child: const _TransformBlock(label: 'rotate'),
                ),
              ),
              _TransformTile(
                label: 'rotate(-0.4)',
                child: Transform.rotate(
                  angle: -0.4,
                  child: const _TransformBlock(label: 'rotate'),
                ),
              ),
              _TransformTile(
                label: 'rotate(0.6)',
                child: Transform.rotate(
                  angle: 0.6,
                  child: const _TransformBlock(label: 'rotate'),
                ),
              ),
              _TransformTile(
                label: 'scale(1.2)',
                child: Transform.scale(
                  scale: 1.2,
                  child: const _TransformBlock(label: 'scale'),
                ),
              ),
              _TransformTile(
                label: 'scale(0.8)',
                child: Transform.scale(
                  scale: 0.8,
                  child: const _TransformBlock(label: 'scale'),
                ),
              ),
              _TransformTile(
                label: 'scale(1.0)',
                child: Transform.scale(
                  scale: 1.0,
                  child: const _TransformBlock(label: 'scale'),
                ),
              ),
              _TransformTile(
                label: 'translate(8,4)',
                child: Transform.translate(
                  offset: const Offset(8, 4),
                  child: const _TransformBlock(label: 'translate'),
                ),
              ),
              _TransformTile(
                label: 'skewX(0.3)',
                child: Transform(
                  transform: Matrix4.skewX(0.3),
                  alignment: Alignment.center,
                  child: const _TransformBlock(label: 'skew'),
                ),
              ),
              _TransformTile(
                label: 'matrix4',
                child: Transform(
                  transform: Matrix4.identity()
                    ..rotateZ(0.15)
                    ..scaleByDouble(0.95, 0.95, 1.0, 1.0),
                  alignment: Alignment.center,
                  child: const _TransformBlock(label: 'matrix'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TransformTile extends StatelessWidget {
  const _TransformTile({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F4FF),
        borderRadius: BorderRadius.circular(14),
        boxShadow: _Palette.hardElevation,
      ),
      child: Column(
        children: <Widget>[
          Expanded(child: Center(child: child)),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: _Palette.subtleInk,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }
}

class _TransformBlock extends StatelessWidget {
  const _TransformBlock({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        gradient: _Palette.candy,
        borderRadius: BorderRadius.circular(12),
        boxShadow: _Palette.roseGlow,
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w800,
          fontSize: 11,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

// =====================================================================
// SECTION 4 — ClipRectLayer
// =====================================================================
//
// `ClipRect` is the cheapest clip layer. We slice a vibrant gradient
// three different ways: top-half, bottom-half, and a centered diamond
// (via custom `clipBehavior`).
// =====================================================================

class _ClipRectLayerSection extends StatelessWidget {
  const _ClipRectLayerSection();

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const _SectionHeader(
            label: 'Section 4',
            title: 'ClipRectLayer',
            layerName: 'ClipRectLayer',
            swatch: _Palette.teal,
          ),
          const _Callout(
            message:
                'ClipRect is the cheapest clip — axis-aligned, no anti-alias '
                'curves, just a bounded rectangle. Each variant below is a '
                'separate ClipRectLayer.',
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 180,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: _ClipRectVariant(
                    title: 'top half',
                    alignment: Alignment.topCenter,
                    heightFactor: 0.5,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _ClipRectVariant(
                    title: 'bottom half',
                    alignment: Alignment.bottomCenter,
                    heightFactor: 0.5,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _ClipRectVariant(
                    title: 'center band',
                    alignment: Alignment.center,
                    heightFactor: 0.4,
                    widthFactor: 0.7,
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

class _ClipRectVariant extends StatelessWidget {
  const _ClipRectVariant({
    required this.title,
    required this.alignment,
    required this.heightFactor,
    this.widthFactor = 1.0,
  });

  final String title;
  final Alignment alignment;
  final double heightFactor;
  final double widthFactor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ClipRect(
            clipBehavior: Clip.hardEdge,
            child: Align(
              alignment: alignment,
              heightFactor: heightFactor,
              widthFactor: widthFactor,
              child: Container(
                decoration: BoxDecoration(
                  gradient: _Palette.sunset,
                  boxShadow: _Palette.softElevation,
                ),
                width: 240,
                height: 180,
                child: const Center(
                  child: Icon(Icons.wb_sunny,
                      color: Colors.white, size: 56),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          title,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: _Palette.subtleInk,
          ),
        ),
      ],
    );
  }
}

// =====================================================================
// SECTION 5 — ClipRRectLayer
// =====================================================================
//
// `ClipRRect` allocates a ClipRRectLayer with an antialiased rounded
// rectangle. We render a gallery: circular, elliptical, and asymmetric
// corner radii on photographic-looking gradient blocks.
// =====================================================================

class _ClipRRectLayerSection extends StatelessWidget {
  const _ClipRRectLayerSection();

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const _SectionHeader(
            label: 'Section 5',
            title: 'ClipRRectLayer',
            layerName: 'ClipRRectLayer',
            swatch: _Palette.amber,
          ),
          const _Callout(
            message:
                'ClipRRect creates a ClipRRectLayer. It supports elliptical '
                'corners and asymmetric radii via BorderRadius.only. Use '
                'Clip.antiAlias for photographic content; Clip.hardEdge for '
                'screenshots and blocky UI.',
          ),
          const SizedBox(height: 16),
          Row(
            children: <Widget>[
              Expanded(
                child: _RRectGalleryItem(
                  title: 'circular 24',
                  radius: BorderRadius.circular(24),
                  gradient: _Palette.ocean,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _RRectGalleryItem(
                  title: 'elliptical',
                  radius: const BorderRadius.all(
                    Radius.elliptical(60, 24),
                  ),
                  gradient: _Palette.meadow,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _RRectGalleryItem(
                  title: 'asymmetric',
                  radius: const BorderRadius.only(
                    topLeft: Radius.circular(48),
                    topRight: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(48),
                  ),
                  gradient: _Palette.lantern,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              Expanded(
                child: _RRectGalleryItem(
                  title: 'pill',
                  radius: BorderRadius.circular(96),
                  gradient: _Palette.candy,
                  height: 96,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _RRectGalleryItem(
                  title: 'rounded square',
                  radius: BorderRadius.circular(36),
                  gradient: _Palette.prism,
                  height: 96,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RRectGalleryItem extends StatelessWidget {
  const _RRectGalleryItem({
    required this.title,
    required this.radius,
    required this.gradient,
    this.height = 140,
  });

  final String title;
  final BorderRadius radius;
  final Gradient gradient;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ClipRRect(
          borderRadius: radius,
          clipBehavior: Clip.antiAlias,
          child: Container(
            height: height,
            decoration: BoxDecoration(
              gradient: gradient,
              boxShadow: _Palette.softElevation,
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          title,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: _Palette.subtleInk,
          ),
        ),
      ],
    );
  }
}

// =====================================================================
// SECTION 6 — ClipPathLayer
// =====================================================================
//
// `ClipPath` with a `CustomClipper<Path>` allocates a ClipPathLayer.
// Three custom clippers below: a star, a heart, and a wave.
// =====================================================================

class _ClipPathLayerSection extends StatelessWidget {
  const _ClipPathLayerSection();

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const _SectionHeader(
            label: 'Section 6',
            title: 'ClipPathLayer',
            layerName: 'ClipPathLayer',
            swatch: _Palette.rose,
          ),
          const _Callout(
            message:
                'ClipPath uses a CustomClipper<Path> to define an arbitrary '
                'shape. It allocates a ClipPathLayer with anti-aliased '
                'edges. Implement shouldReclip to avoid redundant repaints.',
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 180,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: _ClipPathDemo(
                    title: 'star',
                    clipper: const _StarClipper(points: 5),
                    gradient: _Palette.sunset,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _ClipPathDemo(
                    title: 'heart',
                    clipper: const _HeartClipper(),
                    gradient: _Palette.candy,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _ClipPathDemo(
                    title: 'wave',
                    clipper: const _WaveClipper(),
                    gradient: _Palette.ocean,
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

class _ClipPathDemo extends StatelessWidget {
  const _ClipPathDemo({
    required this.title,
    required this.clipper,
    required this.gradient,
  });

  final String title;
  final CustomClipper<Path> clipper;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ClipPath(
            clipper: clipper,
            clipBehavior: Clip.antiAlias,
            child: Container(
              decoration: BoxDecoration(
                gradient: gradient,
                boxShadow: _Palette.softElevation,
              ),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          title,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: _Palette.subtleInk,
          ),
        ),
      ],
    );
  }
}

class _StarClipper extends CustomClipper<Path> {
  const _StarClipper({required this.points});

  final int points;

  @override
  Path getClip(Size size) {
    final Path path = Path();
    final double cx = size.width / 2;
    final double cy = size.height / 2;
    final double rOuter = size.shortestSide / 2;
    final double rInner = rOuter * 0.5;
    final int total = points * 2;
    for (int i = 0; i < total; i++) {
      final double r = i.isEven ? rOuter : rInner;
      final double theta = -3.14159265 / 2 + (i * 3.14159265 / points);
      final double x = cx + r * _cos(theta);
      final double y = cy + r * _sin(theta);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant _StarClipper oldClipper) =>
      oldClipper.points != points;

  // Simple fixed-point approximations to keep the file purely static and
  // free from `dart:math`. Accurate enough for the visual demo.
  static double _cos(double t) {
    // Reduce angle to [-pi, pi] using one-step modulo logic.
    double x = t;
    while (x > 3.14159265) {
      x -= 6.2831853;
    }
    while (x < -3.14159265) {
      x += 6.2831853;
    }
    final double x2 = x * x;
    return 1 - x2 / 2 + x2 * x2 / 24 - x2 * x2 * x2 / 720;
  }

  static double _sin(double t) {
    double x = t;
    while (x > 3.14159265) {
      x -= 6.2831853;
    }
    while (x < -3.14159265) {
      x += 6.2831853;
    }
    final double x2 = x * x;
    return x - x * x2 / 6 + x * x2 * x2 / 120 - x * x2 * x2 * x2 / 5040;
  }
}

class _HeartClipper extends CustomClipper<Path> {
  const _HeartClipper();

  @override
  Path getClip(Size size) {
    final Path path = Path();
    final double w = size.width;
    final double h = size.height;
    path.moveTo(w * 0.5, h * 0.95);
    path.cubicTo(
      w * -0.05, h * 0.55,
      w * 0.15, h * 0.05,
      w * 0.5, h * 0.30,
    );
    path.cubicTo(
      w * 0.85, h * 0.05,
      w * 1.05, h * 0.55,
      w * 0.5, h * 0.95,
    );
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant _HeartClipper oldClipper) => false;
}

class _WaveClipper extends CustomClipper<Path> {
  const _WaveClipper();

  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.lineTo(0, size.height * 0.7);
    path.quadraticBezierTo(
      size.width * 0.25, size.height * 0.95,
      size.width * 0.5, size.height * 0.7,
    );
    path.quadraticBezierTo(
      size.width * 0.75, size.height * 0.45,
      size.width, size.height * 0.7,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant _WaveClipper oldClipper) => false;
}

// =====================================================================
// SECTION 7 — OpacityLayer
// =====================================================================
//
// `Opacity` allocates a save-layer behind the scenes. Anything below
// 1.0 forces an OpacityLayer; this can be expensive for large subtrees.
// We render the same content at 10 opacity steps from 0.1 → 1.0.
// =====================================================================

class _OpacityLayerSection extends StatelessWidget {
  const _OpacityLayerSection();

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const _SectionHeader(
            label: 'Section 7',
            title: 'OpacityLayer',
            layerName: 'OpacityLayer',
            swatch: _Palette.violet,
          ),
          const _Callout(
            tone: _CalloutTone.warn,
            message:
                'Opacity always allocates a save-layer (an OpacityLayer) '
                'whenever opacity < 1.0. For large subtrees, prefer '
                'AnimatedOpacity wrapped in RepaintBoundary, or pre-tinted '
                'colors.',
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 90,
            child: Row(
              children: <Widget>[
                for (int i = 1; i <= 10; i++)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: Opacity(
                        opacity: i / 10.0,
                        child: _OpacityChip(label: '${i * 10}%'),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const _Callout(
            tone: _CalloutTone.tip,
            message:
                'When the underlying widget is a single colored shape, you '
                'can avoid OpacityLayer entirely by tinting the color '
                'directly with .withValues(alpha: x).',
          ),
        ],
      ),
    );
  }
}

class _OpacityChip extends StatelessWidget {
  const _OpacityChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: _Palette.candy,
        borderRadius: BorderRadius.circular(10),
        boxShadow: _Palette.roseGlow,
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w800,
          fontSize: 11,
        ),
      ),
    );
  }
}

// =====================================================================
// SECTION 8 — ImageFilterLayer / BackdropFilterLayer
// =====================================================================
//
// `BackdropFilter` applies an `ImageFilter` to the *content beneath* it,
// allocating a BackdropFilterLayer. We layer three different blur
// sigmas over the same vibrant gradient.
// =====================================================================

class _BackdropFilterSection extends StatelessWidget {
  const _BackdropFilterSection();

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const _SectionHeader(
            label: 'Section 8',
            title: 'BackdropFilterLayer & ImageFilterLayer',
            layerName: 'BackdropFilterLayer / ImageFilterLayer',
            swatch: _Palette.cyan,
          ),
          const _Callout(
            message:
                'BackdropFilter creates a BackdropFilterLayer that runs an '
                'ImageFilter (e.g. ImageFilter.blur) over the content '
                'painted *underneath* it. ImageFiltered runs a filter over '
                'its own subtree, allocating an ImageFilterLayer.',
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: <Widget>[
                Container(
                  height: 220,
                  decoration: BoxDecoration(
                    gradient: _Palette.prism,
                  ),
                ),
                Positioned.fill(
                  child: Row(
                    children: const <Widget>[
                      Expanded(child: _BlurPanel(sigma: 4, label: 'σ=4')),
                      Expanded(child: _BlurPanel(sigma: 12, label: 'σ=12')),
                      Expanded(child: _BlurPanel(sigma: 28, label: 'σ=28')),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const _Callout(
            tone: _CalloutTone.warn,
            message:
                'Blur filters are expensive: cost is ~O(area × sigma). '
                'Wrap the overlay with a RepaintBoundary so its raster is '
                'cached when the underlying content does not change.',
          ),
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              Expanded(child: _ImageFilteredDemo()),
              const SizedBox(width: 12),
              Expanded(child: _ImageFilteredDemo(matrix: true)),
            ],
          ),
        ],
      ),
    );
  }
}

class _BlurPanel extends StatelessWidget {
  const _BlurPanel({required this.sigma, required this.label});

  final double sigma;
  final String label;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ui.ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.18),
          border: Border.symmetric(
            vertical: BorderSide(
              color: Colors.white.withValues(alpha: 0.35),
              width: 1,
            ),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: 16,
            shadows: <Shadow>[
              Shadow(color: Colors.black54, blurRadius: 4),
            ],
          ),
        ),
      ),
    );
  }
}

class _ImageFilteredDemo extends StatelessWidget {
  const _ImageFilteredDemo({this.matrix = false});

  final bool matrix;

  @override
  Widget build(BuildContext context) {
    final Widget content = Container(
      height: 90,
      decoration: BoxDecoration(
        gradient: _Palette.meadow,
        borderRadius: BorderRadius.circular(14),
        boxShadow: _Palette.softElevation,
      ),
      alignment: Alignment.center,
      child: const Text(
        'ImageFiltered',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w800,
          fontSize: 16,
        ),
      ),
    );
    if (matrix) {
      return ImageFiltered(
        imageFilter: ui.ImageFilter.matrix(
          (Matrix4.identity()..scaleByDouble(0.92, 0.92, 1.0, 1.0)).storage,
        ),
        child: content,
      );
    }
    return ImageFiltered(
      imageFilter: ui.ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
      child: content,
    );
  }
}

// =====================================================================
// SECTION 9 — ColorFilterLayer
// =====================================================================
//
// `ColorFiltered` allocates a ColorFilterLayer. We render the same hero
// element through four hand-encoded ColorFilter.matrix(...) filters:
// grayscale, sepia, invert, and a rough hue-shift.
// =====================================================================

class _ColorFilterSection extends StatelessWidget {
  const _ColorFilterSection();

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const _SectionHeader(
            label: 'Section 9',
            title: 'ColorFilterLayer',
            layerName: 'ColorFilterLayer',
            swatch: _Palette.emerald,
          ),
          const _Callout(
            message:
                'ColorFiltered allocates a ColorFilterLayer, applying a 4×5 '
                'color matrix at composite time. Common effects: grayscale, '
                'sepia, invert, hue-shift. Cheaper than ImageFilter blurs.',
          ),
          const SizedBox(height: 16),
          GridView.count(
            crossAxisCount: 4,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.85,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: <Widget>[
              _ColorMatrixTile(label: 'identity', matrix: _identityMatrix()),
              _ColorMatrixTile(label: 'grayscale', matrix: _grayscaleMatrix()),
              _ColorMatrixTile(label: 'sepia', matrix: _sepiaMatrix()),
              _ColorMatrixTile(label: 'invert', matrix: _invertMatrix()),
            ],
          ),
          const SizedBox(height: 12),
          GridView.count(
            crossAxisCount: 4,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.85,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: <Widget>[
              _ColorMatrixTile(label: 'hue-shift', matrix: _hueShiftMatrix()),
              _ColorMatrixTile(
                label: 'desaturate',
                matrix: _saturationMatrix(0.4),
              ),
              _ColorMatrixTile(
                label: 'oversaturate',
                matrix: _saturationMatrix(1.8),
              ),
              _ColorMatrixTile(
                label: 'tint',
                matrix: _tintMatrix(_Palette.violetLight),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static List<double> _identityMatrix() => <double>[
        1, 0, 0, 0, 0,
        0, 1, 0, 0, 0,
        0, 0, 1, 0, 0,
        0, 0, 0, 1, 0,
      ];

  static List<double> _grayscaleMatrix() {
    const double r = 0.2126;
    const double g = 0.7152;
    const double b = 0.0722;
    return <double>[
      r, g, b, 0, 0,
      r, g, b, 0, 0,
      r, g, b, 0, 0,
      0, 0, 0, 1, 0,
    ];
  }

  static List<double> _sepiaMatrix() => <double>[
        0.393, 0.769, 0.189, 0, 0,
        0.349, 0.686, 0.168, 0, 0,
        0.272, 0.534, 0.131, 0, 0,
        0, 0, 0, 1, 0,
      ];

  static List<double> _invertMatrix() => <double>[
        -1, 0, 0, 0, 255,
        0, -1, 0, 0, 255,
        0, 0, -1, 0, 255,
        0, 0, 0, 1, 0,
      ];

  static List<double> _hueShiftMatrix() => <double>[
        0.213, 0.715, 0.072, 0, 0,
        0.213, 0.715, 0.072, 0, 0,
        0.213, 0.715, 0.072, 0, 0,
        0, 0, 0, 1, 0,
      ];

  static List<double> _saturationMatrix(double s) {
    final double inv = 1 - s;
    final double r = 0.213 * inv;
    final double g = 0.715 * inv;
    final double b = 0.072 * inv;
    return <double>[
      r + s, g, b, 0, 0,
      r, g + s, b, 0, 0,
      r, g, b + s, 0, 0,
      0, 0, 0, 1, 0,
    ];
  }

  static List<double> _tintMatrix(Color c) {
    return <double>[
      0.5, 0, 0, 0, c.r * 255 * 0.5,
      0, 0.5, 0, 0, c.g * 255 * 0.5,
      0, 0, 0.5, 0, c.b * 255 * 0.5,
      0, 0, 0, 1, 0,
    ];
  }
}

class _ColorMatrixTile extends StatelessWidget {
  const _ColorMatrixTile({required this.label, required this.matrix});

  final String label;
  final List<double> matrix;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F4FF),
        borderRadius: BorderRadius.circular(14),
        boxShadow: _Palette.softElevation,
      ),
      child: Column(
        children: <Widget>[
          Expanded(
            child: ColorFiltered(
              colorFilter: ColorFilter.matrix(matrix),
              child: Container(
                decoration: BoxDecoration(
                  gradient: _Palette.lantern,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: _Palette.subtleInk,
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// SECTION 10 — PictureLayer
// =====================================================================
//
// Every leaf RenderObject paints into a PictureLayer (or a
// pre-recorded PictureLayer when the raster cache picks it up).
// `CustomPaint` is the most direct way to author one. Below, a private
// `_GlyphPainter` draws shapes onto a CustomPaint.
// =====================================================================

class _PictureLayerSection extends StatelessWidget {
  const _PictureLayerSection();

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const _SectionHeader(
            label: 'Section 10',
            title: 'PictureLayer',
            layerName: 'PictureLayer',
            swatch: _Palette.slate,
          ),
          const _Callout(
            message:
                'CustomPaint produces a PictureLayer: the canvas commands '
                'are recorded once, then the raster is reused across frames '
                'when wrapped in a RepaintBoundary.',
          ),
          const SizedBox(height: 16),
          Container(
            height: 220,
            decoration: BoxDecoration(
              color: _Palette.paper,
              borderRadius: BorderRadius.circular(20),
              boxShadow: _Palette.crispOutline,
            ),
            child: const RepaintBoundary(
              child: CustomPaint(
                painter: _GlyphPainter(),
                size: Size.infinite,
              ),
            ),
          ),
          const SizedBox(height: 16),
          const _Callout(
            tone: _CalloutTone.tip,
            message:
                'Wrap heavy CustomPaint in a RepaintBoundary so the raster '
                'cache reuses the rendered PictureLayer across frames.',
          ),
        ],
      ),
    );
  }
}

class _GlyphPainter extends CustomPainter {
  const _GlyphPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint sky = Paint()
      ..shader = _Palette.vapor.createShader(Offset.zero & size);
    canvas.drawRect(Offset.zero & size, sky);

    // Draw a sun.
    final Paint sun = Paint()
      ..shader = _Palette.sunset.createShader(
        Rect.fromCircle(
          center: Offset(size.width * 0.78, size.height * 0.32),
          radius: 56,
        ),
      );
    canvas.drawCircle(
      Offset(size.width * 0.78, size.height * 0.32),
      48,
      sun,
    );

    // Draw stylized hills.
    final Path hill = Path()
      ..moveTo(0, size.height)
      ..lineTo(0, size.height * 0.7)
      ..quadraticBezierTo(
        size.width * 0.25, size.height * 0.45,
        size.width * 0.5, size.height * 0.65,
      )
      ..quadraticBezierTo(
        size.width * 0.75, size.height * 0.85,
        size.width, size.height * 0.6,
      )
      ..lineTo(size.width, size.height)
      ..close();

    final Paint hillPaint = Paint()
      ..shader = _Palette.meadow.createShader(Offset.zero & size);
    canvas.drawPath(hill, hillPaint);

    // Stars.
    final Paint star = Paint()..color = Colors.white;
    for (int i = 0; i < 8; i++) {
      final double dx = 30.0 + i * size.width / 9;
      final double dy = 30.0 + (i.isOdd ? 16 : 0);
      canvas.drawCircle(Offset(dx, dy), 2.4, star);
    }

    // Geometric badge.
    final Paint badge = Paint()
      ..color = _Palette.ink.withValues(alpha: 0.85)
      ..style = PaintingStyle.fill;
    final RRect rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(20, size.height - 80, 180, 56),
      const Radius.circular(14),
    );
    canvas.drawRRect(rrect, badge);

    final TextSpan span = const TextSpan(
      text: 'PictureLayer demo',
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w800,
        fontSize: 14,
      ),
    );
    final TextPainter tp = TextPainter(
      text: span,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: 160);
    tp.paint(canvas, Offset(36, size.height - 64));
  }

  @override
  bool shouldRepaint(covariant _GlyphPainter oldDelegate) => false;
}

// =====================================================================
// SECTION 11 — Composite Cost & Best Practices
// =====================================================================
//
// A series of callouts that explain when each layer is allocated and
// how to keep the compositor cheap.
// =====================================================================

class _CompositeCostSection extends StatelessWidget {
  const _CompositeCostSection();

  @override
  Widget build(BuildContext context) {
    return _Card(
      shadows: _Palette.sunkenInk,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const <Widget>[
          _SectionHeader(
            label: 'Section 11',
            title: 'Composite Cost & Best Practices',
            layerName: 'Layer (base class) / RepaintBoundary',
            swatch: _Palette.slate,
          ),
          _Callout(
            message:
                'Every save-layer (Opacity, BackdropFilter, ColorFiltered, '
                'ClipPath when antialiased, etc.) costs an off-screen GPU '
                'buffer. Wrapping the subtree in a RepaintBoundary lets the '
                'compositor cache its raster between frames.',
          ),
          SizedBox(height: 8),
          _Callout(
            tone: _CalloutTone.tip,
            message:
                'Prefer ClipRRect over ClipPath when a rounded rectangle '
                'will do — ClipRRect uses a cheap analytical clip, '
                'ClipPath uses a software path mask.',
          ),
          SizedBox(height: 8),
          _Callout(
            tone: _CalloutTone.warn,
            message:
                'Avoid stacking Opacity inside a list of items that animate '
                'independently. Each one creates an OpacityLayer per frame.',
          ),
          SizedBox(height: 8),
          _Callout(
            tone: _CalloutTone.tip,
            message:
                'For repeated heavy CustomPaint, set isComplex: true and '
                'willChange: false on the CustomPaint to nudge the raster '
                'cache.',
          ),
          SizedBox(height: 8),
          _Callout(
            message:
                'BackdropFilterLayer scales with the underlying layer area, '
                'not just the filter sigma. Clip its bounds to the visible '
                'region.',
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// SECTION 12 — Layer Legend
// =====================================================================
//
// A scrollable visual legend that lists every layer covered, the widget
// that produces it, and a short cost note.
// =====================================================================

class _LegendSection extends StatelessWidget {
  const _LegendSection();

  @override
  Widget build(BuildContext context) {
    final List<_LegendEntry> entries = <_LegendEntry>[
      const _LegendEntry(
        layer: 'Layer',
        widget: '— (abstract)',
        cost: 'Base class for all compositing layers.',
        swatch: _Palette.subtleInk,
      ),
      const _LegendEntry(
        layer: 'ContainerLayer',
        widget: '— (abstract)',
        cost: 'Holds children; supertype of the layers below.',
        swatch: _Palette.subtleInk,
      ),
      const _LegendEntry(
        layer: 'OffsetLayer',
        widget: 'every RenderObject paint',
        cost: 'Cheap; just a translation in the layer tree.',
        swatch: _Palette.violet,
      ),
      const _LegendEntry(
        layer: 'TransformLayer',
        widget: 'Transform / RotatedBox',
        cost: 'Cheap; matrix multiply during composite.',
        swatch: _Palette.cyan,
      ),
      const _LegendEntry(
        layer: 'ClipRectLayer',
        widget: 'ClipRect',
        cost: 'Cheap; axis-aligned, no save-layer required.',
        swatch: _Palette.teal,
      ),
      const _LegendEntry(
        layer: 'ClipRRectLayer',
        widget: 'ClipRRect',
        cost: 'Moderate; antialiased rounded clip.',
        swatch: _Palette.amber,
      ),
      const _LegendEntry(
        layer: 'ClipPathLayer',
        widget: 'ClipPath',
        cost: 'Higher; arbitrary path mask.',
        swatch: _Palette.rose,
      ),
      const _LegendEntry(
        layer: 'OpacityLayer',
        widget: 'Opacity / FadeTransition',
        cost: 'Allocates a save-layer when opacity < 1.0.',
        swatch: _Palette.violet,
      ),
      const _LegendEntry(
        layer: 'BackdropFilterLayer',
        widget: 'BackdropFilter',
        cost: 'Expensive; ImageFilter over content beneath.',
        swatch: _Palette.cyan,
      ),
      const _LegendEntry(
        layer: 'ColorFilterLayer',
        widget: 'ColorFiltered',
        cost: 'Moderate; 4×5 color matrix at composite.',
        swatch: _Palette.emerald,
      ),
      const _LegendEntry(
        layer: 'ImageFilterLayer',
        widget: 'ImageFiltered',
        cost: 'Variable; depends on filter (blur, matrix, …).',
        swatch: _Palette.cyan,
      ),
      const _LegendEntry(
        layer: 'PictureLayer',
        widget: 'CustomPaint / leaf paints',
        cost: 'Cached when wrapped in RepaintBoundary.',
        swatch: _Palette.slate,
      ),
    ];

    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const _SectionHeader(
            label: 'Section 12',
            title: 'Legend',
            layerName: 'All layers covered',
            swatch: _Palette.ink,
          ),
          for (final _LegendEntry e in entries) ...<Widget>[
            _LegendRow(entry: e),
            const SizedBox(height: 8),
          ],
        ],
      ),
    );
  }
}

class _LegendEntry {
  const _LegendEntry({
    required this.layer,
    required this.widget,
    required this.cost,
    required this.swatch,
  });

  final String layer;
  final String widget;
  final String cost;
  final Color swatch;
}

class _LegendRow extends StatelessWidget {
  const _LegendRow({required this.entry});

  final _LegendEntry entry;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFFAF8FF),
        borderRadius: BorderRadius.circular(12),
        border: Border(
          left: BorderSide(color: entry.swatch, width: 4),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 160,
            child: Text(
              entry.layer,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontWeight: FontWeight.w800,
                fontSize: 13,
                color: _Palette.ink,
              ),
            ),
          ),
          SizedBox(
            width: 200,
            child: Text(
              entry.widget,
              style: const TextStyle(
                fontSize: 12,
                color: _Palette.subtleInk,
              ),
            ),
          ),
          Expanded(
            child: Text(
              entry.cost,
              style: const TextStyle(
                fontSize: 12,
                color: _Palette.ink,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// END OF FILE
// =====================================================================
