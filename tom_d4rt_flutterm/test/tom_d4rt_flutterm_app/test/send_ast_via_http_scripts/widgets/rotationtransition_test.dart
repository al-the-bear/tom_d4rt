// D4rt test script: Tests RotationTransition, SizeTransition, PositionedTransition, DecoratedBoxTransition from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RotationTransition/SizeTransition/PositionedTransition/DecoratedBoxTransition test executing');

  // ========== ROTATIONTRANSITION ==========
  print('--- RotationTransition Tests ---');

  // Test RotationTransition at 0 turns (no rotation)
  final rotateZero = RotationTransition(
    turns: AlwaysStoppedAnimation(0.0),
    child: Container(
      width: 80.0,
      height: 80.0,
      color: Colors.blue,
      child: Center(child: Text('0', style: TextStyle(color: Colors.white, fontSize: 20.0))),
    ),
  );
  print('RotationTransition turns=0.0 created');

  // Test RotationTransition at 0.25 turns (90 degrees)
  final rotateQuarter = RotationTransition(
    turns: AlwaysStoppedAnimation(0.25),
    child: Container(
      width: 80.0,
      height: 80.0,
      color: Colors.green,
      child: Center(child: Text('90', style: TextStyle(color: Colors.white, fontSize: 20.0))),
    ),
  );
  print('RotationTransition turns=0.25 (90 deg) created');

  // Test RotationTransition at 0.5 turns (180 degrees)
  final rotateHalf = RotationTransition(
    turns: AlwaysStoppedAnimation(0.5),
    child: Container(
      width: 80.0,
      height: 80.0,
      color: Colors.red,
      child: Center(child: Text('180', style: TextStyle(color: Colors.white, fontSize: 20.0))),
    ),
  );
  print('RotationTransition turns=0.5 (180 deg) created');

  // Test RotationTransition at 0.75 turns (270 degrees)
  final rotateThreeQuarter = RotationTransition(
    turns: AlwaysStoppedAnimation(0.75),
    child: Container(
      width: 80.0,
      height: 80.0,
      color: Colors.orange,
      child: Center(child: Text('270', style: TextStyle(color: Colors.white, fontSize: 20.0))),
    ),
  );
  print('RotationTransition turns=0.75 (270 deg) created');

  // Test RotationTransition with alignment
  final rotateAligned = RotationTransition(
    turns: AlwaysStoppedAnimation(0.125),
    alignment: Alignment.topLeft,
    child: Container(
      width: 80.0,
      height: 80.0,
      color: Colors.purple,
      child: Center(child: Text('TL', style: TextStyle(color: Colors.white, fontSize: 16.0))),
    ),
  );
  print('RotationTransition with alignment=topLeft created');

  // ========== SIZETRANSITION ==========
  print('--- SizeTransition Tests ---');

  // Test SizeTransition at full size
  final sizeFull = SizeTransition(
    sizeFactor: AlwaysStoppedAnimation(1.0),
    child: Container(
      width: 200.0,
      height: 60.0,
      color: Colors.teal,
      child: Center(child: Text('Full size', style: TextStyle(color: Colors.white))),
    ),
  );
  print('SizeTransition sizeFactor=1.0 created');

  // Test SizeTransition at half size
  final sizeHalf = SizeTransition(
    sizeFactor: AlwaysStoppedAnimation(0.5),
    child: Container(
      width: 200.0,
      height: 60.0,
      color: Colors.indigo,
      child: Center(child: Text('Half size', style: TextStyle(color: Colors.white))),
    ),
  );
  print('SizeTransition sizeFactor=0.5 created');

  // Test SizeTransition at zero size
  final sizeZero = SizeTransition(
    sizeFactor: AlwaysStoppedAnimation(0.0),
    child: Container(
      width: 200.0,
      height: 60.0,
      color: Colors.red,
      child: Center(child: Text('Zero', style: TextStyle(color: Colors.white))),
    ),
  );
  print('SizeTransition sizeFactor=0.0 created');

  // Test SizeTransition with horizontal axis
  final sizeHorizontal = SizeTransition(
    sizeFactor: AlwaysStoppedAnimation(0.75),
    axis: Axis.horizontal,
    child: Container(
      width: 200.0,
      height: 60.0,
      color: Colors.brown,
      child: Center(child: Text('Horizontal 0.75', style: TextStyle(color: Colors.white))),
    ),
  );
  print('SizeTransition horizontal axis, sizeFactor=0.75 created');

  // Test SizeTransition with axisAlignment
  final sizeAligned = SizeTransition(
    sizeFactor: AlwaysStoppedAnimation(0.5),
    axisAlignment: -1.0,
    child: Container(
      width: 200.0,
      height: 60.0,
      color: Colors.amber,
      child: Center(child: Text('Aligned -1.0', style: TextStyle(color: Colors.black))),
    ),
  );
  print('SizeTransition with axisAlignment=-1.0 created');

  // ========== POSITIONEDTRANSITION ==========
  print('--- PositionedTransition Tests ---');

  // Test PositionedTransition at a static position
  final posBasic = Stack(
    children: [
      Container(width: 300.0, height: 100.0, color: Colors.grey),
      PositionedTransition(
        rect: AlwaysStoppedAnimation(RelativeRect.fromLTRB(10.0, 10.0, 190.0, 40.0)),
        child: Container(
          color: Colors.blue,
          child: Center(child: Text('Pos 10,10', style: TextStyle(color: Colors.white))),
        ),
      ),
    ],
  );
  print('PositionedTransition at static position created');

  // Test PositionedTransition centered
  final posCentered = Stack(
    children: [
      Container(width: 300.0, height: 100.0, color: Colors.grey),
      PositionedTransition(
        rect: AlwaysStoppedAnimation(RelativeRect.fromLTRB(50.0, 20.0, 50.0, 20.0)),
        child: Container(
          color: Colors.green,
          child: Center(child: Text('Centered', style: TextStyle(color: Colors.white))),
        ),
      ),
    ],
  );
  print('PositionedTransition centered created');

  // Test PositionedTransition at bottom-right
  final posBottomRight = Stack(
    children: [
      Container(width: 300.0, height: 100.0, color: Colors.grey),
      PositionedTransition(
        rect: AlwaysStoppedAnimation(RelativeRect.fromLTRB(200.0, 60.0, 10.0, 10.0)),
        child: Container(
          color: Colors.red,
          child: Center(child: Text('BR', style: TextStyle(color: Colors.white))),
        ),
      ),
    ],
  );
  print('PositionedTransition at bottom-right created');

  // ========== DECORATEDBOXTRANSITION ==========
  print('--- DecoratedBoxTransition Tests ---');

  // Test DecoratedBoxTransition with basic decoration
  final decoBasic = DecoratedBoxTransition(
    decoration: AlwaysStoppedAnimation(BoxDecoration(
      color: Colors.blue,
      borderRadius: BorderRadius.circular(8.0),
    )),
    child: Container(
      width: 200.0,
      height: 60.0,
      child: Center(child: Text('Basic deco', style: TextStyle(color: Colors.white))),
    ),
  );
  print('DecoratedBoxTransition basic created');

  // Test DecoratedBoxTransition with border
  final decoBorder = DecoratedBoxTransition(
    decoration: AlwaysStoppedAnimation(BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Colors.green, width: 3.0),
      borderRadius: BorderRadius.circular(12.0),
    )),
    child: Container(
      width: 200.0,
      height: 60.0,
      child: Center(child: Text('Bordered deco')),
    ),
  );
  print('DecoratedBoxTransition with border created');

  // Test DecoratedBoxTransition with shadow
  final decoShadow = DecoratedBoxTransition(
    decoration: AlwaysStoppedAnimation(BoxDecoration(
      color: Colors.orange,
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 8.0,
          offset: Offset(2.0, 4.0),
        ),
      ],
    )),
    child: Container(
      width: 200.0,
      height: 60.0,
      child: Center(child: Text('Shadow deco', style: TextStyle(color: Colors.white))),
    ),
  );
  print('DecoratedBoxTransition with shadow created');

  // Test DecoratedBoxTransition with position=foreground
  final decoForeground = DecoratedBoxTransition(
    decoration: AlwaysStoppedAnimation(BoxDecoration(
      border: Border.all(color: Colors.red, width: 4.0),
      borderRadius: BorderRadius.circular(8.0),
    )),
    position: DecorationPosition.foreground,
    child: Container(
      width: 200.0,
      height: 60.0,
      color: Colors.yellow,
      child: Center(child: Text('Foreground deco')),
    ),
  );
  print('DecoratedBoxTransition foreground position created');

  print('All RotationTransition/SizeTransition/PositionedTransition/DecoratedBoxTransition tests completed');

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('=== RotationTransition Tests ===', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
        SizedBox(height: 8.0),
        Text('0 turns:', style: TextStyle(fontWeight: FontWeight.bold)),
        Center(child: rotateZero),
        SizedBox(height: 8.0),
        Text('0.25 turns (90 deg):', style: TextStyle(fontWeight: FontWeight.bold)),
        Center(child: rotateQuarter),
        SizedBox(height: 8.0),
        Text('0.5 turns (180 deg):', style: TextStyle(fontWeight: FontWeight.bold)),
        Center(child: rotateHalf),
        SizedBox(height: 8.0),
        Text('0.75 turns (270 deg):', style: TextStyle(fontWeight: FontWeight.bold)),
        Center(child: rotateThreeQuarter),
        SizedBox(height: 8.0),
        Text('TopLeft alignment:', style: TextStyle(fontWeight: FontWeight.bold)),
        Center(child: SizedBox(width: 120.0, height: 120.0, child: rotateAligned)),
        SizedBox(height: 16.0),
        Text('=== SizeTransition Tests ===', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
        SizedBox(height: 8.0),
        Text('Full size (1.0):', style: TextStyle(fontWeight: FontWeight.bold)),
        sizeFull,
        SizedBox(height: 8.0),
        Text('Half size (0.5):', style: TextStyle(fontWeight: FontWeight.bold)),
        sizeHalf,
        SizedBox(height: 8.0),
        Text('Zero size (0.0):', style: TextStyle(fontWeight: FontWeight.bold)),
        sizeZero,
        SizedBox(height: 8.0),
        Text('Horizontal axis (0.75):', style: TextStyle(fontWeight: FontWeight.bold)),
        sizeHorizontal,
        SizedBox(height: 8.0),
        Text('Axis alignment -1.0:', style: TextStyle(fontWeight: FontWeight.bold)),
        sizeAligned,
        SizedBox(height: 16.0),
        Text('=== PositionedTransition Tests ===', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
        SizedBox(height: 8.0),
        Text('Top-left position:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(width: 300.0, height: 100.0, child: posBasic),
        SizedBox(height: 8.0),
        Text('Centered:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(width: 300.0, height: 100.0, child: posCentered),
        SizedBox(height: 8.0),
        Text('Bottom-right:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(width: 300.0, height: 100.0, child: posBottomRight),
        SizedBox(height: 16.0),
        Text('=== DecoratedBoxTransition Tests ===', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
        SizedBox(height: 8.0),
        Text('Basic:', style: TextStyle(fontWeight: FontWeight.bold)),
        decoBasic,
        SizedBox(height: 8.0),
        Text('Bordered:', style: TextStyle(fontWeight: FontWeight.bold)),
        decoBorder,
        SizedBox(height: 8.0),
        Text('Shadow:', style: TextStyle(fontWeight: FontWeight.bold)),
        decoShadow,
        SizedBox(height: 8.0),
        Text('Foreground position:', style: TextStyle(fontWeight: FontWeight.bold)),
        decoForeground,
        SizedBox(height: 16.0),
        Text('Key Points:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• RotationTransition rotates child by turns (0.0 to 1.0)'),
        Text('• SizeTransition clips child by sizeFactor along an axis'),
        Text('• PositionedTransition animates position within a Stack'),
        Text('• DecoratedBoxTransition animates box decoration'),
        Text('• All use AlwaysStoppedAnimation for static testing'),
      ],
    ),
  );
}
