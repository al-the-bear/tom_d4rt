// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests SlideTransition from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SlideTransition test executing');

  // Test SlideTransition at origin (no offset)
  final slideOrigin = SlideTransition(
    position: AlwaysStoppedAnimation(Offset(0.0, 0.0)),
    child: Container(
      width: 200.0,
      height: 60.0,
      color: Colors.blue,
      child: Center(
        child: Text('Offset(0, 0)', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('SlideTransition at origin created');

  // Test SlideTransition offset right by 0.5
  final slideRight = SlideTransition(
    position: AlwaysStoppedAnimation(Offset(0.5, 0.0)),
    child: Container(
      width: 200.0,
      height: 60.0,
      color: Colors.green,
      child: Center(
        child: Text('Offset(0.5, 0)', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('SlideTransition offset right 0.5 created');

  // Test SlideTransition offset left by -0.5
  final slideLeft = SlideTransition(
    position: AlwaysStoppedAnimation(Offset(-0.5, 0.0)),
    child: Container(
      width: 200.0,
      height: 60.0,
      color: Colors.orange,
      child: Center(
        child: Text('Offset(-0.5, 0)', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('SlideTransition offset left -0.5 created');

  // Test SlideTransition offset down by 0.5
  final slideDown = SlideTransition(
    position: AlwaysStoppedAnimation(Offset(0.0, 0.5)),
    child: Container(
      width: 200.0,
      height: 60.0,
      color: Colors.purple,
      child: Center(
        child: Text('Offset(0, 0.5)', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('SlideTransition offset down 0.5 created');

  // Test SlideTransition offset up by -0.5
  final slideUp = SlideTransition(
    position: AlwaysStoppedAnimation(Offset(0.0, -0.5)),
    child: Container(
      width: 200.0,
      height: 60.0,
      color: Colors.red,
      child: Center(
        child: Text('Offset(0, -0.5)', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('SlideTransition offset up -0.5 created');

  // Test SlideTransition diagonal
  final slideDiagonal = SlideTransition(
    position: AlwaysStoppedAnimation(Offset(0.3, 0.3)),
    child: Container(
      width: 200.0,
      height: 60.0,
      color: Colors.teal,
      child: Center(
        child: Text('Offset(0.3, 0.3)', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('SlideTransition diagonal offset created');

  // Test SlideTransition with full width offset
  final slideFullRight = SlideTransition(
    position: AlwaysStoppedAnimation(Offset(1.0, 0.0)),
    child: Container(
      width: 200.0,
      height: 60.0,
      color: Colors.indigo,
      child: Center(
        child: Text('Offset(1.0, 0)', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('SlideTransition full right offset created');

  // Test SlideTransition with textDirection RTL
  final slideRtl = SlideTransition(
    position: AlwaysStoppedAnimation(Offset(0.5, 0.0)),
    textDirection: TextDirection.rtl,
    child: Container(
      width: 200.0,
      height: 60.0,
      color: Colors.brown,
      child: Center(
        child: Text(
          'RTL + Offset(0.5, 0)',
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
  );
  print('SlideTransition with textDirection=RTL created');

  // Test SlideTransition with textDirection LTR
  final slideLtr = SlideTransition(
    position: AlwaysStoppedAnimation(Offset(0.5, 0.0)),
    textDirection: TextDirection.ltr,
    child: Container(
      width: 200.0,
      height: 60.0,
      color: Colors.cyan,
      child: Center(
        child: Text(
          'LTR + Offset(0.5, 0)',
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
  );
  print('SlideTransition with textDirection=LTR created');

  print('SlideTransition test completed');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'SlideTransition Test',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.0),
        Text('Origin (0, 0):', style: TextStyle(fontWeight: FontWeight.bold)),
        slideOrigin,
        SizedBox(height: 8.0),
        Text('Right (0.5, 0):', style: TextStyle(fontWeight: FontWeight.bold)),
        slideRight,
        SizedBox(height: 8.0),
        Text('Left (-0.5, 0):', style: TextStyle(fontWeight: FontWeight.bold)),
        slideLeft,
        SizedBox(height: 8.0),
        Text('Down (0, 0.5):', style: TextStyle(fontWeight: FontWeight.bold)),
        slideDown,
        SizedBox(height: 8.0),
        Text('Up (0, -0.5):', style: TextStyle(fontWeight: FontWeight.bold)),
        slideUp,
        SizedBox(height: 8.0),
        Text(
          'Diagonal (0.3, 0.3):',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        slideDiagonal,
        SizedBox(height: 8.0),
        Text(
          'Full right (1.0, 0):',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        slideFullRight,
        SizedBox(height: 8.0),
        Text('RTL direction:', style: TextStyle(fontWeight: FontWeight.bold)),
        slideRtl,
        SizedBox(height: 8.0),
        Text('LTR direction:', style: TextStyle(fontWeight: FontWeight.bold)),
        slideLtr,
        SizedBox(height: 16.0),
        Text('Key Points:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• SlideTransition uses Animation<Offset>'),
        Text('• Offset is in fractions of child size'),
        Text('• (1.0, 0) moves one full width to the right'),
        Text('• textDirection affects horizontal slide direction'),
        Text('• AlwaysStoppedAnimation for static positioning'),
      ],
    ),
  );
}
