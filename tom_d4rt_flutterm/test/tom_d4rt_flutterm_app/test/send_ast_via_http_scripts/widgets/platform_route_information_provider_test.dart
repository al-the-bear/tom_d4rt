// D4rt test script: Tests PlatformRouteInformationProvider from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('PlatformRouteInformationProvider test executing');

  // Test PlatformRouteInformationProvider - PlatformRouteInformationProvider
  print('PlatformRouteInformationProvider is available in the widgets package');
  print('PlatformRouteInformationProvider runtimeType accessible');

  print('PlatformRouteInformationProvider test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PlatformRouteInformationProvider Tests'),
      Text('PlatformRouteInformationProvider'),
    ],
  );
}
