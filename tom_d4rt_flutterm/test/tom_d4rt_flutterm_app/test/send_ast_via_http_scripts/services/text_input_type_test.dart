// D4rt test script: Tests TextInputType from services
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TextInputType test executing');
  print('=' * 50);

  // TextInputType constants
  print('\nTextInputType constants:');
  print('text: ${TextInputType.text}');
  print('multiline: ${TextInputType.multiline}');
  print('number: ${TextInputType.number}');
  print('phone: ${TextInputType.phone}');
  print('datetime: ${TextInputType.datetime}');
  print('emailAddress: ${TextInputType.emailAddress}');
  print('url: ${TextInputType.url}');
  print('visiblePassword: ${TextInputType.visiblePassword}');
  print('name: ${TextInputType.name}');
  print('streetAddress: ${TextInputType.streetAddress}');
  print('none: ${TextInputType.none}');

  // TextInputType.numberWithOptions
  print('\nTextInputType.numberWithOptions:');
  final signedNumber = TextInputType.numberWithOptions(signed: true);
  final decimalNumber = TextInputType.numberWithOptions(decimal: true);
  final signedDecimal = TextInputType.numberWithOptions(
    signed: true,
    decimal: true,
  );
  print('Signed: $signedNumber');
  print('Decimal: $decimalNumber');
  print('Signed+Decimal: $signedDecimal');

  // Keyboard appearance
  print('\nKeyboard appearance by type:');
  print('text: Standard keyboard');
  print('number: Numeric keypad');
  print('phone: Phone dialer pad');
  print('emailAddress: Keyboard with @');
  print('url: Keyboard with .com');

  // Type properties
  print('\nTextInputType values:');
  final types = [
    TextInputType.text,
    TextInputType.number,
    TextInputType.phone,
    TextInputType.emailAddress,
  ];
  for (final type in types) {
    print('${type.toJson()}');
  }

  // Usage in TextField
  print('\nUsage in TextField:');
  print('TextField(keyboardType: TextInputType.emailAddress)');
  print('TextField(keyboardType: TextInputType.number)');
  print('TextField(keyboardType: TextInputType.phone)');

  // Platform behavior
  print('\nPlatform behavior:');
  print('- iOS: Affects keyboard type');
  print('- Android: Affects input method');
  print('- Web: Affects input[type] attribute');

  // Type hierarchy
  print('\nType hierarchy:');
  print('is Object: ${TextInputType.text is Object}');

  // TextInputAction relationship
  print('\nRelated: TextInputAction');
  print('- done, go, search, send, next');
  print('- Affects keyboard action button');

  // Explain purpose
  print('\nTextInputType purpose:');
  print('- Specifies keyboard type for input');
  print('- Affects virtual keyboard layout');
  print('- Enables appropriate input methods');
  print('- numberWithOptions for numeric variants');
  print('- Used with TextField, TextFormField');

  print('\n' + '=' * 50);
  print('TextInputType test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'TextInputType Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('text: ${TextInputType.text}'),
      Text('number: ${TextInputType.number}'),
      Text('email: ${TextInputType.emailAddress}'),
      Text('Purpose: Keyboard type selection'),
    ],
  );
}
