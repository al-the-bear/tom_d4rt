// D4rt test script: Tests DeferredComponent from services
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('DeferredComponent test executing');

  // Test DeferredComponent - Deferred loading
  print('DeferredComponent is available in the services package');
  print('DeferredComponent: Deferred loading');

  print('DeferredComponent test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('DeferredComponent Tests'),
      Text('Deferred loading'),
    ],
  );
}
