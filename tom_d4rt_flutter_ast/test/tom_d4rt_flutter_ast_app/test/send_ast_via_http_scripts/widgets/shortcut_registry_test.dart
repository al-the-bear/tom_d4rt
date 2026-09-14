// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — ShortcutRegistry
// Demonstrates ShortcutRegistry — a ChangeNotifier that manages dynamic
// registration of keyboard shortcuts, merging multiple entries into one
// consolidated map, and notifying listeners on changes.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ShortcutRegistry Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptPoints = <Map<String, dynamic>>[
    {
      'icon': Icons.hub,
      'title': 'Central Shortcut Manager',
      'body': 'ShortcutRegistry is a ChangeNotifier that acts as the '
          'central registry for keyboard shortcuts. Multiple widgets can '
          'register their shortcuts independently and the registry merges '
          'them into one consolidated map.',
    },
    {
      'icon': Icons.badge,
      'title': 'Entry-Based Ownership',
      'body': 'Each call to addAll() returns a ShortcutRegistryEntry, '
          'a handle that grants the caller ownership of those shortcuts. '
          'This entry can be used to replace or dispose the shortcuts '
          'independently of other entries.',
    },
    {
      'icon': Icons.notification_important,
      'title': 'Deferred Notifications',
      'body': 'Notifications are deferred to the next frame via '
          'SchedulerBinding.addPostFrameCallback. This batches multiple '
          'changes into one notification, avoiding redundant rebuilds.',
    },
    {
      'icon': Icons.search,
      'title': 'Context Lookup',
      'body': 'ShortcutRegistry.of(context) and maybeOf(context) find the '
          'nearest registry via _ShortcutRegistrarScope. The registry is '
          'owned by ShortcutRegistrar, usually from MaterialApp.',
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
          color: Colors.deepPurple.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.deepPurple.withValues(alpha: 0.2)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(p['icon'] as IconData, color: Colors.deepPurple.shade700, size: 26.0),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    p['title'] as String,
                    style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700,
                        color: Colors.deepPurple.shade700),
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
  // SECTION 2: API Reference
  // ============================================================
  print('=== Section 2: API Reference ===');

  final apiMethods = <Map<String, dynamic>>[
    {
      'name': 'addAll()',
      'signature': 'ShortcutRegistryEntry addAll(\n'
          '  Map<ShortcutActivator, Intent>\n'
          '    value,\n'
          ')',
      'desc': 'Registers a set of shortcuts and returns an entry handle. '
          'Each entry is tracked independently. Triggers a deferred '
          'notification.',
      'color': Colors.green,
    },
    {
      'name': 'shortcuts (getter)',
      'signature': 'Map<ShortcutActivator, Intent>\n'
          '  get shortcuts',
      'desc': 'Returns the merged map of ALL registered shortcuts from '
          'ALL entries. The merge order matches registration order — '
          'later entries override earlier ones with the same activator.',
      'color': Colors.blue,
    },
    {
      'name': 'of(context)',
      'signature': 'static ShortcutRegistry of(\n'
          '  BuildContext context,\n'
          ')',
      'desc': 'Finds the nearest ShortcutRegistry via InheritedWidget. '
          'Throws if none is found. Use in initState or build.',
      'color': Colors.purple,
    },
    {
      'name': 'maybeOf(context)',
      'signature': 'static ShortcutRegistry? maybeOf(\n'
          '  BuildContext context,\n'
          ')',
      'desc': 'Like of() but returns null instead of throwing. Use when '
          'registry presence is optional.',
      'color': Colors.orange,
    },
  ];

  final apiCards = <Widget>[];
  for (final m in apiMethods) {
    final color = m['color'] as Color;
    apiCards.add(
      Container(
        margin: const EdgeInsets.only(bottom: 10.0),
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
              child: Text(m['name'] as String,
                  style: TextStyle(fontSize: 12.0, fontFamily: 'monospace',
                      fontWeight: FontWeight.w700, color: color)),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
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
                  const SizedBox(height: 6.0),
                  Text(m['desc'] as String,
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
  // SECTION 3: ShortcutRegistryEntry
  // ============================================================
  print('=== Section 3: ShortcutRegistryEntry ===');

  final entryMethods = <Map<String, dynamic>>[
    {
      'name': 'replaceAll()',
      'signature': 'void replaceAll(\n'
          '  Map<ShortcutActivator, Intent>\n'
          '    value,\n'
          ')',
      'desc': 'Replaces all shortcuts in this entry. The registry updates '
          'its merged map and notifies. Other entries are not affected.',
      'color': Colors.blue,
    },
    {
      'name': 'dispose()',
      'signature': 'void dispose()',
      'desc': 'Removes this entry from the registry. The registry removes '
          'these shortcuts from its merged map and notifies. Must be called '
          'to prevent memory leaks.',
      'color': Colors.red,
    },
  ];

  final entryCards = <Widget>[];
  for (final m in entryMethods) {
    final color = m['color'] as Color;
    entryCards.add(
      Container(
        margin: const EdgeInsets.only(bottom: 10.0),
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
              child: Text(m['name'] as String,
                  style: TextStyle(fontSize: 12.0, fontFamily: 'monospace',
                      fontWeight: FontWeight.w700, color: color)),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
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
                  const SizedBox(height: 6.0),
                  Text(m['desc'] as String,
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
  // SECTION 4: Merge Visualization
  // ============================================================
  print('=== Section 4: Merge Visualization ===');

  final mergeDemo = _SRGMergeDemo();

  // ============================================================
  // SECTION 5: Live Demo
  // ============================================================
  print('=== Section 5: Live Demo ===');

  final liveDemo = _SRGLiveDemo();

  // ============================================================
  // SECTION 6: Notification Batching
  // ============================================================
  print('=== Section 6: Notification Batching ===');

  final batchSteps = <Map<String, dynamic>>[
    {
      'step': '1. addAll() called',
      'desc': 'Shortcuts are stored in the entry. The registry schedules '
          'a post-frame callback if one is not already pending.',
      'color': Colors.green,
      'icon': Icons.add_circle,
    },
    {
      'step': '2. replaceAll() called',
      'desc': 'Entry shortcuts are replaced. If a notification is already '
          'scheduled, no new callback is added.',
      'color': Colors.blue,
      'icon': Icons.swap_horiz,
    },
    {
      'step': '3. dispose() called',
      'desc': 'Entry is removed from the registry. If a notification is '
          'already scheduled, no new callback is added.',
      'color': Colors.red,
      'icon': Icons.delete,
    },
    {
      'step': '4. Post-frame callback fires',
      'desc': 'The merged shortcut map is recalculated and notifyListeners() '
          'is called. All three changes above result in ONE notification.',
      'color': Colors.purple,
      'icon': Icons.notification_important,
    },
  ];

  final batchCards = <Widget>[];
  for (var i = 0; i < batchSteps.length; i++) {
    final s = batchSteps[i];
    final color = s['color'] as Color;
    batchCards.add(
      Container(
        margin: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  width: 28.0,
                  height: 28.0,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                    border: Border.all(color: color, width: 2.0),
                  ),
                  child: Icon(s['icon'] as IconData, size: 14.0, color: color),
                ),
                if (i < batchSteps.length - 1)
                  Container(
                    width: 2.0,
                    height: 20.0,
                    color: Colors.grey.shade300,
                  ),
              ],
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.03),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: color.withValues(alpha: 0.15)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(s['step'] as String,
                        style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w700, color: color)),
                    const SizedBox(height: 3.0),
                    Text(s['desc'] as String,
                        style: TextStyle(fontSize: 10.5, color: Colors.grey.shade600, height: 1.3)),
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
  // SECTION 7: Edge Cases
  // ============================================================
  print('=== Section 7: Edge Cases ===');

  final edgeCases = <Map<String, dynamic>>[
    {
      'title': 'Duplicate Activators',
      'icon': Icons.warning_amber,
      'color': Colors.orange,
      'desc': 'If two entries register the same activator, the LATER entry '
          'wins in the merged map. A debug assertion warns about this in '
          'debug mode. In release mode, the later entry silently overrides.',
    },
    {
      'title': 'Dispose After Registry Dispose',
      'icon': Icons.error_outline,
      'color': Colors.red,
      'desc': 'If the ShortcutRegistrar is disposed before its entries, '
          'entry.dispose() may fail. Always dispose entries in your '
          'widget dispose() method, before the parent tree is torn down.',
    },
    {
      'title': 'Empty Entry',
      'icon': Icons.check_circle,
      'color': Colors.green,
      'desc': 'addAll({}) creates a valid entry with no shortcuts. This is '
          'useful as a placeholder that you later populate via replaceAll().',
    },
    {
      'title': 'Hot Reload',
      'icon': Icons.refresh,
      'color': Colors.blue,
      'desc': 'Shortcuts registered in initState survive hot reload. '
          'Only a hot restart or full rebuild re-runs initState. If you '
          'move shortcuts to build(), duplicates will accumulate.',
    },
  ];

  final edgeCards = <Widget>[];
  for (final ec in edgeCases) {
    final color = ec['color'] as Color;
    edgeCards.add(
      Container(
        margin: const EdgeInsets.only(bottom: 10.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(8.0),
          border: Border(left: BorderSide(color: color, width: 3.0)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(ec['icon'] as IconData, size: 20.0, color: color),
            const SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(ec['title'] as String,
                      style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700, color: color)),
                  const SizedBox(height: 3.0),
                  Text(ec['desc'] as String,
                      style: TextStyle(fontSize: 11.5, color: Colors.grey.shade700, height: 1.35)),
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
    {'icon': Icons.hub, 'text': 'ShortcutRegistry is a ChangeNotifier managing shortcut entries'},
    {'icon': Icons.badge, 'text': 'addAll() returns ShortcutRegistryEntry for ownership tracking'},
    {'icon': Icons.merge_type, 'text': 'All entries are merged into one consolidated shortcut map'},
    {'icon': Icons.swap_horiz, 'text': 'Entries support replaceAll() and dispose() independently'},
    {'icon': Icons.notification_important, 'text': 'Notifications are batched to the next frame'},
    {'icon': Icons.search, 'text': 'Access via ShortcutRegistry.of(context) or maybeOf(context)'},
  ];

  final summaryItems = <Widget>[];
  for (final sp in summaryPoints) {
    summaryItems.add(
      Padding(
        padding: const EdgeInsets.only(bottom: 6.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(sp['icon'] as IconData, size: 16.0, color: Colors.deepPurple.shade700),
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
        title: const Text('ShortcutRegistry'),
        backgroundColor: Colors.deepPurple.shade700,
        foregroundColor: Colors.white,
        elevation: 2.0,
        bottom: const TabBar(
          isScrollable: true,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: [
            Tab(text: 'Concept'),
            Tab(text: 'API'),
            Tab(text: 'Entry'),
            Tab(text: 'Merge'),
            Tab(text: 'Live Demo'),
            Tab(text: 'Batching'),
            Tab(text: 'Edge Cases'),
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
                _buildSRGBullet('ShortcutRegistry',
                    'A ChangeNotifier that manages dynamic keyboard shortcut '
                    'registration with entry-based ownership and deferred '
                    'notifications.'),
                const SizedBox(height: 14.0),
                ...conceptCards,
              ],
            ),
          ),
          // Tab 2: API
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSRGBullet('API Reference',
                    'Core methods for interacting with ShortcutRegistry.'),
                const SizedBox(height: 14.0),
                ...apiCards,
              ],
            ),
          ),
          // Tab 3: Entry
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSRGBullet('ShortcutRegistryEntry',
                    'The ownership handle returned by addAll(). Provides '
                    'replaceAll() and dispose() for lifecycle management.'),
                const SizedBox(height: 14.0),
                ...entryCards,
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
                          Icon(Icons.warning_amber, size: 14.0,
                              color: Colors.amber.shade800),
                          const SizedBox(width: 6.0),
                          Text('Lifecycle Rule',
                              style: TextStyle(fontSize: 11.0,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.amber.shade800)),
                        ],
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        'Always pair addAll() with entry.dispose() in your '
                        'widget lifecycle. Register in initState/didChangeDependencies, '
                        'dispose in dispose(). Never call addAll() in build().',
                        style: TextStyle(fontSize: 10.5, color: Colors.grey.shade700,
                            height: 1.35),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Tab 4: Merge
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSRGBullet('Merge Visualization',
                    'See how multiple entries merge into one shortcut map.'),
                const SizedBox(height: 14.0),
                mergeDemo,
              ],
            ),
          ),
          // Tab 5: Live Demo
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSRGBullet('Interactive Registry',
                    'Add, replace, and dispose shortcut entries. Observe '
                    'the merged map and notification behavior.'),
                const SizedBox(height: 14.0),
                liveDemo,
              ],
            ),
          ),
          // Tab 6: Batching
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSRGBullet('Notification Batching',
                    'How ShortcutRegistry batches multiple changes into '
                    'one notification per frame.'),
                const SizedBox(height: 14.0),
                ...batchCards,
                const SizedBox(height: 10.0),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.purple.withValues(alpha: 0.04),
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.purple.shade200),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Implementation Detail',
                          style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w700,
                              color: Colors.purple.shade700)),
                      const SizedBox(height: 4.0),
                      Text(
                        'void _notifyListenersNextFrame() {\n'
                        '  if (!_notificationScheduled) {\n'
                        '    _notificationScheduled = true;\n'
                        '    SchedulerBinding.instance\n'
                        '      .addPostFrameCallback((_) {\n'
                        '        _notificationScheduled = false;\n'
                        '        notifyListeners();\n'
                        '    });\n'
                        '  }\n'
                        '}',
                        style: TextStyle(fontSize: 9.5, fontFamily: 'monospace',
                            color: Colors.grey.shade700),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Tab 7: Edge Cases
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSRGBullet('Edge Cases & Pitfalls',
                    'Important scenarios to be aware of.'),
                const SizedBox(height: 14.0),
                ...edgeCards,
              ],
            ),
          ),
          // Tab 8: Summary
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSRGBullet('Key Takeaways', ''),
                const SizedBox(height: 10.0),
                Container(
                  padding: const EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.deepPurple.withValues(alpha: 0.05),
                        Colors.purple.withValues(alpha: 0.05),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.deepPurple.withValues(alpha: 0.2)),
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
Widget _buildSRGBullet(String title, String body) {
  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.deepPurple.withValues(alpha: 0.04),
      borderRadius: BorderRadius.circular(8.0),
      border: Border(left: BorderSide(color: Colors.deepPurple.shade700, width: 3.0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700,
            color: Colors.deepPurple.shade700)),
        if (body.isNotEmpty) ...[
          const SizedBox(height: 4.0),
          Text(body, style: TextStyle(fontSize: 13.0, color: Colors.grey.shade700, height: 1.4)),
        ],
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Merge Visualization
// ---------------------------------------------------------------------------
class _SRGMergeDemo extends StatefulWidget {
  @override
  State<_SRGMergeDemo> createState() => _SRGMergeDemoState();
}

class _SRGMergeDemoState extends State<_SRGMergeDemo> {
  final _entries = <Map<String, dynamic>>[
    {
      'name': 'Entry A (Editor)',
      'color': Colors.blue,
      'shortcuts': {'Ctrl+S': 'SaveIntent', 'Ctrl+Z': 'UndoIntent', 'Ctrl+C': 'CopyIntent'},
      'active': true,
    },
    {
      'name': 'Entry B (Navigation)',
      'color': Colors.green,
      'shortcuts': {'Ctrl+N': 'NewTabIntent', 'Ctrl+W': 'CloseTabIntent'},
      'active': true,
    },
    {
      'name': 'Entry C (Override)',
      'color': Colors.orange,
      'shortcuts': {'Ctrl+S': 'QuickSaveIntent', 'F5': 'RunIntent'},
      'active': false,
    },
  ];

  Map<String, MapEntry<String, Color>> _getMergedMap() {
    final merged = <String, MapEntry<String, Color>>{};
    for (final entry in _entries) {
      if (!(entry['active'] as bool)) continue;
      final color = entry['color'] as Color;
      final shortcuts = entry['shortcuts'] as Map<String, String>;
      for (final e in shortcuts.entries) {
        merged[e.key] = MapEntry(e.value, color);
      }
    }
    return merged;
  }

  @override
  Widget build(BuildContext context) {
    final merged = _getMergedMap();

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
          const Text('Entry Merge Simulator',
              style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700)),
          const SizedBox(height: 6.0),
          Text('Toggle entries to see how the merged map changes.',
              style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600)),
          const SizedBox(height: 14.0),
          // Individual entries
          ...List.generate(_entries.length, (i) {
            final entry = _entries[i];
            final color = entry['color'] as Color;
            final active = entry['active'] as bool;
            final shortcuts = entry['shortcuts'] as Map<String, String>;

            return Container(
              margin: const EdgeInsets.only(bottom: 8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  color: active ? color.withValues(alpha: 0.3) : Colors.grey.shade200,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                    decoration: BoxDecoration(
                      color: active ? color.withValues(alpha: 0.06) : Colors.grey.shade50,
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(7.0)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 10.0,
                          height: 10.0,
                          decoration: BoxDecoration(
                            color: active ? color : Colors.grey,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6.0),
                        Expanded(
                          child: Text(entry['name'] as String,
                              style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w700,
                                  color: active ? color : Colors.grey)),
                        ),
                        GestureDetector(
                          onTap: () => setState(() {
                            _entries[i]['active'] = !active;
                          }),
                          child: Icon(
                            active ? Icons.toggle_on : Icons.toggle_off,
                            size: 28.0,
                            color: active ? color : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (active)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: shortcuts.entries.map((e) {
                          final isOverridden = merged.containsKey(e.key) &&
                              merged[e.key]!.value != color;
                          return Container(
                            margin: const EdgeInsets.only(bottom: 4.0),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 4.0),
                            decoration: BoxDecoration(
                              color: isOverridden
                                  ? Colors.red.withValues(alpha: 0.06)
                                  : Colors.grey.shade50,
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Row(
                              children: [
                                Text(e.key, style: TextStyle(fontSize: 10.0,
                                    fontFamily: 'monospace', fontWeight: FontWeight.w700,
                                    color: Colors.grey.shade700,
                                    decoration: isOverridden
                                        ? TextDecoration.lineThrough
                                        : null)),
                                const SizedBox(width: 6.0),
                                Icon(Icons.arrow_forward, size: 8.0,
                                    color: Colors.grey.shade400),
                                const SizedBox(width: 6.0),
                                Expanded(
                                  child: Text(e.value, style: TextStyle(fontSize: 10.0,
                                      fontFamily: 'monospace', color: color,
                                      decoration: isOverridden
                                          ? TextDecoration.lineThrough
                                          : null)),
                                ),
                                if (isOverridden)
                                  Text('overridden', style: TextStyle(fontSize: 8.0,
                                      fontWeight: FontWeight.w700, color: Colors.red)),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                ],
              ),
            );
          }),
          const SizedBox(height: 10.0),
          // Merged map
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.deepPurple.withValues(alpha: 0.04),
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.deepPurple.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.merge_type, size: 16.0, color: Colors.deepPurple.shade700),
                    const SizedBox(width: 6.0),
                    Text('Merged Map (${merged.length} entries)',
                        style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w700,
                            color: Colors.deepPurple.shade700)),
                  ],
                ),
                const SizedBox(height: 8.0),
                if (merged.isEmpty)
                  Text('{ /* empty */ }',
                      style: TextStyle(fontSize: 10.0, fontFamily: 'monospace',
                          color: Colors.grey.shade500))
                else
                  ...merged.entries.map((e) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 4.0),
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      decoration: BoxDecoration(
                        color: e.value.value.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 8.0,
                            height: 8.0,
                            decoration: BoxDecoration(
                                color: e.value.value, shape: BoxShape.circle),
                          ),
                          const SizedBox(width: 6.0),
                          Text(e.key, style: TextStyle(fontSize: 10.0,
                              fontFamily: 'monospace', fontWeight: FontWeight.w700,
                              color: Colors.grey.shade700)),
                          const SizedBox(width: 6.0),
                          Icon(Icons.arrow_forward, size: 8.0,
                              color: Colors.grey.shade400),
                          const SizedBox(width: 6.0),
                          Text(e.value.key, style: TextStyle(fontSize: 10.0,
                              fontFamily: 'monospace', color: e.value.value)),
                        ],
                      ),
                    );
                  }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Live Demo: Interactive ShortcutRegistry
// ---------------------------------------------------------------------------
class _SRGLiveDemo extends StatefulWidget {
  @override
  State<_SRGLiveDemo> createState() => _SRGLiveDemoState();
}

class _SRGLiveDemoState extends State<_SRGLiveDemo> {
  final _entries = <Map<String, dynamic>>[];
  int _nextId = 1;
  int _notificationCount = 0;
  final _log = <String>[];

  final _shortcutPool = <Map<String, String>>[
    {'key': 'Ctrl+S', 'intent': 'SaveIntent'},
    {'key': 'Ctrl+Z', 'intent': 'UndoIntent'},
    {'key': 'Ctrl+Y', 'intent': 'RedoIntent'},
    {'key': 'Ctrl+X', 'intent': 'CutIntent'},
    {'key': 'Ctrl+C', 'intent': 'CopyIntent'},
    {'key': 'Ctrl+V', 'intent': 'PasteIntent'},
    {'key': 'Ctrl+A', 'intent': 'SelectAllIntent'},
    {'key': 'Ctrl+F', 'intent': 'FindIntent'},
    {'key': 'Ctrl+H', 'intent': 'ReplaceIntent'},
    {'key': 'F1', 'intent': 'HelpIntent'},
    {'key': 'F2', 'intent': 'RenameIntent'},
    {'key': 'F5', 'intent': 'RunIntent'},
  ];
  int _poolIndex = 0;

  Map<String, String> _nextShortcut() {
    final s = _shortcutPool[_poolIndex % _shortcutPool.length];
    _poolIndex++;
    return s;
  }

  void _addEntry() {
    final s1 = _nextShortcut();
    final s2 = _nextShortcut();
    final id = _nextId++;
    setState(() {
      _entries.add({
        'id': id,
        'shortcuts': {s1['key']!: s1['intent']!, s2['key']!: s2['intent']!},
      });
      _notificationCount++;
      _log.insert(0, 'addAll() -> Entry #$id: '
          '${s1['key']}, ${s2['key']}');
      if (_log.length > 8) _log.removeLast();
    });
  }

  void _replaceEntry(int index) {
    final s = _nextShortcut();
    setState(() {
      final id = _entries[index]['id'];
      _entries[index]['shortcuts'] = {s['key']!: s['intent']!};
      _notificationCount++;
      _log.insert(0, 'replaceAll() -> Entry #$id: ${s['key']}');
      if (_log.length > 8) _log.removeLast();
    });
  }

  void _disposeEntry(int index) {
    setState(() {
      final id = _entries[index]['id'];
      _entries.removeAt(index);
      _notificationCount++;
      _log.insert(0, 'dispose() -> Entry #$id removed');
      if (_log.length > 8) _log.removeLast();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Compute merged map
    final merged = <String, String>{};
    for (final entry in _entries) {
      final shortcuts = entry['shortcuts'] as Map<String, String>;
      merged.addAll(shortcuts);
    }

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
              const Text('Registry Simulator',
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700)),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text('Notifications: $_notificationCount',
                    style: TextStyle(fontSize: 9.0, fontWeight: FontWeight.w700,
                        color: Colors.deepPurple.shade700)),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          // Actions
          Row(
            children: [
              GestureDetector(
                onTap: _addEntry,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6.0),
                    border: Border.all(color: Colors.green.shade200),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.add, size: 14.0, color: Colors.green.shade700),
                      const SizedBox(width: 4.0),
                      Text('addAll()', style: TextStyle(fontSize: 10.0,
                          fontFamily: 'monospace', fontWeight: FontWeight.w700,
                          color: Colors.green.shade700)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 6.0),
              if (_entries.isNotEmpty)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _entries.clear();
                      _notificationCount++;
                      _log.insert(0, 'dispose() -> All entries cleared');
                      if (_log.length > 8) _log.removeLast();
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
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
                        Text('Clear All', style: TextStyle(fontSize: 10.0,
                            fontWeight: FontWeight.w600, color: Colors.red.shade700)),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12.0),
          // Entries
          if (_entries.isEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Column(
                children: [
                  Icon(Icons.inbox, size: 28.0, color: Colors.grey),
                  SizedBox(height: 4.0),
                  Text('No entries registered', style: TextStyle(fontSize: 11.0,
                      color: Colors.grey)),
                ],
              ),
            )
          else
            ...List.generate(_entries.length, (i) {
              final entry = _entries[i];
              final shortcuts = entry['shortcuts'] as Map<String, String>;
              return Container(
                margin: const EdgeInsets.only(bottom: 6.0),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.withValues(alpha: 0.03),
                  borderRadius: BorderRadius.circular(6.0),
                  border: Border.all(color: Colors.deepPurple.withValues(alpha: 0.15)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('#${entry['id']}', style: TextStyle(fontSize: 9.0,
                        fontFamily: 'monospace', fontWeight: FontWeight.w700,
                        color: Colors.deepPurple.shade700)),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: Wrap(
                        spacing: 4.0,
                        runSpacing: 4.0,
                        children: shortcuts.entries.map((e) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6.0, vertical: 2.0),
                            decoration: BoxDecoration(
                              color: Colors.deepPurple.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(3.0),
                            ),
                            child: Text('${e.key} -> ${e.value}',
                                style: TextStyle(fontSize: 8.5, fontFamily: 'monospace',
                                    color: Colors.deepPurple.shade700)),
                          );
                        }).toList(),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _replaceEntry(i),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Icon(Icons.swap_horiz, size: 16.0,
                            color: Colors.blue.shade400),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _disposeEntry(i),
                      child: Icon(Icons.close, size: 16.0,
                          color: Colors.red.shade300),
                    ),
                  ],
                ),
              );
            }),
          const SizedBox(height: 10.0),
          // Merged
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.deepPurple.withValues(alpha: 0.04),
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.deepPurple.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('registry.shortcuts (${merged.length})',
                    style: TextStyle(fontSize: 10.0, fontFamily: 'monospace',
                        fontWeight: FontWeight.w700, color: Colors.deepPurple.shade700)),
                const SizedBox(height: 4.0),
                Text(
                  merged.isEmpty
                      ? '{ }'
                      : '{ ${merged.entries.map((e) => '${e.key}: ${e.value}').join(', ')} }',
                  style: TextStyle(fontSize: 9.5, fontFamily: 'monospace',
                      color: Colors.grey.shade700),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          // Log
          Container(
            width: double.infinity,
            height: 100.0,
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Event Log:', style: TextStyle(fontSize: 9.0,
                      fontWeight: FontWeight.w700, color: Colors.green.shade300)),
                  const SizedBox(height: 4.0),
                  if (_log.isEmpty)
                    Text('(no events)', style: TextStyle(fontSize: 9.0,
                        color: Colors.grey.shade600))
                  else
                    ..._log.map((l) => Text(l, style: TextStyle(fontSize: 9.0,
                        fontFamily: 'monospace', color: Colors.green.shade200, height: 1.4))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
