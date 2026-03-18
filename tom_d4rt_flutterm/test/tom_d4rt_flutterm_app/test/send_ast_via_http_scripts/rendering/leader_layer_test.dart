// D4rt test script: Tests LeaderLayer from rendering
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('LeaderLayer test executing');

  // Test LeaderLayer - Leader layer
  print('LeaderLayer is available in the rendering package');
  print('LeaderLayer: Leader layer');

  print('LeaderLayer test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('LeaderLayer Tests'),
      Text('Leader layer'),
    ],
  );
}
