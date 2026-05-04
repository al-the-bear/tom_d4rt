// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ScrollDirection enum from package:flutter/rendering.
// Deep Demo: Visual + instructive walkthrough of ScrollDirection — the enum
// that reports the *user-perceived direction of CONTENT motion* during a
// drag/fling, not the direction of the finger and not the AxisDirection of
// the viewport. ScrollDirection has exactly three values: idle, forward,
// reverse. It is reported by ScrollPosition.userScrollDirection and by
// UserScrollNotification, and is the canonical signal used by
// "hide-on-scroll" patterns, momentum-aware FABs, and scroll-aware sheets.
//
// Why a whole demo for a 3-valued enum? Because the *meaning* of the values
// is genuinely subtle:
//   * The direction is relative to the AxisDirection of the viewport.
//   * "forward" means content is moving toward larger scroll offsets, which
//     for an AxisDirection.down list (the default ListView) means the user
//     is dragging UP and revealing content further down — i.e. the finger
//     goes UP, the content goes UP, the offset INCREASES.
//   * "reverse" is the opposite: finger goes DOWN, content moves DOWN, the
//     offset DECREASES, scrollbar thumb travels back toward 0.
//   * "idle" is reported when no user-driven scroll is in progress. A
//     ballistic settle after a fling is *still* idle from
//     userScrollDirection's point of view — a classic source of bugs.
//
// This file builds an annotated reference card for the three values, two
// concrete viewport simulations (vertical and horizontal), three real-world
// recipes, a comparison with AxisDirection / ScrollPositionAlignmentPolicy,
// and a pitfalls section.

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

dynamic build(BuildContext context) {
  print('ScrollDirection Deep Demo executing');
  print('Enum has ${ScrollDirection.values.length} values: '
      '${ScrollDirection.values.map((v) => v.name).join(", ")}');

  // ============================================================
  // SECTION 1: Hero header
  // ============================================================
  print('=== Section 1: Hero header ===');

  final hero = Container(
    padding: const EdgeInsets.all(24.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.deepPurple.shade700,
          Colors.indigo.shade600,
          Colors.blue.shade500,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Colors.deepPurple.shade900.withValues(alpha: 0.45),
          blurRadius: 24.0,
          offset: const Offset(0.0, 12.0),
        ),
        BoxShadow(
          color: Colors.indigo.shade900.withValues(alpha: 0.25),
          blurRadius: 6.0,
          offset: const Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(14.0),
              ),
              child: const Icon(Icons.swap_vert,
                  color: Colors.white, size: 40.0),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'ScrollDirection',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                  Text(
                    'package:flutter/rendering.dart',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12.0,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 12.0, vertical: 6.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Text(
                '${ScrollDirection.values.length} values',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 18.0),
        const Text(
          'The direction the user is currently scrolling — measured as the '
          'direction of CONTENT motion, not finger motion. Used by '
          'UserScrollNotification, ScrollPosition.userScrollDirection, and '
          'every "hide on scroll" UI you have ever built.',
          style: TextStyle(
              color: Colors.white, fontSize: 14.0, height: 1.45),
        ),
      ],
    ),
  );
  print('Hero built');

  // ============================================================
  // SECTION 2: Disambiguation diagram — finger vs content vs offset
  // ============================================================
  print('=== Section 2: Finger vs content vs offset ===');

  Widget arrowColumn({
    required IconData icon,
    required Color color,
    required String top,
    required String bottom,
  }) {
    return Container(
      width: 110.0,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withValues(alpha: 0.10),
            color.withValues(alpha: 0.25),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: color.withValues(alpha: 0.6), width: 1.4),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.25),
            blurRadius: 8.0,
            offset: const Offset(0.0, 3.0),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(top,
              style: TextStyle(
                  fontSize: 11.0,
                  color: color,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 4.0),
          Icon(icon, color: color, size: 36.0),
          const SizedBox(height: 4.0),
          Text(bottom,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 10.0, color: Colors.grey.shade800)),
        ],
      ),
    );
  }

  final disambig = Container(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.amber.shade50, Colors.orange.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.orange.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.orange.shade200.withValues(alpha: 0.5),
          blurRadius: 12.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Icon(Icons.warning_amber_rounded,
              color: Colors.orange.shade800, size: 22.0),
          const SizedBox(width: 8.0),
          Text(
            'The famous confusion',
            style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.orange.shade900),
          ),
        ]),
        const SizedBox(height: 12.0),
        const Text(
          'A user drags their finger UP on a default ListView (axis = down). '
          'Three different "directions" are in play. Only one of them is '
          'ScrollDirection.',
          style: TextStyle(fontSize: 13.0, height: 1.4),
        ),
        const SizedBox(height: 14.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            arrowColumn(
              icon: Icons.arrow_upward,
              color: Colors.blue.shade700,
              top: 'FINGER',
              bottom: 'moves up\n(gesture)',
            ),
            arrowColumn(
              icon: Icons.arrow_upward,
              color: Colors.green.shade700,
              top: 'CONTENT',
              bottom: 'moves up\n(pixels)',
            ),
            arrowColumn(
              icon: Icons.add_circle,
              color: Colors.deepPurple.shade700,
              top: 'OFFSET',
              bottom: 'increases\n(scroll value)',
            ),
            arrowColumn(
              icon: Icons.fast_forward,
              color: Colors.red.shade700,
              top: 'ScrollDir',
              bottom: 'forward\n(this enum)',
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.orange.shade300),
          ),
          child: const Text(
            'Rule of thumb: ScrollDirection follows the OFFSET. Increasing '
            'offset → forward. Decreasing offset → reverse. No active drag → '
            'idle. The finger direction is irrelevant; what matters is the '
            'sign of the offset delta relative to the viewport AxisDirection.',
            style: TextStyle(fontSize: 12.0, height: 1.45),
          ),
        ),
      ],
    ),
  );
  print('Disambiguation built');

  // ============================================================
  // SECTION 3: Per-value cards — idle, forward, reverse
  // ============================================================
  print('=== Section 3: Per-value cards ===');

  Widget directionCard({
    required ScrollDirection value,
    required Color color,
    required IconData icon,
    required String oneLiner,
    required String verticalMeaning,
    required String horizontalMeaning,
    required String whenItFires,
  }) {
    print('Building card for ScrollDirection.${value.name} '
        '(index ${value.index})');
    return Container(
      width: 320.0,
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withValues(alpha: 0.08),
            color.withValues(alpha: 0.22),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: color, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.30),
            blurRadius: 12.0,
            offset: const Offset(0.0, 6.0),
          ),
          BoxShadow(
            color: color.withValues(alpha: 0.15),
            blurRadius: 3.0,
            offset: const Offset(0.0, 1.0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.20),
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: color, width: 1.5),
                ),
                child: Icon(icon, color: color, size: 28.0),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ScrollDirection.${value.name}',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                    Text(
                      'index ${value.index}',
                      style: TextStyle(
                          fontSize: 10.0, color: Colors.grey.shade700),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          Text(
            oneLiner,
            style: TextStyle(
                fontSize: 13.0,
                color: Colors.grey.shade900,
                fontStyle: FontStyle.italic,
                height: 1.4),
          ),
          const SizedBox(height: 12.0),
          _row('Vertical list', verticalMeaning, color),
          const SizedBox(height: 6.0),
          _row('Horizontal list', horizontalMeaning, color),
          const SizedBox(height: 6.0),
          _row('When it fires', whenItFires, color),
        ],
      ),
    );
  }

  final cards = <Widget>[
    directionCard(
      value: ScrollDirection.idle,
      color: Colors.blueGrey.shade600,
      icon: Icons.pause_circle_outline,
      oneLiner:
          'No user-driven scroll. Notice: ballistic settle after a fling '
          'still reports idle here.',
      verticalMeaning:
          'Finger lifted, or never touched. Offset may still drift '
          'during physics simulation.',
      horizontalMeaning:
          'Same: any horizontal page that is not actively dragged is idle, '
          'even mid-snap.',
      whenItFires:
          'Default state. Reported once at end of drag, before ballistic '
          'simulation completes the gesture.',
    ),
    directionCard(
      value: ScrollDirection.forward,
      color: Colors.green.shade700,
      icon: Icons.fast_forward,
      oneLiner:
          'Content is moving in the AxisDirection — offset is INCREASING.',
      verticalMeaning:
          'AxisDirection.down list: finger drags UP, list pixels move UP, '
          'offset grows. Reveals further-down items.',
      horizontalMeaning:
          'AxisDirection.right list: finger drags LEFT, items shift LEFT, '
          'offset grows. Reveals further-right items.',
      whenItFires:
          'Beginning of drag toward higher offsets, and continuously while '
          'the user keeps dragging that way.',
    ),
    directionCard(
      value: ScrollDirection.reverse,
      color: Colors.red.shade700,
      icon: Icons.fast_rewind,
      oneLiner:
          'Content is moving AGAINST the AxisDirection — offset is '
          'DECREASING.',
      verticalMeaning:
          'AxisDirection.down list: finger drags DOWN, list pixels move '
          'DOWN, offset shrinks. Reveals earlier items / pulls down to '
          'refresh.',
      horizontalMeaning:
          'AxisDirection.right list: finger drags RIGHT, items shift RIGHT, '
          'offset shrinks toward 0.',
      whenItFires:
          'Drags toward lower offsets. The classic trigger for hiding the '
          'AppBar / showing a "back to top" affordance.',
    ),
  ];
  print('Built ${cards.length} per-value cards');

  // ============================================================
  // SECTION 4: Mock vertical viewport showing each direction
  // ============================================================
  print('=== Section 4: Mock vertical viewport ===');

  Widget mockVertical(ScrollDirection dir, Color tone) {
    final isForward = dir == ScrollDirection.forward;
    final isReverse = dir == ScrollDirection.reverse;
    final thumbTop = isForward ? 90.0 : (isReverse ? 20.0 : 55.0);
    final arrowIcon = isForward
        ? Icons.arrow_upward
        : (isReverse ? Icons.arrow_downward : Icons.horizontal_rule);
    return Container(
      width: 150.0,
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            tone.withValues(alpha: 0.05),
            tone.withValues(alpha: 0.18),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: tone, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: tone.withValues(alpha: 0.25),
            blurRadius: 6.0,
            offset: const Offset(0.0, 3.0),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            dir.name.toUpperCase(),
            style: TextStyle(
                fontSize: 11.0,
                fontWeight: FontWeight.bold,
                color: tone),
          ),
          const SizedBox(height: 6.0),
          Stack(
            children: [
              // The "viewport"
              Container(
                width: 110.0,
                height: 160.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6.0),
                  border:
                      Border.all(color: Colors.grey.shade400, width: 1.0),
                ),
                child: Column(
                  children: List.generate(6, (i) {
                    return Container(
                      height: 22.0,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 4.0, vertical: 2.0),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(3.0),
                      ),
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 6.0),
                      child: Text('item $i',
                          style: TextStyle(
                              fontSize: 10.0,
                              color: Colors.grey.shade700)),
                    );
                  }),
                ),
              ),
              // Thumb track
              Positioned(
                right: 0.0,
                top: 0.0,
                bottom: 0.0,
                child: Container(
                  width: 4.0,
                  color: Colors.grey.shade200,
                ),
              ),
              // Thumb position
              Positioned(
                right: 0.0,
                top: thumbTop,
                child: Container(
                  width: 4.0,
                  height: 36.0,
                  decoration: BoxDecoration(
                    color: tone,
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                ),
              ),
              // Arrow overlay representing content motion
              Positioned(
                left: 40.0,
                top: 60.0,
                child: Icon(arrowIcon, color: tone, size: 36.0),
              ),
            ],
          ),
          const SizedBox(height: 6.0),
          Text(
            isForward
                ? 'finger ↑ / offset ↑'
                : (isReverse ? 'finger ↓ / offset ↓' : 'no drag'),
            style:
                TextStyle(fontSize: 10.0, color: Colors.grey.shade700),
          ),
        ],
      ),
    );
  }

  final verticalRow = Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      mockVertical(ScrollDirection.idle, Colors.blueGrey.shade600),
      mockVertical(ScrollDirection.forward, Colors.green.shade700),
      mockVertical(ScrollDirection.reverse, Colors.red.shade700),
    ],
  );
  print('Vertical viewports built');

  // ============================================================
  // SECTION 5: Mock horizontal viewport
  // ============================================================
  print('=== Section 5: Mock horizontal viewport ===');

  Widget mockHorizontal(ScrollDirection dir, Color tone) {
    final isForward = dir == ScrollDirection.forward;
    final isReverse = dir == ScrollDirection.reverse;
    final thumbLeft = isForward ? 110.0 : (isReverse ? 20.0 : 65.0);
    final arrowIcon = isForward
        ? Icons.arrow_back
        : (isReverse ? Icons.arrow_forward : Icons.horizontal_rule);
    return Container(
      width: 220.0,
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            tone.withValues(alpha: 0.05),
            tone.withValues(alpha: 0.20),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: tone, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: tone.withValues(alpha: 0.25),
            blurRadius: 6.0,
            offset: const Offset(0.0, 3.0),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'horizontal: ${dir.name}',
            style: TextStyle(
                fontSize: 11.0,
                fontWeight: FontWeight.bold,
                color: tone),
          ),
          const SizedBox(height: 6.0),
          Stack(
            children: [
              Container(
                width: 200.0,
                height: 60.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6.0),
                  border:
                      Border.all(color: Colors.grey.shade400, width: 1.0),
                ),
                child: Row(
                  children: List.generate(5, (i) {
                    return Container(
                      width: 36.0,
                      margin: const EdgeInsets.all(3.0),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(3.0),
                      ),
                      alignment: Alignment.center,
                      child: Text('$i',
                          style: TextStyle(
                              fontSize: 11.0,
                              color: Colors.grey.shade700)),
                    );
                  }),
                ),
              ),
              Positioned(
                left: 0.0,
                right: 0.0,
                bottom: 0.0,
                child: Container(height: 4.0, color: Colors.grey.shade200),
              ),
              Positioned(
                left: thumbLeft,
                bottom: 0.0,
                child: Container(
                  width: 50.0,
                  height: 4.0,
                  decoration: BoxDecoration(
                    color: tone,
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                ),
              ),
              Positioned(
                left: 80.0,
                top: 14.0,
                child: Icon(arrowIcon, color: tone, size: 28.0),
              ),
            ],
          ),
          const SizedBox(height: 6.0),
          Text(
            isForward
                ? 'finger ← / offset ↑'
                : (isReverse ? 'finger → / offset ↓' : 'no drag'),
            style:
                TextStyle(fontSize: 10.0, color: Colors.grey.shade700),
          ),
        ],
      ),
    );
  }

  final horizontalCol = Column(
    children: [
      mockHorizontal(ScrollDirection.idle, Colors.blueGrey.shade600),
      mockHorizontal(ScrollDirection.forward, Colors.green.shade700),
      mockHorizontal(ScrollDirection.reverse, Colors.red.shade700),
    ],
  );
  print('Horizontal viewports built');

  // ============================================================
  // SECTION 6: Recipes — three real-world patterns
  // ============================================================
  print('=== Section 6: Recipes ===');

  Widget recipe({
    required String title,
    required String why,
    required String code,
    required Color color,
    required IconData icon,
  }) {
    print('Recipe: $title');
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withValues(alpha: 0.05),
            color.withValues(alpha: 0.18),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: color, width: 1.6),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.25),
            blurRadius: 10.0,
            offset: const Offset(0.0, 5.0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(icon, color: color, size: 24.0),
            const SizedBox(width: 8.0),
            Text(
              title,
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: color),
            ),
          ]),
          const SizedBox(height: 8.0),
          Text(why,
              style: const TextStyle(fontSize: 12.0, height: 1.4)),
          const SizedBox(height: 10.0),
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              code,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.0,
                color: color.withValues(alpha: 0.9),
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }

  final recipeHide = recipe(
    title: 'Recipe 1 — Hide-on-scroll AppBar',
    why:
        'Drop the AppBar when the user scrolls forward (digging deeper into '
        'content); show it again when they scroll reverse (heading back up). '
        'Note: rely on UserScrollNotification.direction, NOT on offset deltas '
        'across frames — the latter triggers on inertial settles too.',
    code: 'NotificationListener<UserScrollNotification>(\n'
        '  onNotification: (n) {\n'
        '    final dir = n.direction;\n'
        '    if (dir == ScrollDirection.forward) {\n'
        '      // hide app bar (animate offscreen)\n'
        '    } else if (dir == ScrollDirection.reverse) {\n'
        '      // show app bar\n'
        '    }\n'
        '    // ScrollDirection.idle: keep current state\n'
        '    return false;\n'
        '  },\n'
        '  child: ListView(...),\n'
        ')',
    color: Colors.green.shade700,
    icon: Icons.vertical_align_top,
  );

  final recipeFab = recipe(
    title: 'Recipe 2 — Momentum-aware FAB',
    why:
        'A FAB that collapses to an icon-only chip while the user is actively '
        'scrolling, and re-expands to icon+label when they stop. Watch for '
        'ScrollDirection.idle to know when to expand again — but remember '
        'idle fires when the DRAG ends, even if the page is still gliding.',
    code: 'bool expanded = true; // track elsewhere\n'
        'NotificationListener<UserScrollNotification>(\n'
        '  onNotification: (n) {\n'
        '    switch (n.direction) {\n'
        '      case ScrollDirection.forward:\n'
        '      case ScrollDirection.reverse:\n'
        '        expanded = false; // collapse to icon\n'
        '        break;\n'
        '      case ScrollDirection.idle:\n'
        '        expanded = true;  // expand label\n'
        '        break;\n'
        '    }\n'
        '    return false;\n'
        '  },\n'
        '  child: ListView(...),\n'
        ')',
    color: Colors.deepPurple.shade600,
    icon: Icons.smart_button,
  );

  final recipeSheet = recipe(
    title: 'Recipe 3 — Scroll-aware bottom sheet',
    why:
        'A persistent bottom sheet that peeks while the user scrolls forward, '
        'and fully reveals when they scroll reverse. The pattern is the same '
        'as the AppBar but inverted on the Y axis. RTL and reversed lists '
        'flip the meaning of forward/reverse — see Pitfalls.',
    code: 'NotificationListener<UserScrollNotification>(\n'
        '  onNotification: (n) {\n'
        '    final isPullingUp = n.direction == ScrollDirection.reverse;\n'
        '    sheetController.target = isPullingUp ? 1.0 : 0.2;\n'
        '    return false;\n'
        '  },\n'
        '  child: ListView(...),\n'
        ')',
    color: Colors.teal.shade700,
    icon: Icons.unfold_more,
  );
  print('Recipes built');

  // ============================================================
  // SECTION 7: Visual map — gesture → AxisDirection → ScrollDirection
  // ============================================================
  print('=== Section 7: Gesture → Axis → ScrollDirection map ===');

  Widget mapCell(String text,
      {bool header = false, Color? bg, Color? fg, double width = 130.0}) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: bg ?? (header ? Colors.indigo.shade100 : Colors.white),
        border: Border.all(color: Colors.grey.shade400, width: 0.5),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: header ? 11.0 : 11.5,
          fontWeight: header ? FontWeight.bold : FontWeight.normal,
          color: fg ?? (header ? Colors.indigo.shade900 : Colors.black87),
          fontFamily: header ? null : 'monospace',
        ),
      ),
    );
  }

  final mapTable = Container(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.cyan.shade50, Colors.blue.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.cyan.shade300, width: 1.4),
      boxShadow: [
        BoxShadow(
          color: Colors.cyan.shade200.withValues(alpha: 0.5),
          blurRadius: 10.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Mapping table — finger → AxisDirection → ScrollDirection',
          style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.cyan.shade900),
        ),
        const SizedBox(height: 12.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            children: [
              Row(children: [
                mapCell('Finger', header: true),
                mapCell('AxisDirection', header: true),
                mapCell('Offset Δ', header: true),
                mapCell('ScrollDirection', header: true),
              ]),
              Row(children: [
                mapCell('drag UP'),
                mapCell('down'),
                mapCell('+', bg: Colors.green.shade50),
                mapCell('forward', fg: Colors.green.shade800),
              ]),
              Row(children: [
                mapCell('drag DOWN'),
                mapCell('down'),
                mapCell('-', bg: Colors.red.shade50),
                mapCell('reverse', fg: Colors.red.shade800),
              ]),
              Row(children: [
                mapCell('drag DOWN'),
                mapCell('up (reversed)'),
                mapCell('+', bg: Colors.green.shade50),
                mapCell('forward', fg: Colors.green.shade800),
              ]),
              Row(children: [
                mapCell('drag UP'),
                mapCell('up (reversed)'),
                mapCell('-', bg: Colors.red.shade50),
                mapCell('reverse', fg: Colors.red.shade800),
              ]),
              Row(children: [
                mapCell('drag LEFT'),
                mapCell('right'),
                mapCell('+', bg: Colors.green.shade50),
                mapCell('forward', fg: Colors.green.shade800),
              ]),
              Row(children: [
                mapCell('drag RIGHT'),
                mapCell('right'),
                mapCell('-', bg: Colors.red.shade50),
                mapCell('reverse', fg: Colors.red.shade800),
              ]),
              Row(children: [
                mapCell('drag RIGHT'),
                mapCell('left (RTL)'),
                mapCell('+', bg: Colors.green.shade50),
                mapCell('forward', fg: Colors.green.shade800),
              ]),
              Row(children: [
                mapCell('no drag'),
                mapCell('any'),
                mapCell('±/0', bg: Colors.grey.shade100),
                mapCell('idle', fg: Colors.blueGrey.shade800),
              ]),
            ],
          ),
        ),
        const SizedBox(height: 10.0),
        Text(
          'Read this table at least twice. The row that surprises most '
          'developers is the RTL one: dragging RIGHT in an Arabic UI is '
          'forward, because the AxisDirection is left.',
          style: TextStyle(
              fontSize: 11.0,
              fontStyle: FontStyle.italic,
              color: Colors.cyan.shade900),
        ),
      ],
    ),
  );
  print('Mapping table built');

  // ============================================================
  // SECTION 8: Comparison with neighbours
  // ============================================================
  print('=== Section 8: Neighbour comparison ===');

  Widget compareCard(String title, String oneLiner, List<String> bullets,
      Color color, IconData icon) {
    return Container(
      width: 280.0,
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withValues(alpha: 0.06),
            color.withValues(alpha: 0.20),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: color, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.30),
            blurRadius: 10.0,
            offset: const Offset(0.0, 4.0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(icon, color: color, size: 22.0),
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 13.0,
                    fontWeight: FontWeight.bold,
                    color: color),
              ),
            ),
          ]),
          const SizedBox(height: 8.0),
          Text(oneLiner,
              style: const TextStyle(fontSize: 12.0, height: 1.4)),
          const SizedBox(height: 8.0),
          for (final b in bullets)
            Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.circle, size: 6.0, color: color),
                  const SizedBox(width: 6.0),
                  Expanded(
                    child: Text(b,
                        style: const TextStyle(
                            fontSize: 11.0, height: 1.35)),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  final comparison = Wrap(
    alignment: WrapAlignment.center,
    children: [
      compareCard(
        'ScrollDirection',
        'User-perceived direction of CONTENT motion. 3 values: idle, forward, '
            'reverse.',
        const [
          'Lives in package:flutter/rendering.',
          'Reported by UserScrollNotification.direction.',
          'Use this for "hide on scroll" UI.',
        ],
        Colors.deepPurple.shade700,
        Icons.swap_vert,
      ),
      compareCard(
        'AxisDirection',
        'Static configuration of the viewport: up, down, left, right. '
            'Defines what "forward" means.',
        const [
          'Set on Viewport / RenderViewport.',
          'Combine with growthDirection to derive ScrollDirection.',
          'Use applyGrowthDirectionToScrollDirection() to flip.',
        ],
        Colors.indigo.shade700,
        Icons.compare_arrows,
      ),
      compareCard(
        'ScrollPositionAlignmentPolicy',
        'How a Scrollable aligns when ensureVisible() is called. Different '
            'concept entirely.',
        const [
          'Values: explicit, keepVisibleAtEnd, keepVisibleAtStart.',
          'About bringing items into view, not motion direction.',
          'Easy to confuse by name only — not a direction enum.',
        ],
        Colors.brown.shade700,
        Icons.center_focus_strong,
      ),
    ],
  );
  print('Comparison built');

  // ============================================================
  // SECTION 9: Pitfalls
  // ============================================================
  print('=== Section 9: Pitfalls ===');

  Widget pitfall(String title, String body, Color color, IconData icon) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withValues(alpha: 0.06),
            color.withValues(alpha: 0.18),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10.0),
        border: Border(
          left: BorderSide(color: color, width: 4.0),
          top: BorderSide(color: color.withValues(alpha: 0.4)),
          right: BorderSide(color: color.withValues(alpha: 0.4)),
          bottom: BorderSide(color: color.withValues(alpha: 0.4)),
        ),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.20),
            blurRadius: 6.0,
            offset: const Offset(0.0, 3.0),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 22.0),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13.0,
                        color: color)),
                const SizedBox(height: 4.0),
                Text(body,
                    style:
                        const TextStyle(fontSize: 12.0, height: 1.45)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final pitfalls = Container(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.red.shade50, Colors.pink.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.red.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pitfalls — read these BEFORE shipping a hide-on-scroll UI',
          style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.red.shade900),
        ),
        const SizedBox(height: 8.0),
        pitfall(
          'Idle hides the inertial settle',
          'After a fling, the user has lifted their finger but the list is '
          'still gliding. ScrollDirection is already idle. If you key off '
          'idle to expand a FAB, it will pop out mid-glide. Either pair with '
          'ScrollPosition.isScrollingNotifier (debounced) or wait for '
          'ScrollEndNotification.',
          Colors.red.shade700,
          Icons.front_hand,
        ),
        pitfall(
          'Reversed lists invert "forward"',
          'A ListView with reverse: true has AxisDirection.up. A finger drag '
          'DOWN now grows the offset and reports ScrollDirection.forward. If '
          'your app bar hides on forward, it will hide when the user expects '
          '"pull down to refresh". Test both reverse: true and reverse: '
          'false.',
          Colors.deepOrange.shade700,
          Icons.flip_camera_android,
        ),
        pitfall(
          'RTL flips horizontal forward',
          'In a horizontal Scrollable inside an RTL Directionality, '
          'AxisDirection becomes left. A finger drag RIGHT (which feels like '
          '"go back to start" to an LTR developer) is forward in RTL. Keep '
          'this in mind when wiring carousel chrome that depends on '
          'direction.',
          Colors.purple.shade700,
          Icons.translate,
        ),
        pitfall(
          'NestedScrollView reports the outer position',
          'When using NestedScrollView, UserScrollNotification can fire from '
          'either inner or outer Scrollable. Filter by depth or by '
          'metrics.axis if you need to drive a header that only follows the '
          'outer scroll.',
          Colors.indigo.shade700,
          Icons.layers,
        ),
        pitfall(
          'Do not derive direction from offset deltas',
          'It is tempting to compute (newOffset - oldOffset) and infer '
          'direction. That fires during ballistic settles, overscroll '
          'snapbacks, and programmatic animateTo() calls. Use '
          'UserScrollNotification.direction — it filters those out for you.',
          Colors.teal.shade800,
          Icons.do_not_disturb_alt,
        ),
      ],
    ),
  );
  print('Pitfalls built');

  // ============================================================
  // SECTION 10: Footer with file path + ASCII box
  // ============================================================
  print('=== Section 10: Footer ===');

  const asciiBox = '''
+----------------------------------------------------------------+
|  ScrollDirection — package:flutter/rendering                   |
|                                                                |
|     idle    --->  no user scroll in progress                   |
|     forward --->  offset increasing  (with AxisDirection)      |
|     reverse --->  offset decreasing  (against AxisDirection)   |
|                                                                |
|  Source of truth: UserScrollNotification.direction             |
|                   ScrollPosition.userScrollDirection           |
+----------------------------------------------------------------+
''';

  final footer = Container(
    margin: const EdgeInsets.only(top: 12.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.grey.shade900, Colors.blueGrey.shade900],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.40),
          blurRadius: 14.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Icon(Icons.insert_drive_file,
              color: Colors.cyan.shade300, size: 18.0),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              'test/tom_d4rt_flutter_ast_app/test/send_ast_via_http_scripts/'
              'rendering/scroll_direction_test.dart',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.0,
                color: Colors.cyan.shade300,
              ),
            ),
          ),
        ]),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.35),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            asciiBox,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.green.shade200,
              height: 1.35,
            ),
          ),
        ),
      ],
    ),
  );
  print('Footer built');

  print('ScrollDirection Deep Demo completed successfully');

  // ============================================================
  // Compose final layout
  // ============================================================
  return SingleChildScrollView(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        hero,
        const SizedBox(height: 24.0),
        const _SectionTitle('1. Finger vs Content vs Offset'),
        disambig,
        const SizedBox(height: 24.0),
        const _SectionTitle('2. The three values'),
        Wrap(
          alignment: WrapAlignment.center,
          children: cards,
        ),
        const SizedBox(height: 24.0),
        const _SectionTitle('3. Vertical viewport simulation'),
        verticalRow,
        const SizedBox(height: 24.0),
        const _SectionTitle('4. Horizontal viewport simulation'),
        horizontalCol,
        const SizedBox(height: 24.0),
        const _SectionTitle('5. Recipes'),
        recipeHide,
        recipeFab,
        recipeSheet,
        const SizedBox(height: 24.0),
        const _SectionTitle('6. Mapping table'),
        mapTable,
        const SizedBox(height: 24.0),
        const _SectionTitle('7. Neighbour comparison'),
        comparison,
        const SizedBox(height: 24.0),
        const _SectionTitle('8. Pitfalls'),
        pitfalls,
        const SizedBox(height: 24.0),
        const _SectionTitle('9. Reference card'),
        footer,
      ],
    ),
  );
}

// Helper: a labelled row inside a per-value card.
Widget _row(String label, String value, Color color) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        width: 96.0,
        padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Text(
          label,
          style: TextStyle(
              fontSize: 10.0,
              fontWeight: FontWeight.bold,
              color: color),
        ),
      ),
      const SizedBox(width: 8.0),
      Expanded(
        child: Text(
          value,
          style: const TextStyle(fontSize: 11.5, height: 1.4),
        ),
      ),
    ],
  );
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0, top: 4.0),
      child: Row(
        children: [
          Container(
            width: 4.0,
            height: 22.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.indigo.shade400, Colors.purple.shade400],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(2.0),
            ),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
