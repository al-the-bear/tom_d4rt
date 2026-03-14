// D4rt test script: Tests BoxBorder abstract and Border concrete class from painting
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('BoxBorder test executing');
  final results = <String>[];

  // ========== Border (concrete implementation of BoxBorder) Tests ==========
  print('Testing Border class (BoxBorder implementation)...');

  // Test 1: Default Border.all constructor
  final border1 = Border.all(color: Color(0xFF000000), width: 1.0);
  assert(border1.top.width == 1.0, 'Top border width should be 1.0');
  assert(border1.bottom.width == 1.0, 'Bottom border width should be 1.0');
  assert(border1.left.width == 1.0, 'Left border width should be 1.0');
  assert(border1.right.width == 1.0, 'Right border width should be 1.0');
  results.add('Border.all: width=${border1.top.width}');
  print('Border.all: width=${border1.top.width}');

  // Test 2: Border.all with custom width
  final border2 = Border.all(color: Color(0xFFFF0000), width: 2.5);
  assert(border2.top.width == 2.5, 'Border width should be 2.5');
  assert(border2.top.color == Color(0xFFFF0000), 'Border color should be red');
  results.add(
    'Border.all custom: width=${border2.top.width}, color=${border2.top.color}',
  );
  print('Border.all custom width verified');

  // Test 3: Border with individual sides
  final border3 = Border(
    top: BorderSide(color: Color(0xFFFF0000), width: 1.0),
    bottom: BorderSide(color: Color(0xFF00FF00), width: 2.0),
    left: BorderSide(color: Color(0xFF0000FF), width: 3.0),
    right: BorderSide(color: Color(0xFFFFFF00), width: 4.0),
  );
  assert(border3.top.width == 1.0, 'Top should be 1.0');
  assert(border3.bottom.width == 2.0, 'Bottom should be 2.0');
  assert(border3.left.width == 3.0, 'Left should be 3.0');
  assert(border3.right.width == 4.0, 'Right should be 4.0');
  results.add('Border individual sides: verified');
  print('Border individual sides verified');

  // Test 4: Border.symmetric constructor
  final border4 = Border.symmetric(
    vertical: BorderSide(color: Color(0xFFFF0000), width: 2.0),
    horizontal: BorderSide(color: Color(0xFF0000FF), width: 3.0),
  );
  assert(border4.top.width == 2.0, 'Vertical top should be 2.0');
  assert(border4.bottom.width == 2.0, 'Vertical bottom should be 2.0');
  assert(border4.left.width == 3.0, 'Horizontal left should be 3.0');
  assert(border4.right.width == 3.0, 'Horizontal right should be 3.0');
  results.add(
    'Border.symmetric: vertical=${border4.top.width}, horizontal=${border4.left.width}',
  );
  print('Border.symmetric verified');

  // Test 5: Border dimensions calculation
  final border5 = Border.all(width: 5.0);
  final dimensions = border5.dimensions;
  assert(dimensions.horizontal == 10.0, 'Horizontal dimensions should be 10.0');
  assert(dimensions.vertical == 10.0, 'Vertical dimensions should be 10.0');
  results.add(
    'Border dimensions: h=${dimensions.horizontal}, v=${dimensions.vertical}',
  );
  print('Border dimensions: ${dimensions}');

  // Test 6: Border isUniform check
  final uniformBorder = Border.all(color: Color(0xFF000000), width: 2.0);
  assert(uniformBorder.isUniform == true, 'Border.all should be uniform');
  results.add('Border isUniform: ${uniformBorder.isUniform}');
  print('Border isUniform: ${uniformBorder.isUniform}');

  // Test 7: Border with BorderSide.none
  final borderWithNone = Border(
    top: BorderSide(color: Color(0xFFFF0000), width: 1.0),
    bottom: BorderSide.none,
    left: BorderSide.none,
    right: BorderSide.none,
  );
  assert(borderWithNone.bottom == BorderSide.none, 'Bottom should be none');
  results.add('Border with none sides: verified');
  print('Border with BorderSide.none verified');

  // Test 8: Border scale method
  final scaledBorder = border1.scale(2.0);
  assert(scaledBorder.top.width == 2.0, 'Scaled width should be 2.0');
  results.add('Border scaled: ${scaledBorder.top.width}');
  print('Border scale: ${scaledBorder.top.width}');

  // Test 9: BorderSide styles
  final solidBorder = BorderSide(
    color: Color(0xFF000000),
    width: 1.0,
    style: BorderStyle.solid,
  );
  assert(solidBorder.style == BorderStyle.solid, 'Style should be solid');
  results.add('BorderSide style: ${solidBorder.style}');
  print('BorderSide style: ${solidBorder.style}');

  // Test 10: Border equality
  final borderA = Border.all(color: Color(0xFF000000), width: 1.0);
  final borderB = Border.all(color: Color(0xFF000000), width: 1.0);
  assert(borderA == borderB, 'Equal borders should be equal');
  results.add('Border equality: ${borderA == borderB}');
  print('Border equality verified');

  // Test 11: Border hashCode
  final hashA = borderA.hashCode;
  final hashB = borderB.hashCode;
  assert(hashA == hashB, 'Equal borders should have same hashCode');
  results.add('Border hashCode: $hashA == $hashB');
  print('Border hashCode verified');

  // Test 12: Border add operation
  final addedBorder = Border.all(
    width: 1.0,
  ).add(Border.all(width: 1.0), reversed: false);
  results.add('Border add: $addedBorder');
  print('Border add operation tested');

  print('BoxBorder test completed with ${results.length} tests');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('BoxBorder Tests (Border implementation)'),
      Text('Tests passed: ${results.length}'),
      ...results.take(5).map((r) => Text(r, style: TextStyle(fontSize: 10))),
    ],
  );
}
