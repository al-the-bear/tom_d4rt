// D4rt test script: Tests InteractiveViewer, TransformationController,
// MatrixGestureDetector patterns, Matrix4 transforms, FittedBox,
// RotatedBox, ClipRect, ClipRRect
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('InteractiveViewer/Transform test executing');

  // ========== TransformationController ==========
  print('--- TransformationController Tests ---');
  final controller = TransformationController();
  print('TransformationController created');
  print('  initial value: ${controller.value}');

  controller.value = Matrix4.identity()..scale(2.0);
  print('  scaled 2x: ${controller.value.getMaxScaleOnAxis()}');

  controller.value = Matrix4.identity();
  print('  reset to identity');

  // ========== InteractiveViewer ==========
  print('--- InteractiveViewer Tests ---');
  final viewer = InteractiveViewer(
    transformationController: controller,
    boundaryMargin: EdgeInsets.all(20.0),
    minScale: 0.1,
    maxScale: 5.0,
    constrained: true,
    panEnabled: true,
    scaleEnabled: true,
    scaleFactor: 200.0,
    alignment: Alignment.center,
    child: Container(
      width: 300,
      height: 300,
      color: Colors.blue,
      child: Center(child: Text('Zoomable', style: TextStyle(color: Colors.white))),
    ),
  );
  print('InteractiveViewer created');

  // ========== FittedBox ==========
  print('--- FittedBox Tests ---');
  final fittedBox = FittedBox(
    fit: BoxFit.contain,
    alignment: Alignment.center,
    clipBehavior: Clip.hardEdge,
    child: Text('Fitted', style: TextStyle(fontSize: 100)),
  );
  print('FittedBox created: fit=${BoxFit.contain}');

  for (final fit in BoxFit.values) {
    print('  BoxFit: $fit');
  }

  // ========== RotatedBox ==========
  print('--- RotatedBox Tests ---');
  final rotated = RotatedBox(
    quarterTurns: 1,
    child: Text('Rotated'),
  );
  print('RotatedBox created: quarterTurns=1');

  // ========== ClipRect ==========
  print('--- ClipRect Tests ---');
  final clipRect = ClipRect(
    clipBehavior: Clip.antiAlias,
    child: Container(width: 100, height: 100, color: Colors.red),
  );
  print('ClipRect created: clipBehavior=${Clip.antiAlias}');

  // ========== ClipRRect ==========
  print('--- ClipRRect Tests ---');
  final clipRRect = ClipRRect(
    borderRadius: BorderRadius.circular(16.0),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    child: Container(width: 100, height: 100, color: Colors.green),
  );
  print('ClipRRect created: borderRadius=16.0');

  // ========== ClipOval ==========
  print('--- ClipOval Tests ---');
  final clipOval = ClipOval(
    clipBehavior: Clip.antiAlias,
    child: Container(width: 100, height: 100, color: Colors.purple),
  );
  print('ClipOval created');

  // ========== ClipPath ==========
  print('--- ClipPath Tests ---');
  final clipPath = ClipPath(
    clipBehavior: Clip.antiAlias,
    child: Container(width: 100, height: 100, color: Colors.orange),
  );
  print('ClipPath created');

  print('All interactive viewer tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 200, child: viewer),
            fittedBox,
            rotated,
            Row(children: [clipRect, clipRRect, clipOval]),
            clipPath,
          ],
        ),
      ),
    ),
  );
}
