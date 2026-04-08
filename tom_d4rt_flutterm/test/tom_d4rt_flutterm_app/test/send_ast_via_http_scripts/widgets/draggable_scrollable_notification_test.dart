// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
// D4rt test script: Deep Demo — DraggableScrollableNotification
// Demonstrates DraggableScrollableNotification — the notification
// dispatched by DraggableScrollableSheet when its extent changes.
// Covers notification properties, the sheet lifecycle, listening
// patterns, comparison with ScrollNotification, real-world usage,
// and tips.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DraggableScrollableNotification Deep Demo executing');

  // ============================================================
  // SECTION 1: What is DraggableScrollableNotification?
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.drag_handle,
      'title': 'Sheet Extent Change Notifications',
      'body': 'DraggableScrollableNotification is a notification '
          'dispatched by DraggableScrollableSheet whenever its '
          'extent (the fraction of screen it covers) changes. '
          'It carries the current extent, minExtent, maxExtent, '
          'and initialExtent so listeners can react to sheet '
          'position changes.',
      'accent': Colors.brown[700]!,
    },
    {
      'icon': Icons.notifications_active,
      'title': 'Extends Notification',
      'body': 'It directly extends Notification (not '
          'ScrollNotification). This means it bubbles up the '
          'widget tree just like all notifications, and you catch '
          'it with NotificationListener<'
          'DraggableScrollableNotification>.',
      'accent': Colors.amber[800]!,
    },
    {
      'icon': Icons.height,
      'title': 'Fractional Extents (0.0 to 1.0)',
      'body': 'All extent values are fractions of the parent '
          'height: 0.0 = fully collapsed (zero height), 1.0 = '
          'full screen. The notification reports the current '
          'extent as a fraction, making it easy to compute '
          'percentages and progress.',
      'accent': Colors.brown[600]!,
    },
    {
      'icon': Icons.swap_vert,
      'title': 'Dispatched During Drag & Settle',
      'body': 'Notifications fire during both user-driven drags '
          'and programmatic animations. Even when the sheet snaps '
          'to minExtent or maxExtent after release, each frame '
          'of the settle animation dispatches a notification.',
      'accent': Colors.amber[700]!,
    },
  ];

  print('  Prepared ${conceptCards.length} concept cards');

  // ============================================================
  // SECTION 2: Notification Properties
  // ============================================================
  print('=== Section 2: Properties ===');

  final properties = <Map<String, dynamic>>[
    {
      'name': 'extent',
      'type': 'double',
      'icon': Icons.height,
      'color': Colors.brown[700]!,
      'description': 'The current extent of the sheet as a fraction '
          'of the parent (0.0 to 1.0). This is the main property '
          'you will read. At minExtent the sheet is collapsed, at '
          'maxExtent it covers the maximum allowed area.',
      'key': true,
    },
    {
      'name': 'minExtent',
      'type': 'double',
      'icon': Icons.vertical_align_bottom,
      'color': Colors.amber[700]!,
      'description': 'The minimum extent the sheet can be dragged '
          'to. Matches the minChildSize parameter of '
          'DraggableScrollableSheet (default 0.25). The sheet '
          'cannot go below this value.',
      'key': false,
    },
    {
      'name': 'maxExtent',
      'type': 'double',
      'icon': Icons.vertical_align_top,
      'color': Colors.amber[700]!,
      'description': 'The maximum extent the sheet can be dragged '
          'to. Matches maxChildSize (default 1.0). The sheet '
          'cannot go above this value.',
      'key': false,
    },
    {
      'name': 'initialExtent',
      'type': 'double',
      'icon': Icons.start,
      'color': Colors.brown[600]!,
      'description': 'The initial extent when the sheet first '
          'appeared. Matches initialChildSize (default 0.5). '
          'Useful for calculating how far the user has dragged '
          'from the initial position.',
      'key': false,
    },
    {
      'name': 'context',
      'type': 'BuildContext?',
      'icon': Icons.account_tree,
      'color': Colors.grey[600]!,
      'description': 'The build context of the widget that '
          'dispatched the notification. Inherited from '
          'Notification. Useful for locating the source sheet.',
      'key': false,
    },
  ];

  print('  Prepared ${properties.length} properties');

  // ============================================================
  // SECTION 3: Derived Calculations
  // ============================================================
  print('=== Section 3: Derived Values ===');

  final derived = <Map<String, dynamic>>[
    {
      'name': 'progress (0→1)',
      'formula': '(extent - minExtent) / (maxExtent - minExtent)',
      'icon': Icons.trending_up,
      'color': Colors.brown[700]!,
      'description': 'Normalized progress from fully collapsed (0) '
          'to fully expanded (1). Useful for driving opacity, '
          'scale, or color interpolation.',
      'example': 'min=0.25, max=1.0, extent=0.625 → '
          'progress = (0.625-0.25) / (1.0-0.25) = 0.5',
    },
    {
      'name': 'isAtMin',
      'formula': 'extent <= minExtent',
      'icon': Icons.arrow_downward,
      'color': Colors.amber[800]!,
      'description': 'Whether the sheet is fully collapsed at its '
          'minimum extent. Useful for showing/hiding alternative '
          'UI like a "pull up" indicator.',
      'example': 'extent=0.25, min=0.25 → true',
    },
    {
      'name': 'isAtMax',
      'formula': 'extent >= maxExtent',
      'icon': Icons.arrow_upward,
      'color': Colors.brown[600]!,
      'description': 'Whether the sheet is fully expanded. At this '
          'point the internal scroll content becomes scrollable '
          '(if there\'s overflow) and dragging up no longer '
          'expands the sheet.',
      'example': 'extent=1.0, max=1.0 → true',
    },
    {
      'name': 'pixelExtent',
      'formula': 'extent * parentHeight',
      'icon': Icons.straighten,
      'color': Colors.amber[700]!,
      'description': 'The actual pixel height of the sheet. Multiply '
          'extent by the parent\'s total height (from '
          'MediaQuery.of(context).size.height or LayoutBuilder).',
      'example': 'extent=0.5, parentHeight=800 → 400px',
    },
    {
      'name': 'dragFromInitial',
      'formula': 'extent - initialExtent',
      'icon': Icons.drag_indicator,
      'color': Colors.brown[500]!,
      'description': 'How far the sheet has moved from its initial '
          'position. Positive = expanded beyond initial, negative = '
          'collapsed below initial.',
      'example': 'extent=0.7, initial=0.5 → +0.2 (expanded)',
    },
  ];

  print('  Prepared ${derived.length} derived calculations');

  // ============================================================
  // SECTION 4: Sheet Lifecycle
  // ============================================================
  print('=== Section 4: Sheet Lifecycle ===');

  final lifecycle = <Map<String, dynamic>>[
    {
      'phase': 'Sheet Created',
      'step': 1,
      'icon': Icons.add_circle,
      'color': Colors.brown[600]!,
      'description': 'DraggableScrollableSheet is built with '
          'initialChildSize (default 0.5). The sheet appears at '
          'this extent. An initial notification is dispatched.',
    },
    {
      'phase': 'User Starts Drag',
      'step': 2,
      'icon': Icons.touch_app,
      'color': Colors.amber[700]!,
      'description': 'User touches and drags the sheet handle or '
          'content. Each frame of the drag generates a '
          'DraggableScrollableNotification with the updated extent.',
    },
    {
      'phase': 'During Drag',
      'step': 3,
      'icon': Icons.swap_vert,
      'color': Colors.brown[700]!,
      'description': 'Continuous notifications fire as the sheet '
          'follows the finger. extent changes smoothly between '
          'minExtent and maxExtent. Listeners can update UI '
          'every frame (e.g., backdrop opacity).',
    },
    {
      'phase': 'Drag Released',
      'step': 4,
      'icon': Icons.pan_tool,
      'color': Colors.amber[800]!,
      'description': 'User lifts finger. If snap=true, the sheet '
          'animates to the nearest snap point. During the settle '
          'animation, notifications continue firing each frame.',
    },
    {
      'phase': 'Settle Complete',
      'step': 5,
      'icon': Icons.check_circle,
      'color': Colors.brown[500]!,
      'description': 'Sheet reaches its final position (a snap '
          'point or the release position if no snapping). A final '
          'notification fires with the settled extent.',
    },
    {
      'phase': 'Programmatic Change',
      'step': 6,
      'icon': Icons.code,
      'color': Colors.amber[600]!,
      'description': 'DraggableScrollableController.animateTo() or '
          'jumpTo() can change the extent programmatically. These '
          'also dispatch notifications for each frame of the '
          'animation (animateTo) or a single notification (jumpTo).',
    },
  ];

  print('  Prepared ${lifecycle.length} lifecycle phases');

  // ============================================================
  // SECTION 5: Comparison with ScrollNotification
  // ============================================================
  print('=== Section 5: Comparison ===');

  final comparison = <Map<String, dynamic>>[
    {
      'aspect': 'Base class',
      'draggable': 'Notification',
      'scroll': 'LayoutChangedNotification',
    },
    {
      'aspect': 'Source widget',
      'draggable': 'DraggableScrollableSheet',
      'scroll': 'Scrollable (ListView, etc.)',
    },
    {
      'aspect': 'Reports',
      'draggable': 'Sheet extent (0.0–1.0)',
      'scroll': 'Scroll offset (pixels)',
    },
    {
      'aspect': 'Key property',
      'draggable': 'extent (fraction)',
      'scroll': 'metrics.pixels',
    },
    {
      'aspect': 'Subtypes',
      'draggable': 'None (single class)',
      'scroll': 'Start, Update, End, Overscroll',
    },
    {
      'aspect': 'Listener',
      'draggable': 'NotificationListener<DraggableScrollable...>',
      'scroll': 'NotificationListener<ScrollNotification>',
    },
    {
      'aspect': 'Relationship',
      'draggable': 'Fires BEFORE scroll content scrolls',
      'scroll': 'Fires when content scrolls inside sheet',
    },
  ];

  print('  Prepared ${comparison.length} comparison rows');

  // ============================================================
  // SECTION 6: Listening Patterns
  // ============================================================
  print('=== Section 6: Listening Patterns ===');

  final patterns = <Map<String, dynamic>>[
    {
      'name': 'Basic NotificationListener',
      'icon': Icons.hearing,
      'color': Colors.brown[700]!,
      'description': 'Wrap the sheet (or its ancestor) with '
          'NotificationListener<DraggableScrollableNotification>. '
          'The onNotification callback receives every extent change.',
      'code': 'NotificationListener<DraggableScrollableNotification>(\n'
          '  onNotification: (notification) {\n'
          '    final extent = notification.extent;\n'
          '    // update state\n'
          '    return false; // let it continue bubbling\n'
          '  },\n'
          '  child: DraggableScrollableSheet(...),\n'
          ')',
    },
    {
      'name': 'DraggableScrollableController',
      'icon': Icons.tune,
      'color': Colors.amber[700]!,
      'description': 'Attach a DraggableScrollableController and '
          'listen to its size property via addListener(). This '
          'is an alternative to notification listening, giving '
          'you the current size directly.',
      'code': 'final controller = DraggableScrollableController();\n'
          'controller.addListener(() {\n'
          '  final size = controller.size; // current extent\n'
          '});\n'
          'DraggableScrollableSheet(controller: controller, ...)',
    },
    {
      'name': 'Progress-Based UI',
      'icon': Icons.gradient,
      'color': Colors.brown[600]!,
      'description': 'Compute normalized progress and use it to '
          'drive visual changes — backdrop opacity, icon rotation, '
          'color transitions. The notification fires every frame, '
          'enabling smooth animations.',
      'code': 'final progress = (n.extent - n.minExtent)\n'
          '    / (n.maxExtent - n.minExtent);\n'
          'setState(() { backdropOpacity = progress * 0.5; });',
    },
    {
      'name': 'Threshold Detection',
      'icon': Icons.compare_arrows,
      'color': Colors.amber[800]!,
      'description': 'Check if extent crosses specific thresholds '
          'to trigger discrete actions — show/hide FAB, change '
          'app bar title, enable/disable features.',
      'code': 'if (n.extent > 0.7 && !isExpanded) {\n'
          '  setState(() { isExpanded = true; });\n'
          '} else if (n.extent < 0.3 && isExpanded) {\n'
          '  setState(() { isExpanded = false; });\n'
          '}',
    },
  ];

  print('  Prepared ${patterns.length} listening patterns');

  // ============================================================
  // SECTION 7: Real-World Scenarios
  // ============================================================
  print('=== Section 7: Scenarios ===');

  final scenarios = <Map<String, dynamic>>[
    {
      'name': 'Map Bottom Sheet',
      'icon': Icons.map,
      'color': Colors.brown[700]!,
      'description': 'Google Maps-style bottom sheet showing place '
          'details. As the user drags it up, the notification\'s '
          'extent drives the map padding and camera zoom. At 0.5 '
          'extent, a photo carousel appears. At 0.9, reviews load.',
    },
    {
      'name': 'Music Player Mini/Full',
      'icon': Icons.music_note,
      'color': Colors.amber[700]!,
      'description': 'A draggable now-playing bar. At minExtent '
          '(~0.1) it shows a mini player. Dragging up expands to '
          'full player. The notification extent drives the '
          'crossfade between mini and full layouts.',
    },
    {
      'name': 'Ride-Sharing Route Sheet',
      'icon': Icons.local_taxi,
      'color': Colors.brown[600]!,
      'description': 'Sheet shows ride options. Collapsed: summary '
          'and price. Expanded: detailed route, driver info, '
          'payment. Notification extent toggles between layouts '
          'and adjusts the visible map area.',
    },
    {
      'name': 'Filter Panel',
      'icon': Icons.filter_list,
      'color': Colors.amber[800]!,
      'description': 'E-commerce filter sheet. At minExtent, shows '
          '"N filters active". Expanded, shows full filter UI. '
          'The notification helps coordinate the main list — '
          'adding top padding as the sheet grows.',
    },
    {
      'name': 'Photo Editor Tools',
      'icon': Icons.photo_filter,
      'color': Colors.brown[500]!,
      'description': 'A photo editing sheet with adjustment sliders. '
          'At minExtent, just shows the tool icons. Expanded, '
          'shows full sliders. Notification extent shrinks the '
          'photo preview proportionally.',
    },
  ];

  print('  Prepared ${scenarios.length} scenarios');

  // ============================================================
  // SECTION 8: Snap Points & Sheet Configuration
  // ============================================================
  print('=== Section 8: Configuration ===');

  final configItems = <Map<String, dynamic>>[
    {
      'name': 'minChildSize',
      'default': '0.25',
      'icon': Icons.vertical_align_bottom,
      'color': Colors.brown[700]!,
      'description': 'Minimum extent the sheet can be dragged to. '
          'The notification\'s minExtent will match this value. '
          'Set to 0.0 to allow fully collapsing.',
    },
    {
      'name': 'maxChildSize',
      'default': '1.0',
      'icon': Icons.vertical_align_top,
      'color': Colors.amber[700]!,
      'description': 'Maximum extent. The notification\'s maxExtent '
          'will match this. Set to less than 1.0 if the sheet '
          'shouldn\'t cover the full screen.',
    },
    {
      'name': 'initialChildSize',
      'default': '0.5',
      'icon': Icons.start,
      'color': Colors.brown[600]!,
      'description': 'Where the sheet starts. The notification\'s '
          'initialExtent matches this. Must be between '
          'minChildSize and maxChildSize.',
    },
    {
      'name': 'snap',
      'default': 'false',
      'icon': Icons.grid_on,
      'color': Colors.amber[800]!,
      'description': 'When true, the sheet snaps to positions '
          'defined in snapSizes after release. During the snap '
          'animation, notifications continue firing each frame.',
    },
    {
      'name': 'snapSizes',
      'default': 'null',
      'icon': Icons.format_line_spacing,
      'color': Colors.brown[500]!,
      'description': 'List of fractional snap positions between '
          'min and max (exclusive). E.g., [0.5] for a half-snap. '
          'The extent in notifications will settle at one of '
          'these values or at min/max.',
    },
    {
      'name': 'shouldCloseOnMinExtent',
      'default': 'true',
      'icon': Icons.close,
      'color': Colors.amber[600]!,
      'description': 'Whether the sheet pops the route when dragged '
          'to minExtent. If true, the last notification will have '
          'extent == minExtent just before the sheet closes.',
    },
  ];

  print('  Prepared ${configItems.length} config items');

  // ============================================================
  // SECTION 9: Tips & Gotchas
  // ============================================================
  print('=== Section 9: Tips & Gotchas ===');

  final tips = <Map<String, dynamic>>[
    {
      'icon': Icons.lightbulb_outline,
      'title': 'Not a ScrollNotification',
      'body': 'DraggableScrollableNotification does NOT extend '
          'ScrollNotification. A NotificationListener<'
          'ScrollNotification> will NOT catch it. Use the specific '
          'type in the listener generic.',
      'severity': 'info',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'High Frequency During Drag',
      'body': 'Notifications fire every frame during a drag (60+ '
          'per second). Avoid expensive computation in the '
          'listener. If you must do heavy work, debounce or only '
          'react when extent crosses a threshold.',
      'severity': 'warning',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Use Controller for Imperative Access',
      'body': 'DraggableScrollableController.size gives you the '
          'current extent without setting up a NotificationListener. '
          'Both approaches work; the controller is simpler for '
          'one-off reads, notifications for reactive UI updates.',
      'severity': 'tip',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'Extent Boundaries Are Enforced',
      'body': 'The notification\'s extent will never exceed maxExtent '
          'or go below minExtent (unlike scroll metrics which can '
          'report overscroll). You don\'t need to clamp manually.',
      'severity': 'warning',
    },
    {
      'icon': Icons.lightbulb_outline,
      'title': 'Separate from Inner Scroll',
      'body': 'When the sheet is fully expanded, dragging its '
          'content scrolls the inner ScrollView. During inner '
          'scrolling, DraggableScrollableNotification stops firing '
          '(extent doesn\'t change). ScrollNotification fires '
          'for the inner content instead.',
      'severity': 'info',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Combine with AnimatedBuilder',
      'body': 'For smooth visual transitions driven by extent, '
          'store the extent in a ValueNotifier and use '
          'ValueListenableBuilder. This avoids full setState() '
          'rebuilds and keeps animations performant.',
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
      title: Text('DraggableScrollableNotification'),
      backgroundColor: Colors.brown[700],
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
                colors: [Colors.brown[700]!, Colors.amber[700]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.drag_handle, color: Colors.white, size: 40),
                SizedBox(height: 12),
                Text(
                  'DraggableScrollable\nNotification',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'A notification dispatched when a '
                  'DraggableScrollableSheet\'s extent changes. '
                  'Carries current, min, max, and initial extent '
                  'fractions for reactive UI coordination.',
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
          _dragHead('1', 'What is it?'),
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

          // ── Section 2: Properties ──
          _dragHead('2', 'Notification Properties'),
          SizedBox(height: 12),
          ...properties.map((prop) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: prop['key'] == true
                        ? Colors.amber[50]
                        : Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border(
                      left: BorderSide(
                          color: prop['color'] as Color, width: 4),
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
                        Icon(prop['icon'] as IconData,
                            color: prop['color'] as Color, size: 16),
                        SizedBox(width: 6),
                        Expanded(
                          child: Text(prop['name'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'monospace',
                                  fontSize: 12,
                                  color: prop['color'] as Color)),
                        ),
                        _dragTag(
                            prop['type'] as String, Colors.grey[500]!),
                        if (prop['key'] == true) ...[
                          SizedBox(width: 4),
                          _dragTag('KEY', Colors.brown[700]!),
                        ],
                      ]),
                      SizedBox(height: 4),
                      Text(prop['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.3)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 3: Derived Values ──
          _dragHead('3', 'Derived Calculations'),
          SizedBox(height: 12),
          ...derived.map((d) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: d['color'] as Color, width: 4),
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
                        Icon(d['icon'] as IconData,
                            color: d['color'] as Color, size: 18),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(d['name'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13)),
                        ),
                      ]),
                      SizedBox(height: 6),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(d['formula'] as String,
                            style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 11,
                                color: Colors.brown[800])),
                      ),
                      SizedBox(height: 6),
                      Text(d['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.3)),
                      SizedBox(height: 4),
                      Text('Example: ${d['example']}',
                          style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey[500],
                              fontStyle: FontStyle.italic)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 4: Lifecycle ──
          _dragHead('4', 'Sheet Lifecycle'),
          SizedBox(height: 12),
          ...lifecycle.map((lc) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border(
                      left: BorderSide(
                          color: lc['color'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 2,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: lc['color'] as Color,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text('${lc['step']}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12)),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(children: [
                              Icon(lc['icon'] as IconData,
                                  color: lc['color'] as Color,
                                  size: 16),
                              SizedBox(width: 6),
                              Text(lc['phase'] as String,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13)),
                            ]),
                            SizedBox(height: 4),
                            Text(lc['description'] as String,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[700],
                                    height: 1.3)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 5: Comparison ──
          _dragHead('5', 'vs ScrollNotification'),
          SizedBox(height: 12),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2))
              ],
            ),
            child: Column(children: [
              Container(
                padding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.brown[700],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: Row(children: [
                  Expanded(
                      flex: 2,
                      child: Text('Aspect',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10))),
                  Expanded(
                      flex: 3,
                      child: Text('DraggableScrollable',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10))),
                  Expanded(
                      flex: 3,
                      child: Text('ScrollNotification',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10))),
                ]),
              ),
              ...comparison.asMap().entries.map((entry) {
                final idx = entry.key;
                final row = entry.value;
                return Container(
                  padding: EdgeInsets.symmetric(
                      vertical: 6, horizontal: 10),
                  color: idx.isEven ? Colors.grey[50] : Colors.white,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          flex: 2,
                          child: Text(row['aspect'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10))),
                      Expanded(
                          flex: 3,
                          child: Text(row['draggable'] as String,
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.brown[700],
                                  height: 1.3))),
                      Expanded(
                          flex: 3,
                          child: Text(row['scroll'] as String,
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey[600],
                                  height: 1.3))),
                    ],
                  ),
                );
              }),
            ]),
          ),

          SizedBox(height: 24),

          // ── Section 6: Patterns ──
          _dragHead('6', 'Listening Patterns'),
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
                          child: Text(p['name'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14)),
                        ),
                      ]),
                      SizedBox(height: 8),
                      Text(p['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                      SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(p['code'] as String,
                            style: TextStyle(
                                fontSize: 11,
                                fontFamily: 'monospace',
                                color: Colors.brown[800],
                                height: 1.4)),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 7: Scenarios ──
          _dragHead('7', 'Real-World Scenarios'),
          SizedBox(height: 12),
          ...scenarios.map((s) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: s['color'] as Color, width: 4),
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
                        Icon(s['icon'] as IconData,
                            color: s['color'] as Color, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(s['name'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14)),
                        ),
                      ]),
                      SizedBox(height: 8),
                      Text(s['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 8: Configuration ──
          _dragHead('8', 'Sheet Configuration'),
          SizedBox(height: 12),
          ...configItems.map((c) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border(
                      left: BorderSide(
                          color: c['color'] as Color, width: 4),
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
                        Icon(c['icon'] as IconData,
                            color: c['color'] as Color, size: 16),
                        SizedBox(width: 6),
                        Expanded(
                          child: Text(c['name'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'monospace',
                                  fontSize: 12,
                                  color: c['color'] as Color)),
                        ),
                        _dragTag('default: ${c['default']}',
                            Colors.grey[500]!),
                      ]),
                      SizedBox(height: 4),
                      Text(c['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.3)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 9: Tips ──
          _dragHead('9', 'Tips, Pitfalls & Gotchas'),
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
              'End of DraggableScrollableNotification Deep Demo',
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
Widget _dragHead(String number, String title) {
  return Row(
    children: [
      Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.brown[700],
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
// Helper: Small tag/badge
// ──────────────────────────────────────────────────────────
Widget _dragTag(String text, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(4),
    ),
    child: Text(text,
        style: TextStyle(
            color: Colors.white,
            fontSize: 9,
            fontWeight: FontWeight.bold)),
  );
}
