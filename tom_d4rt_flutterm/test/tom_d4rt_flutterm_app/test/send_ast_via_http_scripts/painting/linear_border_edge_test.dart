// D4rt test script: Tests LinearBorderEdge from painting
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('LinearBorderEdge test executing');
  final results = <String>[];

  // ========== LinearBorderEdge Tests ==========
  print('Testing LinearBorderEdge...');

  // Test 1: Default LinearBorderEdge
  final edge1 = LinearBorderEdge();
  assert(edge1.size == 1.0, 'Default size should be 1.0');
  assert(edge1.alignment == 0.0, 'Default alignment should be 0.0');
  results.add(
    'LinearBorderEdge default: size=${edge1.size}, align=${edge1.alignment}',
  );
  print(
    'LinearBorderEdge default: size=${edge1.size}, alignment=${edge1.alignment}',
  );

  // Test 2: LinearBorderEdge with custom size
  final edge2 = LinearBorderEdge(size: 0.5);
  assert(edge2.size == 0.5, 'Size should be 0.5');
  results.add('LinearBorderEdge size: ${edge2.size}');
  print('LinearBorderEdge size: ${edge2.size}');

  // Test 3: LinearBorderEdge with custom alignment
  final edge3 = LinearBorderEdge(alignment: 0.5);
  assert(edge3.alignment == 0.5, 'Alignment should be 0.5');
  results.add('LinearBorderEdge alignment: ${edge3.alignment}');
  print('LinearBorderEdge alignment: ${edge3.alignment}');

  // Test 4: LinearBorderEdge with both parameters
  final edge4 = LinearBorderEdge(size: 0.75, alignment: -1.0);
  assert(edge4.size == 0.75, 'Size should be 0.75');
  assert(edge4.alignment == -1.0, 'Alignment should be -1.0');
  results.add(
    'LinearBorderEdge full: size=${edge4.size}, align=${edge4.alignment}',
  );
  print(
    'LinearBorderEdge custom: size=${edge4.size}, alignment=${edge4.alignment}',
  );

  // Test 5: LinearBorderEdge alignment at start (-1.0)
  final edgeStart = LinearBorderEdge(size: 0.5, alignment: -1.0);
  assert(edgeStart.alignment == -1.0, 'Start alignment should be -1.0');
  results.add('LinearBorderEdge start align: ${edgeStart.alignment}');
  print('LinearBorderEdge start alignment verified');

  // Test 6: LinearBorderEdge alignment at center (0.0)
  final edgeCenter = LinearBorderEdge(size: 0.5, alignment: 0.0);
  assert(edgeCenter.alignment == 0.0, 'Center alignment should be 0.0');
  results.add('LinearBorderEdge center align: ${edgeCenter.alignment}');
  print('LinearBorderEdge center alignment verified');

  // Test 7: LinearBorderEdge alignment at end (1.0)
  final edgeEnd = LinearBorderEdge(size: 0.5, alignment: 1.0);
  assert(edgeEnd.alignment == 1.0, 'End alignment should be 1.0');
  results.add('LinearBorderEdge end align: ${edgeEnd.alignment}');
  print('LinearBorderEdge end alignment verified');

  // Test 8: LinearBorderEdge.none constant
  final edgeNone = LinearBorderEdge.none;
  assert(edgeNone.size == 0.0, 'None edge size should be 0.0');
  results.add('LinearBorderEdge.none: size=${edgeNone.size}');
  print('LinearBorderEdge.none: size=${edgeNone.size}');

  // Test 9: LinearBorderEdge lerp
  final edgeA = LinearBorderEdge(size: 0.0, alignment: -1.0);
  final edgeB = LinearBorderEdge(size: 1.0, alignment: 1.0);
  final lerped = LinearBorderEdge.lerp(edgeA, edgeB, 0.5);
  assert(lerped != null, 'Lerped edge should not be null');
  assert(lerped!.size == 0.5, 'Lerped size should be 0.5');
  assert(lerped.alignment == 0.0, 'Lerped alignment should be 0.0');
  results.add(
    'LinearBorderEdge lerp: size=${lerped.size}, align=${lerped.alignment}',
  );
  print(
    'LinearBorderEdge lerp: size=${lerped.size}, alignment=${lerped.alignment}',
  );

  // Test 10: LinearBorderEdge small size
  final edgeSmall = LinearBorderEdge(size: 0.1);
  assert(edgeSmall.size == 0.1, 'Small size should be 0.1');
  results.add('LinearBorderEdge small: ${edgeSmall.size}');
  print('LinearBorderEdge small size verified');

  // Test 11: LinearBorderEdge full size
  final edgeFull = LinearBorderEdge(size: 1.0);
  assert(edgeFull.size == 1.0, 'Full size should be 1.0');
  results.add('LinearBorderEdge full size: ${edgeFull.size}');
  print('LinearBorderEdge full size verified');

  // Test 12: LinearBorderEdge equality
  final eq1 = LinearBorderEdge(size: 0.5, alignment: 0.5);
  final eq2 = LinearBorderEdge(size: 0.5, alignment: 0.5);
  assert(eq1 == eq2, 'Equal edges should be equal');
  results.add('LinearBorderEdge equality: ${eq1 == eq2}');
  print('LinearBorderEdge equality verified');

  // Test 13: LinearBorderEdge inequality
  final ne1 = LinearBorderEdge(size: 0.5);
  final ne2 = LinearBorderEdge(size: 0.6);
  assert(ne1 != ne2, 'Different edges should not be equal');
  results.add('LinearBorderEdge inequality: ${ne1 != ne2}');
  print('LinearBorderEdge inequality verified');

  // Test 14: LinearBorderEdge hashCode
  final hash1 = eq1.hashCode;
  final hash2 = eq2.hashCode;
  assert(hash1 == hash2, 'Equal edges should have same hash');
  results.add('LinearBorderEdge hashCode: $hash1');
  print('LinearBorderEdge hashCode: $hash1');

  print('LinearBorderEdge test completed with ${results.length} tests');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('LinearBorderEdge Tests'),
      Text('Tests passed: ${results.length}'),
      ...results.take(5).map((r) => Text(r, style: TextStyle(fontSize: 10))),
    ],
  );
}
