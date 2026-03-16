// D4rt test script: Tests Opacity widget from Flutter widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Opacity test executing');

  // Variation 1: Opacity 0.0 (fully transparent)
  final widget1 = Opacity(
    opacity: 0.0,
    child: Container(width: 100, height: 50, color: Colors.blue),
  );
  print('Opacity(opacity: 0.0) created');

  // Variation 2: Opacity 0.5 (half transparent)
  final widget2 = Opacity(
    opacity: 0.5,
    child: Container(
      width: 100,
      height: 50,
      color: Colors.red,
      child: Center(child: Text('50%')),
    ),
  );
  print('Opacity(opacity: 0.5) created');

  // Variation 3: Opacity 1.0 (fully visible)
  final widget3 = Opacity(
    opacity: 1.0,
    child: Container(
      width: 100,
      height: 50,
      color: Colors.green,
      child: Center(child: Text('100%')),
    ),
  );
  print('Opacity(opacity: 1.0) created');

  // Variation 4: Opacity with alwaysIncludeSemantics
  final widget4 = Opacity(
    opacity: 0.3,
    alwaysIncludeSemantics: true,
    child: Container(
      width: 100,
      height: 50,
      color: Colors.purple,
      child: Center(child: Text('Semantics')),
    ),
  );
  print('Opacity(opacity: 0.3, alwaysIncludeSemantics: true) created');

  // Variation 5: Opacity wrapping a complex widget
  final widget5 = Opacity(
    opacity: 0.7,
    child: Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.visibility, color: Colors.orange),
            SizedBox(width: 8),
            Text('70% visible card'),
          ],
        ),
      ),
    ),
  );
  print('Opacity(opacity: 0.7, child: Card) created');

  print('Opacity test completed');
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [widget1, widget2, widget3, widget4, widget5],
  );
}
