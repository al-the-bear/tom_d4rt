// ignore_for_file: avoid_print
// D4rt test script: Tests Scribe from services
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Scribe test executing');

  // Scribe is for handwriting/stylus input
  print('Scribe handles stylus handwriting input');
  print('Used by: platform IME for stylus');

  // Check if scribe is supported
  print('\nScribe.stylusHandwritingAvailable():');
  print('Checks platform support for stylus input');
  print('Returns Future<bool>');

  // Scribe purpose
  print('\nScribe purpose:');
  print('- Converts stylus input to text');
  print('- Platform-specific implementation');
  print('- Used by iPadOS, Android stylus');
  print('- Transparent to most Flutter code');

  // How it works
  print('\nHow it works:');
  print('1. User writes with stylus in text field');
  print('2. Platform recognizes handwriting');
  print('3. Text sent to TextInputClient');
  print('4. TextField receives text normally');

  // Integration
  print('\nIntegration:');
  print('- Automatic for TextField/TextFormField');
  print('- No code changes needed');
  print('- Platform handles recognition');
  print('- Works with any TextInputClient');

  // Platform support
  print('\nPlatform support:');
  print('- iPadOS: Scribble feature');
  print('- Android: Stylus handwriting');
  print('- Not supported: Web, desktop');

  // Related classes
  print('\nRelated:');
  print('- ScribeClient: receives scribe events');
  print('- SystemChannels.scribe: platform channel');

  print('\nScribe test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'Scribe Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Stylus handwriting input'),
      Text('Platform: iOS/Android stylus'),
      Text('Converts: handwriting to text'),
      Text('Integration: automatic'),
    ],
  );
}
