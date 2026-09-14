// ignore_for_file: unused_field, unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

// =============================================================================
// Deep visual demo: ImmediateMultiDragGestureRecognizer
// -----------------------------------------------------------------------------
// ImmediateMultiDragGestureRecognizer is one of four MultiDrag recognizers in
// package:flutter/gestures.dart that allow each pointer to independently
// initiate its own drag. Unlike Pan/Drag recognizers (which only track a single
// pointer and reset between drags), MultiDrag recognizers spawn a separate
// `MultiDragPointerState` for every active pointer, so two, three, or even
// five fingers can drag distinct objects at the same time.
//
// The "Immediate" variant claims the gesture arena on pointer-down — there is
// no slop, no movement threshold, no time delay. The very first frame after
// the finger lands, `onStart` fires and the recognizer expects a `Drag` object
// in return. Subsequent moves are routed through `Drag.update`, lift through
// `Drag.end`, and arena loss through `Drag.cancel`.
//
// Compare to:
//   * DelayedMultiDragGestureRecognizer  — waits for a long-press timeout
//     (default 100 ms) before claiming, useful for "hold then drag" patterns
//     in reorderable lists.
//   * HorizontalMultiDragGestureRecognizer — claims after slop, but only on
//     horizontal motion (rejects vertical pans).
//   * VerticalMultiDragGestureRecognizer  — claims after slop, but only on
//     vertical motion (rejects horizontal pans).
//
// This file is a hand-authored fixture for the analyzer-free interpreter
// corpus: a single static `dynamic build(BuildContext)` entry point, no
// runApp, no StatefulWidget, no controllers, no async, no timers, no streams.
// All callbacks are no-ops. Helpers are `_Private`-prefixed and may be unused.
// =============================================================================

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'ImmediateMultiDragGestureRecognizer Deep Demo',
    home: Scaffold(
      backgroundColor: const Color(0xFFFAF7F2),
      appBar: AppBar(
        title: const Text('ImmediateMultiDragGestureRecognizer'),
        backgroundColor: const Color(0xFFFF6F3C),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _PrivateHeroCard(),
            const SizedBox(height: 28),
            _PrivateSectionHeader(
              index: 1,
              title: 'Anatomy of onStart and the Drag interface',
              subtitle: 'What you return from onStart and what the framework calls on it.',
            ),
            const SizedBox(height: 12),
            _PrivateAnatomyCard(),
            const SizedBox(height: 28),
            _PrivateSectionHeader(
              index: 2,
              title: 'The four MultiDrag siblings',
              subtitle: 'Immediate, Delayed, Horizontal, Vertical — same shape, different arena rules.',
            ),
            const SizedBox(height: 12),
            _PrivateFamilyGrid(),
            const SizedBox(height: 28),
            _PrivateSectionHeader(
              index: 3,
              title: 'Gesture arena timeline',
              subtitle: 'PointerDown -> claim -> win or lose -> Drag callbacks.',
            ),
            const SizedBox(height: 12),
            _PrivateArenaTimeline(),
            const SizedBox(height: 28),
            _PrivateSectionHeader(
              index: 4,
              title: 'Pointer-trail gallery: claim-on-down vs claim-after-delay',
              subtitle: 'Six tiles contrasting Immediate (orange) and Delayed (slate) trails.',
            ),
            const SizedBox(height: 12),
            _PrivateTrailGallery(),
            const SizedBox(height: 28),
            _PrivateSectionHeader(
              index: 5,
              title: 'Code recipe — RawGestureDetector',
              subtitle: 'Wire ImmediateMultiDragGestureRecognizer through a gestures map.',
            ),
            const SizedBox(height: 12),
            _PrivateRecipeCard(),
            const SizedBox(height: 20),
            _PrivateLiveRawGestureDetectorIllustration(),
            const SizedBox(height: 28),
            _PrivateSectionHeader(
              index: 6,
              title: 'Multi-finger choreography',
              subtitle: 'Three fingers, three sticky notes, three concurrent drags.',
            ),
            const SizedBox(height: 12),
            _PrivateChoreographyCard(),
            const SizedBox(height: 28),
            _PrivateSectionHeader(
              index: 7,
              title: 'Five-finger trail visualization',
              subtitle: 'A snapshot of an Immediate recognizer tracking five concurrent pointers.',
            ),
            const SizedBox(height: 12),
            _PrivateFiveFingerTrails(),
            const SizedBox(height: 28),
            _PrivateSectionHeader(
              index: 8,
              title: 'Pitfalls and when to choose which',
              subtitle: 'Immediate steals scroll gestures; Delayed feels laggy for direct manipulation.',
            ),
            const SizedBox(height: 12),
            _PrivatePitfallsCard(),
            const SizedBox(height: 28),
            _PrivateSectionHeader(
              index: 9,
              title: 'Decision matrix',
              subtitle: 'Pick the right recognizer for the interaction.',
            ),
            const SizedBox(height: 12),
            _PrivateDecisionMatrix(),
            const SizedBox(height: 28),
            _PrivateFooter(),
          ],
        ),
      ),
    ),
  );
}

// =============================================================================
// Data classes — _Private-prefixed
// =============================================================================

class _PrivateRecognizerSpec {
  final String name;
  final String tagline;
  final String claimRule;
  final String typicalUse;
  final IconData icon;
  final Color color;
  final String delayLabel;
  final String slopLabel;
  final String axisLabel;
  const _PrivateRecognizerSpec({
    required this.name,
    required this.tagline,
    required this.claimRule,
    required this.typicalUse,
    required this.icon,
    required this.color,
    required this.delayLabel,
    required this.slopLabel,
    required this.axisLabel,
  });
}

class _PrivateGestureSpec {
  final String label;
  final String detail;
  final Color accent;
  const _PrivateGestureSpec({
    required this.label,
    required this.detail,
    required this.accent,
  });
}

class _PrivateTrailPoint {
  final double x;
  final double y;
  final double radius;
  final Color color;
  const _PrivateTrailPoint(this.x, this.y, this.radius, this.color);
}

class _PrivateFingerTrail {
  final String label;
  final Color color;
  final List<_PrivateTrailPoint> points;
  const _PrivateFingerTrail({
    required this.label,
    required this.color,
    required this.points,
  });
}

class _PrivateTimelineStep {
  final String time;
  final String event;
  final String detail;
  final Color color;
  final IconData icon;
  const _PrivateTimelineStep({
    required this.time,
    required this.event,
    required this.detail,
    required this.color,
    required this.icon,
  });
}

class _PrivatePitfall {
  final String title;
  final String description;
  final String mitigation;
  final IconData icon;
  final Color color;
  const _PrivatePitfall({
    required this.title,
    required this.description,
    required this.mitigation,
    required this.icon,
    required this.color,
  });
}

class _PrivateMatrixRow {
  final String scenario;
  final String recommendation;
  final String reason;
  final Color color;
  const _PrivateMatrixRow({
    required this.scenario,
    required this.recommendation,
    required this.reason,
    required this.color,
  });
}

// =============================================================================
// Hero card with multi-finger drag visualization
// =============================================================================

class _PrivateHeroCard extends StatelessWidget {
  const _PrivateHeroCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFFFF6F3C),
            const Color(0xFFFFB347).withValues(alpha: 0.92),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF6F3C).withValues(alpha: 0.35),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.22),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(Icons.touch_app, color: Colors.white, size: 36),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'ImmediateMultiDragGestureRecognizer',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.2,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Multi-touch drags, claimed the moment a finger touches.',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.95),
                        fontSize: 14,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(16),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Stack(
                children: [
                  Positioned.fill(child: CustomPaint(painter: _PrivateFiveTrailPainter())),
                  const Positioned(
                    left: 16,
                    top: 12,
                    child: Text(
                      '5 simultaneous pointer trails',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 16,
                    bottom: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        'each trail = MultiDragPointerState',
                        style: TextStyle(
                          color: Color(0xFFFF6F3C),
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              _PrivateHeroChip(label: 'no slop', icon: Icons.flash_on),
              const SizedBox(width: 8),
              _PrivateHeroChip(label: 'no delay', icon: Icons.timer_off),
              const SizedBox(width: 8),
              _PrivateHeroChip(label: 'multi-pointer', icon: Icons.fingerprint),
              const SizedBox(width: 8),
              _PrivateHeroChip(label: 'arena-aware', icon: Icons.gavel),
            ],
          ),
        ],
      ),
    );
  }
}

class _PrivateHeroChip extends StatelessWidget {
  final String label;
  final IconData icon;
  const _PrivateHeroChip({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.22),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 14),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _PrivateFiveTrailPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final trails = <_PrivateFingerTrail>[
      _PrivateFingerTrail(
        label: 'F1',
        color: Colors.white,
        points: const [
          _PrivateTrailPoint(0.05, 0.30, 6, Colors.white),
          _PrivateTrailPoint(0.15, 0.32, 5, Colors.white),
          _PrivateTrailPoint(0.30, 0.40, 4, Colors.white),
          _PrivateTrailPoint(0.50, 0.55, 3, Colors.white),
        ],
      ),
      _PrivateFingerTrail(
        label: 'F2',
        color: Color(0xFFFFE66D),
        points: const [
          _PrivateTrailPoint(0.10, 0.70, 6, Color(0xFFFFE66D)),
          _PrivateTrailPoint(0.25, 0.62, 5, Color(0xFFFFE66D)),
          _PrivateTrailPoint(0.40, 0.55, 4, Color(0xFFFFE66D)),
          _PrivateTrailPoint(0.55, 0.45, 3, Color(0xFFFFE66D)),
        ],
      ),
      _PrivateFingerTrail(
        label: 'F3',
        color: Color(0xFF7FE0CB),
        points: const [
          _PrivateTrailPoint(0.92, 0.20, 6, Color(0xFF7FE0CB)),
          _PrivateTrailPoint(0.78, 0.30, 5, Color(0xFF7FE0CB)),
          _PrivateTrailPoint(0.66, 0.42, 4, Color(0xFF7FE0CB)),
          _PrivateTrailPoint(0.52, 0.50, 3, Color(0xFF7FE0CB)),
        ],
      ),
      _PrivateFingerTrail(
        label: 'F4',
        color: Color(0xFFFFAFCC),
        points: const [
          _PrivateTrailPoint(0.95, 0.78, 6, Color(0xFFFFAFCC)),
          _PrivateTrailPoint(0.82, 0.72, 5, Color(0xFFFFAFCC)),
          _PrivateTrailPoint(0.70, 0.65, 4, Color(0xFFFFAFCC)),
          _PrivateTrailPoint(0.58, 0.58, 3, Color(0xFFFFAFCC)),
        ],
      ),
      _PrivateFingerTrail(
        label: 'F5',
        color: Color(0xFFB8B5FF),
        points: const [
          _PrivateTrailPoint(0.50, 0.92, 6, Color(0xFFB8B5FF)),
          _PrivateTrailPoint(0.50, 0.80, 5, Color(0xFFB8B5FF)),
          _PrivateTrailPoint(0.50, 0.68, 4, Color(0xFFB8B5FF)),
          _PrivateTrailPoint(0.50, 0.56, 3, Color(0xFFB8B5FF)),
        ],
      ),
    ];

    for (final trail in trails) {
      final paint = Paint()
        ..color = trail.color.withValues(alpha: 0.85)
        ..style = PaintingStyle.fill;

      final linePaint = Paint()
        ..color = trail.color.withValues(alpha: 0.6)
        ..strokeWidth = 2.0
        ..style = PaintingStyle.stroke;

      for (int i = 0; i < trail.points.length - 1; i++) {
        final a = trail.points[i];
        final b = trail.points[i + 1];
        canvas.drawLine(
          Offset(a.x * size.width, a.y * size.height),
          Offset(b.x * size.width, b.y * size.height),
          linePaint,
        );
      }
      for (final p in trail.points) {
        canvas.drawCircle(
          Offset(p.x * size.width, p.y * size.height),
          p.radius,
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// =============================================================================
// Section header
// =============================================================================

class _PrivateSectionHeader extends StatelessWidget {
  final int index;
  final String title;
  final String subtitle;
  const _PrivateSectionHeader({
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
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: const Color(0xFFFF6F3C),
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Text(
            '$index',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D2D2D),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 12.5,
                  color: Color(0xFF6E6E6E),
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

// =============================================================================
// Section 1 — Anatomy of onStart and the Drag interface
// =============================================================================

class _PrivateAnatomyCard extends StatelessWidget {
  const _PrivateAnatomyCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEDE4D8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'onStart returns a Drag (or null to refuse)',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1B16),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'final recognizer = ImmediateMultiDragGestureRecognizer()\n'
              '  ..onStart = (Offset position) {\n'
              '    // Decide whether to handle this pointer.\n'
              '    // Return a Drag implementation, or null to opt out.\n'
              '    return _MyDrag();\n'
              '  };',
              style: TextStyle(
                color: Color(0xFFFFC685),
                fontFamily: 'monospace',
                fontSize: 12.5,
                height: 1.45,
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'The Drag interface — three callbacks, three lifecycle moments',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          _PrivateDragCallbackRow(
            symbol: 'update',
            type: 'DragUpdateDetails',
            description: 'Pointer moved. Use details.delta and details.globalPosition.',
            color: const Color(0xFFFF6F3C),
            icon: Icons.swipe,
          ),
          const SizedBox(height: 8),
          _PrivateDragCallbackRow(
            symbol: 'end',
            type: 'DragEndDetails',
            description: 'Pointer lifted. Use details.velocity for fling physics.',
            color: const Color(0xFF2A9D8F),
            icon: Icons.outbond,
          ),
          const SizedBox(height: 8),
          _PrivateDragCallbackRow(
            symbol: 'cancel',
            type: 'void',
            description: 'Arena rejected this pointer. Roll back any drag effect.',
            color: const Color(0xFF8B5CF6),
            icon: Icons.cancel,
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF4E6),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFFFD9A8)),
            ),
            child: Row(
              children: [
                const Icon(Icons.lightbulb, color: Color(0xFFFF6F3C), size: 20),
                const SizedBox(width: 10),
                const Expanded(
                  child: Text(
                    'Each pointer gets its own Drag instance. Returning the same Drag object for two pointers is a bug — they will fight over update/end calls.',
                    style: TextStyle(fontSize: 12, height: 1.4),
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

class _PrivateDragCallbackRow extends StatelessWidget {
  final String symbol;
  final String type;
  final String description;
  final Color color;
  final IconData icon;
  const _PrivateDragCallbackRow({
    required this.symbol,
    required this.type,
    required this.description,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              symbol,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.bold,
                fontFamily: 'monospace',
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '($type)',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              description,
              style: const TextStyle(fontSize: 12, height: 1.35),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// Section 2 — The four MultiDrag siblings
// =============================================================================

class _PrivateFamilyGrid extends StatelessWidget {
  const _PrivateFamilyGrid();

  @override
  Widget build(BuildContext context) {
    final specs = <_PrivateRecognizerSpec>[
      const _PrivateRecognizerSpec(
        name: 'ImmediateMultiDragGestureRecognizer',
        tagline: 'Claim now, ask questions later.',
        claimRule: 'Wins arena on PointerDown.',
        typicalUse: 'Direct-manipulation drag-and-drop where any motion is a drag.',
        icon: Icons.flash_on,
        color: Color(0xFFFF6F3C),
        delayLabel: '0 ms',
        slopLabel: '0 px',
        axisLabel: 'any',
      ),
      const _PrivateRecognizerSpec(
        name: 'DelayedMultiDragGestureRecognizer',
        tagline: 'Long-press, then drag.',
        claimRule: 'Wins arena after kLongPressTimeout (~500 ms).',
        typicalUse: 'ReorderableListView. Hold to lift an item, then drag.',
        icon: Icons.timer,
        color: Color(0xFF6C7A89),
        delayLabel: '~500 ms',
        slopLabel: '0 px',
        axisLabel: 'any',
      ),
      const _PrivateRecognizerSpec(
        name: 'HorizontalMultiDragGestureRecognizer',
        tagline: 'East-west only.',
        claimRule: 'Wins after horizontal slop. Rejects vertical motion.',
        typicalUse: 'Side-swipe gestures coexisting with a vertical scroll.',
        icon: Icons.swap_horiz,
        color: Color(0xFF2A9D8F),
        delayLabel: '0 ms',
        slopLabel: '~18 px',
        axisLabel: 'horizontal',
      ),
      const _PrivateRecognizerSpec(
        name: 'VerticalMultiDragGestureRecognizer',
        tagline: 'North-south only.',
        claimRule: 'Wins after vertical slop. Rejects horizontal motion.',
        typicalUse: 'Pull-down menus while a horizontal carousel pans.',
        icon: Icons.swap_vert,
        color: Color(0xFF8B5CF6),
        delayLabel: '0 ms',
        slopLabel: '~18 px',
        axisLabel: 'vertical',
      ),
    ];

    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _PrivateFamilyCard(spec: specs[0])),
            const SizedBox(width: 12),
            Expanded(child: _PrivateFamilyCard(spec: specs[1])),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _PrivateFamilyCard(spec: specs[2])),
            const SizedBox(width: 12),
            Expanded(child: _PrivateFamilyCard(spec: specs[3])),
          ],
        ),
      ],
    );
  }
}

class _PrivateFamilyCard extends StatelessWidget {
  final _PrivateRecognizerSpec spec;
  const _PrivateFamilyCard({required this.spec});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: spec.color.withValues(alpha: 0.45), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: spec.color.withValues(alpha: 0.10),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: spec.color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(spec.icon, color: spec.color, size: 20),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  spec.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: spec.color,
                    fontSize: 12.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            spec.tagline,
            style: const TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2D2D2D),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            spec.claimRule,
            style: const TextStyle(fontSize: 11.5, height: 1.4, color: Color(0xFF555555)),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 6,
            runSpacing: 4,
            children: [
              _PrivateMiniBadge(label: 'delay ${spec.delayLabel}', color: spec.color),
              _PrivateMiniBadge(label: 'slop ${spec.slopLabel}', color: spec.color),
              _PrivateMiniBadge(label: 'axis ${spec.axisLabel}', color: spec.color),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: spec.color.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              spec.typicalUse,
              style: const TextStyle(fontSize: 11, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}

class _PrivateMiniBadge extends StatelessWidget {
  final String label;
  final Color color;
  const _PrivateMiniBadge({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: color,
          fontFamily: 'monospace',
        ),
      ),
    );
  }
}

// =============================================================================
// Section 3 — Gesture arena timeline
// =============================================================================

class _PrivateArenaTimeline extends StatelessWidget {
  const _PrivateArenaTimeline();

  @override
  Widget build(BuildContext context) {
    final steps = <_PrivateTimelineStep>[
      const _PrivateTimelineStep(
        time: 't+0',
        event: 'PointerDownEvent',
        detail: 'Finger touches screen. New entry in GestureBinding pointer router.',
        color: Color(0xFFFF6F3C),
        icon: Icons.touch_app,
      ),
      const _PrivateTimelineStep(
        time: 't+0',
        event: 'addAllowedPointer',
        detail: 'Recognizer creates a MultiDragPointerState for this pointer ID.',
        color: Color(0xFFE76F51),
        icon: Icons.add_circle,
      ),
      const _PrivateTimelineStep(
        time: 't+0',
        event: 'arena.add(this)',
        detail: 'Recognizer registers as a contender in the GestureArena.',
        color: Color(0xFFF4A261),
        icon: Icons.gavel,
      ),
      const _PrivateTimelineStep(
        time: 't+0+e',
        event: 'resolve(GestureDisposition.accepted)',
        detail: 'Immediate variant immediately claims the arena. No slop, no delay.',
        color: Color(0xFFE9C46A),
        icon: Icons.flash_on,
      ),
      const _PrivateTimelineStep(
        time: 't+0+e',
        event: 'onStart(position) -> Drag',
        detail: 'Recognizer asks owner for a Drag. If null, the pointer is dropped.',
        color: Color(0xFF2A9D8F),
        icon: Icons.play_arrow,
      ),
      const _PrivateTimelineStep(
        time: 't+1..N',
        event: 'Drag.update(DragUpdateDetails)',
        detail: 'Each PointerMoveEvent forwards delta and globalPosition.',
        color: Color(0xFF264653),
        icon: Icons.swipe,
      ),
      const _PrivateTimelineStep(
        time: 't+N',
        event: 'Drag.end(DragEndDetails)',
        detail: 'Finger lifts. Velocity is included for fling physics.',
        color: Color(0xFF6C7A89),
        icon: Icons.outbond,
      ),
      const _PrivateTimelineStep(
        time: 'parallel',
        event: 'Drag.cancel()',
        detail: 'If something else wins (rare for Immediate), the drag is rolled back.',
        color: Color(0xFF8B5CF6),
        icon: Icons.cancel,
      ),
    ];

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEDE4D8)),
      ),
      child: Column(
        children: List.generate(steps.length, (i) {
          final step = steps[i];
          final isLast = i == steps.length - 1;
          return _PrivateTimelineRow(step: step, isLast: isLast, index: i);
        }),
      ),
    );
  }
}

class _PrivateTimelineRow extends StatelessWidget {
  final _PrivateTimelineStep step;
  final bool isLast;
  final int index;
  const _PrivateTimelineRow({
    required this.step,
    required this.isLast,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 64,
            child: Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(
                step.time,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.5,
                  color: step.color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Column(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: step.color,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Icon(step.icon, color: Colors.white, size: 14),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: step.color.withValues(alpha: 0.35),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 2, bottom: isLast ? 0 : 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    step.event,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12.5,
                      fontWeight: FontWeight.bold,
                      color: step.color,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    step.detail,
                    style: const TextStyle(fontSize: 12, height: 1.4),
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

// =============================================================================
// Section 4 — Pointer-trail gallery, Immediate vs Delayed
// =============================================================================

class _PrivateTrailGallery extends StatelessWidget {
  const _PrivateTrailGallery();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _PrivateTrailTile(
              title: 'Immediate · Tap-and-go',
              variant: _PrivateTrailVariant.immediateTapGo,
              accent: const Color(0xFFFF6F3C),
              caption: 'Drag fires on the very first move. Perfect for live drag.',
            )),
            const SizedBox(width: 12),
            Expanded(child: _PrivateTrailTile(
              title: 'Delayed · Hold-then-drag',
              variant: _PrivateTrailVariant.delayedHoldDrag,
              accent: const Color(0xFF6C7A89),
              caption: 'Nothing happens for ~500 ms, then drag activates.',
            )),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _PrivateTrailTile(
              title: 'Immediate · Diagonal swipe',
              variant: _PrivateTrailVariant.immediateDiagonal,
              accent: const Color(0xFFE76F51),
              caption: 'Any direction works — no axis constraint.',
            )),
            const SizedBox(width: 12),
            Expanded(child: _PrivateTrailTile(
              title: 'Delayed · Released early',
              variant: _PrivateTrailVariant.delayedAborted,
              accent: const Color(0xFFA0A8B0),
              caption: 'Lifting before the timeout sends a tap, not a drag.',
            )),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _PrivateTrailTile(
              title: 'Immediate · Two pointers in flight',
              variant: _PrivateTrailVariant.immediateTwoFingers,
              accent: const Color(0xFFF4A261),
              caption: 'Two pointer states track in parallel.',
            )),
            const SizedBox(width: 12),
            Expanded(child: _PrivateTrailTile(
              title: 'Delayed · Hold then drag',
              variant: _PrivateTrailVariant.delayedHoldThenDrag,
              accent: const Color(0xFF8B5CF6),
              caption: 'Static dwell circle, then trail follows.',
            )),
          ],
        ),
      ],
    );
  }
}

enum _PrivateTrailVariant {
  immediateTapGo,
  delayedHoldDrag,
  immediateDiagonal,
  delayedAborted,
  immediateTwoFingers,
  delayedHoldThenDrag,
}

class _PrivateTrailTile extends StatelessWidget {
  final String title;
  final _PrivateTrailVariant variant;
  final Color accent;
  final String caption;
  const _PrivateTrailTile({
    required this.title,
    required this.variant,
    required this.accent,
    required this.caption,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: accent.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: accent,
              fontSize: 12.5,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 110,
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CustomPaint(
                painter: _PrivateVariantTrailPainter(variant: variant, accent: accent),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            caption,
            style: const TextStyle(fontSize: 11, height: 1.4, color: Color(0xFF555555)),
          ),
        ],
      ),
    );
  }
}

class _PrivateVariantTrailPainter extends CustomPainter {
  final _PrivateTrailVariant variant;
  final Color accent;
  _PrivateVariantTrailPainter({required this.variant, required this.accent});

  @override
  void paint(Canvas canvas, Size size) {
    switch (variant) {
      case _PrivateTrailVariant.immediateTapGo:
        _drawTrail(canvas, size, _path([
          Offset(0.10, 0.55),
          Offset(0.30, 0.50),
          Offset(0.55, 0.45),
          Offset(0.85, 0.40),
        ]));
        break;
      case _PrivateTrailVariant.delayedHoldDrag:
        _drawDwell(canvas, size, const Offset(0.18, 0.55));
        _drawTrail(canvas, size, _path([
          Offset(0.18, 0.55),
          Offset(0.40, 0.55),
          Offset(0.65, 0.55),
          Offset(0.85, 0.55),
        ]));
        break;
      case _PrivateTrailVariant.immediateDiagonal:
        _drawTrail(canvas, size, _path([
          Offset(0.15, 0.85),
          Offset(0.35, 0.65),
          Offset(0.55, 0.45),
          Offset(0.80, 0.20),
        ]));
        break;
      case _PrivateTrailVariant.delayedAborted:
        _drawDwell(canvas, size, const Offset(0.5, 0.5), aborted: true);
        break;
      case _PrivateTrailVariant.immediateTwoFingers:
        _drawTrail(canvas, size, _path([
          Offset(0.10, 0.30),
          Offset(0.35, 0.30),
          Offset(0.60, 0.30),
        ]));
        _drawTrail(canvas, size, _path([
          Offset(0.10, 0.70),
          Offset(0.40, 0.70),
          Offset(0.70, 0.70),
        ]));
        break;
      case _PrivateTrailVariant.delayedHoldThenDrag:
        _drawDwell(canvas, size, const Offset(0.20, 0.55));
        _drawTrail(canvas, size, _path([
          Offset(0.20, 0.55),
          Offset(0.40, 0.45),
          Offset(0.65, 0.40),
          Offset(0.85, 0.30),
        ]));
        break;
    }
  }

  List<Offset> _path(List<Offset> normalized) => normalized;

  void _drawTrail(Canvas canvas, Size size, List<Offset> normalized) {
    final paint = Paint()
      ..color = accent.withValues(alpha: 0.85)
      ..style = PaintingStyle.fill;
    final linePaint = Paint()
      ..color = accent.withValues(alpha: 0.55)
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < normalized.length - 1; i++) {
      canvas.drawLine(
        Offset(normalized[i].dx * size.width, normalized[i].dy * size.height),
        Offset(normalized[i + 1].dx * size.width, normalized[i + 1].dy * size.height),
        linePaint,
      );
    }
    for (int i = 0; i < normalized.length; i++) {
      final p = normalized[i];
      final r = 4.0 + (normalized.length - i) * 0.8;
      canvas.drawCircle(
        Offset(p.dx * size.width, p.dy * size.height),
        r,
        paint,
      );
    }
  }

  void _drawDwell(Canvas canvas, Size size, Offset normalized, {bool aborted = false}) {
    final center = Offset(normalized.dx * size.width, normalized.dy * size.height);
    final ringPaint = Paint()
      ..color = accent.withValues(alpha: 0.30)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    canvas.drawCircle(center, 18, ringPaint);
    canvas.drawCircle(center, 12, ringPaint);
    final dotPaint = Paint()..color = accent.withValues(alpha: 0.85);
    canvas.drawCircle(center, 6, dotPaint);
    if (aborted) {
      final cross = Paint()
        ..color = const Color(0xFFE63946)
        ..strokeWidth = 2
        ..style = PaintingStyle.stroke;
      canvas.drawLine(
        Offset(center.dx - 10, center.dy - 10),
        Offset(center.dx + 10, center.dy + 10),
        cross,
      );
      canvas.drawLine(
        Offset(center.dx + 10, center.dy - 10),
        Offset(center.dx - 10, center.dy + 10),
        cross,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// =============================================================================
// Section 5 — Code recipe + a real RawGestureDetector
// =============================================================================

class _PrivateRecipeCard extends StatelessWidget {
  const _PrivateRecipeCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1B16),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF6F3C),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'recipe',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'RawGestureDetector with a gestures map',
                style: TextStyle(
                  color: Color(0xFFFFE9CC),
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const SelectableText(
            'RawGestureDetector(\n'
            '  behavior: HitTestBehavior.opaque,\n'
            '  gestures: <Type, GestureRecognizerFactory>{\n'
            '    ImmediateMultiDragGestureRecognizer:\n'
            '      GestureRecognizerFactoryWithHandlers<\n'
            '        ImmediateMultiDragGestureRecognizer\n'
            '      >(\n'
            '        () => ImmediateMultiDragGestureRecognizer(),\n'
            '        (ImmediateMultiDragGestureRecognizer r) {\n'
            '          r.onStart = (Offset position) {\n'
            '            // Each pointer gets its own Drag.\n'
            '            return _MyMultiDrag(startPosition: position);\n'
            '          };\n'
            '        },\n'
            '      ),\n'
            '  },\n'
            '  child: Stack(children: [/* ... draggable children ... */]),\n'
            ')',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              color: Color(0xFFFFC685),
              height: 1.45,
            ),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              '// _MyMultiDrag implements Drag — three methods:\n'
              'class _MyMultiDrag implements Drag {\n'
              '  _MyMultiDrag({required this.startPosition});\n'
              '  final Offset startPosition;\n'
              '  @override\n'
              '  void update(DragUpdateDetails details) { /* move sticky note */ }\n'
              '  @override\n'
              '  void end(DragEndDetails details)       { /* settle / fling */ }\n'
              '  @override\n'
              '  void cancel()                            { /* roll back */ }\n'
              '}',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.5,
                color: Color(0xFF7FE0CB),
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PrivateLiveRawGestureDetectorIllustration extends StatelessWidget {
  const _PrivateLiveRawGestureDetectorIllustration();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFEDE4D8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.code, color: Color(0xFFFF6F3C)),
              SizedBox(width: 8),
              Text(
                'Live (no-op) RawGestureDetector',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'Below is a real RawGestureDetector wired to ImmediateMultiDragGestureRecognizer. The factory is constructed but onStart returns null, so no Drag is ever created — the demo stays animation-free and stateless.',
            style: TextStyle(fontSize: 12, height: 1.4),
          ),
          const SizedBox(height: 12),
          RawGestureDetector(
            behavior: HitTestBehavior.opaque,
            gestures: <Type, GestureRecognizerFactory>{
              ImmediateMultiDragGestureRecognizer:
                  GestureRecognizerFactoryWithHandlers<ImmediateMultiDragGestureRecognizer>(
                () => ImmediateMultiDragGestureRecognizer(),
                (ImmediateMultiDragGestureRecognizer instance) {
                  instance.onStart = (Offset position) {
                    // No-op: returning null tells the recognizer to ignore this pointer.
                    return null;
                  };
                },
              ),
            },
            child: Container(
              height: 96,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFFE9CC), Color(0xFFFFD1B0)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFFF6F3C).withValues(alpha: 0.5)),
              ),
              child: const Text(
                '(touchable but inert canvas)',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 12,
                  color: Color(0xFF8C5A2A),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// Section 6 — Multi-finger choreography
// =============================================================================

class _PrivateChoreographyCard extends StatelessWidget {
  const _PrivateChoreographyCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF7EE),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFFFD9A8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Three pointers, three sticky notes — concurrently.',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.5),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 200,
            child: Stack(
              children: [
                Positioned.fill(
                  child: CustomPaint(painter: _PrivateChoreographyPainter()),
                ),
                Positioned(
                  left: 18,
                  top: 28,
                  child: _PrivateStickyNote(
                    label: 'idea A',
                    color: const Color(0xFFFFE66D),
                    rotation: -0.06,
                  ),
                ),
                Positioned(
                  left: 130,
                  top: 80,
                  child: _PrivateStickyNote(
                    label: 'idea B',
                    color: const Color(0xFFFFAFCC),
                    rotation: 0.04,
                  ),
                ),
                Positioned(
                  right: 18,
                  top: 30,
                  child: _PrivateStickyNote(
                    label: 'idea C',
                    color: const Color(0xFF7FE0CB),
                    rotation: -0.03,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            'Each finger\'s onStart returns its own Drag. Update events for pointer N go only to Drag N. There is no shared mutable state inside the recognizer; the pointer-to-state map is keyed by pointer ID.',
            style: TextStyle(fontSize: 12, height: 1.5),
          ),
        ],
      ),
    );
  }
}

class _PrivateStickyNote extends StatelessWidget {
  final String label;
  final Color color;
  final double rotation;
  const _PrivateStickyNote({
    required this.label,
    required this.color,
    required this.rotation,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: rotation,
      child: Container(
        width: 90,
        height: 90,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 8,
              offset: const Offset(2, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 6),
            Container(width: 60, height: 2, color: Colors.black.withValues(alpha: 0.15)),
            const SizedBox(height: 4),
            Container(width: 50, height: 2, color: Colors.black.withValues(alpha: 0.10)),
            const SizedBox(height: 4),
            Container(width: 40, height: 2, color: Colors.black.withValues(alpha: 0.08)),
          ],
        ),
      ),
    );
  }
}

class _PrivateChoreographyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final fingerColor = const Color(0xFFFF6F3C).withValues(alpha: 0.9);
    final paths = <List<Offset>>[
      [
        const Offset(0.05, 0.15),
        const Offset(0.18, 0.30),
        const Offset(0.30, 0.50),
      ],
      [
        const Offset(0.50, 0.05),
        const Offset(0.60, 0.30),
        const Offset(0.65, 0.55),
      ],
      [
        const Offset(0.95, 0.20),
        const Offset(0.85, 0.40),
        const Offset(0.78, 0.55),
      ],
    ];

    for (final path in paths) {
      final pts = path.map((p) => Offset(p.dx * size.width, p.dy * size.height)).toList();
      final stroke = Paint()
        ..color = fingerColor.withValues(alpha: 0.45)
        ..strokeWidth = 2
        ..style = PaintingStyle.stroke;
      for (int i = 0; i < pts.length - 1; i++) {
        canvas.drawLine(pts[i], pts[i + 1], stroke);
      }
      for (int i = 0; i < pts.length; i++) {
        final r = 5.0 + (pts.length - i);
        canvas.drawCircle(
          pts[i],
          r,
          Paint()..color = fingerColor.withValues(alpha: 0.5 + i * 0.15),
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// =============================================================================
// Section 7 — Five-finger trails snapshot
// =============================================================================

class _PrivateFiveFingerTrails extends StatelessWidget {
  const _PrivateFiveFingerTrails();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1B16),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.fingerprint, color: Color(0xFFFFC685)),
              SizedBox(width: 8),
              Text(
                '5 active MultiDragPointerStates',
                style: TextStyle(
                  color: Color(0xFFFFE9CC),
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            height: 220,
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.25),
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CustomPaint(
                painter: _PrivateFiveTrailDarkPainter(),
                child: const SizedBox.expand(),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: const [
              _PrivateTrailLegend(label: 'pointer 17 (F1)', color: Color(0xFFFF6F3C)),
              _PrivateTrailLegend(label: 'pointer 18 (F2)', color: Color(0xFFFFE66D)),
              _PrivateTrailLegend(label: 'pointer 19 (F3)', color: Color(0xFF7FE0CB)),
              _PrivateTrailLegend(label: 'pointer 20 (F4)', color: Color(0xFFFFAFCC)),
              _PrivateTrailLegend(label: 'pointer 21 (F5)', color: Color(0xFFB8B5FF)),
            ],
          ),
        ],
      ),
    );
  }
}

class _PrivateTrailLegend extends StatelessWidget {
  final String label;
  final Color color;
  const _PrivateTrailLegend({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.55)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontFamily: 'monospace',
              fontSize: 10.5,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _PrivateFiveTrailDarkPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final trails = <_PrivateFingerTrail>[
      _PrivateFingerTrail(
        label: 'F1',
        color: const Color(0xFFFF6F3C),
        points: const [
          _PrivateTrailPoint(0.08, 0.15, 4, Color(0xFFFF6F3C)),
          _PrivateTrailPoint(0.18, 0.25, 5, Color(0xFFFF6F3C)),
          _PrivateTrailPoint(0.30, 0.40, 6, Color(0xFFFF6F3C)),
          _PrivateTrailPoint(0.42, 0.55, 7, Color(0xFFFF6F3C)),
        ],
      ),
      _PrivateFingerTrail(
        label: 'F2',
        color: const Color(0xFFFFE66D),
        points: const [
          _PrivateTrailPoint(0.92, 0.10, 4, Color(0xFFFFE66D)),
          _PrivateTrailPoint(0.78, 0.22, 5, Color(0xFFFFE66D)),
          _PrivateTrailPoint(0.66, 0.35, 6, Color(0xFFFFE66D)),
          _PrivateTrailPoint(0.55, 0.50, 7, Color(0xFFFFE66D)),
        ],
      ),
      _PrivateFingerTrail(
        label: 'F3',
        color: const Color(0xFF7FE0CB),
        points: const [
          _PrivateTrailPoint(0.50, 0.92, 4, Color(0xFF7FE0CB)),
          _PrivateTrailPoint(0.50, 0.78, 5, Color(0xFF7FE0CB)),
          _PrivateTrailPoint(0.50, 0.65, 6, Color(0xFF7FE0CB)),
          _PrivateTrailPoint(0.50, 0.52, 7, Color(0xFF7FE0CB)),
        ],
      ),
      _PrivateFingerTrail(
        label: 'F4',
        color: const Color(0xFFFFAFCC),
        points: const [
          _PrivateTrailPoint(0.18, 0.85, 4, Color(0xFFFFAFCC)),
          _PrivateTrailPoint(0.30, 0.78, 5, Color(0xFFFFAFCC)),
          _PrivateTrailPoint(0.42, 0.70, 6, Color(0xFFFFAFCC)),
          _PrivateTrailPoint(0.55, 0.62, 7, Color(0xFFFFAFCC)),
        ],
      ),
      _PrivateFingerTrail(
        label: 'F5',
        color: const Color(0xFFB8B5FF),
        points: const [
          _PrivateTrailPoint(0.85, 0.85, 4, Color(0xFFB8B5FF)),
          _PrivateTrailPoint(0.72, 0.78, 5, Color(0xFFB8B5FF)),
          _PrivateTrailPoint(0.62, 0.70, 6, Color(0xFFB8B5FF)),
          _PrivateTrailPoint(0.52, 0.62, 7, Color(0xFFB8B5FF)),
        ],
      ),
    ];

    for (final trail in trails) {
      final dotPaint = Paint()..style = PaintingStyle.fill;
      final linePaint = Paint()
        ..color = trail.color.withValues(alpha: 0.5)
        ..strokeWidth = 2
        ..style = PaintingStyle.stroke;
      for (int i = 0; i < trail.points.length - 1; i++) {
        canvas.drawLine(
          Offset(trail.points[i].x * size.width, trail.points[i].y * size.height),
          Offset(trail.points[i + 1].x * size.width, trail.points[i + 1].y * size.height),
          linePaint,
        );
      }
      for (int i = 0; i < trail.points.length; i++) {
        final p = trail.points[i];
        dotPaint.color = trail.color.withValues(alpha: 0.4 + 0.15 * i);
        canvas.drawCircle(
          Offset(p.x * size.width, p.y * size.height),
          p.radius.toDouble(),
          dotPaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// =============================================================================
// Section 8 — Pitfalls
// =============================================================================

class _PrivatePitfallsCard extends StatelessWidget {
  const _PrivatePitfallsCard();

  @override
  Widget build(BuildContext context) {
    final pitfalls = <_PrivatePitfall>[
      const _PrivatePitfall(
        title: 'Stealing scroll gestures',
        description:
            'Inside a scrollable, ImmediateMultiDragGestureRecognizer wins the arena before the scrollable\'s drag recognizer. Vertical swipes never become scrolls.',
        mitigation:
            'Use VerticalMultiDragGestureRecognizer with a different axis, or DelayedMultiDragGestureRecognizer to give scroll first dibs.',
        icon: Icons.swap_vert,
        color: Color(0xFFE63946),
      ),
      const _PrivatePitfall(
        title: 'Tap conflicts',
        description:
            'A short tap is also a "pointer down + small move + up". Immediate claims it as a drag, suppressing onTap on children.',
        mitigation:
            'If you also need taps, layer a TapGestureRecognizer in the same RawGestureDetector — but be aware Immediate will outrace it.',
        icon: Icons.touch_app,
        color: Color(0xFFE76F51),
      ),
      const _PrivatePitfall(
        title: 'Forgetting Drag.cancel',
        description:
            'If another recognizer somehow wins (rare with Immediate, but possible in nested arenas), cancel() fires. Skipping cleanup leaves UI half-dragged.',
        mitigation:
            'Always implement cancel() to revert position changes you applied during update().',
        icon: Icons.cancel,
        color: Color(0xFF8B5CF6),
      ),
      const _PrivatePitfall(
        title: 'Returning null on every onStart',
        description:
            'If onStart returns null for a pointer, the framework still consumed the arena win — no other recognizer below will get this pointer.',
        mitigation:
            'Only attach Immediate to regions where every pointer should drag. Use HitTestBehavior thoughtfully on the wrapper.',
        icon: Icons.block,
        color: Color(0xFF6C7A89),
      ),
    ];

    return Column(
      children: [
        for (final pitfall in pitfalls) ...[
          _PrivatePitfallTile(pitfall: pitfall),
          const SizedBox(height: 10),
        ],
      ],
    );
  }
}

class _PrivatePitfallTile extends StatelessWidget {
  final _PrivatePitfall pitfall;
  const _PrivatePitfallTile({required this.pitfall});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: pitfall.color.withValues(alpha: 0.45)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: pitfall.color.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(pitfall.icon, color: pitfall.color, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pitfall.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: pitfall.color,
                    fontSize: 13.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  pitfall.description,
                  style: const TextStyle(fontSize: 12, height: 1.4),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: pitfall.color.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.lightbulb_outline, color: pitfall.color, size: 14),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          pitfall.mitigation,
                          style: const TextStyle(fontSize: 11.5, height: 1.4),
                        ),
                      ),
                    ],
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

// =============================================================================
// Section 9 — Decision matrix
// =============================================================================

class _PrivateDecisionMatrix extends StatelessWidget {
  const _PrivateDecisionMatrix();

  @override
  Widget build(BuildContext context) {
    final rows = <_PrivateMatrixRow>[
      const _PrivateMatrixRow(
        scenario: 'Free-floating draggable cards on a board',
        recommendation: 'ImmediateMultiDragGestureRecognizer',
        reason: 'Drag should feel instant and there is no scroll competing.',
        color: Color(0xFFFF6F3C),
      ),
      const _PrivateMatrixRow(
        scenario: 'ReorderableListView item handle',
        recommendation: 'DelayedMultiDragGestureRecognizer',
        reason: 'Scroll wins fast taps; long-press lifts the row first.',
        color: Color(0xFF6C7A89),
      ),
      const _PrivateMatrixRow(
        scenario: 'Sidebar swipe inside a vertically scrollable page',
        recommendation: 'HorizontalMultiDragGestureRecognizer',
        reason: 'Reject vertical motion so the page can still scroll.',
        color: Color(0xFF2A9D8F),
      ),
      const _PrivateMatrixRow(
        scenario: 'Pull-down menu over a horizontal carousel',
        recommendation: 'VerticalMultiDragGestureRecognizer',
        reason: 'Reject horizontal motion so the carousel can still pan.',
        color: Color(0xFF8B5CF6),
      ),
      const _PrivateMatrixRow(
        scenario: 'Multi-finger paint app',
        recommendation: 'ImmediateMultiDragGestureRecognizer',
        reason: 'Every pointer is a brush stroke — no shared state, no delay.',
        color: Color(0xFFE76F51),
      ),
      const _PrivateMatrixRow(
        scenario: 'Single-pointer slider',
        recommendation: 'HorizontalDragGestureRecognizer (not multi)',
        reason: 'You only need one pointer; multi-drag adds complexity.',
        color: Color(0xFFA0A8B0),
      ),
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFEDE4D8)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: const BoxDecoration(
              color: Color(0xFFFFF4E6),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(14),
                topRight: Radius.circular(14),
              ),
            ),
            child: Row(
              children: const [
                Expanded(
                  flex: 4,
                  child: Text('Scenario', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                ),
                Expanded(
                  flex: 4,
                  child: Text('Recommendation', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                ),
                Expanded(
                  flex: 5,
                  child: Text('Why', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                ),
              ],
            ),
          ),
          for (int i = 0; i < rows.length; i++)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: i.isEven ? Colors.white : const Color(0xFFFAF7F2),
                border: Border(top: BorderSide(color: rows[i].color.withValues(alpha: 0.18))),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 4,
                    child: Text(rows[i].scenario, style: const TextStyle(fontSize: 11.5, height: 1.4)),
                  ),
                  Expanded(
                    flex: 4,
                    child: Text(
                      rows[i].recommendation,
                      style: TextStyle(
                        fontSize: 11.5,
                        height: 1.4,
                        fontWeight: FontWeight.bold,
                        color: rows[i].color,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Text(
                      rows[i].reason,
                      style: const TextStyle(fontSize: 11.5, height: 1.4, color: Color(0xFF555555)),
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

// =============================================================================
// Footer
// =============================================================================

class _PrivateFooter extends StatelessWidget {
  const _PrivateFooter();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1B16),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFFF6F3C).withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.flash_on, color: Color(0xFFFFC685)),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ImmediateMultiDragGestureRecognizer',
                  style: TextStyle(
                    color: Color(0xFFFFE9CC),
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'package:flutter/gestures.dart · multi-pointer · claims arena on PointerDown · returns Drag from onStart.',
                  style: TextStyle(
                    color: Color(0xFFC5B49A),
                    fontSize: 11.5,
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
