// D4rt test script: Tests Tooltip from Flutter material widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Tooltip test executing');

  // Test Tooltip with message and Icon child
  final tooltip1 = Tooltip(message: 'Hello', child: Icon(Icons.info));
  print('Tooltip(message: Hello, child: Icon) created');

  // Test Tooltip with height
  final tooltip2 = Tooltip(
    message: 'Tooltip text',
    height: 40.0,
    child: Icon(Icons.help),
  );
  print('Tooltip(message: Tooltip text, height: 40.0) created');

  // Test Tooltip with verticalOffset and preferBelow
  final tooltip3 = Tooltip(
    message: 'Custom',
    verticalOffset: 20.0,
    preferBelow: false,
    child: Icon(Icons.settings),
  );
  print('Tooltip(verticalOffset: 20.0, preferBelow: false) created');

  // Test Tooltip with decoration and textStyle
  final tooltip4 = Tooltip(
    message: 'Styled tooltip',
    decoration: BoxDecoration(
      color: Colors.blue,
      borderRadius: BorderRadius.circular(8),
    ),
    textStyle: TextStyle(color: Colors.white, fontSize: 14),
    child: Icon(Icons.style),
  );
  print('Tooltip with decoration and textStyle created');

  // Test Tooltip with richMessage
  final tooltip5 = Tooltip(
    richMessage: TextSpan(text: 'Rich tooltip'),
    child: Icon(Icons.text_fields),
  );
  print('Tooltip with richMessage created');

  // Test Tooltip with waitDuration and showDuration
  final tooltip6 = Tooltip(
    message: 'Delayed tooltip',
    waitDuration: Duration(milliseconds: 500),
    showDuration: Duration(milliseconds: 1000),
    child: Icon(Icons.timer),
  );
  print('Tooltip with waitDuration and showDuration created');

  print('Tooltip test completed');
  return Column(
    children: [tooltip1, tooltip2, tooltip3, tooltip4, tooltip5, tooltip6],
  );
}
