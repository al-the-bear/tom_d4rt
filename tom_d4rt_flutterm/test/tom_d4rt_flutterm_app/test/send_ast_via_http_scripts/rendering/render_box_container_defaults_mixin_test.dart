// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/material.dart';

// Deep demo: ContainerBoxParentData & container defaults mixin
// Shows multi-child layout parent data, Stack, Positioned,
// IndexedStack, CustomMultiChildLayout, and parent data flow.

Widget _buildHeader(String title) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 18, horizontal: 20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF1A237E), Color(0xFF4A148C)],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(14),
      boxShadow: [
        BoxShadow(
          color: Color(0x55000000),
          blurRadius: 10,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        letterSpacing: 1.2,
      ),
    ),
  );
}

Widget _buildSectionTitle(String title) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.only(top: 20, bottom: 10),
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF00695C), Color(0xFF00897B)],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),
  );
}

Widget _buildInfoCard(String label, String description) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Color(0xFFF3E5F5),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Color(0xFFCE93D8), width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4A148C),
          ),
        ),
        SizedBox(height: 4),
        Text(
          description,
          style: TextStyle(fontSize: 13, color: Color(0xFF37474F)),
        ),
      ],
    ),
  );
}

Widget _buildColorBox(Color color, String label, double w, double h) {
  return Container(
    width: w,
    height: h,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: Colors.black26, width: 1),
    ),
    alignment: Alignment.center,
    child: Text(
      label,
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  );
}

// Section 1: Basic Stack with ContainerBoxParentData positioning
Widget _buildBasicStackSection() {
  print('[ContainerBoxParentData] Section 1: Basic Stack demo');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionTitle('1. Basic Stack with Positioned Children'),
      _buildInfoCard(
        'ContainerBoxParentData',
        'Each child in a Stack gets ContainerBoxParentData which holds '
            'the offset computed during layout. Positioned widgets set '
            'constraints that the RenderStack uses to place children.',
      ),
      SizedBox(height: 8),
      Container(
        height: 220,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFFECEFF1),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Color(0xFF90A4AE), width: 2),
        ),
        child: Stack(
          children: [
            // Base layer - fills the stack
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFE3F2FD), Color(0xFFBBDEFB)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  'Base Layer (no Positioned)',
                  style: TextStyle(fontSize: 14, color: Color(0xFF1565C0)),
                ),
              ),
            ),
            // Top-left positioned child
            Positioned(
              left: 10,
              top: 10,
              child: _buildColorBox(Color(0xFFE53935), 'TL', 70, 50),
            ),
            // Top-right positioned child
            Positioned(
              right: 10,
              top: 10,
              child: _buildColorBox(Color(0xFF43A047), 'TR', 70, 50),
            ),
            // Bottom-left positioned child
            Positioned(
              left: 10,
              bottom: 10,
              child: _buildColorBox(Color(0xFF1E88E5), 'BL', 70, 50),
            ),
            // Bottom-right positioned child
            Positioned(
              right: 10,
              bottom: 10,
              child: _buildColorBox(Color(0xFFFB8C00), 'BR', 70, 50),
            ),
            // Center positioned with width and height
            Positioned(
              left: 100,
              top: 80,
              width: 120,
              height: 60,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF8E24AA),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Center\n(l:100, t:80)',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

// Section 2: StackFit values
Widget _buildStackFitSection() {
  print('[ContainerBoxParentData] Section 2: StackFit values');

  Widget buildFitDemo(String label, StackFit fit, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Color(0xFF37474F),
          ),
        ),
        SizedBox(height: 4),
        Container(
          width: 110,
          height: 110,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black38, width: 2),
            borderRadius: BorderRadius.circular(6),
            color: Color(0xFFFAFAFA),
          ),
          child: Stack(
            fit: fit,
            children: [
              Container(color: color.withOpacity(0.3)),
              Center(
                child: Container(
                  width: 50,
                  height: 50,
                  color: color,
                  alignment: Alignment.center,
                  child: Text(
                    '50x50',
                    style: TextStyle(fontSize: 9, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionTitle('2. StackFit Values'),
      _buildInfoCard(
        'StackFit',
        'Controls how non-positioned children are sized. '
            'loose: children can be smaller. '
            'expand: children forced to fill. '
            'passthrough: parent constraints passed through.',
      ),
      SizedBox(height: 8),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildFitDemo('StackFit.loose', StackFit.loose, Color(0xFF1565C0)),
          buildFitDemo('StackFit.expand', StackFit.expand, Color(0xFFC62828)),
          buildFitDemo(
            'StackFit.passthrough',
            StackFit.passthrough,
            Color(0xFF2E7D32),
          ),
        ],
      ),
    ],
  );
}

// Section 3: Stack Alignment values
Widget _buildAlignmentSection() {
  print('[ContainerBoxParentData] Section 3: Stack alignment values');

  Widget buildAlignDemo(String label, AlignmentDirectional align, Color clr) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Container(
          width: 90,
          height: 90,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1),
            color: Color(0xFFF5F5F5),
          ),
          child: Stack(
            alignment: align,
            children: [
              Container(width: 40, height: 40, color: clr),
              Container(width: 20, height: 20, color: clr.withOpacity(0.5)),
            ],
          ),
        ),
      ],
    );
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionTitle('3. Stack Alignment Values'),
      _buildInfoCard(
        'Alignment',
        'Non-positioned children are placed according to the '
            'alignment property. Each demo shows two overlapping boxes '
            'aligned differently within the Stack.',
      ),
      SizedBox(height: 8),
      Wrap(
        spacing: 12,
        runSpacing: 12,
        children: [
          buildAlignDemo(
            'topStart',
            AlignmentDirectional.topStart,
            Color(0xFFD32F2F),
          ),
          buildAlignDemo(
            'topCenter',
            AlignmentDirectional.topCenter,
            Color(0xFF1976D2),
          ),
          buildAlignDemo(
            'topEnd',
            AlignmentDirectional.topEnd,
            Color(0xFF388E3C),
          ),
          buildAlignDemo(
            'centerStart',
            AlignmentDirectional.centerStart,
            Color(0xFFF57C00),
          ),
          buildAlignDemo(
            'center',
            AlignmentDirectional.center,
            Color(0xFF7B1FA2),
          ),
          buildAlignDemo(
            'centerEnd',
            AlignmentDirectional.centerEnd,
            Color(0xFF00796B),
          ),
          buildAlignDemo(
            'bottomStart',
            AlignmentDirectional.bottomStart,
            Color(0xFF5D4037),
          ),
          buildAlignDemo(
            'bottomCenter',
            AlignmentDirectional.bottomCenter,
            Color(0xFF455A64),
          ),
          buildAlignDemo(
            'bottomEnd',
            AlignmentDirectional.bottomEnd,
            Color(0xFFC2185B),
          ),
        ],
      ),
    ],
  );
}

// Section 4: Positioned variations
Widget _buildPositionedVariationsSection() {
  print('[ContainerBoxParentData] Section 4: Positioned variations');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionTitle('4. Positioned Widget Variations'),
      _buildInfoCard(
        'Positioned parameters',
        'left, top, right, bottom define edges. '
            'width, height define size. Setting opposing edges (left+right) '
            'stretches the child. Positioned.fill sets all edges to 0.',
      ),
      SizedBox(height: 8),
      Container(
        height: 250,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFFFFF8E1),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Color(0xFFFFCC80), width: 2),
        ),
        child: Stack(
          children: [
            // Positioned with left and top only
            Positioned(
              left: 8,
              top: 8,
              child: _buildColorBox(Color(0xFF5C6BC0), 'l:8 t:8', 80, 40),
            ),
            // Positioned with right and bottom only
            Positioned(
              right: 8,
              bottom: 8,
              child: _buildColorBox(Color(0xFF26A69A), 'r:8 b:8', 80, 40),
            ),
            // Positioned with left+right (stretches horizontally)
            Positioned(
              left: 20,
              right: 20,
              top: 60,
              height: 35,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFEF5350),
                  borderRadius: BorderRadius.circular(6),
                ),
                alignment: Alignment.center,
                child: Text(
                  'left:20, right:20 (stretches)',
                  style: TextStyle(fontSize: 11, color: Colors.white),
                ),
              ),
            ),
            // Positioned with top+bottom (stretches vertically)
            Positioned(
              left: 8,
              top: 105,
              bottom: 60,
              width: 100,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF66BB6A),
                  borderRadius: BorderRadius.circular(6),
                ),
                alignment: Alignment.center,
                child: Text(
                  't+b\nstretch',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 10, color: Colors.white),
                ),
              ),
            ),
            // Positioned with explicit width and height
            Positioned(
              left: 130,
              top: 110,
              width: 100,
              height: 60,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFAB47BC),
                  borderRadius: BorderRadius.circular(6),
                ),
                alignment: Alignment.center,
                child: Text(
                  'w:100 h:60',
                  style: TextStyle(fontSize: 11, color: Colors.white),
                ),
              ),
            ),
            // Positioned.fill demo
            Positioned(
              left: 130,
              right: 8,
              bottom: 8,
              height: 35,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFFF7043),
                  borderRadius: BorderRadius.circular(6),
                ),
                alignment: Alignment.center,
                child: Text(
                  'like Positioned.fill but with edges',
                  style: TextStyle(fontSize: 10, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

// Section 5: Positioned.fill and Positioned.directional
Widget _buildPositionedFillDirectionalSection() {
  print('[ContainerBoxParentData] Section 5: Positioned.fill & directional');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionTitle('5. Positioned.fill & Positioned.directional'),
      _buildInfoCard(
        'Positioned.fill',
        'Sets left, top, right, and bottom all to 0.0 by default '
            'making the child fill the entire Stack.',
      ),
      _buildInfoCard(
        'Positioned.directional',
        'Uses start/end instead of left/right, '
            'adapting to text direction (LTR/RTL).',
      ),
      SizedBox(height: 8),
      // Positioned.fill demo
      Container(
        height: 120,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xFF78909C), width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF42A5F5), Color(0xFF1565C0)],
                  ),
                  borderRadius: BorderRadius.circular(6),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Positioned.fill - fills entire Stack',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Positioned(
              right: 10,
              bottom: 10,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                color: Color(0xCCFFFFFF),
                child: Text('On top of fill', style: TextStyle(fontSize: 11)),
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 12),
      // Positioned.directional demo
      Container(
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xFF78909C), width: 2),
          borderRadius: BorderRadius.circular(8),
          color: Color(0xFFF1F8E9),
        ),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Stack(
            children: [
              Positioned.directional(
                textDirection: TextDirection.ltr,
                start: 10,
                top: 10,
                child: _buildColorBox(Color(0xFF2E7D32), 'LTR start', 100, 35),
              ),
              Positioned.directional(
                textDirection: TextDirection.rtl,
                start: 10,
                bottom: 10,
                child: _buildColorBox(Color(0xFFC62828), 'RTL start', 100, 35),
              ),
              Positioned(
                left: 130,
                top: 30,
                child: Text(
                  'LTR start = left\nRTL start = right',
                  style: TextStyle(fontSize: 11, color: Color(0xFF37474F)),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

// Section 6: IndexedStack
Widget _buildIndexedStackSection() {
  print('[ContainerBoxParentData] Section 6: IndexedStack');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionTitle('6. IndexedStack - Show One Child at a Time'),
      _buildInfoCard(
        'IndexedStack',
        'A Stack that shows only one child (by index). '
            'All children maintain state but only the indexed child is visible. '
            'Uses same ContainerBoxParentData internally.',
      ),
      SizedBox(height: 8),
      // Show three IndexedStack instances, each showing a different index
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildIndexedStackDemo(0),
          _buildIndexedStackDemo(1),
          _buildIndexedStackDemo(2),
        ],
      ),
    ],
  );
}

Widget _buildIndexedStackDemo(int activeIndex) {
  print('[IndexedStack] Showing index $activeIndex');
  List<Color> colors = [
    Color(0xFFE53935),
    Color(0xFF43A047),
    Color(0xFF1E88E5),
  ];
  List<String> labels = ['Page A', 'Page B', 'Page C'];
  return Column(
    children: [
      Text(
        'index: $activeIndex',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Color(0xFF37474F),
        ),
      ),
      SizedBox(height: 4),
      Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black26, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: IndexedStack(
          index: activeIndex,
          alignment: Alignment.center,
          children: [
            Container(
              color: colors[0],
              alignment: Alignment.center,
              child: Text(
                labels[0],
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
            Container(
              color: colors[1],
              alignment: Alignment.center,
              child: Text(
                labels[1],
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
            Container(
              color: colors[2],
              alignment: Alignment.center,
              child: Text(
                labels[2],
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

// Section 7: Parent data flow visualization
Widget _buildParentDataFlowSection() {
  print('[ContainerBoxParentData] Section 7: Parent data flow');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionTitle('7. Parent Data Flow Through Layout System'),
      _buildInfoCard(
        'How ParentData works',
        'ParentData is set by the parent RenderObject on child RenderObjects. '
            'ContainerBoxParentData extends BoxParentData (which has offset) '
            'and ContainerParentDataMixin (which has nextSibling/previousSibling). '
            'This linked list structure enables efficient child traversal.',
      ),
      SizedBox(height: 8),
      // Visual diagram of parent data hierarchy
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Color(0xFFFFF3E0),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Color(0xFFFFB74D), width: 2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHierarchyBox(
              'ParentData',
              'Base class - empty',
              Color(0xFF37474F),
              0,
            ),
            _buildHierarchyArrow(),
            _buildHierarchyBox(
              'BoxParentData',
              'Adds: Offset offset',
              Color(0xFF1565C0),
              1,
            ),
            _buildHierarchyArrow(),
            _buildHierarchyBox(
              'ContainerBoxParentData<ChildType>',
              'Adds: nextSibling, previousSibling (linked list)',
              Color(0xFF2E7D32),
              2,
            ),
            _buildHierarchyArrow(),
            _buildHierarchyBox(
              'StackParentData',
              'Adds: top, right, bottom, left, width, height',
              Color(0xFFC62828),
              3,
            ),
            SizedBox(height: 16),
            // Flow description
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color(0xFFE8F5E9),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Layout Flow:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: Color(0xFF1B5E20),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '1. Parent calls setupParentData() for each child',
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(
                    '2. Positioned reads constraints into StackParentData',
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(
                    '3. RenderStack reads StackParentData during layout',
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(
                    '4. Offset is computed and stored in parentData.offset',
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(
                    '5. During paint, offset is used to position the child',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _buildHierarchyBox(String name, String desc, Color color, int depth) {
  return Padding(
    padding: EdgeInsets.only(left: depth * 16.0),
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(desc, style: TextStyle(color: Color(0xCCFFFFFF), fontSize: 11)),
        ],
      ),
    ),
  );
}

Widget _buildHierarchyArrow() {
  return Padding(
    padding: EdgeInsets.only(left: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 2),
        Icon(Icons.arrow_downward, size: 18, color: Color(0xFF757575)),
        SizedBox(height: 2),
      ],
    ),
  );
}

// Section 8: CustomMultiChildLayout
Widget _buildCustomMultiChildLayoutSection() {
  print('[ContainerBoxParentData] Section 8: CustomMultiChildLayout');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionTitle('8. CustomMultiChildLayout'),
      _buildInfoCard(
        'CustomMultiChildLayout',
        'Another consumer of multi-child parent data. '
            'Uses MultiChildLayoutDelegate to position children by ID. '
            'Each child gets a LayoutId widget that assigns a unique id '
            'used during the delegate performLayout callback.',
      ),
      SizedBox(height: 8),
      Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFFE8EAF6),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Color(0xFF7986CB), width: 2),
        ),
        child: CustomMultiChildLayout(
          delegate: _DemoLayoutDelegate(),
          children: [
            LayoutId(
              id: 'header',
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF3F51B5),
                  borderRadius: BorderRadius.circular(6),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Header (id: header)',
                  style: TextStyle(color: Colors.white, fontSize: 13),
                ),
              ),
            ),
            LayoutId(
              id: 'body',
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF7986CB),
                  borderRadius: BorderRadius.circular(6),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Body (id: body)',
                  style: TextStyle(color: Colors.white, fontSize: 13),
                ),
              ),
            ),
            LayoutId(
              id: 'footer',
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF283593),
                  borderRadius: BorderRadius.circular(6),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Footer (id: footer)',
                  style: TextStyle(color: Colors.white, fontSize: 13),
                ),
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 8),
      _buildInfoCard(
        'MultiChildLayoutDelegate',
        'The delegate measures children with layoutChild() and '
            'positions them with positionChild(). '
            'Children are identified by the id given to LayoutId. '
            'This is lower-level than Stack but gives full control.',
      ),
    ],
  );
}

// Section 9: Nested Stacks and complex composition
Widget _buildNestedStacksSection() {
  print('[ContainerBoxParentData] Section 9: Nested Stacks and composition');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionTitle('9. Nested Stacks & Complex Composition'),
      _buildInfoCard(
        'Nested multi-child layouts',
        'Stacks can be nested. Each Stack creates its own set of '
            'ContainerBoxParentData for its direct children. '
            'ParentData never leaks across boundaries.',
      ),
      SizedBox(height: 8),
      Container(
        height: 220,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFFEDE7F6),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Color(0xFFB39DDB), width: 2),
        ),
        child: Stack(
          children: [
            // Outer layer
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFE1BEE7), Color(0xFFCE93D8)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Outer Stack',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF4A148C),
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
            // Inner stack positioned in the center-left
            Positioned(
              left: 15,
              top: 30,
              width: 150,
              height: 160,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFF7B1FA2), width: 2),
                  borderRadius: BorderRadius.circular(8),
                  color: Color(0x33FFFFFF),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      left: 5,
                      top: 5,
                      child: _buildColorBox(
                        Color(0xFFAD1457),
                        'Inner A',
                        60,
                        35,
                      ),
                    ),
                    Positioned(
                      right: 5,
                      bottom: 5,
                      child: _buildColorBox(
                        Color(0xFF00695C),
                        'Inner B',
                        60,
                        35,
                      ),
                    ),
                    Positioned(
                      left: 30,
                      top: 55,
                      child: Text(
                        'Inner Stack',
                        style: TextStyle(
                          fontSize: 11,
                          color: Color(0xFF4A148C),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Another inner stack on the right
            Positioned(
              right: 15,
              top: 30,
              width: 150,
              height: 160,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFF0D47A1), width: 2),
                  borderRadius: BorderRadius.circular(8),
                  color: Color(0x33FFFFFF),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Color(0xFF1565C0),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Center',
                        style: TextStyle(color: Colors.white, fontSize: 11),
                      ),
                    ),
                    Positioned(
                      left: 5,
                      top: 5,
                      child: Container(
                        padding: EdgeInsets.all(4),
                        color: Color(0xCC1565C0),
                        child: Text(
                          'Corner',
                          style: TextStyle(color: Colors.white, fontSize: 9),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 30,
                      bottom: 8,
                      child: Text(
                        'Aligned Stack',
                        style: TextStyle(
                          fontSize: 11,
                          color: Color(0xFF0D47A1),
                          fontWeight: FontWeight.bold,
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
    ],
  );
}

// Custom layout delegate for section 8
class _DemoLayoutDelegate extends MultiChildLayoutDelegate {
  _DemoLayoutDelegate();

  @override
  void performLayout(Size size) {
    print('[CustomLayout] performLayout called with size: $size');
    double headerHeight = 45;
    double footerHeight = 40;
    double spacing = 8;

    // Layout header
    if (hasChild('header')) {
      layoutChild(
        'header',
        BoxConstraints.tightFor(width: size.width - 20, height: headerHeight),
      );
      positionChild('header', Offset(10, 10));
      print('[CustomLayout] Positioned header at (10, 10)');
    }

    // Layout body
    if (hasChild('body')) {
      double bodyTop = 10 + headerHeight + spacing;
      double bodyHeight =
          size.height - headerHeight - footerHeight - spacing * 3 - 20;
      layoutChild(
        'body',
        BoxConstraints.tightFor(width: size.width - 20, height: bodyHeight),
      );
      positionChild('body', Offset(10, bodyTop));
      print('[CustomLayout] Positioned body at (10, $bodyTop)');
    }

    // Layout footer
    if (hasChild('footer')) {
      layoutChild(
        'footer',
        BoxConstraints.tightFor(width: size.width - 20, height: footerHeight),
      );
      double footerTop = size.height - footerHeight - 10;
      positionChild('footer', Offset(10, footerTop));
      print('[CustomLayout] Positioned footer at (10, $footerTop)');
    }
  }

  @override
  bool shouldRelayout(_DemoLayoutDelegate oldDelegate) {
    return false;
  }
}

// Main build entry point
dynamic build(BuildContext context) {
  print('=== ContainerBoxParentData & Defaults Mixin Demo ===');
  print('Demonstrating multi-child layout parent data system');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader('ContainerBoxParentData\n& Container Defaults Mixin'),
        SizedBox(height: 8),
        _buildInfoCard(
          'Overview',
          'ContainerBoxParentData combines BoxParentData (offset positioning) '
              'with ContainerParentDataMixin (linked-list child traversal). '
              'This is the foundation for multi-child layout widgets like '
              'Stack, Row, Column, Wrap, and CustomMultiChildLayout.',
        ),
        SizedBox(height: 16),
        _buildBasicStackSection(),
        SizedBox(height: 16),
        _buildStackFitSection(),
        SizedBox(height: 16),
        _buildAlignmentSection(),
        SizedBox(height: 16),
        _buildPositionedVariationsSection(),
        SizedBox(height: 16),
        _buildPositionedFillDirectionalSection(),
        SizedBox(height: 16),
        _buildIndexedStackSection(),
        SizedBox(height: 16),
        _buildParentDataFlowSection(),
        SizedBox(height: 16),
        _buildCustomMultiChildLayoutSection(),
        SizedBox(height: 16),
        _buildNestedStacksSection(),
        SizedBox(height: 24),
        // Summary footer
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1A237E), Color(0xFF283593)],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Summary',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'ContainerBoxParentData is central to multi-child layouts. '
                'It provides offset-based positioning (from BoxParentData) '
                'and linked-list child traversal (from ContainerParentDataMixin). '
                'Stack, CustomMultiChildLayout, and similar widgets all rely '
                'on this parent data to position their children during layout.',
                style: TextStyle(fontSize: 13, color: Color(0xDDFFFFFF)),
              ),
            ],
          ),
        ),
        SizedBox(height: 32),
      ],
    ),
  );
}
