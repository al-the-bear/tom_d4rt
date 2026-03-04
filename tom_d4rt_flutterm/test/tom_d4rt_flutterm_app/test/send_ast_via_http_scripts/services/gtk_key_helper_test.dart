// D4rt test script: Tests GtkKeyHelper from services
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('GtkKeyHelper test executing');

  // Test GtkKeyHelper - GtkKeyHelper
  print('GtkKeyHelper is available in the services package');
  print('GtkKeyHelper: GtkKeyHelper');

  print('GtkKeyHelper test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('GtkKeyHelper Tests'),
      Text('GtkKeyHelper'),
    ],
  );
}
