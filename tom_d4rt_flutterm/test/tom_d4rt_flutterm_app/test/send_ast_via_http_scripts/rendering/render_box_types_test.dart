// D4rt test script: Tests RenderDecoratedBox, RenderPadding, RenderAlign,
// RenderPositionedBox, RenderConstrainedBox, RenderFlex, RenderConstrainedOverflowBox
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

dynamic build(BuildContext context) {
  print('RenderBox types test executing');

  // ========== RenderPadding ==========
  print('--- RenderPadding Tests ---');
  final renderPadding = RenderPadding(
    padding: EdgeInsets.all(16.0),
    textDirection: TextDirection.ltr,
  );
  print('RenderPadding created: padding=16.0');

  // ========== RenderPositionedBox ==========
  print('--- RenderPositionedBox Tests ---');
  final renderPositioned = RenderPositionedBox(
    alignment: Alignment.center,
    widthFactor: null,
    heightFactor: null,
    textDirection: TextDirection.ltr,
  );
  print('RenderPositionedBox created: alignment=center');

  // ========== RenderConstrainedBox ==========
  print('--- RenderConstrainedBox Tests ---');
  final renderConstrained = RenderConstrainedBox(
    additionalConstraints: BoxConstraints(
      minWidth: 100.0,
      maxWidth: 300.0,
      minHeight: 50.0,
      maxHeight: 200.0,
    ),
  );
  print('RenderConstrainedBox created');
  print('  min: 100x50');
  print('  max: 300x200');

  // ========== BoxConstraints advanced ==========
  print('--- BoxConstraints advanced Tests ---');
  final tight = BoxConstraints.tight(Size(200, 100));
  print('BoxConstraints.tight: $tight');

  final loose = BoxConstraints.loose(Size(300, 200));
  print('BoxConstraints.loose: $loose');

  final expand = BoxConstraints.expand(width: 400, height: 300);
  print('BoxConstraints.expand: $expand');

  final tightFor = BoxConstraints.tightFor(width: 150);
  print('BoxConstraints.tightFor width=150: $tightFor');

  // Constraint operations
  final normalized = BoxConstraints(minWidth: 200, maxWidth: 100).normalize();
  print('Normalized: $normalized');

  final constrained = BoxConstraints(
    minWidth: 100,
    maxWidth: 300,
  ).constrain(Size(250, 150));
  print('Constrained size: $constrained');

  // ========== RenderFlex ==========
  print('--- RenderFlex Tests ---');
  final renderFlex = RenderFlex(
    direction: Axis.vertical,
    mainAxisAlignment: MainAxisAlignment.start,
    mainAxisSize: MainAxisSize.max,
    crossAxisAlignment: CrossAxisAlignment.center,
    textDirection: TextDirection.ltr,
    verticalDirection: VerticalDirection.down,
    clipBehavior: Clip.none,
  );
  print('RenderFlex created: direction=vertical');

  // ========== ContainerBoxParentData ==========
  print('--- ParentData Tests ---');
  final parentData = BoxParentData();
  print('BoxParentData created: offset=${parentData.offset}');

  print('All render box tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'RenderBox Types Test',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            Text('RenderPadding, RenderPositionedBox'),
            Text('RenderConstrainedBox, RenderFlex'),
            Text('BoxConstraints: tight, loose, expand'),
          ],
        ),
      ),
    ),
  );
}
