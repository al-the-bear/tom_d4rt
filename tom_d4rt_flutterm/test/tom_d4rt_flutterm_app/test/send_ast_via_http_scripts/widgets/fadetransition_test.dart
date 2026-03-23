// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests FadeTransition from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('FadeTransition test executing');

  // Test FadeTransition with AlwaysStoppedAnimation at 0.5
  final fadeHalf = FadeTransition(
    opacity: AlwaysStoppedAnimation(0.5),
    child: Container(
      width: 200.0,
      height: 60.0,
      color: Colors.blue,
      child: Center(
        child: Text('Fade 0.5', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('FadeTransition with opacity=0.5 created');

  // Test FadeTransition with opacity 0.0 (transparent)
  final fadeZero = FadeTransition(
    opacity: AlwaysStoppedAnimation(0.0),
    child: Container(
      width: 200.0,
      height: 60.0,
      color: Colors.red,
      child: Center(
        child: Text('Fade 0.0', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('FadeTransition with opacity=0.0 created');

  // Test FadeTransition with opacity 1.0 (fully visible)
  final fadeFull = FadeTransition(
    opacity: AlwaysStoppedAnimation(1.0),
    child: Container(
      width: 200.0,
      height: 60.0,
      color: Colors.green,
      child: Center(
        child: Text('Fade 1.0', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('FadeTransition with opacity=1.0 created');

  // Test FadeTransition with opacity 0.25
  final fadeQuarter = FadeTransition(
    opacity: AlwaysStoppedAnimation(0.25),
    child: Container(
      width: 200.0,
      height: 60.0,
      color: Colors.orange,
      child: Center(
        child: Text('Fade 0.25', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('FadeTransition with opacity=0.25 created');

  // Test FadeTransition with opacity 0.75
  final fadeThreeQuarter = FadeTransition(
    opacity: AlwaysStoppedAnimation(0.75),
    child: Container(
      width: 200.0,
      height: 60.0,
      color: Colors.purple,
      child: Center(
        child: Text('Fade 0.75', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('FadeTransition with opacity=0.75 created');

  // Test FadeTransition with alwaysIncludeSemantics
  final fadeSemantics = FadeTransition(
    opacity: AlwaysStoppedAnimation(0.0),
    alwaysIncludeSemantics: true,
    child: Container(
      width: 200.0,
      height: 60.0,
      color: Colors.teal,
      child: Center(
        child: Text('With semantics', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('FadeTransition with alwaysIncludeSemantics=true created');

  // Test FadeTransition with Text child
  final fadeText = FadeTransition(
    opacity: AlwaysStoppedAnimation(0.6),
    child: Text(
      'Faded text at 0.6',
      style: TextStyle(fontSize: 18.0, color: Colors.indigo),
    ),
  );
  print('FadeTransition with Text child created');

  // Test FadeTransition with Icon child
  final fadeIcon = FadeTransition(
    opacity: AlwaysStoppedAnimation(0.4),
    child: Icon(Icons.favorite, size: 48.0, color: Colors.red),
  );
  print('FadeTransition with Icon child created');

  // Test FadeTransition with Card child
  final fadeCard = FadeTransition(
    opacity: AlwaysStoppedAnimation(0.8),
    child: Card(
      elevation: 4.0,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('Faded Card at 0.8'),
      ),
    ),
  );
  print('FadeTransition with Card child created');

  // Test nested FadeTransition
  final nestedFade = FadeTransition(
    opacity: AlwaysStoppedAnimation(0.7),
    child: FadeTransition(
      opacity: AlwaysStoppedAnimation(0.7),
      child: Container(
        width: 200.0,
        height: 60.0,
        color: Colors.brown,
        child: Center(
          child: Text('Nested fade', style: TextStyle(color: Colors.white)),
        ),
      ),
    ),
  );
  print('Nested FadeTransition created (0.7 * 0.7 = ~0.49)');

  print('FadeTransition test completed');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'FadeTransition Test',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.0),
        Text('Opacity 0.0:', style: TextStyle(fontWeight: FontWeight.bold)),
        Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: fadeZero,
        ),
        SizedBox(height: 8.0),
        Text('Opacity 0.25:', style: TextStyle(fontWeight: FontWeight.bold)),
        Center(child: fadeQuarter),
        SizedBox(height: 8.0),
        Text('Opacity 0.5:', style: TextStyle(fontWeight: FontWeight.bold)),
        Center(child: fadeHalf),
        SizedBox(height: 8.0),
        Text('Opacity 0.75:', style: TextStyle(fontWeight: FontWeight.bold)),
        Center(child: fadeThreeQuarter),
        SizedBox(height: 8.0),
        Text('Opacity 1.0:', style: TextStyle(fontWeight: FontWeight.bold)),
        Center(child: fadeFull),
        SizedBox(height: 8.0),
        Text('Faded Text:', style: TextStyle(fontWeight: FontWeight.bold)),
        fadeText,
        SizedBox(height: 8.0),
        Text('Faded Icon:', style: TextStyle(fontWeight: FontWeight.bold)),
        Center(child: fadeIcon),
        SizedBox(height: 8.0),
        Text('Faded Card:', style: TextStyle(fontWeight: FontWeight.bold)),
        fadeCard,
        SizedBox(height: 8.0),
        Text('Nested Fade:', style: TextStyle(fontWeight: FontWeight.bold)),
        Center(child: nestedFade),
        SizedBox(height: 16.0),
        Text('Key Points:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• FadeTransition uses Animation<double> for opacity'),
        Text('• AlwaysStoppedAnimation for static values'),
        Text('• opacity range: 0.0 (hidden) to 1.0 (visible)'),
        Text('• alwaysIncludeSemantics for accessibility'),
        Text('• Nested fades multiply opacity values'),
      ],
    ),
  );
}
