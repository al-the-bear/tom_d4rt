// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — UnmanagedRestorationScope
// Demonstrates UnmanagedRestorationScope, a widget that provides a
// RestorationBucket to its subtree without managing the bucket lifecycle.
// Useful for injecting externally-managed restoration buckets.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('UnmanagedRestorationScope Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptItems = <Map<String, dynamic>>[
    {
      'icon': Icons.restore,
      'title': 'What is UnmanagedRestorationScope?',
      'body': 'UnmanagedRestorationScope is a widget that injects a '
          'RestorationBucket into the widget tree without managing '
          'the bucket\u0027s lifecycle. You supply the bucket externally '
          'and the widget makes it available to descendants.',
      'accent': Colors.amber,
    },
    {
      'icon': Icons.account_tree,
      'title': 'State Restoration System',
      'body': 'Flutter\u0027s restoration system preserves state across '
          'app restarts (e.g., on Android when the OS kills background '
          'apps). Data is stored in a hierarchical bucket tree that '
          'mirrors the widget tree.',
      'accent': Colors.blue,
    },
    {
      'icon': Icons.folder_open,
      'title': 'Restoration Buckets',
      'body': 'A RestorationBucket is a scoped container for restoration '
          'data. Each bucket has a string ID and can contain child '
          'buckets and RestorableProperty values like counters, text, '
          'scroll positions, and booleans.',
      'accent': Colors.green,
    },
    {
      'icon': Icons.settings_backup_restore,
      'title': 'When to Use Unmanaged',
      'body': 'Use UnmanagedRestorationScope when you already own and '
          'control the bucket externally — for example, when '
          'integrating with a custom restoration backend or when '
          'testing restoration behavior in isolation.',
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
            colors: [accent.withOpacity(0.14), accent.withOpacity(0.03)],
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
      'name': 'bucket',
      'type': 'RestorationBucket?',
      'desc': 'The restoration bucket made available to descendants. '
          'If null, descendants behave as if no restoration scope '
          'is present and will not participate in state restoration.',
    },
    {
      'name': 'child',
      'type': 'Widget',
      'desc': 'The widget subtree that can access the restoration '
          'bucket via RestorationScope.of(context). All restorable '
          'widgets in this subtree use this bucket.',
    },
    {
      'name': 'RestorationScope.of()',
      'type': 'RestorationBucket?',
      'desc': 'Static method that retrieves the nearest restoration '
          'bucket from the widget tree. Returns the bucket provided '
          'by UnmanagedRestorationScope or RestorationScope.',
    },
    {
      'name': 'RestorationBucket',
      'type': 'class',
      'desc': 'A container for restoration data. Holds key-value pairs '
          'of serializable data. Can contain child buckets forming '
          'a tree structure matching the widget hierarchy.',
    },
    {
      'name': 'RestorationBucket.empty',
      'type': 'factory',
      'desc': 'Creates an empty bucket with a given restorationId. '
          'Commonly used with UnmanagedRestorationScope when you need '
          'a fresh bucket not backed by any stored data.',
    },
    {
      'name': 'registerForRestoration',
      'type': 'method on State mixin',
      'desc': 'Registers a RestorableProperty with the nearest bucket. '
          'The property\u0027s value is saved when the app is backgrounded '
          'and restored when the app restarts.',
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
              ? Colors.amber.withOpacity(0.07)
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
                      color: Colors.amber.shade900,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Container(
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
                      overflow: TextOverflow.ellipsis,
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
  // SECTION 3: Bucket Hierarchy
  // ============================================================
  print('=== Section 3: Bucket Hierarchy ===');

  final hierarchyLevels = <Map<String, dynamic>>[
    {
      'level': 0,
      'name': 'Root Bucket',
      'desc': 'Provided by the engine or WidgetsApp. Contains the '
          'entire restoration tree for the application. Serialized '
          'to and deserialized from platform storage.',
      'color': Colors.amber,
      'indent': 0,
    },
    {
      'level': 1,
      'name': 'Navigator Bucket',
      'desc': 'Each Navigator with a restorationScopeId gets a child '
          'bucket. Stores route history and route-level state.',
      'color': Colors.blue,
      'indent': 1,
    },
    {
      'level': 2,
      'name': 'Route Bucket',
      'desc': 'Individual routes get child buckets from the Navigator. '
          'Stores widget state within each route (scroll positions, '
          'form fields, tab indices).',
      'color': Colors.green,
      'indent': 2,
    },
    {
      'level': 3,
      'name': 'Widget Bucket',
      'desc': 'Widgets with RestorationMixin claim child buckets from '
          'their scope. This is where RestorableProperty values '
          'like RestorableInt or RestorableString are stored.',
      'color': Colors.orange,
      'indent': 3,
    },
    {
      'level': 4,
      'name': 'Custom Bucket (Unmanaged)',
      'desc': 'An UnmanagedRestorationScope can inject a bucket at any '
          'level. The bucket may come from a custom backend, a test '
          'harness, or any external source.',
      'color': Colors.purple,
      'indent': 2,
    },
  ];

  final hierarchyWidgets = <Widget>[];
  for (var i = 0; i < hierarchyLevels.length; i++) {
    final hl = hierarchyLevels[i];
    final hlColor = hl['color'] as Color;
    final indent = hl['indent'] as int;
    print('Hierarchy ${i + 1}: ${hl['name']}');
    hierarchyWidgets.add(
      Container(
        margin: EdgeInsets.only(
          left: 16.0 + indent * 20.0,
          right: 16,
          top: 5,
          bottom: 5,
        ),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: hlColor.withOpacity(0.06),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: hlColor.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: hlColor.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  'L${hl['level']}',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: hlColor,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hl['name'] as String,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: hlColor,
                    ),
                  ),
                  Text(
                    hl['desc'] as String,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade700,
                      height: 1.3,
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
  // SECTION 4: Managed vs Unmanaged
  // ============================================================
  print('=== Section 4: Managed vs Unmanaged ===');

  final comparisonRows = <Map<String, String>>[
    {
      'aspect': 'Widget',
      'managed': 'RestorationScope',
      'unmanaged': 'UnmanagedRestorationScope',
    },
    {
      'aspect': 'Bucket Lifecycle',
      'managed': 'Creates and disposes bucket',
      'unmanaged': 'Does not manage lifecycle',
    },
    {
      'aspect': 'Bucket Source',
      'managed': 'Claims child from parent bucket',
      'unmanaged': 'Accepts external bucket',
    },
    {
      'aspect': 'Restoration ID',
      'managed': 'Required (string)',
      'unmanaged': 'Not needed (bucket is provided)',
    },
    {
      'aspect': 'Null Bucket',
      'managed': 'Not possible if parent has bucket',
      'unmanaged': 'Allowed (disables restoration)',
    },
    {
      'aspect': 'Use Case',
      'managed': 'Normal app restoration',
      'unmanaged': 'Testing, custom backends',
    },
    {
      'aspect': 'Parent Dependency',
      'managed': 'Needs parent restoration scope',
      'unmanaged': 'Independent of parent scope',
    },
  ];

  // Build a table-like display
  final headerRow = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    decoration: BoxDecoration(
      color: Colors.amber.withOpacity(0.15),
      borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
    ),
    child: Row(
      children: [
        SizedBox(
          width: 90,
          child: Text(
            'Aspect',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: Colors.amber.shade900,
            ),
          ),
        ),
        Expanded(
          child: Text(
            'Managed',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: Colors.green.shade700,
            ),
          ),
        ),
        Expanded(
          child: Text(
            'Unmanaged',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade700,
            ),
          ),
        ),
      ],
    ),
  );

  final dataRows = <Widget>[];
  for (var i = 0; i < comparisonRows.length; i++) {
    final cr = comparisonRows[i];
    print('Managed vs Unmanaged ${i + 1}: ${cr['aspect']}');
    dataRows.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: i.isEven ? Colors.grey.withOpacity(0.03) : Colors.white,
          border: Border(
            bottom: BorderSide(color: Colors.grey.withOpacity(0.1)),
          ),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 90,
              child: Text(
                cr['aspect']!,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade700,
                ),
              ),
            ),
            Expanded(
              child: Text(
                cr['managed']!,
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
            Expanded(
              child: Text(
                cr['unmanaged']!,
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 5: Restoration Flow
  // ============================================================
  print('=== Section 5: Restoration Flow ===');

  final flowSteps = <Map<String, dynamic>>[
    {
      'step': '1. App Backgrounded',
      'desc': 'The OS signals the app to save state. The restoration '
          'system serializes all RestorationBuckets into a flat '
          'binary format and hands it to the platform.',
      'icon': Icons.pause_circle,
      'color': Colors.amber,
    },
    {
      'step': '2. App Killed',
      'desc': 'The OS terminates the app process to reclaim memory. '
          'The serialized restoration data persists in platform '
          'storage (Android: saved instance state, iOS: state '
          'restoration archive).',
      'icon': Icons.close,
      'color': Colors.red,
    },
    {
      'step': '3. App Relaunched',
      'desc': 'When the user returns, the OS provides the stored data. '
          'The engine deserializes it back into a root bucket. '
          'WidgetsApp receives the bucket and distributes it.',
      'icon': Icons.play_arrow,
      'color': Colors.green,
    },
    {
      'step': '4. Buckets Distributed',
      'desc': 'Each RestorationScope (or UnmanagedRestorationScope) '
          'receives its child bucket from the parent. Widgets with '
          'RestorationMixin register their properties.',
      'icon': Icons.account_tree,
      'color': Colors.blue,
    },
    {
      'step': '5. State Restored',
      'desc': 'Registered RestorableProperties read their values from '
          'the bucket. The counter is back to 42, the scroll position '
          'is restored, the tab index is remembered.',
      'icon': Icons.restore,
      'color': Colors.purple,
    },
  ];

  final flowWidgets = <Widget>[];
  for (var i = 0; i < flowSteps.length; i++) {
    final fs = flowSteps[i];
    final fsColor = fs['color'] as Color;
    print('Flow ${i + 1}: ${fs['step']}');
    flowWidgets.add(
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
                    color: fsColor.withOpacity(0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    fs['icon'] as IconData,
                    color: fsColor,
                    size: 18,
                  ),
                ),
                if (i < flowSteps.length - 1)
                  Container(
                    width: 2,
                    height: 24,
                    color: fsColor.withOpacity(0.2),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: fsColor.withOpacity(0.04),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: fsColor.withOpacity(0.15)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      fs['step'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: fsColor,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      fs['desc'] as String,
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
  // SECTION 6: Registration
  // ============================================================
  print('=== Section 6: Registration ===');

  final restorableTypes = <Map<String, dynamic>>[
    {
      'type': 'RestorableInt',
      'desc': 'Stores an integer value. Common for counters, indices, '
          'selected tab positions, or quantities.',
      'example': 'Counter: 42 \u2192 saved \u2192 restored as 42',
      'color': Colors.amber,
    },
    {
      'type': 'RestorableDouble',
      'desc': 'Stores a double-precision float. Used for scroll offsets, '
          'animation progress, slider values, or opacity.',
      'example': 'Scroll: 350.5px \u2192 saved \u2192 restored at 350.5px',
      'color': Colors.blue,
    },
    {
      'type': 'RestorableString',
      'desc': 'Stores a text string. Used for search queries, form '
          'field contents, user names, or selected options.',
      'example': 'Search: "flutter" \u2192 saved \u2192 restored as "flutter"',
      'color': Colors.green,
    },
    {
      'type': 'RestorableBool',
      'desc': 'Stores a boolean flag. Used for toggle states, checkbox '
          'values, expansion panels, or visibility flags.',
      'example': 'Dark mode: true \u2192 saved \u2192 restored as true',
      'color': Colors.orange,
    },
    {
      'type': 'RestorableDateTime',
      'desc': 'Stores a DateTime. Used for date pickers, scheduled dates, '
          'or last-visited timestamps.',
      'example': 'Date: 2026-04-07 \u2192 saved \u2192 restored as 2026-04-07',
      'color': Colors.purple,
    },
    {
      'type': 'RestorableTextEditingController',
      'desc': 'Wraps a TextEditingController. Restores the text content, '
          'selection range, and composing region of a text field.',
      'example': 'TextField: "Hello" \u2192 saved \u2192 restored with cursor',
      'color': Colors.teal,
    },
  ];

  final regWidgets = <Widget>[];
  for (var i = 0; i < restorableTypes.length; i++) {
    final rt = restorableTypes[i];
    final rtColor = rt['color'] as Color;
    print('Restorable ${i + 1}: ${rt['type']}');
    regWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: rtColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: rtColor.withOpacity(0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: rtColor.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    rt['type'] as String,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: rtColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              rt['desc'] as String,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade700,
                height: 1.35,
              ),
            ),
            const SizedBox(height: 4),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E2E),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                rt['example'] as String,
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
    );
  }

  // ============================================================
  // SECTION 7: Use Cases
  // ============================================================
  print('=== Section 7: Use Cases ===');

  final useCases = <Map<String, dynamic>>[
    {
      'title': 'Testing Restoration',
      'desc': 'In widget tests, inject an UnmanagedRestorationScope with '
          'a pre-populated bucket to verify that a widget correctly '
          'restores its state without needing a full app lifecycle.',
      'icon': Icons.science,
      'color': Colors.amber,
    },
    {
      'title': 'Custom State Backend',
      'desc': 'When using a custom persistence backend (database, '
          'shared preferences, server), create buckets manually and '
          'inject them via UnmanagedRestorationScope instead of '
          'relying on the platform restoration mechanism.',
      'icon': Icons.storage,
      'color': Colors.blue,
    },
    {
      'title': 'Plugin Integration',
      'desc': 'Plugins that manage their own restoration data can '
          'use UnmanagedRestorationScope to provide that data to '
          'Flutter widgets embedded within the plugin UI.',
      'icon': Icons.extension,
      'color': Colors.green,
    },
    {
      'title': 'Conditional Restoration',
      'desc': 'Toggle restoration on/off by passing null to the bucket '
          'parameter. When null, descendants skip state saving. '
          'Useful for guest mode or privacy-sensitive screens.',
      'icon': Icons.toggle_on,
      'color': Colors.orange,
    },
    {
      'title': 'Multi-Window Support',
      'desc': 'Each window or tab can have its own restoration bucket '
          'injected via UnmanagedRestorationScope, keeping state '
          'separate between windows while sharing the same app.',
      'icon': Icons.tab,
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
  // SECTION 8: Summary
  // ============================================================
  print('=== Section 8: Summary ===');

  final summaryPoints = <Map<String, dynamic>>[
    {
      'icon': Icons.restore,
      'text': 'UnmanagedRestorationScope injects an externally-owned '
          'RestorationBucket into the widget tree.',
    },
    {
      'icon': Icons.settings_backup_restore,
      'text': 'Unlike RestorationScope, it does not create or dispose '
          'the bucket. The caller owns the lifecycle.',
    },
    {
      'icon': Icons.account_tree,
      'text': 'Buckets form a tree hierarchy. Each level stores state '
          'relevant to that part of the widget tree.',
    },
    {
      'icon': Icons.save,
      'text': 'RestorableProperties (int, string, bool, etc.) register '
          'with the nearest bucket for automatic save/restore.',
    },
    {
      'icon': Icons.science,
      'text': 'Primary use cases: testing, custom backends, conditional '
          'restoration, and multi-window scenarios.',
    },
    {
      'icon': Icons.toggle_off,
      'text': 'Passing null as bucket disables restoration for the '
          'entire subtree — useful for privacy screens.',
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
                color: Colors.amber.shade900,
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
        title: const Text('UnmanagedRestorationScope'),
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
            Tab(icon: Icon(Icons.account_tree), text: 'Hierarchy'),
            Tab(icon: Icon(Icons.compare), text: 'Compare'),
            Tab(icon: Icon(Icons.sync), text: 'Flow'),
            Tab(icon: Icon(Icons.app_registration), text: 'Register'),
            Tab(icon: Icon(Icons.lightbulb), text: 'Use Cases'),
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
                  'UnmanagedRestorationScope: inject an externally-managed '
                  'restoration bucket into the widget tree.',
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
                  'API surface for UnmanagedRestorationScope and related classes.',
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
                  'RestorationBucket tree structure mirrors the widget tree.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...hierarchyWidgets,
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
                  'RestorationScope vs UnmanagedRestorationScope.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              headerRow,
              ...dataRows,
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
                  'How state restoration flows from save to restore.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...flowWidgets,
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
                  'RestorableProperty types that register with buckets.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...regWidgets,
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
                  'Real-world scenarios for UnmanagedRestorationScope.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...useCaseWidgets,
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
                      Colors.amber.withOpacity(0.14),
                      Colors.orange.withOpacity(0.06),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Key takeaways about UnmanagedRestorationScope.',
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
