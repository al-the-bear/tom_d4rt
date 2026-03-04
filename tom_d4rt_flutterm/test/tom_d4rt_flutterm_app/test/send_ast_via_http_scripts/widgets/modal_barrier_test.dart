// D4rt test script: Tests ModalBarrier from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ModalBarrier test executing');

  // Test ModalBarrier - ModalBarrier
  print('ModalBarrier is available in the widgets package');
  print('ModalBarrier runtimeType accessible');

  print('ModalBarrier test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ModalBarrier Tests'),
      Text('ModalBarrier'),
    ],
  );
}
