// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — TickerModeData (InheritedWidget)
// TickerModeData is an InheritedWidget that provides ticker-activity
// information to descendants. It works with TickerMode to let subtrees
// query whether tickers (animations) should be active or muted.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TickerModeData Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptItems = <Map<String, dynamic>>[
    {
      'icon': Icons.data_object,
      'title': 'What is TickerModeData?',
      'body': 'TickerModeData is the InheritedWidget companion to '
          'TickerMode. While TickerMode wraps subtrees with an '
          'enabled/disabled flag, TickerModeData is the inherited '
          'mechanism that delivers that state to descendants.',
      'accent': Colors.cyan,
    },
    {
      'icon': Icons.share,
      'title': 'InheritedWidget Pattern',
      'body': 'TickerModeData uses the InheritedWidget pattern so any '
          'widget in the subtree can read the ticker-active state '
          'without explicit parameter passing. Widgets call '
          'TickerMode.of(context) which finds TickerModeData.',
      'accent': Colors.blue,
    },
    {
      'icon': Icons.animation,
      'title': 'Animation Control',
      'body': 'When TickerModeData reports inactive, AnimationController '
          'and other Ticker consumers stop driving animations. This '
          'saves CPU cycles for offscreen or backgrounded content '
          'without rebuilding the widget tree.',
      'accent': Colors.deepOrange,
    },
    {
      'icon': Icons.account_tree,
      'title': 'Subtree Scope',
      'body': 'TickerModeData is scoped to the subtree where TickerMode '
          'is placed. Multiple TickerMode widgets can nest, each '
          'overriding the state for its own subtree. Children see '
          'the nearest ancestor\'s value.',
      'accent': Colors.green,
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
  // SECTION 2: API & Relationship
  // ============================================================
  print('=== Section 2: API ===');

  final apiEntries = <Map<String, String>>[
    {
      'name': 'enabled',
      'type': 'bool',
      'desc': 'Whether tickers in the subtree should be active. When '
          'true, AnimationControllers drive animations normally. '
          'When false, tickers are silently muted.',
    },
    {
      'name': 'TickerMode.of(context)',
      'type': 'bool',
      'desc': 'Static method that looks up the nearest TickerModeData '
          'ancestor and returns its enabled value. Returns true if '
          'no TickerMode ancestor exists (default active).',
    },
    {
      'name': 'TickerMode.getNotifier(context)',
      'type': 'ValueNotifier<bool>',
      'desc': 'Returns a ValueNotifier that allows widgets to listen '
          'for ticker-mode changes without rebuilding. Useful for '
          'custom Ticker implementations.',
    },
    {
      'name': 'updateShouldNotify',
      'type': 'bool Function(TickerModeData)',
      'desc': 'InheritedWidget method that returns true when the enabled '
          'flag changes, triggering dependent widget rebuilds.',
    },
    {
      'name': 'child',
      'type': 'Widget',
      'desc': 'The subtree that this TickerModeData covers. All '
          'descendants will receive the ticker state via '
          'InheritedWidget dependency.',
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
          border: Border.all(color: Colors.cyan.withOpacity(0.2)),
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
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.cyan,
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
  // SECTION 3: InheritedWidget Mechanics
  // ============================================================
  print('=== Section 3: InheritedWidget ===');

  final inheritedMechanics = <Map<String, dynamic>>[
    {
      'title': 'Widget Tree Propagation',
      'desc': 'TickerModeData sits in the element tree as an '
          'InheritedElement. When a descendant calls '
          'TickerMode.of(context), the framework walks up the tree '
          'to find it and registers a dependency.',
      'icon': Icons.account_tree,
      'color': Colors.cyan,
    },
    {
      'title': 'Dependency Registration',
      'desc': 'Calling TickerMode.of(context) registers the calling '
          'widget as a dependent. When TickerModeData changes and '
          'updateShouldNotify returns true, all dependents rebuild.',
      'icon': Icons.link,
      'color': Colors.blue,
    },
    {
      'title': 'Efficient Updates',
      'desc': 'Only widgets that actually called TickerMode.of(context) '
          'rebuild when the ticker state changes. Widgets that don\'t '
          'use ticker state are unaffected, even in the same subtree.',
      'icon': Icons.flash_on,
      'color': Colors.amber,
    },
    {
      'title': 'Nesting Behavior',
      'desc': 'If multiple TickerMode widgets are nested, children find '
          'the closest ancestor. An inner TickerMode(enabled: true) '
          'can re-enable tickers within an outer disabled zone.',
      'icon': Icons.layers,
      'color': Colors.green,
    },
    {
      'title': 'Default Value',
      'desc': 'When no TickerMode ancestor exists, TickerMode.of(context) '
          'returns true (tickers active by default). This ensures '
          'animations work without explicit TickerMode wrapping.',
      'icon': Icons.check_circle,
      'color': Colors.teal,
    },
  ];

  final inheritedWidgets = <Widget>[];
  for (var i = 0; i < inheritedMechanics.length; i++) {
    final im = inheritedMechanics[i];
    final imColor = im['color'] as Color;
    print('Inherited ${i + 1}: ${im['title']}');
    inheritedWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: imColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: imColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: imColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(im['icon'] as IconData, color: imColor, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      im['title'] as String,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: imColor,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      im['desc'] as String,
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
  // SECTION 4: Consumers
  // ============================================================
  print('=== Section 4: Consumers ===');

  final consumers = <Map<String, dynamic>>[
    {
      'name': 'AnimationController',
      'desc': 'The primary consumer. When ticker mode is disabled, '
          'AnimationController\'s internal Ticker silently stops. '
          'Pending animations freeze at their current value. '
          'Re-enabling resumes from where they paused.',
      'icon': Icons.animation,
      'color': Colors.cyan,
    },
    {
      'name': 'TickerProviderStateMixin',
      'desc': 'The mixin that creates Tickers for State objects. It '
          'automatically subscribes to TickerModeData and mutes '
          'its Tickers when the mode is disabled.',
      'icon': Icons.settings,
      'color': Colors.blue,
    },
    {
      'name': 'SingleTickerProviderStateMixin',
      'desc': 'Same as TickerProviderStateMixin but limited to a single '
          'Ticker. Slightly more efficient when a State only needs '
          'one AnimationController.',
      'icon': Icons.looks_one,
      'color': Colors.deepOrange,
    },
    {
      'name': 'Custom Tickers',
      'desc': 'Custom widgets that create their own Tickers should call '
          'TickerMode.of(context) or use getNotifier() to respect '
          'ticker mode. Ignoring it wastes CPU on hidden animations.',
      'icon': Icons.build,
      'color': Colors.green,
    },
    {
      'name': 'Implicit Animations',
      'desc': 'AnimatedContainer, AnimatedOpacity, and other implicit '
          'animation widgets use AnimationController internally. '
          'They automatically honor TickerModeData via their mixins.',
      'icon': Icons.auto_awesome_motion,
      'color': Colors.purple,
    },
  ];

  final consumerWidgets = <Widget>[];
  for (var i = 0; i < consumers.length; i++) {
    final c = consumers[i];
    final cColor = c['color'] as Color;
    print('Consumer ${i + 1}: ${c['name']}');
    consumerWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: cColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: cColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: cColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(c['icon'] as IconData, color: cColor, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      c['name'] as String,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: cColor,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      c['desc'] as String,
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
  // SECTION 5: Use Cases
  // ============================================================
  print('=== Section 5: Use Cases ===');

  final useCases = <Map<String, dynamic>>[
    {
      'case': 'Offscreen Tabs',
      'desc': 'When a TabBarView shows tab A, tabs B and C are offscreen. '
          'Wrapping them with TickerMode(enabled: false) stops their '
          'animations, saving CPU without disposing the tab state.',
      'icon': Icons.tab,
      'color': Colors.cyan,
    },
    {
      'case': 'App Lifecycle',
      'desc': 'When the app moves to background (AppLifecycleState.paused), '
          'disabling TickerMode at the root stops all animations. '
          'Re-enable when the app resumes.',
      'icon': Icons.mobile_off,
      'color': Colors.red,
    },
    {
      'case': 'Modal Overlays',
      'desc': 'When a full-screen modal covers the main content, muting '
          'background tickers avoids wasting GPU cycles on invisible '
          'animations under the overlay.',
      'icon': Icons.layers,
      'color': Colors.blue,
    },
    {
      'case': 'Lazy ListView',
      'desc': 'Items scrolled far off screen may have animated indicators '
          'or progress bars. TickerMode can mute them until they are '
          'near the viewport again.',
      'icon': Icons.list,
      'color': Colors.green,
    },
    {
      'case': 'Power Saving',
      'desc': 'On low-battery or power-saving mode, an app can disable '
          'decorative animations globally by toggling a root-level '
          'TickerMode, reducing frame rate demand.',
      'icon': Icons.battery_saver,
      'color': Colors.orange,
    },
  ];

  final useCaseWidgets = <Widget>[];
  for (var i = 0; i < useCases.length; i++) {
    final uc = useCases[i];
    final ucColor = uc['color'] as Color;
    print('Use case ${i + 1}: ${uc['case']}');
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
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: ucColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(uc['icon'] as IconData, color: ucColor, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      uc['case'] as String,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: ucColor,
                      ),
                    ),
                    const SizedBox(height: 6),
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
  // SECTION 6: Relationship Diagram
  // ============================================================
  print('=== Section 6: Relationships ===');

  final relationships = <Map<String, dynamic>>[
    {
      'from': 'TickerMode (StatefulWidget)',
      'to': 'TickerModeData (InheritedWidget)',
      'relationship': 'Creates and updates',
      'desc': 'TickerMode builds a TickerModeData in its build method, '
          'passing the enabled flag. The State object rebuilds '
          'TickerModeData when enabled changes.',
      'color': Colors.cyan,
    },
    {
      'from': 'TickerModeData',
      'to': 'TickerMode.of(context)',
      'relationship': 'Looked up by',
      'desc': 'The static of() method calls '
          'context.dependOnInheritedWidgetOfExactType<TickerModeData>() '
          'to find the nearest ancestor and read its enabled flag.',
      'color': Colors.blue,
    },
    {
      'from': 'TickerProviderStateMixin',
      'to': 'TickerMode.of(context)',
      'relationship': 'Subscribes to',
      'desc': 'The mixin calls TickerMode.of(context) during didChangeDependencies '
          'and mutes/unmutes all Tickers it created. This is automatic.',
      'color': Colors.green,
    },
    {
      'from': 'AnimationController',
      'to': 'TickerProviderStateMixin',
      'relationship': 'Gets Ticker from',
      'desc': 'AnimationController(vsync: this) obtains a Ticker from '
          'the mixin. The mixin controls that Ticker based on '
          'TickerModeData state.',
      'color': Colors.deepOrange,
    },
  ];

  final relationWidgets = <Widget>[];
  for (var i = 0; i < relationships.length; i++) {
    final r = relationships[i];
    final rColor = r['color'] as Color;
    print('Relation ${i + 1}: ${r['from']} -> ${r['to']}');
    relationWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: rColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: rColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: rColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        r['from'] as String,
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: rColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.arrow_forward, size: 14, color: rColor),
                        Text(
                          r['relationship'] as String,
                          style: TextStyle(fontSize: 8, color: rColor),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: rColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        r['to'] as String,
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: rColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                r['desc'] as String,
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
  // SECTION 7: Best Practices
  // ============================================================
  print('=== Section 7: Best Practices ===');

  final practices = <Map<String, dynamic>>[
    {
      'practice': 'Always use vsync: this',
      'desc': 'When creating AnimationControllers in State objects, '
          'use TickerProviderStateMixin and pass vsync: this. This '
          'ensures automatic ticker mode integration.',
      'good': true,
      'color': Colors.green,
    },
    {
      'practice': 'Don\'t ignore ticker mode in custom Tickers',
      'desc': 'If building custom animation drivers, check '
          'TickerMode.of(context) and respect the result. Ignoring '
          'it wastes CPU and battery.',
      'good': false,
      'color': Colors.red,
    },
    {
      'practice': 'Wrap offscreen content with TickerMode',
      'desc': 'For PageView or TabBarView children, wrap offscreen pages '
          'with TickerMode(enabled: false) to stop their animations.',
      'good': true,
      'color': Colors.green,
    },
    {
      'practice': 'Use getNotifier for non-widget consumers',
      'desc': 'For RenderObjects or other non-widget code that needs '
          'ticker mode state, use TickerMode.getNotifier(context) '
          'to listen without widget dependency.',
      'good': true,
      'color': Colors.green,
    },
    {
      'practice': 'Don\'t frequently toggle TickerMode',
      'desc': 'Each toggle triggers rebuilds of all dependent widgets. '
          'Toggle based on meaningful state changes (tab switch, '
          'background), not on every frame.',
      'good': false,
      'color': Colors.red,
    },
  ];

  final practiceWidgets = <Widget>[];
  for (var i = 0; i < practices.length; i++) {
    final p = practices[i];
    final pColor = p['color'] as Color;
    final isGood = p['good'] as bool;
    print('Practice ${i + 1}: ${p['practice']}');
    practiceWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: pColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: pColor.withOpacity(0.2)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: pColor.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isGood ? Icons.check : Icons.close,
                color: pColor,
                size: 18,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${isGood ? "DO" : "DON\u0027T"}: ${p['practice']}',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: pColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    p['desc'] as String,
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
  // SECTION 8: Summary
  // ============================================================
  print('=== Section 8: Summary ===');

  final summaryPoints = <Map<String, dynamic>>[
    {
      'icon': Icons.data_object,
      'text': 'TickerModeData is the InheritedWidget that delivers '
          'ticker-active state from TickerMode to the subtree.',
    },
    {
      'icon': Icons.search,
      'text': 'Widgets call TickerMode.of(context) which finds the '
          'nearest TickerModeData ancestor in the element tree.',
    },
    {
      'icon': Icons.animation,
      'text': 'AnimationController, TickerProviderStateMixin, and '
          'implicit animations all consume TickerModeData.',
    },
    {
      'icon': Icons.layers,
      'text': 'Nested TickerMode widgets create layered scopes. Each '
          'subtree sees its nearest ancestor\'s state.',
    },
    {
      'icon': Icons.battery_saver,
      'text': 'Primary benefit: power saving by stopping invisible '
          'animations on offscreen tabs, backgrounded apps.',
    },
    {
      'icon': Icons.check_circle,
      'text': 'Default is true (active). Only widgets using '
          'TickerMode.of() rebuild when the state changes.',
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
          border: Border.all(color: Colors.cyan.withOpacity(0.12)),
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
                color: Colors.cyan,
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
        title: const Text('TickerModeData'),
        backgroundColor: Colors.cyan,
        foregroundColor: Colors.white,
        bottom: const TabBar(
          isScrollable: true,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: [
            Tab(icon: Icon(Icons.info_outline), text: 'Concept'),
            Tab(icon: Icon(Icons.api), text: 'API'),
            Tab(icon: Icon(Icons.account_tree), text: 'Inherited'),
            Tab(icon: Icon(Icons.animation), text: 'Consumers'),
            Tab(icon: Icon(Icons.lightbulb), text: 'Use Cases'),
            Tab(icon: Icon(Icons.share), text: 'Relations'),
            Tab(icon: Icon(Icons.rule), text: 'Practices'),
            Tab(icon: Icon(Icons.summarize), text: 'Summary'),
          ],
        ),
      ),
      body: TabBarView(
        children: [
          // Tab 1
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
                  'TickerModeData: InheritedWidget companion to TickerMode '
                  'for ticker state propagation.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...conceptCards,
            ],
          ),
          // Tab 2
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
                  'API surface: enabled flag, of(), getNotifier(), and update.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...apiWidgets,
            ],
          ),
          // Tab 3
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
                  'How InheritedWidget propagation works for TickerModeData.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...inheritedWidgets,
            ],
          ),
          // Tab 4
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
                  'Widgets and mixins that consume TickerModeData.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...consumerWidgets,
            ],
          ),
          // Tab 5
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
                  'Real-world scenarios for TickerMode / TickerModeData.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...useCaseWidgets,
            ],
          ),
          // Tab 6
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
                  'How TickerModeData relates to TickerMode, mixins, and controllers.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...relationWidgets,
            ],
          ),
          // Tab 7
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
                  'Do\'s and don\'ts for ticker mode usage.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...practiceWidgets,
            ],
          ),
          // Tab 8
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
                  'Key takeaways about TickerModeData.',
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
