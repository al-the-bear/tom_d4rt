// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

// ============================================================================
// SLIVER LOGICAL CONTAINER PARENT DATA — Deep Demo
// ============================================================================
//
// SliverLogicalContainerParentData is a parent data class that combines
// two key traits:
//
//   1. Physical child management — from ContainerParentDataMixin
//      (next/previous sibling pointers for a linked-list of render children)
//
//   2. Sliver physical layout data — from SliverPhysicalParentData
//      (paintOffset: where to paint the child relative to the sliver)
//
// It extends SliverPhysicalContainerParentData (which itself merges
// SliverPhysicalParentData + ContainerParentDataMixin<RenderBox>) and
// serves as the parent data type for slivers that maintain a logical
// ordering of children beyond just their paint/physical order.
//
// The primary user is RenderSliverMultiBoxAdaptor, which keeps children
// in both a linked-list (for painting/hit-testing in paint order) and a
// Map<int, RenderBox> (for logical index-based access).
//
// This demo explains the parent data hierarchy, shows how physical and
// logical child tracking differs, visualises the linked list structure,
// and illustrates keep-alive child management.
//
// Color theme : Navy Blue (#1A237E) / Ice Blue (#E3F2FD)
// Helper prefix: _lc
// ============================================================================

// ---------------------------------------------------------------------------
// Color palette
// ---------------------------------------------------------------------------
const Color _lcNavy = Color(0xFF1A237E);
const Color _lcIce = Color(0xFFE3F2FD);
const Color _lcDeepNavy = Color(0xFF0D1642);
const Color _lcPaleBlue = Color(0xFFF5F9FF);
const Color _lcCharcoal = Color(0xFF263238);
const Color _lcTeal = Color(0xFF00695C);
const Color _lcCrimson = Color(0xFFC62828);
const Color _lcAmber = Color(0xFFFFA000);
const Color _lcGreen = Color(0xFF2E7D32);
const Color _lcPurple = Color(0xFF6A1B9A);
const Color _lcOrange = Color(0xFFE65100);
const Color _lcIndigo = Color(0xFF283593);
const Color _lcBrown = Color(0xFF4E342E);
const Color _lcSlate = Color(0xFF546E7A);

// ---------------------------------------------------------------------------
// Reusable helpers
// ---------------------------------------------------------------------------

Widget _lcSectionHeader(String title, {String? subtitle}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    decoration: const BoxDecoration(
      gradient: LinearGradient(colors: [_lcNavy, _lcDeepNavy]),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
        if (subtitle != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(subtitle,
                style:
                    const TextStyle(color: Color(0xCCFFFFFF), fontSize: 13)),
          ),
      ],
    ),
  );
}

Widget _lcExplain(String text) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(14),
    color: _lcPaleBlue,
    child: Text(text,
        style: const TextStyle(
            fontSize: 13, height: 1.55, color: _lcCharcoal)),
  );
}

Widget _lcPill(String label, Color bg, {Color textColor = Colors.white}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
        color: bg, borderRadius: BorderRadius.circular(12)),
    child: Text(label,
        style: TextStyle(
            color: textColor, fontSize: 11, fontWeight: FontWeight.w600)),
  );
}

Widget _lcCard(String title, Widget child,
    {Color borderColor = _lcNavy}) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: borderColor, width: 1.4),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: borderColor.withValues(alpha: 0.08),
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(9)),
          ),
          child: Text(title,
              style: TextStyle(
                  color: borderColor,
                  fontSize: 14,
                  fontWeight: FontWeight.bold)),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(14, 8, 14, 14),
          child: child,
        ),
      ],
    ),
  );
}

Widget _lcCode(String code) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: const Color(0xFF1E1E1E),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(code,
        style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 12,
            color: Color(0xFFD4D4D4),
            height: 1.5)),
  );
}

Widget _lcKv(String key, String value, {Color? valueColor}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      children: [
        SizedBox(
          width: 170,
          child: Text(key,
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: _lcCharcoal)),
        ),
        Expanded(
          child: Text(value,
              style: TextStyle(fontSize: 12, color: valueColor ?? _lcSlate)),
        ),
      ],
    ),
  );
}

Widget _lcDivider() {
  return Container(
    height: 1,
    color: _lcIce,
    margin: const EdgeInsets.symmetric(vertical: 6),
  );
}

Widget _lcInline(String text) {
  return Text(text,
      style: const TextStyle(fontSize: 12, height: 1.5, color: _lcCharcoal));
}

// ============================================================================
// Build
// ============================================================================

dynamic build(BuildContext context) {
  print('=== SliverLogicalContainerParentData Deep Demo START ===');

  final Widget demo = Container(
    color: _lcIce,
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitleBanner(),

          _lcSectionHeader('1  What Is SliverLogicalContainerParentData?',
              subtitle: 'Parent data for slivers with logical child ordering'),
          _buildWhatIs(),

          _lcSectionHeader('2  Class Hierarchy',
              subtitle:
                  'ParentData → SliverPhysical → Container → Logical'),
          _buildHierarchy(),

          _lcSectionHeader('3  Physical vs Logical Children',
              subtitle: 'Two ways to track the same children'),
          _buildPhysicalVsLogical(),

          _lcSectionHeader('4  The paintOffset Field',
              subtitle:
                  'Inherited from SliverPhysicalParentData'),
          _buildPaintOffset(),

          _lcSectionHeader('5  ContainerParentDataMixin',
              subtitle: 'The linked-list backbone'),
          _buildContainerMixin(),

          _lcSectionHeader('6  RenderSliverMultiBoxAdaptor Usage',
              subtitle: 'The primary consumer of this parent data'),
          _buildMultiBoxAdaptor(),

          _lcSectionHeader('7  KeepAlive Children',
              subtitle: 'Logical but not always physical'),
          _buildKeepAlive(),

          _lcSectionHeader('8  Parent Data Lifecycle',
              subtitle: 'Setup → layout → paint → detach'),
          _buildLifecycle(),

          _lcSectionHeader('9  Child Management Diagram',
              subtitle: 'How the linked list and index map cooperate'),
          _buildManagementDiagram(),

          _lcSectionHeader(
              '10  vs SliverMultiBoxAdaptorParentData',
              subtitle: 'What the subclass adds'),
          _buildComparison(),

          _buildSummary(),

          const SizedBox(height: 30),
        ],
      ),
    ),
  );

  print('=== SliverLogicalContainerParentData Deep Demo END ===');
  return demo;
}

// ============================================================================
// Sections
// ============================================================================

Widget _buildTitleBanner() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.fromLTRB(24, 30, 24, 24),
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [_lcNavy, _lcDeepNavy],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.account_tree,
                  color: Colors.white, size: 28),
            ),
            const SizedBox(width: 14),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('SliverLogicalContainer',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  Text('ParentData',
                      style: TextStyle(
                          color: Color(0xAAFFFFFF),
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            'rendering library  •  extends SliverPhysicalContainerParentData',
            style: TextStyle(color: Color(0xDDFFFFFF), fontSize: 12),
          ),
        ),
        const SizedBox(height: 14),
        const Text(
          'A parent data class that merges sliver physical layout data '
          '(paintOffset) with container child management (linked list '
          'pointers), forming the base for slivers that track children '
          'both by paint order and by logical index.',
          style: TextStyle(
              color: Color(0xCCFFFFFF), fontSize: 13, height: 1.5),
        ),
      ],
    ),
  );
}

// -------------- 1. What Is -----------------------------------------------

Widget _buildWhatIs() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _lcExplain(
        'Every RenderObject can attach a ParentData object to each of its '
        'children.  For slivers containing box children, the parent data '
        'must fulfil two roles:\n\n'
        '1. Store the paintOffset — where to paint the child relative to '
        '   the sliver origin.  This comes from SliverPhysicalParentData.\n'
        '2. Maintain linked-list pointers (previousSibling / nextSibling) '
        '   so the container can iterate children in order.  This comes '
        '   from ContainerParentDataMixin.\n\n'
        'SliverPhysicalContainerParentData merges both.  '
        'SliverLogicalContainerParentData extends it with no new fields — '
        'its purpose is to stand as a distinct type in the class hierarchy '
        'so that slivers needing "logical container" semantics can declare '
        'this as their parentData type.',
      ),
      _lcCard('At a Glance', Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _lcKv('Adds new fields', 'None'),
          _lcKv('Purpose', 'Type marker for logical child containers'),
          _lcKv('Extends', 'SliverPhysicalContainerParentData'),
          _lcKv('Inherits', 'paintOffset, previousSibling, nextSibling'),
          _lcDivider(),
          _lcKv('Used by', 'RenderSliverMultiBoxAdaptor'),
          _lcKv('Subclassed by', 'SliverMultiBoxAdaptorParentData'),
        ],
      )),
      _lcCode(
        '// The actual class is effectively empty:\n'
        'class SliverLogicalContainerParentData\n'
        '    extends SliverPhysicalContainerParentData {\n'
        '  // No additional fields or methods.\n'
        '  // Exists as a type marker in the hierarchy.\n'
        '}',
      ),
    ],
  );
}

// -------------- 2. Hierarchy ---------------------------------------------

Widget _buildHierarchy() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _lcExplain(
        'The parent data class hierarchy for slivers with box children '
        'progresses through four levels.  Each level adds a specific '
        'capability.  SliverLogicalContainerParentData sits at the fourth '
        'level, below the physical container but above the multi-box '
        'adaptor-specific parent data.',
      ),
      _lcCard('Full Hierarchy', Column(
        children: [
          _lcHierarchyBox('ParentData', 'Base class — empty', _lcSlate, 0),
          _lcHierarchyArrow(),
          _lcHierarchyBox('SliverPhysicalParentData',
              'Adds: Offset paintOffset', _lcTeal, 1),
          _lcHierarchyArrow(),
          _lcHierarchyBox(
              'SliverPhysicalContainerParentData',
              'Mixes in: ContainerParentDataMixin<RenderBox>',
              _lcIndigo,
              2),
          _lcHierarchyArrow(),
          _lcHierarchyBox(
              'SliverLogicalContainerParentData',
              'No new fields — type marker',
              _lcNavy,
              3),
          _lcHierarchyArrow(),
          _lcHierarchyBox(
              'SliverMultiBoxAdaptorParentData',
              'Adds: int index, bool keepAlive',
              _lcCrimson,
              4),
        ],
      )),
      _lcCard('ContainerParentDataMixin (mixed in at level 2)', Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _lcKv('previousSibling', 'RenderBox? — linked-list prev pointer'),
          _lcKv('nextSibling', 'RenderBox? — linked-list next pointer'),
          _lcDivider(),
          _lcInline(
            'This mixin provides the double-linked-list infrastructure '
            'that ContainerRenderObjectMixin uses to iterate children '
            'in paint order (first → last) and hit-test order (last → first).',
          ),
        ],
      )),
    ],
  );
}

Widget _lcHierarchyBox(
    String name, String detail, Color color, int depth) {
  return Padding(
    padding: EdgeInsets.only(left: depth * 12.0),
    child: Container(
      width: 300,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        border: Border.all(color: color, width: 1.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name,
              style: TextStyle(
                  color: color,
                  fontSize: 13,
                  fontWeight: FontWeight.bold)),
          Text(detail,
              style: TextStyle(
                  color: color.withValues(alpha: 0.7), fontSize: 11)),
        ],
      ),
    ),
  );
}

Widget _lcHierarchyArrow() {
  return Column(
    children: [
      Container(width: 2, height: 10, color: _lcNavy.withValues(alpha: 0.3)),
      Icon(Icons.arrow_drop_down,
          size: 16, color: _lcNavy.withValues(alpha: 0.5)),
    ],
  );
}

// -------------- 3. Physical vs Logical -----------------------------------

Widget _buildPhysicalVsLogical() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _lcExplain(
        '"Physical" children are those currently attached to the render '
        'tree and maintained in the linked list.  They have a real '
        'paintOffset and are visited during paint and hit-test.\n\n'
        '"Logical" children include physical children PLUS children that '
        'are kept alive off-screen (e.g. due to AutomaticKeepAlive).  '
        'These keep-alive children still have parent data but are not in '
        'the active linked list — they are stored in a separate map.\n\n'
        'SliverLogicalContainerParentData marks the parent data as '
        'belonging to a sliver that may maintain this distinction.',
      ),
      _lcCard('Physical Children', Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _lcChildRow('Child A', 'index 0', 'visible', _lcGreen, true),
          _lcChildRow('Child B', 'index 1', 'visible', _lcGreen, true),
          _lcChildRow('Child C', 'index 2', 'visible', _lcGreen, true),
          _lcDivider(),
          _lcKv('In linked list', 'Yes'),
          _lcKv('paintOffset', 'Set during layout'),
          _lcKv('Painted', 'Yes — visited in paint()'),
          _lcKv('Hit-tested', 'Yes — visited in hitTest()'),
        ],
      )),
      _lcCard('Logical-Only Children (Keep-Alive)', Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _lcChildRow('Child X', 'index 5', 'keep-alive', _lcAmber, false),
          _lcChildRow('Child Y', 'index 8', 'keep-alive', _lcAmber, false),
          _lcDivider(),
          _lcKv('In linked list', 'No — stored in _keepAliveBucket'),
          _lcKv('paintOffset', 'Not meaningful (off-screen)'),
          _lcKv('Painted', 'No'),
          _lcKv('Hit-tested', 'No'),
          _lcKv('State preserved', 'Yes — that is the purpose'),
        ],
      )),
      // Visual: two-column diagram
      _lcCard('Side-by-Side Diagram', Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: _lcChildGroup('Physical (Linked List)', [
              _lcMiniChild('A[0]', _lcGreen),
              _lcMiniChild('B[1]', _lcGreen),
              _lcMiniChild('C[2]', _lcGreen),
              _lcMiniChild('D[3]', _lcGreen),
            ]),
          ),
          Container(width: 1, height: 120, color: _lcNavy.withValues(alpha: 0.2)),
          Expanded(
            child: _lcChildGroup('Logical Only (Bucket)', [
              _lcMiniChild('X[5]', _lcAmber),
              _lcMiniChild('Y[8]', _lcAmber),
            ]),
          ),
        ],
      )),
    ],
  );
}

Widget _lcChildRow(
    String name, String index, String status, Color color, bool physical) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: physical ? color : Colors.transparent,
            border: Border.all(color: color, width: 1.5),
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            '$name ($index) — $status',
            style: const TextStyle(
                fontSize: 11,
                fontFamily: 'monospace',
                color: _lcCharcoal),
          ),
        ),
      ],
    ),
  );
}

Widget _lcChildGroup(String title, List<Widget> children) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: _lcSlate)),
        const SizedBox(height: 6),
        ...children,
      ],
    ),
  );
}

Widget _lcMiniChild(String label, Color color) {
  return Container(
    width: double.infinity,
    height: 24,
    margin: const EdgeInsets.only(bottom: 4),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(4),
      border: Border.all(color: color.withValues(alpha: 0.3)),
    ),
    alignment: Alignment.center,
    child: Text(label,
        style: TextStyle(
            fontSize: 10, fontWeight: FontWeight.bold, color: color)),
  );
}

// -------------- 4. paintOffset -------------------------------------------

Widget _buildPaintOffset() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _lcExplain(
        'paintOffset is inherited from SliverPhysicalParentData and tells '
        'the painting system where to position each child relative to the '
        'sliver origin.  During performLayout, the sliver sets this offset '
        'for each visible child.\n\n'
        'For a vertical SliverList, paintOffset.dy is the distance from '
        'the top of the sliver to the top of the child.  paintOffset.dx '
        'is usually 0 (unless the child is indented).',
      ),
      _lcCard('paintOffset Layout Example', Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _lcPaintOffsetRow('Child A', 0, 60, _lcGreen),
          _lcPaintOffsetRow('Child B', 60, 80, _lcIndigo),
          _lcPaintOffsetRow('Child C', 140, 50, _lcTeal),
          _lcPaintOffsetRow('Child D', 190, 70, _lcCrimson),
          _lcDivider(),
          _lcInline(
            'Each child is painted at sliver_origin + paintOffset.  The '
            'viewport clips to the visible region.',
          ),
        ],
      )),
      // Visual: vertical strip with children positioned
      _lcCard('Visual: Sliver with paintOffsets', Container(
        height: 200,
        decoration: BoxDecoration(
          border: Border.all(color: _lcNavy, width: 2),
          borderRadius: BorderRadius.circular(6),
        ),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          children: [
            _lcPaintChild(0, 60, 'A  offset=(0,0)', _lcGreen),
            _lcPaintChild(60, 80, 'B  offset=(0,60)', _lcIndigo),
            _lcPaintChild(140, 50, 'C  offset=(0,140)', _lcTeal),
          ],
        ),
      )),
      _lcCode(
        '// During SliverList.performLayout:\n'
        'childParentData.paintOffset = Offset(0, layoutOffset);\n'
        '// Where layoutOffset is the running total of child heights.\n'
        '\n'
        '// During SliverList.paint:\n'
        '// For each child:\n'
        'context.paintChild(child, offset + childParentData.paintOffset);',
      ),
    ],
  );
}

Widget _lcPaintOffsetRow(String name, double offset, double height, Color color) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      children: [
        Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          alignment: Alignment.center,
          child: Text(name.split(' ').last,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold)),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            '$name: paintOffset=(0, $offset), height=$height',
            style: const TextStyle(
                fontSize: 11, fontFamily: 'monospace', color: _lcCharcoal),
          ),
        ),
      ],
    ),
  );
}

Widget _lcPaintChild(
    double top, double height, String label, Color color) {
  return Positioned(
    top: top,
    left: 0,
    right: 0,
    child: Container(
      height: height,
      color: color.withValues(alpha: 0.2),
      alignment: Alignment.center,
      child: Text(label,
          style: TextStyle(
              fontSize: 10, fontWeight: FontWeight.bold, color: color)),
    ),
  );
}

// -------------- 5. ContainerParentDataMixin -------------------------------

Widget _buildContainerMixin() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _lcExplain(
        'ContainerParentDataMixin<RenderBox> adds two fields:\n\n'
        '  • previousSibling — pointer to the child before this one\n'
        '  • nextSibling     — pointer to the child after this one\n\n'
        'Together they form a doubly-linked list maintained by '
        'ContainerRenderObjectMixin.  The sliver iterates this list '
        'for painting (first → last) and for hit testing (last → first).\n\n'
        'The mixin is mixed into SliverPhysicalContainerParentData, '
        'so SliverLogicalContainerParentData inherits it.',
      ),
      _lcCard('Linked List Structure', Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _lcLinkedListVisual(),
          _lcDivider(),
          _lcKv('firstChild', 'Render object stores this'),
          _lcKv('lastChild', 'Render object stores this'),
          _lcKv('childCount', 'Render object stores this'),
          _lcDivider(),
          _lcInline(
            'The linked list connects only physical (active) children.  '
            'Keep-alive children are detached from the list but remain in '
            'the logical index map.',
          ),
        ],
      )),
      _lcCode(
        '// Iterating children via the linked list:\n'
        'RenderBox? child = firstChild;\n'
        'while (child != null) {\n'
        '  // Process child...\n'
        '  final parentData = child.parentData\n'
        '      as SliverLogicalContainerParentData;\n'
        '  // Access paintOffset:\n'
        '  print(parentData.paintOffset);\n'
        '  // Move to next:\n'
        '  child = parentData.nextSibling;\n'
        '}',
      ),
      _lcCard('Operations on the Linked List', Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _lcOperationRow('insert(child)', 'Adds child, sets prev/next pointers',
              _lcGreen),
          _lcOperationRow('remove(child)', 'Unlinks child from list, clears pointers',
              _lcCrimson),
          _lcOperationRow('move(child, after:)',
              'Removes then re-inserts at new position', _lcIndigo),
          _lcDivider(),
          _lcInline(
            'These operations are on the render object '
            '(ContainerRenderObjectMixin), not the parent data.  But they '
            'modify the parent data linked-list pointers.',
          ),
        ],
      )),
    ],
  );
}

Widget _lcLinkedListVisual() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      _lcLinkedNode('A', _lcGreen),
      _lcLinkedArrow(),
      _lcLinkedNode('B', _lcIndigo),
      _lcLinkedArrow(),
      _lcLinkedNode('C', _lcTeal),
      _lcLinkedArrow(),
      _lcLinkedNode('D', _lcCrimson),
    ],
  );
}

Widget _lcLinkedNode(String label, Color color) {
  return Container(
    width: 36,
    height: 36,
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.12),
      border: Border.all(color: color, width: 1.5),
      borderRadius: BorderRadius.circular(8),
    ),
    alignment: Alignment.center,
    child: Text(label,
        style: TextStyle(
            color: color, fontSize: 13, fontWeight: FontWeight.bold)),
  );
}

Widget _lcLinkedArrow() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 2),
    child: Column(
      children: [
        const Icon(Icons.arrow_forward, size: 12, color: _lcSlate),
        const Icon(Icons.arrow_back, size: 12, color: _lcSlate),
      ],
    ),
  );
}

Widget _lcOperationRow(String name, String desc, Color color) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 8,
          height: 8,
          margin: const EdgeInsets.only(top: 4),
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: RichText(
            text: TextSpan(children: [
              TextSpan(
                text: '$name  ',
                style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: color),
              ),
              TextSpan(
                text: desc,
                style: const TextStyle(fontSize: 11, color: _lcSlate),
              ),
            ]),
          ),
        ),
      ],
    ),
  );
}

// -------------- 6. MultiBoxAdaptor usage ---------------------------------

Widget _buildMultiBoxAdaptor() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _lcExplain(
        'RenderSliverMultiBoxAdaptor is the abstract base class behind '
        'SliverList and SliverGrid.  It uses SliverMultiBoxAdaptorParentData '
        '(which extends SliverLogicalContainerParentData) as the parent '
        'data for each child.\n\n'
        'The adaptor maintains two parallel structures:\n'
        '  1. Linked list (via ContainerParentDataMixin) — for paint and '
        '     hit-test iteration\n'
        '  2. Map<int, RenderBox> _keepAliveBucket — for children that '
        '     are off-screen but kept alive\n\n'
        'During layout, children enter and leave the linked list as they '
        'scroll in and out of view.  Keep-alive children are moved to the '
        'bucket when they leave the viewport.',
      ),
      _lcCard('Dual-Structure Management', Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _lcDualRow('Visible child created',
              'insert into linked list, set parentData.index', _lcGreen),
          _lcDualRow('Child scrolls out (no keep-alive)',
              'remove from linked list, dispose child', _lcCrimson),
          _lcDualRow('Child scrolls out (keep-alive)',
              'remove from linked list → store in _keepAliveBucket', _lcAmber),
          _lcDualRow('Keep-alive scrolls back in',
              'move from bucket → re-insert into linked list', _lcIndigo),
          _lcDualRow('Key change / new data',
              'create new child, old disposed or kept', _lcPurple),
        ],
      )),
      _lcCode(
        '// Simplified from RenderSliverMultiBoxAdaptor:\n\n'
        '// Insert a new child at the given index:\n'
        'void insertAndLayoutChild(\n'
        '  SliverConstraints constraints, {\n'
        '  required RenderBox? after,\n'
        '}) {\n'
        '  // 1. Check if in _keepAliveBucket\n'
        '  if (_keepAliveBucket.containsKey(index)) {\n'
        '    // Move back to linked list\n'
        '    final child = _keepAliveBucket.remove(index)!;\n'
        '    insert(child, after: after);\n'
        '  } else {\n'
        '    // 2. Create new child from delegate\n'
        '    _createOrObtainChild(index, after: after);\n'
        '  }\n'
        '}\n\n'
        '// Move child to keep-alive when it leaves viewport:\n'
        'void _%.moveToKeepAliveBucket(RenderBox child) {\n'
        '  remove(child);  // unlink from list\n'
        '  _keepAliveBucket[child.parentData.index] = child;\n'
        '}',
      ),
    ],
  );
}

Widget _lcDualRow(String action, String detail, Color color) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 8,
          height: 8,
          margin: const EdgeInsets.only(top: 4),
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(action,
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: color)),
              Text(detail,
                  style: const TextStyle(fontSize: 10, color: _lcSlate)),
            ],
          ),
        ),
      ],
    ),
  );
}

// -------------- 7. KeepAlive ---------------------------------------------

Widget _buildKeepAlive() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _lcExplain(
        'The AutomaticKeepAlive and KeepAliveNotification mechanism '
        'allows widgets to request that their RenderBox be kept alive '
        'even after scrolling off-screen.  The '
        'SliverMultiBoxAdaptorParentData stores a keepAlive flag.\n\n'
        'When a child goes off-screen:\n'
        '  • If keepAlive == true: the child is moved to _keepAliveBucket, '
        '    preserving its state.  Its parent data (a '
        '    SliverLogicalContainerParentData subclass) remains attached.\n'
        '  • If keepAlive == false: the child is detached and may be '
        '    disposed, releasing its state.',
      ),
      _lcCard('KeepAlive Lifecycle', Column(
        children: [
          _lcKeepAliveStep(1, 'Child widget calls keepAlive(true)',
              'Widget mixin sends KeepAliveNotification', _lcGreen),
          _lcKeepAliveStep(2, 'Notification reaches SliverMultiBoxAdaptor',
              'Sets parentData.keepAlive = true', _lcIndigo),
          _lcKeepAliveStep(3, 'Child scrolls off-screen',
              'Child moved to _keepAliveBucket', _lcAmber),
          _lcKeepAliveStep(4, 'State preserved in bucket',
              'RenderBox and parent data still intact', _lcPurple),
          _lcKeepAliveStep(5, 'Child scrolls back on-screen',
              'Moved from bucket back to linked list', _lcTeal),
        ],
      )),
      // Visual: viewport with keep-alive items
      _lcCard('Visual: Viewport with Keep-Alive', Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              children: [
                const Text('Viewport',
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: _lcSlate)),
                const SizedBox(height: 4),
                Container(
                  height: 120,
                  decoration: BoxDecoration(
                    border: Border.all(color: _lcNavy, width: 2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Column(
                    children: [
                      _lcViewportItem('Item 3', _lcGreen, true),
                      _lcViewportItem('Item 4', _lcGreen, true),
                      _lcViewportItem('Item 5', _lcGreen, true),
                      _lcViewportItem('Item 6', _lcGreen, true),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Text('Visible = Physical children',
                      style: TextStyle(fontSize: 9, color: _lcSlate)),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              children: [
                const Text('KeepAlive Bucket',
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: _lcSlate)),
                const SizedBox(height: 4),
                Container(
                  height: 120,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _lcAmber.withValues(alpha: 0.06),
                    border: Border.all(
                        color: _lcAmber.withValues(alpha: 0.4), width: 1.5),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _lcBucketItem('Item 0', _lcAmber),
                      _lcBucketItem('Item 1', _lcAmber),
                      _lcBucketItem('Item 2', _lcOrange),
                      const SizedBox(height: 8),
                      const Text('State preserved',
                          style: TextStyle(
                              fontSize: 9,
                              fontStyle: FontStyle.italic,
                              color: _lcSlate)),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Text('Off-screen = Logical only',
                      style: TextStyle(fontSize: 9, color: _lcSlate)),
                ),
              ],
            ),
          ),
        ],
      )),
    ],
  );
}

Widget _lcKeepAliveStep(
    int step, String title, String detail, Color color) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          alignment: Alignment.center,
          child: Text('$step',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.bold)),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: color)),
              Text(detail,
                  style: const TextStyle(fontSize: 10, color: _lcSlate)),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _lcViewportItem(String label, Color color, bool visible) {
  return Expanded(
    child: Container(
      width: double.infinity,
      color: color.withValues(alpha: visible ? 0.15 : 0.05),
      alignment: Alignment.center,
      child: Text(label,
          style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w600,
              color: visible ? color : _lcSlate)),
    ),
  );
}

Widget _lcBucketItem(String label, Color color) {
  return Container(
    width: double.infinity,
    height: 22,
    margin: const EdgeInsets.only(bottom: 3),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(3),
      border: Border.all(color: color.withValues(alpha: 0.3)),
    ),
    alignment: Alignment.center,
    child: Text(label,
        style: TextStyle(
            fontSize: 9, fontWeight: FontWeight.w600, color: color)),
  );
}

// -------------- 8. Lifecycle ---------------------------------------------

Widget _buildLifecycle() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _lcExplain(
        'The parent data goes through a well-defined lifecycle:\n\n'
        '1. Setup: when a child is adopted, setupParentData creates a '
        '   SliverMultiBoxAdaptorParentData (or the logical container '
        '   parent data for simpler slivers).\n'
        '2. Layout: performLayout sets paintOffset and other fields.\n'
        '3. Paint: paint() reads paintOffset to position each child.\n'
        '4. Hit-test: hitTestChildren iterates the linked list.\n'
        '5. Detach: when a child is removed, parent data is cleared.\n\n'
        'The parent data object is reused if the same child is '
        're-adopted (e.g. after a keep-alive return).',
      ),
      _lcCard('Lifecycle Stages', Column(
        children: [
          _lcLifecycleStage('Setup', 'setupParentData() creates instance',
              Icons.build, _lcGreen),
          _lcLifecycleStage('Layout', 'performLayout() sets paintOffset',
              Icons.straighten, _lcIndigo),
          _lcLifecycleStage('Paint', 'paint() reads paintOffset',
              Icons.brush, _lcTeal),
          _lcLifecycleStage('Hit Test', 'hitTestChildren() iterates list',
              Icons.touch_app, _lcAmber),
          _lcLifecycleStage('Detach', 'detach() clears pointers',
              Icons.link_off, _lcCrimson),
        ],
      )),
      _lcCode(
        '// In RenderSliverMultiBoxAdaptor:\n'
        '@override\n'
        'void setupParentData(RenderObject child) {\n'
        '  if (child.parentData is! SliverMultiBoxAdaptorParentData) {\n'
        '    child.parentData = SliverMultiBoxAdaptorParentData();\n'
        '  }\n'
        '}\n'
        '// SliverMultiBoxAdaptorParentData extends\n'
        '// SliverLogicalContainerParentData, so the type check\n'
        '// ensures the full hierarchy is in place.',
      ),
    ],
  );
}

Widget _lcLifecycleStage(
    String title, String detail, IconData icon, Color color) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: color.withValues(alpha: 0.3)),
          ),
          alignment: Alignment.center,
          child: Icon(icon, size: 18, color: color),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: color)),
              Text(detail,
                  style: const TextStyle(fontSize: 10, color: _lcSlate)),
            ],
          ),
        ),
      ],
    ),
  );
}

// -------------- 9. Management Diagram ------------------------------------

Widget _buildManagementDiagram() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _lcExplain(
        'The following diagram shows how a SliverList with 10 items manages '
        'children as the user scrolls.  Items 4-7 are visible (in the linked '
        'list).  Items 2-3 are keep-alive (in the bucket).  Items 0-1 and '
        '8-9 are not materialised at all.',
      ),
      _lcCard('Full Management View', Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _lcPill('Not created', _lcSlate),
              const SizedBox(width: 6),
              _lcPill('Keep-alive', _lcAmber),
              const SizedBox(width: 6),
              _lcPill('Visible', _lcGreen),
            ],
          ),
          const SizedBox(height: 10),
          _lcManagementRow(0, 'Not created', _lcSlate),
          _lcManagementRow(1, 'Not created', _lcSlate),
          _lcManagementRow(2, 'Keep-alive (bucket)', _lcAmber),
          _lcManagementRow(3, 'Keep-alive (bucket)', _lcAmber),
          _lcManagementRow(4, 'Visible (linked list)', _lcGreen),
          _lcManagementRow(5, 'Visible (linked list)', _lcGreen),
          _lcManagementRow(6, 'Visible (linked list)', _lcGreen),
          _lcManagementRow(7, 'Visible (linked list)', _lcGreen),
          _lcManagementRow(8, 'Not created', _lcSlate),
          _lcManagementRow(9, 'Not created', _lcSlate),
          _lcDivider(),
          _lcKv('childCount (physical)', '4 (items 4-7)'),
          _lcKv('_keepAliveBucket.length', '2 (items 2-3)'),
          _lcKv('Total logical', '6 (items 2-7)'),
          _lcKv('Delegate itemCount', '10'),
        ],
      )),
      _lcCard('After Scrolling Down', Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _lcInline(
            'User scrolls down. Items 4-5 leave viewport, items 8-9 enter.',
          ),
          const SizedBox(height: 6),
          _lcManagementRow(0, 'Not created', _lcSlate),
          _lcManagementRow(1, 'Not created', _lcSlate),
          _lcManagementRow(2, 'Disposed (was keep-alive)', _lcBrown),
          _lcManagementRow(3, 'Disposed (was keep-alive)', _lcBrown),
          _lcManagementRow(4, 'Keep-alive (was visible)', _lcAmber),
          _lcManagementRow(5, 'Keep-alive (was visible)', _lcAmber),
          _lcManagementRow(6, 'Visible', _lcGreen),
          _lcManagementRow(7, 'Visible', _lcGreen),
          _lcManagementRow(8, 'Visible (new)', _lcGreen),
          _lcManagementRow(9, 'Visible (new)', _lcGreen),
        ],
      )),
    ],
  );
}

Widget _lcManagementRow(int index, String status, Color color) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      children: [
        Container(
          width: 28,
          height: 18,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(3),
          ),
          alignment: Alignment.center,
          child: Text('$index',
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: color)),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(status,
              style: TextStyle(fontSize: 11, color: color)),
        ),
      ],
    ),
  );
}

// -------------- 10. Comparison -------------------------------------------

Widget _buildComparison() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _lcExplain(
        'SliverMultiBoxAdaptorParentData extends '
        'SliverLogicalContainerParentData and adds:\n\n'
        '  • int? index  — the child index in the delegate\n'
        '  • bool _keepAlive — whether to keep the child alive off-screen\n\n'
        'SliverLogicalContainerParentData itself has no fields beyond what '
        'it inherits.  The distinction exists so that other slivers that '
        'need logical container semantics but NOT the index/keepAlive '
        'fields can use SliverLogicalContainerParentData directly.',
      ),
      _lcCard('Field Comparison', Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _lcCompareRow(
            'SliverLogicalContainerParentData',
            ['paintOffset: Offset', 'previousSibling: RenderBox?',
             'nextSibling: RenderBox?'],
            _lcNavy,
          ),
          _lcDivider(),
          _lcCompareRow(
            'SliverMultiBoxAdaptorParentData',
            ['(all of the above)', 'index: int?', '_keepAlive: bool'],
            _lcCrimson,
          ),
        ],
      )),
      _lcCard('When to Use Which?', Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _lcDecisionRow('Custom sliver with fixed children',
              'SliverLogicalContainerParentData', _lcNavy),
          _lcDecisionRow('SliverList / SliverGrid (adaptor-based)',
              'SliverMultiBoxAdaptorParentData', _lcCrimson),
          _lcDecisionRow('Simple single-child sliver',
              'SliverPhysicalParentData', _lcTeal),
          _lcDecisionRow('Sliver without box children',
              'SliverParentData (no box fields)', _lcSlate),
        ],
      )),
      _lcCode(
        '// SliverMultiBoxAdaptorParentData adds:\n'
        'class SliverMultiBoxAdaptorParentData\n'
        '    extends SliverLogicalContainerParentData {\n'
        '  int? index;\n'
        '  bool _keepAlive = false;\n\n'
        '  bool get keptAlive => _keepAlive;\n'
        '}',
      ),
    ],
  );
}

Widget _lcCompareRow(String title, List<String> fields, Color color) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title,
          style: TextStyle(
              fontSize: 12, fontWeight: FontWeight.bold, color: color)),
      const SizedBox(height: 4),
      ...fields.map((f) => Padding(
            padding: const EdgeInsets.only(left: 12, bottom: 2),
            child: Row(
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration:
                      BoxDecoration(color: color, shape: BoxShape.circle),
                ),
                const SizedBox(width: 8),
                Text(f,
                    style: const TextStyle(
                        fontSize: 11,
                        fontFamily: 'monospace',
                        color: _lcCharcoal)),
              ],
            ),
          )),
    ],
  );
}

Widget _lcDecisionRow(String scenario, String parentData, Color color) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(scenario,
              style: const TextStyle(fontSize: 11, color: _lcCharcoal)),
        ),
        const SizedBox(width: 8),
        _lcPill(parentData, color),
      ],
    ),
  );
}

// -------------- Summary --------------------------------------------------

Widget _buildSummary() {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.fromLTRB(12, 12, 12, 8),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [_lcNavy, _lcDeepNavy],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white, size: 20),
            SizedBox(width: 8),
            Text('Summary',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 14),
        _lcSummaryPoint(
          'SliverLogicalContainerParentData extends '
          'SliverPhysicalContainerParentData with no new fields.'),
        _lcSummaryPoint(
          'It inherits paintOffset (from SliverPhysicalParentData) and '
          'previousSibling/nextSibling (from ContainerParentDataMixin).'),
        _lcSummaryPoint(
          'The class exists as a type marker distinguishing slivers '
          'that track children logically (by index) from those that '
          'only track them physically (by linked list).'),
        _lcSummaryPoint(
          'Physical children are in the doubly-linked list and are '
          'painted and hit-tested during each frame.'),
        _lcSummaryPoint(
          'Logical-only children (keep-alive) are stored in a separate '
          'bucket with their state preserved.'),
        _lcSummaryPoint(
          'SliverMultiBoxAdaptorParentData (the subclass) adds index '
          'and keepAlive fields for SliverList/SliverGrid.'),
        _lcSummaryPoint(
          'The linked list is maintained by ContainerRenderObjectMixin, '
          'which calls insert/remove on the parent data pointers.'),
        _lcSummaryPoint(
          'Understanding this hierarchy is key to implementing custom '
          'slivers that manage multiple box children.'),
      ],
    ),
  );
}

Widget _lcSummaryPoint(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 2),
          child: Icon(Icons.arrow_right, color: _lcIce, size: 16),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Text(text,
              style: const TextStyle(
                  color: Colors.white, fontSize: 12, height: 1.5)),
        ),
      ],
    ),
  );
}
