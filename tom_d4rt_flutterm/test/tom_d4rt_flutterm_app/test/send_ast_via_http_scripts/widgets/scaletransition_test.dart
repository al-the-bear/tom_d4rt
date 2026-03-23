// ignore_for_file: avoid_print
// D4rt test script: Tests ScaleTransition from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ScaleTransition test executing');

  // Test ScaleTransition at full scale
  final scaleFull = ScaleTransition(
    scale: AlwaysStoppedAnimation(1.0),
    child: Container(
      width: 100.0,
      height: 60.0,
      color: Colors.blue,
      child: Center(
        child: Text('Scale 1.0', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('ScaleTransition scale=1.0 created');

  // Test ScaleTransition at half scale
  final scaleHalf = ScaleTransition(
    scale: AlwaysStoppedAnimation(0.5),
    child: Container(
      width: 100.0,
      height: 60.0,
      color: Colors.green,
      child: Center(
        child: Text(
          'Scale 0.5',
          style: TextStyle(color: Colors.white, fontSize: 10.0),
        ),
      ),
    ),
  );
  print('ScaleTransition scale=0.5 created');

  // Test ScaleTransition at zero (invisible)
  final scaleZero = ScaleTransition(
    scale: AlwaysStoppedAnimation(0.0),
    child: Container(
      width: 100.0,
      height: 60.0,
      color: Colors.red,
      child: Center(
        child: Text('Scale 0.0', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('ScaleTransition scale=0.0 created');

  // Test ScaleTransition at double scale
  final scaleDouble = ScaleTransition(
    scale: AlwaysStoppedAnimation(2.0),
    child: Container(
      width: 60.0,
      height: 30.0,
      color: Colors.orange,
      child: Center(
        child: Text(
          '2x',
          style: TextStyle(color: Colors.white, fontSize: 10.0),
        ),
      ),
    ),
  );
  print('ScaleTransition scale=2.0 created');

  // Test ScaleTransition at 0.75
  final scaleThreeQuarter = ScaleTransition(
    scale: AlwaysStoppedAnimation(0.75),
    child: Container(
      width: 100.0,
      height: 60.0,
      color: Colors.purple,
      child: Center(
        child: Text('Scale 0.75', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('ScaleTransition scale=0.75 created');

  // Test ScaleTransition with alignment topLeft
  final scaleTopLeft = ScaleTransition(
    scale: AlwaysStoppedAnimation(0.5),
    alignment: Alignment.topLeft,
    child: Container(
      width: 100.0,
      height: 60.0,
      color: Colors.teal,
      child: Center(
        child: Text(
          'TopLeft',
          style: TextStyle(color: Colors.white, fontSize: 10.0),
        ),
      ),
    ),
  );
  print('ScaleTransition with alignment=topLeft created');

  // Test ScaleTransition with alignment bottomRight
  final scaleBottomRight = ScaleTransition(
    scale: AlwaysStoppedAnimation(0.5),
    alignment: Alignment.bottomRight,
    child: Container(
      width: 100.0,
      height: 60.0,
      color: Colors.indigo,
      child: Center(
        child: Text(
          'BtmRight',
          style: TextStyle(color: Colors.white, fontSize: 10.0),
        ),
      ),
    ),
  );
  print('ScaleTransition with alignment=bottomRight created');

  // Test ScaleTransition with alignment center (default)
  final scaleCenter = ScaleTransition(
    scale: AlwaysStoppedAnimation(0.5),
    alignment: Alignment.center,
    child: Container(
      width: 100.0,
      height: 60.0,
      color: Colors.brown,
      child: Center(
        child: Text(
          'Center',
          style: TextStyle(color: Colors.white, fontSize: 10.0),
        ),
      ),
    ),
  );
  print('ScaleTransition with alignment=center created');

  // Test ScaleTransition with filterQuality
  final scaleFiltered = ScaleTransition(
    scale: AlwaysStoppedAnimation(1.5),
    filterQuality: FilterQuality.high,
    child: Container(
      width: 80.0,
      height: 50.0,
      color: Colors.cyan,
      child: Center(
        child: Text('HQ', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('ScaleTransition with filterQuality=high created');

  // Test ScaleTransition with low filterQuality
  final scaleLowFilter = ScaleTransition(
    scale: AlwaysStoppedAnimation(1.5),
    filterQuality: FilterQuality.low,
    child: Container(
      width: 80.0,
      height: 50.0,
      color: Colors.pink,
      child: Center(
        child: Text('LQ', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('ScaleTransition with filterQuality=low created');

  print('ScaleTransition test completed');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'ScaleTransition Test',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.0),
        Text(
          'Scale 1.0 (normal):',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Center(child: scaleFull),
        SizedBox(height: 8.0),
        Text('Scale 0.75:', style: TextStyle(fontWeight: FontWeight.bold)),
        Center(child: scaleThreeQuarter),
        SizedBox(height: 8.0),
        Text('Scale 0.5:', style: TextStyle(fontWeight: FontWeight.bold)),
        Center(child: scaleHalf),
        SizedBox(height: 8.0),
        Text(
          'Scale 0.0 (invisible):',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Container(
          height: 60.0,
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: Center(child: scaleZero),
        ),
        SizedBox(height: 8.0),
        Text('Scale 2.0:', style: TextStyle(fontWeight: FontWeight.bold)),
        Center(child: scaleDouble),
        SizedBox(height: 16.0),
        Text(
          'Alignment TopLeft:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: scaleTopLeft,
        ),
        SizedBox(height: 8.0),
        Text(
          'Alignment BottomRight:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: scaleBottomRight,
        ),
        SizedBox(height: 8.0),
        Text(
          'Alignment Center:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: scaleCenter,
        ),
        SizedBox(height: 8.0),
        Text(
          'High filter quality:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Center(child: scaleFiltered),
        SizedBox(height: 8.0),
        Text(
          'Low filter quality:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Center(child: scaleLowFilter),
        SizedBox(height: 16.0),
        Text('Key Points:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• ScaleTransition uses Animation<double> for scale'),
        Text('• 0.0 = invisible, 1.0 = normal, 2.0 = double size'),
        Text('• alignment controls the scale origin point'),
        Text('• filterQuality affects rendering quality'),
        Text('• AlwaysStoppedAnimation for static scale values'),
      ],
    ),
  );
}
