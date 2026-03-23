// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests SliverGridDelegateWithFixedCrossAxisCount, SliverGridDelegateWithMaxCrossAxisExtent, ColumnWidth classes
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Sliver delegates test executing');

  // ========== SLIVER GRID DELEGATE WITH FIXED CROSS AXIS COUNT ==========
  print('--- SliverGridDelegateWithFixedCrossAxisCount Tests ---');

  final fixedCount2 = SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
  );
  print('FixedCrossAxisCount(2) created: ${fixedCount2.runtimeType}');
  print('  crossAxisCount: ${fixedCount2.crossAxisCount}');
  print('  mainAxisSpacing: ${fixedCount2.mainAxisSpacing}');
  print('  crossAxisSpacing: ${fixedCount2.crossAxisSpacing}');
  print('  childAspectRatio: ${fixedCount2.childAspectRatio}');

  final fixedCount3Custom = SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 3,
    mainAxisSpacing: 8.0,
    crossAxisSpacing: 8.0,
    childAspectRatio: 1.5,
  );
  print('FixedCrossAxisCount(3, custom):');
  print('  crossAxisCount: ${fixedCount3Custom.crossAxisCount}');
  print('  mainAxisSpacing: ${fixedCount3Custom.mainAxisSpacing}');
  print('  crossAxisSpacing: ${fixedCount3Custom.crossAxisSpacing}');
  print('  childAspectRatio: ${fixedCount3Custom.childAspectRatio}');

  final fixedCount4WithExtent = SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 4,
    mainAxisSpacing: 4.0,
    crossAxisSpacing: 4.0,
    mainAxisExtent: 100.0,
  );
  print('FixedCrossAxisCount(4, mainAxisExtent=100):');
  print('  crossAxisCount: ${fixedCount4WithExtent.crossAxisCount}');
  print('  mainAxisExtent: ${fixedCount4WithExtent.mainAxisExtent}');

  // ========== SLIVER GRID DELEGATE WITH MAX CROSS AXIS EXTENT ==========
  print('--- SliverGridDelegateWithMaxCrossAxisExtent Tests ---');

  final maxExtent100 = SliverGridDelegateWithMaxCrossAxisExtent(
    maxCrossAxisExtent: 100.0,
  );
  print('MaxCrossAxisExtent(100) created: ${maxExtent100.runtimeType}');
  print('  maxCrossAxisExtent: ${maxExtent100.maxCrossAxisExtent}');
  print('  mainAxisSpacing: ${maxExtent100.mainAxisSpacing}');
  print('  crossAxisSpacing: ${maxExtent100.crossAxisSpacing}');
  print('  childAspectRatio: ${maxExtent100.childAspectRatio}');

  final maxExtentCustom = SliverGridDelegateWithMaxCrossAxisExtent(
    maxCrossAxisExtent: 200.0,
    mainAxisSpacing: 10.0,
    crossAxisSpacing: 10.0,
    childAspectRatio: 0.75,
  );
  print('MaxCrossAxisExtent(200, custom):');
  print('  maxCrossAxisExtent: ${maxExtentCustom.maxCrossAxisExtent}');
  print('  mainAxisSpacing: ${maxExtentCustom.mainAxisSpacing}');
  print('  crossAxisSpacing: ${maxExtentCustom.crossAxisSpacing}');
  print('  childAspectRatio: ${maxExtentCustom.childAspectRatio}');

  final maxExtentWithMainAxis = SliverGridDelegateWithMaxCrossAxisExtent(
    maxCrossAxisExtent: 150.0,
    mainAxisExtent: 80.0,
  );
  print('MaxCrossAxisExtent(150, mainAxisExtent=80):');
  print('  mainAxisExtent: ${maxExtentWithMainAxis.mainAxisExtent}');

  // ========== USING DELEGATES IN GRIDVIEW ==========
  print('--- GridView with delegates ---');

  final gridView1 = GridView(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
    children: [Text('A'), Text('B'), Text('C'), Text('D')],
  );
  print('GridView with FixedCrossAxisCount created: ${gridView1.runtimeType}');

  final gridView2 = GridView(
    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: 120.0,
    ),
    children: [Text('A'), Text('B'), Text('C')],
  );
  print('GridView with MaxCrossAxisExtent created: ${gridView2.runtimeType}');

  // ========== FIXED COLUMN WIDTH ==========
  print('--- FixedColumnWidth Tests ---');

  final fixedCol = FixedColumnWidth(100.0);
  print('FixedColumnWidth(100) created: ${fixedCol.runtimeType}');
  print('  value: ${fixedCol.value}');

  final fixedCol200 = FixedColumnWidth(200.0);
  print('FixedColumnWidth(200) value: ${fixedCol200.value}');

  // ========== FLEX COLUMN WIDTH ==========
  print('--- FlexColumnWidth Tests ---');

  final flexCol = FlexColumnWidth();
  print('FlexColumnWidth() created: ${flexCol.runtimeType}');
  print('  value: ${flexCol.value}');

  final flexCol2 = FlexColumnWidth(2.0);
  print('FlexColumnWidth(2.0) value: ${flexCol2.value}');

  final flexCol3 = FlexColumnWidth(3.0);
  print('FlexColumnWidth(3.0) value: ${flexCol3.value}');

  // ========== INTRINSIC COLUMN WIDTH ==========
  print('--- IntrinsicColumnWidth Tests ---');

  final intrinsicCol = IntrinsicColumnWidth();
  print('IntrinsicColumnWidth() created: ${intrinsicCol.runtimeType}');

  final intrinsicColFlex = IntrinsicColumnWidth(flex: 1.0);
  print('IntrinsicColumnWidth(flex=1) created [${intrinsicColFlex.hashCode}]');

  // ========== TABLE WITH COLUMN WIDTHS ==========
  print('--- Table with column widths ---');

  final table = Table(
    columnWidths: {
      0: FixedColumnWidth(80.0),
      1: FlexColumnWidth(2.0),
      2: IntrinsicColumnWidth(),
    },
    defaultColumnWidth: FlexColumnWidth(),
    children: [
      TableRow(children: [Text('Col1'), Text('Col2'), Text('Col3')]),
      TableRow(children: [Text('A'), Text('B'), Text('C')]),
    ],
  );
  print('Table with mixed column widths created: ${table.runtimeType}');

  // ========== MAX COLUMN WIDTH / MIN COLUMN WIDTH ==========
  print('--- MaxColumnWidth / MinColumnWidth ---');

  final maxCol = MaxColumnWidth(FixedColumnWidth(100.0), FlexColumnWidth(1.0));
  print('MaxColumnWidth created: ${maxCol.runtimeType}');

  final minCol = MinColumnWidth(FixedColumnWidth(200.0), FlexColumnWidth(1.0));
  print('MinColumnWidth created: ${minCol.runtimeType}');

  // ========== FRACTION COLUMN WIDTH ==========
  print('--- FractionColumnWidth Tests ---');

  final fractionCol = FractionColumnWidth(0.5);
  print('FractionColumnWidth(0.5) created: ${fractionCol.runtimeType}');
  print('  value: ${fractionCol.value}');

  final fractionCol25 = FractionColumnWidth(0.25);
  print('FractionColumnWidth(0.25) value: ${fractionCol25.value}');

  print('Sliver delegates test completed');
  return Text('Sliver delegates test passed');
}
