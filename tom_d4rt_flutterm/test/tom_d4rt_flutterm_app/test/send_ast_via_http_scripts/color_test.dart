// D4rt test script: Tests Color.fromARGB from dart:ui
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Widget created');

  return Container(
    width: 200.0,
    height: 100.0,
    color: Color.fromARGB(255, 255, 100, 50),
    child: Center(
      child: Text(
        'dart:ui Color works!',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
