import 'package:flutter/material.dart';

/// Deep visual demo for DataTable - a Material data table widget.
/// Shows column headers, rows, and sorting capabilities.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('DataTable Demo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: DataTable(
          columns: const [
            DataColumn(label: Text('Name', style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text('Age', style: TextStyle(fontWeight: FontWeight.bold)), numeric: true),
            DataColumn(label: Text('Role', style: TextStyle(fontWeight: FontWeight.bold))),
          ],
          rows: const [
            DataRow(cells: [DataCell(Text('Alice')), DataCell(Text('28')), DataCell(Text('Engineer'))]),
            DataRow(cells: [DataCell(Text('Bob')), DataCell(Text('34')), DataCell(Text('Designer'))]),
            DataRow(cells: [DataCell(Text('Carol')), DataCell(Text('22')), DataCell(Text('Manager'))]),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Supports sorting, selection, and custom cells', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}
