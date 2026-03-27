// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests TextMagnifierConfiguration from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TextMagnifierConfiguration test executing');
  print('=' * 50);

  // Test disabled configuration (constant)
  print('Testing TextMagnifierConfiguration.disabled:');
  final disabled = TextMagnifierConfiguration.disabled;
  print('  magnifierBuilder: returns null (disabled)');
  print('  shouldDisplayHandlesInMagnifier: ${disabled.shouldDisplayHandlesInMagnifier}');

  // Test custom configuration
  print('\nTesting TextMagnifierConfiguration() constructor:');
  final custom = TextMagnifierConfiguration(
    shouldDisplayHandlesInMagnifier: false,
    magnifierBuilder: (context, controller, info) {
      // Custom magnifier implementation
      return null;
    },
  );
  print('  shouldDisplayHandlesInMagnifier: ${custom.shouldDisplayHandlesInMagnifier}');
  print('  magnifierBuilder: custom function');

  // Class properties
  print('\nTextMagnifierConfiguration properties:');
  print('  - magnifierBuilder: MagnifierBuilder');
  print('  - shouldDisplayHandlesInMagnifier: bool');

  // MagnifierBuilder signature
  print('\nMagnifierBuilder typedef:');
  print('  Widget? Function(');
  print('    BuildContext context,');
  print('    MagnifierController controller,');
  print('    ValueNotifier<MagnifierInfo> magnifierInfo,');
  print('  )');

  // shouldDisplayHandlesInMagnifier usage
  print('\nshouldDisplayHandlesInMagnifier usage:');
  print('  - Controls Overlay layer order');
  print('  - true: handles above magnifier');
  print('  - false: magnifier above handles');
  print('  - Affects SelectionOverlay.showMagnifier');

  // Default behavior
  print('\nDefault behavior:');
  print('  - Default constructor: enabled (non-null builder)');
  print('  - .disabled constant: returns null for all builds');
  print('  - shouldDisplayHandlesInMagnifier defaults to true');

  // Platform usage
  print('\nPlatform usage:');
  print('  - iOS: CupertinoTextMagnifier');
  print('  - Android: MaterialTextMagnifier (Loupe)');
  print('  - Desktop: Usually disabled');

  // Integration
  print('\nIntegration points:');
  print('  - TextField magnifierConfiguration parameter');
  print('  - SelectableRegion magnifierConfiguration parameter');
  print('  - EditableText magnifierConfiguration parameter');

  // runtimeType
  print('\nType verification:');
  print('  disabled.runtimeType: ${disabled.runtimeType}');
  print('  custom.runtimeType: ${custom.runtimeType}');

  print('\n' + '=' * 50);
  print('TextMagnifierConfiguration test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'TextMagnifierConfiguration Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: Configuration class'),
      Text('Constant: disabled'),
      Text('Props: magnifierBuilder, shouldDisplayHandlesInMagnifier'),
    ],
  );
}
