// D4rt test script: Tests Builder from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Builder test executing');

  // Test Builder with simple builder function returning Container
  final simpleBuilder = Builder(
    builder: (BuildContext ctx) {
      print('Builder callback invoked - returning Container');
      return Container(
        color: Colors.blue,
        height: 60.0,
        child: Center(
          child: Text('Simple Builder', style: TextStyle(color: Colors.white)),
        ),
      );
    },
  );
  print('Builder with Container child created');

  // Test Builder returning Text widget
  final textBuilder = Builder(
    builder: (BuildContext ctx) {
      print('Builder callback invoked - returning Text');
      return Text(
        'Builder returns Text',
        style: TextStyle(fontSize: 18.0, color: Colors.green),
      );
    },
  );
  print('Builder returning Text created');

  // Test Builder returning Column
  final columnBuilder = Builder(
    builder: (BuildContext ctx) {
      print('Builder callback invoked - returning Column');
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [Text('Item 1'), Text('Item 2'), Text('Item 3')],
      );
    },
  );
  print('Builder returning Column created');

  // Test Builder accessing Theme from context
  final themeBuilder = Builder(
    builder: (BuildContext ctx) {
      final theme = Theme.of(ctx);
      print('Builder accessing Theme: ${theme.primaryColor}');
      return Container(
        color: theme.primaryColor,
        height: 60.0,
        child: Center(
          child: Text('Theme color', style: TextStyle(color: Colors.white)),
        ),
      );
    },
  );
  print('Builder accessing Theme.of(context) created');

  // Test Builder accessing MediaQuery from context
  final mediaBuilder = Builder(
    builder: (BuildContext ctx) {
      final media = MediaQuery.of(ctx);
      print('Builder accessing MediaQuery: size=${media.size}');
      return Container(
        color: Colors.orange,
        height: 60.0,
        child: Center(
          child: Text(
            'Screen: ${media.size.width.toInt()}x${media.size.height.toInt()}',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    },
  );
  print('Builder accessing MediaQuery created');

  // Test Builder returning Card
  final cardBuilder = Builder(
    builder: (BuildContext ctx) {
      print('Builder callback invoked - returning Card');
      return Card(
        elevation: 4.0,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('Card from Builder'),
        ),
      );
    },
  );
  print('Builder returning Card created');

  // Test nested Builders
  final nestedBuilder = Builder(
    builder: (BuildContext outerCtx) {
      print('Outer Builder invoked');
      return Container(
        color: Colors.grey,
        padding: EdgeInsets.all(8.0),
        child: Builder(
          builder: (BuildContext innerCtx) {
            print('Inner Builder invoked');
            return Container(
              color: Colors.indigo,
              height: 40.0,
              child: Center(
                child: Text(
                  'Nested Builder',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
          },
        ),
      );
    },
  );
  print('Nested Builder created');

  // --- StatefulBuilder tests ---
  
  // Test StatefulBuilder with basic state
  final statefulBasic = StatefulBuilder(
    builder: (BuildContext ctx, void Function(void Function()) setState) {
      print('StatefulBuilder basic builder invoked');
      return Container(
        color: Colors.teal,
        height: 60.0,
        child: Center(
          child: Text('StatefulBuilder Basic', style: TextStyle(color: Colors.white)),
        ),
      );
    },
  );
  print('StatefulBuilder basic created');

  // Test StatefulBuilder with counter-like state
  final statefulCounter = StatefulBuilder(
    builder: (BuildContext ctx, void Function(void Function()) setState) {
      print('StatefulBuilder counter builder invoked');
      return Container(
        color: Colors.deepPurple,
        height: 60.0,
        child: Center(
          child: Text('Counter: 0', style: TextStyle(color: Colors.white, fontSize: 18.0)),
        ),
      );
    },
  );
  print('StatefulBuilder counter created');

  // Test StatefulBuilder with toggle pattern
  final statefulToggle = StatefulBuilder(
    builder: (BuildContext ctx, void Function(void Function()) setState) {
      print('StatefulBuilder toggle builder invoked');
      return Container(
        color: Colors.amber,
        height: 60.0,
        child: Center(
          child: Text('Toggle: OFF', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      );
    },
  );
  print('StatefulBuilder toggle created');

  print('Builder test completed');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Builder Test',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.0),
        Text('Simple Builder:', style: TextStyle(fontWeight: FontWeight.bold)),
        simpleBuilder,
        SizedBox(height: 8.0),
        Text('Text Builder:', style: TextStyle(fontWeight: FontWeight.bold)),
        textBuilder,
        SizedBox(height: 8.0),
        Text('Column Builder:', style: TextStyle(fontWeight: FontWeight.bold)),
        columnBuilder,
        SizedBox(height: 8.0),
        Text('Theme Builder:', style: TextStyle(fontWeight: FontWeight.bold)),
        themeBuilder,
        SizedBox(height: 8.0),
        Text(
          'MediaQuery Builder:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        mediaBuilder,
        SizedBox(height: 8.0),
        Text('Card Builder:', style: TextStyle(fontWeight: FontWeight.bold)),
        cardBuilder,
        SizedBox(height: 8.0),
        Text('Nested Builder:', style: TextStyle(fontWeight: FontWeight.bold)),
        nestedBuilder,
        SizedBox(height: 16.0),
        Text('StatefulBuilder Tests:', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
        SizedBox(height: 8.0),
        statefulBasic,
        SizedBox(height: 8.0),
        statefulCounter,
        SizedBox(height: 8.0),
        statefulToggle,
        SizedBox(height: 16.0),
        Text('Key Points:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• Builder provides a new BuildContext'),
        Text('• Useful for accessing inherited widgets'),
        Text('• Builder function runs during build phase'),
        Text('• Can return any widget type'),
        Text('• StatefulBuilder provides a setState callback'),
        Text('• StatefulBuilder enables local state in build()'),
      ],
    ),
  );
}
