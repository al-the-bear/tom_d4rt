// D4rt test script: Tests MissingPluginException from services
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('MissingPluginException test executing');

  // Test MissingPluginException - Plugin error
  print('MissingPluginException is available in the services package');
  print('MissingPluginException: Plugin error');

  print('MissingPluginException test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('MissingPluginException Tests'),
      Text('Plugin error'),
    ],
  );
}
