// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep demo for ParentData from rendering
//
// ParentData is the base class for render object parent data.
// It serves as the foundation for all layout-related data that
// a parent render object attaches to its children.
//
// Key characteristics:
//   - Base class for all parent data types
//   - Attached to child via setupParentData()
//   - Contains detach() method for cleanup
//   - Extended by BoxParentData, SliverParentData, etc.
//
// Subtypes:
//   - BoxParentData: adds offset for positioned children
//   - ContainerBoxParentData: adds sibling navigation
//   - StackParentData: positioning constraints for Stack
//   - FlexParentData: flex factor and fit for Flex layouts
//
// This demo covers:
//   1. ParentData overview and concept
//   2. detach() method and lifecycle
//   3. Rendering layer hierarchy
//   4. Stack/Positioned usage examples
//   5. Flex layout demonstrations
//   6. Custom parent data concepts
//
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// COLOR PALETTE (only used colors)
// ═══════════════════════════════════════════════════════════════════════════════

Color _indigo800 = Color(0xFF283593);
Color _indigo700 = Color(0xFF303F9F);
Color _indigo600 = Color(0xFF3949AB);
Color _indigo500 = Color(0xFF3F51B5);
Color _indigo400 = Color(0xFF5C6BC0);
Color _indigo100 = Color(0xFFC5CAE9);
Color _indigo50 = Color(0xFFE8EAF6);

Color _teal700 = Color(0xFF00796B);
Color _teal600 = Color(0xFF00897B);
Color _teal500 = Color(0xFF009688);
Color _teal400 = Color(0xFF26A69A);

Color _amber700 = Color(0xFFFFA000);
Color _amber600 = Color(0xFFFFB300);
Color _amber500 = Color(0xFFFFC107);

Color _red700 = Color(0xFFD32F2F);
Color _red600 = Color(0xFFE53935);
Color _red500 = Color(0xFFF44336);
Color _red400 = Color(0xFFEF5350);

Color _green700 = Color(0xFF388E3C);
Color _green600 = Color(0xFF43A047);
Color _green500 = Color(0xFF4CAF50);

Color _grey900 = Color(0xFF212121);
Color _grey800 = Color(0xFF424242);
Color _grey700 = Color(0xFF616161);
Color _grey600 = Color(0xFF757575);
Color _grey400 = Color(0xFFBDBDBD);
Color _grey300 = Color(0xFFE0E0E0);
Color _grey200 = Color(0xFFEEEEEE);
Color _grey100 = Color(0xFFF5F5F5);
Color _grey50 = Color(0xFFFAFAFA);

Color _white = Color(0xFFFFFFFF);
Color _black = Color(0xFF000000);

// ═══════════════════════════════════════════════════════════════════════════════
// HELPER WIDGETS
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildMainHeader(String title, String subtitle, IconData icon) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(24),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_indigo800, _indigo600],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: _indigo800.withAlpha(80),
          blurRadius: 16,
          offset: Offset(0, 8),
        ),
      ],
    ),
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _white.withAlpha(30),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 48, color: _white),
        ),
        SizedBox(height: 16),
        Text(
          title,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: _white,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 8),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 14,
            color: _white.withAlpha(220),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

Widget _buildSectionTitle(String title, IconData icon, Color color) {
  return Container(
    margin: EdgeInsets.only(top: 24, bottom: 16),
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [color, color.withAlpha(200)],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: color.withAlpha(50),
          blurRadius: 8,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Row(
      children: [
        Icon(icon, color: _white, size: 24),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: _white,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildInfoCard(String title, String content, IconData icon, Color accent) {
  return Container(
    margin: EdgeInsets.only(bottom: 12),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: accent.withAlpha(60), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: _black.withAlpha(10),
          blurRadius: 6,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: accent.withAlpha(25),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: accent, size: 22),
            ),
            SizedBox(width: 14),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: _grey900,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Text(
          content,
          style: TextStyle(
            fontSize: 13,
            color: _grey700,
            height: 1.5,
          ),
        ),
      ],
    ),
  );
}

Widget _buildCodeBlock(String title, String code, Color headerColor) {
  return Container(
    margin: EdgeInsets.only(bottom: 16),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: headerColor.withAlpha(40)),
      boxShadow: [
        BoxShadow(
          color: _black.withAlpha(8),
          blurRadius: 4,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: headerColor.withAlpha(20),
            borderRadius: BorderRadius.vertical(top: Radius.circular(11)),
          ),
          child: Row(
            children: [
              Icon(Icons.code, color: headerColor, size: 18),
              SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: headerColor,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Color(0xFF1E1E1E),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(11)),
          ),
          child: Text(
            code,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              color: Color(0xFFD4D4D4),
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildDiagramContainer(String title, Widget diagram) {
  return Container(
    margin: EdgeInsets.only(bottom: 16),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _grey50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _grey300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.schema, color: _indigo700, size: 20),
            SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: _indigo800,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        diagram,
      ],
    ),
  );
}

Widget _buildAsciiDiagram(String ascii) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _grey100,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _grey300),
    ),
    child: Text(
      ascii,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11,
        color: _grey800,
        height: 1.4,
      ),
    ),
  );
}

Widget _buildPropertyRow(String name, String type, String description) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
    decoration: BoxDecoration(
      border: Border(bottom: BorderSide(color: _grey200)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            name,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: _indigo700,
              fontFamily: 'monospace',
            ),
          ),
        ),
        SizedBox(
          width: 80,
          child: Text(
            type,
            style: TextStyle(
              fontSize: 11,
              color: _teal700,
              fontFamily: 'monospace',
            ),
          ),
        ),
        Expanded(
          child: Text(
            description,
            style: TextStyle(
              fontSize: 12,
              color: _grey700,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildHighlightBox(String text, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: color.withAlpha(20),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withAlpha(100)),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 12,
        color: color,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

Widget _buildNumberedStep(int number, String title, String description, Color color) {
  return Container(
    margin: EdgeInsets.only(bottom: 12),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '\$number',
              style: TextStyle(
                color: _white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: _grey900,
                ),
              ),
              SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(
                  fontSize: 12,
                  color: _grey600,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildTreeNode(String label, Color color, {List<Widget>? children, IconData? icon}) {
  return Container(
    margin: EdgeInsets.only(bottom: 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: color.withAlpha(30),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: color),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) Icon(icon, color: color, size: 16),
              if (icon != null) SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: color,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
        ),
        if (children != null)
          Container(
            margin: EdgeInsets.only(left: 20, top: 8),
            padding: EdgeInsets.only(left: 12),
            decoration: BoxDecoration(
              border: Border(left: BorderSide(color: color.withAlpha(100), width: 2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 1: PARENT DATA OVERVIEW
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildOverviewSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionTitle('ParentData Overview', Icons.data_object, _indigo700),
      _buildInfoCard(
        'What is ParentData?',
        'ParentData is the base class for data that a parent render object '
        'attaches to its children. It provides a standardized way for parents '
        'to store layout-related information about each child, such as position '
        'offsets, flex values, or positioning constraints.',
        Icons.info_outline,
        _indigo600,
      ),
      _buildInfoCard(
        'How ParentData Works',
        'When a child render object is adopted by a parent, the parent calls '
        'setupParentData() to initialize the child\'s parentData property. '
        'The parent then uses this data during layout and painting phases to '
        'determine how to position and render the child.',
        Icons.settings,
        _teal600,
      ),
      _buildCodeBlock(
        'ParentData Base Class',
        '''class ParentData {
  // Called when the child is removed from parent
  @protected
  @mustCallSuper
  void detach() { }
  
  // String representation for debugging
  @override
  String toString() => '<\\\$runtimeType>';
}''',
        _indigo700,
      ),
      _buildDiagramContainer(
        'ParentData Lifecycle',
        _buildAsciiDiagram('''
  ┌─────────────────────────────────────────────────┐
  │            Parent RenderObject                  │
  │                                                 │
  │  1. adoptChild(child) called                   │
  │     ↓                                          │
  │  2. setupParentData(child)                     │
  │     - Creates ParentData instance              │
  │     - Assigns to child.parentData             │
  │     ↓                                          │
  │  3. Layout phase                               │
  │     - Parent reads/writes to parentData       │
  │     - Stores offset, constraints, etc.        │
  │     ↓                                          │
  │  4. Paint phase                                │
  │     - Uses parentData.offset for position     │
  │     ↓                                          │
  │  5. dropChild(child) called                    │
  │     - child.parentData.detach() invoked       │
  │     - Cleanup resources                        │
  └─────────────────────────────────────────────────┘
'''),
      ),
      _buildInfoCard(
        'Key Responsibilities',
        '• Store layout information set by parent\n'
        '• Provide detach() for cleanup when removed\n'
        '• Enable communication between parent and child\n'
        '• Support specific layout protocols (box, sliver)',
        Icons.checklist,
        _green700,
      ),
    ],
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 2: DETACH METHOD
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildDetachSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionTitle('detach() Method', Icons.link_off, _red700),
      _buildInfoCard(
        'Purpose of detach()',
        'The detach() method is called when a child render object is being '
        'removed from its parent. It provides an opportunity to clean up any '
        'resources, remove listeners, or sever connections that were established '
        'when the parent data was set up.',
        Icons.cleaning_services,
        _red600,
      ),
      _buildCodeBlock(
        'detach() Implementation',
        '''// Base implementation
void detach() {
  // Override in subclasses to cleanup
}

// ContainerParentDataMixin implementation
mixin ContainerParentDataMixin<T extends RenderObject> 
    on ParentData {
  T? previousSibling;
  T? nextSibling;
  
  @override
  void detach() {
    // Clear sibling references
    // Allows garbage collection
    super.detach();
  }
}''',
        _red700,
      ),
      _buildDiagramContainer(
        'detach() Call Sequence',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildNumberedStep(
              1,
              'Parent initiates removal',
              'Parent calls dropChild(child) to remove the child from its child list',
              _red600,
            ),
            _buildNumberedStep(
              2,
              'Sibling links updated',
              'For container parent data, previousSibling and nextSibling are reconnected',
              _amber700,
            ),
            _buildNumberedStep(
              3,
              'detach() called',
              'child.parentData.detach() is invoked to clean up resources',
              _teal600,
            ),
            _buildNumberedStep(
              4,
              'References cleared',
              'ParentData references are cleared, allowing garbage collection',
              _green600,
            ),
          ],
        ),
      ),
      _buildAsciiDiagram('''
BEFORE REMOVAL:
┌────────────────────────────────────────────────┐
│              Parent Container                  │
│                                                │
│   Child A  ←──→  Child B  ←──→  Child C       │
│   prev:null      prev:A         prev:B        │
│   next:B         next:C         next:null     │
└────────────────────────────────────────────────┘

AFTER REMOVING Child B:
┌────────────────────────────────────────────────┐
│              Parent Container                  │
│                                                │
│        Child A  ←───────→  Child C            │
│        prev:null           prev:A             │
│        next:C              next:null          │
│                                                │
│   Child B (orphaned)                          │
│   - detach() called                           │
│   - prev/next cleared                         │
│   - Ready for GC                              │
└────────────────────────────────────────────────┘
'''),
      _buildInfoCard(
        'Best Practices',
        '• Always call super.detach() in overrides\n'
        '• Remove any listeners attached to parent\n'
        '• Clear cached references to parent objects\n'
        '• Do not access parent after detach() returns',
        Icons.verified,
        _green700,
      ),
    ],
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 3: RENDERING LAYER HIERARCHY
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildHierarchySection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionTitle('Rendering Layer Hierarchy', Icons.account_tree, _teal700),
      _buildInfoCard(
        'ParentData Type System',
        'Flutter\'s rendering layer defines a hierarchy of ParentData types, '
        'each adding specific functionality for different layout protocols. '
        'The base ParentData class is minimal, with subclasses adding offset, '
        'sibling navigation, flex values, and positioning constraints.',
        Icons.layers,
        _teal600,
      ),
      _buildDiagramContainer(
        'ParentData Inheritance Tree',
        _buildTreeNode(
          'ParentData',
          _indigo700,
          icon: Icons.data_object,
          children: [
            _buildTreeNode(
              'BoxParentData',
              _teal600,
              icon: Icons.crop_square,
              children: [
                _buildTreeNode(
                  'ContainerBoxParentData<RenderBox>',
                  _amber700,
                  icon: Icons.view_list,
                  children: [
                    _buildTreeNode('FlexParentData', _green600, icon: Icons.swap_horiz),
                    _buildTreeNode('StackParentData', _red600, icon: Icons.layers),
                    _buildTreeNode('FlowParentData', _indigo500, icon: Icons.air),
                    _buildTreeNode('WrapParentData', _teal500, icon: Icons.wrap_text),
                  ],
                ),
                _buildTreeNode(
                  'MultiChildLayoutParentData',
                  _amber600,
                  icon: Icons.dashboard,
                ),
              ],
            ),
            _buildTreeNode(
              'SliverLogicalParentData',
              _green700,
              icon: Icons.view_stream,
              children: [
                _buildTreeNode(
                  'SliverLogicalContainerParentData',
                  _green500,
                  icon: Icons.list,
                ),
              ],
            ),
            _buildTreeNode(
              'SliverPhysicalParentData',
              _red700,
              icon: Icons.straighten,
              children: [
                _buildTreeNode(
                  'SliverPhysicalContainerParentData',
                  _red500,
                  icon: Icons.grid_view,
                ),
              ],
            ),
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: _white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _grey300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _indigo50,
                borderRadius: BorderRadius.vertical(top: Radius.circular(11)),
              ),
              child: Text(
                'ParentData Properties by Type',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: _indigo800,
                ),
              ),
            ),
            _buildPropertyRow('ParentData', 'base', 'detach() method only'),
            _buildPropertyRow('BoxParentData', 'Offset', 'offset for painting position'),
            _buildPropertyRow('Container...', 'T?, T?', 'previousSibling, nextSibling'),
            _buildPropertyRow('FlexParentData', 'int, FlexFit', 'flex factor and fit mode'),
            _buildPropertyRow('StackParentData', 'double?*6', 'left, top, right, bottom, width, height'),
            _buildPropertyRow('SliverLogical...', 'double', 'layoutOffset for scroll position'),
            _buildPropertyRow('SliverPhysical...', 'Offset', 'paintOffset for painting'),
          ],
        ),
      ),
      _buildCodeBlock(
        'BoxParentData Definition',
        '''class BoxParentData extends ParentData {
  // Offset at which to paint the child
  Offset offset = Offset.zero;
  
  @override
  String toString() => 
    'offset=\\\$offset';
}''',
        _teal700,
      ),
      _buildCodeBlock(
        'ContainerParentDataMixin',
        '''mixin ContainerParentDataMixin<T extends RenderObject> 
    on ParentData {
  // Previous sibling in parent's child list
  T? previousSibling;
  
  // Next sibling in parent's child list  
  T? nextSibling;
}

// Combined type for box containers
class ContainerBoxParentData<T extends RenderBox>
    extends BoxParentData 
    with ContainerParentDataMixin<T> { }''',
        _amber700,
      ),
    ],
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 4: STACK AND POSITIONED EXAMPLES
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildStackExamplesSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionTitle('Stack/Positioned Usage', Icons.layers, _amber700),
      _buildInfoCard(
        'StackParentData Overview',
        'StackParentData extends ContainerBoxParentData and adds positioning '
        'constraints: left, top, right, bottom, width, and height. The Positioned '
        'widget is a ParentDataWidget that sets these values on StackParentData.',
        Icons.dashboard,
        _amber600,
      ),
      _buildCodeBlock(
        'StackParentData Structure',
        '''class StackParentData 
    extends ContainerBoxParentData<RenderBox> {
  // Positioning constraints
  double? top;
  double? right;
  double? bottom;
  double? left;
  double? width;
  double? height;
  
  // Check if positioned
  bool get isPositioned =>
    top != null || right != null ||
    bottom != null || left != null ||
    width != null || height != null;
    
  // Get positioning rect
  RelativeRect get rect => RelativeRect.fromLTRB(
    left ?? 0, top ?? 0, right ?? 0, bottom ?? 0
  );
}''',
        _amber700,
      ),
      _buildDiagramContainer(
        'Stack Layout Example',
        Container(
          height: 250,
          decoration: BoxDecoration(
            color: _grey100,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _grey400),
          ),
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _indigo100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    'Non-positioned\n(fills stack)',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: _indigo700, fontSize: 12),
                  ),
                ),
              ),
              Positioned(
                left: 20,
                top: 20,
                child: Container(
                  width: 80,
                  height: 50,
                  decoration: BoxDecoration(
                    color: _teal400,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: _teal700.withAlpha(60),
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'left:20\ntop:20',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: _white, fontSize: 10),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 20,
                top: 20,
                width: 80,
                height: 50,
                child: Container(
                  decoration: BoxDecoration(
                    color: _amber500,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: _amber700.withAlpha(60),
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'right:20\ntop:20',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: _white, fontSize: 10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 40,
                right: 40,
                bottom: 20,
                height: 60,
                child: Container(
                  decoration: BoxDecoration(
                    color: _red500,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: _red700.withAlpha(60),
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'left:40, right:40, bottom:20',
                      style: TextStyle(color: _white, fontSize: 11),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 100,
                top: 90,
                child: Container(
                  width: 100,
                  height: 60,
                  decoration: BoxDecoration(
                    color: _green500,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: _green700.withAlpha(60),
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'left:100\ntop:90',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: _white, fontSize: 10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      _buildCodeBlock(
        'Positioned Widget Usage',
        '''Stack(
  children: [
    // Non-positioned child fills available space
    Container(color: Colors.grey),
    
    // Positioned from top-left
    Positioned(
      left: 20,
      top: 20,
      child: Box(size: 80),
    ),
    
    // Positioned with explicit size
    Positioned(
      right: 20,
      top: 20,
      width: 80,
      height: 50,
      child: Box(),
    ),
    
    // Stretched horizontally
    Positioned(
      left: 40,
      right: 40,
      bottom: 20,
      height: 60,
      child: Box(),
    ),
  ],
)''',
        _amber700,
      ),
      _buildAsciiDiagram('''
Stack Layout Algorithm:
1. Non-positioned children given loose constraints
2. Stack sizes itself based on constraints + children
3. Positioned children sized based on positioning:
   
   left + right specified:
     width = stackWidth - left - right
   
   left + width specified:
     positioned at left, sized to width
   
   right + width specified:
     positioned at stackWidth - right - width
   
   only left specified:
     positioned at left, child intrinsic width
     
4. Child offset stored in parentData.offset
'''),
      _buildInfoCard(
        'Positioned.fill Shorthand',
        'The Positioned.fill constructor creates a child that fills the Stack '
        'by setting left, top, right, and bottom all to 0.0. This is useful for '
        'background layers or overlay content that should cover the entire Stack.',
        Icons.fullscreen,
        _teal600,
      ),
    ],
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 5: FLEX LAYOUT DEMOS
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildFlexLayoutSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionTitle('Flex Layout Demos', Icons.view_column, _green700),
      _buildInfoCard(
        'FlexParentData Overview',
        'FlexParentData extends ContainerBoxParentData and adds flex and fit '
        'properties. The flex value determines how much of the remaining space '
        'a child receives, while fit determines whether the child must fill '
        'that space (tight) or can be smaller (loose).',
        Icons.tune,
        _green600,
      ),
      _buildCodeBlock(
        'FlexParentData Structure',
        '''class FlexParentData 
    extends ContainerBoxParentData<RenderBox> {
  // Flex factor (0 = inflexible)
  int flex = 0;
  
  // How child fills allocated space
  FlexFit fit = FlexFit.tight;
}

enum FlexFit {
  // Child MUST fill allocated space
  tight,
  
  // Child CAN be smaller than allocated
  loose,
}''',
        _green700,
      ),
      _buildDiagramContainer(
        'Row with Flexible Children',
        Column(
          children: [
            Container(
              height: 80,
              decoration: BoxDecoration(
                color: _grey100,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _grey400),
              ),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    margin: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: _indigo400,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Center(
                      child: Text(
                        'Fixed\n60px',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: _white, fontSize: 10),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: _teal400,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Center(
                        child: Text(
                          'flex: 1',
                          style: TextStyle(color: _white, fontSize: 11),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Container(
                      margin: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: _amber500,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Center(
                        child: Text(
                          'flex: 2',
                          style: TextStyle(color: _white, fontSize: 11),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: _red400,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Center(
                        child: Text(
                          'flex: 1',
                          style: TextStyle(color: _white, fontSize: 11),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                _buildHighlightBox('Total flex: 4', _grey700),
                SizedBox(width: 8),
                _buildHighlightBox('Space per flex = remaining / 4', _green600),
              ],
            ),
          ],
        ),
      ),
      _buildAsciiDiagram('''
Flex Layout Algorithm:

Phase 1: Measure inflexible children (flex == 0)
┌────────────────────────────────────────────────────┐
│  [Fixed 60px]                 (remaining space)   │
└────────────────────────────────────────────────────┘

Phase 2: Calculate free space
  totalWidth = 300px
  fixedWidth = 60px  
  freeSpace = 300 - 60 = 240px
  totalFlex = 1 + 2 + 1 = 4
  spacePerFlex = 240 / 4 = 60px

Phase 3: Allocate to flexible children
┌────────┬────────────┬────────────────────────┬────────────┐
│ Fixed  │  flex:1    │       flex:2           │   flex:1   │
│  60px  │   60px     │       120px            │    60px    │
└────────┴────────────┴────────────────────────┴────────────┘
'''),
      _buildDiagramContainer(
        'FlexFit.tight vs FlexFit.loose',
        Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Text('FlexFit.tight:', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
            Container(
              height: 60,
              decoration: BoxDecoration(
                color: _grey100,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _grey400),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: _green500,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Center(
                        child: Text(
                          'FILLS allocated space',
                          style: TextStyle(color: _white, fontSize: 11),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Container(
              margin: EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Text('FlexFit.loose:', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
            Container(
              height: 60,
              decoration: BoxDecoration(
                color: _grey100,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _grey400),
              ),
              child: Row(
                children: [
                  Flexible(
                    fit: FlexFit.loose,
                    child: Container(
                      width: 120,
                      margin: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: _amber500,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Center(
                        child: Text(
                          'Can be smaller',
                          style: TextStyle(color: _white, fontSize: 11),
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
          ],
        ),
      ),
      _buildCodeBlock(
        'Expanded vs Flexible',
        '''// Expanded = Flexible with FlexFit.tight
Row(
  children: [
    Expanded(
      flex: 2,
      child: Container(color: Colors.red),
    ),
    Expanded(
      flex: 1, 
      child: Container(color: Colors.blue),
    ),
  ],
)

// Flexible can use loose fit
Row(
  children: [
    Flexible(
      flex: 1,
      fit: FlexFit.loose,
      child: Text('Can shrink to fit'),
    ),
  ],
)''',
        _green700,
      ),
      _buildInfoCard(
        'MainAxisSize Interaction',
        'When a Flex (Row/Column) has MainAxisSize.min, it shrinks to fit its '
        'children. Flexible children with loose fit will be given their intrinsic '
        'size rather than filling remaining space. This interaction between '
        'MainAxisSize and FlexFit is important for responsive layouts.',
        Icons.compress,
        _teal600,
      ),
    ],
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 6: CUSTOM PARENT DATA CONCEPTS
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildCustomParentDataSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionTitle('Custom ParentData Concepts', Icons.build_circle, _indigo600),
      _buildInfoCard(
        'Creating Custom ParentData',
        'You can create custom ParentData classes for specialized layout needs. '
        'This involves defining the ParentData class, creating a ParentDataWidget '
        'to set values, and implementing a custom RenderObject that uses the data.',
        Icons.architecture,
        _indigo500,
      ),
      _buildCodeBlock(
        'Custom ParentData Example',
        '''// Step 1: Define custom ParentData
class PriorityParentData 
    extends ContainerBoxParentData<RenderBox> {
  int priority = 0;
  bool visible = true;
  double opacity = 1.0;
}

// Step 2: Create ParentDataWidget
class PriorityBox extends ParentDataWidget<PriorityParentData> {
  PriorityBox({
    required Widget child,
    this.priority = 0,
    this.visible = true,
    this.opacity = 1.0,
  }) : super(child: child);
  
  final int priority;
  final bool visible;
  final double opacity;
  
  @override
  void applyParentData(RenderObject renderObject) {
    final data = 
      renderObject.parentData as PriorityParentData;
    
    bool needsLayout = false;
    bool needsPaint = false;
    
    if (data.priority != priority) {
      data.priority = priority;
      needsLayout = true;
    }
    if (data.visible != visible) {
      data.visible = visible;
      needsLayout = true;
    }
    if (data.opacity != opacity) {
      data.opacity = opacity;
      needsPaint = true;
    }
    
    final parent = renderObject.parent;
    if (parent != null && needsLayout) {
      parent.markNeedsLayout();
    }
    if (parent != null && needsPaint) {
      parent.markNeedsPaint();
    }
  }
  
  @override
  Type get debugTypicalAncestorWidgetClass => 
    PriorityStack;
}''',
        _indigo700,
      ),
      _buildCodeBlock(
        'Custom RenderObject Using ParentData',
        '''// Step 3: RenderObject that uses custom ParentData
class RenderPriorityStack extends RenderBox
    with ContainerRenderObjectMixin<RenderBox, 
         PriorityParentData>,
         RenderBoxContainerDefaultsMixin<RenderBox,
         PriorityParentData> {
  
  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! PriorityParentData) {
      child.parentData = PriorityParentData();
    }
  }
  
  @override
  void performLayout() {
    // Sort children by priority
    List<RenderBox> children = [];
    RenderBox? child = firstChild;
    while (child != null) {
      children.add(child);
      final data = 
        child.parentData as PriorityParentData;
      child = data.nextSibling;
    }
    
    children.sort((a, b) {
      final dataA = 
        a.parentData as PriorityParentData;
      final dataB = 
        b.parentData as PriorityParentData;
      return dataA.priority.compareTo(dataB.priority);
    });
    
    // Layout children in priority order
    // ... layout logic using priority data
  }
  
  @override
  void paint(PaintingContext context, Offset offset) {
    RenderBox? child = firstChild;
    while (child != null) {
      final data = 
        child.parentData as PriorityParentData;
      
      if (data.visible) {
        if (data.opacity < 1.0) {
          context.pushOpacity(
            offset + data.offset,
            (data.opacity * 255).round(),
            (ctx, off) => ctx.paintChild(child!, off),
          );
        } else {
          context.paintChild(child, offset + data.offset);
        }
      }
      
      child = data.nextSibling;
    }
  }
}''',
        _teal700,
      ),
      _buildDiagramContainer(
        'Custom ParentData Pattern',
        _buildAsciiDiagram('''
┌─────────────────────────────────────────────────────┐
│              PriorityStack (Widget)                 │
│                        │                            │
│                        ▼                            │
│           RenderPriorityStack                       │
│           (calls setupParentData)                   │
│                        │                            │
│     ┌──────────────────┼──────────────────┐        │
│     ▼                  ▼                  ▼        │
│  PriorityBox       PriorityBox        PriorityBox  │
│  priority:1        priority:3         priority:2   │
│     │                  │                  │        │
│     ▼                  ▼                  ▼        │
│  RenderBox          RenderBox          RenderBox   │
│  .parentData:       .parentData:       .parentData:│
│  PriorityParent..   PriorityParent..   PriorityP.. │
│  {priority:1}       {priority:3}       {priority:2}│
└─────────────────────────────────────────────────────┘

Layout order: priority 1 → priority 2 → priority 3
'''),
      ),
      _buildInfoCard(
        'Key Implementation Points',
        '• Override setupParentData() to create your ParentData type\n'
        '• ParentDataWidget.applyParentData() sets values on render objects\n'
        '• Call markNeedsLayout() when layout-affecting data changes\n'
        '• Call markNeedsPaint() when paint-only data changes\n'
        '• Use debugTypicalAncestorWidgetClass for error messages',
        Icons.lightbulb,
        _amber600,
      ),
      _buildCodeBlock(
        'ParentDataWidget Validation',
        '''// Good practice: validate parent type
class PriorityBox extends ParentDataWidget<PriorityParentData> {
  // ...
  
  @override
  bool debugIsValidAncestor(RenderObjectWidget ancestor) {
    // Only valid as child of PriorityStack
    return ancestor is PriorityStack;
  }
  
  @override
  Type get debugTypicalAncestorWidgetClass => PriorityStack;
}

// Usage:
PriorityStack(
  children: [
    PriorityBox(
      priority: 1,
      child: Text('First'),
    ),
    PriorityBox(
      priority: 2,
      visible: false,
      child: Text('Hidden'),
    ),
  ],
)''',
        _green700,
      ),
    ],
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// MAIN BUILD FUNCTION
// ═══════════════════════════════════════════════════════════════════════════════

dynamic build(BuildContext context) {
  print('ParentData Deep Demo - Comprehensive Rendering Test');
  print('=' * 60);

  // Section 1: Overview
  print('\n[SECTION 1] ParentData Overview');
  print('-' * 50);
  print('ParentData is the base class for render object parent data.');
  print('Key points:');
  print('  - Attached to child via setupParentData()');
  print('  - Contains layout information for the parent');
  print('  - Provides detach() for cleanup');
  print('  - Extended by BoxParentData, SliverParentData, etc.');

  // Section 2: detach() method
  print('\n[SECTION 2] detach() Method');
  print('-' * 50);
  print('detach() is called when child is removed from parent:');
  print('  1. Parent calls dropChild(child)');
  print('  2. Sibling links updated (for container parent data)');
  print('  3. child.parentData.detach() invoked');
  print('  4. References cleared for garbage collection');

  // Create ParentData instances for testing
  ParentData baseParentData = ParentData();
  print('\nParentData instance created:');
  print('  runtimeType: ' + baseParentData.runtimeType.toString());
  print('  toString: ' + baseParentData.toString());

  BoxParentData boxParentData = BoxParentData();
  boxParentData.offset = Offset(50.0, 75.0);
  print('\nBoxParentData instance:');
  print('  offset: ' + boxParentData.offset.toString());
  print('  offset.dx: ' + boxParentData.offset.dx.toString());
  print('  offset.dy: ' + boxParentData.offset.dy.toString());

  // Section 3: Hierarchy
  print('\n[SECTION 3] Rendering Layer Hierarchy');
  print('-' * 50);
  print('ParentData type hierarchy:');
  print('  ParentData');
  print('    ├── BoxParentData (offset)');
  print('    │     └── ContainerBoxParentData');
  print('    │           ├── FlexParentData (flex, fit)');
  print('    │           ├── StackParentData (positioning)');
  print('    │           ├── FlowParentData');
  print('    │           └── WrapParentData');
  print('    ├── SliverLogicalParentData');
  print('    └── SliverPhysicalParentData');

  // Section 4: Stack/Positioned
  print('\n[SECTION 4] Stack/Positioned Usage');
  print('-' * 50);
  print('StackParentData properties:');
  print('  - left, top, right, bottom: positioning');
  print('  - width, height: explicit sizing');
  print('  - isPositioned: true if any set');
  print('  - rect: RelativeRect from values');

  // Section 5: Flex layout
  print('\n[SECTION 5] Flex Layout');
  print('-' * 50);
  print('FlexParentData properties:');
  print('  - flex: int, how much free space to take');
  print('  - fit: FlexFit.tight or FlexFit.loose');
  print('FlexFit values:');
  print('  - tight: child MUST fill allocated space');
  print('  - loose: child CAN be smaller');

  // Section 6: Custom ParentData
  print('\n[SECTION 6] Custom ParentData');
  print('-' * 50);
  print('Creating custom ParentData:');
  print('  1. Define ParentData subclass');
  print('  2. Create ParentDataWidget');
  print('  3. Implement RenderObject with setupParentData');
  print('  4. Use ParentData in layout/paint');

  print('\n' + '=' * 60);
  print('ParentData Deep Demo completed successfully');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildMainHeader(
          'ParentData',
          'Base class for render object parent data',
          Icons.data_object,
        ),
        _buildOverviewSection(),
        _buildDetachSection(),
        _buildHierarchySection(),
        _buildStackExamplesSection(),
        _buildFlexLayoutSection(),
        _buildCustomParentDataSection(),
        SizedBox(height: 32),
        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: _grey100,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _grey300),
          ),
          child: Column(
            children: [
              Icon(Icons.check_circle, color: _green600, size: 48),
              SizedBox(height: 12),
              Text(
                'Demo Complete',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: _grey800,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'All ParentData concepts demonstrated successfully',
                style: TextStyle(
                  fontSize: 14,
                  color: _grey600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        SizedBox(height: 32),
      ],
    ),
  );
}
