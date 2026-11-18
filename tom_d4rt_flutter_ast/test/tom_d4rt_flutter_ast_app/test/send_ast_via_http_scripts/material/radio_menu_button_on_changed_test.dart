// ignore_for_file: avoid_print
// D4rt test script: RadioMenuButton.onChanged read back (material,
// addtests2; cluster GEN-134).
//
// `RadioMenuButton<int>(...)` is built by the generic constructor factory,
// whose callback wrapper is a `(int?) => Future<void>`. Reading `onChanged`
// back goes through the getter adapter, which reads the field through
// `RadioMenuButton<dynamic>`; Dart's covariance check on a function-typed
// field then throws `type '(int?) => Future<void>' is not a subtype of type
// '((dynamic) => void)?'`. Native Dart prints the lines below.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== RadioMenuButton.onChanged ===');
  var selected = 2;
  final radio = RadioMenuButton<int>(
    value: 2,
    groupValue: selected,
    onChanged: (v) => selected = v ?? selected,
    child: const Text('two'),
  );
  radio.onChanged!(3);
  print('radio menu changed to: $selected');
  return Center(child: radio);
}
