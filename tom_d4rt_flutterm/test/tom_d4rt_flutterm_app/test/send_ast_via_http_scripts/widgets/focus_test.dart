// D4rt test script: Tests Focus and FocusScope from Flutter widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Focus and FocusScope test executing');

  // Test Focus with child Container
  final focus1 = Focus(
    child: Container(
      width: 100,
      height: 50,
      color: Colors.blue,
      child: Text('Focus'),
    ),
  );
  print('Focus with Container child created');

  // Test Focus with autofocus
  final focus2 = Focus(
    autofocus: true,
    child: Container(
      width: 100,
      height: 50,
      color: Colors.green,
      child: Text('Autofocus'),
    ),
  );
  print('Focus(autofocus: true) created');

  // Test Focus with canRequestFocus false
  final focus3 = Focus(
    canRequestFocus: false,
    child: Container(
      width: 100,
      height: 50,
      color: Colors.red,
      child: Text('No request focus'),
    ),
  );
  print('Focus(canRequestFocus: false) created');

  // Test Focus with debugLabel
  final focus4 = Focus(
    debugLabel: 'myFocus',
    child: Container(
      width: 100,
      height: 50,
      color: Colors.orange,
      child: Text('Debug label'),
    ),
  );
  print('Focus(debugLabel: myFocus) created');

  // Test FocusScope with children
  final focusScope1 = FocusScope(
    child: Column(
      children: [
        Focus(child: TextField()),
        Focus(child: TextField()),
      ],
    ),
  );
  print('FocusScope with two Focus+TextField children created');

  // Test FocusScope with autofocus
  final focusScope2 = FocusScope(
    autofocus: true,
    child: Column(children: [Focus(child: TextField())]),
  );
  print('FocusScope(autofocus: true) created');

  print('Focus and FocusScope test completed');
  return Column(
    children: [focus1, focus2, focus3, focus4, focusScope1, focusScope2],
  );
}
