// ignore_for_file: unused_field, unused_local_variable, unused_element, unused_element_parameter, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, avoid_redundant_argument_values, unnecessary_import
//
// =====================================================================
// Canvas (dart:ui) — Hand-authored deep visual demo
// =====================================================================
//
// This file is a single-screen deep dive into the `dart:ui` `Canvas`
// API as it is used inside Flutter `CustomPainter` implementations. The
// top-level `build` entry returns a fully-formed widget tree composed of
// many `CustomPaint` cards. Each card focuses on one or two concepts
// from the Canvas / Paint / Path / clip / transform / saveLayer family.
//
// The file is intended for d4rt's analyzer-free interpreter, but it is
// also valid Dart: it passes `dart analyze` cleanly. Hard rules:
//
//   * Single `// ignore_for_file:` header — no inline ignores.
//   * Top-level `dynamic build(BuildContext context)` — called once.
//   * No setState, AnimationController, Timer, Future, Stream, async.
//   * No `drawImage` (no source images at build time).
//   * Private helpers and CustomPainters only.
//   * `Color.withValues(alpha: ...)` for color alpha.
//
// Topics covered:
//   - Paint property gallery (fill/stroke, strokeWidth, strokeCap,
//     strokeJoin, blendMode, maskFilter, colorFilter, imageFilter,
//     shader linear/radial/sweep, isAntiAlias).
//   - Drawing primitives (drawLine, drawRect, drawRRect, drawOval,
//     drawCircle, drawArc, drawPath, drawDRRect, drawShadow, drawPaint,
//     drawPoints, drawParagraph).
//   - Transforms (translate, scale, rotate, skew, transform, save,
//     restore, saveLayer).
//   - Clipping (clipRect, clipRRect, clipPath, Clip enum).
//   - Anti-aliasing comparison and hairline pitfalls.
//   - Code-block cards: idiomatic CustomPainter patterns.
//   - Pitfalls callouts.
//   - Footer cheat-sheet.
//
// =====================================================================

import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

// =====================================================================
// ENTRY POINT
// =====================================================================

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Canvas Deep Visual Demo',
    theme: ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.indigo,
      scaffoldBackgroundColor: const Color(0xFFEEF1F8),
      textTheme: const TextTheme(
        bodySmall: TextStyle(fontSize: 12, height: 1.5),
        bodyMedium: TextStyle(fontSize: 14, height: 1.55),
        titleSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.4,
        ),
        titleMedium: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.1,
        ),
        titleLarge: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.5,
        ),
      ),
    ),
    home: const _CanvasShowcase(),
  );
}

// =====================================================================
// PALETTE
// =====================================================================

class _Palette {
  static const Color ink = Color(0xFF0B1220);
  static const Color inkSoft = Color(0xFF1E293B);
  static const Color slate = Color(0xFF334155);
  static const Color mute = Color(0xFF64748B);
  static const Color paper = Color(0xFFF8FAFC);
  static const Color card = Color(0xFFFFFFFF);
  static const Color line = Color(0xFFE2E8F0);
  static const Color softLine = Color(0xFFF1F5F9);

  static const Color indigo = Color(0xFF4F46E5);
  static const Color blue = Color(0xFF2563EB);
  static const Color cyan = Color(0xFF0891B2);
  static const Color teal = Color(0xFF0D9488);
  static const Color mint = Color(0xFF10B981);
  static const Color amber = Color(0xFFF59E0B);
  static const Color orange = Color(0xFFEA580C);
  static const Color rose = Color(0xFFE11D48);
  static const Color purple = Color(0xFF7C3AED);
  static const Color pink = Color(0xFFDB2777);
  static const Color emerald = Color(0xFF059669);
  static const Color sky = Color(0xFF0EA5E9);
}

// =====================================================================
// SHOWCASE ROOT
// =====================================================================

class _CanvasShowcase extends StatelessWidget {
  const _CanvasShowcase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEF1F8),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const <Widget>[
              _HeroSection(),
              SizedBox(height: 36),
              _PaintPropertyGallerySection(),
              SizedBox(height: 36),
              _PrimitiveGallerySection(),
              SizedBox(height: 36),
              _TransformShowcaseSection(),
              SizedBox(height: 36),
              _ClippingShowcaseSection(),
              SizedBox(height: 36),
              _SaveLayerShowcaseSection(),
              SizedBox(height: 36),
              _ParagraphShowcaseSection(),
              SizedBox(height: 36),
              _AntiAliasShowcaseSection(),
              SizedBox(height: 36),
              _CodeIdiomsSection(),
              SizedBox(height: 36),
              _PitfallsSection(),
              SizedBox(height: 36),
              _CheatSheetSection(),
              SizedBox(height: 72),
            ],
          ),
        ),
      ),
    );
  }
}

// =====================================================================
// SHARED PRIMITIVES
// =====================================================================

class _SectionFrame extends StatelessWidget {
  const _SectionFrame({
    required this.tag,
    required this.title,
    required this.subtitle,
    required this.accent,
    required this.children,
  });

  final String tag;
  final String title;
  final String subtitle;
  final Color accent;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _Palette.card,
        borderRadius: BorderRadius.circular(22),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: accent.withValues(alpha: 0.16),
            blurRadius: 32,
            offset: const Offset(0, 16),
          ),
          BoxShadow(
            color: _Palette.ink.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: _Palette.line),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 8,
                height: 26,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[
                      accent,
                      accent.withValues(alpha: 0.55),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 12),
              _TagChip(label: tag, color: accent),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: _Palette.ink,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 13.5,
              height: 1.55,
              color: _Palette.slate,
            ),
          ),
          const SizedBox(height: 20),
          ...children,
        ],
      ),
    );
  }
}

class _TagChip extends StatelessWidget {
  const _TagChip({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            color.withValues(alpha: 0.18),
            color.withValues(alpha: 0.06),
          ],
        ),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.2,
          color: color,
        ),
      ),
    );
  }
}

class _MiniChip extends StatelessWidget {
  const _MiniChip({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.32)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    );
  }
}

class _PaintCard extends StatelessWidget {
  const _PaintCard({
    required this.title,
    required this.subtitle,
    required this.accent,
    required this.painter,
    this.height = 180,
    this.tags = const <String>[],
  });

  final String title;
  final String subtitle;
  final Color accent;
  final CustomPainter painter;
  final double height;
  final List<String> tags;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _Palette.paper,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _Palette.line),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 6,
                height: 18,
                decoration: BoxDecoration(
                  color: accent,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: _Palette.ink,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 12,
              height: 1.45,
              color: _Palette.mute,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: height,
            decoration: BoxDecoration(
              color: _Palette.card,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _Palette.softLine),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(11),
              child: CustomPaint(painter: painter, size: Size.infinite),
            ),
          ),
          if (tags.isNotEmpty) ...<Widget>[
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: tags
                  .map(
                    (String t) => _MiniChip(label: t, color: accent),
                  )
                  .toList(),
            ),
          ],
        ],
      ),
    );
  }
}

class _CodeBlock extends StatelessWidget {
  const _CodeBlock({required this.code, this.caption});

  final String code;
  final String? caption;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0B1224),
        borderRadius: BorderRadius.circular(14),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color(0xFF0B1224).withValues(alpha: 0.18),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(18, 14, 18, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (caption != null) ...<Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFB7185),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFBBF24),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFF4ADE80),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    caption!,
                    style: const TextStyle(
                      color: Color(0xFFCBD5E1),
                      fontSize: 11,
                      letterSpacing: 1.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
          Text(
            code,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.5,
              height: 1.5,
              color: Color(0xFFE5E7EB),
            ),
          ),
        ],
      ),
    );
  }
}

class _Bullet extends StatelessWidget {
  const _Bullet({required this.text, required this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 7),
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 13,
                height: 1.5,
                color: _Palette.slate,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Callout extends StatelessWidget {
  const _Callout({
    required this.title,
    required this.body,
    required this.accent,
    required this.icon,
  });

  final String title;
  final String body;
  final Color accent;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: accent.withValues(alpha: 0.32)),
      ),
      padding: const EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: accent, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: accent,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  body,
                  style: const TextStyle(
                    fontSize: 13,
                    height: 1.5,
                    color: _Palette.slate,
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

class _GridLayout extends StatelessWidget {
  const _GridLayout({
    required this.children,
    this.columns = 2,
    this.spacing = 14,
  });

  final List<Widget> children;
  final int columns;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double w =
            (constraints.maxWidth - spacing * (columns - 1)) / columns;
        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: children
              .map(
                (Widget child) => SizedBox(width: w, child: child),
              )
              .toList(),
        );
      },
    );
  }
}

// =====================================================================
// 1. HERO SECTION
// =====================================================================

class _HeroSection extends StatelessWidget {
  const _HeroSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Color(0xFF1E1B4B),
            Color(0xFF312E81),
            Color(0xFF4338CA),
          ],
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color(0xFF1E1B4B).withValues(alpha: 0.28),
            blurRadius: 48,
            offset: const Offset(0, 24),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(32, 36, 32, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.22),
                  ),
                ),
                child: const Text(
                  'DART:UI · CANVAS',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    letterSpacing: 1.6,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF22D3EE).withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(
                    color: const Color(0xFF22D3EE).withValues(alpha: 0.32),
                  ),
                ),
                child: const Text(
                  'HAND-AUTHORED',
                  style: TextStyle(
                    color: Color(0xFFA5F3FC),
                    fontSize: 11,
                    letterSpacing: 1.6,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          const Text(
            'Canvas — the low-level drawing surface of Flutter',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
              height: 1.15,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'A `Canvas` records drawing operations into a `PictureRecorder` '
            'or paints into a `RenderObject` layer. Every CustomPainter you '
            'write gets a Canvas plus a Size — and from there you compose '
            'pixels using lines, rects, paths, gradients, blends, clips, '
            'transforms, and saved layers. Canvas is a thin Dart wrapper '
            'over a Skia (or Impeller) `SkCanvas`, so calls map directly '
            'to GPU-side primitives.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.88),
              fontSize: 14.5,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 22),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: const <Widget>[
              _HeroPill(
                label: 'CustomPainter',
                detail: 'paint(Canvas c, Size s) — the workhorse hook.',
                icon: Icons.brush_outlined,
              ),
              _HeroPill(
                label: 'RenderObject',
                detail: 'paint(PaintingContext, Offset) → context.canvas.',
                icon: Icons.layers_outlined,
              ),
              _HeroPill(
                label: 'Skia/Impeller',
                detail: 'Dart Canvas methods call into native SkCanvas ops.',
                icon: Icons.memory_outlined,
              ),
              _HeroPill(
                label: 'Retained mode',
                detail: 'PictureRecorder caches a Picture for replay.',
                icon: Icons.save_alt_outlined,
              ),
            ],
          ),
          const SizedBox(height: 22),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.07),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.14),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'WHERE CANVAS LIVES',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.7),
                    fontSize: 11,
                    letterSpacing: 1.6,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Widget tree → Element tree → RenderObject tree → Layer '
                  'tree → Picture (Canvas recorded ops) → SkCanvas → GPU. '
                  'When you call canvas.drawCircle inside a CustomPainter, '
                  'that op is appended to the picture recording for the '
                  'enclosing RepaintBoundary. On the next frame, the engine '
                  'walks the layer tree and replays each Picture into the '
                  'compositor.',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.86),
                    fontSize: 13,
                    height: 1.6,
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

class _HeroPill extends StatelessWidget {
  const _HeroPill({
    required this.label,
    required this.detail,
    required this.icon,
  });

  final String label;
  final String detail;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.18)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: const Color(0xFF22D3EE).withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 18, color: const Color(0xFFA5F3FC)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  detail,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.75),
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
}

// =====================================================================
// 2. PAINT PROPERTY GALLERY
// =====================================================================

class _PaintPropertyGallerySection extends StatelessWidget {
  const _PaintPropertyGallerySection();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      tag: 'PAINT · 14 CARDS',
      title: 'The Paint object: every property in one place',
      subtitle:
          'A Paint bundles the style, color, stroke, blend, masking, and '
          'filter parameters used by every Canvas drawing call. Each card '
          'isolates one property so you can see the effect directly.',
      accent: _Palette.indigo,
      children: <Widget>[
        const _GridLayout(
          columns: 2,
          children: <Widget>[
            _PaintCard(
              title: 'Style — fill vs stroke',
              subtitle:
                  'PaintingStyle.fill paints the inside; .stroke paints '
                  'only the outline at strokeWidth.',
              accent: _Palette.indigo,
              tags: <String>['PaintingStyle.fill', 'PaintingStyle.stroke'],
              painter: _StyleFillStrokePainter(),
            ),
            _PaintCard(
              title: 'StrokeWidth — 0.5 / 2 / 8',
              subtitle:
                  'Sub-pixel widths trigger AA blending; large widths '
                  'reveal cap and join geometry.',
              accent: _Palette.blue,
              tags: <String>['0.5px', '2px', '8px'],
              painter: _StrokeWidthPainter(),
            ),
            _PaintCard(
              title: 'StrokeCap — butt / round / square',
              subtitle:
                  'How a stroked line terminates. Square extends beyond '
                  'the endpoint by half the strokeWidth.',
              accent: _Palette.cyan,
              tags: <String>['butt', 'round', 'square'],
              painter: _StrokeCapPainter(),
            ),
            _PaintCard(
              title: 'StrokeJoin — miter / round / bevel',
              subtitle:
                  'How two stroked segments meet. Miter can spike when '
                  'angles are sharp — bound it with strokeMiterLimit.',
              accent: _Palette.teal,
              tags: <String>['miter', 'round', 'bevel'],
              painter: _StrokeJoinPainter(),
            ),
            _PaintCard(
              title: 'BlendMode — srcOver / multiply / screen / dst',
              subtitle:
                  'Compositing math between the new draw (src) and the '
                  'existing pixel (dst). srcOver is the default.',
              accent: _Palette.mint,
              tags: <String>['srcOver', 'multiply', 'screen', 'dst'],
              painter: _BlendModePainter(),
            ),
            _PaintCard(
              title: 'MaskFilter — blur normal / inner / outer / solid',
              subtitle:
                  'A blur applied to the alpha mask. BlurStyle.normal '
                  'softens; .solid keeps the shape opaque while blurring '
                  'the halo.',
              accent: _Palette.amber,
              tags: <String>['normal', 'inner', 'outer', 'solid'],
              painter: _MaskFilterPainter(),
            ),
            _PaintCard(
              title: 'ColorFilter.matrix — tint via 4×5 matrix',
              subtitle:
                  'A 20-value matrix maps RGBA → RGBA. Useful for hue '
                  'rotation, grayscale, sepia, or simple tints.',
              accent: _Palette.orange,
              tags: <String>['ColorFilter.matrix', '4x5'],
              painter: _ColorFilterPainter(),
            ),
            _PaintCard(
              title: 'ImageFilter.blur on a Paint',
              subtitle:
                  'Applied at draw time inside a saveLayer; blurs the '
                  'source as it composites. Different from a MaskFilter.',
              accent: _Palette.rose,
              tags: <String>['ImageFilter.blur', 'saveLayer'],
              painter: _ImageFilterPainter(),
            ),
            _PaintCard(
              title: 'Shader — linear gradient',
              subtitle:
                  'Gradient.linear or ui.Gradient.linear. The shader fills '
                  'whatever shape uses this Paint.',
              accent: _Palette.purple,
              tags: <String>['linear', 'Gradient.linear'],
              painter: _LinearGradientPainter(),
            ),
            _PaintCard(
              title: 'Shader — radial gradient',
              subtitle:
                  'Radial gradients can have a focal point and focal '
                  'radius for off-center hotspots.',
              accent: _Palette.pink,
              tags: <String>['radial', 'Gradient.radial'],
              painter: _RadialGradientPainter(),
            ),
            _PaintCard(
              title: 'Shader — sweep gradient',
              subtitle:
                  'Sweeps colors around a center point. Great for color '
                  'wheels, conic decoration, or dial indicators.',
              accent: _Palette.emerald,
              tags: <String>['sweep', 'Gradient.sweep'],
              painter: _SweepGradientPainter(),
            ),
            _PaintCard(
              title: 'isAntiAlias — on vs off',
              subtitle:
                  'Disabling AA gives crisp pixel-perfect edges but can '
                  'cause stair-stepping on rotated geometry.',
              accent: _Palette.sky,
              tags: <String>['AA on', 'AA off'],
              painter: _AntiAliasPainter(),
            ),
            _PaintCard(
              title: 'StrokeMiterLimit',
              subtitle:
                  'Caps miter spikes at sharp angles. When the miter '
                  'length exceeds limit × strokeWidth, the join falls '
                  'back to bevel.',
              accent: _Palette.indigo,
              tags: <String>['miterLimit=2', 'miterLimit=10'],
              painter: _MiterLimitPainter(),
            ),
            _PaintCard(
              title: 'invertColors',
              subtitle:
                  'Flips RGB on draw. Useful for theme toggles, but '
                  'applies after shaders/filters.',
              accent: _Palette.blue,
              tags: <String>['invertColors'],
              painter: _InvertColorsPainter(),
            ),
          ],
        ),
      ],
    );
  }
}

// ---------- Paint property painters ----------

class _StyleFillStrokePainter extends CustomPainter {
  const _StyleFillStrokePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint fill = Paint()
      ..style = PaintingStyle.fill
      ..color = _Palette.indigo;
    final Paint stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..color = _Palette.indigo;

    final double cy = size.height / 2;
    final double r = math.min(size.height, size.width) * 0.28;
    canvas.drawCircle(Offset(size.width * 0.30, cy), r, fill);
    canvas.drawCircle(Offset(size.width * 0.70, cy), r, stroke);

    final TextPainter tpFill = _label('fill', _Palette.indigo);
    tpFill.paint(canvas,
        Offset(size.width * 0.30 - tpFill.width / 2, cy + r + 6));
    final TextPainter tpStroke = _label('stroke', _Palette.indigo);
    tpStroke.paint(canvas,
        Offset(size.width * 0.70 - tpStroke.width / 2, cy + r + 6));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _StrokeWidthPainter extends CustomPainter {
  const _StrokeWidthPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final List<double> widths = <double>[0.5, 2, 8];
    final double spacing = size.height / (widths.length + 1);
    for (int i = 0; i < widths.length; i++) {
      final double y = spacing * (i + 1);
      final Paint p = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = widths[i]
        ..color = _Palette.blue;
      canvas.drawLine(
          Offset(size.width * 0.10, y), Offset(size.width * 0.78, y), p);
      final TextPainter tp =
          _label('${widths[i]} px', _Palette.blue, size: 11);
      tp.paint(canvas, Offset(size.width * 0.80, y - tp.height / 2));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _StrokeCapPainter extends CustomPainter {
  const _StrokeCapPainter();

  @override
  void paint(Canvas canvas, Size size) {
    const List<StrokeCap> caps = <StrokeCap>[
      StrokeCap.butt,
      StrokeCap.round,
      StrokeCap.square,
    ];
    const List<String> names = <String>['butt', 'round', 'square'];
    final double spacing = size.height / (caps.length + 1);
    for (int i = 0; i < caps.length; i++) {
      final double y = spacing * (i + 1);
      final Paint p = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 14
        ..color = _Palette.cyan
        ..strokeCap = caps[i];
      canvas.drawLine(
          Offset(size.width * 0.18, y), Offset(size.width * 0.62, y), p);
      // Endpoint markers
      final Paint dot = Paint()..color = _Palette.ink;
      canvas.drawCircle(Offset(size.width * 0.18, y), 1.5, dot);
      canvas.drawCircle(Offset(size.width * 0.62, y), 1.5, dot);
      final TextPainter tp = _label(names[i], _Palette.cyan, size: 11);
      tp.paint(canvas, Offset(size.width * 0.66, y - tp.height / 2));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _StrokeJoinPainter extends CustomPainter {
  const _StrokeJoinPainter();

  @override
  void paint(Canvas canvas, Size size) {
    const List<StrokeJoin> joins = <StrokeJoin>[
      StrokeJoin.miter,
      StrokeJoin.round,
      StrokeJoin.bevel,
    ];
    const List<String> names = <String>['miter', 'round', 'bevel'];
    final double colW = size.width / 3;
    for (int i = 0; i < joins.length; i++) {
      final Paint p = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 10
        ..color = _Palette.teal
        ..strokeJoin = joins[i]
        ..strokeMiterLimit = 10;
      final double cx = colW * (i + 0.5);
      final double cy = size.height / 2;
      final Path path = Path()
        ..moveTo(cx - 22, cy + 18)
        ..lineTo(cx, cy - 22)
        ..lineTo(cx + 22, cy + 18);
      canvas.drawPath(path, p);
      final TextPainter tp = _label(names[i], _Palette.teal, size: 11);
      tp.paint(canvas, Offset(cx - tp.width / 2, cy + 28));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _BlendModePainter extends CustomPainter {
  const _BlendModePainter();

  @override
  void paint(Canvas canvas, Size size) {
    const List<BlendMode> modes = <BlendMode>[
      BlendMode.srcOver,
      BlendMode.multiply,
      BlendMode.screen,
      BlendMode.dstOver,
    ];
    const List<String> names = <String>[
      'srcOver',
      'multiply',
      'screen',
      'dstOver',
    ];
    final double colW = size.width / modes.length;
    for (int i = 0; i < modes.length; i++) {
      final double cx = colW * (i + 0.5);
      final double cy = size.height * 0.45;
      final Paint a = Paint()..color = const Color(0xFFEF4444);
      final Paint b = Paint()
        ..color = const Color(0xFF3B82F6)
        ..blendMode = modes[i];
      canvas.drawCircle(Offset(cx - 10, cy), 18, a);
      canvas.drawCircle(Offset(cx + 10, cy), 18, b);
      final TextPainter tp = _label(names[i], _Palette.mint, size: 10);
      tp.paint(canvas, Offset(cx - tp.width / 2, size.height - 18));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _MaskFilterPainter extends CustomPainter {
  const _MaskFilterPainter();

  @override
  void paint(Canvas canvas, Size size) {
    const List<BlurStyle> styles = <BlurStyle>[
      BlurStyle.normal,
      BlurStyle.inner,
      BlurStyle.outer,
      BlurStyle.solid,
    ];
    const List<String> names = <String>[
      'normal',
      'inner',
      'outer',
      'solid',
    ];
    final double colW = size.width / styles.length;
    for (int i = 0; i < styles.length; i++) {
      final double cx = colW * (i + 0.5);
      final double cy = size.height * 0.45;
      final Paint p = Paint()
        ..color = _Palette.amber
        ..maskFilter = MaskFilter.blur(styles[i], 6);
      canvas.drawCircle(Offset(cx, cy), 18, p);
      final TextPainter tp = _label(names[i], _Palette.amber, size: 10);
      tp.paint(canvas, Offset(cx - tp.width / 2, size.height - 18));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ColorFilterPainter extends CustomPainter {
  const _ColorFilterPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint base = Paint()..color = const Color(0xFF1E293B);
    final ColorFilter sepia = const ColorFilter.matrix(<double>[
      0.393, 0.769, 0.189, 0, 0,
      0.349, 0.686, 0.168, 0, 0,
      0.272, 0.534, 0.131, 0, 0,
      0,     0,     0,     1, 0,
    ]);
    final ColorFilter invert = const ColorFilter.matrix(<double>[
      -1, 0, 0, 0, 255,
      0, -1, 0, 0, 255,
      0, 0, -1, 0, 255,
      0, 0, 0, 1, 0,
    ]);
    final double cellW = size.width / 3;
    final double cy = size.height * 0.5;
    // Original
    canvas.drawCircle(Offset(cellW * 0.5, cy), 22, base);
    final TextPainter t1 = _label('original', _Palette.orange, size: 10);
    t1.paint(canvas, Offset(cellW * 0.5 - t1.width / 2, size.height - 18));
    // Sepia
    final Paint pSepia = Paint()
      ..color = const Color(0xFF1E293B)
      ..colorFilter = sepia;
    canvas.drawCircle(Offset(cellW * 1.5, cy), 22, pSepia);
    final TextPainter t2 = _label('sepia matrix', _Palette.orange, size: 10);
    t2.paint(canvas, Offset(cellW * 1.5 - t2.width / 2, size.height - 18));
    // Invert
    final Paint pInvert = Paint()
      ..color = const Color(0xFF1E293B)
      ..colorFilter = invert;
    canvas.drawCircle(Offset(cellW * 2.5, cy), 22, pInvert);
    final TextPainter t3 = _label('invert matrix', _Palette.orange, size: 10);
    t3.paint(canvas, Offset(cellW * 2.5 - t3.width / 2, size.height - 18));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ImageFilterPainter extends CustomPainter {
  const _ImageFilterPainter();

  @override
  void paint(Canvas canvas, Size size) {
    // Base shape — sharp
    final Paint sharp = Paint()..color = _Palette.rose;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.08, size.height * 0.28, 70, 56),
        const Radius.circular(10),
      ),
      sharp,
    );
    // Blurred via saveLayer + ImageFilter.blur
    final Rect bounds = Offset.zero & size;
    final Paint blurPaint = Paint()
      ..imageFilter = ui.ImageFilter.blur(sigmaX: 4, sigmaY: 4);
    canvas.saveLayer(bounds, blurPaint);
    final Paint inner = Paint()..color = _Palette.rose;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.52, size.height * 0.28, 70, 56),
        const Radius.circular(10),
      ),
      inner,
    );
    canvas.restore();

    final TextPainter t1 = _label('sharp', _Palette.rose, size: 11);
    t1.paint(canvas, Offset(size.width * 0.08 + 18, size.height - 18));
    final TextPainter t2 = _label('blur σ=4', _Palette.rose, size: 11);
    t2.paint(canvas, Offset(size.width * 0.52 + 10, size.height - 18));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _LinearGradientPainter extends CustomPainter {
  const _LinearGradientPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    final Paint p = Paint()
      ..shader = ui.Gradient.linear(
        rect.topLeft,
        rect.bottomRight,
        const <Color>[
          Color(0xFF7C3AED),
          Color(0xFFEC4899),
          Color(0xFFF59E0B),
        ],
        <double>[0.0, 0.5, 1.0],
      );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        rect.deflate(14),
        const Radius.circular(14),
      ),
      p,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _RadialGradientPainter extends CustomPainter {
  const _RadialGradientPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    final Offset center = Offset(size.width * 0.42, size.height * 0.42);
    final Paint p = Paint()
      ..shader = ui.Gradient.radial(
        center,
        size.shortestSide * 0.55,
        const <Color>[
          Color(0xFFFB7185),
          Color(0xFFDB2777),
          Color(0xFF581C87),
        ],
        <double>[0.0, 0.55, 1.0],
      );
    canvas.drawRect(rect, p);
    final Paint dot = Paint()..color = Colors.white.withValues(alpha: 0.8);
    canvas.drawCircle(center, 3, dot);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _SweepGradientPainter extends CustomPainter {
  const _SweepGradientPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    final Offset center = rect.center;
    final Paint p = Paint()
      ..shader = ui.Gradient.sweep(
        center,
        const <Color>[
          Color(0xFF10B981),
          Color(0xFF0EA5E9),
          Color(0xFF8B5CF6),
          Color(0xFFEC4899),
          Color(0xFFF59E0B),
          Color(0xFF10B981),
        ],
        <double>[0.0, 0.2, 0.4, 0.6, 0.8, 1.0],
      );
    canvas.drawCircle(center, size.shortestSide * 0.42, p);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _AntiAliasPainter extends CustomPainter {
  const _AntiAliasPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final double cy = size.height / 2;
    final Paint aa = Paint()
      ..color = _Palette.sky
      ..isAntiAlias = true;
    final Paint noAA = Paint()
      ..color = _Palette.sky
      ..isAntiAlias = false;
    canvas.save();
    canvas.translate(size.width * 0.30, cy);
    canvas.rotate(0.18);
    canvas.drawRect(Rect.fromCenter(center: Offset.zero, width: 60, height: 60), aa);
    canvas.restore();
    canvas.save();
    canvas.translate(size.width * 0.70, cy);
    canvas.rotate(0.18);
    canvas.drawRect(Rect.fromCenter(center: Offset.zero, width: 60, height: 60), noAA);
    canvas.restore();
    final TextPainter t1 = _label('AA on', _Palette.sky, size: 11);
    t1.paint(canvas, Offset(size.width * 0.30 - t1.width / 2, size.height - 16));
    final TextPainter t2 = _label('AA off', _Palette.sky, size: 11);
    t2.paint(canvas, Offset(size.width * 0.70 - t2.width / 2, size.height - 16));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _MiterLimitPainter extends CustomPainter {
  const _MiterLimitPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final double cy = size.height / 2;
    final Paint low = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..color = _Palette.indigo
      ..strokeJoin = StrokeJoin.miter
      ..strokeMiterLimit = 2;
    final Paint high = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..color = _Palette.indigo
      ..strokeJoin = StrokeJoin.miter
      ..strokeMiterLimit = 10;
    final Path zig1 = Path()
      ..moveTo(size.width * 0.08, cy + 16)
      ..lineTo(size.width * 0.22, cy - 24)
      ..lineTo(size.width * 0.36, cy + 16);
    canvas.drawPath(zig1, low);
    final Path zig2 = Path()
      ..moveTo(size.width * 0.55, cy + 16)
      ..lineTo(size.width * 0.69, cy - 24)
      ..lineTo(size.width * 0.83, cy + 16);
    canvas.drawPath(zig2, high);
    final TextPainter t1 = _label('limit=2 (beveled)', _Palette.indigo, size: 10);
    t1.paint(canvas, Offset(size.width * 0.10, size.height - 16));
    final TextPainter t2 = _label('limit=10 (spike)', _Palette.indigo, size: 10);
    t2.paint(canvas, Offset(size.width * 0.57, size.height - 16));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _InvertColorsPainter extends CustomPainter {
  const _InvertColorsPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = const Color(0xFFF1F5F9);
    canvas.drawRect(Offset.zero & size, bg);
    final Paint a = Paint()..color = _Palette.blue;
    canvas.drawCircle(Offset(size.width * 0.30, size.height / 2), 26, a);
    final Paint b = Paint()
      ..color = _Palette.blue
      ..invertColors = true;
    canvas.drawCircle(Offset(size.width * 0.70, size.height / 2), 26, b);
    final TextPainter t1 = _label('normal', _Palette.blue, size: 11);
    t1.paint(canvas, Offset(size.width * 0.30 - t1.width / 2, size.height - 16));
    final TextPainter t2 = _label('invert', _Palette.blue, size: 11);
    t2.paint(canvas, Offset(size.width * 0.70 - t2.width / 2, size.height - 16));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ---------- text label helper ----------

TextPainter _label(String text, Color color, {double size = 12}) {
  final TextPainter tp = TextPainter(
    text: TextSpan(
      text: text,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: FontWeight.w700,
      ),
    ),
    textDirection: TextDirection.ltr,
  );
  tp.layout();
  return tp;
}

// =====================================================================
// 3. PRIMITIVE GALLERY
// =====================================================================

class _PrimitiveGallerySection extends StatelessWidget {
  const _PrimitiveGallerySection();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      tag: 'PRIMITIVES · 10 CARDS',
      title: 'Drawing primitives: lines, rects, paths, arcs, shadows',
      subtitle:
          'Every shape in Flutter eventually decomposes into these calls. '
          'Knowing them is enough to render almost any 2D effect.',
      accent: _Palette.emerald,
      children: <Widget>[
        const _GridLayout(
          columns: 2,
          children: <Widget>[
            _PaintCard(
              title: 'drawLine — variants',
              subtitle:
                  'Single segments with different colors, widths, and '
                  'caps. Stacked for visual rhythm.',
              accent: _Palette.emerald,
              tags: <String>['drawLine'],
              painter: _DrawLineVariantsPainter(),
            ),
            _PaintCard(
              title: 'drawRect / drawRRect',
              subtitle:
                  'Axis-aligned rectangles. RRect supports per-corner '
                  'radii via RRect.fromRectAndCorners.',
              accent: _Palette.teal,
              tags: <String>['drawRect', 'drawRRect'],
              painter: _DrawRectPainter(),
            ),
            _PaintCard(
              title: 'drawOval / drawCircle',
              subtitle:
                  'Ovals are inscribed in a Rect; circles are a special '
                  'case with center+radius.',
              accent: _Palette.cyan,
              tags: <String>['drawOval', 'drawCircle'],
              painter: _DrawOvalPainter(),
            ),
            _PaintCard(
              title: 'drawArc — open and closed',
              subtitle:
                  'startAngle and sweepAngle in radians. useCenter=true '
                  'draws a pie slice; false draws an open arc.',
              accent: _Palette.amber,
              tags: <String>['drawArc', 'useCenter'],
              painter: _DrawArcPainter(),
            ),
            _PaintCard(
              title: 'drawPath — multi-segment',
              subtitle:
                  'moveTo, lineTo, cubicTo, quadraticBezierTo, conicTo, '
                  'arcTo — all chain into a single Path.',
              accent: _Palette.purple,
              tags: <String>[
                'moveTo',
                'lineTo',
                'cubicTo',
                'quadraticBezierTo',
              ],
              painter: _DrawPathPainter(),
            ),
            _PaintCard(
              title: 'drawDRRect — donut',
              subtitle:
                  'Outer minus inner RRect in one call. Faster than '
                  'painting two separate RRects with even-odd fill.',
              accent: _Palette.rose,
              tags: <String>['drawDRRect'],
              painter: _DrawDRRectPainter(),
            ),
            _PaintCard(
              title: 'drawShadow on a Path',
              subtitle:
                  'Elevation-based shadow under an arbitrary Path. '
                  'Internally uses ShadowBoundsPath + saveLayer.',
              accent: _Palette.indigo,
              tags: <String>['drawShadow', 'elevation'],
              painter: _DrawShadowPainter(),
            ),
            _PaintCard(
              title: 'drawPaint — fill entire canvas',
              subtitle:
                  'Paints the full clip region with the supplied Paint. '
                  'Often used with a shader for backgrounds.',
              accent: _Palette.blue,
              tags: <String>['drawPaint'],
              painter: _DrawPaintPainter(),
            ),
            _PaintCard(
              title: 'drawColor — blend a tint',
              subtitle:
                  'Equivalent to drawPaint(color + blendMode). Cheaper '
                  'and clearer when you just need a flat fill.',
              accent: _Palette.orange,
              tags: <String>['drawColor', 'BlendMode'],
              painter: _DrawColorPainter(),
            ),
            _PaintCard(
              title: 'drawPoints — point/lines/polygon',
              subtitle:
                  'A batch primitive. PointMode controls whether the '
                  'offsets are points, line segments, or a polyline.',
              accent: _Palette.mint,
              tags: <String>['points', 'lines', 'polygon'],
              painter: _DrawPointsPainter(),
            ),
            _PaintCard(
              title: 'Path bezier showcase',
              subtitle:
                  'A single Path stitched from cubic and quadratic '
                  'beziers — the building blocks of curves.',
              accent: _Palette.pink,
              tags: <String>['cubicTo', 'quadraticBezierTo'],
              painter: _PathBezierPainter(),
            ),
            _PaintCard(
              title: 'Path.combine — union, difference',
              subtitle:
                  'Boolean ops on two paths. Returns a new Path with the '
                  'resulting outline only.',
              accent: _Palette.sky,
              tags: <String>['Path.combine', 'PathOperation'],
              painter: _PathCombinePainter(),
            ),
          ],
        ),
      ],
    );
  }
}

// ---------- primitive painters ----------

class _DrawLineVariantsPainter extends CustomPainter {
  const _DrawLineVariantsPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final List<Color> colors = <Color>[
      _Palette.indigo,
      _Palette.cyan,
      _Palette.amber,
      _Palette.rose,
      _Palette.emerald,
    ];
    final double step = size.height / (colors.length + 1);
    for (int i = 0; i < colors.length; i++) {
      final double y = step * (i + 1);
      final Paint p = Paint()
        ..color = colors[i]
        ..strokeWidth = 1.0 + i * 1.2
        ..strokeCap = StrokeCap.round;
      canvas.drawLine(
          Offset(size.width * 0.08, y), Offset(size.width * 0.92, y), p);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _DrawRectPainter extends CustomPainter {
  const _DrawRectPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint fill = Paint()..color = _Palette.teal;
    final Paint stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = _Palette.teal;
    final Rect r = Rect.fromLTWH(20, 20, 80, 60);
    canvas.drawRect(r, fill);
    canvas.drawRect(r.translate(110, 0), stroke);
    final RRect rr = RRect.fromRectAndCorners(
      Rect.fromLTWH(20, size.height - 70, 170, 50),
      topLeft: const Radius.circular(16),
      bottomRight: const Radius.circular(16),
      topRight: const Radius.circular(4),
      bottomLeft: const Radius.circular(4),
    );
    canvas.drawRRect(rr, fill..color = _Palette.teal.withValues(alpha: 0.85));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _DrawOvalPainter extends CustomPainter {
  const _DrawOvalPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint p = Paint()..color = _Palette.cyan;
    canvas.drawOval(
      Rect.fromLTWH(size.width * 0.08, size.height * 0.20, 110, 60),
      p,
    );
    canvas.drawCircle(
      Offset(size.width * 0.78, size.height * 0.55),
      32,
      p..color = _Palette.cyan.withValues(alpha: 0.75),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _DrawArcPainter extends CustomPainter {
  const _DrawArcPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint open = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..color = _Palette.amber
      ..strokeCap = StrokeCap.round;
    final Paint pie = Paint()..color = _Palette.amber.withValues(alpha: 0.75);
    final Rect r1 =
        Rect.fromCircle(center: Offset(size.width * 0.30, size.height / 2), radius: 36);
    canvas.drawArc(r1, math.pi * 0.15, math.pi * 1.3, false, open);
    final Rect r2 =
        Rect.fromCircle(center: Offset(size.width * 0.72, size.height / 2), radius: 36);
    canvas.drawArc(r2, -math.pi / 2, math.pi * 1.2, true, pie);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _DrawPathPainter extends CustomPainter {
  const _DrawPathPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Path path = Path();
    final double w = size.width;
    final double h = size.height;
    path.moveTo(w * 0.10, h * 0.80);
    path.lineTo(w * 0.25, h * 0.20);
    path.quadraticBezierTo(w * 0.40, h * 0.05, w * 0.55, h * 0.40);
    path.cubicTo(
      w * 0.65, h * 0.55,
      w * 0.70, h * 0.10,
      w * 0.85, h * 0.45,
    );
    path.conicTo(w * 0.95, h * 0.70, w * 0.75, h * 0.80, 1.4);
    path.arcToPoint(
      Offset(w * 0.35, h * 0.85),
      radius: const Radius.circular(40),
      clockwise: false,
    );
    path.close();
    final Paint stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..color = _Palette.purple
      ..strokeJoin = StrokeJoin.round;
    final Paint fill = Paint()
      ..color = _Palette.purple.withValues(alpha: 0.15);
    canvas.drawPath(path, fill);
    canvas.drawPath(path, stroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _DrawDRRectPainter extends CustomPainter {
  const _DrawDRRectPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    final Offset center = rect.center;
    final RRect outer = RRect.fromRectAndRadius(
      Rect.fromCenter(center: center, width: 130, height: 130),
      const Radius.circular(28),
    );
    final RRect inner = RRect.fromRectAndRadius(
      Rect.fromCenter(center: center, width: 70, height: 70),
      const Radius.circular(14),
    );
    final Paint p = Paint()..color = _Palette.rose;
    canvas.drawDRRect(outer, inner, p);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _DrawShadowPainter extends CustomPainter {
  const _DrawShadowPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Path path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(
            center: Offset(size.width / 2, size.height / 2),
            width: 130,
            height: 80,
          ),
          const Radius.circular(18),
        ),
      );
    canvas.drawShadow(path, _Palette.ink, 8, true);
    final Paint p = Paint()..color = _Palette.indigo;
    canvas.drawPath(path, p);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _DrawPaintPainter extends CustomPainter {
  const _DrawPaintPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    final Paint p = Paint()
      ..shader = ui.Gradient.linear(
        rect.topLeft,
        rect.bottomRight,
        const <Color>[Color(0xFF1E40AF), Color(0xFF2DD4BF)],
      );
    canvas.drawPaint(p);
    final Paint dot = Paint()..color = Colors.white.withValues(alpha: 0.6);
    canvas.drawCircle(rect.center, 16, dot);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _DrawColorPainter extends CustomPainter {
  const _DrawColorPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = const Color(0xFFFFFBEB);
    canvas.drawRect(Offset.zero & size, bg);
    final Paint shape = Paint()..color = _Palette.orange;
    canvas.drawCircle(Offset(size.width * 0.30, size.height / 2), 32, shape);
    canvas.drawCircle(Offset(size.width * 0.70, size.height / 2), 32, shape);
    // Tint everything with a translucent orange overlay
    canvas.drawColor(_Palette.orange.withValues(alpha: 0.18), BlendMode.srcOver);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _DrawPointsPainter extends CustomPainter {
  const _DrawPointsPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final List<Offset> base = List<Offset>.generate(
      12,
      (int i) => Offset(
        size.width * (0.08 + 0.07 * i),
        size.height * (0.4 + 0.1 * math.sin(i * 0.6)),
      ),
    );
    final Paint p1 = Paint()
      ..color = _Palette.mint
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;
    canvas.drawPoints(ui.PointMode.points, base, p1);
    final Paint p2 = Paint()
      ..color = _Palette.mint.withValues(alpha: 0.6)
      ..strokeWidth = 1.5;
    canvas.drawPoints(ui.PointMode.polygon, base, p2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _PathBezierPainter extends CustomPainter {
  const _PathBezierPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Path path = Path();
    final double w = size.width;
    final double h = size.height;
    path.moveTo(w * 0.05, h * 0.5);
    path.cubicTo(w * 0.25, h * 0.05, w * 0.45, h * 0.95, w * 0.65, h * 0.5);
    path.quadraticBezierTo(w * 0.85, h * 0.10, w * 0.95, h * 0.5);
    final Paint stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..color = _Palette.pink
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(path, stroke);
    // Control point dots
    final Paint ctl = Paint()..color = _Palette.pink.withValues(alpha: 0.6);
    canvas.drawCircle(Offset(w * 0.25, h * 0.05), 3, ctl);
    canvas.drawCircle(Offset(w * 0.45, h * 0.95), 3, ctl);
    canvas.drawCircle(Offset(w * 0.85, h * 0.10), 3, ctl);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _PathCombinePainter extends CustomPainter {
  const _PathCombinePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Path a = Path()
      ..addOval(Rect.fromCircle(
        center: Offset(size.width * 0.40, size.height / 2),
        radius: 38,
      ));
    final Path b = Path()
      ..addOval(Rect.fromCircle(
        center: Offset(size.width * 0.60, size.height / 2),
        radius: 38,
      ));
    final Path union = Path.combine(PathOperation.union, a, b);
    final Path diff = Path.combine(PathOperation.difference, a, b);
    final Paint fill = Paint()..color = _Palette.sky.withValues(alpha: 0.20);
    canvas.drawPath(union, fill);
    final Paint stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = _Palette.sky;
    canvas.drawPath(diff, stroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// =====================================================================
// 4. TRANSFORM SHOWCASE
// =====================================================================

class _TransformShowcaseSection extends StatelessWidget {
  const _TransformShowcaseSection();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      tag: 'TRANSFORMS · 6 CARDS',
      title: 'Transforming the canvas coordinate system',
      subtitle:
          'translate / scale / rotate / skew / transform compose into the '
          'current transform matrix. Each card shows a "before" reference '
          'and an "after" view of the same shape.',
      accent: _Palette.purple,
      children: <Widget>[
        const _GridLayout(
          columns: 2,
          children: <Widget>[
            _PaintCard(
              title: 'translate(dx, dy)',
              subtitle:
                  'Shifts the origin. Subsequent draws appear at (x+dx, '
                  'y+dy). The ghost square shows the un-translated position.',
              accent: _Palette.purple,
              tags: <String>['translate'],
              painter: _TranslatePainter(),
            ),
            _PaintCard(
              title: 'scale uniform — scale(s)',
              subtitle:
                  'Multiplies x and y by the same factor s. strokeWidth '
                  'scales with the matrix unless you compensate.',
              accent: _Palette.indigo,
              tags: <String>['scale(s)'],
              painter: _UniformScalePainter(),
            ),
            _PaintCard(
              title: 'scale non-uniform — scale(sx, sy)',
              subtitle:
                  'Different x/y factors. Circles become ellipses and '
                  'rotations are anisotropically warped.',
              accent: _Palette.blue,
              tags: <String>['scale(sx, sy)'],
              painter: _NonUniformScalePainter(),
            ),
            _PaintCard(
              title: 'rotate(theta)',
              subtitle:
                  'Rotates counter-clockwise around the current origin. '
                  'Combine with translate to rotate around a pivot.',
              accent: _Palette.cyan,
              tags: <String>['rotate'],
              painter: _RotatePainter(),
            ),
            _PaintCard(
              title: 'skew(sx, sy)',
              subtitle:
                  'Shears the canvas. Each unit of x becomes (1, sy); '
                  'each unit of y becomes (sx, 1).',
              accent: _Palette.teal,
              tags: <String>['skew'],
              painter: _SkewPainter(),
            ),
            _PaintCard(
              title: 'transform(Matrix4)',
              subtitle:
                  'Applies an arbitrary 4×4 affine transform via a '
                  'Float64List of 16 elements.',
              accent: _Palette.emerald,
              tags: <String>['transform', 'Matrix4'],
              painter: _Matrix4Painter(),
            ),
          ],
        ),
      ],
    );
  }
}

class _TranslatePainter extends CustomPainter {
  const _TranslatePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint ghost = Paint()..color = _Palette.purple.withValues(alpha: 0.18);
    final Paint p = Paint()..color = _Palette.purple;
    final Rect r = Rect.fromCenter(
        center: Offset(size.width * 0.30, size.height / 2),
        width: 60,
        height: 60);
    canvas.drawRect(r, ghost);
    canvas.save();
    canvas.translate(size.width * 0.40, 0);
    canvas.drawRect(r, p);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _UniformScalePainter extends CustomPainter {
  const _UniformScalePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint ghost = Paint()..color = _Palette.indigo.withValues(alpha: 0.18);
    final Paint p = Paint()..color = _Palette.indigo;
    canvas.drawCircle(Offset(size.width * 0.28, size.height / 2), 24, ghost);
    canvas.save();
    canvas.translate(size.width * 0.70, size.height / 2);
    canvas.scale(1.6);
    canvas.drawCircle(Offset.zero, 24, p);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _NonUniformScalePainter extends CustomPainter {
  const _NonUniformScalePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint ghost = Paint()..color = _Palette.blue.withValues(alpha: 0.18);
    final Paint p = Paint()..color = _Palette.blue;
    canvas.drawCircle(Offset(size.width * 0.28, size.height / 2), 24, ghost);
    canvas.save();
    canvas.translate(size.width * 0.70, size.height / 2);
    canvas.scale(1.8, 0.6);
    canvas.drawCircle(Offset.zero, 24, p);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _RotatePainter extends CustomPainter {
  const _RotatePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint ghost = Paint()..color = _Palette.cyan.withValues(alpha: 0.18);
    final Paint p = Paint()..color = _Palette.cyan;
    final Rect base = Rect.fromCenter(center: Offset.zero, width: 60, height: 40);
    canvas.save();
    canvas.translate(size.width * 0.30, size.height / 2);
    canvas.drawRect(base, ghost);
    canvas.restore();
    canvas.save();
    canvas.translate(size.width * 0.70, size.height / 2);
    canvas.rotate(math.pi / 6);
    canvas.drawRect(base, p);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _SkewPainter extends CustomPainter {
  const _SkewPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint ghost = Paint()..color = _Palette.teal.withValues(alpha: 0.18);
    final Paint p = Paint()..color = _Palette.teal;
    final Rect base = Rect.fromCenter(center: Offset.zero, width: 70, height: 50);
    canvas.save();
    canvas.translate(size.width * 0.30, size.height / 2);
    canvas.drawRect(base, ghost);
    canvas.restore();
    canvas.save();
    canvas.translate(size.width * 0.70, size.height / 2);
    canvas.skew(0.35, 0.0);
    canvas.drawRect(base, p);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _Matrix4Painter extends CustomPainter {
  const _Matrix4Painter();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint ghost = Paint()..color = _Palette.emerald.withValues(alpha: 0.18);
    final Paint p = Paint()..color = _Palette.emerald;
    final Rect base = Rect.fromCenter(center: Offset.zero, width: 64, height: 48);
    canvas.save();
    canvas.translate(size.width * 0.28, size.height / 2);
    canvas.drawRect(base, ghost);
    canvas.restore();
    // Affine: scale 1.3x, shear y, rotate 12 deg, translate.
    final double c = math.cos(0.21);
    final double s = math.sin(0.21);
    final Float64List m = Float64List.fromList(<double>[
      1.3 * c, 1.0 * s, 0, 0,
      -s, c, 0, 0,
      0, 0, 1, 0,
      size.width * 0.70, size.height / 2, 0, 1,
    ]);
    canvas.save();
    canvas.transform(m);
    canvas.drawRect(base, p);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// =====================================================================
// 5. CLIPPING SHOWCASE
// =====================================================================

class _ClippingShowcaseSection extends StatelessWidget {
  const _ClippingShowcaseSection();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      tag: 'CLIPPING · 4 CARDS',
      title: 'clipRect, clipRRect, clipPath and the Clip enum',
      subtitle:
          'Clipping restricts subsequent draws to a region of the canvas. '
          'The Clip enum controls whether the clip is anti-aliased and '
          'whether it forces a saveLayer.',
      accent: _Palette.rose,
      children: <Widget>[
        const _GridLayout(
          columns: 2,
          children: <Widget>[
            _PaintCard(
              title: 'clipRect — axis-aligned',
              subtitle:
                  'Cheapest clip. Hard-edged by default. Anything drawn '
                  'after the clip is masked to the rect.',
              accent: _Palette.rose,
              tags: <String>['clipRect', 'hardEdge'],
              painter: _ClipRectPainter(),
            ),
            _PaintCard(
              title: 'clipRRect — rounded',
              subtitle:
                  'Anti-aliased by default. Use for rounded panels with '
                  'rich content (gradients, images, text).',
              accent: _Palette.orange,
              tags: <String>['clipRRect', 'antiAlias'],
              painter: _ClipRRectPainter(),
            ),
            _PaintCard(
              title: 'clipPath — arbitrary',
              subtitle:
                  'Mask to any Path. Expensive at large sizes — pair with '
                  'saveLayer only when blend modes need it.',
              accent: _Palette.purple,
              tags: <String>['clipPath'],
              painter: _ClipPathPainter(),
            ),
            _PaintCard(
              title: 'Clip enum — none / hardEdge / antiAlias / withSaveLayer',
              subtitle:
                  'Trade-off between edge softness and GPU cost. '
                  'withSaveLayer is required for some blend effects.',
              accent: _Palette.pink,
              tags: <String>['Clip.none', 'Clip.hardEdge', 'Clip.antiAlias'],
              painter: _ClipEnumPainter(),
            ),
          ],
        ),
      ],
    );
  }
}

class _ClipRectPainter extends CustomPainter {
  const _ClipRectPainter();

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    final Rect clip = Rect.fromCenter(
      center: size.center(Offset.zero),
      width: size.width * 0.6,
      height: size.height * 0.55,
    );
    canvas.clipRect(clip);
    final Paint p = Paint()
      ..shader = ui.Gradient.linear(
        Offset.zero,
        Offset(size.width, size.height),
        const <Color>[Color(0xFFE11D48), Color(0xFFFB923C)],
      );
    canvas.drawPaint(p);
    canvas.restore();
    final Paint outline = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = _Palette.rose.withValues(alpha: 0.6);
    canvas.drawRect(
        Rect.fromCenter(
            center: size.center(Offset.zero),
            width: size.width * 0.6,
            height: size.height * 0.55),
        outline);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ClipRRectPainter extends CustomPainter {
  const _ClipRRectPainter();

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    final RRect clip = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: size.center(Offset.zero),
        width: size.width * 0.7,
        height: size.height * 0.6,
      ),
      const Radius.circular(28),
    );
    canvas.clipRRect(clip);
    final Paint p = Paint()
      ..shader = ui.Gradient.radial(
        size.center(Offset.zero),
        size.shortestSide * 0.6,
        const <Color>[Color(0xFFFB923C), Color(0xFFB45309)],
      );
    canvas.drawPaint(p);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ClipPathPainter extends CustomPainter {
  const _ClipPathPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Path star = Path();
    final Offset c = size.center(Offset.zero);
    final double rOuter = size.shortestSide * 0.42;
    final double rInner = rOuter * 0.45;
    for (int i = 0; i < 10; i++) {
      final double r = i.isEven ? rOuter : rInner;
      final double a = -math.pi / 2 + i * math.pi / 5;
      final Offset pt = c + Offset(math.cos(a) * r, math.sin(a) * r);
      if (i == 0) {
        star.moveTo(pt.dx, pt.dy);
      } else {
        star.lineTo(pt.dx, pt.dy);
      }
    }
    star.close();
    canvas.save();
    canvas.clipPath(star);
    final Paint p = Paint()
      ..shader = ui.Gradient.linear(
        Offset.zero,
        Offset(size.width, size.height),
        const <Color>[Color(0xFF7C3AED), Color(0xFFEC4899)],
      );
    canvas.drawPaint(p);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ClipEnumPainter extends CustomPainter {
  const _ClipEnumPainter();

  @override
  void paint(Canvas canvas, Size size) {
    // Demonstrate doAntiAlias true vs false.
    canvas.save();
    canvas.clipRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.05, size.height * 0.18,
            size.width * 0.40, size.height * 0.65),
        const Radius.circular(20),
      ),
      doAntiAlias: false,
    );
    canvas.drawColor(_Palette.pink, BlendMode.srcOver);
    canvas.restore();
    canvas.save();
    canvas.clipRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.55, size.height * 0.18,
            size.width * 0.40, size.height * 0.65),
        const Radius.circular(20),
      ),
    );
    canvas.drawColor(_Palette.pink, BlendMode.srcOver);
    canvas.restore();
    final TextPainter t1 = _label('hardEdge', _Palette.pink, size: 11);
    t1.paint(canvas, Offset(size.width * 0.15, size.height - 16));
    final TextPainter t2 = _label('antiAlias', _Palette.pink, size: 11);
    t2.paint(canvas, Offset(size.width * 0.65, size.height - 16));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// =====================================================================
// 6. SAVE / RESTORE / SAVE-LAYER
// =====================================================================

class _SaveLayerShowcaseSection extends StatelessWidget {
  const _SaveLayerShowcaseSection();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      tag: 'STATE STACK',
      title: 'save, restore, saveLayer — and why they matter',
      subtitle:
          'Canvas state (transform + clip + paint) lives on a stack. save '
          'pushes the current state; restore pops it. saveLayer allocates '
          'an offscreen surface so subsequent draws can be composited as '
          'a group with the layer Paint.',
      accent: _Palette.indigo,
      children: <Widget>[
        const _GridLayout(
          columns: 2,
          children: <Widget>[
            _PaintCard(
              title: 'save / restore — isolating transforms',
              subtitle:
                  'Without restore, the translate/rotate leaks into the '
                  'rest of paint(). Always pair them.',
              accent: _Palette.indigo,
              tags: <String>['save', 'restore'],
              painter: _SaveRestorePainter(),
            ),
            _PaintCard(
              title: 'saveLayer — opacity composition',
              subtitle:
                  'Three overlapping circles, all 50% opacity. Without a '
                  'layer they show overlap darkening; with a layer the '
                  'group composites as one.',
              accent: _Palette.purple,
              tags: <String>['saveLayer', 'opacity'],
              painter: _SaveLayerOpacityPainter(),
            ),
            _PaintCard(
              title: 'Nested saveLayer — blend isolation',
              subtitle:
                  'Inner saveLayer applies a BlendMode within the group '
                  'without leaking to siblings outside the outer layer.',
              accent: _Palette.pink,
              tags: <String>['nested', 'BlendMode'],
              painter: _NestedSaveLayerPainter(),
            ),
            _PaintCard(
              title: 'Layer + ImageFilter — group blur',
              subtitle:
                  'Pass a Paint with imageFilter to saveLayer; the whole '
                  'group is blurred on composite.',
              accent: _Palette.cyan,
              tags: <String>['saveLayer', 'ImageFilter'],
              painter: _LayerBlurPainter(),
            ),
          ],
        ),
      ],
    );
  }
}

class _SaveRestorePainter extends CustomPainter {
  const _SaveRestorePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint p = Paint()..color = _Palette.indigo;
    final Rect r = Rect.fromCenter(center: Offset.zero, width: 38, height: 38);
    for (int i = 0; i < 5; i++) {
      canvas.save();
      canvas.translate(
        size.width * 0.20 + i * (size.width * 0.14),
        size.height / 2,
      );
      canvas.rotate(i * 0.22);
      canvas.drawRect(r, p..color = _Palette.indigo.withValues(alpha: 0.18 + i * 0.14));
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _SaveLayerOpacityPainter extends CustomPainter {
  const _SaveLayerOpacityPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Rect bounds = Offset.zero & size;
    // Without layer (left half)
    final Paint a = Paint()..color = const Color(0x80EF4444);
    final Paint b = Paint()..color = const Color(0x803B82F6);
    final Paint c = Paint()..color = const Color(0x8010B981);
    final double cy = size.height / 2;
    canvas.drawCircle(Offset(size.width * 0.16, cy - 10), 22, a);
    canvas.drawCircle(Offset(size.width * 0.28, cy - 10), 22, b);
    canvas.drawCircle(Offset(size.width * 0.22, cy + 10), 22, c);
    // With layer (right half)
    canvas.saveLayer(bounds, Paint()..color = const Color(0x80FFFFFF));
    canvas.drawCircle(Offset(size.width * 0.66, cy - 10), 22, Paint()..color = const Color(0xFFEF4444));
    canvas.drawCircle(Offset(size.width * 0.78, cy - 10), 22, Paint()..color = const Color(0xFF3B82F6));
    canvas.drawCircle(Offset(size.width * 0.72, cy + 10), 22, Paint()..color = const Color(0xFF10B981));
    canvas.restore();
    final TextPainter t1 = _label('overlap = darker', _Palette.purple, size: 10);
    t1.paint(canvas, Offset(size.width * 0.08, size.height - 16));
    final TextPainter t2 = _label('grouped = one alpha', _Palette.purple, size: 10);
    t2.paint(canvas, Offset(size.width * 0.55, size.height - 16));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _NestedSaveLayerPainter extends CustomPainter {
  const _NestedSaveLayerPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Rect bounds = Offset.zero & size;
    canvas.saveLayer(bounds, Paint());
    final Paint bg = Paint()..color = _Palette.pink.withValues(alpha: 0.15);
    canvas.drawRect(bounds, bg);
    canvas.saveLayer(bounds, Paint()..blendMode = BlendMode.multiply);
    final Paint a = Paint()..color = const Color(0xFFEC4899);
    final Paint b = Paint()..color = const Color(0xFF8B5CF6);
    canvas.drawCircle(Offset(size.width * 0.40, size.height / 2), 30, a);
    canvas.drawCircle(Offset(size.width * 0.60, size.height / 2), 30, b);
    canvas.restore();
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _LayerBlurPainter extends CustomPainter {
  const _LayerBlurPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Rect bounds = Offset.zero & size;
    canvas.saveLayer(
      bounds,
      Paint()..imageFilter = ui.ImageFilter.blur(sigmaX: 3, sigmaY: 3),
    );
    final Paint a = Paint()..color = const Color(0xFF0EA5E9);
    final Paint b = Paint()..color = const Color(0xFF2563EB);
    canvas.drawCircle(Offset(size.width * 0.35, size.height / 2), 26, a);
    canvas.drawRect(
      Rect.fromCenter(
          center: Offset(size.width * 0.65, size.height / 2),
          width: 52,
          height: 52),
      b,
    );
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// =====================================================================
// 7. PARAGRAPH SHOWCASE
// =====================================================================

class _ParagraphShowcaseSection extends StatelessWidget {
  const _ParagraphShowcaseSection();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      tag: 'TEXT ON CANVAS',
      title: 'drawParagraph — text inside a CustomPainter',
      subtitle:
          'Build a Paragraph via ParagraphBuilder or TextPainter, then '
          'call canvas.drawParagraph(paragraph, offset). TextPainter is '
          'higher-level and is what most CustomPainters reach for.',
      accent: _Palette.amber,
      children: <Widget>[
        const _PaintCard(
          title: 'TextPainter snippet rendered on Canvas',
          subtitle:
              'TextPainter handles layout (line breaks, ellipsis, RTL). '
              'Build it inside paint(), call layout(), then paint() at an '
              'Offset. Bounded text uses maxWidth in layout().',
          accent: _Palette.amber,
          height: 220,
          tags: <String>['drawParagraph', 'TextPainter'],
          painter: _ParagraphPainter(),
        ),
        const SizedBox(height: 12),
        const _CodeBlock(
          caption: 'CANVAS · TEXT PAINTER',
          code:
              "final TextPainter tp = TextPainter(\n"
              "  text: TextSpan(text: 'Hello', style: style),\n"
              "  textDirection: TextDirection.ltr,\n"
              "  maxLines: 2,\n"
              "  ellipsis: '…',\n"
              ")..layout(maxWidth: size.width - 32);\n"
              "tp.paint(canvas, Offset(16, 16));",
        ),
      ],
    );
  }
}

class _ParagraphPainter extends CustomPainter {
  const _ParagraphPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = const Color(0xFFFFFBEB);
    canvas.drawRect(Offset.zero & size, bg);

    final TextPainter title = TextPainter(
      text: const TextSpan(
        text: 'Canvas.drawParagraph',
        style: TextStyle(
          color: _Palette.amber,
          fontSize: 18,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.3,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: size.width - 32);
    title.paint(canvas, const Offset(16, 14));

    final TextPainter body = TextPainter(
      text: const TextSpan(
        text:
            'TextPainter wraps the underlying Paragraph machinery. It '
            'handles layout, ellipsis, soft-wrap, RTL, and even hit '
            'testing offsets. After layout(), call paint(canvas, offset) '
            'inside a CustomPainter to render text exactly where you '
            'need it on the canvas.',
        style: TextStyle(
          color: _Palette.slate,
          fontSize: 13.5,
          height: 1.55,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: size.width - 32);
    body.paint(canvas, const Offset(16, 46));

    // Underline accent
    final Paint accent = Paint()
      ..color = _Palette.amber
      ..strokeWidth = 2;
    canvas.drawLine(const Offset(16, 38), Offset(16 + title.width, 38), accent);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// =====================================================================
// 8. ANTI-ALIAS SHOWCASE
// =====================================================================

class _AntiAliasShowcaseSection extends StatelessWidget {
  const _AntiAliasShowcaseSection();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      tag: 'PIXELS',
      title: 'Anti-aliasing & hairline pitfalls',
      subtitle:
          '1px-wide strokes on non-integer coordinates blend across two '
          'pixels and look soft. Either snap to pixel grid or accept the '
          'blur — never both.',
      accent: _Palette.slate,
      children: <Widget>[
        const _GridLayout(
          columns: 2,
          children: <Widget>[
            _PaintCard(
              title: 'Hairlines without pixel snapping',
              subtitle:
                  'A 1.0px stroke at y=10.0 blends across rows 9 and 10. '
                  'The line looks 2px wide and grayish.',
              accent: _Palette.slate,
              tags: <String>['hairline', 'AA blur'],
              painter: _HairlineFloatPainter(),
            ),
            _PaintCard(
              title: 'Hairlines with .5 offset snap',
              subtitle:
                  'Translating by 0.5px centers the stroke on a pixel row '
                  'and yields a crisp 1px line.',
              accent: _Palette.slate,
              tags: <String>['snap=0.5'],
              painter: _HairlineSnappedPainter(),
            ),
            _PaintCard(
              title: 'AA on a rotated rect — soft edges',
              subtitle:
                  'Rotated geometry always benefits from AA, but very '
                  'thin strokes still appear semi-transparent.',
              accent: _Palette.slate,
              tags: <String>['AA on'],
              painter: _AARotatedOnPainter(),
            ),
            _PaintCard(
              title: 'AA off on a rotated rect — stair-step',
              subtitle:
                  'Without AA, rotated edges visibly step. Acceptable for '
                  'pixel art; usually a bug elsewhere.',
              accent: _Palette.slate,
              tags: <String>['AA off'],
              painter: _AARotatedOffPainter(),
            ),
          ],
        ),
      ],
    );
  }
}

class _HairlineFloatPainter extends CustomPainter {
  const _HairlineFloatPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint p = Paint()
      ..color = _Palette.ink
      ..strokeWidth = 1;
    for (int i = 0; i < 8; i++) {
      final double y = 16.0 + i * 14.0; // integer offsets
      canvas.drawLine(Offset(10, y), Offset(size.width - 10, y), p);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _HairlineSnappedPainter extends CustomPainter {
  const _HairlineSnappedPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint p = Paint()
      ..color = _Palette.ink
      ..strokeWidth = 1;
    for (int i = 0; i < 8; i++) {
      final double y = 16.5 + i * 14.0; // half-pixel offsets
      canvas.drawLine(Offset(10, y), Offset(size.width - 10, y), p);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _AARotatedOnPainter extends CustomPainter {
  const _AARotatedOnPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint p = Paint()
      ..color = _Palette.slate
      ..isAntiAlias = true;
    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);
    canvas.rotate(0.18);
    canvas.drawRect(
        Rect.fromCenter(center: Offset.zero, width: 80, height: 60), p);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _AARotatedOffPainter extends CustomPainter {
  const _AARotatedOffPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint p = Paint()
      ..color = _Palette.slate
      ..isAntiAlias = false;
    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);
    canvas.rotate(0.18);
    canvas.drawRect(
        Rect.fromCenter(center: Offset.zero, width: 80, height: 60), p);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// =====================================================================
// 9. CODE-BLOCK IDIOMS
// =====================================================================

class _CodeIdiomsSection extends StatelessWidget {
  const _CodeIdiomsSection();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      tag: 'IDIOMS · 6 BLOCKS',
      title: 'Common CustomPainter patterns',
      subtitle:
          'Six concise snippets you will reach for again and again when '
          'writing custom Canvas code. drawImage is included here for '
          'documentation only — no image is loaded at build time.',
      accent: _Palette.blue,
      children: <Widget>[
        const _CodeBlock(
          caption: 'BASIC CUSTOMPAINTER',
          code:
              "class GridPainter extends CustomPainter {\n"
              "  const GridPainter({required this.color, required this.step});\n"
              "  final Color color;\n"
              "  final double step;\n"
              "\n"
              "  @override\n"
              "  void paint(Canvas canvas, Size size) {\n"
              "    final Paint p = Paint()..color = color..strokeWidth = 1;\n"
              "    for (double x = 0; x < size.width; x += step) {\n"
              "      canvas.drawLine(Offset(x, 0), Offset(x, size.height), p);\n"
              "    }\n"
              "    for (double y = 0; y < size.height; y += step) {\n"
              "      canvas.drawLine(Offset(0, y), Offset(size.width, y), p);\n"
              "    }\n"
              "  }\n"
              "\n"
              "  @override\n"
              "  bool shouldRepaint(covariant GridPainter old) =>\n"
              "      old.color != color || old.step != step;\n"
              "}",
        ),
        const SizedBox(height: 14),
        const _CodeBlock(
          caption: 'LAYERED EFFECTS — SHADOW + FILL + STROKE',
          code:
              "void paint(Canvas canvas, Size size) {\n"
              "  final Path path = Path()..addRRect(\n"
              "    RRect.fromRectAndRadius(\n"
              "      Offset.zero & size, const Radius.circular(20),\n"
              "    ),\n"
              "  );\n"
              "  canvas.drawShadow(path, Colors.black, 8, true);\n"
              "  canvas.drawPath(path, Paint()..color = Colors.indigo);\n"
              "  canvas.drawPath(\n"
              "    path,\n"
              "    Paint()\n"
              "      ..style = PaintingStyle.stroke\n"
              "      ..strokeWidth = 2\n"
              "      ..color = Colors.white,\n"
              "  );\n"
              "}",
        ),
        const SizedBox(height: 14),
        const _CodeBlock(
          caption: 'SAVE / RESTORE DISCIPLINE',
          code:
              "void paint(Canvas canvas, Size size) {\n"
              "  for (int i = 0; i < 6; i++) {\n"
              "    canvas.save();\n"
              "    canvas.translate(size.width / 2, size.height / 2);\n"
              "    canvas.rotate(i * math.pi / 3);\n"
              "    canvas.drawLine(Offset.zero, const Offset(40, 0), paint);\n"
              "    canvas.restore(); // pair every save with a restore!\n"
              "  }\n"
              "  assert(canvas.getSaveCount() == 1);\n"
              "}",
        ),
        const SizedBox(height: 14),
        const _CodeBlock(
          caption: 'GROUP ALPHA WITH SAVELAYER',
          code:
              "void paint(Canvas canvas, Size size) {\n"
              "  final Rect bounds = Offset.zero & size;\n"
              "  canvas.saveLayer(bounds, Paint()..color = const Color(0x80FFFFFF));\n"
              "  // 3 overlapping draws now composite as a single 50% group:\n"
              "  for (int i = 0; i < 3; i++) {\n"
              "    canvas.drawCircle(centers[i], 24, Paint()..color = palette[i]);\n"
              "  }\n"
              "  canvas.restore();\n"
              "}",
        ),
        const SizedBox(height: 14),
        const _CodeBlock(
          caption: 'drawImage — DOCUMENTED, NOT EXECUTED',
          code:
              "// drawImage requires a ui.Image obtained from\n"
              "// ImageDescriptor / Codec.getNextFrame or via\n"
              "// ImageStream listener; never load synchronously at build.\n"
              "//\n"
              "// canvas.drawImage(image, Offset.zero, Paint());\n"
              "// canvas.drawImageRect(image, src, dst, Paint());\n"
              "// canvas.drawImageNine(image, center, dst, Paint());\n"
              "//\n"
              "// Tip: feed a ui.Image into a Shader via\n"
              "// ImageShader for tiling/transformed image fills.",
        ),
        const SizedBox(height: 14),
        const _CodeBlock(
          caption: 'PERFORMANCE — REUSE PAINT, AVOID saveLayer',
          code:
              "// 1. Allocate Paint objects ONCE in the painter constructor\n"
              "//    when the values are static; rebuild only when they change.\n"
              "// 2. Avoid saveLayer in tight loops — each call allocates an\n"
              "//    offscreen surface and forces a copy on restore.\n"
              "// 3. Prefer drawRRect over drawPath when the shape is a\n"
              "//    rounded rect — Skia has a fast path for it.\n"
              "// 4. Implement shouldRepaint precisely. Returning true\n"
              "//    when nothing changed forces a relayout every frame.\n"
              "// 5. Wrap heavy painters in a RepaintBoundary so siblings\n"
              "//    don't repaint when they change.",
        ),
      ],
    );
  }
}

// =====================================================================
// 10. PITFALLS
// =====================================================================

class _PitfallsSection extends StatelessWidget {
  const _PitfallsSection();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      tag: 'PITFALLS · 6 CALLOUTS',
      title: 'Things that will trip you up',
      subtitle:
          'Six concrete failure modes that every Canvas user eventually '
          'hits. Each one shows what goes wrong and how to dodge it.',
      accent: _Palette.rose,
      children: const <Widget>[
        _Callout(
          accent: _Palette.rose,
          icon: Icons.warning_amber_outlined,
          title: 'Forgetting to call restore after save',
          body:
              'A leaked transform corrupts every subsequent draw in the '
              'same paint() call — including draws from sibling painters '
              'that share the canvas (rare in widgets, common in PDF '
              'export). Use try/finally or wrap each section in its own '
              'save/restore.',
        ),
        SizedBox(height: 10),
        _Callout(
          accent: _Palette.orange,
          icon: Icons.warning_amber_outlined,
          title: 'Allocating Paint in every paint() call',
          body:
              'Paint objects are mutable. Reuse them when properties are '
              'static, or hold them as final fields in the CustomPainter. '
              'In hot loops, recreating Paint adds allocation pressure '
              'and triggers shader recompilation.',
        ),
        SizedBox(height: 10),
        _Callout(
          accent: _Palette.amber,
          icon: Icons.warning_amber_outlined,
          title: 'saveLayer is much more expensive than save',
          body:
              'saveLayer allocates an offscreen GPU texture sized to the '
              'bounds. Use only when you need group opacity, group blend '
              'modes, or image filters. Otherwise stick to save / restore.',
        ),
        SizedBox(height: 10),
        _Callout(
          accent: _Palette.indigo,
          icon: Icons.warning_amber_outlined,
          title: 'Hairline stroke pixel snapping',
          body:
              'A 1.0-pixel stroke at integer y values lands between '
              'pixels and looks gray. Offset by 0.5 when you want crisp '
              'lines, or accept the AA blur consistently across the UI.',
        ),
        SizedBox(height: 10),
        _Callout(
          accent: _Palette.purple,
          icon: Icons.warning_amber_outlined,
          title: 'Clipping + stroke interaction',
          body:
              'Strokes have width and extend half outside the path. A '
              'clipPath that exactly matches the stroked path will clip '
              'off half the stroke. Either inflate the clip by '
              'strokeWidth / 2 or paint the stroke before the clip.',
        ),
        SizedBox(height: 10),
        _Callout(
          accent: _Palette.pink,
          icon: Icons.warning_amber_outlined,
          title: 'drawShadow needs accurate path bounds',
          body:
              'Skia computes the shadow from the Path bounds. If you '
              'stroke a path and forget that strokes inflate the bounds, '
              'the shadow gets clipped. Use Path.getBounds() with the '
              'inflated stroke rectangle when sizing parent clips.',
        ),
      ],
    );
  }
}

// =====================================================================
// 11. CHEAT-SHEET FOOTER
// =====================================================================

class _CheatSheetSection extends StatelessWidget {
  const _CheatSheetSection();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      tag: 'CHEAT-SHEET',
      title: 'Every Canvas method covered in this file',
      subtitle:
          'Reference chips for the methods and types demonstrated across '
          'the sections above. Use as a quick mental index.',
      accent: _Palette.ink,
      children: <Widget>[
        _buildGroup('DRAW PRIMITIVES', _Palette.emerald, const <String>[
          'drawLine',
          'drawRect',
          'drawRRect',
          'drawDRRect',
          'drawOval',
          'drawCircle',
          'drawArc',
          'drawPath',
          'drawPoints',
          'drawShadow',
          'drawPaint',
          'drawColor',
          'drawParagraph',
        ]),
        const SizedBox(height: 10),
        _buildGroup('PAINT PROPERTIES', _Palette.indigo, const <String>[
          'color',
          'style (fill/stroke)',
          'strokeWidth',
          'strokeCap',
          'strokeJoin',
          'strokeMiterLimit',
          'blendMode',
          'maskFilter',
          'colorFilter',
          'imageFilter',
          'shader',
          'isAntiAlias',
          'invertColors',
          'filterQuality',
        ]),
        const SizedBox(height: 10),
        _buildGroup('TRANSFORMS', _Palette.purple, const <String>[
          'save',
          'restore',
          'saveLayer',
          'getSaveCount',
          'translate',
          'scale',
          'rotate',
          'skew',
          'transform',
        ]),
        const SizedBox(height: 10),
        _buildGroup('CLIPPING', _Palette.rose, const <String>[
          'clipRect',
          'clipRRect',
          'clipPath',
          'Clip.none',
          'Clip.hardEdge',
          'Clip.antiAlias',
          'Clip.antiAliasWithSaveLayer',
        ]),
        const SizedBox(height: 10),
        _buildGroup('PATHS', _Palette.cyan, const <String>[
          'moveTo',
          'lineTo',
          'cubicTo',
          'quadraticBezierTo',
          'conicTo',
          'arcTo',
          'arcToPoint',
          'addRect',
          'addRRect',
          'addOval',
          'addPath',
          'close',
          'Path.combine',
          'PathOperation.union',
          'PathOperation.difference',
          'PathOperation.intersect',
          'PathOperation.xor',
        ]),
        const SizedBox(height: 10),
        _buildGroup('SHADERS', _Palette.amber, const <String>[
          'Gradient.linear',
          'Gradient.radial',
          'Gradient.sweep',
          'ImageShader (omitted at build)',
          'TileMode.clamp',
          'TileMode.mirror',
          'TileMode.repeated',
          'TileMode.decal',
        ]),
        const SizedBox(height: 10),
        _buildGroup('TEXT', _Palette.orange, const <String>[
          'TextPainter',
          'ParagraphBuilder',
          'TextStyle',
          'TextSpan',
          'maxLines',
          'ellipsis',
        ]),
        const SizedBox(height: 18),
        const _Bullet(
          color: _Palette.slate,
          text:
              'drawImage / drawImageRect / drawImageNine intentionally '
              'omitted from the render demos — no ui.Image is available '
              'at build time. See the documented snippet for the API.',
        ),
        const _Bullet(
          color: _Palette.slate,
          text:
              'Always pair save with restore. Inspect canvas.getSaveCount '
              'in debug builds to catch leaks early.',
        ),
        const _Bullet(
          color: _Palette.slate,
          text:
              'Prefer the most specific method available — drawRRect '
              'over a stroked Path approximation, drawColor over a '
              'full-canvas drawRect.',
        ),
        const _Bullet(
          color: _Palette.slate,
          text:
              'Wrap each CustomPaint inside a RepaintBoundary when its '
              'output is independent of its siblings. This keeps repaint '
              'regions tight.',
        ),
        const _Bullet(
          color: _Palette.slate,
          text:
              'For animations, pass a Listenable to CustomPaint.painter\'s '
              'super constructor and read its value() inside paint(). '
              'shouldRepaint can return false in that pattern because the '
              'Listenable drives the repaint.',
        ),
        const SizedBox(height: 22),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[Color(0xFF0F172A), Color(0xFF1E293B)],
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: const Color(0xFF22D3EE).withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.bolt_outlined,
                  color: Color(0xFFA5F3FC),
                  size: 22,
                ),
              ),
              const SizedBox(width: 14),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'End of the Canvas deep visual demo',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Every section above is a hand-authored CustomPainter '
                      'composition. You can copy any painter into your own '
                      'project unchanged — they are pure dart:ui code.',
                      style: TextStyle(
                        color: Color(0xFFCBD5E1),
                        fontSize: 13,
                        height: 1.55,
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

  Widget _buildGroup(String label, Color accent, List<String> chips) {
    return Container(
      decoration: BoxDecoration(
        color: _Palette.paper,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _Palette.line),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 4,
                height: 14,
                decoration: BoxDecoration(
                  color: accent,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: accent,
                  fontSize: 11,
                  letterSpacing: 1.4,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: chips
                .map((String c) => _MiniChip(label: c, color: accent))
                .toList(),
          ),
        ],
      ),
    );
  }
}
