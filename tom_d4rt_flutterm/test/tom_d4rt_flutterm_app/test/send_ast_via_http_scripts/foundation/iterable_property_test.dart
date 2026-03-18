// D4rt test script: Tests IterableProperty from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('IterableProperty test executing');

  final ip1 = IterableProperty<String>('items', ['a', 'b', 'c']);
  print('IterableProperty: ${ip1.name}=${ip1.value}');
  print('toString: ${ip1.toString()}');

  final ip2 = IterableProperty<int>('numbers', [1, 2, 3, 4, 5]);
  print('ip2: ${ip2.toString()}');

  final ip3 = IterableProperty<String>('empty', [], ifEmpty: 'none');
  print('ip3 empty: ${ip3.toString()}');

  final ip4 = IterableProperty<String>('null', null, ifNull: 'not set');
  print('ip4 null: ${ip4.toString()}');

  print('IterableProperty test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'IterableProperty Tests',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      Text('items: ${ip1.toString()}'),
      Text('empty: ${ip3.toString()}'),
    ],
  );
}
