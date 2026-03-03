// D4rt test script: Tests AnimatedContainer from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('AnimatedContainer test executing');

  // Test AnimatedContainer with duration
  final basicAnimated = AnimatedContainer(
    duration: Duration(milliseconds: 300),
    width: 100.0,
    height: 100.0,
    color: Colors.blue,
    child: Center(
      child: Text('Basic', style: TextStyle(color: Colors.white)),
    ),
  );
  print('AnimatedContainer with duration=300ms created');

  // Test AnimatedContainer with curve
  final curvedAnimated = AnimatedContainer(
    duration: Duration(milliseconds: 500),
    curve: Curves.easeInOut,
    width: 150.0,
    height: 80.0,
    color: Colors.green,
    child: Center(
      child: Text('Curved', style: TextStyle(color: Colors.white)),
    ),
  );
  print('AnimatedContainer with curve=easeInOut created');

  // Test AnimatedContainer with BoxDecoration
  final decoratedAnimated = AnimatedContainer(
    duration: Duration(milliseconds: 400),
    width: 120.0,
    height: 120.0,
    decoration: BoxDecoration(
      color: Colors.orange,
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 10.0,
          offset: Offset(2.0, 2.0),
        ),
      ],
    ),
    child: Center(
      child: Text('Decorated', style: TextStyle(color: Colors.white)),
    ),
  );
  print('AnimatedContainer with BoxDecoration created');

  // Test AnimatedContainer with different size
  final largeAnimated = AnimatedContainer(
    duration: Duration(milliseconds: 600),
    curve: Curves.bounceOut,
    width: 200.0,
    height: 60.0,
    color: Colors.purple,
    child: Center(
      child: Text('Large', style: TextStyle(color: Colors.white)),
    ),
  );
  print('AnimatedContainer with large size created');

  // Test AnimatedContainer with small size
  final smallAnimated = AnimatedContainer(
    duration: Duration(milliseconds: 600),
    curve: Curves.elasticOut,
    width: 60.0,
    height: 60.0,
    color: Colors.red,
    child: Center(
      child: Text('S', style: TextStyle(color: Colors.white, fontSize: 12.0)),
    ),
  );
  print('AnimatedContainer with small size created');

  // Test AnimatedContainer with padding
  final paddedAnimated = AnimatedContainer(
    duration: Duration(milliseconds: 350),
    padding: EdgeInsets.all(16.0),
    width: 160.0,
    height: 80.0,
    color: Colors.teal,
    child: Text('Padded', style: TextStyle(color: Colors.white)),
  );
  print('AnimatedContainer with padding created');

  // Test AnimatedContainer with margin
  final marginAnimated = AnimatedContainer(
    duration: Duration(milliseconds: 350),
    margin: EdgeInsets.symmetric(horizontal: 20.0),
    width: 140.0,
    height: 60.0,
    color: Colors.indigo,
    child: Center(
      child: Text('Margin', style: TextStyle(color: Colors.white)),
    ),
  );
  print('AnimatedContainer with margin created');

  // Test AnimatedContainer with alignment
  final alignedAnimated = AnimatedContainer(
    duration: Duration(milliseconds: 300),
    width: 180.0,
    height: 80.0,
    color: Colors.brown,
    alignment: Alignment.centerLeft,
    child: Padding(
      padding: EdgeInsets.only(left: 8.0),
      child: Text('Aligned left', style: TextStyle(color: Colors.white)),
    ),
  );
  print('AnimatedContainer with alignment created');

  // Test AnimatedContainer with constraints
  final constrainedAnimated = AnimatedContainer(
    duration: Duration(milliseconds: 500),
    constraints: BoxConstraints(
      minWidth: 50.0,
      maxWidth: 200.0,
      minHeight: 40.0,
      maxHeight: 80.0,
    ),
    color: Colors.pink,
    child: Center(
      child: Text('Constrained', style: TextStyle(color: Colors.white)),
    ),
  );
  print('AnimatedContainer with constraints created');

  // Test AnimatedContainer with transform
  final transformedAnimated = AnimatedContainer(
    duration: Duration(milliseconds: 400),
    width: 100.0,
    height: 50.0,
    color: Colors.cyan,
    transform: Matrix4.rotationZ(0.05),
    child: Center(
      child: Text('Rotated', style: TextStyle(color: Colors.white)),
    ),
  );
  print('AnimatedContainer with transform created');

  print('AnimatedContainer test completed');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'AnimatedContainer Test',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.0),
        Text('Basic (300ms):', style: TextStyle(fontWeight: FontWeight.bold)),
        Center(child: basicAnimated),
        SizedBox(height: 8.0),
        Text(
          'Curved (easeInOut):',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Center(child: curvedAnimated),
        SizedBox(height: 8.0),
        Text('Decorated:', style: TextStyle(fontWeight: FontWeight.bold)),
        Center(child: decoratedAnimated),
        SizedBox(height: 8.0),
        Text(
          'Large (bounceOut):',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Center(child: largeAnimated),
        SizedBox(height: 8.0),
        Text(
          'Small (elasticOut):',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Center(child: smallAnimated),
        SizedBox(height: 8.0),
        Text('Padded:', style: TextStyle(fontWeight: FontWeight.bold)),
        Center(child: paddedAnimated),
        SizedBox(height: 8.0),
        Text('Margin:', style: TextStyle(fontWeight: FontWeight.bold)),
        marginAnimated,
        SizedBox(height: 8.0),
        Text('Aligned:', style: TextStyle(fontWeight: FontWeight.bold)),
        alignedAnimated,
        SizedBox(height: 8.0),
        Text('Constrained:', style: TextStyle(fontWeight: FontWeight.bold)),
        constrainedAnimated,
        SizedBox(height: 8.0),
        Text('Transformed:', style: TextStyle(fontWeight: FontWeight.bold)),
        Center(child: transformedAnimated),
        SizedBox(height: 16.0),
        Text('Key Points:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• AnimatedContainer animates between property changes'),
        Text('• duration controls animation length'),
        Text('• curve controls animation easing'),
        Text('• Supports decoration, size, padding, margin, transform'),
        Text('• No AnimationController needed'),
      ],
    ),
  );
}
