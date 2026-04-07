// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — SharedAppData
// Demonstrates SharedAppData — an InheritedModel-based mechanism for sharing
// key-value data across the widget tree with fine-grained dependency tracking,
// lazy initialization, and efficient selective rebuilds.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SharedAppData Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptPoints = <Map<String, dynamic>>[
    {
      'icon': Icons.share,
      'title': 'Application-Wide Key-Value Store',
      'body': 'SharedAppData provides a lightweight, framework-level '
          'key-value store for sharing state across the widget tree. '
          'It sits above your app in the tree, created automatically '
          'by WidgetsApp (MaterialApp, CupertinoApp).',
    },
    {
      'icon': Icons.refresh,
      'title': 'InheritedModel-Based Rebuilds',
      'body': 'Widgets that read a key only rebuild when THAT key changes, '
          'not when any other key changes. This is achieved via '
          'InheritedModel aspect-based dependency tracking.',
    },
    {
      'icon': Icons.code,
      'title': 'Static API: getValue / setValue',
      'body': 'Two static methods: getValue(context, key, init) reads the '
          'current value or lazily creates it. setValue(context, key, value) '
          'updates a value and only rebuilds dependent widgets.',
    },
    {
      'icon': Icons.key,
      'title': 'Collision-Free Keys',
      'body': 'Use static final Object() keys to guarantee uniqueness. '
          'String keys risk collisions between unrelated packages. '
          'Object identity provides guaranteed isolation.',
    },
  ];

  final conceptCards = <Widget>[];
  for (var i = 0; i < conceptPoints.length; i++) {
    final p = conceptPoints[i];
    print('Concept ${i + 1}: ${p['title']}');
    conceptCards.add(
      Container(
        margin: const EdgeInsets.only(bottom: 10.0),
        padding: const EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: Colors.indigo.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.indigo.withValues(alpha: 0.2)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(p['icon'] as IconData, color: Colors.indigo.shade700, size: 26.0),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    p['title'] as String,
                    style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700,
                        color: Colors.indigo.shade700),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    p['body'] as String,
                    style: TextStyle(fontSize: 12.5, color: Colors.grey.shade800, height: 1.4),
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
  // SECTION 2: Static API
  // ============================================================
  print('=== Section 2: Static API ===');

  final apiMethods = <Map<String, dynamic>>[
    {
      'method': 'getValue<K extends Object, V>',
      'signature': 'static V getValue<K extends Object, V>(\n'
          '  BuildContext context,\n'
          '  K key,\n'
          '  SharedAppDataInitCallback<V> init,\n'
          ')',
      'desc': 'Reads the value for the given key. If the key has not been '
          'set yet, calls init() to create the initial value. '
          'Creates a dependency on this specific key — widget rebuilds '
          'only when this key is updated.',
      'color': Colors.blue,
    },
    {
      'method': 'setValue<K extends Object, V>',
      'signature': 'static void setValue<K extends Object, V>(\n'
          '  BuildContext context,\n'
          '  K key,\n'
          '  V value,\n'
          ')',
      'desc': 'Sets a new value for the given key. Triggers a rebuild of '
          'all widgets that depend on this key via getValue. Uses == '
          'comparison — if the value has not changed, no rebuild occurs.',
      'color': Colors.green,
    },
  ];

  final apiCards = <Widget>[];
  for (final m in apiMethods) {
    final color = m['color'] as Color;
    apiCards.add(
      Container(
        margin: const EdgeInsets.only(bottom: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.06),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(9.0)),
              ),
              child: Text(m['method'] as String,
                  style: TextStyle(fontSize: 12.0, fontFamily: 'monospace',
                      fontWeight: FontWeight.w700, color: color)),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(6.0),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Text(m['signature'] as String,
                        style: TextStyle(fontSize: 10.0, fontFamily: 'monospace',
                            color: Colors.grey.shade700)),
                  ),
                  const SizedBox(height: 8.0),
                  Text(m['desc'] as String,
                      style: TextStyle(fontSize: 11.5, color: Colors.grey.shade600, height: 1.35)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 3: Key Strategy
  // ============================================================
  print('=== Section 3: Key Strategy ===');

  final keyStrategies = <Map<String, dynamic>>[
    {
      'title': 'Object() Keys (Recommended)',
      'icon': Icons.check_circle,
      'color': Colors.green,
      'code': 'class MyFeature {\n'
          '  // Private, unique, collision-free\n'
          '  static final _themeKey = Object();\n'
          '  static final _localeKey = Object();\n'
          '\n'
          '  static String getTheme(\n'
          '      BuildContext ctx) =>\n'
          '    SharedAppData.getValue(\n'
          '      ctx, _themeKey, () => "light");\n'
          '}',
      'desc': 'Object identity guarantees uniqueness. Keep keys private '
          'to prevent external access. Each feature creates its own keys.',
    },
    {
      'title': 'String Keys (Risky)',
      'icon': Icons.warning_amber,
      'color': Colors.orange,
      'code': '// Risk: another package might\n'
          '// use the same key!\n'
          'SharedAppData.getValue(\n'
          '  context,\n'
          '  "theme_mode",  // Collision!\n'
          '  () => "light",\n'
          ');',
      'desc': 'String keys are readable but risk collisions between unrelated '
          'packages or features. Only use if you control the full key space.',
    },
    {
      'title': 'Enum Keys (Typed)',
      'icon': Icons.category,
      'color': Colors.blue,
      'code': 'enum AppDataKey {\n'
          '  theme, locale, fontSize\n'
          '}\n'
          '\n'
          'SharedAppData.getValue(\n'
          '  context,\n'
          '  AppDataKey.theme,\n'
          '  () => "light",\n'
          ');',
      'desc': 'Enum keys combine readability with type safety but require '
          'a shared enum definition. Good for single-app use cases.',
    },
  ];

  final keyCards = <Widget>[];
  for (final ks in keyStrategies) {
    final color = ks['color'] as Color;
    keyCards.add(
      Container(
        margin: const EdgeInsets.only(bottom: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.06),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(9.0)),
              ),
              child: Row(
                children: [
                  Icon(ks['icon'] as IconData, size: 18.0, color: color),
                  const SizedBox(width: 8.0),
                  Text(ks['title'] as String,
                      style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700, color: color)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(6.0),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Text(ks['code'] as String,
                        style: TextStyle(fontSize: 10.0, fontFamily: 'monospace',
                            color: Colors.grey.shade700)),
                  ),
                  const SizedBox(height: 8.0),
                  Text(ks['desc'] as String,
                      style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600, height: 1.3)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 4: DependencyTracker Demo
  // ============================================================
  print('=== Section 4: Dependency Tracker ===');

  final depDemo = _SADDependencyDemo();

  // ============================================================
  // SECTION 5: Live Demo
  // ============================================================
  print('=== Section 5: Live Demo ===');

  final liveDemo = _SADLiveDemo();

  // ============================================================
  // SECTION 6: Comparison
  // ============================================================
  print('=== Section 6: Comparison ===');

  final comparisonRows = <Map<String, dynamic>>[
    {
      'feature': 'Scope',
      'sad': 'App-wide (above MaterialApp)',
      'iw': 'Subtree-local',
      'provider': 'Flexible (any scope)',
    },
    {
      'feature': 'Data Model',
      'sad': 'Key-value Map<Object, Object>',
      'iw': 'Single typed value',
      'provider': 'Single typed value',
    },
    {
      'feature': 'Selective Rebuild',
      'sad': 'Per-key (InheritedModel)',
      'iw': 'All dependents',
      'provider': 'Per-selector',
    },
    {
      'feature': 'Setup Required',
      'sad': 'None (auto in WidgetsApp)',
      'iw': 'Create InheritedWidget subclass',
      'provider': 'Add Provider widget',
    },
    {
      'feature': 'Type Safety',
      'sad': 'Generic K/V, cast at call site',
      'iw': 'Strong: typed at definition',
      'provider': 'Strong: typed at definition',
    },
    {
      'feature': 'Best For',
      'sad': 'Simple cross-cutting settings',
      'iw': 'Stable config data',
      'provider': 'Complex state management',
    },
  ];

  final compRows = <Widget>[];
  for (var i = 0; i < comparisonRows.length; i++) {
    final r = comparisonRows[i];
    compRows.add(
      Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
        decoration: BoxDecoration(
          color: i.isEven ? Colors.grey.shade50 : Colors.white,
          border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 72.0,
              child: Text(r['feature'] as String,
                  style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.w700,
                      color: Colors.grey.shade700)),
            ),
            Expanded(
              child: Text(r['sad'] as String,
                  style: TextStyle(fontSize: 9.0, color: Colors.indigo.shade700)),
            ),
            Expanded(
              child: Text(r['iw'] as String,
                  style: TextStyle(fontSize: 9.0, color: Colors.grey.shade600)),
            ),
            Expanded(
              child: Text(r['provider'] as String,
                  style: TextStyle(fontSize: 9.0, color: Colors.grey.shade600)),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 7: Patterns & Anti-Patterns
  // ============================================================
  print('=== Section 7: Patterns ===');

  final patterns = <Map<String, dynamic>>[
    {
      'title': 'Wrapper Class Pattern',
      'isGood': true,
      'icon': Icons.check_circle,
      'color': Colors.green,
      'code': 'class AppSettings {\n'
          '  static final _key = Object();\n'
          '\n'
          '  static int getFontSize(\n'
          '      BuildContext ctx) =>\n'
          '    SharedAppData.getValue(\n'
          '      ctx, _key, () => 14);\n'
          '\n'
          '  static void setFontSize(\n'
          '      BuildContext ctx, int v) =>\n'
          '    SharedAppData.setValue(\n'
          '      ctx, _key, v);\n'
          '}',
      'desc': 'Encapsulates key management. Provides a clean, typed '
          'API without exposing internal keys.',
    },
    {
      'title': 'Storing Complex Objects',
      'isGood': false,
      'icon': Icons.cancel,
      'color': Colors.red,
      'code': '// Bad: storing mutable state\n'
          'SharedAppData.setValue(\n'
          '  context, key,\n'
          '  UserProfile(name, email),\n'
          ');\n'
          '// == comparison will always\n'
          '// return false (new instance),\n'
          '// causing unnecessary rebuilds.',
      'desc': 'SharedAppData uses == for change detection. Mutable objects '
          'without equals/hashCode cause rebuilds on every setValue.',
    },
    {
      'title': 'Lazy Initialization',
      'isGood': true,
      'icon': Icons.check_circle,
      'color': Colors.green,
      'code': '// Good: expensive init runs\n'
          '// only on first access\n'
          'final config = SharedAppData\n'
          '  .getValue(context, _configKey,\n'
          '    () => loadDefaultConfig());\n'
          '\n'
          '// Subsequent calls return\n'
          '// the cached value',
      'desc': 'The init callback is only called once, when the key is first '
          'accessed. This is ideal for expensive computations.',
    },
    {
      'title': 'Accessing Outside Build',
      'isGood': false,
      'icon': Icons.cancel,
      'color': Colors.red,
      'code': '// Bad: creates dependency in\n'
          '// wrong lifecycle phase\n'
          'void initState() {\n'
          '  super.initState();\n'
          '  // WRONG - context not safe\n'
          '  val = SharedAppData.getValue(\n'
          '    context, key, () => 0);\n'
          '}',
      'desc': 'getValue creates a dependency, so it must only be called '
          'during build(). Use didChangeDependencies() if you need the '
          'value outside build.',
    },
  ];

  final patternCards = <Widget>[];
  for (final pat in patterns) {
    final color = pat['color'] as Color;
    final isGood = pat['isGood'] as bool;
    patternCards.add(
      Container(
        margin: const EdgeInsets.only(bottom: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.06),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(9.0)),
              ),
              child: Row(
                children: [
                  Icon(pat['icon'] as IconData, size: 16.0, color: color),
                  const SizedBox(width: 6.0),
                  Text(isGood ? 'DO' : 'DO NOT',
                      style: TextStyle(fontSize: 9.0, fontWeight: FontWeight.w900, color: color)),
                  const SizedBox(width: 6.0),
                  Expanded(
                    child: Text(pat['title'] as String,
                        style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700,
                            color: Colors.grey.shade800)),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(6.0),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Text(pat['code'] as String,
                        style: TextStyle(fontSize: 10.0, fontFamily: 'monospace',
                            color: Colors.grey.shade700)),
                  ),
                  const SizedBox(height: 8.0),
                  Text(pat['desc'] as String,
                      style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600, height: 1.3)),
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
    {'icon': Icons.share, 'text': 'SharedAppData is an InheritedModel-based app-wide key-value store'},
    {'icon': Icons.code, 'text': 'Static API: getValue(context, key, init) and setValue(context, key, value)'},
    {'icon': Icons.key, 'text': 'Use Object() keys for collision-free isolation between features'},
    {'icon': Icons.refresh, 'text': 'Selective rebuilds: only widgets that read a changed key rebuild'},
    {'icon': Icons.auto_fix_high, 'text': 'Lazy init: the init callback runs only on first access of each key'},
    {'icon': Icons.widgets, 'text': 'Auto-created: WidgetsApp / MaterialApp includes it in the tree'},
  ];

  final summaryItems = <Widget>[];
  for (final sp in summaryPoints) {
    summaryItems.add(
      Padding(
        padding: const EdgeInsets.only(bottom: 6.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(sp['icon'] as IconData, size: 16.0, color: Colors.indigo.shade700),
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(sp['text'] as String,
                  style: TextStyle(fontSize: 12.5, color: Colors.grey.shade800, height: 1.3)),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // BUILD TABBED LAYOUT
  // ============================================================
  print('Building tabbed layout');

  return DefaultTabController(
    length: 8,
    child: Scaffold(
      appBar: AppBar(
        title: const Text('SharedAppData'),
        backgroundColor: Colors.indigo.shade700,
        foregroundColor: Colors.white,
        elevation: 2.0,
        bottom: const TabBar(
          isScrollable: true,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: [
            Tab(text: 'Concept'),
            Tab(text: 'Static API'),
            Tab(text: 'Key Strategy'),
            Tab(text: 'Dependencies'),
            Tab(text: 'Live Demo'),
            Tab(text: 'Comparison'),
            Tab(text: 'Patterns'),
            Tab(text: 'Summary'),
          ],
        ),
      ),
      body: TabBarView(
        children: [
          // Tab 1: Concept
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSADBullet('SharedAppData',
                    'Framework-level InheritedModel that provides a key-value '
                    'store accessible from anywhere in the widget tree.'),
                const SizedBox(height: 14.0),
                ...conceptCards,
              ],
            ),
          ),
          // Tab 2: Static API
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSADBullet('Static Methods',
                    'SharedAppData exposes two static methods for reading '
                    'and writing shared data.'),
                const SizedBox(height: 14.0),
                ...apiCards,
                const SizedBox(height: 10.0),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Colors.amber.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.amber.shade300),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.info_outline, size: 14.0,
                              color: Colors.amber.shade800),
                          const SizedBox(width: 6.0),
                          Text('SharedAppDataInitCallback',
                              style: TextStyle(fontSize: 11.0, fontFamily: 'monospace',
                                  fontWeight: FontWeight.w700, color: Colors.amber.shade800)),
                        ],
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        'typedef SharedAppDataInitCallback<T> = T Function()\n\n'
                        'The callback is invoked lazily — only when getValue is '
                        'called for a key that has no value yet. After the first '
                        'call, the returned value is cached.',
                        style: TextStyle(fontSize: 10.5, color: Colors.grey.shade700, height: 1.35),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Tab 3: Key Strategy
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSADBullet('Key Selection Strategies',
                    'How you choose keys affects isolation, readability, '
                    'and collision safety.'),
                const SizedBox(height: 14.0),
                ...keyCards,
              ],
            ),
          ),
          // Tab 4: Dependencies
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSADBullet('Dependency Tracking',
                    'Visualize which widgets rebuild when specific keys change.'),
                const SizedBox(height: 14.0),
                depDemo,
              ],
            ),
          ),
          // Tab 5: Live Demo
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSADBullet('Interactive Key-Value Store',
                    'Add, modify, and remove key-value pairs. Observe '
                    'how dependent widgets respond to changes.'),
                const SizedBox(height: 14.0),
                liveDemo,
              ],
            ),
          ),
          // Tab 6: Comparison
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSADBullet('Comparison with Alternatives',
                    'SharedAppData vs InheritedWidget vs Provider.'),
                const SizedBox(height: 14.0),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 10.0),
                        decoration: BoxDecoration(
                          color: Colors.indigo.withValues(alpha: 0.06),
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(9.0)),
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 72.0,
                              child: Text('Feature',
                                  style: TextStyle(fontSize: 9.5,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.grey.shade700)),
                            ),
                            Expanded(
                              child: Text('SharedAppData',
                                  style: TextStyle(fontSize: 9.0,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.indigo)),
                            ),
                            Expanded(
                              child: Text('InheritedWidget',
                                  style: TextStyle(fontSize: 9.0,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.grey.shade600)),
                            ),
                            Expanded(
                              child: Text('Provider',
                                  style: TextStyle(fontSize: 9.0,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.grey.shade600)),
                            ),
                          ],
                        ),
                      ),
                      ...compRows,
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Tab 7: Patterns
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSADBullet('Patterns and Anti-Patterns',
                    'Best practices for using SharedAppData effectively.'),
                const SizedBox(height: 14.0),
                ...patternCards,
              ],
            ),
          ),
          // Tab 8: Summary
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSADBullet('Key Takeaways', ''),
                const SizedBox(height: 10.0),
                Container(
                  padding: const EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.indigo.withValues(alpha: 0.05),
                        Colors.blue.withValues(alpha: 0.05),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.indigo.withValues(alpha: 0.2)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: summaryItems,
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

// ---------------------------------------------------------------------------
// Helper: section bullet
// ---------------------------------------------------------------------------
Widget _buildSADBullet(String title, String body) {
  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.indigo.withValues(alpha: 0.04),
      borderRadius: BorderRadius.circular(8.0),
      border: Border(left: BorderSide(color: Colors.indigo.shade700, width: 3.0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700,
            color: Colors.indigo.shade700)),
        if (body.isNotEmpty) ...[
          const SizedBox(height: 4.0),
          Text(body, style: TextStyle(fontSize: 13.0, color: Colors.grey.shade700, height: 1.4)),
        ],
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Dependency Tracking Visualization
// ---------------------------------------------------------------------------
class _SADDependencyDemo extends StatefulWidget {
  @override
  State<_SADDependencyDemo> createState() => _SADDependencyDemoState();
}

class _SADDependencyDemoState extends State<_SADDependencyDemo> {
  String? _changedKey;
  final _keys = ['theme', 'locale', 'fontSize', 'darkMode'];
  final _widgets = <Map<String, dynamic>>[
    {'name': 'AppBar', 'deps': ['theme', 'darkMode'], 'icon': Icons.web_asset},
    {'name': 'Body', 'deps': ['theme', 'fontSize'], 'icon': Icons.article},
    {'name': 'Footer', 'deps': ['locale'], 'icon': Icons.notes},
    {'name': 'Drawer', 'deps': ['theme', 'locale', 'darkMode'], 'icon': Icons.menu},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Tap a key to see which widgets would rebuild',
              style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700)),
          const SizedBox(height: 12.0),
          // Key buttons
          Wrap(
            spacing: 8.0,
            runSpacing: 6.0,
            children: _keys.map((k) {
              final isSelected = _changedKey == k;
              return GestureDetector(
                onTap: () => setState(() {
                  _changedKey = isSelected ? null : k;
                }),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Colors.indigo.shade700
                        : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(16.0),
                    border: Border.all(
                      color: isSelected ? Colors.indigo.shade700 : Colors.grey.shade300,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.key, size: 12.0,
                          color: isSelected ? Colors.white : Colors.grey),
                      const SizedBox(width: 4.0),
                      Text(k, style: TextStyle(fontSize: 11.0,
                          fontFamily: 'monospace', fontWeight: FontWeight.w600,
                          color: isSelected ? Colors.white : Colors.grey.shade700)),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16.0),
          // Widget grid
          ...(_widgets.map((w) {
            final deps = w['deps'] as List<String>;
            final wouldRebuild = _changedKey != null && deps.contains(_changedKey);
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.only(bottom: 8.0),
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: wouldRebuild
                    ? Colors.indigo.withValues(alpha: 0.08)
                    : Colors.grey.shade50,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  color: wouldRebuild
                      ? Colors.indigo.shade400
                      : Colors.grey.shade200,
                  width: wouldRebuild ? 2.0 : 1.0,
                ),
              ),
              child: Row(
                children: [
                  Icon(w['icon'] as IconData, size: 18.0,
                      color: wouldRebuild ? Colors.indigo.shade700 : Colors.grey.shade400),
                  const SizedBox(width: 8.0),
                  Text(w['name'] as String,
                      style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700,
                          color: wouldRebuild ? Colors.indigo.shade700 : Colors.grey.shade600)),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Wrap(
                      spacing: 4.0,
                      children: deps.map((d) {
                        final isChanging = d == _changedKey;
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                          decoration: BoxDecoration(
                            color: isChanging
                                ? Colors.indigo.withValues(alpha: 0.15)
                                : Colors.grey.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Text(d, style: TextStyle(fontSize: 8.5,
                              fontFamily: 'monospace',
                              fontWeight: isChanging ? FontWeight.w700 : FontWeight.w400,
                              color: isChanging ? Colors.indigo.shade700 : Colors.grey.shade500)),
                        );
                      }).toList(),
                    ),
                  ),
                  if (wouldRebuild)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                      decoration: BoxDecoration(
                        color: Colors.orange.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Text('REBUILD', style: TextStyle(fontSize: 8.0,
                          fontWeight: FontWeight.w900, color: Colors.orange.shade700)),
                    ),
                ],
              ),
            );
          })),
          if (_changedKey != null) ...[
            const SizedBox(height: 8.0),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.indigo.withValues(alpha: 0.04),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text(
                'setValue(context, "$_changedKey", newValue) -> '
                '${_widgets.where((w) => (w['deps'] as List<String>).contains(_changedKey)).map((w) => w['name']).join(', ')} '
                'would rebuild',
                style: TextStyle(fontSize: 10.0, fontFamily: 'monospace',
                    color: Colors.indigo.shade700),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Live Demo: Interactive Key-Value Store
// ---------------------------------------------------------------------------
class _SADLiveDemo extends StatefulWidget {
  @override
  State<_SADLiveDemo> createState() => _SADLiveDemoState();
}

class _SADLiveDemoState extends State<_SADLiveDemo> {
  final _store = <String, String>{
    'theme': 'light',
    'fontSize': '14',
    'language': 'English',
  };
  String _selectedKey = 'theme';
  int _rebuildCount = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('Key-Value Store Simulation',
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700)),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: Colors.indigo.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Text(
                  'Rebuilds: $_rebuildCount',
                  style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w700,
                      color: Colors.indigo.shade700),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14.0),
          // Current store contents
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Current Store Contents:',
                    style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w700,
                        color: Colors.grey.shade600)),
                const SizedBox(height: 6.0),
                ..._store.entries.map((e) {
                  final isSelected = e.key == _selectedKey;
                  return Container(
                    margin: const EdgeInsets.only(bottom: 4.0),
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.indigo.withValues(alpha: 0.1)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(4.0),
                      border: Border.all(
                        color: isSelected
                            ? Colors.indigo.shade300
                            : Colors.grey.shade200,
                      ),
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => setState(() => _selectedKey = e.key),
                          child: Icon(
                            isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
                            size: 14.0,
                            color: isSelected ? Colors.indigo : Colors.grey,
                          ),
                        ),
                        const SizedBox(width: 6.0),
                        Text('"${e.key}"',
                            style: TextStyle(fontSize: 10.0, fontFamily: 'monospace',
                                fontWeight: FontWeight.w700, color: Colors.indigo.shade700)),
                        const SizedBox(width: 4.0),
                        Icon(Icons.arrow_forward, size: 10.0, color: Colors.grey),
                        const SizedBox(width: 4.0),
                        Expanded(
                          child: Text('"${e.value}"',
                              style: TextStyle(fontSize: 10.0, fontFamily: 'monospace',
                                  color: Colors.grey.shade600)),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
          const SizedBox(height: 12.0),
          // Actions
          Row(
            children: [
              Text('Selected: "$_selectedKey"',
                  style: TextStyle(fontSize: 11.0, fontFamily: 'monospace',
                      fontWeight: FontWeight.w600, color: Colors.indigo.shade700)),
            ],
          ),
          const SizedBox(height: 8.0),
          // Quick value buttons
          Wrap(
            spacing: 6.0,
            runSpacing: 6.0,
            children: [
              _buildActionButton('Toggle Value', Icons.swap_horiz, Colors.blue, () {
                setState(() {
                  _rebuildCount++;
                  final current = _store[_selectedKey] ?? '';
                  if (_selectedKey == 'theme') {
                    _store[_selectedKey] = current == 'light' ? 'dark' : 'light';
                  } else if (_selectedKey == 'fontSize') {
                    final size = int.tryParse(current) ?? 14;
                    _store[_selectedKey] = '${size == 14 ? 18 : size == 18 ? 22 : 14}';
                  } else if (_selectedKey == 'language') {
                    _store[_selectedKey] = current == 'English' ? 'German' : 'English';
                  }
                });
              }),
              _buildActionButton('Add Key', Icons.add, Colors.green, () {
                setState(() {
                  _rebuildCount++;
                  final newKey = 'key_${_store.length}';
                  _store[newKey] = 'value_${_store.length}';
                  _selectedKey = newKey;
                });
              }),
              _buildActionButton('Remove Key', Icons.delete, Colors.red, () {
                if (_store.length > 1) {
                  setState(() {
                    _rebuildCount++;
                    _store.remove(_selectedKey);
                    _selectedKey = _store.keys.first;
                  });
                }
              }),
              _buildActionButton('Reset', Icons.restart_alt, Colors.grey, () {
                setState(() {
                  _rebuildCount = 0;
                  _store
                    ..clear()
                    ..addAll({
                      'theme': 'light',
                      'fontSize': '14',
                      'language': 'English',
                    });
                  _selectedKey = 'theme';
                });
              }),
            ],
          ),
          const SizedBox(height: 12.0),
          // Preview
          _buildPreviewPanel(),
        ],
      ),
    );
  }

  Widget _buildActionButton(String label, IconData icon, Color color,
      VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(6.0),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 12.0, color: color),
            const SizedBox(width: 4.0),
            Text(label, style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w600,
                color: color)),
          ],
        ),
      ),
    );
  }

  Widget _buildPreviewPanel() {
    final isDark = _store['theme'] == 'dark';
    final fontSize = double.tryParse(_store['fontSize'] ?? '14') ?? 14.0;
    final lang = _store['language'] ?? 'English';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey.shade900 : Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: isDark ? Colors.grey.shade700 : Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Live Preview (reads all keys)',
              style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w700,
                  color: isDark ? Colors.white70 : Colors.grey.shade600)),
          const SizedBox(height: 8.0),
          Text(
            lang == 'English'
                ? 'Hello! This text reflects the current store values.'
                : 'Hallo! Dieser Text spiegelt die aktuellen Store-Werte wider.',
            style: TextStyle(
              fontSize: fontSize,
              color: isDark ? Colors.white : Colors.grey.shade800,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4.0),
          Row(
            children: [
              Container(
                width: 12.0,
                height: 12.0,
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey.shade800 : Colors.white,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(2.0),
                ),
              ),
              const SizedBox(width: 4.0),
              Text('theme=${ _store['theme']}',
                  style: TextStyle(fontSize: 9.0, fontFamily: 'monospace',
                      color: isDark ? Colors.white54 : Colors.grey.shade500)),
              const SizedBox(width: 8.0),
              Text('size=${fontSize.toInt()}',
                  style: TextStyle(fontSize: 9.0, fontFamily: 'monospace',
                      color: isDark ? Colors.white54 : Colors.grey.shade500)),
              const SizedBox(width: 8.0),
              Text('lang=$lang',
                  style: TextStyle(fontSize: 9.0, fontFamily: 'monospace',
                      color: isDark ? Colors.white54 : Colors.grey.shade500)),
            ],
          ),
        ],
      ),
    );
  }
}
