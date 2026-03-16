// D4rt test script: Tests CupertinoSliverNavigationBar,
// CupertinoNavigationBarBackButtonMode, CupertinoSegmentedControl variants,
// CupertinoSlidingSegmentedControl
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('Cupertino nav/segmented test executing');

  // ========== CupertinoNavigationBarBackButtonMode ==========
  print('--- CupertinoNavigationBarBackButtonMode Tests ---');
  // The enum values
  print('automatic mode');
  print('noBackButton mode');

  // ========== CupertinoSliverNavigationBar ==========
  print('--- CupertinoSliverNavigationBar Tests ---');
  final sliverNav = CupertinoSliverNavigationBar(
    largeTitle: Text('Large Title'),
    leading: CupertinoButton(
      padding: EdgeInsets.zero,
      child: Icon(CupertinoIcons.back),
      onPressed: () {},
    ),
    trailing: CupertinoButton(
      padding: EdgeInsets.zero,
      child: Icon(CupertinoIcons.add),
      onPressed: () {},
    ),
    previousPageTitle: 'Back',
    border: Border(
      bottom: BorderSide(color: CupertinoColors.separator, width: 0.0),
    ),
    backgroundColor: CupertinoColors.systemBackground,
    brightness: Brightness.light,
    padding: EdgeInsetsDirectional.only(start: 16.0, end: 16.0),
    stretch: true,
  );
  print('CupertinoSliverNavigationBar created');

  // ========== CupertinoSlidingSegmentedControl ==========
  print('--- CupertinoSlidingSegmentedControl Tests ---');
  final slidingSegmented = CupertinoSlidingSegmentedControl<int>(
    groupValue: 0,
    onValueChanged: (int? value) {
      print('Sliding segment changed: $value');
    },
    children: {0: Text('First'), 1: Text('Second'), 2: Text('Third')},
    thumbColor: CupertinoColors.white,
    backgroundColor: CupertinoColors.systemGrey5,
    padding: EdgeInsets.all(4.0),
  );
  print('CupertinoSlidingSegmentedControl created with 3 segments');

  // ========== CupertinoSegmentedControl ==========
  print('--- CupertinoSegmentedControl Tests ---');
  final segmented = CupertinoSegmentedControl<int>(
    groupValue: 1,
    onValueChanged: (int value) {
      print('Segment changed: $value');
    },
    children: {
      0: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Text('One'),
      ),
      1: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Text('Two'),
      ),
      2: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Text('Three'),
      ),
    },
    selectedColor: CupertinoColors.activeBlue,
    unselectedColor: CupertinoColors.white,
    borderColor: CupertinoColors.activeBlue,
    pressedColor: CupertinoColors.systemGrey4,
    padding: EdgeInsets.symmetric(horizontal: 16.0),
  );
  print('CupertinoSegmentedControl created');

  print('All cupertino nav/segmented tests passed');

  // ========== RETURN WIDGET ==========
  return CupertinoApp(
    home: CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          sliverNav,
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [slidingSegmented, SizedBox(height: 16.0), segmented],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
