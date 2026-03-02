// D4rt test script: Tests DataRow, DataColumn, DataCell from Flutter material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DataRow/DataColumn/DataCell test executing');

  // Test DataColumn variations
  final col1 = DataColumn(label: Text('Name'));
  print('DataColumn(label: Name) created');

  final col2 = DataColumn(label: Text('Age'), numeric: true);
  print('DataColumn(label: Age, numeric: true) created');

  final col3 = DataColumn(
    label: Text('Sortable'),
    onSort: (colIndex, ascending) {
      print('sort $colIndex $ascending');
    },
  );
  print('DataColumn(label: Sortable, onSort) created');

  final col4 = DataColumn(label: Text('Action'));
  print('DataColumn(label: Action) created');

  // Test DataRow variations
  final row1 = DataRow(cells: [
    DataCell(Text('John')),
    DataCell(Text('25')),
    DataCell(Text('A')),
    DataCell(Text('View')),
  ]);
  print('DataRow(cells: 4 basic cells) created');

  final row2 = DataRow(
    selected: true,
    cells: [
      DataCell(Text('Jane')),
      DataCell(Text('30')),
      DataCell(Text('B')),
      DataCell(Text('Edit')),
    ],
  );
  print('DataRow(selected: true) created');

  final row3 = DataRow(
    onSelectChanged: (selected) {
      print('selected: $selected');
    },
    cells: [
      DataCell(Text('Bob')),
      DataCell(Text('22')),
      DataCell(Text('C')),
      DataCell(Text('Delete')),
    ],
  );
  print('DataRow(onSelectChanged) created');

  // Test DataCell variations
  final cellSimple = DataCell(Text('Simple'));
  print('DataCell(Text simple) created');

  final cellEditable = DataCell(Text('Editable'), showEditIcon: true);
  print('DataCell(showEditIcon: true) created');

  final cellPlaceholder = DataCell(Text('Placeholder'), placeholder: true);
  print('DataCell(placeholder: true) created');

  final cellOnTap = DataCell(
    Text('Tappable'),
    onTap: () {
      print('cell tapped');
    },
  );
  print('DataCell(onTap) created');

  // Row using the special cells
  final row4 = DataRow(cells: [
    cellSimple,
    cellEditable,
    cellPlaceholder,
    cellOnTap,
  ]);
  print('DataRow(mixed cell types) created');

  // Row with color
  final row5 = DataRow(
    color: WidgetStateProperty.all(Colors.blue.shade50),
    cells: [
      DataCell(Text('Colored')),
      DataCell(Text('42')),
      DataCell(Text('D')),
      DataCell(Text('Colored row')),
    ],
  );
  print('DataRow(color: blue.shade50) created');

  // Build the DataTable with all variations
  final dataTable = DataTable(
    columns: [col1, col2, col3, col4],
    rows: [row1, row2, row3, row4, row5],
  );
  print('DataTable(5 columns, 5 rows) assembled');

  print('DataRow/DataColumn/DataCell test completed');
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Text('DataTable with various DataRow/DataColumn/DataCell variations'),
          ),
          dataTable,
        ],
      ),
    ),
  );
}
