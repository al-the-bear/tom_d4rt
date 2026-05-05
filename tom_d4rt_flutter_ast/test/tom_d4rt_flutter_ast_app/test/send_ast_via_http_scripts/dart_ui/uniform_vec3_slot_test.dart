// =============================================================================
// Deep demo: dart:ui UniformVec3Slot
// =============================================================================
//
// UniformVec3Slot is the typed handle for a 3-component (vec3) uniform inside
// a compiled Flutter FragmentProgram. When a fragment shader written for the
// Impeller / Skia runtime declares:
//
//      uniform vec3 u_tint;
//
// the program metadata exposes that uniform via a UniformVec3Slot whose
// numeric `slot` index points at the first of three contiguous 32-bit float
// cells in the GPU uniform buffer. The Dart side writes the three components
// using either the public per-float API:
//
//      shader.setFloat(slot + 0, r);
//      shader.setFloat(slot + 1, g);
//      shader.setFloat(slot + 2, b);
//
// ...or, when available, the typed convenience method:
//
//      shader.setVec3(slot, r, g, b);
//
// This file is a hand-authored "field guide" for the slot. It does NOT compile
// or invoke a fragment shader. The whole point is to *show* the API surface
// and the conceptual layout via static, scrollable visuals — exactly what you
// would put on a whiteboard for a teammate the first time they meet the vec3
// uniform contract.
//
// The script is sandboxed inside the SendTestRunner harness, so:
//   * no main / runApp,
//   * no StatefulWidget / setState / controllers,
//   * no Timer / Future / Stream,
//   * no print,
//   * no leading-underscore locals,
//   * Color.withValues(alpha: ...) instead of withOpacity,
//   * child / children last in widget constructors,
//   * const used everywhere it can be.
// =============================================================================

import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------
// Local shim for UniformVec3Slot.
//
// UniformVec3Slot is part of the dart:ui FragmentProgram metadata family. It
// is not constructable from public Flutter API and is not bridged uniformly
// across versions inside the AST sandbox. The class below is a tiny read-only
// placeholder that mirrors the relevant public-facing fields (slot index, the
// three float components, a semantic label, a short description). The demo
// only ever *reads* these fields when painting widgets.
// -----------------------------------------------------------------------------
class UniformVec3Slot {
  final int slot;
  final double x;
  final double y;
  final double z;
  final String label;
  final String purpose;

  const UniformVec3Slot({
    required this.slot,
    required this.x,
    required this.y,
    required this.z,
    required this.label,
    required this.purpose,
  });
}

// -----------------------------------------------------------------------------
// Palette: cyan / indigo / purple / teal accents on a near-black surface.
// Pure constants so every container can stay const.
// -----------------------------------------------------------------------------
class VPalette {
  static const Color surface = Color(0xFF06070C);
  static const Color surfaceAlt = Color(0xFF0C0E16);
  static const Color surfaceCard = Color(0xFF12141E);
  static const Color border = Color(0xFF1F2233);
  static const Color borderStrong = Color(0xFF2A2E45);
  static const Color textHi = Color(0xFFE6EAF5);
  static const Color textMid = Color(0xFF9AA4BD);
  static const Color textLo = Color(0xFF5A6480);

  static const Color cyan = Color(0xFF22D3EE);
  static const Color cyanDim = Color(0xFF0E7490);
  static const Color indigo = Color(0xFF6366F1);
  static const Color indigoDim = Color(0xFF312E81);
  static const Color purple = Color(0xFFA855F7);
  static const Color purpleDim = Color(0xFF581C87);
  static const Color teal = Color(0xFF14B8A6);
  static const Color tealDim = Color(0xFF134E4A);
  static const Color amber = Color(0xFFF59E0B);
  static const Color rose = Color(0xFFF43F5E);
  static const Color emerald = Color(0xFF10B981);
}

// -----------------------------------------------------------------------------
// Top-level entry point invoked by the SendTestRunner.
// Returns a Scaffold containing a SingleChildScrollView with the full guide.
// -----------------------------------------------------------------------------
dynamic build(BuildContext context) {
  return const Scaffold(
    backgroundColor: VPalette.surface,
    body: SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20, 24, 20, 56),
        child: VGuideRoot(),
      ),
    ),
  );
}

// =============================================================================
// Root layout: stacks every section with vertical spacing.
// =============================================================================
class VGuideRoot extends StatelessWidget {
  const VGuideRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        VHeroBanner(),
        SizedBox(height: 28),
        VSectionTitle(
          index: '01',
          title: 'Slot Taxonomy',
          subtitle: 'The full UniformSlot family used by FragmentProgram.',
        ),
        SizedBox(height: 14),
        VSlotTaxonomy(),
        SizedBox(height: 28),
        VSectionTitle(
          index: '02',
          title: 'Anatomy',
          subtitle: 'Program  ->  shader.setVec3(slot, x, y, z)  ->  GPU uniform memory.',
        ),
        SizedBox(height: 14),
        VAnatomyDiagram(),
        SizedBox(height: 28),
        VSectionTitle(
          index: '03',
          title: 'Vec3 as RGB Colour',
          subtitle: 'Eight sample vec3 values rendered as their colour interpretation.',
        ),
        SizedBox(height: 14),
        VColourGrid(),
        SizedBox(height: 28),
        VSectionTitle(
          index: '04',
          title: 'Vec3 as 3D Position',
          subtitle: 'Four samples plotted in a conceptual (x, y) plane with z as halo.',
        ),
        SizedBox(height: 14),
        VPositionGrid(),
        SizedBox(height: 28),
        VSectionTitle(
          index: '05',
          title: 'Use Cases',
          subtitle: 'Six common ways a fragment shader interprets a vec3 uniform.',
        ),
        SizedBox(height: 14),
        VUseCaseGrid(),
        SizedBox(height: 28),
        VSectionTitle(
          index: '06',
          title: 'API Surface',
          subtitle: 'How application code binds a vec3 to a fragment shader.',
        ),
        SizedBox(height: 14),
        VApiSurface(),
        SizedBox(height: 28),
        VSectionTitle(
          index: '07',
          title: 'Memory Layout',
          subtitle: 'Twelve consecutive float32 cells in the uniform buffer.',
        ),
        SizedBox(height: 14),
        VMemoryStrip(),
        SizedBox(height: 28),
        VSectionTitle(
          index: '08',
          title: 'vec2  vs  vec3  vs  vec4',
          subtitle: 'Width, byte cost and typical workload.',
        ),
        SizedBox(height: 14),
        VComparisonPanel(),
        SizedBox(height: 28),
        VSectionTitle(
          index: '09',
          title: 'Caveats',
          subtitle: 'Padding, alignment, runtime cost, portability.',
        ),
        SizedBox(height: 14),
        VCaveatsGrid(),
        SizedBox(height: 28),
        VSectionTitle(
          index: '10',
          title: 'Takeaways',
          subtitle: 'What to remember when you next write a vec3 uniform.',
        ),
        SizedBox(height: 14),
        VFooterCard(),
      ],
    );
  }
}

// =============================================================================
// Section 1: Hero banner.
//   - Cyan -> indigo gradient
//   - Inline glyph
//   - Title + subtitle + the same vec3 sample painted three different ways
// =============================================================================
class VHeroBanner extends StatelessWidget {
  const VHeroBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 26, 24, 26),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF0E7490),
            Color(0xFF312E81),
            Color(0xFF581C87),
          ],
        ),
        border: Border.all(color: VPalette.borderStrong),
        boxShadow: [
          BoxShadow(
            color: VPalette.cyan.withValues(alpha: 0.18),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              VHeroGlyph(),
              SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'dart:ui  -  FragmentProgram',
                      style: TextStyle(
                        color: VPalette.cyan,
                        fontSize: 12,
                        letterSpacing: 2.4,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'UniformVec3Slot',
                      style: TextStyle(
                        color: VPalette.textHi,
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.4,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Three packed float32s the GPU sees as a single vec3.',
                      style: TextStyle(
                        color: VPalette.textHi,
                        fontSize: 13,
                        height: 1.45,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 18),
          VHeroSampleStrip(),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// Decorative glyph: stack of cyan / indigo / purple bars to evoke a 3-channel
// uniform layout. Pure const, no painter.
// -----------------------------------------------------------------------------
class VHeroGlyph extends StatelessWidget {
  const VHeroGlyph({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: VPalette.surface.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: VPalette.borderStrong),
      ),
      child: const Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            VHeroBar(color: VPalette.cyan, label: 'X'),
            VHeroBar(color: VPalette.indigo, label: 'Y'),
            VHeroBar(color: VPalette.purple, label: 'Z'),
          ],
        ),
      ),
    );
  }
}

class VHeroBar extends StatelessWidget {
  final Color color;
  final String label;
  const VHeroBar({super.key, required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 12,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(3),
      ),
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 4),
      child: Text(
        label,
        style: const TextStyle(
          color: VPalette.surface,
          fontSize: 8,
          fontWeight: FontWeight.w900,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// Hero sample strip: same vec3 (0.13, 0.42, 0.85) shown as colour, position
// and direction. Reinforces "the bytes are agnostic, the meaning is yours".
// -----------------------------------------------------------------------------
class VHeroSampleStrip extends StatelessWidget {
  const VHeroSampleStrip({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: VPalette.surface.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: VPalette.borderStrong),
      ),
      child: const Row(
        children: [
          Expanded(
            child: VHeroSampleCell(
              caption: 'as RGB',
              swatch: Color(0xFF216BD9),
              line1: 'r 0.13',
              line2: 'g 0.42',
              line3: 'b 0.85',
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: VHeroSampleCell(
              caption: 'as XYZ',
              swatch: VPalette.indigo,
              line1: 'x 0.13',
              line2: 'y 0.42',
              line3: 'z 0.85',
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: VHeroSampleCell(
              caption: 'as DIR',
              swatch: VPalette.cyan,
              line1: 'dx 0.14',
              line2: 'dy 0.44',
              line3: 'dz 0.89',
            ),
          ),
        ],
      ),
    );
  }
}

class VHeroSampleCell extends StatelessWidget {
  final String caption;
  final Color swatch;
  final String line1;
  final String line2;
  final String line3;
  const VHeroSampleCell({
    super.key,
    required this.caption,
    required this.swatch,
    required this.line1,
    required this.line2,
    required this.line3,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: VPalette.surfaceCard.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: VPalette.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            caption,
            style: const TextStyle(
              color: VPalette.textMid,
              fontSize: 10,
              letterSpacing: 2,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            height: 22,
            decoration: BoxDecoration(
              color: swatch,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(height: 8),
          Text(line1, style: monoStyle),
          Text(line2, style: monoStyle),
          Text(line3, style: monoStyle),
        ],
      ),
    );
  }

  static const TextStyle monoStyle = TextStyle(
    color: VPalette.textHi,
    fontSize: 11,
    fontFamily: 'monospace',
  );
}

// =============================================================================
// Reusable section title.
// =============================================================================
class VSectionTitle extends StatelessWidget {
  final String index;
  final String title;
  final String subtitle;
  const VSectionTitle({
    super.key,
    required this.index,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: VPalette.surfaceCard,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: VPalette.cyan.withValues(alpha: 0.45)),
          ),
          alignment: Alignment.center,
          child: Text(
            index,
            style: const TextStyle(
              color: VPalette.cyan,
              fontSize: 13,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.4,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: VPalette.textHi,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.2,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                subtitle,
                style: const TextStyle(
                  color: VPalette.textMid,
                  fontSize: 12.5,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// =============================================================================
// Section 2: slot taxonomy.
//   - Wrap of chips representing the slot family
//   - Vec3 chip is highlighted
//   - Note about availability of typed vec3 setter
// =============================================================================
class VSlotTaxonomy extends StatelessWidget {
  const VSlotTaxonomy({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: VPalette.surfaceAlt,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: VPalette.border),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              VSlotChip(
                name: 'UniformFloatSlot',
                bytes: '4 B  -  1 x f32',
                colour: VPalette.teal,
                highlight: false,
              ),
              VSlotChip(
                name: 'UniformVec2Slot',
                bytes: '8 B  -  2 x f32',
                colour: VPalette.cyan,
                highlight: false,
              ),
              VSlotChip(
                name: 'UniformVec3Slot',
                bytes: '12 B  -  3 x f32',
                colour: VPalette.indigo,
                highlight: true,
              ),
              VSlotChip(
                name: 'UniformVec4Slot',
                bytes: '16 B  -  4 x f32',
                colour: VPalette.purple,
                highlight: false,
              ),
              VSlotChip(
                name: 'UniformIntSlot',
                bytes: '4 B  -  1 x i32',
                colour: VPalette.amber,
                highlight: false,
              ),
              VSlotChip(
                name: 'UniformIvec2Slot',
                bytes: '8 B  -  2 x i32',
                colour: VPalette.rose,
                highlight: false,
              ),
              VSlotChip(
                name: 'UniformMat4Slot',
                bytes: '64 B  -  16 x f32',
                colour: VPalette.emerald,
                highlight: false,
              ),
              VSlotChip(
                name: 'UniformSampler2DSlot',
                bytes: 'opaque tex',
                colour: VPalette.amber,
                highlight: false,
              ),
            ],
          ),
          SizedBox(height: 14),
          Text(
            'NOTE  -  not every Flutter SDK exposes every slot type as public '
            'Dart API. Some live only inside the engine metadata. The shapes '
            'shown here are the conceptual taxonomy, even when the public '
            'symbol is not directly constructable.',
            style: TextStyle(
              color: VPalette.textMid,
              fontSize: 11.5,
              height: 1.5,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}

class VSlotChip extends StatelessWidget {
  final String name;
  final String bytes;
  final Color colour;
  final bool highlight;
  const VSlotChip({
    super.key,
    required this.name,
    required this.bytes,
    required this.colour,
    required this.highlight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: highlight
            ? colour.withValues(alpha: 0.16)
            : VPalette.surfaceCard,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: highlight
              ? colour
              : VPalette.border,
          width: highlight ? 1.4 : 1,
        ),
        boxShadow: highlight
            ? [
                BoxShadow(
                  color: colour.withValues(alpha: 0.30),
                  blurRadius: 14,
                  offset: const Offset(0, 4),
                ),
              ]
            : const [],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: colour,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  color: highlight ? VPalette.textHi : VPalette.textHi,
                  fontSize: 12.5,
                  fontWeight: highlight ? FontWeight.w800 : FontWeight.w600,
                  fontFamily: 'monospace',
                ),
              ),
              const SizedBox(height: 2),
              Text(
                bytes,
                style: const TextStyle(
                  color: VPalette.textLo,
                  fontSize: 10,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// Section 3: Anatomy diagram.
//   - Three flow boxes: program -> setVec3 -> uniform memory
//   - Arrow connectors
//   - Side panel showing [x, y, z] cells
// =============================================================================
class VAnatomyDiagram extends StatelessWidget {
  const VAnatomyDiagram({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: VPalette.surfaceAlt,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: VPalette.border),
      ),
      child: const Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 3,
                child: VAnatomyBox(
                  badge: 'A',
                  badgeColor: VPalette.cyan,
                  title: 'FragmentProgram',
                  subtitle: 'Compiled .frag asset.\nExposes named uniform slots.',
                  body: 'final program = await ui.FragmentProgram\n'
                      '    .fromAsset(\'shaders/tint.frag\');',
                ),
              ),
              VAnatomyArrow(),
              Expanded(
                flex: 4,
                child: VAnatomyBox(
                  badge: 'B',
                  badgeColor: VPalette.indigo,
                  title: 'shader.setVec3',
                  subtitle: 'Application code stamps\nthree floats into the slot.',
                  body: 'final shader = program.fragmentShader();\n'
                      'shader.setVec3(slot, 0.20, 0.40, 0.80);',
                ),
              ),
              VAnatomyArrow(),
              Expanded(
                flex: 3,
                child: VAnatomyBox(
                  badge: 'C',
                  badgeColor: VPalette.purple,
                  title: 'GPU uniform memory',
                  subtitle: 'Three 32-bit floats sit\ncontiguously in the UBO.',
                  body: '[ x ][ y ][ z ]\nf32  f32  f32',
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          VAnatomySideStrip(),
        ],
      ),
    );
  }
}

class VAnatomyBox extends StatelessWidget {
  final String badge;
  final Color badgeColor;
  final String title;
  final String subtitle;
  final String body;
  const VAnatomyBox({
    super.key,
    required this.badge,
    required this.badgeColor,
    required this.title,
    required this.subtitle,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: VPalette.surfaceCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: VPalette.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  color: badgeColor,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  badge,
                  style: const TextStyle(
                    color: VPalette.surface,
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: VPalette.textHi,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: const TextStyle(
              color: VPalette.textMid,
              fontSize: 11.5,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: VPalette.surface,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: VPalette.border),
            ),
            child: Text(
              body,
              style: const TextStyle(
                color: VPalette.cyan,
                fontFamily: 'monospace',
                fontSize: 10.5,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class VAnatomyArrow extends StatelessWidget {
  const VAnatomyArrow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 4,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            VPalette.cyan.withValues(alpha: 0.35),
            VPalette.purple.withValues(alpha: 0.35),
          ],
        ),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// Anatomy side strip: shows the [x, y, z] uniform layout as three labelled
// cells, with byte offsets above each.
// -----------------------------------------------------------------------------
class VAnatomySideStrip extends StatelessWidget {
  const VAnatomySideStrip({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: VPalette.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: VPalette.border),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'CONCEPTUAL LAYOUT  -  inside the uniform buffer',
            style: TextStyle(
              color: VPalette.textMid,
              fontSize: 10.5,
              letterSpacing: 1.6,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              VLayoutCell(
                offset: '+ 0',
                comp: 'x',
                colour: VPalette.cyan,
              ),
              SizedBox(width: 6),
              VLayoutCell(
                offset: '+ 4',
                comp: 'y',
                colour: VPalette.indigo,
              ),
              SizedBox(width: 6),
              VLayoutCell(
                offset: '+ 8',
                comp: 'z',
                colour: VPalette.purple,
              ),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  '12 bytes total.  Some std140 layouts pad to 16 bytes so '
                  'the next vec4 stays aligned on a 16-byte boundary.',
                  style: TextStyle(
                    color: VPalette.textMid,
                    fontSize: 11,
                    height: 1.45,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class VLayoutCell extends StatelessWidget {
  final String offset;
  final String comp;
  final Color colour;
  const VLayoutCell({
    super.key,
    required this.offset,
    required this.comp,
    required this.colour,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          offset,
          style: const TextStyle(
            color: VPalette.textLo,
            fontFamily: 'monospace',
            fontSize: 10,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: colour.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: colour),
          ),
          alignment: Alignment.center,
          child: Text(
            comp,
            style: TextStyle(
              color: colour,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w900,
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }
}

// =============================================================================
// Section 4: Vec3 as RGB colour.
//   - 4-column grid (8 panels, 2 rows)
//   - Each panel: coloured square + vec3 label + RGB annotation
// =============================================================================
class VColourGrid extends StatelessWidget {
  const VColourGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            Expanded(
              child: VColourPanel(
                colour: Color(0xFFFF0000),
                label: 'vec3(1, 0, 0)',
                hint: 'pure red',
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: VColourPanel(
                colour: Color(0xFF00FF00),
                label: 'vec3(0, 1, 0)',
                hint: 'pure green',
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: VColourPanel(
                colour: Color(0xFF0000FF),
                label: 'vec3(0, 0, 1)',
                hint: 'pure blue',
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: VColourPanel(
                colour: Color(0xFFFFFF00),
                label: 'vec3(1, 1, 0)',
                hint: 'yellow',
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: VColourPanel(
                colour: Color(0xFFFFFFFF),
                label: 'vec3(1, 1, 1)',
                hint: 'white',
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: VColourPanel(
                colour: Color(0xFF800080),
                label: 'vec3(.5, 0, .5)',
                hint: 'half-tone purple',
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: VColourPanel(
                colour: Color(0xFF3366CC),
                label: 'vec3(.2, .4, .8)',
                hint: 'slate blue',
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: VColourPanel(
                colour: Color(0xFF009999),
                label: 'vec3(0, .6, .6)',
                hint: 'teal',
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class VColourPanel extends StatelessWidget {
  final Color colour;
  final String label;
  final String hint;
  const VColourPanel({
    super.key,
    required this.colour,
    required this.label,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: VPalette.surfaceCard,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: VPalette.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: BoxDecoration(
                color: colour,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: VPalette.borderStrong, width: 1.2),
                boxShadow: [
                  BoxShadow(
                    color: colour.withValues(alpha: 0.30),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              color: VPalette.textHi,
              fontSize: 11.5,
              fontWeight: FontWeight.w800,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(height: 2),
          Text(
            'RGB  -  $hint',
            style: const TextStyle(
              color: VPalette.textLo,
              fontSize: 10.5,
              letterSpacing: 0.4,
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// Section 5: Vec3 as 3D position.
//   - Four panels
//   - Stack with a faint grid, a positioned dot at (x, y),
//     and a halo whose size encodes z.
// =============================================================================
class VPositionGrid extends StatelessWidget {
  const VPositionGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: VPositionPanel(
            x: 0.20,
            y: 0.20,
            z: 0.10,
            label: 'vec3(.2, .2, .1)',
            hint: 'near corner, low z',
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: VPositionPanel(
            x: 0.50,
            y: 0.50,
            z: 0.50,
            label: 'vec3(.5, .5, .5)',
            hint: 'centred, mid depth',
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: VPositionPanel(
            x: 0.80,
            y: 0.30,
            z: 0.90,
            label: 'vec3(.8, .3, .9)',
            hint: 'far x, high z',
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: VPositionPanel(
            x: 0.30,
            y: 0.85,
            z: 0.30,
            label: 'vec3(.3, .85, .3)',
            hint: 'low y, low z',
          ),
        ),
      ],
    );
  }
}

class VPositionPanel extends StatelessWidget {
  final double x;
  final double y;
  final double z;
  final String label;
  final String hint;
  const VPositionPanel({
    super.key,
    required this.x,
    required this.y,
    required this.z,
    required this.label,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    final double haloSize = 12 + z * 56;
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: VPalette.surfaceCard,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: VPalette.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final double w = constraints.maxWidth;
                final double h = constraints.maxHeight;
                final double dotX = (w - 8) * x;
                final double dotY = (h - 8) * (1.0 - y);
                final double haloX = dotX + 4 - haloSize / 2;
                final double haloY = dotY + 4 - haloSize / 2;
                return Container(
                  decoration: BoxDecoration(
                    color: VPalette.surface,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: VPalette.border),
                  ),
                  child: Stack(
                    children: [
                      const Positioned.fill(child: VPositionGridLines()),
                      Positioned(
                        left: haloX,
                        top: haloY,
                        child: Container(
                          width: haloSize,
                          height: haloSize,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: VPalette.purple.withValues(alpha: 0.55),
                              width: 1.2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: VPalette.purple.withValues(alpha: 0.20),
                                blurRadius: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: dotX,
                        top: dotY,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: VPalette.cyan,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              color: VPalette.textHi,
              fontSize: 11,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            hint,
            style: const TextStyle(
              color: VPalette.textLo,
              fontSize: 10.5,
            ),
          ),
        ],
      ),
    );
  }
}

class VPositionGridLines extends StatelessWidget {
  const VPositionGridLines({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: VGridPainter());
  }
}

class VGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = VPalette.borderStrong.withValues(alpha: 0.55)
      ..strokeWidth = 0.7;
    const int divisions = 5;
    for (int i = 1; i < divisions; i = i + 1) {
      final double dx = size.width * i / divisions;
      final double dy = size.height * i / divisions;
      canvas.drawLine(Offset(dx, 0), Offset(dx, size.height), paint);
      canvas.drawLine(Offset(0, dy), Offset(size.width, dy), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// =============================================================================
// Section 6: Use-case grid.
//   - Six cards arranged 3 + 3
//   - Each card: icon, title, vec3 example, prose
// =============================================================================
class VUseCaseGrid extends StatelessWidget {
  const VUseCaseGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: VUseCaseCard(
                accent: VPalette.cyan,
                icon: Icons.palette_outlined,
                title: 'as RGB colour',
                example: 'vec3(0.96, 0.42, 0.13)',
                prose: 'Tinting, sky colour, gradient stops. The fragment '
                    'shader writes  fragColour = vec4(uTint, 1.0);  '
                    'directly.',
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: VUseCaseCard(
                accent: VPalette.indigo,
                icon: Icons.threed_rotation_outlined,
                title: 'as XYZ position',
                example: 'vec3(2.5, 1.0, -3.4)',
                prose: 'Camera position, light position, model anchor in '
                    'world-space. Treat as a point, not a direction.',
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: VUseCaseCard(
                accent: VPalette.purple,
                icon: Icons.flash_on_outlined,
                title: 'as light direction',
                example: 'normalize(vec3(.4, .8, .4))',
                prose: 'Often pre-normalised on the host. Treat as a unit '
                    'vector pointing AT the light from the surface.',
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: VUseCaseCard(
                accent: VPalette.teal,
                icon: Icons.aspect_ratio_outlined,
                title: 'as scale factor',
                example: 'vec3(1.0, 1.5, 1.0)',
                prose: 'Anisotropic scaling on the three axes. A vec3(1,1,1) '
                    'is identity scale.',
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: VUseCaseCard(
                accent: VPalette.amber,
                icon: Icons.tune_outlined,
                title: 'as HSL',
                example: 'vec3(0.55, 0.80, 0.50)',
                prose: 'Some shaders pick HSL over RGB because hue tweaks are '
                    'cheaper. Same three slots, different semantic.',
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: VUseCaseCard(
                accent: VPalette.rose,
                icon: Icons.crop_free_outlined,
                title: 'as bbox half-extent',
                example: 'vec3(64, 32, 16)',
                prose: 'Useful for AABB tests inside the shader. Three slots '
                    'cover all three axes without a vec4 padding penalty.',
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class VUseCaseCard extends StatelessWidget {
  final Color accent;
  final IconData icon;
  final String title;
  final String example;
  final String prose;
  const VUseCaseCard({
    super.key,
    required this.accent,
    required this.icon,
    required this.title,
    required this.example,
    required this.prose,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: VPalette.surfaceCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: VPalette.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: accent.withValues(alpha: 0.55)),
                ),
                alignment: Alignment.center,
                child: Icon(icon, color: accent, size: 16),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: VPalette.textHi,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            decoration: BoxDecoration(
              color: VPalette.surface,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: VPalette.border),
            ),
            child: Text(
              example,
              style: TextStyle(
                color: accent,
                fontFamily: 'monospace',
                fontSize: 11,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            prose,
            style: const TextStyle(
              color: VPalette.textMid,
              fontSize: 11.5,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// Section 7: API surface.
//   - Three monospace blocks: program load, shader handle, setVec3 / setFloat
//   - Note about typed vec3 vs three setFloat calls
// =============================================================================
class VApiSurface extends StatelessWidget {
  const VApiSurface({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: VPalette.surfaceAlt,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: VPalette.border),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VApiBlock(
            label: '1   load',
            code: '// in async setup before first frame:\n'
                'final program = await ui.FragmentProgram\n'
                '    .fromAsset(\'shaders/tint.frag\');',
            note: 'fromAsset is async.  In sandboxed scripts we cannot await, '
                'so the demo only describes the call.',
          ),
          SizedBox(height: 10),
          VApiBlock(
            label: '2   handle',
            code: '// once per draw, cheap:\n'
                'final shader = program.fragmentShader();',
            note: 'fragmentShader() returns a fresh FragmentShader you bind '
                'to a Paint via paint.shader = shader.',
          ),
          SizedBox(height: 10),
          VApiBlock(
            label: '3   bind via per-float',
            code: '// canonical, works on every Flutter SDK\n'
                'shader.setFloat(0, 0.20);  // x\n'
                'shader.setFloat(1, 0.40);  // y\n'
                'shader.setFloat(2, 0.80);  // z',
            note: 'setFloat takes a flat scalar index. A vec3 occupies three '
                'consecutive scalar slots starting at the base index.',
          ),
          SizedBox(height: 10),
          VApiBlock(
            label: '4   bind via setVec3',
            code: '// shorter, when the SDK exposes typed setters\n'
                'shader.setVec3(slot, 0.20, 0.40, 0.80);',
            note: 'setVec3 is an ergonomic wrapper. Internally it still '
                'writes three float32 cells. Not present on every SDK '
                'version.',
          ),
        ],
      ),
    );
  }
}

class VApiBlock extends StatelessWidget {
  final String label;
  final String code;
  final String note;
  const VApiBlock({
    super.key,
    required this.label,
    required this.code,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: VPalette.cyan,
            fontSize: 11,
            letterSpacing: 1.6,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: VPalette.surface,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: VPalette.border),
          ),
          child: Text(
            code,
            style: const TextStyle(
              color: VPalette.textHi,
              fontSize: 11.5,
              height: 1.55,
              fontFamily: 'monospace',
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          note,
          style: const TextStyle(
            color: VPalette.textMid,
            fontSize: 11,
            height: 1.45,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }
}

// =============================================================================
// Section 8: Memory layout strip.
//   - 12 cells representing 12 consecutive 32-bit floats
//   - First 3 highlighted as "vec3 slot 0"
//   - Cells 3..5 highlighted as "vec3 slot 1"
//   - Remaining 6 cells shown as faded "free / next vec3"
// =============================================================================
class VMemoryStrip extends StatelessWidget {
  const VMemoryStrip({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: VPalette.surfaceAlt,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: VPalette.border),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'UNIFORM BUFFER  -  contiguous float32 cells, 4 B each',
            style: TextStyle(
              color: VPalette.textMid,
              fontSize: 11,
              letterSpacing: 1.6,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 14),
          Row(
            children: [
              VMemCell(index: 0, group: 0, comp: 'x'),
              VMemCell(index: 1, group: 0, comp: 'y'),
              VMemCell(index: 2, group: 0, comp: 'z'),
              VMemCell(index: 3, group: 1, comp: 'x'),
              VMemCell(index: 4, group: 1, comp: 'y'),
              VMemCell(index: 5, group: 1, comp: 'z'),
              VMemCell(index: 6, group: 2, comp: '?'),
              VMemCell(index: 7, group: 2, comp: '?'),
              VMemCell(index: 8, group: 2, comp: '?'),
              VMemCell(index: 9, group: 2, comp: '?'),
              VMemCell(index: 10, group: 2, comp: '?'),
              VMemCell(index: 11, group: 2, comp: '?'),
            ],
          ),
          SizedBox(height: 14),
          Row(
            children: [
              VMemLegend(colour: VPalette.cyan, label: 'vec3 slot 0  -  setVec3(0, x, y, z)'),
              SizedBox(width: 18),
              VMemLegend(colour: VPalette.purple, label: 'vec3 slot 1  -  setVec3(3, x, y, z)'),
              SizedBox(width: 18),
              VMemLegend(colour: VPalette.textLo, label: 'free / next uniform'),
            ],
          ),
        ],
      ),
    );
  }
}

class VMemCell extends StatelessWidget {
  final int index;
  final int group;
  final String comp;
  const VMemCell({
    super.key,
    required this.index,
    required this.group,
    required this.comp,
  });

  @override
  Widget build(BuildContext context) {
    final Color colour;
    switch (group) {
      case 0:
        colour = VPalette.cyan;
        break;
      case 1:
        colour = VPalette.purple;
        break;
      default:
        colour = VPalette.textLo;
    }
    final bool faded = group == 2;
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2),
        height: 64,
        decoration: BoxDecoration(
          color: faded
              ? VPalette.surface
              : colour.withValues(alpha: 0.18),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: faded ? VPalette.border : colour,
            width: faded ? 1 : 1.4,
          ),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '+ ${index * 4}',
              style: const TextStyle(
                color: VPalette.textLo,
                fontSize: 9,
                fontFamily: 'monospace',
              ),
            ),
            const SizedBox(height: 2),
            Text(
              comp,
              style: TextStyle(
                color: faded ? VPalette.textLo : colour,
                fontSize: 18,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              'f32',
              style: TextStyle(
                color: faded ? VPalette.textLo : VPalette.textMid,
                fontSize: 8.5,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VMemLegend extends StatelessWidget {
  final Color colour;
  final String label;
  const VMemLegend({super.key, required this.colour, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            color: colour.withValues(alpha: 0.25),
            border: Border.all(color: colour),
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            color: VPalette.textMid,
            fontSize: 11,
            fontFamily: 'monospace',
          ),
        ),
      ],
    );
  }
}

// =============================================================================
// Section 9: Comparison panel.
//   - Three rows: vec2, vec3, vec4
//   - Each row: typed slot name, byte-cost bar, typical use
// =============================================================================
class VComparisonPanel extends StatelessWidget {
  const VComparisonPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: VPalette.surfaceAlt,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: VPalette.border),
      ),
      child: const Column(
        children: [
          VCompareRow(
            slotName: 'UniformVec2Slot',
            bytes: 8,
            cells: 2,
            colour: VPalette.cyan,
            highlight: false,
            useCase: 'uv  /  resolution  /  mouse coord',
          ),
          SizedBox(height: 8),
          VCompareRow(
            slotName: 'UniformVec3Slot',
            bytes: 12,
            cells: 3,
            colour: VPalette.indigo,
            highlight: true,
            useCase: 'rgb  /  xyz  /  light direction',
          ),
          SizedBox(height: 8),
          VCompareRow(
            slotName: 'UniformVec4Slot',
            bytes: 16,
            cells: 4,
            colour: VPalette.purple,
            highlight: false,
            useCase: 'rgba  /  quaternion  /  homogeneous',
          ),
        ],
      ),
    );
  }
}

class VCompareRow extends StatelessWidget {
  final String slotName;
  final int bytes;
  final int cells;
  final Color colour;
  final bool highlight;
  final String useCase;
  const VCompareRow({
    super.key,
    required this.slotName,
    required this.bytes,
    required this.cells,
    required this.colour,
    required this.highlight,
    required this.useCase,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: highlight
            ? colour.withValues(alpha: 0.16)
            : VPalette.surfaceCard,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: highlight ? colour : VPalette.border,
          width: highlight ? 1.4 : 1,
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 170,
            child: Text(
              slotName,
              style: TextStyle(
                color: VPalette.textHi,
                fontSize: 12.5,
                fontFamily: 'monospace',
                fontWeight: highlight ? FontWeight.w800 : FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                for (int i = 0; i < cells; i = i + 1)
                  Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        color: colour.withValues(alpha: 0.30),
                        border: Border.all(color: colour),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                const SizedBox(width: 8),
                Text(
                  '$bytes B',
                  style: const TextStyle(
                    color: VPalette.textMid,
                    fontSize: 11,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 230,
            child: Text(
              useCase,
              style: const TextStyle(
                color: VPalette.textMid,
                fontSize: 11.5,
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
// Section 10: Caveats grid.
//   - Four cards
// =============================================================================
class VCaveatsGrid extends StatelessWidget {
  const VCaveatsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: VCaveatCard(
                accent: VPalette.amber,
                icon: Icons.warning_amber_outlined,
                title: 'std140 padding',
                body: 'In std140 layouts, a vec3 is *aligned* to 16 bytes. '
                    'It still consumes 12 bytes of payload, but the next '
                    'uniform may be pushed to the next 16-byte boundary.',
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: VCaveatCard(
                accent: VPalette.rose,
                icon: Icons.compress_outlined,
                title: 'std430 packing',
                body: 'In std430 layouts (storage buffers), a vec3 is packed '
                    'tighter. Mixing std140 and std430 across host / device '
                    'is the source of most "uniforms look corrupted" bugs.',
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: VCaveatCard(
                accent: VPalette.teal,
                icon: Icons.speed_outlined,
                title: 'update cost',
                body: 'Each setFloat / setVec3 call rewrites the host-side '
                    'uniform image. The device upload happens at the next '
                    'draw, not on every setter call.',
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: VCaveatCard(
                accent: VPalette.purple,
                icon: Icons.public_outlined,
                title: 'GPU portability',
                body: 'Some mobile GPUs reject vec3 in old driver paths and '
                    'silently widen to vec4. If you see a black 4th channel, '
                    'check for an implicit padding pass.',
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class VCaveatCard extends StatelessWidget {
  final Color accent;
  final IconData icon;
  final String title;
  final String body;
  const VCaveatCard({
    super.key,
    required this.accent,
    required this.icon,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: VPalette.surfaceCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: VPalette.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(icon, color: accent, size: 16),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: VPalette.textHi,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            body,
            style: const TextStyle(
              color: VPalette.textMid,
              fontSize: 11.5,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// Section 11: Footer card. Plain takeaways.
// =============================================================================
class VFooterCard extends StatelessWidget {
  const VFooterCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            VPalette.indigoDim.withValues(alpha: 0.55),
            VPalette.purpleDim.withValues(alpha: 0.55),
          ],
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: VPalette.borderStrong),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Takeaways',
            style: TextStyle(
              color: VPalette.textHi,
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 10),
          VFooterBullet(
            text: 'A UniformVec3Slot is just an *index* into the uniform '
                'buffer. The semantic of the three floats is whatever your '
                '.frag file says it is.',
          ),
          VFooterBullet(
            text: 'On every Flutter SDK you can write the slot using three '
                'setFloat calls. setVec3 is sugar that some SDK versions '
                'expose on top.',
          ),
          VFooterBullet(
            text: 'Bytes are packed contiguously at the slot offset, but '
                'std140 may pad the *next* uniform to keep alignment. This '
                'is invisible on the host but visible on the device.',
          ),
          VFooterBullet(
            text: 'No real shader is compiled here. This file is a static '
                'visual field guide that runs entirely inside the AST '
                'sandbox.',
          ),
        ],
      ),
    );
  }
}

class VFooterBullet extends StatelessWidget {
  final String text;
  const VFooterBullet({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.only(top: 6, right: 10),
            decoration: const BoxDecoration(
              color: VPalette.cyan,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: VPalette.textHi,
                fontSize: 12.5,
                height: 1.55,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
