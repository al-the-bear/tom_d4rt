// D4rt test script: Tests ImageFilterConfig from rendering
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ImageFilterConfig test executing');

  // ========== Basic ImageFilterConfig creation ==========
  print('--- Basic ImageFilterConfig ---');
  final blurFilter = ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0);
  final config1 = ImageFilterConfig(filter: blurFilter);
  print('  created: ${config1.runtimeType}');
  print('  filter: ${config1.filter}');

  // ========== Different ImageFilter types ==========
  print('--- Different ImageFilter types ---');
  final gaussianBlur = ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0);
  final configBlur = ImageFilterConfig(filter: gaussianBlur);
  print('  gaussian blur config: ${configBlur.runtimeType}');
  print('  filter type: ${configBlur.filter.runtimeType}');

  final asymmetricBlur = ImageFilter.blur(sigmaX: 15.0, sigmaY: 5.0);
  final configAsymmetric = ImageFilterConfig(filter: asymmetricBlur);
  print('  asymmetric blur: ${configAsymmetric.filter.runtimeType}');

  // ========== Matrix filters ==========
  print('--- Matrix filters ---');
  final matrixFilter = ImageFilter.matrix(
    Float64List.fromList([
      1.0, 0.0, 0.0, 0.0,
      0.0, 1.0, 0.0, 0.0,
      0.0, 0.0, 1.0, 0.0,
      0.0, 0.0, 0.0, 1.0,
    ]),
  );
  final configMatrix = ImageFilterConfig(filter: matrixFilter);
  print('  matrix filter config: ${configMatrix.runtimeType}');

  // ========== Composed filters ==========
  print('--- Composed filters ---');
  final innerFilter = ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0);
  final outerFilter = ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0);
  final composedFilter = ImageFilter.compose(inner: innerFilter, outer: outerFilter);
  final configComposed = ImageFilterConfig(filter: composedFilter);
  print('  composed filter: ${configComposed.runtimeType}');

  // ========== Blur sigma variations ==========
  print('--- Blur sigma variations ---');
  final smallBlur = ImageFilterConfig(filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0));
  print('  small blur (1.0, 1.0): ${smallBlur.runtimeType}');

  final mediumBlur = ImageFilterConfig(filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0));
  print('  medium blur (5.0, 5.0): ${mediumBlur.runtimeType}');

  final largeBlur = ImageFilterConfig(filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0));
  print('  large blur (20.0, 20.0): ${largeBlur.runtimeType}');

  // ========== TileMode variations ==========
  print('--- TileMode variations ---');
  final clampBlur = ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0, tileMode: TileMode.clamp);
  final configClamp = ImageFilterConfig(filter: clampBlur);
  print('  clamp mode: ${configClamp.filter.runtimeType}');

  final repeatBlur = ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0, tileMode: TileMode.repeated);
  final configRepeat = ImageFilterConfig(filter: repeatBlur);
  print('  repeat mode: ${configRepeat.filter.runtimeType}');

  final mirrorBlur = ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0, tileMode: TileMode.mirror);
  final configMirror = ImageFilterConfig(filter: mirrorBlur);
  print('  mirror mode: ${configMirror.filter.runtimeType}');

  // ========== Equality checks ==========
  print('--- Equality checks ---');
  final configA = ImageFilterConfig(filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0));
  final configB = ImageFilterConfig(filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0));
  print('  configA: ${configA.runtimeType}');
  print('  configB: ${configB.runtimeType}');

  print('ImageFilterConfig test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('ImageFilterConfig Tests',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          SizedBox(height: 8.0),
          Text('Basic config: ${config1.runtimeType}'),
          Text('Filter: ${config1.filter.runtimeType}'),
          SizedBox(height: 8.0),
          Text('Blur variations:'),
          Text('  - Small (1.0)'),
          Text('  - Medium (5.0)'),
          Text('  - Large (20.0)'),
          SizedBox(height: 8.0),
          Text('TileMode options:'),
          Text('  - clamp'),
          Text('  - repeated'),
          Text('  - mirror'),
        ],
      ),
    ),
  );
}
