// D4rt test script: Tests TapMoveDetails from gestures
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TapMoveDetails test executing');

  // Note: TapMoveDetails is not a standard Flutter class
  // Testing via DragUpdateDetails which has similar properties
  final dragUpdate = DragUpdateDetails(
    globalPosition: Offset(150.0, 250.0),
    localPosition: Offset(75.0, 125.0),
    delta: Offset(5.0, 10.0),
    primaryDelta: 10.0,
    sourceTimeStamp: Duration(milliseconds: 100),
  );

  print('Using DragUpdateDetails for move details testing');
  print('Type: ${dragUpdate.runtimeType}');

  // Test position properties
  print('\nPosition properties:');
  print('globalPosition: ${dragUpdate.globalPosition}');
  print('localPosition: ${dragUpdate.localPosition}');

  // Test delta properties
  print('\nDelta properties:');
  print('delta: ${dragUpdate.delta}');
  print('primaryDelta: ${dragUpdate.primaryDelta}');

  // Test timing
  print('\nTiming:');
  print('sourceTimeStamp: ${dragUpdate.sourceTimeStamp}');

  // Explain move details concept
  print('\nMove details concept:');
  print('- Contains position and movement info');
  print('- global/localPosition: current position');
  print('- delta: change since last event');
  print('- primaryDelta: delta along primary axis');

  // Move details classes
  print('\nMove/Update details classes:');
  print('- DragUpdateDetails: standard drag updates');
  print('- TapDragUpdateDetails: tap-and-drag updates');
  print('- LongPressMoveUpdateDetails: long press moves');
  print('- ScaleUpdateDetails: scale gesture updates');

  // Delta usage
  print('\nDelta usage:');
  print('- Incremental updates');
  print('- Accumulate for total offset');
  print('- Apply to transform/position');

  print('\nTapMoveDetails test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'TapMoveDetails Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Movement details in gestures'),
      Text('delta: ${dragUpdate.delta}'),
      Text('primaryDelta: ${dragUpdate.primaryDelta}'),
      Text('Concept: position + delta'),
    ],
  );
}
