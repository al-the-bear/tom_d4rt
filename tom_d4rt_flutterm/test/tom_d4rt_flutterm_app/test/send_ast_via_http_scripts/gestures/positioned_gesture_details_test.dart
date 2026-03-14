// D4rt test script: Tests PositionedGestureDetails from gestures
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PositionedGestureDetails test executing');

  // Test via subclass TapDownDetails (concrete implementation)
  final tapDetails = TapDownDetails(
    globalPosition: Offset(100.0, 200.0),
    localPosition: Offset(50.0, 100.0),
    kind: PointerDeviceKind.touch,
  );

  print('Using TapDownDetails (extends PositionedGestureDetails)');
  print('runtimeType: ${tapDetails.runtimeType}');

  // Test position properties
  print('\nPosition properties:');
  print('globalPosition: ${tapDetails.globalPosition}');
  print('localPosition: ${tapDetails.localPosition}');

  // Test kind
  print('\nDevice kind:');
  print('kind: ${tapDetails.kind}');

  // PositionedGestureDetails subclasses
  print('\nPositionedGestureDetails hierarchy:');
  print('- PositionedGestureDetails (abstract base)');
  print('  - TapDownDetails');
  print('  - TapUpDetails');
  print('  - LongPressStartDetails');
  print('  - LongPressMoveUpdateDetails');
  print('  - LongPressEndDetails');
  print('  - DragStartDetails');
  print('  - DragUpdateDetails');

  // Test another subclass
  print('\nDragStartDetails example:');
  final dragDetails = DragStartDetails(
    globalPosition: Offset(200.0, 300.0),
    localPosition: Offset(100.0, 150.0),
    sourceTimeStamp: Duration(milliseconds: 100),
    kind: PointerDeviceKind.mouse,
  );
  print('globalPosition: ${dragDetails.globalPosition}');
  print('localPosition: ${dragDetails.localPosition}');
  print('sourceTimeStamp: ${dragDetails.sourceTimeStamp}');

  // Explain purpose
  print('\nPositionedGestureDetails purpose:');
  print('- Base class for gesture detail objects');
  print('- Provides globalPosition and localPosition');
  print('- Includes pointer device kind');
  print('- Standard position info for callbacks');

  // Usage context
  print('\nUsage context:');
  print('- GestureDetector callback parameters');
  print('- onTapDown(TapDownDetails)');
  print('- onTapUp(TapUpDetails)');
  print('- onPanStart(DragStartDetails)');
  print('- etc.');

  print('\nPositionedGestureDetails test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'PositionedGestureDetails Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Base class for gesture details'),
      Text('globalPosition: ${tapDetails.globalPosition}'),
      Text('localPosition: ${tapDetails.localPosition}'),
      Text('Subclasses: TapDownDetails, DragStart...'),
    ],
  );
}
