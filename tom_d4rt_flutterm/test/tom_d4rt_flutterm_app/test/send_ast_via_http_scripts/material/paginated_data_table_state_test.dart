import 'package:flutter/material.dart';

/// Deep visual demo for PaginatedDataTable state.
/// Manages pagination and selection state.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('PaginatedDataTable State', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        width: 220,
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)]),
        child: Column(
          children: [
            Table(
              columnWidths: const {0: FixedColumnWidth(30), 1: FlexColumnWidth(), 2: FixedColumnWidth(50)},
              children: [
                TableRow(decoration: BoxDecoration(color: Colors.grey.shade100), children: [
                  const Padding(padding: EdgeInsets.all(8), child: Icon(Icons.check_box_outline_blank, size: 14)),
                  const Padding(padding: EdgeInsets.all(8), child: Text('Name', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10))),
                  const Padding(padding: EdgeInsets.all(8), child: Text('Age', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10))),
                ]),
                const TableRow(children: [Padding(padding: EdgeInsets.all(8), child: Icon(Icons.check_box, size: 14, color: Colors.blue)), Padding(padding: EdgeInsets.all(8), child: Text('Alice', style: TextStyle(fontSize: 10))), Padding(padding: EdgeInsets.all(8), child: Text('28', style: TextStyle(fontSize: 10)))]),
                const TableRow(children: [Padding(padding: EdgeInsets.all(8), child: Icon(Icons.check_box_outline_blank, size: 14)), Padding(padding: EdgeInsets.all(8), child: Text('Bob', style: TextStyle(fontSize: 10))), Padding(padding: EdgeInsets.all(8), child: Text('34', style: TextStyle(fontSize: 10)))]),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text('1-10 of 50', style: TextStyle(fontSize: 9)),
                  const SizedBox(width: 8),
                  Icon(Icons.chevron_left, size: 16, color: Colors.grey.shade400),
                  const Icon(Icons.chevron_right, size: 16),
                ],
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('rowsPerPage, sortColumnIndex', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}
