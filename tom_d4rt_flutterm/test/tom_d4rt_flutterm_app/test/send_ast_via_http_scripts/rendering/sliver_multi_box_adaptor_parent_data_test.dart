// D4rt test script: Tests SliverMultiBoxAdaptorParentData from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SliverMultiBoxAdaptorParentData test executing');
  final results = <String>[];

  // ========== Section 1: Basic Creation ==========
  print('--- Section 1: Basic SliverMultiBoxAdaptorParentData Creation ---');
  
  final parentData1 = SliverMultiBoxAdaptorParentData();
  print('Created SliverMultiBoxAdaptorParentData: ${parentData1.runtimeType}');
  print('Type check: ${parentData1 is SliverMultiBoxAdaptorParentData}');
  results.add('Basic creation successful');

  // ========== Section 2: Index Property ==========
  print('--- Section 2: Index Property ---');
  
  final parentData2 = SliverMultiBoxAdaptorParentData();
  print('Initial index: ${parentData2.index}');
  
  parentData2.index = 0;
  print('After setting to 0: ${parentData2.index}');
  
  parentData2.index = 5;
  print('After setting to 5: ${parentData2.index}');
  
  parentData2.index = 100;
  print('After setting to 100: ${parentData2.index}');
  results.add('Index property tested');

  // ========== Section 3: KeepAlive Property ==========
  print('--- Section 3: KeepAlive Property ---');
  
  final parentData3 = SliverMultiBoxAdaptorParentData();
  print('Initial keepAlive: ${parentData3.keepAlive}');
  
  parentData3.keepAlive = true;
  print('After setting to true: ${parentData3.keepAlive}');
  
  parentData3.keepAlive = false;
  print('After setting to false: ${parentData3.keepAlive}');
  results.add('KeepAlive property tested');

  // ========== Section 4: Layout Offset Property ==========
  print('--- Section 4: Layout Offset Property ---');
  
  final parentData4 = SliverMultiBoxAdaptorParentData();
  print('Initial layoutOffset: ${parentData4.layoutOffset}');
  
  parentData4.layoutOffset = 100.0;
  print('After setting to 100.0: ${parentData4.layoutOffset}');
  
  parentData4.layoutOffset = 0.0;
  print('After setting to 0.0: ${parentData4.layoutOffset}');
  
  parentData4.layoutOffset = 500.5;
  print('After setting to 500.5: ${parentData4.layoutOffset}');
  results.add('Layout offset tested');

  // ========== Section 5: Multiple Indices ==========
  print('--- Section 5: Multiple Indices ---');
  
  final indices = [0, 1, 5, 10, 50, 100, 500, 1000];
  for (final idx in indices) {
    final pd = SliverMultiBoxAdaptorParentData();
    pd.index = idx;
    print('Index $idx: ${pd.index}');
  }
  results.add('Tested ${indices.length} indices');

  // ========== Section 6: Combined Properties ==========
  print('--- Section 6: Combined Properties ---');
  
  final combined = SliverMultiBoxAdaptorParentData();
  combined.index = 42;
  combined.keepAlive = true;
  combined.layoutOffset = 250.0;
  print('Combined - index: ${combined.index}');
  print('Combined - keepAlive: ${combined.keepAlive}');
  print('Combined - layoutOffset: ${combined.layoutOffset}');
  results.add('Combined properties: index=42, keepAlive=true');

  // ========== Section 7: Inheritance Chain ==========
  print('--- Section 7: Inheritance Chain ---');
  
  final parentData5 = SliverMultiBoxAdaptorParentData();
  print('Is ParentData: ${parentData5 is ParentData}');
  print('Is SliverLogicalParentData: ${parentData5 is SliverLogicalParentData}');
  print('Is SliverMultiBoxAdaptorParentData: ${parentData5 is SliverMultiBoxAdaptorParentData}');
  print('Runtime type: ${parentData5.runtimeType}');
  results.add('Inheritance chain verified');

  // ========== Section 8: Multiple Instances with Different States ==========
  print('--- Section 8: Multiple Instances with Different States ---');
  
  final instances = <SliverMultiBoxAdaptorParentData>[];
  for (int i = 0; i < 5; i++) {
    final pd = SliverMultiBoxAdaptorParentData();
    pd.index = i;
    pd.keepAlive = i % 2 == 0;
    pd.layoutOffset = i * 50.0;
    instances.add(pd);
    print('Instance $i - index: ${pd.index}, keepAlive: ${pd.keepAlive}, offset: ${pd.layoutOffset}');
  }
  results.add('Created ${instances.length} instances');

  // ========== Section 9: Null Index ==========
  print('--- Section 9: Null Index ---');
  
  final parentData6 = SliverMultiBoxAdaptorParentData();
  print('Default index is null: ${parentData6.index == null}');
  parentData6.index = 10;
  print('After setting to 10: ${parentData6.index}');
  parentData6.index = null;
  print('After setting to null: ${parentData6.index}');
  results.add('Null index tested');

  // ========== Section 10: toString Method ==========
  print('--- Section 10: toString Method ---');
  
  final parentData7 = SliverMultiBoxAdaptorParentData();
  parentData7.index = 3;
  parentData7.keepAlive = true;
  parentData7.layoutOffset = 100.0;
  print('toString: ${parentData7.toString()}');
  results.add('toString tested');

  print('SliverMultiBoxAdaptorParentData test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SliverMultiBoxAdaptorParentData Tests'),
      Text('Results: ${results.length} sections'),
      ...results.map((r) => Text(r)),
    ],
  );
}
