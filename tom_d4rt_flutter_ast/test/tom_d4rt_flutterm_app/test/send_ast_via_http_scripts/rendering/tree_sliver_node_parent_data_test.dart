// ignore_for_file: avoid_print
// Deep demo: TreeSliverNodeParentData
// Demonstrates the per-node parent data that TreeSliver attaches to
// each child — tracks depth, parent relationship, animation state,
// and layout offsets within the tree.
import 'package:flutter/material.dart';

// ─── palette: Indigo / Lavender ───────────────────────────────────
const Color _tnIndigo = Color(0xFF283593);
const Color _tnLavender = Color(0xFFE8EAF6);
const Color _tnAccent = Color(0xFF3949AB);
const Color _tnDark = Color(0xFF1A1A1A);
const Color _tnGreen = Color(0xFF2E7D32);
const Color _tnOrange = Color(0xFFEF6C00);
const Color _tnRed = Color(0xFFC62828);
const Color _tnTeal = Color(0xFF00695C);
const Color _tnPurple = Color(0xFF7B1FA2);

// ─── text helpers ─────────────────────────────────────────────────
Widget _tnTitle(String t) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Text(t,
          style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: _tnIndigo,
              letterSpacing: 0.3)),
    );

Widget _tnSubtitle(String t) => Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 4),
      child: Text(t,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.w700, color: _tnAccent)),
    );

Widget _tnBody(String t) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Text(t,
          style: const TextStyle(
              fontSize: 13.5, color: Colors.black87, height: 1.45)),
    );

Widget _tnCode(String t) => Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _tnDark,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(t,
          style: const TextStyle(
              fontSize: 12,
              fontFamily: 'monospace',
              color: Color(0xFFC5CAE9),
              height: 1.5)),
    );

Widget _tnNote(String t) => Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _tnLavender,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _tnIndigo.withValues(alpha: 0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 8, top: 1),
            child: Icon(Icons.info_outline, size: 16, color: _tnIndigo),
          ),
          Expanded(
            child: Text(t,
                style: const TextStyle(
                    fontSize: 12.5, color: _tnIndigo, height: 1.4)),
          ),
        ],
      ),
    );

Widget _tnDivider() => Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Container(height: 1, color: _tnIndigo.withValues(alpha: 0.1)),
    );

Widget _tnBullet(String label, String desc) => Padding(
      padding: const EdgeInsets.only(left: 12, top: 3, bottom: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.only(top: 6, right: 8),
            decoration:
                const BoxDecoration(color: _tnAccent, shape: BoxShape.circle),
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

Widget _tnTag(String t, Color bg, [Color fg = Colors.white]) => Container(
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

Widget _tnLabel(String t) => Text(t,
    style: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: _tnIndigo,
        letterSpacing: 0.2));

// ─── §1 Title banner ──────────────────────────────────────────────
Widget _tnBanner() => Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [_tnIndigo, Color(0xFF3949AB)],
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
          const Icon(Icons.data_object, size: 48, color: _tnLavender),
          const SizedBox(height: 10),
          const Text('TreeSliverNodeParentData',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: 0.5)),
          const SizedBox(height: 6),
          Text('Per-node metadata attached by TreeSliver during layout',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 13,
                  color: Colors.white.withValues(alpha: 0.85))),
          const SizedBox(height: 12),
          Wrap(
            alignment: WrapAlignment.center,
            children: [
              _tnTag('rendering', _tnAccent),
              _tnTag('parentData', _tnTeal),
              _tnTag('TreeSliver', _tnPurple),
            ],
          ),
        ],
      ),
    );

// ─── §2 What is it? ──────────────────────────────────────────────
List<Widget> _tnWhatIs() => [
      _tnTitle('§2  What Is TreeSliverNodeParentData?'),
      _tnBody(
          'TreeSliverNodeParentData is a ParentData subclass that '
          'TreeSliver attaches to each child RenderBox. It stores the '
          'metadata needed to position and animate tree nodes within '
          'the scrollable list — depth, parent index, expand/collapse '
          'animation progress, and layout offset.'),
      _tnCode(
          'class TreeSliverNodeParentData\n'
          '    extends SliverMultiBoxAdaptorParentData {\n'
          '  int depth = 0;\n'
          '  int? parentIndex;\n'
          '  bool isExpanded = false;\n'
          '  double animationProgress = 1.0;\n'
          '}'),
      _tnBody(
          'This class extends SliverMultiBoxAdaptorParentData, which '
          'itself provides the index and keepAlive fields needed for '
          'efficient sliver list management.'),
    ];

// ─── §3 Inheritance hierarchy ────────────────────────────────────
List<Widget> _tnHierarchy() => [
      _tnDivider(),
      _tnTitle('§3  Inheritance Hierarchy'),
      _tnBody(
          'TreeSliverNodeParentData sits deep in the ParentData line. '
          'Each level adds capabilities:'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _tnLavender,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _tnHierItem(0, 'ParentData', 'Base — generic child metadata',
                _tnIndigo),
            _tnHierItem(1, 'SliverLogicalParentData',
                'layoutOffset (position in sliver)', _tnAccent),
            _tnHierItem(2, 'SliverMultiBoxAdaptorParentData',
                'index, keepAlive', _tnTeal),
            _tnHierItem(3, 'TreeSliverNodeParentData',
                'depth, parentIndex, animation', _tnOrange),
          ],
        ),
      ),
      _tnNote(
          'Each ancestor contributes fields. TreeSliverNodeParentData '
          'inherits layoutOffset (scroll position), index (logical '
          'position in the child list), and keepAlive (whether the '
          'item should be preserved off-screen).'),
    ];

Widget _tnHierItem(int depth, String name, String desc, Color c) => Padding(
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

// ─── §4 Fields in detail ────────────────────────────────────────
List<Widget> _tnFields() => [
      _tnDivider(),
      _tnTitle('§4  Fields In Detail'),
      _tnSubtitle('depth'),
      _tnBody(
          'The nesting level of this node in the tree. Root nodes have '
          'depth 0, their children have depth 1, and so on. Used to '
          'compute indentation offset via TreeSliverIndentationType.'),
      _tnFieldCard('depth', 'int', '0',
          'Nesting level (root = 0)', _tnGreen),
      _tnSubtitle('parentIndex'),
      _tnBody(
          'The index of this node\'s parent in the flattened child '
          'list. Null for root nodes. Enables tree traversal from any '
          'node back up to the root.'),
      _tnFieldCard('parentIndex', 'int?', 'null',
          'Index of parent in child list', _tnPurple),
      _tnSubtitle('isExpanded'),
      _tnBody(
          'Whether this node\'s children are visible. When toggled, '
          'the TreeSliver animates children in/out. Only meaningful '
          'for nodes that have children.'),
      _tnFieldCard('isExpanded', 'bool', 'false',
          'Whether children are shown', _tnOrange),
      _tnSubtitle('animationProgress'),
      _tnBody(
          'A value from 0.0 to 1.0 tracking how far expand/collapse '
          'animation has progressed. 1.0 means fully expanded or '
          'fully collapsed (animation complete). During animation, '
          'intermediate values drive the visual transition.'),
      _tnFieldCard('animationProgress', 'double', '1.0',
          'Expand/collapse animation 0..1', _tnTeal),
    ];

Widget _tnFieldCard(
    String name, String type, String defVal, String desc, Color c) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(vertical: 6),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: c.withValues(alpha: 0.25)),
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
          height: 44,
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
                          fontSize: 14,
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

// ─── §5 Inherited fields ─────────────────────────────────────────
List<Widget> _tnInherited() => [
      _tnDivider(),
      _tnTitle('§5  Inherited Fields'),
      _tnBody(
          'These fields come from ancestor ParentData classes and are '
          'equally important for tree node layout:'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _tnLavender,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _tnInhRow('layoutOffset', 'double?',
                'Position within the sliver scroll extent', _tnIndigo),
            _tnInhRow('index', 'int?',
                'Index in the flattened child list', _tnAccent),
            _tnInhRow('keepAlive', 'bool',
                'Preserve even when off-screen', _tnGreen),
          ],
        ),
      ),
      _tnCode(
          '// These are available on every TreeSliverNodeParentData\n'
          'final parentData = child.parentData\n'
          '    as TreeSliverNodeParentData;\n'
          '\n'
          '// Own fields\n'
          'print(parentData.depth);\n'
          'print(parentData.isExpanded);\n'
          '\n'
          '// Inherited fields\n'
          'print(parentData.layoutOffset);\n'
          'print(parentData.index);\n'
          'print(parentData.keepAlive);'),
    ];

Widget _tnInhRow(String name, String type, String desc, Color c) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.only(top: 4, right: 8),
            decoration: BoxDecoration(
              color: c,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(
            width: 95,
            child: Text(name,
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: c,
                    fontFamily: 'monospace')),
          ),
          Expanded(
            child: Text(desc,
                style: const TextStyle(
                    fontSize: 11, color: Colors.black54)),
          ),
        ],
      ),
    );

// ─── §6 Tree layout visualization ────────────────────────────────
List<Widget> _tnTreeLayout() => [
      _tnDivider(),
      _tnTitle('§6  Tree Layout Visualization'),
      _tnBody(
          'When TreeSliver lays out a flat list of tree nodes, each '
          'child\'s ParentData captures where it belongs:'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _tnLavender,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _tnLabel('Flattened node list with parentData values'),
            const SizedBox(height: 10),
            _tnNodeRow(0, 'Root A', 0, null, true),
            _tnNodeRow(1, 'Child A.1', 1, 0, true),
            _tnNodeRow(2, 'Leaf A.1.1', 2, 1, false),
            _tnNodeRow(2, 'Leaf A.1.2', 3, 1, false),
            _tnNodeRow(1, 'Child A.2', 4, 0, false),
            _tnNodeRow(0, 'Root B', 5, null, false),
          ],
        ),
      ),
      _tnBullet('depth', 'How many levels from the root'),
      _tnBullet('index', 'Position in the flattened list (0-based)'),
      _tnBullet('parentIndex', 'Which item is the parent (null for roots)'),
      _tnBullet('isExpanded', 'Whether children are currently shown'),
    ];

Widget _tnNodeRow(
    int depth, String label, int index, int? parentIdx, bool expanded) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 2),
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(
          color: expanded
              ? _tnAccent.withValues(alpha: 0.3)
              : Colors.grey.withValues(alpha: 0.15)),
    ),
    child: Row(
      children: [
        // Depth indent
        SizedBox(width: depth * 18.0),
        // Expand indicator
        Icon(
          expanded
              ? Icons.keyboard_arrow_down
              : (depth < 2 && parentIdx != null)
                  ? Icons.keyboard_arrow_right
                  : Icons.remove,
          size: 14,
          color: expanded ? _tnAccent : Colors.black38,
        ),
        const SizedBox(width: 4),
        // Label
        Expanded(
          child: Text(label,
              style: TextStyle(
                  fontSize: 11.5,
                  fontWeight: expanded ? FontWeight.w600 : FontWeight.w400,
                  color: Colors.black87)),
        ),
        // Metadata badges
        _tnBadge('d=$depth', _tnGreen),
        _tnBadge('i=$index', _tnAccent),
        _tnBadge(
            parentIdx != null ? 'p=$parentIdx' : 'p=null', _tnPurple),
        if (expanded) _tnBadge('exp', _tnOrange),
      ],
    ),
  );
}

Widget _tnBadge(String t, Color c) => Container(
      margin: const EdgeInsets.only(left: 4),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
      decoration: BoxDecoration(
        color: c.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Text(t,
          style: TextStyle(
              fontSize: 8.5,
              fontWeight: FontWeight.w600,
              color: c,
              fontFamily: 'monospace')),
    );

// ─── §7 Animation state ──────────────────────────────────────────
List<Widget> _tnAnimation() => [
      _tnDivider(),
      _tnTitle('§7  Animation Progress'),
      _tnBody(
          'When a node is expanded or collapsed, TreeSliver animates '
          'the children in/out. The animationProgress field tracks '
          'this transition on each affected child:'),
      _tnCode(
          '// Animation phases\n'
          '// Collapsing: 1.0 -> 0.0  (children fade out)\n'
          '// Expanding:  0.0 -> 1.0  (children fade in)\n'
          '// Idle:       1.0          (no animation)'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _tnLavender,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _tnLabel('Expand animation timeline'),
            const SizedBox(height: 10),
            _tnAnimBar('0%', 0.0, _tnRed),
            _tnAnimBar('25%', 0.25, _tnOrange),
            _tnAnimBar('50%', 0.5, _tnAccent),
            _tnAnimBar('75%', 0.75, _tnTeal),
            _tnAnimBar('100%', 1.0, _tnGreen),
          ],
        ),
      ),
      _tnBody(
          'During the animation, the child node is visible but may be '
          'partially clipped or at a reduced size. The rendering system '
          'uses animationProgress to compute the visible extent of '
          'each animating node.'),
      _tnSubtitle('Impact on layout'),
      _tnBullet('animationProgress = 0',
          'Child has zero visible extent (hidden)'),
      _tnBullet('animationProgress = 0.5',
          'Child shows half its natural height'),
      _tnBullet('animationProgress = 1.0',
          'Child is fully visible (default idle state)'),
    ];

Widget _tnAnimBar(String label, double progress, Color c) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          SizedBox(
            width: 32,
            child: Text(label,
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: c)),
          ),
          Expanded(
            child: Container(
              height: 16,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: progress.clamp(0.02, 1.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: c.withValues(alpha: 0.7),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 28,
            child: Text(progress.toStringAsFixed(1),
                style: TextStyle(
                    fontSize: 9,
                    color: c,
                    fontFamily: 'monospace')),
          ),
        ],
      ),
    );

// ─── §8 Layout offset ────────────────────────────────────────────
List<Widget> _tnLayoutOffset() => [
      _tnDivider(),
      _tnTitle('§8  Layout Offset & Scroll Position'),
      _tnBody(
          'The inherited layoutOffset field positions each node in '
          'the scroll direction. TreeSliver computes these during '
          'layout, stacking nodes vertically:'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _tnLavender,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _tnLabel('Layout offset computation'),
            const SizedBox(height: 10),
            _tnOffsetRow('Node A', 0, 48, _tnIndigo),
            _tnOffsetRow('Node A.1', 48, 48, _tnAccent),
            _tnOffsetRow('Node A.1.1', 96, 36, _tnTeal),
            _tnOffsetRow('Node A.1.2', 132, 36, _tnTeal),
            _tnOffsetRow('Node A.2', 168, 48, _tnAccent),
            _tnOffsetRow('Node B', 216, 48, _tnIndigo),
          ],
        ),
      ),
      _tnCode(
          '// Layout offset is cumulative:\n'
          '// Node A:     layoutOffset = 0\n'
          '// Node A.1:   layoutOffset = 48  (0 + height of A)\n'
          '// Node A.1.1: layoutOffset = 96  (48 + height of A.1)\n'
          '// ...\n'
          '// Each node stacks after the previous one'),
      _tnNote(
          'layoutOffset is in the main axis direction (vertical for '
          'default scrolling). It does not include cross-axis indentation '
          '— that is computed separately from the depth field.'),
    ];

Widget _tnOffsetRow(String name, int offset, int height, Color c) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(name,
                style: TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w600,
                    color: c)),
          ),
          Expanded(
            child: Container(
              height: 20,
              margin: EdgeInsets.only(left: offset * 0.3),
              decoration: BoxDecoration(
                color: c.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: c.withValues(alpha: 0.4)),
              ),
              child: Center(
                child: Text('offset=$offset  h=$height',
                    style: TextStyle(
                        fontSize: 8,
                        color: c,
                        fontFamily: 'monospace')),
              ),
            ),
          ),
        ],
      ),
    );

// ─── §9 Parent index traversal ───────────────────────────────────
List<Widget> _tnTraversal() => [
      _tnDivider(),
      _tnTitle('§9  Parent Index Traversal'),
      _tnBody(
          'The parentIndex field enables walking up the tree from any '
          'node. Starting at a leaf, follow parentIndex to reach the '
          'root:'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _tnLavender,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _tnLabel('Traversal: Leaf A.1.2 -> Root A'),
            const SizedBox(height: 10),
            _tnPathStep('Leaf A.1.2', 'index=3, parentIndex=1', _tnOrange, true),
            _tnPathStep('Child A.1', 'index=1, parentIndex=0', _tnAccent, true),
            _tnPathStep('Root A', 'index=0, parentIndex=null', _tnIndigo, false),
          ],
        ),
      ),
      _tnCode(
          '/// Walk to root from any node\n'
          'List<int> pathToRoot(List<RenderBox> children, int startIdx) {\n'
          '  final path = <int>[startIdx];\n'
          '  var current = startIdx;\n'
          '  while (true) {\n'
          '    final pd = children[current].parentData\n'
          '        as TreeSliverNodeParentData;\n'
          '    if (pd.parentIndex == null) break;\n'
          '    current = pd.parentIndex!;\n'
          '    path.add(current);\n'
          '  }\n'
          '  return path;\n'
          '}'),
    ];

Widget _tnPathStep(String name, String meta, Color c, bool hasArrow) =>
    Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: c.withValues(alpha: 0.3)),
          ),
          child: Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(color: c, shape: BoxShape.circle),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(name,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: c)),
              ),
              Text(meta,
                  style: const TextStyle(
                      fontSize: 9,
                      color: Colors.black45,
                      fontFamily: 'monospace')),
            ],
          ),
        ),
        if (hasArrow)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Icon(Icons.arrow_upward, size: 16, color: c),
          ),
      ],
    );

// ─── §10 Relationship to other ParentData ────────────────────────
List<Widget> _tnRelated() => [
      _tnDivider(),
      _tnTitle('§10  Related ParentData Classes'),
      _tnBody(
          'Different slivers attach different ParentData to their children. '
          'TreeSliverNodeParentData is specific to TreeSliver:'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _tnLavender,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _tnRelRow('SliverMultiBoxAdaptorParentData',
                'index + keepAlive for general slivers', _tnAccent),
            _tnRelRow('TreeSliverNodeParentData',
                '+ depth, parentIndex, animation for trees', _tnOrange),
            _tnRelRow('SliverGridParentData',
                'crossAxisOffset for grid layouts', _tnTeal),
            _tnRelRow('BoxParentData',
                'offset for plain box layout', _tnPurple),
          ],
        ),
      ),
      _tnNote(
          'You cannot use TreeSliverNodeParentData with a non-TreeSliver '
          'parent. The parent sliver type determines which ParentData '
          'subclass is used.'),
    ];

Widget _tnRelRow(String name, String desc, Color c) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 4,
            height: 32,
            margin: const EdgeInsets.only(right: 10),
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

// ─── §11 Summary ─────────────────────────────────────────────────
List<Widget> _tnSummary() => [
      _tnDivider(),
      _tnTitle('§11  Summary'),
      _tnBody(
          'TreeSliverNodeParentData carries the essential per-node '
          'metadata that TreeSliver needs to position, animate, and '
          'navigate tree nodes.'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              _tnIndigo.withValues(alpha: 0.07),
              _tnLavender,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _tnIndigo.withValues(alpha: 0.15)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Key takeaways',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: _tnIndigo)),
            const SizedBox(height: 10),
            _tnSumPt('depth',
                'Nesting level — used for indentation calculation'),
            _tnSumPt('parentIndex',
                'Links each node to its parent for traversal'),
            _tnSumPt('isExpanded',
                'Tracks whether children are visible'),
            _tnSumPt('animationProgress',
                'Drives expand/collapse transitions (0..1)'),
            _tnSumPt('layoutOffset',
                'Inherited — vertical position in the scroll extent'),
            _tnSumPt('index / keepAlive',
                'Inherited — list management from sliver adaptor'),
          ],
        ),
      ),
      const SizedBox(height: 20),
      Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: _tnIndigo,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
              'End of TreeSliverNodeParentData Deep Demo',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: 0.3)),
        ),
      ),
      const SizedBox(height: 24),
    ];

Widget _tnSumPt(String label, String desc) => Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 4, right: 8),
            child: Icon(Icons.check_circle, size: 14, color: _tnAccent),
          ),
          Expanded(
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: '$label — ',
                    style: const TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                        color: _tnIndigo)),
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
        _tnBanner(),
        const SizedBox(height: 20),
        ..._tnWhatIs(),
        ..._tnHierarchy(),
        ..._tnFields(),
        ..._tnInherited(),
        ..._tnTreeLayout(),
        ..._tnAnimation(),
        ..._tnLayoutOffset(),
        ..._tnTraversal(),
        ..._tnRelated(),
        ..._tnSummary(),
      ],
    ),
  );
}
