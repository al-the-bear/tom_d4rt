// ignore_for_file: avoid_print
// D4rt deep demo: DirectionalFocusTraversalPolicyMixin — a mixin for
// FocusTraversalPolicy that adds directional (arrow key) focus navigation.
// This covers spatial focus resolution, geometry-based nearest-neighbor
// lookups, and how this enables grid/form keyboard navigation.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ─── Magenta / Fuchsia palette ───
  const Color magenta = Color(0xFFC026D3);
  const Color fuchsia = Color(0xFFD946EF);
  const Color deepMagenta = Color(0xFF86198F);
  const Color paleLavender = Color(0xFFFDF4FF);
  const Color orchid = Color(0xFFE879F9);
  const Color thistle = Color(0xFFF5D0FE);
  const Color plum = Color(0xFF701A75);
  const Color heather = Color(0xFFF0ABFC);
  const Color violet = Color(0xFFa855F7);
  const Color mulberry = Color(0xFF9333EA);

  print('===== DIRECTIONAL FOCUS TRAVERSAL POLICY MIXIN DEEP DEMO =====');

  // ─── Local helpers ───

  Widget sectionBanner(String number, String title) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 24, bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [plum, deepMagenta],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: plum.withValues(alpha: 0.35),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: magenta,
              borderRadius: BorderRadius.circular(17),
              border: Border.all(color: orchid, width: 1.5),
            ),
            child: Center(
              child: Text(number,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.3)),
          ),
        ],
      ),
    );
  }

  Widget noteBox(String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: paleLavender,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: thistle),
      ),
      child: Text(text,
          style: TextStyle(
              fontSize: 13,
              color: deepMagenta.withValues(alpha: 0.9),
              height: 1.5)),
    );
  }

  Widget infoCard(String heading, Widget content) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: thistle),
        boxShadow: [
          BoxShadow(
            color: magenta.withValues(alpha: 0.07),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 12),
            decoration: BoxDecoration(
              color: paleLavender,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(7)),
            ),
            child: Text(heading,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: plum)),
          ),
          Padding(padding: const EdgeInsets.all(12), child: content),
        ],
      ),
    );
  }

  Widget tag(String label, Color bg, Color fg) {
    return Container(
      margin: const EdgeInsets.only(right: 6, bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(label,
          style:
              TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: fg)),
    );
  }

  Widget dataRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 155,
            child: Text(label,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: plum)),
          ),
          Expanded(
            child: Text(value,
                style: TextStyle(fontSize: 12, color: deepMagenta)),
          ),
        ],
      ),
    );
  }

  Widget colorSwatch(String name, Color color) {
    return Container(
      margin: const EdgeInsets.only(right: 8, bottom: 8),
      child: Column(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  color: plum.withValues(alpha: 0.15), width: 1),
            ),
          ),
          const SizedBox(height: 4),
          Text(name,
              style: TextStyle(fontSize: 9, color: plum),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget progressBar(String label, double fraction, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label,
                  style: TextStyle(fontSize: 11, color: plum)),
              Text('${(fraction * 100).toStringAsFixed(0)}%',
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: color)),
            ],
          ),
          const SizedBox(height: 3),
          Container(
            width: double.infinity,
            height: 7,
            decoration: BoxDecoration(
              color: heather.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(3.5),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: fraction.clamp(0.0, 1.0),
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(3.5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget focusCell(String label, bool focused, Color borderColor) {
    return Container(
      width: 70,
      height: 50,
      margin: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: focused ? borderColor.withValues(alpha: 0.2) : Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
            color: focused ? borderColor : heather.withValues(alpha: 0.5),
            width: focused ? 2.5 : 1),
        boxShadow: focused
            ? [BoxShadow(color: borderColor.withValues(alpha: 0.25), blurRadius: 6)]
            : [],
      ),
      child: Center(
        child: Text(label,
            style: TextStyle(
                fontSize: 10,
                fontWeight: focused ? FontWeight.w700 : FontWeight.normal,
                color: focused ? borderColor : deepMagenta)),
      ),
    );
  }

  Widget arrowIndicator(String direction, Color color) {
    IconData icon;
    switch (direction) {
      case 'up':
        icon = Icons.arrow_upward;
        break;
      case 'down':
        icon = Icons.arrow_downward;
        break;
      case 'left':
        icon = Icons.arrow_back;
        break;
      case 'right':
        icon = Icons.arrow_forward;
        break;
      default:
        icon = Icons.help_outline;
    }
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Icon(icon, size: 18, color: color),
    );
  }

  Widget distanceLabel(String from, String to, String distance) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
      decoration: BoxDecoration(
        color: thistle.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Text(from,
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: magenta)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Icon(Icons.arrow_right_alt, size: 14, color: deepMagenta),
          ),
          Text(to,
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: magenta)),
          const Spacer(),
          Text(distance,
              style: TextStyle(fontSize: 11, color: plum, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }

  // ─── Section 1: Overview ───
  print('[Section 1] Overview');

  final section1 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('01', 'Overview & Purpose'),
      noteBox(
          'DirectionalFocusTraversalPolicyMixin adds directional '
          '(arrow key) focus navigation to any FocusTraversalPolicy. While '
          'the base policy handles Tab/Shift+Tab ordering, this mixin adds '
          'spatial awareness — focusing the nearest widget in the direction '
          'the user presses.'),
      infoCard(
          'Core Identity',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Type', 'Mixin on FocusTraversalPolicy'),
              dataRow('Package', 'flutter/widgets'),
              dataRow('Adds', 'Arrow key directional navigation'),
              dataRow('Algorithm', 'Geometry-based nearest neighbor'),
              dataRow('Directions', 'Up, Down, Left, Right'),
            ],
          )),
      infoCard(
          'Why It Matters',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Accessibility', 'Keyboard-only navigation'),
              dataRow('TV / kiosk', 'D-pad / remote control input'),
              dataRow('Desktop', 'Power user keyboard workflows'),
              dataRow('Grid layouts', 'Tab order is insufficient'),
            ],
          )),
    ],
  );

  // ─── Section 2: Linear vs Directional Focus ───
  print('[Section 2] Linear vs Directional Focus');

  final section2 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('02', 'Linear vs Directional Focus'),
      noteBox(
          'Tab traversal is linear — it visits widgets in a flat order. '
          'Directional traversal is spatial — it picks the nearest widget '
          'in the arrow direction. Both complement each other.'),
      infoCard(
          'Tab Traversal (Linear)',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Input', 'Tab / Shift+Tab'),
              dataRow('Order', 'Defined by policy (reading order)'),
              dataRow('Predictable', 'Same order every time'),
              dataRow('Grid behavior', 'Row by row, left to right'),
            ],
          )),
      infoCard(
          'Arrow Traversal (Directional)',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Input', 'Arrow keys (↑ ↓ ← →)'),
              dataRow('Order', 'Spatial — depends on layout'),
              dataRow('Context-aware', 'Varies based on current position'),
              dataRow('Grid behavior', 'Natural column/row movement'),
            ],
          )),
      infoCard(
          'Visual Comparison',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Tab order: A → B → C → D → E → F',
                  style: TextStyle(fontSize: 12, color: deepMagenta, fontWeight: FontWeight.w600)),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  focusCell('A', false, magenta),
                  focusCell('B', false, magenta),
                  focusCell('C', false, magenta),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  focusCell('D', true, magenta),
                  focusCell('E', false, magenta),
                  focusCell('F', false, magenta),
                ],
              ),
              const SizedBox(height: 6),
              Text('Arrow-up from D → goes to A (spatial neighbor)',
                  style: TextStyle(fontSize: 12, color: plum, fontWeight: FontWeight.w600)),
            ],
          )),
    ],
  );

  // ─── Section 3: Spatial Algorithm ───
  print('[Section 3] Spatial Algorithm');

  final section3 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('03', 'Spatial Algorithm'),
      noteBox(
          'The mixin uses a geometry-based nearest-neighbor algorithm. It '
          'examines the bounding rectangles of all focusable nodes and '
          'selects the one closest in the requested direction.'),
      infoCard(
          'Algorithm Steps',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('1. Get current rect', 'Bounding box of focused node'),
              dataRow('2. Filter candidates', 'Only nodes in the direction'),
              dataRow('3. Calculate distance', 'From current to each candidate'),
              dataRow('4. Select nearest', 'Minimum distance wins'),
              dataRow('5. Request focus', 'Move focus to winner'),
            ],
          )),
      infoCard(
          'Direction Filtering',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Up', 'Candidates whose bottom ≤ current top'),
              dataRow('Down', 'Candidates whose top ≥ current bottom'),
              dataRow('Left', 'Candidates whose right ≤ current left'),
              dataRow('Right', 'Candidates whose left ≥ current right'),
            ],
          )),
      infoCard(
          'Distance Metric',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Primary axis', 'Distance along arrow direction'),
              dataRow('Cross axis', 'Perpendicular offset (weighted less)'),
              dataRow('Combined', 'Weighted Euclidean-like metric'),
              dataRow('Tie-breaking', 'Cross-axis alignment preference'),
            ],
          )),
    ],
  );

  // ─── Section 4: Grid Navigation ───
  print('[Section 4] Grid Navigation');

  final section4 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('04', 'Grid Navigation'),
      noteBox(
          'Grid layouts are the primary use case for directional focus. '
          'Arrow keys move between cells naturally — up/down between rows, '
          'left/right between columns.'),
      infoCard(
          'Grid Focus Map',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  focusCell('1,1', false, magenta),
                  focusCell('1,2', false, magenta),
                  focusCell('1,3', false, magenta),
                  focusCell('1,4', false, magenta),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  focusCell('2,1', false, magenta),
                  focusCell('2,2', true, fuchsia),
                  focusCell('2,3', false, magenta),
                  focusCell('2,4', false, magenta),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  focusCell('3,1', false, magenta),
                  focusCell('3,2', false, magenta),
                  focusCell('3,3', false, magenta),
                  focusCell('3,4', false, magenta),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  arrowIndicator('up', magenta),
                  arrowIndicator('down', fuchsia),
                  arrowIndicator('left', orchid),
                  arrowIndicator('right', violet),
                ],
              ),
              const SizedBox(height: 4),
              dataRow('Current focus', 'cell 2,2'),
              dataRow('Arrow up →', 'cell 1,2 (same column)'),
              dataRow('Arrow right →', 'cell 2,3 (same row)'),
              dataRow('Arrow down →', 'cell 3,2 (same column)'),
            ],
          )),
    ],
  );

  // ─── Section 5: Distance Calculation ───
  print('[Section 5] Distance Calculation');

  final section5 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('05', 'Distance Calculation'),
      noteBox(
          'The distance calculation determines which candidate node wins. '
          'It considers both the primary axis (direction of movement) and '
          'the cross axis (perpendicular offset).'),
      infoCard(
          'Distance Components',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              distanceLabel('Cell 2,2', 'Cell 1,2', '50px (direct above)'),
              distanceLabel('Cell 2,2', 'Cell 1,1', '71px (diagonal)'),
              distanceLabel('Cell 2,2', 'Cell 1,3', '71px (diagonal)'),
            ],
          )),
      infoCard(
          'Weighting',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Primary weight', '1.0 (full distance in direction)'),
              dataRow('Cross weight', 'Lower (varies by implementation)'),
              dataRow('Overlap bonus', 'Candidates aligned get priority'),
              dataRow('Zero cross', 'Perfectly aligned — minimum distance'),
            ],
          )),
      infoCard(
          'Edge Cases',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('No candidates', 'Focus stays (no movement)'),
              dataRow('Tied distances', 'First in traversal order wins'),
              dataRow('Overlapping rects', 'Center-to-center distance'),
              dataRow('Very far apart', 'Still navigable if only option'),
            ],
          )),
    ],
  );

  // ─── Section 6: Mixin Methods ───
  print('[Section 6] Mixin Methods');

  final section6 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('06', 'Mixin Methods'),
      noteBox(
          'The mixin provides methods that override or supplement the base '
          'policy\'s navigation. These are called by the focus system when '
          'directional input is detected.'),
      infoCard(
          'Key Methods',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('findFirstFocusInDirection', 'Entry point for arrow nav'),
              dataRow('inDirection', 'Resolve focus in given direction'),
              dataRow('_sortAndFilterByDirection', 'Internal candidate filter'),
              dataRow('_popPolicyDataIfNeeded', 'Stack management'),
            ],
          )),
      infoCard(
          'TraversalDirection Enum',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('TraversalDirection.up', 'Arrow up / D-pad up'),
              dataRow('TraversalDirection.down', 'Arrow down / D-pad down'),
              dataRow('TraversalDirection.left', 'Arrow left / D-pad left'),
              dataRow('TraversalDirection.right', 'Arrow right / D-pad right'),
            ],
          )),
    ],
  );

  // ─── Section 7: Framework Integration ───
  print('[Section 7] Framework Integration');

  final section7 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('07', 'Framework Integration'),
      noteBox(
          'Directional focus is triggered by the framework when FocusNode '
          'receives an arrow key event. The event propagates through the '
          'focus tree to the enclosing FocusTraversalGroup.'),
      infoCard(
          'Event Chain',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('1. Key event', 'Arrow key pressed'),
              dataRow('2. FocusNode', 'Receives keyDown'),
              dataRow('3. Focus system', 'Detects directional intent'),
              dataRow('4. Traversal group', 'Delegates to policy'),
              dataRow('5. Policy mixin', 'Runs directional algorithm'),
              dataRow('6. New focus', 'Target node focused'),
            ],
          )),
      infoCard(
          'FocusTraversalGroup',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Widget', 'FocusTraversalGroup'),
              dataRow('Policy property', 'Accepts any FocusTraversalPolicy'),
              dataRow('Scope', 'Limits navigation to its subtree'),
              dataRow('Nesting', 'Groups can nest for sub-regions'),
            ],
          )),
    ],
  );

  // ─── Section 8: Built-in Policies ───
  print('[Section 8] Built-in Policies');

  final section8 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('08', 'Built-in Policies Using Mixin'),
      noteBox(
          'Several built-in policies use this mixin. Understanding which '
          'policies include directional support helps choose the right one.'),
      infoCard(
          'ReadingOrderTraversalPolicy',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Uses mixin', 'Yes'),
              dataRow('Tab order', 'Reading order (top-left to bottom-right)'),
              dataRow('Arrow keys', 'Spatial nearest neighbor'),
              dataRow('Default', 'Yes — used when no policy specified'),
            ],
          )),
      infoCard(
          'OrderedTraversalPolicy',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Uses mixin', 'Yes'),
              dataRow('Tab order', 'Explicit FocusOrder widgets'),
              dataRow('Arrow keys', 'Spatial nearest neighbor'),
              dataRow('Use case', 'Custom tab order with arrow support'),
            ],
          )),
      infoCard(
          'WidgetOrderTraversalPolicy',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Uses mixin', 'Yes'),
              dataRow('Tab order', 'Widget tree order'),
              dataRow('Arrow keys', 'Spatial nearest neighbor'),
              dataRow('Use case', 'Simple widget-tree-based order'),
            ],
          )),
    ],
  );

  // ─── Section 9: TV / Game Controller Input ───
  print('[Section 9] TV and Game Controller');

  final section9 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('09', 'TV & Game Controller Input'),
      noteBox(
          'Directional focus is essential for TV apps and game UIs where '
          'the only input is a D-pad or joystick. Every focusable element '
          'must be reachable via directional navigation.'),
      infoCard(
          'TV Remote Layout',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  focusCell('Home', true, fuchsia),
                  focusCell('Movies', false, magenta),
                  focusCell('Shows', false, magenta),
                  focusCell('Search', false, magenta),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  focusCell('Poster 1', false, magenta),
                  focusCell('Poster 2', false, magenta),
                  focusCell('Poster 3', false, magenta),
                  focusCell('Poster 4', false, magenta),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  focusCell('Poster 5', false, magenta),
                  focusCell('Poster 6', false, magenta),
                  focusCell('Poster 7', false, magenta),
                  focusCell('Poster 8', false, magenta),
                ],
              ),
              const SizedBox(height: 6),
              dataRow('D-pad down', 'Home tab row → Poster row'),
              dataRow('D-pad right', 'Home → Movies (same row)'),
              dataRow('Select button', 'Activate focused item'),
            ],
          )),
      infoCard(
          'Game UI',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Inventory grid', 'Arrow keys move between slots'),
              dataRow('Menu list', 'Up/down to browse items'),
              dataRow('Dialog choices', 'Left/right to select option'),
              dataRow('HUD elements', 'Directional navigation to icons'),
            ],
          )),
    ],
  );

  // ─── Section 10: Form Navigation ───
  print('[Section 10] Form Navigation');

  final section10 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('10', 'Form Navigation'),
      noteBox(
          'Complex forms benefit from directional navigation. Users can '
          'move between columns with left/right and between rows with '
          'up/down, in addition to Tab for sequential order.'),
      infoCard(
          'Two-Column Form',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(child: focusCell('First Name', false, magenta)),
                  Expanded(child: focusCell('Last Name', false, magenta)),
                ],
              ),
              Row(
                children: [
                  Expanded(child: focusCell('Email', true, fuchsia)),
                  Expanded(child: focusCell('Phone', false, magenta)),
                ],
              ),
              Row(
                children: [
                  Expanded(child: focusCell('Address', false, magenta)),
                  Expanded(child: focusCell('City', false, magenta)),
                ],
              ),
              const SizedBox(height: 6),
              dataRow('Tab from Email', '→ Phone (linear)'),
              dataRow('Arrow-right from Email', '→ Phone (directional)'),
              dataRow('Arrow-up from Email', '→ First Name (spatial)'),
              dataRow('Arrow-down from Email', '→ Address (spatial)'),
            ],
          )),
    ],
  );

  // ─── Section 11: Custom Policies ───
  print('[Section 11] Custom Policies');

  final section11 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('11', 'Custom Policies'),
      noteBox(
          'You can create a custom FocusTraversalPolicy that uses this '
          'mixin. Override the directional methods if the default spatial '
          'algorithm doesn\'t fit your layout.'),
      infoCard(
          'Creating a Custom Policy',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Step 1', 'Extend FocusTraversalPolicy'),
              dataRow('Step 2', 'Mix in DirectionalFocusTraversalPolicyMixin'),
              dataRow('Step 3', 'Override sortDescendants (Tab order)'),
              dataRow('Step 4', 'Optionally override directional methods'),
            ],
          )),
      infoCard(
          'Override Scenarios',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Circular grids', 'Polar coordinate distance'),
              dataRow('Hex layouts', 'Hexagonal neighbor detection'),
              dataRow('Wrap-around', 'Right from last → first in row'),
              dataRow('Skip disabled', 'Skip non-interactive widgets'),
            ],
          )),
    ],
  );

  // ─── Section 12: Scope Boundaries ───
  print('[Section 12] Scope Boundaries');

  final section12 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('12', 'Scope Boundaries'),
      noteBox(
          'FocusTraversalGroup creates scope boundaries. Directional '
          'navigation only considers nodes within the same group by '
          'default. This prevents arrow keys from jumping to unrelated '
          'UI regions.'),
      infoCard(
          'Scope Behavior',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Within group', 'Free directional movement'),
              dataRow('Cross group', 'Blocked by default'),
              dataRow('Nested groups', 'Inner group is self-contained'),
              dataRow('Focus escape', 'Tab can exit group, arrows cannot'),
            ],
          )),
      infoCard(
          'Example Layout',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.only(bottom: 6),
                decoration: BoxDecoration(
                  border: Border.all(color: magenta, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Group A: Navigation Bar',
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: magenta)),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        focusCell('Nav 1', false, magenta),
                        focusCell('Nav 2', false, magenta),
                        focusCell('Nav 3', false, magenta),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: orchid, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Group B: Content Grid',
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: orchid)),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        focusCell('Item 1', true, fuchsia),
                        focusCell('Item 2', false, orchid),
                      ],
                    ),
                    Row(
                      children: [
                        focusCell('Item 3', false, orchid),
                        focusCell('Item 4', false, orchid),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              dataRow('Arrow-up from Item 1', 'Stays in Group B (no exit)'),
            ],
          )),
    ],
  );

  // ─── Section 13: Accessibility ───
  print('[Section 13] Accessibility');

  final section13 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('13', 'Accessibility'),
      noteBox(
          'Directional focus is a key accessibility feature. Screen reader '
          'users and keyboard-only users depend on predictable arrow key '
          'behavior to navigate spatial layouts.'),
      infoCard(
          'Accessibility Requirements',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('WCAG 2.1.1', 'All functionality via keyboard'),
              dataRow('WCAG 2.4.3', 'Meaningful focus order'),
              dataRow('Direction intuitive', 'Matches visual layout'),
              dataRow('No focus traps', 'Always escapable'),
            ],
          )),
      infoCard(
          'Screen Reader Behavior',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('VoiceOver', 'Arrow keys move between elements'),
              dataRow('TalkBack', 'Swipe gestures map to directions'),
              dataRow('NVDA/JAWS', 'Arrow keys in forms mode'),
              dataRow('Focus announcement', 'New element name spoken'),
            ],
          )),
    ],
  );

  // ─── Section 14: Performance ───
  print('[Section 14] Performance');

  final section14 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('14', 'Performance'),
      noteBox(
          'The spatial search examines all focusable nodes in the group. '
          'For small groups this is instant, but very large groups (1000+ '
          'nodes) may need optimization.'),
      infoCard(
          'Complexity Analysis',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Time complexity', 'O(n) per directional request'),
              dataRow('n = ', 'Focusable nodes in group'),
              dataRow('10 nodes', 'Negligible (< 0.1ms)'),
              dataRow('100 nodes', 'Fast (< 1ms)'),
              dataRow('1000 nodes', 'Potentially noticeable (few ms)'),
            ],
          )),
      infoCard(
          'Optimization Strategies',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              progressBar('Smaller groups', 0.90, magenta),
              progressBar('Lazy focus nodes', 0.70, fuchsia),
              progressBar('Viewport culling', 0.60, orchid),
              progressBar('Spatial indexing', 0.40, violet),
            ],
          )),
    ],
  );

  // ─── Section 15: Testing ───
  print('[Section 15] Testing');

  final section15 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('15', 'Testing'),
      noteBox(
          'Testing directional focus requires simulating arrow key events '
          'and verifying that focus lands on the expected node based on '
          'spatial layout.'),
      infoCard(
          'Test Approach',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Build grid', 'Create grid of Focus + focusable'),
              dataRow('Set initial focus', 'Focus specific node'),
              dataRow('Send arrow key', 'simulateKeyDownEvent(LogicalKeyboardKey.arrowRight)'),
              dataRow('Verify focus', 'Check which FocusNode has focus'),
            ],
          )),
      infoCard(
          'Test Scenarios',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Same row right', 'Focus moves to adjacent cell'),
              dataRow('Same column down', 'Focus moves to cell below'),
              dataRow('Edge of grid', 'Focus stays (no movement)'),
              dataRow('Irregular layout', 'Nearest neighbor in direction'),
              dataRow('Empty direction', 'No candidate — focus unchanged'),
            ],
          )),
    ],
  );

  // ─── Section 16: Visual Dashboard ───
  print('[Section 16] Visual Dashboard');

  final section16 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('16', 'Visual Dashboard'),
      noteBox('Complete overview of the DirectionalFocusTraversalPolicyMixin deep demo.'),
      infoCard(
          'Demo Color Palette',
          Wrap(
            children: [
              colorSwatch('Magenta', magenta),
              colorSwatch('Fuchsia', fuchsia),
              colorSwatch('Deep Mag.', deepMagenta),
              colorSwatch('Pale Lav.', paleLavender),
              colorSwatch('Orchid', orchid),
              colorSwatch('Thistle', thistle),
              colorSwatch('Plum', plum),
              colorSwatch('Heather', heather),
              colorSwatch('Violet', violet),
              colorSwatch('Mulberry', mulberry),
            ],
          )),
      infoCard(
          'Section Coverage',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              progressBar('Overview', 1.0, magenta),
              progressBar('Linear vs Directional', 1.0, fuchsia),
              progressBar('Spatial Algorithm', 1.0, orchid),
              progressBar('Grid Navigation', 1.0, violet),
              progressBar('Distance Calculation', 1.0, magenta),
              progressBar('Mixin Methods', 1.0, fuchsia),
              progressBar('Framework Integration', 1.0, orchid),
              progressBar('Built-in Policies', 1.0, violet),
              progressBar('TV & Game Controller', 1.0, magenta),
              progressBar('Form Navigation', 1.0, fuchsia),
              progressBar('Custom Policies', 1.0, orchid),
              progressBar('Scope Boundaries', 1.0, violet),
              progressBar('Accessibility', 1.0, magenta),
              progressBar('Performance', 1.0, fuchsia),
              progressBar('Testing', 1.0, orchid),
              progressBar('Dashboard', 1.0, violet),
            ],
          )),
      infoCard(
          'Statistics',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Total sections', '16'),
              dataRow('Theme', 'Magenta / Fuchsia'),
              dataRow('Palette colors', '10'),
            ],
          )),
      Wrap(
        spacing: 6,
        runSpacing: 4,
        children: [
          tag('DirectionalFocus', magenta, Colors.white),
          tag('Arrow Navigation', fuchsia, Colors.white),
          tag('Spatial Algorithm', orchid, Colors.white),
          tag('Grid Layout', violet, Colors.white),
          tag('Accessibility', mulberry, Colors.white),
          tag('TV / D-pad', plum, Colors.white),
        ],
      ),
    ],
  );

  print('===== END DIRECTIONAL FOCUS TRAVERSAL POLICY MIXIN DEEP DEMO =====');

  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        section1,
        section2,
        section3,
        section4,
        section5,
        section6,
        section7,
        section8,
        section9,
        section10,
        section11,
        section12,
        section13,
        section14,
        section15,
        section16,
      ],
    ),
  );
}
