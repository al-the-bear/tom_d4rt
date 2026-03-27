// ignore_for_file: avoid_print, deprecated_member_use
// D4rt test script: Tests DynamicSchemeVariant from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DynamicSchemeVariant test executing');
  print('=' * 50);

  // DynamicSchemeVariant is an enum with 9 values
  print('DynamicSchemeVariant enum values:');
  for (final variant in DynamicSchemeVariant.values) {
    print('  ${variant.name}: index=${variant.index}');
  }
  print('DynamicSchemeVariant has ${DynamicSchemeVariant.values.length} values');

  // Test first and last
  final first = DynamicSchemeVariant.values.first;
  final last = DynamicSchemeVariant.values.last;
  print('\nFirst value: $first (index ${first.index})');
  print('Last value: $last (index ${last.index})');

  // Test tonalSpot
  print('\nTesting DynamicSchemeVariant.tonalSpot:');
  final tonalSpot = DynamicSchemeVariant.tonalSpot;
  print('  name: ${tonalSpot.name}');
  print('  index: ${tonalSpot.index}');
  print('  Purpose: Default Material - pastel with low chroma');

  // Test fidelity
  print('\nTesting DynamicSchemeVariant.fidelity:');
  final fidelity = DynamicSchemeVariant.fidelity;
  print('  name: ${fidelity.name}');
  print('  Purpose: Matches seed color even if bright');

  // Test monochrome
  print('\nTesting DynamicSchemeVariant.monochrome:');
  final monochrome = DynamicSchemeVariant.monochrome;
  print('  name: ${monochrome.name}');
  print('  Purpose: All grayscale, no chroma');

  // Test neutral
  print('\nTesting DynamicSchemeVariant.neutral:');
  final neutral = DynamicSchemeVariant.neutral;
  print('  name: ${neutral.name}');
  print('  Purpose: Close to grayscale, hint of chroma');

  // Test vibrant
  print('\nTesting DynamicSchemeVariant.vibrant:');
  final vibrant = DynamicSchemeVariant.vibrant;
  print('  name: ${vibrant.name}');
  print('  Purpose: Pastel colors, high chroma');

  // Test expressive
  print('\nTesting DynamicSchemeVariant.expressive:');
  final expressive = DynamicSchemeVariant.expressive;
  print('  name: ${expressive.name}');
  print('  Purpose: Medium chroma, varied hues');

  // Test content
  print('\nTesting DynamicSchemeVariant.content:');
  final content = DynamicSchemeVariant.content;
  print('  name: ${content.name}');
  print('  Purpose: Like fidelity, matches seed');

  // Test rainbow
  print('\nTesting DynamicSchemeVariant.rainbow:');
  final rainbow = DynamicSchemeVariant.rainbow;
  print('  name: ${rainbow.name}');
  print('  Purpose: Playful - seed hue not used');

  // Test fruitSalad
  print('\nTesting DynamicSchemeVariant.fruitSalad:');
  final fruitSalad = DynamicSchemeVariant.fruitSalad;
  print('  name: ${fruitSalad.name}');
  print('  Purpose: Playful variant');

  // Usage with ColorScheme.fromSeed
  print('\nUsage with ColorScheme.fromSeed:');
  final scheme1 = ColorScheme.fromSeed(
    seedColor: Colors.blue,
    dynamicSchemeVariant: DynamicSchemeVariant.tonalSpot,
  );
  print('tonalSpot scheme primary: ${scheme1.primary}');

  final scheme2 = ColorScheme.fromSeed(
    seedColor: Colors.blue,
    dynamicSchemeVariant: DynamicSchemeVariant.vibrant,
  );
  print('vibrant scheme primary: ${scheme2.primary}');

  // Test equality
  print('\nEquality test: tonalSpot == tonalSpot: ${tonalSpot == tonalSpot}');

  print('\n' + '=' * 50);
  print('DynamicSchemeVariant test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('DynamicSchemeVariant Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      SizedBox(height: 8),
      Text('Values: ${DynamicSchemeVariant.values.length}'),
      Text('tonalSpot, fidelity, monochrome'),
      Text('neutral, vibrant, expressive'),
      Text('content, rainbow, fruitSalad'),
    ],
  );
}
