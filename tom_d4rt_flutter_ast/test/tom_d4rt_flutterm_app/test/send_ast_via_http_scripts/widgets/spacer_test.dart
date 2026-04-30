// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — Spacer
// Demonstrates the Spacer widget, which creates adjustable blank space
// in Flex layouts (Row, Column, Flex). Spacer is a convenience wrapper
// around Expanded with an empty SizedBox child. Its flex factor controls
// how remaining space is distributed among multiple Spacers.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Spacer Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptItems = <Map<String, dynamic>>[
    {
      'icon': Icons.space_bar,
      'title': 'What is Spacer?',
      'body': 'Spacer is a widget that takes up available space along the '
          'main axis of a Row, Column, or Flex. It does not render any '
          'visual content — it just occupies space to push other widgets '
          'apart. Under the hood it is Expanded(child: SizedBox.shrink()).',
      'accent': Colors.deepPurple,
    },
    {
      'icon': Icons.linear_scale,
      'title': 'Flex Factor',
      'body': 'Spacer accepts a single parameter: flex (default 1). '
          'The flex factor works identically to Expanded.flex — it '
          'determines how much of the remaining space this Spacer '
          'claims relative to other flexible children.',
      'accent': Colors.blue,
    },
    {
      'icon': Icons.swap_horiz,
      'title': 'Spacer vs Expanded',
      'body': 'Expanded wraps a visible child and makes it fill remaining '
          'space. Spacer wraps nothing — its only purpose is to create '
          'blank space. Use Spacer when you want gaps, Expanded when you '
          'want a widget to grow.',
      'accent': Colors.orange,
    },
    {
      'icon': Icons.straighten,
      'title': 'Spacer vs SizedBox',
      'body': 'SizedBox creates a fixed-size gap (e.g., 16 pixels). '
          'Spacer creates a flexible gap that grows or shrinks with the '
          'available space. Use SizedBox for exact spacing, Spacer for '
          'proportional spacing.',
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
  // SECTION 2: API Surface
  // ============================================================
  print('=== Section 2: API ===');

  final apiRows = <Map<String, String>>[
    {
      'member': 'Spacer({int flex = 1})',
      'kind': 'Constructor',
      'desc': 'Creates a spacer with the given flex factor. The flex '
          'determines how much space this spacer claims relative to '
          'other flexible children in the same Flex parent.',
    },
    {
      'member': 'flex',
      'kind': 'Property',
      'desc': 'The flex factor. Defaults to 1. Higher values claim '
          'more of the remaining space. The ratio between flex values '
          'determines the proportional sizes.',
    },
    {
      'member': 'build(context)',
      'kind': 'Method',
      'desc': 'Returns Expanded(flex: flex, child: const SizedBox.shrink()). '
          'This is the entire implementation — Spacer is just syntactic '
          'sugar over Expanded with an empty child.',
    },
  ];

  final apiWidgets = <Widget>[];
  for (var i = 0; i < apiRows.length; i++) {
    final row = apiRows[i];
    print('API ${i + 1}: ${row['member']}');
    apiWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: i.isEven
              ? Colors.deepPurple.withOpacity(0.05)
              : Colors.grey.withOpacity(0.03),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.deepPurple.withOpacity(0.15)),
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
                    color: Colors.deepPurple.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    row['member']!,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.deepPurple,
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
                    row['kind']!,
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey.shade600,
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
  // SECTION 3: Basic Usage in Row
  // ============================================================
  print('=== Section 3: Basic Row ===');

  final rowExamples = <Map<String, dynamic>>[
    {
      'label': 'Leading Spacer',
      'desc': 'Push all content to the end.',
      'children': <Widget>[
        const Spacer(),
        _tag('A', Colors.deepPurple),
        const SizedBox(width: 6),
        _tag('B', Colors.deepPurple),
      ],
    },
    {
      'label': 'Trailing Spacer',
      'desc': 'Push all content to the start.',
      'children': <Widget>[
        _tag('A', Colors.blue),
        const SizedBox(width: 6),
        _tag('B', Colors.blue),
        const Spacer(),
      ],
    },
    {
      'label': 'Middle Spacer',
      'desc': 'Push content to both ends.',
      'children': <Widget>[
        _tag('A', Colors.orange),
        const Spacer(),
        _tag('B', Colors.orange),
      ],
    },
    {
      'label': 'Surrounding Spacers',
      'desc': 'Center content using two Spacers.',
      'children': <Widget>[
        const Spacer(),
        _tag('CENTERED', Colors.green),
        const Spacer(),
      ],
    },
  ];

  final rowWidgets = <Widget>[];
  for (var i = 0; i < rowExamples.length; i++) {
    final ex = rowExamples[i];
    print('Row example ${i + 1}: ${ex['label']}');
    rowWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.deepPurple.withOpacity(0.03),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.deepPurple.withOpacity(0.15)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ex['label'] as String,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              ex['desc'] as String,
              style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
            ),
            const SizedBox(height: 8),
            Container(
              height: 44,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.06),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.grey.withOpacity(0.15)),
              ),
              child: Row(
                children: ex['children'] as List<Widget>,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 4: Column Usage
  // ============================================================
  print('=== Section 4: Column Usage ===');

  final colExamples = <Map<String, dynamic>>[
    {
      'label': 'Header — Spacer — Footer',
      'desc': 'Push header up and footer down.',
      'color': Colors.teal,
    },
    {
      'label': 'FAB at Bottom',
      'desc': 'Position an action button at the bottom.',
      'color': Colors.indigo,
    },
    {
      'label': 'Equal Spacing',
      'desc': 'Three items equally spaced with Spacers.',
      'color': Colors.pink,
    },
  ];

  final colWidgets = <Widget>[];
  for (var i = 0; i < colExamples.length; i++) {
    final ce = colExamples[i];
    final ceColor = ce['color'] as Color;
    print('Column example ${i + 1}: ${ce['label']}');

    Widget colContent;
    if (i == 0) {
      colContent = Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: ceColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text('Header', style: TextStyle(fontSize: 11, color: ceColor, fontWeight: FontWeight.bold)),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: ceColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text('Footer', style: TextStyle(fontSize: 11, color: ceColor, fontWeight: FontWeight.bold)),
          ),
        ],
      );
    } else if (i == 1) {
      colContent = Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: ceColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text('Content Area', style: TextStyle(fontSize: 11, color: ceColor)),
          ),
          const Spacer(),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: ceColor,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.add, color: Colors.white, size: 20),
          ),
        ],
      );
    } else {
      colContent = Column(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: ceColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text('Item 1', style: TextStyle(fontSize: 10, color: ceColor)),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: ceColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text('Item 2', style: TextStyle(fontSize: 10, color: ceColor)),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: ceColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text('Item 3', style: TextStyle(fontSize: 10, color: ceColor)),
          ),
        ],
      );
    }

    colWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: ceColor.withOpacity(0.03),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: ceColor.withOpacity(0.15)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ce['label'] as String,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: ceColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(ce['desc'] as String, style: TextStyle(fontSize: 11, color: Colors.grey.shade500)),
            const SizedBox(height: 8),
            Container(
              height: 140,
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.05),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.grey.withOpacity(0.15)),
              ),
              child: colContent,
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 5: Flex Factor Demo
  // ============================================================
  print('=== Section 5: Flex Factor ===');

  final flexCases = <Map<String, dynamic>>[
    {'flexValues': [1, 1], 'desc': 'Two Spacers with flex:1 — equal halves'},
    {'flexValues': [1, 2], 'desc': 'flex:1 and flex:2 — 1/3 and 2/3'},
    {'flexValues': [1, 1, 1], 'desc': 'Three Spacers flex:1 — equal thirds'},
    {'flexValues': [1, 3], 'desc': 'flex:1 and flex:3 — 1/4 and 3/4'},
    {'flexValues': [2, 1, 2], 'desc': 'flex:2, flex:1, flex:2 — 2/5, 1/5, 2/5'},
  ];

  final flexColors = [
    Colors.deepPurple,
    Colors.blue,
    Colors.teal,
    Colors.orange,
    Colors.pink,
  ];

  final flexWidgets = <Widget>[];
  for (var i = 0; i < flexCases.length; i++) {
    final fc = flexCases[i];
    final fcColor = flexColors[i % flexColors.length];
    final values = fc['flexValues'] as List<int>;
    final totalFlex = values.fold<int>(0, (a, b) => a + b);
    print('Flex case ${i + 1}: $values');
    flexWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: fcColor.withOpacity(0.03),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: fcColor.withOpacity(0.15)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              fc['desc'] as String,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: fcColor,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              height: 36,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.grey.withOpacity(0.2)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Row(
                  children: [
                    for (var j = 0; j < values.length; j++) ...[
                      Expanded(
                        flex: values[j],
                        child: Container(
                          color: fcColor.withOpacity(0.1 + j * 0.12),
                          child: Center(
                            child: Text(
                              'flex:${values[j]}\n(${values[j]}/$totalFlex)',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w600,
                                color: fcColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      if (j < values.length - 1)
                        Container(width: 1, color: fcColor.withOpacity(0.2)),
                    ],
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
  // SECTION 6: Comparison
  // ============================================================
  print('=== Section 6: Comparison ===');

  final comparisonData = <Map<String, dynamic>>[
    {
      'widget': 'Spacer',
      'icon': Icons.space_bar,
      'behavior': 'Flexible blank space',
      'use': 'Proportional gaps that adapt to available space',
      'code': 'const Spacer(flex: 1)',
      'color': Colors.deepPurple,
    },
    {
      'widget': 'SizedBox',
      'icon': Icons.straighten,
      'behavior': 'Fixed-size gap',
      'use': 'Exact pixel spacing that never changes',
      'code': 'const SizedBox(width: 16)',
      'color': Colors.blue,
    },
    {
      'widget': 'Expanded',
      'icon': Icons.open_in_full,
      'behavior': 'Flexible child wrapper',
      'use': 'A visible widget that fills remaining space',
      'code': 'Expanded(child: myWidget)',
      'color': Colors.teal,
    },
    {
      'widget': 'Flexible',
      'icon': Icons.unfold_more,
      'behavior': 'Soft flexible wrapper',
      'use': 'A child that can optionally grow (fit: loose)',
      'code': 'Flexible(child: myWidget)',
      'color': Colors.orange,
    },
    {
      'widget': 'Padding',
      'icon': Icons.padding,
      'behavior': 'Fixed insets',
      'use': 'Inset space within a widget, not between siblings',
      'code': 'Padding(padding: EdgeInsets.all(8))',
      'color': Colors.pink,
    },
  ];

  final compWidgets = <Widget>[];
  for (var i = 0; i < comparisonData.length; i++) {
    final cd = comparisonData[i];
    final cdColor = cd['color'] as Color;
    print('Compare ${i + 1}: ${cd['widget']}');
    compWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: cdColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: cdColor.withOpacity(0.2)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: cdColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(cd['icon'] as IconData, color: cdColor, size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        cd['widget'] as String,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: cdColor,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: cdColor.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          cd['behavior'] as String,
                          style: TextStyle(fontSize: 9, color: cdColor),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    cd['use'] as String,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade700,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: cdColor.withOpacity(0.06),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      cd['code'] as String,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 10,
                        color: cdColor,
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

  // ============================================================
  // SECTION 7: Practical Layouts
  // ============================================================
  print('=== Section 7: Practical ===');

  // Toolbar demo
  final toolbarDemo = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'App Bar Layout',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Leading icon, title, then Spacer pushes actions to the right.',
          style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.deepPurple,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              const Icon(Icons.menu, color: Colors.white, size: 20),
              const SizedBox(width: 12),
              const Text(
                'My App',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              const Icon(Icons.search, color: Colors.white, size: 20),
              const SizedBox(width: 12),
              const Icon(Icons.notifications, color: Colors.white, size: 20),
              const SizedBox(width: 12),
              const Icon(Icons.more_vert, color: Colors.white, size: 20),
            ],
          ),
        ),
      ],
    ),
  );

  // Dialog buttons demo
  final dialogDemo = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Dialog Buttons',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Spacer pushes buttons to the right edge of the dialog.',
          style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.withOpacity(0.2)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Delete this item?', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              Text('This action cannot be undone.', style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Text('Cancel', style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text('Delete', style: TextStyle(fontSize: 12, color: Colors.white)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // List tile with trailing
  final listTileDemo = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Custom List Tile',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.teal,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Leading avatar + title, Spacer, then trailing metadata.',
          style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.04),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.withOpacity(0.15)),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: Colors.teal.withOpacity(0.15),
                child: const Icon(Icons.person, color: Colors.teal, size: 20),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'John Doe',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Software Engineer',
                    style: TextStyle(fontSize: 10, color: Colors.grey.shade500),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                '3:42 PM',
                style: TextStyle(fontSize: 10, color: Colors.grey.shade400),
              ),
              const SizedBox(width: 6),
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: Summary
  // ============================================================
  print('=== Section 8: Summary ===');

  final summaryPoints = <Map<String, dynamic>>[
    {
      'icon': Icons.space_bar,
      'text': 'Spacer is a stateless widget that creates flexible blank '
          'space in Row, Column, and Flex layouts.',
    },
    {
      'icon': Icons.linear_scale,
      'text': 'The flex parameter (default 1) controls proportional space '
          'allocation, just like Expanded.flex.',
    },
    {
      'icon': Icons.code,
      'text': 'Under the hood, Spacer is Expanded(child: SizedBox.shrink()). '
          'It is pure syntactic sugar.',
    },
    {
      'icon': Icons.swap_horiz,
      'text': 'Use Spacer for proportional gaps between children. '
          'Use SizedBox for fixed-pixel gaps.',
    },
    {
      'icon': Icons.dashboard,
      'text': 'Common patterns: push items to edges, center content, '
          'create toolbar layouts, and dialog button alignment.',
    },
    {
      'icon': Icons.accessibility,
      'text': 'Spacer has no visual or semantic output — it is invisible '
          'to screen readers and hit testing.',
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
          color: Colors.deepPurple.withOpacity(0.04 + (i % 3) * 0.02),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.deepPurple.withOpacity(0.12)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.deepPurple.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                sp['icon'] as IconData,
                color: Colors.deepPurple,
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
        title: const Text('Spacer'),
        backgroundColor: Colors.deepPurple,
        bottom: const TabBar(
          isScrollable: true,
          indicatorColor: Colors.white,
          tabs: [
            Tab(icon: Icon(Icons.info_outline), text: 'Concept'),
            Tab(icon: Icon(Icons.api), text: 'API'),
            Tab(icon: Icon(Icons.swap_horiz), text: 'Row'),
            Tab(icon: Icon(Icons.swap_vert), text: 'Column'),
            Tab(icon: Icon(Icons.linear_scale), text: 'Flex'),
            Tab(icon: Icon(Icons.compare), text: 'Compare'),
            Tab(icon: Icon(Icons.dashboard), text: 'Practical'),
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
                  color: Colors.deepPurple.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Spacer: a widget that creates flexible blank space to '
                  'push siblings apart in Flex layouts.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...conceptCards,
            ],
          ),

          // Tab 2: API
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Spacer has one of the smallest APIs in Flutter — '
                  'a single constructor parameter.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...apiWidgets,
            ],
          ),

          // Tab 3: Row
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Spacer placement in Row determines where children '
                  'are pushed: start, end, both, or center.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...rowWidgets,
            ],
          ),

          // Tab 4: Column
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Spacer works identically in Column, pushing children '
                  'along the vertical axis.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...colWidgets,
            ],
          ),

          // Tab 5: Flex Factor
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Multiple Spacers divide remaining space proportionally '
                  'based on their flex values.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...flexWidgets,
            ],
          ),

          // Tab 6: Compare
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Comparison of spacing widgets. Each has a distinct use case.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...compWidgets,
            ],
          ),

          // Tab 7: Practical
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Real-world layouts that rely on Spacer for alignment.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              toolbarDemo,
              dialogDemo,
              listTileDemo,
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
                      Colors.deepPurple.withOpacity(0.12),
                      Colors.purple.withOpacity(0.06),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Key takeaways about Spacer.',
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

/// Helper that creates a colored tag label for Row demos.
Widget _tag(String label, Color color) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: color.withOpacity(0.15),
      borderRadius: BorderRadius.circular(6),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: color,
      ),
    ),
  );
}
