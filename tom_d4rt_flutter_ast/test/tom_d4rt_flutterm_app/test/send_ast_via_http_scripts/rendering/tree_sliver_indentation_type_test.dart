// ignore_for_file: avoid_print
// Deep demo: TreeSliverIndentationType
// Demonstrates the TreeSliverIndentationType abstract class — controls
// indentation strategy for tree-structured sliver lists. Covers standard
// (fixed per level) and custom (callback) indentation approaches.
import 'package:flutter/material.dart';

// ─── palette: Olive / Cream ───────────────────────────────────────
const Color _tiOlive = Color(0xFF33691E);
const Color _tiCream = Color(0xFFF1F8E9);
const Color _tiAccent = Color(0xFF558B2F);
const Color _tiDark = Color(0xFF1A1A1A);
const Color _tiBlue = Color(0xFF1565C0);
const Color _tiPurple = Color(0xFF7B1FA2);
const Color _tiOrange = Color(0xFFEF6C00);
const Color _tiRed = Color(0xFFC62828);
const Color _tiTeal = Color(0xFF00695C);

// ─── text helpers ─────────────────────────────────────────────────
Widget _tiTitle(String t) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Text(t,
          style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: _tiOlive,
              letterSpacing: 0.3)),
    );

Widget _tiSubtitle(String t) => Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 4),
      child: Text(t,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.w700, color: _tiAccent)),
    );

Widget _tiBody(String t) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Text(t,
          style: const TextStyle(
              fontSize: 13.5, color: Colors.black87, height: 1.45)),
    );

Widget _tiCode(String t) => Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _tiDark,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(t,
          style: const TextStyle(
              fontSize: 12,
              fontFamily: 'monospace',
              color: Color(0xFFC5E1A5),
              height: 1.5)),
    );

Widget _tiNote(String t) => Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _tiCream,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _tiOlive.withValues(alpha: 0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 8, top: 1),
            child: Icon(Icons.info_outline, size: 16, color: _tiOlive),
          ),
          Expanded(
            child: Text(t,
                style: const TextStyle(
                    fontSize: 12.5, color: _tiOlive, height: 1.4)),
          ),
        ],
      ),
    );

Widget _tiDivider() => Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Container(height: 1, color: _tiOlive.withValues(alpha: 0.1)),
    );

Widget _tiBullet(String label, String desc) => Padding(
      padding: const EdgeInsets.only(left: 12, top: 3, bottom: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.only(top: 6, right: 8),
            decoration:
                const BoxDecoration(color: _tiAccent, shape: BoxShape.circle),
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

Widget _tiTag(String t, Color bg, [Color fg = Colors.white]) => Container(
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

Widget _tiLabel(String t) => Text(t,
    style: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: _tiOlive,
        letterSpacing: 0.2));

// ─── tree visual builders ─────────────────────────────────────────

/// Build a mock tree row with indentation.
Widget _tiTreeRow(int depth, String label,
    {bool isFolder = false,
    double indentPerLevel = 24,
    Color lineColor = _tiAccent}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      children: [
        // Indent guides
        ...List.generate(depth, (i) => SizedBox(
          width: indentPerLevel,
          height: 28,
          child: Center(
            child: Container(
              width: 1,
              height: 28,
              color: lineColor.withValues(alpha: 0.2 + (i * 0.08)),
            ),
          ),
        )),
        // Icon
        Icon(
          isFolder ? Icons.folder_outlined : Icons.description_outlined,
          size: 16,
          color: isFolder ? _tiOrange : _tiAccent,
        ),
        const SizedBox(width: 6),
        // Label
        Expanded(
          child: Text(label,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: isFolder ? FontWeight.w600 : FontWeight.w400,
                  color: Colors.black87)),
        ),
        // Depth badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
          decoration: BoxDecoration(
            color: _tiOlive.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text('L$depth',
              style: const TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                  color: _tiOlive,
                  fontFamily: 'monospace')),
        ),
      ],
    ),
  );
}

// ─── §1 Title banner ──────────────────────────────────────────────
Widget _tiBanner() => Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [_tiOlive, Color(0xFF558B2F)],
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
          const Icon(Icons.account_tree_outlined, size: 48, color: _tiCream),
          const SizedBox(height: 10),
          const Text('TreeSliverIndentationType',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: 0.5)),
          const SizedBox(height: 6),
          Text('Controls how tree nodes are indented in a TreeSliver',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 13,
                  color: Colors.white.withValues(alpha: 0.85))),
          const SizedBox(height: 12),
          Wrap(
            alignment: WrapAlignment.center,
            children: [
              _tiTag('rendering', _tiAccent),
              _tiTag('TreeSliver', _tiBlue),
              _tiTag('indentation', _tiPurple),
            ],
          ),
        ],
      ),
    );

// ─── §2 What is it? ──────────────────────────────────────────────
List<Widget> _tiWhatIs() => [
      _tiTitle('§2  What Is TreeSliverIndentationType?'),
      _tiBody(
          'TreeSliverIndentationType is an abstract class that defines '
          'how child nodes in a TreeSliver are indented based on their '
          'depth in the tree hierarchy. It computes the horizontal '
          'offset for each row, creating the visual nesting that makes '
          'tree structures readable.'),
      _tiCode(
          'abstract class TreeSliverIndentationType {\n'
          '  // Fixed indent per level\n'
          '  const factory TreeSliverIndentationType.standard(\n'
          '    double indent,\n'
          '  ) = StandardTreeSliverIndentation;\n'
          '\n'
          '  // Custom callback-based indent\n'
          '  const factory TreeSliverIndentationType.custom(\n'
          '    double Function(TreeSliverNode) getIndentation,\n'
          '  ) = CustomTreeSliverIndentation;\n'
          '}'),
      _tiBody(
          'TreeSliver uses this type to determine the leading padding '
          'for each node row. It supports two strategies: a simple '
          'fixed indent per level, and a fully custom callback.'),
    ];

// ─── §3 Standard indentation ─────────────────────────────────────
List<Widget> _tiStandard() => [
      _tiDivider(),
      _tiTitle('§3  Standard Indentation'),
      _tiBody(
          'The standard factory creates an indentation that multiplies '
          'a fixed value by the node depth. Level 0 has no indent, '
          'level 1 has 1x indent, level 2 has 2x, and so on:'),
      _tiCode(
          '// 24px per level — the default\n'
          'const indent = TreeSliverIndentationType.standard(24.0);\n'
          '\n'
          '// Level 0: 0px\n'
          '// Level 1: 24px\n'
          '// Level 2: 48px\n'
          '// Level 3: 72px'),
      _tiSubtitle('Visual: 24px standard indent'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _tiCream,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _tiLabel('24px per level'),
            const SizedBox(height: 8),
            _tiTreeRow(0, 'Root', isFolder: true, indentPerLevel: 24),
            _tiTreeRow(1, 'src/', isFolder: true, indentPerLevel: 24),
            _tiTreeRow(2, 'main.dart', indentPerLevel: 24),
            _tiTreeRow(2, 'app.dart', indentPerLevel: 24),
            _tiTreeRow(1, 'test/', isFolder: true, indentPerLevel: 24),
            _tiTreeRow(2, 'widget_test.dart', indentPerLevel: 24),
            _tiTreeRow(0, 'pubspec.yaml', indentPerLevel: 24),
          ],
        ),
      ),
      _tiSubtitle('Visual: 40px standard indent'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _tiCream,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _tiLabel('40px per level — wider spacing'),
            const SizedBox(height: 8),
            _tiTreeRow(0, 'Root', isFolder: true, indentPerLevel: 40),
            _tiTreeRow(1, 'src/', isFolder: true, indentPerLevel: 40),
            _tiTreeRow(2, 'main.dart', indentPerLevel: 40),
            _tiTreeRow(2, 'app.dart', indentPerLevel: 40),
            _tiTreeRow(1, 'test/', isFolder: true, indentPerLevel: 40),
            _tiTreeRow(2, 'widget_test.dart', indentPerLevel: 40),
          ],
        ),
      ),
      _tiSubtitle('Visual: 12px standard indent'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _tiCream,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _tiLabel('12px per level — compact spacing'),
            const SizedBox(height: 8),
            _tiTreeRow(0, 'Root', isFolder: true, indentPerLevel: 12),
            _tiTreeRow(1, 'src/', isFolder: true, indentPerLevel: 12),
            _tiTreeRow(2, 'widgets/', isFolder: true, indentPerLevel: 12),
            _tiTreeRow(3, 'button.dart', indentPerLevel: 12),
            _tiTreeRow(3, 'dialog.dart', indentPerLevel: 12),
            _tiTreeRow(2, 'models/', isFolder: true, indentPerLevel: 12),
            _tiTreeRow(3, 'user.dart', indentPerLevel: 12),
          ],
        ),
      ),
    ];

// ─── §4 Custom indentation ───────────────────────────────────────
List<Widget> _tiCustom() => [
      _tiDivider(),
      _tiTitle('§4  Custom Indentation'),
      _tiBody(
          'The custom factory takes a callback that receives the '
          'TreeSliverNode and returns the indent amount. This allows '
          'non-linear or context-dependent indentation:'),
      _tiCode(
          '// Logarithmic indentation — diminishing returns\n'
          'TreeSliverIndentationType.custom(\n'
          '  (TreeSliverNode node) {\n'
          '    final depth = node.depth;\n'
          '    return 40.0 * (1.0 - 1.0 / (depth + 1));\n'
          '  },\n'
          ')\n'
          '\n'
          '// Type-based indentation\n'
          'TreeSliverIndentationType.custom(\n'
          '  (TreeSliverNode node) {\n'
          '    if (node.children.isNotEmpty) {\n'
          '      return node.depth * 20.0;  // folders\n'
          '    }\n'
          '    return node.depth * 28.0;    // files\n'
          '  },\n'
          ')'),
      _tiSubtitle('Visual: increasing indent per deeper level'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _tiCream,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _tiLabel('Custom: 16px, 20px, 28px, 36px per level'),
            const SizedBox(height: 8),
            _tiCustomRow(0, 0, 'Project', isFolder: true),
            _tiCustomRow(1, 16, 'lib/', isFolder: true),
            _tiCustomRow(2, 36, 'src/', isFolder: true),
            _tiCustomRow(3, 64, 'core.dart'),
            _tiCustomRow(3, 64, 'utils.dart'),
            _tiCustomRow(1, 16, 'test/', isFolder: true),
            _tiCustomRow(2, 36, 'unit_test.dart'),
          ],
        ),
      ),
      _tiNote(
          'Custom indentation is powerful but should be used carefully. '
          'Inconsistent indentation can confuse users about the tree '
          'structure. Standard indentation is preferred for most cases.'),
    ];

Widget _tiCustomRow(int depth, double indent, String label,
    {bool isFolder = false}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      children: [
        SizedBox(width: indent),
        Icon(
          isFolder ? Icons.folder_outlined : Icons.description_outlined,
          size: 16,
          color: isFolder ? _tiOrange : _tiAccent,
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Text(label,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: isFolder ? FontWeight.w600 : FontWeight.w400,
                  color: Colors.black87)),
        ),
        Text('${indent.toInt()}px',
            style: const TextStyle(
                fontSize: 9,
                color: Colors.black45,
                fontFamily: 'monospace')),
      ],
    ),
  );
}

// ─── §5 How TreeSliver uses it ───────────────────────────────────
List<Widget> _tiUsage() => [
      _tiDivider(),
      _tiTitle('§5  How TreeSliver Uses IndentationType'),
      _tiBody(
          'TreeSliver accepts an indentation parameter of type '
          'TreeSliverIndentationType. It queries the indentation for '
          'each visible node during layout:'),
      _tiCode(
          'TreeSliver<MyNode>(\n'
          '  tree: rootNodes,\n'
          '  indentation: const TreeSliverIndentationType.standard(24),\n'
          '  treeNodeBuilder: (context, node, toggleCallback) {\n'
          '    return TreeSliverRow(\n'
          '      node: node,\n'
          '      onTap: toggleCallback,\n'
          '      child: Text(node.content.name),\n'
          '    );\n'
          '  },\n'
          ')'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _tiCream,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _tiLabel('Layout flow'),
            const SizedBox(height: 10),
            _tiFlowStep('1', 'TreeSliver lays out visible nodes', _tiOlive),
            _tiFlowStep('2', 'For each node, queries indentation type',
                _tiBlue),
            _tiFlowStep('3', 'Indentation returns horizontal offset',
                _tiPurple),
            _tiFlowStep('4', 'Node row is padded by that offset',
                _tiOrange),
            _tiFlowStep('5', 'Visual nesting appears in the sliver',
                _tiAccent),
          ],
        ),
      ),
    ];

Widget _tiFlowStep(String num, String desc, Color c) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              color: c,
              borderRadius: BorderRadius.circular(11),
            ),
            child: Center(
              child: Text(num,
                  style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: Colors.white)),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(desc,
                style: const TextStyle(
                    fontSize: 12, color: Colors.black87)),
          ),
        ],
      ),
    );

// ─── §6 Side-by-side comparison ──────────────────────────────────
List<Widget> _tiSideBySide() => [
      _tiDivider(),
      _tiTitle('§6  Side-By-Side: Different Indent Sizes'),
      _tiBody(
          'The standard indent value dramatically changes the visual '
          'density of the tree view. Compare these three settings:'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _tiCream,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _tiMiniTree('8px', 8, _tiRed)),
            const SizedBox(width: 6),
            Expanded(child: _tiMiniTree('24px', 24, _tiBlue)),
            const SizedBox(width: 6),
            Expanded(child: _tiMiniTree('48px', 48, _tiTeal)),
          ],
        ),
      ),
      _tiBullet('8px', 'Very compact — good for dense trees with many levels'),
      _tiBullet('24px', 'Default — balanced readability and density'),
      _tiBullet('48px', 'Spacious — clear nesting, but uses more horizontal space'),
    ];

Widget _tiMiniTree(String label, double indent, Color c) {
  return Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: c.withValues(alpha: 0.3)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: c)),
        const SizedBox(height: 4),
        _tiMiniRow(0, indent, c),
        _tiMiniRow(1, indent, c),
        _tiMiniRow(2, indent, c),
        _tiMiniRow(2, indent, c),
        _tiMiniRow(1, indent, c),
        _tiMiniRow(0, indent, c),
      ],
    ),
  );
}

Widget _tiMiniRow(int depth, double indent, Color c) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Row(
        children: [
          SizedBox(width: depth * indent.clamp(0, 16)),
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: c.withValues(alpha: 0.3 + depth * 0.2),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 3),
          Expanded(
            child: Container(
              height: 4,
              decoration: BoxDecoration(
                color: c.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
        ],
      ),
    );

// ─── §7 Deep tree visualization ──────────────────────────────────
List<Widget> _tiDeepTree() => [
      _tiDivider(),
      _tiTitle('§7  Deep Tree Visualization'),
      _tiBody(
          'Standard indentation scales linearly with depth. For very '
          'deep trees, this can push content off-screen. Here is a '
          '6-level deep tree with 24px indent:'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _tiCream,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _tiLabel('6-level tree (24px/level = 144px max indent)'),
            const SizedBox(height: 8),
            _tiTreeRow(0, 'organization/', isFolder: true),
            _tiTreeRow(1, 'department/', isFolder: true),
            _tiTreeRow(2, 'team/', isFolder: true),
            _tiTreeRow(3, 'project/', isFolder: true),
            _tiTreeRow(4, 'module/', isFolder: true),
            _tiTreeRow(5, 'component.dart'),
            _tiTreeRow(5, 'component_test.dart'),
            _tiTreeRow(4, 'utils/', isFolder: true),
            _tiTreeRow(5, 'helpers.dart'),
            _tiTreeRow(3, 'docs/', isFolder: true),
            _tiTreeRow(4, 'readme.md'),
          ],
        ),
      ),
      _tiBody(
          'For deep trees, consider using a smaller indent value or '
          'custom indentation that tapers off at deeper levels.'),
      _tiCode(
          '// Tapering custom indent for deep trees\n'
          'TreeSliverIndentationType.custom(\n'
          '  (node) {\n'
          '    // First 3 levels: 24px each\n'
          '    // Deeper levels: 12px each\n'
          '    final d = node.depth;\n'
          '    if (d <= 3) return d * 24.0;\n'
          '    return 72.0 + (d - 3) * 12.0;\n'
          '  },\n'
          ')'),
    ];

// ─── §8 Standard vs. custom comparison ───────────────────────────
List<Widget> _tiVsComparison() => [
      _tiDivider(),
      _tiTitle('§8  Standard vs. Custom Comparison'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _tiCream,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _tiVsRow('Aspect', 'Standard', 'Custom', isHeader: true),
            _tiVsRow('API', 'standard(double)', 'custom(Function)'),
            _tiVsRow('Logic', 'depth * indent', 'callback(node)'),
            _tiVsRow('Performance', 'Fastest (multiply)', 'Depends on callback'),
            _tiVsRow('Flexibility', 'Uniform only', 'Any strategy'),
            _tiVsRow('Use case', 'Most tree views', 'Special layouts'),
            _tiVsRow('Const', 'Yes', 'Only if callback is const'),
          ],
        ),
      ),
      _tiCode(
          '// Standard — simple and const\n'
          'const indent = TreeSliverIndentationType.standard(24);\n'
          '\n'
          '// Custom — flexible but not const\n'
          'final indent = TreeSliverIndentationType.custom(\n'
          '  (node) => node.depth * 20.0 + 8.0,\n'
          ');'),
      _tiNote(
          'For most applications, standard indentation is sufficient. '
          'Use custom indentation only when you need non-linear scaling, '
          'type-dependent indentation, or accessibility considerations.'),
    ];

Widget _tiVsRow(String aspect, String std, String custom,
    {bool isHeader = false}) {
  final style = TextStyle(
    fontSize: 10.5,
    fontWeight: isHeader ? FontWeight.w700 : FontWeight.w400,
    color: isHeader ? _tiOlive : Colors.black87,
  );
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      children: [
        SizedBox(width: 80, child: Text(aspect, style: style)),
        Expanded(
            child: Text(std,
                style: style.copyWith(
                    color: isHeader ? _tiOlive : _tiBlue))),
        Expanded(
            child: Text(custom,
                style: style.copyWith(
                    color: isHeader ? _tiOlive : _tiPurple))),
      ],
    ),
  );
}

// ─── §9 Real-world examples ──────────────────────────────────────
List<Widget> _tiExamples() => [
      _tiDivider(),
      _tiTitle('§9  Real-World Examples'),
      _tiSubtitle('File explorer'),
      _tiBody(
          'A file explorer typically uses standard indentation of 16-24px '
          'to mirror the IDE sidebar appearance:'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFF252526),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _tiFileRow(0, 'my_project', Icons.folder, const Color(0xFFE8A848)),
            _tiFileRow(1, 'lib', Icons.folder, const Color(0xFFE8A848)),
            _tiFileRow(2, 'main.dart', Icons.code, const Color(0xFF42A5F5)),
            _tiFileRow(2, 'app.dart', Icons.code, const Color(0xFF42A5F5)),
            _tiFileRow(1, 'test', Icons.folder, const Color(0xFFE8A848)),
            _tiFileRow(2, 'app_test.dart', Icons.code, const Color(0xFF66BB6A)),
            _tiFileRow(1, 'pubspec.yaml', Icons.settings,
                const Color(0xFFBDBDBD)),
          ],
        ),
      ),
      _tiSubtitle('Organization chart'),
      _tiBody(
          'An org chart may need wider indentation (32-48px) to clearly '
          'separate hierarchy levels:'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: _tiCream,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _tiOrgRow(0, 'CEO', _tiOlive),
            _tiOrgRow(1, 'VP Engineering', _tiBlue),
            _tiOrgRow(2, 'Lead Developer', _tiPurple),
            _tiOrgRow(3, 'Developer A', _tiAccent),
            _tiOrgRow(3, 'Developer B', _tiAccent),
            _tiOrgRow(2, 'Lead QA', _tiPurple),
            _tiOrgRow(1, 'VP Marketing', _tiBlue),
            _tiOrgRow(2, 'Campaign Manager', _tiPurple),
          ],
        ),
      ),
    ];

Widget _tiFileRow(int depth, String name, IconData icon, Color c) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(width: depth * 18.0),
          Icon(icon, size: 14, color: c),
          const SizedBox(width: 6),
          Text(name,
              style: TextStyle(
                  fontSize: 12, color: c.withValues(alpha: 0.9))),
        ],
      ),
    );

Widget _tiOrgRow(int depth, String title, Color c) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          SizedBox(width: depth * 36.0),
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: c,
              shape: depth < 2 ? BoxShape.circle : BoxShape.rectangle,
              borderRadius: depth >= 2 ? BorderRadius.circular(2) : null,
            ),
          ),
          const SizedBox(width: 8),
          Text(title,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: depth < 2 ? FontWeight.w700 : FontWeight.w400,
                  color: c)),
        ],
      ),
    );

// ─── §10 Summary ─────────────────────────────────────────────────
List<Widget> _tiSummary() => [
      _tiDivider(),
      _tiTitle('§10  Summary'),
      _tiBody(
          'TreeSliverIndentationType controls the visual nesting of '
          'tree nodes. Two strategies cover virtually all use cases.'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              _tiOlive.withValues(alpha: 0.07),
              _tiCream,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _tiOlive.withValues(alpha: 0.15)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Key takeaways',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: _tiOlive)),
            const SizedBox(height: 10),
            _tiSumPt('standard(double)',
                'Fixed indent per depth level (default approach)'),
            _tiSumPt('custom(Function)',
                'Callback for non-linear or context-dependent indentation'),
            _tiSumPt('Used by TreeSliver',
                'Passed as the indentation parameter'),
            _tiSumPt('Affects layout',
                'Determines horizontal padding for each node row'),
            _tiSumPt('Deep trees',
                'Consider smaller or tapering indent for many levels'),
            _tiSumPt('Const-friendly',
                'Standard is always const; custom may or may not be'),
          ],
        ),
      ),
      const SizedBox(height: 20),
      Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: _tiOlive,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
              'End of TreeSliverIndentationType Deep Demo',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: 0.3)),
        ),
      ),
      const SizedBox(height: 24),
    ];

Widget _tiSumPt(String label, String desc) => Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 4, right: 8),
            child: Icon(Icons.check_circle, size: 14, color: _tiAccent),
          ),
          Expanded(
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: '$label — ',
                    style: const TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                        color: _tiOlive)),
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
        _tiBanner(),
        const SizedBox(height: 20),
        ..._tiWhatIs(),
        ..._tiStandard(),
        ..._tiCustom(),
        ..._tiUsage(),
        ..._tiSideBySide(),
        ..._tiDeepTree(),
        ..._tiVsComparison(),
        ..._tiExamples(),
        ..._tiSummary(),
      ],
    ),
  );
}
