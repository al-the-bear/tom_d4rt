// D4rt test script: Tests StringProperty from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('StringProperty test executing');

  final sp1 = StringProperty('name', 'Flutter');
  print('StringProperty: ${sp1.toString()}');

  final sp2 = StringProperty('label', 'Hello World', showName: false);
  print('sp2 no name: ${sp2.toString()}');

  final sp3 = StringProperty('value', null, ifEmpty: 'empty', quoted: true);
  print('sp3 null: ${sp3.toString()}');

  final sp4 = StringProperty('desc', 'test', quoted: false);
  print('sp4 unquoted: ${sp4.toString()}');

  print('StringProperty test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'StringProperty Tests',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      Text('name: ${sp1.toString()}'),
      Text('no name: ${sp2.toString()}'),
    ],
  );
}
