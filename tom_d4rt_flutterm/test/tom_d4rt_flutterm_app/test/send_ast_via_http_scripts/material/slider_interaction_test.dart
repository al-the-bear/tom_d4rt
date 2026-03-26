// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests SliderInteraction from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SliderInteraction test executing');
  print('=' * 50);

  // Enumerate all values
  print('\nSliderInteraction values:');
  for (final value in SliderInteraction.values) {
    print('  ${value.name}: index=${value.index}');
  }
  print('SliderInteraction has ${SliderInteraction.values.length} values');

  // First and last
  final first = SliderInteraction.values.first;
  final last = SliderInteraction.values.last;
  print('\nFirst: $first (${first.name}, index ${first.index})');
  print('Last: $last (${last.name}, index ${last.index})');

  // Specific values
  print('\nSpecific values:');
  print('tapAndSlide: ${SliderInteraction.tapAndSlide.name} (index ${SliderInteraction.tapAndSlide.index})');
  print('tapOnly: ${SliderInteraction.tapOnly.name} (index ${SliderInteraction.tapOnly.index})');
  print('slideOnly: ${SliderInteraction.slideOnly.name} (index ${SliderInteraction.slideOnly.index})');
  print('slideThumb: ${SliderInteraction.slideThumb.name} (index ${SliderInteraction.slideThumb.index})');

  // Usage description
  print('\nUsage context:');
  print('tapAndSlide: User can tap anywhere and slide the thumb');
  print('  Default behavior for most sliders');
  print('tapOnly: User can only tap to set value, no sliding');
  print('  Useful for discrete value selection');
  print('slideOnly: User can only slide, tapping has no effect');
  print('  Prevents accidental value changes');
  print('slideThumb: User can only slide by dragging the thumb');
  print('  Most precise interaction mode');

  // Equality
  print('\nEquality tests:');
  print('tapAndSlide == tapAndSlide: ${SliderInteraction.tapAndSlide == SliderInteraction.tapAndSlide}');
  print('tapAndSlide == tapOnly: ${SliderInteraction.tapAndSlide == SliderInteraction.tapOnly}');
  print('identical: ${identical(SliderInteraction.tapAndSlide, SliderInteraction.values[0])}');

  // Type checks
  print('\nType checks:');
  print('runtimeType: ${first.runtimeType}');
  print('is SliderInteraction: ${first is SliderInteraction}');
  print('is Enum: ${first is Enum}');

  // String representations
  print('\nString representations:');
  for (final value in SliderInteraction.values) {
    print('  toString: $value, name: ${value.name}');
  }

  // Usage with SliderThemeData
  print('\nSliderThemeData integration:');
  for (final interaction in SliderInteraction.values) {
    final theme = SliderThemeData(allowedInteraction: interaction);
    print('  ${interaction.name}: ${theme.allowedInteraction}');
  }

  // Default theme value
  final defaultTheme = SliderThemeData();
  print('\nDefault allowedInteraction: ${defaultTheme.allowedInteraction}');

  // Detailed iteration with index
  print('\nIndexed iteration:');
  for (var i = 0; i < SliderInteraction.values.length; i++) {
    final v = SliderInteraction.values[i];
    print('  [$i] ${v.name} (index=${v.index})');
  }

  print('\n' + '=' * 50);
  print('SliderInteraction test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'SliderInteraction Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Values: ${SliderInteraction.values.length}'),
      for (final v in SliderInteraction.values)
        Text('  ${v.name} (${v.index})'),
      Text('SliderTheme: all interactions supported'),
    ],
  );
}
