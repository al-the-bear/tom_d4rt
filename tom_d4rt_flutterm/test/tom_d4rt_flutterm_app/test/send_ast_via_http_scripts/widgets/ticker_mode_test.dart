// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — TickerMode
// Demonstrates TickerMode, the StatefulWidget that controls whether
// animations (Tickers) are active in its subtree. Used to pause
// animations for offscreen content, background tabs, and power saving.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TickerMode Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptItems = <Map<String, dynamic>>[
    {
      'icon': Icons.pause_circle_outline,
      'title': 'What is TickerMode?',
      'body': 'TickerMode is a StatefulWidget that wraps a subtree and '
          'controls whether Tickers (the heartbeat of animations) '
          'are active or muted. When enabled is false, all '
          'AnimationControllers in the subtree silently pause.',
      'accent': Colors.amber,
    },
    {
      'icon': Icons.timer,
      'title': 'Tickers Explained',
      'body': 'A Ticker fires a callback every vsync frame (~60fps). '
          'AnimationController uses Tickers to progress animations. '
          'TickerMode controls the Ticker\'s active state without '
          'disposing or recreating it.',
      'accent': Colors.blue,
    },
    {
      'icon': Icons.battery_saver,
      'title': 'Why Mute Tickers?',
      'body': 'Animations consume CPU and GPU every frame. When content '
          'is offscreen (other tab, scrolled away, behind modal), '
          'running animations is wasted work. TickerMode eliminates '
          'this overhead cleanly.',
      'accent': Colors.green,
    },
    {
      'icon': Icons.toggle_on,
      'title': 'Enable vs Disable',
      'body': 'TickerMode(enabled: true) activates tickers (default). '
          'TickerMode(enabled: false) mutes them. Toggling is cheap — '
          'no widget tree rebuilds or controller disposal needed.',
      'accent': Colors.deepOrange,
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
      'name': 'enabled',
      'type': 'bool',
      'desc': 'Whether tickers in the subtree should be active. Default '
          'is true. When false, all Tickers created via '
          'TickerProviderStateMixin are silently muted.',
    },
    {
      'name': 'child',
      'type': 'Widget',
      'desc': 'The subtree of widgets whose animations are controlled. '
          'Any AnimationController in this subtree (using vsync: this) '
          'will respect the enabled flag.',
    },
    {
      'name': 'TickerMode.of(context)',
      'type': 'static bool',
      'desc': 'Returns whether tickers are enabled for the given context. '
          'Looks up the nearest TickerMode ancestor. Returns true if '
          'no ancestor exists.',
    },
    {
      'name': 'TickerMode.getNotifier(context)',
      'type': 'static ValueNotifier<bool>',
      'desc': 'Returns a ValueNotifier that updates when the ticker mode '
          'changes. Useful for non-widget code (RenderObjects, '
          'custom Tickers) that cannot depend on InheritedWidgets.',
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
              ? Colors.amber.withOpacity(0.06)
              : Colors.grey.withOpacity(0.03),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.amber.withOpacity(0.25)),
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
                    color: Colors.amber.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    ae['name']!,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.amber.shade800,
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
  // SECTION 3: How It Works
  // ============================================================
  print('=== Section 3: How It Works ===');

  final howSteps = <Map<String, dynamic>>[
    {
      'step': '1. Wrap with TickerMode',
      'desc': 'Place TickerMode around the subtree you want to control. '
          'Set enabled: false to mute, true to activate.',
      'code': 'TickerMode(\n'
          '  enabled: isTabVisible,\n'
          '  child: MyAnimatedWidget(),\n'
          ')',
      'icon': Icons.wrap_text,
      'color': Colors.amber,
    },
    {
      'step': '2. TickerModeData Published',
      'desc': 'TickerMode builds a TickerModeData InheritedWidget that '
          'propagates the enabled flag down the tree.',
      'code': '// Internal: TickerMode.build()\n'
          '// return TickerModeData(\n'
          '//   enabled: widget.enabled,\n'
          '//   child: widget.child,\n'
          '// );',
      'icon': Icons.share,
      'color': Colors.blue,
    },
    {
      'step': '3. Mixin Reads State',
      'desc': 'TickerProviderStateMixin calls TickerMode.of(context) in '
          'didChangeDependencies. When the value changes, it mutes '
          'or unmutes all Tickers it created.',
      'code': '// Internal: TickerProviderStateMixin\n'
          '// void didChangeDependencies() {\n'
          '//   final muted = !TickerMode.of(context);\n'
          '//   for (final t in _tickers) t.muted = muted;\n'
          '// }',
      'icon': Icons.settings,
      'color': Colors.green,
    },
    {
      'step': '4. Animations Pause/Resume',
      'desc': 'Muted Tickers stop firing frame callbacks. Active '
          'animations freeze at their current value. When re-enabled, '
          'they resume from where they left off.',
      'code': '// ticker.muted = true;\n'
          '// -> stops vsync callbacks\n'
          '// -> animation stays at current value\n'
          '// ticker.muted = false;\n'
          '// -> resumes from current value',
      'icon': Icons.animation,
      'color': Colors.deepOrange,
    },
  ];

  final howWidgets = <Widget>[];
  for (var i = 0; i < howSteps.length; i++) {
    final hs = howSteps[i];
    final hsColor = hs['color'] as Color;
    print('How ${i + 1}: ${hs['step']}');
    howWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: hsColor.withOpacity(0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    hs['icon'] as IconData,
                    color: hsColor,
                    size: 20,
                  ),
                ),
                if (i < howSteps.length - 1)
                  Container(
                    width: 2,
                    height: 40,
                    color: hsColor.withOpacity(0.2),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: hsColor.withOpacity(0.04),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: hsColor.withOpacity(0.15)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      hs['step'] as String,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: hsColor,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      hs['desc'] as String,
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
                      child: Text(
                        hs['code'] as String,
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
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 4: Scenarios
  // ============================================================
  print('=== Section 4: Scenarios ===');

  final scenarios = <Map<String, dynamic>>[
    {
      'scenario': 'Tab Switching',
      'desc': 'In a TabBarView with keepAlive tabs, offscreen tabs retain '
          'state but their animations waste CPU. TickerMode stops '
          'them without rebuilding.',
      'before': 'All tabs animate \u2192 3x CPU',
      'after': 'Only visible tab animates \u2192 1x CPU',
      'icon': Icons.tab,
      'color': Colors.amber,
    },
    {
      'scenario': 'Page Navigation',
      'desc': 'When pushing a new route, the previous route\'s animations '
          'continue running behind the new page. TickerMode can '
          'mute them during navigation.',
      'before': 'Background route animates \u2192 wasted GPU',
      'after': 'Background route paused \u2192 GPU freed',
      'icon': Icons.navigation,
      'color': Colors.blue,
    },
    {
      'scenario': 'App Background',
      'desc': 'When the app is backgrounded (home button, switch app), '
          'animations are invisible. A root-level TickerMode disable '
          'saves battery significantly.',
      'before': 'Animations run in background \u2192 battery drain',
      'after': 'All animations paused \u2192 battery saved',
      'icon': Icons.mobile_off,
      'color': Colors.red,
    },
    {
      'scenario': 'Collapsible Panels',
      'desc': 'ExpansionPanel or Drawer with animated content. When '
          'collapsed, the animated children are hidden. TickerMode '
          'stops their animations while collapsed.',
      'before': 'Hidden panel content animates',
      'after': 'Panel content animations paused',
      'icon': Icons.expand_less,
      'color': Colors.green,
    },
    {
      'scenario': 'Conditional Animations',
      'desc': 'User preference: "Reduce animations" setting. Wrap the '
          'app content in TickerMode(enabled: !reduceAnimations) '
          'to globally mute decorative animations.',
      'before': 'Animations always active',
      'after': 'Animations respect user preference',
      'icon': Icons.accessibility,
      'color': Colors.purple,
    },
  ];

  final scenarioWidgets = <Widget>[];
  for (var i = 0; i < scenarios.length; i++) {
    final s = scenarios[i];
    final sColor = s['color'] as Color;
    print('Scenario ${i + 1}: ${s['scenario']}');
    scenarioWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: sColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: sColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(s['icon'] as IconData, color: sColor, size: 22),
                  const SizedBox(width: 8),
                  Text(
                    s['scenario'] as String,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: sColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                s['desc'] as String,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                  height: 1.35,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.06),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: Colors.red.withOpacity(0.15)),
                      ),
                      child: Column(
                        children: [
                          const Text(
                            'Before',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            s['before'] as String,
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey.shade600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Icon(Icons.arrow_forward, size: 16, color: sColor),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.06),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: Colors.green.withOpacity(0.15),
                        ),
                      ),
                      child: Column(
                        children: [
                          const Text(
                            'After',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            s['after'] as String,
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey.shade600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 5: Nesting
  // ============================================================
  print('=== Section 5: Nesting ===');

  final nestingItems = <Map<String, dynamic>>[
    {
      'title': 'Single Level',
      'desc': 'One TickerMode wrapping a subtree. All descendants see '
          'the same enabled value. The most common usage pattern.',
      'diagram': ['TickerMode(enabled: false)', '  \u2514\u2500 Child A (muted)', '  \u2514\u2500 Child B (muted)'],
      'color': Colors.amber,
    },
    {
      'title': 'Two Levels — Override',
      'desc': 'An inner TickerMode can re-enable tickers inside an '
          'outer disabled zone. The inner value takes precedence '
          'for its subtree.',
      'diagram': [
        'TickerMode(enabled: false)',
        '  \u2514\u2500 Child A (muted)',
        '  \u2514\u2500 TickerMode(enabled: true)',
        '      \u2514\u2500 Child B (active!)',
      ],
      'color': Colors.blue,
    },
    {
      'title': 'Two Levels — Double Disable',
      'desc': 'Nesting two disabled TickerModes has no additional effect '
          'on children. They remain muted. The inner one is redundant.',
      'diagram': [
        'TickerMode(enabled: false)',
        '  \u2514\u2500 TickerMode(enabled: false)',
        '      \u2514\u2500 Child (muted — same result)',
      ],
      'color': Colors.grey,
    },
    {
      'title': 'Siblings',
      'desc': 'Each TickerMode only affects its own subtree. Sibling '
          'subtrees are independent and can have different states.',
      'diagram': [
        'Row',
        '  \u2514\u2500 TickerMode(enabled: true) \u2192 active',
        '  \u2514\u2500 TickerMode(enabled: false) \u2192 muted',
      ],
      'color': Colors.green,
    },
  ];

  final nestingWidgets = <Widget>[];
  for (var i = 0; i < nestingItems.length; i++) {
    final ni = nestingItems[i];
    final niColor = ni['color'] as Color;
    final diagramLines = ni['diagram'] as List<String>;
    print('Nesting ${i + 1}: ${ni['title']}');
    nestingWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: niColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: niColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ni['title'] as String,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: niColor,
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
                  children: diagramLines
                      .map((line) => Text(
                            line,
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
              const SizedBox(height: 8),
              Text(
                ni['desc'] as String,
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
  // SECTION 6: Performance Impact
  // ============================================================
  print('=== Section 6: Performance ===');

  final perfItems = <Map<String, dynamic>>[
    {
      'title': 'CPU Savings',
      'desc': 'Each muted AnimationController stops its vsync callback, '
          'saving one frame-callback execution per controller per '
          'frame. With 10 controllers at 60fps, that is 600 '
          'saved callbacks every second.',
      'metric': '~600 callbacks/sec saved (10 controllers)',
      'color': Colors.amber,
    },
    {
      'title': 'GPU Savings',
      'desc': 'Muted animations stop triggering repaint boundaries. '
          'The compositor skips re-compositing those layers. Visible '
          'complexity drops.',
      'metric': 'Fewer repainted layers per frame',
      'color': Colors.blue,
    },
    {
      'title': 'Memory Impact',
      'desc': 'TickerMode does not free memory. Controllers, state, and '
          'widget trees remain in memory. Only the frame callback '
          'CPU cost is eliminated. For memory savings, dispose widgets.',
      'metric': 'Zero memory reduction (CPU only)',
      'color': Colors.deepOrange,
    },
    {
      'title': 'Toggle Cost',
      'desc': 'Toggling TickerMode triggers didChangeDependencies in all '
          'dependent widgets. Cost is proportional to the number of '
          'Ticker consumers in the subtree. Usually negligible.',
      'metric': 'O(n) where n = ticker consumers',
      'color': Colors.green,
    },
    {
      'title': 'Battery Impact',
      'desc': 'On mobile, background animations are the top battery '
          'drain from UI apps. TickerMode at the root during '
          'background saves significant battery.',
      'metric': 'Up to 15% battery savings (app-dependent)',
      'color': Colors.red,
    },
  ];

  final perfWidgets = <Widget>[];
  for (var i = 0; i < perfItems.length; i++) {
    final pi = perfItems[i];
    final piColor = pi['color'] as Color;
    print('Perf ${i + 1}: ${pi['title']}');
    perfWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: piColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: piColor.withOpacity(0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  pi['title'] as String,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: piColor,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: piColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    pi['metric'] as String,
                    style: TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                      color: piColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              pi['desc'] as String,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade700,
                height: 1.35,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 7: Code Patterns
  // ============================================================
  print('=== Section 7: Code Patterns ===');

  final patterns = <Map<String, dynamic>>[
    {
      'title': 'Basic Wrapping',
      'code': 'TickerMode(\n'
          '  enabled: isVisible,\n'
          '  child: AnimatedContent(),\n'
          ')',
      'desc': 'Simplest usage: wrap animated content and toggle enabled '
          'based on visibility state.',
      'color': Colors.amber,
    },
    {
      'title': 'TabBarView Optimization',
      'code': 'TabBarView(\n'
          '  children: tabs.map((tab) {\n'
          '    final isActive = currentIndex == tab.index;\n'
          '    return TickerMode(\n'
          '      enabled: isActive,\n'
          '      child: tab.content,\n'
          '    );\n'
          '  }).toList(),\n'
          ')',
      'desc': 'Wrap each tab with TickerMode. Only the active tab has '
          'animations running.',
      'color': Colors.blue,
    },
    {
      'title': 'App Lifecycle Integration',
      'code': 'class _AppState extends State<App>\n'
          '    with WidgetsBindingObserver {\n'
          '  bool _active = true;\n'
          '\n'
          '  void didChangeAppLifecycleState(s) {\n'
          '    setState(() =>\n'
          '      _active = s == AppLifecycleState.resumed);\n'
          '  }\n'
          '\n'
          '  Widget build(ctx) => TickerMode(\n'
          '    enabled: _active,\n'
          '    child: MaterialApp(...),\n'
          '  );\n'
          '}',
      'desc': 'Mute all animations when the app is backgrounded by '
          'wrapping the root with lifecycle-driven TickerMode.',
      'color': Colors.red,
    },
    {
      'title': 'Query Ticker State',
      'code': 'Widget build(BuildContext context) {\n'
          '  final active = TickerMode.of(context);\n'
          '  return Text(\n'
          '    active ? "Animating" : "Paused",\n'
          '  );\n'
          '}',
      'desc': 'Read the current ticker mode state from any descendant. '
          'Useful for showing indicator badges.',
      'color': Colors.green,
    },
  ];

  final patternWidgets = <Widget>[];
  for (var i = 0; i < patterns.length; i++) {
    final p = patterns[i];
    final pColor = p['color'] as Color;
    print('Pattern ${i + 1}: ${p['title']}');
    patternWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: pColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: pColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                p['title'] as String,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: pColor,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                p['desc'] as String,
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
                  p['code'] as String,
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
      'icon': Icons.pause_circle_outline,
      'text': 'TickerMode controls animation activity in its subtree '
          'via the enabled flag.',
    },
    {
      'icon': Icons.timer,
      'text': 'Tickers are the vsync heartbeat of animations. TickerMode '
          'mutes them without disposing controllers.',
    },
    {
      'icon': Icons.tab,
      'text': 'Primary use: stop offscreen tab animations, background '
          'route animations, and collapsed panel content.',
    },
    {
      'icon': Icons.layers,
      'text': 'Nesting: inner TickerMode can override outer. Children '
          'see nearest ancestor. Siblings independent.',
    },
    {
      'icon': Icons.speed,
      'text': 'Saves CPU (no frame callbacks) and GPU (no repaints) '
          'but does not free memory.',
    },
    {
      'icon': Icons.battery_saver,
      'text': 'Combined with app lifecycle observer, TickerMode is the '
          'simplest way to save battery on mobile.',
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
          color: Colors.amber.withOpacity(0.04 + (i % 3) * 0.02),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.amber.withOpacity(0.15)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.amber.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                sp['icon'] as IconData,
                color: Colors.amber.shade800,
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
        title: const Text('TickerMode'),
        backgroundColor: Colors.amber.shade700,
        foregroundColor: Colors.white,
        bottom: const TabBar(
          isScrollable: true,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: [
            Tab(icon: Icon(Icons.info_outline), text: 'Concept'),
            Tab(icon: Icon(Icons.api), text: 'API'),
            Tab(icon: Icon(Icons.settings), text: 'Mechanism'),
            Tab(icon: Icon(Icons.lightbulb), text: 'Scenarios'),
            Tab(icon: Icon(Icons.layers), text: 'Nesting'),
            Tab(icon: Icon(Icons.speed), text: 'Performance'),
            Tab(icon: Icon(Icons.code), text: 'Patterns'),
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
                  color: Colors.amber.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'TickerMode: enables or disables animation Tickers in '
                  'its subtree for power and CPU savings.',
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
                  color: Colors.amber.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Constructor parameters and static methods.',
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
                  color: Colors.amber.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Step-by-step: how TickerMode mutes animations.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...howWidgets,
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
                  color: Colors.amber.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Real-world scenarios where TickerMode saves resources.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...scenarioWidgets,
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
                  color: Colors.amber.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Nesting and override behavior of TickerMode.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...nestingWidgets,
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
                  color: Colors.amber.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'CPU, GPU, memory, and battery impacts of TickerMode.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...perfWidgets,
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
                  color: Colors.amber.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Common code patterns for using TickerMode effectively.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...patternWidgets,
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
                      Colors.amber.withOpacity(0.12),
                      Colors.orange.withOpacity(0.06),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Key takeaways about TickerMode.',
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
