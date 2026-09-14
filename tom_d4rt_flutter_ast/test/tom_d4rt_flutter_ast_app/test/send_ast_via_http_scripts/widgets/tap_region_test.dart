// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — TapRegion
// Demonstrates TapRegion, a widget that detects taps inside and outside
// its bounds (or its group's bounds). TapRegion is the primary API for
// "dismiss on tap outside" patterns in Flutter. It registers with the
// nearest TapRegionSurface and evaluates every pointer-down event.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TapRegion Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptItems = <Map<String, dynamic>>[
    {
      'icon': Icons.touch_app,
      'title': 'What is TapRegion?',
      'body': 'TapRegion is a widget that reports when a tap occurs inside '
          'or outside its bounds. Unlike GestureDetector (which only '
          'detects its own taps), TapRegion listens for all taps on the '
          'screen via TapRegionSurface and compares the tap position '
          'against its region.',
      'accent': Colors.deepOrange,
    },
    {
      'icon': Icons.notifications_active,
      'title': 'Callback Model',
      'body': 'TapRegion provides two callbacks: onTapInside fires when '
          'the pointer lands within the region, and onTapOutside fires '
          'when the pointer lands anywhere else. Both receive the '
          'PointerDownEvent with the exact tap coordinates.',
      'accent': Colors.blue,
    },
    {
      'icon': Icons.group_work,
      'title': 'Group Awareness',
      'body': 'When multiple TapRegion widgets share a groupId, they '
          'form a virtual merged region. A tap inside ANY group member '
          'is considered "inside" for ALL members. Only taps outside '
          'every member fire onTapOutside.',
      'accent': Colors.green,
    },
    {
      'icon': Icons.smart_button,
      'title': 'Common Uses',
      'body': 'Close a dropdown when tapping outside. Unfocus a text field. '
          'Dismiss a tooltip. Hide autocomplete suggestions. Close a '
          'context menu. Close a date picker. Any "dismiss on outside '
          'tap" interaction.',
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
      'name': 'child',
      'type': 'Widget?',
      'desc': 'The widget that defines the visual region. The TapRegion '
          'bounds are determined by this child\'s render box. If null, '
          'TapRegion is a zero-size widget.',
    },
    {
      'name': 'groupId',
      'type': 'Object?',
      'desc': 'Links this region with others in the same group. Any object '
          'can serve as groupId. Null means ungrouped — the region is '
          'evaluated independently.',
    },
    {
      'name': 'onTapOutside',
      'type': 'TapRegionCallback?',
      'desc': 'Called when a pointer-down event occurs outside this region '
          '(or its group). Receives a PointerDownEvent. Typical action: '
          'unfocus, dismiss, or close.',
    },
    {
      'name': 'onTapInside',
      'type': 'TapRegionCallback?',
      'desc': 'Called when a pointer-down event occurs inside this region. '
          'Useful for resetting timers, tracking engagement, or providing '
          'feedback.',
    },
    {
      'name': 'consumeOutsideTaps',
      'type': 'bool',
      'desc': 'When true, outside taps are consumed and do not reach other '
          'widgets. Defaults to false. Acts like an invisible modal '
          'barrier for the tap event.',
    },
    {
      'name': 'behavior',
      'type': 'HitTestBehavior?',
      'desc': 'How the region participates in hit testing. Default is '
          'deferToChild — blank areas within the bounds are not "inside". '
          'Set to opaque to treat the entire bounding box as the region.',
    },
    {
      'name': 'enabled',
      'type': 'bool',
      'desc': 'Whether the region is active. Defaults to true. When false, '
          'the region does not register with the surface and callbacks '
          'are not called.',
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
              ? Colors.deepOrange.withOpacity(0.06)
              : Colors.grey.withOpacity(0.03),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.deepOrange.withOpacity(0.2)),
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
                    color: Colors.deepOrange.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    ae['name']!,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.deepOrange,
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
  // SECTION 3: Basic Usage
  // ============================================================
  print('=== Section 3: Basic ===');

  final basicExamples = <Map<String, dynamic>>[
    {
      'title': 'Simple Dismiss',
      'desc': 'Wrap any content in TapRegion. When the user taps elsewhere '
          'on the screen, onTapOutside fires. No groupId needed for '
          'a single region.',
      'code': 'TapRegion(\n'
          '  onTapOutside: (event) {\n'
          '    setState(() => isVisible = false);\n'
          '  },\n'
          '  child: Container(\n'
          '    padding: EdgeInsets.all(16),\n'
          '    color: Colors.white,\n'
          '    child: Text("Tap outside to dismiss"),\n'
          '  ),\n'
          ')',
      'color': Colors.deepOrange,
    },
    {
      'title': 'With Tap Inside Tracking',
      'desc': 'Both callbacks can be used simultaneously. Track inside '
          'taps for analytics or to reset auto-dismiss timers.',
      'code': 'TapRegion(\n'
          '  onTapOutside: (_) => dismiss(),\n'
          '  onTapInside: (_) {\n'
          '    // Reset 5-second auto-dismiss timer\n'
          '    resetTimer();\n'
          '  },\n'
          '  child: notificationBanner,\n'
          ')',
      'color': Colors.blue,
    },
    {
      'title': 'Enabled / Disabled',
      'desc': 'The enabled property controls whether the region is active. '
          'Toggle it to temporarily disable outside-tap detection without '
          'removing the widget from the tree.',
      'code': 'TapRegion(\n'
          '  enabled: isPopupVisible,\n'
          '  onTapOutside: (_) => closePopup(),\n'
          '  child: popupContent,\n'
          ')',
      'color': Colors.green,
    },
  ];

  final basicWidgets = <Widget>[];
  for (var i = 0; i < basicExamples.length; i++) {
    final be = basicExamples[i];
    final beColor = be['color'] as Color;
    print('Basic ${i + 1}: ${be['title']}');
    basicWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: beColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: beColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: beColor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Center(
                      child: Text(
                        '${i + 1}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: beColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      be['title'] as String,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: beColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                be['desc'] as String,
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
                  color: beColor.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  be['code'] as String,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10,
                    color: beColor,
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
  // SECTION 4: Groups
  // ============================================================
  print('=== Section 4: Groups ===');

  final groupExamples = <Map<String, dynamic>>[
    {
      'title': 'Menu + Trigger Group',
      'desc': 'The button that opens the menu and the menu panel share '
          'a groupId. Clicking the button does not dismiss the menu. '
          'Clicking the menu does not dismiss itself. Only clicking '
          'outside both dismisses.',
      'visual': [
        {'label': 'Button', 'width': 80.0},
        {'label': 'Menu Panel', 'width': 140.0},
      ],
      'color': Colors.deepOrange,
    },
    {
      'title': 'Search + Suggestions Group',
      'desc': 'The search input and the autocomplete suggestions panel '
          'are in the same group. Typing activates search; tapping a '
          'suggestion is "inside"; tapping away closes both.',
      'visual': [
        {'label': 'Search Field', 'width': 180.0},
        {'label': 'Suggestions', 'width': 180.0},
      ],
      'color': Colors.blue,
    },
    {
      'title': 'Nested Dropdown Group',
      'desc': 'A primary dropdown and a secondary child dropdown share '
          'the same group. Navigating between levels keeps everything '
          'open. Tapping outside the entire hierarchy dismisses all.',
      'visual': [
        {'label': 'Trigger', 'width': 70.0},
        {'label': 'Dropdown', 'width': 100.0},
        {'label': 'Sub-dropdown', 'width': 100.0},
      ],
      'color': Colors.green,
    },
    {
      'title': 'Independent Groups',
      'desc': 'Different components use different groupIds. Opening one '
          'dropdown does not interfere with another. Each group is '
          'evaluated independently by the surface.',
      'visual': [
        {'label': 'Group A', 'width': 100.0},
        {'label': 'Group B', 'width': 100.0},
      ],
      'color': Colors.orange,
    },
  ];

  final groupWidgets = <Widget>[];
  for (var i = 0; i < groupExamples.length; i++) {
    final ge = groupExamples[i];
    final geColor = ge['color'] as Color;
    final items = ge['visual'] as List<Map<String, dynamic>>;
    print('Group ${i + 1}: ${ge['title']}');

    final chips = <Widget>[];
    for (var v = 0; v < items.length; v++) {
      chips.add(
        Container(
          width: items[v]['width'] as double,
          margin: const EdgeInsets.only(right: 6, bottom: 4),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          decoration: BoxDecoration(
            color: geColor.withOpacity(0.12),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: geColor.withOpacity(0.3)),
          ),
          child: Center(
            child: Text(
              items[v]['label'] as String,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: geColor,
              ),
            ),
          ),
        ),
      );
    }

    groupWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: geColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: geColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ge['title'] as String,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: geColor,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(children: chips),
              const SizedBox(height: 8),
              Text(
                ge['desc'] as String,
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
    );
  }

  // ============================================================
  // SECTION 5: Callbacks
  // ============================================================
  print('=== Section 5: Callbacks ===');

  final callbackItems = <Map<String, dynamic>>[
    {
      'callback': 'onTapOutside',
      'desc': 'Fired when a PointerDownEvent occurs outside the region '
          '(or group). The event contains the global and local tap '
          'coordinates. Common actions: unfocus, dismiss, close.',
      'timing': 'On pointer DOWN (not up)',
      'example': '(PointerDownEvent event) {\n'
          '  print("Tapped at: \${event.position}");\n'
          '  FocusScope.of(context).unfocus();\n'
          '}',
      'color': Colors.red,
    },
    {
      'callback': 'onTapInside',
      'desc': 'Fired when a PointerDownEvent occurs inside the region. '
          'Less commonly used — mainly for analytics, engagement '
          'tracking, or resetting auto-dismiss timers.',
      'timing': 'On pointer DOWN (same as outside)',
      'example': '(PointerDownEvent event) {\n'
          '  print("User engaged with: \${event.position}");\n'
          '  autoCloseTimer.reset();\n'
          '}',
      'color': Colors.green,
    },
    {
      'callback': 'Both Together',
      'desc': 'Using both callbacks gives you full visibility into tap '
          'location relative to your region. One region can handle '
          'both inside and outside logic.',
      'timing': 'Both fire on pointer DOWN',
      'example': 'TapRegion(\n'
          '  onTapInside: (_) => keepOpen(),\n'
          '  onTapOutside: (_) => dismiss(),\n'
          '  child: floatingPanel,\n'
          ')',
      'color': Colors.deepOrange,
    },
  ];

  final callbackWidgets = <Widget>[];
  for (var i = 0; i < callbackItems.length; i++) {
    final ci = callbackItems[i];
    final ciColor = ci['color'] as Color;
    print('Callback ${i + 1}: ${ci['callback']}');
    callbackWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: ciColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: ciColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
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
                      color: ciColor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      ci['callback'] as String,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: ciColor,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      ci['timing'] as String,
                      style: TextStyle(
                        fontSize: 9,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                ci['desc'] as String,
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
                  color: ciColor.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  ci['example'] as String,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10,
                    color: ciColor,
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
  // SECTION 6: Consume Taps
  // ============================================================
  print('=== Section 6: Consume ===');

  final consumeInfo = <Map<String, dynamic>>[
    {
      'title': 'Default: consumeOutsideTaps = false',
      'desc': 'Outside taps pass through to other widgets normally. '
          'The onTapOutside callback fires, but the tap also reaches '
          'buttons, links, and gesture detectors behind the region.',
      'visual': 'passthrough',
      'color': Colors.green,
    },
    {
      'title': 'consumeOutsideTaps = true',
      'desc': 'Outside taps are eaten by the surface. No other widget '
          'receives the tap. This is like a modal barrier that '
          'prevents background interaction.',
      'visual': 'blocked',
      'color': Colors.red,
    },
    {
      'title': 'When to Use consume:true',
      'desc': 'Use for modal dialogs that should block background '
          'interaction but still dismiss on outside tap. Also for '
          'critical popovers where accidental taps in the background '
          'could cause problems.',
      'visual': 'modal',
      'color': Colors.orange,
    },
    {
      'title': 'Caution',
      'desc': 'consumeOutsideTaps blocks ALL other tap handling. '
          'Navigation buttons, back gestures, and other interactive '
          'elements will not work. Use sparingly and only when truly '
          'needed for modality.',
      'visual': 'warning',
      'color': Colors.purple,
    },
  ];

  final consumeWidgets = <Widget>[];
  for (var i = 0; i < consumeInfo.length; i++) {
    final co = consumeInfo[i];
    final coColor = co['color'] as Color;
    print('Consume ${i + 1}: ${co['title']}');

    // Build visual representation
    Widget miniVisual;
    if (co['visual'] == 'passthrough') {
      miniVisual = Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.05),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.12),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.green.withOpacity(0.3)),
              ),
              child: const Text('Region',
                  style: TextStyle(fontSize: 9)),
            ),
            Icon(Icons.arrow_forward, size: 14, color: Colors.green),
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.12),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text('Button (receives tap)',
                  style: TextStyle(fontSize: 9)),
            ),
          ],
        ),
      );
    } else if (co['visual'] == 'blocked') {
      miniVisual = Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.05),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.12),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.red.withOpacity(0.3)),
              ),
              child: const Text('Region',
                  style: TextStyle(fontSize: 9)),
            ),
            Icon(Icons.block, size: 14, color: Colors.red),
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.08),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'Button (blocked)',
                style: TextStyle(
                  fontSize: 9,
                  color: Colors.grey.shade500,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      miniVisual = const SizedBox.shrink();
    }

    consumeWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: coColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: coColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                co['title'] as String,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: coColor,
                ),
              ),
              const SizedBox(height: 6),
              if (co['visual'] == 'passthrough' ||
                  co['visual'] == 'blocked') ...[
                miniVisual,
                const SizedBox(height: 6),
              ],
              Text(
                co['desc'] as String,
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
    );
  }

  // ============================================================
  // SECTION 7: Patterns
  // ============================================================
  print('=== Section 7: Patterns ===');

  final patternRecipes = <Map<String, dynamic>>[
    {
      'title': 'Dismiss Floating Panel',
      'recipe': '1. Wrap panel in TapRegion\n'
          '2. Set onTapOutside => setState to hide\n'
          '3. Panel disappears on outside tap',
      'complexity': 'Simple',
      'icon': Icons.close,
      'color': Colors.deepOrange,
    },
    {
      'title': 'Keep Picker Open While Interacting',
      'recipe': '1. Group the trigger + picker with same groupId\n'
          '2. Tapping inside either keeps picker open\n'
          '3. Only outside taps close the picker',
      'complexity': 'Medium',
      'icon': Icons.date_range,
      'color': Colors.blue,
    },
    {
      'title': 'Multi-Select Chip Editor',
      'recipe': '1. Text input + suggestion list share groupId\n'
          '2. Tapping suggestions adds chips\n'
          '3. Tapping outside closes suggestion list only',
      'complexity': 'Medium',
      'icon': Icons.label,
      'color': Colors.green,
    },
    {
      'title': 'Context Menu with Sub-Menus',
      'recipe': '1. Right-click shows context menu (TapRegion)\n'
          '2. Hover sub-menu also in same group\n'
          '3. Outside tap dismisses entire hierarchy',
      'complexity': 'Complex',
      'icon': Icons.menu_open,
      'color': Colors.purple,
    },
    {
      'title': 'Modal Overlay Without Route',
      'recipe': '1. Show content in Overlay with TapRegion\n'
          '2. Set consumeOutsideTaps: true\n'
          '3. Background is non-interactive\n'
          '4. Outside tap fires dismiss callback',
      'complexity': 'Medium',
      'icon': Icons.layers,
      'color': Colors.orange,
    },
  ];

  final patternWidgets = <Widget>[];
  for (var i = 0; i < patternRecipes.length; i++) {
    final pr = patternRecipes[i];
    final prColor = pr['color'] as Color;
    print('Pattern ${i + 1}: ${pr['title']}');
    patternWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: prColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: prColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: prColor.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      pr['icon'] as IconData,
                      color: prColor,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      pr['title'] as String,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: prColor,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: prColor.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      pr['complexity'] as String,
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        color: prColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: prColor.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  pr['recipe'] as String,
                  style: TextStyle(
                    fontSize: 12,
                    color: prColor,
                    height: 1.5,
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
      'icon': Icons.touch_app,
      'text': 'TapRegion detects taps inside and outside its bounds '
          'using the globally-aware TapRegionSurface system.',
    },
    {
      'icon': Icons.group_work,
      'text': 'groupId links regions into a single virtual area — taps '
          'must be outside ALL members to fire onTapOutside.',
    },
    {
      'icon': Icons.notifications,
      'text': 'onTapOutside and onTapInside fire on pointer-down, not '
          'on pointer-up. They receive PointerDownEvent.',
    },
    {
      'icon': Icons.block,
      'text': 'consumeOutsideTaps blocks taps from reaching background '
          'widgets — use for modal behavior without a route.',
    },
    {
      'icon': Icons.toggle_on,
      'text': 'The enabled property allows dynamic activation/deactivation '
          'without removing the widget from the tree.',
    },
    {
      'icon': Icons.smart_button,
      'text': 'Primary use cases: dismiss menus, close dropdowns, unfocus '
          'text fields, and hide floating UI.',
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
          color: Colors.deepOrange.withOpacity(0.04 + (i % 3) * 0.02),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.deepOrange.withOpacity(0.12)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.deepOrange.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                sp['icon'] as IconData,
                color: Colors.deepOrange,
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
        title: const Text('TapRegion'),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        bottom: const TabBar(
          isScrollable: true,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: [
            Tab(icon: Icon(Icons.info_outline), text: 'Concept'),
            Tab(icon: Icon(Icons.api), text: 'API'),
            Tab(icon: Icon(Icons.play_arrow), text: 'Basic'),
            Tab(icon: Icon(Icons.group_work), text: 'Groups'),
            Tab(icon: Icon(Icons.notifications), text: 'Callbacks'),
            Tab(icon: Icon(Icons.block), text: 'Consume'),
            Tab(icon: Icon(Icons.pattern), text: 'Patterns'),
            Tab(icon: Icon(Icons.summarize), text: 'Summary'),
          ],
        ),
      ),
      body: TabBarView(
        children: [
          // Tab 1: Concept
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.deepOrange.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'TapRegion: detect taps inside and outside any widget '
                  'to build dismiss-on-outside-tap interactions.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...conceptCards,
            ],
          ),

          // Tab 2: API
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.deepOrange.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'All TapRegion constructor parameters and their roles.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...apiWidgets,
            ],
          ),

          // Tab 3: Basic
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.deepOrange.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Simple usage: single region with callbacks.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...basicWidgets,
            ],
          ),

          // Tab 4: Groups
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.deepOrange.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Linking regions with groupId for compound interactions.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...groupWidgets,
            ],
          ),

          // Tab 5: Callbacks
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.deepOrange.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'onTapInside vs onTapOutside callback behavior.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...callbackWidgets,
            ],
          ),

          // Tab 6: Consume
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.deepOrange.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'consumeOutsideTaps: blocking vs passing through.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...consumeWidgets,
            ],
          ),

          // Tab 7: Patterns
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.deepOrange.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Recipes for common TapRegion interaction patterns.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...patternWidgets,
            ],
          ),

          // Tab 8: Summary
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.deepOrange.withOpacity(0.12),
                      Colors.orange.withOpacity(0.06),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Key takeaways about TapRegion.',
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
