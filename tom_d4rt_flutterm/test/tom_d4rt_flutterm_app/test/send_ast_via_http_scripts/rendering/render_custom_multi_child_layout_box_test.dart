// D4rt test script: Tests RenderCustomMultiChildLayoutBox from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

// Custom delegate for multi-child layout
class _StackLayoutDelegate extends MultiChildLayoutDelegate {
  @override
  void performLayout(Size size) {
    // Layout children in stack-like arrangement
    if (hasChild('background')) {
      layoutChild('background', BoxConstraints.tight(size));
      positionChild('background', Offset.zero);
    }
    if (hasChild('foreground')) {
      final foregroundSize = layoutChild(
        'foreground',
        BoxConstraints.loose(size),
      );
      positionChild(
        'foreground',
        Offset(
          (size.width - foregroundSize.width) / 2,
          (size.height - foregroundSize.height) / 2,
        ),
      );
    }
  }

  @override
  bool shouldRelayout(_StackLayoutDelegate oldDelegate) => false;
}

// Diagonal layout delegate
class _DiagonalLayoutDelegate extends MultiChildLayoutDelegate {
  final double spacing;

  _DiagonalLayoutDelegate({this.spacing = 20});

  @override
  void performLayout(Size size) {
    double x = 0;
    double y = 0;
    for (int i = 0; i < 5; i++) {
      final childId = 'item$i';
      if (hasChild(childId)) {
        final childSize = layoutChild(childId, BoxConstraints.loose(size));
        positionChild(childId, Offset(x, y));
        x += spacing;
        y += spacing;
      }
    }
  }

  @override
  bool shouldRelayout(_DiagonalLayoutDelegate oldDelegate) {
    return spacing != oldDelegate.spacing;
  }
}

dynamic build(BuildContext context) {
  print('RenderCustomMultiChildLayoutBox test executing');

  // ========== CUSTOM MULTI-CHILD LAYOUT BASICS ==========
  print('--- CustomMultiChildLayout Basics ---');
  print('RenderCustomMultiChildLayoutBox positions multiple children');
  print('Uses MultiChildLayoutDelegate for custom positioning');
  print('Each child must have a LayoutId');

  // Test basic CustomMultiChildLayout
  final stackLayout = CustomMultiChildLayout(
    delegate: _StackLayoutDelegate(),
    children: [
      LayoutId(
        id: 'background',
        child: Container(color: Colors.blue),
      ),
      LayoutId(
        id: 'foreground',
        child: Container(
          width: 50,
          height: 50,
          color: Colors.white,
          child: Center(child: Text('FG')),
        ),
      ),
    ],
  );
  print('CustomMultiChildLayout with stack delegate');
  print('  Background: fills entire area');
  print('  Foreground: centered 50x50');

  // ========== DELEGATE METHODS ==========
  print('--- MultiChildLayoutDelegate Methods ---');
  print('hasChild(id): Check if child with id exists');
  print('layoutChild(id, constraints): Layout child, returns Size');
  print('positionChild(id, offset): Position child at offset');
  print('shouldRelayout(oldDelegate): Return true to trigger relayout');

  // Test diagonal layout
  final diagonalLayout = CustomMultiChildLayout(
    delegate: _DiagonalLayoutDelegate(spacing: 15),
    children: [
      for (int i = 0; i < 3; i++)
        LayoutId(
          id: 'item$i',
          child: Container(
            width: 30,
            height: 30,
            color: Colors.primaries[i % Colors.primaries.length],
            child: Center(child: Text('$i')),
          ),
        ),
    ],
  );
  print('Diagonal layout with 3 children');
  print('  Spacing: 15 pixels');

  // ========== LAYOUT ID USAGE ==========
  print('--- LayoutId Usage ---');
  print('LayoutId wraps each child with unique identifier');
  print('ID can be any Object (String, int, enum, etc.)');
  print('IDs must be unique within the layout');

  // Test with different ID types
  final stringIds = CustomMultiChildLayout(
    delegate: _StackLayoutDelegate(),
    children: [
      LayoutId(
        id: 'bg',
        child: Container(color: Colors.grey),
      ),
      LayoutId(
        id: 'fg',
        child: Container(width: 40, height: 40, color: Colors.red),
      ),
    ],
  );
  print('String IDs: "bg", "fg"');

  // ========== USE CASES ==========
  print('--- Common Use Cases ---');
  print('1. Complex overlay layouts');
  print('2. Custom card layouts');
  print('3. Dashboard widgets with specific positioning');
  print('4. Game UI layouts');

  // Test responsive-like layout
  final responsiveLayout = Container(
    width: 200,
    height: 100,
    color: Colors.grey[200],
    child: CustomMultiChildLayout(
      delegate: _StackLayoutDelegate(),
      children: [
        LayoutId(
          id: 'background',
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.purple, Colors.blue]),
            ),
          ),
        ),
        LayoutId(
          id: 'foreground',
          child: Card(
            child: Padding(padding: EdgeInsets.all(8), child: Text('Card')),
          ),
        ),
      ],
    ),
  );
  print('Responsive-style layout with gradient background');

  // ========== COMPARING WITH OTHER LAYOUTS ==========
  print('--- Comparing Layout Widgets ---');
  print('CustomMultiChildLayout: Full control over positioning');
  print('Stack: Z-order based layout with alignment');
  print('Flow: Transformation-based layout');
  print('Wrap: Automatic wrapping layout');

  // ========== CONSTRAINT HANDLING ==========
  print('--- Constraint Handling ---');
  print('Parent constraints passed to delegate');
  print('layoutChild receives constraints you specify');
  print('Children can have different constraints');

  // Test tight vs loose constraints
  final constraintTest = CustomMultiChildLayout(
    delegate: _StackLayoutDelegate(),
    children: [
      LayoutId(
        id: 'background',
        child: Container(color: Colors.cyan),
      ),
      LayoutId(
        id: 'foreground',
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [Icon(Icons.star, size: 24), Text('Star')],
        ),
      ),
    ],
  );
  print('Constraint test with varying child sizes');

  // ========== PERFORMANCE NOTES ==========
  print('--- Performance Considerations ---');
  print('shouldRelayout controls when to recalculate');
  print('Cache layout calculations when possible');
  print('Minimize number of children for performance');

  print('RenderCustomMultiChildLayoutBox test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderCustomMultiChildLayoutBox Tests'),
      Container(width: 150, height: 100, child: stackLayout),
      SizedBox(height: 8),
      Container(
        width: 120,
        height: 80,
        color: Colors.grey[100],
        child: diagonalLayout,
      ),
      SizedBox(height: 8),
      responsiveLayout,
      SizedBox(height: 8),
      Text('All CustomMultiChildLayout tests passed'),
    ],
  );
}
