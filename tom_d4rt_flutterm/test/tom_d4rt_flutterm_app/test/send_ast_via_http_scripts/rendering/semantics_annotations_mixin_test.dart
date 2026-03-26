// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests SemanticsAnnotationsMixin from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SemanticsAnnotationsMixin test executing');
  print('=' * 50);

  // SemanticsAnnotationsMixin is a mixin on RenderObject
  print('\nSemanticsAnnotationsMixin:');
  print('Type: mixin on RenderObject');
  print('Purpose: Adds semantics annotation capabilities');
  print('Used by: RenderSemanticsAnnotations, RenderSliverSemanticsAnnotations');
  print('Cannot be instantiated directly');

  // Key properties
  print('\nKey properties:');
  print('  properties -> SemanticsProperties (get/set)');
  print('  container -> bool (get/set)');
  print('  explicitChildNodes -> bool (get/set)');
  print('  excludeSemantics -> bool (get/set)');
  print('  blockUserActions -> bool (get/set)');

  // initSemanticsAnnotations method
  print('\ninitSemanticsAnnotations parameters:');
  print('  properties: SemanticsProperties');
  print('  container: bool');
  print('  explicitChildNodes: bool');
  print('  excludeSemantics: bool');
  print('  blockUserActions: bool');
  print('  localeForSubtree: Locale?');
  print('  textDirection: TextDirection?');

  // Concrete users
  print('\nConcrete classes using this mixin:');
  print('  RenderSemanticsAnnotations extends RenderProxyBox');
  print('    with SemanticsAnnotationsMixin');
  print('  RenderSliverSemanticsAnnotations extends RenderProxySliver');
  print('    with SemanticsAnnotationsMixin');

  // SemanticsProperties
  print('\nSemanticsProperties examples:');
  final props = SemanticsProperties(
    label: 'Example label',
    hint: 'Example hint',
    enabled: true,
    checked: false,
  );
  print('  label: ${props.label}');
  print('  hint: ${props.hint}');
  print('  enabled: ${props.enabled}');
  print('  checked: ${props.checked}');

  // Widget-level equivalent
  print('\nWidget-level equivalent:');
  print('  Semantics(');
  print('    label: "Button",');
  print('    hint: "Double tap to activate",');
  print('    container: true,');
  print('    child: ...,');
  print('  )');

  // Accessibility tree
  print('\nAccessibility tree impact:');
  print('  container=true: creates new semantics node');
  print('  excludeSemantics=true: hides child semantics');
  print('  explicitChildNodes=true: uses child nodes directly');
  print('  blockUserActions=true: prevents user interaction');

  print('\n==================================================');
  print('SemanticsAnnotationsMixin test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'SemanticsAnnotationsMixin Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: Mixin on RenderObject'),
      Text('Properties: container, excludeSemantics, ...'),
      Text('Widget: Semantics'),
      Text('Purpose: Add accessibility annotations'),
    ],
  );
}
