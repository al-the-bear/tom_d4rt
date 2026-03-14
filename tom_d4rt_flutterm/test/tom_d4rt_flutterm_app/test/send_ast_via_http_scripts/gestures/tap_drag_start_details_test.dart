// D4rt test script: Tests TapDragStartDetails from gestures
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TapDragStartDetails test executing');

  // Create TapDragStartDetails
  final details = TapDragStartDetails(
    globalPosition: Offset(100.0, 200.0),
    localPosition: Offset(50.0, 100.0),
    kind: PointerDeviceKind.touch,
    consecutiveTapCount: 1,
  );

  print('Created: ${details.runtimeType}');

  // Test position properties
  print('\nPosition properties:');
  print('globalPosition: ${details.globalPosition}');
  print('localPosition: ${details.localPosition}');

  // Test device info
  print('\nDevice info:');
  print('kind: ${details.kind}');

  // Test consecutive tap count
  print('\nConsecutive tap count:');
  print('consecutiveTapCount: ${details.consecutiveTapCount}');

  // Explain purpose
  print('\nTapDragStartDetails purpose:');
  print('- Details when drag starts in tap-and-drag');
  print('- Called when movement exceeds threshold');
  print('- Contains starting position');
  print('- Used with BaseTapAndDragGestureRecognizer');

  // Transition from tap to drag
  print('\nTap to drag transition:');
  print('1. TapDragDownDetails (pointer down)');
  print('2. Small movement (still tap)');
  print('3. Movement > threshold');
  print('4. TapDragStartDetails (drag begins) <- this');
  print('5. TapDragUpdateDetails (drag continues)');

  // vs TapDragDownDetails
  print('\nDifference from TapDragDownDetails:');
  print('- TapDragDownDetails: any pointer down');
  print('- TapDragStartDetails: drag actually started');
  print('- May or may not get start after down');

  print('\nTapDragStartDetails test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'TapDragStartDetails Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Drag started in tap-and-drag'),
      Text('globalPosition: ${details.globalPosition}'),
      Text('After: movement > threshold'),
      Text('consecutiveTapCount: ${details.consecutiveTapCount}'),
    ],
  );
}
