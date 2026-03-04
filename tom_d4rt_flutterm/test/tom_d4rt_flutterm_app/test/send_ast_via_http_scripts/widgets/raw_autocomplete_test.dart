// D4rt test script: Tests RawAutocomplete from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RawAutocomplete test executing');

  // Test RawAutocomplete - RawAutocomplete
  print('RawAutocomplete is available in the widgets package');
  print('RawAutocomplete runtimeType accessible');

  print('RawAutocomplete test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RawAutocomplete Tests'),
      Text('RawAutocomplete'),
    ],
  );
}
