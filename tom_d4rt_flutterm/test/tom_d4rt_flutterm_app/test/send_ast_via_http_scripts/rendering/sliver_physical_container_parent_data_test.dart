// D4rt test script: Tests SliverPhysicalContainerParentData from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SliverPhysicalContainerParentData test executing');
  final results = <String>[];

  // ========== Section 1: Basic Creation ==========
  print('--- Section 1: Basic SliverPhysicalContainerParentData Creation ---');
  
  final parentData1 = SliverPhysicalContainerParentData();
  print('Created SliverPhysicalContainerParentData: ${parentData1.runtimeType}');
  print('Type check: ${parentData1 is SliverPhysicalContainerParentData}');
  print('Is SliverPhysicalParentData: ${parentData1 is SliverPhysicalParentData}');
  results.add('Basic creation successful');

  // ========== Section 2: Paint Offset Property ==========
  print('--- Section 2: Paint Offset Property ---');
  
  final parentData2 = SliverPhysicalContainerParentData();
  print('Initial paintOffset: ${parentData2.paintOffset}');
  
  parentData2.paintOffset = Offset(100.0, 50.0);
  print('After setting to (100, 50): ${parentData2.paintOffset}');
  
  parentData2.paintOffset = Offset(0.0, 0.0);
  print('After setting to (0, 0): ${parentData2.paintOffset}');
  
  parentData2.paintOffset = Offset(200.5, 150.5);
  print('After setting to (200.5, 150.5): ${parentData2.paintOffset}');
  results.add('Paint offset tested');

  // ========== Section 3: Various Paint Offsets ==========
  print('--- Section 3: Various Paint Offsets ---');
  
  final offsets = [
    Offset(0, 0),
    Offset(50, 25),
    Offset(100, 100),
    Offset(200, 150),
    Offset(500, 300),
    Offset(1000, 800),
  ];
  for (final offset in offsets) {
    final pd = SliverPhysicalContainerParentData();
    pd.paintOffset = offset;
    print('Paint offset $offset: ${pd.paintOffset}');
  }
  results.add('Tested ${offsets.length} paint offsets');

  // ========== Section 4: Negative Paint Offsets ==========
  print('--- Section 4: Negative Paint Offsets ---');
  
  final negativeOffsets = [
    Offset(-10, -5),
    Offset(-50, 25),
    Offset(100, -50),
    Offset(-200, -150),
  ];
  for (final offset in negativeOffsets) {
    final pd = SliverPhysicalContainerParentData();
    pd.paintOffset = offset;
    print('Negative offset $offset: ${pd.paintOffset}');
  }
  results.add('Tested ${negativeOffsets.length} negative offsets');

  // ========== Section 5: Inheritance Chain ==========
  print('--- Section 5: Inheritance Chain ---');
  
  final parentData3 = SliverPhysicalContainerParentData();
  print('Is ParentData: ${parentData3 is ParentData}');
  print('Is SliverPhysicalParentData: ${parentData3 is SliverPhysicalParentData}');
  print('Is SliverPhysicalContainerParentData: ${parentData3 is SliverPhysicalContainerParentData}');
  print('Runtime type: ${parentData3.runtimeType}');
  results.add('Inheritance chain verified');

  // ========== Section 6: Multiple Instances ==========
  print('--- Section 6: Multiple Instances ---');
  
  final instances = <SliverPhysicalContainerParentData>[];
  for (int i = 0; i < 5; i++) {
    final pd = SliverPhysicalContainerParentData();
    pd.paintOffset = Offset(i * 100.0, i * 50.0);
    instances.add(pd);
    print('Instance $i paintOffset: ${pd.paintOffset}');
  }
  print('Created ${instances.length} instances');
  results.add('Created ${instances.length} instances');

  // ========== Section 7: Large Paint Offsets ==========
  print('--- Section 7: Large Paint Offsets ---');
  
  final largeOffsets = [
    Offset(10000, 5000),
    Offset(50000, 25000),
    Offset(100000, 50000),
  ];
  for (final offset in largeOffsets) {
    final pd = SliverPhysicalContainerParentData();
    pd.paintOffset = offset;
    print('Large offset $offset: ${pd.paintOffset}');
  }
  results.add('Tested ${largeOffsets.length} large offsets');

  // ========== Section 8: Fractional Paint Offsets ==========
  print('--- Section 8: Fractional Paint Offsets ---');
  
  final fractionalOffsets = [
    Offset(0.1, 0.2),
    Offset(1.5, 2.5),
    Offset(10.25, 20.75),
    Offset(100.333, 200.666),
  ];
  for (final offset in fractionalOffsets) {
    final pd = SliverPhysicalContainerParentData();
    pd.paintOffset = offset;
    print('Fractional offset $offset: ${pd.paintOffset}');
  }
  results.add('Tested ${fractionalOffsets.length} fractional offsets');

  // ========== Section 9: Paint Offset Components ==========
  print('--- Section 9: Paint Offset Components ---');
  
  final parentData4 = SliverPhysicalContainerParentData();
  parentData4.paintOffset = Offset(150.0, 75.0);
  print('paintOffset.dx: ${parentData4.paintOffset.dx}');
  print('paintOffset.dy: ${parentData4.paintOffset.dy}');
  print('paintOffset.distance: ${parentData4.paintOffset.distance}');
  print('paintOffset.direction: ${parentData4.paintOffset.direction}');
  results.add('Paint offset components tested');

  // ========== Section 10: toString Method ==========
  print('--- Section 10: toString Method ---');
  
  final parentData5 = SliverPhysicalContainerParentData();
  parentData5.paintOffset = Offset(100.0, 50.0);
  print('toString: ${parentData5.toString()}');
  results.add('toString tested');

  print('SliverPhysicalContainerParentData test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SliverPhysicalContainerParentData Tests'),
      Text('Results: ${results.length} sections'),
      ...results.map((r) => Text(r)),
    ],
  );
}
