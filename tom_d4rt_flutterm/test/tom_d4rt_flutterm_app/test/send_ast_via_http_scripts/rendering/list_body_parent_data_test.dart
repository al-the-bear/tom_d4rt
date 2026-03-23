// ignore_for_file: avoid_print
// D4rt Flutter demo: ListBodyParentData - parent data in ListBody layouts
// Explores how ListBody uses parent data for sibling-linked child layout,
// vertical/horizontal arrangement, and the render tree's linked-list structure.
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Color theme constants
// ---------------------------------------------------------------------------
const _kTeal500 = Color(0xFF14B8A6);
const _kRose500 = Color(0xFFF43F5E);
const _kTeal100 = Color(0xFFCCFBF1);
const _kRose100 = Color(0xFFFFE4E6);
const _kTeal700 = Color(0xFF0F766E);
const _kRose700 = Color(0xFFBE123C);
const _kTeal50 = Color(0xFFF0FDFA);
const _kRose50 = Color(0xFFFFF1F2);
const _kGray100 = Color(0xFFF3F4F6);
const _kGray700 = Color(0xFF374151);
const _kGray500 = Color(0xFF6B7280);
const _kWhite = Color(0xFFFFFFFF);

// ---------------------------------------------------------------------------
// Section header builder
// ---------------------------------------------------------------------------
Widget _buildSectionHeader(String number, String title, String subtitle) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.only(top: 24, bottom: 12),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_kTeal500, _kRose500],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$number  $title',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: _kWhite,
          ),
        ),
        SizedBox(height: 4),
        Text(
          subtitle,
          style: TextStyle(fontSize: 13, color: _kWhite.withAlpha(204)),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Info card widget
// ---------------------------------------------------------------------------
Widget _buildInfoCard(String title, String content, Color accent) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _kWhite,
      border: Border(left: BorderSide(color: accent, width: 4)),
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
          color: accent.withAlpha(30),
          blurRadius: 6,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: _kGray700,
          ),
        ),
        SizedBox(height: 6),
        Text(content, style: TextStyle(fontSize: 13, color: _kGray500)),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Linked-list node visual
// ---------------------------------------------------------------------------
Widget _buildLinkedNode(String label, Color bg, Color border, bool hasArrow) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: bg,
          border: Border.all(color: border, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: _kGray700,
          ),
        ),
      ),
      if (hasArrow)
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4),
          child: Icon(Icons.arrow_forward, size: 18, color: _kTeal700),
        ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Sibling chain diagram row
// ---------------------------------------------------------------------------
Widget _buildSiblingChainDiagram(List<String> names) {
  final nodes = <Widget>[];
  for (var i = 0; i < names.length; i++) {
    final isEven = i % 2 == 0;
    nodes.add(
      _buildLinkedNode(
        names[i],
        isEven ? _kTeal100 : _kRose100,
        isEven ? _kTeal500 : _kRose500,
        i < names.length - 1,
      ),
    );
  }
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(children: nodes),
  );
}

// ---------------------------------------------------------------------------
// Code snippet card
// ---------------------------------------------------------------------------
Widget _buildCodeSnippet(String title, String code) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(vertical: 8),
    decoration: BoxDecoration(
      color: Color(0xFF1E293B),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: _kTeal700,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: _kWhite,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(14),
          child: Text(
            code,
            style: TextStyle(
              fontSize: 12,
              fontFamily: 'monospace',
              color: Color(0xFF94A3B8),
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// ListBody child tile
// ---------------------------------------------------------------------------
Widget _buildListBodyChild(int index, String label, Color color) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12),
    margin: EdgeInsets.symmetric(vertical: 3),
    decoration: BoxDecoration(
      color: color.withAlpha(25),
      border: Border.all(color: color.withAlpha(100), width: 1),
      borderRadius: BorderRadius.circular(6),
    ),
    child: Row(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Center(
            child: Text(
              '$index',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: _kWhite,
              ),
            ),
          ),
        ),
        SizedBox(width: 10),
        Text(
          label,
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Property row for parent data fields
// ---------------------------------------------------------------------------
Widget _buildPropertyRow(String name, String value, Color dotColor) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: dotColor,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          flex: 2,
          child: Text(
            name,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              fontFamily: 'monospace',
              color: _kGray700,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(value, style: TextStyle(fontSize: 13, color: _kGray500)),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Numbered explanation step
// ---------------------------------------------------------------------------
Widget _buildExplanationStep(int step, String text, Color accent) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 26,
          height: 26,
          decoration: BoxDecoration(
            color: accent,
            borderRadius: BorderRadius.circular(13),
          ),
          child: Center(
            child: Text(
              '$step',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: _kWhite,
              ),
            ),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 13, color: _kGray700, height: 1.4),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Horizontal vs Vertical comparison card
// ---------------------------------------------------------------------------
Widget _buildAxisDirectionCard(
  String title,
  String direction,
  IconData icon,
  Color accent,
  List<String> childLabels,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: accent.withAlpha(15),
      border: Border.all(color: accent.withAlpha(80), width: 1),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: accent, size: 20),
            SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: accent,
              ),
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: accent.withAlpha(30),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                direction,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: accent,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        ...childLabels.map(
          (label) => Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(vertical: 2),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: _kWhite,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: accent.withAlpha(50)),
            ),
            child: Text(
              label,
              style: TextStyle(fontSize: 12, color: _kGray700),
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Comparison table row
// ---------------------------------------------------------------------------
Widget _buildComparisonRow(String aspect, String listBody, String column) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
    decoration: BoxDecoration(
      border: Border(bottom: BorderSide(color: _kGray100, width: 1)),
    ),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            aspect,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: _kGray700,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            listBody,
            style: TextStyle(fontSize: 12, color: _kTeal700),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(column, style: TextStyle(fontSize: 12, color: _kRose700)),
        ),
      ],
    ),
  );
}

// ===========================================================================
// Entry point
// ===========================================================================
dynamic build(BuildContext context) {
  // --- Data exploration prints ---
  print('=== ListBodyParentData Demo ===');
  print('ListBody arranges children sequentially along an axis.');
  print('ParentData stores nextSibling / previousSibling pointers.');
  print('AxisDirection values: ${AxisDirection.values}');
  print('AxisDirection.down index: ${AxisDirection.down.index}');
  print('AxisDirection.right index: ${AxisDirection.right.index}');
  print('Total AxisDirection values: ${AxisDirection.values.length}');

  final childNames = [
    'Header',
    'Profile Card',
    'Stats Row',
    'Actions',
    'Footer',
  ];
  print('Demo children: $childNames');
  print('Child count: ${childNames.length}');
  print('First child: ${childNames.first}');
  print('Last child: ${childNames.last}');

  return SingleChildScrollView(
    child: Container(
      padding: EdgeInsets.all(16),
      color: _kTeal50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ================================================================
          // Title banner
          // ================================================================
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [_kTeal700, _kRose700],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: _kTeal500.withAlpha(60),
                  blurRadius: 12,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.link, color: _kWhite, size: 28),
                    SizedBox(width: 10),
                    Text(
                      'ListBodyParentData',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: _kWhite,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  'Sibling-linked parent data for sequential child layout',
                  style: TextStyle(fontSize: 14, color: _kWhite.withAlpha(204)),
                ),
                SizedBox(height: 4),
                Text(
                  'rendering library • ListBody • RenderListBody',
                  style: TextStyle(fontSize: 12, color: _kWhite.withAlpha(153)),
                ),
              ],
            ),
          ),

          // ================================================================
          // Section 1: What is ListBodyParentData?
          // ================================================================
          _buildSectionHeader(
            '01',
            'What is ListBodyParentData?',
            'Parent data class used by RenderListBody for linked child management',
          ),

          _buildInfoCard(
            'Definition',
            'ListBodyParentData extends ContainerBoxParentData and adds '
                'nextSibling/previousSibling pointers, creating a doubly-linked '
                'list of children in the render tree. This allows RenderListBody '
                'to traverse children efficiently in both directions.',
            _kTeal500,
          ),

          _buildInfoCard(
            'Inheritance Chain',
            'ListBodyParentData\n'
                '  → ContainerBoxParentData<RenderBox>\n'
                '  → BoxParentData\n'
                '  → ParentData\n\n'
                'Each level adds capabilities: offset storage, sibling links, '
                'and box-specific layout constraints.',
            _kRose500,
          ),

          _buildCodeSnippet(
            'ListBodyParentData class structure',
            'class ListBodyParentData\n'
                '    extends ContainerBoxParentData<RenderBox> {\n'
                '  // Inherited from ContainerBoxParentData:\n'
                '  //   RenderBox? previousSibling;\n'
                '  //   RenderBox? nextSibling;\n'
                '  //\n'
                '  // Inherited from BoxParentData:\n'
                '  //   Offset offset = Offset.zero;\n'
                '}\n',
          ),

          // ================================================================
          // Section 2: Parent Data Fields
          // ================================================================
          _buildSectionHeader(
            '02',
            'Parent Data Fields',
            'Key properties stored on each child in a ListBody',
          ),

          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(vertical: 8),
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: _kWhite,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _kTeal500.withAlpha(60)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Fields in ListBodyParentData',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: _kGray700,
                  ),
                ),
                SizedBox(height: 10),
                _buildPropertyRow(
                  'offset',
                  'Position relative to parent origin (Offset)',
                  _kTeal500,
                ),
                _buildPropertyRow(
                  'previousSibling',
                  'Reference to prior child in paint order',
                  _kRose500,
                ),
                _buildPropertyRow(
                  'nextSibling',
                  'Reference to next child in paint order',
                  _kTeal500,
                ),
                Divider(color: _kGray100),
                _buildPropertyRow(
                  'ContainerParentDataMixin',
                  'Provides the sibling pointers mixin',
                  _kRose500,
                ),
                _buildPropertyRow(
                  'BoxParentData',
                  'Provides the offset field for positioning',
                  _kTeal500,
                ),
              ],
            ),
          ),

          // ================================================================
          // Section 3: Linked List Visualization
          // ================================================================
          _buildSectionHeader(
            '03',
            'Sibling Chain Visualization',
            'How children form a doubly-linked list via parent data',
          ),

          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(vertical: 8),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _kWhite,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _kTeal500.withAlpha(60)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Forward chain (nextSibling →)',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: _kTeal700,
                  ),
                ),
                SizedBox(height: 8),
                _buildSiblingChainDiagram(childNames),
                SizedBox(height: 16),
                Text(
                  'Backward chain (← previousSibling)',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: _kRose700,
                  ),
                ),
                SizedBox(height: 8),
                _buildSiblingChainDiagram(childNames.reversed.toList()),
                SizedBox(height: 14),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: _kTeal50,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'Each child holds pointers to its neighbors. '
                    'RenderListBody walks this chain during layout and painting, '
                    'positioning each child after the previous one along the main axis.',
                    style: TextStyle(
                      fontSize: 12,
                      color: _kGray700,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),

          _buildCodeSnippet(
            'Traversing the sibling chain',
            'RenderBox? child = firstChild;\n'
                'while (child != null) {\n'
                '  final parentData = child.parentData\n'
                '      as ListBodyParentData;\n'
                '  // position child after accumulated offset\n'
                '  parentData.offset = Offset(0, currentY);\n'
                '  currentY += child.size.height;\n'
                '  child = parentData.nextSibling;\n'
                '}\n',
          ),

          // ================================================================
          // Section 4: Vertical ListBody Layout
          // ================================================================
          _buildSectionHeader(
            '04',
            'Vertical ListBody Layout',
            'AxisDirection.down — the default sequential child arrangement',
          ),

          _buildAxisDirectionCard(
            'Vertical (default)',
            'AxisDirection.down',
            Icons.arrow_downward,
            _kTeal500,
            childNames,
          ),

          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(vertical: 6),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kWhite,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Offset assignments (vertical)',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: _kGray700,
                  ),
                ),
                SizedBox(height: 6),
                ...List.generate(childNames.length, (i) {
                  final y = i * 60.0;
                  return _buildPropertyRow(
                    childNames[i],
                    'offset = Offset(0, ${y.toStringAsFixed(0)})',
                    i.isEven ? _kTeal500 : _kRose500,
                  );
                }),
              ],
            ),
          ),

          // ================================================================
          // Section 5: Horizontal ListBody Layout
          // ================================================================
          _buildSectionHeader(
            '05',
            'Horizontal ListBody Layout',
            'AxisDirection.right — arranging children left to right',
          ),

          _buildAxisDirectionCard(
            'Horizontal',
            'AxisDirection.right',
            Icons.arrow_forward,
            _kRose500,
            childNames,
          ),

          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(vertical: 6),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kWhite,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Offset assignments (horizontal)',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: _kGray700,
                  ),
                ),
                SizedBox(height: 6),
                ...List.generate(childNames.length, (i) {
                  final x = i * 120.0;
                  return _buildPropertyRow(
                    childNames[i],
                    'offset = Offset(${x.toStringAsFixed(0)}, 0)',
                    i.isEven ? _kRose500 : _kTeal500,
                  );
                }),
              ],
            ),
          ),

          // ================================================================
          // Section 6: ListBody vs Column Comparison
          // ================================================================
          _buildSectionHeader(
            '06',
            'ListBody vs Column',
            'When to use ListBody over a simple Column widget',
          ),

          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(vertical: 8),
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: _kWhite,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _kGray100),
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  decoration: BoxDecoration(
                    color: _kGray100,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Aspect',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: _kGray700,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          'ListBody',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: _kTeal700,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          'Column',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: _kRose700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                _buildComparisonRow('Layout', 'Sequential only', 'Flex-based'),
                _buildComparisonRow(
                  'Parent Data',
                  'Sibling-linked',
                  'FlexParentData',
                ),
                _buildComparisonRow(
                  'Axis',
                  'Any AxisDirection',
                  'Vertical only',
                ),
                _buildComparisonRow(
                  'Size',
                  'Unbounded main',
                  'Bounded or flex',
                ),
                _buildComparisonRow('Children', 'All laid out', 'Flex ratios'),
                _buildComparisonRow(
                  'Scrolling',
                  'Needs ScrollView',
                  'Can overflow',
                ),
              ],
            ),
          ),

          // ================================================================
          // Section 7: Practical Layout Examples
          // ================================================================
          _buildSectionHeader(
            '07',
            'Practical Layout Examples',
            'Real-world scenarios showing ListBody and its parent data',
          ),

          _buildInfoCard(
            'Chat Message List',
            'A vertical ListBody of message bubbles. Each child\'s parent data '
                'stores offset.dy for its position in the conversation. The sibling '
                'chain lets the renderer quickly find adjacent messages for grouping '
                'same-sender bubbles.',
            _kTeal500,
          ),

          ...List.generate(4, (i) {
            final isMe = i.isEven;
            return _buildListBodyChild(
              i,
              isMe
                  ? 'Sent: Hello! (offset.dy=${i * 56})'
                  : 'Received: Hi there! (offset.dy=${i * 56})',
              isMe ? _kTeal500 : _kRose500,
            );
          }),

          SizedBox(height: 12),

          _buildInfoCard(
            'Settings Panel',
            'A vertical list of settings groups. Each group is a child whose '
                'parent data maintains the sequential offset. previousSibling lets '
                'the renderer check if a divider is needed between groups.',
            _kRose500,
          ),

          ...[
            'Account Settings',
            'Privacy & Security',
            'Notifications',
            'Appearance',
            'About',
          ].asMap().entries.map(
            (e) => _buildListBodyChild(
              e.key,
              '${e.value} (nextSibling: ${e.key < 4 ? "yes" : "null"})',
              e.key.isEven ? _kTeal500 : _kRose500,
            ),
          ),

          // ================================================================
          // Section 8: Layout Algorithm Steps
          // ================================================================
          _buildSectionHeader(
            '08',
            'Layout Algorithm',
            'How RenderListBody uses parent data during layout',
          ),

          _buildExplanationStep(
            1,
            'RenderListBody receives constraints from its parent (typically a viewport).',
            _kTeal500,
          ),
          _buildExplanationStep(
            2,
            'It lays out each child with tight cross-axis constraints and loose main-axis.',
            _kRose500,
          ),
          _buildExplanationStep(
            3,
            'After layout, it walks the sibling chain via nextSibling, accumulating '
            'the main-axis offset in each child\'s parentData.offset.',
            _kTeal500,
          ),
          _buildExplanationStep(
            4,
            'The total size is the sum of all children along the main axis, '
            'and the maximum cross-axis extent.',
            _kRose500,
          ),
          _buildExplanationStep(
            5,
            'During painting, it walks the chain again, painting each child '
            'at its stored offset. Reverse axis directions walk previousSibling.',
            _kTeal500,
          ),
          _buildExplanationStep(
            6,
            'Hit testing also uses the sibling chain to find which child contains '
            'a given point, using offset comparisons.',
            _kRose500,
          ),

          _buildCodeSnippet(
            'RenderListBody.performLayout (simplified)',
            '// Simplified layout algorithm\n'
                'void performLayout() {\n'
                '  RenderBox? child = firstChild;\n'
                '  double mainAxisOffset = 0.0;\n'
                '  double crossAxisExtent = 0.0;\n'
                '\n'
                '  while (child != null) {\n'
                '    child.layout(childConstraints,\n'
                '        parentUsesSize: true);\n'
                '    final pd = child.parentData\n'
                '        as ListBodyParentData;\n'
                '    pd.offset = offsetFor(mainAxisOffset);\n'
                '    mainAxisOffset += child.size.height;\n'
                '    crossAxisExtent = max(\n'
                '        crossAxisExtent, child.size.width);\n'
                '    child = pd.nextSibling;\n'
                '  }\n'
                '}\n',
          ),

          // Footer
          SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: _kRose50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _kRose500.withAlpha(40)),
            ),
            child: Text(
              'ListBodyParentData is a specialized parent data class that enables '
              'efficient sequential layout through sibling pointers. While rarely '
              'used directly, understanding it illuminates how Flutter\'s render tree '
              'manages child relationships for custom layout protocols.',
              style: TextStyle(
                fontSize: 12,
                color: _kGray700,
                height: 1.5,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),

          SizedBox(height: 24),
        ],
      ),
    ),
  );
}
