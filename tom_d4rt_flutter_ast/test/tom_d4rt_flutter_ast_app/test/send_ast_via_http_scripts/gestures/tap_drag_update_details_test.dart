// D4rt test script: Deep visual demonstration of TapDragUpdateDetails.
//
// TapDragUpdateDetails (package:flutter/gestures.dart) is the per-frame
// payload streamed from BaseTapAndDragGestureRecognizer.onDragUpdate while
// a composite tap-and-drag gesture is in flight.  Where its sibling
// TapDragEndDetails marks the moment of lift-off and carries velocity, this
// payload is fired *repeatedly* on every pointer move and carries motion
// deltas plus an accumulated origin-offset.
//
// SDK-verified constructor fields (Flutter 3.41.x):
//   - globalPosition         Offset, screen-space pointer position now.
//   - localPosition          Offset, local-space pointer position now.
//   - sourceTimeStamp        Duration?, optional engine-side timestamp.
//   - delta                  Offset, motion since the previous update.
//   - primaryDelta           double?, axis-projected delta on 1-D drags.
//   - kind                   PointerDeviceKind?, pointer kind, may be null.
//   - offsetFromOrigin       Offset, cumulative motion since drag start
//                            (global frame).
//   - localOffsetFromOrigin  Offset, cumulative motion since drag start
//                            (local frame).
//   - consecutiveTapCount    int, taps preceding the drag (1, 2, 3, ...).
//
// NOTE — fields the brief mentions that DO NOT exist on this SDK:
//   - localDelta             Not a field on TapDragUpdateDetails.  The
//                            "local-space" view of motion is derived by the
//                            framework from the same pointer event but is
//                            not carried separately on this payload.  The
//                            demo therefore treats it conceptually and
//                            renders the rotation example via
//                            localOffsetFromOrigin instead.
//   - keysPressedOnDown      Lives on TapDragEndDetails / the recogniser,
//                            NOT on TapDragUpdateDetails.  It is illustrated
//                            as a conceptual companion (the modifier set
//                            latches at down and is observable elsewhere).
//
// This deep demo is intentionally distinct from the TapDragEndDetails
// sibling: forest-green / emerald palette (no pink/magenta), wave-pattern
// accents on the field grid (no framed boxes), and section ordering that
// places phase-timeline second and the construction sample later.
//
// Sections:
//   1. Hero header (gradient forest-green → emerald)
//   2. Phase timeline (Down → TapUp(N) → DragUpdate frames → DragEnd)
//   3. Field grid (9 cards, wave-accent rounded-rect cards)
//   4. delta vs localDelta (4 panels + rotation panel)
//   5. offsetFromOrigin showcase (4 cards with trail dots)
//   6. consecutiveTapCount showcase (1..4)
//   7. keysPressedOnDown showcase (none, Shift, Ctrl+Shift, Alt+Cmd)
//   8. Construction sample (constructor + readout)
//   9. Comparison panel (Drag / TapDrag / LongPressMove)
//  10. Real-world usage cards
//  11. Caveats
//  12. Footer takeaways

import 'dart:math' as math;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ---------------------------------------------------------------------------
// Top-level value classes.  No leading underscores on locals; the helper
// classes use a regular CapitalCase name so they read naturally below.
// ---------------------------------------------------------------------------

class FieldEntry {
  const FieldEntry({
    required this.name,
    required this.type,
    required this.sample,
    required this.summary,
    required this.icon,
    required this.tint,
  });

  final String name;
  final String type;
  final String sample;
  final String summary;
  final IconData icon;
  final Color tint;
}

class DeltaSample {
  const DeltaSample({
    required this.label,
    required this.dx,
    required this.dy,
    required this.story,
    required this.tint,
  });

  final String label;
  final double dx;
  final double dy;
  final String story;
  final Color tint;

  double get magnitude => math.sqrt(dx * dx + dy * dy);
  double get angleDegrees => math.atan2(dy, dx) * 180.0 / math.pi;
}

class OriginSample {
  const OriginSample({
    required this.frame,
    required this.story,
    required this.totalDx,
    required this.totalDy,
    required this.trail,
    required this.tint,
  });

  final int frame;
  final String story;
  final double totalDx;
  final double totalDy;
  final List<Offset> trail;
  final Color tint;
}

class TapCountVignette {
  const TapCountVignette({
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

class ModifierVignette {
  const ModifierVignette({
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

class TimelinePhase {
  const TimelinePhase({
    required this.label,
    required this.subtitle,
    required this.tint,
    required this.icon,
    required this.highlight,
  });

  final String label;
  final String subtitle;
  final Color tint;
  final IconData icon;
  final bool highlight;
}

// ---------------------------------------------------------------------------
// build entry-point — single-file Flutter D4rt script.
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  // -------------------------------------------------------------------------
  // Forest-green / emerald palette.  Distinct from the End demo's
  // pink/magenta palette.  Reused by hero gradients, accent strips, and
  // section header backgrounds.
  // -------------------------------------------------------------------------
  const Color forestDeep = Color(0xFF1B5E20);
  const Color forestMid = Color(0xFF2E7D32);
  const Color emerald = Color(0xFF00897B);
  const Color emeraldLight = Color(0xFF26A69A);
  const Color limeAccent = Color(0xFF7CB342);
  const Color mossSurface = Color(0xFFE8F5E9);
  const Color barkInk = Color(0xFF1B3A1F);

  // -------------------------------------------------------------------------
  // Canonical sample TapDragUpdateDetails instance.  A double-tap-and-drag
  // recogniser, currently mid-flight, has fired this update at frame 5:
  //   * the pointer is at (240, 180) global, (200, 140) local
  //   * since the previous frame it has moved (+12, +4) — a fairly small
  //     forward drift
  //   * the cumulative motion since drag start is (+96, +32) global,
  //     (+80, +28) local — most of the drag has been horizontal
  //   * this is the second tap of a double-tap-and-drag (text-line select)
  // -------------------------------------------------------------------------
  final TapDragUpdateDetails canonical = TapDragUpdateDetails(
    globalPosition: const Offset(240, 180),
    localPosition: const Offset(200, 140),
    sourceTimeStamp: const Duration(milliseconds: 137),
    delta: const Offset(12, 4),
    primaryDelta: null,
    kind: PointerDeviceKind.touch,
    offsetFromOrigin: const Offset(96, 32),
    localOffsetFromOrigin: const Offset(80, 28),
    consecutiveTapCount: 2,
  );

  // The conceptual modifier set held at the original down event for the
  // canonical instance.  TapDragUpdateDetails does NOT carry this on
  // Flutter 3.41 — it is shown as a conceptual companion only.
  final Set<LogicalKeyboardKey> conceptualKeysPressedOnDown =
      <LogicalKeyboardKey>{LogicalKeyboardKey.shift};

  // -------------------------------------------------------------------------
  // Phase timeline (Section 2).  Down → TapUp(N) → DragUpdate frames →
  // DragEnd.  DragUpdate frames are highlighted with limeAccent.
  // -------------------------------------------------------------------------
  const List<TimelinePhase> timeline = <TimelinePhase>[
    TimelinePhase(
      label: 'Down',
      subtitle: 'pointer contacts',
      tint: forestDeep,
      icon: Icons.touch_app,
      highlight: false,
    ),
    TimelinePhase(
      label: 'TapUp×N',
      subtitle: 'N taps registered',
      tint: forestMid,
      icon: Icons.repeat,
      highlight: false,
    ),
    TimelinePhase(
      label: 'DragStart',
      subtitle: 'motion crosses slop',
      tint: emerald,
      icon: Icons.play_circle,
      highlight: false,
    ),
    TimelinePhase(
      label: 'DragUpdate ①',
      subtitle: 'first move frame',
      tint: limeAccent,
      icon: Icons.drag_indicator,
      highlight: true,
    ),
    TimelinePhase(
      label: 'DragUpdate ②',
      subtitle: 'second move frame',
      tint: limeAccent,
      icon: Icons.drag_indicator,
      highlight: true,
    ),
    TimelinePhase(
      label: 'DragUpdate …',
      subtitle: 'streamed every frame',
      tint: limeAccent,
      icon: Icons.drag_indicator,
      highlight: true,
    ),
    TimelinePhase(
      label: 'DragEnd',
      subtitle: 'pointer lifts',
      tint: emeraldLight,
      icon: Icons.flag,
      highlight: false,
    ),
  ];

  // -------------------------------------------------------------------------
  // Field grid (Section 3) — 9 cards, one per public constructor parameter.
  // -------------------------------------------------------------------------
  const List<FieldEntry> fields = <FieldEntry>[
    FieldEntry(
      name: 'globalPosition',
      type: 'Offset',
      sample: 'Offset(240.0, 180.0)',
      summary:
          'Pointer position right now in screen-space coordinates.  '
          'Useful for routing the gesture to overlays, popups, or other '
          'widgets above the receiving subtree.',
      icon: Icons.public,
      tint: Color(0xFF1B5E20),
    ),
    FieldEntry(
      name: 'localPosition',
      type: 'Offset',
      sample: 'Offset(200.0, 140.0)',
      summary:
          'Same pointer position but transformed into the receiving '
          'widget\'s local space.  This is what hit-test / item-index '
          'consumers should read.',
      icon: Icons.crop_free,
      tint: Color(0xFF2E7D32),
    ),
    FieldEntry(
      name: 'sourceTimeStamp',
      type: 'Duration?',
      sample: 'Duration(ms: 137)',
      summary:
          'Engine-side timestamp of the source pointer event.  Null for '
          'synthetic / accessibility-injected events.  Pair with previous '
          'updates to compute custom velocities.',
      icon: Icons.schedule,
      tint: Color(0xFF388E3C),
    ),
    FieldEntry(
      name: 'delta',
      type: 'Offset',
      sample: 'Offset(12.0, 4.0)',
      summary:
          'Motion since the PREVIOUS update.  In the receiving widget\'s '
          'event-coordinate space.  Defaults to Offset.zero on the very '
          'first update.',
      icon: Icons.trending_up,
      tint: Color(0xFF43A047),
    ),
    FieldEntry(
      name: 'primaryDelta',
      type: 'double?',
      sample: 'null  (pan)',
      summary:
          'Axis-projected delta exposed only by 1-D recognisers.  Null '
          'on TapAndPanGestureRecognizer because pan has two free axes.  '
          'Asserts must match delta when non-null.',
      icon: Icons.straighten,
      tint: Color(0xFF558B2F),
    ),
    FieldEntry(
      name: 'kind',
      type: 'PointerDeviceKind?',
      sample: 'PointerDeviceKind.touch',
      summary:
          'Pointer kind (touch, mouse, stylus, trackpad, …).  Nullable — '
          'may be null on synthetic / replayed events that never carried '
          'a real device kind.',
      icon: Icons.devices_other,
      tint: Color(0xFF00897B),
    ),
    FieldEntry(
      name: 'offsetFromOrigin',
      type: 'Offset',
      sample: 'Offset(96.0, 32.0)',
      summary:
          'Cumulative motion since the drag\'s anchor down event, in '
          'GLOBAL coordinates.  Resets per consecutive-tap series; tied '
          'to the most recent PointerDownEvent.',
      icon: Icons.timeline,
      tint: Color(0xFF26A69A),
    ),
    FieldEntry(
      name: 'localOffsetFromOrigin',
      type: 'Offset',
      sample: 'Offset(80.0, 28.0)',
      summary:
          'Same cumulative offset but in LOCAL coordinates.  Differs from '
          'the global value when the receiving widget is transformed '
          '(rotated, scaled, translated).',
      icon: Icons.center_focus_strong,
      tint: Color(0xFF7CB342),
    ),
    FieldEntry(
      name: 'consecutiveTapCount',
      type: 'int',
      sample: '2',
      summary:
          'How many quick taps preceded the drag.  1 = single-tap-and-drag, '
          '2 = double-tap-and-drag, etc.  Branches behaviour per tap '
          'count — character vs word vs line select.',
      icon: Icons.fingerprint,
      tint: Color(0xFFAFB42B),
    ),
  ];

  // -------------------------------------------------------------------------
  // delta vs localDelta panels (Section 4).  Four motion samples plus a
  // rotation-aware companion panel.
  // -------------------------------------------------------------------------
  const List<DeltaSample> deltaSamples = <DeltaSample>[
    DeltaSample(
      label: 'pure right',
      dx: 10,
      dy: 0,
      story:
          '+10 px on x, 0 on y.  Cleanly horizontal.  Likely a horizontal '
          'TapAndDrag — primaryDelta would be 10.',
      tint: forestDeep,
    ),
    DeltaSample(
      label: 'pure down',
      dx: 0,
      dy: 10,
      story:
          '0 on x, +10 px on y.  Cleanly vertical.  Vertical TapAndDrag '
          'would expose primaryDelta = 10 here.',
      tint: forestMid,
    ),
    DeltaSample(
      label: 'diagonal forward',
      dx: 8,
      dy: 8,
      story:
          'Equal dx and dy — pan-style two-axis motion.  primaryDelta is '
          'null on TapAndPanGestureRecognizer for this case.',
      tint: emerald,
    ),
    DeltaSample(
      label: 'back-and-up',
      dx: -12,
      dy: 4,
      story:
          'Negative dx, small +y.  Pointer is moving back toward the '
          'origin column while still drifting downward.',
      tint: limeAccent,
    ),
  ];

  // -------------------------------------------------------------------------
  // offsetFromOrigin progress samples (Section 5).  Four cards showing the
  // same drag at different cumulative offsets, with a trail of dots.
  // -------------------------------------------------------------------------
  const List<OriginSample> originSamples = <OriginSample>[
    OriginSample(
      frame: 1,
      story: 'Just past the slop threshold; first detectable drag motion.',
      totalDx: 12,
      totalDy: 4,
      trail: <Offset>[
        Offset(0, 0),
        Offset(12, 4),
      ],
      tint: forestDeep,
    ),
    OriginSample(
      frame: 5,
      story: 'A handful of frames in; horizontal lead emerging.',
      totalDx: 60,
      totalDy: 20,
      trail: <Offset>[
        Offset(0, 0),
        Offset(12, 4),
        Offset(24, 8),
        Offset(36, 12),
        Offset(48, 16),
        Offset(60, 20),
      ],
      tint: forestMid,
    ),
    OriginSample(
      frame: 12,
      story: 'Mid drag; pointer has covered a typical text-line span.',
      totalDx: 144,
      totalDy: 48,
      trail: <Offset>[
        Offset(0, 0),
        Offset(24, 6),
        Offset(48, 14),
        Offset(72, 22),
        Offset(96, 30),
        Offset(120, 40),
        Offset(144, 48),
      ],
      tint: emerald,
    ),
    OriginSample(
      frame: 22,
      story: 'Long drag; near edge — caller may auto-scroll or clamp.',
      totalDx: 264,
      totalDy: 88,
      trail: <Offset>[
        Offset(0, 0),
        Offset(40, 12),
        Offset(80, 24),
        Offset(120, 40),
        Offset(160, 56),
        Offset(200, 70),
        Offset(232, 80),
        Offset(264, 88),
      ],
      tint: limeAccent,
    ),
  ];

  // -------------------------------------------------------------------------
  // Tap-count vignettes (Section 6) — 1..4 taps before drag.
  // -------------------------------------------------------------------------
  const List<TapCountVignette> tapVignettes = <TapCountVignette>[
    TapCountVignette(
      count: 1,
      title: 'Single tap then drag',
      story:
          'One down/up pair followed by motion.  Standard cursor-place '
          'then drag-to-select-by-character behaviour.',
      tint: forestDeep,
    ),
    TapCountVignette(
      count: 2,
      title: 'Double tap then drag',
      story:
          'Two quick taps then motion.  Drag-to-select-by-word; updates '
          'extend selection by whole words as the pointer moves.',
      tint: forestMid,
    ),
    TapCountVignette(
      count: 3,
      title: 'Triple tap then drag',
      story:
          'Three taps then motion.  Drag-to-select-by-line; each frame '
          'extends selection by entire lines under the pointer.',
      tint: emerald,
    ),
    TapCountVignette(
      count: 4,
      title: 'Quadruple tap then drag',
      story:
          'Rare in stock widgets; some editors surface this as '
          'drag-to-select-by-paragraph.  Implementation choice.',
      tint: limeAccent,
    ),
  ];

  // -------------------------------------------------------------------------
  // Modifier vignettes (Section 7) — keysPressedOnDown is conceptual on
  // TapDragUpdateDetails (not a real field on this SDK), but knowing what
  // was held at down still drives per-frame behaviour.
  // -------------------------------------------------------------------------
  const List<ModifierVignette> modifierVignettes = <ModifierVignette>[
    ModifierVignette(
      label: 'No modifiers',
      keys: <String>[],
      story:
          'Plain drag.  Each update advances the cursor / moves the '
          'item by delta.',
      tint: forestDeep,
    ),
    ModifierVignette(
      label: 'Shift',
      keys: <String>['Shift'],
      story:
          'Shift latched at down means each update extends the selection '
          'anchor instead of replacing it.',
      tint: forestMid,
    ),
    ModifierVignette(
      label: 'Ctrl + Shift',
      keys: <String>['Ctrl', 'Shift'],
      story:
          'Shift extends, Ctrl widens granularity (word/line).  Each '
          'update re-evaluates both rules.',
      tint: emerald,
    ),
    ModifierVignette(
      label: 'Alt + Cmd',
      keys: <String>['Alt', 'Cmd'],
      story:
          'Block-select on macOS-style editors.  Each update redraws a '
          'rectangular selection from origin to current.',
      tint: limeAccent,
    ),
  ];

  // -------------------------------------------------------------------------
  // Comparison rows (Section 9) — three update-style payloads.
  // -------------------------------------------------------------------------
  const List<ComparisonRow> comparison = <ComparisonRow>[
    ComparisonRow(
      name: 'DragUpdateDetails',
      recogniser: 'PanGestureRecognizer / DragGestureRecognizer',
      fields: <String>[
        'globalPosition',
        'localPosition',
        'delta',
        'primaryDelta',
        'sourceTimeStamp',
      ],
      tint: forestDeep,
      icon: Icons.open_with,
    ),
    ComparisonRow(
      name: 'TapDragUpdateDetails',
      recogniser: 'BaseTapAndDragGestureRecognizer',
      fields: <String>[
        'globalPosition',
        'localPosition',
        'delta',
        'primaryDelta',
        'offsetFromOrigin',
        'localOffsetFromOrigin',
        'consecutiveTapCount',
        'sourceTimeStamp',
        'kind',
      ],
      tint: emerald,
      icon: Icons.drag_indicator,
    ),
    ComparisonRow(
      name: 'LongPressMoveUpdateDetails',
      recogniser: 'LongPressGestureRecognizer',
      fields: <String>[
        'globalPosition',
        'localPosition',
        'offsetFromOrigin',
        'localOffsetFromOrigin',
      ],
      tint: limeAccent,
      icon: Icons.touch_app,
    ),
  ];

  // -------------------------------------------------------------------------
  // Real-world usage cards (Section 10).
  // -------------------------------------------------------------------------
  const List<UsagePattern> usagePatterns = <UsagePattern>[
    UsagePattern(
      title: 'Per-frame transform application',
      body:
          'Apply details.delta directly to a Matrix4 or Offset state '
          'tracker each update.  Smoothest path for canvas-style drags '
          'where the user expects 1:1 motion mapping.',
      tint: forestDeep,
      icon: Icons.transform,
    ),
    UsagePattern(
      title: 'Draggable element with shift-snap',
      body:
          'Use details.offsetFromOrigin + the latched shift modifier to '
          'snap movement to the dominant axis.  Update tracks origin so '
          'the snap is stable across frames.',
      tint: emerald,
      icon: Icons.swap_horiz,
    ),
    UsagePattern(
      title: 'Picker rotation gesture',
      body:
          'Convert details.localOffsetFromOrigin into an angle around the '
          'picker centre per frame.  consecutiveTapCount can switch '
          'between coarse and fine rotation modes.',
      tint: limeAccent,
      icon: Icons.rotate_right,
    ),
  ];

  // -------------------------------------------------------------------------
  // Caveats (Section 11).
  // -------------------------------------------------------------------------
  const List<CaveatItem> caveats = <CaveatItem>[
    CaveatItem(
      title: 'kind is nullable',
      body:
          'Always null-check details.kind before branching on device '
          'type — synthetic and accessibility-injected events do not '
          'carry a real device kind.',
      tint: forestDeep,
      icon: Icons.help_outline,
    ),
    CaveatItem(
      title: 'delta vs offsetFromOrigin',
      body:
          'delta is per-frame motion; offsetFromOrigin is cumulative '
          'since drag start.  Mixing them up causes drift bugs (apply '
          'cumulative every frame and the element accelerates wildly).',
      tint: forestMid,
      icon: Icons.compare_arrows,
    ),
    CaveatItem(
      title: 'Frame-rate dependency',
      body:
          'Update frequency follows the engine\'s pointer-event rate, '
          'which usually matches the screen refresh.  Do not assume a '
          'fixed cadence; integrate with sourceTimeStamp when the maths '
          'depends on time.',
      tint: emerald,
      icon: Icons.speed,
    ),
    CaveatItem(
      title: 'keysPressedOnDown latches at down',
      body:
          'On payloads that DO carry keysPressedOnDown (TapDragEndDetails, '
          'TapDragStartDetails) the set is captured at the very first '
          'down event and never updated mid-drag.  Releasing Shift '
          'mid-drag will not change behaviour.',
      tint: limeAccent,
      icon: Icons.keyboard,
    ),
  ];

  // -------------------------------------------------------------------------
  // Layout helpers — small, const-friendly.  Each renders a self-contained
  // chunk of the page.  Composed inside the SingleChildScrollView at the
  // bottom of build().
  // -------------------------------------------------------------------------

  // 1. Hero header --------------------------------------------------------
  Widget heroHeader = Container(
    width: double.infinity,
    padding: const EdgeInsets.fromLTRB(28, 36, 28, 32),
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[forestDeep, forestMid, emerald, emeraldLight],
        stops: <double>[0.0, 0.45, 0.8, 1.0],
      ),
    ),
    child: const Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.drag_indicator,
          color: Colors.white,
          size: 64,
        ),
        SizedBox(width: 24),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'TapDragUpdateDetails',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.4,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Per-frame motion deltas + cumulative origin offset, '
                'streamed by BaseTapAndDragGestureRecognizer.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  height: 1.4,
                ),
              ),
              SizedBox(height: 12),
              Row(
                children: <Widget>[
                  Icon(Icons.bolt, color: Colors.white70, size: 16),
                  SizedBox(width: 6),
                  Text(
                    'forest-green / emerald palette',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // Section title helper -------------------------------------------------
  Widget sectionTitle(String index, String title, String subtitle) =>
      Padding(
        padding: const EdgeInsets.fromLTRB(24, 36, 24, 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: emerald.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: emerald.withValues(alpha: 0.4),
                  width: 1.5,
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                index,
                style: const TextStyle(
                  color: forestDeep,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    title,
                    style: const TextStyle(
                      color: barkInk,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: barkInk.withValues(alpha: 0.7),
                      fontSize: 13,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  // 2. Phase timeline ----------------------------------------------------
  List<Widget> timelineNodes = <Widget>[];
  for (int i = 0; i < timeline.length; i++) {
    final TimelinePhase phase = timeline[i];
    timelineNodes.add(
      Container(
        width: 132,
        padding: const EdgeInsets.fromLTRB(10, 14, 10, 12),
        decoration: BoxDecoration(
          color: phase.highlight
              ? phase.tint.withValues(alpha: 0.18)
              : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: phase.highlight
                ? phase.tint
                : phase.tint.withValues(alpha: 0.45),
            width: phase.highlight ? 2.0 : 1.2,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(phase.icon, color: phase.tint, size: 26),
            const SizedBox(height: 6),
            Text(
              phase.label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: phase.tint,
                fontSize: 13,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              phase.subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: barkInk.withValues(alpha: 0.7),
                fontSize: 11,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
    if (i != timeline.length - 1) {
      timelineNodes.add(
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 6),
          child: Icon(
            Icons.chevron_right,
            color: emerald,
            size: 22,
          ),
        ),
      );
    }
  }
  Widget timelineSection = Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: timelineNodes,
      ),
    ),
  );

  // Wave-pattern accent strip — used by the field grid and origin trail
  // cards to keep this demo visually distinct from the framed-box style of
  // the End demo.
  Widget waveStrip(Color tint) => SizedBox(
        height: 14,
        child: Row(
          children: <Widget>[
            for (int j = 0; j < 12; j++)
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 1),
                  decoration: BoxDecoration(
                    color: tint.withValues(alpha: j.isEven ? 0.55 : 0.18),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
          ],
        ),
      );

  // 3. Field grid --------------------------------------------------------
  List<Widget> fieldCards = <Widget>[];
  for (final FieldEntry entry in fields) {
    fieldCards.add(
      Container(
        width: 320,
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: entry.tint.withValues(alpha: 0.35),
            width: 1.4,
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: entry.tint.withValues(alpha: 0.08),
              blurRadius: 14,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: entry.tint.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: Icon(entry.icon, color: entry.tint, size: 22),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        entry.name,
                        style: const TextStyle(
                          color: barkInk,
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'monospace',
                        ),
                      ),
                      Text(
                        entry.type,
                        style: TextStyle(
                          color: entry.tint,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            waveStrip(entry.tint),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: mossSurface,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                entry.sample,
                style: const TextStyle(
                  color: forestDeep,
                  fontFamily: 'monospace',
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              entry.summary,
              style: TextStyle(
                color: barkInk.withValues(alpha: 0.78),
                fontSize: 12.5,
                height: 1.45,
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget fieldGridSection = Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24),
    child: Wrap(
      spacing: 16,
      runSpacing: 16,
      children: fieldCards,
    ),
  );

  // 4. delta vs localDelta panels ---------------------------------------
  Widget deltaCoordPanel(DeltaSample s) {
    // Render a small 120x120 coord plane with an arrow from centre.
    const double size = 120;
    const double half = size / 2;
    // Clamp the arrow to the panel.
    final double scale =
        s.magnitude == 0 ? 0 : math.min(half - 12, s.magnitude * 5) / s.magnitude;
    final double endX = half + s.dx * scale;
    final double endY = half + s.dy * scale;
    return Container(
      width: 280,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: s.tint.withValues(alpha: 0.4),
          width: 1.4,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            s.label,
            style: TextStyle(
              color: s.tint,
              fontSize: 14,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'delta = Offset(${s.dx.toStringAsFixed(0)}, '
            '${s.dy.toStringAsFixed(0)})',
            style: const TextStyle(
              color: barkInk,
              fontSize: 12,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Center(
            child: SizedBox(
              width: size,
              height: size,
              child: Stack(
                children: <Widget>[
                  // Coord-plane backdrop.
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        color: mossSurface,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: s.tint.withValues(alpha: 0.2),
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                  // Horizontal axis.
                  Positioned(
                    left: 6,
                    right: 6,
                    top: half - 0.5,
                    child: Container(
                      height: 1,
                      color: s.tint.withValues(alpha: 0.45),
                    ),
                  ),
                  // Vertical axis.
                  Positioned(
                    top: 6,
                    bottom: 6,
                    left: half - 0.5,
                    child: Container(
                      width: 1,
                      color: s.tint.withValues(alpha: 0.45),
                    ),
                  ),
                  // Origin dot.
                  Positioned(
                    left: half - 4,
                    top: half - 4,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: s.tint,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  // End dot.
                  Positioned(
                    left: endX - 5,
                    top: endY - 5,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: s.tint,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'magnitude ${s.magnitude.toStringAsFixed(2)} px · '
            'angle ${s.angleDegrees.toStringAsFixed(0)}°',
            style: TextStyle(
              color: barkInk.withValues(alpha: 0.7),
              fontSize: 11,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(height: 6),
          Text(
            s.story,
            style: TextStyle(
              color: barkInk.withValues(alpha: 0.78),
              fontSize: 12,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget rotationPanel = Container(
    width: 580,
    padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
    decoration: BoxDecoration(
      color: mossSurface,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: emerald.withValues(alpha: 0.5),
        width: 1.6,
      ),
    ),
    child: const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.rotate_right, color: emerald, size: 22),
            SizedBox(width: 8),
            Text(
              'localDelta — when the receiving widget is rotated',
              style: TextStyle(
                color: forestDeep,
                fontSize: 14,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Text(
          'TapDragUpdateDetails on this Flutter version does NOT carry a '
          'separate localDelta field — only delta (in receiver-event '
          'space) and the cumulative localOffsetFromOrigin / '
          'offsetFromOrigin pair.\n\n'
          'When the receiver is transformed (rotated, scaled), the per-'
          'frame motion vector you experience inside the widget IS '
          'already in receiver-event coordinates because the framework '
          'transforms incoming pointer events.  The cumulative offsets '
          'then split into a global view (offsetFromOrigin) and a local '
          'view (localOffsetFromOrigin), which is what you want when '
          'rendering hover-tracking overlays.',
          style: TextStyle(
            color: barkInk,
            fontSize: 12.5,
            height: 1.5,
          ),
        ),
      ],
    ),
  );

  Widget deltaSection = Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Wrap(
          spacing: 14,
          runSpacing: 14,
          children: <Widget>[
            for (final DeltaSample s in deltaSamples) deltaCoordPanel(s),
          ],
        ),
        const SizedBox(height: 18),
        rotationPanel,
      ],
    ),
  );

  // 5. offsetFromOrigin showcase ----------------------------------------
  Widget originCard(OriginSample sample) {
    // Render trail dots inside a 220x110 surface, scaled so the largest
    // sample's cumulative offset still fits.
    const double w = 220;
    const double h = 110;
    const double xMax = 280;
    const double yMax = 110;
    final List<Widget> dots = <Widget>[];
    for (int i = 0; i < sample.trail.length; i++) {
      final Offset o = sample.trail[i];
      final double cx = 12 + (o.dx / xMax) * (w - 24);
      final double cy = 12 + (o.dy / yMax) * (h - 24);
      final double size = i == sample.trail.length - 1 ? 12 : 7;
      dots.add(
        Positioned(
          left: cx - size / 2,
          top: cy - size / 2,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: i == sample.trail.length - 1
                  ? sample.tint
                  : sample.tint.withValues(alpha: 0.45),
              shape: BoxShape.circle,
              border: i == sample.trail.length - 1
                  ? Border.all(color: Colors.white, width: 2)
                  : null,
            ),
          ),
        ),
      );
    }
    return Container(
      width: 290,
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: sample.tint.withValues(alpha: 0.4),
          width: 1.4,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'frame ${sample.frame}',
                style: TextStyle(
                  color: sample.tint,
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'monospace',
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: sample.tint.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '+(${sample.totalDx.toStringAsFixed(0)}, '
                  '${sample.totalDy.toStringAsFixed(0)})',
                  style: const TextStyle(
                    color: forestDeep,
                    fontSize: 11,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          waveStrip(sample.tint),
          const SizedBox(height: 10),
          Container(
            width: w,
            height: h,
            decoration: BoxDecoration(
              color: mossSurface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: sample.tint.withValues(alpha: 0.18),
                width: 1,
              ),
            ),
            child: Stack(children: dots),
          ),
          const SizedBox(height: 8),
          Text(
            sample.story,
            style: TextStyle(
              color: barkInk.withValues(alpha: 0.78),
              fontSize: 12,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget originSection = Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24),
    child: Wrap(
      spacing: 14,
      runSpacing: 14,
      children: <Widget>[
        for (final OriginSample s in originSamples) originCard(s),
      ],
    ),
  );

  // 6. consecutiveTapCount showcase --------------------------------------
  Widget tapDot(Color tint) => Container(
        width: 18,
        height: 18,
        margin: const EdgeInsets.only(right: 6),
        decoration: BoxDecoration(
          color: tint,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2),
        ),
      );
  Widget tapVignetteCard(TapCountVignette v) {
    final List<Widget> dotRow = <Widget>[];
    for (int i = 0; i < v.count; i++) {
      dotRow.add(tapDot(v.tint));
    }
    return Container(
      width: 290,
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: v.tint.withValues(alpha: 0.4),
          width: 1.4,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: v.tint,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'consecutiveTapCount = ${v.count}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #32, P3):
          // The card is 290 wide (inner 258 after 16+16 padding). With
          // count=3 or 4 the inner dot Row (24 px per dot incl. margin)
          // plus the 22-px arrow Icon, the 4-px SizedBox and the
          // monospace "drag · update · update · …" pill summed to
          // ~268-292 px, overflowing the inner width by up to 16 px (the
          // count=3 case). Wrapped the trailing pill Container in
          // `Flexible` so it shrinks (and the text wraps within) when
          // the dot row grows; ASCII content is unchanged.
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(children: dotRow),
              const Icon(Icons.arrow_right_alt, color: emerald, size: 22),
              const SizedBox(width: 4),
              Flexible(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: v.tint.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: v.tint.withValues(alpha: 0.5),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    'drag · update · update · …',
                    style: TextStyle(
                      color: v.tint,
                      fontSize: 11,
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            v.title,
            style: const TextStyle(
              color: barkInk,
              fontSize: 14,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            v.story,
            style: TextStyle(
              color: barkInk.withValues(alpha: 0.78),
              fontSize: 12,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget tapCountSection = Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24),
    child: Wrap(
      spacing: 14,
      runSpacing: 14,
      children: <Widget>[
        for (final TapCountVignette v in tapVignettes) tapVignetteCard(v),
      ],
    ),
  );

  // 7. keysPressedOnDown showcase ---------------------------------------
  Widget keyCap(String label, Color tint) => Container(
        margin: const EdgeInsets.only(right: 6, top: 4, bottom: 4),
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: tint, width: 1.4),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: tint.withValues(alpha: 0.18),
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Text(
          label,
          style: TextStyle(
            color: tint,
            fontSize: 11,
            fontWeight: FontWeight.w800,
            fontFamily: 'monospace',
          ),
        ),
      );
  Widget modifierVignetteCard(ModifierVignette v) {
    final List<Widget> caps = <Widget>[];
    if (v.keys.isEmpty) {
      caps.add(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: v.tint.withValues(alpha: 0.16),
            borderRadius: BorderRadius.circular(6),
          ),
          child: const Text(
            '(no modifiers)',
            style: TextStyle(
              color: barkInk,
              fontSize: 11,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      );
    } else {
      for (final String k in v.keys) {
        caps.add(keyCap(k, v.tint));
      }
    }
    return Container(
      width: 290,
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: v.tint.withValues(alpha: 0.4),
          width: 1.4,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            v.label,
            style: TextStyle(
              color: v.tint,
              fontSize: 14,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(children: caps),
          const SizedBox(height: 10),
          Text(
            v.story,
            style: TextStyle(
              color: barkInk.withValues(alpha: 0.78),
              fontSize: 12,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget modifierSection = Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
          margin: const EdgeInsets.only(bottom: 14),
          decoration: BoxDecoration(
            color: emeraldLight.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: emeraldLight.withValues(alpha: 0.45),
              width: 1,
            ),
          ),
          child: const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(Icons.info_outline, color: forestDeep, size: 18),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'keysPressedOnDown is NOT a field on '
                  'TapDragUpdateDetails (it lives on TapDragEndDetails / '
                  'TapDragStartDetails).  Shown here as a conceptual '
                  'companion: the latched modifier set still drives '
                  'per-frame update behaviour.',
                  style: TextStyle(
                    color: barkInk,
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
        Wrap(
          spacing: 14,
          runSpacing: 14,
          children: <Widget>[
            for (final ModifierVignette v in modifierVignettes)
              modifierVignetteCard(v),
          ],
        ),
      ],
    ),
  );

  // 8. Construction sample ----------------------------------------------
  const String constructionSource = '''
final TapDragUpdateDetails details = TapDragUpdateDetails(
  globalPosition: Offset(240, 180),
  localPosition: Offset(200, 140),
  sourceTimeStamp: Duration(milliseconds: 137),
  delta: Offset(12, 4),
  primaryDelta: null,            // pan-style, no primary axis
  kind: PointerDeviceKind.touch,
  offsetFromOrigin: Offset(96, 32),
  localOffsetFromOrigin: Offset(80, 28),
  consecutiveTapCount: 2,
);
''';

  Widget readoutRow(String key, String value) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 200,
              child: Text(
                key,
                style: const TextStyle(
                  color: forestDeep,
                  fontSize: 12.5,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Expanded(
              child: Text(
                value,
                style: TextStyle(
                  color: barkInk.withValues(alpha: 0.85),
                  fontSize: 12.5,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ],
        ),
      );

  final String keysReadout = conceptualKeysPressedOnDown
      .map((LogicalKeyboardKey k) => k.debugName ?? '${k.keyId}')
      .join(', ');

  Widget constructionSection = Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
          decoration: BoxDecoration(
            color: barkInk,
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Text(
            constructionSource,
            style: TextStyle(
              color: Color(0xFFC8E6C9),
              fontFamily: 'monospace',
              fontSize: 12.5,
              height: 1.55,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: emerald.withValues(alpha: 0.45),
              width: 1.4,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                'Live readout — actual instance fields',
                style: TextStyle(
                  color: forestDeep,
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 10),
              readoutRow('runtimeType',
                  canonical.runtimeType.toString()),
              readoutRow(
                  'globalPosition', canonical.globalPosition.toString()),
              readoutRow(
                  'localPosition', canonical.localPosition.toString()),
              readoutRow('sourceTimeStamp',
                  canonical.sourceTimeStamp?.toString() ?? 'null'),
              readoutRow('delta', canonical.delta.toString()),
              readoutRow('primaryDelta',
                  canonical.primaryDelta?.toString() ?? 'null'),
              readoutRow('kind', canonical.kind?.toString() ?? 'null'),
              readoutRow('offsetFromOrigin',
                  canonical.offsetFromOrigin.toString()),
              readoutRow('localOffsetFromOrigin',
                  canonical.localOffsetFromOrigin.toString()),
              readoutRow('consecutiveTapCount',
                  canonical.consecutiveTapCount.toString()),
              readoutRow('(conceptual) keysPressedOnDown',
                  '{$keysReadout}'),
            ],
          ),
        ),
      ],
    ),
  );

  // 9. Comparison panel --------------------------------------------------
  Widget comparisonCard(ComparisonRow row) {
    return Container(
      width: 320,
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: row.tint.withValues(alpha: 0.45),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(row.icon, color: row.tint, size: 22),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  row.name,
                  style: TextStyle(
                    color: row.tint,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            row.recogniser,
            style: TextStyle(
              color: barkInk.withValues(alpha: 0.7),
              fontSize: 11.5,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 10),
          waveStrip(row.tint),
          const SizedBox(height: 10),
          for (final String f in row.fields)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 1.5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.fiber_manual_record,
                    color: row.tint,
                    size: 9,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      f,
                      style: const TextStyle(
                        color: barkInk,
                        fontSize: 12,
                        fontFamily: 'monospace',
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

  Widget comparisonSection = Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24),
    child: Wrap(
      spacing: 16,
      runSpacing: 16,
      children: <Widget>[
        for (final ComparisonRow r in comparison) comparisonCard(r),
      ],
    ),
  );

  // 10. Real-world usage cards ------------------------------------------
  Widget usageCard(UsagePattern p) => Container(
        width: 320,
        padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
        decoration: BoxDecoration(
          color: p.tint.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: p.tint.withValues(alpha: 0.45),
            width: 1.4,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: p.tint.withValues(alpha: 0.16),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: Icon(p.icon, color: p.tint, size: 22),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    p.title,
                    style: const TextStyle(
                      color: barkInk,
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              p.body,
              style: TextStyle(
                color: barkInk.withValues(alpha: 0.82),
                fontSize: 12.5,
                height: 1.5,
              ),
            ),
          ],
        ),
      );

  Widget usageSection = Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24),
    child: Wrap(
      spacing: 16,
      runSpacing: 16,
      children: <Widget>[
        for (final UsagePattern p in usagePatterns) usageCard(p),
      ],
    ),
  );

  // 11. Caveats ----------------------------------------------------------
  Widget caveatCard(CaveatItem c) => Container(
        width: 320,
        padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: c.tint.withValues(alpha: 0.45),
            width: 1.4,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(c.icon, color: c.tint, size: 22),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    c.title,
                    style: TextStyle(
                      color: c.tint,
                      fontSize: 13.5,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            waveStrip(c.tint),
            const SizedBox(height: 8),
            Text(
              c.body,
              style: TextStyle(
                color: barkInk.withValues(alpha: 0.82),
                fontSize: 12,
                height: 1.45,
              ),
            ),
          ],
        ),
      );

  Widget caveatSection = Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24),
    child: Wrap(
      spacing: 16,
      runSpacing: 16,
      children: <Widget>[
        for (final CaveatItem c in caveats) caveatCard(c),
      ],
    ),
  );

  // 12. Footer takeaways -------------------------------------------------
  Widget footer = Container(
    width: double.infinity,
    margin: const EdgeInsets.fromLTRB(0, 36, 0, 0),
    padding: const EdgeInsets.fromLTRB(28, 28, 28, 32),
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[emerald, forestMid, forestDeep],
      ),
    ),
    child: const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.eco, color: Colors.white, size: 26),
            SizedBox(width: 10),
            Text(
              'Takeaways',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        SizedBox(height: 14),
        Text(
          '• delta is per-frame; offsetFromOrigin is cumulative since the '
          'drag\'s anchor down event.\n'
          '• primaryDelta is non-null only on 1-D recognisers; null on '
          'TapAndPanGestureRecognizer.\n'
          '• consecutiveTapCount lets a single recogniser drive '
          'character / word / line behaviours.\n'
          '• keysPressedOnDown is NOT on this payload — it lives on '
          'TapDragEndDetails / TapDragStartDetails.  Latched at down.\n'
          '• kind may be null on synthetic events; null-check before '
          'branching on device type.\n'
          '• Update frequency follows the engine\'s pointer-event rate; '
          'integrate with sourceTimeStamp when the maths needs time.',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            height: 1.6,
          ),
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // Final scaffold.  Sections composed top-to-bottom into a single
  // SingleChildScrollView.
  // -------------------------------------------------------------------------
  return Scaffold(
    backgroundColor: const Color(0xFFF1F8E9),
    body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          heroHeader,
          sectionTitle(
            '02',
            'Phase timeline',
            'Down → TapUp(N) → DragUpdate frames (highlighted) → DragEnd. '
                'TapDragUpdateDetails is the payload streamed during the '
                'highlighted frames.',
          ),
          timelineSection,
          sectionTitle(
            '03',
            'Field grid',
            'Nine cards — one per public constructor parameter — with '
                'wave-pattern accents.',
          ),
          fieldGridSection,
          sectionTitle(
            '04',
            'delta vs localDelta',
            'Per-frame motion sampled four ways, plus the rotated-receiver '
                'companion panel.',
          ),
          deltaSection,
          sectionTitle(
            '05',
            'offsetFromOrigin showcase',
            'The same drag visited at four progress points; trail dots show '
                'cumulative motion since drag start.',
          ),
          originSection,
          sectionTitle(
            '06',
            'consecutiveTapCount showcase',
            'One, two, three, four taps before the drag — branches '
                'character / word / line / paragraph behaviours.',
          ),
          tapCountSection,
          sectionTitle(
            '07',
            'keysPressedOnDown showcase',
            'Modifier scenarios that drive update behaviour — conceptual '
                'on this payload.',
          ),
          modifierSection,
          sectionTitle(
            '08',
            'Construction sample',
            'Constructor literal plus a live readout of the canonical '
                'instance fields.',
          ),
          constructionSection,
          sectionTitle(
            '09',
            'Comparison panel',
            'How this payload relates to its update-style siblings.',
          ),
          comparisonSection,
          sectionTitle(
            '10',
            'Real-world usage',
            'Three patterns taken straight from production code paths.',
          ),
          usageSection,
          sectionTitle(
            '11',
            'Caveats',
            'Things to know before relying on this payload in production.',
          ),
          caveatSection,
          footer,
        ],
      ),
    ),
  );
}
