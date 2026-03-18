// D4rt test script: Tests LocaleStringAttribute from dart:ui
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('LocaleStringAttribute test executing');

  // LocaleStringAttribute marks a range with a locale
  final attr1 = ui.LocaleStringAttribute(
    range: TextRange(start: 0, end: 5),
    locale: ui.Locale('en', 'US'),
  );
  print('LocaleStringAttribute created: ${attr1.runtimeType}');
  print('range: ${attr1.range}');
  print('locale: ${attr1.locale}');

  // Different locale
  final attr2 = ui.LocaleStringAttribute(
    range: TextRange(start: 6, end: 12),
    locale: ui.Locale('de', 'DE'),
  );
  print('attr2 locale: ${attr2.locale}');
  print('attr2 range: start=${attr2.range.start}, end=${attr2.range.end}');

  // Japanese locale
  final attr3 = ui.LocaleStringAttribute(
    range: TextRange(start: 0, end: 3),
    locale: ui.Locale('ja'),
  );
  print('attr3 locale: ${attr3.locale}');

  // SpellOutStringAttribute
  final spellAttr = ui.SpellOutStringAttribute(
    range: TextRange(start: 0, end: 10),
  );
  print('SpellOutStringAttribute: ${spellAttr.runtimeType}');
  print('spellAttr range: ${spellAttr.range}');

  // StringAttribute base
  print('true: ${attr1 is ui.StringAttribute}');
  print('true: ${spellAttr is ui.StringAttribute}');

  print('LocaleStringAttribute test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('LocaleStringAttribute Tests', style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 8),
      Text('en_US: range=${attr1.range}'),
      Text('de_DE: range=${attr2.range}'),
      Text('ja: range=${attr3.range}'),
      Text('SpellOutStringAttribute: ${spellAttr.range}'),
    ],
  );
}
