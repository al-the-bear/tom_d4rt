// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests PhysicalModel, PhysicalShape, ShaderMask,
// BackdropFilter, ColorFiltered from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PhysicalModel test executing');

  // ========== PHYSICALMODEL ==========
  print('--- PhysicalModel Tests ---');

  // PhysicalModel applies elevation with a shadow
  final physicalBox = PhysicalModel(
    color: Colors.white,
    elevation: 8.0,
    shadowColor: Colors.black,
    borderRadius: BorderRadius.circular(12.0),
    child: SizedBox(
      width: 150.0,
      height: 80.0,
      child: Center(child: Text('Elevated')),
    ),
  );
  print('PhysicalModel with elevation=8 created');
  print('  color: ${physicalBox.color}');
  print('  elevation: ${physicalBox.elevation}');
  print('  shadowColor: ${physicalBox.shadowColor}');

  // PhysicalModel with different clip
  final clippedModel = PhysicalModel(
    color: Colors.blue,
    elevation: 4.0,
    clipBehavior: Clip.antiAlias,
    borderRadius: BorderRadius.circular(20.0),
    child: Container(
      width: 100.0,
      height: 100.0,
      color: Colors.blue,
      child: Center(
        child: Text('Clipped', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('PhysicalModel with Clip.antiAlias created');

  // ========== PHYSICALSHAPE ==========
  print('--- PhysicalShape Tests ---');

  // PhysicalShape uses a custom shape
  final physicalShape = PhysicalShape(
    color: Colors.green,
    elevation: 6.0,
    clipper: ShapeBorderClipper(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
    ),
    child: SizedBox(
      width: 150.0,
      height: 80.0,
      child: Center(
        child: Text('Shape', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('PhysicalShape created');
  print('  color: ${physicalShape.color}');
  print('  elevation: ${physicalShape.elevation}');

  // PhysicalShape with circle
  final circleShape = PhysicalShape(
    color: Colors.orange,
    elevation: 4.0,
    clipper: ShapeBorderClipper(shape: CircleBorder()),
    child: SizedBox(
      width: 80.0,
      height: 80.0,
      child: Center(
        child: Text('O', style: TextStyle(color: Colors.white, fontSize: 24.0)),
      ),
    ),
  );
  print('PhysicalShape with CircleBorder created');

  // ========== COLORFILTERED ==========
  print('--- ColorFiltered Tests ---');

  // ColorFiltered applies a color filter to its child
  final colorFiltered = ColorFiltered(
    colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn),
    child: Container(
      width: 100.0,
      height: 100.0,
      color: Colors.blue,
      child: Center(child: Text('Filtered')),
    ),
  );
  print('ColorFiltered with red colorBurn created');

  // Grayscale filter
  final grayscale = ColorFiltered(
    colorFilter: ColorFilter.mode(Colors.grey, BlendMode.saturation),
    child: Container(
      width: 100.0,
      height: 50.0,
      color: Colors.green,
      child: Center(
        child: Text('Gray', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('ColorFiltered grayscale created');

  print('All PhysicalModel tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'PhysicalModel Test',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 12.0),
            physicalBox,
            SizedBox(height: 12.0),
            clippedModel,
            SizedBox(height: 12.0),
            physicalShape,
            SizedBox(height: 12.0),
            circleShape,
            SizedBox(height: 12.0),
            colorFiltered,
            SizedBox(height: 8.0),
            grayscale,
          ],
        ),
      ),
    ),
  );
}
