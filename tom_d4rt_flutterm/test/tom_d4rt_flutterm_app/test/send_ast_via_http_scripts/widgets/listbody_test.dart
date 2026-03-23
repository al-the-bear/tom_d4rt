// ignore_for_file: avoid_print
// D4rt test script: Tests ListBody from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ListBody test executing');

  // Test ListBody with vertical main axis (default)
  final verticalBody = ListBody(
    mainAxis: Axis.vertical,
    children: [
      Container(
        height: 50.0,
        color: Colors.blue,
        child: Center(
          child: Text('Item 1', style: TextStyle(color: Colors.white)),
        ),
      ),
      Container(
        height: 50.0,
        color: Colors.green,
        child: Center(
          child: Text('Item 2', style: TextStyle(color: Colors.white)),
        ),
      ),
      Container(
        height: 50.0,
        color: Colors.orange,
        child: Center(
          child: Text('Item 3', style: TextStyle(color: Colors.white)),
        ),
      ),
    ],
  );
  print('ListBody with mainAxis=vertical and 3 children created');

  // Test ListBody with reverse false
  final reverseBody = ListBody(
    reverse: false,
    children: [
      Container(
        height: 40.0,
        color: Colors.red,
        child: Center(child: Text('A')),
      ),
      Container(
        height: 40.0,
        color: Colors.purple,
        child: Center(child: Text('B')),
      ),
    ],
  );
  print('ListBody with reverse=false created');

  // Test ListBody with single child
  final singleChild = ListBody(
    children: [
      Container(
        height: 60.0,
        color: Colors.teal,
        child: Center(child: Text('Only child')),
      ),
    ],
  );
  print('ListBody with single child created');

  // Test ListBody with decorated children
  final decoratedBody = ListBody(
    children: [
      Container(
        height: 45.0,
        margin: EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color: Colors.indigo,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Text('Decorated 1', style: TextStyle(color: Colors.white)),
        ),
      ),
      Container(
        height: 45.0,
        margin: EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(child: Text('Decorated 2')),
      ),
      Container(
        height: 45.0,
        margin: EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color: Colors.cyan,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(child: Text('Decorated 3')),
      ),
    ],
  );
  print('ListBody with decorated children created');

  // ListBody must be placed inside a widget that provides unbounded constraints
  // along its main axis, such as inside a ListView or Column
  print('ListBody test completed');
  return ListView(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    children: [verticalBody, reverseBody, singleChild, decoratedBody],
  );
}
