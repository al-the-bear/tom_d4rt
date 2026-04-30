// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests PercentProperty from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PercentProperty test executing');

  final pp1 = PercentProperty('progress', 0.75);
  print('PercentProperty: ${pp1.toString()}');

  final pp2 = PercentProperty('opacity', 1.0);
  print('pp2: ${pp2.toString()}');

  final pp3 = PercentProperty('done', 0.0);
  print('pp3: ${pp3.toString()}');

  final pp4 = PercentProperty('ratio', null, ifNull: 'unknown');
  print('pp4 null: ${pp4.toString()}');

  print('PercentProperty test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'PercentProperty Tests',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      Text('75%: ${pp1.toString()}'),
      Text('100%: ${pp2.toString()}'),
      Text('0%: ${pp3.toString()}'),
    ],
  );
}
