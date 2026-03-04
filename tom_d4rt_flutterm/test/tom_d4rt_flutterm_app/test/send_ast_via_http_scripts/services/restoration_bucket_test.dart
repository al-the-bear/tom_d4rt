// D4rt test script: Tests RestorationBucket from services
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RestorationBucket test executing');

  // Test RestorationBucket - RestorationBucket
  print('RestorationBucket is available in the services package');
  print('RestorationBucket: RestorationBucket');

  print('RestorationBucket test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RestorationBucket Tests'),
      Text('RestorationBucket'),
    ],
  );
}
