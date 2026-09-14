// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — TreeSliver
// Demonstrates TreeSliver, the scrollable widget that renders
// expandable/collapsible hierarchical tree structures using
// TreeSliverNode data models in a sliver context.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TreeSliver Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptItems = <Map<String, dynamic>>[
    {
      'icon': Icons.account_tree,
      'title': 'What is TreeSliver?',
      'body': 'TreeSliver is a sliver widget that renders a list of '
          'TreeSliverNode items as an expandable tree. It lazily '
          'builds only visible rows, making it efficient for very '
          'large trees with thousands of nodes.',
      'accent': Colors.indigo,
    },
    {
      'icon': Icons.view_list,
      'title': 'Sliver-Based',
      'body': 'TreeSliver is a sliver, so it works inside CustomScrollView. '
          'Combine it with other slivers like SliverAppBar, '
          'SliverToBoxAdapter, or SliverList for rich scrollable UIs.',
      'accent': Colors.blue,
    },
    {
      'icon': Icons.animation,
      'title': 'Animated Expand/Collapse',
      'body': 'TreeSliver animates the insertion and removal of child rows '
          'when a branch is expanded or collapsed. Smooth slide-in '
          'transitions give users clear visual feedback.',
      'accent': Colors.green,
    },
    {
      'icon': Icons.format_indent_increase,
      'title': 'Indentation & Guides',
      'body': 'Each level of nesting is visually indented. TreeSliver can '
          'also draw tree guide lines connecting parents to children, '
          'similar to IDE file explorers.',
      'accent': Colors.deepOrange,
    },
  ];

  final conceptCards = <Widget>[];
  for (var i = 0; i < conceptItems.length; i++) {
    final c = conceptItems[i];
    final accent = c['accent'] as Color;
    print('Concept ${i + 1}: ${c['title']}');
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
                child: Icon(c['icon'] as IconData, color: accent, size: 26),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      c['title'] as String,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: accent,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      c['body'] as String,
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
      'name': 'tree',
      'type': 'List<TreeSliverNode<T>>',
      'desc': 'The root-level nodes of the tree. Each root can have '
          'children forming sub-trees. The flat list of roots is '
          'the starting point for tree traversal.',
    },
    {
      'name': 'treeNodeBuilder',
      'type': 'TreeSliverNodeBuilder',
      'desc': 'Callback that builds a widget for each visible node. '
          'Receives the context, node, and animation value. If null, '
          'TreeSliver uses a default row builder.',
    },
    {
      'name': 'treeRowExtentBuilder',
      'type': 'TreeSliverRowExtentBuilder?',
      'desc': 'Optional callback to set the height of each tree row. '
          'Receives the node and returns a double. If null, rows '
          'use the default extent.',
    },
    {
      'name': 'indentation',
      'type': 'TreeSliverIndentationType',
      'desc': 'Controls how child levels are indented. Options: '
          'standard (fixed per level), custom (callback), '
          'or none. Also configures tree guide line painting.',
    },
    {
      'name': 'toggleAnimationStyle',
      'type': 'AnimationStyle?',
      'desc': 'Customize the expand/collapse animation duration and curve. '
          'Set AnimationStyle.noAnimation to disable transitions.',
    },
    {
      'name': 'onNodeToggle',
      'type': 'ValueChanged<TreeSliverNode<T>>?',
      'desc': 'Callback fired when a node is expanded or collapsed. '
          'Receives the toggled node. Useful for analytics, '
          'lazy loading children, or persisting expansion state.',
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
              ? Colors.indigo.withOpacity(0.06)
              : Colors.grey.withOpacity(0.03),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.indigo.withOpacity(0.25)),
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
                    color: Colors.indigo.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    ae['name']!,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.indigo,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Container(
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
                        fontSize: 9,
                        color: Colors.grey.shade600,
                      ),
                      overflow: TextOverflow.ellipsis,
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

  // ============================================================
  // SECTION 3: Building Rows
  // ============================================================
  print('=== Section 3: Building Rows ===');

  final buildExamples = <Map<String, dynamic>>[
    {
      'title': 'Default Row Builder',
      'desc': 'Without a treeNodeBuilder, TreeSliver renders a simple '
          'row with indentation and an expand arrow. Good for '
          'prototyping but limited in styling.',
      'code': 'TreeSliver<String>(\n'
          '  tree: myNodes,\n'
          '  // Uses default builder\n'
          ')',
      'color': Colors.indigo,
    },
    {
      'title': 'Custom Row Builder',
      'desc': 'Provide treeNodeBuilder to fully control each row\u0027s '
          'appearance. Receive the node, depth, and animation to '
          'build any widget you want.',
      'code': 'TreeSliver<FileNode>(\n'
          '  tree: fileTree,\n'
          '  treeNodeBuilder: (context, node, anim) {\n'
          '    return Padding(\n'
          '      padding: EdgeInsets.only(\n'
          '        left: node.depth * 24.0,\n'
          '      ),\n'
          '      child: Row(children: [\n'
          '        Icon(node.content.icon),\n'
          '        Text(node.content.name),\n'
          '      ]),\n'
          '    );\n'
          '  },\n'
          ')',
      'color': Colors.blue,
    },
    {
      'title': 'Animated Row Content',
      'desc': 'The animation parameter drives the expand/collapse '
          'transition. Use it for opacity fades or size changes '
          'as children appear.',
      'code': 'treeNodeBuilder: (ctx, node, anim) {\n'
          '  return SizeTransition(\n'
          '    sizeFactor: anim,\n'
          '    child: ListTile(\n'
          '      title: Text(node.content),\n'
          '    ),\n'
          '  );\n'
          '}',
      'color': Colors.green,
    },
    {
      'title': 'Rich Row with Actions',
      'desc': 'Build rows with icons, trailing buttons, context menus — '
          'anything a ListTile can do. Depth controls indentation.',
      'code': 'treeNodeBuilder: (ctx, node, anim) {\n'
          '  final isFolder = node.children.isNotEmpty;\n'
          '  return ListTile(\n'
          '    contentPadding: EdgeInsets.only(\n'
          '      left: 16 + node.depth * 24.0,\n'
          '    ),\n'
          '    leading: Icon(isFolder\n'
          '      ? Icons.folder : Icons.file_copy),\n'
          '    title: Text(node.content.name),\n'
          '    trailing: PopupMenuButton(...),\n'
          '  );\n'
          '}',
      'color': Colors.deepOrange,
    },
  ];

  final buildWidgets = <Widget>[];
  for (var i = 0; i < buildExamples.length; i++) {
    final be = buildExamples[i];
    final beColor = be['color'] as Color;
    print('Build ${i + 1}: ${be['title']}');
    buildWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: beColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: beColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                be['title'] as String,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: beColor,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                be['desc'] as String,
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
                  be['code'] as String,
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
  // SECTION 4: Indentation
  // ============================================================
  print('=== Section 4: Indentation ===');

  final indentTypes = <Map<String, dynamic>>[
    {
      'type': 'Standard (default)',
      'desc': 'Each level is indented by a fixed amount (typically 40 '
          'logical pixels). Consistent and predictable layout that '
          'works for most use cases.',
      'visual': [
        {'depth': 0, 'text': 'Root'},
        {'depth': 1, 'text': 'Child (40px indent)'},
        {'depth': 2, 'text': 'Grandchild (80px)'},
        {'depth': 3, 'text': 'Great-grandchild (120px)'},
      ],
      'color': Colors.indigo,
    },
    {
      'type': 'Custom',
      'desc': 'Provide a callback that returns the indentation for each '
          'node based on its depth. Useful for non-linear indent '
          'or progressively tighter nesting.',
      'visual': [
        {'depth': 0, 'text': 'Root (0px)'},
        {'depth': 1, 'text': 'Child (30px)'},
        {'depth': 2, 'text': 'Grandchild (50px)'},
        {'depth': 3, 'text': 'G-grandchild (65px)'},
      ],
      'color': Colors.blue,
    },
    {
      'type': 'None',
      'desc': 'No automatic indentation. All items are flush left. '
          'Handle indentation in your treeNodeBuilder manually. '
          'Full control over visual layout.',
      'visual': [
        {'depth': 0, 'text': 'Root (no indent)'},
        {'depth': 0, 'text': 'Child (no indent)'},
        {'depth': 0, 'text': 'Grandchild (no indent)'},
      ],
      'color': Colors.grey,
    },
  ];

  final indentWidgets = <Widget>[];
  for (var i = 0; i < indentTypes.length; i++) {
    final it = indentTypes[i];
    final itColor = it['color'] as Color;
    final visuals = it['visual'] as List<Map<String, dynamic>>;
    print('Indent ${i + 1}: ${it['type']}');
    indentWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: itColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: itColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                it['type'] as String,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: itColor,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                it['desc'] as String,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                  height: 1.35,
                ),
              ),
              const SizedBox(height: 10),
              ...visuals.map((v) {
                final d = v['depth'] as int;
                return Container(
                  margin: EdgeInsets.only(left: d * 30.0, top: 3, bottom: 3),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: itColor.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    v['text'] as String,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                      color: itColor,
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  // Guide lines visualization
  final guideLines = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: const Color(0xFF1E1E2E),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Tree Lines (like IDE file explorers):',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Color(0xFFA6E3A1),
          ),
        ),
        const SizedBox(height: 8),
        ...[
          '\u25BC project/',
          '\u2502  \u251C\u2500 src/',
          '\u2502  \u2502  \u251C\u2500 main.dart',
          '\u2502  \u2502  \u2514\u2500 utils.dart',
          '\u2502  \u251C\u2500 test/',
          '\u2502  \u2502  \u2514\u2500 main_test.dart',
          '\u2502  \u2514\u2500 README.md',
        ].map((line) => Text(
              line,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: Color(0xFFCDD6F4),
                height: 1.6,
              ),
            )),
      ],
    ),
  );

  // ============================================================
  // SECTION 5: Animation
  // ============================================================
  print('=== Section 5: Animation ===');

  final animItems = <Map<String, dynamic>>[
    {
      'title': 'Default Animation',
      'desc': 'TreeSliver uses a smooth slide-and-fade transition for '
          'expand/collapse. Children slide in from the top when '
          'expanding, and slide out when collapsing.',
      'code': 'TreeSliver<String>(\n'
          '  tree: nodes,\n'
          '  // Default animation applied\n'
          ')',
      'duration': '200ms (default)',
      'color': Colors.indigo,
    },
    {
      'title': 'Custom Duration',
      'desc': 'Override the animation timing with toggleAnimationStyle. '
          'Slower animations give dramatic flair; faster ones '
          'feel snappy.',
      'code': 'TreeSliver<String>(\n'
          '  tree: nodes,\n'
          '  toggleAnimationStyle: AnimationStyle(\n'
          '    duration: Duration(milliseconds: 500),\n'
          '    curve: Curves.easeInOutCubic,\n'
          '  ),\n'
          ')',
      'duration': '500ms custom',
      'color': Colors.blue,
    },
    {
      'title': 'No Animation',
      'desc': 'Disable animation entirely for instant expand/collapse. '
          'Good for accessibility (reduced motion) or dense trees '
          'where animation is distracting.',
      'code': 'TreeSliver<String>(\n'
          '  tree: nodes,\n'
          '  toggleAnimationStyle:\n'
          '    AnimationStyle.noAnimation,\n'
          ')',
      'duration': '0ms (instant)',
      'color': Colors.grey,
    },
    {
      'title': 'Animation in Row Builder',
      'desc': 'The treeNodeBuilder receives an Animation<double> for the '
          'expand transition. Use it for custom entry effects: fade, '
          'scale, or slide.',
      'code': 'treeNodeBuilder: (ctx, node, anim) {\n'
          '  return FadeTransition(\n'
          '    opacity: anim,\n'
          '    child: SizeTransition(\n'
          '      sizeFactor: anim,\n'
          '      child: MyRowWidget(node),\n'
          '    ),\n'
          '  );\n'
          '}',
      'duration': 'Built-in Animation<double>',
      'color': Colors.green,
    },
  ];

  final animWidgets = <Widget>[];
  for (var i = 0; i < animItems.length; i++) {
    final ai = animItems[i];
    final aiColor = ai['color'] as Color;
    print('Animation ${i + 1}: ${ai['title']}');
    animWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: aiColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: aiColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      ai['title'] as String,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: aiColor,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: aiColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      ai['duration'] as String,
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        color: aiColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                ai['desc'] as String,
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
                  ai['code'] as String,
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
  // SECTION 6: Interaction
  // ============================================================
  print('=== Section 6: Interaction ===');

  final interItems = <Map<String, dynamic>>[
    {
      'title': 'Tap to Toggle',
      'icon': Icons.touch_app,
      'desc': 'By default, tapping a branch node toggles its expansion. '
          'TreeSliver handles this internally. No extra gesture '
          'detector needed.',
      'color': Colors.indigo,
    },
    {
      'title': 'onNodeToggle Callback',
      'icon': Icons.notifications,
      'desc': 'React to expansions/collapses. Use for lazy loading — '
          'when a node is expanded, fetch its children from an API '
          'before they\u0027re displayed.',
      'color': Colors.blue,
    },
    {
      'title': 'Programmatic Control',
      'icon': Icons.code,
      'desc': 'Set node.expanded = true/false and rebuild to control '
          'expansion in code. Useful for "Expand All" or "Collapse '
          'All" buttons.',
      'color': Colors.green,
    },
    {
      'title': 'Selection State',
      'icon': Icons.check_circle,
      'desc': 'TreeSliver doesn\u0027t manage selection. Add selected '
          'state to your content type T and highlight rows '
          'in treeNodeBuilder based on that state.',
      'color': Colors.deepOrange,
    },
    {
      'title': 'Context Menus',
      'icon': Icons.more_vert,
      'desc': 'Add right-click or long-press menus in treeNodeBuilder. '
          'Wrap rows with GestureDetector or use PopupMenuButton '
          'as a trailing widget.',
      'color': Colors.purple,
    },
  ];

  final interWidgets = <Widget>[];
  for (var i = 0; i < interItems.length; i++) {
    final ii = interItems[i];
    final iiColor = ii['color'] as Color;
    print('Interaction ${i + 1}: ${ii['title']}');
    interWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: iiColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: iiColor.withOpacity(0.2)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: iiColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(ii['icon'] as IconData, color: iiColor, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ii['title'] as String,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: iiColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    ii['desc'] as String,
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
  // SECTION 7: Patterns
  // ============================================================
  print('=== Section 7: Patterns ===');

  final patternItems = <Map<String, dynamic>>[
    {
      'title': 'File Explorer',
      'icon': Icons.folder_open,
      'desc': 'The classic use: file system hierarchy. Folders expand to '
          'show nested files and subdirectories. Use icons to '
          'distinguish file types.',
      'code': 'CustomScrollView(\n'
          '  slivers: [\n'
          '    TreeSliver<FileNode>(\n'
          '      tree: fileSystemTree,\n'
          '      treeNodeBuilder: (ctx, node, anim) {\n'
          '        return FileRow(node: node);\n'
          '      },\n'
          '    ),\n'
          '  ],\n'
          ')',
      'color': Colors.amber,
    },
    {
      'title': 'Settings Groups',
      'desc': 'Expandable setting categories like "Display", "Sound", '
          '"Network". Each expands to show individual toggle/slider '
          'settings.',
      'icon': Icons.settings,
      'code': 'TreeSliver<SettingItem>(\n'
          '  tree: settingsTree,\n'
          '  treeNodeBuilder: (ctx, node, anim) {\n'
          '    if (node.children.isNotEmpty) {\n'
          '      return SectionHeader(node.content);\n'
          '    }\n'
          '    return SettingTile(node.content);\n'
          '  },\n'
          ')',
      'color': Colors.teal,
    },
    {
      'title': 'With Other Slivers',
      'desc': 'Combine TreeSliver with SliverAppBar, SliverPadding, or '
          'SliverList inside a CustomScrollView for rich layouts.',
      'icon': Icons.view_quilt,
      'code': 'CustomScrollView(\n'
          '  slivers: [\n'
          '    SliverAppBar(title: Text("Explorer")),\n'
          '    SliverPadding(\n'
          '      padding: EdgeInsets.all(8),\n'
          '      sliver: TreeSliver<String>(\n'
          '        tree: nodes,\n'
          '      ),\n'
          '    ),\n'
          '  ],\n'
          ')',
      'color': Colors.blue,
    },
  ];

  final patternWidgets = <Widget>[];
  for (var i = 0; i < patternItems.length; i++) {
    final pi = patternItems[i];
    final piColor = pi['color'] as Color;
    print('Pattern ${i + 1}: ${pi['title']}');
    patternWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: piColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: piColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(pi['icon'] as IconData, color: piColor, size: 22),
                  const SizedBox(width: 8),
                  Text(
                    pi['title'] as String,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: piColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                pi['desc'] as String,
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
                  pi['code'] as String,
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
      'text': 'TreeSliver renders hierarchical tree data as an '
          'expandable/collapsible scrollable list of rows.',
    },
    {
      'icon': Icons.view_list,
      'text': 'Works inside CustomScrollView alongside other slivers. '
          'Lazily builds only visible rows for performance.',
    },
    {
      'icon': Icons.build,
      'text': 'treeNodeBuilder provides full control over row appearance. '
          'Receives node content, depth, and expand animation.',
    },
    {
      'icon': Icons.format_indent_increase,
      'text': 'Indentation types: standard (40px per level), custom '
          'callback, or none. Tree guide lines optional.',
    },
    {
      'icon': Icons.animation,
      'text': 'Smooth expand/collapse animations by default. Customize '
          'with toggleAnimationStyle or disable entirely.',
    },
    {
      'icon': Icons.touch_app,
      'text': 'Tap toggles expansion. Use onNodeToggle for side effects '
          'like lazy loading or analytics.',
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
          color: Colors.indigo.withOpacity(0.04 + (i % 3) * 0.02),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.indigo.withOpacity(0.15)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.indigo.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                sp['icon'] as IconData,
                color: Colors.indigo,
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
        title: const Text('TreeSliver'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        bottom: const TabBar(
          isScrollable: true,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: [
            Tab(icon: Icon(Icons.info_outline), text: 'Concept'),
            Tab(icon: Icon(Icons.api), text: 'API'),
            Tab(icon: Icon(Icons.build), text: 'Building'),
            Tab(icon: Icon(Icons.format_indent_increase), text: 'Indentation'),
            Tab(icon: Icon(Icons.animation), text: 'Animation'),
            Tab(icon: Icon(Icons.touch_app), text: 'Interaction'),
            Tab(icon: Icon(Icons.code), text: 'Patterns'),
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
                  color: Colors.indigo.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'TreeSliver: a scrollable, animated, lazily-rendered '
                  'hierarchical tree widget for CustomScrollView.',
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
                  color: Colors.indigo.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'TreeSliver constructor parameters and callbacks.',
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
                  color: Colors.indigo.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Building custom tree row widgets with treeNodeBuilder.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...buildWidgets,
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
                  color: Colors.indigo.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Indentation types and tree guide lines.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...indentWidgets,
              guideLines,
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
                  color: Colors.indigo.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Expand/collapse animation and customization.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...animWidgets,
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
                  color: Colors.indigo.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'User interaction: tapping, selection, and context menus.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...interWidgets,
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
                  color: Colors.indigo.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Common patterns and compositions with TreeSliver.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...patternWidgets,
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
                      Colors.indigo.withOpacity(0.12),
                      Colors.blue.withOpacity(0.06),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Key takeaways about TreeSliver.',
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
