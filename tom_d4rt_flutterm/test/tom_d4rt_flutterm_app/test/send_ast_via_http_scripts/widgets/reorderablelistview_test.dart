// D4rt test script: Tests ReorderableListView from Flutter material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ReorderableListView test executing');

  // Variation 1: Basic ReorderableListView with ListTiles
  final widget1 = ReorderableListView(
    onReorder: (old, newIdx) {
      print('reorder $old -> $newIdx');
    },
    children: [
      ListTile(key: ValueKey(0), title: Text('Item 0')),
      ListTile(key: ValueKey(1), title: Text('Item 1')),
      ListTile(key: ValueKey(2), title: Text('Item 2')),
    ],
  );
  print('ReorderableListView(basic 3 items) created');

  // Variation 2: ReorderableListView with padding
  final widget2 = ReorderableListView(
    padding: EdgeInsets.all(16),
    onReorder: (old, newIdx) {
      print('reorder with padding $old -> $newIdx');
    },
    children: [
      ListTile(
        key: ValueKey(10),
        title: Text('Padded 0'),
        leading: Icon(Icons.drag_handle),
      ),
      ListTile(
        key: ValueKey(11),
        title: Text('Padded 1'),
        leading: Icon(Icons.drag_handle),
      ),
      ListTile(
        key: ValueKey(12),
        title: Text('Padded 2'),
        leading: Icon(Icons.drag_handle),
      ),
      ListTile(
        key: ValueKey(13),
        title: Text('Padded 3'),
        leading: Icon(Icons.drag_handle),
      ),
    ],
  );
  print('ReorderableListView(with padding) created');

  // Variation 3: ReorderableListView.builder
  final widget3 = ReorderableListView.builder(
    onReorder: (old, newIdx) {
      print('builder reorder $old -> $newIdx');
    },
    itemCount: 5,
    itemBuilder: (context, index) => ListTile(
      key: ValueKey(index),
      title: Text('Builder Item $index'),
      subtitle: Text('Subtitle $index'),
    ),
  );
  print('ReorderableListView.builder(itemCount: 5) created');

  // Variation 4: ReorderableListView with header and custom children
  final widget4 = ReorderableListView(
    header: Container(
      padding: EdgeInsets.all(16),
      color: Colors.blue.shade100,
      child: Text('Reorderable List Header'),
    ),
    onReorder: (old, newIdx) {
      print('header list reorder $old -> $newIdx');
    },
    children: [
      Card(
        key: ValueKey(20),
        child: ListTile(title: Text('Card Item 0')),
      ),
      Card(
        key: ValueKey(21),
        child: ListTile(title: Text('Card Item 1')),
      ),
      Card(
        key: ValueKey(22),
        child: ListTile(title: Text('Card Item 2')),
      ),
    ],
  );
  print('ReorderableListView(with header) created');

  print('ReorderableListView test completed');
  return Column(
    children: [
      Expanded(child: widget1),
      Expanded(child: widget2),
      Expanded(child: widget3),
      Expanded(child: widget4),
    ],
  );
}
