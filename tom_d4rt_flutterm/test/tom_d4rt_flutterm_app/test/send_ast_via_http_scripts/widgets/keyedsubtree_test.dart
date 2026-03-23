// ignore_for_file: avoid_print
// D4rt test script: Tests KeyedSubtree, AnnotatedRegion from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('KeyedSubtree test executing');

  // ========== KEYEDSUBTREE ==========
  print('--- KeyedSubtree Tests ---');

  // KeyedSubtree assigns a key to a subtree without adding widget overhead
  final keyed1 = KeyedSubtree(
    key: ValueKey('item-1'),
    child: Container(
      color: Colors.blue,
      width: 100.0,
      height: 50.0,
      child: Center(
        child: Text('Keyed 1', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('KeyedSubtree with ValueKey("item-1") created');
  print('  key: ${keyed1.key}');

  // KeyedSubtree with UniqueKey
  final keyed2 = KeyedSubtree(
    key: UniqueKey(),
    child: Container(
      color: Colors.green,
      width: 100.0,
      height: 50.0,
      child: Center(
        child: Text('Keyed 2', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('KeyedSubtree with UniqueKey created');
  print('  key: ${keyed2.key}');

  // KeyedSubtree without key
  final keyedNoKey = KeyedSubtree(
    child: Container(
      color: Colors.orange,
      width: 100.0,
      height: 50.0,
      child: Center(
        child: Text('No key', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('KeyedSubtree without key created');
  print('  key: ${keyedNoKey.key}');

  // KeyedSubtree.wrap - creates a list of keyed subtrees
  final widgets = [
    Container(color: Colors.red, width: 80.0, height: 30.0),
    Container(color: Colors.blue, width: 80.0, height: 30.0),
    Container(color: Colors.green, width: 80.0, height: 30.0),
  ];
  final wrappedList = KeyedSubtree.ensureUniqueKeysForList(widgets);
  print(
    'KeyedSubtree.ensureUniqueKeysForList created ${wrappedList.length} items',
  );
  for (var i = 0; i < wrappedList.length; i++) {
    print('  wrapped[$i] key: ${wrappedList[i].key}');
  }

  // ========== ANNOTATEDREGION ==========
  print('--- AnnotatedRegion Tests ---');

  // AnnotatedRegion is used to annotate a region of the layer tree
  // Commonly used with SystemUiOverlayStyle
  final annotated = AnnotatedRegion<int>(
    value: 42,
    child: Container(
      color: Colors.purple,
      width: 100.0,
      height: 50.0,
      child: Center(
        child: Text('Annotated', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('AnnotatedRegion<int>(42) created');
  print('  value: ${annotated.value}');
  print('  sized: ${annotated.sized}');

  // AnnotatedRegion with sized=false
  final annotatedUnsized = AnnotatedRegion<String>(
    value: 'test-annotation',
    sized: false,
    child: Container(
      color: Colors.teal,
      width: 100.0,
      height: 50.0,
      child: Center(
        child: Text('Unsized', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('AnnotatedRegion with sized=false created');
  print('  value: ${annotatedUnsized.value}');
  print('  sized: ${annotatedUnsized.sized}');

  print('All KeyedSubtree tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'KeyedSubtree / AnnotatedRegion Test',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            keyed1,
            SizedBox(height: 4.0),
            keyed2,
            SizedBox(height: 4.0),
            ...wrappedList,
            SizedBox(height: 8.0),
            annotated,
            SizedBox(height: 4.0),
            annotatedUnsized,
          ],
        ),
      ),
    ),
  );
}
