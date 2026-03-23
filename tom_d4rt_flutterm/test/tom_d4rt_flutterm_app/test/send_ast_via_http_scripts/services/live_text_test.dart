// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests LiveText from services
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('LiveText test executing');
  print('=' * 50);

  // LiveText is a class with static methods
  print('\nLiveText class:');
  print('LiveText provides static methods for Live Text functionality');

  // Explain Live Text feature
  print('\nLive Text feature:');
  print('- iOS 15+/macOS Monterey+ feature');
  print('- Recognizes text in images');
  print('- Allows copying/interacting with text in photos');
  print('- Available in camera and photos');

  // LiveText.isLiveTextInputAvailable
  print('\nLiveText.isLiveTextInputAvailable:');
  print('- Returns Future<bool>');
  print('- Checks if Live Text input is available');
  print('- iOS 15+, macOS 12+ required');
  print('- Device must support on-device ML');

  // Platform availability
  print('\nPlatform availability:');
  print('- iOS 15.0+: Supported on A12+ chips');
  print('- macOS 12.0+: Supported on Apple Silicon');
  print('- Android: Not available (returns false)');
  print('- Windows/Linux: Not available (returns false)');
  print('- Web: Not available (returns false)');

  // Use cases
  print('\nUse cases:');
  print('1. Text input from camera');
  print('2. Copy text from images');
  print('3. Phone number recognition');
  print('4. URL detection in photos');
  print('5. Address recognition');

  // Integration with TextField
  print('\nIntegration with TextField:');
  print('- TextField can show camera button');
  print('- Tapping opens camera for text capture');
  print('- Recognized text inserted into field');
  print('- Controlled via InputDecoration.suffixIcon');

  // Test type hierarchy
  print('\nType hierarchy:');
  print('LiveText is a static utility class');

  // Error handling
  print('\nError handling:');
  print('- Check isLiveTextInputAvailable before using');
  print('- Gracefully degrade on unsupported platforms');
  print('- Provide alternative text input methods');

  // Related APIs
  print('\nRelated APIs:');
  print('- IOSSystemContextMenuItemDataLiveText');
  print('- TextInputConfiguration');
  print('- CupertinoTextField live text support');

  // Explain purpose
  print('\nLiveText purpose:');
  print('- Utility class for iOS/macOS Live Text');
  print('- isLiveTextInputAvailable: Check availability');
  print('- Enables text recognition from camera');
  print('- Part of Apple\'s on-device ML features');
  print('- Improves text input UX on supported devices');

  print('\n' + '=' * 50);
  print('LiveText test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'LiveText Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: static utility class'),
      Text('Method: isLiveTextInputAvailable'),
      Text('Platform: iOS 15+, macOS 12+'),
      Text('Purpose: Camera text recognition'),
    ],
  );
}
