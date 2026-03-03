// D4rt test script: Tests D4rtCustomClipper proxy with ClipPath/ClipRect widgets
// Phase 4: Proxy class generation for abstract delegates (GEN-083)
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

dynamic build(BuildContext context) {
  print('D4rtCustomClipper proxy test executing');

  // ========== RECT CLIPPER ==========
  print('--- D4rtCustomClipper<Rect> ---');

  // Create a custom clipper that clips to a centered rectangle
  final rectClipper = D4rtCustomClipper(
    onGetClip: (Size size) {
      final inset = 20.0;
      return Rect.fromLTWH(inset, inset, size.width - inset * 2, size.height - inset * 2);
    },
    onShouldReclip: (CustomClipper oldClipper) => false,
  );
  print('D4rtCustomClipper (Rect) created: ${rectClipper.runtimeType}');
  print('  is CustomClipper: ${rectClipper is CustomClipper}');

  // Use in ClipRect widget
  final widget1 = ClipRect(
    clipper: rectClipper,
    child: Container(
      width: 200.0,
      height: 100.0,
      color: Colors.blue,
      child: Center(
        child: Text('Clipped Rect', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('ClipRect with D4rtCustomClipper<Rect> created');

  // ========== PATH CLIPPER ==========
  print('--- D4rtCustomClipper<Path> ---');

  // Create a custom clipper that clips to a diamond path
  final pathClipper = D4rtCustomClipper.path(
    onGetClip: (Size size) {
      final path = Path();
      path.moveTo(size.width / 2, 0);
      path.lineTo(size.width, size.height / 2);
      path.lineTo(size.width / 2, size.height);
      path.lineTo(0, size.height / 2);
      path.close();
      return path;
    },
    onShouldReclip: (CustomClipper oldClipper) => false,
  );
  print('D4rtCustomClipper.path created for diamond shape');

  // Use in ClipPath widget
  final widget2 = ClipPath(
    clipper: pathClipper,
    child: Container(
      width: 150.0,
      height: 150.0,
      color: Colors.green,
      child: Center(
        child: Text('Diamond', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('ClipPath with D4rtCustomClipper<Path> created');

  // ========== CIRCULAR CLIPPER ==========
  print('--- Circular Clip ---');

  final circleClipper = D4rtCustomClipper.path(
    onGetClip: (Size size) {
      final path = Path();
      path.addOval(
        Rect.fromCenter(
          center: Offset(size.width / 2, size.height / 2),
          width: size.width * 0.8,
          height: size.height * 0.8,
        ),
      );
      return path;
    },
    onShouldReclip: (CustomClipper oldClipper) => false,
  );
  print('Circular clipper created');

  final widget3 = ClipPath(
    clipper: circleClipper,
    child: Container(
      width: 120.0,
      height: 120.0,
      color: Colors.red,
      child: Center(
        child: Text('Circle', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('ClipPath with circular clipper created');

  // ========== DYNAMIC RECLIP ==========
  print('--- shouldReclip Logic ---');

  final dynamicClipper = D4rtCustomClipper(
    onGetClip: (Size size) {
      return Rect.fromLTWH(10, 10, size.width - 20, size.height - 20);
    },
    onShouldReclip: (CustomClipper oldClipper) => true,
  );
  print('Dynamic clipper (always reclips) created');

  final widget4 = ClipRect(
    clipper: dynamicClipper,
    child: Container(
      width: 100.0,
      height: 100.0,
      color: Colors.purple,
      child: Center(child: Text('Reclip', style: TextStyle(color: Colors.white))),
    ),
  );
  print('ClipRect with dynamic clipper created');

  // ========== CLIPPER WITH CLIPBEHAVIOR ==========
  print('--- ClipBehavior Options ---');

  final widget5 = ClipRect(
    clipper: rectClipper,
    clipBehavior: Clip.antiAlias,
    child: Container(
      width: 200.0,
      height: 100.0,
      color: Colors.orange,
      child: Center(
        child: Text('AntiAlias', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('ClipRect with Clip.antiAlias created');

  // ========== NESTED CLIPPING ==========
  print('--- Nested Clipping ---');

  final widget6 = ClipRect(
    clipper: rectClipper,
    child: ClipPath(
      clipper: circleClipper,
      child: Container(
        width: 200.0,
        height: 200.0,
        color: Colors.teal,
        child: Center(
          child: Text('Nested', style: TextStyle(color: Colors.white)),
        ),
      ),
    ),
  );
  print('Nested ClipRect + ClipPath created');

  print('D4rtCustomClipper proxy test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('D4rtCustomClipper Proxy Tests'),
      SizedBox(height: 8.0),
      widget1,
      SizedBox(height: 8.0),
      widget2,
      SizedBox(height: 8.0),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [widget3, SizedBox(width: 8.0), widget4],
      ),
      SizedBox(height: 8.0),
      widget5,
      SizedBox(height: 8.0),
      widget6,
    ],
  );
}
