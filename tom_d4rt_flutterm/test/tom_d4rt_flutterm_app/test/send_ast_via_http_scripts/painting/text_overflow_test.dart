// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests TextOverflow from painting
import 'package:flutter/painting.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TextOverflow test executing');
  print('=' * 50);

  // TextOverflow enum overview
  print('TextOverflow enum overview:');
  print('  - How to handle overflowed text');
  print('  - Used in Text widget');
  print('  - 4 values: clip, fade, ellipsis, visible');

  // Enumerate all values
  print('\nTextOverflow values:');
  for (final value in TextOverflow.values) {
    print('  ${value.name}: index=${value.index}');
  }
  print('TextOverflow has ${TextOverflow.values.length} values');

  // Test clip
  print('\nTest TextOverflow.clip:');
  final clip = TextOverflow.clip;
  print('  Name: ${clip.name}');
  print('  Behavior: Hard cut at boundary');

  // Test fade
  print('\nTest TextOverflow.fade:');
  final fade = TextOverflow.fade;
  print('  Name: ${fade.name}');
  print('  Behavior: Gradient fade at edge');

  // Test ellipsis
  print('\nTest TextOverflow.ellipsis:');
  final ellipsis = TextOverflow.ellipsis;
  print('  Name: ${ellipsis.name}');
  print('  Behavior: Shows ... at end');

  // Test visible
  print('\nTest TextOverflow.visible:');
  final visible = TextOverflow.visible;
  print('  Name: ${visible.name}');
  print('  Behavior: Text extends beyond bounds');

  // First and last
  print('\nFirst and last:');
  print('  First: ${TextOverflow.values.first}');
  print('  Last: ${TextOverflow.values.last}');

  // Usage context
  print('\nUsage context:');
  print('  Text.overflow');
  print('  RichText.overflow');
  print('  TextPainter.ellipsis');

  // Common patterns
  print('\nCommon patterns:');
  print('  List items: ellipsis');
  print('  Headlines: fade');
  print('  Debug: visible');
  print('  Containers: clip');

  // Switch pattern
  print('\nSwitch pattern:');
  final overflow = TextOverflow.ellipsis;
  switch (overflow) {
    case TextOverflow.clip:
      print('  Clipping text');
      break;
    case TextOverflow.fade:
      print('  Fading text');
      break;
    case TextOverflow.ellipsis:
      print('  Adding ellipsis');
      break;
    case TextOverflow.visible:
      print('  Text overflows visibly');
      break;
  }

  print('\n' + '=' * 50);
  print('TextOverflow test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TextOverflow Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      SizedBox(height: 8),
      Text('Type: Enum'),
      Text('Values: clip, fade, ellipsis, visible'),
      Text('Purpose: Overflow handling'),
    ],
  );
}
