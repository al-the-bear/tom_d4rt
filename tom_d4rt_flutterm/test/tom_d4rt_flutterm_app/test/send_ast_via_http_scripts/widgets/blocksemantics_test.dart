// D4rt test script: Tests BlockSemantics and IndexedSemantics from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('BlockSemantics test executing');

  // Test BlockSemantics with blocking=true (default)
  final block1 = BlockSemantics(
    child: Container(
      width: 150.0,
      height: 60.0,
      color: Colors.blue,
      child: Center(
        child: Text('Blocked', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('BlockSemantics(blocking: true) created');

  // Test BlockSemantics with blocking=false
  final block2 = BlockSemantics(
    blocking: false,
    child: Container(
      width: 150.0,
      height: 60.0,
      color: Colors.green,
      child: Center(
        child: Text('Not blocked', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('BlockSemantics(blocking: false) created');

  // Test BlockSemantics wrapping interactive content
  final block3 = BlockSemantics(
    child: ElevatedButton(
      child: Text('Semantically Blocked Button'),
      onPressed: () => print('Blocked button pressed'),
    ),
  );
  print('BlockSemantics wrapping ElevatedButton created');

  // Test IndexedSemantics with various indices
  final indexed1 = IndexedSemantics(
    index: 0,
    child: Container(
      width: 150.0,
      height: 50.0,
      color: Colors.orange,
      child: Center(child: Text('Index 0')),
    ),
  );
  print('IndexedSemantics(index: 0) created');

  final indexed2 = IndexedSemantics(
    index: 1,
    child: Container(
      width: 150.0,
      height: 50.0,
      color: Colors.purple,
      child: Center(
        child: Text('Index 1', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('IndexedSemantics(index: 1) created');

  final indexed3 = IndexedSemantics(
    index: 5,
    child: Container(
      width: 150.0,
      height: 50.0,
      color: Colors.teal,
      child: Center(
        child: Text('Index 5', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('IndexedSemantics(index: 5) created');

  // Test IndexedSemantics in a list-like context
  final indexedList = Column(
    mainAxisSize: MainAxisSize.min,
    children: List.generate(4, (index) {
      return IndexedSemantics(
        index: index,
        child: Container(
          width: 200.0,
          height: 40.0,
          margin: EdgeInsets.symmetric(vertical: 2.0),
          color: Colors.primaries[index % Colors.primaries.length],
          child: Center(
            child: Text(
              'List item $index',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      );
    }),
  );
  print('IndexedSemantics list with 4 items created');

  // Test combination: BlockSemantics containing IndexedSemantics
  final combined = BlockSemantics(
    child: IndexedSemantics(
      index: 10,
      child: Container(
        width: 180.0,
        height: 50.0,
        color: Colors.indigo,
        child: Center(
          child: Text('Block+Index=10', style: TextStyle(color: Colors.white)),
        ),
      ),
    ),
  );
  print('BlockSemantics containing IndexedSemantics(index: 10) created');

  print('BlockSemantics test completed');
  return SingleChildScrollView(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('BlockSemantics / IndexedSemantics Tests'),
        SizedBox(height: 8.0),
        block1,
        block2,
        block3,
        SizedBox(height: 8.0),
        indexed1,
        indexed2,
        indexed3,
        SizedBox(height: 8.0),
        indexedList,
        SizedBox(height: 8.0),
        combined,
      ],
    ),
  );
}
