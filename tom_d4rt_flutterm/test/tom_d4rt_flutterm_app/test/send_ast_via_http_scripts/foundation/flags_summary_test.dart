// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests FlagsSummary from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('FlagsSummary test executing');

  final fs = FlagsSummary<bool>('options', {
    'scrollable': true,
    'draggable': false,
    'resizable': true,
  }, ifEmpty: 'none');
  print('FlagsSummary: ${fs.runtimeType}');
  print('toString: ${fs.toString()}');
  print('value: ${fs.value}');

  final fs2 = FlagsSummary<bool>('empty', {}, ifEmpty: 'no flags');
  print('Empty: ${fs2.toString()}');

  print('FlagsSummary test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('FlagsSummary Tests', style: TextStyle(fontWeight: FontWeight.bold)),
      Text('Result: ${fs.toString()}'),
      Text('Empty: ${fs2.toString()}'),
    ],
  );
}
