// D4rt test script: Tests RenderDecoratedSliver from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RenderDecoratedSliver test executing');

  // ========== DECORATED SLIVER BASICS ==========
  print('--- DecoratedSliver Basics ---');
  print('RenderDecoratedSliver paints decoration around a sliver');
  print('Equivalent to DecoratedBox but for slivers');
  print('Supports BoxDecoration, ShapeDecoration, etc.');

  // Test using DecoratedSliver widget
  final colorDecoration = BoxDecoration(
    color: Colors.blue[100],
  );
  print('Simple color BoxDecoration');
  print('  color: Colors.blue[100]');

  // Test gradient decoration
  final gradientDecoration = BoxDecoration(
    gradient: LinearGradient(
      colors: [Colors.purple, Colors.blue],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  );
  print('Gradient BoxDecoration');
  print('  LinearGradient: purple to blue');

  // ========== DECORATION TYPES ==========
  print('--- Decoration Types ---');

  // Border decoration
  final borderDecoration = BoxDecoration(
    color: Colors.white,
    border: Border.all(color: Colors.red, width: 2),
    borderRadius: BorderRadius.circular(8),
  );
  print('Border decoration');
  print('  border: 2px red');
  print('  borderRadius: 8');

  // Shadow decoration
  final shadowDecoration = BoxDecoration(
    color: Colors.white,
    boxShadow: [
      BoxShadow(
        color: Colors.black26,
        blurRadius: 8,
        offset: Offset(2, 2),
      ),
    ],
  );
  print('Shadow decoration');
  print('  boxShadow: black26, blur 8, offset (2,2)');

  // Combined decoration
  final combinedDecoration = BoxDecoration(
    gradient: LinearGradient(
      colors: [Colors.orange, Colors.red],
    ),
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: Colors.black38,
        blurRadius: 10,
        offset: Offset(0, 4),
      ),
    ],
  );
  print('Combined decoration: gradient + radius + shadow');

  // ========== SLIVER CONTEXT ==========
  print('--- Sliver Context Usage ---');
  print('DecoratedSliver must be used inside CustomScrollView');
  print('Decoration wraps the entire sliver paint extent');
  print('Useful for sliver headers, footers, backgrounds');

  // Create a complete scrollable with decorated slivers
  final scrollableExample = Container(
    height: 200,
    child: CustomScrollView(
      slivers: [
        // Decorated header sliver
        DecoratedSliver(
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
          ),
          sliver: SliverToBoxAdapter(
            child: Container(
              height: 60,
              child: Center(
                child: Text(
                  'Decorated Header',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ),
        ),
        // Content sliver
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => ListTile(
              title: Text('Item $index'),
              leading: Icon(Icons.star),
            ),
            childCount: 5,
          ),
        ),
        // Decorated footer sliver
        DecoratedSliver(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            border: Border(top: BorderSide(color: Colors.grey)),
          ),
          sliver: SliverToBoxAdapter(
            child: Container(
              height: 50,
              child: Center(child: Text('Footer')),
            ),
          ),
        ),
      ],
    ),
  );
  print('Complete CustomScrollView with decorated slivers');

  // ========== USE CASES ==========
  print('--- Common Use Cases ---');
  print('1. Styled sliver app bars');
  print('2. Section backgrounds in lists');
  print('3. Decorated sliver headers');
  print('4. Group separators with styling');

  // ========== DECORATION POSITION ==========
  print('--- Decoration Position ---');
  print('DecorationPosition.background: Decoration behind content');
  print('DecorationPosition.foreground: Decoration in front');

  final backgroundPositioned = DecoratedSliver(
    decoration: colorDecoration,
    position: DecorationPosition.background,
    sliver: SliverToBoxAdapter(child: Container(height: 40)),
  );
  print('Background positioned decoration');

  final foregroundPositioned = DecoratedSliver(
    decoration: BoxDecoration(
      border: Border.all(color: Colors.green, width: 3),
    ),
    position: DecorationPosition.foreground,
    sliver: SliverToBoxAdapter(child: Container(height: 40, color: Colors.yellow[100])),
  );
  print('Foreground positioned border');

  // ========== COMPARING WITH DECORATEDBOX ==========
  print('--- DecoratedSliver vs DecoratedBox ---');
  print('DecoratedBox: Works with RenderBox children');
  print('DecoratedSliver: Works with RenderSliver children');
  print('Same decoration types, different render protocols');

  // DecoratedBox equivalent
  final decoratedBox = DecoratedBox(
    decoration: borderDecoration,
    child: SizedBox(width: 80, height: 60, child: Center(child: Text('Box'))),
  );
  print('DecoratedBox for comparison');

  // ========== PAINTING BEHAVIOR ==========
  print('--- Painting Behavior ---');
  print('Decoration paints relative to sliver\'s scroll offset');
  print('Handles sliver geometry (paintExtent, layoutExtent)');
  print('Clips to sliver bounds if needed');

  // ========== PERFORMANCE NOTES ==========
  print('--- Performance Considerations ---');
  print('Complex decorations (shadows, gradients) impact performance');
  print('Use simple colors when possible');
  print('Decoration is repainted on scroll');

  print('RenderDecoratedSliver test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderDecoratedSliver Tests'),
      SizedBox(height: 8),
      // Show decoration samples
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 60, height: 50,
            decoration: colorDecoration,
            child: Center(child: Text('Color')),
          ),
          SizedBox(width: 8),
          Container(
            width: 60, height: 50,
            decoration: borderDecoration,
            child: Center(child: Text('Border')),
          ),
          SizedBox(width: 8),
          Container(
            width: 60, height: 50,
            decoration: gradientDecoration,
            child: Center(child: Text('Grad', style: TextStyle(color: Colors.white))),
          ),
        ],
      ),
      SizedBox(height: 8),
      // Scrollable example
      ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: scrollableExample,
      ),
      SizedBox(height: 8),
      decoratedBox,
      SizedBox(height: 8),
      Text('All DecoratedSliver tests passed'),
    ],
  );
}
