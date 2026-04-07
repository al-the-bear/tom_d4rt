// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — TableCell
// Demonstrates TableCell, the widget that controls how a child is
// positioned within a cell of a Table widget. TableCell provides
// vertical alignment control and integrates with the Table layout
// algorithm. Each child of a TableRow should be wrapped in a TableCell
// when custom alignment or spanning behavior is needed.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TableCell Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptItems = <Map<String, dynamic>>[
    {
      'icon': Icons.grid_on,
      'title': 'What is TableCell?',
      'body': 'TableCell is a widget used as a child of TableRow. It '
          'provides per-cell vertical alignment control within a '
          'Table layout. Without TableCell, children use the default '
          'alignment from Table.defaultVerticalAlignment.',
      'accent': Colors.cyan,
    },
    {
      'icon': Icons.table_chart,
      'title': 'Relationship to Table',
      'body': 'Table contains TableRows, which contain children. Those '
          'children can optionally be wrapped in TableCell to override '
          'the vertical alignment for that specific cell. The Table '
          'handles column widths; TableCell handles vertical position.',
      'accent': Colors.blue,
    },
    {
      'icon': Icons.vertical_align_center,
      'title': 'Vertical Alignment',
      'body': 'Each TableCell can specify a verticalAlignment from the '
          'TableCellVerticalAlignment enum: top, middle, bottom, '
          'baseline, fill, or intrinsicHeight. This overrides the '
          'Table\'s defaultVerticalAlignment for that cell alone.',
      'accent': Colors.green,
    },
    {
      'icon': Icons.compare_arrows,
      'title': 'Why Not Just Container?',
      'body': 'Container with Alignment works for simple positioning, '
          'but TableCell participates in the Table layout protocol. '
          'It communicates alignment to the Table\'s RenderObject, '
          'which coordinates row heights across all cells.',
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
      'name': 'verticalAlignment',
      'type': 'TableCellVerticalAlignment?',
      'desc': 'The vertical alignment of this cell within its row. If '
          'null, the Table\'s defaultVerticalAlignment is used. When '
          'set, overrides the default for this cell only.',
    },
    {
      'name': 'child',
      'type': 'Widget',
      'desc': 'The widget content of this cell. Can be any widget — '
          'Text, Container, Icon, or complex layouts. The Table '
          'constrains the child\'s width to the column width.',
    },
  ];

  final alignEnumValues = <Map<String, String>>[
    {
      'value': 'top',
      'desc': 'Align the cell\'s child at the top of the row. The child '
          'sits flush with the top edge, with empty space below if '
          'other cells in the row are taller.',
    },
    {
      'value': 'middle',
      'desc': 'Center the child vertically in the row. Equal space above '
          'and below. This is the default for Table if not overridden.',
    },
    {
      'value': 'bottom',
      'desc': 'Align at the bottom of the row. Empty space appears above '
          'the child. Useful for footer-like content in a row.',
    },
    {
      'value': 'baseline',
      'desc': 'Align along the text baseline. Requires textBaseline to be '
          'set on the Table. All baseline-aligned cells in a row share '
          'the same baseline, ensuring text alignment across columns.',
    },
    {
      'value': 'fill',
      'desc': 'Stretch the child to fill the full row height. The child '
          'is forced to be as tall as the tallest cell in the row. '
          'Good for colored backgrounds or dividers.',
    },
    {
      'value': 'intrinsicHeight',
      'desc': 'Size the child to its intrinsic height, then position at '
          'the top. The row height is the max intrinsic height of all '
          'children. More expensive than other modes.',
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
                    ae['name']!,
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

  // Enum values section
  apiWidgets.add(
    Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: const Text(
        'TableCellVerticalAlignment Values',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.cyan,
        ),
      ),
    ),
  );
  for (var i = 0; i < alignEnumValues.length; i++) {
    final ev = alignEnumValues[i];
    print('Enum ${i + 1}: ${ev['value']}');
    apiWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.cyan.withOpacity(0.03),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.cyan.withOpacity(0.1)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: Colors.cyan.withOpacity(0.12),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                ev['value']!,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Colors.cyan,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                ev['desc']!,
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
  // SECTION 3: Basic Table
  // ============================================================
  print('=== Section 3: Basic ===');

  // Build a visual table example
  final tableHeaders = ['Name', 'Type', 'Status'];
  final tableData = <List<String>>[
    ['Widget A', 'Container', 'Active'],
    ['Widget B', 'Column', 'Deprecated'],
    ['Widget C', 'Row', 'Active'],
    ['Widget D', 'Stack', 'Beta'],
  ];

  final headerCells = <Widget>[];
  for (final h in tableHeaders) {
    headerCells.add(
      Container(
        padding: const EdgeInsets.all(10),
        color: Colors.cyan.withOpacity(0.15),
        child: Text(
          h,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
            color: Colors.cyan,
          ),
        ),
      ),
    );
  }

  final dataRowWidgets = <Widget>[];
  for (var r = 0; r < tableData.length; r++) {
    final row = tableData[r];
    print('Row ${r + 1}: ${row.join(', ')}');
    final cells = <Widget>[];
    for (var c = 0; c < row.length; c++) {
      cells.add(
        Container(
          padding: const EdgeInsets.all(10),
          color: r.isEven
              ? Colors.cyan.withOpacity(0.03)
              : Colors.transparent,
          child: Text(
            row[c],
            style: TextStyle(fontSize: 12, color: Colors.grey.shade800),
          ),
        ),
      );
    }
    dataRowWidgets.add(
      Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey.withOpacity(0.15)),
          ),
        ),
        child: Row(
          children: cells.map((c) => Expanded(child: c)).toList(),
        ),
      ),
    );
  }

  final basicTable = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.cyan.withOpacity(0.2)),
    ),
    clipBehavior: Clip.hardEdge,
    child: Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.cyan.withOpacity(0.3)),
            ),
          ),
          child: Row(
            children: headerCells.map((c) => Expanded(child: c)).toList(),
          ),
        ),
        ...dataRowWidgets,
      ],
    ),
  );

  // Code example
  final basicCode = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.cyan.withOpacity(0.04),
      borderRadius: BorderRadius.circular(8),
    ),
    child: const Text(
      'Table(\n'
      '  children: [\n'
      '    TableRow(\n'
      '      children: [\n'
      '        TableCell(\n'
      '          verticalAlignment:\n'
      '            TableCellVerticalAlignment.middle,\n'
      '          child: Text("Name"),\n'
      '        ),\n'
      '        TableCell(\n'
      '          child: Text("Value"),\n'
      '        ),\n'
      '      ],\n'
      '    ),\n'
      '  ],\n'
      ')',
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 10,
        color: Colors.cyan,
        height: 1.4,
      ),
    ),
  );

  // ============================================================
  // SECTION 4: Alignment Comparison
  // ============================================================
  print('=== Section 4: Alignment ===');

  final alignModes = <Map<String, dynamic>>[
    {
      'mode': 'top',
      'desc': 'Child sits at the top. Space below when other cells '
          'are taller. Natural reading position.',
      'position': Alignment.topCenter,
      'color': Colors.cyan,
    },
    {
      'mode': 'middle',
      'desc': 'Child centered vertically. Equal space above and below. '
          'Default alignment in most Table configurations.',
      'position': Alignment.center,
      'color': Colors.blue,
    },
    {
      'mode': 'bottom',
      'desc': 'Child at the bottom. Space above. Good for totals or '
          'footer content in a row.',
      'position': Alignment.bottomCenter,
      'color': Colors.green,
    },
    {
      'mode': 'fill',
      'desc': 'Child stretched to row height. Background colors extend '
          'fully. Child must handle being taller than intrinsic.',
      'position': Alignment.center,
      'color': Colors.orange,
    },
  ];

  final alignWidgets = <Widget>[];
  for (var i = 0; i < alignModes.length; i++) {
    final am = alignModes[i];
    final amColor = am['color'] as Color;
    final pos = am['position'] as Alignment;
    print('Align ${i + 1}: ${am['mode']}');

    alignWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: amColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: amColor.withOpacity(0.2)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: amColor.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      am['mode'] as String,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: amColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    am['desc'] as String,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade700,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            // Visual: cell with positioned content
            Container(
              width: 60,
              height: 70,
              decoration: BoxDecoration(
                border: Border.all(color: amColor.withOpacity(0.3)),
                borderRadius: BorderRadius.circular(6),
                color: amColor.withOpacity(0.02),
              ),
              child: Align(
                alignment: pos,
                child: Container(
                  height: am['mode'] == 'fill' ? 70.0 : 20.0,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: amColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Center(
                    child: Text(
                      'cell',
                      style: TextStyle(
                        fontSize: 9,
                        color: amColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 5: Cell Decoration
  // ============================================================
  print('=== Section 5: Decoration ===');

  final decoTopics = <Map<String, dynamic>>[
    {
      'title': 'Cell Background Color',
      'desc': 'Wrap the TableCell child in a Container with a color. '
          'Use TableCellVerticalAlignment.fill so the color extends '
          'to the full row height, not just the content height.',
      'code': 'TableCell(\n'
          '  verticalAlignment:\n'
          '    TableCellVerticalAlignment.fill,\n'
          '  child: Container(\n'
          '    color: Colors.blue.withOpacity(0.1),\n'
          '    padding: EdgeInsets.all(8),\n'
          '    child: Text("Colored cell"),\n'
          '  ),\n'
          ')',
      'color': Colors.cyan,
    },
    {
      'title': 'Cell with Border',
      'desc': 'Table provides border property for the entire grid. For '
          'per-cell borders, wrap individual children in Container '
          'with BoxDecoration. Combine with Table.border for clean lines.',
      'code': 'Table(\n'
          '  border: TableBorder.all(\n'
          '    color: Colors.grey.shade300,\n'
          '    width: 1,\n'
          '  ),\n'
          '  // cells get borders from Table.border\n'
          ')',
      'color': Colors.blue,
    },
    {
      'title': 'Alternating Row Colors',
      'desc': 'Apply decoration to the TableRow, not individual cells. '
          'TableRow.decoration controls the row-level background. '
          'This is more efficient than decorating each cell.',
      'code': 'TableRow(\n'
          '  decoration: BoxDecoration(\n'
          '    color: isEven\n'
          '      ? Colors.grey.shade50\n'
          '      : Colors.white,\n'
          '  ),\n'
          '  children: [...],\n'
          ')',
      'color': Colors.green,
    },
    {
      'title': 'Cell with Padding',
      'desc': 'Table does not have cell padding. Wrap each cell\'s content '
          'in Padding or a Container with padding. This is a common '
          'pattern for all Table implementations.',
      'code': 'TableCell(\n'
          '  child: Padding(\n'
          '    padding: EdgeInsets.symmetric(\n'
          '      horizontal: 12,\n'
          '      vertical: 8,\n'
          '    ),\n'
          '    child: Text("Padded"),\n'
          '  ),\n'
          ')',
      'color': Colors.orange,
    },
  ];

  final decoWidgets = <Widget>[];
  for (var i = 0; i < decoTopics.length; i++) {
    final dt = decoTopics[i];
    final dtColor = dt['color'] as Color;
    print('Deco ${i + 1}: ${dt['title']}');
    decoWidgets.add(
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
  // SECTION 6: Column Width
  // ============================================================
  print('=== Section 6: Column Width ===');

  final widthModes = <Map<String, dynamic>>[
    {
      'name': 'IntrinsicColumnWidth',
      'desc': 'Sizes columns to their widest child. Expensive because '
          'it measures every row. Use for small tables only.',
      'icon': Icons.compress,
      'color': Colors.cyan,
    },
    {
      'name': 'FlexColumnWidth',
      'desc': 'Distributes remaining space proportionally. Similar to '
          'Flexible in a Row. FlexColumnWidth(2) gets twice the '
          'space of FlexColumnWidth(1).',
      'icon': Icons.open_in_full,
      'color': Colors.blue,
    },
    {
      'name': 'FixedColumnWidth',
      'desc': 'A fixed pixel width. Predictable but not responsive. '
          'Content may overflow if text is larger than expected.',
      'icon': Icons.straighten,
      'color': Colors.green,
    },
    {
      'name': 'FractionColumnWidth',
      'desc': 'Width as a fraction of the Table width. '
          'FractionColumnWidth(0.3) takes 30% of the table. '
          'Useful for responsive proportional columns.',
      'icon': Icons.pie_chart,
      'color': Colors.orange,
    },
    {
      'name': 'MaxColumnWidth / MinColumnWidth',
      'desc': 'Composition of two width strategies with max or min. '
          'MaxColumnWidth(IntrinsicColumnWidth(), FixedColumnWidth(100)) '
          'ensures at least 100px wide.',
      'icon': Icons.compare_arrows,
      'color': Colors.purple,
    },
  ];

  final widthWidgets = <Widget>[];
  for (var i = 0; i < widthModes.length; i++) {
    final wm = widthModes[i];
    final wmColor = wm['color'] as Color;
    print('Width ${i + 1}: ${wm['name']}');
    widthWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: wmColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: wmColor.withOpacity(0.2)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: wmColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(wm['icon'] as IconData, color: wmColor, size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    wm['name'] as String,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: wmColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    wm['desc'] as String,
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
  // SECTION 7: Interaction
  // ============================================================
  print('=== Section 7: Interaction ===');

  final interactionTopics = <Map<String, dynamic>>[
    {
      'title': 'Tappable Cells',
      'desc': 'Wrap cell content in GestureDetector or InkWell for tap '
          'handling. InkWell needs a Material ancestor — wrap in Material '
          'if the cell doesn\'t have one from the Table context.',
      'color': Colors.cyan,
    },
    {
      'title': 'Selectable Text in Cells',
      'desc': 'Use SelectableText instead of Text for copyable cell '
          'content. Each cell can independently support text selection '
          'without affecting other cells in the row.',
      'color': Colors.blue,
    },
    {
      'title': 'Editable Cells',
      'desc': 'Replace text with TextField or TextFormField for inline '
          'editing. Use FocusNode to manage keyboard navigation '
          'between cells (Tab to advance, Shift+Tab to go back).',
      'color': Colors.green,
    },
    {
      'title': 'Checkbox / Switch Cells',
      'desc': 'Add Checkbox or Switch widgets in cells for toggle columns. '
          'Align them with TableCellVerticalAlignment.middle for '
          'visual consistency with adjacent text cells.',
      'color': Colors.orange,
    },
    {
      'title': 'Cell Context Menu',
      'desc': 'Use GestureDetector.onLongPress or right-click listener '
          'to show cell-specific context menus. Pass the cell\'s data '
          'to the menu handler for contextual actions.',
      'color': Colors.purple,
    },
  ];

  final interWidgets = <Widget>[];
  for (var i = 0; i < interactionTopics.length; i++) {
    final it = interactionTopics[i];
    final itColor = it['color'] as Color;
    print('Interact ${i + 1}: ${it['title']}');
    interWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: itColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: itColor.withOpacity(0.2)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: itColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(7),
              ),
              child: Center(
                child: Text(
                  '${i + 1}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: itColor,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    it['title'] as String,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: itColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    it['desc'] as String,
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
      'icon': Icons.grid_on,
      'text': 'TableCell controls per-cell vertical alignment within '
          'a Table widget\'s row.',
    },
    {
      'icon': Icons.vertical_align_center,
      'text': 'verticalAlignment overrides the Table default. Values: '
          'top, middle, bottom, baseline, fill, intrinsicHeight.',
    },
    {
      'icon': Icons.palette,
      'text': 'Use fill alignment with colored Containers for full-height '
          'cell backgrounds. Row decoration for alternating colors.',
    },
    {
      'icon': Icons.table_chart,
      'text': 'Column widths are controlled by Table.columnWidths, not '
          'TableCell. Use Flex, Fixed, Fraction, or Intrinsic widths.',
    },
    {
      'icon': Icons.touch_app,
      'text': 'Wrap cell children in GestureDetector/InkWell for tap, '
          'long-press, and context menu interactions.',
    },
    {
      'icon': Icons.compare_arrows,
      'text': 'For large data sets, consider DataTable or PaginatedDataTable '
          'instead of Table with manual TableCells.',
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
                color: Colors.cyan,
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
        title: const Text('TableCell'),
        backgroundColor: Colors.cyan,
        bottom: const TabBar(
          isScrollable: true,
          indicatorColor: Colors.white,
          tabs: [
            Tab(icon: Icon(Icons.info_outline), text: 'Concept'),
            Tab(icon: Icon(Icons.api), text: 'API'),
            Tab(icon: Icon(Icons.grid_on), text: 'Basic'),
            Tab(icon: Icon(Icons.vertical_align_center), text: 'Align'),
            Tab(icon: Icon(Icons.palette), text: 'Decor'),
            Tab(icon: Icon(Icons.view_column), text: 'Widths'),
            Tab(icon: Icon(Icons.touch_app), text: 'Interact'),
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
                  'TableCell: per-cell vertical alignment control for '
                  'Table layouts in Flutter.',
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
                  color: Colors.cyan.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Properties and TableCellVerticalAlignment values.',
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
                  color: Colors.cyan.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'A basic table demonstrating cells with header and data rows.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              basicTable,
              basicCode,
            ],
          ),

          // Tab 4: Alignment
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
                  'Visual comparison of vertical alignment modes in cells.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...alignWidgets,
            ],
          ),

          // Tab 5: Decoration
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
                  'Styling cells with backgrounds, borders, padding, '
                  'and alternating row colors.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...decoWidgets,
            ],
          ),

          // Tab 6: Column Width
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
                  'Column width strategies that affect how cells are '
                  'sized horizontally within the Table.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...widthWidgets,
            ],
          ),

          // Tab 7: Interaction
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
                  'Adding tap, selection, editing, and context menu '
                  'interactions to table cells.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...interWidgets,
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
                  'Key takeaways about TableCell.',
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
