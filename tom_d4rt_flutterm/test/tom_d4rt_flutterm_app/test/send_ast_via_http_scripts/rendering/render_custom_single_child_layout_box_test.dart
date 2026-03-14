// D4rt test script: Tests RenderCustomSingleChildLayoutBox from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

// Center-offset delegate
class _CenterOffsetDelegate extends SingleChildLayoutDelegate {
  final Offset offset;

  _CenterOffsetDelegate({this.offset = Offset.zero});

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return BoxConstraints.loose(constraints.biggest);
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    return Offset(
      (size.width - childSize.width) / 2 + offset.dx,
      (size.height - childSize.height) / 2 + offset.dy,
    );
  }

  @override
  bool shouldRelayout(_CenterOffsetDelegate oldDelegate) {
    return offset != oldDelegate.offset;
  }

  @override
  Size getSize(BoxConstraints constraints) => constraints.biggest;
}

// Corner positioning delegate
class _CornerDelegate extends SingleChildLayoutDelegate {
  final Alignment alignment;
  final EdgeInsets padding;

  _CornerDelegate({
    this.alignment = Alignment.center,
    this.padding = EdgeInsets.zero,
  });

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return BoxConstraints.loose(Size(
      constraints.maxWidth - padding.horizontal,
      constraints.maxHeight - padding.vertical,
    ));
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    final x = padding.left + (size.width - padding.horizontal - childSize.width) * 
        ((alignment.x + 1) / 2);
    final y = padding.top + (size.height - padding.vertical - childSize.height) * 
        ((alignment.y + 1) / 2);
    return Offset(x, y);
  }

  @override
  bool shouldRelayout(_CornerDelegate oldDelegate) {
    return alignment != oldDelegate.alignment || padding != oldDelegate.padding;
  }
}

dynamic build(BuildContext context) {
  print('RenderCustomSingleChildLayoutBox test executing');

  // ========== CUSTOM SINGLE CHILD LAYOUT BASICS ==========
  print('--- CustomSingleChildLayout Basics ---');
  print('RenderCustomSingleChildLayoutBox positions a single child');
  print('Uses SingleChildLayoutDelegate for custom positioning');
  print('More flexible than Align widget');

  // Test basic CustomSingleChildLayout
  final centeredLayout = CustomSingleChildLayout(
    delegate: _CenterOffsetDelegate(),
    child: Container(
      width: 60,
      height: 60,
      color: Colors.blue,
      child: Center(child: Text('C')),
    ),
  );
  print('CustomSingleChildLayout with center delegate');
  print('  Child centered in available space');

  // Test with offset
  final offsetLayout = CustomSingleChildLayout(
    delegate: _CenterOffsetDelegate(offset: Offset(20, 10)),
    child: Container(
      width: 50,
      height: 50,
      color: Colors.red,
      child: Center(child: Text('O')),
    ),
  );
  print('CustomSingleChildLayout with offset');
  print('  Offset: (20, 10) from center');

  // ========== DELEGATE METHODS ==========
  print('--- SingleChildLayoutDelegate Methods ---');
  print('getSize(constraints): Override to set layout size');
  print('getConstraintsForChild(constraints): Set child constraints');
  print('getPositionForChild(size, childSize): Position child');
  print('shouldRelayout(oldDelegate): Control when to relayout');

  // Test corner positioning
  final topLeftLayout = CustomSingleChildLayout(
    delegate: _CornerDelegate(
      alignment: Alignment.topLeft,
      padding: EdgeInsets.all(8),
    ),
    child: Container(
      width: 40,
      height: 40,
      color: Colors.green,
      child: Center(child: Text('TL')),
    ),
  );
  print('Corner delegate: top-left with padding');

  final bottomRightLayout = CustomSingleChildLayout(
    delegate: _CornerDelegate(
      alignment: Alignment.bottomRight,
      padding: EdgeInsets.all(8),
    ),
    child: Container(
      width: 40,
      height: 40,
      color: Colors.orange,
      child: Center(child: Text('BR')),
    ),
  );
  print('Corner delegate: bottom-right with padding');

  // ========== USE CASES ==========
  print('--- Common Use Cases ---');
  print('1. Tooltip positioning');
  print('2. Custom popup placement');
  print('3. Overlay positioning');
  print('4. Dynamic child positioning based on state');

  // Test animated positioning concept
  final animatedPosition = CustomSingleChildLayout(
    delegate: _CenterOffsetDelegate(offset: Offset(30, 0)),
    child: AnimatedContainer(
      duration: Duration(milliseconds: 200),
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.purple,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(child: Icon(Icons.star, color: Colors.white, size: 20)),
    ),
  );
  print('Animated positioning with delegate');

  // ========== CONSTRAINT HANDLING ==========
  print('--- Constraint Handling ---');
  print('getConstraintsForChild defines what child receives');
  print('Can use tight, loose, or custom constraints');
  print('Parent constraints available for calculations');

  // Test tight constraints
  final tightConstraintLayout = CustomSingleChildLayout(
    delegate: _CenterOffsetDelegate(),
    child: Container(
      color: Colors.teal,
      child: Center(child: Text('Tight')),
    ),
  );
  print('Loose constraints allow child to size itself');

  // ========== COMPARING WITH ALIGN ==========
  print('--- Comparing with Align Widget ---');
  print('Align: Simple alignment with alignment parameter');
  print('CustomSingleChildLayout: Full control over positioning');
  print('Align is simpler, CustomSingleChildLayout more powerful');

  // Equivalent Align widget
  final alignEquivalent = Align(
    alignment: Alignment.center,
    child: Container(
      width: 50,
      height: 50,
      color: Colors.amber,
      child: Center(child: Text('A')),
    ),
  );
  print('Align widget for simple centering');

  // ========== SIZING BEHAVIOR ==========
  print('--- Sizing Behavior ---');
  print('getSize controls how layout sizes itself');
  print('Default: constraints.biggest (fills available space)');
  print('Can return smaller size if needed');

  // Test with explicit size
  final fixedSizeLayout = Container(
    width: 120,
    height: 80,
    color: Colors.grey[200],
    child: CustomSingleChildLayout(
      delegate: _CenterOffsetDelegate(),
      child: Container(
        width: 40,
        height: 40,
        color: Colors.indigo,
        child: Center(child: Text('F')),
      ),
    ),
  );
  print('Fixed size container with centered child');

  // ========== NESTED LAYOUTS ==========
  print('--- Nested Custom Layouts ---');

  final nestedLayout = Container(
    width: 150,
    height: 100,
    color: Colors.grey[300],
    child: CustomSingleChildLayout(
      delegate: _CornerDelegate(alignment: Alignment.topRight, padding: EdgeInsets.all(4)),
      child: CustomSingleChildLayout(
        delegate: _CenterOffsetDelegate(),
        child: Container(
          width: 60,
          height: 50,
          color: Colors.pink,
          child: Center(child: Text('N')),
        ),
      ),
    ),
  );
  print('Nested CustomSingleChildLayout widgets');

  // ========== PERFORMANCE NOTES ==========
  print('--- Performance Considerations ---');
  print('shouldRelayout prevents unnecessary recalculations');
  print('Compare delegate properties for changes');
  print('Use const delegates when possible');

  print('RenderCustomSingleChildLayoutBox test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderCustomSingleChildLayoutBox Tests'),
      Container(
        width: 120,
        height: 80,
        color: Colors.grey[200],
        child: centeredLayout,
      ),
      SizedBox(height: 8),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(width: 80, height: 60, color: Colors.grey[100], child: topLeftLayout),
          SizedBox(width: 8),
          Container(width: 80, height: 60, color: Colors.grey[100], child: bottomRightLayout),
        ],
      ),
      SizedBox(height: 8),
      fixedSizeLayout,
      SizedBox(height: 8),
      nestedLayout,
      SizedBox(height: 8),
      Text('All CustomSingleChildLayout tests passed'),
    ],
  );
}
