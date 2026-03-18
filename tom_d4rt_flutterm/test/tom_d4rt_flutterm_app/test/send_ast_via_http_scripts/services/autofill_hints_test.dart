// D4rt test script: Tests AutofillHints from services
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('AutofillHints test executing');

  // AutofillHints is a class with static constants
  print('AutofillHints provides standard autofill hints');

  // Common autofill hints
  print('\nCommon autofill hints:');
  print('email: ${AutofillHints.email}');
  print('password: ${AutofillHints.password}');
  print('username: ${AutofillHints.username}');
  print('name: ${AutofillHints.name}');

  // Address hints
  print('\nAddress hints:');
  print('streetAddressLine1: ${AutofillHints.streetAddressLine1}');
  print('postalCode: ${AutofillHints.postalCode}');
  print('addressCity: ${AutofillHints.addressCity}');
  print('countryName: ${AutofillHints.countryName}');

  // Phone hints
  print('\nPhone hints:');
  print('telephoneNumber: ${AutofillHints.telephoneNumber}');
  print(
    'telephoneNumberCountryCode: ${AutofillHints.telephoneNumberCountryCode}',
  );

  // Credit card hints
  print('\nCredit card hints:');
  print('creditCardNumber: ${AutofillHints.creditCardNumber}');
  print('creditCardExpirationDate: ${AutofillHints.creditCardExpirationDate}');
  print('creditCardSecurityCode: ${AutofillHints.creditCardSecurityCode}');

  // Usage example
  print('\nUsage in TextField:');
  print('TextField(');
  print('  autofillHints: [AutofillHints.email],');
  print('  keyboardType: TextInputType.emailAddress,');
  print(')');

  // Multiple hints
  print('\nMultiple hints:');
  print('autofillHints: [');
  print('  AutofillHints.newPassword,');
  print('  AutofillHints.password,');
  print(']');

  print('\nAutofillHints test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'AutofillHints Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Standard autofill hint constants'),
      Text('email: ${AutofillHints.email}'),
      Text('password: ${AutofillHints.password}'),
      Text('username: ${AutofillHints.username}'),
    ],
  );
}
