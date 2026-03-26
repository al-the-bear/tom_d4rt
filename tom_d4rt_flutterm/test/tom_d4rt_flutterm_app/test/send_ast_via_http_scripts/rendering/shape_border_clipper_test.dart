// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ShapeBorderClipper from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ShapeBorderClipper test executing');
  print('=' * 50);

  // ShapeBorderClipper clips to a ShapeBorder path
  print('\nShapeBorderClipper:');
  print('Extends: CustomClipper<Path>');
  print('Purpose: Clips a render object to a ShapeBorder outline');
  print('Used by ClipPath and RenderClipPath');

  // Create with a rounded rectangle border
  final clipper = ShapeBorderClipper(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
  );
  print('\nCreated ShapeBorderClipper:');
  print('  runtimeType: ${clipper.runtimeType}');
  print('  shape: ${clipper.shape}');
  print('  textDirection: ${clipper.textDirection}');

  // With textDirection
  final clipperRtl = ShapeBorderClipper(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
    textDirection: TextDirection.rtl,
  );
  print('\nWith RTL textDirection:');
  print('  textDirection: ${clipperRtl.textDirection}');

  // Different ShapeBorder types
  print('\nShapeBorder types for clipping:');
  final circleClipper = ShapeBorderClipper(
    shape: const CircleBorder(),
  );
  print('  CircleBorder: ${circleClipper.shape}');

  final stadiumClipper = ShapeBorderClipper(
    shape: const StadiumBorder(),
  );
  print('  StadiumBorder: ${stadiumClipper.shape}');

  final bevelClipper = ShapeBorderClipper(
    shape: BeveledRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
  );
  print('  BeveledRectangleBorder: ${bevelClipper.shape}');

  // getClip method
  print('\ngetClip method:');
  print('  Path getClip(Size size)');
  print('  Returns the clip path for the given size');
  print('  Delegates to ShapeBorder.getOuterPath()');
  final path = clipper.getClip(const Size(200, 100));
  print('  path for 200x100: bounds = ${path.getBounds()}');

  // shouldReclip
  print('\nshouldReclip:');
  print('  Compares shape and textDirection');
  final clipper2 = ShapeBorderClipper(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
  );
  print('  same shape reclip: ${clipper.shouldReclip(clipper2)}');

  // Widget equivalent
  print('\nWidget equivalent:');
  print('  ClipPath(');
  print('    clipper: ShapeBorderClipper(');
  print('      shape: RoundedRectangleBorder(borderRadius: ...),');
  print('    ),');
  print('    child: Image.asset("photo.png"),');
  print('  )');

  print('\n==================================================');
  print('ShapeBorderClipper test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'ShapeBorderClipper Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: Concrete class'),
      Text('Extends: CustomClipper<Path>'),
      Text('shape: ${clipper.shape}'),
      Text('Purpose: Clip to ShapeBorder outline'),
    ],
  );
}
