// D4rt test script: Tests DecoratedBox, ColoredBox, RotatedBox from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DecoratedBox test executing');

  // Test DecoratedBox with BoxDecoration color
  final decoratedColor = DecoratedBox(
    decoration: BoxDecoration(
      color: Colors.blue,
    ),
    child: SizedBox(
      width: 200.0,
      height: 60.0,
      child: Center(
        child: Text('DecoratedBox color', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('DecoratedBox with color created');

  // Test DecoratedBox with border radius
  final decoratedRounded = DecoratedBox(
    decoration: BoxDecoration(
      color: Colors.green,
      borderRadius: BorderRadius.circular(16.0),
    ),
    child: SizedBox(
      width: 200.0,
      height: 60.0,
      child: Center(
        child: Text('Rounded', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('DecoratedBox with borderRadius created');

  // Test DecoratedBox with border
  final decoratedBorder = DecoratedBox(
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Colors.orange, width: 3.0),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: SizedBox(
      width: 200.0,
      height: 60.0,
      child: Center(
        child: Text('With border', style: TextStyle(color: Colors.orange)),
      ),
    ),
  );
  print('DecoratedBox with border created');

  // Test DecoratedBox with box shadow
  final decoratedShadow = DecoratedBox(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 8.0,
          offset: Offset(2.0, 4.0),
        ),
      ],
    ),
    child: SizedBox(
      width: 200.0,
      height: 60.0,
      child: Center(
        child: Text('With shadow'),
      ),
    ),
  );
  print('DecoratedBox with boxShadow created');

  // Test DecoratedBox with gradient
  final decoratedGradient = DecoratedBox(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.purple, Colors.blue, Colors.cyan],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: SizedBox(
      width: 200.0,
      height: 60.0,
      child: Center(
        child: Text('Gradient', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('DecoratedBox with gradient created');

  // Test DecoratedBox with circle shape
  final decoratedCircle = DecoratedBox(
    decoration: BoxDecoration(
      color: Colors.red,
      shape: BoxShape.circle,
    ),
    child: SizedBox(
      width: 80.0,
      height: 80.0,
      child: Center(
        child: Text('Circle', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('DecoratedBox with circle shape created');

  // Test DecoratedBox with foreground decoration
  final decoratedForeground = DecoratedBox(
    decoration: BoxDecoration(color: Colors.blue),
    position: DecorationPosition.background,
    child: SizedBox(
      width: 200.0,
      height: 60.0,
      child: Center(
        child: Text('Background', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('DecoratedBox with background position created');

  // Test ColoredBox with color
  final coloredBoxBasic = ColoredBox(
    color: Colors.teal,
    child: SizedBox(
      width: 200.0,
      height: 60.0,
      child: Center(
        child: Text('ColoredBox', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('ColoredBox with teal color created');

  // Test ColoredBox with different colors
  final coloredBoxRed = ColoredBox(
    color: Colors.red,
    child: SizedBox(
      width: 200.0,
      height: 60.0,
      child: Center(
        child: Text('Red ColoredBox', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('ColoredBox with red color created');

  // Test ColoredBox with opacity
  final coloredBoxOpacity = ColoredBox(
    color: Color.fromRGBO(0, 0, 255, 0.5),
    child: SizedBox(
      width: 200.0,
      height: 60.0,
      child: Center(
        child: Text('Semi-transparent'),
      ),
    ),
  );
  print('ColoredBox with semi-transparent color created');

  // Test RotatedBox with quarterTurns 1
  final rotated1 = RotatedBox(
    quarterTurns: 1,
    child: Container(
      width: 80.0,
      height: 40.0,
      color: Colors.indigo,
      child: Center(
        child: Text('Turn 1', style: TextStyle(color: Colors.white, fontSize: 12.0)),
      ),
    ),
  );
  print('RotatedBox with quarterTurns=1 (90 degrees) created');

  // Test RotatedBox with quarterTurns 2
  final rotated2 = RotatedBox(
    quarterTurns: 2,
    child: Container(
      width: 80.0,
      height: 40.0,
      color: Colors.brown,
      child: Center(
        child: Text('Turn 2', style: TextStyle(color: Colors.white, fontSize: 12.0)),
      ),
    ),
  );
  print('RotatedBox with quarterTurns=2 (180 degrees) created');

  // Test RotatedBox with quarterTurns 3
  final rotated3 = RotatedBox(
    quarterTurns: 3,
    child: Container(
      width: 80.0,
      height: 40.0,
      color: Colors.pink,
      child: Center(
        child: Text('Turn 3', style: TextStyle(color: Colors.white, fontSize: 12.0)),
      ),
    ),
  );
  print('RotatedBox with quarterTurns=3 (270 degrees) created');

  // Test RotatedBox with quarterTurns 0 (no rotation)
  final rotated0 = RotatedBox(
    quarterTurns: 0,
    child: Container(
      width: 80.0,
      height: 40.0,
      color: Colors.amber,
      child: Center(
        child: Text('Turn 0', style: TextStyle(color: Colors.black, fontSize: 12.0)),
      ),
    ),
  );
  print('RotatedBox with quarterTurns=0 (no rotation) created');

  print('DecoratedBox test completed');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'DecoratedBox / ColoredBox / RotatedBox Test',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.0),
        Text('DecoratedBox - Color:', style: TextStyle(fontWeight: FontWeight.bold)),
        Center(child: decoratedColor),
        SizedBox(height: 8.0),
        Text('DecoratedBox - Rounded:', style: TextStyle(fontWeight: FontWeight.bold)),
        Center(child: decoratedRounded),
        SizedBox(height: 8.0),
        Text('DecoratedBox - Border:', style: TextStyle(fontWeight: FontWeight.bold)),
        Center(child: decoratedBorder),
        SizedBox(height: 8.0),
        Text('DecoratedBox - Shadow:', style: TextStyle(fontWeight: FontWeight.bold)),
        Center(child: decoratedShadow),
        SizedBox(height: 8.0),
        Text('DecoratedBox - Gradient:', style: TextStyle(fontWeight: FontWeight.bold)),
        Center(child: decoratedGradient),
        SizedBox(height: 8.0),
        Text('DecoratedBox - Circle:', style: TextStyle(fontWeight: FontWeight.bold)),
        Center(child: decoratedCircle),
        SizedBox(height: 16.0),
        Text('ColoredBox - Teal:', style: TextStyle(fontWeight: FontWeight.bold)),
        Center(child: coloredBoxBasic),
        SizedBox(height: 8.0),
        Text('ColoredBox - Red:', style: TextStyle(fontWeight: FontWeight.bold)),
        Center(child: coloredBoxRed),
        SizedBox(height: 8.0),
        Text('ColoredBox - Semi-transparent:', style: TextStyle(fontWeight: FontWeight.bold)),
        Center(child: coloredBoxOpacity),
        SizedBox(height: 16.0),
        Text('RotatedBox:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(children: [Text('0 turns'), SizedBox(height: 4.0), rotated0]),
            Column(children: [Text('1 turn'), SizedBox(height: 4.0), rotated1]),
            Column(children: [Text('2 turns'), SizedBox(height: 4.0), rotated2]),
            Column(children: [Text('3 turns'), SizedBox(height: 4.0), rotated3]),
          ],
        ),
        SizedBox(height: 16.0),
        Text('Key Points:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• DecoratedBox applies BoxDecoration'),
        Text('• Supports color, border, borderRadius, shadow, gradient'),
        Text('• ColoredBox is a simpler alternative for solid colors'),
        Text('• RotatedBox rotates child by 90-degree increments'),
        Text('• quarterTurns: 0=0, 1=90, 2=180, 3=270 degrees'),
      ],
    ),
  );
}
