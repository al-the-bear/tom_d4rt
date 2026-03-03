// D4rt test script: Tests ShapeDecoration, DecorationImage
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DecorationTest test executing');

  // ShapeDecoration with gradient and shadows
  final shapeDecoration = ShapeDecoration(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16.0),
      side: BorderSide(color: Colors.blue, width: 2.0),
    ),
    gradient: LinearGradient(
      colors: [Colors.blue.shade100, Colors.purple.shade100],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    shadows: [
      BoxShadow(
        color: Colors.black26,
        blurRadius: 8.0,
        offset: Offset(2.0, 4.0),
      ),
      BoxShadow(
        color: Colors.blue.withValues(alpha: 0.2),
        blurRadius: 4.0,
        offset: Offset(0.0, 2.0),
      ),
    ],
  );
  print('ShapeDecoration shape: ${shapeDecoration.shape}');
  print('ShapeDecoration gradient: ${shapeDecoration.gradient}');
  print('ShapeDecoration shadows: ${shapeDecoration.shadows}');

  // ShapeDecoration with color (no gradient)
  final shapeDecorationColor = ShapeDecoration(
    shape: CircleBorder(
      side: BorderSide(color: Colors.green, width: 1.5),
    ),
    color: Colors.green.shade50,
  );
  print('ShapeDecoration (color) shape: ${shapeDecorationColor.shape}');
  print('ShapeDecoration (color) color: ${shapeDecorationColor.color}');

  // DecorationImage — construct with a placeholder NetworkImage
  // Note: The image won't actually load in D4rt, but we test construction
  final decorationImage = DecorationImage(
    image: NetworkImage('https://example.com/placeholder.png'),
    fit: BoxFit.cover,
    alignment: Alignment.center,
  );
  print('DecorationImage fit: ${decorationImage.fit}');
  print('DecorationImage alignment: ${decorationImage.alignment}');
  print('DecorationImage image: ${decorationImage.image}');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      DecoratedBox(
        decoration: shapeDecoration,
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Text(
            'ShapeDecoration\nwith gradient & shadows',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14.0),
          ),
        ),
      ),
      SizedBox(height: 16.0),
      DecoratedBox(
        decoration: shapeDecorationColor,
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Text(
            'ShapeDecoration\nwith color',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14.0),
          ),
        ),
      ),
      SizedBox(height: 16.0),
      Container(
        width: 120.0,
        height: 80.0,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          border: Border.all(color: Colors.grey),
        ),
        child: Center(
          child: Text(
            'DecorationImage\n(constructed)',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12.0),
          ),
        ),
      ),
    ],
  );
}
