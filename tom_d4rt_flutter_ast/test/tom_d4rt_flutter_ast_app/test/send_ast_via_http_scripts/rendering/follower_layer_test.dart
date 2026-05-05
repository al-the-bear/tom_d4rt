// D4rt deep-visual demo: FollowerLayer from package:flutter/rendering.dart.
//
// This file is the LAYER-LEVEL companion to render_follower_layer_test.dart.
// While the sibling file demonstrates the render-object surface (indigo/purple
// palette, widget pairs in focus), this file zooms in on the compositing-time
// data structure: where FollowerLayer sits inside the layer tree, how its
// transform is derived from its leader, and how the LayerLink state machine
// dictates whether it paints, what offset it applies, and whether it must
// recompute its inherited transform.
//
// FollowerLayer extends ContainerLayer. It owns a `link` (LayerLink), a
// `showWhenUnlinked` flag, an `unlinkedOffset` and a `linkedOffset`. At
// composite time the engine walks up to the root, finds the LeaderLayer that
// shares the same LayerLink, captures its `_lastTransform`, and rebases the
// follower's subtree to sit on top of that transform plus the configured
// linkedOffset.
//
// Palette: slate -> cyan. Distinct from the render-object companion (indigo /
// purple) so the two demos remain visually orthogonal. Style: layer-tree
// diagrams, link-state pills, transform inheritance schematics.

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' as rendering;
import 'package:flutter/widgets.dart' as widgets;

// ============================================================================
// Top-level LayerLink instances. Declared as top-level finals so the live
// CompositedTransformTarget / CompositedTransformFollower demos below can
// reference real, persistent links rather than throwaway instances created
// inside build(). This mirrors how LayerLinks are typically hoisted into
// State objects in production code.
// ============================================================================

final rendering.LayerLink linkAvatarBadge = rendering.LayerLink();
final rendering.LayerLink linkButtonTooltip = rendering.LayerLink();
final rendering.LayerLink linkLinkedDemo = rendering.LayerLink();
final rendering.LayerLink linkUnlinkedShowDemo = rendering.LayerLink();
final rendering.LayerLink linkUnlinkedHideDemo = rendering.LayerLink();
final rendering.LayerLink linkOffsetDemo = rendering.LayerLink();

// Reference a widgets-prefixed type to keep the explicit widgets import
// load-bearing (avoids unnecessary_import).
typedef BuildCtx = widgets.BuildContext;

// ============================================================================
// Slate / cyan palette. Carefully picked so this file is visually distinct
// from the render_follower_layer_test.dart sibling (which leans indigo and
// purple). Slate handles structural ink; cyan handles accent, link state,
// and transform-inheritance highlights.
// ============================================================================

const Color slate900 = Color(0xFF0F172A);
const Color slate800 = Color(0xFF1E293B);
const Color slate700 = Color(0xFF334155);
const Color slate600 = Color(0xFF475569);
const Color slate500 = Color(0xFF64748B);
const Color slate400 = Color(0xFF94A3B8);
const Color slate300 = Color(0xFFCBD5E1);
const Color slate200 = Color(0xFFE2E8F0);
const Color slate100 = Color(0xFFF1F5F9);
const Color slate050 = Color(0xFFF8FAFC);

const Color cyan700 = Color(0xFF0E7490);
const Color cyan600 = Color(0xFF0891B2);
const Color cyan500 = Color(0xFF06B6D4);
const Color cyan400 = Color(0xFF22D3EE);
const Color cyan300 = Color(0xFF67E8F9);
const Color cyan200 = Color(0xFFA5F3FC);
const Color cyan100 = Color(0xFFCFFAFE);

const Color amber500 = Color(0xFFF59E0B);
const Color rose500 = Color(0xFFF43F5E);
const Color emerald500 = Color(0xFF10B981);
const Color violet500 = Color(0xFF8B5CF6);

// ============================================================================
// build entrypoint — required contract: top-level dynamic build(BuildContext).
// ============================================================================

dynamic build(BuildContext context) {
  return Scaffold(
    backgroundColor: slate100,
    body: SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          HeroHeaderSection(),
          SizedBox(height: 28),
          LayerTreePlacementSection(),
          SizedBox(height: 28),
          LinkStateMachineSection(),
          SizedBox(height: 28),
          TransformInheritanceSection(),
          SizedBox(height: 28),
          ShowWhenUnlinkedSection(),
          SizedBox(height: 28),
          CoordinateMathSection(),
          SizedBox(height: 28),
          LayerComparisonSection(),
          SizedBox(height: 28),
          LiveAnchoredBadgeSection(),
          SizedBox(height: 28),
          LiveFloatingTooltipSection(),
          SizedBox(height: 28),
          CaveatsSection(),
          SizedBox(height: 28),
          FooterSection(),
          SizedBox(height: 24),
        ],
      ),
    ),
  );
}

// ============================================================================
// SECTION 1 — Hero header.
// Slate -> cyan gradient with stacked-layer iconography that hints at the
// nested compositing groups managed by a FollowerLayer.
// ============================================================================

class HeroHeaderSection extends StatelessWidget {
  const HeroHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(28, 28, 28, 32),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [slate900, slate700, cyan700],
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: cyan700.withValues(alpha: 0.35),
            blurRadius: 32,
            offset: const Offset(0, 18),
          ),
          BoxShadow(
            color: slate900.withValues(alpha: 0.32),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const StackedLayersIcon(),
          const SizedBox(width: 22),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: cyan300.withValues(alpha: 0.22),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(
                      color: cyan200.withValues(alpha: 0.50),
                    ),
                  ),
                  child: const Text(
                    'package:flutter/rendering.dart',
                    style: TextStyle(
                      color: cyan100,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.1,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                const Text(
                  'FollowerLayer',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 38,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.8,
                    height: 1.0,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'extends ContainerLayer',
                  style: TextStyle(
                    color: cyan200,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'monospace',
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  'A compositing-time layer that re-bases its subtree onto the '
                  'transform of a LeaderLayer it is linked to. The engine '
                  'rewrites the inherited transform whenever the leader moves, '
                  'so the follower\'s children always paint at the right '
                  'world-space coordinates.',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.92),
                    fontSize: 14,
                    height: 1.55,
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    HeroBadge(label: 'link', color: cyan300),
                    SizedBox(width: 10),
                    HeroBadge(label: 'linkedOffset', color: cyan300),
                    SizedBox(width: 10),
                    HeroBadge(label: 'unlinkedOffset', color: cyan300),
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

class StackedLayersIcon extends StatelessWidget {
  const StackedLayersIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 88,
      height: 88,
      child: Stack(
        children: [
          Positioned(
            left: 14,
            top: 14,
            child: LayerCard(
              size: 52,
              tint: cyan700,
              border: cyan500,
            ),
          ),
          Positioned(
            left: 22,
            top: 26,
            child: LayerCard(
              size: 52,
              tint: cyan600,
              border: cyan400,
            ),
          ),
          Positioned(
            left: 30,
            top: 38,
            child: LayerCard(
              size: 52,
              tint: cyan500,
              border: cyan300,
            ),
          ),
          const Positioned(
            left: 50,
            top: 58,
            child: Icon(
              Icons.link_rounded,
              color: Colors.white,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}

class LayerCard extends StatelessWidget {
  final double size;
  final Color tint;
  final Color border;

  const LayerCard({
    super.key,
    required this.size,
    required this.tint,
    required this.border,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: tint.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: border, width: 1.4),
        boxShadow: [
          BoxShadow(
            color: slate900.withValues(alpha: 0.30),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
    );
  }
}

class HeroBadge extends StatelessWidget {
  final String label;
  final Color color;

  const HeroBadge({super.key, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.55)),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.w600,
          fontFamily: 'monospace',
        ),
      ),
    );
  }
}

// ============================================================================
// SECTION 2 — Layer tree placement.
// Vertical tree diagram showing where FollowerLayer typically sits in a real
// composited frame: RootLayer -> TransformLayer -> ContainerLayer ->
// FollowerLayer (this) -> child layers.
// ============================================================================

class LayerTreePlacementSection extends StatelessWidget {
  const LayerTreePlacementSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionShell(
      number: '02',
      title: 'Where it sits in the layer tree',
      subtitle:
          'The engine walks up to the root each composite, so FollowerLayer\'s '
          'final transform depends on every ancestor in the chain.',
      children: const [
        LayerTreeDiagram(),
        SizedBox(height: 18),
        LayerTreeAnnotations(),
      ],
    );
  }
}

class LayerTreeDiagram extends StatelessWidget {
  const LayerTreeDiagram({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 22, 18, 22),
      decoration: BoxDecoration(
        color: slate900,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: slate900.withValues(alpha: 0.18),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: const Column(
        children: [
          LayerTreeNode(
            type: 'RootLayer',
            note: 'top of the tree, owned by the engine',
            tint: cyan300,
            level: 0,
            isLast: false,
          ),
          LayerTreeNode(
            type: 'TransformLayer',
            note: 'device pixel ratio + flutter view scale',
            tint: cyan400,
            level: 1,
            isLast: false,
          ),
          LayerTreeNode(
            type: 'ContainerLayer',
            note: 'the containing render group (e.g. Overlay)',
            tint: cyan500,
            level: 2,
            isLast: false,
          ),
          LayerTreeNode(
            type: 'FollowerLayer  ← this layer',
            note: 'rebases subtree onto the leader\'s transform',
            tint: cyan300,
            level: 3,
            isLast: false,
            highlight: true,
          ),
          LayerTreeNode(
            type: 'OffsetLayer / OpacityLayer / …',
            note: 'whatever the follower\'s children paint',
            tint: cyan600,
            level: 4,
            isLast: false,
          ),
          LayerTreeNode(
            type: 'PictureLayer',
            note: 'rasterised draw commands',
            tint: cyan700,
            level: 5,
            isLast: true,
          ),
        ],
      ),
    );
  }
}

class LayerTreeNode extends StatelessWidget {
  final String type;
  final String note;
  final Color tint;
  final int level;
  final bool isLast;
  final bool highlight;

  const LayerTreeNode({
    super.key,
    required this.type,
    required this.note,
    required this.tint,
    required this.level,
    required this.isLast,
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: level * 22.0),
          Container(
            margin: const EdgeInsets.only(top: 6, right: 10),
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: tint,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: tint.withValues(alpha: 0.55),
                  blurRadius: 8,
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: highlight
                    ? cyan500.withValues(alpha: 0.18)
                    : slate800,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: highlight
                      ? cyan300.withValues(alpha: 0.65)
                      : slate700,
                  width: highlight ? 1.4 : 1.0,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    type,
                    style: TextStyle(
                      color: highlight ? cyan100 : Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'monospace',
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    note,
                    style: TextStyle(
                      color: slate300.withValues(alpha: 0.85),
                      fontSize: 11.5,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LayerTreeAnnotations extends StatelessWidget {
  const LayerTreeAnnotations({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cyan100.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: cyan300.withValues(alpha: 0.6)),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnnotationRow(
            tag: 'note',
            text:
                'The leader does NOT have to be an ancestor of the follower. '
                'It can live in a completely different subtree — that\'s why '
                'tooltips inside an Overlay can still follow a button buried '
                'deep in the page.',
          ),
          SizedBox(height: 8),
          AnnotationRow(
            tag: 'invariant',
            text:
                'The leader MUST have been composited (painted) earlier in '
                'the same frame. Otherwise its `_lastTransform` is null and '
                'the follower falls into the unlinked branch.',
          ),
        ],
      ),
    );
  }
}

class AnnotationRow extends StatelessWidget {
  final String tag;
  final String text;

  const AnnotationRow({super.key, required this.tag, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: cyan700,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            tag,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.1,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: slate800,
              fontSize: 12.5,
              height: 1.45,
            ),
          ),
        ),
      ],
    );
  }
}

// ============================================================================
// SECTION 3 — Link state machine.
// Four pills describing how the follower behaves in each state of the
// LayerLink relationship.
// ============================================================================

class LinkStateMachineSection extends StatelessWidget {
  const LinkStateMachineSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionShell(
      number: '03',
      title: 'The LayerLink state machine',
      subtitle:
          'Four observable states. Each one maps to a distinct branch in '
          'FollowerLayer.applyTransform / addToScene.',
      children: const [
        StatePill(
          label: 'Unlinked',
          icon: Icons.link_off_rounded,
          accent: rose500,
          condition: 'link.leader == null',
          behaviour:
              'No leader is mounted. If showWhenUnlinked is true the subtree '
              'paints at unlinkedOffset relative to the follower\'s natural '
              'position. Otherwise the entire subtree is skipped during '
              'compositing — the children are never added to the scene.',
        ),
        SizedBox(height: 12),
        StatePill(
          label: 'Linked-NotComposited',
          icon: Icons.cloud_off_rounded,
          accent: amber500,
          condition: 'link.leader != null && leader._lastTransform == null',
          behaviour:
              'The leader exists in the tree but has not been painted yet '
              'this frame. Common for leaders that became visible after the '
              'follower was already added to the scene. Treated like '
              'unlinked: skip subtree (or paint at unlinkedOffset).',
        ),
        SizedBox(height: 12),
        StatePill(
          label: 'Linked-Composited',
          icon: Icons.link_rounded,
          accent: emerald500,
          condition: 'link.leader != null && leader._lastTransform != null',
          behaviour:
              'The happy path. The engine pulls the leader\'s last composited '
              'transform, multiplies it by the inverse of the follower\'s '
              'composite-position transform, applies linkedOffset, and pushes '
              'the resulting transform onto the scene before walking the '
              'follower\'s children.',
        ),
        SizedBox(height: 12),
        StatePill(
          label: 'Stale-Transform',
          icon: Icons.history_rounded,
          accent: violet500,
          condition: 'leader transform changed AFTER follower painted',
          behaviour:
              'When markNeedsAddToScene fires on the link, every follower '
              'attached to the link is invalidated so the scene rebuilds with '
              'fresh transforms. Without this signal, followers would lag a '
              'frame behind a moving leader.',
        ),
      ],
    );
  }
}

class StatePill extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color accent;
  final String condition;
  final String behaviour;

  const StatePill({
    super.key,
    required this.label,
    required this.icon,
    required this.accent,
    required this.condition,
    required this.behaviour,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: slate200),
        boxShadow: [
          BoxShadow(
            color: slate900.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.12),
              shape: BoxShape.circle,
              border: Border.all(color: accent.withValues(alpha: 0.55)),
            ),
            child: Icon(icon, color: accent, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      label,
                      style: const TextStyle(
                        color: slate900,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: slate100,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: slate200),
                      ),
                      child: Text(
                        condition,
                        style: const TextStyle(
                          color: slate700,
                          fontSize: 10.5,
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  behaviour,
                  style: const TextStyle(
                    color: slate700,
                    fontSize: 12.5,
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
}

// ============================================================================
// SECTION 4 — Transform inheritance diagram.
// A custom-painted schematic: leader at world (80, 60) with a 15° rotation,
// follower subtree composited with that transform applied plus a linkedOffset
// (0, 56). Draws axes, leader anchor, follower anchor, transform arrow.
// ============================================================================

class TransformInheritanceSection extends StatelessWidget {
  const TransformInheritanceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionShell(
      number: '04',
      title: 'Transform inheritance, visualised',
      subtitle:
          'Leader at world (80, 60) with rotation 15°. Follower\'s subtree '
          'inherits exactly that transform, with linkedOffset (0, 56) applied '
          'on top.',
      children: const [
        SizedBox(
          height: 280,
          child: TransformInheritanceCanvas(),
        ),
        SizedBox(height: 16),
        TransformInheritanceLegend(),
      ],
    );
  }
}

class TransformInheritanceCanvas extends StatelessWidget {
  const TransformInheritanceCanvas({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [slate050, slate100],
          ),
          border: Border.all(color: slate200),
        ),
        child: const CustomPaint(
          painter: TransformInheritancePainter(),
          size: Size.infinite,
        ),
      ),
    );
  }
}

class TransformInheritancePainter extends CustomPainter {
  const TransformInheritancePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint grid = Paint()
      ..color = slate200.withValues(alpha: 0.65)
      ..strokeWidth = 0.6;
    for (double x = 0; x < size.width; x += 24) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
    }
    for (double y = 0; y < size.height; y += 24) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }

    final Paint axis = Paint()
      ..color = slate500
      ..strokeWidth = 1.2;
    canvas.drawLine(const Offset(20, 240), Offset(size.width - 20, 240), axis);
    canvas.drawLine(const Offset(40, 20), const Offset(40, 260), axis);

    final TextPainter axisX = TextPainter(
      text: const TextSpan(
        text: 'world.x',
        style: TextStyle(color: slate600, fontSize: 11),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    axisX.paint(canvas, Offset(size.width - 70, 244));
    final TextPainter axisY = TextPainter(
      text: const TextSpan(
        text: 'world.y',
        style: TextStyle(color: slate600, fontSize: 11),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    axisY.paint(canvas, const Offset(44, 14));

    const Offset leaderCenter = Offset(140, 120);
    canvas.save();
    canvas.translate(leaderCenter.dx, leaderCenter.dy);
    canvas.rotate(15 * 3.14159265 / 180);
    final Paint leaderFill = Paint()..color = cyan600.withValues(alpha: 0.85);
    final Paint leaderBorder = Paint()
      ..color = cyan300
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6;
    final Rect leaderRect = Rect.fromCenter(
      center: Offset.zero,
      width: 110,
      height: 60,
    );
    final RRect leaderRR = RRect.fromRectAndRadius(
      leaderRect,
      const Radius.circular(8),
    );
    canvas.drawRRect(leaderRR, leaderFill);
    canvas.drawRRect(leaderRR, leaderBorder);
    final TextPainter leaderLabel = TextPainter(
      text: const TextSpan(
        text: 'Leader\n(80, 60) · rot 15°',
        style: TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.w600,
          height: 1.3,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: 100);
    leaderLabel.paint(
      canvas,
      Offset(-leaderLabel.width / 2, -leaderLabel.height / 2),
    );
    canvas.restore();

    canvas.save();
    canvas.translate(leaderCenter.dx, leaderCenter.dy);
    canvas.rotate(15 * 3.14159265 / 180);
    canvas.translate(0, 56);
    final Paint followerFill = Paint()
      ..color = amber500.withValues(alpha: 0.85);
    final Paint followerBorder = Paint()
      ..color = amber500
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6;
    final Rect followerRect = Rect.fromCenter(
      center: Offset.zero,
      width: 130,
      height: 50,
    );
    final RRect followerRR = RRect.fromRectAndRadius(
      followerRect,
      const Radius.circular(8),
    );
    canvas.drawRRect(followerRR, followerFill);
    canvas.drawRRect(followerRR, followerBorder);
    final TextPainter followerLabel = TextPainter(
      text: const TextSpan(
        text: 'Follower subtree\nlinkedOffset (0, 56)',
        style: TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.w600,
          height: 1.3,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: 120);
    followerLabel.paint(
      canvas,
      Offset(-followerLabel.width / 2, -followerLabel.height / 2),
    );
    canvas.restore();

    final Paint flowPaint = Paint()
      ..color = cyan700
      ..strokeWidth = 1.6
      ..style = PaintingStyle.stroke;
    final Path flow = Path()
      ..moveTo(220, 100)
      ..cubicTo(320, 60, 380, 160, 460, 120);
    canvas.drawPath(flow, flowPaint);

    final Paint arrowHead = Paint()..color = cyan700;
    final Path arrow = Path()
      ..moveTo(460, 120)
      ..lineTo(450, 114)
      ..lineTo(450, 126)
      ..close();
    canvas.drawPath(arrow, arrowHead);

    final TextPainter flowLabel = TextPainter(
      text: const TextSpan(
        text: 'inherits leader.lastTransform',
        style: TextStyle(
          color: cyan700,
          fontSize: 12,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w600,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    flowLabel.paint(canvas, const Offset(290, 70));

    final Paint inheritedFill = Paint()
      ..color = emerald500.withValues(alpha: 0.85);
    final Paint inheritedBorder = Paint()
      ..color = emerald500
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6;
    canvas.save();
    canvas.translate(500, 130);
    canvas.rotate(15 * 3.14159265 / 180);
    final Rect childRect = Rect.fromCenter(
      center: Offset.zero,
      width: 110,
      height: 50,
    );
    final RRect childRR = RRect.fromRectAndRadius(
      childRect,
      const Radius.circular(8),
    );
    canvas.drawRRect(childRR, inheritedFill);
    canvas.drawRRect(childRR, inheritedBorder);
    final TextPainter childLabel = TextPainter(
      text: const TextSpan(
        text: 'Subtree paints\nat world coords',
        style: TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.w600,
          height: 1.3,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: 100);
    childLabel.paint(
      canvas,
      Offset(-childLabel.width / 2, -childLabel.height / 2),
    );
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant TransformInheritancePainter oldDelegate) =>
      false;
}

class TransformInheritanceLegend extends StatelessWidget {
  const TransformInheritanceLegend({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: slate050,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: slate200),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LegendChip(color: cyan600, label: 'leader'),
          SizedBox(height: 6),
          LegendChip(color: amber500, label: 'follower (raw)'),
          SizedBox(height: 6),
          LegendChip(color: emerald500, label: 'follower subtree (composited)'),
        ],
      ),
    );
  }
}

class LegendChip extends StatelessWidget {
  final Color color;
  final String label;

  const LegendChip({super.key, required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            color: slate800,
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

// ============================================================================
// SECTION 5 — showWhenUnlinked / unlinkedOffset showcase.
// Four cards backed by REAL CompositedTransformTarget / Follower widgets to
// demonstrate the live behaviour of each combination.
// ============================================================================

class ShowWhenUnlinkedSection extends StatelessWidget {
  const ShowWhenUnlinkedSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionShell(
      number: '05',
      title: 'showWhenUnlinked / unlinkedOffset',
      subtitle:
          'Four real CompositedTransformTarget + Follower pairs. Each card '
          'isolates one combination so the layer\'s painting branch is '
          'unambiguous.',
      children: [
        Wrap(
          spacing: 14,
          runSpacing: 14,
          children: [
            UnlinkedDemoCard(
              title: 'Linked',
              subtitle: 'leader present, transform composited',
              showWhenUnlinked: false,
              hasLeader: true,
              unlinkedOffset: Offset.zero,
              link: linkLinkedDemo,
              accent: emerald500,
            ),
            UnlinkedDemoCard(
              title: 'Unlinked + show',
              subtitle: 'leader absent, follower paints anyway',
              showWhenUnlinked: true,
              hasLeader: false,
              unlinkedOffset: Offset.zero,
              link: linkUnlinkedShowDemo,
              accent: amber500,
            ),
            UnlinkedDemoCard(
              title: 'Unlinked + hide',
              subtitle: 'leader absent, subtree skipped',
              showWhenUnlinked: false,
              hasLeader: false,
              unlinkedOffset: Offset.zero,
              link: linkUnlinkedHideDemo,
              accent: rose500,
            ),
            UnlinkedDemoCard(
              title: 'Unlinked + offset',
              subtitle: 'unlinkedOffset (24, 12) applied',
              showWhenUnlinked: true,
              hasLeader: false,
              unlinkedOffset: Offset(24, 12),
              link: linkOffsetDemo,
              accent: violet500,
            ),
          ],
        ),
      ],
    );
  }
}

class UnlinkedDemoCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool showWhenUnlinked;
  final bool hasLeader;
  final Offset unlinkedOffset;
  final LayerLink link;
  final Color accent;

  const UnlinkedDemoCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.showWhenUnlinked,
    required this.hasLeader,
    required this.unlinkedOffset,
    required this.link,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: slate200),
        boxShadow: [
          BoxShadow(
            color: slate900.withValues(alpha: 0.07),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: accent.withValues(alpha: 0.55)),
            ),
            child: Text(
              title,
              style: TextStyle(
                color: accent,
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.4,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            subtitle,
            style: const TextStyle(
              color: slate700,
              fontSize: 11.5,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 110,
            child: Stack(
              children: [
                if (hasLeader)
                  Positioned(
                    left: 18,
                    top: 30,
                    child: CompositedTransformTarget(
                      link: link,
                      child: Container(
                        width: 60,
                        height: 30,
                        decoration: BoxDecoration(
                          color: cyan500,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'leader',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                Positioned(
                  left: 110,
                  top: 70,
                  child: CompositedTransformFollower(
                    link: link,
                    showWhenUnlinked: showWhenUnlinked,
                    offset: unlinkedOffset,
                    child: Container(
                      width: 60,
                      height: 24,
                      decoration: BoxDecoration(
                        color: accent,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        'follower',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'showWhenUnlinked: $showWhenUnlinked',
            style: const TextStyle(
              color: slate600,
              fontSize: 10.5,
              fontFamily: 'monospace',
            ),
          ),
          Text(
            'unlinkedOffset: ${unlinkedOffset.dx.toStringAsFixed(0)}, '
            '${unlinkedOffset.dy.toStringAsFixed(0)}',
            style: const TextStyle(
              color: slate600,
              fontSize: 10.5,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// SECTION 6 — Coordinate math.
// A code-block panel with pseudo-Dart for getLastTransform() and an
// explanation of how the engine derives the follower's effective transform
// from the leader's last composited transform plus the follower's own
// composite-position transform.
// ============================================================================

class CoordinateMathSection extends StatelessWidget {
  const CoordinateMathSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionShell(
      number: '06',
      title: 'Coordinate math',
      subtitle:
          'How the engine arrives at the final 4x4 transform applied to the '
          'follower\'s subtree at composite time.',
      children: const [
        CodeBlock(
          title: 'FollowerLayer.getLastTransform()  (paraphrased)',
          lines: [
            'Matrix4? getLastTransform() {',
            '  if (link.leader == null) return null;',
            '  if (link.leader._lastTransform == null) return null;',
            '',
            '  // 1. Walk the follower\'s ancestor chain to compute the',
            '  //    transform from the follower\'s composite-position to',
            '  //    the layer-tree root.',
            '  final result = Matrix4.identity();',
            '  applyTransform(this, result);',
            '',
            '  // 2. Take the leader\'s recorded last transform (its',
            '  //    composite-time transform from leader\'s own coords to',
            '  //    the tree root).',
            '  result.multiply(_invertedTransform);',
            '  result.multiply(link.leader._lastTransform);',
            '',
            '  // 3. Apply the configured linkedOffset.',
            '  result.translate(linkedOffset.dx, linkedOffset.dy);',
            '  return result;',
            '}',
          ],
        ),
        SizedBox(height: 14),
        CodeBlockExplanation(),
      ],
    );
  }
}

class CodeBlock extends StatelessWidget {
  final String title;
  final List<String> lines;

  const CodeBlock({super.key, required this.title, required this.lines});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: slate900,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: slate800),
        boxShadow: [
          BoxShadow(
            color: slate900.withValues(alpha: 0.18),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: const BoxDecoration(
              color: slate800,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(11),
                topRight: Radius.circular(11),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: rose500,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: amber500,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: emerald500,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 14),
                Text(
                  title,
                  style: const TextStyle(
                    color: cyan200,
                    fontSize: 12,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final String line in lines)
                  Text(
                    line.isEmpty ? ' ' : line,
                    style: TextStyle(
                      color: line.trimLeft().startsWith('//')
                          ? slate400
                          : Colors.white.withValues(alpha: 0.92),
                      fontSize: 12,
                      fontFamily: 'monospace',
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
}

class CodeBlockExplanation extends StatelessWidget {
  const CodeBlockExplanation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cyan100.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: cyan300.withValues(alpha: 0.6)),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ExplanationLine(
            num: '①',
            text:
                'Compute follower\'s root-relative transform by walking up the '
                'parent chain. This is exactly the matrix that would put the '
                'follower\'s natural position into the scene.',
          ),
          SizedBox(height: 6),
          ExplanationLine(
            num: '②',
            text:
                'Invert it and chain with the leader\'s recorded transform — '
                'the resulting matrix maps from follower\'s natural position '
                'to leader\'s painted position.',
          ),
          SizedBox(height: 6),
          ExplanationLine(
            num: '③',
            text:
                'Translate by linkedOffset. This is the offset the user '
                'configured between the leader anchor and the follower anchor.',
          ),
        ],
      ),
    );
  }
}

class ExplanationLine extends StatelessWidget {
  final String num;
  final String text;

  const ExplanationLine({super.key, required this.num, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          num,
          style: const TextStyle(
            color: cyan700,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: slate800,
              fontSize: 12.5,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}

// ============================================================================
// SECTION 7 — Layer comparison.
// FollowerLayer vs TransformLayer vs ContainerLayer in three columns.
// ============================================================================

class LayerComparisonSection extends StatelessWidget {
  const LayerComparisonSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionShell(
      number: '07',
      title: 'FollowerLayer vs neighbours',
      subtitle:
          'Three sibling layer types in the rendering library, side-by-side.',
      children: const [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ComparisonColumn(
                title: 'ContainerLayer',
                accent: slate600,
                bullets: [
                  'Plain parent in the layer tree',
                  'No transform of its own',
                  'Just owns its children list',
                  'Engine walks subtree as-is',
                ],
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: ComparisonColumn(
                title: 'TransformLayer',
                accent: cyan600,
                bullets: [
                  'Stores a Matrix4 directly',
                  'Applied to subtree at composite',
                  'Static at compositing time',
                  'No leader/follower coupling',
                ],
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: ComparisonColumn(
                title: 'FollowerLayer',
                accent: emerald500,
                bullets: [
                  'Inherits transform from a leader',
                  'Re-derived every composite',
                  'Cross-tree linking via LayerLink',
                  'Can hide subtree if unlinked',
                ],
                highlight: true,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class ComparisonColumn extends StatelessWidget {
  final String title;
  final Color accent;
  final List<String> bullets;
  final bool highlight;

  const ComparisonColumn({
    super.key,
    required this.title,
    required this.accent,
    required this.bullets,
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 16),
      decoration: BoxDecoration(
        color: highlight ? cyan100.withValues(alpha: 0.45) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: highlight
              ? cyan300.withValues(alpha: 0.85)
              : slate200,
          width: highlight ? 1.4 : 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: accent,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11.5,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.4,
              ),
            ),
          ),
          const SizedBox(height: 10),
          for (final String b in bullets)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 5, right: 8),
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: accent,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      b,
                      style: const TextStyle(
                        color: slate800,
                        fontSize: 12,
                        height: 1.4,
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

// ============================================================================
// SECTION 8 — Live demo: anchored badge.
// Real CompositedTransformTarget (avatar) + CompositedTransformFollower (red
// numeric badge), exactly as a notification badge would be authored.
// ============================================================================

class LiveAnchoredBadgeSection extends StatelessWidget {
  const LiveAnchoredBadgeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionShell(
      number: '08',
      title: 'Live demo · anchored badge',
      subtitle:
          'Avatar carries the LeaderLayer; the red counter overlays it via a '
          'FollowerLayer with linkedOffset (32, -6).',
      children: [
        Container(
          height: 130,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: slate200),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                left: 30,
                top: 30,
                child: CompositedTransformTarget(
                  link: linkAvatarBadge,
                  child: Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [cyan500, cyan700],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: cyan700.withValues(alpha: 0.40),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.person_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 30,
                top: 30,
                child: CompositedTransformFollower(
                  link: linkAvatarBadge,
                  showWhenUnlinked: false,
                  offset: const Offset(34, -6),
                  child: Container(
                    width: 28,
                    height: 22,
                    decoration: BoxDecoration(
                      color: rose500,
                      borderRadius: BorderRadius.circular(11),
                      border: Border.all(color: Colors.white, width: 1.5),
                      boxShadow: [
                        BoxShadow(
                          color: rose500.withValues(alpha: 0.45),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      '12',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ),
              const Positioned(
                left: 110,
                top: 36,
                child: SizedBox(
                  width: 220,
                  child: Text(
                    'CompositedTransformTarget(link: …)\n'
                    'CompositedTransformFollower(link: …, offset: (34, -6))',
                    style: TextStyle(
                      color: slate700,
                      fontSize: 11.5,
                      fontFamily: 'monospace',
                      height: 1.5,
                    ),
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

// ============================================================================
// SECTION 9 — Live demo: floating tooltip with arrow.
// Same pattern, with a tooltip body and a downward-pointing arrow. The
// FollowerLayer paints the entire tooltip group at a configured offset above
// the target button.
// ============================================================================

class LiveFloatingTooltipSection extends StatelessWidget {
  const LiveFloatingTooltipSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionShell(
      number: '09',
      title: 'Live demo · floating tooltip',
      subtitle:
          'Button carries the leader; the tooltip body + arrow live inside '
          'the FollowerLayer subtree, anchored above by linkedOffset.',
      children: [
        Container(
          height: 200,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: slate900,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                left: 60,
                bottom: 24,
                child: CompositedTransformTarget(
                  link: linkButtonTooltip,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: cyan500,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: cyan500.withValues(alpha: 0.55),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.info_outline_rounded,
                          color: Colors.white,
                          size: 16,
                        ),
                        SizedBox(width: 6),
                        Text(
                          'Hover target',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 60,
                bottom: 24,
                child: CompositedTransformFollower(
                  link: linkButtonTooltip,
                  showWhenUnlinked: false,
                  offset: const Offset(0, -68),
                  child: const TooltipBubble(),
                ),
              ),
              const Positioned(
                right: 18,
                top: 18,
                child: SizedBox(
                  width: 200,
                  child: Text(
                    'The follower\'s entire subtree (bubble + arrow) inherits '
                    'one composited transform from the leader. Moving the '
                    'button moves the tooltip in lock-step.',
                    style: TextStyle(
                      color: slate200,
                      fontSize: 11.5,
                      height: 1.5,
                    ),
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

class TooltipBubble extends StatelessWidget {
  const TooltipBubble({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: slate900.withValues(alpha: 0.45),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: const Text(
            'Composited above target',
            style: TextStyle(
              color: slate900,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const TooltipArrow(),
      ],
    );
  }
}

class TooltipArrow extends StatelessWidget {
  const TooltipArrow({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(14, 8),
      painter: TooltipArrowPainter(),
    );
  }
}

class TooltipArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint fill = Paint()..color = Colors.white;
    final Path path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width / 2, size.height)
      ..close();
    canvas.drawPath(path, fill);
  }

  @override
  bool shouldRepaint(covariant TooltipArrowPainter oldDelegate) => false;
}

// ============================================================================
// SECTION 10 — Caveats. Five cards covering paint order, recomposition,
// unlinkedOffset semantics, repaint boundary interaction, hit-testing.
// ============================================================================

class CaveatsSection extends StatelessWidget {
  const CaveatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionShell(
      number: '10',
      title: 'Caveats',
      subtitle:
          'Five non-obvious behaviours to keep in mind when reasoning about a '
          'FollowerLayer at the layer-tree level.',
      children: const [
        CaveatCard(
          icon: Icons.schedule_rounded,
          accent: amber500,
          title: 'Leader must paint before follower',
          body:
              'FollowerLayer reads link.leader._lastTransform during its own '
              'addToScene. If the leader hasn\'t been painted yet this frame, '
              'the field is null and the follower falls into the unlinked '
              'branch. In a typical Overlay setup this means the target widget '
              'must be earlier in the paint order than the overlay entry.',
        ),
        SizedBox(height: 10),
        CaveatCard(
          icon: Icons.refresh_rounded,
          accent: emerald500,
          title: 'Recomposition cost',
          body:
              'Each frame the engine recomputes the follower\'s transform by '
              'walking the ancestor chain, inverting a 4x4 matrix, and '
              'multiplying with the leader\'s transform. This is cheap but '
              'happens on every composite. Avoid placing thousands of '
              'follower-linked subtrees on screen at once.',
        ),
        SizedBox(height: 10),
        CaveatCard(
          icon: Icons.swap_horiz_rounded,
          accent: cyan600,
          title: 'unlinkedOffset is in follower-local space',
          body:
              'When the follower is unlinked and showWhenUnlinked is true, '
              'the subtree paints at the follower\'s natural position plus '
              'unlinkedOffset. linkedOffset is meaningless in the unlinked '
              'state — the engine ignores it.',
        ),
        SizedBox(height: 10),
        CaveatCard(
          icon: Icons.layers_rounded,
          accent: violet500,
          title: 'Repaint boundary interaction',
          body:
              'A FollowerLayer is itself a compositing layer; its parent must '
              'composite a new scene whenever the leader\'s transform '
              'changes. The follower forwards a markNeedsAddToScene up the '
              'chain, which can defeat the savings of a nearby '
              'RepaintBoundary if the leader animates.',
        ),
        SizedBox(height: 10),
        CaveatCard(
          icon: Icons.touch_app_rounded,
          accent: rose500,
          title: 'Hit-testing across the link',
          body:
              'Hit tests on the follower\'s subtree must apply the inverse '
              'transform to convert global pointer coords into the leader\'s '
              'local space. RenderFollowerLayer overrides hitTest to do '
              'exactly that — bypassing it (e.g. with custom hit-test '
              'wrappers) leads to taps that miss visible content.',
        ),
      ],
    );
  }
}

class CaveatCard extends StatelessWidget {
  final IconData icon;
  final Color accent;
  final String title;
  final String body;

  const CaveatCard({
    super.key,
    required this.icon,
    required this.accent,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: slate200),
        boxShadow: [
          BoxShadow(
            color: slate900.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.13),
              shape: BoxShape.circle,
              border: Border.all(color: accent.withValues(alpha: 0.55)),
            ),
            child: Icon(icon, color: accent, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: slate900,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  body,
                  style: const TextStyle(
                    color: slate700,
                    fontSize: 12.5,
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
}

// ============================================================================
// SECTION 11 — Footer.
// Three takeaways, slate background, cyan accent.
// ============================================================================

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 22, 24, 24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [slate800, slate900],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: cyan500,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'TAKEAWAYS',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'FollowerLayer · layer-level summary',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const FooterPoint(
            icon: Icons.account_tree_rounded,
            text:
                'A FollowerLayer is a ContainerLayer whose effective transform '
                'is borrowed from a leader layer in (potentially) a different '
                'subtree. The link is keyed by a shared LayerLink instance.',
          ),
          SizedBox(height: 10),
          const FooterPoint(
            icon: Icons.tune_rounded,
            text:
                'Three knobs control its compositing branches: '
                'showWhenUnlinked toggles whether the subtree paints when no '
                'leader is available, unlinkedOffset positions it in that '
                'state, linkedOffset positions it relative to the leader.',
          ),
          SizedBox(height: 10),
          const FooterPoint(
            icon: Icons.bolt_rounded,
            text:
                'It is the engine-side mechanism that powers '
                'CompositedTransformTarget / Follower, and therefore tooltips, '
                'badges, dropdowns, and any other overlay that must track a '
                'widget across animations and layout changes.',
          ),
        ],
      ),
    );
  }
}

class FooterPoint extends StatelessWidget {
  final IconData icon;
  final String text;

  const FooterPoint({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: cyan500.withValues(alpha: 0.18),
            shape: BoxShape.circle,
            border: Border.all(color: cyan300.withValues(alpha: 0.55)),
          ),
          child: Icon(icon, color: cyan300, size: 16),
        ),
        const SizedBox(width: 12),
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
    );
  }
}

// ============================================================================
// Shared section shell.
// Wraps each major section with a consistent index number, title and
// subtitle, and renders the body widgets below.
// ============================================================================

class SectionShell extends StatelessWidget {
  final String number;
  final String title;
  final String subtitle;
  final List<Widget> children;

  const SectionShell({
    super.key,
    required this.number,
    required this.title,
    required this.subtitle,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: cyan100,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: cyan300),
              ),
              child: Text(
                number,
                style: const TextStyle(
                  color: cyan700,
                  fontSize: 12,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: slate900,
                  fontSize: 19,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.3,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.only(left: 2),
          child: Text(
            subtitle,
            style: const TextStyle(
              color: slate600,
              fontSize: 13,
              height: 1.5,
            ),
          ),
        ),
        const SizedBox(height: 16),
        ...children,
      ],
    );
  }
}
