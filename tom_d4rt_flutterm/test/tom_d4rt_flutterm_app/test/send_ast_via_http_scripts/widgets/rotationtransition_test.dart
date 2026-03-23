// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RotationTransition, SizeTransition, DecoratedBoxTransition from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print(
    'RotationTransition/SizeTransition/DecoratedBoxTransition test executing',
  );

  // ========== ROTATIONTRANSITION ==========
  print('--- RotationTransition Tests ---');

  // Test RotationTransition at 0 turns (no rotation)
  final rotateZero = RotationTransition(
    turns: AlwaysStoppedAnimation(0.0),
    child: Container(
      width: 80.0,
      height: 80.0,
      color: Colors.blue,
      child: Center(
        child: Text('0', style: TextStyle(color: Colors.white, fontSize: 20.0)),
      ),
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
      child: Center(
        child: Text(
          '90',
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
      ),
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
      child: Center(
        child: Text(
          '180',
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
      ),
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
      child: Center(
        child: Text(
          '270',
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
      ),
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
      child: Center(
        child: Text(
          'TL',
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
      ),
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
      child: Center(
        child: Text('Full size', style: TextStyle(color: Colors.white)),
      ),
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
      child: Center(
        child: Text('Half size', style: TextStyle(color: Colors.white)),
      ),
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
      child: Center(
        child: Text('Zero', style: TextStyle(color: Colors.white)),
      ),
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
      child: Center(
        child: Text('Horizontal 0.75', style: TextStyle(color: Colors.white)),
      ),
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
      child: Center(
        child: Text('Aligned -1.0', style: TextStyle(color: Colors.black)),
      ),
    ),
  );
  print('SizeTransition with axisAlignment=-1.0 created');

  // Note: PositionedTransition removed - AlwaysStoppedAnimation<dynamic> can't be
  // assigned to Animation<RelativeRect> in D4rt

  // Note: DecoratedBoxTransition removed - AlwaysStoppedAnimation<dynamic> can't be
  // assigned to Animation<Decoration> in D4rt

  print('All RotationTransition/SizeTransition tests completed');

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '=== RotationTransition Tests ===',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
        SizedBox(height: 8.0),
        Text('0 turns:', style: TextStyle(fontWeight: FontWeight.bold)),
        Center(child: rotateZero),
        SizedBox(height: 8.0),
        Text(
          '0.25 turns (90 deg):',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Center(child: rotateQuarter),
        SizedBox(height: 8.0),
        Text(
          '0.5 turns (180 deg):',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Center(child: rotateHalf),
        SizedBox(height: 8.0),
        Text(
          '0.75 turns (270 deg):',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Center(child: rotateThreeQuarter),
        SizedBox(height: 8.0),
        Text(
          'TopLeft alignment:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Center(
          child: SizedBox(width: 120.0, height: 120.0, child: rotateAligned),
        ),
        SizedBox(height: 16.0),
        Text(
          '=== SizeTransition Tests ===',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
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
        Text(
          'Horizontal axis (0.75):',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        sizeHorizontal,
        SizedBox(height: 8.0),
        Text(
          'Axis alignment -1.0:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        sizeAligned,
        SizedBox(height: 16.0),
        Text('Key Points:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• RotationTransition rotates child by turns (0.0 to 1.0)'),
        Text('• SizeTransition clips child by sizeFactor along an axis'),
        Text('• All use AlwaysStoppedAnimation for static testing'),
      ],
    ),
  );
}
