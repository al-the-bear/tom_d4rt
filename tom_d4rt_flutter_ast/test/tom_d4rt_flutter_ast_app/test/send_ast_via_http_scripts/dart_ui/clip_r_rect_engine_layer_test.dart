// D4rt test script: Deep visual demonstration of ClipRRectEngineLayer
//
// ClipRRectEngineLayer is the low-level engine-side layer that the Flutter
// engine records when a rounded-rectangle clip is pushed onto a SceneBuilder.
// Application code rarely constructs one directly: the high-level
// ClipRRect widget, the RenderClipRRect render object, and SceneBuilder.
// pushClipRRect emit these layers as part of the layer tree.
//
// This script walks through the user-facing surface area that produces a
// ClipRRectEngineLayer at the engine level: RRect / Radius geometry,
// BorderRadius cookbook, the ClipRRect widget, Clip behaviour modes,
// Canvas.clipRRect inside CustomPaint, and frosted-glass compositions that
// rely on rounded clipping to keep BackdropFilter and ShaderMask tidy.
//
// Imports note: dart:ui is aliased to `ui` so we can reference ui.RRect,
// ui.Radius and ui.Clip directly in narrative text and in CustomPaint code.

import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

// =============================================================================
// Palette — single source of truth for the demo's visual identity
// =============================================================================

const Color _kInk = Color(0xFF0F172A);
const Color _kInkSoft = Color(0xFF334155);
const Color _kMist = Color(0xFFE2E8F0);
const Color _kPaper = Color(0xFFF8FAFC);
const Color _kAccent = Color(0xFF6366F1);
const Color _kAccentDeep = Color(0xFF4338CA);
const Color _kAccentSoft = Color(0xFFC7D2FE);
const Color _kRose = Color(0xFFF43F5E);
const Color _kAmber = Color(0xFFF59E0B);
const Color _kEmerald = Color(0xFF10B981);
const Color _kCyan = Color(0xFF06B6D4);
const Color _kViolet = Color(0xFF8B5CF6);
const Color _kFuchsia = Color(0xFFD946EF);
const Color _kSlate = Color(0xFF64748B);

// =============================================================================
// Entry point consumed by the D4rt SendTestRunner harness
// =============================================================================

dynamic build(BuildContext context) {
  return Scaffold(
    backgroundColor: _kPaper,
    body: SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildHeroBanner(),
          const SizedBox(height: 28),
          _buildEngineLayerExplainer(),
          const SizedBox(height: 28),
          _buildRRectGeometryShowcase(),
          const SizedBox(height: 28),
          _buildRadiusVocabulary(),
          const SizedBox(height: 28),
          _buildBorderRadiusCookbook(),
          const SizedBox(height: 28),
          _buildBorderRadiusDirectionalSection(),
          const SizedBox(height: 28),
          _buildClipBehaviourMatrix(),
          const SizedBox(height: 28),
          _buildClipRRectGallery(),
          const SizedBox(height: 28),
          _buildCanvasClipRRectLab(),
          const SizedBox(height: 28),
          _buildFrostedGlassStack(),
          const SizedBox(height: 28),
          _buildShaderMaskCombo(),
          const SizedBox(height: 28),
          _buildLerpStrip(),
          const SizedBox(height: 28),
          _buildLayerTreeTimeline(),
          const SizedBox(height: 28),
          _buildPerformanceNotes(),
          const SizedBox(height: 28),
          _buildClosingPanel(),
        ],
      ),
    ),
  );
}

// =============================================================================
// Hero banner
// =============================================================================

Widget _buildHeroBanner() {
  return ClipRRect(
    borderRadius: const BorderRadius.all(Radius.circular(28)),
    child: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[_kAccentDeep, _kAccent, _kViolet],
        ),
      ),
      padding: const EdgeInsets.fromLTRB(28, 32, 28, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.35),
                  ),
                ),
                child: const Icon(
                  Icons.rounded_corner,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'ClipRRectEngineLayer',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.6,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'A guided tour of rounded-rectangle clipping in Flutter',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.85),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.25),
              ),
            ),
            child: const Text(
              'ClipRRectEngineLayer is created when SceneBuilder.pushClipRRect '
              'is invoked. ClipRRect, RenderClipRRect and Canvas.clipRRect all '
              'eventually feed into one of these layers in the engine layer tree.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: <Widget>[
              _heroChip('ui.RRect'),
              _heroChip('ui.Radius'),
              _heroChip('BorderRadius'),
              _heroChip('Clip.antiAlias'),
              _heroChip('SceneBuilder.pushClipRRect'),
              _heroChip('Canvas.clipRRect'),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _heroChip(String label) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.22),
      borderRadius: BorderRadius.circular(999),
      border: Border.all(color: Colors.white.withValues(alpha: 0.4)),
    ),
    child: Text(
      label,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 11,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.2,
      ),
    ),
  );
}

// =============================================================================
// Section header helper
// =============================================================================

Widget _sectionHeader(String number, String title, String subtitle) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Container(
        width: 44,
        height: 44,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: <Color>[_kAccent, _kViolet],
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          number,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
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
              style: const TextStyle(
                color: _kInk,
                fontSize: 20,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.4,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: const TextStyle(
                color: _kInkSoft,
                fontSize: 13,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _card({required Widget child, EdgeInsets? padding}) {
  return Container(
    padding: padding ?? const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: _kMist),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _kInk.withValues(alpha: 0.04),
          blurRadius: 18,
          offset: const Offset(0, 8),
        ),
      ],
    ),
    child: child,
  );
}

// =============================================================================
// SECTION 1 — Engine layer explainer
// =============================================================================

Widget _buildEngineLayerExplainer() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _sectionHeader(
        '01',
        'From widget to engine layer',
        'How a ClipRRect widget becomes a ClipRRectEngineLayer in the scene.',
      ),
      const SizedBox(height: 16),
      _card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              'When ClipRRect rebuilds, the RenderClipRRect render object '
              'pushes its rounded rect onto the layer tree. The compositor '
              'translates that into a SceneBuilder.pushClipRRect call, which '
              'returns an EngineLayer handle. That handle is, concretely, a '
              'ClipRRectEngineLayer — an opaque token the engine uses to '
              'recycle the underlying composited layer between frames.',
              style: TextStyle(color: _kInkSoft, fontSize: 13, height: 1.55),
            ),
            const SizedBox(height: 18),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(child: _pipelineStep('Widget', 'ClipRRect', _kAccent)),
                _pipelineArrow(),
                Expanded(
                  child: _pipelineStep(
                    'Render object',
                    'RenderClipRRect',
                    _kViolet,
                  ),
                ),
                _pipelineArrow(),
                Expanded(
                  child: _pipelineStep('Layer', 'ClipRRectLayer', _kFuchsia),
                ),
                _pipelineArrow(),
                Expanded(
                  child: _pipelineStep(
                    'Engine',
                    'ClipRRectEngineLayer',
                    _kRose,
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

Widget _pipelineStep(String role, String name, Color colour) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
    decoration: BoxDecoration(
      color: colour.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: colour.withValues(alpha: 0.4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          role.toUpperCase(),
          style: TextStyle(
            color: colour,
            fontSize: 9,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          name,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: _kInk,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
  );
}

Widget _pipelineArrow() {
  return const SizedBox(
    width: 24,
    child: Icon(Icons.chevron_right, color: _kSlate, size: 22),
  );
}

// =============================================================================
// SECTION 2 — RRect geometry showcase
// =============================================================================

Widget _buildRRectGeometryShowcase() {
  final List<_RRectSpec> specs = <_RRectSpec>[
    const _RRectSpec(
      label: 'fromLTRBR',
      summary: 'Single uniform radius',
      builder: _RRectBuilder.uniform,
      colour: _kAccent,
    ),
    const _RRectSpec(
      label: 'fromLTRBXY',
      summary: 'Independent X/Y radii',
      builder: _RRectBuilder.xyEllipse,
      colour: _kEmerald,
    ),
    const _RRectSpec(
      label: 'fromLTRBAndCorners',
      summary: 'Per-corner Radius',
      builder: _RRectBuilder.perCorner,
      colour: _kAmber,
    ),
    const _RRectSpec(
      label: 'fromRectXY',
      summary: 'Rect + elliptical radius',
      builder: _RRectBuilder.rectXY,
      colour: _kCyan,
    ),
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _sectionHeader(
        '02',
        'ui.RRect constructors at a glance',
        'Every flavour the engine layer ultimately consumes.',
      ),
      const SizedBox(height: 16),
      _card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: List<Widget>.generate(specs.length, (int index) {
            final _RRectSpec spec = specs[index];
            return Padding(
              padding: EdgeInsets.only(bottom: index == specs.length - 1 ? 0 : 14),
              child: _RRectSpecRow(spec: spec),
            );
          }),
        ),
      ),
    ],
  );
}

enum _RRectBuilder { uniform, xyEllipse, perCorner, rectXY }

class _RRectSpec {
  const _RRectSpec({
    required this.label,
    required this.summary,
    required this.builder,
    required this.colour,
  });

  final String label;
  final String summary;
  final _RRectBuilder builder;
  final Color colour;
}

class _RRectSpecRow extends StatelessWidget {
  const _RRectSpecRow({required this.spec});

  final _RRectSpec spec;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: spec.colour.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: spec.colour.withValues(alpha: 0.25)),
      ),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 80,
            height: 56,
            child: CustomPaint(
              painter: _RRectSamplePainter(
                builder: spec.builder,
                colour: spec.colour,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'ui.RRect.${spec.label}',
                  style: TextStyle(
                    color: spec.colour,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'monospace',
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  spec.summary,
                  style: const TextStyle(
                    color: _kInkSoft,
                    fontSize: 12,
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

class _RRectSamplePainter extends CustomPainter {
  const _RRectSamplePainter({required this.builder, required this.colour});

  final _RRectBuilder builder;
  final Color colour;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    final ui.RRect rrect;
    switch (builder) {
      case _RRectBuilder.uniform:
        rrect = ui.RRect.fromRectAndRadius(
          rect.deflate(4),
          const ui.Radius.circular(14),
        );
        break;
      case _RRectBuilder.xyEllipse:
        rrect = ui.RRect.fromRectXY(rect.deflate(4), 18, 8);
        break;
      case _RRectBuilder.perCorner:
        rrect = ui.RRect.fromRectAndCorners(
          rect.deflate(4),
          topLeft: const ui.Radius.circular(20),
          topRight: const ui.Radius.circular(4),
          bottomLeft: const ui.Radius.circular(4),
          bottomRight: const ui.Radius.circular(20),
        );
        break;
      case _RRectBuilder.rectXY:
        rrect = ui.RRect.fromRectXY(rect.deflate(4), 10, 18);
        break;
    }
    final Paint fill = Paint()..color = colour.withValues(alpha: 0.22);
    final Paint stroke = Paint()
      ..color = colour
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    canvas.drawRRect(rrect, fill);
    canvas.drawRRect(rrect, stroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// =============================================================================
// SECTION 3 — Radius vocabulary
// =============================================================================

Widget _buildRadiusVocabulary() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _sectionHeader(
        '03',
        'Radius vocabulary',
        'Radius.circular, Radius.elliptical and Radius.zero side by side.',
      ),
      const SizedBox(height: 16),
      _card(
        child: Row(
          children: <Widget>[
            Expanded(
              child: _radiusSample(
                title: 'Radius.zero',
                description: 'Sharp corner; degenerates into a rectangle clip.',
                radius: Radius.zero,
                colour: _kSlate,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _radiusSample(
                title: 'Radius.circular(18)',
                description: 'Equal X/Y, perfectly round corner.',
                radius: const Radius.circular(18),
                colour: _kAccent,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _radiusSample(
                title: 'Radius.elliptical(28, 10)',
                description: 'Stretched ellipse, useful for capsule edges.',
                radius: const Radius.elliptical(28, 10),
                colour: _kRose,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _radiusSample({
  required String title,
  required String description,
  required Radius radius,
  required Color colour,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      Container(
        height: 80,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              colour.withValues(alpha: 0.22),
              colour.withValues(alpha: 0.05),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.all(radius),
          border: Border.all(color: colour.withValues(alpha: 0.5), width: 2),
        ),
      ),
      const SizedBox(height: 10),
      Text(
        title,
        style: TextStyle(
          color: colour,
          fontSize: 12,
          fontWeight: FontWeight.w800,
        ),
      ),
      const SizedBox(height: 4),
      Text(
        description,
        style: const TextStyle(color: _kInkSoft, fontSize: 11, height: 1.4),
      ),
    ],
  );
}

// =============================================================================
// SECTION 4 — BorderRadius cookbook
// =============================================================================

Widget _buildBorderRadiusCookbook() {
  final List<_RecipeSpec> recipes = <_RecipeSpec>[
    const _RecipeSpec(
      title: 'BorderRadius.circular(20)',
      description: 'Uniform corner across all four edges.',
      radius: BorderRadius.all(Radius.circular(20)),
      colour: _kAccent,
    ),
    const _RecipeSpec(
      title: 'BorderRadius.all(Radius.elliptical(40, 14))',
      description: 'Capsule-like stretched corners.',
      radius: BorderRadius.all(Radius.elliptical(40, 14)),
      colour: _kRose,
    ),
    _RecipeSpec(
      title: 'BorderRadius.vertical(top: 24)',
      description: 'Bottom-sheet style — flat bottom, rounded top.',
      radius: const BorderRadius.vertical(top: Radius.circular(24)),
      colour: _kEmerald,
    ),
    _RecipeSpec(
      title: 'BorderRadius.horizontal(right: 24)',
      description: 'Tab-style: leading edge sharp, trailing edge round.',
      radius: const BorderRadius.horizontal(right: Radius.circular(24)),
      colour: _kAmber,
    ),
    _RecipeSpec(
      title: 'BorderRadius.only(topLeft, bottomRight)',
      description: 'Chat-bubble diagonal: opposite corners rounded.',
      radius: const BorderRadius.only(
        topLeft: Radius.circular(24),
        bottomRight: Radius.circular(24),
      ),
      colour: _kCyan,
    ),
    _RecipeSpec(
      title: 'BorderRadius.only(top huge)',
      description: 'Big top, small bottom — modal sheet hero.',
      radius: const BorderRadius.only(
        topLeft: Radius.circular(36),
        topRight: Radius.circular(36),
        bottomLeft: Radius.circular(6),
        bottomRight: Radius.circular(6),
      ),
      colour: _kViolet,
    ),
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _sectionHeader(
        '04',
        'BorderRadius cookbook',
        'Six recipes that show up over and over in real UI work.',
      ),
      const SizedBox(height: 16),
      _card(
        child: Wrap(
          spacing: 12,
          runSpacing: 12,
          children: List<Widget>.generate(recipes.length, (int index) {
            return SizedBox(
              width: 168,
              child: _RecipeTile(spec: recipes[index]),
            );
          }),
        ),
      ),
    ],
  );
}

class _RecipeSpec {
  const _RecipeSpec({
    required this.title,
    required this.description,
    required this.radius,
    required this.colour,
  });

  final String title;
  final String description;
  final BorderRadius radius;
  final Color colour;
}

class _RecipeTile extends StatelessWidget {
  const _RecipeTile({required this.spec});

  final _RecipeSpec spec;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _kPaper,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kMist),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            height: 64,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  spec.colour.withValues(alpha: 0.85),
                  spec.colour.withValues(alpha: 0.35),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: spec.radius,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            spec.title,
            style: const TextStyle(
              color: _kInk,
              fontSize: 10.5,
              fontWeight: FontWeight.w700,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(height: 4),
          Text(
            spec.description,
            style: const TextStyle(
              color: _kInkSoft,
              fontSize: 10,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// SECTION 5 — BorderRadiusDirectional
// =============================================================================

Widget _buildBorderRadiusDirectionalSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _sectionHeader(
        '05',
        'BorderRadiusDirectional in RTL',
        'topStart/topEnd flip with text direction; resolved to BorderRadius.',
      ),
      const SizedBox(height: 16),
      _card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: _directionalSample(
                    direction: TextDirection.ltr,
                    label: 'LTR',
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _directionalSample(
                    direction: TextDirection.rtl,
                    label: 'RTL',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            const Text(
              'The same BorderRadiusDirectional.only(topStart: 28, bottomEnd: 28) '
              'produces different geometry depending on the inherited '
              'Directionality. The render layer resolves it before the engine '
              'ever sees the final RRect.',
              style: TextStyle(color: _kInkSoft, fontSize: 12, height: 1.5),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _directionalSample({
  required TextDirection direction,
  required String label,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      Directionality(
        textDirection: direction,
        child: Container(
          height: 72,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: <Color>[_kFuchsia, _kViolet],
            ),
            borderRadius: const BorderRadiusDirectional.only(
              topStart: Radius.circular(28),
              bottomEnd: Radius.circular(28),
            ).resolve(direction),
          ),
          alignment: AlignmentDirectional.centerStart,
          padding: const EdgeInsetsDirectional.only(start: 16),
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 14,
            ),
          ),
        ),
      ),
      const SizedBox(height: 8),
      Text(
        'Directionality.$label',
        style: const TextStyle(color: _kInkSoft, fontSize: 11),
      ),
    ],
  );
}

// =============================================================================
// SECTION 6 — Clip behaviour matrix
// =============================================================================

Widget _buildClipBehaviourMatrix() {
  final List<_BehaviourSpec> behaviours = <_BehaviourSpec>[
    const _BehaviourSpec(
      mode: 'Clip.none',
      icon: Icons.block,
      colour: _kSlate,
      cost: 'free',
      quality: 'no clip',
      note: 'Layer is recorded but no clip is applied — children may overflow.',
    ),
    const _BehaviourSpec(
      mode: 'Clip.hardEdge',
      icon: Icons.crop_square,
      colour: _kEmerald,
      cost: 'cheapest',
      quality: 'aliased',
      note: 'Pixel-aligned clip, jaggy edges. Great for opaque shapes.',
    ),
    const _BehaviourSpec(
      mode: 'Clip.antiAlias',
      icon: Icons.blur_on,
      colour: _kAccent,
      cost: 'moderate',
      quality: 'smooth',
      note: 'Default for ClipRRect; smooth edges with a small GPU cost.',
    ),
    const _BehaviourSpec(
      mode: 'Clip.antiAliasWithSaveLayer',
      icon: Icons.layers,
      colour: _kRose,
      cost: 'expensive',
      quality: 'pristine',
      note: 'Allocates a saveLayer so blends respect the rounded boundary.',
    ),
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _sectionHeader(
        '06',
        'Clip behaviour matrix',
        'Four Clip values map to four different engine-side strategies.',
      ),
      const SizedBox(height: 16),
      _card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: List<Widget>.generate(behaviours.length, (int index) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: index == behaviours.length - 1 ? 0 : 10,
              ),
              child: _BehaviourRow(spec: behaviours[index]),
            );
          }),
        ),
      ),
    ],
  );
}

class _BehaviourSpec {
  const _BehaviourSpec({
    required this.mode,
    required this.icon,
    required this.colour,
    required this.cost,
    required this.quality,
    required this.note,
  });

  final String mode;
  final IconData icon;
  final Color colour;
  final String cost;
  final String quality;
  final String note;
}

class _BehaviourRow extends StatelessWidget {
  const _BehaviourRow({required this.spec});

  final _BehaviourSpec spec;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: spec.colour.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: spec.colour.withValues(alpha: 0.25)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: spec.colour.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(spec.icon, color: spec.colour, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  spec.mode,
                  style: TextStyle(
                    color: spec.colour,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'monospace',
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  spec.note,
                  style: const TextStyle(
                    color: _kInkSoft,
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: <Widget>[
                    _miniBadge('cost: ${spec.cost}', spec.colour),
                    const SizedBox(width: 6),
                    _miniBadge('quality: ${spec.quality}', spec.colour),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _miniBadge(String label, Color colour) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: colour.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(999),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: colour,
        fontSize: 10,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}

// =============================================================================
// SECTION 7 — ClipRRect gallery
// =============================================================================

Widget _buildClipRRectGallery() {
  final List<_GalleryEntry> entries = <_GalleryEntry>[
    const _GalleryEntry(
      title: 'Avatar disc',
      radius: BorderRadius.all(Radius.circular(40)),
      gradient: <Color>[_kAccent, _kViolet],
      icon: Icons.person,
    ),
    const _GalleryEntry(
      title: 'Pill button',
      radius: BorderRadius.all(Radius.circular(28)),
      gradient: <Color>[_kRose, _kAmber],
      icon: Icons.play_arrow,
    ),
    const _GalleryEntry(
      title: 'Card',
      radius: BorderRadius.all(Radius.circular(16)),
      gradient: <Color>[_kEmerald, _kCyan],
      icon: Icons.dashboard,
    ),
    const _GalleryEntry(
      title: 'Modal',
      radius: BorderRadius.vertical(top: Radius.circular(28)),
      gradient: <Color>[_kViolet, _kFuchsia],
      icon: Icons.bookmark,
    ),
    const _GalleryEntry(
      title: 'Chat bubble L',
      radius: BorderRadius.only(
        topLeft: Radius.circular(18),
        topRight: Radius.circular(18),
        bottomRight: Radius.circular(18),
        bottomLeft: Radius.circular(4),
      ),
      gradient: <Color>[_kCyan, _kAccent],
      icon: Icons.chat,
    ),
    const _GalleryEntry(
      title: 'Chat bubble R',
      radius: BorderRadius.only(
        topLeft: Radius.circular(18),
        topRight: Radius.circular(18),
        bottomLeft: Radius.circular(18),
        bottomRight: Radius.circular(4),
      ),
      gradient: <Color>[_kFuchsia, _kRose],
      icon: Icons.chat_bubble,
    ),
    const _GalleryEntry(
      title: 'Slanted ellipse',
      radius: BorderRadius.all(Radius.elliptical(38, 14)),
      gradient: <Color>[_kAmber, _kEmerald],
      icon: Icons.brightness_high,
    ),
    const _GalleryEntry(
      title: 'Asymmetric',
      radius: BorderRadius.only(
        topLeft: Radius.circular(28),
        bottomRight: Radius.circular(28),
      ),
      gradient: <Color>[_kAccentDeep, _kCyan],
      icon: Icons.swap_horiz,
    ),
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _sectionHeader(
        '07',
        'ClipRRect gallery',
        'A grid of common shapes built directly with ClipRRect.',
      ),
      const SizedBox(height: 16),
      _card(
        child: Wrap(
          spacing: 12,
          runSpacing: 12,
          children: List<Widget>.generate(entries.length, (int index) {
            return SizedBox(
              width: 110,
              child: _GalleryTile(entry: entries[index]),
            );
          }),
        ),
      ),
    ],
  );
}

class _GalleryEntry {
  const _GalleryEntry({
    required this.title,
    required this.radius,
    required this.gradient,
    required this.icon,
  });

  final String title;
  final BorderRadius radius;
  final List<Color> gradient;
  final IconData icon;
}

class _GalleryTile extends StatelessWidget {
  const _GalleryTile({required this.entry});

  final _GalleryEntry entry;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        ClipRRect(
          borderRadius: entry.radius,
          clipBehavior: Clip.antiAlias,
          child: Container(
            height: 84,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: entry.gradient,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            alignment: Alignment.center,
            child: Icon(entry.icon, color: Colors.white, size: 30),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          entry.title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: _kInk,
            fontSize: 11,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

// =============================================================================
// SECTION 8 — Canvas.clipRRect lab
// =============================================================================

Widget _buildCanvasClipRRectLab() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _sectionHeader(
        '08',
        'Canvas.clipRRect lab',
        'Direct CustomPainter usage of canvas.clipRRect with overflowing geometry.',
      ),
      const SizedBox(height: 16),
      _card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 220,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: _canvasSample(
                      title: 'No clip',
                      painter: const _ClipLabPainter(applyClip: false),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: _canvasSample(
                      title: 'canvas.clipRRect',
                      painter: const _ClipLabPainter(applyClip: true),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            const Text(
              'In both panels the painter draws the same set of overlapping '
              'circles. The right-hand panel pushes a clipRRect onto the '
              'canvas before drawing — the engine resolves this into a '
              'transient ClipRRectEngineLayer inside the picture recording.',
              style: TextStyle(color: _kInkSoft, fontSize: 12, height: 1.5),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _canvasSample({required String title, required CustomPainter painter}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      Expanded(
        child: Container(
          decoration: BoxDecoration(
            color: _kPaper,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: _kMist),
          ),
          child: CustomPaint(painter: painter, size: Size.infinite),
        ),
      ),
      const SizedBox(height: 6),
      Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: _kInkSoft,
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
    ],
  );
}

class _ClipLabPainter extends CustomPainter {
  const _ClipLabPainter({required this.applyClip});

  final bool applyClip;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    final ui.RRect clip = ui.RRect.fromRectAndCorners(
      rect.deflate(10),
      topLeft: const ui.Radius.circular(28),
      topRight: const ui.Radius.circular(6),
      bottomLeft: const ui.Radius.circular(6),
      bottomRight: const ui.Radius.circular(28),
    );
    if (applyClip) {
      canvas.save();
      canvas.clipRRect(clip);
    }
    final List<Color> palette = <Color>[
      _kAccent,
      _kRose,
      _kEmerald,
      _kAmber,
      _kViolet,
      _kCyan,
      _kFuchsia,
    ];
    final math.Random rng = math.Random(7);
    for (int i = 0; i < 26; i++) {
      final double dx = rng.nextDouble() * size.width;
      final double dy = rng.nextDouble() * size.height;
      final double r = 14 + rng.nextDouble() * 38;
      final Paint p = Paint()
        ..color = palette[i % palette.length].withValues(alpha: 0.55)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(Offset(dx, dy), r, p);
    }
    if (applyClip) {
      canvas.restore();
      final Paint stroke = Paint()
        ..color = _kInk
        ..strokeWidth = 1.5
        ..style = PaintingStyle.stroke;
      canvas.drawRRect(clip, stroke);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// =============================================================================
// SECTION 9 — Frosted glass stack
// =============================================================================

Widget _buildFrostedGlassStack() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _sectionHeader(
        '09',
        'Frosted glass with ClipRRect',
        'Rounded clipping keeps BackdropFilter and translucent panels tidy.',
      ),
      const SizedBox(height: 16),
      _card(
        child: SizedBox(
          height: 280,
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: CustomPaint(painter: const _BlobsPainter()),
                ),
              ),
              const Positioned(
                left: 24,
                top: 24,
                right: 24,
                child: _GlassCard(
                  title: 'Now Playing',
                  subtitle: 'A frosted card uses ClipRRect to bound the blur.',
                  accent: _kAccent,
                ),
              ),
              const Positioned(
                left: 60,
                bottom: 24,
                right: 24,
                child: _GlassCard(
                  title: 'Up next',
                  subtitle:
                      'Stacking two glass cards demonstrates how the clip '
                      'isolates each backdrop blur.',
                  accent: _kRose,
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

class _GlassCard extends StatelessWidget {
  const _GlassCard({
    required this.title,
    required this.subtitle,
    required this.accent,
  });

  final String title;
  final String subtitle;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.55),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withValues(alpha: 0.6)),
        ),
        child: Row(
          children: <Widget>[
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.graphic_eq, color: accent, size: 24),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: const TextStyle(
                      color: _kInk,
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: _kInkSoft,
                      fontSize: 11,
                      height: 1.4,
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

class _BlobsPainter extends CustomPainter {
  const _BlobsPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()
      ..shader = const LinearGradient(
        colors: <Color>[_kAccentSoft, Colors.white],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Offset.zero & size);
    canvas.drawRect(Offset.zero & size, bg);

    final List<Color> blobs = <Color>[
      _kAccent,
      _kRose,
      _kEmerald,
      _kAmber,
      _kViolet,
      _kCyan,
    ];
    final math.Random rng = math.Random(13);
    for (int i = 0; i < 12; i++) {
      final double dx = rng.nextDouble() * size.width;
      final double dy = rng.nextDouble() * size.height;
      final double r = 40 + rng.nextDouble() * 60;
      final Paint p = Paint()
        ..color = blobs[i % blobs.length].withValues(alpha: 0.42);
      canvas.drawCircle(Offset(dx, dy), r, p);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// =============================================================================
// SECTION 10 — ShaderMask + ClipRRect combo
// =============================================================================

Widget _buildShaderMaskCombo() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _sectionHeader(
        '10',
        'ClipRRect + ShaderMask',
        'Compose rounded clipping with a gradient mask for fade-out edges.',
      ),
      const SizedBox(height: 16),
      _card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: ShaderMask(
                blendMode: BlendMode.dstIn,
                shaderCallback: (Rect rect) {
                  return const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: <Color>[
                      Colors.transparent,
                      Colors.black,
                      Colors.black,
                      Colors.transparent,
                    ],
                    stops: <double>[0, 0.08, 0.92, 1],
                  ).createShader(rect);
                },
                child: Container(
                  height: 96,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[_kViolet, _kAccent, _kCyan, _kEmerald],
                    ),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'fade-in / fade-out edges',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14),
            const Text(
              'The ClipRRect keeps the rounded silhouette intact while the '
              'ShaderMask blends the inner content against an alpha gradient. '
              'Without the rounded clip, the soft edges from the ShaderMask '
              'would extend into the parent container.',
              style: TextStyle(color: _kInkSoft, fontSize: 12, height: 1.5),
            ),
          ],
        ),
      ),
    ],
  );
}

// =============================================================================
// SECTION 11 — BorderRadius.lerp strip
// =============================================================================

Widget _buildLerpStrip() {
  const int steps = 8;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _sectionHeader(
        '11',
        'BorderRadius.lerp',
        'Interpolating between two corner profiles, eight steps.',
      ),
      const SizedBox(height: 16),
      _card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: List<Widget>.generate(steps, (int index) {
                final double t = index / (steps - 1);
                final BorderRadius? r = BorderRadius.lerp(
                  const BorderRadius.all(Radius.circular(4)),
                  const BorderRadius.only(
                    topLeft: Radius.circular(36),
                    bottomRight: Radius.circular(36),
                  ),
                  t,
                );
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: Container(
                      height: 80,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: <Color>[
                            Color.lerp(_kAccent, _kRose, t) ?? _kAccent,
                            Color.lerp(_kCyan, _kAmber, t) ?? _kCyan,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: r ?? BorderRadius.zero,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        't=${t.toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 14),
            const Text(
              'BorderRadius.lerp is what AnimatedContainer and tween-based '
              'morphs use under the hood. Every interpolated value still '
              'produces a ClipRRectEngineLayer when applied.',
              style: TextStyle(color: _kInkSoft, fontSize: 12, height: 1.5),
            ),
          ],
        ),
      ),
    ],
  );
}

// =============================================================================
// SECTION 12 — Layer tree timeline
// =============================================================================

Widget _buildLayerTreeTimeline() {
  final List<_TimelineStep> steps = <_TimelineStep>[
    const _TimelineStep(
      title: 'paint phase',
      detail:
          'RenderClipRRect.paint records a clipRRect on the recording Canvas '
          'or pushes a ClipRRectLayer onto the composite layer tree.',
      colour: _kAccent,
      icon: Icons.brush,
    ),
    const _TimelineStep(
      title: 'compositing',
      detail:
          'During flush, the framework iterates layer children and either '
          'reuses an existing ClipRRectEngineLayer or asks the engine for a '
          'fresh one via SceneBuilder.pushClipRRect.',
      colour: _kViolet,
      icon: Icons.layers,
    ),
    const _TimelineStep(
      title: 'engine layer cache',
      detail:
          'The returned ClipRRectEngineLayer handle is stashed on the layer '
          'so subsequent frames can re-use the GPU resources without '
          'rebuilding the clip texture.',
      colour: _kRose,
      icon: Icons.memory,
    ),
    const _TimelineStep(
      title: 'rasterisation',
      detail:
          'When the scene is rasterised, the engine applies the rounded '
          'clip — anti-aliased or not — based on the Clip behaviour stored '
          'alongside the layer.',
      colour: _kEmerald,
      icon: Icons.flash_on,
    ),
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _sectionHeader(
        '12',
        'Frame timeline',
        'How a ClipRRect contributes to a single frame.',
      ),
      const SizedBox(height: 16),
      _card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: List<Widget>.generate(steps.length, (int index) {
            final bool isLast = index == steps.length - 1;
            return _timelineEntry(steps[index], isLast);
          }),
        ),
      ),
    ],
  );
}

class _TimelineStep {
  const _TimelineStep({
    required this.title,
    required this.detail,
    required this.colour,
    required this.icon,
  });

  final String title;
  final String detail;
  final Color colour;
  final IconData icon;
}

Widget _timelineEntry(_TimelineStep step, bool isLast) {
  return IntrinsicHeight(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              width: 36,
              height: 36,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: step.colour.withValues(alpha: 0.16),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(step.icon, color: step.colour, size: 20),
            ),
            if (!isLast)
              Expanded(
                child: Container(
                  width: 2,
                  color: step.colour.withValues(alpha: 0.18),
                ),
              ),
          ],
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(bottom: isLast ? 0 : 14),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: step.colour.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: step.colour.withValues(alpha: 0.25)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    step.title.toUpperCase(),
                    style: TextStyle(
                      color: step.colour,
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.1,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    step.detail,
                    style: const TextStyle(
                      color: _kInkSoft,
                      fontSize: 12,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 13 — Performance notes
// =============================================================================

Widget _buildPerformanceNotes() {
  final List<_NoteSpec> notes = <_NoteSpec>[
    const _NoteSpec(
      title: 'Prefer BoxDecoration when you can',
      detail:
          'BoxDecoration with a borderRadius does not allocate a separate '
          'clip layer; the border is painted as part of the same draw call.',
      icon: Icons.check_circle,
      colour: _kEmerald,
    ),
    const _NoteSpec(
      title: 'ClipRRect is cheap for opaque children',
      detail:
          'Clip.antiAlias on opaque content is essentially free. The expense '
          'is in saveLayer mode, which compositions blends require.',
      icon: Icons.info,
      colour: _kAccent,
    ),
    const _NoteSpec(
      title: 'Avoid antiAliasWithSaveLayer in lists',
      detail:
          'Each item allocates a save layer; for long scrolling lists, '
          'switch to Clip.antiAlias and keep children opaque.',
      icon: Icons.warning_amber,
      colour: _kAmber,
    ),
    const _NoteSpec(
      title: 'Reuse engine layers',
      detail:
          'Stable widget trees let Flutter retain the underlying '
          'ClipRRectEngineLayer between frames. Avoid rebuilding the RRect '
          'geometry on every tick if nothing actually changed.',
      icon: Icons.bolt,
      colour: _kViolet,
    ),
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _sectionHeader(
        '13',
        'Performance notes',
        'Practical advice when ClipRRect shows up in a profile.',
      ),
      const SizedBox(height: 16),
      _card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: List<Widget>.generate(notes.length, (int index) {
            final _NoteSpec note = notes[index];
            return Padding(
              padding: EdgeInsets.only(
                bottom: index == notes.length - 1 ? 0 : 10,
              ),
              child: _noteTile(note),
            );
          }),
        ),
      ),
    ],
  );
}

class _NoteSpec {
  const _NoteSpec({
    required this.title,
    required this.detail,
    required this.icon,
    required this.colour,
  });

  final String title;
  final String detail;
  final IconData icon;
  final Color colour;
}

Widget _noteTile(_NoteSpec note) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: note.colour.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: note.colour.withValues(alpha: 0.25)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(note.icon, color: note.colour, size: 22),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                note.title,
                style: TextStyle(
                  color: note.colour,
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                note.detail,
                style: const TextStyle(
                  color: _kInkSoft,
                  fontSize: 12,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 14 — Closing panel
// =============================================================================

Widget _buildClosingPanel() {
  return ClipRRect(
    borderRadius: const BorderRadius.all(Radius.circular(24)),
    child: Container(
      padding: const EdgeInsets.fromLTRB(24, 26, 24, 26),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[_kInk, _kAccentDeep],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 44,
                height: 44,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.bookmark_added,
                  color: Colors.white,
                  size: 22,
                ),
              ),
              const SizedBox(width: 14),
              const Expanded(
                child: Text(
                  'Recap',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _recapBullet(
            'ClipRRectEngineLayer is the engine-side artefact recorded for '
            'every rounded-rect clip in a Flutter scene.',
          ),
          _recapBullet(
            'High-level entry points: ClipRRect widget, RenderClipRRect, '
            'Canvas.clipRRect, SceneBuilder.pushClipRRect.',
          ),
          _recapBullet(
            'Geometry comes from ui.RRect, ui.Radius and BorderRadius — '
            'BorderRadiusDirectional resolves to BorderRadius based on '
            'Directionality.',
          ),
          _recapBullet(
            'Clip behaviour modes trade visual fidelity for GPU cost: prefer '
            'Clip.antiAlias unless blends demand saveLayer.',
          ),
          _recapBullet(
            'ClipRRect composes cleanly with BackdropFilter, ShaderMask and '
            'CustomPaint to deliver familiar UI flourishes.',
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
            ),
            child: const Text(
              'D4rt-interpreted Flutter scene · ClipRRectEngineLayer deep demo',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.3,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _recapBullet(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 6,
          height: 6,
          margin: const EdgeInsets.only(top: 6, right: 10),
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.92),
              fontSize: 12.5,
              height: 1.55,
            ),
          ),
        ),
      ],
    ),
  );
}
