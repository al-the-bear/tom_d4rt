// D4rt test script: Tests FloatingActionButtonLocation variants:
// StandardFabLocation, endFloat, centerFloat, endDocked, centerDocked,
// endTop, startTop, endContained, miniStartTop
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('FAB location types test executing');

  // ========== FloatingActionButtonLocation constants ==========
  print('--- FloatingActionButtonLocation Types ---');
  final locations = <String, FloatingActionButtonLocation>{
    'endFloat': FloatingActionButtonLocation.endFloat,
    'centerFloat': FloatingActionButtonLocation.centerFloat,
    'endDocked': FloatingActionButtonLocation.endDocked,
    'centerDocked': FloatingActionButtonLocation.centerDocked,
    'endTop': FloatingActionButtonLocation.endTop,
    'startTop': FloatingActionButtonLocation.startTop,
    'endContained': FloatingActionButtonLocation.endContained,
    'miniStartTop': FloatingActionButtonLocation.miniStartTop,
  };

  for (final entry in locations.entries) {
    print('  ${entry.key}: ${entry.value}');
    print('    type: ${entry.value.runtimeType}');
  }

  // ========== FloatingActionButtonAnimator ==========
  print('--- FloatingActionButtonAnimator Tests ---');
  final animator = FloatingActionButtonAnimator.scaling;
  print('FloatingActionButtonAnimator.scaling: $animator');

  // ========== FAB types ==========
  print('--- FloatingActionButton variants ---');
  final fab = FloatingActionButton(
    onPressed: () {},
    child: Icon(Icons.add),
    tooltip: 'Add',
    elevation: 6.0,
    focusElevation: 8.0,
    hoverElevation: 10.0,
    highlightElevation: 12.0,
    disabledElevation: 0.0,
    shape: CircleBorder(),
    clipBehavior: Clip.none,
    isExtended: false,
    materialTapTargetSize: MaterialTapTargetSize.padded,
  );
  print('FloatingActionButton created');

  final fabSmall = FloatingActionButton.small(
    onPressed: () {},
    child: Icon(Icons.edit),
  );
  print('FloatingActionButton.small created');

  final fabLarge = FloatingActionButton.large(
    onPressed: () {},
    child: Icon(Icons.camera),
  );
  print('FloatingActionButton.large created');

  final fabExtended = FloatingActionButton.extended(
    onPressed: () {},
    label: Text('Extended'),
    icon: Icon(Icons.navigation),
  );
  print('FloatingActionButton.extended created');

  // ========== MaterialTapTargetSize ==========
  print('--- MaterialTapTargetSize Tests ---');
  for (final size in MaterialTapTargetSize.values) {
    print('  MaterialTapTargetSize: $size');
  }

  print('All FAB location tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: Text('FAB Locations')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            fabSmall,
            SizedBox(height: 8),
            fabLarge,
            SizedBox(height: 8),
            fabExtended,
          ],
        ),
      ),
      floatingActionButton: fab,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
    ),
  );
}
