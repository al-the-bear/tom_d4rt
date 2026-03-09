// D4rt test script: Tests MessageProperty from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('MessageProperty test executing');

  final mp1 = MessageProperty('status', 'All systems operational');
  print('MessageProperty: ${mp1.name}');
  print('toString: ${mp1.toString()}');

  final mp2 = MessageProperty('error', 'Connection failed', level: DiagnosticLevel.error);
  print('mp2 level: ${mp2.level}');
  print('mp2: ${mp2.toString()}');

  print('MessageProperty test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('MessageProperty Tests', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('status: ${mp1.toString()}'),
    Text('error: ${mp2.toString()}'),
  ]);
}
