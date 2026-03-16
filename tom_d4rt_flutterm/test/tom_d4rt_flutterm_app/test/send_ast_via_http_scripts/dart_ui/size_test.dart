// D4rt test script: Tests Size from dart:ui
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Size test executing');

  // Test Size constructors
  final size1 = Size(200.0, 150.0);
  print('Size created: width=${size1.width}, height=${size1.height}');

  // Test Size.square
  final square = Size.square(100.0);
  print('Size.square: ${square.width}x${square.height}');

  // Test Size.zero
  final zero = Size.zero;
  print('Size.zero: ${zero.width}x${zero.height}');

  // Test Size.fromWidth and Size.fromHeight
  final fromWidth = Size.fromWidth(200.0);
  print('Size.fromWidth: ${fromWidth.width}x${fromWidth.height}');

  final fromHeight = Size.fromHeight(150.0);
  print('Size.fromHeight: ${fromHeight.width}x${fromHeight.height}');

  // Test Size operations
  final aspectRatio = size1.aspectRatio;
  print('Aspect ratio: $aspectRatio');

  final flipped = size1.flipped;
  print('Flipped: ${flipped.width}x${flipped.height}');

  final isEmpty = size1.isEmpty;
  print('isEmpty: $isEmpty');

  print('Size test completed');

  return Container(
    width: size1.width,
    height: size1.height,
    color: Colors.green,
    child: Center(
      child: Text(
        'Size: ${size1.width.toInt()}x${size1.height.toInt()}',
        style: TextStyle(color: Colors.white, fontSize: 16.0),
      ),
    ),
  );
}
