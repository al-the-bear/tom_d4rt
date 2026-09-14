// ignore_for_file: avoid_print, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, unused_element, unnecessary_string_interpolations, unnecessary_brace_in_string_interps, prefer_interpolation_to_compose_strings, unnecessary_lambdas, dead_code, prefer_const_declarations
import 'package:flutter/material.dart';

// ============================================================================
// DEMO: RenderTreeSliver
//
// RenderTreeSliver is the render object powering TreeSliver — a sliver
// that lazily lays out a tree-structured data set with expandable/
// collapsible nodes. Each tree node can have any number of children, and
// indentation, animations, and hit-testing are managed by the render sliver.
//
// This demo visualises:
//   1. What RenderTreeSliver does and how it relates to TreeSliver widget
//   2. Tree node structure and parent-child relationships
//   3. Indentation and depth-based visual layout
//   4. Expand/collapse mechanics and animation coordination
//   5. Lazy layout: only visible nodes are laid out
//   6. TreeSliverNode data model and state tracking
//   7. Custom treeNodeBuilder and indentation configuration
//   8. Accessibility and semantics for tree nodes
//   9. Use cases and integration patterns
//
// All visuals are standard Flutter widgets.
// ============================================================================

// ---------------------------------------------------------------------------
// Colour palette – Teal / Emerald
// ---------------------------------------------------------------------------
const Color _tsPrimary = Color(0xFF00695C);
const Color _tsPrimaryLight = Color(0xFF00897B);
const Color _tsAccent = Color(0xFF00BFA5);
const Color _tsAccentDark = Color(0xFF004D40);
const Color _tsSurface = Color(0xFFE0F2F1);
const Color _tsSurfaceDark = Color(0xFFB2DFDB);
const Color _tsOnPrimary = Color(0xFFFFFFFF);
const Color _tsTextDark = Color(0xFF004D40);
const Color _tsTextMedium = Color(0xFF00796B);
const Color _tsDivider = Color(0xFF80CBC4);
const Color _tsBlue = Color(0xFF1565C0);
const Color _tsOrange = Color(0xFFE65100);
const Color _tsPurple = Color(0xFF6A1B9A);
const Color _tsPink = Color(0xFFC2185B);
const Color _tsGrey = Color(0xFF757575);
const Color _tsAmber = Color(0xFFF57F17);

// ---------------------------------------------------------------------------
// Sample tree data
// ---------------------------------------------------------------------------
class _TsNode {
  final String label;
  final IconData icon;
  final int depth;
  final bool expanded;
  final bool hasChildren;
  final Color? accentColor;

  const _TsNode({
    required this.label,
    required this.icon,
    this.depth = 0,
    this.expanded = false,
    this.hasChildren = false,
    this.accentColor,
  });
}

const List<_TsNode> _tsSampleTree = [
  _TsNode(label: 'lib/', icon: Icons.folder, depth: 0, expanded: true, hasChildren: true, accentColor: _tsPrimary),
  _TsNode(label: 'src/', icon: Icons.folder_open, depth: 1, expanded: true, hasChildren: true, accentColor: _tsPrimaryLight),
  _TsNode(label: 'models/', icon: Icons.folder, depth: 2, expanded: false, hasChildren: true, accentColor: _tsBlue),
  _TsNode(label: 'widgets/', icon: Icons.folder_open, depth: 2, expanded: true, hasChildren: true, accentColor: _tsPurple),
  _TsNode(label: 'tree_node.dart', icon: Icons.insert_drive_file, depth: 3, accentColor: _tsPurple),
  _TsNode(label: 'tree_view.dart', icon: Icons.insert_drive_file, depth: 3, accentColor: _tsPurple),
  _TsNode(label: 'utils/', icon: Icons.folder, depth: 2, expanded: false, hasChildren: true, accentColor: _tsOrange),
  _TsNode(label: 'app.dart', icon: Icons.insert_drive_file, depth: 1, accentColor: _tsPrimaryLight),
  _TsNode(label: 'test/', icon: Icons.folder, depth: 0, expanded: false, hasChildren: true, accentColor: _tsAmber),
  _TsNode(label: 'pubspec.yaml', icon: Icons.settings, depth: 0, accentColor: _tsGrey),
  _TsNode(label: 'README.md', icon: Icons.description, depth: 0, accentColor: _tsGrey),
];

// ---------------------------------------------------------------------------
// Helper: section title
// ---------------------------------------------------------------------------
Widget _tsSectionTitle(String title, IconData icon) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8, top: 4),
    child: Row(
      children: [
        Icon(icon, size: 18, color: _tsPrimary),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: _tsTextDark,
              letterSpacing: 0.3,
            ),
          ),
        ),
        Expanded(child: Divider(color: _tsDivider, thickness: 1)),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Helper: badge
// ---------------------------------------------------------------------------
Widget _tsBadge(String label, Color bg, Color fg) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(4)),
    child: Text(label, style: TextStyle(fontSize: 10, color: fg, fontWeight: FontWeight.w600)),
  );
}

// ---------------------------------------------------------------------------
// Helper: info card
// ---------------------------------------------------------------------------
Widget _tsInfoCard(String title, String body, IconData icon, {Color? accent}) {
  final c = accent ?? _tsPrimary;
  return Container(
    margin: EdgeInsets.only(bottom: 8),
    decoration: BoxDecoration(
      color: _tsSurface,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: c.withValues(alpha: 0.3)),
    ),
    padding: EdgeInsets.all(12),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: c),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: _tsTextDark)),
              SizedBox(height: 4),
              Text(body, style: TextStyle(fontSize: 12, color: _tsTextMedium, height: 1.4)),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Helper: tree node row
// ---------------------------------------------------------------------------
Widget _tsNodeRow(_TsNode node) {
  final color = node.accentColor ?? _tsGrey;
  return Container(
    margin: EdgeInsets.symmetric(vertical: 1),
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(4),
    ),
    child: Row(
      children: [
        SizedBox(width: node.depth * 20.0),
        // Depth guides
        ...List.generate(node.depth, (i) => Container(
          width: 1,
          height: 20,
          margin: EdgeInsets.only(right: 19),
          color: _tsDivider.withValues(alpha: 0.5),
        )),
        if (node.hasChildren)
          Icon(
            node.expanded ? Icons.expand_more : Icons.chevron_right,
            size: 16,
            color: color,
          )
        else
          SizedBox(width: 16),
        SizedBox(width: 4),
        Icon(node.icon, size: 16, color: color),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            node.label,
            style: TextStyle(
              fontSize: 12,
              color: _tsTextDark,
              fontWeight: node.hasChildren ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ),
        if (node.hasChildren)
          _tsBadge(node.expanded ? 'open' : 'closed', color.withValues(alpha: 0.15), color),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Helper: code line
// ---------------------------------------------------------------------------
Widget _tsCode(String text) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(color: _tsSurfaceDark, borderRadius: BorderRadius.circular(4)),
    child: Text(text, style: TextStyle(fontSize: 11, fontFamily: 'monospace', color: _tsPrimary, fontWeight: FontWeight.w600)),
  );
}

// ---------------------------------------------------------------------------
// Section 1: RenderTreeSliver Overview
// ---------------------------------------------------------------------------
Widget _tsSection1Overview() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _tsSectionTitle('1 · RenderTreeSliver Overview', Icons.account_tree_outlined),
      _tsInfoCard(
        'What is RenderTreeSliver?',
        'The render object that lays out tree-structured content lazily within '
            'a CustomScrollView. It manages node indentation, expand/collapse '
            'state, and efficiently creates/destroys child render objects as '
            'nodes scroll in and out of view.',
        Icons.view_list,
      ),
      _tsInfoCard(
        'TreeSliver widget',
        'TreeSliver<T> is the widget API. It takes a list of root '
            'TreeSliverNode<T> objects, a treeNodeBuilder, and optional '
            'configuration for indentation and animation. Under the hood, '
            'it creates RenderTreeSliver.',
        Icons.widgets,
        accent: _tsAccent,
      ),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _tsDivider),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _tsBadge('TreeSliver<T>', _tsPrimary, _tsOnPrimary),
                Icon(Icons.arrow_forward, size: 14, color: _tsGrey),
                _tsBadge('RenderTreeSliver', _tsAccentDark, _tsOnPrimary),
                Icon(Icons.arrow_forward, size: 14, color: _tsGrey),
                _tsBadge('Viewport', _tsBlue, _tsOnPrimary),
              ],
            ),
            SizedBox(height: 8),
            Text(
              'Widget creates render object, which participates in sliver protocol',
              style: TextStyle(fontSize: 11, color: _tsTextMedium, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 2: Tree Node Structure
// ---------------------------------------------------------------------------
Widget _tsSection2Structure() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _tsSectionTitle('2 · Tree Node Structure', Icons.device_hub),
      _tsInfoCard(
        'TreeSliverNode<T>',
        'Each node holds a content value of type T, a list of child nodes, '
            'and expand/collapse state. The data model is a standard tree — '
            'each node can have zero or more children, forming an arbitrary '
            'hierarchy.',
        Icons.data_object,
      ),
      Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _tsDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.account_tree, size: 16, color: _tsPrimary),
                SizedBox(width: 6),
                Text('Sample file tree', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: _tsTextDark)),
              ],
            ),
            Divider(color: _tsDivider, height: 8),
            ..._tsSampleTree.map((node) => _tsNodeRow(node)),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 3: Indentation & Depth Layout
// ---------------------------------------------------------------------------
Widget _tsSection3Indentation() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _tsSectionTitle('3 · Indentation & Depth Layout', Icons.format_indent_increase),
      _tsInfoCard(
        'Depth-based indentation',
        'RenderTreeSliver indents each node\'s child render box by '
            'depth × indentation pixels. The default indentation is 10.0 logical '
            'pixels per level. This is configurable via TreeSliver.indentation.',
        Icons.space_bar,
      ),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _tsDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Indentation visualisation', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: _tsTextDark)),
            SizedBox(height: 10),
            _tsIndentRow(0, 'Root node', _tsPrimary),
            _tsIndentRow(1, 'Child (depth 1)', _tsPrimaryLight),
            _tsIndentRow(2, 'Grandchild (depth 2)', _tsBlue),
            _tsIndentRow(3, 'Great-grandchild (depth 3)', _tsPurple),
            _tsIndentRow(4, 'Depth 4', _tsPink),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.info_outline, size: 14, color: _tsTextMedium),
                SizedBox(width: 4),
                Expanded(
                  child: Text(
                    'indent = depth × indentation (default 10.0px per level)',
                    style: TextStyle(fontSize: 10, color: _tsTextMedium, fontStyle: FontStyle.italic),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      SizedBox(height: 8),
      _tsInfoCard(
        'Custom indentation',
        'Set TreeSliver(indentation: 24.0) for wider tree indentation, or '
            'use TreeSliver(indentation: 0.0) for flat lists with custom '
            'leading indicators handled in the node builder.',
        Icons.tune,
        accent: _tsOrange,
      ),
    ],
  );
}

Widget _tsIndentRow(int depth, String label, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2),
    child: Row(
      children: [
        Container(
          width: depth * 24.0,
          height: 2,
          color: _tsDivider.withValues(alpha: 0.4),
        ),
        if (depth > 0) ...[
          Container(width: 2, height: 20, color: color.withValues(alpha: 0.4)),
          SizedBox(width: 4),
        ],
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: color.withValues(alpha: 0.3)),
          ),
          child: Text(label, style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.w600)),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 4: Expand / Collapse Mechanics
// ---------------------------------------------------------------------------
Widget _tsSection4ExpandCollapse() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _tsSectionTitle('4 · Expand / Collapse Mechanics', Icons.unfold_more),
      _tsInfoCard(
        'Toggle node expansion',
        'When a user taps the expand icon, TreeSliverController toggles the '
            'node\'s isExpanded state. RenderTreeSliver then inserts or removes '
            'children from the flattened active node list and triggers a layout.',
        Icons.touch_app,
      ),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _tsDivider),
        ),
        child: Column(
          children: [
            Text('Expand/collapse cycle', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: _tsTextDark)),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: _tsSurface,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: _tsPrimary.withValues(alpha: 0.2)),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.chevron_right, size: 24, color: _tsPrimary),
                        SizedBox(height: 4),
                        Text('Collapsed', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: _tsTextDark)),
                        Text('Children hidden', style: TextStyle(fontSize: 10, color: _tsTextMedium)),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: [
                      Icon(Icons.arrow_forward, size: 16, color: _tsAccent),
                      Text('tap', style: TextStyle(fontSize: 9, color: _tsGrey)),
                      Icon(Icons.arrow_back, size: 16, color: _tsAccent),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: _tsSurface,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: _tsAccentDark.withValues(alpha: 0.2)),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.expand_more, size: 24, color: _tsAccentDark),
                        SizedBox(height: 4),
                        Text('Expanded', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: _tsTextDark)),
                        Text('Children visible', style: TextStyle(fontSize: 10, color: _tsTextMedium)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      SizedBox(height: 8),
      _tsInfoCard(
        'Animation support',
        'TreeSliver supports animated expand/collapse using toggleAnimationStyle. '
            'The render object works with the element to animate children sliding '
            'in and out, coordinating layout extent changes smoothly.',
        Icons.animation,
        accent: _tsPurple,
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 5: Lazy Layout
// ---------------------------------------------------------------------------
Widget _tsSection5LazyLayout() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _tsSectionTitle('5 · Lazy Layout', Icons.speed),
      _tsInfoCard(
        'On-demand node creation',
        'Like SliverList, RenderTreeSliver only creates child render objects '
            'for visible nodes plus a small cache extent. Nodes scrolled far '
            'off-screen are disposed. This keeps memory usage constant for '
            'trees with thousands of nodes.',
        Icons.memory,
      ),
      Container(
        height: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _tsDivider),
        ),
        child: Stack(
          children: [
            // Viewport area
            Positioned(
              left: 20, top: 50, right: 20, bottom: 50,
              child: Container(
                decoration: BoxDecoration(
                  color: _tsAccent.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: _tsAccent, width: 1.5),
                ),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.visibility, size: 20, color: _tsAccent),
                    SizedBox(height: 4),
                    Text('Visible nodes (laid out)', style: TextStyle(fontSize: 11, color: _tsTextDark, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ),
            // Above viewport (cache)
            Positioned(
              left: 20, top: 10, right: 20,
              child: Container(
                height: 35,
                decoration: BoxDecoration(
                  color: _tsGrey.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(6)),
                  border: Border.all(color: _tsGrey.withValues(alpha: 0.3)),
                ),
                alignment: Alignment.center,
                child: Text('Cache (ready to display)', style: TextStyle(fontSize: 10, color: _tsGrey)),
              ),
            ),
            // Below viewport (cache)
            Positioned(
              left: 20, bottom: 10, right: 20,
              child: Container(
                height: 35,
                decoration: BoxDecoration(
                  color: _tsGrey.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(6)),
                  border: Border.all(color: _tsGrey.withValues(alpha: 0.3)),
                ),
                alignment: Alignment.center,
                child: Text('Cache (ready to display)', style: TextStyle(fontSize: 10, color: _tsGrey)),
              ),
            ),
            // Labels
            Positioned(
              right: 8, top: 10,
              child: _tsBadge('off-screen', _tsGrey, _tsOnPrimary),
            ),
            Positioned(
              right: 8, bottom: 10,
              child: _tsBadge('off-screen', _tsGrey, _tsOnPrimary),
            ),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 6: TreeSliverNode Data Model
// ---------------------------------------------------------------------------
Widget _tsSection6DataModel() {
  final fields = <Map<String, String>>[
    {'field': 'content', 'desc': 'User data of type T for this node'},
    {'field': 'children', 'desc': 'List<TreeSliverNode<T>> child nodes'},
    {'field': 'isExpanded', 'desc': 'Whether children are currently visible'},
    {'field': 'depth', 'desc': 'Computed depth in the tree hierarchy'},
    {'field': 'parent', 'desc': 'Reference to the parent node (null for roots)'},
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _tsSectionTitle('6 · TreeSliverNode Data Model', Icons.data_object),
      _tsInfoCard(
        'TreeSliverNode<T>',
        'The data model class that represents each node in the tree. It holds '
            'user content, child references, and expansion state. The render '
            'object flattens expanded nodes into a linear list for layout.',
        Icons.schema,
      ),
      Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _tsDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Node properties', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: _tsTextDark)),
            Divider(color: _tsDivider, height: 12),
            ...fields.map((f) => Padding(
              padding: EdgeInsets.symmetric(vertical: 3),
              child: Row(
                children: [
                  Container(
                    width: 100,
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(color: _tsSurfaceDark, borderRadius: BorderRadius.circular(4)),
                    child: Text(f['field']!, style: TextStyle(fontSize: 10, fontFamily: 'monospace', color: _tsPrimary, fontWeight: FontWeight.w600)),
                  ),
                  SizedBox(width: 8),
                  Expanded(child: Text(f['desc']!, style: TextStyle(fontSize: 11, color: _tsTextMedium))),
                ],
              ),
            )),
          ],
        ),
      ),
      SizedBox(height: 8),
      _tsInfoCard(
        'Flattened active list',
        'The render object maintains a flattened list of all currently visible '
            'nodes (expanded subtrees included, collapsed subtrees excluded). '
            'Index N in this flat list maps to the N-th visible row in the tree.',
        Icons.list,
        accent: _tsAccentDark,
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 7: treeNodeBuilder & Customisation
// ---------------------------------------------------------------------------
Widget _tsSection7Builder() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _tsSectionTitle('7 · treeNodeBuilder & Customisation', Icons.build_circle),
      _tsInfoCard(
        'Custom node widget',
        'TreeSliver.treeNodeBuilder lets you provide a custom Widget for each '
            'node. The builder receives the BuildContext, the TreeSliverNode<T>, '
            'and an AnimationStyle. Return any widget — it will be indented '
            'automatically by the render object.',
        Icons.brush,
      ),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _tsDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Builder signature', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: _tsTextDark)),
            SizedBox(height: 8),
            _tsCode('Widget treeNodeBuilder('),
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: _tsCode('BuildContext context,'),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: _tsCode('TreeSliverNode<T> node,'),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: _tsCode('AnimationStyle? style,'),
            ),
            _tsCode(')'),
            SizedBox(height: 8),
            Text(
              'The builder is called for each visible node during layout. '
              'Return any widget — the render object handles indentation.',
              style: TextStyle(fontSize: 11, color: _tsTextMedium, height: 1.4),
            ),
          ],
        ),
      ),
      SizedBox(height: 8),
      _tsInfoCard(
        'TreeSliver.defaultTreeNodeBuilder',
        'Flutter provides a default builder that renders a row with an '
            'expand/collapse icon and a Text label. For custom UIs, override '
            'with treeNodeBuilder.',
        Icons.auto_fix_normal,
        accent: _tsAccent,
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 8: Accessibility & Semantics
// ---------------------------------------------------------------------------
Widget _tsSection8Accessibility() {
  final semantics = <Map<String, dynamic>>[
    {'label': 'Semantic tree role', 'desc': 'Each node has "treeItem" role', 'icon': Icons.accessibility_new, 'color': _tsPrimary},
    {'label': 'Expand/collapse action', 'desc': 'Semantic action for toggling nodes', 'icon': Icons.unfold_more, 'color': _tsAccentDark},
    {'label': 'Level announcement', 'desc': 'Depth level communicated to screen readers', 'icon': Icons.format_indent_increase, 'color': _tsBlue},
    {'label': 'Expanded state', 'desc': 'SemanticsFlag.isExpanded for open nodes', 'icon': Icons.check_circle, 'color': _tsAmber},
    {'label': 'Child count', 'desc': 'Number of children communicated', 'icon': Icons.format_list_numbered, 'color': _tsPurple},
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _tsSectionTitle('8 · Accessibility & Semantics', Icons.accessibility),
      _tsInfoCard(
        'Tree semantics',
        'RenderTreeSliver provides rich semantic information for screen readers. '
            'Each node announces its depth, expanded state, and child count. '
            'Users can expand/collapse nodes via accessibility actions.',
        Icons.record_voice_over,
      ),
      ...semantics.map((s) => Container(
        margin: EdgeInsets.only(bottom: 6),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border(left: BorderSide(color: s['color'] as Color, width: 3)),
        ),
        child: Row(
          children: [
            Icon(s['icon'] as IconData, size: 18, color: s['color'] as Color),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(s['label'] as String, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: _tsTextDark)),
                  SizedBox(height: 2),
                  Text(s['desc'] as String, style: TextStyle(fontSize: 11, color: _tsTextMedium)),
                ],
              ),
            ),
          ],
        ),
      )),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 9: Use Cases & Integration
// ---------------------------------------------------------------------------
Widget _tsSection9UseCases() {
  final useCases = <Map<String, dynamic>>[
    {'title': 'File explorer', 'desc': 'Browsing directory hierarchies', 'icon': Icons.folder_copy, 'color': _tsPrimary},
    {'title': 'Settings tree', 'desc': 'Nested preference categories', 'icon': Icons.settings, 'color': _tsBlue},
    {'title': 'Organisation chart', 'desc': 'Employee reporting structure', 'icon': Icons.groups, 'color': _tsPurple},
    {'title': 'Category browser', 'desc': 'Product or content taxonomy', 'icon': Icons.category, 'color': _tsOrange},
    {'title': 'JSON/XML viewer', 'desc': 'Structured data exploration', 'icon': Icons.data_object, 'color': _tsAmber},
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _tsSectionTitle('9 · Use Cases & Integration', Icons.apps),
      _tsInfoCard(
        'When to use TreeSliver',
        'Use TreeSliver whenever you need to display hierarchical data in a '
            'scroll view. It handles lazy layout, expand/collapse, indentation, '
            'and accessibility automatically. Pair it with other slivers in a '
            'CustomScrollView.',
        Icons.widgets,
      ),
      ...useCases.map((u) => Container(
        margin: EdgeInsets.only(bottom: 6),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border(left: BorderSide(color: u['color'] as Color, width: 3)),
        ),
        child: Row(
          children: [
            Icon(u['icon'] as IconData, size: 20, color: u['color'] as Color),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(u['title'] as String, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: _tsTextDark)),
                  SizedBox(height: 2),
                  Text(u['desc'] as String, style: TextStyle(fontSize: 11, color: _tsTextMedium)),
                ],
              ),
            ),
          ],
        ),
      )),
      SizedBox(height: 12),
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [_tsPrimary.withValues(alpha: 0.08), _tsAccent.withValues(alpha: 0.08)],
          ),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _tsPrimary.withValues(alpha: 0.2)),
        ),
        child: Column(
          children: [
            Icon(Icons.account_tree, size: 32, color: _tsPrimary),
            SizedBox(height: 8),
            Text(
              'RenderTreeSliver',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: _tsTextDark),
            ),
            SizedBox(height: 4),
            Text(
              'The render object for tree-structured sliver content — lazy layout, '
              'depth indentation, expand/collapse animation, and full accessibility '
              'for hierarchical data displays.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11, color: _tsTextMedium, height: 1.4),
            ),
          ],
        ),
      ),
    ],
  );
}

// ============================================================================
// MAIN BUILD
// ============================================================================
dynamic build(BuildContext context) {
  return SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Header ──────────────────────────────────────────────────────
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [_tsPrimary, _tsPrimaryLight],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.account_tree, color: _tsOnPrimary, size: 28),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'RenderTreeSliver',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _tsOnPrimary,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6),
              Text(
                'Lazy tree layout sliver — hierarchical data with expand/collapse',
                style: TextStyle(fontSize: 12, color: _tsOnPrimary.withValues(alpha: 0.85)),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),

        // ── Sections ────────────────────────────────────────────────────
        _tsSection1Overview(),
        _tsSection2Structure(),
        _tsSection3Indentation(),
        _tsSection4ExpandCollapse(),
        _tsSection5LazyLayout(),
        _tsSection6DataModel(),
        _tsSection7Builder(),
        _tsSection8Accessibility(),
        _tsSection9UseCases(),

        SizedBox(height: 24),
      ],
    ),
  );
}
