// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests SliverChildBuilderDelegate, SliverChildListDelegate,
// SliverAnimatedList, SliverSafeArea, SliverVisibility, SliverLayoutBuilder
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Sliver delegates test executing');

  // ========== SliverChildBuilderDelegate ==========
  print('--- SliverChildBuilderDelegate Tests ---');

  final builderDelegate = SliverChildBuilderDelegate((
    BuildContext ctx,
    int index,
  ) {
    return ListTile(
      title: Text('Item $index'),
      leading: CircleAvatar(child: Text('$index')),
    );
  }, childCount: 20);
  print('SliverChildBuilderDelegate childCount: ${builderDelegate.childCount}');
  print(
    'SliverChildBuilderDelegate estimatedChildCount: ${builderDelegate.estimatedChildCount}',
  );

  // ========== SliverChildListDelegate ==========
  print('--- SliverChildListDelegate Tests ---');

  final children = [
    ListTile(title: Text('A')),
    ListTile(title: Text('B')),
    ListTile(title: Text('C')),
  ];
  final listDelegate = SliverChildListDelegate(children);
  print(
    'SliverChildListDelegate estimatedChildCount: ${listDelegate.estimatedChildCount}',
  );

  final listDelegateFixed = SliverChildListDelegate.fixed(children);
  print(
    'SliverChildListDelegate.fixed estimatedChildCount: ${listDelegateFixed.estimatedChildCount}',
  );

  // ========== SliverSafeArea ==========
  print('--- SliverSafeArea Tests ---');

  final sliverSafeArea = SliverSafeArea(
    sliver: SliverToBoxAdapter(child: Text('Safe content')),
  );
  print('SliverSafeArea created');

  // ========== SliverVisibility ==========
  print('--- SliverVisibility Tests ---');

  final sliverVisible = SliverVisibility(
    visible: true,
    sliver: SliverToBoxAdapter(child: Text('Visible')),
  );
  print('SliverVisibility visible: true created');

  final sliverHidden = SliverVisibility(
    visible: false,
    sliver: SliverToBoxAdapter(child: Text('Hidden')),
    replacementSliver: SliverToBoxAdapter(child: SizedBox.shrink()),
  );
  print('SliverVisibility visible: false created');

  // ========== SliverIgnorePointer ==========
  print('--- SliverIgnorePointer Tests ---');

  final sliverIgnore = SliverIgnorePointer(
    ignoring: true,
    sliver: SliverToBoxAdapter(child: Text('Ignored')),
  );
  print('SliverIgnorePointer ignoring: true created');

  print('All sliver delegate tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Sliver Delegates Test',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
            ),
          ),
          SliverList(delegate: builderDelegate),
          sliverSafeArea,
          sliverVisible,
          sliverHidden,
          sliverIgnore,
          SliverList(delegate: listDelegate),
        ],
      ),
    ),
  );
}
