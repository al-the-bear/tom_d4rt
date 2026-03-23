// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests AnimatedOpacity from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('AnimatedOpacity test executing');

  // Test AnimatedOpacity with opacity 0.0 (fully transparent)
  final opacity0 = AnimatedOpacity(
    opacity: 0.0,
    duration: Duration(milliseconds: 300),
    child: Container(
      color: Colors.blue,
      height: 60.0,
      child: Center(
        child: Text('Opacity 0.0', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('AnimatedOpacity(opacity=0.0) created - fully transparent');

  // Test AnimatedOpacity with opacity 0.5 (half transparent)
  final opacity50 = AnimatedOpacity(
    opacity: 0.5,
    duration: Duration(milliseconds: 300),
    child: Container(
      color: Colors.blue,
      height: 60.0,
      child: Center(
        child: Text('Opacity 0.5', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('AnimatedOpacity(opacity=0.5) created - half transparent');

  // Test AnimatedOpacity with opacity 1.0 (fully visible)
  final opacity100 = AnimatedOpacity(
    opacity: 1.0,
    duration: Duration(milliseconds: 300),
    child: Container(
      color: Colors.blue,
      height: 60.0,
      child: Center(
        child: Text('Opacity 1.0', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('AnimatedOpacity(opacity=1.0) created - fully visible');

  // Test AnimatedOpacity with longer duration
  final longDuration = AnimatedOpacity(
    opacity: 0.7,
    duration: Duration(milliseconds: 1000),
    child: Container(
      color: Colors.green,
      height: 60.0,
      child: Center(
        child: Text('1000ms duration', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('AnimatedOpacity with duration=1000ms created');

  // Test AnimatedOpacity with curve
  final withCurve = AnimatedOpacity(
    opacity: 0.8,
    duration: Duration(milliseconds: 500),
    curve: Curves.easeInOut,
    child: Container(
      color: Colors.orange,
      height: 60.0,
      child: Center(
        child: Text('easeInOut curve', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('AnimatedOpacity with curve=easeInOut created');

  // Test AnimatedOpacity with bounceIn curve
  final withBounceCurve = AnimatedOpacity(
    opacity: 0.6,
    duration: Duration(milliseconds: 600),
    curve: Curves.bounceIn,
    child: Container(
      color: Colors.purple,
      height: 60.0,
      child: Center(
        child: Text('bounceIn curve', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('AnimatedOpacity with curve=bounceIn created');

  // Test AnimatedOpacity with onEnd callback
  final withOnEnd = AnimatedOpacity(
    opacity: 0.9,
    duration: Duration(milliseconds: 400),
    onEnd: () {
      print('AnimatedOpacity animation ended');
    },
    child: Container(
      color: Colors.red,
      height: 60.0,
      child: Center(
        child: Text('With onEnd', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('AnimatedOpacity with onEnd callback created');

  // Test AnimatedOpacity with alwaysIncludeSemantics
  final withSemantics = AnimatedOpacity(
    opacity: 0.0,
    duration: Duration(milliseconds: 300),
    alwaysIncludeSemantics: true,
    child: Text('Semantics included'),
  );
  print('AnimatedOpacity with alwaysIncludeSemantics=true created');

  // Test AnimatedOpacity with decelerate curve
  final withDecelerate = AnimatedOpacity(
    opacity: 0.4,
    duration: Duration(milliseconds: 450),
    curve: Curves.decelerate,
    child: Container(
      color: Colors.teal,
      height: 60.0,
      child: Center(
        child: Text('decelerate', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('AnimatedOpacity with curve=decelerate created');

  print('AnimatedOpacity test completed');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'AnimatedOpacity Test',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.0),
        Text(
          'Opacity 0.0 (transparent):',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: opacity0,
        ),
        SizedBox(height: 8.0),
        Text('Opacity 0.5:', style: TextStyle(fontWeight: FontWeight.bold)),
        opacity50,
        SizedBox(height: 8.0),
        Text(
          'Opacity 1.0 (visible):',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        opacity100,
        SizedBox(height: 8.0),
        Text(
          'Long duration (1000ms):',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        longDuration,
        SizedBox(height: 8.0),
        Text(
          'With easeInOut curve:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        withCurve,
        SizedBox(height: 8.0),
        Text(
          'With bounceIn curve:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        withBounceCurve,
        SizedBox(height: 8.0),
        Text(
          'With onEnd callback:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        withOnEnd,
        SizedBox(height: 8.0),
        Text(
          'With decelerate curve:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        withDecelerate,
        SizedBox(height: 16.0),
        Text('Key Points:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• AnimatedOpacity is an implicit animation'),
        Text('• opacity: 0.0 (transparent) to 1.0 (visible)'),
        Text('• duration controls animation length'),
        Text('• curve controls animation easing'),
        Text('• onEnd fires when animation completes'),
        Text('• No AnimationController needed'),
      ],
    ),
  );
}
