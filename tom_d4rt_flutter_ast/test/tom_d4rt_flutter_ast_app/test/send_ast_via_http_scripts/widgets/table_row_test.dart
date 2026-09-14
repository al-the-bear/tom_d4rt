// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — TableRow
// Demonstrates TableRow, the widget that represents a horizontal row of
// cells inside a Table. TableRow defines the children (cells) and an
// optional decoration for row-level styling such as background colors,
// gradients, or borders. Every child of a Table must be a TableRow.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TableRow Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptItems = <Map<String, dynamic>>[
    {
      'icon': Icons.table_rows,
      'title': 'What is TableRow?',
      'body': 'TableRow is not a widget in the traditional sense — it\'s a '
          'data object that groups a list of widgets (cells) into a row. '
          'Table.children is a List<TableRow>, and each TableRow provides '
          'the cells for that row.',
      'accent': Colors.amber,
    },
    {
      'icon': Icons.grid_on,
      'title': 'Relationship to Table',
      'body': 'Every Table requires at least one TableRow. All TableRows '
          'must have the same number of children (matching the column '
          'count). The Table lays out columns first, then positions '
          'each row\'s children within those column widths.',
      'accent': Colors.blue,
    },
    {
      'icon': Icons.format_paint,
      'title': 'Row Decoration',
      'body': 'TableRow.decoration accepts a Decoration (typically Box'
          'Decoration) that paints behind all cells in the row. This is '
          'the standard way to add row backgrounds, alternating colors, '
          'or hover highlights.',
      'accent': Colors.green,
    },
    {
      'icon': Icons.compare,
      'title': 'TableRow vs Row Widget',
      'body': 'Row is a layout widget that sizes children with flex. '
          'TableRow is a data container for Table — it doesn\'t do '
          'layout itself. Table handles column alignment across rows, '
          'which Row cannot do.',
      'accent': Colors.deepOrange,
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
  // SECTION 2: API
  // ============================================================
  print('=== Section 2: API ===');

  final apiEntries = <Map<String, String>>[
    {
      'name': 'children',
      'type': 'List<Widget>',
      'desc': 'The widgets in this row, one per column. Every TableRow '
          'in a Table must have the same number of children. Children '
          'can be plain widgets or wrapped in TableCell for per-cell '
          'vertical alignment.',
    },
    {
      'name': 'decoration',
      'type': 'Decoration?',
      'desc': 'A decoration painted behind the row. Typically a '
          'BoxDecoration with a background color. The decoration '
          'covers the full row width and the row\'s computed height.',
    },
  ];

  final tableProperties = <Map<String, String>>[
    {
      'name': 'Table.children',
      'type': 'List<TableRow>',
      'desc': 'The rows of the table. Each element is a TableRow whose '
          'children are the cells. Rows are laid out top to bottom.',
    },
    {
      'name': 'Table.defaultVerticalAlignment',
      'type': 'TableCellVerticalAlignment',
      'desc': 'Default vertical alignment for cells that do not have '
          'a TableCell wrapper with explicit alignment. Defaults '
          'to top.',
    },
    {
      'name': 'Table.border',
      'type': 'TableBorder?',
      'desc': 'Draws borders around and between cells. Supports '
          'different styles for top, bottom, left, right, horizontal '
          'inside, and vertical inside borders.',
    },
    {
      'name': 'Table.columnWidths',
      'type': 'Map<int, TableColumnWidth>?',
      'desc': 'Per-column width specifications. The key is the column '
          'index. Columns not in the map use defaultColumnWidth.',
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
              ? Colors.amber.withOpacity(0.06)
              : Colors.grey.withOpacity(0.03),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.amber.withOpacity(0.2)),
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
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.amber,
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
                    ae['type']!,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
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

  apiWidgets.add(
    Container(
      margin: const EdgeInsets.fromLTRB(16, 14, 16, 4),
      child: Text(
        'Related Table Properties',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.amber.shade800,
        ),
      ),
    ),
  );
  for (var i = 0; i < tableProperties.length; i++) {
    final tp = tableProperties[i];
    print('TableProp ${i + 1}: ${tp['name']}');
    apiWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.amber.withOpacity(0.03),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.amber.withOpacity(0.12)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: Colors.amber.withOpacity(0.12),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                tp['name']!,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber.shade800,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                tp['desc']!,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey.shade700,
                  height: 1.35,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 3: Basic Table with Rows
  // ============================================================
  print('=== Section 3: Basic ===');

  final sampleData = <List<String>>[
    ['Flutter', 'Widget toolkit', 'Stable'],
    ['Dart', 'Language', 'Stable'],
    ['DevTools', 'Debugging', 'Stable'],
    ['Pub', 'Package manager', 'Stable'],
    ['DartPad', 'Online editor', 'Stable'],
  ];

  // Build a visual table
  final hdrRow = Container(
    padding: const EdgeInsets.symmetric(vertical: 10),
    decoration: BoxDecoration(
      color: Colors.amber.withOpacity(0.15),
      border: Border(bottom: BorderSide(color: Colors.amber.withOpacity(0.3))),
    ),
    child: Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              'Name',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: Colors.amber.shade900,
              ),
            ),
          ),
        ),
        Expanded(
          child: Text(
            'Category',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: Colors.amber.shade900,
            ),
          ),
        ),
        Expanded(
          child: Text(
            'Status',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: Colors.amber.shade900,
            ),
          ),
        ),
      ],
    ),
  );

  final bodyRows = <Widget>[];
  for (var r = 0; r < sampleData.length; r++) {
    final row = sampleData[r];
    print('Row ${r + 1}: ${row[0]}');
    bodyRows.add(
      Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: r.isEven
              ? Colors.amber.withOpacity(0.04)
              : Colors.transparent,
          border: Border(
            bottom: BorderSide(color: Colors.grey.withOpacity(0.12)),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  row[0],
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade800,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Text(
                row[1],
                style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  row[2],
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.green,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final basicTable = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.amber.withOpacity(0.2)),
    ),
    clipBehavior: Clip.hardEdge,
    child: Column(children: [hdrRow, ...bodyRows]),
  );

  // ============================================================
  // SECTION 4: Row Decoration
  // ============================================================
  print('=== Section 4: Decoration ===');

  final decoExamples = <Map<String, dynamic>>[
    {
      'title': 'Solid Color Background',
      'desc': 'The simplest decoration. BoxDecoration with a single color '
          'paints behind all cells in the row.',
      'code': 'TableRow(\n'
          '  decoration: BoxDecoration(\n'
          '    color: Colors.amber.withOpacity(0.1),\n'
          '  ),\n'
          '  children: [...],\n'
          ')',
      'visual': Colors.amber.withOpacity(0.12),
      'color': Colors.amber,
    },
    {
      'title': 'Gradient Background',
      'desc': 'Use a LinearGradient in BoxDecoration for a gradient '
          'that spans the full row width. Horizontal gradients look '
          'best for row decorations.',
      'code': 'TableRow(\n'
          '  decoration: BoxDecoration(\n'
          '    gradient: LinearGradient(\n'
          '      colors: [Colors.amber.withOpacity(0.15),\n'
          '               Colors.transparent],\n'
          '    ),\n'
          '  ),\n'
          '  children: [...],\n'
          ')',
      'visual': Colors.blue.withOpacity(0.08),
      'color': Colors.blue,
    },
    {
      'title': 'Bottom Border Only',
      'desc': 'Combine a transparent background with a bottom-only border '
          'in BoxDecoration to create separator lines between rows.',
      'code': 'TableRow(\n'
          '  decoration: BoxDecoration(\n'
          '    border: Border(\n'
          '      bottom: BorderSide(\n'
          '        color: Colors.grey.shade300,\n'
          '      ),\n'
          '    ),\n'
          '  ),\n'
          '  children: [...],\n'
          ')',
      'visual': Colors.transparent,
      'color': Colors.green,
    },
    {
      'title': 'Hover / Selected State',
      'desc': 'Change the row decoration based on state. Use StatefulWidget '
          'or ValueNotifier to toggle between normal and highlighted '
          'decorations on hover or selection.',
      'code': 'TableRow(\n'
          '  decoration: BoxDecoration(\n'
          '    color: isSelected\n'
          '      ? Colors.amber.withOpacity(0.2)\n'
          '      : Colors.transparent,\n'
          '  ),\n'
          '  children: [...],\n'
          ')',
      'visual': Colors.amber.withOpacity(0.2),
      'color': Colors.orange,
    },
  ];

  final decoWidgets = <Widget>[];
  for (var i = 0; i < decoExamples.length; i++) {
    final de = decoExamples[i];
    final deColor = de['color'] as Color;
    print('Deco ${i + 1}: ${de['title']}');
    decoWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: deColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: deColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: deColor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Center(
                      child: Text(
                        '${i + 1}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: deColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      de['title'] as String,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: deColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Visual: mini row with decoration
              Container(
                height: 28,
                decoration: BoxDecoration(
                  color: de['visual'] as Color,
                  borderRadius: BorderRadius.circular(4),
                  border: de['title'] == 'Bottom Border Only'
                      ? const Border(
                          bottom: BorderSide(color: Colors.grey),
                        )
                      : null,
                ),
                child: Row(
                  children: [
                    for (var c = 0; c < 3; c++)
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: Center(
                            child: Text(
                              'cell ${c + 1}',
                              style: TextStyle(
                                fontSize: 8,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                de['desc'] as String,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                  height: 1.35,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: deColor.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  de['code'] as String,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10,
                    color: deColor,
                    height: 1.4,
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
  // SECTION 5: Header Rows
  // ============================================================
  print('=== Section 5: Headers ===');

  final headerPatterns = <Map<String, dynamic>>[
    {
      'title': 'Styled Header Row',
      'desc': 'Use a darker background and bold text for the first '
          'TableRow. This is the most common pattern for table headers.',
      'style': 'bold + dark bg',
      'color': Colors.amber,
    },
    {
      'title': 'Sticky Header',
      'desc': 'Table does not support sticky headers natively. For '
          'scrollable tables, separate the header into its own Table '
          'and place the body Table inside a SingleChildScrollView.',
      'style': 'split layout',
      'color': Colors.blue,
    },
    {
      'title': 'Multi-Line Header',
      'desc': 'Headers with long labels can wrap to multiple lines. '
          'Use TableCellVerticalAlignment.middle for the header row '
          'so multiline headers center nicely.',
      'style': 'wrapping text',
      'color': Colors.green,
    },
    {
      'title': 'Sortable Headers',
      'desc': 'Wrap header cells in GestureDetector to detect taps. '
          'Show an up/down arrow icon to indicate sort direction. '
          'Rebuild the Table with reordered data.',
      'style': 'tap + icon',
      'color': Colors.purple,
    },
  ];

  final headerWidgets = <Widget>[];
  for (var i = 0; i < headerPatterns.length; i++) {
    final hp = headerPatterns[i];
    final hpColor = hp['color'] as Color;
    print('Header ${i + 1}: ${hp['title']}');
    headerWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: hpColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: hpColor.withOpacity(0.2)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: hpColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(7),
              ),
              child: Center(
                child: Text(
                  '${i + 1}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: hpColor,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          hp['title'] as String,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: hpColor,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: hpColor.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          hp['style'] as String,
                          style: TextStyle(
                            fontSize: 9,
                            color: hpColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    hp['desc'] as String,
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
  // SECTION 6: Dynamic Rows
  // ============================================================
  print('=== Section 6: Dynamic ===');

  final dynamicTopics = <Map<String, dynamic>>[
    {
      'title': 'Building Rows from Data',
      'desc': 'Map a List of data items to TableRow widgets. Use '
          '.asMap().entries for index-based alternating decoration. '
          'Rebuild the Table when data changes.',
      'code': 'Table(\n'
          '  children: data.asMap().entries.map((e) {\n'
          '    return TableRow(\n'
          '      decoration: BoxDecoration(\n'
          '        color: e.key.isEven\n'
          '          ? Colors.grey.shade50\n'
          '          : Colors.white,\n'
          '      ),\n'
          '      children:\n'
          '        e.value.cells.map(cellWidget).toList(),\n'
          '    );\n'
          '  }).toList(),\n'
          ')',
      'color': Colors.amber,
    },
    {
      'title': 'Adding Rows',
      'desc': 'Add items to the data list and call setState. The Table '
          'rebuilds with the new rows. No animation by default — '
          'wrap in AnimatedSwitcher for transitions.',
      'code': 'void addRow(Item item) {\n'
          '  setState(() {\n'
          '    data.add(item);\n'
          '  });\n'
          '}',
      'color': Colors.blue,
    },
    {
      'title': 'Removing Rows',
      'desc': 'Remove items from the data list. For confirmation, show '
          'a dialog before removing. For undo, keep removed items '
          'in a separate list temporarily.',
      'code': 'void removeRow(int index) {\n'
          '  setState(() {\n'
          '    data.removeAt(index);\n'
          '  });\n'
          '}',
      'color': Colors.red,
    },
    {
      'title': 'Row Count Constraint',
      'desc': 'All rows must have the same number of children. When data '
          'has variable columns, pad shorter rows with empty SizedBox '
          'widgets to maintain the column count.',
      'code': 'final maxCols = data\n'
          '  .map((r) => r.length)\n'
          '  .reduce(max);\n'
          '// Pad each row to maxCols',
      'color': Colors.orange,
    },
  ];

  final dynamicWidgets = <Widget>[];
  for (var i = 0; i < dynamicTopics.length; i++) {
    final dt = dynamicTopics[i];
    final dtColor = dt['color'] as Color;
    print('Dynamic ${i + 1}: ${dt['title']}');
    dynamicWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: dtColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: dtColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: dtColor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Center(
                      child: Text(
                        '${i + 1}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: dtColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      dt['title'] as String,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: dtColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                dt['desc'] as String,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                  height: 1.35,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: dtColor.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  dt['code'] as String,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10,
                    color: dtColor,
                    height: 1.4,
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
  // SECTION 7: Best Practices
  // ============================================================
  print('=== Section 7: Best Practices ===');

  final practices = <Map<String, dynamic>>[
    {
      'title': 'Use Table for Small, Fixed Data',
      'desc': 'Table measures all children to compute row heights and '
          'column widths. For large datasets (100+ rows), use '
          'DataTable, PaginatedDataTable, or ListView-based layouts.',
      'icon': Icons.speed,
      'color': Colors.amber,
    },
    {
      'title': 'Prefer TableRow.decoration over Cell Wrappers',
      'desc': 'Row-level decoration is more efficient than wrapping '
          'each cell in a Container with a background. The Table '
          'paints the decoration once per row.',
      'icon': Icons.format_paint,
      'color': Colors.blue,
    },
    {
      'title': 'Consistent Column Count',
      'desc': 'Ensure every TableRow has the same number of children. '
          'Mismatched counts throw an assertion error in debug mode. '
          'Use helper functions to validate data before building.',
      'icon': Icons.rule,
      'color': Colors.red,
    },
    {
      'title': 'Use TableBorder for Grid Lines',
      'desc': 'Table.border paints efficient grid lines between cells. '
          'This is faster than adding borders to individual cells '
          'and ensures consistent line widths.',
      'icon': Icons.border_all,
      'color': Colors.green,
    },
    {
      'title': 'Consider DataTable for Material',
      'desc': 'DataTable provides sorting, selection, row taps, and '
          'Material styling out of the box. Use plain Table only '
          'when you need fully custom table rendering.',
      'icon': Icons.table_view,
      'color': Colors.purple,
    },
  ];

  final practiceWidgets = <Widget>[];
  for (var i = 0; i < practices.length; i++) {
    final pr = practices[i];
    final prColor = pr['color'] as Color;
    print('Practice ${i + 1}: ${pr['title']}');
    practiceWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: prColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: prColor.withOpacity(0.2)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: prColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(pr['icon'] as IconData, color: prColor, size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pr['title'] as String,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: prColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    pr['desc'] as String,
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
  // SECTION 8: Summary
  // ============================================================
  print('=== Section 8: Summary ===');

  final summaryPoints = <Map<String, dynamic>>[
    {
      'icon': Icons.table_rows,
      'text': 'TableRow groups cells into a row for the Table widget. '
          'It holds children and an optional decoration.',
    },
    {
      'icon': Icons.format_paint,
      'text': 'TableRow.decoration paints behind all cells — use it for '
          'row backgrounds, gradients, and alternating colors.',
    },
    {
      'icon': Icons.rule,
      'text': 'All TableRows in a Table must have the same number of '
          'children (matching the column count).',
    },
    {
      'icon': Icons.compare,
      'text': 'TableRow is a data object, not a layout widget. Table '
          'does the layout; Row is for general horizontal layout.',
    },
    {
      'icon': Icons.speed,
      'text': 'Table measures all rows upfront. Use DataTable or '
          'ListView for large datasets that need scrolling.',
    },
    {
      'icon': Icons.grid_on,
      'text': 'Combine with TableCell for per-cell alignment and '
          'Table.border for efficient grid line rendering.',
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
                color: Colors.amber,
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
        title: const Text('TableRow'),
        backgroundColor: Colors.amber,
        foregroundColor: Colors.black87,
        bottom: const TabBar(
          isScrollable: true,
          indicatorColor: Colors.black87,
          labelColor: Colors.black87,
          unselectedLabelColor: Colors.black54,
          tabs: [
            Tab(icon: Icon(Icons.info_outline), text: 'Concept'),
            Tab(icon: Icon(Icons.api), text: 'API'),
            Tab(icon: Icon(Icons.grid_on), text: 'Basic'),
            Tab(icon: Icon(Icons.format_paint), text: 'Decor'),
            Tab(icon: Icon(Icons.view_headline), text: 'Headers'),
            Tab(icon: Icon(Icons.playlist_add), text: 'Dynamic'),
            Tab(icon: Icon(Icons.check_circle), text: 'Practices'),
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
                  'TableRow: the row container for Table widgets, '
                  'grouping cells and providing row-level decoration.',
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
                  color: Colors.amber.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'TableRow properties and related Table API members.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...apiWidgets,
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
                  'A basic table with header and data rows showing '
                  'alternating row backgrounds.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              basicTable,
            ],
          ),

          // Tab 4: Decoration
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
                  'Row-level decoration patterns: solid colors, '
                  'gradients, borders, and state-based highlights.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...decoWidgets,
            ],
          ),

          // Tab 5: Headers
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
                  'Patterns for styling and managing table header rows.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...headerWidgets,
            ],
          ),

          // Tab 6: Dynamic
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
                  'Building, adding, and removing TableRows dynamically '
                  'from data sources.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...dynamicWidgets,
            ],
          ),

          // Tab 7: Best Practices
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
                  'Performance tips, design patterns, and when to use '
                  'Table vs alternatives.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...practiceWidgets,
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
                  'Key takeaways about TableRow.',
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
