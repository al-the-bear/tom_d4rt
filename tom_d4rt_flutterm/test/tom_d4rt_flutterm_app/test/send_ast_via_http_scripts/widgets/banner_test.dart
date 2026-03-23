// ignore_for_file: avoid_print
// D4rt test script: Tests Banner and ErrorWidget from Flutter widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Banner/ErrorWidget test executing');

  // Variation 1: Banner at topEnd
  final widget1 = Banner(
    message: 'DEBUG',
    location: BannerLocation.topEnd,
    child: Container(width: 200, height: 100, color: Colors.grey),
  );
  print('Banner(message: DEBUG, location: topEnd) created');

  // Variation 2: Banner at topStart with custom color
  final widget2 = Banner(
    message: 'TEST',
    location: BannerLocation.topStart,
    color: Colors.red,
    child: Container(
      width: 200,
      height: 100,
      color: Colors.grey.shade300,
      child: Center(child: Text('Test Content')),
    ),
  );
  print('Banner(message: TEST, location: topStart, color: red) created');

  // Variation 3: Banner at bottomEnd
  final widget3 = Banner(
    message: 'BETA',
    location: BannerLocation.bottomEnd,
    child: Container(
      width: 200,
      height: 100,
      color: Colors.blue.shade100,
      child: Center(child: Text('Beta Feature')),
    ),
  );
  print('Banner(message: BETA, location: bottomEnd) created');

  // Variation 4: Banner at bottomStart
  final widget4 = Banner(
    message: 'NEW',
    location: BannerLocation.bottomStart,
    color: Colors.green,
    child: Container(
      width: 200,
      height: 100,
      color: Colors.yellow.shade100,
      child: Center(child: Text('New Feature')),
    ),
  );
  print('Banner(message: NEW, location: bottomStart, color: green) created');

  // Variation 5: ErrorWidget with string message
  final widget5 = ErrorWidget('Test error message');
  print('ErrorWidget(String) created');

  // Variation 6: ErrorWidget with Exception
  final widget6 = ErrorWidget(Exception('Test exception'));
  print('ErrorWidget(Exception) created');

  print('Banner/ErrorWidget test completed');
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      widget1,
      widget2,
      widget3,
      widget4,
      SizedBox(height: 80, child: widget5),
      SizedBox(height: 80, child: widget6),
    ],
  );
}
