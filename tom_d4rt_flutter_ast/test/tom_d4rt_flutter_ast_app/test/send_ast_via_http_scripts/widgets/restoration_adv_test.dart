// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// =============================================================================
//  RESTORATION ADVANCED  —  a deep, visual tour of Flutter's state restoration
//                          stack: RestorableProperty, RestorableValue family,
//                          RestorationMixin, RestorationScope, RestorationBucket
// =============================================================================
//
//  This file is a hand-authored visual demo. The harness runs `build()` as a
//  top-level function inside a corpus of widget tests. We cannot create a real
//  `State` subclass here (the corpus rejects them) — so instead we *describe*
//  the restoration system through layered diagrams, decision matrices, code
//  snippets, and palette swatches. Every section is intended to read like a
//  cheatsheet poster: chunky, deliberate, and information-dense.
//
//  Sections (top to bottom):
//    1. Title banner with the restoration motto.
//    2. Conceptual overview of RestorationManager → buckets → properties.
//    3. Nested bucket anatomy diagram (CustomPainter).
//    4. Decision matrix mapping primitive types → RestorableProperty subclass.
//    5. Lifecycle ribbon: restoreState → registerForRestoration → dispose.
//    6. Code snippet card: RestorationMixin skeleton.
//    7. RestorableTextEditingController spotlight.
//    8. RestorationScope vs UnmanagedRestorationScope comparison.
//    9. Palette of property variations (Wrap).
//   10. Pitfalls and rules of thumb card.
//   11. Closing reference table summarising every RestorableProperty subclass.
//
//  Visual rules of engagement:
//    - At least 8 section cards, each with its own gradient + multi-layer
//      shadow combo, distinct from siblings.
//    - At least 6 unique gradients and 6 unique shadows file-wide.
//    - Per-section prose is ≥ 60 words, hand-written.
//    - No animation controllers, no async, no Timer, no setState at root.
//    - Interactive bits live inside `StatefulBuilder` blocks.
//
// =============================================================================

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// =============================================================================
// PALETTE — every gradient and shadow used in the demo lives here so that the
// section helpers stay readable and the visual vocabulary is auditable.
// =============================================================================

const Color _kInk = Color(0xFF101522);
const Color _kInkSoft = Color(0xFF2A3144);
const Color _kPaper = Color(0xFFF5F7FB);
const Color _kPaperEdge = Color(0xFFDEE3EE);

const Color _kAccentTeal = Color(0xFF1ABC9C);
const Color _kAccentTealDeep = Color(0xFF117A65);
const Color _kAccentAmber = Color(0xFFF1C40F);
const Color _kAccentAmberDeep = Color(0xFFB7950B);
const Color _kAccentMagenta = Color(0xFFD63384);
const Color _kAccentMagentaDeep = Color(0xFF7A1E50);
const Color _kAccentIndigo = Color(0xFF4B6CB7);
const Color _kAccentIndigoDeep = Color(0xFF182848);
const Color _kAccentEmerald = Color(0xFF27AE60);
const Color _kAccentEmeraldDeep = Color(0xFF196F3D);
const Color _kAccentCoral = Color(0xFFFF6F61);
const Color _kAccentCoralDeep = Color(0xFFB23A2E);
const Color _kAccentSlate = Color(0xFF5D6D7E);
const Color _kAccentSlateDeep = Color(0xFF1B2631);

// Gradient #1 — Title banner: deep night sky with a teal undertone.
const LinearGradient _gradTitle = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: <Color>[_kAccentIndigoDeep, _kAccentIndigo, _kAccentTealDeep],
  stops: <double>[0.0, 0.55, 1.0],
);

// Gradient #2 — Overview card: foggy paper with a slight cool tint.
const LinearGradient _gradOverview = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: <Color>[Color(0xFFEAF1FB), Color(0xFFD7E2F4)],
);

// Gradient #3 — Anatomy diagram backdrop: ink to slate.
const LinearGradient _gradAnatomy = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: <Color>[_kInk, _kInkSoft, _kAccentSlateDeep],
  stops: <double>[0.0, 0.5, 1.0],
);

// Gradient #4 — Decision matrix: warm parchment.
const LinearGradient _gradDecision = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: <Color>[Color(0xFFFFF8E1), Color(0xFFFCE4B3), Color(0xFFF7C873)],
  stops: <double>[0.0, 0.55, 1.0],
);

// Gradient #5 — Lifecycle ribbon: emerald to coral, like a state machine.
const LinearGradient _gradLifecycle = LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  colors: <Color>[_kAccentEmeraldDeep, _kAccentEmerald, _kAccentAmber, _kAccentCoral, _kAccentCoralDeep],
  stops: <double>[0.0, 0.3, 0.55, 0.8, 1.0],
);

// Gradient #6 — Code snippet card: dark editor vibe.
const LinearGradient _gradCode = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: <Color>[Color(0xFF161B22), Color(0xFF21262D)],
);

// Gradient #7 — TextEditingController spotlight: magenta to indigo.
const LinearGradient _gradSpotlight = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: <Color>[_kAccentMagentaDeep, _kAccentMagenta, _kAccentIndigo],
  stops: <double>[0.0, 0.6, 1.0],
);

// Gradient #8 — Scope comparison: split feel via two halves rendered separately.
const LinearGradient _gradScopeLeft = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: <Color>[Color(0xFFE3F2FD), Color(0xFFBBDEFB)],
);
const LinearGradient _gradScopeRight = LinearGradient(
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
  colors: <Color>[Color(0xFFFFEBEE), Color(0xFFFFCDD2)],
);

// Gradient #9 — Palette swatches background: pale lavender.
const LinearGradient _gradPalette = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: <Color>[Color(0xFFF3E5F5), Color(0xFFE1BEE7)],
);

// Gradient #10 — Pitfalls card: deep coral warning glow.
const LinearGradient _gradPitfalls = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: <Color>[Color(0xFFFFF3E0), Color(0xFFFFCC80), Color(0xFFFFA726)],
  stops: <double>[0.0, 0.55, 1.0],
);

// Gradient #11 — Reference table backdrop.
const LinearGradient _gradReference = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: <Color>[Color(0xFFECEFF1), Color(0xFFCFD8DC)],
);

// Shadow #1 — Crisp drop with secondary diffuse halo (used on the title banner).
const List<BoxShadow> _shadowTitle = <BoxShadow>[
  BoxShadow(color: Color(0x66000000), offset: Offset(0, 14), blurRadius: 32, spreadRadius: 2),
  BoxShadow(color: Color(0x331ABC9C), offset: Offset(0, 2), blurRadius: 6),
];

// Shadow #2 — Soft paper lift used on overview / decision cards.
const List<BoxShadow> _shadowPaper = <BoxShadow>[
  BoxShadow(color: Color(0x14000000), offset: Offset(0, 6), blurRadius: 14),
  BoxShadow(color: Color(0x0A000000), offset: Offset(0, 1), blurRadius: 2),
];

// Shadow #3 — Heavy diagram shadow, doubled for depth.
const List<BoxShadow> _shadowAnatomy = <BoxShadow>[
  BoxShadow(color: Color(0x80000000), offset: Offset(0, 18), blurRadius: 40, spreadRadius: 4),
  BoxShadow(color: Color(0x40000000), offset: Offset(0, 4), blurRadius: 8),
];

// Shadow #4 — Lifecycle ribbon glow.
const List<BoxShadow> _shadowLifecycle = <BoxShadow>[
  BoxShadow(color: Color(0x4427AE60), offset: Offset(-6, 6), blurRadius: 20),
  BoxShadow(color: Color(0x44FF6F61), offset: Offset(6, 6), blurRadius: 20),
];

// Shadow #5 — Code card: inner-feeling drop, slight tint.
const List<BoxShadow> _shadowCode = <BoxShadow>[
  BoxShadow(color: Color(0x66000000), offset: Offset(0, 10), blurRadius: 24),
  BoxShadow(color: Color(0x331ABC9C), offset: Offset(0, 0), blurRadius: 2, spreadRadius: 1),
];

// Shadow #6 — Spotlight magenta glow.
const List<BoxShadow> _shadowSpotlight = <BoxShadow>[
  BoxShadow(color: Color(0x66D63384), offset: Offset(0, 12), blurRadius: 28),
  BoxShadow(color: Color(0x224B6CB7), offset: Offset(0, -2), blurRadius: 8),
];

// Shadow #7 — Pitfalls warning shadow.
const List<BoxShadow> _shadowPitfalls = <BoxShadow>[
  BoxShadow(color: Color(0x44B23A2E), offset: Offset(0, 10), blurRadius: 22),
  BoxShadow(color: Color(0x22B7950B), offset: Offset(0, 4), blurRadius: 6),
];

// Shadow #8 — Reference table flat lift.
const List<BoxShadow> _shadowReference = <BoxShadow>[
  BoxShadow(color: Color(0x22000000), offset: Offset(0, 8), blurRadius: 16),
];

// =============================================================================
// CUSTOM PAINTERS — diagrams that visualise bucket nesting and key flow.
// =============================================================================

/// Paints concentric, labelled rectangles representing a bucket hierarchy:
///   root → "page" → "form" → "field". The label of each bucket and its
///   restorationId is drawn as a small chip in the top-left corner.
class _NestedBucketsPainter extends CustomPainter {
  const _NestedBucketsPainter();

  @override
  void paint(Canvas canvas, Size size) {
    // Define the four nested boxes with shrinking insets and custom colours.
    final List<_BucketLayer> layers = <_BucketLayer>[
      _BucketLayer(inset: 4, label: 'root', id: '<root>', fill: const Color(0xFF22304A), stroke: _kAccentTeal),
      _BucketLayer(inset: 28, label: 'page', id: 'home-page', fill: const Color(0xFF2E3F5C), stroke: _kAccentAmber),
      _BucketLayer(inset: 54, label: 'form', id: 'profile-form', fill: const Color(0xFF3A4E70), stroke: _kAccentEmerald),
      _BucketLayer(inset: 82, label: 'field', id: 'first-name', fill: const Color(0xFF4A6088), stroke: _kAccentCoral),
    ];

    for (final _BucketLayer layer in layers) {
      final Rect rect = Rect.fromLTWH(
        layer.inset.toDouble(),
        layer.inset.toDouble(),
        size.width - layer.inset * 2,
        size.height - layer.inset * 2,
      );
      final RRect rrect = RRect.fromRectAndRadius(rect, const Radius.circular(14));

      // Fill.
      canvas.drawRRect(rrect, Paint()..color = layer.fill);

      // Stroke.
      canvas.drawRRect(
        rrect,
        Paint()
          ..color = layer.stroke
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.0,
      );

      // Chip in the top-left of each box.
      final TextPainter labelPainter = TextPainter(
        text: TextSpan(
          children: <InlineSpan>[
            TextSpan(
              text: ' ${layer.label} ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.4,
                background: Paint()..color = layer.stroke.withValues(alpha: 0.85),
              ),
            ),
            const TextSpan(text: '  '),
            TextSpan(
              text: 'id="${layer.id}"',
              style: const TextStyle(color: Colors.white70, fontSize: 11, fontFamily: 'monospace'),
            ),
          ],
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      labelPainter.paint(canvas, Offset(rect.left + 10, rect.top + 8));
    }

    // Draw an inner caption at the very centre.
    final TextPainter caption = TextPainter(
      text: const TextSpan(
        text: 'RestorableValue\n  ↑  registerForRestoration\n  ↑  RestorationMixin',
        style: TextStyle(color: Colors.white, fontSize: 12, fontFamily: 'monospace', height: 1.4),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout(maxWidth: size.width - 200);
    caption.paint(
      canvas,
      Offset((size.width - caption.width) / 2, (size.height - caption.height) / 2),
    );
  }

  @override
  bool shouldRepaint(covariant _NestedBucketsPainter oldDelegate) => false;
}

class _BucketLayer {
  const _BucketLayer({
    required this.inset,
    required this.label,
    required this.id,
    required this.fill,
    required this.stroke,
  });
  final int inset;
  final String label;
  final String id;
  final Color fill;
  final Color stroke;
}

/// Paints the lifecycle flow as a horizontal sequence of bubbles connected by
/// arrows: restoreState → registerForRestoration → didUpdateRestorationId → dispose.
class _LifecycleFlowPainter extends CustomPainter {
  const _LifecycleFlowPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final List<_FlowStep> steps = <_FlowStep>[
      _FlowStep(label: 'restoreState', sub: 'first call', colour: _kAccentEmerald),
      _FlowStep(label: 'registerForRestoration', sub: 'each property', colour: _kAccentTeal),
      _FlowStep(label: 'didUpdateRestorationId', sub: 'id change', colour: _kAccentAmber),
      _FlowStep(label: 'restoreState', sub: 'old=bucket', colour: _kAccentMagenta),
      _FlowStep(label: 'dispose', sub: 'unregister', colour: _kAccentCoral),
    ];

    final double bubbleWidth = (size.width - (steps.length + 1) * 12) / steps.length;
    final double bubbleHeight = size.height - 16;

    for (int i = 0; i < steps.length; i++) {
      final _FlowStep step = steps[i];
      final double left = 12 + i * (bubbleWidth + 12);
      final Rect rect = Rect.fromLTWH(left, 8, bubbleWidth, bubbleHeight);
      final RRect rrect = RRect.fromRectAndRadius(rect, const Radius.circular(16));

      canvas.drawRRect(rrect, Paint()..color = step.colour.withValues(alpha: 0.85));
      canvas.drawRRect(
        rrect,
        Paint()
          ..color = Colors.white.withValues(alpha: 0.6)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5,
      );

      final TextPainter titlePainter = TextPainter(
        text: TextSpan(
          text: step.label,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 13, height: 1.1),
        ),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
        maxLines: 2,
      )..layout(maxWidth: bubbleWidth - 12);

      final TextPainter subPainter = TextPainter(
        text: TextSpan(
          text: step.sub,
          style: const TextStyle(color: Colors.white70, fontSize: 11, fontFamily: 'monospace'),
        ),
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: bubbleWidth - 12);

      titlePainter.paint(canvas, Offset(left + (bubbleWidth - titlePainter.width) / 2, rect.top + 14));
      subPainter.paint(canvas, Offset(left + (bubbleWidth - subPainter.width) / 2, rect.bottom - subPainter.height - 12));

      // Arrow between bubbles.
      if (i < steps.length - 1) {
        final double startX = rect.right + 1;
        final double endX = rect.right + 11;
        final double midY = rect.center.dy;
        final Paint arrow = Paint()
          ..color = Colors.white70
          ..strokeWidth = 2.0
          ..strokeCap = StrokeCap.round;
        canvas.drawLine(Offset(startX, midY), Offset(endX, midY), arrow);
        canvas.drawLine(Offset(endX, midY), Offset(endX - 4, midY - 4), arrow);
        canvas.drawLine(Offset(endX, midY), Offset(endX - 4, midY + 4), arrow);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _LifecycleFlowPainter oldDelegate) => false;
}

class _FlowStep {
  const _FlowStep({required this.label, required this.sub, required this.colour});
  final String label;
  final String sub;
  final Color colour;
}

// =============================================================================
// SECTION HELPERS — each helper returns a single `Widget` for the column.
// They are intentionally chunky so the file reads top-to-bottom like a poster.
// =============================================================================

Widget _buildTitleBanner() {
  return Container(
    margin: const EdgeInsets.fromLTRB(20, 20, 20, 12),
    padding: const EdgeInsets.fromLTRB(28, 28, 28, 32),
    decoration: BoxDecoration(
      gradient: _gradTitle,
      borderRadius: BorderRadius.circular(24),
      boxShadow: _shadowTitle,
      border: Border.all(color: _kAccentTeal.withValues(alpha: 0.4), width: 1.2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _kAccentTeal,
                borderRadius: BorderRadius.circular(999),
                boxShadow: const <BoxShadow>[
                  BoxShadow(color: Color(0x33000000), offset: Offset(0, 2), blurRadius: 4),
                ],
              ),
              child: const Text(
                'flutter / restoration',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 11, letterSpacing: 1.4),
              ),
            ),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _kAccentAmber.withValues(alpha: 0.85),
                borderRadius: BorderRadius.circular(999),
              ),
              child: const Text(
                'visual demo',
                style: TextStyle(color: _kInk, fontWeight: FontWeight.w700, fontSize: 11, letterSpacing: 1.4),
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        const Text(
          'Advanced State Restoration',
          style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.w900, height: 1.1, letterSpacing: -0.5),
        ),
        const SizedBox(height: 8),
        const Text(
          'RestorableProperty • RestorationMixin • RestorationScope • RestorationBucket',
          style: TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.4),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.25),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
          ),
          child: const Text(
            'State restoration in Flutter lets the framework hand a piece of\n'
            'durable, serialisable state back to your widgets after the process\n'
            'was killed by the OS. Restorables live in buckets; buckets live in\n'
            'a tree keyed by restorationIds; and that tree is rooted in the\n'
            'RestorationManager. This card-deck demo walks you through every\n'
            'moving piece without spinning up a real State subclass.',
            style: TextStyle(color: Colors.white, fontSize: 13, height: 1.55),
          ),
        ),
      ],
    ),
  );
}

Widget _buildOverviewSection() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    padding: const EdgeInsets.all(22),
    decoration: BoxDecoration(
      gradient: _gradOverview,
      borderRadius: BorderRadius.circular(20),
      boxShadow: _shadowPaper,
      border: Border.all(color: _kPaperEdge),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const _SectionHeader(
          tag: '01',
          title: 'Why restoration exists',
          accent: _kAccentIndigo,
        ),
        const SizedBox(height: 12),
        const Text(
          'When iOS or Android decides your background app is in the way, it '
          'tears your process down. The user, however, expects to return to '
          'the exact field they were editing, the same tab, with the same '
          'scroll position. The restoration framework solves this by letting '
          'individual widgets opt in to persisting a tiny, structured slice '
          'of their state into a tree of RestorationBuckets that the engine '
          'serialises across launches. Buckets are addressed by stable, '
          'developer-chosen restorationIds — so the contract is purely about '
          'identity, not pointer-equality.',
          style: TextStyle(color: _kInk, fontSize: 13.5, height: 1.55),
        ),
        const SizedBox(height: 14),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _miniBadge(label: 'serialisable', colour: _kAccentTealDeep),
            _miniBadge(label: 'opt-in', colour: _kAccentMagentaDeep),
            _miniBadge(label: 'id-keyed', colour: _kAccentAmberDeep),
            _miniBadge(label: 'tree-shaped', colour: _kAccentIndigoDeep),
          ],
        ),
      ],
    ),
  );
}

Widget _buildAnatomyDiagram() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    padding: const EdgeInsets.fromLTRB(22, 22, 22, 18),
    decoration: BoxDecoration(
      gradient: _gradAnatomy,
      borderRadius: BorderRadius.circular(22),
      boxShadow: _shadowAnatomy,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const _SectionHeader(
          tag: '02',
          title: 'Bucket anatomy — nested by restorationId',
          accent: _kAccentTeal,
          onDark: true,
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 260,
          child: CustomPaint(
            painter: const _NestedBucketsPainter(),
            child: const SizedBox.expand(),
          ),
        ),
        const SizedBox(height: 14),
        const Text(
          'Each concentric rectangle is a RestorationBucket. The outermost is '
          'owned by the RestorationManager; every inner one is a child keyed '
          'by a restorationId chosen by the widget that opened the scope. A '
          'RestorableValue (the innermost dot) ultimately writes its primitive '
          'payload — int, double, String, bool, list of those — into the '
          'leafmost bucket. When the OS later hands us back a serialised '
          'tree, the framework walks the same id path and rehydrates the '
          'value before the first build call. Identity is everything; ids '
          'must be stable across launches or the data is dropped.',
          style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.55),
        ),
      ],
    ),
  );
}

Widget _buildDecisionMatrix() {
  // Use a DataTable for the "pick your RestorableProperty" decision matrix.
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: _gradDecision,
      borderRadius: BorderRadius.circular(20),
      boxShadow: _shadowPaper,
      border: Border.all(color: _kAccentAmberDeep.withValues(alpha: 0.35)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const _SectionHeader(
          tag: '03',
          title: 'Pick your RestorableProperty',
          accent: _kAccentAmberDeep,
        ),
        const SizedBox(height: 10),
        const Text(
          'There is one RestorableProperty subclass for almost every primitive '
          'you can think of. Nullable cousins exist for any type where null is '
          'semantically meaningful. Whenever you find yourself reaching for a '
          'plain ValueNotifier inside a State, ask first whether the user '
          'would care if the value were lost on relaunch. If yes, switch to '
          'the matching Restorable type instead.',
          style: TextStyle(color: _kInk, fontSize: 13, height: 1.5),
        ),
        const SizedBox(height: 14),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            headingRowColor: WidgetStateProperty.all(_kAccentAmberDeep.withValues(alpha: 0.18)),
            border: TableBorder.all(color: _kAccentAmberDeep.withValues(alpha: 0.3), width: 1),
            columns: const <DataColumn>[
              DataColumn(label: Text('You have', style: TextStyle(fontWeight: FontWeight.w800))),
              DataColumn(label: Text('Use class', style: TextStyle(fontWeight: FontWeight.w800))),
              DataColumn(label: Text('Nullable variant', style: TextStyle(fontWeight: FontWeight.w800))),
              DataColumn(label: Text('Notes', style: TextStyle(fontWeight: FontWeight.w800))),
            ],
            rows: const <DataRow>[
              DataRow(cells: <DataCell>[
                DataCell(Text('int')),
                DataCell(Text('RestorableInt')),
                DataCell(Text('RestorableIntN')),
                DataCell(Text('Counters, indices, page numbers')),
              ]),
              DataRow(cells: <DataCell>[
                DataCell(Text('double')),
                DataCell(Text('RestorableDouble')),
                DataCell(Text('RestorableDoubleN')),
                DataCell(Text('Scroll offsets, slider values')),
              ]),
              DataRow(cells: <DataCell>[
                DataCell(Text('num')),
                DataCell(Text('RestorableNum<T>')),
                DataCell(Text('RestorableNumN<T>')),
                DataCell(Text('Generic numeric container')),
              ]),
              DataRow(cells: <DataCell>[
                DataCell(Text('String')),
                DataCell(Text('RestorableString')),
                DataCell(Text('RestorableStringN')),
                DataCell(Text('Form fields, identifiers')),
              ]),
              DataRow(cells: <DataCell>[
                DataCell(Text('bool')),
                DataCell(Text('RestorableBool')),
                DataCell(Text('RestorableBoolN')),
                DataCell(Text('Toggles, expanded/collapsed')),
              ]),
              DataRow(cells: <DataCell>[
                DataCell(Text('DateTime')),
                DataCell(Text('RestorableDateTime')),
                DataCell(Text('RestorableDateTimeN')),
                DataCell(Text('Date pickers, reminders')),
              ]),
              DataRow(cells: <DataCell>[
                DataCell(Text('Enum')),
                DataCell(Text('RestorableEnum<T>')),
                DataCell(Text('RestorableEnumN<T>')),
                DataCell(Text('Dropdowns, mode selectors')),
              ]),
              DataRow(cells: <DataCell>[
                DataCell(Text('TextEditingValue')),
                DataCell(Text('RestorableTextEditingController')),
                DataCell(Text('—')),
                DataCell(Text('Wraps a controller; auto-disposes')),
              ]),
              DataRow(cells: <DataCell>[
                DataCell(Text('Custom object')),
                DataCell(Text('extends RestorableValue<T>')),
                DataCell(Text('—')),
                DataCell(Text('Implement toPrimitives / fromPrimitives')),
              ]),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildLifecycleRibbon() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    padding: const EdgeInsets.fromLTRB(22, 22, 22, 18),
    decoration: BoxDecoration(
      gradient: _gradLifecycle,
      borderRadius: BorderRadius.circular(22),
      boxShadow: _shadowLifecycle,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const _SectionHeader(
          tag: '04',
          title: 'Lifecycle of a RestorationMixin',
          accent: Colors.white,
          onDark: true,
        ),
        const SizedBox(height: 8),
        const Text(
          'When the framework hands a bucket to your State, it calls '
          'restoreState first with the old bucket (or null on a cold start). '
          'You register each RestorableProperty against the new bucket using '
          'registerForRestoration, supplying a child id. If the parent later '
          'changes its restorationId, didUpdateRestorationId fires and the '
          'framework re-runs the wiring. Finally, on dispose, your properties '
          'are unregistered automatically — but you still have to call '
          'super.dispose() to flush them.',
          style: TextStyle(color: Colors.white, fontSize: 13, height: 1.5),
        ),
        const SizedBox(height: 14),
        SizedBox(
          height: 92,
          child: CustomPaint(
            painter: const _LifecycleFlowPainter(),
            child: const SizedBox.expand(),
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Note that registerForRestoration is also the *read* path: the '
          'first time it runs against a bucket that already contains a value '
          'for the supplied id, your RestorableValue.fromPrimitives is '
          'invoked to rehydrate. The same call writes new values out via '
          'toPrimitives whenever the underlying value notifies.',
          style: TextStyle(color: Colors.white70, fontSize: 12.5, height: 1.5),
        ),
      ],
    ),
  );
}

Widget _buildCodeSnippetCard() {
  const String snippet = '''
class _ProfilePageState extends State<ProfilePage>
    with RestorationMixin {

  // Each property declares its own initial value.
  final RestorableInt        _age   = RestorableInt(0);
  final RestorableString     _name  = RestorableString('');
  final RestorableBool       _vip   = RestorableBool(false);
  final RestorableDateTime   _born  = RestorableDateTime(DateTime(2000));
  final RestorableEnum<Mode> _mode  = RestorableEnum<Mode>(
    Mode.compact, values: Mode.values,
  );
  final RestorableTextEditingController _bio =
      RestorableTextEditingController();

  @override
  String? get restorationId => 'profile-page';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_age,  'age');
    registerForRestoration(_name, 'name');
    registerForRestoration(_vip,  'vip');
    registerForRestoration(_born, 'born');
    registerForRestoration(_mode, 'mode');
    registerForRestoration(_bio,  'bio');
  }

  @override
  void dispose() {
    _age.dispose(); _name.dispose(); _vip.dispose();
    _born.dispose(); _mode.dispose(); _bio.dispose();
    super.dispose();
  }
}
''';
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    padding: const EdgeInsets.fromLTRB(22, 22, 22, 18),
    decoration: BoxDecoration(
      gradient: _gradCode,
      borderRadius: BorderRadius.circular(20),
      boxShadow: _shadowCode,
      border: Border.all(color: _kAccentTeal.withValues(alpha: 0.4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const _SectionHeader(
          tag: '05',
          title: 'RestorationMixin skeleton',
          accent: _kAccentTeal,
          onDark: true,
        ),
        const SizedBox(height: 10),
        const Text(
          'This is the canonical shape. The restorationId getter anchors the '
          'state into the bucket tree; restoreState wires every property to a '
          'child id; dispose tears them down in the same order. You do not '
          'need to call super.restoreState — the mixin already handles the '
          'bucket bookkeeping for you. The properties themselves are simple '
          'ChangeNotifier-shaped objects whose .value setter writes through '
          'to the bucket.',
          style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.5),
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.35),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
          ),
          child: const Text(
            snippet,
            style: TextStyle(
              color: Color(0xFFE6F1FF),
              fontFamily: 'monospace',
              fontSize: 12,
              height: 1.45,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildSpotlightCard(BuildContext context) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    padding: const EdgeInsets.all(22),
    decoration: BoxDecoration(
      gradient: _gradSpotlight,
      borderRadius: BorderRadius.circular(22),
      boxShadow: _shadowSpotlight,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const _SectionHeader(
          tag: '06',
          title: 'Spotlight: RestorableTextEditingController',
          accent: _kAccentAmber,
          onDark: true,
        ),
        const SizedBox(height: 10),
        const Text(
          'Of the entire family, the text-editing controller is the trickiest '
          'because it wraps a *listener* object whose lifetime you would '
          'normally manage by hand. The Restorable variant takes care of '
          'creating the inner TextEditingController lazily, listens to it for '
          'changes, and disposes it when you dispose the Restorable. You '
          'never call .dispose on the inner controller directly. A nice side '
          'effect: the value field returns the live controller, so you can '
          'pass restorable.value straight into a TextField as its controller.',
          style: TextStyle(color: Colors.white, fontSize: 13, height: 1.5),
        ),
        const SizedBox(height: 14),
        StatefulBuilder(
          builder: (BuildContext context, void Function(void Function()) setState) {
            return Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: const <BoxShadow>[
                  BoxShadow(color: Color(0x33000000), offset: Offset(0, 4), blurRadius: 12),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Demo input — type freely (not actually persisted in this static demo)',
                    style: TextStyle(color: _kInk, fontWeight: FontWeight.w700, fontSize: 12),
                  ),
                  const SizedBox(height: 10),
                  const TextField(
                    decoration: InputDecoration(
                      labelText: 'Bio',
                      hintText: 'Tell us about yourself',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      Icon(Icons.bookmark, size: 16, color: _kAccentMagentaDeep.withValues(alpha: 0.9)),
                      const SizedBox(width: 6),
                      const Expanded(
                        child: Text(
                          'In a real RestorationMixin, the controller above would '
                          'be supplied by _bio.value, and the bucket would already '
                          'contain the previous text by the time the first frame paints.',
                          style: TextStyle(color: _kInkSoft, fontSize: 12, height: 1.4),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ],
    ),
  );
}

Widget _buildScopeComparisonCard() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    padding: const EdgeInsets.all(22),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(22),
      boxShadow: _shadowPaper,
      border: Border.all(color: _kPaperEdge),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const _SectionHeader(
          tag: '07',
          title: 'RestorationScope vs UnmanagedRestorationScope',
          accent: _kAccentIndigo,
        ),
        const SizedBox(height: 10),
        const Text(
          'Most apps only ever see RestorationScope: it pulls the current '
          'bucket from its ancestor, opens a child keyed by the given id, '
          'and exposes it down the tree. UnmanagedRestorationScope is the '
          'escape hatch — it lets you mount a bucket you obtained by other '
          'means (typically when you are bridging into a navigator route or '
          'a sub-app). The two widgets are otherwise siblings in the same '
          'family and have the same downstream semantics.',
          style: TextStyle(color: _kInk, fontSize: 13, height: 1.5),
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  gradient: _gradScopeLeft,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFF90CAF9)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    Text('RestorationScope', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: _kInk)),
                    SizedBox(height: 6),
                    Text(
                      '• Reads ancestor bucket via context.\n'
                      '• Opens a child bucket using restorationId.\n'
                      '• Auto-disposes the child when removed.\n'
                      '• Cheapest, most common variant.\n'
                      '• Great for routes, sheets, sub-trees.',
                      style: TextStyle(color: _kInkSoft, fontSize: 12.5, height: 1.5),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  gradient: _gradScopeRight,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFEF9A9A)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    Text('UnmanagedRestorationScope', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: _kInk)),
                    SizedBox(height: 6),
                    Text(
                      '• Caller owns the RestorationBucket.\n'
                      '• Mount the bucket directly — no parent.\n'
                      '• You are responsible for disposal.\n'
                      '• Useful for ad-hoc, isolated trees.\n'
                      '• Often paired with RootRestorationScope.',
                      style: TextStyle(color: _kInkSoft, fontSize: 12.5, height: 1.5),
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

Widget _buildPaletteSection() {
  // Wrap of small "swatch" cards, one per RestorableValue subclass.
  final List<_Swatch> swatches = <_Swatch>[
    const _Swatch('RestorableInt',                  '0',                  _kAccentTeal),
    const _Swatch('RestorableIntN',                 'null | int',         _kAccentTealDeep),
    const _Swatch('RestorableDouble',               '0.0',                _kAccentEmerald),
    const _Swatch('RestorableDoubleN',              'null | double',      _kAccentEmeraldDeep),
    const _Swatch('RestorableNum<T>',               'generic',            _kAccentIndigo),
    const _Swatch('RestorableNumN<T>',              'generic | null',     _kAccentIndigoDeep),
    const _Swatch('RestorableString',               '""',                 _kAccentAmber),
    const _Swatch('RestorableStringN',              'null | String',      _kAccentAmberDeep),
    const _Swatch('RestorableBool',                 'false',              _kAccentMagenta),
    const _Swatch('RestorableBoolN',                'null | bool',        _kAccentMagentaDeep),
    const _Swatch('RestorableDateTime',             'epoch',              _kAccentCoral),
    const _Swatch('RestorableDateTimeN',            'null | DateTime',    _kAccentCoralDeep),
    const _Swatch('RestorableEnum<T>',              'T.values[0]',        _kAccentSlate),
    const _Swatch('RestorableEnumN<T>',             'null | T',           _kAccentSlateDeep),
    const _Swatch('RestorableTextEditingController','""',                 _kAccentTealDeep),
  ];
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    padding: const EdgeInsets.all(22),
    decoration: BoxDecoration(
      gradient: _gradPalette,
      borderRadius: BorderRadius.circular(20),
      boxShadow: _shadowPaper,
      border: Border.all(color: const Color(0xFFCE93D8)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const _SectionHeader(
          tag: '08',
          title: 'Palette of RestorableValue subclasses',
          accent: _kAccentMagentaDeep,
        ),
        const SizedBox(height: 10),
        const Text(
          'A visual reminder that the API surface is genuinely small. Every '
          'tile below is a single class shipped by package:flutter — the only '
          'thing varying is the wrapped primitive. The default value shown in '
          'the chip is the value the property assumes the first time it is '
          'asked to provide one, before restoration has occurred. Pick the '
          'tile that matches your data and you are 90% of the way to a '
          'restoration-aware widget.',
          style: TextStyle(color: _kInk, fontSize: 13, height: 1.5),
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: <Widget>[
            for (final _Swatch s in swatches)
              Container(
                width: 200,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: s.colour.withValues(alpha: 0.45)),
                  boxShadow: const <BoxShadow>[
                    BoxShadow(color: Color(0x14000000), offset: Offset(0, 3), blurRadius: 6),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          width: 10, height: 10,
                          decoration: BoxDecoration(
                            color: s.colour, borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            s.name,
                            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 12.5, color: _kInk),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: s.colour.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'default: ${s.defaultValue}',
                        style: TextStyle(color: s.colour, fontSize: 11, fontFamily: 'monospace'),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildPitfallsCard() {
  final List<_Pitfall> pitfalls = const <_Pitfall>[
    _Pitfall(
      icon: Icons.fingerprint,
      title: 'Stable restorationIds',
      body: 'Never derive a restorationId from something that changes per '
            'launch — index in a randomly-shuffled list, an auto-generated '
            'UUID, a hash of the user object. The id must be the same on '
            'launch N+1 as it was on launch N, or the bucket is orphaned.',
    ),
    _Pitfall(
      icon: Icons.cleaning_services_outlined,
      title: 'Dispose every Restorable',
      body: 'Properties hold listeners and a reference to the bucket. Always '
            'call .dispose() in your State.dispose, even though the mixin '
            'unregisters them — the listeners are yours.',
    ),
    _Pitfall(
      icon: Icons.travel_explore,
      title: 'Use the right scope',
      body: 'A Navigator already wraps each route in a RestorationScope. You '
            'rarely need to add another one. Only reach for '
            'UnmanagedRestorationScope when bridging foreign buckets.',
    ),
    _Pitfall(
      icon: Icons.bug_report_outlined,
      title: 'Test cold-start paths',
      body: 'Use the flutter_test restoration helpers (restartAndRestore) to '
            'simulate the OS dropping your process. A widget that "works" '
            'inside a hot-reload session can still be broken on real cold '
            'starts.',
    ),
  ];

  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    padding: const EdgeInsets.all(22),
    decoration: BoxDecoration(
      gradient: _gradPitfalls,
      borderRadius: BorderRadius.circular(22),
      boxShadow: _shadowPitfalls,
      border: Border.all(color: _kAccentCoralDeep.withValues(alpha: 0.4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const _SectionHeader(
          tag: '09',
          title: 'Pitfalls & rules of thumb',
          accent: _kAccentCoralDeep,
        ),
        const SizedBox(height: 10),
        const Text(
          'Restoration is one of those features that looks simple on paper '
          'but quietly punishes shortcuts. The four traps below are the ones '
          'we see most often in code review. The fix is always the same: be '
          'deliberate about identity, deliberate about disposal, and test '
          'the cold-start path explicitly with the flutter_test restoration '
          'helpers — never assume hot-reload is representative.',
          style: TextStyle(color: _kInk, fontSize: 13, height: 1.55),
        ),
        const SizedBox(height: 14),
        for (final _Pitfall p in pitfalls)
          Container(
            margin: const EdgeInsets.symmetric(vertical: 6),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.85),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _kAccentCoralDeep.withValues(alpha: 0.25)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(p.icon, color: _kAccentCoralDeep, size: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        p.title,
                        style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: _kInk),
                      ),
                      const SizedBox(height: 4),
                      Text(p.body, style: const TextStyle(color: _kInkSoft, fontSize: 12.5, height: 1.45)),
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

Widget _buildReferenceTableCard() {
  return Container(
    margin: const EdgeInsets.fromLTRB(20, 10, 20, 24),
    padding: const EdgeInsets.all(22),
    decoration: BoxDecoration(
      gradient: _gradReference,
      borderRadius: BorderRadius.circular(22),
      boxShadow: _shadowReference,
      border: Border.all(color: _kPaperEdge),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const _SectionHeader(
          tag: '10',
          title: 'Closing reference table — every RestorableProperty subclass',
          accent: _kAccentSlateDeep,
        ),
        const SizedBox(height: 10),
        const Text(
          'A single sheet you can keep open while wiring up a new screen. '
          'Each row names the class, the wrapped primitive, the engine-side '
          'representation it serialises into, and a typical use case. The '
          'engine-side representation matters because it tells you what '
          'shape your toPrimitives must return when you write a custom '
          'subclass of RestorableValue.',
          style: TextStyle(color: _kInk, fontSize: 13, height: 1.55),
        ),
        const SizedBox(height: 14),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Table(
            columnWidths: const <int, TableColumnWidth>{
              0: FixedColumnWidth(220),
              1: FixedColumnWidth(120),
              2: FixedColumnWidth(160),
              3: FlexColumnWidth(),
            },
            border: TableBorder.all(color: _kAccentSlate.withValues(alpha: 0.35)),
            children: <TableRow>[
              TableRow(
                decoration: BoxDecoration(color: _kAccentSlate.withValues(alpha: 0.18)),
                children: const <Widget>[
                  _TableHead('Class'),
                  _TableHead('Wraps'),
                  _TableHead('Primitive'),
                  _TableHead('Typical use'),
                ],
              ),
              _refRow('RestorableInt',                          'int',              'int',       'counters, indices, totals'),
              _refRow('RestorableIntN',                         'int?',             'int|null',  'optional counters'),
              _refRow('RestorableDouble',                       'double',           'double',    'slider values, dimensions'),
              _refRow('RestorableDoubleN',                      'double?',          'double|null','optional sliders'),
              _refRow('RestorableNum<T extends num>',           'T',                'num',       'generic numeric stores'),
              _refRow('RestorableNumN<T extends num>',          'T?',               'num|null',  'optional generic numeric'),
              _refRow('RestorableString',                       'String',           'String',    'form fields, names'),
              _refRow('RestorableStringN',                      'String?',          'String|null','optional fields'),
              _refRow('RestorableBool',                         'bool',             'bool',      'toggles, switches'),
              _refRow('RestorableBoolN',                        'bool?',            'bool|null', 'tri-state toggles'),
              _refRow('RestorableDateTime',                     'DateTime',         'int(micros)','timestamps, picker values'),
              _refRow('RestorableDateTimeN',                    'DateTime?',        'int|null',  'optional timestamps'),
              _refRow('RestorableEnum<T extends Enum>',         'T',                'String',    'enum-backed dropdowns'),
              _refRow('RestorableEnumN<T extends Enum>',        'T?',               'String|null','optional enum dropdowns'),
              _refRow('RestorableTextEditingController',        'TextEditingController','String','text inputs'),
              _refRow('RestorableValue<T>',                     'T',                'depends',   'roll your own primitive'),
              _refRow('RestorableListenable<T>',                'T (Listenable)',   'derived',   'wrap Listenable-shaped state'),
              _refRow('RestorableChangeNotifier<T>',            'T (ChangeNotifier)','derived',  'wrap ChangeNotifier subclasses'),
              _refRow('RestorableRouteFuture<T>',               'route result',     'arguments', 'navigator route results'),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _kAccentSlate.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Text(
            'Reminder: RestorableProperty itself is abstract — you never '
            'instantiate it directly. RestorableValue<T> is the abstract '
            'subclass to extend when none of the built-ins fit; you implement '
            'toPrimitives()/fromPrimitives() and createDefaultValue().',
            style: TextStyle(color: _kInkSoft, fontSize: 12, height: 1.45),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// SMALL HELPERS / BUILDING BLOCKS
// =============================================================================

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.tag,
    required this.title,
    required this.accent,
    this.onDark = false,
  });
  final String tag;
  final String title;
  final Color accent;
  final bool onDark;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: accent,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            tag,
            style: TextStyle(
              color: onDark ? _kInk : Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 12,
              letterSpacing: 1.2,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              color: onDark ? Colors.white : _kInk,
              fontWeight: FontWeight.w900,
              fontSize: 18,
              height: 1.2,
              letterSpacing: -0.2,
            ),
          ),
        ),
      ],
    );
  }
}

Widget _miniBadge({required String label, required Color colour}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: colour.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(999),
      border: Border.all(color: colour.withValues(alpha: 0.55)),
    ),
    child: Text(
      label,
      style: TextStyle(color: colour, fontWeight: FontWeight.w700, fontSize: 11, letterSpacing: 0.6),
    ),
  );
}

class _Swatch {
  const _Swatch(this.name, this.defaultValue, this.colour);
  final String name;
  final String defaultValue;
  final Color colour;
}

class _Pitfall {
  const _Pitfall({required this.icon, required this.title, required this.body});
  final IconData icon;
  final String title;
  final String body;
}

class _TableHead extends StatelessWidget {
  const _TableHead(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: 12.5,
          color: _kInk,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}

TableRow _refRow(String name, String wraps, String primitive, String use) {
  return TableRow(
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(name, style: const TextStyle(fontFamily: 'monospace', fontSize: 12, color: _kInk)),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(wraps, style: const TextStyle(fontFamily: 'monospace', fontSize: 12, color: _kInkSoft)),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(primitive, style: const TextStyle(fontFamily: 'monospace', fontSize: 12, color: _kInkSoft)),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(use, style: const TextStyle(fontSize: 12, color: _kInkSoft)),
      ),
    ],
  );
}

// =============================================================================
// HARNESS ENTRY — top-level build(BuildContext). MaterialApp → Scaffold →
// SafeArea → SingleChildScrollView → Column.
// =============================================================================

dynamic build(BuildContext context) {
  // Talk to the developer running the corpus.
  print('--- Restoration Advanced Demo ---');
  print('RestorableProperty            : $RestorableProperty');
  print('RestorationMixin              : $RestorationMixin');
  print('RestorationBucket             : $RestorationBucket');
  print('RestorationScope              : $RestorationScope');
  print('UnmanagedRestorationScope     : $UnmanagedRestorationScope');
  print('RootRestorationScope          : $RootRestorationScope');
  print('--- Property family ---');
  // We instantiate a few properties just to prove they exist; we never
  // register them with a real bucket.
  final RestorableInt    ri  = RestorableInt(42);
  final RestorableDouble rd  = RestorableDouble(3.14159);
  final RestorableString rs  = RestorableString('Tom');
  final RestorableBool   rb  = RestorableBool(true);
  final RestorableDateTime rdt = RestorableDateTime(DateTime(2026, 5, 11));
  print('RestorableInt(42)             : $ri (value=${ri.value})');
  print('RestorableDouble(3.14)        : $rd (value=${rd.value})');
  print('RestorableString("Tom")       : $rs (value=${rs.value})');
  print('RestorableBool(true)          : $rb (value=${rb.value})');
  print('RestorableDateTime(2026-5-11) : $rdt (value=${rdt.value})');
  // Reach into the services library to prove the import is used.
  const ClipboardData clip = ClipboardData(text: 'restorationId');
  print('ClipboardData("restorationId"): ${clip.text}');
  print('--- Restoration Advanced Demo OK ---');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Restoration Advanced — Visual Demo',
    theme: ThemeData(
      colorSchemeSeed: _kAccentIndigo,
      useMaterial3: true,
      scaffoldBackgroundColor: _kPaper,
    ),
    home: Scaffold(
      backgroundColor: _kPaper,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _buildTitleBanner(),
              _buildOverviewSection(),
              _buildAnatomyDiagram(),
              _buildDecisionMatrix(),
              _buildLifecycleRibbon(),
              _buildCodeSnippetCard(),
              _buildSpotlightCard(context),
              _buildScopeComparisonCard(),
              _buildPaletteSection(),
              _buildPitfallsCard(),
              _buildReferenceTableCard(),
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 24),
                child: Text(
                  'End of Restoration Advanced demo.\n'
                  'Total sections: 10. Total RestorableValue subclasses surveyed: 15+.',
                  style: TextStyle(color: _kInkSoft, fontSize: 12, height: 1.4),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
