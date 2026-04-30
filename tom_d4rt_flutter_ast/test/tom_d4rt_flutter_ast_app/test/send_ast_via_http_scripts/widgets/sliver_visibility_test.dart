// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — SliverVisibility
// Demonstrates the SliverVisibility widget which controls whether a sliver
// is visible while optionally maintaining state, animation, size, semantics,
// and interactivity. Shows the difference between hiding a sliver completely
// vs keeping its state alive in the background.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SliverVisibility Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptItems = <Map<String, dynamic>>[
    {
      'icon': Icons.visibility,
      'title': 'What is SliverVisibility?',
      'body': 'SliverVisibility is the sliver equivalent of the Visibility '
          'widget. It controls whether a sliver child is visible, while '
          'optionally keeping its state, animation, layout, semantics, '
          'and interactivity alive in the background.',
      'accent': Colors.cyan,
    },
    {
      'icon': Icons.memory,
      'title': 'Why Maintain State?',
      'body': 'When you conditionally remove a sliver from a CustomScrollView '
          'with an if-statement, its entire widget subtree is destroyed. '
          'SliverVisibility with maintainState: true keeps the sliver\'s '
          'state object alive even when hidden.',
      'accent': Colors.deepPurple,
    },
    {
      'icon': Icons.layers,
      'title': 'Maintain Size',
      'body': 'With maintainSize: true, the hidden sliver still occupies '
          'its full layout space. Other slivers do not shift when it is '
          'toggled. This prevents jarring layout jumps when showing/hiding '
          'sections dynamically.',
      'accent': Colors.teal,
    },
    {
      'icon': Icons.swap_horiz,
      'title': 'Replacement Sliver',
      'body': 'When visible is false and maintainSize is false, the sliver '
          'is replaced by replacementSliver (defaults to a zero-extent '
          'SliverToBoxAdapter). You can provide a custom replacement for '
          'placeholder content.',
      'accent': Colors.orange,
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
  // SECTION 2: Constructor / Properties
  // ============================================================
  print('=== Section 2: Properties ===');

  final propRows = <Map<String, String>>[
    {
      'param': 'visible',
      'type': 'bool',
      'default': 'true',
      'desc': 'Whether the sliver child is visible. When false, the sliver '
          'is hidden according to the maintain* flags.',
    },
    {
      'param': 'maintainState',
      'type': 'bool',
      'default': 'false',
      'desc': 'Keep the sliver\'s State object alive while hidden. If false, '
          'the sliver is completely removed from the tree when not visible.',
    },
    {
      'param': 'maintainAnimation',
      'type': 'bool',
      'default': 'false',
      'desc': 'Keep animations ticking while hidden. Requires maintainState. '
          'Animations resume from current position when shown again.',
    },
    {
      'param': 'maintainSize',
      'type': 'bool',
      'default': 'false',
      'desc': 'Keep the layout space occupied. The sliver is invisible but '
          'still takes up room. Requires maintainAnimation.',
    },
    {
      'param': 'maintainSemantics',
      'type': 'bool',
      'default': 'false',
      'desc': 'Keep the semantic information available to screen readers '
          'while the sliver is hidden. Requires maintainSize.',
    },
    {
      'param': 'maintainInteractivity',
      'type': 'bool',
      'default': 'false',
      'desc': 'Keep the sliver responsive to hit testing while hidden. '
          'Users can tap an invisible sliver. Requires maintainSemantics.',
    },
    {
      'param': 'sliver',
      'type': 'Widget',
      'default': '—',
      'desc': 'The sliver child to show or hide.',
    },
    {
      'param': 'replacementSliver',
      'type': 'Widget',
      'default': 'SliverToBoxAdapter()',
      'desc': 'Shown when visible is false and maintainSize is false. '
          'Defaults to a zero-size sliver.',
    },
  ];

  final propWidgets = <Widget>[];
  for (var i = 0; i < propRows.length; i++) {
    final row = propRows[i];
    print('Prop ${i + 1}: ${row['param']}');
    propWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: i.isEven
              ? Colors.cyan.withOpacity(0.05)
              : Colors.grey.withOpacity(0.03),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.cyan.withOpacity(0.15)),
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
                    color: Colors.cyan.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    row['param']!,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 14,
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
                    row['type']!,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                if (row['default'] != '—')
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.cyan.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'default: ${row['default']}',
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 10,
                        color: Colors.cyan,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              row['desc']!,
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
  // SECTION 3: Basic Toggle Demo
  // ============================================================
  print('=== Section 3: Basic Toggle ===');

  // Static demo showing the concept of toggling sliver visibility
  final basicSections = <Map<String, dynamic>>[
    {
      'title': 'Section A — Always Visible',
      'color': Colors.cyan,
      'items': ['Item A-1', 'Item A-2', 'Item A-3'],
    },
    {
      'title': 'Section B — Can Be Hidden',
      'color': Colors.orange,
      'items': ['Item B-1', 'Item B-2', 'Item B-3', 'Item B-4'],
    },
    {
      'title': 'Section C — Always Visible',
      'color': Colors.green,
      'items': ['Item C-1', 'Item C-2'],
    },
  ];

  final basicDemo = SizedBox(
    height: 380,
    child: CustomScrollView(
      slivers: <Widget>[
        // Section A — always visible
        SliverToBoxAdapter(
          child: Container(
            padding: const EdgeInsets.all(12),
            color: Colors.cyan.shade600,
            child: const Text(
              'Section A — Always Visible',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext ctx, int index) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.cyan.shade100,
                  child: Text('A${index + 1}'),
                ),
                title: Text(basicSections[0]['items'][index] as String),
              );
            },
            childCount:
                (basicSections[0]['items'] as List<String>).length,
          ),
        ),

        // Section B — wrapped in SliverVisibility
        SliverVisibility(
          visible: true, // In a real app this would be a state variable
          sliver: SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(12),
              color: Colors.orange.shade600,
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Section B — SliverVisibility(visible: true)',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'VISIBLE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SliverVisibility(
          visible: true,
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext ctx, int index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.orange.shade100,
                    child: Text('B${index + 1}'),
                  ),
                  title: Text(basicSections[1]['items'][index] as String),
                );
              },
              childCount:
                  (basicSections[1]['items'] as List<String>).length,
            ),
          ),
        ),

        // Section C — always visible
        SliverToBoxAdapter(
          child: Container(
            padding: const EdgeInsets.all(12),
            color: Colors.green.shade600,
            child: const Text(
              'Section C — Always Visible',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext ctx, int index) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.green.shade100,
                  child: Text('C${index + 1}'),
                ),
                title: Text(basicSections[2]['items'][index] as String),
              );
            },
            childCount:
                (basicSections[2]['items'] as List<String>).length,
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 4: State Preservation
  // ============================================================
  print('=== Section 4: State Preservation ===');

  final stateModes = <Map<String, dynamic>>[
    {
      'title': 'No maintain flags',
      'code': 'SliverVisibility(\n  visible: false,\n  sliver: child,\n)',
      'behavior': 'Sliver is completely removed. State is destroyed. '
          'When shown again, the widget rebuilds from scratch. Counters '
          'reset, scroll positions lost, animation states gone.',
      'icon': Icons.delete_outline,
      'color': Colors.red,
    },
    {
      'title': 'maintainState: true',
      'code': 'SliverVisibility(\n  visible: false,\n  maintainState: true,\n  sliver: child,\n)',
      'behavior': 'State object remains alive. The widget is not rebuilt '
          'when toggled back. Counters, text fields, and other stateful '
          'data persist. The sliver takes no layout space.',
      'icon': Icons.save,
      'color': Colors.orange,
    },
    {
      'title': 'maintainAnimation: true',
      'code': 'SliverVisibility(\n  visible: false,\n  maintainState: true,\n  maintainAnimation: true,\n  sliver: child,\n)',
      'behavior': 'Animation controllers keep ticking. When shown again, '
          'the animation is at the correct frame, not restarted. Useful '
          'for progress indicators and looping animations.',
      'icon': Icons.animation,
      'color': Colors.purple,
    },
    {
      'title': 'maintainSize: true',
      'code': 'SliverVisibility(\n  visible: false,\n  maintainState: true,\n  maintainAnimation: true,\n  maintainSize: true,\n  sliver: child,\n)',
      'behavior': 'The sliver remains in layout, occupying full space. '
          'Other slivers do not shift. Content is just invisible. No '
          'layout jumps when toggling visibility.',
      'icon': Icons.aspect_ratio,
      'color': Colors.teal,
    },
  ];

  final stateCards = <Widget>[];
  for (var i = 0; i < stateModes.length; i++) {
    final sm = stateModes[i];
    final sColor = sm['color'] as Color;
    print('State mode ${i + 1}: ${sm['title']}');
    stateCards.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: sColor.withOpacity(0.04),
          border: Border.all(color: sColor.withOpacity(0.25)),
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
                      color: sColor.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      sm['icon'] as IconData,
                      color: sColor,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      sm['title'] as String,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: sColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: sColor.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  sm['code'] as String,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11,
                    color: sColor,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                sm['behavior'] as String,
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
  // SECTION 5: Replacement Sliver
  // ============================================================
  print('=== Section 5: Replacement ===');

  // Show what happens when a replacement sliver is used
  final replacementDemo = SizedBox(
    height: 350,
    child: CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: Container(
            padding: const EdgeInsets.all(12),
            color: Colors.cyan.shade600,
            child: const Text(
              'Visible Section',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext ctx, int index) {
              return ListTile(
                leading: const Icon(Icons.check_circle, color: Colors.cyan),
                title: Text('Visible item ${index + 1}'),
              );
            },
            childCount: 3,
          ),
        ),

        // Hidden section with custom replacement
        SliverVisibility(
          visible: false,
          replacementSliver: SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.08),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.orange.withOpacity(0.3),
                  style: BorderStyle.solid,
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.visibility_off, color: Colors.orange.shade400),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Section Hidden',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.orange.shade700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'This is a replacementSliver shown when the '
                          'original section is hidden.',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.orange.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext ctx, int index) {
                return ListTile(
                  leading: const Icon(Icons.article, color: Colors.orange),
                  title: Text('Hidden item ${index + 1}'),
                );
              },
              childCount: 5,
            ),
          ),
        ),

        SliverToBoxAdapter(
          child: Container(
            padding: const EdgeInsets.all(12),
            color: Colors.green.shade600,
            child: const Text(
              'Below Section — Not Shifted',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 6: Comparison
  // ============================================================
  print('=== Section 6: Comparison ===');

  final comparisons = <Map<String, dynamic>>[
    {
      'name': 'SliverVisibility',
      'where': 'Sliver context',
      'state': 'Optional (maintainState)',
      'layout': 'Optional (maintainSize)',
      'semantics': 'Optional (maintainSemantics)',
      'replacement': 'Yes (replacementSliver)',
      'color': Colors.cyan,
    },
    {
      'name': 'Visibility',
      'where': 'Box context',
      'state': 'Optional',
      'layout': 'Optional',
      'semantics': 'Optional',
      'replacement': 'Yes (replacement)',
      'color': Colors.blue,
    },
    {
      'name': 'SliverOffstage',
      'where': 'Sliver context',
      'state': 'Always maintained',
      'layout': 'Always off',
      'semantics': 'Removed',
      'replacement': 'No',
      'color': Colors.purple,
    },
    {
      'name': 'Offstage',
      'where': 'Box context',
      'state': 'Always maintained',
      'layout': 'Off (no height)',
      'semantics': 'Removed',
      'replacement': 'No',
      'color': Colors.indigo,
    },
    {
      'name': 'Conditional (if)',
      'where': 'Any',
      'state': 'Destroyed',
      'layout': 'Removed',
      'semantics': 'Removed',
      'replacement': 'Manual',
      'color': Colors.red,
    },
    {
      'name': 'SliverOpacity',
      'where': 'Sliver context',
      'state': 'Always maintained',
      'layout': 'Always present',
      'semantics': 'Optional',
      'replacement': 'No',
      'color': Colors.orange,
    },
  ];

  final compWidgets = <Widget>[];
  for (var i = 0; i < comparisons.length; i++) {
    final c = comparisons[i];
    final ccol = c['color'] as Color;
    print('Comparison ${i + 1}: ${c['name']}');
    compWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: ccol.withOpacity(0.04),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: ccol.withOpacity(0.2)),
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
                    color: ccol.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    c['name'] as String,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: ccol,
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
                    c['where'] as String,
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            _svRefRow('State', c['state'] as String, ccol),
            _svRefRow('Layout', c['layout'] as String, ccol),
            _svRefRow('Semantics', c['semantics'] as String, ccol),
            _svRefRow('Replacement', c['replacement'] as String, ccol),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 7: Maintain Flags Matrix
  // ============================================================
  print('=== Section 7: Flags Matrix ===');

  final flagMatrix = <Map<String, dynamic>>[
    {
      'flags': 'visible: false',
      'state': false,
      'anim': false,
      'size': false,
      'sem': false,
      'hit': false,
      'desc': 'Sliver removed completely. Replaced by replacementSliver.',
    },
    {
      'flags': 'maintainState: true',
      'state': true,
      'anim': false,
      'size': false,
      'sem': false,
      'hit': false,
      'desc': 'State kept alive. Animation paused, no layout space.',
    },
    {
      'flags': 'maintainAnimation: true',
      'state': true,
      'anim': true,
      'size': false,
      'sem': false,
      'hit': false,
      'desc': 'State + animations kept. Still no layout space.',
    },
    {
      'flags': 'maintainSize: true',
      'state': true,
      'anim': true,
      'size': true,
      'sem': false,
      'hit': false,
      'desc': 'Full layout space reserved. Invisible but occupies room.',
    },
    {
      'flags': 'maintainSemantics: true',
      'state': true,
      'anim': true,
      'size': true,
      'sem': true,
      'hit': false,
      'desc': 'Screen readers still see it. Invisible to eyes only.',
    },
    {
      'flags': 'maintainInteractivity: true',
      'state': true,
      'anim': true,
      'size': true,
      'sem': true,
      'hit': true,
      'desc': 'Fully maintained. Invisible but tappable and accessible.',
    },
  ];

  final matrixWidgets = <Widget>[];
  for (var i = 0; i < flagMatrix.length; i++) {
    final fm = flagMatrix[i];
    print('Flag combo ${i + 1}: ${fm['flags']}');
    matrixWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.cyan.withOpacity(0.03 + (i * 0.015)),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.cyan.withOpacity(0.1 + (i * 0.05)),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.cyan.withOpacity(0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                fm['flags'] as String,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.cyan,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _svFlagChip('State', fm['state'] as bool),
                _svFlagChip('Anim', fm['anim'] as bool),
                _svFlagChip('Size', fm['size'] as bool),
                _svFlagChip('Sem', fm['sem'] as bool),
                _svFlagChip('Hit', fm['hit'] as bool),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              fm['desc'] as String,
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey.shade600,
                height: 1.4,
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
      'icon': Icons.visibility,
      'text': 'SliverVisibility controls sliver visibility with fine-grained '
          'maintain flags for state, animation, size, semantics, and hit testing.',
    },
    {
      'icon': Icons.memory,
      'text': 'Use maintainState: true to avoid losing widget state when '
          'temporarily hiding a sliver section.',
    },
    {
      'icon': Icons.aspect_ratio,
      'text': 'Use maintainSize: true to prevent layout jumps — the hidden '
          'sliver still takes up its full space.',
    },
    {
      'icon': Icons.swap_horiz,
      'text': 'Provide a replacementSliver for placeholder content when the '
          'main sliver is hidden without maintainSize.',
    },
    {
      'icon': Icons.compare,
      'text': 'Choose SliverVisibility over conditionals when you need state '
          'preservation. Choose SliverOffstage for simpler always-maintain.',
    },
    {
      'icon': Icons.layers,
      'text': 'The maintain flags form a dependency chain: interactivity '
          'requires semantics, which requires size, animation, and state.',
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
                color: Colors.cyan.shade700,
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
        title: const Text('SliverVisibility'),
        backgroundColor: Colors.cyan.shade700,
        bottom: const TabBar(
          isScrollable: true,
          indicatorColor: Colors.white,
          tabs: [
            Tab(icon: Icon(Icons.info_outline), text: 'Concept'),
            Tab(icon: Icon(Icons.construction), text: 'Properties'),
            Tab(icon: Icon(Icons.toggle_on), text: 'Basic'),
            Tab(icon: Icon(Icons.save), text: 'State'),
            Tab(icon: Icon(Icons.swap_horiz), text: 'Replacement'),
            Tab(icon: Icon(Icons.compare), text: 'Comparison'),
            Tab(icon: Icon(Icons.grid_on), text: 'Flags'),
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
                  color: Colors.cyan.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'SliverVisibility: control whether a sliver is visible '
                  'while optionally keeping its state, animations, layout '
                  'space, semantics, and hit testing alive.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...conceptCards,
            ],
          ),

          // Tab 2: Properties
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
                  'All properties of SliverVisibility. The maintain flags '
                  'form a chain — each higher level requires all lower ones.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...propWidgets,
            ],
          ),

          // Tab 3: Basic Toggle
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
                  'Three sections in a CustomScrollView. Section B is '
                  'wrapped in SliverVisibility, currently visible. In a '
                  'stateful app, toggling visible: false would hide it.',
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

          // Tab 4: State Preservation
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
                  'How each maintain flag affects the hidden sliver. Flags '
                  'build on each other in a dependency chain.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...stateCards,
            ],
          ),

          // Tab 5: Replacement Sliver
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
                  'When a sliver is hidden without maintainSize, a '
                  'replacement sliver takes its place. The default is an '
                  'empty SliverToBoxAdapter. You can provide a custom one.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: replacementDemo,
                ),
              ),
              Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.orange.withOpacity(0.2)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.orange.shade600),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'The orange placeholder above is a replacementSliver. '
                        'The original list items are hidden.',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.orange.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Tab 6: Comparison
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
                  'How SliverVisibility compares to other visibility '
                  'mechanisms in Flutter.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...compWidgets,
            ],
          ),

          // Tab 7: Flags Matrix
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
                  'The maintain flags dependency chain. Each flag requires '
                  'all flags below it to be true.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...matrixWidgets,
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
                      Colors.cyan.withOpacity(0.12),
                      Colors.blue.withOpacity(0.06),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Key takeaways about SliverVisibility.',
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

// ====================================================================
// Helper: Comparison reference row
// ====================================================================
Widget _svRefRow(String label, String value, Color color) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      children: [
        SizedBox(
          width: 90,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade600,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: 11, color: color),
          ),
        ),
      ],
    ),
  );
}

// ====================================================================
// Helper: Flag chip for the matrix
// ====================================================================
Widget _svFlagChip(String label, bool active) {
  return Column(
    children: [
      Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: active
              ? Colors.green.withOpacity(0.15)
              : Colors.red.withOpacity(0.08),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: active
                ? Colors.green.withOpacity(0.5)
                : Colors.red.withOpacity(0.2),
          ),
        ),
        child: Icon(
          active ? Icons.check : Icons.close,
          size: 14,
          color: active ? Colors.green.shade700 : Colors.red.shade300,
        ),
      ),
      const SizedBox(height: 3),
      Text(
        label,
        style: TextStyle(
          fontSize: 9,
          color: Colors.grey.shade500,
        ),
      ),
    ],
  );
}
