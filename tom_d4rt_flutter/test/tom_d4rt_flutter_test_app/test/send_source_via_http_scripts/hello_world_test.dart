// ignore_for_file: unused_import
import 'package:flutter/material.dart';

/// Minimal smoke-test: returns a Text widget so the runner can verify
/// that the source-based interpreter and bridge surface are working.
dynamic build(BuildContext context) {
  print('hello from d4rt source interpreter');
  return const Text('Hello, D4rt!');
}
