// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
// D4rt test script: Deep Demo — TreeSliverController
// Demonstrates TreeSliverController — the ChangeNotifier that manages
// expand/collapse state for tree-structured data in TreeSliver.
// Covers tree node construction, controller methods, indentation modes,
// animation integration, and hierarchical data patterns.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TreeSliverController Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.account_tree,
      'title': 'Tree State Manager',
      'body': 'TreeSliverController extends ChangeNotifier to track '
          'which tree nodes are expanded or collapsed. It stores '
          'expansion state independently from the tree data, so '
          'the same tree can respond to multiple controllers.',
      'accent': Color(0xFF5C6BC0),
    },
    {
      'icon': Icons.unfold_more,
      'title': 'Expand/Collapse API',
      'body': 'Methods like expandNode(), collapseNode(), toggleNode(), '
          'expandAll(), and collapseAll() provide programmatic control '
          'over which branches are visible. Each mutation notifies '
          'TreeSliver to rebuild.',
      'accent': Color(0xFFE65100),
    },
    {
      'icon': Icons.segment,
      'title': 'Integrates with TreeSliver',
      'body': 'TreeSliver is a sliver widget that lazily builds tree rows. '
          'The controller tells it which child lists to materialize. '
          'Only visible nodes are built — efficient even for big trees.',
      'accent': Color(0xFF5C6BC0),
    },
    {
      'icon': Icons.view_list,
      'title': 'TreeSliverNode<T>',
      'body': 'Each node wraps a content value (T) plus a list of children. '
          'Depth, parent references, and expansion flags are managed '
          'by the framework — you supply the data shape.',
      'accent': Color(0xFFE65100),
    },
  ];

  print('  Cards: ${conceptCards.length}');

  // ============================================================
  // SECTION 2: TreeSliverNode
  // ============================================================
  print('=== Section 2: TreeSliverNode ===');

  final nodeProperties = <Map<String, dynamic>>[
    {
      'property': 'content',
      'type': 'T',
      'description': 'The user data for this node. Displayed by the node '
          'builder callback.',
      'color': Color(0xFF5C6BC0),
    },
    {
      'property': 'children',
      'type': 'List<TreeSliverNode<T>>',
      'description': 'Child nodes. Empty list for leaf nodes. The controller '
          'uses this to determine what appears when expanded.',
      'color': Color(0xFFE65100),
    },
    {
      'property': 'depth',
      'type': 'int',
      'description': 'Level in the tree hierarchy. Root nodes are depth 0. '
          'Used for indentation calculations.',
      'color': Color(0xFF5C6BC0),
    },
    {
      'property': 'parent',
      'type': 'TreeSliverNode<T>?',
      'description': 'Reference to parent node, null for root nodes. '
          'Enables upward traversal.',
      'color': Color(0xFFE65100),
    },
    {
      'property': 'isExpanded',
      'type': 'bool',
      'description': 'Current expansion state. True if children are '
          'visible, false if collapsed.',
      'color': Color(0xFF5C6BC0),
    },
  ];

  print('  Properties: ${nodeProperties.length}');

  // ============================================================
  // SECTION 3: Controller Methods
  // ============================================================
  print('=== Section 3: Controller Methods ===');

  final methods = <Map<String, dynamic>>[
    {
      'name': 'expandNode(node)',
      'description': 'Marks a single node as expanded and notifies listeners. '
          'If the node has children, they become visible in the tree.',
      'category': 'Single Node',
      'color': Color(0xFF5C6BC0),
    },
    {
      'name': 'collapseNode(node)',
      'description': 'Marks a single node as collapsed. Children are hidden '
          'but not removed — state is preserved for re-expansion.',
      'category': 'Single Node',
      'color': Color(0xFFE65100),
    },
    {
      'name': 'toggleNode(node)',
      'description': 'Toggles between expanded and collapsed. Convenient '
          'for tap handlers on tree row chevrons.',
      'category': 'Single Node',
      'color': Color(0xFF5C6BC0),
    },
    {
      'name': 'isExpanded(node)',
      'description': 'Returns whether the given node is currently expanded. '
          'Use to render expand/collapse indicators.',
      'category': 'Query',
      'color': Color(0xFFE65100),
    },
    {
      'name': 'expandAll()',
      'description': 'Recursively expands all nodes in the tree. Useful '
          'for "Show All" actions or search result highlighting.',
      'category': 'Bulk',
      'color': Color(0xFF5C6BC0),
    },
    {
      'name': 'collapseAll()',
      'description': 'Collapses all nodes back to showing only roots. '
          'Clean reset for tree navigation.',
      'category': 'Bulk',
      'color': Color(0xFFE65100),
    },
  ];

  print('  Methods: ${methods.length}');

  // ============================================================
  // SECTION 4: Tree Construction
  // ============================================================
  print('=== Section 4: Tree Construction ===');

  final treeCode = '''// Build a tree from hierarchical data
final tree = <TreeSliverNode<String>>[
  TreeSliverNode<String>(
    'Documents',
    children: [
      TreeSliverNode<String>(
        'Work',
        children: [
          TreeSliverNode<String>('report.pdf'),
          TreeSliverNode<String>('budget.xlsx'),
        ],
      ),
      TreeSliverNode<String>(
        'Personal',
        children: [
          TreeSliverNode<String>('notes.md'),
        ],
      ),
    ],
  ),
  TreeSliverNode<String>(
    'Photos',
    children: [
      TreeSliverNode<String>('vacation.jpg'),
      TreeSliverNode<String>('family.png'),
    ],
  ),
];''';

  final usageCode = '''// Use with TreeSliver
final controller = TreeSliverController();

CustomScrollView(
  slivers: [
    TreeSliver<String>(
      tree: tree,
      controller: controller,
      treeNodeBuilder: (
        BuildContext context,
        TreeSliverNode<Object?> node,
        AnimationStyle style,
      ) {
        return TreeSliver.defaultTreeNodeBuilder(
          context,
          node,
          style,
        );
      },
    ),
  ],
)''';

  print('  Tree code ready');

  // ============================================================
  // SECTION 5: Indentation
  // ============================================================
  print('=== Section 5: Indentation ===');

  final indentTypes = <Map<String, dynamic>>[
    {
      'type': 'standard',
      'description': 'Fixed pixel offset per depth level. Each level indents '
          'by a consistent amount (typically 40 logical pixels).',
      'visual': '├── Level 0\n│   ├── Level 1\n│   │   └── Level 2',
      'color': Color(0xFF5C6BC0),
    },
    {
      'type': 'none',
      'description': 'No indentation at all. All nodes align to the left edge. '
          'Useful when depth is shown by other visual means (nesting connectors).',
      'visual': '├── Level 0\n├── Level 1\n├── Level 2',
      'color': Color(0xFFE65100),
    },
    {
      'type': 'custom',
      'description': 'A callback receives the tree node and returns the indent '
          'width. Enables variable-depth indentation, proportional spacing, '
          'or data-driven offsets.',
      'visual': '├── Level 0\n│  ├── Level 1 (16px)\n│     └── Level 2 (32px)',
      'color': Color(0xFF5C6BC0),
    },
  ];

  print('  Indent types: ${indentTypes.length}');

  // ============================================================
  // SECTION 6: Example Tree Data
  // ============================================================
  print('=== Section 6: Example Tree ===');

  // Build a sample tree for the visual demo
  final sampleTree = <Map<String, dynamic>>[
    {
      'label': 'src/',
      'depth': 0,
      'expanded': true,
      'icon': Icons.folder,
      'color': Color(0xFFFFA726),
      'children': [
        {
          'label': 'models/',
          'depth': 1,
          'expanded': true,
          'icon': Icons.folder,
          'color': Color(0xFFFFA726),
          'children': [
            {'label': 'user.dart', 'depth': 2, 'icon': Icons.description, 'color': Color(0xFF42A5F5)},
            {'label': 'product.dart', 'depth': 2, 'icon': Icons.description, 'color': Color(0xFF42A5F5)},
          ],
        },
        {
          'label': 'widgets/',
          'depth': 1,
          'expanded': false,
          'icon': Icons.folder,
          'color': Color(0xFFFFA726),
          'children': [
            {'label': 'button.dart', 'depth': 2, 'icon': Icons.description, 'color': Color(0xFF42A5F5)},
          ],
        },
        {'label': 'main.dart', 'depth': 1, 'icon': Icons.description, 'color': Color(0xFF66BB6A)},
      ],
    },
    {
      'label': 'test/',
      'depth': 0,
      'expanded': false,
      'icon': Icons.folder,
      'color': Color(0xFFFFA726),
      'children': [
        {'label': 'models_test.dart', 'depth': 1, 'icon': Icons.description, 'color': Color(0xFF42A5F5)},
      ],
    },
    {'label': 'pubspec.yaml', 'depth': 0, 'icon': Icons.settings, 'color': Color(0xFF78909C)},
  ];

  print('  Sample tree items: ${sampleTree.length}');

  // ============================================================
  // SECTION 7: ChangeNotifier Pattern
  // ============================================================
  print('=== Section 7: ChangeNotifier ===');

  final notifierAspects = <Map<String, dynamic>>[
    {
      'aspect': 'Notification Batching',
      'description': 'Each expand/collapse call triggers a single '
          'notifyListeners(). Bulk operations like expandAll() '
          'notify once after processing all nodes.',
      'icon': Icons.notifications_active,
      'color': Color(0xFF5C6BC0),
    },
    {
      'aspect': 'Listener Registration',
      'description': 'TreeSliver registers as a listener automatically. '
          'You can also add custom listeners to react to tree '
          'state changes in other parts of the UI.',
      'icon': Icons.hearing,
      'color': Color(0xFFE65100),
    },
    {
      'aspect': 'Disposal',
      'description': 'The controller should be disposed when the hosting '
          'widget is disposed. Failing to do so leaks listeners. '
          'Use StatefulWidget\'s dispose() method.',
      'icon': Icons.delete_outline,
      'color': Color(0xFF5C6BC0),
    },
    {
      'aspect': 'External Controllers',
      'description': 'Create the controller outside TreeSliver to share '
          'it across widgets — e.g., a sidebar tree and a toolbar '
          'with expand/collapse buttons.',
      'icon': Icons.share,
      'color': Color(0xFFE65100),
    },
  ];

  print('  Aspects: ${notifierAspects.length}');

  // ============================================================
  // SECTION 8: Best Practices
  // ============================================================
  print('=== Section 8: Best Practices ===');

  final practices = <Map<String, dynamic>>[
    {
      'title': 'Lazy Tree Construction',
      'detail': 'Build TreeSliverNode lists lazily — only populate '
          'children when the parent is first expanded, not upfront. '
          'This keeps initial load fast for large datasets.',
      'icon': Icons.hourglass_empty,
      'color': Color(0xFF5C6BC0),
    },
    {
      'title': 'Preserve Controller Across Rebuilds',
      'detail': 'Store TreeSliverController in a State field, not in '
          'build(). Recreating it loses expansion state and wastes '
          'AnimationController instances.',
      'icon': Icons.save,
      'color': Color(0xFFE65100),
    },
    {
      'title': 'Custom Node Builder for Rich UIs',
      'detail': 'The default tree node builder is simple text. Override '
          'treeNodeBuilder to add icons, trailing actions, context '
          'menus, and drag handles per node type.',
      'icon': Icons.design_services,
      'color': Color(0xFF5C6BC0),
    },
    {
      'title': 'Animate State Changes',
      'detail': 'TreeSliver animates child insertion/removal. Keep '
          'animation durations short (200–300 ms) for a responsive '
          'feel when expanding deep branches.',
      'icon': Icons.animation,
      'color': Color(0xFFE65100),
    },
    {
      'title': 'Scope to CustomScrollView',
      'detail': 'TreeSliver is a sliver — it must live inside a '
          'CustomScrollView (or NestedScrollView). Do not try to '
          'place it inside a regular Column or Container.',
      'icon': Icons.view_column,
      'color': Color(0xFF5C6BC0),
    },
  ];

  print('  Practices: ${practices.length}');

  // ============================================================
  // BUILD THE UI
  // ============================================================
  print('=== Building UI ===');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ---- Title Banner ----
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF5C6BC0), Color(0xFFE65100)],
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Icon(Icons.account_tree, size: 48, color: Colors.white),
              SizedBox(height: 12),
              Text('TreeSliverController',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
              SizedBox(height: 6),
              Text(
                'The ChangeNotifier that manages expand/collapse state '
                'for hierarchical data rendered through TreeSliver — '
                'programmatic tree navigation in a lazy sliver.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Colors.white70),
              ),
            ],
          ),
        ),

        SizedBox(height: 24),

        // ---- Section 1: Concept ----
        _sectionHeader('1. Concept', Icons.lightbulb_outline, Color(0xFF5C6BC0)),
        SizedBox(height: 10),
        ...conceptCards.map((c) => Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: (c['accent'] as Color).withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12),
                  border: Border(left: BorderSide(color: c['accent'] as Color, width: 4)),
                ),
                padding: EdgeInsets.all(14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(c['icon'] as IconData, color: c['accent'] as Color, size: 28),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(c['title'] as String,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: c['accent'] as Color)),
                          SizedBox(height: 4),
                          Text(c['body'] as String, style: TextStyle(fontSize: 13)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),

        SizedBox(height: 20),

        // ---- Section 2: TreeSliverNode ----
        _sectionHeader('2. TreeSliverNode', Icons.circle, Color(0xFFE65100)),
        SizedBox(height: 10),
        ...nodeProperties.map((np) => Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                padding: EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: np['color'] as Color,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(np['property'] as String,
                          style: TextStyle(color: Colors.white, fontFamily: 'monospace', fontSize: 11, fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(np['type'] as String,
                              style: TextStyle(fontFamily: 'monospace', fontSize: 11, color: Colors.grey[600])),
                          SizedBox(height: 3),
                          Text(np['description'] as String,
                              style: TextStyle(fontSize: 12)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),

        SizedBox(height: 20),

        // ---- Section 3: Controller Methods ----
        _sectionHeader('3. Controller Methods', Icons.settings_remote, Color(0xFF5C6BC0)),
        SizedBox(height: 10),
        ...methods.map((m) => Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: (m['color'] as Color).withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(10),
                  border: Border(left: BorderSide(color: m['color'] as Color, width: 3)),
                ),
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(m['name'] as String,
                              style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace',
                                  fontSize: 12, color: m['color'] as Color)),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: Text(m['category'] as String,
                              style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(m['description'] as String,
                        style: TextStyle(fontSize: 12)),
                  ],
                ),
              ),
            )),

        SizedBox(height: 20),

        // ---- Section 4: Tree Construction ----
        _sectionHeader('4. Tree Construction', Icons.code, Color(0xFFE65100)),
        SizedBox(height: 10),
        Text('Defining a tree structure with TreeSliverNode:',
            style: TextStyle(fontSize: 13, color: Colors.grey[700])),
        SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(treeCode,
              style: TextStyle(fontFamily: 'monospace', fontSize: 11, color: Color(0xFF80CBC4))),
        ),
        SizedBox(height: 12),
        Text('Wiring controller and TreeSliver:',
            style: TextStyle(fontSize: 13, color: Colors.grey[700])),
        SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(usageCode,
              style: TextStyle(fontFamily: 'monospace', fontSize: 11, color: Color(0xFFFF8A65))),
        ),

        SizedBox(height: 20),

        // ---- Section 5: Indentation ----
        _sectionHeader('5. Indentation Types', Icons.format_indent_increase, Color(0xFF5C6BC0)),
        SizedBox(height: 10),
        ...indentTypes.map((it) => Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: (it['color'] as Color).withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: (it['color'] as Color).withValues(alpha: 0.3)),
                ),
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: it['color'] as Color,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(it['type'] as String,
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                    ),
                    SizedBox(height: 8),
                    Text(it['description'] as String, style: TextStyle(fontSize: 12)),
                    SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: Text(it['visual'] as String,
                          style: TextStyle(fontFamily: 'monospace', fontSize: 11)),
                    ),
                  ],
                ),
              ),
            )),

        SizedBox(height: 20),

        // ---- Section 6: Example Tree Visual ----
        _sectionHeader('6. Example Tree', Icons.forest, Color(0xFFE65100)),
        SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[300]!),
          ),
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ..._buildTreeVisual(sampleTree, 0),
            ],
          ),
        ),

        SizedBox(height: 20),

        // ---- Section 7: ChangeNotifier Pattern ----
        _sectionHeader('7. ChangeNotifier', Icons.notification_important, Color(0xFF5C6BC0)),
        SizedBox(height: 10),
        ...notifierAspects.map((a) => Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: (a['color'] as Color).withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(12),
                  border: Border(left: BorderSide(color: a['color'] as Color, width: 4)),
                ),
                padding: EdgeInsets.all(14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(a['icon'] as IconData, color: a['color'] as Color, size: 24),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(a['aspect'] as String,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: a['color'] as Color)),
                          SizedBox(height: 3),
                          Text(a['description'] as String,
                              style: TextStyle(fontSize: 12)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),

        SizedBox(height: 20),

        // ---- Section 8: Best Practices ----
        _sectionHeader('8. Best Practices', Icons.tips_and_updates, Color(0xFFE65100)),
        SizedBox(height: 10),
        ...practices.map((p) => Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                padding: EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        color: (p['color'] as Color).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(p['icon'] as IconData, color: p['color'] as Color, size: 18),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(p['title'] as String,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                          SizedBox(height: 3),
                          Text(p['detail'] as String,
                              style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),

        SizedBox(height: 24),

        // ---- Footer ----
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Icon(Icons.account_tree, color: Color(0xFF5C6BC0), size: 28),
              SizedBox(height: 6),
              Text(
                'TreeSliverController: ChangeNotifier-driven tree '
                'state management — expand, collapse, and animate '
                'hierarchical data in a lazy sliver viewport.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Colors.grey[700]),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
      ],
    ),
  );
}

// ── Tree Visualization Helper ────────────────────────────────────

List<Widget> _buildTreeVisual(List<Map<String, dynamic>> nodes, int depth) {
  final widgets = <Widget>[];
  for (final node in nodes) {
    final indent = depth * 24.0;
    final hasChildren = node.containsKey('children') && (node['children'] as List).isNotEmpty;
    final isExpanded = node['expanded'] == true;
    widgets.add(
      Padding(
        padding: EdgeInsets.only(left: indent, bottom: 4),
        child: Row(
          children: [
            if (hasChildren)
              Icon(
                isExpanded ? Icons.expand_more : Icons.chevron_right,
                size: 18,
                color: Colors.grey[600],
              )
            else
              SizedBox(width: 18),
            SizedBox(width: 4),
            Icon(node['icon'] as IconData, size: 18, color: node['color'] as Color),
            SizedBox(width: 6),
            Text(node['label'] as String,
                style: TextStyle(fontSize: 13, fontWeight: hasChildren ? FontWeight.w600 : FontWeight.normal)),
            if (hasChildren && !isExpanded) ...[
              SizedBox(width: 6),
              Text('(${(node['children'] as List).length})',
                  style: TextStyle(fontSize: 10, color: Colors.grey[500])),
            ],
          ],
        ),
      ),
    );
    if (hasChildren && isExpanded) {
      widgets.addAll(_buildTreeVisual(
        (node['children'] as List).cast<Map<String, dynamic>>(),
        depth + 1,
      ));
    }
  }
  return widgets;
}

// ── Section Header Helper ────────────────────────────────────────

Widget _sectionHeader(String title, IconData icon, Color color) {
  return Row(
    children: [
      Icon(icon, color: color, size: 22),
      SizedBox(width: 8),
      Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
    ],
  );
}
