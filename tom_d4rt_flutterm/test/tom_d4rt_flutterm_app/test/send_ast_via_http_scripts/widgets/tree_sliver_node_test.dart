// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — TreeSliverNode
// Demonstrates TreeSliverNode, the data model for hierarchical nodes
// used by TreeSliver. Each node holds content, optional children,
// and expansion state to drive tree visualizations.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TreeSliverNode Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptItems = <Map<String, dynamic>>[
    {
      'icon': Icons.account_tree,
      'title': 'What is TreeSliverNode?',
      'body': 'TreeSliverNode<T> is a generic data class that models one '
          'node in a tree hierarchy. It pairs user content of type T '
          'with tree metadata: child nodes, expansion state, and '
          'computed depth. It feeds TreeSliver for rendering.',
      'accent': Colors.teal,
    },
    {
      'icon': Icons.folder_open,
      'title': 'Hierarchical Data',
      'body': 'Trees are everywhere: file systems, org charts, menus, '
          'nested categories. TreeSliverNode models these naturally. '
          'Each node can have zero or more children, forming branches '
          'and leaves in an expandable tree.',
      'accent': Colors.blue,
    },
    {
      'icon': Icons.data_object,
      'title': 'Generic Content',
      'body': 'The type parameter T holds your data: a String, a FileInfo, '
          'a MenuItem — anything. TreeSliverNode wraps it with tree '
          'structure metadata so Flutter can render and animate it.',
      'accent': Colors.deepOrange,
    },
    {
      'icon': Icons.expand_more,
      'title': 'Expansion State',
      'body': 'Each node tracks whether it is expanded or collapsed. When '
          'expanded, its children are visible. When collapsed, the '
          'children are hidden. This state drives the TreeSliver\u0027s '
          'layout and animations.',
      'accent': Colors.green,
    },
  ];

  final conceptCards = <Widget>[];
  for (var i = 0; i < conceptItems.length; i++) {
    final item = conceptItems[i];
    final accent = item['accent'] as Color;
    print('Concept ${i + 1}: ${item['title']}');
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
                child: Icon(item['icon'] as IconData, color: accent, size: 26),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['title'] as String,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: accent,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      item['body'] as String,
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
      'name': 'content',
      'type': 'T',
      'desc': 'The user data for this node. Can be any type: String, int, '
          'custom object. Accessed when building the visual row for '
          'this node in TreeSliver.',
    },
    {
      'name': 'children',
      'type': 'List<TreeSliverNode<T>>',
      'desc': 'Child nodes forming branches of the tree. An empty list means '
          'this is a leaf node (no expand arrow). Can be modified '
          'dynamically to add or remove subtrees.',
    },
    {
      'name': 'expanded',
      'type': 'bool',
      'desc': 'Whether this node\u0027s children are currently visible. Default '
          'is false (collapsed). Set to true to show children. Only '
          'meaningful for nodes that have children.',
    },
    {
      'name': 'depth',
      'type': 'int (computed)',
      'desc': 'The level of nesting for this node. Root nodes have depth 0, '
          'their children have depth 1, etc. Used for indentation. '
          'Computed by TreeSliver, not set manually.',
    },
  ];

  final apiWidgets = <Widget>[];
  for (var i = 0; i < apiEntries.length; i++) {
    final ae = apiEntries[i];
    print('API ${i + 1}: ${ae['name']}');
    apiWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: i.isEven
              ? Colors.teal.withOpacity(0.06)
              : Colors.grey.withOpacity(0.03),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.teal.withOpacity(0.25)),
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
                    color: Colors.teal.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    ae['name']!,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.teal,
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
                      fontSize: 10,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
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

  // ============================================================
  // SECTION 3: Construction
  // ============================================================
  print('=== Section 3: Construction ===');

  final constructionExamples = <Map<String, dynamic>>[
    {
      'title': 'Leaf Node (No Children)',
      'code': 'TreeSliverNode<String>(\n'
          '  "readme.txt",\n'
          ')',
      'desc': 'Simplest form: a leaf node with just content. No expand '
          'arrow will appear since it has no children.',
      'icon': Icons.insert_drive_file,
      'color': Colors.grey,
    },
    {
      'title': 'Branch Node (With Children)',
      'code': 'TreeSliverNode<String>(\n'
          '  "src/",\n'
          '  children: [\n'
          '    TreeSliverNode("main.dart"),\n'
          '    TreeSliverNode("utils.dart"),\n'
          '  ],\n'
          ')',
      'desc': 'A branch node that contains two leaf children. Shows an '
          'expand/collapse toggle.',
      'icon': Icons.folder,
      'color': Colors.amber,
    },
    {
      'title': 'Pre-Expanded Node',
      'code': 'TreeSliverNode<String>(\n'
          '  "lib/",\n'
          '  children: [...],\n'
          '  expanded: true,\n'
          ')',
      'desc': 'Create a node that starts expanded. Its children are '
          'visible immediately without user interaction.',
      'icon': Icons.folder_open,
      'color': Colors.teal,
    },
    {
      'title': 'Deep Nesting',
      'code': 'TreeSliverNode("root/",\n'
          '  children: [\n'
          '    TreeSliverNode("level1/",\n'
          '      children: [\n'
          '        TreeSliverNode("level2/",\n'
          '          children: [\n'
          '            TreeSliverNode("deep.txt"),\n'
          '          ],\n'
          '        ),\n'
          '      ],\n'
          '    ),\n'
          '  ],\n'
          ')',
      'desc': 'Nodes can nest arbitrarily deep. Each level increases '
          'the depth value and indent.',
      'icon': Icons.account_tree,
      'color': Colors.blue,
    },
    {
      'title': 'Custom Content Type',
      'code': 'class FileInfo {\n'
          '  final String name;\n'
          '  final int sizeKb;\n'
          '  FileInfo(this.name, this.sizeKb);\n'
          '}\n'
          '\n'
          'TreeSliverNode<FileInfo>(\n'
          '  FileInfo("photo.jpg", 2048),\n'
          '  children: [],\n'
          ')',
      'desc': 'Use any type T as content. The tree builder callback '
          'accesses node.content to display your custom data.',
      'icon': Icons.data_object,
      'color': Colors.deepOrange,
    },
  ];

  final constructionWidgets = <Widget>[];
  for (var i = 0; i < constructionExamples.length; i++) {
    final ce = constructionExamples[i];
    final ceColor = ce['color'] as Color;
    print('Construction ${i + 1}: ${ce['title']}');
    constructionWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: ceColor.withOpacity(0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    ce['icon'] as IconData,
                    color: ceColor,
                    size: 20,
                  ),
                ),
                if (i < constructionExamples.length - 1)
                  Container(
                    width: 2,
                    height: 40,
                    color: ceColor.withOpacity(0.2),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: ceColor.withOpacity(0.04),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: ceColor.withOpacity(0.15)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ce['title'] as String,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: ceColor,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      ce['desc'] as String,
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
                        color: const Color(0xFF1E1E2E),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        ce['code'] as String,
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 10,
                          color: Color(0xFFCDD6F4),
                          height: 1.4,
                        ),
                      ),
                    ),
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
  // SECTION 4: Children
  // ============================================================
  print('=== Section 4: Children ===');

  // Visual tree display showing leaf vs branch nodes
  final treeVisualization = <Map<String, dynamic>>[
    {
      'line': '\u25BC project/ (branch, 3 children)',
      'depth': 0,
      'isLeaf': false,
      'color': Colors.amber,
    },
    {
      'line': '  \u25BC src/ (branch, 2 children)',
      'depth': 1,
      'isLeaf': false,
      'color': Colors.amber,
    },
    {
      'line': '    \u25CF main.dart (leaf)',
      'depth': 2,
      'isLeaf': true,
      'color': Colors.grey,
    },
    {
      'line': '    \u25CF helpers.dart (leaf)',
      'depth': 2,
      'isLeaf': true,
      'color': Colors.grey,
    },
    {
      'line': '  \u25B6 test/ (branch, collapsed)',
      'depth': 1,
      'isLeaf': false,
      'color': Colors.teal,
    },
    {
      'line': '  \u25CF README.md (leaf)',
      'depth': 1,
      'isLeaf': true,
      'color': Colors.grey,
    },
  ];

  final treeVizWidgets = <Widget>[];
  for (var i = 0; i < treeVisualization.length; i++) {
    final tv = treeVisualization[i];
    final tvColor = tv['color'] as Color;
    final depth = tv['depth'] as int;
    treeVizWidgets.add(
      Container(
        margin: EdgeInsets.only(left: 16.0 + depth * 24.0, right: 16, top: 3, bottom: 3),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: tvColor.withOpacity(tv['isLeaf'] as bool ? 0.04 : 0.08),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: tvColor.withOpacity(0.2)),
        ),
        child: Row(
          children: [
            Icon(
              tv['isLeaf'] as bool ? Icons.insert_drive_file : Icons.folder,
              size: 16,
              color: tvColor,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                tv['line'] as String,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                  color: tvColor,
                  fontWeight: tv['isLeaf'] as bool
                      ? FontWeight.normal
                      : FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final childrenNotes = <Map<String, dynamic>>[
    {
      'title': 'Leaf Nodes',
      'desc': 'Nodes with an empty children list or null children. They '
          'cannot be expanded. In a file explorer, files are leaves.',
      'icon': Icons.insert_drive_file,
      'color': Colors.grey,
    },
    {
      'title': 'Branch Nodes',
      'desc': 'Nodes with at least one child. They show an expand/collapse '
          'indicator. In a file explorer, folders are branches.',
      'icon': Icons.folder,
      'color': Colors.amber,
    },
    {
      'title': 'Dynamic Children',
      'desc': 'Children can be added or removed at runtime. Calling '
          'setState after modifying children rebuilds the tree view.',
      'icon': Icons.add_circle_outline,
      'color': Colors.blue,
    },
    {
      'title': 'Lazy Children',
      'desc': 'For large trees, populate children on demand when the user '
          'expands a node. This avoids loading the entire tree upfront.',
      'icon': Icons.hourglass_empty,
      'color': Colors.green,
    },
  ];

  final childNoteWidgets = <Widget>[];
  for (var i = 0; i < childrenNotes.length; i++) {
    final cn = childrenNotes[i];
    final cnColor = cn['color'] as Color;
    print('Children ${i + 1}: ${cn['title']}');
    childNoteWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: cnColor.withOpacity(0.05),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: cnColor.withOpacity(0.2)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(cn['icon'] as IconData, color: cnColor, size: 22),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cn['title'] as String,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: cnColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    cn['desc'] as String,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade700,
                      height: 1.35,
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
  // SECTION 5: Expansion State
  // ============================================================
  print('=== Section 5: Expansion ===');

  final expansionStates = <Map<String, dynamic>>[
    {
      'state': 'Collapsed (default)',
      'desc': 'Children are hidden. The expand arrow points right (\u25B6). '
          'This is the initial state for all newly created nodes '
          'unless expanded: true is passed.',
      'visual': '\u25B6 Documents/',
      'children': '  (3 children hidden)',
      'color': Colors.grey,
    },
    {
      'state': 'Expanded',
      'desc': 'Children are visible in the list. The expand arrow points '
          'down (\u25BC). Set expanded: true in the constructor or '
          'toggle by user tap.',
      'visual': '\u25BC Documents/',
      'children': '  \u251C Resume.pdf\n  \u251C Cover.docx\n  \u2514 Notes.txt',
      'color': Colors.teal,
    },
    {
      'state': 'Toggling',
      'desc': 'TreeSliver animates the expansion. Children slide in or '
          'out smoothly. The node\u0027s expanded flag is flipped. '
          'TreeSliver handles the animation automatically.',
      'visual': '\u25BC\u2192\u25B6 Archiving...',
      'children': '  (children sliding out)',
      'color': Colors.blue,
    },
  ];

  final expansionWidgets = <Widget>[];
  for (var i = 0; i < expansionStates.length; i++) {
    final es = expansionStates[i];
    final esColor = es['color'] as Color;
    print('Expansion ${i + 1}: ${es['state']}');
    expansionWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: esColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: esColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                es['state'] as String,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: esColor,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                es['desc'] as String,
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
                  color: const Color(0xFF1E1E2E),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      es['visual'] as String,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: esColor,
                        height: 1.5,
                      ),
                    ),
                    Text(
                      es['children'] as String,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11,
                        color: Color(0xFFCDD6F4),
                        height: 1.5,
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
  // SECTION 6: Depth & Indentation
  // ============================================================
  print('=== Section 6: Depth ===');

  final depthRows = <Map<String, dynamic>>[
    {'depth': 0, 'label': 'Root node', 'indent': 0, 'color': Colors.teal},
    {'depth': 1, 'label': 'First child', 'indent': 24, 'color': Colors.blue},
    {'depth': 2, 'label': 'Grandchild', 'indent': 48, 'color': Colors.green},
    {'depth': 3, 'label': 'Great-grandchild', 'indent': 72, 'color': Colors.orange},
    {'depth': 4, 'label': 'Deep descendant', 'indent': 96, 'color': Colors.red},
    {'depth': 5, 'label': 'Very deep node', 'indent': 120, 'color': Colors.purple},
  ];

  final depthWidgets = <Widget>[];
  for (var i = 0; i < depthRows.length; i++) {
    final dr = depthRows[i];
    final drColor = dr['color'] as Color;
    final indent = dr['indent'] as int;
    print('Depth ${dr['depth']}: ${dr['label']}');
    depthWidgets.add(
      Container(
        margin: EdgeInsets.only(
          left: 16.0 + indent,
          right: 16,
          top: 4,
          bottom: 4,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: drColor.withOpacity(0.08),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: drColor.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: drColor.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '${dr['depth']}',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: drColor,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              dr['label'] as String,
              style: TextStyle(
                fontSize: 13,
                color: drColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            Text(
              'indent: ${indent}px',
              style: TextStyle(
                fontSize: 10,
                fontFamily: 'monospace',
                color: drColor.withOpacity(0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final depthNotes = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.teal.withOpacity(0.06),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.teal.withOpacity(0.2)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Default indent: depth * 24.0 pixels',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.teal,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'TreeSliver\u0027s treeNodeBuilder receives the node with its depth. '
          'Use depth for indentation: EdgeInsets.only(left: node.depth * 24.0). '
          'Customize the multiplier for wider or narrower trees.',
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey.shade700,
            height: 1.4,
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 7: Real-World Trees
  // ============================================================
  print('=== Section 7: Real-World Trees ===');

  final realWorldTrees = <Map<String, dynamic>>[
    {
      'title': 'File Explorer',
      'icon': Icons.folder_special,
      'desc': 'Most iconic use. Folders as branches, files as leaves. '
          'Content type: FileSystemEntity or custom FileNode.',
      'example': 'TreeSliverNode<FileNode>(FileNode("src/", isDir: true),\n'
          '  children: [TreeSliverNode(FileNode("main.dart"))])',
      'color': Colors.amber,
    },
    {
      'title': 'Organization Chart',
      'icon': Icons.people,
      'desc': 'Each person node contains employees as children. '
          'Expanding reveals direct reports.',
      'example': 'TreeSliverNode(Person("CEO"),\n'
          '  children: [\n'
          '    TreeSliverNode(Person("CTO"), children: [...]),\n'
          '    TreeSliverNode(Person("CFO"), children: [...]),\n'
          '  ])',
      'color': Colors.blue,
    },
    {
      'title': 'Category Browser',
      'icon': Icons.category,
      'desc': 'Product categories with subcategories. E-commerce apps '
          'use this for navigation and filtering.',
      'example': 'TreeSliverNode(Category("Electronics"),\n'
          '  children: [\n'
          '    TreeSliverNode(Category("Phones"), children: [...]),\n'
          '    TreeSliverNode(Category("Laptops"), children: [...]),\n'
          '  ])',
      'color': Colors.deepOrange,
    },
    {
      'title': 'Settings Menu',
      'icon': Icons.settings,
      'desc': 'Nested settings groups. Top-level sections expand to '
          'reveal individual settings.',
      'example': 'TreeSliverNode(SettingsGroup("Display"),\n'
          '  children: [\n'
          '    TreeSliverNode(Setting("Brightness")),\n'
          '    TreeSliverNode(Setting("Theme")),\n'
          '  ])',
      'color': Colors.teal,
    },
    {
      'title': 'Comment Threads',
      'icon': Icons.comment,
      'desc': 'Reddit-style nested replies. Each comment is a node, '
          'replies are children. Depth controls indentation.',
      'example': 'TreeSliverNode(Comment("Great post!"),\n'
          '  children: [\n'
          '    TreeSliverNode(Comment("Thanks!"), children: [...]),\n'
          '  ])',
      'color': Colors.green,
    },
  ];

  final realWorldWidgets = <Widget>[];
  for (var i = 0; i < realWorldTrees.length; i++) {
    final rw = realWorldTrees[i];
    final rwColor = rw['color'] as Color;
    print('RealWorld ${i + 1}: ${rw['title']}');
    realWorldWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: rwColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: rwColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(rw['icon'] as IconData, color: rwColor, size: 22),
                  const SizedBox(width: 8),
                  Text(
                    rw['title'] as String,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: rwColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                rw['desc'] as String,
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
                  color: const Color(0xFF1E1E2E),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  rw['example'] as String,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10,
                    color: Color(0xFFCDD6F4),
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
  // SECTION 8: Summary
  // ============================================================
  print('=== Section 8: Summary ===');

  final summaryPoints = <Map<String, dynamic>>[
    {
      'icon': Icons.account_tree,
      'text': 'TreeSliverNode<T> pairs your data with tree metadata: '
          'children, expansion state, and depth.',
    },
    {
      'icon': Icons.data_object,
      'text': 'Generic type T can be any content — String, custom class, '
          'enum. The tree builder accesses content to render rows.',
    },
    {
      'icon': Icons.expand_more,
      'text': 'Expansion is per-node boolean state. Toggle it and rebuild '
          'to show/hide children smoothly.',
    },
    {
      'icon': Icons.format_indent_increase,
      'text': 'Depth is computed by TreeSliver. Use it for visual '
          'indentation: left padding = depth * indent size.',
    },
    {
      'icon': Icons.insert_drive_file,
      'text': 'Leaf nodes (no children) have no expand arrow. Branch '
          'nodes (with children) show expand/collapse controls.',
    },
    {
      'icon': Icons.folder_special,
      'text': 'Common uses: file explorers, org charts, settings menus, '
          'category browsers, comment threads.',
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
          color: Colors.teal.withOpacity(0.04 + (i % 3) * 0.02),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.teal.withOpacity(0.15)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.teal.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                sp['icon'] as IconData,
                color: Colors.teal,
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
        title: const Text('TreeSliverNode'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        bottom: const TabBar(
          isScrollable: true,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: [
            Tab(icon: Icon(Icons.info_outline), text: 'Concept'),
            Tab(icon: Icon(Icons.api), text: 'API'),
            Tab(icon: Icon(Icons.build), text: 'Construction'),
            Tab(icon: Icon(Icons.folder), text: 'Children'),
            Tab(icon: Icon(Icons.expand_more), text: 'Expansion'),
            Tab(icon: Icon(Icons.format_indent_increase), text: 'Depth'),
            Tab(icon: Icon(Icons.lightbulb), text: 'Use Cases'),
            Tab(icon: Icon(Icons.summarize), text: 'Summary'),
          ],
        ),
      ),
      body: TabBarView(
        children: [
          // Tab 1
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.teal.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'TreeSliverNode: the data model for hierarchical tree nodes.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...conceptCards,
            ],
          ),
          // Tab 2
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.teal.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Properties and computed values of TreeSliverNode.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...apiWidgets,
            ],
          ),
          // Tab 3
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.teal.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Different ways to create and compose nodes.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...constructionWidgets,
            ],
          ),
          // Tab 4
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.teal.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Leaf nodes vs branch nodes and child management.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...treeVizWidgets,
              const SizedBox(height: 12),
              ...childNoteWidgets,
            ],
          ),
          // Tab 5
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.teal.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Expand and collapse behavior of tree nodes.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...expansionWidgets,
            ],
          ),
          // Tab 6
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.teal.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Visual depth levels and indentation patterns.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...depthWidgets,
              depthNotes,
            ],
          ),
          // Tab 7
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.teal.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Real-world scenarios where tree nodes model data.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...realWorldWidgets,
            ],
          ),
          // Tab 8
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.teal.withOpacity(0.12),
                      Colors.green.withOpacity(0.06),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Key takeaways about TreeSliverNode.',
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
