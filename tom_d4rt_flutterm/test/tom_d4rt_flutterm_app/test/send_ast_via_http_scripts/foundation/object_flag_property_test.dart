// D4rt test script: Tests ObjectFlagProperty from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ObjectFlagProperty test executing');

  final ofp1 = ObjectFlagProperty<Function>('callback', () {}, ifPresent: 'has callback');
  print('ObjectFlagProperty: ${ofp1.toString()}');

  final ofp2 = ObjectFlagProperty<Function>.has('onTap', () {});
  print('has: ${ofp2.toString()}');

  final ofp3 = ObjectFlagProperty<Function>.has('onTap', null);
  print('has null: ${ofp3.toString()}');
  print('level: ${ofp3.level}');

  print('ObjectFlagProperty test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('ObjectFlagProperty Tests', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('present: ${ofp1.toString()}'),
    Text('.has: ${ofp2.toString()}'),
  ]);
}
