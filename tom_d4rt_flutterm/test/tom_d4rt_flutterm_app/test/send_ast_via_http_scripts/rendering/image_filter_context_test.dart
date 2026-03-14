// D4rt test script: Tests ImageFilterContext from rendering
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ImageFilterContext test executing');

  // ========== ImageFilterContext is abstract - documented behavior ==========
  print('--- ImageFilterContext (abstract) ---');
  print('  ImageFilterContext is an abstract interface');
  print('  Used by BackdropFilter and related widgets');
  print('  Provides filter and clip information');

  // ========== BackdropFilter usage (uses ImageFilterContext internally) ==========
  print('--- BackdropFilter (uses ImageFilterContext) ---');
  final backdropFilter = BackdropFilter(
    filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
    child: Container(
      width: 100.0,
      height: 100.0,
      color: Color(0x80FFFFFF),
    ),
  );
  print('  BackdropFilter created');
  print('  filter: blur(5.0, 5.0)');

  // ========== Different filter configurations ==========
  print('--- Different filter configurations ---');
  final blurLight = BackdropFilter(
    filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
    child: Container(width: 50.0, height: 50.0),
  );
  print('  light blur filter (2.0, 2.0)');

  final blurHeavy = BackdropFilter(
    filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
    child: Container(width: 50.0, height: 50.0),
  );
  print('  heavy blur filter (15.0, 15.0)');

  final blurAsymmetric = BackdropFilter(
    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 2.0),
    child: Container(width: 50.0, height: 50.0),
  );
  print('  asymmetric blur (10.0, 2.0)');

  // ========== Composed filters ==========
  print('--- Composed filters ---');
  final composedFilter = ImageFilter.compose(
    inner: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
    outer: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
  );
  final composedBackdrop = BackdropFilter(
    filter: composedFilter,
    child: Container(width: 50.0, height: 50.0),
  );
  print('  composed filter: inner + outer blur');

  // ========== BlendMode with filters ==========
  print('--- BlendMode with filters ---');
  final blendNormal = BackdropFilter(
    filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
    blendMode: BlendMode.srcOver,
    child: Container(width: 50.0, height: 50.0),
  );
  print('  blendMode: srcOver');

  final blendMultiply = BackdropFilter(
    filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
    blendMode: BlendMode.multiply,
    child: Container(width: 50.0, height: 50.0),
  );
  print('  blendMode: multiply');

  // ========== Matrix transforms in filter ==========
  print('--- Matrix transforms ---');
  final identityMatrix = Float64List.fromList([
    1.0, 0.0, 0.0, 0.0,
    0.0, 1.0, 0.0, 0.0,
    0.0, 0.0, 1.0, 0.0,
    0.0, 0.0, 0.0, 1.0,
  ]);
  final matrixFilter = ImageFilter.matrix(identityMatrix);
  print('  identity matrix filter created');

  // ========== Filter chains ==========
  print('--- Filter chains ---');
  final filter1 = ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0);
  final filter2 = ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0);
  final filter3 = ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0);
  final chain1 = ImageFilter.compose(inner: filter1, outer: filter2);
  final chain2 = ImageFilter.compose(inner: chain1, outer: filter3);
  print('  3-filter chain created');
  print('  chain depth: 3');

  print('ImageFilterContext test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('ImageFilterContext Tests',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          SizedBox(height: 8.0),
          Text('ImageFilterContext is abstract'),
          Text('Used by BackdropFilter internally'),
          SizedBox(height: 8.0),
          Stack(
            children: [
              Container(
                width: 200.0,
                height: 100.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF2196F3), Color(0xFF4CAF50)],
                  ),
                ),
              ),
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                  child: Container(color: Color(0x40FFFFFF)),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          Text('BackdropFilter with blur applied'),
        ],
      ),
    ),
  );
}
