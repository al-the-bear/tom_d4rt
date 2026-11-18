// ignore_for_file: avoid_print
// D4rt test script: BottomSheet, MaterialRouteTransitionMixin,
// PredictiveBackPageTransitionsBuilder (material, addtests2).
//
// MaterialRouteTransitionMixin is a mixin a script cannot apply to a route
// of its own (the interpreter cannot mix a bridged mixin into a script
// class), so the script uses it through MaterialPageRoute, which mixes it in.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== BottomSheet ===');
  var closed = 0;
  final sheet = BottomSheet(
    onClosing: () => closed++,
    enableDrag: false,
    builder: (context) => const SizedBox(height: 80, child: Text('sheet')),
  );
  print('sheet enableDrag: ${sheet.enableDrag}');
  sheet.onClosing();
  print('sheet closed: $closed');

  print('=== MaterialRouteTransitionMixin ===');
  final MaterialRouteTransitionMixin<void> route = MaterialPageRoute<void>(
    builder: (context) => const Text('page'),
  );
  final content = route.buildContent(context);
  print('route content: ${content is Text ? content.data : content.runtimeType}');
  final other = MaterialPageRoute<void>(builder: (context) => const SizedBox());
  print('route can transition to page route: ${route.canTransitionTo(other)}');
  print('route maintainState: ${route.maintainState}');
  print('route opaque: ${route.opaque}');

  print('=== PredictiveBackPageTransitionsBuilder ===');
  const builder = PredictiveBackPageTransitionsBuilder();
  const transitions = PageTransitionsTheme(
    builders: {TargetPlatform.android: builder},
  );
  print(
    'builder registered: ${identical(transitions.builders[TargetPlatform.android], builder)}',
  );
  print('builder type: ${builder.runtimeType}');

  return Align(alignment: Alignment.bottomCenter, child: sheet);
}
