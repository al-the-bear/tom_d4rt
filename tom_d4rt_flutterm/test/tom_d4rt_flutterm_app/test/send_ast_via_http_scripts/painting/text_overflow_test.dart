// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests TextOverflow from painting
import 'package:flutter/painting.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TextOverflow test executing');
  print('=' * 50);

  // Enumerate all values
  print('\nTextOverflow values:');
  for (final value in TextOverflow.values) {
    print('  ${value.name}: index=${value.index}');
  }
  print('TextOverflow has ${TextOverflow.values.length} values');

  // First and last
  final first = TextOverflow.values.first;
  final last = TextOverflow.values.last;
  print('\nFirst: $first (${first.name}, index ${first.index})');
  print('Last: $last (${last.name}, index ${last.index})');

  // Specific values with visual behavior
  print('\nSpecific values:');
  print('clip: ${TextOverflow.clip.name} (index ${TextOverflow.clip.index})');
  print('  Clips overflowing text at the container boundary');
  print('  Text is simply cut off, no visual indicator');
  print('  Default behavior in Flutter Text widget');
  print('fade: ${TextOverflow.fade.name} (index ${TextOverflow.fade.index})');
  print('  Fades overflowing text to transparent');
  print('  Applies a gradient from opaque to transparent at the edge');
  print('  Requires softWrap: false for single-line fade');
  print('ellipsis: ${TextOverflow.ellipsis.name} (index ${TextOverflow.ellipsis.index})');
  print('  Truncates text and appends an ellipsis (…)');
  print('  Most common for single-line text in lists');
  print('  Uses the Unicode ellipsis character U+2026');
  print('visible: ${TextOverflow.visible.name} (index ${TextOverflow.visible.index})');
  print('  Allows text to overflow and remain visible');
  print('  Text renders beyond container boundaries');
  print('  Useful for debugging or layered text effects');

  // CSS comparison
  print('\nCSS equivalents:');
  print('  clip -> overflow: hidden (no text-overflow)');
  print('  ellipsis -> text-overflow: ellipsis');
  print('  fade -> no direct CSS equivalent');
  print('  visible -> overflow: visible');

  // Text widget integration
  print('\nText widget integration:');
  for (final overflow in TextOverflow.values) {
    print('  Text("...", overflow: TextOverflow.${overflow.name})');
  }

  // Common patterns
  print('\nCommon patterns:');
  print('  List tile title: overflow: TextOverflow.ellipsis, maxLines: 1');
  print('  Description: overflow: TextOverflow.ellipsis, maxLines: 2');
  print('  Debug text: overflow: TextOverflow.visible');

  // Equality tests
  print('\nEquality tests:');
  print('clip == clip: ${TextOverflow.clip == TextOverflow.clip}');
  print('clip == ellipsis: ${TextOverflow.clip == TextOverflow.ellipsis}');
  print('identical: ${identical(TextOverflow.clip, TextOverflow.values[0])}');

  // Type checks
  print('\nType checks:');
  print('runtimeType: ${first.runtimeType}');
  print('is TextOverflow: ${first is TextOverflow}');
  print('is Enum: ${first is Enum}');

  // String representations
  print('\nString representations:');
  for (final value in TextOverflow.values) {
    print('  toString: $value, name: ${value.name}');
  }

  print('\n' + '=' * 50);
  print('TextOverflow test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'TextOverflow Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Values: ${TextOverflow.values.length}'),
      for (final v in TextOverflow.values)
        Text('  ${v.name} (${v.index})'),
      Text('Text: controls overflow rendering'),
    ],
  );
}
