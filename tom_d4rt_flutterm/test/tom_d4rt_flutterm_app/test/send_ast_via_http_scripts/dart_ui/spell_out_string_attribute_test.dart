// D4rt test script: Tests SpellOutStringAttribute from dart:ui
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SpellOutStringAttribute test executing');
  print('=' * 50);

  // SpellOutStringAttribute for accessibility
  print('\nSpellOutStringAttribute:');
  print('StringAttribute for spelling out text');
  print('Screen readers spell each character');

  // Create instance
  final attr1 = ui.SpellOutStringAttribute(range: TextRange(start: 0, end: 5));
  print('\nInstance created:');
  print('range: start=${attr1.range.start}, end=${attr1.range.end}');

  // Properties
  print('\nProperties:');
  print('range: ${attr1.range}');
  print('runtimeType: ${attr1.runtimeType}');

  // Second instance
  final attr2 = ui.SpellOutStringAttribute(
    range: TextRange(start: 10, end: 20),
  );
  print('\nSecond instance:');
  print('range: ${attr2.range}');

  // Extends StringAttribute
  print('\nExtends StringAttribute:');
  print('is StringAttribute: ${attr1 is ui.StringAttribute}');

  // When to use
  print('\nWhen to use:');
  print('- Abbreviations: "FBI", "NASA"');
  print('- Codes: "123ABC"');
  print('- Passwords: masked characters');
  print('- License plates');
  print('- Serial numbers');

  // Screen reader behavior
  print('\nScreen reader behavior:');
  print('');
  print('Without SpellOutStringAttribute:');
  print('  "FBI" -> reads as "fbi" (word)');
  print('');
  print('With SpellOutStringAttribute:');
  print('  "FBI" -> reads as "F, B, I"');

  // Usage in AttributedString
  print('\nUsage in AttributedString:');
  print('AttributedString(');
  print('  "FBI agent",');
  print('  attributes: [');
  print('    SpellOutStringAttribute(');
  print('      range: TextRange(start: 0, end: 3),');
  print('    ),');
  print('  ],');
  print(');');

  // Type hierarchy
  print('\nType hierarchy:');
  print('StringAttribute');
  print('  \u2514\u2500 SpellOutStringAttribute');

  // Explain purpose
  print('\nSpellOutStringAttribute purpose:');
  print('- Spell out text for accessibility');
  print('- Screen reader character-by-character');
  print('- range property for text span');
  print('- Used in AttributedString');
  print('- Extends StringAttribute');

  print('\n${'=' * 50}');
  print('SpellOutStringAttribute test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'SpellOutStringAttribute Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Range: ${attr1.range}'),
      Text('Is StringAttribute: ${attr1 is ui.StringAttribute}'),
      Text('For: abbreviations, codes'),
      Text('Purpose: Spell out text'),
    ],
  );
}
