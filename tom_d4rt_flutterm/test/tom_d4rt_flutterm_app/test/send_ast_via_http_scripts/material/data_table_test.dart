// D4rt test script: Tests DataTable, DataRow, DataCell, DataColumn,
// PaginatedDataTable, DataTableSource, DataTableThemeData, SortColumnOrder
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DataTable test executing');

  // ========== DataColumn ==========
  print('--- DataColumn Tests ---');
  final col1 = DataColumn(
    label: Text('Name'),
    numeric: false,
    tooltip: 'Full name',
  );
  print('DataColumn created: numeric=${col1.numeric}');

  final col2 = DataColumn(label: Text('Age'), numeric: true);
  print('DataColumn numeric created');

  final col3 = DataColumn(
    label: Text('Role'),
    onSort: (columnIndex, ascending) {
      print('  Sorting column $columnIndex ascending=$ascending');
    },
  );
  print('DataColumn with onSort created');

  // ========== DataRow ==========
  print('--- DataRow Tests ---');
  final row1 = DataRow(
    cells: [
      DataCell(Text('Alice')),
      DataCell(Text('30')),
      DataCell(Text('Engineer')),
    ],
    selected: false,
    onSelectChanged: (selected) => print('  Row selected: $selected'),
  );
  print('DataRow created: selected=${row1.selected}');

  final row2 = DataRow(
    cells: [
      DataCell(Text('Bob'), showEditIcon: true),
      DataCell(Text('25'), placeholder: true),
      DataCell(
        Text('Designer'),
        onTap: () => print('  Cell tapped'),
        onLongPress: () => print('  Cell long pressed'),
        onDoubleTap: () => print('  Cell double tapped'),
      ),
    ],
    color: WidgetStateProperty.resolveWith<Color?>(
      (states) =>
          states.contains(WidgetState.selected) ? Colors.blue[100] : null,
    ),
  );
  print('DataRow with DataCell options created');

  // ========== DataCell ==========
  print('--- DataCell Tests ---');
  final cell = DataCell(
    Text('Content'),
    showEditIcon: true,
    placeholder: false,
    onTap: () {},
  );
  print('DataCell created: showEditIcon=${cell.showEditIcon}');
  print('  DataCell.empty: ${DataCell.empty}');

  // ========== DataTable ==========
  print('--- DataTable Tests ---');
  final dataTable = DataTable(
    columns: [col1, col2, col3],
    rows: [row1, row2],
    sortColumnIndex: 0,
    sortAscending: true,
    showCheckboxColumn: true,
    showBottomBorder: true,
    headingRowHeight: 56.0,
    dataRowMinHeight: 48.0,
    dataRowMaxHeight: 56.0,
    horizontalMargin: 24.0,
    columnSpacing: 56.0,
    dividerThickness: 1.0,
    headingRowColor: WidgetStateProperty.all(Colors.grey[200]),
    headingTextStyle: TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    dataTextStyle: TextStyle(color: Colors.black87),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(8),
    ),
    checkboxHorizontalMargin: 12.0,
    border: TableBorder.all(color: Colors.grey[300]!),
  );
  print('DataTable created');

  // ========== DataTableThemeData ==========
  print('--- DataTableThemeData Tests ---');
  final dtTheme = DataTableThemeData(
    headingRowHeight: 60.0,
    dataRowMinHeight: 50.0,
    dataRowMaxHeight: 60.0,
    horizontalMargin: 24.0,
    columnSpacing: 56.0,
    dividerThickness: 1.0,
    headingRowColor: WidgetStateProperty.all(Colors.blue[50]),
    headingTextStyle: TextStyle(fontWeight: FontWeight.bold),
    dataTextStyle: TextStyle(fontSize: 14),
  );
  print('DataTableThemeData created');
  print('  headingRowHeight: ${dtTheme.headingRowHeight}');

  // ========== PaginatedDataTable concepts ==========
  print('--- PaginatedDataTable Tests ---');
  final paginatedTable = PaginatedDataTable(
    header: Text('Employees'),
    columns: [col1, col2, col3],
    source: TestDataSource(),
    rowsPerPage: 5,
    availableRowsPerPage: [5, 10, 20],
    onPageChanged: (page) => print('  Page: $page'),
    sortColumnIndex: 0,
    sortAscending: true,
    showCheckboxColumn: true,
    showFirstLastButtons: true,
    initialFirstRowIndex: 0,
  );
  print('PaginatedDataTable created');

  print('All data table tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [dataTable, SizedBox(height: 16), paginatedTable],
        ),
      ),
    ),
  );
}

class TestDataSource extends DataTableSource {
  final _data = List.generate(50, (i) => ['User $i', '${20 + i}', 'Role $i']);

  @override
  DataRow? getRow(int index) {
    if (index >= _data.length) return null;
    final row = _data[index];
    return DataRow(
      cells: [
        DataCell(Text(row[0])),
        DataCell(Text(row[1])),
        DataCell(Text(row[2])),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _data.length;

  @override
  int get selectedRowCount => 0;
}
