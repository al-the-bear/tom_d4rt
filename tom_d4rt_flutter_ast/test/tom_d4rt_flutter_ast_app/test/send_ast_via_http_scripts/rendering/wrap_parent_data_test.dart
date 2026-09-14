// ignore_for_file: avoid_print
// Deep demo: WrapParentData
// Demonstrates WrapParentData — the per-child parent data that
// RenderWrap attaches to each child, carrying layout offset within
// the containing run and the run index itself.
import 'package:flutter/material.dart';

// ─── palette: Slate Blue / Silver ─────────────────────────────────
const Color _wpSlate = Color(0xFF37474F);
const Color _wpSilver = Color(0xFFECEFF1);
const Color _wpAccent = Color(0xFF546E7A);
const Color _wpDark = Color(0xFF1A1A1A);
const Color _wpBlue = Color(0xFF1565C0);
const Color _wpGreen = Color(0xFF2E7D32);
const Color _wpOrange = Color(0xFFEF6C00);
const Color _wpPurple = Color(0xFF6A1B9A);
const Color _wpTeal = Color(0xFF00695C);
const Color _wpRed = Color(0xFFC62828);

// ─── text helpers ─────────────────────────────────────────────────
Widget _wpTitle(String t) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Text(t,
          style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: _wpSlate,
              letterSpacing: 0.3)),
    );

Widget _wpSubtitle(String t) => Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 4),
      child: Text(t,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.w700, color: _wpAccent)),
    );

Widget _wpBody(String t) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Text(t,
          style: const TextStyle(
              fontSize: 13.5, color: Colors.black87, height: 1.45)),
    );

Widget _wpCode(String t) => Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _wpDark,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(t,
          style: const TextStyle(
              fontSize: 12,
              fontFamily: 'monospace',
              color: Color(0xFFCFD8DC),
              height: 1.5)),
    );

Widget _wpNote(String t) => Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _wpSilver,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _wpSlate.withValues(alpha: 0.15)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 8, top: 1),
            child: Icon(Icons.info_outline, size: 16, color: _wpSlate),
          ),
          Expanded(
            child: Text(t,
                style: const TextStyle(
                    fontSize: 12.5, color: _wpSlate, height: 1.4)),
          ),
        ],
      ),
    );

Widget _wpDivider() => Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Container(height: 1, color: _wpSlate.withValues(alpha: 0.1)),
    );

Widget _wpBullet(String label, String desc) => Padding(
      padding: const EdgeInsets.only(left: 12, top: 3, bottom: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.only(top: 6, right: 8),
            decoration:
                const BoxDecoration(color: _wpAccent, shape: BoxShape.circle),
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

Widget _wpTag(String t, Color bg, [Color fg = Colors.white]) => Container(
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

Widget _wpLabel(String t) => Text(t,
    style: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: _wpSlate,
        letterSpacing: 0.2));

// ─── §1 Title banner ──────────────────────────────────────────────
Widget _wpBanner() => Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [_wpSlate, Color(0xFF546E7A)],
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
          const Icon(Icons.table_chart_outlined, size: 48, color: _wpSilver),
          const SizedBox(height: 10),
          const Text('WrapParentData',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: 0.5)),
          const SizedBox(height: 6),
          Text('Per-child layout data for RenderWrap positioning',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 13,
                  color: Colors.white.withValues(alpha: 0.85))),
          const SizedBox(height: 12),
          Wrap(
            alignment: WrapAlignment.center,
            children: [
              _wpTag('rendering', _wpAccent),
              _wpTag('parentData', _wpBlue),
              _wpTag('Wrap', _wpPurple),
            ],
          ),
        ],
      ),
    );

// ─── §2 What is it? ──────────────────────────────────────────────
List<Widget> _wpWhatIs() => [
      _wpTitle('§2  What Is WrapParentData?'),
      _wpBody(
          'WrapParentData extends ContainerBoxParentData and carries '
          'the per-child layout information that RenderWrap needs to '
          'position each child. It stores the run index — which row '
          '(or column) the child ended up in after wrapping — and '
          'inherits the Offset used for final painting position.'),
      _wpCode(
          'class WrapParentData extends ContainerBoxParentData<RenderBox> {\n'
          '  // Which run (row) this child belongs to\n'
          '  int _runIndex = 0;\n'
          '}'),
      _wpBody(
          'While the class itself is simple, understanding it is key '
          'to understanding how Wrap lays out children across multiple '
          'runs with varying sizes.'),
    ];

// ─── §3 Inheritance hierarchy ────────────────────────────────────
List<Widget> _wpHierarchy() => [
      _wpDivider(),
      _wpTitle('§3  Inheritance Hierarchy'),
      _wpBody(
          'WrapParentData sits in the container parent data chain:'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _wpSilver,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _wpHierItem(0, 'ParentData', 'Base metadata', _wpSlate),
            _wpHierItem(
                1, 'BoxParentData', 'Offset for painting position', _wpBlue),
            _wpHierItem(2, 'ContainerBoxParentData<RenderBox>',
                'previousSibling / nextSibling', _wpGreen),
            _wpHierItem(
                3, 'WrapParentData', '_runIndex (run membership)', _wpOrange),
          ],
        ),
      ),
      _wpBullet('ParentData', 'The root of all parent data in Flutter'),
      _wpBullet('BoxParentData', 'Adds offset — the pixel position for painting'),
      _wpBullet('ContainerBoxParentData',
          'Adds linked-list pointers for child iteration'),
      _wpBullet('WrapParentData', 'Adds run index for multi-line layout'),
    ];

Widget _wpHierItem(int depth, String name, String desc, Color c) => Padding(
      padding: EdgeInsets.only(left: depth * 20.0, top: 4, bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 10,
            height: 10,
            margin: const EdgeInsets.only(top: 4, right: 8),
            decoration: BoxDecoration(
              color: c,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: c)),
                Text(desc,
                    style: const TextStyle(
                        fontSize: 11, color: Colors.black54)),
              ],
            ),
          ),
        ],
      ),
    );

// ─── §4 Fields ───────────────────────────────────────────────────
List<Widget> _wpFields() => [
      _wpDivider(),
      _wpTitle('§4  Fields'),
      _wpSubtitle('Own field: _runIndex'),
      _wpBody(
          'The _runIndex field tracks which "run" this child belongs to. '
          'In a horizontal Wrap, a run is a row. In a vertical Wrap, '
          'a run is a column. When children overflow the main axis, '
          'they wrap to a new run with an incremented index.'),
      _wpFieldCard('_runIndex', 'int', '0',
          'Which run (row/column) this child occupies', _wpOrange),
      _wpSubtitle('Inherited: offset'),
      _wpBody(
          'From BoxParentData — the pixel (x, y) position where this '
          'child is painted relative to the parent RenderWrap.'),
      _wpFieldCard('offset', 'Offset', 'Offset.zero',
          'Painting position (x, y) from BoxParentData', _wpBlue),
      _wpSubtitle('Inherited: previousSibling / nextSibling'),
      _wpBody(
          'From ContainerBoxParentData — linked-list pointers that '
          'let RenderWrap iterate through children efficiently.'),
      _wpFieldCard('previousSibling', 'RenderBox?', 'null',
          'Previous child in the linked list', _wpGreen),
      _wpFieldCard('nextSibling', 'RenderBox?', 'null',
          'Next child in the linked list', _wpGreen),
    ];

Widget _wpFieldCard(
    String name, String type, String defVal, String desc, Color c) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(vertical: 5),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: c.withValues(alpha: 0.2)),
      boxShadow: [
        BoxShadow(
            color: c.withValues(alpha: 0.06),
            blurRadius: 6,
            offset: const Offset(0, 2)),
      ],
    ),
    child: Row(
      children: [
        Container(
          width: 4,
          height: 40,
          decoration: BoxDecoration(
            color: c,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(name,
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: c,
                          fontFamily: 'monospace')),
                  const SizedBox(width: 8),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                    decoration: BoxDecoration(
                      color: c.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(type,
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: c,
                            fontFamily: 'monospace')),
                  ),
                  const Spacer(),
                  Text('=$defVal',
                      style: const TextStyle(
                          fontSize: 10,
                          color: Colors.black45,
                          fontFamily: 'monospace')),
                ],
              ),
              const SizedBox(height: 3),
              Text(desc,
                  style: const TextStyle(
                      fontSize: 11.5, color: Colors.black54)),
            ],
          ),
        ),
      ],
    ),
  );
}

// ─── §5 Runs visualization ───────────────────────────────────────
List<Widget> _wpRuns() => [
      _wpDivider(),
      _wpTitle('§5  Runs Visualization'),
      _wpBody(
          'When a Wrap widget lays out children, it fills the main '
          'axis until capacity is reached, then starts a new run. '
          'Each child\'s WrapParentData records which run it landed in.'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _wpSilver,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _wpLabel('Run assignment in a 300px-wide Wrap'),
            const SizedBox(height: 10),
            _wpRunRow(0, [
              _WpChild('A', 80, _wpBlue),
              _WpChild('B', 100, _wpGreen),
              _WpChild('C', 90, _wpPurple),
            ]),
            const SizedBox(height: 6),
            _wpRunRow(1, [
              _WpChild('D', 120, _wpOrange),
              _WpChild('E', 70, _wpTeal),
              _WpChild('F', 80, _wpRed),
            ]),
            const SizedBox(height: 6),
            _wpRunRow(2, [
              _WpChild('G', 150, _wpSlate),
            ]),
          ],
        ),
      ),
      _wpBody(
          'Children A, B, C fit in run 0 (80+100+90 = 270px < 300). '
          'D starts run 1 because adding 120 to run 0 would exceed 300. '
          'G alone fills run 2.'),
    ];

class _WpChild {
  final String label;
  final double width;
  final Color color;
  const _WpChild(this.label, this.width, this.color);
}

Widget _wpRunRow(int runIndex, List<_WpChild> children) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        width: 50,
        height: 38,
        decoration: BoxDecoration(
          color: _wpSlate.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(
          child: Text('Run $runIndex',
              style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: _wpSlate,
                  fontFamily: 'monospace')),
        ),
      ),
      const SizedBox(width: 8),
      Expanded(
        child: Wrap(
          spacing: 4,
          children: children
              .map((c) => Container(
                    width: c.width,
                    height: 38,
                    decoration: BoxDecoration(
                      color: c.color.withValues(alpha: 0.75),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                          color: c.color, width: 1.5),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(c.label,
                              style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white)),
                          Text('${c.width.toInt()}px',
                              style: TextStyle(
                                  fontSize: 8,
                                  color: Colors.white
                                      .withValues(alpha: 0.7),
                                  fontFamily: 'monospace')),
                        ],
                      ),
                    ),
                  ))
              .toList(),
        ),
      ),
    ],
  );
}

// ─── §6 Offset computation ───────────────────────────────────────
List<Widget> _wpOffset() => [
      _wpDivider(),
      _wpTitle('§6  Offset Computation'),
      _wpBody(
          'RenderWrap computes each child\'s offset (from BoxParentData) '
          'based on the run\'s cross-axis position and the child\'s '
          'main-axis position within the run.'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _wpSilver,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _wpLabel('Offset for each child (horizontal Wrap)'),
            const SizedBox(height: 10),
            _wpOffsetItem('Child A', 'Offset(0, 0)',
                'First child in run 0', _wpBlue),
            _wpOffsetItem('Child B', 'Offset(84, 0)',
                '80 + 4 spacing', _wpGreen),
            _wpOffsetItem('Child C', 'Offset(188, 0)',
                '80 + 4 + 100 + 4', _wpPurple),
            _wpOffsetItem('Child D', 'Offset(0, 44)',
                'First in run 1, y = run0Height + runSpacing', _wpOrange),
            _wpOffsetItem('Child E', 'Offset(124, 44)',
                '120 + 4 spacing in run 1', _wpTeal),
          ],
        ),
      ),
      _wpCode(
          '// Horizontal Wrap offset calculation:\n'
          '// x = sum of preceding widths + spacings in same run\n'
          '// y = sum of preceding run heights + runSpacings\n'
          '\n'
          '// Vertical Wrap offset calculation:\n'
          '// x = sum of preceding run widths + runSpacings\n'
          '// y = sum of preceding heights + spacings in same run'),
    ];

Widget _wpOffsetItem(String name, String offset, String reason, Color c) =>
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: c, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 65,
            child: Text(name,
                style: TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                    color: c)),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: c.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(offset,
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: c,
                    fontFamily: 'monospace')),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(reason,
                style: const TextStyle(
                    fontSize: 10.5, color: Colors.black54)),
          ),
        ],
      ),
    );

// ─── §7 Real Wrap demo ───────────────────────────────────────────
List<Widget> _wpRealWrap() => [
      _wpDivider(),
      _wpTitle('§7  Live Wrap Demonstration'),
      _wpBody(
          'A real Wrap widget showing how children distribute across '
          'runs. Each child has a different size, triggering natural '
          'wrapping behavior:'),
      _wpSubtitle('Default wrapping (alignment: start)'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: _wpSilver,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Wrap(
          spacing: 6,
          runSpacing: 6,
          children: [
            _wpChip('Flutter', _wpBlue, 80),
            _wpChip('Dart', _wpGreen, 56),
            _wpChip('Widgets', _wpPurple, 72),
            _wpChip('RenderObject', _wpOrange, 100),
            _wpChip('Layout', _wpTeal, 64),
            _wpChip('Paint', _wpRed, 52),
            _wpChip('Compositing', _wpSlate, 90),
            _wpChip('Hit Testing', _wpBlue, 80),
          ],
        ),
      ),
      _wpSubtitle('Centered wrapping'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: _wpSilver,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Wrap(
          alignment: WrapAlignment.center,
          spacing: 6,
          runSpacing: 6,
          children: [
            _wpChip('ParentData', _wpSlate, 84),
            _wpChip('Offset', _wpBlue, 56),
            _wpChip('RunIndex', _wpGreen, 72),
            _wpChip('Sibling', _wpPurple, 64),
            _wpChip('KeepAlive', _wpOrange, 76),
          ],
        ),
      ),
    ];

Widget _wpChip(String label, Color c, double width) => Container(
      width: width,
      height: 30,
      decoration: BoxDecoration(
        color: c,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Text(label,
            style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: Colors.white)),
      ),
    );

// ─── §8 Horizontal vs vertical ──────────────────────────────────
List<Widget> _wpDirection() => [
      _wpDivider(),
      _wpTitle('§8  Horizontal vs Vertical Wrap'),
      _wpBody(
          'WrapParentData is used identically in both orientations. '
          'The run concept is the same — only the axis meaning changes.'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _wpSilver,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _wpDirCard('Horizontal', 'direction: Axis.horizontal',
                'Run = row\nMain = x\nCross = y', _wpBlue)),
            const SizedBox(width: 8),
            Expanded(child: _wpDirCard('Vertical', 'direction: Axis.vertical',
                'Run = column\nMain = y\nCross = x', _wpPurple)),
          ],
        ),
      ),
      _wpCode(
          '// Horizontal Wrap (default)\n'
          'Wrap(\n'
          '  direction: Axis.horizontal,\n'
          '  children: [...],\n'
          ')\n'
          '// ParentData._runIndex = which row\n'
          '// ParentData.offset.dx = position in row\n'
          '// ParentData.offset.dy = row\'s vertical position\n'
          '\n'
          '// Vertical Wrap\n'
          'Wrap(\n'
          '  direction: Axis.vertical,\n'
          '  children: [...],\n'
          ')\n'
          '// ParentData._runIndex = which column\n'
          '// ParentData.offset.dy = position in column\n'
          '// ParentData.offset.dx = column\'s horizontal position'),
    ];

Widget _wpDirCard(String title, String code, String info, Color c) =>
    Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: c.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: c)),
          const SizedBox(height: 4),
          Text(code,
              style: TextStyle(
                  fontSize: 10,
                  color: c,
                  fontFamily: 'monospace')),
          const SizedBox(height: 6),
          Text(info,
              style: const TextStyle(
                  fontSize: 10.5, color: Colors.black54, height: 1.5)),
        ],
      ),
    );

// ─── §9 Comparison ───────────────────────────────────────────────
List<Widget> _wpComparison() => [
      _wpDivider(),
      _wpTitle('§9  Comparison With Other ParentData'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _wpSilver,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _wpCompRow('ParentData', 'BoxParentData',
                'Just offset — simple box layout', _wpSlate),
            _wpCompRow('ParentData', 'FlexParentData',
                'flex, fit — for Row/Column', _wpBlue),
            _wpCompRow('ParentData', 'StackParentData',
                'top/left/right/bottom — positioned', _wpGreen),
            _wpCompRow('ParentData', 'WrapParentData',
                'runIndex — which row/column run', _wpOrange),
            _wpCompRow('ParentData', 'SliverMultiBoxAdaptorParentData',
                'index, keepAlive — for slivers', _wpPurple),
            _wpCompRow('ParentData', 'TreeSliverNodeParentData',
                'depth, parentIndex — for trees', _wpTeal),
          ],
        ),
      ),
      _wpNote(
          'Each RenderObject type uses a different ParentData subclass '
          'tailored to its layout algorithm. WrapParentData is minimal '
          'because Wrap only needs to know which run a child belongs to.'),
    ];

Widget _wpCompRow(String base, String name, String desc, Color c) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 4,
            height: 28,
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: c,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        color: c,
                        fontFamily: 'monospace')),
                Text(desc,
                    style: const TextStyle(
                        fontSize: 10.5, color: Colors.black54)),
              ],
            ),
          ),
        ],
      ),
    );

// ─── §10 Summary ─────────────────────────────────────────────────
List<Widget> _wpSummary() => [
      _wpDivider(),
      _wpTitle('§10  Summary'),
      _wpBody(
          'WrapParentData is a simple but essential piece of the Wrap '
          'layout system, tracking which run each child belongs to.'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [_wpSlate.withValues(alpha: 0.07), _wpSilver],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _wpSlate.withValues(alpha: 0.15)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Key takeaways',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: _wpSlate)),
            const SizedBox(height: 10),
            _wpSumPt('_runIndex',
                'Tracks which run (row/column) a child belongs to'),
            _wpSumPt('offset',
                'Inherited — final painting position within RenderWrap'),
            _wpSumPt('sibling links',
                'Inherited — linked-list traversal of children'),
            _wpSumPt('Used by RenderWrap',
                'Set during layout, consumed during painting'),
            _wpSumPt('Direction-agnostic',
                'Same data model for horizontal and vertical Wraps'),
            _wpSumPt('Minimal design',
                'Only one own field — simplest among layout ParentData'),
          ],
        ),
      ),
      const SizedBox(height: 20),
      Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: _wpSlate,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text('End of WrapParentData Deep Demo',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: 0.3)),
        ),
      ),
      const SizedBox(height: 24),
    ];

Widget _wpSumPt(String label, String desc) => Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 4, right: 8),
            child: Icon(Icons.check_circle, size: 14, color: _wpAccent),
          ),
          Expanded(
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: '$label — ',
                    style: const TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                        color: _wpSlate)),
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
        _wpBanner(),
        const SizedBox(height: 20),
        ..._wpWhatIs(),
        ..._wpHierarchy(),
        ..._wpFields(),
        ..._wpRuns(),
        ..._wpOffset(),
        ..._wpRealWrap(),
        ..._wpDirection(),
        ..._wpComparison(),
        ..._wpSummary(),
      ],
    ),
  );
}
