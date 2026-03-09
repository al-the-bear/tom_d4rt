// D4rt test script: Tests StringAttribute from dart:ui
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('StringAttribute test executing');

  // StringAttribute is abstract — tested via subtypes
  final spell = ui.SpellOutStringAttribute(range: TextRange(start: 0, end: 3));
  print('SpellOut is StringAttribute: ${spell is ui.StringAttribute}');
  print('range: ${spell.range}');

  final locale = ui.LocaleStringAttribute(
    range: TextRange(start: 5, end: 10),
    locale: ui.Locale('en'),
  );
  print('Locale is StringAttribute: ${locale is ui.StringAttribute}');
  print('range: ${locale.range}');
  print('locale: ${locale.locale}');

  print('StringAttribute test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('StringAttribute Tests', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('SpellOut subtype OK'),
    Text('Locale subtype OK'),
  ]);
}
