// D4rt test script: Deep visual demonstration of TapDragEndDetails.
//
// TapDragEndDetails (package:flutter/gestures.dart) is the payload delivered
// by callbacks such as onDragEnd of BaseTapAndDragGestureRecognizer (and the
// concrete TapAndHorizontalDragGestureRecognizer / TapAndPanGestureRecognizer
// variants).  It marks the END of a composite gesture that started with one
// or more taps and continued with a drag — the moment the user lifts their
// pointer after dragging.
//
// Carried fields:
//   - globalPosition       Offset, screen-space position of the lift.
//   - localPosition        Offset, position relative to the receiving widget.
//   - velocity             Velocity, full 2-D pixels-per-second vector.
//   - primaryVelocity      double?, axis-projected velocity for 1-D recognisers.
//   - consecutiveTapCount  int, how many taps preceded the drag (1, 2, 3, ...).
//   - keysPressedOnDown    Set<LogicalKeyboardKey>, modifiers held at the
//                          initial down event (NOT at lift).
//   - kind                 PointerDeviceKind?, may be null on synthetic events.
//
// This deep demo lays out an extensive visual reference covering:
//   1. Hero header
//   2. Composite-gesture anatomy diagram
//   3. Field-by-field card grid
//   4. Velocity vector visualisation (4 samples, magnitudes + angles)
//   5. consecutiveTapCount showcase (1..4)
//   6. keysPressedOnDown showcase (none, Shift, Ctrl+Shift, Alt)
//   7. Constructor source + live readout
//   8. Comparison with DragEndDetails / LongPressEndDetails
//   9. Real-world usage cards
//  10. Caveats
//  11. Footer takeaways

import 'dart:math' as math;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ---------------------------------------------------------------------------
// Top-level value classes (no leading underscores on locals; classes may use
// a lowercase prefix so they read naturally in the layout code below).
// ---------------------------------------------------------------------------

class FieldEntry {
  const FieldEntry({
    required this.name,
    required this.type,
    required this.sample,
    required this.summary,
    required this.icon,
    required this.color,
  });

  final String name;
  final String type;
  final String sample;
  final String summary;
  final IconData icon;
  final Color color;
}

class VelocitySample {
  const VelocitySample({
    required this.label,
    required this.dx,
    required this.dy,
    required this.tint,
  });

  final String label;
  final double dx;
  final double dy;
  final Color tint;

  double get magnitude => math.sqrt(dx * dx + dy * dy);
  double get angleDegrees => math.atan2(dy, dx) * 180.0 / math.pi;
}

class TapCountSample {
  const TapCountSample({
    required this.count,
    required this.title,
    required this.story,
    required this.tint,
  });

  final int count;
  final String title;
  final String story;
  final Color tint;
}

class ModifierSample {
  const ModifierSample({
    required this.label,
    required this.keys,
    required this.story,
    required this.tint,
  });

  final String label;
  final List<String> keys;
  final String story;
  final Color tint;
}

class ComparisonRow {
  const ComparisonRow({
    required this.name,
    required this.recogniser,
    required this.fields,
    required this.tint,
    required this.icon,
  });

  final String name;
  final String recogniser;
  final List<String> fields;
  final Color tint;
  final IconData icon;
}

class UsagePattern {
  const UsagePattern({
    required this.title,
    required this.body,
    required this.tint,
    required this.icon,
  });

  final String title;
  final String body;
  final Color tint;
  final IconData icon;
}

class CaveatItem {
  const CaveatItem({
    required this.title,
    required this.body,
    required this.tint,
    required this.icon,
  });

  final String title;
  final String body;
  final Color tint;
  final IconData icon;
}

// ---------------------------------------------------------------------------
// build entry-point — single-file Flutter D4rt script.
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  // -------------------------------------------------------------------------
  // The canonical sample TapDragEndDetails instance — referenced from the
  // hero header, the field grid, the velocity panel, and the constructor
  // readout card.  A double-tap-and-shift-drag at (120, 80) global / (100,
  // 60) local with a strong rightward velocity.
  // -------------------------------------------------------------------------
  final TapDragEndDetails canonical = TapDragEndDetails(
    globalPosition: const Offset(120, 80),
    localPosition: const Offset(100, 60),
    velocity: const Velocity(pixelsPerSecond: Offset(420, -50)),
    primaryVelocity: 420,
    consecutiveTapCount: 2,
  );
  // The conceptual modifier set held at down — illustrative only.  This
  // is rendered in the readout so the demo still shows what a newer
  // Flutter's keysPressedOnDown would carry; the live instance above
  // does not store it on this Flutter version.
  final Set<LogicalKeyboardKey> conceptualKeysPressedOnDown =
      <LogicalKeyboardKey>{LogicalKeyboardKey.shift};

  // -------------------------------------------------------------------------
  // Field gallery — one card per public field.
  // -------------------------------------------------------------------------
  final List<FieldEntry> fields = const <FieldEntry>[
    FieldEntry(
      name: 'globalPosition',
      type: 'Offset',
      sample: 'Offset(120.0, 80.0)',
      summary:
          'Pointer position in screen coordinates at the moment the drag '
          'ended.  Useful when reporting positions to overlays or routes '
          'that live above the receiving widget.',
      icon: Icons.public,
      color: Color(0xFF1E88E5),
    ),
    FieldEntry(
      name: 'localPosition',
      type: 'Offset',
      sample: 'Offset(100.0, 60.0)',
      summary:
          'Same lift point but expressed in the receiving widget\'s local '
          'coordinate space.  This is the value most hit-test sensitive '
          'logic (selection, item index) consumes.',
      icon: Icons.crop_free,
      color: Color(0xFF43A047),
    ),
    FieldEntry(
      name: 'velocity',
      type: 'Velocity',
      sample: 'Velocity(Offset(420, -50))',
      summary:
          'Full 2-D pixels-per-second vector measured by the gesture\'s '
          'velocity tracker just before lift.  Drives fling / inertial '
          'animations on multi-axis recognisers.',
      icon: Icons.speed,
      color: Color(0xFFE53935),
    ),
    FieldEntry(
      name: 'primaryVelocity',
      type: 'double?',
      sample: '420.0',
      summary:
          'Axis-projected velocity exposed only by 1-D recognisers '
          '(horizontal / vertical TapAndDrag variants).  Null on '
          'TapAndPanGestureRecognizer because pan has two free axes.',
      icon: Icons.straighten,
      color: Color(0xFFFB8C00),
    ),
    FieldEntry(
      name: 'consecutiveTapCount',
      type: 'int',
      sample: '2',
      summary:
          'How many quick taps preceded the drag.  1 = single-tap-and-drag, '
          '2 = double-tap-and-drag, etc.  Lets the same recogniser drive '
          'different behaviours per tap count.',
      icon: Icons.repeat,
      color: Color(0xFF8E24AA),
    ),
    FieldEntry(
      name: 'keysPressedOnDown',
      type: 'Set<LogicalKeyboardKey>',
      sample: '{LogicalKeyboardKey.shift}',
      summary:
          'Modifier keys that were held at the INITIAL down event '
          '(not at lift).  Used to branch behaviour — for example, '
          'extend-selection on shift-drag.',
      icon: Icons.keyboard,
      color: Color(0xFF00897B),
    ),
    FieldEntry(
      name: 'kind',
      type: 'PointerDeviceKind?',
      sample: 'PointerDeviceKind.mouse',
      summary:
          'Pointer kind (touch, mouse, stylus, trackpad...).  Nullable — '
          'may be null on synthetic / replayed events that never carried '
          'a real device kind.',
      icon: Icons.devices_other,
      color: Color(0xFF6D4C41),
    ),
  ];

  // -------------------------------------------------------------------------
  // Velocity samples for the vector visualisation strip.  Each renders into
  // a 280x120 frame with arrow + magnitude + angle annotations.
  // -------------------------------------------------------------------------
  final List<VelocitySample> velocitySamples = const <VelocitySample>[
    VelocitySample(
      label: 'Horizontal flick',
      dx: 420,
      dy: -50,
      tint: Color(0xFF1565C0),
    ),
    VelocitySample(
      label: 'Slow diagonal',
      dx: 160,
      dy: 120,
      tint: Color(0xFF2E7D32),
    ),
    VelocitySample(
      label: 'Strong upward',
      dx: -30,
      dy: -540,
      tint: Color(0xFFC62828),
    ),
    VelocitySample(
      label: 'Tiny drift',
      dx: 35,
      dy: 18,
      tint: Color(0xFF6A1B9A),
    ),
  ];

  // -------------------------------------------------------------------------
  // Tap-count vignettes (1..4).
  // -------------------------------------------------------------------------
  final List<TapCountSample> tapCounts = const <TapCountSample>[
    TapCountSample(
      count: 1,
      title: 'Single tap then drag',
      story:
          'One down/up pair followed by movement.  Most common: '
          'standard text-cursor placement followed by a drag-to-select.',
      tint: Color(0xFF1976D2),
    ),
    TapCountSample(
      count: 2,
      title: 'Double tap then drag',
      story:
          'Two quick taps before motion.  Classic pattern in maps and '
          'images: double-tap-zoom that morphs into pan when the second '
          'tap is held and dragged.',
      tint: Color(0xFF388E3C),
    ),
    TapCountSample(
      count: 3,
      title: 'Triple tap then drag',
      story:
          'Power-user shortcut.  Some editors triple-tap-and-drag to '
          'extend a paragraph selection across paragraphs.',
      tint: Color(0xFFE65100),
    ),
    TapCountSample(
      count: 4,
      title: 'Quadruple tap then drag',
      story:
          'Edge-case but supported.  Rarely used for production gestures '
          'but exposed by the recogniser for completeness.',
      tint: Color(0xFFAD1457),
    ),
  ];

  // -------------------------------------------------------------------------
  // Modifier-combo vignettes for keysPressedOnDown.
  // -------------------------------------------------------------------------
  final List<ModifierSample> modifiers = const <ModifierSample>[
    ModifierSample(
      label: 'No modifiers',
      keys: <String>[],
      story:
          'A bare drag.  Typical default action — move the cursor or scroll '
          'the view.',
      tint: Color(0xFF455A64),
    ),
    ModifierSample(
      label: 'Shift held',
      keys: <String>['Shift'],
      story:
          'Common selection-extend modifier.  In a text field, shift-drag '
          'extends the selection from the previous caret position to the '
          'lift point.',
      tint: Color(0xFF00838F),
    ),
    ModifierSample(
      label: 'Ctrl + Shift',
      keys: <String>['Ctrl', 'Shift'],
      story:
          'Word-granular selection extend.  Editors commonly use this combo '
          'to grow the selection by whole words rather than characters.',
      tint: Color(0xFF6A1B9A),
    ),
    ModifierSample(
      label: 'Alt held',
      keys: <String>['Alt'],
      story:
          'Block-selection / column-mode in many code editors.  Alt-drag '
          'may also enable copy-while-drag in file managers.',
      tint: Color(0xFFD84315),
    ),
  ];

  // -------------------------------------------------------------------------
  // Comparison rows for *EndDetails siblings.
  // -------------------------------------------------------------------------
  final List<ComparisonRow> comparisons = const <ComparisonRow>[
    ComparisonRow(
      name: 'DragEndDetails',
      recogniser: 'DragGestureRecognizer family',
      fields: <String>[
        'velocity',
        'primaryVelocity',
        'globalPosition',
        'localPosition',
      ],
      tint: Color(0xFF1565C0),
      icon: Icons.swap_horiz,
    ),
    ComparisonRow(
      name: 'TapDragEndDetails',
      recogniser: 'BaseTapAndDragGestureRecognizer family',
      fields: <String>[
        'globalPosition',
        'localPosition',
        'velocity',
        'primaryVelocity',
        'consecutiveTapCount',
        'keysPressedOnDown',
        'kind',
      ],
      tint: Color(0xFF2E7D32),
      icon: Icons.touch_app,
    ),
    ComparisonRow(
      name: 'LongPressEndDetails',
      recogniser: 'LongPressGestureRecognizer',
      fields: <String>[
        'globalPosition',
        'localPosition',
        'velocity',
      ],
      tint: Color(0xFFAD1457),
      icon: Icons.timer,
    ),
  ];

  // -------------------------------------------------------------------------
  // Real-world usage patterns.
  // -------------------------------------------------------------------------
  final List<UsagePattern> usagePatterns = const <UsagePattern>[
    UsagePattern(
      title: 'Extend text selection with shift-drag',
      body:
          'On end, read keysPressedOnDown — if it contains LogicalKeyboard'
          'Key.shift, anchor the selection to the previous caret instead '
          'of replacing it.  consecutiveTapCount picks word vs character '
          'granularity.',
      tint: Color(0xFF1565C0),
      icon: Icons.text_fields,
    ),
    UsagePattern(
      title: 'Double-tap-and-drag to zoom-and-pan',
      body:
          'On a map / image viewer, branch on consecutiveTapCount == 2 '
          'to interpret vertical dy as zoom delta and horizontal dx as '
          'pan delta.  velocity drives the post-lift fling.',
      tint: Color(0xFF2E7D32),
      icon: Icons.zoom_in_map,
    ),
    UsagePattern(
      title: 'Reorder list items with long-press-then-drag',
      body:
          'Use the LongPress* variant for a hold-to-grab feel.  Shown for '
          'contrast: TapDragEndDetails fires on quick taps, '
          'LongPressEndDetails fires after the long-press timeout.',
      tint: Color(0xFFAD1457),
      icon: Icons.reorder,
    ),
  ];

  // -------------------------------------------------------------------------
  // Caveats list.
  // -------------------------------------------------------------------------
  final List<CaveatItem> caveats = const <CaveatItem>[
    CaveatItem(
      title: 'primaryVelocity is null on multi-axis recognisers',
      body:
          'TapAndPanGestureRecognizer reports null because pan is 2-D.  '
          'Only the horizontal / vertical variants populate '
          'primaryVelocity with the projected magnitude.',
      tint: Color(0xFFFB8C00),
      icon: Icons.warning_amber,
    ),
    CaveatItem(
      title: 'kind may be null',
      body:
          'Synthetic / replayed pointer events can omit a device kind.  '
          'Always null-check before branching on PointerDeviceKind '
          'values.',
      tint: Color(0xFFE53935),
      icon: Icons.help_outline,
    ),
    CaveatItem(
      title: 'keysPressedOnDown is the DOWN-state',
      body:
          'The set reflects which modifiers were held when the FIRST down '
          'event arrived, not at lift.  If the user releases shift mid-'
          'drag, this still contains shift.',
      tint: Color(0xFF6A1B9A),
      icon: Icons.history,
    ),
    CaveatItem(
      title: 'consecutiveTapCount resets on long pauses',
      body:
          'A pause longer than the platform double-tap interval resets '
          'the counter.  Don\'t rely on the field for long-running '
          'sequences — it is bounded by the recogniser\'s timer.',
      tint: Color(0xFF00897B),
      icon: Icons.timelapse,
    ),
  ];

  // -------------------------------------------------------------------------
  // Top-level Scaffold
  // -------------------------------------------------------------------------
  return Scaffold(
    backgroundColor: const Color(0xFFF1F4F9),
    appBar: AppBar(
      backgroundColor: const Color(0xFF263238),
      foregroundColor: Colors.white,
      elevation: 0,
      title: const Text('TapDragEndDetails — Deep Demo'),
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          buildHeroHeader(canonical),
          const SizedBox(height: 24),
          buildAnatomyDiagram(),
          const SizedBox(height: 24),
          buildFieldGrid(fields),
          const SizedBox(height: 24),
          buildVelocityPanel(velocitySamples),
          const SizedBox(height: 24),
          buildTapCountShowcase(tapCounts),
          const SizedBox(height: 24),
          buildModifierShowcase(modifiers),
          const SizedBox(height: 24),
          buildConstructorReadout(canonical, conceptualKeysPressedOnDown),
          const SizedBox(height: 24),
          buildComparisonPanel(comparisons),
          const SizedBox(height: 24),
          buildUsagePatterns(usagePatterns),
          const SizedBox(height: 24),
          buildCaveats(caveats),
          const SizedBox(height: 24),
          buildFooter(),
        ],
      ),
    ),
  );
}

// ===========================================================================
// SECTION 1 — Hero header
// ===========================================================================

Widget buildHeroHeader(TapDragEndDetails canonical) {
  return Container(
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[Color(0xFF1A237E), Color(0xFF0277BD), Color(0xFF00838F)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: const Color(0xFF1A237E).withValues(alpha: 0.35),
          offset: const Offset(0, 12),
          blurRadius: 28,
          spreadRadius: -4,
        ),
        BoxShadow(
          color: Colors.white.withValues(alpha: 0.18),
          offset: const Offset(0, -2),
          blurRadius: 4,
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(
                Icons.touch_app,
                color: Colors.white,
                size: 36,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'TapDragEndDetails',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.4,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'package:flutter/gestures.dart',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.85),
                      fontFamily: 'monospace',
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        const Text(
          'The end-phase payload of a tap-then-drag composite gesture.',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            height: 1.35,
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: <Widget>[
            buildHeroChip(
              'tapCount = ${canonical.consecutiveTapCount}',
              Icons.repeat,
            ),
            buildHeroChip(
              'v = ${canonical.velocity.pixelsPerSecond.dx.toStringAsFixed(0)},'
                  ' ${canonical.velocity.pixelsPerSecond.dy.toStringAsFixed(0)} px/s',
              Icons.speed,
            ),
            buildHeroChip(
              'primary = ${canonical.primaryVelocity?.toStringAsFixed(0)}',
              Icons.straighten,
            ),
            buildHeroChip(
              'shift held',
              Icons.keyboard,
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildHeroChip(String label, IconData icon) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.16),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.white.withValues(alpha: 0.30)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(icon, color: Colors.white, size: 14),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 2 — Anatomy: composite gesture lifecycle
// ===========================================================================

Widget buildAnatomyDiagram() {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: const Color(0xFFE0E4EA)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          offset: const Offset(0, 6),
          blurRadius: 18,
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          '2. Anatomy — composite gesture lifecycle',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 6),
        const Text(
          'Tap-then-drag is a composite — N taps, then drag start, drag '
          'updates, drag end.  TapDragEndDetails carries the *final* phase.',
          style: TextStyle(fontSize: 13, color: Color(0xFF455A64), height: 1.4),
        ),
        const SizedBox(height: 20),
        Row(
          children: <Widget>[
            buildPhasePill(
              label: 'down',
              note: 'TapDragDownDetails',
              tint: const Color(0xFF1565C0),
              icon: Icons.south,
            ),
            const Expanded(child: PhaseConnector()),
            buildPhasePill(
              label: 'tap-up x N',
              note: 'counted',
              tint: const Color(0xFF2E7D32),
              icon: Icons.north,
            ),
            const Expanded(child: PhaseConnector()),
            buildPhasePill(
              label: 'drag-update',
              note: 'TapDragUpdateDetails',
              tint: const Color(0xFFE65100),
              icon: Icons.swipe,
            ),
            const Expanded(child: PhaseConnector()),
            buildPhasePill(
              label: 'drag-end',
              note: 'TapDragEndDetails',
              tint: const Color(0xFFAD1457),
              icon: Icons.flag,
              highlight: true,
            ),
          ],
        ),
        const SizedBox(height: 18),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF4E5),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFFFCC80)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              Icon(Icons.info_outline, color: Color(0xFFEF6C00), size: 20),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'TapDragEndDetails fires once per gesture, when the user '
                  'lifts the pointer after the drag.  Velocity / position / '
                  'modifiers are captured here for fling and selection-end '
                  'logic.',
                  style: TextStyle(fontSize: 13, height: 1.45),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildPhasePill({
  required String label,
  required String note,
  required Color tint,
  required IconData icon,
  bool highlight = false,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
    decoration: BoxDecoration(
      color: highlight ? tint : tint.withValues(alpha: 0.10),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: tint, width: highlight ? 0 : 1.4),
      boxShadow: highlight
          ? <BoxShadow>[
              BoxShadow(
                color: tint.withValues(alpha: 0.40),
                blurRadius: 14,
                offset: const Offset(0, 4),
              ),
            ]
          : <BoxShadow>[],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(icon, color: highlight ? Colors.white : tint, size: 18),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w800,
            color: highlight ? Colors.white : tint,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          note,
          style: TextStyle(
            fontSize: 9.5,
            fontFamily: 'monospace',
            color: highlight
                ? Colors.white.withValues(alpha: 0.85)
                : tint.withValues(alpha: 0.85),
          ),
        ),
      ],
    ),
  );
}

class PhaseConnector extends StatelessWidget {
  const PhaseConnector({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 2,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            Colors.grey.withValues(alpha: 0.25),
            Colors.grey.withValues(alpha: 0.55),
            Colors.grey.withValues(alpha: 0.25),
          ],
        ),
      ),
    );
  }
}

// ===========================================================================
// SECTION 3 — Field-by-field grid
// ===========================================================================

Widget buildFieldGrid(List<FieldEntry> fields) {
  return Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: const Color(0xFFFAFCFF),
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: const Color(0xFFD8E0EA)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          '3. Fields',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 4),
        const Text(
          'Each field of TapDragEndDetails — type, sample value, summary.',
          style: TextStyle(fontSize: 13, color: Color(0xFF455A64)),
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: <Widget>[
            for (final FieldEntry entry in fields) buildFieldCard(entry),
          ],
        ),
      ],
    ),
  );
}

Widget buildFieldCard(FieldEntry entry) {
  return Container(
    width: 320,
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: entry.color.withValues(alpha: 0.45), width: 1.2),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: entry.color.withValues(alpha: 0.10),
          offset: const Offset(0, 4),
          blurRadius: 10,
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: entry.color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(entry.icon, color: entry.color, size: 18),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                entry.name,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: entry.color,
                  fontFamily: 'monospace',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: entry.color.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                entry.type,
                style: TextStyle(
                  fontSize: 11,
                  fontFamily: 'monospace',
                  color: entry.color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF1B1F23),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            entry.sample,
            style: const TextStyle(
              color: Color(0xFFB5E48C),
              fontFamily: 'monospace',
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          entry.summary,
          style: const TextStyle(
            fontSize: 12.5,
            height: 1.4,
            color: Color(0xFF37474F),
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 4 — Velocity vector visualisation
// ===========================================================================

Widget buildVelocityPanel(List<VelocitySample> samples) {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: const Color(0xFF0D1B2A),
      borderRadius: BorderRadius.circular(20),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: const Color(0xFF0D1B2A).withValues(alpha: 0.25),
          offset: const Offset(0, 10),
          blurRadius: 24,
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          '4. Velocity vectors',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Four sample velocities — pixels-per-second arrows in a 280x120 frame.',
          style: TextStyle(
            fontSize: 13,
            color: Colors.white.withValues(alpha: 0.78),
          ),
        ),
        const SizedBox(height: 18),
        Wrap(
          spacing: 14,
          runSpacing: 14,
          children: <Widget>[
            for (final VelocitySample s in samples) buildVelocityFrame(s),
          ],
        ),
      ],
    ),
  );
}

Widget buildVelocityFrame(VelocitySample sample) {
  // Scale the vector so it always fits inside the 280x120 box.  The
  // longest sample below is roughly 540 px/s along an axis; divide by
  // an appropriate factor so even that one fits.
  const double frameWidth = 280;
  const double frameHeight = 120;
  const double maxArm = 90;
  final double magnitude = sample.magnitude;
  final double scale = magnitude == 0 ? 0 : maxArm / magnitude;
  final double endX = sample.dx * scale;
  final double endY = sample.dy * scale;
  final double angleRadians = math.atan2(sample.dy, sample.dx);
  final double drawnLength = math.sqrt(endX * endX + endY * endY);

  return Container(
    width: frameWidth,
    decoration: BoxDecoration(
      color: const Color(0xFF1A2E45),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: sample.tint.withValues(alpha: 0.55)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 10, 12, 4),
          child: Text(
            sample.label,
            style: TextStyle(
              color: sample.tint,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(
          width: frameWidth,
          height: frameHeight,
          child: Stack(
            children: <Widget>[
              // Origin axes
              const Positioned.fill(child: AxisGrid()),
              // Origin dot at frame centre
              Positioned(
                left: frameWidth / 2 - 4,
                top: frameHeight / 2 - 4,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              // Arrow shaft + head, anchored at centre, rotated to angle.
              Positioned(
                left: frameWidth / 2,
                top: frameHeight / 2,
                child: Transform.rotate(
                  angle: angleRadians,
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        width: drawnLength,
                        height: 3,
                        decoration: BoxDecoration(
                          color: sample.tint,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      Icon(
                        Icons.play_arrow,
                        size: 18,
                        color: sample.tint,
                      ),
                    ],
                  ),
                ),
              ),
              // End-point glow
              Positioned(
                left: frameWidth / 2 + endX - 4,
                top: frameHeight / 2 + endY - 4,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: sample.tint,
                    shape: BoxShape.circle,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: sample.tint.withValues(alpha: 0.55),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 6, 12, 12),
          child: Wrap(
            spacing: 8,
            runSpacing: 6,
            children: <Widget>[
              buildVelocityChip(
                'magnitude ${magnitude.toStringAsFixed(0)} px/s',
                sample.tint,
              ),
              buildVelocityChip(
                'angle ${sample.angleDegrees.toStringAsFixed(0)}°',
                sample.tint,
              ),
              buildVelocityChip(
                'dx ${sample.dx.toStringAsFixed(0)}',
                sample.tint,
              ),
              buildVelocityChip(
                'dy ${sample.dy.toStringAsFixed(0)}',
                sample.tint,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildVelocityChip(String label, Color tint) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: tint.withValues(alpha: 0.18),
      border: Border.all(color: tint.withValues(alpha: 0.45)),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: tint,
        fontSize: 10.5,
        fontFamily: 'monospace',
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

class AxisGrid extends StatelessWidget {
  const AxisGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        // Horizontal axis
        const Positioned(
          left: 12,
          right: 12,
          top: 60 - 0.5,
          child: AxisLine(),
        ),
        // Vertical axis
        const Positioned(
          left: 140 - 0.5,
          top: 8,
          bottom: 8,
          child: AxisLineVertical(),
        ),
      ],
    );
  }
}

class AxisLine extends StatelessWidget {
  const AxisLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.18),
      ),
    );
  }
}

class AxisLineVertical extends StatelessWidget {
  const AxisLineVertical({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.18),
      ),
    );
  }
}

// ===========================================================================
// SECTION 5 — consecutiveTapCount showcase
// ===========================================================================

Widget buildTapCountShowcase(List<TapCountSample> samples) {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: const Color(0xFFE0E4EA)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          '5. consecutiveTapCount in action',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 4),
        const Text(
          'How many taps preceded the drag.  Visualised as a chevron strip.',
          style: TextStyle(fontSize: 13, color: Color(0xFF455A64)),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: <Widget>[
            for (final TapCountSample s in samples) buildTapCountCard(s),
          ],
        ),
      ],
    ),
  );
}

Widget buildTapCountCard(TapCountSample sample) {
  return Container(
    width: 240,
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: sample.tint.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: sample.tint.withValues(alpha: 0.40)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: sample.tint,
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: Text(
                '${sample.count}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                sample.title,
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                  color: sample.tint,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        buildTapStrip(sample.count, sample.tint),
        const SizedBox(height: 12),
        Text(
          sample.story,
          style: const TextStyle(fontSize: 12, height: 1.4),
        ),
      ],
    ),
  );
}

Widget buildTapStrip(int count, Color tint) {
  // A row of N filled circles representing taps, an arrow, then a swipe icon.
  final List<Widget> children = <Widget>[];
  for (int i = 0; i < count; i++) {
    children.add(
      Container(
        width: 14,
        height: 14,
        margin: const EdgeInsets.only(right: 6),
        decoration: BoxDecoration(
          color: tint,
          shape: BoxShape.circle,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: tint.withValues(alpha: 0.45),
              blurRadius: 4,
            ),
          ],
        ),
      ),
    );
  }
  children.add(
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Icon(Icons.arrow_forward, size: 16, color: tint),
    ),
  );
  children.add(
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: tint.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: tint.withValues(alpha: 0.45)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(Icons.swipe, size: 14, color: tint),
          const SizedBox(width: 4),
          Text(
            'drag',
            style: TextStyle(
              color: tint,
              fontSize: 10.5,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    ),
  );
  return Row(children: children);
}

// ===========================================================================
// SECTION 6 — keysPressedOnDown showcase
// ===========================================================================

Widget buildModifierShowcase(List<ModifierSample> samples) {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[Color(0xFFF3E5F5), Color(0xFFE8EAF6)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: const Color(0xFFD1C4E9)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          '6. keysPressedOnDown — modifier-aware behaviour',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 4),
        const Text(
          'The set of modifier keys held when the FIRST down event arrived.',
          style: TextStyle(fontSize: 13, color: Color(0xFF455A64)),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: <Widget>[
            for (final ModifierSample m in samples) buildModifierCard(m),
          ],
        ),
      ],
    ),
  );
}

Widget buildModifierCard(ModifierSample sample) {
  return Container(
    width: 280,
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: sample.tint.withValues(alpha: 0.50)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: sample.tint.withValues(alpha: 0.10),
          offset: const Offset(0, 4),
          blurRadius: 10,
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.keyboard, color: sample.tint, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                sample.label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: sample.tint,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        if (sample.keys.isEmpty)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: const Color(0xFFEEEEEE),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFBDBDBD)),
            ),
            child: const Text(
              '{}  (empty set)',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: Color(0xFF424242),
              ),
            ),
          )
        else
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: <Widget>[
              for (final String k in sample.keys) buildKeyCap(k, sample.tint),
            ],
          ),
        const SizedBox(height: 10),
        Text(
          sample.story,
          style: const TextStyle(fontSize: 12, height: 1.4),
        ),
      ],
    ),
  );
}

Widget buildKeyCap(String label, Color tint) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: tint,
      borderRadius: BorderRadius.circular(6),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: tint.withValues(alpha: 0.45),
          offset: const Offset(0, 2),
          blurRadius: 4,
        ),
      ],
    ),
    child: Text(
      label,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 11.5,
        fontWeight: FontWeight.w800,
        letterSpacing: 0.5,
        fontFamily: 'monospace',
      ),
    ),
  );
}

// ===========================================================================
// SECTION 7 — Constructor source + live readout
// ===========================================================================

Widget buildConstructorReadout(
  TapDragEndDetails canonical,
  Set<LogicalKeyboardKey> conceptualKeysPressedOnDown,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: const Color(0xFF111827),
          borderRadius: BorderRadius.circular(14),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.30),
              offset: const Offset(0, 6),
              blurRadius: 16,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.code, color: Color(0xFF60A5FA), size: 18),
                SizedBox(width: 8),
                Text(
                  '7. Constructor source',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              'final TapDragEndDetails details = TapDragEndDetails(\n'
              '  globalPosition:       const Offset(120, 80),\n'
              '  localPosition:        const Offset(100, 60),\n'
              '  velocity:             const Velocity(\n'
              '                          pixelsPerSecond: Offset(420, -50),\n'
              '                        ),\n'
              '  primaryVelocity:      420,\n'
              '  consecutiveTapCount:  2,\n'
              '  keysPressedOnDown:    const <LogicalKeyboardKey>{\n'
              '                          LogicalKeyboardKey.shift,\n'
              '                        },\n'
              ');',
              style: TextStyle(
                color: Color(0xFFD1FAE5),
                fontFamily: 'monospace',
                fontSize: 12.5,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFE0E4EA)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Live readout — actual field values from the constructed instance',
              style: TextStyle(
                fontSize: 13.5,
                fontWeight: FontWeight.w800,
                color: Color(0xFF263238),
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: <Widget>[
                buildReadoutCell(
                  'globalPosition',
                  '${canonical.globalPosition}',
                  const Color(0xFF1E88E5),
                ),
                buildReadoutCell(
                  'localPosition',
                  '${canonical.localPosition}',
                  const Color(0xFF43A047),
                ),
                buildReadoutCell(
                  'velocity.pixelsPerSecond',
                  '${canonical.velocity.pixelsPerSecond}',
                  const Color(0xFFE53935),
                ),
                buildReadoutCell(
                  'primaryVelocity',
                  '${canonical.primaryVelocity}',
                  const Color(0xFFFB8C00),
                ),
                buildReadoutCell(
                  'consecutiveTapCount',
                  '${canonical.consecutiveTapCount}',
                  const Color(0xFF8E24AA),
                ),
                buildReadoutCell(
                  'keysPressedOnDown (conceptual)',
                  '$conceptualKeysPressedOnDown',
                  const Color(0xFF00897B),
                ),
                buildReadoutCell(
                  'kind (conceptual)',
                  'PointerDeviceKind.mouse',
                  const Color(0xFF6D4C41),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

Widget buildReadoutCell(String label, String value, Color tint) {
  return Container(
    width: 320,
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: tint.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: tint.withValues(alpha: 0.40)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
            color: tint,
            fontFamily: 'monospace',
            fontSize: 11.5,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 12,
            color: Color(0xFF1F2937),
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 8 — Comparison panel: DragEnd vs TapDragEnd vs LongPressEnd
// ===========================================================================

Widget buildComparisonPanel(List<ComparisonRow> comparisons) {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: const Color(0xFFFFFBEA),
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: const Color(0xFFF3D77B)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          '8. Comparison — *EndDetails siblings',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 4),
        const Text(
          'How TapDragEndDetails differs from its drag and long-press cousins.',
          style: TextStyle(fontSize: 13, color: Color(0xFF6D4C41)),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: <Widget>[
            for (final ComparisonRow row in comparisons)
              buildComparisonCard(row),
          ],
        ),
      ],
    ),
  );
}

Widget buildComparisonCard(ComparisonRow row) {
  return Container(
    width: 290,
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: row.tint.withValues(alpha: 0.55), width: 1.4),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: row.tint.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(row.icon, color: row.tint, size: 18),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    row.name,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: row.tint,
                      fontFamily: 'monospace',
                    ),
                  ),
                  Text(
                    row.recogniser,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF607D8B),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const Divider(height: 18),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: <Widget>[
            for (final String f in row.fields)
              Tooltip(
                message: f,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: row.tint.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: row.tint.withValues(alpha: 0.35),
                    ),
                  ),
                  child: Text(
                    f,
                    style: TextStyle(
                      color: row.tint,
                      fontSize: 11.5,
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 9 — Real-world usage
// ===========================================================================

Widget buildUsagePatterns(List<UsagePattern> patterns) {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: const Color(0xFFE8F5E9),
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: const Color(0xFFA5D6A7)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          '9. Real-world usage',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 4),
        const Text(
          'Three concrete patterns that branch on TapDragEndDetails fields.',
          style: TextStyle(fontSize: 13, color: Color(0xFF2E7D32)),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: <Widget>[
            for (final UsagePattern p in patterns) buildUsageCard(p),
          ],
        ),
      ],
    ),
  );
}

Widget buildUsageCard(UsagePattern pattern) {
  return Container(
    width: 320,
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: pattern.tint.withValues(alpha: 0.50)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: pattern.tint.withValues(alpha: 0.10),
          offset: const Offset(0, 4),
          blurRadius: 10,
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: pattern.tint.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(pattern.icon, color: pattern.tint, size: 18),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                pattern.title,
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w800,
                  color: pattern.tint,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          pattern.body,
          style: const TextStyle(fontSize: 12.5, height: 1.45),
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 10 — Caveats
// ===========================================================================

Widget buildCaveats(List<CaveatItem> caveats) {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: const Color(0xFFFFEBEE),
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: const Color(0xFFFFCDD2)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          '10. Caveats',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 4),
        const Text(
          'Things to remember when consuming TapDragEndDetails in production.',
          style: TextStyle(fontSize: 13, color: Color(0xFFC62828)),
        ),
        const SizedBox(height: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            for (final CaveatItem c in caveats) ...<Widget>[
              buildCaveatCard(c),
              const SizedBox(height: 10),
            ],
          ],
        ),
      ],
    ),
  );
}

Widget buildCaveatCard(CaveatItem caveat) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: caveat.tint.withValues(alpha: 0.55)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: caveat.tint.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(caveat.icon, color: caveat.tint, size: 18),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                caveat.title,
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w800,
                  color: caveat.tint,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                caveat.body,
                style: const TextStyle(fontSize: 12.5, height: 1.45),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 11 — Footer takeaways
// ===========================================================================

Widget buildFooter() {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[Color(0xFF263238), Color(0xFF37474F)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.flag, color: Colors.white, size: 22),
            SizedBox(width: 10),
            Text(
              '11. Takeaways',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        SizedBox(height: 14),
        FooterBullet(
          icon: Icons.check_circle,
          text:
              'TapDragEndDetails is the END-PHASE payload — fires once, at '
              'pointer lift after a tap-then-drag composite gesture.',
        ),
        FooterBullet(
          icon: Icons.check_circle,
          text:
              'Use velocity / primaryVelocity for fling animations.  '
              'primaryVelocity is null on multi-axis pan recognisers.',
        ),
        FooterBullet(
          icon: Icons.check_circle,
          text:
              'Branch behaviour on consecutiveTapCount and keysPressedOnDown '
              'to express selection-extend, zoom-and-pan, and other '
              'modifier-aware gestures.',
        ),
        FooterBullet(
          icon: Icons.check_circle,
          text:
              'Always null-check kind — synthetic events may not carry a '
              'PointerDeviceKind.',
        ),
      ],
    ),
  );
}

class FooterBullet extends StatelessWidget {
  const FooterBullet({super.key, required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(icon, color: const Color(0xFF80CBC4), size: 16),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
