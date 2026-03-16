// D4rt test script: Tests IntProperty from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('IntProperty test executing');

  final ip1 = IntProperty('count', 42);
  print('IntProperty: ${ip1.name}=${ip1.value}');
  print('toString: ${ip1.toString()}');

  final ip2 = IntProperty('index', 0, defaultValue: 0);
  print('ip2 default: ${ip2.toString()}');

  final ip3 = IntProperty('size', null, ifNull: 'auto');
  print('ip3 null: ${ip3.toString()}');

  print('IntProperty test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('IntProperty Tests', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('count: ${ip1.toString()}'),
    Text('null: ${ip3.toString()}'),
  ]);
}
