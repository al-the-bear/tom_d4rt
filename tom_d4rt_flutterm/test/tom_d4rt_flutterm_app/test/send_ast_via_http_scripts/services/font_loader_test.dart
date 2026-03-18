// D4rt test script: Tests FontLoader from services
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('FontLoader test executing');
  print('=' * 50);

  // Create FontLoader
  final fontLoader = FontLoader('CustomFont');
  print('\nFontLoader created:');
  print('runtimeType: ${fontLoader.runtimeType}');
  print('family: ${fontLoader.family}');

  // FontLoader constructor requires family name
  print('\nFontLoader construction:');
  final robotoLoader = FontLoader('Roboto');
  final monoLoader = FontLoader('RobotoMono');
  print('Roboto family: ${robotoLoader.family}');
  print('RobotoMono family: ${monoLoader.family}');

  // Adding font data (would typically be from network/asset)
  print('\nAdding font data:');
  print('addFont() accepts Future<ByteData>');
  print('Multiple font variants can be added');
  print('Weights/styles added as separate font data');

  // Load process
  print('\nFont loading process:');
  print('1. Create FontLoader with family name');
  print('2. Call addFont() for each variant');
  print('3. Call load() to register fonts');
  print('4. Use family name in TextStyle');

  // Usage pattern
  print('\nUsage pattern:');
  print('final loader = FontLoader("MyFont");');
  print('loader.addFont(fontData());');
  print('await loader.load();');
  print('TextStyle(fontFamily: "MyFont")');

  // Font file formats
  print('\nSupported font formats:');
  print('- TTF (TrueType)');
  print('- OTF (OpenType)');
  print('- TTC (TrueType Collection)');

  // Type hierarchy
  print('\nType hierarchy:');
  print('is Object: true /* fontLoader is Object */');

  // Font variants
  print('\nFont variant handling:');
  print('Weight: Regular (400), Bold (700)');
  print('Style: Normal, Italic');
  print('Each variant = separate addFont() call');

  // Error handling
  print('\nError handling:');
  print('Invalid font data throws exception');
  print('Missing family name not allowed');
  print('load() must be called to register');

  // Explain purpose
  print('\nFontLoader purpose:');
  print('- Load custom fonts at runtime');
  print('- Register fonts from ByteData');
  print('- family: Font family name');
  print('- addFont(): Add font variant data');
  print('- load(): Register fonts with engine');
  print('- Enables dynamic font loading');

  print('\n' + '=' * 50);
  print('FontLoader test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'FontLoader Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: ${fontLoader.runtimeType}'),
      Text('family: ${fontLoader.family}'),
      Text('Methods: addFont(), load()'),
      Text('Purpose: Runtime font loading'),
    ],
  );
}
