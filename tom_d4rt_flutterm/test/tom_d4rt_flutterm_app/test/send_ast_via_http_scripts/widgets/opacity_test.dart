// ignore_for_file: avoid_print
// D4rt test script: Tests Opacity and FadeTransition widgets from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Opacity test executing');

  // Test basic Opacity
  final fullyOpaque = Opacity(
    opacity: 1.0,
    child: Container(
      height: 50.0,
      color: Colors.blue,
      child: Center(
        child: Text('Opacity: 1.0', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('Opacity(1.0) created - fully visible');

  final halfOpacity = Opacity(
    opacity: 0.5,
    child: Container(
      height: 50.0,
      color: Colors.blue,
      child: Center(
        child: Text('Opacity: 0.5', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('Opacity(0.5) created - half transparent');

  final quarterOpacity = Opacity(
    opacity: 0.25,
    child: Container(
      height: 50.0,
      color: Colors.blue,
      child: Center(
        child: Text('Opacity: 0.25', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('Opacity(0.25) created - mostly transparent');

  final fullyTransparent = Opacity(
    opacity: 0.0,
    child: Container(
      height: 50.0,
      color: Colors.blue,
      child: Center(
        child: Text('Opacity: 0.0', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('Opacity(0.0) created - fully transparent');

  // Test Opacity with alwaysIncludeSemantics
  final withSemantics = Opacity(
    opacity: 0.0,
    alwaysIncludeSemantics: true,
    child: Text('Semantics included when invisible'),
  );
  print('Opacity with alwaysIncludeSemantics=true created');

  // Test FadeTransition
  final fadeAnimation = AlwaysStoppedAnimation<double>(0.5);
  final fadeTransition = FadeTransition(
    opacity: fadeAnimation,
    child: Container(
      height: 50.0,
      color: Colors.green,
      child: Center(
        child: Text('FadeTransition', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('FadeTransition with AlwaysStoppedAnimation(0.5) created');

  // Test FadeTransition with alwaysIncludeSemantics
  final fadeWithSemantics = FadeTransition(
    opacity: AlwaysStoppedAnimation<double>(0.0),
    alwaysIncludeSemantics: true,
    child: Text('Fade with semantics'),
  );
  print('FadeTransition with alwaysIncludeSemantics=true created');

  // Test opacity values
  print('Opacity must be between 0.0 and 1.0');
  print('Opacity 0.0 = fully transparent');
  print('Opacity 1.0 = fully opaque');

  // Test AnimatedOpacity
  final animatedOpacity = AnimatedOpacity(
    opacity: 0.75,
    duration: Duration(milliseconds: 300),
    child: Container(
      height: 50.0,
      color: Colors.purple,
      child: Center(
        child: Text('AnimatedOpacity', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('AnimatedOpacity with duration=300ms created');

  // Test AnimatedOpacity with curve
  final animatedOpacityCurve = AnimatedOpacity(
    opacity: 0.5,
    duration: Duration(milliseconds: 500),
    curve: Curves.easeInOut,
    child: Container(
      height: 50.0,
      color: Colors.orange,
      child: Center(
        child: Text(
          'AnimatedOpacity with Curve',
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
  );
  print('AnimatedOpacity with curve=easeInOut created');

  // Test AnimatedOpacity with onEnd
  final animatedOpacityCallback = AnimatedOpacity(
    opacity: 0.8,
    duration: Duration(milliseconds: 200),
    onEnd: () {
      print('AnimatedOpacity animation completed');
    },
    child: Container(
      height: 50.0,
      color: Colors.teal,
      child: Center(
        child: Text('With onEnd', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('AnimatedOpacity with onEnd callback created');

  // Test SliverOpacity
  print('SliverOpacity - opacity for sliver children');

  // Test opacity stack
  final opacityStack = Stack(
    children: [
      Container(
        height: 100.0,
        color: Colors.red,
        child: Center(
          child: Text(
            'Base Layer',
            style: TextStyle(color: Colors.white, fontSize: 18.0),
          ),
        ),
      ),
      Opacity(
        opacity: 0.7,
        child: Container(
          height: 100.0,
          color: Colors.blue,
          child: Center(
            child: Text(
              'Semi-transparent Overlay',
              style: TextStyle(color: Colors.white, fontSize: 14.0),
            ),
          ),
        ),
      ),
    ],
  );
  print('Stack with opacity overlay created');

  // Test performance notes
  print(
    'Performance: Opacity is expensive, prefer using colors with opacity when possible',
  );
  print('Container(color: Colors.blue.withOpacity(0.5)) is more efficient');

  // Test color with opacity alternative
  final colorOpacity = Container(
    height: 50.0,
    color: Colors.blue.withOpacity(0.5),
    child: Center(
      child: Text('Color with opacity', style: TextStyle(color: Colors.white)),
    ),
  );
  print('Container with color.withOpacity(0.5) created');

  // Test Visibility as alternative
  final visibilityWidget = Visibility(
    visible: true,
    child: Text('Visibility widget'),
  );
  print('Visibility widget created as alternative');

  final invisibleWidget = Visibility(
    visible: false,
    maintainSize: true,
    maintainAnimation: true,
    maintainState: true,
    child: Text('Invisible but maintains space'),
  );
  print('Visibility with maintainSize=true created');

  print('Opacity test completed');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Opacity Test',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.0),

        Text('Opacity Values:', style: TextStyle(fontWeight: FontWeight.bold)),
        fullyOpaque,
        SizedBox(height: 4.0),
        halfOpacity,
        SizedBox(height: 4.0),
        quarterOpacity,
        SizedBox(height: 4.0),
        Container(
          height: 50.0,
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: Center(
            child: Stack(children: [Text('(invisible)'), fullyTransparent]),
          ),
        ),
        SizedBox(height: 16.0),

        Text('FadeTransition:', style: TextStyle(fontWeight: FontWeight.bold)),
        fadeTransition,
        SizedBox(height: 16.0),

        Text('AnimatedOpacity:', style: TextStyle(fontWeight: FontWeight.bold)),
        animatedOpacity,
        SizedBox(height: 4.0),
        animatedOpacityCurve,
        SizedBox(height: 4.0),
        animatedOpacityCallback,
        SizedBox(height: 16.0),

        Text('Opacity Stack:', style: TextStyle(fontWeight: FontWeight.bold)),
        opacityStack,
        SizedBox(height: 16.0),

        Text(
          'Color Opacity Alternative:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        colorOpacity,
        SizedBox(height: 16.0),

        Text('Key Points:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• Opacity(opacity: 0-1) - static opacity'),
        Text('• FadeTransition - animated with Animation<double>'),
        Text('• AnimatedOpacity - implicit animation'),
        Text('• alwaysIncludeSemantics - for accessibility'),
        Text('• color.withOpacity() - more performant'),
      ],
    ),
  );
}
