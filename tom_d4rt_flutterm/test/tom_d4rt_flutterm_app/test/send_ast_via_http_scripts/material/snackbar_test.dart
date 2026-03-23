// ignore_for_file: avoid_print
// D4rt test script: Tests SnackBar from Flutter material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SnackBar test executing');

  // Variation 1: Basic SnackBar
  final widget1 = SnackBar(content: Text('Hello snackbar'));
  print('SnackBar(basic) created');
  print('  Type: $widget1');

  // Variation 2: SnackBar with action
  final widget2 = SnackBar(
    content: Text('With action'),
    action: SnackBarAction(
      label: 'Undo',
      onPressed: () {
        print('undo');
      },
    ),
  );
  print('SnackBar(with action) created');
  print('  Type: $widget2');

  // Variation 3: SnackBar with background color
  final widget3 = SnackBar(
    content: Text('Colored'),
    backgroundColor: Colors.green,
  );
  print('SnackBar(backgroundColor: green) created');
  print('  Type: $widget3');

  // Variation 4: SnackBar with custom duration
  final widget4 = SnackBar(
    content: Text('Duration'),
    duration: Duration(seconds: 5),
  );
  print('SnackBar(duration: 5s) created');
  print('  Type: $widget4');

  // Variation 5: SnackBar with floating behavior
  final widget5 = SnackBar(
    content: Text('Behavior'),
    behavior: SnackBarBehavior.floating,
  );
  print('SnackBar(behavior: floating) created');
  print('  Type: $widget5');

  // Variation 6: SnackBar with custom shape
  final widget6 = SnackBar(
    content: Text('Shape'),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  );
  print('SnackBar(shape: RoundedRectangleBorder) created');
  print('  Type: $widget6');

  print('SnackBar test completed');
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      // SnackBars are not normally placed in a Column directly,
      // but we wrap their content for display purposes
      Container(
        padding: EdgeInsets.all(8),
        color: Colors.grey.shade800,
        child: Text(
          'SnackBar 1: Hello snackbar',
          style: TextStyle(color: Colors.white),
        ),
      ),
      Container(
        padding: EdgeInsets.all(8),
        color: Colors.grey.shade800,
        child: Row(
          children: [
            Expanded(
              child: Text(
                'SnackBar 2: With action',
                style: TextStyle(color: Colors.white),
              ),
            ),
            TextButton(onPressed: () {}, child: Text('Undo')),
          ],
        ),
      ),
      Container(
        padding: EdgeInsets.all(8),
        color: Colors.green,
        child: Text(
          'SnackBar 3: Colored',
          style: TextStyle(color: Colors.white),
        ),
      ),
      Container(
        padding: EdgeInsets.all(8),
        color: Colors.grey.shade800,
        child: Text(
          'SnackBar 4: Duration 5s',
          style: TextStyle(color: Colors.white),
        ),
      ),
      Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.grey.shade800,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          'SnackBar 5: Floating',
          style: TextStyle(color: Colors.white),
        ),
      ),
      Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey.shade800,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          'SnackBar 6: Shaped',
          style: TextStyle(color: Colors.white),
        ),
      ),
    ],
  );
}
