// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests Semantics, MergeSemantics, ExcludeSemantics from Flutter widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Semantics widgets test executing');

  // Test Semantics with label
  final sem1 = Semantics(
    label: 'Test button',
    child: Container(width: 80, height: 40, color: Colors.blue),
  );
  print('Semantics(label: Test button) created');

  // Test Semantics with image flag
  final sem2 = Semantics(
    label: 'Image',
    image: true,
    child: Container(width: 80, height: 80, color: Colors.green),
  );
  print('Semantics(label: Image, image: true) created');

  // Test Semantics with header flag
  final sem3 = Semantics(header: true, label: 'Header', child: Text('Title'));
  print('Semantics(header: true, label: Header) created');

  // Test Semantics with button flag
  final sem4 = Semantics(
    button: true,
    label: 'Submit button',
    child: Container(
      width: 120,
      height: 40,
      color: Colors.orange,
      child: Center(child: Text('Submit')),
    ),
  );
  print('Semantics(button: true, label: Submit button) created');

  // Test Semantics with enabled and focusable
  final sem5 = Semantics(
    enabled: true,
    focusable: true,
    label: 'Focusable item',
    child: Container(width: 100, height: 40, color: Colors.teal),
  );
  print('Semantics(enabled: true, focusable: true) created');

  // Test MergeSemantics
  final merge = MergeSemantics(
    child: Column(children: [Text('Merged'), Icon(Icons.star)]),
  );
  print('MergeSemantics with Column created');

  // Test ExcludeSemantics excluding true
  final exclude1 = ExcludeSemantics(child: Container(child: Text('Excluded')));
  print('ExcludeSemantics(excluding: true) created');

  // Test ExcludeSemantics excluding false
  final exclude2 = ExcludeSemantics(
    excluding: false,
    child: Container(child: Text('Not excluded')),
  );
  print('ExcludeSemantics(excluding: false) created');

  print('Semantics widgets test completed');
  return Column(
    children: [sem1, sem2, sem3, sem4, sem5, merge, exclude1, exclude2],
  );
}
