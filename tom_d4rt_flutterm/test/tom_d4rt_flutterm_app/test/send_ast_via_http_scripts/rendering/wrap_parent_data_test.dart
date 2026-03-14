// D4rt test script: Tests WrapParentData from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('WrapParentData test executing');

  // ========== WrapParentData Basic Creation ==========
  print('--- WrapParentData Basic Creation ---');
  final parentData = WrapParentData();
  print('  created: ${parentData.runtimeType}');
  print('  type: WrapParentData');

  // ========== WrapParentData runIndex Property ==========
  print('--- WrapParentData runIndex Property ---');
  print('  initial runIndex: ${parentData.runIndex}');
  parentData.runIndex = 0;
  print('  runIndex = 0: ${parentData.runIndex}');
  parentData.runIndex = 1;
  print('  runIndex = 1: ${parentData.runIndex}');
  parentData.runIndex = 2;
  print('  runIndex = 2: ${parentData.runIndex}');
  parentData.runIndex = 5;
  print('  runIndex = 5: ${parentData.runIndex}');
  parentData.runIndex = 10;
  print('  runIndex = 10: ${parentData.runIndex}');

  // ========== WrapParentData Multiple Instances ==========
  print('--- WrapParentData Multiple Instances ---');
  final data1 = WrapParentData();
  final data2 = WrapParentData();
  final data3 = WrapParentData();
  final data4 = WrapParentData();

  data1.runIndex = 0;
  data2.runIndex = 0;
  data3.runIndex = 1;
  data4.runIndex = 1;

  print('  data1.runIndex: ${data1.runIndex}');
  print('  data2.runIndex: ${data2.runIndex}');
  print('  data3.runIndex: ${data3.runIndex}');
  print('  data4.runIndex: ${data4.runIndex}');

  // ========== WrapParentData Inheritance ==========
  print('--- WrapParentData Inheritance ---');
  // WrapParentData extends ContainerBoxParentData<RenderBox>
  print('  extends ContainerBoxParentData<RenderBox>: true');
  print(
    '  parentData is ContainerBoxParentData: ${parentData is ContainerBoxParentData}',
  );
  print('  parentData is BoxParentData: ${parentData is BoxParentData}');
  print('  parentData is ParentData: ${parentData is ParentData}');

  // ========== WrapParentData offset Property (inherited) ==========
  print('--- WrapParentData offset Property (inherited) ---');
  print('  initial offset: ${parentData.offset}');
  parentData.offset = Offset.zero;
  print('  offset = Offset.zero: ${parentData.offset}');
  parentData.offset = Offset(10.0, 20.0);
  print('  offset = Offset(10, 20): ${parentData.offset}');
  parentData.offset = Offset(50.5, 100.25);
  print('  offset = Offset(50.5, 100.25): ${parentData.offset}');
  parentData.offset = Offset(-10.0, -5.0);
  print('  offset = Offset(-10, -5): ${parentData.offset}');

  // ========== WrapParentData Simulated Row Layout ==========
  print('--- WrapParentData Simulated Row Layout ---');
  // Simulate items in a wrap layout with multiple rows
  final items = <WrapParentData>[];
  for (int i = 0; i < 6; i++) {
    final item = WrapParentData();
    item.runIndex = i ~/ 3; // 2 items per row
    item.offset = Offset((i % 3) * 100.0, (i ~/ 3) * 50.0);
    items.add(item);
    print('  item[$i]: runIndex=${item.runIndex}, offset=${item.offset}');
  }

  // ========== WrapParentData toString ==========
  print('--- WrapParentData toString ---');
  final toStringData = WrapParentData();
  toStringData.runIndex = 2;
  toStringData.offset = Offset(150.0, 100.0);
  print('  toString(): ${toStringData.toString()}');

  // ========== WrapParentData with Wrap Widget Context ==========
  print('--- WrapParentData with Wrap Widget Context ---');
  print('  WrapParentData is used with RenderWrap');
  print('  runIndex indicates which row/column the child is in');
  print('  offset is set by RenderWrap during layout');

  // ========== WrapParentData Edge Cases ==========
  print('--- WrapParentData Edge Cases ---');
  final edgeCase = WrapParentData();
  edgeCase.runIndex = 0;
  edgeCase.offset = Offset.zero;
  print(
    '  empty wrap (first item): runIndex=${edgeCase.runIndex}, offset=${edgeCase.offset}',
  );

  final largeRunIndex = WrapParentData();
  largeRunIndex.runIndex = 100;
  print('  large runIndex: ${largeRunIndex.runIndex}');

  final largeOffset = WrapParentData();
  largeOffset.offset = Offset(10000.0, 5000.0);
  print('  large offset: ${largeOffset.offset}');

  // ========== WrapParentData Container Properties ==========
  print('--- WrapParentData Container Properties ---');
  final containerData = WrapParentData();
  print('  nextSibling: ${containerData.nextSibling}');
  print('  previousSibling: ${containerData.previousSibling}');

  print('WrapParentData test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'WrapParentData Tests',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('Type: ${parentData.runtimeType}'),
          Text('Properties: runIndex, offset (inherited)'),
          Text('Extends ContainerBoxParentData<RenderBox>'),
          Text('Used with RenderWrap for layout'),
          Text('Multiple instances tested'),
          Text('Row layout simulation completed'),
        ],
      ),
    ),
  );
}
