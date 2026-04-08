// ignore_for_file: avoid_print
// Deep demo: TableCellParentData
// Demonstrates the TableCellParentData class that stores per-cell
// vertical alignment for children of the Table/RenderTable widget.
import 'package:flutter/material.dart';

// ─── palette: Deep Purple / Lavender ──────────────────────────────
const Color _tcPurple = Color(0xFF4A148C);
const Color _tcLavender = Color(0xFFEDE7F6);
const Color _tcAccent = Color(0xFF7C4DFF);
const Color _tcDark = Color(0xFF212121);
const Color _tcGood = Color(0xFF2E7D32);
const Color _tcWarn = Color(0xFFE65100);
const Color _tcBlue = Color(0xFF1565C0);
const Color _tcTeal = Color(0xFF00796B);

// ─── text helpers ─────────────────────────────────────────────────
Widget _tcTitle(String t) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Text(t,
          style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: _tcPurple,
              letterSpacing: 0.3)),
    );

Widget _tcSubtitle(String t) => Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 4),
      child: Text(t,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.w700, color: _tcAccent)),
    );

Widget _tcBody(String t) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Text(t,
          style: const TextStyle(
              fontSize: 13.5, color: Colors.black87, height: 1.45)),
    );

Widget _tcCode(String t) => Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _tcDark,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(t,
          style: const TextStyle(
              fontSize: 12,
              fontFamily: 'monospace',
              color: Color(0xFFCE93D8),
              height: 1.5)),
    );

Widget _tcNote(String t) => Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _tcLavender,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _tcPurple.withValues(alpha: 0.25)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 8, top: 1),
            child: Icon(Icons.info_outline, size: 16, color: _tcPurple),
          ),
          Expanded(
            child: Text(t,
                style: const TextStyle(
                    fontSize: 12.5, color: _tcPurple, height: 1.4)),
          ),
        ],
      ),
    );

Widget _tcDivider() => Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Container(height: 1, color: _tcPurple.withValues(alpha: 0.12)),
    );

Widget _tcBullet(String label, String desc) => Padding(
      padding: const EdgeInsets.only(left: 12, top: 3, bottom: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.only(top: 6, right: 8),
            decoration:
                const BoxDecoration(color: _tcAccent, shape: BoxShape.circle),
          ),
          Expanded(
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: '$label: ',
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87)),
                TextSpan(
                    text: desc,
                    style: const TextStyle(
                        fontSize: 13, color: Colors.black87)),
              ]),
            ),
          ),
        ],
      ),
    );

Widget _tcTag(String t, Color bg, [Color fg = Colors.white]) => Container(
      margin: const EdgeInsets.only(right: 6, bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(t,
          style: TextStyle(
              fontSize: 10, fontWeight: FontWeight.w700, color: fg)),
    );

Widget _tcLabel(String t) => Text(t,
    style: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: _tcPurple,
        letterSpacing: 0.2));

Widget _tcSmall(String t) => Text(t,
    style: const TextStyle(fontSize: 10.5, color: Colors.black54));

// ─── visual building blocks ───────────────────────────────────────

/// A row of table cells with alignment indicators.
Widget _tcTableRow(
    List<_TcCellDef> cells, double rowHeight, String rowLabel) {
  return Container(
    margin: const EdgeInsets.only(bottom: 2),
    child: Row(
      children: [
        SizedBox(
          width: 40,
          child: Text(rowLabel,
              style: const TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                  color: _tcPurple)),
        ),
        ...cells.map((c) => Expanded(
              child: Container(
                height: rowHeight,
                margin: const EdgeInsets.symmetric(horizontal: 1),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  border: Border.all(
                      color: _tcPurple.withValues(alpha: 0.2), width: 0.5),
                ),
                child: _tcAlignedCell(c, rowHeight),
              ),
            )),
      ],
    ),
  );
}

Widget _tcAlignedCell(_TcCellDef c, double rowHeight) {
  Alignment align;
  switch (c.vAlign) {
    case 'top':
      align = Alignment.topCenter;
    case 'bottom':
      align = Alignment.bottomCenter;
    case 'middle':
      align = Alignment.center;
    case 'baseline':
      align = const Alignment(0, -0.3);
    case 'fill':
      return Container(
        color: c.color.withValues(alpha: 0.7),
        child: Center(
          child: Text(c.label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 8,
                  fontWeight: FontWeight.w700,
                  color: Colors.white)),
        ),
      );
    default:
      align = Alignment.center;
  }
  return Align(
    alignment: align,
    child: Container(
      height: c.cellHeight,
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: c.color.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3),
          child: Text(c.label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 8,
                  fontWeight: FontWeight.w700,
                  color: Colors.white)),
        ),
      ),
    ),
  );
}

class _TcCellDef {
  final String label;
  final String vAlign;
  final Color color;
  final double cellHeight;
  const _TcCellDef(this.label, this.vAlign, this.color, this.cellHeight);
}

/// A class hierarchy box.
Widget _tcHierBox(String name, Color bg, {bool highlight = false}) =>
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
        border: highlight
            ? Border.all(color: _tcPurple, width: 2)
            : Border.all(color: bg),
      ),
      child: Text(name,
          style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: highlight ? _tcPurple : Colors.white)),
    );

Widget _tcArrow() => const Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Icon(Icons.arrow_downward, size: 16, color: _tcAccent),
    );

// ─── §1 Title banner ─────────────────────────────────────────────
Widget _tcBanner() => Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [_tcPurple, Color(0xFF6A1B9A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
              color: Color(0x40000000),
              blurRadius: 12,
              offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        children: [
          const Icon(Icons.table_chart_outlined, size: 48, color: _tcLavender),
          const SizedBox(height: 10),
          const Text('TableCellParentData',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: 0.5)),
          const SizedBox(height: 6),
          Text('Per-cell vertical alignment for Table children',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 13,
                  color: Colors.white.withValues(alpha: 0.85))),
          const SizedBox(height: 12),
          Wrap(
            alignment: WrapAlignment.center,
            children: [
              _tcTag('rendering', _tcAccent),
              _tcTag('parent data', _tcBlue),
              _tcTag('table layout', _tcTeal),
            ],
          ),
        ],
      ),
    );

// ─── §2 What is TableCellParentData? ─────────────────────────────
List<Widget> _tcWhatIs() => [
      _tcTitle('§2  What Is TableCellParentData?'),
      _tcBody(
          'TableCellParentData is a ParentData subclass that extends '
          'BoxParentData. It is attached to each child of a RenderTable '
          '(the render object behind the Table widget).'),
      _tcBody(
          'Its primary purpose is to store a per-cell verticalAlignment '
          'property. This allows individual table cells to override the '
          'default table-level vertical alignment.'),
      _tcCode(
          'class TableCellParentData extends BoxParentData {\n'
          '  TableCellVerticalAlignment? verticalAlignment;\n'
          '}'),
      _tcNote(
          'BoxParentData provides an offset field (the position of the '
          'child). TableCellParentData adds the verticalAlignment on top '
          'of that.'),
    ];

// ─── §3 Class hierarchy ──────────────────────────────────────────
List<Widget> _tcHierarchy() => [
      _tcDivider(),
      _tcTitle('§3  Class Hierarchy'),
      _tcBody(
          'TableCellParentData sits in the ParentData hierarchy, adding '
          'only one field to BoxParentData:'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _tcLavender,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            _tcHierBox('ParentData', Colors.grey),
            _tcArrow(),
            _tcHierBox('BoxParentData', _tcBlue),
            _tcArrow(),
            _tcHierBox('TableCellParentData', _tcLavender,
                highlight: true),
          ],
        ),
      ),
      _tcSubtitle('What each level provides'),
      _tcBullet('ParentData',
          'Base class — marker for parent-specific data on a child'),
      _tcBullet('BoxParentData',
          'Adds Offset offset — position within the parent box'),
      _tcBullet('TableCellParentData',
          'Adds TableCellVerticalAlignment? verticalAlignment — per-cell '
          'alignment override'),
    ];

// ─── §4 The verticalAlignment field ──────────────────────────────
List<Widget> _tcField() => [
      _tcDivider(),
      _tcTitle('§4  The verticalAlignment Field'),
      _tcBody(
          'The single field added by TableCellParentData is a nullable '
          'TableCellVerticalAlignment. When null, the cell uses the '
          'Table default. When set, it overrides for that cell only.'),
      _tcCode(
          'TableCellVerticalAlignment? verticalAlignment;\n'
          '\n'
          '// Possible values:\n'
          '//   top          - align to top of row\n'
          '//   middle       - center vertically in row\n'
          '//   bottom       - align to bottom of row\n'
          '//   baseline     - align to text baseline\n'
          '//   fill         - stretch to fill row height\n'
          '//   intrinsicHeight - use intrinsic height'),
      _tcSubtitle('Nullable semantics'),
      _tcBody(
          'null means "use the table default" (set via '
          'Table.defaultVerticalAlignment). Any non-null value overrides '
          'the default for that specific cell.'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _tcLavender,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _tcFieldRow('Value', 'Behavior', isHeader: true),
            _tcFieldRow('null', 'Uses Table.defaultVerticalAlignment'),
            _tcFieldRow('top', 'Cell content at top of row'),
            _tcFieldRow('middle', 'Cell content centered vertically'),
            _tcFieldRow('bottom', 'Cell content at bottom of row'),
            _tcFieldRow('baseline', 'Align to text baseline'),
            _tcFieldRow('fill', 'Stretch to fill row height'),
          ],
        ),
      ),
    ];

Widget _tcFieldRow(String val, String behavior, {bool isHeader = false}) {
  final style = TextStyle(
    fontSize: 11,
    fontWeight: isHeader ? FontWeight.w700 : FontWeight.w400,
    color: isHeader ? _tcPurple : Colors.black87,
  );
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      children: [
        SizedBox(
            width: 90, child: Text(val, style: style)),
        Expanded(child: Text(behavior, style: style)),
      ],
    ),
  );
}

// ─── §5 How TableCell sets parentData ────────────────────────────
List<Widget> _tcTableCell() => [
      _tcDivider(),
      _tcTitle('§5  How TableCell Sets parentData'),
      _tcBody(
          'In the widget tree, you use TableCell to wrap a child and '
          'specify its vertical alignment. TableCell is a ParentDataWidget '
          'that writes the alignment into the TableCellParentData:'),
      _tcCode(
          'class TableCell extends ParentDataWidget<TableCellParentData> {\n'
          '  final TableCellVerticalAlignment? verticalAlignment;\n'
          '\n'
          '  @override\n'
          '  void applyParentData(RenderObject renderObject) {\n'
          '    final parentData =\n'
          '        renderObject.parentData as TableCellParentData;\n'
          '    if (parentData.verticalAlignment != verticalAlignment) {\n'
          '      parentData.verticalAlignment = verticalAlignment;\n'
          '      // Triggers relayout of the parent RenderTable\n'
          '    }\n'
          '  }\n'
          '}'),
      _tcBody('Usage in a Table widget:'),
      _tcCode(
          'Table(\n'
          '  defaultVerticalAlignment:\n'
          '      TableCellVerticalAlignment.middle,\n'
          '  children: [\n'
          '    TableRow(children: [\n'
          '      // Uses default (middle)\n'
          '      Text("Cell 1"),\n'
          '      // Overrides to top\n'
          '      TableCell(\n'
          '        verticalAlignment:\n'
          '            TableCellVerticalAlignment.top,\n'
          '        child: Text("Cell 2"),\n'
          '      ),\n'
          '    ]),\n'
          '  ],\n'
          ')'),
      _tcNote(
          'TableCell is the ONLY way to set per-cell alignment from the '
          'widget layer. It writes directly to the parentData slot.'),
    ];

// ─── §6 Table layout flow with verticalAlignment ─────────────────
List<Widget> _tcLayoutFlow() => [
      _tcDivider(),
      _tcTitle('§6  Table Layout Flow'),
      _tcBody(
          'During performLayout, RenderTable reads the verticalAlignment '
          'from each child parentData to decide positioning:'),
      _tcCode(
          'void performLayout() {\n'
          '  // 1. Compute column widths\n'
          '  // 2. Layout each cell to determine intrinsic heights\n'
          '  // 3. Compute row heights (max cell height per row)\n'
          '  // 4. For each cell:\n'
          '  final pd = child.parentData as TableCellParentData;\n'
          '  final alignment = pd.verticalAlignment\n'
          '      ?? defaultVerticalAlignment;\n'
          '  switch (alignment) {\n'
          '    case top:    pd.offset = Offset(x, rowY);\n'
          '    case middle: pd.offset = Offset(x, rowY + dy/2);\n'
          '    case bottom: pd.offset = Offset(x, rowY + dy);\n'
          '    case fill:   // relayout child with tight height\n'
          '    case baseline: // align to baseline\n'
          '  }\n'
          '}'),
      _tcSubtitle('Layout sequence'),
      _tcBullet('Step 1', 'Compute column widths from ColumnWidth specs'),
      _tcBullet('Step 2', 'Layout all cells with column width; get heights'),
      _tcBullet('Step 3', 'Row height = max cell height within the row'),
      _tcBullet('Step 4',
          'Read verticalAlignment from parentData; position cell'),
      _tcBullet('Step 5',
          'If alignment is fill, relayout cell with tight row height'),
    ];

// ─── §7 Visual: row with mixed alignments ────────────────────────
List<Widget> _tcMixedRow() => [
      _tcDivider(),
      _tcTitle('§7  Visual: Row With Mixed Alignments'),
      _tcBody(
          'A single table row where each cell has a different vertical '
          'alignment, showing how children position within the row:'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _tcLavender,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _tcLabel('Row height: 80px'),
            const SizedBox(height: 6),
            // Column headers
            Row(
              children: [
                const SizedBox(width: 40),
                ...['top', 'middle', 'bottom', 'fill', 'baseline']
                    .map((a) => Expanded(
                          child: Center(
                            child: Text(a,
                                style: const TextStyle(
                                    fontSize: 8,
                                    fontWeight: FontWeight.w700,
                                    color: _tcPurple)),
                          ),
                        )),
              ],
            ),
            const SizedBox(height: 4),
            _tcTableRow([
              const _TcCellDef('top\n30px', 'top', _tcPurple, 30),
              const _TcCellDef('mid\n25px', 'middle', _tcAccent, 25),
              const _TcCellDef('bot\n35px', 'bottom', _tcBlue, 35),
              const _TcCellDef('fill\n80px', 'fill', _tcTeal, 80),
              const _TcCellDef('base\n20px', 'baseline', _tcWarn, 20),
            ], 80, 'Row 1'),
          ],
        ),
      ),
      _tcSmall(
          'Each cell positions differently within the same 80px row'),
      _tcBody(
          'The row height (80px) is determined by the tallest cell before '
          'fill is applied. Then each cell is positioned based on its '
          'verticalAlignment from the parentData.'),
    ];

// ─── §8 Default vs per-cell alignment ────────────────────────────
List<Widget> _tcDefaultVsCell() => [
      _tcDivider(),
      _tcTitle('§8  Default vs Per-Cell Alignment'),
      _tcBody(
          'The Table has a defaultVerticalAlignment property. Each cell '
          'can override it using TableCell. Here is the priority:'),
      _tcCode(
          '// Priority:\n'
          '// 1. TableCellParentData.verticalAlignment (per-cell)\n'
          '// 2. Table.defaultVerticalAlignment (table-wide default)\n'
          '\n'
          'final alignment = parentData.verticalAlignment\n'
          '    ?? table.defaultVerticalAlignment;'),
      _tcSubtitle('Visual: default=middle, some cells override'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _tcLavender,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _tcLabel('Default: middle | Per-cell: varies'),
            const SizedBox(height: 6),
            Row(
              children: [
                const SizedBox(width: 40),
                ...['default\n(middle)', 'top\noverride', 'default\n(middle)',
                    'bottom\noverride']
                    .map((h) => Expanded(
                          child: Center(
                            child: Text(h,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 7,
                                    fontWeight: FontWeight.w700,
                                    color: _tcPurple)),
                          ),
                        )),
              ],
            ),
            const SizedBox(height: 4),
            _tcTableRow([
              const _TcCellDef('mid\n(def)', 'middle', _tcAccent, 24),
              const _TcCellDef('top\n(ovr)', 'top', _tcPurple, 24),
              const _TcCellDef('mid\n(def)', 'middle', _tcAccent, 30),
              const _TcCellDef('bot\n(ovr)', 'bottom', _tcPurple, 24),
            ], 60, 'Row 1'),
            const SizedBox(height: 2),
            _tcTableRow([
              const _TcCellDef('mid\n(def)', 'middle', _tcAccent, 20),
              const _TcCellDef('mid\n(def)', 'middle', _tcAccent, 28),
              const _TcCellDef('fill\n(ovr)', 'fill', _tcTeal, 60),
              const _TcCellDef('mid\n(def)', 'middle', _tcAccent, 22),
            ], 60, 'Row 2'),
          ],
        ),
      ),
      _tcSmall('(def) = uses Table default, (ovr) = per-cell override'),
      _tcNote(
          'The common pattern: set a sensible default on the Table, then '
          'override only the cells that need special alignment.'),
    ];

// ─── §9 Who creates & reads this data ────────────────────────────
List<Widget> _tcCreators() => [
      _tcDivider(),
      _tcTitle('§9  Who Creates and Reads This Data'),
      _tcSubtitle('Creation'),
      _tcBody(
          'RenderTable.setupParentData() creates a TableCellParentData '
          'for each child:'),
      _tcCode(
          '@override\n'
          'void setupParentData(RenderObject child) {\n'
          '  if (child.parentData is! TableCellParentData) {\n'
          '    child.parentData = TableCellParentData();\n'
          '  }\n'
          '}'),
      _tcSubtitle('Writing'),
      _tcBody(
          'TableCell.applyParentData() writes the verticalAlignment:'),
      _tcCode(
          'void applyParentData(RenderObject renderObject) {\n'
          '  final pd = renderObject.parentData\n'
          '      as TableCellParentData;\n'
          '  pd.verticalAlignment = verticalAlignment;\n'
          '  // Mark parent as needing layout\n'
          '}'),
      _tcSubtitle('Reading'),
      _tcBody(
          'RenderTable.performLayout() reads the verticalAlignment '
          'during the positioning phase to decide where to place each cell:'),
      _tcCode(
          'final pd = child.parentData as TableCellParentData;\n'
          'final cellAlign = pd.verticalAlignment\n'
          '    ?? defaultVerticalAlignment;\n'
          '// Use cellAlign to compute pd.offset'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _tcLavender,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _tcLabel('Data flow'),
            const SizedBox(height: 8),
            _tcFlowRow('RenderTable', 'creates', 'TableCellParentData'),
            _tcFlowRow('TableCell', 'writes', 'verticalAlignment'),
            _tcFlowRow('RenderTable', 'reads', 'verticalAlignment'),
            _tcFlowRow('RenderTable', 'writes', 'offset (position)'),
          ],
        ),
      ),
    ];

Widget _tcFlowRow(String actor, String action, String target) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(actor,
                style: const TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                    color: _tcPurple)),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            margin: const EdgeInsets.symmetric(horizontal: 6),
            decoration: BoxDecoration(
              color: _tcAccent.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(action,
                style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: _tcAccent)),
          ),
          Expanded(
            child: Text(target,
                style: const TextStyle(
                    fontSize: 10.5,
                    color: Colors.black87,
                    fontFamily: 'monospace')),
          ),
        ],
      ),
    );

// ─── §10 Comparison with other ParentData ────────────────────────
List<Widget> _tcComparison() => [
      _tcDivider(),
      _tcTitle('§10  Comparison With Other ParentData'),
      _tcBody(
          'How TableCellParentData relates to other parent data classes:'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _tcLavender,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _tcCmpRow('Class', 'Fields', 'Used By', isHeader: true),
            _tcCmpRow('BoxParentData', 'offset', 'RenderBox'),
            _tcCmpRow('FlexParentData', 'flex, fit', 'Flex/Row/Column'),
            _tcCmpRow('StackParentData', 'top,left...', 'RenderStack'),
            _tcCmpRow('TableCellPD',
                'verticalAlignment', 'RenderTable'),
            _tcCmpRow('SliverPhysicalPD', 'paintOffset', 'Slivers'),
          ],
        ),
      ),
      _tcSubtitle('Key differences'),
      _tcBullet('BoxParentData',
          'Only stores position (offset). No layout hints.'),
      _tcBullet('FlexParentData',
          'Stores flex factor and FlexFit. Affects size allocation.'),
      _tcBullet('StackParentData',
          'Stores positional constraints (left, top, width, height).'),
      _tcBullet('TableCellParentData',
          'Stores only verticalAlignment. Affects vertical positioning '
          'within a row, not sizing.'),
      _tcNote(
          'TableCellParentData is one of the simplest ParentData subclasses — '
          'it adds just a single nullable field to BoxParentData.'),
    ];

Widget _tcCmpRow(String cls, String fields, String usedBy,
    {bool isHeader = false}) {
  final style = TextStyle(
    fontSize: 10,
    fontWeight: isHeader ? FontWeight.w700 : FontWeight.w400,
    color: isHeader ? _tcPurple : Colors.black87,
  );
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      children: [
        SizedBox(width: 100, child: Text(cls, style: style)),
        Expanded(child: Text(fields, style: style)),
        SizedBox(width: 80, child: Text(usedBy, style: style)),
      ],
    ),
  );
}

// ─── §11 Summary ─────────────────────────────────────────────────
List<Widget> _tcSummary() => [
      _tcDivider(),
      _tcTitle('§11  Summary'),
      _tcBody(
          'TableCellParentData is a focused ParentData class that enables '
          'per-cell vertical alignment override in Table widgets. It bridges '
          'the gap between the Table widget default and individual cell needs.'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              _tcPurple.withValues(alpha: 0.08),
              _tcLavender,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _tcPurple.withValues(alpha: 0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Key takeaways',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: _tcPurple)),
            const SizedBox(height: 10),
            _tcSumPt('Extends BoxParentData',
                'Inherits offset, adds verticalAlignment'),
            _tcSumPt('Single field',
                'TableCellVerticalAlignment? verticalAlignment'),
            _tcSumPt('Null = default',
                'Falls back to Table.defaultVerticalAlignment'),
            _tcSumPt('TableCell writes it',
                'ParentDataWidget sets verticalAlignment'),
            _tcSumPt('RenderTable reads it',
                'Uses alignment during performLayout'),
            _tcSumPt('Values',
                'top, middle, bottom, baseline, fill, intrinsicHeight'),
          ],
        ),
      ),
      const SizedBox(height: 20),
      Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: _tcPurple,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text('End of TableCellParentData Deep Demo',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: 0.3)),
        ),
      ),
      const SizedBox(height: 24),
    ];

Widget _tcSumPt(String label, String desc) => Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 4, right: 8),
            child: Icon(Icons.check_circle, size: 14, color: _tcGood),
          ),
          Expanded(
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: '$label — ',
                    style: const TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                        color: _tcPurple)),
                TextSpan(
                    text: desc,
                    style: const TextStyle(
                        fontSize: 12.5, color: Colors.black87)),
              ]),
            ),
          ),
        ],
      ),
    );

// ═══════════════════════════════════════════════════════════════════
// ENTRY POINT
// ═══════════════════════════════════════════════════════════════════
dynamic build(BuildContext context) {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _tcBanner(),
        const SizedBox(height: 20),
        ..._tcWhatIs(),
        ..._tcHierarchy(),
        ..._tcField(),
        ..._tcTableCell(),
        ..._tcLayoutFlow(),
        ..._tcMixedRow(),
        ..._tcDefaultVsCell(),
        ..._tcCreators(),
        ..._tcComparison(),
        ..._tcSummary(),
      ],
    ),
  );
}
