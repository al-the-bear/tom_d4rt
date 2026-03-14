// D4rt test script: Tests TextParentData from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('TextParentData test executing');
  final results = <String>[];

  // ========== Section 1: Basic Creation ==========
  print('--- Section 1: Basic TextParentData Creation ---');
  
  final parentData1 = TextParentData();
  print('Created TextParentData: ${parentData1.runtimeType}');
  print('Type check: ${parentData1 is TextParentData}');
  print('Is ContainerBoxParentData: ${parentData1 is ContainerBoxParentData}');
  results.add('Basic creation successful');

  // ========== Section 2: Scale Property ==========
  print('--- Section 2: Scale Property ---');
  
  final parentData2 = TextParentData();
  print('Initial scale: ${parentData2.scale}');
  
  parentData2.scale = 1.0;
  print('After setting to 1.0: ${parentData2.scale}');
  
  parentData2.scale = 1.5;
  print('After setting to 1.5: ${parentData2.scale}');
  
  parentData2.scale = 2.0;
  print('After setting to 2.0: ${parentData2.scale}');
  
  parentData2.scale = 0.5;
  print('After setting to 0.5: ${parentData2.scale}');
  results.add('Scale property tested');

  // ========== Section 3: Various Scale Values ==========
  print('--- Section 3: Various Scale Values ---');
  
  final scales = [0.25, 0.5, 0.75, 1.0, 1.25, 1.5, 2.0, 3.0];
  for (final scale in scales) {
    final pd = TextParentData();
    pd.scale = scale;
    print('Scale $scale: ${pd.scale}');
  }
  results.add('Tested ${scales.length} scale values');

  // ========== Section 4: Offset Property (inherited) ==========
  print('--- Section 4: Offset Property ---');
  
  final parentData3 = TextParentData();
  print('Initial offset: ${parentData3.offset}');
  
  parentData3.offset = Offset(100.0, 50.0);
  print('After setting to (100, 50): ${parentData3.offset}');
  
  parentData3.offset = Offset.zero;
  print('After setting to zero: ${parentData3.offset}');
  
  parentData3.offset = Offset(200.5, 150.5);
  print('After setting to (200.5, 150.5): ${parentData3.offset}');
  results.add('Offset property tested');

  // ========== Section 5: Combined Properties ==========
  print('--- Section 5: Combined Properties ---');
  
  final combined = TextParentData();
  combined.scale = 1.5;
  combined.offset = Offset(25.0, 50.0);
  print('Combined - scale: ${combined.scale}');
  print('Combined - offset: ${combined.offset}');
  results.add('Combined properties tested');

  // ========== Section 6: Multiple Instances ==========
  print('--- Section 6: Multiple Instances ---');
  
  final instances = <TextParentData>[];
  for (int i = 0; i < 5; i++) {
    final pd = TextParentData();
    pd.scale = 0.5 + (i * 0.25);
    pd.offset = Offset(i * 10.0, i * 20.0);
    instances.add(pd);
    print('Instance $i - scale: ${pd.scale}, offset: ${pd.offset}');
  }
  results.add('Created ${instances.length} instances');

  // ========== Section 7: Inheritance Chain ==========
  print('--- Section 7: Inheritance Chain ---');
  
  final parentData4 = TextParentData();
  print('Is ParentData: ${parentData4 is ParentData}');
  print('Is BoxParentData: ${parentData4 is BoxParentData}');
  print('Is ContainerBoxParentData: ${parentData4 is ContainerBoxParentData}');
  print('Is TextParentData: ${parentData4 is TextParentData}');
  print('Runtime type: ${parentData4.runtimeType}');
  results.add('Inheritance chain verified');

  // ========== Section 8: Null Scale ==========
  print('--- Section 8: Null Scale ---');
  
  final parentData5 = TextParentData();
  print('Default scale is null: ${parentData5.scale == null}');
  
  parentData5.scale = 1.0;
  print('After setting to 1.0: ${parentData5.scale}');
  
  parentData5.scale = null;
  print('After setting to null: ${parentData5.scale}');
  results.add('Null scale tested');

  // ========== Section 9: Large and Small Scales ==========
  print('--- Section 9: Large and Small Scales ---');
  
  final extremeScales = [0.01, 0.1, 10.0, 100.0];
  for (final scale in extremeScales) {
    final pd = TextParentData();
    pd.scale = scale;
    print('Extreme scale $scale: ${pd.scale}');
  }
  results.add('Tested ${extremeScales.length} extreme scales');

  // ========== Section 10: Various Offsets ==========
  print('--- Section 10: Various Offsets ---');
  
  final offsets = [
    Offset(0, 0),
    Offset(10, 20),
    Offset(100, 200),
    Offset(-50, -100),
    Offset(1000, 500),
  ];
  for (final offset in offsets) {
    final pd = TextParentData();
    pd.offset = offset;
    print('Offset $offset: dx=${pd.offset.dx}, dy=${pd.offset.dy}');
  }
  results.add('Tested ${offsets.length} offsets');

  // ========== Section 11: toString Method ==========
  print('--- Section 11: toString Method ---');
  
  final parentData6 = TextParentData();
  parentData6.scale = 1.5;
  parentData6.offset = Offset(50.0, 100.0);
  print('toString: ${parentData6.toString()}');
  results.add('toString tested');

  print('TextParentData test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TextParentData Tests'),
      Text('Results: ${results.length} sections'),
      ...results.map((r) => Text(r)),
    ],
  );
}
