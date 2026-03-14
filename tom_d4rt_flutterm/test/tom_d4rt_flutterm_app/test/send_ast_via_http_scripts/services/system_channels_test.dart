// D4rt test script: Tests SystemChannels from services
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SystemChannels test executing');

  // SystemChannels is a collection of static channels
  print('SystemChannels provides platform channels');

  // Test navigation channel
  print('\nNavigation channel:');
  final navChannel = SystemChannels.navigation;
  print('navigation type: ${navChannel.runtimeType}');
  print('name: ${navChannel.name}');
  print('Used for: back button, routes');

  // Test lifecycle channel
  print('\nLifecycle channel:');
  final lifecycleChannel = SystemChannels.lifecycle;
  print('lifecycle type: ${lifecycleChannel.runtimeType}');
  print('name: ${lifecycleChannel.name}');
  print('Used for: app state changes');

  // Test platform channel
  print('\nPlatform channel:');
  final platformChannel = SystemChannels.platform;
  print('platform type: ${platformChannel.runtimeType}');
  print('name: ${platformChannel.name}');
  print('Used for: clipboard, haptics');

  // Test text input channel
  print('\nText input channel:');
  final textInputChannel = SystemChannels.textInput;
  print('textInput type: ${textInputChannel.runtimeType}');
  print('name: ${textInputChannel.name}');
  print('Used for: keyboard input');

  // All available channels
  print('\nAll SystemChannels:');
  print('- navigation: route handling');
  print('- lifecycle: app state');
  print('- platform: clipboard, haptics');
  print('- textInput: keyboard');
  print('- keyEvent: key events');
  print('- accessibility: a11y');
  print('- menu: system menus');

  // When to use
  print('\nTypically used internally:');
  print('- Higher-level APIs wrap these');
  print('- Clipboard, HapticFeedback, etc.');
  print('- Direct use rare in apps');

  print('\nSystemChannels test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'SystemChannels Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Platform communication channels'),
      Text('navigation: ${navChannel.name}'),
      Text('lifecycle: ${lifecycleChannel.name}'),
      Text('platform: ${platformChannel.name}'),
    ],
  );
}
