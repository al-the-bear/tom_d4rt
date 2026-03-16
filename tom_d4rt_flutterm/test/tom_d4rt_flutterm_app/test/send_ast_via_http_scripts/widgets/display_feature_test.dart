// D4rt test script: Tests DisplayFeature, DisplayFeatureType,
// DisplayFeatureSubScreen, DisplayFeatureState
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

dynamic build(BuildContext context) {
  print('DisplayFeature test executing');

  // ========== DisplayFeatureType ==========
  print('--- DisplayFeatureType Tests ---');
  for (final type in ui.DisplayFeatureType.values) {
    print('DisplayFeatureType: ${type.name}');
  }

  // ========== DisplayFeatureState ==========
  print('--- DisplayFeatureState Tests ---');
  for (final state in ui.DisplayFeatureState.values) {
    print('DisplayFeatureState: ${state.name}');
  }

  // ========== DisplayFeature ==========
  print('--- DisplayFeature Tests ---');
  final feature = ui.DisplayFeature(
    bounds: Rect.fromLTWH(0, 0, 10, 800),
    type: ui.DisplayFeatureType.fold,
    state: ui.DisplayFeatureState.postureFlat,
  );
  print('DisplayFeature created');
  print('  bounds: ${feature.bounds}');
  print('  type: ${feature.type}');
  print('  state: ${feature.state}');

  // Another feature type
  final hinge = ui.DisplayFeature(
    bounds: Rect.fromLTWH(380, 0, 20, 800),
    type: ui.DisplayFeatureType.hinge,
    state: ui.DisplayFeatureState.unknown,
  );
  print('Hinge DisplayFeature created');
  print('  bounds: ${hinge.bounds}');
  print('  type: ${hinge.type}');

  // ========== DisplayFeatureSubScreen ==========
  print('--- DisplayFeatureSubScreen Tests ---');
  final subScreen = DisplayFeatureSubScreen(
    anchorPoint: Offset(100.0, 100.0),
    child: Text('Sub screen content'),
  );
  print('DisplayFeatureSubScreen created');
  print('  anchorPoint: ${subScreen.anchorPoint}');

  print('All display feature tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'DisplayFeature Test',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'DisplayFeatureType values: ${ui.DisplayFeatureType.values.length}',
            ),
            Text(
              'DisplayFeatureState values: ${ui.DisplayFeatureState.values.length}',
            ),
            DisplayFeatureSubScreen(
              anchorPoint: Offset.zero,
              child: Text('SubScreen content'),
            ),
          ],
        ),
      ),
    ),
  );
}
