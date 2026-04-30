// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

class _DemoDataSource extends DataTableSource {
  @override
  DataRow? getRow(int index) {
    if (index >= rowCount) return null;
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text('Row $index')),
        DataCell(Text('Value ${index * 10}')),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => 5;

  @override
  int get selectedRowCount => 0;
}

dynamic build(BuildContext context) {
  print('=== PaginatedDataTableState Deep Demo (Harness-Safe) ===');

  return MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640, maxHeight: 420),
            child: SingleChildScrollView(
              child: PaginatedDataTable(
                header: const Text('Paginated Table'),
                columns: const [
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('Value')),
                ],
                source: _DemoDataSource(),
                rowsPerPage: 5,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
