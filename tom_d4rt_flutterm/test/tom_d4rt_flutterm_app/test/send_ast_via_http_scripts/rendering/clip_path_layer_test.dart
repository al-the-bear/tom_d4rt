// D4rt test script: Tests ClipPathLayer from rendering
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ClipPathLayer test executing');

  // ========== ClipPathLayer Basic Creation ==========
  print('--- ClipPathLayer Basic Creation ---');
  final trianglePath = Path()
    ..moveTo(50.0, 0.0)
    ..lineTo(100.0, 100.0)
    ..lineTo(0.0, 100.0)
    ..close();

  final clipLayer = ClipPathLayer(clipPath: trianglePath);
  print('  created: ${clipLayer.runtimeType}');
  print('  clipPath: ${clipLayer.clipPath}');
  print('  clipBehavior: ${clipLayer.clipBehavior}');

  // ========== ClipPathLayer with Different Paths ==========
  print('--- ClipPathLayer with Different Paths ---');

  // Circle path
  final circlePath = Path()
    ..addOval(Rect.fromCircle(center: Offset(50.0, 50.0), radius: 40.0));
  final circleClip = ClipPathLayer(clipPath: circlePath);
  print('  circle clip created');

  // Rectangle path
  final rectPath = Path()..addRect(Rect.fromLTWH(10.0, 10.0, 80.0, 60.0));
  final rectClip = ClipPathLayer(clipPath: rectPath);
  print('  rectangle clip created');

  // Rounded rectangle path
  final rrectPath = Path()
    ..addRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0.0, 0.0, 100.0, 80.0),
        Radius.circular(15.0),
      ),
    );
  final rrectClip = ClipPathLayer(clipPath: rrectPath);
  print('  rounded rectangle clip created');

  // Star path (pentagon)
  final starPath = Path()
    ..moveTo(50.0, 0.0)
    ..lineTo(61.0, 35.0)
    ..lineTo(100.0, 35.0)
    ..lineTo(68.0, 57.0)
    ..lineTo(79.0, 91.0)
    ..lineTo(50.0, 70.0)
    ..lineTo(21.0, 91.0)
    ..lineTo(32.0, 57.0)
    ..lineTo(0.0, 35.0)
    ..lineTo(39.0, 35.0)
    ..close();
  final starClip = ClipPathLayer(clipPath: starPath);
  print('  star clip created');

  // ========== ClipPathLayer with ClipBehavior ==========
  print('--- ClipPathLayer with ClipBehavior ---');
  final hardEdgeClip = ClipPathLayer(
    clipPath: trianglePath,
    clipBehavior: Clip.hardEdge,
  );
  print('  hardEdge: ${hardEdgeClip.clipBehavior}');

  final antiAliasClip = ClipPathLayer(
    clipPath: trianglePath,
    clipBehavior: Clip.antiAlias,
  );
  print('  antiAlias: ${antiAliasClip.clipBehavior}');

  final antiAliasWithSaveLayerClip = ClipPathLayer(
    clipPath: trianglePath,
    clipBehavior: Clip.antiAliasWithSaveLayer,
  );
  print('  antiAliasWithSaveLayer: ${antiAliasWithSaveLayerClip.clipBehavior}');

  // ========== ClipPathLayer Property Modification ==========
  print('--- ClipPathLayer Property Modification ---');
  final mutableLayer = ClipPathLayer(clipPath: trianglePath);
  print('  initial clipPath set');

  final newPath = Path()..addOval(Rect.fromLTWH(0.0, 0.0, 120.0, 80.0));
  mutableLayer.clipPath = newPath;
  print('  modified clipPath to oval');

  mutableLayer.clipBehavior = Clip.antiAlias;
  print('  modified clipBehavior: ${mutableLayer.clipBehavior}');

  // ========== ClipPathLayer Layer Hierarchy ==========
  print('--- ClipPathLayer Layer Hierarchy ---');
  print('  parent: ${clipLayer.parent}');
  print('  firstChild: ${clipLayer.firstChild}');
  print('  lastChild: ${clipLayer.lastChild}');
  print('  nextSibling: ${clipLayer.nextSibling}');
  print('  previousSibling: ${clipLayer.previousSibling}');
  print('  hasChildren: ${clipLayer.hasChildren}');

  // ========== Path Operations ==========
  print('--- Path Operations ---');
  final complexPath = Path();
  complexPath.moveTo(0.0, 0.0);
  complexPath.lineTo(100.0, 0.0);
  complexPath.quadraticBezierTo(150.0, 50.0, 100.0, 100.0);
  complexPath.cubicTo(80.0, 120.0, 20.0, 120.0, 0.0, 100.0);
  complexPath.close();
  print('  complex path with curves created');

  final complexClip = ClipPathLayer(clipPath: complexPath);
  print('  complex clip layer: ${complexClip.runtimeType}');

  // ========== Path Bounds ==========
  print('--- Path Bounds ---');
  print('  triangle bounds: ${trianglePath.getBounds()}');
  print('  circle bounds: ${circlePath.getBounds()}');
  print('  rect bounds: ${rectPath.getBounds()}');
  print('  star bounds: ${starPath.getBounds()}');

  // ========== Clip Behavior Values ==========
  print('--- Clip Behavior Values ---');
  for (final clip in Clip.values) {
    print('  ${clip.name}: index=${clip.index}');
  }

  print('ClipPathLayer test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'ClipPathLayer Tests',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('ClipPathLayer: ${clipLayer.runtimeType}'),
          Text('Shapes: triangle, circle, rect, rrect, star'),
          Text('ClipBehavior: hardEdge, antiAlias, antiAliasWithSaveLayer'),
          Text('Property modification verified'),
          Text('Path operations: lines, curves, bezier'),
          Text('Path bounds calculated'),
        ],
      ),
    ),
  );
}
