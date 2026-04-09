// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

/// PanAxis — Deep Demonstration
///
/// Palette: Violet / Orchid (purple-pink spectrum)
/// Primary:   Color(0xFF7B1FA2) — Purple 700
/// Secondary: Color(0xFF9C27B0) — Purple 500
/// Accent:    Color(0xFFCE93D8) — Purple 200
/// Surface:   Color(0xFFF3E5F5) — Purple 50
/// Deep:      Color(0xFF4A148C) — Purple 900
/// Muted:     Color(0xFFE1BEE7) — Purple 100
/// Warm:      Color(0xFFAB47BC) — Purple 400
/// Highlight: Color(0xFFBA68C8) — Purple 300
/// Light:     Color(0xFFF8EAF6) — Purple 50+ (custom)
/// Dark:      Color(0xFF6A1B9A) — Purple 800

dynamic build(BuildContext context) {
  // ─── Section 1: Title Banner ───
  print('');
  print('████████████████████████████████████████████████████████████');
  print('██                                                      ██');
  print('██   PanAxis — Complete Deep Dive                        ██');
  print('██   Constraint enum for InteractiveViewer panning       ██');
  print('██                                                      ██');
  print('████████████████████████████████████████████████████████████');
  print('');

  const purple700 = Color(0xFF7B1FA2);
  const purple500 = Color(0xFF9C27B0);
  const purple200 = Color(0xFFCE93D8);
  const purple50 = Color(0xFFF3E5F5);
  const purple900 = Color(0xFF4A148C);
  const purple100 = Color(0xFFE1BEE7);
  const purple400 = Color(0xFFAB47BC);
  const purple300 = Color(0xFFBA68C8);
  const purpleLight = Color(0xFFF8EAF6);
  const purple800 = Color(0xFF6A1B9A);

  // ─── Section 2: What Is PanAxis? ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 2: What Is PanAxis?');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  PanAxis is an enum that controls which directions the');
  print('  user can pan (drag) content inside an InteractiveViewer');
  print('  widget. It constrains the axis of movement.');
  print('');
  print('  ┌─────────────────────────────────────────────────────┐');
  print('  │  Purpose: Limit pan gestures to specific axes or   │');
  print('  │  allow them freely. This is essential for UI        │');
  print('  │  patterns where uncontrolled panning would be       │');
  print('  │  confusing (e.g. a horizontal-only image strip).    │');
  print('  │                                                     │');
  print('  │  Location: widgets/interactive_viewer.dart          │');
  print('  │  Used by: InteractiveViewer.panAxis property        │');
  print('  └─────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 3: Enum Values ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 3: Enum Values');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  PanAxis has exactly four values:');
  print('');
  print('  ┌──────────────┬──────────────────────────────────────┐');
  print('  │  Value        │  Behavior                           │');
  print('  ├──────────────┼──────────────────────────────────────┤');
  print('  │  horizontal   │  Pan only along the X axis          │');
  print('  │              │  Vertical drag is ignored            │');
  print('  ├──────────────┼──────────────────────────────────────┤');
  print('  │  vertical     │  Pan only along the Y axis          │');
  print('  │              │  Horizontal drag is ignored          │');
  print('  ├──────────────┼──────────────────────────────────────┤');
  print('  │  aligned      │  Locks to the DOMINANT axis of      │');
  print('  │              │  initial drag direction. Once the    │');
  print('  │              │  user starts moving mostly-X or      │');
  print('  │              │  mostly-Y, it locks to that axis     │');
  print('  │              │  for the rest of the gesture.        │');
  print('  ├──────────────┼──────────────────────────────────────┤');
  print('  │  free         │  No constraint. Pan in any          │');
  print('  │              │  direction simultaneously.           │');
  print('  │              │  (This is the DEFAULT)               │');
  print('  └──────────────┴──────────────────────────────────────┘');
  print('');

  // Demonstrate enum properties
  print('  Enum properties:');
  print('  ┌──────────────────────────────────────────────────────┐');
  for (final axis in PanAxis.values) {
    print('  │  PanAxis.${axis.name.padRight(12)} index=${axis.index}');
  }
  print('  │  PanAxis.values.length = ${PanAxis.values.length}');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 4: Axis Constraint Diagrams ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 4: Axis Constraint Diagrams');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  PanAxis.horizontal:');
  print('  ┌──────────────────────────────────────────┐');
  print('  │                                          │');
  print('  │    ←═══════ ● ═══════→                   │');
  print('  │         (pan allowed)                     │');
  print('  │              ↕ blocked                    │');
  print('  │                                          │');
  print('  └──────────────────────────────────────────┘');
  print('');
  print('  PanAxis.vertical:');
  print('  ┌──────────────────────────────────────────┐');
  print('  │              ↑                            │');
  print('  │              ║                            │');
  print('  │    ← blocked ● blocked →                  │');
  print('  │              ║                            │');
  print('  │              ↓  (pan allowed)             │');
  print('  └──────────────────────────────────────────┘');
  print('');
  print('  PanAxis.aligned:');
  print('  ┌──────────────────────────────────────────┐');
  print('  │              ↑                            │');
  print('  │              ║                            │');
  print('  │    ←═════════●═════════→                  │');
  print('  │              ║                            │');
  print('  │              ↓                            │');
  print('  │                                          │');
  print('  │  Locks to ONE axis based on initial drag  │');
  print('  │  direction (whichever delta is larger)    │');
  print('  └──────────────────────────────────────────┘');
  print('');
  print('  PanAxis.free:');
  print('  ┌──────────────────────────────────────────┐');
  print('  │    ↖   ↑   ↗                             │');
  print('  │      ╲ ║ ╱                               │');
  print('  │    ←══ ● ══→                             │');
  print('  │      ╱ ║ ╲                               │');
  print('  │    ↙   ↓   ↘                             │');
  print('  │                                          │');
  print('  │  Pan in any direction (default behavior)  │');
  print('  └──────────────────────────────────────────┘');
  print('');

  // ─── Section 5: Aligned Mode Deep Dive ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 5: Aligned Mode Deep Dive');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  PanAxis.aligned is the most nuanced value. It allows');
  print('  panning in both directions but locks to the dominant');
  print('  axis once the gesture is recognized.');
  print('');
  print('  How it works internally:');
  print('  ┌──────────────────────────────────────────────────┐');
  print('  │  1. User starts dragging                         │');
  print('  │  2. Framework accumulates dx and dy deltas       │');
  print('  │  3. When |dx| > |dy| → lock to horizontal       │');
  print('  │     When |dy| > |dx| → lock to vertical         │');
  print('  │  4. For rest of gesture, perpendicular axis      │');
  print('  │     delta is zeroed out                          │');
  print('  │  5. Next gesture starts fresh (no memory)        │');
  print('  └──────────────────────────────────────────────────┘');
  print('');
  print('  Use cases for aligned:');
  print('  ┌──────────────────────────────────────────────────┐');
  print('  │  • Map viewers: pan along roads/rivers naturally  │');
  print('  │  • Spreadsheet grids: scroll row or column        │');
  print('  │  • Blueprint viewers: align to grid lines         │');
  print('  │  • Precision work: prevent diagonal drift         │');
  print('  └──────────────────────────────────────────────────┘');
  print('');
  print('  Comparison: aligned vs free for diagonal gestures:');
  print('  ┌──────────────────────────────────────────────────┐');
  print('  │  Gesture: user drags ↗ (45°)                     │');
  print('  │                                                   │');
  print('  │  free:    content moves ↗  (diagonal)             │');
  print('  │  aligned: content moves →  or ↑  (locked axis)   │');
  print('  │           depending on which was initially larger │');
  print('  └──────────────────────────────────────────────────┘');
  print('');

  // ─── Section 6: InteractiveViewer Integration ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 6: InteractiveViewer Integration');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  PanAxis is used exclusively by InteractiveViewer:');
  print('');
  print('  ┌──────────────────────────────────────────────────┐');
  print('  │  InteractiveViewer(                               │');
  print('  │    panAxis: PanAxis.horizontal,  // ← here        │');
  print('  │    boundaryMargin: EdgeInsets.all(20),            │');
  print('  │    minScale: 0.5,                                 │');
  print('  │    maxScale: 4.0,                                 │');
  print('  │    child: Image.network("..."),                   │');
  print('  │  )                                                │');
  print('  └──────────────────────────────────────────────────┘');
  print('');
  print('  InteractiveViewer properties that interact with PanAxis:');
  print('');
  print('  ┌────────────────────┬──────────────────────────────┐');
  print('  │  Property           │  Relationship               │');
  print('  ├────────────────────┼──────────────────────────────┤');
  print('  │  panEnabled          │ Must be true for panAxis   │');
  print('  │                     │ to have any effect          │');
  print('  ├────────────────────┼──────────────────────────────┤');
  print('  │  boundaryMargin     │ Constrains pan extent       │');
  print('  │                     │ in allowed directions       │');
  print('  ├────────────────────┼──────────────────────────────┤');
  print('  │  constrained        │ If false, child can be      │');
  print('  │                     │ panned outside viewport     │');
  print('  ├────────────────────┼──────────────────────────────┤');
  print('  │  scaleEnabled       │ Independent of panAxis      │');
  print('  │                     │ (zoom still works normally) │');
  print('  ├────────────────────┼──────────────────────────────┤');
  print('  │  transformationCtrl │ Reflects constrained pan    │');
  print('  │                     │ in its matrix translation   │');
  print('  └────────────────────┴──────────────────────────────┘');
  print('');
  print('  Important: panAxis only affects pan gestures.');
  print('  Pinch-to-zoom scaling is NOT affected by panAxis.');
  print('  Even with PanAxis.horizontal, the user can zoom');
  print('  in all directions.');
  print('');

  // ─── Section 7: Transformation Matrix Effects ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 7: Transformation Matrix Effects');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  InteractiveViewer uses a Matrix4 transformation.');
  print('  PanAxis modifies which translation components are');
  print('  allowed to change:');
  print('');
  print('  ┌──────────────────────────────────────────────────┐');
  print('  │  Matrix4 translation components:                  │');
  print('  │                                                   │');
  print('  │  ┌──────────────────┬──────────┬──────────┐       │');
  print('  │  │  PanAxis         │  tx (X)  │  ty (Y)  │       │');
  print('  │  ├──────────────────┼──────────┼──────────┤       │');
  print('  │  │  horizontal      │  changes │  fixed   │       │');
  print('  │  │  vertical        │  fixed   │  changes │       │');
  print('  │  │  aligned         │  one     │  changes │       │');
  print('  │  │  free            │  changes │  changes │       │');
  print('  │  └──────────────────┴──────────┴──────────┘       │');
  print('  │                                                   │');
  print('  │  Scale (sx, sy) is always allowed to change.      │');
  print('  └──────────────────────────────────────────────────┘');
  print('');
  print('  When using TransformationController, the matrix');
  print('  reflects the constrained translation. You can read');
  print('  the pan offset with:');
  print('');
  print('  ┌──────────────────────────────────────────────────┐');
  print('  │  final offset = Offset(                           │');
  print('  │    controller.value.getTranslation().x,           │');
  print('  │    controller.value.getTranslation().y,           │');
  print('  │  );                                               │');
  print('  └──────────────────────────────────────────────────┘');
  print('');

  // ─── Section 8: Practical Use Cases ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 8: Practical Use Cases');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  PanAxis.horizontal:');
  print('  ┌──────────────────────────────────────────────────┐');
  print('  │  • Horizontal image gallery / filmstrip           │');
  print('  │  • Timeline viewer (events along X axis)          │');
  print('  │  • Wide table that scrolls only sideways          │');
  print('  │  • Score/sheet music viewer                       │');
  print('  │  • Gantt chart viewer                             │');
  print('  └──────────────────────────────────────────────────┘');
  print('');
  print('  PanAxis.vertical:');
  print('  ┌──────────────────────────────────────────────────┐');
  print('  │  • Tall document viewer (legal contract)          │');
  print('  │  • Vertical timeline / changelog                  │');
  print('  │  • Tall infographic                               │');
  print('  │  • Chat transcript with zoom                      │');
  print('  └──────────────────────────────────────────────────┘');
  print('');
  print('  PanAxis.aligned:');
  print('  ┌──────────────────────────────────────────────────┐');
  print('  │  • Spreadsheet (precise row/column scrolling)     │');
  print('  │  • Grid-based editors                             │');
  print('  │  • CAD / diagram viewers                          │');
  print('  │  • Floor plan navigation                          │');
  print('  └──────────────────────────────────────────────────┘');
  print('');
  print('  PanAxis.free:');
  print('  ┌──────────────────────────────────────────────────┐');
  print('  │  • Photo viewer (pinch and pan)                   │');
  print('  │  • Map viewer (Google Maps-like)                  │');
  print('  │  • Canvas / whiteboard                            │');
  print('  │  • Large diagram exploration                      │');
  print('  └──────────────────────────────────────────────────┘');
  print('');

  // ─── Section 9: PanAxis with Boundary ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 9: PanAxis with Boundary Constraints');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  PanAxis and boundaryMargin work together to define');
  print('  the reachable area:');
  print('');
  print('  ┌──────────────────────────────────────────────────┐');
  print('  │  PanAxis.horizontal + boundaryMargin:             │');
  print('  │                                                   │');
  print('  │  ┌─────────────────────────────────────────┐      │');
  print('  │  │    margin │  viewport  │ margin          │      │');
  print('  │  │    ←──────│───content──│──────→          │      │');
  print('  │  │           │            │                │      │');
  print('  │  └─────────────────────────────────────────┘      │');
  print('  │                                                   │');
  print('  │  Only left/right margins matter (vertical ignored)│');
  print('  └──────────────────────────────────────────────────┘');
  print('');
  print('  ┌──────────────────────────────────────────────────┐');
  print('  │  PanAxis.free + EdgeInsets.all(double.infinity):  │');
  print('  │                                                   │');
  print('  │  Creates an infinite canvas — content can be      │');
  print('  │  panned in all directions without bounds.         │');
  print('  │                                                   │');
  print('  │  Useful for: whiteboards, node editors, unlimited │');
  print('  │  canvas tools.                                    │');
  print('  └──────────────────────────────────────────────────┘');
  print('');

  // ─── Section 10: Default Behavior ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 10: Default Behavior');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  When you create an InteractiveViewer without setting');
  print('  panAxis, the default is PanAxis.free:');
  print('');
  print('  ┌──────────────────────────────────────────────────┐');
  print('  │  InteractiveViewer(                               │');
  print('  │    child: myWidget,  // panAxis defaults to free  │');
  print('  │  )                                                │');
  print('  │                                                   │');
  print('  │  IS EQUIVALENT TO:                                │');
  print('  │                                                   │');
  print('  │  InteractiveViewer(                               │');
  print('  │    panAxis: PanAxis.free,                         │');
  print('  │    child: myWidget,                               │');
  print('  │  )                                                │');
  print('  └──────────────────────────────────────────────────┘');
  print('');
  print('  This means most InteractiveViewers allow unrestricted');
  print('  panning out of the box. You only need to set panAxis');
  print('  when you want to restrict movement.');
  print('');

  // ─── Section 11: Interaction with panEnabled ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 11: Interaction with panEnabled');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  panEnabled and panAxis are separate controls:');
  print('');
  print('  ┌──────────────────────────────────────────────────┐');
  print('  │  panEnabled = true, panAxis = free                │');
  print('  │    → Full panning in all directions               │');
  print('  │                                                   │');
  print('  │  panEnabled = true, panAxis = horizontal          │');
  print('  │    → Only horizontal panning                      │');
  print('  │                                                   │');
  print('  │  panEnabled = false, panAxis = anything           │');
  print('  │    → No panning at all (panAxis ignored)          │');
  print('  │                                                   │');
  print('  │  panEnabled = false, scaleEnabled = true          │');
  print('  │    → Zoom works but no panning                    │');
  print('  └──────────────────────────────────────────────────┘');
  print('');
  print('  This allows flexible combinations:');
  print('  • Zoom-only mode: panEnabled=false, scaleEnabled=true');
  print('  • View-only mode: panEnabled=false, scaleEnabled=false');
  print('  • Horizontal strip: panEnabled=true, panAxis=horizontal');
  print('');

  // ─── Section 12: Comparison with Other Scrolling Approaches ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 12: PanAxis vs Other Scrolling Approaches');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌─────────────────────┬──────────────────────────────┐');
  print('  │  Approach            │  When to Use                │');
  print('  ├─────────────────────┼──────────────────────────────┤');
  print('  │  ListView            │ Lazy list, single axis      │');
  print('  │  (Axis.vertical)    │ (no zoom, no pan)            │');
  print('  ├─────────────────────┼──────────────────────────────┤');
  print('  │  SingleChildScroll   │ Simple scroll, single axis  │');
  print('  │  (Axis.horizontal)  │ (no zoom, no pan)            │');
  print('  ├─────────────────────┼──────────────────────────────┤');
  print('  │  InteractiveViewer   │ Zoom + pan with axis        │');
  print('  │  + PanAxis           │ constraints                 │');
  print('  ├─────────────────────┼──────────────────────────────┤');
  print('  │  InteractiveViewer   │ Unbounded content with      │');
  print('  │  .builder            │ lazy child building         │');
  print('  ├─────────────────────┼──────────────────────────────┤');
  print('  │  GestureDetector     │ Custom gesture handling     │');
  print('  │  + Transform         │ (full control, more work)   │');
  print('  └─────────────────────┴──────────────────────────────┘');
  print('');

  // ─── Section 13: Source Code Architecture ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 13: Source Code Architecture');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  In the Flutter SDK, PanAxis is defined in');
  print('  widgets/interactive_viewer.dart:');
  print('');
  print('  ┌──────────────────────────────────────────────────┐');
  print('  │  enum PanAxis {                                   │');
  print('  │    horizontal,                                    │');
  print('  │    vertical,                                      │');
  print('  │    aligned,                                       │');
  print('  │    free,                                          │');
  print('  │  }                                                │');
  print('  └──────────────────────────────────────────────────┘');
  print('');
  print('  The InteractiveViewer state class uses panAxis in');
  print('  its _onScaleUpdate method to filter the pan delta:');
  print('');
  print('  ┌──────────────────────────────────────────────────┐');
  print('  │  switch (widget.panAxis) {                        │');
  print('  │    case PanAxis.horizontal:                       │');
  print('  │      focalPointDelta = Offset(delta.dx, 0);      │');
  print('  │    case PanAxis.vertical:                         │');
  print('  │      focalPointDelta = Offset(0, delta.dy);      │');
  print('  │    case PanAxis.aligned:                          │');
  print('  │      // Determine dominant axis from accumulated  │');
  print('  │      // deltas, then zero out the other           │');
  print('  │    case PanAxis.free:                             │');
  print('  │      focalPointDelta = delta;  // no filtering    │');
  print('  │  }                                                │');
  print('  └──────────────────────────────────────────────────┘');
  print('');

  // ─── Section 14: Dynamic PanAxis Switching ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 14: Dynamic PanAxis Switching');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  PanAxis can be changed at runtime by rebuilding the');
  print('  InteractiveViewer with a different value:');
  print('');
  print('  ┌──────────────────────────────────────────────────┐');
  print('  │  // In a StatefulWidget:                          │');
  print('  │  PanAxis currentAxis = PanAxis.free;              │');
  print('  │                                                   │');
  print('  │  InteractiveViewer(                               │');
  print('  │    panAxis: currentAxis,                          │');
  print('  │    child: largeContent,                           │');
  print('  │  )                                                │');
  print('  │                                                   │');
  print('  │  // Toggle with a button:                         │');
  print('  │  setState(() {                                    │');
  print('  │    currentAxis = currentAxis == PanAxis.free      │');
  print('  │      ? PanAxis.aligned                            │');
  print('  │      : PanAxis.free;                              │');
  print('  │  });                                              │');
  print('  └──────────────────────────────────────────────────┘');
  print('');
  print('  The switch takes effect on the next gesture. Any');
  print('  ongoing gesture uses the panAxis that was active');
  print('  when the gesture started.');
  print('');

  // ─── Section 15: Performance Characteristics ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 15: Performance Characteristics');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  PanAxis has negligible performance impact:');
  print('');
  print('  ┌────────────────────────┬──────────────────────────┐');
  print('  │  Aspect                │  Impact                  │');
  print('  ├────────────────────────┼──────────────────────────┤');
  print('  │  Enum comparison       │  O(1), trivial           │');
  print('  │  Delta filtering       │  O(1) per gesture event  │');
  print('  │  Matrix update         │  Same cost for all modes │');
  print('  │  Aligned axis detect   │  O(1) comparison of dx/dy│');
  print('  │  Child repaint         │  Same for all modes      │');
  print('  │  Memory overhead       │  Zero (enum value only)  │');
  print('  └────────────────────────┴──────────────────────────┘');
  print('');
  print('  The only cost difference between modes is the aligned');
  print('  mode maintaining a running sum to determine the');
  print('  dominant axis — this is one addition per gesture event.');
  print('');

  // ─── Section 16: Common Pitfalls ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 16: Common Pitfalls');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  Pitfall 1: Confusing panAxis with scroll direction');
  print('  ┌──────────────────────────────────────────────────┐');
  print('  │  PanAxis is NOT the same as Axis (used by        │');
  print('  │  ListView, PageView, etc.). They are different   │');
  print('  │  enums for different widget systems.              │');
  print('  │                                                   │');
  print('  │  PanAxis → InteractiveViewer only                 │');
  print('  │  Axis    → Scrollable widgets (ListView, etc.)    │');
  print('  └──────────────────────────────────────────────────┘');
  print('');
  print('  Pitfall 2: Expecting aligned to prevent zoom drift');
  print('  ┌──────────────────────────────────────────────────┐');
  print('  │  PanAxis.aligned only constrains PAN gestures.   │');
  print('  │  Pinch-zoom can still cause apparent "drift"     │');
  print('  │  because zoom centers on the pinch focal point.   │');
  print('  └──────────────────────────────────────────────────┘');
  print('');
  print('  Pitfall 3: Nesting InteractiveViewer in a scroll');
  print('  ┌──────────────────────────────────────────────────┐');
  print('  │  If InteractiveViewer is inside a ListView:       │');
  print('  │  • PanAxis.vertical may fight the ListView        │');
  print('  │  • PanAxis.horizontal avoids the conflict         │');
  print('  │  • Or use NeverScrollableScrollPhysics on parent  │');
  print('  └──────────────────────────────────────────────────┘');
  print('');

  // ─── Section 17: Live Interactive Demo ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 17: Live Interactive Demo');
  print('═══════════════════════════════════════════════════════════');
  print('');

  // Build a demo with 4 InteractiveViewers, one for each PanAxis
  final panAxisEntries = <MapEntry<PanAxis, Map<String, dynamic>>>[
    MapEntry(PanAxis.horizontal, {
      'label': 'Horizontal Only',
      'icon': Icons.swap_horiz,
      'color': purple700,
      'desc': 'Pan left/right only',
    }),
    MapEntry(PanAxis.vertical, {
      'label': 'Vertical Only',
      'icon': Icons.swap_vert,
      'color': purple500,
      'desc': 'Pan up/down only',
    }),
    MapEntry(PanAxis.aligned, {
      'label': 'Aligned (Axis Lock)',
      'icon': Icons.open_with,
      'color': purple400,
      'desc': 'Locks to dominant axis',
    }),
    MapEntry(PanAxis.free, {
      'label': 'Free (Default)',
      'icon': Icons.zoom_out_map,
      'color': purple800,
      'desc': 'Pan in any direction',
    }),
  ];

  // Grid content for each viewer
  Widget buildGridContent(Color accentColor) {
    return SizedBox(
      width: 500,
      height: 500,
      child: CustomPaint(
        painter: _GridPainter(accentColor: accentColor),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.9),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: accentColor, width: 2),
            ),
            child: Text(
              'Pan Me!',
              style: TextStyle(
                color: accentColor,
                fontWeight: FontWeight.w800,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }

  final panAxisDemo = Scaffold(
    backgroundColor: purple50,
    appBar: AppBar(
      title: const Text(
        'PanAxis — Interactive Comparison',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 16,
        ),
      ),
      backgroundColor: purple900,
    ),
    body: ListView(
      padding: const EdgeInsets.all(12),
      children: [
        // Header
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [purple700, purple500],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Four PanAxis Modes',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Each panel below uses a different PanAxis value.\n'
                'Try panning in each to feel the difference.',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.85),
                  fontSize: 13,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        // Four InteractiveViewers
        ...panAxisEntries.map((entry) {
          final axis = entry.key;
          final info = entry.value;
          final entryColor = info['color'] as Color;

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: purple100,
              ),
              boxShadow: [
                BoxShadow(
                  color: entryColor.withValues(alpha: 0.1),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Label bar
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: entryColor.withValues(alpha: 0.1),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(11),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        info['icon'] as IconData,
                        color: entryColor,
                        size: 20,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${info['label']}',
                              style: TextStyle(
                                color: entryColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              'PanAxis.${axis.name} — ${info['desc']}',
                              style: TextStyle(
                                color: entryColor.withValues(alpha: 0.7),
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Interactive viewer panel
                SizedBox(
                  height: 180,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(11),
                    ),
                    child: InteractiveViewer(
                      panAxis: axis,
                      boundaryMargin: const EdgeInsets.all(100),
                      minScale: 0.5,
                      maxScale: 3.0,
                      child: buildGridContent(entryColor),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),

        // Enum reference card
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: purpleLight,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: purple200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'PanAxis Enum Reference',
                style: TextStyle(
                  color: purple900,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),
              ...PanAxis.values.map((axis) {
                final descriptions = {
                  PanAxis.horizontal: 'Pan only along X axis',
                  PanAxis.vertical: 'Pan only along Y axis',
                  PanAxis.aligned: 'Lock to dominant drag axis',
                  PanAxis.free: 'Unrestricted panning (default)',
                };
                return Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: purple400,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'PanAxis.${axis.name}',
                        style: TextStyle(
                          color: purple700,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          fontFamily: 'monospace',
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          descriptions[axis] ?? '',
                          style: TextStyle(
                            color: purple800.withValues(alpha: 0.8),
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ],
    ),
  );

  print('  Live widget built: 4-panel PanAxis comparison');
  print('  • Each panel uses a different PanAxis value');
  print('  • 500x500 grid content to pan/zoom in each');
  print('  • Color-coded labels with enum descriptions');
  print('');

  // ─── Section 18: Summary ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 18: Summary');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  PanAxis is a focused enum that constrains the');
  print('  panning direction within InteractiveViewer.');
  print('');
  print('  ┌─────────────────────────────────────────────────────┐');
  print('  │  Key takeaways:                                     │');
  print('  │                                                     │');
  print('  │  1. Four values: horizontal, vertical, aligned, free│');
  print('  │  2. Default is PanAxis.free (no constraint)         │');
  print('  │  3. Aligned locks to dominant axis per gesture      │');
  print('  │  4. Only affects pan — zoom is unaffected           │');
  print('  │  5. Requires panEnabled = true to have effect       │');
  print('  │  6. Works with boundaryMargin for extent limits     │');
  print('  │  7. Can be changed dynamically via setState         │');
  print('  │  8. Zero performance overhead                       │');
  print('  └─────────────────────────────────────────────────────┘');
  print('');

  print('  Demo colors used:');
  print('  ┌──────────────────────────────────────────────────┐');
  print('  │  Purple 900  ${purple900.toARGB32().toRadixString(16).padLeft(8, "0")}  Deep');
  print('  │  Purple 800  ${purple800.toARGB32().toRadixString(16).padLeft(8, "0")}  Dark');
  print('  │  Purple 700  ${purple700.toARGB32().toRadixString(16).padLeft(8, "0")}  Primary');
  print('  │  Purple 500  ${purple500.toARGB32().toRadixString(16).padLeft(8, "0")}  Secondary');
  print('  │  Purple 400  ${purple400.toARGB32().toRadixString(16).padLeft(8, "0")}  Warm');
  print('  │  Purple 300  ${purple300.toARGB32().toRadixString(16).padLeft(8, "0")}  Highlight');
  print('  │  Purple 200  ${purple200.toARGB32().toRadixString(16).padLeft(8, "0")}  Accent');
  print('  │  Purple 100  ${purple100.toARGB32().toRadixString(16).padLeft(8, "0")}  Muted');
  print('  │  Purple 50   ${purple50.toARGB32().toRadixString(16).padLeft(8, "0")}  Surface');
  print('  │  Purple Lt   ${purpleLight.toARGB32().toRadixString(16).padLeft(8, "0")}  Light');
  print('  └──────────────────────────────────────────────────┘');
  print('');

  print('████████████████████████████████████████████████████████████');
  print('██  PanAxis — Demonstration Complete                     ██');
  print('████████████████████████████████████████████████████████████');
  print('');

  return panAxisDemo;
}

/// Custom painter that draws a grid pattern for the InteractiveViewer panels
class _GridPainter extends CustomPainter {
  final Color accentColor;

  const _GridPainter({required this.accentColor});

  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = accentColor.withValues(alpha: 0.15)
      ..strokeWidth = 1.0;

    final majorPaint = Paint()
      ..color = accentColor.withValues(alpha: 0.35)
      ..strokeWidth = 2.0;

    const spacing = 25.0;

    // Draw grid lines
    for (double x = 0; x <= size.width; x += spacing) {
      final isMajor = (x % (spacing * 4) == 0);
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        isMajor ? majorPaint : gridPaint,
      );
    }

    for (double y = 0; y <= size.height; y += spacing) {
      final isMajor = (y % (spacing * 4) == 0);
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        isMajor ? majorPaint : gridPaint,
      );
    }

    // Draw center crosshair
    final centerPaint = Paint()
      ..color = accentColor.withValues(alpha: 0.6)
      ..strokeWidth = 2.0;

    final cx = size.width / 2;
    final cy = size.height / 2;
    canvas.drawLine(Offset(cx - 20, cy), Offset(cx + 20, cy), centerPaint);
    canvas.drawLine(Offset(cx, cy - 20), Offset(cx, cy + 20), centerPaint);

    // Draw origin marker
    canvas.drawCircle(Offset(cx, cy), 4, Paint()..color = accentColor);
  }

  @override
  bool shouldRepaint(_GridPainter oldDelegate) =>
      accentColor != oldDelegate.accentColor;
}
