// ignore_for_file: avoid_print
// D4rt test script: Tests CupertinoSegmentedControl and CupertinoSlidingSegmentedControl
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('Cupertino segmented controls test executing');

  // ===== 1. CupertinoSegmentedControl with Map =====
  print('--- CupertinoSegmentedControl ---');
  final segmented = CupertinoSegmentedControl(
    children: {
      0: Padding(padding: EdgeInsets.symmetric(horizontal: 16.0), child: Text('Day')),
      1: Padding(padding: EdgeInsets.symmetric(horizontal: 16.0), child: Text('Week')),
      2: Padding(padding: EdgeInsets.symmetric(horizontal: 16.0), child: Text('Month')),
    },
    groupValue: 0,
    onValueChanged: (value) {
      print('  segmented changed: $value');
    },
  );
  print('  basic segmented control created');

  // ===== 2. CupertinoSegmentedControl with custom colors =====
  print('--- Custom colors ---');
  final coloredSegmented = CupertinoSegmentedControl(
    children: {
      'a': Text('Alpha'),
      'b': Text('Beta'),
      'c': Text('Gamma'),
    },
    groupValue: 'a',
    onValueChanged: (value) {},
    selectedColor: CupertinoColors.systemGreen,
    unselectedColor: CupertinoColors.white,
    borderColor: CupertinoColors.systemGreen,
    pressedColor: CupertinoColors.systemGreen.withValues(alpha: 0.2),
  );
  print('  colored segmented (green theme) created');

  // ===== 3. CupertinoSlidingSegmentedControl =====
  print('--- CupertinoSlidingSegmentedControl ---');
  final sliding = CupertinoSlidingSegmentedControl(
    children: {
      0: Text('All'),
      1: Text('Missed'),
    },
    groupValue: 0,
    onValueChanged: (value) {
      print('  sliding changed: $value');
    },
  );
  print('  basic sliding control created');

  // ===== 4. Sliding with custom background and thumb color =====
  print('--- Sliding custom colors ---');
  final customSliding = CupertinoSlidingSegmentedControl(
    children: {
      0: Text('Posts'),
      1: Text('Reels'),
      2: Text('Tags'),
    },
    groupValue: 1,
    onValueChanged: (value) {},
    backgroundColor: CupertinoColors.systemGrey5,
    thumbColor: CupertinoColors.white,
  );
  print('  custom sliding control created');

  // ===== 5. Sliding with icons =====
  print('--- Sliding with icons ---');
  final iconSliding = CupertinoSlidingSegmentedControl(
    children: {
      0: Icon(CupertinoIcons.list_bullet, size: 20.0),
      1: Icon(CupertinoIcons.square_grid_2x2, size: 20.0),
      2: Icon(CupertinoIcons.map, size: 20.0),
    },
    groupValue: 0,
    onValueChanged: (value) {},
  );
  print('  icon sliding control created');

  // ===== 6. Many segments =====
  print('--- Many segments ---');
  final manySegments = CupertinoSegmentedControl(
    children: {
      for (var i = 0; i < 5; i++)
        i: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text('S$i'),
        ),
    },
    groupValue: 2,
    onValueChanged: (value) {},
  );
  print('  5-segment control created');

  // ===== 7. Two segments (minimum) =====
  print('--- Minimum segments ---');
  final twoSegments = CupertinoSlidingSegmentedControl(
    children: {
      true: Text('On'),
      false: Text('Off'),
    },
    groupValue: true,
    onValueChanged: (value) {},
  );
  print('  boolean sliding control created');

  // ===== 8. Null groupValue (no selection) =====
  print('--- Null selection ---');
  final noSelection = CupertinoSlidingSegmentedControl(
    children: {
      0: Text('None'),
      1: Text('Selected'),
    },
    groupValue: null,
    onValueChanged: (value) {},
  );
  print('  no-selection sliding created');

  print('Cupertino segmented controls test completed');
  return CupertinoApp(
    home: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('Segmented Test')),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('CupertinoSegmentedControl:', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8.0),
              segmented,
              SizedBox(height: 16.0),
              Text('Custom colors:', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8.0),
              coloredSegmented,
              SizedBox(height: 16.0),
              Text('Many segments:', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8.0),
              manySegments,
              SizedBox(height: 24.0),
              Text('CupertinoSlidingSegmentedControl:', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8.0),
              sliding,
              SizedBox(height: 16.0),
              Text('Custom sliding:', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8.0),
              customSliding,
              SizedBox(height: 16.0),
              Text('Icon sliding:', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8.0),
              Center(child: iconSliding),
              SizedBox(height: 16.0),
              Text('Boolean sliding:', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8.0),
              Center(child: twoSegments),
              SizedBox(height: 16.0),
              Text('No selection:', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8.0),
              Center(child: noSelection),
            ],
          ),
        ),
      ),
    ),
  );
}
