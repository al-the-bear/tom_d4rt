// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests Table from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Table test executing');

  // Test basic Table with TableRow children
  final tableBasic = Table(
    children: [
      TableRow(children: [Text('A1'), Text('B1'), Text('C1')]),
      TableRow(children: [Text('A2'), Text('B2'), Text('C2')]),
      TableRow(children: [Text('A3'), Text('B3'), Text('C3')]),
    ],
  );
  print('Basic Table with 3x3 cells created');

  // Test Table with border
  final tableBorder = Table(
    border: TableBorder.all(color: Colors.black, width: 1.0),
    children: [
      TableRow(
        children: [
          Padding(padding: EdgeInsets.all(8.0), child: Text('Name')),
          Padding(padding: EdgeInsets.all(8.0), child: Text('Age')),
          Padding(padding: EdgeInsets.all(8.0), child: Text('City')),
        ],
      ),
      TableRow(
        children: [
          Padding(padding: EdgeInsets.all(8.0), child: Text('Alice')),
          Padding(padding: EdgeInsets.all(8.0), child: Text('30')),
          Padding(padding: EdgeInsets.all(8.0), child: Text('NYC')),
        ],
      ),
      TableRow(
        children: [
          Padding(padding: EdgeInsets.all(8.0), child: Text('Bob')),
          Padding(padding: EdgeInsets.all(8.0), child: Text('25')),
          Padding(padding: EdgeInsets.all(8.0), child: Text('LA')),
        ],
      ),
    ],
  );
  print('Table with border created');

  // Test Table with columnWidths
  final tableColumnWidths = Table(
    border: TableBorder.all(color: Colors.grey, width: 1.0),
    columnWidths: {
      0: FlexColumnWidth(2.0),
      1: FlexColumnWidth(1.0),
      2: FixedColumnWidth(80.0),
    },
    children: [
      TableRow(
        children: [
          Padding(padding: EdgeInsets.all(8.0), child: Text('Wide column')),
          Padding(padding: EdgeInsets.all(8.0), child: Text('Normal')),
          Padding(padding: EdgeInsets.all(8.0), child: Text('Fixed')),
        ],
      ),
      TableRow(
        children: [
          Padding(padding: EdgeInsets.all(8.0), child: Text('Flex 2.0')),
          Padding(padding: EdgeInsets.all(8.0), child: Text('Flex 1.0')),
          Padding(padding: EdgeInsets.all(8.0), child: Text('80px')),
        ],
      ),
    ],
  );
  print('Table with columnWidths created');

  // Test Table with defaultVerticalAlignment
  final tableVerticalAlign = Table(
    border: TableBorder.all(color: Colors.blue, width: 1.0),
    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
    children: [
      TableRow(
        children: [
          Container(
            height: 60.0,
            padding: EdgeInsets.all(4.0),
            child: Text('Tall cell'),
          ),
          Padding(padding: EdgeInsets.all(4.0), child: Text('Middle aligned')),
          Padding(padding: EdgeInsets.all(4.0), child: Text('Also middle')),
        ],
      ),
      TableRow(
        children: [
          Padding(padding: EdgeInsets.all(4.0), child: Text('Row 2')),
          Padding(padding: EdgeInsets.all(4.0), child: Text('Data')),
          Padding(padding: EdgeInsets.all(4.0), child: Text('More')),
        ],
      ),
    ],
  );
  print('Table with defaultVerticalAlignment=middle created');

  // Test Table with row decorations
  final tableDecorated = Table(
    border: TableBorder.all(color: Colors.black54, width: 1.0),
    children: [
      TableRow(
        decoration: BoxDecoration(color: Colors.blue),
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Header 1',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Header 2',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      TableRow(
        decoration: BoxDecoration(color: Colors.grey),
        children: [
          Padding(padding: EdgeInsets.all(8.0), child: Text('Data 1')),
          Padding(padding: EdgeInsets.all(8.0), child: Text('Data 2')),
        ],
      ),
      TableRow(
        decoration: BoxDecoration(color: Colors.white),
        children: [
          Padding(padding: EdgeInsets.all(8.0), child: Text('Data 3')),
          Padding(padding: EdgeInsets.all(8.0), child: Text('Data 4')),
        ],
      ),
    ],
  );
  print('Table with row decorations created');

  // Test Table with IntrinsicColumnWidth
  final tableIntrinsic = Table(
    border: TableBorder.all(color: Colors.green, width: 1.0),
    columnWidths: {0: IntrinsicColumnWidth(), 1: FlexColumnWidth(1.0)},
    children: [
      TableRow(
        children: [
          Padding(padding: EdgeInsets.all(8.0), child: Text('Short')),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Flexible column fills remaining space'),
          ),
        ],
      ),
      TableRow(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Longer label here'),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Adapts to content'),
          ),
        ],
      ),
    ],
  );
  print('Table with IntrinsicColumnWidth created');

  // Test Table with symmetric border
  final tableSymmetricBorder = Table(
    border: TableBorder.symmetric(
      inside: BorderSide(color: Colors.grey, width: 1.0),
      outside: BorderSide(color: Colors.black, width: 2.0),
    ),
    children: [
      TableRow(
        children: [
          Padding(padding: EdgeInsets.all(8.0), child: Text('Cell 1')),
          Padding(padding: EdgeInsets.all(8.0), child: Text('Cell 2')),
          Padding(padding: EdgeInsets.all(8.0), child: Text('Cell 3')),
        ],
      ),
      TableRow(
        children: [
          Padding(padding: EdgeInsets.all(8.0), child: Text('Cell 4')),
          Padding(padding: EdgeInsets.all(8.0), child: Text('Cell 5')),
          Padding(padding: EdgeInsets.all(8.0), child: Text('Cell 6')),
        ],
      ),
    ],
  );
  print('Table with symmetric border created');

  // Test Table with defaultColumnWidth
  final tableDefaultCol = Table(
    border: TableBorder.all(color: Colors.purple, width: 1.0),
    defaultColumnWidth: FlexColumnWidth(1.0),
    children: [
      TableRow(
        children: [
          Padding(padding: EdgeInsets.all(8.0), child: Text('Equal')),
          Padding(padding: EdgeInsets.all(8.0), child: Text('Width')),
          Padding(padding: EdgeInsets.all(8.0), child: Text('Cols')),
          Padding(padding: EdgeInsets.all(8.0), child: Text('Four')),
        ],
      ),
      TableRow(
        children: [
          Padding(padding: EdgeInsets.all(8.0), child: Text('R2C1')),
          Padding(padding: EdgeInsets.all(8.0), child: Text('R2C2')),
          Padding(padding: EdgeInsets.all(8.0), child: Text('R2C3')),
          Padding(padding: EdgeInsets.all(8.0), child: Text('R2C4')),
        ],
      ),
    ],
  );
  print('Table with defaultColumnWidth created');

  print('All Table tests completed');

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '=== Table Tests ===',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
        SizedBox(height: 8.0),
        Text('Basic 3x3:', style: TextStyle(fontWeight: FontWeight.bold)),
        tableBasic,
        SizedBox(height: 12.0),
        Text('With border:', style: TextStyle(fontWeight: FontWeight.bold)),
        tableBorder,
        SizedBox(height: 12.0),
        Text(
          'Column widths (Flex/Fixed):',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        tableColumnWidths,
        SizedBox(height: 12.0),
        Text(
          'Vertical alignment (middle):',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        tableVerticalAlign,
        SizedBox(height: 12.0),
        Text('Row decorations:', style: TextStyle(fontWeight: FontWeight.bold)),
        tableDecorated,
        SizedBox(height: 12.0),
        Text(
          'Intrinsic column width:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        tableIntrinsic,
        SizedBox(height: 12.0),
        Text(
          'Symmetric border:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        tableSymmetricBorder,
        SizedBox(height: 12.0),
        Text(
          'Default column width:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        tableDefaultCol,
        SizedBox(height: 16.0),
        Text('Key Points:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• Table uses TableRow children for rows'),
        Text('• columnWidths map overrides per-column sizing'),
        Text(
          '• FlexColumnWidth, FixedColumnWidth, IntrinsicColumnWidth available',
        ),
        Text('• TableBorder.all, TableBorder.symmetric for borders'),
        Text('• defaultVerticalAlignment controls cell alignment'),
        Text('• TableRow decoration styles individual rows'),
      ],
    ),
  );
}
