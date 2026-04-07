// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — ShortcutRegistrar
// Demonstrates ShortcutRegistrar — a widget that creates and provides a
// ShortcutRegistry and ShortcutManager to its subtree, enabling dynamic
// registration of keyboard shortcuts from anywhere in the widget tree.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ShortcutRegistrar Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptPoints = <Map<String, dynamic>>[
    {
      'icon': Icons.keyboard,
      'title': 'Keyboard Shortcut Host Widget',
      'body': 'ShortcutRegistrar creates a ShortcutRegistry and '
          'ShortcutManager, then places them in the widget tree via '
          'an InheritedWidget scope. Descendant widgets can register '
          'shortcuts dynamically without modifying the parent.',
    },
    {
      'icon': Icons.auto_fix_high,
      'title': 'Pre-installed by MaterialApp',
      'body': 'MaterialApp, CupertinoApp, and WidgetsApp all include a '
          'ShortcutRegistrar above your app. You rarely need to create '
          'one yourself — just use ShortcutRegistry.of(context) to '
          'access the existing one.',
    },
    {
      'icon': Icons.add_circle,
      'title': 'Dynamic Registration',
      'body': 'Unlike the Shortcuts widget (static map), ShortcutRegistrar '
          'allows widgets to register shortcuts at any point in their '
          'lifecycle. Register on mount, unregister on dispose.',
    },
    {
      'icon': Icons.merge_type,
      'title': 'Shortcut Merging',
      'body': 'The ShortcutManager receives the merged map of all '
          'registered shortcuts. Later registrations override earlier '
          'ones with the same activator. The ShortcutRegistrar forwards '
          'this merged map to a Shortcuts.manager() widget internally.',
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
          color: Colors.teal.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.teal.withValues(alpha: 0.2)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(p['icon'] as IconData, color: Colors.teal.shade700, size: 26.0),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    p['title'] as String,
                    style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700,
                        color: Colors.teal.shade700),
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
  // SECTION 2: Architecture
  // ============================================================
  print('=== Section 2: Architecture ===');

  final archLayers = <Map<String, dynamic>>[
    {
      'name': 'ShortcutRegistrar',
      'type': 'StatefulWidget',
      'color': Colors.teal,
      'desc': 'The outer widget. Creates both ShortcutRegistry and '
          'ShortcutManager in its State. Only parameter: child.',
    },
    {
      'name': '_ShortcutRegistrarScope',
      'type': 'InheritedWidget',
      'color': Colors.blue,
      'desc': 'Internal InheritedWidget that exposes the ShortcutRegistry '
          'to descendants via ShortcutRegistry.of(context).',
    },
    {
      'name': 'Shortcuts.manager()',
      'type': 'Widget',
      'color': Colors.purple,
      'desc': 'Receives the ShortcutManager from ShortcutRegistrar. '
          'The manager holds the merged shortcut map and processes '
          'key events.',
    },
    {
      'name': 'ShortcutRegistry',
      'type': 'ChangeNotifier',
      'color': Colors.orange,
      'desc': 'Holds all registered shortcut entries. Notifies the '
          'ShortcutManager when shortcuts change. Managed by the '
          'ShortcutRegistrar state.',
    },
    {
      'name': 'ShortcutManager',
      'type': 'ChangeNotifier',
      'color': Colors.red,
      'desc': 'Processes key events and invokes Actions. Receives '
          'the shortcut map from ShortcutRegistry.',
    },
  ];

  final archCards = <Widget>[];
  for (var i = 0; i < archLayers.length; i++) {
    final layer = archLayers[i];
    final color = layer['color'] as Color;
    archCards.add(
      Container(
        margin: EdgeInsets.only(left: i * 8.0, bottom: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            Container(
              width: 4.0,
              height: 60.0,
              decoration: BoxDecoration(
                color: color,
                borderRadius: const BorderRadius.horizontal(left: Radius.circular(7.0)),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(layer['name'] as String,
                            style: TextStyle(fontSize: 11.0, fontFamily: 'monospace',
                                fontWeight: FontWeight.w700, color: color)),
                        const SizedBox(width: 6.0),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 1.0),
                          decoration: BoxDecoration(
                            color: color.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(3.0),
                          ),
                          child: Text(layer['type'] as String,
                              style: TextStyle(fontSize: 8.0, fontFamily: 'monospace',
                                  color: color)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4.0),
                    Text(layer['desc'] as String,
                        style: TextStyle(fontSize: 10.5, color: Colors.grey.shade600, height: 1.3)),
                  ],
                ),
              ),
            ),
            if (i < archLayers.length - 1)
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(Icons.arrow_downward, size: 14.0, color: Colors.grey.shade400),
              ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 3: Widget Tree
  // ============================================================
  print('=== Section 3: Widget Tree ===');

  final treeDemo = _SRTreeDemo();

  // ============================================================
  // SECTION 4: Usage Patterns
  // ============================================================
  print('=== Section 4: Usage Patterns ===');

  final usagePatterns = <Map<String, dynamic>>[
    {
      'title': 'Register in initState',
      'icon': Icons.play_arrow,
      'color': Colors.green,
      'code': 'late ShortcutRegistryEntry _entry;\n'
          '\n'
          '@override\n'
          'void initState() {\n'
          '  super.initState();\n'
          '  _entry = ShortcutRegistry.of(\n'
          '    context\n'
          '  ).addAll(<ShortcutActivator,\n'
          '    Intent>{\n'
          '    SingleActivator(\n'
          '      LogicalKeyboardKey.keyS,\n'
          '      control: true,\n'
          '    ): const SaveIntent(),\n'
          '  });\n'
          '}',
      'desc': 'Register shortcuts when the widget mounts. The entry '
          'tracks ownership for clean disposal.',
    },
    {
      'title': 'Dispose Entry',
      'icon': Icons.stop,
      'color': Colors.red,
      'code': '@override\n'
          'void dispose() {\n'
          '  _entry.dispose();\n'
          '  super.dispose();\n'
          '}',
      'desc': 'Always dispose the entry to unregister shortcuts and '
          'prevent memory leaks. The registry removes the entry from '
          'its merged map.',
    },
    {
      'title': 'Replace Shortcuts',
      'icon': Icons.swap_horiz,
      'color': Colors.blue,
      'code': '// Update registered shortcuts\n'
          '_entry.replaceAll(\n'
          '  <ShortcutActivator, Intent>{\n'
          '    SingleActivator(\n'
          '      LogicalKeyboardKey.keyZ,\n'
          '      control: true,\n'
          '    ): const UndoIntent(),\n'
          '    SingleActivator(\n'
          '      LogicalKeyboardKey.keyZ,\n'
          '      control: true,\n'
          '      shift: true,\n'
          '    ): const RedoIntent(),\n'
          '  },\n'
          ');',
      'desc': 'Replace all shortcuts in an entry without create/dispose. '
          'The registry updates its merged map and notifies.',
    },
    {
      'title': 'Multiple Entries',
      'icon': Icons.layers,
      'color': Colors.purple,
      'code': '// Each feature registers\n'
          '// its own entry\n'
          'final editEntry = registry.addAll(\n'
          '  editShortcuts);\n'
          'final navEntry = registry.addAll(\n'
          '  navigationShortcuts);\n'
          'final helpEntry = registry.addAll(\n'
          '  helpShortcuts);\n'
          '\n'
          '// Dispose independently\n'
          'editEntry.dispose();',
      'desc': 'Multiple widgets/features can register separate entries. '
          'Each entry is independently disposable.',
    },
  ];

  final usageCards = <Widget>[];
  for (final u in usagePatterns) {
    final color = u['color'] as Color;
    usageCards.add(
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
                  Icon(u['icon'] as IconData, size: 16.0, color: color),
                  const SizedBox(width: 6.0),
                  Text(u['title'] as String,
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
                    child: Text(u['code'] as String,
                        style: TextStyle(fontSize: 10.0, fontFamily: 'monospace',
                            color: Colors.grey.shade700)),
                  ),
                  const SizedBox(height: 8.0),
                  Text(u['desc'] as String,
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
  // SECTION 5: Live Demo
  // ============================================================
  print('=== Section 5: Live Demo ===');

  final liveDemo = _SRLiveDemo();

  // ============================================================
  // SECTION 6: Custom vs Default
  // ============================================================
  print('=== Section 6: Custom vs Default ===');

  final customVsDefault = <Map<String, dynamic>>[
    {
      'title': 'Using Default (MaterialApp provided)',
      'icon': Icons.check_circle,
      'color': Colors.green,
      'isRecommended': true,
      'code': '// MaterialApp automatically\n'
          '// includes ShortcutRegistrar\n'
          'class MyWidget extends StatefulWidget {\n'
          '  @override\n'
          '  State<MyWidget> createState() =>\n'
          '    _MyWidgetState();\n'
          '}\n'
          '\n'
          'class _MyWidgetState\n'
          '    extends State<MyWidget> {\n'
          '  late ShortcutRegistryEntry _e;\n'
          '\n'
          '  @override\n'
          '  void initState() {\n'
          '    super.initState();\n'
          '    _e = ShortcutRegistry.of(\n'
          '      context).addAll(myShortcuts);\n'
          '  }\n'
          '}',
      'desc': 'The most common case: just access the existing registry. '
          'No need to wrap anything in ShortcutRegistrar.',
    },
    {
      'title': 'Custom ShortcutRegistrar',
      'icon': Icons.settings,
      'color': Colors.orange,
      'isRecommended': false,
      'code': '// Only needed for isolated\n'
          '// shortcut scopes\n'
          'ShortcutRegistrar(\n'
          '  child: MyIsolatedPanel(),\n'
          ')',
      'desc': 'Use a custom ShortcutRegistrar when you need isolated '
          'shortcut scopes — for example, a panel that should not '
          'inherit or affect the main app shortcuts.',
    },
  ];

  final cvdCards = <Widget>[];
  for (final item in customVsDefault) {
    final color = item['color'] as Color;
    cvdCards.add(
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
                  Icon(item['icon'] as IconData, size: 16.0, color: color),
                  const SizedBox(width: 6.0),
                  Expanded(
                    child: Text(item['title'] as String,
                        style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700, color: color)),
                  ),
                  if (item['isRecommended'] as bool)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                      decoration: BoxDecoration(
                        color: Colors.green.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: const Text('RECOMMENDED',
                          style: TextStyle(fontSize: 8.0, fontWeight: FontWeight.w900,
                              color: Colors.green)),
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
                    child: Text(item['code'] as String,
                        style: TextStyle(fontSize: 10.0, fontFamily: 'monospace',
                            color: Colors.grey.shade700)),
                  ),
                  const SizedBox(height: 8.0),
                  Text(item['desc'] as String,
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
  // SECTION 7: Relationship Diagram
  // ============================================================
  print('=== Section 7: Relationships ===');

  final relDemo = _SRRelationshipDemo();

  // ============================================================
  // SECTION 8: Summary
  // ============================================================
  print('=== Section 8: Summary ===');

  final summaryPoints = <Map<String, dynamic>>[
    {'icon': Icons.keyboard, 'text': 'ShortcutRegistrar hosts a ShortcutRegistry + ShortcutManager'},
    {'icon': Icons.auto_fix_high, 'text': 'Pre-installed by MaterialApp — rarely needs manual setup'},
    {'icon': Icons.add_circle, 'text': 'Enables dynamic shortcut registration from any descendant widget'},
    {'icon': Icons.merge_type, 'text': 'All registered shortcuts are merged into one map for the manager'},
    {'icon': Icons.swap_horiz, 'text': 'Entries support replaceAll() for updating and dispose() for cleanup'},
    {'icon': Icons.layers, 'text': 'Nested ShortcutRegistrars create isolated shortcut scopes'},
  ];

  final summaryItems = <Widget>[];
  for (final sp in summaryPoints) {
    summaryItems.add(
      Padding(
        padding: const EdgeInsets.only(bottom: 6.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(sp['icon'] as IconData, size: 16.0, color: Colors.teal.shade700),
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
        title: const Text('ShortcutRegistrar'),
        backgroundColor: Colors.teal.shade700,
        foregroundColor: Colors.white,
        elevation: 2.0,
        bottom: const TabBar(
          isScrollable: true,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: [
            Tab(text: 'Concept'),
            Tab(text: 'Architecture'),
            Tab(text: 'Widget Tree'),
            Tab(text: 'Usage'),
            Tab(text: 'Live Demo'),
            Tab(text: 'Custom vs Default'),
            Tab(text: 'Relationships'),
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
                _buildSRBullet('ShortcutRegistrar',
                    'A widget that provides dynamic keyboard shortcut '
                    'registration to its subtree via ShortcutRegistry.'),
                const SizedBox(height: 14.0),
                ...conceptCards,
              ],
            ),
          ),
          // Tab 2: Architecture
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSRBullet('Internal Architecture',
                    'Layered composition from StatefulWidget to ShortcutManager.'),
                const SizedBox(height: 14.0),
                ...archCards,
              ],
            ),
          ),
          // Tab 3: Widget Tree
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSRBullet('Widget Tree Visualization',
                    'How ShortcutRegistrar fits into a typical app.'),
                const SizedBox(height: 14.0),
                treeDemo,
              ],
            ),
          ),
          // Tab 4: Usage
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSRBullet('Usage Patterns',
                    'Common patterns for registering and managing shortcuts.'),
                const SizedBox(height: 14.0),
                ...usageCards,
              ],
            ),
          ),
          // Tab 5: Live Demo
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSRBullet('Interactive Demo',
                    'Simulate shortcut registration/unregistration.'),
                const SizedBox(height: 14.0),
                liveDemo,
              ],
            ),
          ),
          // Tab 6: Custom vs Default
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSRBullet('Default vs Custom',
                    'When to use the built-in vs create your own.'),
                const SizedBox(height: 14.0),
                ...cvdCards,
              ],
            ),
          ),
          // Tab 7: Relationships
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSRBullet('Component Relationships',
                    'How ShortcutRegistrar relates to other shortcut classes.'),
                const SizedBox(height: 14.0),
                relDemo,
              ],
            ),
          ),
          // Tab 8: Summary
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSRBullet('Key Takeaways', ''),
                const SizedBox(height: 10.0),
                Container(
                  padding: const EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.teal.withValues(alpha: 0.05),
                        Colors.cyan.withValues(alpha: 0.05),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.teal.withValues(alpha: 0.2)),
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
Widget _buildSRBullet(String title, String body) {
  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.teal.withValues(alpha: 0.04),
      borderRadius: BorderRadius.circular(8.0),
      border: Border(left: BorderSide(color: Colors.teal.shade700, width: 3.0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700,
            color: Colors.teal.shade700)),
        if (body.isNotEmpty) ...[
          const SizedBox(height: 4.0),
          Text(body, style: TextStyle(fontSize: 13.0, color: Colors.grey.shade700, height: 1.4)),
        ],
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Widget Tree Visualization
// ---------------------------------------------------------------------------
class _SRTreeDemo extends StatelessWidget {
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
          const Text('MaterialApp Widget Tree',
              style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700)),
          const SizedBox(height: 14.0),
          _buildTreeNode('MaterialApp', 'Provides theme, routes, etc.', Colors.blue, 0),
          _buildTreeLine(0),
          _buildTreeNode('WidgetsApp', 'Core app shell', Colors.blue.shade300, 1),
          _buildTreeLine(1),
          _buildTreeNode('ShortcutRegistrar', 'Created here automatically',
              Colors.teal, 2, isHighlighted: true),
          _buildTreeLine(2),
          _buildTreeNode('_ShortcutRegistrarScope', 'InheritedWidget (registry)',
              Colors.teal.shade300, 3),
          _buildTreeLine(3),
          _buildTreeNode('Shortcuts.manager()', 'Receives ShortcutManager',
              Colors.purple, 4),
          _buildTreeLine(4),
          _buildTreeNode('Navigator', 'Route management', Colors.orange, 5),
          _buildTreeLine(5),
          _buildTreeNode('YourPage', 'Can call ShortcutRegistry.of(context)',
              Colors.green, 6, isHighlighted: true),
          const SizedBox(height: 14.0),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.amber.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.amber.shade300),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.info_outline, size: 14.0, color: Colors.amber.shade800),
                const SizedBox(width: 6.0),
                Expanded(
                  child: Text(
                    'ShortcutRegistry.of(context) walks UP the tree to find '
                    'the nearest _ShortcutRegistrarScope, which holds the registry.',
                    style: TextStyle(fontSize: 10.5, color: Colors.amber.shade800, height: 1.3),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTreeNode(String name, String desc, Color color, int depth,
      {bool isHighlighted = false}) {
    return Padding(
      padding: EdgeInsets.only(left: depth * 16.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        decoration: BoxDecoration(
          color: isHighlighted ? color.withValues(alpha: 0.1) : Colors.grey.shade50,
          borderRadius: BorderRadius.circular(6.0),
          border: Border.all(
            color: isHighlighted ? color : Colors.grey.shade200,
            width: isHighlighted ? 2.0 : 1.0,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 8.0,
              height: 8.0,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            const SizedBox(width: 6.0),
            Text(name, style: TextStyle(fontSize: 10.0, fontFamily: 'monospace',
                fontWeight: FontWeight.w700, color: color)),
            const SizedBox(width: 8.0),
            Flexible(
              child: Text(desc, style: TextStyle(fontSize: 9.0, color: Colors.grey.shade500)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTreeLine(int depth) {
    return Padding(
      padding: EdgeInsets.only(left: depth * 16.0 + 20.0),
      child: SizedBox(
        height: 12.0,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            width: 1.0,
            height: 12.0,
            color: Colors.grey.shade300,
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Live Demo: Simulated Shortcut Registration
// ---------------------------------------------------------------------------
class _SRLiveDemo extends StatefulWidget {
  @override
  State<_SRLiveDemo> createState() => _SRLiveDemoState();
}

class _SRLiveDemoState extends State<_SRLiveDemo> {
  final _entries = <Map<String, dynamic>>[];
  int _nextId = 1;
  String _lastAction = 'No actions yet';

  final _availableShortcuts = <Map<String, dynamic>>[
    {'key': 'Ctrl+S', 'action': 'Save', 'icon': Icons.save},
    {'key': 'Ctrl+Z', 'action': 'Undo', 'icon': Icons.undo},
    {'key': 'Ctrl+C', 'action': 'Copy', 'icon': Icons.content_copy},
    {'key': 'Ctrl+V', 'action': 'Paste', 'icon': Icons.content_paste},
    {'key': 'Ctrl+N', 'action': 'New', 'icon': Icons.add},
    {'key': 'Ctrl+O', 'action': 'Open', 'icon': Icons.folder_open},
    {'key': 'Ctrl+P', 'action': 'Print', 'icon': Icons.print},
    {'key': 'F5', 'action': 'Refresh', 'icon': Icons.refresh},
  ];

  void _addEntry() {
    if (_availableShortcuts.isEmpty) return;
    final shortcut = _availableShortcuts.removeAt(0);
    setState(() {
      _entries.add({
        'id': _nextId++,
        'shortcut': shortcut,
        'active': true,
      });
      _lastAction = 'Registered: ${shortcut['key']} -> ${shortcut['action']}';
    });
  }

  void _removeEntry(int index) {
    setState(() {
      final entry = _entries.removeAt(index);
      final shortcut = entry['shortcut'] as Map<String, dynamic>;
      _availableShortcuts.add(shortcut);
      _lastAction = 'Disposed: ${shortcut['key']} -> ${shortcut['action']}';
    });
  }

  void _toggleEntry(int index) {
    setState(() {
      _entries[index]['active'] = !(_entries[index]['active'] as bool);
      final s = _entries[index]['shortcut'] as Map<String, dynamic>;
      final active = _entries[index]['active'] as bool;
      _lastAction = '${active ? "Activated" : "Deactivated"}: '
          '${s['key']} -> ${s['action']}';
    });
  }

  @override
  Widget build(BuildContext context) {
    final activeCount = _entries.where((e) => e['active'] as bool).length;

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
              const Text('Shortcut Registration Simulator',
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700)),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                decoration: BoxDecoration(
                  color: Colors.teal.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text('$activeCount active',
                    style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w700,
                        color: Colors.teal.shade700)),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          // Action bar
          Row(
            children: [
              GestureDetector(
                onTap: _availableShortcuts.isNotEmpty ? _addEntry : null,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                  decoration: BoxDecoration(
                    color: _availableShortcuts.isNotEmpty
                        ? Colors.teal.withValues(alpha: 0.1)
                        : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(6.0),
                    border: Border.all(
                      color: _availableShortcuts.isNotEmpty
                          ? Colors.teal.shade300
                          : Colors.grey.shade200,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.add, size: 14.0,
                          color: _availableShortcuts.isNotEmpty
                              ? Colors.teal.shade700
                              : Colors.grey),
                      const SizedBox(width: 4.0),
                      Text('Register Shortcut',
                          style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600,
                              color: _availableShortcuts.isNotEmpty
                                  ? Colors.teal.shade700
                                  : Colors.grey)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              if (_entries.isNotEmpty)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      for (final e in _entries) {
                        _availableShortcuts.add(
                            e['shortcut'] as Map<String, dynamic>);
                      }
                      _entries.clear();
                      _lastAction = 'Disposed all entries';
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                    decoration: BoxDecoration(
                      color: Colors.red.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(6.0),
                      border: Border.all(color: Colors.red.shade200),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.delete_sweep, size: 14.0, color: Colors.red.shade700),
                        const SizedBox(width: 4.0),
                        Text('Dispose All',
                            style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600,
                                color: Colors.red.shade700)),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12.0),
          // Registered entries
          if (_entries.isEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: const Column(
                children: [
                  Icon(Icons.keyboard_hide, size: 32.0, color: Colors.grey),
                  SizedBox(height: 6.0),
                  Text('No shortcuts registered',
                      style: TextStyle(fontSize: 11.0, color: Colors.grey)),
                  Text('Tap "Register Shortcut" to add entries',
                      style: TextStyle(fontSize: 10.0, color: Colors.grey)),
                ],
              ),
            )
          else
            ...List.generate(_entries.length, (i) {
              final entry = _entries[i];
              final shortcut = entry['shortcut'] as Map<String, dynamic>;
              final active = entry['active'] as bool;
              return Container(
                margin: const EdgeInsets.only(bottom: 6.0),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: active
                      ? Colors.teal.withValues(alpha: 0.04)
                      : Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(6.0),
                  border: Border.all(
                    color: active ? Colors.teal.shade200 : Colors.grey.shade200,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
                      decoration: BoxDecoration(
                        color: Colors.grey.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(3.0),
                      ),
                      child: Text('#${entry['id']}',
                          style: TextStyle(fontSize: 8.0, fontFamily: 'monospace',
                              color: Colors.grey.shade500)),
                    ),
                    const SizedBox(width: 6.0),
                    Icon(shortcut['icon'] as IconData, size: 14.0,
                        color: active ? Colors.teal.shade700 : Colors.grey),
                    const SizedBox(width: 6.0),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                      decoration: BoxDecoration(
                        color: active
                            ? Colors.teal.withValues(alpha: 0.1)
                            : Colors.grey.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Text(shortcut['key'] as String,
                          style: TextStyle(fontSize: 10.0, fontFamily: 'monospace',
                              fontWeight: FontWeight.w700,
                              color: active ? Colors.teal.shade700 : Colors.grey)),
                    ),
                    const SizedBox(width: 6.0),
                    Expanded(
                      child: Text(shortcut['action'] as String,
                          style: TextStyle(fontSize: 10.5,
                              color: active ? Colors.grey.shade700 : Colors.grey.shade400,
                              decoration: active ? null : TextDecoration.lineThrough)),
                    ),
                    GestureDetector(
                      onTap: () => _toggleEntry(i),
                      child: Icon(
                        active ? Icons.toggle_on : Icons.toggle_off,
                        size: 24.0,
                        color: active ? Colors.teal : Colors.grey,
                      ),
                    ),
                    const SizedBox(width: 4.0),
                    GestureDetector(
                      onTap: () => _removeEntry(i),
                      child: Icon(Icons.close, size: 16.0, color: Colors.red.shade300),
                    ),
                  ],
                ),
              );
            }),
          const SizedBox(height: 10.0),
          // Merged map
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.indigo.withValues(alpha: 0.04),
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.indigo.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.merge_type, size: 14.0, color: Colors.indigo.shade700),
                    const SizedBox(width: 6.0),
                    Text('Merged Shortcut Map (${_entries.where((e) => e['active'] as bool).length} entries)',
                        style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w700,
                            color: Colors.indigo.shade700)),
                  ],
                ),
                const SizedBox(height: 4.0),
                Text(
                  _entries.where((e) => e['active'] as bool).isEmpty
                      ? '{ /* empty */ }'
                      : '{\n${_entries.where((e) => e['active'] as bool).map((e) {
                          final s = e['shortcut'] as Map<String, dynamic>;
                          return '  ${s['key']}: ${s['action']}Intent()';
                        }).join(',\n')}\n}',
                  style: TextStyle(fontSize: 9.5, fontFamily: 'monospace',
                      color: Colors.indigo.shade600),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8.0),
          // Last action
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.amber.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Row(
              children: [
                Icon(Icons.history, size: 12.0, color: Colors.amber.shade700),
                const SizedBox(width: 6.0),
                Text(_lastAction,
                    style: TextStyle(fontSize: 10.0, color: Colors.amber.shade800)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Relationship Diagram
// ---------------------------------------------------------------------------
class _SRRelationshipDemo extends StatelessWidget {
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
          const Text('Shortcut System Components',
              style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700)),
          const SizedBox(height: 14.0),
          _buildRelation(
            from: 'ShortcutRegistrar',
            fromColor: Colors.teal,
            relation: 'creates',
            to: 'ShortcutRegistry',
            toColor: Colors.orange,
            desc: 'Creates and holds in State',
          ),
          _buildRelation(
            from: 'ShortcutRegistrar',
            fromColor: Colors.teal,
            relation: 'creates',
            to: 'ShortcutManager',
            toColor: Colors.red,
            desc: 'Creates and holds in State',
          ),
          _buildRelation(
            from: 'ShortcutRegistry',
            fromColor: Colors.orange,
            relation: 'notifies',
            to: 'ShortcutManager',
            toColor: Colors.red,
            desc: 'When shortcuts change',
          ),
          _buildRelation(
            from: 'ShortcutRegistry',
            fromColor: Colors.orange,
            relation: 'creates',
            to: 'ShortcutRegistryEntry',
            toColor: Colors.purple,
            desc: 'On addAll() calls',
          ),
          _buildRelation(
            from: 'ShortcutRegistryEntry',
            fromColor: Colors.purple,
            relation: 'calls',
            to: 'ShortcutRegistry',
            toColor: Colors.orange,
            desc: 'replaceAll() / dispose()',
          ),
          _buildRelation(
            from: 'Shortcuts.manager()',
            fromColor: Colors.blue,
            relation: 'uses',
            to: 'ShortcutManager',
            toColor: Colors.red,
            desc: 'To process key events',
          ),
          _buildRelation(
            from: 'ShortcutManager',
            fromColor: Colors.red,
            relation: 'invokes',
            to: 'Actions',
            toColor: Colors.green,
            desc: 'Matching Intent for activator',
          ),
          const SizedBox(height: 12.0),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.teal.withValues(alpha: 0.04),
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.teal.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Data Flow:',
                    style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w700,
                        color: Colors.teal.shade700)),
                const SizedBox(height: 4.0),
                Text(
                  'Widget calls registry.addAll(shortcuts)\n'
                  '  -> Registry merges into shared map\n'
                  '  -> Registry notifies Manager\n'
                  '  -> Manager updates its shortcut bindings\n'
                  '  -> Key event matches activator\n'
                  '  -> Manager dispatches Intent\n'
                  '  -> Actions invokes handler',
                  style: TextStyle(fontSize: 9.5, fontFamily: 'monospace',
                      color: Colors.grey.shade700, height: 1.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRelation({
    required String from,
    required Color fromColor,
    required String relation,
    required String to,
    required Color toColor,
    required String desc,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
            decoration: BoxDecoration(
              color: fromColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(from,
                style: TextStyle(fontSize: 8.5, fontFamily: 'monospace',
                    fontWeight: FontWeight.w700, color: fromColor)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: Column(
              children: [
                Icon(Icons.arrow_forward, size: 10.0, color: Colors.grey.shade400),
                Text(relation,
                    style: TextStyle(fontSize: 7.0, color: Colors.grey.shade500)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
            decoration: BoxDecoration(
              color: toColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(to,
                style: TextStyle(fontSize: 8.5, fontFamily: 'monospace',
                    fontWeight: FontWeight.w700, color: toColor)),
          ),
          const SizedBox(width: 6.0),
          Expanded(
            child: Text(desc,
                style: TextStyle(fontSize: 9.0, fontStyle: FontStyle.italic,
                    color: Colors.grey.shade500),
                textAlign: TextAlign.end),
          ),
        ],
      ),
    );
  }
}
