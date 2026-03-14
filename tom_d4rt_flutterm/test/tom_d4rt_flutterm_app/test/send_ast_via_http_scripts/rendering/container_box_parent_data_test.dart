// D4rt test script: Tests ContainerBoxParentData from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ContainerBoxParentData test executing');
  final results = <String>[];

  // ========== Section 1: Basic Construction ==========
  print('--- Section 1: Basic Construction ---');
  
  // ContainerBoxParentData combines BoxParentData with ContainerParentDataMixin
  final parentData = ContainerBoxParentData<RenderBox>();
  print('Created ContainerBoxParentData');
  print('Initial offset: ${parentData.offset}');
  results.add('Initial offset: ${parentData.offset}');
  
  // ========== Section 2: Offset Property ==========
  print('--- Section 2: Offset Property ---');
  
  // Set offset
  parentData.offset = Offset(100, 50);
  print('Set offset to: ${parentData.offset}');
  results.add('Set offset: ${parentData.offset}');
  
  // Modify offset
  parentData.offset = Offset(200, 150);
  print('Modified offset: ${parentData.offset}');
  results.add('Modified offset: ${parentData.offset}');
  
  // ========== Section 3: Previous/Next Sibling ==========
  print('--- Section 3: Previous/Next Sibling ---');
  
  // These are from ContainerParentDataMixin
  // Note: previousSibling and nextSibling are set by the container
  print('previousSibling: ${parentData.previousSibling}');
  print('nextSibling: ${parentData.nextSibling}');
  results.add('Siblings: prev=${parentData.previousSibling}, next=${parentData.nextSibling}');
  
  // ========== Section 4: Multiple Parent Data Instances ==========
  print('--- Section 4: Multiple Parent Data Instances ---');
  
  final data1 = ContainerBoxParentData<RenderBox>();
  final data2 = ContainerBoxParentData<RenderBox>();
  final data3 = ContainerBoxParentData<RenderBox>();
  
  data1.offset = Offset(0, 0);
  data2.offset = Offset(100, 0);
  data3.offset = Offset(200, 0);
  
  print('Data 1 offset: ${data1.offset}');
  print('Data 2 offset: ${data2.offset}');
  print('Data 3 offset: ${data3.offset}');
  results.add('Multiple: d1=${data1.offset}, d2=${data2.offset}, d3=${data3.offset}');
  
  // ========== Section 5: Zero Offset ==========
  print('--- Section 5: Zero Offset ---');
  
  final zeroData = ContainerBoxParentData<RenderBox>();
  zeroData.offset = Offset.zero;
  print('Zero offset: ${zeroData.offset}');
  print('Is zero: ${zeroData.offset == Offset.zero}');
  results.add('Zero offset: ${zeroData.offset == Offset.zero}');
  
  // ========== Section 6: Negative Offset ==========
  print('--- Section 6: Negative Offset ---');
  
  final negData = ContainerBoxParentData<RenderBox>();
  negData.offset = Offset(-50, -30);
  print('Negative offset: ${negData.offset}');
  print('dx: ${negData.offset.dx}, dy: ${negData.offset.dy}');
  results.add('Negative: dx=${negData.offset.dx}, dy=${negData.offset.dy}');
  
  // ========== Section 7: Large Offset ==========
  print('--- Section 7: Large Offset ---');
  
  final largeData = ContainerBoxParentData<RenderBox>();
  largeData.offset = Offset(10000, 5000);
  print('Large offset: ${largeData.offset}');
  results.add('Large offset: ${largeData.offset}');
  
  // ========== Section 8: Fractional Offset ==========
  print('--- Section 8: Fractional Offset ---');
  
  final fracData = ContainerBoxParentData<RenderBox>();
  fracData.offset = Offset(10.5, 20.75);
  print('Fractional offset: ${fracData.offset}');
  results.add('Fractional: ${fracData.offset}');
  
  // ========== Section 9: ToString ==========
  print('--- Section 9: ToString ---');
  
  final strData = ContainerBoxParentData<RenderBox>();
  strData.offset = Offset(42, 24);
  final str = strData.toString();
  print('ToString: $str');
  results.add('HasToString: ${str.isNotEmpty}');
  
  // ========== Section 10: Type Parameters ==========
  print('--- Section 10: Type Parameters ---');
  
  // ContainerBoxParentData is generic over ChildType
  // This demonstrates type safety
  final typedData = ContainerBoxParentData<RenderBox>();
  print('Created typed ContainerBoxParentData<RenderBox>');
  
  // Runtime type check
  print('Type check: ${typedData is BoxParentData}');
  print('Is ContainerBoxParentData: ${typedData is ContainerBoxParentData}');
  results.add('Type check: isBoxParentData=${typedData is BoxParentData}');

  print('ContainerBoxParentData test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('ContainerBoxParentData Tests',
               style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          ...results.map((r) => Padding(
            padding: EdgeInsets.symmetric(vertical: 2),
            child: Text('✓ $r', style: TextStyle(fontSize: 14)),
          )),
        ],
      ),
    ),
  );
}
