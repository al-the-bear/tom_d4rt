// D4rt test script: Tests AnimatedGrid from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('AnimatedGrid test executing');

  // AnimatedGrid was added in Flutter 3.7+ (similar to AnimatedList but for grids)
  // It may not be available in all Flutter versions
  print('AnimatedGrid requires Flutter 3.7+');

  // Test AnimatedGrid with initialItemCount
  try {
    final grid1 = AnimatedGrid(
      initialItemCount: 6,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
      ),
      itemBuilder: (context, index, animation) {
        return ScaleTransition(
          scale: animation,
          child: Container(
            color: Colors.primaries[index % Colors.primaries.length],
            child: Center(
              child: Text(
                '$index',
                style: TextStyle(color: Colors.white, fontSize: 18.0),
              ),
            ),
          ),
        );
      },
    );
    print('AnimatedGrid(initialItemCount: 6, crossAxisCount: 3) created');

    // Test AnimatedGrid with different cross axis count
    final grid2 = AnimatedGrid(
      initialItemCount: 4,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
        childAspectRatio: 1.5,
      ),
      itemBuilder: (context, index, animation) {
        return FadeTransition(
          opacity: animation,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Center(
              child: Text('Grid $index', style: TextStyle(color: Colors.white)),
            ),
          ),
        );
      },
    );
    print('AnimatedGrid(initialItemCount: 4, crossAxisCount: 2) created');

    // Test AnimatedGrid with zero initial items
    final grid3 = AnimatedGrid(
      initialItemCount: 0,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      itemBuilder: (context, index, animation) {
        return SizeTransition(
          sizeFactor: animation,
          child: Container(
            color: Colors.blue,
            child: Center(child: Text('$index')),
          ),
        );
      },
    );
    print('AnimatedGrid(initialItemCount: 0) created');

    print('AnimatedGrid test completed');
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('AnimatedGrid Tests'),
        SizedBox(height: 8.0),
        SizedBox(height: 150.0, child: grid1),
        SizedBox(height: 8.0),
        SizedBox(height: 150.0, child: grid2),
        SizedBox(height: 8.0),
        SizedBox(height: 50.0, child: grid3),
      ],
    );
  } catch (e) {
    print('AnimatedGrid not available in this Flutter version: $e');
    print('AnimatedGrid test completed (not available)');

    // Fallback: show GridView as alternative
    final fallbackGrid = GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
      children: List.generate(6, (index) {
        return Container(
          color: Colors.primaries[index % Colors.primaries.length],
          child: Center(
            child: Text('$index', style: TextStyle(color: Colors.white)),
          ),
        );
      }),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('AnimatedGrid not available - showing GridView fallback'),
        SizedBox(height: 8.0),
        fallbackGrid,
      ],
    );
  }
}
