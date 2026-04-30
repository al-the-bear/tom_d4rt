// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — SliverWithKeepAliveWidget
// Demonstrates how slivers can keep their children alive when they scroll
// off-screen, preventing state loss. Covers the keep-alive mechanism,
// AutomaticKeepAliveClientMixin, performance considerations, and use cases.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SliverWithKeepAliveWidget Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptItems = <Map<String, dynamic>>[
    {
      'icon': Icons.pin_drop,
      'title': 'What is Keep-Alive?',
      'body': 'When slivers build children lazily (SliverList, SliverGrid), '
          'items that scroll off-screen are disposed to save memory. Their '
          'State objects are destroyed. Keep-alive prevents this — the '
          'widget stays in the tree even when not visible.',
      'accent': Colors.amber,
    },
    {
      'icon': Icons.recycling,
      'title': 'The Problem',
      'body': 'If a list item has a counter at 42 and scrolls off-screen, '
          'the State is disposed. When scrolled back, a new State is created '
          'with the counter at 0. Text field input, animation progress, '
          'checkbox state — all lost without keep-alive.',
      'accent': Colors.red,
    },
    {
      'icon': Icons.push_pin,
      'title': 'KeepAlive / AutomaticKeepAlive',
      'body': 'Flutter provides two mechanisms: KeepAlive wraps a child '
          'widget directly with a keepAlive flag. AutomaticKeepAlive is '
          'inserted by SliverList/SliverGrid and listens for '
          'KeepAliveNotification from children using the mixin.',
      'accent': Colors.blue,
    },
    {
      'icon': Icons.code,
      'title': 'AutomaticKeepAliveClientMixin',
      'body': 'The standard way to keep a list item alive: mix '
          'AutomaticKeepAliveClientMixin into the item\'s State, override '
          'wantKeepAlive to return true, and call super.build(context) in '
          'the build method. The sliver then preserves the item.',
      'accent': Colors.green,
    },
  ];

  final conceptCards = <Widget>[];
  for (var idx = 0; idx < conceptItems.length; idx++) {
    final e = conceptItems[idx];
    final accent = e['accent'] as Color;
    print('Concept ${idx + 1}: ${e['title']}');
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
                child: Icon(e['icon'] as IconData, color: accent, size: 28),
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
  // SECTION 2: How It Works (mechanism)
  // ============================================================
  print('=== Section 2: Mechanism ===');

  final mechanismSteps = <Map<String, dynamic>>[
    {
      'step': '1',
      'title': 'SliverList wraps children in AutomaticKeepAlive',
      'body': 'Every child built by SliverList or SliverGrid is '
          'automatically wrapped in an AutomaticKeepAlive widget. This '
          'widget listens for KeepAliveNotifications from its subtree.',
      'icon': Icons.layers,
      'color': Colors.amber,
    },
    {
      'step': '2',
      'title': 'Child mixes in AutomaticKeepAliveClientMixin',
      'body': 'The child widget\'s State class uses '
          'AutomaticKeepAliveClientMixin and overrides wantKeepAlive. '
          'When wantKeepAlive returns true, a KeepAliveNotification is '
          'dispatched up the tree.',
      'icon': Icons.code,
      'color': Colors.blue,
    },
    {
      'step': '3',
      'title': 'AutomaticKeepAlive catches the notification',
      'body': 'The AutomaticKeepAlive widget receives the notification '
          'and wraps the child in a KeepAlive widget with keepAlive: true. '
          'This tells the sliver\'s render object to keep the child.',
      'icon': Icons.catching_pokemon,
      'color': Colors.purple,
    },
    {
      'step': '4',
      'title': 'Render sliver preserves the child',
      'body': 'When the child scrolls off-screen, the render sliver checks '
          'the KeepAlive flag. If true, it moves the child to a keep-alive '
          'bucket instead of disposing it. The State and Element persist.',
      'icon': Icons.save,
      'color': Colors.green,
    },
    {
      'step': '5',
      'title': 'Child scrolls back — instant restore',
      'body': 'When the kept-alive child scrolls back into view, it is '
          'moved from the bucket back to the active list. No rebuild, no '
          'state loss. It is the same widget instance with all state intact.',
      'icon': Icons.restore,
      'color': Colors.teal,
    },
  ];

  final mechanismCards = <Widget>[];
  for (var i = 0; i < mechanismSteps.length; i++) {
    final ms = mechanismSteps[i];
    final mColor = ms['color'] as Color;
    print('Step ${ms['step']}: ${ms['title']}');
    mechanismCards.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: mColor.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: mColor.withOpacity(0.2)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: mColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  ms['step'] as String,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: mColor,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ms['title'] as String,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: mColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    ms['body'] as String,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade700,
                      height: 1.4,
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
  // SECTION 3: Basic Usage (KeepAlive widget)
  // ============================================================
  print('=== Section 3: Basic KeepAlive ===');

  // Demonstrate KeepAlive wrapping list items
  final basicDemo = SizedBox(
    height: 380,
    child: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          title: const Text('KeepAlive Demo'),
          backgroundColor: Colors.amber.shade700,
          pinned: true,
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext ctx, int index) {
              final isKept = index.isEven;
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: isKept
                      ? Colors.amber.withOpacity(0.08)
                      : Colors.grey.withOpacity(0.04),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: isKept
                        ? Colors.amber.withOpacity(0.3)
                        : Colors.grey.withOpacity(0.15),
                  ),
                ),
                child: ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: isKept
                          ? Colors.amber.withOpacity(0.15)
                          : Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      isKept ? Icons.push_pin : Icons.push_pin_outlined,
                      color: isKept ? Colors.amber.shade700 : Colors.grey,
                      size: 20,
                    ),
                  ),
                  title: Text(
                    'Item ${index + 1}',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: isKept
                          ? Colors.amber.shade800
                          : Colors.grey.shade700,
                    ),
                  ),
                  subtitle: Text(
                    isKept
                        ? 'keepAlive: true — state preserved'
                        : 'keepAlive: false — state destroyed on scroll',
                    style: TextStyle(
                      fontSize: 11,
                      color: isKept
                          ? Colors.amber.shade600
                          : Colors.grey.shade500,
                    ),
                  ),
                  trailing: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: isKept
                          ? Colors.green.withOpacity(0.12)
                          : Colors.red.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      isKept ? 'KEPT' : 'DISPOSED',
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        color: isKept
                            ? Colors.green.shade700
                            : Colors.red.shade400,
                      ),
                    ),
                  ),
                ),
              );
            },
            childCount: 20,
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 4: Mixin Pattern
  // ============================================================
  print('=== Section 4: Mixin Pattern ===');

  final mixinSteps = <Map<String, dynamic>>[
    {
      'title': 'Step 1: Add the mixin',
      'code': 'class _MyItemState extends State<MyItem>\n'
          '    with AutomaticKeepAliveClientMixin {\n'
          '  ...\n'
          '}',
      'note': 'The mixin provides the wantKeepAlive getter and the '
          'mechanism to dispatch KeepAliveNotification.',
      'color': Colors.amber,
    },
    {
      'title': 'Step 2: Override wantKeepAlive',
      'code': '@override\n'
          'bool get wantKeepAlive => true;',
      'note': 'Return true to keep this widget alive. You can also make '
          'it conditional: return _hasUnsavedData;',
      'color': Colors.blue,
    },
    {
      'title': 'Step 3: Call super.build in build()',
      'code': '@override\n'
          'Widget build(BuildContext context) {\n'
          '  super.build(context); // REQUIRED!\n'
          '  return YourWidget(...);\n'
          '}',
      'note': 'This call triggers the KeepAliveNotification. Without it, '
          'the mixin does not work and the child will be disposed.',
      'color': Colors.green,
    },
    {
      'title': 'Step 4: Dynamic keep-alive',
      'code': 'void _onDataSaved() {\n'
          '  _hasUnsavedData = false;\n'
          '  updateKeepAlive();\n'
          '}',
      'note': 'Call updateKeepAlive() when the condition changes. This '
          're-evaluates wantKeepAlive and updates the KeepAlive widget.',
      'color': Colors.purple,
    },
  ];

  final mixinCards = <Widget>[];
  for (var i = 0; i < mixinSteps.length; i++) {
    final ms = mixinSteps[i];
    final msColor = ms['color'] as Color;
    print('Mixin ${i + 1}: ${ms['title']}');
    mixinCards.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: msColor.withOpacity(0.04),
          border: Border.all(color: msColor.withOpacity(0.25)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ms['title'] as String,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: msColor,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: msColor.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  ms['code'] as String,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12,
                    color: msColor,
                    height: 1.4,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                ms['note'] as String,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 5: Performance Impact
  // ============================================================
  print('=== Section 5: Performance ===');

  final perfItems = <Map<String, dynamic>>[
    {
      'title': 'Memory Usage',
      'body': 'Each kept-alive item retains its full widget subtree, Element, '
          'and State in memory. 100 kept-alive items with images will consume '
          'significantly more memory than 100 lazily-built items.',
      'severity': 'High',
      'icon': Icons.memory,
      'color': Colors.red,
    },
    {
      'title': 'Build Performance',
      'body': 'Kept-alive items do not need to rebuild when scrolled back. '
          'This is a performance win — no initState, no build overhead. '
          'The trade-off is memory for speed.',
      'severity': 'Positive',
      'icon': Icons.speed,
      'color': Colors.green,
    },
    {
      'title': 'Bucket Overhead',
      'body': 'Kept-alive children move to an internal "keep-alive bucket" '
          'in the render object. This is a lightweight operation but the '
          'render sliver tracks more children than it normally would.',
      'severity': 'Low',
      'icon': Icons.inventory_2,
      'color': Colors.blue,
    },
    {
      'title': 'Recommendation',
      'body': 'Use keep-alive selectively. Good candidates: items with user '
          'input (text fields, checkboxes), media players, items with '
          'expensive initialization. Bad: simple text tiles, static cards.',
      'severity': 'Guidance',
      'icon': Icons.tips_and_updates,
      'color': Colors.amber,
    },
    {
      'title': 'Dynamic Control',
      'body': 'Use conditional wantKeepAlive to keep alive only when needed. '
          'A form item might return true only while it has unsaved changes. '
          'Once saved, let it be disposed to free memory.',
      'severity': 'Best Practice',
      'icon': Icons.toggle_on,
      'color': Colors.purple,
    },
  ];

  final perfCards = <Widget>[];
  for (var i = 0; i < perfItems.length; i++) {
    final pi = perfItems[i];
    final pColor = pi['color'] as Color;
    print('Perf ${i + 1}: ${pi['title']}');
    perfCards.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: pColor.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: pColor.withOpacity(0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: pColor.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    pi['icon'] as IconData,
                    color: pColor,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    pi['title'] as String,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: pColor,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: pColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    pi['severity'] as String,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: pColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              pi['body'] as String,
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
  // SECTION 6: Use Cases
  // ============================================================
  print('=== Section 6: Use Cases ===');

  final useCases = <Map<String, dynamic>>[
    {
      'title': 'Form Fields in Lists',
      'body': 'Long forms with many fields in a scrollable list. Users fill '
          'in data and scroll to see more fields. Without keep-alive, '
          'scrolling back would erase their input.',
      'icon': Icons.edit_note,
      'example': 'Registration forms, survey inputs, settings panels',
      'color': Colors.amber,
    },
    {
      'title': 'Media Players',
      'body': 'A feed with embedded video or audio players. Each player has '
          'playback state (position, playing/paused). Keep-alive preserves '
          'the playback position when scrolling away and back.',
      'icon': Icons.play_circle,
      'example': 'Social feeds, podcast lists, tutorial playlists',
      'color': Colors.red,
    },
    {
      'title': 'Counter and Toggle Widgets',
      'body': 'Shopping carts with quantity counters, to-do lists with '
          'checkboxes. The user\'s selections persist across scrolling '
          'without needing external state management.',
      'icon': Icons.add_shopping_cart,
      'example': 'E-commerce carts, checklists, rating widgets',
      'color': Colors.green,
    },
    {
      'title': 'Animated Items',
      'body': 'List items that run entrance animations or shimmer effects. '
          'Without keep-alive, scrolling back triggers the animation again. '
          'With keep-alive, you see the final state.',
      'icon': Icons.animation,
      'example': 'Card reveal animations, progress indicators',
      'color': Colors.purple,
    },
    {
      'title': 'Expensive Initialization',
      'body': 'Items that perform expensive computations in initState — '
          'parsing data, loading resources, connecting to streams. '
          'Keep-alive avoids repeating that initialization.',
      'icon': Icons.data_object,
      'example': 'Charts, maps, WebView containers',
      'color': Colors.blue,
    },
  ];

  final useCaseCards = <Widget>[];
  for (var i = 0; i < useCases.length; i++) {
    final uc = useCases[i];
    final ucColor = uc['color'] as Color;
    print('Use case ${i + 1}: ${uc['title']}');
    useCaseCards.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: ucColor.withOpacity(0.04),
          border: Border.all(color: ucColor.withOpacity(0.25)),
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
                      color: ucColor.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      uc['icon'] as IconData,
                      color: ucColor,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      uc['title'] as String,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: ucColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                uc['body'] as String,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: ucColor.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  uc['example'] as String,
                  style: TextStyle(
                    fontSize: 11,
                    fontStyle: FontStyle.italic,
                    color: ucColor,
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
  // SECTION 7: Lifecycle Comparison
  // ============================================================
  print('=== Section 7: Lifecycle ===');

  // Visual comparison of what happens when scrolling with/without keep-alive
  final lifecyclePhases = <Map<String, dynamic>>[
    {
      'phase': 'Build',
      'without': 'initState → build → widget appears',
      'with': 'initState → build → widget appears',
      'same': true,
    },
    {
      'phase': 'Scroll Away',
      'without': 'deactivate → dispose → State destroyed',
      'with': 'deactivate → moved to keep-alive bucket',
      'same': false,
    },
    {
      'phase': 'In Bucket',
      'without': '(Widget does not exist)',
      'with': 'State alive, Element detached from render',
      'same': false,
    },
    {
      'phase': 'Scroll Back',
      'without': 'New initState → new build → fresh widget',
      'with': 'activate → widget restored → same State',
      'same': false,
    },
    {
      'phase': 'User Data',
      'without': 'Lost — counters reset, input cleared',
      'with': 'Preserved — counters, input, selections intact',
      'same': false,
    },
  ];

  final lifecycleWidgets = <Widget>[];
  for (var i = 0; i < lifecyclePhases.length; i++) {
    final lp = lifecyclePhases[i];
    final isSame = lp['same'] as bool;
    print('Lifecycle ${i + 1}: ${lp['phase']}');
    lifecycleWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSame
              ? Colors.grey.withOpacity(0.04)
              : Colors.amber.withOpacity(0.05),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSame
                ? Colors.grey.withOpacity(0.15)
                : Colors.amber.withOpacity(0.2),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.amber.withOpacity(0.12),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                lp['phase'] as String,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber.shade800,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.red.withOpacity(0.15)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Without keep-alive',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.red.shade600,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          lp['without'] as String,
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: Colors.green.withOpacity(0.15),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'With keep-alive',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.green.shade600,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          lp['with'] as String,
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey.shade700,
                          ),
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
    );
  }

  // ============================================================
  // SECTION 8: Summary
  // ============================================================
  print('=== Section 8: Summary ===');

  final summaryPoints = <Map<String, dynamic>>[
    {
      'icon': Icons.push_pin,
      'text': 'KeepAlive / AutomaticKeepAlive prevent sliver list children '
          'from being disposed when they scroll off-screen.',
    },
    {
      'icon': Icons.code,
      'text': 'Use AutomaticKeepAliveClientMixin: mix it into State, override '
          'wantKeepAlive, and call super.build(context).',
    },
    {
      'icon': Icons.memory,
      'text': 'Kept-alive children consume memory. Use selectively for items '
          'with user state, not for static content.',
    },
    {
      'icon': Icons.toggle_on,
      'text': 'Make wantKeepAlive conditional and call updateKeepAlive() when '
          'state changes — release memory when no longer needed.',
    },
    {
      'icon': Icons.speed,
      'text': 'Kept-alive items restore instantly on scroll-back, no '
          'initState or build overhead. Great for expensive widgets.',
    },
    {
      'icon': Icons.inventory_2,
      'text': 'Off-screen kept-alive children live in the render object\'s '
          'keep-alive bucket — a lightweight holding pattern.',
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
          border: Border.all(color: Colors.amber.withOpacity(0.12)),
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
                color: Colors.amber.shade700,
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
        title: const Text('Sliver KeepAlive'),
        backgroundColor: Colors.amber.shade700,
        bottom: const TabBar(
          isScrollable: true,
          indicatorColor: Colors.white,
          tabs: [
            Tab(icon: Icon(Icons.info_outline), text: 'Concept'),
            Tab(icon: Icon(Icons.settings), text: 'Mechanism'),
            Tab(icon: Icon(Icons.push_pin), text: 'Basic'),
            Tab(icon: Icon(Icons.code), text: 'Mixin'),
            Tab(icon: Icon(Icons.speed), text: 'Performance'),
            Tab(icon: Icon(Icons.apps), text: 'Use Cases'),
            Tab(icon: Icon(Icons.compare), text: 'Lifecycle'),
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
                  color: Colors.amber.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Keep-alive in slivers: prevent lazy list children from '
                  'losing their state when scrolled off-screen. The widget '
                  'stays in memory, ready for instant restoration.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...conceptCards,
            ],
          ),

          // Tab 2: Mechanism
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
                  'How the keep-alive mechanism works step by step, from '
                  'the SliverList wrapping to the render object bucket.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...mechanismCards,
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
                  color: Colors.amber.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'A list where even-indexed items use keepAlive: true '
                  '(amber, pinned icon) and odd items do not (grey). '
                  'Scroll to see which items preserve state.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: basicDemo,
                ),
              ),
            ],
          ),

          // Tab 4: Mixin Pattern
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
                  'The standard pattern for using '
                  'AutomaticKeepAliveClientMixin in stateful list items.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...mixinCards,
            ],
          ),

          // Tab 5: Performance
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
                  'Trade-offs of keeping list items alive: memory cost '
                  'vs rebuild avoidance.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...perfCards,
            ],
          ),

          // Tab 6: Use Cases
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
                  'Real-world scenarios where keep-alive is the right '
                  'choice for sliver list items.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...useCaseCards,
            ],
          ),

          // Tab 7: Lifecycle Comparison
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
                  'Side-by-side lifecycle comparison: what happens at each '
                  'phase with and without keep-alive.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...lifecycleWidgets,
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
                      Colors.amber.withOpacity(0.12),
                      Colors.orange.withOpacity(0.06),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Key takeaways about sliver keep-alive behavior.',
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
