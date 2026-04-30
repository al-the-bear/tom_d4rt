// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
// D4rt test script: Deep Demo — FixedExtentScrollPhysics
// Demonstrates FixedExtentScrollPhysics, a ScrollPhysics subclass
// that always snaps the scroll position to item boundaries.
// Covers snapping mechanics, how it works with FixedExtentScroll-
// Controller and ListWheelScrollView, comparison with other
// physics types, the scroll simulation pipeline, and practical
// patterns for wheel-style scrollables.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('FixedExtentScrollPhysics Deep Demo executing');

  // ============================================================
  // SECTION 1: What is FixedExtentScrollPhysics?
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.local_attraction,
      'title': 'Snap-to-Item Physics',
      'body': 'FixedExtentScrollPhysics is a ScrollPhysics that '
          'always settles on an item boundary. When the user '
          'finishes a scroll gesture, the physics simulation '
          'ensures the scroll lands exactly at an item center — '
          'never between items.',
      'accent': Colors.green[700]!,
    },
    {
      'icon': Icons.precision_manufacturing,
      'title': 'The "Fixed Extent" Guarantee',
      'body': 'Every child has the same height (the "item extent"). '
          'This constraint is what makes snapping possible — the '
          'physics knows that valid positions are 0, itemExtent, '
          '2×itemExtent, etc. Any position between is invalid.',
      'accent': Colors.lightGreen[700]!,
    },
    {
      'icon': Icons.rotate_90_degrees_cw,
      'title': 'Used by ListWheelScrollView Automatically',
      'body': 'ListWheelScrollView applies FixedExtentScrollPhysics '
          'by default. You rarely need to specify it manually. But '
          'understanding it helps when customizing scroll behavior, '
          'building custom wheel widgets, or debugging snap issues.',
      'accent': Colors.green[600]!,
    },
    {
      'icon': Icons.settings_suggest,
      'title': 'Extends ScrollPhysics',
      'body': 'FixedExtentScrollPhysics is a standard ScrollPhysics '
          'subclass. It inherits the parent chaining mechanism, '
          'meaning it can be composed with other physics via the '
          'parent parameter (though this is rarely needed).',
      'accent': Colors.lightGreen[600]!,
    },
  ];

  print('  Prepared ${conceptCards.length} concept cards');

  // ============================================================
  // SECTION 2: How Snapping Works
  // ============================================================
  print('=== Section 2: Snapping Mechanics ===');

  final snapSteps = <Map<String, dynamic>>[
    {
      'step': '1',
      'label': 'User Scrolls',
      'color': Colors.green[400]!,
      'detail': 'The user drags or flings the wheel. The scroll '
          'position is at some arbitrary pixel value, likely '
          'between two items. For example, position might be '
          '127.4px with itemExtent 50px.',
    },
    {
      'step': '2',
      'label': 'Gesture Ends',
      'color': Colors.green[500]!,
      'detail': 'The user lifts their finger. The framework asks '
          'the physics for a simulation: createBallisticSimulation(). '
          'The current velocity and position are passed in.',
    },
    {
      'step': '3',
      'label': 'Target Item Calculated',
      'color': Colors.lightGreen[600]!,
      'detail': 'FixedExtentScrollPhysics calculates the nearest '
          'item boundary. With position 127.4px and extent 50px, '
          'the nearest items are index 2 (100px) and index 3 '
          '(150px). Based on velocity and proximity, it picks 3.',
    },
    {
      'step': '4',
      'label': 'Spring Simulation Created',
      'color': Colors.green[600]!,
      'detail': 'A SpringSimulation is created to animate from the '
          'current position (127.4px) to the target item boundary '
          '(150.0px). The spring parameters come from the '
          'ScrollSpringDescription in the physics.',
    },
    {
      'step': '5',
      'label': 'Animation Runs',
      'color': Colors.green[700]!,
      'detail': 'The spring simulation drives the scroll position '
          'from 127.4px to 150.0px over several frames. It may '
          'overshoot slightly and settle (spring behavior). Each '
          'frame, the position updates and the UI repaints.',
    },
    {
      'step': '6',
      'label': 'Snap Complete',
      'color': Colors.green[800]!,
      'detail': 'The simulation completes when the velocity is near '
          'zero and the position is within tolerance of the target '
          '(150.0px). Item 3 is now perfectly centered. '
          'onSelectedItemChanged fires if it changed.',
    },
  ];

  print('  Prepared ${snapSteps.length} snap steps');

  // ============================================================
  // SECTION 3: Comparison with Other Physics
  // ============================================================
  print('=== Section 3: Physics Comparison ===');

  final physicsTypes = <Map<String, dynamic>>[
    {
      'name': 'FixedExtentScrollPhysics',
      'icon': Icons.local_attraction,
      'color': Colors.green[600]!,
      'snaps': true,
      'bounces': false,
      'clamps': false,
      'description': 'Snaps to item boundaries. Designed for wheel '
          'scrollables. Always settles on an exact item position.',
      'highlight': true,
    },
    {
      'name': 'BouncingScrollPhysics',
      'icon': Icons.sports_basketball,
      'color': Colors.orange[600]!,
      'snaps': false,
      'bounces': true,
      'clamps': false,
      'description': 'iOS-style physics. Allows overscroll with '
          'elastic bounce-back. Stops at any position — no snapping.',
      'highlight': false,
    },
    {
      'name': 'ClampingScrollPhysics',
      'icon': Icons.block,
      'color': Colors.blue[600]!,
      'snaps': false,
      'bounces': false,
      'clamps': true,
      'description': 'Android-style physics. Hard stop at scroll '
          'boundaries with glow effect. Stops at any position.',
      'highlight': false,
    },
    {
      'name': 'PageScrollPhysics',
      'icon': Icons.auto_stories,
      'color': Colors.purple[600]!,
      'snaps': true,
      'bounces': false,
      'clamps': false,
      'description': 'Snaps to page boundaries (viewport-sized). '
          'Similar concept to FixedExtent but pages can be different '
          'sizes. Used by PageView.',
      'highlight': false,
    },
    {
      'name': 'NeverScrollableScrollPhysics',
      'icon': Icons.lock,
      'color': Colors.grey[600]!,
      'snaps': false,
      'bounces': false,
      'clamps': false,
      'description': 'Disables user scrolling entirely. The scroll '
          'view cannot be scrolled by touch. Only programmatic '
          'scrolling works.',
      'highlight': false,
    },
  ];

  print('  Prepared ${physicsTypes.length} physics types');

  // ============================================================
  // SECTION 4: The Scroll Simulation Pipeline
  // ============================================================
  print('=== Section 4: Simulation Pipeline ===');

  final pipeline = <Map<String, dynamic>>[
    {
      'name': 'ScrollPhysics.createBallisticSimulation()',
      'icon': Icons.input,
      'color': Colors.green[500]!,
      'description': 'Entry point. Called when user lifts finger. '
          'Receives ScrollMetrics (position, velocity, bounds). '
          'FixedExtentScrollPhysics overrides this.',
    },
    {
      'name': 'Calculate target item',
      'icon': Icons.calculate,
      'color': Colors.green[600]!,
      'description': 'Uses FixedExtentMetrics.itemIndex to determine '
          'the nearest item. Considers the velocity: a fast fling '
          'can skip to a further item even if a closer one exists.',
    },
    {
      'name': 'Compute target pixel offset',
      'icon': Icons.compare_arrows,
      'color': Colors.lightGreen[600]!,
      'description': 'Multiplies the target item index by the item '
          'extent to get the exact pixel position. This is the '
          'scroll offset where the item is perfectly centered.',
    },
    {
      'name': 'Create SpringSimulation',
      'icon': Icons.architecture,
      'color': Colors.green[700]!,
      'description': 'Creates a spring simulation from current '
          'position to target. The spring constant determines how '
          'quickly it snaps. Default spring is critically damped — '
          'no oscillation.',
    },
    {
      'name': 'ScrollPosition.applyPhysicsToUserOffset()',
      'icon': Icons.touch_app,
      'color': Colors.lightGreen[700]!,
      'description': 'During active dragging, this translates user '
          'finger movement to scroll offset. FixedExtentScrollPhysics '
          'does NOT snap during the drag — only after release.',
    },
  ];

  print('  Prepared ${pipeline.length} pipeline stages');

  // ============================================================
  // SECTION 5: Key Methods
  // ============================================================
  print('=== Section 5: Key Methods ===');

  final methods = <Map<String, dynamic>>[
    {
      'name': 'createBallisticSimulation',
      'retn': 'Simulation?',
      'icon': Icons.rocket_launch,
      'color': Colors.green[600]!,
      'bgColor': Colors.green[50]!,
      'description': 'The core override. Creates the spring simulation '
          'that snaps to the nearest item boundary after the user '
          'releases. Returns null if already at an item boundary '
          'and velocity is zero (no animation needed).',
    },
    {
      'name': 'applyPhysicsToUserOffset',
      'retn': 'double',
      'icon': Icons.pan_tool,
      'color': Colors.lightGreen[600]!,
      'bgColor': Colors.lightGreen[50]!,
      'description': 'Inherited from ScrollPhysics. Translates raw '
          'finger movement into scroll offset during active drag. '
          'FixedExtent does not override this — dragging is smooth '
          'and unrestricted.',
    },
    {
      'name': 'applyBoundaryConditions',
      'retn': 'double',
      'icon': Icons.fence,
      'color': Colors.green[700]!,
      'bgColor': Colors.green[50]!,
      'description': 'Determines behavior at scroll boundaries (start '
          'and end of list). FixedExtent delegates to its parent '
          'physics for boundary behavior.',
    },
    {
      'name': 'copyWith({ScrollPhysics? parent})',
      'retn': 'FixedExtentScrollPhysics',
      'icon': Icons.copy,
      'color': Colors.lightGreen[700]!,
      'bgColor': Colors.lightGreen[50]!,
      'description': 'Creates a copy with an optional new parent. '
          'Used by the framework to chain physics together. Part '
          'of the ScrollPhysics composition pattern.',
    },
  ];

  print('  Prepared ${methods.length} methods');

  // ============================================================
  // SECTION 6: FixedExtentMetrics
  // ============================================================
  print('=== Section 6: FixedExtentMetrics ===');

  final metricsFields = <Map<String, dynamic>>[
    {
      'name': 'itemIndex',
      'type': 'int',
      'icon': Icons.tag,
      'color': Colors.green[600]!,
      'description': 'The index of the currently centered item '
          '(or the item the scroll is nearest to while scrolling). '
          'This is the key addition over regular ScrollMetrics.',
    },
    {
      'name': 'pixels',
      'type': 'double',
      'icon': Icons.straighten,
      'color': Colors.lightGreen[600]!,
      'description': 'Inherited from ScrollMetrics. The raw pixel '
          'offset. For item 5 with extent 50, this is 250.0 '
          '(± some decimal while mid-scroll).',
    },
    {
      'name': 'minScrollExtent',
      'type': 'double',
      'icon': Icons.first_page,
      'color': Colors.green[500]!,
      'description': 'The minimum scroll offset (usually 0.0). '
          'Scrolling beyond this hits the top boundary.',
    },
    {
      'name': 'maxScrollExtent',
      'type': 'double',
      'icon': Icons.last_page,
      'color': Colors.lightGreen[700]!,
      'description': 'The maximum scroll offset based on total items '
          'and viewport size. Scrolling beyond this hits the bottom.',
    },
    {
      'name': 'viewportDimension',
      'type': 'double',
      'icon': Icons.crop_free,
      'color': Colors.green[700]!,
      'description': 'Height of the visible viewport. Determines how '
          'many items are visible simultaneously on the wheel.',
    },
  ];

  print('  Prepared ${metricsFields.length} metrics fields');

  // ============================================================
  // SECTION 7: Real-World Patterns
  // ============================================================
  print('=== Section 7: Real-World Patterns ===');

  final patterns = <Map<String, dynamic>>[
    {
      'title': 'Custom Snap Wheel',
      'icon': Icons.view_carousel,
      'color': Colors.green[600]!,
      'body': 'When building a custom scrollable (not using '
          'ListWheelScrollView), apply FixedExtentScrollPhysics '
          'manually via the physics parameter. Ensure your scroll '
          'view provides FixedExtentMetrics for correct snapping.',
    },
    {
      'title': 'Horizontal Wheel Picker',
      'icon': Icons.swap_horiz,
      'color': Colors.lightGreen[600]!,
      'body': 'FixedExtentScrollPhysics works with any axis. Use '
          'a RotatedBox around ListWheelScrollView or build a '
          'custom horizontal scrollable with this physics for '
          'horizontal value selection.',
    },
    {
      'title': 'Disabled Snapping Region',
      'icon': Icons.not_interested,
      'color': Colors.green[700]!,
      'body': 'Sometimes you want snapping except in one region. '
          'Subclass FixedExtentScrollPhysics and override '
          'createBallisticSimulation to return a non-snapping '
          'simulation when in the disabled region.',
    },
    {
      'title': 'Haptic Feedback on Snap',
      'icon': Icons.vibration,
      'color': Colors.lightGreen[700]!,
      'body': 'Use onSelectedItemChanged on ListWheelScrollView to '
          'trigger haptic feedback every time the physics snaps to '
          'a new item. This creates the satisfying "click" feeling '
          'of physical dials.',
    },
    {
      'title': 'Chained Physics',
      'icon': Icons.link,
      'color': Colors.green[800]!,
      'body': 'Compose FixedExtentScrollPhysics with a parent like '
          'BouncingScrollPhysics for elastic overscroll at the '
          'boundaries while still snapping between items: '
          'FixedExtentScrollPhysics(parent: BouncingScrollPhysics()).',
    },
  ];

  print('  Prepared ${patterns.length} real-world patterns');

  // ============================================================
  // SECTION 8: Customizing Snap Behavior
  // ============================================================
  print('=== Section 8: Customizing Snap Behavior ===');

  final customizations = <Map<String, dynamic>>[
    {
      'name': 'Spring Stiffness',
      'icon': Icons.tune,
      'color': Colors.green[500]!,
      'description': 'The snap speed is controlled by the spring '
          'description in ScrollPhysics. A stiffer spring means '
          'faster snapping. Override spring property to customize.',
      'example': 'SpringDescription(\n'
          '  mass: 0.5,\n'
          '  stiffness: 100.0,\n'
          '  damping: 1.0,\n'
          ')',
    },
    {
      'name': 'Tolerance',
      'icon': Icons.straighten,
      'color': Colors.lightGreen[600]!,
      'description': 'ScrollPhysics.toleranceFor() determines when '
          'the simulation is "close enough" to stop. Override '
          'toleranceFor() for tighter or looser snap precision.',
      'example': 'Tolerance(\n'
          '  distance: 0.01,  // 0.01 pixel\n'
          '  velocity: 0.01,  // 0.01 px/s\n'
          ')',
    },
    {
      'name': 'Velocity Threshold',
      'icon': Icons.speed,
      'color': Colors.green[600]!,
      'description': 'Override createBallisticSimulation to apply '
          'a velocity threshold: if the user flings quickly, jump '
          'multiple items instead of just one. Standard behavior '
          'considers proximity + velocity together.',
      'example': 'if (velocity.abs() > 2000) {\n'
          '  // skip 3 items in fling direction\n'
          '}',
    },
    {
      'name': 'Directional Bias',
      'icon': Icons.arrow_forward,
      'color': Colors.lightGreen[700]!,
      'description': 'The default rounds to the nearest item. Override '
          'to always snap forward (next item in scroll direction) '
          'instead of nearest. Useful for one-way selection wheels.',
      'example': '// Always snap to next item in drag direction\n'
          'final target = velocity >= 0\n'
          '  ? nextItem : previousItem;',
    },
  ];

  print('  Prepared ${customizations.length} customizations');

  // ============================================================
  // SECTION 9: Tips & Gotchas
  // ============================================================
  print('=== Section 9: Tips & Gotchas ===');

  final tips = <Map<String, dynamic>>[
    {
      'icon': Icons.warning_amber,
      'title': 'Requires FixedExtentMetrics',
      'body': 'FixedExtentScrollPhysics only works correctly when '
          'the scroll position provides FixedExtentMetrics. Using '
          'it with a regular ListView will not snap because '
          'ListView does not provide item extent information.',
      'severity': 'warning',
    },
    {
      'icon': Icons.lightbulb_outline,
      'title': 'ListWheelScrollView Applies It Automatically',
      'body': 'You almost never need to pass FixedExtentScrollPhysics '
          'explicitly. ListWheelScrollView and CupertinoPicker apply '
          'it by default. Only specify it if you have a custom '
          'scrollable or need to chain with other physics.',
      'severity': 'info',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Snapping Is Only After Release',
      'body': 'During an active drag (finger still on screen), the '
          'scroll moves freely — no snapping. Snapping occurs only in '
          'the ballistic phase (after the user lifts their finger). '
          'This is by design for smooth UX.',
      'severity': 'tip',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'Very Fast Flings Can Feel Odd',
      'body': 'A very fast fling can overshoot the target and then '
          'the spring pulls it back. This is normal but can feel '
          'unexpected. Adjust the spring constants if the overshoot '
          'is too pronounced.',
      'severity': 'warning',
    },
    {
      'icon': Icons.lightbulb_outline,
      'title': 'Fractional Item Indices During Scroll',
      'body': 'While the user is actively scrolling, the scroll '
          'position can be between items. FixedExtentMetrics.itemIndex '
          'rounds to the nearest item. The decimal part is lost. '
          'For fractional values, use pixels / itemExtent.',
      'severity': 'info',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Test with Slow Scrolling',
      'body': 'The most common bug is a very slow release that barely '
          'moves the finger. Ensure the physics still snaps even for '
          'near-zero velocity. The default implementation handles '
          'this, but custom overrides might miss it.',
      'severity': 'tip',
    },
  ];

  print('  Prepared ${tips.length} tips');

  // ============================================================
  // BUILD THE VISUAL LAYOUT
  // ============================================================
  print('=== Building visual layout ===');

  return Scaffold(
    backgroundColor: Colors.grey[50],
    appBar: AppBar(
      title: Text('FixedExtentScrollPhysics'),
      backgroundColor: Colors.green[700],
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header banner ──
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green[700]!, Colors.lightGreen[600]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.local_attraction, color: Colors.white, size: 40),
                SizedBox(height: 12),
                Text(
                  'FixedExtentScrollPhysics',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Scroll physics that always snaps to item '
                  'boundaries — the engine behind wheel pickers '
                  'and CupertinoPicker\'s satisfying settle.',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 24),

          // ── Section 1: Concept ──
          _secHead('1', 'What is FixedExtentScrollPhysics?'),
          SizedBox(height: 12),
          ...conceptCards.map((card) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: card['accent'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(card['icon'] as IconData,
                            color: card['accent'] as Color, size: 22),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(card['title'] as String,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[900])),
                        ),
                      ]),
                      SizedBox(height: 10),
                      Text(card['body'] as String,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[700],
                              height: 1.5)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 2: Snapping Steps ──
          _secHead('2', 'How Snapping Works'),
          SizedBox(height: 12),
          ...snapSteps.map((step) => Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: step['color'] as Color,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(step['step'] as String,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13)),
                        ),
                      ),
                      Container(
                          width: 2, height: 28, color: Colors.grey[300]),
                    ]),
                    SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 2,
                                offset: Offset(0, 1))
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(step['label'] as String,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13)),
                            SizedBox(height: 6),
                            Text(step['detail'] as String,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[700],
                                    height: 1.4)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),

          SizedBox(height: 24),

          // ── Section 3: Comparison ──
          _secHead('3', 'Comparison with Other Physics'),
          SizedBox(height: 12),
          ...physicsTypes.map((pt) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: (pt['highlight'] as bool)
                        ? (pt['color'] as Color).withOpacity(0.08)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: (pt['highlight'] as bool)
                          ? (pt['color'] as Color).withOpacity(0.5)
                          : Colors.grey[200]!,
                      width: (pt['highlight'] as bool) ? 2 : 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(pt['icon'] as IconData,
                            color: pt['color'] as Color, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(pt['name'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  fontFamily: 'monospace')),
                        ),
                        if (pt['highlight'] as bool)
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 6, vertical: 1),
                            decoration: BoxDecoration(
                              color: pt['color'] as Color,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text('this demo',
                                style: TextStyle(
                                    fontSize: 8,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ),
                      ]),
                      SizedBox(height: 6),
                      Row(children: [
                        _physBadge('snaps', pt['snaps'] as bool),
                        SizedBox(width: 6),
                        _physBadge('bounces', pt['bounces'] as bool),
                        SizedBox(width: 6),
                        _physBadge('clamps', pt['clamps'] as bool),
                      ]),
                      SizedBox(height: 8),
                      Text(pt['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 4: Simulation Pipeline ──
          _secHead('4', 'The Scroll Simulation Pipeline'),
          SizedBox(height: 12),
          ...pipeline.map((p) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: p['color'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(p['icon'] as IconData,
                            color: p['color'] as Color, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(p['name'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  fontFamily: 'monospace')),
                        ),
                      ]),
                      SizedBox(height: 6),
                      Text(p['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 5: Key Methods ──
          _secHead('5', 'Key Methods'),
          SizedBox(height: 12),
          ...methods.map((m) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: m['bgColor'] as Color,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: (m['color'] as Color).withOpacity(0.4)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: m['color'] as Color,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(m['icon'] as IconData,
                              color: Colors.white, size: 18),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(m['name'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  fontFamily: 'monospace',
                                  color: m['color'] as Color)),
                        ),
                        Text('→ ${m['retn']}',
                            style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey[500],
                                fontFamily: 'monospace')),
                      ]),
                      SizedBox(height: 8),
                      Text(m['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[800],
                              height: 1.4)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 6: FixedExtentMetrics ──
          _secHead('6', 'FixedExtentMetrics'),
          SizedBox(height: 12),
          ...metricsFields.map((f) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border(
                      left: BorderSide(
                          color: f['color'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 2,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(f['icon'] as IconData,
                            color: f['color'] as Color, size: 18),
                        SizedBox(width: 8),
                        Text('.${f['name']}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                fontFamily: 'monospace',
                                color: f['color'] as Color)),
                        Spacer(),
                        Text(f['type'] as String,
                            style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey[500],
                                fontFamily: 'monospace')),
                      ]),
                      SizedBox(height: 6),
                      Text(f['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 7: Real-World Patterns ──
          _secHead('7', 'Real-World Patterns'),
          SizedBox(height: 12),
          ...patterns.map((p) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: p['color'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(p['icon'] as IconData,
                            color: p['color'] as Color, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(p['title'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14)),
                        ),
                      ]),
                      SizedBox(height: 8),
                      Text(p['body'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 8: Customizations ──
          _secHead('8', 'Customizing Snap Behavior'),
          SizedBox(height: 12),
          ...customizations.map((c) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: c['color'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(c['icon'] as IconData,
                            color: c['color'] as Color, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(c['name'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14)),
                        ),
                      ]),
                      SizedBox(height: 8),
                      Text(c['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                      SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: (c['color'] as Color).withOpacity(0.06),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(c['example'] as String,
                            style: TextStyle(
                                fontSize: 11,
                                fontFamily: 'monospace',
                                color: Colors.grey[700],
                                height: 1.4)),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 9: Tips ──
          _secHead('9', 'Tips, Pitfalls & Gotchas'),
          SizedBox(height: 12),
          ...tips.map((tip) {
            Color bgColor;
            Color borderColor;
            switch (tip['severity']) {
              case 'warning':
                bgColor = Colors.amber[50]!;
                borderColor = Colors.amber[400]!;
                break;
              case 'tip':
                bgColor = Colors.green[50]!;
                borderColor = Colors.green[400]!;
                break;
              default:
                bgColor = Colors.blue[50]!;
                borderColor = Colors.blue[300]!;
            }
            return Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border(
                      left: BorderSide(color: borderColor, width: 4)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Icon(tip['icon'] as IconData,
                          color: borderColor, size: 20),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(tip['title'] as String,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: Colors.grey[900])),
                      ),
                    ]),
                    SizedBox(height: 6),
                    Text(tip['body'] as String,
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[800],
                            height: 1.4)),
                  ],
                ),
              ),
            );
          }),

          SizedBox(height: 32),

          // ── Footer ──
          Center(
            child: Text(
              'End of FixedExtentScrollPhysics Deep Demo',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[400],
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    ),
  );
}

// ──────────────────────────────────────────────────────────
// Helper: Section heading with numbered badge
// ──────────────────────────────────────────────────────────
Widget _secHead(String number, String title) {
  return Row(
    children: [
      Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.green[700],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(number,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14)),
        ),
      ),
      SizedBox(width: 10),
      Expanded(
        child: Text(title,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[900])),
      ),
    ],
  );
}

// ──────────────────────────────────────────────────────────
// Helper: Physics feature badge
// ──────────────────────────────────────────────────────────
Widget _physBadge(String label, bool enabled) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: enabled
          ? Colors.green[50]
          : Colors.grey[100],
      borderRadius: BorderRadius.circular(6),
      border: Border.all(
          color: enabled
              ? Colors.green[400]!
              : Colors.grey[300]!),
    ),
    child: Text(
      '$label: ${enabled ? "yes" : "no"}',
      style: TextStyle(
          fontSize: 10,
          color: enabled ? Colors.green[700] : Colors.grey[600],
          fontWeight: FontWeight.w600),
    ),
  );
}
