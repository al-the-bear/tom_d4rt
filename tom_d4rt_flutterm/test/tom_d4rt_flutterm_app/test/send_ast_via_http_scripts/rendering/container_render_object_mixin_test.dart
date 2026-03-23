// ignore_for_file: avoid_print
// D4rt test script: Deep demo for ContainerRenderObjectMixin from rendering
//
// ContainerRenderObjectMixin is a mixin for render objects that manage multiple children.
// It provides a doubly-linked list structure for efficient child management.
//
// Key aspects covered:
//   1. ContainerRenderObjectMixin concept - what it is and why it exists
//   2. firstChild/lastChild - accessing the endpoints of the child list
//   3. childCount - getting the number of children
//   4. insert/remove/move/add - manipulating the child list
//   5. visitChildren - iterating over all children
//
// ═══════════════════════════════════════════════════════════════════════════
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// ═══════════════════════════════════════════════════════════════════════════
// COLOR PALETTE
// ═══════════════════════════════════════════════════════════════════════════

Color _kDeepPurple50 = Color(0xFFEDE7F6);
Color _kDeepPurple100 = Color(0xFFD1C4E9);
Color _kDeepPurple200 = Color(0xFFB39DDB);
Color _kDeepPurple300 = Color(0xFF9575CD);
Color _kDeepPurple400 = Color(0xFF7E57C2);
Color _kDeepPurple500 = Color(0xFF673AB7);
Color _kDeepPurple600 = Color(0xFF5E35B1);
Color _kDeepPurple700 = Color(0xFF512DA8);
Color _kDeepPurple800 = Color(0xFF4527A0);
Color _kDeepPurple900 = Color(0xFF311B92);

Color _kAmber100 = Color(0xFFFFECB3);
Color _kAmber200 = Color(0xFFFFE082);
Color _kAmber400 = Color(0xFFFFCA28);

// ═══════════════════════════════════════════════════════════════════════════
// CUSTOM PARENT DATA FOR DEMO
// ═══════════════════════════════════════════════════════════════════════════

class DemoChildParentData extends ContainerBoxParentData<RenderBox> {
  int childIndex = 0;
  String childLabel = '';
  bool isHighlighted = false;
  Color childColor = Color(0xFF673AB7);
}

// ═══════════════════════════════════════════════════════════════════════════
// DEMO RENDER OBJECT USING ContainerRenderObjectMixin
// ═══════════════════════════════════════════════════════════════════════════

class DemoContainerRenderBox extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, DemoChildParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, DemoChildParentData> {
  //
  // This class demonstrates ContainerRenderObjectMixin by implementing
  // a simple vertical stack layout for demo purposes.
  //

  double _spacing = 8.0;

  double get spacing => _spacing;

  set spacing(double value) {
    if (_spacing != value) {
      _spacing = value;
      markNeedsLayout();
    }
  }

  @override
  void setupParentData(RenderObject child) {
    if (child.parentData is! DemoChildParentData) {
      child.parentData = DemoChildParentData();
    }
  }

  @override
  void performLayout() {
    double yOffset = 0;
    double maxWidth = 0;

    RenderBox? currentChild = firstChild;
    int index = 0;

    while (currentChild != null) {
      DemoChildParentData childParentData =
          currentChild.parentData as DemoChildParentData;

      currentChild.layout(
        BoxConstraints(maxWidth: constraints.maxWidth),
        parentUsesSize: true,
      );

      childParentData.offset = Offset(0, yOffset);
      childParentData.childIndex = index;

      yOffset += currentChild.size.height + _spacing;
      if (currentChild.size.width > maxWidth) {
        maxWidth = currentChild.size.width;
      }

      currentChild = childParentData.nextSibling;
      index++;
    }

    size = Size(
      constraints.constrainWidth(maxWidth),
      constraints.constrainHeight(yOffset > 0 ? yOffset - _spacing : 0),
    );
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    defaultPaint(context, offset);
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    return defaultHitTestChildren(result, position: position);
  }

  // Demonstration method: collect all child indices
  List<int> collectChildIndices() {
    List<int> indices = [];
    visitChildren((RenderObject child) {
      if (child is RenderBox) {
        DemoChildParentData pd = child.parentData as DemoChildParentData;
        indices.add(pd.childIndex);
      }
    });
    return indices;
  }

  // Demonstration method: get child at specific index using iteration
  RenderBox? getChildAtIndex(int targetIndex) {
    RenderBox? current = firstChild;
    int idx = 0;
    while (current != null) {
      if (idx == targetIndex) {
        return current;
      }
      DemoChildParentData pd = current.parentData as DemoChildParentData;
      current = pd.nextSibling;
      idx++;
    }
    return null;
  }

  // Demonstration method: iterate from last to first
  List<int> collectReverseIndices() {
    List<int> indices = [];
    RenderBox? current = lastChild;
    while (current != null) {
      DemoChildParentData pd = current.parentData as DemoChildParentData;
      indices.add(pd.childIndex);
      current = pd.previousSibling;
    }
    return indices;
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// DEMO WIDGET WRAPPING THE RENDER OBJECT
// ═══════════════════════════════════════════════════════════════════════════

class DemoContainerWidget extends MultiChildRenderObjectWidget {
  DemoContainerWidget({
    Key? key,
    List<Widget> children = const [],
    this.spacing = 8.0,
  }) : super(key: key, children: children);

  final double spacing;

  @override
  RenderObject createRenderObject(BuildContext context) {
    DemoContainerRenderBox renderObject = DemoContainerRenderBox();
    renderObject.spacing = spacing;
    return renderObject;
  }

  @override
  void updateRenderObject(
    BuildContext context,
    DemoContainerRenderBox renderObject,
  ) {
    renderObject.spacing = spacing;
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// HELPER WIDGET BUILDERS
// ═══════════════════════════════════════════════════════════════════════════

Widget _buildSectionHeader(String title, IconData icon) {
  return Padding(
    padding: EdgeInsets.only(bottom: 12, top: 8),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _kDeepPurple500,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: _kDeepPurple900,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildConceptCard(String heading, String body, IconData cardIcon) {
  return Container(
    margin: EdgeInsets.only(bottom: 12),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _kDeepPurple50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kDeepPurple200, width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(cardIcon, color: _kDeepPurple700, size: 22),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                heading,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: _kDeepPurple800,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Text(
          body,
          style: TextStyle(fontSize: 12, color: _kDeepPurple700, height: 1.5),
        ),
      ],
    ),
  );
}

Widget _buildCodeDisplay(String title, String code) {
  return Container(
    margin: EdgeInsets.only(bottom: 14),
    decoration: BoxDecoration(
      color: _kDeepPurple900,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: _kDeepPurple800,
            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
          ),
          child: Row(
            children: [
              Icon(Icons.code, color: _kDeepPurple200, size: 16),
              SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color: _kDeepPurple100,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(14),
          child: Text(
            code,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              color: _kDeepPurple50,
              height: 1.6,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildPropertyRow(String propName, String propType, String desc) {
  return Container(
    margin: EdgeInsets.only(bottom: 8),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _kDeepPurple100),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: _kAmber100,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            propType,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: _kDeepPurple800,
              fontFamily: 'monospace',
            ),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                propName,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: _kDeepPurple900,
                  fontFamily: 'monospace',
                ),
              ),
              SizedBox(height: 4),
              Text(
                desc,
                style: TextStyle(fontSize: 11, color: _kDeepPurple600),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildMethodCard(
  String methodName,
  String signature,
  String description,
  List<String> parameters,
) {
  return Container(
    margin: EdgeInsets.only(bottom: 12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _kDeepPurple300),
      boxShadow: [
        BoxShadow(
          color: _kDeepPurple100.withAlpha(128),
          blurRadius: 4,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _kDeepPurple100,
            borderRadius: BorderRadius.vertical(top: Radius.circular(9)),
          ),
          child: Row(
            children: [
              Icon(Icons.functions, color: _kDeepPurple700, size: 18),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  methodName,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: _kDeepPurple900,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _kDeepPurple50,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  signature,
                  style: TextStyle(
                    fontSize: 10,
                    fontFamily: 'monospace',
                    color: _kDeepPurple800,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                description,
                style: TextStyle(fontSize: 11, color: _kDeepPurple700),
              ),
              if (parameters.isNotEmpty) ...[
                SizedBox(height: 10),
                Text(
                  'Parameters:',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: _kDeepPurple800,
                  ),
                ),
                SizedBox(height: 6),
                ...parameters.map(
                  (p) => Padding(
                    padding: EdgeInsets.only(left: 8, bottom: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('• ', style: TextStyle(color: _kDeepPurple500)),
                        Expanded(
                          child: Text(
                            p,
                            style: TextStyle(
                              fontSize: 10,
                              color: _kDeepPurple600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildHighlightBox(String text, Color bgColor, Color textColor) {
  return Container(
    margin: EdgeInsets.only(bottom: 10),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        Icon(Icons.lightbulb_outline, color: textColor, size: 20),
        SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 12, color: textColor, height: 1.4),
          ),
        ),
      ],
    ),
  );
}

Widget _buildDiagramBox(String title, List<String> items) {
  return Container(
    margin: EdgeInsets.only(bottom: 12),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _kDeepPurple200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: _kDeepPurple800,
          ),
        ),
        SizedBox(height: 10),
        ...items.asMap().entries.map((entry) {
          int idx = entry.key;
          String item = entry.value;
          bool isLast = idx == items.length - 1;
          return Padding(
            padding: EdgeInsets.only(bottom: isLast ? 0 : 6),
            child: Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: _kDeepPurple400,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${idx + 1}',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                    decoration: BoxDecoration(
                      color: _kDeepPurple50,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      item,
                      style: TextStyle(fontSize: 11, color: _kDeepPurple700),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════
// SECTION 1: ContainerRenderObjectMixin Concept
// ═══════════════════════════════════════════════════════════════════════════

Widget _buildConceptSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionHeader('ContainerRenderObjectMixin Concept', Icons.widgets),
      _buildConceptCard(
        'What is ContainerRenderObjectMixin?',
        'ContainerRenderObjectMixin is a mixin that provides the infrastructure '
            'for render objects that need to manage multiple children. It implements '
            'a doubly-linked list structure for efficient child traversal and '
            'modification. This mixin is fundamental for any render object that '
            'acts as a container for other render objects.',
        Icons.info_outline,
      ),
      _buildConceptCard(
        'Why Use a Doubly-Linked List?',
        'A doubly-linked list allows O(1) insertion and removal at any position '
            '(given a reference to the node). Each child has pointers to both its '
            'previous and next siblings, enabling bidirectional traversal. This '
            'structure is optimal for UI layouts where children are frequently '
            'reordered, inserted, or removed.',
        Icons.link,
      ),
      _buildCodeDisplay(
        'Basic Mixin Declaration',
        '''mixin ContainerRenderObjectMixin<
    ChildType extends RenderObject,
    ParentDataType extends ContainerParentDataMixin<ChildType>>
    on RenderObject {
  
  // The mixin requires two type parameters:
  // ChildType - the type of child render objects
  // ParentDataType - parent data type with sibling links
  
  ChildType? _firstChild;
  ChildType? _lastChild;
  int _childCount = 0;
}''',
      ),
      _buildHighlightBox(
        'ContainerRenderObjectMixin requires ContainerParentDataMixin on the '
            'parent data to store the previous/next sibling references.',
        _kAmber100,
        _kDeepPurple800,
      ),
      _buildConceptCard(
        'Integration with ParentData',
        'Every child render object has a parentData property. For containers, '
            'this parent data must include ContainerParentDataMixin which provides '
            'the previousSibling and nextSibling pointers. The container mixin '
            'manages these pointers automatically when children are added or removed.',
        Icons.data_object,
      ),
      _buildDiagramBox(
        'Child List Structure',
        [
          'firstChild points to head of list',
          'Each child has nextSibling pointer',
          'Each child has previousSibling pointer',
          'lastChild points to tail of list',
        ],
      ),
    ],
  );
}

// ═══════════════════════════════════════════════════════════════════════════
// SECTION 2: firstChild and lastChild Properties
// ═══════════════════════════════════════════════════════════════════════════

Widget _buildFirstLastChildSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionHeader('firstChild / lastChild Properties', Icons.first_page),
      _buildConceptCard(
        'Accessing List Endpoints',
        'The firstChild and lastChild properties provide direct access to the '
            'head and tail of the child list. These are essential for starting '
            'iteration in either direction. Both return null when the container '
            'has no children.',
        Icons.arrow_right_alt,
      ),
      _buildPropertyRow(
        'firstChild',
        'ChildType?',
        'The first child in the linked list, or null if empty. Use this to '
            'start forward iteration through children.',
      ),
      _buildPropertyRow(
        'lastChild',
        'ChildType?',
        'The last child in the linked list, or null if empty. Use this to '
            'start reverse iteration or to append children efficiently.',
      ),
      _buildCodeDisplay(
        'Using firstChild for Forward Iteration',
        '''void iterateForward() {
  RenderBox? current = firstChild;
  while (current != null) {
    // Process the current child
    print('Processing child: \$current');
    
    // Move to next sibling via parentData
    final pd = current.parentData
        as ContainerBoxParentData<RenderBox>;
    current = pd.nextSibling;
  }
}''',
      ),
      _buildCodeDisplay(
        'Using lastChild for Reverse Iteration',
        '''void iterateReverse() {
  RenderBox? current = lastChild;
  while (current != null) {
    // Process the current child
    print('Processing child in reverse: \$current');
    
    // Move to previous sibling via parentData
    final pd = current.parentData
        as ContainerBoxParentData<RenderBox>;
    current = pd.previousSibling;
  }
}''',
      ),
      _buildHighlightBox(
        'Always check for null when accessing firstChild or lastChild, as the '
            'container might be empty.',
        _kDeepPurple100,
        _kDeepPurple800,
      ),
      _buildConceptCard(
        'Performance Characteristics',
        'Accessing firstChild and lastChild is O(1) - constant time. The mixin '
            'maintains direct references to both endpoints. This makes operations '
            'like prepending, appending, or checking emptiness very efficient.',
        Icons.speed,
      ),
    ],
  );
}

// ═══════════════════════════════════════════════════════════════════════════
// SECTION 3: childCount Property
// ═══════════════════════════════════════════════════════════════════════════

Widget _buildChildCountSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionHeader('childCount Property', Icons.format_list_numbered),
      _buildConceptCard(
        'Tracking the Number of Children',
        'The childCount property returns the current number of children in the '
            'container. This count is maintained internally and updated automatically '
            'when children are added or removed. It provides O(1) access to the count.',
        Icons.numbers,
      ),
      _buildPropertyRow(
        'childCount',
        'int',
        'The total number of children currently in the container. Always >= 0. '
            'Updated automatically by insert/remove operations.',
      ),
      _buildCodeDisplay(
        'Using childCount in Layout',
        '''@override
void performLayout() {
  if (childCount == 0) {
    size = constraints.smallest;
    return;
  }
  
  // Calculate space per child
  double availableWidth = constraints.maxWidth;
  double childWidth = availableWidth / childCount;
  
  RenderBox? child = firstChild;
  double xOffset = 0;
  
  while (child != null) {
    child.layout(
      BoxConstraints.tightFor(width: childWidth),
      parentUsesSize: true,
    );
    
    final pd = child.parentData
        as ContainerBoxParentData<RenderBox>;
    pd.offset = Offset(xOffset, 0);
    xOffset += childWidth;
    
    child = pd.nextSibling;
  }
  
  size = Size(availableWidth, maxChildHeight);
}''',
      ),
      _buildHighlightBox(
        'childCount is always synchronized with the actual number of children. '
            'You never need to manually count children.',
        _kAmber100,
        _kDeepPurple800,
      ),
      _buildConceptCard(
        'Common Use Cases for childCount',
        'Use childCount to: determine if container is empty (childCount == 0), '
            'calculate per-child dimensions in layouts, decide on layout strategy '
            'based on child quantity, optimize painting when count is known, and '
            'validate state during debugging.',
        Icons.checklist,
      ),
      _buildCodeDisplay(
        'Conditional Layout Based on childCount',
        '''@override
void performLayout() {
  switch (childCount) {
    case 0:
      size = Size.zero;
      break;
    case 1:
      layoutSingleChild();
      break;
    case 2:
      layoutTwoChildren();
      break;
    default:
      layoutManyChildren();
  }
}''',
      ),
    ],
  );
}

// ═══════════════════════════════════════════════════════════════════════════
// SECTION 4: insert, remove, move, add Methods
// ═══════════════════════════════════════════════════════════════════════════

Widget _buildChildManipulationSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionHeader('insert / remove / move / add', Icons.edit),
      _buildConceptCard(
        'Child List Manipulation',
        'ContainerRenderObjectMixin provides several methods for manipulating '
            'the child list: insert adds a child after a specific sibling, remove '
            'detaches a child from the list, move repositions a child, and add '
            'appends a child to the end of the list.',
        Icons.swap_vert,
      ),
      _buildMethodCard(
        'insert',
        'void insert(ChildType child, {ChildType? after})',
        'Inserts a child into the child list after the specified sibling. If '
            'after is null, the child is inserted at the beginning of the list.',
        [
          'child: The render object to insert',
          'after: Optional sibling after which to insert (null = insert at start)',
        ],
      ),
      _buildMethodCard(
        'add',
        'void add(ChildType child)',
        'Appends a child to the end of the child list. This is equivalent to '
            'calling insert(child, after: lastChild).',
        ['child: The render object to append'],
      ),
      _buildMethodCard(
        'remove',
        'void remove(ChildType child)',
        'Removes a child from the child list. The child must be a direct child '
            'of this container. The child\'s parentData sibling links are cleared.',
        ['child: The render object to remove'],
      ),
      _buildMethodCard(
        'move',
        'void move(ChildType child, {ChildType? after})',
        'Moves a child to a new position in the child list. The child must '
            'already be a direct child. Efficient alternative to remove+insert.',
        [
          'child: The render object to move',
          'after: The sibling after which to place the child (null = move to start)',
        ],
      ),
      _buildCodeDisplay(
        'Inserting Children',
        '''// Add child at the end
void addChild(RenderBox child) {
  adoptChild(child);
  add(child); // Appends to end of list
  markNeedsLayout();
}

// Insert child at specific position
void insertChildAfter(RenderBox child, RenderBox? after) {
  adoptChild(child);
  insert(child, after: after);
  markNeedsLayout();
}

// Insert at beginning
void prependChild(RenderBox child) {
  adoptChild(child);
  insert(child, after: null); // null = insert at start
  markNeedsLayout();
}''',
      ),
      _buildCodeDisplay(
        'Removing Children',
        '''// Remove a specific child
void removeChild(RenderBox child) {
  remove(child);
  dropChild(child);
  markNeedsLayout();
}

// Remove all children
void removeAllChildren() {
  RenderBox? child = firstChild;
  while (child != null) {
    final next = (child.parentData
        as ContainerBoxParentData<RenderBox>).nextSibling;
    remove(child);
    dropChild(child);
    child = next;
  }
  markNeedsLayout();
}''',
      ),
      _buildCodeDisplay(
        'Moving Children',
        '''// Move child to end of list
void moveToEnd(RenderBox child) {
  move(child, after: lastChild);
  markNeedsLayout();
}

// Move child to beginning
void moveToBeginning(RenderBox child) {
  move(child, after: null);
  markNeedsLayout();
}

// Swap two children positions
void swapChildren(RenderBox a, RenderBox b) {
  final pdA = a.parentData as ContainerBoxParentData<RenderBox>;
  final beforeA = pdA.previousSibling;
  
  move(a, after: b);
  move(b, after: beforeA);
  markNeedsLayout();
}''',
      ),
      _buildHighlightBox(
        'Remember to call adoptChild before insert/add and dropChild after '
            'remove. These manage the render tree relationships.',
        _kAmber200,
        _kDeepPurple900,
      ),
      _buildConceptCard(
        'Order of Operations',
        'When adding: first call adoptChild(), then insert/add. When removing: '
            'first call remove(), then dropChild(). This order ensures the render '
            'tree maintains correct parent-child relationships at all times.',
        Icons.format_list_numbered,
      ),
    ],
  );
}

// ═══════════════════════════════════════════════════════════════════════════
// SECTION 5: visitChildren Method
// ═══════════════════════════════════════════════════════════════════════════

Widget _buildVisitChildrenSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionHeader('visitChildren Method', Icons.account_tree),
      _buildConceptCard(
        'Iterating Over All Children',
        'The visitChildren method calls a visitor function for each child in '
            'the container. This is the standard way to iterate children in Flutter\'s '
            'render object tree. It is used internally by the framework for layout, '
            'painting, hit testing, and tree operations.',
        Icons.repeat,
      ),
      _buildMethodCard(
        'visitChildren',
        'void visitChildren(RenderObjectVisitor visitor)',
        'Calls the visitor function once for each child render object. Children '
            'are visited in order from firstChild to lastChild. Override this method '
            'in custom render objects to include all children.',
        ['visitor: A function that takes a RenderObject and returns void'],
      ),
      _buildCodeDisplay(
        'Standard visitChildren Implementation',
        '''@override
void visitChildren(RenderObjectVisitor visitor) {
  RenderBox? child = firstChild;
  while (child != null) {
    visitor(child);
    final pd = child.parentData
        as ContainerBoxParentData<RenderBox>;
    child = pd.nextSibling;
  }
}''',
      ),
      _buildCodeDisplay(
        'Using visitChildren for Various Tasks',
        '''// Collect all children into a list
List<RenderBox> getChildrenAsList() {
  List<RenderBox> children = [];
  visitChildren((RenderObject child) {
    children.add(child as RenderBox);
  });
  return children;
}

// Find a child matching a condition
RenderBox? findChild(bool Function(RenderBox) test) {
  RenderBox? found;
  visitChildren((RenderObject child) {
    if (found == null && test(child as RenderBox)) {
      found = child;
    }
  });
  return found;
}

// Calculate aggregate properties
double getTotalHeight() {
  double total = 0;
  visitChildren((RenderObject child) {
    total += (child as RenderBox).size.height;
  });
  return total;
}''',
      ),
      _buildHighlightBox(
        'The default implementation in ContainerRenderObjectMixin handles '
            'iteration automatically. You rarely need to override visitChildren.',
        _kDeepPurple100,
        _kDeepPurple800,
      ),
      _buildConceptCard(
        'Framework Usage of visitChildren',
        'The framework calls visitChildren internally for: depth-first tree '
            'traversal, marking children as needing layout/paint, detaching children '
            'when the subtree is removed, and debugging/diagnostic operations.',
        Icons.developer_mode,
      ),
      _buildCodeDisplay(
        'Custom visitChildren for Special Cases',
        '''// If you have multiple child slots:
class RenderTwoSlots extends RenderBox {
  RenderBox? _headerChild;
  RenderBox? _bodyChild;
  
  @override
  void visitChildren(RenderObjectVisitor visitor) {
    if (_headerChild != null) {
      visitor(_headerChild!);
    }
    if (_bodyChild != null) {
      visitor(_bodyChild!);
    }
  }
}''',
      ),
      _buildDiagramBox(
        'visitChildren Flow',
        [
          'Start at firstChild',
          'Call visitor function with current child',
          'Get nextSibling from parentData',
          'Repeat until nextSibling is null',
        ],
      ),
    ],
  );
}

// ═══════════════════════════════════════════════════════════════════════════
// MAIN BUILD FUNCTION
// ═══════════════════════════════════════════════════════════════════════════

dynamic build(BuildContext context) {
  print('ContainerRenderObjectMixin Demo Starting...');

  // Demonstrate the mixin concepts
  print('ContainerRenderObjectMixin manages children in render objects');
  print('It uses a doubly-linked list for efficient traversal');
  print('Key properties: firstChild, lastChild, childCount');
  print('Key methods: insert, remove, move, add, visitChildren');

  return Scaffold(
    backgroundColor: _kDeepPurple50,
    appBar: AppBar(
      title: Text(
        'ContainerRenderObjectMixin Demo',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      backgroundColor: _kDeepPurple700,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [_kDeepPurple600, _kDeepPurple800],
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
                    Icon(Icons.widgets_outlined, color: Colors.white, size: 28),
                    SizedBox(width: 12),
                    Text(
                      'ContainerRenderObjectMixin',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Text(
                  'A mixin that provides child management infrastructure for '
                      'render objects with multiple children. Uses a doubly-linked '
                      'list for efficient O(1) insertion and removal.',
                  style: TextStyle(
                    fontSize: 13,
                    color: _kDeepPurple100,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),

          // Section 1: Concept
          _buildConceptSection(),
          SizedBox(height: 16),

          // Section 2: firstChild/lastChild
          _buildFirstLastChildSection(),
          SizedBox(height: 16),

          // Section 3: childCount
          _buildChildCountSection(),
          SizedBox(height: 16),

          // Section 4: insert/remove/move/add
          _buildChildManipulationSection(),
          SizedBox(height: 16),

          // Section 5: visitChildren
          _buildVisitChildrenSection(),
          SizedBox(height: 16),

          // Live Demo Section
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _kDeepPurple300),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.play_circle_fill, color: _kDeepPurple600, size: 24),
                    SizedBox(width: 10),
                    Text(
                      'Live Demo',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: _kDeepPurple800,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Text(
                  'The DemoContainerWidget below uses ContainerRenderObjectMixin '
                      'to manage its children:',
                  style: TextStyle(fontSize: 12, color: _kDeepPurple700),
                ),
                SizedBox(height: 12),
                DemoContainerWidget(
                  spacing: 8.0,
                  children: [
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: _kDeepPurple500,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Child 1: firstChild',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: _kDeepPurple400,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Child 2: middle child',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: _kDeepPurple300,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Child 3: lastChild',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 16),

          // Summary
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _kAmber100,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _kAmber400),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.summarize, color: _kDeepPurple800, size: 22),
                    SizedBox(width: 10),
                    Text(
                      'Key Takeaways',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: _kDeepPurple900,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                _buildSummaryItem(
                  'ContainerRenderObjectMixin provides a doubly-linked list '
                      'structure for managing children',
                ),
                _buildSummaryItem(
                  'firstChild and lastChild give O(1) access to list endpoints',
                ),
                _buildSummaryItem(
                  'childCount is maintained automatically and provides O(1) access',
                ),
                _buildSummaryItem(
                  'insert/add/remove/move provide efficient O(1) child manipulation',
                ),
                _buildSummaryItem(
                  'visitChildren enables iteration through all children',
                ),
                _buildSummaryItem(
                  'Always use adoptChild/dropChild with insert/remove operations',
                ),
              ],
            ),
          ),
          SizedBox(height: 24),
        ],
      ),
    ),
  );
}

Widget _buildSummaryItem(String text) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.check_circle, color: _kDeepPurple600, size: 16),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 12, color: _kDeepPurple800, height: 1.4),
          ),
        ),
      ],
    ),
  );
}
