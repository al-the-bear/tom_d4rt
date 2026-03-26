// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests DynamicSchemeVariant from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DynamicSchemeVariant test executing');
  print('=' * 50);

  // Enumerate all values
  print('\nDynamicSchemeVariant values:');
  for (final value in DynamicSchemeVariant.values) {
    print('  ${value.name}: index=${value.index}');
  }
  print('DynamicSchemeVariant has ${DynamicSchemeVariant.values.length} values');

  // First and last
  final first = DynamicSchemeVariant.values.first;
  final last = DynamicSchemeVariant.values.last;
  print('\nFirst: $first (${first.name}, index ${first.index})');
  print('Last: $last (${last.name}, index ${last.index})');

  // Specific values
  print('\nSpecific values:');
  print('tonalSpot: ${DynamicSchemeVariant.tonalSpot.name} (index ${DynamicSchemeVariant.tonalSpot.index})');
  print('fidelity: ${DynamicSchemeVariant.fidelity.name} (index ${DynamicSchemeVariant.fidelity.index})');
  print('monochrome: ${DynamicSchemeVariant.monochrome.name} (index ${DynamicSchemeVariant.monochrome.index})');
  print('neutral: ${DynamicSchemeVariant.neutral.name} (index ${DynamicSchemeVariant.neutral.index})');
  print('vibrant: ${DynamicSchemeVariant.vibrant.name} (index ${DynamicSchemeVariant.vibrant.index})');
  print('expressive: ${DynamicSchemeVariant.expressive.name} (index ${DynamicSchemeVariant.expressive.index})');
  print('content: ${DynamicSchemeVariant.content.name} (index ${DynamicSchemeVariant.content.index})');
  print('rainbow: ${DynamicSchemeVariant.rainbow.name} (index ${DynamicSchemeVariant.rainbow.index})');
  print('fruitSalad: ${DynamicSchemeVariant.fruitSalad.name} (index ${DynamicSchemeVariant.fruitSalad.index})');

  // Equality
  print('\nEquality tests:');
  print('tonalSpot == tonalSpot: ${DynamicSchemeVariant.tonalSpot == DynamicSchemeVariant.tonalSpot}');
  print('tonalSpot == fidelity: ${DynamicSchemeVariant.tonalSpot == DynamicSchemeVariant.fidelity}');
  print('identical: ${identical(DynamicSchemeVariant.tonalSpot, DynamicSchemeVariant.values[0])}');

  // Type checks
  print('\nType checks:');
  print('runtimeType: ${first.runtimeType}');
  print('is DynamicSchemeVariant: ${first is DynamicSchemeVariant}');
  print('is Enum: ${first is Enum}');

  // String representations
  print('\nString representations:');
  for (final value in DynamicSchemeVariant.values) {
    print('  $value => ${value.name}');
  }

  // Usage with ColorScheme.fromSeed
  print('\nColorScheme.fromSeed with variants:');
  final seedColor = Colors.blue;
  for (final variant in DynamicSchemeVariant.values) {
    final scheme = ColorScheme.fromSeed(
      seedColor: seedColor,
      dynamicSchemeVariant: variant,
    );
    print('  ${variant.name}: primary=${scheme.primary}, secondary=${scheme.secondary}');
  }

  print('\nSeed color used: $seedColor');
  print('\n' + '=' * 50);
  print('DynamicSchemeVariant test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'DynamicSchemeVariant Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Values: ${DynamicSchemeVariant.values.length}'),
      for (final v in DynamicSchemeVariant.values)
        Text('  ${v.name} (${v.index})'),
    ],
  );
}
