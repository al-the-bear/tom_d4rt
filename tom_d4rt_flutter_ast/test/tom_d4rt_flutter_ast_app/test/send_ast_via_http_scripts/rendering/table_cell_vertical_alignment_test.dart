// ignore_for_file: avoid_print
// Deep demo: TableCellVerticalAlignment
// Demonstrates the TableCellVerticalAlignment enum that controls how
// cells are positioned vertically within a Table row.
import 'package:flutter/material.dart';

// ─── palette: Amber / Light Amber ─────────────────────────────────
const Color _vaAmber = Color(0xFFFF6F00);
const Color _vaLight = Color(0xFFFFF8E1);
const Color _vaAccent = Color(0xFFFFA000);
const Color _vaDark = Color(0xFF212121);
const Color _vaGood = Color(0xFF2E7D32);
const Color _vaBlue = Color(0xFF1565C0);
const Color _vaPurple = Color(0xFF6A1B9A);
const Color _vaTeal = Color(0xFF00796B);

// ─── text helpers ─────────────────────────────────────────────────
Widget _vaTitle(String t) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Text(t,
          style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: _vaAmber,
              letterSpacing: 0.3)),
    );

Widget _vaSubtitle(String t) => Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 4),
      child: Text(t,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.w700, color: _vaAccent)),
    );

Widget _vaBody(String t) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Text(t,
          style: const TextStyle(
              fontSize: 13.5, color: Colors.black87, height: 1.45)),
    );

Widget _vaCode(String t) => Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _vaDark,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(t,
          style: const TextStyle(
              fontSize: 12,
              fontFamily: 'monospace',
              color: Color(0xFFFFD54F),
              height: 1.5)),
    );

Widget _vaNote(String t) => Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _vaLight,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _vaAmber.withValues(alpha: 0.25)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 8, top: 1),
            child: Icon(Icons.info_outline, size: 16, color: _vaAmber),
          ),
          Expanded(
            child: Text(t,
                style: const TextStyle(
                    fontSize: 12.5, color: _vaAmber, height: 1.4)),
          ),
        ],
      ),
    );

Widget _vaDivider() => Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Container(height: 1, color: _vaAmber.withValues(alpha: 0.12)),
    );

Widget _vaBullet(String label, String desc) => Padding(
      padding: const EdgeInsets.only(left: 12, top: 3, bottom: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.only(top: 6, right: 8),
            decoration:
                const BoxDecoration(color: _vaAccent, shape: BoxShape.circle),
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

Widget _vaTag(String t, Color bg, [Color fg = Colors.white]) => Container(
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

Widget _vaLabel(String t) => Text(t,
    style: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: _vaAmber,
        letterSpacing: 0.2));

Widget _vaSmall(String t) => Text(t,
    style: const TextStyle(fontSize: 10.5, color: Colors.black54));

// ─── visual cell builder ──────────────────────────────────────────

/// A mock table row showing a cell aligned at a given vertical position.
Widget _vaCellDisplay(String alignName, Alignment align, Color cellColor,
    double cellH, double rowH,
    {bool isFill = false}) {
  return Container(
    width: double.infinity,
    height: rowH,
    margin: const EdgeInsets.symmetric(vertical: 4),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _vaAmber.withValues(alpha: 0.2)),
    ),
    child: Stack(
      children: [
        // Row height indicator
        Positioned(
          right: 4,
          top: 2,
          child: Text('row: ${rowH.toInt()}px',
              style: TextStyle(
                  fontSize: 8,
                  color: Colors.grey.shade500,
                  fontFamily: 'monospace')),
        ),
        // The aligned cell
        Align(
          alignment: align,
          child: Container(
            width: isFill ? double.infinity : 140,
            height: isFill ? rowH : cellH,
            margin: isFill
                ? EdgeInsets.zero
                : const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: cellColor.withValues(alpha: 0.85),
              borderRadius: isFill
                  ? BorderRadius.zero
                  : BorderRadius.circular(6),
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(alignName,
                      style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          color: Colors.white)),
                  if (!isFill)
                    Text('${cellH.toInt()}px',
                        style: TextStyle(
                            fontSize: 9,
                            color: Colors.white.withValues(alpha: 0.8))),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

/// A compact multi-cell row for side-by-side comparison.
Widget _vaCompactCell(
    String label, Alignment align, Color c, double ch, double rh,
    {bool fill = false}) {
  return Container(
    height: rh,
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      border: Border.all(color: _vaAmber.withValues(alpha: 0.15)),
    ),
    child: Stack(
      children: [
        Align(
          alignment: align,
          child: Container(
            width: double.infinity,
            height: fill ? rh : ch,
            margin: fill ? EdgeInsets.zero : const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: c.withValues(alpha: 0.8),
              borderRadius:
                  fill ? BorderRadius.zero : BorderRadius.circular(4),
            ),
            child: Center(
              child: Text(label,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.w700,
                      color: Colors.white)),
            ),
          ),
        ),
      ],
    ),
  );
}

// ─── §1 Title banner ─────────────────────────────────────────────
Widget _vaBanner() => Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [_vaAmber, Color(0xFFF57C00)],
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
          const Icon(Icons.vertical_align_center, size: 48, color: _vaLight),
          const SizedBox(height: 10),
          const Text('TableCellVerticalAlignment',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: 0.5)),
          const SizedBox(height: 6),
          Text('How cells sit vertically inside table rows',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 13,
                  color: Colors.white.withValues(alpha: 0.85))),
          const SizedBox(height: 12),
          Wrap(
            alignment: WrapAlignment.center,
            children: [
              _vaTag('rendering', _vaAccent),
              _vaTag('enum', _vaBlue),
              _vaTag('table layout', _vaTeal),
            ],
          ),
        ],
      ),
    );

// ─── §2 What is it? ──────────────────────────────────────────────
List<Widget> _vaWhatIs() => [
      _vaTitle('§2  What Is TableCellVerticalAlignment?'),
      _vaBody(
          'TableCellVerticalAlignment is an enum that determines how the '
          'content of a table cell is positioned vertically within its row. '
          'Since rows can have cells of different heights, this controls '
          'where shorter cells sit relative to the tallest cell.'),
      _vaCode(
          'enum TableCellVerticalAlignment {\n'
          '  top,              // align to top edge of row\n'
          '  middle,           // center vertically in row\n'
          '  bottom,           // align to bottom edge of row\n'
          '  baseline,         // align to text baseline\n'
          '  fill,             // stretch to fill row height\n'
          '  intrinsicHeight,  // use child intrinsic height\n'
          '}'),
      _vaBody(
          'It is used in two places: as the Table.defaultVerticalAlignment '
          '(table-wide default), and per-cell via TableCell.verticalAlignment '
          '(stored in TableCellParentData).'),
    ];

// ─── §3 All six values explained ─────────────────────────────────
List<Widget> _vaEnumValues() => [
      _vaDivider(),
      _vaTitle('§3  All Six Enum Values'),
      _vaSubtitle('top'),
      _vaBody(
          'The top edge of the cell content aligns with the top edge of '
          'the row. Extra space is below the content.'),
      _vaBullet('Offset', 'y = rowTop'),
      _vaSubtitle('middle'),
      _vaBody(
          'The cell content is centered vertically. Equal space above '
          'and below.'),
      _vaBullet('Offset', 'y = rowTop + (rowHeight - cellHeight) / 2'),
      _vaSubtitle('bottom'),
      _vaBody(
          'The bottom edge of the cell content aligns with the bottom '
          'edge of the row. Extra space is above.'),
      _vaBullet('Offset', 'y = rowTop + rowHeight - cellHeight'),
      _vaSubtitle('baseline'),
      _vaBody(
          'The text baseline of each cell is aligned. Requires a '
          'textBaseline parameter on the Table. Useful for aligning '
          'text of different sizes.'),
      _vaBullet('Offset', 'Calculated from alphabetic/ideographic baseline'),
      _vaSubtitle('fill'),
      _vaBody(
          'The cell is forced to fill the entire row height via tight '
          'constraints. The content stretches vertically.'),
      _vaBullet('Offset', 'y = rowTop, height = rowHeight'),
      _vaSubtitle('intrinsicHeight'),
      _vaBody(
          'The cell is sized to its intrinsic height and positioned at '
          'the top. Unlike fill, it does not stretch.'),
      _vaBullet('Behavior', 'Uses getMaxIntrinsicHeight for sizing'),
      _vaNote(
          'The default value for Table.defaultVerticalAlignment is '
          'TableCellVerticalAlignment.top. Most tables use top or middle.'),
    ];

// ─── §4 Visual: top alignment ────────────────────────────────────
List<Widget> _vaTopVisual() => [
      _vaDivider(),
      _vaTitle('§4  Visual: Top Alignment'),
      _vaBody(
          'Cell content is pinned to the top of the row. The remaining '
          'space is below:'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _vaLight,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            _vaLabel('TableCellVerticalAlignment.top'),
            const SizedBox(height: 8),
            _vaCellDisplay(
                'top', Alignment.topCenter, _vaAmber, 35, 80),
            _vaCellDisplay(
                'top', Alignment.topCenter, _vaAccent, 50, 80),
          ],
        ),
      ),
      _vaCode(
          'Table(\n'
          '  defaultVerticalAlignment:\n'
          '      TableCellVerticalAlignment.top,\n'
          '  children: [\n'
          '    TableRow(children: [\n'
          '      Container(height: 35, color: amber),\n'
          '      Container(height: 50, color: gold),\n'
          '      Container(height: 80, color: orange), // tallest\n'
          '    ]),\n'
          '  ],\n'
          ')'),
      _vaSmall('Shorter cells align top, leaving space at the bottom'),
    ];

// ─── §5 Visual: middle alignment ─────────────────────────────────
List<Widget> _vaMiddleVisual() => [
      _vaDivider(),
      _vaTitle('§5  Visual: Middle Alignment'),
      _vaBody(
          'Cell content is centered vertically in the row. Equal padding '
          'above and below:'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _vaLight,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            _vaLabel('TableCellVerticalAlignment.middle'),
            const SizedBox(height: 8),
            _vaCellDisplay(
                'middle', Alignment.center, _vaBlue, 35, 80),
            _vaCellDisplay(
                'middle', Alignment.center, _vaPurple, 50, 80),
          ],
        ),
      ),
      _vaCode(
          'Table(\n'
          '  defaultVerticalAlignment:\n'
          '      TableCellVerticalAlignment.middle,\n'
          '  children: [\n'
          '    TableRow(children: [\n'
          '      Container(height: 35, color: blue),   // centered\n'
          '      Container(height: 50, color: purple), // centered\n'
          '      Container(height: 80, color: teal),   // tallest\n'
          '    ]),\n'
          '  ],\n'
          ')'),
      _vaSmall('Shorter cells centered — equal space top and bottom'),
    ];

// ─── §6 Visual: bottom alignment ─────────────────────────────────
List<Widget> _vaBottomVisual() => [
      _vaDivider(),
      _vaTitle('§6  Visual: Bottom Alignment'),
      _vaBody(
          'Cell content is pinned to the bottom of the row. Extra space '
          'is above:'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _vaLight,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            _vaLabel('TableCellVerticalAlignment.bottom'),
            const SizedBox(height: 8),
            _vaCellDisplay(
                'bottom', Alignment.bottomCenter, _vaTeal, 35, 80),
            _vaCellDisplay(
                'bottom', Alignment.bottomCenter, _vaGood, 50, 80),
          ],
        ),
      ),
      _vaCode(
          'Table(\n'
          '  defaultVerticalAlignment:\n'
          '      TableCellVerticalAlignment.bottom,\n'
          '  children: [\n'
          '    TableRow(children: [\n'
          '      Container(height: 35, color: teal),   // at bottom\n'
          '      Container(height: 50, color: green),  // at bottom\n'
          '      Container(height: 80, color: amber),  // tallest\n'
          '    ]),\n'
          '  ],\n'
          ')'),
      _vaSmall('Shorter cells flush with the bottom of the row'),
    ];

// ─── §7 Visual: fill alignment ───────────────────────────────────
List<Widget> _vaFillVisual() => [
      _vaDivider(),
      _vaTitle('§7  Visual: Fill Alignment'),
      _vaBody(
          'Cells are forced to fill the full row height. The child receives '
          'tight constraints equal to the row height:'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _vaLight,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            _vaLabel('TableCellVerticalAlignment.fill'),
            const SizedBox(height: 8),
            _vaCellDisplay(
                'fill (stretches to 80)', Alignment.center, _vaAmber, 80, 80,
                isFill: true),
            const SizedBox(height: 4),
            _vaSmall('Cell originally wanted 30px but was stretched to 80px'),
          ],
        ),
      ),
      _vaCode(
          'Table(\n'
          '  defaultVerticalAlignment:\n'
          '      TableCellVerticalAlignment.fill,\n'
          '  children: [\n'
          '    TableRow(children: [\n'
          '      // All cells forced to row height\n'
          '      Container(color: amber),   // fills 80px\n'
          '      Container(color: orange),  // fills 80px\n'
          '      Container(height: 80),     // determines row height\n'
          '    ]),\n'
          '  ],\n'
          ')'),
      _vaNote(
          'With fill, the child is relaid out with tight height constraints '
          '(height = rowHeight). The child layout must accept the forced '
          'height. Good for colored backgrounds that need to cover the full row.'),
    ];

// ─── §8 Visual: baseline alignment ───────────────────────────────
List<Widget> _vaBaselineVisual() => [
      _vaDivider(),
      _vaTitle('§8  Visual: Baseline Alignment'),
      _vaBody(
          'Text baselines are aligned across cells. Different font sizes '
          'sit on the same baseline:'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _vaLight,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            _vaLabel('TableCellVerticalAlignment.baseline'),
            const SizedBox(height: 12),
            // Simulated baseline alignment
            Container(
              width: double.infinity,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
                border:
                    Border.all(color: _vaAmber.withValues(alpha: 0.2)),
              ),
              child: Stack(
                children: [
                  // Baseline indicator line
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 40,
                    child: Container(
                      height: 1,
                      color: Colors.red.withValues(alpha: 0.5),
                    ),
                  ),
                  Positioned(
                    right: 4,
                    top: 28,
                    child: Text('baseline',
                        style: TextStyle(
                            fontSize: 7,
                            color: Colors.red.shade300,
                            fontStyle: FontStyle.italic)),
                  ),
                  // Three texts at different sizes aligned to baseline
                  Positioned(
                    left: 10,
                    top: 16,
                    child: Text('Small',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: _vaAmber.withValues(alpha: 0.9))),
                  ),
                  Positioned(
                    left: 80,
                    top: 8,
                    child: Text('Medium',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: _vaBlue.withValues(alpha: 0.9))),
                  ),
                  Positioned(
                    left: 190,
                    top: 2,
                    child: Text('Big',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            color: _vaPurple.withValues(alpha: 0.9))),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 6),
            _vaSmall(
                'Red line = shared baseline. Texts align regardless of size.'),
          ],
        ),
      ),
      _vaCode(
          'Table(\n'
          '  defaultVerticalAlignment:\n'
          '      TableCellVerticalAlignment.baseline,\n'
          '  textBaseline: TextBaseline.alphabetic, // required!\n'
          '  children: [\n'
          '    TableRow(children: [\n'
          '      Text("Small", style: TextStyle(fontSize: 14)),\n'
          '      Text("Medium", style: TextStyle(fontSize: 22)),\n'
          '      Text("Big", style: TextStyle(fontSize: 30)),\n'
          '    ]),\n'
          '  ],\n'
          ')'),
      _vaNote(
          'When using baseline alignment, Table.textBaseline MUST be set. '
          'Without it, Flutter throws an assertion error.'),
    ];

// ─── §9 Side-by-side comparison ──────────────────────────────────
List<Widget> _vaComparison() => [
      _vaDivider(),
      _vaTitle('§9  Side-by-Side Comparison'),
      _vaBody(
          'All alignment values shown in one row, with cells of varying '
          'heights in an 80px row:'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _vaLight,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            // Headers
            Row(
              children: [
                for (final label
                    in ['top', 'middle', 'bottom', 'fill', 'baseline'])
                  Expanded(
                    child: Center(
                      child: Text(label,
                          style: const TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w700,
                              color: _vaAmber)),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Expanded(
                    child: _vaCompactCell(
                        'top\n30px', Alignment.topCenter, _vaAmber, 30, 80)),
                Expanded(
                    child: _vaCompactCell(
                        'mid\n30px', Alignment.center, _vaBlue, 30, 80)),
                Expanded(
                    child: _vaCompactCell('bot\n30px',
                        Alignment.bottomCenter, _vaTeal, 30, 80)),
                Expanded(
                    child: _vaCompactCell(
                        'fill\n80px', Alignment.center, _vaPurple, 80, 80,
                        fill: true)),
                Expanded(
                    child: _vaCompactCell('base\n30px',
                        const Alignment(0, -0.3), _vaGood, 30, 80)),
              ],
            ),
            const SizedBox(height: 6),
            _vaSmall(
                'Same 30px cell in an 80px row, positioned differently'),
          ],
        ),
      ),
      // Comparison table
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _vaLight,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _vaCmpRow('Value', 'Position', 'Stretches?', 'Common Use',
                isHeader: true),
            _vaCmpRow('top', 'Top edge', 'No', 'Default'),
            _vaCmpRow('middle', 'Centered', 'No', 'Data tables'),
            _vaCmpRow('bottom', 'Bottom edge', 'No', 'Totals row'),
            _vaCmpRow('fill', 'Full row', 'Yes', 'Backgrounds'),
            _vaCmpRow('baseline', 'Text line', 'No', 'Mixed fonts'),
            _vaCmpRow('intrinsic', 'Top (intrinsic)', 'No', 'Complex'),
          ],
        ),
      ),
    ];

Widget _vaCmpRow(String val, String pos, String stretch, String use,
    {bool isHeader = false}) {
  final style = TextStyle(
    fontSize: 10,
    fontWeight: isHeader ? FontWeight.w700 : FontWeight.w400,
    color: isHeader ? _vaAmber : Colors.black87,
  );
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      children: [
        SizedBox(width: 64, child: Text(val, style: style)),
        Expanded(child: Text(pos, style: style)),
        SizedBox(width: 60, child: Text(stretch, style: style)),
        Expanded(child: Text(use, style: style)),
      ],
    ),
  );
}

// ─── §10 How RenderTable uses this enum ──────────────────────────
List<Widget> _vaRenderTable() => [
      _vaDivider(),
      _vaTitle('§10  How RenderTable Uses This Enum'),
      _vaBody(
          'RenderTable reads the alignment in two phases during layout:'),
      _vaSubtitle('Phase 1: Determine row heights'),
      _vaBody(
          'All cells are laid out once to get their intrinsic sizes. The '
          'row height is the maximum cell height in that row.'),
      _vaSubtitle('Phase 2: Position cells'),
      _vaBody(
          'Each cell is positioned based on its verticalAlignment:'),
      _vaCode(
          'final alignment = parentData.verticalAlignment\n'
          '    ?? defaultVerticalAlignment;\n'
          '\n'
          'switch (alignment) {\n'
          '  case top:\n'
          '    parentData.offset = Offset(x, rowTop);\n'
          '  case middle:\n'
          '    final dy = (rowHeight - cellHeight) / 2;\n'
          '    parentData.offset = Offset(x, rowTop + dy);\n'
          '  case bottom:\n'
          '    final dy = rowHeight - cellHeight;\n'
          '    parentData.offset = Offset(x, rowTop + dy);\n'
          '  case fill:\n'
          '    // Relayout with tight height constraints\n'
          '    child.layout(\n'
          '      BoxConstraints.tightFor(\n'
          '        width: colWidth, height: rowHeight),\n'
          '      parentUsesSize: true);\n'
          '    parentData.offset = Offset(x, rowTop);\n'
          '  case baseline:\n'
          '    // Align on text baseline across row\n'
          '    final baseline = child.getDistanceToBaseline(...);\n'
          '    parentData.offset = Offset(x, rowTop + rowBaseline\n'
          '        - baseline);\n'
          '  case intrinsicHeight:\n'
          '    parentData.offset = Offset(x, rowTop);\n'
          '}'),
      _vaNote(
          'The fill case is special: it calls child.layout() a second '
          'time with tight constraints. All other cases only adjust the '
          'offset without re-laying out the child.'),
      _vaSubtitle('Performance implication'),
      _vaBody(
          'Using fill means the child is laid out twice per frame. '
          'For simple cells this is negligible, but for complex cell '
          'content it could be a performance concern.'),
    ];

// ─── §11 Summary ─────────────────────────────────────────────────
List<Widget> _vaSummary() => [
      _vaDivider(),
      _vaTitle('§11  Summary'),
      _vaBody(
          'TableCellVerticalAlignment gives fine-grained control over '
          'vertical positioning of cells within table rows. Six values '
          'cover every practical layout requirement.'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              _vaAmber.withValues(alpha: 0.08),
              _vaLight,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _vaAmber.withValues(alpha: 0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Key takeaways',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: _vaAmber)),
            const SizedBox(height: 10),
            _vaSumPt('top', 'Content at top edge of row (default)'),
            _vaSumPt('middle', 'Content vertically centered'),
            _vaSumPt('bottom', 'Content at bottom edge of row'),
            _vaSumPt('fill',
                'Content stretched to fill row height (relayout)'),
            _vaSumPt('baseline',
                'Text baselines aligned across cells (needs textBaseline)'),
            _vaSumPt('intrinsicHeight',
                'Uses intrinsic height, positioned at top'),
            _vaSumPt('Per-cell override',
                'TableCell sets verticalAlignment in parentData'),
          ],
        ),
      ),
      const SizedBox(height: 20),
      Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: _vaAmber,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
              'End of TableCellVerticalAlignment Deep Demo',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: 0.3)),
        ),
      ),
      const SizedBox(height: 24),
    ];

Widget _vaSumPt(String label, String desc) => Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 4, right: 8),
            child: Icon(Icons.check_circle, size: 14, color: _vaGood),
          ),
          Expanded(
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: '$label — ',
                    style: const TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                        color: _vaAmber)),
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
        _vaBanner(),
        const SizedBox(height: 20),
        ..._vaWhatIs(),
        ..._vaEnumValues(),
        ..._vaTopVisual(),
        ..._vaMiddleVisual(),
        ..._vaBottomVisual(),
        ..._vaFillVisual(),
        ..._vaBaselineVisual(),
        ..._vaComparison(),
        ..._vaRenderTable(),
        ..._vaSummary(),
      ],
    ),
  );
}
