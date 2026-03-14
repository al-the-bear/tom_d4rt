// D4rt test script: Tests ListBodyParentData from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ListBodyParentData test executing');

  // ========== Basic ListBodyParentData creation ==========
  print('--- Basic ListBodyParentData ---');
  final parentData1 = ListBodyParentData();
  print('  created: ${parentData1.runtimeType}');
  print('  extent (initial): unset');

  // ========== ParentData inheritance ==========
  print('--- ParentData inheritance ---');
  print('  ListBodyParentData extends ContainerBoxParentData');
  print('  parentData1 is ParentData: ${parentData1 is ParentData}');
  print('  parentData1 is BoxParentData: ${parentData1 is BoxParentData}');
  print(
    '  parentData1 is ContainerBoxParentData: ${parentData1 is ContainerBoxParentData}',
  );

  // ========== BoxParentData properties ==========
  print('--- BoxParentData properties ---');
  final parentData2 = ListBodyParentData();
  parentData2.offset = Offset(10.0, 20.0);
  print('  offset set: ${parentData2.offset}');

  parentData2.offset = Offset(50.0, 100.0);
  print('  offset modified: ${parentData2.offset}');

  parentData2.offset = Offset.zero;
  print('  offset cleared: ${parentData2.offset}');

  // ========== ContainerBoxParentData properties ==========
  print('--- ContainerBoxParentData properties ---');
  final containerData = ListBodyParentData();
  print('  previousSibling: ${containerData.previousSibling}');
  print('  nextSibling: ${containerData.nextSibling}');

  // ========== Multiple instances ==========
  print('--- Multiple instances ---');
  final dataA = ListBodyParentData();
  final dataB = ListBodyParentData();
  final dataC = ListBodyParentData();
  dataA.offset = Offset(0.0, 0.0);
  dataB.offset = Offset(0.0, 50.0);
  dataC.offset = Offset(0.0, 100.0);
  print('  dataA offset: ${dataA.offset}');
  print('  dataB offset: ${dataB.offset}');
  print('  dataC offset: ${dataC.offset}');

  // ========== Typical list body layout pattern ==========
  print('--- Typical list layout pattern ---');
  final items = <ListBodyParentData>[];
  double currentY = 0.0;
  for (int i = 0; i < 5; i++) {
    final itemData = ListBodyParentData();
    itemData.offset = Offset(0.0, currentY);
    items.add(itemData);
    currentY += 48.0; // typical list item height
  }
  print('  created ${items.length} list items');
  for (int i = 0; i < items.length; i++) {
    print('  item $i offset: ${items[i].offset}');
  }

  // ========== toString representation ==========
  print('--- toString representation ---');
  final toStringData = ListBodyParentData();
  toStringData.offset = Offset(15.0, 25.0);
  print('  toString: ${toStringData.toString()}');

  // ========== RuntimeType checks ==========
  print('--- RuntimeType checks ---');
  print('  parentData1.runtimeType: ${parentData1.runtimeType}');
  print('  dataA.runtimeType: ${dataA.runtimeType}');

  // ========== Comparing instances ==========
  print('--- Comparing instances ---');
  final compareA = ListBodyParentData();
  final compareB = ListBodyParentData();
  compareA.offset = Offset(10.0, 10.0);
  compareB.offset = Offset(10.0, 10.0);
  print('  compareA == compareB: ${compareA == compareB}');
  print(
    '  compareA.offset == compareB.offset: ${compareA.offset == compareB.offset}',
  );

  print('ListBodyParentData test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'ListBodyParentData Tests',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('Basic data: ${parentData1.runtimeType}'),
          Text('Offset: ${parentData2.offset}'),
          SizedBox(height: 8.0),
          Text('Inheritance:'),
          Text('  - extends ContainerBoxParentData'),
          Text('  - includes offset property'),
          Text('  - includes sibling links'),
          SizedBox(height: 8.0),
          Text('List layout (${items.length} items):'),
          ...items.asMap().entries.map(
            (e) => Text('  Item ${e.key}: y=${e.value.offset.dy}'),
          ),
        ],
      ),
    ),
  );
}
