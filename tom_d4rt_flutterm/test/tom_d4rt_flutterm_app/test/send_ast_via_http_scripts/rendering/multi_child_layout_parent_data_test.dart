// D4rt test script: Tests MultiChildLayoutParentData from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('MultiChildLayoutParentData test executing');

  // ========== Basic MultiChildLayoutParentData creation ==========
  print('--- Basic MultiChildLayoutParentData ---');
  final pd1 = MultiChildLayoutParentData();
  print('  created: ${pd1.runtimeType}');

  // ========== id property ==========
  print('--- id property ---');
  final pdId1 = MultiChildLayoutParentData();
  pdId1.id = 'header';
  print('  id = "header": ${pdId1.id}');
  
  final pdId2 = MultiChildLayoutParentData();
  pdId2.id = 'body';
  print('  id = "body": ${pdId2.id}');
  
  final pdId3 = MultiChildLayoutParentData();
  pdId3.id = 'footer';
  print('  id = "footer": ${pdId3.id}');
  
  final pdId4 = MultiChildLayoutParentData();
  pdId4.id = 1;
  print('  id = 1 (int): ${pdId4.id}');
  
  final pdId5 = MultiChildLayoutParentData();
  pdId5.id = 'sidebar';
  print('  id = "sidebar": ${pdId5.id}');

  // ========== Different id types ==========
  print('--- Different id types ---');
  final pdString = MultiChildLayoutParentData()..id = 'stringId';
  print('  String id: ${pdString.id}');
  
  final pdInt = MultiChildLayoutParentData()..id = 42;
  print('  int id: ${pdInt.id}');
  
  enum LayoutId { header, content, footer }
  final pdEnum = MultiChildLayoutParentData()..id = LayoutId.header;
  print('  enum id: ${pdEnum.id}');

  // ========== offset property (inherited) ==========
  print('--- offset property ---');
  final pdOffset1 = MultiChildLayoutParentData();
  pdOffset1.id = 'offsetTest1';
  pdOffset1.offset = Offset(10.0, 20.0);
  print('  offset (10, 20): ${pdOffset1.offset}');
  
  final pdOffset2 = MultiChildLayoutParentData();
  pdOffset2.id = 'offsetTest2';
  pdOffset2.offset = Offset(100.0, 200.0);
  print('  offset (100, 200): ${pdOffset2.offset}');
  
  final pdOffset3 = MultiChildLayoutParentData();
  pdOffset3.id = 'offsetTest3';
  pdOffset3.offset = Offset.zero;
  print('  offset (0, 0): ${pdOffset3.offset}');

  // ========== Combined id and offset ==========
  print('--- Combined id and offset ---');
  final combined1 = MultiChildLayoutParentData();
  combined1.id = 'topLeft';
  combined1.offset = Offset(0.0, 0.0);
  print('  topLeft at ${combined1.offset}');
  
  final combined2 = MultiChildLayoutParentData();
  combined2.id = 'center';
  combined2.offset = Offset(100.0, 100.0);
  print('  center at ${combined2.offset}');
  
  final combined3 = MultiChildLayoutParentData();
  combined3.id = 'bottomRight';
  combined3.offset = Offset(200.0, 200.0);
  print('  bottomRight at ${combined3.offset}');

  // ========== Multiple parent data instances ==========
  print('--- Multiple instances ---');
  final ids = ['top', 'middle', 'bottom', 'left', 'right'];
  final dataList = ids.map((id) {
    final pd = MultiChildLayoutParentData();
    pd.id = id;
    pd.offset = Offset(ids.indexOf(id) * 50.0, ids.indexOf(id) * 30.0);
    return pd;
  }).toList();
  for (final pd in dataList) {
    print('  id: ${pd.id}, offset: ${pd.offset}');
  }

  // ========== Inheritance check ==========
  print('--- Inheritance check ---');
  print('  is ContainerBoxParentData: ${pd1 is ContainerBoxParentData}');
  print('  is BoxParentData: ${pd1 is BoxParentData}');
  print('  is ParentData: ${pd1 is ParentData}');

  // ========== RuntimeType checks ==========
  print('--- RuntimeType checks ---');
  print('  pd1.runtimeType: ${pd1.runtimeType}');
  print('  pdId1.runtimeType: ${pdId1.runtimeType}');

  // ========== toString ==========
  print('--- toString ---');
  print('  pdId1.toString(): ${pdId1.toString()}');
  print('  combined1.toString(): ${combined1.toString()}');

  print('MultiChildLayoutParentData test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('MultiChildLayoutParentData Tests',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          SizedBox(height: 8.0),
          Text('Type: ${pd1.runtimeType}'),
          Text('Properties: id, offset'),
          SizedBox(height: 8.0),
          Text('Sample IDs:'),
          Text('  header: ${pdId1.id}'),
          Text('  body: ${pdId2.id}'),
          Text('  footer: ${pdId3.id}'),
          Text('  int id: ${pdId4.id}'),
          SizedBox(height: 8.0),
          Text('Combined examples:'),
          Text('  ${combined1.id} at ${combined1.offset}'),
          Text('  ${combined2.id} at ${combined2.offset}'),
          Text('  ${combined3.id} at ${combined3.offset}'),
          SizedBox(height: 8.0),
          Text('Inheritance: ContainerBoxParentData > BoxParentData'),
        ],
      ),
    ),
  );
}
