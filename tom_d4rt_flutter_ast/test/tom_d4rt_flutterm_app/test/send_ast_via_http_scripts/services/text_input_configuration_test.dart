// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests TextInputConfiguration from services
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TextInputConfiguration test executing');
  print('=' * 50);

  // Create TextInputConfiguration
  final config = TextInputConfiguration(
    inputType: TextInputType.text,
    obscureText: false,
    autocorrect: true,
    actionLabel: 'Done',
    inputAction: TextInputAction.done,
    keyboardAppearance: Brightness.light,
  );
  print('\nTextInputConfiguration created:');
  print('runtimeType: ${config.runtimeType}');
  print('inputType: ${config.inputType}');
  print('obscureText: ${config.obscureText}');
  print('autocorrect: ${config.autocorrect}');
  print('inputAction: ${config.inputAction}');

  // Email configuration
  print('\nEmail input configuration:');
  final emailConfig = TextInputConfiguration(
    inputType: TextInputType.emailAddress,
    autocorrect: false,
    enableSuggestions: false,
    inputAction: TextInputAction.next,
  );
  print('inputType: ${emailConfig.inputType}');
  print('autocorrect: ${emailConfig.autocorrect}');

  // Password configuration
  print('\nPassword configuration:');
  final passwordConfig = TextInputConfiguration(
    inputType: TextInputType.visiblePassword,
    obscureText: true,
    autocorrect: false,
    enableSuggestions: false,
  );
  print('obscureText: ${passwordConfig.obscureText}');
  print('autocorrect: ${passwordConfig.autocorrect}');

  // Multiline configuration
  print('\nMultiline configuration:');
  final multiConfig = TextInputConfiguration(
    inputType: TextInputType.multiline,
    inputAction: TextInputAction.newline,
  );
  print('inputType: ${multiConfig.inputType}');
  print('inputAction: ${multiConfig.inputAction}');

  // Configuration properties
  print('\nAll configuration properties:');
  print('- inputType: Keyboard type');
  print('- readOnly: Disable editing');
  print('- obscureText: Hide input');
  print('- autocorrect: Auto-correction');
  print('- smartDashesType: Smart dashes');
  print('- smartQuotesType: Smart quotes');
  print('- enableSuggestions: Show suggestions');
  print('- inputAction: Keyboard action');
  print('- keyboardAppearance: Light/dark');
  print('- textCapitalization: Capitalization');
  print('- autofillHints: Autofill hints');

  // JSON serialization
  print('\nJSON serialization:');
  print('toJson() converts to platform channel format');

  // Explain purpose
  print('\nTextInputConfiguration purpose:');
  print('- Configures text input behavior');
  print('- Passed to platform text input');
  print('- Affects keyboard appearance');
  print('- Controls autocorrection/suggestions');
  print('- Used by TextInput.attach()');

  print('\n' + '=' * 50);
  print('TextInputConfiguration test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'TextInputConfiguration Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: ${config.runtimeType}'),
      Text('inputType: ${config.inputType}'),
      Text('autocorrect: ${config.autocorrect}'),
      Text('Purpose: Input behavior config'),
    ],
  );
}
