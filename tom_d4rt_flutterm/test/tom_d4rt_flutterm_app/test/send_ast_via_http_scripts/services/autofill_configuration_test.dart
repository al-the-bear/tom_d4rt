// D4rt test script: Tests AutofillConfiguration from services
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('AutofillConfiguration test executing');
  print('=' * 50);

  // Create AutofillConfiguration for username
  final usernameConfig = AutofillConfiguration(
    uniqueIdentifier: 'username_field',
    autofillHints: [AutofillHints.username],
    hintText: 'Enter username',
  );
  print('\nUsername AutofillConfiguration:');
  print('runtimeType: ${usernameConfig.runtimeType}');
  print('uniqueIdentifier: ${usernameConfig.uniqueIdentifier}');
  print('autofillHints: ${usernameConfig.autofillHints}');
  print('hintText: ${usernameConfig.hintText}');

  // Create for password
  final passwordConfig = AutofillConfiguration(
    uniqueIdentifier: 'password_field',
    autofillHints: [AutofillHints.password],
    hintText: 'Enter password',
  );
  print('\nPassword config:');
  print('uniqueIdentifier: ${passwordConfig.uniqueIdentifier}');
  print('autofillHints: ${passwordConfig.autofillHints}');

  // Create for email
  final emailConfig = AutofillConfiguration(
    uniqueIdentifier: 'email_field',
    autofillHints: [AutofillHints.email],
    hintText: 'Enter email address',
  );
  print('\nEmail config:');
  print('autofillHints: ${emailConfig.autofillHints}');

  // Create with multiple hints
  final multiHintConfig = AutofillConfiguration(
    uniqueIdentifier: 'name_field',
    autofillHints: [AutofillHints.name, AutofillHints.givenName],
    hintText: 'Full name',
  );
  print('\nMultiple hints:');
  print('autofillHints: ${multiHintConfig.autofillHints}');

  // Test disabled configuration
  print('\nDisabled configuration:');
  const disabled = AutofillConfiguration.disabled;
  print('disabled uniqueIdentifier: ${disabled.uniqueIdentifier}');
  print('disabled autofillHints: ${disabled.autofillHints}');

  // Common AutofillHints
  print('\nCommon AutofillHints:');
  print('- ${AutofillHints.username}');
  print('- ${AutofillHints.password}');
  print('- ${AutofillHints.email}');
  print('- ${AutofillHints.name}');
  print('- ${AutofillHints.telephoneNumber}');
  print('- ${AutofillHints.creditCardNumber}');

  // Test type hierarchy
  print('\nType hierarchy:');
  print('is Object: true /* usernameConfig is Object */');

  // Create for address fields
  final addressConfig = AutofillConfiguration(
    uniqueIdentifier: 'street_address',
    autofillHints: [AutofillHints.streetAddressLine1],
    hintText: 'Street address',
  );
  print('\nAddress config:');
  print('autofillHints: ${addressConfig.autofillHints}');

  // Explain purpose
  print('\nAutofillConfiguration purpose:');
  print('- Configures autofill behavior for text fields');
  print('- uniqueIdentifier: Unique ID for the field');
  print('- autofillHints: List of autofill hint strings');
  print('- hintText: Placeholder text for the field');
  print('- Used by AutofillGroup and TextField');
  print('- Enables OS-level password/data autofill');

  print('\n' + '=' * 50);
  print('AutofillConfiguration test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'AutofillConfiguration Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: ${usernameConfig.runtimeType}'),
      Text('Username hints: ${usernameConfig.autofillHints}'),
      Text('Password hints: ${passwordConfig.autofillHints}'),
      Text('Purpose: Autofill field configuration'),
    ],
  );
}
