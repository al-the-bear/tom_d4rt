// D4rt test script: Tests TableCellParentData from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('TableCellParentData test executing');
  final results = <String>[];

  // ========== Section 1: Basic Creation ==========
  print('--- Section 1: Basic TableCellParentData Creation ---');
  
  final parentData1 = TableCellParentData();
  print('Created TableCellParentData: ${parentData1.runtimeType}');
  print('Type check: ${parentData1 is TableCellParentData}');
  print('Is BoxParentData: ${parentData1 is BoxParentData}');
  results.add('Basic creation successful');

  // ========== Section 2: Vertical Alignment Property ==========
  print('--- Section 2: Vertical Alignment Property ---');
  
  final parentData2 = TableCellParentData();
  print('Initial verticalAlignment: ${parentData2.verticalAlignment}');
  
  parentData2.verticalAlignment = TableCellVerticalAlignment.top;
  print('After setting to top: ${parentData2.verticalAlignment}');
  
  parentData2.verticalAlignment = TableCellVerticalAlignment.middle;
  print('After setting to middle: ${parentData2.verticalAlignment}');
  
  parentData2.verticalAlignment = TableCellVerticalAlignment.bottom;
  print('After setting to bottom: ${parentData2.verticalAlignment}');
  
  parentData2.verticalAlignment = TableCellVerticalAlignment.baseline;
  print('After setting to baseline: ${parentData2.verticalAlignment}');
  
  parentData2.verticalAlignment = TableCellVerticalAlignment.fill;
  print('After setting to fill: ${parentData2.verticalAlignment}');
  results.add('Vertical alignment tested');

  // ========== Section 3: All TableCellVerticalAlignment Values ==========
  print('--- Section 3: All TableCellVerticalAlignment Values ---');
  
  for (final alignment in TableCellVerticalAlignment.values) {
    final pd = TableCellParentData();
    pd.verticalAlignment = alignment;
    print('Alignment ${alignment.name}: ${pd.verticalAlignment}');
  }
  print('Total alignments: ${TableCellVerticalAlignment.values.length}');
  results.add('All ${TableCellVerticalAlignment.values.length} alignments tested');

  // ========== Section 4: Offset Property (inherited from BoxParentData) ==========
  print('--- Section 4: Offset Property ---');
  
  final parentData3 = TableCellParentData();
  print('Initial offset: ${parentData3.offset}');
  
  parentData3.offset = Offset(100.0, 50.0);
  print('After setting to (100, 50): ${parentData3.offset}');
  
  parentData3.offset = Offset.zero;
  print('After setting to zero: ${parentData3.offset}');
  results.add('Offset property tested');

  // ========== Section 5: Combined Properties ==========
  print('--- Section 5: Combined Properties ---');
  
  final combined = TableCellParentData();
  combined.verticalAlignment = TableCellVerticalAlignment.middle;
  combined.offset = Offset(25.0, 50.0);
  print('Combined - verticalAlignment: ${combined.verticalAlignment}');
  print('Combined - offset: ${combined.offset}');
  results.add('Combined properties tested');

  // ========== Section 6: Multiple Instances ==========
  print('--- Section 6: Multiple Instances ---');
  
  final instances = <TableCellParentData>[];
  final alignments = TableCellVerticalAlignment.values;
  for (int i = 0; i < alignments.length; i++) {
    final pd = TableCellParentData();
    pd.verticalAlignment = alignments[i];
    pd.offset = Offset(i * 10.0, i * 20.0);
    instances.add(pd);
    print('Instance $i - alignment: ${pd.verticalAlignment}, offset: ${pd.offset}');
  }
  results.add('Created ${instances.length} instances');

  // ========== Section 7: Inheritance Chain ==========
  print('--- Section 7: Inheritance Chain ---');
  
  final parentData4 = TableCellParentData();
  print('Is ParentData: ${parentData4 is ParentData}');
  print('Is BoxParentData: ${parentData4 is BoxParentData}');
  print('Is TableCellParentData: ${parentData4 is TableCellParentData}');
  print('Runtime type: ${parentData4.runtimeType}');
  results.add('Inheritance chain verified');

  // ========== Section 8: Null Vertical Alignment ==========
  print('--- Section 8: Null Vertical Alignment ---');
  
  final parentData5 = TableCellParentData();
  print('Default verticalAlignment is null: ${parentData5.verticalAlignment == null}');
  
  parentData5.verticalAlignment = TableCellVerticalAlignment.top;
  print('After setting to top: ${parentData5.verticalAlignment}');
  
  parentData5.verticalAlignment = null;
  print('After setting to null: ${parentData5.verticalAlignment}');
  results.add('Null alignment tested');

  // ========== Section 9: Various Offsets ==========
  print('--- Section 9: Various Offsets ---');
  
  final offsets = [
    Offset(0, 0),
    Offset(10, 20),
    Offset(100, 200),
    Offset(-50, -100),
    Offset(1000, 500),
  ];
  for (final offset in offsets) {
    final pd = TableCellParentData();
    pd.offset = offset;
    print('Offset $offset: dx=${pd.offset.dx}, dy=${pd.offset.dy}');
  }
  results.add('Tested ${offsets.length} offsets');

  // ========== Section 10: toString Method ==========
  print('--- Section 10: toString Method ---');
  
  final parentData6 = TableCellParentData();
  parentData6.verticalAlignment = TableCellVerticalAlignment.middle;
  parentData6.offset = Offset(50.0, 100.0);
  print('toString: ${parentData6.toString()}');
  results.add('toString tested');

  print('TableCellParentData test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TableCellParentData Tests'),
      Text('Results: ${results.length} sections'),
      ...results.map((r) => Text(r)),
    ],
  );
}
