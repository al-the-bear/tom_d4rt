// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — SliverSemantics (conceptual name for sliver
// accessibility). This demo covers how to add semantic annotations to slivers
// for accessibility — using Semantics widgets, MergeSemantics, and
// ExcludeSemantics within sliver contexts. It shows the accessibility tree
// structure and how screen readers interact with sliver scroll views.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SliverSemantics Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptItems = <Map<String, dynamic>>[
    {
      'icon': Icons.accessibility_new,
      'title': 'Semantics in Slivers',
      'body': 'Semantics are accessibility annotations that describe UI '
          'elements to screen readers like TalkBack (Android) and VoiceOver '
          '(iOS). When building scrollable UIs with slivers, proper semantic '
          'annotations ensure the content is navigable and understandable '
          'for users with visual impairments.',
      'accent': Colors.brown,
    },
    {
      'icon': Icons.account_tree,
      'title': 'The Semantics Tree',
      'body': 'Flutter maintains a separate semantics tree alongside the '
          'widget tree and render tree. Each Semantics widget creates a node '
          'in this tree. Screen readers traverse the semantics tree, not the '
          'widget tree, so the semantics annotations determine what the user '
          'hears and can interact with.',
      'accent': Colors.indigo,
    },
    {
      'icon': Icons.view_list,
      'title': 'Slivers and Accessibility',
      'body': 'CustomScrollView and its slivers automatically generate some '
          'semantic information. SliverList items are announced as individual '
          'elements. But you may need to add custom labels, merge semantics '
          'of complex list items, or exclude decorative slivers.',
      'accent': Colors.green,
    },
    {
      'icon': Icons.build,
      'title': 'Key Semantic Widgets',
      'body': 'Semantics — adds a semantic node with label, hint, value, '
          'and actions. MergeSemantics — merges children into a single node. '
          'ExcludeSemantics — hides children from the tree. '
          'IndexedSemantics — provides ordering information for lists.',
      'accent': Colors.deepOrange,
    },
  ];

  final conceptCards = <Widget>[];
  for (var idx = 0; idx < conceptItems.length; idx++) {
    final e = conceptItems[idx];
    final accent = e['accent'] as Color;
    print('Concept ${idx + 1}: ${e['title']}');
    conceptCards.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [accent.withOpacity(0.12), accent.withOpacity(0.04)],
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
                child: Icon(e['icon'] as IconData, color: accent, size: 28),
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
  // SECTION 2: Key Properties
  // ============================================================
  print('=== Section 2: Properties ===');

  final propRows = <Map<String, String>>[
    {
      'param': 'label',
      'type': 'String?',
      'desc': 'A textual description of the widget. This is what the screen '
          'reader announces. For a button it might be "Submit", for an image '
          'it might describe the content.',
    },
    {
      'param': 'hint',
      'type': 'String?',
      'desc': 'A brief description of the result of performing an action. '
          'For example "Double tap to open settings" or "Swipe to delete".',
    },
    {
      'param': 'value',
      'type': 'String?',
      'desc': 'The current value of the widget, like "50%" for a slider '
          'or "On" for a switch.',
    },
    {
      'param': 'container',
      'type': 'bool',
      'desc': 'Whether this node introduces a new scope. A container node '
          'groups its children. Screen readers may announce "In: [label]" '
          'when entering a container.',
    },
    {
      'param': 'explicitChildNodes',
      'type': 'bool',
      'desc': 'If true, forces the child semantics to be explicit nodes '
          'rather than merged. Used when each child needs its own focus.',
    },
    {
      'param': 'sortKey',
      'type': 'SemanticsSortKey?',
      'desc': 'Controls the traversal order. OrdinalSortKey(1.0) comes '
          'before OrdinalSortKey(2.0). Without sort keys, traversal '
          'follows visual layout order.',
    },
  ];

  final propWidgets = <Widget>[];
  for (var i = 0; i < propRows.length; i++) {
    final row = propRows[i];
    print('Property ${i + 1}: ${row['param']}');
    propWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: i.isEven
              ? Colors.brown.withOpacity(0.06)
              : Colors.grey.withOpacity(0.04),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.brown.withOpacity(0.15)),
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
                    color: Colors.brown.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    row['param']!,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.brown,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    row['type']!,
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
              row['desc']!,
              style: TextStyle(
                fontSize: 13,
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
  // SECTION 3: Basic semantic annotations in sliver lists
  // ============================================================
  print('=== Section 3: Basic ===');

  final basicContacts = <Map<String, dynamic>>[
    {'name': 'Alice Johnson', 'email': 'alice@example.com', 'icon': Icons.person},
    {'name': 'Bob Martinez', 'email': 'bob@example.com', 'icon': Icons.person},
    {'name': 'Carol Chen', 'email': 'carol@example.com', 'icon': Icons.person},
    {'name': 'David Kim', 'email': 'david@example.com', 'icon': Icons.person},
    {'name': 'Emma Wilson', 'email': 'emma@example.com', 'icon': Icons.person},
    {'name': 'Frank Lopez', 'email': 'frank@example.com', 'icon': Icons.person},
    {'name': 'Grace Taylor', 'email': 'grace@example.com', 'icon': Icons.person},
    {'name': 'Henry Davis', 'email': 'henry@example.com', 'icon': Icons.person},
  ];

  final basicDemo = SizedBox(
    height: 400,
    child: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          title: const Text('Accessible Contacts'),
          backgroundColor: Colors.brown.shade600,
          pinned: true,
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext ctx, int index) {
              final contact = basicContacts[index];
              // MergeSemantics combines the avatar, name, and email into
              // a single semantic focus node, so the screen reader announces
              // them all together as one item.
              return MergeSemantics(
                child: Semantics(
                  label: '${contact['name']}, ${contact['email']}',
                  hint: 'Double tap to call',
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.brown.shade200,
                      child: Text(
                        (contact['name'] as String)[0],
                        style: TextStyle(
                          color: Colors.brown.shade800,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: Text(contact['name'] as String),
                    subtitle: Text(contact['email'] as String),
                    trailing: const Icon(Icons.phone, size: 18),
                  ),
                ),
              );
            },
            childCount: basicContacts.length,
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 4: Labeling strategies
  // ============================================================
  print('=== Section 4: Labeling ===');

  final labelStrategies = <Map<String, dynamic>>[
    {
      'name': 'Descriptive Label',
      'desc': 'Provide a full text label that describes what the element is. '
          'Example: "Profile picture of Alice Johnson". Essential for '
          'images and icons that have no text content.',
      'icon': Icons.label,
      'color': Colors.brown,
      'example': 'Semantics(label: "Profile photo of Alice")',
    },
    {
      'name': 'Action Hint',
      'desc': 'Tell the user what will happen when they interact. Example: '
          '"Double tap to open contact details, swipe left to delete".',
      'icon': Icons.touch_app,
      'color': Colors.blue,
      'example': 'Semantics(hint: "Double tap to open")',
    },
    {
      'name': 'Value Announcement',
      'desc': 'For widgets with state, announce the current value. Example: '
          'A rating widget says "4 out of 5 stars".',
      'icon': Icons.format_list_numbered,
      'color': Colors.orange,
      'example': 'Semantics(value: "4 of 5 stars")',
    },
    {
      'name': 'MergeSemantics',
      'desc': 'Combine multiple child elements into one semantic node. '
          'Without merge, a screen reader might focus on the icon, text, '
          'and subtitle separately — confusing the user.',
      'icon': Icons.call_merge,
      'color': Colors.green,
      'example': 'MergeSemantics(child: ListTile(...))',
    },
    {
      'name': 'ExcludeSemantics',
      'desc': 'Remove decorative elements from the semantics tree. Icons '
          'next to labeled text, dividers, and background decorations do '
          'not need to be announced by the screen reader.',
      'icon': Icons.visibility_off,
      'color': Colors.red,
      'example': 'ExcludeSemantics(child: Divider())',
    },
  ];

  final labelCards = <Widget>[];
  for (var i = 0; i < labelStrategies.length; i++) {
    final strat = labelStrategies[i];
    final sColor = strat['color'] as Color;
    print('Label strategy ${i + 1}: ${strat['name']}');
    labelCards.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: sColor.withOpacity(0.04),
          border: Border.all(color: sColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: sColor.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      strat['icon'] as IconData,
                      color: sColor,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      strat['name'] as String,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: sColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                strat['desc'] as String,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: sColor.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  strat['example'] as String,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11,
                    color: sColor,
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
  // SECTION 5: Container semantics
  // ============================================================
  print('=== Section 5: Container semantics ===');

  final containerExplanation = <Map<String, dynamic>>[
    {
      'title': 'Container = true',
      'body': 'Creates a semantic boundary. The node groups its children. '
          'Screen readers may announce entry/exit of the container. '
          'Use for logical groups like a card with multiple parts.',
      'visual': 'Scrollable list section',
      'icon': Icons.inventory_2,
      'color': Colors.brown,
    },
    {
      'title': 'Container = false (default)',
      'body': 'The semantic node sits alongside siblings in a flat list. '
          'No grouping boundary. Children appear as peers to the screen '
          'reader rather than nested under a parent.',
      'visual': 'Individual items',
      'icon': Icons.list,
      'color': Colors.blue,
    },
    {
      'title': 'explicitChildNodes = true',
      'body': 'Forces children to be separate semantic nodes even when '
          'they would normally be merged. Each child gets its own focus. '
          'Useful when each element needs independent interaction.',
      'visual': 'Each button focusable',
      'icon': Icons.call_split,
      'color': Colors.green,
    },
  ];

  final containerCards = <Widget>[];
  for (var i = 0; i < containerExplanation.length; i++) {
    final ce = containerExplanation[i];
    final cColor = ce['color'] as Color;
    print('Container ${i + 1}: ${ce['title']}');
    containerCards.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: cColor.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: cColor.withOpacity(0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: cColor.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(ce['icon'] as IconData, color: cColor, size: 22),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    ce['title'] as String,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: cColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              ce['body'] as String,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade700,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: cColor.withOpacity(0.08),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'Visual: ${ce['visual']}',
                style: TextStyle(
                  fontSize: 11,
                  fontStyle: FontStyle.italic,
                  color: cColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 6: Accessibility patterns
  // ============================================================
  print('=== Section 6: Patterns ===');

  final patterns = <Map<String, dynamic>>[
    {
      'title': 'Scrollable Region Announcement',
      'body': 'CustomScrollView automatically creates a "scrollable" '
          'semantic node. Screen readers announce "Scrollable area" and '
          'users can scroll with gestures. No extra code needed.',
      'icon': Icons.swap_vert,
      'color': Colors.brown,
    },
    {
      'title': 'List Item Counting',
      'body': 'When using SliverChildBuilderDelegate, Flutter automatically '
          'assigns IndexedSemantics so screen readers say "item 1 of 10", '
          '"item 2 of 10", etc. This gives users context of their position.',
      'icon': Icons.format_list_numbered,
      'color': Colors.indigo,
    },
    {
      'title': 'Custom Actions',
      'body': 'Add custom semantic actions for swipe actions, delete, '
          'and other gestures. These show up in the screen reader action '
          'menu. Example: CustomSemanticsAction(label: "Archive").',
      'icon': Icons.touch_app,
      'color': Colors.teal,
    },
    {
      'title': 'Live Regions',
      'body': 'When slivers load new content dynamically, use Semantics '
          'with liveRegion: true so screen readers announce the changes '
          'without the user needing to navigate to the new content.',
      'icon': Icons.campaign,
      'color': Colors.red,
    },
    {
      'title': 'Heading Levels',
      'body': 'Mark section headers in sliver lists as heading: true in '
          'Semantics. Screen readers let users jump between headings, '
          'making long lists faster to navigate.',
      'icon': Icons.title,
      'color': Colors.purple,
    },
    {
      'title': 'Hidden Decorative Elements',
      'body': 'Decorative dividers, background images, and spacer slivers '
          'should be wrapped in ExcludeSemantics so they do not clutter '
          'the screen reader navigation.',
      'icon': Icons.visibility_off,
      'color': Colors.grey,
    },
  ];

  final patternWidgets = <Widget>[];
  for (var i = 0; i < patterns.length; i++) {
    final pat = patterns[i];
    final pColor = pat['color'] as Color;
    print('Pattern ${i + 1}: ${pat['title']}');
    patternWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: pColor.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: pColor.withOpacity(0.2)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: pColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(pat['icon'] as IconData, color: pColor, size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pat['title'] as String,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: pColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    pat['body'] as String,
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
  // SECTION 7: Screen reader simulation
  // ============================================================
  print('=== Section 7: Screen reader sim ===');

  // Visual representation of what a screen reader "sees"
  final srNodes = <Map<String, dynamic>>[
    {
      'focus': 'Accessible Contacts',
      'type': 'Heading',
      'announcement': 'Accessible Contacts, heading',
      'color': Colors.brown,
    },
    {
      'focus': 'Scrollable area',
      'type': 'Scroll',
      'announcement': 'Scrollable area, 8 items',
      'color': Colors.blue,
    },
    {
      'focus': 'Alice Johnson, alice@example.com',
      'type': 'Button',
      'announcement': 'Alice Johnson, alice@example.com. Double tap to call. Item 1 of 8.',
      'color': Colors.green,
    },
    {
      'focus': 'Bob Martinez, bob@example.com',
      'type': 'Button',
      'announcement': 'Bob Martinez, bob@example.com. Double tap to call. Item 2 of 8.',
      'color': Colors.green,
    },
    {
      'focus': '[Divider]',
      'type': 'Excluded',
      'announcement': '(Not announced — ExcludeSemantics)',
      'color': Colors.grey,
    },
    {
      'focus': 'Carol Chen, carol@example.com',
      'type': 'Button',
      'announcement': 'Carol Chen, carol@example.com. Double tap to call. Item 3 of 8.',
      'color': Colors.green,
    },
  ];

  final srWidgets = <Widget>[];
  for (var i = 0; i < srNodes.length; i++) {
    final node = srNodes[i];
    final nColor = node['color'] as Color;
    final isExcluded = node['type'] == 'Excluded';
    print('SR node ${i + 1}: ${node['focus']}');
    srWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isExcluded
              ? Colors.grey.withOpacity(0.06)
              : nColor.withOpacity(0.05),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: nColor.withOpacity(isExcluded ? 0.1 : 0.25),
            style: isExcluded ? BorderStyle.none : BorderStyle.solid,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Focus indicator
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: isExcluded
                    ? Colors.grey.withOpacity(0.1)
                    : nColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(6),
                border: isExcluded
                    ? null
                    : Border.all(color: nColor.withOpacity(0.4), width: 2),
              ),
              child: Icon(
                isExcluded ? Icons.visibility_off : Icons.accessibility,
                color: isExcluded ? Colors.grey : nColor,
                size: 14,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        node['focus'] as String,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight:
                              isExcluded ? FontWeight.normal : FontWeight.w600,
                          color: isExcluded ? Colors.grey : nColor,
                          decoration: isExcluded
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: nColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Text(
                          node['type'] as String,
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w600,
                            color: nColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(
                    node['announcement'] as String,
                    style: TextStyle(
                      fontSize: 11,
                      fontStyle: FontStyle.italic,
                      color: isExcluded ? Colors.grey : Colors.grey.shade600,
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
      'icon': Icons.accessibility_new,
      'text': 'Add Semantics widgets to sliver list items to provide '
          'meaningful labels, hints, and values for screen readers.',
    },
    {
      'icon': Icons.call_merge,
      'text': 'Use MergeSemantics to combine complex list items (icon + '
          'title + subtitle) into a single screen reader focus node.',
    },
    {
      'icon': Icons.visibility_off,
      'text': 'Use ExcludeSemantics for decorative elements like dividers, '
          'spacers, and background images that add no information.',
    },
    {
      'icon': Icons.format_list_numbered,
      'text': 'SliverList automatically provides IndexedSemantics so screen '
          'readers can announce "item N of M".',
    },
    {
      'icon': Icons.title,
      'text': 'Mark section headers with heading: true in Semantics for '
          'efficient navigation with screen readers.',
    },
    {
      'icon': Icons.account_tree,
      'text': 'Use container: true to create semantic boundaries for '
          'logical groups, explicitChildNodes for independent focus.',
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
          color: Colors.brown.withOpacity(0.04 + (i % 3) * 0.02),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.brown.withOpacity(0.12)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.brown.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                sp['icon'] as IconData,
                color: Colors.brown.shade700,
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
        title: const Text('Sliver Semantics'),
        backgroundColor: Colors.brown.shade700,
        bottom: const TabBar(
          isScrollable: true,
          indicatorColor: Colors.white,
          tabs: [
            Tab(icon: Icon(Icons.info_outline), text: 'Concept'),
            Tab(icon: Icon(Icons.construction), text: 'Properties'),
            Tab(icon: Icon(Icons.list), text: 'Basic'),
            Tab(icon: Icon(Icons.label), text: 'Labeling'),
            Tab(icon: Icon(Icons.inventory_2), text: 'Container'),
            Tab(icon: Icon(Icons.pattern), text: 'Patterns'),
            Tab(icon: Icon(Icons.record_voice_over), text: 'Reader Sim'),
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
                  color: Colors.brown.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Accessibility in sliver scroll views: how to annotate '
                  'slivers with semantic information so screen readers can '
                  'navigate and announce your content meaningfully.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...conceptCards,
            ],
          ),

          // Tab 2: Properties
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.brown.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Key properties of the Semantics widget that are relevant '
                  'when building accessible sliver lists.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...propWidgets,
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
                  color: Colors.brown.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'A contacts list where each item uses MergeSemantics and '
                  'Semantics to provide a combined label and action hint.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: basicDemo,
                ),
              ),
            ],
          ),

          // Tab 4: Labeling
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.brown.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Different strategies for providing semantic information '
                  'to screen readers in sliver contexts.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...labelCards,
            ],
          ),

          // Tab 5: Container
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.brown.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'How the container and explicitChildNodes properties '
                  'affect the semantics tree structure.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...containerCards,
            ],
          ),

          // Tab 6: Patterns
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.brown.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Best practices and patterns for building accessible '
                  'sliver-based scroll views.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...patternWidgets,
            ],
          ),

          // Tab 7: Screen Reader Sim
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.brown.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'A simulated view of how a screen reader traverses the '
                  'semantics tree of our accessible contacts list. The '
                  'green nodes are focusable, grey means excluded.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...srWidgets,
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
                      Colors.brown.withOpacity(0.12),
                      Colors.orange.withOpacity(0.06),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Key points about sliver semantics and accessibility.',
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
