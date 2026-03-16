// D4rt test script: Tests Offstage from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Offstage test executing');

  // Test Offstage with offstage=true (hidden, no space)
  final offstageTrue = Offstage(
    offstage: true,
    child: Container(
      color: Colors.blue,
      height: 80.0,
      width: 200.0,
      child: Center(
        child: Text('Offstage true', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('Offstage(offstage=true) created - widget hidden');

  // Test Offstage with offstage=false (visible)
  final offstageFalse = Offstage(
    offstage: false,
    child: Container(
      color: Colors.green,
      height: 80.0,
      width: 200.0,
      child: Center(
        child: Text('Offstage false', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('Offstage(offstage=false) created - widget visible');

  // Test Offstage default (offstage defaults to true)
  final offstageDefault = Offstage(
    child: Container(
      color: Colors.red,
      height: 80.0,
      width: 200.0,
      child: Center(
        child: Text('Offstage default', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('Offstage(default) created - defaults to offstage=true');

  // Test Offstage with SizedBox child
  final offstageSizedBox = Offstage(
    offstage: true,
    child: SizedBox(
      width: 150.0,
      height: 150.0,
      child: Container(
        color: Colors.orange,
        child: Center(
          child: Text('SizedBox child', style: TextStyle(color: Colors.white)),
        ),
      ),
    ),
  );
  print('Offstage with SizedBox child created');

  // Test Offstage with visible SizedBox child
  final visibleSizedBox = Offstage(
    offstage: false,
    child: SizedBox(
      width: 150.0,
      height: 80.0,
      child: Container(
        color: Colors.purple,
        child: Center(
          child: Text(
            'Visible SizedBox',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    ),
  );
  print('Offstage(false) with SizedBox child - visible');

  // Test Offstage with Text child
  final offstageText = Offstage(
    offstage: true,
    child: Text('This text is offstage', style: TextStyle(fontSize: 18.0)),
  );
  print('Offstage with Text child created');

  // Test Offstage toggling concept
  final showWidget = false;
  final toggledOffstage = Offstage(
    offstage: showWidget == false,
    child: Container(
      color: Colors.teal,
      height: 80.0,
      child: Center(
        child: Text('Toggled offstage', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print(
    'Offstage toggle concept: showWidget=$showWidget, offstage=${showWidget == false}',
  );

  print('Offstage test completed');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Offstage Test',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.0),
        Text(
          'Offstage=true (hidden):',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Container(
          height: 30.0,
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: Stack(children: [Text('(widget is offstage)'), offstageTrue]),
        ),
        SizedBox(height: 8.0),
        Text(
          'Offstage=false (visible):',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        offstageFalse,
        SizedBox(height: 8.0),
        Text(
          'Default offstage:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Container(
          height: 30.0,
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: Stack(
            children: [Text('(default is offstage)'), offstageDefault],
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          'Visible SizedBox child:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        visibleSizedBox,
        SizedBox(height: 8.0),
        Text(
          'Hidden SizedBox child:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Container(
          height: 30.0,
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: Stack(
            children: [Text('(SizedBox is offstage)'), offstageSizedBox],
          ),
        ),
        SizedBox(height: 16.0),
        Text('Key Points:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• offstage=true hides widget and removes from layout'),
        Text('• offstage=false renders widget normally'),
        Text('• Unlike Visibility, Offstage always removes space'),
        Text('• Widget state is maintained when offstage'),
        Text('• Default value of offstage is true'),
      ],
    ),
  );
}
