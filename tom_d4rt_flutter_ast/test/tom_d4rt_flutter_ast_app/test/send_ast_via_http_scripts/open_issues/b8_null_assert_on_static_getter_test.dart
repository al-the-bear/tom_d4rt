// Reproduces B.8 — spurious `!` null-check error on nullable static getters.
//
// `visitPostfixExpression` raises a spurious Runtime Error when the null-assert
// operator `!` is applied to a nullable static getter expression.
//
// ignore_for_file: avoid_print, prefer_final_fields

import 'package:flutter/material.dart';

class _Registry {
  static int? _value = 42;
  static int get value => _value!;
}

dynamic build(BuildContext context) {
  final v = _Registry.value;
  return Center(child: Text('$v'));
}
