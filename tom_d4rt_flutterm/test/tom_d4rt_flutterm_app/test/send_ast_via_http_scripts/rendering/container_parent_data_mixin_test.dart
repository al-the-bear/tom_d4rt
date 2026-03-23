// ignore_for_file: avoid_print
// D4rt test script: Tests ContainerParentDataMixin from rendering
// ContainerParentDataMixin adds sibling navigation to ParentData for containers
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

dynamic build(BuildContext context) {
  print('ContainerParentDataMixin deep demo executing');
  print('This mixin provides previousSibling/nextSibling for linked list traversal');
  print('Used by ContainerRenderObjectMixin to manage child render objects');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
    ),
    home: Scaffold(
      appBar: AppBar(
        title: Text('ContainerParentDataMixin Deep Demo'),
        backgroundColor: Colors.indigo.shade100,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('1. ContainerParentDataMixin Concept'),
            _buildInfoCard(
              'ContainerParentDataMixin is a mixin on ParentData that adds sibling '
              'pointers to enable doubly-linked list traversal of render object children. '
              'This is essential for efficiently iterating children in both directions.',
              Colors.indigo.shade50,
            ),
            _buildMixinConceptSection(),
            SizedBox(height: 24),

            _buildSectionHeader('2. The Mixin Definition'),
            _buildInfoCard(
              'The mixin adds two key properties: previousSibling and nextSibling. '
              'These nullable references point to adjacent ParentData objects in the list. '
              'Both are managed automatically by ContainerRenderObjectMixin.',
              Colors.blue.shade50,
            ),
            _buildMixinDefinitionSection(),
            SizedBox(height: 24),

            _buildSectionHeader('3. previousSibling Property'),
            _buildInfoCard(
              'previousSibling is a nullable reference to the ParentData of the child '
              'that comes before this one in the container. It is null for the first child. '
              'Used for backward iteration through children.',
              Colors.purple.shade50,
            ),
            _buildPreviousSiblingSection(),
            SizedBox(height: 24),

            _buildSectionHeader('4. nextSibling Property'),
            _buildInfoCard(
              'nextSibling is a nullable reference to the ParentData of the child '
              'that comes after this one in the container. It is null for the last child. '
              'Used for forward iteration through children.',
              Colors.teal.shade50,
            ),
            _buildNextSiblingSection(),
            SizedBox(height: 24),

            _buildSectionHeader('5. Linked List Structure'),
            _buildInfoCard(
              'Children in a container form a doubly-linked list through their ParentData. '
              'firstChild and lastChild on the container point to the endpoints. '
              'Each child ParentData links to its neighbors via previousSibling/nextSibling.',
              Colors.amber.shade50,
            ),
            _buildLinkedListStructureSection(),
            SizedBox(height: 24),

            _buildSectionHeader('6. Linked List Visualization'),
            _buildInfoCard(
              'Visual representation of how children are linked together. '
              'The doubly-linked list enables O(1) insertion and removal at any position '
              'when combined with direct access to the node.',
              Colors.cyan.shade50,
            ),
            _buildLinkedListVisualizationSection(),
            SizedBox(height: 24),

            _buildSectionHeader('7. Forward Traversal Pattern'),
            _buildInfoCard(
              'Starting from firstChild, follow nextSibling links until null. '
              'This is the most common traversal pattern for layout and painting.',
              Colors.green.shade50,
            ),
            _buildForwardTraversalSection(),
            SizedBox(height: 24),

            _buildSectionHeader('8. Backward Traversal Pattern'),
            _buildInfoCard(
              'Starting from lastChild, follow previousSibling links until null. '
              'Useful for reverse painting order or hit testing from front to back.',
              Colors.orange.shade50,
            ),
            _buildBackwardTraversalSection(),
            SizedBox(height: 24),

            _buildSectionHeader('9. Sibling Navigation Utilities'),
            _buildInfoCard(
              'Common utility patterns for navigating between siblings. '
              'Includes finding nth sibling, checking position, and counting neighbors.',
              Colors.pink.shade50,
            ),
            _buildSiblingNavigationUtilitiesSection(),
            SizedBox(height: 24),

            _buildSectionHeader('10. Integration with ContainerRenderObjectMixin'),
            _buildInfoCard(
              'ContainerRenderObjectMixin manages the linked list through insert, remove, '
              'and move operations. It maintains firstChild, lastChild, and childCount '
              'while updating sibling links appropriately.',
              Colors.deepPurple.shade50,
            ),
            _buildContainerIntegrationSection(),
            SizedBox(height: 24),

            _buildSectionHeader('11. Custom Container Implementation'),
            _buildInfoCard(
              'Example of creating a custom container render object that uses '
              'ContainerParentDataMixin for its children. Shows setupParentData, '
              'layout iteration, and paint order.',
              Colors.lime.shade50,
            ),
            _buildCustomContainerSection(),
            SizedBox(height: 24),

            _buildSectionHeader('12. Detaching and Reattaching'),
            _buildInfoCard(
              'When children are removed, sibling links are severed. On reattachment '
              'to a new parent or position, links are reestablished. The detach method '
              'sets both sibling references to null.',
              Colors.brown.shade50,
            ),
            _buildDetachReattachSection(),
            SizedBox(height: 40),
          ],
        ),
      ),
    ),
  );
}

Widget _buildSectionHeader(String title) {
  return Container(
    margin: EdgeInsets.only(bottom: 12, top: 8),
    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.indigo.shade700, Colors.indigo.shade500],
      ),
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withAlpha(60),
          blurRadius: 4,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  );
}

Widget _buildInfoCard(String text, Color backgroundColor) {
  return Container(
    margin: EdgeInsets.only(bottom: 16),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.link, color: Colors.grey.shade700, size: 20),
        SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 14, color: Colors.grey.shade800),
          ),
        ),
      ],
    ),
  );
}

Widget _buildCodeBlock(String title, String code) {
  return Container(
    margin: EdgeInsets.only(bottom: 12),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.indigo.shade700,
            borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
          ),
          child: Row(
            children: [
              Icon(Icons.code, color: Colors.white70, size: 16),
              SizedBox(width: 8),
              Text(title, style: TextStyle(color: Colors.white, fontSize: 12)),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(12),
          child: Text(
            code,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              color: Colors.green.shade300,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildConceptCard(String title, String description, IconData icon, Color color) {
  return Container(
    margin: EdgeInsets.only(bottom: 10),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: color.withAlpha(25),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withAlpha(80)),
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withAlpha(50),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: color),
              ),
              SizedBox(height: 4),
              Text(description, style: TextStyle(fontSize: 12, color: Colors.grey.shade700)),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildMixinConceptSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildConceptCard(
        'What is a Mixin?',
        'A Dart mixin adds functionality to a class without inheritance. '
        'ContainerParentDataMixin mixes into ParentData subclasses.',
        Icons.extension,
        Colors.indigo,
      ),
      _buildConceptCard(
        'ParentData Purpose',
        'ParentData stores information about a child that is managed by its parent. '
        'Different containers store different parent data (position, flex, etc).',
        Icons.data_object,
        Colors.blue,
      ),
      _buildConceptCard(
        'Why Siblings?',
        'Sibling pointers enable O(1) traversal between adjacent children. '
        'Without them, finding the next child would require array lookup.',
        Icons.compare_arrows,
        Colors.purple,
      ),
      _buildCodeBlock(
        'ContainerParentDataMixin Declaration',
        'mixin ContainerParentDataMixin<ChildType extends RenderObject>\n'
        '    on ParentData {\n'
        '  ChildType? previousSibling;\n'
        '  ChildType? nextSibling;\n'
        '  \n'
        '  void detach() {\n'
        '    super.detach();\n'
        '    previousSibling = null;\n'
        '    nextSibling = null;\n'
        '  }\n'
        '}',
      ),
    ],
  );
}

Widget _buildMixinDefinitionSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildConceptCard(
        'Type Parameter',
        'The mixin has a type parameter ChildType extends RenderObject. '
        'This ensures type safety when navigating between siblings.',
        Icons.label_outline,
        Colors.blue,
      ),
      _buildConceptCard(
        'Requires ParentData',
        'The "on ParentData" clause means this mixin can only be applied to '
        'classes that extend ParentData. It adds sibling functionality.',
        Icons.merge_type,
        Colors.teal,
      ),
      _buildCodeBlock(
        'BoxParentData with Container Mixin',
        'class BoxParentData extends ParentData {\n'
        '  Offset offset = Offset.zero;\n'
        '}\n'
        '\n'
        'class ContainerBoxParentData extends BoxParentData\n'
        '    with ContainerParentDataMixin<RenderBox> {\n'
        '  // Now has previousSibling and nextSibling\n'
        '  // pointing to RenderBox instances\n'
        '}',
      ),
      _buildCodeBlock(
        'Custom ParentData Example',
        'class MyCustomParentData extends ParentData\n'
        '    with ContainerParentDataMixin<RenderBox> {\n'
        '  int priority = 0;\n'
        '  bool isVisible = true;\n'
        '  Alignment alignment = Alignment.center;\n'
        '}',
      ),
    ],
  );
}

Widget _buildPreviousSiblingSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildConceptCard(
        'Backward Link',
        'previousSibling points to the child that was inserted before this one. '
        'For the first child in the container, previousSibling is null.',
        Icons.arrow_back,
        Colors.purple,
      ),
      _buildConceptCard(
        'Type Safety',
        'previousSibling is typed as ChildType? where ChildType extends RenderObject. '
        'This prevents mixing incompatible render object types.',
        Icons.security,
        Colors.green,
      ),
      _buildCodeBlock(
        'Accessing previousSibling',
        'void processChildWithPredecessor(RenderBox child) {\n'
        '  var parentData = child.parentData\n'
        '      as ContainerParentDataMixin<RenderBox>;\n'
        '  \n'
        '  RenderBox? prev = parentData.previousSibling;\n'
        '  if (prev != null) {\n'
        '    print("Found previous sibling");\n'
        '    // Can access prev layout info, size, etc\n'
        '  } else {\n'
        '    print("This is the first child");\n'
        '  }\n'
        '}',
      ),
      _buildCodeBlock(
        'Checking for First Child',
        'bool isFirstChild(RenderBox child) {\n'
        '  var parentData = child.parentData\n'
        '      as ContainerParentDataMixin<RenderBox>;\n'
        '  return parentData.previousSibling == null;\n'
        '}',
      ),
    ],
  );
}

Widget _buildNextSiblingSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildConceptCard(
        'Forward Link',
        'nextSibling points to the child that was inserted after this one. '
        'For the last child in the container, nextSibling is null.',
        Icons.arrow_forward,
        Colors.teal,
      ),
      _buildConceptCard(
        'Traversal Endpoint',
        'When nextSibling returns null, you have reached the end of the child list. '
        'This is how forward iteration loops terminate.',
        Icons.stop_circle_outlined,
        Colors.orange,
      ),
      _buildCodeBlock(
        'Accessing nextSibling',
        'void processChildWithSuccessor(RenderBox child) {\n'
        '  var parentData = child.parentData\n'
        '      as ContainerParentDataMixin<RenderBox>;\n'
        '  \n'
        '  RenderBox? next = parentData.nextSibling;\n'
        '  if (next != null) {\n'
        '    print("Found next sibling");\n'
        '    // Can use next for layout dependency\n'
        '  } else {\n'
        '    print("This is the last child");\n'
        '  }\n'
        '}',
      ),
      _buildCodeBlock(
        'Checking for Last Child',
        'bool isLastChild(RenderBox child) {\n'
        '  var parentData = child.parentData\n'
        '      as ContainerParentDataMixin<RenderBox>;\n'
        '  return parentData.nextSibling == null;\n'
        '}',
      ),
    ],
  );
}

Widget _buildLinkedListStructureSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildConceptCard(
        'Doubly-Linked List',
        'The children form a doubly-linked list. Each node has forward and '
        'backward pointers. This enables efficient bidirectional traversal.',
        Icons.link,
        Colors.amber,
      ),
      _buildConceptCard(
        'Container Endpoints',
        'ContainerRenderObjectMixin provides firstChild and lastChild getters. '
        'These are the head and tail of the linked list.',
        Icons.first_page,
        Colors.deepOrange,
      ),
      _buildCodeBlock(
        'Linked List Structure',
        'Container (has firstChild, lastChild, childCount)\n'
        '    │\n'
        '    ├─ Child A (parentData.previousSibling = null)\n'
        '    │           (parentData.nextSibling = B)\n'
        '    │\n'
        '    ├─ Child B (parentData.previousSibling = A)\n'
        '    │           (parentData.nextSibling = C)\n'
        '    │\n'
        '    └─ Child C (parentData.previousSibling = B)\n'
        '                (parentData.nextSibling = null)',
      ),
      _buildCodeBlock(
        'Container Properties',
        'abstract class ContainerRenderObjectMixin<\n'
        '    ChildType extends RenderObject,\n'
        '    ParentDataType extends ContainerParentDataMixin<ChildType>\n'
        '> {\n'
        '  int get childCount;\n'
        '  ChildType? get firstChild;\n'
        '  ChildType? get lastChild;\n'
        '  \n'
        '  // Methods to modify the list\n'
        '  void insert(ChildType child, {ChildType? after});\n'
        '  void remove(ChildType child);\n'
        '  void move(ChildType child, {ChildType? after});\n'
        '}',
      ),
    ],
  );
}

Widget _buildLinkedListVisualizationSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade400),
        ),
        child: Column(
          children: [
            Text(
              'Doubly-Linked List Visualization',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 16),
            _buildLinkedListDiagram(),
          ],
        ),
      ),
      SizedBox(height: 12),
      _buildCodeBlock(
        'Visual Legend',
        '┌─────────┐    ┌─────────┐    ┌─────────┐\n'
        '│ Child A │◄──►│ Child B │◄──►│ Child C │\n'
        '└─────────┘    └─────────┘    └─────────┘\n'
        '     ▲                              ▲\n'
        '     │                              │\n'
        'firstChild                     lastChild\n'
        '\n'
        '◄──► represents sibling links\n'
        '──►  is nextSibling direction\n'
        '◄──  is previousSibling direction',
      ),
      _buildCodeBlock(
        'Memory Relationships',
        'Container RenderObject\n'
        '├── firstChild ──────────────────┐\n'
        '├── lastChild ───────────────────┼──┐\n'
        '│                                │  │\n'
        '│   ┌────────────────────────────┘  │\n'
        '│   │                               │\n'
        '│   ▼                               │\n'
        '│ Child A.parentData                │\n'
        '│   ├── previousSibling: null       │\n'
        '│   └── nextSibling ──────────┐     │\n'
        '│                             │     │\n'
        '│   ┌─────────────────────────┘     │\n'
        '│   │                               │\n'
        '│   ▼                               │\n'
        '│ Child B.parentData                │\n'
        '│   ├── previousSibling ─────► A    │\n'
        '│   └── nextSibling ──────────┐     │\n'
        '│                             │     │\n'
        '│   ┌─────────────────────────┘     │\n'
        '│   │                               │\n'
        '│   ▼  ◄────────────────────────────┘\n'
        '│ Child C.parentData\n'
        '│   ├── previousSibling ─────► B\n'
        '│   └── nextSibling: null',
      ),
    ],
  );
}

Widget _buildLinkedListDiagram() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      _buildNodeBox('A', 'first', Colors.green),
      _buildArrowBidirectional(),
      _buildNodeBox('B', 'middle', Colors.blue),
      _buildArrowBidirectional(),
      _buildNodeBox('C', 'last', Colors.orange),
    ],
  );
}

Widget _buildNodeBox(String label, String position, Color color) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withAlpha(50),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color, width: 2),
    ),
    child: Column(
      children: [
        Text(
          'Child $label',
          style: TextStyle(fontWeight: FontWeight.bold, color: color),
        ),
        SizedBox(height: 4),
        Text(
          position,
          style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
        ),
      ],
    ),
  );
}

Widget _buildArrowBidirectional() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8),
    child: Row(
      children: [
        Icon(Icons.arrow_back, size: 16, color: Colors.grey.shade600),
        Container(
          width: 20,
          height: 2,
          color: Colors.grey.shade600,
        ),
        Icon(Icons.arrow_forward, size: 16, color: Colors.grey.shade600),
      ],
    ),
  );
}

Widget _buildForwardTraversalSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildConceptCard(
        'Start at firstChild',
        'Forward traversal begins at the firstChild property of the container. '
        'If firstChild is null, the container has no children.',
        Icons.play_arrow,
        Colors.green,
      ),
      _buildConceptCard(
        'Follow nextSibling',
        'From each child, access its parentData.nextSibling to get the next child. '
        'Continue until nextSibling is null.',
        Icons.navigate_next,
        Colors.blue,
      ),
      _buildCodeBlock(
        'Forward Iteration Pattern',
        'void visitChildrenForward() {\n'
        '  RenderBox? child = firstChild;\n'
        '  while (child != null) {\n'
        '    // Process child here\n'
        '    print("Visiting: child");\n'
        '    \n'
        '    // Move to next sibling\n'
        '    var parentData = child.parentData\n'
        '        as ContainerParentDataMixin<RenderBox>;\n'
        '    child = parentData.nextSibling;\n'
        '  }\n'
        '}',
      ),
      _buildCodeBlock(
        'Layout Children Forward',
        'void performLayout() {\n'
        '  var accumulatedHeight = 0.0;\n'
        '  RenderBox? child = firstChild;\n'
        '  \n'
        '  while (child != null) {\n'
        '    child.layout(constraints, parentUsesSize: true);\n'
        '    \n'
        '    var parentData = child.parentData as BoxParentData;\n'
        '    parentData.offset = Offset(0, accumulatedHeight);\n'
        '    accumulatedHeight += child.size.height;\n'
        '    \n'
        '    var containerData = child.parentData\n'
        '        as ContainerParentDataMixin<RenderBox>;\n'
        '    child = containerData.nextSibling;\n'
        '  }\n'
        '  \n'
        '  size = Size(constraints.maxWidth, accumulatedHeight);\n'
        '}',
      ),
    ],
  );
}

Widget _buildBackwardTraversalSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildConceptCard(
        'Start at lastChild',
        'Backward traversal begins at the lastChild property of the container. '
        'Useful for reverse painting order or priority-based processing.',
        Icons.last_page,
        Colors.orange,
      ),
      _buildConceptCard(
        'Follow previousSibling',
        'From each child, access its parentData.previousSibling to get the previous child. '
        'Continue until previousSibling is null.',
        Icons.navigate_before,
        Colors.red,
      ),
      _buildCodeBlock(
        'Backward Iteration Pattern',
        'void visitChildrenBackward() {\n'
        '  RenderBox? child = lastChild;\n'
        '  while (child != null) {\n'
        '    // Process child here\n'
        '    print("Visiting in reverse: child");\n'
        '    \n'
        '    // Move to previous sibling\n'
        '    var parentData = child.parentData\n'
        '        as ContainerParentDataMixin<RenderBox>;\n'
        '    child = parentData.previousSibling;\n'
        '  }\n'
        '}',
      ),
      _buildCodeBlock(
        'Hit Test Reverse Order',
        'bool hitTestChildren(BoxHitTestResult result, Offset position) {\n'
        '  // Test from front to back (last painted = front)\n'
        '  RenderBox? child = lastChild;\n'
        '  \n'
        '  while (child != null) {\n'
        '    var parentData = child.parentData as BoxParentData;\n'
        '    var transformed = position - parentData.offset;\n'
        '    \n'
        '    if (child.hitTest(result, position: transformed)) {\n'
        '      return true;\n'
        '    }\n'
        '    \n'
        '    var containerData = child.parentData\n'
        '        as ContainerParentDataMixin<RenderBox>;\n'
        '    child = containerData.previousSibling;\n'
        '  }\n'
        '  return false;\n'
        '}',
      ),
    ],
  );
}

Widget _buildSiblingNavigationUtilitiesSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildCodeBlock(
        'Find Nth Next Sibling',
        'RenderBox? nthNextSibling(RenderBox child, int n) {\n'
        '  RenderBox? current = child;\n'
        '  for (var i = 0; i < n && current != null; i++) {\n'
        '    var parentData = current.parentData\n'
        '        as ContainerParentDataMixin<RenderBox>;\n'
        '    current = parentData.nextSibling;\n'
        '  }\n'
        '  return current;\n'
        '}',
      ),
      _buildCodeBlock(
        'Count Siblings After',
        'int countSiblingsAfter(RenderBox child) {\n'
        '  var count = 0;\n'
        '  var parentData = child.parentData\n'
        '      as ContainerParentDataMixin<RenderBox>;\n'
        '  var sibling = parentData.nextSibling;\n'
        '  \n'
        '  while (sibling != null) {\n'
        '    count++;\n'
        '    parentData = sibling.parentData\n'
        '        as ContainerParentDataMixin<RenderBox>;\n'
        '    sibling = parentData.nextSibling;\n'
        '  }\n'
        '  return count;\n'
        '}',
      ),
      _buildCodeBlock(
        'Get Child Index',
        'int getChildIndex(RenderBox child) {\n'
        '  var index = 0;\n'
        '  var parentData = child.parentData\n'
        '      as ContainerParentDataMixin<RenderBox>;\n'
        '  var sibling = parentData.previousSibling;\n'
        '  \n'
        '  while (sibling != null) {\n'
        '    index++;\n'
        '    parentData = sibling.parentData\n'
        '        as ContainerParentDataMixin<RenderBox>;\n'
        '    sibling = parentData.previousSibling;\n'
        '  }\n'
        '  return index;\n'
        '}',
      ),
      _buildCodeBlock(
        'Are Adjacent Siblings',
        'bool areAdjacentSiblings(RenderBox a, RenderBox b) {\n'
        '  var aData = a.parentData\n'
        '      as ContainerParentDataMixin<RenderBox>;\n'
        '  var bData = b.parentData\n'
        '      as ContainerParentDataMixin<RenderBox>;\n'
        '  \n'
        '  return aData.nextSibling == b || bData.nextSibling == a;\n'
        '}',
      ),
    ],
  );
}

Widget _buildContainerIntegrationSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildConceptCard(
        'insert() Operation',
        'When inserting a child, the container updates sibling links. '
        'The optional "after" parameter specifies insertion position.',
        Icons.add_circle_outline,
        Colors.green,
      ),
      _buildConceptCard(
        'remove() Operation',
        'When removing a child, adjacent siblings are reconnected. '
        'The removed childs sibling links are cleared via detach.',
        Icons.remove_circle_outline,
        Colors.red,
      ),
      _buildConceptCard(
        'move() Operation',
        'Moving repositions a child within the list. '
        'Sibling links are updated for old and new positions.',
        Icons.swap_horiz,
        Colors.blue,
      ),
      _buildCodeBlock(
        'Insert Operation Logic',
        'void insert(ChildType child, {ChildType? after}) {\n'
        '  adoptChild(child);\n'
        '  \n'
        '  var childParentData = child.parentData\n'
        '      as ContainerParentDataMixin<ChildType>;\n'
        '  \n'
        '  if (after == null) {\n'
        '    // Insert at beginning\n'
        '    childParentData.nextSibling = _firstChild;\n'
        '    if (_firstChild != null) {\n'
        '      var firstData = _firstChild.parentData\n'
        '          as ContainerParentDataMixin<ChildType>;\n'
        '      firstData.previousSibling = child;\n'
        '    }\n'
        '    _firstChild = child;\n'
        '    _lastChild ??= child;\n'
        '  } else {\n'
        '    // Insert after specified child\n'
        '    var afterData = after.parentData\n'
        '        as ContainerParentDataMixin<ChildType>;\n'
        '    childParentData.previousSibling = after;\n'
        '    childParentData.nextSibling = afterData.nextSibling;\n'
        '    \n'
        '    if (afterData.nextSibling != null) {\n'
        '      var nextData = afterData.nextSibling.parentData\n'
        '          as ContainerParentDataMixin<ChildType>;\n'
        '      nextData.previousSibling = child;\n'
        '    }\n'
        '    afterData.nextSibling = child;\n'
        '    \n'
        '    if (after == _lastChild) {\n'
        '      _lastChild = child;\n'
        '    }\n'
        '  }\n'
        '  _childCount++;\n'
        '}',
      ),
    ],
  );
}

Widget _buildCustomContainerSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildCodeBlock(
        'Custom Container ParentData',
        'class MyContainerParentData extends BoxParentData\n'
        '    with ContainerParentDataMixin<RenderBox> {\n'
        '  int zIndex = 0;\n'
        '  bool isFloating = false;\n'
        '  double priority = 1.0;\n'
        '}',
      ),
      _buildCodeBlock(
        'Custom Container RenderObject',
        'class RenderMyContainer extends RenderBox\n'
        '    with ContainerRenderObjectMixin<RenderBox, MyContainerParentData>,\n'
        '         RenderBoxContainerDefaultsMixin<RenderBox, MyContainerParentData> {\n'
        '  \n'
        '  @override\n'
        '  void setupParentData(RenderObject child) {\n'
        '    if (child.parentData is! MyContainerParentData) {\n'
        '      child.parentData = MyContainerParentData();\n'
        '    }\n'
        '  }\n'
        '  \n'
        '  @override\n'
        '  void performLayout() {\n'
        '    var child = firstChild;\n'
        '    while (child != null) {\n'
        '      child.layout(constraints, parentUsesSize: true);\n'
        '      var parentData = child.parentData as MyContainerParentData;\n'
        '      child = parentData.nextSibling;\n'
        '    }\n'
        '    size = constraints.biggest;\n'
        '  }\n'
        '  \n'
        '  @override\n'
        '  void paint(PaintingContext context, Offset offset) {\n'
        '    var child = firstChild;\n'
        '    while (child != null) {\n'
        '      var parentData = child.parentData as MyContainerParentData;\n'
        '      context.paintChild(child, offset + parentData.offset);\n'
        '      child = parentData.nextSibling;\n'
        '    }\n'
        '  }\n'
        '}',
      ),
      _buildCodeBlock(
        'Widget Using Custom Container',
        'class MyContainerWidget extends MultiChildRenderObjectWidget {\n'
        '  MyContainerWidget({super.key, required super.children});\n'
        '  \n'
        '  @override\n'
        '  RenderObject createRenderObject(BuildContext context) {\n'
        '    return RenderMyContainer();\n'
        '  }\n'
        '}',
      ),
    ],
  );
}

Widget _buildDetachReattachSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildConceptCard(
        'Detach Process',
        'When a child is removed from its parent, the detach method is called. '
        'This clears both sibling references to prevent dangling pointers.',
        Icons.link_off,
        Colors.red,
      ),
      _buildConceptCard(
        'Link Preservation',
        'Before detach, the containers remove operation must update adjacent '
        'siblings to maintain list integrity.',
        Icons.save,
        Colors.blue,
      ),
      _buildConceptCard(
        'Reattachment',
        'When a child is added to a new parent, new sibling links are established '
        'based on the insertion position.',
        Icons.link,
        Colors.green,
      ),
      _buildCodeBlock(
        'Detach Implementation',
        'mixin ContainerParentDataMixin<ChildType extends RenderObject>\n'
        '    on ParentData {\n'
        '  ChildType? previousSibling;\n'
        '  ChildType? nextSibling;\n'
        '  \n'
        '  @override\n'
        '  void detach() {\n'
        '    super.detach();\n'
        '    // Clear sibling references on detach\n'
        '    // to prevent dangling pointers\n'
        '    if (previousSibling != null) {\n'
        '      // Note: Actual framework handles this\n'
        '      // in the remove() operation before detach\n'
        '    }\n'
        '    previousSibling = null;\n'
        '    nextSibling = null;\n'
        '  }\n'
        '}',
      ),
      _buildCodeBlock(
        'Remove Operation Logic',
        'void remove(ChildType child) {\n'
        '  var childParentData = child.parentData\n'
        '      as ContainerParentDataMixin<ChildType>;\n'
        '  \n'
        '  // Update previous sibling link\n'
        '  if (childParentData.previousSibling != null) {\n'
        '    var prevData = childParentData.previousSibling.parentData\n'
        '        as ContainerParentDataMixin<ChildType>;\n'
        '    prevData.nextSibling = childParentData.nextSibling;\n'
        '  } else {\n'
        '    _firstChild = childParentData.nextSibling;\n'
        '  }\n'
        '  \n'
        '  // Update next sibling link\n'
        '  if (childParentData.nextSibling != null) {\n'
        '    var nextData = childParentData.nextSibling.parentData\n'
        '        as ContainerParentDataMixin<ChildType>;\n'
        '    nextData.previousSibling = childParentData.previousSibling;\n'
        '  } else {\n'
        '    _lastChild = childParentData.previousSibling;\n'
        '  }\n'
        '  \n'
        '  _childCount--;\n'
        '  dropChild(child);\n'
        '  // dropChild calls child.parentData?.detach()\n'
        '}',
      ),
      SizedBox(height: 16),
      _buildSummaryCard(),
    ],
  );
}

Widget _buildSummaryCard() {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.indigo.shade100, Colors.indigo.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.indigo.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.summarize, color: Colors.indigo.shade700),
            SizedBox(width: 8),
            Text(
              'ContainerParentDataMixin Summary',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.indigo.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        _buildSummaryItem('Provides previousSibling and nextSibling pointers'),
        _buildSummaryItem('Enables doubly-linked list traversal of children'),
        _buildSummaryItem('Type-safe with ChildType type parameter'),
        _buildSummaryItem('Used with ContainerRenderObjectMixin'),
        _buildSummaryItem('Siblings cleared on detach to prevent dangling refs'),
        _buildSummaryItem('O(1) sibling access for efficient iteration'),
      ],
    ),
  );
}

Widget _buildSummaryItem(String text) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.check_circle, color: Colors.green.shade600, size: 18),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 13, color: Colors.indigo.shade800),
          ),
        ),
      ],
    ),
  );
}

void main() {
  print('=== ContainerParentDataMixin Deep Demo ===');
  print('');
  print('ContainerParentDataMixin provides sibling pointers for ParentData.');
  print('This enables efficient doubly-linked list traversal of children.');
  print('');
  
  _demonstrateMixinConcept();
  _demonstrateSiblingPointers();
  _demonstrateLinkedListStructure();
  _demonstrateTraversalPatterns();
  _demonstrateContainerIntegration();
  
  print('');
  print('=== Demo Complete ===');
}

void _demonstrateMixinConcept() {
  print('--- Mixin Concept ---');
  print('ContainerParentDataMixin is defined as:');
  print('  mixin ContainerParentDataMixin<ChildType extends RenderObject>');
  print('      on ParentData { ... }');
  print('');
  print('The "on ParentData" clause means it can only be mixed into');
  print('classes that extend ParentData.');
  print('');
  print('The type parameter ChildType ensures type safety when');
  print('navigating between siblings.');
  print('');
}

void _demonstrateSiblingPointers() {
  print('--- Sibling Pointers ---');
  print('The mixin provides two key properties:');
  print('');
  print('  ChildType? previousSibling');
  print('    - Points to the previous child in the container');
  print('    - null for the first child');
  print('');
  print('  ChildType? nextSibling');
  print('    - Points to the next child in the container');
  print('    - null for the last child');
  print('');
}

void _demonstrateLinkedListStructure() {
  print('--- Linked List Structure ---');
  print('Children form a doubly-linked list:');
  print('');
  print('  Container');
  print('    firstChild ──► Child A');
  print('    lastChild ───► Child C');
  print('');
  print('  Child A');
  print('    previousSibling: null');
  print('    nextSibling: ──────► Child B');
  print('');
  print('  Child B');
  print('    previousSibling: ◄── Child A');
  print('    nextSibling: ──────► Child C');
  print('');
  print('  Child C');
  print('    previousSibling: ◄── Child B');
  print('    nextSibling: null');
  print('');
}

void _demonstrateTraversalPatterns() {
  print('--- Traversal Patterns ---');
  print('');
  print('Forward traversal (for layout, painting):');
  print('  var child = firstChild;');
  print('  while (child != null) {');
  print('    // process child');
  print('    child = child.parentData.nextSibling;');
  print('  }');
  print('');
  print('Backward traversal (for hit testing):');
  print('  var child = lastChild;');
  print('  while (child != null) {');
  print('    // process child');
  print('    child = child.parentData.previousSibling;');
  print('  }');
  print('');
}

void _demonstrateContainerIntegration() {
  print('--- Container Integration ---');
  print('');
  print('ContainerRenderObjectMixin manages the linked list:');
  print('');
  print('  insert(child, {after}):');
  print('    - Adds child to the list');
  print('    - Updates sibling pointers');
  print('    - Updates firstChild/lastChild');
  print('');
  print('  remove(child):');
  print('    - Removes child from list');
  print('    - Reconnects adjacent siblings');
  print('    - Clears child sibling pointers');
  print('');
  print('  move(child, {after}):');
  print('    - Repositions child in list');
  print('    - Updates all affected links');
  print('');
}
