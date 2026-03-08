// D4rt test script: Tests DisplayFeature from dart:ui
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DisplayFeature test executing');

  // Create DisplayFeature with fold type
  final df1 = ui.DisplayFeature(
    bounds: Rect.fromLTWH(100, 0, 4, 800),
    type: ui.DisplayFeatureType.fold,
    state: ui.DisplayFeatureState.postureFlat,
  );
  print('DisplayFeature fold: bounds=${df1.bounds}, type=${df1.type}, state=${df1.state}');
  print('hashCode: ${df1.hashCode}');
  print('toString: ${df1.toString()}');

  // Create DisplayFeature with hinge type
  final df2 = ui.DisplayFeature(
    bounds: Rect.fromLTWH(200, 0, 30, 800),
    type: ui.DisplayFeatureType.hinge,
    state: ui.DisplayFeatureState.postureHalfOpened,
  );
  print('DisplayFeature hinge: bounds=${df2.bounds}, type=${df2.type}, state=${df2.state}');

  // Create DisplayFeature with cutout type
  final df3 = ui.DisplayFeature(
    bounds: Rect.fromLTWH(150, 0, 100, 50),
    type: ui.DisplayFeatureType.cutout,
    state: ui.DisplayFeatureState.unknown,
  );
  print('DisplayFeature cutout: type=${df3.type}, state=${df3.state}');

  // Equality
  final df4 = ui.DisplayFeature(
    bounds: Rect.fromLTWH(100, 0, 4, 800),
    type: ui.DisplayFeatureType.fold,
    state: ui.DisplayFeatureState.postureFlat,
  );
  print('df1 == df4 (same params): ${df1 == df4}');
  print('df1 == df2 (different): ${df1 == df2}');

  // All types
  print('DisplayFeatureType.fold: ${ui.DisplayFeatureType.fold}');
  print('DisplayFeatureType.hinge: ${ui.DisplayFeatureType.hinge}');
  print('DisplayFeatureType.cutout: ${ui.DisplayFeatureType.cutout}');

  // All states
  print('DisplayFeatureState.unknown: ${ui.DisplayFeatureState.unknown}');
  print('DisplayFeatureState.postureFlat: ${ui.DisplayFeatureState.postureFlat}');
  print('DisplayFeatureState.postureHalfOpened: ${ui.DisplayFeatureState.postureHalfOpened}');

  print('DisplayFeature test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('DisplayFeature Tests', style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 8),
      Text('Fold: ${df1.type}, ${df1.state}'),
      Text('Hinge: ${df2.type}, ${df2.state}'),
      Text('Cutout: ${df3.type}, ${df3.state}'),
      Text('Equality: same=${df1 == df4}, diff=${df1 == df2}'),
    ],
  );
}
