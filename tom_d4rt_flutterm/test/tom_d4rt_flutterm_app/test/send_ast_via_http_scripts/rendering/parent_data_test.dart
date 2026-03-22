// D4rt test script: Comprehensive deep demo for ParentData from rendering
//
// ParentData is the base class for data attached to render objects:
//   - Stored in child.parentData property
//   - Set up by parent via setupParentData()
//   - Contains layout information about the child
//   - Cleaned up via detach() when child is removed
//
// This demo covers:
//   1. ParentData concept explanation with visuals
//   2. Positioned widget demonstration (uses BoxParentData)
//   3. Stack layout with StackParentData
//   4. Flex layout with FlexParentData (via Flexible)
//   5. detach() method visualization
//
// ═══════════════════════════════════════════════════════════════════════════
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// ═══════════════════════════════════════════════════════════════════════════
// COLOR PALETTE
// ═══════════════════════════════════════════════════════════════════════════

Color _primaryDark = Color(0xFF1565C0);
Color _primaryMedium = Color(0xFF1976D2);
Color _primaryLight = Color(0xFF42A5F5);
Color _primaryPale = Color(0xFFBBDEFB);
Color _primaryBg = Color(0xFFE3F2FD);

Color _accentDark = Color(0xFFC62828);
Color _accentMedium = Color(0xFFE53935);
Color _accentLight = Color(0xFFEF5350);

Color _successDark = Color(0xFF2E7D32);
Color _successMedium = Color(0xFF43A047);
Color _successLight = Color(0xFF66BB6A);
Color _successPale = Color(0xFFC8E6C9);

Color _warnDark = Color(0xFFF57F17);
Color _warnMedium = Color(0xFFFBC02D);

Color _textPrimary = Color(0xFF212121);
Color _textSecondary = Color(0xFF757575);
Color _bgCard = Color(0xFFFFFFFF);

// ═══════════════════════════════════════════════════════════════════════════
// HELPER WIDGETS
// ═══════════════════════════════════════════════════════════════════════════

Widget _buildSectionHeader(String title, IconData icon, Color color) {
  return Container(
    margin: EdgeInsets.only(bottom: 16, top: 8),
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [color, color.withAlpha(180)],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: color.withAlpha(60),
          blurRadius: 8,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      children: [
        Icon(icon, color: Colors.white, size: 24),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildInfoBox(String title, String content, IconData icon, Color color) {
  return Container(
    margin: EdgeInsets.only(bottom: 12),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _bgCard,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withAlpha(100), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 4,
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
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withAlpha(30),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: _textPrimary,
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
            color: _textSecondary,
            height: 1.5,
          ),
        ),
      ],
    ),
  );
}

Widget _buildCodeDisplay(String title, String code, Color headerColor) {
  return Container(
    margin: EdgeInsets.only(bottom: 16),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: headerColor.withAlpha(60)),
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
            color: Color(0xFF263238),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(11)),
          ),
          child: Text(
            code,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              color: Color(0xFFE0E0E0),
              height: 1.6,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildDiagramBox(String title, Widget diagram) {
  return Container(
    margin: EdgeInsets.only(bottom: 16),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _bgCard,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _primaryPale),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: _primaryDark,
          ),
        ),
        SizedBox(height: 12),
        diagram,
      ],
    ),
  );
}



Widget _buildAsciiDiagram(String ascii) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Color(0xFFE0E0E0)),
    ),
    child: Text(
      ascii,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11,
        color: _textPrimary,
        height: 1.4,
      ),
    ),
  );
}

// Helper for table rows
Widget _buildTableRow(String type, String properties, bool alternate) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: BoxDecoration(
      color: alternate ? _primaryBg : Colors.white,
    ),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            type,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: _textPrimary,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            properties,
            style: TextStyle(
              fontSize: 11,
              color: _textSecondary,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════
// MAIN BUILD FUNCTION
// ═══════════════════════════════════════════════════════════════════════════

dynamic build(BuildContext context) {
  print('ParentData Deep Demo - Comprehensive Test');
  print('═' * 60);

  // -------------------------------------------------------------------------
  // SECTION 1: ParentData Concept Explanation
  // -------------------------------------------------------------------------
  print('\n[SECTION 1] ParentData Concept Explanation');
  print('-' * 50);

  print('\nParentData is the base class for storing layout data:');
  print('  - Every RenderObject has a parentData property');
  print('  - The PARENT sets up this data for its CHILD');
  print('  - Contains information the parent needs for layout/paint');
  print('  - Different layout protocols use different ParentData types');

  print('\nConceptual Diagram:');
  print('  ┌───────────────────────────────────────────────┐');
  print('  │            RenderObject (Parent)              │');
  print('  │  ┌───────────────────────────────────────┐    │');
  print('  │  │        setupParentData(child)        │    │');
  print('  │  │   Creates ParentData for the child   │    │');
  print('  │  └───────────────────┬───────────────────┘    │');
  print('  │                      │                        │');
  print('  │                      ▼                        │');
  print('  │  ┌───────────────────────────────────────┐    │');
  print('  │  │         child.parentData              │    │');
  print('  │  │   Stores layout info about child      │    │');
  print('  │  └───────────────────────────────────────┘    │');
  print('  └───────────────────────────────────────────────┘');

  print('\nParentData class structure:');
  print('''
  class ParentData {
    // Called when the child is removed from the parent
    @protected
    @mustCallSuper
    void detach() {}
  }
  ''');

  print('\nKey points about ParentData:');
  print('  1. Base class is minimal - just has detach() method');
  print('  2. Subclasses add specific properties (offset, flex, etc.)');
  print('  3. Parent controls the ParentData type via setupParentData()');
  print('  4. Child widget can influence values via ParentDataWidget');

  // -------------------------------------------------------------------------
  // SECTION 2: Type Hierarchy Visualization
  // -------------------------------------------------------------------------
  print('\n[SECTION 2] ParentData Type Hierarchy');
  print('-' * 50);

  print('\nParentData inheritance tree:');
  print('''
  ParentData (base)
    │
    ├── BoxParentData (adds Offset offset)
    │     │
    │     ├── ContainerBoxParentData<RenderBox>
    │     │     │
    │     │     ├── FlexParentData (flex, fit)
    │     │     │
    │     │     ├── StackParentData (positioning rect)
    │     │     │
    │     │     ├── FlowParentData
    │     │     │
    │     │     └── WrapParentData
    │     │
    │     └── Multi/CustomLayoutParentData
    │
    ├── SliverLogicalParentData (scroll offset)
    │     │
    │     └── SliverLogicalContainerParentData
    │
    ├── SliverPhysicalParentData (paint offset)
    │     │
    │     └── SliverPhysicalContainerParentData
    │
    └── Other specialized types...
  ''');

  // -------------------------------------------------------------------------
  // SECTION 3: BoxParentData and Positioned
  // -------------------------------------------------------------------------
  print('\n[SECTION 3] BoxParentData via Positioned Widget');
  print('-' * 50);

  print('\nBoxParentData adds offset property:');
  print('''
  class BoxParentData extends ParentData {
    Offset offset = Offset.zero;
  }
  ''');

  print('\nPositioned widget sets StackParentData:');
  print('  - Positioned extends ParentDataWidget<StackParentData>');
  print('  - StackParentData extends BoxParentData');
  print('  - Adds: left, top, right, bottom, width, height');

  BoxParentData boxData = BoxParentData();
  boxData.offset = Offset(50.0, 100.0);
  print('\nBoxParentData instance:');
  print('  offset: ${boxData.offset}');
  print('  offset.dx: ${boxData.offset.dx}');
  print('  offset.dy: ${boxData.offset.dy}');

  print('\nPositioned usage diagram:');
  print('''
  Stack
    │
    └── Positioned(
          left: 20,
          top: 30,
          child: Box
        )
        │
        └── child.parentData:
              StackParentData(
                left: 20,
                top: 30,
                offset: calculated
              )
  ''');

  // -------------------------------------------------------------------------
  // SECTION 4: Stack Layout with StackParentData
  // -------------------------------------------------------------------------
  print('\n[SECTION 4] Stack Layout with StackParentData');
  print('-' * 50);

  print('\nStackParentData structure:');
  print('''
  class StackParentData extends ContainerBoxParentData<RenderBox> {
    // Positioning constraints
    double? top;
    double? right;
    double? bottom;
    double? left;
    double? width;
    double? height;

    // Whether positioned
    bool get isPositioned => 
      top != null || right != null || 
      bottom != null || left != null || 
      width != null || height != null;

    // Computed positioning rect
    RelativeRect get rect => RelativeRect.fromLTRB(
      left ?? 0, top ?? 0, right ?? 0, bottom ?? 0
    );
  }
  ''');

  print('\nStack layout algorithm with ParentData:');
  print('  1. Stack measures non-positioned children first');
  print('  2. Determines own size from constraints + children');
  print('  3. For each positioned child:');
  print('     a. Reads StackParentData values');
  print('     b. Calculates constraints from positioning');
  print('     c. Layouts child with calculated constraints');
  print('     d. Sets child.parentData.offset for painting');
  print('  4. Non-positioned children centered or stretched');

  print('\nStack layout visualization:');
  print('''
  ┌─────────────────────────────────┐
  │           Stack (400x400)       │
  │  ┌───────────────────────┐      │
  │  │  Non-positioned child │      │
  │  │    (fills vertically/ │      │
  │  │     horizontally)     │      │
  │  └───────────────────────┘      │
  │                                 │
  │      ┌──────────┐               │
  │      │Positioned│  left:40      │
  │      │ top:50   │  top:50       │
  │      └──────────┘               │
  │                                 │
  │               ┌──────────┐      │
  │               │Positioned│      │
  │               │right:20  │      │
  │               │bottom:20 │      │
  │               └──────────┘      │
  └─────────────────────────────────┘
  ''');

  // -------------------------------------------------------------------------
  // SECTION 5: Flex Layout with FlexParentData
  // -------------------------------------------------------------------------
  print('\n[SECTION 5] Flex Layout with FlexParentData');
  print('-' * 50);

  print('\nFlexParentData structure:');
  print('''
  class FlexParentData extends ContainerBoxParentData<RenderBox> {
    // How much of the free space this child takes
    int flex = 0;
    
    // How the child fills its allocated space
    FlexFit fit = FlexFit.tight;
  }
  ''');

  print('\nFlexFit values:');
  print('  FlexFit.tight  - Child MUST fill allocated space');
  print('  FlexFit.loose  - Child CAN be smaller than allocated');

  print('\nFlexible and Expanded widgets:');
  print('''
  // Expanded = Flexible with FlexFit.tight
  Expanded(
    flex: 2,
    child: Container(color: Colors.red),
  )
  
  // Flexible = FlexFit.loose by default  
  Flexible(
    flex: 1,
    fit: FlexFit.loose,
    child: Container(color: Colors.blue),
  )
  ''');

  print('\nFlex layout algorithm:');
  print('  Phase 1 - Measure inflexible children:');
  print('    - Children with flex == 0');
  print('    - Given unbounded constraints in main axis');
  print('    - Sum their main axis sizes');
  print('');
  print('  Phase 2 - Calculate free space:');
  print('    - freeSpace = mainAxisSize - inflexibleSize');
  print('    - totalFlex = sum of all flex values');
  print('    - spacePerFlex = freeSpace / totalFlex');
  print('');
  print('  Phase 3 - Layout flexible children:');
  print('    - For each child with flex > 0:');
  print('      - allocatedSpace = flex * spacePerFlex');
  print('      - If FlexFit.tight: exact size');
  print('      - If FlexFit.loose: max size');

  print('\nFlex layout visualization:');
  print('''
  Row (total width: 300px)
  ┌──────────┬────────────────────┬────────────────────┐
  │ Fixed    │    Flexible(1)     │    Flexible(2)     │
  │  60px    │    80px (loose)    │    160px (tight)   │
  │          │  ┌──────────┐      │ ################## │
  │  #####   │  │ content  │      │ ################## │
  │          │  └──────────┘      │ ################## │
  └──────────┴────────────────────┴────────────────────┘
  
  Calculation:
    freeSpace = 300 - 60 = 240px
    totalFlex = 1 + 2 = 3
    spacePerFlex = 240 / 3 = 80px
    
    Flexible(1): 1 * 80 = 80px max
    Flexible(2): 2 * 80 = 160px exact
  ''');

  // -------------------------------------------------------------------------
  // SECTION 6: detach() Method Visualization
  // -------------------------------------------------------------------------
  print('\n[SECTION 6] detach() Method Lifecycle');
  print('-' * 50);

  print('\ndetach() is called when child is removed from parent:');
  print('''
  class ParentData {
    @protected
    @mustCallSuper
    void detach() { }
  }
  ''');

  print('\nWhen detach() is called:');
  print('  1. Child is being removed from parent');
  print('  2. Parent calls child.parentData.detach()');
  print('  3. Cleans up any listeners or resources');
  print('  4. Sibling links are severed (for container parent data)');

  print('\nContainerParentDataMixin detach():');
  print('''
  mixin ContainerParentDataMixin<ChildType extends RenderObject> 
      on ParentData {
    
    ChildType? previousSibling;
    ChildType? nextSibling;
    
    @override
    void detach() {
      // Sever sibling links
      // Allows garbage collection
      super.detach();
    }
  }
  ''');

  print('\ndetach() lifecycle diagram:');
  print('''
  BEFORE REMOVAL:
  ┌────────────────────────────────────────────┐
  │            Parent RenderObject             │
  │                                            │
  │   Child A ←→ Child B ←→ Child C ←→ Child D │
  │              (removing)                    │
  └────────────────────────────────────────────┘
  
  DURING REMOVAL:
  ┌────────────────────────────────────────────┐
  │  1. Parent removes Child B from tree       │
  │  2. childB.parentData.detach() called      │
  │  3. Sibling links updated:                 │
  │     - childA.next = childC                 │
  │     - childC.previous = childA             │
  │  4. childB references cleared              │
  └────────────────────────────────────────────┘
  
  AFTER REMOVAL:
  ┌────────────────────────────────────────────┐
  │            Parent RenderObject             │
  │                                            │
  │       Child A  ←→  Child C  ←→  Child D    │
  │                                            │
  │       Child B (orphaned, can be GC'd)      │
  └────────────────────────────────────────────┘
  ''');

  print('\nBest practices for detach():');
  print('  1. Always call super.detach()');
  print('  2. Clean up listeners registered with parent');
  print('  3. Release any cached resources');
  print('  4. Do not access parent after detach');

  // -------------------------------------------------------------------------
  // SECTION 7: ParentDataWidget Pattern
  // -------------------------------------------------------------------------
  print('\n[SECTION 7] ParentDataWidget Pattern');
  print('-' * 50);

  print('\nParentDataWidget allows widgets to set parent data:');
  print('''
  abstract class ParentDataWidget<T extends ParentData> 
      extends ProxyWidget {
    
    // Check if this widget can apply to parent data
    bool debugIsValidParentData(covariant ParentData parentData);
    
    // Apply widget configuration to parent data
    void applyParentData(RenderObject renderObject);
  }
  ''');

  print('\nExample: Positioned inherits ParentDataWidget:');
  print('''
  class Positioned extends ParentDataWidget<StackParentData> {
    final double? left;
    final double? top;
    final double? right;
    final double? bottom;
    
    @override
    void applyParentData(RenderObject renderObject) {
      final parentData = renderObject.parentData as StackParentData;
      
      bool needsLayout = false;
      
      if (parentData.left != left) {
        parentData.left = left;
        needsLayout = true;
      }
      // ... similar for top, right, bottom
      
      if (needsLayout) {
        renderObject.parent?.markNeedsLayout();
      }
    }
  }
  ''');

  print('\nParentDataWidget responsibilities:');
  print('  1. Type-safe parent data access');
  print('  2. Validate compatibility with parent');
  print('  3. Apply data changes efficiently');
  print('  4. Trigger relayout when data changes');

  // -------------------------------------------------------------------------
  // SECTION 8: Custom ParentData Example
  // -------------------------------------------------------------------------
  print('\n[SECTION 8] Creating Custom ParentData');
  print('-' * 50);

  print('\nCustom parent data for a priority-based layout:');
  print('''
  // Custom ParentData
  class PriorityParentData extends ContainerBoxParentData<RenderBox> {
    int priority = 0;
    bool visible = true;
  }
  
  // Custom ParentDataWidget  
  class Priority extends ParentDataWidget<PriorityParentData> {
    final int priority;
    final bool visible;
    
    @override
    void applyParentData(RenderObject renderObject) {
      final parentData = renderObject.parentData as PriorityParentData;
      
      if (parentData.priority != priority) {
        parentData.priority = priority;
        renderObject.parent?.markNeedsLayout();
      }
      
      if (parentData.visible != visible) {
        parentData.visible = visible;
        renderObject.parent?.markNeedsPaint();
      }
    }
    
    @override
    bool debugIsValidParentData(ParentData parentData) {
      return parentData is PriorityParentData;
    }
  }
  
  // Custom RenderObject
  class RenderPriorityLayout extends RenderBox
      with ContainerRenderObjectMixin<RenderBox, PriorityParentData> {
    
    @override
    void setupParentData(RenderBox child) {
      if (child.parentData is! PriorityParentData) {
        child.parentData = PriorityParentData();
      }
    }
    
    @override
    void performLayout() {
      // Sort children by priority
      final children = <RenderBox>[];
      visitChildren((child) {
        children.add(child as RenderBox);
      });
      children.sort((a, b) {
        final aData = a.parentData as PriorityParentData;
        final bData = b.parentData as PriorityParentData;
        return bData.priority - aData.priority;
      });
      
      // Layout high priority first
      // ... layout logic
    }
  }
  ''');

  // -------------------------------------------------------------------------
  // SECTION 9: Common ParentData Types Summary
  // -------------------------------------------------------------------------
  print('\n[SECTION 9] Common ParentData Types Summary');
  print('-' * 50);

  print('\n┌────────────────────────┬──────────────────────────────────────┐');
  print('│ ParentData Type        │ Purpose & Properties                 │');
  print('├────────────────────────┼──────────────────────────────────────┤');
  print('│ BoxParentData          │ Basic offset for box children        │');
  print('│                        │ - offset: Offset                     │');
  print('├────────────────────────┼──────────────────────────────────────┤');
  print('│ StackParentData        │ Positioning in Stack                 │');
  print('│                        │ - left, top, right, bottom           │');
  print('│                        │ - width, height                      │');
  print('├────────────────────────┼──────────────────────────────────────┤');
  print('│ FlexParentData         │ Flex layout (Row/Column)             │');
  print('│                        │ - flex: int                          │');
  print('│                        │ - fit: FlexFit                       │');
  print('├────────────────────────┼──────────────────────────────────────┤');
  print('│ FlowParentData         │ Flow widget layout                   │');
  print('│                        │ - offset from FlowDelegate           │');
  print('├────────────────────────┼──────────────────────────────────────┤');
  print('│ WrapParentData         │ Wrap widget positioning              │');
  print('│                        │ - offset for wrapped children        │');
  print('├────────────────────────┼──────────────────────────────────────┤');
  print('│ TableCellParentData    │ Table cell positioning               │');
  print('│                        │ - verticalAlignment                  │');
  print('├────────────────────────┼──────────────────────────────────────┤');
  print('│ SliverLogicalParentData│ Sliver scrolling                     │');
  print('│                        │ - layoutOffset: double               │');
  print('├────────────────────────┼──────────────────────────────────────┤');
  print('│ SliverPhysicalParentData│ Sliver painting                     │');
  print('│                        │ - paintOffset: Offset                │');
  print('└────────────────────────┴──────────────────────────────────────┘');

  print('\n═' * 60);
  print('ParentData Deep Demo completed successfully');
  print('═' * 60);

  // =========================================================================
  // BUILD VISUAL UI
  // =========================================================================

  return SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Title
        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [_primaryDark, _primaryMedium],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Icon(Icons.account_tree, size: 48, color: Colors.white),
              SizedBox(height: 12),
              Text(
                'ParentData',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Base class for layout data attached to render objects',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withAlpha(220),
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 24),

        // Section 1: Concept
        _buildSectionHeader(
          'ParentData Concept',
          Icons.lightbulb_outline,
          _primaryDark,
        ),

        _buildInfoBox(
          'What is ParentData?',
          'ParentData is the base class for data that a parent RenderObject '
              'stores about each of its children. The parent creates this data '
              'via setupParentData() and uses it during layout and painting. '
              'Different layout protocols use specialized ParentData subclasses.',
          Icons.info_outline,
          _primaryMedium,
        ),

        _buildDiagramBox(
          'ParentData Flow',
          _buildAsciiDiagram('''
  ┌───────────────────────────────────┐
  │     Parent RenderObject           │
  │                                   │
  │  setupParentData(child) {         │
  │    child.parentData = MyData();   │
  │  }                                │
  │                 │                 │
  │                 ▼                 │
  │  ┌─────────────────────────────┐  │
  │  │   child.parentData          │  │
  │  │   (layout info storage)     │  │
  │  └─────────────────────────────┘  │
  └───────────────────────────────────┘'''),
        ),

        _buildCodeDisplay('ParentData Base Class', '''
class ParentData {
  // Called when child is removed from parent
  @protected
  @mustCallSuper
  void detach() { }
}''', _primaryDark),

        // Section 2: Type Hierarchy
        _buildSectionHeader(
          'Type Hierarchy',
          Icons.account_tree_outlined,
          _successDark,
        ),

        _buildDiagramBox(
          'ParentData Inheritance',
          _buildAsciiDiagram('''
  ParentData
    │
    ├── BoxParentData
    │     ├── ContainerBoxParentData
    │     │     ├── FlexParentData
    │     │     ├── StackParentData
    │     │     └── FlowParentData
    │     └── Other box types...
    │
    ├── SliverLogicalParentData
    │     └── SliverLogicalContainerParentData
    │
    └── SliverPhysicalParentData
          └── SliverPhysicalContainerParentData'''),
        ),

        // Section 3: Positioned/BoxParentData
        _buildSectionHeader(
          'Positioned & BoxParentData',
          Icons.place_outlined,
          _accentDark,
        ),

        _buildInfoBox(
          'BoxParentData',
          'BoxParentData extends ParentData with a single property: offset. '
              'This Offset determines where the child is painted relative to the '
              'parent. The parent sets this during layout after determining child position.',
          Icons.drag_indicator,
          _accentMedium,
        ),

        _buildCodeDisplay('BoxParentData Structure', '''
class BoxParentData extends ParentData {
  // Position where child paints
  Offset offset = Offset.zero;
}

// In parent layout:
void performLayout() {
  child.layout(constraints, parentUsesSize: true);
  final childData = child.parentData as BoxParentData;
  childData.offset = Offset(20, 30);
}''', _accentDark),

        // Section 4: Stack Demo
        _buildSectionHeader(
          'Stack with StackParentData',
          Icons.layers_outlined,
          _warnDark,
        ),

        _buildInfoBox(
          'StackParentData',
          'StackParentData extends ContainerBoxParentData and adds positioning '
              'properties: left, top, right, bottom, width, height. The Positioned '
              'widget sets these values, and Stack uses them during layout.',
          Icons.view_in_ar,
          _warnDark,
        ),

        Container(
          height: 200,
          margin: EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: _primaryPale.withAlpha(100),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _primaryMedium),
          ),
          child: Stack(
            children: [
              Positioned(
                left: 16,
                top: 16,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: _accentLight,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      'left:16\ntop:16',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 11),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 16,
                top: 16,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: _successLight,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      'right:16\ntop:16',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 11),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 16,
                bottom: 16,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: _primaryLight,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      'left:16\nbottom:16',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 11),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 16,
                bottom: 16,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: _warnMedium,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      'right:16\nbottom:16',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 11),
                    ),
                  ),
                ),
              ),
              Center(
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: _primaryMedium),
                  ),
                  child: Text(
                    'Non-positioned\n(centered)',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: _textPrimary),
                  ),
                ),
              ),
            ],
          ),
        ),

        // Section 5: Flex Demo
        _buildSectionHeader(
          'Flex with FlexParentData',
          Icons.view_column_outlined,
          _successDark,
        ),

        _buildInfoBox(
          'FlexParentData',
          'FlexParentData stores flex factor and fit mode for Row/Column children. '
              'The flex property determines space allocation ratio, while fit '
              '(tight or loose) determines how child fills allocated space.',
          Icons.compare_arrows,
          _successDark,
        ),

        Container(
          margin: EdgeInsets.only(bottom: 16),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _successMedium),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Row with Flexible children:',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: _successDark,
                ),
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 60,
                    decoration: BoxDecoration(
                      color: _primaryMedium,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Center(
                      child: Text(
                        'Fixed\n50px',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Flexible(
                    flex: 1,
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: _accentLight,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Center(
                        child: Text(
                          'flex: 1',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Flexible(
                    flex: 2,
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: _successLight,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Center(
                        child: Text(
                          'flex: 2',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                'flex:2 gets 2x the space of flex:1',
                style: TextStyle(fontSize: 11, color: _textSecondary),
              ),
            ],
          ),
        ),

        _buildCodeDisplay('FlexParentData Structure', '''
class FlexParentData 
    extends ContainerBoxParentData<RenderBox> {
  
  int flex = 0;
  FlexFit fit = FlexFit.tight;
}

// Usage via Flexible/Expanded
Row(
  children: [
    Flexible(
      flex: 1,
      fit: FlexFit.loose,
      child: ...,
    ),
    Expanded(  // flex:1, fit:tight
      flex: 2,
      child: ...,
    ),
  ],
)''', _successDark),

        // Section 6: detach() visualization
        _buildSectionHeader(
          'detach() Method',
          Icons.link_off,
          _accentDark,
        ),

        _buildInfoBox(
          'When detach() is called',
          'The detach() method is called when a child is removed from its parent. '
              'It cleans up resources and severs sibling links. This allows the '
              'removed child to be garbage collected properly.',
          Icons.delete_sweep,
          _accentDark,
        ),

        _buildDiagramBox(
          'detach() Lifecycle',
          _buildAsciiDiagram('''
  BEFORE: A ←→ B ←→ C ←→ D
          │              │
  parent.remove(B) called
          │              │
  DURING: B.parentData.detach()
          - Clean up B references
          - Update: A.next = C
          - Update: C.prev = A
          │              │
  AFTER:  A ←────→ C ←→ D
          
          B (orphaned, eligible for GC)'''),
        ),

        // Summary Table
        _buildSectionHeader(
          'ParentData Types Summary',
          Icons.table_chart_outlined,
          _primaryDark,
        ),

        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _primaryPale),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _primaryDark,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(11)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        'Type',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        'Properties',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              _buildTableRow('BoxParentData', 'offset: Offset', false),
              _buildTableRow('StackParentData', 'left, top, right, bottom, width, height', true),
              _buildTableRow('FlexParentData', 'flex: int, fit: FlexFit', false),
              _buildTableRow('FlowParentData', 'offset (delegate-controlled)', true),
              _buildTableRow('WrapParentData', 'offset, runIndex', false),
              _buildTableRow('TableCellParentData', 'verticalAlignment', true),
              _buildTableRow('SliverLogicalParentData', 'layoutOffset', false),
              _buildTableRow('SliverPhysicalParentData', 'paintOffset', true),
            ],
          ),
        ),

        SizedBox(height: 24),

        // Footer
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _successPale,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _successMedium),
          ),
          child: Row(
            children: [
              Icon(Icons.check_circle, color: _successDark, size: 24),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'ParentData demo completed. Covered: concept, type hierarchy, '
                      'BoxParentData, StackParentData, FlexParentData, and detach().',
                  style: TextStyle(
                    fontSize: 13,
                    color: _successDark,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
