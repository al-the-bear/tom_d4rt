// D4rt test script: Tests RootIsolateToken from dart:ui
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RootIsolateToken test executing');

  final token = ui.RootIsolateToken.instance;
  print('RootIsolateToken.instance: $token');
  print('Type: ${token.runtimeType}');
  print('Is not null (root isolate): ${token != null}');

  // Access again — same instance
  final token2 = ui.RootIsolateToken.instance;
  print('Same instance: ${identical(token, token2)}');

  print('RootIsolateToken test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('RootIsolateToken Tests', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('instance: ${token != null ? "available" : "null"}'),
    Text('Singleton: ${identical(token, token2)}'),
  ]);
}
