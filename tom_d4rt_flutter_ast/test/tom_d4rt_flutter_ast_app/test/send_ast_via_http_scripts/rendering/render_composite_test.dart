// ignore_for_file: unused_field, unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last
import 'package:flutter/material.dart';

// =====================================================================
// RENDER COMPOSITE DEEP DEMO
// =====================================================================
// This file is a deeply annotated, hand-written, fully static visual
// exploration of the *compositing* facet of Flutter's rendering layer.
//
// Topics covered (in narrative order):
//   1. Hero banner            - what is compositing?
//   2. Render-tree vs Layer-tree side-by-side diagram
//   3. needsCompositing flag lifecycle (state diagram)
//   4. Repaint-boundary effect: before/after panels
//   5. Compositing triggers reference table
//   6. paintsChild / applyPaintTransform method reference
//   7. Performance impact bar (relative cost rows)
//   8. Pitfalls
//   9. Best practices
//  10. Footer / further reading
//
// Why a separate file dedicated to compositing?
//   The "compositing bits" inside RenderObject are subtle. They control
//   whether a subtree paints into the parent's canvas directly, or whether
//   it spawns a *layer* (OffsetLayer, TransformLayer, ClipPathLayer, etc.)
//   that the Flutter engine composites at frame time. Misunderstanding this
//   distinction leads to invisible widgets, missed clip regions, dropped
//   filters, or runaway repaint cost.
//
// Hard rules adopted by this demo:
//   * No StatefulWidget. No Timer. No Future. No Stream. No AnimationController.
//   * No setState. No dart:async. No dart:io.
//   * Layout is *visual only* - we render diagrams, tables, and prose.
//   * All sections are private `_*Section extends StatelessWidget` types.
//
// The build() entry point at the bottom is the test harness hook used by
// the AST-over-HTTP test framework. It returns a MaterialApp.
// =====================================================================

dynamic build(BuildContext context) {
  return MaterialApp(
    title: 'Render Composite Deep Demo',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.indigo,
      scaffoldBackgroundColor: const Color(0xFFF6F7FB),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(fontSize: 13.5, height: 1.45),
      ),
    ),
    home: Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _HeroBannerSection(),
            SizedBox(height: 28),
            _TreeComparisonSection(),
            SizedBox(height: 28),
            _NeedsCompositingLifecycleSection(),
            SizedBox(height: 28),
            _RepaintBoundaryEffectSection(),
            SizedBox(height: 28),
            _CompositingTriggersTableSection(),
            SizedBox(height: 28),
            _MethodReferenceSection(),
            SizedBox(height: 28),
            _PerformanceImpactSection(),
            SizedBox(height: 28),
            _PitfallsSection(),
            SizedBox(height: 28),
            _BestPracticesSection(),
            SizedBox(height: 28),
            _FooterSection(),
            SizedBox(height: 40),
          ],
        ),
      ),
    ),
  );
}

// =====================================================================
// Shared visual primitives (private helpers reused across sections)
// =====================================================================

class _GradientCard extends StatelessWidget {
  const _GradientCard({
    required this.child,
    required this.colors,
    this.padding = const EdgeInsets.all(20),
    this.radius = 18,
  });

  final Widget child;
  final List<Color> colors;
  final EdgeInsets padding;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colors,
        ),
        borderRadius: BorderRadius.circular(radius),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.10),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.index,
    required this.title,
    required this.subtitle,
  });

  final String index;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 46,
          height: 46,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[Color(0xFF4F46E5), Color(0xFF9333EA)],
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: const Color(0xFF4F46E5).withValues(alpha: 0.35),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Text(
            index,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1F2937),
                  letterSpacing: -0.2,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 13,
                  color: const Color(0xFF1F2937).withValues(alpha: 0.66),
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.text, required this.color});
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.45)),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11.5,
          fontWeight: FontWeight.w700,
          color: color,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}

class _CodeChip extends StatelessWidget {
  const _CodeChip(this.code);
  final String code;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A).withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: const Color(0xFF0F172A).withValues(alpha: 0.12),
        ),
      ),
      child: Text(
        code,
        style: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 12,
          color: Color(0xFF0F172A),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _Bullet extends StatelessWidget {
  const _Bullet(this.text, {this.color = const Color(0xFF4F46E5)});
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
            margin: const EdgeInsets.only(top: 6, right: 10),
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 13.5,
                height: 1.5,
                color: Color(0xFF1F2937),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      margin: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            const Color(0xFF1F2937).withValues(alpha: 0.0),
            const Color(0xFF1F2937).withValues(alpha: 0.18),
            const Color(0xFF1F2937).withValues(alpha: 0.0),
          ],
        ),
      ),
    );
  }
}

// =====================================================================
// SECTION 1 - HERO BANNER
// =====================================================================
// The hero introduces the topic in plain language. Compositing in
// Flutter is the process by which the *engine* (Skia / Impeller) draws
// pre-rendered "layers" into the final frame. A layer is essentially a
// recorded picture, optionally with a transform, a clip, an opacity, a
// filter, or some other engine-level operation associated with it.
//
// The render tree decides *which* render objects need their own layer.
// Most don't - they paint into their parent's canvas. A few do, and
// those become the boundaries of the layer tree.

class _HeroBannerSection extends StatelessWidget {
  const _HeroBannerSection();

  @override
  Widget build(BuildContext context) {
    return _GradientCard(
      colors: const <Color>[Color(0xFF312E81), Color(0xFF6D28D9), Color(0xFFDB2777)],
      padding: const EdgeInsets.fromLTRB(28, 32, 28, 32),
      radius: 24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.35),
                  ),
                ),
                child: const Text(
                  'RENDER LAYER  -  DEEP DIVE',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 11,
                    letterSpacing: 1.6,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  'compositing bits',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.92),
                    fontFamily: 'monospace',
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          const Text(
            'How compositing turns render objects into layers',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.6,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'A practical map of needsCompositing, markNeedsCompositingBitsUpdate, '
            'alwaysNeedsCompositing, OffsetLayer, ContainerLayer, '
            'RenderRepaintBoundary, paintsChild and applyPaintTransform.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.85),
              fontSize: 15,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 22),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: <Widget>[
              _HeroChip(label: 'needsCompositing', color: const Color(0xFFFBBF24)),
              _HeroChip(label: 'OffsetLayer', color: const Color(0xFF34D399)),
              _HeroChip(label: 'RepaintBoundary', color: const Color(0xFF60A5FA)),
              _HeroChip(label: 'alwaysNeedsCompositing', color: const Color(0xFFF472B6)),
              _HeroChip(label: 'paintsChild', color: const Color(0xFFA78BFA)),
              _HeroChip(label: 'applyPaintTransform', color: const Color(0xFFFCA5A5)),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.white.withValues(alpha: 0.22)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(Icons.lightbulb_outline,
                        color: Colors.white.withValues(alpha: 0.9), size: 18),
                    const SizedBox(width: 8),
                    const Text(
                      'TL;DR',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 13,
                        letterSpacing: 0.6,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'A render object is "compositing" when it (or one of its '
                  'descendants) needs a dedicated engine layer to paint '
                  'correctly. Examples include opacity < 1, transforms with '
                  'perspective, image filters, backdrop filters, and explicit '
                  'RepaintBoundary widgets. The engine composes these layers '
                  'together to produce the final frame; the rest of the tree '
                  'paints into a shared canvas owned by the nearest compositing '
                  'ancestor.',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.92),
                    fontSize: 13.5,
                    height: 1.55,
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

class _HeroChip extends StatelessWidget {
  const _HeroChip({required this.label, required this.color});
  final String label;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            color.withValues(alpha: 0.32),
            color.withValues(alpha: 0.14),
          ],
        ),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.55)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'monospace',
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// SECTION 2 - RENDER-TREE VS LAYER-TREE COMPARISON
// =====================================================================
// Flutter maintains two parallel trees during a frame:
//
//   render tree:   RenderObject hierarchy (layout + paint).
//   layer tree:    Layer hierarchy submitted to the engine.
//
// Every render object belongs to exactly one layer (its "compositing
// ancestor"), but only render objects that *introduce* a layer appear
// as nodes in the layer tree. The two trees have the same root but
// the layer tree is typically far smaller.

class _TreeComparisonSection extends StatelessWidget {
  const _TreeComparisonSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionHeader(
            index: '2',
            title: 'Render tree vs layer tree',
            subtitle:
                'Two parallel trees produced for every frame. The layer tree '
                'is a sparse projection of the render tree.',
          ),
          const SizedBox(height: 18),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(child: _renderTreeDiagram()),
              const SizedBox(width: 18),
              Expanded(child: _layerTreeDiagram()),
            ],
          ),
          const _Divider(),
          Row(
            children: <Widget>[
              const _Pill(text: 'PARENT = paints child', color: Color(0xFF2563EB)),
              const SizedBox(width: 8),
              const _Pill(text: 'LAYER = engine boundary', color: Color(0xFFDB2777)),
              const SizedBox(width: 8),
              const _Pill(text: 'LEAF = paints into canvas', color: Color(0xFF059669)),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Observations',
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
          ),
          const SizedBox(height: 8),
          const _Bullet(
              'The render tree has many nodes; most are non-compositing.'),
          const _Bullet(
              'The layer tree has only the compositing ancestors: Opacity, '
              'Transform (3D), ClipPath, ColorFilter, RepaintBoundary, root.'),
          const _Bullet(
              'Every render object is associated with the nearest enclosing '
              'compositing ancestor - its "layer owner".'),
          const _Bullet(
              'Repainting one render object only invalidates the picture of '
              'its layer owner, not the entire scene.'),
        ],
      ),
    );
  }

  Widget _renderTreeDiagram() {
    return _GradientCard(
      colors: const <Color>[Color(0xFFEFF6FF), Color(0xFFDBEAFE)],
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Render tree',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 16,
              color: Color(0xFF1E3A8A),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Every layout + paint participant',
            style: TextStyle(
              color: const Color(0xFF1E3A8A).withValues(alpha: 0.7),
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 14),
          _treeNode('RenderView', 0, _NodeKind.layer),
          _treeNode('RenderPositionedBox', 1, _NodeKind.parent),
          _treeNode('RenderPadding', 2, _NodeKind.parent),
          _treeNode('RenderFlex (Column)', 3, _NodeKind.parent),
          _treeNode('RenderConstrainedBox', 4, _NodeKind.parent),
          _treeNode('RenderOpacity (0.6)', 4, _NodeKind.layer),
          _treeNode('RenderParagraph', 5, _NodeKind.leaf),
          _treeNode('RenderRepaintBoundary', 4, _NodeKind.layer),
          _treeNode('RenderPhysicalModel', 5, _NodeKind.parent),
          _treeNode('RenderDecoratedBox', 6, _NodeKind.parent),
          _treeNode('RenderImage', 7, _NodeKind.leaf),
          _treeNode('RenderTransform (3D)', 4, _NodeKind.layer),
          _treeNode('RenderParagraph', 5, _NodeKind.leaf),
          _treeNode('RenderPadding', 3, _NodeKind.parent),
          _treeNode('RenderParagraph', 4, _NodeKind.leaf),
        ],
      ),
    );
  }

  Widget _layerTreeDiagram() {
    return _GradientCard(
      colors: const <Color>[Color(0xFFFDF2F8), Color(0xFFFCE7F3)],
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Layer tree',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 16,
              color: Color(0xFF831843),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Sparse - only compositing ancestors',
            style: TextStyle(
              color: const Color(0xFF831843).withValues(alpha: 0.7),
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 14),
          _treeNode('TransformLayer (root)', 0, _NodeKind.layer),
          _treeNode('PictureLayer', 1, _NodeKind.leaf),
          _treeNode('OpacityLayer (0.6)', 1, _NodeKind.layer),
          _treeNode('PictureLayer', 2, _NodeKind.leaf),
          _treeNode('OffsetLayer (RepaintBoundary)', 1, _NodeKind.layer),
          _treeNode('PictureLayer', 2, _NodeKind.leaf),
          _treeNode('TransformLayer (3D)', 1, _NodeKind.layer),
          _treeNode('PictureLayer', 2, _NodeKind.leaf),
          _treeNode('PictureLayer (residual paragraph)', 1, _NodeKind.leaf),
        ],
      ),
    );
  }

  Widget _treeNode(String label, int depth, _NodeKind kind) {
    final Color base = switch (kind) {
      _NodeKind.layer => const Color(0xFFDB2777),
      _NodeKind.parent => const Color(0xFF2563EB),
      _NodeKind.leaf => const Color(0xFF059669),
    };
    final String prefix = switch (kind) {
      _NodeKind.layer => 'LAYER',
      _NodeKind.parent => 'PARENT',
      _NodeKind.leaf => 'LEAF',
    };
    return Padding(
      padding: EdgeInsets.only(left: depth * 14.0, top: 3, bottom: 3),
      child: Row(
        children: <Widget>[
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: base, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
            decoration: BoxDecoration(
              color: base.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              prefix,
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w800,
                color: base,
                letterSpacing: 0.6,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              label,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: Color(0xFF111827),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum _NodeKind { layer, parent, leaf }

// =====================================================================
// SECTION 3 - needsCompositing FLAG LIFECYCLE (state diagram)
// =====================================================================
// The internal flag `_needsCompositing` on RenderObject is the heart of
// this story. It is a derived bit: true if the render object or any of
// its descendants requires a compositing layer.
//
// Lifecycle of `_needsCompositing`:
//
//   1. Initial - flag is `alwaysNeedsCompositing` (false for most).
//   2. Attach - parent recomputes its own flag from child contributions.
//   3. markNeedsCompositingBitsUpdate() - schedules a recompute walk.
//   4. _updateCompositingBits() - bottom-up pass updates the flag.
//   5. paint() - branches on `needsCompositing` to push a layer or not.
//   6. Detach - parent re-derives the flag, propagating cleanup.

class _NeedsCompositingLifecycleSection extends StatelessWidget {
  const _NeedsCompositingLifecycleSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionHeader(
            index: '3',
            title: 'needsCompositing flag lifecycle',
            subtitle:
                'How the compositing bit is computed, propagated, and consumed '
                'as a frame is built.',
          ),
          const SizedBox(height: 18),
          _stateDiagram(),
          const _Divider(),
          _stateLegend(),
          const _Divider(),
          _flagPropagationDiagram(),
        ],
      ),
    );
  }

  Widget _stateDiagram() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[Color(0xFFF0F9FF), Color(0xFFE0F2FE)],
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'State machine of _needsCompositing',
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
          ),
          const SizedBox(height: 14),
          Row(
            children: <Widget>[
              Expanded(child: _stateBox('INITIAL', 'Just constructed', const Color(0xFF6B7280))),
              _arrow('attach()'),
              Expanded(child: _stateBox('CLEAN', 'attached, flag valid', const Color(0xFF059669))),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: <Widget>[
              Expanded(child: _stateBox('CLEAN', 'attached, flag valid', const Color(0xFF059669))),
              _arrow('markNeeds...Update()'),
              Expanded(child: _stateBox('DIRTY', 'needs recompute', const Color(0xFFDC2626))),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: <Widget>[
              Expanded(child: _stateBox('DIRTY', 'flag stale', const Color(0xFFDC2626))),
              _arrow('_updateCompositingBits()'),
              Expanded(child: _stateBox('CLEAN', 'flag re-derived', const Color(0xFF059669))),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: <Widget>[
              Expanded(child: _stateBox('CLEAN', 'frame is painting', const Color(0xFF059669))),
              _arrow('paint() branches'),
              Expanded(
                child: _stateBox(
                  'COMPOSITES',
                  'pushed layer',
                  const Color(0xFFDB2777),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _stateBox(String name, String hint, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        border: Border.all(color: color.withValues(alpha: 0.4), width: 1.4),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            name,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w800,
              fontSize: 12,
              letterSpacing: 0.6,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            hint,
            style: const TextStyle(
              fontSize: 11.5,
              color: Color(0xFF374151),
            ),
          ),
        ],
      ),
    );
  }

  Widget _arrow(String label) {
    return Container(
      width: 110,
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Column(
        children: <Widget>[
          Container(
            height: 2,
            color: const Color(0xFF6B7280).withValues(alpha: 0.5),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.5,
              color: Color(0xFF374151),
            ),
          ),
        ],
      ),
    );
  }

  Widget _stateLegend() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: const <Widget>[
        _Pill(text: 'INITIAL  -  no parent yet', color: Color(0xFF6B7280)),
        _Pill(text: 'CLEAN    -  flag is up to date', color: Color(0xFF059669)),
        _Pill(text: 'DIRTY    -  needs recomputation', color: Color(0xFFDC2626)),
        _Pill(text: 'COMPOSITES - layer pushed', color: Color(0xFFDB2777)),
      ],
    );
  }

  Widget _flagPropagationDiagram() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[Color(0xFFFEF3C7), Color(0xFFFDE68A)],
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Bottom-up propagation example',
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
          ),
          const SizedBox(height: 12),
          _propRow('Root (RenderView)', true,
              'true because any descendant compositing forces it'),
          _propRow('  Column', true,
              'aggregates from children below'),
          _propRow('    Padding', false,
              'pure layout, no layer'),
          _propRow('    Opacity(0.5)', true,
              'alwaysNeedsCompositing = true when opacity < 1'),
          _propRow('      Text', false,
              'leaf, paints into parent canvas'),
          _propRow('    RepaintBoundary', true,
              'alwaysNeedsCompositing = true unconditionally'),
          _propRow('      ListView', false,
              'inside boundary, paints into boundary layer'),
          _propRow('    Transform.translate', false,
              '2D translate alone does not force compositing'),
          _propRow('    Transform (3D)', true,
              'transform with perspective requires layer'),
        ],
      ),
    );
  }

  Widget _propRow(String node, bool flag, String reason) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 220,
            child: Text(
              node,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.5,
                color: Color(0xFF1F2937),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: (flag ? const Color(0xFFDB2777) : const Color(0xFF059669))
                  .withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              flag ? 'needsCompositing = true' : 'needsCompositing = false',
              style: TextStyle(
                color: flag
                    ? const Color(0xFFDB2777)
                    : const Color(0xFF059669),
                fontFamily: 'monospace',
                fontSize: 11.5,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              reason,
              style: const TextStyle(
                fontSize: 12.5,
                color: Color(0xFF374151),
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
// SECTION 4 - REPAINT-BOUNDARY EFFECT (before / after panels)
// =====================================================================
// `RepaintBoundary` is the simplest mechanism for explicitly introducing
// a compositing boundary. It wraps a subtree so that the subtree gets
// its own `OffsetLayer`, and dirty repaints inside the boundary do not
// propagate up to invalidate other parts of the scene.
//
// The classic illustration: a list of complex items, one of which
// animates. Without a boundary, every animation tick repaints every
// item. With a boundary, only the animated item repaints.

class _RepaintBoundaryEffectSection extends StatelessWidget {
  const _RepaintBoundaryEffectSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionHeader(
            index: '4',
            title: 'RepaintBoundary - before / after',
            subtitle:
                'Visualise the dirty-region propagation with and without a '
                'RepaintBoundary wrapping a frequently-redrawing child.',
          ),
          const SizedBox(height: 18),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(child: _beforePanel()),
              const SizedBox(width: 16),
              Expanded(child: _afterPanel()),
            ],
          ),
          const _Divider(),
          _comparisonTable(),
        ],
      ),
    );
  }

  Widget _beforePanel() {
    return _GradientCard(
      colors: const <Color>[Color(0xFFFEE2E2), Color(0xFFFECACA)],
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFDC2626),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'BEFORE',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.5,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'No RepaintBoundary',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF991B1B),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'Every frame, the entire list repaints into the same layer as the '
            'animation.',
            style: TextStyle(
              fontSize: 12,
              color: const Color(0xFF991B1B).withValues(alpha: 0.85),
            ),
          ),
          const SizedBox(height: 14),
          _fakeListItem('Item 0001', dirty: true),
          _fakeListItem('Item 0002', dirty: true),
          _fakeListItem('Spinner', dirty: true, accent: true),
          _fakeListItem('Item 0003', dirty: true),
          _fakeListItem('Item 0004', dirty: true),
          _fakeListItem('Item 0005', dirty: true),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.55),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'Cost per frame ~ N * cost(item)',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: Color(0xFF7F1D1D),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _afterPanel() {
    return _GradientCard(
      colors: const <Color>[Color(0xFFDCFCE7), Color(0xFFBBF7D0)],
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFF059669),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'AFTER',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.5,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'With RepaintBoundary',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF064E3B),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'Only the spinner subtree repaints; the rest of the list is '
            'reused from its cached OffsetLayer.',
            style: TextStyle(
              fontSize: 12,
              color: const Color(0xFF064E3B).withValues(alpha: 0.85),
            ),
          ),
          const SizedBox(height: 14),
          _fakeListItem('Item 0001', dirty: false),
          _fakeListItem('Item 0002', dirty: false),
          _fakeListItem('Spinner', dirty: true, accent: true),
          _fakeListItem('Item 0003', dirty: false),
          _fakeListItem('Item 0004', dirty: false),
          _fakeListItem('Item 0005', dirty: false),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.55),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'Cost per frame ~ cost(spinner) + compose(layers)',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: Color(0xFF064E3B),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _fakeListItem(String label,
      {required bool dirty, bool accent = false}) {
    final Color base = accent
        ? const Color(0xFF7C3AED)
        : const Color(0xFF111827).withValues(alpha: 0.65);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: dirty
              ? const Color(0xFFDC2626).withValues(alpha: 0.55)
              : const Color(0xFF065F46).withValues(alpha: 0.35),
          width: dirty ? 1.6 : 1.0,
        ),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 9,
            height: 9,
            decoration: BoxDecoration(color: base, shape: BoxShape.circle),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: Color(0xFF111827),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: dirty
                  ? const Color(0xFFDC2626).withValues(alpha: 0.12)
                  : const Color(0xFF065F46).withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              dirty ? 'dirty' : 'cached',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 10.5,
                fontWeight: FontWeight.w700,
                color: dirty
                    ? const Color(0xFFDC2626)
                    : const Color(0xFF065F46),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _comparisonTable() {
    final List<List<String>> rows = <List<String>>[
      <String>['Layer count', '1 (or root only)', '2 (root + boundary)'],
      <String>['Items repainted/frame', 'N', '1'],
      <String>['GPU compose calls', '~1', '~2'],
      <String>['Memory for cached pictures', 'small', '+1 cached picture'],
      <String>['Setup complexity', 'trivial', 'wrap subtree'],
      <String>['When to use', 'static rare repaint', 'frequent isolated repaint'],
    ];
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        children: <Widget>[
          _tableHeader(<String>['Metric', 'Before', 'After']),
          for (final List<String> r in rows) _tableRow(r),
        ],
      ),
    );
  }

  Widget _tableHeader(List<String> cells) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[Color(0xFF1F2937), Color(0xFF374151)],
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: <Widget>[
          for (int i = 0; i < cells.length; i++)
            Expanded(
              flex: i == 0 ? 3 : 2,
              child: Text(
                cells[i],
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 12.5,
                  letterSpacing: 0.5,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _tableRow(List<String> cells) {
    return Container(
      margin: const EdgeInsets.only(top: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFF1F2937).withValues(alpha: 0.08),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          for (int i = 0; i < cells.length; i++)
            Expanded(
              flex: i == 0 ? 3 : 2,
              child: Text(
                cells[i],
                style: TextStyle(
                  fontFamily: i == 0 ? null : 'monospace',
                  fontSize: 12.5,
                  fontWeight: i == 0 ? FontWeight.w700 : FontWeight.w500,
                  color: const Color(0xFF1F2937),
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
// SECTION 5 - COMPOSITING TRIGGERS REFERENCE TABLE
// =====================================================================
// Comprehensive reference of which render objects / widgets force a
// compositing layer to be created, and why. Each entry annotates the
// trigger with the layer kind, and whether it is conditional.

class _CompositingTriggersTableSection extends StatelessWidget {
  const _CompositingTriggersTableSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionHeader(
            index: '5',
            title: 'Compositing triggers reference',
            subtitle:
                'A catalogue of render objects that introduce layers, the '
                'layer kind they push, and the condition that activates them.',
          ),
          const SizedBox(height: 18),
          _triggerTable(),
          const _Divider(),
          _layerKindLegend(),
        ],
      ),
    );
  }

  Widget _triggerTable() {
    final List<_Trigger> triggers = const <_Trigger>[
      _Trigger('RenderRepaintBoundary', 'OffsetLayer',
          'always', _Severity.always,
          'Explicit boundary, alwaysNeedsCompositing == true.'),
      _Trigger('RenderOpacity', 'OpacityLayer',
          'opacity < 1.0', _Severity.conditional,
          'Opaque at 1.0 short-circuits to no layer.'),
      _Trigger('RenderAnimatedOpacity', 'OpacityLayer',
          'animation value < 1', _Severity.conditional,
          'Same as RenderOpacity but driven by an Animation.'),
      _Trigger('RenderTransform', 'TransformLayer',
          'transform != identity && hasPerspective || compositing forced',
          _Severity.conditional,
          '2D translate may be inlined; 3D requires a layer.'),
      _Trigger('RenderFractionalTranslation', 'none',
          'never', _Severity.never,
          'Pure offset, applied during paint.'),
      _Trigger('RenderClipRect', 'ClipRectLayer',
          'clipBehavior != none', _Severity.conditional,
          'May inline antialiased clip without a layer in some cases.'),
      _Trigger('RenderClipRRect', 'ClipRRectLayer',
          'clipBehavior != none', _Severity.conditional,
          'Rounded clip; antiAliasWithSaveLayer always composites.'),
      _Trigger('RenderClipOval', 'ClipPathLayer',
          'always when clipping', _Severity.always,
          'Oval clip uses a path layer.'),
      _Trigger('RenderClipPath', 'ClipPathLayer',
          'always when clipping', _Severity.always,
          'Arbitrary path clip; always pushes a layer.'),
      _Trigger('RenderPhysicalModel', 'PhysicalModelLayer',
          'elevation > 0 || clipBehavior != none',
          _Severity.conditional,
          'Engine-side elevation shadow + clip combination.'),
      _Trigger('RenderPhysicalShape', 'PhysicalShapeLayer',
          'elevation > 0 || clipBehavior != none',
          _Severity.conditional,
          'PhysicalModel for custom shapes.'),
      _Trigger('RenderImageFilter', 'ImageFilterLayer',
          'filter != null', _Severity.always,
          'Used by BackdropFilter etc.'),
      _Trigger('RenderBackdropFilter', 'BackdropFilterLayer',
          'always', _Severity.always,
          'Samples from behind the layer; must composite.'),
      _Trigger('RenderColorFilter', 'ColorFilterLayer',
          'always', _Severity.always,
          'Wraps subtree paint in a color filter.'),
      _Trigger('RenderShaderMask', 'ShaderMaskLayer',
          'always', _Severity.always,
          'Applies shader to subtree image.'),
      _Trigger('RenderFollowLeader', 'LeaderLayer/FollowerLayer',
          'with CompositedTransformFollower', _Severity.always,
          'Synchronises a follower with a leader rectangle.'),
      _Trigger('RenderTransformLayer (3D)', 'TransformLayer',
          'matrix has perspective component', _Severity.always,
          'Engine cannot collapse perspective into draw calls.'),
      _Trigger('RenderTexture', 'TextureLayer',
          'always when bound', _Severity.always,
          'External texture (e.g. platform views).'),
      _Trigger('RenderPlatformView', 'PlatformViewLayer',
          'always', _Severity.always,
          'Embeds native view; needs its own layer.'),
      _Trigger('RenderOpacity (0.0)', 'OpacityLayer',
          'opacity == 0', _Severity.conditional,
          'May short-circuit paint entirely - subtree not painted at all.'),
    ];
    return Column(
      children: <Widget>[
        _headerRow(),
        for (final _Trigger t in triggers) _triggerRow(t),
      ],
    );
  }

  Widget _headerRow() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[Color(0xFF312E81), Color(0xFF4338CA)],
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: const <Widget>[
          Expanded(flex: 4, child: Text('RenderObject',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 12.5))),
          Expanded(flex: 3, child: Text('Layer kind',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 12.5))),
          Expanded(flex: 3, child: Text('Condition',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 12.5))),
          Expanded(flex: 2, child: Text('Severity',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 12.5))),
        ],
      ),
    );
  }

  Widget _triggerRow(_Trigger t) {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
            color: const Color(0xFF1F2937).withValues(alpha: 0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Text(
                  t.name,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1F2937),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  t.layer,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12,
                    color: Color(0xFF4338CA),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  t.condition,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF374151),
                    height: 1.35,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: _severityPill(t.severity),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            t.note,
            style: TextStyle(
              fontSize: 12,
              color: const Color(0xFF1F2937).withValues(alpha: 0.7),
              fontStyle: FontStyle.italic,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }

  Widget _severityPill(_Severity sev) {
    final Color color = switch (sev) {
      _Severity.always => const Color(0xFFDB2777),
      _Severity.conditional => const Color(0xFFB45309),
      _Severity.never => const Color(0xFF059669),
    };
    final String label = switch (sev) {
      _Severity.always => 'ALWAYS',
      _Severity.conditional => 'COND',
      _Severity.never => 'NEVER',
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10.5,
          fontWeight: FontWeight.w800,
          color: color,
          letterSpacing: 0.6,
        ),
      ),
    );
  }

  Widget _layerKindLegend() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: const <Widget>[
        _Pill(text: 'OffsetLayer', color: Color(0xFF4338CA)),
        _Pill(text: 'OpacityLayer', color: Color(0xFF7C3AED)),
        _Pill(text: 'TransformLayer', color: Color(0xFFDB2777)),
        _Pill(text: 'ClipRectLayer / ClipRRectLayer / ClipPathLayer',
            color: Color(0xFFB45309)),
        _Pill(text: 'PhysicalModelLayer / PhysicalShapeLayer',
            color: Color(0xFF065F46)),
        _Pill(text: 'ImageFilterLayer / BackdropFilterLayer',
            color: Color(0xFF0E7490)),
        _Pill(text: 'ColorFilterLayer / ShaderMaskLayer',
            color: Color(0xFFBE123C)),
        _Pill(text: 'TextureLayer / PlatformViewLayer',
            color: Color(0xFF1F2937)),
      ],
    );
  }
}

class _Trigger {
  const _Trigger(
      this.name, this.layer, this.condition, this.severity, this.note);
  final String name;
  final String layer;
  final String condition;
  final _Severity severity;
  final String note;
}

enum _Severity { always, conditional, never }

// =====================================================================
// SECTION 6 - paintsChild / applyPaintTransform METHOD REFERENCE
// =====================================================================
// Two protocol methods on RenderObject participate in the compositing
// flow when something other than the parent's own render asks "where
// does this child appear on the screen?".

class _MethodReferenceSection extends StatelessWidget {
  const _MethodReferenceSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionHeader(
            index: '6',
            title: 'paintsChild & applyPaintTransform',
            subtitle:
                'Protocol methods that let render objects describe how a child '
                'maps from its local coordinates into the parent.',
          ),
          const SizedBox(height: 18),
          _methodCard(
            name: 'bool paintsChild(covariant RenderObject child)',
            signature:
                'returns true if this render object will actually paint the '
                'given child during paint().',
            details: <String>[
              'Default implementation in RenderObject returns true.',
              'Override in clipping or culling renderers to return false '
                  'when child falls outside visible area.',
              'Affects hit-test propagation and accessibility tree.',
              'IndexedStack returns false for all non-active children; '
                  'they are laid out but not painted.',
              'Result must be stable across a frame (cached by callers).',
            ],
            color: const Color(0xFF4338CA),
          ),
          const SizedBox(height: 16),
          _methodCard(
            name:
                'void applyPaintTransform(covariant RenderObject child, Matrix4 transform)',
            signature:
                'mutates `transform` in place so it maps points from the '
                'child\'s local space into this render object\'s space.',
            details: <String>[
              'Default uses BoxParentData.offset for RenderBox children.',
              'Transform renderers multiply in their own matrix.',
              'Opacity is invisible in this transform - it does not move '
                  'children, only modifies pixels.',
              'Used by RenderObject.getTransformTo() to chain transforms '
                  'up the tree.',
              'Wrong implementations break Overlay.of(), CompositedTransformFollower, '
                  'and hit testing under rotation.',
            ],
            color: const Color(0xFFDB2777),
          ),
          const _Divider(),
          _interactionDiagram(),
        ],
      ),
    );
  }

  Widget _methodCard({
    required String name,
    required String signature,
    required List<String> details,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            color.withValues(alpha: 0.10),
            color.withValues(alpha: 0.02),
          ],
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'METHOD',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 10.5,
                    letterSpacing: 0.6,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  name,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            signature,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF1F2937),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 10),
          for (final String d in details) _Bullet(d, color: color),
        ],
      ),
    );
  }

  Widget _interactionDiagram() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[Color(0xFFECFEFF), Color(0xFFCFFAFE)],
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Call sequence for "where on screen is this RenderBox?"',
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
          ),
          const SizedBox(height: 12),
          _seqStep('1', 'caller', 'box.getTransformTo(ancestor)'),
          _seqStep('2', 'RenderObject', 'walk parent chain up to ancestor'),
          _seqStep('3', 'each parent',
              'applyPaintTransform(child, matrix) merges in its local mapping'),
          _seqStep('4', 'compositing parents',
              'TransformLayer adds 3D transform, OpacityLayer is a no-op for geometry'),
          _seqStep('5', 'caller',
              'matrix.transform3(localPoint) -> screen position'),
        ],
      ),
    );
  }

  Widget _seqStep(String n, String actor, String action) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 24,
            height: 24,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Color(0xFF0E7490),
              shape: BoxShape.circle,
            ),
            child: Text(
              n,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 130,
            child: Text(
              actor,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.5,
                fontWeight: FontWeight.w700,
                color: Color(0xFF0E7490),
              ),
            ),
          ),
          Expanded(
            child: Text(
              action,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF1F2937),
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// SECTION 7 - PERFORMANCE IMPACT BARS
// =====================================================================
// The relative cost of compositing-related operations. Bars are
// normalised against the cost of painting a single static container.

class _PerformanceImpactSection extends StatelessWidget {
  const _PerformanceImpactSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionHeader(
            index: '7',
            title: 'Performance impact - relative cost',
            subtitle:
                'Order-of-magnitude estimates. Real numbers vary by GPU, '
                'screen size, and the contents of the layer.',
          ),
          const SizedBox(height: 18),
          _bar('Container with BoxDecoration', 0.10, const Color(0xFF059669)),
          _bar('Text (single line)', 0.18, const Color(0xFF059669)),
          _bar('Image (decoded, cached)', 0.22, const Color(0xFF059669)),
          _bar('Push OffsetLayer (RepaintBoundary)', 0.08,
              const Color(0xFF4338CA)),
          _bar('Push OpacityLayer', 0.30, const Color(0xFFB45309)),
          _bar('Push TransformLayer (3D)', 0.40, const Color(0xFFB45309)),
          _bar('Push ClipRRectLayer (antialiased)', 0.45,
              const Color(0xFFB45309)),
          _bar('Push ClipPath with complex path', 0.65,
              const Color(0xFFDB2777)),
          _bar('Push BackdropFilter (blur sigma=8)', 0.95,
              const Color(0xFFDB2777)),
          _bar('Push ColorFilterLayer', 0.35, const Color(0xFFB45309)),
          _bar('Composite 2 cached layers', 0.05, const Color(0xFF059669)),
          _bar('Composite 100 cached layers', 0.50, const Color(0xFFB45309)),
          _bar('Repaint 1000-line ListView (no boundary)', 1.00,
              const Color(0xFFDB2777)),
          _bar('Repaint 1000-line ListView (with boundary)', 0.06,
              const Color(0xFF059669)),
          const _Divider(),
          _legend(),
        ],
      ),
    );
  }

  Widget _bar(String label, double normalised, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 280,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 12.5,
                color: Color(0xFF1F2937),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Stack(
              children: <Widget>[
                Container(
                  height: 18,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F2937).withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: normalised.clamp(0.0, 1.0),
                  child: Container(
                    height: 18,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          color.withValues(alpha: 0.85),
                          color.withValues(alpha: 0.55),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 52,
            child: Text(
              normalised.toStringAsFixed(2),
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Color(0xFF111827),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _legend() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: const <Widget>[
        _Pill(text: 'cheap', color: Color(0xFF059669)),
        _Pill(text: 'boundary cost (one-off)', color: Color(0xFF4338CA)),
        _Pill(text: 'moderate', color: Color(0xFFB45309)),
        _Pill(text: 'expensive', color: Color(0xFFDB2777)),
      ],
    );
  }
}

// =====================================================================
// SECTION 8 - PITFALLS
// =====================================================================
// Common mistakes when reasoning about compositing.

class _PitfallsSection extends StatelessWidget {
  const _PitfallsSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionHeader(
            index: '8',
            title: 'Pitfalls',
            subtitle:
                'Anti-patterns that look like optimisations but make rendering '
                'slower, glitchy, or harder to reason about.',
          ),
          const SizedBox(height: 18),
          _pitfall(
            'Sprinkling RepaintBoundary everywhere',
            'Each boundary adds a layer, its own picture cache, and a '
                'compositing step. For mostly-static UI, the overhead exceeds '
                'the savings. Apply boundaries only around frequently '
                'repainting subtrees that share a parent with stable siblings.',
            const Color(0xFFDC2626),
          ),
          _pitfall(
            'Wrapping the entire screen in RepaintBoundary',
            'A boundary at the root is redundant - the engine already pushes '
                'a root layer. You buy nothing and you add an extra '
                'OffsetLayer.',
            const Color(0xFFDC2626),
          ),
          _pitfall(
            'Setting alwaysNeedsCompositing = true on a custom RenderObject',
            'Useful only when you genuinely need to push a layer in paint(). '
                'If you do not call pushLayer / pushOpacity / etc. the flag '
                'lies, and the framework assumes a layer exists when it does '
                'not - leading to missing repaints.',
            const Color(0xFFDC2626),
          ),
          _pitfall(
            'Calling markNeedsPaint() instead of '
                'markNeedsCompositingBitsUpdate()',
            'After changing a property that toggles whether you composite '
                '(e.g. opacity crossing 1.0), the compositing-bits cache is '
                'stale. Plain markNeedsPaint will paint, but parents will not '
                'know to push a layer. Call markNeedsCompositingBitsUpdate() '
                'as well.',
            const Color(0xFFDC2626),
          ),
          _pitfall(
            'Forgetting to override paintsChild for hidden children',
            'IndexedStack-style widgets must report paintsChild == false for '
                'inactive children. Otherwise hit-test results and semantics '
                'will still surface them. The visual output looks right; the '
                'behaviour is wrong.',
            const Color(0xFFDC2626),
          ),
          _pitfall(
            'Overriding applyPaintTransform incompletely',
            'If your render object stores children at offsets other than '
                'BoxParentData.offset, you must teach applyPaintTransform '
                'about those offsets. Without it, Overlay positioning, '
                'CompositedTransformFollower, and global-to-local conversion '
                'are wrong.',
            const Color(0xFFDC2626),
          ),
          _pitfall(
            'Using Transform.scale on a very large subtree',
            'A scale matrix is "free" for geometry but the engine still '
                'paints the entire subtree at the new size. Cache the result '
                'with RepaintBoundary so the rasterisation is reused.',
            const Color(0xFFDC2626),
          ),
          _pitfall(
            'Animating Opacity instead of FadeTransition',
            'Opacity rebuilds and repaints the subtree at every animation '
                'tick. FadeTransition uses an OpacityLayer with an animated '
                'alpha value, which the engine handles without repainting.',
            const Color(0xFFDC2626),
          ),
          _pitfall(
            'Stacking many BackdropFilter widgets',
            'Each BackdropFilter samples the layer behind it; nested filters '
                'force multiple samples. Coalesce into a single filter or use '
                'a less expensive effect.',
            const Color(0xFFDC2626),
          ),
        ],
      ),
    );
  }

  Widget _pitfall(String title, String body, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            color.withValues(alpha: 0.08),
            color.withValues(alpha: 0.02),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.warning_amber_rounded, color: color, size: 18),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            body,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF1F2937),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// SECTION 9 - BEST PRACTICES
// =====================================================================

class _BestPracticesSection extends StatelessWidget {
  const _BestPracticesSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionHeader(
            index: '9',
            title: 'Best practices',
            subtitle:
                'Heuristics that hold for the vast majority of Flutter apps.',
          ),
          const SizedBox(height: 18),
          _practice('Measure before optimising',
              'Run the Performance overlay, the DevTools "Repaint Rainbow", '
                  'and Skia tracing first. Compositing decisions should be '
                  'data driven.'),
          _practice('Boundary near the change',
              'Place RepaintBoundary around the smallest subtree that '
                  'animates frequently. The boundary is most effective when '
                  'its siblings are stable.'),
          _practice('Prefer Transition widgets over rebuilds',
              'FadeTransition, SlideTransition, ScaleTransition apply changes '
                  'at the layer level. They avoid the build phase entirely.'),
          _practice('Use Opacity(0.0) carefully',
              'opacity == 0 short-circuits paint, which is great. But if the '
                  'subtree must remain hit-testable, use Visibility or '
                  'IgnorePointer explicitly.'),
          _practice('Override paintsChild when culling',
              'If your custom layout decides not to paint a child, override '
                  'paintsChild to return false so semantics and hit testing '
                  'agree.'),
          _practice('Override applyPaintTransform when offsetting',
              'Whenever your render object positions children at non-trivial '
                  'offsets, applyPaintTransform must mirror that math.'),
          _practice('Call markNeedsCompositingBitsUpdate when conditional',
              'Any setter that toggles whether a layer is pushed must mark '
                  'the compositing bits dirty - never rely on markNeedsPaint '
                  'alone.'),
          _practice('Cache static content',
              'Wrap rarely-changing portions of the screen in '
                  'RepaintBoundary so the engine can reuse their picture.'),
          _practice('Minimise BackdropFilter scope',
              'Constrain BackdropFilter to the smallest possible rect using '
                  'ClipRect. Sampling the back-buffer is expensive at full '
                  'screen resolution.'),
          _practice('Document custom RenderObjects',
              'When subclassing RenderBox or RenderObject, document the '
                  'compositing contract: when do you set '
                  'alwaysNeedsCompositing, which layer kind do you push, what '
                  'invariants does paintsChild guarantee?'),
        ],
      ),
    );
  }

  Widget _practice(String title, String body) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[Color(0xFFECFDF5), Color(0xFFD1FAE5)],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: const Color(0xFF065F46).withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.check_circle_outline,
                  color: Color(0xFF065F46), size: 18),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF065F46),
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            body,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF1F2937),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// SECTION 10 - FOOTER
// =====================================================================

class _FooterSection extends StatelessWidget {
  const _FooterSection();

  @override
  Widget build(BuildContext context) {
    return _GradientCard(
      colors: const <Color>[Color(0xFF0F172A), Color(0xFF1E293B)],
      padding: const EdgeInsets.all(24),
      radius: 22,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(
                      color: Colors.white.withValues(alpha: 0.25)),
                ),
                child: const Text(
                  'END',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 11,
                    letterSpacing: 1.4,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                'rendering / compositing reference',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.8),
                  fontSize: 12,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Text(
            'Further reading',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 12),
          _link('package:flutter/rendering.dart - RenderObject'),
          _link('package:flutter/rendering.dart - Layer / OffsetLayer'),
          _link('package:flutter/rendering.dart - RenderRepaintBoundary'),
          _link('package:flutter/widgets.dart - RepaintBoundary'),
          _link('Flutter DevTools - Repaint Rainbow'),
          _link('Flutter DevTools - Highlight Repaints'),
          _link('Flutter Engine - SceneBuilder / EngineLayer'),
          const SizedBox(height: 18),
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'KEY TAKEAWAY',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.7),
                          fontWeight: FontWeight.w800,
                          fontSize: 10.5,
                          letterSpacing: 1.0,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Compositing is the engine-level boundary between '
                        '"painted into the parent canvas" and "submitted as '
                        'its own layer". The render tree decides which side '
                        'of the boundary each object sits on; the layer tree '
                        'is the result.',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.92),
                          fontSize: 13,
                          height: 1.5,
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
    );
  }

  Widget _link(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: <Widget>[
          Container(
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: Color(0xFF60A5FA),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                color: Color(0xFFE2E8F0),
                fontFamily: 'monospace',
                fontSize: 12.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
