// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — SliverEnsureSemantics
// Demonstrates SliverEnsureSemantics — a sliver wrapper that forces
// its child sliver to always contribute semantics information to the
// semantics tree, even when the child would normally be excluded for
// performance. Critical for accessibility compliance.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SliverEnsureSemantics Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptItems = <Map<String, dynamic>>[
    {
      'icon': Icons.accessibility,
      'title': 'What Is SliverEnsureSemantics?',
      'body': 'SliverEnsureSemantics is a sliver wrapper that marks its '
          'child sliver as needing semantics. This guarantees the child '
          'always contributes a SemanticsNode to the semantics tree, '
          'which is the data structure screen readers consume.',
    },
    {
      'icon': Icons.visibility_off,
      'title': 'Why Slivers Skip Semantics',
      'body': 'For performance, the framework may skip building '
          'semantics nodes for slivers that are off-screen or whose '
          'semantics are considered redundant. This is normally fine, '
          'but can cause issues with assistive technologies.',
    },
    {
      'icon': Icons.hearing,
      'title': 'Screen Reader Impact',
      'body': 'When semantics are skipped, screen readers (TalkBack, '
          'VoiceOver) may not announce content correctly. '
          'SliverEnsureSemantics forces the semantics to always be '
          'present, ensuring no content is invisible to assistive tech.',
    },
    {
      'icon': Icons.shield,
      'title': 'Accessibility Guarantee',
      'body': 'Use this widget when your sliver contains content that '
          'MUST be accessible — form fields, navigation items, '
          'critical status messages, or content that users navigate '
          'to via heading or landmark accessibility shortcuts.',
    },
    {
      'icon': Icons.speed,
      'title': 'Performance Trade-off',
      'body': 'Forcing semantics has a small performance cost since '
          'extra SemanticsNode objects are created and maintained. '
          'Use it selectively — only on slivers where accessibility '
          'completeness is more important than micro-optimization.',
    },
  ];

  final conceptCards = <Widget>[];
  for (var i = 0; i < conceptItems.length; i++) {
    final item = conceptItems[i];
    print('Concept ${i + 1}: ${item['title']}');
    conceptCards.add(
      Container(
        margin: const EdgeInsets.only(bottom: 10.0),
        padding: const EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: Colors.deepPurple.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.deepPurple.withValues(alpha: 0.12)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.deepPurple.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(
                item['icon'] as IconData,
                color: Colors.deepPurple,
                size: 22.0,
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['title'] as String,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                      color: Colors.deepPurple,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    item['body'] as String,
                    style: TextStyle(
                      fontSize: 12.5,
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
  // SECTION 2: Constructor
  // ============================================================
  print('=== Section 2: Constructor ===');

  Widget buildSESParam(
    String name,
    String type,
    String desc,
    bool required,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.deepPurple.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.deepPurple.withValues(alpha: 0.12)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
            decoration: BoxDecoration(
              color: required
                  ? Colors.red.withValues(alpha: 0.1)
                  : Colors.green.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              required ? 'REQUIRED' : 'OPTIONAL',
              style: TextStyle(
                fontSize: 9.0,
                fontWeight: FontWeight.bold,
                color: required ? Colors.red : Colors.green.shade700,
              ),
            ),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13.5,
                        color: Colors.deepPurple,
                        fontFamily: 'monospace',
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6.0,
                        vertical: 2.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(3.0),
                      ),
                      child: Text(
                        type,
                        style: TextStyle(
                          fontSize: 10.5,
                          fontFamily: 'monospace',
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4.0),
                Text(
                  desc,
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.grey.shade700,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final constructorWidgets = [
    buildSESParam(
      'sliver',
      'Widget',
      'The child sliver whose semantics should always be present. '
          'Any sliver widget (SliverList, SliverGrid, SliverToBoxAdapter, etc.) '
          'can be wrapped.',
      true,
    ),
    buildSESParam(
      'key',
      'Key?',
      'An optional key for this widget in the element tree.',
      false,
    ),
  ];

  // Code sample
  final constructorCode = Container(
    margin: const EdgeInsets.only(top: 12.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '// Ensure a SliverList always has semantics:',
          style: TextStyle(
            fontSize: 11.5,
            fontFamily: 'monospace',
            color: Colors.green,
          ),
        ),
        SizedBox(height: 2.0),
        Text(
          'SliverEnsureSemantics(\n'
          '  sliver: SliverList(\n'
          '    delegate: SliverChildBuilderDelegate(\n'
          '      (context, index) => ListTile(\n'
          '        title: Text(\'Item \$index\'),\n'
          '      ),\n'
          '      childCount: 20,\n'
          '    ),\n'
          '  ),\n'
          ')',
          style: TextStyle(
            fontSize: 11.5,
            fontFamily: 'monospace',
            color: Colors.white70,
            height: 1.4,
          ),
        ),
      ],
    ),
  );

  // Class hierarchy
  final hierarchyCard = Container(
    margin: const EdgeInsets.only(top: 12.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.deepPurple.withValues(alpha: 0.03),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Colors.deepPurple.withValues(alpha: 0.1)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Class Hierarchy',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13.0,
            color: Colors.deepPurple,
          ),
        ),
        const SizedBox(height: 8.0),
        ...['Widget', '  └─ ProxyWidget',
            '      └─ SingleChildRenderObjectWidget',
            '          └─ SliverEnsureSemantics']
            .map((line) => Padding(
              padding: const EdgeInsets.only(bottom: 2.0),
              child: Text(
                line,
                style: TextStyle(
                  fontSize: 11.5,
                  fontFamily: 'monospace',
                  color: line.contains('SliverEnsureSemantics')
                      ? Colors.deepPurple
                      : Colors.grey.shade700,
                  fontWeight: line.contains('SliverEnsureSemantics')
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
            )),
        const SizedBox(height: 6.0),
        Text(
          'A SingleChildRenderObjectWidget — it wraps exactly one sliver '
          'child and modifies how its render object participates in the '
          'semantics tree.',
          style: TextStyle(
            fontSize: 11.0,
            color: Colors.grey.shade600,
            height: 1.3,
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: Default Behavior
  // ============================================================
  print('=== Section 3: Default Behavior ===');

  // Visual explanation of default semantics behavior
  Widget buildSESDiagramRow(String label, String detail, IconData icon, Color color,
      {bool highlighted = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: highlighted
            ? color.withValues(alpha: 0.1)
            : color.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(
          color: color.withValues(alpha: highlighted ? 0.3 : 0.1),
          width: highlighted ? 1.5 : 1.0,
        ),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18.0, color: color),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                Text(
                  detail,
                  style: TextStyle(
                    fontSize: 11.0,
                    color: Colors.grey.shade600,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final defaultBehaviorRows = <Widget>[
    buildSESDiagramRow(
      'Visible Sliver',
      'On-screen slivers have semantics built normally by the framework',
      Icons.visibility,
      Colors.green,
    ),
    buildSESDiagramRow(
      'Partially Visible Sliver',
      'Slivers partially in the viewport usually have semantics',
      Icons.visibility,
      Colors.orange,
    ),
    buildSESDiagramRow(
      'Off-Screen Sliver',
      'Slivers scrolled out of view may have their semantics dropped to save memory',
      Icons.visibility_off,
      Colors.red,
      highlighted: true,
    ),
    buildSESDiagramRow(
      'Cached Sliver',
      'Slivers in the cache extent may or may not have semantics depending on configuration',
      Icons.cached,
      Colors.amber,
    ),
  ];

  // Without vs With comparison
  Widget buildSESComparison(
    String title,
    List<String> items,
    IconData icon,
    Color color,
    bool good,
  ) {
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: color.withValues(alpha: 0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20.0, color: color),
              const SizedBox(width: 8.0),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                  color: color,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                decoration: BoxDecoration(
                  color: (good ? Colors.green : Colors.red).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  good ? 'GOOD' : 'RISKY',
                  style: TextStyle(
                    fontSize: 9.0,
                    fontWeight: FontWeight.bold,
                    color: good ? Colors.green : Colors.red,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          ...items.map((item) => Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  good ? Icons.check : Icons.close,
                  size: 14.0,
                  color: good ? Colors.green : Colors.red,
                ),
                const SizedBox(width: 6.0),
                Expanded(
                  child: Text(
                    item,
                    style: TextStyle(
                      fontSize: 11.5,
                      color: Colors.grey.shade700,
                      height: 1.3,
                    ),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  final withoutEnsure = buildSESComparison(
    'Without SliverEnsureSemantics',
    [
      'Off-screen items may lose semantics',
      'Screen readers may skip content',
      'Heading navigation may be incomplete',
      'Better performance (fewer SemanticsNode objects)',
    ],
    Icons.warning_amber,
    Colors.orange,
    false,
  );

  final withEnsure = buildSESComparison(
    'With SliverEnsureSemantics',
    [
      'All child items always have semantics',
      'Screen readers see all content',
      'Heading navigation works completely',
      'Slightly more memory for SemanticsNode objects',
    ],
    Icons.verified,
    Colors.green,
    true,
  );

  // ============================================================
  // SECTION 4: Forced Semantics
  // ============================================================
  print('=== Section 4: Forced Semantics ===');

  // Live slivers with and without wrapper
  final forcedSemanticsDemo = SizedBox(
    height: 300.0,
    child: Row(
      children: [
        // Without wrapper
        Expanded(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                color: Colors.red.withValues(alpha: 0.1),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.close, size: 14.0, color: Colors.red),
                    SizedBox(width: 4.0),
                    Text(
                      'Without Wrapper',
                      style: TextStyle(
                        fontSize: 11.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (ctx, index) => Container(
                          margin: const EdgeInsets.all(3.0),
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Colors.red.withValues(alpha: 0.05),
                            borderRadius: BorderRadius.circular(4.0),
                            border: Border.all(
                              color: Colors.red.withValues(alpha: 0.15),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 24.0,
                                height: 24.0,
                                decoration: BoxDecoration(
                                  color: Colors.red.withValues(alpha: 0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    '${index + 1}',
                                    style: const TextStyle(
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8.0),
                              Expanded(
                                child: Text(
                                  'Item ${index + 1}',
                                  style: TextStyle(
                                    fontSize: 11.0,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.accessibility_new,
                                size: 14.0,
                                color: Colors.grey.shade400,
                              ),
                            ],
                          ),
                        ),
                        childCount: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 1.0,
          color: Colors.grey.shade300,
        ),
        // With wrapper
        Expanded(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                color: Colors.green.withValues(alpha: 0.1),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check, size: 14.0, color: Colors.green),
                    SizedBox(width: 4.0),
                    Text(
                      'With Wrapper',
                      style: TextStyle(
                        fontSize: 11.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    SliverEnsureSemantics(
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (ctx, index) => Container(
                            margin: const EdgeInsets.all(3.0),
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: Colors.green.withValues(alpha: 0.05),
                              borderRadius: BorderRadius.circular(4.0),
                              border: Border.all(
                                color: Colors.green.withValues(alpha: 0.15),
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 24.0,
                                  height: 24.0,
                                  decoration: BoxDecoration(
                                    color: Colors.green.withValues(alpha: 0.1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${index + 1}',
                                      style: const TextStyle(
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8.0),
                                Expanded(
                                  child: Text(
                                    'Item ${index + 1}',
                                    style: TextStyle(
                                      fontSize: 11.0,
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                ),
                                const Icon(
                                  Icons.accessibility_new,
                                  size: 14.0,
                                  color: Colors.green,
                                ),
                              ],
                            ),
                          ),
                          childCount: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 5: Live Demo
  // ============================================================
  print('=== Section 5: Live Demo ===');

  final liveWidget = _SESLiveDemo();

  // ============================================================
  // SECTION 6: Accessibility
  // ============================================================
  print('=== Section 6: Accessibility ===');

  final a11yCards = <Map<String, dynamic>>[
    {
      'icon': Icons.record_voice_over,
      'title': 'Screen Reader Completeness',
      'body': 'With SliverEnsureSemantics, all items in a SliverList are '
          'announced by the screen reader — even those far from the '
          'current scroll position. Without it, some items may be skipped.',
      'color': Colors.blue,
    },
    {
      'icon': Icons.format_list_numbered,
      'title': 'Heading Navigation',
      'body': 'iOS VoiceOver and Android TalkBack let users navigate by '
          'headings. If a sliver contains heading semantics and loses its '
          'SemanticsNode when off-screen, that heading becomes invisible '
          'to assistive navigation.',
      'color': Colors.teal,
    },
    {
      'icon': Icons.touch_app,
      'title': 'Focus Traversal',
      'body': 'When accessibility focus moves past the visible area, the '
          'framework scrolls to bring the focused element into view. '
          'Ensuring semantics helps this process work reliably for all '
          'child elements.',
      'color': Colors.orange,
    },
    {
      'icon': Icons.flag,
      'title': 'Semantic Landmarks',
      'body': 'If your sliver contains elements marked as live regions, '
          'alert dialogs, or important status text, wrapping with '
          'SliverEnsureSemantics prevents those from being pruned.',
      'color': Colors.purple,
    },
    {
      'icon': Icons.developer_mode,
      'title': 'Testing with SemanticsDebugger',
      'body': 'Wrap your MaterialApp with SemanticsDebugger to see the '
          'semantics tree visually. Compare the tree with and without '
          'SliverEnsureSemantics to see the difference.',
      'color': Colors.indigo,
    },
  ];

  final a11yWidgets = <Widget>[];
  for (var i = 0; i < a11yCards.length; i++) {
    final card = a11yCards[i];
    final color = card['color'] as Color;
    a11yWidgets.add(
      Container(
        margin: const EdgeInsets.only(bottom: 10.0),
        padding: const EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: color.withValues(alpha: 0.12)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(
                card['icon'] as IconData,
                color: color,
                size: 20.0,
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    card['title'] as String,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13.5,
                      color: color,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    card['body'] as String,
                    style: TextStyle(
                      fontSize: 12.0,
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
  // SECTION 7: Patterns
  // ============================================================
  print('=== Section 7: Patterns ===');

  Widget buildSESPattern(
    String title,
    String description,
    String code,
    IconData icon,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: color.withValues(alpha: 0.12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20.0, color: color),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13.0,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6.0),
          Text(
            description,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.grey.shade700,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 8.0),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Text(
              code,
              style: const TextStyle(
                fontSize: 10.5,
                fontFamily: 'monospace',
                color: Colors.white70,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  final patterns = [
    buildSESPattern(
      'SliverList with Ensured Semantics',
      'Wrap a SliverList to guarantee all list items are '
          'always available to screen readers.',
      'SliverEnsureSemantics(\n'
      '  sliver: SliverList.builder(\n'
      '    itemCount: items.length,\n'
      '    itemBuilder: (ctx, i) => ListTile(...),\n'
      '  ),\n'
      ')',
      Icons.list,
      Colors.blue,
    ),
    buildSESPattern(
      'SliverGrid with Ensured Semantics',
      'Grids benefit similarly — all grid items are semantically '
          'present even when scrolled far away.',
      'SliverEnsureSemantics(\n'
      '  sliver: SliverGrid.count(\n'
      '    crossAxisCount: 2,\n'
      '    children: gridItems,\n'
      '  ),\n'
      ')',
      Icons.grid_view,
      Colors.teal,
    ),
    buildSESPattern(
      'SliverToBoxAdapter with Ensured Semantics',
      'Wrap a SliverToBoxAdapter containing a heading or landmark '
          'to ensure it is always accessible.',
      'SliverEnsureSemantics(\n'
      '  sliver: SliverToBoxAdapter(\n'
      '    child: Semantics(\n'
      '      header: true,\n'
      '      child: Text("Section Title"),\n'
      '    ),\n'
      '  ),\n'
      ')',
      Icons.title,
      Colors.orange,
    ),
    buildSESPattern(
      'Multiple Wrapped Slivers',
      'In a CustomScrollView, wrap only the slivers that need '
          'guaranteed semantics — no need to wrap everything.',
      'CustomScrollView(\n'
      '  slivers: [\n'
      '    sliverAppBar,  // no wrapper needed\n'
      '    SliverEnsureSemantics(\n'
      '      sliver: navSliver,  // critical nav\n'
      '    ),\n'
      '    contentSliver,  // optional\n'
      '  ],\n'
      ')',
      Icons.layers,
      Colors.purple,
    ),
    buildSESPattern(
      'Conditional Wrapping',
      'Conditionally wrap based on platform or accessibility settings '
          'to optimize performance when not needed.',
      'final sliver = needsSemantics\n'
      '  ? SliverEnsureSemantics(sliver: mySliver)\n'
      '  : mySliver;',
      Icons.toggle_on,
      Colors.deepOrange,
    ),
  ];

  // ============================================================
  // SECTION 8: Summary
  // ============================================================
  print('=== Section 8: Summary ===');

  Widget buildSESBullet(IconData icon, String text, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16.0, color: color),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.grey.shade700,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  final summaryBullets = [
    buildSESBullet(
      Icons.check_circle_outline,
      'SliverEnsureSemantics wraps a single sliver child and forces '
          'it to always contribute to the semantics tree.',
      Colors.green,
    ),
    buildSESBullet(
      Icons.check_circle_outline,
      'Without it, slivers may have their semantics dropped when '
          'off-screen, making content invisible to screen readers.',
      Colors.green,
    ),
    buildSESBullet(
      Icons.check_circle_outline,
      'Essential for slivers containing headings, navigation, '
          'landmarks, or any accessibility-critical content.',
      Colors.green,
    ),
    buildSESBullet(
      Icons.check_circle_outline,
      'Zero configuration — just wrap any sliver and it ensures '
          'semantics. No parameters to tune.',
      Colors.green,
    ),
    buildSESBullet(
      Icons.warning_amber,
      'Slight performance cost: extra SemanticsNode objects are '
          'created for off-screen content. Use selectively.',
      Colors.orange,
    ),
    buildSESBullet(
      Icons.warning_amber,
      'Not a substitute for proper Semantics widgets on child '
          'elements — those must still declare their roles and labels.',
      Colors.orange,
    ),
    buildSESBullet(
      Icons.info_outline,
      'Works with all sliver types: SliverList, SliverGrid, '
          'SliverToBoxAdapter, SliverFixedExtentList, etc.',
      Colors.blue,
    ),
    buildSESBullet(
      Icons.info_outline,
      'Use SemanticsDebugger widget to visualize the semantics tree '
          'and verify your wrapping strategy.',
      Colors.blue,
    ),
  ];

  // ============================================================
  // ASSEMBLE TABBED LAYOUT
  // ============================================================
  print('=== Assembling tabbed layout ===');

  return DefaultTabController(
    length: 8,
    child: Scaffold(
      appBar: AppBar(
        title: const Text('SliverEnsureSemantics Deep Demo'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 2.0,
        bottom: const TabBar(
          isScrollable: true,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          labelStyle: TextStyle(fontSize: 11.5, fontWeight: FontWeight.bold),
          unselectedLabelStyle: TextStyle(fontSize: 11.0),
          tabs: [
            Tab(text: 'Concept'),
            Tab(text: 'Constructor'),
            Tab(text: 'Default'),
            Tab(text: 'Forced'),
            Tab(text: 'Live Demo'),
            Tab(text: 'Accessibility'),
            Tab(text: 'Patterns'),
            Tab(text: 'Summary'),
          ],
        ),
      ),
      body: TabBarView(
        children: [
          // ===== TAB 1: Concept =====
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.deepPurple.withValues(alpha: 0.12),
                        Colors.deepPurple.withValues(alpha: 0.04),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(
                      color: Colors.deepPurple.withValues(alpha: 0.15),
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.accessibility,
                          color: Colors.deepPurple,
                          size: 32.0,
                        ),
                      ),
                      const SizedBox(height: 12.0),
                      const Text(
                        'SliverEnsureSemantics',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                      const SizedBox(height: 6.0),
                      Text(
                        'Guarantee semantics are always present for '
                        'accessible sliver content.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13.0,
                          color: Colors.grey.shade600,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                ...conceptCards,
                const SizedBox(height: 12.0),
                // Semantics tree diagram
                Container(
                  padding: const EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.withValues(alpha: 0.03),
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: Colors.deepPurple.withValues(alpha: 0.1),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.account_tree, color: Colors.deepPurple, size: 18.0),
                          SizedBox(width: 8.0),
                          Text(
                            'How the Semantics Tree Works',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13.0,
                              color: Colors.deepPurple,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'Flutter maintains two trees: the RenderObject tree (visual) '
                        'and the Semantics tree (accessibility). Screen readers only '
                        'see the Semantics tree. SliverEnsureSemantics ensures your '
                        'sliver\'s content is always in the Semantics tree.',
                        style: TextStyle(
                          fontSize: 11.5,
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

          // ===== TAB 2: Constructor =====
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      const Icon(Icons.build_circle, color: Colors.deepPurple, size: 28.0),
                      const SizedBox(height: 8.0),
                      const Text(
                        'Constructor',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        'A minimal wrapper — accepts only a sliver child.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                ...constructorWidgets,
                constructorCode,
                hierarchyCard,
              ],
            ),
          ),

          // ===== TAB 3: Default Behavior =====
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      const Icon(Icons.tune, color: Colors.deepPurple, size: 28.0),
                      const SizedBox(height: 8.0),
                      const Text(
                        'Default Semantics Behavior',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        'How slivers handle semantics without explicit wrapping.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'Semantics by Visibility:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                    color: Colors.deepPurple,
                  ),
                ),
                const SizedBox(height: 10.0),
                ...defaultBehaviorRows,
                const SizedBox(height: 16.0),
                withoutEnsure,
                const SizedBox(height: 12.0),
                withEnsure,
              ],
            ),
          ),

          // ===== TAB 4: Forced Semantics =====
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      const Icon(Icons.verified, color: Colors.deepPurple, size: 28.0),
                      const SizedBox(height: 8.0),
                      const Text(
                        'Forced Semantics in Action',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        'Side-by-side: same SliverList, one without and one with wrapper.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: Colors.deepPurple.withValues(alpha: 0.2),
                    ),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: forcedSemanticsDemo,
                ),
                const SizedBox(height: 12.0),
                Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Colors.amber.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      color: Colors.amber.withValues(alpha: 0.15),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.info_outline, size: 16.0, color: Colors.amber),
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: Text(
                          'Both lists have 15 items and scroll identically. '
                          'The difference is in the semantics tree: the right '
                          'list (wrapped) ensures all 15 items are always '
                          'announced by assistive technology.',
                          style: TextStyle(
                            fontSize: 11.5,
                            color: Colors.grey.shade600,
                            height: 1.3,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                // Visual semantics tree comparison
                Row(
                  children: [
                    Expanded(
                      child: _buildMiniTree(
                        'Without Wrapper',
                        ['SemanticsNode (root)', '  ├─ Item 1 ✓', '  ├─ Item 2 ✓',
                         '  ├─ Item 3 ✓', '  ├─ …', '  ├─ Item 10 ⚠',
                         '  └─ Items 11-15 ✗'],
                        Colors.red,
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: _buildMiniTree(
                        'With Wrapper',
                        ['SemanticsNode (root)', '  ├─ Item 1 ✓', '  ├─ Item 2 ✓',
                         '  ├─ Item 3 ✓', '  ├─ …', '  ├─ Item 10 ✓',
                         '  └─ Items 11-15 ✓'],
                        Colors.green,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // ===== TAB 5: Live Demo =====
          liveWidget,

          // ===== TAB 6: Accessibility =====
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      const Icon(Icons.accessibility_new, color: Colors.deepPurple, size: 28.0),
                      const SizedBox(height: 8.0),
                      const Text(
                        'Accessibility Benefits',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        'How SliverEnsureSemantics improves the experience '
                        'for users of assistive technology.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                ...a11yWidgets,
              ],
            ),
          ),

          // ===== TAB 7: Patterns =====
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      const Icon(Icons.pattern, color: Colors.deepPurple, size: 28.0),
                      const SizedBox(height: 8.0),
                      const Text(
                        'Common Patterns',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        'Practical usage patterns for wrapping various sliver types.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                ...patterns,
              ],
            ),
          ),

          // ===== TAB 8: Summary =====
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.deepPurple.withValues(alpha: 0.12),
                        Colors.deepPurple.withValues(alpha: 0.04),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(
                      color: Colors.deepPurple.withValues(alpha: 0.15),
                    ),
                  ),
                  child: Column(
                    children: [
                      const Icon(Icons.check_circle, color: Colors.deepPurple, size: 32.0),
                      const SizedBox(height: 10.0),
                      const Text(
                        'Summary',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                      const SizedBox(height: 6.0),
                      Text(
                        'Key takeaways for SliverEnsureSemantics',
                        style: TextStyle(
                          fontSize: 13.0,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                ...summaryBullets,
                const SizedBox(height: 16.0),
                // Quick reference
                Container(
                  padding: const EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.withValues(alpha: 0.04),
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: Colors.deepPurple.withValues(alpha: 0.12),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Quick Reference',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                          color: Colors.deepPurple,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      _buildSESRefItem('Type', 'SingleChildRenderObjectWidget (sliver)'),
                      _buildSESRefItem('Key param', 'sliver (single child)'),
                      _buildSESRefItem('Purpose', 'Force semantics tree inclusion'),
                      _buildSESRefItem('Effect', 'Child SemanticsNode always present'),
                      _buildSESRefItem('Use when', 'Accessibility-critical sliver content'),
                      _buildSESRefItem('Cost', 'Minor (extra SemanticsNode objects)'),
                      _buildSESRefItem('Testing', 'SemanticsDebugger widget'),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 10.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: const Text(
                      'SliverEnsureSemantics — Accessibility you can guarantee.',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
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

// ================================================================
// LIVE DEMO (Interactive)
// ================================================================

class _SESLiveDemo extends StatefulWidget {
  @override
  State<_SESLiveDemo> createState() => _SESLiveDemoState();
}

class _SESLiveDemoState extends State<_SESLiveDemo> {
  bool _useEnsureSemantics = true;
  int _itemCount = 10;
  bool _showLabels = true;

  @override
  Widget build(BuildContext context) {
    print('Live demo: ensured=$_useEnsureSemantics, items=$_itemCount');

    // Build the inner sliver
    Widget innerSliver = SliverList(
      delegate: SliverChildBuilderDelegate(
        (ctx, index) => Semantics(
          label: 'Demo item ${index + 1}',
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: _useEnsureSemantics
                  ? Colors.green.withValues(alpha: 0.06)
                  : Colors.orange.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: (_useEnsureSemantics ? Colors.green : Colors.orange)
                    .withValues(alpha: 0.2),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 32.0,
                  height: 32.0,
                  decoration: BoxDecoration(
                    color: (_useEnsureSemantics ? Colors.green : Colors.orange)
                        .withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: _useEnsureSemantics ? Colors.green : Colors.orange,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'List Item ${index + 1}',
                        style: TextStyle(
                          fontSize: 13.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade800,
                        ),
                      ),
                      if (_showLabels)
                        Text(
                          'Semantic label: "Demo item ${index + 1}"',
                          style: TextStyle(
                            fontSize: 10.0,
                            fontStyle: FontStyle.italic,
                            color: Colors.grey.shade500,
                          ),
                        ),
                    ],
                  ),
                ),
                Icon(
                  _useEnsureSemantics
                      ? Icons.accessibility_new
                      : Icons.accessibility,
                  size: 18.0,
                  color: (_useEnsureSemantics ? Colors.green : Colors.orange)
                      .withValues(alpha: 0.5),
                ),
              ],
            ),
          ),
        ),
        childCount: _itemCount,
      ),
    );

    // Optionally wrap
    Widget sliverContent = _useEnsureSemantics
        ? SliverEnsureSemantics(sliver: innerSliver)
        : innerSliver;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Controls
          Container(
            padding: const EdgeInsets.all(14.0),
            decoration: BoxDecoration(
              color: Colors.deepPurple.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: Colors.deepPurple.withValues(alpha: 0.12),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Interactive Controls',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                    color: Colors.deepPurple,
                  ),
                ),
                const SizedBox(height: 10.0),
                // Toggle wrapper
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Use SliverEnsureSemantics:',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                    Switch(
                      value: _useEnsureSemantics,
                      activeColor: Colors.deepPurple,
                      onChanged: (v) => setState(() => _useEnsureSemantics = v),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 3.0,
                      ),
                      decoration: BoxDecoration(
                        color: (_useEnsureSemantics ? Colors.green : Colors.orange)
                            .withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        _useEnsureSemantics ? 'ON' : 'OFF',
                        style: TextStyle(
                          fontSize: 10.0,
                          fontWeight: FontWeight.bold,
                          color: _useEnsureSemantics ? Colors.green : Colors.orange,
                        ),
                      ),
                    ),
                  ],
                ),
                // Item count
                Row(
                  children: [
                    SizedBox(
                      width: 90.0,
                      child: Text(
                        'Items:',
                        style: TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Slider(
                        value: _itemCount.toDouble(),
                        min: 3.0,
                        max: 25.0,
                        divisions: 22,
                        activeColor: Colors.deepPurple,
                        label: '$_itemCount',
                        onChanged: (v) =>
                            setState(() => _itemCount = v.toInt()),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 3.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        '$_itemCount',
                        style: const TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                  ],
                ),
                // Show labels
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Show semantic labels:',
                        style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700),
                      ),
                    ),
                    Switch(
                      value: _showLabels,
                      activeColor: Colors.deepPurple,
                      onChanged: (v) => setState(() => _showLabels = v),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12.0),
          // Status bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: (_useEnsureSemantics ? Colors.green : Colors.orange)
                  .withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: (_useEnsureSemantics ? Colors.green : Colors.orange)
                    .withValues(alpha: 0.15),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  _useEnsureSemantics ? Icons.verified : Icons.warning_amber,
                  size: 16.0,
                  color: _useEnsureSemantics ? Colors.green : Colors.orange,
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    _useEnsureSemantics
                        ? 'All $_itemCount items will have semantics nodes — '
                            'screen readers can announce every item.'
                        : '$_itemCount items — off-screen items may lose '
                            'semantics. Screen readers might skip them.',
                    style: TextStyle(
                      fontSize: 11.0,
                      color: _useEnsureSemantics
                          ? Colors.green.shade700
                          : Colors.orange.shade700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12.0),
          // Scrollable list
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: Colors.deepPurple.withValues(alpha: 0.2),
                ),
              ),
              clipBehavior: Clip.antiAlias,
              child: CustomScrollView(
                slivers: [sliverContent],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ================================================================
// HELPER FUNCTIONS
// ================================================================

Widget _buildMiniTree(String title, List<String> lines, Color color) {
  return Container(
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.04),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.withValues(alpha: 0.15)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 11.0,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 6.0),
        ...lines.map((line) => Text(
          line,
          style: TextStyle(
            fontSize: 9.5,
            fontFamily: 'monospace',
            color: Colors.grey.shade700,
            height: 1.4,
          ),
        )),
      ],
    ),
  );
}

Widget _buildSESRefItem(String label, String value) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 90.0,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade700,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: 11.5, color: Colors.grey.shade600),
          ),
        ),
      ],
    ),
  );
}
