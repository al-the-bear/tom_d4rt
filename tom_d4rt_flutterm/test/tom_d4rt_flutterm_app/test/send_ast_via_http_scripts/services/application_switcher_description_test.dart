// D4rt test script: Tests ApplicationSwitcherDescription from services
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ApplicationSwitcherDescription test executing');
  print('=' * 50);

  // Create ApplicationSwitcherDescription with label only
  final desc1 = ApplicationSwitcherDescription(label: 'My App');
  print('\nApplicationSwitcherDescription with label:');
  print('runtimeType: ${desc1.runtimeType}');
  print('label: ${desc1.label}');
  print('primaryColor: ${desc1.primaryColor}');

  // Create with both label and color
  final desc2 = ApplicationSwitcherDescription(
    label: 'Flutter App',
    primaryColor: 0xFF6200EE,
  );
  print('\nWith label and color:');
  print('label: ${desc2.label}');
  print('primaryColor: ${desc2.primaryColor}');
  print('primaryColor hex: ${desc2.primaryColor?.toRadixString(16)}');

  // Create with null label
  final desc3 = ApplicationSwitcherDescription(primaryColor: 0xFF03DAC6);
  print('\nWith null label:');
  print('label: ${desc3.label}');
  print('primaryColor: ${desc3.primaryColor}');

  // Create with empty label
  final desc4 = ApplicationSwitcherDescription(label: '');
  print('\nWith empty label:');
  print('label: "${desc4.label}"');
  print('label isEmpty: ${desc4.label?.isEmpty}');

  // Test common color values
  print('\nCommon color configurations:');
  final material = ApplicationSwitcherDescription(
    label: 'Material',
    primaryColor: 0xFF6200EE,
  );
  final red = ApplicationSwitcherDescription(
    label: 'Red App',
    primaryColor: 0xFFFF0000,
  );
  final blue = ApplicationSwitcherDescription(
    label: 'Blue App',
    primaryColor: 0xFF0000FF,
  );
  print('Material purple: ${material.primaryColor?.toRadixString(16)}');
  print('Red: ${red.primaryColor?.toRadixString(16)}');
  print('Blue: ${blue.primaryColor?.toRadixString(16)}');

  // Test type hierarchy
  print('\nType hierarchy:');
  print('is Object: ${desc1 is Object}');

  // Color parsing examples
  print('\nColor interpretation:');
  final colorVal = desc2.primaryColor;
  if (colorVal != null) {
    final alpha = (colorVal >> 24) & 0xFF;
    final red = (colorVal >> 16) & 0xFF;
    final green = (colorVal >> 8) & 0xFF;
    final blue = colorVal & 0xFF;
    print('ARGB: A=$alpha, R=$red, G=$green, B=$blue');
  }

  // Compare descriptions
  print('\nDescription comparison:');
  final same1 = ApplicationSwitcherDescription(
    label: 'Test',
    primaryColor: 0xFF000000,
  );
  final same2 = ApplicationSwitcherDescription(
    label: 'Test',
    primaryColor: 0xFF000000,
  );
  print('same1 == same2: ${same1 == same2}');
  print('identical: ${identical(same1, same2)}');

  // Explain purpose
  print('\nApplicationSwitcherDescription purpose:');
  print('- Configures app appearance in OS task switcher');
  print('- label: Title shown in app switcher');
  print('- primaryColor: Header color in app switcher');
  print('- Pass to SystemChrome.setApplicationSwitcherDescription');
  print('- Android-specific but available cross-platform');

  print('\n' + '=' * 50);
  print('ApplicationSwitcherDescription test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'ApplicationSwitcherDescription Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: ${desc1.runtimeType}'),
      Text('label: ${desc2.label}'),
      Text('primaryColor: ${desc2.primaryColor?.toRadixString(16)}'),
      Text('Purpose: Task switcher configuration'),
    ],
  );
}
