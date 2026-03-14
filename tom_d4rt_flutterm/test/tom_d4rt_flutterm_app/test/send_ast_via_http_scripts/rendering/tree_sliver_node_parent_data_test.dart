// D4rt test script: Tests TreeSliverNodeParentData from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('TreeSliverNodeParentData test executing');

  // ========== TreeSliverNodeParentData Basic Creation ==========
  print('--- TreeSliverNodeParentData Basic Creation ---');
  final parentData = TreeSliverNodeParentData();
  print('  created: ${parentData.runtimeType}');

  // ========== TreeSliverNodeParentData depth Property ==========
  print('--- TreeSliverNodeParentData depth Property ---');
  print('  initial depth: ${parentData.depth}');
  parentData.depth = 0;
  print('  depth = 0: ${parentData.depth}');
  parentData.depth = 1;
  print('  depth = 1: ${parentData.depth}');
  parentData.depth = 2;
  print('  depth = 2: ${parentData.depth}');
  parentData.depth = 5;
  print('  depth = 5: ${parentData.depth}');
  parentData.depth = 10;
  print('  depth = 10: ${parentData.depth}');

  // ========== TreeSliverNodeParentData layoutOffset Property ==========
  print('--- TreeSliverNodeParentData layoutOffset Property ---');
  print('  initial layoutOffset: ${parentData.layoutOffset}');
  parentData.layoutOffset = 0.0;
  print('  layoutOffset = 0.0: ${parentData.layoutOffset}');
  parentData.layoutOffset = 50.0;
  print('  layoutOffset = 50.0: ${parentData.layoutOffset}');
  parentData.layoutOffset = 100.5;
  print('  layoutOffset = 100.5: ${parentData.layoutOffset}');
  parentData.layoutOffset = 250.75;
  print('  layoutOffset = 250.75: ${parentData.layoutOffset}');

  // ========== TreeSliverNodeParentData Multiple Instances ==========
  print('--- TreeSliverNodeParentData Multiple Instances ---');
  final data1 = TreeSliverNodeParentData();
  final data2 = TreeSliverNodeParentData();
  final data3 = TreeSliverNodeParentData();

  data1.depth = 0;
  data1.layoutOffset = 0.0;
  print('  data1: depth=${data1.depth}, layoutOffset=${data1.layoutOffset}');

  data2.depth = 1;
  data2.layoutOffset = 48.0;
  print('  data2: depth=${data2.depth}, layoutOffset=${data2.layoutOffset}');

  data3.depth = 2;
  data3.layoutOffset = 96.0;
  print('  data3: depth=${data3.depth}, layoutOffset=${data3.layoutOffset}');

  // ========== TreeSliverNodeParentData Inheritance ==========
  print('--- TreeSliverNodeParentData Inheritance ---');
  // TreeSliverNodeParentData extends SliverMultiBoxAdaptorParentData
  print('  extends SliverMultiBoxAdaptorParentData: true');
  print(
    '  parentData is SliverMultiBoxAdaptorParentData: ${parentData is SliverMultiBoxAdaptorParentData}',
  );
  print('  parentData is ParentData: ${parentData is ParentData}');

  // ========== TreeSliverNodeParentData Index Property ==========
  print('--- TreeSliverNodeParentData Index Property (inherited) ---');
  print('  initial index: ${parentData.index}');
  parentData.index = 0;
  print('  index = 0: ${parentData.index}');
  parentData.index = 5;
  print('  index = 5: ${parentData.index}');
  parentData.index = 100;
  print('  index = 100: ${parentData.index}');

  // ========== TreeSliverNodeParentData keepAlive Property ==========
  print('--- TreeSliverNodeParentData keepAlive Property (inherited) ---');
  print('  initial keepAlive: ${parentData.keepAlive}');
  parentData.keepAlive = true;
  print('  keepAlive = true: ${parentData.keepAlive}');
  parentData.keepAlive = false;
  print('  keepAlive = false: ${parentData.keepAlive}');

  // ========== TreeSliverNodeParentData toString ==========
  print('--- TreeSliverNodeParentData toString ---');
  final toStringData = TreeSliverNodeParentData();
  toStringData.depth = 3;
  toStringData.layoutOffset = 150.0;
  toStringData.index = 7;
  print('  toString(): ${toStringData.toString()}');

  // ========== TreeSliverNodeParentData Tree Structure Simulation ==========
  print('--- TreeSliverNodeParentData Tree Structure Simulation ---');
  final nodes = <TreeSliverNodeParentData>[];
  for (int i = 0; i < 5; i++) {
    final node = TreeSliverNodeParentData();
    node.depth = i ~/ 2;
    node.layoutOffset = i * 40.0;
    node.index = i;
    nodes.add(node);
    print(
      '  node[$i]: depth=${node.depth}, offset=${node.layoutOffset}, index=${node.index}',
    );
  }

  print('TreeSliverNodeParentData test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'TreeSliverNodeParentData Tests',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('Type: ${parentData.runtimeType}'),
          Text('Properties: depth, layoutOffset'),
          Text('Inherited: index, keepAlive'),
          Text('Extends SliverMultiBoxAdaptorParentData'),
          Text('Multiple instances tested'),
          Text('Tree structure simulation completed'),
        ],
      ),
    ),
  );
}
