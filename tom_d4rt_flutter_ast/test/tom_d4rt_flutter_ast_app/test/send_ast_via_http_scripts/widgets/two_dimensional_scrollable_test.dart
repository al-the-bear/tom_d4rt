// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — TwoDimensionalScrollable
// Demonstrates TwoDimensionalScrollable, the widget that coordinates
// two scroll positions (horizontal + vertical) and routes gestures
// into the 2D viewport. It is the scrolling engine inside
// TwoDimensionalScrollView.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TwoDimensionalScrollable Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptItems = <Map<String, dynamic>>[
    {
      'icon': Icons.swap_horiz,
      'title': 'What is TwoDimensionalScrollable?',
      'body': 'TwoDimensionalScrollable is the state-managing widget '
          'that creates and controls two ScrollPosition objects: '
          'one for the horizontal axis, one for the vertical axis. '
          'It feeds both positions into a viewportBuilder callback.',
      'accent': Colors.teal,
    },
    {
      'icon': Icons.layers,
      'title': 'Layer in the Stack',
      'body': 'TwoDimensionalScrollView \u2192 TwoDimensionalScrollable '
          '\u2192 TwoDimensionalViewport. The scrollable sits in the '
          'middle, accepting user gestures and translating them into '
          'offset changes on both axes.',
      'accent': Colors.indigo,
    },
    {
      'icon': Icons.touch_app,
      'title': 'Gesture Routing',
      'body': 'A single touch gesture may affect one or both axes. The '
          'diagonalDragBehavior property controls whether a drag '
          'moves one axis at a time or both simultaneously.',
      'accent': Colors.deepOrange,
    },
    {
      'icon': Icons.compare_arrows,
      'title': 'Two ScrollPositions',
      'body': 'Unlike normal Scrollable (one position), this creates two '
          'independent positions. Each can have its own controller, '
          'physics, and direction. They are updated independently '
          'based on gesture decomposition.',
      'accent': Colors.purple,
    },
  ];

  final conceptCards = <Widget>[];
  for (var i = 0; i < conceptItems.length; i++) {
    final e = conceptItems[i];
    final accent = e['accent'] as Color;
    print('Concept ${i + 1}: ${e['title']}');
    conceptCards.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [accent.withOpacity(0.12), accent.withOpacity(0.03)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: accent.withOpacity(0.3)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: accent.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(e['icon'] as IconData, color: accent, size: 26),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      e['title'] as String,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: accent,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      e['body'] as String,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade800,
                        height: 1.45,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 2: API
  // ============================================================
  print('=== Section 2: API ===');

  final apiEntries = <Map<String, String>>[
    {
      'name': 'horizontalDetails',
      'type': 'ScrollableDetails',
      'desc': 'Configuration for the horizontal scroll position: controller, '
          'physics, and decoration. The scrollable creates a '
          'ScrollPosition from these details.',
    },
    {
      'name': 'verticalDetails',
      'type': 'ScrollableDetails',
      'desc': 'Configuration for the vertical scroll position. Same '
          'structure but for the vertical axis. Both are required.',
    },
    {
      'name': 'viewportBuilder',
      'type': 'TwoDimensionalViewportBuilder',
      'desc': 'Callback that receives both ViewportOffset objects and '
          'returns a TwoDimensionalViewport widget. The Scrollable '
          'calls this to build the viewport.',
    },
    {
      'name': 'diagonalDragBehavior',
      'type': 'DiagonalDragBehavior',
      'desc': 'Controls how diagonal touch drags are decomposed into '
          'horizontal and vertical offsets.',
    },
    {
      'name': 'incrementCalculator',
      'type': 'TwoDimensionalScrollIncrementCalculator?',
      'desc': 'Optional function that calculates how much to scroll '
          'for keyboard arrow keys and scroll buttons. Returns '
          'an Offset(dx, dy) increment.',
    },
    {
      'name': 'dragStartBehavior',
      'type': 'DragStartBehavior',
      'desc': 'Whether the drag position starts from the point of the '
          'initial down event or the position when the drag threshold '
          'is met. Affects gesture precision.',
    },
  ];

  final apiWidgets = <Widget>[];
  for (var i = 0; i < apiEntries.length; i++) {
    final ae = apiEntries[i];
    print('API ${i + 1}: ${ae['name']}');
    apiWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: i.isEven
              ? Colors.teal.withOpacity(0.06)
              : Colors.grey.withOpacity(0.03),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.teal.withOpacity(0.25)),
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
                    color: Colors.teal.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    ae['name']!,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.teal.shade800,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    ae['type']!,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 10,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              ae['desc']!,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade700,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 3: Dual ScrollPosition
  // ============================================================
  print('=== Section 3: Dual ScrollPosition ===');

  final posTopics = <Map<String, dynamic>>[
    {
      'title': 'Independent Positions',
      'desc': 'Each axis has its own ScrollPosition with separate min/max '
          'extents, current offset, and notification listeners. '
          'Scrolling one axis does not affect the other.',
      'visual': [
        'Horizontal: [====|======]  offset: 120px',
        'Vertical:   [==|========]  offset: 60px',
        '                                         ',
        'Each bar moves independently.',
      ],
      'color': Colors.teal,
    },
    {
      'title': 'Controller Attachment',
      'desc': 'Each position can be controlled by a separate '
          'ScrollController. This allows programmatic scrolling '
          'per axis: jumpTo, animateTo, addListener.',
      'visual': [
        'horizontalCtrl.jumpTo(200)',
        '  \u2192 horizontal position = 200',
        '  \u2192 vertical position unchanged',
        '',
        'verticalCtrl.animateTo(500)',
        '  \u2192 vertical position animates to 500',
        '  \u2192 horizontal position unchanged',
      ],
      'color': Colors.blue,
    },
    {
      'title': 'Physics Per Axis',
      'desc': 'Horizontal and vertical can have different scroll physics. '
          'Example: clamping horizontally (no overscroll) while '
          'bouncing vertically (iOS-style overscroll).',
      'visual': [
        'Horizontal: ClampingScrollPhysics',
        '  \u2192 stops at edge, no bounce',
        '',
        'Vertical: BouncingScrollPhysics',
        '  \u2192 elastic overscroll, spring back',
      ],
      'color': Colors.deepOrange,
    },
  ];

  final posWidgets = <Widget>[];
  for (var i = 0; i < posTopics.length; i++) {
    final pt = posTopics[i];
    final ptColor = pt['color'] as Color;
    final lines = pt['visual'] as List<String>;
    print('Position ${i + 1}: ${pt['title']}');
    posWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: ptColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: ptColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                pt['title'] as String,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: ptColor,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                pt['desc'] as String,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                  height: 1.35,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E2E),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: lines
                      .map((ln) => Text(
                            ln,
                            style: const TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 10,
                              color: Color(0xFFCDD6F4),
                              height: 1.5,
                            ),
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 4: Gesture Flow
  // ============================================================
  print('=== Section 4: Gesture Flow ===');

  final gestureSteps = <Map<String, dynamic>>[
    {
      'step': '1. Touch Down',
      'desc': 'User places finger on screen. RawGestureDetector registers '
          'a potential drag in both directions simultaneously.',
      'icon': Icons.touch_app,
      'color': Colors.teal,
    },
    {
      'step': '2. Direction Detection',
      'desc': 'As the finger moves, the delta is analyzed. The dominant '
          'direction (H or V) is determined based on '
          'diagonalDragBehavior setting.',
      'icon': Icons.explore,
      'color': Colors.blue,
    },
    {
      'step': '3. Delta Decomposition',
      'desc': 'The drag delta (dx, dy) is split according to the behavior: '
          'free mode passes both; none mode zeroes the non-dominant; '
          'weighted modes scale by ratio.',
      'icon': Icons.call_split,
      'color': Colors.deepOrange,
    },
    {
      'step': '4. Position Update',
      'desc': 'Each axis ScrollPosition receives its portion of the delta. '
          'The position applies physics (clamping, bouncing) and '
          'updates its pixel offset.',
      'icon': Icons.system_update_alt,
      'color': Colors.green,
    },
    {
      'step': '5. Viewport Notified',
      'desc': 'Both positions notify their listeners. The viewport '
          'receives the new offsets and relayouts its children, '
          'removing offscreen cells and building new ones.',
      'icon': Icons.notifications_active,
      'color': Colors.purple,
    },
  ];

  final gestureWidgets = <Widget>[];
  for (var i = 0; i < gestureSteps.length; i++) {
    final gs = gestureSteps[i];
    final gsColor = gs['color'] as Color;
    print('Gesture ${i + 1}: ${gs['step']}');
    gestureWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: gsColor.withOpacity(0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    gs['icon'] as IconData,
                    color: gsColor,
                    size: 20,
                  ),
                ),
                if (i < gestureSteps.length - 1)
                  Container(
                    width: 2,
                    height: 30,
                    color: gsColor.withOpacity(0.2),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: gsColor.withOpacity(0.04),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: gsColor.withOpacity(0.15)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      gs['step'] as String,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: gsColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      gs['desc'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade700,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 5: ViewportBuilder
  // ============================================================
  print('=== Section 5: ViewportBuilder ===');

  final vbTopics = <Map<String, dynamic>>[
    {
      'title': 'Builder Callback Signature',
      'desc': 'The viewportBuilder receives a BuildContext and two '
          'ViewportOffset objects (horizontal and vertical). It must '
          'return a TwoDimensionalViewport widget.',
      'code': 'viewportBuilder: (\n'
          '  BuildContext ctx,\n'
          '  ViewportOffset horizontalOffset,\n'
          '  ViewportOffset verticalOffset,\n'
          ') {\n'
          '  return MyTwoDimensionalViewport(\n'
          '    horizontalOffset: horizontalOffset,\n'
          '    verticalOffset: verticalOffset,\n'
          '    delegate: myDelegate,\n'
          '    mainAxis: Axis.vertical,\n'
          '  );\n'
          '}',
      'color': Colors.teal,
    },
    {
      'title': 'ViewportOffset Explained',
      'desc': 'ViewportOffset is the abstract base of ScrollPosition. '
          'It provides .pixels (current offset) and .applyViewportDimension '
          'for the viewport to report its size. The viewport listens '
          'for changes to trigger relayout.',
      'code': '// Inside the Viewport:\n'
          'horizontalOffset.addListener(_onScrollChanged);\n'
          'verticalOffset.addListener(_onScrollChanged);\n'
          '\n'
          'void _onScrollChanged() {\n'
          '  markNeedsLayout();\n'
          '}',
      'color': Colors.blue,
    },
    {
      'title': 'Rebuild Triggers',
      'desc': 'The viewport is rebuilt when: a scroll position changes, '
          'the widget size changes (new constraints), the delegate '
          'changes, or a hot reload occurs. Only visible cells '
          'are rebuilt.',
      'code': '// Rebuilds when:\n'
          '// - horizontalOffset.pixels changes\n'
          '// - verticalOffset.pixels changes\n'
          '// - Size constraints change\n'
          '// - Delegate identity changes',
      'color': Colors.green,
    },
  ];

  final vbWidgets = <Widget>[];
  for (var i = 0; i < vbTopics.length; i++) {
    final vb = vbTopics[i];
    final vbColor = vb['color'] as Color;
    print('ViewportBuilder ${i + 1}: ${vb['title']}');
    vbWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: vbColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: vbColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                vb['title'] as String,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: vbColor,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                vb['desc'] as String,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                  height: 1.35,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E2E),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  vb['code'] as String,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10,
                    color: Color(0xFFCDD6F4),
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 6: Increment Calculator
  // ============================================================
  print('=== Section 6: Increments ===');

  final incrTopics = <Map<String, dynamic>>[
    {
      'title': 'What Are Scroll Increments?',
      'desc': 'When the user presses arrow keys, Page Up/Down, or uses '
          'scroll buttons, the scrollable needs to know how many '
          'pixels to move per step. The incrementCalculator provides '
          'this as an Offset(dx, dy).',
      'icon': Icons.keyboard,
      'color': Colors.teal,
    },
    {
      'title': 'Default Behavior',
      'desc': 'Without a custom calculator, the scrollable uses '
          'standard Material increments: arrow keys move ~50px, '
          'page keys move one viewport extent minus some margin.',
      'icon': Icons.arrow_circle_down,
      'color': Colors.blue,
    },
    {
      'title': 'Custom Calculator',
      'desc': 'For a spreadsheet, you might want arrow keys to move '
          'exactly one cell width/height. The calculator receives '
          'the ScrollIncrementDetails with axis, type (line/page), '
          'and metrics.',
      'icon': Icons.table_chart,
      'color': Colors.deepOrange,
    },
    {
      'title': 'No Keyboard = No Calculator',
      'desc': 'On mobile devices without keyboard, the increment '
          'calculator is never called. It only matters for desktop '
          'and web platforms where keyboard navigation is expected.',
      'icon': Icons.phone_android,
      'color': Colors.grey,
    },
  ];

  final incrWidgets = <Widget>[];
  for (var i = 0; i < incrTopics.length; i++) {
    final ic = incrTopics[i];
    final icColor = ic['color'] as Color;
    print('Increment ${i + 1}: ${ic['title']}');
    incrWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: icColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: icColor.withOpacity(0.2)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: icColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(ic['icon'] as IconData, color: icColor, size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ic['title'] as String,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: icColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    ic['desc'] as String,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade700,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 7: Integration
  // ============================================================
  print('=== Section 7: Integration ===');

  final integrationItems = <Map<String, dynamic>>[
    {
      'title': 'With ScrollControllers',
      'desc': 'Attach separate ScrollControllers to each axis for '
          'programmatic control, listening to offset changes, '
          'and animating to specific positions.',
      'code': 'final hCtrl = ScrollController();\n'
          'final vCtrl = ScrollController();\n'
          '\n'
          'TwoDimensionalScrollView(\n'
          '  horizontalDetails: ScrollableDetails.horizontal(\n'
          '    controller: hCtrl,\n'
          '  ),\n'
          '  verticalDetails: ScrollableDetails.vertical(\n'
          '    controller: vCtrl,\n'
          '  ),\n'
          '  ...\n'
          ')',
      'color': Colors.teal,
    },
    {
      'title': 'With NotificationListener',
      'desc': 'Listen for ScrollNotification from either axis using a '
          'NotificationListener. The notification includes metrics '
          'from the scrolled axis.',
      'code': 'NotificationListener<ScrollNotification>(\n'
          '  onNotification: (notification) {\n'
          '    print(notification.metrics.pixels);\n'
          '    return false;\n'
          '  },\n'
          '  child: myTwoDimScrollView,\n'
          ')',
      'color': Colors.blue,
    },
    {
      'title': 'With Scrollbar',
      'desc': 'Each axis can have its own scrollbar. Wrapping with two '
          'Scrollbar widgets (one horizontal, one vertical) connected '
          'to the respective controllers provides visual feedback.',
      'code': '// Vertical scrollbar\n'
          'Scrollbar(\n'
          '  controller: vCtrl,\n'
          '  child: // Horizontal scrollbar\n'
          '    Scrollbar(\n'
          '      controller: hCtrl,\n'
          '      notificationPredicate: (n) => n.depth == 1,\n'
          '      child: myTwoDimScrollView,\n'
          '    ),\n'
          ')',
      'color': Colors.green,
    },
  ];

  final integrationWidgets = <Widget>[];
  for (var i = 0; i < integrationItems.length; i++) {
    final ii = integrationItems[i];
    final iiColor = ii['color'] as Color;
    print('Integration ${i + 1}: ${ii['title']}');
    integrationWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: iiColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: iiColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ii['title'] as String,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: iiColor,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                ii['desc'] as String,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                  height: 1.35,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E2E),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  ii['code'] as String,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10,
                    color: Color(0xFFCDD6F4),
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 8: Summary
  // ============================================================
  print('=== Section 8: Summary ===');

  final summaryPoints = <Map<String, dynamic>>[
    {
      'icon': Icons.swap_horiz,
      'text': 'TwoDimensionalScrollable manages two independent '
          'ScrollPositions for horizontal and vertical scrolling.',
    },
    {
      'icon': Icons.touch_app,
      'text': 'Gesture routing splits drag deltas between axes based '
          'on the diagonalDragBehavior setting.',
    },
    {
      'icon': Icons.build,
      'text': 'The viewportBuilder callback receives both offsets and '
          'must return a TwoDimensionalViewport.',
    },
    {
      'icon': Icons.keyboard,
      'text': 'incrementCalculator customizes keyboard/button scroll '
          'amounts, defaulting to Material conventions.',
    },
    {
      'icon': Icons.compare_arrows,
      'text': 'Each axis can have independent physics, controllers, '
          'and scroll physics for maximum flexibility.',
    },
    {
      'icon': Icons.layers,
      'text': 'Sits between TwoDimensionalScrollView (user API) and '
          'TwoDimensionalViewport (rendering). The coordination layer.',
    },
  ];

  final summaryWidgets = <Widget>[];
  for (var i = 0; i < summaryPoints.length; i++) {
    final sp = summaryPoints[i];
    print('Summary ${i + 1}: ${(sp['text'] as String).substring(0, 40)}...');
    summaryWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.teal.withOpacity(0.04 + (i % 3) * 0.02),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.teal.withOpacity(0.15)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.teal.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                sp['icon'] as IconData,
                color: Colors.teal.shade800,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                sp['text'] as String,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade800,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // ASSEMBLE TABBED LAYOUT
  // ============================================================
  print('Assembling tabbed layout');

  return DefaultTabController(
    length: 8,
    child: Scaffold(
      appBar: AppBar(
        title: const Text('TwoDimensionalScrollable'),
        backgroundColor: Colors.teal.shade700,
        foregroundColor: Colors.white,
        bottom: const TabBar(
          isScrollable: true,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: [
            Tab(icon: Icon(Icons.info_outline), text: 'Concept'),
            Tab(icon: Icon(Icons.api), text: 'API'),
            Tab(icon: Icon(Icons.compare_arrows), text: 'Positions'),
            Tab(icon: Icon(Icons.touch_app), text: 'Gestures'),
            Tab(icon: Icon(Icons.build), text: 'Builder'),
            Tab(icon: Icon(Icons.keyboard), text: 'Increments'),
            Tab(icon: Icon(Icons.extension), text: 'Integration'),
            Tab(icon: Icon(Icons.summarize), text: 'Summary'),
          ],
        ),
      ),
      body: TabBarView(
        children: [
          // Tab 1 — Concept
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.teal.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'TwoDimensionalScrollable: the engine that manages '
                  'two scroll positions and routes touch gestures.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...conceptCards,
            ],
          ),
          // Tab 2 — API
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.teal.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Constructor parameters and configuration.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...apiWidgets,
            ],
          ),
          // Tab 3 — Dual Positions
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.teal.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'How two independent ScrollPositions are managed.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...posWidgets,
            ],
          ),
          // Tab 4 — Gesture Flow
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.teal.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Step-by-step: from touch to viewport update.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...gestureWidgets,
            ],
          ),
          // Tab 5 — ViewportBuilder
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.teal.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'The viewportBuilder callback that connects the '
                  'scrollable to the viewport.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...vbWidgets,
            ],
          ),
          // Tab 6 — Increments
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.teal.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Keyboard and button scroll increment customization.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...incrWidgets,
            ],
          ),
          // Tab 7 — Integration
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.teal.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Connecting controllers, notifications, and scrollbars.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...integrationWidgets,
            ],
          ),
          // Tab 8 — Summary
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.teal.withOpacity(0.12),
                      Colors.cyan.withOpacity(0.06),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Key takeaways about TwoDimensionalScrollable.',
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              ...summaryWidgets,
            ],
          ),
        ],
      ),
    ),
  );
}
