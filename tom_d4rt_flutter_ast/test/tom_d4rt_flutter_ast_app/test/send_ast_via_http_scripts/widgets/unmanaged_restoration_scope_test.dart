// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo - UnmanagedRestorationScope (live).
//
// This demo wires real UnmanagedRestorationScope widgets into the live tree,
// each binding a real (or null) RestorationBucket. The script demonstrates:
//   * Live UnmanagedRestorationScope nodes wrapping subtrees
//   * Real RestorationBucket.empty bindings created at script time
//   * Null-bucket variant that disables restoration for a subtree
//   * Multi-bucket sibling layout with independent restoration scopes
//   * Cooperation with RestorationScope and RestorableInt/Bool/String
//   * Behavioural narrative for save/restore lifecycle
//   * Comparison tables, API reference, use cases, and a final summary
//
// Harness contract: build(BuildContext) returns a MaterialApp ->
// Scaffold -> SafeArea -> SingleChildScrollView -> Column tree.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('UnmanagedRestorationScope deep demo executing');

  // ============================================================
  // BUCKET FACTORY: build a small graveyard of live buckets that
  // we will hand to UnmanagedRestorationScope widgets below.
  // ============================================================
  print('Allocating live RestorationBucket instances');

  final RestorationBucket bucketAlpha = RestorationBucket.empty(
    restorationId: 'demo_alpha',
    debugOwner: 'unmanaged_demo.alpha',
  );
  final RestorationBucket bucketBeta = RestorationBucket.empty(
    restorationId: 'demo_beta',
    debugOwner: 'unmanaged_demo.beta',
  );
  final RestorationBucket bucketGamma = RestorationBucket.empty(
    restorationId: 'demo_gamma',
    debugOwner: 'unmanaged_demo.gamma',
  );
  final RestorationBucket bucketDelta = RestorationBucket.empty(
    restorationId: 'demo_delta',
    debugOwner: 'unmanaged_demo.delta',
  );
  final RestorationBucket bucketEpsilon = RestorationBucket.empty(
    restorationId: 'demo_epsilon',
    debugOwner: 'unmanaged_demo.epsilon',
  );
  final RestorationBucket bucketCounter = RestorationBucket.empty(
    restorationId: 'demo_counter',
    debugOwner: 'unmanaged_demo.counter',
  );
  final RestorationBucket bucketSettings = RestorationBucket.empty(
    restorationId: 'demo_settings',
    debugOwner: 'unmanaged_demo.settings',
  );
  final RestorationBucket bucketProfile = RestorationBucket.empty(
    restorationId: 'demo_profile',
    debugOwner: 'unmanaged_demo.profile',
  );
  final RestorationBucket bucketSearch = RestorationBucket.empty(
    restorationId: 'demo_search',
    debugOwner: 'unmanaged_demo.search',
  );

  print('Bucket alpha id: ${bucketAlpha.restorationId}');
  print('Bucket beta id: ${bucketBeta.restorationId}');
  print('Bucket gamma id: ${bucketGamma.restorationId}');
  print('Bucket delta id: ${bucketDelta.restorationId}');
  print('Bucket epsilon id: ${bucketEpsilon.restorationId}');
  print('Bucket counter id: ${bucketCounter.restorationId}');
  print('Bucket settings id: ${bucketSettings.restorationId}');
  print('Bucket profile id: ${bucketProfile.restorationId}');
  print('Bucket search id: ${bucketSearch.restorationId}');

  // Resolve platform once for guards.
  final TargetPlatform platform = Theme.of(context).platform;
  final String platformName = platform.toString().split('.').last;
  print('Platform: $platformName');

  // ============================================================
  // SECTION 1: Concept cards.
  // ============================================================
  print('=== Section 1: Concept ===');

  final List<Map<String, dynamic>> conceptItems = <Map<String, dynamic>>[
    <String, dynamic>{
      'icon': Icons.restore,
      'title': 'What is UnmanagedRestorationScope?',
      'body':
          'UnmanagedRestorationScope is an InheritedWidget that injects a '
          'RestorationBucket into the widget tree without taking ownership '
          'of the bucket lifecycle. The caller creates and disposes the '
          'bucket; the widget only exposes it to descendants.',
      'accent': Colors.amber,
    },
    <String, dynamic>{
      'icon': Icons.account_tree,
      'title': 'State Restoration System',
      'body':
          "Flutter's restoration system preserves widget state across app "
          'restarts (notably on Android when the OS kills background apps). '
          'Data lives in a hierarchical bucket tree that mirrors a slice of '
          'the widget tree.',
      'accent': Colors.blue,
    },
    <String, dynamic>{
      'icon': Icons.folder_open,
      'title': 'Restoration Buckets',
      'body':
          'A RestorationBucket is a scoped container for restoration data. '
          'Each bucket has a string ID, can hold scalar values via '
          'RestorableProperty subclasses, and may contain child buckets.',
      'accent': Colors.green,
    },
    <String, dynamic>{
      'icon': Icons.settings_backup_restore,
      'title': 'When to use Unmanaged',
      'body':
          'Use UnmanagedRestorationScope when you already own the bucket: '
          'integration with a custom backend, isolated test fixtures, or '
          'plugin code that returns its own bucket from native side.',
      'accent': Colors.orange,
    },
    <String, dynamic>{
      'icon': Icons.toggle_off,
      'title': 'Null bucket disables restoration',
      'body':
          'If you pass null as the bucket parameter, descendants behave as '
          'though no restoration scope is present. This is the canonical '
          'switch for privacy-sensitive screens and guest mode.',
      'accent': Colors.purple,
    },
    <String, dynamic>{
      'icon': Icons.swap_horiz,
      'title': 'Hot-swap buckets at runtime',
      'body':
          'Because UnmanagedRestorationScope is an InheritedWidget, changing '
          'the bucket reference rebuilds descendants and rebinds their '
          'RestorableProperty instances against the new bucket.',
      'accent': Colors.teal,
    },
  ];

  final List<Widget> conceptCards = <Widget>[];
  for (int i = 0; i < conceptItems.length; i++) {
    final Map<String, dynamic> e = conceptItems[i];
    final Color accent = e['accent'] as Color;
    print('Concept ${i + 1}: ${e['title']}');
    conceptCards.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              accent.withOpacity(0.14),
              accent.withOpacity(0.03),
            ],
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
            children: <Widget>[
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
                  children: <Widget>[
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
  // SECTION 2: API surface (verified against Flutter SDK).
  // ============================================================
  print('=== Section 2: API ===');

  final List<Map<String, String>> apiEntries = <Map<String, String>>[
    <String, String>{
      'name': 'UnmanagedRestorationScope({key, bucket, required child})',
      'type': 'const constructor',
      'desc':
          'Creates the inherited widget. bucket is RestorationBucket?; if '
          'null, restoration is disabled for the subtree. child is required.',
    },
    <String, String>{
      'name': 'bucket',
      'type': 'RestorationBucket?',
      'desc':
          'The restoration bucket made available to descendants. The widget '
          'does not own it: do not expect dispose to clean it up.',
    },
    <String, String>{
      'name': 'child',
      'type': 'Widget',
      'desc':
          'The subtree that can access the bucket via RestorationScope.of.',
    },
    <String, String>{
      'name': 'updateShouldNotify(old)',
      'type': 'bool override',
      'desc':
          'Returns oldWidget.bucket != bucket, so descendants only rebuild '
          'when the bucket reference itself changes.',
    },
    <String, String>{
      'name': 'RestorationScope.of(context)',
      'type': 'static RestorationBucket?',
      'desc':
          'Walks up the inherited tree and returns the nearest bucket '
          'provided by either RestorationScope or UnmanagedRestorationScope.',
    },
    <String, String>{
      'name': 'RestorationBucket.empty',
      'type': 'factory constructor',
      'desc':
          'Creates a fresh bucket with a restorationId and debugOwner. '
          'Used here to feed UnmanagedRestorationScope live, runnable buckets.',
    },
    <String, String>{
      'name': 'RestorationBucket.read / write',
      'type': 'methods',
      'desc':
          'Read and write primitive values (int, bool, String, List, Map) '
          'into the bucket using string keys.',
    },
    <String, String>{
      'name': 'RestorableInt / Bool / String',
      'type': 'RestorableProperty subclasses',
      'desc':
          'High-level wrappers that register with a bucket via '
          'RestorationMixin and expose a typed value with change notification.',
    },
  ];

  final List<Widget> apiWidgets = <Widget>[];
  for (int i = 0; i < apiEntries.length; i++) {
    final Map<String, String> ae = apiEntries[i];
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
          children: <Widget>[
            Wrap(
              spacing: 8,
              runSpacing: 4,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: <Widget>[
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
  // SECTION 3: LIVE Unmanaged scope wrapping a labelled subtree.
  // This block instantiates a real UnmanagedRestorationScope in
  // the widget tree with bucketAlpha. Descendants can call
  // RestorationScope.of(context) and get bucketAlpha back.
  // ============================================================
  print('=== Section 3: Live Unmanaged subtree (alpha) ===');

  final Widget liveAlphaSection = UnmanagedRestorationScope(
    bucket: bucketAlpha,
    child: Builder(
      builder: (BuildContext inner) {
        final RestorationBucket? injected = RestorationScope.maybeOf(inner);
        final String injectedId = injected?.restorationId ?? '<none>';
        print('Live alpha sees bucket: $injectedId');
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.amber.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.amber.withOpacity(0.4)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    Icons.bolt,
                    color: Colors.amber.shade800,
                    size: 22,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Live UnmanagedRestorationScope (alpha)',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber.shade900,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                'This box is wrapped by a real UnmanagedRestorationScope. '
                'A descendant Builder calls RestorationScope.of(context) '
                'and prints the bucket ID at script time.',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade800,
                  height: 1.4,
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
                  'RestorationScope.of(context)?.restorationId = $injectedId',
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11,
                    color: Color(0xFFCDD6F4),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    ),
  );

  // ============================================================
  // SECTION 4: NULL-bucket subtree. This is the canonical "turn
  // restoration off for this branch" pattern.
  // ============================================================
  print('=== Section 4: Null-bucket subtree ===');

  final Widget nullBucketSection = UnmanagedRestorationScope(
    bucket: null,
    child: Builder(
      builder: (BuildContext inner) {
        final RestorationBucket? injected = RestorationScope.maybeOf(inner);
        final String injectedId = injected?.restorationId ?? '<null>';
        print('Null-bucket subtree sees bucket: $injectedId');
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.red.withOpacity(0.04),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.red.withOpacity(0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    Icons.lock,
                    color: Colors.red.shade700,
                    size: 22,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'UnmanagedRestorationScope(bucket: null)',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.red.shade800,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                'Descendants of this scope behave as if no restoration is '
                'available at all. This is the opt-out switch for guest mode '
                'or privacy-sensitive panels.',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade800,
                  height: 1.4,
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
                  'RestorationScope.of(context) = $injectedId',
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11,
                    color: Color(0xFFCDD6F4),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    ),
  );

  // ============================================================
  // SECTION 5: Sibling subtrees with different unmanaged buckets.
  // We render two side-by-side cards, each wrapped by its own
  // UnmanagedRestorationScope with a distinct bucket.
  // ============================================================
  print('=== Section 5: Sibling unmanaged scopes (beta + gamma) ===');

  Widget buildSiblingCard({
    required String label,
    required RestorationBucket bucket,
    required Color accent,
    required IconData icon,
  }) {
    return UnmanagedRestorationScope(
      bucket: bucket,
      child: Builder(
        builder: (BuildContext inner) {
          final RestorationBucket? injected = RestorationScope.maybeOf(inner);
          final String injectedId = injected?.restorationId ?? '<none>';
          print('Sibling $label sees: $injectedId');
          return Container(
            margin: const EdgeInsets.all(6),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: accent.withOpacity(0.06),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: accent.withOpacity(0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(icon, color: accent, size: 18),
                    const SizedBox(width: 6),
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: accent,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  'Bucket id: $injectedId',
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'debugOwner: ${bucket.debugOwner}',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  final Widget siblingsSection = Container(
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Colors.grey.withOpacity(0.03),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.withOpacity(0.15)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            'Two sibling UnmanagedRestorationScope nodes, each with its own '
            'bucket. The siblings cannot see each other\'s buckets - they are '
            'fully independent restoration islands.',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade800,
              height: 1.4,
            ),
          ),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: buildSiblingCard(
                label: 'Beta scope',
                bucket: bucketBeta,
                accent: Colors.blue,
                icon: Icons.cloud,
              ),
            ),
            Expanded(
              child: buildSiblingCard(
                label: 'Gamma scope',
                bucket: bucketGamma,
                accent: Colors.green,
                icon: Icons.eco,
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 6: Nested unmanaged scopes. Inner replaces outer.
  // ============================================================
  print('=== Section 6: Nested unmanaged scopes ===');

  final Widget nestedSection = UnmanagedRestorationScope(
    bucket: bucketDelta,
    child: Builder(
      builder: (BuildContext outer) {
        final String outerId =
            RestorationScope.maybeOf(outer)?.restorationId ?? '<none>';
        print('Nested outer sees: $outerId');
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.indigo.withOpacity(0.04),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.indigo.withOpacity(0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Outer scope (delta)',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo.shade700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'RestorationScope.of -> $outerId',
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                ),
              ),
              const SizedBox(height: 12),
              UnmanagedRestorationScope(
                bucket: bucketEpsilon,
                child: Builder(
                  builder: (BuildContext inner) {
                    final String innerId =
                        RestorationScope.maybeOf(inner)?.restorationId ??
                            '<none>';
                    print('Nested inner sees: $innerId');
                    return Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple.withOpacity(0.06),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.deepPurple.withOpacity(0.3),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Inner scope (epsilon)',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple.shade700,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'RestorationScope.of -> $innerId',
                            style: const TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 11,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'The inner scope shadows the outer one - any '
                            'descendant beneath it sees epsilon, not delta.',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey.shade700,
                              height: 1.35,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    ),
  );

  // ============================================================
  // SECTION 7: Bucket hierarchy explainer.
  // ============================================================
  print('=== Section 7: Bucket hierarchy ===');

  final List<Map<String, dynamic>> hierarchyLevels = <Map<String, dynamic>>[
    <String, dynamic>{
      'level': 0,
      'name': 'Root Bucket',
      'desc':
          'Provided by the engine or WidgetsApp via RootRestorationScope. '
          'Holds the entire restoration tree for the application.',
      'color': Colors.amber,
      'indent': 0,
    },
    <String, dynamic>{
      'level': 1,
      'name': 'Navigator Bucket',
      'desc':
          'Each Navigator with a restorationScopeId gets a child bucket. '
          'Stores the route stack and route-level state.',
      'color': Colors.blue,
      'indent': 1,
    },
    <String, dynamic>{
      'level': 2,
      'name': 'Route Bucket',
      'desc':
          'Routes claim child buckets from the Navigator. Stores per-screen '
          'state (scroll positions, form fields, tab indices).',
      'color': Colors.green,
      'indent': 2,
    },
    <String, dynamic>{
      'level': 3,
      'name': 'Widget Bucket',
      'desc':
          'Widgets with RestorationMixin claim child buckets. This is where '
          'RestorableInt / String / Bool values live.',
      'color': Colors.orange,
      'indent': 3,
    },
    <String, dynamic>{
      'level': 4,
      'name': 'Custom Bucket (Unmanaged)',
      'desc':
          'UnmanagedRestorationScope can splice an externally-owned bucket '
          'into any level of this tree.',
      'color': Colors.purple,
      'indent': 2,
    },
  ];

  final List<Widget> hierarchyWidgets = <Widget>[];
  for (int i = 0; i < hierarchyLevels.length; i++) {
    final Map<String, dynamic> hl = hierarchyLevels[i];
    final Color hlColor = hl['color'] as Color;
    final int indent = hl['indent'] as int;
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
          children: <Widget>[
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
                children: <Widget>[
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
  // SECTION 8: Managed vs Unmanaged comparison table.
  // ============================================================
  print('=== Section 8: Managed vs Unmanaged ===');

  final List<Map<String, String>> comparisonRows = <Map<String, String>>[
    <String, String>{
      'aspect': 'Widget',
      'managed': 'RestorationScope',
      'unmanaged': 'UnmanagedRestorationScope',
    },
    <String, String>{
      'aspect': 'Bucket Lifecycle',
      'managed': 'Creates and disposes bucket',
      'unmanaged': 'Caller owns lifecycle',
    },
    <String, String>{
      'aspect': 'Bucket Source',
      'managed': 'Claims child from parent bucket',
      'unmanaged': 'Accepts external bucket',
    },
    <String, String>{
      'aspect': 'Restoration ID',
      'managed': 'Required',
      'unmanaged': 'Not needed (bucket already has one)',
    },
    <String, String>{
      'aspect': 'Null Bucket',
      'managed': 'Not allowed',
      'unmanaged': 'Allowed (disables restoration)',
    },
    <String, String>{
      'aspect': 'Use Case',
      'managed': 'Normal app restoration',
      'unmanaged': 'Tests, plugins, custom backends',
    },
    <String, String>{
      'aspect': 'Parent Dependency',
      'managed': 'Needs parent bucket',
      'unmanaged': 'Independent of parent scope',
    },
    <String, String>{
      'aspect': 'Rebuild Trigger',
      'managed': 'On id or parent change',
      'unmanaged': 'On bucket reference change',
    },
  ];

  final Widget tableHeader = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    decoration: BoxDecoration(
      color: Colors.amber.withOpacity(0.15),
      borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
    ),
    child: Row(
      children: <Widget>[
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

  final List<Widget> tableRows = <Widget>[];
  for (int i = 0; i < comparisonRows.length; i++) {
    final Map<String, String> cr = comparisonRows[i];
    print('Compare ${i + 1}: ${cr['aspect']}');
    tableRows.add(
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
          children: <Widget>[
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
  // SECTION 9: Save/restore lifecycle flow.
  // ============================================================
  print('=== Section 9: Lifecycle flow ===');

  final List<Map<String, dynamic>> flowSteps = <Map<String, dynamic>>[
    <String, dynamic>{
      'step': '1. App backgrounded',
      'desc':
          'OS signals the app to save state. The restoration system serialises '
          'all RestorationBuckets (managed and unmanaged ones whose buckets '
          'opt in) into a flat binary.',
      'icon': Icons.pause_circle,
      'color': Colors.amber,
    },
    <String, dynamic>{
      'step': '2. App killed',
      'desc':
          'The OS terminates the process. The serialised data persists in '
          'platform storage (Android saved instance state / iOS state '
          'restoration archive).',
      'icon': Icons.close,
      'color': Colors.red,
    },
    <String, dynamic>{
      'step': '3. App relaunched',
      'desc':
          'The engine deserialises the data into a root bucket. WidgetsApp '
          'receives it and distributes it down the tree.',
      'icon': Icons.play_arrow,
      'color': Colors.green,
    },
    <String, dynamic>{
      'step': '4. Buckets distributed',
      'desc':
          'Each RestorationScope claims a child bucket. UnmanagedRestoration'
          'Scope inserts its externally-owned bucket at the right place.',
      'icon': Icons.account_tree,
      'color': Colors.blue,
    },
    <String, dynamic>{
      'step': '5. Properties restored',
      'desc':
          'Registered RestorableProperties read their values from the bucket '
          'and notify their owners.',
      'icon': Icons.restore,
      'color': Colors.purple,
    },
  ];

  final List<Widget> flowWidgets = <Widget>[];
  for (int i = 0; i < flowSteps.length; i++) {
    final Map<String, dynamic> fs = flowSteps[i];
    final Color fsColor = fs['color'] as Color;
    print('Flow ${i + 1}: ${fs['step']}');
    flowWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              children: <Widget>[
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
                  children: <Widget>[
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
  // SECTION 10: RestorableProperty registry.
  // ============================================================
  print('=== Section 10: Restorable property types ===');

  final List<Map<String, dynamic>> restorableTypes = <Map<String, dynamic>>[
    <String, dynamic>{
      'type': 'RestorableInt',
      'desc':
          'Stores an integer. Common for counters, indices, selected tabs.',
      'example': 'Counter: 42 -> saved -> restored as 42',
      'color': Colors.amber,
    },
    <String, dynamic>{
      'type': 'RestorableDouble',
      'desc':
          'Stores a double. Used for scroll offsets, animation progress, '
          'slider values.',
      'example': 'Scroll: 350.5px -> saved -> restored at 350.5px',
      'color': Colors.blue,
    },
    <String, dynamic>{
      'type': 'RestorableString',
      'desc':
          'Stores a String. Used for search queries, form fields, '
          'selected option keys.',
      'example': 'Search: "flutter" -> saved -> restored as "flutter"',
      'color': Colors.green,
    },
    <String, dynamic>{
      'type': 'RestorableBool',
      'desc':
          'Stores a boolean. Used for toggle states, checkboxes, '
          'expansion panels.',
      'example': 'Dark mode: true -> saved -> restored as true',
      'color': Colors.orange,
    },
    <String, dynamic>{
      'type': 'RestorableDateTime',
      'desc':
          'Stores a DateTime. Used for date pickers, scheduled dates.',
      'example': 'Date: 2026-04-07 -> saved -> restored as 2026-04-07',
      'color': Colors.purple,
    },
    <String, dynamic>{
      'type': 'RestorableTextEditingController',
      'desc':
          'Wraps a TextEditingController. Restores text, selection, '
          'composing region.',
      'example': 'TextField: "Hello" -> saved -> restored with cursor',
      'color': Colors.teal,
    },
    <String, dynamic>{
      'type': 'RestorableEnum<T>',
      'desc':
          'Stores any enum value. Useful for theme modes, status flags, '
          'view layouts.',
      'example': 'ThemeMode.dark -> saved -> restored as ThemeMode.dark',
      'color': Colors.deepOrange,
    },
    <String, dynamic>{
      'type': 'RestorableNum<T>',
      'desc':
          'Generic numeric base. RestorableInt and RestorableDouble inherit '
          'from this.',
      'example': 'num: 3.14 -> saved -> restored as 3.14',
      'color': Colors.cyan,
    },
  ];

  final List<Widget> regWidgets = <Widget>[];
  for (int i = 0; i < restorableTypes.length; i++) {
    final Map<String, dynamic> rt = restorableTypes[i];
    final Color rtColor = rt['color'] as Color;
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
          children: <Widget>[
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
  // SECTION 11: Use cases.
  // ============================================================
  print('=== Section 11: Use cases ===');

  final List<Map<String, dynamic>> useCases = <Map<String, dynamic>>[
    <String, dynamic>{
      'title': 'Testing restoration',
      'desc':
          'In widget tests, inject an UnmanagedRestorationScope with a '
          'pre-populated bucket to verify a widget restores its state without '
          'driving a full app lifecycle.',
      'icon': Icons.science,
      'color': Colors.amber,
    },
    <String, dynamic>{
      'title': 'Custom state backend',
      'desc':
          'When using a custom persistence layer (database, shared prefs, '
          'server), build buckets manually and inject them via Unmanaged'
          'RestorationScope instead of relying on the platform mechanism.',
      'icon': Icons.storage,
      'color': Colors.blue,
    },
    <String, dynamic>{
      'title': 'Plugin integration',
      'desc':
          'Plugins that already manage restoration data on the native side '
          'can hand the resulting buckets to Flutter widgets via Unmanaged'
          'RestorationScope.',
      'icon': Icons.extension,
      'color': Colors.green,
    },
    <String, dynamic>{
      'title': 'Conditional restoration',
      'desc':
          'Pass null to disable restoration for a subtree. Useful for guest '
          'mode, kiosks, and privacy-sensitive screens.',
      'icon': Icons.toggle_on,
      'color': Colors.orange,
    },
    <String, dynamic>{
      'title': 'Multi-window support',
      'desc':
          'Each window or tab can have its own restoration bucket injected '
          'via UnmanagedRestorationScope, keeping state separate while '
          'sharing the same app instance.',
      'icon': Icons.tab,
      'color': Colors.purple,
    },
    <String, dynamic>{
      'title': 'Embedded mini-apps',
      'desc':
          'When embedding a Flutter slice inside a larger host (e.g. add-to-app), '
          'the host can hand the slice an externally-managed bucket so '
          'restoration aligns with the host policy, not the Flutter default.',
      'icon': Icons.layers,
      'color': Colors.teal,
    },
  ];

  final List<Widget> useCaseWidgets = <Widget>[];
  for (int i = 0; i < useCases.length; i++) {
    final Map<String, dynamic> uc = useCases[i];
    final Color ucColor = uc['color'] as Color;
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
            children: <Widget>[
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
                  children: <Widget>[
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
  // SECTION 12: Live "panel grid" of unmanaged scopes (counter,
  // settings, profile, search). Each panel is independently
  // wrapped by UnmanagedRestorationScope.
  // ============================================================
  print('=== Section 12: Live panel grid ===');

  Widget buildPanel({
    required String title,
    required String description,
    required IconData icon,
    required Color accent,
    required RestorationBucket bucket,
  }) {
    return UnmanagedRestorationScope(
      bucket: bucket,
      child: Builder(
        builder: (BuildContext panelContext) {
          final RestorationBucket? injected =
              RestorationScope.maybeOf(panelContext);
          final String injectedId = injected?.restorationId ?? '<none>';
          print('Panel "$title" sees: $injectedId');
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  accent.withOpacity(0.12),
                  accent.withOpacity(0.02),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: accent.withOpacity(0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: accent.withOpacity(0.18),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(icon, color: accent, size: 22),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: accent,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade800,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E1E2E),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'bucketId = $injectedId\n'
                    'debugOwner = ${bucket.debugOwner}',
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
          );
        },
      ),
    );
  }

  final Widget panelGrid = Column(
    children: <Widget>[
      buildPanel(
        title: 'Counter Panel',
        description:
            'A counter widget would register a RestorableInt with the '
            'bucket counter and recover the last value on restart.',
        icon: Icons.exposure_plus_1,
        accent: Colors.amber,
        bucket: bucketCounter,
      ),
      buildPanel(
        title: 'Settings Panel',
        description:
            'Settings store boolean toggles via RestorableBool. The '
            'unmanaged bucket here is owned by a settings service.',
        icon: Icons.settings,
        accent: Colors.indigo,
        bucket: bucketSettings,
      ),
      buildPanel(
        title: 'Profile Panel',
        description:
            'A profile panel keeps a RestorableString for display name. '
            'The bucket is provided by the user-session service.',
        icon: Icons.person,
        accent: Colors.green,
        bucket: bucketProfile,
      ),
      buildPanel(
        title: 'Search Panel',
        description:
            'Search query state lives in a RestorableTextEditingController. '
            'Its bucket is owned by the search service.',
        icon: Icons.search,
        accent: Colors.purple,
        bucket: bucketSearch,
      ),
    ],
  );

  // ============================================================
  // SECTION 13: Code sample reference.
  // ============================================================
  print('=== Section 13: Code sample ===');

  const String codeSample = '''
final bucket = RestorationBucket.empty(
  restorationId: 'demo',
  debugOwner: 'docs.demo',
);

UnmanagedRestorationScope(
  bucket: bucket,
  child: MyRestorableWidget(),
);

class MyRestorableWidget extends StatefulWidget {
  const MyRestorableWidget({super.key});
  @override
  State<MyRestorableWidget> createState() => _MyState();
}

class _MyState extends State<MyRestorableWidget>
    with RestorationMixin {
  final RestorableInt counter = RestorableInt(0);

  @override
  String? get restorationId => 'my_widget';

  @override
  void restoreState(RestorationBucket? old, bool initialRestore) {
    registerForRestoration(counter, 'counter');
  }

  @override
  void dispose() {
    counter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text('count: \${counter.value}');
  }
}
''';

  final Widget codeSampleSection = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: const Color(0xFF1E1E2E),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(Icons.code, color: Color(0xFFCDD6F4), size: 18),
            const SizedBox(width: 8),
            Text(
              'Canonical code sample',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade300,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Text(
          codeSample,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11,
            color: Color(0xFFCDD6F4),
            height: 1.4,
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 14: Pitfalls.
  // ============================================================
  print('=== Section 14: Pitfalls ===');

  final List<Map<String, dynamic>> pitfalls = <Map<String, dynamic>>[
    <String, dynamic>{
      'title': 'Forgetting to dispose the bucket',
      'desc':
          'UnmanagedRestorationScope does not dispose the bucket. If your '
          'service hands out a bucket, your service must dispose it.',
      'icon': Icons.warning,
      'color': Colors.red,
    },
    <String, dynamic>{
      'title': 'Sharing one bucket across two scopes',
      'desc':
          'The same bucket cannot be claimed by two siblings. If you need '
          'two scopes, create two buckets via RestorationBucket.empty.',
      'icon': Icons.error_outline,
      'color': Colors.orange,
    },
    <String, dynamic>{
      'title': 'Assuming null disables sub-features',
      'desc':
          'Passing null only disables Flutter restoration. Your custom '
          'persistence still runs unless you wire it to the same flag.',
      'icon': Icons.report,
      'color': Colors.amber,
    },
    <String, dynamic>{
      'title': 'Mismatched restoration IDs',
      'desc':
          'If you re-create a bucket with a different restorationId, prior '
          'state will not be found. Keep IDs stable across runs.',
      'icon': Icons.swap_calls,
      'color': Colors.deepPurple,
    },
    <String, dynamic>{
      'title': 'Reading bucket synchronously at build',
      'desc':
          'Bucket data may not be ready in the very first build pass. Use '
          'RestorationMixin.restoreState rather than reading from build.',
      'icon': Icons.timer,
      'color': Colors.blue,
    },
  ];

  final List<Widget> pitfallWidgets = <Widget>[];
  for (int i = 0; i < pitfalls.length; i++) {
    final Map<String, dynamic> p = pitfalls[i];
    final Color pColor = p['color'] as Color;
    print('Pitfall ${i + 1}: ${p['title']}');
    pitfallWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: pColor.withOpacity(0.05),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: pColor.withOpacity(0.3)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(p['icon'] as IconData, color: pColor, size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    p['title'] as String,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: pColor,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    p['desc'] as String,
                    style: TextStyle(
                      fontSize: 11,
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
  // SECTION 15: Platform notes (Theme.of(context).platform guard).
  // ============================================================
  print('=== Section 15: Platform notes ===');

  String platformAdvice;
  Color platformColor;
  IconData platformIcon;
  if (platform == TargetPlatform.android) {
    platformAdvice =
        'Android is the most common target for state restoration. The OS '
        'aggressively kills background apps; UnmanagedRestorationScope '
        'helps test that path with synthetic buckets.';
    platformColor = Colors.green;
    platformIcon = Icons.android;
  } else if (platform == TargetPlatform.iOS) {
    platformAdvice =
        'iOS supports state restoration for some scenes. Unmanaged'
        'RestorationScope is mostly used for testing on iOS or to bridge '
        'to UIKit-side restoration archives.';
    platformColor = Colors.blue;
    platformIcon = Icons.phone_iphone;
  } else if (platform == TargetPlatform.macOS) {
    platformAdvice =
        'macOS does not have aggressive process kills, but Unmanaged'
        'RestorationScope is still useful for window state and tests.';
    platformColor = Colors.indigo;
    platformIcon = Icons.laptop_mac;
  } else if (platform == TargetPlatform.windows) {
    platformAdvice =
        'Windows uses session restore. UnmanagedRestorationScope is most '
        'useful for tests and embedded scenarios.';
    platformColor = Colors.cyan;
    platformIcon = Icons.laptop_windows;
  } else if (platform == TargetPlatform.linux) {
    platformAdvice =
        'Linux desktop has no formal restoration; UnmanagedRestoration'
        'Scope is mainly used for tests, embedded, and custom backends.';
    platformColor = Colors.deepOrange;
    platformIcon = Icons.computer;
  } else {
    platformAdvice =
        'Fuchsia and other targets vary. Treat UnmanagedRestorationScope '
        'as your portable hook into restoration.';
    platformColor = Colors.purple;
    platformIcon = Icons.devices_other;
  }

  final Widget platformSection = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: platformColor.withOpacity(0.06),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: platformColor.withOpacity(0.3)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: platformColor.withOpacity(0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(platformIcon, color: platformColor, size: 22),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Platform: $platformName',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: platformColor,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                platformAdvice,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade800,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 16: Summary takeaways.
  // ============================================================
  print('=== Section 16: Summary ===');

  final List<Map<String, dynamic>> summaryPoints = <Map<String, dynamic>>[
    <String, dynamic>{
      'icon': Icons.restore,
      'text':
          'UnmanagedRestorationScope injects an externally-owned '
          'RestorationBucket into the widget tree.',
    },
    <String, dynamic>{
      'icon': Icons.settings_backup_restore,
      'text':
          'Unlike RestorationScope, it does not create or dispose the '
          'bucket; the caller owns the lifecycle.',
    },
    <String, dynamic>{
      'icon': Icons.account_tree,
      'text':
          'Buckets form a tree hierarchy. Each level stores state '
          'relevant to that part of the widget tree.',
    },
    <String, dynamic>{
      'icon': Icons.save,
      'text':
          'RestorableProperties (int, string, bool, etc.) register with '
          'the nearest bucket for automatic save/restore.',
    },
    <String, dynamic>{
      'icon': Icons.science,
      'text':
          'Primary use cases: testing, custom backends, conditional '
          'restoration, and multi-window scenarios.',
    },
    <String, dynamic>{
      'icon': Icons.toggle_off,
      'text':
          'Passing null disables restoration for the entire subtree.',
    },
    <String, dynamic>{
      'icon': Icons.swap_horiz,
      'text':
          'Changing the bucket reference triggers updateShouldNotify and '
          'rebuilds descendants.',
    },
    <String, dynamic>{
      'icon': Icons.lock,
      'text':
          'Use null-bucket scopes for guest mode, kiosks, and any privacy-'
          'sensitive subtree.',
    },
  ];

  final List<Widget> summaryWidgets = <Widget>[];
  for (int i = 0; i < summaryPoints.length; i++) {
    final Map<String, dynamic> sp = summaryPoints[i];
    final String snippet =
        (sp['text'] as String).substring(0, 40);
    print('Summary ${i + 1}: $snippet...');
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
          children: <Widget>[
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
  // SECTION 17: Final live banner.
  // We wrap the closing banner in yet another UnmanagedRestoration
  // Scope to drive the point home: any node, any depth.
  // ============================================================
  print('=== Section 17: Final live banner ===');

  final Widget finalBanner = UnmanagedRestorationScope(
    bucket: bucketAlpha,
    child: Builder(
      builder: (BuildContext bannerContext) {
        final RestorationBucket? injected =
            RestorationScope.maybeOf(bannerContext);
        final String injectedId = injected?.restorationId ?? '<none>';
        print('Final banner sees: $injectedId');
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                Colors.amber.withOpacity(0.18),
                Colors.deepOrange.withOpacity(0.10),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.amber.withOpacity(0.4)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    Icons.flag,
                    color: Colors.amber.shade900,
                    size: 26,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'You reached the end',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber.shade900,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                'This banner is itself wrapped in an UnmanagedRestorationScope. '
                'Demonstrating that the widget can appear at the very top, '
                'in the middle, or at the very bottom of any tree slice.',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade800,
                  height: 1.45,
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
                  'banner.RestorationScope.of(context).restorationId = '
                  '$injectedId',
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11,
                    color: Color(0xFFCDD6F4),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    ),
  );

  // ============================================================
  // FINAL ASSEMBLY: harness contract.
  // MaterialApp -> Scaffold -> SafeArea -> SingleChildScrollView -> Column.
  // ============================================================
  print('Assembling final harness layout');

  Widget sectionHeader(String title, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 18, 16, 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(8),
        border: Border(
          left: BorderSide(color: color, width: 4),
        ),
      ),
      child: Row(
        children: <Widget>[
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'UnmanagedRestorationScope Deep Demo',
    theme: ThemeData(
      colorSchemeSeed: Colors.amber,
      useMaterial3: true,
    ),
    home: Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('UnmanagedRestorationScope'),
        backgroundColor: Colors.amber.shade700,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Top intro banner.
              Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[
                      Colors.amber.withOpacity(0.18),
                      Colors.deepOrange.withOpacity(0.08),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.amber.withOpacity(0.4)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.restore,
                          color: Colors.amber.shade900,
                          size: 28,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'UnmanagedRestorationScope - live demo',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.amber.shade900,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Inject an externally-owned RestorationBucket into the '
                      'widget tree without managing its lifecycle. This script '
                      'wires real instances into the live tree.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade800,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),

              sectionHeader('1. Concept', Icons.info_outline, Colors.amber),
              ...conceptCards,

              sectionHeader('2. API surface', Icons.api, Colors.indigo),
              ...apiWidgets,

              sectionHeader(
                '3. Live unmanaged scope (alpha)',
                Icons.bolt,
                Colors.amber,
              ),
              liveAlphaSection,

              sectionHeader(
                '4. Null-bucket subtree',
                Icons.lock,
                Colors.red,
              ),
              nullBucketSection,

              sectionHeader(
                '5. Sibling unmanaged scopes',
                Icons.linear_scale,
                Colors.blue,
              ),
              siblingsSection,

              sectionHeader(
                '6. Nested unmanaged scopes',
                Icons.layers,
                Colors.indigo,
              ),
              nestedSection,

              sectionHeader(
                '7. Bucket hierarchy',
                Icons.account_tree,
                Colors.green,
              ),
              ...hierarchyWidgets,

              sectionHeader(
                '8. Managed vs Unmanaged',
                Icons.compare,
                Colors.amber,
              ),
              tableHeader,
              ...tableRows,

              sectionHeader(
                '9. Lifecycle flow',
                Icons.sync,
                Colors.purple,
              ),
              ...flowWidgets,

              sectionHeader(
                '10. RestorableProperty types',
                Icons.app_registration,
                Colors.teal,
              ),
              ...regWidgets,

              sectionHeader(
                '11. Use cases',
                Icons.lightbulb,
                Colors.orange,
              ),
              ...useCaseWidgets,

              sectionHeader(
                '12. Live panel grid',
                Icons.grid_view,
                Colors.deepPurple,
              ),
              panelGrid,

              sectionHeader(
                '13. Code sample',
                Icons.code,
                Colors.blueGrey,
              ),
              codeSampleSection,

              sectionHeader(
                '14. Pitfalls',
                Icons.warning,
                Colors.red,
              ),
              ...pitfallWidgets,

              sectionHeader(
                '15. Platform notes',
                Icons.devices,
                Colors.cyan,
              ),
              platformSection,

              sectionHeader(
                '16. Summary',
                Icons.summarize,
                Colors.amber,
              ),
              ...summaryWidgets,

              sectionHeader(
                '17. Final live banner',
                Icons.flag,
                Colors.deepOrange,
              ),
              finalBanner,

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    ),
  );
}
