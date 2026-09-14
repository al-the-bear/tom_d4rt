// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — UniqueWidget
// Demonstrates UniqueWidget, a widget that uses a GlobalKey to ensure
// only one instance exists in the widget tree at any given time.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('UniqueWidget Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptItems = <Map<String, dynamic>>[
    {
      'icon': Icons.fingerprint,
      'title': 'What is UniqueWidget?',
      'body': 'UniqueWidget is an abstract StatefulWidget that creates '
          'and owns a GlobalKey. This key guarantees that only one '
          'instance of the widget exists in the widget tree at any '
          'time. If you try to insert two, Flutter throws.',
      'accent': Colors.cyan,
    },
    {
      'icon': Icons.vpn_key,
      'title': 'GlobalKey Mechanism',
      'body': 'Each UniqueWidget subclass generates a GlobalKey tied '
          'to its State type. The framework uses this key to track '
          'the widget across builds and detect duplicates. The key '
          'is created once and reused across rebuilds.',
      'accent': Colors.blue,
    },
    {
      'icon': Icons.swap_horiz,
      'title': 'Reparenting',
      'body': 'Because the widget has a GlobalKey, it can be moved '
          '(reparented) from one location in the tree to another '
          'without losing its state. The Element and State object '
          'travel with the key.',
      'accent': Colors.green,
    },
    {
      'icon': Icons.warning_amber,
      'title': 'Uniqueness Enforcement',
      'body': 'Flutter\u0027s framework asserts that each GlobalKey appears '
          'at most once. Inserting the same UniqueWidget in two places '
          'simultaneously causes a runtime error. This is by design '
          'to prevent ambiguous state references.',
      'accent': Colors.orange,
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
      'name': 'UniqueWidget<T>',
      'type': 'abstract class',
      'desc': 'An abstract StatefulWidget parameterized on its State type T. '
          'Subclass this instead of StatefulWidget when you need a '
          'singleton widget with a persistent GlobalKey.',
    },
    {
      'name': 'key',
      'type': 'GlobalKey<T>',
      'desc': 'Automatically created GlobalKey tied to the State type. '
          'This key is what makes the widget unique. You never pass '
          'a key to the constructor — it is generated internally.',
    },
    {
      'name': 'createState()',
      'type': 'T',
      'desc': 'Returns the State object of type T. Same as regular '
          'StatefulWidget but the State is guaranteed to persist '
          'across reparenting thanks to the GlobalKey.',
    },
    {
      'name': 'currentState',
      'type': 'T?',
      'desc': 'Access the current State via key.currentState. Because '
          'UniqueWidget owns the GlobalKey, you can always reach '
          'the state from anywhere that has a reference to the widget.',
    },
    {
      'name': 'currentContext',
      'type': 'BuildContext?',
      'desc': 'Access the current BuildContext via key.currentContext. '
          'Returns null if the widget is not currently mounted in '
          'the tree. Useful for showing dialogs or overlays.',
    },
    {
      'name': 'currentWidget',
      'type': 'Widget?',
      'desc': 'Access the current widget configuration via '
          'key.currentWidget. Returns the widget instance as it was '
          'last built by the framework.',
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
              ? Colors.cyan.withOpacity(0.06)
              : Colors.grey.withOpacity(0.03),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.cyan.withOpacity(0.25)),
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
                    color: Colors.cyan.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    ae['name']!,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.cyan.shade800,
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
  // SECTION 3: GlobalKey Deep Dive
  // ============================================================
  print('=== Section 3: GlobalKey Deep Dive ===');

  final globalKeyTopics = <Map<String, dynamic>>[
    {
      'title': 'Key Identity',
      'desc': 'A GlobalKey uniquely identifies an Element in the widget '
          'tree. Unlike LocalKey (ValueKey, ObjectKey), it is unique '
          'across the entire tree, not just among siblings.',
      'icon': Icons.key,
      'color': Colors.cyan,
    },
    {
      'title': 'Registration',
      'desc': 'When a widget with a GlobalKey mounts, it registers in a '
          'global table. If another widget tries to register with the '
          'same key, the framework throws a duplicate-key error.',
      'icon': Icons.app_registration,
      'color': Colors.blue,
    },
    {
      'title': 'State Preservation',
      'desc': 'GlobalKeys preserve state across reparenting. When a widget '
          'moves from location A to B in the same build frame, the '
          'framework detaches the Element and reattaches it at B.',
      'icon': Icons.save,
      'color': Colors.green,
    },
    {
      'title': 'Performance Cost',
      'desc': 'Each GlobalKey adds overhead: global registration, '
          'deferred deactivation checks, and cross-tree lookups. '
          'Use sparingly — only when reparenting or external State '
          'access is genuinely needed.',
      'icon': Icons.speed,
      'color': Colors.orange,
    },
    {
      'title': 'vs ValueKey',
      'desc': 'ValueKey identifies elements by a value and works within '
          'siblings. GlobalKey is across the entire tree. UniqueWidget '
          'uses GlobalKey because it needs tree-wide uniqueness.',
      'icon': Icons.compare_arrows,
      'color': Colors.purple,
    },
  ];

  final gkWidgets = <Widget>[];
  for (var i = 0; i < globalKeyTopics.length; i++) {
    final gk = globalKeyTopics[i];
    final gkColor = gk['color'] as Color;
    print('GlobalKey ${i + 1}: ${gk['title']}');
    gkWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: gkColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: gkColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: gkColor.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  gk['icon'] as IconData,
                  color: gkColor,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      gk['title'] as String,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: gkColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      gk['desc'] as String,
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
      ),
    );
  }

  // ============================================================
  // SECTION 4: Single Instance Guarantee
  // ============================================================
  print('=== Section 4: Single Instance ===');

  final scenarioData = <Map<String, dynamic>>[
    {
      'scenario': 'Widget in One Place',
      'status': 'Valid',
      'desc': 'The UniqueWidget exists at exactly one position in the '
          'tree. The GlobalKey is registered once. Everything works.',
      'visual': 'Tree: [A] \u2192 [B] \u2192 [UniqueWidget \u2714]',
      'statusColor': Colors.green,
    },
    {
      'scenario': 'Widget Moves',
      'status': 'Valid',
      'desc': 'The widget is removed from position A and added to '
          'position B in the same build frame. The framework '
          'reparents the Element. State is preserved.',
      'visual': 'Frame N: [A] \u2192 [UW]\nFrame N+1: [B] \u2192 [UW] (same State)',
      'statusColor': Colors.green,
    },
    {
      'scenario': 'Widget in Two Places',
      'status': 'Error',
      'desc': 'Attempting to insert the widget at two positions in the '
          'same frame triggers a GlobalKey duplicate error. Flutter '
          'asserts the key appears at most once.',
      'visual': 'Tree: [A] \u2192 [UW] and [B] \u2192 [UW] \u2718 CRASH',
      'statusColor': Colors.red,
    },
    {
      'scenario': 'Widget Removed',
      'status': 'Valid',
      'desc': 'When removed, the GlobalKey is unregistered. The State '
          'goes through deactivate() and dispose(). The widget can '
          'later be reinserted, creating a fresh State.',
      'visual': 'Tree: [A] \u2192 [removed] \u2192 key unregistered',
      'statusColor': Colors.cyan,
    },
  ];

  final scenarioWidgets = <Widget>[];
  for (var i = 0; i < scenarioData.length; i++) {
    final sd = scenarioData[i];
    final sColor = sd['statusColor'] as Color;
    print('Scenario ${i + 1}: ${sd['scenario']}');
    scenarioWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: sColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: sColor.withOpacity(0.25)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  sd['scenario'] as String,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: sColor,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: sColor.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    sd['status'] as String,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: sColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              sd['desc'] as String,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade700,
                height: 1.35,
              ),
            ),
            const SizedBox(height: 6),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E2E),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                sd['visual'] as String,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10,
                  color: Color(0xFFCDD6F4),
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 5: Use Cases
  // ============================================================
  print('=== Section 5: Use Cases ===');

  final useCases = <Map<String, dynamic>>[
    {
      'title': 'Overlay Anchors',
      'desc': 'A floating overlay panel that needs to persist its State '
          'as it moves between different locations in the tree. The '
          'UniqueWidget pattern lets you reparent the overlay while '
          'keeping its scroll position, animation state, and data.',
      'icon': Icons.picture_in_picture,
      'color': Colors.cyan,
    },
    {
      'title': 'Draggable Tiles',
      'desc': 'Dashboard tiles that can be dragged from one grid slot to '
          'another. Each tile is a UniqueWidget so the State (form data, '
          'timers, scroll positions) survives the move between slots.',
      'icon': Icons.drag_indicator,
      'color': Colors.blue,
    },
    {
      'title': 'Focus Management',
      'desc': 'A search field that appears in different parts of the UI '
          'depending on screen size. UniqueWidget ensures the focus '
          'state and text content persist across layout changes.',
      'icon': Icons.search,
      'color': Colors.green,
    },
    {
      'title': 'Media Players',
      'desc': 'A video player widget that can move between pip mode and '
          'full-screen without reinitializing the player. The State '
          'holds the playback position and buffered data.',
      'icon': Icons.play_circle,
      'color': Colors.orange,
    },
    {
      'title': 'Chat Bubbles',
      'desc': 'A message composer that moves between conversation views. '
          'The UniqueWidget retains the draft text, attachment state, '
          'and any pending animations without rebuilding.',
      'icon': Icons.chat,
      'color': Colors.purple,
    },
  ];

  final useCaseWidgets = <Widget>[];
  for (var i = 0; i < useCases.length; i++) {
    final uc = useCases[i];
    final ucColor = uc['color'] as Color;
    print('Use case ${i + 1}: ${uc['title']}');
    useCaseWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: ucColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: ucColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(9),
                decoration: BoxDecoration(
                  color: ucColor.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  uc['icon'] as IconData,
                  color: ucColor,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      uc['title'] as String,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: ucColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      uc['desc'] as String,
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
      ),
    );
  }

  // ============================================================
  // SECTION 6: Reparenting
  // ============================================================
  print('=== Section 6: Reparenting ===');

  final reparentSteps = <Map<String, dynamic>>[
    {
      'step': '1. Widget at Position A',
      'desc': 'The UniqueWidget is mounted at position A in the tree. '
          'Its GlobalKey is registered. The State is created and '
          'initState() has been called.',
      'icon': Icons.place,
      'color': Colors.cyan,
    },
    {
      'step': '2. Build Removes from A',
      'desc': 'During a build, the widget is no longer at position A. '
          'The framework marks the Element as potentially deactivated '
          'but does not dispose it yet.',
      'icon': Icons.remove_circle_outline,
      'color': Colors.orange,
    },
    {
      'step': '3. Build Adds at Position B',
      'desc': 'In the same build frame, the widget appears at position B. '
          'The framework finds the matching GlobalKey, detaches the '
          'Element from A, and reattaches it at B.',
      'icon': Icons.add_location,
      'color': Colors.green,
    },
    {
      'step': '4. State Preserved',
      'desc': 'The State object is the same instance. No dispose/initState '
          'cycle occurs. Only didChangeDependencies may fire if inherited '
          'widgets at B differ from those at A.',
      'icon': Icons.save,
      'color': Colors.blue,
    },
    {
      'step': '5. Render Updated',
      'desc': 'The RenderObject is re-inserted into the render tree at B\u0027s '
          'position. Layout and paint happen at the new location. '
          'The user sees the widget appear at B seamlessly.',
      'icon': Icons.brush,
      'color': Colors.purple,
    },
  ];

  final reparentWidgets = <Widget>[];
  for (var i = 0; i < reparentSteps.length; i++) {
    final rs = reparentSteps[i];
    final rsColor = rs['color'] as Color;
    print('Reparent ${i + 1}: ${rs['step']}');
    reparentWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: rsColor.withOpacity(0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    rs['icon'] as IconData,
                    color: rsColor,
                    size: 18,
                  ),
                ),
                if (i < reparentSteps.length - 1)
                  Container(
                    width: 2,
                    height: 24,
                    color: rsColor.withOpacity(0.2),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: rsColor.withOpacity(0.04),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: rsColor.withOpacity(0.15)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      rs['step'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: rsColor,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      rs['desc'] as String,
                      style: TextStyle(
                        fontSize: 11,
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
  // SECTION 7: Comparison
  // ============================================================
  print('=== Section 7: Comparison ===');

  final comparisons = <Map<String, dynamic>>[
    {
      'widget': 'UniqueWidget',
      'key': 'GlobalKey (auto)',
      'instances': 'Exactly 1',
      'reparent': 'Yes (state preserved)',
      'stateAccess': 'Via key.currentState',
      'color': Colors.cyan,
    },
    {
      'widget': 'StatefulWidget',
      'key': 'Optional (any key)',
      'instances': 'Unlimited',
      'reparent': 'Only with GlobalKey',
      'stateAccess': 'Only with GlobalKey',
      'color': Colors.blue,
    },
    {
      'widget': 'StatelessWidget',
      'key': 'Optional (any key)',
      'instances': 'Unlimited',
      'reparent': 'Only with GlobalKey',
      'stateAccess': 'N/A (no state)',
      'color': Colors.green,
    },
    {
      'widget': 'InheritedWidget',
      'key': 'Optional',
      'instances': 'Unlimited',
      'reparent': 'Only with GlobalKey',
      'stateAccess': 'Via of(context)',
      'color': Colors.orange,
    },
  ];

  final compWidgets = <Widget>[];
  for (var i = 0; i < comparisons.length; i++) {
    final comp = comparisons[i];
    final compColor = comp['color'] as Color;
    print('Comparison ${i + 1}: ${comp['widget']}');

    final fields = <MapEntry<String, String>>[
      MapEntry('Key', comp['key'] as String),
      MapEntry('Max Instances', comp['instances'] as String),
      MapEntry('Reparent', comp['reparent'] as String),
      MapEntry('State Access', comp['stateAccess'] as String),
    ];

    final fieldWidgets = <Widget>[];
    for (final f in fields) {
      fieldWidgets.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 3),
          child: Row(
            children: [
              SizedBox(
                width: 95,
                child: Text(
                  f.key,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  f.value,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade800,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    compWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: compColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: compColor.withOpacity(0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 3,
              ),
              decoration: BoxDecoration(
                color: compColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                comp['widget'] as String,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: compColor,
                ),
              ),
            ),
            const SizedBox(height: 8),
            ...fieldWidgets,
          ],
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
      'icon': Icons.fingerprint,
      'text': 'UniqueWidget is an abstract StatefulWidget with an '
          'auto-created GlobalKey ensuring tree-wide uniqueness.',
    },
    {
      'icon': Icons.vpn_key,
      'text': 'The GlobalKey registers the widget globally. Inserting '
          'two instances simultaneously causes a runtime error.',
    },
    {
      'icon': Icons.swap_horiz,
      'text': 'Reparenting is the primary use case: move the widget '
          'between tree locations without losing State.',
    },
    {
      'icon': Icons.access_time,
      'text': 'No dispose/initState cycle on reparent. Only '
          'didChangeDependencies may fire at the new location.',
    },
    {
      'icon': Icons.find_in_page,
      'text': 'key.currentState, key.currentContext, and '
          'key.currentWidget provide external access to internals.',
    },
    {
      'icon': Icons.warning_amber,
      'text': 'Use sparingly. GlobalKeys have overhead. Prefer ValueKey '
          'or ObjectKey when tree-wide identity is not needed.',
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
          color: Colors.cyan.withOpacity(0.04 + (i % 3) * 0.02),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.cyan.withOpacity(0.15)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.cyan.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                sp['icon'] as IconData,
                color: Colors.cyan.shade800,
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
        title: const Text('UniqueWidget'),
        backgroundColor: Colors.cyan.shade700,
        foregroundColor: Colors.white,
        bottom: const TabBar(
          isScrollable: true,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: [
            Tab(icon: Icon(Icons.info_outline), text: 'Concept'),
            Tab(icon: Icon(Icons.api), text: 'API'),
            Tab(icon: Icon(Icons.vpn_key), text: 'GlobalKey'),
            Tab(icon: Icon(Icons.fingerprint), text: 'Unique'),
            Tab(icon: Icon(Icons.lightbulb), text: 'Use Cases'),
            Tab(icon: Icon(Icons.swap_horiz), text: 'Reparent'),
            Tab(icon: Icon(Icons.compare), text: 'Compare'),
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
                  color: Colors.cyan.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'UniqueWidget: a StatefulWidget with a built-in GlobalKey '
                  'that enforces exactly-one-instance in the widget tree.',
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
                  color: Colors.cyan.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'API surface of UniqueWidget and its GlobalKey.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...apiWidgets,
            ],
          ),
          // Tab 3 — GlobalKey
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.cyan.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Deep dive into the GlobalKey mechanism used by UniqueWidget.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...gkWidgets,
            ],
          ),
          // Tab 4 — Single Instance
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.cyan.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Scenarios: what happens with one, two, or zero instances.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...scenarioWidgets,
            ],
          ),
          // Tab 5 — Use Cases
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.cyan.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Practical scenarios where UniqueWidget shines.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...useCaseWidgets,
            ],
          ),
          // Tab 6 — Reparenting
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.cyan.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Step-by-step: how reparenting works with GlobalKey.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...reparentWidgets,
            ],
          ),
          // Tab 7 — Comparison
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.cyan.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'UniqueWidget vs StatefulWidget vs StatelessWidget vs '
                  'InheritedWidget.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...compWidgets,
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
                      Colors.cyan.withOpacity(0.12),
                      Colors.teal.withOpacity(0.06),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Key takeaways about UniqueWidget.',
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
