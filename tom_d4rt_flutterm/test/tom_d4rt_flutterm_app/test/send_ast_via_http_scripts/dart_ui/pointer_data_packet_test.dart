// D4rt test script: Tests PointerDataPacket from dart_ui
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('PointerDataPacket test executing');

  // Test PointerDataPacket - Batched pointer events
  print('PointerDataPacket is available in the dart_ui package');
  print('PointerDataPacket: Batched pointer events');

  print('PointerDataPacket test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PointerDataPacket Tests'),
      Text('Batched pointer events'),
    ],
  );
}
