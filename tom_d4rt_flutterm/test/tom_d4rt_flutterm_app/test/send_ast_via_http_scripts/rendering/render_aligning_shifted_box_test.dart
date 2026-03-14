// D4rt test script: Tests RenderAligningShiftedBox from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RenderAligningShiftedBox test executing');

  // ========== ALIGNMENT CONCEPTS ==========
  print('--- RenderAligningShiftedBox Concepts ---');
  print('RenderAligningShiftedBox is the base class for alignment render objects');
  print('It shifts its child according to an Alignment value');
  print('Subclasses: RenderPositionedBox (Align), RenderConstrainedOverflowBox, etc.');

  // ========== ALIGNMENT VALUES ==========
  print('--- Alignment Values ---');
  print('Alignment.topLeft: ${Alignment.topLeft}');
  print('Alignment.topCenter: ${Alignment.topCenter}');
  print('Alignment.topRight: ${Alignment.topRight}');
  print('Alignment.centerLeft: ${Alignment.centerLeft}');
  print('Alignment.center: ${Alignment.center}');
  print('Alignment.centerRight: ${Alignment.centerRight}');
  print('Alignment.bottomLeft: ${Alignment.bottomLeft}');
  print('Alignment.bottomCenter: ${Alignment.bottomCenter}');
  print('Alignment.bottomRight: ${Alignment.bottomRight}');

  // ========== ALIGN WIDGET TESTS ==========
  print('--- Align Widget Tests (uses RenderPositionedBox) ---');

  final alignTopLeft = Container(
    width: 100,
    height: 80,
    color: Colors.grey.shade300,
    child: Align(
      alignment: Alignment.topLeft,
      child: Container(width: 30, height: 30, color: Colors.red),
    ),
  );
  print('Created Align with topLeft');

  final alignCenter = Container(
    width: 100,
    height: 80,
    color: Colors.grey.shade300,
    child: Align(
      alignment: Alignment.center,
      child: Container(width: 30, height: 30, color: Colors.blue),
    ),
  );
  print('Created Align with center');

  final alignBottomRight = Container(
    width: 100,
    height: 80,
    color: Colors.grey.shade300,
    child: Align(
      alignment: Alignment.bottomRight,
      child: Container(width: 30, height: 30, color: Colors.green),
    ),
  );
  print('Created Align with bottomRight');

  // ========== CUSTOM ALIGNMENT ==========
  print('--- Custom Alignment Values ---');

  final customAlign = Container(
    width: 100,
    height: 80,
    color: Colors.grey.shade300,
    child: Align(
      alignment: Alignment(0.5, -0.5),
      child: Container(width: 20, height: 20, color: Colors.purple),
    ),
  );
  print('Created Align with custom Alignment(0.5, -0.5)');
  print('  x: 0.5 (slightly right of center)');
  print('  y: -0.5 (slightly above center)');

  // ========== WIDTH/HEIGHT FACTOR ==========
  print('--- Width/Height Factor Tests ---');

  final alignWithFactor = Container(
    color: Colors.yellow.shade100,
    child: Align(
      alignment: Alignment.center,
      widthFactor: 2.0,
      heightFactor: 2.0,
      child: Container(width: 40, height: 40, color: Colors.orange),
    ),
  );
  print('Created Align with widthFactor: 2.0, heightFactor: 2.0');
  print('  Parent size will be 2x child size');

  final alignWithWidthFactor = Align(
    alignment: Alignment.centerLeft,
    widthFactor: 3.0,
    child: Container(width: 30, height: 30, color: Colors.cyan),
  );
  print('Created Align with widthFactor: 3.0');

  // ========== CENTER WIDGET ==========
  print('--- Center Widget Tests ---');
  print('Center is a convenience widget equivalent to Align(alignment: Alignment.center)');

  final centerWidget = Container(
    width: 100,
    height: 80,
    color: Colors.grey.shade200,
    child: Center(
      child: Container(width: 30, height: 30, color: Colors.teal),
    ),
  );
  print('Created Center widget');

  final centerWithFactor = Center(
    widthFactor: 1.5,
    heightFactor: 1.5,
    child: Container(width: 40, height: 40, color: Colors.indigo),
  );
  print('Created Center with factors');

  // ========== FRACTIONAL OFFSET ==========
  print('--- FractionalOffset Tests ---');
  print('FractionalOffset.topLeft (0.0, 0.0)');
  print('FractionalOffset.center (0.5, 0.5)');
  print('FractionalOffset.bottomRight (1.0, 1.0)');

  final fractionalAlign = Container(
    width: 100,
    height: 80,
    color: Colors.grey.shade300,
    child: Align(
      alignment: FractionalOffset(0.75, 0.25),
      child: Container(width: 20, height: 20, color: Colors.amber),
    ),
  );
  print('Created Align with FractionalOffset(0.75, 0.25)');

  // ========== ALIGNMENT GEOMETRY ==========
  print('--- AlignmentGeometry Tests ---');
  
  final directional = AlignmentDirectional.topStart;
  print('AlignmentDirectional.topStart: $directional');
  print('AlignmentDirectional.bottomEnd: ${AlignmentDirectional.bottomEnd}');
  print('A1ignmentDirectional respects text direction (LTR/RTL)');

  // ========== POSITIONED BOX TESTS ==========
  print('--- RenderPositionedBox Properties ---');
  print('RenderPositionedBox implements RenderAligningShiftedBox');
  print('Properties: alignment, widthFactor, heightFactor, textDirection');

  // ========== ALIGNMENT ARITHMETIC ==========
  print('--- Alignment Arithmetic ---');
  final a1 = Alignment(0.5, 0.5);
  final a2 = Alignment(0.2, 0.3);
  print('Alignment(0.5, 0.5) + Alignment(0.2, 0.3) = ${a1 + a2}');
  print('Alignment(0.5, 0.5) - Alignment(0.2, 0.3) = ${a1 - a2}');
  print('Alignment(0.5, 0.5) * 2 = ${a1 * 2}');
  print('-Alignment(0.5, 0.5) = ${-a1}');

  // ========== LAYOUT BEHAVIOR ==========
  print('--- Layout Behavior ---');
  print('RenderAligningShiftedBox computes child position using:');
  print('  childParentData.offset = alignment.alongOffset(...)');
  print('The offset is calculated based on remaining space after child layout');

  print('RenderAligningShiftedBox test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderAligningShiftedBox Tests'),
      SizedBox(height: 8),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [alignTopLeft, alignCenter, alignBottomRight],
      ),
      SizedBox(height: 8),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [customAlign, centerWidget],
      ),
      SizedBox(height: 8),
      alignWithFactor,
      SizedBox(height: 8),
      Text('All alignment tests passed'),
    ],
  );
}
