// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests Table, TableRow, TableCell, TableBorder,
// Wrap, Flow, FlowDelegate
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Table/Wrap/Flow test executing');

  // ========== TableBorder ==========
  print('--- TableBorder Tests ---');
  final tableBorder = TableBorder(
    top: BorderSide(color: Colors.black, width: 1.0),
    right: BorderSide(color: Colors.black, width: 1.0),
    bottom: BorderSide(color: Colors.black, width: 1.0),
    left: BorderSide(color: Colors.black, width: 1.0),
    horizontalInside: BorderSide(color: Colors.grey, width: 0.5),
    verticalInside: BorderSide(color: Colors.grey, width: 0.5),
  );
  print('TableBorder created');
  print('  isUniform: ${tableBorder.isUniform}');

  final tableBorderAll = TableBorder.all(color: Colors.red, width: 2.0);
  print('TableBorder.all created: isUniform=${tableBorderAll.isUniform}');

  final symmetricBorder = TableBorder.symmetric(
    inside: BorderSide(color: Colors.blue),
    outside: BorderSide(color: Colors.green, width: 2.0),
  );
  print('TableBorder.symmetric created: $symmetricBorder');

  // ========== TableRow ==========
  print('--- TableRow Tests ---');
  final tableRow = TableRow(
    decoration: BoxDecoration(color: Colors.grey[200]),
    children: [Text('Cell 1'), Text('Cell 2'), Text('Cell 3')],
  );
  print('TableRow created with ${tableRow.children.length} cells');

  // ========== TableCell ==========
  print('--- TableCell Tests ---');
  final tableCell = TableCell(
    verticalAlignment: TableCellVerticalAlignment.middle,
    child: Text('Centered cell'),
  );
  print('TableCell created');
  print('  verticalAlignment: ${tableCell.verticalAlignment}');

  // TableCellVerticalAlignment values
  for (final align in TableCellVerticalAlignment.values) {
    print('  TableCellVerticalAlignment: $align');
  }

  // ========== Table ==========
  print('--- Table Tests ---');
  final table = Table(
    border: tableBorderAll,
    defaultColumnWidth: FlexColumnWidth(),
    columnWidths: {
      0: FixedColumnWidth(100),
      1: FlexColumnWidth(2),
      2: IntrinsicColumnWidth(),
    },
    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
    children: [
      tableRow,
      TableRow(children: [Text('A'), Text('B'), Text('C')]),
    ],
  );
  print('Table created');

  // Column width types
  print('FixedColumnWidth: ${FixedColumnWidth(50)}');
  print('FlexColumnWidth: ${FlexColumnWidth(1.0)}');
  print('IntrinsicColumnWidth: ${IntrinsicColumnWidth()}');
  print('FractionColumnWidth: ${FractionColumnWidth(0.3)}');
  print(
    'MaxColumnWidth: ${MaxColumnWidth(FixedColumnWidth(50), FlexColumnWidth())}',
  );
  print(
    'MinColumnWidth: ${MinColumnWidth(FixedColumnWidth(50), FlexColumnWidth())}',
  );

  // ========== Wrap ==========
  print('--- Wrap Tests ---');
  final wrap = Wrap(
    spacing: 8.0,
    runSpacing: 4.0,
    alignment: WrapAlignment.start,
    runAlignment: WrapAlignment.center,
    crossAxisAlignment: WrapCrossAlignment.center,
    direction: Axis.horizontal,
    verticalDirection: VerticalDirection.down,
    children: [
      Chip(label: Text('A')),
      Chip(label: Text('B')),
      Chip(label: Text('C')),
    ],
  );
  print('Wrap created: spacing=${wrap.spacing}, runSpacing=${wrap.runSpacing}');

  for (final val in WrapAlignment.values) {
    print('  WrapAlignment: $val');
  }
  for (final val in WrapCrossAlignment.values) {
    print('  WrapCrossAlignment: $val');
  }

  // ========== Flow ==========
  print('--- Flow Tests ---');
  final flow = Flow(
    delegate: TestFlowDelegate(),
    children: [
      Container(width: 50, height: 50, color: Colors.red),
      Container(width: 50, height: 50, color: Colors.blue),
      Container(width: 50, height: 50, color: Colors.green),
    ],
  );
  print('Flow created with TestFlowDelegate');

  print('All table/wrap/flow tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            table,
            SizedBox(height: 16),
            wrap,
            SizedBox(height: 16),
            SizedBox(height: 100, child: flow),
          ],
        ),
      ),
    ),
  );
}

class TestFlowDelegate extends FlowDelegate {
  @override
  void paintChildren(FlowPaintingContext context) {
    double dx = 0;
    for (int i = 0; i < context.childCount; i++) {
      context.paintChild(i, transform: Matrix4.translationValues(dx, 0, 0));
      dx += 60;
    }
  }

  @override
  bool shouldRepaint(TestFlowDelegate oldDelegate) => false;

  @override
  Size getSize(BoxConstraints constraints) => Size(300, 50);
}
