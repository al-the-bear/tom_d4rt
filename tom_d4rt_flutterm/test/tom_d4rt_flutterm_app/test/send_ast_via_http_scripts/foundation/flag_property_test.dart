// D4rt test script: Tests FlagProperty from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('FlagProperty test executing');

  final fp1 = FlagProperty('enabled', value: true, ifTrue: 'ENABLED');
  print('FlagProperty true: ${fp1.toString()}');

  final fp2 = FlagProperty('visible', value: false, ifFalse: 'HIDDEN');
  print('FlagProperty false: ${fp2.toString()}');

  final fp3 = FlagProperty(
    'active',
    value: true,
    ifTrue: 'active',
    ifFalse: 'inactive',
  );
  print('fp3: ${fp3.toString()}');

  final fp4 = FlagProperty(
    'check',
    value: false,
    ifTrue: 'yes',
    ifFalse: 'no',
    showName: true,
  );
  print('fp4 showName: ${fp4.toString()}');

  print('FlagProperty test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('FlagProperty Tests', style: TextStyle(fontWeight: FontWeight.bold)),
      Text('True: ${fp1.toString()}'),
      Text('False: ${fp2.toString()}'),
    ],
  );
}
