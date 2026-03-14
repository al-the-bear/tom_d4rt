// D4rt test script: Tests AutofillConfiguration from services
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('AutofillConfiguration comprehensive test executing');
  final results = <String>[];
  int passCount = 0;
  int failCount = 0;

  // Helper to record test results
  void recordTest(String name, bool passed) {
    if (passed) {
      passCount++;
      results.add('✓ $name');
      print('PASS: $name');
    } else {
      failCount++;
      results.add('✗ $name');
      print('FAIL: $name');
    }
  }

  // Test 1: AutofillConfiguration basic creation
  print('\n--- Test 1: AutofillConfiguration basic creation ---');
  try {
    final config = AutofillConfiguration(
      uniqueIdentifier: 'email_field_1',
      autofillHints: [AutofillHints.email],
      hintText: 'Enter your email',
    );
    assert(config.uniqueIdentifier == 'email_field_1');
    assert(config.autofillHints.contains(AutofillHints.email));
    print('Unique ID: ${config.uniqueIdentifier}');
    print('Hints: ${config.autofillHints}');
    print('Hint text: ${config.hintText}');
    recordTest('AutofillConfiguration basic creation', true);
  } catch (e) {
    print('Error: $e');
    recordTest('AutofillConfiguration basic creation', false);
  }

  // Test 2: Configuration with multiple hints
  print('\n--- Test 2: Configuration with multiple hints ---');
  try {
    final config = AutofillConfiguration(
      uniqueIdentifier: 'name_field',
      autofillHints: [AutofillHints.name, AutofillHints.givenName],
      hintText: 'Enter your name',
    );
    assert(config.autofillHints.length == 2);
    print('Multiple hints configured: ${config.autofillHints.length}');
    for (final hint in config.autofillHints) {
      print('  - $hint');
    }
    recordTest('Configuration with multiple hints', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Configuration with multiple hints', false);
  }

  // Test 3: Email configuration
  print('\n--- Test 3: Email configuration ---');
  try {
    final emailConfig = AutofillConfiguration(
      uniqueIdentifier: 'email_input',
      autofillHints: [AutofillHints.email],
      hintText: 'Email address',
    );
    assert(emailConfig.autofillHints.first == AutofillHints.email);
    print('Email config created');
    print('Hint: ${emailConfig.autofillHints.first}');
    recordTest('Email configuration', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Email configuration', false);
  }

  // Test 4: Password configuration
  print('\n--- Test 4: Password configuration ---');
  try {
    final pwConfig = AutofillConfiguration(
      uniqueIdentifier: 'password_input',
      autofillHints: [AutofillHints.password],
      hintText: 'Password',
    );
    assert(pwConfig.autofillHints.contains(AutofillHints.password));
    print('Password config created');
    print('Hint: ${pwConfig.autofillHints.first}');
    recordTest('Password configuration', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Password configuration', false);
  }

  // Test 5: New password configuration
  print('\n--- Test 5: New password configuration ---');
  try {
    final newPwConfig = AutofillConfiguration(
      uniqueIdentifier: 'new_password_input',
      autofillHints: [AutofillHints.newPassword],
      hintText: 'Create new password',
    );
    assert(newPwConfig.autofillHints.contains(AutofillHints.newPassword));
    print('New password config created');
    recordTest('New password configuration', true);
  } catch (e) {
    print('Error: $e');
    recordTest('New password configuration', false);
  }

  // Test 6: Username configuration
  print('\n--- Test 6: Username configuration ---');
  try {
    final userConfig = AutofillConfiguration(
      uniqueIdentifier: 'username_input',
      autofillHints: [AutofillHints.username],
      hintText: 'Username',
    );
    assert(userConfig.autofillHints.contains(AutofillHints.username));
    print('Username config created');
    recordTest('Username configuration', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Username configuration', false);
  }

  // Test 7: Phone configuration
  print('\n--- Test 7: Phone configuration ---');
  try {
    final phoneConfig = AutofillConfiguration(
      uniqueIdentifier: 'phone_input',
      autofillHints: [AutofillHints.telephoneNumber],
      hintText: 'Phone number',
    );
    assert(phoneConfig.autofillHints.contains(AutofillHints.telephoneNumber));
    print('Phone config created');
    print('Hint: ${phoneConfig.autofillHints.first}');
    recordTest('Phone configuration', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Phone configuration', false);
  }

  // Test 8: Address configuration
  print('\n--- Test 8: Address configuration ---');
  try {
    final addressConfigs = [
      AutofillConfiguration(
        uniqueIdentifier: 'street_address',
        autofillHints: [AutofillHints.streetAddressLine1],
        hintText: 'Street address',
      ),
      AutofillConfiguration(
        uniqueIdentifier: 'city',
        autofillHints: [AutofillHints.addressCity],
        hintText: 'City',
      ),
      AutofillConfiguration(
        uniqueIdentifier: 'postal_code',
        autofillHints: [AutofillHints.postalCode],
        hintText: 'ZIP/Postal code',
      ),
    ];
    print('Address configs created: ${addressConfigs.length}');
    for (final config in addressConfigs) {
      print('  - ${config.uniqueIdentifier}');
    }
    recordTest('Address configuration', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Address configuration', false);
  }

  // Test 9: Credit card configuration
  print('\n--- Test 9: Credit card configuration ---');
  try {
    final ccConfigs = [
      AutofillConfiguration(
        uniqueIdentifier: 'cc_number',
        autofillHints: [AutofillHints.creditCardNumber],
        hintText: 'Card number',
      ),
      AutofillConfiguration(
        uniqueIdentifier: 'cc_expiry',
        autofillHints: [AutofillHints.creditCardExpirationDate],
        hintText: 'Expiry date',
      ),
      AutofillConfiguration(
        uniqueIdentifier: 'cc_cvv',
        autofillHints: [AutofillHints.creditCardSecurityCode],
        hintText: 'CVV',
      ),
    ];
    print('Credit card configs created: ${ccConfigs.length}');
    recordTest('Credit card configuration', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Credit card configuration', false);
  }

  // Test 10: Disabled autofill configuration
  print('\n--- Test 10: Disabled autofill configuration ---');
  try {
    const disabledConfig = AutofillConfiguration.disabled;
    print('Disabled config: enabled=${disabledConfig.enabled}');
    assert(disabledConfig.enabled == false);
    recordTest('Disabled autofill configuration', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Disabled autofill configuration', false);
  }

  // Test 11: Unique identifier patterns
  print('\n--- Test 11: Unique identifier patterns ---');
  try {
    final identifiers = [
      'field_1',
      'login_email',
      'signup_password',
      'profile_name',
      'checkout_address',
    ];
    for (final id in identifiers) {
      final config = AutofillConfiguration(
        uniqueIdentifier: id,
        autofillHints: [AutofillHints.name],
        hintText: 'Field',
      );
      print('ID: ${config.uniqueIdentifier}');
      assert(config.uniqueIdentifier == id);
    }
    recordTest('Unique identifier patterns', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Unique identifier patterns', false);
  }

  // Print summary
  print('\n========================================');
  print('AutofillConfiguration Test Summary');
  print('========================================');
  print('Passed: $passCount');
  print('Failed: $failCount');
  print('Total:  ${passCount + failCount}');
  print('========================================');

  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'AutofillConfiguration Test Results',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 8),
      Text(
        'Passed: $passCount | Failed: $failCount',
        style: TextStyle(
          color: failCount == 0 ? Color(0xFF4CAF50) : Color(0xFFF44336),
        ),
      ),
      SizedBox(height: 8),
      ...results.map((r) => Text(r, style: TextStyle(fontSize: 12))),
    ],
  );
}
