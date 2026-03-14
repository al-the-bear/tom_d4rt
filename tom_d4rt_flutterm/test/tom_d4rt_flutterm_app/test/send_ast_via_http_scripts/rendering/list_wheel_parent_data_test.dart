// D4rt test script: Tests ListWheelParentData from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ListWheelParentData test executing');

  // ========== Basic ListWheelParentData creation ==========
  print('--- Basic ListWheelParentData ---');
  final parentData1 = ListWheelParentData();
  print('  created: ${parentData1.runtimeType}');

  // ========== index property ==========
  print('--- index property ---');
  final pd1 = ListWheelParentData();
  pd1.index = 0;
  print('  index = 0: ${pd1.index}');

  final pd2 = ListWheelParentData();
  pd2.index = 5;
  print('  index = 5: ${pd2.index}');

  final pd3 = ListWheelParentData();
  pd3.index = 10;
  print('  index = 10: ${pd3.index}');

  final pd4 = ListWheelParentData();
  pd4.index = 100;
  print('  index = 100: ${pd4.index}');

  // ========== negative index ==========
  print('--- negative index ---');
  final pdNeg = ListWheelParentData();
  pdNeg.index = -1;
  print('  index = -1: ${pdNeg.index}');

  // ========== offset property (inherited from ContainerBoxParentData) ==========
  print('--- offset property ---');
  final pdOffset1 = ListWheelParentData();
  pdOffset1.offset = Offset(10.0, 20.0);
  print('  offset (10, 20): ${pdOffset1.offset}');

  final pdOffset2 = ListWheelParentData();
  pdOffset2.offset = Offset(0.0, 0.0);
  print('  offset (0, 0): ${pdOffset2.offset}');

  final pdOffset3 = ListWheelParentData();
  pdOffset3.offset = Offset(100.0, 200.0);
  print('  offset (100, 200): ${pdOffset3.offset}');

  final pdOffset4 = ListWheelParentData();
  pdOffset4.offset = Offset(-50.0, -100.0);
  print('  offset (-50, -100): ${pdOffset4.offset}');

  // ========== Combined index and offset ==========
  print('--- Combined index and offset ---');
  final pdCombined = ListWheelParentData();
  pdCombined.index = 3;
  pdCombined.offset = Offset(50.0, 150.0);
  print('  index: ${pdCombined.index}, offset: ${pdCombined.offset}');

  // ========== Multiple instances ==========
  print('--- Multiple instances ---');
  final dataList = List.generate(5, (i) {
    final pd = ListWheelParentData();
    pd.index = i;
    pd.offset = Offset(i * 10.0, i * 20.0);
    return pd;
  });
  for (int i = 0; i < dataList.length; i++) {
    print(
      '  child $i: index=${dataList[i].index}, offset=${dataList[i].offset}',
    );
  }

  // ========== Is ContainerBoxParentData ==========
  print('--- Inheritance check ---');
  print(
    '  is ContainerBoxParentData: ${parentData1 is ContainerBoxParentData}',
  );
  print('  is ParentData: ${parentData1 is ParentData}');

  // ========== RuntimeType ==========
  print('--- RuntimeType ---');
  print('  runtimeType: ${parentData1.runtimeType}');

  // ========== Default values ==========
  print('--- Default values ---');
  final pdDefault = ListWheelParentData();
  print('  default index: ${pdDefault.index}');
  print('  default offset: ${pdDefault.offset}');

  print('ListWheelParentData test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'ListWheelParentData Tests',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('Type: ${parentData1.runtimeType}'),
          Text('Properties: index, offset'),
          SizedBox(height: 8.0),
          Text('Sample values:'),
          Text('  index=0: ${pd1.index}'),
          Text('  index=5: ${pd2.index}'),
          Text('  index=10: ${pd3.index}'),
          SizedBox(height: 8.0),
          Text('Offset examples:'),
          Text('  offset: ${pdOffset1.offset}'),
          Text('  offset: ${pdOffset2.offset}'),
          Text('  offset: ${pdOffset3.offset}'),
          SizedBox(height: 8.0),
          Text('Combined: index=${pdCombined.index}, ${pdCombined.offset}'),
        ],
      ),
    ),
  );
}
