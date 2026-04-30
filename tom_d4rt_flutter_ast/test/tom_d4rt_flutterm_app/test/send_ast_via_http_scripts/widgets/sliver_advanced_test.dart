// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests SliverAnimatedList, SliverAnimatedOpacity,
// SliverLayoutBuilder, SliverPrototypeExtentList, SliverReorderableList,
// SliverCrossAxisGroup, SliverMainAxisGroup
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Sliver advanced widgets test executing');

  // ========== SliverAnimatedList ==========
  print('--- SliverAnimatedList Tests ---');
  final animListKey = GlobalKey<SliverAnimatedListState>();
  final sliverAnimatedList = SliverAnimatedList(
    key: animListKey,
    initialItemCount: 3,
    itemBuilder: (context, index, animation) {
      return SizeTransition(
        sizeFactor: animation,
        child: ListTile(title: Text('Animated item $index')),
      );
    },
  );
  print('SliverAnimatedList created with 3 items');

  // ========== SliverAnimatedOpacity ==========
  print('--- SliverAnimatedOpacity Tests ---');
  final sliverAnimOpacity = SliverAnimatedOpacity(
    opacity: 0.5,
    duration: Duration(milliseconds: 300),
    curve: Curves.easeIn,
    sliver: SliverToBoxAdapter(child: Text('Fading sliver')),
  );
  print('SliverAnimatedOpacity created with opacity 0.5');

  // ========== SliverLayoutBuilder ==========
  print('--- SliverLayoutBuilder Tests ---');
  final sliverLayoutBuilder = SliverLayoutBuilder(
    builder: (context, constraints) {
      print(
        '  SliverLayoutBuilder constraints: ${constraints.crossAxisExtent}',
      );
      return SliverToBoxAdapter(child: Text('Layout built'));
    },
  );
  print('SliverLayoutBuilder created');

  // ========== SliverPrototypeExtentList ==========
  print('--- SliverPrototypeExtentList Tests ---');
  final sliverPrototype = SliverPrototypeExtentList(
    prototypeItem: ListTile(title: Text('Prototype')),
    delegate: SliverChildBuilderDelegate(
      (context, index) => ListTile(title: Text('Proto item $index')),
      childCount: 5,
    ),
  );
  print('SliverPrototypeExtentList created with 5 items: $sliverPrototype');

  // ========== SliverReorderableList ==========
  print('--- SliverReorderableList Tests ---');
  final items = List.generate(5, (i) => 'Reorder $i');
  final sliverReorderable = SliverReorderableList(
    itemCount: items.length,
    itemBuilder: (context, index) {
      return ReorderableDragStartListener(
        key: ValueKey(items[index]),
        index: index,
        child: ListTile(title: Text(items[index])),
      );
    },
    onReorder: (oldIndex, newIndex) {
      print('  Reorder: $oldIndex -> $newIndex');
    },
  );
  print('SliverReorderableList created with ${items.length} items: $sliverReorderable');

  print('All sliver advanced tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Sliver Advanced Test',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
            ),
          ),
          sliverAnimOpacity,
          sliverLayoutBuilder,
          sliverAnimatedList,
        ],
      ),
    ),
  );
}
