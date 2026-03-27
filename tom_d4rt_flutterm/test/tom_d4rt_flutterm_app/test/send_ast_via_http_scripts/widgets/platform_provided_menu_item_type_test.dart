// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests PlatformProvidedMenuItemType from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PlatformProvidedMenuItemType test executing');
  print('=' * 50);

  // === Test PlatformProvidedMenuItemType enum ===
  print('\nPlatformProvidedMenuItemType lists system menu types');

  // List all values
  print('\n--- Enum values ---');
  for (final type in PlatformProvidedMenuItemType.values) {
    print('PlatformProvidedMenuItemType.${type.name}');
  }

  // Test about
  print('\n--- Testing about ---');
  final about = PlatformProvidedMenuItemType.about;
  print('about.name: ${about.name}');
  print('about.index: ${about.index}');
  print('Shows About dialog');

  // Test quit
  print('\n--- Testing quit ---');
  final quit = PlatformProvidedMenuItemType.quit;
  print('quit.name: ${quit.name}');
  print('quit.index: ${quit.index}');
  print('Exits application');

  // Test servicesSubmenu
  print('\n--- Testing servicesSubmenu ---');
  final services = PlatformProvidedMenuItemType.servicesSubmenu;
  print('services.name: ${services.name}');
  print('Shows system services menu');

  // Test hide variations
  print('\n--- Testing hide variations ---');
  print('hide: Hide this app');
  print('hideOtherApplications: Hide other apps');  
  print('showAllApplications: Show all hidden');

  // Test window controls
  print('\n--- Testing window controls ---');
  print('minimizeWindow: Minimize window');
  print('zoomWindow: Zoom/maximize window');
  print('toggleFullScreen: Toggle fullscreen');
  print('arrangeWindowsInFront: Arrange windows');

  // Test speech
  print('\n--- Testing speech ---');
  print('startSpeaking: Begin text-to-speech');
  print('stopSpeaking: End text-to-speech');

  // Test comparison
  print('\n--- Testing comparison ---');
  print('about == quit: ${about == quit}');
  print('about == PlatformProvidedMenuItemType.about: ${about == PlatformProvidedMenuItemType.about}');

  // Platform support
  print('\n--- Platform support ---');
  print('These are macOS-specific menu items');
  print('Other platforms have no equivalents');
  print('Check PlatformProvidedMenuItem.hasMenu()');

  print('\n' + '=' * 50);
  print('PlatformProvidedMenuItemType test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'PlatformProvidedMenuItemType Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Values: ${PlatformProvidedMenuItemType.values.length}'),
      Text('about.index: ${about.index}'),
      Text('quit.index: ${quit.index}'),
    ],
  );
}
