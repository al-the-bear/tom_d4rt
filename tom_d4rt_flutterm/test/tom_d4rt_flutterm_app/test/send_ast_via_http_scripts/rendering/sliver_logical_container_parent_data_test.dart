// D4rt test script: Tests SliverLogicalContainerParentData from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SliverLogicalContainerParentData test executing');
  final results = <String>[];

  // ========== Section 1: Basic Creation ==========
  print('--- Section 1: Basic SliverLogicalContainerParentData Creation ---');

  final parentData1 = SliverLogicalContainerParentData();
  print('Created SliverLogicalContainerParentData: ${parentData1.runtimeType}');
  print('Type check: ${parentData1 is SliverLogicalContainerParentData}');
  print(
    'Is SliverLogicalParentData: ${parentData1 is SliverLogicalParentData}',
  );
  results.add('Basic creation successful');

  // ========== Section 2: Layout Offset Property ==========
  print('--- Section 2: Layout Offset Property ---');

  final parentData2 = SliverLogicalContainerParentData();
  print('Initial layoutOffset: ${parentData2.layoutOffset}');

  parentData2.layoutOffset = 100.0;
  print('After setting to 100.0: ${parentData2.layoutOffset}');

  parentData2.layoutOffset = 250.5;
  print('After setting to 250.5: ${parentData2.layoutOffset}');

  parentData2.layoutOffset = 0.0;
  print('After setting to 0.0: ${parentData2.layoutOffset}');
  results.add('Layout offset tested');

  // ========== Section 3: Various Layout Offsets ==========
  print('--- Section 3: Various Layout Offsets ---');

  final offsets = [0.0, 50.0, 100.0, 200.0, 500.0, 1000.0, 5000.0];
  for (final offset in offsets) {
    final pd = SliverLogicalContainerParentData();
    pd.layoutOffset = offset;
    print('Layout offset $offset: ${pd.layoutOffset}');
  }
  results.add('Tested ${offsets.length} layout offsets');

  // ========== Section 4: Null Layout Offset ==========
  print('--- Section 4: Null Layout Offset ---');

  final parentData3 = SliverLogicalContainerParentData();
  print('Default layoutOffset is null: ${parentData3.layoutOffset == null}');

  parentData3.layoutOffset = 100.0;
  print('After setting: ${parentData3.layoutOffset}');

  parentData3.layoutOffset = null;
  print('After setting to null: ${parentData3.layoutOffset}');
  results.add('Null layout offset tested');

  // ========== Section 5: Multiple Instances ==========
  print('--- Section 5: Multiple Instances ---');

  final instances = <SliverLogicalContainerParentData>[];
  for (int i = 0; i < 5; i++) {
    final pd = SliverLogicalContainerParentData();
    pd.layoutOffset = i * 100.0;
    instances.add(pd);
    print('Instance $i layoutOffset: ${pd.layoutOffset}');
  }
  print('Created ${instances.length} instances');
  results.add('Created ${instances.length} instances');

  // ========== Section 6: Inheritance Chain ==========
  print('--- Section 6: Inheritance Chain ---');

  final parentData4 = SliverLogicalContainerParentData();
  print('Is ParentData: ${parentData4 is ParentData}');
  print(
    'Is SliverLogicalParentData: ${parentData4 is SliverLogicalParentData}',
  );
  print(
    'Is SliverLogicalContainerParentData: ${parentData4 is SliverLogicalContainerParentData}',
  );
  print('Runtime type: ${parentData4.runtimeType}');
  results.add('Inheritance chain verified');

  // ========== Section 7: Large Layout Offsets ==========
  print('--- Section 7: Large Layout Offsets ---');

  final largeOffsets = [10000.0, 50000.0, 100000.0, 1000000.0];
  for (final offset in largeOffsets) {
    final pd = SliverLogicalContainerParentData();
    pd.layoutOffset = offset;
    print('Large offset $offset: ${pd.layoutOffset}');
  }
  results.add('Tested ${largeOffsets.length} large offsets');

  // ========== Section 8: Fractional Layout Offsets ==========
  print('--- Section 8: Fractional Layout Offsets ---');

  final fractionalOffsets = [0.1, 0.5, 1.5, 10.25, 100.333, 500.666];
  for (final offset in fractionalOffsets) {
    final pd = SliverLogicalContainerParentData();
    pd.layoutOffset = offset;
    print('Fractional offset $offset: ${pd.layoutOffset}');
  }
  results.add('Tested ${fractionalOffsets.length} fractional offsets');

  // ========== Section 9: toString Method ==========
  print('--- Section 9: toString Method ---');

  final parentData5 = SliverLogicalContainerParentData();
  parentData5.layoutOffset = 150.0;
  print('toString: ${parentData5.toString()}');
  results.add('toString tested');

  print('SliverLogicalContainerParentData test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SliverLogicalContainerParentData Tests'),
      Text('Results: ${results.length} sections'),
      ...results.map((r) => Text(r)),
    ],
  );
}
