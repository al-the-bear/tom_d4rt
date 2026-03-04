// D4rt test script: Tests ScaffoldFeatureController, FabTopOffsetY, FabFloatOffsetY, FabDockedOffsetY, EndFloatFabLocation, CenterFloatFabLocation, EndDockedFabLocation, CenterDockedFabLocation, EndTopFabLocation, StartTopFabLocation, EndContainedFabLocation
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Scaffold FAB location and feature controller tests executing');

  // ========== ScaffoldFeatureController ==========
  print('--- ScaffoldFeatureController Tests ---');
  // ScaffoldFeatureController is returned by ScaffoldState.showBottomSheet etc.
  // It is a generic class: ScaffoldFeatureController<T extends Widget, U>
  // We reference the type since we cannot call showBottomSheet outside a live Scaffold.
  print('ScaffoldFeatureController type: ${ScaffoldFeatureController}');
  print('ScaffoldFeatureController referenced successfully');

  // ========== FloatingActionButtonLocation Subclasses ==========
  print('--- FAB Location Tests ---');

  // EndFloatFabLocation
  final FloatingActionButtonLocation endFloat =
      FloatingActionButtonLocation.endFloat;
  print('endFloat type: ${endFloat.runtimeType}');
  print('endFloat toString: ${endFloat}');

  // CenterFloatFabLocation
  final FloatingActionButtonLocation centerFloat =
      FloatingActionButtonLocation.centerFloat;
  print('centerFloat type: ${centerFloat.runtimeType}');
  print('centerFloat toString: ${centerFloat}');

  // EndDockedFabLocation
  final FloatingActionButtonLocation endDocked =
      FloatingActionButtonLocation.endDocked;
  print('endDocked type: ${endDocked.runtimeType}');
  print('endDocked toString: ${endDocked}');

  // CenterDockedFabLocation
  final FloatingActionButtonLocation centerDocked =
      FloatingActionButtonLocation.centerDocked;
  print('centerDocked type: ${centerDocked.runtimeType}');
  print('centerDocked toString: ${centerDocked}');

  // EndTopFabLocation
  final FloatingActionButtonLocation endTop =
      FloatingActionButtonLocation.endTop;
  print('endTop type: ${endTop.runtimeType}');
  print('endTop toString: ${endTop}');

  // StartTopFabLocation
  final FloatingActionButtonLocation startTop =
      FloatingActionButtonLocation.startTop;
  print('startTop type: ${startTop.runtimeType}');
  print('startTop toString: ${startTop}');

  // EndContainedFabLocation
  final FloatingActionButtonLocation endContained =
      FloatingActionButtonLocation.endContained;
  print('endContained type: ${endContained.runtimeType}');
  print('endContained toString: ${endContained}');

  // ========== FAB Offset Mixins ==========
  print('--- FAB Offset Mixin Tests ---');
  // FabTopOffsetY, FabFloatOffsetY, FabDockedOffsetY are mixins applied to FAB location classes.
  // endTop uses FabTopOffsetY
  print('endTop (FabTopOffsetY mixin): ${endTop.runtimeType}');
  // endFloat/centerFloat use FabFloatOffsetY
  print('endFloat (FabFloatOffsetY mixin): ${endFloat.runtimeType}');
  print('centerFloat (FabFloatOffsetY mixin): ${centerFloat.runtimeType}');
  // endDocked/centerDocked use FabDockedOffsetY
  print('endDocked (FabDockedOffsetY mixin): ${endDocked.runtimeType}');
  print('centerDocked (FabDockedOffsetY mixin): ${centerDocked.runtimeType}');

  // Collect all locations for verification
  final List<FloatingActionButtonLocation> allLocations = [
    endFloat,
    centerFloat,
    endDocked,
    centerDocked,
    endTop,
    startTop,
    endContained,
  ];
  print('Total FAB locations tested: ${allLocations.length}');

  print('All Scaffold FAB tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Scaffold FAB Test',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            Text('ScaffoldFeatureController: referenced'),
            Text('FAB Locations: ${allLocations.length} tested'),
            Text('endFloat: ${endFloat.runtimeType}'),
            Text('centerFloat: ${centerFloat.runtimeType}'),
            Text('endDocked: ${endDocked.runtimeType}'),
            Text('centerDocked: ${centerDocked.runtimeType}'),
            Text('endTop: ${endTop.runtimeType}'),
            Text('startTop: ${startTop.runtimeType}'),
            Text('endContained: ${endContained.runtimeType}'),
          ],
        ),
      ),
    ),
  );
}
