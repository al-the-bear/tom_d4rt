// D4rt test script: Tests MinColumnWidth from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('MinColumnWidth test executing');

  // ========== Basic MinColumnWidth creation ==========
  print('--- Basic MinColumnWidth ---');
  final width1 = MinColumnWidth(
    FixedColumnWidth(100.0),
    FractionColumnWidth(0.5),
  );
  print('  created: ${width1.runtimeType}');
  print('  combines FixedColumnWidth(100) and FractionColumnWidth(0.5)');

  // ========== Different column width combinations ==========
  print('--- Different combinations ---');
  
  final width2 = MinColumnWidth(
    FixedColumnWidth(50.0),
    FixedColumnWidth(100.0),
  );
  print('  MinColumnWidth(Fixed(50), Fixed(100))');
  print('    type: ${width2.runtimeType}');
  
  final width3 = MinColumnWidth(
    FractionColumnWidth(0.3),
    FractionColumnWidth(0.5),
  );
  print('  MinColumnWidth(Fraction(0.3), Fraction(0.5))');
  print('    type: ${width3.runtimeType}');
  
  final width4 = MinColumnWidth(
    IntrinsicColumnWidth(),
    FixedColumnWidth(150.0),
  );
  print('  MinColumnWidth(Intrinsic, Fixed(150))');
  print('    type: ${width4.runtimeType}');

  // ========== Nested MinColumnWidth ==========
  print('--- Nested MinColumnWidth ---');
  final nested = MinColumnWidth(
    MinColumnWidth(
      FixedColumnWidth(50.0),
      FixedColumnWidth(100.0),
    ),
    FractionColumnWidth(0.25),
  );
  print('  nested MinColumnWidth: ${nested.runtimeType}');

  // ========== With FlexColumnWidth ==========
  print('--- With FlexColumnWidth ---');
  final flex1 = MinColumnWidth(
    FlexColumnWidth(1.0),
    FixedColumnWidth(80.0),
  );
  print('  MinColumnWidth(Flex(1.0), Fixed(80))');
  print('    type: ${flex1.runtimeType}');
  
  final flex2 = MinColumnWidth(
    FlexColumnWidth(2.0),
    FlexColumnWidth(1.0),
  );
  print('  MinColumnWidth(Flex(2.0), Flex(1.0))');
  print('    type: ${flex2.runtimeType}');

  // ========== TableColumnWidth interface ==========
  print('--- TableColumnWidth interface ---');
  print('  is TableColumnWidth: ${width1 is TableColumnWidth}');
  print('  is TableColumnWidth: ${width2 is TableColumnWidth}');

  // ========== toString representation ==========
  print('--- toString ---');
  print('  width1.toString(): ${width1.toString()}');
  print('  width2.toString(): ${width2.toString()}');

  // ========== Compare with MaxColumnWidth ==========
  print('--- Compare with MaxColumnWidth ---');
  final minWidth = MinColumnWidth(
    FixedColumnWidth(100.0),
    FixedColumnWidth(200.0),
  );
  final maxWidth = MaxColumnWidth(
    FixedColumnWidth(100.0),
    FixedColumnWidth(200.0),
  );
  print('  MinColumnWidth: ${minWidth.runtimeType}');
  print('  MaxColumnWidth: ${maxWidth.runtimeType}');
  print('  Min picks smaller, Max picks larger');

  // ========== RuntimeType checks ==========
  print('--- RuntimeType checks ---');
  print('  width1.runtimeType: ${width1.runtimeType}');
  print('  width2.runtimeType: ${width2.runtimeType}');
  print('  nested.runtimeType: ${nested.runtimeType}');

  print('MinColumnWidth test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('MinColumnWidth Tests',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          SizedBox(height: 8.0),
          Text('Type: ${width1.runtimeType}'),
          Text('Purpose: Returns minimum of two column widths'),
          SizedBox(height: 8.0),
          Text('Combination examples:'),
          Table(
            columnWidths: {
              0: MinColumnWidth(
                FixedColumnWidth(80.0),
                FractionColumnWidth(0.4),
              ),
              1: MinColumnWidth(
                FixedColumnWidth(120.0),
                FractionColumnWidth(0.6),
              ),
            },
            border: TableBorder.all(color: Color(0xFF9E9E9E)),
            children: [
              TableRow(children: [
                Padding(padding: EdgeInsets.all(8.0), 
                  child: Text('Min(80, 40%)')),
                Padding(padding: EdgeInsets.all(8.0), 
                  child: Text('Min(120, 60%)')),
              ]),
              TableRow(children: [
                Padding(padding: EdgeInsets.all(8.0), 
                  child: Text('Column A')),
                Padding(padding: EdgeInsets.all(8.0), 
                  child: Text('Column B')),
              ]),
            ],
          ),
          SizedBox(height: 8.0),
          Text('Nested: ${nested.runtimeType}'),
          Text('Compare: MinColumnWidth vs MaxColumnWidth'),
        ],
      ),
    ),
  );
}
