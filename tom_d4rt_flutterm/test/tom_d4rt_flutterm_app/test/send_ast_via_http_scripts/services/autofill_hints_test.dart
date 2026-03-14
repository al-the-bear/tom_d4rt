// D4rt test script: Tests AutofillHints from services
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('AutofillHints comprehensive test executing');
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

  // Test 1: Email autofill hint
  print('\n--- Test 1: Email autofill hint ---');
  try {
    final hint = AutofillHints.email;
    assert(hint.isNotEmpty);
    print('Email hint: $hint');
    recordTest('Email autofill hint', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Email autofill hint', false);
  }

  // Test 2: Password autofill hints
  print('\n--- Test 2: Password autofill hints ---');
  try {
    final passwordHints = [AutofillHints.password, AutofillHints.newPassword];
    for (final hint in passwordHints) {
      print('Password hint: $hint');
      assert(hint.isNotEmpty);
    }
    recordTest('Password autofill hints', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Password autofill hints', false);
  }

  // Test 3: Username hint
  print('\n--- Test 3: Username hint ---');
  try {
    final hint = AutofillHints.username;
    assert(hint.isNotEmpty);
    print('Username hint: $hint');
    recordTest('Username hint', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Username hint', false);
  }

  // Test 4: Name-related hints
  print('\n--- Test 4: Name-related hints ---');
  try {
    final nameHints = [
      AutofillHints.name,
      AutofillHints.givenName,
      AutofillHints.familyName,
      AutofillHints.middleName,
      AutofillHints.namePrefix,
      AutofillHints.nameSuffix,
      AutofillHints.nickname,
    ];
    print('Name-related hints:');
    for (final hint in nameHints) {
      print('  - $hint');
      assert(hint.isNotEmpty);
    }
    recordTest('Name-related hints', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Name-related hints', false);
  }

  // Test 5: Phone hints
  print('\n--- Test 5: Phone hints ---');
  try {
    final phoneHints = [
      AutofillHints.telephoneNumber,
      AutofillHints.telephoneNumberCountryCode,
      AutofillHints.telephoneNumberDevice,
      AutofillHints.telephoneNumberNational,
    ];
    print('Phone hints:');
    for (final hint in phoneHints) {
      print('  - $hint');
      assert(hint.isNotEmpty);
    }
    recordTest('Phone hints', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Phone hints', false);
  }

  // Test 6: Address hints
  print('\n--- Test 6: Address hints ---');
  try {
    final addressHints = [
      AutofillHints.fullStreetAddress,
      AutofillHints.streetAddressLine1,
      AutofillHints.streetAddressLine2,
      AutofillHints.streetAddressLine3,
      AutofillHints.addressCity,
      AutofillHints.addressState,
      AutofillHints.postalCode,
      AutofillHints.countryCode,
      AutofillHints.countryName,
    ];
    print('Address hints:');
    for (final hint in addressHints) {
      print('  - $hint');
      assert(hint.isNotEmpty);
    }
    recordTest('Address hints', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Address hints', false);
  }

  // Test 7: Credit card hints
  print('\n--- Test 7: Credit card hints ---');
  try {
    final ccHints = [
      AutofillHints.creditCardNumber,
      AutofillHints.creditCardExpirationDate,
      AutofillHints.creditCardExpirationMonth,
      AutofillHints.creditCardExpirationYear,
      AutofillHints.creditCardSecurityCode,
      AutofillHints.creditCardName,
      AutofillHints.creditCardType,
    ];
    print('Credit card hints:');
    for (final hint in ccHints) {
      print('  - $hint');
      assert(hint.isNotEmpty);
    }
    recordTest('Credit card hints', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Credit card hints', false);
  }

  // Test 8: Birthday hints
  print('\n--- Test 8: Birthday hints ---');
  try {
    final bdayHints = [
      AutofillHints.birthday,
      AutofillHints.birthdayDay,
      AutofillHints.birthdayMonth,
      AutofillHints.birthdayYear,
    ];
    print('Birthday hints:');
    for (final hint in bdayHints) {
      print('  - $hint');
      assert(hint.isNotEmpty);
    }
    recordTest('Birthday hints', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Birthday hints', false);
  }

  // Test 9: Organization hints
  print('\n--- Test 9: Organization hints ---');
  try {
    final orgHints = [AutofillHints.organizationName, AutofillHints.jobTitle];
    print('Organization hints:');
    for (final hint in orgHints) {
      print('  - $hint');
      assert(hint.isNotEmpty);
    }
    recordTest('Organization hints', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Organization hints', false);
  }

  // Test 10: One-time code hint
  print('\n--- Test 10: One-time code hint ---');
  try {
    final hint = AutofillHints.oneTimeCode;
    assert(hint.isNotEmpty);
    print('One-time code hint: $hint');
    recordTest('One-time code hint', true);
  } catch (e) {
    print('Error: $e');
    recordTest('One-time code hint', false);
  }

  // Test 11: URL hint
  print('\n--- Test 11: URL hint ---');
  try {
    final hint = AutofillHints.url;
    assert(hint.isNotEmpty);
    print('URL hint: $hint');
    recordTest('URL hint', true);
  } catch (e) {
    print('Error: $e');
    recordTest('URL hint', false);
  }

  // Test 12: Gender hint
  print('\n--- Test 12: Gender hint ---');
  try {
    final hint = AutofillHints.gender;
    assert(hint.isNotEmpty);
    print('Gender hint: $hint');
    recordTest('Gender hint', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Gender hint', false);
  }

  // Print summary
  print('\n========================================');
  print('AutofillHints Test Summary');
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
        'AutofillHints Test Results',
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
