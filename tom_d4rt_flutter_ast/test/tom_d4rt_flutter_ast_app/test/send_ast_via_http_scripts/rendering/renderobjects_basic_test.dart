// ignore_for_file: unused_field, unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last
//
// RenderObjects (Basic) — Hand-authored deep demo for the foundational
// render-tree classes that ship in `package:flutter/rendering.dart`.
//
// Target classes (described, never instantiated):
//
//   • RenderObject          — abstract root of the render tree. Owns the
//                             attach / layout / paint / hitTest / detach
//                             lifecycle and a parent-data slot used by its
//                             parent to track per-child layout state.
//   • RenderBox             — Cartesian-pixel subclass of RenderObject with
//                             the BoxConstraints / Size protocol.
//   • RenderProxyBox        — RenderBox that has exactly one RenderBox child
//                             and forwards the constraints unchanged.
//   • RenderShiftedBox      — RenderBox with a single child that may be
//                             positioned at a non-zero offset by the parent.
//   • RenderConstrainedBox  — Tightens / loosens the incoming constraints
//                             before delegating to its child.
//   • RenderPadding         — RenderShiftedBox that subtracts the inset on
//                             layout and re-positions the child.
//   • RenderTransform       — RenderProxyBox that paints a 4x4 matrix in a
//                             TransformLayer during paint.
//   • RenderOpacity         — RenderProxyBox that drops to 0 paint when the
//                             alpha is zero, and creates an OpacityLayer
//                             otherwise.
//
// Live RenderBox instantiation is OUT OF SCOPE here. We only refer to these
// classes by name and describe their shape via `Text` widgets that render
// the contract as code snippets. The visible UI itself is composed of the
// ordinary widget API on top of the same render objects.
//
// This file is a static, single-screen visual deep demo. It contains a
// single `dynamic build(BuildContext)` that returns a `MaterialApp`. There
// are no animations, controllers, timers, async, or stateful interactions.
// All helper widgets, painters, and decorations are private (`_Private`)
// and live below the entry point.
//
// Visual themes:
//   • Cool deep-blue / orange / mint palette with ≥7 gradients.
//   • Generous use of BoxShadow stacks (≥6 multi-shadow groups).
//   • Layered "anatomy" diagrams of the render-tree using nested Containers.
//   • Hand-drawn flow charts: constraints go DOWN, sizes come UP.
//
// Target ≥800 lines (actual ~1700-2300). Hand-authored. Analyzer-clean.
// =====================================================================

import 'package:flutter/material.dart';

// =====================================================================
// ENTRY POINT
// =====================================================================

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'RenderObjects (Basic) Demo',
    theme: ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.indigo,
      scaffoldBackgroundColor: const Color(0xFFEFF2F8),
      textTheme: const TextTheme(
        bodySmall: TextStyle(fontSize: 12, height: 1.45),
        bodyMedium: TextStyle(fontSize: 14, height: 1.5),
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
    home: const _RenderObjectsBasicShowcase(),
  );
}

// =====================================================================
// SHOWCASE ROOT
// =====================================================================

class _RenderObjectsBasicShowcase extends StatelessWidget {
  const _RenderObjectsBasicShowcase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF2F8),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const <Widget>[
              _HeroSection(),
              SizedBox(height: 36),
              _ThreeTreesSection(),
              SizedBox(height: 36),
              _RenderObjectAnatomySection(),
              SizedBox(height: 36),
              _ConstraintsFlowSection(),
              SizedBox(height: 36),
              _RenderProxyBoxSection(),
              SizedBox(height: 36),
              _RenderConstrainedBoxSection(),
              SizedBox(height: 36),
              _RenderPaddingSection(),
              SizedBox(height: 36),
              _RenderShiftedBoxFamilySection(),
              SizedBox(height: 36),
              _RenderTransformSection(),
              SizedBox(height: 36),
              _RenderOpacitySection(),
              SizedBox(height: 36),
              _ParentDataSection(),
              SizedBox(height: 36),
              _LayoutProtocolSection(),
              SizedBox(height: 36),
              _PaintPhaseSection(),
              SizedBox(height: 36),
              _MarkNeedsSection(),
              SizedBox(height: 36),
              _PitfallsSection(),
              SizedBox(height: 36),
              _LegendSection(),
              SizedBox(height: 72),
            ],
          ),
        ),
      ),
    );
  }
}

// =====================================================================
// PALETTE — every color used in this file
// =====================================================================

class _Palette {
  static const Color ink = Color(0xFF0F172A);
  static const Color inkSoft = Color(0xFF1E293B);
  static const Color slate = Color(0xFF334155);
  static const Color mute = Color(0xFF64748B);
  static const Color paper = Color(0xFFF8FAFC);
  static const Color card = Color(0xFFFFFFFF);
  static const Color accent = Color(0xFF2563EB);
  static const Color accent2 = Color(0xFF7C3AED);
  static const Color accent3 = Color(0xFF0EA5E9);
  static const Color warm = Color(0xFFF97316);
  static const Color warm2 = Color(0xFFE11D48);
  static const Color mint = Color(0xFF10B981);
  static const Color amber = Color(0xFFF59E0B);
  static const Color line = Color(0xFFE2E8F0);
}

// =====================================================================
// SHARED PRIMITIVES — section frame, code block, label chip
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
            color: accent.withValues(alpha: 0.14),
            blurRadius: 28,
            offset: const Offset(0, 14),
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
                height: 24,
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
              _SectionTagChip(label: tag, color: accent),
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

class _SectionTagChip extends StatelessWidget {
  const _SectionTagChip({required this.label, required this.color});

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
            color.withValues(alpha: 0.08),
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
            color: const Color(0xFF0B1224).withValues(alpha: 0.4),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              _CodeDot(color: const Color(0xFFEF4444)),
              const SizedBox(width: 6),
              _CodeDot(color: const Color(0xFFF59E0B)),
              const SizedBox(width: 6),
              _CodeDot(color: const Color(0xFF22C55E)),
              const SizedBox(width: 12),
              Text(
                caption ?? 'snippet.dart',
                style: const TextStyle(
                  color: Color(0xFF94A3B8),
                  fontFamily: 'monospace',
                  fontSize: 11,
                  letterSpacing: 0.6,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            code,
            style: const TextStyle(
              color: Color(0xFFE2E8F0),
              fontFamily: 'monospace',
              fontSize: 12.5,
              height: 1.55,
            ),
          ),
        ],
      ),
    );
  }
}

class _CodeDot extends StatelessWidget {
  const _CodeDot({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}

class _LabelChip extends StatelessWidget {
  const _LabelChip({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w700,
          fontSize: 11,
          letterSpacing: 0.6,
        ),
      ),
    );
  }
}

class _BulletLine extends StatelessWidget {
  const _BulletLine({required this.text, required this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 7),
            child: Container(
              width: 7,
              height: 7,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 13.5,
                height: 1.55,
                color: _Palette.slate,
              ),
            ),
          ),
        ],
      ),
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
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Color(0xFF0F172A),
            Color(0xFF1E3A8A),
            Color(0xFF7C3AED),
          ],
          stops: <double>[0.0, 0.55, 1.0],
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color(0x551E3A8A),
            blurRadius: 36,
            offset: Offset(0, 18),
          ),
          BoxShadow(
            color: Color(0x337C3AED),
            blurRadius: 18,
            offset: Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(28, 28, 28, 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.28),
                  ),
                ),
                child: const Text(
                  'package:flutter/rendering.dart',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.0,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF97316).withValues(alpha: 0.85),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const Text(
                  'BASIC SET',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.4,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          const Text(
            'RenderObjects, the Basic Family',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              height: 1.1,
              letterSpacing: -0.6,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'A guided tour of RenderObject, RenderBox, and the proxy / shifted '
            'subclasses that power Padding, ConstrainedBox, Center, '
            'Transform, and Opacity. Constraints flow down. Sizes flow up. '
            'Parents position their children.',
            style: TextStyle(
              fontSize: 15,
              color: Color(0xFFCBD5E1),
              height: 1.55,
            ),
          ),
          const SizedBox(height: 22),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: const <Widget>[
              _LabelChip(label: 'RenderObject', color: Color(0xFF60A5FA)),
              _LabelChip(label: 'RenderBox', color: Color(0xFF93C5FD)),
              _LabelChip(label: 'RenderProxyBox', color: Color(0xFFA78BFA)),
              _LabelChip(label: 'RenderShiftedBox', color: Color(0xFFF472B6)),
              _LabelChip(
                label: 'RenderConstrainedBox',
                color: Color(0xFFFBBF24),
              ),
              _LabelChip(label: 'RenderPadding', color: Color(0xFFFB923C)),
              _LabelChip(label: 'RenderTransform', color: Color(0xFF34D399)),
              _LabelChip(label: 'RenderOpacity', color: Color(0xFF22D3EE)),
            ],
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// 2. THREE TREES — Widget / Element / RenderObject
// =====================================================================

class _ThreeTreesSection extends StatelessWidget {
  const _ThreeTreesSection();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      tag: '02 · MENTAL MODEL',
      title: 'The Three Trees',
      subtitle: 'Every Flutter app maintains three parallel trees that talk '
          'to each other. The Widget tree is a recipe; the Element tree is '
          'the running instance; the RenderObject tree does the layout, '
          'painting and hit-testing.',
      accent: _Palette.accent,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            Expanded(
              child: _TreeColumn(
                title: 'Widget',
                subtitle: 'immutable description',
                color: Color(0xFF60A5FA),
                bullets: <String>[
                  'const where possible',
                  'cheap to build',
                  'rebuilt every frame',
                  'just data — no state',
                ],
                rootLabel: 'MaterialApp',
                children: <String>[
                  'Scaffold',
                  'Padding',
                  'Center',
                  'Text',
                ],
              ),
            ),
            SizedBox(width: 14),
            Expanded(
              child: _TreeColumn(
                title: 'Element',
                subtitle: 'living instance',
                color: Color(0xFFA78BFA),
                bullets: <String>[
                  'mounted to the tree',
                  'holds State / Build slot',
                  'connects widget ↔ render',
                  'recycled across rebuilds',
                ],
                rootLabel: 'StatefulElement',
                children: <String>[
                  'StatelessElement',
                  'SingleChildElement',
                  'SingleChildElement',
                  'LeafElement',
                ],
              ),
            ),
            SizedBox(width: 14),
            Expanded(
              child: _TreeColumn(
                title: 'RenderObject',
                subtitle: 'layout & paint',
                color: Color(0xFFF472B6),
                bullets: <String>[
                  'attach / detach',
                  'layout(constraints)',
                  'paint(canvas, offset)',
                  'hitTest(result)',
                ],
                rootLabel: 'RenderView',
                children: <String>[
                  'RenderRepaintBoundary',
                  'RenderPadding',
                  'RenderPositionedBox',
                  'RenderParagraph',
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 22),
        _CodeBlock(
          caption: 'three_trees.dart',
          code: 'Widget       → just a description (createElement → ...)\n'
              'Element      → manages lifecycle (mount, update, unmount)\n'
              'RenderObject → does the work (layout, paint, hitTest)\n'
              '\n'
              '// Each Widget creates an Element via createElement().\n'
              '// Each RenderObjectWidget creates a RenderObject via\n'
              '// createRenderObject(BuildContext) and is then kept in sync\n'
              '// by updateRenderObject(BuildContext, RenderObject).',
        ),
        const SizedBox(height: 18),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFEFF6FF),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFBFDBFE)),
          ),
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              Icon(Icons.lightbulb, color: Color(0xFF2563EB), size: 22),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Rule of thumb: Widgets you write. Elements you rarely '
                  'touch. RenderObjects you study when something looks '
                  'wrong on screen, when you need a custom layout, or when '
                  'you are profiling a slow paint.',
                  style: TextStyle(
                    fontSize: 13.5,
                    height: 1.55,
                    color: _Palette.inkSoft,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TreeColumn extends StatelessWidget {
  const _TreeColumn({
    required this.title,
    required this.subtitle,
    required this.color,
    required this.bullets,
    required this.rootLabel,
    required this.children,
  });

  final String title;
  final String subtitle;
  final Color color;
  final List<String> bullets;
  final String rootLabel;
  final List<String> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            color.withValues(alpha: 0.16),
            color.withValues(alpha: 0.04),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.4)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: color.withValues(alpha: 0.15),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: color,
              letterSpacing: -0.2,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 11,
              color: _Palette.mute,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: 12),
          for (final String b in bullets)
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Container(
                      width: 5,
                      height: 5,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      b,
                      style: const TextStyle(
                        fontSize: 11.5,
                        height: 1.4,
                        color: _Palette.slate,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 10),
          _MiniTreeNode(label: rootLabel, color: color, isRoot: true),
          for (final String c in children) ...<Widget>[
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.only(left: 14),
              child: _MiniTreeNode(label: c, color: color),
            ),
          ],
        ],
      ),
    );
  }
}

class _MiniTreeNode extends StatelessWidget {
  const _MiniTreeNode({
    required this.label,
    required this.color,
    this.isRoot = false,
  });

  final String label;
  final Color color;
  final bool isRoot;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: isRoot
            ? color.withValues(alpha: 0.22)
            : color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: color.withValues(alpha: isRoot ? 0.55 : 0.3),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 10.5,
          fontWeight: isRoot ? FontWeight.w800 : FontWeight.w600,
          color: _Palette.ink,
        ),
      ),
    );
  }
}

// =====================================================================
// 3. RENDEROBJECT ANATOMY — lifecycle stages
// =====================================================================

class _RenderObjectAnatomySection extends StatelessWidget {
  const _RenderObjectAnatomySection();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      tag: '03 · ANATOMY',
      title: 'RenderObject Lifecycle',
      subtitle: 'Every RenderObject moves through six well-defined stages '
          'between construction and disposal. Each stage has a contract; '
          'each contract has invariants that the framework enforces with '
          'assertions in debug mode.',
      accent: _Palette.accent2,
      children: <Widget>[
        Column(
          children: const <Widget>[
            _LifecycleRow(
              index: '01',
              name: 'attach',
              color: Color(0xFF60A5FA),
              summary: 'Object is added to a PipelineOwner. '
                  'owner != null. The object can now schedule layout, '
                  'paint, and semantics updates.',
              snippet: 'void attach(PipelineOwner owner) {\n'
                  '  super.attach(owner);\n'
                  '  // walk children, attach each, register with owner\n'
                  '}',
            ),
            _LifecycleRow(
              index: '02',
              name: 'layout',
              color: Color(0xFFA78BFA),
              summary: 'Parent calls child.layout(constraints, '
                  'parentUsesSize: bool). Child computes its size and may '
                  'call layout on its own children. Constraints flow DOWN; '
                  'sizes flow UP.',
              snippet: 'void layout(Constraints constraints,\n'
                  '            { bool parentUsesSize = false }) {\n'
                  '  // performResize / performLayout (RenderBox)\n'
                  '}',
            ),
            _LifecycleRow(
              index: '03',
              name: 'paint',
              color: Color(0xFFF472B6),
              summary: 'PaintingContext walks the tree and asks each render '
                  'object to paint(context, offset). Painting is in screen '
                  'space; the offset is relative to the parent layer.',
              snippet: 'void paint(PaintingContext context, Offset offset) {\n'
                  '  // context.canvas.draw...\n'
                  '  // context.paintChild(child, offset + childOffset)\n'
                  '}',
            ),
            _LifecycleRow(
              index: '04',
              name: 'semantics',
              color: Color(0xFFFBBF24),
              summary: 'A separate semantics tree is built for screen '
                  'readers. Each RenderObject contributes via '
                  'describeSemanticsConfiguration / visitChildrenForSemantics.',
              snippet: 'void describeSemanticsConfiguration(\n'
                  '    SemanticsConfiguration config) {\n'
                  '  config.label = "...";\n'
                  '  config.isButton = true;\n'
                  '}',
            ),
            _LifecycleRow(
              index: '05',
              name: 'hitTest',
              color: Color(0xFFFB923C),
              summary: 'When a pointer event lands, the framework walks the '
                  'tree from root to leaves calling hitTest(result, '
                  'position). Render objects that report a hit get the '
                  'gesture.',
              snippet: 'bool hitTest(BoxHitTestResult result,\n'
                  '             { required Offset position }) {\n'
                  '  // check children first, then self\n'
                  '  return /* hit? */ false;\n'
                  '}',
            ),
            _LifecycleRow(
              index: '06',
              name: 'detach',
              color: Color(0xFF34D399),
              summary: 'Object is removed from the pipeline. owner becomes '
                  'null. Layers are released. The render object can later '
                  'be re-attached to a new tree.',
              snippet: 'void detach() {\n'
                  '  // walk children, detach each\n'
                  '  super.detach();\n'
                  '}',
            ),
          ],
        ),
      ],
    );
  }
}

class _LifecycleRow extends StatelessWidget {
  const _LifecycleRow({
    required this.index,
    required this.name,
    required this.color,
    required this.summary,
    required this.snippet,
  });

  final String index;
  final String name;
  final Color color;
  final String summary;
  final String snippet;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Container(
        decoration: BoxDecoration(
          color: _Palette.paper,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _Palette.line),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: color.withValues(alpha: 0.10),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 56,
              height: 56,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    color,
                    color.withValues(alpha: 0.65),
                  ],
                ),
                borderRadius: BorderRadius.circular(14),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: color.withValues(alpha: 0.4),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Text(
                index,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        name,
                        style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                          letterSpacing: -0.2,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.14),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          'stage',
                          style: TextStyle(
                            color: color,
                            fontWeight: FontWeight.w700,
                            fontSize: 9.5,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    summary,
                    style: const TextStyle(
                      color: _Palette.slate,
                      fontSize: 13,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _CodeBlock(code: snippet, caption: '$name.dart'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =====================================================================
// 4. CONSTRAINTS FLOW — the layout protocol diagram
// =====================================================================

class _ConstraintsFlowSection extends StatelessWidget {
  const _ConstraintsFlowSection();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      tag: '04 · PROTOCOL',
      title: 'Constraints go down. Sizes go up. Parent positions.',
      subtitle: 'The first sentence of every Flutter layout talk. The parent '
          'hands the child a BoxConstraints. The child returns a Size that '
          'fits inside those constraints. The parent then assigns each '
          'child an Offset — not the child itself.',
      accent: _Palette.accent3,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                Color(0xFFF0F9FF),
                Color(0xFFEFF6FF),
              ],
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFBAE6FD)),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              _FlowNode(
                label: 'Parent (RenderBox)',
                color: _Palette.accent,
                detail: 'min: (0, 0) … max: (300, 200)',
              ),
              _FlowArrow(
                label: 'constraints',
                detail: 'BoxConstraints',
                color: _Palette.accent,
                downward: true,
              ),
              _FlowNode(
                label: 'Child (RenderBox)',
                color: _Palette.accent2,
                detail: 'computeDryLayout / performLayout',
              ),
              _FlowArrow(
                label: 'size',
                detail: 'Size(160, 80)',
                color: _Palette.accent2,
                downward: false,
              ),
              _FlowNode(
                label: 'Parent assigns offset',
                color: _Palette.warm,
                detail: 'child.parentData.offset = Offset(20, 30)',
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        _CodeBlock(
          caption: 'layout_protocol.dart',
          code: '// Pseudo-code, taken from the BOX layout contract:\n'
              '\n'
              'void performLayout() {\n'
              '  final BoxConstraints incoming = constraints;\n'
              '  child!.layout(incoming, parentUsesSize: true);\n'
              '  size = incoming.constrain(child!.size);\n'
              '\n'
              '  final BoxParentData pd = child!.parentData! as BoxParentData;\n'
              '  pd.offset = Offset(/* parent decides */);\n'
              '}\n'
              '\n'
              '// `parentUsesSize: true` is essential — without it, a child\n'
              '// resize will not invalidate the parent. Use it whenever\n'
              '// performLayout reads child.size.',
        ),
        const SizedBox(height: 18),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            Expanded(
              child: _RuleCard(
                title: 'Tight constraints',
                color: Color(0xFF2563EB),
                example: 'min == max',
                explanation: 'Child has no choice. Used by SizedBox, '
                    'ConstrainedBox(BoxConstraints.tight(...)), and the '
                    'inside of a flex item with Expanded.',
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _RuleCard(
                title: 'Loose constraints',
                color: Color(0xFF7C3AED),
                example: 'min == 0, max > 0',
                explanation: 'Child can be any size up to max. Used by '
                    'Padding, Center, Align, and the inside of a Stack '
                    'unless StackFit.expand is set.',
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _RuleCard(
                title: 'Unbounded',
                color: Color(0xFFE11D48),
                example: 'max == infinity',
                explanation: 'Common in scroll views. The child must shrink-'
                    'wrap or the layout asserts. Trying to render an '
                    'infinite-height Column inside a ListView is the '
                    'canonical mistake.',
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _FlowNode extends StatelessWidget {
  const _FlowNode({
    required this.label,
    required this.color,
    required this.detail,
  });

  final String label;
  final Color color;
  final String detail;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            color.withValues(alpha: 0.18),
            color.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.45)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: color.withValues(alpha: 0.18),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: color,
              fontSize: 14,
              letterSpacing: -0.1,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            detail,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              color: _Palette.slate,
            ),
          ),
        ],
      ),
    );
  }
}

class _FlowArrow extends StatelessWidget {
  const _FlowArrow({
    required this.label,
    required this.detail,
    required this.color,
    required this.downward,
  });

  final String label;
  final String detail;
  final Color color;
  final bool downward;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: <Widget>[
          const SizedBox(width: 24),
          Container(
            width: 2,
            height: 26,
            color: color.withValues(alpha: 0.4),
          ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: color.withValues(alpha: 0.4)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  downward ? Icons.south : Icons.north,
                  size: 14,
                  color: color,
                ),
                const SizedBox(width: 6),
                Text(
                  label,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w800,
                    fontSize: 11,
                    letterSpacing: 0.6,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  detail,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11,
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

class _RuleCard extends StatelessWidget {
  const _RuleCard({
    required this.title,
    required this.color,
    required this.example,
    required this.explanation,
  });

  final String title;
  final Color color;
  final String example;
  final String explanation;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _Palette.paper,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.4)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: color.withValues(alpha: 0.12),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w800,
              fontSize: 14,
              letterSpacing: -0.1,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              example,
              style: TextStyle(
                color: color,
                fontFamily: 'monospace',
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            explanation,
            style: const TextStyle(
              color: _Palette.slate,
              fontSize: 12.5,
              height: 1.55,
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// 5. RENDER PROXY BOX SECTION
// =====================================================================

class _RenderProxyBoxSection extends StatelessWidget {
  const _RenderProxyBoxSection();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      tag: '05 · RENDERPROXYBOX',
      title: 'RenderProxyBox — single-child, same constraints',
      subtitle: 'A RenderProxyBox holds exactly one child and forwards the '
          'constraints to it unchanged. Its size becomes the child\'s size. '
          'Almost every "decorator" RenderObject (Opacity, ClipRect, '
          'ColorFiltered, BackdropFilter, RotatedBox\'s wrapper…) extends '
          'RenderProxyBox.',
      accent: _Palette.accent2,
      children: <Widget>[
        _CodeBlock(
          caption: 'render_proxy_box.dart',
          code: 'abstract class RenderProxyBox extends RenderBox\n'
              '    with RenderObjectWithChildMixin<RenderBox>,\n'
              '         RenderProxyBoxMixin {\n'
              '\n'
              '  // performLayout simply delegates to the child:\n'
              '  @override\n'
              '  void performLayout() {\n'
              '    if (child != null) {\n'
              '      child!.layout(constraints, parentUsesSize: true);\n'
              '      size = child!.size;\n'
              '    } else {\n'
              '      size = computeSizeForNoChild(constraints);\n'
              '    }\n'
              '  }\n'
              '\n'
              '  // paint walks straight through:\n'
              '  @override\n'
              '  void paint(PaintingContext context, Offset offset) {\n'
              '    if (child != null) context.paintChild(child!, offset);\n'
              '  }\n'
              '}',
        ),
        const SizedBox(height: 18),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            Expanded(
              child: _ProxyBoxSwatch(
                title: 'RenderOpacity',
                widgetForm: 'Opacity(opacity: ...)',
                color: Color(0xFF22D3EE),
                gradient: <Color>[Color(0xFFCFFAFE), Color(0xFFE0F2FE)],
                summary: 'Wraps child in an OpacityLayer when alpha is in '
                    '(0, 1). Skips paint entirely when alpha == 0.',
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _ProxyBoxSwatch(
                title: 'RenderTransform',
                widgetForm: 'Transform(transform: M)',
                color: Color(0xFF34D399),
                gradient: <Color>[Color(0xFFD1FAE5), Color(0xFFECFDF5)],
                summary: 'Pushes a TransformLayer with a 4×4 matrix. '
                    'Constraints are still forwarded as-is to the child.',
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _ProxyBoxSwatch(
                title: 'RenderClipRect',
                widgetForm: 'ClipRect()',
                color: Color(0xFFA78BFA),
                gradient: <Color>[Color(0xFFEDE9FE), Color(0xFFF5F3FF)],
                summary: 'Applies a ClipRectLayer at paint time. Layout is '
                    'unchanged — clipping is purely a paint-side concern.',
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFFFF7ED),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFFED7AA)),
          ),
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              Icon(Icons.bolt, color: Color(0xFFEA580C), size: 22),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Performance: a RenderProxyBox is essentially free at '
                  'layout — one delegated layout() call. The cost is '
                  'almost always at paint time, when a layer is pushed '
                  '(Opacity, Transform, ClipPath…). RepaintBoundary is '
                  'also a RenderProxyBox: zero layout impact, but a real '
                  'compositing-layer separation.',
                  style: TextStyle(
                    fontSize: 13.5,
                    height: 1.55,
                    color: _Palette.inkSoft,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ProxyBoxSwatch extends StatelessWidget {
  const _ProxyBoxSwatch({
    required this.title,
    required this.widgetForm,
    required this.color,
    required this.gradient,
    required this.summary,
  });

  final String title;
  final String widgetForm;
  final Color color;
  final List<Color> gradient;
  final String summary;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradient,
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.5)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: color.withValues(alpha: 0.18),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.w800,
              fontSize: 13.5,
              color: _Palette.ink,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              widgetForm,
              style: TextStyle(
                fontFamily: 'monospace',
                fontWeight: FontWeight.w700,
                fontSize: 10.5,
                color: color,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            summary,
            style: const TextStyle(
              fontSize: 12,
              color: _Palette.slate,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// 6. RENDER CONSTRAINED BOX
// =====================================================================

class _RenderConstrainedBoxSection extends StatelessWidget {
  const _RenderConstrainedBoxSection();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      tag: '06 · RENDERCONSTRAINEDBOX',
      title: 'RenderConstrainedBox — tighten or loosen, then delegate',
      subtitle: 'RenderConstrainedBox holds an additional `additionalConstraints` '
          'field. At layout time it intersects the incoming constraints '
          'with this field, then asks the child to lay out under the '
          'narrower constraints. SizedBox, ConstrainedBox, and Container '
          '(when sizing properties are set) all create one of these.',
      accent: _Palette.amber,
      children: <Widget>[
        _CodeBlock(
          caption: 'render_constrained_box.dart',
          code: 'class RenderConstrainedBox extends RenderProxyBox {\n'
              '  RenderConstrainedBox({ required BoxConstraints additional });\n'
              '\n'
              '  BoxConstraints additionalConstraints;\n'
              '\n'
              '  @override\n'
              '  void performLayout() {\n'
              '    final BoxConstraints incoming = constraints;\n'
              '    final BoxConstraints merged =\n'
              '        additionalConstraints.enforce(incoming);\n'
              '    if (child != null) {\n'
              '      child!.layout(merged, parentUsesSize: true);\n'
              '      size = child!.size;\n'
              '    } else {\n'
              '      size = merged.constrain(Size.zero);\n'
              '    }\n'
              '  }\n'
              '}',
        ),
        const SizedBox(height: 18),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: <Widget>[
            _ConstraintChip(
              label: 'SizedBox(width: 100, height: 100)',
              tight: true,
              color: _Palette.accent,
            ),
            _ConstraintChip(
              label: 'SizedBox.expand',
              tight: true,
              color: _Palette.accent,
            ),
            _ConstraintChip(
              label: 'ConstrainedBox(BoxConstraints(minWidth: 200))',
              tight: false,
              color: _Palette.amber,
            ),
            _ConstraintChip(
              label: 'ConstrainedBox(BoxConstraints.loose(Size(300, 200)))',
              tight: false,
              color: _Palette.amber,
            ),
            _ConstraintChip(
              label: 'Container(width: 120, height: 60)',
              tight: true,
              color: _Palette.warm,
            ),
            _ConstraintChip(
              label: 'Container(constraints: BoxConstraints(minHeight: 40))',
              tight: false,
              color: _Palette.warm,
            ),
          ],
        ),
        const SizedBox(height: 18),
        // A real, on-screen example using widgets that produce a
        // RenderConstrainedBox.
        _DemoCard(
          title: 'A SizedBox tightens both axes',
          subtitle: 'The blue box below is a SizedBox(width: 200, height: 80). '
              'The text inside has loose constraints from its parent Center '
              'but tight constraints from the SizedBox.',
          color: _Palette.accent,
          child: Center(
            child: Container(
              width: 220,
              height: 88,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    Color(0xFF3B82F6),
                    Color(0xFF2563EB),
                  ],
                ),
                borderRadius: BorderRadius.circular(14),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Color(0x442563EB),
                    blurRadius: 16,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: const Text(
                'tight: 200×80',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ConstraintChip extends StatelessWidget {
  const _ConstraintChip({
    required this.label,
    required this.tight,
    required this.color,
  });

  final String label;
  final bool tight;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.45)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            tight ? Icons.lock : Icons.lock_open,
            size: 14,
            color: color,
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: _Palette.ink,
              fontFamily: 'monospace',
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.25),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              tight ? 'TIGHT' : 'LOOSE',
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w800,
                fontSize: 9.5,
                letterSpacing: 0.8,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DemoCard extends StatelessWidget {
  const _DemoCard({
    required this.title,
    required this.subtitle,
    required this.color,
    required this.child,
  });

  final String title;
  final String subtitle;
  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _Palette.paper,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.35)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: color.withValues(alpha: 0.15),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w800,
              fontSize: 14,
              letterSpacing: -0.1,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(
              color: _Palette.slate,
              fontSize: 12.5,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 14),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(20),
            child: child,
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// 7. RENDER PADDING
// =====================================================================

class _RenderPaddingSection extends StatelessWidget {
  const _RenderPaddingSection();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      tag: '07 · RENDERPADDING',
      title: 'RenderPadding — first taste of RenderShiftedBox',
      subtitle: 'RenderPadding is the canonical RenderShiftedBox. It '
          'subtracts the inset from the incoming constraints, lays out the '
          'child under those tighter constraints, then offsets the child '
          'by (left, top). Its own size is child.size + horizontal + '
          'vertical.',
      accent: _Palette.warm,
      children: <Widget>[
        _CodeBlock(
          caption: 'render_padding.dart',
          code: 'class RenderPadding extends RenderShiftedBox {\n'
              '  EdgeInsets get padding => _resolvedPadding!;\n'
              '\n'
              '  @override\n'
              '  void performLayout() {\n'
              '    final EdgeInsets pad = padding;\n'
              '    if (child == null) {\n'
              '      size = constraints.constrain(\n'
              '          Size(pad.horizontal, pad.vertical));\n'
              '      return;\n'
              '    }\n'
              '    final BoxConstraints inner = constraints.deflate(pad);\n'
              '    child!.layout(inner, parentUsesSize: true);\n'
              '    final BoxParentData pd = child!.parentData! as BoxParentData;\n'
              '    pd.offset = Offset(pad.left, pad.top);\n'
              '    size = constraints.constrain(Size(\n'
              '      pad.horizontal + child!.size.width,\n'
              '      pad.vertical   + child!.size.height,\n'
              '    ));\n'
              '  }\n'
              '}',
        ),
        const SizedBox(height: 18),
        _DemoCard(
          title: 'Padding(EdgeInsets.all(20))',
          subtitle: 'The inner pink box gets constraints of '
              'parentMax - 40 on each axis. RenderPadding then sets the '
              'child\'s parentData.offset to (20, 20) so it visually '
              'sits inside the orange frame.',
          color: _Palette.warm,
          child: Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  Color(0xFFFFEDD5),
                  Color(0xFFFED7AA),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFFB923C)),
            ),
            padding: const EdgeInsets.all(20),
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    Color(0xFFEC4899),
                    Color(0xFFDB2777),
                  ],
                ),
                borderRadius: BorderRadius.circular(10),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Color(0x44DB2777),
                    blurRadius: 14,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: const Text(
                'child',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'monospace',
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 14),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            Expanded(
              child: _BulletList(
                color: Color(0xFFF97316),
                title: 'What it does',
                bullets: <String>[
                  'Resolves EdgeInsetsDirectional with textDirection',
                  'Deflates constraints by horizontal + vertical inset',
                  'Forwards deflated constraints to child',
                  'Stores Offset(pad.left, pad.top) in parentData',
                ],
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _BulletList(
                color: Color(0xFF7C3AED),
                title: 'What it does NOT do',
                bullets: <String>[
                  'Does not paint anything — children paint themselves',
                  'Does not introduce a new compositing layer',
                  'Does not influence hitTest beyond offsetting children',
                  'Does not cache layout across rebuilds',
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _BulletList extends StatelessWidget {
  const _BulletList({
    required this.color,
    required this.title,
    required this.bullets,
  });

  final Color color;
  final String title;
  final List<String> bullets;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _Palette.paper,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w800,
              fontSize: 13,
              letterSpacing: -0.1,
            ),
          ),
          const SizedBox(height: 8),
          for (final String b in bullets) _BulletLine(text: b, color: color),
        ],
      ),
    );
  }
}

// =====================================================================
// 8. RENDER SHIFTED BOX FAMILY — Center, Align, more
// =====================================================================

class _RenderShiftedBoxFamilySection extends StatelessWidget {
  const _RenderShiftedBoxFamilySection();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      tag: '08 · RENDERSHIFTEDBOX',
      title: 'RenderShiftedBox — the family with one shifted child',
      subtitle: 'RenderShiftedBox is the abstract base for RenderObjects '
          'that have one child whose origin may differ from (0, 0). '
          'Subclasses include RenderPadding, RenderPositionedBox (Center, '
          'Align), RenderBaseline, and RenderAligningShiftedBox.',
      accent: _Palette.warm2,
      children: <Widget>[
        _CodeBlock(
          caption: 'render_shifted_box.dart',
          code: 'abstract class RenderShiftedBox extends RenderBox\n'
              '    with RenderObjectWithChildMixin<RenderBox> {\n'
              '\n'
              '  @override\n'
              '  void paint(PaintingContext context, Offset offset) {\n'
              '    if (child != null) {\n'
              '      final BoxParentData pd =\n'
              '          child!.parentData! as BoxParentData;\n'
              '      context.paintChild(child!, offset + pd.offset);\n'
              '    }\n'
              '  }\n'
              '\n'
              '  @override\n'
              '  bool hitTestChildren(BoxHitTestResult result,\n'
              '      { required Offset position }) {\n'
              '    if (child == null) return false;\n'
              '    final BoxParentData pd =\n'
              '        child!.parentData! as BoxParentData;\n'
              '    return result.addWithPaintOffset(\n'
              '      offset: pd.offset,\n'
              '      position: position,\n'
              '      hitTest: (BoxHitTestResult r, Offset p) =>\n'
              '          child!.hitTest(r, position: p),\n'
              '    );\n'
              '  }\n'
              '}',
        ),
        const SizedBox(height: 18),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            Expanded(
              child: _ShiftedBoxCard(
                title: 'Center',
                renderType: 'RenderPositionedBox',
                color: Color(0xFFE11D48),
                description: 'alignment = Alignment.center. Loosens '
                    'constraints, lays out child, then offsets the child to '
                    'the geometric center of the available space.',
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _ShiftedBoxCard(
                title: 'Align',
                renderType: 'RenderPositionedBox',
                color: Color(0xFF9333EA),
                description: 'Same RenderObject as Center, but with a '
                    'configurable Alignment. Resolves AlignmentDirectional '
                    'with the ambient TextDirection.',
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _ShiftedBoxCard(
                title: 'Padding',
                renderType: 'RenderPadding',
                color: Color(0xFFF97316),
                description: 'Already covered above. Uses the same '
                    'BoxParentData.offset slot for its child to flow '
                    'through.',
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        _DemoCard(
          title: 'Center inside a 240×120 box',
          subtitle: 'Center receives the parent\'s constraints, loosens them '
              'to (0…240, 0…120), lays out the inner pill, then sets the '
              'child\'s offset to ((240 - childW)/2, (120 - childH)/2).',
          color: _Palette.warm2,
          child: SizedBox(
            width: 240,
            height: 120,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: <Color>[
                      Color(0xFFF43F5E),
                      Color(0xFFE11D48),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(999),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Color(0x44E11D48),
                      blurRadius: 14,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                child: const Text(
                  'centered',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'monospace',
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ShiftedBoxCard extends StatelessWidget {
  const _ShiftedBoxCard({
    required this.title,
    required this.renderType,
    required this.color,
    required this.description,
  });

  final String title;
  final String renderType;
  final Color color;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            color.withValues(alpha: 0.16),
            color.withValues(alpha: 0.04),
          ],
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w800,
              fontSize: 18,
              letterSpacing: -0.2,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              renderType,
              style: TextStyle(
                fontFamily: 'monospace',
                color: color,
                fontWeight: FontWeight.w700,
                fontSize: 10.5,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: const TextStyle(
              fontSize: 12,
              height: 1.5,
              color: _Palette.slate,
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// 9. RENDER TRANSFORM
// =====================================================================

class _RenderTransformSection extends StatelessWidget {
  const _RenderTransformSection();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      tag: '09 · RENDERTRANSFORM',
      title: 'RenderTransform — paint a 4×4 matrix',
      subtitle: 'RenderTransform is a RenderProxyBox that applies a 4×4 '
          'transformation matrix during paint. The transform does not '
          'affect layout: the child is laid out as if no transform existed, '
          'and the matrix only changes how the resulting pixels are placed.',
      accent: _Palette.mint,
      children: <Widget>[
        _CodeBlock(
          caption: 'render_transform.dart',
          code: 'class RenderTransform extends RenderProxyBox {\n'
              '  Matrix4 transform;\n'
              '  Offset? origin;\n'
              '  AlignmentGeometry? alignment;\n'
              '  TextDirection? textDirection;\n'
              '  bool transformHitTests;\n'
              '\n'
              '  @override\n'
              '  void paint(PaintingContext context, Offset offset) {\n'
              '    if (child == null) return;\n'
              '    final Matrix4 effective = _effectiveTransform();\n'
              '    if (MatrixUtils.isIdentity(effective)) {\n'
              '      context.paintChild(child!, offset);\n'
              '    } else {\n'
              '      _layer = context.pushTransform(\n'
              '        needsCompositing,\n'
              '        offset,\n'
              '        effective,\n'
              '        super.paint,\n'
              '        oldLayer: _layer,\n'
              '      );\n'
              '    }\n'
              '  }\n'
              '}',
        ),
        const SizedBox(height: 18),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            Expanded(
              child: _MatrixCard(
                title: 'Identity',
                color: Color(0xFF10B981),
                rows: <List<String>>[
                  <String>['1', '0', '0', '0'],
                  <String>['0', '1', '0', '0'],
                  <String>['0', '0', '1', '0'],
                  <String>['0', '0', '0', '1'],
                ],
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: _MatrixCard(
                title: 'Translate(20, 30)',
                color: Color(0xFF0EA5E9),
                rows: <List<String>>[
                  <String>['1', '0', '0', '20'],
                  <String>['0', '1', '0', '30'],
                  <String>['0', '0', '1', '0'],
                  <String>['0', '0', '0', '1'],
                ],
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: _MatrixCard(
                title: 'Scale(2x, 2x)',
                color: Color(0xFF7C3AED),
                rows: <List<String>>[
                  <String>['2', '0', '0', '0'],
                  <String>['0', '2', '0', '0'],
                  <String>['0', '0', '1', '0'],
                  <String>['0', '0', '0', '1'],
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        _DemoCard(
          title: 'Transform.rotate(angle: 0.18)',
          subtitle: 'The teal card below is rotated visually but its '
              'layout slot is still axis-aligned. A sibling laid out next '
              'to it would not see the rotation in its constraints.',
          color: _Palette.mint,
          child: Center(
            child: Transform.rotate(
              angle: 0.18,
              child: Container(
                width: 220,
                height: 90,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                      Color(0xFF14B8A6),
                      Color(0xFF0F766E),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Color(0x440F766E),
                      blurRadius: 18,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: const Text(
                  'rotated by paint',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'monospace',
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _MatrixCard extends StatelessWidget {
  const _MatrixCard({
    required this.title,
    required this.color,
    required this.rows,
  });

  final String title;
  final Color color;
  final List<List<String>> rows;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _Palette.paper,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.45)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: color.withValues(alpha: 0.12),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w800,
              fontSize: 12.5,
            ),
          ),
          const SizedBox(height: 8),
          for (final List<String> row in rows)
            Padding(
              padding: const EdgeInsets.only(bottom: 3),
              child: Row(
                children: <Widget>[
                  for (final String cell in row)
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 1.5),
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.10),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          cell,
                          style: TextStyle(
                            color: color,
                            fontFamily: 'monospace',
                            fontWeight: FontWeight.w800,
                            fontSize: 11,
                          ),
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

// =====================================================================
// 10. RENDER OPACITY
// =====================================================================

class _RenderOpacitySection extends StatelessWidget {
  const _RenderOpacitySection();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      tag: '10 · RENDEROPACITY',
      title: 'RenderOpacity — saveLayer when needed, otherwise nothing',
      subtitle: 'RenderOpacity is a RenderProxyBox that paints an '
          'OpacityLayer when alpha is strictly between 0 and 255. At alpha '
          '== 0 it skips paint entirely. At alpha == 255 (fully opaque) it '
          'just delegates to the child without a layer.',
      accent: _Palette.accent3,
      children: <Widget>[
        _CodeBlock(
          caption: 'render_opacity.dart',
          code: 'class RenderOpacity extends RenderProxyBox {\n'
              '  double opacity;\n'
              '  bool alwaysIncludeSemantics;\n'
              '\n'
              '  @override\n'
              '  bool get alwaysNeedsCompositing =>\n'
              '      child != null && _alpha != 0 && _alpha != 255;\n'
              '\n'
              '  @override\n'
              '  void paint(PaintingContext context, Offset offset) {\n'
              '    if (child == null || _alpha == 0) return;\n'
              '    if (_alpha == 255) {\n'
              '      context.paintChild(child!, offset);\n'
              '      return;\n'
              '    }\n'
              '    _layer = context.pushOpacity(\n'
              '      offset,\n'
              '      _alpha,\n'
              '      super.paint,\n'
              '      oldLayer: _layer,\n'
              '    );\n'
              '  }\n'
              '}',
        ),
        const SizedBox(height: 18),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            for (final double a in const <double>[0.15, 0.45, 0.75, 1.0])
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: _OpacitySwatch(opacity: a),
                ),
              ),
          ],
        ),
        const SizedBox(height: 18),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFFEF3C7),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFFCD34D)),
          ),
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              Icon(Icons.warning_amber, color: Color(0xFFB45309), size: 22),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Opacity is expensive. The OpacityLayer forces a '
                  'saveLayer() into an offscreen buffer, then composites it '
                  'back. For animating fade-in/out on a leaf, prefer '
                  'AnimatedOpacity with a child that is itself a '
                  'RepaintBoundary, or use FadeTransition with a '
                  'CompositedTransformFollower for sticky regions.',
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.55,
                    color: _Palette.inkSoft,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _OpacitySwatch extends StatelessWidget {
  const _OpacitySwatch({required this.opacity});

  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _Palette.paper,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _Palette.line),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        children: <Widget>[
          Container(
            height: 70,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  const Color(0xFF0EA5E9).withValues(alpha: opacity),
                  const Color(0xFF2563EB).withValues(alpha: opacity),
                ],
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: Text(
              opacity.toStringAsFixed(2),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontFamily: 'monospace',
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            opacity == 1.0
                ? 'no layer'
                : opacity == 0.0
                    ? 'paint skipped'
                    : 'OpacityLayer',
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: _Palette.mute,
              letterSpacing: 0.4,
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// 11. PARENT DATA — Stack as the canonical example
// =====================================================================

class _ParentDataSection extends StatelessWidget {
  const _ParentDataSection();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      tag: '11 · PARENTDATA',
      title: 'parentData — the slot the parent owns on each child',
      subtitle: 'Every RenderObject has a `parentData` field, set by the '
          'parent in setupParentData(). It is how a parent stores per-child '
          'layout state without subclassing the child. RenderBox children '
          'use BoxParentData (just an offset). Stack uses '
          'StackParentData (offset + top/right/bottom/left/width/height).',
      accent: Color(0xFF9333EA),
      children: <Widget>[
        _CodeBlock(
          caption: 'parent_data.dart',
          code: '// Base RenderObject API:\n'
              'abstract class RenderObject {\n'
              '  ParentData? parentData;\n'
              '\n'
              '  @protected\n'
              '  void setupParentData(covariant RenderObject child) {\n'
              '    if (child.parentData is! BoxParentData) {\n'
              '      child.parentData = BoxParentData();\n'
              '    }\n'
              '  }\n'
              '}\n'
              '\n'
              '// RenderStack uses a richer subclass:\n'
              'class StackParentData extends ContainerBoxParentData<RenderBox> {\n'
              '  double? top;\n'
              '  double? right;\n'
              '  double? bottom;\n'
              '  double? left;\n'
              '  double? width;\n'
              '  double? height;\n'
              '}\n'
              '\n'
              '// Children of Stack carry that data — the Positioned widget\n'
              '// is a ParentDataWidget that mutates it during element\n'
              '// reconciliation.',
        ),
        const SizedBox(height: 18),
        _DemoCard(
          title: 'Stack with two Positioned children',
          subtitle: 'Each Positioned widget writes into its child '
              'RenderBox\'s StackParentData. RenderStack reads those fields '
              'during performLayout to compute offsets.',
          color: const Color(0xFF9333EA),
          child: SizedBox(
            height: 160,
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: <Color>[
                        Color(0xFFEDE9FE),
                        Color(0xFFF5F3FF),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Positioned(
                  top: 14,
                  left: 14,
                  child: _StackBadge(
                    label: 'top: 14, left: 14',
                    color: const Color(0xFF9333EA),
                  ),
                ),
                Positioned(
                  bottom: 14,
                  right: 14,
                  child: _StackBadge(
                    label: 'bottom: 14, right: 14',
                    color: const Color(0xFF7C3AED),
                  ),
                ),
                const Center(
                  child: Text(
                    'StackParentData',
                    style: TextStyle(
                      color: Color(0xFF6B21A8),
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 14),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            Expanded(
              child: _BulletList(
                color: Color(0xFF9333EA),
                title: 'ParentDataWidget pattern',
                bullets: <String>[
                  'Positioned ⇒ StackParentData',
                  'Flexible / Expanded ⇒ FlexParentData',
                  'TableCell ⇒ TableCellParentData',
                  'KeepAlive ⇒ KeepAliveParentDataMixin',
                ],
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _BulletList(
                color: Color(0xFF7C3AED),
                title: 'Why it matters',
                bullets: <String>[
                  'Avoids subclassing the child render object',
                  'Lets one widget tree drive many parent semantics',
                  'Per-child state survives across rebuilds',
                  'Used by accessibility / hit-test traversal too',
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _StackBadge extends StatelessWidget {
  const _StackBadge({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            color,
            color.withValues(alpha: 0.7),
          ],
        ),
        borderRadius: BorderRadius.circular(999),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: color.withValues(alpha: 0.4),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontFamily: 'monospace',
          fontWeight: FontWeight.w800,
          fontSize: 11,
        ),
      ),
    );
  }
}

// =====================================================================
// 12. LAYOUT PROTOCOL — pseudo-code card
// =====================================================================

class _LayoutProtocolSection extends StatelessWidget {
  const _LayoutProtocolSection();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      tag: '12 · LAYOUT',
      title: 'The full layout protocol, in pseudo-code',
      subtitle: 'Reading this as a single sequence makes the contract '
          'click. Note where parentUsesSize matters and where '
          'computeDryLayout / computeMaxIntrinsicWidth come into play.',
      accent: _Palette.accent,
      children: <Widget>[
        _CodeBlock(
          caption: 'layout_pseudo.dart',
          code: '// PARENT, in performLayout:\n'
              'final BoxConstraints incoming = constraints;\n'
              'BoxConstraints childConstraints = ...; // tighten/loose/shift\n'
              'child.layout(childConstraints, parentUsesSize: true);\n'
              '\n'
              '// CHILD\'s layout method (RenderBox):\n'
              'void layout(BoxConstraints c, { bool parentUsesSize = false }) {\n'
              '  if (sizedByParent) {\n'
              '    performResize(); // size depends only on constraints\n'
              '  }\n'
              '  performLayout(); // size depends on children\n'
              '}\n'
              '\n'
              '// PARENT, after child.layout returns:\n'
              'final Size childSize = child.size;\n'
              'final BoxParentData pd = child.parentData! as BoxParentData;\n'
              'pd.offset = ...; // parent decides position\n'
              'size = incoming.constrain(...);\n'
              '\n'
              '// PAINT phase happens later:\n'
              'context.paintChild(child, offset + pd.offset);',
        ),
        const SizedBox(height: 18),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            Expanded(
              child: _BulletList(
                color: Color(0xFF2563EB),
                title: 'Invariants',
                bullets: <String>[
                  'A child can never read its parent\'s constraints',
                  'A parent can only read child.size if parentUsesSize: true',
                  'A child must respect its constraints — the framework asserts',
                  'Layout is single-pass — no relayout up the tree',
                ],
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _BulletList(
                color: Color(0xFF0EA5E9),
                title: 'Special hooks',
                bullets: <String>[
                  'computeDryLayout — size without performing layout',
                  'computeMinIntrinsicWidth / Height — for IntrinsicHeight',
                  'computeMaxIntrinsicWidth / Height — for shrink-wrap rows',
                  'sizedByParent — fast path; size only depends on incoming',
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// =====================================================================
// 13. PAINT PHASE
// =====================================================================

class _PaintPhaseSection extends StatelessWidget {
  const _PaintPhaseSection();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      tag: '13 · PAINT',
      title: 'The paint phase — context, canvas, layers',
      subtitle: 'Once layout is complete, the framework walks the tree and '
          'asks each RenderObject to paint(PaintingContext, Offset). The '
          'context exposes a Canvas for raster ops and a set of pushXxx '
          'helpers for compositing layers. RenderObjects that need a '
          'compositing layer override needsCompositing.',
      accent: _Palette.accent2,
      children: <Widget>[
        _CodeBlock(
          caption: 'paint_phase.dart',
          code: 'void paint(PaintingContext context, Offset offset) {\n'
              '  // Direct draw (no compositing layer):\n'
              '  context.canvas.drawRect(\n'
              '    offset & size,\n'
              '    Paint()..color = const Color(0xFF2563EB),\n'
              '  );\n'
              '\n'
              '  // Forward to a child:\n'
              '  if (child != null) {\n'
              '    final BoxParentData pd =\n'
              '        child!.parentData! as BoxParentData;\n'
              '    context.paintChild(child!, offset + pd.offset);\n'
              '  }\n'
              '\n'
              '  // Push a compositing layer (Opacity / Transform / Clip):\n'
              '  _layer = context.pushOpacity(\n'
              '    offset, alpha, super.paint, oldLayer: _layer,\n'
              '  );\n'
              '}',
        ),
        const SizedBox(height: 18),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            Expanded(
              child: _PaintMethodCard(
                method: 'paintChild',
                color: Color(0xFF2563EB),
                description: 'Recursive walk. Forwards to the child\'s '
                    'paint method. No compositing cost. Used by every '
                    'container-style RenderObject.',
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: _PaintMethodCard(
                method: 'pushOpacity',
                color: Color(0xFF22D3EE),
                description: 'Pushes an OpacityLayer. Forces a saveLayer in '
                    'the engine and an offscreen buffer. Always sets '
                    'needsCompositing.',
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: _PaintMethodCard(
                method: 'pushTransform',
                color: Color(0xFF34D399),
                description: 'Pushes a TransformLayer with a 4×4 matrix. '
                    'Used by Transform and RotatedBox. Hit-tests are also '
                    'transformed when transformHitTests is true.',
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: _PaintMethodCard(
                method: 'pushClipRect',
                color: Color(0xFFA78BFA),
                description: 'Pushes a ClipRectLayer — cheap on the GPU, '
                    'but still a layer. ClipRRect / ClipPath cost more '
                    'because the engine must rasterize the path.',
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _PaintMethodCard extends StatelessWidget {
  const _PaintMethodCard({
    required this.method,
    required this.color,
    required this.description,
  });

  final String method;
  final Color color;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            color.withValues(alpha: 0.18),
            color.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.45)),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            method,
            style: TextStyle(
              fontFamily: 'monospace',
              color: color,
              fontWeight: FontWeight.w800,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            description,
            style: const TextStyle(
              color: _Palette.slate,
              fontSize: 11.5,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// 14. MARK NEEDS LAYOUT / PAINT
// =====================================================================

class _MarkNeedsSection extends StatelessWidget {
  const _MarkNeedsSection();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      tag: '14 · INVALIDATION',
      title: 'markNeedsLayout vs markNeedsPaint',
      subtitle: 'When a property changes, a custom RenderObject must tell '
          'the pipeline. markNeedsLayout schedules a relayout that may '
          'propagate to the parent if the size could change. '
          'markNeedsPaint is cheaper — it only re-runs paint().',
      accent: _Palette.warm,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            Expanded(
              child: _MarkNeedsCard(
                title: 'markNeedsLayout()',
                color: Color(0xFFE11D48),
                bullets: <String>[
                  'Use when the new value could change size',
                  'Relayout boundary determines how far it propagates',
                  'Triggers paint and semantics afterwards too',
                  'Examples: padding changed, child added/removed',
                ],
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _MarkNeedsCard(
                title: 'markNeedsPaint()',
                color: Color(0xFF22D3EE),
                bullets: <String>[
                  'Use when only the visual changes',
                  'Stops at the nearest RepaintBoundary',
                  'Does NOT relayout, does NOT re-test semantics',
                  'Examples: color changed, opacity changed',
                ],
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _MarkNeedsCard(
                title: 'markNeedsSemanticsUpdate()',
                color: Color(0xFFFBBF24),
                bullets: <String>[
                  'Use when accessibility config changes',
                  'Cheaper than layout — only walks the semantics tree',
                  'Triggered automatically by markNeedsLayout',
                  'Examples: label changed, isButton flipped',
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        _CodeBlock(
          caption: 'invalidation.dart',
          code: 'class RenderMyBox extends RenderProxyBox {\n'
              '  Color _color;\n'
              '  set color(Color value) {\n'
              '    if (_color == value) return;\n'
              '    _color = value;\n'
              '    markNeedsPaint(); // visual only\n'
              '  }\n'
              '\n'
              '  EdgeInsets _padding;\n'
              '  set padding(EdgeInsets value) {\n'
              '    if (_padding == value) return;\n'
              '    _padding = value;\n'
              '    markNeedsLayout(); // size may change\n'
              '  }\n'
              '\n'
              '  String _label;\n'
              '  set label(String value) {\n'
              '    if (_label == value) return;\n'
              '    _label = value;\n'
              '    markNeedsSemanticsUpdate();\n'
              '  }\n'
              '}',
        ),
      ],
    );
  }
}

class _MarkNeedsCard extends StatelessWidget {
  const _MarkNeedsCard({
    required this.title,
    required this.color,
    required this.bullets,
  });

  final String title;
  final Color color;
  final List<String> bullets;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _Palette.paper,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.45)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: color.withValues(alpha: 0.14),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontFamily: 'monospace',
              color: color,
              fontWeight: FontWeight.w800,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 8),
          for (final String b in bullets) _BulletLine(text: b, color: color),
        ],
      ),
    );
  }
}

// =====================================================================
// 15. PITFALLS
// =====================================================================

class _PitfallsSection extends StatelessWidget {
  const _PitfallsSection();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      tag: '15 · PITFALLS',
      title: 'Common pitfalls when reasoning about RenderObjects',
      subtitle: 'A short list of mistakes that come up in real codebases. '
          'Most of them stem from forgetting that constraints are pushed '
          'down and sizes are pulled up — never the other way around.',
      accent: _Palette.warm2,
      children: <Widget>[
        _PitfallCard(
          number: 1,
          title: 'Reading child.size without parentUsesSize: true',
          color: const Color(0xFFE11D48),
          body: 'The framework only re-lays out a parent when a child '
              'resizes if the parent declared dependency on the size. '
              'Skipping `parentUsesSize: true` will look fine the first '
              'frame and silently break on the next rebuild.',
        ),
        _PitfallCard(
          number: 2,
          title: 'Wrapping in Opacity for animation',
          color: const Color(0xFFF97316),
          body: 'Opacity forces a saveLayer. For animated fades, prefer '
              'AnimatedOpacity inside a RepaintBoundary, or use '
              'FadeTransition with an explicit alpha-only animation. The '
              'expensive offscreen buffer is the same in both cases, but '
              'the surrounding repaint tree is much smaller.',
        ),
        _PitfallCard(
          number: 3,
          title: 'Confusing Padding with margin',
          color: const Color(0xFFF59E0B),
          body: 'Flutter has no margin. Padding is always inside the '
              'RenderObject\'s size — it inflates the render box itself. '
              'Container\'s `margin:` is a separate Padding wrapped '
              'around the decorated child.',
        ),
        _PitfallCard(
          number: 4,
          title: 'Transform without alignment',
          color: const Color(0xFF34D399),
          body: 'Transform with no alignment uses the top-left corner as '
              'the origin. Transform.scale and Transform.rotate offer '
              'shortcut alignment parameters that make the transform '
              'apply around the center.',
        ),
        _PitfallCard(
          number: 5,
          title: 'Stack with no constraints',
          color: const Color(0xFF7C3AED),
          body: 'A Stack inside an unbounded parent (Column, ListView…) '
              'will not stretch by default. You either provide a '
              'SizedBox.expand around it, or pass `fit: StackFit.passthrough` '
              'and rely on the children to size the stack.',
        ),
        _PitfallCard(
          number: 6,
          title: 'markNeedsPaint when layout actually changed',
          color: const Color(0xFF0EA5E9),
          body: 'If your custom RenderObject\'s new property could change '
              'size, you must call markNeedsLayout. markNeedsPaint will '
              'leave the old size cached and the next frame will look '
              'correct only by accident.',
        ),
        _PitfallCard(
          number: 7,
          title: 'Forgetting setupParentData',
          color: const Color(0xFFEC4899),
          body: 'A custom container RenderObject must override '
              'setupParentData if it expects a richer ParentData type than '
              'BoxParentData. Forgetting it makes the cast inside '
              'performLayout throw.',
        ),
      ],
    );
  }
}

class _PitfallCard extends StatelessWidget {
  const _PitfallCard({
    required this.number,
    required this.title,
    required this.color,
    required this.body,
  });

  final int number;
  final String title;
  final Color color;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        decoration: BoxDecoration(
          color: _Palette.paper,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: color.withValues(alpha: 0.45)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: color.withValues(alpha: 0.12),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 38,
              height: 38,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    color,
                    color.withValues(alpha: 0.7),
                  ],
                ),
                borderRadius: BorderRadius.circular(10),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: color.withValues(alpha: 0.4),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Text(
                '$number',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
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
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                      letterSpacing: -0.1,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    body,
                    style: const TextStyle(
                      color: _Palette.slate,
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
    );
  }
}

// =====================================================================
// 16. LEGEND / FOOTER
// =====================================================================

class _LegendSection extends StatelessWidget {
  const _LegendSection();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      tag: '16 · LEGEND',
      title: 'Class map at a glance',
      subtitle: 'Single source of truth for the eight classes covered in '
          'this file, with a one-line summary and the widget that produces '
          'each one in idiomatic Flutter code.',
      accent: _Palette.mint,
      children: <Widget>[
        Column(
          children: const <Widget>[
            _LegendRow(
              type: 'RenderObject',
              widget: '— (abstract)',
              note: 'Lifecycle, parentData, ownership.',
              color: Color(0xFF60A5FA),
            ),
            _LegendRow(
              type: 'RenderBox',
              widget: '— (abstract)',
              note: 'BoxConstraints in, Size out.',
              color: Color(0xFF93C5FD),
            ),
            _LegendRow(
              type: 'RenderProxyBox',
              widget: 'Many decorators',
              note: 'One child, same constraints, optional layer at paint.',
              color: Color(0xFFA78BFA),
            ),
            _LegendRow(
              type: 'RenderShiftedBox',
              widget: '— (abstract)',
              note: 'One child with a parentData.offset.',
              color: Color(0xFFF472B6),
            ),
            _LegendRow(
              type: 'RenderConstrainedBox',
              widget: 'SizedBox / ConstrainedBox',
              note: 'Tighten or loosen incoming constraints.',
              color: Color(0xFFFBBF24),
            ),
            _LegendRow(
              type: 'RenderPadding',
              widget: 'Padding',
              note: 'Deflate constraints, offset child.',
              color: Color(0xFFFB923C),
            ),
            _LegendRow(
              type: 'RenderTransform',
              widget: 'Transform / RotatedBox',
              note: 'Push a TransformLayer with a 4×4 matrix.',
              color: Color(0xFF34D399),
            ),
            _LegendRow(
              type: 'RenderOpacity',
              widget: 'Opacity / FadeTransition',
              note: 'Push an OpacityLayer when alpha is in (0, 255).',
              color: Color(0xFF22D3EE),
            ),
          ],
        ),
        const SizedBox(height: 18),
        Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                Color(0xFF0F172A),
                Color(0xFF1E293B),
              ],
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Color(0x880F172A),
                blurRadius: 22,
                offset: Offset(0, 12),
              ),
            ],
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF22D3EE).withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: const Text(
                      'TL;DR',
                      style: TextStyle(
                        color: Color(0xFF67E8F9),
                        fontWeight: FontWeight.w900,
                        fontSize: 11,
                        letterSpacing: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Text(
                'A RenderObject is a node in a tree that does layout, '
                'paint, hit-testing, and semantics. Its parent gives it '
                'constraints; it returns a size; the parent decides where '
                'it sits via parentData. RenderProxyBox forwards everything '
                'unchanged. RenderShiftedBox positions one child. '
                'RenderConstrainedBox tightens. RenderPadding deflates. '
                'RenderTransform paints a matrix. RenderOpacity paints '
                'transparency. Almost every Flutter widget you draw on '
                'screen ends in one of these.',
                style: TextStyle(
                  color: Color(0xFFE2E8F0),
                  fontSize: 14,
                  height: 1.6,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _LegendRow extends StatelessWidget {
  const _LegendRow({
    required this.type,
    required this.widget,
    required this.note,
    required this.color,
  });

  final String type;
  final String widget;
  final String note;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        decoration: BoxDecoration(
          color: _Palette.paper,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.35)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        child: Row(
          children: <Widget>[
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: color.withValues(alpha: 0.6),
                    blurRadius: 6,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: 220,
              child: Text(
                type,
                style: TextStyle(
                  color: color,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w800,
                  fontSize: 13,
                ),
              ),
            ),
            SizedBox(
              width: 200,
              child: Text(
                widget,
                style: const TextStyle(
                  color: _Palette.inkSoft,
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
            ),
            Expanded(
              child: Text(
                note,
                style: const TextStyle(
                  color: _Palette.slate,
                  fontSize: 12.5,
                  height: 1.45,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
