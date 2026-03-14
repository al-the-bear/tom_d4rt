// D4rt test script: Tests SliverPhysicalParentData from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SliverPhysicalParentData test executing');
  final results = <String>[];

  // ========== Section 1: Basic Creation ==========
  print('--- Section 1: Basic SliverPhysicalParentData Creation ---');

  final parentData1 = SliverPhysicalParentData();
  print('Created SliverPhysicalParentData: ${parentData1.runtimeType}');
  print('Type check: ${parentData1 is SliverPhysicalParentData}');
  print('Is ParentData: ${parentData1 is ParentData}');
  results.add('Basic creation successful');

  // ========== Section 2: Paint Offset Property ==========
  print('--- Section 2: Paint Offset Property ---');

  final parentData2 = SliverPhysicalParentData();
  print('Initial paintOffset: ${parentData2.paintOffset}');

  parentData2.paintOffset = Offset(100.0, 50.0);
  print('After setting to (100, 50): ${parentData2.paintOffset}');

  parentData2.paintOffset = Offset(0.0, 0.0);
  print('After setting to (0, 0): ${parentData2.paintOffset}');

  parentData2.paintOffset = Offset(200.5, 150.5);
  print('After setting to (200.5, 150.5): ${parentData2.paintOffset}');
  results.add('Paint offset tested');

  // ========== Section 3: Offset Zero ==========
  print('--- Section 3: Offset Zero ---');

  final parentData3 = SliverPhysicalParentData();
  parentData3.paintOffset = Offset.zero;
  print('Offset.zero: ${parentData3.paintOffset}');
  print('Is zero: ${parentData3.paintOffset == Offset.zero}');
  results.add('Offset.zero tested');

  // ========== Section 4: Various Paint Offsets ==========
  print('--- Section 4: Various Paint Offsets ---');

  final offsets = [
    Offset(0, 0),
    Offset(10, 20),
    Offset(50, 100),
    Offset(100, 200),
    Offset(250, 500),
    Offset(500, 1000),
  ];
  for (final offset in offsets) {
    final pd = SliverPhysicalParentData();
    pd.paintOffset = offset;
    print(
      'Paint offset $offset: dx=${pd.paintOffset.dx}, dy=${pd.paintOffset.dy}',
    );
  }
  results.add('Tested ${offsets.length} paint offsets');

  // ========== Section 5: Negative Offsets ==========
  print('--- Section 5: Negative Offsets ---');

  final negativeOffsets = [
    Offset(-10, -20),
    Offset(-50, 0),
    Offset(0, -100),
    Offset(-200, -150),
  ];
  for (final offset in negativeOffsets) {
    final pd = SliverPhysicalParentData();
    pd.paintOffset = offset;
    print('Negative offset $offset: ${pd.paintOffset}');
  }
  results.add('Tested ${negativeOffsets.length} negative offsets');

  // ========== Section 6: Multiple Instances ==========
  print('--- Section 6: Multiple Instances ---');

  final instances = <SliverPhysicalParentData>[];
  for (int i = 0; i < 5; i++) {
    final pd = SliverPhysicalParentData();
    pd.paintOffset = Offset(i * 50.0, i * 25.0);
    instances.add(pd);
    print('Instance $i paintOffset: ${pd.paintOffset}');
  }
  print('Created ${instances.length} instances');
  results.add('Created ${instances.length} instances');

  // ========== Section 7: Inheritance Chain ==========
  print('--- Section 7: Inheritance Chain ---');

  final parentData4 = SliverPhysicalParentData();
  print('Is ParentData: ${parentData4 is ParentData}');
  print(
    'Is SliverPhysicalParentData: ${parentData4 is SliverPhysicalParentData}',
  );
  print('Runtime type: ${parentData4.runtimeType}');
  results.add('Inheritance chain verified');

  // ========== Section 8: Large Paint Offsets ==========
  print('--- Section 8: Large Paint Offsets ---');

  final largeOffsets = [
    Offset(10000, 5000),
    Offset(50000, 25000),
    Offset(100000, 50000),
    Offset(1000000, 500000),
  ];
  for (final offset in largeOffsets) {
    final pd = SliverPhysicalParentData();
    pd.paintOffset = offset;
    print('Large offset dx: ${pd.paintOffset.dx}, dy: ${pd.paintOffset.dy}');
  }
  results.add('Tested ${largeOffsets.length} large offsets');

  // ========== Section 9: Fractional Offsets ==========
  print('--- Section 9: Fractional Offsets ---');

  final fractionalOffsets = [
    Offset(0.1, 0.2),
    Offset(1.5, 2.5),
    Offset(10.123, 20.456),
    Offset(100.999, 200.001),
  ];
  for (final offset in fractionalOffsets) {
    final pd = SliverPhysicalParentData();
    pd.paintOffset = offset;
    print('Fractional offset: ${pd.paintOffset}');
  }
  results.add('Tested ${fractionalOffsets.length} fractional offsets');

  // ========== Section 10: Offset Distance and Direction ==========
  print('--- Section 10: Offset Distance and Direction ---');

  final parentData5 = SliverPhysicalParentData();
  parentData5.paintOffset = Offset(100.0, 100.0);
  print('Offset (100, 100) distance: ${parentData5.paintOffset.distance}');
  print('Offset (100, 100) direction: ${parentData5.paintOffset.direction}');
  print(
    'Offset (100, 100) distanceSquared: ${parentData5.paintOffset.distanceSquared}',
  );
  results.add('Distance and direction tested');

  // ========== Section 11: toString Method ==========
  print('--- Section 11: toString Method ---');

  final parentData6 = SliverPhysicalParentData();
  parentData6.paintOffset = Offset(75.0, 125.0);
  print('toString: ${parentData6.toString()}');
  results.add('toString tested');

  print('SliverPhysicalParentData test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SliverPhysicalParentData Tests'),
      Text('Results: ${results.length} sections'),
      ...results.map((r) => Text(r)),
    ],
  );
}
