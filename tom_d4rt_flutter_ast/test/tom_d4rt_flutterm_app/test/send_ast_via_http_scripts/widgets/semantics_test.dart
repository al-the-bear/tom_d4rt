// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests Semantics, MergeSemantics, ExcludeSemantics –
// the core accessibility annotation widgets. Deep Demo: Concept,
// Semantics widget properties, flags & actions, MergeSemantics,
// ExcludeSemantics, live accessibility demo, patterns, summary.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Semantics Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptPoints = <Map<String, dynamic>>[
    {
      'icon': Icons.accessibility_new,
      'title': 'Semantics Widget',
      'body': 'Annotates the widget tree with descriptions used by '
          'assistive technologies like screen readers. Each Semantics '
          'widget creates a SemanticsNode in the semantics tree with '
          'labels, flags, and actions.',
    },
    {
      'icon': Icons.merge,
      'title': 'MergeSemantics',
      'body': 'Combines the semantics of all descendants into a single '
          'node. Useful when multiple widgets should be announced '
          'together (e.g., icon + label in a list tile).',
    },
    {
      'icon': Icons.visibility_off,
      'title': 'ExcludeSemantics',
      'body': 'Removes descendants from the semantics tree entirely. '
          'Use for decorative elements that add no information for '
          'screen reader users (backgrounds, dividers, ornaments).',
    },
    {
      'icon': Icons.foundation,
      'title': 'Accessibility Foundation',
      'body': 'These three widgets form the foundation of Flutter '
          'accessibility. Most Material widgets use them internally. '
          'You use them directly for custom widgets.',
    },
  ];

  final conceptCards = <Widget>[];
  for (var i = 0; i < conceptPoints.length; i++) {
    final p = conceptPoints[i];
    print('Concept ${i + 1}: ${p['title']}');
    conceptCards.add(
      Container(
        margin: const EdgeInsets.only(bottom: 10.0),
        padding: const EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: Colors.blue.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.blue.withValues(alpha: 0.2)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(p['icon'] as IconData, color: Colors.blue.shade700, size: 26.0),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    p['title'] as String,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.blue.shade700,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    p['body'] as String,
                    style: TextStyle(fontSize: 12.5, color: Colors.grey.shade800, height: 1.4),
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
  // SECTION 2: Semantics Properties
  // ============================================================
  print('=== Section 2: Properties ===');

  final textProps = <Map<String, dynamic>>[
    {
      'name': 'label',
      'type': 'String?',
      'group': 'Text',
      'desc': 'Description for screen readers (e.g., "Submit button").',
    },
    {
      'name': 'value',
      'type': 'String?',
      'group': 'Text',
      'desc': 'Current value (e.g., "50%" for a slider).',
    },
    {
      'name': 'hint',
      'type': 'String?',
      'group': 'Text',
      'desc': 'Hint text (e.g., "Double tap to activate").',
    },
    {
      'name': 'tooltip',
      'type': 'String?',
      'group': 'Text',
      'desc': 'Tooltip text associated with the semantic node.',
    },
    {
      'name': 'attributedLabel',
      'type': 'AttributedString?',
      'group': 'Rich Text',
      'desc': 'Label with attributes (spell-out, locale).',
    },
    {
      'name': 'container',
      'type': 'bool',
      'group': 'Structure',
      'desc': 'Whether this is a boundary for semantics purposes.',
    },
    {
      'name': 'explicitChildNodes',
      'type': 'bool',
      'group': 'Structure',
      'desc': 'Force child nodes to be included individually.',
    },
    {
      'name': 'excludeSemantics',
      'type': 'bool',
      'group': 'Structure',
      'desc': 'Exclude all descendant semantics (like ExcludeSemantics).',
    },
    {
      'name': 'textDirection',
      'type': 'TextDirection?',
      'group': 'Layout',
      'desc': 'Reading direction (LTR/RTL) for the label text.',
    },
    {
      'name': 'sortKey',
      'type': 'SemanticsSortKey?',
      'group': 'Order',
      'desc': 'Controls reading order for screen readers.',
    },
  ];

  final propGroups = <String, List<Map<String, dynamic>>>{};
  for (final p in textProps) {
    final g = p['group'] as String;
    propGroups.putIfAbsent(g, () => []);
    propGroups[g]!.add(p);
  }

  final groupColors = <String, Color>{
    'Text': Colors.blue,
    'Rich Text': Colors.purple,
    'Structure': Colors.green,
    'Layout': Colors.orange,
    'Order': Colors.teal,
  };

  final propSections = <Widget>[];
  for (final entry in propGroups.entries) {
    final color = groupColors[entry.key] ?? Colors.grey;
    propSections.add(
      Container(
        margin: const EdgeInsets.only(bottom: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.08),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(9.0)),
              ),
              child: Text(
                entry.key,
                style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700, color: color),
              ),
            ),
            ...entry.value.map((p) => Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey.shade100)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        p['name'] as String,
                        style: TextStyle(fontSize: 11.5, fontFamily: 'monospace',
                            fontWeight: FontWeight.w700, color: color),
                      ),
                      const SizedBox(width: 6.0),
                      Text(
                        p['type'] as String,
                        style: TextStyle(fontSize: 10.0, fontFamily: 'monospace',
                            color: Colors.grey.shade500),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    p['desc'] as String,
                    style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 3: Semantic Flags
  // ============================================================
  print('=== Section 3: Flags ===');

  final flags = <Map<String, dynamic>>[
    {'flag': 'button', 'desc': 'Marks as a button element', 'color': Colors.blue, 'icon': Icons.smart_button},
    {'flag': 'header', 'desc': 'Section heading (h1-h6 equivalent)', 'color': Colors.purple, 'icon': Icons.title},
    {'flag': 'link', 'desc': 'Hyperlink element', 'color': Colors.teal, 'icon': Icons.link},
    {'flag': 'image', 'desc': 'Image content', 'color': Colors.green, 'icon': Icons.image},
    {'flag': 'slider', 'desc': 'Slider/range control', 'color': Colors.orange, 'icon': Icons.tune},
    {'flag': 'textField', 'desc': 'Text input field', 'color': Colors.indigo, 'icon': Icons.text_fields},
    {'flag': 'readOnly', 'desc': 'Cannot be modified', 'color': Colors.grey, 'icon': Icons.lock},
    {'flag': 'enabled', 'desc': 'Currently enabled/interactive', 'color': Colors.green, 'icon': Icons.toggle_on},
    {'flag': 'focusable', 'desc': 'Can receive keyboard focus', 'color': Colors.blue, 'icon': Icons.center_focus_strong},
    {'flag': 'focused', 'desc': 'Currently has focus', 'color': Colors.amber, 'icon': Icons.filter_center_focus},
    {'flag': 'checked', 'desc': 'Checked state (checkbox/radio)', 'color': Colors.green, 'icon': Icons.check_box},
    {'flag': 'selected', 'desc': 'Currently selected', 'color': Colors.purple, 'icon': Icons.check_circle},
    {'flag': 'toggled', 'desc': 'Toggle state (switch)', 'color': Colors.teal, 'icon': Icons.toggle_on},
    {'flag': 'hidden', 'desc': 'Present but hidden from user', 'color': Colors.red, 'icon': Icons.visibility_off},
    {'flag': 'obscured', 'desc': 'Content is obscured (password)', 'color': Colors.red, 'icon': Icons.password},
    {'flag': 'liveRegion', 'desc': 'Announces changes automatically', 'color': Colors.orange, 'icon': Icons.campaign},
  ];

  final flagRows = <Widget>[];
  for (var i = 0; i < flags.length; i += 2) {
    final left = flags[i];
    final right = i + 1 < flags.length ? flags[i + 1] : null;
    flagRows.add(
      Padding(
        padding: const EdgeInsets.only(bottom: 6.0),
        child: Row(
          children: [
            Expanded(child: _buildSemFlagChip(left)),
            const SizedBox(width: 8.0),
            Expanded(child: right != null ? _buildSemFlagChip(right) : const SizedBox.shrink()),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 4: MergeSemantics
  // ============================================================
  print('=== Section 4: MergeSemantics ===');

  final mergeDemo = _SemMergeDemo();

  // ============================================================
  // SECTION 5: ExcludeSemantics
  // ============================================================
  print('=== Section 5: ExcludeSemantics ===');

  final excludeDemo = _SemExcludeDemo();

  // ============================================================
  // SECTION 6: Live Demo
  // ============================================================
  print('=== Section 6: Live Demo ===');

  final liveDemo = _SemLiveDemo();

  // ============================================================
  // SECTION 7: Best Practices
  // ============================================================
  print('=== Section 7: Best Practices ===');

  final practices = <Map<String, dynamic>>[
    {
      'icon': Icons.label,
      'title': 'Always Label Custom Widgets',
      'color': Colors.blue,
      'good': 'Semantics(\n  label: "Delete item",\n  button: true,\n  child: customDeleteIcon,\n)',
      'bad': 'GestureDetector(\n  onTap: delete,\n  child: customDeleteIcon,\n  // No semantics!\n)',
    },
    {
      'icon': Icons.merge,
      'title': 'Merge Related Information',
      'color': Colors.green,
      'good': 'MergeSemantics(\n  child: Row(children: [\n    Icon(Icons.star),\n    Text("Favorite"),\n  ]),\n)',
      'bad': '// Icon and text announced\n// separately:\nRow(children: [\n  Icon(Icons.star),\n  Text("Favorite"),\n])',
    },
    {
      'icon': Icons.visibility_off,
      'title': 'Exclude Decorative Elements',
      'color': Colors.orange,
      'good': 'ExcludeSemantics(\n  child: Image.asset(\n    "decorative_bg.png",\n  ),\n)',
      'bad': '// Background image clutters\n// screen reader output:\nImage.asset(\n  "decorative_bg.png",\n)',
    },
    {
      'icon': Icons.sort,
      'title': 'Control Reading Order',
      'color': Colors.purple,
      'good': 'Semantics(\n  sortKey: OrdinalSortKey(1.0),\n  child: importantWidget,\n)',
      'bad': '// Default order may not\n// be logical for complex\n// layouts or overlays',
    },
  ];

  final practiceCards = <Widget>[];
  for (final pr in practices) {
    final color = pr['color'] as Color;
    practiceCards.add(
      Container(
        margin: const EdgeInsets.only(bottom: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.06),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(9.0)),
              ),
              child: Row(
                children: [
                  Icon(pr['icon'] as IconData, color: color, size: 20.0),
                  const SizedBox(width: 8.0),
                  Text(
                    pr['title'] as String,
                    style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w700, color: color),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.check_circle, size: 12.0, color: Colors.green),
                            const SizedBox(width: 4.0),
                            Text('Good', style: TextStyle(fontSize: 10.0,
                                fontWeight: FontWeight.w700, color: Colors.green.shade700)),
                          ],
                        ),
                        const SizedBox(height: 4.0),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors.green.withValues(alpha: 0.04),
                            borderRadius: BorderRadius.circular(4.0),
                            border: Border.all(color: Colors.green.withValues(alpha: 0.15)),
                          ),
                          child: Text(
                            pr['good'] as String,
                            style: TextStyle(fontSize: 10.0, fontFamily: 'monospace',
                                color: Colors.grey.shade700),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.cancel, size: 12.0, color: Colors.red),
                            const SizedBox(width: 4.0),
                            Text('Bad', style: TextStyle(fontSize: 10.0,
                                fontWeight: FontWeight.w700, color: Colors.red.shade700)),
                          ],
                        ),
                        const SizedBox(height: 4.0),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors.red.withValues(alpha: 0.04),
                            borderRadius: BorderRadius.circular(4.0),
                            border: Border.all(color: Colors.red.withValues(alpha: 0.15)),
                          ),
                          child: Text(
                            pr['bad'] as String,
                            style: TextStyle(fontSize: 10.0, fontFamily: 'monospace',
                                color: Colors.grey.shade700),
                          ),
                        ),
                      ],
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
    {'icon': Icons.accessibility_new, 'text': 'Semantics annotates widgets for screen readers and assistive tech'},
    {'icon': Icons.label, 'text': 'Use label, value, hint for text descriptions read aloud'},
    {'icon': Icons.flag, 'text': '16+ boolean flags mark widgets as buttons, headers, images, etc.'},
    {'icon': Icons.merge, 'text': 'MergeSemantics combines children into one announcement'},
    {'icon': Icons.visibility_off, 'text': 'ExcludeSemantics hides decorative elements from readers'},
    {'icon': Icons.sort, 'text': 'Use sortKey (OrdinalSortKey) to control reading order'},
  ];

  final summaryItems = <Widget>[];
  for (final sp in summaryPoints) {
    summaryItems.add(
      Padding(
        padding: const EdgeInsets.only(bottom: 6.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(sp['icon'] as IconData, size: 16.0, color: Colors.blue.shade700),
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                sp['text'] as String,
                style: TextStyle(fontSize: 12.5, color: Colors.grey.shade800, height: 1.3),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // BUILD TABBED LAYOUT
  // ============================================================
  print('Building tabbed layout');

  return DefaultTabController(
    length: 8,
    child: Scaffold(
      appBar: AppBar(
        title: const Text('Semantics'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        elevation: 2.0,
        bottom: const TabBar(
          isScrollable: true,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: [
            Tab(text: 'Concept'),
            Tab(text: 'Properties'),
            Tab(text: 'Flags'),
            Tab(text: 'MergeSemantics'),
            Tab(text: 'ExcludeSemantics'),
            Tab(text: 'Live Demo'),
            Tab(text: 'Best Practices'),
            Tab(text: 'Summary'),
          ],
        ),
      ),
      body: TabBarView(
        children: [
          // Tab 1: Concept
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSemBullet('Accessibility Widgets',
                    'Three core widgets that control how the semantics tree '
                    'represents your UI to assistive technologies.'),
                const SizedBox(height: 14.0),
                ...conceptCards,
              ],
            ),
          ),
          // Tab 2: Properties
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSemBullet('Semantics Widget Properties',
                    'Key parameters organized by category.'),
                const SizedBox(height: 14.0),
                ...propSections,
              ],
            ),
          ),
          // Tab 3: Flags
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSemBullet('Boolean Semantic Flags',
                    'Flags that describe the role and state of a widget.'),
                const SizedBox(height: 14.0),
                ...flagRows,
                const SizedBox(height: 10.0),
                Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Colors.amber.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.amber.shade300),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.info_outline, size: 16.0, color: Colors.amber.shade800),
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: Text(
                          'Semantics also has action callbacks like onTap, '
                          'onLongPress, onScrollLeft/Right/Up/Down, onCopy, '
                          'onCut, onPaste, onDismiss, and more. These define '
                          'what actions assistive tech can trigger.',
                          style: TextStyle(fontSize: 11.5, color: Colors.amber.shade900, height: 1.35),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Tab 4: MergeSemantics
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSemBullet('MergeSemantics',
                    'Combines semantic nodes of all descendants into '
                    'a single announcement.'),
                const SizedBox(height: 14.0),
                mergeDemo,
              ],
            ),
          ),
          // Tab 5: ExcludeSemantics
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSemBullet('ExcludeSemantics',
                    'Removes widgets from the semantics tree '
                    'to hide decorative or redundant elements.'),
                const SizedBox(height: 14.0),
                excludeDemo,
              ],
            ),
          ),
          // Tab 6: Live Demo
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSemBullet('Interactive Semantics Demo',
                    'Various semantic annotations applied to widgets. '
                    'Use the Accessibility Inspector to see the tree.'),
                const SizedBox(height: 14.0),
                liveDemo,
              ],
            ),
          ),
          // Tab 7: Best Practices
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSemBullet('Accessibility Best Practices',
                    'Do and do-not patterns for semantic annotations.'),
                const SizedBox(height: 14.0),
                ...practiceCards,
              ],
            ),
          ),
          // Tab 8: Summary
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSemBullet('Key Takeaways', ''),
                const SizedBox(height: 10.0),
                Container(
                  padding: const EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.blue.withValues(alpha: 0.05),
                        Colors.indigo.withValues(alpha: 0.05),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.blue.withValues(alpha: 0.2)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: summaryItems,
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

// ---------------------------------------------------------------------------
// Helper: section bullet
// ---------------------------------------------------------------------------
Widget _buildSemBullet(String title, String body) {
  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.blue.withValues(alpha: 0.04),
      borderRadius: BorderRadius.circular(8.0),
      border: Border(left: BorderSide(color: Colors.blue.shade700, width: 3.0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700, color: Colors.blue.shade700)),
        if (body.isNotEmpty) ...[
          const SizedBox(height: 4.0),
          Text(body, style: TextStyle(fontSize: 13.0, color: Colors.grey.shade700, height: 1.4)),
        ],
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Helper: flag chip
// ---------------------------------------------------------------------------
Widget _buildSemFlagChip(Map<String, dynamic> flag) {
  final color = flag['color'] as Color;
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(color: color.withValues(alpha: 0.2)),
    ),
    child: Row(
      children: [
        Icon(flag['icon'] as IconData, size: 14.0, color: color),
        const SizedBox(width: 6.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                flag['flag'] as String,
                style: TextStyle(fontSize: 10.0, fontFamily: 'monospace',
                    fontWeight: FontWeight.w700, color: color),
              ),
              Text(
                flag['desc'] as String,
                style: TextStyle(fontSize: 9.0, color: Colors.grey.shade600),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// MergeSemantics Demo
// ---------------------------------------------------------------------------
class _SemMergeDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'MergeSemantics Comparison',
            style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 14.0),
          // Without merge
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.red.withValues(alpha: 0.04),
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.red.withValues(alpha: 0.2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.cancel, size: 14.0, color: Colors.red),
                    const SizedBox(width: 6.0),
                    Text('Without MergeSemantics',
                        style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w700,
                            color: Colors.red.shade700)),
                  ],
                ),
                const SizedBox(height: 8.0),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6.0),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 24.0),
                      SizedBox(width: 10.0),
                      Text('Favorite', style: TextStyle(fontSize: 14.0)),
                      Spacer(),
                      Text('42 items', style: TextStyle(fontSize: 12.0, color: Colors.grey)),
                    ],
                  ),
                ),
                const SizedBox(height: 6.0),
                Text(
                  'Screen reader announces each element separately:\n'
                  '"star icon" ... "Favorite" ... "42 items"',
                  style: TextStyle(fontSize: 11.0, fontStyle: FontStyle.italic,
                      color: Colors.red.shade700, height: 1.3),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12.0),
          // With merge
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.green.withValues(alpha: 0.04),
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.green.withValues(alpha: 0.2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.check_circle, size: 14.0, color: Colors.green),
                    const SizedBox(width: 6.0),
                    Text('With MergeSemantics',
                        style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w700,
                            color: Colors.green.shade700)),
                  ],
                ),
                const SizedBox(height: 8.0),
                MergeSemantics(
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6.0),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 24.0),
                        SizedBox(width: 10.0),
                        Text('Favorite', style: TextStyle(fontSize: 14.0)),
                        Spacer(),
                        Text('42 items', style: TextStyle(fontSize: 12.0, color: Colors.grey)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 6.0),
                Text(
                  'Screen reader announces as one:\n'
                  '"star icon, Favorite, 42 items"',
                  style: TextStyle(fontSize: 11.0, fontStyle: FontStyle.italic,
                      color: Colors.green.shade700, height: 1.3),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14.0),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(6.0),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Text(
              'MergeSemantics(\n'
              '  child: Row(\n'
              '    children: [\n'
              '      Icon(Icons.star),\n'
              '      Text("Favorite"),\n'
              '      Text("42 items"),\n'
              '    ],\n'
              '  ),\n'
              ')',
              style: TextStyle(fontSize: 10.5, fontFamily: 'monospace',
                  color: Colors.grey.shade700),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// ExcludeSemantics Demo
// ---------------------------------------------------------------------------
class _SemExcludeDemo extends StatefulWidget {
  @override
  State<_SemExcludeDemo> createState() => _SemExcludeDemoState();
}

class _SemExcludeDemoState extends State<_SemExcludeDemo> {
  bool _excluding = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'ExcludeSemantics Toggle',
                style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700),
              ),
              const Spacer(),
              Switch(
                value: _excluding,
                activeColor: Colors.blue,
                onChanged: (v) => setState(() => _excluding = v),
              ),
            ],
          ),
          const SizedBox(height: 6.0),
          Text(
            'Toggle to see how ExcludeSemantics affects the '
            'semantic tree. When excluding is true, the child '
            'is hidden from screen readers.',
            style: TextStyle(fontSize: 12.0, color: Colors.grey.shade600, height: 1.3),
          ),
          const SizedBox(height: 14.0),
          // The excluded content
          ExcludeSemantics(
            excluding: _excluding,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                color: _excluding
                    ? Colors.red.withValues(alpha: 0.04)
                    : Colors.green.withValues(alpha: 0.04),
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  color: _excluding
                      ? Colors.red.withValues(alpha: 0.25)
                      : Colors.green.withValues(alpha: 0.25),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        _excluding ? Icons.visibility_off : Icons.visibility,
                        size: 18.0,
                        color: _excluding ? Colors.red : Colors.green,
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        _excluding ? 'Hidden from semantics tree' : 'Visible in semantics tree',
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w700,
                          color: _excluding ? Colors.red.shade700 : Colors.green.shade700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  const Text(
                    'This decorative content includes an image and '
                    'some ornamental text that should not be announced '
                    'by screen readers.',
                    style: TextStyle(fontSize: 13.0, height: 1.4),
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      Icon(Icons.palette, size: 30.0, color: Colors.purple.shade300),
                      const SizedBox(width: 8.0),
                      Icon(Icons.brush, size: 30.0, color: Colors.blue.shade300),
                      const SizedBox(width: 8.0),
                      Icon(Icons.auto_fix_high, size: 30.0, color: Colors.amber.shade300),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14.0),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(6.0),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Text(
              'ExcludeSemantics(\n'
              '  excluding: $_excluding,\n'
              '  child: decorativeContent,\n'
              ')',
              style: TextStyle(fontSize: 11.0, fontFamily: 'monospace',
                  color: Colors.grey.shade700),
            ),
          ),
          const SizedBox(height: 10.0),
          Row(
            children: [
              Expanded(
                child: _excludeUseCase('Decorative images', Icons.image, Colors.purple),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: _excludeUseCase('Background art', Icons.wallpaper, Colors.teal),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: _excludeUseCase('Redundant text', Icons.text_fields, Colors.orange),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _excludeUseCase(String label, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          Icon(icon, size: 20.0, color: color),
          const SizedBox(height: 4.0),
          Text(label, style: TextStyle(fontSize: 9.0, color: color),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Live Semantics Demo
// ---------------------------------------------------------------------------
class _SemLiveDemo extends StatefulWidget {
  @override
  State<_SemLiveDemo> createState() => _SemLiveDemoState();
}

class _SemLiveDemoState extends State<_SemLiveDemo> {
  bool _isChecked = false;
  double _sliderValue = 0.5;
  int _counter = 0;
  String _lastAction = 'None';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Various Semantic Annotations',
            style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 14.0),
          // Header semantics
          Semantics(
            header: true,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Row(
                children: [
                  Icon(Icons.title, size: 16.0, color: Colors.blue),
                  const SizedBox(width: 8.0),
                  Text('Section Header (header: true)',
                      style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700,
                          color: Colors.blue.shade700)),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                    decoration: BoxDecoration(
                      color: Colors.blue.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text('header', style: TextStyle(fontSize: 9.0,
                        fontFamily: 'monospace', color: Colors.blue.shade700)),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          // Button semantics
          Semantics(
            button: true,
            label: 'Increment counter',
            child: InkWell(
              onTap: () => setState(() {
                _counter++;
                _lastAction = 'Counter incremented to $_counter';
              }),
              borderRadius: BorderRadius.circular(8.0),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.green.withValues(alpha: 0.2)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.add_circle, size: 20.0, color: Colors.green),
                    const SizedBox(width: 8.0),
                    Text('Counter: $_counter (button: true)',
                        style: TextStyle(fontSize: 12.0, color: Colors.green.shade700)),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                      decoration: BoxDecoration(
                        color: Colors.green.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Text('button', style: TextStyle(fontSize: 9.0,
                          fontFamily: 'monospace', color: Colors.green.shade700)),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          // Checkbox with checked semantics
          Semantics(
            label: 'Enable notifications',
            checked: _isChecked,
            child: InkWell(
              onTap: () => setState(() {
                _isChecked = !_isChecked;
                _lastAction = 'Checkbox: $_isChecked';
              }),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.purple.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.purple.withValues(alpha: 0.2)),
                ),
                child: Row(
                  children: [
                    Icon(
                      _isChecked ? Icons.check_box : Icons.check_box_outline_blank,
                      size: 20.0,
                      color: Colors.purple,
                    ),
                    const SizedBox(width: 8.0),
                    Text('Enable notifications (checked: $_isChecked)',
                        style: TextStyle(fontSize: 12.0, color: Colors.purple.shade700)),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                      decoration: BoxDecoration(
                        color: Colors.purple.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Text('checked', style: TextStyle(fontSize: 9.0,
                          fontFamily: 'monospace', color: Colors.purple.shade700)),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          // Slider with value semantics
          Semantics(
            label: 'Volume',
            value: '${(_sliderValue * 100).round()}%',
            slider: true,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: Colors.orange.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.orange.withValues(alpha: 0.2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('Volume: ${(_sliderValue * 100).round()}% (slider: true)',
                          style: TextStyle(fontSize: 12.0, color: Colors.orange.shade700)),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                        decoration: BoxDecoration(
                          color: Colors.orange.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Text('slider', style: TextStyle(fontSize: 9.0,
                            fontFamily: 'monospace', color: Colors.orange.shade700)),
                      ),
                    ],
                  ),
                  Slider(
                    value: _sliderValue,
                    onChanged: (v) => setState(() {
                      _sliderValue = v;
                      _lastAction = 'Slider: ${(v * 100).round()}%';
                    }),
                    activeColor: Colors.orange,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          // Image semantics
          Semantics(
            image: true,
            label: 'App logo icon',
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.teal.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.teal.withValues(alpha: 0.2)),
              ),
              child: Row(
                children: [
                  Icon(Icons.flutter_dash, size: 32.0, color: Colors.teal),
                  const SizedBox(width: 10.0),
                  Text('Image element (image: true, label: "App logo icon")',
                      style: TextStyle(fontSize: 12.0, color: Colors.teal.shade700)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          // Live region
          Semantics(
            liveRegion: true,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.amber.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(color: Colors.amber.shade300),
              ),
              child: Row(
                children: [
                  Icon(Icons.campaign, size: 16.0, color: Colors.amber.shade800),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Text(
                      'Live region: "$_lastAction" (auto-announced)',
                      style: TextStyle(fontSize: 11.0, color: Colors.amber.shade900),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
