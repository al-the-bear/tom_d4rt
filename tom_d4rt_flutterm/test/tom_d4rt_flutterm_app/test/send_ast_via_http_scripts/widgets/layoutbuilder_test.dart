// ignore_for_file: avoid_print
// D4rt test script: Tests LayoutBuilder from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('LayoutBuilder test executing');

  // Test LayoutBuilder checking constraints
  final constraintCheck = LayoutBuilder(
    builder: (BuildContext ctx, BoxConstraints constraints) {
      print('LayoutBuilder constraints: $constraints');
      print('maxWidth: ${constraints.maxWidth}');
      print('maxHeight: ${constraints.maxHeight}');
      print('minWidth: ${constraints.minWidth}');
      print('minHeight: ${constraints.minHeight}');
      return Container(
        color: Colors.blue,
        height: 60.0,
        child: Center(
          child: Text(
            'Max: ${constraints.maxWidth.toInt()}x${constraints.maxHeight.toInt()}',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    },
  );
  print('LayoutBuilder with constraint check created');

  // Test LayoutBuilder using maxWidth for responsive layout
  final responsiveLayout = LayoutBuilder(
    builder: (BuildContext ctx, BoxConstraints constraints) {
      final maxWidth = constraints.maxWidth;
      print('LayoutBuilder maxWidth: $maxWidth');
      if (maxWidth > 600.0) {
        return Row(
          children: [
            Expanded(
              child: Container(
                color: Colors.green,
                height: 80.0,
                child: Center(
                  child: Text(
                    'Left Panel',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: Container(
                color: Colors.teal,
                height: 80.0,
                child: Center(
                  child: Text(
                    'Right Panel',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        );
      } else {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: Colors.green,
              height: 60.0,
              child: Center(
                child: Text('Top Panel', style: TextStyle(color: Colors.white)),
              ),
            ),
            SizedBox(height: 8.0),
            Container(
              color: Colors.teal,
              height: 60.0,
              child: Center(
                child: Text(
                  'Bottom Panel',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        );
      }
    },
  );
  print('LayoutBuilder responsive layout created');

  // Test LayoutBuilder with percentage-based sizing
  final percentSizing = LayoutBuilder(
    builder: (BuildContext ctx, BoxConstraints constraints) {
      final halfWidth = constraints.maxWidth * 0.5;
      print('LayoutBuilder half width: $halfWidth');
      return Container(
        width: halfWidth,
        height: 60.0,
        color: Colors.orange,
        child: Center(
          child: Text('50% width', style: TextStyle(color: Colors.white)),
        ),
      );
    },
  );
  print('LayoutBuilder with percentage sizing created');

  // Test LayoutBuilder inside constrained parent
  final constrainedParent = SizedBox(
    width: 200.0,
    height: 100.0,
    child: LayoutBuilder(
      builder: (BuildContext ctx, BoxConstraints constraints) {
        print('Constrained LayoutBuilder: $constraints');
        return Container(
          color: Colors.purple,
          child: Center(
            child: Text(
              '${constraints.maxWidth.toInt()}x${constraints.maxHeight.toInt()}',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    ),
  );
  print('LayoutBuilder inside constrained SizedBox created');

  // Test LayoutBuilder with hasInfiniteWidth check
  final infiniteCheck = LayoutBuilder(
    builder: (BuildContext ctx, BoxConstraints constraints) {
      final isUnbounded = constraints.maxWidth == double.infinity;
      print('LayoutBuilder hasBoundedWidth: ${constraints.hasBoundedWidth}');
      return Container(
        width: isUnbounded ? 200.0 : constraints.maxWidth,
        height: 60.0,
        color: Colors.red,
        child: Center(
          child: Text(
            'Bounded: ${constraints.hasBoundedWidth}',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    },
  );
  print('LayoutBuilder with infinity check created');

  // Test LayoutBuilder returning different child counts
  final dynamicChildren = LayoutBuilder(
    builder: (BuildContext ctx, BoxConstraints constraints) {
      final itemWidth = 80.0;
      final count = (constraints.maxWidth / itemWidth).floor();
      print('LayoutBuilder can fit $count items');
      final items = <Widget>[];
      for (int i = 0; i < count; i = i + 1) {
        items.add(
          Container(
            width: itemWidth - 4.0,
            height: 40.0,
            margin: EdgeInsets.all(2.0),
            color: Colors.primaries[i % Colors.primaries.length],
            child: Center(
              child: Text('${i + 1}', style: TextStyle(color: Colors.white)),
            ),
          ),
        );
      }
      return Row(children: items);
    },
  );
  print('LayoutBuilder with dynamic children created');

  print('LayoutBuilder test completed');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'LayoutBuilder Test',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.0),
        Text(
          'Constraint Check:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        constraintCheck,
        SizedBox(height: 8.0),
        Text(
          'Responsive Layout:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        responsiveLayout,
        SizedBox(height: 8.0),
        Text(
          'Percentage Sizing:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        percentSizing,
        SizedBox(height: 8.0),
        Text(
          'Constrained Parent (200x100):',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        constrainedParent,
        SizedBox(height: 8.0),
        Text('Bounded Check:', style: TextStyle(fontWeight: FontWeight.bold)),
        infiniteCheck,
        SizedBox(height: 8.0),
        Text(
          'Dynamic Children:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        dynamicChildren,
        SizedBox(height: 16.0),
        Text('Key Points:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• LayoutBuilder provides parent constraints'),
        Text('• Use maxWidth/maxHeight for responsive UIs'),
        Text('• hasBoundedWidth checks for infinite constraints'),
        Text('• Great for percentage-based layouts'),
        Text('• Rebuilds when constraints change'),
      ],
    ),
  );
}
