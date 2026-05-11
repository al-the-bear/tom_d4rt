// ignore_for_file: unused_field, unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last
//
// =====================================================================
// RenderBox Family — Hand-authored visual deep demo
// =====================================================================
//
// This file is a single-screen, analyzer-clean visual deep dive into the
// RenderBox subtree of `package:flutter/rendering.dart`. The file does not
// instantiate any RenderBox subclass directly; instead, every relevant
// class is described, anatomised, and contrasted via prose, code snippets
// (rendered as `Text` blocks), and hand-drawn flow diagrams composed of
// ordinary widgets.
//
// Target classes (described, never instantiated here):
//
//   • RenderBox            — Cartesian-pixel RenderObject. Owns the
//                            BoxConstraints / Size protocol and a
//                            BoxParentData slot for absolute child offsets.
//   • RenderProxyBox       — Single-child RenderBox that forwards the
//                            incoming constraints unchanged and adopts the
//                            child's size as its own.
//   • RenderShiftedBox     — Single-child RenderBox that may position the
//                            child at a non-zero offset relative to its own
//                            origin.
//   • RenderConstrainedBox — RenderProxyBox subclass that intersects the
//                            incoming BoxConstraints with `additionalConstraints`
//                            before delegating to the child.
//   • RenderAnimatedSize   — RenderShiftedBox that smoothly interpolates
//                            its size whenever the child's intrinsic size
//                            changes.
//   • RenderAspectRatio    — RenderProxyBox that picks the largest size that
//                            fits the parent constraints AND has a fixed
//                            width/height ratio.
//   • RenderFlex           — Multi-child RenderBox that lays children out in
//                            a single horizontal or vertical run.
//   • RenderStack          — Multi-child RenderBox that paints children in
//                            order, positioning them via `StackParentData`.
//   • RenderWrap           — Multi-child RenderBox that breaks its run into
//                            a sequence of "lines" along the cross axis.
//   • RenderListBody       — Multi-child RenderBox that lays children one
//                            after another along a single axis.
//   • RenderViewport       — RenderBox that hosts RenderSlivers; the bridge
//                            between the box world and the sliver world.
//
// Hard rules respected in this file:
//
//   • Single import: `package:flutter/material.dart`.
//   • Entry: `dynamic build(BuildContext context)` returning MaterialApp.
//   • No setState, AnimationController, Timer, Future, Stream, async,
//     scroll/text/animation controllers, or RenderBox instantiation.
//   • Color alpha via `Color.withValues(alpha: ...)`.
//
// =====================================================================

import 'package:flutter/material.dart';

// =====================================================================
// ENTRY POINT
// =====================================================================

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'RenderBox Family Deep Demo',
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
    home: const _RenderBoxShowcase(),
  );
}

// =====================================================================
// SHOWCASE ROOT
// =====================================================================

class _RenderBoxShowcase extends StatelessWidget {
  const _RenderBoxShowcase();

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
              _ConstraintsFlowSection(),
              SizedBox(height: 36),
              _RenderBoxAnatomySection(),
              SizedBox(height: 36),
              _RenderProxyBoxCard(),
              SizedBox(height: 28),
              _RenderShiftedBoxCard(),
              SizedBox(height: 28),
              _RenderConstrainedBoxCard(),
              SizedBox(height: 28),
              _RenderAnimatedSizeCard(),
              SizedBox(height: 28),
              _RenderAspectRatioCard(),
              SizedBox(height: 28),
              _RenderFlexCard(),
              SizedBox(height: 28),
              _RenderStackCard(),
              SizedBox(height: 28),
              _RenderWrapCard(),
              SizedBox(height: 28),
              _RenderListBodyCard(),
              SizedBox(height: 28),
              _RenderViewportCard(),
              SizedBox(height: 72),
            ],
          ),
        ),
      ),
    );
  }
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
                    color: Color(0xFFEF4444),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF59E0B),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFF10B981),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  caption!,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF94A3B8),
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.6,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(height: 1, color: const Color(0xFF1E293B)),
            const SizedBox(height: 10),
          ],
          Text(
            code,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.2,
              height: 1.55,
              color: Color(0xFFE2E8F0),
            ),
          ),
        ],
      ),
    );
  }
}

class _Bullet extends StatelessWidget {
  const _Bullet({required this.text, this.color = _Palette.indigo});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 7, right: 10),
            width: 7,
            height: 7,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 13.4,
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

class _MiniHeading extends StatelessWidget {
  const _MiniHeading({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 4),
      child: Row(
        children: <Widget>[
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// HERO SECTION
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
            Color(0xFF0F172A),
            Color(0xFF1E1B4B),
            Color(0xFF312E81),
          ],
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color(0xFF312E81).withValues(alpha: 0.45),
            blurRadius: 40,
            offset: const Offset(0, 20),
          ),
          BoxShadow(
            color: const Color(0xFF0F172A).withValues(alpha: 0.32),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(28, 30, 28, 30),
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
                  gradient: LinearGradient(
                    colors: <Color>[
                      _Palette.amber.withValues(alpha: 0.25),
                      _Palette.orange.withValues(alpha: 0.18),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(
                    color: _Palette.amber.withValues(alpha: 0.55),
                  ),
                ),
                child: const Text(
                  'package:flutter/rendering.dart',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.1,
                    color: Color(0xFFFCD34D),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.15),
                  ),
                ),
                child: const Text(
                  'BOX LAYOUT PROTOCOL',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.4,
                    color: Color(0xFFC7D2FE),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          const Text(
            'The RenderBox family',
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.8,
              height: 1.05,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Constraints flow DOWN. Sizes flow UP. Parents place children.',
            style: TextStyle(
              fontSize: 16,
              height: 1.5,
              color: Colors.white.withValues(alpha: 0.78),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.10),
              ),
            ),
            child: Text(
              'A RenderBox is a RenderObject that uses BoxConstraints (min/max '
              'width and height) and produces a Size (width × height). Its '
              'parent stores a per-child Offset on the BoxParentData slot. '
              'This single contract is what every Padding, Row, Column, '
              'Stack, Wrap, AspectRatio, ConstrainedBox, AnimatedSize, and '
              'most other layout widgets ultimately compile down to.',
              style: TextStyle(
                fontSize: 13.5,
                height: 1.6,
                color: Colors.white.withValues(alpha: 0.82),
              ),
            ),
          ),
          const SizedBox(height: 18),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              _heroChip('RenderBox', _Palette.indigo),
              _heroChip('RenderProxyBox', _Palette.blue),
              _heroChip('RenderShiftedBox', _Palette.cyan),
              _heroChip('RenderConstrainedBox', _Palette.teal),
              _heroChip('RenderAnimatedSize', _Palette.mint),
              _heroChip('RenderAspectRatio', _Palette.amber),
              _heroChip('RenderFlex', _Palette.orange),
              _heroChip('RenderStack', _Palette.rose),
              _heroChip('RenderWrap', _Palette.purple),
              _heroChip('RenderListBody', _Palette.pink),
              _heroChip('RenderViewport', Colors.white),
            ],
          ),
        ],
      ),
    );
  }

  Widget _heroChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.45)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11.5,
          fontWeight: FontWeight.w700,
          color: color,
          letterSpacing: 0.4,
          fontFamily: 'monospace',
        ),
      ),
    );
  }
}

// =====================================================================
// CONSTRAINTS FLOW SECTION
// =====================================================================

class _ConstraintsFlowSection extends StatelessWidget {
  const _ConstraintsFlowSection();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      tag: 'PROTOCOL · 01',
      title: 'BoxConstraints flow chart',
      subtitle:
          'The fundamental rule of box layout: parents pass BoxConstraints '
          'down the tree; children return a Size up the tree; the parent then '
          'writes the absolute child Offset onto the BoxParentData slot.',
      accent: _Palette.indigo,
      children: <Widget>[
        const _CodeBlock(
          caption: 'BoxConstraints — the data class that flows DOWN',
          code: 'class BoxConstraints extends Constraints {\n'
              '  const BoxConstraints({\n'
              '    this.minWidth  = 0.0,\n'
              '    this.maxWidth  = double.infinity,\n'
              '    this.minHeight = 0.0,\n'
              '    this.maxHeight = double.infinity,\n'
              '  });\n'
              '\n'
              '  bool get isTight   => minWidth == maxWidth\n'
              '                      && minHeight == maxHeight;\n'
              '  bool get hasBoundedWidth  => maxWidth  < double.infinity;\n'
              '  bool get hasBoundedHeight => maxHeight < double.infinity;\n'
              '\n'
              '  Size constrain(Size size) => Size(\n'
              '    constrainWidth(size.width),\n'
              '    constrainHeight(size.height),\n'
              '  );\n'
              '}',
        ),
        const SizedBox(height: 16),
        const _CodeBlock(
          caption: 'Size — the data class that flows UP',
          code: 'class Size extends OffsetBase {\n'
              '  const Size(double width, double height);\n'
              '  double get width;\n'
              '  double get height;\n'
              '  double get aspectRatio => width / height;\n'
              '}',
        ),
        const SizedBox(height: 22),
        _ConstraintsFlowDiagram(),
        const SizedBox(height: 22),
        const _MiniHeading(label: 'WHAT EACH ARROW MEANS', color: _Palette.indigo),
        const _Bullet(
          color: _Palette.blue,
          text: 'DOWN arrow: parent invokes child.layout(constraints, '
              'parentUsesSize: …). The child stores the incoming '
              'BoxConstraints in its `constraints` getter.',
        ),
        const _Bullet(
          color: _Palette.mint,
          text: 'UP arrow: after performLayout(), the child sets `size = …` '
              '(must satisfy `constraints.isSatisfiedBy(size)`). The parent '
              'reads `child.size` to know the result.',
        ),
        const _Bullet(
          color: _Palette.amber,
          text: 'SIDE arrow: the parent then writes `(child.parentData as '
              'BoxParentData).offset = …` to position the child in its own '
              'coordinate space. The child never knows its absolute offset.',
        ),
      ],
    );
  }
}

class _ConstraintsFlowDiagram extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Color(0xFFF8FAFF),
            Color(0xFFEFF2FE),
          ],
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _Palette.line),
      ),
      child: Column(
        children: <Widget>[
          _flowNode('Parent RenderBox', _Palette.indigo,
              'computes BoxConstraints for child'),
          _arrow(downLabel: 'constraints', up: false),
          _flowNode('Child RenderBox', _Palette.blue,
              'performLayout() → sets size'),
          _arrow(downLabel: 'size', up: true),
          _flowNode('Parent (again)', _Palette.purple,
              'reads child.size, writes child.parentData.offset'),
        ],
      ),
    );
  }

  Widget _flowNode(String title, Color color, String subtitle) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 14, 18, 14),
      decoration: BoxDecoration(
        color: _Palette.card,
        borderRadius: BorderRadius.circular(14),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: color.withValues(alpha: 0.18),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[color, color.withValues(alpha: 0.55)],
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: const Icon(Icons.crop_square, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w800,
                    color: color,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12.5,
                    color: _Palette.slate,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _arrow({required String downLabel, required bool up}) {
    final Color color = up ? _Palette.mint : _Palette.blue;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            up ? Icons.arrow_upward : Icons.arrow_downward,
            color: color,
            size: 18,
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: color.withValues(alpha: 0.35)),
            ),
            child: Text(
              downLabel,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: color,
                letterSpacing: 0.6,
                fontFamily: 'monospace',
              ),
            ),
          ),
          const SizedBox(width: 8),
          Icon(
            up ? Icons.arrow_upward : Icons.arrow_downward,
            color: color,
            size: 18,
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// RENDERBOX BASE CLASS ANATOMY
// =====================================================================

class _RenderBoxAnatomySection extends StatelessWidget {
  const _RenderBoxAnatomySection();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      tag: 'BASE · 02',
      title: 'RenderBox — the base class',
      subtitle:
          'Every box-shaped render object subclasses RenderBox. It adds a '
          'Cartesian Size, a BoxConstraints contract, intrinsic-size queries, '
          'and a hit-testing protocol on top of the bare RenderObject.',
      accent: _Palette.blue,
      children: <Widget>[
        const _CodeBlock(
          caption: 'RenderBox — relevant interface (sketch)',
          code: 'abstract class RenderBox extends RenderObject {\n'
              '  // Layout output:\n'
              '  Size get size; // valid AFTER performLayout()\n'
              '\n'
              '  // Layout input (from parent):\n'
              '  @override\n'
              '  BoxConstraints get constraints;\n'
              '\n'
              '  // Per-child slot the PARENT writes:\n'
              '  @override\n'
              '  void setupParentData(covariant RenderObject child) {\n'
              '    if (child.parentData is! BoxParentData) {\n'
              '      child.parentData = BoxParentData();\n'
              '    }\n'
              '  }\n'
              '\n'
              '  // Subclass hooks:\n'
              '  @override\n'
              '  void performLayout();              // must set size\n'
              '  @override\n'
              '  void paint(PaintingContext c, Offset offset);\n'
              '  @override\n'
              '  bool hitTest(BoxHitTestResult r, {required Offset position});\n'
              '\n'
              '  // Intrinsic protocol (used by Wrap, Table, IntrinsicWidth):\n'
              '  double computeMinIntrinsicWidth(double height);\n'
              '  double computeMaxIntrinsicWidth(double height);\n'
              '  double computeMinIntrinsicHeight(double width);\n'
              '  double computeMaxIntrinsicHeight(double width);\n'
              '}\n'
              '\n'
              'class BoxParentData extends ParentData {\n'
              '  Offset offset = Offset.zero; // child position in parent space\n'
              '}',
        ),
        const SizedBox(height: 18),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: _anatomyCell(
                'INPUT',
                'BoxConstraints',
                'min/max width & height',
                _Palette.blue,
                Icons.south,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _anatomyCell(
                'OUTPUT',
                'Size',
                'width × height',
                _Palette.mint,
                Icons.north,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _anatomyCell(
                'PARENT-WRITES',
                'BoxParentData.offset',
                'child position',
                _Palette.amber,
                Icons.east,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const _MiniHeading(label: 'INVARIANTS', color: _Palette.blue),
        const _Bullet(
          color: _Palette.blue,
          text: 'After layout, `size` is non-null and lies inside the '
              'incoming `constraints`. Reading `size` before layout asserts.',
        ),
        const _Bullet(
          color: _Palette.blue,
          text: 'A RenderBox must NOT depend on its parent\'s size during '
              'its own layout. The only input is `constraints`.',
        ),
        const _Bullet(
          color: _Palette.blue,
          text: 'Coordinates are local. The origin (0,0) is always the '
              'top-left of THIS render box. Children store their offset '
              'relative to it on `BoxParentData.offset`.',
        ),
        const _Bullet(
          color: _Palette.blue,
          text: 'Hit testing is symmetrical: paint draws child at offset, '
              'hit-test subtracts the same offset before recursing.',
        ),
      ],
    );
  }

  Widget _anatomyCell(
    String label,
    String type,
    String hint,
    Color color,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            color.withValues(alpha: 0.13),
            color.withValues(alpha: 0.05),
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
              Icon(icon, size: 16, color: color),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.3,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            type,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: _Palette.ink,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(height: 4),
          Text(
            hint,
            style: const TextStyle(
              fontSize: 11.5,
              color: _Palette.slate,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// VARIANT CARD — shared frame for the 10 RenderBox variant cards
// =====================================================================

class _VariantCard extends StatelessWidget {
  const _VariantCard({
    required this.tag,
    required this.title,
    required this.tagline,
    required this.accent,
    required this.parentClass,
    required this.children,
  });

  final String tag;
  final String title;
  final String tagline;
  final Color accent;
  final String parentClass;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _Palette.card,
        borderRadius: BorderRadius.circular(20),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: accent.withValues(alpha: 0.14),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
          BoxShadow(
            color: _Palette.ink.withValues(alpha: 0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: _Palette.line),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Header band
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  accent.withValues(alpha: 0.20),
                  accent.withValues(alpha: 0.06),
                ],
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              border: Border(
                bottom: BorderSide(color: accent.withValues(alpha: 0.25)),
              ),
            ),
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    _TagChip(label: tag, color: accent),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _Palette.card,
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(color: _Palette.line),
                      ),
                      child: Text(
                        'extends $parentClass',
                        style: const TextStyle(
                          fontSize: 10.5,
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.w700,
                          color: _Palette.slate,
                          letterSpacing: 0.4,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: _Palette.ink,
                    fontFamily: 'monospace',
                    letterSpacing: -0.4,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  tagline,
                  style: const TextStyle(
                    fontSize: 13.5,
                    height: 1.5,
                    color: _Palette.slate,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: children,
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// 1 / 10 — RenderProxyBox
// =====================================================================

class _RenderProxyBoxCard extends StatelessWidget {
  const _RenderProxyBoxCard();

  @override
  Widget build(BuildContext context) {
    return _VariantCard(
      tag: 'BOX · 03',
      title: 'RenderProxyBox',
      tagline:
          'Single-child box that forwards constraints unchanged and adopts '
          'the child\'s size as its own. The chassis class for nearly every '
          'painting-only effect (Opacity, Transform, ClipRect, ColoredBox).',
      accent: _Palette.blue,
      parentClass: 'RenderBox with RenderObjectWithChildMixin<RenderBox>',
      children: <Widget>[
        const _CodeBlock(
          caption: 'class signature & layout',
          code: 'class RenderProxyBox extends RenderBox\n'
              '    with RenderObjectWithChildMixin<RenderBox>,\n'
              '         RenderProxyBoxMixin {\n'
              '  RenderProxyBox([RenderBox? child]) { this.child = child; }\n'
              '}\n'
              '\n'
              'mixin RenderProxyBoxMixin on RenderBox,\n'
              '    RenderObjectWithChildMixin<RenderBox> {\n'
              '  @override\n'
              '  void performLayout() {\n'
              '    if (child != null) {\n'
              '      child!.layout(constraints, parentUsesSize: true);\n'
              '      size = child!.size;\n'
              '    } else {\n'
              '      size = computeSizeForNoChild(constraints);\n'
              '    }\n'
              '  }\n'
              '}',
        ),
        const SizedBox(height: 16),
        const _MiniHeading(label: 'WHEN USED', color: _Palette.blue),
        const _Bullet(
          color: _Palette.blue,
          text: 'Whenever a widget needs to MUTATE PAINT (apply a filter, '
              'transform, clip, opacity) without changing layout. The widget '
              'wraps a single child of the same size.',
        ),
        const _Bullet(
          color: _Palette.blue,
          text: 'Examples: Opacity, AnimatedOpacity, Transform, '
              'FractionalTranslation, ClipRect, ClipRRect, ClipOval, ClipPath, '
              'ColoredBox, DecoratedBox, ShaderMask, BackdropFilter.',
        ),
        const _Bullet(
          color: _Palette.blue,
          text: 'paint() typically pushes a Layer (OpacityLayer, '
              'TransformLayer, ClipRectLayer) and recurses. Layout is a no-op '
              'pass-through.',
        ),
      ],
    );
  }
}

// =====================================================================
// 2 / 10 — RenderShiftedBox
// =====================================================================

class _RenderShiftedBoxCard extends StatelessWidget {
  const _RenderShiftedBoxCard();

  @override
  Widget build(BuildContext context) {
    return _VariantCard(
      tag: 'BOX · 04',
      title: 'RenderShiftedBox',
      tagline:
          'Single-child box that may position the child at a non-zero '
          'offset relative to its own origin. The chassis class for '
          'Padding, Align, Center, FittedBox, OverflowBox.',
      accent: _Palette.cyan,
      parentClass: 'RenderBox with RenderObjectWithChildMixin<RenderBox>',
      children: <Widget>[
        const _CodeBlock(
          caption: 'class signature',
          code: 'abstract class RenderShiftedBox extends RenderBox\n'
              '    with RenderObjectWithChildMixin<RenderBox> {\n'
              '  RenderShiftedBox(RenderBox? child) { this.child = child; }\n'
              '\n'
              '  @override\n'
              '  void paint(PaintingContext context, Offset offset) {\n'
              '    if (child != null) {\n'
              '      final childParentData =\n'
              '          child!.parentData! as BoxParentData;\n'
              '      context.paintChild(\n'
              '        child!,\n'
              '        childParentData.offset + offset,\n'
              '      );\n'
              '    }\n'
              '  }\n'
              '}',
        ),
        const SizedBox(height: 16),
        const _MiniHeading(label: 'KEY DIFFERENCE FROM PROXY', color: _Palette.cyan),
        const _Bullet(
          color: _Palette.cyan,
          text: 'RenderProxyBox forces child.size == this.size. '
              'RenderShiftedBox lets `this.size` be DIFFERENT and stores the '
              'translation in child.parentData.offset.',
        ),
        const _Bullet(
          color: _Palette.cyan,
          text: 'Subclasses override performLayout() to (a) layout the child '
              'with adjusted constraints, (b) set this.size, (c) compute and '
              'write child.parentData.offset.',
        ),
        const _Bullet(
          color: _Palette.cyan,
          text: 'Concrete subclasses: RenderPadding, RenderAligningShiftedBox, '
              'RenderPositionedBox (Align/Center), RenderConstrainedOverflowBox, '
              'RenderSizedOverflowBox, RenderFittedBox, RenderBaseline.',
        ),
      ],
    );
  }
}

// =====================================================================
// 3 / 10 — RenderConstrainedBox
// =====================================================================

class _RenderConstrainedBoxCard extends StatelessWidget {
  const _RenderConstrainedBoxCard();

  @override
  Widget build(BuildContext context) {
    return _VariantCard(
      tag: 'BOX · 05',
      title: 'RenderConstrainedBox',
      tagline:
          'Tightens or loosens the incoming BoxConstraints by intersecting '
          'with `additionalConstraints` before delegating to its child.',
      accent: _Palette.teal,
      parentClass: 'RenderProxyBox',
      children: <Widget>[
        const _CodeBlock(
          caption: 'how it modifies constraints',
          code: 'class RenderConstrainedBox extends RenderProxyBox {\n'
              '  RenderConstrainedBox({\n'
              '    RenderBox? child,\n'
              '    required BoxConstraints additionalConstraints,\n'
              '  }) : _additionalConstraints = additionalConstraints,\n'
              '       super(child);\n'
              '\n'
              '  BoxConstraints _additionalConstraints;\n'
              '\n'
              '  @override\n'
              '  void performLayout() {\n'
              '    final BoxConstraints effective =\n'
              '        _additionalConstraints.enforce(constraints);\n'
              '    if (child != null) {\n'
              '      child!.layout(effective, parentUsesSize: true);\n'
              '      size = child!.size;\n'
              '    } else {\n'
              '      size = effective.constrain(Size.zero);\n'
              '    }\n'
              '  }\n'
              '}',
        ),
        const SizedBox(height: 16),
        const _MiniHeading(label: 'POWERS THESE WIDGETS', color: _Palette.teal),
        const _Bullet(
          color: _Palette.teal,
          text: 'ConstrainedBox(constraints: …) — passes through directly.',
        ),
        const _Bullet(
          color: _Palette.teal,
          text: 'SizedBox(width: w, height: h) — uses '
              '`BoxConstraints.tightFor(width: w, height: h)` so width and '
              'height become forced if specified.',
        ),
        const _Bullet(
          color: _Palette.teal,
          text: 'LimitedBox — applies maxWidth/maxHeight ONLY when the '
              'incoming axis is unbounded (used inside ListView items).',
        ),
        const _Bullet(
          color: _Palette.teal,
          text: '`enforce()` is intersection: result is no looser than '
              'parent constraints AND no looser than `additionalConstraints`.',
        ),
      ],
    );
  }
}

// =====================================================================
// 4 / 10 — RenderAnimatedSize
// =====================================================================

class _RenderAnimatedSizeCard extends StatelessWidget {
  const _RenderAnimatedSizeCard();

  @override
  Widget build(BuildContext context) {
    return _VariantCard(
      tag: 'BOX · 06',
      title: 'RenderAnimatedSize',
      tagline:
          'A RenderShiftedBox that smoothly interpolates its OWN size '
          'whenever the child\'s intrinsic size changes — the engine behind '
          'AnimatedSize and AnimatedCrossFade.',
      accent: _Palette.mint,
      parentClass: 'RenderAligningShiftedBox',
      children: <Widget>[
        const _CodeBlock(
          caption: 'simplified contract',
          code: 'class RenderAnimatedSize extends RenderAligningShiftedBox {\n'
              '  RenderAnimatedSize({\n'
              '    required TickerProvider vsync,\n'
              '    required Duration duration,\n'
              '    Curve curve = Curves.linear,\n'
              '    AlignmentGeometry alignment = Alignment.center,\n'
              '    RenderBox? child,\n'
              '  });\n'
              '\n'
              '  RenderAnimatedSizeState get state;\n'
              '\n'
              '  @override\n'
              '  void performLayout() {\n'
              '    // 1. layout child loosely to read its desired size\n'
              '    // 2. start an internal Tween<Size> from oldSize → newSize\n'
              '    // 3. expose the interpolated size via this.size\n'
              '    // 4. align the child within that interpolated size\n'
              '  }\n'
              '}',
        ),
        const SizedBox(height: 16),
        const _MiniHeading(label: 'STATE MACHINE', color: _Palette.mint),
        const _Bullet(
          color: _Palette.mint,
          text: 'stable — child size matches container size, no animation.',
        ),
        const _Bullet(
          color: _Palette.mint,
          text: 'changed — child reports a new size; a Tween<Size> starts.',
        ),
        const _Bullet(
          color: _Palette.mint,
          text: 'unstable — child keeps changing during animation: '
              'RenderAnimatedSize falls back to following the child instantly '
              'and emits a "size is unstable" debug warning.',
        ),
        const _Bullet(
          color: _Palette.mint,
          text: 'This is one of the few RenderBoxes that owns a Ticker — '
              'AnimatedSize provides the TickerProvider via SingleTickerProviderStateMixin.',
        ),
      ],
    );
  }
}

// =====================================================================
// 5 / 10 — RenderAspectRatio
// =====================================================================

class _RenderAspectRatioCard extends StatelessWidget {
  const _RenderAspectRatioCard();

  @override
  Widget build(BuildContext context) {
    return _VariantCard(
      tag: 'BOX · 07',
      title: 'RenderAspectRatio',
      tagline:
          'Picks the largest size satisfying the parent constraints AND '
          'matching a fixed width / height ratio. Powers AspectRatio.',
      accent: _Palette.amber,
      parentClass: 'RenderProxyBox',
      children: <Widget>[
        const _CodeBlock(
          caption: 'sizing algorithm',
          code: 'class RenderAspectRatio extends RenderProxyBox {\n'
              '  RenderAspectRatio({required double aspectRatio,\n'
              '                     RenderBox? child})\n'
              '      : _aspectRatio = aspectRatio,\n'
              '        super(child);\n'
              '\n'
              '  double _aspectRatio; // width / height\n'
              '\n'
              '  Size _applyAspectRatio(BoxConstraints constraints) {\n'
              '    if (constraints.isTight) return constraints.smallest;\n'
              '\n'
              '    double w = constraints.maxWidth;\n'
              '    double h = w.isFinite ? w / _aspectRatio\n'
              '                          : constraints.maxHeight;\n'
              '    if (h > constraints.maxHeight) {\n'
              '      h = constraints.maxHeight;\n'
              '      w = h * _aspectRatio;\n'
              '    }\n'
              '    if (w < constraints.minWidth)  { w = constraints.minWidth;\n'
              '                                    h = w / _aspectRatio; }\n'
              '    if (h < constraints.minHeight) { h = constraints.minHeight;\n'
              '                                    w = h * _aspectRatio; }\n'
              '    return constraints.constrain(Size(w, h));\n'
              '  }\n'
              '}',
        ),
        const SizedBox(height: 16),
        const _MiniHeading(label: 'EDGE CASES', color: _Palette.amber),
        const _Bullet(
          color: _Palette.amber,
          text: 'Both axes unbounded → asserts: AspectRatio cannot pick a '
              'size when neither constraint is finite.',
        ),
        const _Bullet(
          color: _Palette.amber,
          text: 'Tight constraints → ignores the aspect ratio entirely; '
              'returns `constraints.smallest` (which equals largest when tight).',
        ),
        const _Bullet(
          color: _Palette.amber,
          text: 'Layout always succeeds within parent constraints — the '
              'aspect ratio bends to fit, never the other way around.',
        ),
      ],
    );
  }
}

// =====================================================================
// 6 / 10 — RenderFlex
// =====================================================================

class _RenderFlexCard extends StatelessWidget {
  const _RenderFlexCard();

  @override
  Widget build(BuildContext context) {
    return _VariantCard(
      tag: 'BOX · 08',
      title: 'RenderFlex',
      tagline:
          'The multi-child engine behind Row, Column, and Flex. Two-pass '
          'layout: first measure inflexible children, then distribute leftover '
          'space to flex children proportionally to their flex value.',
      accent: _Palette.orange,
      parentClass: 'RenderBox with ContainerRenderObjectMixin<…, FlexParentData>',
      children: <Widget>[
        const _CodeBlock(
          caption: 'parent data + main fields',
          code: 'class FlexParentData extends ContainerBoxParentData<RenderBox> {\n'
              '  int? flex;       // Expanded.flex / Flexible.flex\n'
              '  FlexFit? fit;    // FlexFit.tight / FlexFit.loose\n'
              '}\n'
              '\n'
              'class RenderFlex extends RenderBox\n'
              '    with ContainerRenderObjectMixin<RenderBox, FlexParentData>,\n'
              '         RenderBoxContainerDefaultsMixin<RenderBox,\n'
              '             FlexParentData> {\n'
              '  Axis              direction;          // horizontal / vertical\n'
              '  MainAxisAlignment mainAxisAlignment;  // start … spaceEvenly\n'
              '  CrossAxisAlignment crossAxisAlignment; // start … stretch / baseline\n'
              '  MainAxisSize      mainAxisSize;       // min / max\n'
              '  TextDirection?    textDirection;\n'
              '  VerticalDirection verticalDirection;\n'
              '  TextBaseline?     textBaseline;       // for crossAxis baseline\n'
              '}',
        ),
        const SizedBox(height: 16),
        const _CodeBlock(
          caption: 'two-pass performLayout (sketch)',
          code: 'void performLayout() {\n'
              '  // PASS 1 — inflexible children (flex == 0 / null)\n'
              '  double totalFlex = 0;\n'
              '  double allocated = 0;\n'
              '  for (RenderBox child in children) {\n'
              '    final fpd = child.parentData! as FlexParentData;\n'
              '    if ((fpd.flex ?? 0) > 0) {\n'
              '      totalFlex += fpd.flex!;\n'
              '      continue;\n'
              '    }\n'
              '    child.layout(_unboundedAlongMain(constraints),\n'
              '                  parentUsesSize: true);\n'
              '    allocated += _mainSize(child);\n'
              '  }\n'
              '\n'
              '  // PASS 2 — flex children share the remaining space\n'
              '  final double freeSpace =\n'
              '      max(0, _maxMain(constraints) - allocated);\n'
              '  final double spacePerFlex =\n'
              '      totalFlex > 0 ? freeSpace / totalFlex : 0;\n'
              '\n'
              '  for (RenderBox child in children) {\n'
              '    final fpd = child.parentData! as FlexParentData;\n'
              '    if ((fpd.flex ?? 0) == 0) continue;\n'
              '    final double extent = spacePerFlex * fpd.flex!;\n'
              '    final BoxConstraints inner = (fpd.fit == FlexFit.tight)\n'
              '        ? _tightAlongMain(extent, constraints)\n'
              '        : _looseAlongMain(extent, constraints);\n'
              '    child.layout(inner, parentUsesSize: true);\n'
              '  }\n'
              '\n'
              '  // PASS 3 — position every child along main axis\n'
              '  // according to mainAxisAlignment + crossAxisAlignment\n'
              '}',
        ),
        const SizedBox(height: 16),
        const _MiniHeading(label: 'IMPLEMENTATION HIGHLIGHTS', color: _Palette.orange),
        const _Bullet(
          color: _Palette.orange,
          text: 'CrossAxisAlignment.stretch makes children TIGHT on the '
              'cross axis; CrossAxisAlignment.baseline forces baseline metrics.',
        ),
        const _Bullet(
          color: _Palette.orange,
          text: 'MainAxisSize.min sets this.size = sum of children on main '
              'axis; MainAxisSize.max takes the parent\'s max on that axis.',
        ),
        const _Bullet(
          color: _Palette.orange,
          text: 'Asserts on unbounded main-axis with flex children: '
              '"RenderFlex children have non-zero flex but incoming … '
              'constraints are unbounded".',
        ),
      ],
    );
  }
}

// =====================================================================
// 7 / 10 — RenderStack
// =====================================================================

class _RenderStackCard extends StatelessWidget {
  const _RenderStackCard();

  @override
  Widget build(BuildContext context) {
    return _VariantCard(
      tag: 'BOX · 09',
      title: 'RenderStack',
      tagline:
          'Multi-child box that paints children in order. Children are either '
          'positioned (top/right/bottom/left given) or non-positioned '
          '(sized to the stack and aligned by `alignment`).',
      accent: _Palette.rose,
      parentClass: 'RenderBox with ContainerRenderObjectMixin<…, StackParentData>',
      children: <Widget>[
        const _CodeBlock(
          caption: 'parent data',
          code: 'class StackParentData extends ContainerBoxParentData<RenderBox> {\n'
              '  double? top;\n'
              '  double? right;\n'
              '  double? bottom;\n'
              '  double? left;\n'
              '  double? width;\n'
              '  double? height;\n'
              '\n'
              '  bool get isPositioned =>\n'
              '      top    != null || right  != null ||\n'
              '      bottom != null || left   != null ||\n'
              '      width  != null || height != null;\n'
              '}',
        ),
        const SizedBox(height: 16),
        const _CodeBlock(
          caption: 'two-pass layout',
          code: 'void performLayout() {\n'
              '  // PASS 1: lay out NON-positioned children with `constraints`\n'
              '  // (or loosened, depending on StackFit). Track the largest size.\n'
              '  Size biggest = constraints.smallest;\n'
              '  final BoxConstraints inner = switch (fit) {\n'
              '    StackFit.loose     => constraints.loosen(),\n'
              '    StackFit.expand    => BoxConstraints.tight(constraints.biggest),\n'
              '    StackFit.passthrough => constraints,\n'
              '  };\n'
              '  for (RenderBox c in children) {\n'
              '    final spd = c.parentData! as StackParentData;\n'
              '    if (spd.isPositioned) continue;\n'
              '    c.layout(inner, parentUsesSize: true);\n'
              '    biggest = _max(biggest, c.size);\n'
              '  }\n'
              '  size = biggest;\n'
              '\n'
              '  // PASS 2: lay out + position EACH positioned child\n'
              '  for (RenderBox c in children) {\n'
              '    final spd = c.parentData! as StackParentData;\n'
              '    if (!spd.isPositioned) {\n'
              '      // align inside the stack with `alignment`\n'
              '      spd.offset = alignment.alongOffset(\n'
              '        Offset(size.width  - c.size.width,\n'
              '               size.height - c.size.height),\n'
              '      );\n'
              '      continue;\n'
              '    }\n'
              '    final BoxConstraints pc =\n'
              '        _constraintsForPositioned(spd, size);\n'
              '    c.layout(pc, parentUsesSize: true);\n'
              '    spd.offset = _offsetForPositioned(spd, size, c.size);\n'
              '  }\n'
              '}',
        ),
        const SizedBox(height: 16),
        const _MiniHeading(label: 'STACKFIT MODES', color: _Palette.rose),
        const _Bullet(
          color: _Palette.rose,
          text: 'loose — non-positioned children may be smaller than the '
              'stack; the stack sizes itself to the biggest child.',
        ),
        const _Bullet(
          color: _Palette.rose,
          text: 'expand — non-positioned children are forced TIGHT to the '
              'stack\'s constraints; everyone is the same size.',
        ),
        const _Bullet(
          color: _Palette.rose,
          text: 'passthrough — incoming constraints are forwarded unchanged; '
              'the parent must size the stack tightly.',
        ),
      ],
    );
  }
}

// =====================================================================
// 8 / 10 — RenderWrap
// =====================================================================

class _RenderWrapCard extends StatelessWidget {
  const _RenderWrapCard();

  @override
  Widget build(BuildContext context) {
    return _VariantCard(
      tag: 'BOX · 10',
      title: 'RenderWrap',
      tagline:
          'Multi-child box that lays out along the main axis until space '
          'runs out, then breaks to a new line on the cross axis. Powers Wrap.',
      accent: _Palette.purple,
      parentClass: 'RenderBox with ContainerRenderObjectMixin<…, WrapParentData>',
      children: <Widget>[
        const _CodeBlock(
          caption: 'parent data + main fields',
          code: 'class WrapParentData extends ContainerBoxParentData<RenderBox> {\n'
              '  int _runIndex = 0; // which "line" the child belongs to\n'
              '}\n'
              '\n'
              'class RenderWrap extends RenderBox\n'
              '    with ContainerRenderObjectMixin<RenderBox, WrapParentData>,\n'
              '         RenderBoxContainerDefaultsMixin<RenderBox,\n'
              '             WrapParentData> {\n'
              '  Axis              direction;\n'
              '  WrapAlignment     alignment;          // main-axis per run\n'
              '  double            spacing;            // gap between children\n'
              '  WrapAlignment     runAlignment;       // alignment of runs on cross\n'
              '  double            runSpacing;         // gap between runs\n'
              '  WrapCrossAlignment crossAxisAlignment;\n'
              '  TextDirection?    textDirection;\n'
              '  VerticalDirection verticalDirection;\n'
              '}',
        ),
        const SizedBox(height: 16),
        const _CodeBlock(
          caption: 'algorithm sketch',
          code: 'void performLayout() {\n'
              '  // 1. Walk children in order. For each, layout LOOSE on main\n'
              '  //    axis (so it reports its preferred size).\n'
              '  // 2. If currentRunMain + childMain + spacing > maxMain,\n'
              '  //    close the current run and start a new one.\n'
              '  // 3. Track per-run total main extent and max cross extent.\n'
              '  // 4. After all runs are known, this.size = combined main\n'
              '  //    × sum of (run cross extent + runSpacing).\n'
              '  // 5. Walk runs again to assign each child its parent-data\n'
              '  //    offset based on alignment / runAlignment.\n'
              '}',
        ),
        const SizedBox(height: 16),
        const _MiniHeading(label: 'INTRINSIC NOTES', color: _Palette.purple),
        const _Bullet(
          color: _Palette.purple,
          text: 'RenderWrap reports finite intrinsic widths and heights — '
              'safe to place inside Wrap-of-Wraps unlike RenderFlex.',
        ),
        const _Bullet(
          color: _Palette.purple,
          text: 'WrapCrossAlignment.start/end/center positions each child '
              'within its own run\'s cross extent.',
        ),
        const _Bullet(
          color: _Palette.purple,
          text: 'A single run with no overflow degrades to a Flex-like '
              'layout; Wrap is therefore a strict superset of a one-line Flex '
              'in shape, but with different intrinsic semantics.',
        ),
      ],
    );
  }
}

// =====================================================================
// 9 / 10 — RenderListBody
// =====================================================================

class _RenderListBodyCard extends StatelessWidget {
  const _RenderListBodyCard();

  @override
  Widget build(BuildContext context) {
    return _VariantCard(
      tag: 'BOX · 11',
      title: 'RenderListBody',
      tagline:
          'Lays children one after another along a single axis using the '
          'FULL cross-axis extent. The non-scrolling cousin of SliverList.',
      accent: _Palette.pink,
      parentClass: 'RenderBox with ContainerRenderObjectMixin<…, ListBodyParentData>',
      children: <Widget>[
        const _CodeBlock(
          caption: 'parent data + layout',
          code: 'class ListBodyParentData\n'
              '    extends ContainerBoxParentData<RenderBox> {}\n'
              '\n'
              'class RenderListBody extends RenderBox\n'
              '    with ContainerRenderObjectMixin<RenderBox,\n'
              '             ListBodyParentData>,\n'
              '         RenderBoxContainerDefaultsMixin<RenderBox,\n'
              '             ListBodyParentData> {\n'
              '  AxisDirection axisDirection; // down / right / up / left\n'
              '\n'
              '  @override\n'
              '  void performLayout() {\n'
              '    // Build inner constraints: TIGHT on cross axis,\n'
              '    // UNBOUNDED on the main axis (children may be any length).\n'
              '    final BoxConstraints inner = _innerForMainAxis(constraints);\n'
              '    double mainExtent = 0;\n'
              '    RenderBox? c = firstChild;\n'
              '    while (c != null) {\n'
              '      c.layout(inner, parentUsesSize: true);\n'
              '      final pd = c.parentData! as ListBodyParentData;\n'
              '      pd.offset = _mainAxisOffset(mainExtent);\n'
              '      mainExtent += _mainExtentOf(c);\n'
              '      c = childAfter(c);\n'
              '    }\n'
              '    size = constraints.constrain(_mainSizeFor(mainExtent));\n'
              '  }\n'
              '}',
        ),
        const SizedBox(height: 16),
        const _MiniHeading(label: 'WHEN TO REACH FOR IT', color: _Palette.pink),
        const _Bullet(
          color: _Palette.pink,
          text: 'You want a vertical list with NO scrolling — useful inside '
              'a SingleChildScrollView when items are heterogeneous and you '
              'do not want SliverList\'s viewport semantics.',
        ),
        const _Bullet(
          color: _Palette.pink,
          text: 'Children must report a finite extent on the main axis; '
              'asserts otherwise.',
        ),
        const _Bullet(
          color: _Palette.pink,
          text: 'AxisDirection.up / .left reverse the iteration order on the '
              'paint axis without re-ordering the underlying children list.',
        ),
      ],
    );
  }
}

// =====================================================================
// 10 / 10 — RenderViewport
// =====================================================================

class _RenderViewportCard extends StatelessWidget {
  const _RenderViewportCard();

  @override
  Widget build(BuildContext context) {
    return _VariantCard(
      tag: 'BOX · 12',
      title: 'RenderViewport',
      tagline:
          'A RenderBox whose CHILDREN are RenderSlivers. The bridge between '
          'box constraints (parent-side) and sliver constraints (child-side); '
          'the heart of every CustomScrollView.',
      accent: _Palette.indigo,
      parentClass: 'RenderViewportBase<SliverPhysicalContainerParentData>',
      children: <Widget>[
        const _CodeBlock(
          caption: 'class signature',
          code: 'class RenderViewport extends RenderViewportBase<\n'
              '        SliverPhysicalContainerParentData> {\n'
              '  RenderViewport({\n'
              '    required AxisDirection axisDirection,\n'
              '    required AxisDirection crossAxisDirection,\n'
              '    required ViewportOffset offset, // ScrollPosition\n'
              '    double  anchor      = 0.0,\n'
              '    double  cacheExtent = RenderAbstractViewport.defaultCacheExtent,\n'
              '    int?    center,\n'
              '    List<RenderSliver>? children,\n'
              '  });\n'
              '}',
        ),
        const SizedBox(height: 16),
        const _CodeBlock(
          caption: 'box-to-sliver translation',
          code: 'void performLayout() {\n'
              '  size = constraints.biggest;\n'
              '  // For each sliver, build a SliverConstraints from this size,\n'
              '  // the current scroll offset, axis direction, and remaining\n'
              '  // paint extent. Then sliver.layout(sliverConstraints).\n'
              '  // Each sliver returns SliverGeometry, which we accumulate to\n'
              '  // place the next sliver in the scroll axis.\n'
              '}',
        ),
        const SizedBox(height: 16),
        const _MiniHeading(label: 'WHY IT MATTERS HERE', color: _Palette.indigo),
        const _Bullet(
          color: _Palette.indigo,
          text: 'It is included in the box family because, from its parent\'s '
              'perspective, it is a normal RenderBox — it consumes '
              'BoxConstraints and produces a Size.',
        ),
        const _Bullet(
          color: _Palette.indigo,
          text: 'From its children\'s perspective it is a sliver host — '
              'children consume SliverConstraints and produce SliverGeometry. '
              'The viewport translates between the two universes.',
        ),
        const _Bullet(
          color: _Palette.indigo,
          text: 'See the sliver demo file for the full sliver-side protocol; '
              'this card only documents the box-side surface.',
        ),
      ],
    );
  }
}
