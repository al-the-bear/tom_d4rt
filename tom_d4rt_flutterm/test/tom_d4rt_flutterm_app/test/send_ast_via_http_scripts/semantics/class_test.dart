// ignore_for_file: avoid_print
// D4rt test script: Tests Semantics class from semantics
import 'package:flutter/semantics.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Semantics class test executing');
  print('=' * 50);

  // Semantics widget
  print('\nSemantics widget:');
  print('Annotates widget tree with semantics info');
  print('Primary widget for accessibility metadata');

  // Create instance explanation
  print('\nSemantics constructor parameters:');
  print('- label: Screen reader text');
  print('- hint: Usage hint');
  print('- value: Current value');
  print('- button: Is a button');
  print('- enabled: Interaction enabled');
  print('- checked: Checkbox state');
  print('- selected: Selection state');
  print('- onTap: Tap callback');
  print('- onLongPress: Long press callback');

  // SemanticsProperties
  print('\nSemanticsProperties:');
  final props = SemanticsProperties(
    label: 'Button label',
    hint: 'Double tap to activate',
    button: true,
    enabled: true,
  );
  print('label: ${props.label}');
  print('hint: ${props.hint}');
  print('button: ${props.button}');
  print('enabled: ${props.enabled}');

  // SemanticsNode
  print('\nSemanticsNode:');
  print('Node in the semantics tree');
  print('Contains semantics data for one element');
  print('Has rect, transform, children');

  // SemanticsConfiguration
  print('\nSemanticsConfiguration:');
  final config = SemanticsConfiguration();
  config.label = 'Test element';
  config.isButton = true;
  print('label: ${config.label}');
  print('isButton: ${config.isButton}');

  // SemanticsAction
  print('\nSemanticsAction:');
  print('tap: ${SemanticsAction.tap.index}');
  print('longPress: ${SemanticsAction.longPress.index}');
  print('scrollUp: ${SemanticsAction.scrollUp.index}');
  print('scrollDown: ${SemanticsAction.scrollDown.index}');
  print('increase: ${SemanticsAction.increase.index}');
  print('decrease: ${SemanticsAction.decrease.index}');

  // SemanticsFlag
  print('\nSemanticsFlag:');
  print('hasCheckedState: ${SemanticsFlag.hasCheckedState.index}');
  print('isChecked: ${SemanticsFlag.isChecked.index}');
  print('isSelected: ${SemanticsFlag.isSelected.index}');
  print('isButton: ${SemanticsFlag.isButton.index}');
  print('isEnabled: ${SemanticsFlag.isEnabled.index}');

  // Type hierarchy
  print('\nSemantics-related types:');
  print('Semantics (widget)');
  print('SemanticsProperties');
  print('SemanticsConfiguration');
  print('SemanticsNode');
  print('SemanticsAction');
  print('SemanticsFlag');
  print('SemanticsEvent');

  // Explain purpose
  print('\nSemantics purpose:');
  print('- Accessibility metadata');
  print('- Screen reader support');
  print('- Platform accessibility APIs');
  print('- Semantics tree building');
  print('- A11y testing support');

  print('\n' + '=' * 50);
  print('Semantics class test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'Semantics Class Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('SemanticsProperties: ${props.label}'),
      Text('SemanticsConfiguration: ${config.label}'),
      Text('SemanticsAction: tap, longPress...'),
      Text('Purpose: Accessibility'),
    ],
  );
}
