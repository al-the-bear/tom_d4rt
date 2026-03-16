// D4rt test script: Tests SafeArea from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SafeArea test executing');

  // Test SafeArea with all edges (default)
  final safeAreaAll = SafeArea(
    child: Container(
      color: Colors.blue,
      height: 100.0,
      child: Center(
        child: Text(
          'SafeArea all edges',
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
  );
  print('SafeArea with all edges created');

  // Test SafeArea with top disabled
  final safeAreaNoTop = SafeArea(
    top: false,
    child: Container(
      color: Colors.green,
      height: 100.0,
      child: Center(
        child: Text('SafeArea no top', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('SafeArea with top=false created');

  // Test SafeArea with bottom disabled
  final safeAreaNoBottom = SafeArea(
    bottom: false,
    child: Container(
      color: Colors.orange,
      height: 100.0,
      child: Center(
        child: Text(
          'SafeArea no bottom',
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
  );
  print('SafeArea with bottom=false created');

  // Test SafeArea with left and right disabled
  final safeAreaNoSides = SafeArea(
    left: false,
    right: false,
    child: Container(
      color: Colors.purple,
      height: 100.0,
      child: Center(
        child: Text('SafeArea no sides', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('SafeArea with left=false, right=false created');

  // Test SafeArea with all edges disabled
  final safeAreaNone = SafeArea(
    top: false,
    bottom: false,
    left: false,
    right: false,
    child: Container(
      color: Colors.red,
      height: 100.0,
      child: Center(
        child: Text('SafeArea no edges', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('SafeArea with all edges disabled created');

  // Test SafeArea with minimum padding
  final safeAreaMinPadding = SafeArea(
    minimum: EdgeInsets.all(16.0),
    child: Container(
      color: Colors.teal,
      height: 100.0,
      child: Center(
        child: Text(
          'SafeArea min padding 16',
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
  );
  print('SafeArea with minimum padding=16 created');

  // Test SafeArea with asymmetric minimum padding
  final safeAreaAsymmetric = SafeArea(
    minimum: EdgeInsets.only(left: 20.0, right: 20.0, top: 8.0, bottom: 8.0),
    child: Container(
      color: Colors.indigo,
      height: 100.0,
      child: Center(
        child: Text(
          'SafeArea asymmetric min',
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
  );
  print('SafeArea with asymmetric minimum padding created');

  // Test SafeArea with maintainBottomViewPadding
  final safeAreaMaintainBottom = SafeArea(
    maintainBottomViewPadding: true,
    child: Container(
      color: Colors.brown,
      height: 100.0,
      child: Center(
        child: Text(
          'SafeArea maintainBottom',
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
  );
  print('SafeArea with maintainBottomViewPadding=true created');

  print('SafeArea test completed');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'SafeArea Test',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.0),
        Text(
          'All edges (default):',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        safeAreaAll,
        SizedBox(height: 8.0),
        Text('No top:', style: TextStyle(fontWeight: FontWeight.bold)),
        safeAreaNoTop,
        SizedBox(height: 8.0),
        Text('No bottom:', style: TextStyle(fontWeight: FontWeight.bold)),
        safeAreaNoBottom,
        SizedBox(height: 8.0),
        Text('No sides:', style: TextStyle(fontWeight: FontWeight.bold)),
        safeAreaNoSides,
        SizedBox(height: 8.0),
        Text(
          'All edges disabled:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        safeAreaNone,
        SizedBox(height: 8.0),
        Text(
          'Minimum padding 16:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        safeAreaMinPadding,
        SizedBox(height: 8.0),
        Text(
          'Asymmetric min padding:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        safeAreaAsymmetric,
        SizedBox(height: 8.0),
        Text(
          'Maintain bottom view padding:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        safeAreaMaintainBottom,
        SizedBox(height: 16.0),
        Text('Key Points:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• SafeArea respects system UI intrusions'),
        Text('• top/bottom/left/right control which edges'),
        Text('• minimum sets a floor for padding'),
        Text('• maintainBottomViewPadding for keyboard'),
      ],
    ),
  );
}
