// D4rt test script: Tests FractionColumnWidth from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('FractionColumnWidth test executing');

  // ========== Basic FractionColumnWidth creation ==========
  print('--- Basic FractionColumnWidth ---');
  final width1 = FractionColumnWidth(0.5);
  print('  created: ${width1.runtimeType}');
  print('  value (fraction): 0.5');

  // ========== Different fraction values ==========
  print('--- Different fraction values ---');
  final width10 = FractionColumnWidth(0.1);
  print('  FractionColumnWidth(0.1): ${width10.runtimeType}');
  
  final width25 = FractionColumnWidth(0.25);
  print('  FractionColumnWidth(0.25): ${width25.runtimeType}');
  
  final width33 = FractionColumnWidth(0.333);
  print('  FractionColumnWidth(0.333): ${width33.runtimeType}');
  
  final width75 = FractionColumnWidth(0.75);
  print('  FractionColumnWidth(0.75): ${width75.runtimeType}');
  
  final width100 = FractionColumnWidth(1.0);
  print('  FractionColumnWidth(1.0): ${width100.runtimeType}');

  // ========== TableColumnWidth interface ==========
  print('--- TableColumnWidth interface ---');
  print('  width1 is TableColumnWidth: ${width1 is TableColumnWidth}');
  print('  minIntrinsicWidth: depends on table constraints');
  print('  maxIntrinsicWidth: depends on table constraints');

  // ========== Comparing FractionColumnWidth instances ==========
  print('--- Comparing instances ---');
  final widthA = FractionColumnWidth(0.5);
  final widthB = FractionColumnWidth(0.5);
  final widthC = FractionColumnWidth(0.3);
  print('  widthA == widthB (same fraction): ${widthA == widthB}');
  print('  widthA == widthC (different fraction): ${widthA == widthC}');

  // ========== toString representation ==========
  print('--- toString representation ---');
  print('  width1.toString(): ${width1.toString()}');
  print('  width10.toString(): ${width10.toString()}');
  print('  width100.toString(): ${width100.toString()}');

  // ========== Using in Table widget ==========
  print('--- Use in Table widget ---');
  final tableColumnWidths = {
    0: FractionColumnWidth(0.3),
    1: FractionColumnWidth(0.5),
    2: FractionColumnWidth(0.2),
  };
  print('  column 0: FractionColumnWidth(0.3)');
  print('  column 1: FractionColumnWidth(0.5)');
  print('  column 2: FractionColumnWidth(0.2)');
  print('  total fraction: 1.0 (30% + 50% + 20%)');

  // ========== Edge cases ==========
  print('--- Edge cases ---');
  final widthZero = FractionColumnWidth(0.0);
  print('  FractionColumnWidth(0.0): ${widthZero.runtimeType}');
  
  final widthSmall = FractionColumnWidth(0.01);
  print('  FractionColumnWidth(0.01): ${widthSmall.runtimeType}');

  print('FractionColumnWidth test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('FractionColumnWidth Tests',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          SizedBox(height: 8.0),
          Text('Basic FractionColumnWidth: ${width1.runtimeType}'),
          Text('Fraction 0.5 for 50% width'),
          SizedBox(height: 8.0),
          Table(
            columnWidths: {
              0: FractionColumnWidth(0.3),
              1: FractionColumnWidth(0.4),
              2: FractionColumnWidth(0.3),
            },
            border: TableBorder.all(color: Color(0xFF9E9E9E)),
            children: [
              TableRow(children: [
                Padding(padding: EdgeInsets.all(8.0), child: Text('30%')),
                Padding(padding: EdgeInsets.all(8.0), child: Text('40%')),
                Padding(padding: EdgeInsets.all(8.0), child: Text('30%')),
              ]),
              TableRow(children: [
                Padding(padding: EdgeInsets.all(8.0), child: Text('Col A')),
                Padding(padding: EdgeInsets.all(8.0), child: Text('Col B')),
                Padding(padding: EdgeInsets.all(8.0), child: Text('Col C')),
              ]),
            ],
          ),
        ],
      ),
    ),
  );
}
