// D4rt test script: Tests TextInputFormatter classes from services
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Services text input formatter test executing');

  // ========== TEXTINPUTFORMATTER ==========
  print('--- TextInputFormatter Tests ---');

  // Test FilteringTextInputFormatter.allow
  print('--- FilteringTextInputFormatter.allow Tests ---');

  final digitsOnly = FilteringTextInputFormatter.allow(RegExp(r'[0-9]'));

  // Test formatting digits
  var result = digitsOnly.formatEditUpdate(
    TextEditingValue.empty,
    TextEditingValue(text: 'abc123def456'),
  );
  print('Filter digits from "abc123def456": "${result.text}"');

  result = digitsOnly.formatEditUpdate(
    TextEditingValue.empty,
    TextEditingValue(text: '1234567890'),
  );
  print('Filter digits from "1234567890": "${result.text}"');

  result = digitsOnly.formatEditUpdate(
    TextEditingValue.empty,
    TextEditingValue(text: 'abcdef'),
  );
  print('Filter digits from "abcdef": "${result.text}"');

  // Test FilteringTextInputFormatter.deny
  print('--- FilteringTextInputFormatter.deny Tests ---');

  final noDigits = FilteringTextInputFormatter.deny(RegExp(r'[0-9]'));

  result = noDigits.formatEditUpdate(
    TextEditingValue.empty,
    TextEditingValue(text: 'abc123def456'),
  );
  print('Deny digits from "abc123def456": "${result.text}"');

  // Test FilteringTextInputFormatter.digitsOnly
  print('--- FilteringTextInputFormatter.digitsOnly Tests ---');

  final digitsOnlyFormatter = FilteringTextInputFormatter.digitsOnly;

  result = digitsOnlyFormatter.formatEditUpdate(
    TextEditingValue.empty,
    TextEditingValue(text: 'Phone: (555) 123-4567'),
  );
  print('digitsOnly from phone: "${result.text}"');

  // Test FilteringTextInputFormatter.singleLineFormatter
  print('--- FilteringTextInputFormatter.singleLineFormatter Tests ---');

  final singleLine = FilteringTextInputFormatter.singleLineFormatter;

  result = singleLine.formatEditUpdate(
    TextEditingValue.empty,
    TextEditingValue(text: 'Line1\nLine2\nLine3'),
  );
  print('singleLine from multiline: "${result.text}"');

  // Test custom patterns
  print('--- Custom Pattern Tests ---');

  // Allow only letters
  final lettersOnly = FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]'));
  result = lettersOnly.formatEditUpdate(
    TextEditingValue.empty,
    TextEditingValue(text: 'Hello123World456'),
  );
  print('Letters only from "Hello123World456": "${result.text}"');

  // Allow alphanumeric
  final alphanumeric = FilteringTextInputFormatter.allow(
    RegExp(r'[a-zA-Z0-9]'),
  );
  result = alphanumeric.formatEditUpdate(
    TextEditingValue.empty,
    TextEditingValue(text: 'Hello! World? 123'),
  );
  print('Alphanumeric from "Hello! World? 123": "${result.text}"');

  // Allow email characters
  final emailChars = FilteringTextInputFormatter.allow(
    RegExp(r'[a-zA-Z0-9@._-]'),
  );
  result = emailChars.formatEditUpdate(
    TextEditingValue.empty,
    TextEditingValue(text: 'user@example.com !!!'),
  );
  print('Email chars from "user@example.com !!!": "${result.text}"');

  // Allow hex characters
  final hexChars = FilteringTextInputFormatter.allow(RegExp(r'[0-9a-fA-F]'));
  result = hexChars.formatEditUpdate(
    TextEditingValue.empty,
    TextEditingValue(text: '#FF00GG88'),
  );
  print('Hex chars from "#FF00GG88": "${result.text}"');

  // ========== LENGTHLIMITINGTEXTINPUTFORMATTER ==========
  print('--- LengthLimitingTextInputFormatter Tests ---');

  // Test with max length
  final maxLength10 = LengthLimitingTextInputFormatter(10);

  result = maxLength10.formatEditUpdate(
    TextEditingValue.empty,
    TextEditingValue(text: 'Hello'),
  );
  print('Max 10, input "Hello" (5 chars): "${result.text}"');

  result = maxLength10.formatEditUpdate(
    TextEditingValue.empty,
    TextEditingValue(text: 'Hello World!'),
  );
  print('Max 10, input "Hello World!" (12 chars): "${result.text}"');

  result = maxLength10.formatEditUpdate(
    TextEditingValue.empty,
    TextEditingValue(text: '12345678901234567890'),
  );
  print('Max 10, input 20 chars: "${result.text}"');

  // Test with null (no limit)
  final noLimit = LengthLimitingTextInputFormatter(null);
  result = noLimit.formatEditUpdate(
    TextEditingValue.empty,
    TextEditingValue(text: 'This is a very long string that has no limit'),
  );
  print('No limit: "${result.text}"');

  // Test different limits
  final maxLength3 = LengthLimitingTextInputFormatter(3);
  result = maxLength3.formatEditUpdate(
    TextEditingValue.empty,
    TextEditingValue(text: 'ABCDEFG'),
  );
  print('Max 3 from "ABCDEFG": "${result.text}"');

  final maxLength1 = LengthLimitingTextInputFormatter(1);
  result = maxLength1.formatEditUpdate(
    TextEditingValue.empty,
    TextEditingValue(text: 'XYZ'),
  );
  print('Max 1 from "XYZ": "${result.text}"');

  // Test with truncation mode
  print('--- MaxLengthEnforcement Tests ---');

  final enforcedFormatter = LengthLimitingTextInputFormatter(
    5,
    maxLengthEnforcement: MaxLengthEnforcement.enforced,
  );
  result = enforcedFormatter.formatEditUpdate(
    TextEditingValue.empty,
    TextEditingValue(text: 'Hello World'),
  );
  print('Enforced max 5: "${result.text}"');

  final truncateFormatter = LengthLimitingTextInputFormatter(
    5,
    maxLengthEnforcement: MaxLengthEnforcement.truncateAfterCompositionEnds,
  );
  result = truncateFormatter.formatEditUpdate(
    TextEditingValue.empty,
    TextEditingValue(text: 'Hello World'),
  );
  print('Truncate after composition max 5: "${result.text}"');

  // ========== COMBINING FORMATTERS ==========
  print('--- Combining Formatters Tests ---');

  // Combine digits only with max length
  final phoneFormatter = [
    FilteringTextInputFormatter.digitsOnly,
    LengthLimitingTextInputFormatter(10),
  ];

  var value = TextEditingValue(text: 'Phone: (555) 123-4567-8900');
  for (final formatter in phoneFormatter) {
    value = formatter.formatEditUpdate(TextEditingValue.empty, value);
  }
  print('Phone number formatting: "${value.text}"');

  // Username: alphanumeric, max 15
  final usernameFormatters = [
    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9_]')),
    LengthLimitingTextInputFormatter(15),
  ];

  value = TextEditingValue(text: 'User@Name!123_Test_Very_Long');
  for (final formatter in usernameFormatters) {
    value = formatter.formatEditUpdate(TextEditingValue.empty, value);
  }
  print('Username formatting: "${value.text}"');

  // ========== TEXTEDITINGVALUE ==========
  print('--- TextEditingValue Tests ---');

  final emptyValue = TextEditingValue.empty;
  print(
    'TextEditingValue.empty: text="${emptyValue.text}", selection=${emptyValue.selection}',
  );

  final textValue = TextEditingValue(text: 'Hello World');
  print('TextEditingValue: text="${textValue.text}"');
  print('  selection: ${textValue.selection}');
  print('  composing: ${textValue.composing}');

  // With selection
  final selectedValue = TextEditingValue(
    text: 'Hello World',
    selection: TextSelection(baseOffset: 0, extentOffset: 5),
  );
  print('With selection: "${selectedValue.text}"');
  print(
    '  selected text indices: ${selectedValue.selection.baseOffset}-${selectedValue.selection.extentOffset}',
  );

  // With cursor position
  final cursorValue = TextEditingValue(
    text: 'Hello World',
    selection: TextSelection.collapsed(offset: 5),
  );
  print('With cursor at 5: selection=${cursorValue.selection}');

  // With composing region (IME)
  final composingValue = TextEditingValue(
    text: 'Hello',
    selection: TextSelection.collapsed(offset: 5),
    composing: TextRange(start: 0, end: 5),
  );
  print('With composing: composing=${composingValue.composing}');

  // Test copyWith
  final modifiedValue = textValue.copyWith(
    selection: TextSelection.collapsed(offset: 0),
  );
  print('copyWith: selection=${modifiedValue.selection}');

  // Test replaced
  final replacedValue = textValue.replaced(TextRange(start: 0, end: 5), 'Hi');
  print('replaced "Hello" with "Hi": "${replacedValue.text}"');

  // ========== TEXTSELECTION ==========
  print('--- TextSelection Tests ---');

  final selection = TextSelection(baseOffset: 0, extentOffset: 5);
  print(
    'TextSelection: base=${selection.baseOffset}, extent=${selection.extentOffset}',
  );
  print('  isCollapsed: ${selection.isCollapsed}');
  print('  isDirectional: ${selection.isDirectional}');

  final collapsed = TextSelection.collapsed(offset: 5);
  print(
    'Collapsed: offset=${collapsed.baseOffset}, isCollapsed=${collapsed.isCollapsed}',
  );

  final fromPosition = TextSelection.fromPosition(TextPosition(offset: 3));
  print('FromPosition: ${fromPosition.baseOffset}');

  // Test affinity
  final upstreamSelection = TextSelection.collapsed(
    offset: 5,
    affinity: TextAffinity.upstream,
  );
  print('Upstream affinity: ${upstreamSelection.affinity}');

  final downstreamSelection = TextSelection.collapsed(
    offset: 5,
    affinity: TextAffinity.downstream,
  );
  print('Downstream affinity: ${downstreamSelection.affinity}');

  // Test copyWith
  final extendedSelection = selection.copyWith(extentOffset: 10);
  print(
    'Extended selection: ${extendedSelection.baseOffset}-${extendedSelection.extentOffset}',
  );

  print('Services text input formatter test completed');

  // Return a visual representation
  return Directionality(
    textDirection: TextDirection.ltr,
    child: Container(
      padding: EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'TextInputFormatter Tests',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),

            Text(
              'FilteringTextInputFormatter:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),

            Container(
              padding: EdgeInsets.all(8.0),
              color: Color(0xFFE3F2FD),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Input: "abc123def456"',
                    style: TextStyle(fontSize: 12.0),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    '• digitsOnly → "123456"',
                    style: TextStyle(fontSize: 12.0),
                  ),
                  Text(
                    '• lettersOnly → "abcdef"',
                    style: TextStyle(fontSize: 12.0),
                  ),
                  Text(
                    '• alphanumeric → "abc123def456"',
                    style: TextStyle(fontSize: 12.0),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),

            Text(
              'LengthLimitingTextInputFormatter:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),

            Container(
              padding: EdgeInsets.all(8.0),
              color: Color(0xFFFFF3E0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Input: "Hello World!" (12 chars)',
                    style: TextStyle(fontSize: 12.0),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    '• maxLength(10) → "Hello Worl"',
                    style: TextStyle(fontSize: 12.0),
                  ),
                  Text(
                    '• maxLength(5) → "Hello"',
                    style: TextStyle(fontSize: 12.0),
                  ),
                  Text(
                    '• maxLength(3) → "Hel"',
                    style: TextStyle(fontSize: 12.0),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),

            Text(
              'Combined Formatters:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),

            Container(
              padding: EdgeInsets.all(8.0),
              color: Color(0xFFE8F5E9),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Phone Number (digits + max 10):',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '"(555) 123-4567" → "5551234567"',
                    style: TextStyle(fontSize: 12.0),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Username (alphanum + max 15):',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '"User@Name!Test_Long" → "UserNameTest_Lo"',
                    style: TextStyle(fontSize: 12.0),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),

            Text(
              'Interactive Demo:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),

            TextField(
              decoration: InputDecoration(
                labelText: 'Digits Only',
                border: OutlineInputBorder(),
              ),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            SizedBox(height: 8.0),

            TextField(
              decoration: InputDecoration(
                labelText: 'Max 10 Characters',
                border: OutlineInputBorder(),
              ),
              inputFormatters: [LengthLimitingTextInputFormatter(10)],
            ),
            SizedBox(height: 8.0),

            TextField(
              decoration: InputDecoration(
                labelText: 'Phone (digits, max 10)',
                border: OutlineInputBorder(),
              ),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
              ],
              keyboardType: TextInputType.phone,
            ),
          ],
        ),
      ),
    ),
  );
}
