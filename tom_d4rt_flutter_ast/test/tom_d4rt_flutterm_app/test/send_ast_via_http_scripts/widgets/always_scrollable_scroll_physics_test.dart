// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
// D4rt test script: Deep Demo — AlwaysScrollableScrollPhysics
// Demonstrates AlwaysScrollableScrollPhysics, the ScrollPhysics subclass that
// ensures a Scrollable is always scrollable even when content fits the viewport.
// Covers the ScrollPhysics family, pull-to-refresh patterns, physics chaining,
// platform defaults, and side-by-side comparisons.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('AlwaysScrollableScrollPhysics Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept — What is AlwaysScrollableScrollPhysics?
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.swap_vert,
      'title': 'AlwaysScrollableScrollPhysics',
      'body': 'By default, a ListView or ScrollView only scrolls when '
          'its content exceeds the viewport. AlwaysScrollableScrollPhysics '
          'overrides this — the view is scrollable regardless of content '
          'size. This enables overscroll indicators and pull-to-refresh '
          'even on short lists.',
      'accent': Colors.deepOrange,
    },
    {
      'icon': Icons.refresh,
      'title': 'Pull-to-Refresh Enabler',
      'body': 'RefreshIndicator needs the ScrollView to be scrollable '
          'to detect the pull gesture. Without AlwaysScrollableScrollPhysics, '
          'a list with 2 items that fits the screen cannot trigger '
          'pull-to-refresh. This physics class is the standard fix.',
      'accent': Colors.orange,
    },
    {
      'icon': Icons.link,
      'title': 'Physics Chaining',
      'body': 'AlwaysScrollableScrollPhysics takes an optional parent '
          'parameter. It delegates all physics behavior to the parent '
          'but overrides shouldAcceptUserOffset() to always return true. '
          'Common: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()).',
      'accent': Colors.blue,
    },
    {
      'icon': Icons.phone_android,
      'title': 'Platform-Aware',
      'body': 'On iOS, ListView already uses BouncingScrollPhysics (always '
          'scrollable). On Android, it uses ClampingScrollPhysics (not '
          'always scrollable). AlwaysScrollableScrollPhysics makes '
          'behavior consistent across platforms.',
      'accent': Colors.green,
    },
  ];

  print('  Prepared ${conceptCards.length} concept cards');

  final conceptWidgets = conceptCards.map<Widget>((card) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: (card['accent'] as Color).withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: (card['accent'] as Color).withOpacity(0.3),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(card['icon'] as IconData,
              color: card['accent'] as Color, size: 32),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  card['title'] as String,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: card['accent'] as Color,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  card['body'] as String,
                  style: const TextStyle(fontSize: 13, height: 1.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }).toList();

  // ============================================================
  // SECTION 2: API Surface
  // ============================================================
  print('=== Section 2: API Surface ===');

  const alwaysPhysics = AlwaysScrollableScrollPhysics();
  final alwaysPhysicsType = alwaysPhysics.runtimeType.toString();
  final alwaysAllowsImplicit = alwaysPhysics.allowImplicitScrolling;
  print('  runtimeType: $alwaysPhysicsType');
  print('  allowImplicitScrolling: $alwaysAllowsImplicit');

  // Test chaining
  const chainedPhysics = AlwaysScrollableScrollPhysics(
    parent: BouncingScrollPhysics(),
  );
  final chainedParent = chainedPhysics.parent.runtimeType.toString();
  print('  Chained parent: $chainedParent');

  final apiProps = <Map<String, String>>[
    {
      'label': 'Class',
      'value': alwaysPhysicsType,
      'detail': 'Concrete ScrollPhysics subclass',
    },
    {
      'label': 'Extends',
      'value': 'ScrollPhysics',
      'detail': 'Base class for scroll behavior',
    },
    {
      'label': 'Constructor',
      'value': 'const AlwaysScrollableScrollPhysics({parent})',
      'detail': 'Optional parent for chaining',
    },
    {
      'label': 'Key Override',
      'value': 'shouldAcceptUserOffset → true',
      'detail': 'Always returns true, making scroll always active',
    },
    {
      'label': 'parent',
      'value': chainedParent,
      'detail': 'Delegates all other behavior to parent physics',
    },
    {
      'label': 'allowImplicit',
      'value': '$alwaysAllowsImplicit',
      'detail': 'Whether implicit scrolling is allowed',
    },
    {
      'label': 'applyTo()',
      'value': 'Returns new with ancestor merged',
      'detail': 'Used internally to build the effective physics chain',
    },
  ];

  final apiWidgets = apiProps.map<Widget>((prop) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.deepOrange.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border(
          left: BorderSide(color: Colors.deepOrange, width: 4),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 110,
            child: Text(
              prop['label']!,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: Colors.deepOrange,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  prop['value']!,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w600),
                ),
                Text(
                  prop['detail']!,
                  style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }).toList();

  // ============================================================
  // SECTION 3: Side-by-Side Comparison
  // ============================================================
  print('=== Section 3: Side-by-Side Comparison ===');

  // Two mini ListViews: one with default physics (no scroll when content fits)
  // and one with AlwaysScrollableScrollPhysics (always scrollable)
  final shortItems = List.generate(3, (i) => 'Item ${i + 1}');

  Widget buildMiniList(String label, ScrollPhysics? physics, Color accent) {
    return Container(
      width: 150,
      height: 200,
      decoration: BoxDecoration(
        border: Border.all(color: accent.withOpacity(0.4), width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            color: accent,
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: ListView.builder(
              physics: physics,
              itemCount: shortItems.length,
              itemBuilder: (ctx, i) {
                return Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 6, vertical: 3),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: accent.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: accent.withOpacity(0.15)),
                  ),
                  child: Text(
                    shortItems[i],
                    style: TextStyle(fontSize: 13, color: accent),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  final comparisonWidget = Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.deepOrange.withOpacity(0.04),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.deepOrange.withOpacity(0.15)),
    ),
    child: Column(
      children: [
        const Text(
          'Both lists have only 3 items (content fits viewport):',
          style: TextStyle(fontSize: 13, height: 1.4),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildMiniList(
                'Default Physics', null, Colors.grey),
            const SizedBox(width: 12),
            buildMiniList(
                'AlwaysScrollable',
                const AlwaysScrollableScrollPhysics(),
                Colors.deepOrange),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.deepOrange.withOpacity(0.08),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.info, color: Colors.deepOrange, size: 18),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'The left list (default physics) cannot scroll because '
                  'its 3 items fit the viewport. The right list '
                  '(AlwaysScrollableScrollPhysics) is scrollable regardless, '
                  'showing overscroll indicators.',
                  style: TextStyle(
                      fontSize: 12, height: 1.4, color: Colors.grey[700]),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 4: Pull-to-Refresh Pattern
  // ============================================================
  print('=== Section 4: Pull-to-Refresh Pattern ===');

  // RefreshIndicator + AlwaysScrollableScrollPhysics is the standard pattern.
  final refreshDemoCode =
      'RefreshIndicator(\n'
      '  onRefresh: () async {\n'
      '    await fetchNewData();\n'
      '  },\n'
      '  child: ListView.builder(\n'
      '    physics: const AlwaysScrollableScrollPhysics(),\n'
      '    itemCount: items.length,\n'
      '    itemBuilder: (ctx, i) => ListTile(title: Text(items[i])),\n'
      '  ),\n'
      ')';

  // Build a real RefreshIndicator demo
  final refreshDemo = RefreshIndicator(
    onRefresh: () async {
      print('  → Pull-to-refresh triggered!');
    },
    color: Colors.deepOrange,
    child: ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.deepOrange.withOpacity(0.08),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Row(
            children: [
              Icon(Icons.arrow_downward, color: Colors.deepOrange),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Pull down to trigger refresh! This list has only '
                  '2 items but is scrollable thanks to '
                  'AlwaysScrollableScrollPhysics.',
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.orange.withOpacity(0.08),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Row(
            children: [
              Icon(Icons.refresh, color: Colors.orange),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Without AlwaysScrollableScrollPhysics, the '
                  'RefreshIndicator would not activate because the '
                  'list content fits the viewport.',
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 5: ScrollPhysics Family Tree
  // ============================================================
  print('=== Section 5: ScrollPhysics Family Tree ===');

  final physicsFamily = <Map<String, dynamic>>[
    {
      'name': 'ScrollPhysics',
      'purpose': 'Abstract base — defines scrolling behavior contract',
      'icon': Icons.foundation,
      'color': Colors.grey[700]!,
      'isBase': true,
    },
    {
      'name': 'AlwaysScrollableScrollPhysics',
      'purpose': 'Always allows scroll, even when content fits viewport',
      'icon': Icons.swap_vert,
      'color': Colors.deepOrange,
      'isBase': false,
    },
    {
      'name': 'BouncingScrollPhysics',
      'purpose': 'iOS-style overscroll bounce effect',
      'icon': Icons.sports_basketball,
      'color': Colors.blue,
      'isBase': false,
    },
    {
      'name': 'ClampingScrollPhysics',
      'purpose': 'Android-style overscroll glow (no bounce)',
      'icon': Icons.phone_android,
      'color': Colors.green,
      'isBase': false,
    },
    {
      'name': 'NeverScrollableScrollPhysics',
      'purpose': 'Disables scrolling entirely (for nested scrollables)',
      'icon': Icons.block,
      'color': Colors.red,
      'isBase': false,
    },
    {
      'name': 'FixedExtentScrollPhysics',
      'purpose': 'Snaps to fixed-size items (used by ListWheelScrollView)',
      'icon': Icons.straighten,
      'color': Colors.purple,
      'isBase': false,
    },
    {
      'name': 'PageScrollPhysics',
      'purpose': 'Snaps to page boundaries (used by PageView)',
      'icon': Icons.auto_stories,
      'color': Colors.teal,
      'isBase': false,
    },
    {
      'name': 'RangeMaintainingScrollPhysics',
      'purpose': 'Maintains scroll position within a valid range',
      'icon': Icons.tune,
      'color': Colors.amber[800]!,
      'isBase': false,
    },
  ];

  print('  ${physicsFamily.length} physics types catalogued');

  final physicsWidgets = physicsFamily.map<Widget>((phys) {
    final isHighlighted = phys['name'] == 'AlwaysScrollableScrollPhysics';
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: isHighlighted
            ? (phys['color'] as Color).withOpacity(0.15)
            : (phys['color'] as Color).withOpacity(0.06),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: (phys['color'] as Color)
              .withOpacity(isHighlighted ? 0.5 : 0.2),
          width: isHighlighted ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: (phys['color'] as Color).withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(phys['icon'] as IconData,
                color: phys['color'] as Color, size: 20),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      phys['name'] as String,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: phys['color'] as Color,
                      ),
                    ),
                    if (isHighlighted) ...[
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 1),
                        decoration: BoxDecoration(
                          color: Colors.deepOrange,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'THIS DEMO',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                    if (phys['isBase'] as bool) ...[
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 1),
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'BASE',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  phys['purpose'] as String,
                  style: const TextStyle(fontSize: 11, height: 1.3),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }).toList();

  // ============================================================
  // SECTION 6: Physics Chaining — How parent Works
  // ============================================================
  print('=== Section 6: Physics Chaining ===');

  final chainingExamples = <Map<String, dynamic>>[
    {
      'code': 'const AlwaysScrollableScrollPhysics()',
      'chain': 'AlwaysScrollable → platform default',
      'description': 'Uses platform default as parent. On Android: '
          'ClampingScrollPhysics. On iOS: BouncingScrollPhysics.',
      'color': Colors.deepOrange,
    },
    {
      'code': 'const AlwaysScrollableScrollPhysics(\n'
          '  parent: BouncingScrollPhysics(),\n'
          ')',
      'chain': 'AlwaysScrollable → Bouncing',
      'description': 'Forces iOS-style bounce on all platforms while '
          'keeping always-scrollable behavior.',
      'color': Colors.blue,
    },
    {
      'code': 'const AlwaysScrollableScrollPhysics(\n'
          '  parent: ClampingScrollPhysics(),\n'
          ')',
      'chain': 'AlwaysScrollable → Clamping',
      'description': 'Forces Android-style clamping on all platforms while '
          'keeping always-scrollable behavior.',
      'color': Colors.green,
    },
    {
      'code': 'const AlwaysScrollableScrollPhysics(\n'
          '  parent: PageScrollPhysics(),\n'
          ')',
      'chain': 'AlwaysScrollable → Page snapping',
      'description': 'Page-snapping behavior that is always scrollable. '
          'Useful for carousels with few pages.',
      'color': Colors.purple,
    },
  ];

  print('  ${chainingExamples.length} chaining examples');

  final chainingWidgets = chainingExamples.map<Widget>((example) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: (example['color'] as Color).withOpacity(0.06),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: (example['color'] as Color).withOpacity(0.25),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Chain visualization
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: (example['color'] as Color).withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: [
                const Icon(Icons.link, size: 16, color: Colors.grey),
                const SizedBox(width: 6),
                Text(
                  example['chain'] as String,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: example['color'] as Color,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              example['code'] as String,
              style: const TextStyle(fontFamily: 'monospace', fontSize: 11),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            example['description'] as String,
            style: const TextStyle(fontSize: 12, height: 1.4),
          ),
        ],
      ),
    );
  }).toList();

  // ============================================================
  // SECTION 7: Platform Defaults Visual
  // ============================================================
  print('=== Section 7: Platform Defaults ===');

  // Build a visual showing what each platform does by default
  final platformData = <Map<String, dynamic>>[
    {
      'platform': 'Android',
      'icon': Icons.phone_android,
      'default': 'ClampingScrollPhysics',
      'effect': 'Overscroll glow (edge effect). Not scrollable when '
          'content fits. Need AlwaysScrollable for pull-to-refresh.',
      'color': Colors.green,
      'needsAlways': true,
    },
    {
      'platform': 'iOS',
      'icon': Icons.phone_iphone,
      'default': 'BouncingScrollPhysics',
      'effect': 'Overscroll bounce. Already always-scrollable due to '
          'bounce physics. AlwaysScrollable is redundant but harmless.',
      'color': Colors.blue,
      'needsAlways': false,
    },
    {
      'platform': 'Web',
      'icon': Icons.web,
      'default': 'ClampingScrollPhysics',
      'effect': 'Same as Android — clamping by default. Need '
          'AlwaysScrollable for refresh on short content.',
      'color': Colors.orange,
      'needsAlways': true,
    },
    {
      'platform': 'Desktop',
      'icon': Icons.desktop_mac,
      'default': 'ClampingScrollPhysics',
      'effect': 'Clamping by default. AlwaysScrollable needed if '
          'you want overscroll on short content.',
      'color': Colors.purple,
      'needsAlways': true,
    },
  ];

  print('  ${platformData.length} platforms documented');

  final platformWidgets = platformData.map<Widget>((plat) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: (plat['color'] as Color).withOpacity(0.07),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: (plat['color'] as Color).withOpacity(0.25),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: (plat['color'] as Color).withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(plat['icon'] as IconData,
                color: plat['color'] as Color, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      plat['platform'] as String,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: plat['color'] as Color,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: (plat['needsAlways'] as bool)
                            ? Colors.red.withOpacity(0.1)
                            : Colors.green.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: (plat['needsAlways'] as bool)
                              ? Colors.red
                              : Colors.green,
                          width: 0.5,
                        ),
                      ),
                      child: Text(
                        (plat['needsAlways'] as bool)
                            ? 'NEEDS ALWAYS'
                            : 'ALREADY OK',
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          color: (plat['needsAlways'] as bool)
                              ? Colors.red
                              : Colors.green,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  'Default: ${plat['default']}',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[700]),
                ),
                const SizedBox(height: 2),
                Text(
                  plat['effect'] as String,
                  style: const TextStyle(fontSize: 11, height: 1.3),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }).toList();

  // ============================================================
  // SECTION 8: Real-World Use Cases
  // ============================================================
  print('=== Section 8: Real-World Use Cases ===');

  final useCases = <Map<String, dynamic>>[
    {
      'title': 'Pull-to-Refresh Lists',
      'desc': 'Any list that might have fewer items than the screen height '
          'needs AlwaysScrollableScrollPhysics for RefreshIndicator to work.',
      'icon': Icons.refresh,
      'color': Colors.deepOrange,
    },
    {
      'title': 'Empty State with Refresh',
      'desc': 'When a list is empty (0 items), the user must still be able '
          'to pull-to-refresh to load initial data. AlwaysScrollable makes '
          'the empty view scrollable.',
      'icon': Icons.inbox,
      'color': Colors.blue,
    },
    {
      'title': 'Search Results',
      'desc': 'Search results may start empty and grow. Using '
          'AlwaysScrollableScrollPhysics ensures consistent UX whether '
          'there are 0 results or 1000.',
      'icon': Icons.search,
      'color': Colors.green,
    },
    {
      'title': 'Chat Messages',
      'desc': 'A new conversation has few messages. Pull-to-refresh loads '
          'older messages. AlwaysScrollable enables this even with 1-2 messages.',
      'icon': Icons.chat,
      'color': Colors.purple,
    },
    {
      'title': 'Dashboard Cards',
      'desc': 'A dashboard with 2-3 cards might fit the screen. Adding '
          'AlwaysScrollable provides overscroll feedback and a consistent '
          'scrolling feel.',
      'icon': Icons.dashboard,
      'color': Colors.teal,
    },
    {
      'title': 'Cross-Platform Consistency',
      'desc': 'Use AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()) '
          'to get iOS-style bounce on all platforms for a consistent UX.',
      'icon': Icons.devices,
      'color': Colors.amber[800]!,
    },
  ];

  print('  ${useCases.length} use cases');

  final useCaseWidgets = useCases.map<Widget>((uc) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: (uc['color'] as Color).withOpacity(0.06),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: (uc['color'] as Color).withOpacity(0.25),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(uc['icon'] as IconData, color: uc['color'] as Color, size: 26),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  uc['title'] as String,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: uc['color'] as Color,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  uc['desc'] as String,
                  style: const TextStyle(fontSize: 12, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }).toList();

  // ============================================================
  // SECTION 9: Common Mistakes
  // ============================================================
  print('=== Section 9: Common Mistakes ===');

  final mistakes = <Map<String, dynamic>>[
    {
      'title': 'Forgetting AlwaysScrollable with RefreshIndicator',
      'severity': 'Error',
      'sevColor': Colors.red,
      'detail': 'RefreshIndicator silently does nothing if the list can\'t '
          'scroll. This is the #1 cause of "RefreshIndicator not working" '
          'bugs. Fix: add physics: AlwaysScrollableScrollPhysics().',
      'icon': Icons.error,
    },
    {
      'title': 'Using on Nested ScrollView',
      'severity': 'Warning',
      'sevColor': Colors.orange,
      'detail': 'In a nested scroll scenario (ScrollView inside ScrollView), '
          'the inner view should use NeverScrollableScrollPhysics, not '
          'AlwaysScrollable. AlwaysScrollable on an inner view will steal '
          'scroll events.',
      'icon': Icons.warning,
    },
    {
      'title': 'Redundant on iOS',
      'severity': 'Info',
      'sevColor': Colors.blue,
      'detail': 'On iOS, BouncingScrollPhysics is already always-scrollable. '
          'Adding AlwaysScrollableScrollPhysics is redundant. Not harmful, '
          'but adds unnecessary complexity. Consider platform checks.',
      'icon': Icons.info,
    },
    {
      'title': 'Not Chaining with Desired Physics',
      'severity': 'Warning',
      'sevColor': Colors.orange,
      'detail': 'AlwaysScrollableScrollPhysics() without parent uses the '
          'platform default. If you want specific behavior (e.g., bounce), '
          'chain explicitly: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()).',
      'icon': Icons.warning,
    },
  ];

  print('  ${mistakes.length} common mistakes');

  final mistakeWidgets = mistakes.map<Widget>((m) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: (m['sevColor'] as Color).withOpacity(0.06),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: (m['sevColor'] as Color).withOpacity(0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(m['icon'] as IconData,
                  color: m['sevColor'] as Color, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  m['title'] as String,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: m['sevColor'] as Color,
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: m['sevColor'] as Color,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  m['severity'] as String,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            m['detail'] as String,
            style: const TextStyle(fontSize: 12, height: 1.4),
          ),
        ],
      ),
    );
  }).toList();

  // ============================================================
  // SECTION 10: Summary Dashboard
  // ============================================================
  print('=== Section 10: Summary Dashboard ===');

  final summaryItems = <Map<String, dynamic>>[
    {'label': 'Physics types', 'value': '${physicsFamily.length}', 'icon': Icons.category},
    {'label': 'Chaining patterns', 'value': '${chainingExamples.length}', 'icon': Icons.link},
    {'label': 'Platforms covered', 'value': '${platformData.length}', 'icon': Icons.devices},
    {'label': 'Use cases', 'value': '${useCases.length}', 'icon': Icons.lightbulb},
    {'label': 'Common mistakes', 'value': '${mistakes.length}', 'icon': Icons.warning},
    {'label': 'API properties', 'value': '${apiProps.length}', 'icon': Icons.code},
  ];

  final summaryGrid = Wrap(
    spacing: 10,
    runSpacing: 10,
    children: summaryItems.map<Widget>((item) {
      return Container(
        width: 155,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.deepOrange.withOpacity(0.12),
              Colors.deepOrange.withOpacity(0.04),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.deepOrange.withOpacity(0.2)),
        ),
        child: Column(
          children: [
            Icon(item['icon'] as IconData, color: Colors.deepOrange, size: 24),
            const SizedBox(height: 6),
            Text(
              item['value'] as String,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              item['label'] as String,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 10, color: Colors.grey[600]),
            ),
          ],
        ),
      );
    }).toList(),
  );

  // ============================================================
  // Helper: Section header
  // ============================================================
  Widget scrollSectionHeader(String number, String title, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(top: 28, bottom: 14),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.deepOrange, Colors.deepOrange[300]!],
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Icon(icon, color: Colors.white, size: 22),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  print('AlwaysScrollableScrollPhysics Deep Demo — building final layout');

  // ============================================================
  // FINAL LAYOUT
  // ============================================================
  return Scaffold(
    appBar: AppBar(
      title: const Text('AlwaysScrollableScrollPhysics'),
      backgroundColor: Colors.deepOrange,
      foregroundColor: Colors.white,
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.deepOrange, Colors.deepOrange[300]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.swap_vert, color: Colors.white, size: 40),
                const SizedBox(height: 10),
                const Text(
                  'AlwaysScrollableScrollPhysics',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'ScrollPhysics that forces a Scrollable to always be '
                  'scrollable, even when content fits the viewport — essential '
                  'for pull-to-refresh on short lists.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.9),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),

          // Sections
          scrollSectionHeader('1', 'Concept', Icons.lightbulb),
          ...conceptWidgets,

          scrollSectionHeader('2', 'API Surface', Icons.code),
          ...apiWidgets,

          scrollSectionHeader('3', 'Side-by-Side Comparison', Icons.compare),
          comparisonWidget,

          scrollSectionHeader('4', 'Pull-to-Refresh Pattern', Icons.refresh),
          Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Standard Pattern:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
                const SizedBox(height: 6),
                Text(
                  refreshDemoCode,
                  style: const TextStyle(fontFamily: 'monospace', fontSize: 11),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 200,
            child: refreshDemo,
          ),

          scrollSectionHeader('5', 'ScrollPhysics Family', Icons.category),
          ...physicsWidgets,

          scrollSectionHeader('6', 'Physics Chaining', Icons.link),
          ...chainingWidgets,

          scrollSectionHeader('7', 'Platform Defaults', Icons.devices),
          ...platformWidgets,

          scrollSectionHeader('8', 'Real-World Use Cases', Icons.lightbulb),
          ...useCaseWidgets,

          scrollSectionHeader('9', 'Common Mistakes', Icons.report_problem),
          ...mistakeWidgets,

          scrollSectionHeader('10', 'Summary Dashboard', Icons.dashboard),
          summaryGrid,
          const SizedBox(height: 30),
        ],
      ),
    ),
  );
}
