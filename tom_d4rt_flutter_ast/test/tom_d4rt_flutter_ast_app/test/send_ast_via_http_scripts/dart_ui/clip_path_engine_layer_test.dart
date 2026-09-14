// ignore_for_file: unused_field, unused_local_variable, unused_element, unused_element_parameter, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, avoid_redundant_argument_values, unnecessary_import, deprecated_member_use, unused_import
//
// =====================================================================
// dart:ui EngineLayer family — Hand-authored deep visual demo
// =====================================================================
//
// This file is a single-screen deep dive into the `dart:ui` engine
// layer hierarchy as it is produced by `SceneBuilder` and held alive
// by the rendering layer (`flutter/rendering`). The top-level `build`
// entry returns a fully-formed widget tree composed of many sections
// and `CustomPaint` cards that visualize each engine layer kind.
//
// Hard rules:
//   * Single `// ignore_for_file:` header — no inline ignores.
//   * Top-level `dynamic build(BuildContext context)` — called once.
//   * No setState, AnimationController, Timer, Future, Stream, async.
//   * No actual Scene construction — documentation + CustomPainter
//     visualizations only.
//   * Private helpers and CustomPainters only.
//   * `Color.withValues(alpha: ...)` for color alpha.
//
// Sections (11):
//   1.  Hero intro — what engine layers are.
//   2.  EngineLayer class hierarchy (CustomPainter tree).
//   3.  ClipPathEngineLayer focal demo.
//   4.  SceneBuilder pseudo-code walkthrough.
//   5.  Layer reuse story (oldLayer parameter).
//   6.  Six layer-type effect cards.
//   7.  Render pipeline timeline.
//   8.  Layer vs EngineLayer comparison table.
//   9.  Six pitfalls.
//   10. Code-block idioms (six dark cards).
//   11. Footer cheat-sheet.
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
    title: 'EngineLayer Deep Visual Demo',
    theme: ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.deepPurple,
      scaffoldBackgroundColor: const Color(0xFFEFEDF7),
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
    home: const _EngineLayerShowcase(),
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
  static const Color violet = Color(0xFF8B5CF6);
  static const Color fuchsia = Color(0xFFD946EF);
}

// =====================================================================
// SHOWCASE ROOT
// =====================================================================

class _EngineLayerShowcase extends StatelessWidget {
  const _EngineLayerShowcase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFEDF7),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const <Widget>[
              _HeroSection(),
              SizedBox(height: 36),
              _HierarchySection(),
              SizedBox(height: 36),
              _ClipPathFocalSection(),
              SizedBox(height: 36),
              _SceneBuilderWalkthroughSection(),
              SizedBox(height: 36),
              _LayerReuseSection(),
              SizedBox(height: 36),
              _LayerTypeCardsSection(),
              SizedBox(height: 36),
              _RenderPipelineTimelineSection(),
              SizedBox(height: 36),
              _ComparisonTableSection(),
              SizedBox(height: 36),
              _PitfallsSection(),
              SizedBox(height: 36),
              _CodeIdiomsSection(),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.13),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  tag,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.4,
                    color: accent,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: _Palette.ink,
              letterSpacing: -0.3,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 13.5,
              height: 1.6,
              color: _Palette.mute,
            ),
          ),
          const SizedBox(height: 20),
          ...children,
        ],
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
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10.5,
          fontWeight: FontWeight.w700,
          color: color,
          letterSpacing: 0.4,
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
                  .map((String t) => _MiniChip(label: t, color: accent))
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
              .map((Widget child) => SizedBox(width: w, child: child))
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
            Color(0xFF4C1D95),
            Color(0xFF6D28D9),
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
                  'DART:UI · ENGINELAYER',
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
                  color: const Color(0xFFC084FC).withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(
                    color: const Color(0xFFC084FC).withValues(alpha: 0.32),
                  ),
                ),
                child: const Text(
                  'SCENE / SCENEBUILDER',
                  style: TextStyle(
                    color: Color(0xFFE9D5FF),
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
            'EngineLayer — the retained compositor tree of Flutter',
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
            'An `EngineLayer` is an opaque handle into the C++ compositor. '
            'You never construct one directly — instead a `SceneBuilder` '
            'returns one for every `push*` call. The Dart rendering layer '
            'caches those handles on `ContainerLayer` subclasses so the next '
            'frame can pass them back via the `oldLayer:` parameter and '
            'skip rebuilding unchanged subtrees on the GPU side.',
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
                label: 'Scene',
                detail: 'The finished compositor tree handed to the engine.',
                icon: Icons.account_tree_outlined,
              ),
              _HeroPill(
                label: 'SceneBuilder',
                detail: 'Push/pop API that constructs the engine layer tree.',
                icon: Icons.layers_outlined,
              ),
              _HeroPill(
                label: 'EngineLayer',
                detail: 'Opaque handle returned by every push* call.',
                icon: Icons.token_outlined,
              ),
              _HeroPill(
                label: 'oldLayer:',
                detail: 'Reuse parameter — retained-mode incremental updates.',
                icon: Icons.refresh,
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
                  'WHERE ENGINELAYERS LIVE',
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
                  'tree (rendering/Layer) → SceneBuilder push* calls → '
                  'EngineLayer tree (C++ compositor) → Scene → engine submits '
                  'to the GPU thread. Every RepaintBoundary becomes one '
                  'PictureLayer; every ClipPath, Opacity, Transform, etc. '
                  'becomes a ContainerLayer subclass that owns one EngineLayer '
                  'handle. The rendering side is the bookkeeping; the engine '
                  'side is the actual compositor primitive.',
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
              color: const Color(0xFFC084FC).withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 18, color: const Color(0xFFE9D5FF)),
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
// 2. ENGINELAYER CLASS HIERARCHY
// =====================================================================

class _HierarchySection extends StatelessWidget {
  const _HierarchySection();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      tag: 'HIERARCHY · 11 KINDS',
      title: 'The EngineLayer class tree — one root, eleven leaves',
      subtitle:
          '`EngineLayer` is the abstract root marker. Every concrete kind is '
          'returned by a specific `SceneBuilder.push*` call. The leaves are '
          'opaque to Dart; you can only hold them, dispose them, or pass '
          'them back as `oldLayer:` to reuse compositor state on the next '
          'frame.',
      accent: _Palette.purple,
      children: <Widget>[
        Container(
          height: 520,
          decoration: BoxDecoration(
            color: _Palette.paper,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _Palette.line),
          ),
          padding: const EdgeInsets.all(12),
          child: CustomPaint(
            painter: _HierarchyTreePainter(),
            size: Size.infinite,
          ),
        ),
        const SizedBox(height: 16),
        const _Callout(
          title: 'Why "opaque"?',
          body:
              'The concrete classes (ClipPathEngineLayer, OpacityEngineLayer, '
              '…) have no Dart-accessible fields. They are pure compositor '
              'handles — the Dart side only knows the runtime type, never '
              'the internal state. Reuse is by identity, not equality.',
          accent: _Palette.purple,
          icon: Icons.lock_outline,
        ),
      ],
    );
  }
}

class _HierarchyTreePainter extends CustomPainter {
  _HierarchyTreePainter();

  static const List<String> _leaves = <String>[
    'ClipPathEngineLayer',
    'ClipRectEngineLayer',
    'ClipRRectEngineLayer',
    'OpacityEngineLayer',
    'TransformEngineLayer',
    'OffsetEngineLayer',
    'BackdropFilterEngineLayer',
    'ShaderMaskEngineLayer',
    'ColorFilterEngineLayer',
    'ImageFilterEngineLayer',
    'PhysicalShapeEngineLayer',
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = const Color(0xFFFAFAFE);
    canvas.drawRect(Offset.zero & size, bg);

    // Root node
    final Rect root = Rect.fromCenter(
      center: Offset(size.width / 2, 38),
      width: 220,
      height: 44,
    );
    _drawNode(canvas, root, 'EngineLayer (abstract)', _Palette.purple, true);

    // Leaves laid out in 2 columns
    final double yStart = 110;
    final double yStep = 38;
    final double colGap = 16;
    final int rows = (_leaves.length / 2).ceil();
    final double nodeW = (size.width - 32 - colGap) / 2;

    for (int i = 0; i < _leaves.length; i++) {
      final int col = i % 2;
      final int row = i ~/ 2;
      final double x = 16 + col * (nodeW + colGap);
      final double y = yStart + row * yStep;
      final Rect node = Rect.fromLTWH(x, y, nodeW, 30);
      final Color accent = _accentFor(i);
      _drawNode(canvas, node, _leaves[i], accent, false);

      // Arrow from root center bottom to node top
      final Offset start = Offset(root.center.dx, root.bottom);
      final Offset end = Offset(node.center.dx, node.top);
      _drawArrow(canvas, start, end, accent.withValues(alpha: 0.55));
    }

    // Footer text
    final TextPainter footer = TextPainter(
      text: TextSpan(
        text:
            'Eleven concrete leaves. Each corresponds to exactly one '
            'SceneBuilder.push* call.',
        style: TextStyle(
          fontSize: 11,
          color: _Palette.mute,
          fontStyle: FontStyle.italic,
        ),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    footer.layout(maxWidth: size.width - 32);
    footer.paint(canvas, Offset(16, size.height - 22));
  }

  Color _accentFor(int i) {
    const List<Color> palette = <Color>[
      _Palette.rose,
      _Palette.amber,
      _Palette.orange,
      _Palette.emerald,
      _Palette.teal,
      _Palette.cyan,
      _Palette.blue,
      _Palette.indigo,
      _Palette.violet,
      _Palette.fuchsia,
      _Palette.pink,
    ];
    return palette[i % palette.length];
  }

  void _drawNode(
    Canvas canvas,
    Rect rect,
    String label,
    Color accent,
    bool isRoot,
  ) {
    final RRect rrect = RRect.fromRectAndRadius(rect, const Radius.circular(8));
    final Paint fill = Paint()
      ..color = isRoot
          ? accent.withValues(alpha: 0.16)
          : accent.withValues(alpha: 0.08);
    canvas.drawRRect(rrect, fill);
    final Paint stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = isRoot ? 1.6 : 1.0
      ..color = accent.withValues(alpha: isRoot ? 0.7 : 0.5);
    canvas.drawRRect(rrect, stroke);

    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: label,
        style: TextStyle(
          fontSize: isRoot ? 13.5 : 11,
          fontWeight: FontWeight.w800,
          color: accent,
          fontFamily: 'monospace',
        ),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    tp.layout(maxWidth: rect.width - 8);
    tp.paint(
      canvas,
      Offset(
        rect.center.dx - tp.width / 2,
        rect.center.dy - tp.height / 2,
      ),
    );
  }

  void _drawArrow(Canvas canvas, Offset start, Offset end, Color color) {
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..color = color;
    // Curve via control point
    final Path path = Path()
      ..moveTo(start.dx, start.dy)
      ..cubicTo(
        start.dx,
        (start.dy + end.dy) / 2,
        end.dx,
        (start.dy + end.dy) / 2,
        end.dx,
        end.dy,
      );
    canvas.drawPath(path, paint);

    // Arrowhead
    final Paint head = Paint()..color = color;
    final Path arrowHead = Path()
      ..moveTo(end.dx, end.dy)
      ..lineTo(end.dx - 4, end.dy - 6)
      ..lineTo(end.dx + 4, end.dy - 6)
      ..close();
    canvas.drawPath(arrowHead, head);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// =====================================================================
// 3. CLIPPATHENGINELAYER FOCAL DEMO
// =====================================================================

class _ClipPathFocalSection extends StatelessWidget {
  const _ClipPathFocalSection();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      tag: 'CLIPPATHENGINELAYER · FOCAL',
      title: 'Before vs after — how pushClipPath sculpts the layer tree',
      subtitle:
          '`SceneBuilder.pushClipPath(Path path, {Clip clipBehavior, '
          'ClipPathEngineLayer? oldLayer})` adds a clip node above the '
          'subsequent picture/child layers. Anything painted between the '
          'push and the matching pop is intersected with the path.',
      accent: _Palette.rose,
      children: <Widget>[
        _GridLayout(
          columns: 2,
          spacing: 14,
          children: <Widget>[
            _PaintCard(
              title: 'Before pushClipPath',
              subtitle: 'Raw colorful rect painted with no clip layer above.',
              accent: _Palette.rose,
              height: 220,
              painter: _ClipPathBeforePainter(),
              tags: <String>['no clip', 'full rect'],
            ),
            _PaintCard(
              title: 'After pushClipPath(starPath)',
              subtitle:
                  'Same picture, but the engine layer intersects every '
                  'pixel with the star path.',
              accent: _Palette.rose,
              height: 220,
              painter: _ClipPathAfterPainter(),
              tags: <String>['ClipPathEngineLayer', 'antiAlias'],
            ),
          ],
        ),
        const SizedBox(height: 16),
        _PaintCard(
          title: 'How the clip layer wraps the picture',
          subtitle:
              'The clip layer is a transparent node — it adds no pixels '
              'on its own. It declares a path mask, and the child '
              'PictureLayer below it is rasterised through that mask.',
          accent: _Palette.purple,
          height: 240,
          painter: _ClipPathWrapDiagramPainter(),
          tags: <String>['parent: ClipPathEngineLayer', 'child: PictureLayer'],
        ),
        const SizedBox(height: 16),
        const _Callout(
          title: 'Clip vs ClipPath',
          body:
              'pushClipRect → ClipRectEngineLayer (axis-aligned rect). '
              'pushClipRRect → ClipRRectEngineLayer (rect with radii). '
              'pushClipPath → ClipPathEngineLayer (arbitrary path). The '
              'last one is the most expensive because the GPU must '
              'stencil-test against the tessellated path.',
          accent: _Palette.rose,
          icon: Icons.crop_outlined,
        ),
      ],
    );
  }
}

class _ClipPathBeforePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    _drawColorfulBackground(canvas, size);
    // Hint label
    final TextPainter tp = TextPainter(
      text: const TextSpan(
        text: 'NO CLIP — full picture pixels',
        style: TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.2,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(10, 10, tp.width + 12, tp.height + 6),
        const Radius.circular(6),
      ),
      Paint()..color = Colors.black.withValues(alpha: 0.35),
    );
    tp.paint(canvas, const Offset(16, 13));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ClipPathAfterPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // First, build the star path centred on the canvas.
    final Path star = _buildStarPath(size);
    canvas.save();
    canvas.clipPath(star, doAntiAlias: true);
    _drawColorfulBackground(canvas, size);
    canvas.restore();

    // Outline the star to show the clip boundary.
    canvas.drawPath(
      star,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.4
        ..color = _Palette.rose,
    );

    // Hint label
    final TextPainter tp = TextPainter(
      text: const TextSpan(
        text: 'ClipPathEngineLayer (star)',
        style: TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.2,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(10, 10, tp.width + 12, tp.height + 6),
        const Radius.circular(6),
      ),
      Paint()..color = _Palette.rose,
    );
    tp.paint(canvas, const Offset(16, 13));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

void _drawColorfulBackground(Canvas canvas, Size size) {
  // Tile of saturated rectangles.
  const List<Color> tiles = <Color>[
    _Palette.rose,
    _Palette.amber,
    _Palette.emerald,
    _Palette.blue,
    _Palette.violet,
    _Palette.pink,
    _Palette.orange,
    _Palette.cyan,
  ];
  final double cellW = size.width / 4;
  final double cellH = size.height / 2;
  int idx = 0;
  for (int y = 0; y < 2; y++) {
    for (int x = 0; x < 4; x++) {
      final Rect r = Rect.fromLTWH(x * cellW, y * cellH, cellW, cellH);
      canvas.drawRect(r, Paint()..color = tiles[idx % tiles.length]);
      idx++;
    }
  }
  // Diagonal stripe overlay for texture.
  final Paint stripe = Paint()
    ..color = Colors.white.withValues(alpha: 0.12)
    ..strokeWidth = 6
    ..style = PaintingStyle.stroke;
  for (double t = -size.height; t < size.width + size.height; t += 18) {
    canvas.drawLine(
      Offset(t, 0),
      Offset(t + size.height, size.height),
      stripe,
    );
  }
}

Path _buildStarPath(Size size) {
  final Offset c = Offset(size.width / 2, size.height / 2);
  final double rOuter = math.min(size.width, size.height) * 0.42;
  final double rInner = rOuter * 0.46;
  final Path p = Path();
  const int points = 5;
  for (int i = 0; i < points * 2; i++) {
    final double angle = -math.pi / 2 + i * math.pi / points;
    final double r = i.isEven ? rOuter : rInner;
    final Offset pt = c + Offset(math.cos(angle) * r, math.sin(angle) * r);
    if (i == 0) {
      p.moveTo(pt.dx, pt.dy);
    } else {
      p.lineTo(pt.dx, pt.dy);
    }
  }
  p.close();
  return p;
}

class _ClipPathWrapDiagramPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = const Color(0xFFFAF7FF);
    canvas.drawRect(Offset.zero & size, bg);

    // Parent: ClipPathEngineLayer (wide rect, dashed)
    final Rect parent = Rect.fromLTWH(20, 20, size.width - 40, 70);
    _drawDashedBox(canvas, parent, _Palette.rose, 'ClipPathEngineLayer');

    // Inside it: child PictureLayer (smaller)
    final Rect child = Rect.fromLTWH(40, 110, size.width - 80, 70);
    _drawBox(canvas, child, _Palette.blue, 'PictureLayer (the actual pixels)');

    // Arrow parent → child
    final Paint arrow = Paint()
      ..color = _Palette.purple.withValues(alpha: 0.6)
      ..strokeWidth = 1.4
      ..style = PaintingStyle.stroke;
    canvas.drawLine(
      Offset(size.width / 2, parent.bottom),
      Offset(size.width / 2, child.top),
      arrow,
    );

    // Star mask visual on the right
    final Rect maskArea = Rect.fromLTWH(20, 190, size.width - 40, 40);
    final Paint hintBg = Paint()..color = _Palette.rose.withValues(alpha: 0.07);
    canvas.drawRRect(
      RRect.fromRectAndRadius(maskArea, const Radius.circular(8)),
      hintBg,
    );
    final TextPainter hint = TextPainter(
      text: const TextSpan(
        text:
            'The clip layer holds the Path mask. The picture layer below '
            'is rasterised through that mask each frame.',
        style: TextStyle(
          fontSize: 11.5,
          color: _Palette.slate,
          height: 1.4,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    hint.layout(maxWidth: maskArea.width - 16);
    hint.paint(canvas, Offset(maskArea.left + 8, maskArea.top + 6));
  }

  void _drawBox(Canvas canvas, Rect rect, Color color, String label) {
    final RRect rr = RRect.fromRectAndRadius(rect, const Radius.circular(10));
    canvas.drawRRect(
      rr,
      Paint()..color = color.withValues(alpha: 0.1),
    );
    canvas.drawRRect(
      rr,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2
        ..color = color.withValues(alpha: 0.6),
    );
    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w800,
          color: color,
          fontFamily: 'monospace',
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    tp.layout(maxWidth: rect.width - 16);
    tp.paint(
      canvas,
      Offset(rect.center.dx - tp.width / 2, rect.center.dy - tp.height / 2),
    );
  }

  void _drawDashedBox(Canvas canvas, Rect rect, Color color, String label) {
    final Paint dash = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4
      ..color = color.withValues(alpha: 0.7);
    final Path path = Path()
      ..addRRect(RRect.fromRectAndRadius(rect, const Radius.circular(10)));
    _drawDashedPath(canvas, path, dash, 6, 4);

    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(10)),
      Paint()..color = color.withValues(alpha: 0.06),
    );

    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w800,
          color: color,
          fontFamily: 'monospace',
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    tp.layout(maxWidth: rect.width - 16);
    tp.paint(
      canvas,
      Offset(rect.center.dx - tp.width / 2, rect.center.dy - tp.height / 2),
    );
  }

  void _drawDashedPath(
    Canvas canvas,
    Path source,
    Paint paint,
    double on,
    double off,
  ) {
    for (final ui.PathMetric m in source.computeMetrics()) {
      double dist = 0;
      while (dist < m.length) {
        final double next = math.min(dist + on, m.length);
        canvas.drawPath(m.extractPath(dist, next), paint);
        dist = next + off;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// =====================================================================
// 4. SCENEBUILDER PSEUDO-CODE WALKTHROUGH
// =====================================================================

class _SceneBuilderWalkthroughSection extends StatelessWidget {
  const _SceneBuilderWalkthroughSection();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      tag: 'SCENEBUILDER · STEP BY STEP',
      title: 'Push, paint, pop, build — the four-beat rhythm of every frame',
      subtitle:
          '`SceneBuilder` is a tiny push/pop API. Each `push*` returns an '
          '`EngineLayer`; each must be balanced by a `pop()`. Between push '
          'and pop you can `addPicture`, `addPlatformView`, `addRetained`, '
          'or recursively push more layers. `build()` finalises the tree.',
      accent: _Palette.indigo,
      children: <Widget>[
        const _CodeBlock(
          caption: 'pseudo · pushClipPath + addPicture + pop + build',
          code: 'final SceneBuilder builder = SceneBuilder();\n'
              '\n'
              '// 1. Push a clip layer. Returns a ClipPathEngineLayer.\n'
              'final ClipPathEngineLayer clip = builder.pushClipPath(\n'
              '  starPath,                       // the Path mask\n'
              '  clipBehavior: Clip.antiAlias,   // edge quality\n'
              ')!;\n'
              '\n'
              '// 2. Add the actual pixels. PictureRecorder → Picture.\n'
              'builder.addPicture(Offset.zero, picture);\n'
              '\n'
              '// 3. Pop the clip layer. Push/pop must balance.\n'
              'builder.pop();\n'
              '\n'
              '// 4. Finalise — returns a Scene handle.\n'
              'final Scene scene = builder.build();\n'
              '\n'
              '// 5. Hand it to the engine, then dispose.\n'
              'window.render(scene);\n'
              'scene.dispose();',
        ),
        const SizedBox(height: 14),
        _GridLayout(
          columns: 2,
          spacing: 14,
          children: const <Widget>[
            _Callout(
              title: '① push returns a handle',
              body:
                  'pushClipPath, pushOpacity, pushTransform, … each return '
                  'a concrete EngineLayer subtype. Keep that handle if you '
                  'plan to reuse the layer next frame.',
              accent: _Palette.rose,
              icon: Icons.upload_outlined,
            ),
            _Callout(
              title: '② addPicture appends pixels',
              body:
                  'addPicture(offset, picture) pushes a PictureLayer below '
                  'the currently-open container. Pictures are the only '
                  'source of actual rasterised content.',
              accent: _Palette.emerald,
              icon: Icons.image_outlined,
            ),
            _Callout(
              title: '③ pop closes the container',
              body:
                  'Every push must be matched with a pop. Mismatched '
                  'push/pop is a frame-time assertion in debug builds and '
                  'a visual disaster in release.',
              accent: _Palette.amber,
              icon: Icons.download_outlined,
            ),
            _Callout(
              title: '④ build returns a Scene',
              body:
                  'build() is one-shot — the SceneBuilder is consumed. Pass '
                  'the Scene to FlutterView.render and dispose it. The '
                  'engine takes ownership of the tree.',
              accent: _Palette.indigo,
              icon: Icons.account_tree_outlined,
            ),
          ],
        ),
      ],
    );
  }
}

// =====================================================================
// 5. LAYER REUSE STORY
// =====================================================================

class _LayerReuseSection extends StatelessWidget {
  const _LayerReuseSection();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      tag: 'OLDLAYER · RETAINED MODE',
      title: 'pushClipPath(oldLayer: previous) — frame-to-frame reuse',
      subtitle:
          'Every push* call accepts an optional oldLayer of the matching '
          'concrete type. Passing it back lets the compositor keep its '
          'cached state (tessellated path, GPU texture, blur kernel) and '
          'merely update what changed.',
      accent: _Palette.teal,
      children: <Widget>[
        Container(
          height: 280,
          decoration: BoxDecoration(
            color: _Palette.paper,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _Palette.line),
          ),
          padding: const EdgeInsets.all(12),
          child: CustomPaint(
            painter: _LayerReuseDiagramPainter(),
            size: Size.infinite,
          ),
        ),
        const SizedBox(height: 16),
        const _CodeBlock(
          caption: 'frame N+1 — reusing the clip layer',
          code: '// In a Layer subclass\'s addToScene:\n'
              'ClipPathEngineLayer? _engineLayer;\n'
              '\n'
              '@override\n'
              'void addToScene(SceneBuilder builder) {\n'
              '  _engineLayer = builder.pushClipPath(\n'
              '    clipPath,\n'
              '    clipBehavior: clipBehavior,\n'
              '    oldLayer: _engineLayer, // ← reuse\n'
              '  );\n'
              '  addChildrenToScene(builder);\n'
              '  builder.pop();\n'
              '}',
        ),
        const SizedBox(height: 14),
        const _GridLayout(
          columns: 2,
          spacing: 14,
          children: <Widget>[
            _Bullet(
              text:
                  'Without oldLayer: the compositor rebuilds the layer node '
                  'from scratch — fresh allocation, fresh tessellation, '
                  'fresh GPU upload.',
              color: _Palette.rose,
            ),
            _Bullet(
              text:
                  'With oldLayer: the compositor mutates the existing node '
                  'in place. Cached path geometry and texture atlases are '
                  'preserved.',
              color: _Palette.emerald,
            ),
            _Bullet(
              text:
                  'The Layer class tracks the engine handle in '
                  '`_engineLayer`. ContainerLayer.updateSubtreeNeedsAddToScene '
                  'flags reuse eligibility.',
              color: _Palette.blue,
            ),
            _Bullet(
              text:
                  'Type matters: passing an OpacityEngineLayer to '
                  'pushClipPath asserts. The static type of oldLayer must '
                  'match the push call exactly.',
              color: _Palette.amber,
            ),
          ],
        ),
      ],
    );
  }
}

class _LayerReuseDiagramPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = const Color(0xFFF6FBF9);
    canvas.drawRect(Offset.zero & size, bg);

    final double frameW = (size.width - 60) / 3;
    final double frameH = size.height - 70;
    for (int i = 0; i < 3; i++) {
      final double x = 20 + i * (frameW + 10);
      final Rect frame = Rect.fromLTWH(x, 40, frameW, frameH);
      _drawFrame(canvas, frame, i);
      // Frame label
      final TextPainter t = TextPainter(
        text: TextSpan(
          text: 'FRAME ${i + 1}',
          style: TextStyle(
            color: _Palette.slate,
            fontSize: 11,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.2,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      t.layout();
      t.paint(canvas, Offset(x, 18));
    }

    // Arrows between frames
    final Paint arrow = Paint()
      ..color = _Palette.teal.withValues(alpha: 0.55)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;
    for (int i = 0; i < 2; i++) {
      final double x = 20 + (i + 1) * frameW + i * 10 - 5;
      canvas.drawLine(
        Offset(x, size.height / 2),
        Offset(x + 10, size.height / 2),
        arrow,
      );
      // arrowhead
      final Path head = Path()
        ..moveTo(x + 10, size.height / 2)
        ..lineTo(x + 6, size.height / 2 - 3)
        ..lineTo(x + 6, size.height / 2 + 3)
        ..close();
      canvas.drawPath(head, Paint()..color = _Palette.teal);
    }

    // Footer caption
    final TextPainter footer = TextPainter(
      text: const TextSpan(
        text:
            'The same ClipPathEngineLayer handle is threaded through every '
            'frame. The compositor never frees the GPU resources.',
        style: TextStyle(
          fontSize: 11,
          color: _Palette.mute,
          fontStyle: FontStyle.italic,
        ),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    footer.layout(maxWidth: size.width - 32);
    footer.paint(
      canvas,
      Offset((size.width - footer.width) / 2, size.height - 22),
    );
  }

  void _drawFrame(Canvas canvas, Rect frame, int idx) {
    canvas.drawRRect(
      RRect.fromRectAndRadius(frame, const Radius.circular(10)),
      Paint()..color = Colors.white,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(frame, const Radius.circular(10)),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0
        ..color = _Palette.line,
    );

    // Inside: parent node and child node
    final Rect parent = Rect.fromLTWH(
      frame.left + 8,
      frame.top + 14,
      frame.width - 16,
      30,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(parent, const Radius.circular(6)),
      Paint()..color = _Palette.teal.withValues(alpha: 0.12),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(parent, const Radius.circular(6)),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0
        ..color = _Palette.teal.withValues(alpha: 0.6),
    );
    final TextPainter pt = TextPainter(
      text: TextSpan(
        text: idx == 0
            ? 'pushClipPath()'
            : 'pushClipPath(oldLayer:)',
        style: TextStyle(
          color: _Palette.teal,
          fontSize: 10,
          fontWeight: FontWeight.w800,
          fontFamily: 'monospace',
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    pt.layout(maxWidth: parent.width - 6);
    pt.paint(
      canvas,
      Offset(parent.center.dx - pt.width / 2, parent.center.dy - pt.height / 2),
    );

    final Rect child = Rect.fromLTWH(
      frame.left + 24,
      frame.top + 60,
      frame.width - 48,
      30,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(child, const Radius.circular(6)),
      Paint()..color = _Palette.blue.withValues(alpha: 0.1),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(child, const Radius.circular(6)),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0
        ..color = _Palette.blue.withValues(alpha: 0.6),
    );
    final TextPainter ct = TextPainter(
      text: TextSpan(
        text: 'PictureLayer',
        style: TextStyle(
          color: _Palette.blue,
          fontSize: 10,
          fontWeight: FontWeight.w800,
          fontFamily: 'monospace',
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    ct.layout();
    ct.paint(
      canvas,
      Offset(child.center.dx - ct.width / 2, child.center.dy - ct.height / 2),
    );

    // Connector
    canvas.drawLine(
      Offset(parent.center.dx, parent.bottom),
      Offset(child.center.dx, child.top),
      Paint()
        ..color = _Palette.mute.withValues(alpha: 0.6)
        ..strokeWidth = 1.0,
    );

    // Tag bottom: cached / reused
    final TextPainter tag = TextPainter(
      text: TextSpan(
        text: idx == 0 ? 'NEW HANDLE' : 'REUSED HANDLE',
        style: TextStyle(
          color: idx == 0 ? _Palette.amber : _Palette.emerald,
          fontSize: 10,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.0,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    tag.layout();
    tag.paint(
      canvas,
      Offset(
        frame.center.dx - tag.width / 2,
        frame.bottom - tag.height - 6,
      ),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// =====================================================================
// 6. SIX LAYER-TYPE CARDS
// =====================================================================

class _LayerTypeCardsSection extends StatelessWidget {
  const _LayerTypeCardsSection();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      tag: 'EFFECTS · 8 CARDS',
      title: 'What each EngineLayer actually does to pixels',
      subtitle:
          'Eight cards, eight engine layer kinds. Each one paints the '
          'effect that the compositor primitive produces — clip, opacity, '
          'transform, offset, backdrop blur, shader mask, color filter, '
          'image filter.',
      accent: _Palette.violet,
      children: <Widget>[
        _GridLayout(
          columns: 2,
          spacing: 14,
          children: <Widget>[
            _PaintCard(
              title: 'ClipRectEngineLayer',
              subtitle: 'Axis-aligned rect mask. The cheapest clip kind.',
              accent: _Palette.rose,
              painter: _ClipRectEffectPainter(),
              tags: <String>['pushClipRect', 'Clip.hardEdge'],
            ),
            _PaintCard(
              title: 'ClipRRectEngineLayer',
              subtitle:
                  'Rounded-rect mask. Common path for Material cards.',
              accent: _Palette.orange,
              painter: _ClipRRectEffectPainter(),
              tags: <String>['pushClipRRect', 'antiAlias'],
            ),
            _PaintCard(
              title: 'OpacityEngineLayer',
              subtitle:
                  'Alpha-multiplies the whole subtree. Implies saveLayer.',
              accent: _Palette.amber,
              painter: _OpacityEffectPainter(),
              tags: <String>['pushOpacity', 'alpha 0..255'],
            ),
            _PaintCard(
              title: 'TransformEngineLayer',
              subtitle:
                  '4×4 matrix applied to children. Includes 3D perspective.',
              accent: _Palette.emerald,
              painter: _TransformEffectPainter(),
              tags: <String>['pushTransform', 'Float64List(16)'],
            ),
            _PaintCard(
              title: 'OffsetEngineLayer',
              subtitle:
                  'Special-case 2D translation — faster than a full matrix.',
              accent: _Palette.teal,
              painter: _OffsetEffectPainter(),
              tags: <String>['pushOffset', 'dx,dy'],
            ),
            _PaintCard(
              title: 'BackdropFilterEngineLayer',
              subtitle:
                  'Reads what is already painted below and filters it. '
                  'Expensive — needs an offscreen.',
              accent: _Palette.cyan,
              painter: _BackdropFilterEffectPainter(),
              tags: <String>['pushBackdropFilter', 'ImageFilter.blur'],
            ),
            _PaintCard(
              title: 'ShaderMaskEngineLayer',
              subtitle:
                  'Multiplies child pixels by a Shader (gradient/image).',
              accent: _Palette.violet,
              painter: _ShaderMaskEffectPainter(),
              tags: <String>['pushShaderMask', 'BlendMode.modulate'],
            ),
            _PaintCard(
              title: 'ColorFilterEngineLayer',
              subtitle:
                  'Per-pixel color transform applied to the subtree.',
              accent: _Palette.fuchsia,
              painter: _ColorFilterEffectPainter(),
              tags: <String>['pushColorFilter', 'matrix / mode'],
            ),
          ],
        ),
        const SizedBox(height: 16),
        _PaintCard(
          title: 'ImageFilterEngineLayer',
          subtitle:
              'Applies an ImageFilter (blur, dilate, matrix) to the child '
              'subtree as it is rasterised.',
          accent: _Palette.pink,
          painter: _ImageFilterEffectPainter(),
          height: 200,
          tags: <String>[
            'pushImageFilter',
            'ImageFilter.blur',
            'ImageFilter.matrix',
          ],
        ),
      ],
    );
  }
}

class _ClipRectEffectPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    _drawColorfulBackground(canvas, size);
    final Rect clip = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: size.width * 0.7,
      height: size.height * 0.6,
    );
    canvas.save();
    canvas.clipRect(clip);
    canvas.drawRect(
      Offset.zero & size,
      Paint()..color = Colors.black.withValues(alpha: 0.35),
    );
    canvas.restore();
    // mask boundary highlight
    canvas.drawRect(
      clip,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.4
        ..color = _Palette.rose,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ClipRRectEffectPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    _drawColorfulBackground(canvas, size);
    final RRect rr = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(size.width / 2, size.height / 2),
        width: size.width * 0.75,
        height: size.height * 0.65,
      ),
      const Radius.circular(28),
    );
    canvas.save();
    canvas.clipRRect(rr, doAntiAlias: true);
    canvas.drawRect(
      Offset.zero & size,
      Paint()..color = Colors.black.withValues(alpha: 0.35),
    );
    canvas.restore();
    canvas.drawRRect(
      rr,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.4
        ..color = _Palette.orange,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _OpacityEffectPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = const Color(0xFFFAFAFE);
    canvas.drawRect(Offset.zero & size, bg);
    // Three discs, each with progressively lower alpha.
    final List<double> alphas = <double>[1.0, 0.65, 0.3];
    for (int i = 0; i < 3; i++) {
      final double cx = size.width * (0.22 + 0.28 * i);
      final double cy = size.height / 2;
      final Paint disc = Paint()
        ..color = _Palette.amber.withValues(alpha: alphas[i]);
      canvas.drawCircle(Offset(cx, cy), size.height * 0.28, disc);
      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: 'α${(alphas[i] * 255).round()}',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11,
            fontWeight: FontWeight.w800,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      tp.layout();
      tp.paint(canvas, Offset(cx - tp.width / 2, cy - tp.height / 2));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _TransformEffectPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = const Color(0xFFF4FBF6);
    canvas.drawRect(Offset.zero & size, bg);
    // Three rects: identity, rotated, perspective-skewed.
    final double w = size.width / 3.5;
    final double h = size.height * 0.55;
    final List<Matrix4> ms = <Matrix4>[
      Matrix4.identity()..translate(size.width * 0.08, size.height * 0.22),
      Matrix4.identity()
        ..translate(size.width * 0.41, size.height * 0.22 + h / 2)
        ..rotateZ(0.4)
        ..translate(-w / 2, -h / 2),
      Matrix4.identity()
        ..translate(size.width * 0.7, size.height * 0.22)
        ..setEntry(3, 2, 0.0015)
        ..rotateY(0.6),
    ];
    for (int i = 0; i < ms.length; i++) {
      canvas.save();
      canvas.transform(ms[i].storage);
      final Paint p = Paint()..color = _Palette.emerald.withValues(alpha: 0.7);
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, w, h),
          const Radius.circular(8),
        ),
        p,
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _OffsetEffectPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = const Color(0xFFF1FBFB);
    canvas.drawRect(Offset.zero & size, bg);
    // Original vs offset duplicates.
    final Paint orig = Paint()..color = _Palette.teal.withValues(alpha: 0.35);
    final Paint shifted = Paint()..color = _Palette.teal;
    final Rect r = Rect.fromLTWH(
      size.width * 0.12,
      size.height * 0.22,
      size.width * 0.4,
      size.height * 0.5,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(r, const Radius.circular(8)),
      orig,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(r.shift(const Offset(30, 18)),
          const Radius.circular(8)),
      shifted,
    );
    // arrow showing the shift
    final Paint arrow = Paint()
      ..color = _Palette.slate
      ..strokeWidth = 1.4
      ..style = PaintingStyle.stroke;
    canvas.drawLine(
      Offset(r.right, r.bottom),
      Offset(r.right + 30, r.bottom + 18),
      arrow,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _BackdropFilterEffectPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    _drawColorfulBackground(canvas, size);
    final Rect frosted = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: size.width * 0.65,
      height: size.height * 0.5,
    );
    canvas.saveLayer(
      frosted,
      Paint()..imageFilter = ui.ImageFilter.blur(sigmaX: 8, sigmaY: 8),
    );
    canvas.drawRect(
      frosted,
      Paint()..color = Colors.white.withValues(alpha: 0.001),
    );
    canvas.restore();
    canvas.drawRRect(
      RRect.fromRectAndRadius(frosted, const Radius.circular(12)),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.4
        ..color = _Palette.cyan,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ShaderMaskEffectPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = const Color(0xFFFAF5FF);
    canvas.drawRect(Offset.zero & size, bg);
    // Render text-like bars masked by a horizontal gradient.
    final Shader shader = ui.Gradient.linear(
      Offset(0, size.height / 2),
      Offset(size.width, size.height / 2),
      <Color>[_Palette.violet, _Palette.pink, _Palette.amber],
      <double>[0.0, 0.5, 1.0],
    );
    canvas.saveLayer(Offset.zero & size, Paint());
    final Paint bar = Paint()..color = Colors.black;
    for (int i = 0; i < 4; i++) {
      final double y = 24.0 + i * 28;
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(20, y, size.width - 40 - i * 10, 14),
          const Radius.circular(4),
        ),
        bar,
      );
    }
    final Paint mask = Paint()
      ..shader = shader
      ..blendMode = BlendMode.srcIn;
    canvas.drawRect(Offset.zero & size, mask);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ColorFilterEffectPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    _drawColorfulBackground(canvas, size);
    canvas.saveLayer(
      Offset.zero & size,
      Paint()
        ..colorFilter = const ColorFilter.matrix(<double>[
          0.2126, 0.7152, 0.0722, 0, 0,
          0.2126, 0.7152, 0.0722, 0, 0,
          0.2126, 0.7152, 0.0722, 0, 0,
          0, 0, 0, 1, 0,
        ]),
    );
    canvas.drawRect(
      Offset.zero & size,
      Paint()..color = Colors.white.withValues(alpha: 0.001),
    );
    canvas.restore();
    final TextPainter tp = TextPainter(
      text: const TextSpan(
        text: 'GRAYSCALE COLOR MATRIX',
        style: TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.4,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(10, 10, tp.width + 12, tp.height + 6),
        const Radius.circular(6),
      ),
      Paint()..color = _Palette.fuchsia,
    );
    tp.paint(canvas, const Offset(16, 13));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ImageFilterEffectPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = const Color(0xFFFFF0F5);
    canvas.drawRect(Offset.zero & size, bg);
    // Left half: sharp text; right half: blurred via ImageFilter.
    final Rect left = Rect.fromLTWH(0, 0, size.width / 2, size.height);
    final Rect right = Rect.fromLTWH(size.width / 2, 0, size.width / 2, size.height);

    void paintSwatch(Rect r) {
      for (int i = 0; i < 3; i++) {
        canvas.drawCircle(
          Offset(r.left + r.width * (0.3 + 0.2 * i), r.center.dy),
          18,
          Paint()..color = _Palette.pink.withValues(alpha: 0.7 - i * 0.18),
        );
      }
    }

    paintSwatch(left);
    canvas.saveLayer(
      right,
      Paint()..imageFilter = ui.ImageFilter.blur(sigmaX: 6, sigmaY: 6),
    );
    paintSwatch(right);
    canvas.restore();

    // dividing line
    canvas.drawLine(
      Offset(size.width / 2, 0),
      Offset(size.width / 2, size.height),
      Paint()
        ..color = _Palette.line
        ..strokeWidth = 1.0,
    );
    final TextPainter a = TextPainter(
      text: const TextSpan(
        text: 'NO FILTER',
        style: TextStyle(
          color: _Palette.slate,
          fontSize: 10,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.4,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    a.layout();
    a.paint(canvas, Offset(left.center.dx - a.width / 2, 8));
    final TextPainter b = TextPainter(
      text: const TextSpan(
        text: 'ImageFilter.blur',
        style: TextStyle(
          color: _Palette.pink,
          fontSize: 10,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.4,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    b.layout();
    b.paint(canvas, Offset(right.center.dx - b.width / 2, 8));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// =====================================================================
// 7. RENDER PIPELINE TIMELINE
// =====================================================================

class _RenderPipelineTimelineSection extends StatelessWidget {
  const _RenderPipelineTimelineSection();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      tag: 'PIPELINE · WHERE LAYERS LIVE',
      title: 'build → layout → paint → composite → engine → GPU',
      subtitle:
          'A frame is six clearly-bounded phases. EngineLayers materialise '
          'in the composite phase, when Layer.addToScene calls into '
          'SceneBuilder. The GPU only sees the finished Scene.',
      accent: _Palette.blue,
      children: <Widget>[
        Container(
          height: 320,
          decoration: BoxDecoration(
            color: _Palette.paper,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _Palette.line),
          ),
          padding: const EdgeInsets.all(12),
          child: CustomPaint(
            painter: _PipelineTimelinePainter(),
            size: Size.infinite,
          ),
        ),
        const SizedBox(height: 16),
        const _GridLayout(
          columns: 2,
          spacing: 14,
          children: <Widget>[
            _Bullet(
              text:
                  'BUILD: widget tree reconciles. No engine layers exist yet '
                  '— only Element wiring.',
              color: _Palette.amber,
            ),
            _Bullet(
              text:
                  'LAYOUT: RenderObject tree computes sizes and positions. '
                  'Still no engine layers.',
              color: _Palette.orange,
            ),
            _Bullet(
              text:
                  'PAINT: RenderObjects produce Layer tree (Dart-side). '
                  'PictureLayers record canvas ops into Pictures.',
              color: _Palette.emerald,
            ),
            _Bullet(
              text:
                  'COMPOSITE: Layer.addToScene walks the tree, calls '
                  'SceneBuilder.push* — *this is where EngineLayers are born*.',
              color: _Palette.blue,
            ),
            _Bullet(
              text:
                  'FLUSH: SceneBuilder.build() returns a Scene; '
                  'FlutterView.render hands it to the GPU thread.',
              color: _Palette.indigo,
            ),
            _Bullet(
              text:
                  'RASTERISE: GPU thread walks the EngineLayer tree and '
                  'turns it into draw calls (Skia / Impeller).',
              color: _Palette.purple,
            ),
          ],
        ),
      ],
    );
  }
}

class _PipelineTimelinePainter extends CustomPainter {
  static const List<String> _phases = <String>[
    'BUILD',
    'LAYOUT',
    'PAINT',
    'COMPOSITE',
    'FLUSH',
    'RASTERISE',
  ];

  static const List<Color> _colors = <Color>[
    _Palette.amber,
    _Palette.orange,
    _Palette.emerald,
    _Palette.blue,
    _Palette.indigo,
    _Palette.purple,
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = const Color(0xFFFAFBFF);
    canvas.drawRect(Offset.zero & size, bg);

    final double margin = 14;
    final double trackY = 80;
    final double trackH = 56;
    final double trackW = size.width - margin * 2;
    final double phaseW = trackW / _phases.length;

    // Phase boxes
    for (int i = 0; i < _phases.length; i++) {
      final Rect r = Rect.fromLTWH(
        margin + i * phaseW + 4,
        trackY,
        phaseW - 8,
        trackH,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(r, const Radius.circular(8)),
        Paint()..color = _colors[i].withValues(alpha: 0.16),
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(r, const Radius.circular(8)),
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.2
          ..color = _colors[i].withValues(alpha: 0.65),
      );
      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: _phases[i],
          style: TextStyle(
            color: _colors[i],
            fontSize: 11,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.0,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      tp.layout(maxWidth: r.width - 6);
      tp.paint(
        canvas,
        Offset(r.center.dx - tp.width / 2, r.center.dy - tp.height / 2 - 6),
      );

      // Sub label
      final TextPainter sub = TextPainter(
        text: TextSpan(
          text: _subLabel(i),
          style: TextStyle(
            color: _colors[i].withValues(alpha: 0.8),
            fontSize: 9,
            fontWeight: FontWeight.w700,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      sub.layout(maxWidth: r.width - 6);
      sub.paint(
        canvas,
        Offset(r.center.dx - sub.width / 2, r.center.dy + 4),
      );
    }

    // Marker above COMPOSITE
    final double markerX = margin + 3 * phaseW + phaseW / 2;
    final Paint marker = Paint()..color = _Palette.blue;
    canvas.drawCircle(Offset(markerX, trackY - 14), 6, marker);
    final TextPainter mk = TextPainter(
      text: const TextSpan(
        text: '★ EngineLayers materialise here',
        style: TextStyle(
          color: _Palette.blue,
          fontSize: 11,
          fontWeight: FontWeight.w800,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    mk.layout();
    mk.paint(canvas, Offset(markerX - mk.width / 2, trackY - 36));

    // Pipeline arrow connecting boxes
    final Paint arr = Paint()
      ..color = _Palette.mute.withValues(alpha: 0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;
    canvas.drawLine(
      Offset(margin, trackY + trackH + 18),
      Offset(margin + trackW, trackY + trackH + 18),
      arr,
    );
    for (int i = 1; i < _phases.length; i++) {
      final double x = margin + i * phaseW;
      canvas.drawLine(
        Offset(x, trackY + trackH + 14),
        Offset(x, trackY + trackH + 22),
        arr,
      );
    }

    // Bottom legend explaining layer tree handoff
    final Rect legend = Rect.fromLTWH(
      margin,
      size.height - 100,
      size.width - margin * 2,
      80,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(legend, const Radius.circular(10)),
      Paint()..color = _Palette.blue.withValues(alpha: 0.06),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(legend, const Radius.circular(10)),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0
        ..color = _Palette.blue.withValues(alpha: 0.3),
    );
    final TextPainter legendTp = TextPainter(
      text: TextSpan(
        children: <TextSpan>[
          const TextSpan(
            text: 'Layer (Dart) → SceneBuilder.push* → ',
            style: TextStyle(
              color: _Palette.slate,
              fontSize: 12,
              height: 1.5,
            ),
          ),
          TextSpan(
            text: 'EngineLayer (compositor)',
            style: TextStyle(
              color: _Palette.blue,
              fontSize: 12,
              fontWeight: FontWeight.w800,
              height: 1.5,
            ),
          ),
          const TextSpan(
            text:
                ' → Scene → FlutterView.render → GPU. The Dart side hands '
                'off ownership of the EngineLayer tree to native; '
                'subsequent frames may reuse the same handles.',
            style: TextStyle(
              color: _Palette.slate,
              fontSize: 12,
              height: 1.5,
            ),
          ),
        ],
      ),
      textDirection: TextDirection.ltr,
    );
    legendTp.layout(maxWidth: legend.width - 18);
    legendTp.paint(
      canvas,
      Offset(legend.left + 10, legend.top + 10),
    );

    // Top title
    final TextPainter title = TextPainter(
      text: const TextSpan(
        text: 'A FRAME, PHASE BY PHASE',
        style: TextStyle(
          color: _Palette.ink,
          fontSize: 12,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.6,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    title.layout();
    title.paint(canvas, Offset(margin, 14));
  }

  String _subLabel(int i) {
    switch (i) {
      case 0:
        return 'Widget reconcile';
      case 1:
        return 'Size · position';
      case 2:
        return 'PictureRecorder';
      case 3:
        return 'addToScene';
      case 4:
        return 'render(Scene)';
      case 5:
        return 'Skia / Impeller';
    }
    return '';
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// =====================================================================
// 8. COMPARISON TABLE
// =====================================================================

class _ComparisonTableSection extends StatelessWidget {
  const _ComparisonTableSection();

  static const List<List<String>> _rows = <List<String>>[
    <String>['ContainerLayer', '—', 'Abstract parent on the Dart side.'],
    <String>['PictureLayer', '—', 'Holds a recorded ui.Picture; no engine layer.'],
    <String>['ClipPathLayer', 'ClipPathEngineLayer', 'pushClipPath.'],
    <String>['ClipRectLayer', 'ClipRectEngineLayer', 'pushClipRect.'],
    <String>['ClipRRectLayer', 'ClipRRectEngineLayer', 'pushClipRRect.'],
    <String>['OpacityLayer', 'OpacityEngineLayer', 'pushOpacity.'],
    <String>['TransformLayer', 'TransformEngineLayer', 'pushTransform (Float64List).'],
    <String>['OffsetLayer', 'OffsetEngineLayer', 'pushOffset (dx, dy).'],
    <String>['BackdropFilterLayer', 'BackdropFilterEngineLayer', 'pushBackdropFilter.'],
    <String>['ShaderMaskLayer', 'ShaderMaskEngineLayer', 'pushShaderMask.'],
    <String>['ColorFilterLayer', 'ColorFilterEngineLayer', 'pushColorFilter.'],
    <String>['ImageFilterLayer', 'ImageFilterEngineLayer', 'pushImageFilter.'],
    <String>['PhysicalModelLayer', 'PhysicalShapeEngineLayer', 'pushPhysicalShape.'],
    <String>['AnnotatedRegionLayer', '—', 'Hit-test metadata; no engine layer.'],
    <String>['LeaderLayer / FollowerLayer', '—', 'CompositedTransformTarget plumbing.'],
  ];

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      tag: 'COMPARISON · DART vs ENGINE',
      title: 'rendering/Layer subclasses vs dart:ui EngineLayer cousins',
      subtitle:
          'The flutter/rendering library wraps each engine layer with a '
          'higher-level Layer subclass that owns the handle and integrates '
          'with the rest of the framework (debug, diagnostics, hit-tests).',
      accent: _Palette.sky,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: _Palette.paper,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: _Palette.line),
          ),
          child: Column(
            children: <Widget>[
              const _ComparisonRow(
                left: 'rendering/Layer',
                middle: 'dart:ui EngineLayer',
                right: 'SceneBuilder call',
                isHeader: true,
              ),
              for (final List<String> row in _rows)
                _ComparisonRow(
                  left: row[0],
                  middle: row[1],
                  right: row[2],
                ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const _Callout(
          title: 'PictureLayer has no EngineLayer',
          body:
              'PictureLayer.addToScene calls addPicture, not push/pop. The '
              'engine layer family is exclusively for *container* nodes that '
              'wrap children. Leaves (pictures, platform views, performance '
              'overlays) are added with add* methods.',
          accent: _Palette.sky,
          icon: Icons.info_outline,
        ),
      ],
    );
  }
}

class _ComparisonRow extends StatelessWidget {
  const _ComparisonRow({
    required this.left,
    required this.middle,
    required this.right,
    this.isHeader = false,
  });

  final String left;
  final String middle;
  final String right;
  final bool isHeader;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isHeader ? _Palette.sky.withValues(alpha: 0.1) : null,
        border: Border(bottom: BorderSide(color: _Palette.line)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Text(
              left,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isHeader ? FontWeight.w800 : FontWeight.w700,
                color: isHeader ? _Palette.sky : _Palette.ink,
                fontFamily: 'monospace',
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              middle,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isHeader ? FontWeight.w800 : FontWeight.w700,
                color: isHeader
                    ? _Palette.sky
                    : (middle == '—' ? _Palette.mute : _Palette.purple),
                fontFamily: 'monospace',
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              right,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isHeader ? FontWeight.w800 : FontWeight.w500,
                color: isHeader ? _Palette.sky : _Palette.slate,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// 9. PITFALLS
// =====================================================================

class _PitfallsSection extends StatelessWidget {
  const _PitfallsSection();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      tag: 'PITFALLS · SIX TO AVOID',
      title: 'Six ways engine layers go wrong',
      subtitle:
          'These bugs rarely throw — they manifest as silent visual '
          'glitches, dropped frames, or memory creep. Catching them needs '
          'familiarity with the push/pop model and the oldLayer contract.',
      accent: _Palette.rose,
      children: const <Widget>[
        _Callout(
          title: 'Leaked engine layer reference',
          body:
              'Holding a non-null EngineLayer field on a disposed Layer '
              'keeps the GPU side alive. Always null out _engineLayer on '
              'dispose, or use dispose() pattern so the Skia handle is '
              'released.',
          accent: _Palette.rose,
          icon: Icons.memory_outlined,
        ),
        SizedBox(height: 12),
        _Callout(
          title: 'Mismatched push / pop',
          body:
              'Every pushClipPath, pushOpacity, pushTransform must be '
              'balanced with exactly one pop(). One extra push silently '
              'leaks a container open; one extra pop asserts in debug.',
          accent: _Palette.orange,
          icon: Icons.compare_arrows_outlined,
        ),
        SizedBox(height: 12),
        _Callout(
          title: 'oldLayer reuse with mutated clip rect',
          body:
              'Passing an oldLayer with the wrong path/rect is the engine '
              '"believing" you when you shouldn\'t be trusted. The compositor '
              'updates its mask, but cached tessellation may be wrong for '
              'one frame and you see a clip flash.',
          accent: _Palette.amber,
          icon: Icons.refresh_outlined,
        ),
        SizedBox(height: 12),
        _Callout(
          title: 'BackdropFilter inside an Opacity',
          body:
              'BackdropFilter samples the surface beneath it. If the closest '
              'ancestor saveLayer (OpacityEngineLayer) is opaque, the filter '
              'reads black — and the user sees a black smudge. Move the '
              'backdrop above the opacity or use Opacity\'s alwaysIncludeSemantics '
              'workaround.',
          accent: _Palette.emerald,
          icon: Icons.layers_clear_outlined,
        ),
        SizedBox(height: 12),
        _Callout(
          title: 'ShaderMask vs ColorFilter cost mismatch',
          body:
              'ShaderMaskEngineLayer needs an offscreen — it is one full '
              'saveLayer. ColorFilterEngineLayer can fold into the parent '
              'paint. Reach for ColorFilter when a per-pixel transform '
              'suffices; reserve ShaderMask for gradients or texture masks.',
          accent: _Palette.blue,
          icon: Icons.gradient_outlined,
        ),
        SizedBox(height: 12),
        _Callout(
          title: 'ImageFilter.blur on every frame',
          body:
              'Blurs are the single most expensive primitive in the engine. '
              'Each frame retessellates a Gaussian kernel. If the input is '
              'static, cache the blurred result in a RepaintBoundary so the '
              'kernel only runs once.',
          accent: _Palette.violet,
          icon: Icons.speed_outlined,
        ),
      ],
    );
  }
}

// =====================================================================
// 10. CODE IDIOMS
// =====================================================================

class _CodeIdiomsSection extends StatelessWidget {
  const _CodeIdiomsSection();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      tag: 'IDIOMS · SIX SNIPPETS',
      title: 'The six push* calls you will use most',
      subtitle:
          'Each push* call returns its own concrete EngineLayer subtype. '
          'Pair every push with exactly one pop, and thread oldLayer for '
          'reuse. The patterns below are the canonical Flutter framework '
          'idioms.',
      accent: _Palette.indigo,
      children: <Widget>[
        const _CodeBlock(
          caption: 'pushClipPath — arbitrary mask',
          code: 'final Path star = _buildStarPath();\n'
              'final ClipPathEngineLayer? layer = builder.pushClipPath(\n'
              '  star,\n'
              '  clipBehavior: Clip.antiAlias,\n'
              '  oldLayer: _engineLayer,\n'
              ');\n'
              '// … addPicture / push children …\n'
              'builder.pop();',
        ),
        const SizedBox(height: 12),
        const _CodeBlock(
          caption: 'pushClipRRect — rounded-rect mask',
          code: 'final RRect card = RRect.fromRectAndRadius(\n'
              '  Offset.zero & size,\n'
              '  const Radius.circular(12),\n'
              ');\n'
              'final ClipRRectEngineLayer? layer = builder.pushClipRRect(\n'
              '  card,\n'
              '  clipBehavior: Clip.antiAlias,\n'
              '  oldLayer: _engineLayer,\n'
              ');\n'
              'builder.pop();',
        ),
        const SizedBox(height: 12),
        const _CodeBlock(
          caption: 'pushColorFilter — per-pixel color transform',
          code: 'final ColorFilter grayscale = const ColorFilter.matrix(\n'
              '  <double>[\n'
              '    0.2126, 0.7152, 0.0722, 0, 0,\n'
              '    0.2126, 0.7152, 0.0722, 0, 0,\n'
              '    0.2126, 0.7152, 0.0722, 0, 0,\n'
              '    0,      0,      0,      1, 0,\n'
              '  ],\n'
              ');\n'
              'final ColorFilterEngineLayer? layer =\n'
              '    builder.pushColorFilter(grayscale, oldLayer: _engineLayer);\n'
              'builder.pop();',
        ),
        const SizedBox(height: 12),
        const _CodeBlock(
          caption: 'pushImageFilter — blur the subtree',
          code: 'final ui.ImageFilter blur =\n'
              '    ui.ImageFilter.blur(sigmaX: 6, sigmaY: 6);\n'
              'final ImageFilterEngineLayer? layer = builder.pushImageFilter(\n'
              '  blur,\n'
              '  oldLayer: _engineLayer,\n'
              ');\n'
              'builder.pop();',
        ),
        const SizedBox(height: 12),
        const _CodeBlock(
          caption: 'pushBackdropFilter — frosted-glass effect',
          code: 'final ui.ImageFilter frost =\n'
              '    ui.ImageFilter.blur(sigmaX: 12, sigmaY: 12);\n'
              'final BackdropFilterEngineLayer? layer =\n'
              '    builder.pushBackdropFilter(\n'
              '  frost,\n'
              '  blendMode: BlendMode.srcOver,\n'
              '  oldLayer: _engineLayer,\n'
              ');\n'
              'builder.pop();',
        ),
        const SizedBox(height: 12),
        const _CodeBlock(
          caption: 'pushShaderMask — gradient-shaped masking',
          code: 'final Shader shader = ui.Gradient.linear(\n'
              '  Offset.zero,\n'
              '  Offset(size.width, 0),\n'
              '  <Color>[Colors.deepPurple, Colors.amber],\n'
              ');\n'
              'final ShaderMaskEngineLayer? layer = builder.pushShaderMask(\n'
              '  shader,\n'
              '  Offset.zero & size,\n'
              '  BlendMode.modulate,\n'
              '  oldLayer: _engineLayer,\n'
              ');\n'
              'builder.pop();',
        ),
      ],
    );
  }
}

// =====================================================================
// 11. CHEAT SHEET FOOTER
// =====================================================================

class _CheatSheetSection extends StatelessWidget {
  const _CheatSheetSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Color(0xFF0F172A),
            Color(0xFF1E1B4B),
            Color(0xFF312E81),
          ],
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color(0xFF1E1B4B).withValues(alpha: 0.32),
            blurRadius: 48,
            offset: const Offset(0, 24),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(32, 32, 32, 36),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(999),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.22),
              ),
            ),
            child: const Text(
              'CHEAT SHEET · ENGINELAYER',
              style: TextStyle(
                color: Colors.white,
                fontSize: 11,
                letterSpacing: 1.6,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Keep the four words straight: Scene, SceneBuilder, EngineLayer, oldLayer.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w800,
              height: 1.2,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 20),
          const _ChipGroup(
            title: 'dart:ui layers',
            chips: <String>[
              'EngineLayer',
              'ClipPathEngineLayer',
              'ClipRectEngineLayer',
              'ClipRRectEngineLayer',
              'OpacityEngineLayer',
              'TransformEngineLayer',
              'OffsetEngineLayer',
              'BackdropFilterEngineLayer',
              'ShaderMaskEngineLayer',
              'ColorFilterEngineLayer',
              'ImageFilterEngineLayer',
              'PhysicalShapeEngineLayer',
            ],
            accent: Color(0xFFC084FC),
          ),
          SizedBox(height: 14),
          const _ChipGroup(
            title: 'rendering Layer subclasses',
            chips: <String>[
              'ContainerLayer',
              'PictureLayer',
              'OffsetLayer',
              'ClipPathLayer',
              'ClipRectLayer',
              'ClipRRectLayer',
              'TransformLayer',
              'OpacityLayer',
              'ShaderMaskLayer',
              'BackdropFilterLayer',
              'ColorFilterLayer',
              'ImageFilterLayer',
              'PhysicalModelLayer',
              'AnnotatedRegionLayer',
              'LeaderLayer',
              'FollowerLayer',
            ],
            accent: Color(0xFF22D3EE),
          ),
          SizedBox(height: 14),
          const _ChipGroup(
            title: 'Compositor terms',
            chips: <String>[
              'Scene',
              'SceneBuilder',
              'Picture',
              'PictureRecorder',
              'addPicture',
              'addRetained',
              'addPlatformView',
              'oldLayer',
              'push / pop',
              'Clip.antiAlias',
              'Clip.hardEdge',
              'Clip.antiAliasWithSaveLayer',
            ],
            accent: Color(0xFFFB7185),
          ),
          SizedBox(height: 14),
          const _ChipGroup(
            title: 'Perf flags',
            chips: <String>[
              'debugDisableClipLayers',
              'debugDisableOpacityLayers',
              'debugDisablePhysicalShapeLayers',
              'debugRepaintRainbowEnabled',
              'debugProfilePaintsEnabled',
              'RepaintBoundary',
              'RenderRepaintBoundary',
              'kRaster',
              'kCompositor',
            ],
            accent: Color(0xFF34D399),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.07),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.14),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: const Color(0xFFC084FC).withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.account_tree_outlined,
                    size: 20,
                    color: Color(0xFFE9D5FF),
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'EngineLayer is the compositor side. Layer is the Dart '
                    'side. Pictures are pixels; EngineLayers are wrappers. '
                    'Push, paint, pop, build — and on the next frame, '
                    'thread the handle back via oldLayer.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.5,
                      height: 1.55,
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

class _ChipGroup extends StatelessWidget {
  const _ChipGroup({
    required this.title,
    required this.chips,
    required this.accent,
  });

  final String title;
  final List<String> chips;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title.toUpperCase(),
          style: TextStyle(
            color: accent,
            fontSize: 11,
            letterSpacing: 1.6,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: chips
              .map(
                (String c) => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: 0.13),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(
                      color: accent.withValues(alpha: 0.32),
                    ),
                  ),
                  child: Text(
                    c,
                    style: TextStyle(
                      color: accent,
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
